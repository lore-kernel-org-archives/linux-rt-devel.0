Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079C294A10
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513780; cv=none; b=PFrN5FH/arSCWbBzORYx1lTskbli/GRE68uBF7qO92GQm+Q5aNDgC+AhdS7Xr3qLnK2X3KoUybp+ay1M3BVylcwor6COxH1l9YaIWqeM5bv1ULNqIZ8hYa7uTb99511oOJbrRxK8g5p4ZKmQrankyMiLb4fX6G9b9sraHS3iGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513780; c=relaxed/simple;
	bh=EOVfr2ok6rxbBdxN7bYBtEviOJjGs6G3RxZU8KfK1eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f+0DwGAJMLApluqG3lr7yeCL+J+6qS3wzzeBzF12MYDIZqrYgLDm3sUizNq84WyC+26bT6X2FTPb08/7dw6f//oZhU+tl5aMHKuzXsE6iYIbkY8UdLJSJFGkMC8dkOFu+uxPhMA+nltkiC/DTULBjGnjZj6uqvWSi8jXXbVo2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 12 Aug
 2026 13:48:27 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 12 Aug 2026 13:48:27 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 12 Aug 2026 13:48:31 +0800
Subject: [PATCH 7/7] EDAC/aspeed: Add AST2700 support
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260812-edac-v1-7-03992edea297@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786513706; l=10873;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=EOVfr2ok6rxbBdxN7bYBtEviOJjGs6G3RxZU8KfK1eo=;
 b=8xYSioI2uWnPZREYmRnWEyTIdXS0zjZ+TlyEg5XE6IsciKW7kUGokXwO724O50Q/rJTYXWUlR
 DW4p++Hr2d1Beh3dCNI+P14TUfGYmrJbbtWTvqqIKGmkdHAhtWVgxZZ
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add SDRAM ECC reporting for the Aspeed AST2700. Its DRAMC has a different
register layout, a split interrupt status/clear/mask scheme, DDR4/DDR5
memory and interrupt registers that are not key-protected.

Its interrupt status/clear and enable sequences differ from the earlier
SoCs, so add per-chip isr() and set_irq() hooks and route the request_irq
and enable/disable paths through them, keeping the existing AST2400/2500/
2600 behaviour under the shared aspeed_mcr_isr()/aspeed_set_irq().

Unlike the earlier SoCs it records a single failure address shared by
both error types, so extend the shared count_rec()/count_un_rec()
helpers with a have_addr flag to report an error without an address
(existing SoCs pass have_addr = true, unchanged) and widen their address
argument to phys_addr_t as the AST2700 address can exceed 32 bits.

Tested on an AST2700: A correctable error was injected from the console by
unlocking the controller and writing its ECC error inject test register:

  # mw 12c00000 1688a8a8
  # mw 12c00080 31
  EDAC MC0: 1 CE on mc#0csrow#0channel#0 (csrow:0 channel:0 page:0x40f6da offset:0xdb0 grain:16 syndrome:0x0)

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/edac/aspeed_edac.c | 154 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 128 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 91df5d2df5f1..8b48044a00d1 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -32,6 +32,19 @@
 #define ASPEED_MCR_INTR_CTRL_CNT_UNREC  GENMASK(15, 12)
 #define ASPEED_MCR_INTR_CTRL_ENABLE     (BIT(0) | BIT(1))
 
+#define AST2700_INT_STS			0x04
+#define AST2700_INT_CLR			0x08
+#define AST2700_INT_MASK		0x0c
+#define   AST2700_INT_ECC_RECOVERABLE	BIT(5)
+#define   AST2700_INT_ECC_UNRECOVERABLE	BIT(4)
+#define AST2700_MCFG			0x10
+#define   AST2700_MCFG_ECC		BIT(6)
+#define   AST2700_MCFG_DRAM_TYPE	BIT(0) /* 0=DDR4, 1=DDR5 */
+#define AST2700_ECC_STS			0x78
+#define   AST2700_ECC_REC_CNT		GENMASK(15, 8)
+#define   AST2700_ECC_UNREC_CNT		GENMASK(7, 0)
+#define AST2700_ECC_FAIL_ADDR		0x7c
+
 struct aspeed_edac_chip {
 	unsigned int conf_reg;
 	u32 conf_ecc;
@@ -40,6 +53,8 @@ struct aspeed_edac_chip {
 	unsigned long mtype_cap;
 	unsigned int prot_reg;
 	u32 prot_key;
+	irqreturn_t (*isr)(int irq, void *arg);
+	void (*set_irq)(struct mem_ctl_info *mci, bool enable);
 };
 
 struct aspeed_edac {
@@ -49,26 +64,34 @@ struct aspeed_edac {
 	const struct aspeed_edac_chip *chip;
 };
 
-static void count_rec(struct mem_ctl_info *mci, u8 rec_cnt, u32 rec_addr)
+static void count_rec(struct mem_ctl_info *mci, u8 rec_cnt, phys_addr_t rec_addr,
+		      bool have_addr)
 {
 	struct csrow_info *csrow = mci->csrows[0];
-	u32 page, offset, syndrome;
+	unsigned long page, offset, syndrome;
 
 	if (!rec_cnt)
 		return;
 
-	/* report first few errors (if there are) */
-	/* note: no addresses are recorded */
-	if (rec_cnt > 1) {
+	/*
+	 * Report the errors whose address is not recorded: all of them when
+	 * no address is available, otherwise all but the last one (reported
+	 * with its address below).
+	 */
+	if (rec_cnt > 1 || !have_addr) {
 		/* page, offset and syndrome are not available */
 		page = 0;
 		offset = 0;
 		syndrome = 0;
-		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, rec_cnt-1,
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     have_addr ? rec_cnt - 1 : rec_cnt,
 				     page, offset, syndrome, 0, 0, -1,
 				     "address(es) not available", "");
 	}
 
+	if (!have_addr)
+		return;
+
 	/* report last error */
 	/* note: rec_addr is the last recoverable error addr */
 	page = rec_addr >> PAGE_SHIFT;
@@ -81,32 +104,34 @@ static void count_rec(struct mem_ctl_info *mci, u8 rec_cnt, u32 rec_addr)
 }
 
 static void count_un_rec(struct mem_ctl_info *mci, u8 un_rec_cnt,
-			 u32 un_rec_addr)
+			 phys_addr_t un_rec_addr, bool have_addr)
 {
 	struct csrow_info *csrow = mci->csrows[0];
-	u32 page, offset, syndrome;
+	unsigned long page, offset, syndrome;
 
 	if (!un_rec_cnt)
 		return;
 
-	/* report 1. error */
-	/* note: un_rec_addr is the first unrecoverable error addr */
-	page = un_rec_addr >> PAGE_SHIFT;
-	offset = un_rec_addr & ~PAGE_MASK;
-	/* syndrome is not available */
-	syndrome = 0;
-	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
-			     csrow->first_page + page, offset, syndrome,
-			     0, 0, -1, "", "");
+	/* report the first error with its address when one is available */
+	if (have_addr) {
+		/* note: un_rec_addr is the first unrecoverable error addr */
+		page = un_rec_addr >> PAGE_SHIFT;
+		offset = un_rec_addr & ~PAGE_MASK;
+		/* syndrome is not available */
+		syndrome = 0;
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
+				     csrow->first_page + page, offset, syndrome,
+				     0, 0, -1, "", "");
+	}
 
-	/* report further errors (if there are) */
-	/* note: no addresses are recorded */
-	if (un_rec_cnt > 1) {
+	/* report the remaining errors without a recorded address */
+	if (un_rec_cnt > 1 || !have_addr) {
 		/* page, offset and syndrome are not available */
 		page = 0;
 		offset = 0;
 		syndrome = 0;
-		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, un_rec_cnt-1,
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     have_addr ? un_rec_cnt - 1 : un_rec_cnt,
 				     page, offset, syndrome, 0, 0, -1,
 				     "address(es) not available", "");
 	}
@@ -160,8 +185,8 @@ static irqreturn_t aspeed_mcr_isr(int irq, void *arg)
 		rec_cnt, un_rec_cnt);
 
 	/* process recoverable and unrecoverable errors */
-	count_rec(mci, rec_cnt, rec_addr);
-	count_un_rec(mci, un_rec_cnt, un_rec_addr);
+	count_rec(mci, rec_cnt, rec_addr, true);
+	count_un_rec(mci, un_rec_cnt, un_rec_addr, true);
 
 	if (!rec_cnt && !un_rec_cnt)
 		dev_dbg_ratelimited(mci->pdev, "received edac interrupt, but did not find any ECC counters\n");
@@ -174,6 +199,52 @@ static irqreturn_t aspeed_mcr_isr(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t ast2700_dramc_isr(int irq, void *arg)
+{
+	u32 int_sts, ecc_sts, fail_addr;
+	struct mem_ctl_info *mci = arg;
+	struct aspeed_edac *priv;
+	u8 rec_cnt, un_rec_cnt;
+	phys_addr_t addr;
+
+	priv = mci->pvt_info;
+
+	scoped_guard(raw_spinlock, &priv->lock) {
+		int_sts = readl(priv->regs + AST2700_INT_STS);
+		ecc_sts = readl(priv->regs + AST2700_ECC_STS);
+		fail_addr = readl(priv->regs + AST2700_ECC_FAIL_ADDR);
+
+		/* the interrupt registers are not key-protected; clear only ECC */
+		writel(int_sts & (AST2700_INT_ECC_RECOVERABLE | AST2700_INT_ECC_UNRECOVERABLE),
+		       priv->regs + AST2700_INT_CLR);
+	}
+
+	rec_cnt = FIELD_GET(AST2700_ECC_REC_CNT, ecc_sts);
+	un_rec_cnt = FIELD_GET(AST2700_ECC_UNREC_CNT, ecc_sts);
+
+	/* the register holds address bits [35:4], in units of 16 bytes */
+	addr = (phys_addr_t)fail_addr << 4;
+
+	/*
+	 * The controller records only the address of the latest failure,
+	 * shared by both error types. When only one type occurred it owns
+	 * that address; when both occurred attribute it to the uncorrectable
+	 * error and report the corrected ones without an address.
+	 */
+	if (un_rec_cnt && !rec_cnt) {
+		count_un_rec(mci, un_rec_cnt, addr, true);
+	} else if (!un_rec_cnt && rec_cnt) {
+		count_rec(mci, rec_cnt, addr, true);
+	} else if (un_rec_cnt && rec_cnt) {
+		count_un_rec(mci, un_rec_cnt, addr, true);
+		count_rec(mci, rec_cnt, 0, false);
+	} else {
+		dev_dbg_ratelimited(mci->pdev, "received interrupt with no ECC counters set\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
 static void aspeed_set_irq(struct mem_ctl_info *mci, bool enable)
 {
 	struct aspeed_edac *priv = mci->pvt_info;
@@ -192,8 +263,22 @@ static void aspeed_set_irq(struct mem_ctl_info *mci, bool enable)
 	aspeed_mcr_irq_update_exit(priv);
 }
 
+static void ast2700_set_irq(struct mem_ctl_info *mci, bool enable)
+{
+	u32 mask = AST2700_INT_ECC_RECOVERABLE | AST2700_INT_ECC_UNRECOVERABLE;
+	struct aspeed_edac *priv = mci->pvt_info;
+	u32 val;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+
+	/* interrupts are enabled by clearing their mask bits */
+	val = readl(priv->regs + AST2700_INT_MASK);
+	writel(enable ? (val & ~mask) : (val | mask), priv->regs + AST2700_INT_MASK);
+}
+
 static int config_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
 {
+	struct aspeed_edac *priv = mci->pvt_info;
 	int irq;
 	int rc;
 
@@ -203,13 +288,13 @@ static int config_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	rc = devm_request_irq(&pdev->dev, irq, aspeed_mcr_isr, IRQF_TRIGGER_HIGH,
+	rc = devm_request_irq(&pdev->dev, irq, priv->chip->isr, IRQF_TRIGGER_HIGH,
 			      DRV_NAME, mci);
 	if (rc)
 		return rc;
 
 	/* enable interrupts */
-	aspeed_set_irq(mci, true);
+	priv->chip->set_irq(mci, true);
 
 	return 0;
 }
@@ -354,9 +439,10 @@ static int aspeed_probe(struct platform_device *pdev)
 static void aspeed_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct aspeed_edac *priv = mci->pvt_info;
 
 	/* disable interrupts */
-	aspeed_set_irq(mci, false);
+	priv->chip->set_irq(mci, false);
 
 	/* free resources */
 	edac_mc_del_mc(&pdev->dev);
@@ -371,6 +457,8 @@ static const struct aspeed_edac_chip ast2400_edac = {
 	.mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4,
 	.prot_reg = ASPEED_MCR_PROT,
 	.prot_key = ASPEED_MCR_PROT_PASSWD,
+	.isr = aspeed_mcr_isr,
+	.set_irq = aspeed_set_irq,
 };
 
 /* The AST2600 does not key-protect the interrupt control register (MCR50). */
@@ -380,12 +468,26 @@ static const struct aspeed_edac_chip ast2600_edac = {
 	.conf_dram_type = ASPEED_MCR_CONF_DRAM_TYPE,
 	.dram_type = { MEM_DDR3, MEM_DDR4 },
 	.mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4,
+	.isr = aspeed_mcr_isr,
+	.set_irq = aspeed_set_irq,
+};
+
+/* The AST2700 interrupt registers are not key-protected either. */
+static const struct aspeed_edac_chip ast2700_edac = {
+	.conf_reg = AST2700_MCFG,
+	.conf_ecc = AST2700_MCFG_ECC,
+	.conf_dram_type = AST2700_MCFG_DRAM_TYPE,
+	.dram_type = { MEM_DDR4, MEM_DDR5 },
+	.mtype_cap = MEM_FLAG_DDR4 | MEM_FLAG_DDR5,
+	.isr = ast2700_dramc_isr,
+	.set_irq = ast2700_set_irq,
 };
 
 static const struct of_device_id aspeed_of_match[] = {
 	{ .compatible = "aspeed,ast2400-sdram-edac", .data = &ast2400_edac },
 	{ .compatible = "aspeed,ast2500-sdram-edac", .data = &ast2400_edac },
 	{ .compatible = "aspeed,ast2600-sdram-edac", .data = &ast2600_edac },
+	{ .compatible = "aspeed,ast2700-sdram-edac", .data = &ast2700_edac },
 	{},
 };
 

-- 
2.34.1

