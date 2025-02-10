Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407A62528E1
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200584; cv=none; b=MYdX/pHNxJLh2h2zTD7dYslKbYB3WN0F/V6+omdqIwlKLpNeq++33L5d2W7gAJ94eizwpYp1KP2EMpHbMqpKxUGDXjz2dYgOrXWhIE1hHZAKINfiDTZX7pO4k/6VQd6IfKm48ENHoAudO2pScSvYcw9J9/AcabWKRln9VMKtfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200584; c=relaxed/simple;
	bh=yFqEwFQVYDr4xD5HeQRBZzXl/2LV8l8Outuncqf4vvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThJQB7XssDCq3aFG5et/md1NixAlO0M/ow/smKBENC8A8fcjihq9DfLK9rSPz3YIBdij6wfeLFNHnrFsy3rZf0sd5R3pB1+j5kOoPOMIz4qfx+fZVn1WeWJ5JaGJGHbI81Vc+18ruPdJh4X1qUhodSd4GN6qTDo/bmRcii49RjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VFZf6KvB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VFZf6KvB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=24qpgPKCLX23k1AKR52IOhRUFCOiLCPIqtuu4KporW4=; b=VFZf6KvB5ssMyfWM08F+vvn2PN
	iCje30a75JbS+LvoP+qqOZfyDpTeylYr7cMt+TtDr1SvKcV2YmJS+Qqw3QVOP1NgEqv35cwuGlL/m
	AGyugs113kfS5OtwK9Eqb3rI89bGRweuDFyIm6CdFbJ5h9ipX2MY8BMGq44xgPlO8BZ78KoyOveeL
	+5d2bmF9sFYM4Ezxu+bNhNunN5LvttxOeLD280YBi3nmqESnveq4gMsCilfzxh2QmJPAY7Al1Jn4Z
	gNGsaFmOVIIjcmBgkdCh8f5I658IlbV5vB2lOT7q5sw0LZaLnisrnT9iMw/KjRwaedwPYakP9QI8N
	jDRtw+AA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51130)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1thVWB-0007Hf-1n;
	Mon, 10 Feb 2025 15:16:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1thVW7-0007bH-1a;
	Mon, 10 Feb 2025 15:16:11 +0000
Date: Mon, 10 Feb 2025 15:16:11 +0000
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
Message-ID: <Z6oYO5uKlEJ8C8Ne@shell.armlinux.org.uk>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-4-bigeasy@linutronix.de>
 <20250210120429.iFfBClW1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210120429.iFfBClW1@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 10, 2025 at 01:04:29PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-03 15:16:26 [+0100], To linux-kernel@vger.kernel.org wrote:
> > __die() invokes later __show_regs() -> show_regs_print_info() which
> > prints the current preemption model.
> > Remove it from the initial line.
> > 
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Is it okay, to route this via the sched tree?

Sorry, its not obvious where show_regs_print_info() prints this.
dump_stack_print_info() itself doesn't directly. print_worker_info()
doesn't. print_stop_info() doesn't. Not sure whether print_scx_info()
does.

Maybe showing example output would help?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
