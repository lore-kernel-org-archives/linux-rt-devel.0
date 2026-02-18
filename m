Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281D306D3D
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Feb 2026 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399840; cv=none; b=m5dn2imczrJhO2gL4I42j7Q1mmjX0MfflnPlGHaVTOwq3rzrc95UY4vb4O8mpdmdBUmQvXYYje5jDloxKf/2ZwH31sd+8FsJV7ZcMREnMMn29Fgg11jAsqySiUuDe+oS50XLlosuucDWOS5L1V4qaTgRvGiwwlnSSIroQGo/ah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399840; c=relaxed/simple;
	bh=34u/rNF/6gMuqw/QVlKw+Hkw0ctFME7G9F/5KqB8LsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1GrXJsQ/zOXQd54gAeaP7qre1Aa5SS6nCIsQaQVasgOeEnI0w6aw/3W4LuLCZbRO7xnCzvUQbTG4ge0CUW4KUTLRDuRxiH3WdmWU7cBcfZK/LoHjS6Kyg/cNRw9Vk9tO9ZOk67Go/75JLfLSyvTtYaSUHzUyNqIkcrWPSn94tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frHsimN5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2N4jDFl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frHsimN5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2N4jDFl"
Date: Wed, 18 Feb 2026 08:30:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771399838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rE1+nS47WTm1MywF1MSM8NtXNvVjaIpkgpgBHi8uZLw=;
	b=frHsimN5f0WFkWdQz/69DQuAw9hk38yo+1V4Z4MJ/8gpB4qm+/hye4N71URiIQfEINN5Y6
	E6COlf+uIVwSKmZD1GpLFDmb2Y+Kx05zaDhdTkQv+0Wr06dAZqyIcpwR6ow+tue62CBkAK
	SsuRo77Ppkv5suj8XiJFSs2IOOFnbxwcaIfxXhoQZ5bLucWclIkF6PlpKWu0g3rlYomoKi
	XOTISplYcOelNq6JLX9O7039ml3irE5LhptQ/55YzeBLKpW7UACrsc0FYZr1EHKashXBr7
	9Z8f2yGKCpOPEJVwkP1POBX4JZ6FGdWqB7tWy7IB9WiWEZCBBub1WCC/mqAN5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771399838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rE1+nS47WTm1MywF1MSM8NtXNvVjaIpkgpgBHi8uZLw=;
	b=s2N4jDFl/I3362WXwp8T+mzBytfrQXnRjYmii6jBZk1HHGQB2uSMExzRTHMePdUXeCOVMY
	cb8Tn3tHtRrIghCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
Message-ID: <20260218073036.AlkNRoAP@linutronix.de>
References: <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
 <20260216153745.CA3__zRc@linutronix.de>
 <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
 <20260217071952.WCXLGs5-@linutronix.de>
 <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
 <20260217095700.SjYjM8RO@linutronix.de>
 <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de>
 <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de>

On 2026-02-17 20:10:09 [+0100], Bert Karwatzki wrote:
> 
> I tried to research the original commit which introduced the xmit_lock_owner check, but
> it is present since linux 2.3.6 (released 19990610) (when __dev_queue_xmit() was still called dev_queue_xmit()),
> so I can't tell the original idea behind that check (perhaps recuesion detection ...), so I'm
> not completely sure if it can be omitted (and just let dev_xmit_recursion() do the recursion checking).

Okay. Thank you. I add it to my list.

> Bert Karwatzki

Sebastian
