Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF6932ED32
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Apr 2026 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116249; cv=pass; b=Id4GpO9uUHFaDTewbjCLam4DQdILFLtK7tWA5V3BstX7zOPMoIyZL0AervpY3bMm4u6YdRHxBoEMkLvRAzhzxqeRIL2xxew6mhQ42jS6og8G/SutSRyyv3HyWSSxGiayqCPtQzECzXVdr290884gbag7LptTZiY2CUPmSZxQ0xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116249; c=relaxed/simple;
	bh=TH8sG4ZFTd40xrtO8my09gy9jHZzt6ZP6hpQ8AsXtvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5K3yCgwlyD0+ZTjYGEojr4vM7JAt9ixKsbLsQwYg+6kflupS/cvPLjUVOLj4J3EJKM///M7NkQJyXWvXwqNac+3pyNm+PhfeP2H4I4Uzvy4etkcWYBr0bu53DDB3geQL0m2ZeiCK6iznTV/J830q9R85rZxDbh2MIcT8v6eiI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NvXzHxWe; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NvXzHxWe"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso295610f8f.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Apr 2026 00:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775116247; cv=none;
        d=google.com; s=arc-20240605;
        b=UmrZl+ChDokkqMJMAmRauBu54d9Ab9YIaNe9lKHOv3YCwV/JGrTYzJaT59JtCdqS2E
         weLupe3HywpojKmCAhynU+1Ehq+8wxUl3wn/egm87e4QZszva/mL/JjpzAkHJLC9vgH5
         Ky2GHvoXKvs71Q6K2NBviY5jIl7EfdyCLHrOjUOg1rUGf8GFudH9L6c5mTONmKrDrTam
         txjVhfS92rNoG0FG1qW4SYe3+mDgjZu1i0QnkUbWasEeicUh/az4GrSGb/QwqTvKN5Bm
         7rosHPKcc08e39j7/18sIsYsohXYe38ucEo2dXWEdWFjywnkDb0NSDBrdVT9tWYkDE70
         d8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TH8sG4ZFTd40xrtO8my09gy9jHZzt6ZP6hpQ8AsXtvo=;
        fh=h32snYV+ujGtx4jkD3wjnMCVBCjDkiQSc3lf42gQHAc=;
        b=NiDU4rOJa+h058dWN5Ucd8xU3Zf8YXIhoKosICCLZCHimw/GhKBurSigIJ3kwSStiQ
         2ngeEHf17hxfO6I4HxbJMBI0ou4FE12djIFNpdWESAfSO7HAHaIi8mkmG1RtVu2NS0b6
         CSpSH2Gxu53Of1WXAWS0dDAsW6DNoboggoD/rvQi0TsRKRa0PslbDQXjGSnIqD4F1/lf
         cE4mu69uDB10m/ml0iL1I4yYKpSAzxniwrDrrMvrfD5cZzTN8pNrErNckeAhoxvw+pIe
         6i3BThfooDps9luQ/GO3owh1rCJMJCnx4sxgxBI2kZs5K/rpgttqnecCJ0mvlOp+uyC0
         PECA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775116247; x=1775721047; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TH8sG4ZFTd40xrtO8my09gy9jHZzt6ZP6hpQ8AsXtvo=;
        b=NvXzHxWe2QKmgjbNROcYHkFfo9iFm9OLXMd7BMKgFXlAoWzKRI+/pzWDcS45bFYBZd
         REI3Cy/KW+CTvBZCVWz3wZWNDkPXakBQRaMqdQ1fZb39cT8+hC+brXSQQPVPQLl9rflD
         v3rf78zztWLHnKUKS4QQz0YQIFeOko7J4l0Wx2GImSwWcIj15tL4taRKMb/H/TEiTTu+
         9jZtLjIU8fbL+n1aJG0xXdQF7o1mIaSvqI7U/O28lOw2e/WtMOdwWwPSCRfKcf94+Zbv
         yVIvwKNUYmuzTkwJzAKxWG6CXoc2mQxF9eRu4IOsAeWvymPAN5llpxiCoFwZ4X4BT9Dg
         Qo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775116247; x=1775721047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH8sG4ZFTd40xrtO8my09gy9jHZzt6ZP6hpQ8AsXtvo=;
        b=pzhfPs/JKhp/kw2PHD/TVyNnKY7F/Lustr7IA2iRzr4xIJguvJq2DpdisTx/B+5MpZ
         mNVcw8e4i3alE4zo7VxQkRPiOb2cMbXdOLCxmf6WiFtKnehLU79MjsggKH71mM4ldTBr
         dCAyhlhSyWrIWXmjdidrqm8DxMPNd7+1WfXPGXE7Ikqh/kbwyRB5OmV6TxJJye4f94YV
         w44nap6PP61C0YcVOBXb/u9wVG+gYTY8Ag5rNnx94PfRTOQXeF1Cd+PHIZeKEzQ/koBX
         wHM7zFpVGuI75UP29vl+rfGUKRdQmjIZmSkC7TYQFXwx7kNpU8wWg52oZ4jXEWWUM+Al
         3Nzw==
X-Forwarded-Encrypted: i=1; AJvYcCV3DXffwM4b4wMIXl4E0c+Bz8EWsHUc/vjqgmgoknVjXea8HKTcD8XlzRga6JLHunTwvzxB8pMD3Hj9xKvLsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcjlvvxzP0prFNE9hRqieOfqv02CRLoRS8pUOLN9v5LzD6v/ej
	GZ5c3EA/9WQu1vElwnlJ9sCffFRB3Mgr3y4ORBXuGq0ypDAffjn3mrpb5u6Z19a1hIYmjNjdEVt
	6sCtsJ/IlLTwor1LYz/lm0NOgkA8LOIsQWgylFOAonA==
X-Gm-Gg: ATEYQzycn7l94nmxVVeoIPoom2wjvvhJJ5g8xlNR4ZfJTver22c+bqjmY/zmLnyJij5
	hkFgpJ/fxLiTFG2NgZQ5tTManyJKoNLnLE7fqOgXTHFkZEwAWEH13+ByzX3KcGf4gUAqp3Pl03R
	96kgq8f4OUgOncIaYuwJ4kWJ+wOoCDzi156At0mo9es68kVe+jfipHICQqN5WqYvj3i92BNz+CH
	SbeqRBiO80RlsAsBgaTBIwHJWW3VsH2EpSUxqeNqqJfT4WbBM3n4ewpzhbrI3BmIo4vHWVj7nxJ
	nxK+7+Ym+e/dJwSxUt0sbvaCI6dWFdbnIhe9n+3yFwjJv81WRU95wZlDRwXOcDXbTJMgU+rzkKc
	frTkV
X-Received: by 2002:a05:6000:2c03:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-43d150d3fa7mr11490151f8f.38.1775116246685; Thu, 02 Apr 2026
 00:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de> <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de> <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com> <20260318111849._MMol8Hr@linutronix.de>
 <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
 <20260318145101._iaDDpbE@linutronix.de> <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
 <20260402070319.vhRd6c-f@linutronix.de>
In-Reply-To: <20260402070319.vhRd6c-f@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 2 Apr 2026 09:50:35 +0200
X-Gm-Features: AQROBzDZUqa_BzGKAluV-XM-Nj1B7MyqvSkoxQA3m3h3_5JZUXOc70CroRCVmQ8
Message-ID: <CAPjX3Ffz22M_ADE1xPqHOCyni1wLwc+reLTVyOrJ+gqNYY6vwg@mail.gmail.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, spasswolf@web.de, 
	tglx@linutronix.de, Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 09:03, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2026-04-01 18:55:43 [+0200], Daniel Vacek wrote:
> > > > > The above was me thinking and does not even compile for !RT. Commit
> > > > > b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> > > > > netdev_queue::_xmit_lock") is what was merged in the end.
> >
> > Thinking about it again, wouldn't it be better to have one generic
> > solution rather then special-casing for PREEMPT_RT vs. !PREEMPT_RT?
>
> PREEMPT_RT and !PREEMPT_RT is fundamentally different here. The one is
> not preemptible and records the CPU of the lock owner to detect a
> recursive deadlock.
> The other is preemptible, uses a different locking type/ class which
> records the lock owner which can be utilised for this purpose.

I understand that (or at least I think I do).
My idea was that the non-preemptible one can record `current` task
instead of the CPU to detect the deadlock. And that would also work
for the preemptible case (it would actually match the lock owner
approach as you did for the PREEMPT_RT case).
One code for both configurations, no special-casing. I'd argue that's
a better result. Am I missing something?

The size of the netdev_queue structure would grow by 8 bytes for !RT
case, but that's not a big deal, IMO. For RT case it would just fill
the hole.

--nX


> A generic thing would be to remove this and rely on lockdep. This could
> work if it is only a devel thing and never "I setup something and make a
> loop" sort of thing.
>
> > --nX
>
> Sebastian
