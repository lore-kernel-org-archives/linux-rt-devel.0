Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35DE34B1AD
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168245; cv=none; b=WThJNCiGhrGwgSTJ3DqkQ7VOTMe/QeJQAByS+xWpF9eOKPNUHbqpABGDiRiXLyFzbhI2Nss9VmIQGzwgO2WUgBAGuqY6cO7SpXTFXG61r07rYNk/BjFjLuYDoxB7/A1AXHmrQHHoQF/HmDFwgaOlmtxD4bkXxvQOlSt8sXYQg04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168245; c=relaxed/simple;
	bh=Ho2psf7/qNUddFKw3dQI1I0+XwQk++kQx5ZMVlv6P9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adum6ITdtATni54B/Ebx8fv9aMdffI4U26UvMm0oN1Ubt8JAaS15XHuUUBxryuu/MUJi6B4yNoqkTPwO399Bprkt8Fbq0mbD4duWZCiYSMltcgENi9jPgr+OGxp2xkFvWBj5TnNFHXMxhCljNxTAqg5q9vzCbEHJoD1kzhQ76Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o1R1Qecx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XHlcExbr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o1R1Qecx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XHlcExbr"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKAdw30kiS16YSJS+M2uj7rvfnRZHv16JtZKgorXgz4=;
	b=o1R1Qecxpa8p513yby3Xjp1M+Xvu7NpGugDC/ZDFV8uvv1NjymABPzIu0+C7SzY4pWb4XA
	cnM7+apZcLN+5unC26/rwzVIHYspLyPP/1jC4IcjZsaS5a0kZ508CUPIcJ8t0CGe/ruH54
	pI9SU1Q/gEjoJpRxo66lPEC4MB5HnIGp57lhZZGTRFruNcZxxIFpo67PGRLhk9hLq2XRyb
	/fCEi3UJiPrJylW+2Hl2W0xaoI+8SpYU7/Tkk/EdPA5zktHkZJjAnUnH1mocIgTlu8axUj
	goeBg1u8+eX1oMcRcilu+CpvhPYL/ZzyD31KT5Kt59dNDP28oN8cBF9e1Ab14Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKAdw30kiS16YSJS+M2uj7rvfnRZHv16JtZKgorXgz4=;
	b=XHlcExbr1ZUWWUELsI9V+SIxudW4CmnAoNVyOn3XP3wiQl6HBAFF75KSFkdOuouykpGHBS
	U0WNmdeulZe6lqCA==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH 13/21] usb: typec: fusb302: Remove IRQF_ONESHOT
Date: Fri, 23 Jan 2026 12:36:59 +0100
Message-ID: <20260123113708.416727-14-bigeasy@linutronix.de>
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
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT from irqflags.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Fixes: 309b6341d5570 ("usb: typec: fusb302: Revert incorrect threaded irq f=
ix")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/usb/typec/tcpm/fusb302.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb=
302.c
index 870a71f953f6c..19ff8217818e7 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1756,8 +1756,7 @@ static int fusb302_probe(struct i2c_client *client)
 	}
=20
 	ret =3D request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
-			  IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-			  "fsc_interrupt_int_n", chip);
+			  IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
 	if (ret < 0) {
 		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=3D%d", ret);
 		goto tcpm_unregister_port;
--=20
2.51.0

