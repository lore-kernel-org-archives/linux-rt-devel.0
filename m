Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844426;
	b=tG9WSKw1d5x7dUz25P/QMRizZDjjOUEYO4qlGg8KMWUKHFh3Eqs3kZpCQpSGNrbRUpGc
	 QGWXW4bLhkxSZY0lUlgiua1A2w/r7JzWWABnglarUUWJsJjByE/WyG63t0p8YOgnWMPeM
	 +j3iJt/bfzTEdewEIyC3ibHdJjGA7xWo4gKskGB0RCZq6TvsvWk4wZwXNbPQle81vFkQl
	 WxKY3uXNfb/hI3q4MXBChECUiV0vBCGDu3ZSodxCrI1QFzRj4vt2P+VFLBkAfaJh+9zAv
	 Xi5U+9rJq9C5sNQNJk5eRTrrMKZUm0hY1NzOArty9zyKX1Ry6GAQwWH8LFDav8EJaDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844426;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NR1WitsnrUF6Vecclfpa0MewRu5Y9KVFWrQGR5yiBx8=;
	b=q2dYOflZN6MGtFm6RC8hKeQFqpKTdNYzNwSOlTZ7u/oCwMFsRD8ojltRCGbVztHxlj/i
	 ipqEP/RiR5r4wHpwdZkq2T8bCrmaRAD1Sv9q1WqgKQKkzxzYthjB4n9cVZzjQnRY6ce7v
	 uU0J5vo44lEtbm+H4PoMxL/114D7eVGd3nV+DvnCg+XMa1Ja5O+HdmZGgzhpliur5gIv9
	 WwPBMBnnuYHfBDwsaJLYwUJaUxYHAKcBzFmDjpoR4tMJXy/8L17tXaTZwsIeUQPgBdTFN
	 5ll/59YQ45bj9YkfdHo2g1EV4eXHL15+oO++PHQbz7OR6VgyzCZS4aGXwEZ/7hmEvtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeM28q0B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0762E606A33D;
	Mon, 16 Nov 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeM28q0B
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 66E851F000CC;
	Mon, 16 Nov 2026 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844425;
	bh=NR1WitsnrUF6Vecclfpa0MewRu5Y9KVFWrQGR5yiBx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AeM28q0BaV+nA8m8Yqo92Lrc88cR8Lt6ODyS5py5XJ5bMQ7GGBeOFFdaUAzIr+u9M
	 xAOdH0rXGGaYbMxyPKgKn4Onkve7UvR8mD8o2qCFyT+baRffWrLJRUySp8XdQz14X9
	 OgVdHxZl98ZOQMR6sxjHv37nf+W8AuHYp8WZVOlJGKhrwoeWXnouUx1wDPE+mbdgdn
	 uG7oNtmgi6+BbDPaVtJvlYWBElGfWMv1Kp823cGUxrkL9TtSROssYU+zuAn9udMv6n
	 UkpEFWTjgV0PEqEBQ113Sq5GkonrV6I9/tU+whTykYDgsMDL9SU2x0uzKKnsd1K+cY
	 1BIi7lyIx5/Fg==
Date: Mon, 16 Nov 2026 16:47:56 +0100
From: Nicolas Schier <nsc@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
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
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/10] kconfig: Introduce OVERLAY= for make checkconfig
Message-ID: <avslrMXA7QkW_X8W@levanger>
Mail-Followup-To: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
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
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-11-darwi@linutronix.de>
 <avQNgXSWhODyc5Fc@derry.ads.avm.de>
 <avWmzbh3rp7TawCn@lx-t490>
 <avYwKuCrHOHV_gOw@lx-t490>
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
In-Reply-To: <avYwKuCrHOHV_gOw@lx-t490>

On Thu, Nov 12, 2026 at 10:31:22PM +0100, Ahmed S. Darwish wrote:
> Hi Nicolas,
> 
> On Thu, 12 Nov 2026, Ahmed S. Darwish wrote:
> >
> > On Wed, 11 Nov 2026, Nicolas Schier wrote:
> > >
> > > Please add the optional overlay arguments right here:
> > >
> > > 	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)" $(addprefix -o , "$(OVERLAY)")
> > >
> >
> > Sure, will do.
> >
> 
> I've just tried the suggested addprefix function:
> 
>     $ make V=1 RULES=preempt_rt checkconfig
>     ...
>     python3 -B ./tools/kconfig-check/check.py check -c ".config" -p "preempt_rt" -o ""
> 
> Notice the breakage due to -o "".
> 
> Unquoting OVERLAY will make it work:
> 
>     $(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)" $(addprefix -o , $(OVERLAY))
> 
> But it breaks the consistent pattern of quoting all passed variables.
> 
> So, can we keep it as it was originally done?
> 
> Namely:
> 
>     checkconfig_overlay = $(if $(OVERLAY),-o "$(OVERLAY)")
>     ...
> 
>     checkconfig:
> 	...
> 	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)" $(checkconfig_overlay)

well, ok.

I still do not think that a top-level make target is a good idea.  Any
important extension to checkconfig's arguments needs to be properly
mapped, and as you won't have the 'checkconfig' target in the middle of
a series of other targets, I still don't see a good reason for
implementing a top-level Makefile integration.  Thus, I still recommend
to skip the top-level Makefile integration.

-- 
Nicolas
