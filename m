Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AB4BB810
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271261; cv=none; b=Fr3/2KTLfbCMZkjFiKqvIBDNqR6REBWT33oihWbv7+tG9vsr3vXtM/fmfXG90852fwfxx4WdXRLMWOi+W+WZUy96jOt/Y1h8ZngasQhIFXJqYKqcGXZ3mwBKjLaQ99QPn5VTrgP8/95xu7eB56Et5EAgsDN1hg+zaP+MsXvdgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271261; c=relaxed/simple;
	bh=sS68p+atF2H8DVQ56LLhJJdiwhdbaXcCjWgoc3iiZJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c1Rh0sfFLLLnhQLRJ2At5I39WyGKsh20CU9rn0pRnvNxi3Wjy9mvpbLcsAuA/uLc6WhAY81z/RCcKUKRqCm0UbFr7KCyszc9UA0C41weM4hCtlRuWotB8jAUytm0yUh//m6uThLIjsVuzu81KaZL3AgZJrUlQxp3UBjy/QBKBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KjFfftV9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KjFfftV9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AAA01E4D;
	Thu, 24 Sep 2026 10:34:15 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6B273F86F;
	Thu, 24 Sep 2026 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790271259; bh=sS68p+atF2H8DVQ56LLhJJdiwhdbaXcCjWgoc3iiZJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KjFfftV9PivAqPaWnCX/EhuACvFWPoPKGysT0cTibCTb1cM52lDIoPL8wKJ1RZJx0
	 CfP1EKbCEBLYqHnVfMYlO+TOVXYW8rV6g+LJLPB77frTvpXe6bxethDCsrHlxrtrii
	 BE8dlj5MwzYcDsmngdrui1SBQRByDpQ1YBNxBxN4=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Thu, 24 Sep 2026 18:33:40 +0100
Subject: [PATCH v12 02/14] coresight: etm4x: prohibit modifying cntr_val
 while session is enabled
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-separate_etm_cfg_v2-v12-2-a2b41d2f7c2b@arm.com>
References: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=sS68p+atF2H8DVQ56LLhJJdiwhdbaXcCjWgoc3iiZJg=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqtV8MfDB1+nWZx8wYikco0l3/g2a5nPn9uIViT
 c2Xq3C9BLKJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarVfDAAKCRBt1cPRWsUx
 M5zPC/9KRSAhvos1jMAiZwYx1G5YpmNDuJuk0N0s+pE+tp/HEdEOKIwKP8dc1Hwx0ejENEM+Jfu
 0mbSBa+XCu+AaXLDjIrSliT9HATTpsA+B3BLMx6s4iwNmjeZEScFO0gEKUxsmuWmjCkvEpk4SYD
 mprsSSBBiYE9TuzkPcPBvDVOPRQ+A5N8ltBA4zT3P3a4yJbEE5x/z9tkO7WA/G3G17UpypVwFSA
 6s3sWAr9LL4CWNurp3qXU+F8dtxBBywpcZS3f4A5ENa7ZHFC886Z+TWLmiwP/NHhsnPLDqxN8+b
 LWdYr9C6Ki9ZsTYkXoZeA05DHIIqOkJ01e9TYKPzRCXpu4qa9NruZ3+CrbcOt3HA/cnIUGgJoMI
 SJMeRRhGIbyk2WWvpiDTswqewRVj34Dux3DBvyhU8sb08jhVJTiMITuwN/R8FSS2KI9g3vXka1n
 mFWe03P9JCZtJZ/9C/1tqsGRB06Pw9sycSM1SaZboYq+lsU1FGaX2CUdpZVn+Fl9bWO1A=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

cntr_val is overwritten with the values read from the corresponding
registers by etm4_disable_hw() when the session is disabled.

This means that any changes to these values made while the session is
enabled would be lost when the session is disabled.

Therefore, prohibit modifying cntr_val while the session is enabled.

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index db3cf4ad6806..a547de5a3f9c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1615,6 +1615,9 @@ static ssize_t cntr_val_store(struct device *dev,
 		return -EINVAL;
 	if (val > ETM_CNTR_MAX_VAL)
 		return -EINVAL;
+	if (IS_ERR_OR_NULL(drvdata->csdev) ||
+	    coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
 
 	raw_spin_lock(&drvdata->spinlock);
 	idx = config->cntr_idx;

-- 
2.43.0

