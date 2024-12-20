Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65FD1CBE8C
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734700233; cv=none; b=rXcIEAfjYQAuU+UJZFYooCa6CTuTBqz0l7qvnC9aEHFVx9FCUORa6PgJGE6kpAlSS1AuGEQjpCfjYFf3epzlqs3VoUH20dVXG2wcHNRi+Ikwng6kHs+vv/+C1b+Id27HDUI15nv4oWWOgLYAa4Fr9HhiAWpl5B0Be/gbtBuna7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734700233; c=relaxed/simple;
	bh=qrHqZqqEaVMU3oCHDCS41i+I4fc1QPJYYRzHrA7T2c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riABlUM3Zlrsb1JU0kS7ZjVss2tzMbR2mGJEwaS12qUlnToV3Kmx5Xm3H6ATUNG11PUMxr13P7DDrScR0+6zhyN8baDr1p5kGAYq2M3CF2nSRK4wNKILkA66LEelfaErlcpQ+O9rfeogFdxnTJWwYR7h1hVlk5lqvnJKxxp5158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CcMsfQcg; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcMsfQcg"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so16801951fa.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 05:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734700230; x=1735305030; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrHqZqqEaVMU3oCHDCS41i+I4fc1QPJYYRzHrA7T2c0=;
        b=CcMsfQcgzScqpm98+/oWGCI/SCZsPChdiooHee/VMZhJQNpwj/byprgce69TMWk8Tc
         7N0/8t5FvpgPGJX1BmQ7ptLzW7OC2/0x7fb5L380XhHIbsO3fPcY086zvRoj5BiJXHC/
         oWgP5V5LoH3VGaPWjTL9hBCBim2V9WdxrvNDs2JTYzCCH2s87lcA0YJ0tUtf2mTHbQil
         +PzO7a/13gN6ziYwtXBVL3UAX6QXPNwUGNJQJNT+frKnpJX181be1/2r9fBcgqJ5BlSU
         7l2jh9szbO9OkqDzxyI9/YwRrbVvJDzcAqgFzOqx+6iJqGd7BUuhWI9a1VwPd2PIl2YN
         IHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734700230; x=1735305030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrHqZqqEaVMU3oCHDCS41i+I4fc1QPJYYRzHrA7T2c0=;
        b=JAQ7NHUCipVaaM4uMUq0OV/+NrcxJbEEqjuZLzTwRkrR1oXID0TX/7EyLAGYQ3cJHY
         gwj2ObfHk7lUiV3famH0YVEAGUjKeZlcZORuhcVUD5xD69gky4y/AULPqzY+Z8OH6iie
         qcDHmAA+ybVQtXkjm67RKXhcEKWqCG4DqqpnFqyv+gES5x/Zn6CEV8N+7tak4AjB5IWa
         0snoBhWkl4yUWoOjY3IH1vQVqIOWtP7jcTkO3SXxDA0rMRXPaTV/yvZgDz9YuzHQ2b/U
         tCTo79dVUhCCTwFgDZMWlR4qoJxHzj7vgasBVLG4gUWCtbmZfxTqHU4dRCw4Fxaa4yhX
         Z0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXQpPIxZHkSt5E39ns67aI7qK86A5wImhRA2gEjFsstQXxmIEf8uI7F9/zhkg8RukCwdcFNoSlmsEjmNOq3Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvMaFMEWf2KgliQSAw7x3L0rXela4yIsi9Mj8BvDwWPISMXmY4
	WeLWmXAuBif44XT1UJhO8p8V7F2XdldtoweYJ+sa1TQBHt6YIInTKtpjcDRQKhOSfDsu/2USbAz
	V1abOU/8xjE2hVfKxE44YIX+TW3VY4WWFMBRMlw==
X-Gm-Gg: ASbGncvA8jxmI1U4udm9RDe8gY1BcSjplpR/rgUEe3KQJCO5QcbkZ8e6dKd/sd08zhU
	PN0q37NU5+XXCE2Ks0KeZ3yzXoNTJ7wCZbfLv3A==
X-Google-Smtp-Source: AGHT+IEsWa7ECublo4QBSm9SpricFNqVcJqJSRxA1U/TGctMJucN3JX8+bo5j0L+A2ogMgWJu00AKQ5Mn/t8hFoEZhs=
X-Received: by 2002:a05:6512:b06:b0:540:2549:b6da with SMTP id
 2adb3069b0e04-54229547969mr730789e87.23.1734700229726; Fri, 20 Dec 2024
 05:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-4-arnd@kernel.org>
 <d54e11cf3f4d4216b5cecf29b761cd45@AcuMS.aculab.com>
In-Reply-To: <d54e11cf3f4d4216b5cecf29b761cd45@AcuMS.aculab.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Dec 2024 14:10:18 +0100
Message-ID: <CACRpkdYihj15SRp5t_8Aq4i4jtgP1-VLOSbbKG+ozLgiAuLgmQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: drop CONFIG_HIGHPTE support
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, Ard Biesheuvel <ardb@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 7:41=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:

> From: Arnd Bergmann
> > Sent: 10 December 2024 16:06
> ...
> > Since Arm is the last architecture remaining that uses this, and almost
> > no 32-bit machines support more than 4GB of RAM, the cost of continuing
> > to maintain HIGHPTE seems unjustified, so remove it here to allow
> > simplifying the generic page table handling.
>
> 'Picking at nits' 'highmem' support was needed for systems with 4GB of RA=
M
> in order to use more than 3GB or 3.5GB (depending on the bios) because
> of the physical addresses that are reserved for PCI (and other MMIO).

Wow I didn't know that, there are so many reasons why highmem is used
by different architectures.

On ARM it was originally added for a certain Marvell system with
a mere 2GB of RAM:
commit 053a96ca11a9785a7e63fc89eed4514a6446ec58

The reason was that since the virtual address space is just 4GB and
we have reserved virtual kernel memory from (typically) 0xc0000000
only ~1GB can be linearly accessed by the kernel (actually less than
that).

This wasn't a problem since no ARM system was using more than
1GB until Nico ran into it.

So the ARM "high memory" is something to do with virtual memory
size rather than physical memory reservations as in the x86 case.

Yours,
Linus Walleij
