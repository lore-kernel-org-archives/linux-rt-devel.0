Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2132857EE
	for <linux-rt-devel@lists.linux.dev>; Sun, 14 Jun 2026 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781441765; cv=pass; b=Aqqx2QwgNuP6xa3Fy/00TMe69azUINUGiGOY97naZOGF0l9mynCMKW60Y33fExDPIfsSx//PY7G7D5GUvqetgh77HZ6pXuTF77oQEOHTm09AfuETQv8NAcZAXDYA6tCRQJ6hwLYxfRso3mb+1rsBgwzYFLCkrz5NpfF8OH2RoVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781441765; c=relaxed/simple;
	bh=weXwqxQBZCGF/DjDGP8L+VzYsjiEKQCKAFEJ897yvck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWUXTmVNibjJVg48Yu6F3gmbTdSwJWhijDylfv6Oh5XwGljbxMHBdh2Nu3pS5w+1ky2SOvEOY23fhovfg1GYNom98g4K0vGD5N4nmDCc3ejTnU6e76byjQLg79ZTJdswV7i6ZukN1mPHvAtsdMIED6htaDY6Q2Nd9rGeyasXGLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=CFXBWbfC; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="CFXBWbfC"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4864abba33fso1587422b6e.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 14 Jun 2026 05:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781441764; cv=none;
        d=google.com; s=arc-20240605;
        b=CeyWbbCjn3vV5sT9gk3roKsTIYYjeWNpz1BbNpSNS2Rr5t51CdLtsizxfTFA//eAXx
         840lb8UHF926SQO+9X0gqZlTzb1AbBdkn9Ufu/S9Hj3b9TwdzWbk7gdx4+7YcasKmlVk
         6hl+7I519J+sC4WpxDR68xRbKvHGM2zk1wBRMeDsRq7QS1LMKksbhqreSbFKqbWxu6Zk
         D99GKVKwNfXDXd5qxKoIhraDSDJvvCxR39M41dtAM9CTBtuI8xBISZW/Yvlu1TickIFH
         0HKEcn2rQbHMjZp04TKOqc+6syC31161hFqHZkpUZTGTjnwk0EpMEGWz8/Su75oLyP8L
         LPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=weXwqxQBZCGF/DjDGP8L+VzYsjiEKQCKAFEJ897yvck=;
        fh=Mc40B2Gu27r2A4lK2H22KA4nVKODI92Iimn+z9BLmc8=;
        b=VnGdibfx5JGglhJMt5/viZpqa+TtuMix0563YjXbpFpXTPgmQNxWlxbzpMk4ElL/ez
         vn47p738JPa5Hbx+dORf+pWTyd0tVf6fuef5wgKmnAD/viAvP9Rm0lUfNMYFhNpOfx4O
         XZuK3ecHsIZ985vFUqW0Ys0sx7WRf+X05v60irfBgPOo10OR4EiFer+Z1mqQWn/vSbHU
         WU1XvHFOtOK/QH+BV8FyrUTckKpEwJiR/ZDlIAEe855wx34JSBUr79kEKyiL5xMmlAq5
         CimPa/PCzJLr9yd54Fnz/XLlZ0FLBa5mU1A1evo/lsx7kWMmso90k56S0GX2sX8LGJSY
         gHGg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781441764; x=1782046564; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=weXwqxQBZCGF/DjDGP8L+VzYsjiEKQCKAFEJ897yvck=;
        b=CFXBWbfC2MRO7EPvfha8wcgw86a4ltpYefwzSTy2We2JGzvjwidz8rZP+v7E438OsG
         IbyYKlWIKSAt0j+nzqFOpvhooKte+/Z6Zt7jG+wWxp+vWmDCEW8L9DGuBafYRN8xOPRS
         I0v0ItOKO6qRZlOT0QNJW/S5fEyhSFEuYmBfzvrIE1hW8P78DLGXels2J7CQmfv/pNmi
         eK2hNBv8/IYA9lR9aMWcAlIfEVouoM4aNCQEqpfhJWhk1qODaBGkjvoOQH3BkX9JpjUv
         Eqvx9th0lZ96+ZoryYkeVOL07zaACEVJAspCTMavsFiw3hbt8edmTWzB8DVqib0xLcKG
         W4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781441764; x=1782046564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weXwqxQBZCGF/DjDGP8L+VzYsjiEKQCKAFEJ897yvck=;
        b=O0t9mDO3ZHxhvIJHYJwhmuLYH9aAAWltYJcJ8oo0B58yx/0CDXJT3jfZcYUM2kDY3K
         MHdzydLtoOZtK1irY7N+oGlKz0djGdt9LrU5zJVstR3TiVDPhXKCM3jAFavTKn5nb1Q/
         usrE52cEU+1Zkn7Gdfae4R1BqR+zSw+UDWyNMc/f9rZVD6ZQgge5pKkLI6WHxaAfwPqE
         F0s4YqHyz7WyEkKxq/QjGQp7KZOqf7PI8BaCOjID04zosnn6peMXDsXP5wfsR2yLgl8M
         ZXhflAfMyCiD+JuFhvjSK/r2A16z/Y8l3BdZzhN1XJ/CGvfBqMleEXTtWVD89QRasl+x
         WBYw==
X-Forwarded-Encrypted: i=1; AFNElJ+NYXcJhUpqXQp/PrNUppn4KMrU8UmZJzqjMxYTpC54XMIJKi+ZFoHH3cVSfntYnNZofI5PEUFeeUkQnZq5QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMe9HUEvZxRr1L64JPMHNVYs9Ra02H1Iu7lD5ubWbPoD5FIv/e
	Czol9cUQJuaPEawgjJfOezejXslgOdT6RAhw9szOmgskUOxJAPFnJdnjAE71lW5Yzbv+DqfQ0yS
	sZwglG1dd8yjDQ8hCHNEEx7tfs0VjC4lqgv1uJTqOZw==
X-Gm-Gg: Acq92OFnG+jO9vTRrpx6s+o7Xa8J/sOpezr+seinKdiNl5MPUlXclT8WWl3w2R3821V
	+p5u/L7ugmUMwG8nkXlUCLCqwINRSUXSnFsAhpsEvFY83l3+9b95jIrgiJhe1tABOxzl7GUFrBe
	72p4R8j4zEEl8gCm5tEyDVKcDL7yQBgEM9z8P8g0TAn274HRwaGdVAykBdJ0f9icWQZUHMozXS7
	TLgSrCdWiWb/wgzmsDptdlQTNlF/Yyd1sacaPz0iHGJfvB3CCBQkkkPL5cU7zCjirt59hMx4Za2
	AC/eGVGRkL2QUaErmMEzlW76fdV0TXqn2NLqn0E8DnozGE+WrxwBxeUsNW/UCcfD1IjaD8wnuTy
	Cpu7cthXR98UajpLeoMNzwCsntROXdLi53qz1wt4=
X-Received: by 2002:a05:6808:3025:b0:486:4b79:12b6 with SMTP id
 5614622812f47-4872dde9912mr5576862b6e.9.1781441763846; Sun, 14 Jun 2026
 05:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
 <20260601-deprecate_boot_delay-v1-4-c34c187142a6@thegoodpenguin.co.uk> <aibfFQpK0Se-SiaT@pathway.suse.cz>
In-Reply-To: <aibfFQpK0Se-SiaT@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sun, 14 Jun 2026 13:55:51 +0100
X-Gm-Features: AVVi8CcZ8P3gD-g-OZJNOPUE3PVXT5e3I-du7zp9_GgQG2DxRwtKKm-rCROOcqc
Message-ID: <CALqELGz7F0eL9e70OfJLMFLNKDhCG237hr0gG5qo-8pDuEo9Dw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] Documentation/kernel-parameters: add/update printk_delay/boot_delay
To: Petr Mladek <pmladek@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 at 16:26, Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2026-06-01 00:17:40, Andrew Murray wrote:
> > boot_delay has been deprecated in favour of an extended printk_delay,
> > let's update kernel-parameters to reflect the addition of printk_delay
> > and the deprecation of boot_delay.
> >
> > Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
>
> LGTM:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Best Regards,
> Petr

Thanks for the reviews!

Andrew Murray
