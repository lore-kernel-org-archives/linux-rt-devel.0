Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5B501F4F
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976006; cv=none; b=i4ECK+J54R/aCK4Y+AQhdZfTjVRNB5KWVlO8umhNbD5xqC849WnbIPqgsvnnq06sUa5yMXRjEetMpP6GdoPevWhMV/r2PZBJMh5xuD8zGGXGhkSIGM5hwKLo4ZUQvHZz6bw4pDPdsQ3f+d2b7zui0yiYnWxVqKU8hVYv7UPFPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976006; c=relaxed/simple;
	bh=Q4sS6ysJkh6bVqmDm0t8nwutvdPtgGri+t2E+qvwZrQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=gHi8nRlRWC654Fwjh9qz7CbFTQaaMsFPBaByy5Z+Vx2jH/6cAdA9Vh9oSLguDvQqOcTn1ff/QawLbCszFR8MCHtC57VgwDadHvbiEgDFZAwdvUMoPDqIJJcCtGfPyoBBT/F2zL328ASHBLtWOe1SSZvr9APFH0s7fBfS4LdwUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewCood6O; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewCood6O"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3abe4fb64d2so1741940a91.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791976000; x=1792580800; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E41qJNRzVmPfHenlZSA2Vl9639pSTN9ZvaDbaLPA2p0=;
        b=ewCood6OGa8oFXvtX1O86h+sh9cy1/EgLV7CKlv/xnNF+Si9yhIqL8db52oYRkI+6K
         jYIsiC/AoXw3PGhRuB0EkaANTnEk6daNN9YDMKP1Lho6As4GwI+Db1vtbMm8Y9lP55yc
         2Jic5SLo2p8/IHrp+rFrMXQ8x8MHBb8AFYezrEOh0b75HMV1wO/7RI/xV2jNdV80EiBy
         p3W8GGApMe2HRl6CfwoyXpXXdxoDGMXD7ktbq3GjWi0Yehf22QKfIqM01mp6+P8kzPtd
         Lg0GTb1uxv3k8YnQY0IjPPLWf2evOg/dJZUhRkccyMRW+SBjyb+dRKkDO6A3v1j0aasQ
         L7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791976000; x=1792580800;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E41qJNRzVmPfHenlZSA2Vl9639pSTN9ZvaDbaLPA2p0=;
        b=ACzINQN12pDXJyMFiiH3ZRxha5oYLNEPHFiUFCewVG3WoSe0WiIHu+vZ1l+t+QiP1r
         6NhQ71VV5ouyxHx+Y4BnZRJNIihgieHjQbg9olKsOOyI6ZD4co8vcUs15iobTM2hP9DT
         eGmipaaqoC2xz9xRv5fcn0KJw2A+vHKVoD45u/2XYx1AAqJfw0fvGxLUXYjoSmZDt4Ed
         2+EMyav3SELkDO5FOBmt1SNxZQLs/Y2gPNmxpQTz8ZcP7oFOKCxBdP6u8csACcAkbjC5
         CRHl5w55IneoIFVX+QPRcy7Jfk2nxoL1jw3d38WHEvlG01RaMWyZkaOiauijD3sM6mlK
         NbYg==
X-Forwarded-Encrypted: i=1; AKwUvBwaCx2Hg6G1lPZV/V+s8/hzO9f5fVflOC+kl7uimXpAaSc6QQTmcTlE8kyqzWxbxDUOzDAD058pVTnCqdFYEw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJnJiUuwUAs7zfh3MZ7l2ECrRwo2nO/sJUpT3c7WR4prQyXpdcA
	+O7XopVnWaxOqMCmIke4bYHzbfM1E3j15NNRxm3WP3I+vM2BUYDYKM0Q
X-Gm-Gg: AYBFou0bgvjsBX/zo1d3CZFhgdaDlT5nhEZWUSUQkVylOOjg9bR6ZiXwZD2Aevopnoe
	eHBuJ+bkVzDh5DaAUcn3a4v1iWwUZukJjaWhXDJz/IxdIVRg/GnppiNZevKp8dh/XFTry2aym0a
	lDFRjuJ2Y0wUESiAerBkcUjyOSW2Md25P5fGjxGnYf0KUtGAH/jSHhIsmCXO8aMZ4nQtJw1z9wr
	9JyxS0RBTBRFp5I+3fzxJ6y0YPGDdYeDTFWsNo6yzAK9CpX9dfa5dS87jqbwXsvX6aXxwpIC/p5
	QqKfxTtbMf7SuEQaXnLM/OH3VEJGxzjfBpYXtal3h40nYwVJ/YHsUTNf2roJu8013ZwaIMK5QQN
	2LVaI6Kk9CklYtC9oeqrOiLhaDpv1HG8cNmgE+SAImAvLA4yZjYO8ufGnQ46xy0fLMxDsH6kBgv
	FSPA+PoSxGulPfVtqC2ZbKFlih5a/8KpfVIUdEJwXltH4UAsM9cRwDR6CFiDlEz2WxRiJEo71wy
	7xQD+8qrmAn2nw3UjlJaqIx+Fu+TrM=
X-Received: by 2002:a17:90b:4a08:b0:3ac:4e91:bff7 with SMTP id 98e67ed59e1d1-3ac4e91c1b6mr2825151a91.48.1791975999552;
        Wed, 14 Oct 2026 04:06:39 -0700 (PDT)
Received: from [172.20.10.4] ([240e:471:300:dde:5eec:32d6:f33:1d4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd5e2b79df5sm5281837a12.19.2026.10.14.04.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/2] HID: picolcd: Fix output-request and
 framebuffer locking
From: Aveline Noir <jm5905938@gmail.com>
To: Aveline Noir <jm5905938@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 bigeasy@linutronix.de, linux-rt-devel@lists.linux.dev, deller@gmx.de, 
 simona@ffwll.ch, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
References: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
Date: Wed, 14 Oct 2026 19:06:31 +0800
Message-Id: <179197599193.532954.6543599494592547892.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791975994; l=2119;
 i=jm5905938@gmail.com; h=from:subject:message-id;
 bh=Q4sS6ysJkh6bVqmDm0t8nwutvdPtgGri+t2E+qvwZrQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgboJ0y2WZIrQV0H4HJI1WEQ5sxS6pM
 Nc/XEYGLW8ee6wAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJSB+KMp1PvZyKEm4roi9iB1DW2hPjN7sh98ZjltMhWCFYkG+UkBAjTEszr3F5A7A+M39+3Sa31
 Dwagjpf+n0w0=
X-Developer-Key: i=jm5905938@gmail.com; a=openssh;
 fpr=SHA256:oSxqik6Pl1M8EjQW1QXKHoylm1jy0sguOWFFJlA9zf0

Hi Jiri, Benjamin,

Just a quick ping on this v2 series. Have you had a chance to take a look?

Both fixes have been tested with QEMU/UHID, though not on physical hardware. I'd appreciate any feedback and would be happy to make changes or run additional tests if needed.

Thanks,
Aveline

On 2026-09-28 18:15 +0200, Aveline Noir wrote:
> This series fixes two PicoLCD locking problems. The first moves output
> requests into sleepable context and serializes LED state updates. The
> second breaks the last-close/deferred-worker lock dependency using a
> private framebuffer update mutex.
> 
> The first patch was tested separately with the original syzkaller C
> reproducer and bounded concurrent sysfs/UHID-destroy workloads on
> PREEMPT_RT. The complete series additionally passed repeated framebuffer
> open/write/close and persistent-open framebuffer tests. Pre-fix modules
> reproduced the respective failures. Physical hardware, prolonged stress
> and suspend/resume have not been tested.
> 
> Patch 2's Fixes tag identifies the fbdev change that began draining
> deferred work from fb_release() while holding info->lock. Patch 1's Fixes
> tag was checked against the upstream transport-conversion diff.
> 
> Changes in v2:
> - Address Sebastian Andrzej Siewior's feedback: clarify that the issue
>   is not specific to PREEMPT_RT and identify picolcd_data::lock as a
>   spinlock_t in patch 1. The code changes are identical to v1.
> 
> Aveline Noir (2):
>   HID: picolcd: Move output requests out of spinlocked sections
>   HID: picolcd: Avoid framebuffer last-close deadlock
> 
>  drivers/hid/hid-picolcd.h           |  4 +++
>  drivers/hid/hid-picolcd_backlight.c |  7 ++--
>  drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++---------
>  drivers/hid/hid-picolcd_fb.c        | 56 ++++++++++++++++++-----------
>  drivers/hid/hid-picolcd_lcd.c       |  7 ++--
>  drivers/hid/hid-picolcd_leds.c      | 31 +++++++++-------
>  6 files changed, 93 insertions(+), 58 deletions(-)
> 
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> -- 
> 2.55.0
> 


