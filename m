Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F138F92F
	for <linux-rt-devel@lists.linux.dev>; Sat, 12 Sep 2026 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242969; cv=none; b=oXA+BURW+QSj+QoQfoy7qjkRMNQGYDGaEePVQQxdUE2NXA7qKl5BGY48eCOtVG4jz3cgYIYm2IzyQ863Lf1N8fmyTB8vSYN34W80kPsFv2yRvi1cdx6bpIIZaUAlA/b8eeXICFszkLRt1zF+NjL5s9UWsn/tJeziva01JBvw/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242969; c=relaxed/simple;
	bh=BdaqS2x93aAnR7qyDRmryncl463GVVC0Ab+SSxVjyQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2sE9lOkjXhdEOTrPrGCAUYT9/yrgzfYVIpazhHraAF8ZdPHxrPOcboiijmbO0+kEYMLvGtoEglrm2MxMYiFWzkc+m+vw7ni9r3GX/4W1vepxaPte+W/buDy3Vc8sLRCr2Gs/0WySaL+UvvbxzBcpf43PaJp03YY9KuE/7XTnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEv0/fsp; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEv0/fsp"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so3434555e9.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 12 Sep 2026 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242962; x=1789847762; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iv5Y9hzbKwVTvwjYbkj7A4OWiAYcXcebXQ5vuapgDoU=;
        b=CEv0/fsppBKSF3ohr4E+ZQEGF6qYM0QYixjpIS24kMTnQMy5OIaDy4kPa41IWoZ6C6
         8o1XH8K3BZE/hp3t+anVbZ1bvATfi+sJDJw7GTiz7cuCx6VmBulavmhbo7x3sl44Ge87
         0Nvf0WYnANHgZPJRhjPpJL+NYCoxky3Ius4xfmx1ecAqIfGXIMAYDRbsct1O3dTGg0P0
         Wbtpl29mp+iCvLnmP9Dkk08jEd7pWvkWCPFTIW8Zg8QravVNaZcn/gUYXMSryX/YqsOx
         NWdfGXfClKCsK6oPtjD+rSge5E6nq/Nb4u5zVBnluxWPuH6CRUUNTH1c3q1qlwo98wZ1
         v7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242962; x=1789847762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iv5Y9hzbKwVTvwjYbkj7A4OWiAYcXcebXQ5vuapgDoU=;
        b=c/SYeT2sHYBa/BD5/yw+H3BYMo/rqmT0h3ka09eOenJYqbdw5njVHfXiA9nOlIx6jS
         efCGarkueQF9/pQQqEb93orh8jp+y/z6Lmax9dvhcd82lbozuqKTc+1p4snnR5f/Jzk/
         s4fkqUeX7jmhW9VxyChUfkXV2C/9rBe8vRS2lkWUmXJ99+nrppU4fQ/nJ5B03mWnsFcJ
         z/CkaJvsSd3QRFK0/FXkBDwGmR2vhoTfJrcCoJ93pZT7ORa0bzZTfxGf4Nesg+aBvcOM
         2iVkbdgc8AhDfOC0DrGraKoU4dA+QxgXZ6Ov9eUdKlrCn1jgv34Y+hKDlUlJbZqEKoCO
         3RuQ==
X-Forwarded-Encrypted: i=1; AKwUvByKMgn7tqfZBWz9IiprpC8w2b0qRW/Ojss80ydaScr1culsxgtj2xF6JpWF241pAVz0KyAlsWHfb9PQMJUdEg==@lists.linux.dev
X-Gm-Message-State: AFuF++lOct1HFoJ7NSWlZnPW883k7s73ilGbYr7wrJ0W5t1aKgpnyHsy
	QVR3FBJYf9GaVN+J0i0UWP/36SPk+KJgPZIKpjr8cUFOWYLjeX6Ru0TY
X-Gm-Gg: AYBFou0KqoZbFiW8Q3hGheAEohHvUDA5YcSxlCNytip2RWp4BzIoJtAULOU0+F2kaUl
	fkkatCwDl+JVRpHpBfLV+oS1aQEjvNXeQlRCOVCmj/2Oh7f+hmG02uOsZhgB7mQ7lQjGVYloJBK
	cUqjQA3/VGR6WAIeqHvipRsgPJ/seW/T2aI1sCi2UifdxpCABanPN1Ox0X5ZJKCECTapmOqJnFx
	wLRI6fTQnv+6BJXV4q2GPlAeRBnZPs7ZioFLa1A9zoT/kJx5RTGTHJQAfrOs7T25Xj1+cykAIvM
	eB4xods8G89ralDP/1Js4pqcvfixyfLn9vN78NtNGXqqY/kOVQz+E6oCw5PQIeWVUah+gaGEyrU
	wdbO8AaXfAs8iAHhAnAY+NFbORVOf5HXmYyyPU+Sm+dYN7hwYYZaJ4QaQ6nDTRxgjKNaeOmrOH8
	OrnIv3TVxmBhk2U4Qf4S4iJeUIs1f25C+YczbpPeeyN+9Mf5IFaJsE+S90w33WjjsjXsGScfAy5
	otoapMa/YkT68dF55CdQxEGrRPKuZRaoPHQNxxI6OYUE61tCTYg863Z7zDdGF8tlB1o1c659yEG
	ziy6OKuEsOVyU6lu7o4Api7EnvoLd/jRtIlm1AYyG3s494InXojq9Iy1chC9HWg7diF48QmUtOc
	D14jJYHo=
X-Received: by 2002:a05:600d:4452:20b0:499:b65d:124f with SMTP id 5b1f17b1804b1-49e6198c2aemr79301175e9.11.1789242962176;
        Sat, 12 Sep 2026 12:56:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm267089045e9.14.2026.09.12.12.56.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:56:01 -0700 (PDT)
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
Subject: [PATCH 3/4] ARM: cacheinfo: guard the CLIDR read in populate_cache_leaves()
Date: Sat, 12 Sep 2026 21:55:51 +0200
Message-Id: <20260912195552.76673-4-kmehltretter@gmail.com>
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
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
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
-- 
2.53.0

