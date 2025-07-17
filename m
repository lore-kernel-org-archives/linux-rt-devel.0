Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606C2F6FA3
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Jul 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764262; cv=none; b=n9L7BdH6vG6oY6AlBfj99biEaBxL1RUd2TPYlaRjy6wb1n5OSJ5t3Zt7+9nbPy0h3VVDAc+xAC2AJGH3uQCyVvWa6Yi1rCfjV8ly7V9CpMtSV9BBvPc9LFfJlu1RiXC7TH9d5Fi1Azcyujti/19YCXiNZhFonMyaRbICC0zgUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764262; c=relaxed/simple;
	bh=TjJPZjE7LvO6jqYIZfxsmaHsQ8zr8JbRj3GYZAqIXh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBbGYW/vu3cdlABH42JBGFM/a8L4hvTv9z7CiMCMGd2TCvNy0gU6T1WD9TlC+HvIkomTmG3wdY+hs78THUeSlmet8nvjQczuoiacLoNMAEJpXg2lOaFK2CqdGRsEzm+Ux8yQi8//Z9C1zkKnUK0cjJIBG8I46gG3G1hW69aMxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URlX8RWu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URlX8RWu"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45555e3317aso6665415e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Jul 2025 07:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752764259; x=1753369059; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJgeoNdML9iq51bMxNPeinGnnB+OEInhGxDVHOGA/Qs=;
        b=URlX8RWuZ2wAvcsdaSEVy7noUhtUa+U/2xHCq2gc8s8kGTZ/EIyvSLclOZw8rktLCT
         egVx4xjvLFcx2JXmZAieKJDPoX67uC0DW5jzhCLA8eveKD+CP7hZaxK8sBkXeQxIqDV4
         UKSWYNc2TPDL3ySrZh4QZr+FNYPFfruLYX7tP397rH3JWKUTsxNh7V4SOeIZ5NZ2FtHN
         62vEN8/OgFbm0USrXSHb85yHJ3oyxlup2glXj29Ald4ErorRjeefUV1B2AoF2CW5rLpI
         LBrbcPEQRaQABjO6tTu+ZZ5Lj9CJnvXsu5chcd4b6ENrcLBa5y+U7OjfH5F02c1sb4xW
         9zyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764259; x=1753369059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJgeoNdML9iq51bMxNPeinGnnB+OEInhGxDVHOGA/Qs=;
        b=iO4etUiBDYR0Xf8FCZvd1Pr3I+68FU8V8x3SwCS6+a5cr+oMjmRjhSPWuTcX+GikXS
         mszQemvxv3oe3tQ3zt2TtxQVR9mkfS9eWsGLhNRWOZZ5CnVbuXbx+5Z2f9d91QI54S/y
         wpGDql5k9jhgc4OgbiYOsMY+tnekpn38tRtAIPg+5uSmYxDU7tJoGyjfJoTwvxaRLAdS
         idwJpYMT4DiGWGl6hkJg6by5XH6Nn/sPfOnSeDCmWauLrI6hniPs9SqZ541Rk6NbmWsR
         SvCszenx41KTXXkq6IEPHepxQ1Qjr51+w9oniIlzdrLFPvtPNN802riBSyRvh9YTNM+q
         xTjw==
X-Forwarded-Encrypted: i=1; AJvYcCUAQUXkUx82YrR5DcUqVgk+nDDi9wympuhaNeoi/T+6NYysZUxozMFtCxjn+0n+FS4mKf5yJ1hVSCi7/3hD0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxECt640uDv1CQPF7Diti1dBuohfPzD5MMLj2TVCJbLToBDZvB1
	L0THahuicLm4WnSwh7UM2DZ6UoEUnn6kLNNPHI7V6mB6QusElzZxLALZ+mv+5TZ2l96R5B1Sani
	LDAfyKszz0wo2bHoXvTqyBhj+n4WENxM=
X-Gm-Gg: ASbGncssSPioiiPTIR9xhk+3cQ3urkosg10vseSWaaL3Y/eoDQDPeZ9wPWZ7tUpZBhe
	osfEo/bSZyxVHcdybYHizwfToEseXxgKHJziFFIhWmeIx7YFQOkZSVIqOIorTGQSaTE3b1Z+Sd9
	cji+uUQX25zrPOGg/VsoSLp1Q5kca5FN33Gk4+G0LMoFkyg/mrIiz2hL/9jWnxzhKIDowL7+EL+
	fDcxrQ/GcmGq1dkR839DJQUcw7TxtYOBg==
X-Google-Smtp-Source: AGHT+IFVOPWj5ugE6UY0h+KfdvbEFS7sthBRunlQl5uPPpmwXPciExUEPVS27TcOmmVOb9O1RSZY2960vCa1Erl09Dw=
X-Received: by 2002:a05:600c:4e4a:b0:456:28f4:a576 with SMTP id
 5b1f17b1804b1-4562e391fb0mr70054165e9.27.1752764258422; Thu, 17 Jul 2025
 07:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop> <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop> <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop> <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop> <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop> <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
In-Reply-To: <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 07:57:27 -0700
X-Gm-Features: Ac12FXy5AFevRfwhfAmaQeo4LydVWcXQknsIDwZ-nKzOVg4wL8MqRTNLukqIhwQ
Message-ID: <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 6:14=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-07-16 18:54, Paul E. McKenney wrote:
> > On Wed, Jul 16, 2025 at 01:35:48PM -0700, Paul E. McKenney wrote:
> >> On Wed, Jul 16, 2025 at 11:09:22AM -0400, Steven Rostedt wrote:
> >>> On Fri, 11 Jul 2025 10:05:26 -0700
> >>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >>>
> >>>> This trace point will invoke rcu_read_unlock{,_notrace}(), which wil=
l
> >>>> note that preemption is disabled.  If rcutree.use_softirq is set and
> >>>> this task is blocking an expedited RCU grace period, it will directl=
y
> >>>> invoke the non-notrace function raise_softirq_irqoff().  Otherwise,
> >>>> it will directly invoke the non-notrace function irq_work_queue_on()=
.
> >>>
> >>> Just to clarify some things; A function annotated by "notrace" simply
> >>> will not have the ftrace hook to that function, but that function may
> >>> very well have tracing triggered inside of it.
> >>>
> >>> Functions with "_notrace" in its name (like preempt_disable_notrace()=
)
> >>> should not have any tracing instrumentation (as Mathieu stated)
> >>> inside of it, so that it can be used in the tracing infrastructure.
> >>>
> >>> raise_softirq_irqoff() has a tracepoint inside of it. If we have the
> >>> tracing infrastructure call that, and we happen to enable that
> >>> tracepoint, we will have:
> >>>
> >>>    raise_softirq_irqoff()
> >>>       trace_softirq_raise()
> >>>         [..]
> >>>           raise_softirq_irqoff()
> >>>              trace_softirq_raise()
> >>>                 [..]
> >>>                   Ad infinitum!
> >>>
> >>> I'm not sure if that's what is being proposed or not, but I just want=
ed
> >>> to make sure everyone is aware of the above.
> >>
> >> OK, I *think* I might actually understand the problem.  Maybe.
> >>
> >> I am sure that the usual suspects will not be shy about correcting any
> >> misapprehensions in the following.  ;-)
> >>
> >> My guess is that some users of real-time Linux would like to use BPF
> >> programs while still getting decent latencies out of their systems.
> >> (Not something I would have predicted, but then again, I was surprised
> >> some years back to see people with a 4096-CPU system complaining about
> >> 200-microsecond latency blows from RCU.)  And the BPF guys (now CCed)
> >> made some changes some years back to support this, perhaps most notabl=
y
> >> replacing some uses of preempt_disable() with migrate_disable().
> >>
> >> Except that the current __DECLARE_TRACE() macro defeats this work
> >> for tracepoints by disabling preemption across the tracepoint call,
> >> which might well be a BPF program.  So we need to do something to
> >> __DECLARE_TRACE() to get the right sort of protection while still leav=
ing
> >> preemption enabled.
> >>
> >> One way of attacking this problem is to use preemptible RCU.  The prob=
lem
> >> with this is that although one could construct a trace-safe version
> >> of rcu_read_unlock(), these would negate some optimizations that Lai
> >> Jiangshan worked so hard to put in place.  Plus those optimizations
> >> also simplified the code quite a bit.  Which is why I was pushing back
> >> so hard, especially given that I did not realize that real-time system=
s
> >> would be running BPF programs concurrently with real-time applications=
.
> >> This meant that I was looking for a functional problem with the curren=
t
> >> disabling of preemption, and not finding it.
> >>
> >> So another way of dealing with this is to use SRCU-fast, which is
> >> like SRCU, but dispenses with the smp_mb() calls and the redundant
> >> read-side array indexing.  Plus it is easy to make _notrace variants
> >> srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace(),
> >> along with the requisite guards.
> >>
> >> Re-introducing SRCU requires reverting most of e53244e2c893 ("tracepoi=
nt:
> >> Remove SRCU protection"), and I have hacked together this and the
> >> prerequisites mentioned in the previous paragraph.
> >>
> >> These are passing ridiculously light testing, but probably have at
> >> least their share of bugs.
> >>
> >> But first, do I actually finally understand the problem?
> >
> > OK, they pass somewhat less ridiculously moderate testing, though I hav=
e
> > not yet hit them over the head with the ftrace selftests.
> >
> > So might as well post them.
> >
> > Thoughts?
>
> Your explanation of the problem context fits my understanding.
>
> Note that I've mostly been pulled into this by Sebastian who wanted
> to understand better the how we could make the tracepoint
> instrumentation work with bpf probes that need to sleep due to
> locking. Hence my original somewhat high-level desiderata.

I still don't understand what problem is being solved.
As current tracepoint code stands there is no issue with it at all
on PREEMPT_RT from bpf pov.
bpf progs that attach to tracepoints are not sleepable.
They don't call rt_spinlock either.
Recognizing tracepoints that can sleep/fault and allow
sleepable bpf progs there is on our to do list,
but afaik it doesn't need any changes to tracepoint infra.
There is no need to replace existing preempt_disable wrappers
with sleepable srcu_fast or anything else.
