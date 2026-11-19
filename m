Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110704;
	b=MVNrIAE/q/8UqBcm+Ad5rryVZH0X5/Bm9xCAKY+tIz+f/FjoUSA8zjabO7MJDKBUv+yA
	 dyKu6Kf9qMtOvDlUC8nDqGIjNw7twz/At7ZUokUumXapqIvqGVFFQasSv74UX0ne4fZRn
	 +6+UnPTb45NPT5QbQROc0PLBtE3p5DiuOCIB2qDRiBHEzYETzaO20GvT25N3vYtNeXAHu
	 qPFQr4dD9SY74qZerVIjmK7NBAYVp9jlCzyYtAP0QxTQ2am/xDTjVkgqV4tGU3X1/IVlm
	 X9CTI0jppPIQMPcEbN5kUKoOjb2VMKdTKSfJAihh4xO7GK1ny7HaLAFuiSmbLG9vbEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110704;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=HkwgrMMAxh/Pa+gTNOwIrDS+SnvfT/r5RJMCGUHHVyI=;
	b=z9zjdiuSbwLio/GLZ4Zce+3Bc//F3tivBDKeWPjrldWiYNc77UP4CV4geiTp6y2YGHDg
	 s+RxdpVHvrl7oD4d5SOLRctv5E2unZqwpWAfh5qpvYPiJeCLfVf0fihdjnuEYtbFu2K3l
	 MVhqxQW2lVNrYRQsEm2g/V5TE4kkWtyHk/C0PDICwUuROmj4A6EFTFw5XEDWGGQLAVYV/
	 NkwHWJC7uf1GTvNjMi/bv7gA/+liB9GyhWmpu2b3HvJSnC3YU7cW1lkvmCA0ItZfeDD4e
	 zv7vBCtOPUG0e2YNMv/piCjv6S86pgTZDUBBdXXParPlIx1oGRyl5/z2NlXsIjq7umA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94960A261C
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 17:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E94960A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795110703; x=1826646703;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IPMwiZyW2lp+dYhB4kV60JlONdGVqmGhSYHG6tuUBlI=;
  b=XHhd+AsDVBNj03Az6HI4fWx0OdaEjIV8CwfuzmIFD4P33qYMzFQMxtY5
   T2+rcP+V+UDy2gRC12Jb4D5Mji0CBslBxNUraQ/+k95wKOHAglzqTcfUL
   RYyU581LmyICb5myVqLp/dSk5pKvk1I+Tccl0WZL09YeLtZ09zbR3AWTE
   H4PdaoEvLFBU+C3hPZUAPdkoYP/QZA7XpNzbqMEma+sx4M3QGaMTsBPK0
   VPgI3zbalqp0aTpR37by+JeQJSCsoKEmmYur5IXUFJ7r2t7lX75o4MmTN
   KaU8vH50vgG5lPsPLBAErFvndwl26Vj6yBVXUuPhv4KYNxKuStRZeOHz7
   g==;
X-CSE-ConnectionGUID: XajFCRX+T5yKzgHzv0RGZA==
X-CSE-MsgGUID: hyzR9tCgSGCQ05ZhUqnMMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 19:51:34 +0200
X-CSE-ConnectionGUID: 5cYxBOppS6yTI9fIKR4pkg==
X-CSE-MsgGUID: Nc5ZvbX/QiuTzDgmA3BT0A==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 19 Nov 2026 19:59:49 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 19 Nov 2026 19:51:33 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 19 Nov 2026 19:51:29 +0200
Subject: [PATCH v3 3/7] MIPS: CM: export the symbols needed to access the
 GCRs from a module
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
Message-Id: <20261119-i6500-cm3-pmu-v3-3-c86410934b51@mobileye.com>
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

Allow modules to use the GCR and CPC accessors from asm/mips-cm.h and
asm/mips-cpc.h:

- mips_gcr_base and mips_cpc_base are the mapped register blocks;
- the CPS_ACCESSOR macros consult mips_cm_is64 on every 64-bit register
  access;
- mips_cm_lock_other() / mips_cm_unlock_other() are the only way to
  reach the registers of another cluster through the redirect block.

This is a prerequisite for building the CM3 PMU driver as a module.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/mips/kernel/mips-cm.c  | 5 +++++
 arch/mips/kernel/mips-cpc.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 3bfe85e86a9a..ed98021418b5 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/of.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
@@ -14,8 +15,10 @@
 #include <asm/mipsregs.h>
 
 void __iomem *mips_gcr_base;
+EXPORT_SYMBOL_GPL(mips_gcr_base);
 void __iomem *mips_cm_l2sync_base;
 int mips_cm_is64;
+EXPORT_SYMBOL_GPL(mips_cm_is64);
 bool mips_cm_is_l2_hci_broken;
 
 static char *cm2_tr[8] = {
@@ -373,6 +376,7 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 	 */
 	mb();
 }
+EXPORT_SYMBOL_GPL(mips_cm_lock_other);
 
 void mips_cm_unlock_other(void)
 {
@@ -389,6 +393,7 @@ void mips_cm_unlock_other(void)
 
 	preempt_enable();
 }
+EXPORT_SYMBOL_GPL(mips_cm_unlock_other);
 
 void mips_cm_error_report(void)
 {
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 4b50c58628dc..b948a1c96e1e 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/percpu.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -14,6 +15,7 @@
 #include <asm/mips-cps.h>
 
 void __iomem *mips_cpc_base;
+EXPORT_SYMBOL_GPL(mips_cpc_base);
 
 static DEFINE_PER_CPU_ALIGNED(raw_spinlock_t, cpc_core_lock);
 

-- 
2.43.0

