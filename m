Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315F32D45C
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421379; cv=none; b=GJS+pDJo5yB1H7yMjRD/ts7oFSQMFpuBELFXzmnri2MerqhgfbVAQzYePdvgs1vYugM84QXJbkoHDQgDhBvEgPMdH8Wgj2duYCtjpxkDue+3KG+qvVQHv7Pk22l/+jg9y0b1HBIW9tP3F7asXvUWFyr4KuAxooC2HAW4MsLRXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421379; c=relaxed/simple;
	bh=VbeBWdppKfqCbY/sjS2/7nXliFIRTsgNIaPxooXf+ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4KVBDtuRh/WKVpFmD0iF7apBvQs3+UpHUQYX97DDc8SYrMZOx/SeyEcgK8aJyej53TAd6pbJeJmFnIP2K8J6lcEauOfBU3eopLITQS+6Jl47NhWE/COlnjk/f9sX0EezHW1nBbt3M/8zRSzMEdvXSx5mlJCFekTAHimh2l5nCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8HWZ65n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BT1aXoau; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8HWZ65n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BT1aXoau"
Date: Mon, 26 Jan 2026 10:56:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769421374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NTafVHHqA3gFQvf8/15cpyxZaZQjKjR0HodDp6qra40=;
	b=b8HWZ65n1EupzUdN98jFug9ZmT+Rz+gHE80++ARQIXOt2ZURr9Szm+keE37zcfMcYNsmCV
	pDVgzfJwFkMlgIkAFOcXj/NyC5iZRVoG+lknQt8XHx5DRwr4n5rAWV4SuZlidxJFciqlVP
	IqhbV/bHCspgupdI5GhciaQoF1tNoRUQoBB7ZwvacNgH0oqfQKa2IxUgOZFJBgghMrTmaB
	pBmRO7+TGQdTBZRqUBtfH3f2wGW5gTk0MwSDNBuepfAxUgQrGlmPr+t4OwHjVMogWZIGuF
	jTmUrkxvXiBXp3J54UsgdRGUfV1WGmkexvg7GWYPgVMjy+Tc4NZpfD8xG3/+Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769421374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NTafVHHqA3gFQvf8/15cpyxZaZQjKjR0HodDp6qra40=;
	b=BT1aXoau3mo89utTwl9IjBNA0hHAGvqUpuhwPuGRSrMs+OWLL3pSwOZAkb8fk2RFuGxMoP
	OoRU6M64grVFYEBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Lee Jones <lee@kernel.org>,
	patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/21] mfd: wm8350-core: Use IRQF_ONESHOT
Message-ID: <20260126095613.vgkhGpdh@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-18-bigeasy@linutronix.de>
 <aXOLS_ZP7o0xaHII@smile.fi.intel.com>
 <20260126080119.AEjgGgaw@linutronix.de>
 <aXc346Nr_C4sybE5@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXc346Nr_C4sybE5@smile.fi.intel.com>

On 2026-01-26 11:46:11 [+0200], Andy Shevchenko wrote:
> On Mon, Jan 26, 2026 at 09:01:19AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-01-23 16:52:59 [+0200], Andy Shevchenko wrote:
> > > On Fri, Jan 23, 2026 at 12:37:03PM +0100, Sebastian Andrzej Siewior wrote:
> 
> ...
> 
> > > > Cc: Lee Jones <lee@kernel.org>
> > > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Cc: patches@opensource.cirrus.com
> > > > Cc: Mark Brown <broonie@kernel.org>
> > > 
> > > Cc list can be moved out from the commit message.
> > 
> > If I move it out, the list won't be CCed.
> 
> Please. elaborate. It works for me. I use `git send-email ...`

Yes that works. But I have to move it every single patch and I have 20
and the number of Cc:es varies. Once I move it there, it won't be there
on the next git-format-patch or will be imported via git-am.
If you continue to nitpick here, I could do it for the next iio
submission assuming it will be picked-up by iio maintainers. But doing
it just for the single mfd patch looks like too much work.

Sebastian
