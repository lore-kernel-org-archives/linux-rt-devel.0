Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483925;
	b=JVVuuz46YI+lp0V8Iqzk/YmVEG7m5AjtuGv9EsOWLGWbLjwXRrGzwNVrJo2kydcdtjQT
	 RWXu/LIoVZfDZFuNfLwGSaDGp2e4j2olJDEUHt223+iYLDM+4W+SDKpoDZbFEbL2QuiV1
	 N/u2UBRrCcayDYD0PURMtuJdCh8VbDc4h3U6PyLnon8YLWT7XvzT2kXgxLIEdm287DCAm
	 OOpJskOrbam8pW3TwR7eRdAgC+/o3ns/7jNfmSoyhmbe4oi9iSz9V/xI/8u89vod9HUgN
	 nCvst44LE1tfrddfQSakwwfJYQMdwM4u3EVzUVExCha7ElupJKn62eLNysfhkXDaDKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483925;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=+HOiY7t+6Ht5kHOkHA2FZLOJZLjbuqmVxYfSgV4Fl4o=;
	b=Rks8ppG1u7/Jb4wa5LxnKXBH99qZsTOZn5HWPE582qJjHUdNSibkr99JYygMiyFQTN/M
	 jPVX7EfyFtZU77dXrG6rIayGESkPa/8/Mur+Vj5FA9RQYmTcx6ZzI8p9IY6BiVRZD07QJ
	 dZhovfIA5TNf+WjWMkiKNn4a0l2KIs3KDNFhoCgfxs3C/QtnyKcsnMkANw2SeWIcKI76F
	 S3zl755NEbSsGDm9E/fWpNqf2M/OUZJN97nEWcKCiPC+2f1ogcI+krplhpewwtGup0r0a
	 Mq/0Ld8lujewiids8myGoD7/TaqSc//yolf2ELweqZH4vj3VL6kF7RJcnVFbvwaR1aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=K3xooDCT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8eJ0S19h;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD071606A321
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 11:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD071606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=K3xooDCT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8eJ0S19h
Date: Thu, 12 Nov 2026 12:45:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794483919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HOiY7t+6Ht5kHOkHA2FZLOJZLjbuqmVxYfSgV4Fl4o=;
	b=K3xooDCTtoxJZQDgV9I7H2+ev6J11md9UHLOAON+cxSf8+iv2pjdX+patbdGxUMfaMP8Vl
	ESbeTvnze4rfuVRlovHf4EuP2m+bFabuofouKCRb4p8dYBPK4LiIW79x2F2/t71avlBXcm
	BfiMlMNLaDAbrBc7AsczAvZIS95nUysvZ0nQqHUfXWQp50BrlpXruB3ndkmREoJH66y0P9
	k49NVkx7YR/WHMzRyxCMjPlL40gx4O8RkhzQPh3KlVBtpKsylgLjsX3NGZBARq/wstKR2s
	L3j3AEaoGvr/ivVD8dYgUjuMrS8z0rALgG1Bb3symr+L9uRIGGj451I01vX8FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794483919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HOiY7t+6Ht5kHOkHA2FZLOJZLjbuqmVxYfSgV4Fl4o=;
	b=8eJ0S19h+N5fpVcW8D5IHRytFJFj2Qq24YIjN58GKiNsp5QIeRAD6G73nB9xk8pwhwDb0h
	9NQCWZl7C0eaPpCA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Nicolas Schier <nsc@kernel.org>
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
Message-ID: <avWmzbh3rp7TawCn@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-11-darwi@linutronix.de>
 <avQNgXSWhODyc5Fc@derry.ads.avm.de>
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
In-Reply-To: <avQNgXSWhODyc5Fc@derry.ads.avm.de>

Hi Nicolas,

On Wed, 11 Nov 2026, Nicolas Schier wrote:
>
> Please add the optional overlay arguments right here:
>
> 	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)" $(addprefix -o , "$(OVERLAY)")
>

Sure, will do.

> <bike-shedding>
> ... or let kconfig-policy-checker read the 'OVERLAY' environment
> variable itself.
> </bike-shedding>

I'm not a big fan of environment variables, especially in the sensitive
domains of auditing and validation.

I've built a lot of Linux systems with Yocto, Debian tooling, etc., and
environment variables led to some of the hardest debug sessions.

One checks CI logs, Yocto build logs, etc., and nothing directly leads to
the problem at hand.  Only to realize some hours later that it was an
environment variable some layer on top of you has erroneously set :(

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
