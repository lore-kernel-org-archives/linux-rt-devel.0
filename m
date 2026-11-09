Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240924;
	b=z3vlXTbb7TqDS4/2FWZiSApbCaOe2K1KFWUNvKh/WoGqjyv1z5s16Ki3/wAYaABq5X4B
	 OYiAuj93H0cep/ANPz1rdBWvSEvuJYHKXaG4RkXGpm/cKPXwImYCDY3xomQDvwmn4Vc6L
	 XGJjdn7mygGbgpM2QV2XhPg4S7L/HtScP6WbIdY5GQTvTUB0gm0Ns5JnTowlBS7JoMU7s
	 Io8OHmJK88Mt9Ap1f7yiic/P6kchRqBD/5+B0fkuca9QaXvWxU2XYTrkydHHudpn0RQ8S
	 gf7gMSupTFBCcD8qf4ynnSH6kAQNv18x7/tnd0Oesb1ZPqFIVuZtGyNcDCqGYCoy9KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240924;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=MN1BnROEORvgYw+MypT4h2Jcvdysaix5bzeL3TZj7Ug=;
	b=tXE7IQLdrlOGMom9HHb8iMp1oOgQYcEpxI3dPHp9P1l2e6qh3pWJFVlfn2Zk8QidWd0+
	 aP37Y+Q7ycZNll4D/oNAYpv7/ZANM/YZXVR/e4kbliczp5q2e/nvk0QNYqc5R+pfL/d9c
	 9Wo3DVnz9iwVtFJzB5tUhl1j3E4HuVXlps4yN5sb0igFzY3HcNRjLHVKXGY3VeQIkrjf6
	 dhYYNeKBUMez5M0rfCGZscs+3BFshojLhDjC/8v1xKvW+38g/3frpRezkn5Qx3oJ0+0Mn
	 xLJLlbsKQ0qsT3v4mIrwooU+TqsexvjZ+NUYWurvsCY8ENyLAcSYJ/xAQwWZA1mix/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="Nxb/MLdA";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6Qx5XPOv;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0B8606A32A
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 16:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F0B8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Nxb/MLdA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6Qx5XPOv
Date: Mon, 9 Nov 2026 17:15:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794240922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN1BnROEORvgYw+MypT4h2Jcvdysaix5bzeL3TZj7Ug=;
	b=Nxb/MLdAkBa8XsF9k4yN7JmmPWhb8eEZ4Wx0xAxLiQm4wV/EKdGA2b7vjyaEYTOj9rMTUv
	MULDhOcSoINy1O2FUxnboI/qdEKA2U44jWA5KkmARngPnZ132W1A2SZbdfpfpOx10h/M83
	x1JW8Yc7fQCC+vBVYGuDDuxqa9jqH4WhTtzWe3Ql+gIsbBHY2mBDTm6sftmxRWdfGuQyUY
	yQ5ynwDKnwgsCHJrlGyi5gvzs3LPxm0CDYBMFQ89F2AB/+VXH2RXQcOZ8R7R+fBwX5fkDo
	3YzGn7rbQESMqQdnk4EnrTUic1Sl+761RUJiDSpAbqOUgByyeGCFG5owA9EFpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794240922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN1BnROEORvgYw+MypT4h2Jcvdysaix5bzeL3TZj7Ug=;
	b=6Qx5XPOvhwNYptQdWHV4IOm3h9SuIai0MbKolYUcGGjW2585+syNcIkyAKHYlIuU84OMub
	McwTYs2bfaHtl1Dg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Julian Braha <julianbraha@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Nicolas Schier <nsc@kernel.org>,
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
	linux-kernel@vger.kernel.org, arighi@nvidia.com
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
Message-ID: <avHxmCEdHgyRD7n0@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com>
 <20261109003745.GA3429615@ax162>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109003745.GA3429615@ax162>

On Sun, 08 Nov 2026, Nathan Chancellor wrote:
>
> On Sun, Nov 08, 2026 at 06:59:26PM +0000, Julian Braha wrote:
> > I think the name will cause confusion.
> >
> > We already have some "kconfig checkers" in-tree, like
> > scripts/kconfig-sym-check.pl
> >
> > But actually, your tool is quite unrelated, because that one checks
> > 'Kconfig' source files, while yours checks the user's '.config' file.
> >
> > This has already caused some confusion in the past, for example in this
> > thread [2], someone misunderstood which one 'kconfig-sym-check'
> > actually checks.
> >
> > In addition to .config vs Kconfig, the name is similar to
> > 'kconfig-sym-check', but is not as descriptive about *what kind* of
> > checks it performs.
>
> Yeah, I had similar thoughts when this initially appeared in my inbox.
> As you mentioned in your email, this is basically a policy checker (“we
> need these configuration options enabled or disabled to meet our
> requirements”), so maybe config-policy-checker or something like that
> would be clearer?

I would've loved to keep "kconfig" in the name so that outside the kernel,
it's still clear it's about a kernel .config. For example, a Debian package
for this tool can be called "kconfig-checker", "kconfig-policy-checker",
etc.

What about kconfig-audit?  Something like:

   ./tools/kconfig-audit/audit.py -c .config -p PREEMPT_RT

   make POLICY=preempt_rt auditconfig

config-policy-checker does sound good, but it feels verbose.

Feedback appreciated.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
