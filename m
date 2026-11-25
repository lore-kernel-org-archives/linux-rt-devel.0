Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603488;
	b=EXqd4FNXDd1R+tCbcYRfGlc3zT+nYk1Yvv+U2V7KDY6Zpg2N7mbWdaZ/YRXLOwsABc01
	 YtvHNL9LAFk1wSCdbfKsFAxh2mCj89K6KnVZbq3wQb/0DmTzGJGxRfBQGatGbOGn2WvAh
	 bTmBOTTTz6iZggSCyQfb2zysd6sVIBpyYNtSuHA4jconYgFLQxf+oNpW6NUieSCplkvJz
	 KfmCYCTChAJDY5+g3IQkXEIU7vn2MZA+YcBh6iK1GEwwplTpfTbFHSN646K+YyTywBQN+
	 njWEtHOrlsmEEhmYa+iQ1zT5FSH+YI0YiUGGnSU+P/FvkrwllXabklFOU8hIOEnS9ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603488;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=CMyK6mMobUrcy0EM1NOvK36Vw9GZCvCYDQpUoqbxDoY=;
	b=cFGPlgaJAY4kAD6vAhPgF3OcLouiwxjJ/KwIC3l1Q2ynPsP16ICfMOn4bpGGRSg/9vp+
	 eoAWJaefOcSBsZHJd2sGCV780g05upET40ZZ0WbNBZ1dtTIuXfg2pgog0oZytJfvKWJiW
	 eb5SxcxpBYj4wfw293KCoPk87vlNvwjkAPd34AmI80nIJlf/jILYd95eOn87Ym049qNwr
	 YkkCYeT6VVysiouKQ6nG2oCBj/tIfsio9ccvdtg28IjraE3jfCBTA3GU1aOi2QvtXqiQ0
	 9qcV92+pIGvu4Z7LuqUWB/JYULKgnDv3Y1u/SIFnbQYh7ph6XpEQr3ihcoFLMMn7KOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ODecRjVN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ljn4WTxk;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4949606A323
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 10:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4949606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ODecRjVN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ljn4WTxk
Date: Wed, 25 Nov 2026 11:44:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795603484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMyK6mMobUrcy0EM1NOvK36Vw9GZCvCYDQpUoqbxDoY=;
	b=ODecRjVNdI7BuGrM0sYA4qblRE3XKZlm+eV5380OTLybeDGlpWtV7aCPxK7Qm87gYwPD/B
	S7OPRgWxE9BBMewGcbkGj+FcbR824dQOzsCiuTXaS2EklxC8+o+V8tQIk8rG9VqKCNWcK5
	RajfIXx9arE0vcNx236Q6IwaiLG11ZPQPtQDgxhAGigyQBpchRnlh4bceHdvlbS7g6crHD
	rS1Pqa8ii9S7GU/jU2hJmuxa5GLSgZRjYPZ3yBxeiPu2yIP1E98QcF5EYkPSmGxwXZD4D0
	6fgJUguiB4WBxcrhCj5heXpABYa7i/gD3m5aPaFH/ErMtjpLGrMOUW8HMikkhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795603484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMyK6mMobUrcy0EM1NOvK36Vw9GZCvCYDQpUoqbxDoY=;
	b=ljn4WTxk2IVa51CmiQbV6bDPcpU5jnkhvsmfmn/M1cxv63RHcKQtiCWhXNcfTpq3qUSSEq
	IpWOavTryMXMbyCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Zixin Wang <w1355457260@gmail.com>, frederic@kernel.org
Cc: linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	darwi@linutronix.de, john.ogness@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org, corbet@lwn.net,
	wagi@monom.org, atomlin@atomlin.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Documentation: real-time: Add runtime tuning guide
Message-ID: <20261125104443.X1l7Oy7s@linutronix.de>
References: <20261125074658.33117-1-w1355457260@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125074658.33117-1-w1355457260@gmail.com>

On 2026-11-25 07:46:58 [+0000], Zixin Wang wrote:
> Runtime tuning options such as C-state limits, EFI runtime services,
> CPU isolation, RCU callback offloading, and interrupt affinity are not
> kernel configuration options.  Move them out of the configuration guide
> into a separate real-time runtime tuning guide, so the configuration
> guide stays focused on Kconfig options.
> 
> Keep the existing configuration section anchors in place and link to the
> new guide from the relevant configuration options.  This preserves the
> documentation links generated by kconfig-checker.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220633
> Link: https://github.com/elisa-tech/wg-aerospace/issues/222
> Signed-off-by: Zixin Wang <w1355457260@gmail.com>

This looks good. We don't have too many copies of the content anymore.
Any objections from anyone?

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
