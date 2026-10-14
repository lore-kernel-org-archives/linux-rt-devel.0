Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284124F4021
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975197; cv=none; b=reVXaKtZX4lA/4/p6RciW1GXQzVHyEq3ej4iQeGZ/trL36RpRw1SKVJiKwLzNJW3+snZ9xt9eq08KY6/8d0tuJPcMTrrQdYQ8ssepQYmxASn7Y0jpaNjfC4+Xw3lMR1WLe+xf7Wqbvym/IK0mxYk/mKz5zyu892xJ9UUE5NCM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975197; c=relaxed/simple;
	bh=HNiwfT/GXOoN6HV1huhzttE4d6EUz4rjAhAD3VDXG9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuLmWrJaQXd0+LzOqqN1SOpO4b4hwi/MJ0QGqdCfNyehidMmim88mwXurG0EzH1vE0Ltj/q5cR632c6Vo+UbysmYEsaPk2ba+tCSoEKWdUtD1bvgT2PpXDEkFogqLzTJ7S8e2u/P4wnE15M+IV2qnjKMJtJpAUB/IoN+z0tCngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FE6zXOb1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Jtz5jgL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FE6zXOb1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Jtz5jgL"
Date: Wed, 14 Oct 2026 12:53:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791975194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Kygbp8cZypTKiQmO5xyQ6S7jVl/BhpU4TxaEVjtZwg=;
	b=FE6zXOb1ibNkTIYX9fkmtAKRCszNmJLjiHlLN/7PozaNiolBOlMji8xNG8cdJJsIRrJWXS
	7+2OljmQqPlWPszEsqldwe4K0uwCxkjrOkGJfmtyZf14gxsMDCS6ggognEGM/MqG9zKtCk
	03P+FK6hW2UDJfcHW54aLmZp5pgERv5ddfHPoiem9DGMWXSEse6ZV7uqj3JesrvwdfwUFf
	tcUXGYo+Rqh5gITtUGdWa4VsG7oxbrJg1/laWgpZDhAYTc788Gu+5F/mZVRrZzxUZ/B0ra
	lF+tLDkLNHrTbv2H/nqyGPSq1OP5sBYQPquBXKKA0f4uYbD6P6FFn5fgwz+ecg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791975194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Kygbp8cZypTKiQmO5xyQ6S7jVl/BhpU4TxaEVjtZwg=;
	b=0Jtz5jgLsKOaOlDQ7uCL0ljyUcsUiyj6k2yO7j90IAm+/pYt0CVoOyUVkS+tRMGavuCqGw
	bfK8Pepdy+qwvBBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
Cc: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jessica Liu <liu.xuemei1@zte.com.cn>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3] irqchip/riscv-aplic: fix asynchronous probing
Message-ID: <20261014105312.xNkvgkGg@linutronix.de>
References: <20261012-aplic-async-probe-v3-1-5cf52dc28690@mobileye.com>
 <20261013152727.2cUDX3l0@linutronix.de>
 <5a8048ef-a241-4486-adc1-440721d3606a@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5a8048ef-a241-4486-adc1-440721d3606a@mobileye.com>

On 2026-10-14 11:15:05 [+0300], Vladimir Kondratiev wrote:
> On 10/13/26 18:27, Sebastian Andrzej Siewior wrote:
> > EXTERNAL EMAIL: Do not click any links or open any attachments unless y=
ou trust the sender and know the content is safe.
> >=20
> > On 2026-10-12 12:12:59 [+0300], Vladimir Kondratiev wrote:
> >> boolean flag don't protect from race when probing several instances
> >> asynchronously. On system with multiple APLICs, if probed asynchronous=
ly,
> >> warning triggered as below.
> >=20
> > Why is this async? Doesn't __platform_driver_probe() set it to sync?
>=20
> Yes it does but aplic driver uses
>=20
> builtin_platform_driver(aplic_driver);
>=20
> that takes different route. Easy way to directly proof it: I boot with
>=20
> driver_async_probe=3D* dyndbg=3D\"func __driver_attach +p\"
>=20
> to request asynchronous probe and debug prints in the __driver_attach
> shows:
> [    0.236483] platform 48760000.interrupt-controller: probing driver ris=
cv-aplic asynchronously
> [    0.236513] platform 674e0000.interrupt-controller: probing driver ris=
cv-aplic asynchronously
> [    0.236539] platform 67560000.interrupt-controller: probing driver ris=
cv-aplic asynchronously

Does "driver_async_probe=3D*" mark _all_ drivers as safe and you run into
a problem where a driver isn't safe? Does the "dyndbg=3D" argument show
the driver is probed asynchronously if you omit the "driver_async_probe"
argument?
So the question is do we want to let it probe asynchronously or should
we force it to sync.

> > Would you mind providing a coherent description of the problem and
> > implemented solution instead of slapping console output?
>=20
> Sorry if it was not clear; shall I explain in details why pattern
>=20
> if (!done) {
> 	do_something();
> 	done =3D true;
> }
>=20
> is not SMP safe? Add detailed explanation to commit message and shorten c=
onsole output?

No console output at all. You need to coherently explain the problem
without adding console output. This is a simple problem, there is no
need to for a huge commit message here. Also there is no need for SMP
here as we do have kernel preemption.

> Reason for asynchronous probing is simple - to reduce boot time, it is cr=
itical for embedded
> systems. Think of system managing car rear camera and proximity sensors, =
it should be ready when you
> start driving, this lefts very short time for the kernel to boot.

So the driver does not support async probing and you add it and call it
a fix? I don't mind async probing but it should be declared what the
actual intention is. And maybe the driver should be marked async in the
end.

> >> ---
> >> Changes in v3:
> >> - drop __ro_after_init attribute due to write to read-only page concern
> >=20
> > What concern? That __ro_after_init can stay. It is built-in only.
> See comment to v2 by sachiko-bot$kernel.org here
> https://lore.kernel.org/all/sashiko-outbox-167856@kernel.org/
> quote:
> ---cut---
> [Severity: High]
>=20
> Will this trigger a fatal page fault if the probe is deferred?
>=20
=E2=80=A6
> Platform driver probes can be deferred (for instance, waiting for an MSI
>=20
> domain) and run in a workqueue after the init phase is done.
=E2=80=A6
> and indeed, aplic_msi_setup() can return -EPROBE_DEFER so concern is vali=
d and
> existed in original code, it is not related to asynchronous probing

I would not expect the MSI domain to be probed after kernel booting via
a module. This is the scenario where this would explode.
And if you consider this a problem you should address it and denote it
in the commit description as such and not silently changing it as part
of another change without any explanation.

Sebastian
