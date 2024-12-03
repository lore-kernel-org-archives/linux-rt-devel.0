Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2831E6306
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Dec 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226604; cv=none; b=BEsOP60RXUfAqxgvvMoIZw7GI4jQfEJv8jNbea0tkPnsMaGHOXEwVDmzDsPwKBH/ZroNdn0lGatqqS/1/cuhfc9Wx7CldvQsQzTmfFItwfcF1TnXTTMSn1s6/XE+vvOeHaJANy1jKOEooj7v7clN4eXBMADD+rijYrnP2u8Fw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226604; c=relaxed/simple;
	bh=FxcsbY3FjV8Rn7E8RuEuz5Fod9k70nwFiOVIo0znD9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTxd29gCZplFemPg+CXNBYd1occ5KHuwbCtcUBGJNXXTNhHHK2dzNU5zxJxXH3GVlB0Z0hANDzyvC35csfV3F2or1siw/zWR/L3a7Y9s0M3vgTyntTW3hZSB3oEfEdfCOEjHZFJSyJmlERVEgH2dF3qqZTBrS0eHKsrBsEotPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1FA2143D;
	Tue,  3 Dec 2024 03:50:29 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 00BEB3F58B;
	Tue,  3 Dec 2024 03:49:59 -0800 (PST)
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
Subject: [PATCH v2 6/9] coresight-funnel: change funnel_drvdata spinlock's type to raw_spinlock_t
Date: Tue,  3 Dec 2024 11:49:39 +0000
Message-Id: <20241203114942.697188-7-yeoreum.yun@arm.com>
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

In coresight-funnel drivers, cti_drvdata->spinlock can be held
during __schedule() by perf_event_task_sched_out()/in().

Since funnel_drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change type funnel_drvdata->spinlock in
coresight-funnel drivers, which can be called by
perf_event_task_sched_out()/in(), from spinlock_t to raw_spinlock_t.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 33efe1acbef7..a566c8854327 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -47,7 +47,7 @@ struct funnel_drvdata {
 	struct clk		*pclk;
 	struct coresight_device	*csdev;
 	unsigned long		priority;
-	spinlock_t		spinlock;
+	raw_spinlock_t		spinlock;
 };
 
 static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
@@ -85,7 +85,7 @@ static int funnel_enable(struct coresight_device *csdev,
 	unsigned long flags;
 	bool first_enable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (atomic_read(&in->dest_refcnt) == 0) {
 		if (drvdata->base)
 			rc = dynamic_funnel_enable_hw(drvdata, in->dest_port);
@@ -94,7 +94,7 @@ static int funnel_enable(struct coresight_device *csdev,
 	}
 	if (!rc)
 		atomic_inc(&in->dest_refcnt);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
 		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n",
@@ -129,13 +129,13 @@ static void funnel_disable(struct coresight_device *csdev,
 	unsigned long flags;
 	bool last_disable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (atomic_dec_return(&in->dest_refcnt) == 0) {
 		if (drvdata->base)
 			dynamic_funnel_disable_hw(drvdata, in->dest_port);
 		last_disable = true;
 	}
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (last_disable)
 		dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n",
@@ -266,7 +266,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	}
 	dev->platform_data = pdata;
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
 	desc.ops = &funnel_cs_ops;
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

