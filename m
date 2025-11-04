Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC3347BA2
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Nov 2025 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299683; cv=none; b=rW0CnbQJ2WwAIk6Tdn5o/FqOdY7LJ3jDGzGn+6FwmR6UVftoDmPB0XzpGzKPp3DYSGC56YYlBBZpeBG5oYswTVCq4OYt9nIFuqpODfF5E6jdm/HYXYapnUAvpsd1vH9D0DHnCBNSiPD/m8WQ95aPzTkQZ1BUREqu8Itt6RSBXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299683; c=relaxed/simple;
	bh=fhZM85l1uSREt1wMvhWcmC7U7Dt1bJyMbgpE4R0c+9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+6cMvTU8ZTJaU7uCNZvOzbQgE0rWX32Lhg9NbUT2wwjzHB+NVb2xIHQ9vsBWF3ZZ9jxt/AaHsCemSHVjScsxjQEHdv8W7Dmn0jTtDOfP3T5rdi+XZZ8jriUkUb27yZ9S9VkQeVI8npu9n4kAak+A3AZ8I3KiN9m7V7Q6nENusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+R3fEbg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+R3fEbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D08C4CEF8
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Nov 2025 23:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762299683;
	bh=fhZM85l1uSREt1wMvhWcmC7U7Dt1bJyMbgpE4R0c+9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n+R3fEbgHl6EI+6rABYnXYx7/Yftd2e21aILUVE9CsEz9i19cMFFqVt6Rq91enP1P
	 mWtOsddDwh/92H/q5WfWt6JiSea3K1YXvJIl8ibjvSMub1Fu7UrkUJCfO0fJYwa7zV
	 de5plCCpwViMhbcRsmnvkZtgaByPFsboxYY/8bVKPgaz9UgJmUzi33bvYpCFa1OCGs
	 CFwAO0eiuWBSy5Djv2IZiyEbfqT5ihZTGZ7/OIb3gzzMKoDRvCwDBq1Q0zXksyNCDt
	 3SoS/si+krK+m4i0DgxaTu1qRTzFaD6ivXanZdrRexg4EW0fQDWl0KLGq4Cw+hUxkw
	 yOcuMC4ljQ7JA==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7869dee42cdso4899257b3.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 04 Nov 2025 15:41:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnP8AdVjgMfDQHdhH+v9jLYRTCkN2VuP4JtBwFqGY/oUA29soQHlhq9HJT2mr/QOGY+ZqKKx0MPn2QDW/hBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzjc3l0jF2LlUQvSt95r3JjrwH9j9vKMW6iG8QjheYaNfCMGfJy
	AgLrkl5inCNNes6kt2wXSfTr7nzfgtI1+viCzUFTPftwOx+B7TNXsBjgm4O6Qwqzl777RzVAEx3
	VGGv8k57QpKGLKeGRwtgsLjigFvt07Ms=
X-Google-Smtp-Source: AGHT+IG5YjJyeun/FhxE1uvNILjGs7+uK5LNrsZh/uE3mdeeUAP/+Jf2de6+gEpt3P0hfy94aTVupbFfHMBjlGFOuCQ=
X-Received: by 2002:a05:690e:1404:b0:63c:f5a6:f307 with SMTP id
 956f58d0204a3-63fc76a413dmr4544668d50.30.1762299682330; Tue, 04 Nov 2025
 15:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251103101545.760243-1-bigeasy@linutronix.de> <740b1a09-24b2-4473-aeb4-490ac42da7c2@app.fastmail.com>
In-Reply-To: <740b1a09-24b2-4473-aeb4-490ac42da7c2@app.fastmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 5 Nov 2025 00:41:11 +0100
X-Gmail-Original-Message-ID: <CAD++jLnsPphTjv_mDc--BDSWjRn2Q4WAGkQ1XNmTNg7VGY0adw@mail.gmail.com>
X-Gm-Features: AWmQ_bkSZkbh3lgoOtda_vhQ5EiawR6dARli3SbhpUt1IKJiv0r5dieZ5ucjNWs
Message-ID: <CAD++jLnsPphTjv_mDc--BDSWjRn2Q4WAGkQ1XNmTNg7VGY0adw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ARM: Remaining PREEMPT_RT bits
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-rt-devel@lists.linux.dev, Russell King <linux@armlinux.org.uk>, 
	Xie Yuanbin <xieyuanbin1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 12:24=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Mon, Nov 3, 2025, at 11:15, Sebastian Andrzej Siewior wrote:
> > this is the last batch I have to enable PREEMPT_RT on the ARM
> > architecture.
> > Last time I posted them there was some discussion about making the
> > branch predictor hardening worse. I redid it hoping it improved now and
> > does not make it worse.
> >
> > v1=E2=80=A6v2: https://lore.kernel.org/all/20251029155918.503060-1-bige=
asy@linutronix.de
> >   - Allow to enable jump-labels on UP. The UP build does not involve
> >     stop_machine(). Reworked by Arnd.
> >
> >   - Instead of forbidding HAVE_GUP_FAST with HIGHPTE enabled just
> >     disable HIGHPTE on PREEMPT_RT. As Arnd explained, HIGHPTE is rarely
> >     needed.
> >
> >   - Don't let ARCH_SUPPORTS_RT depend on HAVE_POSIX_CPU_TIMERS_TASK_WOR=
K
> >     which in turn depends on !KVM. Since KVM has been removed from ARM
> >     it is sufficient to unconditionally allow ARCH_SUPPORTS_RT. Noted
> >     by Arnd.
>
> Whole series
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> Looks all good to me. The first two patches may clash with
> the work on generic entry that I think Linus Walleij (added to
> Cc) is in the process of rebasing, but I think that is fine:
> hopefully the special case that you  adding here will just go
> away after Linus' patches, so everything should be fine
> regardless of which gets merged first.
>
> Linus, can you have a look and confirm?

The patches look fine to me, the series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>
(nevermind the kernel.org address on this mail, it's because
the mail is not in my other inbox because of something...)

The generic entry is mainly about getting rid of the old
RCU context tracker and ridding some lockdep warnings and
I am in the process of splitting off the irqentry parts and send
separately.

I think these patches are good to go.

Yours,
Linus Walleij
