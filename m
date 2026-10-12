Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706143C7BF
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790541; cv=none; b=ibd2mPl93n8v3trrkHx80FhjTHixZOYDQ4WQWuvVdMr2kVG1fAj4x9txcyg9G+/6yJGYZU9hKINBPulBgd0HhpNM1KFXEDCOiga8ZRFMHgld29EfSehbSqFRhGmoSK37fad9wnatrN8AJsFc99Au/d6LSXldzvpyrVTnvgnoldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790541; c=relaxed/simple;
	bh=rro3Q103tON6YF9EYmKQjD31tul/1auJiy4JtB4uR94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eRq8J+JCDW47mjqq/HkZ+pncAm/OTBdOSNaod1mOTofGBic+XxVse+zZg/njvZ2Rkkmpqa2dDI5IkayHD7a7uma3mpoXtdpRuneGPWtZz2lYh97ENRjyCA9iZHDb/ygoTEueyTLaKGVbQM+PaT1hH3bSiLCbf/gAQDEEUntjbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=CuRYkodd reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="CuRYkodd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1791790541; x=1823326541;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=rro3Q103tON6YF9EYmKQjD31tul/1auJiy4JtB4uR94=;
  b=CuRYkoddrLG0+2eEf0t21G2povYHlqFAK/s7+vmEK1/bp37W7bui8RPv
   wpGiM33zFOg0z55sNUYUP2ThKoDNDEAdGUrKuQzFJZSMFCRhVxP/hCbNw
   4yNI+FkdCT45oEBftZxxDEYtrpnprVsZjIGI19+F9AbYoxJ4M5o5rrEL9
   SQcIGQ17544wpH+amLN16DbCMoBgWmTexWOCvJ1G5TX+tA5hevrgdvw2s
   YAsEb5/HLJp/6JUoVE617+I1P9W83I8TW7ZjFXrpO6kwn9mkSVBCHkWL1
   6QejKOpANyyTrz/AIqnsYmhXyNhREbOhgm22eKk+EWmYT5PdoD9VaAyA0
   w==;
X-CSE-ConnectionGUID: HPlFx9CCQ2Wi0W/ug98EBA==
X-CSE-MsgGUID: RaejHCvSR0uJBpZcYYvYIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 10:34:30 +0300
X-CSE-ConnectionGUID: WKqFf3OrRsG/pIgJKAMBiQ==
X-CSE-MsgGUID: 3rYXRc34TNGXk5O6BHvSzw==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 12 Oct 2026 10:41:51 +0300
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 12 Oct 2026 10:34:22 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Mon, 12 Oct 2026 10:34:08 +0300
Subject: [PATCH] irqchip/riscv-aplic: fix asynchronous probing
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-aplic-async-probe-v1-1-4c2c4f5b0916@mobileye.com>
X-B4-Tracking: v=1; b=H4sIAHCNzGoC/x3MQQqAIBBA0avErBtQK4uuEi3MphoIFYUopLsnL
 d/i/wyJIlOCscoQ6eLE3hXIugJ7GLcT8loMSigthVRowskWTXqcxRD9QjhIrVoSTadFD6ULkTa
 +/+c0v+8HcUftPWMAAAA=
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
X-Mailer: b4 0.14.2

boolean flag don't protect from race when probing several instances
asynchronously. On system with multiple APLICs, if probed asynchronously,
warning triggered as below.

[    0.227210] riscv-aplic 67560000.interrupt-controller: 257 interrupts directly connected to 8 CPUs
[    0.227210] riscv-aplic 674e0000.interrupt-controller: 257 interrupts directly connected to 8 CPUs
[    0.227224] ------------[ cut here ]------------
[    0.227227] list_add double add: new=ffffffff8130ced0, prev=ffffffff8130ced0, next=ffffffff81316d40.
[    0.227302] WARNING: lib/list_debug.c:35 at __list_add_valid_or_report+0xe0/0xe6, CPU#4: kworker/u97:0/211
[    0.227322] Modules linked in:
[    0.227333] CPU: 4 UID: 0 PID: 211 Comm: kworker/u97:0 Not tainted 7.3.0-rc6 #1 PREEMPT_RT
[    0.227341] Hardware name: EyeQ7H evaluation board (DT)
[    0.227346] Workqueue: async async_run_entry_fn
[    0.227358] epc : __list_add_valid_or_report+0xe0/0xe6
[    0.227366]  ra : __list_add_valid_or_report+0xe0/0xe6
[    0.227375] epc : ffffffff804a08a0 ra : ffffffff804a08a0 sp : ffffffc600823b90
[    0.227379]  gp : ffffffff81389e70 tp : ffffffd60135ee00 t0 : 0000000000000000
[    0.227383]  t1 : 3fffffffffffffff t2 : 0000000000000000 s0 : ffffffc600823bb0
[    0.227387]  s1 : ffffffff8130ced0 a0 : 0000000000000058 a1 : ffffffd9efc9e5c0
[    0.227391]  a2 : ffffffd9efd5c510 a3 : 0000000000000000 a4 : 0000000000000000
[    0.227395]  a5 : 0000000000000000 a6 : ffffffd9efc6e5c0 a7 : bfffffffffffe000
[    0.227399]  s2 : 0000000000000000 s3 : ffffffff8130ce28 s4 : 0000000000000000
[    0.227402]  s5 : ffffffd6018b65c8 s6 : 0000000000000000 s7 : ffffffd6012fd605
[    0.227406]  s8 : ffffffd6010c3400 s9 : 0000000000000000 s10: 0000000000000000
[    0.227409]  s11: 0000000000000000 t3 : 3fffffffffffe000 t4 : 0000000000000020
[    0.227413]  t5 : 0000000000000000 t6 : ffffffc6008238f8 ssp : 0000000000000000
[    0.227417] status: 0000000200000120 badaddr: ffffffff804a08a0 cause: 0000000000000003
[    0.227422] [<ffffffff804a08a0>] __list_add_valid_or_report+0xe0/0xe6
[    0.227432] [<ffffffff80558226>] register_syscore+0x30/0x60
[    0.227444] [<ffffffff804ca0fe>] aplic_probe+0xd2/0xfa
[    0.227453] [<ffffffff80559b2e>] platform_probe+0x3e/0x7a
[    0.227461] [<ffffffff8055731a>] really_probe+0x88/0x35c
[    0.227469] [<ffffffff805576ae>] __driver_probe_device+0xc0/0x13a
[    0.227478] [<ffffffff805577f4>] driver_probe_device+0x38/0xb2
[    0.227486] [<ffffffff80557ba6>] __driver_attach_async_helper+0x3c/0xc4
[    0.227493] [<ffffffff80054a0e>] async_run_entry_fn+0x28/0x154
[    0.227500] [<ffffffff8004482a>] process_one_work+0x14e/0x3d2
[    0.227509] [<ffffffff800452fe>] worker_thread+0x144/0x286
[    0.227516] [<ffffffff8004ca3e>] kthread+0xee/0x10e
[    0.227524] [<ffffffff8001050a>] ret_from_fork_kernel+0x18/0x14e
[    0.227532] [<ffffffff807bef36>] ret_from_fork_kernel_asm+0x16/0x18
[    0.227542] ---[ end trace 0000000000000000 ]---
[    0.228475] pinctrl-single 48508000.pinctrl: 512 pins, size 2048
[    0.228500] pinctrl-single 53838000.pinctrl: 512 pins, size 2048
[    0.228723] pinctrl-single 67107000.pinctrl: 512 pins, size 2048
[    0.227210] riscv-aplic 674e0000.interrupt-controller: 257 interrupts directly connected to 8 CPUs
[    0.227224] ------------[ cut here ]------------
[    0.227227] list_add double add: new=ffffffff8130ced0, prev=ffffffff8130ced0, next=ffffffff81316d40.
[    0.227302] WARNING: lib/list_debug.c:35 at __list_add_valid_or_report+0xe0/0xe6, CPU#4: kworker/u97:0/211
[    0.227322] Modules linked in:
[    0.227333] CPU: 4 UID: 0 PID: 211 Comm: kworker/u97:0 Not tainted 7.3.0-rc6 #1 PREEMPT_RT
[    0.227341] Hardware name: EyeQ7H evaluation board (DT)
[    0.227346] Workqueue: async async_run_entry_fn
[    0.227358] epc : __list_add_valid_or_report+0xe0/0xe6
[    0.227366]  ra : __list_add_valid_or_report+0xe0/0xe6
[    0.227375] epc : ffffffff804a08a0 ra : ffffffff804a08a0 sp : ffffffc600823b90
[    0.227379]  gp : ffffffff81389e70 tp : ffffffd60135ee00 t0 : 0000000000000000
[    0.227383]  t1 : 3fffffffffffffff t2 : 0000000000000000 s0 : ffffffc600823bb0
[    0.227387]  s1 : ffffffff8130ced0 a0 : 0000000000000058 a1 : ffffffd9efc9e5c0
[    0.227391]  a2 : ffffffd9efd5c510 a3 : 0000000000000000 a4 : 0000000000000000
[    0.227395]  a5 : 0000000000000000 a6 : ffffffd9efc6e5c0 a7 : bfffffffffffe000
[    0.227399]  s2 : 0000000000000000 s3 : ffffffff8130ce28 s4 : 0000000000000000
[    0.227402]  s5 : ffffffd6018b65c8 s6 : 0000000000000000 s7 : ffffffd6012fd605
[    0.227406]  s8 : ffffffd6010c3400 s9 : 0000000000000000 s10: 0000000000000000
[    0.227409]  s11: 0000000000000000 t3 : 3fffffffffffe000 t4 : 0000000000000020
[    0.227413]  t5 : 0000000000000000 t6 : ffffffc6008238f8 ssp : 0000000000000000
[    0.227417] status: 0000000200000120 badaddr: ffffffff804a08a0 cause: 0000000000000003
[    0.227422] [<ffffffff804a08a0>] __list_add_valid_or_report+0xe0/0xe6
[    0.227432] [<ffffffff80558226>] register_syscore+0x30/0x60
[    0.227444] [<ffffffff804ca0fe>] aplic_probe+0xd2/0xfa
[    0.227453] [<ffffffff80559b2e>] platform_probe+0x3e/0x7a
[    0.227461] [<ffffffff8055731a>] really_probe+0x88/0x35c
[    0.227469] [<ffffffff805576ae>] __driver_probe_device+0xc0/0x13a
[    0.227478] [<ffffffff805577f4>] driver_probe_device+0x38/0xb2
[    0.227486] [<ffffffff80557ba6>] __driver_attach_async_helper+0x3c/0xc4
[    0.227493] [<ffffffff80054a0e>] async_run_entry_fn+0x28/0x154
[    0.227500] [<ffffffff8004482a>] process_one_work+0x14e/0x3d2
[    0.227509] [<ffffffff800452fe>] worker_thread+0x144/0x286
[    0.227516] [<ffffffff8004ca3e>] kthread+0xee/0x10e
[    0.227524] [<ffffffff8001050a>] ret_from_fork_kernel+0x18/0x14e
[    0.227532] [<ffffffff807bef36>] ret_from_fork_kernel_asm+0x16/0x18
[    0.227542] ---[ end trace 0000000000000000 ]---

Fixes: b330fbfd34d7 ("irqchip/riscv-aplic: Register syscore operations only once")
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 drivers/irqchip/irq-riscv-aplic-main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index d9afb6ae98cf56d6fd9f858c31a3d23546c3b450..db15ec8a2d3462f6c911c1e5b7446b05b47bd127 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -116,14 +116,12 @@ static struct syscore aplic_syscore = {
 	.ops = &aplic_syscore_ops,
 };
 
-static bool aplic_syscore_registered __ro_after_init;
+static atomic_t aplic_syscore_registered = ATOMIC_INIT(0) __ro_after_init;
 
 static void aplic_syscore_init(void)
 {
-	if (!aplic_syscore_registered) {
+	if (!atomic_fetch_inc(&aplic_syscore_registered))
 		register_syscore(&aplic_syscore);
-		aplic_syscore_registered = true;
-	}
 }
 
 static int aplic_pm_notifier(struct notifier_block *nb, unsigned long action, void *data)

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261012-aplic-async-probe-81624e035607

Best regards,
-- 
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

