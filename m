Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84E2380FD1
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995964; cv=none; b=qp015/EcqfmRISd6LWVXJUGq02/Cy/bgPfTgIooQNdY3DBuNcjmPxaYvpZgDtsEXq1X/lVhZCyPGeSgeqLKv//TXzaMvC9dHjIveKwOoEqjL7yrBkwZW7qQo2i2sjoNq40erVw2fse3RBZUxhsopdJiHRF95B4cIM2XNRR7aJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995964; c=relaxed/simple;
	bh=M/H8p54y9BAGRBok7Bq+l77HPKLtLrhketpnjFmnyH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sfx94tiXzvch3D1deS/hRo4IIsgSbntAX3KckNafQYMMZ4DiJO4lF0vq0sAYI9zXe/Z0CVdh3oDyCTc35zeD+VvRh4C2UWAFQB+tLhVIGoM7PxWDj+Xtj10WmpKCkbEMz/zNlGn4lNujifQ90FuiZ5V65e36OF9458UtzBFE+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=curc2BE9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="curc2BE9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16A282F;
	Fri,  2 Oct 2026 19:52:37 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 666C33F763;
	Fri,  2 Oct 2026 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995960; bh=M/H8p54y9BAGRBok7Bq+l77HPKLtLrhketpnjFmnyH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=curc2BE9ZhtdKVJjrN5TvMhlUxVY7AbWpyOsE9GmSAXohHoHjFKz+dFIJVbk2R7NX
	 sc4NPnf0yXfGF6/SZkub5UkckHxBHy0qIUwrsvaOJPGkpgYV4Z0fv1t8t4v7IEffQz
	 RX0NIkobmV/wBh4ZWDPugXDi5d3bIP4uJmLn7I30=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Sat, 03 Oct 2026 03:52:15 +0100
Subject: [PATCH RESEND v13 03/14] coresight: etm3x: prohibit modifying
 cntr_val and reset while session is enabled
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-separate_etm_cfg_v2-v13-3-5d8a29aead95@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=M/H8p54y9BAGRBok7Bq+l77HPKLtLrhketpnjFmnyH0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwG3kO8Ia+RgIa6TGr8bMwB3ihA9t/0Dv9uHVt
 SGYLCIZSAeJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasBt5AAKCRBt1cPRWsUx
 M0gXDADV9P6WDGWyvhb/sriIF9ERz9gRNjL21avxFPFPtHsinDiNo7/BlcYVlcXpfsEwe27B8SO
 zYYwPby1l8A026uDUq+4VobhaQnzvrdXN6Z/LcniW3rgJcJxkUNVyX96RS4bHl6V49kDBPu/q5H
 9xfti0cy2eHYn3bl3oY1JQ8r23BFv2y7tqF4L5KijxabfMurII1svpJ9D2byNgKp9YbFfa/QhpO
 VglirMJRO5MclRLqu4v+FgqhxbByeMNLbTr1vsytA7zOP5Cs2lrOdFAO25Lb6etyZepro7PNebD
 Z9UJrjgJqlR4v9ljSr+UMlFA3KzmpW9St3lC968Bjd4pIJ4ctrgxnOsYH2gW3AHFVOkjeAYxBGd
 By7w/dDEhcEhH6X+69eSyAkTCMne/bXk/LUCEH3N8jwL/E57JktLu+ZaSqnUZZZ2iWe99A2dkdw
 tUIQRrgaRvQJMRQ8MQioVvIkok6emsUMBNidY7MGVm6afDWt2mtgD7pU2Ef3ec3Yb8cSg=
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

