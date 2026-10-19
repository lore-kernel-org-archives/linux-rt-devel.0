Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431650;
	b=L3RG/s9hDwZ7OYwCGNmEiEpWXuiPgV9lFYuwHnm56IIELHUarLn+WsajlAkWSFQgzrKu
	 N1wlt5YFjUplnF/ExBDND9C08Phxp7iOpD1BGTamvjsQriypb7pcWYWHvGFRlQ7qWfiZd
	 eX66W9BhTahiR5pGfK227cStWF8QZzpa24ObyFp8jGRUXKEA3492SB3kjIHc27+DbGdAd
	 qae+JDCT7z3Y89VHF0jdStS7nm6kP9jPCJ2yzslsLNSZKLp2Uix/3elw7rfgEBZZWkCm8
	 L2H3UKVkth1kiB3tq1cLpLfs46XqsGaMm9sTbg0qIeIPDadif5LfZoKc55KY1PTTXzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431650;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fGwMgISYpdxpEJEgn7RaNQa2CvlfTo+sUsj3D3A+Feo=;
	b=U5v0vupx4IBT5o+fk3Ev9u9u02bnRknV5hc7rpy29Tj8rpoa01W7a1wGTpDutsdq6xLz
	 QmNHmpJO95KtuY6XVD2JbTBwCu65tyUt5bE82e3KHBuyKZolXfwuW5PlSX82U9waKJ64L
	 LMDRWMJbCov8vCLDqXj08TAtQNtuJwBKs+s1rFX1+Vc2lVJGfNyPKdPWJrgy44gJcdtj7
	 UjHqJtE6Ao0qJZRh0cCcFUd221ctbpTlNivWZBKRqpdYoP2s4HYYr/Agp55xxqcRY4evy
	 2ICl3u4LcY2WSl59JrVTOTyFXq/KauzVxNwnxKRI9OwS1IytGhtaLZDWO2+bo8Og6Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5acmoDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1506606A31F
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5acmoDP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5818A1F000C4;
	Mon, 19 Oct 2026 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431649;
	bh=fGwMgISYpdxpEJEgn7RaNQa2CvlfTo+sUsj3D3A+Feo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D5acmoDPrm7eViP6lEF9r+wHZGmqMH+5U/H7DSyZK5Xtbt/wG+nGY0IfUteIqjVEI
	 cyKNXdZn954ismEo4MkwJHIzsaU74rLsxYnWMDVF9HERf0I4NPjuqLhw75AIbsGP9J
	 IB6zFLMaIpp9uoCb1U1U6QUGTu/E69u0Uy+P8DNLtsZY2pJj81TE2izMEY9NyRRP0q
	 VN68wpxB7CrpyMSz4GcJZpUVujg+/N0fXh/+SUEXUmIIPMGWjAYqs3DsaUhudp1G8D
	 Q95dHqW09hmZacxDBtPCdrokKNQgXFGaY5x+FZKTPkU+dLPIhgu6T/azx2F9OhAvSt
	 Oy0uHM/SaKEfw==
Date: Mon, 19 Oct 2026 12:40:48 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 6.6-rt 0/5] net: Backport backlog-NAPI threads to resolve
 PREEMPT_RT softirq warning in SMP flush
Message-ID: <atZWIBciePyeMnWa@demetrius>
References: <cover.1792345413.git.wen.yang@linux.dev>
 <atYZLK0gmG8vRHxG@demetrius>
 <b957b12e-f272-4dbf-a308-c6b61bcb3d66@linux.dev>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b957b12e-f272-4dbf-a308-c6b61bcb3d66@linux.dev>

On Tue, Oct 20, 2026 at 01:18:06AM +0800, Wen Yang wrote:
> 
> 
> Hi,
> 
> Thanks for pushing the rc, and for giving it time to soak before release.
> On your question about the v6.1 series - you're right, it is larger:
> 15 patches. That is mostly because 6.1.y does not carry the ten NAPI/RPS/
> defer_list prerequisites from v6.4-v6.9 that v6.6 already has, so they have
> to come along:
>     10  prerequisite NAPI/RPS/defer_list patches
>      4  the backlog-NAPI changes (the same set as the v6.6 series)
>      1  revert of the RT defer_work workaround
> 
> Only one of the 14 upstream patches needed a change beyond context: patch 06
> keeps raise_softirq_irqoff() instead of __raise_softirq_irqoff(), since
> 6.1-rt already carries 533824e6a0fb and the 2023 upstream text predates it.
> The other 13 are line-for-line identical, and patch 13's five hand-placed
> hunks are context only.
> 
> The code is unchanged since I posted it, so there is nothing new to send;
> please feel free to apply and test the series as posted.
> 
> https://lore.kernel.org/all/cover.1791912669.git.wen.yang@linux.dev/
> 
> 
> Thanks,
> Wen
> 

Meh, 15 patches doesn't suck. I'll try and get to that tonight or
tomorrow and see if we can have both v6.6-rt-next and v6.1-rt-next
soaking. 

Clark
-- 
The United States Coast Guard
Ruining Natural Selection since 1790
