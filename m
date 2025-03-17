Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33221D5B7
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Mar 2025 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200320; cv=none; b=IkUIj6QEXXQlHteTFCTXRx+QFAGQzAH3/vaHaGgdoCeAnLtJuOHKsV9Vfupzn/tDZtGIrjlPgeiZI0ElPSiEmRxVz0VDfzEPZhDjE/mB6F9RTs/74d7AkPvet3sQYK2iJDIiSi+xho45TbCRLAElBvrqY5gaAz6piyqqqcvWn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200320; c=relaxed/simple;
	bh=hVufP56gIqL/ekQh0Ds15+CJcC0jnI0bgl9xwOQs8v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRzrneIEvH+0oUehW9PfHLTXTqv+1PMuYgn+IK65maB+LFSTKRrYGr/xBcYkZ7aQIguTPG+rb+06twWAKAf1sovgP3FH6wJQ/18SnDQP4zNH+XUL/RJge8YDuKmOGGSpcmRKWk5wOH7JnbfFKu//Lx2xqgtdzg4wMBKPKzYynzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=13281Oum; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RneW/ph2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="13281Oum";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RneW/ph2"
Date: Mon, 17 Mar 2025 09:31:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742200317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJcBiNdm6rRo1qlHMjH21yTF+yAq1TpHJW2IXXtA4SM=;
	b=13281OumgzsV2OQ6Ka2kcd9jgAzyXguf91lBZAEw4lDBfljzKhBOuXauByPxgkarfCy1BR
	iK8CPoGshgTic4DrTgp5hvX6EWYWlYgml5AS4swD2huzCJPXujFnO7VPSFHWuDi1A/3S8D
	N8u0fzhNzEG92afD0kxOpKwN+SE+zy+DQfkv8rKasNvKAzUZFO4V30D/wytWKHoaFlqoyW
	K6crErUOk0ERaPlw57zLcWNTRijwFhk1GMtGtE0yfAiS5EQ5VAH7gu4pYXXbPrUh7nrvTy
	xRSzENnQJr1ThHU/8vLf7oBjQ+t/Eop1FXW3z02oZxzHytwqOL5NWgRlREzZ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742200317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJcBiNdm6rRo1qlHMjH21yTF+yAq1TpHJW2IXXtA4SM=;
	b=RneW/ph23+saTEgYSWKSiZcsvPosJi2wRWszioBpUgilf2iB+o0KWSsiQ3nkzqA5kvHjD0
	T7lsH36JL+hUZEDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 1/9] sched: Add a generic function to return the
 preemption string.
Message-ID: <20250317083155.9g9ksofZ@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
 <20250314160810.2373416-2-bigeasy@linutronix.de>
 <Z9ay49NsoC73dKXe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z9ay49NsoC73dKXe@gmail.com>

On 2025-03-16 12:15:47 [+0100], Ingo Molnar wrote:
>=20
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>=20
> > +const char *preempt_modes[] =3D {
> > +	"none", "voluntary", "full", "lazy", NULL,
> > +};
>=20
> > +	/* Count entries in NULL terminated preempt_modes */
> > +	for (j =3D 0; preempt_modes[j]; j++)
> > +		;
>=20
> I'm pretty sure the build-time ARRAY_SIZE() primitive is superior here. ;=
-)

It would be but it is not an option.
That array is defined in core.c where it is "always" required while
debug.c needs it optionally. core.c is its one compile unit while
debug.c is included by build_utility.c. So I don't see how this can work
unless we shift things:

|   CC      kernel/sched/build_utility.o
| In file included from include/linux/kernel.h:16,
|                  from include/linux/cpumask.h:11,
|                  from include/linux/smp.h:13,
|                  from include/linux/sched/clock.h:5,
|                  from kernel/sched/build_utility.c:12:
| kernel/sched/debug.c: In function =E2=80=98sched_dynamic_show=E2=80=99:
| include/linux/array_size.h:11:32: error: invalid application of =E2=80=98=
sizeof=E2=80=99 to incomplete type =E2=80=98const char *[]=E2=80=99
|    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_=
be_array(arr))
|       |                                ^
| kernel/sched/debug.c:250:13: note: in expansion of macro =E2=80=98ARRAY_S=
IZE=E2=80=99
|   250 |         j =3D ARRAY_SIZE(preempt_modes);
|       |             ^~~~~~~~~~

> Thanks,
>=20
> 	Ingo

Sebastian
