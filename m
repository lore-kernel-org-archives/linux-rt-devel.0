Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F522580F3
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204828; cv=none; b=KmGV7FrQ9ehL3k3cFpGEJDh+4ZxSZCFDxING+jg+GvbrK/QFDRf3q9kNr5acqOo7DoYyu8uUH5zbb6KEhsP+rs6gE8lpW//tSD/WqBAczqLOaibmrSXl8gEGJ9T0R6ingg7b3RfARPxF+bIdERsiASCOTc1Vh0oD9YonQhkX3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204828; c=relaxed/simple;
	bh=OrGnLEaPA40Ypy50xxSGb6NuXyxZCay7HGv5220MxuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUVmuDJQFY3pufzI/WBa1CIcAp7nqDTt1xMXyqxQ0KbtEakodzx43ra0AqILOppbeZaHZLhZhnyOH+23uCZS/Jitbk8Z2VmfK7Fj/zZKt6y8k35N5yLiCGHwFM9UfzOHk42WVawfOeHryL1nJF3Ii1683WPy4N+z/tnmpDsQSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KHpd0st0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KHpd0st0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qDMJjCqZ/aFVApe15tYIJ4bIehn01MV7+TcmlbZlq+Q=; b=KHpd0st00sXgIk5WQxaRD3PvIq
	NmQRNFN4gKRGhvM2ZswwRvR8EY4O3sKMmdFbIyDhLR3obsXQsWt2annXPCSZ8A3EXoqarpy5JWCh3
	ZKY5bPInmuAQCN7ptDBsyytcla8pl1uShiwSGAAm9c9jMmrCUVWUxwGL49m3c5OEcRyXqc+TGrGpX
	gmr05OQBjHBsOatVqA91435FyrPtj3GP6+dbd1GM53QNYesVqHq6lIQDnJ3gEJ5PF4gt/La5IzGjU
	uJC30xUG3Ws07gXKNPbFMACQDPFhGIfHPvQRwSCx64KFNiNkh7VOtHufm33v206AU0Tmzbl3tqlJt
	iX6GaSXQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53332)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1thWcd-0007UO-2b;
	Mon, 10 Feb 2025 16:26:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1thWca-0007dV-0y;
	Mon, 10 Feb 2025 16:26:56 +0000
Date: Mon, 10 Feb 2025 16:26:56 +0000
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
Message-ID: <Z6oo0MExaEy5J55_@shell.armlinux.org.uk>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-4-bigeasy@linutronix.de>
 <20250210120429.iFfBClW1@linutronix.de>
 <Z6oYO5uKlEJ8C8Ne@shell.armlinux.org.uk>
 <20250210153902.06VTSS6d@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210153902.06VTSS6d@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 10, 2025 at 04:39:02PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-10 15:16:11 [+0000], Russell King (Oracle) wrote:
> > On Mon, Feb 10, 2025 at 01:04:29PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2025-02-03 15:16:26 [+0100], To linux-kernel@vger.kernel.org wrote:
> > > > __die() invokes later __show_regs() -> show_regs_print_info() which
> > > > prints the current preemption model.
> > > > Remove it from the initial line.
> > > > 
> > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > 
> > > Is it okay, to route this via the sched tree?
> > 
> > Sorry, its not obvious where show_regs_print_info() prints this.
> > dump_stack_print_info() itself doesn't directly. print_worker_info()
> > doesn't. print_stop_info() doesn't. Not sure whether print_scx_info()
> > does.
> > 
> > Maybe showing example output would help?
> 
> Patch 2/9 adds this. [ https://lore.kernel.org/all/20250203141632.440554-3-bigeasy@linutronix.de/ ]

That explains it - patch 2 is only sent to a very restricted subset
and not even to mailing lists that would be relevant in the absence
of a direct Cc. Ditto patch 1. All I received were patches 3 and 4.

In patch 1:

+	static char buf[128];
...
+		seq_buf_init(&s, buf, 128);

Why not sizeof(buf) ?

For patch 2:

"Use
pr_warn() instead of printk() to pass a loglevel. This makes it part of
generic WARN/ BUG traces.
"

How about cases which use dump_stack_lvl() to dump the output at a more
severe level than warning? Should the message be printed at a less
severe level than the other messages?

> This this applied, die("test") on ARM ends as:
> 
> [    1.595106] Kernel panic - not syncing: test
> [    1.596044] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W 6.14.0-rc2-00009-gb80a798df08c-dirty #13 PREEMPT
> [    1.596768] Tainted: [W]=WARN
> [    1.596946] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022

Hmm. I've no idea what you're testing, what you've quoted makes zero
sense to me.

First...

void die(const char *str, struct pt_regs *regs, int err)

is the die function prototype, so it takes a bit more than what you've
indicated.

Second, "Kernel panic" suggests that panic() has been called. However,
this only happens when die() is called (or more specifically
oops_end()) from either interrupt context (in which case we get
"Kernel panic - Fatal exception in interrupt") or if panic_on_oops
is set ("Kernel panic - Fatal exception").

I don't see a path which would result in
"Kernel panic - not syncing: test" to be printed from this path.

Since __die() does not call dump_stack(), we're not going to call
dump_stack_print_info() from __die(), so I don't think it's appropriate
to remove this information.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
