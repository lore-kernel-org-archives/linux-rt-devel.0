Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658435A924
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837367; cv=none; b=YbFFr3JUsNcRpPA8NlCOtJ+GvANE623ZfiV4SlFck5T420hK9u/VFjm9U9JbaML1jEcxLuRYRKAb6iwMcnd+Y6I2c0QLzZqpGXB7493+/jL1ZNk3oXgoOSnhxLarUHjhsoQaKGX2n7FP9CDQOFDjjs9Q5m2VYILAQRb+kO/ZLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837367; c=relaxed/simple;
	bh=JcfFYNhi7LcRIrtBraNNg0VePjlTY8To76yruIzAZ9Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZucdLTwvJk4cbvQjOG+dkikirGlSjAVdKT3tsVzkqkfaHtVdMQERBMa8IrJ3jL/pT3Hk0BWRiCtp0YfSAbmVXDNlICJnKMICVoicqeHXpi94D45dv4Nmt5QAGdYT9A3qwQutrMGDOprtk5XuNsp+vOlAKGygfhh8XMchNLlE7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lIkAruG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QCnlcO60; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lIkAruG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QCnlcO60"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9631E1D00132;
	Thu, 30 Oct 2025 11:16:03 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 11:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761837363;
	 x=1761923763; bh=PB77BhgDPVqLXInC5oE3SrEz8gPtJUc/9tkX6JDWI3c=; b=
	lIkAruG7GNX3boS4q1978C5us8tEEkiLIB1C/TGac+iOp5kuJI6j+eqFyJYz+lXk
	3mtF76x7jjeKXtoRouqUJaun1Rvmi2wOy4vp4Qx7IcgeLKU7+RUSFMdf+dVNkvDw
	7pMHbtl1HO6FM8VgtYtfFXvfJanKvsYpEOZK53C0XmTfyH4E229gBZqUZ1E8CEuJ
	M8eycMfbjKJ2r7BDJpZZ1Y5ugrgTVi8X3lcv2H6SaGhI60MrCHIUt44HWxigHi4J
	fJYwQ8CEmj+Pt/9enqAgSbQq1o9UTc9DMUSQncdMrRPgl7UrKd71y3EVVU7CWOLQ
	LzXa/UOcXYcb0XKE3GxXcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761837363; x=
	1761923763; bh=PB77BhgDPVqLXInC5oE3SrEz8gPtJUc/9tkX6JDWI3c=; b=Q
	CnlcO60Z2jfUgktsFJ6r+qan0HxY4cOH20ZqnyzXc7kNsgWpqU2qJMnhxrNggBVm
	9YnJHj0S0utsBi/R4V7Zi1O43J7SufWim7kj7hd1YsZPWvEdPh8hq3OQ+t83QyFz
	aHMN/xkbGvxEYHd1P+7tZvkRwePGQPwxPIusuZfuySJNs5y2ELnJZiWGNB9HtIrR
	GBEeOvXpwGhaRyyU20iC7mc+qpKCJ//rBadEJn+U7/GAf481cRCY2N4f4Iyr4rLq
	1oroNx4qxgIUAaQJLuX1uLsc/Dukiy4zvYHK5F3b4kiOUNu8GZrMa6pOO7WKZPc7
	N2MCvlQbgy/SHhB0YpySw==
X-ME-Sender: <xms:MoEDaaesw3fL0imeZTjWzBYoXX3UXP_hT6RqsdFw2tjwBun5TRDEZA>
    <xme:MoEDafBg8aIiMq_HWtIzdtvdkETvoExPUP7eD8IgZkN5e9yDmdDkH0BUMdA61l5Dz
    GJW5nydY4_G5oyKmE48clRl4wGCIeD3BktW9fBPEELd-lnzPrk_Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigsegrrh
    hmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepgihivgihuhgrnhgsihhnudeshhhu
    rgifvghirdgtohhmpdhrtghpthhtohepsghighgvrghshieslhhinhhuthhrohhnihigrd
    guvgdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhrthdquggvvhgvlheslh
    hishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:MoEDaQyegoz89-uSebOVebeBHSh1jGV57kzTJFGYE9ZLQL5Z82H61w>
    <xmx:MoEDaX9UHUA-8qB2AOkJvEGXcM4T6BxF1lGfGK-BniaR5P3mXZOpsA>
    <xmx:MoEDacJuPvYxHJNcgjK4asRzeon9wm0D9u_tPIilDD_e6lZNluSedw>
    <xmx:MoEDaVfk3Cris_NQTGKOCevlBnm4405jeaia25F8BnMzzkcAROkU4g>
    <xmx:M4EDaXXih8gARFVQ63x3KWfJGwkjjLRB8d5e5OizjRw6cJZo-bAyZGAA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D9E8700063; Thu, 30 Oct 2025 11:16:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: ADO3ruLUhBC7
Date: Thu, 30 Oct 2025 16:15:42 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Xie Yuanbin" <xieyuanbin1@huawei.com>
Message-Id: <324652fe-b5b8-45a6-9c57-096813e9092c@app.fastmail.com>
In-Reply-To: <20251029155918.503060-4-bigeasy@linutronix.de>
References: <20251029155918.503060-1-bigeasy@linutronix.de>
 <20251029155918.503060-4-bigeasy@linutronix.de>
Subject: Re: [PATCH 3/5] ARM: Disable FAST_GUP on PREEMPT_RT if HIGHPTE is also
 enabled.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 29, 2025, at 16:59, Sebastian Andrzej Siewior wrote:
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -105,7 +105,7 @@ config ARM
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
>  	select HAVE_EXIT_THREAD
> -	select HAVE_GUP_FAST if ARM_LPAE
> +	select HAVE_GUP_FAST if ARM_LPAE && !(PREEMPT_RT && HIGHPTE)
>  	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_GRAPH_FREGS

I would still prefer the version I posted previous at

https://lore.kernel.org/all/20241210160556.2341497-3-arnd@kernel.org/

disabling HIGHPTE when PREEMPT_RT is enabled.

     Arnd
