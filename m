Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707161D0E28
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691546; cv=none; b=YGzTobvI0Xf9+wDhSrJlwXia3S8zGlTkIi9b6FnhkDtaU7W0mZw+yoNA+g5VNXNYPuMYIGSLqlVWxAjOcC/E1r5TVgYO8/AqEjF8CV+EKxmohKT52TUmU/LGWDoWtbUE2x0g/IETEZLGPmImFBA+nBvn/5NJU5IG2+Dr8GkCURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691546; c=relaxed/simple;
	bh=gm8sQ2LDvKhhQbLOZFFuOs4KS30QMPjIScI4wfbYGXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMOHZGBeORs5NeB6GW0VM0RiVd0BWeGqt7qPL+pM1Z292lHyAe+3vaNVCiDwWDtyj1/5a3GLC1jBaqnUIMMunVgsvrBoQT2RRG5P0RREEI2tX8FgQqf/50VVzIKhRc6b/tcXW69AolWNW06I5JXx6sJ6JVZLsRTWPPjzl/yQywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 046041480;
	Fri, 20 Dec 2024 02:46:13 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9C3F3F720;
	Fri, 20 Dec 2024 02:45:42 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: suzuki.poulose@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	mike.leach@linaro.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 7/9] coresight-replicator: change replicator_drvdata spinlock's type to raw_spinlock_t
Date: Fri, 20 Dec 2024 10:45:19 +0000
Message-Id: <20241220104521.809071-9-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220104521.809071-1-yeoreum.yun@arm.com>
References: <20241220104521.809071-1-yeoreum.yun@arm.com>
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

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
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

