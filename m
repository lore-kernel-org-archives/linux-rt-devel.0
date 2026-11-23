Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433862;
	b=uB242U5oY6xl//FfCo+sOFHYJr1S94iTW+nX15z1x8qtOdVr19LD3UL8ixQ0sSURBJXA
	 GG7knoGWLqpb6pVsWdalQxTQVJXGawhzPWjVHMnGyUx3Gc+6qH2WcNaCjwaJ0eDRMowH2
	 6taK5QzOy7dEPd5WumNZELLxB3nZ4Uf59cFqqqCUkPPgYn81slwkXPivlOYGkwVhwhZFW
	 tSO/BaTMs68/6DxOCvQoFswKy1sNKfDZ4k4o+byFRDrJWf51ruOEZkp6X28EC2ZVkYas4
	 GaSsUw5C2i4ZpOe1C9JF7QHCtkTjafiaPtNiCPkK8RtUt4i1WgZ35SVKJFREWZhRQoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433862;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=lyATTZSpPwfe+0tTFDl9okuYREBYcyzOpR8HimDcF54=;
	b=h4GfhGeapKJUBqUB0A4Y2tW07aETgV1IQFkcKkOICvBN8599pCH5Sfdml8hGjtZy98Mi
	 hLALRy+JLdNDfsOvPfQu3BHWdgZNDwThvk4IMFL6xB0ihr4ooh2HGyZhzmxFu7lZVz5oZ
	 x14JqDdYBAOXw6rscT73jBC8323myM6fjpLfliRXFIVKAqRIY2Mot+4Vi/pS5uITN0/Ku
	 JKF9cRy/nH+ue946A8Jl643rsCNM3D36mUOiz4U6iH6Bs4VaRoLOU7Be8wOqXCQDEXr6c
	 GhYpH3B+QOW2ywP4qG1CLHZdujR95jUm5uKI3T5eQk5gZ7um8T8fZdVxTkY6/L0X9+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A2606A337
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 11:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A3A2606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795433861; x=1826969861;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=huVfTbErH6adnt9mw42pnrtw5P+Ckl7UHBlLJGXkTlo=;
  b=upQSKjSjx0l23acvVRXNG2tlamIA/8JsmKH61FSjRNzFsSjg8U158hry
   s6U88QWsYXGzRybKCi1x1CUPlzDbruuAUGI6k143lm6JRcfwQUeHK0rzC
   EdPMXTuum0nisXlT9SA5qkTgKBmcHhPPSy0Urp/s0hrQ0ROL8BkxmWRcT
   7Ci/7ZLb94iTetCfyuri3Ds0ciGhifMxgWY1vqS8D2/vIhKakOEMly0EX
   SUwZmcTqeYMXF1pNa2oy7fWx29Rmxu1+cR/REa+xJIPOWRFkaF333eVrs
   0X75FpjZ93csMQtHpSdb61DgJBuhulEptrhGkOw9EL389fa1JvqoSu2Kw
   A==;
X-CSE-ConnectionGUID: dDe7KE8KRK6djsam4khyug==
X-CSE-MsgGUID: f8MAgeLeSFWH/iABTroVsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 13:37:35 +0200
X-CSE-ConnectionGUID: T/+ivEZMSnequjDciurdfg==
X-CSE-MsgGUID: HzNCZGvDT7KSUg+TBTkCEQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 23 Nov 2026 13:46:01 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 23 Nov 2026 13:37:34 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Mon, 23 Nov 2026 13:37:16 +0200
Subject: [PATCH v4 6/6] MAINTAINERS: Add entry for MIPS CM3 PMU
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
Message-Id: <20261123-i6500-cm3-pmu-v4-6-5a9f5351688f@mobileye.com>
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

Add a MAINTAINERS entry covering the driver for the MIPS CM3 PMU

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 782389bd5cd3..e9a02076017b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18227,6 +18227,12 @@ F:	arch/mips/configs/generic/board-boston.config
 F:	drivers/clk/imgtec/clk-boston.c
 F:	include/dt-bindings/clock/boston-clock.h
 
+MIPS CM3 PMU
+M:	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+S:	Maintained
+F:	Documentation/admin-guide/perf/mips_cm3_pmu.rst
+F:	drivers/perf/mips_cm3_pmu.c
+
 MIPS CORE DRIVERS
 M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
 L:	linux-mips@vger.kernel.org

-- 
2.43.0

