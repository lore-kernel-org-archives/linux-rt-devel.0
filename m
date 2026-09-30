Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09844D37B0
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785509; cv=none; b=o6A1TE3esmLjAHOBmUxDohcD07fnkSlWHTt8j1Goe8oLWvEJqeEpwbtqRPPgl3Et88BLavWQ3GuFpw7jXFG5vH3rSbOdYdrIuyZ0yUA3ashhmh5l75b7ysU5joEmj1xlkeQgJ35nmY1tJw5sOhbjWEWO0Uke2i+MXeelEGOFyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785509; c=relaxed/simple;
	bh=3g+W+m1mL29e+VUNcB3FYt0dHoj5UvMiARshZ7d/7n8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mB39taAsp9tdWqdJZx2CE8eCNJA+UWYSTPi4OjZ7ciHDL9nvBJuPS1uwPbBV+rufqETLjXmhw0jkWbrL4w4BJIlyiGCO5Fwv6pj/Y8hoLymV3EaUbULvnHV0G3jD3h/fsG9EKmiRtXz+ZL6Tteq5QRnW9/JNdP9CBCUoorHNsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xDUB9RUa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z3GcZNu1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xDUB9RUa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z3GcZNu1"
Date: Wed, 30 Sep 2026 18:24:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790785499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NVl799tGpAdBq2gHlTTsil+zZWdNVRsyXZjPKgSWPdo=;
	b=xDUB9RUaCkPREzXOuASh38kjrG99IoEsa0O/rwSMZrCbpOZQPkUZDCl2cE3lgXZCfCs4cb
	o3NPftRbTAmURo16tfTt46MSOuUASOpzbaHj8EvkBHaTt/kgXZiGjRoikUTCWCC0g5ydXl
	VIk22yx6yKh29TkGAlp5HRS78gzmluIQ7Y/0ur47VwJdlRz99MiEAKVyieZUP4qqlPUOm/
	ec9vsAHaQDeiJ1GOHn4+pPlo0jzE/VrvQauGbnCktWjrOrs+O8h4BWN0XQcGczY54NE5/w
	+P3piQc8P1gFhTuJZ7pC3COaxbOR1lqKyZW9pK8o1NkIycEz2f+2M/j98zkmjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790785499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NVl799tGpAdBq2gHlTTsil+zZWdNVRsyXZjPKgSWPdo=;
	b=z3GcZNu1hBwQjvN7QovFsWfNCetoBKV4DVlwSdDDNr3LquoxnCLux62QnV55+RJZ3trzEm
	savLk/1d6hzIPbCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Nam Cao <namcao@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5] af_unix: Do not wait for garbage collector in
 sendmsg()
Message-ID: <20260930162457.4ajVJ-Qa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Nam Cao <namcao@linutronix.de>

AF_UNIX sockets' sendmsg() schedules and blocks on the garbage collector
if the user sent a file descriptor and the user has too many inflight
unix sockets and there is a cyclic reference in the system. The user
needs to have more "unix_inflight" FDs than UNIX_INFLIGHT_SANE_USER
(2024) in order to wait for the garbage collector to complete.

The reason for blocking on garbage collector goes back to 2008, when
it was reported that "Local/unprivileged users can cause soft lockups
and take out system processes by triggering the OOM killer":
https://bugzilla.redhat.com/show_bug.cgi?id=3D470201

The soft lockup was because a process can keep queuing AF_UNIX sockets to
another process that is exiting. Back in 2008, the garbage collector was
run synchronously by the exiting process, therefore keep queuing AF_UNIX
sockets blocks that process from exiting.

The solution to that issue was forcing sendmsg() to wait for ongoing
garbage collector, in commit 5f23b734963ec ("net: Fix soft lockups/OOM
issues w/ unix garbage collector").

The OOM killer issue was brought up again in 2010:
https://lore.kernel.org/lkml/AANLkTi=3DQ967xpX0KLMwX-=3D_4_1AKO5wjHEuJ1TrNj=
Cj9@mail.gmail.com/

To resolve that report, beside blocking on the garbage collector, sendmsg()
also schedules the garbage collector if the number of inflight FDs
in the system is too high. This was done in commit 9915672d41273
("af_unix: limit unix_tot_inflight").

Then in 2015, once again, the OOM killer problem was brought up:
https://lore.kernel.org/lkml/20151228141435.GA13351@1wt.eu/

That time, the issue was resolved by disallowing a user from having more
inflight AF_UNIX sockets than their RLIMIT_NOFILE. That was done by commit
712f4aad406b ("unix: properly account for FDs passed over unix sockets")
and commit 415e3d3e90ce ("unix: correctly track in-flight fds in sending
process user_struct").

Now, sendmsg() does not have to block on the garbage collector anymore,
because:

  - The soft lockup issue is no longer relevant, because the garbage
    collector now runs asynchronously since commit d9f21b361333 ("af_unix:
    Try to run GC async."). Collecting happens with disabled preemption
    but the free happens in preemptible context.

  - The OOM killer issue is addressed by ensuring no more than
    RLIMIT_NOFILE FDs can be inflight.

  - A privileged user can bypass the RLIMIT_NOFILE limit. Should the
    user continue to enqueue FDs then waiting on GC does only slow down
    the user. It does not avoid the OOM if the GC does not find and dead
    FDs which can be cleaned up.

Therefore, don't penalise the user by blocking on the GC. No problems
were observed after running the reproducers from the mentioned bug
reports.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

I played with it a bit. The first scheduling of the GC via
unix_schedule_gc() does not wait for its completion because it requires
unix_graph_cyclic_sccs to be set which is only the case after GC run
completed. Once this occurred, the subsequent invocation will block.
If there are no dead sockets then blocking was all for nothing but this
is not known in advance.
The ordinary user should be rate limited by the RLIMIT_NOFILE and the
privileged one can OOM anyway.
Usually the kworker should get enough CPU time to clean up the dead
sockets. I tried to hook it up to the shrinker, so that there is one
synchronous GC invocation in the OOM case, but this hardly helped. It
can not be estimated if it will free something so most of the time it
was pointless.
If the task exists without consuming the passed FDs then they remain and
can only be cleaned up by the GC. The GC is triggered enough by random
tasks on close() so it does not seems necessary to have a shrinker or
another hook to enforce this at random intervals.

v4=E2=80=A6v5: https://lore.kernel.org/all/cover.1785824313.git.namcao@linu=
tronix.de/
  - Reworded the commit message a bit
  - Also removed the comment about penalty

v4:=20
  - Downsize this series to just removing the priority
    inversion. Garbage collector scheduling should still be cleaned up,
    but that is non-trivial and I do not want that to stand in the way
    of this simple fix.

v3:
  - Move unix_schedule_gc() to be after exit_task_work()

v2:
  - Add patch [1/3]
  - Rebase the other two patches onto the new patch
  - Change commit message to be more precise

 net/unix/garbage.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index da774f56ca648..e4c6f645fbd0f 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -648,16 +648,10 @@ void unix_schedule_gc(struct user_struct *user)
 	if (READ_ONCE(unix_graph_state) =3D=3D UNIX_GRAPH_NOT_CYCLIC)
 		return;
=20
-	/* Penalise users who want to send AF_UNIX sockets
-	 * but whose sockets have not been received yet.
-	 */
 	if (user &&
 	    READ_ONCE(user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
 		return;
=20
 	if (!READ_ONCE(gc_in_progress))
 		queue_work(system_dfl_wq, &unix_gc_work);
-
-	if (user && READ_ONCE(unix_graph_cyclic_sccs))
-		flush_work(&unix_gc_work);
 }
--=20
2.55.0

