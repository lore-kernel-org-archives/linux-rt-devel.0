Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8443630215F
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Nov 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786584; cv=none; b=W4p0RZOS0fUAt1NvrRPlgs7tfwHpsOnK0bC4hiszMh2W8d72EEW2vrO+SyWH6VfFsO0FUzZyDABjmefHme4X6lrFvxX3GaclNHAurYabNFDSiYjqeVi2A9AnXaH7uhzPf33z0LkfYsMD4cAg+9LZMnBNoe4LfkXqTeL28Swkudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786584; c=relaxed/simple;
	bh=gvuphkX9MVwqb9yuTMDHMD9PJxkH/tN5jxv46FJiPWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4imPJslGT+MW1vYk5jgABaaNZ4d8+2YSP3PdFQ6z4BaNwYPUAzkLjd8o5mWHYoU5hhKCe+8m78M145CTs/r4mt7KMVQ/Aw8080cy2j8d8ycjmu7FjTH2k/GcRUTHVFMpLlCq03O5uhxAuRji7cuPR88aBhvu/PriyvlzahC3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JyC6l7+8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jspdRtBL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JyC6l7+8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jspdRtBL"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762786580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrUC7JbXBMMxZugHWu6/YK600YFH5JwP0FwRYQIUf/M=;
	b=JyC6l7+8FqVtcfYhbakSbUYu34GR7YTGq/u6DTGBUO6kpm1VLLA+XBgEFRI7a9ZrFMZNMn
	5KWAMu+p3WT6x+redLeV29EmvxnGyg6PGS1uCQ4L4eVrdnhq5ePAlewey9xfBNU3oM6eSL
	zlWbo58hQzt8CrzDaLtFysrBQoNx59l06sTGEVWRqwtDP8wD6oQ6eoZQysawwKSeWvEOmU
	p5n5z81HQ/IMCNYYivvSenGPrTOcK3PBx+YkuGDiFRsCUzX2q66FUy/pBKXphIY69gAqq3
	8qo/xcgDl94THVb9L+l6eidhu1fyHjY7yQL7Gi+opXS49WnPf+APrTDb7wPYlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762786580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrUC7JbXBMMxZugHWu6/YK600YFH5JwP0FwRYQIUf/M=;
	b=jspdRtBLEAWqyMHczz5EJhINO7IkTsLK18N72je4bPgEtwAWt3eTpiACZi4pj0+us84yPa
	huWf94jBVy6sYpCw==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 2/5] ARM: mm: fault: Enable interrupts before invoking __do_user_fault()
Date: Mon, 10 Nov 2025 15:55:52 +0100
Message-ID: <20251110145555.2555055-3-bigeasy@linutronix.de>
In-Reply-To: <20251110145555.2555055-1-bigeasy@linutronix.de>
References: <20251110145555.2555055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Yadi.hu" <yadi.hu@windriver.com>

In the !LPAE case __do_user_fault() is invoked from do_bad_area(). If a
user pointer cause the page fault then a signal is sent.

Sending a signal requires to acquire sighand_struct::siglock which is a
spinlock_t. On PREEMPT_RT spinlock_t becomes a sleeping spin lock which
requires interrupts to be enabled. Since the calling context is user
land, interrupts must have been enabled so it is fine to enable them in
this case.

Enable interrupts in do_bad_area() before invoking __do_user_fault().

[bigeasy: Initial patch/ report by Yadi. Maintained the patch and redid
          the patch description since]

Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 5d28c28e877c1..ad58c1e22a5f9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -218,6 +218,7 @@ void do_bad_area(unsigned long addr, unsigned int fsr, =
struct pt_regs *regs)
 	if (user_mode(regs)) {
 		if (addr >=3D TASK_SIZE)
 			harden_branch_predictor();
+		local_irq_enable();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	} else {
 		__do_kernel_fault(mm, addr, fsr, regs);
--=20
2.51.0

