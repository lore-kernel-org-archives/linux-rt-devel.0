Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776361DA2F1
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932552; cv=none; b=Mbf0yoo0sEe1/t+kn0Q7A3+z60t1RRBg4FVXC7Lg7Ut8XvhHBe6PuI020DiiqRTCeimR3s9QetNp35/Gan/H723H2DwLvInt8Wtm8pkH00ko0j/iqecG+tM6P4PHRQi7sGXztHKacJfgIXBIzRuM34TcO10ylMG6sAK3Cf6h0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932552; c=relaxed/simple;
	bh=2bk3rd6Unupi94gDlp38KUWBsvkJXx2o6I8uEdDqUIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLCFLKdnywhK6p7b/+vFwTenlW7iT1dBiXgYXmcVl8hs1pOyeHphvt1NEdRj7QR1DarUhMhJhfMlyawN9gGagqaNMWMbfqWhECqzSWvU7qFpJqaMvp8bg+nK2PY3Qt+Z6VcgXWfEBSvOXDQDkJpjgTWyRqaM/5PZUDlClq7LFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ulUOh6HO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ulUOh6HO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nNWhv5561LH+95ZybovZ5QdJpH0cPUFUZxKRgUtXR3E=; b=ulUOh6HOqEKJ/+/0ZTK/7V4JHs
	IYfIm3L3Fkn9lb8DFP5UyS6eX3eSLbEgzX29gw5Me/d9xkMQ//Hn+bJbR3pT4jN4rErOXi4eKbQGp
	+OL+TBvpdG0l8l54bTeNZTfTEWl3xU5wsNCqV5TyfESZ5fsf+soeB60fmIsNqlJ4tbD1/59jcMOnH
	SBoNQaErwL41M+p5wwp9jRoe3pWupX74UV5NihoTveX9a8DSi484J4WXGHkXi9QEvGeMz9AT0w79t
	FFAyGZ3nPdkV4s5LaWpBgIO4/oM9EO+F2DWiUnOMCtOt5as48fE1m8hqzLQxacQ758xMBbNzsjrcd
	L3MGkrlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47116)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tLP3o-000493-1m;
	Wed, 11 Dec 2024 15:55:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tLP3j-0004Rn-1O;
	Wed, 11 Dec 2024 15:55:31 +0000
Date: Wed, 11 Dec 2024 15:55:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/4] ARM: Disable HIGHPTE on PREEMPT_RT kernels
Message-ID: <Z1m18yn67dsJRVWA@shell.armlinux.org.uk>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-3-arnd@kernel.org>
 <20241211134811.wM_UADhQ@linutronix.de>
 <20241211140402.yf7gMExr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211140402.yf7gMExr@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 11, 2024 at 03:04:02PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-12-11 14:48:11 [+0100], To Arnd Bergmann wrote:
> > I guess if you have boxes with 4GiB+ and can proof that the performance
> > improves without HIGHPTE (since you don't have to map the page table).
> > The question is then how much of low mem has to be used instead and when
> > does it start to hurt.
> 
> Some numbers have been been documented in commit
>    14315592009c1 ("x86, mm: Allow highmem user page tables to be disabled at boot time")
> 
> and I would like cite:
> | We could probably handwave up an argument for a threshold at 16G of total
> | RAM.
> 
> which means HIGHPTE would make sense with >= 16GiB of memory.

However, there is more to consider.

32-bit Arm works out at the same for this:

    Assuming 768M of lowmem we have 196608 potential lowmem PTE
    pages. Each page can map 2M of RAM in a PAE-enabled configuration,
    meaning a maximum of 384G of RAM could potentially be mapped using
    lowmem PTEs.

because, presumably, x86 uses 8 bytes per PTE entry, whereas on Arm we
still use 4 bytes, but because we keep two copies of a PTE (one for
hardware, the other for the kernel) it works out that we're the same
there - one PTE page can also map 2M of RAM.

However, what is quite different is the L1 page tables. On x86,
everything is nice and easy, and each page table is one 4k page.
On 32-bit Arm, this is not the case - we need to grab a 16k page for
the L1, and the more immovable allocations we have in lowmem, the
harder it will be to satisfy this. Failing to grab a 16k page
leads to fork() failing and an unusable system.

So, we want to keep as many immovable allocations out of lowmem as
possible - which is an additional constraint x86 doesn't have, and
shouldn't be overlooked without ensuring that the probability of it
happening remains acceptably low.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
