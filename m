Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DB32ED32
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422392; cv=none; b=R4IUrzS9v5Vb6lwjYo0DS5gaK9X7g6t0mTvLNDvwgiWtaALDvdFl7N8NxDoegXq4gpkakFH3CWoiXs7Yu0oSz1ccfnzwaxWRIhfkdGW+FaNszSZuVkLNIh1kXshnLm5lpJfOc+s2HTORstVv7DErzUKdLv/A0Ki5LkW388lnCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422392; c=relaxed/simple;
	bh=S/yM+CF4IYCc6b9ym6jawxQ5s1xjUyFkS3CFV/69dCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfxtfHLEqXQZ5NiBrkpOjQug8pQL/zyZNC906+wIERFdhNwZdEHAwjqYNCjO69hFljn/ssc+WLGtPLc24dGmNAZSSuIkpt9Fl+semBaziOi0V6YeiwWqJEuucOugcPIawFYacFGPUDQtA55DkZ8I9rYi2IdcF5BuMTI3NF/OJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NER9gLct; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=59Zhvodu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NER9gLct";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="59Zhvodu"
Date: Mon, 26 Jan 2026 11:13:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769422389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDlEnaTaRlBZltjPd2ORCUM3ilFz5q90jaV7Q3mhyeo=;
	b=NER9gLctfPerZL3U020eSpGpI2xB2a/zIPXO+ii0KXEdvjNHsMRQBxyXOiQkPFjq8Nj/gb
	0imj3puENwNDg+JO11eGsliHUTooLqtfnsxYWPM91kZc+b50yGJrjGCmoh+ARYqU9ouzA7
	7oFbLGrBwmujGt7QykX36tbdhwID+L5SP+LWhO9b0d1E9ry4Oyc+r8ylBQ84pDrwsiWCXY
	rawn+lzBIwmXxICLWMXAP1xYfkTBowhyYOp6MiDVsLlPlhRzvzfJ6N8iufUzmhRKh5SxgX
	ozzwrN1iavn4lyof2ujZUnb1YRtm47mgMLBxWzo2WvwAQ4vue8DjJcurLpKl1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769422389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDlEnaTaRlBZltjPd2ORCUM3ilFz5q90jaV7Q3mhyeo=;
	b=59ZhvoduMfs05OFfyl0gPY2KRh0Z11btohqkSywwFZWwbv3tYI/+TJmAvd7z4790F+SVRc
	faMyMmCnq5JLcXAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Lee Jones <lee@kernel.org>,
	patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/21] mfd: wm8350-core: Use IRQF_ONESHOT
Message-ID: <20260126101308.TOAFAQsM@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-18-bigeasy@linutronix.de>
 <aXOLS_ZP7o0xaHII@smile.fi.intel.com>
 <20260126080119.AEjgGgaw@linutronix.de>
 <aXc346Nr_C4sybE5@smile.fi.intel.com>
 <20260126095613.vgkhGpdh@linutronix.de>
 <aXc8WYH0p9Hr-yz9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXc8WYH0p9Hr-yz9@smile.fi.intel.com>

On 2026-01-26 12:05:13 [+0200], Andy Shevchenko wrote:
> > or will be imported via git-am.
> 
> Yes, that's the idea. `git am` will strip them out. But why would you need to
> apply via `git am` locally? You can pull from the tree.

I fetch from the list to pick up the tags, fix some of them up as the
iio but most of them remain the same. Then I post the v2. Where do I get
the Cc from? So I add them manually again?

> > If you continue to nitpick here, I could do it for the next iio
> > submission assuming it will be picked-up by iio maintainers. But doing
> > it just for the single mfd patch looks like too much work.
> 
> I'm thinking of all the patches.
> 

Sebastian
