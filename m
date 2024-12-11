Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83469225A50
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923986; cv=none; b=Lg9NlvC4mmhCQLOwwvKzTwhz2R7ixE5zdwkh8UJHqxhgy4mv66PabZioZ5gRawOmAoAO2JA2FeRYtitG+et0hswT9kK9ygjbKm0zUsCc0UPgyrsHJYDN6Xz3rZLjKLkyUGXbatv8us7ToBDmn9TMCZBeHnOM8k10bFv9nIzX/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923986; c=relaxed/simple;
	bh=kOQcwnwJSdFL36S0cYmgulVJqIFn4KDwKugZv4rxk6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GX9p7ZX+kpOzwSpuRV4n1a4CYPjiw1F/3mTRyivfGsN89JbA/RryseLkfzg8r+nipp8AQJnqRrqvUko1yYUiZO7yoGpI4tx/8/7PXC3JVBIWbbqwkqQJLGJskVSB3o8N/1ylHO1f3frKHrMKXQXqQiDSv1VXKS4Z22VX804joyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oc+xfTEb; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oc+xfTEb"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54024ecc33dso2211371e87.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733923983; x=1734528783; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOQcwnwJSdFL36S0cYmgulVJqIFn4KDwKugZv4rxk6w=;
        b=Oc+xfTEbLm7ozMJO0DN8QgxH9NkI6GyhqQuzdnmDpDA45Sj5+DXzykd05f4qvIszma
         +PV7ejM1HdnQ4JwWpJwzWwVHIC5FiCLiBY6oE/Di5ajKdSKeYl6YNdvwjQH1iYfdVP5C
         Q6/n/hInT1XD822Vc2DyOCjS749XgkZphorv7ib4D69P6qwk6biekYhVQIG9DchF94Sv
         1HyP2jVmkhkPkmpHB9EQX9EN+buUuT2es6K009GeqVplrC3GsfsmmjYGzHZmBGjifC9+
         sheM8UKmdERfhnN8I4q27BBJuY88JMYaFZ2i+Uy85xdTOF7XizbyqZ9ftyWMu2qqVXxM
         Tpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923983; x=1734528783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOQcwnwJSdFL36S0cYmgulVJqIFn4KDwKugZv4rxk6w=;
        b=NPU6uQ/cpjceED8giyJsYWoW3jz8T//ADqu5zu9BsNEDjnqON4Ivy/QgInifzG3DJw
         oEqQHsOv9nK96I/Sxn0SgnLmxGyJ6eTydyY5w6NOlMBXXlwvd3iqU7yFPm99vq0ZuJQS
         dYWdZRcCB6/yFYKPOi3ukYMJRkqriqTak4txNwlI/RyRN0ZlyM1sjYxOx1j+4RdQloX2
         zZt7DpRjbqPFLnXRkk/NtP2Hvtay93Nb+GcOm4NVaiPVHp0RGQvTKoIrl3dXjkkk8ket
         /gco/ZtCdSkM/Yx2eRMQI94JyHcAxV6kZ0rB9s89GQO7SV97c8TFbwe0mD5vhZZLeTwM
         nawg==
X-Forwarded-Encrypted: i=1; AJvYcCUFsUiVl2lDVbwdFlm68EkRNXCpOMBC9nUp37pmMF4lM7iwG/JMrpMK2SVLTnsupICmX7rUDolAti0NIZ46hA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yynq7LXvbi9vB5MzHoNZmjT87rbmroLMwMc3XLl1HhLSSzEgMpY
	G/JCwZ6HdJSGypppIGvuYTApIfUzyC3VRBG/OsNvKeG0j3cxaA1Pygdah4umpu66A0WuqpzEj+z
	5curDMsvP1Pf+4DxZOEb7FLCrlQE8BRrg2UV8uA==
X-Gm-Gg: ASbGncvB+qps6rZnSrJl1DXCDO8/ZcXUCj7K/TP68ysNT34oV9sPCng0No5F4yvdJXI
	6Lxx9Nj7/QNoQWyntBvLgQJBmj1lZ+enmLA==
X-Google-Smtp-Source: AGHT+IFSR1UjhXcHcy5k6a2CNcZJuWgxkaipEQM/YpWhqPeqodiJy0P57HJau7brIqv2XFjLP5RpxZwdcMO+4TzEqjo=
X-Received: by 2002:a05:6512:10d5:b0:540:2223:9b20 with SMTP id
 2adb3069b0e04-5402a609ac9mr779864e87.53.1733923982633; Wed, 11 Dec 2024
 05:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-4-arnd@kernel.org>
In-Reply-To: <20241210160556.2341497-4-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 14:32:51 +0100
Message-ID: <CACRpkdZoRbJ4DwRpZQMKbEAvzg4AAdp4B+94SFLm1ssiQmjUwQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: drop CONFIG_HIGHPTE support
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
> CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
> support. At the time it made sense, as the CONFIG_ARM_LPAE option allowed
> systems with 16GB of memory that made lowmem a particularly scarce
> resource, and the HIGHPTE implementation gave feature parity with 32-bit
> x86 and frv machines.
>
> Since Arm is the last architecture remaining that uses this, and almost
> no 32-bit machines support more than 4GB of RAM, the cost of continuing
> to maintain HIGHPTE seems unjustified, so remove it here to allow
> simplifying the generic page table handling.
>
> Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kernel.o=
rg/T/#u
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'm in favor of this if the x86 patch goes in. We need to get rid
of highmem anyway and this will need to happen sooner or later
either way.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
