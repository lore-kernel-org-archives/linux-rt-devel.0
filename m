Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05502286413
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205573; cv=none; b=bt8qo/u4k6i4zKhcLnLdtJxKiis0N0B9WuBRrNiqiCR2zzK1ChDIOBr0rE/1Izdp4Zi6j9ylNnaCrCrtELX4QlsIgQ5D6ChuDsIR0YrIt21rFCGpZQMRIukezMT3GCLguvg4XpprxRQn9lZozYgNGHM1XNVvNFpuYTWGviIvld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205573; c=relaxed/simple;
	bh=bjb2VxnZLavOmnLouq7tWHNq7iTKG5PlzydGkyVtuBI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bjS87YxwwJs0mKMaFkSMxhl58uLe06RQzwdFRAAesqzjprlHakvxyStgT3yjVnXTGFSGm5sJxD52o+0BGvsXT4B7aTzCCe8vHEZPhp9uoTQNTCcYVwHUVExlV5yTeGhVY1zeh7GkPBQCrBALBTeUnvHEa34qPLEMoi0UCZcWotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rwVFDEHt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rwVFDEHt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jM89VooTCsyDyj3RpueyCnQialfJtSYcR3IS3wxm5tY=; b=rwVFDEHtxJ6vBL74EM3pjfnU/S
	YmPH7XxXkgtYQtgF5oSyYr6HOFRZFwYdlzRrQPx333VB7eTp238pnErCCxKP3NuZ9YRkfEFz08Mwd
	ax0n1YxolALwrXi8i+34P4ciQNGrvqM+RGvEE6ADyP4u7P6FRvO9kPPZ+kQj7vh6PVcL6v18zFsR/
	+RiQ3tFeckZfbD8RlA9q0Ef5hOrJ2AFcGNhhLx43a5AQHCGYyB+mJ4FkCL82ispETjyt2iuThr3Lm
	i+aLSKYG48CQupdKLIgLsj0+8iqGynyytXl5YL/CFvNuYjwB1AkU+TwYniMpo6q2ElqN1/uMlsg3m
	OnCjSA4w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47422 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvzcn-000000000ym-2YJu;
	Fri, 27 Feb 2026 15:19:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvzcm-0000000AwoI-3o9W;
	Fri, 27 Feb 2026 15:19:28 +0000
In-Reply-To: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 5/6] ARM: move FSR fault status definitions before fsr_fs()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvzcm-0000000AwoI-3o9W@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 15:19:28 +0000

The FSR's fault status bits depend on whether LPAE is enabled. Rather
than always exposing both LPAE and non-LPAE to all code, move them
inside the ifdef blocks dependent on LPAE to restrict their visibility.
No code other than fsr_fs() makes use of these.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index d2bdedaefe14..44c0fad29cce 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -8,9 +8,6 @@
 #define FSR_LNX_PF		BIT(31)
 #define FSR_CM			BIT(13)
 #define FSR_WRITE		BIT(11)
-#define FSR_FS4			BIT(10)
-#define FSR_FS3_0		GENMASK(3, 0)
-#define FSR_FS5_0		GENMASK(5, 0)
 
 #ifdef CONFIG_ARM_LPAE
 #define FSR_FS_AEA		17
@@ -18,6 +15,8 @@
 #define FS_PERM_NOLL		0xC
 #define FS_MMU_NOLL_MASK	0x3C
 
+#define FSR_FS5_0		GENMASK(5, 0)
+
 static inline int fsr_fs(unsigned int fsr)
 {
 	return fsr & FSR_FS5_0;
@@ -29,6 +28,9 @@ static inline int fsr_fs(unsigned int fsr)
 #define FS_L1_PERM		0xD
 #define FS_L2_PERM		0xF
 
+#define FSR_FS4			BIT(10)
+#define FSR_FS3_0		GENMASK(3, 0)
+
 static inline int fsr_fs(unsigned int fsr)
 {
 	return (fsr & FSR_FS3_0) | (fsr & FSR_FS4) >> 6;
-- 
2.47.3

