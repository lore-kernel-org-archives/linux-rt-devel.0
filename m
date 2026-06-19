Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2EC31E85C;
	Fri, 19 Jun 2026 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781894431; cv=none; b=sysWbIBlGztxi5/AZ22pW596V5w3vchbrOgkTLvfUJjORZY4kNFSS5iHql8uSIYqb5k6Vj2ue8V+sqpptVDkM823wRHNhSptYNZYqWosNQE+zwaePMya6GbBMJfQZXnTiVFYbhBOBMo/jzEEOur2PlYNTsP8+fzanLjm3hKoO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781894431; c=relaxed/simple;
	bh=3n10e2iY6QMKhOw0pBWZGyhAqyVmaCPMoDySuypPPd4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i6psN9NmVIq4QwEjlx6RBfJpJOlCt8MQF8p1NW77z5EaaJVuclVVw1nYoEqd3gCxWkXln+Y4uVzpFJkvBnPPa+dspwWuSuafIoNrfl/v8We5D09mXGlusnG88MfJtpxBySR/ER0kHuPkjNZzJxGMrggmn7Xw6yG2gfEcSPDys4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlLqDvAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlLqDvAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCF31F000E9;
	Fri, 19 Jun 2026 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781894429;
	bh=3ufh8GcA52Oi1zevPONjZEeZM7ns83r3GsEz4MKFdAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OlLqDvAA6HMxxxVrL4k2F9XDQPoy/J9k5mKmVD6R4WTR3pETb1/h+cVlka/I8+IWy
	 8I8W2tVv5sh46RvhbL1EQcXXv8Ol437A/tlT1gnddzTHowz9MmKj8Cgp+a1Z11bbq8
	 w41H7DFBONh+1VXCpOLLpy0ZPMqPEDM1Drc1CnLFq7AQ58xPLX+zFw/EyLRHG1KQcU
	 NzrDS+4BTfAGvnGqh2VhnoH0oETLyg8ulzJNd+khhQdWenV+3XDUMUJm5KN4Jkf7Qi
	 gXaZK/nuhkkMnoDTTpZbq/XZc0pFzI9pD2RmEfTwYA9pI5qCp1/s9liftWGo+zj2RI
	 /46E5WENIZU0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] riscv: Add support for srmcfg CSR from Ssqosid
 extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260619-dfustini-atl-sc-cbqri-dt-v1-3-e79a7723fab0@kernel.org>
References: <20260619-dfustini-atl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org>
 <20260619-dfustini-atl-sc-cbqri-dt-v1-3-e79a7723fab0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 18:40:28 +0000
Message-Id: <20260619184028.ABCF31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The CPU PM exit notifier invalidates the software CSR cache but =
fails to eagerly restore the hardware CSR_SRMCFG, leaving the currently exe=
cuting task running with incorrect QoS IDs during system resume.
- [Medium] The CPU hotplug teardown callback's cache invalidation is premat=
urely overwritten by the idle task context switch, leaving the hardware CSR=
 out of sync when the CPU comes back online.
--

commit 083587978f6f45cace44a919e47c9276b0701827
Author: Drew Fustini <fustini@kernel.org>

riscv: Add support for srmcfg CSR from Ssqosid extension

This commit adds support for the srmcfg CSR defined in the Ssqosid ISA
extension. It allows setting the RCID and MCID for each task on context
switch to associate resource usage with the running task, and caches the
CSR state per-cpu to avoid redundant writes.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0

> diff --git a/arch/riscv/kernel/qos.c b/arch/riscv/kernel/qos.c
> index 0000000000000..42f1ff9b219d9
> --- /dev/null
> +++ b/arch/riscv/kernel/qos.c

[ ... ]

> +static int riscv_srmcfg_pm_notify(struct notifier_block *nb,
> +				  unsigned long action, void *unused)
> +{
> +	switch (action) {
> +	case CPU_PM_EXIT:
> +	case CPU_PM_ENTER_FAILED:
> +		__this_cpu_write(cpu_srmcfg, U32_MAX);
> +		break;

[Severity: Medium]
Will the currently executing task run with an incorrect hardware QoS ID dur=
ing
resume?

When the system resumes from deep idle or suspend, the hardware CSR_SRMCFG
is reset to an implementation-defined state. While this invalidates the
software cache, it doesn't immediately reprogram the hardware CSR.

Because there is no immediate context switch, does this leave the currently
running task executing with the reset hardware state until it is eventually
scheduled out?

Should this explicitly call __switch_to_srmcfg(current) to eagerly restore
the hardware state?

> +	}
> +	return NOTIFY_OK;
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

[Severity: Medium]
Is it possible the teardown callback's cache invalidation gets prematurely
overwritten by the idle task context switch?

The teardown callback runs at CPUHP_AP_ONLINE_DYN during CPU offline, which
sets the cache to U32_MAX. However, after this callback finishes, the dying
CPU must still context switch to the idle task to halt.

Will this context switch trigger __switch_to_srmcfg(idle_task), overwriting
the U32_MAX sentinel before the CPU powers off?

If so, when the CPU comes back online with a reset hardware CSR, and
schedules its first task, could it match the stale cache and skip the CSR
write, leaving the hardware CSR out of sync?

> +	if (err < 0) {
> +		pr_warn("srmcfg cpuhp registration failed (%d), cpus brought online af=
ter boot will not invalidate the CSR_SRMCFG cache\n",
> +			err);
> +		return err;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-dfustini-a=
tl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org?part=3D3
