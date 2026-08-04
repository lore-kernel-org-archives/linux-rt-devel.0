Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907E38F653
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Aug 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825993; cv=none; b=oJ7buY4c0c6hdNRCwLAS1XLa3FrzniyId5LJ0xHvoxLQQtfvah/0R4pZKWmhcDw0Hl64PE/T22l65zPfj3dhRZkb0pemn4u+nUUNoVYM+6Uep0sZ4AmPRCduXnAZmjElTYGKAO3IXoSRXwI3bwWhVNsjooOurnnQw57OwZZMM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825993; c=relaxed/simple;
	bh=/XIb5TzMkZrBHkgexKTZCf6MhryZ7eKYOFf9I5Sh6SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTUzMHy9jp6swuv1zUfElsPsqLM3uj+nLxfYmLrx04dqPCzpJ36XRaKD+1vcgIJKRYIqUKv2o8L1ntORZ80KWEKW2pepcZXDfrre/vEHX+jNChsT8dvyy7xqj2fu6x8Uhi4rcJxB6KojIw/1ms7KjQfPJzJT5sl3VeYTh6/X+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RRjuIAkY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4JXqGXjv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RRjuIAkY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4JXqGXjv"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785825990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aBPzwOcpvwMmkPdr3pNjwZh7/IAHAZbuGs3fraxD3s=;
	b=RRjuIAkYj8k0Lq1/PZQMyf+Zi/MQlLknQpS9b5iqxgTWFaQtHvKc80qznnKCl+GROTB9Wl
	0A1wK/KPt+J4dnw/JRSBmXRqLTgs7bDof8MguWswyAa8bG3hd4LA9o2rzWHkMYczGePMEd
	b1l54SuIi3JLnBuUOqBTzpSHcoP5t9hpLILDQxxE7j5aejHl4cUQGqm9fL9kK0zeFS8Jcm
	8QAwLc/X70aJa6BhBV5aAYQVSShPuEVv5i1mQwDsqzYYH6AsEO12aXd2B9eqJ/+eD7dRS0
	hJc8kQI5KBlsLBu2OKOpC8tOPUUHO6iwZ6NK9eHrZCBvBOZkApF2mChkBO7+8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785825990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aBPzwOcpvwMmkPdr3pNjwZh7/IAHAZbuGs3fraxD3s=;
	b=4JXqGXjv9RZqI+EP7xVJlA6qFWbCQXaY7+8EtR33ZHah/RoLnQ6BS2cMLMpMeOwQ69+/Q/
	ljDWeXZCJbRoFMDA==
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v4 1/1] af_unix: Do not wait for garbage collector in sendmsg()
Date: Tue,  4 Aug 2026 08:46:16 +0200
Message-ID: <bc759ceba26d6e20fab3bcf7333ee7e6246696b6.1785824313.git.namcao@linutronix.de>
In-Reply-To: <cover.1785824313.git.namcao@linutronix.de>
References: <cover.1785824313.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AF_UNIX sockets' sendmsg() schedules and blocks on the garbage collector if
user has too many inflight unix sockets and there is cyclic reference in
the system. This causes real-time issues, as cyclic reference can be
created by any task in the system, and high priority tasks who do need to
send lots of AF_UNIX sockets get blocked by the garbage collector which
runs as workqueue, causing a priority inversion scenario.

The reason for blocking on garbage collector goes back to 2008, when
it was reported that "Local/unprivileged users can cause soft lockups
and take out system processes by triggering the OOM killer":
https://bugzilla.redhat.com/show_bug.cgi?id=3D470201

The soft lockup was because a process can keep queueing AF_UNIX sockets to
another process that is exiting. Back in 2008, the garbage collector was
run synchronously by the exiting process, therefore keep queueing AF_UNIX
sockets blocks that process from exiting.

The solution to that issue was forcing sendmsg() to wait for ongoing
garbage collector.

The OOM killer issue was brought up again in 2010:
https://lore.kernel.org/lkml/AANLkTi=3DQ967xpX0KLMwX-=3D_4_1AKO5wjHEuJ1TrNj=
Cj9@mail.gmail.com/

To resolve that report, beside blocking on the garbage collector, sendmsg()
also schedules the garbage collector if the number of inflight AF_UNIX
sockets in the system is too high.

Then in 2015, once again, the OOM killer problem was brought up:
https://lore.kernel.org/lkml/20151228141435.GA13351@1wt.eu/

That time, the issue was resolved by disallowing a user from having more
inflight AF_UNIX sockets than their RLIMIT_NOFILE. That was done by commit
712f4aad406b ("unix: properly account for FDs passed over unix sockets")
and commit 415e3d3e90ce ("unix: correctly track in-flight fds in sending
process user_struct").

Now, sendmsg() does not have to block on the garbage collector anymore,
because:

  - The OOM killer issue has already been addressed by checking
    RLIMIT_NOFILE.

  - The soft lockup issue is no longer relevant, because the garbage
    collector now runs asynchronously since commit d9f21b361333 ("af_unix:
    Try to run GC async.")

Therefore, remove that to prevent priority inversion. Running all the
reproducers from the mentioned bug reports after this patch, no problem is
observed.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 net/unix/garbage.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0783555e2526..e0702171d246 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -653,7 +653,4 @@ void unix_schedule_gc(struct user_struct *user)
=20
 	if (!READ_ONCE(gc_in_progress))
 		queue_work(system_dfl_wq, &unix_gc_work);
-
-	if (user && READ_ONCE(unix_graph_cyclic_sccs))
-		flush_work(&unix_gc_work);
 }
--=20
2.47.3

