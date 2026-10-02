Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364CA3DDDB1
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Oct 2026 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967821; cv=none; b=pDhupDdTW+PMjv11mtB9uXzzOFoUBXGEAzaiqRTmfXB4oydtU8vGONGJQk9IKJ6iLwivDBh2cLGmhRIIHpdqbBX6DkhCab1D03pF6pbS9MkuqlebgQ/2m8/0/xvuMpHiQNoEoHF18EXNYPD5VD7xQKirlTB9q5r+stfBMtXWWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967821; c=relaxed/simple;
	bh=/LTIVchcSYeV2GdWMsw9q/5+SrFXYHpc2drQmo5k3iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LffXYC2I6dx8MDekmUrTN/E8pFedVWLgJSLoCqkx/rtTl/NrYPe3e1WbQp/4f28UylagqvRxzQPNmFqLcPuYzp22DZWvlQ7UQ/lJxoxgfJAwa+IGhpqdnbdYXT69TpUoiRPoVDgTikGRS9eW3QSfPSljY8bbDQU+NS4xvoEFuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aT0sNsfv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aT0sNsfv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2522F143D;
	Fri,  2 Oct 2026 12:03:36 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85A4E3F85F;
	Fri,  2 Oct 2026 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790967819; bh=/LTIVchcSYeV2GdWMsw9q/5+SrFXYHpc2drQmo5k3iU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aT0sNsfviVxPNATmbhcyBxXAOVAx3R9gnCgUfw66GVkFS4ppj8V7k0S8+8hhcKOOf
	 dTL5OLCcj0b4IHf+9RyUdpq+NME1uqatlyS03awqxcA0R7aQ+gnZcXmYGFRKcAn5dW
	 sN4h0gTq3BLABYdUbSF2pVhorYx+7FKOrW7w9sbs=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 02 Oct 2026 20:03:22 +0100
Subject: [PATCH v13 01/14] coresight: etm4x: read-back TRCSEQSTR at
 disabling and prohibit modifying seq_state while enabling.
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-separate_etm_cfg_v2-v13-1-fe429d8d96fb@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=/LTIVchcSYeV2GdWMsw9q/5+SrFXYHpc2drQmo5k3iU=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqv///9VUKc6rivLVuGZ3pF7zctdNW30JEAt83a
 TTuwEFcbiqJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCar///wAKCRBt1cPRWsUx
 MzSlC/9lcq/dhBMe/2rI3OVtkt/qBuf/DqV6YdDCvTGe3Kb8T1HYlI8y2YhsPFmG4bSCXBEuma4
 8D2zgZfmhhO1VAMU22lvoT1UzcyuyeBDY8WJIobZjV/JhBlEM8Cjrs/TA21YPlYdlwPlWDHVz69
 PMnPG3umS+5y6U7Ws2b332aJBl9dMKSIbAgu1F+d4u0oqqWw9At+WErwXLag2PRUeHrfM6t5BeY
 4jhwCPgEvmBAQth1GV8dWhZEQ8gx87RtToOEqwNpm+aauT/XO6e5iKoC8NaQ+bX9hPTnvbeR+Kx
 1RSfhWWyAdbMlT99q921rLzho9EiuB+RVvcEz/s3a1vFaOjVDdH63hcCRMOdJJ++QWg6fC9nT7p
 LUnaiGFSOA1dtNXsLjFoFSdJbRH5FVz3MiILfMKzJMlyoG0GE6WH1dexnD44tL2AU0T0AWKiQnR
 VJ3w39OchpZnR/eIKP8MYI9c7bl8FC6Oii7rvzW1d56+A7GPzdjpQ1aV5r37Zpmh5teo4=
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
Reviewed-by: Mike Leach <mike.leach@arm.com>
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
index cc6cdd3ae29d..2c72ea831fe6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1435,6 +1435,8 @@ static ssize_t seq_state_store(struct device *dev,
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
+	if (IS_ERR_OR_NULL(drvdata) || coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
 	if (val >= drvdata->nrseqstate)
 		return -EINVAL;
 

-- 
2.43.0

