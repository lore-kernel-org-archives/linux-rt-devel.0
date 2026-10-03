Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FECD32A3D7
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995957; cv=none; b=kCGHHkOu7ec5i6TlKiAN5bMk8hPMXvGbErdq1o4qcdgGzBhsuDF1AuB6RyFmMouey0PtSIJIS6QPW7b1KP3vvB7Ys0Ml7w0PPZu12u1kYGhXQ8o5TNNIcEHRKmkRDEtLOdK89j7wVhs+f3NkIhji9GtYreXt6Ew1BczJZqHWh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995957; c=relaxed/simple;
	bh=WO4vKOfpybslW+mujSt9j/FEVI3+0mIWmOAlXRBt0Ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lpu5ME15Mq08SY6O4f5BsMPDrJ9QCRfLN9LzdMnzdQsrm64GOlq+Om90kx+rCBI9il5K53HYe62BeJ6ulyLAQnBK2ElqgMqs/O5H+1FHSmbkt5ZbCVF6fcscDM9+hHEMDoyUWnRKKn2LoH+sn6JhQMvxZtT4t8tGqT0mBA5Ddn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RG+y1pdV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RG+y1pdV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B1FF143D;
	Fri,  2 Oct 2026 19:52:32 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF4DD3F763;
	Fri,  2 Oct 2026 19:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995955; bh=WO4vKOfpybslW+mujSt9j/FEVI3+0mIWmOAlXRBt0Ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RG+y1pdVqc7PQDne7qCJpeYYtUNWxASYA8HAjKMBUoHuk5fPOPm/ofEvuW8NKvryg
	 ulUMY5SY6BWKaSy1OyD60lOnAHoiRrvITaYGd1u9A1TGouNynnRTFMirICH40UfPTp
	 BnBhLsXlYgNF1KIHhltxlrmurxeVNoFF5j9kMVxI=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Sat, 03 Oct 2026 03:52:13 +0100
Subject: [PATCH RESEND v13 01/14] coresight: etm4x: read-back TRCSEQSTR at
 disabling and prohibit modifying seq_state while enabling.
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-separate_etm_cfg_v2-v13-1-5d8a29aead95@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=WO4vKOfpybslW+mujSt9j/FEVI3+0mIWmOAlXRBt0Ac=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwG3iZDNL58P3wIlFq/CqJWrPwWoNO6dWpVp9c
 L8YNxAHKM+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasBt4gAKCRBt1cPRWsUx
 M2B2DAC/sv/EIkVznFyRrP09kdjmNyCfC7GiXiRe3Wzj2HkDqO0FU/B5cIhfOLCVcs86YjEaQyP
 UgBPz4b39i1QcZZskvgSbryCVHF7hrv4mNS7bV7gsd6knyjo/90ohXfAwb79d96PgKlcL5DKvcL
 q5Z5c58Qp4RP8AduDXFH9/tk3xGBYdSFy7Qhdtlp3cwMK/zWjc44kTePA54RnC3IDsI8kHaXhZH
 CY5fDkDTbzEBieOcwU96Mg5dltHXRutxEFQO02ORb5qOc9ArAICEbUJ4p6gPyRpciLQfWyblyWe
 cA5D3Nwri4jlgCKFfdvbq0472BlJV+Gfy7ZefB6gUVGRyeA7MvgpT90nvPmzE4rlS3j2fNLU5pA
 u7JIulgfZ2ZhGy0rjhLPtng6SCHikEE+nWL591yoVnlKzv9mdWiFg/Cf2l86a7i36kaCRpnp43w
 m0mAp9LuBhnzkzAkbCT8dKP0BUTXfKT+J9+J/zqMP3R+Buw5iRtCiHF+RzSKvntukbqvY=
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
index cc6cdd3ae29d..4945d577ceab 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1435,6 +1435,8 @@ static ssize_t seq_state_store(struct device *dev,
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
+	if (IS_ERR_OR_NULL(drvdata->csdev) || coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
 	if (val >= drvdata->nrseqstate)
 		return -EINVAL;
 

-- 
2.43.0

