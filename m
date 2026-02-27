Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4119220F2D
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205563; cv=none; b=S4fVdu+b5/sfPkgQFOsyNVs6t3g/Lcsf5Rj1ig+Q3qH4nQMLZx7Cfta92jRBaUcWwe76c6BbDd1EMhuPnGV681cyy7q17AzLxHbtDB4lG1KFwMWQHpiueGbHrXUJnd0ZgxMWdaBaCfX9WH1JHvApgFa+rUVMBesrcHL7ldo348I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205563; c=relaxed/simple;
	bh=bYfLX/wrXpFLCMKUwFnxezaYju+2eGJS6xctg7DNc+o=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=t1jxDMSAn2j5D6dSwuu6TwipnTGsiOcqGjSFBhW4Upj2DDMz3lUrYKjR6P1K0yTszMqMA4orQBzb4kSgkAEmEDcP1T90d54hgvvJxdszEvpYzUA/DuL03jSICGHLL9T0ThvIBf+HyAH5AKW5VskBOQTOg2tbHjFb5Wrmm16SETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=R8LXlWlP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R8LXlWlP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NEDF1h4DToBH7xC2ataksBPzKU9iqPLKYlA4C0KD+CM=; b=R8LXlWlPnb/TAijZszftYnBn9h
	UcPa99aAXrQzjfR+ekgs0kgW5pOSZEFGM8ZO3GPd17X5GqB0hJMdcwM58whrbsA+l2g5wMUGu3E4H
	jZQq0Fli5bGZK1m0EgDO7PIfyHBaczVcFSujcUwV0FXLmgyrDjHYrJEsMFGVkoWeho4llEO+RgAkt
	yqANjntpRbQ9LK6UKA5WfjGk5zDlCi/HP3n9ZRRCNcWy759iMxLjb2gACWug9t6zx3m7SlwpIifST
	urahw+rylEHe5uB/fjt9tvM/D6yRXfwskbo7VBv8ujJgr0x49ylNkL/3il5rXw3rkOT0MmCBvdPB5
	IwMqC88g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59014 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvzcd-000000000yI-23Jg;
	Fri, 27 Feb 2026 15:19:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvzcc-0000000Awo6-2oph;
	Fri, 27 Feb 2026 15:19:18 +0000
In-Reply-To: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 3/6] ARM: move is_permission_fault() and
 is_translation_fault() to fault.h
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvzcc-0000000Awo6-2oph@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 15:19:18 +0000

is_permission_fault() and is_translation_fault() are both conditional
on the FSR encodings, which are dependent on LPAE. We define the
constants in fault.h. Move these inline functions to fault.h to be
near the FSR definitions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.c | 26 --------------------------
 arch/arm/mm/fault.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 0f3b6cc516c1..e62cc4be5adf 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -115,32 +115,6 @@ static inline bool is_write_fault(unsigned int fsr)
 	return (fsr & FSR_WRITE) && !(fsr & FSR_CM);
 }
 
-static inline bool is_translation_fault(unsigned int fsr)
-{
-	int fs = fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) == FS_TRANS_NOLL)
-		return true;
-#else
-	if (fs == FS_L1_TRANS || fs == FS_L2_TRANS)
-		return true;
-#endif
-	return false;
-}
-
-static inline bool is_permission_fault(unsigned int fsr)
-{
-	int fs = fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL)
-		return true;
-#else
-	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
-		return true;
-#endif
-	return false;
-}
-
 static void die_kernel_fault(const char *msg, struct mm_struct *mm,
 			     unsigned long addr, unsigned int fsr,
 			     struct pt_regs *regs)
diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index e8f8c1902544..e95f44757dc9 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -35,6 +35,32 @@ static inline int fsr_fs(unsigned int fsr)
 }
 #endif
 
+static inline bool is_translation_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+#ifdef CONFIG_ARM_LPAE
+	if ((fs & FS_MMU_NOLL_MASK) == FS_TRANS_NOLL)
+		return true;
+#else
+	if (fs == FS_L1_TRANS || fs == FS_L2_TRANS)
+		return true;
+#endif
+	return false;
+}
+
+static inline bool is_permission_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+#ifdef CONFIG_ARM_LPAE
+	if ((fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL)
+		return true;
+#else
+	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
+		return true;
+#endif
+	return false;
+}
+
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 void early_abt_enable(void);
 asmlinkage void do_DataAbort(unsigned long addr, unsigned int fsr,
-- 
2.47.3

