Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486563;
	b=fAvM6zgCinKPJtbG8upQM6MnE3WREaUZ0zSaxYeKJiuwwtQAXVVC+zS6G1uloB5EqQAh
	 DAbnG4j8y+7YYnVo3Pgtf2z7/K11SPlzAUs1oo4focVYzKFx8BxpHelKYlfUXElFRiU9q
	 tl0c7RJlPM34DoD9RJkB9Yf0gAKwGBlrtift1apaViQuGtbL4iiMGOzVlvPCNnRyNjLC2
	 Hhtz80RrYvr/AaPyDn5NwWSTyFhNBzAdE8gaapL7OvT3ibfzq/nTuRkg/lvQ8jvMzkneA
	 99PnXhMhlN+Ew5uAf9CaxsKAObtF2N2ePXKhtEyrhsMVaeK/mu+zNth8rlqHsI94wsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486563;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=sFHPBhyxEeqzI/mLr3+tgL1IHWLq7an7I5T8KPeBRhc=;
	b=XUf0sCP3qbk0yV14ssUMRwMwonvtWRDrLvVm8DTH6bN03c4tYGRBkd9hluXl+9M/6HGN
	 g7hgULTh3wCFl/8zoQfdXQnpsM3/inIyNKGzv/sXRSEHi/VT/+qgOXscgu4oiVykhHhNI
	 UtwDXb7T6bh1Ggeg2P73rj0Scc29eoJ5eWRzwIkVMyljiLBlIUUnthN2K8kJgLm/NKne8
	 LZ+CGH890ZPvTI2ygRlrGggw7onHFrWXoi04Mmk42K6b1wa/CDYR6dzI3UK8MFkSwl5kZ
	 4Xh0IE4vR25NHSItjwb5daD+JAsoTHkAoUcDq9j1Ivd4DBbSoVajJDYqOFxdLCiQGnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE252606A33F
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 12:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE252606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794486563; x=1826022563;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=upY+Mz2RBSTRetbNF/wY4CRuGU76bONdjwh7Q0RZt1g=;
  b=QMJ8h0RqWhiFTWwvMy0Qt2M7mkoArtb+vRJG81Usx+0NilcXbV3bWy2p
   C4vXBtbm2l80bclbXxGZHM0PMaPtMYlZvVjVO+Z1pH4ewlDoTW6b6Ss1V
   6TiyEYwgc1p5c8VRdX1m/LSpNJkJnvhbXddWaKE/4zmuEJr68kgDFHj6u
   UFp1WFdCPjawCsCNGBcat2za1er+hdU11RAWLHfGwBKWOL/hcQ+86VyIO
   YAeOB7ckDVAeAyV9jAojBuIiMEUYRFbOBQl0Jon2CSQT04Ley6EYQA3Xe
   1eLM1liv2a1J/pG2MKPRtiYOGEnSS1Z1p148kQsbrgQbIBbNxsNW6MYLK
   w==;
X-CSE-ConnectionGUID: A9Ft6bOfS363m2fsTr3WDA==
X-CSE-MsgGUID: pBFlCXKeRG6pq8LrrN+aPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 14:29:21 +0200
X-CSE-ConnectionGUID: lQy6LFkCQWWNJrPd7fLgaw==
X-CSE-MsgGUID: F3m/1ulwTZiUE3VjOeK+8A==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 12 Nov 2026 14:37:18 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 12 Nov 2026 14:29:20 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 12 Nov 2026 14:29:01 +0200
Subject: [PATCH v2 4/6] dt-bindings: mips: mti,mips-cm: add performance
 counter interrupt
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
Message-Id: <20261112-i6500-cm3-pmu-v2-4-cd2569571819@mobileye.com>
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

The CM3 asserts so_cm_perf_cnt_int when one of its performance counters
overflows. Whether that output is connected to an interrupt controller
input is up to the SoC integrator, so describe it as an optional
'interrupts' property of the coherency-manager node. When absent, the
counters have to be polled by software.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 Documentation/devicetree/bindings/mips/mti,mips-cm.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/mti,mips-cm.yaml b/Documentation/devicetree/bindings/mips/mti,mips-cm.yaml
index d129d6382847..ca7a6717ecdf 100644
--- a/Documentation/devicetree/bindings/mips/mti,mips-cm.yaml
+++ b/Documentation/devicetree/bindings/mips/mti,mips-cm.yaml
@@ -38,6 +38,12 @@ properties:
 
     maxItems: 1
 
+  interrupts:
+    description:
+      Performance counter overflow interrupt of the CM (so_cm_perf_cnt_int).
+      When absent, the performance counters are polled by software.
+    maxItems: 1
+
 required:
   - compatible
 

-- 
2.43.0

