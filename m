Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED72DE702
	for <linux-rt-devel@lists.linux.dev>; Thu,  1 Oct 2026 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870566; cv=none; b=RQOXz+uSDS2p0UC0CeMCekoq6QzPL3ZY8wlM2VneTqcBCRXBZBlTtwQLTQEXf/s9iFX7LH2vM/yd4K3Sd2NQz0973SJShjyoTA97OXZGHSbK0oO+ypOOlYj0wefQpWUyv/+mExEfOSQ79D8t3JTpOwSfrASZDr6scauq5T58BVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870566; c=relaxed/simple;
	bh=8SEQ5LEwZWMx8fIG82dPeZqqz2OtyFESARM0SeMil1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/uWFNi92AnGdFA109jQQ+PVXhvXmLtn064BDY1xkho5SrwaoyRhhsVOJITdzO0NMSUv7/ENEy3t9735dYd5ZP1r8mHUjixNboGkNo7nF+tsgfx3aCmY0H/gtiGeGATtdUXTHYtZ0wvhueB3Iw1Hu2uYoX9pM1nTOjnEZNf68hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rnR8PEGL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ky3oivQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rnR8PEGL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ky3oivQ"
Date: Thu, 1 Oct 2026 18:02:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790870560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiHVpFyNR2pOIXjsmsCrGQ6THqpDTioyZ8jXsUY1wOs=;
	b=rnR8PEGLqutBHG/3yvWn65AZO3WXNjHHwj7UZiqgL5MzHMtjayrrwh1EmluaI4IJ8iKJex
	7xavQr0nnFTOF6d/n0kSS4yuaZr97IY9VDCzSYdW1Ctf5dzwsRkT8g90+sdd9KdxCC/iYZ
	1agPWkVKkizScTvtZVFL4JpDzJlWDgIbEXXhPbYB9qetJ0idT91uaVYYMjOqHyV5xIlKUZ
	EUCXJ4sAjRvc+6dPS2scKFFn/JQyB29e5qtyy7AH9B0TQ8vkJhP2eZGlxOO/IDH7UUuR0O
	Jf/XbxDyF6tPEMYoNwGAaqBgZHM9zjD6ZvI92gX6qrhNJ4SgCi8H+niINY2Z8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790870560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiHVpFyNR2pOIXjsmsCrGQ6THqpDTioyZ8jXsUY1wOs=;
	b=0ky3oivQi/n/kuMoQWWLSroLRMMz5vspW7kIB39ArBZeai9RfhCIuKufpaF37piVZxaHD8
	oSSZ34iLoI3bQNBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Nam Cao <namcao@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5] af_unix: Do not wait for garbage collector
 in sendmsg()
Message-ID: <20261001160239.j1stzfx6@linutronix.de>
References: <20260930162457.4ajVJ-Qa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260930162457.4ajVJ-Qa@linutronix.de>

On 2026-09-30 18:24:59 [+0200], To netdev@vger.kernel.org wrote:
> I played with it a bit. The first scheduling of the GC via
> unix_schedule_gc() does not wait for its completion because it requires

I have a few other data points from my play time:
The "on the flight limit" is the FD limit. This one can be increased to
the hardlimit by an ordinary user, so
| $ ulimit -n 524288

next based on [0] socketpair() + sendmsg() in a loop until the FD limit
is hit, and sleep.
Before start of the program, "free -h" reported for used 667Mi. After it
was done allocating (and not terminated) 3,1Gi.

I added a few trace_printk()s:

--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -614,6 +614,7 @@ static void unix_gc(struct work_struct *work)
 	WRITE_ONCE(gc_in_progress, true);
=20
 	spin_lock(&unix_gc_lock);
+	trace_printk("Start\n");
=20
 	if (unix_graph_state =3D=3D UNIX_GRAPH_NOT_CYCLIC) {
 		spin_unlock(&unix_gc_lock);
@@ -627,6 +628,7 @@ static void unix_gc(struct work_struct *work)
 	else
 		unix_walk_scc(&hitlist);
=20
+	trace_printk("End\n");
 	spin_unlock(&unix_gc_lock);
=20
 	skb_queue_walk(&hitlist, skb) {
@@ -634,7 +636,9 @@ static void unix_gc(struct work_struct *work)
 			UNIXCB(skb).fp->dead =3D true;
 	}
=20
+	trace_printk("Purge %d\n", hitlist.qlen);
 	__skb_queue_purge_reason(&hitlist, SKB_DROP_REASON_SOCKET_CLOSE);
+	trace_printk("Purged\n");
 skip_gc:
 	WRITE_ONCE(gc_in_progress, false);
 }

and after the program was done allocating:

|  kworker/u150:0-231     [021] ...1.  1046.960384: unix_gc: Start
|  kworker/u150:0-231     [021] .B.1.  1046.991199: unix_gc: End
|  kworker/u150:0-231     [021] .....  1046.991206: unix_gc: Purge 0
|  kworker/u150:0-231     [021] .....  1046.991206: unix_gc: Purged

~30ms to iterate over the lists, nothing to purge since everything is in
use. This is what I mean, that flush_work() slows things down but does
help. A deferred work would make sense just to throttle that gc.

Now I trigged the OOM killer and saw:
|  Tasks state (memory values in pages):
|  [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgta=
bles_bytes swapents oom_score_adj name
|  [   2549]  1001  2549      643      431       24      407         0    4=
5056        0             0 unix-fd-tc
|  [   2365]  1001  2365     2172     1177       93     1084         0    5=
3248        0           200 dbus-daemon
|  oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),cpuset=3D/,mems_=
allowed=3D0-1,global_oom,task_memcg=3D/user.slice/user-1001.slice/user@1001=
=2Eservice/session.slice/dbus.service,task=3Ddbus-daemon,pid=3D2365,uid=3D1=
001
|  Out of memory: Killed process 2365 (dbus-daemon) total-vm:8688kB, anon-r=
ss:372kB, file-rss:4336kB, shmem-rss:0kB, UID:1001 pgtables:52kB oom_score_=
adj:200

That "unix-fd-tc" program looks very thin (given that >2GiB are in use).
But that is probably okay. I guess that the skbs are just accounted on
the socket and I don't hit any limits here (maybe I should?).

Now, killing that program, the memory remains occupied. A few seconds
later a random close triggered the GC and then

|  kworker/u143:2-2451    [030] ...1.  1066.959556: unix_gc: Start
|  kworker/u143:2-2451    [030] ...1.  1066.989993: unix_gc: End
|  kworker/u143:2-2451    [030] .....  1067.057696: unix_gc: Purge 524289
|  kworker/u143:2-2451    [030] .l...  1067.705185: unix_gc: Purged

again, 30ms to iterate and then free 524289 items took a bit but it was
preemptible. After that `used' dropped back to 675Mi.

I would argue that too_many_unix_fds() could use UNIX_INFLIGHT_SANE_USER
or 2 * UNIX_INFLIGHT_SANE_USER as a hard limit. Having 1000 fd inflight
for a user sounds insane high amount but there might be legitime
use case=E2=80=A6

[0] https://lore.kernel.org/all/ba4ed2717e5225b7b77ef928fb97ee5544632811.17=
84712370.git.namcao@linutronix.de/

Sebastian
