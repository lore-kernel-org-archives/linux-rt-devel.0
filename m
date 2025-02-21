Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFD2AD0F
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Feb 2025 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103469; cv=none; b=XMf5A2rsJBq6C63VXe/0otstkjJyUZdAqWbUHmn+FPlasjdAhM8kE1gq55KTlNGNYw614dbzIiuT5ttEyk4t6PJWZG9csKMeb5TXALxaQrlGZGjSmq1dNUHrTh3tYnG9CNPDjEOi1aZhzEeg+d2b75/fJrBPBJ6Y2nj4kOmytLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103469; c=relaxed/simple;
	bh=N1yHkd6WcyNSVQbGsYczlSizRGhxXsmcqx1x0a+rzi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEDhL2p/1GCq+LA/vs3zsOOOCdQlfLAxXF7ygrNIGVQb4BkhIJbHb9jYQjmJro3xxOIPp5fiDiQ+QQlXsyKANv4fpjc+d7LxR0FLs7DXGaTxBhSoeXaThpIvQl7g32P1GiWRO8LyPm4bYErDer5IZNCeadQTCOIPlU8IP8P433A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpPC+nKm; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpPC+nKm"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-472098e6e75so88921cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 18:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740103466; x=1740708266; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1yHkd6WcyNSVQbGsYczlSizRGhxXsmcqx1x0a+rzi4=;
        b=jpPC+nKm6QKkrRJSeDyzdWkyS67LuocL/+ltToGX74Jk4hC2Ectx5VI3dYdrUSy2RL
         n3dcD/cfIVQo2sTXMyhAZxpQOo3tW9WNv2+8PdLvYBjDoVaxoADl4gK8iSwgRc/7Tf2H
         y7sfxkO0DJhUlQO53sUhEFBNIiTtR20+a1KPQJMTp2EDqC35OpRuplJzAo9PS3xVTYjm
         O6LbB8a7M/85rcK5lu4viiVdVSZBIsuNIPBkzryCQhxWsoeS3rVnv3b7j5kBeMn5xADY
         M+SDFjfxbv+aDbHNnG2ssn1N1IQ78Vg6hto5UzC4NvglnmQwfri7H//9vjPc5Iv/Erba
         mEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740103466; x=1740708266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1yHkd6WcyNSVQbGsYczlSizRGhxXsmcqx1x0a+rzi4=;
        b=BGTyGiu7ymFFrykkl/a1nT6MEnrNpJhBj1IETF0FNOrbVYXg2YYAc9l0Nvx3TH/XZQ
         77WaQaCg6fjcOCXDBfAttg4t8I9xNWt3A8MKio53Ys5+BAAqKp5W4WNrBrDdbtt4KZox
         sxZ4e/XaWgr1dpMwnKGcLgsT5arFnjlTjTvT61/OOeebbn8wFB9FRNEELZBYYWkqiTtU
         7YQgoUYUecWIjjxr4P9VsW8TqaDVWP79DJDam2sLiAGhKIGIXqZ3qS35VYMfdYnKrsLv
         sSeY6ft+3+3bmf91MHW+RLVfric1LO6g/tdrA7JPCTHUtft4fNDXXGch1+ykG09zL84u
         rSag==
X-Forwarded-Encrypted: i=1; AJvYcCWyOGj4R9j0pjf3O1Vfq6zjSMAyWJooTh2CywCL7l8XvbNScqpf1hXou3ERn+Fv5UhTogm0AF8FzaKctvE/Fg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhLFXIXFp9IDrlDuZGJB6Ualqm452/KfNfe1gWLQtof9K9IVwX
	5fR6lK6Gl06pCFkGl9I4omHwK3FhFkYWSHcmHv48yIWAv5B2B6pzE7TxYBEBfSrrrXHkb3vor9Y
	NNYj0Ex+XCGk5fMUWF8eUpjUoLNdpdnII2lPM
X-Gm-Gg: ASbGncvv1W9bpG+HzahyJwJdQ1o1uflYPXbZaF3hNdC8B7D3xTNHjbbR0iAiu1WQY1c
	DlLaXSGlMKqGwLeIU3ZulSwitIkVsF0at7/a60K/ip3/KN81+AVqnC/gxb/RnQQpCZQhza5wcky
	wCsvAdyc2y
X-Google-Smtp-Source: AGHT+IFShkeKNa7hBQxM8WJImL27ya3TaFWjy9t41mcSCg8PXCJXsgBgjYpdo+tD3SDjLtFIoBf92VZ9oD1/FNTlZj0=
X-Received: by 2002:ac8:5a10:0:b0:471:9ece:b13b with SMTP id
 d75a77b69052e-47225043af1mr904521cf.1.1740103466046; Thu, 20 Feb 2025
 18:04:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220093257.9380-1-kprateek.nayak@amd.com> <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com> <20250220113227.GL34567@noisy.programming.kicks-ass.net>
 <59d46dd3-33da-4e95-8674-d93fc00d73f6@amd.com>
In-Reply-To: <59d46dd3-33da-4e95-8674-d93fc00d73f6@amd.com>
From: Josh Don <joshdon@google.com>
Date: Thu, 20 Feb 2025 18:04:14 -0800
X-Gm-Features: AWEUYZkezBZ_8B7pnQOk5D6fE9Yi15jahsKLRimXrfXwGO-40LmlcMoAEdkjKjc
Message-ID: <CABk29NuQZZsg+YYYyGh79Txkc=q6f8KUfKf8W8czB=ys=nPd=A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ben Segall <bsegall@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Barret Rhoden <brho@google.com>, 
	Petr Mladek <pmladek@suse.com>, Qais Yousef <qyousef@layalina.io>, 
	"Paul E. McKenney" <paulmck@kernel.org>, David Vernet <dvernet@meta.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:04=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> Hello Peter,
>
> On 2/20/2025 5:02 PM, Peter Zijlstra wrote:
> > On Thu, Feb 20, 2025 at 04:48:58PM +0530, K Prateek Nayak wrote:
> >> Any and all feedback is appreciated :)
> >
> > Pfff.. I hate it all :-)
> >
> > So the dequeue approach puts the pain on the people actually using the
> > bandwidth crud, while this 'some extra accounting' crap has *everybody*
> > pay for this nonsense, right?

Doing the context tracking could also provide benefit beyond CFS
bandwidth. As an example, we often see a pattern where a thread
acquires one mutex, then sleeps on trying to take a second mutex. When
the thread eventually is woken due to the second mutex now being
available, the thread now needs to wait to get back on cpu, which can
take an arbitrary amount of time depending on where it landed in the
tree, its weight, etc. Other threads trying to acquire that first
mutex now experience priority inversion as they must wait for the
original thread to get back on cpu and release the mutex. Re-using the
same context tracking, we could prioritize execution of threads in
kernel critical sections, even if they aren't the fair next choice.

If that isn't convincing enough, we could certainly throw another
kconfig or boot param for this behavior :)

> Is the expectation that these deployments have to be managed more
> smartly if we move to a per-task throttling model? Else it is just
> hard lockup by a thousand tasks.

+1, I don't see the per-task throttling being able to scale here.

> If Ben or Josh can comment on any scalability issues they might have
> seen on their deployment and any learning they have drawn from them
> since LPC'24, it would be great. Any stats on number of tasks that
> get throttled at one go would also be helpful.

Maybe just to emphasize that we continue to see the same type of
slowness; throttle/unthrottle when traversing a large cgroup
sub-hierarchy is still an issue for us and we're working on sending a
patch to ideally break this up to do the updates more lazily, as
described at LPC.

In particular, throttle/unthrottle (whether it be on a group basis or
a per-task basis) is a loop that is subject to a lot of cache misses.

Best,
Josh
