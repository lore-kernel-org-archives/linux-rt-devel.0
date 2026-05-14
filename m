Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3FC281357;
	Thu, 14 May 2026 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722936; cv=none; b=bNoUibvUhWynIEFuCViuNOdgGoho3mv76ob/kaSw8MGIrId9YPlr47stclFuc7srjKKew14M9v0CrhrQsPkzVa9XS4ExzfVtnYvnX/zfn7j4br2K33oVmzlQinmuFnSuUHr6MTH6rKmc2LdNalBpJsSZsZ2UvNq24eQu6Q+YCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722936; c=relaxed/simple;
	bh=DK16ct83G4Srj0HUW7ghKKUqVVxB9kuz97P4a5FbMB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma5DqeJ9YCZJpN9AJsrhDSzHqYHxmNrumgGiqAHNftXSFNKPzBgbbLb05Ig3uUqOBm6+qur7KAY1eR6+LT5OMrc90qsY0w5uR5xBlbkxdKloKwGwlBRSMQr7il3JQUa7Cv/VJwi3zoJJq8BpTBOYm5wgwgTct5rFiPNar5jWbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzbOsqQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzbOsqQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16AFC19425;
	Thu, 14 May 2026 01:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778722935;
	bh=DK16ct83G4Srj0HUW7ghKKUqVVxB9kuz97P4a5FbMB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzbOsqQJCG+HmliUqwdA5bcU6fazyGxudzSstR8pnHcDV+dkrvCqZd4Hx9+kO2v8+
	 US1Fdsg66CNXlKaVCuTM8ODoSJ2Oesr+1TmtOv0Yu3fl4K0bP0KcOpetrjA71LlL/b
	 BLFUjWAlL/5+340i4/lCVvj7WJimIglQZe6AUuzwr+i9y/55vBnBWdcQWdNDS/ilNf
	 aqc94HJnJ4KoUTfl3u5SYvkKg9IpvBImnMS5rw68vfQF9dVR6VhTVZoiiqhRrYeRqj
	 urolJBlHzE8/zgxl2g3x+N9oeLdzVifQTlrQeSJ7rf7fdBNNdDYJ3LFQLKyCw0aziV
	 dlXnDlB6alqSg==
Date: Wed, 13 May 2026 15:42:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kyle McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Linux RT Development <linux-rt-devel@lists.linux.dev>,
	Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <agUodtxEi24HQ1Oo@slm.duckdns.org>
References: <20260506235716.2530720-1-tj@kernel.org>
 <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
 <20260512113754.448c1f5b@gandalf.local.home>
 <056f95bc5805f7e161458984fff4b3cb@kernel.org>
 <20260512172847.5024e5e8@gandalf.local.home>
 <20260513193914.1593369-1-tj@kernel.org>
 <20260513202432.18dd7b9f@gandalf.local.home>
 <agUdAatmlqQc1NS_@slm.duckdns.org>
 <20260513213108.2870a1e7@fedora>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513213108.2870a1e7@fedora>

Hello,

On Wed, May 13, 2026 at 09:31:08PM -0400, Steven Rostedt wrote:
> OK, this is what I was missing. The fact that the CPU was running a
> softirq at the time that was running for a very long time that prevents
> the schedule from happening.

Right, although, in prod case, I don't think each softirq invocation is that
long. It's maybe a few msecs, if that. However, there's a constant stream of
them and if you slow down the CPU enough with IPIs, the CPU can't ever clear
pending softirq although it only runs a short time each time it enters
softirq.

> So if the current task running is SCHED_OTHER we still need to handle
> the case where the next task is pinned, as it will cause a warning
> again if it tries to move the fair task, especially since that doesn't
> fix the overloading.
> 
> I think this requires a bit more complex fix. Perhaps if the current
> task is fair and the next task is pinned, it needs to look for the task
> after that one to move.

I see. You know the code and history a lot better than I do. Wanna take
over?

Thanks.

-- 
tejun
