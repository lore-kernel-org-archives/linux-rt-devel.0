Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E073043DB;
	Wed, 12 Aug 2026 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530995; cv=none; b=EgGdn5L8Y/M+phobAaisSsAUbwztDh2Fqf92czUFcq9/nL6SL7c17iifBN7LROKyfi3PCxeIe89YovKIhp0rLlthRcfFKzEMW4JTr6nkXWbKimVj2I+f2Y9nZ2hzJBd33IuNZAPnlbA4wL42EKQLUkpOip2z7Ao5AtMYFhCIa3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530995; c=relaxed/simple;
	bh=/Ft4r5DzH9kh3zjsTyNdRTZxLyUywX4Wxogccz6YMO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhCoY9OSDKO6gDdoVVrbsIuVqTBc6SNt97qlLHyxMgiOGnRuArztuDRN3T+NZOvki5Ia8to+ho8eq7flyucIBMnV/aV0QIPIFI07twyGOBHT7UmptsNPlKLvHvZH4h9Amcu3iMuRG/s8ogc3aijbVTODxnDlg6SjDY1tRiClPOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KuBz3oI/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KuBz3oI/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d5RBwZyUS6Le2BNs48LkPOz/vGZX9KDv+t0EJBSo89I=; b=KuBz3oI/lXJYGpZoQXy5h5m5iU
	qEIPspjv3jYP00Wj8bPjrxvFLaG9Ch3J1JRPrLL/GTNn1m55eJ8UoMUhsz87u6XnNYf7Xs8M2gna0
	bPAO2pPoeqP5teA0vv1uNHXGzSJ1tNfp1+WddDs9Nqnx74eeKEAwJWw5SLMXvSXup/qvd4Si4nP6R
	Q45+OMC6dT9f6CeU/7WL3C+PHhquVZ7a1ItZSMY9uGf8rilpW390fL/3fnYXnhY6N9DDl/uQAsiuh
	yQITbMlT2xrGiPvAetP9LO2VEgm5uGB1lmljHMEgNfsXGGBY7AF2MRSF8J8s3XfHfvFhasbm3mUnx
	v5zv7sIg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wu6Jq-0000000FJ6K-3Uzy;
	Wed, 12 Aug 2026 10:36:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 571E8300382; Wed, 12 Aug 2026 12:36:21 +0200 (CEST)
Date: Wed, 12 Aug 2026 12:36:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] kcov: Suppress timer and scheduler coverage leaks
Message-ID: <20260812103621.GJ776954@noisy.programming.kicks-ass.net>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
 <60A84278-D257-4815-8CB0-8247DEDDA339@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60A84278-D257-4815-8CB0-8247DEDDA339@grrlz.net>

On Tue, Aug 11, 2026 at 08:59:41PM +0100, Bradley Morgan wrote:
> On 11 August 2026 16:41:05 BST, Karl Mehltretter <kmehltretter@gmail.com>
> wrote:
> >KCOV aims to exclude interrupt and scheduler coverage so syscall coverage
> >stays input-dependent. Instrumented callees can still record when
> >uninstrumented timer and scheduler paths run with in_task() true.
> >
> >With the diagnostic patch in [1] applied, CONFIG_KCOV_SELFTEST exposes
> >three cases on x86-64: deferred hrtimer rearm, __schedule() callees and
> >PREEMPT_RT wakeups. Task-context wakeups and new-task enqueue also add
> >scheduler coverage to ordinary syscalls.
> >
> >Add a nestable KCOV_PAUSED bit and a kcov_pause guard. Use the guard for
> >deferred hrtimer rearm, __schedule(), the try_to_wake_up() wakeup body
> >and wake_up_new_task(). This suppresses their instrumented callees
> >without excluding those callees from task-context coverage.
> >
> >Changes in v2:
> > - Add patch 1 to make kcov_start()'s mode parameter unsigned int. No
> >   functional change.
> > - Rework patch 2 around a guard-only API with private current-only
> >   helpers (Bradley Morgan).
> > - Use the guard in patches 3-6 and reword the pause comments.
> >
> >v2 testing:
> > - GCC builds on x86-64, arm32, arm64, MIPS32/64, PowerPC 32/64,
> >   s390, RISC-V 32/64, LoongArch, Xtensa and UML.
> > - PREEMPT_RT builds on x86-64, arm32, arm64, RISC-V 32/64 and
> >   LoongArch.
> > - x86-64 builds with GCC 8.1 and Clang 22.1. Both kernels passed a
> >   KCOV selftest boot.
> > - x86-64 CONFIG_KCOV=n build, with no KCOV or pause references.
> > - KCOV selftest, 10/10 x86-64 boots with and without PREEMPT_RT. A
> >   fresh non-RT boot passed after the helper-only rework.
> > - 40 dummy_hcd/g_zero remote-KCOV cycles on x86-64 and arm64.
> > - 400 repeated fork() calls on x86-64 PREEMPT_RT.
> >
> >Three one-hour syzkaller A/B pairs were run. Each baseline and patched
> >run used four 2-vCPU PREEMPT_RT VMs. The patched kernel completed 22-51%
> >more executions than base. At matched execution counts, corpus size grew
> >42-54% and coverage 14-19%. No run produced a report.
> >
> >With KCOV disabled, the pause sections compile away. With KCOV enabled
> >on x86-64, GCC 15.2 grows __schedule() by 117 bytes,
> >try_to_wake_up() by 94 bytes and wake_up_new_task() by 88 bytes relative
> >to the base commit.
> >
> >[1]
> >https://lore.kernel.org/r/20260724192122.73080-1-kmehltretter@gmail.com
> >
> 
> 
> Reviewed-by: Bradley Morgan <include@grrlz.net>

Plonk
