Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E017044AB88
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124187; cv=none; b=VMJ4IXO9AEj3iBg15mjWCm1MB6b5sRWuUyycw510DgEJmXtqDcwvrMaYXZJuPGqHot4eYIZHVWUKUB82wOwE61rGemIEms0gLL6gUA3rSvFZjZpcChqOnChiAZLGriHi3IL/JEFUsXVp73tlyYzO4ACRbX4jheholW/VFft+xNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124187; c=relaxed/simple;
	bh=CBHqN7snhxYRskBFclU3Ntl2e2QfakAxW5bdmKzKdRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zym/jvOX8n+NA1lyngk77kqE8ykPNoLr0bAlQG6d2XJpZwRpZIwFtYtv5UI4Eq8VZztj8gW+NypXak7qEFbfoC0gLm2nQEZwfPHpAPG49OqJ8s/hrWijsB2J9I0IHA7F5JWhBYqpGYSyAacVDCuTVAv15AZQU0geyW0gHF36u+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QvHFRCYz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QvHFRCYz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF80A16F2;
	Fri, 11 Sep 2026 03:56:20 -0700 (PDT)
Received: from e129823.arm.com (unknown [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647313F7B4;
	Fri, 11 Sep 2026 03:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789124184; bh=CBHqN7snhxYRskBFclU3Ntl2e2QfakAxW5bdmKzKdRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QvHFRCYzN4i2ZWcoXe9bdOkaXqC97SdBYKOI7X7ornq//8ieCnM22RPKtQAoRfd5G
	 Qxeup9GhETzRB0iRRJG+EfDmGw8Jy0ii+/+Pg3/JAQMdvxeifw9kjATSyMvdtyh5+r
	 q8kcWdKjfKDf38uQHUBtZ6L80Jdbx3tIzqOz8dNw=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 11 Sep 2026 11:56:03 +0100
Subject: [PATCH v10 4/8] coresight: etm3x: remove redundant cpu online
 check on etm_enable_sysfs()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-separate_etm_cfg_v2-v10-4-1b715d95927a@arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
In-Reply-To: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
To: Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=CBHqN7snhxYRskBFclU3Ntl2e2QfakAxW5bdmKzKdRM=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqo95J7fsYucbkFqj21ZH5KdtKSs4sYSGPjoVq4
 qKl4BHZxXSJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqPeSQAKCRBt1cPRWsUx
 M5hfDAC6LewplU7u2JiEw7+dcseutPOZQpNoX/YQGOmgH61JH/Soy9RkpG+SnZKHREb7xAmPiRI
 W0DsSeXXE8Makft+mbt36F0UE9Hn/+bb0qhuxSKPIU38tY6vR5bd4VM7irX/6fwx5yIrn46b6pd
 /kmmHMOdzQCaTtqfMTacuyLBJhbRdaLajFVHIAefPSc5MRTjOHy8Fa4KTwE1ErOAy7G3dxaxwXi
 jiz/27bdDSMGD+J82Qjyh0i5c9qjYClFE7dNnm3WiWPxAYqiBjlNu7tOZ+uDipBnO5/axTWQN7F
 zwJiJadly5A99Jeae4U+kP15krbS6Y4eB2xhtmLIBZsQU6i4RYQ4LsPtyOxgrMj55c6TK+7tq0V
 ySTCLL2Zec54uBlJVr7L3lQ61do9rZwR91ZcFDE7FnGdrw6lQn9SUUS3GmigdLrdDKYZ/w5jgam
 KBWsTkZyzhEPav/KMwWbsVOz56cSl48YFRHpGNRQnH4NszpvZvU5LreMAxmb/jexgG6pc=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

cpu online() check is done in coresight_validate_source_sysfs() already.
and smp_call_function_single() will fail when cpu is offline.

Therefore, remove redundant check in etm_enable_sysfs().

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 31 +++++++++-------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 7a1e183c0b48..14e0724a43a1 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -519,25 +519,20 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
 	struct etm_enable_arg arg = { };
 	int ret;
 
-	/*
-	 * Configure the ETM only if the CPU is online.  If it isn't online
-	 * hw configuration will take place on the local CPU during bring up.
-	 */
-	if (cpu_online(drvdata->cpu)) {
-		arg.drvdata = drvdata;
-		arg.path = path;
-
-		raw_spin_lock(&drvdata->spinlock);
-		arg.config = drvdata->config;
-		raw_spin_unlock(&drvdata->spinlock);
-
-		ret = smp_call_function_single(drvdata->cpu,
-					       etm_enable_sysfs_smp_call, &arg, 1);
-		if (!ret)
-			ret = arg.rc;
-	} else {
+	arg.drvdata = drvdata;
+	arg.path = path;
+
+	raw_spin_lock(&drvdata->spinlock);
+	arg.config = drvdata->config;
+	raw_spin_unlock(&drvdata->spinlock);
+
+	ret = smp_call_function_single(drvdata->cpu,
+				       etm_enable_sysfs_smp_call, &arg, 1);
+
+	if (!ret)
+		ret = arg.rc;
+	else
 		ret = -ENODEV;
-	}
 
 	if (!ret)
 		dev_dbg(&csdev->dev, "ETM tracing enabled\n");

-- 
2.43.0

