Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838E01A5B8A;
	Mon, 29 Jun 2026 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737478; cv=none; b=kNnhywWd+u7J/zcGlfwiauEJDeocG/N+o6g/epLsyUV4AfCgJuns6AEVXGujBE+3Rv1BaIWBvmaUk3738STHg0HKY5+Ps9Ue4c9XbjIfOXgFS88Y4yT3IHI1Ok+7h5HW71bLev3qoI/qS2YV2aiBDlssb/FqrUlvHDhAOpladwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737478; c=relaxed/simple;
	bh=am+2kT5Mhn3yy6TGaa8kxRCHG9UXSPn7kXBgZ/aOWkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WATefkJxrdAcG2SiD/lUPSemUVmkCLeZhUnwPRo5rziDcdymYTRfOF+kr0SFpxAbnHkiZp4LbwDwyP6kATtcduZgWedAStaboMnLfAYj6+8hq6fB2BHyk+vu86pXvE0Q6K+qjLCA4reqeDCV0sNFuPqLrFrXgmrWJ2+/4r/pQDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzAE0lG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzAE0lG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C4D1F000E9;
	Mon, 29 Jun 2026 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782737477;
	bh=J92xK0LJefr1PvTlzBUiHK1AjNnxtDC8zHvbmWlnY50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nzAE0lG4gNgpaK5O1mJ5fzUUnZy4D98/is0excufCzdNHYhKOhrLOrINWsEJBHoHi
	 Nk311X6skLrghynqMwRDyL0yfiaxmn3ntXN05fljk07snA9CNPfoYy5aeNVd21vHVL
	 K0EJdiHqaywWixXqWJrD0pw/8eHV7CB4J8h6KX8I949vsvTl2qUjvJ8lZvSxv7EQWx
	 a/tphIX+mc7Zwdnd0/wa+ZUzqwrFVbDvLDzkrvpIFzI34MmDzbvLCbyVSLID5/9mMJ
	 LEmhMaG3J8E1mWc5jly5P3kLiuJWBeUU16WV3Mvjk43As7xCc6tYZVG2intvqEE6/1
	 jd4go9fA6l/1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ARM: enable interrupts when unhandled user faults
 are triggered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xie Yuanbin" <xieyuanbin1@huawei.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260629123349.134224-1-xieyuanbin1@huawei.com>
References: <20260629123349.134224-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 12:51:16 +0000
Message-Id: <20260629125117.34C4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing interrupt enablement in baddataabort() before sending =
signals, causing a PREEMPT_RT sleeping-while-atomic BUG.
--

commit c514933dc1b8809c06e2a04abca8d68edc5cd623
Author: Xie Yuanbin <xieyuanbin1@huawei.com>

ARM: enable interrupts when unhandled user faults are triggered

This commit enables interrupts in do_DataAbort() and do_PrefetchAbort()
when unhandled user faults are triggered. This resolves an issue on
PREEMPT_RT where calling force_sig_fault() with interrupts disabled
would cause problems, as PREEMPT_RT requires interrupts to be enabled
when sending signals.

> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index e62cc4be5adf6..c686775035325 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -633,6 +633,9 @@ do_DataAbort(unsigned long addr, unsigned int fsr, st=
ruct pt_regs *regs)
>  	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
>  		return;
> =20
> +	if (likely(user_mode(regs)))
> +		local_irq_enable();
> +

[Severity: Critical]
This is a pre-existing issue, but does a similar fix need to be applied
to baddataabort() in arch/arm/kernel/traps.c?

If a user-space program executes an unsupported data access instruction on
architectures using v4t_late_abort (like ARM720T or ARM7TDMI), it raises
a data abort exception and enters __dabt_usr with interrupts disabled.

Execution can proceed to v4t_late_abort(), and if instruction decode
fails, it branches to baddataabort():

arch/arm/mm/abort-lv4t.S:v4t_late_abort()
    .data_unknown:
        mov r0, r4
        mov r1, r8
        b   baddataabort

baddataabort() then calls arm_notify_die() which eventually calls
force_sig_fault():

arch/arm/kernel/traps.c:baddataabort()
    arm_notify_die("unknown data abort code", regs,
                   SIGILL, ILL_ILLOPC, (void __user *)addr, instr, 0);

Because baddataabort() lacks the local_irq_enable() being added here in
do_DataAbort(), interrupts remain disabled during signal delivery. Could
this allow an unprivileged local user to trigger this path and cause a
sleeping-while-atomic panic on PREEMPT_RT?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629123349.1342=
24-1-xieyuanbin1@huawei.com?part=3D1
