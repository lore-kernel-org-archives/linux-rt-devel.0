Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E22DBF75
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820699; cv=none; b=NroYd5voJPrcBPV8uHz16tdMP83BKAotlrnpgJYrj2NOdMDbYjkBTT7dFVCslR0kes20aJFnI7HqA2Tg31/RB6A47UQ/HaM9sJ4/Vo+mKl/vkyL+Qwbud+iHjYNs5l684uygGsHr+QkiUiSTGv08PV/CRYX+WzPoZRMsja2ScXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820699; c=relaxed/simple;
	bh=tSMNCreFvXq69LTQf7VjjG6MLKnI3x0MjfLrAsaSQQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU6IYqCnh9V8KzzTbvFKnALYAjkhCMbdBzXDPHbS6F7lG52XI8JLUhB48+iQ8I66YgM8ocJr6UpRAYGTqk67cncjxzzbM2Eu+2yagP2c60TmVaCaFIqmnBLyt2foRoJDhGtj/BUfQPGEiBDXMEt97CVlUgZqjzNII4o/YS8Sszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=K2ocgODh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K2ocgODh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lEy1pzlBxEDKuz9VSbjEr50+/lWvYrPAgZ9M9/u5gJc=; b=K2ocgODhGfZUa+rFjoxN6HdHrC
	fIemRICg6B7cQX4qQQJxPD++XA+tm3szSlSA1QAolcn2cIG9onf3/Tpx7Zce/5ugAQcw19A7InhpZ
	0DWCbe2BuiIjfF04Z1ptn3vATb5T1mOU/Mt0nBMkDhFFhIs94Nobiu0ct+OojsRS8N3R2zWe1OgUb
	GMkowlp7mIDcN64hWfKrXWdEDA8c9M02A/Ag8rUHt2N2BM54zIm8EtpjmFhkzzYjy3HrHbgP6S/Bk
	vVdXzIyXZczWSiletA1uhr0yuo+XXlJSWzKTvrc5PIP2tB6GbIXe2lGhVeRh2TBajV7ZDNo8t0hSy
	r5Ms6uXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48466)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vEQ2m-000000005Yv-0in2;
	Thu, 30 Oct 2025 10:38:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vEQ2k-000000008Nf-33Er;
	Thu, 30 Oct 2025 10:38:10 +0000
Date: Thu, 30 Oct 2025 10:38:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev, tglx@linutronix.de
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Message-ID: <aQNAEtIoU9sEx3LF@shell.armlinux.org.uk>
References: <20251030072339.63vdFNo3@linutronix.de>
 <20251030074507.33863-1-xieyuanbin1@huawei.com>
 <20251030075558.sUBj8_6U@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030075558.sUBj8_6U@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 30, 2025 at 08:55:58AM +0100, Sebastian Andrzej Siewior wrote:
> Arm64 and X86 replaced the stop_machine() logic with something else that
> does not affect latency in that magnitude. If Arm could something
> similar then fine but until then I don't see a way around it.

"If Arm could". For 32-bit, Arm Ltd isn't going to do anything, it's
old as far as they're concerned. It's up to those participating in the
kernel community to maintain and look after the code.

Thus, if there is a desire for something other than stop_machine() then
it is up to those who care about the issue to do something about it,
rather than expecting someone else to do something for them.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
