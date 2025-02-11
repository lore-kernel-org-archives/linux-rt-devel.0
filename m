Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15728230D0E;
	Tue, 11 Feb 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287223; cv=none; b=V0Qe1LlaUP1pC0TqO1fzttdU9APYTXRez5BDU6rWIecVOz8NQ4tlrODwKZCORA25WOIdzFKUBjOJK63wnT+F++6QhqKMflaY+Tytd6JrHBdh0v0ljD9VqmZe/dzLKiQyxx4iJGAS43nKZdz1ztO1oV4Kkb+2hlM2bocBVKpFCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287223; c=relaxed/simple;
	bh=mOAVxW6tetpGZjcYV2weElMouCc/GtOd82EnhQ8+85I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tM70loOzz4qOiyYSW/CVlNMNY0ZwpRtNB2ZI1foOX3SzR2ZqqFwXvWpTFHbS20yMJn88yGWPEnUnkfcL4jC5DaJByH3VJP/YXoAHQ/haKdhhMoechNx/rV4tzbDTi0u148R6Tdr2xRqt/SxE5xfuf8HFf6njArQ2m4rXCyzuTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lo2JW7si; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ri9koU7W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lo2JW7si";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ri9koU7W"
Date: Tue, 11 Feb 2025 16:20:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739287219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xGUgApZDmXbkZQbNRmGSAJtUSm3HnPj/hv+ZmYMXOjY=;
	b=lo2JW7si0mmZdBT+bWGK5iop4rllSU+1FwOOetdO/iW6km9Q09xn5CrJ5o+AAtWdx8L83K
	hYeAMsUZwdMkSvjwvY+rbd423YPZFJoMeXxoGGtih3Mw5R/QL1kcwef1q8sQBdjLbxGfgf
	bFonJdcaXBlzspXMHzvV89BsWGXSjQJ0DTGODPUXz4s5ISBcH+L6GOXmmlJX1GWjnt7NrK
	9BrAvLUf51eCIUNRV213VsquKUDKCYXNHtTznzwB1mKyWoHfPf4xY1B4tEueFdprIwb3FZ
	cGqO+ncxhRNSTEcphbkYghsiudhESx78xBhbFUR1BVi9h7H9FU7mlcJWfwi3/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739287219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xGUgApZDmXbkZQbNRmGSAJtUSm3HnPj/hv+ZmYMXOjY=;
	b=ri9koU7W9LfDekfm23bFg2OwuVj+iGqpawBr8/PqYfdrS3j4PyjGi6qVbLYSCVttRkRiS5
	/Wp4vsG8jfcvyxBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gustavo Padovan <gus@collabora.com>
Cc: kernelci <kernelci@lists.linux.dev>,
	linux-rt-devel <linux-rt-devel@lists.linux.dev>,
	stable-rt <stable-rt@vger.kernel.org>,
	Daniel Wagner <wagi@monom.org>
Subject: Re: PREEMPT_RT testing on kernelci
Message-ID: <20250211152018.sK91dh93@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>

On 2025-02-11 08:33:56 [-0300], Gustavo Padovan wrote:
> Hi Sebastian,
Hi Gustavo,

> Thank you for your email. We are happy that KernelCI is helping you with tests.
;)
>  > Since PREEMPT_RT is now available upstream, would it work to compile and 
>  > enable some of its tests for the supported architectures on Linus' tree 
>  > and maybe the -next tree? I don't think that happens at the moment, I 
>  > saw only a few stable-rt trees. 
> 
> https://github.com/kernelci/kernelci-pipeline/pull/1010
> 
> This will get it enabled for mainline and next. Allow us a few days for processing and
> deploying this in production.

Sure. Just poke if you have something to inspect or look at because of
$reason.

The architectures, that support RT are what you see in
| git grep ARCH_SUPPORTS_RT arch/

so this does not include arm at current stage for instance. So in
general, if you can't select CONFIG_PREEMPT_RT you can skip the
config/ build/ test.

RiscV on the other hand is supported.

> Beyond that, we would love any feedback you have to us. A lot of the infra
> we have today is new, so there are still rough edges to work on.

Sure. How do I see easily what is tested/ done? I could maybe wait a few
days and check the dashboard. The link from above showed timerlat has
been but I didn't manage to figure what has been. I guess there is a
script somewhere handling the logic.

> Best,
> 
> - Gus

Sebastian
