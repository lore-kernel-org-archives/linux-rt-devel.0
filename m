Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171A270557
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Dec 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691516; cv=none; b=QdGc+Ze893ksN9N5uKNfYNN8z09+RwIbF8o1KUItMnxLRDInCtv/3WGiUWgEYFzFrxpUHH+wXi01FZHqThWQoyFzxEwbjSNIgyth7h4PoV3Q0XHNeLpjp8utnqVjWMf1ziulAUQiHdH9r+yH/59G6A2jyLzvPgG6rn5FUpVEQD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691516; c=relaxed/simple;
	bh=cRXXbvbUzNNV6AW6nEqKnAboSpoT8gwAJQ6ScyPZtcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlb9ZcTZxcA0xBKadTYb9Txt9byMs+RMh2Fy2m5a97Kx7xDlYdtb9CTkaxOiWjyizgYVNIXYUxDXod8NTPOJzQk1yvdNZm08HomABIn3rzbnLtlbWuLCoMLYSz0SLlxyfY1KJQG4RDTxPiJPwoC28kkNQytiHELEsxatgn6T3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=osUsKHIt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0HZTzH+1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="osUsKHIt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0HZTzH+1"
Date: Tue, 2 Dec 2025 17:05:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764691512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vgz9yq/L+yG5wR+0sBWMMC8Af7WF7LKgi9Ddt3OC+Ws=;
	b=osUsKHItN3B+FdLAGJouZCnRBe1omUSHY5b2VU+xMMcwuK52Xk+6+Fyp1n1gwox5SmDgqF
	35HpFhzr30nY7M2RjpqCmCOLTueTTYpBhR6ieue16K168k1pu5Zb92QXL7LpBe8TUeigGc
	nPnzUWWess8YBMbOXRqQWD43vp2lQ+oZRL6aKd7L3lKQeEnVP9+YY2Gntnga0tqAR8Zj8g
	6EXrxGBL1GgDIJXCFogzGfkKlU1FHUhG2qdRDrOMzvrJT3Jt+49ibBOrPvEjiDTD+k4DF6
	NuZtnAmsXARWFBUUELICjXJ2wkNFW3XboC9m9KqM2ctyF1xAB0eHdDxxILNrNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764691512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vgz9yq/L+yG5wR+0sBWMMC8Af7WF7LKgi9Ddt3OC+Ws=;
	b=0HZTzH+1RKr9vOW7Gj0+XJWoUwekYi5hx9kHzAQPUQLwWPpZA1xBr30MUxRU0j+lGkTjXU
	8YMV6hXkln+9mQBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Xie Yuanbin <xieyuanbin1@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>
Subject: Re: [PATCH v3 2/5] ARM: mm: fault: Enable interrupts before invoking
 __do_user_fault()
Message-ID: <20251202160510.eUVnCuRx@linutronix.de>
References: <20251110145555.2555055-1-bigeasy@linutronix.de>
 <20251110145555.2555055-3-bigeasy@linutronix.de>
 <20251202141816.wfHNUMFK@linutronix.de>
 <aS8J0WrmmH01L3K1@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aS8J0WrmmH01L3K1@shell.armlinux.org.uk>

On 2025-12-02 15:46:25 [+0000], Russell King (Oracle) wrote:
> If I apply 9460/1 without 9462/1 first, then it makes the problems
> with the branch predictor hardening worse. I'm not prepared to do that.
> 
> However, 9462/1 is tied up in the discussions that are ongoing, and I'm
> not going to short-circuit the still-ongoing discussions that touch
> this area by applying this patch - which would screw up everyone's
> proposals to fix the various many problems that are being discovered in
> the 32-bit ARM fault handling.
> 
> This means I can't apply 9462/1 nor 9460/1.
> 
> Since 9463/1 likely requires these, I can't apply that one either.
> 
> Sorry.

Understood. So you just want to get the other bug fixed first and then
we get back to this if it still remains open.
Please let me know if you need some testing or applied the fix and want
me to rebase these changes on top.

Sebastian
