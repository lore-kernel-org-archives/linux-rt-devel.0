Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B162248A8
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Dec 2025 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690398; cv=none; b=dUXwD/dwqMo6dtANy19uwOK5nCauDlPqzETfXY56vCpFuNzbPM5oXymy83nCIhu8fiVQ43mpc/v1tj2oj4owrXnZU05R6W0zRhUiT27lcZGatOLoJomUAZ5uZYsvID61N0UhGnTOKA7k5DxyZe/66vk+e3hLPahcnBPsOicXhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690398; c=relaxed/simple;
	bh=KjtMcdo1q07YLEnKSETnsu9YPtnqxwGw5nK+k/AAiN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoJGp8twAxUm6zU6WBfR8nFfsYGrSM5gCynCsImeuw0RUH/dInrJ57e2eCg6iiDKdJinaIBzNCfJA0fEQToDWS1fhfvrrVDzQcMCFD/1zEQNKeo596WxnBziVOIC/3N9Rvd+apt+aGzoPnzORuuvtCQO2kK24Z8WxnFZmLjuRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pGW1wQMD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pGW1wQMD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B8lVeEewvobMOpR8lC3k8lo2AR9tpKYDSUjo/3iThWc=; b=pGW1wQMDB4gpVcAKDhhrvOYIMF
	S+z2LpAbMdBAY5XqI1fKjg3P8u2iCOqMO4V4QEPppqxcuKT0/3m+J/t1w4LeF8OAbRzSZuemnp8BH
	lGdUigCNtpumHjdEYQZ9a2vtwZTMHMvBplbgfIGWsB3C9nGptZHiDxtwPuQZ4mEhiyzSbZfaaOYIc
	27qdV3AxAeC+BJeAFNdPbC2zJWBKK1hkxbaBkzlLJylXr4moCUnz8wJK3sag6v/qc9px+7BSKVNWi
	ZI8yjuBc78wbyBMg70rqFMSMGxuVzF/31CbQi2nbiOMgt4DqsWa+IaI3C7wofwyrU5mXMFpowX/JU
	jmWpMz2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59058)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQSaC-000000001pg-3HUd;
	Tue, 02 Dec 2025 15:46:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQSa9-000000007Zj-1Cyb;
	Tue, 02 Dec 2025 15:46:25 +0000
Date: Tue, 2 Dec 2025 15:46:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Xie Yuanbin <xieyuanbin1@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>
Subject: Re: [PATCH v3 2/5] ARM: mm: fault: Enable interrupts before invoking
 __do_user_fault()
Message-ID: <aS8J0WrmmH01L3K1@shell.armlinux.org.uk>
References: <20251110145555.2555055-1-bigeasy@linutronix.de>
 <20251110145555.2555055-3-bigeasy@linutronix.de>
 <20251202141816.wfHNUMFK@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202141816.wfHNUMFK@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 02, 2025 at 03:18:16PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-10 15:55:52 [+0100], To linux-arm-kernel@lists.infradead.org wrote:
> |
> |   https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9460/1
> |
> | Moved to Discarded.
> |
> | This makes the issues with the branch predictor hardening worse if this
> | patch is merged on its own - since this adds another path where
> | interrupts are enabled before calling harden_branch_predictor() in
> | __do_user_fault(). It would be sensible to move the interrupt enable
> | into __do_user_fault().
> |
> |    *** PLEASE DO NOT REPLY TO THIS MESSAGE ***
> 
> I thought that we apply both.
> In 9462/1 I am moving harden_branch_predictor() out of __do_user_fault()
> because do_page_fault() needs the hardening before the interrupts are
> enabled. Do mean something like

If I apply 9460/1 without 9462/1 first, then it makes the problems
with the branch predictor hardening worse. I'm not prepared to do that.

However, 9462/1 is tied up in the discussions that are ongoing, and I'm
not going to short-circuit the still-ongoing discussions that touch
this area by applying this patch - which would screw up everyone's
proposals to fix the various many problems that are being discovered in
the 32-bit ARM fault handling.

This means I can't apply 9462/1 nor 9460/1.

Since 9463/1 likely requires these, I can't apply that one either.

Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
