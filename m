Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0D40F8CF
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205568; cv=none; b=scL70AQPlaEsVdVxxP1Zfg/HmQMjtawCh8s5m3N/Iil5G0lC6Hbfftf0+pCqxJA4qqx8ScRQnn5CF6XfHT4nbydG8mq+0UMOqv/kCS49GryfsYIQBTTuuoxRY8EdEo0l1lZW4TNpfglPFYp1COPy/DGl+xy5OyncXZJG2Mu/+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205568; c=relaxed/simple;
	bh=yTaJbAluWYKYz6zsANLaiEjQofM1kSMDJZwNue03QyY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SErNUR3gEAPST+YAZKi8HZow73cnlC4SPALvWFuj/Vk+5I3HTe8BiVQJFamjQWmISIQzxCyqSm+7vjrsmwGbgsJ1AerlRYTeGBrXbBmjlDne5HYtomLNFkiZg4WEjeXVp/lC8o++JhH7QqGU+VZeP+cZETD4zeOVxWaYjjDlViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qOupxukB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qOupxukB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b8f+jjLUuEPjOIj2EFH8Sf+p1khoKw+4tTQ8ZS3xXOc=; b=qOupxukBeAYE/SA/shquQFNVe9
	6jeL8AZzJFjrkHHXcunJV4bwA2mb+iFB68xaWMlIz2qOZ3TIkHwh+aWPjACH1x1JmffJg583oxOpJ
	/NLq5y7Es1zxJC9GhwKauXzAJYjDiRzV5iZgPLOm+CS+kgNNcyHAetqyH7tfBa4nRZ0YjHIQSHyTL
	pmz6GnTRUCZXdHH4B8nzM4RKk1fF8IJLNe9LdybJqkq4+UHx0dk/ZJzX2aqgOAPqlmho1eMIENTiA
	X7oKBu6fQClfA6787HVOkMoxdcyreJ1O+0NnViv1GxTERp86dpQhHVKjt2p9ZPQe3dWpQz78mgg4m
	j7mg1NtA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59016 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvzci-000000000yX-2L0g;
	Fri, 27 Feb 2026 15:19:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvzch-0000000AwoC-3JkD;
	Fri, 27 Feb 2026 15:19:23 +0000
In-Reply-To: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 4/6] ARM: use BIT() and GENMASK() for fault status register
 fields
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvzch-0000000AwoC-3JkD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 15:19:23 +0000

Modernise the fault status field definitions by using BIT() and
GENMASK().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index e95f44757dc9..d2bdedaefe14 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -5,12 +5,12 @@
 /*
  * Fault status register encodings.  We steal bit 31 for our own purposes.
  */
-#define FSR_LNX_PF		(1 << 31)
-#define FSR_CM			(1 << 13)
-#define FSR_WRITE		(1 << 11)
-#define FSR_FS4			(1 << 10)
-#define FSR_FS3_0		(15)
-#define FSR_FS5_0		(0x3f)
+#define FSR_LNX_PF		BIT(31)
+#define FSR_CM			BIT(13)
+#define FSR_WRITE		BIT(11)
+#define FSR_FS4			BIT(10)
+#define FSR_FS3_0		GENMASK(3, 0)
+#define FSR_FS5_0		GENMASK(5, 0)
 
 #ifdef CONFIG_ARM_LPAE
 #define FSR_FS_AEA		17
-- 
2.47.3

