Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433864;
	b=1g9XsyqYdx8gcP5okWyGogzomw5be564VDnEwKbBtsxNt3Q8wMZYmGmxdzSn65CuKq0W
	 wCdF4pH5f/+bsRCW2RUgkLmdsmqDVBjDw24bEkN5Vv9I1aEnifxNMDJk/AV6Fowteyyb/
	 24HqNzCI7Vn8Oe3JzQgFENbbBWxrB8ICvhHOU3aW9ADZP6BZNmuQihR4urHtnAG4sUZJt
	 SDama2ozbaqnUkTkkOyw2DgzqOyzinyCUIhvsSSURBqTotRJ/6jQNgWyqz2CzCMAJcWvW
	 l0LWyPYsdJYfixmebibsxkz+xp0EbQl0XNmG1S4vPZgX3O023rLqNA8UNhyDrIQFXsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433864;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=E3uK4ToIL2mUz3Svln8sWa7foOIYRKuRK6T5m3vJSVY=;
	b=O3eKJ5v/oOQ+KoT/EnfSb9tJiI69op07b/k7N5mp05+yi2nNkKnle0+UdI6DBH8MtMZT
	 geqgVo9vA8yu7EK6O497vxVbWc8iNDZhMaRI4E2g9qIjAI+FrnkGKLw/LSu+eQuDKKqbj
	 ahPa+8kNxzcKgNQHqQV0+1ff3zW3qUF37e0mcmdvNHt2iBOo2BwetS8MTmWX05dGHTAOL
	 0BkM6mXPNZG5+gJ3XIvM3QbYRsbiTuceSd6cIHVJ//Si7C3QxLuUnHTh1BABSv+zYjHF5
	 gPghtKumeO1OC11thNejtKZDPZKLZX2b51KEpo23GltNG7L9OEwMpwBL2Zfh2nzjGpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C7C60A261A
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 11:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C7C60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795433864; x=1826969864;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CVPab+eqiu3Puch8ckhPaA7dUxIgv7j+PTZCvvIA2cs=;
  b=Neio7NhVEurNxzZEW9jbJg4udMq21d9NOgrcuVwzjOvAOaCKbquv15jj
   2E3IJQ5pdA9AU8DRhyPTfYCeMhbys+I570sJV7p5wsXPhBPceu66PoYNk
   2Lxh53jJF68LYZBSTUMp0vFjm+zmOltiDKddQ/ZBU/Jk1iJ2sWjpIDEHu
   Ll0/PsxJZwh2L1Ja+x2AJ/qa3yvtImQ9/0jcP+c0elRL6289kIogo7ac6
   /d4nUrYjsKyvZeQjvIybDdBURyTwqCyWVEoojR4E+vtjEti1kuaP48usY
   9E5B+BaG7joQo6tmQ+bfX4KCwtih1RHSv9a+/8QGtB1wr4h8hNrvcA/W1
   A==;
X-CSE-ConnectionGUID: eMyySaelS0mME+nq6mO4Tg==
X-CSE-MsgGUID: dN1reAX8QIW+5Mj3rHuTmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 13:37:34 +0200
X-CSE-ConnectionGUID: ZNX9Ay/VSMu6OR/oF7HPcQ==
X-CSE-MsgGUID: hyqSjWXXRm2C+ZdHMiz/Ew==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 23 Nov 2026 13:45:54 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 23 Nov 2026 13:37:33 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Mon, 23 Nov 2026 13:37:15 +0200
Subject: [PATCH v4 5/6] MIPS: eyeq6_defconfig: enable the CM3 PMU
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
Message-Id: <20261123-i6500-cm3-pmu-v4-5-5a9f5351688f@mobileye.com>
References: <20261123-i6500-cm3-pmu-v4-0-5a9f5351688f@mobileye.com>
In-Reply-To: <20261123-i6500-cm3-pmu-v4-0-5a9f5351688f@mobileye.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
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
 linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-hardening@vger.kernel.org
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

