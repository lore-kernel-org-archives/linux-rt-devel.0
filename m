Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5760386C18
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995969; cv=none; b=tbNe2bqE6gkRto0at3w7NPgY/ip5y9QTCbusim0/ixOk/4UEMQxCwXlQpPqrFGvtSYZcaY9Vy5gIo6WQW1MqvQkbufBhpNbytXvx1py5gc+fnbAuxw6DdqT5ZeirUDZ8ToiI+IgtCiB4O/xbBWyV8umiRJb9aFtkdjSEawEWyRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995969; c=relaxed/simple;
	bh=TiWi/q8xGcjEmeDCS5JuOhiRjHoHgT0etgyhg2oNuXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Be9yo0Xox/H7zJw+GRx3jWIfP4ETZsmghfgnpxNmP0rCWIPWXyivQmHT3OJ947p/0MWOxtEH5cVop1TtQTad4B7xxcWiD8viSKYI8NYdijg0tCJxwdTKUbVyG6ZAmtcA5DaTBM0JRxQMInzhtlfqvVMkBdfXXYpskuOfyp3mNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KFLzS+wa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KFLzS+wa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E788E2F;
	Fri,  2 Oct 2026 19:52:43 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4630D3F763;
	Fri,  2 Oct 2026 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995967; bh=TiWi/q8xGcjEmeDCS5JuOhiRjHoHgT0etgyhg2oNuXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KFLzS+wandwS8zb36jLpa7iVNTukJJtF4lozUzbfVNB4m3PCmtHbnRigGAYTlgtXR
	 J1oTq9Wty5vsPpscTQWq9o1RUSkQuSXdHbj3YEKOxjjaaCcG/w0xA1fHpiwsKR8s97
	 /C9yX3AYx1ZRuKyEG5gzOsYef9Y1AKZcL18h7vIY=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Sat, 03 Oct 2026 03:52:18 +0100
Subject: [PATCH RESEND v13 06/14] coresight: etm3x: remove redundant cpu
 online check on etm_enable_sysfs()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-separate_etm_cfg_v2-v13-6-5d8a29aead95@arm.com>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
In-Reply-To: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=TiWi/q8xGcjEmeDCS5JuOhiRjHoHgT0etgyhg2oNuXc=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwG3ndhqbOpIs0XikI01YmdV96LXjrn8NQK+UG
 oWtGDM8vm6JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasBt5wAKCRBt1cPRWsUx
 M/XoDADX73C5l4GqYrjcLcI5nvXpAYB6U4nC1C5tzSaJec3VRWePXWHPO/QVyyPXzmGbhWUrNDp
 Z7mEcBETzEIST/saAseeWsUA+NJG7Yn+r1IxKypaQx3ttiTW7FbIT1cMdHO6n8kyg+X8Hg+TcP+
 QxaNnDAtomZvm6rB7ZYiq/JyB5db7QuOnzz5cxSQE0pWPtwMbv97JIG4WODMoYtLV/r5nB8YKS5
 Oy7gtX7zLtRDYIucOGCe1zOJ1UywzIOWFEWxmzumy51r+gtEZEck4XVTnbvz+1nFH+lQLYWz3Z8
 3K5KI//zbvVMNX+iTAcbzcJCEaQyfE7Mbhdj9giiFEnMz9tZEKHKKEHzDdClB2Mrsp7fpSp0vLo
 88Kqwtmuk5L7eK299TqsmesMcWF4RZElvpxxz/c+zVVFVq4vRexsr1WB0mPeLJGEao/drlfRV75
 rELEwvVAcI8704FJVnbDA+jM/+25M6WLeNT2H/5dhAYBeeQgxyg4D9l3CIMLtu/RY/kZw=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

cpu online() check is done in coresight_validate_source_sysfs() already.
and smp_call_function_single() will fail when cpu is offline.

Therefore, remove redundant check in etm_enable_sysfs().

Reviewed-by: Mike Leach <mike.leach@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 26 +++++++++-------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index dcadcc383012..ac7c154720cb 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -513,25 +513,19 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
 		return -EBUSY;
 	}
 
-	/*
-	 * Configure the ETM only if the CPU is online.  If it isn't online
-	 * hw configuration will take place on the local CPU during bring up.
-	 */
-	if (cpu_online(drvdata->cpu)) {
-		arg.drvdata = drvdata;
-		arg.path = path;
+	arg.drvdata = drvdata;
+	arg.path = path;
 
-		scoped_guard(spinlock, &drvdata->spinlock) {
-			drvdata->curr_config = drvdata->config;
-		}
+	scoped_guard(spinlock, &drvdata->spinlock) {
+		drvdata->curr_config = drvdata->config;
+	}
 
-		ret = smp_call_function_single(drvdata->cpu,
-					       etm_enable_sysfs_smp_call, &arg, 1);
-		if (!ret)
-			ret = arg.rc;
-	} else {
+	ret = smp_call_function_single(drvdata->cpu,
+				       etm_enable_sysfs_smp_call, &arg, 1);
+	if (!ret)
+		ret = arg.rc;
+	else
 		ret = -ENODEV;
-	}
 
 	if (!ret) {
 		dev_dbg(&csdev->dev, "ETM tracing enabled\n");

-- 
2.43.0

