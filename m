Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94E219E8;
	Fri, 26 Jun 2026 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782435363; cv=none; b=kcDrHOGMH3TQpwYQQaCfFNhpYBWo5kM42KCOfYHGeXBgIyd/VS2NyuRl2rmBwZBaPl49onyTGITcMi7dUnRGNWd5qlqW037Ssh6SmNe0hrD6ELDGFbSQ9LhtvTbWPKtyeHYhYk8Gxi52oJpmNAB3Zc1ZWZNvEqAXVmD2hPBzmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782435363; c=relaxed/simple;
	bh=qOX06uWedos8rk+zFyXSIy7MKZGpuLVWmx2CoklomW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYjPGLv4M7XFm9MaTLXvsRbbATQubT+cG+P+ZhhpSAlmbtwJ5vD/y+r1Wl2hKhGisQ5oRrwlMlr2kdR0T+vD2fCpCgfTMX5KNAcP9V3kojX1TD1bmqYR2GRWMbWDAeATldn698o+gOBKoPm2BE/9MSG8E81sfYbpunNoLGrfH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDoepVE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDoepVE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F9D1F000E9;
	Fri, 26 Jun 2026 00:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782435362;
	bh=ysKKFfnEd9fMd34RVQdBVCJIRaNtCRv3LpzVrhgDaX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mDoepVE53LkKVx3X0Az2q4ZO6fzO0EHxOt2Nsbda81xHb+VAlB8fTyVMuhpvHrca8
	 Ev50sfyZDfpx4SzeIF1E61JprAyY0Kn8ezkSLSUjfwMkOp8eK95+w+sseNyVwoQDj3
	 XbO/+7hWvif7xzMKHOf52aIFHqgHHJ+0xP8QuxubpEVp9dnjEthn8okC2TupivYCZ8
	 yCjgfka+6uDh/2nysqKEfWP2PTpnAEgPYAwcrqTckkTbEIXwhw7kbHxaY/hdGEXc1T
	 l4+izbOCea818ZmAAcRyxLOScFoZE03Bhg8/pOyrwxVQaLX/ISUfIpZaDnP9QpCB/m
	 OHrDomEwSY4xA==
Date: Thu, 25 Jun 2026 17:56:00 -0700
From: Drew Fustini <fustini@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 3/8] riscv: Add support for srmcfg CSR from Ssqosid
 extension
Message-ID: <aj3OIASOuSsvxJ+k@x1>
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
 <20260624-dfustini-atl-sc-cbqri-dt-v2-3-2f8049fd902b@kernel.org>
 <20260625015006.DF5041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625015006.DF5041F000E9@smtp.kernel.org>

On Thu, Jun 25, 2026 at 01:50:06AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] CPU hotplug cache invalidation is registered at the wrong state (CPUHP_AP_ONLINE_DYN), allowing the srmcfg cache sentinel to be overwritten before the CPU goes offline.
> --
> 
> commit d51eb8c4a6c5a57f238cc53688229c08ea6418e1
> Author: Drew Fustini <fustini@kernel.org>
> 
> riscv: Add support for srmcfg CSR from Ssqosid extension
> 
> This commit adds support for the srmcfg CSR defined in the Ssqosid ISA
> extension. It introduces a per-cpu cache to avoid redundant CSR writes
> during context switches and uses CPU hotplug and PM notifiers to manage
> cache invalidation.
> 
> Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> 
> > diff --git a/arch/riscv/kernel/qos.c b/arch/riscv/kernel/qos.c
> > new file mode 100644
> > index 0000000000000..ea33201a43f61
> > --- /dev/null
> > +++ b/arch/riscv/kernel/qos.c
> 
> [ ... ]
> 
> > +static int riscv_srmcfg_reset_cache(unsigned int cpu)
> > +{
> > +	per_cpu(cpu_srmcfg, cpu) = U32_MAX;
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> > +static int __init riscv_srmcfg_init(void)
> > +{
> > +	int err;
> > +
> > +	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID))
> > +		return 0;
> > +
> > +	/*
> > +	 * cpuhp_setup_state() invokes the startup callback locally on every
> > +	 * already-online CPU, so no separate seed loop is needed here.
> > +	 */
> > +	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/srmcfg:online",
> > +				riscv_srmcfg_reset_cache, riscv_srmcfg_reset_cache);
> 
> [Severity: High]
> Does registering the hotplug callbacks at CPUHP_AP_ONLINE_DYN run too early
> during teardown and too late during startup?
> 
> Since CPUHP_AP_ONLINE_DYN teardown runs while the CPU is still schedulable,
> could the U32_MAX sentinel set by riscv_srmcfg_reset_cache() be overwritten
> by subsequent context switches (such as switching to the idle thread) before
> the CPU actually goes offline?

That is correct that the U32_MAX sentinel can be overwritten by the idle
task or per-cpu kthreads that run while CPU is dying. This is not a
problem in practice as they have thread.srmcfg == 0 which results in
cpu_srmcfg_default.

I will update the riscv_srmcfg_reset_cache() comment to clarify that the
teardown callback is not relied on.

> If a CPU is offlined and then onlined, the stale cache would persist while
> the hardware CSR has been reset. Because the CPU becomes schedulable before
> the CPUHP_AP_ONLINE_DYN startup callback runs, a task matching the stale
> cache might skip the required CSR write and run with incorrect hardware tags.

A normal task cannot run on the CPU before the startup callback re-arms
the sentinel. riscv_srmcfg_reset_cache() writes cpu_srmcfg = U32_MAX
before set_cpu_active(). Only the idle task and per-cpu kthreads run in
the window before, and they carry thread.srmcfg == 0. That means they
take the CPU default rcid and mcid, not stale ones.

Drew
