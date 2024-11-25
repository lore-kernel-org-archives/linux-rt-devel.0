Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C28A196D90
	for <linux-rt-devel@lists.linux.dev>; Mon, 25 Nov 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528121; cv=none; b=tJaTtNq2IVdP6tazKf8mZkLSJ20R13s9STf4gC924elIF6mGszWi/eswbhcScq62w3GvtTbBZcnKOeRNAkr57z1gAU1Aw0WQb9cdOJNx3wYCV2l0JwCkm0WjBvLdLHx2BSo4pBSC7LS90ymrETCvEZilCigxHmicHvbpyqIYq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528121; c=relaxed/simple;
	bh=6kjujJZOpbZXxjyTsHW8i6GUxKhZMXjR/HsUnWZDBbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gs2X1iEI8rruDLUztQi7P+aFxtbzQmk49uop80v45SI47m2aYhHF60MWBq85UIV0vFqaDYAadmu7M2oCj3NkN39jRyWPMYiI6kDr3yZqRjIO2SrRJ1ZhYsdBTqKFlYHlwF/pETJ+lPbYNUZU6W4r8WIhe6NFsiSSHhn8/Vzs89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C146B1756;
	Mon, 25 Nov 2024 01:49:08 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D8793F66E;
	Mon, 25 Nov 2024 01:48:36 -0800 (PST)
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
Subject: [PATCH 7/9] coresight-replicator: change replicator_drvdata spinlock's type to raw_spinlock_t
Date: Mon, 25 Nov 2024 09:48:14 +0000
Message-Id: <20241125094816.365472-8-yeoreum.yun@arm.com>
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
 .../coresight/coresight-replicator.c          | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 3e55be9c8418..7ff08fb70758 100644
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
 
@@ -122,20 +122,19 @@ static int replicator_enable(struct coresight_device *csdev,
 {
 	int rc = 0;
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	unsigned long flags;
 	bool first_enable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	scoped_guard(raw_spinlock_irqsave, &drvdata->spinlock) {
 	if (atomic_read(&out->src_refcnt) == 0) {
-		if (drvdata->base)
-			rc = dynamic_replicator_enable(drvdata, in->dest_port,
-						       out->src_port);
+			if (drvdata->base)
+				rc = dynamic_replicator_enable(drvdata, in->dest_port,
+							       out->src_port);
+			if (!rc)
+				first_enable = true;
+		}
 		if (!rc)
-			first_enable = true;
+			atomic_inc(&out->src_refcnt);
 	}
-	if (!rc)
-		atomic_inc(&out->src_refcnt);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
 		dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
@@ -176,17 +175,16 @@ static void replicator_disable(struct coresight_device *csdev,
 			       struct coresight_connection *out)
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	unsigned long flags;
 	bool last_disable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (atomic_dec_return(&out->src_refcnt) == 0) {
-		if (drvdata->base)
-			dynamic_replicator_disable(drvdata, in->dest_port,
-						   out->src_port);
-		last_disable = true;
+	scoped_guard(raw_spinlock_irqsave, &drvdata->spinlock) {
+		if (atomic_dec_return(&out->src_refcnt) == 0) {
+			if (drvdata->base)
+				dynamic_replicator_disable(drvdata, in->dest_port,
+							   out->src_port);
+			last_disable = true;
+		}
 	}
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (last_disable)
 		dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
@@ -277,7 +275,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	}
 	dev->platform_data = pdata;
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
 	desc.ops = &replicator_cs_ops;
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

