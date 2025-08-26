Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530EA31A567;
	Tue, 26 Aug 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225650; cv=none; b=QpdlYYoMLoEtlG1MfSTfASDw4MLoD+Slqf6sCLfch+y+mBw8HJIrH1d/vrshiKqRjidICJXhCOxazKGdEA5ykKxQf+wHMWXf8id3gVB15UYy0adcLn9mEe+9QU1/bellHWKSKipZ+Tgny6KnpBRYNUGTTkCbwHCjGA6XUnhmwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225650; c=relaxed/simple;
	bh=U5i6Ai9CYUMbdmoeMp+ZUqbk8vq+WFrcMy7YrJP1WM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRglG8yvj18x6G9XfU81gBsdcWoA90H9o8JomN85KiQOq1/7C/pDt28JT3fITusiSmNhofJHVWZzYOwRKKOjFyl3DJu+EvlbuuUSYQyVs7LGERRLtqaT/C3xqzdw6ruu9Xb66CeBJoLSHN5HdhMLBC2p7es+O6YMjkct3KJc7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuHX962y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuHX962y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2B3C4CEF1;
	Tue, 26 Aug 2025 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756225649;
	bh=U5i6Ai9CYUMbdmoeMp+ZUqbk8vq+WFrcMy7YrJP1WM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JuHX962ycdqh+pGgK05dllJQ9dS8EFFkt/XJrQFGHNVpHwRwMJ4Ys8DEnGl10VFs6
	 R2UX0zzQN1hcCozXsJbo1ZFDcisjIi3IMCmz0brUYcBts2ydPlW9xS0IgRMrYo1AEw
	 6TxSlOK7gAo1ES5r1wTDdKnH4HuB3airDCoXIA/zIR8e9hE7Kj7oYHyjRPQsu21eRc
	 t/N46x7bz23QvTyMAiQWyPkCBb5VzpRqCeFMhAmQxx7l4j5/wT0q43D7PMUlm2Cwco
	 m/MG5ntCP9cgDI/xOMpkeR22tUm772CxdHy8ekRUx71/g0E+hywe/nJ9xKM6IIBnLy
	 2xMN+TChm6a8w==
Date: Tue, 26 Aug 2025 06:27:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <aK3gbywOkrksPQeV@slm.duckdns.org>
References: <aKNlshZmWsHVXBo0@slm.duckdns.org>
 <20250819150105.DYeV89fa@linutronix.de>
 <20250820103657.vDuDuLx6@linutronix.de>
 <20250820105518.Yf36NzJd@linutronix.de>
 <aKYltdkLBRZJF0Ok@slm.duckdns.org>
 <20250821092827.zcFpdnNy@linutronix.de>
 <aKdTEkK5MBz_Fj47@slm.duckdns.org>
 <20250822094812.L4hiquhY@linutronix.de>
 <aKix80fycymWz3Mh@slm.duckdns.org>
 <20250826154942.BcGs2_U5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826154942.BcGs2_U5@linutronix.de>

Hello,

On Tue, Aug 26, 2025 at 05:49:42PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-08-22 08:07:47 [-1000], Tejun Heo wrote:
> > Hello, Sebastian.
> Hi Tejun,
> 
> > Agreed, once we get rid of them, we can drop the whole block for both RT and
> > !RT - ie. revert the patch that added it. But, wouldn't it be more orderly
> > to match the semantics in both cases even if the behavior isn't quite
> > optimal? We can put some comment noting what to do once the culprits are
> > updated to not need it.
> 
> Sure. I am only worried that if something is possible, people will use
> it. I don't think things will change if we debate for another week ;)
> The first patch here in this thread should provide the symmetrical API.
> 
> Oh. We could also hide this polling API behind a special API which is
> hidden just for three special cases so everyone else would do the right
> job.

Oh yeah, that makes a lot of sense to me - splitting it out into something
which is named explicitly to discourage further usages.

Thanks.

-- 
tejun
