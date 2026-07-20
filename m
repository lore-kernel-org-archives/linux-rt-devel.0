Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001313D5226
	for <linux-rt-devel@lists.linux.dev>; Mon, 20 Jul 2026 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541413; cv=pass; b=YHC56hEiskpr5sfZaIh+GTCUQAx0egS0oi2X25YpAPxljN+UxGzuQfBruRmC4XMHtH3bQOuNVnEmin+TAcefU6ruUJN3PYiKYyzRsGbmeyqRvAiJlNinAXe7G7i3n2l6etf3GWn6J9rva0XglekoMGGDSkJs88nW18dtpOP3Vc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541413; c=relaxed/simple;
	bh=Rf2CcF1fMAjQQ07JUkzEG3ekSQ2NZ5TvGoZ+ll/pCF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5EZIbRYmNVXOB/HW6ZWYYQBBjlNBD/cmZQv2wIggniSPOnwv73M2RbSXyzBYADkxyJ20P8PVWLJ1PvRAYh06lF6B3Dtu2lvW1vT3JDpa1CqZ4tCUulu6vppjI6JneZahveD9itT2PLgWvojmtHT8d9/4E7CgNdFkf3/DfE1ViM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fgmULjCh; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fgmULjCh"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so3488565fac.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 20 Jul 2026 02:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784541402; cv=none;
        d=google.com; s=arc-20260327;
        b=ohRzRhhpSd3LdKVxlWRjndCNmUUh54Iro4/+XbsWc+GbMMgh1w75cWtb6+Up++IUOF
         2UTG+M2JcfrJwz3/WhC5dTabv3fmmxVAhU9ud1x1ehdxknMgneOW6vVE+Hk0xYcEim/u
         AbFfKhg80I+GVgTP1D4VVrXd0/cBhn1E7sAUFt0/GMVkRzcSnAJZp4GaIGSj3PaUH1Dg
         gqg2MQB1z5396iuuu3ctT1vF+K70/yEHc0eAKhshfDoEaxKiR4aEGQF4+PJ5PiOLLe9y
         CkjZsN/4Bp3q+J0EY66GJiNgb9QUTCxCgdLFJFtakvVa23ziXuHLP/bxPQfikhH85+Je
         cndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/QfTROmE3YHgh/f/zRXTqcomrYygUunYx3Oxz5bmMoA=;
        fh=RtnB3dz3OJZ2JvgZalaBV6s9Jq515bHEOeWrpIpe0gA=;
        b=CA8oByTfqsbHhzG7HWkwseobUTLEqzjcQWwlScoZvdhiQmGa9MBC0utCUWOaEbV1dA
         uMnbTbTUEJQvsLGbIpK9j2QzzlIpOhIyA0RzWgyLWoUaft8wBfthPh1EGgOljAj2t6Da
         P4VKXdoFqPaPiTL1OCW9ulkRtBljRhgYeKjp9JZRlCwUGG8ufY0LiIzLrd0YOst3asFR
         ZueG2g5634NHKN4B+ZIQu52qN5R4Vdg8HZ9nqRIOWQva+ROHSqsCEKiqxxTiKJDdZdpm
         JlxixnQeiyAZ6cC5rDlNEB7JyS0lsEQUrRmD9uAO4hEYFVTnvvfY/i7wxEpfF7wpI95r
         hGHA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784541402; x=1785146202; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/QfTROmE3YHgh/f/zRXTqcomrYygUunYx3Oxz5bmMoA=;
        b=fgmULjCh6scfOwEVdBt0bWwshHvl7clFKqb70D1Soj/+JwGuSmfkykvTJ4jHn/mQK1
         Xv2aMP0XHKQT6IeLDCCon381QxeHVKYLav9YFyevKFtty+2+na7wc98dhOWVbd12xL3Z
         Ji5MecN/r0vDHjdVrkRUbaM/+Dvqy+jF3RNMuKieO+hB5JQRA+2n6a8en6v2dSlFV4QQ
         FON7578tAibxamJ9J86TOc5jRhWp368MtmkVco/luVRJpNiQ4B8Ub7OIPHV2ignb99lJ
         p82047kmhL94f0EroXr3f09w25snvAcqexJgwM/+6dD/kzz49EvApnAXd7MWvnH3T2fk
         lHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784541402; x=1785146202;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/QfTROmE3YHgh/f/zRXTqcomrYygUunYx3Oxz5bmMoA=;
        b=CWoa5z3kYWkE9m1uDmWG0B2fo/O3TVHgLRCbH13qwQYI72Ye445cWpQOBs9D1zKWia
         8Q33nkDQ2/2m4Dw7RUiWEaq5PNqUMR1o2iAIMGgDb0ZBmInHJl3UJPV5GYZ51HGbq3bN
         S+SrlqzwtMJRSu1/pkTN9TlYfLrWKBuQLfiwtifTRla2I226cz4Ksa9u10Px0lvkle4J
         m03bD6SxrfP0y73autAdKT8QvHT098mi4OsnHzHIkAOFb0XE3OgwezMug6KmsBBDOJYp
         j1f9ekfQBhbMeiRUIMonDWBAt25gLmsfepZ4pVGuoi7FPwx2WcjyR8CBMbbd5MJw7QTL
         +B0g==
X-Forwarded-Encrypted: i=1; AHgh+RqWspHhBF0GFefWa5twCIyK5ibumO5XaxtnAsJfIvQxT9AkY4WDqTAhybrA4/ZG/qZaliqy9Ma48EE9QGs0vg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyn3LsyjKWIthGjMZV5MOaN6fhWYKsB/Q70dpvH5lmGQBiDBwti
	MQOBTXcZQrSDhh9dayvg270OWZ09P8KyEhpLHGW7VAxEQnBI8TbS252semNDMQ8c2dxVm7nzb9g
	Ca0IF3mbT9eONTOUQvizBUfU0n4WsAfC6koRcuyA8Hw==
X-Gm-Gg: AfdE7cm0EMeP28yU1YpMlIRlTxIClSp9dgzUgoJ1PR7zUn7kG6cxDe/OR2c1tLKeGJL
	WDUo3mb8bCQMbBsKvBQOPKaUse0UFOWIn0X3+HAxlurfKrY+9bEHlZjqGY9cebj79Bfa7ZQQTKV
	9f4mmq6TtgvzIJb05j6VZcHYpqam25eRNR1QNMYZERMkpUfXjU35gIZPejmYVWvH6zCS7VTkA0A
	exUd0I9ry6GIJC4gzjSDdB3FFpiUBv9s/CmmX+/nuBTKm4PwfFbDyDw5POdGyyM
X-Received: by 2002:a05:687c:408f:b0:456:f395:ab9b with SMTP id
 586e51a60fabf-456f395cb69mr1979470fac.32.1784541401865; Mon, 20 Jul 2026
 02:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260714-dfustini-atl-sc-cbqri-dt-v5-0-b0ae7e9c932e@kernel.org> <20260714-dfustini-atl-sc-cbqri-dt-v5-4-b0ae7e9c932e@kernel.org>
In-Reply-To: <20260714-dfustini-atl-sc-cbqri-dt-v5-4-b0ae7e9c932e@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 20 Jul 2026 17:56:29 +0800
X-Gm-Features: AUfX_myBhFNJsP3T11LGHzTrMgNDl9z_qFK00JOYqBRt3k_qXEBMb8-8FmZd97E
Message-ID: <CAEEQ3w=kVgMnQ8mu=X+d3xYbANT6dNfv7w71BUwmYxP6qcUhgg@mail.gmail.com>
Subject: Re: [External] [PATCH v5 4/8] riscv_cbqri: Add capacity controller
 probe and allocation device ops
To: Drew Fustini <fustini@kernel.org>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Kumar Patra <atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, 
	Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
	Chen Pei <cp0613@linux.alibaba.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Conor Dooley <conor+dt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>, 
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
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, devicetree@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Wed, Jul 15, 2026 at 8:24=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add support for the RISC-V CBQRI capacity controller. A platform driver
> passes a cbqri_controller_info descriptor together with the cache level
> to riscv_cbqri_register_cc_dt(), which probes the controller and adds it
> to the controller list.
>
> Assisted-by: Claude:claude-opus-4-8
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                      |   3 +
>  drivers/resctrl/Kconfig          |  13 +
>  drivers/resctrl/Makefile         |   3 +
>  drivers/resctrl/cbqri_devices.c  | 563 +++++++++++++++++++++++++++++++++=
++++++
>  drivers/resctrl/cbqri_internal.h | 122 +++++++++
>  include/linux/riscv_cbqri.h      |  45 ++++
>  6 files changed, 749 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a0a4b41f02c5..064a6ae2823e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23365,6 +23365,9 @@ L:      linux-riscv@lists.infradead.org
>  S:     Supported
>  F:     arch/riscv/include/asm/qos.h
>  F:     arch/riscv/kernel/qos.c
> +F:     drivers/resctrl/cbqri_devices.c
> +F:     drivers/resctrl/cbqri_internal.h
> +F:     include/linux/riscv_cbqri.h
>
>  RISC-V RPMI AND MPXY DRIVERS
>  M:     Rahul Pathak <rahul@summations.net>
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> index 672abea3b03c..92b9c82cf9f3 100644
> --- a/drivers/resctrl/Kconfig
> +++ b/drivers/resctrl/Kconfig
> @@ -29,3 +29,16 @@ config ARM64_MPAM_RESCTRL_FS
>         default y if ARM64_MPAM_DRIVER && RESCTRL_FS
>         select RESCTRL_RMID_DEPENDS_ON_CLOSID
>         select RESCTRL_ASSIGN_FIXED
> +
> +menuconfig RISCV_CBQRI
> +       bool "RISC-V CBQRI support"
> +       depends on RISCV && RISCV_ISA_SSQOSID
> +       help
> +         Capacity and Bandwidth QoS Register Interface (CBQRI) support f=
or
> +         RISC-V cache QoS resources. CBQRI exposes cache capacity
> +         allocation through the resctrl filesystem at /sys/fs/resctrl wh=
en
> +         RESCTRL_FS is also enabled.
> +
> +if RISCV_CBQRI
> +
> +endif

Should this empty if/endif block go in patch [8/8] instead?

> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4f6d0e81f9b8..4d8a2c4b5627 100644
> --- a/drivers/resctrl/Makefile
> +++ b/drivers/resctrl/Makefile
> @@ -3,3 +3,6 @@ mpam-y                                          +=3D mpam=
_devices.o
>  mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)           +=3D mpam_resctrl.o
>
>  ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)      +=3D -DDEBUG
> +
> +obj-$(CONFIG_RISCV_CBQRI)                      +=3D cbqri.o
> +cbqri-y                                                +=3D cbqri_device=
s.o
> diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devi=
ces.c
> new file mode 100644
> index 000000000000..3e1df660920e
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_devices.c
> @@ -0,0 +1,563 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/riscv_cbqri.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <asm/csr.h>
> +
> +#include "cbqri_internal.h"
> +
> +LIST_HEAD(cbqri_controllers);
> +
> +/*
> + * Serializes cbqri_controllers mutations against a concurrent insert un=
der
> + * asynchronous driver probing, and against the boot-time walk in the re=
sctrl
> + * glue. Runtime cpuhp walks happen after registration has settled.
> + */
> +DEFINE_MUTEX(cbqri_controllers_lock);
> +
> +/*
> + * CBQRI registers are 64-bit, but the spec only guarantees single-copy
> + * atomicity for naturally aligned 4-byte accesses. Read the two halves =
and
> + * reconstruct, so the driver does not rely on native 64-bit MMIO.
> + *
> + * The halves are not sampled atomically, but a tear is harmless. The fi=
elds
> + * that change while an operation runs, BUSY (bit 39) and STATUS (bits
> + * 38:32), are in the high half and read by the single high readl(). The=
 low
> + * half (OP/AT/RCID) is software-written and constant for the operation.
> + */
> +static u64 cbqri_readq(void __iomem *addr)
> +{
> +       u32 lo =3D readl(addr);
> +       u32 hi =3D readl(addr + 4);
> +
> +       return (u64)hi << 32 | lo;
> +}
> +
> +/* Set capacity block mask (cc_block_mask) */
> +static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
> +{
> +       /*
> +        * cbqri_probe_cc() rejects ncblks > 32, so the mask fits the low=
 word.
> +        * Per CBQRI 3.5 the cc_block_mask bits above NCBLKS are read-onl=
y zero,
> +        * so the upper word needs no write.
> +        */
> +       writel(lower_32_bits(cbm), ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> +}
> +
> +/*
> + * Clear cc_cunits so a CONFIG_LIMIT on a CUNITS-capable controller impo=
ses no
> + * capacity-unit limit. resctrl models only the block mask. On controlle=
rs
> + * with cc_capabilities.CUNITS =3D=3D 0 the register is read-only zero, =
so there is
> + * nothing to do.
> + */
> +static void cbqri_clear_cunits(struct cbqri_controller *ctrl)
> +{
> +       if (ctrl->cc.cunits) {
> +               writel(0, ctrl->base + CBQRI_CC_CUNITS_OFF);
> +               writel(0, ctrl->base + CBQRI_CC_CUNITS_OFF + 4);
> +       }
> +}
> +
> +static int cbqri_wait_busy_flag(struct cbqri_controller *ctrl, int reg_o=
ffset,
> +                               u64 *regp)
> +{
> +       u64 reg;
> +       int ret;
> +
> +       /*
> +        * Sleeping poll: caller holds ctrl->lock as a sleeping mutex, so
> +        * 10us/1ms is safe under PREEMPT_RT.
> +        */
> +       ret =3D read_poll_timeout(cbqri_readq, reg,
> +                               !FIELD_GET(CBQRI_CONTROL_REGISTERS_BUSY_M=
ASK, reg),
> +                               10, 1000, false, ctrl->base + reg_offset)=
;
> +       if (ret)
> +               return ret;
> +       if (regp)
> +               *regp =3D reg;
> +       return 0;
> +}
> +
> +/*
> + * Perform capacity allocation control operation on capacity controller.
> + * Caller must hold ctrl->lock.
> + */
> +static int cbqri_cc_alloc_op(struct cbqri_controller *ctrl, int operatio=
n,
> +                            int rcid, u32 at)
> +{
> +       int reg_offset =3D CBQRI_CC_ALLOC_CTL_OFF;
> +       int status;
> +       u64 reg;
> +
> +       lockdep_assert_held(&ctrl->lock);
> +
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +               pr_err_ratelimited("BUSY timeout before starting operatio=
n\n");
> +               return -EIO;
> +       }
> +       FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_OP_MASK, &reg, operation);
> +       FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_RCID_MASK, &reg, rcid);
> +
> +       /*
> +        * CBQRI Table 1: AT 0=3DData, 1=3DCode. Program AT on controller=
s
> +        * that report supports_alloc_at_code. On controllers that don't,
> +        * AT is reserved-zero and the op acts on both halves.
> +        */
> +       reg &=3D ~CBQRI_CONTROL_REGISTERS_AT_MASK;
> +       if (ctrl->cc.supports_alloc_at_code)
> +               reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK, at);
> +
> +       writel(lower_32_bits(reg), ctrl->base + reg_offset);
> +
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +               pr_err_ratelimited("BUSY timeout during operation\n");
> +               return -EIO;
> +       }
> +
> +       status =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
> +       if (status !=3D CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS) {
> +               pr_err_ratelimited("operation %d failed: status=3D%d\n", =
operation, status);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Apply a capacity block mask and verify via CONFIG_LIMIT + READ_LIMIT.
> + *
> + * AT-capable controllers with CDP off need a second CONFIG_LIMIT on the
> + * other AT half (the spec encodes AT only as 0=3DData / 1=3DCode, there=
 is
> + * no "both halves" value). CDP-on issues separate per-type writes from
> + * resctrl, so a single CONFIG_LIMIT per call is correct.
> + */
> +int cbqri_apply_cache_config(struct cbqri_controller *ctrl, u32 closid,
> +                            const struct cbqri_cc_config *cfg)
> +{
> +       bool need_at_mirror;
> +       u64 saved_cbm =3D 0;
> +       int err =3D 0;
> +       u64 reg;
> +
> +       mutex_lock(&ctrl->lock);
> +
> +       need_at_mirror =3D ctrl->cc.supports_alloc_at_code && !cfg->cdp_e=
nabled;
> +
> +       /*
> +        * Capture the cfg->at half CBM before any write so a partial
> +        * AT-mirror failure can revert and keep the two halves consisten=
t.
> +        * Pre-clear cc_block_mask so a silent firmware no-op (status
> +        * SUCCESS but staging not updated) shows as a zero readback
> +        * rather than carrying stale data from a prior op.
> +        */
> +       if (need_at_mirror) {
> +               cbqri_set_cbm(ctrl, 0);
> +               err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_REA=
D_LIMIT,
> +                                       closid, cfg->at);
> +               if (err < 0)
> +                       goto out;
> +               saved_cbm =3D cbqri_readq(ctrl->base + CBQRI_CC_BLOCK_MAS=
K_OFF);
> +       }
> +
> +       /* Set capacity block mask (cc_block_mask) */
> +       cbqri_set_cbm(ctrl, cfg->cbm);
> +       cbqri_clear_cunits(ctrl);
> +
> +       /* Capacity config limit operation for the AT half implied by cfg=
->at */
> +       err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMI=
T,
> +                               closid, cfg->at);
> +       if (err < 0)
> +               goto out;
> +
> +       /*
> +        * CDP-off mirror: on AT-capable controllers, also program the
> +        * other AT half with the same mask so the two halves stay in syn=
c.
> +        */
> +       if (need_at_mirror) {
> +               u32 other =3D (cfg->at =3D=3D CBQRI_CONTROL_REGISTERS_AT_=
CODE) ?
> +                           CBQRI_CONTROL_REGISTERS_AT_DATA :
> +                           CBQRI_CONTROL_REGISTERS_AT_CODE;
> +
> +               cbqri_set_cbm(ctrl, cfg->cbm);
> +               cbqri_clear_cunits(ctrl);
> +               err =3D cbqri_cc_alloc_op(ctrl,
> +                                       CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMI=
T,
> +                                       closid, other);
> +               if (err < 0) {
> +                       int rerr;
> +
> +                       /*
> +                        * Best-effort revert of the cfg->at half so the =
two
> +                        * halves stay in sync. A schemata read sees only=
 one
> +                        * half, so silent divergence would otherwise rep=
ort
> +                        * the new value as if the write had succeeded.
> +                        */
> +                       cbqri_set_cbm(ctrl, saved_cbm);
> +                       cbqri_clear_cunits(ctrl);
> +                       rerr =3D cbqri_cc_alloc_op(ctrl,
> +                                                CBQRI_CC_ALLOC_CTL_OP_CO=
NFIG_LIMIT,
> +                                                closid, cfg->at);
> +                       if (rerr < 0)
> +                               pr_err_ratelimited("AT-mirror revert fail=
ed (err=3D%d), AT halves diverged\n",
> +                                                  rerr);
> +                       goto out;
> +               }
> +       }
> +
> +       /* Clear cc_block_mask before read limit to verify op works */
> +       cbqri_set_cbm(ctrl, 0);
> +
> +       /* Perform a capacity read limit operation to verify blockmask */
> +       err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
> +                               closid, cfg->at);
> +       if (err < 0)
> +               goto out;
> +
> +       /*
> +        * Read capacity blockmask and narrow to u32 to match resctrl's C=
BM
> +        * width. cbqri_probe_cc() rejects ncblks > 32 so the upper bits =
are
> +        * reserved zero.
> +        */
> +       reg =3D cbqri_readq(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> +       if (lower_32_bits(reg) !=3D cfg->cbm) {
> +               pr_err_ratelimited("CBM verify mismatch (reg=3D%llx !=3D =
cbm=3D%llx)\n",
> +                                  reg, cfg->cbm);
> +               err =3D -EIO;
> +       }
> +
> +out:
> +       mutex_unlock(&ctrl->lock);
> +       return err;
> +}
> +
> +/*
> + * Read the configured CBM for closid on the at half via READ_LIMIT.
> + * Pre-clears cc_block_mask before the op so a silent firmware no-op
> + * (status SUCCESS but staging not updated) is detectable in cbm_out.
> + */
> +int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
> +                           u32 at, u32 *cbm_out)
> +{
> +       int err;
> +
> +       mutex_lock(&ctrl->lock);
> +       cbqri_set_cbm(ctrl, 0);
> +       err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,=
 closid, at);
> +       if (err =3D=3D 0) {
> +               /*
> +                * resctrl exposes the CBM as a u32 and cbqri_probe_cc() =
rejects
> +                * ncblks > 32, so the mask fits the low 32-bit word of t=
he
> +                * cc_block_mask register.
> +                */
> +               *cbm_out =3D readl(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> +       }
> +       mutex_unlock(&ctrl->lock);
> +       return err;
> +}
> +
> +static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_of=
fset,
> +                              int operation, int *status, bool *access_t=
ype_supported)
> +{
> +       const u64 active_mask =3D CBQRI_CONTROL_REGISTERS_OP_MASK |
> +                               CBQRI_CONTROL_REGISTERS_AT_MASK |
> +                               CBQRI_CONTROL_REGISTERS_RCID_MASK;
> +       u64 reg, saved_reg;
> +       int at;
> +
> +       /*
> +        * Default the output to false so the status=3D=3D0 (feature not
> +        * implemented) path returns a deterministic value to the caller
> +        * rather than leaving an uninitialized bool.
> +        */
> +       *access_type_supported =3D false;
> +
> +       /* Keep the initial register value to preserve the WPRI fields */
> +       reg =3D cbqri_readq(ctrl->base + reg_offset);
> +       saved_reg =3D reg;
> +
> +       /* Drain any in-flight firmware op before issuing our own write. =
*/
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &saved_reg) < 0) {
> +               pr_err("BUSY timeout before probe operation\n");
> +               return -EIO;
> +       }
> +
> +       /*
> +        * Execute the requested operation with all active fields
> +        * (OP/AT/RCID) zeroed except OP itself. Every bit not in
> +        * active_mask is WPRI and gets carried over from saved_reg.
> +        */
> +       reg =3D (saved_reg & ~active_mask) |
> +             FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
> +       writel(lower_32_bits(reg), ctrl->base + reg_offset);
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +               pr_err_ratelimited("BUSY timeout during operation\n");
> +               return -EIO;
> +       }
> +
> +       /* Get the operation status */
> +       *status =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
> +
> +       /*
> +        * Check for the AT support if the register is implemented
> +        * (if not, the status value will remain 0)
> +        */
> +       if (*status !=3D 0) {
> +               /*
> +                * Re-issue operation with AT=3DCODE so the controller
> +                * latches AT=3DCODE on supported hardware (or resets it =
to 0
> +                * on hardware that doesn't). OP must be a defined CBQRI =
op
> +                * here. OP=3D0 is a no-op and would silently disable CDP=
.
> +                */
> +               reg =3D (saved_reg & ~active_mask) |
> +                     FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operati=
on) |
> +                     FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
> +                                CBQRI_CONTROL_REGISTERS_AT_CODE);
> +               writel(lower_32_bits(reg), ctrl->base + reg_offset);
> +               if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +                       pr_err("BUSY timeout setting AT field\n");
> +                       return -EIO;
> +               }
> +
> +               /*
> +                * If the AT field value has been reset to zero,
> +                * then the AT support is not present
> +                */
> +               at =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_AT_MASK, reg);
> +               if (at =3D=3D CBQRI_CONTROL_REGISTERS_AT_CODE)
> +                       *access_type_supported =3D true;
> +       }
> +
> +       /*
> +        * Restore the original register value.
> +        * Clear OP to avoid re-triggering the probe op.
> +        */
> +       saved_reg &=3D ~CBQRI_CONTROL_REGISTERS_OP_MASK;
> +       writel(lower_32_bits(saved_reg), ctrl->base + reg_offset);
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, NULL) < 0) {
> +               pr_err("BUSY timeout restoring register value\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cbqri_probe_cc(struct cbqri_controller *ctrl)
> +{
> +       int err, status;
> +       int ver_major, ver_minor;
> +       u64 reg;
> +
> +       reg =3D cbqri_readq(ctrl->base + CBQRI_CC_CAPABILITIES_OFF);
> +       if (reg =3D=3D 0)
> +               return -ENODEV;
> +
> +       ver_minor =3D FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MINOR_MASK, reg=
);
> +       ver_major =3D FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK, reg=
);
> +       ctrl->cc.ncblks =3D FIELD_GET(CBQRI_CC_CAPABILITIES_NCBLKS_MASK, =
reg);
> +
> +       pr_debug("version=3D%d.%d ncblks=3D%d cache_level=3D%d\n",
> +                ver_major, ver_minor,
> +                ctrl->cc.ncblks, ctrl->cache.cache_level);
> +
> +       /*
> +        * NCBLKS =3D=3D 0 would divide-by-zero in the schemata math whil=
e
> +        * ctrl->lock is held.
> +        */
> +       if (!ctrl->cc.ncblks) {
> +               pr_warn("CC at %pa has 0 capacity blocks, skipping\n",
> +                       &ctrl->addr);
> +               return -ENODEV;
> +       }
> +
> +       if (ctrl->cc.ncblks > 32) {
> +               pr_warn("CC at %pa has ncblks=3D%u > 32 (resctrl CBM is u=
32), skipping\n",
> +                       &ctrl->addr, ctrl->cc.ncblks);
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * On a CUNITS-capable controller, CONFIG_LIMIT also consumes cc_=
cunits,
> +        * whose reset value is unspecified. The driver clears it to 0 (n=
o limit)
> +        * on every CONFIG_LIMIT, so cc_cunits at 0x28 must be within the=
 mapping.
> +        */
> +       ctrl->cc.cunits =3D FIELD_GET(CBQRI_CC_CAPABILITIES_CUNITS_MASK, =
reg);
> +       if (ctrl->cc.cunits && ctrl->size < CBQRI_CC_CUNITS_OFF + 8) {
> +               pr_warn("CC at %pa supports CUNITS but maps only %pa, ski=
pping\n",
> +                       &ctrl->addr, &ctrl->size);
> +               return -ENODEV;
> +       }
> +
> +       /* Probe allocation features */
> +       err =3D cbqri_probe_feature(ctrl, CBQRI_CC_ALLOC_CTL_OFF,
> +                                 CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
> +                                 &status, &ctrl->cc.supports_alloc_at_co=
de);
> +       if (err)
> +               return err;
> +
> +       if (status =3D=3D CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS)
> +               ctrl->alloc_capable =3D true;
> +
> +       return 0;
> +}
> +
> +static int cbqri_probe_controller(struct cbqri_controller *ctrl)
> +{
> +       int err;
> +
> +       pr_debug("controller info: type=3D%d addr=3D%pa size=3D%pa max-rc=
id=3D%u\n",
> +                ctrl->type, &ctrl->addr, &ctrl->size, ctrl->rcid_count);
> +
> +       if (!ctrl->addr) {
> +               pr_warn("controller has invalid addr=3D0x0, skipping\n");
> +               return -EINVAL;
> +       }
> +
> +       if (ctrl->size < CBQRI_CTRL_MIN_REG_SPAN) {
> +               pr_warn("controller at %pa: size %pa < minimum 0x%x, skip=
ping\n",
> +                       &ctrl->addr, &ctrl->size, CBQRI_CTRL_MIN_REG_SPAN=
);
> +               return -EINVAL;
> +       }
> +
> +       if (!request_mem_region(ctrl->addr, ctrl->size, "cbqri_controller=
")) {
> +               pr_err("request_mem_region failed for %pa\n", &ctrl->addr=
);
> +               return -EBUSY;
> +       }
> +
> +       ctrl->base =3D ioremap(ctrl->addr, ctrl->size);
> +       if (!ctrl->base) {
> +               pr_err("ioremap failed for %pa\n", &ctrl->addr);
> +               err =3D -ENOMEM;
> +               goto err_release;
> +       }
> +
> +       switch (ctrl->type) {
> +       case CBQRI_CONTROLLER_TYPE_CAPACITY:
> +               err =3D cbqri_probe_cc(ctrl);
> +               break;
> +       default:
> +               pr_err("unknown controller type %d\n", ctrl->type);
> +               err =3D -ENODEV;
> +               break;
> +       }
> +
> +       if (err)
> +               goto err_iounmap;
> +
> +       return 0;
> +
> +err_iounmap:
> +       iounmap(ctrl->base);
> +       ctrl->base =3D NULL;
> +err_release:
> +       release_mem_region(ctrl->addr, ctrl->size);
> +       return err;
> +}
> +
> +void cbqri_controller_destroy(struct cbqri_controller *ctrl)
> +{
> +       /*
> +        * cbqri_probe_controller() clears ctrl->base on its error paths =
and
> +        * releases the mem region itself, so reach into both only when
> +        * destroy is rolling back a successful probe.
> +        */
> +       if (ctrl->base) {
> +               iounmap(ctrl->base);
> +               release_mem_region(ctrl->addr, ctrl->size);
> +       }
> +       kfree(ctrl);
> +}
> +
> +/**
> + * riscv_cbqri_register_cc_dt() - register a DT-described capacity contr=
oller
> + * @info:        registration descriptor. info->cache_id is used as the
> + *               resctrl domain id. info->type must be CAPACITY.
> + * @cache_level: cache level (2 or 3) the controller backs, mapped to th=
e
> + *               resctrl L2/L3 resource by the resctrl glue.
> + *
> + * The cache level and id (info->cache_id) are supplied directly by the
> + * caller, which resolves them from cacheinfo. Domain membership is reso=
lved
> + * per CPU at hotplug, so no cpu mask is stored. There is no firmware ta=
ble
> + * to resolve any of this from.
> + *
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
> +                              u32 cache_level)
> +{
> +       struct cbqri_controller *ctrl;
> +       int err;
> +
> +       if (!info->addr) {
> +               pr_warn("skipping controller with invalid addr=3D0x0\n");
> +               return -EINVAL;
> +       }
> +
> +       if (info->type !=3D CBQRI_CONTROLLER_TYPE_CAPACITY) {
> +               pr_warn("register_cc_dt called with non-capacity type %u\=
n",
> +                       info->type);
> +               return -EINVAL;
> +       }
> +
> +       ctrl =3D kzalloc(sizeof(*ctrl), GFP_KERNEL);
> +       if (!ctrl)
> +               return -ENOMEM;
> +
> +       mutex_init(&ctrl->lock);
> +
> +       ctrl->addr =3D info->addr;
> +       ctrl->size =3D info->size;
> +       ctrl->type =3D info->type;
> +       ctrl->rcid_count =3D info->rcid_count;
> +
> +       /*
> +        * SRMCFG encodes RCID in 12 bits. Reject an out-of-range count r=
ather
> +        * than silently truncating in every FIELD_PREP(SRMCFG_RCID_MASK,=
 closid)
> +        * on the schedule-in fast path.
> +        */
> +       if (ctrl->rcid_count > FIELD_MAX(SRMCFG_RCID_MASK) + 1) {
> +               pr_warn("CC at %pa has RCID count %u beyond the 12-bit SR=
MCFG field, skipping\n",
> +                       &ctrl->addr, ctrl->rcid_count);
> +               cbqri_controller_destroy(ctrl);
> +               return -EINVAL;
> +       }
> +
> +       ctrl->cache.cache_id =3D info->cache_id;
> +       ctrl->cache.cache_level =3D cache_level;
> +
> +       err =3D cbqri_probe_controller(ctrl);
> +       if (err) {
> +               cbqri_controller_destroy(ctrl);
> +               return err;
> +       }
> +
> +       /*
> +        * Allocation capability comes from the capabilities register pro=
bed
> +        * above, not from device tree. rcid_count only bounds the RCID r=
ange,
> +        * so a controller the hardware reports as alloc-capable but desc=
ribed
> +        * with no RCID count cannot be driven. Reject that inconsistency=
. A
> +        * monitoring-only controller (not alloc_capable) needs no RCID c=
ount.
> +        */
> +       if (ctrl->alloc_capable && !ctrl->rcid_count) {
> +               pr_warn("CC at %pa is alloc-capable but has no RCID count=
, skipping\n",
> +                       &ctrl->addr);
> +               cbqri_controller_destroy(ctrl);
> +               return -EINVAL;
> +       }
> +
> +       guard(mutex)(&cbqri_controllers_lock);
> +       list_add_tail(&ctrl->list, &cbqri_controllers);
> +       return 0;
> +}
> diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_int=
ernal.h
> new file mode 100644
> index 000000000000..77429f39f874
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_internal.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _DRIVERS_RESCTRL_CBQRI_INTERNAL_H
> +#define _DRIVERS_RESCTRL_CBQRI_INTERNAL_H
> +
> +#include <linux/bitfield.h>
> +#include <linux/riscv_cbqri.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +/* Capacity Controller (CC) MMIO register offsets. */
> +#define CBQRI_CC_CAPABILITIES_OFF 0
> +#define CBQRI_CC_ALLOC_CTL_OFF   24
> +#define CBQRI_CC_BLOCK_MASK_OFF  32
> +
> +/*
> + * Per CBQRI 3.5 the block-mask width BMW is the smallest multiple of 64=
 bits
> + * that holds NCBLKS, so cc_cunits sits at 32 + BMW/8 bytes. This consta=
nt is
> + * valid only while NCBLKS <=3D 64. cbqri_probe_cc() rejects ncblks > 32=
 before
> + * it reads cc_capabilities.CUNITS, forcing BMW to 64 bits, one 8-byte b=
lock
> + * mask, and cc_cunits at 0x28. Raising that cap above 64 would require
> + * computing 32 + roundup(ncblks, 64) / 8 instead of a constant.
> + */
> +#define CBQRI_CC_CUNITS_OFF      40
> +
> +/*
> + * Highest base register offset (cc_block_mask at 0x20) plus its 8-byte =
width.
> + * cbqri_probe_controller() rejects smaller mappings. cc_cunits at 0x28 =
is
> + * optional and only required when cc_capabilities.CUNITS is set, which
> + * cbqri_probe_cc() checks against the mapping size separately.
> + */
> +#define CBQRI_CTRL_MIN_REG_SPAN  0x28u
> +
> +#define CBQRI_CC_CAPABILITIES_VER_MINOR_MASK  GENMASK_ULL(3, 0)
> +#define CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK  GENMASK_ULL(7, 4)
> +#define CBQRI_CC_CAPABILITIES_NCBLKS_MASK     GENMASK_ULL(23, 8)
> +#define CBQRI_CC_CAPABILITIES_CUNITS_MASK     BIT_ULL(25)
> +
> +/*
> + * CC control registers are 64-bit, but the CBQRI spec only guarantees
> + * single-copy atomicity for naturally aligned 4-byte accesses. They are=
 read
> + * as two 32-bit halves (cbqri_readq) reconstructed into a u64 for field
> + * extraction, and written via the low 32-bit half, so the driver does n=
ot
> + * depend on native 64-bit MMIO. Keep every field mask GENMASK_ULL so
> + * FIELD_MODIFY() or ~mask on the reconstructed u64 never zero-extends a
> + * 32-bit mask and clobbers STATUS/BUSY/WPRI in bits 63:32.
> + */
> +#define CBQRI_CONTROL_REGISTERS_OP_MASK      GENMASK_ULL(4, 0)
> +#define CBQRI_CONTROL_REGISTERS_AT_MASK      GENMASK_ULL(7, 5)
> +/* AT field values (CBQRI Table 1): data vs code half for CDP */
> +#define CBQRI_CONTROL_REGISTERS_AT_DATA      0
> +#define CBQRI_CONTROL_REGISTERS_AT_CODE      1
> +#define CBQRI_CONTROL_REGISTERS_RCID_MASK    GENMASK_ULL(19, 8)
> +#define CBQRI_CONTROL_REGISTERS_STATUS_MASK  GENMASK_ULL(38, 32)
> +#define CBQRI_CONTROL_REGISTERS_BUSY_MASK    GENMASK_ULL(39, 39)
> +
> +#define CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT 1
> +#define CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT   2
> +#define CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS  1
> +
> +/* Capacity Controller hardware capabilities */
> +struct riscv_cbqri_capacity_caps {
> +       u16 ncblks;
> +       bool supports_alloc_at_code;
> +       /* cc_capabilities.CUNITS: controller enforces a capacity-unit li=
mit */
> +       bool cunits;
> +};
> +
> +/**
> + * struct cbqri_cc_config - desired capacity allocation state for one rc=
id
> + * @cbm:         capacity block mask
> + * @at:          AT half the @cbm applies to (CBQRI_CONTROL_REGISTERS_AT=
_DATA
> + *               or CBQRI_CONTROL_REGISTERS_AT_CODE)
> + * @cdp_enabled: when false and the controller supports AT, mirror @cbm
> + *               into the other AT half so both stay in sync
> + */
> +struct cbqri_cc_config {
> +       u64  cbm;
> +       u32  at;
> +       bool cdp_enabled;
> +};
> +
> +struct cbqri_controller {
> +       void __iomem *base;
> +       /*
> +        * Serializes the write-then-poll-busy MMIO sequences on this
> +        * controller. Each CBQRI op may busy-wait up to 1 ms on slow
> +        * firmware, so use a sleeping mutex to keep preemption enabled.
> +        * All resctrl-arch entry points run in process context.
> +        */
> +       struct mutex lock;
> +
> +       struct riscv_cbqri_capacity_caps cc;
> +
> +       bool alloc_capable;
> +
> +       phys_addr_t addr;
> +       phys_addr_t size;
> +       enum cbqri_controller_type type;
> +       u32 rcid_count;
> +
> +       struct list_head list;
> +
> +       struct cache_controller {
> +               u32 cache_level;
> +               /* Cache id used as the resctrl domain id */
> +               u32 cache_id;
> +       } cache;
> +};
> +
> +extern struct list_head cbqri_controllers;
> +extern struct mutex cbqri_controllers_lock;
> +
> +void cbqri_controller_destroy(struct cbqri_controller *ctrl);
> +
> +int cbqri_apply_cache_config(struct cbqri_controller *ctrl, u32 closid,
> +                            const struct cbqri_cc_config *cfg);
> +
> +int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
> +                           u32 at, u32 *cbm_out);
> +
> +#endif /* _DRIVERS_RESCTRL_CBQRI_INTERNAL_H */
> diff --git a/include/linux/riscv_cbqri.h b/include/linux/riscv_cbqri.h
> new file mode 100644
> index 000000000000..e6b3febbed89
> --- /dev/null
> +++ b/include/linux/riscv_cbqri.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Public registration API for the RISC-V Capacity and Bandwidth QoS
> + * Register Interface (CBQRI) core. Discovery layers (device tree
> + * platform drivers) call riscv_cbqri_register_cc_dt() to hand a capacit=
y
> + * controller descriptor to the core, which owns all subsequent state.
> + */
> +#ifndef _LINUX_RISCV_CBQRI_H
> +#define _LINUX_RISCV_CBQRI_H
> +
> +#include <linux/types.h>
> +
> +enum cbqri_controller_type {
> +       CBQRI_CONTROLLER_TYPE_CAPACITY,
> +};
> +
> +/**
> + * struct cbqri_controller_info - registration descriptor
> + * @addr:        MMIO base address of the controller's register interfac=
e
> + * @size:        size of the MMIO region
> + * @type:        controller type (capacity)
> + * @rcid_count:  number of supported RCIDs
> + * @cache_id:    cache id used as the resctrl domain id
> + */
> +struct cbqri_controller_info {
> +       phys_addr_t                     addr;
> +       phys_addr_t                     size;
> +       enum cbqri_controller_type      type;
> +       u32                             rcid_count;
> +       u32                             cache_id;
> +};
> +
> +#if IS_ENABLED(CONFIG_RISCV_CBQRI)
> +int riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
> +                              u32 cache_level);
> +#else
> +static inline int
> +riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
> +                          u32 cache_level)
> +{
> +       return -ENODEV;
> +}
> +#endif
> +
> +#endif /* _LINUX_RISCV_CBQRI_H */
>
> --
> 2.43.0
>

Thanks,
Yunhui
