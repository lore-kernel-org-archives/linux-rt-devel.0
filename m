Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6573783D5;
	Mon, 12 Oct 2026 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794487; cv=none; b=bUbJdR6M2ougd0/vCPr5ps8m9b3uKHNXtz56zVSsIoMgfIVVG7Oiqia70Ck6X6K4hRwREVrcnK2oMttvTcNGP93RmbXLUrDCjVCFP1oDDw7HFGlIFhDcJWOZguLOiSy4bwNZUqUg50H6nXqItFw93CH/yFBX4O2gDfkmt8pcqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794487; c=relaxed/simple;
	bh=FEaVqUC7+QhTolAQa07RN1nbny7lslqeXfm2iGC7kHw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SmQ1/tyWUcwUdsNwr7onH4Kp+9iZsyP0E8MK+bkjvDsg/pjlPAAQWZ/nwcV8vJQOJH3UrU8eZRTbJzPCmFKgnXjThpcqvmhO0Ombo05RNmUEUPNNDKuba6OHd1fcuc8JDcfMoBsr68SprKo+KvLiu9hBR7UKgBwyTX4NWGx1SEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGj7iS3m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGj7iS3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8508F1F0089B;
	Mon, 12 Oct 2026 08:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791794485;
	bh=I824b3dF57Lz5uC93EXnwibHqvkV8N6lhYn20jcXpec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NGj7iS3mZ90UWH3dEwrIVGUCJfSsCwjSCZJb8hwr53ZrOqjimuvL44pA3XLCfSO90
	 ZbbrlIsaB3feqftGDdwVWR/8Tojst6pv0tHLIYrTMsjsobssaYAzdqihkD8AhZ3yqn
	 JU1+suv/wHC+p04sg9Q18zm1lG4UAyrWCx9KWWr/vfgzVQpqYA+pDRtIfm8KvQi3l3
	 F/ugcQw25tx01mIsUPGn4M2HoRQBu+1dhJ8AuhasRMca8MiNonrnLtNtgSSiN6PMn6
	 MWjTtBwxMHOj8iBuPq5id1tDnWJ9MSddbX6OqkKuI40VuepyfspZ56TsDkFpGz7o+0
	 IGXr+w4A4d7Zg==
Message-ID: <sashiko-outbox-167856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] irqchip/riscv-aplic: fix asynchronous probing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20261012-aplic-async-probe-v2-1-868d7684c9d6@mobileye.com>
References: <20261012-aplic-async-probe-v2-1-868d7684c9d6@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 08:41:25 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] irqchip/riscv-aplic: panic on writing __ro_after_init atomic varia=
ble during late probe
--

commit 85f19d2af252a4bd94c9b2ae22ff4a1c3d7ce27f
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

irqchip/riscv-aplic: fix asynchronous probing

This commit replaces the boolean flag with an atomic counter to prevent a
double-add race condition when probing multiple APLIC instances
asynchronously.

Link: https://lore.kernel.org/r/20261012-aplic-async-probe-v1-1-4c2c4f5b091=
6@mobileye.com

> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq=
-riscv-aplic-main.c
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -116,14 +116,12 @@ static struct syscore aplic_syscore =3D {
>  	.ops =3D &aplic_syscore_ops,
>  };
> =20
> -static bool aplic_syscore_registered __ro_after_init;
> +static atomic_t aplic_syscore_registered __ro_after_init =3D ATOMIC_INIT=
(0);
> =20
>  static void aplic_syscore_init(void)
>  {
> -	if (!aplic_syscore_registered) {
> +	if (!atomic_cmpxchg(&aplic_syscore_registered, 0, 1))

[Severity: High]
Will this trigger a fatal page fault if the probe is deferred?

The aplic_syscore_registered variable retains the __ro_after_init attribute,
which places it in a memory section that becomes strictly read-only after
the kernel initialization phase completes.

Platform driver probes can be deferred (for instance, waiting for an MSI
domain) and run in a workqueue after the init phase is done.

If a late probe calls aplic_syscore_init(), atomic_cmpxchg() will attempt
to write 1 to this read-only memory page, which causes a store fault (or
AMO fault on RISC-V).

Does the __ro_after_init attribute need to be removed here to safely
support late and deferred probing?

>  		register_syscore(&aplic_syscore);
> -		aplic_syscore_registered =3D true;
> -	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-aplic-asyn=
c-probe-v2-1-868d7684c9d6@mobileye.com?part=3D1
