Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721B3EBF14
	for <linux-rt-devel@lists.linux.dev>; Wed, 16 Sep 2026 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541729; cv=none; b=ujVfO1k9D+DCtDNzO9mKMllR4gDgan1idQppW9RaarCdBEWknpSy1lj42kJpOSuGPeLbvUWARU+/5l39igPgKF9Y/RZEqA27lgmlpWCH+jbeT4pIXU2xmF6ThJ/8NNLFj5Z09jba1vI6YsKKdEmJxrajZDnmdQ1jWmbVd0xYvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541729; c=relaxed/simple;
	bh=QXTe48Zea/Trvazz/Pkd3exaoVKlULQahD22GQ0/e4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8tbM3PIKOc4p9hQspTdQJeagSrYdzLuunRoa6L/BNXbg3WfII8r7+eqkE3Gy6eYWReGf34PWvuAxw4TH1GOV8W7eqPJ0Ui6gRE/9G1n54he3Vmzb0gxixXyGrHMCRRkSi8be2um9krjxtkY+GFfVpZ9R76+Re12sT9FuUCCUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d8KzTUND; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nTqE4oSa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d8KzTUND";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nTqE4oSa"
Date: Wed, 16 Sep 2026 08:55:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789541725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9JO/nXJM4LsTI15Dh6R6P3Rqfh7Ru0q6bmBLCp4g7U=;
	b=d8KzTUND03j3NdeVuY3GH23jIk5brwhQtdraM7PikkrUR4bKEOI2aB9YfQwuZwQF9ijVF5
	Hs+RE6lvS9GCn5qsmyrtGKXmAnuHYp8WGtSEHKxoONTuB3V/USNkwbUYN/DVmXTyvNbYQb
	g8xtIBUmvAN3MZa8RQB3dm759d9QjiRjhmHXiY2W2NmzLVO7myiEc+g8m++eEAB9TFGO1Q
	VwtqPrukbNv0l5EdXExKtnWbIQxqCBdB3+f0PjrDQUnbNEJTJmhDNndPSQ8e8zQ8lmdS9L
	1CQM9VL4nxU+PV7idppSNyCZ9Tw18esIW2cpzrxAfoGNfhb57ggLzXCV64ZUMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789541725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9JO/nXJM4LsTI15Dh6R6P3Rqfh7Ru0q6bmBLCp4g7U=;
	b=nTqE4oSalnbUJXQjhv1kggMWeeRiI+xO13V29BwxV1TwdkgYL7rTZ6g0zU+oZLqhxLFISo
	sqmSlQs+UFZPJsBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCHv2] gpio: mvebu: keep resume masks within the irqchip cache
Message-ID: <20260916065523.ZJKAHHyW@linutronix.de>
References: <20260915004406.115230-1-rosenp@gmail.com>
 <20260915064352.T4HiPnt_@linutronix.de>
 <CAKxU2N_+H50zy7V0FR-_4KiyAG8+_x4kg2QZBsumHEXgdwmqKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKxU2N_+H50zy7V0FR-_4KiyAG8+_x4kg2QZBsumHEXgdwmqKQ@mail.gmail.com>

On 2026-09-15 15:24:24 [-0700], Rosen Penev wrote:
> On Mon, Sep 14, 2026 at 11:43=E2=80=AFPM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2026-09-14 17:44:06 [-0700], Rosen Penev wrote:
> > > mvebu_gpio_resume() writes the edge/level mask registers saved at
> > > suspend time straight back to hardware, bypassing the irqchip's
> > > mask_cache_priv.  genirq skips mask_irq() for a line it already
> > > considers masked, so restoring a bit in hardware that genirq thinks
> > > is still masked leaves that line unmasked behind genirq's back.  An
> > > asserted level line then has nobody to ack it, and the moment
> > > interrupts are re-enabled the chained handler storms, hanging resume.
> >
> > Why is the mask value changed after suspend?
> In order to keep genirq and the hardware in sync.

There seems to be write after suspend took place or before resume.

Sebastian
