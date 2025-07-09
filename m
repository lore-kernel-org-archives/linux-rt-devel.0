Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA752E5B05
	for <linux-rt-devel@lists.linux.dev>; Wed,  9 Jul 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076070; cv=none; b=Uu5s4kx7kVe6bhOSU82C57Cl8oWXsPd2xoF6yaEkvPuKCUMJRSix67P7K1IgxB+UrN3gYFKJ/mpNmtFZ9XemP9olLOexU2Cr/F61tiQcBPnddhTsrBfjUa/yS96pRgT1E2lKXYW35r2whbpszHNxvkJzKAMg2D8OoJcswOz+6XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076070; c=relaxed/simple;
	bh=h6tMRQRXn67KOocJPl7gL2XSOaaSQRap9WsxQwDoJLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VIgelgfa0axidty26VzWKGmZVPFIDpe+KGFLDNdyWNTjTv3Q/xKmH/Li+xeH4RXt84QMzQOJqcakw2AhiHvYFmmHvQq6lKnJtf5BsfUnQl9fhbC2LYNa1hJjOyoXlbMVUdvVOpzeZ/eopJNYu1ZyOWgqY05+2yRak9zRrIeBFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VniV5qzS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VniV5qzS"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d54214adso41462695e9.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 09 Jul 2025 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752076066; x=1752680866; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4M7LELCI1cPFBstNSyN002g4c3zY7P9EeDdL35tmOwI=;
        b=VniV5qzSiIPy/lrx2q/Y30nbCmIDusYNsGjEdlLwgV5ippNYHdBSUO43jVYB+g8wx3
         9G2rq7FtjFyfqVZkA4jWWiJZyF3JnryUjjy4mziupykVNt5Uk1JucZze50n5yZ//Kah2
         JpDn26cUPOFZ0ZcP9NMutuJFg5QCdLeiEsvI3h+KSnoSZNKf4FF/CNqExy0bmpxcSfVN
         jIT2mH8qSxiG6nLbYIg+FFycUE7YLurudecFwr1RNbsVKkpl/JlOOyx5okbA2O//XRay
         fF1mY9wmWs6xN14Dq0u4N4dwQI9r7el3nbmcXqYXYfHW/1CgmI5wnj5gEScc8Of72T8+
         ouaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752076066; x=1752680866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4M7LELCI1cPFBstNSyN002g4c3zY7P9EeDdL35tmOwI=;
        b=oPU+IkdeuC2gRyFHOx3I0x5KRC+3K5LukEZGZDytWczCNuyNK8jIQLt6jl0wsEGRsg
         WQEsNpDQXQKq9F29Iyq03X6pIMo7QyPNe8oNUN/F5RBGrphNGS00pgOWw4+urW4YcN+p
         wo4diEmJ2crCqKvQPDvbNgwj9GfAt44Mqne9NsWYwNvyO9Xtg1CiIseiHuFXe1jBPbl5
         1KU1+8HYCHO7aab3OxK1D3tSHhqISTDJnC0yrRhp2Ah7bmYLrUq5rBNrbeBjDq5aldwK
         tXCapaGTryU9HzzPL34hUUr5E/22hTkbNCOESGYtpQp8rjPoYA5CNN0Z86TZbrtFDIiJ
         Yzdg==
X-Forwarded-Encrypted: i=1; AJvYcCXbklKzXKlHRHjMJwk9rvm3vG9YQnvUrEaWDc1K2VDP3O1RwNN790T+sfvLt32ecqSm+Uie6jZHhMsNiZPW8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz46tnsKSNL8P1rTX/o7kt0jf2WevbD81C770lp6PReawYytUS0
	nC3Texpa525211q3p+x0zDpSmaKXIupTs3RE2/zDYHOswvwSB8yepEvFoaFhnzPtghw=
X-Gm-Gg: ASbGncueaRflP1La2U1Ipw6FZg0bGl12S8aZNfpYiT5xTab2lQ1oR1sBSyoaseDGNYM
	CcwTTUQ+wP6qiKg4yXDBUoH4NAkCD1WQX/ilJZ/jypwl+ONt45r+GyeD+6p0Pl2FQ3+7cQD8dXy
	JTE34h4wsiKbubkXb8FuUWNtTduMzHUGZufnQM6RY82HiGdBA0pXamxl8V7UM1WY63awznBObkH
	m1roQ1jEfm8s2tQh5JgeUV35KUU27gU4bXnhe9JLwLhZmyAy6AhLnqcIJWO7RRZw+NpvXW0Rf81
	z9MlawPFdQoGwpIYgCIhtezFicEmtwHreXqFaBEkad5nrdAfdWYN4UWQqGfpdt0P5E7TgxEmaLx
	QidAj9hyl/H4c
X-Google-Smtp-Source: AGHT+IFtb3wKvcyNXV4wx2vLvybT75yPG2OAwmNgwliyjrb9KJP4FNMYX9tqHYbI3ZRouro6vvXlVw==
X-Received: by 2002:a05:6000:2206:b0:3a5:42:b17b with SMTP id ffacd0b85a97d-3b5e452a289mr2446888f8f.29.1752076065919;
        Wed, 09 Jul 2025 08:47:45 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97732sm16783647f8f.59.2025.07.09.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:47:45 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org,
	sudeep.holla@arm.com,
	ulf.hansson@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Raghavendra Kakarla <quic_rkakarla@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT))
Subject: [PATCH] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
Date: Wed,  9 Jul 2025 17:47:28 +0200
Message-ID: <20250709154728.733920-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently cpu hotplug with the PREEMPT_RT option set in the kernel is
not supported because the underlying generic power domain functions
used in the cpu hotplug callbacks are incompatible from a lock point
of view. This situation prevents the suspend to idle to reach the
deepest idle state for the "cluster" as identified in the
undermentioned commit.

Use the compatible ones when PREEMPT_RT is enabled and remove the
boolean disabling the hotplug callbacks with this option.

With this change the platform can reach the deepest idle state
allowing at suspend time to consume less power.

Tested-on Lenovo T14s with the following script:

echo 0 > /sys/devices/system/cpu/cpu3/online
BEFORE=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }') ;
rtcwake -s 1 -m mem;
AFTER=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }');
if [ $BEFORE -lt $AFTER ]; then
    echo "Test successful"
else
    echo "Test failed"
fi
echo 1 > /sys/devices/system/cpu/cpu3/online

Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT")
Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 4e1ba35deda9..b19bc60cc627 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -45,7 +45,6 @@ struct psci_cpuidle_domain_state {
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(struct psci_cpuidle_domain_state, psci_domain_state);
 static bool psci_cpuidle_use_syscore;
-static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(struct generic_pm_domain *pd, unsigned int state_idx,
 			   u32 state)
@@ -124,8 +123,12 @@ static int psci_idle_cpuhp_up(unsigned int cpu)
 {
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
 
-	if (pd_dev)
-		pm_runtime_get_sync(pd_dev);
+	if (pd_dev) {
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			pm_runtime_get_sync(pd_dev);
+		else
+			dev_pm_genpd_resume(pd_dev);
+	}
 
 	return 0;
 }
@@ -135,7 +138,11 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
 
 	if (pd_dev) {
-		pm_runtime_put_sync(pd_dev);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			pm_runtime_put_sync(pd_dev);
+		else
+			dev_pm_genpd_suspend(pd_dev);
+
 		/* Clear domain state to start fresh at next online. */
 		psci_clear_domain_state();
 	}
@@ -196,9 +203,6 @@ static void psci_idle_init_cpuhp(void)
 {
 	int err;
 
-	if (!psci_cpuidle_use_cpuhp)
-		return;
-
 	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
 					"cpuidle/psci:online",
 					psci_idle_cpuhp_up,
@@ -259,10 +263,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * s2ram and s2idle.
 	 */
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
-		psci_cpuidle_use_cpuhp = true;
-	}
 
 	return 0;
 }
@@ -339,7 +341,6 @@ static void psci_cpu_deinit_idle(int cpu)
 
 	dt_idle_detach_cpu(data->dev);
 	psci_cpuidle_use_syscore = false;
-	psci_cpuidle_use_cpuhp = false;
 }
 
 static int psci_idle_init_cpu(struct device *dev, int cpu)
-- 
2.43.0

