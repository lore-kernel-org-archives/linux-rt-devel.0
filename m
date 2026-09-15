Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B81E4C1516
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472098; cv=none; b=n3cYIzTDi8PctRG0/lLRQFrpn+ozAHNhdCq0H4n00qjMDkpLCgLup0budxGk9zgx+cC6yLlpF0pg2D0/OKElBsyuYLddXInh2jcX7O367zIocG2pDdAImwBebLT4pR4gz71HMa0ivBOu0FnTVu61bPqvmKW5FQEa2spu1sIy6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472098; c=relaxed/simple;
	bh=OY9M4kkCabp+bV4ooKfCZXYd5uvoGme47JFL/fchmm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFW9thJw0L922SgjKp11xEOSYiesVI66+cBdrTNKwJ+83lhznuTCb/Ale8px7PzqDjnRRo3TboZ+vN7JQlbdglFM8qDBCRrCKvykOLp1uSB5ySgBtePDzdjJe+AXYqTGKMHB9VRVcmTKOtI645gTU/X5l6R0yYyEHZwkLfg48xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PFL3l9JB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PFL3l9JB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B5D21BD0;
	Tue, 15 Sep 2026 04:34:50 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D2AD3F86F;
	Tue, 15 Sep 2026 04:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789472093; bh=OY9M4kkCabp+bV4ooKfCZXYd5uvoGme47JFL/fchmm8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PFL3l9JBUgxUIxK2x05P+HdgTK88s1Tfe5qipYp9uXSOuU0fXAOKOrBrZBEIfkoYU
	 IYAbT1gL1IHrNUncP5pQgoj7TaQrepwRUyYa5nUU0B2MeuzLBke03UWQXzre+jrcqS
	 /POJl+B7DLSnizqbHN2UqmRA5W1/n+oYwNhPRutI=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Tue, 15 Sep 2026 12:34:37 +0100
Subject: [PATCH v11 2/9] coresight: etm3x: prohibit modifying cntr_val and
 reset while session is enabled
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-separate_etm_cfg_v2-v11-2-d2b258d51747@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=OY9M4kkCabp+bV4ooKfCZXYd5uvoGme47JFL/fchmm8=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqqS1TmYIRhSMz5EhthjcSwJUaxwuP8BpyV1qsT
 UcrhEL1dwaJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqktUwAKCRBt1cPRWsUx
 MzeNDAC7pg2DnobJUGrqYeiX7Jh3wLOoJOfPfXcMFQ6ikhLAt+4WFTQI/IpZouq+NTJXtAb6KZU
 B7sAyTKTyBpN0KfTsjozkMko6ZUgc7k97C+l/rYSdFf0Q214QI8QlQUMKslSiaWeCGWv1uk9cjD
 ZrPDmdRQKDOJzy7cwYWQTWuaR3fO4BNa0Gv4fYMaTfmrfCWaXQpY1ewGkcZyTioRUEcT3aKU0J6
 QincnIEvrKBxXPErZA72fbOuMtJHnieyAjRlvpQWm5lWjUIAm4tDXRaJtY2qLn1Qmmdgypjv41G
 MtWWPPsPTgJRyfTzEAAIeaVIEeg/8MC+KSaCMFXQtd51OdHSlHPr8tZ5OW1N0DpY7BjHOcadCO7
 vL6AOfh1egSer4UoD9eRcyehAXXqUFzUfbXef30MKxuBAFLtaTJCLeFR8ifE1vFSzVZYbnaoj1B
 pz+7bB6Kr2VVI8ZmId5ef113VnfGdMkzFByoGrZ0ywTsBbFc92ZYnbzTwRcbJSAw826gM=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

cntr_val are overwritten with the values read from the corresponding
registers by etm_disable_hw() when the session is disabled.

This means that any changes to this value made while the session is
enabled would be lost when the session is disabled.

Also, reset shouldn't be called while session is enabled.

Therefore, prohibit modifying cntr_val and reset while the session is enabled.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index b3c67e96a82a4..d4846d6364945 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -74,6 +74,8 @@ static ssize_t reset_store(struct device *dev,
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
+	if (coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
 
 	if (val) {
 		spin_lock(&drvdata->spinlock);
@@ -744,6 +746,8 @@ static ssize_t cntr_val_store(struct device *dev,
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
+	if (coresight_get_mode(drvdata->csdev))
+		return -EBUSY;
 
 	spin_lock(&drvdata->spinlock);
 	config->cntr_val[config->cntr_idx] = val;

-- 
2.43.0

