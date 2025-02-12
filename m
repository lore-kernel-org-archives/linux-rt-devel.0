Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B8210186
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380916; cv=none; b=NuIXr/kGH7/f/Nez5ZWDnln0s+wxQCYI/WsI3hn85E5blWApTjD6T7/JKlHAS33QAZTLkt+wYWo+iiEqNBLIQaZwshboGqwSWwNc6mv47GQSoRrSJYYgoS6MIr+SyReZNDId8rQBYl/W9hyeGrFf+xC+gm3Zay1bhQf/yO68dP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380916; c=relaxed/simple;
	bh=55NjTwjZlA4vw7PUj9bs8A9XkcEYDqOyE3twIxfDs/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d913LLv1kNlaYSCVTMY77/dkM8skXv3hwVKgf3MjTUfAy9MpVsMTklBHg3kePJNgjFJI9JM1Jv1JNZ1KoZ/nRLZICV1g3ygS57XXc3p3z2ZOMfWEooe7agrSyKD0rc1VlDFI8Pny2tXFHBuQ2bVsiYysf0OS5hE9IcDztUVKG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PDIEqjYF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SRYEobPH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PDIEqjYF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SRYEobPH"
Date: Wed, 12 Feb 2025 18:21:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739380913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CyfVin1u1oK7DfpnQULRSmAXjKYLLSeAv1EfBRzwKn8=;
	b=PDIEqjYF8vDXQV9gwipWO9rtRGDg/R/HJAbaY4NH5vMMTEdGQNK+jgO5Fi1FCO1CTghb7I
	ABIexs77zHVd8LTWltEQwgBq7dzw6b5JzL/BO7YekNXV7tt7TlcpkNP13MDzcqckSmd/o4
	k0IjGXu7/pOu6KUrC4V6WmpOf4pFFx+BXUucmGgh6u5WI6pPrHHi/BVneaMj5J8RY2iEpz
	f3Gz0XR3KizArDhYGtpTuscRoEAt7Zgmt5DLiW7cA6sJ9YyARp4ndBR8K5MSdYvckurdua
	pfwfewHFTTXw1tkbYKAl2La1CM+Z4Jz9lDYit7wbnXFKBt0DNgvGeZhIAWHdnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739380913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CyfVin1u1oK7DfpnQULRSmAXjKYLLSeAv1EfBRzwKn8=;
	b=SRYEobPHUMUYI6s7+mRK2Jcz5CsE653jBvCid7m6iVl/YGedeEBaMGhaKLaoBGfjencpzC
	Im4rDx8087AhqTAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212172152.6f66lcrk@linutronix.de>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
 <20250212114531.4e95ffe7@gandalf.local.home>
 <20250212165908.DoNnHJ5v@linutronix.de>
 <20250212120328.28fe4123@gandalf.local.home>
 <20250212120706.7e169c2b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212120706.7e169c2b@gandalf.local.home>

On 2025-02-12 12:07:06 [-0500], Steven Rostedt wrote:
> 
> Expanding on my argument. Why does it work for non-PREEMPT_RT but not for
> PREEMPT_RT?

The semantics are different. It is not a race on !RT but *might* happen
on RT.
The other alternative would be to add additional locking into
pcnet32_access() and avoid having the lock in the ISR.
But this driver/ hardware is old and probably hardly used outside of
qemu. We did not have any reports about this recently. We had a few
reports within the net stack but this is gone now.

So. Adding your suggestion into the core code just to satisfy one driver
is not something I had in mind.

> -- Steve

Sebastian
