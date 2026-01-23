Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717ED3EBF16
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168246; cv=none; b=TrUnacJ4gqOE73tg0orrZ1y2+KX+RqLR8w2j3RgWzMSn7g38Z5lWgEewXbxF2kgluqJ9SuAW/qaNtbgc4gN5sdVvOsdW+T9VnXrS1IBjZAgtR896plSGVbVBM/zRwSNJpIfmO23GUCIzM+zNqcfNuUMr16zYWP7trs8Xfeaz6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168246; c=relaxed/simple;
	bh=7S6roLtR2ILWMTt6k1VjruCZla33TpE5dDkqi47ng2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2bi9soF2TeLB/eEXHK2Hv7kxWZd1QjPnFXJGxpd0q5LJG0TdKabmlKv0RH5T226C3K9qcjiJkZDLNikq66+XZXuSOfyI1wHT969PnVNQX3JqjgGLXoEY7iblLoZ4KOVmwfIxVpeqyhqDSpiWavPFn7SrDDzatSSStjDCuFQK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FoM/+mTv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/FqJyzLi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FoM/+mTv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/FqJyzLi"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuGZdWBY87PO10lLpZUmYDO4z+8I9ptGVyLBptz6r3Q=;
	b=FoM/+mTvXQh+IlIjj5sQr2L+31X8A7ne6u27SqaGMbvmf0C2n+LUMwcJMiY5kUWsTMQOJr
	EX3df1nkEdWwWUKLREBzXRLAi3YoUcLDF7Tky7F+GCXhTlXCv+cL1XPgcRKuFFSEr3MF8U
	H/VHJZRF4AhhQwSTBgjsywbOIS5aU6aDlyRAwiRJVrdqhTH5aFKO7vL19SF3WzU0vzUCSL
	TjF7Snin0kI1SLHapcQy13ydgeqRR5GGQzNSncGLP7Y96WRnXV5SGzv+Yqvzal7e0WpQnP
	4D2Ru5/8b7/vfMtNke/MowoF0tAebuBlOwKyuYQSehS4hAfanQABhMO7NoXo/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuGZdWBY87PO10lLpZUmYDO4z+8I9ptGVyLBptz6r3Q=;
	b=/FqJyzLipZ2EWyZRKLaLuPjj7SWd4p2VwnGnaXolZfN6wtB99EmsXIlLdjo4XinbVgMvSR
	lbjeGqTOAXUxagAQ==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	patches@opensource.cirrus.com,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 17/21] mfd: wm8350-core: Use IRQF_ONESHOT
Date: Fri, 23 Jan 2026 12:37:03 +0100
Message-ID: <20260123113708.416727-18-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using a threaded interrupt without a dedicated primary handler mandates
the IRQF_ONESHOT flag to mask the interrupt source while the threaded
handler is active. Otherwise the interrupt can fire again before the
threaded handler had a chance to run.

Mark explained that this should not happen with this hardware since it a
slow irqchip which is behind an I2C/ SPI bus but the IRQ-core will
refuse to accept such a handler.

Set IRQF_ONESHOT so the interrupt source is masked until the secondary
handler is done.

Cc: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: patches@opensource.cirrus.com
Cc: Mark Brown <broonie@kernel.org>
Fixes: 1c6c69525b40e ("genirq: Reject bogus threaded irq requests")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/mfd/wm8350/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/wm8350/core.h b/include/linux/mfd/wm8350/cor=
e.h
index 5f70d3b5d1b1a..097ef4dfcdac8 100644
--- a/include/linux/mfd/wm8350/core.h
+++ b/include/linux/mfd/wm8350/core.h
@@ -667,7 +667,7 @@ static inline int wm8350_register_irq(struct wm8350 *wm=
8350, int irq,
 		return -ENODEV;
=20
 	return request_threaded_irq(irq + wm8350->irq_base, NULL,
-				    handler, flags, name, data);
+				    handler, flags | IRQF_ONESHOT, name, data);
 }
=20
 static inline void wm8350_free_irq(struct wm8350 *wm8350, int irq, void *d=
ata)
--=20
2.51.0

