Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0A446829;
	Mon, 12 Oct 2026 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790987; cv=none; b=etUzTEw6TXH9R3QPCDZ3gOd6daXH9g9MT23vq3u897ncEVj6bbLWI/5ixCy93DRWQYOSC3x5UEmlBMAtuQY4JmvDARB2fxtymOxV29z6Vot/agkAp8yD+5hjZ4kaaP1CTzEPv+A0+JT9OFIK+FT2j+50xfbBJiUID9aL5pJs4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790987; c=relaxed/simple;
	bh=l7NGpp6l5Jhy9ff5ZEdlpTiAOPzxWC23JNIilD/yUIk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rzivQsXKUCRfIFIRW+Ii9FmDjPjVUwRowF0caexteSJkQzzJ59fdDJyduLDs4c+7X6uec/PzaPpZ+VzZSoVwSAM7eEXIHp/2CrqEqgozkDojqp1nfhtoKnFMJ8sS0OSJyr7AGHS/hbo9Fl/3IwPxyQXB1LlUzHl/J3G5gjBO2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv/FkQ7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv/FkQ7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF88D1F0089B;
	Mon, 12 Oct 2026 07:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791790983;
	bh=mr74o6+1/ayXBIrsRLQ8ORrof+ARTFn/xZpx7+uPfdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nv/FkQ7UBHm2IpusHcc1wWng5YR8TvyWBQ/hv57QbZZ0A7xD+FHdvVXEBH15UzXFi
	 8eVms9lHOeyfcBn4uR4O8QWwW9jDnSkwrqFfis8jQES/+W1AHSf0pcwmL/T4WEJ5YH
	 9Ef6VkBwlCoeEMHB96+XhMD8Zd98C9PLiZ2Ze0kQ/3K+OqeVfbafsWzgwwfb6Cxgxq
	 Yi5tqE9t0yZ7CT29livCahwlPi6edT+rpKvC9G1r1BapTYKhZVuFNc/Hi+stTthuVP
	 8viDa/u1rLSB8KN/DZ+VRsLf4c9GRsfmckj0eeDzM3e4GciiHVYxUv+IFW4tjbdtFS
	 xsLtMtVKHdqxg==
Message-ID: <sashiko-outbox-167805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] irqchip/riscv-aplic: fix asynchronous probing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261012-aplic-async-probe-v1-1-4c2c4f5b0916@mobileye.com>
References: <20261012-aplic-async-probe-v1-1-4c2c4f5b0916@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:43:03 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] irqchip/riscv-aplic: unconditional atomic write to __ro_after_init=
 variable in probe
--

commit 226fcd5ec01da9df7f8352eacfc1a2ef6a9d054e
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

irqchip/riscv-aplic: fix asynchronous probing

This commit addresses a race condition during asynchronous probing of multi=
ple
APLIC instances. It prevents a double list_add warning in syscore registrat=
ion
by replacing a boolean flag with an atomic counter.

> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq=
-riscv-aplic-main.c
> index d9afb6ae98cf5..db15ec8a2d346 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
[ ... ]
> @@ -116,14 +116,12 @@ static struct syscore aplic_syscore =3D {
>  	.ops =3D &aplic_syscore_ops,
>  };
> =20
> -static bool aplic_syscore_registered __ro_after_init;
> +static atomic_t aplic_syscore_registered =3D ATOMIC_INIT(0) __ro_after_i=
nit;
> =20
>  static void aplic_syscore_init(void)
>  {
> -	if (!aplic_syscore_registered) {
> +	if (!atomic_fetch_inc(&aplic_syscore_registered))

[Severity: High]
Does this unconditional atomic write risk a page fault crash?=20

Since aplic_syscore_registered is marked with __ro_after_init, calling
atomic_fetch_inc() performs an unconditional read-modify-write operation on=
 it.

If the platform driver's aplic_probe() executes after the kernel initializa=
tion
phase completes (for instance, via deferred probing or a manual sysfs unbind
and bind), writing to this read-only page will trigger a fatal Store/AMO ac=
cess
page fault.

While a first probe post-init would have crashed previously as well, this=20
change degrades the behavior. Previously, a second late probe would just re=
ad
true and skip the write entirely, whereas now it unconditionally writes and
crashes.

>  		register_syscore(&aplic_syscore);
> -		aplic_syscore_registered =3D true;
> -	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-aplic-asyn=
c-probe-v1-1-4c2c4f5b0916@mobileye.com?part=3D1
