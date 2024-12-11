Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B423FD06
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923784; cv=none; b=JIHD6FqtHcNQpuvh3W/oHYbgEA74pd82ZhRknkZ4GHGAOFElDGIwNQ8azF+Nuq8GmOBCQIpH8Psl0Cqm+EMcW0wR9QJOKN03fmLLeK04wQiBT1OytqH4KAsNlQyStZfrKmZERhnEyjBULBJDXpsvD3XjYETryc1PPiqfn+nVDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923784; c=relaxed/simple;
	bh=pBszRuBW18HohSRop+i8jodKGiC4y4kU/qCMAftwYv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwioKlDsGuLnepxD2zltst20ch3O8IVWXQ4st8EnJ2I7rJ1Xgw9GpWC7bqJEJzzwOCJZU9TqlAbxxU/lxtgeJL9hAElDVqUp8wplXQzYODqPi3R7r+0lM59w5C1Gphxknb7vurRpiBBpodH2c+AJl5CyGekp5ZtsWxyvvML2B7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vTufm6+i; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTufm6+i"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401c68b89eso812939e87.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733923781; x=1734528581; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7zPCRbNobZB2rLY4klNUfuL4Nc1TSS5AqwC+M05YI8=;
        b=vTufm6+i601a4K0JK1mHJT8gCG9GqmtEwBZPyXUWN3AVk+jZNBrQEuOEmvLA7af6Xq
         Wvse1T0dxlPWM7/KvNuKld0yiMGSMfqyR6VGAVgsnl1dzAsLwaKPVI9q7Hrzhw1cJU47
         PtuGnTQB2gpWoI0wewhvmLbNogfvkpkoJNLMyL6z54vfd6cYKEjQkzoNDmYLxET4YpJh
         lj0tdMxCR0scqZPWsMJfzHwElCH0s1GC8cy/XVcmHij+8a4QLP5uXg1H77B3Xyx7bwHa
         oTW9mqa1tR3NVrkCMgRoTIDVNacIm9aVLVRwQyx2oIN3M0j0bpFMO9ty3EcPJUHv+P5g
         QOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923781; x=1734528581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7zPCRbNobZB2rLY4klNUfuL4Nc1TSS5AqwC+M05YI8=;
        b=hqdtPT3zNZchZmjgA2Cy16PBpoQwvrG0vKPZVPrn9Bn/3rbnbS5XjXK2/JMOP+pSAb
         mh5Vozipb5GGe8DlZwpQyJQvBMPG66YijBFRbYGV/cq1Uh9E3tlW0omqoBNtrGotLYbb
         MTIiwFv12Eq8XMsIUTEOfTOH9UZSIa0lRR/XasFRS47FBQh+F5YknKOhH8RWkB9zl+x7
         D1gURxv/8TkG/HRWYSOFZR2SjcVbxBmfcGreVlNXXpeu/AjzUkJCFcgCGRncDgwyVTWx
         bC+0kBpC5GWvfenGtHW0x1E8zAl8jCtOUdxpgr3NWBPRbqOh8EUo3iEpmgwKH0sAHuo4
         iAhA==
X-Forwarded-Encrypted: i=1; AJvYcCXG/fLm6CJEhBNapuCPDLjPzZyJE/WhmiC5VD2saJ2etEZD0kudorJig0NpQnxeiVpY5v49PReKeZZiMBKc/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQpxDzThCLej1kx9JWxx98gjHu40mKDoYaBsyZKoLj2QvjzSr/
	mGd9uNRDKnB0WR0hI5h5d/bLOTq3PbUc+XB9WxxD87ce4o9GLYGQJrZBU6Zo7GA7teWirYcq168
	vw7lBu38VN/G1UnOU/LRgzBX1s9BSl35/vepR9A==
X-Gm-Gg: ASbGnct/ZZ9XQwFchXj3mIqdrPdgM0GLg5To3CX8aOy0VgPSN0hJlnZdpyraKRGA45T
	/mboYDVacx5I/hzIHc3f6RiweXzpxjE94hw==
X-Google-Smtp-Source: AGHT+IFgSwAzChMV6MPtTrzqAT5fEZJhpVqpZ7rEneJDnxJfXq2+f607r/zOzxJe6hnLdIwQ0jSdAOyNE+c9jLtr2FA=
X-Received: by 2002:a05:6512:3d9e:b0:53e:2246:c262 with SMTP id
 2adb3069b0e04-5402a6ba964mr927083e87.0.1733923780650; Wed, 11 Dec 2024
 05:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-3-arnd@kernel.org>
In-Reply-To: <20241210160556.2341497-3-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 14:29:29 +0100
Message-ID: <CACRpkdZaoD2vqbCi1AFUa6mF2_=c3Nu4R0CvxFAep0VMgtMtOQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: Disable HIGHPTE on PREEMPT_RT kernels
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:06=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> gup_pgd_range() is invoked with disabled interrupts and invokes

There is no gup_pgd_range() in the kernel, is this patch a bit
old?

There is gup_fast_pgd_range().
See 23babe1934d7637b598e4c9d9f3876e318fa63a4
gup.c contains:

  get_user_pages_fast attempts to pin user pages by
  walking the page tables directly and avoids taking locks.
(...)
   Let's consistently call the "fast-only" part of GUP "GUP-fast"
   and rename all relevant internal functions to start with
   "gup_fast", to make it clearer that this is not ordinary GUP.
   The current mixture of "lockless",  "gup" and "gup_fast" is
   confusing.

So fast GUP is supposed to be lockless, and should just not
have this problem. So it can't be addressing gup_fast_pgd_range()
right?

> __kmap_local_page_prot() via pte_offset_map(), gup_p4d_range().
> With HIGHPTE enabled, __kmap_local_page_prot() invokes kmap_high_get()
> which uses a spinlock_t via lock_kmap_any(). This leads to an
> sleeping-while-atomic error on PREEMPT_RT because spinlock_t becomes a
> sleeping lock and must not be acquired in atomic context.

I think this needs to be inspected by David Hildenbrand, if he consistently
rename the GPU functions to be "fast" and there is a lock somewhere
deep in there, something must be wrong and violating the API
contract.

> The loop in map_new_virtual() uses wait_queue_head_t for wake up which
> also is using a spinlock_t.
>
> Since HIGHPTE is rarely needed at all, turn it off for PREEMPT_RT
> to allow the use of get_user_pages_fast().
>
> [arnd: rework patch to turn off HIGHPTE instead of HAVE_PAST_GUP]

HAVE_FAST_GUP

I'm still confused, how can something that is supposed to be
lockless "fast" acquire a spinlock? Something is odd here.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> There is an open question about whether HIGHPTE is still needed
> at all, given how rare 32-bit machines with more than 4GB
> are on any architecture. If we instead decide to remove HIGHPTE
> altogether, this patch is no longer needed.

I'm more asking if HIGHPTE even acquires a spinlock anymore
as it is supposed to be "fast"/lockless. If it does, it is clearly violatin=
g
the "fast" promise of the fast GUP API and should not exist.

Yours,
Linus Walleij
