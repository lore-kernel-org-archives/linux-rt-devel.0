Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65951AD24
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783890310; cv=none; b=GtHdq3lAT0PAlZSWaNrUkoYYUSOx4mVHP1jgc3yH6vdbVSfOPfLtILc5iqAvbRspzVxIN/uJoFf+gnQ96Vl2JhECrMhCXqf5AzaVaxcJIxjIEDWFJAga9g1N87a/oFpaU1xNLvGb5yCe4Fs1JmL2uW99fcQQniT1okFMb7n6/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783890310; c=relaxed/simple;
	bh=odSjBM17z5rvWok6ezx5hXagOfcO2GuPyauGIRLxaSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lXLXYFwsEiJtcLIlTQi+o+JLpvjwXW73NTHq9IbagralVK9ZMc+IIHzNdydXTS2qq1mIov65cDz8k0L6mCOT+YCet9cglU1DiW28uxjNum4yBOfcE0bd5wzs36FsJGszgZpsuwZo1b88uYcIZPxsGzdQeFqJNaFMEw04MuIsBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzQ5P1AT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzQ5P1AT"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47362928f65so2450341f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783890308; x=1784495108; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76fARbTyu0qdrrH8D7924DNiR5qZurH1xIxVFjOxQhY=;
        b=YzQ5P1ATdtSa3Qu46SDUANJkFxzt+9YLI78Q4FTaMlmgbpgI1Ho/CdFN7/NqcpVsdj
         /kXVN/Vp+29Nk8+OKPA7DtoESs4639tvxTKDL7fUbNvJRT7Mkqu+SDV01Pdz8zImUGoZ
         id/n8dFc0uekxG7feVo+GLDj5v2unKcbV4ptac7tGUOC1uaDov1Hs253ZNF2RxjFIvwX
         rb/BpWwNIjQLCWpbtH0bZwCVzu9llj8PXKg4s/KlsxaDo90ousAHbiyzHAYfmRNnl4dQ
         AEX6t2fgcXV2Ytaytt1pC539zuTVobLkLYla6rLRFzhBzGBHI/hhCNHtR0rlX++gY+UI
         2/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783890308; x=1784495108;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=76fARbTyu0qdrrH8D7924DNiR5qZurH1xIxVFjOxQhY=;
        b=oBRwX9KLZVwI/kRSU50gRuWNIVCqT9axtxa5dbs+ACg4fNozouxSREScqcHKjqtAn5
         bmIgUpwbWx+5SZz7qnwTtVyWPyYgFZ78F1BX/hgsvfcyJl+PqSNwNcDNf07y3It/zQpK
         cTv6GpJx0yxfP1Xo5xhKcvyfPKv8vTWDYT6nZVq1BFxzHQw+ffcvwCiX6vwR5avaMkPV
         wgTO6oxgTv9QrQN8MoSIbLG4A3fuHAumJx+itez56nxESibutjwfg1BgrEVasY8OeXud
         ylnOrJgcxT0+vnvsAYdod3cy3XFHxew9FQxDbEYGpuY+RGrnr6Qn2niP84q4y8BDvhql
         NR0Q==
X-Forwarded-Encrypted: i=1; AHgh+RqE5J9bA2eUsL+zvAUE0j/QPLvR/2ZiS//vHJU1/N1TeKeIyyH/0DVdekFr3zJyFM5T+2UfkDeM47ZFDlb3Tw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgNJ0ryPYRtvWD57A2+gAYr4AOLDOKe1EPnyuPgnJwavXUyzip
	p5h1/rffhQ7ymju4ZVxjEhKZK+V9pIWgt/9bYhd7swWpKIbQhf2rP2oi
X-Gm-Gg: AfdE7cldFV2UKpltjtvmEB3gbta1Oup2zmRjms39SuB/yCh6Z56y6VAISI14iJux9yi
	qQcr53CYGzlgEkDZM6koNr0yeohbVlJnvGKi2k0qB57++sp12Rfty09fCzVOgOJbXNhif7Ri6UR
	LHRQPfkKpUUeDLQi2cfDNaFkzNhxFwQVH8ktOBgh+E1xVWshMz7sLkYVbU6KluGHpWOgYNMWqIL
	Kwyb3ZX51a9H7VwxUaWR0oxqJ27YIeKex2elNnjRiUiIVr2dmpNqh25dM4LI/erdHCzrMg4iKe6
	7sYzUqD8ulwAfD8rBvOYXeJAltKCuMlrEslHiUMpQ8jM+g3ESKxxjJSj3ZEFz7BJeaJpIgSSlpM
	rSTTJ0u2062ka5oKTOzQPmiLZ8sdyvnCMygbMWxoVVoKc2Mp3kVLA0uimzEkyUwH4VlQFv5ohvh
	dU8tjjpJJh/vvZFiaht0kwLnUSOwO4Mk029a8OlisJrVWqqZ5/3Q==
X-Received: by 2002:a05:6000:220f:b0:474:7bf8:15d4 with SMTP id ffacd0b85a97d-47f2dcd720bmr7244179f8f.36.1783890307565;
        Sun, 12 Jul 2026 14:05:07 -0700 (PDT)
Received: from ST.. ([102.185.196.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm76460144f8f.24.2026.07.12.14.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:05:07 -0700 (PDT)
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
Subject: [PATCH] coresight: Fix scheduling while atomic in coresight_device_release()
Date: Mon, 13 Jul 2026 00:04:45 +0300
Message-Id: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dropping the last reference to a coresight_device can trigger a kernel
panic on PREEMPT_RT builds due to a "scheduling while atomic" violation.

When the CPU enters an idle state, coresight_cpu_pm_notify() is invoked
with local interrupts disabled (atomic context). This function eventually
calls coresight_put_percpu_source_ref(), which drops the device reference
via put_device(). If this is the last reference, it triggers the release
chain:

  coresight_cpu_pm_notify() (IRQs off)
    -> coresight_put_percpu_source_ref()
      -> put_device()
        -> coresight_device_release()
          -> free_percpu()

On a PREEMPT_RT kernel, free_percpu() acquires pcpu_lock, which is
implemented as a sleeping rt-mutex. Sleeping while in an atomic context
causes a system crash.

Fix this by deferring the teardown of the coresight_device to process
context. Add a work_struct to `struct coresight_device` and use
schedule_work() inside coresight_device_release() to safely execute
free_percpu() and kfree() in a worker thread, away from the atomic PM
notifier path.

Additionally, remove the redundant raw_spinlock_irqsave guard in
coresight_put_percpu_source_ref(). The lock was originally intended to
protect the per-CPU pointer table, but dropping a reference does not
touch this table.

Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 28 +++++++++++++-------
 include/linux/coresight.h                    |  2 ++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 6d65c43d5..9dbdb2977 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -165,13 +165,6 @@ void coresight_put_percpu_source_ref(struct coresight_device *csdev)
 
 	guard(raw_spinlock_irqsave)(&coresight_dev_lock);
 
-	/*
-	 * TODO: coresight_device_release() is invoked to release resources when
-	 * the device's refcount reaches zero. It then calls free_percpu(),
-	 * which acquires pcpu_lock — a sleepable lock when PREEMPT_RT is
-	 * enabled. Since the raw spinlock coresight_dev_lock is held, this can
-	 * lead to a potential "scheduling while atomic" issue.
-	 */
 	put_device(&csdev->dev);
 }
 
@@ -1257,13 +1250,30 @@ static void coresight_clear_default_sink(struct coresight_device *csdev)
 	}
 }
 
+static void coresight_device_release_work(struct work_struct *work)
+{
+	struct coresight_device *csdev =
+		container_of(work, struct coresight_device, free_work);
+
+	free_percpu(csdev->perf_sink_id_map.cpu_map);
+	kfree(csdev);
+}
+
 static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
 	fwnode_handle_put(csdev->dev.fwnode);
-	free_percpu(csdev->perf_sink_id_map.cpu_map);
-	kfree(csdev);
+
+	/*
+	 * This release callback can run with the last reference dropped
+	 * from atomic/IRQs-off context (e.g. coresight_put_percpu_source_ref()
+	 * called from the CPU_PM notifier). free_percpu() takes pcpu_lock,
+	 * which is a sleeping lock under PREEMPT_RT, so defer the actual
+	 * teardown to process context.
+	 */
+	INIT_WORK(&csdev->free_work, coresight_device_release_work);
+	schedule_work(&csdev->free_work);
 }
 
 static int coresight_orphan_match(struct device *dev, void *data)
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index ddf18c970..63253f6c4 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/sched.h>
 #include <linux/platform_device.h>
+#include <linux/workqueue.h>
 
 /* Peripheral id registers (0xFD0-0xFEC) */
 #define CORESIGHT_PERIPHIDR4	0xfd0
@@ -293,6 +294,7 @@ struct coresight_device {
 	struct csdev_access access;
 	struct device dev;
 	struct coresight_path *path;
+	struct work_struct free_work;
 	atomic_t mode;
 	int refcnt;
 	int cpu;
-- 
2.34.1

