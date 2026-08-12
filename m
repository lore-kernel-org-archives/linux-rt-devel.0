Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B379317145
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514018; cv=none; b=WlLGeNwHngjclxK0QpII10aAy6HoMgarPGCXO7auG5UwHFYRignlYQl72jQ41UoxDY80E5BRY5ucFH3Vr4YK9ntdAY4C+bt+YP+vZTRO7+dEDXnEmQexLNS89zmHw5+GrRrKZEUwb0e8qElSzSsnlPEe/JxZ02JGkBbR3lPC/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514018; c=relaxed/simple;
	bh=z9SqsVTupF6vkjCZpgGoS377DCcrh5k1AI9S/5F9788=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NFmiIWJlbcpBoE/MSnJarSn/7VlToplDvFJ2zvY4Bd7MTsIJhVH2XRtdn8UBXLMEguh+51WEwS+/mNFS4e/HPITvM/gEg8OrSOHYR8Q0bYkqJwkRVVD7CzbnuPhnt2hCmn/eP32zhxKeqKQ5AOgRAiMCiDiEmCrjubeKRFWK0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 12 Aug
 2026 13:48:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 12 Aug 2026 13:48:26 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 12 Aug 2026 13:48:25 +0800
Subject: [PATCH 1/7] dt-bindings: edac: aspeed: Add AST2700 SDRAM EDAC
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260812-edac-v1-1-03992edea297@aspeedtech.com>
References: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
In-Reply-To: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
	<linux-rt-devel@lists.linux.dev>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786513706; l=1387;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=z9SqsVTupF6vkjCZpgGoS377DCcrh5k1AI9S/5F9788=;
 b=G01N5R7+EbAExh/xiJj8baWQ66EJngCPmhBj+mvEAm6w44/buhkUU6kIZAAKLyZ5YhYuXPpae
 fJ/1iQBhWCkD9YnfO+l5NADP/X2H36c3D2fzXW6l10l/F87q0aea1xf
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add the "aspeed,ast2700-sdram-edac" compatible and note DDR5 support.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml         | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml b/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
index 09735826d707..685b6815f293 100644
--- a/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
+++ b/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
@@ -10,8 +10,9 @@ maintainers:
   - Stefan Schaeckeler <sschaeck@cisco.com>
 
 description: >
-  The Aspeed BMC SoC supports DDR3 and DDR4 memory with and without ECC (error
-  correction check).
+  The Aspeed BMC SoCs support DDR memory with and without ECC (error
+  correction check): DDR3 and DDR4 on the AST2400, AST2500 and AST2600,
+  and DDR4 and DDR5 on the AST2700.
 
   The memory controller supports SECDED (single bit error correction, double bit
   error detection) and single bit error auto scrubbing by reserving 8 bits for
@@ -25,6 +26,7 @@ properties:
       - aspeed,ast2400-sdram-edac
       - aspeed,ast2500-sdram-edac
       - aspeed,ast2600-sdram-edac
+      - aspeed,ast2700-sdram-edac
 
   reg:
     maxItems: 1

-- 
2.34.1

