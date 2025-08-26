Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0351DF75A
	for <linux-rt-devel@lists.linux.dev>; Tue, 26 Aug 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223388; cv=none; b=A8EUz4qjn9kolN59ZcPOKVdX4ck+SEAyZpYVi6VEXF24swvqvbxiJIP9ceW5KjupalVA0MZFnkufKnEwnQ7ejcC6kmFjKMK/EuPShBB92PeemtpJ8A6mlDKR/GLJ7z5Kg2hGJkEtN9rednNMHPC3sBasbCrCqoUi6DHo7YFRxj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223388; c=relaxed/simple;
	bh=diHKNMqlw9Q4VBnUxB/AQaJFA6eSyu3mzzuDwfFR3dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1POIszbC7e3P8+82OsQ24P5aN3k8N/pSvMAAc/8a7tIplYwZI1kshLHJ5oFwxnYXOa5GRkllo4WundINfq4c+iaOp3TOqFDIg5bD0b1aT2jcz+//jVXmDuK2PxG9nE5S0/gttjvAObPNNrTFE2Tki6smOzHTnGOYYwOMh0HGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qYq7cgOT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8BN1Bwfi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qYq7cgOT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8BN1Bwfi"
Date: Tue, 26 Aug 2025 17:49:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756223384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diHKNMqlw9Q4VBnUxB/AQaJFA6eSyu3mzzuDwfFR3dE=;
	b=qYq7cgOT/Gr+L8+g3GXEyEdg+lYy1itBwjfx6UKrNbhSq7kW+Qa2G5T+wICnOHVyPwy+7h
	hYZ5tYkAR76bYGuJLqEaQi7oPHJbvMNds2AVbYrRxKzTLZFH9hKMYm05hJ1zRl3iTaos8n
	1XtuWAhdMsjBh40Rzz3Xc6EH7HNjJ8jaU8WC/xYx6AFjDf8v6AMfmOpsFPUStiUVn3d2bw
	cYwb5YPjaIzJ1PbbQ8HyNorVGa5pb3UXwNg99hCe/zpiou0CG6xe3evq7kUv4VC9QPUeo8
	ZNpJy3yr5hVttq9fYs9BMncCuQkDgIKu9Oe6bm0OX8qNF3E/vpcf84OUQWg/aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756223384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diHKNMqlw9Q4VBnUxB/AQaJFA6eSyu3mzzuDwfFR3dE=;
	b=8BN1BwfiOEk3SE+f6fj7HMEhEvvqK86tVfBidDu5HKXQ/SBpwVVWkKa0LKUqMf4Tmw1slC
	IezueTTiy8vPWeBg==
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
Message-ID: <20250826154942.BcGs2_U5@linutronix.de>
References: <20250818125242.vJ4wGk20@linutronix.de>
 <aKNlshZmWsHVXBo0@slm.duckdns.org>
 <20250819150105.DYeV89fa@linutronix.de>
 <20250820103657.vDuDuLx6@linutronix.de>
 <20250820105518.Yf36NzJd@linutronix.de>
 <aKYltdkLBRZJF0Ok@slm.duckdns.org>
 <20250821092827.zcFpdnNy@linutronix.de>
 <aKdTEkK5MBz_Fj47@slm.duckdns.org>
 <20250822094812.L4hiquhY@linutronix.de>
 <aKix80fycymWz3Mh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKix80fycymWz3Mh@slm.duckdns.org>

On 2025-08-22 08:07:47 [-1000], Tejun Heo wrote:
> Hello, Sebastian.
Hi Tejun,

> Agreed, once we get rid of them, we can drop the whole block for both RT and
> !RT - ie. revert the patch that added it. But, wouldn't it be more orderly
> to match the semantics in both cases even if the behavior isn't quite
> optimal? We can put some comment noting what to do once the culprits are
> updated to not need it.

Sure. I am only worried that if something is possible, people will use
it. I don't think things will change if we debate for another week ;)
The first patch here in this thread should provide the symmetrical API.

Oh. We could also hide this polling API behind a special API which is
hidden just for three special cases so everyone else would do the right
job.

> Thanks.

Sebastian
