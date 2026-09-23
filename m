Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D947DD4A
	for <linux-rt-devel@lists.linux.dev>; Wed, 23 Sep 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154812; cv=pass; b=CmnG4YDw0BxXHnVJvoJbvWkKVHxedlJLWfE/XBhRdpmc2xOe9FnS2SB/FHm+MVy80dPG68s7V733Z1Yz1USatu1Be8oOhjtCpkSv05FQ7/HSwYC4kMB5jpVhH/frvMMAPsvTf+k//HJBofyBCUdI3NJkbYiQf7YQX/3DqRsqGV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154812; c=relaxed/simple;
	bh=UNaPbaGAe6mDUtdWti8yDkXMxxRmuEwWHIu7PKT5dw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bA2uy9evUoJDugeNhZxRBjrqUnDBqf0rTunAScE+Z6IW/i6yATNJhCViVKd8+lyd8GEzUvUMYAgsaHAwKM7XcKAq7bsFMmlfwfTV/7Jl2J6AkSxW9dNsJhjwF+NPcS0HvP3ACG9802MGJg4Zk1+Pa2ebE7l1smV6X1Ov5eHb0LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d8qOMnHt; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d8qOMnHt"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6c2613d8157so349169eaf.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 23 Sep 2026 02:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790154807; cv=none;
        d=google.com; s=arc-20260327;
        b=U+OJiNAJM3dhcefFk0bhY+t+kwgJv6t4Yvbyr84wgcTAG0qJWK3+ydgNe4Bd80x1r6
         s0AbwZbKpWEWhouKt6ntN3/Iw9fr940qVxsTwM+kwNW/04gSMP+cWFLMDOdtSRn+LCyv
         qwuhzLdx4YZln0zwkjUy7WFTjLDRjqiif1rg9BDy7sNIjqtnWmL8CitECmjAkVBaRUs+
         yG//onen2hb35ulhy34NMNhwUcoE5beYF16c7mvnO3hTuqMjpSWE3j3fF9gEdzHJvtDI
         Tnpt+ksjXVsoZhITVTNz1IgAnEQjBUd7YLSRVT07iexVaTTBMMOYz49eme8r2EFe9piT
         qJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/RNW8Ass0WBbgYgG7Ctc1GZ9e4vdeYBANuSzejgShgY=;
        fh=B0BwpDtX/ehv5zEz28RL3s7T1f8ctni62dtykgkXI7s=;
        b=O30Nn2Xwat45o2LJZrBC5Zfu53utSA71jBZNPLu9NF5nCFYGlS0yQDaCL1gzyj+6ja
         8sxQLSoniOX+cHeHJt87dtT7a8hMheKkJ46/OyhoYynIOh0vyLdlYaN6Dj1YJpG0hi0E
         yRlKOhyjGSeQWSazvrL4AUGRc7spbBsGp+veg8SIGX0WHu6obJLbjJZVMKrRv8+oYP5k
         lhoJcbXTk6jhI9/ubIPjpdVmMkUYlMXVyhNdKBKEOatZynUeYiHCp3VqPcvyiEEMdQgT
         Apn+IUb2gm6E5Tvn4XXETTWOJzuBJ4I5tj41uPBixPSmEcj4syO7Tr8dy8Tb8Ds6owRz
         XGPA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790154807; x=1790759607; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/RNW8Ass0WBbgYgG7Ctc1GZ9e4vdeYBANuSzejgShgY=;
        b=d8qOMnHtI80mSYsZPnjdyyG94inFv24dyT2jU9jWmOTbzSIuRxXIvAvCWDNsh8oYkp
         VFvwFiDnw52akzRloulEf9p+am+iFuRG1Re/3pTmDgzeHrR3sPqDlG1lwBnZxwlU8nqj
         +t8SX6XDr9DkhFDBRf0C2ND+taM5vqGo3ZmyiUQ0M1ZHisjwnriFe8Nd5wgU8l1TaXiR
         aSjMha2dD9VyJIUj1QEr1nYag87cLRy6PyF0H1TqpfGQn18akCcQTLKQwULHsh5UTltb
         im/po2dJmcWfI8FSZSaE/zg7VqtLu9lFNfR+/XEOWv/r7qS6Ab9Eg1vKINJHtPhQeKvC
         sOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790154807; x=1790759607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RNW8Ass0WBbgYgG7Ctc1GZ9e4vdeYBANuSzejgShgY=;
        b=ufNTAc64P+AKkuwgB4CBtI4outAV9z/fNxZ5UeQWk0FCZe9xt76Ap5BeamnS9YyxuG
         J28WXH0OfQQjPZ2f3+w/8g2R4zXwjSlwr3UR3JczAFxBMvLs1nGMGhF2ZNVE/0ZcJwGF
         k7xLBO2Cnt4W05JbItA20fAQD7NKS9sD9aWlxNDyJVLMkkh87RuwB4W6hCFaqBnGrH18
         /iBtNJzzmtsu60y3hcMzLXMzlAxEosIeLC6c5InSHucKSQB5gMlPbBUasAh/o0tsKl/l
         ulDlxlvXVgwEla3oFL+AQmfkmPRTxQi/x7IbuSsUBkulOPOeeGhBogpAlVDyvvJpF1YH
         GrLg==
X-Forwarded-Encrypted: i=1; AKwUvBy3j0ggpNkH8Aw35O0GrsX2RX/bcq+6JGnWH2vIHxkuoGkrF6yIry6lmDUPXhC8TjOk1R6zde5QN+dEDiQV4Q==@lists.linux.dev
X-Gm-Message-State: AFuF++no5RElEuzYPTGnYpW7q5/YlEbtZAjmnFQxBhBbyp1lFvGF3FHr
	Ky+biiQhprlpbSMQp1CYqHbGRc8M18YpoKxPuTjGSZ4pImMIN1n5Uz0Eqi4ticOeCusHj3pgEij
	kmCd16W74XtUDmnDGhk8rdW1tPMJ/AYdvKP1KPpjf7g==
X-Gm-Gg: AYBFou0Gt3i3qEnYfwX6QCKwxBwg+jKgq0Q5fcUVvq2alQLApHTB4LVwx1ugrFNa+vs
	asVHPpxgfcf6F1Rrd8UPtlgnfQZY94TSDYgNzNgVI6MvMAhhK0wIG3Xg23Jyiwd6eFJoRDirHq1
	vEigDJbqLeXh/GHAPyDzWW8WSDastSLGXayn8hIIk7ZeMm+/PBunK27THfLM/iakPzDZyWoIBEH
	cmQHaoWRKxf8KQnAthuI/XYgMk+LFPWO+5IQacnaS5w3mn2b4ie3WNiDCrsSHoJK6iuMtGAf+Wn
	UgO5xmnstiQn8gWGeJvPD8sPnDjvGXqjesA/f3B4F7fOHJcLiHEfBUEjs/BXyg==
X-Received: by 2002:a05:6820:1524:b0:6cd:3fdb:fa65 with SMTP id
 006d021491bc7-6d2d3908806mr1910348eaf.80.1790154806396; Wed, 23 Sep 2026
 02:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260917-dfustini-atl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org> <20260917-dfustini-atl-sc-cbqri-dt-v8-2-7964e8d73fe8@kernel.org>
In-Reply-To: <20260917-dfustini-atl-sc-cbqri-dt-v8-2-7964e8d73fe8@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 23 Sep 2026 17:13:15 +0800
X-Gm-Features: AclHuK9IVM3akbZF4_8i8WYwzisHdVqvCgHyIAHT0vXfyU_pYbs5SakXxCGkRpY
Message-ID: <CAEEQ3w=pDjEGfMtHUamxLFa0+qYuZ=od0OhAUH7_h+ybMAiO4g@mail.gmail.com>
Subject: Re: [External] [PATCH v8 2/5] riscv_cbqri: resctrl: Add cache
 allocation via capacity block mask
To: Drew Fustini <fustini@kernel.org>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, 
	Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor+dt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	Fenghua Yu <fenghuay@nvidia.com>, Gong Shuai <gong.shuai@sanechips.com.cn>, 
	Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn, 
	James Morse <james.morse@arm.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn, 
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Peter Newman <peternewman@google.com>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rob Herring <robh@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tony Luck <tony.luck@intel.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, devicetree@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fustini,

On Fri, Sep 18, 2026 at 12:41=E2=80=AFAM Drew Fustini <fustini@kernel.org> =
wrote:
>
> Wire CBQRI capacity controllers into resctrl as RDT_RESOURCE_L2 and
> RDT_RESOURCE_L3 schemata.
>
> resctrl exposes a single capacity mask per resource, so when more than
> one capacity controller backs a cache level they must report the same
> number of capacity blocks. The same holds for the other capabilities
> resctrl exposes once per resource. A level whose controllers disagree
> is left unexposed. Other levels are unaffected.
>
> Control domains are created in the cpuhp online callback and keyed on
> the onlining CPU's cache id from cacheinfo, so a CPU that is offline at
> probe time still joins its domain once it comes online. A domain is
> published on the ctrl_domains RCU list only after it is fully
> initialized and brought online, and removed from the list before it is
> taken offline, following the documented safe traversal rules.
>
> Assisted-by: LLM
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                      |   2 +
>  arch/riscv/include/asm/resctrl.h | 147 ++++++++
>  drivers/resctrl/Kconfig          |   4 +
>  drivers/resctrl/Makefile         |   1 +
>  drivers/resctrl/cbqri_resctrl.c  | 785 +++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 939 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92b111cd25c0..db0799d8cbf8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23570,9 +23570,11 @@ R:     yunhui cui <cuiyunhui@bytedance.com>
>  L:     linux-riscv@lists.infradead.org
>  S:     Supported
>  F:     arch/riscv/include/asm/qos.h
> +F:     arch/riscv/include/asm/resctrl.h
>  F:     arch/riscv/kernel/qos.c
>  F:     drivers/resctrl/cbqri_devices.c
>  F:     drivers/resctrl/cbqri_internal.h
> +F:     drivers/resctrl/cbqri_resctrl.c
>  F:     include/linux/riscv_cbqri.h
>
>  RISC-V RPMI AND MPXY DRIVERS
> diff --git a/arch/riscv/include/asm/resctrl.h b/arch/riscv/include/asm/re=
sctrl.h
> new file mode 100644
> index 000000000000..b08f4e12f7aa
> --- /dev/null
> +++ b/arch/riscv/include/asm/resctrl.h
> @@ -0,0 +1,147 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_RISCV_RESCTRL_H
> +#define _ASM_RISCV_RESCTRL_H
> +
> +#include <linux/resctrl_types.h>
> +#include <linux/sched.h>
> +#include <linux/types.h>
> +
> +#include <asm/qos.h>
> +
> +struct rdt_resource;
> +
> +/*
> + * Sentinel "no CLOSID assigned" used by resctrl_arch_rmid_idx_decode().
> + * fs/resctrl treats this opaquely. CBQRI uses MCID directly as the line=
ar
> + * rmid index, so closid is unused on decode.
> + */
> +#define RISCV_RESCTRL_EMPTY_CLOSID     ((u32)~0)
> +
> +/*
> + * Terminology mapping between x86 (Intel RDT/AMD QoS) and RISC-V:
> + *
> + *  CLOSID on x86 is RCID on RISC-V
> + *    RMID on x86 is MCID on RISC-V
> + *     CDP on x86 is AT (access type) on RISC-V
> + */
> +
> +/**
> + * resctrl_arch_alloc_capable() - any CBQRI controller exposes resctrl a=
lloc
> + *
> + * Returns true once at least one CBQRI controller has successfully prob=
ed for
> + * a resctrl-exposed cache capacity allocation feature. Only meaningful =
after
> + * cbqri_resctrl_setup() runs at late_initcall.
> + */
> +bool resctrl_arch_alloc_capable(void);
> +
> +/**
> + * resctrl_arch_mon_capable() - any CBQRI controller exposes resctrl mon=
itoring
> + *
> + * The CBQRI driver implements capacity allocation only and wires up no
> + * monitoring events, so this always returns false. fs/resctrl reference=
s it
> + * unconditionally, hence the stub.
> + */
> +bool resctrl_arch_mon_capable(void);
> +
> +/**
> + * resctrl_arch_rmid_idx_encode() - encode (RCID, MCID) into a linear in=
dex
> + * @closid: RCID (resource control id)
> + * @rmid:   MCID (monitoring counter id)
> + *
> + * RISC-V uses MCID directly as the linear index into per-RMID arrays
> + * managed by fs/resctrl, since CBQRI controllers admit any MCID for any
> + * RCID. closid is unused here. CDP is encoded via the AT field on each
> + * CBQRI op rather than via the index.
> + */
> +u32  resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid);
> +
> +/**
> + * resctrl_arch_rmid_idx_decode() - inverse of resctrl_arch_rmid_idx_enc=
ode()
> + * @idx:    linear index
> + * @closid: out: always RISCV_RESCTRL_EMPTY_CLOSID
> + * @rmid:   out: the MCID that @idx encodes
> + */
> +void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid);
> +
> +/**
> + * resctrl_arch_set_cpu_default_closid_rmid() - install per-CPU srmcfg d=
efault
> + * @cpu:    CPU number
> + * @closid: RCID to use when no task is matched
> + * @rmid:   MCID to use when no task is matched
> + *
> + * Sets the per-CPU cpu_srmcfg_default so __switch_to_srmcfg() can fall =
back
> + * to the CPU's default RCID/MCID for default-group tasks (those whose
> + * thread.srmcfg encodes to 0, i.e. closid =3D=3D RESCTRL_RESERVED_CLOSI=
D and
> + * rmid =3D=3D RESCTRL_RESERVED_RMID). Implements resctrl allocation rul=
e 2
> + * ("CPU default") on RISC-V.
> + */
> +void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 r=
mid);
> +
> +/**
> + * resctrl_arch_sched_in() - context-switch hook to install task RCID/MC=
ID
> + * @tsk: the task being scheduled in
> + *
> + * Called from finish_task_switch() to write tsk->thread.srmcfg into the
> + * srmcfg CSR. Tasks tagged with RISCV_RESCTRL_EMPTY_CLOSID inherit the
> + * per-CPU default set via resctrl_arch_set_cpu_default_closid_rmid().
> + */
> +void resctrl_arch_sched_in(struct task_struct *tsk);
> +
> +/**
> + * resctrl_arch_set_closid_rmid() - tag a task with an RCID/MCID
> + * @tsk:    task to tag
> + * @closid: RCID to install
> + * @rmid:   MCID to install
> + *
> + * Updates tsk->thread.srmcfg with the encoded (RCID, MCID) pair. The ne=
w
> + * value takes effect on the next resctrl_arch_sched_in() for this task.
> + */
> +void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u=
32 rmid);
> +
> +/**
> + * resctrl_arch_match_closid() - test whether a task carries a given RCI=
D
> + * @tsk:    task
> + * @closid: RCID
> + */
> +bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid);
> +
> +/**
> + * resctrl_arch_match_rmid() - test whether a task carries a given (RCID=
, MCID)
> + * @tsk:    task
> + * @closid: RCID
> + * @rmid:   MCID
> + */
> +bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rm=
id);
> +
> +/**
> + * resctrl_arch_mon_ctx_alloc() - allocate per-monitor-event arch contex=
t
> + * @r:     resctrl resource being monitored
> + * @evtid: which monitor event needs context
> + *
> + * The CBQRI driver implements no monitoring events, so there is no per-=
event
> + * context to allocate and the stub returns NULL. fs/resctrl references =
it
> + * unconditionally before checking resctrl_arch_mon_capable().
> + */
> +void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, enum resctrl_ev=
ent_id evtid);
> +
> +/**
> + * resctrl_arch_mon_ctx_free() - release context returned by mon_ctx_all=
oc()
> + * @r:            resctrl resource
> + * @evtid:        monitor event id
> + * @arch_mon_ctx: pointer returned by resctrl_arch_mon_ctx_alloc()
> + */
> +void resctrl_arch_mon_ctx_free(struct rdt_resource *r, enum resctrl_even=
t_id evtid,
> +                              void *arch_mon_ctx);
> +
> +static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
> +{
> +       return val;
> +}
> +
> +/* Not needed for RISC-V */
> +static inline void resctrl_arch_enable_mon(void) { }
> +static inline void resctrl_arch_disable_mon(void) { }
> +static inline void resctrl_arch_enable_alloc(void) { }
> +static inline void resctrl_arch_disable_alloc(void) { }
> +
> +#endif /* _ASM_RISCV_RESCTRL_H */
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> index 1219fb29aa2e..cac23d20124b 100644
> --- a/drivers/resctrl/Kconfig
> +++ b/drivers/resctrl/Kconfig
> @@ -38,3 +38,7 @@ menuconfig RISCV_CBQRI
>           RISC-V cache QoS resources. CBQRI exposes cache capacity
>           allocation through the resctrl filesystem at /sys/fs/resctrl wh=
en
>           RESCTRL_FS is also enabled.
> +
> +config RISCV_CBQRI_RESCTRL_FS
> +       bool
> +       default y if RISCV_CBQRI && RESCTRL_FS
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4d8a2c4b5627..a7631712dba9 100644
> --- a/drivers/resctrl/Makefile
> +++ b/drivers/resctrl/Makefile
> @@ -6,3 +6,4 @@ ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)       +=3D -DDE=
BUG
>
>  obj-$(CONFIG_RISCV_CBQRI)                      +=3D cbqri.o
>  cbqri-y                                                +=3D cbqri_device=
s.o
> +cbqri-$(CONFIG_RISCV_CBQRI_RESCTRL_FS)         +=3D cbqri_resctrl.o
> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resc=
trl.c
> new file mode 100644
> index 000000000000..0c4bfa2a7f43
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c
> @@ -0,0 +1,785 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/bitfield.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/cleanup.h>
> +#include <linux/riscv_cbqri.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufeature.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/rculist.h>
> +#include <linux/resctrl.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <asm/csr.h>
> +#include <asm/qos.h>
> +
> +#include "cbqri_internal.h"
> +
> +struct cbqri_resctrl_res {
> +       struct cbqri_controller *ctrl;
> +       struct rdt_resource     resctrl_res;
> +       bool                    cdp_enabled;
> +};
> +
> +struct cbqri_resctrl_dom {
> +       struct rdt_ctrl_domain  resctrl_ctrl_dom;
> +       struct cbqri_controller *hw_ctrl;
> +};
> +
> +static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCE=
S];
> +
> +static bool exposed_alloc_capable;
> +
> +/* Protects ctrl_domain list mutations across CPU hotplug. */
> +static DEFINE_MUTEX(cbqri_domain_list_lock);
> +
> +static struct rdt_ctrl_domain *
> +cbqri_find_ctrl_domain(struct list_head *h, int id)
> +{
> +       struct rdt_domain_hdr *hdr =3D resctrl_find_domain(h, id, NULL);
> +
> +       return hdr ? container_of(hdr, struct rdt_ctrl_domain, hdr) : NUL=
L;
> +}
> +
> +/* Map a hardware cache level to its resctrl resource id, or -ENODEV. */
> +static int cbqri_cache_level_to_rid(u32 cache_level)
> +{
> +       switch (cache_level) {
> +       case 2:
> +               return RDT_RESOURCE_L2;
> +       case 3:
> +               return RDT_RESOURCE_L3;
> +       default:
> +               return -ENODEV;
> +       }
> +}
> +
> +static int cbqri_apply_cache_config_dom(struct cbqri_resctrl_dom *hw_dom=
,
> +                                       struct rdt_resource *r,
> +                                       u32 closid, enum resctrl_conf_typ=
e t,
> +                                       u64 cbm)
> +{
> +       struct cbqri_resctrl_res *hw_res =3D
> +               container_of(r, struct cbqri_resctrl_res, resctrl_res);
> +       struct cbqri_cc_config cfg =3D {
> +               .cbm =3D cbm,
> +               .at =3D (t =3D=3D CDP_CODE) ? CBQRI_CONTROL_REGISTERS_AT_=
CODE :
> +                                       CBQRI_CONTROL_REGISTERS_AT_DATA,
> +               .cdp_enabled =3D hw_res->cdp_enabled,
> +       };
> +
> +       return cbqri_apply_cache_config(hw_dom->hw_ctrl, closid, &cfg);
> +}
> +
> +bool resctrl_arch_alloc_capable(void)
> +{
> +       return exposed_alloc_capable;
> +}
> +
> +bool resctrl_arch_mon_capable(void)
> +{
> +       return false;
> +}
> +
> +bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level rid)
> +{
> +       if (rid !=3D RDT_RESOURCE_L2 && rid !=3D RDT_RESOURCE_L3)
> +               return false;
> +       return cbqri_resctrl_resources[rid].cdp_enabled;
> +}
> +
> +int resctrl_arch_set_cdp_enabled(enum resctrl_res_level rid, bool enable=
)
> +{
> +       struct cbqri_resctrl_res *cbqri_res;
> +
> +       if (rid !=3D RDT_RESOURCE_L2 && rid !=3D RDT_RESOURCE_L3)
> +               return -ENODEV;
> +
> +       cbqri_res =3D &cbqri_resctrl_resources[rid];
> +       if (!cbqri_res->resctrl_res.cdp_capable)
> +               return -ENODEV;
> +
> +       cbqri_res->cdp_enabled =3D enable;
> +       return 0;
> +}
> +
> +struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
> +{
> +       if (l >=3D RDT_NUM_RESOURCES)
> +               return NULL;
> +
> +       return &cbqri_resctrl_resources[l].resctrl_res;
> +}
> +
> +bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
> +{
> +       return false;
> +}
> +
> +void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r,
> +                                enum resctrl_event_id evtid)
> +{
> +       return NULL;
> +}
> +
> +void resctrl_arch_mon_ctx_free(struct rdt_resource *r,
> +                              enum resctrl_event_id evtid, void *arch_mo=
n_ctx)
> +{
> +}
> +
> +void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_l3_mon_=
domain *d,
> +                             enum resctrl_event_id evtid, u32 rmid, u32 =
closid,
> +                             u32 cntr_id, bool assign)
> +{
> +}
> +
> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_l3_mon_dom=
ain *d,
> +                          u32 unused, u32 rmid, int cntr_id,
> +                          enum resctrl_event_id eventid, u64 *val)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
> +{
> +       return false;
> +}
> +
> +int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable=
)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_l3_mon_d=
omain *d,
> +                            u32 unused, u32 rmid, int cntr_id,
> +                            enum resctrl_event_id eventid)
> +{
> +}
> +
> +bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r)
> +{
> +       return false;
> +}
> +
> +int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +void resctrl_arch_mon_event_config_read(void *info)
> +{
> +}
> +
> +void resctrl_arch_mon_event_config_write(void *info)
> +{
> +}
> +
> +void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_m=
on_domain *d)
> +{
> +}
> +
> +void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_d=
omain *d,
> +                            u32 unused, u32 rmid, enum resctrl_event_id =
eventid)
> +{
> +}
> +
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr=
 *hdr,
> +                          u32 closid, u32 rmid, enum resctrl_event_id ev=
entid,
> +                          void *arch_priv, u64 *val, void *arch_mon_ctx)
> +{
> +       return -ENODATA;
> +}
> +
> +/*
> + * Note about terminology between x86 (Intel RDT/AMD QoS) and RISC-V:
> + *   CLOSID on x86 is RCID on RISC-V
> + *     RMID on x86 is MCID on RISC-V
> + */
> +u32 resctrl_arch_get_num_closid(struct rdt_resource *res)
> +{
> +       struct cbqri_resctrl_res *hw_res;
> +
> +       hw_res =3D container_of(res, struct cbqri_resctrl_res, resctrl_re=
s);
> +
> +       if (!hw_res->ctrl)
> +               return 0;
> +
> +       return hw_res->ctrl->rcid_count;
> +}

When CDP is enabled, the resctrl core halves the value returned by
resctrl_arch_get_num_closid(). Is that correct for CBQRI?
CBQRI v1.0 defines allocation using an (RCID, AT) pair, and its example
uses the same RCID=3D5 for separate AT=3D0 and AT=3D1 allocations.

Thanks,
Yunhui

> +
> +u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +       return 1;
> +}
> +
> +u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
> +{
> +       return rmid;
> +}
> +
> +void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
> +{
> +       *closid =3D RISCV_RESCTRL_EMPTY_CLOSID;
> +       *rmid =3D idx;
> +}
> +
> +void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 r=
mid)
> +{
> +       u32 srmcfg =3D FIELD_PREP(SRMCFG_RCID_MASK, closid) |
> +                    FIELD_PREP(SRMCFG_MCID_MASK, rmid);
> +
> +       WRITE_ONCE(per_cpu(cpu_srmcfg_default, cpu), srmcfg);
> +}
> +
> +void resctrl_arch_sched_in(struct task_struct *tsk)
> +{
> +       __switch_to_srmcfg(tsk);
> +}
> +
> +void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u=
32 rmid)
> +{
> +       u32 srmcfg =3D FIELD_PREP(SRMCFG_RCID_MASK, closid) |
> +                    FIELD_PREP(SRMCFG_MCID_MASK, rmid);
> +
> +       WRITE_ONCE(tsk->thread.srmcfg, srmcfg);
> +}
> +
> +void resctrl_arch_sync_cpu_closid_rmid(void *info)
> +{
> +       struct resctrl_cpu_defaults *r =3D info;
> +
> +       lockdep_assert_preemption_disabled();
> +
> +       if (r) {
> +               resctrl_arch_set_cpu_default_closid_rmid(smp_processor_id=
(),
> +                                                        r->closid, r->rm=
id);
> +       }
> +
> +       resctrl_arch_sched_in(current);
> +}
> +
> +bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
> +{
> +       return FIELD_GET(SRMCFG_RCID_MASK, READ_ONCE(tsk->thread.srmcfg))=
 =3D=3D closid;
> +}
> +
> +bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rm=
id)
> +{
> +       return FIELD_GET(SRMCFG_MCID_MASK, READ_ONCE(tsk->thread.srmcfg))=
 =3D=3D rmid;
> +}
> +
> +void resctrl_arch_pre_mount(void)
> +{
> +       /* All controllers discovered at boot via late_initcall. Nothing =
to do. */
> +}
> +
> +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_doma=
in *d,
> +                           u32 closid, enum resctrl_conf_type t, u32 cfg=
_val)
> +{
> +       struct cbqri_resctrl_dom *dom;
> +
> +       dom =3D container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_do=
m);
> +
> +       if (!r->alloc_capable)
> +               return -EINVAL;
> +
> +       switch (r->rid) {
> +       case RDT_RESOURCE_L2:
> +       case RDT_RESOURCE_L3:
> +               return cbqri_apply_cache_config_dom(dom, r, closid, t, cf=
g_val);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
> +{
> +       struct resctrl_staged_config *cfg;
> +       enum resctrl_conf_type t;
> +       struct rdt_ctrl_domain *d;
> +       int err =3D 0;
> +
> +       /* Walking r->ctrl_domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
> +       list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> +               for (t =3D 0; t < CDP_NUM_TYPES; t++) {
> +                       cfg =3D &d->staged_config[t];
> +                       if (!cfg->have_new_ctrl)
> +                               continue;
> +                       err =3D resctrl_arch_update_one(r, d, closid, t, =
cfg->new_ctrl);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +       return err;
> +}
> +
> +u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_doma=
in *d,
> +                           u32 closid, enum resctrl_conf_type type)
> +{
> +       struct cbqri_resctrl_dom *hw_dom;
> +       struct cbqri_controller *ctrl;
> +       u32 at;
> +       u32 val;
> +       int err;
> +
> +       hw_dom =3D container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl=
_dom);
> +       ctrl =3D hw_dom->hw_ctrl;
> +       val =3D resctrl_get_default_ctrl(r);
> +
> +       if (!r->alloc_capable)
> +               return val;
> +
> +       switch (r->rid) {
> +       case RDT_RESOURCE_L2:
> +       case RDT_RESOURCE_L3:
> +               at =3D (type =3D=3D CDP_CODE) ? CBQRI_CONTROL_REGISTERS_A=
T_CODE :
> +                                         CBQRI_CONTROL_REGISTERS_AT_DATA=
;
> +               err =3D cbqri_read_cache_config(ctrl, closid, at, &val);
> +               if (err < 0)
> +                       val =3D resctrl_get_default_ctrl(r);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return val;
> +}
> +
> +void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
> +{
> +       struct cbqri_resctrl_res *hw_res;
> +       struct rdt_ctrl_domain *d;
> +       enum resctrl_conf_type t;
> +       u32 default_ctrl;
> +       int i;
> +
> +       lockdep_assert_cpus_held();
> +
> +       hw_res =3D container_of(r, struct cbqri_resctrl_res, resctrl_res)=
;
> +       default_ctrl =3D resctrl_get_default_ctrl(r);
> +
> +       if (!hw_res->ctrl)
> +               return;
> +
> +       list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> +               for (i =3D 0; i < hw_res->ctrl->rcid_count; i++) {
> +                       for (t =3D 0; t < CDP_NUM_TYPES; t++) {
> +                               int rerr;
> +
> +                               rerr =3D resctrl_arch_update_one(r, d, i,=
 t, default_ctrl);
> +                               if (rerr)
> +                                       pr_err_ratelimited("rid=3D%d rese=
t RCID %u type %u failed (%d)\n",
> +                                                          r->rid, i, t, =
rerr);
> +                       }
> +               }
> +       }
> +}
> +
> +static struct rdt_ctrl_domain *cbqri_new_domain(struct cbqri_controller =
*ctrl)
> +{
> +       struct cbqri_resctrl_dom *hw_dom;
> +       struct rdt_ctrl_domain *domain;
> +
> +       hw_dom =3D kzalloc_obj(*hw_dom, GFP_KERNEL);
> +       if (!hw_dom)
> +               return NULL;
> +
> +       hw_dom->hw_ctrl =3D ctrl;
> +       domain =3D &hw_dom->resctrl_ctrl_dom;
> +
> +       INIT_LIST_HEAD(&domain->hdr.list);
> +
> +       return domain;
> +}
> +
> +static int cbqri_init_domain_ctrlval(struct rdt_resource *r, struct rdt_=
ctrl_domain *d)
> +{
> +       struct cbqri_resctrl_dom *hw_dom;
> +       enum resctrl_conf_type t;
> +       int err =3D 0;
> +       int i;
> +
> +       hw_dom =3D container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl=
_dom);
> +
> +       for (i =3D 0; i < hw_dom->hw_ctrl->rcid_count; i++) {
> +               /*
> +                * Seed both DATA and CODE staged slots so a later mount
> +                * with -o cdp does not see stale CODE values.
> +                * On non-AT controllers cbqri_cc_alloc_op() masks AT to =
0
> +                * so all three iterations land on the same hardware stat=
e.
> +                * The redundant writes are harmless.
> +                */
> +               for (t =3D 0; t < CDP_NUM_TYPES; t++) {
> +                       err =3D resctrl_arch_update_one(r, d, i, t,
> +                                                     resctrl_get_default=
_ctrl(r));
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +       return 0;
> +}
> +
> +/*
> + * Two capacity controllers at the same cache level are interchangeable =
to
> + * resctrl only if they expose identical caps, since resctrl publishes o=
ne
> + * set of caps per rid but any of the level's controllers may service a
> + * given RCID.
> + */
> +static bool cbqri_cc_caps_agree(const struct cbqri_controller *a,
> +                               const struct cbqri_controller *b)
> +{
> +       return a->rcid_count =3D=3D b->rcid_count &&
> +              a->cc.ncblks =3D=3D b->cc.ncblks &&
> +              a->cc.supports_alloc_at_code =3D=3D b->cc.supports_alloc_a=
t_code &&
> +              a->alloc_capable =3D=3D b->alloc_capable;
> +}
> +
> +/*
> + * Walk cbqri_controllers and pick one capacity controller (CC) per cach=
e
> + * level (L2/L3) to back the corresponding RDT_RESOURCE_L*. When more th=
an
> + * one CC sits at the same level (e.g. one per socket), they must agree =
on
> + * rcid_count / ncblks / supports_alloc_at_code / alloc_capable. A level
> + * whose controllers disagree is dropped, since resctrl exposes a single
> + * set of caps per rid, but the other level is still picked. The first
> + * matching controller wins.
> + */
> +static void cbqri_resctrl_pick_caches(void)
> +{
> +       struct cbqri_controller *ctrl, *pick;
> +       int rid;
> +
> +       guard(mutex)(&cbqri_controllers_lock);
> +
> +       for (rid =3D 0; rid < RDT_NUM_RESOURCES; rid++) {
> +               pick =3D NULL;
> +
> +               list_for_each_entry(ctrl, &cbqri_controllers, list) {
> +                       if (ctrl->type !=3D CBQRI_CONTROLLER_TYPE_CAPACIT=
Y ||
> +                           !ctrl->alloc_capable ||
> +                           cbqri_cache_level_to_rid(ctrl->cache.cache_le=
vel) !=3D rid)
> +                               continue;
> +
> +                       if (!pick) {
> +                               pick =3D ctrl;
> +                       } else if (!cbqri_cc_caps_agree(pick, ctrl)) {
> +                               pr_err("L%u controllers have mismatched c=
apabilities, skipping this level\n",
> +                                      ctrl->cache.cache_level);
> +                               pick =3D NULL;
> +                               break;
> +                       }
> +               }
> +
> +               cbqri_resctrl_resources[rid].ctrl =3D pick;
> +       }
> +}
> +
> +/*
> + * Fill the rdt_resource fields for one picked rid. An rid with no picke=
d
> + * controller is left untouched so it stays out of resctrl_arch_get_reso=
urce().
> + */
> +static void cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_r=
es)
> +{
> +       struct cbqri_controller *ctrl =3D cbqri_res->ctrl;
> +       struct rdt_resource *res =3D &cbqri_res->resctrl_res;
> +
> +       if (!ctrl)
> +               return;
> +
> +       switch (res->rid) {
> +       case RDT_RESOURCE_L2:
> +       case RDT_RESOURCE_L3:
> +               res->name =3D (res->rid =3D=3D RDT_RESOURCE_L2) ? "L2" : =
"L3";
> +               res->schema_fmt =3D RESCTRL_SCHEMA_BITMAP;
> +               res->ctrl_scope =3D (res->rid =3D=3D RDT_RESOURCE_L2) ?
> +                                   RESCTRL_L2_CACHE : RESCTRL_L3_CACHE;
> +               res->cache.cbm_len =3D ctrl->cc.ncblks;
> +               res->cache.shareable_bits =3D 0;
> +               res->cache.min_cbm_bits =3D 1;
> +               res->cache.arch_has_sparse_bitmasks =3D false;
> +               res->cdp_capable =3D ctrl->cc.supports_alloc_at_code;
> +               res->alloc_capable =3D ctrl->alloc_capable;
> +               INIT_LIST_HEAD(&res->ctrl_domains);
> +               INIT_LIST_HEAD(&res->mon_domains);
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +static void cbqri_resctrl_accumulate_caps(void)
> +{
> +       int rid;
> +
> +       for (rid =3D 0; rid < RDT_NUM_RESOURCES; rid++) {
> +               struct cbqri_resctrl_res *hw_res =3D &cbqri_resctrl_resou=
rces[rid];
> +
> +               if (!hw_res->ctrl)
> +                       continue;
> +               if (hw_res->ctrl->alloc_capable)
> +                       exposed_alloc_capable =3D true;
> +       }
> +}
> +
> +/*
> + * Create, list-insert, and online a fresh ctrl_domain backing ctrl on
> + * resource res, seeded with cpu and identified by dom_id. Caller must
> + * hold cbqri_domain_list_lock and must have already verified that no
> + * existing ctrl_domain on res carries this id.
> + */
> +static struct rdt_ctrl_domain *cbqri_create_ctrl_domain(struct cbqri_con=
troller *ctrl,
> +                                                       struct rdt_resour=
ce *res,
> +                                                       unsigned int cpu,=
 int dom_id)
> +{
> +       struct rdt_ctrl_domain *domain;
> +       struct list_head *pos =3D NULL;
> +       int err;
> +
> +       domain =3D cbqri_new_domain(ctrl);
> +       if (!domain)
> +               return ERR_PTR(-ENOMEM);
> +
> +       cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
> +       domain->hdr.id =3D dom_id;
> +       domain->hdr.type =3D RESCTRL_CTRL_DOMAIN;
> +       domain->hdr.rid =3D res->rid;
> +
> +       err =3D cbqri_init_domain_ctrlval(res, domain);
> +       if (err)
> +               goto free;
> +
> +       err =3D resctrl_online_ctrl_domain(res, domain);
> +       if (err)
> +               goto free;
> +
> +       /*
> +        * Publish only after the domain is fully initialized and online,=
 so a
> +        * reader walking the RCU list never sees a half-built domain.
> +        */
> +       resctrl_find_domain(&res->ctrl_domains, dom_id, &pos);
> +       list_add_tail_rcu(&domain->hdr.list, pos);
> +
> +       return domain;
> +free:
> +       kfree(container_of(domain, struct cbqri_resctrl_dom, resctrl_ctrl=
_dom));
> +       return ERR_PTR(err);
> +}
> +
> +/*
> + * Remove a CPU from the domain at each level whose cache it shares. The
> + * domain is looked up by the CPU's own cache id and the lookup returns =
NULL
> + * if it is already gone, so this is idempotent and undoes a partial onl=
ine
> + * attach as well as a full offline. Caller holds cbqri_domain_list_lock=
.
> + */
> +static void cbqri_detach_cpu_from_all_ctrls(unsigned int cpu)
> +{
> +       static const u32 levels[] =3D { 2, 3 };
> +       struct cbqri_resctrl_res *hw_res;
> +       struct rdt_ctrl_domain *d;
> +       struct rdt_resource *res;
> +       struct cacheinfo *ci;
> +       int i, rid;
> +
> +       lockdep_assert_held(&cbqri_domain_list_lock);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(levels); i++) {
> +               ci =3D get_cpu_cacheinfo_level(cpu, levels[i]);
> +               if (!ci)
> +                       continue;
> +
> +               rid =3D cbqri_cache_level_to_rid(levels[i]);
> +               hw_res =3D &cbqri_resctrl_resources[rid];
> +               if (!hw_res->ctrl)
> +                       continue;
> +
> +               res =3D &hw_res->resctrl_res;
> +               d =3D cbqri_find_ctrl_domain(&res->ctrl_domains, ci->id);
> +               if (!d)
> +                       continue;
> +
> +               cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
> +               if (cpumask_empty(&d->hdr.cpu_mask)) {
> +                       list_del_rcu(&d->hdr.list);
> +                       synchronize_rcu();
> +                       resctrl_offline_ctrl_domain(res, d);
> +                       kfree(container_of(d, struct cbqri_resctrl_dom,
> +                                          resctrl_ctrl_dom));
> +               }
> +       }
> +}
> +
> +/*
> + * Attach a CPU to the capacity controller at each cache level whose cac=
he
> + * the CPU shares. On failure, detach the CPU from everything attached s=
o
> + * far: the cpuhp core does not run this state's offline teardown when i=
ts
> + * startup fails, so a partial attach would otherwise leak into the doma=
in
> + * cpu_masks. Caller holds cbqri_domain_list_lock.
> + */
> +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> +{
> +       static const u32 levels[] =3D { 2, 3 };
> +       struct cbqri_controller *ctrl, *c;
> +       struct cbqri_resctrl_res *hw_res;
> +       struct rdt_ctrl_domain *d;
> +       struct cacheinfo *ci;
> +       int i, rid;
> +
> +       lockdep_assert_held(&cbqri_domain_list_lock);
> +
> +       /*
> +        * Hold cbqri_controllers_lock across the walk so a controller
> +        * registered after boot cannot corrupt it. The register path tak=
es
> +        * it as a leaf and never cbqri_domain_list_lock, so this nesting
> +        * cannot invert.
> +        */
> +       guard(mutex)(&cbqri_controllers_lock);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(levels); i++) {
> +               ci =3D get_cpu_cacheinfo_level(cpu, levels[i]);
> +               if (!ci)
> +                       continue;
> +
> +               rid =3D cbqri_cache_level_to_rid(levels[i]);
> +               hw_res =3D &cbqri_resctrl_resources[rid];
> +               if (!hw_res->ctrl)
> +                       continue;
> +
> +               /* The controller backing this CPU's cache at this level.=
 */
> +               ctrl =3D NULL;
> +               list_for_each_entry(c, &cbqri_controllers, list) {
> +                       if (c->type =3D=3D CBQRI_CONTROLLER_TYPE_CAPACITY=
 &&
> +                           c->alloc_capable &&
> +                           c->cache.cache_level =3D=3D levels[i] &&
> +                           c->cache.cache_id =3D=3D ci->id) {
> +                               ctrl =3D c;
> +                               break;
> +                       }
> +               }
> +               if (!ctrl)
> +                       continue;
> +
> +               d =3D cbqri_find_ctrl_domain(&hw_res->resctrl_res.ctrl_do=
mains,
> +                                          ci->id);
> +               if (d) {
> +                       cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +                       continue;
> +               }
> +
> +               d =3D cbqri_create_ctrl_domain(ctrl, &hw_res->resctrl_res=
, cpu,
> +                                            ci->id);
> +               if (IS_ERR(d)) {
> +                       cbqri_detach_cpu_from_all_ctrls(cpu);
> +                       return PTR_ERR(d);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static bool cbqri_resctrl_inited;
> +
> +static void cbqri_resctrl_teardown(void)
> +{
> +       int rid;
> +
> +       if (!cbqri_resctrl_inited)
> +               return;
> +
> +       resctrl_exit();
> +
> +       for (rid =3D 0; rid < RDT_NUM_RESOURCES; rid++) {
> +               struct cbqri_resctrl_res *hw_res =3D &cbqri_resctrl_resou=
rces[rid];
> +
> +               hw_res->ctrl =3D NULL;
> +               hw_res->cdp_enabled =3D false;
> +       }
> +       exposed_alloc_capable =3D false;
> +       cbqri_resctrl_inited =3D false;
> +}
> +
> +static int cbqri_resctrl_setup(void)
> +{
> +       int rid;
> +       int err;
> +
> +       for (rid =3D 0; rid < RDT_NUM_RESOURCES; rid++)
> +               cbqri_resctrl_resources[rid].resctrl_res.rid =3D rid;
> +
> +       cbqri_resctrl_pick_caches();
> +
> +       for (rid =3D 0; rid < RDT_NUM_RESOURCES; rid++)
> +               cbqri_resctrl_control_init(&cbqri_resctrl_resources[rid])=
;
> +
> +       cbqri_resctrl_accumulate_caps();
> +
> +       if (!exposed_alloc_capable) {
> +               pr_debug("no resctrl-capable CBQRI controllers found\n");
> +               return -ENODEV;
> +       }
> +
> +       err =3D resctrl_init();
> +       if (err)
> +               return err;
> +
> +       cbqri_resctrl_inited =3D true;
> +       return 0;
> +}
> +
> +static int cbqri_resctrl_online_cpu(unsigned int cpu)
> +{
> +       int err;
> +
> +       mutex_lock(&cbqri_domain_list_lock);
> +       err =3D cbqri_attach_cpu_to_all_ctrls(cpu);
> +       mutex_unlock(&cbqri_domain_list_lock);
> +       if (err)
> +               return err;
> +
> +       /*
> +        * Seed the per-CPU default RCID/MCID to the reserved (0, 0) pair=
 and
> +        * notify the resctrl core so it tracks this CPU in the default g=
roup.
> +        */
> +       resctrl_arch_set_cpu_default_closid_rmid(cpu, 0, 0);
> +       resctrl_online_cpu(cpu);
> +       return 0;
> +}
> +
> +static int cbqri_resctrl_offline_cpu(unsigned int cpu)
> +{
> +       resctrl_offline_cpu(cpu);
> +
> +       mutex_lock(&cbqri_domain_list_lock);
> +       cbqri_detach_cpu_from_all_ctrls(cpu);
> +       mutex_unlock(&cbqri_domain_list_lock);
> +       return 0;
> +}
> +
> +static int __init cbqri_arch_late_init(void)
> +{
> +       int err;
> +
> +       if (!riscv_isa_extension_available(NULL, SSQOSID))
> +               return -ENODEV;
> +
> +       err =3D cbqri_resctrl_setup();
> +       if (err)
> +               return err;
> +
> +       err =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "cbqri:online",
> +                               cbqri_resctrl_online_cpu,
> +                               cbqri_resctrl_offline_cpu);
> +       if (err < 0) {
> +               cbqri_resctrl_teardown();
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +late_initcall(cbqri_arch_late_init);
>
> --
> 2.43.0
>
