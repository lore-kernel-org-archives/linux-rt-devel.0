Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473CF3DBD7C
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Jun 2026 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771996; cv=none; b=SLMXafs2v4Y1/hPmTETsrYP40PqzIvwlqB0ATSy7sSyG4qYIyIRlA95YHWTUg0xFcDymmi6voKktOjiGFyzazMcXaCPy+Dadb71zJcLisjTnvn2KuCahwYL5z8K1QiyftMmPiW/3402k05npZjtUGMEyebeFTiL6UTJ2NX09h6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771996; c=relaxed/simple;
	bh=90RshJNXcbS0u0V9t6gk2WT1/7k8SRI015G/Y3dPI8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncrFhGe6U5PHXm6QZTeoytWVWYid1Yd/KoG9j85+ixyjeEH52BIScFRdIt/FfvFX1EbUVdNwdUsmqnfqAF695xjsk1PA+q+hAftlqf495B/wrE4sB3ZMrnEktOxrv0qACIG3RNlAGPCRKaKg7BMmaelcvip9wvY6rrUELAYc6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2yA6YGRM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a+W9Xz9h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2yA6YGRM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a+W9Xz9h"
Date: Thu, 18 Jun 2026 10:39:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781771993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/ovdTd4uY76NriLjPfuTvG51woYHXGCCe1NOFnV+UA=;
	b=2yA6YGRMiIW0zc84lKoWwO1tfPH3yl0c5wDv4vHZYF63XEz0hhs9R08ZNtgtJbsYo5C7/t
	tk52D7lK1mRTHgQ9nJ+QYxFqg/e6w377FjTrLYr0nOzTCNtjFzARzzqRVxMl3dsKollszZ
	oO1jMNg81C+RyD81kgMTmQeuKYRuP9M9wmYF0BAOV/tacygPMoAbyihuaSfd0CE14SaOG9
	C7vpe72a8lXGT+iQbyyw7M70mR8IkfQuOShd0SrJIDJHGzGM4eBIY+35QVE9enVyHxrIEi
	4cLrjYBdJ0E16xKZChMgHoeicM5QIsxuzFSswMG9WMMS7Ebkgd7WXUpuSnjZ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781771993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/ovdTd4uY76NriLjPfuTvG51woYHXGCCe1NOFnV+UA=;
	b=a+W9Xz9hwmI/fqkVqBlUSyrE+RxOmn4jPut/eiMWAo/g35/8wP+mmVFVfNsOwmigIIocA/
	s0cY9XrlyLz9vQAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	clrkwllms@kernel.org, rostedt@goodmis.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] net: mvneta: free/request IRQ across suspend/resume
Message-ID: <20260618083952.IbGzrvJL@linutronix.de>
References: <20260617092028.1722407-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617092028.1722407-1-yun.zhou@windriver.com>

On 2026-06-17 17:20:28 [+0800], Yun Zhou wrote:
> On PREEMPT_RT, the mvneta IRQ handler is force-threaded. Under high

There is also the `threadirqs' option.

> network traffic, the IRQ can enter suspend with desc->depth == 1
> (masked by the oneshot mechanism between handler invocations).

That would be irq_desc::depth.

> During suspend, the kernel increments depth to 2 and masks the
> interrupt at the MPIC level (clearing the SRC_CTL CPU routing bit,
> due to IRQCHIP_MASK_ON_SUSPEND). 

The interrupt should be masked while the depth counter goes 0->1, no?

>                                  On resume, depth is decremented
> back to 1, but since it does not reach 0, the unmask is never
> called. The MPIC CPU routing remains cleared, permanently disabling
> interrupt delivery.

But why not? In my naive assumption, we get into suspend with
irq_desc::depth = 2 and the threaded should be woken up. Once the
treaded handler is done the counter should decrement by one. Then again
during resume reaching 0 leading to the unmask. If the thread handler is
frozen and defrosted on resume then it should still happen but in
different order.

Something is missing here based on my naive assumption.

> Fix by freeing the IRQ in suspend and re-requesting it in resume.
> This ensures a clean IRQ state (depth=0, proper hardware routing)
> on every resume cycle, regardless of the pre-suspend depth. This
> follows the approach used by other drivers (e.g. igb).

The igb shutdowns the device entirely, not just freeing the IRQ.

> Fixes: 9768b45ceb0b ("net: mvneta: support suspend and resume")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Sebastian
