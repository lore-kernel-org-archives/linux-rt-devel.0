Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6BEEBB
	for <linux-rt-devel@lists.linux.dev>; Mon,  7 Jul 2025 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874523; cv=none; b=dxaPi8x8MZARieYN7rgkKKxrLFVsORjSSBqPNwS6sszblBwdRc+NfMFEzRcp80h1RwWpozar+d16NVtFfxC3wYUy6e7SubDmPqkDrvsc5yuViXloQFZIR8DLD+RoxWt3YszomnrQlrIqcy0Roh8tfwJqm7VZLbfK0/bLpvqsR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874523; c=relaxed/simple;
	bh=cH2swmMd5K+BZZdi5yD46movVpLTBsGAaFdBSr9i4iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQEECLJnSZPr/yNA0Pop2+vGGLn+Khj0wbuxPXAEbxgyH+sV3sYsyX6XXcaT/H4yhn2PEi5+E65XPjsMskDS1L2DawZFAoqruXC4+JVREHjD69SXegMySaAujSLxtCY3aLFznywUUUWeTI5vtHm9dv88M9rfzEnWri2Y+FAJWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvAyjv+2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PeQKoIM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvAyjv+2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PeQKoIM"
Date: Mon, 7 Jul 2025 09:48:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751874519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dU4SwaCPUGqndsRZNikINhiZyqeyVTpDnrJpcq4qFNw=;
	b=jvAyjv+26qjJkqZ6hHdxYRXvRgjXZchddBYhDRtyD9c/RicoLqUBlIY7wwbnalNoKGs+B0
	qmX/ZF4lMP9VWaR5tmhgoEVuytKmNFIyLucCL26kIL1ikmLcbgPE7L2zgEDsIo8Co7ngZD
	1HG2S9RNex0ffm/MRdTzVWDODm9jH0sWAo2gYvzAezPPEKoi9NN7ttMpusRHC9ols5j4AJ
	1meaPzmeOhQyM0MnslMpMmtZP0DrkAnSfUA2WM6qcZzGb7xN278kcSLMUJBOH4wMiOcjjN
	XkBebyp4lBA2xR0lAnDoi8X19xR4XhnY3FBqqzRLIyU1bmJq5DE3+gBmpslMgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751874519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dU4SwaCPUGqndsRZNikINhiZyqeyVTpDnrJpcq4qFNw=;
	b=3PeQKoIM8jplZXWrEnOQc8zGxdh2iSMWkFUyt757nOJaWVq/MVvVUZX3QUrJ3MYuZ75fZ3
	JEYIYRloapmT+8Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: linux-rt-devel@lists.linux.dev
Subject: Re: proper place to get up-to-date 6.12 with realtime patches?
Message-ID: <20250707074838.IvnzjFwF@linutronix.de>
References: <9e726dc8-e753-4f91-b3b2-9ea526e846b4@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e726dc8-e753-4f91-b3b2-9ea526e846b4@windriver.com>

On 2025-07-04 12:17:30 [-0600], Chris Friesen wrote:
> I'm a little confused about the intent of the linux-rt-devel/linux-6.12.y-rt
> git repo relative to the linux-stable/linux-6.12.y repo.
> 
> Given that the realtime patches are merged into mainline in 6.12, what's the
> point of linux-rt-devel/linux-6.12.y-rt ?   Is it just for changes that
> aren't yet mature enough to make it into mainline?

Yes. There is a handful patches that did not make it into v6.12. There
are not considered critical but still useful. This includes:
- support for ARM (32bit) and PowerPC
- Atomic console/ nbcon support for 8250 (the UART on most x86 devices)
- lazy preemption
- i915 support (the GPU driver)

> Thanks,
> Chris

Sebastian
