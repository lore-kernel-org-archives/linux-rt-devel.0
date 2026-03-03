Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0386535C1A1
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Mar 2026 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545817; cv=none; b=DOo6fDWSfXHmHWIEFz94vfflDFd8R4X3r3WJV+ZQr2HY0uhK0sYgmarFAXbFvBkmrZi9sIW1y5plic1KhIVt0mxoMAIpSbtZptZUKmMlddbLvfc5q39oMlxkM+OrSzZPrnpESWoqp+dKwiNAHJbz1tjWVCE1py/LhRjiUbCP0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545817; c=relaxed/simple;
	bh=RDYgonMLZZgBvRizzxm+UNJ3z8Y0vv51l3EtJhZlR0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrFZKMTrx3l+/vW2tSdTkErPXuvJctqoAlKaDbZZWOU+zpLCaZ/mVpYFLF3TBF10Dc9UoW1Wlg1pz0ghbDD3uufSRr5duu7n0BfpDWKK+2+yrcuX7rc4bqjknWF600u1T7URXpjJzyA8kmR6yl+1XYkvee/yTDLKAFG2U4B3HyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56a94923c0aso1817574e0c.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Mar 2026 05:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772545812; x=1773150612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4n4UKmZ6iVKu4X1jPmC0GNiXXYHBrOv1cdLwQZ4FC0=;
        b=YaScGBqNciNcf9DtL6MfGKx776OMfkdojdyPrahD3xdE2j7HguBcl5i/Xf0hafQW4i
         ADcbnN9XKvxYCRP9qqkNeGksGj1ui5AzDfyQmNvShJ9Q+cdBJffyB/VX9p+zSlIchZ0j
         IF8KVU9AFk+fusGhP6ZouqNZ3pMV+9RO1vClDpAm1CHSAkRgPz8oPBRIsxW3rFfqYT/H
         Fe1FY/F5tL8N710OPt09D1WU8EerwoQJF+yw3QNvBZmvfyRx+12k1OsY31YxcKrlg3LG
         5R+nIS+IHDNqp6t3Bw3EaM6bwmFOg3c9BVNoBBull6rzhjzGvNazxoHjuyzufxJBwCZl
         Y8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUH2pv/8jmPlIZyTKuBwgFFvm7WQU6l7WY8ENi1qODqcMMQKZKM93woulDxERpsqmF6AmLHGcxesi/ImaC1VQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKpI7foT3dQjU4LyXzPfiiIlAzTPgsLY8770j9sdiFPJnbLy5y
	gbLbepFblty2TQDumn2n9MPPR7+NNvONJQ0NFNjNTrAHDJAHbN44z8Iq614Rl44k
X-Gm-Gg: ATEYQzxyDcAZ2NiiNngWduamXDEzx85bKYsZ6ArugAPu55yihLUIr6ZT3bWBkjeFKrT
	ta+IAMixCPkAF28XiV54ZggUHj9EMcIcOyKHfjE3wWBVS08Brr6LM4hCqJILusxUvl08KlTBGJQ
	d1Mmi3LV2FRz8fWjUXRDdoBSmNj/lldRaVoJ1LexzGaK75jOUDyTUnUVSNaazQNb3HjuPt6HEOA
	ZIK2FIhnrqVfU6dGtBLxK5sgM4ArKti/rvIBvOPD9/HDaNUjy5+hm0YrdLnO9HnKFeha6Aiv7WS
	g+CswZyHUDaZ9DApiw2XF/SNCPc91blhyCuR4GqEynPXT7dE9XLE74y0Pg1cncG2dl5dw0uIyEV
	JszDozPFBY5s/JWRQ0Ljp/ZH1VhmheBnKpPbaDHayPJAxZ0E+K6PP6gs0oYPSLLj+goFnikQD1U
	umPhjvLF8OPJsfc14SjgEDZhMxvtaL4TTULF5GYw9sjUQnZEo0q3Y0CkKspIEH
X-Received: by 2002:a05:6122:4d08:b0:567:443f:a772 with SMTP id 71dfb90a1353d-56aa08c6664mr6451149e0c.0.1772545811678;
        Tue, 03 Mar 2026 05:50:11 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56ab4aad2ebsm10495092e0c.17.2026.03.03.05.50.10
        for <linux-rt-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 05:50:10 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94ac5cb71feso1635807241.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Mar 2026 05:50:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMxHykhkfCDt9rf5C7DlHaIA6vtuD0P/OhTIww2D7nUWRxnUXD0kjXmpYZsFpxF89KEtLU7HGfjkB721ns+w==@lists.linux.dev
X-Received: by 2002:a05:6102:2ad5:b0:5f5:2ab7:cef4 with SMTP id
 ada2fe7eead31-5ff323530c3mr5306088137.12.1772545810046; Tue, 03 Mar 2026
 05:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260205103930.666051-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260205103930.666051-1-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Mar 2026 14:49:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXe2EXW7j7_Z9KSb1tYFbsEfC63HSvDBycdCYH4us2MDQ@mail.gmail.com>
X-Gm-Features: AaiRm5373kqYXoPI1qibK4QKFV_2fpSfHkF0McTh9iV8GZ-ZNcR_4rReTQoXHNw
Message-ID: <CAMuHMdXe2EXW7j7_Z9KSb1tYFbsEfC63HSvDBycdCYH4us2MDQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: renesas: rzt2h: fix invalid wait context
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Linus Walleij <linusw@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Feb 2026 at 11:40, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The rzt2h_gpio_get_direction() function is called from
> gpiod_get_direction(), which ends up being used within the __setup_irq()
> call stack when requesting an interrupt.
>
> __setup_irq() holds a raw_spinlock_t with IRQs disabled, which creates
> an atomic context. spinlock_t cannot be used within atomic context
> when PREEMPT_RT is enabled, since it may become a sleeping lock.
>
> An "[ BUG: Invalid wait context ]" splat is observed when running with
> CONFIG_PROVE_LOCKING enabled, describing exactly the aforementioned call
> stack.
>
> __setup_irq() needs to hold a raw_spinlock_t with IRQs disabled to
> serialize access against a concurrent hard interrupt.
>
> Switch to raw_spinlock_t to fix this.
>
> Fixes: 829dde3369a9 ("pinctrl: renesas: rzt2h: Add GPIO IRQ chip to handle interrupts")
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>
> V2:
>  * reword commit message to better describe why
>    rzt2h_gpio_get_direction() needs to use raw_spinlock_t

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-fixes for v7.0.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
