Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111333CEB7
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168240; cv=none; b=mqofyUalSfZn4QbX4fa8RgSibbZdC7NTumj7IfbpB25gvwdKQnYaYZ8fhhIUwCbKsb3dlWvx0STIrZcDiBGTaMLCLWqomMl9VSLLjGgpixLmJd8YDSOsfwHHqpVNcQv7Pnh6eESWfJcn9TxRj9LztO1vvESSxYsLcBjoZr4SEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168240; c=relaxed/simple;
	bh=xIG6dgGL0m2Ob8S+jn/+Z8aqjE+CAR5xgYoV0lQuUJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFUAaFJ9WIOUXoBnsVhvbdmqEbAprZpFiPAZaOpPx98WeXxYVkWz31cRGq5d1OM+SCPBRNiNR94m+jZRyQlxYmJz4k6x6bw/F7s0UzmXK1EDEjbB02gHwIIBY4jFLaTI6HXtQ2PcVW4EdKRxRkTzqiPxDO7reY7k6IDkSEF1a24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0OU2dkMo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6o9/+xdX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0OU2dkMo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6o9/+xdX"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWni5HW99nwatLe3bFxSkgJ092tCPIuDbEsFgoqJcfI=;
	b=0OU2dkMohdOjRwrZK6iO6qfrNE4FxZJc4SpwLNvy/5UjjIZ6HATJafTZi1s3O8yRcQKgRv
	HqtTaLCjIwZhHMCV5cFkE5NeAoRvrVz18Zw3lT3yghMM6ZgHgHSNpcSH8fF2cRt1oKpzUn
	kosVEx2qy66OIUCMmx+TaA6wn23hRO9fLG9xTdD2Akqur8X4F7XGhcv35LNXym1F+plyJe
	eMlcF0c3ChPfACaHa5awZtwncB97PtPH+U5wOs3bhlkGLvUdwpHhOvrOwO52GMotDcefvD
	fQtlN39AOk5y12doT8FMmIyselSFlrn8ZZmn1vdryBKd9IoUGX0RoGVmAK7ntg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWni5HW99nwatLe3bFxSkgJ092tCPIuDbEsFgoqJcfI=;
	b=6o9/+xdXLJRHeZtviycF1Lb87SBxXuNkoulzn6XM+QHkLtf9hE78qmZQfjeLDMv7i/byMu
	2QXo8NGNkEaXBZDA==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/21] bus: fsl-mc: Use default primary handler
Date: Fri, 23 Jan 2026 12:36:51 +0100
Message-ID: <20260123113708.416727-6-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no added value in dprc_irq0_handler() compared to
irq_default_primary_handler().

Use the default primary interrupt handler by specifying NULL.

Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/bus/fsl-mc/dprc-driver.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-dri=
ver.c
index c63a7e688db6a..db67442addad2 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -380,17 +380,6 @@ int dprc_scan_container(struct fsl_mc_device *mc_bus_d=
ev,
 }
 EXPORT_SYMBOL_GPL(dprc_scan_container);
=20
-/**
- * dprc_irq0_handler - Regular ISR for DPRC interrupt 0
- *
- * @irq_num: IRQ number of the interrupt being handled
- * @arg: Pointer to device structure
- */
-static irqreturn_t dprc_irq0_handler(int irq_num, void *arg)
-{
-	return IRQ_WAKE_THREAD;
-}
-
 /**
  * dprc_irq0_handler_thread - Handler thread function for DPRC interrupt 0
  *
@@ -527,7 +516,7 @@ static int register_dprc_irq_handler(struct fsl_mc_devi=
ce *mc_dev)
 	 */
 	error =3D devm_request_threaded_irq(&mc_dev->dev,
 					  irq->virq,
-					  dprc_irq0_handler,
+					  NULL,
 					  dprc_irq0_handler_thread,
 					  IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					  dev_name(&mc_dev->dev),
--=20
2.51.0

