Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BE14BA9E1
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271258; cv=none; b=o4zhMuCvIZNywCaGf2EiRSLvajhZi3HHkv4s7qdzr0CJ4QB2u+22++inR0r30Iv9cgOeOSS5r4NTcsrTR+1W7xb/m5jFKwJMiLCN+5XrfXXdi7is2yHcyOxT47RXddunmrdzMuZOJhkSKPXvYN01nb2jK5q2O5xZiBm7mkjBJ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271258; c=relaxed/simple;
	bh=53Q5rj/7x+pKv27XfPvPIecPjq6QeuKQwbgS+7MBKw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McKnTyiyPur8FUktaTW6xpPzR/34RCc+bgFvpBBEqE5gE0H3g3Q+9vYD0kSpx19yy2HxYxBCaN4muHWf7wJmQq6XQVFMVWWvWRl8VAP+hSOlYsLFADCoY20siM/iAyclKB304jllAgp+hXf9K+/ZZCFrwVFjWNEf6LOjteYcnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J6v1g7Zk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J6v1g7Zk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB2741E5E;
	Thu, 24 Sep 2026 10:34:12 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11BDE3F86F;
	Thu, 24 Sep 2026 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790271256; bh=53Q5rj/7x+pKv27XfPvPIecPjq6QeuKQwbgS+7MBKw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J6v1g7ZksczunscKjuZNMJU2izJgyhiTRoDKt1PNFXdwdd1F5zPsDhsnXzAOCxgAZ
	 L8Y+74TmzGGMToqz9MioidUn6mf39WMzSdTeZDFXXU4J/tZR6k7WIReyJ1p+TWHh4o
	 lFO7lKLJ5iLZ0kXLNvxNhIwQwJb1Sy37oeAdNr0I=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Thu, 24 Sep 2026 18:33:39 +0100
Subject: [PATCH v12 01/14] coresight: etm4x: read-back TRCSEQSTR at
 disabling and prohibit modifying seq_state while enabling.
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-separate_etm_cfg_v2-v12-1-a2b41d2f7c2b@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=53Q5rj/7x+pKv27XfPvPIecPjq6QeuKQwbgS+7MBKw0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqtV8L2TzE38V3muYAysfVSoimlW95GWmvvUhPA
 jy2pl3LNLqJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarVfCwAKCRBt1cPRWsUx
 M9CwC/91iDVFdb41gcvWs14pPQ2nxw1scsI/e/7l3QCUOA8VSEtsrnfuboDUqT7t3/yTnehA/py
 0MBfFIeRMnYMzPfEkq3YKKF6V53CGuIIqG1D7OYvwwu48RbsItOI6fl+1pS/YlmNjWVLZTpJFsP
 KNgZltaLulip3XWdkBV7uMFW+57ljVlOjuFlIcYbHbmAcPfFyu9QHHISxiiPPpdxYy5B3db+L6w
 pTPU2BXFVbu78HQdup6KnsS9Cqf8qllB3+Wn4Q1I8z5H5wqP6Miqm1iJe5gWVJKC/BXW7lo+mMx
 vjKvYfi6VBAxwQkozgcmemjvEUhfi8GbECTiu1Bh1wcedLAoAo4fcQDHk7LDlvQxuja8c/9TDN5
 ul11CxCho0HMOKc1JWuIgo0IgLkHsloqM1du/zCcfEkc/Y59aFh4Cwa9XMT5DVy5NePuw+BS0Ba
 KVA7u+Mn7rBmHAymuw05tWSqQBeD+4xmveW/E+fpODle25CCicgvc8peRr1L2SzMsug/I=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

TRCSEQSTR can be changed by the ETM while a session is active. Its value
therefore needs to be preserved when a sysfs session is disabled so that
users can read the current sequence state after the session ends.

This means that any changes made to TRCSEQSTR while the sysfs-session is active
would be lost when the session is disabled.

Copy the TRCSEQSTR value when disabling a sysfs session, and prohibit
modifying seq_state while the session is active.

Suggested-by: Mike Leach <mike.leach@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c  | 4 ++++
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 2247ad55d444..9ca03a5913a3 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1073,6 +1073,10 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
 	}
 
+	/* read back the sequence state */
+	if (drvdata->nrseqstate)
+		config->seq_state = etm4x_relaxed_read32(csa, TRCSEQSTR);
+
 	coresight_disclaim_device_unlocked(csdev);
 	etm4_cs_lock(drvdata, csa);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index cc6cdd3ae29d..db3cf4ad6806 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1437,6 +1437,8 @@ static ssize_t seq_state_store(struct device *dev,
 		return -EINVAL;
 	if (val >= drvdata->nrseqstate)
 		return -EINVAL;
+	if (IS_ERR_OR_NULL(drvdata) || coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
 
 	config->seq_state = val;
 	return size;

-- 
2.43.0

