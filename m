Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F52E22B5
	for <linux-rt-devel@lists.linux.dev>; Sun,  1 Mar 2026 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772346869; cv=none; b=ikw9LGbo258ThqqAgzCAX6ZPXGkDjCE6iAjiWf5Z/qj31NjpsgBW//YI/dkNUC4jIOJf21TWdODsCm3P3mBtyOlEcZS6lR3zh8iILaX0569Ns0iKQSFiSxL/kaWwtCYGYuvQt4XbNsBv0klCOF+TaDYI6eLFnkLYv/3h8431YTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772346869; c=relaxed/simple;
	bh=4kW78VB6HvJ7HwLv3XkvQWHjvP50yh/DiNDuEin0xv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkhfEZJSxV+vzdG6GxQsUvXoI2Uq+RmNTe7rKlZKn9y75i7ca8CUdIsHMocEIDQ+w9s/9RcCZk2k1vVRirFHIoPL1WjntYbGDZT7b2cDNiu2CEirHSycTAEjOSooSB4qQRNvjlAyqkZAUKRcT0BW/pcCxRg5L3h/gCkQcxuqExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx0RMDCb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx0RMDCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76A0C2BC9E
	for <linux-rt-devel@lists.linux.dev>; Sun,  1 Mar 2026 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772346868;
	bh=4kW78VB6HvJ7HwLv3XkvQWHjvP50yh/DiNDuEin0xv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hx0RMDCbBG/7uEUtJfY7AZdEzRYTsTXLWCk85YIX0kq5R6x6DPHr7Vo2a/IcOQ62i
	 KJnfxljCXOCOjeM3Y/ikmcJ77M9chF0ETgqi49VWjWOVJ8YQx3EzoVJiagPKALCb4V
	 Bu9Av3E0PO9R94jcjrUVMKJiLDbUfeA0AEVPFWtgMMwPoks4OL2Pu2ar0+oMKmPMuq
	 ax/fosTfwY/L4JcI1RhaibGuYftkD7Cc0OiWCTISuL9U/ib1K+2l3Ayp5U/GUM+tcQ
	 IRFzZJVf4aM6yu6gict0iQmA7Q68ES8oMc18rU0xAP3d0lFbP5wTGRUEful8SZ54hi
	 oxzFaGIOPG6BA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65a43a512b0so3798933a12.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 28 Feb 2026 22:34:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTSapGZF19Vf8Tqv+lhwyIVmkdghKuDs8hvfksj5ADJz2pr3jF0bajEazexvmR64RkUi1hkYrmG1GMGayE6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsUGHkjU2VH2gEUOjNC8mJbMCBxzz/LsQuwniBK5aCPB5bhAOb
	YrWeN90d4JH35dcjjXZSsjM8l7uVoaX1gM1Ye9EO5j9HRBUyNqUrHPLwKC2U6v4XMYaP0p+tIwt
	0kCeYfu3BlGYBhCJUgSt4VzKwsyznAwo=
X-Received: by 2002:a05:6402:42c4:b0:65c:2170:67d2 with SMTP id
 4fb4d7f45d1cf-65fddcebdcamr5308457a12.16.1772346867383; Sat, 28 Feb 2026
 22:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260301012737.1685164-1-sashal@kernel.org>
In-Reply-To: <20260301012737.1685164-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:34:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5th1nFb92g2PN9-OKym6n5w1FuYcFsn8DBL5rrV0rjog@mail.gmail.com>
X-Gm-Features: AaiRm50sdsa9Q1QX9fbwa919mYlErSNYDuxC69Hv3GRV489YLWP-xJNx_W__o4k
Message-ID: <CAAhV-H5th1nFb92g2PN9-OKym6n5w1FuYcFsn8DBL5rrV0rjog@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Handle percpu handler address for ORC
 unwinder" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, yangtiezhu@loongson.cn, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
Please do the same thing here:
https://lore.kernel.org/loongarch/CAAhV-H46pdrJgJ0tg493nK8S8X6NQrXu+jHO-yDp=
BBdyDpRQKw@mail.gmail.com/T/#t

Huacai

>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From 055c7e75190e0be43037bd663a3f6aced194416e Mon Sep 17 00:00:00 2001
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
> Date: Tue, 10 Feb 2026 19:31:13 +0800
> Subject: [PATCH] LoongArch: Handle percpu handler address for ORC unwinde=
r
>
> After commit 4cd641a79e69 ("LoongArch: Remove unnecessary checks for ORC
> unwinder"), the system can not boot normally under some configs (such as
> enable KASAN), there are many error messages "cannot find unwind pc".
>
> The kernel boots normally with the defconfig, so no problem found out at
> the first time. Here is one way to reproduce:
>
>   cd linux
>   make mrproper defconfig -j"$(nproc)"
>   scripts/config -e KASAN
>   make olddefconfig all -j"$(nproc)"
>   sudo make modules_install
>   sudo make install
>   sudo reboot
>
> The address that can not unwind is not a valid kernel address which is
> between "pcpu_handlers[cpu]" and "pcpu_handlers[cpu] + vec_sz" due to
> the code of eentry was copied to the new area of pcpu_handlers[cpu] in
> setup_tlb_handler(), handle this special case to get the valid address
> to unwind normally.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/setup.h |  3 +++
>  arch/loongarch/kernel/unwind_orc.c | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/=
asm/setup.h
> index 3c2fb16b11b64..f81375e5e89c0 100644
> --- a/arch/loongarch/include/asm/setup.h
> +++ b/arch/loongarch/include/asm/setup.h
> @@ -7,6 +7,7 @@
>  #define _LOONGARCH_SETUP_H
>
>  #include <linux/types.h>
> +#include <linux/threads.h>
>  #include <asm/sections.h>
>  #include <uapi/asm/setup.h>
>
> @@ -14,6 +15,8 @@
>
>  extern unsigned long eentry;
>  extern unsigned long tlbrentry;
> +extern unsigned long pcpu_handlers[NR_CPUS];
> +extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
>  extern char init_command_line[COMMAND_LINE_SIZE];
>  extern void tlb_init(int cpu);
>  extern void cpu_cache_init(void);
> diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/u=
nwind_orc.c
> index d6b3688a1ce97..11ba3e4ac9eee 100644
> --- a/arch/loongarch/kernel/unwind_orc.c
> +++ b/arch/loongarch/kernel/unwind_orc.c
> @@ -352,6 +352,22 @@ static inline unsigned long bt_address(unsigned long=
 ra)
>  {
>         extern unsigned long eentry;
>
> +#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
> +       int cpu;
> +       int vec_sz =3D sizeof(exception_handlers);
> +
> +       for_each_possible_cpu(cpu) {
> +               if (!pcpu_handlers[cpu])
> +                       continue;
> +
> +               if (ra >=3D pcpu_handlers[cpu] &&
> +                   ra < pcpu_handlers[cpu] + vec_sz) {
> +                       ra =3D ra + eentry - pcpu_handlers[cpu];
> +                       break;
> +               }
> +       }
> +#endif
> +
>         if (ra >=3D eentry && ra < eentry +  EXCCODE_INT_END * VECSIZE) {
>                 unsigned long func;
>                 unsigned long type =3D (ra - eentry) / VECSIZE;
> --
> 2.51.0
>
>
>
>
>
