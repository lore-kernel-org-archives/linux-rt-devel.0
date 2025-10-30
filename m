Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47629351FDC
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822667; cv=none; b=L7MBgG47bYAT7OzgRjd3EgO/ddBV9DJW7NaovzCCXDDag4npTnzuJU7/WJQVIxUFUIR2stOdXYDcbJOD5IgwT09gkKJdgayViPDSFQ44A73RouEjLRE+akPb6EMRxQomew0u2vcGkx31KK312yGAWFSZnt3MdgWgZVER/9bZF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822667; c=relaxed/simple;
	bh=06ekNiQ8Bfa7Q69B/aZrGqOGffxlLTDRo/1z35y5/Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWmlBwvLeMDnE7MmdVuWyA02YlOMc0zJd+Nz9BKn1tXMoHTyN8n0Wq1Hpnsw8vMUVfByRLc0odzEg4+xV0OSz67cwFjOTEZQG0z9sHrC4zNb/Ot0ppzJ0U9Ux1WZn20bOIoPQvc5ZorZLuNR564cbh/dwTHw0B1YuImUMTPijVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U9X+QRUb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X+vK3xic; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U9X+QRUb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+vK3xic"
Date: Thu, 30 Oct 2025 12:10:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761822660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ntgtEMvcQj5lBXisx5rT6ZbhVQHfnuBooqnky1xiy0=;
	b=U9X+QRUb/N748dXlwxULspa4EVDIWt3d3RMdB1xNf5ecq86ft4ExuSZjUNemFEMRa1NxFR
	/B89iY7SWf9rBmtCaW3HXTT3vhX5BDtkScthNs7FUj67AdKq7fhHBFNBCSar/WNbRZbQ/y
	4vQZjtn4e2xgsAX9/B11gZlE92eBUWNTt1vLuKgTQzvewdnjT0dCQFk9pBTIUjYm0ZBfKS
	MJX9cqyFvU3cEl5gj80tsaCg4d1bV5GhgP8ttKvufIxXfbx2Sn8eLLsgK4t5OtOl569zFc
	3LzRMWt7gixAkNeEIJy4IIbU3cY2+91vJTx0ObPPQj0lb5tJDe3iPMRpoB/+BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761822660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ntgtEMvcQj5lBXisx5rT6ZbhVQHfnuBooqnky1xiy0=;
	b=X+vK3xicSBKAOBaV1PaN8ZoRGMqKsd9zdg3We+XXvPY2Fh0yiWQ4c/tnBxezIj2cOvTmO/
	I0b9hhdlj2SZQyDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev, tglx@linutronix.de
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Message-ID: <20251030111058.TNDQmuHk@linutronix.de>
References: <20251030072339.63vdFNo3@linutronix.de>
 <20251030074507.33863-1-xieyuanbin1@huawei.com>
 <20251030075558.sUBj8_6U@linutronix.de>
 <aQNAEtIoU9sEx3LF@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQNAEtIoU9sEx3LF@shell.armlinux.org.uk>

On 2025-10-30 10:38:10 [+0000], Russell King (Oracle) wrote:
> On Thu, Oct 30, 2025 at 08:55:58AM +0100, Sebastian Andrzej Siewior wrote:
> > Arm64 and X86 replaced the stop_machine() logic with something else that
> > does not affect latency in that magnitude. If Arm could something
> > similar then fine but until then I don't see a way around it.
> 
> "If Arm could". For 32-bit, Arm Ltd isn't going to do anything, it's
> old as far as they're concerned. It's up to those participating in the
> kernel community to maintain and look after the code.
> 
> Thus, if there is a desire for something other than stop_machine() then
> it is up to those who care about the issue to do something about it,
> rather than expecting someone else to do something for them.

I fully understand. I've been told by several people to repost my ARM-RT
patches because they ("as in "the SoCs") appear to be of interest in
years to come. As individual vendor promise to deliver their SoCs for
10y+. It also claimed that new products appear with these SoCs. Now that
we have RT support in upstream kernel, ARM is one of the missing
architectures that was supported out of tree.

Having jump-labels disabled is what we had in the ARM-RT queue since
jump-labels were introduced. From around v4.0.8-rt6 it was considered
safe and enabled for x86, powerpc and arm64. From that point of view I
don't see a regression for the users.
And as you said, if there are ARM users who care and have an idea how to
optimize stop_machine() away they are welcome to post patches.

Sebastian
