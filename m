Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C292222A9
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 23:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783983649; cv=none; b=S/nwihuJd2//7ovZ4pms8XxWCett65tEHOC/4cnklxPtnaCJxavvb4blYNtj6fHkepFTc7qQFHQDZ8ZkcrRT0Dt7NM36RTSZGiuifjLUGdBGvvbuw8rgLn/GAUOrEpI1vq1hVM2jPXTGYloOSom59mhkGc2S/e9YJ+4WUAmb2h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783983649; c=relaxed/simple;
	bh=mjpOssqdko44vM+FfdPiQeA5zf+rOXDkLtZlLPaFU2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcA20mFOQKTUP6w628VF1BdfrxhRQKEpfnjzSz5JzS9ppgA7LM4UHt8MR/0sN2QRNT6IQjo5Nw3jI2lB08Xnu2t2KaxG+gqMZXOGBqMsUQT3zPFGSSfLmw/UITK5h40aAUktq9qZ0R6R3/kJWoe/a9OjAAr5Svt/p6x8+mN0J74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVhKXi5s; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVhKXi5s"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69c5f6f7a40so4443516a12.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 16:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783983646; x=1784588446; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qo7IAvthG118m/JTtLFPGSZtzV4fU1ihRDscsFNE2qM=;
        b=UVhKXi5sUOcl5jGpYrAlIPFftgPqLb47VXAKF+XI3vUf3dmFRUTNNg35L2BKkeWJxt
         vCNt9i7KqxrABn2E6P6d9XhvxcI2tLKuP08TYXgkuXcDsMXbt/HVyAesvgoB6BiCyDSH
         BDSGSPNdvZFoUpr5ugfoUEzl7BzFO0X6hV0cznpTUAIFUAXAIO/WfZam1/7UAV3NSrIm
         xTCLUQ31LAIhuOzObxxMr1/x/12OV71UzwZrheVcol4yshDBPaPbPL9HGpOeE61jLw3b
         cNrtfLJbVDBLr8D5X8Sk29Pl7DS/A0PU5f3MVB22afUgnfa8DktD1epBGFpIP+xmOOis
         fmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783983646; x=1784588446;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qo7IAvthG118m/JTtLFPGSZtzV4fU1ihRDscsFNE2qM=;
        b=R/Lt2gizxxWI0zvpGNwRTVQ0whVzpb+TISh+cze3ZYcru6LuJIcfDS78B8afVs76la
         zhFCLNtoa5oh3iErspNIeZDgHyyEGSs/j+UhVdWCcyQSOAWQamJKwj6M3IosKFf1NyqW
         uJBPthlSge5yG25/Tr7q2XBOhsUcViSDcG+vjUmk3955MLjdkRd7ImsZE2E3D27Y9q9A
         Z/TYyzBivfjDNXnq/JpFNmQdQessW1uGECeVuSapRnoDzgRNZ/wCnKtNj8fTuSNm/uBj
         F4pj8soEziuV//Rvqha0PMIzVJTnfJAredYQLyhDwmWXH9mzfkQCZ0py34h8ZmMPrBiT
         2gcg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7zXAzX7L5dch9mhMYK5vpmJFhCLj6F4nNwCQf2rVDQRUZIms7e6mUxYClk+cpXxvuaihvfFEkgdEDItE3QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMe2Gg9+yId4PBAA+VjLI5Kcuf9clFp54jqsRhT+MMW83OOtLI
	3xPWiSJw92QysZCo7TsZNy6aor7soqzo+GIrtTF9zPoyQo9z30GzTf1s
X-Gm-Gg: AfdE7cnWoKGMiffHRqZ0EpsZHvz4zva2aGbmBdxTe21lwLw5sGdB/JZUlI5j/GNbx23
	J1aRf0M3ujInLbUJEUXTgU4NuE9Jf0vYo0TXBeWHr6fAqj99k403mTLQvEa3p0ptFx4r0SYNpj7
	Vn9PQcXmYTK3npa0H/sDMWMH5O3IupH2piVIiWEtjUiB8dFjMpRGhYirrtXT63pO7ZfEsYFYHaD
	s4QNPcjSZnjmDMBpEDjNiQyqbzoKkO66UV1PpgXAbOo7PHjfwWx82aQbpK6GB1P0kCBeZIvOVn+
	3+QvTvGX9rziZ8oDmoMe1vQYXih/4FRKjj+MlgvmiMgh2WuMtXcuBSWB7bQ5xqDOSH2ys3mquS/
	slMDQ7ARpKiLbQl7N5aW0vnv7WfPXBa1WEl4HGiEo59EkaVWWDvKrqBIGX5SLyfVmkrbKIQbWKe
	8OvjOFWPI2DCHOwQXEHJ8joAkdGZL7AULoFnFIDindjTFhfPKB+g==
X-Received: by 2002:a05:6402:1e8f:b0:698:1973:1daa with SMTP id 4fb4d7f45d1cf-69c5f10c9b9mr4960904a12.18.1783983646028;
        Mon, 13 Jul 2026 16:00:46 -0700 (PDT)
Received: from ST.. ([154.189.248.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2878e74sm512640a12.4.2026.07.13.16.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 16:00:44 -0700 (PDT)
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
Subject: [PATCH v2] coresight: Fix scheduling while atomic in coresight_put_percpu_source_ref()
Date: Tue, 14 Jul 2026 02:00:27 +0300
Message-Id: <20260713230028.8046-1-mohamedaymanworkspace@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dropping the last reference to a coresight_device triggers a kernel panic
on PREEMPT_RT builds due to a "scheduling while atomic" violation.

During CPU idle transitions, coresight_cpu_pm_notify() runs with
interrupts disabled. It eventually calls put_device(), which can
synchronously trigger the device's release callback and drop the parent
device's reference. On PREEMPT_RT, free_percpu() takes a sleeping lock
(rt-mutex), and the parent's release callback might also sleep. Sleeping
in this atomic PM context crashes the system.

A previous patch tried deferring just the coresight_device_release() body,
but this still left the synchronous put_device() call dangerously exposed
to sleeping parent release functions.

Fix this by entirely deferring the put_device() call to process context.
We add a pending counter (put_pending) and a work_struct to the coresight
device. When releasing a reference, we increment the counter and queue
the work. A worker thread then safely drains the counter and calls
put_device(). The counter prevents leaking references if multiple puts
are queued before the worker even has a chance to run.

To prevent a use-after-free race condition during module unload, the work
is queued on a dedicated coresight_wq which is safely drained and
destroyed in coresight_exit().

Finally, remove the unnecessary raw_spinlock_irqsave in the put path,
as dropping a reference doesn't require protecting the per-CPU table.

Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 37 ++++++++++++++------
 include/linux/coresight.h                    |  3 ++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 6d65c43d5..e931e6bdc 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -63,6 +63,8 @@ static LIST_HEAD(coresight_dev_idx_list);
 
 static const struct cti_assoc_op *cti_assoc_ops;
 
+static struct workqueue_struct *coresight_wq;
+
 static struct coresight_node *
 coresight_path_first_node(struct coresight_path *path)
 {
@@ -132,6 +134,16 @@ static void coresight_clear_percpu_source(struct coresight_device *csdev)
 	per_cpu(csdev_source, csdev->cpu) = NULL;
 }
 
+static void coresight_put_device_work(struct work_struct *work)
+{
+	struct coresight_device *csdev =
+		container_of(work, struct coresight_device, put_work);
+	int n = atomic_xchg(&csdev->put_pending, 0);
+
+	while (n--)
+		put_device(&csdev->dev);
+}
+
 struct coresight_device *coresight_get_percpu_source_ref(int cpu)
 {
 	struct coresight_device *csdev;
@@ -163,16 +175,9 @@ void coresight_put_percpu_source_ref(struct coresight_device *csdev)
 	if (!csdev || !coresight_is_percpu_source(csdev))
 		return;
 
-	guard(raw_spinlock_irqsave)(&coresight_dev_lock);
+	atomic_inc(&csdev->put_pending);
 
-	/*
-	 * TODO: coresight_device_release() is invoked to release resources when
-	 * the device's refcount reaches zero. It then calls free_percpu(),
-	 * which acquires pcpu_lock — a sleepable lock when PREEMPT_RT is
-	 * enabled. Since the raw spinlock coresight_dev_lock is held, this can
-	 * lead to a potential "scheduling while atomic" issue.
-	 */
-	put_device(&csdev->dev);
+	queue_work(coresight_wq, &csdev->put_work);
 }
 
 struct coresight_device *coresight_get_source(struct coresight_path *path)
@@ -1563,6 +1568,9 @@ coresight_init_device(struct coresight_desc *desc)
 	csdev->dev.release = coresight_device_release;
 	csdev->dev.bus = &coresight_bustype;
 
+	INIT_WORK(&csdev->put_work, coresight_put_device_work);
+	atomic_set(&csdev->put_pending, 0);
+
 	return csdev;
 }
 
@@ -2090,9 +2098,13 @@ static int __init coresight_init(void)
 {
 	int ret;
 
+	coresight_wq = alloc_workqueue("coresight_wq", 0, 0);
+	if (!coresight_wq)
+		return -ENOMEM;
+
 	ret = bus_register(&coresight_bustype);
 	if (ret)
-		return ret;
+		goto exit_wq;
 
 	ret = etm_perf_init();
 	if (ret)
@@ -2121,6 +2133,8 @@ static int __init coresight_init(void)
 	etm_perf_exit();
 exit_bus_unregister:
 	bus_unregister(&coresight_bustype);
+exit_wq:
+	destroy_workqueue(coresight_wq);
 	return ret;
 }
 
@@ -2133,6 +2147,9 @@ static void __exit coresight_exit(void)
 	etm_perf_exit();
 	bus_unregister(&coresight_bustype);
 	coresight_release_device_list();
+
+	if (coresight_wq)
+		destroy_workqueue(coresight_wq);
 }
 
 module_init(coresight_init);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index ddf18c970..589a6c20d 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/sched.h>
 #include <linux/platform_device.h>
+#include <linux/workqueue.h>
 
 /* Peripheral id registers (0xFD0-0xFEC) */
 #define CORESIGHT_PERIPHIDR4	0xfd0
@@ -293,6 +294,8 @@ struct coresight_device {
 	struct csdev_access access;
 	struct device dev;
 	struct coresight_path *path;
+	struct work_struct put_work;
+	atomic_t put_pending;
 	atomic_t mode;
 	int refcnt;
 	int cpu;
-- 
2.34.1

