Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F88381AA
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925206; cv=none; b=ZbNW1YqDPOAZYD8mpbnvkiFMODJAwtOL2QXNE+vM3any1+OEIH/aJCAvOb8LiblnTZCO/Lk+PRzAB80b7C9VqdUvE9ITaTw8pmkWhh4v7dohgjiwp2HCiwejgR9LSVfTA8TiaOVt1ZIjpK524TLg+jjc9pUnufcFXxBu1hvtkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925206; c=relaxed/simple;
	bh=mLDfF6DLkAmhFafk0UNWf4nDRiuWWXkbwy0Q4hCTIFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoD4sFkvmGaKX/5JTsLqicm4RYURt3PnzuGX8Co7NV/myCkCeHrZk2JazKy2M9c4zzAYeXwPg/0UiFiX64QwCeZ2eGxZNzAaFq2gxabtiBhSmYZaVZwono8o/zPkFBFgoZYDM8ShBtxEZw7w/0xJHhx6ITtuGajSnpHXomtxzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sjwV+FFu; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjwV+FFu"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401c52000fso3339117e87.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733925202; x=1734530002; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLDfF6DLkAmhFafk0UNWf4nDRiuWWXkbwy0Q4hCTIFk=;
        b=sjwV+FFuKc/2I08uf8rxaTl87ODqCxoNizjUCtL10U0Bp/QjFgaRS33elmauMwgOGA
         OmkbwpNpmz9y/4C20MbL6zQyRg/QYVgdBwkYZWWoWuH6IrpMMKV7PkRl/TJnySzVrZOw
         4psM3+j71SCPfxIx4moekV2JjpdSyQznUS5Fcvs0rZaM3L4RaKDePhfNx3o1crKHoCRA
         yXbwBCKCrFdvyKYnm1mT4Fu5cRnsDaGiCie5ij0CDrCLiX8LbaBfjZBlG2kEWcfd3zxq
         cI8dpL4wn/ibD8owfXcfgPa+NuxKts8QEYH55k9K5xtfesS3JBn6KlnYYFiB9XTQ6oc2
         H16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925202; x=1734530002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLDfF6DLkAmhFafk0UNWf4nDRiuWWXkbwy0Q4hCTIFk=;
        b=dbnqdAk9quaHgD3m2yXzsWN70vk1+J5xyxmezq2OiVL60lXQro9tDbQ8Z4b8jaf8NU
         lZTUG08GTgvlcTXOvI3QhZoTdbWpvVPmNXpsSad+F1r+cB/+Q0SHgaEdsxM6zU4ngEB7
         34GXeSI4x4coHEIJU579VUXns8xrNrMkLB7f4BoweGSCZZ3aq+d4h3lHwmSQMCObweBz
         jMC0MhSV2FVo3J5OgRftH4ALlmi4GvSXf1QzOFjrjBzNX/6LwVfx/o0B4jjkku2pHgbO
         qZCp19HAmRw8osO/iby6n2Y0U/XyycyS5vPNCiBEjv4+QBGf+5Ok07fImCu5Wo2Qpwqu
         QpZg==
X-Forwarded-Encrypted: i=1; AJvYcCWn/EcsamqBpVj/aebrVvPL69csMH7HfTTQ4rUE1utURG3cOT1aosbDNeQvyjOvnAe9MSKMaAqeTwX1BjDQ1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4jsqZlk8yTztsk1SBorB8/Z0V+s7yCEFT6EiFwfL0Cv/Ux3R3
	bK4Cy6ATStaiVjnPURgLA763hq19HubBog3GlWID5CQAQvnQqicMtqBHItAjzvHUEeZUAE/4tQQ
	zSHyS7KQ3KpekdLaO7JxXOwU3XRv16QwO1Ek2EWk/Gr1FIsYmxs8=
X-Gm-Gg: ASbGncuUOKUboX+GqI15WAOIb5X/eyuMrVQkbhEelQLWplDYwHxYVXsegLukU56dOKW
	S+Ig8udgGxnf3NyFhdBvBbTv0gmkZtClHxg==
X-Google-Smtp-Source: AGHT+IFpSpr7Oj3qJ4QCRaMyoAXW3T3Mn4cdU1emXCSwCgqqhtbRU6US3c71ZX6xXcz95RXUg/DvJ1LdvBmYYHR+JRA=
X-Received: by 2002:a05:6512:3c85:b0:53e:1c3e:34 with SMTP id
 2adb3069b0e04-5402a6056a1mr984021e87.38.1733925202578; Wed, 11 Dec 2024
 05:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-5-arnd@kernel.org>
In-Reply-To: <20241210160556.2341497-5-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 14:53:11 +0100
Message-ID: <CACRpkdbsN9WNZ4Fo++FvK+2xxe6VF+66oaBgs4+o3oGUfW4OaA@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: drop HIGHPTE support altogether
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

> From: Arnd Bergmann <arnd@arndb.de>
>
> With both x86 and arm having dropped CONFIG_HIGHPTE support, no
> architecture is left using it, so remove the remnants in common code.
>
> It is likely that further cleanups are possible in the page table
> code but those are not obvious from the config options.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Mapping PTEs in highmem makes no sense to me, it's better
that we try other solutions to move away from highmem use
altogether.

Yours,
Linus Walleij
