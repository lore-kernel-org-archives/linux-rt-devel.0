Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1F3630B9
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452296; cv=none; b=uwH+KhXIZlk6846zuEyrt1wD63vh0DAyzUgOjFyRY/+lgW1HAd7ti4k1uT+m5XC3cvlBl+o5HBEHXKu7aDqLgJ74obmU+xN/NAR8+ZwsZmh3FuiLgfoYyWGqcOfuu0/uvuJBcwivHL73RbAHu/NBp9hmnyNDdR2a9EgE0gbJzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452296; c=relaxed/simple;
	bh=m8SSIbZ93R41fR9BT9txy5cX7q+XetDeaxLrs/ZiZ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQxE2u9FTJQGb8tTsnUsMN4U1Zf5N74x3hhvsq26krFbklkCotIXjDmK48vlARGocnsiFPH8bpSZivVPe4T8VYZeua1yIKandXMMe4N7AkGucBO7Z9zdgWo2G1YfATyQaBK8ohjE1ZtuA6OoFzAE80uT7WQVZmbF2fELEWUGCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g7XHkW1P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vHn+sqPL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g7XHkW1P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vHn+sqPL"
Date: Mon, 2 Mar 2026 12:51:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772452292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m8SSIbZ93R41fR9BT9txy5cX7q+XetDeaxLrs/ZiZ9Y=;
	b=g7XHkW1Pr65WvnSuDMjZgHVl+CcCiFI7fDIePtB21YwVaC/dV59j/LcQ9NYPhzqDGhkFlV
	LbvVWejqYktwHKlQpY1dLpf5LUFJREo9Y7EM/f5vq8RnEs4ACp3v8fkQatL3YT2TZdxTxF
	+GcN8Dg0D3T21KI3YClpKjvEgGAqWG4UwQrwhTcHqTFPWDGVAc85DdANsN3omvAr5b9A/G
	RNzKKyXHUNgCQx7MvxewVDVd4BVgWTNJjgH+VXydSMYDZ84RGstEa7nt6p/RYhE7rO+A+K
	rcJa3X5gZgHuJfd2wGq50IyXoh6JeJQc3/6AeeQ1GNb4D3XdMss7yJ669j8pwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772452292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m8SSIbZ93R41fR9BT9txy5cX7q+XetDeaxLrs/ZiZ9Y=;
	b=vHn+sqPLO9K+K/S/VoYuqM4qL9fS9YEzsivVX+wDS9DEEsPrI6tilxSBii1eV7NmH4tZ/+
	IcdfFC4+IPiPJzAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/6] ARM: move vmalloc() lazy-page table population
Message-ID: <20260302115130.T10_Vx84@linutronix.de>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
 <E1vvzcX-0000000Awo0-2KBN@rmk-PC.armlinux.org.uk>
 <20260302104351.yyWvNCTb@linutronix.de>
 <aaVs_31KNKvUkNL8@shell.armlinux.org.uk>
 <20260302110055.hFMkUcnt@linutronix.de>
 <aaVyWFNu8scqZeEY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaVyWFNu8scqZeEY@shell.armlinux.org.uk>

On 2026-03-02 11:19:52 [+0000], Russell King (Oracle) wrote:
> We've gone from the code always having interrupts disabled, to your
> review response that always wants them to be enabled (which is what
> *un*conditionally enable interrupts means) to now conditionally enable
> interrupts.

I'm sorry but this got out of hand.
The wording was we must "not enable interrupts" and I was curious if
this is because we destroy some information (on the following fault/
interrupt) _or_ not. If we don't destroy anything then it would be okay
to enable them conditionally. At no point I am suggesting to do so.

Sorry for the confusion here.

Sebastian
