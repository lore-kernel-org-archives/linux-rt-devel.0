Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2C18DB35
	for <linux-rt-devel@lists.linux.dev>; Wed, 23 Sep 2026 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122583; cv=none; b=T5TNhUCEi45mUCiM9YnAqmwWHaz56VSFt8T80W0PyHi2e4cI8gl8XSLjJd8Fn83omA2Fi6BupFCoEw7swQwsJ/r/oCQfnU2r0EC+uuuiM9UcaRPFuA67i6DpQF9nzKuEOlcKTje22r05U3Ez+2TxgEp/8Jn66Spcjxbp6u5m4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122583; c=relaxed/simple;
	bh=QpQJ4P+1QuwFIytToYpQ0l1bkWL7uzAhHzRmI1lxObo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD3yyLKAUE7krGwpI+Ml/t3KUSAppYcpCcg/q2oUmdRArrMzAAgD+5OsSKOr9v50M++O825nmPZr+yEm5dTbaLN8/0aZ78WnJI/XCDqNq6U5D5po4lZ2TyGZRGlcLjqCa0obq43kJD42PxTF/48JpfZYS5ST46+HEuC1acTc0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrvD1f7n; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrvD1f7n"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so272108f8f.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 22 Sep 2026 17:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790122580; x=1790727380; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fGaf5/XDGDoLwT4whw7j8UodAPOmfiavhJ5qJSDxFhs=;
        b=YrvD1f7nU6632TJzqWoRsdOdqUf3unnIYVvaWSvSBLfeE3SEaorkaklf+EJpLLFu3R
         FWn7ie7Fhb/mHbnHIUnWzrl5gx4cUIOlOr6sBro2SlWe98INJQFrQMIL+mmNY8KTn+LK
         XJ6emVOPQph6z05VktHdLr8NjTN3in3ZttxlpEZgQi9U6DxVLCIVq7MEolcYKsRh8+I1
         HzSEx6doHKqo5CuN11vQx1xjjfulJHKgWQiImMtby2L6V+rwf4YN0vF79zx6tCODKEZM
         qBnnjYVG39qlugDNXaSK+yhUSh6EosEN5eAp2xyj9IyAk8riokyjCiKvgc46IN7I0xuH
         6GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790122580; x=1790727380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGaf5/XDGDoLwT4whw7j8UodAPOmfiavhJ5qJSDxFhs=;
        b=xQN3zh0lP58UVif3p4FVOCyBAL+QKtbrwrql77CFzjIJp2P9u5MULxnWHdnXFJIswI
         FW12VTSOfkq20qgO8jmSMlLfuuQpHHVepoiqexmrOvC1OjqyJFX9/I+/vkg/NHtAV+Xk
         X+X1N+PqNXk+/9B87BsM/0rRkvLBcREtM4Slw9CGKn1lSVpD7VLi9XJqRoyP7ExpPiCb
         sASWno48T7oYKw2U7hkhwg0e+2sa4wUvLwwDnGH0j2xgQE3daYY1xK0ELUqXS56C1qTG
         c966iHRPTXdMqrMvICozuE5P+uMthZZ4VE1SkRv4ZWiKoXXmrpFupQXeQhM/hbXizzHt
         Y1Wg==
X-Forwarded-Encrypted: i=1; AKwUvByE6gSqyHAztAjI77B4w1emyDr/TXnsUlEVH494CJCqSTBdLqev1Lj4MWw5tPr4ge5ykhjvH8Ndfvy0jcmkeA==@lists.linux.dev
X-Gm-Message-State: AFuF++ko3GNzJmTcnclDojkZq7SAmHdQakOV1yBrWaKPx2E/gmz3vkaH
	/cE/0sSz/jjYj8Ov2kdE9fbeeXEG0n6/H7fGqtzIfmffF0MrlAc7UMpe
X-Gm-Gg: AYBFou3ZPp4w/Im7a8uykm6EhhbXOmwmqMSLjS1e4qN0AIi3aoWdv4VZfmvxbQT7FzP
	eZvGSlx1eVgpLpAYl2UZ3Gf4BBVW5MU5wIXii/2bfzDgvbLKAPbsffIdsW10U2pdOgLhoIOvoJa
	rCSkpfEZA8sUtOFQ43L+l35/kS2nAOHsuLVl0lqgeA5S6Is3zpSCY3bJxeaJJ5VgeU4rz+vIHNn
	Qfuvsn5RqmhBMXSHYw6XsTIltH2Rqts41NesGdTRugKeNB4QNlfTlPS+hBsfU1Ea9gCQAl5myhz
	KlwP3Au15Z9m2UF9nrVEmOYSu1jFrAmcC7X3kFMHTfX5rT9J5ufe94/JRPiaHMXBsH3B6CRPtw1
	k8gr1Zqt3Ya9Ildrwh9zQfRjRjIz07o1gmJA0jJRWoibfF33vtpKNKyDdnl4aKNVKuTem7h2tLt
	qPJQ8hLpl8nnN08+wKI2FpyokFobwiss1jURSDomcf5eUpDziTaIZn5vNmjmjRvFyXdGTXCtIN2
	qHsI683ADZordtyWXUJ11Pm3wB8Xl428lgsfMHMHtI9DUy5tkLKKT1T1x9a0alWHoweZq++Prug
	V4c2986TRuSZm5mK5HR8Wp6b2pzPrej9rt91y3ugnIO20UQVTTQ1KC8FFnfCqSMHNEGBmyjHVtX
	6X49T
X-Received: by 2002:a05:6000:4b14:b0:487:62d:37dc with SMTP id ffacd0b85a97d-488670af97amr1253715f8f.32.1790122579667;
        Tue, 22 Sep 2026 17:16:19 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a5e6-3401-f8e1-409a-a02d-633a.310.pool.telefonica.de. [2a02:3100:a5e6:3401:f8e1:409a:a02d:633a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877970fsm2152470f8f.24.2026.09.22.17.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 17:16:18 -0700 (PDT)
Date: Wed, 23 Sep 2026 02:16:14 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] softirq: Preserve interrupt context during IRQ exit
Message-ID: <arMXH87-cd5U5DS1@gmail.com>
References: <20260905023210.82853-1-kmehltretter@gmail.com>
 <20260917152150.dvEKJ8B3@linutronix.de>
 <20260919075105.34023-1-kmehltretter@gmail.com>
 <20260921135015.edLXthz6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921135015.edLXthz6@linutronix.de>

On Mon, Sep 21, 2026 at 03:50:15PM +0100, Sebastian Andrzej Siewior wrote:
> The "important" part is this fixing something that is broken today or is
> it just avoiding fallout. We don't have any memory allocations/ locking
> in the mentioned window as far as I know. That would fix things, just
> avoid fallout.

Instrumentation sees the wrong context today, the rest is avoiding
fallout.

There is some locking in the window though. With threaded interrupts,
and always on RT, the window wakes ksoftirqd and ktimers. The tracepoints
of those wakeups then run as if they were in the interrupted task. On RT
can_spin_trylock() does not refuse in there.

> > -Woverflow is on by default. I'll swap the operands:
> 
> Is this some gcc-17 thing? I don't remember that I saw it and I did test
> that.

gcc 15.2. Without the casts x86_64_defconfig fails here, because it sets
CONFIG_WERROR:

  include/linux/preempt.h:78:25: error: overflow in conversion from
  'long unsigned int' to 'int' changes value from '18446744073692774656'
  to '-16776960' [-Werror=overflow]

clang 21 warns as well (-Wconstant-conversion). With the operands
swapped the value is positive and fits an int, so no cast is needed.

> > HARDIRQ_OFFSET after the addition. In softirq_handle_begin() I will move
> > lockdep_softirqs_off() before the assertion. Then the lockdep softirq
> > state is consistent if the assertion fires and printk runs.
> 
> Right. I mean you have one state and this what you want test for. I
> don't think it make sense to test before and after arithmetics.
> I am just not sure if those warnings should be hidden behind
> CONFIG_DEBUG_PREEMPT similar as preempt_count_add() does it. Maybe it is
> not hot-enough-path to worry about it.

I'll keep them for now. They only run when softirqs are handled on irq
exit, so much less often than preempt_count_add(), and the softirq
handlers run right after them. With both checks softirq.o has 8 more
instructions on x86-64 and 11 on arm64 on that path.

> > Yes, that is the intent. irq_count() would skip the wakeup when the
> > interrupt hit a BH disabled or softirq serving section. The old test
> > did not skip it, and nothing else handles pending_timer_softirq.
> 
> I am slightly unsure but I think we want the wakeup of the timer thread
> even if we are in a bh-disabled section. If the current task is a
> SCHED_OTHER then the wake-up preempt it. If the thread is already woken
> then the wake-up will do nothing.

Yes. I'll use !in_nmi() && hardirq_count() == HARDIRQ_OFFSET, without
softirq_count().

> > Today the wakeup already runs before the rearm when no softirq is
> > pending. Does the old order have a reason that I do not see? Then I
> > keep it and document that the timer thread handles such a softirq.
> 
> This only matters for the threadirq case. Here invoke_softirq() will
> only wake ksoftirqd and wake_timersd() will only wake the ktimers
> thread. There will be no new softirqs added to the mask. This currently
> is an ugly catch-all for both sides. Ideally only the softirqs raised by
> task X should be handled by task X but the first one will do everything.

OK, I'll drop that change.

Thanks,
Karl
