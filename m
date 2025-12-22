Received: from localhost.localdomain (unknown [147.136.157.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2192D0C80
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Dec 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407395; cv=none; b=cUJI1e8RCAK9VIJezA9s73CzQFoZlai0q6HiKMxXK1UakyG+8UYVlPn1OtV2V0TjUQrFRHfdL3+/R52d2xrRMGlueTJWJYfvFiWBTnjsykvxMfbUY+2dTxV+zOdlZBTsWAjiCyD2GDqupWyKSuRX+6vMtGu46r+cCN7N7vwXw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407395; c=relaxed/simple;
	bh=TluKvSVXQaUpIlGiDSi6wCc26Oj5cCdSYZoxaj2Vw1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMC1wdQKRWdoS4mK94nXvE2CoV/an3OHMN/aYV6WQINqckJvN16Cmi803YGuR8LhKQ/sRm0c5BkGGkaXd6XfAZNXMXeLnM4XXZVdN51fM7eDl+0f2iRNLrC8r3kZbj11zJhflyhduKwGdE19qMG0KMxVbKwj6G2706n6KmxOdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 3F9218AA381; Mon, 22 Dec 2025 20:43:04 +0800 (+08)
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
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v3] ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT
Date: Mon, 22 Dec 2025 20:42:19 +0800
Message-ID: <20251222124220.261109-1-jiayuan.chen@linux.dev>
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

Fix this by handling the cmpxchg() failure gracefully on PREEMPT_RT:
free our allocation and return the existing pcpu_rt installed by
another task. The BUG_ON is retained for non-PREEMPT_RT kernels where
such races should not occur.

Link: https://syzkaller.appspot.com/bug?extid=9b35e9bc0951140d13e6
Fixes: 8b1c04acad08 ("softirq: Make softirq control and processing RT aware")
Reported-by: syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6918cd88.050a0220.1c914e.0045.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
v2 -> v3: Use correct Fixes tag.
          https://lore.kernel.org/netdev/20251219025140.77695-1-jiayuan.chen@linux.dev/
v1 -> v2: Drop migrate_{disable, enabled} suggested by Steven and Paolo.
          https://lore.kernel.org/all/20251209124805.379112-1-jiayuan.chen@linux.dev/T/
---
 net/ipv6/route.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index aee6a10b112a..9e7afda7cba2 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1470,7 +1470,18 @@ static struct rt6_info *rt6_make_pcpu_route(struct net *net,
 
 	p = this_cpu_ptr(res->nh->rt6i_pcpu);
 	prev = cmpxchg(p, NULL, pcpu_rt);
-	BUG_ON(prev);
+	if (unlikely(prev)) {
+		/*
+		 * Another task on this CPU already installed a pcpu_rt.
+		 * This can happen on PREEMPT_RT where preemption is possible.
+		 * Free our allocation and return the existing one.
+		 */
+		BUG_ON(!IS_ENABLED(CONFIG_PREEMPT_RT));
+
+		dst_dev_put(&pcpu_rt->dst);
+		dst_release(&pcpu_rt->dst);
+		return prev;
+	}
 
 	if (res->f6i->fib6_destroying) {
 		struct fib6_info *from;
-- 
2.43.0

