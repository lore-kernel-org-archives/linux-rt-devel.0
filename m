Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D82DEA82
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822782; cv=none; b=Qy4A3nB1ta3FQrSb4Cuz5/q5sDskyN0cHnWAg3aSApGJJuhGJIoqre/ocIOD0K6GPdMGxl7Jv3LJIZJPznve+ZAv4LMLSdPEqZoI3buHT80TjbPP46S1YkYqo9lvqKWR7zwNi6Z9wmqag748DbemkwQ55iYfAQJYM5m0QEHFRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822782; c=relaxed/simple;
	bh=2r/d/DXkCCqfUiqYh4pT8N//8c5NvbXpQA4IUEu+M7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qxm/ddcg0mGBv+5Xbn5wqSvofoEPdhuo0L/NaG0SKed78YxYTu5ao5K1KTMH/KUIxL7JRbOp6EGk1YsAy33lQrFBZO/9O5MMUXit0zOaq+T6pIin/Bz1JkjqPJkyqkiG6HnuAxvFSGPU6gFyUYqiGvr49zrKE/vTYy0vVtZuVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0JmYzi3; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0JmYzi3"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-72267c05050so26961507b3.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756822780; x=1757427580; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W60ago5VW57dbfLZcJC+4/A9yeK1QqRMxCl2bII8T1A=;
        b=U0JmYzi3u1itQiBM7Cd8I8f3+3TKJtk/szLc1HZOaBX2Q5pT9/UZNbAOXlxJ4W8cGX
         /qCJLgCao+IDaMXyO+t6sNjrdqxYRLffuR4Tvi2F5OuI5fOtiAyuJLwnXnmAkIAIYR5O
         yTF4wAJVea2z7redIOhuQ02/wCGnV2g2toR4dyE5EZH8Z26ts9fXV6wWE7zk9tMRWazU
         a9qL1DaRU2LWxB0SW+mjg2lxqZ8f8lVZQ0G6B4nQzp5xxOgWBk6Xn8ZvNR+JoHnIatbD
         qj1SjXOYVsd2LspBiCDi7q6x9R4s6oXyYe5TyHqsZCTygTKnD8FPMTW52QhSD4CfF/tY
         uy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756822780; x=1757427580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W60ago5VW57dbfLZcJC+4/A9yeK1QqRMxCl2bII8T1A=;
        b=N/bhvthTCXcj6dWu6gJTheOXQYyNzaJVl7/rOBHXM9aT6MLUsBNynDxB38wl+HFNv3
         7L5KYWKojswa1wJxlunlLbz8+2tTDtfsFilH3mUu7kBmPOhPuSMWgOWw+2El2yf6/CMH
         p+WSmBVBYl1uBOOkM8kT9IurPCwGtAqdxSRfNXImZVJWmiK7qWpNXPrV/gwWIe04oglr
         i7yXLT1+aGFIN0Hblg1XmpP4m0QWsaM7ujBut8X2+rlcJHb0eHgW9BlQ6LjPrP/Meq5v
         alnLKv+kdjVSfInUKAO+beLN02AXIDNJPuQmBaInfDCnfIBo324u7OfGrf1lbgBahp/r
         TjGg==
X-Gm-Message-State: AOJu0YwLVRkevgVTtRSK+uDV0Vi8nQkiRYfvpXhVicOTPgMBAGLtgPrp
	87RTiCEQoz6vpJ5va5KYkLRyuZBHtckMOquijgdfY9N2jQaeiJrB+ooYRJbnGlegou0XKUzQ5Ci
	BCd7cbjnb2plGKWqoDj8BYp4DgL4q0CE=
X-Gm-Gg: ASbGncs4loORaasWxAogmGE4KQbHc+9Rtt15JB64OQ7bN7KDW/u4wiKaqYpvbVY8dZh
	gZxI+xU1D++j/mhmDCarokew4bcPJQ808V5CBvcdi7b0A5voEh58Qr8D6Y94QDGnGmTnlg1kan/
	CSjX2yWPagiUQbdjhCYzC1mhvm2JMPcWJW7LJks9LzPABUZetpYLedFaEVbGypalL5NKcT/QhO8
	db5P4hL7Jd2+YAcbPYH9cnu1B0EeXH4NM8LO86ru31BPlvzZsq2orrZny4pVUfbvVU933ft22fI
	kZScFFWbeP8uYLeWsw==
X-Google-Smtp-Source: AGHT+IGa1EaDaFDmxnfeNJKhDTCxo8us1/bV8cd/W3/t0GnTRNqnMGNTnVcOOCSr3xfi66UPFbHGj1g+7yrfeYrrX7M=
X-Received: by 2002:a05:690c:d88:b0:721:1649:b05b with SMTP id
 00721157ae682-72276361de9mr136212497b3.13.1756822779444; Tue, 02 Sep 2025
 07:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250901163811.963326-1-bigeasy@linutronix.de>
 <20250901163811.963326-2-bigeasy@linutronix.de> <CAJhGHyBaqn_HOoHX+YinKW5YSy1rncfbvYXktkEtmFgK44E9wg@mail.gmail.com>
 <20250902111740.hwMmUu4T@linutronix.de>
In-Reply-To: <20250902111740.hwMmUu4T@linutronix.de>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 2 Sep 2025 22:19:26 +0800
X-Gm-Features: Ac12FXxwiQL3_AxCPmxMyQd-juJULME8fi7RYO-LDay-Lw6Fm6cBtgOGJ8vZawo
Message-ID: <CAJhGHyD7x9QLJ+uoRnbh4qOhphdxJU4c384D1Ph2tn5ktR_=kw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH workers
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Sebastian

On Tue, Sep 2, 2025 at 7:17=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> >
> > Is it possible to use rt_mutex_init_proxy_locked(), rt_mutex_proxy_unlo=
ck()
> > and rt_mutex_wait_proxy_lock()?
> >
> > Or is it possible to add something like rt_spinlock_init_proxy_locked()=
,
> > rt_spinlock_proxy_unlock() and rt_spinlock_wait_proxy_lock() which work
> > the same as the rt_mutex's proxy lock primitives but for non-sleep cont=
ext?
>
> I don't think so. I think non-sleep context is the killer part. Those
> are for PI and this works by assigning waiter's priority, going to sleep
> until "it" is done. Now if you want non-sleep then you would have to
> remain on the CPU and spin until the "work" is done. This spinning would
> work if the other task is on a remote CPU. But if both are on the same
> CPU then spinning is not working.
>

I meant to say that the supposed rt_spinlock_wait_proxy_lock() would
work similarly to the rt_mutex proxy lock, which would wait until the
boosted task (in this case, the kthread running the BH work) calls
rt_spinlock_proxy_unlock(). It would also behave like the PREEMPT_RT
version of spin_lock, where the task blocked  on a spin_lock has a
special style of blocked/sleep instead of spinning on the CPU and this
is what the prefix "rt_spinlock" means.


By the way, I=E2=80=99m not objecting to this patch =E2=80=94 I just want t=
o explore
whether there might be other options.

Thanks
Lai
