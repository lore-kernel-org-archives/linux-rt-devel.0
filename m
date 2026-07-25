Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A8C23AE62;
	Sat, 25 Jul 2026 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939872; cv=none; b=o+N4VdIVnXNwJbTGoESegeBj7giY/yeR8Vti1P2xdrosapl6LK+Mn2zdjYmbPw80lT9wZ+s4C0k/Z5i38AJ4n5WL2hQVOTqQZF+bvo2mhSGTQ6ol/uwoWgDmxR7xRtdEPNXsvcmppDKOPibi8GN551xw21lb/6EDNUnEkjo7rOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939872; c=relaxed/simple;
	bh=2afZDJiuHfDE1sB6aFonl4S+sN03lp+Irl7dv5x47yI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0/b30PpPk/CI6WvV1TuGZLcMoxXwU9cEBoC0nzJ4dU4xjYDPcO764a66vnV1X923o04PXvc0X8IxomM3X2E8eqOXCWGjSIBeI1w68WOuKx61K2J5ZZ+Dexf5RAwE5VOBSet2T905uUtbABZqBnulcK9g0Cq5qmX1IQqEjtJ7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUBOTQIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUBOTQIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2961F000E9;
	Sat, 25 Jul 2026 00:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784939871;
	bh=5oNSHKqLlRWRJwPNA+bnUHam3PpdiLWy38DDyM6uyHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SUBOTQIpPxIm0nrdO90Snat7iHIYdEsYPHujm11Hq5DTMh5NAFDB0nHFDlEsUqYD4
	 sknIGbhFpubnoIHV0H9dq4wOUTfJS/bgNmaGCKWyMyg3IqK0GHhTTm/7bliEpavXN4
	 YJHhZy76my3GwrZLzcevpfaqUvF7S7KRsIcgViIbuluxAxT1oaqFy4XBSYVygN5Vez
	 IWSU7GqEQ6UPfpklQqdVL8bjX4ZXLb6yXojfgvmgVaEPz71pOzjsB0aP7PI8S/pG5f
	 uV40rCVQchhnReC+D6vqc78ocXilI3ifHSdjzHGrDTyHF4OjHbkTBo3v8cG5xggu/0
	 CVzWMZzw/cGrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] riscv: vector: allow non-preemptible kernel-mode
 vector with IRQs off
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Chiu" <tchiu@tenstorrent.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260725001749.2579274-3-tchiu@tenstorrent.com>
References: <20260725001749.2579274-1-tchiu@tenstorrent.com>
 <20260725001749.2579274-3-tchiu@tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 00:37:50 +0000
Message-Id: <20260725003751.2A2961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `!irqs_disabled()` check from `may_use_simd()` expose=
s KVM guest vector state to corruption and leakage by hardirqs.
--

--- Patch [2]: [PATCH v4 2/3] riscv: vector: allow non-preemptible kernel-m=
ode vector with IRQs off ---
commit db1e5a6ad1a80d124f168f9dae7f399f6eec4f67
Author: Andy Chiu <tchiu@tenstorrent.com>

riscv: vector: allow non-preemptible kernel-mode vector with IRQs off

This commit upgrades get/put_cpu_vector_context to allow safe execution und=
er
both IRQ off and regular process context, similar to arm64/fpsimd. It also
exports these symbols for the KVM module to call.

> diff --git a/arch/riscv/include/asm/simd.h b/arch/riscv/include/asm/simd.h
> index adb50f3ec2057..f176a8072c625 100644
> --- a/arch/riscv/include/asm/simd.h
> +++ b/arch/riscv/include/asm/simd.h
[ ... ]
> @@ -36,20 +36,10 @@ static __must_check inline bool may_use_simd(void)
>  	/*
>  	 * Nesting is achieved in preempt_v by spreading the control for
>  	 * preemptible and non-preemptible kernel-mode Vector into two fields.
> -	 * Always try to match with preempt_v if kernel V-context exists. Then,
> -	 * fallback to check non preempt_v if nesting happens, or if the config
> -	 * is not set.
> +	 * Only non-preempt_v can nest on top of preempt_v, if non-preempt_v is
> +	 * unavailable, then preempt_v is not allowed.
>  	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_V_PREEMPTIVE) && current->thread.kernel=
_vstate.datap) {
> -		if (!riscv_preempt_v_started(current))
> -			return true;
> -	}
> -	/*
> -	 * Non-preemptible kernel-mode Vector temporarily disables bh. So we
> -	 * must not return true on irq_disabled(). Otherwise we would fail the
> -	 * lockdep check calling local_bh_enable()
> -	 */
> -	return !irqs_disabled() && !(riscv_v_flags() & RISCV_KERNEL_MODE_V);
> +	return !(riscv_v_flags() & RISCV_KERNEL_MODE_V);

[Severity: High]
Does removing the !irqs_disabled() check here expose KVM guest vector state
to corruption and leakage by hardirqs?

If KVM loads guest vector state into CPU registers during kvm_arch_vcpu_loa=
d(),
and a hardirq using vector instructions fires while running KVM code,
may_use_simd() will now return true.

Would kernel_vector_begin() then save the CPU hardware registers (which con=
tain
KVM guest data) into the host task's current->thread.vstate, followed by the
hardirq clobbering the CPU registers with its own vector operations?

If this happens, when the hardirq returns KVM would resume with corrupted
vector state, and the host task (e.g., QEMU) could receive the leaked guest
state.

While this series exports KVM symbols to potentially let KVM set
RISCV_KERNEL_MODE_V to protect the state, are the actual KVM patches to set
this flag missing from this series, leaving the tree vulnerable in the inte=
rim?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725001749.2579=
274-1-tchiu@tenstorrent.com?part=3D2
