Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110705;
	b=sONwVKsJmEZW2wcKAGvJwlvcZy055Wqggxtt6XfZk+S6eDbLlsjonvhcAg/qwwPnTZ5g
	 beX2UToZt6pZd3/lu5PZah5n+1ZqtDAxdnyRwWTN4vbXAiidwNsKIum7GCKZwlS9e4D5V
	 CDC/32VshjOUoEBdpbbp7EShCizB+5m8TIl8ei+j01Ldw17SqLWzAio2IGHI1qOXf6DRV
	 uVyEvPxZwt8DxZvF8avfO0YiUz+Cef/a/kQaK6bGgl2qk1YMfJyK4NAAAZwO5hYrOCmd1
	 56ZXQhT4TJXCAFOlCDJAgWioxzgqabIpAIq1VV2XPfOpyqF0HAl7nCOWN0V4tk0u/xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110705;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=lyATTZSpPwfe+0tTFDl9okuYREBYcyzOpR8HimDcF54=;
	b=QJAeD3/G6ggr8nx2tTDEZc+DS/6n2A6e0MQ5/gwEvl3LcgtOKvMoYdo6E/6EWJzhcI9Z
	 Ch/p0BRkxvF93gs50ty5yePL+e+TxfCcF1io9vMBBVBqkDpshLs4qACx7exXTg+GjHksG
	 LrkMliFpkESut2KVeIDtyDfnCwTJ9+1694/1uUSWsvJFB2bx5PoLiDJ/84Q9SscE9nJ/v
	 WJ+woW7iE9DgwBhY7yIBjawiZdLN842Y5VgjCC3fbzJkH/W/SYdVtaJ2jf9qLdrFo7RzZ
	 lrDcAzHJWye/7+weXcGlvYwAjuqy9Dxp38jC2gWhR8Ufdxh8RB2BShkF3jqNfbUIKeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB4B60A2630
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 17:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDB4B60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795110705; x=1826646705;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=huVfTbErH6adnt9mw42pnrtw5P+Ckl7UHBlLJGXkTlo=;
  b=sGSgZRhtkICOORFYDY7mAB57pywWHb/qH546sJFOz9dtpT5bItTSDrM7
   AKJw39mT8fmePFf4jIlYF2aEXXQjA9b4xwTLayUrOtup7WfhD0X11x082
   u0izI4iCrmhkiNey2o1z3DjKRO4eUjEhB9oXoe29l3O2L/2NR3B2YHAS3
   bdDQmAypHMHDQrU/Hm2+tSax8SNd1bEAj6jiSaoghkgIl4dkyxRTs5tNe
   nAmhsZYk3qUBr+8Q/PqN74bgsEpzVx0ppoZBNL8dCGxuTTNhdcT182ec5
   FPMnX3OcWY9K+WEi+7nJjsXz9mojL75VOdFzhBIFIfHaq4q+Wqb+cVLyX
   w==;
X-CSE-ConnectionGUID: XajFCRX+T5yKzgHzv0RGZA==
X-CSE-MsgGUID: +NESDkYSRHmZTnlarKjF2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 19:51:38 +0200
X-CSE-ConnectionGUID: ri2IGrxzQdOPJsIu1/kODA==
X-CSE-MsgGUID: ODobeq1NQgavWhZ8D8UMoQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 19 Nov 2026 19:59:53 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 19 Nov 2026 19:51:37 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 19 Nov 2026 19:51:33 +0200
Subject: [PATCH v3 7/7] MAINTAINERS: Add entry for MIPS CM3 PMU
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
Message-Id: <20261119-i6500-cm3-pmu-v3-7-c86410934b51@mobileye.com>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
In-Reply-To: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
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

