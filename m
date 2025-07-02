Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B82F508D
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Jul 2025 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476162; cv=none; b=D7jF2NjVXPUwWYXkNOtXes07XtI5kF4hPeZ6/CxRKoQ95tjrQE81ToGKqeL2I5mmtzfRuAk5jzFGoa1tRwcqZjImR/rkL1GzxRyvwkt8G55/EBYN8HvQX/9T20DQTlRukYXGNed8Mj8+ruyTDeTx7Rb4/DD9PaG0gHtcczuh7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476162; c=relaxed/simple;
	bh=NsWlTB8yMod+8yMKM8n6UgGR91Ftf1yT2Mvm5Fsu9KI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Otdtwmjml1hbyF8l6Uv/C3UW054Ode2TnW+PgiiPrb4R5FjkbJbMlKX68ilCr2HsUlU/OReN9Hqgaui35CZfbelxQsxdLv7DfJrbJi8YAcC1J9AJc6+RiN4Sv6M+4wlMfH2tPo2848VC+MLBZ4nSFAe/qhzPLjCx29c7q4rXiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 3162610635E;
	Wed,  2 Jul 2025 17:09:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 5DE8E2002E;
	Wed,  2 Jul 2025 17:09:10 +0000 (UTC)
Date: Wed, 2 Jul 2025 13:09:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "=?UTF-8?B?xaBpbmRlbMOhxZksIEppbmTFmWljaA==?="
 <JindrichSindelar@eaton.com>
Cc: "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "ryotkkr98@gmail.com" <ryotkkr98@gmail.com>
Subject: Re: softirqs causing high IRQ jitter
Message-ID: <20250702130909.0bc4702d@batman.local.home>
In-Reply-To: <SA1PR17MB5553039BCE5C4C1A68CEFB87D740A@SA1PR17MB5553.namprd17.prod.outlook.com>
References: <SA1PR17MB5553039BCE5C4C1A68CEFB87D740A@SA1PR17MB5553.namprd17.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 79h9ms1i9b5dcpfbsg4x9hk5ob3ztcj9
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5DE8E2002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX184snDrwtrFWu3Fgt400wq/b3jLJBa0Sg0=
X-HE-Tag: 1751476150-304264
X-HE-Meta: U2FsdGVkX19qAys2RLNghjyKmMQU+FcX26h9EkoCCb0GlvPzaqwLBM/x3jQP4GPNkqrGrNuAv6LAR0hKw5OLPX9Mr6bawaP4twccqVBLU8C+gri8VFOe5O73N5psUIqB0tC+tFzpXZ/BE9lfbc9friEwN1eFevx6vjsYYXhSqkXErfn7ixUBzdNB62hSRchHCUzZyai+UzVZEpFovManlIfcvOOFjUUtk6GLvsQvGn2y8KeFjTe3wzhB8+Y2xvqjRk/Sl4cHMtNg+xtWITWbHhzfrtHB1Jk3/Px4R/FN/ciT0N93bS3qM1GYLzC6dyjAIkNUKKhA+bHXoDaEGkWjmrjF5uii1PIhdhC99yHhOtLzuBlhCsTAAXdIrWwEmo0tBFBpEO4hN9SelutqRLqJag==

On Wed, 2 Jul 2025 14:51:37 +0000
"=C5=A0indel=C3=A1=C5=99, Jind=C5=99ich" <JindrichSindelar@eaton.com> wrote:

> Hello,
>=20
> This is my first post here, hope everything is right with it :)

Welcome!

>=20
> Our team is observing high jitter in certain IRQ handlers on a PREEMPT_RT
> kernel, and we have pinned the issue to softirqs. However, we're not sure
> how to address the problem. I'll describe the situation first, sum up how
> I understand things, and ask questions at the end.
>=20
> We have an embedded system with the NXP i.MX6 single-core SoC, and our
> kernel is based on linux-stable-rt v5.15.163-rt78. Our modifications are
> rather small and don't touch anything softirq-related.
>=20
> All of our IRQ threads are running at the default priority of 50
> (SCHED_FIFO). There are also several user-space application SCHED_FIFO
> threads - some above, some below the priority 50. We also noticed that the
> application is raising the ksoftirqd priority to 60 (SCHED_FIFO), based on
> recommendations from an external supplier - the reason being the ability
> to handle TIMER and HRTIMER softirqs with minimal latency and jitter.
>=20
> We observe that a UART "Tx complete" IRQ occasionally comes late, causing
> unacceptable jitter in the communication. There are actually more threads
> involved (SDMA IRQ, its tasklet, and UART "Tx complete" IRQ), and any of
> these can come late.
>=20
> We did some experiments and debugging through GPIOs and found that when
> the UART "Tx complete" IRQ comes late, it is when there is a bunch of
> softirqs processed in a row. We set a GPIO when entering the loop in
> handle_softirqs() and clear the GPIO when leaving it. The pulse we observe
> on that GPIO when it delays the UART IRQ can have a length of a few
> hundred microseconds.
>=20
> Furthermore, we found that in v6.6.12-rt20, an additional thread has been
> introduced to primarily handle the timer-related softirqs
> (https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/co
> mmit/?id=3D7f49c1dd9ab0c9f23c526f58241d6cc9d50f1778). We thought this mig=
ht
> be helpful in our situation, as we could leave the ksoftirqd thread at
> prio 1 and set the timer thread prio to 60, as requested by the
> application. We backported the patch, and it did improve the situation,
> but it didn't resolve it completely. The IRQs we're interested in still
> come late, but it's now more seldom. My understanding is that, despite the
> claim in the commit message, the timer thread is not really dedicated to
> timer softirqs only. It gets woken up when a timer softirq is raised, but
> it will also handle any other softirqs that are pending at that moment.

I think you may have found the main issue. That is the timer softirqd
will pick up other softirqs that are pending. Yes it is a separate
thread and will wake up to handle softirqs when the timer softirq needs
to be handled but I don't see anything limiting it from handling other
softirqs.

This looks like it could be an enhancement to have the timer softirq
only handle timer softirqs. But unfortunately, I don't have the time to
implement this. Perhaps somebody else?

-- Steve


>=20
> Additionally, the pending softirqs can also be executed in the context of
> any threaded IRQ. So even if there was an isolation where the timer thread
> handles (hr)timers only, the other softirqs could still cause unacceptabl=
e jitter
> in IRQ handling. In my understanding, the whole thing gets even more
> complicated by priority inheritance - even if softirq processing gets
> started in the context of a ksoftirqd thread with priority 1, its priority
> may get PI-boosted when a higher priority thread runs into a lock held by
> ksoftirqd.
>=20
> Please correct me if any of my understandings or observations mentioned
> above are wrong. Now, I'd like to ask these questions:
>=20
> 1. In our view, not all of the softirqs have the same priority: e.g.,
> (hr)timers and tasklets seem important, but things like NET_RX, NET_TX, or
> BLOCK less so. Would it be a bad idea to try to introduce a more selective
> approach, where a certain type of softirqs can only be executed with a
> defined maximum priority? This could make more sense if we introduced some
> IRQ priority partitioning instead of leaving all IRQ threads at prio 50
> (we're considering this step as well).
>=20
> 2. Several of our peripherals use a DMA (our SoC actually has 2 different=
 DMA
> blocks), and we noticed that the dmaengine is using tasklets to execute
> the DMA callbacks. This means the callbacks can be executed in the context
> of an arbitrary thread (and thus arbitrary priority). It feels quite
> strange to me, especially because the DMA callbacks can further
> "cooperate" with other IRQs (such as enabling the "Tx complete" IRQ of our
> UART). I understood that tasklets are deprecated and it's recommended to
> use BH workqueues instead. Is there a reason why we shouldn't modify the
> dmaengine (which I see as a very important component in the system) to
> make it use BH workqueues instead of tasklets?
>=20
> 3. Do you have any other recommendations on how we should configure and
> balance our system? Setting different priorities to individual IRQ threads
> based on how critical we see them looks quite straightforward, but the
> fact that pending softirqs can be executed in the context of an arbitrary
> IRQ thread still makes it look nondeterministic.
>=20
> Best regards
> Jindra
> ________________________________
> Eaton Elektrotechnika s.r.o. ~ S=C3=ADdlo spole=C4=8Dnosti, jak je zaps=
=C3=A1no v rejst=C5=99=C3=ADku: Kom=C3=A1rovsk=C3=A1 2406, Praha 9 - Horn=
=C3=AD Po=C4=8Dernice, 193 00, =C4=8Cesk=C3=A1 Republika ~ Jm=C3=A9no, m=C3=
=ADsto, kde byla spole=C4=8Dnost zaregistrov=C3=A1na: Praha ~ Identifika=C4=
=8Dn=C3=AD =C4=8D=C3=ADslo (I=C4=8CO): 498 11 894
> ________________________________

