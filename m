Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36537CD42
	for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238167; cv=none; b=IwF9+fsOB91OysnIQ02UopQl3v/f8WiQNluUgCbrp97LlKODbI/ar7QY01Z1/aWczh505Y2YAFqNFV+PzS85eQu4543DqPjuLrUphqt3ivAE04tWCUEDH3mLi6CHDKu5pQY7xV1W9164fk8R6ELxdTG8ezcaoS/QotXcgo4oecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238167; c=relaxed/simple;
	bh=zjLFdBciCH36gQX93iOqveGy1R/ywZ1tsnZtfSHwo/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWxyE8UzJsZt2vLaggTaWJG/KhPOtUweF1/kM/q1wSQ6Mb1VCyqlg5hnWH/QGU4GbgKQpWiuow8qwrnrhufW+vAlgFE6nlUSYcYQCJ1H3BAU5QTxNcLOwEv/Oty51+JewBXvzhqTxb/2aGKzP3s5JL91hj8zchIKLxA39qNLUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgKrkJDu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgKrkJDu"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f4638f4aso32042885e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 14:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784238164; x=1784842964; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eyGPsVw0MJSV96XCp7cxneDUGR8CvSyWL+Po087qX1c=;
        b=kgKrkJDuiBVsACBRPHB9GhYRqsRFchLJABlcwDCDLMNjJTLbTjpe6m2XKmlm+YvSJU
         MeDeK7X4AX87F8QMDIdz3QRADMvB7Q8rS67UPwSJwdd4gQq7sE/X3xmpaL853SEqxQLK
         jkiYzaY1+YGCU4Nw86mKDRI7k9PmrRFrWbrUGWoNMFNnmqyvMVp7rSeThEEKV41hcUM7
         myOvMcA8hSHIMwzZx9wWvijXAj8Cr7oHNfK1EzA49wcRlr/THadh6Npr1WKY81MY0MQX
         OgoRpTb7EJMCDUbvXe/wqHO+f3iu10qVMvYpcw8iJqRUY6Zy/HJOje0/uuaqBcLzRaTH
         iSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784238164; x=1784842964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eyGPsVw0MJSV96XCp7cxneDUGR8CvSyWL+Po087qX1c=;
        b=jyqZQQizm6MSdf6mW7851LYJu0DrjaX+GsBZraxEZtu9QeziZlHqQU1abpYmNAaTOT
         pcTqMJ2+GJ7OZwhNSxLoFah0ELewZq56lPSf1ZGbPvHyLm9K6YbP4NV8a+OS6C0sjlhe
         0HA3GFESa1IWE94X9unKH+lcXTezTMkwbS0PBFaXw55fuhL8Yf2E1Bd4DQX/CHSO98nm
         JQkM8dhqgbaBk9v2yq1XtDmE74AGksCWReWZBBmGk4NczwbSabLs+WAlH0O1mYUfZ8Vx
         N06Mkd0h8RaXs/05r5j3LKeGdsf6DCw+OaPRL0tdd6Hbh3PHvPXVaT4w3uu1s5Rcjza8
         C6KQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJ+08cyk0IEBVmlorchRfhZRwzmULTVvAkyPV0n1kZhs91ZCTGNoxH6xkb3w02m71n6KLs8gqYuMQZDQxyTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmbvR/daM11MuhT/+vSiZTfqmsIg1Jvj2ORpkuG4Nojj5u6hHy
	Cx4zW6k6Cyfn8S+F8stMS9HU+N0f0nL0eCjF7bZumqqZxhC85aw4kSrU
X-Gm-Gg: AfdE7cn0LPa4GVTPCm4OdC0pUHDafjtCreOIJZX61UFGWh6UBi/VnYxetUfEm/zGd0t
	9LQmw9QwH7B2rxnZf5INhuDdJsCMatEtGqnDxDfFZL5S0/yiWt78n0O0AKShLYdQj/7t5U4b2qg
	wGOXf+fzWHtuLfTomvhe1490f0/khvSnsde00IZLj2DCRHXGITykDvFlBi97dpNlN3DRrCzj/84
	pyOb0z8dM2cL072jEkd1+FrXNocaZX+yctfbgPKrX9KB8oLnJTzWEjA1dWctyuxMZ0mohNIa8IK
	4fhok//tzCBAejN02WNq7+Zc3zBlWd0ilOraIe3YDOhLELqffp7Y02nrmeA74g65urROrxVstGr
	I9ShEHytGt+azK4URU8hN8tMFC1ZxkIw1RqL6TWuYRUJxbg66ZOdsmF9hh1a1c54eakVmkpfak4
	xMXH8LFKjg4OZrCsWGVwHmX/qHfsIdZW/WijysdLHJT8Zix9T123liZuXs6DoM8GU=
X-Received: by 2002:a05:600c:b8d:b0:493:bcef:565c with SMTP id 5b1f17b1804b1-49548391e68mr12720315e9.1.1784238164132;
        Thu, 16 Jul 2026 14:42:44 -0700 (PDT)
Received: from localhost.localdomain ([102.184.143.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a47de7sm2280035e9.7.2026.07.16.14.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 14:42:43 -0700 (PDT)
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
Subject: [PATCH v3] coresight: Fix scheduling while atomic in coresight_cpu_pm_notify()
Date: Fri, 17 Jul 2026 00:41:54 +0300
Message-Id: <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>
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
cascade. On PREEMPT_RT, free_percpu() takes a sleeping rt-mutex.
Furthermore, any parent device in the release chain might also acquire
sleeping locks, causing a system crash in the atomic PM context.

Fix this by eliminating the get/put dance entirely in the PM notifier path.
Since coresight_cpu_pm_notify() runs with IRQs disabled, it is safe to
read the per-cpu source pointer directly under the coresight_dev_lock,
check the mode, and return the path without unnecessarily manipulating the
kobject refcount.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 22 ++++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 6d65c43d5..713bcff53 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1850,25 +1850,15 @@ static void coresight_release_device_list(void)
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
 
-	/*
-	 * It is expected to run in atomic context or with the CPU lock held for
-	 * sysfs mode, so it cannot be preempted to disable the path. Here
-	 * returns the active path pointer without concern that its state may
-	 * change. Since the build path has taken a reference on the component,
-	 * the path can be safely used by the caller.
-	 */
-	return is_active ? source->path : NULL;
+	return path;
 }
 
 /* Return: 1 if PM is required, 0 if skip, or a negative error */
-- 
2.34.1

