Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6015621
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Dec 2024 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049634; cv=none; b=p9UZ3OsdKlOdXj1GEZ9tmc3xCRrnRKOLJIgWiM9mJTkzspQS9MeUsHB36hxKiC4U2/dBxZtCcJ+I3lBL52wAUPOLkH1jvrbyDkWazmValn2Xcc2eZv32/NqEvcExLQKPo2GBwRsQZRJLwpwRC06z5EWzzn/6KVtB5EgJPUTFbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049634; c=relaxed/simple;
	bh=eXUuxYw/zq0YWB9TTZm2iQpmEhsWgzTOwd/QbpTSb4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC9Dmqko1DSADFDX1KkkR0h32EMyTJKOP0TB0xIpy+/viSkeKDpo9ucbrhWZukHAI71GaFOjuxDARxlpvZps315p3jAJXwiIggpDF+lcH9Ucp5aemYQhss4Ek1pRqannsvVPTUelXIijNqq6011nfdfynWxERSLNtYkTiI4EaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D4qQUuEY; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4qQUuEY"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53f757134cdso1362123e87.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734049631; x=1734654431; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXUuxYw/zq0YWB9TTZm2iQpmEhsWgzTOwd/QbpTSb4U=;
        b=D4qQUuEYllA+y2GZJcSp63KPJSOExnX37w5X4gcKfi8y9GzYFdV6ioOBuFzn6HD3Zp
         yWUcimNJxoRRaFxBXv8jxebNhgMsr0j3xnO0CnLLHklJRkhgk8kcMAE+ZW9daCYSHxJc
         IySO+L7AB12A3sAtg3hrRifty5P/YJsaBqGhXEywx3f2L8ECPvLY6BBodrfTvA8FYVcU
         dptsWG30ab/bzQUqLT0/gVKZnR3iEZ9r3RsZKpXE+joxKFd/sSBQ1Y2B7vSqpaWpusXD
         SUqASIaRwx42HE650Ext1PdSlydMhFl7e7+jZWQ5Or0OOKDl6DIIQhxB6L8mZfr69t1U
         jZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049631; x=1734654431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXUuxYw/zq0YWB9TTZm2iQpmEhsWgzTOwd/QbpTSb4U=;
        b=u2NSf/9XewQeK0E/1QpCwpYEDPs3qQVTX943+dbcotiEEUATCoOTmQcfNwhCJ7XNtl
         LQqIXxhE3UtPC7UEzKoj9AjJQXez4siqFduUwFYkzJDq/b2LsrCvLhicByw5/UgKqlaJ
         V4MbQ7zyMxK07/DG3UbfWdN269LkekfzX2vGqB1xy6oGHz2jeTUSQhyWtndu2imnqBnL
         G/pAU74MpKGX9q9IXNcBWedbR9eC2BroeeEWXreswaqEkfwzC+pXcannGUXsXHTKCjXT
         YF8prPOGNm9StInrxRG8/RLWPKWCAydxECFdgsp6GhcpKW52V6zRptylJ+VVWguQs2Nb
         VDJg==
X-Forwarded-Encrypted: i=1; AJvYcCXc9uxO+IAFZZtvc5afHhCgPbMMwMXI7oucXwK4JxKrIKi4Uxq/v8OG6bHZURU3hyxieNXMOMY/tfoDNfdT8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoPq6N92OkGeodOlLfhgln/20Xg/iop1VkAD6iQuXbBUUjq7In
	tG6Pe3IADd8euttpvY9ciA5hu3z7fRClSJzFWNtxItvdw9Sc2zhqmYu1ZmQjv4JANJ7p40j9LEu
	wmyhnTeWpS/b305IZLDKLVQbP594hqLDSi8Ft6A==
X-Gm-Gg: ASbGncuYhb5ZXa/3toLeoWhBvxyDlB1zvg0yEvqEODnbNH2fdp5OKUjfqdGk6TwiEtU
	OAWYr/wZeUZsqqbEZlT9efg4MiTKA2boM3Lon
X-Google-Smtp-Source: AGHT+IERxfeFHnzWGjnXWaunMgWNYVqkpPBsLMjAfHFuRIKYyNJQAYs2iiNndqzYqxmZbY3OMdZCdjicGUrYBZW+yZ8=
X-Received: by 2002:a05:6512:1053:b0:53e:bedb:867f with SMTP id
 2adb3069b0e04-540905aacbfmr97792e87.41.1734049630826; Thu, 12 Dec 2024
 16:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-3-arnd@kernel.org>
 <CACRpkdZaoD2vqbCi1AFUa6mF2_=c3Nu4R0CvxFAep0VMgtMtOQ@mail.gmail.com> <20241211152257.Igx3aT2Y@linutronix.de>
In-Reply-To: <20241211152257.Igx3aT2Y@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 13 Dec 2024 01:27:00 +0100
Message-ID: <CACRpkdbYU=Txm0zUWDWvNXA0JHRNGpy1ccy0zQdiBb2Ya+UBFA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: Disable HIGHPTE on PREEMPT_RT kernels
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 4:22=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2024-12-11 14:29:29 [+0100], Linus Walleij wrote:
> > So fast GUP is supposed to be lockless, and should just not
> > have this problem. So it can't be addressing gup_fast_pgd_range()
> > right?
> =E2=80=A6
> > I'm more asking if HIGHPTE even acquires a spinlock anymore
> > as it is supposed to be "fast"/lockless. If it does, it is clearly viol=
ating
> > the "fast" promise of the fast GUP API and should not exist.
>
> This is lockless on x86. The problem is ARM's
> arch_kmap_local_high_get(). This is where the lock is from.

Aha that calls down to kmap_high_get() that that issues
lock_kmap_any(flags).

But is it really sound that the "fast" API does this? It feels
like a violation of the whole design of the fast stuff.

Yours,
Linus Walleij
