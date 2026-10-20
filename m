Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495117;
	b=W7LWv3xg2wfhwjpzna9BchhX1jydO5djTUf9lVFetG+fhc4+js1InaxLyBxXgSAXMKU8
	 cITCzr6V+8KqE+x+WibVI5+NZNPPc59PELnyFZzSZWR9xI141W9kpmLTrflyc5UyALjYw
	 xVyABDEzam3MfRfRAGR18bff9zlu3PU1L+x781s7v4oX9ntLZ7ow01AZ7lxR/ndDJsgII
	 wk50algCqtk3CY6xYuHGryRcOvrSXMkiVGObA1xxosw96XcOL7/rV8UR8HJOkiWCMrR9G
	 KGmvh/uZD5BD/JshddwKS5EK5wB672gjVirw4/Lot7e827XAxz/lG+VX0A/NAd5SK9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495117;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yw7XTfTbHqXsstkS3PFcEfyss0ptRfGQdiDTiB2sp34=;
	b=XlS00pgbxBWEoUyj0KYbN+Q6RfAxwclkOkFYZHI5MGvwKcdG7Bkf60wcdhL5S1Rrz1tR
	 yT6MnK0RZYRUx/f7LAD4LiK3MeUmpr/2EjzCfLN3fa+RZWkE/N/5fbLECUj+uClQcGuz3
	 GG5p25a8/QxF4GOsSeL+bNviIuF57RnW0n+BEGAy0aiK9/J0yECx7xUS+r2Wr8wxU1xx6
	 KhABj8km77KRWAUlBf1HAV9U++S9qy7d5OxBa3bLrJTebxUUImVxUNavnNox7avEGoCyt
	 mdApcxRNihMrfaCsbo+ds66QZfvov16vsaYqzxYPdbeZbsTjVI5ibFnF7OhUBWmYe2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfN5WZbR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AB606A31C;
	Tue, 20 Oct 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfN5WZbR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D531F000C4;
	Tue, 20 Oct 2026 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792495116;
	bh=Yw7XTfTbHqXsstkS3PFcEfyss0ptRfGQdiDTiB2sp34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfN5WZbRQyDb67PXuDsLgqUm0MSX3ck+69MapXqVVLWJqcFqCCfJgy71nJmRIyxrh
	 iJ33nkno9u/fYreDp/0cB9GjvfaV2ZhbKkTrl9Fxbq3rfX60JX0eGSnoUP7+pZAcpo
	 Xbg8jWocl0jvK783KYQgK8JXPaKtuUxT/Ab4hxoFUgDy96mHOWO7N9/QSMFmXoYzMf
	 WyxPuGCfc+dGqNQ8vV/E8pyxCfgaZtXdYAVe0AGvGrn71rBGeF5scLKdNHjOYx0ku3
	 ZBhduqKzAXKA7ZreMVWQjCL1K9gZFVt2NJY7l3qQ2hKAOLtrycjqtXb+Ld92+I3DHT
	 upZWCQ5gHXlLg==
Message-ID: <sashiko-outbox-178890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] irqchip/riscv-aplic: fix asynchronous probing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261020-aplic-async-probe-v4-1-68bc35e0ece1@mobileye.com>
References: <20261020-aplic-async-probe-v4-1-68bc35e0ece1@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 11:18:36 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] irqchip/riscv-aplic: unsynchronized global state in aplic_probe() =
async path
--

commit 6da3e6c23904896b41105f01bdd39cd511ef2b88
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

irqchip/riscv-aplic: fix asynchronous probing

This commit replaces the __ro_after_init boolean aplic_syscore_registered
flag with an atomic_t and uses atomic_cmpxchg() in aplic_syscore_init().
This ensures syscore operations are registered only once during concurrent
asynchronous probing and avoids writing to read-only memory when probing is
deferred past init.

> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq=
-riscv-aplic-main.c
> index d9afb6ae98cf5..54e1d5602f15a 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -116,14 +116,12 @@ static struct syscore aplic_syscore =3D {
>  	.ops =3D &aplic_syscore_ops,
>  };
> =20
> -static bool aplic_syscore_registered __ro_after_init;
> +static atomic_t aplic_syscore_registered =3D ATOMIC_INIT(0);
> =20
>  static void aplic_syscore_init(void)
>  {
> -	if (!aplic_syscore_registered) {
> +	if (!atomic_cmpxchg(&aplic_syscore_registered, 0, 1))
>  		register_syscore(&aplic_syscore);
> -		aplic_syscore_registered =3D true;
> -	}
>  }

[Severity: High]
Does making aplic_syscore_registered atomic fully protect the driver during
concurrent asynchronous probing?

Before aplic_probe() reaches aplic_syscore_init(), it invokes either
aplic_msi_setup() or aplic_direct_setup(), both of which call
aplic_setup_priv() -> aplic_pm_add().

In drivers/irqchip/irq-riscv-aplic-main.c, aplic_pm_add() inserts into the
driver-global aplics list without holding a lock:

	priv->saved_hw_regs.srcs =3D srcs;
	list_add(&priv->head, &aplics);

Furthermore, when aplic_msi_setup() returns -EPROBE_DEFER because the MSI
parent domain is not ready (or fails on another error path), devres cleanup
runs aplic_pm_remove(), which deletes from the same global aplics list
without any lock:

	list_del(&priv->head);
	if (dev->pm_domain && dev->of_node)
		dev_pm_genpd_remove_notifier(dev);

Similarly, in drivers/irqchip/irq-riscv-aplic-direct.c, aplic_direct_setup()
performs an unsynchronized check-then-set on the global
aplic_direct_parent_irq variable:

	if (!aplic_direct_parent_irq && domain) {
		aplic_direct_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
		if (aplic_direct_parent_irq) {
			irq_set_chained_handler(aplic_direct_parent_irq,
						aplic_direct_handle_irq);

			/*
			 * Setup CPUHP notifier to enable parent
			 * interrupt on all CPUs
			 */
			cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
					  "irqchip/riscv/aplic:starting",
					  aplic_direct_starting_cpu,
					  aplic_direct_dying_cpu);
		}
	}

When multiple APLIC instances are probed asynchronously at the same time,
can concurrent calls to aplic_pm_add(), aplic_pm_remove(), and
aplic_direct_setup() corrupt the aplics list or register duplicate CPU
hotplug states?

Should the driver-global state in these paths be serialized with a lock, or
should aplic_driver set probe_type to PROBE_FORCE_SYNCHRONOUS (while still
dropping __ro_after_init from aplic_syscore_registered to support deferred
probing after init)?

> =20
>  static int aplic_pm_notifier(struct notifier_block *nb, unsigned long ac=
tion, void *data)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-aplic-asyn=
c-probe-v4-1-68bc35e0ece1@mobileye.com?part=3D1
