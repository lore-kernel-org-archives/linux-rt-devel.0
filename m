Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96BC1A9FB9;
	Fri, 22 Aug 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886069; cv=none; b=PigwuGv4Eo+lgjh8y+nV54M5D21TkSt1yy6twv9Dktl/ZcS4QI5ylmNM56YndATDv3ttUqjvsSzfH1JOj2/wmRZAxKyKsFvCj5aVj9uuEwFVwW2u/8hk8w5mfHFm2vz/gj14a/+Dc0UAVOx51RfdbClZozBMMS3H9v13zw1Uf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886069; c=relaxed/simple;
	bh=TRLO2DCNENsTrov5nyNcOD2c9LJ9eBSAaPzlTkEcayM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9DgsdxQRmmmDFtLqQkX6643KEeCB9cOUh//L8d3zjWkNRG/z/S5JwsLjlM4Q5Wsw3LaxoIkhGeWyqcIEEB1PaWcZ6kccW8wEZN19rXYEmQYfpMl3aJWpZJWGueSSor4HnhTTX9FaGw52DMgsSKvrzGy/36UVy1ZQzouzMGUIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB230mCe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB230mCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F508C4CEED;
	Fri, 22 Aug 2025 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755886068;
	bh=TRLO2DCNENsTrov5nyNcOD2c9LJ9eBSAaPzlTkEcayM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hB230mCefFRs7TfSvZjlWxnaB4i/QJcIMYBg0mFVphlFpKgjYJRFIGR531o2fE2bT
	 mXLfGmqCK+WSZIaLOMaFwcr+1pwAIsxkXgbAlD24o70T331VkRZFc81SYfTz6z0iBm
	 I31knfy3W6fKUVjoWaFWO+63IrvOrV3puxdfmvxcMWUFvLPp4ENR6aGWVAkXHelUNH
	 w/QXUecfA39sfknub5dZOWBnvJopIKQIsgJMtID/VLdBIayvHsT2VL77Fk7Vwd/dmu
	 WcbY0lB+jbIDBdDWUIcsuw7yzYIFFi+vVitgVfygVDl+K0EMQ19lQuyG1Rnc0umzcS
	 b2Rl+HU+r1FzA==
Date: Fri, 22 Aug 2025 08:07:47 -1000
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
Message-ID: <aKix80fycymWz3Mh@slm.duckdns.org>
References: <aJzT7rqwkRQrLGqo@slm.duckdns.org>
 <20250818125242.vJ4wGk20@linutronix.de>
 <aKNlshZmWsHVXBo0@slm.duckdns.org>
 <20250819150105.DYeV89fa@linutronix.de>
 <20250820103657.vDuDuLx6@linutronix.de>
 <20250820105518.Yf36NzJd@linutronix.de>
 <aKYltdkLBRZJF0Ok@slm.duckdns.org>
 <20250821092827.zcFpdnNy@linutronix.de>
 <aKdTEkK5MBz_Fj47@slm.duckdns.org>
 <20250822094812.L4hiquhY@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822094812.L4hiquhY@linutronix.de>

Hello, Sebastian.

On Fri, Aug 22, 2025 at 11:48:12AM +0200, Sebastian Andrzej Siewior wrote:
> > Okay, so, on !RT, that busy loop section is there to allow
> > cancel_work_sync() to be called from BH-disabled contexts and the caller is
> > responsible for ensuring there's no recursion. It's not great but matches
> > the existing behavior. 
> 
> hold on for for a sec: existing behaviour for tasklet_unlock_spin_wait()
> which has three users (a fourth one if we count i915 which has its own
> tasklet layer). Not something that I would call common or wide spread
> behaviour in the kernel (and task workqueue does not have it either).

IIRC, there was a conversion patchset which didn't get pushed to completion
and it hit those, so the patch to add the busy wait.

> tasklet_disable() and tasklet_kill() both sleep while waiting for
> completion and don't spin.
> 
> >                        Obviously, in !RT, we can't go to
> > wait_for_completion() there because we can be in a non-sleepable context.
> 
> Again, only a small amount of users require to do so.
> 
> > Are you saying that, in RT, it'd be fine to call wait_for_completion()
> > inside local_bh_disable() and won't trip any of the context warnings? If so,
> > yeah, we don't need any of the looping.
> 
> No, that won't work. local_bh_disable() will start a RCU read section
> and then RCU will complain during schedule().
> So if the requirement is to cancel a BH workitem from within a BH
> disabled section then we need the first patch in this thread.
> 
> But if we get rid of this requirement…

Agreed, once we get rid of them, we can drop the whole block for both RT and
!RT - ie. revert the patch that added it. But, wouldn't it be more orderly
to match the semantics in both cases even if the behavior isn't quite
optimal? We can put some comment noting what to do once the culprits are
updated to not need it.

Thanks.

-- 
tejun
