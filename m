Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF04915B9
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686566; cv=none; b=XlRsfCnJP5w4brypxvftV0YeKwm6GtCcRNdPXBYcIZA08L3+XPygfne8r941slh89L/JNPPxPTs+e+aBfmtsH1EDCbAZdeLsX8ECmDEiJ99lVY/8G3VezH8CvV2tpv/JUZGO2pSMLKiDHc67ZTr6jcPaPmrK5V4kqcK/tsCq8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686566; c=relaxed/simple;
	bh=bzi3qTltra6aIkH/Jy2yzrbQPmxGzlr79foFYbz7a8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ReGbRP45fTd7pNQhLkzpuYPUzz0vVASiFMpUNDAbISKxFgj0Y9YxMlG2+LEWNLlqlEX5DeORtg4Ug8FId/HJhL1dkfDsnfHEGQvvbyMDDRMtaRyJ4l5i3S1nWGY4O8+0/vYZMMOQLUXanbahPlO1ftuyGHWnk3zJIa8VOQkBeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0gd5qcj; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0gd5qcj"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eefae4so240445ad.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789686558; x=1790291358; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1U17Jog9ZY7djCaBaNRYmrySX0Lr3PE+x+SDEArIf+0=;
        b=i0gd5qcjB1sQJCoNBrggj/48YUCntazY8F2zgge9A+Yfdj4s/MuXharlKaEM04GY3d
         BN+04OTyeaVsP0d+oi7rwnnFYg8jGjfoTgTLK1Zt4S0K8mZe8/zJu6L361HI0IF8fQuG
         93ZAxottdZAhK3tntnv3HC2G5+eojmcq+8MLCLybV7vhLEy+LQSkaT0thopZhTrX/H0D
         o8q+AHMisX0q0KPzi92E2Rlv97L1oxpUZ5o48bEP1YWIBsbJDnLn3HUIDCX+wY/X4n5T
         dqxIy2ejYdt9+rJ5h1Cs+589Jz/qAk23SewK7S+XtTIn5EnB/R4YYF9PBCibiEsL1mTJ
         XC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789686558; x=1790291358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1U17Jog9ZY7djCaBaNRYmrySX0Lr3PE+x+SDEArIf+0=;
        b=U2px7P8jEp6MVaBQxljMcY5wAVO8lKzdcqttwv4lrVVV8ziJyEZdg8xY1Vnhs8pCte
         cs4N4v2/eK2pJNDbtZSPFm217zmOc6VaVSMUNTEHuMv1NZcvmsbQAV1Di96NCJkWpHuQ
         vKRrRYgg7WnRv9bz9OnvCPxCXcNNP1d9PM0so4a/doWJdJiBZGn+BAv43ra9jjShL+8n
         rFPTLG6Za4e04L9vLfh1EPkAcpK+BQidq2YrEMIekIL0/2OibvywZL23DIva5ppuLU4O
         D4CrQJhljsysZewNyMmJ6MTfpT9sN8M+1Y5dARX0AlczrBETkgdelgma+S5VNDe0lNVO
         ENmw==
X-Forwarded-Encrypted: i=1; AKwUvBxeV4V6bMiWOqgMYLUdO3mqFGKHNYlj5NGubsnxU/fvaVsrCnR+oAPKmxr+BCoaznuyZOMIm8Qddmyy58Uq2w==@lists.linux.dev
X-Gm-Message-State: AFuF++mSXzlqv62y+xJ0RexH1vqFBJwT9FR4TVD7zszLYs4OaYAiDwLR
	4H2NuaNpZlCdXZfXX2cO86pAmONd/SZFl3IdSm/t+pI0EJerOC8ZA4JA
X-Gm-Gg: AYBFou1X/mntSOtqZtQNXwsirycY7tKgUi1V+QX1ekyXmZDHQpbVglwhx8EQJDyaeuR
	jzqi/MiBWOXA2Eot6o1boLmOCuhLszHg7H/Kutba9N58C8JNay46XmEmVikYWPfMABAIz2Lvytg
	tCH/YhYrOAEA+9/xZ0PYfcJqaFMBQ9Ia39Qs6eMFBJjPXYc1o1LqVm04m5dxZzQTipLFuXkZiSx
	VolPG92bXxDTTdgxyQw3OTvf7CRot7rI6tCkhbZkhqiUi4OKTBTb25ai1fO2tgylprfskxIP+mI
	6cMaJA6wXI6ScCOOd9iWBhW5s/0ApG6y+aAcVQNASNzlCcxDg7eLyPXFuSvAmmFgNoPRGM241ZQ
	EktHzBPfw/N4mjPOWYWbTS4IFlR2HoqXjV/xzXVmPwm7Pdy8c8D1gTmVht0IYEiTCL/Vcmkvzba
	nFtUec3QGkJfQazFVrmRcVT7B+Ml7D5+k1fP+RdgriezaWHBIKuqIwtmGv9BVtlz4tMqBYNMaK5
	CsASMXsuB9HUEYXvTM8B0Cf0iAMpT0X2p+GDDmjUeQ2D7/u6wgcn58aYal8SZT0AAnrmCaJi+Ac
	s8wlVFWGVGNPw+2pZrY/ViZjCk0FfnpDMPiPmpaIElZ4Djdl
X-Received: by 2002:a17:90b:3b8d:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39e554cb74emr572733a91.6.1789686558386;
        Thu, 17 Sep 2026 16:09:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36116920sm7294763a91.5.2026.09.17.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:09:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Subject: [PATCHv2] gpio: mvebu: use raw spinlock for MMIO regmaps
Date: Thu, 17 Sep 2026 16:09:16 -0700
Message-ID: <20260917230916.118382-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mask/unmask handlers run with the generic irqchip's raw spinlock
held and call regmap_read()/regmap_write() on the GPIO regmaps. By
default regmap protects itself with a plain spinlock, which becomes a
sleeping rt_mutex on CONFIG_PREEMPT_RT; taking it while holding the raw
irqchip lock trips might_sleep(), and PROVE_RAW_LOCK_NESTING flags the
same nesting on non-RT builds.

Configure both GPIO regmaps with .use_raw_spinlock = true so the MMIO
accesses stay atomic in hardirq and raw-locked context.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 v2: remove inline comment
 drivers/gpio/gpio-mvebu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 267e6d5bacd0..92ce02441cc9 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -603,6 +603,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
@@ -610,6 +611,7 @@ static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_pwm_regmap_config = {
-- 
2.55.0

