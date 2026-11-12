Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486566;
	b=KtpI7inM2dl56/J45lwGU167pzlKp/jEJuoBP+XGsbQ+rvHuCIAhH5QGpRrH1YhyNL94
	 DJOHHvjCu83m8VcT7Hsb9tuz8vgLcBzD4VtsuMJXgjUbn1exSwAjRPgV+UqXFQLQjSXiV
	 8IYrif4Ydyr/+9ph9gFH662LZWnN1Mm2Iz3WDAyHxU3UIKrhhyF2exAXM3UfEStX2uDel
	 6ThJ0UAtJI+TjgmlrqfVV0mZrqcVm8MqOFGE+EHsZQHsypwqFqP8/JqVGtlEWKzhNlJR6
	 N+GeY1zhTp+VkEriHQMtZLkYUDOYn28VQCfLnElTaAzYf2PZGoGBYNH2AWAUtkIMtdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486566;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=E3uK4ToIL2mUz3Svln8sWa7foOIYRKuRK6T5m3vJSVY=;
	b=ZDGoymc56CDtOTmVbT1s5pSEMcgfVy/ReVDMgp+IPgtInPlISUXoNFyxXfz8azrBaz0g
	 Cdi7K5UHeggj/69kL2dnuKtY2uXcJN32xWX09uqth33BaWlzgwmSHGkYAmH5/LKE/QmVl
	 DmpN3GbY9FH6x6j8QnmSgbthrZCgS5N1eqaSHL0o06do9++kWh98zcCWSU4lwsBSICank
	 pxWGMer3LMY8bo7SnOimMszyBM3Biy2N3PnqSFG7QYRTsKzP58c+Ox1QW5go7EEmPvV+0
	 9qIlnnEnVRNEQjGhMb7BpNhuaVy9RBp0e0VG3MRL8lXMkeJQw+w6H+DddZdjVhSeZyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB660A2611
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 12:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14EB660A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794486566; x=1826022566;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CVPab+eqiu3Puch8ckhPaA7dUxIgv7j+PTZCvvIA2cs=;
  b=jnM9Yh6fM4NlvD+BQRXrrm2z3lWdPyqPeTGi9Y7DGOhYxaOqjsroCCwI
   il0+eNrm+aPXI3UxG6urEwKv2cMX4IYgWkyNyxRhxaHQPRFyNYeJ9c6Cg
   64AOokeq+Zs0TK+4tDzusP8HvefZwRyaMqt7NtTrHuHKaZX4NuQPu7BJL
   NLWy/zNzBwgEl3Dwha9RwFH26M7l4U9gk+JuGBQbU4RzTSYIgRN8Db323
   1RYbNnSaMA4bWyjI9R5gPtmltq1YgFQMUZDlhoLjdNLmtlY1slIwzTzs+
   hvAJZtM+KgNDAVOFcHM2ZSHHyq9XKmqjw415qmI1awNeH/Xzu4kVs2vZe
   Q==;
X-CSE-ConnectionGUID: uQJ4eUr7Qim+j+ANDx/u1w==
X-CSE-MsgGUID: R6rfT2+pSEWZjMjI1QTOwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 14:29:24 +0200
X-CSE-ConnectionGUID: zrfLJ32aT/e9A3NIpkHx5Q==
X-CSE-MsgGUID: eQ1Chy+aQ7SpgWhbo53KEQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 12 Nov 2026 14:37:36 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 12 Nov 2026 14:29:22 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 12 Nov 2026 14:29:03 +0200
Subject: [PATCH v2 6/6] MIPS: eyeq6_defconfig: enable the CM3 PMU
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-i6500-cm3-pmu-v2-6-cd2569571819@mobileye.com>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
In-Reply-To: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Fu Chao-Ying <chao-ying.fu@globalfoundries.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.16.0

Enable perf events and build the Coherence Manager 3 PMU driver as a
module.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/mips/configs/eyeq6_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/eyeq6_defconfig b/arch/mips/configs/eyeq6_defconfig
index 0a00a201937b..2d06d9ed6526 100644
--- a/arch/mips/configs/eyeq6_defconfig
+++ b/arch/mips/configs/eyeq6_defconfig
@@ -19,6 +19,7 @@ CONFIG_USER_NS=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
+CONFIG_PERF_EVENTS=y
 CONFIG_EYEQ=y
 CONFIG_MACH_EYEQ6H=y
 CONFIG_MIPS_CPS=y
@@ -86,6 +87,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RESET_CONTROLLER=y
+CONFIG_MIPS_CM3_PMU=m
 # CONFIG_NVMEM is not set
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y

-- 
2.43.0

