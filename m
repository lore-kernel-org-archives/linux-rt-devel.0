Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424613EBF16
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168236; cv=none; b=lJhjoemGpksbQpLmYo8YJ3SM0V/o33KBnASCJfe0AK2Kd3Vimp4F8I3COHRwma9F5ufQOdKgQffKrC7ak8ofkfpHgdjTEzv6P1+nDQi+FvP6Q6s6sJZULPEV//WWdNeUbPf22oZJfncH86niCdWwhvpiMi/onSWVp25sWgkBAkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168236; c=relaxed/simple;
	bh=0T9YK4QomM3Dxh1mFq3uLRSslv3jN/qUBwVPAGAXrcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDmTafu5Pfnv8SiEh4y64NK4eCO8UDZCXLsjcRC9wPTAeoc2HQ7M++lBT6bIp0hKuyv+py+NYOaOmFApgjPILjlWaiEGM8tkkiAsPL7g4XcGH+f60LtAZlymde97lnT0wU+VMJV071we2TUy0S5DkX5q7Kga1hecXKr8GAHe6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1M+IPCsk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XDHz7ig4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1M+IPCsk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XDHz7ig4"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CblLaGRlYRdZTje1I1cOH83wRmRSkpl00w4rAJW+2c=;
	b=1M+IPCsk0rvY3ycS4N5OON8pEZcs6609qd6tOB6l7AZEIbcJh41hz/hkhh+M2eWp5mKead
	TFgHR62vYjwLdrrZ/dAMAIMJzpdfft2kQ9oWWhOAmf7qaO4XLBhg9sOaPJsFQv7zgc41Y8
	k2BPQweryHJrYbwmXxPzbt0STkJ0YEt0sB8PUp62bgz3SiPo6w0EaripSxZFVSYzpShXcy
	Cdzhgykt//h+nb3o8GxwoPyIOsk25oX+YV+mmc3QvHTHzQkLIcY1tPwv4QMs9mSLZmRisL
	59RQvV5dSShbClsVoS7EwmN/1GbRi3T61WDDH6hzR9LOxOlZu2NIfISXZZ2y9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CblLaGRlYRdZTje1I1cOH83wRmRSkpl00w4rAJW+2c=;
	b=XDHz7ig4Zj8t8Hz+ancMYbiJ3l4OODiVf4FA8CqHVvmI9sGgva+RYcHV/4GzG4NBXo5VIN
	FTXz9B6na+bBd+DQ==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 01/21] genirq: Set IRQF_COND_ONESHOT in devm_request_irq().
Date: Fri, 23 Jan 2026 12:36:47 +0100
Message-ID: <20260123113708.416727-2-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The flag IRQF_COND_ONESHOT was already force-added to request_irq()
because the ACPI SCI interrupt handler is using the ONESHOT and it
breaks all shared handler.
devm_request_irq() needs the same change since some users, such as
int0002_vgpio, are using this function instead.

Add IRQF_COND_ONESHOT to flags passed to devm_request_irq().

Fixes: c37927a203fa2 ("genirq: Set IRQF_COND_ONESHOT in request_irq()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/interrupt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 266f2b39213a0..b2bb878abd113 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -228,7 +228,7 @@ static inline int __must_check
 devm_request_irq(struct device *dev, unsigned int irq, irq_handler_t handl=
er,
 		 unsigned long irqflags, const char *devname, void *dev_id)
 {
-	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
+	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags | IRQF=
_COND_ONESHOT,
 					 devname, dev_id);
 }
=20
--=20
2.51.0

