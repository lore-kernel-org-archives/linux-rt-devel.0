Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4B3DA7CD
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Jun 2026 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500618; cv=none; b=n5B6Ya0L60bpRbPbXMnQPFoFeboSbobUCS4S4xEP6NVaaS314w89VGR4WLyqDqaR1TA/fZvxSsgJKcutx2SKRBxU5+l5ucrMw+F6BRiM9ECvdoztdPqzYUX5/aUcm1PCzGsR1Rm9BeX5Oh3SAHs1Y/1RF/29hYN89Lrta5rPADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500618; c=relaxed/simple;
	bh=zOv8PjaX40/375pKg9kgdDIzCtKtcjcycNLsga7J4Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWfJg4yoWbturb3EczuliyvTOGDFTZAm2FNgG6PgpcIkh0hv8ZpQGLOMYhlY6Xm8me+UbcxQvAues3t+Pv1+icptET2uhB85MQYs5YfO/JO7PPkHm1cJV9f3m2M4psR693/4jRWx2QXA7gCxQxOLBY8qhFDVYGnIma8mlAFRinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MsEI8/P+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2JWpsPH3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MsEI8/P+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2JWpsPH3"
Date: Wed, 3 Jun 2026 17:30:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780500612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B134OFE8/STCpqpWQ/ddg2uwK5Bkx4sXfIx+4cZNxx4=;
	b=MsEI8/P+ZVEo/Vs5D7VOTFuBXlq4clHt1Uj/9ZPzQ0cilhE1P3Mh8htfrHlDAYLYWzFV2t
	FzYlnvyFJkuaiC5wkLFS2lIw6h6L7fEwLY3GGwnyem1ts+dU3MhvkitS6VxrDY7jsiwwEu
	kX/OA5j8sToh7xv2/u6TKsVMPMV9SYADJ1vwoh9DWNUlvKn/EE4TbY0Tp+PbSUz2tK1E5r
	2JdWXp6xjPjaQ6CFHrxNllygAKxqODMQROnKIXuMw7kPWftCtANImk3E7Sym4rp5/c6OfZ
	IrhNjFGqBcTYnaQxpljjimiOJjJH64smyoL53jb79GZP7paOM2OXGI3yM5lw/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780500612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B134OFE8/STCpqpWQ/ddg2uwK5Bkx4sXfIx+4cZNxx4=;
	b=2JWpsPH3F+7PkAYvR7Re3g2q0DBMHsUC1kKqardXuq28O8/bQNfPd9GiVkO52dCNM/rqjn
	PRiPHlwz7Yga22Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH-tip v3] debugobjects: Don't call fill_pool() in early
 boot non-task context
Message-ID: <20260603153011.vSPiwyLI@linutronix.de>
References: <20260520201509.931905-1-longman@redhat.com>
 <20260603075656.S1aZM9PO@linutronix.de>
 <b4b54ef3-5488-4577-9743-d6ce01f7405e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4b54ef3-5488-4577-9743-d6ce01f7405e@redhat.com>

On 2026-06-03 10:59:55 [-0400], Waiman Long wrote:
> I guess softirq won't be active during early boot. If in_nmi() is true, we
> are screwed for non-RT kernel as well. So only checking for in_hardirq()
> should be fine. I will adopt your suggestion and send a new version.

softirqs shouldn't be active but if they are then are either delayed to
ksoftirqd or inline as of local_bh_enable() which is fine.
And for in_nmi() we are screwed anyway yes :)

> Thanks,
> Longman
> 
Sebastian
