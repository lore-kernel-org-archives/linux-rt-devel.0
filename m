Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6733D50E
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168242; cv=none; b=dIjUHe3wY699tQ1NemYWIe5Su4/+/B8X6ySjnFOAX/qQV6rmm3xYIWE4CAP2Ex6PYuxitIkp7ONFTi6hFRFvmyBRaV7Cj6EfbHIodlCV75g57ALGTQYc4C2eoHO90rbdVTfBlMSza3zpx13FWo9L/0zhgPCxzZKKjrA8QPi4mKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168242; c=relaxed/simple;
	bh=1Ei3iEDq+3ul52dgYpK+hoL434wuj42t2jzcLvrSW80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBzDXiRCuHTD1pIcKuCh0AqosYaD2HdyHbIaBdp0LxrbphGd29g/mVKRzvDCyDGOeRlJnAP31evAg9GJ7hqm+qZvMUEE7pgUEhnccFEqZs7d+WnLCiFCgI8TD/K5fMRrzCtVCeh4c0fd6eUmxopp4+8ZuzPZFzzzfx03Bf4jZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zffOZK+M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KOYwv177; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zffOZK+M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KOYwv177"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rW+PAWZxGnF9Ct2ExEsv2LYHIZ9WUP+SeTviE1CEkbQ=;
	b=zffOZK+MJrBMe4/16DzgMn02IFh1NGTwWSuZc3A6y3frjvDTWjkLG7VWunfUWnsDzia7as
	quCXNFgX3r3ZCD56XLbAgt0+UlDrojzHcbDdtg07HxtmeaKW+W/7sQnkbxdZoJPMSOkG4w
	Ap/boKIuWmq8x6qgjC13NgUIzCMx4FUroW4L7EVCoA8DmwDqehU+XNh9jUg5W3ioYKR+dl
	4rCtOnMEYh6SX8jk9Qhk3CaQWplcYCLzQWRAOdvuj0IBSXuU8iv7TI0REYHctVrHkFXQOb
	5fOhkjdvbLtkekvluCfiXgRogSQxnxOscQEf2ZXmZBYKge+TpZOsNGbRbCoCKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rW+PAWZxGnF9Ct2ExEsv2LYHIZ9WUP+SeTviE1CEkbQ=;
	b=KOYwv177IAVesLbfPWb2vMFuU+K1PnUs5QaCQ2xKmM+aoDfRPHS/+8jtMQwteTN2CPJiT0
	cM5NBEY7NonIRYAg==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/21] ARM: versatile: Remove IRQF_ONESHOT
Date: Fri, 23 Jan 2026 12:36:54 +0100
Message-ID: <20260123113708.416727-9-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.

Revert adding IRQF_ONESHOT to irqflags.

Cc: Linus Walleij <linusw@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-versatile/spc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-versatile/spc.c b/arch/arm/mach-versatile/spc.c
index 812db32448fcd..2d27777a00d33 100644
--- a/arch/arm/mach-versatile/spc.c
+++ b/arch/arm/mach-versatile/spc.c
@@ -459,8 +459,8 @@ int __init ve_spc_init(void __iomem *baseaddr, u32 a15_=
clusid, int irq)
=20
 	readl_relaxed(info->baseaddr + PWC_STATUS);
=20
-	ret =3D request_irq(irq, ve_spc_irq_handler, IRQF_TRIGGER_HIGH
-				| IRQF_ONESHOT, "vexpress-spc", info);
+	ret =3D request_irq(irq, ve_spc_irq_handler, IRQF_TRIGGER_HIGH,
+			  "vexpress-spc", info);
 	if (ret) {
 		pr_err(SPCLOG "IRQ %d request failed\n", irq);
 		kfree(info);
--=20
2.51.0

