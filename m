Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06544317145
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514029; cv=none; b=ScgtLTRx7Qwtotrb3gsGaRH5V1+nAXbG0V+ojRJhgKp4+gEfRnurkclAF8zFj0zsklFdb6Age3iKhR1m4X8o/WQxbUJIMN0SUO5spBRf/OFCmIU7LhPm/N95Y/bsBT4T02hEhim8S4Ah0e7c+kYdslMzMy8shfRk8GTd5wmSH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514029; c=relaxed/simple;
	bh=Me8mi0NrSdfydNawCYFOI5PqxoSJA8FxxW2gT79Fc4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ubeyVqaiPKBou5XFtnCj1rHbg3eEChkfGiN82hcDLglXMgFAOV+5ofCdwP3n7vNo5mRxuV2VknIHx3ppq3vy5FZIauDfK0FBREZ0jcVQ92CYAtFz8lHTOfd41bze2YzsjbVdpsFSFfnXeF3LbotLxNTIrzXnpGhCYt0knMfMxiA=
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
Date: Wed, 12 Aug 2026 13:48:29 +0800
Subject: [PATCH 5/7] EDAC/aspeed: Replace regmap with direct register
 access
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260812-edac-v1-5-03992edea297@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786513706; l=8681;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=Me8mi0NrSdfydNawCYFOI5PqxoSJA8FxxW2gT79Fc4E=;
 b=2PU7W0YGm6//PwLZbta9GqrvS/IUAj0KX1k+Ge63pDjVRmctMKCfK/TyoAstFxKlihE7fwtTf
 FInx/eaBkYGAjxMvKUgrv16OgH5utanqePr0bUFwK99Xu6C5n818RZD
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The driver instantiates its own regmap purely as an MMIO wrapper: it has
no register cache, uses custom reg_read/reg_write callbacks, and is not
shared as a syscon with other drivers. So it brings nothing here beyond
the spinlock that regmap takes around each access when fast_io is set.

Drop the regmap and access the registers directly with readl()/writel()
under an explicit raw spinlock, held across the whole read-modify-write so
the controller is unlocked once around the grouped writes rather than on
every register write. The lock is a raw_spinlock_t because the ECC
interrupt handler runs in hardirq context, where under PREEMPT_RT a
sleeping spinlock could not be acquired.

Annotate the register base with __guarded_by() so that, under
CONFIG_WARN_CONTEXT_ANALYSIS, the compiler checks at build time that every
hardware register access is performed while holding the lock.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/edac/aspeed_edac.c | 132 +++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 84 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 8bfeb21d3204..7bd552ee9a61 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -3,6 +3,7 @@
  * Copyright 2018, 2019 Cisco Systems
  */
 
+#include <linux/cleanup.h>
 #include <linux/edac.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -10,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
+#include <linux/spinlock.h>
 #include "edac_module.h"
 
 #define DRV_NAME "aspeed-edac"
@@ -20,7 +21,6 @@
 #define ASPEED_MCR_INTR_CTRL   0x50 /* interrupt control/status register */
 #define ASPEED_MCR_ADDR_UNREC  0x58 /* address of first un-recoverable error */
 #define ASPEED_MCR_ADDR_REC    0x5c /* address of last recoverable error */
-#define ASPEED_MCR_LAST        ASPEED_MCR_ADDR_REC
 
 #define ASPEED_MCR_PROT_PASSWD          0xfc600309
 #define ASPEED_MCR_CONF_DRAM_TYPE       BIT(4)
@@ -30,55 +30,8 @@
 #define ASPEED_MCR_INTR_CTRL_CNT_UNREC  GENMASK(15, 12)
 #define ASPEED_MCR_INTR_CTRL_ENABLE     (BIT(0) | BIT(1))
 
-static struct regmap *aspeed_regmap;
-
-static int regmap_reg_write(void *context, unsigned int reg, unsigned int val)
-{
-	void __iomem *regs = (void __iomem *)context;
-
-	/* enable write to MCR register set */
-	writel(ASPEED_MCR_PROT_PASSWD, regs + ASPEED_MCR_PROT);
-
-	writel(val, regs + reg);
-
-	/* disable write to MCR register set */
-	writel(~ASPEED_MCR_PROT_PASSWD, regs + ASPEED_MCR_PROT);
-
-	return 0;
-}
-
-static int regmap_reg_read(void *context, unsigned int reg, unsigned int *val)
-{
-	void __iomem *regs = (void __iomem *)context;
-
-	*val = readl(regs + reg);
-
-	return 0;
-}
-
-static bool regmap_is_volatile(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case ASPEED_MCR_PROT:
-	case ASPEED_MCR_INTR_CTRL:
-	case ASPEED_MCR_ADDR_UNREC:
-	case ASPEED_MCR_ADDR_REC:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static const struct regmap_config aspeed_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-	.max_register = ASPEED_MCR_LAST,
-	.reg_write = regmap_reg_write,
-	.reg_read = regmap_reg_read,
-	.volatile_reg = regmap_is_volatile,
-	.fast_io = true,
-};
+static DEFINE_RAW_SPINLOCK(aspeed_lock);
+static void __iomem *aspeed_regs __guarded_by(&aspeed_lock);
 
 static void count_rec(struct mem_ctl_info *mci, u8 rec_cnt, u32 rec_addr)
 {
@@ -147,12 +100,24 @@ static irqreturn_t mcr_isr(int irq, void *arg)
 {
 	struct mem_ctl_info *mci = arg;
 	u32 rec_addr, un_rec_addr;
-	u32 reg50, reg5c, reg58;
-	u8  rec_cnt, un_rec_cnt;
-
-	regmap_read(aspeed_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
-	dev_dbg(mci->pdev, "received edac interrupt w/ mcr register 50: 0x%x\n",
-		reg50);
+	u8 rec_cnt, un_rec_cnt;
+	u32 reg50;
+
+	scoped_guard(raw_spinlock, &aspeed_lock) {
+		reg50 = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
+		dev_dbg(mci->pdev, "received edac interrupt w/ mcr register 50: 0x%x\n",
+			reg50);
+		un_rec_addr = readl(aspeed_regs + ASPEED_MCR_ADDR_UNREC);
+		rec_addr = readl(aspeed_regs + ASPEED_MCR_ADDR_REC);
+
+		/* clearing the counters needs a set-then-clear of CLEAR */
+		writel(ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+		writel(reg50 | ASPEED_MCR_INTR_CTRL_CLEAR,
+		       aspeed_regs + ASPEED_MCR_INTR_CTRL);
+		writel(reg50 & ~ASPEED_MCR_INTR_CTRL_CLEAR,
+		       aspeed_regs + ASPEED_MCR_INTR_CTRL);
+		writel(~ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+	}
 
 	/* collect data about recoverable and unrecoverable errors */
 	rec_cnt = (reg50 & ASPEED_MCR_INTR_CTRL_CNT_REC) >> 16;
@@ -161,20 +126,6 @@ static irqreturn_t mcr_isr(int irq, void *arg)
 	dev_dbg(mci->pdev, "%d recoverable interrupts and %d unrecoverable interrupts\n",
 		rec_cnt, un_rec_cnt);
 
-	regmap_read(aspeed_regmap, ASPEED_MCR_ADDR_UNREC, &reg58);
-	un_rec_addr = reg58;
-
-	regmap_read(aspeed_regmap, ASPEED_MCR_ADDR_REC, &reg5c);
-	rec_addr = reg5c;
-
-	/* clear interrupt flags and error counters: */
-	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
-			   ASPEED_MCR_INTR_CTRL_CLEAR,
-			   ASPEED_MCR_INTR_CTRL_CLEAR);
-
-	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
-			   ASPEED_MCR_INTR_CTRL_CLEAR, 0);
-
 	/* process recoverable and unrecoverable errors */
 	count_rec(mci, rec_cnt, rec_addr);
 	count_un_rec(mci, un_rec_cnt, un_rec_addr);
@@ -182,13 +133,31 @@ static irqreturn_t mcr_isr(int irq, void *arg)
 	if (!rec_cnt && !un_rec_cnt)
 		dev_dbg(mci->pdev, "received edac interrupt, but did not find any ECC counters\n");
 
-	regmap_read(aspeed_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
+	scoped_guard(raw_spinlock, &aspeed_lock)
+		reg50 = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
 	dev_dbg(mci->pdev, "edac interrupt handled. mcr reg 50 is now: 0x%x\n",
 		reg50);
 
 	return IRQ_HANDLED;
 }
 
+static void aspeed_set_irq(bool enable)
+{
+	u32 val;
+
+	guard(raw_spinlock_irqsave)(&aspeed_lock);
+
+	val = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
+	if (enable)
+		val |= ASPEED_MCR_INTR_CTRL_ENABLE;
+	else
+		val &= ~ASPEED_MCR_INTR_CTRL_ENABLE;
+
+	writel(ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+	writel(val, aspeed_regs + ASPEED_MCR_INTR_CTRL);
+	writel(~ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+}
+
 static int config_irq(void *ctx, struct platform_device *pdev)
 {
 	int irq;
@@ -206,9 +175,7 @@ static int config_irq(void *ctx, struct platform_device *pdev)
 		return rc;
 
 	/* enable interrupts */
-	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
-			   ASPEED_MCR_INTR_CTRL_ENABLE,
-			   ASPEED_MCR_INTR_CTRL_ENABLE);
+	aspeed_set_irq(true);
 
 	return 0;
 }
@@ -246,7 +213,8 @@ static int init_csrows(struct mem_ctl_info *mci)
 	nr_pages = resource_size(&r) >> PAGE_SHIFT;
 	csrow->last_page = csrow->first_page + nr_pages - 1;
 
-	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
+	scoped_guard(raw_spinlock, &aspeed_lock)
+		reg04 = readl(aspeed_regs + ASPEED_MCR_CONF);
 	dram_type = (reg04 & ASPEED_MCR_CONF_DRAM_TYPE) ? MEM_DDR4 : MEM_DDR3;
 
 	dimm = csrow->channels[0]->dimm;
@@ -263,7 +231,6 @@ static int init_csrows(struct mem_ctl_info *mci)
 
 static int aspeed_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
 	void __iomem *regs;
@@ -274,13 +241,11 @@ static int aspeed_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	aspeed_regmap = devm_regmap_init(dev, NULL, (__force void *)regs,
-					 &aspeed_regmap_config);
-	if (IS_ERR(aspeed_regmap))
-		return PTR_ERR(aspeed_regmap);
+	scoped_guard(raw_spinlock, &aspeed_lock)
+		aspeed_regs = regs;
 
 	/* bail out if ECC mode is not configured */
-	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
+	reg04 = readl(regs + ASPEED_MCR_CONF);
 	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
 		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
 		return -EPERM;
@@ -346,8 +311,7 @@ static void aspeed_remove(struct platform_device *pdev)
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 
 	/* disable interrupts */
-	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
-			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
+	aspeed_set_irq(false);
 
 	/* free resources */
 	edac_mc_del_mc(&pdev->dev);

-- 
2.34.1

