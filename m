Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA080345731
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712990; cv=none; b=ADRVrkCf7mb3zFDCgPOXMjtUXgGgIovMi490uaBXNxgOtyGd+1wPXb0O46ng0hlnTRDQ6Yhwfi03VZL796xPVSffPm0FdlcJU2aZ2uZw3wC2qbaj0O7bOtR2r+S5ca0XE0K6xSNU8bFDrztKJE97XZeOUTH0RwKR5oqohuXKW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712990; c=relaxed/simple;
	bh=DxhFsr7v4nM4HEMsm0MryKQnLEdISulr17vpBylQNRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rWViO7suXfS0rwaQkC0S1QfFZoX8jy+vaQtauxUbk62VzJ8OhqrXCKj7gwPRRA9WHAmgLSt138zRyT1PKMdjN/hvVN9b0ACIz24hpYuZu4KaQj+vy/wRzylFPBn0QbTZPv+29oCHalvb2qf3c5FghetCKZuTKZb2Zb43GpFz9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTbZVYtI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTbZVYtI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767712987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfX9i0/JqQZm4DOzGN127ncGZdESsrgUSCQk4kQI2Lw=;
	b=jTbZVYtIi8LsoUUwF7MuK7YC2i4z/FDfrtPKUPoB2S/CrYBVzZ/ExIzRDFP0C+1OAy6s/y
	x1ahyQwu69b/Ni7Yjy6S7uuyJ6WuvZdpmbqmCgEMA/gmdBavEXo1E+glv1+mE9vKKO5EBe
	D3U17vHFrPa41E+HFZytpw9NptuNfnw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-gd5QM1W4NiCLU7Vz0mqwyA-1; Tue, 06 Jan 2026 10:23:04 -0500
X-MC-Unique: gd5QM1W4NiCLU7Vz0mqwyA-1
X-Mimecast-MFC-AGG-ID: gd5QM1W4NiCLU7Vz0mqwyA_1767712984
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3c4468d8so6221525e9.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Jan 2026 07:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767712983; x=1768317783;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfX9i0/JqQZm4DOzGN127ncGZdESsrgUSCQk4kQI2Lw=;
        b=ikyN5xHr+Z9WeZ83aISn8X124TYwJDHi4vKdi0d2Ucc+1rqMbHFJwUDQukR6uulcs/
         vSky730/qBMN551zp4+YIf4in+G4xe9adReKsDT1Gb/jq0KU5+ibtuGuJlx6Fk9YRG2r
         eFqSTX046NFtr9a3Xos/U08Dqqz1Gw93S86gSTiBTwYlZkSgnbEwGR2hKUDNooDCkQo8
         WrIYvEvYNLBnqMAz8Zg6f1QeggPMDxzsDEeXvSRKGo4IjcDo3rScPlA9AV6awjTLnFIw
         Q7pyNqW84hhaHzLEZWF6s1n2ZMDC5SHQA1rukG9cpjfW2zN9L0+zoCX8/ZgvERVkXlFQ
         1xZg==
X-Forwarded-Encrypted: i=1; AJvYcCX6fYFG666kG9mh6pvMY5R/EE8md4q3WVI0tcjUaZ2K+pyZZ0w0/MoOSATfRBi3+Hu0qd64TrdEM5pW5/aSSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJJI6ylDLXaX3xAJlzh29tYIbfQ8sOQ73gAxW8bZ1SOUtHO8fY
	t8uSqpQmrHrz2W3wKKMgfgVxkyE9F9NdDes2mHpAcnN8vEvl1olTREm3LEPXhWc6ZPTV7jYkRx6
	ZNjKBxVQlxxC2225fboLclbftjb35vWOCTIpoIDGZyoSewFyLphRNAIoNvfpIshAyNiAn
X-Gm-Gg: AY/fxX55qjt/2Vj2I4TnMpqnqVzdUQvFMuH1sGjhYQEV7shgU/ahQSla0T4Fp2VkDG1
	HS9+msdZJ+T8cGGOtNdY0gWqSP0o0iJp4veqRgtScUyNqevNY8wyHodKdWkhh8qmNNOTrOs41+6
	WYuiOTePpR0qJXtvSqLWXm1RLrmDUaq89TfNh34AUX4oc508dtCQB7st9ezY5ytb5F742ENJevy
	5bVeaUL0M4e2T0pE4zWaUyX5mQgkudakgkbkOFsX9fj5E5xut1yVEzjGOJky0adqCGe6K3b11Nn
	SxUG9At/MEsXYpYcXwTdyE25yZNamvHGv+VGpUwc2YnQfoaRdU6jcn4uarIUguJRHaRVXqyIuFk
	RTIOgcKIdkajjwFK9UkXz8cU49st+uY/cTtY6YjK72P1cr+sSw2bAIzFFZ0uK2soDfN/OKPc=
X-Received: by 2002:a05:600c:1d1d:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-47d7f09c9cfmr35653755e9.18.1767712983584;
        Tue, 06 Jan 2026 07:23:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQEKHfgC0ZiTvLVNAohKd3aeFxuq8zh3hSb2qEWoW/H6FPdVm64Fq2qD7tBQoiHHPktimJ5A==
X-Received: by 2002:a05:600c:1d1d:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-47d7f09c9cfmr35653305e9.18.1767712983018;
        Tue, 06 Jan 2026 07:23:03 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c25sm54234555e9.2.2026.01.06.07.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:23:01 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bigeasy@linutronix.de, clrkwllms@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched: Further restrict the preemption modes
In-Reply-To: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
Date: Tue, 06 Jan 2026 16:23:00 +0100
Message-ID: <xhsmh344ipxyj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: afUTiFnOeIYpBAQnGLn_vpUJ0ttXeu4OurGUGLnp8nA_1767712984
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 19/12/25 11:15, Peter Zijlstra wrote:
> [ with 6.18 being an LTS release, it might be a good time for this ]
>
> The introduction of PREEMPT_LAZY was for multiple reasons:
>
>   - PREEMPT_RT suffered from over-scheduling, hurting performance compared to
>     !PREEMPT_RT.
>
>   - the introduction of (more) features that rely on preemption; like
>     folio_zero_user() which can do large memset() without preemption checks.
>
>     (Xen already had a horrible hack to deal with long running hypercalls)
>
>   - the endless and uncontrolled sprinkling of cond_resched() -- mostly cargo
>     cult or in response to poor to replicate workloads.
>
> By moving to a model that is fundamentally preemptable these things become
> manageable and avoid needing to introduce more horrible hacks.
>
> Since this is a requirement; limit PREEMPT_NONE to architectures that do not
> support preemption at all. Further limit PREEMPT_VOLUNTARY to those
> architectures that do not yet have PREEMPT_LAZY support (with the eventual goal
> to make this the empty set and completely remove voluntary preemption and
> cond_resched() -- notably VOLUNTARY is already limited to !ARCH_NO_PREEMPT.)
>
> This leaves up-to-date architectures (arm64, loongarch, powerpc, riscv, s390,
> x86) with only two preemption models: full and lazy (like PREEMPT_RT).
>
> While Lazy has been the recommended setting for a while, not all distributions
> have managed to make the switch yet. Force things along. Keep the patch minimal
> in case of hard to address regressions that might pop up.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

