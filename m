Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522630CD82;
	Sun, 28 Jun 2026 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782682209; cv=none; b=XfHHTr8tKaW7xynUhmPF8SuDOmpNq2Vn4r1wFiv2Ik/BdSvUh+jIebovApWozONAgp6dqFf7/xDOn7zcjSKN1eF29HQutvh3l6FJloIN3wssswNpn+xFOpTV6WOtvk7wsQyeuORpO8tw87MMvoQqbjki5XfgiTJ9R0Q6Jz2kDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782682209; c=relaxed/simple;
	bh=YNdUa5VlwRC5S4bgAKVNfM/pN4Mq7ChcrxrUcIE/UpI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QR40LSTxQRXavExf/h9bU9AdfMpoqLi5ogx/4u1HPVl+S5CqFfyTqMb5GxQNaqazx60sGaW27fUSFKQjJDy2nFoZevVkkKHV0qGtv2yYNg2/2HkmEguwG4YOB8Pkg1rr92LuZHaRbDr2wyE0/9FVs0FdRLpovsBTL1O1ylpGKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2CD1F000E9;
	Sun, 28 Jun 2026 21:30:07 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] riscv: Enable resctrl filesystem for Ssqosid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rt-devel@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260628-dfustini-atl-sc-cbqri-dt-v3-6-c9c1342fe3cf@kernel.org>
References: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
 <20260628-dfustini-atl-sc-cbqri-dt-v3-6-c9c1342fe3cf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 21:30:07 +0000
Message-Id: <20260628213007.AE2CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] RISCV_ISA_SSQOSID unconditionally selects the user-visible menuc=
onfig RISCV_CBQRI, defeating its prompt and violating Kconfig best practice=
s.
--

commit 6a7bfcfac7becb358efe0bde0c988634f28e5326
Author: Drew Fustini <fustini@kernel.org>

riscv: Enable resctrl filesystem for Ssqosid

This commit enables the resctrl filesystem for the RISC-V Ssqosid extension.
It modifies the RISCV_ISA_SSQOSID config to select ARCH_HAS_CPU_RESCTRL and
RISCV_CBQRI.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ee586925f9722..9c28bcbc29dc9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -594,6 +594,8 @@ config RISCV_ISA_SSQOSID
>  	bool "Ssqosid extension support for supervisor mode Quality of Service =
ID"
>  	depends on 64BIT
>  	default n
> +	select ARCH_HAS_CPU_RESCTRL
> +	select RISCV_CBQRI

[Severity: Medium]
Is it intentional to use select on RISCV_CBQRI here?

RISCV_CBQRI appears to be defined as a user-visible menuconfig:

drivers/resctrl/Kconfig:
menuconfig RISCV_CBQRI
	bool "RISC-V CBQRI support"
	depends on RISCV && RISCV_ISA_SSQOSID

Using select on a user-visible symbol forces it on and overrides the prompt,
which can create a confusing configuration experience where the option is
visible but cannot be toggled.

Could this be addressed by either using "depends on" instead of select,
or by making RISCV_CBQRI a hidden symbol without a prompt?

>  	help
>  	  Adds support for the Ssqosid ISA extension (Supervisor-mode

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-dfustini-a=
tl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org?part=3D6
