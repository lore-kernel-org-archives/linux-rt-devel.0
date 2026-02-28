Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA242EEA0
	for <linux-rt-devel@lists.linux.dev>; Sat, 28 Feb 2026 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772277214; cv=none; b=REjhZ0wi3AMKMqpKlIBJ4Pz1AsKiU55UXklU6oVKbym+F8TAAZw4U6YtXx2mykGBZvx9xRktJt/hvtPHeEbvZEuJ1+m8A/K/I9OT8N1h+4I7jrf+qPVlvP9kyXo9gpK3VwiUDc4Yk1tnvn2i6KVfV8tozwZfKr3aJ8+ztrsK3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772277214; c=relaxed/simple;
	bh=KEtfPjmed9vc8UYUJTd5WRO0PKUsvItWzznuXA+LWAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9soJd+x3SMSJjGXDvS3Rsfw333OOx1TcPs4oFZWrQzU6+jFIIDdOs/8rHDpIcJJuj0i6O7CiQwqnmeIGj5V9vkeMXYa6AothTS8ojMgfw2hYj2gqwepUPt7WxEtM9XrLHCd+9+b6udgJNEw16fdbEQ0RwA1QgxNV1x2PymB9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jYJ1YA/D; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jYJ1YA/D"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772277208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Yg7j2EaokeIvhOnMiy2qGul7Iq/hLXN+CkZ2bmenGc=;
	b=jYJ1YA/DLC21QSpt5yFgGbUCKT5Kl7xSe7ek3iek8flsxo51hy6UcglF27f331wQSCPG/U
	xW92eKHrdnN0PrOB6Zz4LExpsYkPUJklV/rLPQ9dT2QLAlQtYVKxZ7Mv8e31W4cWTCk/4w
	5TNFNeDT+ZHeixhJxN6Qf157D+2HuYw=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net-next v2] net: fix sock compilation error under CONFIG_PREEMPT_RT
Date: Sat, 28 Feb 2026 19:13:18 +0800
Message-ID: <20260228111319.79506-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

When CONFIG_PREEMPT_RT is enabled, __SPIN_LOCK_UNLOCKED() expands to a
brace-enclosed initializer rather than a compound literal, which cannot
be used in assignment expressions. This causes a build failure:

  net/core/sock.c:3787:29: error: expected expression before '{' token
   3787 |                 tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);

Use declaration-with-initializer instead of assignment, consistent with
how __SPIN_LOCK_UNLOCKED() is used elsewhere in the kernel (e.g.
DEFINE_SPINLOCK).

Fixes: 5151ec54f586 ("net: use try_cmpxchg() in lock_sock_nested()")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/core/sock.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9d841975a7a1..fba4d5b8553c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3782,12 +3782,15 @@ void noinline lock_sock_nested(struct sock *sk, int subclass)
 	might_sleep();
 #ifdef CONFIG_64BIT
 	if (sizeof(struct slock_owned) == sizeof(long)) {
-		socket_lock_t tmp, old;
+		socket_lock_t tmp = {
+			.slock = __SPIN_LOCK_UNLOCKED(tmp.slock),
+			.owned = 1,
+		};
+		socket_lock_t old = {
+			.slock = __SPIN_LOCK_UNLOCKED(old.slock),
+			.owned = 0,
+		};
 
-		tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);
-		tmp.owned = 1;
-		old.slock = __SPIN_LOCK_UNLOCKED(old.slock);
-		old.owned = 0;
 		if (likely(try_cmpxchg(&sk->sk_lock.combined,
 				       &old.combined, tmp.combined)))
 			return;
-- 
2.43.0

