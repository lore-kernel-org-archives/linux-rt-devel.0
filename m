Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19E2D8789
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921984; cv=none; b=AZHmuZdAO43mhY3r1svk1aRN8pn9qqPoyAvODRe/mt1pCNprbQ8nrrmWrXkxhkQq0s5ES3w2Hk+l8k3//1nGwoQ5tkwCvNFhH2i82XhOnj6cUPuTnUEZfIyJorL9K0htxEKNzkZnXYthwvTRy37ZF4SKJlYKgTcdGGr6nUPAiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921984; c=relaxed/simple;
	bh=4E85oH5E9Zzy/ABqxPb8kOunSpXHlqPS+tsJFRbOTb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/4nZNm6zvrCDYzUKpo+XhD2dmWpYviq7uj4ka2zmZbdmGxhrJOsKV5lqJexcrvy9lnpc3sxRXOM/i9Z8tBlzc7qspvd37gURC5MmIdMSGKHQocNSdp1AaVLJXt6UOqZHrh0zFZqO2OOBNNXe1Ddvqsg+wfumFHIhFaaotsFjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R5RU+4H8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VChVCQH8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5RU+4H8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VChVCQH8"
Date: Mon, 15 Sep 2025 09:39:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757921975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpEiPV7wEY17f5IV+r2JTWh/WyLf4D/MFLe7AaM4sTU=;
	b=R5RU+4H8F3fTK5DthtlQ6CMXyMwhRfjChvEuvaAG1DG5/gJyNwAqFwbZm397JAD2Ch3nGj
	V7VZpk7KI9e3c9pGQbU1KmSPASG81y3FeFbCqbUqw9Dm+bOjfxRzaVrmB65k2I9UrKVxwy
	60ED1OmRX3UAV8TVJUK+574yzgRknSB1BcXKOPPRJ6HZmSX8/GSTwjxN3rbS85XUwWJPHg
	2FUtegME2sfe32Dy6pRdoNvDsdOmDnx5gXUVUbyqX5Fs1GC/wuqvnx3kR2R7t1Za4fM6i5
	EPZmCwQ9hQIsmeDBArhqePBnkd6TZtXiFG3cwgVTngLn0FSLXvv9OFmo1OX8Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757921975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpEiPV7wEY17f5IV+r2JTWh/WyLf4D/MFLe7AaM4sTU=;
	b=VChVCQH8Y7yAVx07IYUL5SC6nLDb7f4T8NLSI/nfEIdE6DPiVpqDexxT8KoA6kql8MOcEO
	Uqxu/Lp+oKc8oeCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/3] softirq: Provide a handshake for canceling
 tasklets via polling
Message-ID: <20250915073933.L7UOtfkj@linutronix.de>
References: <20250904142526.1845999-1-bigeasy@linutronix.de>
 <20250905101502.6525-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905101502.6525-1-hdanton@sina.com>

On 2025-09-05 18:15:01 [+0800], Hillf Danton wrote:
> 	CPU0			CPU1
> 	----			----
> 	lock A
> 				tasklet C callback
> 				lock A
> 	cancel tasklet B
> 	DEADLOCK-01
> 
> After this work could DEADLOCK-01 be triggered, given no chance for DEADLOCK-02 ?
> 
> 	CPU2			CPU3
> 	----			----
> 	lock A
> 				timer C callback
> 				lock A
> 	timer_delete_sync(timer B)
> 	DEADLOCK-02

You are not supposed to acquire the lock, that is also acquired in the
callback, while canceling the timer/ tasklet.
Tell me please, how is this relevant?

If lock A is acquired on CPU0/ 2 then tasklet/ timer on CPU1/ 3 can't
make progress. Now CPU0/ 2 waits for the callback to complete. This
deadlocks as of today regardless of PREEMPT_RT and this change.

The difference is that !RT requires two CPU for this to happen while RT
is efficient and can trigger this with just one CPU.

Sebastian
