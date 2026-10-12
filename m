Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6C3537FF
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.77.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796390; cv=none; b=rhibRDmaTmh9OLgIR6u5Q5nK9LgEl/yzJkzPbTBPl7Ox7g4D8e81e0Tlks6SGkdWEXA4GTHGlb0mI41OZCuQodMRksDmiX/M0hpBRpB/OYz2Ngssjh5CVx+m++4dDdOMC1ahyG/ohaceV9SGUAe11WZVnJQYDDSy5AXFI6PtBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796390; c=relaxed/simple;
	bh=RUboTfQiUPP76+VWIJzfRXec6oAYPgqZ2bmu4E3lnGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Tew1ICxqUjDXMvgQJfrDos1jNVgbe/tntyIGcdCeqKTEGwuxALnqhwKZ/xL4ONDYm9P5shXX7imcDbihqQAcOBeFFiGyKpcocUXRxq9o2fB6mGfzlHZJU68R4gC7Fh8wzFa31nyYexv4mQ0sTXZZw0Dekof38/9kHca20W2dBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=r4EMsh7x reason="key not found in DNS"; arc=none smtp.client-ip=207.54.77.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="r4EMsh7x"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1791796387; x=1823332387;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=RUboTfQiUPP76+VWIJzfRXec6oAYPgqZ2bmu4E3lnGs=;
  b=r4EMsh7xs//6qOej/uAbpp13MD0OoOIisLNnVLb8Pb8IGREh9uX8R6U3
   O7xsjD6MxwxeGrII5m5ffFEg2Xfp6aEQ9pLG9cJA9BHPt52ndT2E9egeP
   FRoH1yjv9KT3uceE19VQqfvd3cmmsNyp3Z4mwRNJfEuFtRzAy0DdS24ke
   rJhtHgKVYE+tise8wX8jh2RhN0tpdyL+9rQ638Li7Z8uueQhWrZ+rfcF/
   Otz94B7jAH0V+F2ssaedOIdBBCRpP4vS27thrR0oR+U9+exRxuiZP6ud1
   7+P43KPLjXmOfrR5fa9h1UxClWg54trX5Vr1E3W8NHF2p0c0wjOEZVgAd
   w==;
X-CSE-ConnectionGUID: HC/dhebfQxy2UIjvMC1q8w==
X-CSE-MsgGUID: K26D3Nr6TjessknFIQBqTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 12:13:04 +0300
X-CSE-ConnectionGUID: rEWvfetiQ1iP5W/OjNINWg==
X-CSE-MsgGUID: BJlt/lpRT8WsWVNxy4Kuvg==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces01_data.me-corp.lan with SMTP; 12 Oct 2026 12:20:35 +0300
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 12 Oct 2026 12:13:01 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Mon, 12 Oct 2026 12:12:59 +0300
Subject: [PATCH v3] irqchip/riscv-aplic: fix asynchronous probing
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-aplic-async-probe-v3-1-5cf52dc28690@mobileye.com>
X-B4-Tracking: v=1; b=H4sIAJqkzGoC/4XNQQ6DIBCF4asY1qUBRERXvUfThY5jnUTFQENqj
 HcvuuyiXf4vmW82FtATBlZnG/MYKZCbU+SXjMHQzE/k1KVmSigjhVS8WUYC3oR1Br541yK30ii
 NIi+MKFm6Wzz29D7N+yP1QOHl/Hq+iPJYf2lRcsk1KNB90YpKmtvkWhpxxSu4iR1gVH8RlRBrb
 Fcaq6HqvpF93z+5t1n0+gAAAA==
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
Changes in v3:
- drop __ro_after_init attribute due to write to read-only page concern
- Link to v2: https://lore.kernel.org/r/20261012-aplic-async-probe-v2-1-868d7684c9d6@mobileye.com

Changes in v2:
- fixed potential access to read-only page
- Link to v1: https://lore.kernel.org/r/20261012-aplic-async-probe-v1-1-4c2c4f5b0916@mobileye.com
---
 drivers/irqchip/irq-riscv-aplic-main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index d9afb6ae98cf56d6fd9f858c31a3d23546c3b450..54e1d5602f15a04127e900c0a4983022d49da553 100644
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
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261012-aplic-async-probe-81624e035607

Best regards,
-- 
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

