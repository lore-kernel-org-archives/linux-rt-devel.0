Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6891C84A6
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Feb 2026 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771806977; cv=none; b=SzLqgeEI3/E5jcG8XGvEW8vueOfGeWWyb04M55t7JQen68KUCb8voogWk+ULXW74nZGFd+sJa29s9Jzn5ybMi8vT58G+lQEkhhjud4aGu5m2uEbD7H7IkQnk7V88vm8TvBDdbrRsOa+FdQSKqxcNWRCaaqS47HBNhl7N1ialfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771806977; c=relaxed/simple;
	bh=x6X7pOuO+Pav1N3ycAJbVxKjDCVHSRO4+5RfafbiPHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SCni94pfSefRrIbCMGZy5IXPW4kfz1Y2kb8PFSFV3qlkd9z9vMBqhCUUe9G1UuAOtjAx2T9KvZ4R4KujvvxnxgNvYda3qWdfDh/r1KvyAtTcclbqjTAfwNBMxNM1R2gD2DA0vAUUp+QqgGegZaLK/Xtv9iT8W79alHcbMvKxV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=aoVEu1AV; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="aoVEu1AV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771806938; x=1772411738; i=spasswolf@web.de;
	bh=w/j/sxPglZ2EzWDNZLvjlcwI7ZawU2pJVOPTHZFLooI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aoVEu1AV4cVI6LVtKE2Bwqpis8e4wsNsPyVQFFLRsCsV9E7XBKOVN8PrgjO4Bg0s
	 PzU8QV4oFWfc95OBmWWGU7t3YbG0HWpd/Fc4GNNpXIMocMkUpiqfLS96o1oDve5GA
	 Zewe7xlxeyDDTWHgL8BmfDLCWzn1nt25KemEmmh/14eioULMtsM7valf+qUvsZ/FC
	 vrwxun/U8jDPKqsAwCO9df2ZWZ+uLr73UkUKoJ7vWkWl/0gaa6vHbPgiVU2oFOxXL
	 63P0eRg/7shcnRfW+uGFLbc/KW3kp13D646tvpzDmAm/giO51rdEFEBH+BZGo4QWw
	 wCRtpUlsAzUEsB2s8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6091-1vmvOT2fhT-005kmM; Mon, 23
 Feb 2026 01:35:38 +0100
Message-ID: <ba582a2511d8cd4cda5a186ec48263076ac885cc.camel@web.de>
Subject: Re: ~90s shutdown delay with v6.19 and PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Tejun Heo <tj@kernel.org>, 
	spasswolf@web.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas
 Gleixner <tglx@linutronix.de>, dschatzberg@meta.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Date: Mon, 23 Feb 2026 01:35:36 +0100
In-Reply-To: <20260220104420.54610b04@gandalf.local.home>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
			<20260219164648.3014-1-spasswolf@web.de>	<aZd4YCNTAHZNpTfh@mozart.vkv.me>
			<594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
			<20260219195851.7a7bd1b2@fedora>
			<1d56c93ee93334b9d320c93d255d7548f4497836.camel@web.de>
		 <20260220104420.54610b04@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AiphRKA+SoIhiN2L+waXmqNLlzX4e+qih4Z7lbhGcEbxppbzMgE
 YrWl+St05ebjD9OdofYnH0OCYjWiZV0VMXsqRsDSR/ZE2ZFzdr5SGiSpqs129VvBI4fk2LK
 z2KKTf03SeM5T6MofDFy63TRLc1AWlOAGsjbd3P8MKofsqtEiV3Q3uq+6kFIiDNY/yqcDI/
 SHrEW62BV5e4VEBpl7J1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UNDVljmgvJQ=;X4nRzxdPVjizGYPjjFJRAx215Y+
 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

Am Freitag, dem 20.02.2026 um 10:44 -0500 schrieb Steven Rostedt:
> On Fri, 20 Feb 2026 10:15:43 +0100
> Bert Karwatzki <spasswolf@web.de> wrote:
>=20
> > > It will enable sched_switch event and the traceoff_after_boot will
> > > disable tracing right before running init. That way you can see what=
 is
> > > running during boot that is taking the 90 seconds.
> > >=20
> > > -- Steve =20
> >=20
> > I think there's a misunderstanding here, the 90s delay happens on shut=
down, i.e.
> > when using either reboot or shutdown. I've changed the subject accordi=
ngly.
>=20
> In that case you should be using the persistent ring buffer ;-)
>=20
>   https://docs.kernel.org/trace/debugging.html
>=20
> Add to the kernel command line:
>=20
>   reserve_mem=3D20M:2M:trace trace_instance=3Dboot_map@trace
>=20
> And then before rebooting:
>=20
>   echo 1 > /sys/kernel/tracing/instances/boot_map/events/sched/sched_swi=
tch/enable
>   echo 1 > /sys/kernel/tracing/instances/boot_map/tracing_on
>=20
> Then look at the trace after the reboot:
>=20
>   cat /sys/kernel/tracing/instances/boot_map/trace
>=20
> If your laptop doesn't clear memory during a reboot, you should have the=
 trace.
>=20
> If that's not enough to debug the situation, you can enable other events=
,
> or enable function or function graph tracing. That should all work with =
the
> persistent buffer.
>=20
> -- Steve

Thank you, I tried this with v6.19 and PREEMPT_RT and got this during a re=
boot:

# tracer: nop
#
# entries-in-buffer/entries-written: 265126/265126   #P:16
#
#                                _-----=3D> irqs-off/BH-disabled
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| / _-=3D> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
           <...>-2657    [013] d..2.    62.492813: sched_switch: prev_comm=
=3Dbash prev_pid=3D0xa61 (2657) prev_prio=3D0x78 (120) prev_state=3D0x1 (1=
)
next_comm=3Dksoftirqd/13 next_pid=3D0x86 (134) next_prio=3D0x78 (120)
           <...>-134     [013] d..2.    62.492817: sched_switch: prev_comm=
=3Dksoftirqd/13 prev_pid=3D0x86 (134) prev_prio=3D0x78 (120) prev_state=3D=
0x1 (1)
next_comm=3Dswapper/13 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
          <idle>-0       [007] d..2.    62.492824: sched_switch: prev_comm=
=3Dswapper/7 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3Dxfce4-
terminal next_pid=3D0x7ca (1994) next_prio=3D0x78 (120)
           <...>-1994    [007] d..2.    62.493103: sched_switch: prev_comm=
=3Dxfce4-terminal prev_pid=3D0x7ca (1994) prev_prio=3D0x78 (120) prev_stat=
e=3D0x1 (1)
next_comm=3Dswapper/7 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
          <idle>-0       [007] d..2.    62.493135: sched_switch: prev_comm=
=3Dswapper/7 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3Dxfce4-
terminal next_pid=3D0x7ca (1994) next_prio=3D0x78 (120)
          <idle>-0       [009] d..2.    62.493181: sched_switch: prev_comm=
=3Dswapper/9 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3Dgdbus
next_pid=3D0x7dc (2012) next_prio=3D0x78 (120)

[...]=C2=A0


 <...>-22      [000] d..2.   183.258021: sched_switch: prev_comm=3Dmigrati=
on/0 prev_pid=3D0x16 (22) prev_prio=3D0x0 (0) prev_state=3D0x1 (1) next_co=
mm=3Dswapper/0
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-86      [001] d..2.   183.258037: sched_switch: prev_comm=
=3Dksoftirqd/1 prev_pid=3D0x56 (86) prev_prio=3D0x78 (120) prev_state=3D0x=
1 (1)
next_comm=3Dswapper/1 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
          <idle>-0       [004] d..2.   183.258160: sched_switch: prev_comm=
=3Dswapper/4 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3Dsystemd-
shutdow next_pid=3D0x1 (1) next_prio=3D0x78 (120)
           <...>-1       [004] d..2.   183.258236: sched_switch: prev_comm=
=3Dsystemd-shutdow prev_pid=3D0x1 (1) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Dmigration/4 next_pid=3D0x23 (35) next_prio=3D0x0 (0)
           <...>-35      [004] d..2.   183.258254: sched_switch: prev_comm=
=3Dmigration/4 prev_pid=3D0x23 (35) prev_prio=3D0x0 (0) prev_state=3D0x1 (=
1)
next_comm=3Dswapper/4 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
          <idle>-0       [000] d..2.   183.258281: sched_switch: prev_comm=
=3Dswapper/0 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3Dsystemd-
shutdow next_pid=3D0x1 (1) next_prio=3D0x78 (120)

while on v6.19 without PREEMPT_RT I get this

# tracer: nop
#
# entries-in-buffer/entries-written: 32550/32550   #P:16
#
#                                _-----=3D> irqs-off/BH-disabled
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| / _-=3D> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
          <idle>-0       [010] d..2.    22.559681: sched_switch: prev_comm=
=3Dswapper/10 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (=
0)
next_comm=3Dkworker/u64:15 next_pid=3D0x6e (110) next_prio=3D0x78 (120)
           <...>-2767    [004] d..2.    22.559687: sched_switch: prev_comm=
=3Dbash prev_pid=3D0xacf (2767) prev_prio=3D0x78 (120) prev_state=3D0x1 (1=
)
next_comm=3Dswapper/4 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-110     [010] d..2.    22.559691: sched_switch: prev_comm=
=3Dkworker/u64:15 prev_pid=3D0x6e (110) prev_prio=3D0x78 (120) prev_state=
=3D0x80 (128)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
          <idle>-0       [002] d..2.    22.559702: sched_switch: prev_comm=
=3Dswapper/2 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3Dxfce4-
terminal next_pid=3D0x724 (1828) next_prio=3D0x78 (120)
           <...>-1828    [002] d..2.    22.559951: sched_switch: prev_comm=
=3Dxfce4-terminal prev_pid=3D0x724 (1828) prev_prio=3D0x78 (120) prev_stat=
e=3D0x1 (1)
next_comm=3Dswapper/2 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
          <idle>-0       [008] d..2.    22.560343: sched_switch: prev_comm=
=3Dswapper/8 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
)
next_comm=3Drcu_preempt next_pid=3D0xf (15) next_prio=3D0x78 (120)
           <...>-15      [008] d..2.    22.560347: sched_switch: prev_comm=
=3Drcu_preempt prev_pid=3D0xf (15) prev_prio=3D0x78 (120) prev_state=3D0x8=
0 (128)
next_comm=3Dswapper/8 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
          <idle>-0       [002] d..2.    22.561724: sched_switch: prev_comm=
=3Dswapper/2 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3Dxfce4-
terminal next_pid=3D0x724 (1828) next_prio=3D0x78 (120)
           <...>-1828    [002] d..2.    22.561822: sched_switch: prev_comm=
=3Dxfce4-terminal prev_pid=3D0x724 (1828) prev_prio=3D0x78 (120) prev_stat=
e=3D0x1 (1)
next_comm=3Dswapper/2 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
          <idle>-0       [008] d..2.    22.561826: sched_switch: prev_comm=
=3Dswapper/8 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3DXorg
next_pid=3D0x5cb (1483) next_prio=3D0x78 (120)

[...]

<...>-252     [006] d..2.    29.512070: sched_switch: prev_comm=3Dkworker/=
6:2 prev_pid=3D0xfc (252) prev_prio=3D0x78 (120) prev_state=3D0x80 (128) n=
ext_comm=3Dswapper/6
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-153     [012] d..2.    29.512074: sched_switch: prev_comm=
=3Dkworker/12:1 prev_pid=3D0x99 (153) prev_prio=3D0x78 (120) prev_state=3D=
0x80 (128)
next_comm=3Dswapper/12 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
          <idle>-0       [011] d..2.    29.541390: sched_switch: prev_comm=
=3Dswapper/11 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (=
0)
next_comm=3Dsystemd-shutdow next_pid=3D0x1 (1) next_prio=3D0x78 (120)
           <...>-1       [011] d..2.    29.541912: sched_switch: prev_comm=
=3Dsystemd-shutdow prev_pid=3D0x1 (1) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Dmigration/11 next_pid=3D0x51 (81) next_prio=3D0x0 (0)
           <...>-81      [011] d..2.    29.541933: sched_switch: prev_comm=
=3Dmigration/11 prev_pid=3D0x51 (81) prev_prio=3D0x0 (0) prev_state=3D0x1 =
(1)
next_comm=3Dswapper/11 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
          <idle>-0       [000] d..2.    29.541966: sched_switch: prev_comm=
=3Dswapper/0 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (0=
) next_comm=3Dsystemd-
shutdow next_pid=3D0x1 (1) next_prio=3D0x78 (120)
          <idle>-0       [012] d..2.    29.542130: sched_switch: prev_comm=
=3Dswapper/12 prev_pid=3D0x0 (0) prev_prio=3D0x78 (120) prev_state=3D0x0 (=
0)
next_comm=3Drcu_preempt next_pid=3D0xf (15) next_prio=3D0x78 (120)
           <...>-15      [012] d..2.    29.542142: sched_switch: prev_comm=
=3Drcu_preempt prev_pid=3D0xf (15) prev_prio=3D0x78 (120) prev_state=3D0x8=
0 (128)
next_comm=3Dswapper/12 next_pid=3D0x0 (0) next_prio=3D0x78 (120)

So the time to was is ~120s with PREEMPT_RT and 7s without.

The interesting difference between these two traces is that the second one=
 only
contains messages with "status" d..2. while the first also contains some w=
ith different status
(191 of 265126). Could these be the reason for the delay.

$ grep -v d..2. trace.txt

# tracer: nop
#
# entries-in-buffer/entries-written: 265126/265126   #P:16
#
#                                _-----=3D> irqs-off/BH-disabled
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| / _-=3D> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
           <...>-1584    [011] D..22    62.779670: sched_switch: prev_comm=
=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-1584    [011] D..22    62.779702: sched_switch: prev_comm=
=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-1584    [011] D..22    64.779027: sched_switch: prev_comm=
=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-1584    [011] D..22    64.779052: sched_switch: prev_comm=
=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-1653    [003] D..22    64.810070: sched_switch: prev_comm=
=3DXorg prev_pid=3D0x675 (1653) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Drcuc/3 next_pid=3D0x5c (92) next_prio=3D0x62 (98)
           <...>-1584    [011] D..22    66.778764: sched_switch: prev_comm=
=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-1584    [011] D..22    66.778786: sched_switch: prev_comm=
=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-150     [009] D..22    67.793707: sched_switch: prev_comm=
=3Dkworker/u64:5 prev_pid=3D0x96 (150) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/9 next_pid=3D0x74 (116) next_prio=3D0x62 (98)
           <...>-148     [003] D..22    68.793596: sched_switch: prev_comm=
=3Dkworker/u64:3 prev_pid=3D0x94 (148) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/3 next_pid=3D0x5c (92) next_prio=3D0x62 (98)
           <...>-148     [003] D..22    70.794233: sched_switch: prev_comm=
=3Dkworker/u64:3 prev_pid=3D0x94 (148) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/3 next_pid=3D0x5c (92) next_prio=3D0x62 (98)
           <...>-669     [009] D..21    70.794361: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29d (669) prev_prio=3D0x78 (120) prev_state=3D=
0x2 (2)
next_comm=3Dswapper/9 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-669     [009] D..21    71.214115: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29d (669) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/9 next_pid=3D0x74 (116) next_prio=3D0x62 (98)
           <...>-148     [003] D..21    71.794951: sched_switch: prev_comm=
=3Dkworker/u64:3 prev_pid=3D0x94 (148) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Dktimers/3 next_pid=3D0x5d (93) next_prio=3D0x62 (98)
           <...>-148     [003] D..23    71.795947: sched_switch: prev_comm=
=3Dkworker/u64:3 prev_pid=3D0x94 (148) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/3 next_pid=3D0x5c (92) next_prio=3D0x62 (98)
           <...>-148     [012] D..22    75.489983: sched_switch: prev_comm=
=3Dkworker/u64:3 prev_pid=3D0x94 (148) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/12 next_pid=3D0x44 (68) next_prio=3D0x62 (98)
           <...>-1584    [012] D..22    76.776598: sched_switch: prev_comm=
=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-1584    [012] D..22    76.776629: sched_switch: prev_comm=
=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-1584    [012] D..22    78.776540: sched_switch: prev_comm=
=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-1584    [012] D..22    78.776588: sched_switch: prev_comm=
=3Dntpd prev_pid=3D0x630 (1584) prev_prio=3D0x78 (120) prev_state=3D0x100 =
(256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-671     [010] D..21    78.907165: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29f (671) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Dktimers/10 next_pid=3D0x3d (61) next_prio=3D0x62 (98)
           <...>-1372    [012] D..22    80.920002: sched_switch: prev_comm=
=3Davahi-daemon prev_pid=3D0x55c (1372) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-669     [009] D..21    80.935518: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29d (669) prev_prio=3D0x78 (120) prev_state=3D=
0x2 (2)
next_comm=3Dswapper/9 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-669     [009] D..21    80.935533: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29d (669) prev_prio=3D0x78 (120) prev_state=3D=
0x2 (2)
next_comm=3Dswapper/9 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-100     [005] D..21    81.549584: sched_switch: prev_comm=
=3Drcuc/5 prev_pid=3D0x64 (100) prev_prio=3D0x62 (98) prev_state=3D0x100 (=
256)
next_comm=3Dirq/108-amdgpu next_pid=3D0x1aa (426) next_prio=3D0x31 (49)
           <...>-148     [012] D..23    81.791530: sched_switch: prev_comm=
=3Dkworker/u64:3 prev_pid=3D0x94 (148) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/12 next_pid=3D0x44 (68) next_prio=3D0x62 (98)
           <...>-671     [004] D..21    82.179446: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29f (671) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/4 next_pid=3D0x24 (36) next_prio=3D0x62 (98)
           <...>-150     [002] D..22    83.169248: sched_switch: prev_comm=
=3Dkworker/u64:5 prev_pid=3D0x96 (150) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/2 next_pid=3D0x1c (28) next_prio=3D0x62 (98)
           <...>-669     [012] D..23    83.247178: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29d (669) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-152     [010] D..21    84.177041: sched_switch: prev_comm=
=3Dkworker/u64:7 prev_pid=3D0x98 (152) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/10 next_pid=3D0x3c (60) next_prio=3D0x62 (98)
           <...>-159     [006] D..22    84.577962: sched_switch: prev_comm=
=3Dkworker/u64:14 prev_pid=3D0x9f (159) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/6 next_pid=3D0x2c (44) next_prio=3D0x62 (98)
           <...>-159     [006] D..21    84.579215: sched_switch: prev_comm=
=3Dkworker/u64:14 prev_pid=3D0x9f (159) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Dirq/110-mt7921e next_pid=3D0x29c (668) next_prio=3D0x31 (49)
           <...>-152     [004] D..22    84.789922: sched_switch: prev_comm=
=3Dkworker/u64:7 prev_pid=3D0x98 (152) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/4 next_pid=3D0x24 (36) next_prio=3D0x62 (98)
           <...>-10      [000] D..21    86.208639: sched_switch: prev_comm=
=3Dkworker/0:1 prev_pid=3D0xa (10) prev_prio=3D0x78 (120) prev_state=3D0x1=
00 (256)
next_comm=3Drcuc/0 next_pid=3D0x14 (20) next_prio=3D0x62 (98)
           <...>-116     [009] D..21    86.254673: sched_switch: prev_comm=
=3Drcuc/9 prev_pid=3D0x74 (116) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dfirefox-
esr next_pid=3D0x7c5 (1989) next_prio=3D0x62 (98)
           <...>-76      [014] D..23    86.270830: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dirq_work/14 next_pid=3D0x4a (74) next_prio=3D0x62 (98)
           <...>-44      [006] D..23    86.270839: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/6:7 next_pid=3D0xc83 (3203) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.270857: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dxdg-
desktop-por next_pid=3D0x754 (1876) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.270867: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.270880: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/14:4 next_pid=3D0x89e (2206) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.270891: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.270903: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dxdg-
desktop-por next_pid=3D0x754 (1876) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.270911: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.270925: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3DXorg
next_pid=3D0x675 (1653) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.270935: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.270949: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dxdg-
desktop-por next_pid=3D0x754 (1876) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.270961: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.270971: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3DXorg
next_pid=3D0x675 (1653) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.270981: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.270997: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dxdg-
desktop-por next_pid=3D0x754 (1876) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.271009: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.271021: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3DXorg
next_pid=3D0x675 (1653) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.271032: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.271043: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dxdg-
desktop-por next_pid=3D0x754 (1876) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.271062: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.271081: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3DXorg
next_pid=3D0x675 (1653) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.271098: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.271110: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dxdg-
desktop-por next_pid=3D0x754 (1876) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.271124: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Ddbus-
daemon next_pid=3D0x65d (1629) next_prio=3D0x78 (120)
           <...>-76      [014] D..23    86.271145: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3DXorg
next_pid=3D0x675 (1653) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274667: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/14:4 next_pid=3D0x89e (2206) next_prio=3D0x78 (120)
           <...>-108     [007] D..21    86.274668: sched_switch: prev_comm=
=3Drcuc/7 prev_pid=3D0x6c (108) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/7:4 next_pid=3D0xd1e (3358) next_prio=3D0x78 (120)
           <...>-28      [002] D..21    86.274678: sched_switch: prev_comm=
=3Drcuc/2 prev_pid=3D0x1c (28) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/2:2 next_pid=3D0x161 (353) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274682: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/14:4 next_pid=3D0x89e (2206) next_prio=3D0x78 (120)
           <...>-92      [003] D..21    86.274687: sched_switch: prev_comm=
=3Drcuc/3 prev_pid=3D0x5c (92) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/3:1 next_pid=3D0xe9 (233) next_prio=3D0x78 (120)
           <...>-28      [002] D..21    86.274691: sched_switch: prev_comm=
=3Drcuc/2 prev_pid=3D0x1c (28) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/2:2 next_pid=3D0x161 (353) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274695: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/u64:4 next_pid=3D0x95 (149) next_prio=3D0x78 (120)
           <...>-92      [003] D..21    86.274698: sched_switch: prev_comm=
=3Drcuc/3 prev_pid=3D0x5c (92) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/3:1 next_pid=3D0xe9 (233) next_prio=3D0x78 (120)
           <...>-28      [002] D..21    86.274702: sched_switch: prev_comm=
=3Drcuc/2 prev_pid=3D0x1c (28) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dksoftirqd/2 next_pid=3D0x1e (30) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274705: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/u64:4 next_pid=3D0x95 (149) next_prio=3D0x78 (120)
           <...>-92      [003] D..21    86.274709: sched_switch: prev_comm=
=3Drcuc/3 prev_pid=3D0x5c (92) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dksoftirqd/3 next_pid=3D0x5e (94) next_prio=3D0x78 (120)
           <...>-28      [002] D..21    86.274714: sched_switch: prev_comm=
=3Drcuc/2 prev_pid=3D0x1c (28) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3DSocket
Thread next_pid=3D0x96f (2415) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274717: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/u64:4 next_pid=3D0x95 (149) next_prio=3D0x78 (120)
           <...>-92      [003] D..21    86.274721: sched_switch: prev_comm=
=3Drcuc/3 prev_pid=3D0x5c (92) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/3
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-28      [002] D..21    86.274726: sched_switch: prev_comm=
=3Drcuc/2 prev_pid=3D0x1c (28) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3DSocket
Thread next_pid=3D0x96f (2415) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274730: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/u64:4 next_pid=3D0x95 (149) next_prio=3D0x78 (120)
           <...>-140     [015] D..21    86.274732: sched_switch: prev_comm=
=3Drcuc/15 prev_pid=3D0x8c (140) prev_prio=3D0x62 (98) prev_state=3D0x2 (2=
) next_comm=3Dsystemd
next_pid=3D0x1 (1) next_prio=3D0x78 (120)
           <...>-92      [003] D..21    86.274735: sched_switch: prev_comm=
=3Drcuc/3 prev_pid=3D0x5c (92) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/3
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274744: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/14 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-140     [015] D..21    86.274747: sched_switch: prev_comm=
=3Drcuc/15 prev_pid=3D0x8c (140) prev_prio=3D0x62 (98) prev_state=3D0x2 (2=
)
next_comm=3Dkworker/15:1 next_pid=3D0xce (206) next_prio=3D0x78 (120)
           <...>-92      [003] D..21    86.274754: sched_switch: prev_comm=
=3Drcuc/3 prev_pid=3D0x5c (92) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/3
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274761: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/14 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-140     [015] D..21    86.274767: sched_switch: prev_comm=
=3Drcuc/15 prev_pid=3D0x8c (140) prev_prio=3D0x62 (98) prev_state=3D0x2 (2=
) next_comm=3Dsystemd
next_pid=3D0x1 (1) next_prio=3D0x78 (120)
           <...>-92      [003] D..21    86.274772: sched_switch: prev_comm=
=3Drcuc/3 prev_pid=3D0x5c (92) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/3
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-28      [002] D..21    86.274775: sched_switch: prev_comm=
=3Drcuc/2 prev_pid=3D0x1c (28) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3DSocket
Thread next_pid=3D0x96f (2415) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274779: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/14 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-140     [015] D..21    86.274787: sched_switch: prev_comm=
=3Drcuc/15 prev_pid=3D0x8c (140) prev_prio=3D0x62 (98) prev_state=3D0x2 (2=
)
next_comm=3Dkworker/15:1 next_pid=3D0xce (206) next_prio=3D0x78 (120)
           <...>-92      [003] D..21    86.274790: sched_switch: prev_comm=
=3Drcuc/3 prev_pid=3D0x5c (92) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/3
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-28      [002] D..21    86.274795: sched_switch: prev_comm=
=3Drcuc/2 prev_pid=3D0x1c (28) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3DSocket
Thread next_pid=3D0x96f (2415) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274801: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/14 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-140     [015] D..21    86.274804: sched_switch: prev_comm=
=3Drcuc/15 prev_pid=3D0x8c (140) prev_prio=3D0x62 (98) prev_state=3D0x2 (2=
) next_comm=3Dsystemd
next_pid=3D0x1 (1) next_prio=3D0x78 (120)
           <...>-92      [003] D..21    86.274812: sched_switch: prev_comm=
=3Drcuc/3 prev_pid=3D0x5c (92) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/3
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-28      [002] D..21    86.274816: sched_switch: prev_comm=
=3Drcuc/2 prev_pid=3D0x1c (28) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3DSocket
Thread next_pid=3D0x96f (2415) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274822: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/14 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-92      [003] D..21    86.274834: sched_switch: prev_comm=
=3Drcuc/3 prev_pid=3D0x5c (92) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/3
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-28      [002] D..21    86.274837: sched_switch: prev_comm=
=3Drcuc/2 prev_pid=3D0x1c (28) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3DSocket
Thread next_pid=3D0x96f (2415) next_prio=3D0x78 (120)
           <...>-76      [014] D..21    86.274843: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/u64:4 next_pid=3D0x95 (149) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.276634: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dirq_work/6
next_pid=3D0x2a (42) next_prio=3D0x62 (98)
           <...>-60      [010] D..23    86.276634: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dksoftirqd/10 next_pid=3D0x3e (62) next_prio=3D0x78 (120)
           <...>-44      [006] D..23    86.276657: sched_switch: prev_comm=
=3Drcuc/6 prev_pid=3D0x2c (44) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/6
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276672: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.276762: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/4:3 next_pid=3D0xceb (3307) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276773: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.276784: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/4:3 next_pid=3D0xceb (3307) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276797: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.276807: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3DWebKitNetworkPr next_pid=3D0xc68 (3176) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276818: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.276833: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276842: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.276857: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276867: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.276880: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276892: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.276903: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dpool-
spawner next_pid=3D0xbc8 (3016) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276921: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.276933: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276948: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.276958: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276973: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.276982: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.276996: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277007: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277021: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277031: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dgmain
next_pid=3D0x8f6 (2294) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277042: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277055: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277066: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277077: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277091: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277101: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277111: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277122: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277130: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277139: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277149: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277158: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277166: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277175: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277184: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277192: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277201: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277210: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277219: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277228: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-60      [010] D..23    86.277239: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/10 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-36      [004] D..23    86.277248: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dswapper/4
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-52      [008] D..21    86.308651: sched_switch: prev_comm=
=3Drcuc/8 prev_pid=3D0x34 (52) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dksoftirqd/8 next_pid=3D0x36 (54) next_prio=3D0x78 (120)
           <...>-68      [012] D..21    86.308652: sched_switch: prev_comm=
=3Drcuc/12 prev_pid=3D0x44 (68) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dsystemd-
logind next_pid=3D0x56c (1388) next_prio=3D0x78 (120)
           <...>-52      [008] D..21    86.308658: sched_switch: prev_comm=
=3Drcuc/8 prev_pid=3D0x34 (52) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/8:1 next_pid=3D0xaf (175) next_prio=3D0x78 (120)
           <...>-20      [000] D..21    86.311699: sched_switch: prev_comm=
=3Drcuc/0 prev_pid=3D0x14 (20) prev_prio=3D0x62 (98) prev_state=3D0x100 (2=
56) next_comm=3Dirq/6-
AMDI0010: next_pid=3D0x159 (345) next_prio=3D0x31 (49)
           <...>-1535    [000] D..21    86.333765: sched_switch: prev_comm=
=3Disc-loop-0001 prev_pid=3D0x5ff (1535) prev_prio=3D0x78 (120) prev_state=
=3D0x2 (2)
next_comm=3Dswapper/0 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-1538    [001] D..21    86.333767: sched_switch: prev_comm=
=3Disc-loop-0004 prev_pid=3D0x602 (1538) prev_prio=3D0x78 (120) prev_state=
=3D0x2 (2)
next_comm=3Dswapper/1 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-1541    [007] D..21    86.333768: sched_switch: prev_comm=
=3Disc-loop-0005 prev_pid=3D0x605 (1541) prev_prio=3D0x78 (120) prev_state=
=3D0x2 (2)
next_comm=3Dswapper/7 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-1547    [013] D..21    86.333780: sched_switch: prev_comm=
=3Disc-loop-0009 prev_pid=3D0x60b (1547) prev_prio=3D0x78 (120) prev_state=
=3D0x2 (2)
next_comm=3Dswapper/13 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-1550    [005] D..21    86.333789: sched_switch: prev_comm=
=3Disc-loop-0011 prev_pid=3D0x60e (1550) prev_prio=3D0x78 (120) prev_state=
=3D0x2 (2)
next_comm=3Dswapper/5 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-1517    [009] D..21    86.333796: sched_switch: prev_comm=
=3Dnamed prev_pid=3D0x5ed (1517) prev_prio=3D0x78 (120) prev_state=3D0x2 (=
2)
next_comm=3Dswapper/9 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-1549    [003] D..21    86.334055: sched_switch: prev_comm=
=3Disc-loop-0010 prev_pid=3D0x60d (1549) prev_prio=3D0x78 (120) prev_state=
=3D0x2 (2)
next_comm=3Dswapper/3 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-1552    [012] D..21    86.334064: sched_switch: prev_comm=
=3Disc-loop-0012 prev_pid=3D0x610 (1552) prev_prio=3D0x78 (120) prev_state=
=3D0x2 (2)
next_comm=3Dswapper/12 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-124     [011] D..21    86.339629: sched_switch: prev_comm=
=3Drcuc/11 prev_pid=3D0x7c (124) prev_prio=3D0x62 (98) prev_state=3D0x2 (2=
) next_comm=3Dnamed
next_pid=3D0x5ed (1517) next_prio=3D0x62 (98)
           <...>-669     [009] D..21    86.384605: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29d (669) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/9 next_pid=3D0x74 (116) next_prio=3D0x62 (98)
           <...>-669     [009] D..21    86.422599: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29d (669) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/9 next_pid=3D0x74 (116) next_prio=3D0x62 (98)
           <...>-669     [009] D..22    86.435597: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29d (669) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/9 next_pid=3D0x74 (116) next_prio=3D0x62 (98)
           <...>-669     [009] D..24    86.599564: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29d (669) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/9 next_pid=3D0x74 (116) next_prio=3D0x62 (98)
           <...>-671     [010] D..23    86.642556: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29f (671) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/10 next_pid=3D0x3c (60) next_prio=3D0x62 (98)
           <...>-100     [005] D..22    87.291482: sched_switch: prev_comm=
=3Drcuc/5 prev_pid=3D0x64 (100) prev_prio=3D0x62 (98) prev_state=3D0x100 (=
256)
next_comm=3Dirq/108-amdgpu next_pid=3D0x1aa (426) next_prio=3D0x31 (49)
           <...>-108     [007] D..21    87.291485: sched_switch: prev_comm=
=3Drcuc/7 prev_pid=3D0x6c (108) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dswapper/7
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-100     [005] D..21    87.291494: sched_switch: prev_comm=
=3Drcuc/5 prev_pid=3D0x64 (100) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dswapper/5
next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-100     [005] D..21    87.291513: sched_switch: prev_comm=
=3Drcuc/5 prev_pid=3D0x64 (100) prev_prio=3D0x62 (98) prev_state=3D0x100 (=
256)
next_comm=3Dirq/108-amdgpu next_pid=3D0x1aa (426) next_prio=3D0x31 (49)
           <...>-671     [010] D..23    87.871456: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29f (671) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Dktimers/10 next_pid=3D0x3d (61) next_prio=3D0x62 (98)
           <...>-68      [012] D..21    88.253434: sched_switch: prev_comm=
=3Drcuc/12 prev_pid=3D0x44 (68) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dirq_work/12 next_pid=3D0x42 (66) next_prio=3D0x62 (98)
           <...>-76      [014] D..21    88.253437: sched_switch: prev_comm=
=3Drcuc/14 prev_pid=3D0x4c (76) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dswapper/14 next_pid=3D0x0 (0) next_prio=3D0x78 (120)
           <...>-68      [012] D..21    88.253469: sched_switch: prev_comm=
=3Drcuc/12 prev_pid=3D0x44 (68) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/12:4 next_pid=3D0xa58 (2648) next_prio=3D0x78 (120)
           <...>-100     [005] D..21    88.253472: sched_switch: prev_comm=
=3Drcuc/5 prev_pid=3D0x64 (100) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dksoftirqd/5 next_pid=3D0x66 (102) next_prio=3D0x78 (120)
           <...>-116     [009] D..21    88.256459: sched_switch: prev_comm=
=3Drcuc/9 prev_pid=3D0x74 (116) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dkworker/9:1 next_pid=3D0xb0 (176) next_prio=3D0x78 (120)
           <...>-100     [005] D..21    88.256462: sched_switch: prev_comm=
=3Drcuc/5 prev_pid=3D0x64 (100) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dksoftirqd/5 next_pid=3D0x66 (102) next_prio=3D0x78 (120)
           <...>-36      [004] D..21    88.277433: sched_switch: prev_comm=
=3Drcuc/4 prev_pid=3D0x24 (36) prev_prio=3D0x62 (98) prev_state=3D0x2 (2) =
next_comm=3Dsystemd
next_pid=3D0x63f (1599) next_prio=3D0x78 (120)
           <...>-671     [012] D..23    88.383431: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29f (671) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/12 next_pid=3D0x44 (68) next_prio=3D0x62 (98)
           <...>-3500    [014] D..22   134.060263: sched_switch: prev_comm=
=3Dkworker/u64:29 prev_pid=3D0xdac (3500) prev_prio=3D0x78 (120) prev_stat=
e=3D0x100 (256)
next_comm=3Drcuc/14 next_pid=3D0x4c (76) next_prio=3D0x62 (98)
           <...>-148     [012] D..23   156.035218: sched_switch: prev_comm=
=3Dkworker/u64:3 prev_pid=3D0x94 (148) prev_prio=3D0x78 (120) prev_state=
=3D0x100 (256)
next_comm=3Drcuc/12 next_pid=3D0x44 (68) next_prio=3D0x62 (98)
           <...>-671     [011] D..23   156.374210: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29f (671) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/11 next_pid=3D0x7c (124) next_prio=3D0x62 (98)
           <...>-671     [012] D..22   156.886187: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29f (671) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/12 next_pid=3D0x44 (68) next_prio=3D0x62 (98)
           <...>-578     [008] D..21   178.359189: sched_switch: prev_comm=
=3Dkworker/8:2 prev_pid=3D0x242 (578) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Dkworker/8:1 next_pid=3D0xaf (175) next_prio=3D0x78 (120)
           <...>-143     [015] D..21   178.470232: sched_switch: prev_comm=
=3Dkworker/15:0 prev_pid=3D0x8f (143) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Dkworker/15:1 next_pid=3D0xce (206) next_prio=3D0x78 (120)
           <...>-671     [012] D..21   178.523343: sched_switch: prev_comm=
=3Dnapi/phy0-0 prev_pid=3D0x29f (671) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Dmt76-tx phy0 next_pid=3D0x5fb (1531) next_prio=3D0x62 (98)
           <...>-20      [000] D..21   178.891146: sched_switch: prev_comm=
=3Drcuc/0 prev_pid=3D0x14 (20) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)
next_comm=3Dksoftirqd/0 next_pid=3D0xe (14) next_prio=3D0x78 (120)
           <...>-116     [009] D..21   178.938182: sched_switch: prev_comm=
=3Drcuc/9 prev_pid=3D0x74 (116) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dumount
next_pid=3D0xe27 (3623) next_prio=3D0x62 (98)
           <...>-116     [009] D..21   178.947159: sched_switch: prev_comm=
=3Drcuc/9 prev_pid=3D0x74 (116) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dumount
next_pid=3D0xe27 (3623) next_prio=3D0x62 (98)
           <...>-68      [012] D..21   179.004152: sched_switch: prev_comm=
=3Drcuc/12 prev_pid=3D0x44 (68) prev_prio=3D0x62 (98) prev_state=3D0x2 (2)=
 next_comm=3Dumount
next_pid=3D0xe27 (3623) next_prio=3D0x62 (98)
           <...>-132     [013] D..21   179.070272: sched_switch: prev_comm=
=3Drcuc/13 prev_pid=3D0x84 (132) prev_prio=3D0x62 (98) prev_state=3D0x100 =
(256)
next_comm=3Dirq/87-nvme0q14 next_pid=3D0x181 (385) next_prio=3D0x31 (49)
           <...>-60      [010] D..21   181.208158: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x100 (=
256)
next_comm=3Dirq/83-nvme0q11 next_pid=3D0x17b (379) next_prio=3D0x31 (49)
           <...>-60      [010] D..21   181.321060: sched_switch: prev_comm=
=3Drcuc/10 prev_pid=3D0x3c (60) prev_prio=3D0x62 (98) prev_state=3D0x100 (=
256)
next_comm=3Dirq/83-nvme0q11 next_pid=3D0x17b (379) next_prio=3D0x31 (49)
           <...>-1       [002] D..22   182.672954: sched_switch: prev_comm=
=3Dsystemd-shutdow prev_pid=3D0x1 (1) prev_prio=3D0x78 (120) prev_state=3D=
0x100 (256)
next_comm=3Drcuc/2 next_pid=3D0x1c (28) next_prio=3D0x62 (98)


Bert Karwatzki
