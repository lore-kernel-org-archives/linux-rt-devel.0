Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF04BD791
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271264; cv=none; b=EhulCHO2hFmVPtYlesgf95xMf7bEJKSVg4HwGVfdjwKWQNJ1fyrvJqDUFeLkPMoTYQkYqyATme44ENKyooGNyYY4NMQUquNPvVUCL6eg/XjrOathRwT7UY3G/yCKY/UkFzcUtj09t+PxsOIoa7gYyHKZP2ozYOdUk1Iwp7L3AOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271264; c=relaxed/simple;
	bh=M/H8p54y9BAGRBok7Bq+l77HPKLtLrhketpnjFmnyH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZWiegUfvv0fFA6F3QrqP+AWtMeitM4iKNb0lm95FahgDHG56CrQueusHrNHJz6INPKLk0B5g26McOHzhTZWhcoDSXVUk7qZexbELz/gLYWlD8+HipIK2zzfQj+7EPp9/6nMZDs2qwMxDfHE7o1H7FZE5+H2/Vr5w8bjc+CWd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gybT9Kv0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gybT9Kv0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37A801E4D;
	Thu, 24 Sep 2026 10:34:18 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A693F86F;
	Thu, 24 Sep 2026 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790271261; bh=M/H8p54y9BAGRBok7Bq+l77HPKLtLrhketpnjFmnyH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gybT9Kv0y7Ei2KpquZuNOEEU5v+0tkNUelzrSNkkLjgFsJRxG3hC/WKmpcFWtxAug
	 Fj2NQ1iPOc+vxXsCMVFFYV7WQDcNr8EUiFelmXS7JDRR2bItKIx++FA+qIJ4DhB8oz
	 qxhmBhKcyTHLfG366LOp1dfllwvXsWdxSmfe4OGk=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Thu, 24 Sep 2026 18:33:41 +0100
Subject: [PATCH v12 03/14] coresight: etm3x: prohibit modifying cntr_val
 and reset while session is enabled
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-separate_etm_cfg_v2-v12-3-a2b41d2f7c2b@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=M/H8p54y9BAGRBok7Bq+l77HPKLtLrhketpnjFmnyH0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqtV8M2SaHGkPoXGzyIEDWz7Q03gTS12NIDjAii
 ZQi5oqNaTuJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarVfDAAKCRBt1cPRWsUx
 M+XeDAC/3K7Ie9ZibIyAU0NoSUhImUWGdI8tVyZuDB3Fs1qrY7JZAh91T7i9om2MgETtcGFPV+n
 bAUM3CFVdnmZCav//lfYL6HCLSlnMX+T56wVg7taiPY8eaVFgI3MnxcijjiKj39jZWARkn+4qwo
 Ee3/mklPZ9ZWvb1UPVbzq9LhT/fhsVJ1FtvhteYXecqPpfp0CkTo3/F7B4LNcUVHv6cdW730v4T
 ZJdGikq4/mVsePDAoZtkhLdiqkpMp9EYcbkY0+TwQL3yWC1K4lPNYJQUwnJbFzNt+JElGBtkyj1
 f0G67F7LshNIhB44l2AotasBDaBYnLwemVqW25cRUXGI5NrUY0m4Kn/TdU9mmstQ+Hl4oGMXyBN
 CjJu13x08+ZE5cXG0tVSGuO1dChH5M/9YwBbN89Q2NudBkQGSRA7BE338bA8EWO1EkANS2WzSj3
 v1MG+IXF1uYIcrZsCSLeU2AyYFzas1141QgnI216u6Ss8pSED72B6ICRf6lxZDwMgevnM=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

cntr_val are overwritten with the values read from the corresponding
registers by etm_disable_hw() when the session is disabled.

This means that any changes to this value made while the session is
enabled would be lost when the session is disabled.

Also, reset shouldn't be called while session is enabled.

Therefore, prohibit modifying cntr_val and reset while the session is enabled.

Reviewed-by: Mike Leach <mike.leach@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index b3c67e96a82a..cdb70a4382eb 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -75,6 +75,10 @@ static ssize_t reset_store(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (IS_ERR_OR_NULL(drvdata->csdev) ||
+	    coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
+
 	if (val) {
 		spin_lock(&drvdata->spinlock);
 		memset(config, 0, sizeof(struct etm_config));
@@ -744,6 +748,9 @@ static ssize_t cntr_val_store(struct device *dev,
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
+	if (IS_ERR_OR_NULL(drvdata->csdev) ||
+	    coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
 
 	spin_lock(&drvdata->spinlock);
 	config->cntr_val[config->cntr_idx] = val;

-- 
2.43.0

