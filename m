Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53CA2749DC
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782266176; cv=none; b=Dob8TPZZAQoJL5CEfjwbGaRNTiE+lJwb4hHE5dmwmVknGZ6YZ53QWFK8mcC+dE+ebcvm7/QKlDNEbGwgJizMkEHsJXJz69M9fnt5+DWrtoc+olTcbflWBoa/YsbuL2+G8yF1ROABJujTvcuh/dX6UdDkgsbNVFbeW8vPf9YyfFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782266176; c=relaxed/simple;
	bh=gPu3FOxQiQ0uU+fA2TV2OJYMCl07bZ8LHmEofD6dl7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEEX6v1ov45Hdm7BKSVqzThVYKXbbYfr4BWxNOh9L2hhl5SD1k7oaTzA9eCxJsYFeZe6rGuRJmSfhdIzixgh0m76r3lEbVsThYkpwexHJvBEasH5mflzfz6J94uAmc3tyrDm6NVJAM7s4zm277DQ1RVF+/B/LmmzmQ1li6vPCa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOYG8CvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOYG8CvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867261F00AC4
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 01:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782266174;
	bh=f0vOxifqaz+hS+VdiakGBn1KstKfYAxDodPWoCbL64k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hOYG8CvUCINhDuCDMjPm2seU1QtglhJD2HV/0m6Jy6/XUOrNmaNlOsJycpK5mRkC9
	 ReX9Pre8uWzXnJQ0EhnN9hI9JtDNSW1lggW4ldGDP9F4H/iz9mTwnM7MACKztvagDL
	 REY9zm2MIdL8QMfjQYlls8kOGmX5odKS6/95sI2JTcWzNURJjpkbhruXdQd/MLuqdh
	 gi/pjRqPFqwnOXOZsiP8eR07uRHw599tTb9ee3+/2U7mdv2pOvBSKc/iDvTsVCBUP2
	 9XTubPxRdhoQkzGpwiOiDtB+8vHRf0a3BiJwzHx2BLsmDrMcqiBmpgrQxCSlWTJuoW
	 qFLaR7XlG2l2Q==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697f5e3f4easo274683a12.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 23 Jun 2026 18:56:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+R32TEjfXWHaxVcSxDfCFnDzD/1JYc05Mmq/iMTtB3fBR0zRsgANAnoY/u7MopIQrDEZHkovl325yWGrECMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxII/z/dis4QjIrZDFO5SLBGD1gT/zDWONtHpN5hV7q7IvwmHMs
	nBI8yLdEaI1i7Oj++4iXqSjYvK++YCgG+SessxJVNFzxSKMiYNaS8s4tEllSExn92Z3rzmcvODq
	+Sa3UYSy8u2VwZtE11kC22EKol+gxWEA=
X-Received: by 2002:aa7:dc09:0:b0:697:9fd4:1433 with SMTP id
 4fb4d7f45d1cf-697d42d9a94mr2231369a12.7.1782266173207; Tue, 23 Jun 2026
 18:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260623172728.191557-1-xry111@xry111.site>
In-Reply-To: <20260623172728.191557-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 24 Jun 2026 09:56:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H78gWEVDXy6pgOFScLMuMx-fssiXDZNzYZKt0Zgt75=fA@mail.gmail.com>
X-Gm-Features: AVVi8CfE_V_m6-Q1zejbbndpjmWD3SpdRr3dhW790ice0TWK-LcLVLpR5Ll2s-I
Message-ID: <CAAhV-H78gWEVDXy6pgOFScLMuMx-fssiXDZNzYZKt0Zgt75=fA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: loongson64: add IRQ work based on self-IPI
To: Xi Ruoyao <xry111@xry111.site>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Mingcong Bai <jeffbai@aosc.io>, Henry Chen <chenx97@aosc.io>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Wed, Jun 24, 2026 at 1:28=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> Since the commit 91840be8f710 ("irq_work: Fix use-after-free in
> irq_work_single() on PREEMPT_RT"), we observed the performance of
> execve() is significantly impacted on MIPS.
>
> While we are unsure how that commit caused the impact or how to improve
> it (or even if it can be improved at all), implementing IRQ work with
> self-IPI seems able to mitigate the impaction.
>
> Perhaps this can/should be implemented for other MIPS architecture
> processors as well, but we don't have the enough knowledge of them, nor
> access to the hardware.  So only implement it for loongson64 here.
>
> Link: https://lore.kernel.org/6be1cdd5f91dd7418a32ff372a6f3ae259b19195.ca=
mel@xry111.site/
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/mips/include/asm/irq_work.h |  9 +++++++++
>  arch/mips/include/asm/smp.h      |  2 ++
>  arch/mips/loongson64/smp.c       | 10 ++++++++++
>  3 files changed, 21 insertions(+)
>  create mode 100644 arch/mips/include/asm/irq_work.h
>
> diff --git a/arch/mips/include/asm/irq_work.h b/arch/mips/include/asm/irq=
_work.h
> new file mode 100644
> index 000000000000..d4fa2d80aabc
> --- /dev/null
> +++ b/arch/mips/include/asm/irq_work.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_MIPS_IRQ_WORK_H
> +#define _ASM_MIPS_IRQ_WORK_H
> +static inline bool arch_irq_work_has_interrupt(void)
> +{
> +       return IS_ENABLED(CONFIG_MACH_LOONGSON64) && IS_ENABLED(CONFIG_SM=
P);
> +}
> +#endif /* _ASM_MIPS_IRQ_WORK_H */
> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
> index 2427d76f953f..a545568f1cac 100644
> --- a/arch/mips/include/asm/smp.h
> +++ b/arch/mips/include/asm/smp.h
> @@ -50,6 +50,8 @@ extern int __cpu_logical_map[NR_CPUS];
>  #define SMP_CALL_FUNCTION      0x2
>  /* Octeon - Tell another core to flush its icache */
>  #define SMP_ICACHE_FLUSH       0x4
> +/* Loongson64 - Self IPI for IRQ work */
> +#define SMP_IRQ_WORK           0x8
>
>  /* Mask of CPUs which are currently definitely operating coherently */
>  extern cpumask_t cpu_coherent_mask;
> diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
> index 147acd972a07..e584299d0fde 100644
> --- a/arch/mips/loongson64/smp.c
> +++ b/arch/mips/loongson64/smp.c
> @@ -381,6 +381,13 @@ loongson3_send_ipi_mask(const struct cpumask *mask, =
unsigned int action)
>                 ipi_write_action(cpu_logical_map(i), (u32)action);
>  }
>
> +#ifdef CONFIG_IRQ_WORK
> +void arch_irq_work_raise(void)
> +{
> +       loongson3_send_ipi_single(smp_processor_id(), SMP_IRQ_WORK);
> +}
> +#endif
> +
>  static irqreturn_t loongson3_ipi_interrupt(int irq, void *dev_id)
>  {
>         int cpu =3D smp_processor_id();
> @@ -397,6 +404,9 @@ static irqreturn_t loongson3_ipi_interrupt(int irq, v=
oid *dev_id)
>                 irq_exit();
>         }
>
> +       if (action & SMP_IRQ_WORK)
> +               irq_work_run();
> +
>         return IRQ_HANDLED;
>  }
>
> --
> 2.54.0
>
