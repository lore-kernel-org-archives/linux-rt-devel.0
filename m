Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C044724D
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177264; cv=none; b=IVk+qjiD5us4HYKP7G3MY7Oe850xEMZbqn4iVQhz5AnAZhDUoHa7SvI6x1Wmh4Ncq7yDZoZsD2/sUo5hhYUpAtWcbcese2Q8p/1cYJbQRrZQQdp4Eg9GWkEb40sYs2SZxfm/2rDII6Sqj/3RTKRyBB/D6pRwuhEKF4L4O0UKajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177264; c=relaxed/simple;
	bh=3CgVcZpr9CN0Txsd+z8rfzxe9rcLiPO2X6bNrPjyKbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ0mRsouAIC+c1jRChBp3g19mJTaE1y/TrxcMRtGXAzaCH1pYJ0JJRpgzOgn10l6EmXkz42apDSJu4pn/5+POHKWRMgK2FXV+XPnM8eTViVWqmOBD112Yc+C9xKkAX8+qlj7eX2Mk5k8K6ENqcPN+HOuchWlx3BD0gkwT1IYdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elvztB2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elvztB2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A336A1F000C4;
	Fri, 16 Oct 2026 19:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792177260;
	bh=yCjRuiZJxMp4SVs+eT4Ltj1VWHSh53ZvjvCAGOp5zvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=elvztB2TqTktwTuyl+qIHSHrh6YNZBxUmJGJEWStnuZFIdXTaW7vLmLM6GArjolSr
	 6MwI8M6OmMjniSowoqZHSmZDJ6SuE3XViwopHD1CJTPqHjxevWl9g52n1w7W+2kj3o
	 gfu4SdaZjO7XP9WL96CRqoy//9OfO6eoA2hcqZPVrczwMQ63PEWtaNjei4OSr6Msh0
	 uROI11vewMjSsPF814jkdj9Z55xS/VbST+9/GJNUyEv+IcY91FrSxku8gnEcL4cpPh
	 ePmKDWzK7Ph+ZzGvVtPc1I9lAfNLm+63uTUhdsXLFjh0wwqQ6v895hR33pmwOxKPFu
	 aMNzmm4FYF6dg==
Date: Fri, 16 Oct 2026 14:00:59 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v6.1-rt 00/15] net: Backport backlog-NAPI threads to
 resolve PREEMPT_RT softirq warning in SMP flush
Message-ID: <atJ0axhl3AHQIDsa@demetrius>
References: <cover.1791912669.git.wen.yang@linux.dev>
 <20261014150853.f8I2fNx0@linutronix.de>
 <atDWZDywit4ilzJ8@demetrius>
 <20261015133811.PtBdJYyx@linutronix.de>
 <2c3a8c0f-3820-4531-b179-b2656a7d3c7e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3a8c0f-3820-4531-b179-b2656a7d3c7e@linux.dev>

On Sat, Oct 17, 2026 at 02:16:02AM +0800, Wen Yang wrote:
> 
> 
> On 10/15/26 21:38, Sebastian Andrzej Siewior wrote:
> > - NET + proper list
> > 
> > On 2026-10-15 08:34:28 [-0500], Clark Williams wrote:
> > > I don't have a fundamental objection to the backport and agree we should
> > > do v6.6-rt first, then move that back to v6.1-rt.
> > 
> > Okay.
> > 
> > > So it sounds like we need to pull in the RPS code first?
> > 
> > Yes. Wen, do you mind preparing a series for v6.6-RT?
> > 
> 
> Hi Sebastian, Clark,
> 
> Thanks for the feedback.
> Agreed, v6.6-rt should be fixed first to avoid reintroducing the issue
> when users upgrade from v6.1-rt. Regarding the RPS prerequisites, I will
> check which upstream changes are already present in v6.6-rt and identify
> the remaining dependencies for the backlog-NAPI threads and defer_list
> cleanup. I will prepare and test a series for v6.6-RT soon.
> 
> Thanks,
> Wen

Perfect. I expect you'll have a small series for v6.6-rt and then a
pretty large one for v6.1-rt.

Thanks Wen, I'll be ready to apply/test when you send it. 

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
