Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F625A65C
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605364; cv=none; b=rf2fNeDRn0diZz+ceed4qVuFtEE4IAMmt898u9fKgHtvId2dBQqqo2+Uh+BqRxNYTH7yZZgROdg0kSZwOFKvrLFZ5z6VaW3cCFsAuvsDJrrar1kSPrphqLKinlprILiTb68Uw9G9wXTHCwBo5UPGx0YF1gQsZgu0c5MRr6Yh7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605364; c=relaxed/simple;
	bh=SugYHD+uYQY79n6wJCLpwkBHfJKaSU6JUycME7SEG/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmW4VWFsTFWktXny7DWBNCzUoB20ilWe/Hzrd6wB/L/CotqWpFMjfTR3cr+CgWRz9DntiSAPWIjqbhpyb+T9kIvaQD9AVORlT1+HhdlQuNaIfvqE5j+5bnbHHnmX4Rl0vHw2UJ+gNs7FUO/StDve8smAnkLhhEFCFHZDBzNEyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlOsvFEp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlOsvFEp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2156e078563so68517775ad.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 03 Feb 2025 09:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738605362; x=1739210162; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZpi3N7y/rWbfK2y4bLstAC2w9aIoMiTh4j1cLHc2JI=;
        b=FlOsvFEpBP+d0Hbgqlfi6Um/cp81JvRw0ciccgNpOH7Z2OFcIq4LGXZ+VaIN8wBKcA
         LhFTn3lOVZOjTEF9Ztu1ro8dAWVIRfTVNU4jXfEJf/oOukLVkQ9B2jdGdHfBXtNnDHLB
         /IaXbrGGXgL8n3TKtMXJ4ukhdayaNNhma5JCfXs86ayLo+NzNuHAndl/xpSoI7pVgBmc
         iNtmhVG3XDNBUVNVlVt3sZFNH98J5BDtbgOlR+Yi3tN3qD8gybWUNTovzR6Bt57yaIy6
         k+gu8PaBfb+AS4q4zdnV3U+3zqS91rao24WNwBKzXAMERcsf+hkMkz/9eu2wc9iras11
         na7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738605362; x=1739210162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZpi3N7y/rWbfK2y4bLstAC2w9aIoMiTh4j1cLHc2JI=;
        b=u2IZ/RI+HXuV9ypOxXL5p0Dcvf8DNTzGfoVnZAOc9eGhWC8Nj45KKeBBR+QIK7LBaP
         U8PY9jg16RYMgazfWsR2hT1mqy4UDIbbiU6FcRTuKIFPqaiwfF5A3eGT/v3o7FIU/p1l
         HWOCzID9q6N7j9WC3sQHsthZTnH29cM031318Cj+MDJurEH9Cs9oizfxKPfokdtlRU3J
         fln3fna5fBEaOFRfFXp+mAN3/lIKkqywN2Z2xYics8N+Ruy939aNZfaIPYlhFwO4UBOD
         6f/XJvZDLtnByphMhdHK6kBh0M3SlFaohI+TWMLWwa4bkjh3nEsREvtl2NlJ9kAyP5T5
         5POA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZfH2B+mkOUNX7x5JJPBvFxuaot/S4ddPvvNknnV5QmSvH+Nfbh1ZO16cpIAWmSl0vFVfjlXSO5Sb3jaAJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU8/WyVYmSnOkKL5nCNibispl4lTn3wW+prHCFC9wgDvpVwxCM
	20UY/Km8tQqth9nvMwf6CFyLV7Sxga1TVH5loLqhzE1KDpNvKXh5vKr8sDwufExjCJ2XLHqPPvh
	tIrZM0ClLt3hGYEbZgjwBHVmxRI4=
X-Gm-Gg: ASbGnctPOELXQf5i/2Px6m5/a0sgQymijnq8MQCZ1RJj3Z2ERMaNhRsVvP+p8OfagkE
	U2IVmeQSCgQD/Q1/YUblj515xcTXLgNQ3Xumr9nXA8LU6Dp/d2KMvcBWFKoqdlChI7hxpWh9/jZ
	aI6AGRvORoD5m/Z++08uy4HsRue0l2ng==
X-Google-Smtp-Source: AGHT+IFPf0H+yjKerqQ3pf0mjfxtUND+h0LTJMg28IyAxnO+N0IBnPGRZdM9f7sccjKWKaQfL23Lo6ewrd8UKM3T3c0=
X-Received: by 2002:a05:6a00:b8b:b0:72d:35ed:214b with SMTP id
 d2e1a72fcca58-72fd0c8bfb4mr35482879b3a.24.1738605361813; Mon, 03 Feb 2025
 09:56:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250203141632.440554-1-bigeasy@linutronix.de> <20250203141632.440554-9-bigeasy@linutronix.de>
In-Reply-To: <20250203141632.440554-9-bigeasy@linutronix.de>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 3 Feb 2025 09:55:49 -0800
X-Gm-Features: AWEUYZmUdIxLoq0ZTpUZ0ejeXSF2OzhJmPk5P1HKzYnJBUb5YKUMC8WoYkHOZcg
Message-ID: <CAMo8BfL8oVi3ED1rybkEbMru0Z_gs_Lh7435QnUKGxop0PEsmQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] xtensa: Use preempt_model_str().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Ben Segall <bsegall@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Will Deacon <will@kernel.org>, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 6:16=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Use preempt_model_str() instead of manually conducting the preemption
> model.
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/xtensa/kernel/traps.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
