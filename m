Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42433A719
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109000; cv=none; b=nNZh+G+Gd9mWjXshD3jiJieW6wJK3RJYHzwnMquQhGImGHeI39mR5vmRtNJ+phlKov9E78thWHUPLn9/CoHCe8tdgnApttQ8r5f6zZbBldg4uh4BWYGy6sblgZrCUaOcKdZsSMa29jYY2WGMm4nlqEe9EI+THD80K19cwMRrji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109000; c=relaxed/simple;
	bh=VLnhpu9kvdPu7GL0sRb4lnlKsX6ErC8WrqgwDeDfxwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9/b4bOPte32BztTnRowgsnaYwL+jVvTGN/dZRLK3Um9TXRKEE56qWcu+poBVUJeM3bBsZAiuZ5PwtnG/Gy7Q858hu4kPHN7i8Cru++1e0ovXXh+63wXCmR2m8Vk5MIXHsXcwOs+Ed0ToPM9Pft8LnCjNuyYKe/UC2vJlD589DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HGpZuHzG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HGpZuHzG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pr+8ExyOhFxW/Uz4btSXrzEhPFdn+MVB6LdMQibRYoc=; b=HGpZuHzGxjaKNDkGGJJid5glay
	5hMT/4g7xmwuGLThWi9lbZaCDMCu+rYp3wijiDQtm601uNutXM7BiANvKLcd6IbfN0AQiwftMFfbk
	9e0B9QAB5WzNX6ZxQEmeql5WIrVaVgMHtChctKYJCS080QG5xg3fNYFPI3SXJCXkbfOwLFaueiggL
	uriyBEZ3ulpESGQhbJGh9uJDKqfbb8zCIDMwdxr3hA7aHMXFl9AuiyL2BfumcpiC9pNp9ILK4qprS
	CcFSAL/PU5VJFvy78IgS2dxjpXNY+wja/U983SX+6Fd491N2lLoR00kfj6SSTxHuqZ3JZ1F02FGCm
	SxkV6OEQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52834)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvaV3-000000007v5-1PAl;
	Thu, 26 Feb 2026 12:29:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvaUz-000000001xL-31zo;
	Thu, 26 Feb 2026 12:29:45 +0000
Date: Thu, 26 Feb 2026 12:29:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>
Subject: Re: [PATCH v5 1/2] ARM: mm: fault: Enable interrupts before invoking
 __do_user_fault()
Message-ID: <aaA8uR3_o55uuevl@shell.armlinux.org.uk>
References: <20260226111742.3598421-1-bigeasy@linutronix.de>
 <20260226111742.3598421-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226111742.3598421-2-bigeasy@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 26, 2026 at 12:17:41PM +0100, Sebastian Andrzej Siewior wrote:
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
> 
> [bigeasy: Initial patch/ report by Yadi. Maintained the patch and redid
>           the patch description since]
> 
> Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sorry, I've been swamped with stmmac for ages, which has become a
millstone.

I need to push out these patches:

ARM: provide individual is_translation_fault() and is_permission_fault()
ARM: move FSR fault status definitions before fsr_fs()
ARM: use BIT() and GENMASK() for fault status register fields
ARM: move is_permission_fault() and is_translation_fault() to fault.h
ARM: move vmalloc() lazy-page table population
ARM: ensure interrupts are enabled in __do_user_fault()

which will address some of your issues, and clean up the fault handling
code. These patches all date from 5th December. :/

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
