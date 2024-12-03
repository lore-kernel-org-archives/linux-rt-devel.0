Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C40E1E766D
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Dec 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226606; cv=none; b=g5cqumSsVJhHZVoYea9GOsTZmG6A3nHFB9ZGa+ZhP3eo6ShurTuYiRpdXRotQLf3mK58YCtI0YQO80ShZ5Crd3TWubPRsqfzOrbnPowUzRF4S94I0Oh2o4O3xm/7qzmhzi4S7AHXg26kNS+IBI0TqIzAnHhwq3brO2xyb0Q47bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226606; c=relaxed/simple;
	bh=k/CmxdFjeRb0Df4HhwzVzyYnBGVxJt7pqMM8EOtOmTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xmqh4s86fJuosSYj5LSI+P1XI8C995ZbSKNsHb9r6VlJq4lnOdTrFJ1FkoqnDvhUNxj84pneZdhAT/rfYqsep4bSc8+A16QxyXecc4SMYviLFQTGRwJPom25wZJ4JMm7yrRmN0wYP6kB4HfTsqAhHpJVC+BwT74IURDBvaPixYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0410EFEC;
	Tue,  3 Dec 2024 03:50:32 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2793B3F58B;
	Tue,  3 Dec 2024 03:50:02 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	nd@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 7/9] coresight-replicator: change replicator_drvdata spinlock's type to raw_spinlock_t
Date: Tue,  3 Dec 2024 11:49:40 +0000
Message-Id: <20241203114942.697188-8-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203114942.697188-1-yeoreum.yun@arm.com>
References: <20241203114942.697188-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In coresight-replicator drivers, replicator_drvdata->spinlock can be held
during __schedule() by perf_event_task_sched_out()/in().

Since replicator_drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change type replicator_drvdata->spinlock in
coresight-replicator drivers, which can be called
by perf_event_task_sched_out()/in(), from spinlock_t to raw_spinlock_t.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 0fba87de6d1a..7d36fe2176cc 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -41,7 +41,7 @@ struct replicator_drvdata {
 	struct clk		*atclk;
 	struct clk		*pclk;
 	struct coresight_device	*csdev;
-	spinlock_t		spinlock;
+	raw_spinlock_t		spinlock;
 	bool			check_idfilter_val;
 };
 
@@ -125,7 +125,7 @@ static int replicator_enable(struct coresight_device *csdev,
 	unsigned long flags;
 	bool first_enable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (atomic_read(&out->src_refcnt) == 0) {
 		if (drvdata->base)
 			rc = dynamic_replicator_enable(drvdata, in->dest_port,
@@ -135,7 +135,7 @@ static int replicator_enable(struct coresight_device *csdev,
 	}
 	if (!rc)
 		atomic_inc(&out->src_refcnt);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
 		dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
@@ -179,14 +179,14 @@ static void replicator_disable(struct coresight_device *csdev,
 	unsigned long flags;
 	bool last_disable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (atomic_dec_return(&out->src_refcnt) == 0) {
 		if (drvdata->base)
 			dynamic_replicator_disable(drvdata, in->dest_port,
 						   out->src_port);
 		last_disable = true;
 	}
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (last_disable)
 		dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
@@ -277,7 +277,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	}
 	dev->platform_data = pdata;
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
 	desc.ops = &replicator_cs_ops;
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

