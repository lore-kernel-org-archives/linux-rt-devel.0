Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41EC34BA33;
	Thu, 25 Jun 2026 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352208; cv=none; b=b1lG88UUYSMdSGLHoPgF35BE/VOtQCTKjkC7/2/g/UM0CqNMxN6DG9ImKEO86otZjp1F/67Zxz/c8Z4u1CyzdI6ArvjqaYzk26kBcPgP93QKhFPK6Bik46hJF00HvyzXNlHjYuBrJZzzQgTdNecnsyfZ6oC5dAJkxlMnEKVi7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352208; c=relaxed/simple;
	bh=7UbCL5TNNHjK2HAjpRAJBxfRzEO+VI8Qhxd7rjrL6AY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lqbMMiUtz0I3jO8wIs8RuscZlbM71o5WaWa9Sembr8uDwdi0R5DWvKGIumZUwtp9daQV+2w2hKFxcE4jxMp3g/cn6ERGR0jREyXBdzGqGdJCCtfo+2tgdMwWsr5+AIgop5y/7n1rWzCEFUpEJ6F0N2XFr1RHtBPaVOYXNyq6CYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLThrG3l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLThrG3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5041F000E9;
	Thu, 25 Jun 2026 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352207;
	bh=W4OHbX9Ps2ecoRTk981+4q8wRGg/77MYQO93W2Gzh88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZLThrG3lJoyCbHS8CrQIjBHcmOwCmQ5olVVf+dDIAgrlaLbATebE+tm42t9mpPD9R
	 AiuWJ1P06xQI/C+vBqtBLpbIpMDfhZjPjEBVdwJ/nA9/XmThNBTVCtDbRHVIMKeLiq
	 f8ZukptvNzuN/XehhXZxrV4Zg62f3rRqx2kQFYfNc/ET5fDteL2ND5KbJQe0M5562S
	 fDvyCheBlKw30l2cr4Up/S5GKpjIY7ZRo8gwwL0GjqMBZaIG5K7NI2OsruvTkyoG8/
	 P1Qj+UQkYdZ5o2bOSi2wkJB1IWtktRPJkztm34eMDECguwjFfYMh4eHp7RU09TKyov
	 a1TeIt+Ac+L2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] riscv: Add support for srmcfg CSR from Ssqosid
 extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260624-dfustini-atl-sc-cbqri-dt-v2-3-2f8049fd902b@kernel.org>
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
 <20260624-dfustini-atl-sc-cbqri-dt-v2-3-2f8049fd902b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 01:50:06 +0000
Message-Id: <20260625015006.DF5041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] CPU hotplug cache invalidation is registered at the wrong state (C=
PUHP_AP_ONLINE_DYN), allowing the srmcfg cache sentinel to be overwritten b=
efore the CPU goes offline.
--

commit d51eb8c4a6c5a57f238cc53688229c08ea6418e1
Author: Drew Fustini <fustini@kernel.org>

riscv: Add support for srmcfg CSR from Ssqosid extension

This commit adds support for the srmcfg CSR defined in the Ssqosid ISA
extension. It introduces a per-cpu cache to avoid redundant CSR writes
during context switches and uses CPU hotplug and PM notifiers to manage
cache invalidation.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0

> diff --git a/arch/riscv/kernel/qos.c b/arch/riscv/kernel/qos.c
> new file mode 100644
> index 0000000000000..ea33201a43f61
> --- /dev/null
> +++ b/arch/riscv/kernel/qos.c

[ ... ]

> +static int riscv_srmcfg_reset_cache(unsigned int cpu)
> +{
> +	per_cpu(cpu_srmcfg, cpu) =3D U32_MAX;
> +	return 0;
> +}

[ ... ]

> +static int __init riscv_srmcfg_init(void)
> +{
> +	int err;
> +
> +	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID))
> +		return 0;
> +
> +	/*
> +	 * cpuhp_setup_state() invokes the startup callback locally on every
> +	 * already-online CPU, so no separate seed loop is needed here.
> +	 */
> +	err =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/srmcfg:online",
> +				riscv_srmcfg_reset_cache, riscv_srmcfg_reset_cache);

[Severity: High]
Does registering the hotplug callbacks at CPUHP_AP_ONLINE_DYN run too early
during teardown and too late during startup?

Since CPUHP_AP_ONLINE_DYN teardown runs while the CPU is still schedulable,
could the U32_MAX sentinel set by riscv_srmcfg_reset_cache() be overwritten
by subsequent context switches (such as switching to the idle thread) before
the CPU actually goes offline?

If a CPU is offlined and then onlined, the stale cache would persist while
the hardware CSR has been reset. Because the CPU becomes schedulable before
the CPUHP_AP_ONLINE_DYN startup callback runs, a task matching the stale
cache might skip the required CSR write and run with incorrect hardware tag=
s.

> +	if (err < 0) {
> +		pr_warn("srmcfg cpuhp registration failed (%d), cpus brought online af=
ter boot will not invalidate the CSR_SRMCFG cache\n",
> +			err);
> +		return err;
> +	}
> +
> +	cpu_pm_register_notifier(&riscv_srmcfg_pm_nb);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-dfustini-a=
tl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org?part=3D3
