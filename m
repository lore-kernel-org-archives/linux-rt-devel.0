Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB542848B8
	for <linux-rt-devel@lists.linux.dev>; Thu, 28 Aug 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397100; cv=none; b=sTYEvh+LxvUQWrGlQpnbgp9l0kvQbnJDJVsP7SLhqTLRPtOUxk4NxXKvhh55CnSvYzV57kNiGjgA29LtVkBiBN75/3kbvvjHj+KS5WMDeW0OT4UeLHPPjXI6DI0oiXbGd0rhNqYuVQ/n+eqog3+uNDpIVdTtkGZLGogFnbjBs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397100; c=relaxed/simple;
	bh=ecVMeP443f64m+M+NmMkG4F5JybvvXU7SpIX8upmfhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X81rlM8cskqJTvDfteko2mMqjZnRPVIl9HZ4ZgkWX2ObTl9UWvt11NthEFMHqi1wYh97HX5t4DaHwdQynCeA2p7Cnj0rsvvjQSqE1u7iZoj0qtGrng/77CZdWgF+KhD4Iqs2TUuaqIOWxNf9VB3+h5xq3cxKjqX4pSxaf95GGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2fAWHEFh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rqd6HEqk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2fAWHEFh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqd6HEqk"
Date: Thu, 28 Aug 2025 18:04:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756397096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecVMeP443f64m+M+NmMkG4F5JybvvXU7SpIX8upmfhk=;
	b=2fAWHEFhcs28s66ugBbyfln+vyjsbXqNmjzM0hhvMDxzuElxcZRiVqLQVGrcdCRRCDJIV0
	SFq91LjmzaKLikhhZbgmuX0hQIKB7lTOQvkxdGgWZGv+wXrZE3EHSHM6obXqrnjVNn2OMk
	lhSIPCmkVht+RNmGGOrmXOU+GmoVoGbxL3WVEPlSE4+qn4htNsoulMEQCCq5Z4gxj/F9rC
	IK4CJ4d/xc5DSVDDNL6I3dI0Onfz+M5HgJz0NHLUaSHHwmm6PmXMH4sEjUvGGm946mG9sX
	9AY8RNIrjcXWJQesLJZJQXhY1U2k+DfPeo9sGJzw4Ofei+vKtSpClbtSwPl2fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756397096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecVMeP443f64m+M+NmMkG4F5JybvvXU7SpIX8upmfhk=;
	b=rqd6HEqk+37sKUz4GGl5DoVeRJ7Cgl4e2/pi7DNlcWyBtS7kEjUBBodg0wU0tcwHRFeKaW
	j/H1sKZwUxW89TAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <20250828160455.4dxzTug1@linutronix.de>
References: <20250819150105.DYeV89fa@linutronix.de>
 <20250820103657.vDuDuLx6@linutronix.de>
 <20250820105518.Yf36NzJd@linutronix.de>
 <aKYltdkLBRZJF0Ok@slm.duckdns.org>
 <20250821092827.zcFpdnNy@linutronix.de>
 <aKdTEkK5MBz_Fj47@slm.duckdns.org>
 <20250822094812.L4hiquhY@linutronix.de>
 <aKix80fycymWz3Mh@slm.duckdns.org>
 <20250826154942.BcGs2_U5@linutronix.de>
 <aK3gbywOkrksPQeV@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aK3gbywOkrksPQeV@slm.duckdns.org>

On 2025-08-26 06:27:27 [-1000], Tejun Heo wrote:
> Hello,
Hello Tejun,

> Oh yeah, that makes a lot of sense to me - splitting it out into something
> which is named explicitly to discourage further usages.

I am a bit lost now. Do you intend to apply the patch and we came up
with the bh-canceling-from-bh API later on or what is the plan?

I can repost it of course together with the tasklet patch.

> Thanks.

Sebastian
