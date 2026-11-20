Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189695;
	b=PPF6yQd/ogzNY1dE9A3TBSPCII1/ZMfdYqqtXo/aGIvp5sDk7fEViFZ5YSpHSpcAYbi5
	 3gOZpHlt5razFDgg951NFQGlKsmmJT/XyiOQFTcU8hhcb2lP74h/UFGAvvGMg6MURwQlw
	 uBVqRC+xCGL+/v83A0Jlr3IrSwPDK9HrkyO/zjjyvWa6JJ++x18YmrsziBjw/tUw1YbTh
	 Nn1YPAcWFMUXYQX8ggzMBHcMMbsep79ltOhQWe/+wdUHY5VZh8bCvu+kecN70dUSuUl5q
	 zoiVinN1hCStIwQrxnsgADJ8XuY0Z0VY5cnShxN3mMIiKE0upwHYz3zR5xhzCJ1UDQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189695;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=lK3E1fMHaOAZs00Ok2HQC2Ij476E0NIQR/deVYlEviE=;
	b=c7dAy8ZMaYVqAJN3NxplTa3nvujRHdCMqM6ipunysTEmnGEcevA0tbWRUXkiliRpUByz
	 LgI2inoAB9D9xDsla/SaTCK7CYXBxdihzYb12GBM+MMKozfPVy04luuqmawwZNFkfIpDA
	 IYl1q9/xIh8e5zjDlXNLSd9XCN82uPJKWIlwcm/rWjp0tA6Io4oGp9+w2uWUYF494C2//
	 MELLlHcOuyuTHfbpINKt2pQsuliNDTC1cEn2MSMpi9JpvRy3qdYQGIxBCPAAw4Hz66oRN
	 y3ndmyhShPPrDVtSvJlTSwfzu9gR30SS2x77k0ms2tarEPEr1iwfbC4AH+cCeBUwaGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="z/SryV8c";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7UXjk8Pu;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE07606A334
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 15:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE07606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=z/SryV8c;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7UXjk8Pu
Date: Fri, 20 Nov 2026 16:48:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795189693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lK3E1fMHaOAZs00Ok2HQC2Ij476E0NIQR/deVYlEviE=;
	b=z/SryV8c0ojDqvAVOPkgni9WoJZSvqOMNaMkyN+XhTNEROXdR60sZAWQhhvjnT7ov+c44n
	t/p0aO6SEFLfHIw4FTxRrHeaFCqM8rEj87IRfoducuPHzKG705awosG6JOJ5Cn5lF/STTa
	Cg3UsbnE4wu0zpLtdEMa7q62LUhHz4br00IY9LkExD0JURm6gLGCbEAXwTL+veReQ/2IVD
	Tbqnpbxqh+ro87nHLw1jfqIUlHMDq0cNjS2A/MHrQ6eVAPDiso83sofkjsL2S9bLpGs20E
	TNDqK2S+G2MBcDAKTxLs2Wf5f/hEAespdI1tE0grn771Vx/iRgQ+2vP9lxZ1+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795189693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lK3E1fMHaOAZs00Ok2HQC2Ij476E0NIQR/deVYlEviE=;
	b=7UXjk8Pur15tHS06uYGPYECUOx6EI0Y21J+lV/iKOuN8yUZyIs9bRhPzXgNk3DQaw2zowg
	O7eCsfrVWZuDnSAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Zixin Wang <w1355457260@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	clrkwllms@kernel.org, rostedt@goodmis.org, corbet@lwn.net,
	frederic@kernel.org, wagi@monom.org, atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: real-time: Add boot parameters and
 task isolation section
Message-ID: <20261120154811.Svr3Wf_j@linutronix.de>
References: <20261120152836.100638-1-w1355457260@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120152836.100638-1-w1355457260@gmail.com>

On 2026-11-20 23:28:36 [+0800], Zixin Wang wrote:
> One open question about the idle state limits section: I could not
> exercise processor.max_cstate or intel_idle.max_cstate locally.  QEMU
> exposes no ACPI _CST states, so the kernel registers no cpuidle states,
> and intel_idle is not built for this AMD test host.  Should the section
> stay as documentation-only guidance, or would you prefer that I drop or
> rework it (for example, by pointing to
> Documentation/admin-guide/pm/cpuidle.rst)?  I am happy to adjust it.

processor.max_cstate should work on AMD unless it does not expose
certain things. But then it might be an embedded board, not having this?
Does cpupower report anything?
And I don't thing this is exposed on qemu since the guest goes only idle
and the host decides what to do.

The CONFIG_CPU_IDLE section already mentions processor.max_cstate=1 and
refers to cpupower among other points.

I don't know how you want to structure this information but parts of it
are already there. You could go on an add some settings for i915 for
instance. But then it feels like it should be within the DRM section
because it somehow belongs together.

And there is a CONFIG_NO_HZ/ CONFIG_NO_HZ_FULL section for instance.
It also says that the transition is a bit more expensive. This repeated
again later on.

Maybe it wouldn't be that bad if the config switches would have a
suggestion for the comandline argument that might be helpful/
considered. That way the information pieces stay together.

What do you think?

Sebastian
