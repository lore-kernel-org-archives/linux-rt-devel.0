Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433861;
	b=YaoXILNuepQaSVKoWZswUZJc8/Rl5Kaf68Oq8Hmhkb+Hb9Ox4C9hMdRtXcjZRFbwEIo7
	 3SfOx4UC4flL3Rv/34TNDlAkftzVz0nbUe2SnynNzrRhPsyi9zN5X2qU1LnCQO6dT7Zkx
	 nppgp+hV6L2nTqAOdKop/eXiHgM1+cVASwZsDmLuHrcMjhSbIcRDUQM88A/byKRP0KN1B
	 W+rvdSaIUvyl3xCiEv1XpOU0ckc6sLWHLtkrbZRhWVnW4Hr0MS5dxGnvL65RI9JTee/o/
	 z6zeDcElee5nFV86yGSHFzFLVbbXcbu2v2+ETJ+kGL1sCHG5QTJteD5sXF/r2hWYtKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433861;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=HkwgrMMAxh/Pa+gTNOwIrDS+SnvfT/r5RJMCGUHHVyI=;
	b=hgJ2CkPU6HNAAOH34LhhirSFeDBW3pg386HDRpO51pwwz/7dwZYQX5jR09lFhsSaa147
	 iJ2J8AHx7Z3mPZ+LtjyuSPiZomW2PyFUicgT8ITHRhtjMF9nfhM+kGaRTztdM5r0V8JfD
	 VBoChWA7tTdEqIXdht7ksxVWZdQbgSzlpeaLn6kKFAH+OyMU6oJ0hw1pggiZ95WpB82Xf
	 M+hwJ35wFFfMn8N6U4gQgW0UoDh8bVTC4c0DHICsKPonecYDIR2WH+BDpcy8SlGAoFJso
	 5vlenav2kXi0GgiGXqwQnqlc15JmeXBilmI29V0lNXU4/9qTfJ7lNunixSvWzsM+Nrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F7606A685
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 11:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 860F7606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795433860; x=1826969860;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IPMwiZyW2lp+dYhB4kV60JlONdGVqmGhSYHG6tuUBlI=;
  b=eg8kXp1k/jB2zezXGjYkWwhYXsTZlkSfxDSr/0MHt6ChNM5f5XFBeLm7
   9ziXBQSw3P5S5kfHphGlvFBJwgDsLY38axp2kQvymm4YELVXqpcPIl4sa
   1DO8kAPPj/5SkNWHUnz5+KrjkHCw65aJXjuJeOXc2U3x99XA/PK++LcV4
   9J7zGQ0aDAJmQf+cKGWU6ms4gkZpW4loGCMjT+5ZHslxMOmWezECn/Guz
   K2yjbFkHAqfy9LVh7EAVMA6qg3GVBtdCP9odewF5tC/z3b7yAojPJ87k7
   POw+7gIuqkBGtnBkVdqs9oN6wgcLwO2KfORvjlFLKY/PEwECc8Q/mNajl
   Q==;
X-CSE-ConnectionGUID: dDe7KE8KRK6djsam4khyug==
X-CSE-MsgGUID: afRqZavDSICQzAvf2anloA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 13:37:32 +0200
X-CSE-ConnectionGUID: Vhq26FS/TdiUFJJs3EbqDg==
X-CSE-MsgGUID: NZDwNoOGR5utMAr3dMf9dA==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 23 Nov 2026 13:45:58 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 23 Nov 2026 13:37:30 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Mon, 23 Nov 2026 13:37:13 +0200
Subject: [PATCH v4 3/6] MIPS: CM: export the symbols needed to access the
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
Message-Id: <20261123-i6500-cm3-pmu-v4-3-5a9f5351688f@mobileye.com>
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

