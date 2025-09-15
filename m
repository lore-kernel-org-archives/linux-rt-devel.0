Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F289B2EA73C;
	Mon, 15 Sep 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936302; cv=none; b=Rd2PQ3GmNG/7k3TyD0lZXJ8/DEvWU2huumadJjSO9AredFv2WmN4qw7DmMuXlJQY9y4mbpNeNTYW36XsZKMEyn8DsrDnb4u89w/OQehFW62wC81ZEeW4zQzFocHWb1chbnOxT1fNzS2/RaVYxXUy44RT6vriyy3HZef4UymM35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936302; c=relaxed/simple;
	bh=JYNVJIQ+KCus0A36WKqCvNfU00D/LtJkh3+59Dgtx+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx/FYjOrswaSI1KMhEAK5JKG73bHxy2Zo1doj0XgoWwi+Yd6pYfMHH2gsrQht27d51Tq3YO+j4KipJPe8X6aqDPPa6L5757yogbZVuxiG0Nv5vn137zP1Tw1GloVX7iJIApkGPhyXXxJVjxwfFEtMMDCmpiKmAKczCyBuhj6ato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H5kzPEdG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H5kzPEdG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NeLhdcfZv1l+tdaDjamOF3/UpWIu4NEGtM80D+oDqHo=; b=H5kzPEdG5/WTXdQAafq8AMKh6R
	L9R6fbvdG5BZLF+LgZa3mO8SKQdZhCVVdqRa4+zjYvdRrwS2xivSGVA46Ejqb9b1K4u0+6+mfTqtp
	hkzp792ppfpv3TRkOVcuhECgJzyiirFxgmEieO3oli6RWFs52kObFY246fGW4G47JV6THd/ncn7Em
	aSbV8j+wsZH2hffJ6ZkGoYBzz2J/9K/8ROglUtgfmjfoMiOD6Jb2eCqGp5Bctrd0JrkqofSUmHUoA
	bCp2aOQ50PADXhkm4iWFnT1xxnIS2K3qq2d82trRKYCV+unf9PJ0ZXt7BuAowduUdOkEVdneygE/F
	fCvUCVNg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7XB-0000000EKdi-2Flr;
	Mon, 15 Sep 2025 11:38:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7BF38302E03; Mon, 15 Sep 2025 13:38:12 +0200 (CEST)
Date: Mon, 15 Sep 2025 13:38:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RESEND PATCH] sched: restore the behavior of put_task_struct()
 for non-rt
Message-ID: <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
References: <aMf1RzZHjdoPNOv_@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMf1RzZHjdoPNOv_@uudg.org>

On Mon, Sep 15, 2025 at 08:15:19AM -0300, Luis Claudio R. Goncalves wrote:
> Commit 8671bad873eb ("sched: Do not call __put_task_struct() on rt
> if pi_blocked_on is set") changed the behavior of put_task_struct()
> unconditionally, even when PREEMPT_RT was not enabled, in clear mismatch
> with the commit description.
> 
> Restore the previous behavior of put_task_struct() for the PREEMPT_RT
> disabled case.
> 
> Fixes: 8671bad873eb ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
> 
>   Note: This patch is a fix motivated by Oleg Nesterov's question at
>   https://lore.kernel.org/linux-rt-devel/20250728201441.GA4690@redhat.com/

Right, but I thought we did want to make this behaviour consistent.

Why have !RT behave differently? That is, why isn't this simply a
'buggy' comment/changelog issue?

>   Also, the kernel test robot reported a problem found in a x86 (32 bit) VM
>   test that was bisected to the original fix being amended here:
> 
>     https://lkml.org/lkml/2025/9/5/147
> 
>   Though I was not able the reproduce the reported problem, this patch here
>   would minimize the problem by isolating the behavior to PREEMPT_RT-enabled
>   kernels.

Yeah, robot also had trouble reproducing that if I read that
%reproduction thing right.

And IIRC RT has been running with this for ages, and never seen a
problem.


