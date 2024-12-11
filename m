Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E71714D7
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927501; cv=none; b=a6tA0Ok7EvmOc8u8CiUFdExl81w1IySB5Nty632kFKvTWowD3shPLN5K2U2fUb7Mf8ihWRzEP431m5+tM2yh6Z54jY+TPEijNXspSRODy0Ea1a+mk+Ql8hwdpQ4lJCS7mGf1pumqbUwKu6WXS1u8kpyC38jggjsVrXtnOhXV+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927501; c=relaxed/simple;
	bh=6MstwZEDzmfmfSlqeYA+EvXsVRXXP3jiezLL4oDN1/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfkeALMBJDsdUFhRugESbJbu4MyaxyP7wkFfFo0pY6RKfwsj1ZD9xGaVlRPHnvtrN4V1Vdwm9KROVHLRYvD5TGJjCoF26p3lA8WG/lVpOQwR2rOpH7O/c7aLC+Z/1b0mz0MPElr7a49c1WnOWVETuKy8N6Pm7hPLJGqnBOciVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h81u7ikq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h81u7ikq"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df6322ea7so7892822e87.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 06:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733927497; x=1734532297; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joWVG6YN6QwtMFozXajr6ob38hx5tuGFB2YqQJWxAV8=;
        b=h81u7ikqFCWFLclMlc8DZ6l5OEv3MpnScTHersIuD9qPpn5QmhCASa9ISHTzomWUdG
         2m7TIvtywyXL6Na8Bja0Er4ZylwxYhN1POr+roOADUnNxen/c/eBi/OjevZF+hVG23g1
         WGiX9M9mLJVm476wFS27n/bjM6CfQUKr4hb8h08vUOF9BV3CskadUxbeNN4uNhiM7wYp
         HlJhQ+9bAdSHPsB2eYz763C6gQwRcPctjwc2ESxQM/1TeFIsrwfRfhuHIPS6rjgWyl4W
         5eMSQTucsG5VSUU4U38iIT1kHOtEKbqzNYZY5AZFDjYqoVSK0oF6VOb+Df1QcwqBj9Tg
         2/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733927497; x=1734532297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joWVG6YN6QwtMFozXajr6ob38hx5tuGFB2YqQJWxAV8=;
        b=fZIc5Vr3T0E9UqgmF/seH6tJwwRIeOezRrKA2qjEaGlkE5bOu7zZZQ5c5vCiAX6l+A
         /MwZ4iTsLs6PJ7HzC2Kxfw6pTGlZ9eUX9HGZun5tURSbRCbDIT0X4YzfKM4FALU+pcQv
         fldG42PG9fzGsSKX9xnhqxW96zJ2jrIanlu6X++ZijDgBJuu0nbgPsExhgMXQwzYlAsB
         7MedQ4tUUlyNKnoFVfzwsilfa131j1aay1PecBUBYN3vlkYUONqdrcvSYhj26piD+T6E
         gOrvu454LEMyHkPYA6CSKHqveFDovW581IXd5YMvx7eGU5PC7x7vjFGYsMDlFHOaVNyg
         BeeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPQ6HtQgDa/s4sdpC4j+PSJQoIbwD4Wg8PTAxZ9xEuOd9Ssg5CiyX/rpB43QbXIPHdofLjOGCBzDElnB8MZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQUiC8rUc9gj0r5Ks08TkZotCuUK9OFYc8oBkQazhS2hbBxdXm
	s4RXG2vJsirUmUHTwJEtQzScvGpfE5bolHoy1ELv/hEhWuN9GzjGWc8GmMeFvpGq7htaVvgtGzy
	L1ZHbzVi6c5p0+6iULI9y1fkXvs47X8NAll66Kg==
X-Gm-Gg: ASbGnctJNOEaH8LU4Mc2lBpkaoUtdcOkbX4lGJBfz2GnzxECP7gG2Qscjkdu75pLpqF
	hPrLyyPvzdX4m24Pi3C0X+OHhg6SX1ltpXQ==
X-Google-Smtp-Source: AGHT+IHhJBv1eQWShQpfw9LCRRpH2r8wN7wS8bE66kjHN+lCkD0sEsOjQXTbJhT/aLj/ehPesnm+dGREvL7jpex48dI=
X-Received: by 2002:a05:6512:1592:b0:53f:22f5:afdb with SMTP id
 2adb3069b0e04-5402a6055f8mr981790e87.35.1733927497423; Wed, 11 Dec 2024
 06:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-4-arnd@kernel.org>
 <CACRpkdZoRbJ4DwRpZQMKbEAvzg4AAdp4B+94SFLm1ssiQmjUwQ@mail.gmail.com> <Z1mYufbtXpeEwTAq@shell.armlinux.org.uk>
In-Reply-To: <Z1mYufbtXpeEwTAq@shell.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 15:31:26 +0100
Message-ID: <CACRpkdb0g4zGQ-xu3yW=rRmz0zOVYnr-c-KaTSr155YvbrAv8A@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: drop CONFIG_HIGHPTE support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:51=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Wed, Dec 11, 2024 at 02:32:51PM +0100, Linus Walleij wrote:
> > On Tue, Dec 10, 2024 at 5:06=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
> > > support. At the time it made sense, as the CONFIG_ARM_LPAE option all=
owed
> > > systems with 16GB of memory that made lowmem a particularly scarce
> > > resource, and the HIGHPTE implementation gave feature parity with 32-=
bit
> > > x86 and frv machines.
> > >
> > > Since Arm is the last architecture remaining that uses this, and almo=
st
> > > no 32-bit machines support more than 4GB of RAM, the cost of continui=
ng
> > > to maintain HIGHPTE seems unjustified, so remove it here to allow
> > > simplifying the generic page table handling.
> > >
> > > Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kern=
el.org/T/#u
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I'm in favor of this if the x86 patch goes in. We need to get rid
> > of highmem anyway and this will need to happen sooner or later
> > either way.
>
> Well... I use highmem routinely.

Oh I don't mean we should get rid of it without any replacement. Certainly
systems with big physical memories need to be usable.

I am pursuing two ideas (inspired by Arnd and MM people):

1. The easy option - "densemem", on systems with a "hole" in the physical
    memory making the 1:1 linear phys-to-virt map run out too soon and
    overconsume virual memory, actually collect the physical memory on low
    virtual addresses by elaborate phys-to-virt virt-to-phys and page
    numbering that isn't 1:1.

2. The hard option - 4G-by-4G splitting, making the kernel and userspace
    virtual memory spaces separate as it is in hardware on S/390, so the
    kernel can use a while 4G of memory for its needs. I banged my head
    against this a fair amount of time, so I might be incompetent to do it,
    but I still try.

Yours,
Linus Walleij
