Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9930D3E7
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Jul 2026 04:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784694673; cv=none; b=dKv5cmHK7L5w+0mKcql6bQjVzlJNdFwpF0QnWxj3Ep8v+kSA82mJKamzDFL6SUu68L7BFw18ODVWCRC4fgx/A9zZVZqbWqlAY1aBb3jnzSmJPVw8Le572jinnYBOKu3YJ/iiqVDhC8qpVTIGL+cOmLUULMviEMhqUFiOKILoZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784694673; c=relaxed/simple;
	bh=MoFBOqjbdPllrAOMjyA3z1unmWUiWpJoQ6Sdq8yEmIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PPCU1TYp44MbZ3VPuuXbcKJ15FQnANrvYFCiEjzy+BfvZeWwYC+lBqLuHO+V7c8TenB+jTl7kaVOFUyY2o7B37N8Zp8OslPFYhLjeHGWYT8pn0i/ql2aGXnyXqJuw/aovF6tbRGWAr6JrQe/ci1oPF5zP4MDsaa0OewqZ32saFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfA7SCPE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfA7SCPE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49546c690ffso37304175e9.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 21:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784694669; x=1785299469; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cw+g8044aLFqtXGEWXTOBm0DvocPh9k56AtCHyZmPRw=;
        b=FfA7SCPEMgemx7ckHrms97FZvnIfbWXFAE8KuqUKw/k/R6x1iofg61tjXT6T2P7W5j
         OQa1SUlVnNrilgU5HmrLCqW9++XNTytbfy1oW7cDqyV4XGVe4XzsfdZ4bOlzKoMsF5vU
         OX8mdEdvLiSVnc/HJhCtsHn8sjy+pffOqQeQJMFWdPelKBAqXWZ9SAzIhH1xlNFxjRiT
         8KQjma1hCRjb32TFYyWFHunY0RWdMDQ+7sq3RR3kXnoNxG23Mv3fNFS1P6/LhW14Pz96
         l589AyLahKuI8wV1ffwog53Nhl1fiqBXYf1kO3sd90WmUO15s0RPHdi/j/JSqpi+gbB/
         c25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784694669; x=1785299469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cw+g8044aLFqtXGEWXTOBm0DvocPh9k56AtCHyZmPRw=;
        b=ZWPiWng2bWELesyuQDuEH+SdNVvu/jyjGfPGB1yFN12U1sCdbnGUuE8tSfZ1rfj510
         fSWwbUmzLj1zBHP085dsz9qlYFeaAFltBU3A5yPdj3TGFFzIBkh88xFMaGIhzWyyRu2K
         IckORLDe4FFWi+O8FI0P7wxNYKT8GY4n4uk0r98TEiKKcjS+FWXUZdH3igD5ULmkNvaI
         gm4fSiNf/D53k4X8oSfDI8/dn5iyAMFLJdnfJ0uEAFOQ85HekAfytciO45i/UAZp+cft
         n4y9RdQjGNn3Td34DTyakCb4ems41Sg5X+B3PFnT9YaaUdMWzEi4f8ygQ/XnwBREvQtP
         F0Vg==
X-Forwarded-Encrypted: i=1; AHgh+RqH6U12UXulVvOjJSfp0FOeQBg5Mxc9Bz7tVagc/glAwjDQCvLSxeSGLixsayuX6KUyVjjsszggujk1jubrVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9RImNomRboj/WX9+kaOOEPGRRRRKbhEMZ9RHwHDhdQighnWg4
	efCp0WSXade4XT8HOdX+Am2GSFEnTT7IF/ts9BUT9HZjpOPwPZ1fvxSo
X-Gm-Gg: AR+sD10A2Sp64dVuVddwnNleMyKNYzSxY6F68Z0wZ01q8sCUgSGZe4z1Q45stpggi9k
	zUCNzYTWKle+NssmeckGCB134/k4unP2zZyYdvlTf6nkeP48bmC1XzJUZql5lQn/fq3soRZ9+UB
	x8bunbWCOkS1UJEtFL7fHLPyLx10j6vBAD6w1ls8IHUbVINg0vuVWInAv7yuvmejwUb6KV8rmuj
	s939mHPeBJTU/M2LsEtafXRtuMpjVSMt9QuRIpu/gsQ6lo05eyDiNLyg9CIp5tp/3EfbAe8SrAC
	2Yp68QTm1GYX9BHCm3JUWRl3sTVlwuhJ6zBnlB+vtXHPZtfiacwcRzuGl1I4gxwq777rszm5x9S
	tMCjrz3tweGNjsrOBLm8AY9aQ3uQIUGDF2evf+HI1HbG8l5fQlkDxwuF4888HMcoM97JzUKqzza
	v7Xs/wS+D535DtfoXj5QUCAuBAUkFE9z8y+QZaBuBRENZxRwU1vTE4E7ALdFGWR+E=
X-Received: by 2002:a05:600c:8b16:b0:495:69eb:27fe with SMTP id 5b1f17b1804b1-49569eb28a0mr35742605e9.11.1784694669049;
        Tue, 21 Jul 2026 21:31:09 -0700 (PDT)
Received: from localhost.localdomain ([102.187.228.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956537c7desm161495895e9.7.2026.07.21.21.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 21:31:08 -0700 (PDT)
From: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	coresight@lists.linaro.org (moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: Mohamed Ayman <mohamedaymanworkspace@gmail.com>,
	coresight@lists.linaro.org (moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Subject: [PATCH v4] coresight: Fix scheduling while atomic in coresight_cpu_pm_notify()
Date: Wed, 22 Jul 2026 07:30:23 +0300
Message-Id: <20260722043023.6978-1-mohamedaymanworkspace@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dropping the last reference to a coresight_device can trigger a kernel
panic on PREEMPT_RT builds due to a "scheduling while atomic" violation.

When the CPU enters an idle state, coresight_cpu_pm_notify() is invoked
with local interrupts disabled. It calls coresight_cpu_get_active_path(),
which currently uses coresight_get_percpu_source_ref() to get a kobject
reference, and then immediately drops it with coresight_put_percpu_source_ref().

If this put_device() call drops the very last reference (e.g., due to a
concurrent device unregistration), it synchronously triggers the release
cascade. On PREEMPT_RT, free_percpu() takes a sleeping spinlock_t.
Furthermore, any parent device in the release chain might also acquire
sleeping locks, causing a system crash in the atomic PM context.

Fix this by eliminating the get/put dance entirely in the PM notifier path.
Since coresight_cpu_pm_notify() runs with IRQs disabled, it is safe to
read the per-cpu source pointer directly under the coresight_dev_lock,
check the mode, and return the path without unnecessarily manipulating the
kobject refcount.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 6d65c43d5..9461fac9f 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1850,16 +1850,13 @@ static void coresight_release_device_list(void)
 static struct coresight_path *coresight_cpu_get_active_path(enum cs_mode mode)
 {
 	struct coresight_device *source;
-	bool is_active = false;
+	struct coresight_path *path = NULL;
 
-	source = coresight_get_percpu_source_ref(smp_processor_id());
-	if (!source)
-		return NULL;
-
-	if (coresight_get_mode(source) & mode)
-		is_active = true;
+	guard(raw_spinlock_irqsave)(&coresight_dev_lock);
 
-	coresight_put_percpu_source_ref(source);
+	source = per_cpu(csdev_source, smp_processor_id());
+	if (source && (coresight_get_mode(source) & mode))
+		path = source->path;
 
 	/*
 	 * It is expected to run in atomic context or with the CPU lock held for
@@ -1868,7 +1865,7 @@ static struct coresight_path *coresight_cpu_get_active_path(enum cs_mode mode)
 	 * change. Since the build path has taken a reference on the component,
 	 * the path can be safely used by the caller.
 	 */
-	return is_active ? source->path : NULL;
+	return path;
 }
 
 /* Return: 1 if PM is required, 0 if skip, or a negative error */
-- 
2.34.1

