Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F033A9C6
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058699; cv=none; b=rZ1LhEOHpmsdkTnQie4CADLE4BUNXFw3fLkHo1kv3sWUaJ4vuvP8W86IkTGPDoNBjRG+v9ZovgPtYU6nD4oVpYs8nlQdlFk1eN+u45yqUoVT2z7bR0ydakF1mFElpgBNQwCnlyYiKQ+CnDNu+bgQy+MVnt4zwfuuxO+RuAUIUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058699; c=relaxed/simple;
	bh=qn7Bk7qKmIZRr/+snao/aMjtjvEcaDyLGNzoL+8k6/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp5BGbmii0SS6Lj048ttGZN5ReaJayGgBmPdI6hPib6aHGqe74LMk8fXA0p1XSDPviNNGcge3anNmdbWh+9JWwr8z6lcPU2hUvgxO2hw+MfJzdhfjaRe8ZrVR+lY3c5Q6DngDAfyeIhMl0k2o0QF+ITphh9G/xqPoOc9gb9AXCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OF8DSLZh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtNZsPk6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OF8DSLZh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtNZsPk6"
Date: Wed, 25 Feb 2026 23:31:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772058696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xb3dcb3UyI9h3gUPdsLghwOmUcokBpUzpu+97ZbUhhU=;
	b=OF8DSLZhQ7oZEenjnHcJ2oiXj+UBN+leeOxnwF34nkocDYdqJ1dIhIAKaOoPJ0tHFPgeCp
	MIAUOqw4qEAke8T2hpr9L/vi5zy8Yv4KE8xkGJN5iuWXJXgq5VdwObF7banwVT9vRK82FV
	epWZ1YO3sFd/x9nBdBVVU6dRLUTqyf2l4A2VoPsXXTuOMR32MZHtzki+E7cZLXnTLjPnKR
	b8cp6EMGzFFuaeJg92hg3srIjNei2ybq7/dpcKJ1E47GOguCN5z6JtcjCEuIvqnXnsm9RN
	oErceQZtYUYXXknnXu+SiWtMjX/yskO6+hw6tyMrIFVauNnjuD7Bv8nxBqph4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772058696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xb3dcb3UyI9h3gUPdsLghwOmUcokBpUzpu+97ZbUhhU=;
	b=XtNZsPk6D9G8uqYmsBUAzUeDaHP8Rjrf4pEqt01GqyAZCcWQYKxVlMI7hi63l2ULgKAsJ+
	ZdVLUeMxg+TqvtBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	calvin@wbinvd.org, dschatzberg@meta.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
Message-ID: <20260225223135.vjfaFo0c@linutronix.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20260219164648.3014-1-spasswolf@web.de>
 <20260225154341.32AjXoVi@linutronix.de>
 <6abee0b4bca811680a7f7fb6ab70bf27c6805cf5.camel@web.de>
 <20260225165954.180aRkaV@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260225165954.180aRkaV@linutronix.de>

On 2026-02-25 17:59:55 [+0100], To Bert Karwatzki wrote:
> On 2026-02-25 17:37:56 [+0100], Bert Karwatzki wrote:
> > I've done two testruns with this debug patch (The persistant log buffer=
 works now, thanks
> > again to Steven Rostedt):
>=20
> =E2=80=A6
> > This if from PREEMPT_RT log, there*s a long pause in which cgroup_task_=
dead() is not called
>=20
> Yeah, I don't know why. The irq-work is invoked slightly delayed so that
> part is working.
=E2=80=A6
In the good case I have
| systemd-1818  3....2 605751us : cgroup_notify_populated: root=3D0 id=3D23=
82 level=3D5 path=3D/user.slice/user-0.slice/user@0.service/app.slice/ssh-a=
gent.socket val=3D1
|systemct-1911  1....1 620046us : cgroup_attach_task: dst_root=3D0 dst_id=
=3D2382 dst_level=3D5 dst_path=3D/user.slice/user-0.slice/user@0.service/ap=
p.slice/ssh-agent.socket pid=3D1911 comm=3D(ystemctl)
|systemct-1911  1..... 642680us : sched_process_exit: comm=3Dsystemctl pid=
=3D1911 prio=3D120 group_dead=3Dtrue
|systemct-1911  1....2 643423us : signal_generate: sig=3D17 errno=3D0 code=
=3D1 comm=3Dsystemd pid=3D1818 grp=3D1 res=3D0
|systemct-1911  1d..2. 643432us : sched_switch: prev_comm=3Dsystemctl prev_=
pid=3D1911 prev_prio=3D120 prev_state=3DZ =3D=3D> next_comm=3Dsystemd next_=
pid=3D1818 next_prio=3D120

|irq_work-29    1....2 643450us : cgroup_notify_populated: root=3D0 id=3D23=
82 level=3D5 path=3D/user.slice/user-0.slice/user@0.service/app.slice/ssh-a=
gent.socket val=3D0
|irq_work-29    1....2 643457us : cgroup_notify_populated: root=3D0 id=3D22=
29 level=3D4 path=3D/user.slice/user-0.slice/user@0.service/app.slice val=
=3D0
| systemd-1818  1....1 644548us : cgroup_rmdir: root=3D0 id=3D2382 level=3D=
5 path=3D/user.slice/user-0.slice/user@0.service/app.slice/ssh-agent.socket
| systemd-1818  1..... 644784us : sched_process_wait: comm=3Dsystemd pid=3D=
1911 prio=3D120

and in the bad case

| systemd-1828  3....2 312877us : cgroup_notify_populated: root=3D0 id=3D24=
19 level=3D5 path=3D/user.slice/user-0.slice/user@0.service/app.slice/ssh-a=
gent.socket val=3D1
|systemct-1929  2....1 321916us : cgroup_attach_task: dst_root=3D0 dst_id=
=3D2419 dst_level=3D5 dst_path=3D/user.slice/user-0.slice/user@0.service/ap=
p.slice/ssh-agent.socket pid=3D1929 comm =3D(ystemctl)
|systemct-1929  1..... 341432us : sched_process_exit: comm=3Dsystemctl pid=
=3D1929 prio=3D120 group_dead=3Dtrue
|systemct-1929  1.l..2 342623us : signal_generate: sig=3D17 errno=3D0 code=
=3D1 comm=3Dsystemd pid=3D1828 grp=3D1 res=3D0
|systemct-1929  1d..2. 342637us : sched_switch: prev_comm=3Dsystemctl prev_=
pid=3D1929 prev_prio=3D120 prev_state=3DZ =3D=3D> next_comm=3Dsystemd next_=
pid=3D1828 next_prio=3D120

| systemd-1828  1....1 343099us : signal_generate: sig=3D15 errno=3D0 code=
=3D0 comm=3Dsystemctl pid=3D1929 grp=3D1 res=3D1
| systemd-1828  1....1 343102us : signal_generate: sig=3D18 errno=3D0 code=
=3D0 comm=3Dsystemctl pid=3D1929 grp=3D1 res=3D1
| systemd-1828  1..... 343292us : sched_process_wait: comm=3Dsystemd pid=3D=
1929 prio=3D120
| systemd-1828  1..... 343442us : sched_process_wait: comm=3Dsystemd pid=3D=
0 prio=3D120

|irq_work-29    1....2 343725us : cgroup_notify_populated: root=3D0 id=3D24=
19 level=3D5 path=3D/user.slice/user-0.slice/user@0.service/app.slice/ssh-a=
gent.socket val=3D0
| systemd-1828  1....1 90457054us : cgroup_rmdir: root=3D0 id=3D2419 level=
=3D5 path=3D/user.slice/user-0.slice/user@0.service/app.slice/ssh-agent.soc=
ket

Until the sched_switch, everything is the same. But then systemd-1828
(the one with the cgroup_notify_populated event) seems to get impatient
and sends a SIGTERM+SIGCONT. It gets the exit code, the
cgroup_notify_populated event is there later and just once. The
app.slice notify is missing. And the rmdir gets in much later.

Did systemd kill the app.slice at level=3D4? Is this relevant? I don't see
any immediate wake up or signal from within irq_work or
kernfs_notify_workfn() later on.

Sebastian
