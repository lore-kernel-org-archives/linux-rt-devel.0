Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8171FE44A
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Feb 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853855; cv=none; b=mHM8RyeddIT4D+40ULtk46KdipCVNGVvUOfl/AiqvqprFyQxEO+yKblp0/L0hwvCphD2hfXR8EKYG/E3tcz+A8E/LkYsCzgAqMmb/uBxyTB4NEIidXYM+frofc0TG6yNSZHGOPYTkLp0lx58dQaDDLdDpG1f5wqeEyMhh01x0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853855; c=relaxed/simple;
	bh=+BX5Rypw8GUKwCg2d/euMFk52EY1tmdUb/47aHbd5eU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4UeL3i1/S4ESt2i6BcsHpHqRzhUmLeAAfCiNhqjdKVrtViwqqg8f7Ku5oc5OoEod65IFLdI15Su/kMElltfU01OM1yG0adTuBHASTrsZAyGvS3wfcMwE32d0mM5G0Y6CJU+730vNHUgJwZHqujKIlj8CO+DJR2WGKqUEDabIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=pk1S0ZzP; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="pk1S0ZzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771853814; x=1772458614; i=spasswolf@web.de;
	bh=918bOIkJZxm0lChCAXi7Q4IowSPbY6XC8guC6pyNsd8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pk1S0ZzPETdMn08eh7+Bh2gSfOP+0HrVUEnnHyjwel6UOyeBVgUkCST1TVATZ+Ou
	 K9BQ32v5YWUOWa3HzCek+w+AqXf6cp9iMYQwmcGEmAMvaPCC4FbT2CuZ4ox2gKCg9
	 oA1hsqRv/xq6MTl+EANTfQD8tvbby220sPYmbswrjzBNhUgqsBhviTSlqw7mkvydG
	 qDZabEme4WARMZXUt9Gd3eBjqX0/mvIjUBIFPTdGDDpnF7EpAPcGa21/S8osWOsRK
	 CVHBJu82yqoehr4/6P7Hl/QxuLAd5qJugplJfh/ln2cqnf3M1ozY8V5abdaT9qwfh
	 i0XxQnmqFIpbiwc8Vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5ljL-1vg27p2b63-018FBY; Mon, 23
 Feb 2026 14:36:54 +0100
Message-ID: <80f657156fb2d32d8fe246e65e9ac8bf9d7cfbd5.camel@web.de>
Subject: Re: ~90s shutdown delay with v6.19 and PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Tejun Heo <tj@kernel.org>, 
	spasswolf@web.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas
 Gleixner <tglx@linutronix.de>, dschatzberg@meta.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Date: Mon, 23 Feb 2026 14:36:51 +0100
In-Reply-To: <20260223032257.4e6db467@fedora>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
			<20260219164648.3014-1-spasswolf@web.de>	<aZd4YCNTAHZNpTfh@mozart.vkv.me>
			<594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
			<20260219195851.7a7bd1b2@fedora>
			<1d56c93ee93334b9d320c93d255d7548f4497836.camel@web.de>
			<20260220104420.54610b04@gandalf.local.home>
			<ba582a2511d8cd4cda5a186ec48263076ac885cc.camel@web.de>
		 <20260223032257.4e6db467@fedora>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n8HQbFG+gKwLhpUxtMovQxL/1/Tca9f4crTAj6ePe9GTbIP2d3u
 yLJRDMEYh4YAbRetWJvQ+DEQJvPr1+2vHcXXRCz8PTwbUN1dg4b0kzfFtfWkIEg2IoRPgJV
 p12SXghJvHQ+PFY1BB2zsbaG1BlYKAErj7J7X6X+xQL+3tSKk+l4CwltsMxFwxMzpFXBEqM
 NV3PCmG/K3XeOBzN4NiSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P6XoKiUELt8=;12Xg7d6xpA2cUY6n0dKMdDBr0zD
 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

Am Montag, dem 23.02.2026 um 03:22 -0500 schrieb Steven Rostedt:
> On Mon, 23 Feb 2026 01:35:36 +0100
> Bert Karwatzki <spasswolf@web.de> wrote:
>=20
> > So the time to was is ~120s with PREEMPT_RT and 7s without.
> >=20
> > The interesting difference between these two traces is that the second=
 one only
> > contains messages with "status" d..2. while the first also contains so=
me with different status
> > (191 of 265126). Could these be the reason for the delay.
> >=20
> > $ grep -v d..2. trace.txt
> >=20
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 265126/265126   #P:16
> > #
> > #                                _-----=3D> irqs-off/BH-disabled
> > #                               / _----=3D> need-resched
> > #                              | / _---=3D> hardirq/softirq
> > #                              || / _--=3D> preempt-depth
> > #                              ||| / _-=3D> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >            <...>-1584    [011] D..22    62.779670: sched_switch: prev_=
comm=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x=
100 (256)
> > next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
>=20
> The 'D' means both interrupts 'd' and softirqs 'b' are disabled.
>=20
> The last number is migrate disable which means the task is pinned to a
> CPU. That may be an issue if the system is trying to take down a CPU
> and there's a task pinned to it.
>=20
> Now that we know that the persistent ring buffer works, we can add even
> more debugging. We could see where things are stuck...
>=20
>   cd /sys/kernel/tracing/instances/boot_map
>   echo 'stacktrace if prev_state & 3' > events/sched/sched_switch/trigge=
r
>=20
> That will do a stacktrace at every location that schedules out in a
> non-running state. That way we can see what is waiting for something to
> finish.

I tried that twice and got these results:

Commands:
echo 1 > /sys/kernel/tracing/instances/boot_map/events/sched/sched_switch/=
enable
echo 'stacktrace if prev_state & 3' > /sys/kernel/tracing/instances/boot_m=
ap/events/sched/sched_switch/trigger=20
echo 1 > /sys/kernel/tracing/instances/boot_map/tracing_on
reboot

The first time (despite the 265000 entries) the reboot happened at
normals speed, even thought the timestamps suggest something different:
# entries-in-buffer/entries-written: 265170/265170   #P:16
[...]
           <...>-158     [009] d..2.    98.680157: sched_switch: prev_comm=
=3Dkworker/u64:13 prev_pid=3D0x9e (158) prev_prio=3D0x78 (120) prev_state=
=3D0x80 (128)
next_comm=3Dswapper/9 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
[...]
           <...>-70      [012] d..2.   166.155040: sched_switch: prev_comm=
=3Dksoftirqd/12 prev_pid=3D0x46 (70) prev_prio=3D0x78 (120) prev_state=3D0=
x1 (1)
next_comm=3Dswapper/12 next_pid=3D0x0 (0) next_prio=3D0x78 (120)

Here are the messages from /var/log/kern.log that show the last messages o=
f the old kernel
and the first message of the new:
2026-02-23T13:57:38.441240+01:00 lisa kernel: [  T156] amdgpu 0000:03:00.0=
: [drm] Cannot find any crtc or sizes
2026-02-23T13:58:04.876308+01:00 lisa kernel: [    T0] Linux version 6.19.=
0-trace (bert@lisa) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils f=
or Debian)
2.44) #1160 SMP PREEMPT_RT Sat Feb 21 00:22:46 CET 2026

So while the time stamps in the trace suggest that the reboot took at leas=
t 68 seconds,
/var/log/kern.log shows that it took only 26s at most. As I observed the w=
hole thing I'm sure
kern.log is correct here.

Then I repeated the process above and this time the shutdown got stuck
again, but the trace was actually shorter:
# entries-in-buffer/entries-written: 195123/195123   #P:16
[...]
          <idle>-0       [002] d..2.   135.554543: sched_switch: prev_comm=
=3Dswapper/2 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3Dxfce4-
terminal next_pid=3D0x7b7 (1975) next_prio=3D0x78 (120)

[...]
          <idle>-0       [000] d..2.   242.301841: sched_switch: prev_comm=
=3Dswapper/0 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3Dsystemd-
shutdow next_pid=3D0x1 (1) next_prio=3D0x78 (120)

These are the line from kern.log that show the longer delay:
2026-02-23T13:59:19.348451+01:00 lisa kernel: [  T146] amdgpu 0000:03:00.0=
: [drm] Cannot find any crtc or sizes
2026-02-23T14:02:13.817354+01:00 lisa kernel: [    T0] Linux version 6.19.=
0-trace (bert@lisa) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils f=
or Debian)
2.44) #1160 SMP PREEMPT_RT Sat Feb 21 00:22:46 CET 2026

So this time we have a trace that took about 107s and also a longer delay =
in kern.log.
The kern.log delay here is not the time it took for the reboot though, as =
the there might
have been a delay between the last log message of the old kernel and the r=
eboot command.

=46rom now on I'll reboot like this to get a proper timestamp in /var/log/=
kern.log:
# echo reboot > /dev/kmsg && reboot

Bert Karwatzki


