Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E393D565F;
	Wed,  5 Aug 2026 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956091; cv=none; b=CvB9opAQiGyTf0ZTJW4Mtu/UPjY56ECs7XSDMlSv3gqGXIB0totk7KFdkcENo8ALaObFVl02PzBlvZM+3hs2pZMGPxtJaLCvCp8g2mXCdijuHbBAxSYoLNZZM3ThskGZjSBf20DjdiDWmnYS0PD5vKrqlfzGToI3jL1MSeegTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956091; c=relaxed/simple;
	bh=N9ueinDu7+yNBWtXLB4wmzJ9pMLslPpieTw27NjT0FY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KVrB977v2iUD1WEWU+JRu0emw5+UADvjh+W0iqfcaFG2npuU6W0RCFPGPgQJyKQe2/fy95mmm73ZvMzycIL1C+joIBvnRkQ4AFdG+e2pOZ67c1m+XrE64jMExm6eRoJji6MvApfFJME1FpaxTArEZgw0aNpkP7m+aCO9dXTGDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0Kz/AYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0Kz/AYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C259C1F000E9;
	Wed,  5 Aug 2026 18:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785956087;
	bh=LZFgktKwDepiLJ2wPxJe5QgCEqoGd2XF3OANmnNyJgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=C0Kz/AYmxT/OnCfSlVLghSdaaDWTgsFLSNNPkhWLjyL8GZNtXeMtxEVfnCjeSZXJy
	 YybQzXRgTaoeNIJkZ2nVU+b3Tlj7IAnZdHs+9/ayNPYxOc6ReFkubyT09326N7OPdW
	 mziOxpsjXk1rqwEWAskVX8sU6IDrSen8yFF5M9qRcGet9MjOwTbtVcNYSqFDr1TNA4
	 LCt4FenzirOQVgUKEIDpimJFAJC2i0+yfJSTV57JnuHujHh1vwMytbJTaL+Sx+vu/G
	 y/o1GXTayoPj8T0mnhTe6/CaIJXLmcgagqrRM/gj8+B99BJma7A0Bz0LK8I67rmZkB
	 VCHNJSWclcntQ==
Date: Wed, 5 Aug 2026 12:54:42 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Drew Fustini <fustini@kernel.org>
cc: Adrien Ricciardi <aricciardi@baylibre.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
    Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, 
    Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
    Chen Pei <cp0613@linux.alibaba.com>, 
    Conor Dooley <conor.dooley@microchip.com>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>, 
    Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, 
    guo.wenjia23@zte.com.cn, James Morse <james.morse@arm.com>, 
    =?ISO-8859-2?Q?Kornel_Dul=EAba?= <mindal@semihalf.com>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn, 
    Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
    Peter Newman <peternewman@google.com>, 
    =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@ventanamicro.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Rob Herring <robh@kernel.org>, 
    Samuel Holland <samuel.holland@sifive.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Tony Luck <tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
    Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
    yunhui cui <cuiyunhui@bytedance.com>, 
    Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
    linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
    x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 3/8] riscv: Add support for srmcfg CSR from Ssqosid
 extension
In-Reply-To: <20260729-dfustini-atl-sc-cbqri-dt-v6-3-7c22b05d461b@kernel.org>
Message-ID: <3b6dd35e-dabb-3cb0-547f-0c8a0b035e1a@kernel.org>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org> <20260729-dfustini-atl-sc-cbqri-dt-v6-3-7c22b05d461b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Wed, 29 Jul 2026, Drew Fustini wrote:

> Add support for the srmcfg CSR defined in the Ssqosid ISA extension.
> The CSR contains two fields:
> 
>   - Resource Control ID (RCID) for resource allocation
>   - Monitoring Counter ID (MCID) for tracking resource usage
> 
> Requests from a hart to shared resources are tagged with these IDs,
> allowing resource usage to be associated with the running task.
> 
> Add a srmcfg field to thread_struct with the same format as the CSR.
> The context-switch path writes the field to the CSR, and
> resctrl_arch_set_closid_rmid() updates it when a task is assigned to a
> resctrl control or monitoring group.
> 
> A per-cpu cpu_srmcfg_default holds the default srmcfg for each CPU, set
> by resctrl_arch_set_cpu_default_closid_rmid() on CPU group assignment.
> On context switch, RCID and MCID inherit from the CPU default
> independently: a task whose thread RCID field is zero takes the CPU
> default's RCID, and likewise for MCID.

Thanks, queued for v7.3, but with one change (below):

> diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> new file mode 100644
> index 000000000000..cf19e8438bb9
> --- /dev/null
> +++ b/arch/riscv/include/asm/qos.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_QOS_H
> +#define _ASM_RISCV_QOS_H
> +
> +#include <linux/percpu-defs.h>
> +
> +#ifdef CONFIG_RISCV_ISA_SSQOSID
> +
> +#include <linux/bitfield.h>
> +#include <linux/cpufeature.h>
> +#include <linux/sched.h>
> +
> +#include <asm/csr.h>
> +#include <asm/hwcap.h>
> +
> +/* cached value of srmcfg csr for each cpu */
> +DECLARE_PER_CPU(u32, cpu_srmcfg);
> +
> +/* default srmcfg value for each cpu, set via resctrl cpu assignment */
> +DECLARE_PER_CPU(u32, cpu_srmcfg_default);
> +
> +static inline void __switch_to_srmcfg(struct task_struct *next)
> +{
> +	u32 thread_srmcfg, default_srmcfg;
> +
> +	thread_srmcfg = READ_ONCE(next->thread.srmcfg);

What is the intent of the READ_ONCE() here?  

I've dropped it from what's been queued for now.  If it's really 
needed, please let us know why.


thanks,

- Paul
