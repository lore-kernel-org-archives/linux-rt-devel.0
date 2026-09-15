Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574512D7DD4
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433051; cv=none; b=g92/Jz5U0+afq0yS9RjoruHIxlrHHTMOAJ4lcFW7Cj4+kXLUaSjY/z6PzPx9xFQdlN1cRfHHLo/8xKAGjhkkZZjr0q1bHksd2q32KsQAPIlakS9ym2/Y4wRnKLNhgO33XJPrnyVE92CQ2+eVwKcMFqiymSB54mXhBcyULdOwn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433051; c=relaxed/simple;
	bh=Cam+G2pkyC1C2T5ka1nCaIH+HjFohyHCwADETRSirvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGmhPz68EwsH2vQjWfaHReNA+wO/Vh324+WPUbu+v8J8rIpK5P1F4X71fyKubgkpyCOFLkSIAIHTnPk31f1IRGe/2sRpW6i9rlRaS3VuKn7KXjPsibP2davCYK4yLQABDVP8QZ7gGHrNS8KIhg0BEzEPu2smAThS6Nxi+fBmmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7BgIfYD; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7BgIfYD"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b355ffso1581843b3a.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 14 Sep 2026 17:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789433049; x=1790037849; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pR6+8ahH0v/WhXkZabjYsMBMJZUya1nS7QcD3emiias=;
        b=P7BgIfYDJc9AahOmDHbbEQvK03igzQVxGl+92XgA2KEzbfDGU2+LwRXlsKaLcl6bTS
         SGHzMcTcdKiTIOxChapk6+2YGZ4KAubOlIfZ8WFDPrptKLM/6LdhgiZV2D1RvCGxgW4T
         h9FOk14iuXw/kbDdk8+ELO7jY4GOhkjqaV+sjPnEG6jTHaJVw8QTPedu0MfIS2rCeqqm
         FNicZnrBDvIEhC0bTPsnuGVNRd08KAU+PGwsIaTzfiZPqemIpGJ9RVsmFdbqM8ldGaq5
         gDav+Rli7HNXpdUH+YBstRuxNNI8K2UnxQ8BbNyMXNv9qgJP8cBAEIZAlvC72zj5QvCS
         n7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789433049; x=1790037849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pR6+8ahH0v/WhXkZabjYsMBMJZUya1nS7QcD3emiias=;
        b=yiIgcK/Lyi9f4b9Yt1mH2AAdYXx9oAX6++8VRqfbPB1BA/TRo3QK6ydQCU9dRQZ7hu
         v8LK89K2JFdSDEBHdPC4P0wZJnIQPoeWOzRglxHUs1n5JC0/3njFheNz4PaHehar/5cf
         Clw9/8mG6NLPy4a5U1u6CHx+mEexnMV3XYhm/3FqWavQj5ZIeLi6ZIOxkXgHWFSYpiUt
         SU7mdRikPYo+IHOGJf7YzB26L1QzkelK3VSaddJ5jb1esHwgLHVAmA4sbcOBpJTDHCIw
         6lMtK2bj0OEdXYEtq62TaIniG+NbhAbx8DlpJCPfsMuELr/xvOl5hcVcNdL3qwvBSO2d
         x34A==
X-Forwarded-Encrypted: i=1; AKwUvBxN4u8PXE8siaL/i8iiez87uyPcZdMXEcn3sHGPD+jXI6f/DGVcyHpkq/2PLlmJsez7OXj7rDrSRmtlRZjM8Q==@lists.linux.dev
X-Gm-Message-State: AFuF++maH+iONeUC6bukb7d0biQXB/BgojZKlvLp6CK+/PCx6FlQz4kW
	F/B5X8ObKTpie1fVDby9VO2NpYTJD4LroqVHagHOLC0YvIBPjU2soqFS
X-Gm-Gg: AYBFou2D5CscUo60BMCUvlecycVGrjd9UiWkPQX39wUcMstVMZw50uAwl5okpkQ6Ds0
	9wRA0Dlv+VX1IPaYxyOiqEOjPJzzCLrWZGjoYTbPcqJkFFEwyjWk6qdC9DGrnzhFxNBV3a+h+k6
	XmA7pnmMR7B3ZcCGD5a7rEZh4Ti52cNVllgeig7dH2BBxV949pcCJbnG0vDsuyQxqP6Q0Ym9hXm
	8vEd5cW93ono277Mz0z/CEPs5B305G61qjF6Q6Na06YdmLvAt7NKVM2UWMrFGb2d8K4fh/WIpWE
	i9qZ2UR4E+A7vI5sIkOu7lRNmr1kw5SQwfuJl+eAqRRj8lhDSRHZHyl+iqrgUlwSP/IM+2RD9bX
	2QK7Kb0CDYHZJrzRIB/8hjc16b3Du08DqgZeQyTdvZkIr78f52COrrOEQAicCYazXTLs910BAd5
	VfmW5p8bAOtqGUSuIWrISU0BCJVn7JCuJmy5Uww3ytVLOYEkwEgSjdeMl27SSjg8fjHjbr9ymHB
	yFQpQ6oR1E0Cx4cLqrtdPmotdFDQMmJNVi9yHMLcGFYEteKwbYcC69w6sCkApz1ulsjnb2AlsOk
	jGp1jWiDTzclP/VqC33aEiG/AUxrjzaB05jHa7ijzI2wVXu3
X-Received: by 2002:a05:6a21:3397:b0:3c4:3321:4fe9 with SMTP id adf61e73a8af0-3db4048a6a6mr12153286637.7.1789433048529;
        Mon, 14 Sep 2026 17:44:08 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c615bb00sm5927945a12.4.2026.09.14.17.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 17:44:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Subject: [PATCHv2] gpio: mvebu: keep resume masks within the irqchip cache
Date: Mon, 14 Sep 2026 17:44:06 -0700
Message-ID: <20260915004406.115230-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvebu_gpio_resume() writes the edge/level mask registers saved at
suspend time straight back to hardware, bypassing the irqchip's
mask_cache_priv.  genirq skips mask_irq() for a line it already
considers masked, so restoring a bit in hardware that genirq thinks
is still masked leaves that line unmasked behind genirq's back.  An
asserted level line then has nobody to ack it, and the moment
interrupts are re-enabled the chained handler storms, hanging resume.

AND the restored mask values with the matching irqchip mask cache so
only lines genirq currently considers unmasked are unmasked again.
Read the caches under gc->lock to keep them consistent with the
mask/unmask handlers.

Tested on Helios4 (armhf): 5 suspend cycles woken by magic packet,
no hang; mvebu_gpio_resume() returns in 6 usecs.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: Unlock spinlock before regmap_write.
 drivers/gpio/gpio-mvebu.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index c57758019e92..267e6d5bacd0 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1049,6 +1049,8 @@ static int mvebu_gpio_suspend(struct platform_device *pdev, pm_message_t state)
 static int mvebu_gpio_resume(struct platform_device *pdev)
 {
 	struct mvebu_gpio_chip *mvchip = platform_get_drvdata(pdev);
+	u32 edge_cache = ~0U, level_cache = ~0U;
+	unsigned long flags;
 	int i;
 
 	regmap_write(mvchip->regs, GPIO_OUT_OFF + mvchip->offset,
@@ -1060,32 +1062,51 @@ static int mvebu_gpio_resume(struct platform_device *pdev)
 	regmap_write(mvchip->regs, GPIO_IN_POL_OFF + mvchip->offset,
 		     mvchip->in_pol_reg);
 
+	/*
+	 * genirq skips mask_irq() for a line it already considers masked, so
+	 * unmasking one behind its back leaves an asserted level line that
+	 * nobody masks. Restore only bits the irqchip cache still has set.
+	 *
+	 * Snapshot the caches under the raw spinlock, but release it before
+	 * the regmap writes below: regmap_write() takes a sleepable lock on
+	 * PREEMPT_RT.
+	 */
+	if (mvchip->domain) {
+		struct irq_chip_generic *gc;
+
+		gc = irq_get_domain_generic_chip(mvchip->domain, 0);
+		raw_spin_lock_irqsave(&gc->lock, flags);
+		level_cache = gc->chip_types[0].mask_cache_priv;
+		edge_cache = gc->chip_types[1].mask_cache_priv;
+		raw_spin_unlock_irqrestore(&gc->lock, flags);
+	}
+
 	switch (mvchip->soc_variant) {
 	case MVEBU_GPIO_SOC_VARIANT_ORION:
 	case MVEBU_GPIO_SOC_VARIANT_A8K:
 		regmap_write(mvchip->regs, GPIO_EDGE_MASK_OFF + mvchip->offset,
-			     mvchip->edge_mask_regs[0]);
+			     mvchip->edge_mask_regs[0] & edge_cache);
 		regmap_write(mvchip->regs, GPIO_LEVEL_MASK_OFF + mvchip->offset,
-			     mvchip->level_mask_regs[0]);
+			     mvchip->level_mask_regs[0] & level_cache);
 		break;
 	case MVEBU_GPIO_SOC_VARIANT_MV78200:
 		for (i = 0; i < 2; i++) {
 			regmap_write(mvchip->regs,
 				     GPIO_EDGE_MASK_MV78200_OFF(i),
-				     mvchip->edge_mask_regs[i]);
+				     mvchip->edge_mask_regs[i] & edge_cache);
 			regmap_write(mvchip->regs,
 				     GPIO_LEVEL_MASK_MV78200_OFF(i),
-				     mvchip->level_mask_regs[i]);
+				     mvchip->level_mask_regs[i] & level_cache);
 		}
 		break;
 	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
 		for (i = 0; i < 4; i++) {
 			regmap_write(mvchip->regs,
 				     GPIO_EDGE_MASK_ARMADAXP_OFF(i),
-				     mvchip->edge_mask_regs[i]);
+				     mvchip->edge_mask_regs[i] & edge_cache);
 			regmap_write(mvchip->regs,
 				     GPIO_LEVEL_MASK_ARMADAXP_OFF(i),
-				     mvchip->level_mask_regs[i]);
+				     mvchip->level_mask_regs[i] & level_cache);
 		}
 		break;
 	default:
-- 
2.55.0

