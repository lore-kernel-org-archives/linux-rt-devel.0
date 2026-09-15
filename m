Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A8F4A3863
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511173; cv=none; b=BDo81QAgwpMa/NZiU47Y55Myc2V2ck/7Ze2BysS5M9s4M/UoEgy3I8YcLzooy68mht7Xx4MGCGb5c1jTaDAcYphJ4TUYIW1WNzL/bt6pU4UhOHel005Vy9j2segNgKz6W/b8V3z58KR7VCleCTpP+GD8QcZdLMo4VVGdDnOpRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511173; c=relaxed/simple;
	bh=VQB79XU5ha3TH3L1StabFfXEj3XgXRoI6dRfp1doGPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqaMWja+i//oO+PzUxl43w0ngfDR/TjR4TAIs3fjArXHs0FihGgpZgOFT63UFXZZo5vteSsk6GgiVEigPUqCWItp/oqaQE0vWJt+rcPF+vMgJ4qXeKE/At4CbAc9ZKuxImCjJ6BGkwlgdf7OKMCBUXEN30INycTq58IFizf2zr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H72i8ofO; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H72i8ofO"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86212a185dcso244333b3a.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789511172; x=1790115972; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ozbdljbJWhuPCjAs3/0Yc8dEEkoSWPAnbLbDIm9pqjk=;
        b=H72i8ofOGYMP1BrWG2EO6VqSrRmhCcn4EQQq6+FgclEWNIrC5JA7eh7hlJkiQQ+C49
         TXDY09PN2fM8D7TWOJGoio0uFy41fMMJyeWOQdC8DfRvrUlIMgVY1t97g9qaL0aNGsTB
         xszD7nsNuf32X0/T816CIuy7JigaHnHk1H57vWUOVPt0igcWWupuDJJWBK87upMi1frp
         lgWCS8Dm9ul0hOdY3UbZSfQE07uJBnMHHmempWnwETNpKdGcby4F+HncBpgfZVW8NwiQ
         2M6W4DGklUN+VXSUDIIw1SmPU5yPY2rb8VGZn3Zg/wZuyeJa1q6o/UfMCJPh7pzlevwO
         wLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511172; x=1790115972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozbdljbJWhuPCjAs3/0Yc8dEEkoSWPAnbLbDIm9pqjk=;
        b=OJCjAEGuwqLtrzKQCC1UDPI9s//4uZ+zd2o+clIL8bODZxzFzZRggVz8bqKZreBWcn
         ewfX9qOPvs2mTG5htg23ABSmVVvOlumG99thLhUbiqb19AclhUZa1NTC9Thl8uWz+tbY
         13hO8IkaZiqtVIPSR53u5y7G901wym2TtW16634Z76/tiDc3+qNcXXa2nC8WnByTFvbP
         UsGJOYf4v4wPMHBD8A1a/0SFFOlHaucd7odJUr3QMUVl6g35qRyLNeD3iYzhsVUh627U
         3QuDWqEu/bvDsYB0J9AMRV2zc8R0tDAVxnlGZKatSkIcmSmggD+37ma+utzE4c+2E4uB
         IF1A==
X-Forwarded-Encrypted: i=1; AKwUvByMp3BeLqdeyxWoLeGE90NIjrz3mrE/domAPtViecjNbolOkydU8w8TUZvzpVTl6KDfLarxfb8e4K5Scla0wA==@lists.linux.dev
X-Gm-Message-State: AFuF++m7YnujUFIO/D3VqS8EOMq5RSRX8ZiNckGR/Giq8kJ8SJTCQsWo
	kZDHfFFzi4yiCHB7NTJonbvxBIrn73V7ogoYMpPAtkttyPMB3asoKz6W
X-Gm-Gg: AYBFou2oaauC4SMbl0mrLjh9uYtXhdgQSZ8OghZJmhGB7Z07z3H0nNZBlXOkt5pzBMr
	bzhIW4gZvC0OKd286xIIi8gJJ58GRk1l3vyGc/lQZkfshc8sFgq7Gz/QZv9DFkayN/9JKQdH+MR
	AWFJvGOSvLVHDb6QOT+w5Gu4LdkDxdbf+ncAh4LZpE6KSsu2H/8jcvgru0HwQoXfx1js6BzKDgs
	5qOK9kJFP4aitt8rrbkeRi2hZl3e0s7ryUt5t5bU4CaqEz0mzO7+T1DgH4nuA/lbQ8tEIOgA0H5
	RtprygNFZ+4YdIC6vR8pgt5kjM2d8U9Qy8oIxbCAwG3E5UQZFdOAd23RY3vPlq0GS6ZYdc2VBp2
	M7WIAkVVjFaXMzhvmDNsBwb7Na/Jd3HK9zGIPiNb7+IZXRWo84enxMhPoQKgxlb+rK1a9auXaDC
	gVrinFQ76uXruMUgSyvpCZbW6gsmk6Qfw10dA2y7TPsnkX1dH+Z9BVRchl8BqA8i7UnJVCylnCc
	YzVH0S6qR5vkhZw1KFcaZCLCpj5/LrEuWiANMmGYsVVNX1EBfTe5kmmSZIkJzi12u9h3qA3YGSa
	89D9fB5kM69nfAm61CgwljfwUoGNKY23OzbiEF0ebI+RYyBadXRvKOpPHlI=
X-Received: by 2002:a05:6a00:908d:b0:868:e11b:d859 with SMTP id d2e1a72fcca58-8723adb237bmr222206b3a.2.1789511171577;
        Tue, 15 Sep 2026 15:26:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-871febde2ecsm224189b3a.8.2026.09.15.15.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 15:26:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Subject: [PATCH] gpio: mvebu: use raw spinlock for MMIO regmaps
Date: Tue, 15 Sep 2026 15:26:09 -0700
Message-ID: <20260915222609.194216-1-rosenp@gmail.com>
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
---
 drivers/gpio/gpio-mvebu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 03e977c2a629..674feeb31774 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -598,11 +598,18 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+/*
+ * These regmaps are accessed from the mask/unmask handlers while the
+ * irqchip's raw spinlock is held, so they must use a raw spinlock
+ * internally. A plain spinlock becomes a sleeping rt_mutex on
+ * CONFIG_PREEMPT_RT and would trip might_sleep() from that context.
+ */
 static const struct regmap_config mvebu_gpio_regmap_config = {
 	.name = "gpio",
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
@@ -610,6 +617,7 @@ static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_pwm_regmap_config = {
-- 
2.55.0

