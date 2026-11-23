Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433861;
	b=M22x2o6Jf3Sm7oFwvnsSPikIPmbb3LYJpXLNOar2fJiUjbR2Ca8ixDqmGTNdgjByCVdx
	 WCRjBvjCpSc1kzDJWUQ53vryONyHzXSl/LQq9Tf+nq65Rf/e6krKwG8kFF9oCjEwjrL1R
	 zPlIEXsPwubV5QnSkR7Y7UGNdPeiUNbG5dCIvjT4TI7zB31v3AxH5AAErSkgPyBJ801vX
	 XgHI4qbKHV6XiFcPnIlF7414NJPUMjDroRXV4HNeeV6TtuaKoJhneBqFgOKYerv6lEajS
	 WAje4CtQTvFOExlnU7+DqjQ1XdcPbQVMAyKyJAVqRBg7beUBh5ftqpn7MH2+IkvkLRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433861;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=8VjKfFnIZSkrCLXCygsuoSQMlE9SiraWmXyOrGKYFrE=;
	b=plhrHwkrFIbIMYwGYfYxLec/YPmraAtGtyIhDmK/1LJrW8AUU8unEVH5zx0gFyR2Gi+M
	 XLPRA+9kBTMdDnpWU25I5q4i1Ar5tyt7quKIvGThMMtAe/MTdr1JLFo2OodMsEBT3sLK8
	 cz2kHLKEOMOg8LROBP8fWYwQh/FIQRRiBRv2wdWl1HhT+CX7Z5p2uuNrgw3DGLU6P+lHy
	 wEc3aaat70ErrHfPjqtsPSPvHpisQAWsDc3Y3PAGuf1H/+WjkDWdT0RgGNt0qNU1NtkUz
	 47DVfT/UDTZCorL8GUe3hE3uqKRPpXk+H5jxM+Uzfr52UZ2OYdft7LVm8pNrTklQn/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60467606A33F
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 11:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60467606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795433860; x=1826969860;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6HSsbhIJ2/LzJaFX+VzpT4jqVpYrVahm8NgRsq5w1c0=;
  b=cu9BtLwI6zIh04aRe5oEXBgHu5pcphEXdRGUYCtUMyzXNC+jTY63RDyS
   pzUXhZXRng/4U57+yPE7RmStto7apnesYa8VGlNx76U6JZRhh2PJHsvV+
   s0ivypm0fZdaMv5j2QfGjjEBSgzuN+Ok5IwBfhOpEmqwNG36y/sd/wEvU
   d3BNb3XT7qAnwf9o5K7hO4IiOhiBddTNSQk4jJttKSO3TTGI4EuKR3s4b
   XH1DmnScMv1w7AdQCpHHfS9IsNh5ssGQ+u5slIP5J5AmURB/PTiasm9TM
   pV7KsdJ/o03vvEQNwtIn2OYIDsIpYW5hVXPAYgE5amIRLGNelCOKlCnLi
   A==;
X-CSE-ConnectionGUID: i4BBe37kSgarS8wbf3WMHQ==
X-CSE-MsgGUID: SbYD3BSnSp+hQ5EapyyaOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 13:37:29 +0200
X-CSE-ConnectionGUID: wwCti2eIQNyQPVs2zMcl2w==
X-CSE-MsgGUID: zZwA3l2rQHeuaw3KjWwvFQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 23 Nov 2026 13:45:49 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 23 Nov 2026 13:37:28 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Mon, 23 Nov 2026 13:37:11 +0200
Subject: [PATCH v4 1/6] mips: {cm,cpc}: Make cm_core_lock, cpc_core_lock
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
Message-Id: <20261123-i6500-cm3-pmu-v4-1-5a9f5351688f@mobileye.com>
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
 linux-hardening@vger.kernel.org, Paul Burton <paulburton@kernel.org>
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
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

