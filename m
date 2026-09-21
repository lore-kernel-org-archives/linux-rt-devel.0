Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65EF3655CD
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970431; cv=none; b=jZlSeBvoY2iv/VQmKg+8mojJ6XYoOGAsMAv9rdSB/ZdpN0zFfwZqIzH5v5Eo1Cm8NG+2ztWXtqjtT8Y8Ib+q7YQ9SZT6aZcZ5j0e8YunLqn02JPTnxCPIz7yDrUAPwMcfRM8mCxdQsTZpMYvp8Nfr4OsI8XFFLvak29CJdYdRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970431; c=relaxed/simple;
	bh=AXpA8RvM6kawDldLMecY8xFEc9YXqrk/NMuGudPk2vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdcK+bDwCtaR3nBbsAy9d/RaphQTft/q1BYrpQrms6G9q+yPZagKquwuQmBLMWg+oKReVK4LeYT7zmVP70uUez3XBJwDPcNaCOzmeQN5APLf53MFKoGfXQvJCCCGrrBn5vaND2qHEOD+4ME49WTULh2oruaUtaYxb5VrE98kgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFDsIv5l; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFDsIv5l"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so18435675e9.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 20 Sep 2026 23:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789970428; x=1790575228; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bdaDi91QTKJpghjSNCi+hMWuT0eZZ+v0mEr89udI5Ug=;
        b=XFDsIv5lcXSA7XT9mOlu1ICveNEViXaD/KZKws544JwGXTUituAPdeXnWi6hfoiqN5
         QR36LQ/H+TQPfSYPfucfR/IunGoPETwioFyjInEAVXGNHiKTsKXtMkGWRam92mUwzaAQ
         jhS21Ysza/ldC6nTYsUa3jmvaWb42wCilJ/gI0K8Z9g3EnaJ96h+iGtA8afdpo2tl+XP
         LOJ2zBcjjz/Kf6AEbWF/6ojV6P5KRD5sMN2/uGmpfPN2zeNAwBWOOqxN2TFdTMdbfibJ
         cpx0JauuJMRxabD0CbP+Omuq5XNL+vqVD63Shh0eQu9LpvUCOuToGjd5lrrQWLrozNrK
         x9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789970428; x=1790575228;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdaDi91QTKJpghjSNCi+hMWuT0eZZ+v0mEr89udI5Ug=;
        b=N3JBvtMfHiGVE60TDMD2VOdgRGcm7+klcuza91+zdD9ft5gy9sMl85CnX7tX6kI503
         8M9lzXMwyI6BwDdmpkZJ4u+T0xrt+hLUfN3lNrjp1hfD29yxOfc5piXuRi5XV+lvmm/f
         wfzQFcKPvfczqdBR7meqWV4AOUADbGTS2uKGCA0pSZS2YK0E8gz+7jen+Yd+hHX26tV2
         2MAhKIryUEoWLgUJ9XKsbXYz/PRmjqixgSV4W9ZRUzVIWbyTzmfocbXlCb8/TIJ9gfll
         B7XxSeXTb7NB7Phgt+xgDt1dg0YjyLn26D6Ee/rpgj+u8p9e5WYAtaasJgFMQbyVxlep
         Li2Q==
X-Forwarded-Encrypted: i=1; AKwUvBws2zIupnLAn8YXu95RhUca6haeMExBYCLbKLY/mrlgO59Sj77CNXi/uQWqvju34x6C817VyFwUVR+JGpYpOA==@lists.linux.dev
X-Gm-Message-State: AFuF++l2j09cqEQQAGNRIXeOnaCdX11pW/Zv0qvq67aj08d7/sVACPrR
	drczNyP5YctSVR7vgcwVrsxFx1ZIXK4fKGiAiLlBEddVpcRankThTrPj
X-Gm-Gg: AYBFou0OlAAKQTdKdJscClpR0EX50Y+85Dsz0ZiFPweiVT+vBcv4pBS0bfJzNGAr07f
	bQIzXb8zbLVVGybqRyxw+tz84P9AmZBVJyVmQw6WH9jLby9U69iIUDlEBxWJaCMYVUORz+adW9V
	tD/MTKscMFcAwoL1L+iT/vuWJN6uLeEIYOmR0O57nlQWDT1dfbLk/AwWsYXnxHitbUfnjgqcLNo
	Hflvc7zV8XSBIOcU/hauEfSaLtSAqvbZ/T6MYOHxDR1rRNbwH1oWXx5sunHlQMV8tbVDujsQwmj
	y2ghYCYmxshTROjsTnMpLn78Ms9kH9jp+F+zTJNA04FwtPcY/yL9exJ147C6Hl+/x8ax7JJcko/
	///CDC721WYJxbmn0m+z+GYHahcVu7Aae9FYKEY/va58u6GCxQGMQtIRgG1hCEtONJUgzg2pmyp
	othM1n1slM2hRjGNlF24J3LIF7a7M51kw8BKYytHPUFWcTFoQuDYS2EuJU4hQrWcA9XE39Muhqy
	OpYUxGp++wpqYAwwNjDQ0NJb8CF8GSUeMWXQ0wEdT8xmzTku5zPgIED4R8PGjEjXWjl5qax8fQW
	H8OPD/wMDhNy0rr0lObfMjaBvofwkAMiqBBcUHHTXiHBkJiadAlU2mvcQOO4yFF4mGkaDEFBC4G
	Njk8=
X-Received: by 2002:a05:600c:46cb:b0:49e:660a:935e with SMTP id 5b1f17b1804b1-49fc586827cmr115985055e9.29.1789970427187;
        Sun, 20 Sep 2026 23:00:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-f941-243b-87f6-e5a2.310.pool.telefonica.de. [2a02:3100:a8e9:c501:f941:243b:87f6:e5a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd1149e0sm198706585e9.13.2026.09.20.23.00.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 23:00:26 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: cacheinfo: guard the CLIDR read in populate_cache_leaves()
Date: Mon, 21 Sep 2026 08:00:12 +0200
Message-Id: <20260921-arm-cacheinfo-v2-5892c4531ad9-3@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com> <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com> <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM1176 and ARM11 MPCore can be reported as ARMv7 by
cpu_architecture() even though they lack CLIDR. populate_cache_leaves()
therefore needs the CTR-format check used by detect_cache_level().

DT-based early allocation bypasses init_cache_level(), so its check
no longer protects populate_cache_leaves(). A combined ARMv6/ARMv7
SMP kernel can reach this path on BCM2835, whose DT describes its
caches.

Share the CLIDR capability check between detection and population.
Return -ENOENT from population when CLIDR is unavailable, preserving
the existing absence of cacheinfo and avoiding a new topology warning.

Cc: stable@vger.kernel.org
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20260912195552.76673-4-kmehltretter@gmail.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Fresh full-series rc1 retest: three builds and seven QEMU boot/CPU
hotplug checks passed; see the v2 cover for the matrix.

The detailed testing below was performed for v1, before this rebase.

Reproduced on QEMU realview-eb-mpcore (ARM11 MPCore, reported as ARMv7
by cpu_architecture()) with a device tree carrying i-cache-size and
d-cache-size on the cpu nodes like bcm2835.dtsi: with patch 4 and
without this patch populate_cache_leaves() reads CLIDR, which QEMU
returns as zero, so every leaf becomes CACHE_TYPE_NOCACHE. Real ARM11
does not implement the register. With this patch the read is skipped,
the boot is silent and cacheinfo stays absent as before the series.

 arch/arm/kernel/cacheinfo.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index 31591c947254..993c8a134786 100644
--- a/arch/arm/kernel/cacheinfo.c
+++ b/arch/arm/kernel/cacheinfo.c
@@ -80,19 +80,21 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
-static int detect_cache_level(unsigned int *level_p, unsigned int *leaves_p)
+static bool clidr_present(void)
 {
-	unsigned int ctype, level, leaves;
-	u32 ctr, format;
-
 	/* CLIDR is not present before ARMv7/v7m */
 	if (cpu_architecture() < CPU_ARCH_ARMv7)
-		return -EOPNOTSUPP;
+		return false;
 
 	/* Don't try reading CLIDR if CTR declares old format */
-	ctr = read_cpuid_cachetype();
-	format = FIELD_GET(CTR_FORMAT_MASK, ctr);
-	if (format != CTR_FORMAT_ARMV7)
+	return FIELD_GET(CTR_FORMAT_MASK, read_cpuid_cachetype()) == CTR_FORMAT_ARMV7;
+}
+
+static int detect_cache_level(unsigned int *level_p, unsigned int *leaves_p)
+{
+	unsigned int ctype, level, leaves;
+
+	if (!clidr_present())
 		return -EOPNOTSUPP;
 
 	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
@@ -150,11 +152,10 @@ int populate_cache_leaves(unsigned int cpu)
 	enum cache_type type;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *infos = this_cpu_ci->info_list;
-	unsigned int arch = cpu_architecture();
 
-	/* CLIDR is not present before ARMv7/v7m */
-	if (arch < CPU_ARCH_ARMv7)
-		return -EOPNOTSUPP;
+	/* The device tree can describe caches CLIDR cannot fill in. */
+	if (!clidr_present())
+		return -ENOENT;
 
 	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
 	     idx < this_cpu_ci->num_leaves; level++) {
