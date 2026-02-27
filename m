Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A22286413
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205580; cv=none; b=EpZy+fFjdDgHiI99kLmwtb1/fzqlIhFVXhBomUxJ9EkvQUfho0q/sN/lItKW7uy8WSzCaXNboWb4IbxCSBLojhhNZpLDHxIfeFxMipG8MFgOWFJlSUrTLitdrxNp/G2U+FhKsVEFgu9ShW4CwhLa/E7XKsuB+j04x2gW1KHQdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205580; c=relaxed/simple;
	bh=0/n1kD9CkzyxR+fqgElvbz2XhB+tEET6IUmCWcoJwWI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XrnYIj877muxWaJQ6XR/8XdqU3lpSk/po04TVXspIKKj+w+DFtfP3wDewbyA7jqRlfcWu4xN+jhq39+dlmYEYx+sdoxPowewTVrqsJQmmuCX9u+xMJRKJIiRH/zUmHE2kOCAfFkhoj8PHSxMDqcuTn7vE0RRXbicHLhddieqesU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=p2nIOp+r; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="p2nIOp+r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Quj/ZX3jySC8QUhwpNbHp+WOB42xKk81qiHexqqDj7Y=; b=p2nIOp+r/R1AJ0S/b3Hsx32+kU
	YPyf6ZMm6vc7PBc0g9Gh8zVlf7j5Puulfl9L2HBYANi4vNn5hoOWChJ+mIeC3iw704ZrjtCu1gFI6
	eqP0RNic7I3IkLfUMYzBs7mr9gkM05g7fhStT8Pu/GzNGgx7aBU9xMlpWMwGj5jS1dOLw+6Z2gqOL
	5NDIpnRRif0HdX20yZ+2yKXuRN1EQe6Rb34R0/1MATK6HrknQdXYDNz95VQ744FEeeYcEMOqkMYT3
	dZg1tb1BHT2JGx6M5fhnS4z5AS/fCf/Mu07eYZshUOwQ3GVP3M4i2EFmFxPkZbJIYrMITzFxQSczF
	RpLf7X3w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47428 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvzcs-000000000yw-3hES;
	Fri, 27 Feb 2026 15:19:35 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvzcs-0000000AwoO-03iq;
	Fri, 27 Feb 2026 15:19:34 +0000
In-Reply-To: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 6/6] ARM: provide individual is_translation_fault() and
 is_permission_fault()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvzcs-0000000AwoO-03iq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 15:19:34 +0000

Provide individual LPAE and non-LPAE definitions for both these
functions, rather than having ifdefs inside the function body. This
places the functions closer to their associated definitions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.h | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index 44c0fad29cce..207f1b06941d 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -21,6 +21,20 @@ static inline int fsr_fs(unsigned int fsr)
 {
 	return fsr & FSR_FS5_0;
 }
+
+static inline bool is_translation_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+
+	return (fs & FS_MMU_NOLL_MASK) == FS_TRANS_NOLL;
+}
+
+static inline bool is_permission_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+
+	return (fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL;
+}
 #else
 #define FSR_FS_AEA		22
 #define FS_L1_TRANS		0x5
@@ -35,33 +49,21 @@ static inline int fsr_fs(unsigned int fsr)
 {
 	return (fsr & FSR_FS3_0) | (fsr & FSR_FS4) >> 6;
 }
-#endif
 
 static inline bool is_translation_fault(unsigned int fsr)
 {
 	int fs = fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) == FS_TRANS_NOLL)
-		return true;
-#else
-	if (fs == FS_L1_TRANS || fs == FS_L2_TRANS)
-		return true;
-#endif
-	return false;
+
+	return fs == FS_L1_TRANS || fs == FS_L2_TRANS;
 }
 
 static inline bool is_permission_fault(unsigned int fsr)
 {
 	int fs = fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL)
-		return true;
-#else
-	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
-		return true;
-#endif
-	return false;
+
+	return fs == FS_L1_PERM || fs == FS_L2_PERM;
 }
+#endif
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 void early_abt_enable(void);
-- 
2.47.3

