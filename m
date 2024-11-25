Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2A192D63
	for <linux-rt-devel@lists.linux.dev>; Mon, 25 Nov 2024 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528118; cv=none; b=YMj5PQFcNonsQJps3+PbG3rzUVr28Xi8fW0RJ1kC7k7hbRUjE22l7l2O9QXozFsJ6vE3dc5y2Z/+2uX50Q/vFcAJBGAxew/KsDZW8SqTEJmSOl32vVQXRDmkIaPwpsHoYre+Rd9k4IfvNvxgPeAEI0FuWlrEP6c9fnqBsRtIlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528118; c=relaxed/simple;
	bh=xeqJykWNtGzFOwyV63+nS3cJaClNwCklkrtMQtygGgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwDLKT6mEDeQN63kNMY+ZUNN3JiEstDCqtKWtG785Bue185s6Riuqn5Cv0TURlxccllbuMmCL5igOopsLM+hIQIomPmXRM5pO/KTGvODTVfnUpyhigqPSMfEAhsVgcqber3V0ErmxzOjV4Up0Y47Z8DnOlUesQOO+5NHg+E3tV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 470A01FC7;
	Mon, 25 Nov 2024 01:49:06 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 138D73F66E;
	Mon, 25 Nov 2024 01:48:33 -0800 (PST)
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
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH 6/9] coresight-funnel: change funnel_drvdata spinlock's type to raw_spinlock_t
Date: Mon, 25 Nov 2024 09:48:13 +0000
Message-Id: <20241125094816.365472-7-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125094816.365472-1-yeoreum.yun@arm.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Levi Yun <yeoreum.yun@arm.com>

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
 .../hwtracing/coresight/coresight-funnel.c    | 34 +++++++++----------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 5a819c8970fb..dbc2891a10e1 100644
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
@@ -82,19 +82,18 @@ static int funnel_enable(struct coresight_device *csdev,
 {
 	int rc = 0;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	unsigned long flags;
 	bool first_enable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_read(&in->dest_refcnt) == 0) {
-		if (drvdata->base)
-			rc = dynamic_funnel_enable_hw(drvdata, in->dest_port);
+	scoped_guard(raw_spinlock_irqsave, &drvdata->spinlock) {
+		if (atomic_read(&in->dest_refcnt) == 0) {
+			if (drvdata->base)
+				rc = dynamic_funnel_enable_hw(drvdata, in->dest_port);
+			if (!rc)
+				first_enable = true;
+		}
 		if (!rc)
-			first_enable = true;
+			atomic_inc(&in->dest_refcnt);
 	}
-	if (!rc)
-		atomic_inc(&in->dest_refcnt);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
 		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n",
@@ -126,16 +125,15 @@ static void funnel_disable(struct coresight_device *csdev,
 			   struct coresight_connection *out)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	unsigned long flags;
 	bool last_disable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_dec_return(&in->dest_refcnt) == 0) {
-		if (drvdata->base)
-			dynamic_funnel_disable_hw(drvdata, in->dest_port);
-		last_disable = true;
+	scoped_guard(raw_spinlock_irqsave, &drvdata->spinlock) {
+		if (atomic_dec_return(&in->dest_refcnt) == 0) {
+			if (drvdata->base)
+				dynamic_funnel_disable_hw(drvdata, in->dest_port);
+			last_disable = true;
+		}
 	}
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (last_disable)
 		dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n",
@@ -266,7 +264,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	}
 	dev->platform_data = pdata;
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
 	desc.ops = &funnel_cs_ops;
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

