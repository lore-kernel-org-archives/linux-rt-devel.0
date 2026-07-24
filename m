Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C843CEE9;
	Fri, 24 Jul 2026 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913835; cv=none; b=mSI/YDDvTJAiAKTB0oHEkLf+TkDH9gerVIU6Sif8zvbcZjLrfVLB68le+lIzX/JKl7WrisMiYtiiJQXc+jnDHvpBRhyoGr3A5jk+A7Hlv0hSMLAZR/D+JjlDxy3qA1PlRJr66ZMrUvN1RhtItyiOZtjm8kGF+T+JzcJkEvF5uXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913835; c=relaxed/simple;
	bh=zfR1EfIuIINF/MLw6voMT/GzJ0Lsk4LHLwVFzZBGsmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ph+dxalKblRJPHYR9CYf5V2QUHDfx1HsqLJUlh75gpxcfK0OLXFl3TzTE0fPABcgsHimtmRQV36pWJb5M5KqTN4w14Z4SEc3I6eauaD/geGHyPTctzl2HcX0zYL45WRNBaM3bfOlAFZwmFrLqo2+PSbQWZ5bwyaUTbCl4blHSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOjqigig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOjqigig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C580C1F00A3A;
	Fri, 24 Jul 2026 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784913834;
	bh=fjDT6pHLzi8KmNKYW5kC6iCLbJAbfpYueOlx45fE5c8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oOjqigig80e5wAcNO4DkkWCIvKrHCEI2Q/e5apButHcGWxPz77llxJDgnlmE0bdeP
	 UgjXRwNpjQ9rmhcP/tvh1x4MHpIxlw0MA4ZzqLAeh4Vc2LUz4RZCZKQGWZoYa7A6qe
	 kmIQQkR5+Agw2NiOWAwiNLmrF57kWIxOfV4eJ3NSg7zB2S807ktameoRtzJue72vfE
	 73PWR1ysCYBYzQ2bJ5QWOFMdJCc2WWCjkZfUkXa7tY0qvJ0FnnkboA7ZC8pUyXKQKb
	 hmK4PIlzXEaDNw+gL8s05uYx0CRmQ9TzpAa/pCUIinbhKWwKkGBO5HDpiD/0RV1rVG
	 Ele+L+YinlqgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] riscv: vector: allow non-preemptible kernel-mode
 vector with IRQs off
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Chiu" <tchiu@tenstorrent.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260724165001.2317788-3-tchiu@tenstorrent.com>
References: <20260724165001.2317788-1-tchiu@tenstorrent.com>
 <20260724165001.2317788-3-tchiu@tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:23:53 +0000
Message-Id: <20260724172353.C580C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Removing `!irqs_disabled()` from `may_use_simd()` allows hardi=
rqs to clobber KVM guest vector state.
- [Low] Missing include for EXPORT_SYMBOL_FOR_KVM causes build failure.

Pre-existing issues:
- [High] `may_use_simd()` bypasses `RISCV_KERNEL_MODE_V` reentrancy protect=
ion when preemptive vector is enabled.
--

--- Patch [2]: [PATCH v3 2/3] riscv: vector: allow non-preemptible kernel-m=
ode vector with IRQs off ---
commit 3a54faa8049f24258693b2d523344984e57f132c
Author: Andy Chiu <tchiu@tenstorrent.com>

riscv: vector: allow non-preemptible kernel-mode vector with IRQs off
   =20
This commit updates get/put_cpu_vector_context to allow kvm_arch_vcpu_load
and put to be called safely under both irq off and regular process context.
It also exports both symbols for the KVM module.

> diff --git a/arch/riscv/include/asm/simd.h b/arch/riscv/include/asm/simd.h
> index adb50f3ec2057..678c8b97cd497 100644
> --- a/arch/riscv/include/asm/simd.h
> +++ b/arch/riscv/include/asm/simd.h
> @@ -44,12 +44,8 @@ static __must_check inline bool may_use_simd(void)
>  		if (!riscv_preempt_v_started(current))
>  			return true;

[Severity: High]
This is a pre-existing issue, but does this logic bypass the
RISCV_KERNEL_MODE_V reentrancy protection?

If a task such as a KVM thread calls get_cpu_vector_context() directly, it
sets RISCV_KERNEL_MODE_V but not RISCV_PREEMPT_V. If an interrupt occurs
during this non-preemptible vector block, riscv_preempt_v_started(current)
evaluates to false.

Would may_use_simd() then immediately return true and completely bypass the
RISCV_KERNEL_MODE_V check below, falsely permitting the interrupt handler to
clobber the active non-preemptible vector context?

>  	}
> -	/*
> -	 * Non-preemptible kernel-mode Vector temporarily disables bh. So we
> -	 * must not return true on irq_disabled(). Otherwise we would fail the
> -	 * lockdep check calling local_bh_enable()
> -	 */
> -	return !irqs_disabled() && !(riscv_v_flags() & RISCV_KERNEL_MODE_V);
> +
> +	return !(riscv_v_flags() & RISCV_KERNEL_MODE_V);
>  }

[Severity: Critical]
Does removing the !irqs_disabled() check allow hardirqs to clobber KVM
guest vector state?

Without a check preventing hardirqs (such as !in_hardirq() && !in_nmi()),
may_use_simd() can now return true when a host hardirq interrupts a running
KVM guest. The hardirq might use kernel_vector_begin(), which blindly
assumes the hardware vector registers belong to the host thread:

arch/riscv/kernel/kernel_mode_vector.c:kernel_vector_begin() {
    ...
    riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current));
    ...
}

Could this cause the guest's state to be saved into the host thread's user
space vstate, corrupting the guest's vector registers upon resume and
leaking guest state to the host?

> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/k=
ernel_mode_vector.c
> index 307ac369c3d4a..f76e52de11178 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c

[ ... ]

> @@ -55,13 +55,16 @@ void get_cpu_vector_context(void)
>  	 * disable softirqs so it is impossible for softirqs to nest
>  	 * get_cpu_vector_context() when kernel is actively using Vector.
>  	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -		local_bh_disable();
> -	else
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		if (!irqs_disabled())
> +			local_bh_disable();
> +	} else {
>  		preempt_disable();
> +	}
> =20
>  	riscv_v_start(RISCV_KERNEL_MODE_V);
>  }
> +EXPORT_SYMBOL_FOR_KVM(get_cpu_vector_context);

[Severity: Low]
Will this cause a build failure due to a missing include?

EXPORT_SYMBOL_FOR_KVM is used here, but it doesn't appear that
<linux/kvm_types.h> is included in this file or its dependencies.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724165001.2317=
788-1-tchiu@tenstorrent.com?part=3D2
