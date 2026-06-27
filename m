Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8BA255F28
	for <linux-rt-devel@lists.linux.dev>; Sat, 27 Jun 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552679; cv=pass; b=r2x3G8CgXJlSV4E7Q9PJ1q1c43whQnklFus6ZR0wEXBHJdzHo/m3jajP6bARbm1s7KuKe5oRmtRfEuhIojAy1C2nOGD3uzjG3sCkzN+iadAAlM1dKfUdVj7w1i2tbUgFiWHM+o2x/C5cptMaazRdV24sv7J0IbCrGfOvULwjYv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552679; c=relaxed/simple;
	bh=LzU6jX0sAyUn0E704o1Dohe6SOSG2+3b9J3BQ3goWwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jix8Cv5BdBXBYN3HbYmYEPAf7l9GtmmrcTq9T6cY3epgPb0n9kx66kdC5ovsE79Hoz3y0317yoseLsxlH+0t6g3RoRGQOzra24sb1h1WmeO1E+f2dhEp8pqMPYVpqS5U09SIi678YWXZHUJx9mEqiIwiU1ZyxcXUhXhAFMyoeiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ApjHrDRq; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ApjHrDRq"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-49190e20a0cso935733b6e.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 27 Jun 2026 02:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782552675; cv=none;
        d=google.com; s=arc-20260327;
        b=dZU2XsKOGdqaOUU/LVeE1bX16LDb/tZMv9kV5iR1UQwm6hbKyR20HvNywftdNIGiee
         l8USQCcYqfT2bzVF9OmND84hSuQtt6gEiIMsHeo3TbotiVzuXFS5nq37VmkR1iqVILtX
         L96emGTMr2u7JlyP6ERUfmTx5Tea5L6tZmPU3Z1MzWwJsXqCb385M3F6gM3MZW4f2h9y
         dYpf88AdxNap5eKkOOD+np5U/ZUM1QQAt5gRox4JAM3zxCD16c1QiDaEsdud9WA9L0cJ
         xV2saZozPK3EDnpWspY/UjUIc+Gp3EVxDfrZYqV+0M7TGVVmcyfci+zyFbbirz1Gv7B7
         Wu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FJ1wk8NDsFR0CTH7guw4KrGeXq7Bw6mRSIeh4I3dWQU=;
        fh=Yeo/9zkpcFUnLR1BB7FsaefV7hhO5KyFA4po7aoCxRo=;
        b=pnF3MEQwk0ddvIdrL96l1KU1sp7kjbqM9tkih2c5m/WQEbGNvBzDNkFu3Ds9d3LdIQ
         Lex3UG/3MvKU/2tH/KBF2ITE8kBGwpcxXUEvHwPBMJ2o0q9KwJTOqrouVLaGsjEzmNGg
         UynTHxvpHqJFduyfKQvBE66MzeXMFVXangM999/Tv9UwN1ZAEan+C5SaMThx5oksUOPM
         QeT/LMXWJE/eOuTi7ZnZm5cPoZfdlrVguztSmZ9UtDUz/rq+3Et1u7o9QRLt2UCNCo2i
         ekYHCPbSleeUF3CzOpvAvBb5vWqN+TrQCnhKD3+ltDqyb5uyzcgx7RZD1m/10llNEc9X
         sDUg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782552675; x=1783157475; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ1wk8NDsFR0CTH7guw4KrGeXq7Bw6mRSIeh4I3dWQU=;
        b=ApjHrDRqMGCC5DRgqNcclEoFS7BZ/VrKJRDHttzgXiC1xRmPWVhvJpG5MNHBSNdWwJ
         fPqAiJi888Euxu79zcRcPD81FmOV93oqASvP8njce3uWx19CidKycl8ikT/g0LlUN7WQ
         zohuosDgTVTUF/Y5c92gLMX78x43HK5K5lA8chTz5tmxsk4vCQMZxjgTKhF5VdT0mFDh
         6xHPgXm8gdcNRjekcSnL3cyjqGXGGadTbUbHW4ZlHdgUbZzq5SMYynt+MIf9Zxwm0sPK
         2UxShpmlpnDK0JOwbo0HwPE7wHspBFDqsdCJjHp5Fx2zFM11aj6pEqvG9KKIoEQDx0+H
         ujag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782552675; x=1783157475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJ1wk8NDsFR0CTH7guw4KrGeXq7Bw6mRSIeh4I3dWQU=;
        b=RNy4mwcYWBRF1HTlq/B3yfNgFnPNSaywTwVySHhHmay9IERo+XCPLqRfDJ14iDgUqo
         fEI+fJYbhviZ2OPvYMhS2x0b8ykxldeIIx308E6MQshrVTZeAl7ASFhEfdqdUNbYj9gH
         ZFM7z9eoPsx38F5xAZ3ImRN8s8GJh3pUgPojAn2xxyzr9S544UpJI6KfwZLpvTW3PP2R
         8Ppeco2l2P90ZM5oWzf8y4j4IJ7r8+pYI2AjWS9t4GCf0w5ijBxk+FFv3tYQe56hSc8C
         guzH72/N45Oz8EsElk2kw3/tPbB7ZglA4eBqKLMNWAs1HWoehiTByQRtlXHlv1O6Kp0i
         Vtaw==
X-Forwarded-Encrypted: i=1; AFNElJ9UY+NE+xcXkXTdvf4o9vVaYZnF3BsbyRIk6Dn9zhdVgqV3qDaJm/Bj9PE9AeqBp4ghM1tiGXm9X9rox6xeww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIUirUHlDffVkfeOIvuNWMmHxD3FDgW/Hq92mfoKfn5QaxjLxE
	YdgC8qnlKzvYtVSU49C96tlV7/an6pu+tM6JzX8EKIl+llqPQMgAna7vYi9QOaGmBLS9WmdG69J
	QqWDxVUHIPSS8ZYPE4iKfH3cK3tR7i48BBGLeoHFcHw==
X-Gm-Gg: AfdE7cmfb6NjopLpbQ3qT1rAkqirugYDRe6XK9AXFs8/pQh50r4OzZm39A5Wu2PAQVS
	kpJp+afCLlirSRFbptHa8qi+zyV0gqkbGfRoxfbm5daNGU8+wZ8M3MLc6OBVOyR6TlZBqIvgjpJ
	uxHfUuiZCl2+SBeOTVNNV8y0HObTHDQxuNLW8CTjRYYL9EtjxEhuzrdxQS9uqMVXw9Jtgqx/r2z
	3/BImB+W5iUMNCy6co4rCrnavAGiClu9Bw7Tz6PRM9YpS6lxmEhYWOgauC+rb7FkGoJjj+aDX4=
X-Received: by 2002:a05:6808:1a0a:b0:48a:c5f4:a7dd with SMTP id
 5614622812f47-49218ffde71mr8204108b6e.28.1782552675205; Sat, 27 Jun 2026
 02:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org> <20260624-dfustini-atl-sc-cbqri-dt-v2-4-2f8049fd902b@kernel.org>
In-Reply-To: <20260624-dfustini-atl-sc-cbqri-dt-v2-4-2f8049fd902b@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sat, 27 Jun 2026 17:31:03 +0800
X-Gm-Features: AVVi8CfFzCjj-9fMp2nPtn7GClCUFG4CSzlD6kiyao7KC8Lbd9ozj7SaMjTj6QQ
Message-ID: <CAEEQ3w=ZVtHPdLfN0tTzG8AACu+rjhEFWY5pCg+uxvmr7ofqfA@mail.gmail.com>
Subject: Re: [External] [PATCH v2 4/8] riscv_cbqri: Add capacity controller
 probe and allocation device ops
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

On Thu, Jun 25, 2026 at 9:41=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add support for the RISC-V CBQRI capacity controller. A platform driver
> passes a cbqri_controller_info descriptor together with the cache level
> to riscv_cbqri_register_cc_dt(), which probes the controller and adds it
> to the controller list.
>
> Assisted-by: Claude:claude-opus-4-7
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                      |   3 +
>  drivers/resctrl/Kconfig          |  13 +
>  drivers/resctrl/Makefile         |   3 +
>  drivers/resctrl/cbqri_devices.c  | 520 +++++++++++++++++++++++++++++++++=
++++++
>  drivers/resctrl/cbqri_internal.h | 107 ++++++++
>  include/linux/riscv_cbqri.h      |  47 ++++
>  6 files changed, 693 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 07109e1a8f8470377916c98074ab68fec51dfdc6..811c0c9b1fac806945cad0229=
c5330654420a835 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23300,6 +23300,9 @@ L:      linux-riscv@lists.infradead.org
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
> index 672abea3b03ccbeb4532832dd18e5cb80e90ff5b..92b9c82cf9f397437d28006e7=
9d40c2d9b384eb0 100644
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
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4f6d0e81f9b8f34bd8842fdb13be69da72515b79..4d8a2c4b5627144a651da0071=
74d4d9df6171330 100644
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
> index 0000000000000000000000000000000000000000..8ad9df404f65d5d82722cf8b7=
8f02936c489ca6d
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_devices.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/bitfield.h>
> +#include <linux/riscv_cbqri.h>
> +#include <linux/cpumask.h>
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
> +/* Set capacity block mask (cc_block_mask) */
> +static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
> +{
> +       iowrite64(cbm, ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);

The CBQRI spec allows naturally aligned 4-byte accesses and only guarantees
atomicity for 4-byte accesses; 8-byte atomicity is unspecified.

Would 32-bit split accesses be preferable here instead of relying on
ioread64/iowrite64? This may also make the driver less dependent on native
64-bit MMIO support.

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
> +       ret =3D readq_poll_timeout(ctrl->base + reg_offset, reg,
> +                                !FIELD_GET(CBQRI_CONTROL_REGISTERS_BUSY_=
MASK, reg),
> +                                10, 1000);
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
> +       iowrite64(reg, ctrl->base + reg_offset);
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
> +               saved_cbm =3D ioread64(ctrl->base + CBQRI_CC_BLOCK_MASK_O=
FF);
> +       }
> +
> +       /* Set capacity block mask (cc_block_mask) */
> +       cbqri_set_cbm(ctrl, cfg->cbm);
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
> +       reg =3D ioread64(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
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
> +                * cc_block_mask is a 64-bit MMIO register. resctrl expos=
es the
> +                * CBM as a u32. cbqri_probe_cc() rejects ncblks > 32 so =
the
> +                * upper 32 bits are reserved zero by the spec. Narrow
> +                * explicitly via lower_32_bits() so the assumption is vi=
sible
> +                * at the read site.
> +                */
> +               *cbm_out =3D lower_32_bits(ioread64(ctrl->base + CBQRI_CC=
_BLOCK_MASK_OFF));
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
> +       reg =3D ioread64(ctrl->base + reg_offset);
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
> +       iowrite64(reg, ctrl->base + reg_offset);
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
> +               iowrite64(reg, ctrl->base + reg_offset);
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
> +       iowrite64(saved_reg, ctrl->base + reg_offset);
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
> +       reg =3D ioread64(ctrl->base + CBQRI_CC_CAPABILITIES_OFF);
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
> + * @cpu_mask:    CPUs that share this cache.
> + *
> + * The cache topology is supplied directly by the caller. A device-tree
> + * platform driver that already knows which CPUs share the cache and at =
what
> + * level passes that in. There is no firmware table to resolve it from.
> + *
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
> +                              u32 cache_level, const struct cpumask *cpu=
_mask)
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
> +       if (!cpu_mask || cpumask_empty(cpu_mask)) {
> +               pr_warn("register_cc_dt called with empty cpu_mask\n");
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
> +       cpumask_copy(&ctrl->cache.cpu_mask, cpu_mask);
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
> +       mutex_lock(&cbqri_controllers_lock);
> +       list_add_tail(&ctrl->list, &cbqri_controllers);
> +       mutex_unlock(&cbqri_controllers_lock);
> +       return 0;
> +}
> diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_int=
ernal.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..2192a3831bcde7cd4fddf03f2=
ce1103902e8815c
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_internal.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _DRIVERS_RESCTRL_CBQRI_INTERNAL_H
> +#define _DRIVERS_RESCTRL_CBQRI_INTERNAL_H
> +
> +#include <linux/bitfield.h>
> +#include <linux/riscv_cbqri.h>
> +#include <linux/cpumask.h>
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
> + * Highest defined register offset (0x20) plus the 8-byte register width=
.
> + * cbqri_probe_controller() rejects smaller mappings so a u64 access at
> + * BLOCK_MASK stays in bounds.
> + */
> +#define CBQRI_CTRL_MIN_REG_SPAN  0x28u
> +
> +#define CBQRI_CC_CAPABILITIES_VER_MINOR_MASK  GENMASK_ULL(3, 0)
> +#define CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK  GENMASK_ULL(7, 4)
> +#define CBQRI_CC_CAPABILITIES_NCBLKS_MASK     GENMASK_ULL(23, 8)
> +
> +/*
> + * CC control registers are 64-bit. Keep every field mask GENMASK_ULL so
> + * FIELD_MODIFY() or ~mask on a u64 register never zero-extends a 32-bit
> + * mask and clobbers STATUS/BUSY/WPRI in bits 63:32 if RV32 support is
> + * added in the future.
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
> +               struct cpumask cpu_mask;
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
> index 0000000000000000000000000000000000000000..58737224d2f2c67a443f78f9f=
ea7f368c7d16044
> --- /dev/null
> +++ b/include/linux/riscv_cbqri.h
> @@ -0,0 +1,47 @@
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
> +struct cpumask;
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
> +                              u32 cache_level, const struct cpumask *cpu=
_mask);
> +#else
> +static inline int
> +riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
> +                          u32 cache_level, const struct cpumask *cpu_mas=
k)
> +{
> +       return -ENODEV;
> +}
> +#endif
> +
> +#endif /* _LINUX_RISCV_CBQRI_H */
>
> --
> 2.34.1
>

Thanks,
Yunhui
