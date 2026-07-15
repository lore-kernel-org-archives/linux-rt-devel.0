Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDE93B38AB;
	Wed, 15 Jul 2026 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093543; cv=none; b=ZzNT30OlFDAqgq98q5W3FrnRdjBvgjGJOZXQGFfWfNAZyj4/zT4zdwoNB5iQ0csJUeiOKu1JGzjwNbfG/G69epS+752Tn2ESA2mAI6SqMW8kwPwV/syn2LCQlZg4YsBwYelT3cC4WjzyoOtQcL1OHrGqezQWA8efSofUh2e97XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093543; c=relaxed/simple;
	bh=qshXTfYfmD4R5RkFEQeEs/hKTxzME5hHHlDKrEXNTsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EO4TsBLIpe0FuCaXRLO16I4ozh6uNv5HlmSAsQdfE53lwfTWHhb3oPPnjJs5JvdpdNEifw54YosRO7KKripIY7sgMWcgRC/40se6ZlJQQ+KljYL05qhr82M/uQJHZDT224BGt3b6G23fxIBAA8FKhdnEVdc5nWqqvZD7iHuoMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeJXBQxK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeJXBQxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148C81F000E9;
	Wed, 15 Jul 2026 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784093541;
	bh=LS+yc6Y3u41R50YRe37HSSoYfmEJCWKVWgKPKtQgnCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aeJXBQxKMlEr8XHNACxN9xcyA5g5jnf5L4kES5oRN8FvE5Bp0i4rUGhZVR7LCfZpV
	 6hJy0z8OvZgZGIiKBivZF0PmHnazJ1FJL2VEBClWTTcZMjKPmm0ztfDFl7hPzmQljn
	 2xQUjZRIcLTWCf6YbT8Oe7rc1ySGEjzhS/NWPtRb0qBnrORVNmWIv8hKlLi4MJ5Owf
	 zu19VtF8/MenjpKTH0f/14xuNa7fdxffpJQNcPIe8riem1XJCkneibPougqc/z+HO+
	 4GKiIifxdaDqTmSutFenLwg4SvNsffyhzjMKZ4y+VLYeLlgVhZI2kqO9X5DKUQNWiV
	 JgFs2ZhPitS7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] riscv: vector: allow non-preemptible kernel-mode
 vector with IRQs off
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Chiu" <tchiu@tenstorrent.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260715051629.1169645-3-tchiu@tenstorrent.com>
References: <20260715051629.1169645-1-tchiu@tenstorrent.com>
 <20260715051629.1169645-3-tchiu@tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 05:32:20 +0000
Message-Id: <20260715053221.148C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Exported `get_cpu_vector_context` and `put_cpu_vector_context` dyn=
amically evaluate `irqs_disabled()` to balance `local_bh_disable()` and `lo=
cal_bh_enable()`. If a caller alters the IRQ state between the two calls, i=
t will lead to preempt count corruption.
--

--- Patch [2]: [PATCH v2 2/3] riscv: vector: allow non-preemptible kernel-m=
ode vector with IRQs off ---
commit cfe6cf4c78a9ea0fadcde3b4c39aafb48ebeaec6
Author: Andy Chiu <tchiu@tenstorrent.com>

riscv: vector: allow non-preemptible kernel-mode vector with IRQs off

This commit updates get_cpu_vector_context and put_cpu_vector_context to
conditionally disable and enable bottom halves based on whether interrupts
are disabled. It also exports these symbols so they can be used by the KVM
module, specifically for kvm_arch_vcpu_load and put.

> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/k=
ernel_mode_vector.c
> index 307ac369c3d4a..6627e1a82e19e 100644
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
> +EXPORT_SYMBOL_GPL(get_cpu_vector_context);
> =20
>  /*
>   * Release the CPU vector context.
> @@ -74,11 +77,14 @@ void put_cpu_vector_context(void)
>  {
>  	riscv_v_stop(RISCV_KERNEL_MODE_V);
> =20
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -		local_bh_enable();
> -	else
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		if (!irqs_disabled())
> +			local_bh_enable();
> +	} else {

[Severity: High]
Does dynamically checking irqs_disabled() in both get_cpu_vector_context()
and put_cpu_vector_context() risk corrupting the preempt count if the IRQ
state changes between the two calls?

The commit message mentions these are intended for kvm_arch_vcpu_load() and
kvm_arch_vcpu_put(). If KVM calls vcpu_load() during sched_in with IRQs
enabled, get_cpu_vector_context() will call local_bh_disable().

If it later calls vcpu_put() during sched_out with IRQs disabled,
put_cpu_vector_context() will skip local_bh_enable().

Will this permanently leak the BH disable count on every context switch?

>  		preempt_enable();
> +	}
>  }
> +EXPORT_SYMBOL_GPL(put_cpu_vector_context);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715051629.1169=
645-1-tchiu@tenstorrent.com?part=3D2
