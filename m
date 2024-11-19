Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1113B7BC;
	Tue, 19 Nov 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014942; cv=none; b=ICv31dcKAYyPGbzPaDeq+t+g+mQEX/gM6s9vNAnjhvwuh/oBk7rwU/7zJI9+2xFKra4w2oBBpqM1a3OJdq/UkRpohhPn3fo7HXAGOCcDEa27xdixzq5U66RsrJhoZ4s08OldjDXzoX0DGBWLgf4Yq5JWr9ARnWKANAgyDKwpv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014942; c=relaxed/simple;
	bh=hAy+6h8hD83vogCaMVHUYUxGM29IK/lT7Q82iQN8DbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFvwMmvZxDqaeCHb052ul5yDSQ3fbXsitL6npRop4hKpMkY9gP99cDNvCNXjhINAGf4H7qvhIVotmNtUaEdbDZeAFujN9PPi4X9Zex3Bi35oy6k8TBUee9pJA9Menkoj5eluoRRRbrTEVvHlPQpwQtdIeeTt5OdQRfl4YSfWNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gDPzIoVM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gDPzIoVM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vhDa7EvCwi3Ez1OIMYpMWwMLYL38nMDlxR2DS522TwY=; b=gDPzIoVM5N1CxyJgV3HJjb44G+
	TngJypE6QwpWk6R+3Q1dlmwkH+d2jC+utNo6+WBm8SlMrnqSxmTINZ6VqLvU4cSReOHi6jjnKiBHG
	EWdgs7UDu5g/VnAWOBC6yVLJ9DK3xQJx5VDEtiZUFFmm3v+hQASLARsh4IBnhh6wxY6WSq7iyyhqw
	wGjK7u8fTcniz6CB8bMsj+bwulQrL3xa769YIBJoBmuSDnisBmTVIAGrpMiv1h5dKjfHzQq+ziUO/
	Y7BUL06ewSfgxGr1BW06J/QevOKntpwt4rZRqr9RQTpYWN7CTxIVe6Ikdz/X+FsgZscPK1aNu/D1Y
	brAbusvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDMCh-0000000406p-1IOi;
	Tue, 19 Nov 2024 11:15:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1F1143006AB; Tue, 19 Nov 2024 12:15:31 +0100 (CET)
Date: Tue, 19 Nov 2024 12:15:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	NeilBrown <neilb@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5 0/4] sched/fair: Idle load balancer fixes for fallouts
 from IPI optimization to TIF_POLLING CPUs
Message-ID: <20241119111530.GA2328@noisy.programming.kicks-ass.net>
References: <20241119054432.6405-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119054432.6405-1-kprateek.nayak@amd.com>

On Tue, Nov 19, 2024 at 05:44:28AM +0000, K Prateek Nayak wrote:
> K Prateek Nayak (4):
>   softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT
>     kernel
>   sched/core: Remove the unnecessary need_resched() check in
>     nohz_csd_func()
>   sched/fair: Check idle_cpu() before need_resched() to detect ilb CPU
>     turning busy
>   sched/core: Prevent wakeup of ksoftirqd during idle load balance
> 

Thanks!, I'll stick them in a tree post -rc1.
