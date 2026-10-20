Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494807;
	b=hy4A+eI/O9sytOA+QGCOZNqFT/VYRu+eEec58fkVXv3SC5t7I/hbAo5h+7QAketLDUIa
	 gIREY/ExQUjyyLvpLilKefsITexuWWdyDHA4muxT1cUaiTHKx0fW8xoVm4yZhTuI/oeKa
	 EIlYnaatbR4GA1+C2i4VjDqWzlwK7yqZJR4QhpCIDJ8fRv+46J9Pu9p3pBtVx4xvVwqUq
	 QqbvG0xAiVbd8W2CeHzlw2tLjQd4HBPItFLnr/RMHiFAzNYLMf6pbSh0Yf89Mnhj3O4X1
	 ljRyXNuEv1W70MXUJEhcXww/cIBSHDbLpTvqdiRkdg0ZQcyvgpkpXxDILs0VvXSTflg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494807;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=DHsn67GRfyoCUFdDA+iAazXVa3VitZ82Nu7pQrNAL4s=;
	b=r4aKLeEcEXdxFG5FstF3J54Zvi/zthsZ7Xzu1hfsDWxqBfzKLfgLZ8tsPoIBGPE/fi/8
	 Xes7xU4iTxaVRt2ulukVdKe8wJclsXaub6TI8SRxZwacT3cVZ9yKpyfeKaj0danIsrBZ3
	 ILNrWtkFU416FpSehWLIs+A1QKeDTdJr8KTHD6iwKgRU3g8y1Gjyya3JnzHQuKGYcdQO3
	 fapBpwc5k/+EFczTL1fdas2BH+PwwFJFvFNLk3dviK7gdhMh8UgZq/0TOwUmXrepEzS2b
	 M1aQzEUhvPVom1KHdfLRbPwHXNnaqz/FyMeRKuMkr/lhD9UnCaqfhhilsnWEY7y4ANg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85387606A31B
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 11:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85387606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1792494803; x=1824030803;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=43DxCqYx74BgNVGggbQM7tZIdXbth+6fcaCniyNMIYA=;
  b=qWA8LoQ8wvXGwZLX6n2ci3KyrPEyYUOuWgcgyqKC9We6Raw90ssFKfG/
   wtD81ffgGhgEOsr5i8W2a28HqhPQDJYAkdpremiallm1X0ccdyMtba9mD
   wuuYakOArlQHysaNo1IHwgsikRoUBdrqYzKt57Qc4W7ang081ru7iJooq
   KUXA+jwBE4gnL+e5kYttnMrRQuTpvDlO6bNv858lQEAB9j74Znwuqnbey
   x1mnZBtGjwvNqCK+ac+cuocwvfauiDTNlThyJA1CLWphBjVakR1lDKeP0
   x+WYYXclRTRCT7EoPor6zPv7umf8KDJ02F1uPVNUaHYN4yKtszvyHoFAl
   Q==;
X-CSE-ConnectionGUID: 5EbXaXl4SIyCY0j5vrunUw==
X-CSE-MsgGUID: jcH4NxwyQTSupDf/edBDnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 14:13:15 +0300
X-CSE-ConnectionGUID: uI3R6ErPQ7GfhVduOyl9aw==
X-CSE-MsgGUID: dJjfW9ApTY2AycJv7XbKzA==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 20 Oct 2026 14:20:43 +0300
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Tue, 20 Oct 2026 14:13:14 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Tue, 20 Oct 2026 14:12:52 +0300
Subject: [PATCH v4] irqchip/riscv-aplic: fix asynchronous probing
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
Message-Id: <20261020-aplic-async-probe-v4-1-68bc35e0ece1@mobileye.com>
X-B4-Tracking: v=1; b=H4sIALNM12oC/4XNQQqDMBCF4atI1k1JxiTGrnqP0oWOYw1YI0mRi
 nj3Rpel1OX/YL5ZWKTgKLJLtrBAk4vODynUKWPYVcODuGtSMxBgpJDAq7F3yKs4D8jH4GviVhp
 QJHJtRMHS3Riode/dvN1Tdy6+fJj3F5Pc1n/aJLnkCgFVq2tRSnN9+tr1NNMZ/ZNt4ASHCCTEG
 tsUxiosm19IfojkCdHYamgQrCnFF7Ku6weOg6JcPwEAAA==
X-Change-ID: 20261012-aplic-async-probe-81624e035607
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

The APLIC driver leaves probe_type unset, so it follows
PROBE_DEFAULT_STRATEGY and may be probed asynchronously when the
command line requests it. Multiple APLIC instances can therefore
enter aplic_syscore_init() at the same time. The check-then-set of
aplic_syscore_registered is not atomic: two threads can both observe
the flag as false and both call register_syscore(), inserting the
same list node twice. That trips CHECK_DATA_CORRUPTION
("list_add double add") in __list_add_valid_or_report().

The flag is also marked __ro_after_init, but aplic_probe() can run
after init. With MSI, aplic_msi_setup() returns -EPROBE_DEFER while
the MSI parent is not ready, so the later successful probe writes the
flag after it has been made read-only. That write fault exists even
without asynchronous probing.

Replace the flag with an atomic and claim registration with
atomic_cmpxchg(), so only one caller registers the syscore ops and
the store remains writable after init.

Fixes: b330fbfd34d7 ("irqchip/riscv-aplic: Register syscore operations only once")
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
Changes in v4:
- rework commit message
- rebase onto v7.3
- Link to v3: https://lore.kernel.org/r/20261012-aplic-async-probe-v3-1-5cf52dc28690@mobileye.com

Changes in v3:
- drop __ro_after_init attribute due to write to read-only page concern
- Link to v2: https://lore.kernel.org/r/20261012-aplic-async-probe-v2-1-868d7684c9d6@mobileye.com

Changes in v2:
- fixed potential access to read-only page
- Link to v1: https://lore.kernel.org/r/20261012-aplic-async-probe-v1-1-4c2c4f5b0916@mobileye.com

To: Anup Patel <anup@brainfault.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <radu@rendec.net>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Jessica Liu <liu.xuemei1@zte.com.cn>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/irqchip/irq-riscv-aplic-main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index d9afb6ae98cf..54e1d5602f15 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -116,14 +116,12 @@ static struct syscore aplic_syscore = {
 	.ops = &aplic_syscore_ops,
 };
 
-static bool aplic_syscore_registered __ro_after_init;
+static atomic_t aplic_syscore_registered = ATOMIC_INIT(0);
 
 static void aplic_syscore_init(void)
 {
-	if (!aplic_syscore_registered) {
+	if (!atomic_cmpxchg(&aplic_syscore_registered, 0, 1))
 		register_syscore(&aplic_syscore);
-		aplic_syscore_registered = true;
-	}
 }
 
 static int aplic_pm_notifier(struct notifier_block *nb, unsigned long action, void *data)

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261012-aplic-async-probe-81624e035607

Best regards,
--  
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

