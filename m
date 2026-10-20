Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510758;
	b=LBge1qZExIguaIBhMOIKOu3QUGtgEkSRk/RfaL/PsyJV9WwzozmbbTWZ+GfnNnCsNVVM
	 VmcLt7un26L75naQ06JkLOsYxkoOknds9OKiwBc9BnyjdoHWdSsk5qi/uUUx4t/bDn8ul
	 bp22Q174kAA0LfNedawUtDpU1o/kN3g1vY46jaHf03stWEytj2vsMKmGgLSBZK98gYy0j
	 Px9ek558OCYKR4j4u/ApFX6RMoACb1rVHe/bYvDWdsOPhqryVjuF0rVHdoRSnP55dlWbP
	 JVrpZit8LkGbEVzNPrGHnVtAQLO+REqBSzx7V8PBBaPn7i2yXoAktIdBm4CTfuwxKZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510758;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=hW8AG2hV0n29KjgMtq8hTerS5/UiPYe5DlpQ2gjroIc=;
	b=iCxB5lRpX2CL/BREN5J2kAV8VvE5XDfpPEU8VFjCp4MbnaxSezXKvadLQdFWQUs1Addr
	 zw4H0fbu698d8J09MISdwqDWbN8s7kq+1fH1FMF3nwibZB2jkdJzOahQ7Bf9pGyy6YZGk
	 94PqEntOZglxNoqPqR+/UC15Erv8HcnqpiwRSCB5uF65ZqkA9gtal9p+AXXItzB0jH3Nw
	 53FnuLGnUcMmDTYm/xsb/TI9y//KlDRQpkgXIgYFdzUHaQ8mGMBbizeOwbgBmdN3m6PL5
	 WO37qGx9d/pojI8JlvAF7BKaRHa+jbpwKVc1Ex0xHU+tlnlvUQLEaUNpG+VS6iFEQoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DF2606A32A
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 15:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5DF2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1792510756; x=1824046756;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=14bpOD0CALcJBHTTmAKQeDaGQ0pZ38ju38hDe+pPRH8=;
  b=QduoHDE2pkSnyzPI9mwF7+ABAgBzj+J/SKHeYDuC9ZgmtPac/i2IBFGH
   hWIxX5DFq2rJ5fmGf9g1iXpBIrbltWSOVKSE7DKQ8JgdEehr55o/k5ooA
   ZYOB0v3U0P5Gb+MAY7SB2YXRqEV6c5YQpEqLoB6+yeQeYWAJQOoEVFPHK
   BKGBYwotrtXVL97eHtYGkDP2njlRv9NFXbM9exo20pMrkT+KLbfMW/zTR
   dH0xtSiw3Y+uJMAfqi4fRQpELPlpaNaK6rfR75UL6XM/CCLcxsPM61xrW
   yXeemSm10EDAj9+m504/osBWkIqQdNXnr3Gafm207Np3ayc3HDKcvmzCH
   A==;
X-CSE-ConnectionGUID: zFJkn98zTLuN0wnQwqjKdQ==
X-CSE-MsgGUID: bzKaVVIlQf29waub/2HpMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 18:39:12 +0300
X-CSE-ConnectionGUID: OBcHHMnaR1ydp+p9Dua8Nw==
X-CSE-MsgGUID: ya/pOhRWT3ek/Nt0gSKgLQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 20 Oct 2026 18:46:48 +0300
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Tue, 20 Oct 2026 18:39:11 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Tue, 20 Oct 2026 18:38:48 +0300
Subject: [PATCH v5 1/2] irqchip/riscv-aplic: do not mark the syscore
 registered flag ro_after_init
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
Message-Id: <20261020-aplic-async-probe-v5-1-c4861c2aafca@mobileye.com>
References: <20261020-aplic-async-probe-v5-0-c4861c2aafca@mobileye.com>
In-Reply-To: <20261020-aplic-async-probe-v5-0-c4861c2aafca@mobileye.com>
To: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Jessica Liu <liu.xuemei1@zte.com.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

aplic_syscore_registered is marked __ro_after_init, but it is written
from aplic_probe(), which can run after init. With MSI, aplic_msi_setup()
returns -EPROBE_DEFER while the MSI parent (IMSIC) is not ready, so the
later successful probe writes the flag after it has been made read-only.
That write faults.

Drop the __ro_after_init annotation so the flag stays writable.

Fixes: b330fbfd34d7 ("irqchip/riscv-aplic: Register syscore operations only once")
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 drivers/irqchip/irq-riscv-aplic-main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index d9afb6ae98cf..5369078f3d00 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -116,7 +116,11 @@ static struct syscore aplic_syscore = {
 	.ops = &aplic_syscore_ops,
 };
 
-static bool aplic_syscore_registered __ro_after_init;
+/*
+ * Not __ro_after_init: probe can be deferred (e.g. MSI mode waiting for the
+ * IMSIC) and complete after the init memory is made read-only.
+ */
+static bool aplic_syscore_registered;
 
 static void aplic_syscore_init(void)
 {

-- 
2.43.0

