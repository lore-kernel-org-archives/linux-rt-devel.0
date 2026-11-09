Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242894;
	b=c0YTtt/+7wgKkqqOvM4PmKjPnYOp2grgD3cdHY4OCkYk3lrn9f3l+CmoNbOPHBFMg099
	 MN8zrnPIN5bIq3MDbn+4Ua6XqnuKWq7AcUiyZtdkp5xKdxi10a4lF9iEA33q2eRoJA8ez
	 sx+C0M5WFSL+2G8Dipy7RI0w71QEeGws6VIYS0V+GmYdkV24H38m5GFN+3Zox71JGGYDK
	 uZS9BhRGgEcJk6vbJ6PMSNhSSrxw263002+haQUDsy0R4R3kghP6hEdaTHVVm90TuyWIz
	 Jc7d88yr0KoO1MhmFR+Q+xtbC3CCF+iZ62HhoDcLAo0V6/RJXAFlp1j1w9YKflkmd0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242894;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=WjCmpvBTBtjAAl5ks8xILiuJnGJaZE8yootAcNpntZg=;
	b=LQF6j88CqnXyF3ZNqX0PO/bXcXuNzd6sljyUgjdaSBMA+qqo9gzT5VWcLwhM6sjJ77hc
	 PtSZXuG+OSEkpKMQ/NNK6820EToUCaMdgaJnnsK1ayXjSH+q9SLFvXNKLO1dFGbjOzj5X
	 E9nEU7k0uFkUp0eV/2lWDqroZAN95R912L+CTnhBpoPU85lmQqXfd6nTjy06hzAX0vqbB
	 m4klAHddvq0HnakzmvUrE7m9vgyn5Ixf5b8no63k4dMBJ2MzmevFeyImDUzx6e0ji0TQN
	 5UNmx59VUJOAd9+GAAhJBHtpbWlKbgRA3sV/OiuEam/G90Pft6LRGAvvsmoOtQ+AHig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2fgB66IY;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="zDcrh/E0";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36E8606A31C;
	Mon,  9 Nov 2026 16:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A36E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2fgB66IY;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=zDcrh/E0
Date: Mon, 9 Nov 2026 17:47:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794242879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjCmpvBTBtjAAl5ks8xILiuJnGJaZE8yootAcNpntZg=;
	b=2fgB66IYCOqAsgDiJ4Y85b+V/KNFfe3n2zAj36z1c5pXBXxmohpfcoMWGGbZHuiBzx5LZ9
	stSz/0vfbvISOISpa20+j80Zqf8ni9PPZgSDM3BZIEy3trqRZ50XU5jh+QoNhkJwaGvBeL
	iOP44Bf+r8tRSWphQYvET3l1XglBOb0Z/Zesbg2ypJSaFytVIjaM8j1tit+gozKPP0VHmr
	ao9rrSHIioHV0v/qNi4t4HQP35KcDHfgwlyj7RCeo3P5uOp/SH8G/jqLlgWEm7Q3qXH3Qz
	DBwoufM7XVe/+aOPkBGA0TjCDQ6Lw2MsMW+GTjejqNlA1TXUwLsKEnJhtWvDBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794242879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjCmpvBTBtjAAl5ks8xILiuJnGJaZE8yootAcNpntZg=;
	b=zDcrh/E0c3Ts0L0CWB+Jv2CTG9QtpQQJ64ye3yZTlp8mPMNQw5byWSM6ik4azIjQ5nQ2eK
	JhSjaWTyJmkuVKBw==
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
Subject: Re: [PATCH v1 07/10] kconfig-checker: Introduce overlays schema
Message-ID: <avH5PftePd_0y6Lv@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-8-darwi@linutronix.de>
 <sashiko-outbox-202762@kernel.org>
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
In-Reply-To: <sashiko-outbox-202762@kernel.org>

On Sat, 07 Nov 2026, sashiko-bot@kernel.org wrote:
>
> > +# and a custom-overlay.yml:
> > +#
> > +# rules:
> > +#  - name: CONFIG_DRM
> > +#    expected: allow
>
> [Severity: Low]
>
> Should this example use "expected: allowed" instead of "expected: allow"?
>
> base.yml restricts expected to y, n, or allowed, so an overlay written
> from this example fails schema validation.
>

Correct, it should be 'allowed' in that comment above; will fix.

Thanks,
Ahmed
