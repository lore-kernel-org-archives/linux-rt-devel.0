Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6679F4B04BD
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472097; cv=none; b=gTu1I1Hm/xMz0EgdGMOsEuafol/USQciXE7GSxRiABEGqDhpMOf9zedQkNsQvgK866hu/Q51EF/LCGbCYD5SIwmNFeWlUtz3/Wrav1gPoRpZLkWLqoPORB8EitRTb0XMAFC22e6dDAs7ZLShcLCqYIFOdC2mS4LabQqdI3Dgi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472097; c=relaxed/simple;
	bh=9SznDYuGT8UWvy+LroM0/n7oks7pIldiC5cYN/ie6lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/PjGfFwNHHpo6sRTLCHMRNdpbLXxD0f2tCKr8hJQJQHybzhucquWrNtwB+dgpBmU3DwSsM1nXyWEgKr2AnaypwK7lJVd0TO27m7HDqIeT8e6ra12rbIZRZMiVG++wOcZN4khH/4LrQ/DMfGLo23QupbZSvEddllvaHWLJGKUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EJxeykuK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EJxeykuK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CD9C169E;
	Tue, 15 Sep 2026 04:34:48 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC9C3F86F;
	Tue, 15 Sep 2026 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789472091; bh=9SznDYuGT8UWvy+LroM0/n7oks7pIldiC5cYN/ie6lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EJxeykuKGZuefAoOIcnscNFcZbufrNIAnvNt/ygyPFdWqrXkYpB147dLaBlyIUMdC
	 DF4gMURNpzWzMQz8DIE9bsyAgX5oeiujiznZMjNjXzrxsChNJUJqS3AkRwrsnEoK7C
	 +bn3xSqoxgLIBsVaFJ2TSmGLyVEAIYfOP/wkF1/Y=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Tue, 15 Sep 2026 12:34:36 +0100
Subject: [PATCH v11 1/9] coresight: etm4x: prohibit modifying ss_status and
 cntr_val while session is enabled
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-separate_etm_cfg_v2-v11-1-d2b258d51747@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=9SznDYuGT8UWvy+LroM0/n7oks7pIldiC5cYN/ie6lc=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqqS1TkdhDSHPwJcx/vmPdcKKHXF1J3vojEq0VJ
 Av5CLspdxKJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqktUwAKCRBt1cPRWsUx
 Mw3xDAC2MZUtn9trX+mcrq3sX6onUAcMm+eNJV/vk+uyxqJclKUiPMK5N1Ru8xJJCy06oLvKNyO
 nQLYyrs3pMj+xtDncgt2YaeKUaPHBDydamhBBvSHeEImhXehkwph1XVXGWywu2PY580EM8681ka
 hm9MytsXjIc9AZBfXY6Zge0HOdFsDo5ZXwxxAex8ch5TP+AqUkk1OQJUb1hvUfXM5KVTvDHV0Zq
 GPi/mciXValWE+s4dgBzl4B7DNI+I161WyVk1mqs+XCm8gXIXcjjo3KX5rtGWEKkWYYsqwBnLTV
 tiEeqO/dUTChORNpnINZjK67p2JXe3ERj16KFpW+d4TplTFHhpXLrSGzLGA0XQShNMUKD4JCC/t
 xzFp761FweGV2y+9P+2hHQrUDWO8c+KtPxI35w2j3e0hTDMT/8nIAPsb7hBTn+lykszrD9vm63p
 7Zfdy6cydalTrkHcYODmCpfcIJsiG4Y5yw3He5KjNPzxDZyx5JAaDDLjrPh8ltsLUuLew=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

ss_status and cntr_val are overwritten with the values read from the
corresponding registers by etm4_disable_hw() when the session is disabled.

This means that any changes to these values made while the session is
enabled would be lost when the session is disabled.

Therefore, prohibit modifying ss_status and cntr_val while the session is
enabled.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index cc6cdd3ae29d5..8d73248b840a6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1613,6 +1613,8 @@ static ssize_t cntr_val_store(struct device *dev,
 		return -EINVAL;
 	if (val > ETM_CNTR_MAX_VAL)
 		return -EINVAL;
+	if (coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
 
 	raw_spin_lock(&drvdata->spinlock);
 	idx = config->cntr_idx;
@@ -1797,6 +1799,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
+	if (coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
 
 	raw_spin_lock(&drvdata->spinlock);
 	idx = config->ss_idx;
@@ -1847,6 +1851,8 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
+	if (coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
 
 	raw_spin_lock(&drvdata->spinlock);
 	idx = config->ss_idx;

-- 
2.43.0

