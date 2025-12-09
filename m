Received: from localhost.localdomain (unknown [147.136.157.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF1A433AD
	for <linux-rt-devel@lists.linux.dev>; Tue,  9 Dec 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287065; cv=none; b=Xu3unatNBub9i6IawiWKd1IyIrcC5Y7WNvRCt7mbR3l2PjJTK61AoXoAvsI77859CxHPv0k0FjqYoqiD/7p3OKbdd1NkLGRJlGXMzkGqLcAnQQGD732uARFm2cF3QzNWlDvBkYVZvI0qFE2oxuLiJDUgiZ9Rq3ygAL8YX74HAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287065; c=relaxed/simple;
	bh=I53AOfQStrCzyp+2inScgIsW7CxbMSuUYLAgLGRitks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Akla/nEhdXVvh15PD5QJ68yzV79i5VmGm0L1/9xO+ECvrQOtNuPfcbnrOorZJe9mRwWwOWIsFwNYEY+CCl21YeOPzAr6Hs8l8l3PCnASgAD6f/Y3MR0PHlruyohOSYO8qgjDoCbAdG9bQ6SiTSxzm9MSS69Xb9A3FOJ333WhoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 6D6478B2A3E; Tue,  9 Dec 2025 20:48:07 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net-next v1] ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT
Date: Tue,  9 Dec 2025 20:48:04 +0800
Message-ID: <20251209124805.379112-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On PREEMPT_RT kernels, after rt6_get_pcpu_route() returns NULL, the
current task can be preempted. Another task running on the same CPU
may then execute rt6_make_pcpu_route() and successfully install a
pcpu_rt entry. When the first task resumes execution, its cmpxchg()
in rt6_make_pcpu_route() will fail because rt6i_pcpu is no longer
NULL, triggering the BUG_ON(prev). It's easy to reproduce it by adding
mdelay() after rt6_get_pcpu_route().

Using preempt_disable/enable is not appropriate here because
ip6_rt_pcpu_alloc() may sleep.

Fix this by:
1. Adding migrate_disable/enable to ensure consistent per-cpu pointer
   access across potential preemption points.
2. Removing the BUG_ON and instead handling the race gracefully by
   freeing our allocation and returning the existing pcpu_rt when
   cmpxchg() fails.

Link: https://syzkaller.appspot.com/bug?extid=9b35e9bc0951140d13e6
Fixes: 951f788a80ff ("ipv6: fix a BUG in rt6_get_pcpu_route()")
Reported-by: syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6918cd88.050a0220.1c914e.0045.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/route.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index aee6a10b112a..44c34baad0e4 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1470,7 +1470,16 @@ static struct rt6_info *rt6_make_pcpu_route(struct net *net,
 
 	p = this_cpu_ptr(res->nh->rt6i_pcpu);
 	prev = cmpxchg(p, NULL, pcpu_rt);
-	BUG_ON(prev);
+	if (unlikely(prev)) {
+		/*
+		 * Another task on this CPU already installed a pcpu_rt.
+		 * This can happen on PREEMPT_RT where preemption is possible.
+		 * Free our allocation and return the existing one.
+		 */
+		dst_dev_put(&pcpu_rt->dst);
+		dst_release(&pcpu_rt->dst);
+		return prev;
+	}
 
 	if (res->f6i->fib6_destroying) {
 		struct fib6_info *from;
@@ -2299,11 +2308,13 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 	} else {
 		/* Get a percpu copy */
 		local_bh_disable();
+		migrate_disable();
 		rt = rt6_get_pcpu_route(&res);
 
 		if (!rt)
 			rt = rt6_make_pcpu_route(net, &res);
 
+		migrate_enable();
 		local_bh_enable();
 	}
 out:
-- 
2.43.0

