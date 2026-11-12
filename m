Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498799;
	b=x85uaWkUcCXoC8eZL9bIl1ucwUdAv0L7Jtg17tHF3L1K9i/rwh4Bqao7LIzJb2F8pxHM
	 qUGN/PLlUdepY7CHWP88bPdTeTghb/Zvo8wCz2rFxeKoXHzoCqEYTpuxTC2/RSq6vH+KI
	 zmVi6BUp9G7rUNZ1oDpIDHH5/DAQSi911kBh7MC1LaOBu+XZ0qztA7w3a+Hwt12nAZXbH
	 3Mw3Lz6OOX/zLA3lmDvZj8GJxQ1ZNE5xBcAkfpupY0wkDHl/V5pr037r2pbnKSpIWyeuU
	 tpbfpN2u6i3/YTinZ4yElNgxJ4NwqsmLEaOsUqGFvPDbb8GUYMKAb3mkl4hqDlZg4kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498799;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=UFtl5GLe9nZn9BitOJaL1QWLScfaFrXmqzl4iAP7tmo=;
	b=eAWyn7LikTrJZsApMuiPLOQtBtTcrWiQ+Qbe5/H02eqwjV89FRBbt3Skyl9mk2RTRUdq
	 mlxrWT3yZ37GP/bDOKx5jorzJioKste6qANKDI5OXZT/v5fUSBS4Ia37l5rlutLLrsoLv
	 hOnpCLe6xdA1qhIOAtuE9jO88xAoADZZlLMecDwciq9beXW1T02zQeTy1HPp17tcRgYFY
	 g+PrdSThb/u+ideuzqxYnxJDbCscF93lLQGhh6erUDmuN8YWfB19zoFu2AsqFz01XjfUp
	 aPWORyEAggzE3f4hRVWearkCCgqI78ueYm9BNyqNTGMjsK3AH8T7LJb23u88OMWzKPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wixbtCzT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="EPiN0gr/";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29818606A338;
	Thu, 12 Nov 2026 15:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29818606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wixbtCzT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=EPiN0gr/
Date: Thu, 12 Nov 2026 16:53:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794498797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFtl5GLe9nZn9BitOJaL1QWLScfaFrXmqzl4iAP7tmo=;
	b=wixbtCzT/zD161L+fADU+VHbeRMZthwXbLkiVMNah81RqVCw2wzAKwfpzzus6M/7kO0RAp
	/tWy9x4NrY0pRp4v+UxF9R4CZcEJ1OXdOgYYMNZc8RdkS5XFzNFYU6XWBtq0VhbMtKwvT6
	ah0TtMHGjxhjhNzAzrvkAIcG8El7w5eo0q04tdbA15qtVahuX6mKZEm1hVT+aeSmb9oK5q
	0TNrNfMn3ai8m8LFrGgn8++TQ2Q+RTL79AZXBy95trZjGvpTWrJJ6d79JttJTyJr4MOUBs
	DfIJK2huLxIdJstif3P3/DMh7W7QhRUuj+WfkyycYWN1+YIQuM0NcZlyrA4gsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794498797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFtl5GLe9nZn9BitOJaL1QWLScfaFrXmqzl4iAP7tmo=;
	b=EPiN0gr/Zgzia99J1JDPUJoaPrfPvrXsBek11pT6qFUTeLfD1Cv8Kef56XEAkhQ/Hhmgr1
	nt+9Cz4rCi37O7Cw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-rt-devel@lists.linux.dev, debian-kernel@lists.debian.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/10] kconfig: Introduce checkconfig target
Message-ID: <avXg6yuLW0GwFiYr@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-5-darwi@linutronix.de>
 <sashiko-outbox-202759@kernel.org>
 <avIn71Md3LtNaYje@lx-t490>
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
In-Reply-To: <avIn71Md3LtNaYje@lx-t490>

On Mon, 09 Nov 2026, Ahmed S. Darwish wrote:
>
> On Sat, 07 Nov 2026, sashiko-bot@kernel.org wrote:
>
> >
> > In addition, grep -qw treats $(RULES) as a regular expression with word
> > boundaries against the comma-separated output of list-rules rather than
> > matching an exact profile name.
> >
>
> That's good catch; will fix.
>

I've just verified that 'grep -w' considers ',' as a valid word separator:

    $ echo 'word1,preempt_rt,word2' | grep -qw preempt_rt
    $ echo $?
    0

So, Sashiko, this is also a non-issue.

Thanks,
Ahmed
