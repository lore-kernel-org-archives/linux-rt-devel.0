Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3083BE64D
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Mar 2026 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309952; cv=none; b=dVoCEaOZG7aD7X/7bxbgX2fgZyqkGv7UQyzAnO3gdiDT4TXQZ9yRVdNJMQaKgFOob0MySVvcIs/5+JajlSu4JKrYexRrcPR/uxqWdfH8ztGEiqNiVBMmCPNETvB1YjuvDraO6DcRSb9l+6AQ0grUKXcPtoUirP9IOOuFFBKji/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309952; c=relaxed/simple;
	bh=JdjiNfm9ZmMpXtcxWwORwAQzwPs4sCI7XBFp338zITo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKBSDaWcUDu7Eps/0WPXdF7bVNefXdQ8EcMgp8UvUnxmx82VSWbfDlcs52KdklE1+ZOai5P3jbPpTtsKtqJxGbAOuOQj5x15W0ToJVKiXrRojyx37imvJ72DtLHYNDRikAbPwl31GPti8XUjxekUiQpipZWdcd3UlDbvVVnSInA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aLYYFavz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJ1zSOnC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aLYYFavz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJ1zSOnC"
Date: Thu, 12 Mar 2026 11:05:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773309948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdjiNfm9ZmMpXtcxWwORwAQzwPs4sCI7XBFp338zITo=;
	b=aLYYFavzpzA7/dyYPzr6N1yPLlGfVPym5vlEDoyXOe7htpUrQhqKp+wQkVndeODl8Ge958
	7r8bIKI6ZymnLeFnlf86CtVYdawe3/3cOcYhdIcGjHdmGO7h18LpwgdAL95LriWgrkqRgK
	7OGyfaw4SxLPQUVm3770jXLsqtxAwOI2wPE7/D8hTzHkzAzAErozck1ulgSo2IW2LQ+lDC
	abaZy6IYQLGmJ9EawEWNdR3x7HQnJBNRTu8luqRoFew4KxvA51854wqSotViQDATvG0HLj
	NZFAd1EGrtkEBfxUCgcC8k3ZkpphjOzCK6O7PhxBGpLDh+/3PCI+EWmtVLryPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773309948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdjiNfm9ZmMpXtcxWwORwAQzwPs4sCI7XBFp338zITo=;
	b=OJ1zSOnCn+DcAbAdIFKDr/IzmWYkIL4H+iZOLGCuef5YVtqn0H1hji6miz1zbX84N2dT2i
	JrkSBzSzVOevkgDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: boqun@kernel.org, clrkwllms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH] softirq: WARN_ON !preemptible() not check softirq cnt in
 bh disable on RT
Message-ID: <20260312100546.jjvRquDg@linutronix.de>
References: <20260311160910.yoU_8pQ7@linutronix.de>
 <20260311170115.279041-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260311170115.279041-1-jackzxcui1989@163.com>

On 2026-03-12 01:01:15 [+0800], Xin Zhao wrote:
> hi, Sebastian
Hi,

> As you said, the current implementation is good enough. :)
> If you think it=E2=80=99s appropriate to change it to (system_state !=3D =
SYSTEM_BOOTING), you can make
> that change later when you git rid of CONFIG_PREEMPT_RT_NEEDS_BH_LOCK. :)

If I get rid of CONFIG_PREEMPT_RT_NEEDS_BH_LOCK then
!CONFIG_PREEMPT_RT_NEEDS_BH_LOCK becomes the only code and the code in
question will vanish.

> > Funny story: I did a grep for the pattern you described and this s390
> > driver was the only thing that popped up.
>=20
> I'm actually curious why the users of _local_bh_enable, specifically thos=
e using the s390
> driver, haven't raised the issue that this interface cannot be used in RT=
-linux. Could it be
> that s390 users have never run on RT-linux?

This driver is very old and s390 does not support PREEMPT_RT. You can
grep for ARCH_SUPPORTS_RT to see who supports it.

> > > Since you also mentioned that later CONFIG_PREEMPT_RT_NEEDS_BH_LOCK w=
ill no longer be
> > > enabled, at that point, local_bh_disable almost loses its significanc=
e. I think it
> > > should either be removed or implemented as a no-op, as it no longer a=
chieves our
> > > expected effect, and it would be better to save some instruction exec=
ution time.
> >=20
> > We can't nop it entirely. local_bh_disable() needs remain a RCU read
> > section and it needs to ensure that the context does not wonder off to
> > another CPU. Also we need to count the disable/enable because once we go
> > back to zero, we need to run callbacks which may have queued up.
>=20
> I did overlook that local_bh_disable() is also considered an RCU critical=
 section and is
> used in conjunction with rcu_read_lock_bh(). Although I saw comments in t=
he code like
> "/* Required to meet the RCU bottomhalf requirements. */", I don't fully =
understand why
> local_bh_disable must be treated as an RCU read critical section. Is it s=
imply because the
> implementation of rcu_read_lock_bh does not directly call __rcu_read_lock=
 and instead relies
> on local_bh_disable to proxy this call? I haven't figured this out, and i=
t seems a bit
> strange to me.

local_bh_disable() becomes an implicit RCU read lock section on
!PREEMPT_RT and be must preserve the semantic.=20

> > And if we queue the softirq on per-task basis rather then per-CPU then
> > we don't have the problem that one task completes softirqs queued by
> > another one.
>=20
> Are you suggesting that the future implementation of soft interrupts migh=
t be optimized to
> use a per-task approach for queuing and processing soft interrupts? I thi=
nk this is a very
> good attempt, as the current handling of soft interrupts is a bit chaotic=
=2E High-priority
> tasks often end up passively dealing with many low-priority soft interrup=
t tasks during
> local_bh_disable(), effectively acting as 'ksoftirqd'. This seems unreaso=
nable to me, as
> it elevates the priority of low-priority tasks for processing.

Yes. Getting rid of that BH lock removed much of the pain. This would one a=
dditional piece.

> If soft interrupt handling could be implemented in a per-task manner, it =
could even lead to
> priority inheritance in the future, and possibly work in conjunction with=
 BH workqueues to
> thoroughly resolve the long-standing issues of soft interrupts in RT-linu=
x. In my project,
> performance problems are often related to __local_bh_disable_ip and vario=
us sporadic
> latency spikes caused by migrate_disable(). This is quite frustrating.

Ideally if task X queues soft interrupts, it handles them and a later
task does not observe them. Only a task with higher priority can add
additional softirq work.
If task X queues BLOCK and gets preempted, task Y with higher priority
adds NET_RX, then task Y will handle NET_RX and BLOCK. This can be
avoided by handling the softirqs per-task.
However if both raise NET_RX then task Y will still handle both. This is
because both use the same data structure to queue work, in this case the
list of pending napi devices. In this case threaded napi would work
because it avoids the common data structure.

I am not a big fan of the BH workqueues because you queue work items in
context in which it originates and then it "vanishes". So all the
priorities and so on are gone. Also the work from lower priority tasks
gets mixed with high priority tasks. Not something you desire in
general.
In general you are better off remaining in the threaded interrupt,
completing the work.

> Xin Zhao

Sebastian
