Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716143ED3A7
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726028; cv=none; b=k9sYdg7IzUi7BrR0zR8WsilqMmpsQnpQZ1rBPDKOn6mERuArh7X8rXXX0OrZemyXYT24oA4kcVFS5ohNZfjaw3VuLw2FqA0ihhAhqtEuXQEwR81V1WsgOVL2iI92iLlVfbbZ16PyZc2ASYF9CxPYtAkL1c67huV2ZPyw8F41lbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726028; c=relaxed/simple;
	bh=K39QegmarRc+69YCCn/Qzh0OixQo778zpYntp34MNc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6KGHCDMqLHZukiw7H4ipALxg4vcFFm784Lw4hvh04hcl3U9VT+r+nQVKDvaP1dib3FOkR8oBJuYRm8uBT9MJWtalGK9kRdiebECQW26weI++JStuWOges2HPdqLZ8F+/mk6BHJwM5+RdwqznBCJUdxgCVi9624VbYmye+0vG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZcbHkU1o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ia2rmsFh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZcbHkU1o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ia2rmsFh"
Date: Mon, 29 Jun 2026 11:40:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782726024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHpr3kU2Kyzq+FWWd9Tmrgihr14sGrAkX0cDERGN3D0=;
	b=ZcbHkU1odytBpHc0TNfSt5JjcWQoxaq4AldIzyovc3ZvVTRgLGqZdZxsCtEWde4QHjFMg2
	FlrYESVdTpz7ebD+owIdm6I04YN/KLYUpvSKSiEGvjBETSc8xo7hTM372wd3CYeFZFoRVQ
	ZUpN07Mj7NhArCkldYR+0M++cYdrojQ5JIDAnZvQWBgDPsV6tArHx8EWSGw833j/eatgmF
	p934dFpNVEm6l3ZUbboy9O4dM3Ml16mhPIgnEObqS7fFLZ1tpCzU3MfvHlo8QUB8B+YVuZ
	aCTDibd6VRJdUPyxH3sY+5UTCN783Z1X3BqR2xNmhJVx8ECxNp+T8Ynpb7minw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782726024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHpr3kU2Kyzq+FWWd9Tmrgihr14sGrAkX0cDERGN3D0=;
	b=Ia2rmsFhD7py3Nm1QViSF9cbQaz1JUbUlmYxAFmBZkf+eZRFR5h/nNwFMBWUrQk1AHBnsN
	JmM7MHkqm7lEl5Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, arnd@arndb.de,
	clrkwllms@kernel.org, liaohua4@huawei.com, lilinjie8@huawei.com,
	linusw@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling
 user mode errors
Message-ID: <20260629094022.Ml4PCqsB@linutronix.de>
References: <20260629075726.McX9yWi1@linutronix.de>
 <20260629083150.72460-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629083150.72460-1-xieyuanbin1@huawei.com>

On 2026-06-29 16:31:50 [+0800], Xie Yuanbin wrote:
> Thanks. So, can I take it that you agree with the first one?
> 
> On Thu, 25 Jun 2026 20:26:12 +0800, Xie Yuanbin wrote:
> > ```c
> > 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
> > 		return;
> >
> > 	if (likely(user_mode(regs)))
> > 		local_irq_enable();
> >
> > 	pr_alert("8<--- cut here ---\n");

Yes.
If this is moved to the callers of arm_notify_die() then I don't know
what to do about baddataabort(). It looks like it gets invoked with
disabled interrupts, too but I'm not sure. This looks like pre ARM v7.
Is it reasonable to add such a check there?

Sebastian
