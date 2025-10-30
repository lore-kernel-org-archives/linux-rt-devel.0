Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135038F5B
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810965; cv=none; b=tDfZIBfo+4DNdRudcRN9GclCBkzfuTlgicH8rgM0CQfdjx1dl7faphWDpr16xvb0hqpoiwKsVcGlcu/+S6glNNQ12PUweWzHylOjh1n9upoCCnjwUxlfnvXeJnF9/bfIQAXyXJBtplIuIkV1kyttLDHp45IVAAtCQrtaf78yWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810965; c=relaxed/simple;
	bh=R6z3Ni1MIOL7KInOl/cSVRBCL2JaTr1Vez4ovz6Y7KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhX8QUtfhJ32Pgx9ImQeRfsOHrvsjFpkbgbernVhw5br2yiZ1EhMLxkOKksll16iRco1CgLgRJ4K42cNnaJnNknPEzdTDTJJ82BiHQ/8hc111f+ISALigoKV/Le2fBM0O9ACkgGMTcusLohUMYJRlW4uBVn0nS7F2oYfwgM0CNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iHxDhWwr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nhxrKtB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iHxDhWwr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nhxrKtB"
Date: Thu, 30 Oct 2025 08:55:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761810960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eahf1US0Vntav9eB/jJjGf+ncS6bWMSnIpiA6yHnIVE=;
	b=iHxDhWwr8tfyEM3ulmakmguUXZBwIg/kemtFHgwoFBLGpMLI/7Z6ED7qKaF7UqqZH0ZkoD
	oWPCOStkvVjB6dvt22nKbab7NX3D96DHVYHBb6Hn6u8J4idaK5je4v4IYX5rKDEQgcqIIA
	r8+Jnwnfc+s4zlETRehtmFq9VdS59XtWTsdYZSjk3XXl0O13t3EzZLq8XioNkO4bKf9/Ii
	R+ir8X/mgyOCXTkNcNb3aHuFx84RpzCz3jzouUm6FwMAQWh2HBIhovgcY8lMBlPGQLivAU
	QIKdkcT3znvFJ5WEZCWykKW37a8NkIDe9x4+NNIpkrHKghI+bnu4iGn4P1FYvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761810960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eahf1US0Vntav9eB/jJjGf+ncS6bWMSnIpiA6yHnIVE=;
	b=1nhxrKtBG0GhyZ4c447tMnpRUoOiHappmF3/WgKwVSj3lH+f0rAU6zZ4BtmyxXWbp/vEdW
	U8BqudBHO8w6IqDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev, linux@armlinux.org.uk,
	tglx@linutronix.de
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Message-ID: <20251030075558.sUBj8_6U@linutronix.de>
References: <20251030072339.63vdFNo3@linutronix.de>
 <20251030074507.33863-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030074507.33863-1-xieyuanbin1@huawei.com>

On 2025-10-30 15:45:07 [+0800], Xie Yuanbin wrote:
> On Thu, 30 Oct 2025 08:23:39 +0100, Sebastian Andrzej Siewior wrote:
> > It is not a performance issue, it is a latency issue. If the scheduling
> > latency increases by 300us because of this then the PREEMPT_RT system
> > becomes worthless.
> 
> I understand what you mean. But this delay only occurs when the static
> key is enabled/disabled, right? For users, we can control when to
> enable/disable the static key, but it's a real shame if jump labels
> aren't available.
> Therefore, my personal opinion is that informing users that JUMP_LABEL
> might cause unexpected delays, rather than disabling it, would be more
> appropriate. ;)

You can't really control when jump labels are enabled/ disabled. For
instance this happens if you enable/ disable trace points.
Arm64 and X86 replaced the stop_machine() logic with something else that
does not affect latency in that magnitude. If Arm could something
similar then fine but until then I don't see a way around it.
There are other things that are disabled on PREEMPT_RT due to latency
reasons such as transparent huge pages or expedited RCU.

> Xie Yuanbin

Sebastian
