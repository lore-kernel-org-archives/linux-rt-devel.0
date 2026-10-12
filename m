Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30A44AB88
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794091; cv=none; b=LPCxG7431OH4A77txXaInsIieExl0H1zbNClrtDftnlsWbAmQeP3IlyE2DelMO/RiaMBImhhqzKDwzeGVCfxo1XDRFxdB0Um5ClZ5zY4qCWl9bJgpuwXIbeKcsjzKF75ynWii+ZcO8TDgbIiNlc4KqzAzZWZqAe9Yerki9WgLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794091; c=relaxed/simple;
	bh=yk5YgdwDFIhuj5pDr51VySvnm39q0kEC5UqKQPSxas0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tlEsfD5RVrkkeKcUWWvLTBTnr0gp3B/DTAgjJmzzhRZR8jZ8E2+EnNfujHHrnbKFjt94xJ32IeW5+LAUHFaVHpj0aNqGG1IGzVIXphRUIOs0+eSW9EfmxSA4UEEaJxBDAoNQxQpxUHWU4t9lTTIExqMsx7+qJL04aHlsdLMG6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=qowYsnH0 reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="qowYsnH0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1791794088; x=1823330088;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=yk5YgdwDFIhuj5pDr51VySvnm39q0kEC5UqKQPSxas0=;
  b=qowYsnH09M+Dqgh/mFufkEAIXaqzyw3SGokt/VPk/V/w1rL6bqNLAqU3
   PHe8wfi1wLw1jOMitXhL4ug7CkUSv1UK/wx8z1g5q10ajzLqknuAbR20R
   W3EIA6bGyNORANSQuh0XjCtrom10Qcvb8FCQ1VhibJLjIcHBqDgOPXCTb
   +kk+YXuGxts5qiZyT/jT3OPpYXM5/1pVDJg4wKt5mg/LLc81Rzx4JrgTD
   +xVq1q+Wlty+X31TeCgPC5M2Xtq24c76Q0MkC/mcdMGPdnGMCVYBz/ncd
   arFe0UrOIq6EPqIg8fr/4Olv2da5ts6/xuJ91GEpNjykQqvqsHuuAip6M
   w==;
X-CSE-ConnectionGUID: x0ygVKRBTdOdAv3CGk+//Q==
X-CSE-MsgGUID: 5uBz+3VhQPmgi4Mt/BhnAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 11:33:37 +0300
X-CSE-ConnectionGUID: XiyqeNnYQziIV4rRQ/vKzA==
X-CSE-MsgGUID: 6Kn7LuKPSWSm64iHmOB5dw==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 12 Oct 2026 11:41:02 +0300
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 12 Oct 2026 11:33:36 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Mon, 12 Oct 2026 11:33:26 +0300
Subject: [PATCH v2] irqchip/riscv-aplic: fix asynchronous probing
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-aplic-async-probe-v2-1-868d7684c9d6@mobileye.com>
X-B4-Tracking: v=1; b=H4sIAFWbzGoC/32NTQ6CMBBGr0Jm7ZhOLfVn5T0Mi1IHmQQoaU0jI
 dzdygFcvpd871shcRROcKtWiJwlSZgK6EMFvnfTi1GehUErbUmRRjcP4tGlZfI4x9AyXshqw+p
 UW3WGspsjd/LZm4+mcC/pHeKyX2T62X+1TEhovPamq1t1JXsfQysDL3z0YYRm27YvpxHvOLUAA
 AA=
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
Changes in v2:
- fixed potential access to read-only page
- Link to v1: https://lore.kernel.org/r/20261012-aplic-async-probe-v1-1-4c2c4f5b0916@mobileye.com
---
 drivers/irqchip/irq-riscv-aplic-main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index d9afb6ae98cf56d6fd9f858c31a3d23546c3b450..788b9f855cb7e5340a28e5b6acb5e9185a587717 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -116,14 +116,12 @@ static struct syscore aplic_syscore = {
 	.ops = &aplic_syscore_ops,
 };
 
-static bool aplic_syscore_registered __ro_after_init;
+static atomic_t aplic_syscore_registered __ro_after_init = ATOMIC_INIT(0);
 
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
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261012-aplic-async-probe-81624e035607

Best regards,
-- 
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

