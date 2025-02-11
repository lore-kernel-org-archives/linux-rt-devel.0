Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724E250C1D
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286349; cv=none; b=KD3qvwOlyJKGUsfchu8BvKLrQqR401oXI/xr7K3f5uHCJ4QjtZ4ynY2kUHdOyuMu7zsrn+3Cc7Aq46U4f4xzIi9sdWYzz73tFbewp5MWNX3C1MqE3agGla4oQrQlTuEeULD95ckpcguZpgkC/GGhp49ByPPWguMPGUGAUqTStQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286349; c=relaxed/simple;
	bh=gILxc1vlFfC7Cd9Gfzulte7qbvFGDw5/GEDFFZYIvxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAUkBZhY+qxswmekQjO8GEUjfD3Ih9VxmtLDrzFwAYo7p/BA5wTDmg61r2dlzzJVQokX7FrsWHPbcpWH3wxGEaN0caUIZbGUipJ14x92va9DFX2nO10t9DzDw6mLdehGDHU6lyHCTNjMIFngdblUh8v3VlDecghd1Qg/TnlCZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=da6tO3St; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="da6tO3St"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wMch1HIVZL0GsRqZJwBamjdSUtwIeuUTfLpGso7d8Mc=; b=da6tO3St4QZjVO9rW5F4uw5AHD
	FKKdPane4YRfDJt9BuaW78I6ABcPLDGY9pB2W9mebXiwCvIrkcJ6MYsl0ck6XjJrA7Hvq3F8D8/Gk
	2p6aS/oHO5W3vxSwSZO8d52Tceo0y+QVrfstynyfMd3Fer0pexVHmRnB/JeC1cKR5u8CaPaxt6tmG
	RMGSjhW7oY6BSTKK/Etjg1oitWjybsNRHf7qNvvhZqiz10sGQM/PSsA7T3LFQInUbUHUgQGxG7xh/
	FPxwbYS7OUqo53l7IkdQne4GIwwQSli6lFvWL+cK1InoT2pakLgxpGldWVToqhIde+fAAtJSZqURN
	KvoCpPWg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51408)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1thrpV-0002fz-25;
	Tue, 11 Feb 2025 15:05:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1thrpS-0000AA-0g;
	Tue, 11 Feb 2025 15:05:38 +0000
Date: Tue, 11 Feb 2025 15:05:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/9] arm: Rely on generic printing of preemption model.
Message-ID: <Z6tnQvIBlGnoGRN_@shell.armlinux.org.uk>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-4-bigeasy@linutronix.de>
 <20250210120429.iFfBClW1@linutronix.de>
 <Z6oYO5uKlEJ8C8Ne@shell.armlinux.org.uk>
 <20250210153902.06VTSS6d@linutronix.de>
 <Z6oo0MExaEy5J55_@shell.armlinux.org.uk>
 <20250211145249.StI6tEZv@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211145249.StI6tEZv@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 11, 2025 at 03:52:49PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-10 16:26:56 [+0000], Russell King (Oracle) wrote:
> > > This this applied, die("test") on ARM ends as:
> > > 
> > > [    1.595106] Kernel panic - not syncing: test
> > > [    1.596044] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W 6.14.0-rc2-00009-gb80a798df08c-dirty #13 PREEMPT
> > > [    1.596768] Tainted: [W]=WARN
> > > [    1.596946] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
> > 
> > Hmm. I've no idea what you're testing, what you've quoted makes zero
> > sense to me.
> > 
> > First...
> > 
> > void die(const char *str, struct pt_regs *regs, int err)
> > 
> > is the die function prototype, so it takes a bit more than what you've
> > indicated.
> > 
> > Second, "Kernel panic" suggests that panic() has been called. However,
> > this only happens when die() is called (or more specifically
> > oops_end()) from either interrupt context (in which case we get
> > "Kernel panic - Fatal exception in interrupt") or if panic_on_oops
> > is set ("Kernel panic - Fatal exception").
> > 
> > I don't see a path which would result in
> > "Kernel panic - not syncing: test" to be printed from this path.
> > 
> > Since __die() does not call dump_stack(), we're not going to call
> > dump_stack_print_info() from __die(), so I don't think it's appropriate
> > to remove this information.
> 
> Okay. Let me try again with a stack overflow during boot. With the
> series:
> 
> | Freeing unused kernel image (initmem) memory: 2048K
> | 8<--- cut here ---
> | Unable to handle kernel paging request at virtual address df82a000 when write
> | [df82a000] *pgd=80000040007003, *pmd=41487003, *pte=00000000
> | Internal error: Oops: a07 [#1] SMP ARM
> | Modules linked in:
> | CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.14.0-rc2-00009-gdca8d546a8a3-dirty #16 PREEMPT

Got it. Printed from __die() -> __show_regs() -> show_regs_print_info()
-> dump_stack_print_info().

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
