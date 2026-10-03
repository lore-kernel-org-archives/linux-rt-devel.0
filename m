Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F138422E
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995959; cv=none; b=fF9gMxmXM+gdTPSc8n8p+NO0KcrmK+djopWU5Wh9uLYBAcGaCiNgsdwo6NbufgPUkj60Cu99FCnjsqYUJn8QvhF386qqQiXzHdBM20cXr2Ahu3Kdp6k+tCOx231mQYYUPLioNvyCyxs253JAt1mUCAReGM1FfXXaE0lauBLqgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995959; c=relaxed/simple;
	bh=h4wLZ7w5xNm1k2H6+gYt3YSwNI1J7rn9VKAd2u4Zx0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQBh+c6BokEE/Y8SVjR/Yw8DA6MNUi7gKlVrDIQQ8Zjgd6cxWBJWYrT9x7OLaN8OeB9BNi+URUN/nOYqJjdw6/v9G/hd60jbhHrMJ+B5lgbsw3XemhlBUapCGApei1wOVlUQ3x2VuyAMWsiwdNtTv1HYb+Q0UaDugBD3KmK+i1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rkWuhNWG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rkWuhNWG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C38C51764;
	Fri,  2 Oct 2026 19:52:34 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 200F73F763;
	Fri,  2 Oct 2026 19:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995958; bh=h4wLZ7w5xNm1k2H6+gYt3YSwNI1J7rn9VKAd2u4Zx0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rkWuhNWGg5LkN8AbUZ071o4abMjLAW6zgtraLrxerSDY0CAzvXD8O8l3EzqhQ6xSG
	 Kd3XtEPNFHWQrLF89BvZ6w1TX/oUjgXNwJwVIO4fgkWBJAh0cxYC0pT/q8xM8C0IK1
	 uzKQ25SHk8Jufi1VRG1ICgYUN1RJUYKAs2EHxfew=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Sat, 03 Oct 2026 03:52:14 +0100
Subject: [PATCH RESEND v13 02/14] coresight: etm4x: prohibit modifying
 cntr_val while session is enabled
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-separate_etm_cfg_v2-v13-2-5d8a29aead95@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=h4wLZ7w5xNm1k2H6+gYt3YSwNI1J7rn9VKAd2u4Zx0U=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwG3j8k3aLxVvd4p8PHBPLVkHTB2K+TBaCY+4M
 sxPUfpVI4uJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasBt4wAKCRBt1cPRWsUx
 M0F/DACavIOKNdHhmLqUTGuqB4sVQMX9WPIJItOEdkj+BPSxS/jq3Itpmg21n1mHsqxxnnfAm23
 pw6cBcFk1V24uIEQ9Kj1XUwJlmyz6JPNfFry4a/zK51NB8f6bOnToaY05y+zoj0Ep2YlBHF+SLI
 +bGctDeqFWpowL7imah4yldVDJ4L4/JdYh6pxqCdyXjOR5ta+TFllM56KIu091/RfU8XRmrOyge
 SlDcLewOMSRIRtuH0rui7bWFvvMXwjhkImMg8929erDqTiMMinbC1JGe4/GXoxIcssbHwfCGbfq
 RpnXnt/Jd2sSUjEjgB4GDzMZGEv/TN5Miqn+DWOAtVVJ7SB8Cv0dSJQsndFyUT76IsSyFQQ+oik
 KzTsEPH7dlZLoz9+I+TgpvJnw3Kqe0TQ25VcCpjIzBbsl5amL+taGp15jLNWfqbqKMUkUJv8ht3
 6ZbHeJZOz6iqAvw5hWtIo6MOexd2Tr3qdf38dzuCoWctTlF00tBkU6J0SurAooRF3zoUA=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

cntr_val is overwritten with the values read from the corresponding
registers by etm4_disable_hw() when the session is disabled.

This means that any changes to these values made while the session is
enabled would be lost when the session is disabled.

Therefore, prohibit modifying cntr_val while the session is enabled.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Mike Leach <mike.leach@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 4945d577ceab..863bab9c2e27 100644
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

