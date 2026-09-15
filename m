Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D9037FF40
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472110; cv=none; b=kkMz2VN0EzKgp/lnIqDZmbNAU4MKbVhx9OTkS8zg8sX/bDynChy/ql8seDGIYehWU+wBaF9QxICEbNe3zpZ6aG6JrYdBBPMJ00rvFy62NLw/WbFCsx4wNuoKSOTJMqRltQn/495aorKnWlzz4PVGe+5Ut80946E/5G/r2BKPVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472110; c=relaxed/simple;
	bh=Duw0rbqzZc0OG8KYw+ZvnTS3Mf0PkCHjPT/8/o374fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/f3f/u/uwjFVvf8ySM9GufDShHeM5yzzA4HBObrSy+ctYtKqRYN5g7ZfT9+1DxKXERrXBIGFDp8N6u5p21f63j7amEgGyvTdNuA41kfkmZZNbAOk9tzRCbPjcM22YQhGDztbEAlwmC2fvVI7UDQJm6gDU8TV0XAzpyklFtuIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ubQaglxN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ubQaglxN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B321764;
	Tue, 15 Sep 2026 04:34:56 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0013F86F;
	Tue, 15 Sep 2026 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789472100; bh=Duw0rbqzZc0OG8KYw+ZvnTS3Mf0PkCHjPT/8/o374fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ubQaglxNXq4qNU8MsaS0WgAY7sdhdrjBgFc54fGQ0OrluhnLKBaWrylQfo/jiFnOj
	 noaCyq0eRwTI7ktPwU2JZ+dbAYLSiiB1p6qza0czBveoqQT4okS0EUFt91E/3RQ4XE
	 O4L7lbnZvkOXwlA4PMkk+LR5hSGdRkrLz5W8pcMg=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Tue, 15 Sep 2026 12:34:40 +0100
Subject: [PATCH v11 5/9] coresight: etm3x: remove redundant cpu online
 check on etm_enable_sysfs()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-separate_etm_cfg_v2-v11-5-d2b258d51747@arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=Duw0rbqzZc0OG8KYw+ZvnTS3Mf0PkCHjPT/8/o374fg=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqqS1VxtLGhlN+N1BuP+VZSI9LLtuZwzXMSFhzD
 cJm06wmiq+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqktVQAKCRBt1cPRWsUx
 M5oHC/4obvV3deG87NX18PbEDGugKhTfIn9gqv6fz9NhXM6HyIrjXjD4DVK5XxGFiK2eVM7oaGi
 eEa/pbQCBgm2S+CPk8T1XIS6+vOB3BHyVJ6OTbkBdqotTI9HQPm8DJdZb/j7kVJSwFYuuitU2dJ
 m7ZRUbgW7EUFDcPi1w+x6kgeP46rumS88EmFqFx5j55B4QebBdzrRTsfpchABb7WCz1seXzMIN4
 zKnTnPOyxkVfTAlztZYbnIZ0Afn+DnEdG1t7rvAbRw7I+KgN6oMmRx3YnyXoe+HiT1hLg6P0DWZ
 Pu86gmKAp9GHYZcyf5XCwqR31IbloZvfF90Lm1hche/se+SGXnmlGRQGImUfA+Uc8k5kD2prFW+
 8kyenPOI1xeDXrsLwDQ9ngwKpTQFswEoB+Xj7Ccv1AYRJhcnLiWPnqGOT9hGvUuvz/j0vDrurXW
 nMqI9GZ3PoqkzKRX0eDL9QncIxTm/jlioe1ChJVwykjqsDhc7Wy6vYcwv2HNI41Eku+TA=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

cpu online() check is done in coresight_validate_source_sysfs() already.
and smp_call_function_single() will fail when cpu is offline.

Therefore, remove redundant check in etm_enable_sysfs().

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 26 +++++++++-------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index fd76a57e5f861..12bb38dc596e7 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -515,25 +515,19 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
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
-			arg.config = drvdata->config;
-		}
+	scoped_guard(spinlock, &drvdata->spinlock) {
+		arg.config = drvdata->config;
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

