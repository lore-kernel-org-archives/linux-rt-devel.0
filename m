Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6B32C302
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Jun 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638153; cv=pass; b=MUxgpQJltEuw70EzwWuMqPUR7C5IETeZ7N9kcBIva/60egyc1+AYKxWDzGlTMVSh/+cegL40LsxqdJ5T22w7hdO2y0ICyfOSqON4BbwcBQdWdU2Er6jw1p/WmKvPWPUqSUgjlc34g7OrxSvZY1PqFWsjwjhhEehqiEJYFfBd3k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638153; c=relaxed/simple;
	bh=UjGnd8TK3ZsS1d9FtTAXuIVumjvq51GEDpPVi+5bAR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLKTppyqA5nKAwb1EkvhcKs6nGwGLASdYVjqeJ/vZoJRc+1d3PeKnR1YDNoLsQLqau2Ce/t29tNYd3gUr0loqxulmLw4zeUuIppP/oJkXNabAcsoH82zQGguyRkwUIRdvm5Vtle1xcoWy0Y2hf/lWwF8uc0Vn37QRWIT67LYR3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaOmFvoz; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaOmFvoz"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e718d46a6aso2777837a34.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 16 Jun 2026 12:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781638151; cv=none;
        d=google.com; s=arc-20240605;
        b=RWGnIflzfEIlN5stKizRhXDaMajHz8cTWSBpZslyvRSpHNpz9Dvp25Id06zXUdeoZp
         bexxunUoEONfZelIy7TGcQYoBfsivpOkp20XWrekxvSX5fw02M4VNs9qoywXClP3WgYY
         tMgdvc7oYQylti+453Y1g9VvwTdQ6ZZVrMReUSAndEL67ITxm4SE7SJ1TTitb61AoKOG
         obtqdNCM3LYuSZj3Xf3ONl/EnCmoST2Fhhm9PIB1jyC+xwkpI2nGFbbT8UVfWHMmAipx
         lM51yHFuJ0Ygo4RvTzLra6jehV+qtXDBcN56NcS9XOiUGQBKCw0Alb+AnSrgXbRkVib8
         87Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/DbtWcjbJdcQgrj7XNPW8S69zPf+OoH9UEMu7Hzoegs=;
        fh=WzVMVGPaOsjZP+FZmmDIUEkM6Br8o2UKJGdPnYDhXVQ=;
        b=lCZoXt8plGK8eRvdNrTzVuIEceni0+V0grDYPgBkTiqDeA9WLotW6gJGcudhW/4Mf0
         0EU/MDDT/mUvdZ3dpKue4pFSq/hz9x17bQNjew9tLJ1D+HtTQsBRfJiS7OvC9A/JvPU6
         VJ2K1/gFdkk6A4LVDsqPCP1GhGtbpvRQMmHKdHTnnH1du3W2IDXSSAr7S4zRTEn8qcKj
         XMiTb6xz9+mhnr499MqZ6Ruj82ZrFokybG4rty2Bv+JLyt0xUa/foIoLgCquWnf4eyt/
         AA87m+gvEG6AEs0NMAOCZ0DRFuDpN6j4UGAi2hC86alDlslhnY6SmRsGBR0sRmOqSJF5
         lSCA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781638151; x=1782242951; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DbtWcjbJdcQgrj7XNPW8S69zPf+OoH9UEMu7Hzoegs=;
        b=TaOmFvozugehtlQCKtuK4bg1WUdUnMr4iHQiGXXRiWE7HVbBnC705+R4RZnoGj5QsM
         O1CfMO6Yti7bS4YgAdc01N9COeTkS9IJcI+avQEnWOOqAyC29cC8Co0H/eBdmmahJslh
         SbEFY/Bv3qqIBLiWo7d6GBRiJvNBAINeH4TTDC/MNtSEjjKr/t7pypw3dBKUtol9FCZ+
         A5N/2PB33HgUL8GoCX4TZ9Il1uaz0CEohduOhTZ9HnB7R5o9SZA8gEytNKNCIqXBlrB0
         z/rQGgt+Q3mNmsZlrfHB+BmNWnVrWA8wehJjNRnXse5l9GAymqpyiaPKZBZr1bJKdUXH
         xb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781638151; x=1782242951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DbtWcjbJdcQgrj7XNPW8S69zPf+OoH9UEMu7Hzoegs=;
        b=MiFv4DJomMf1xdU3hzqtcrf7Id5zPE23OCE6B0ksSHyQUEQ7BKKCa1CUsEGIwTmQCK
         FwIkB6v2cmk2tcRSMikDPXvJHsqoXBG32WcGq6C7Pc31KfbQzBg+FIi7jbPp91CmBK/x
         AfbA+f2aKhA/iR3URl57Qpko2uNa4iryooTQjQ8qsy13uDbjn2KhZXOjgH8Ir1JdVFWA
         KHUx4h9evXAvsxdXiV2YqH3MlCHERN3Rm0/P66Qf2QhSIYkClOdgxnPiYaAB0vdegR+/
         zXnCL37RznU0JYXQ6ZDOiStwrdk10wcgZv04s1pVvc7ZfFhFSc+njdvMQHVyeeA1RBZI
         tiEw==
X-Forwarded-Encrypted: i=1; AFNElJ9txgLCQga2CNteFYHtQp7ONDVLg6AJPsQ45fTjH8AFEhMY5SFJWpFyV81+XvPUclO4/mZj4tQMA1cSW/S/rQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywyt9JN3XWsP6YJoXBFUR0AOy4EQuDmMbAWcHJ3mlrtCe0dxEpb
	TQidwssUxegBO1+G/PG1NlIMMIXsGc51aeW7fOEXQWtPvpEVCz8VQyZMuym2dvAfu5tiB13Dvdz
	OywQpHBO0vk4EjZr0Xn4vnsfz09Gr+SQ=
X-Gm-Gg: Acq92OG7PmmCL+27/BDKs9Hb/TrXJVLXzW9UqTzi4aGv7fZushR+urhR6EViUsluQtm
	UVsiT3yrJAvAiDYQiEkMthu2k7CRip2K5u+0u6kjdLS5Rr35PSTDEIQLuTwoIy+u0w/rgFeSsPF
	ZDye2I4ihvPzGZ/cjkjh3KkPqT915zT/PwboJvi+7Nm4yaiHwYJhBXUCZZwUjAu9WPUMT6fyJwo
	BLS53yCjgBr1S53qPuFioYkyDbNX8khc0x0FIR0hWzhcgqXVz+ZmFQYPj9nmX/LUYilUQ966Wav
	FGTNVfce3j3iMfRU2wwk
X-Received: by 2002:a05:6830:398d:b0:7dc:d0e3:5bc1 with SMTP id
 46e09a7af769-7e90b4b0c14mr830251a34.13.1781638150796; Tue, 16 Jun 2026
 12:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260616070914.65818-1-mikhail.v.gavrilov@gmail.com> <ajELmhO0cT9gKQUl@gmail.com>
In-Reply-To: <ajELmhO0cT9gKQUl@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 17 Jun 2026 00:28:59 +0500
X-Gm-Features: AVVi8Cee7q7usPbFYOjsHrTnVxCM5F2rK3VxWlJg_CGFXiS02kS6nyiVFDdHQiE
Message-ID: <CABXGCsO5AHLdPnukgVMzgFy1WSxPJZmWNeHr9qOg3M0fHRA0Bg@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Register default clocksource before taking tk_core.lock
To: Breno Leitao <leitao@debian.org>
Cc: Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 1:42=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
> I am seeing a similar issue, although from a different code path.
>
>          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>          [ BUG: Invalid wait context ]
>          7.1.0-next-20260615upstream-14023-g8d6dbbbe3ba6 #32 Not tainted
>          -----------------------------
>          swapper/0/0 is trying to lock:
>          ffff800084e4bd80 (clocksource_mutex){....}-{4:4}, at: __clocksou=
rce_register_scale+0x5c4/0xa48
>          other info that might help us debug this:
>          context-{5:5}
>          1 lock held by swapper/0/0:
>           #0: ffff80008ca99930 (&tkd->lock){....}-{2:2}, at: timekeeping_=
init+0x158/0x290
>          stack backtrace:
>          CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-next-2026=
0615upstream-14023-g8d6dbbbe3ba6 #32 PREEMPT(full)
>          Hardware name: linux,dummy-virt (DT)
>          Call trace:
>           show_stack+0x24/0x38 (C)
>           __dump_stack+0x28/0x38
>           dump_stack_lvl+0x94/0xe0
>           dump_stack+0x18/0x24
>           __lock_acquire+0xba4/0x3520
>           lock_acquire+0x150/0x390
>           __mutex_lock+0xe4/0x1240
>           mutex_lock_nested+0x30/0x48
>           __clocksource_register_scale+0x5c4/0xa48
>           clocksource_default_clock+0x40/0x68
>           timekeeping_init+0x164/0x290
>           start_kernel+0x2b0/0x4b8
>           __primary_switched+0x8c/0xa0
>
>
> Reviwed-by: Breno Leitao <leitao@debian.org>

Thanks for the Reviewed-by and the arm64 confirmation. Note that
f24df84cbe05, which this fixes, is itself Cc: stable, so this should
land in the same stable trees. I'm happy to resend with Cc:
stable@vger.kernel.org added if you prefer; otherwise it can be picked
up via the Fixes: tag or added on apply.


--=20
Best Regards,
Mike Gavrilov.
