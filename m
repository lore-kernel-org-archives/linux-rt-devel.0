Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6582238178
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Feb 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771312795; cv=none; b=pmxzWiMo2TKjfGB5y5q7pkmIj/edFHebfWtukL1AuRzsujMO02RPNjo1PZ6oJJEB+a8tPhS+CTvOnG1yLurnmh8c8iNN07MyS7Oq/rxtYD27Zbu9/rUutxW/Lgyj5BOz6/WN+WeEEwgMhtZZTPRvIGk4kfei14EBCnzMJoyGrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771312795; c=relaxed/simple;
	bh=eQg6QLcVDKqCgHiLxCzWj4OYcujtxb6HPqfPmoO6P7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RI3ZevJpXxvlcoFGOLbe33anprxOsqBlbOMDjOdN5Od7uctIwDfY16VirIr/Tz08dsdrUuVYqzUgQu1dJwqk9kh/9AJgL2DRA8B6rio0Sg3eLcDd7XkWLFeD7hsl4IiuBQB/5Oc/JLbvFfdrfDSp/B9g2rivd/JlwWeuphhYMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rcPGJqkk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SJikSH17; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rcPGJqkk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SJikSH17"
Date: Tue, 17 Feb 2026 08:19:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771312793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+nEmqG34AHLoCUk7+SmL8r7gVNhaExyqHx2t8wbuKI=;
	b=rcPGJqkkl3gdlIJopII+1ey0vTwe2DjcP17Sz1I91QINVIAwkZueMminWVHyY8wUQ85AbG
	91/GFqjgQ/flL0QKs8SpQFExdIfj3LaIA4Rw0dL6aWnyDQnGtgTuVKho9azuWzuTL8fQGR
	l9Ymo4odj/n8R2t6Dg+X5AFBWZbKeAesa77hU1USxor2h1nc6zszEsZBRaCeGp/+F5LZkQ
	0VYmlIQBZK/iNDta7wx65g7phxh2OlqkKq0w5Ie0n12pVcW1TV9kt2RQ58Ud40hrDwQCBK
	+asNVjmwJ87TGs+SeRhYX+0vvi+D+5/zqIcPvUTltYt+M1M2WOoRRPUdtqSKvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771312793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+nEmqG34AHLoCUk7+SmL8r7gVNhaExyqHx2t8wbuKI=;
	b=SJikSH17WRUPqZAZsUv1mCC/DrwTL3IoanVxhn4T1EsMMwmD7dlZ5deZvGAR09v8REOGxJ
	tpCfIeJp9/8AsRAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
Message-ID: <20260217071952.WCXLGs5-@linutronix.de>
References: <20260216134333.412332-1-spasswolf@web.de>
 <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
 <20260216153745.CA3__zRc@linutronix.de>
 <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>

On 2026-02-17 00:48:25 [+0100], Bert Karwatzki wrote:
> The problem seems to be that different preemtible threads try to send skbs. 

This does not matter because the counter is per-thread not per-CPU. 

> 2026-02-17T00:29:24.212231+01:00 [ T1513] Dead loop on virtual device wlp4s0, fix it urgently!

Could you please do a backtrace here, for instance via WARN_ON_ONCE()

> Bert Karwatzki

Sebastian
