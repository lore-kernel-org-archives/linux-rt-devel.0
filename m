Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86D43EC81C
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Oct 2026 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967826; cv=none; b=C/yHqKgrez9JJMfu+f9xI876pVt3FX4d0N4CKlrnEj7KgB20dqFaWxywBo3L3VFQGEOaN7yv4Au9zznk+QF70AB+t/fbKIBPH/hv3a0Ix1mwBOkvRVXBKBrGPX2p07XNigeDbuS7BLiaGdjz3KQ3nreKCiAafcAfBgpyqnSPL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967826; c=relaxed/simple;
	bh=M/H8p54y9BAGRBok7Bq+l77HPKLtLrhketpnjFmnyH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CtGaSP1Q8fgc3B+ZPwXOLJ2q2NL8JnxlKFoQq6moaGWpIUZnWfY7eu54b8WtvkuQU1a62dVEUP5RfkWZlfAvrictVz0XnHOHqzwJMmJ+OPS6T94FxbY7xkwWQYSLHWsc8IGRkBonsGGPYWwKnJHFMj1XVJK8hgz3YBFtSBjlAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WfhCgDK+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WfhCgDK+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC900169C;
	Fri,  2 Oct 2026 12:03:40 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B45C3F85F;
	Fri,  2 Oct 2026 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790967824; bh=M/H8p54y9BAGRBok7Bq+l77HPKLtLrhketpnjFmnyH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WfhCgDK+9XhnjuR3De9jgnN/FGWV7aAaabtw2WRZQwoIqu1jMtHgDb8R36WqYIkv2
	 N6Qrz1c1UJywEo4Zh+8PONczt6qLbfWxAMJjTnBzaidXRLcziBiOX2T5XMz5oDua3o
	 XHuxCi0p0MUrXz++56+j3NrBs8NeS58J3NGQ4eyY=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 02 Oct 2026 20:03:24 +0100
Subject: [PATCH v13 03/14] coresight: etm3x: prohibit modifying cntr_val
 and reset while session is enabled
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-separate_etm_cfg_v2-v13-3-fe429d8d96fb@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=M/H8p54y9BAGRBok7Bq+l77HPKLtLrhketpnjFmnyH0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwAAANaCHRrJq1IZ+THa9oiCN1RzwHFjZqtQoL
 11fkBrmWneJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasAAAAAKCRBt1cPRWsUx
 M6znDACpEU8j77dVWTk+2JlWg/gtTni5kf9ZczFAGLyz3AWr9SML5TihyHoKluhPWtsea/K3uNE
 kjOydUDPPGp5JaV/HRWz5oiDBhZLRCiP8kZTIFoj2k/SvZdZOOYc5nhkPE/A8oeUTOvs5Oksft+
 RkfnEXWfVey0S8JakaGq45Tcq7bTz4sGXTy5wN7Sc4dsRCqiXjnwBTIeX908Si9ssOmSlqi7Tma
 fohyKtrQdvt3mjehFPZ4ppLAkRtXk4FTNgnQbhs3tmKz/pAJi78EbX3rWCPWHvSuBTLydbYqirc
 4zJsxoOWlE6iRcts4hRyvX9lYwH7nARggktYyIXn/gtUA3Siy7xYVP4PAJzHz+uX3NJI/i51r9O
 BdHB91LZdrLNZgTBsSxHZe5SazfjV6TqIcMVxzUY6cYSYlAXEJKn9UMMm3PmzTjKowehlT9DPrU
 Rx4rZMV1DX3BJoI6bVYy6lkjgEYwvHimRvQHJZyhyqeMFb/NPoVr5t8A6lmoehmjwd3Jg=
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

