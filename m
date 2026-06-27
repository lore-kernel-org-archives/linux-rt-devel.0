Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412E393DDC
	for <linux-rt-devel@lists.linux.dev>; Sat, 27 Jun 2026 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782551489; cv=pass; b=bYRBhDO4AwqVViVM7ksXwSI7I2AmhLhFYuxf2N2X0yN3vAhoVRc/ImUuAvVeNtoZdmv64wDMEoNuOD1OYshxfBOZXyL/XScDHJaGen3kq186G0tOhT2fwq3Z34OLR0sKa5ECi/v8jLW67HLTfE+m98AM6BAfpnv5rOIe0A7Ccm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782551489; c=relaxed/simple;
	bh=/v/gJjPtMm0e2IagPA8H5XT5YJJGLKr73EPclNUgP8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhjSxJPjHTQ0lAcMRzwSgoPCNdkUVN7f9nzkvFIpc4uUqHFunOeIN7KZFcCWY9Ybfq2PombIG3jh5YB4r9XNGRw/zY8SmWUuvVbXa6lDOChXFv40tznIav9nKYl2AfnuDRG/wy5lmQaD1zc/NOCn/PAQ7hlWLmnUT6YPwXClQXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dnq4WMWv; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dnq4WMWv"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9784666b3so1350290a34.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 27 Jun 2026 02:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782551482; cv=none;
        d=google.com; s=arc-20260327;
        b=mEi2J0rq7gZlQs/08bPRQ/Qxg77afShJdA0xs9d37cWT4AEWqedUevGp5AK3g2y187
         ry7PEb64XOyjGwac68KZ09+/s5DRP3ezLK/UB4av5bMUiFRjOVN10/Ijl4SfsX3krrxM
         5uXpIabpO4Gt4D6AIakJJUQveNmUnvOA6ekgHR/b9BBqQ3UanlRSdQJ9IrXYTL7x2Mfa
         LmQUSxa4gIs0khuFnDczP3gLhkV9mHLiIql4tcdttOIr9kPUs7NqcW4Dje97olzrBPh8
         O25fL8evO5UHqtWvm5c7l88bjUWbs+WkfeZ2Wg9du2vy/veuvpoYob6o08tmd0Imr5za
         s2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMOolnkZVsJSvXlAMqMgikUARqwid3QhvocvyMvOFYQ=;
        fh=P6Uc4WiNaCLZHdNnfDn+PLiXhtXFEo9apE+bJOo3XAc=;
        b=tBptpUIPuwUwDk51jtt0r0IMYxDaiITdX/PCc5bxQF088fQGjTLMRJkFEwDQCFDt76
         04/Tv/YbPFvN9FdOrGY1/yFCQDOjvw8i5O4ohwBHKWGc1jyCbKp023eqSdoF8NylPGvt
         RSB57qyCUlNiLvYuO9Z0ZB8xQzMh2IxJ0wmB2a7gd8/t+AfdFfMHTlguauHG0gOQZ+tc
         BtZXOaNhv5UU6nVs4jOlKwO/w7BEog9ikHiDYTQ4k2SMBcjQf1rl47g1FjSg6lj7WK/E
         ZRbB9Q+NtPWYKOGDMdkVxDkocUlMMYBG3djw1JyP29TPsS4WXmy5Yv1yETJLC1a/JuVK
         ye7g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782551482; x=1783156282; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMOolnkZVsJSvXlAMqMgikUARqwid3QhvocvyMvOFYQ=;
        b=Dnq4WMWv1K5TWlDSnUP1W5R+uVvaeFE0xOVR73O9CB0hR/g/JrzgzOpB0oA0EScY46
         z2+ASQPjIsxQST1TYvXiVXG4kXkbAwHZ/WCOPymY76SKlMsZ2Qs0ZbsSAXrVbasyUB55
         jCumQxX0smFI2qzPevOcQ0an/IooXe0E1z+iROQvIko9BK2D84iKAj7QCNPt6xC0Eh+F
         Vuip8Panf1riBycJ6NASXb5JGHEQYRy4/UR+iriR0rbbh7isjxCnKdnyWImJROcOBqSt
         Hng52kGQ8MuIcCuze+05hWr3EMd5zxpIKprJNvwdpz0L2W0e7IGbV339Lp274JzMM+c7
         odvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782551482; x=1783156282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMOolnkZVsJSvXlAMqMgikUARqwid3QhvocvyMvOFYQ=;
        b=juypGTPjmWB33twYgwdtTdPL2vi7QZDBcQQpNREhXDf9rycWUYDJbfUrWXH7dgYozP
         ZCyw+3XfHvJd2VyOgCct4YitQX+VCJYV0Lk4hvP4jHd+d/Rk/MjCJFB31Kfysji8zt4c
         KG/g6dlzFO0j8O+mm5yCgM0GPanve4nNODZDm1KiVpsEcvrlwLur3K90u78KbWLqisrk
         935V+ZcYDHNvUxenn3XIShOrY5FH32lnMmFLR41HWaWJtLMeHh37VoDUZRITHa9+BR6Z
         fjCFb0MLHvkSwQnzYN/JKXKmiJlCDzozC6kQK/hCPOTd4jYimzcbg02sAO1CrIm9YEZN
         WWZw==
X-Forwarded-Encrypted: i=1; AFNElJ/o7O99KMwKL8Yl9uVyBQ/lgdh2VAbq4NUOXrP89HFswljbzEHhn0u/rlAnb+nBagKSun+qxXtTWJG/jArIuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqoYEOqaZoL3tEDgc/Pa9WN9FP87f0mvGmigaqRl/I5s4wxQ2Q
	iM2xK+beV7ijjpHG81QF7hTuEqPU9pwINyUh1hApaf31hJGcpvqbJjxapVXZqH+RJyMGtKkfN84
	pwuz2XrkieuAxbmRA5xCvc0smL9ONp33FXfOWGTNUvQ==
X-Gm-Gg: AfdE7ckAfDb6BH7Qejy+CrxC64b+AR1qc+XatwDg4lQNw7sLqZZKqfa0rULr2EUSUx1
	kROUj2uAl5S63WrRof1DI5rGJXCY8iPchxGcxHDbpSYTcITwb3gZFyy7gvBJocHMfy/jLy1Xksc
	SndCcQzZizhyewB/oMbo1ONqe7KuWILOJV1fwpGMBxfNWwQ52/YOv0f0TXcmnbWfs0bOwKhCQT3
	/G7n8/4IXvnI5zuzXf1V2YrSyBdqdeNISv1vwWCjY0j8nuA+h68O8NpyTsV8yEXvFMVZgWJ3QI=
X-Received: by 2002:a05:6830:6814:b0:7e7:1ad:3bcc with SMTP id
 46e09a7af769-7e9b4f754dfmr2910495a34.16.1782551482314; Sat, 27 Jun 2026
 02:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org> <20260624-dfustini-atl-sc-cbqri-dt-v2-3-2f8049fd902b@kernel.org>
In-Reply-To: <20260624-dfustini-atl-sc-cbqri-dt-v2-3-2f8049fd902b@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sat, 27 Jun 2026 17:11:11 +0800
X-Gm-Features: AVVi8Cf0wQkeECheRzPE2LryKr2qX-gbNxpXTpE2bhPVWZc_QCW7orqIGt1cGRM
Message-ID: <CAEEQ3w=ZLnW-Wz_=PcUQTN8q0wxUq1_epCs0B+v=sSug+OHD=Q@mail.gmail.com>
Subject: Re: [External] [PATCH v2 3/8] riscv: Add support for srmcfg CSR from
 Ssqosid extension
To: Drew Fustini <fustini@kernel.org>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Kumar Patra <atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, 
	Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
	Chen Pei <cp0613@linux.alibaba.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Conor Dooley <conor+dt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn, 
	James Morse <james.morse@arm.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn, 
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Peter Newman <peternewman@google.com>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rob Herring <robh@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Luck <tony.luck@intel.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, 
	devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Thu, Jun 25, 2026 at 9:40=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add support for the srmcfg CSR defined in the Ssqosid ISA extension.
> The CSR contains two fields:
>
>   - Resource Control ID (RCID) for resource allocation
>   - Monitoring Counter ID (MCID) for tracking resource usage
>
> Requests from a hart to shared resources are tagged with these IDs,
> allowing resource usage to be associated with the running task.
>
> Add a srmcfg field to thread_struct with the same format as the CSR so
> the scheduler can set the RCID and MCID for each task on context
> switch. A per-cpu cpu_srmcfg variable mirrors the CSR state to avoid
> redundant writes. L1D-hot memory access is faster than a CSR read and
> avoids traps under virtualization.
>
> A per-cpu cpu_srmcfg_default holds the default srmcfg for each CPU as
> set by resctrl CPU group assignment. On context switch, RCID and MCID
> inherit from the CPU default independently: a task whose thread RCID
> field is zero takes the CPU default's RCID, and likewise for MCID.
>
> Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> Assisted-by: Claude:claude-opus-4-7
> Co-developed-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> Signed-off-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                        |  8 ++++
>  arch/riscv/Kconfig                 | 18 +++++++
>  arch/riscv/include/asm/csr.h       |  5 ++
>  arch/riscv/include/asm/processor.h |  3 ++
>  arch/riscv/include/asm/qos.h       | 83 ++++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/switch_to.h |  3 ++
>  arch/riscv/kernel/Makefile         |  2 +
>  arch/riscv/kernel/qos.c            | 98 ++++++++++++++++++++++++++++++++=
++++++
>  8 files changed, 220 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0b9d7c8276acbafdb28a0ea5e81aa853ebee50b9..07109e1a8f8470377916c9807=
4ab68fec51dfdc6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23293,6 +23293,14 @@ F:     drivers/perf/riscv_pmu.c
>  F:     drivers/perf/riscv_pmu_legacy.c
>  F:     drivers/perf/riscv_pmu_sbi.c
>
> +RISC-V QOS RESCTRL SUPPORT
> +M:     Drew Fustini <fustini@kernel.org>
> +R:     yunhui cui <cuiyunhui@bytedance.com>
> +L:     linux-riscv@lists.infradead.org
> +S:     Supported
> +F:     arch/riscv/include/asm/qos.h
> +F:     arch/riscv/kernel/qos.c
> +
>  RISC-V RPMI AND MPXY DRIVERS
>  M:     Rahul Pathak <rahul@summations.net>
>  M:     Anup Patel <anup@brainfault.org>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 3f0a647218e407f72890e83722ba8472858c1a59..ee586925f97227668c228b548=
1c05a2f914d928c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -590,6 +590,24 @@ config RISCV_ISA_SVNAPOT
>
>           If you don't know what to do here, say Y.
>
> +config RISCV_ISA_SSQOSID
> +       bool "Ssqosid extension support for supervisor mode Quality of Se=
rvice ID"
> +       depends on 64BIT
> +       default n
> +       help
> +         Adds support for the Ssqosid ISA extension (Supervisor-mode
> +         Quality of Service ID).
> +
> +         Ssqosid defines the srmcfg CSR which allows the system to tag t=
he
> +         running process with an RCID (Resource Control ID) and MCID
> +         (Monitoring Counter ID). The RCID is used to determine resource
> +         allocation. The MCID is used to track resource usage in event
> +         counters.
> +
> +         For example, a cache controller may use the RCID to apply a
> +         cache partitioning scheme and use the MCID to track how much
> +         cache a process, or a group of processes, is using.
> +
>  config RISCV_ISA_SVPBMT
>         bool "Svpbmt extension support for supervisor mode page-based mem=
ory types"
>         depends on 64BIT && MMU
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 31b8988f4488daa89b854ccc97c4efe1c82bcc3e..7bce928e5daa09bd62f091727=
9b04cfad30f46f5 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -84,6 +84,10 @@
>  #define SATP_ASID_MASK _AC(0xFFFF, UL)
>  #endif
>
> +/* SRMCFG fields */
> +#define SRMCFG_RCID_MASK       GENMASK(11, 0)
> +#define SRMCFG_MCID_MASK       GENMASK(27, 16)
> +
>  /* Exception cause high bit - is an interrupt if set */
>  #define CAUSE_IRQ_FLAG         (_AC(1, UL) << (__riscv_xlen - 1))
>
> @@ -328,6 +332,7 @@
>  #define CSR_STVAL              0x143
>  #define CSR_SIP                        0x144
>  #define CSR_SATP               0x180
> +#define CSR_SRMCFG             0x181
>
>  #define CSR_STIMECMP           0x14D
>  #define CSR_STIMECMPH          0x15D
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index 812517b2cec1350f741849c1c56a35027321ef50..49a386d74cd3f0603a3ff9190=
59d077a7e4d513c 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -123,6 +123,9 @@ struct thread_struct {
>         /* A forced icache flush is not needed if migrating to the previo=
us cpu. */
>         unsigned int prev_cpu;
>  #endif
> +#ifdef CONFIG_RISCV_ISA_SSQOSID
> +       u32 srmcfg;
> +#endif
>  };
>
>  /* Whitelist the fstate from the task_struct for hardened usercopy */
> diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..e9e1d69f3797be5f89785a9b3=
aa7d9d51c476a8a
> --- /dev/null
> +++ b/arch/riscv/include/asm/qos.h
> @@ -0,0 +1,83 @@
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
> +#include <asm/fence.h>
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
> +       u32 thread_srmcfg, default_srmcfg;
> +
> +       thread_srmcfg =3D READ_ONCE(next->thread.srmcfg);
> +       default_srmcfg =3D __this_cpu_read(cpu_srmcfg_default);
> +
> +       /*
> +        * RCID and MCID inherit from cpu_srmcfg_default independently.
> +        * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are both 0, =
so a
> +        * zero field means "unassigned" and takes the CPU default.
> +        */
> +       if (thread_srmcfg =3D=3D 0) {
> +               thread_srmcfg =3D default_srmcfg;
> +       } else {
> +               u32 rcid =3D FIELD_GET(SRMCFG_RCID_MASK, thread_srmcfg);
> +               u32 mcid =3D FIELD_GET(SRMCFG_MCID_MASK, thread_srmcfg);
> +
> +               if (rcid =3D=3D 0 || mcid =3D=3D 0) {
> +                       if (rcid =3D=3D 0)
> +                               rcid =3D FIELD_GET(SRMCFG_RCID_MASK, defa=
ult_srmcfg);
> +                       if (mcid =3D=3D 0)
> +                               mcid =3D FIELD_GET(SRMCFG_MCID_MASK, defa=
ult_srmcfg);
> +                       thread_srmcfg =3D FIELD_PREP(SRMCFG_RCID_MASK, rc=
id) |
> +                                       FIELD_PREP(SRMCFG_MCID_MASK, mcid=
);
> +               }
> +       }
> +
> +       if (thread_srmcfg !=3D __this_cpu_read(cpu_srmcfg)) {
> +               /*
> +                * Drain stores from the outgoing task before the CSR wri=
te
> +                * so they retain the previous RCID/MCID tag at the cache
> +                * interconnect.
> +                */
> +               RISCV_FENCE(rw, o);
> +
> +               __this_cpu_write(cpu_srmcfg, thread_srmcfg);
> +               csr_write(CSR_SRMCFG, thread_srmcfg);
> +               /*
> +                * Order the csrw before the new task's loads/stores so t=
hey
> +                * pick up the new tag. Zicsr 6.1.1 makes CSR writes weak=
ly
> +                * ordered (device-output) vs memory ops. Ssqosid v1.0 is
> +                * silent so honor the general CSR rule.
> +                */
> +               RISCV_FENCE(o, rw);

This is in the context-switch path and may be expensive in practice. Even i=
f
the target workload is pinned and grouped, unpinned/default-group tasks or
kworkers may still run on those CPUs, causing frequent SRMCFG transitions a=
nd
paying two fences each time.

Is this strict ordering required by the Ssqosid spec or known hardware? If
not, can we make this a trade-off and avoid the fences by default, acceptin=
g a
small QoS-tagging inaccuracy around the context-switch boundary?


> +       }
> +}
> +
> +static __always_inline bool has_srmcfg(void)
> +{
> +       return riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID);
> +}
> +
> +#else /* ! CONFIG_RISCV_ISA_SSQOSID  */
> +
> +struct task_struct;
> +static __always_inline bool has_srmcfg(void) { return false; }
> +static inline void __switch_to_srmcfg(struct task_struct *next) { }
> +
> +#endif /* CONFIG_RISCV_ISA_SSQOSID */
> +#endif /* _ASM_RISCV_QOS_H */
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 0e71eb82f920cac2f14bb626879bb219a2f247cc..1c7ea53ec012adeaf03bf7c5d=
549ab21849768b5 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -14,6 +14,7 @@
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
> +#include <asm/qos.h>
>
>  #ifdef CONFIG_FPU
>  extern void __fstate_save(struct task_struct *save_to);
> @@ -119,6 +120,8 @@ do {                                                 =
       \
>                 __switch_to_fpu(__prev, __next);        \
>         if (has_vector() || has_xtheadvector())         \
>                 __switch_to_vector(__prev, __next);     \
> +       if (has_srmcfg())                               \
> +               __switch_to_srmcfg(__next);             \
>         if (switch_to_should_flush_icache(__next))      \
>                 local_flush_icache_all();               \
>         __switch_to_envcfg(__next);                     \
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index cabb99cadfb6d1e1284d6b4e9ae76044d36949f5..ebe1c3588177b4b825a52af9c=
a17e17b5561427c 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -128,3 +128,5 @@ obj-$(CONFIG_ACPI_NUMA)     +=3D acpi_numa.o
>
>  obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) +=3D bugs.o
>  obj-$(CONFIG_RISCV_USER_CFI) +=3D usercfi.o
> +
> +obj-$(CONFIG_RISCV_ISA_SSQOSID) +=3D qos.o
> diff --git a/arch/riscv/kernel/qos.c b/arch/riscv/kernel/qos.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ea33201a43f61534bf28b9c02=
b62801f30f62154
> --- /dev/null
> +++ b/arch/riscv/kernel/qos.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/cpu.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/notifier.h>
> +#include <linux/percpu-defs.h>
> +#include <linux/types.h>
> +
> +#include <asm/cpufeature-macros.h>
> +#include <asm/hwcap.h>
> +#include <asm/qos.h>
> +
> +/*
> + * Cached value of srmcfg csr for each cpu. Seeded to U32_MAX so the nex=
t
> + * __switch_to_srmcfg() unconditionally writes the CSR. The encoding
> + * MCID << 16 | RCID with both fields well under 16 bits can never
> + * produce this sentinel. This covers early-boot context switches that
> + * happen before riscv_srmcfg_init() runs as an arch_initcall.
> + */
> +DEFINE_PER_CPU(u32, cpu_srmcfg) =3D U32_MAX;
> +
> +/* default srmcfg value for each cpu, set via resctrl cpu assignment */
> +DEFINE_PER_CPU(u32, cpu_srmcfg_default);
> +
> +/*
> + * Invalidate the per-CPU srmcfg cache, used as both the cpuhp startup a=
nd
> + * teardown callback. The sentinel is a value no real srmcfg encoding ca=
n
> + * produce (MCID << 16 | RCID, both fields well under 16 bits) so the ne=
xt
> + * __switch_to_srmcfg() unconditionally writes the CSR.
> + *
> + * Ssqosid v1.0 leaves CSR state across hart stop/start implementation-
> + * defined, so the cached value cannot be trusted after online. Invalida=
ting
> + * on offline as well means the sentinel persists across the offline per=
iod:
> + * a CPU brought back online finds the cache already invalidated before =
it is
> + * schedulable, closing the window where a task scheduled before the sta=
rtup
> + * callback runs could match a stale cache and skip the CSR write while =
the
> + * hardware CSR was reset across hart stop/start.
> + */
> +static int riscv_srmcfg_reset_cache(unsigned int cpu)
> +{
> +       per_cpu(cpu_srmcfg, cpu) =3D U32_MAX;
> +       return 0;
> +}
> +
> +/*
> + * CPU PM notifier: invalidate the cached srmcfg on resume from a deep
> + * idle / suspend. Ssqosid v1.0 leaves CSR_SRMCFG state across low-power
> + * transitions implementation-defined, and the boot CPU never goes
> + * through the cpuhp online callback during system suspend, so without
> + * this hook __switch_to_srmcfg() would skip the CSR write when the
> + * outgoing task happens to share its srmcfg with the pre-suspend cache.
> + */
> +static int riscv_srmcfg_pm_notify(struct notifier_block *nb,
> +                                 unsigned long action, void *unused)
> +{
> +       switch (action) {
> +       case CPU_PM_EXIT:
> +       case CPU_PM_ENTER_FAILED:
> +               /*
> +                * The CSR is implementation-defined across the low-power
> +                * transition. Invalidate the cache and eagerly rewrite t=
he
> +                * CSR for the current task so it does not run mis-tagged
> +                * until the next context switch.
> +                */
> +               __this_cpu_write(cpu_srmcfg, U32_MAX);
> +               __switch_to_srmcfg(current);
> +               break;
> +       }
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block riscv_srmcfg_pm_nb =3D {
> +       .notifier_call =3D riscv_srmcfg_pm_notify,
> +};
> +
> +static int __init riscv_srmcfg_init(void)
> +{
> +       int err;
> +
> +       if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID))
> +               return 0;
> +
> +       /*
> +        * cpuhp_setup_state() invokes the startup callback locally on ev=
ery
> +        * already-online CPU, so no separate seed loop is needed here.
> +        */
> +       err =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/srmcfg:onli=
ne",
> +                               riscv_srmcfg_reset_cache, riscv_srmcfg_re=
set_cache);
> +       if (err < 0) {
> +               pr_warn("srmcfg cpuhp registration failed (%d), cpus brou=
ght online after boot will not invalidate the CSR_SRMCFG cache\n",
> +                       err);
> +               return err;
> +       }
> +
> +       cpu_pm_register_notifier(&riscv_srmcfg_pm_nb);
> +       return 0;
> +}
> +arch_initcall(riscv_srmcfg_init);
>
> --
> 2.34.1
>

Thanks,
Yunhui
