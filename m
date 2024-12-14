Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664ED101DE;
	Sat, 14 Dec 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734214278; cv=none; b=J7q1TCEOC/o8MG9Rg+IHAoj9sndY1yhO8YYSyysOudDlvBPi/b7NFlPlpmskZF/9Su+ebM1o0uVbjGm1LH6JQJvUd1MVJjMQ09VaIKLDrk2nw4s4ircygAvulGalFOL0LClKj8VUYI+MYtbrFsHzXix57Kcj0A4Po8UC57kdVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734214278; c=relaxed/simple;
	bh=vS/mC/PG7Z7XwpQ+xnC0D9bGPQsCkaleBv56apyy5vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO/hBhThaWBmhrteYDcVxeJDpSfuM80ivC0dlSEljkFUvit5cW7tSBFq1+pBvVbaf0Vbveoa1/YqnxMl7BFrgV5zJJYCbYQg+zeWkEy2D0FNfVHTM4YeKJr3uo9+7W12eSZk3JWrSjHTzxy/0M8T2+RKxwjJSRzF0H9OG0ZL+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FPP5zK8V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FPP5zK8V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Qo9DRUyKRrqtLyRuNXYM99TkYAh0n7GpnTKVcYgBdPE=; b=FPP5zK8ViSCb+8pbD6ArAAmyiH
	5tbsuw6oSYj65D4t5veoY7adMhxKFB+WgfTWDVJO6RSojy1lEUw9xUz8L8QRlbtz5dnQSi5XxMcdt
	6Ff8bEnof3eNQ9CAbrH+Yb0z23MJSpEmAMZe4iU6on3G7ZyYYSTWWEcP5qzywn7bC/HXl2oduQes/
	RqBpxyXKcYfPIe3zo1ZYsTnleFm0OLJfvW7SzyxVyFsRaKN4mrB7K3332MojFURnVQ4FVivEMLjjR
	OEvWiSHUz4gM4MSrYfTBe+OWUyE0rlNy/yBYHKTJYbdUJEu38qV2Sfqjgz8BdUoHPhaN36eG3EKuj
	/1Tq73AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMaLs-00000005RuX-0hl1;
	Sat, 14 Dec 2024 22:11:08 +0000
Date: Sat, 14 Dec 2024 22:11:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/4] ARM: Disable HIGHPTE on PREEMPT_RT kernels
Message-ID: <Z14Ce7cziCn5Fluq@casper.infradead.org>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-3-arnd@kernel.org>
 <CACRpkdZaoD2vqbCi1AFUa6mF2_=c3Nu4R0CvxFAep0VMgtMtOQ@mail.gmail.com>
 <20241211152257.Igx3aT2Y@linutronix.de>
 <CACRpkdbYU=Txm0zUWDWvNXA0JHRNGpy1ccy0zQdiBb2Ya+UBFA@mail.gmail.com>
 <Z1v6XcaSK97Sa9Tz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1v6XcaSK97Sa9Tz@shell.armlinux.org.uk>

On Fri, Dec 13, 2024 at 09:11:57AM +0000, Russell King (Oracle) wrote:
> On Fri, Dec 13, 2024 at 01:27:00AM +0100, Linus Walleij wrote:
> > On Wed, Dec 11, 2024 at 4:22 PM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > > On 2024-12-11 14:29:29 [+0100], Linus Walleij wrote:
> > > > So fast GUP is supposed to be lockless, and should just not
> > > > have this problem. So it can't be addressing gup_fast_pgd_range()
> > > > right?
> > > …
> > > > I'm more asking if HIGHPTE even acquires a spinlock anymore
> > > > as it is supposed to be "fast"/lockless. If it does, it is clearly violating
> > > > the "fast" promise of the fast GUP API and should not exist.
> > >
> > > This is lockless on x86. The problem is ARM's
> > > arch_kmap_local_high_get(). This is where the lock is from.
> > 
> > Aha that calls down to kmap_high_get() that that issues
> > lock_kmap_any(flags).
> > 
> > But is it really sound that the "fast" API does this? It feels
> > like a violation of the whole design of the fast stuff.
> 
> If there's no way to do it lockless, then it has to take the lock.

Well, no, it's allowed to fail.  It could trylock and fail if it can't
get the lock.
