Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C222F388
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168236; cv=none; b=X9S8iA/eJ3s66/eCKDtFfD8uK1nV4S+U7GZgycEqI5eZ9+MFITvFX12wot5l5x5P414Q8/JJyWcUSz/JxORoEj/+g6m8JxKimLqC0afUIkL5gLP4QmSBcbRtTMJEmIk1LFg862bj3hxydJbQRVj/PKjHXHTb3dtZ2cai/XXby4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168236; c=relaxed/simple;
	bh=pxDvzW/pVOUQU8n6u562P10x1iLuIU8MLG6cyRa1vv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6hA0TuDIOvnjroiml1czyKNZMzBYt8+dUR5oJxaH8o2YFjyjDfosvs/JJddQ4QgDxHtcHhP0O9nQpU6qLU79p6zN7JqqprRdqHuKL+bD3nFQ4YiWYkOucE7RzUCaGN+ok8gdkuB6xY4e7VodAIdZzlwNai8jujdroTO5XodG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MWCm8TTM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F68G21bC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MWCm8TTM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F68G21bC"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gWhv7uil+ZrA4BjnDi6wJaG4CAtZeW3jyH4OtetMsg=;
	b=MWCm8TTMbsroYAhQTsn2dwRHg+OD932OEYI+9b/gUKmKPsrWboxv7f2f/QRIKGDGd1lrCx
	fWzVAQFr5JtuxcEHT2N/ER6Iu2VE9UqdztoOjGvG2ASf2gp9ulpA/eH7hs4VO4E0HDUqub
	CcQWllRdweDk2e/pRsT7KnNTnkwIbBobsCyVqZAUOqjR8XImNRdfvvW3OpZVAh4L/Sst1k
	Nvmeht+dNZDx2BFs16fOmiefEv8oBuyxMWjM/BanxMDdrwJLd8YdW8ZolpOLhg+IPL3KI6
	R4THLKAM4EaQJRTJl9BRWSF1x4DLtUrR48Xp9llD3xjaYDPY1vO4uwpMYykbsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gWhv7uil+ZrA4BjnDi6wJaG4CAtZeW3jyH4OtetMsg=;
	b=F68G21bClIKSFGH97x+i0sHYy9xJAMr/Z3glibNKXWvZOiAEtkcWwsJ6DQ0Pj+GrQhVdZm
	vO9ddwAdTaTl6kCw==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Subject: [PATCH 02/21] platform/x86: int0002: Remove IRQF_ONESHOT from request_irq()
Date: Fri, 23 Jan 2026 12:36:48 +0100
Message-ID: <20260123113708.416727-3-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

The flag was added to match the flag on the shared handler which uses a
threaded handler and therefore IRQF_ONESHOT. This is no longer needed
because devm_request_irq() now passes IRQF_COND_ONESHOT for this case.

Revert adding IRQF_ONESHOT to irqflags.

Cc: Hans de Goede <hansg@kernel.org>
Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
Reported-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Closes: https://lore.kernel.org/all/555f1c56-0f74-41bf-8bd2-6217e0aab0c6@in=
tel.com
Fixes: 8f812373d1958 ("platform/x86: intel: int0002_vgpio: Pass IRQF_ONESHO=
T to request_irq()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/platform/x86/intel/int0002_vgpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/int0002_vgpio.c b/drivers/platform/=
x86/intel/int0002_vgpio.c
index 6f5629dc3f8db..562e880256436 100644
--- a/drivers/platform/x86/intel/int0002_vgpio.c
+++ b/drivers/platform/x86/intel/int0002_vgpio.c
@@ -206,8 +206,8 @@ static int int0002_probe(struct platform_device *pdev)
 	 * FIXME: augment this if we managed to pull handling of shared
 	 * IRQs into gpiolib.
 	 */
-	ret =3D devm_request_irq(dev, irq, int0002_irq,
-			       IRQF_ONESHOT | IRQF_SHARED, "INT0002", chip);
+	ret =3D devm_request_irq(dev, irq, int0002_irq, IRQF_SHARED, "INT0002",
+			       chip);
 	if (ret) {
 		dev_err(dev, "Error requesting IRQ %d: %d\n", irq, ret);
 		return ret;
--=20
2.51.0

