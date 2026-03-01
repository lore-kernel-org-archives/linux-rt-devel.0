Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCEA30B539
	for <linux-rt-devel@lists.linux.dev>; Sun,  1 Mar 2026 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347369; cv=none; b=YumvIiXZM31WET/kICKdB5EoiGu/cJeOkQVmfbiJq+RhuHhuyOF9yngch3DGfy67Q9e6wW7+2lDalvmgf295XNwe45r30RuJVdqYyyWXhd7TW5od+wzgk6nz6S2Ec+4Sf2LywyYtwpp6lSmJiT0jOtg8vI5g3B6B+k9qNYRtUFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347369; c=relaxed/simple;
	bh=gOsLOEfkRMnTNQ6/obOibNRWcQoVeBEacmidZUBspHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChiWHGIzhSZrNEGMfHBto/BJbo0qeoFnDBWXpWlejjUXAlfyN6enOD+VDUvfMYResah3717BciQzlw5Y6y+UTfhdY1lDkC5VmIasXGUHez/SY3tsk3Q6M5UPazvBgcbiNKlQ4WiebglbWTEiq0++VMyJ+sM8eWCKl+BubCfXtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4KtZv9P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4KtZv9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1F2C2BCB0
	for <linux-rt-devel@lists.linux.dev>; Sun,  1 Mar 2026 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772347369;
	bh=gOsLOEfkRMnTNQ6/obOibNRWcQoVeBEacmidZUBspHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X4KtZv9PQnSZJLRiA6BjaEWcT5IsNKn7+6k5rA8DX4Mas5HtSZWQ5Jcji5DOtZMj0
	 4CDyAmPotfmxEk9JUlaUkNCiWFNGL7TZE9PRu0mbMmp+/n5T23P5//M6oe0Kauekej
	 XQA0ZjfJW3vSceBeMakHUEvVKlWO851460mKSC92pC5/LxmY7/c+WuJuIkjGv13PM3
	 IvJHobx7lbvIfqcQblH/7yJhekgg32Yy9Eld8fcyajmid+5VWTnK1gWWNvIH5MH8Zd
	 VtOtfjtmPRYGSRqa8uoSbr3hMOrixUQ9lTlqaBWm5Leop7GW4T0RK4RVgrrRcfnBCF
	 8bFCU7UcfZLcQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65fac0b51baso191969a12.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 28 Feb 2026 22:42:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqOLuug8OaoIGoPC0YsKQkNPaDbE4aUo/NA+N1D7PbeQAxLSdpFzyLK4XTeRs3CYv7+hC2iHBQRn1VG5x+AQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww3EArsZhd5e7dCoyty8+yRwPhxRUxnbBRD7VJ2EQrlVSSHuuR
	F3BOG84kE3RLhA1adlGvULwcp4B+kvtebZKIHntvWPvZrOrSZfyPLHA5Bk8LslgWcOvpBrQTlqK
	YuRavIayFXKVLZhKDRyOvfL1JTTjY7/k=
X-Received: by 2002:a05:6402:a2c5:10b0:65a:4207:fbf0 with SMTP id
 4fb4d7f45d1cf-65fab735585mr5254076a12.15.1772347367821; Sat, 28 Feb 2026
 22:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260301013806.1698436-1-sashal@kernel.org>
In-Reply-To: <20260301013806.1698436-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:42:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4h5n+Ccjc=rwsz+1Bv4DCg94GiZGD2420+jDLB45mxWw@mail.gmail.com>
X-Gm-Features: AaiRm52ewdaatNPIHb6_ElITT_wi8yEOEupcJIIH3B1YMtqMIPVoK17eV3mZ5a0
Message-ID: <CAAhV-H4h5n+Ccjc=rwsz+1Bv4DCg94GiZGD2420+jDLB45mxWw@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Guard percpu handler under
 !CONFIG_PREEMPT_RT" failed to apply to 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, yangtiezhu@loongson.cn, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:38=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I'm very confused because it can be applied and already here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.6

Huacai

>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From 70b0faae3590c628a98a627a10e5d211310169d4 Mon Sep 17 00:00:00 2001
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
> Date: Tue, 10 Feb 2026 19:31:13 +0800
> Subject: [PATCH] LoongArch: Guard percpu handler under !CONFIG_PREEMPT_RT
>
> After commit 88fd2b70120d ("LoongArch: Fix sleeping in atomic context for
> PREEMPT_RT"), it should guard percpu handler under !CONFIG_PREEMPT_RT to
> avoid redundant operations.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/kernel/unwind_prologue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/ker=
nel/unwind_prologue.c
> index 729e775bd40dd..ee1c29686ab05 100644
> --- a/arch/loongarch/kernel/unwind_prologue.c
> +++ b/arch/loongarch/kernel/unwind_prologue.c
> @@ -65,7 +65,7 @@ static inline bool scan_handlers(unsigned long entry_of=
fset)
>
>  static inline bool fix_exception(unsigned long pc)
>  {
> -#ifdef CONFIG_NUMA
> +#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
>         int cpu;
>
>         for_each_possible_cpu(cpu) {
> --
> 2.51.0
>
>
>
>
>
