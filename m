Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1498239573
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837881; cv=none; b=tbbAPwPtGqYef1eQ3EFm/88/SMyXDFe94rRSBy9Kqt40RXZVtoB2Jxwh4Hk5127xSafWsohlluKsByzCqNWhNh9nKNns1mAYZgGEPJTYnmQC2f7Zv2jdcbtrPcJ3/+luRAS6uAANVCAHOz4iem0Veh9/Y3MdZPB4K4remJ2H0BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837881; c=relaxed/simple;
	bh=QCVEWdRHF5f36RWo/2UWvH8OSdH3rD8asnUiYgvuS9M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=up9YHT6Mz9wTmZv0kQ+bQRwxxj3MoDP7gEbxPoNLBml+x4Omh4yzbWpDXzq3g+Q4iVva8lSQJs0ZCS9WyNBB8vB7z6Knr6IOdIjNyVm1MneSKELXbmiqepeoAU2mznZ0aFZGgrojqv5v5AkZyqkftkQpmXSFXB6yH4zFCfpdX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=T0oDgNTH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZLm+pBj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="T0oDgNTH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZLm+pBj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B0987A0196;
	Thu, 30 Oct 2025 11:24:38 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 11:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761837878;
	 x=1761924278; bh=HutlRlAmarm4unWdhm/gDtaCXWn1GhN3+MlaZtBoyWI=; b=
	T0oDgNTHOlDgQ6flqHJZjNNqtS1yb/zCmZaj8SlMcaK3xFSwLKkPjjNyojVygb4o
	LQeuOlQXEmF834OhKiwvWWmYDKeveY7N9qwh+fhK7DSFMMEIt4JXR4UyBU0Qh7g6
	Ym95NkeUNoUUErm0fN8E48jhbDXadBXmpzqm+456izpFMl9xODYQfdOaN7lixqjO
	oAfx8SoEjgQW1z284GsYNqJ7EiUtOveY/c4e8+fWRoC7dzKG6J23A91JM4YLYD8Y
	Y+mJGk6vM8zJ2vyJQVWYHKfGmJN9t30ttK4bYpGb8inKklEQeNuvR5RZkApv2aVa
	S3phK+YfK3Aa/KohAGzvjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761837878; x=
	1761924278; bh=HutlRlAmarm4unWdhm/gDtaCXWn1GhN3+MlaZtBoyWI=; b=m
	ZLm+pBjvWg2UY94Sbd7BAu5h/yXxiiP4pSllbjntCYB1chH0YTw1xNQYYFA/z0Ii
	HEG8un3EevpKFLUVbhku/X1AOb1oSmmxjVbOez9MB+eszDcjk1/gM8bUIQtPSRIX
	ROOxpLgi6QpVef4okYNJP2L93w6aRUEl4Y6KtCSIci5Gi/9Hdtv5s7O6XpwA95T4
	/WoXwKhgIDSoEuin3M5ZqKmgrIpGjD6Na72CPOaSPoG6s+PjqFQYp5l5ecCkTvfd
	/JCh6Jqr5pKC0C43gXYZ1CVSawZy+Ren/tWJt4ucQxpGHZKm+rjGO4M0ypHA2BK3
	+1qTyWsAqmWkMCHG5GJYQ==
X-ME-Sender: <xms:NYMDaQjioTXrVIZPTpqnL0I9YhtIIImnmGTXRf1QtFMdIFciSkqnzw>
    <xme:NYMDaT1B73GMrchXz7XWWex9zmBOfzyO9hUrjlXpynZNwKeuK3eK9r52uKo1lBCAe
    zNtB7cMCKhOz8I1lmW6PZzgYHU0_LUneTwbPxFA5NeP-NzxAC-HXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeileeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigsegrrh
    hmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepgihivgihuhgrnhgsihhnudeshhhu
    rgifvghirdgtohhmpdhrtghpthhtohepsghighgvrghshieslhhinhhuthhrohhnihigrd
    guvgdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthho
    pehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhrthdquggvvhgvlheslhhishhtshdrlhhinhhu
    gidruggvvh
X-ME-Proxy: <xmx:NYMDaRH4NUgWrAJZP5B9cZ3POHXW22RAOKe190FhYYLY89NQv755uA>
    <xmx:NYMDaYnpU6he7zMXEbxaSFzKeRHWwCepI6MrK4xQMIhg6vX0WiD4Mw>
    <xmx:NYMDaVZhGxNykfuqqkEc7CplPct1Y9g2GmijXPpsCjXobVhU7JbjMA>
    <xmx:NYMDadEjE5q2jMCC2r_v7G1i2qvaxVmaOhwZMAt1YAW3FT147kvkcQ>
    <xmx:NoMDaaNLPS1Tizk2zGq-u1wg_MXWgg0o4QrN2fnnbdwHlkyhW9PpvjHk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D65EF700054; Thu, 30 Oct 2025 11:24:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AnkmHEGtRmkZ
Date: Thu, 30 Oct 2025 16:24:16 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Xie Yuanbin" <xieyuanbin1@huawei.com>,
 "Thomas Gleixner" <tglx@linutronix.de>
Message-Id: <a86e9827-9b8b-4313-8d46-5fb2af5b8826@app.fastmail.com>
In-Reply-To: <20251029155918.503060-5-bigeasy@linutronix.de>
References: <20251029155918.503060-1-bigeasy@linutronix.de>
 <20251029155918.503060-5-bigeasy@linutronix.de>
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 29, 2025, at 16:59, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> jump-labels are used to efficiently switch between two possible code
> paths. To achieve this, stop_machine() is used to keep the CPU in a
> known state while the opcode is modified. The usage of stop_machine()
> here leads to large latency spikes which can be observed on PREEMPT_RT.
>
> Jump labels may change the target during runtime and are not restricted
> to debug or "configuration/ setup" part of a PREEMPT_RT system where
> high latencies could be defined as acceptable.
>
> Disable jump-label support on a PREEMPT_RT system.
>
> [bigeasy: Patch description.]
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 864a14a434b08..99c9b1c320af8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -80,7 +80,7 @@ config ARM
>  	select HAS_IOPORT
>  	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> -	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> +	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU 
> && !PREEMPT_RT

I posted a slightly different version last year, which optimizes
the uniprocessor version and has a little more information
in the changelog:

https://lore.kernel.org/all/20241210160556.2341497-2-arnd@kernel.org/

     Arnd
