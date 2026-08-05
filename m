Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B013D6688;
	Wed,  5 Aug 2026 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963048; cv=none; b=Cn1tS2ZhDe90yupMRIUy0qH1MLmBCFGmZZjmY59oEpOpZbeUQ4UC1VugYJEXh3Gc9I3GbwCxD+WWzttVt0sNtGGlrFY79FIhjo8piJQwLtzWh6nebzWNw9mHOaD/Nxq6u4OQDM+rqXvfhbVZ68BfKbGTSCjfo2xPOihvOrQuWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963048; c=relaxed/simple;
	bh=x9RLYW+/E4PHjhuGD/U1f9/icKaLT4GvUvpvF58YiEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNsgMXsoNEuOjVsB/qGJVyoKP4zGyA68CbfVFGbgq7Zb2OUvFusUesSnRV97z7yMFm2YqJuiBw1NmdlW0Ryab5DEMrxP5zm0GYsqVfcLy7gTCBrQIT7Z9f1W6bjR0tGgIVoWrILqTDSaoPE25D0uAJ/p14w0OycmVtMuViw/cUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WncqtGrp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WncqtGrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C741F00A3A;
	Wed,  5 Aug 2026 20:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785963046;
	bh=G++DbwSiUfVLHD8mc41VhyTUG03Wep5oKHw2pOGnKgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WncqtGrpdC8Yzn9eLoX3ZVFiSW7ZWrIypm/oqVAUoMefWs1UPjmWxM3x+2zq+J27m
	 QAaJKWgrC+pc4ItCtATBZGIvZZrwpXng00pybpJntvEJYmXvgZ9p7NqjkBqkl5FnTo
	 t/JORJItzPpYup5zcO1wRpN9nr2FCW86cVBBicnkWy+CvOsKU9kTsx27kiOetB41fG
	 PbtwipVRsCwF1w+1w9/1PjF3C4AIHga265v98pk1LTcqGoOKpX8ZLOlrNxMz4ZB4fc
	 emJwqwAHRPoOj+8cf4oJJZFBzvuZ44W1PSubucX148xBnAonhoMTD7TZWc9bk8SWBW
	 AFlV0iC3h0Itw==
Date: Wed, 5 Aug 2026 13:50:44 -0700
From: Drew Fustini <fustini@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
	Borislav Petkov <bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn,
	James Morse <james.morse@arm.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Newman <peternewman@google.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, devicetree@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 3/8] riscv: Add support for srmcfg CSR from Ssqosid
 extension
Message-ID: <anOiJHmU24Lpbizi@x1>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
 <20260729-dfustini-atl-sc-cbqri-dt-v6-3-7c22b05d461b@kernel.org>
 <3b6dd35e-dabb-3cb0-547f-0c8a0b035e1a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b6dd35e-dabb-3cb0-547f-0c8a0b035e1a@kernel.org>

On Wed, Aug 05, 2026 at 12:54:42PM -0600, Paul Walmsley wrote:
> Hi,
> 

> On Wed, 29 Jul 2026, Drew Fustini wrote:
> 
> > Add support for the srmcfg CSR defined in the Ssqosid ISA extension.
> > The CSR contains two fields:
> > 
> >   - Resource Control ID (RCID) for resource allocation
> >   - Monitoring Counter ID (MCID) for tracking resource usage
> > 
> > Requests from a hart to shared resources are tagged with these IDs,
> > allowing resource usage to be associated with the running task.
> > 
> > Add a srmcfg field to thread_struct with the same format as the CSR.
> > The context-switch path writes the field to the CSR, and
> > resctrl_arch_set_closid_rmid() updates it when a task is assigned to a
> > resctrl control or monitoring group.
> > 
> > A per-cpu cpu_srmcfg_default holds the default srmcfg for each CPU, set
> > by resctrl_arch_set_cpu_default_closid_rmid() on CPU group assignment.
> > On context switch, RCID and MCID inherit from the CPU default
> > independently: a task whose thread RCID field is zero takes the CPU
> > default's RCID, and likewise for MCID.
> 
> Thanks, queued for v7.3, but with one change (below):
> 
> > diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> > new file mode 100644
> > index 000000000000..cf19e8438bb9
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/qos.h
> > @@ -0,0 +1,74 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_RISCV_QOS_H
> > +#define _ASM_RISCV_QOS_H
> > +
> > +#include <linux/percpu-defs.h>
> > +
> > +#ifdef CONFIG_RISCV_ISA_SSQOSID
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/cpufeature.h>
> > +#include <linux/sched.h>
> > +
> > +#include <asm/csr.h>
> > +#include <asm/hwcap.h>
> > +
> > +/* cached value of srmcfg csr for each cpu */
> > +DECLARE_PER_CPU(u32, cpu_srmcfg);
> > +
> > +/* default srmcfg value for each cpu, set via resctrl cpu assignment */
> > +DECLARE_PER_CPU(u32, cpu_srmcfg_default);
> > +
> > +static inline void __switch_to_srmcfg(struct task_struct *next)
> > +{
> > +	u32 thread_srmcfg, default_srmcfg;
> > +
> > +	thread_srmcfg = READ_ONCE(next->thread.srmcfg);
> 
> What is the intent of the READ_ONCE() here?  
> 
> I've dropped it from what's been queued for now.  If it's really 
> needed, please let us know why.
> 
> 
> thanks,
> 
> - Paul

Thanks for queuing this patch. It is okay to leave out the READ_ONCE()
since only Patches 1-3 are being applied.

The READ_ONCE() is meant to pair with the WRITE_ONCE() in
resctrl_arch_set_closid_rmid(), which comes in patch 5. RCID and MCID
share the srmcfg csr, and resctrl can update thread.srmcfg from another
hart while this task is switched in.

Without READ_ONCE(), the compiler may reload the field between the zero
test and the two FIELD_GET() calls, so thread_srmcfg could end up with
RCID from the old value and MCID from the new one. arm64 MPAM uses
READ_ONCE() here for the same reason for mpam_get_regval() in
arch/arm64/include/asm/mpam.h

Thanks,
Drew
