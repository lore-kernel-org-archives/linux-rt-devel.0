Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF367342177
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168241; cv=none; b=WAH/4ve+6MTdj06zDT/9luRQka7qv8vHwEiI6rc3G7jguXG9m4iNyFZl5h7iDOuItHUhg7K880CNTIaxOPfsvdv3Vj3VKag6oOx1fMx23VbHi4Dz7xB5GjBIfMvKnQIarzIFZZ6yGO8ih3JDIAHjVkChNCpAX3aECwcwA70VCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168241; c=relaxed/simple;
	bh=BvOe0n0O3fEnxsIu8XLjoGVkrNv6ygwKM1JjrkTdmxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIEylX77kk57IIFgUNqC6/xZmhKTxshNSBP6CRHxK2w0UOpeCroPLrUI2u8Qjor2iwLtabO1mYfUeJle7d7156kCbp2YZv1T5FgfFDbYjNZFASKZE8TMph7cTyzqsDF9JZUKY3JWrgHUTpPmTOl3i3I31MeKdDkoKOz/nWokq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRzRWqEs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RS2ahJvm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRzRWqEs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RS2ahJvm"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+P2moe5wzk8LRVHukc5mSlFSGY5TZY+eBi1aBHfZZs=;
	b=jRzRWqEs+1UHDABQxWvpOcSiePWZ7aBRgE+gas1fCLx7SMu4d2ayl8tHp8WlGw0RSlZFbJ
	ARgoSlhgmqxElyelzzm+OMXG0mR9GKMC1hnhonAEMYF6AZ79m40KFz1RDzOpkgjRdGrSpx
	112RJbLRJisAzeONPgOYX4ZyJT5P93DK1P/C6YRDqgBEFO1l5SOCK1jdYfvnpvZJAcwrw/
	PTYRrTL8f4t9VkkeDd7X4LHMXNgKHuYJP4WTWBDF3upcGpk9XzvyLSolt5agsKkWonZdym
	Be8Hqus3JnM2eX9ZSncLldKVcYKCJNd+O5rD3pu0ykYbB2p5IxyrFEwu1tQMww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+P2moe5wzk8LRVHukc5mSlFSGY5TZY+eBi1aBHfZZs=;
	b=RS2ahJvmBQ08rqHwJV7WuqdTWNBdXb5J67V8PxIPWuBHyEz8vUJKxLWm4PPEvOxo0YKqEv
	f9X8FJCacfLAsDBw==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 09/21] char: tpm: cr50: Remove IRQF_ONESHOT
Date: Fri, 23 Jan 2026 12:36:55 +0100
Message-ID: <20260123113708.416727-10-bigeasy@linutronix.de>
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

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
 drivers/char/tpm/tpm_tis_spi_cr50.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis=
_i2c_cr50.c
index fc6891a0b6936..b48cacacc0664 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -749,8 +749,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
=20
 	if (client->irq > 0) {
 		rc =3D devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
-				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				      IRQF_NO_AUTOEN,
+				      IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
 				      dev->driver->name, chip);
 		if (rc < 0) {
 			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis=
_spi_cr50.c
index f4937280e9406..32920b4cecfb4 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -287,7 +287,7 @@ int cr50_spi_probe(struct spi_device *spi)
 	if (spi->irq > 0) {
 		ret =3D devm_request_irq(&spi->dev, spi->irq,
 				       cr50_spi_irq_handler,
-				       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				       IRQF_TRIGGER_RISING,
 				       "cr50_spi", cr50_phy);
 		if (ret < 0) {
 			if (ret =3D=3D -EPROBE_DEFER)
--=20
2.51.0

