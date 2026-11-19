Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110704;
	b=b0d5tc8iJMdwKp2VfQOdQGHJjnvBlW8HC7I7lrQiN6mkoppRsJfHFywZ3lOBxgOvPsEU
	 j2oGo+mkz1CQzVx9BKMcpnolSdyjyMwZCuyxJT+n8D9K8839JpSU6bPXbXl3hiqF00W8Z
	 5Gu+ScKb6+5H5AVn4EOIC5/URUuxiwYHnmdLUMgs4ehhCWoReNsfz3RHZJNu5tmEI/fUP
	 JzwsKHGLksXWLqfjwk/Q7Sl3i7KOaf/dt8gRd4fV8wnNii61q4s0nvK+Gc6AXmh9Z7JGA
	 9GvOUroNM85SJ20ilzmVyiMc9OzOSZfmAxkhotFN5PZq9Cul9CzLxJOgPjNaebec/jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110704;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=PRm3Wwq9NQlmuKonGVqXdDDW70eXnhOzZHSNpZOZBag=;
	b=mv48g95zN8Jiqur7GZFMDfqKAPwGIhAsPi5CHsTLEdhPjN08TlLj2Ooxf8DG1qPnjayM
	 qWnsKt+DtBTcZhBdKNP2pWOstDEWQgqdvxyplbv77wx74+J+YfbpFRsgZZAEioFqiR5ew
	 /KVHoi72AmYyNA3osWfvBmZ2Xmuev+CTFKv1qpYjwOK4hHk2U2H+LrfhoowG2Mw/sS2KD
	 NozgMpYTsFdqH7Tsi4UBZ4skH04QUqvWDoC+UkiOS8i8o2G/GNIcfHj9DiqMoGSiqmDg4
	 VjKm+hn4YZ8DOSD8KuvggeCx0+yai3d4mQWTs9LA8kx545WaTYnEZmb9BpN4Sv8A8GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6CE60A261B
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 17:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A6CE60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795110703; x=1826646703;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tbxgL7ZsrTWsrmUOa0vRK78LFkh+IqmpmHZmgai13Hk=;
  b=IA8NZmJl/pUD7nMyTT12dSghLnsUFlCl1Qp3iN0iBwak/LhWhenMyZrB
   m0EQJao7mP7rsMwhymty+ZhzCfLURkVfom7SpTaHvhshyhpxtO7tWzx1k
   MG9HMmrfOFxjMRorg5QhhCT4rJSak2tBAogjF53Z7XT3xeyQyS5AvU/Aa
   tPs2vV5e8PsGR4BXb18+ZklOK2h65Qfp3UWiKbiAJzqdSUe+9wBIzP15l
   XBTE8MJhrEs2fn/sK567+JtE/qJYYATwTil1nuf2biEPrB1QlLUcvNRs7
   cmwzIobpOKqMKA+tSu6NpU03M8+RWgiJUtC8GcQK2VN0Xho6tFIPIDZ0h
   w==;
X-CSE-ConnectionGUID: 8OsyGipBQju0IQUaRhMs3g==
X-CSE-MsgGUID: wLzyBQAYQVay3C29PJZPzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 19:51:36 +0200
X-CSE-ConnectionGUID: NaK7sfVUSV+oJLsBsBliBA==
X-CSE-MsgGUID: ZLMV7MkCQwq8KSRROYyWWA==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 19 Nov 2026 19:59:42 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 19 Nov 2026 19:51:34 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 19 Nov 2026 19:51:30 +0200
Subject: [PATCH v3 4/7] dt-bindings: mips: mti,mips-cm: add performance
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
Message-Id: <20261119-i6500-cm3-pmu-v3-4-c86410934b51@mobileye.com>
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
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0

The CM3 asserts so_cm_perf_cnt_int when one of its performance counters
overflows. Whether that output is connected to an interrupt controller
input is up to the SoC integrator, so describe it as an optional
'interrupts' property of the coherency-manager node. When absent, the
counters have to be polled by software.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

