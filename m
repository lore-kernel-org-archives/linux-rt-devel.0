Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E0D33B96A
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584844; cv=none; b=PueV95Jx+hrWmdy11U2URJWPSq1fNMqS2yQDWY/CrAqcghpsOIki9H+xXquWeGEWzRc/l+LMbPtH+TH0uIyWBti37RInYjP3MIEh1PSXGZjOr8kFe7fYEV79qJwnT+XBxgwjOcFvtlmSXJQ0Tt4iXjgVK/8kLDy+TAOx8MGBLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584844; c=relaxed/simple;
	bh=PGBEMNHsRdj5g/9VuDHy8yE6thd3mLpijspYB+g+6og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN5H8lpwEro7YMqnWTcJbeIMwkvLBFM8dbiXiheVUAl3t1mcItSpH+9ESM941OG94bnOgoJPg2RhG5DKSoGVN6+1kxvaxWIoK1NANm1+D+YOu2eXlu/S55wIPjJU9yL7mnZ5bLFpRF714gZzYkqF70x2lWuAqgmiAIkHh+8ybM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QFQLb4Dt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QFQLb4Dt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XYA1/PW/0yIH+JE9voV2k0usAZeLlOr7n78hGG9p8IA=; b=QFQLb4DtnGGuGfg6tzYpMSXF/W
	ue4Jp5++XNHkR2KYLvgIRT7dbompth+qQ+kdEHlX3RYEmuv3XkPzJ19DPeN29oLEl10ve92Sb/rnj
	Y/GZhWvxaOGeNQW0YF8yBcKLMCEId2mlPlhi1ghGMfixcRWCdW/gWI5ZmuApKMF0fHhDtr+Z/QO6/
	7yI77qfOwnAu2iaboZeksr9zTCwGy4PUCuxB7yxvWwfl+NZN/Kphh8kF2poxmSjhe1lMbTrH4nJco
	gZv49PoDsMKt5V3MJ3h0ThE2gsd8pD6nzgE4IEXVC/2PR8uDwXxUsXiQTrx5vpRsW7v58TglFEb5g
	KAPt3GhA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53306)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgnhn-000000002YA-3e5e;
	Fri, 16 Jan 2026 17:33:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgnhk-000000003mL-3E2k;
	Fri, 16 Jan 2026 17:33:48 +0000
Date: Fri, 16 Jan 2026 17:33:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH v4 1/2] ARM: mm: fault: Enable interrupts before invoking
 __do_user_fault()
Message-ID: <aWp2fKGfIQKJ8wze@shell.armlinux.org.uk>
References: <20260116170041.1059997-1-bigeasy@linutronix.de>
 <20260116170041.1059997-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116170041.1059997-2-bigeasy@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 16, 2026 at 06:00:40PM +0100, Sebastian Andrzej Siewior wrote:
> From: "Yadi.hu" <yadi.hu@windriver.com>
> 
> A page fault from userland for a kernel address originates from from
> do_sect_fault() (!LPAE) or do_page_fault() and ends in __do_user_fault()
> by sending a signal.
> 
> Sending a signal requires to acquire sighand_struct::siglock which is a
> spinlock_t. On PREEMPT_RT spinlock_t becomes a sleeping spin lock which
> requires interrupts to be enabled. Since the calling context is user
> land, interrupts must have been enabled so it is fine to enable them in
> this case.
> 
> Enable interrupts in do_kernel_address_page_fault() unconditional in the
> user_mode case().
> Enable interrupts in do_sect_fault() if they were previously enabled.

Do you need any of this? __do_user_fault() now calls
local_irq_enable() as almost the first thing it does.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
