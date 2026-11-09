Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230334;
	b=ba/g3BuESukZMeanQ0NeJZ00fy6aM7flaV8JjpClrQL5UHx9Eel5KkJGs+GwC9Nc+PeZ
	 z831QC+EmlNVjTZ8u/o9bN94UnuSmap6TYG5uyyQoLfRdIefwz4Arkclf0sZBPf4RRj57
	 JfYKh8xhDTaFFNNcNc6n1BLfhXDlgUXLAZY6+WG0kh1dqTDq/k+XGAhzT+p+8uMnJPKM3
	 ugkSxcx/M0oF2PcEXHbFVnTC7vzjHO7Y0IRLiNQ2QfnQUg4YeWCUzoTbv2s+rQwdU/o61
	 6ROjDkRery62O+4+iErU00HNF0+x2FpWdAItVV2xR5uf+WKDB/yVStPKhvB59NqtE/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230334;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=tMXHe7LOEpQwsow8Uy2YcO83thnpHcV55BkTpvZf2y4=;
	b=iZmVK4WU21yx0Xy45a76puDnL3uGAwbliTjSnYoCkGlvuAqfCBVuA//BhTmYg6cUb/ne
	 rPQ18qifN6l0wHBV7VaMjFAY0aybh9BOjHvl9xsL2cXbFLA9fNml+NT7sL1XQf/G1sFuI
	 CrMTc1GdVvzxUT7i5E+njrez7hRwr71WZw3RH96J8go1RW0paC8/58WsqgYtF+F4B3EtH
	 X9GY4XL8KtumXI1zxyiqQt123M84bDQdWl0q9d0Agrrxt1UCe+nXlInB4msTiVJGYl8Ge
	 cR7UbHA5tgUC57TXxx0OVmOINQVIC9e2+UY0cYAOQn8sNafhf6CyjrHQoyEprcTXURw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="zZliaNK/";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6EHalkND;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540BF606A338
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 13:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 540BF606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zZliaNK/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6EHalkND
Date: Mon, 9 Nov 2026 14:18:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794230331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMXHe7LOEpQwsow8Uy2YcO83thnpHcV55BkTpvZf2y4=;
	b=zZliaNK/fyFYpmhiHJpfrBmH7+jesJiapHjRMSvmu+ji6oo6e3NVekzFNZWcxWP4ROwxeR
	5rIXNxLWlHPC7ZUpj1qctZX32sVB2mXjKkfUV9YzJWFiBc1WHRCC9DF9rDeWK+XoH2AtN1
	9IOkSXESFFjAUqZ4Qfv2NZIa5YteCOSb/hEwn9QNyMLpJK0ZhY1Xr5pP2tgCyp3z2aUTwj
	H7a0rCdx0YwPeK5t9Pa7dwOFdMSakXlHvZEcfmPNGBQAHbU6eDT95eCVHtacRNnmdMfXQE
	mqn3LriZ30H2kUQCRsCBou06q0pgOywDVzNmtFuNcROFjmXa85Mi4ODqtKQtlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794230331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMXHe7LOEpQwsow8Uy2YcO83thnpHcV55BkTpvZf2y4=;
	b=6EHalkNDoeS3bse8s75evKp7TN2+D6q/akhi/zJZefHHgXJx7R4ozf4qfdVR/P+yfaCZaA
	8Y9D1X/YOGk1qBBA==
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/10] kconfig: Introduce checkconfig target
Message-ID: <avHIOS9NHwCCMITd@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-5-darwi@linutronix.de>
 <3dd2bb0d-8486-4630-b496-e92e4ac37c29@gmail.com>
 <20261109003909.GB3429615@ax162>
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
In-Reply-To: <20261109003909.GB3429615@ax162>

On Sun, 08 Nov 2026, Nathan Chancellor wrote:
>
> On Sun, Nov 08, 2026 at 06:59:45PM +0000, Julian Braha wrote:
> >
> > I think this tool may belong in scripts/ due to the kbuild integration,
> > as was mentioned in the past on another tool review:
> >
> > https://lore.kernel.org/linux-kbuild/20260428183101.GA3304253@ax162/
>
> Yeah, while I would prefer for the script to live in scripts/ due to
> being called from Kbuild, I am not sure if the rules/schemas belong
> there?
>
> It might be better to keep everything in tools/ for that reason,
> especially if this may be called externally, but I am open to other
> thoughts.
>

I would prefer to keep it under tools/ as well.  Because of the PREEMPT_RT
policy, and the possible extra policies from ELISA, etc.

This is why one of the development rules at the top of the Python script,
at patch 03/10, is:

  The tool must not depend on being run inside the kernel source tree.
  This simplifies invocation, testing and possible future packaging.

So, upon (hopefully) including this tool mainline, I'd send a patch to the
Debian kernel team to create a separate Debian package from the kernel
sources for it.  That is, exactly like what they're now doing with perf.

(v2 of this series will add versioning support to the schemas; thus making
 the tool's support for packaging stronger as well.)

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
