Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203139185A
	for <linux-rt-devel@lists.linux.dev>; Sat, 12 Sep 2026 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242966; cv=none; b=uIf0RfbJkF4DN7Q/anyjQDFN4VUBumgHD+aHK62o7HknjlRNtL9G1lViXYbtbGC7m2LOTcv1wKoRe8mBISVrJfq/9RocUWY7SPm3J83rjVbcMrvVLFo4qIYqGQaUc67dZuh/KXBPKhlOB7UvEb8KhEI04orkLNnw4yN96yYzLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242966; c=relaxed/simple;
	bh=lambDYX2lwAsI5keUktYfmRvkhvX1OmYUKy53CnCprs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWlqGswZ0k39XZfS+/zvbJMA1arWkF5GlN+3pDSL1WVSSLS+AbLEF6bn8F5VzGLLWKNnDayIB+UXov/1jKeqscavn9tZicQaq1aDHAFnXjoX0WwnbkkgFD/Zyakigsf+mZ/3ZpDrVNfAYYMTQMB4PYXCwsM32DYh6ryu+oEB7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VymUNpz+; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VymUNpz+"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso7121135e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 12 Sep 2026 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242960; x=1789847760; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NwiXawn/cOlpKopFTshA1Oy47KkInxpQCTdPgG/ctyc=;
        b=VymUNpz+dFvZcuBFE7vEr8jGW6FzSwpKW0GaWjJCbUkCrS6PamxNWWeWe4/Ulxt6r2
         0lgrs/dTPTg5CUC1trCCKY4h4aw+7rItSM43wLVRTgHdULSCyK+Ll2BrkynFYfbkgDNX
         cE+ZOOP0bxmEcVC62Zu3G/dO8DloMJu0EtIXQ7QC77b9krQZSZ5aCzNYPFnYlnsxWojs
         Uw0XB98Zvpm7VByHGBS7isJ9KI44oEJKfXn9htFq0XB/uk+CXXB3jj7YPJeFe86voJ1H
         l3wnfe1TGfL3qVuF6xmpiYtmKkCf2hcWDD18Lrsnfhou8PC9vhgItH7h1L20AM3PMu3V
         5zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242960; x=1789847760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NwiXawn/cOlpKopFTshA1Oy47KkInxpQCTdPgG/ctyc=;
        b=mu8bK4zytEZQWb5JqoJ9A6d9gJVqAMdZCiJfDYLJ/jiOl9BSU2f1EQiKJ3oafc2QBj
         cbfnJJCwzBSOiOmNaGsxwmbiMSRyiz0VKe1JZ5kkTuBUkRlr67BDtupziP7AW9D3NSni
         xPd5+4hcsvAHh6RLmDyd06qqMTCbej7bM32V4BHD1gZX4YKkBZRnOLnENzP9KJrcZ1nz
         1/j7pS777ggWJ/AVXQyHtWlIjbAsWNGut/8Sy9Ozbl4sB6aIYlaZWh8l2/5EG/9o+lq8
         OGHUHqpCH6A+1ngQzYUh7cYp+A0IOjhABo/OqsAbCyKzrYyRDCDvp8M/bdjpefpzbASi
         wPkA==
X-Forwarded-Encrypted: i=1; AKwUvBye2NNAwZaE9XvfNtp5mxfQfkKQ7A4dpxq4ttOpXRacPAAUWA2gXfyt5QkyMEyTs2cGM/YsSC7vgA1ZRnPWKg==@lists.linux.dev
X-Gm-Message-State: AFuF++m6YZ3VWgXLfL7lvDDsEYgW+9p60uSM3Y8Z6h0WTzD4LaTw9iAK
	CHIHgEEdYUP34yT+FiRt54jcsXa/iXfPw5KO/ppImKVsgv3RxZ5I2maC
X-Gm-Gg: AYBFou12BG2biUXOpy36FUHqZ8quW0V4KdNyaex+wszn+9BTJtCydHEhU0ch4SC0aSY
	7AjrW/TjTpL+IN40C70cnCEEEv0awkLHvh3qZR6cbE8ww7whsoDvN2WXpiym/tJxl6t0T1GONjp
	dGWQbA1X2kSyx2HWXO+tSNd2BbcngU5FLOwL6P3NCnPfQysNv/1KBPNv4MhkDUSMefUdNHkXIHM
	Z2j7dRZiLk4VVeiP4DHIRpPzNi6Gzy0SZwOVI9t9xoHcn6MXknYmPAVPjydZlYV3yjd8jXuGM0x
	J/vxqkQj82VH0xC91OEH0kGvltw8r9fORHggJ8sY+yFYoE9ylhCDBNUEEtRo/g8roLKptG1/iVB
	7G/VsTtAvyLvWFDup71Oht+28diJZFke+bxvVu6nCNLtb+pPxzbZh+7t02Rks2CDO0fVN25bjhv
	lm7DttCloyN6ag3IlS8/os8MTVRshC/sjnfgAQfEGaXoq7QU52mC3hm8rHWixx5MwSnvhPq2ib5
	jf8TYGUBWcnblBObNmf08rl/kZjJ9WAlokFsBYKOSvSFj/UT6gqMyOXuuI2jnXWqyok8T3p5/h8
	0BVeLW92Nr51sd5w3FNzdFYhIYJ9ibv/OSURLjIwcGlZW7nqBJzjEJ7EY0sPv3r1YWETNnyVOeJ
	PSIqNDkw=
X-Received: by 2002:a05:600c:8b38:b0:49d:272d:74b4 with SMTP id 5b1f17b1804b1-49e619a1e56mr222951175e9.2.1789242959747;
        Sat, 12 Sep 2026 12:55:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm267089045e9.14.2026.09.12.12.55.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:55:59 -0700 (PDT)
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
Subject: [PATCH 1/4] ARM: cacheinfo: avoid out-of-bounds write in populate_cache_leaves()
Date: Sat, 12 Sep 2026 21:55:49 +0200
Message-Id: <20260912195552.76673-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912195552.76673-1-kmehltretter@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

populate_cache_leaves() advances its bounds-checking index once per
cache level, but split instruction/data caches consume two entries.
CLIDR-based allocation supplies enough entries. Early allocation from
the device tree can supply fewer and expose an out-of-bounds write.

Count each written leaf and stop before a split level that does not
fit. This prepares ARM for DT-based early allocation and matches
commit 875d742cf532 ("arm64: cacheinfo: Avoid out-of-bounds write to
cacheinfo array").

Fixes: a9ff94477836 ("ARM: 9433/2: implement cacheinfo support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The overrun was reproduced with KASAN on QEMU virt, cortex-a15, using
a device tree whose cpu nodes carry only d-cache-size, so one leaf.
With patch 4 alone the boot reports a slab-out-of-bounds write in
populate_cache_leaves(). With this patch the boot is clean.

 arch/arm/kernel/cacheinfo.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index e1469b641780..860eeb03cfe5 100644
--- a/arch/arm/kernel/cacheinfo.c
+++ b/arch/arm/kernel/cacheinfo.c
@@ -151,7 +151,7 @@ int populate_cache_leaves(unsigned int cpu)
 	unsigned int level, idx;
 	enum cache_type type;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	struct cacheinfo *infos = this_cpu_ci->info_list;
 	unsigned int arch = cpu_architecture();
 
 	/* CLIDR is not present before ARMv7/v7m */
@@ -159,13 +159,15 @@ int populate_cache_leaves(unsigned int cpu)
 		return -EOPNOTSUPP;
 
 	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
-	     idx < this_cpu_ci->num_leaves; idx++, level++) {
+	     idx < this_cpu_ci->num_leaves; level++) {
 		type = get_cache_type(level);
 		if (type == CACHE_TYPE_SEPARATE) {
-			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
-			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+			if (idx + 1 >= this_cpu_ci->num_leaves)
+				break;
+			ci_leaf_init(&infos[idx++], CACHE_TYPE_DATA, level);
+			ci_leaf_init(&infos[idx++], CACHE_TYPE_INST, level);
 		} else {
-			ci_leaf_init(this_leaf++, type, level);
+			ci_leaf_init(&infos[idx++], type, level);
 		}
 	}
 
-- 
2.53.0

