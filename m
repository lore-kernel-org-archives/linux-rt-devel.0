Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383F3E92A9
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Oct 2026 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967823; cv=none; b=Fxzz3DMqHf9a0vmkLnVuHtl7Q4/MLNUoVJbgczp+t9qWRZWI79Zsb0NKzOeWeP7biu1R1HohZ8E/jBSmVeFvTwJJptpkggyt+ClcbBdTNswspunnRoF4aCjc+xlEKQkkMCrCEkQ7XSDoHq0VxqJWI5rtcDdCNfworurL+cSuoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967823; c=relaxed/simple;
	bh=lUkkjNY5LuFYIcy7QLXpL/HHIJYKEfoWLTcWyHVQCf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnHfm2fielerJ5X/1XEmzuZm6zi4bTTWYpKQZaig/rzo3ADLLJxnNgTeKFJVja4n50RQQWLeRa0iCxsX+GuGhB6IycDpNaUZ4UcFPf+8X8dsweNVjKDAjC7DvNkVydenilm+lIXRboovrAf3V+jS7z0gdmM50OkaKAcXLhog6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VZrxtFkx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VZrxtFkx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CEC51476;
	Fri,  2 Oct 2026 12:03:38 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAEA53F85F;
	Fri,  2 Oct 2026 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790967821; bh=lUkkjNY5LuFYIcy7QLXpL/HHIJYKEfoWLTcWyHVQCf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZrxtFkxP38G5PPCU9+kOzeGZSNQ+bbSpVhkV4F6ByU6jowL/qDXv8PMLU2KxfE90
	 /SQddm2+dAGz2duWdr42ci+0AkyeT9x/je/ubvSd9mitO4jYaYLyCJqh8UCBDbfF3N
	 9cZ+Lnin6kdtuewmyqfi+z07F0+bXQ+7Jb0hHwN8=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 02 Oct 2026 20:03:23 +0100
Subject: [PATCH v13 02/14] coresight: etm4x: prohibit modifying cntr_val
 while session is enabled
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-separate_etm_cfg_v2-v13-2-fe429d8d96fb@arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
In-Reply-To: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
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
 h=from:subject:message-id; bh=lUkkjNY5LuFYIcy7QLXpL/HHIJYKEfoWLTcWyHVQCf8=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwAAA7VK0qxZnNFVcoVfJZJEwUi6cwgefYNYFp
 wZG6SPdCueJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasAAAAAKCRBt1cPRWsUx
 MzyJC/9WE3sldT7Mxsc/DNGRhx+Sox610ZKxurzxm2MPk+mX8SiVbVZNiSQoBnyV2KE0WAr/CNx
 YkAY3peYkN6WgIXZVGpj7K/c4ctpwWUGW2vxYvMHqC7fQifuA+4/gbpQV4t/EDSB6lVbaDfRQQd
 /k2re3q0A4+4xxQSFGMx95APuEnv1DiL4bcMtO4Mo9yqq9LNc7WsqHwiXXEJUKRtX+rKeSHvtbz
 LwOiGEBVDP3SIkutwyrpGDoR1Xs1JYCE4wJFGkelSEy9q63Xys9Mn972ZKyG/yPQ2ZHeVHZ8mYg
 v+9XjatDFzYNnq9hvHgDbEeItlF5jaevD3o4HW4RotbOMsW60w+I8U7AibvWwOiNkA9s6vtp30X
 69NorcFl3Ef8ANpQxC3Me0UOUsHLdd00XsLF7HtSFcCB0wNfdecX64+AYR0CnVD14F1TwR21cmT
 QMGSfELabk6XP2wP/4zXEHIpbZsyflv82bddYObe5A2ylfz3KoYzZQuAOYueZfdVc7uhw=
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
index 2c72ea831fe6..bf4e81bc1e8b 100644
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

