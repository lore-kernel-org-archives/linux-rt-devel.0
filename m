Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110703;
	b=lhccMQHPrjc6ZmmILnWySd54jaYnyloWaamMPRu8VKhOzMVJSANaLvVJCoqvmROMImJ9
	 LHkry+guxqCiAkMrRSR2cqgmme67f46ZDPYEjrfmNAqMZ+ByZTuDSpNOm2VDZOWSqYpev
	 lr9UKBGFhxhbaKSLpS/XMQVtJ9/gUMiO1/fcrMyxVLvIzrWNVC/Lb/Ae2AH8GODlheoDl
	 TOvNMLm5DMjnKsaWW0ycUjH62YlAFnO302rUUNiyZGUH+Dyk5Ff0sFRyVYwpk49NpuAfI
	 6wxiiXkIQ8u0Yu+/H1WvL7rX8IXyDYhddzN2wfCef1A3LeLJ1BVL/Swk3JzWEeQ3yjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110703;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=CedYSSN4VmRSUUDOCoWWB86uIFN22b2CcBsb82DlUJU=;
	b=BVycMlVYfQTzvfPP9p8anNtMwhjpezabbqbVTLfX5t8sA2LXkQGgzWmHCZQYmrGlxATl
	 +HzmgxSpJaNJk/rYCYQZPaU6gmM2gy9C/CLF2h7kiohaO9sgU+7MuA7EcePEfO6O/ow8p
	 gpqZGEBxaI9OQ3VAx84roZP81fkRCy6xrcBb2X3Qjugj774No53tBf1CxxUgBy+YNQibg
	 l9sgGGmD5P/L6NjAeAhjqrmSi3rxF5t1ajWixyP5HGzr6/c0WyzbqrKj3pyB1VQV2ZIMZ
	 rJAIj+DHvXVK+nlPq3bBBtdJg+eVBR8DvmmS3tgENkSYKAqT/xgZCcQkmlUBpBhN8vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C60606A325
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 17:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C60606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795110700; x=1826646700;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=L7G8bdD9wp+VJx4bnBPXDO6O3hytAVV8cw1v6jTr0PA=;
  b=g8FmhinB1EqiMcp3FZm83QLzJ41K5qKggnW3hfiUVSWUuhrWo9NZGA5V
   J0VGePZXws/dFLnZDcyBj69p5JY/6Wh02fx42U2SLXVSuSjWPVmYVlHFB
   T/I9tqtoFRrF2WC1XOZxitOs/uqw8Eu/0IQNhi7Yheg7AANM9aokwgLIR
   /E1tTYjzbMtllvPPVNElbZdCuMJZor9v6HXvVYAXHsN0L4VS7P2IGoA4X
   KljIuytBv3rguYddUfdA+LPL9/rN2dsWo1bLGPV009RrX/nDbB/1cUkfw
   oe44RQa5++klTj53huHY5jJdG4eBrmrHklsWo+3yJxx2SZpSyyoEtdLFr
   g==;
X-CSE-ConnectionGUID: XajFCRX+T5yKzgHzv0RGZA==
X-CSE-MsgGUID: 9eWaYQd1TDadi0tZKSJpLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 19:51:32 +0200
X-CSE-ConnectionGUID: zePeCnaBSnuCurSiN3xmsw==
X-CSE-MsgGUID: TgesIyceQZm3mT7ScHrYig==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 19 Nov 2026 19:59:47 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 19 Nov 2026 19:51:31 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 19 Nov 2026 19:51:27 +0200
Subject: [PATCH v3 1/7] mips: {cm,cpc}: Make cm_core_lock, cpc_core_lock
 raw spinlocks
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
Message-Id: <20261119-i6500-cm3-pmu-v3-1-c86410934b51@mobileye.com>
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
 Paul Burton <paulburton@kernel.org>
X-Mailer: b4 0.16.0

From: Paul Burton <paul.burton@mips.com>

cm_core_lock and cpc_core_lock are used to protect access to a CPU's
core-other/redirect CM and CPC register blocks. Since each CPU sees
its own copy of this block, we need to ensure that critical sections
holding a cm_core_lock run on one CPU - ie. we need to disable
preemption.

Use raw_spinlock_t to implement cm_core_lock and cpc_core_lock in
order to provide the guarantees we need on PREEMPT_RT systems.

Signed-off-by: Paul Burton <paul.burton@mips.com>
[added CPC part]
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/mips/kernel/mips-cm.c  | 20 ++++++++++----------
 arch/mips/kernel/mips-cpc.c | 12 ++++++------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 7c9c5dc38823..3bfe85e86a9a 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -179,7 +179,7 @@ static char *cm3_causes[32] = {
 	"0x19", "0x1a", "0x1b", "0x1c", "0x1d", "0x1e", "0x1f"
 };
 
-static DEFINE_PER_CPU_ALIGNED(spinlock_t, cm_core_lock);
+static DEFINE_PER_CPU_ALIGNED(raw_spinlock_t, cm_core_lock);
 static DEFINE_PER_CPU_ALIGNED(unsigned long, cm_core_lock_flags);
 
 phys_addr_t __weak mips_cm_phys_base(void)
@@ -309,7 +309,7 @@ int mips_cm_probe(void)
 	mips_cm_is64 = IS_ENABLED(CONFIG_64BIT) && (mips_cm_revision() >= CM_REV_CM3);
 
 	for_each_possible_cpu(cpu)
-		spin_lock_init(&per_cpu(cm_core_lock, cpu));
+		raw_spin_lock_init(&per_cpu(cm_core_lock, cpu));
 
 	return 0;
 }
@@ -347,8 +347,8 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 		 * mips_cm_lock_other() leading to a deadlock or a nice warning
 		 * with lockdep enabled.
 		 */
-		spin_lock_irqsave(this_cpu_ptr(&cm_core_lock),
-				  *this_cpu_ptr(&cm_core_lock_flags));
+		raw_spin_lock_irqsave(this_cpu_ptr(&cm_core_lock),
+				      *this_cpu_ptr(&cm_core_lock_flags));
 	} else {
 		WARN_ON(cluster != 0);
 		WARN_ON(block != CM_GCR_Cx_OTHER_BLOCK_LOCAL);
@@ -359,8 +359,8 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 		 * race with us.
 		 */
 		curr_core = cpu_core(&current_cpu_data);
-		spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
-				  per_cpu(cm_core_lock_flags, curr_core));
+		raw_spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
+				      per_cpu(cm_core_lock_flags, curr_core));
 
 		val = FIELD_PREP(CM_GCR_Cx_OTHER_CORENUM, core);
 	}
@@ -380,11 +380,11 @@ void mips_cm_unlock_other(void)
 
 	if (mips_cm_revision() < CM_REV_CM3) {
 		curr_core = cpu_core(&current_cpu_data);
-		spin_unlock_irqrestore(&per_cpu(cm_core_lock, curr_core),
-				       per_cpu(cm_core_lock_flags, curr_core));
+		raw_spin_unlock_irqrestore(&per_cpu(cm_core_lock, curr_core),
+					   per_cpu(cm_core_lock_flags, curr_core));
 	} else {
-		spin_unlock_irqrestore(this_cpu_ptr(&cm_core_lock),
-				       *this_cpu_ptr(&cm_core_lock_flags));
+		raw_spin_unlock_irqrestore(this_cpu_ptr(&cm_core_lock),
+					   *this_cpu_ptr(&cm_core_lock_flags));
 	}
 
 	preempt_enable();
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 3e386f7e1545..4b50c58628dc 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -15,7 +15,7 @@
 
 void __iomem *mips_cpc_base;
 
-static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
+static DEFINE_PER_CPU_ALIGNED(raw_spinlock_t, cpc_core_lock);
 
 static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
 
@@ -74,7 +74,7 @@ int mips_cpc_probe(void)
 	unsigned int cpu;
 
 	for_each_possible_cpu(cpu)
-		spin_lock_init(&per_cpu(cpc_core_lock, cpu));
+		raw_spin_lock_init(&per_cpu(cpc_core_lock, cpu));
 
 	addr = mips_cpc_phys_base();
 	if (!addr)
@@ -97,8 +97,8 @@ void mips_cpc_lock_other(unsigned int core)
 
 	preempt_disable();
 	curr_core = cpu_core(&current_cpu_data);
-	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
-			  per_cpu(cpc_core_lock_flags, curr_core));
+	raw_spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
+			      per_cpu(cpc_core_lock_flags, curr_core));
 	write_cpc_cl_other(FIELD_PREP(CPC_Cx_OTHER_CORENUM, core));
 
 	/*
@@ -117,7 +117,7 @@ void mips_cpc_unlock_other(void)
 		return;
 
 	curr_core = cpu_core(&current_cpu_data);
-	spin_unlock_irqrestore(&per_cpu(cpc_core_lock, curr_core),
-			       per_cpu(cpc_core_lock_flags, curr_core));
+	raw_spin_unlock_irqrestore(&per_cpu(cpc_core_lock, curr_core),
+				   per_cpu(cpc_core_lock_flags, curr_core));
 	preempt_enable();
 }

-- 
2.43.0

