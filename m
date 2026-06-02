Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8D392C39
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Jun 2026 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382215; cv=none; b=W5djDKyPf23iVkUXXJF/7XUV0TJ/V01iETqf48e7JIEBVBiRO6lAFONyTRb1eA2N396PO/BUOc5o6hNpUsesoqkTfB439SaL+mFDbgNagyKxy66t+KGoodxN+hXdTK7Z//XGe7i4z0X1VdhgiwjwIDtk5ED/gw2y2UaTzLDCUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382215; c=relaxed/simple;
	bh=uN2KLYfWe4/29fI1yyckzMO9Lym1DS4Z7QZVgj9g+5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+8jhI3xFKz9xYjprkEVugI9HsZ78vVCqk/7gTEOxEb21EcQjFRer4nS7qMRDAwJTREE7HORuqdSY15oFd2jLodDd/3s3MLYme5bzyVsUEX0exFAr2VmaAsVul7FmmIrzJDA16+bgpb0QYZYFqCMs3FkQ0Htm1LsoL8bAtBKaHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LGU9wEcv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XVNQH8sg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGU9wEcv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XVNQH8sg"
Date: Tue, 2 Jun 2026 08:36:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780382211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZSsvRsfJqlkrFBLO1/Int2sfDx4YeIQ8CEnym8UuY8=;
	b=LGU9wEcvZgmh49lq0Ih4nyUrm4SEFQ3QPjN0AyiUHRSpdLo+Z9xhjJUx6hoE91VyuIsCRD
	XADqryeO97HuKVLaSX6NNXrEwC9woWhzu+TpeAUv8NXsrd4N7xpTnpqpIxVjEW3yvZCcsf
	t/rM90cxqlz2CWbkKE8kY+2jJCmz/ibGfXX4AK/bH17Ho7tc3skTKBZyTavUtJjapZIeUN
	kgksACuWgSyvcRoxnXFwFo7WlwMlL/5GNXopiBSDEcL5wQ9EQeCy7G1xUFbILg5fFDeqBY
	lpC2MuulbitSSxDyWnC27YkLZfvkGVwC4CVisC2esHSh9e/9vBQ6gCcsoFWQdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780382211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZSsvRsfJqlkrFBLO1/Int2sfDx4YeIQ8CEnym8UuY8=;
	b=XVNQH8sgVtfYFFl/3saLdnaVj395BGbsPlx7nuQ5/RFxFZCWwdmGmyPDzh4Te96EuC9Pxa
	2g6nAtmmTUMrLkAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Rodolfo Giometti <giometti@enneenne.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eliav Farber <farbere@amazon.com>,
	Michael Byczkowski <by@by-online.de>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v7 1/1] pps: pps-gpio: split IRQ handler into hardirq
 timestamper + threaded handler
Message-ID: <20260602063650.LWatIBPk@linutronix.de>
References: <cover.1780359378.git.calvin@wbinvd.org>
 <2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org>

On 2026-06-01 17:44:09 [-0700], Calvin Owens wrote:
> From: Michael Byczkowski <by@by-online.de>
> 
> Split the pps-gpio interrupt handler into a primary (hardirq) handler
> that captures the PPS timestamp at interrupt entry, and a threaded
> handler that processes the event. This produces the same two-part
> handler structure on both PREEMPT_RT and non-RT kernels.
> 
> On non-RT kernels the threaded portion runs immediately after the
> primary, with no behavioral change compared to the previous
> single-handler implementation.
> 
> On PREEMPT_RT, where interrupt handlers are force-threaded by default,
> the previous single-handler implementation captured the timestamp
> inside the threaded portion, after IRQ-thread scheduling delay. With
> the split, the timestamp is captured in true hardirq context as it is
> on non-RT kernels, eliminating a significant source of PPS jitter on
> RT systems.
> 
> Tested-by: Michael Byczkowski <by@by-online.de>
> Tested-by: Calvin Owens <calvin@wbinvd.org>
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Michael Byczkowski <by@by-online.de>
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
