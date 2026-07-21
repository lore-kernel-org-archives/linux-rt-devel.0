Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782E3DDAE4
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644575; cv=none; b=FO31aLb0MG4YWqywjxu3NYG8JZvTN1k5M9bbKxKaU0wbgk4+RhWr9HOW5ed/somJ/jS06sGpzy3dEZdgkYTfHVpgZ3Iii3F5GtoRnA4ENOTPQgEk3IMAp0pU7OgPTz9s6ytTwT498UXEfOSdDoexWN1Q8SCfnDRqfwC79mbRzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644575; c=relaxed/simple;
	bh=FjfckGRDhoL0MdRPE3rlXhTjyPT2Pff9Ji0JeV50BUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR1OJf23UHPzO/R/sbSi4QD+4hOWmGNVQ6+7Mx3YjxizjiqyM2rfeDQiDuluFQeBmjNF6QLqamEtBujCIHcTLLAq6HmCBbUkxPEwmfd1yVglSPU/HKsIdU3eUnsiorWqwjXOZtMwgl5QKPeysnyBmIfQYZ+WrF0lNaIwhhpUQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WT7FL0fH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XErFh56i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WT7FL0fH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XErFh56i"
Date: Tue, 21 Jul 2026 16:36:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784644568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y73VMo44vVc17s0kwvEBNmYMDLr9glAxebOJvz8TECg=;
	b=WT7FL0fH4esB+FYB+d9WSR+/MzGOjCbT8XrSoI9Vvnah1q7IejVEI3xxb0/HFgg+PuGBiU
	gdlHuekCqdGvNrAKV9VqqngmqDuA1Jgrk3DBJksWjY4kwMaGaN7zi0/7NTnk3NcGllBsaI
	LoQ5lJ4nozhSA2j0MsNeVfr5in7FJykeMeWO7hzgq+2QJDlxLrJv0LnQ9j9geFWo0/BOi4
	j5+SrsWsDpbHx0mtMYmNMS9at2g4+NQUR7snOKuZNkoaCRfT/Xl4xMEsyuUSfY0dM8SbxZ
	q55AYDZQvcLKHqdEHlNBKBVxrzQcc9T/PpE/I7TaqKMbuORYp7kG/ipviP37hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784644568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y73VMo44vVc17s0kwvEBNmYMDLr9glAxebOJvz8TECg=;
	b=XErFh56iWcVhEBhqEbll09MnIQYmcyhJxuR2GGh52rGAzXfHJa5QMkdvzewpz3feGKGRky
	8o60rjbviAM5MvAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <20260721143606.NqT15H0p@linutronix.de>
References: <20260716195716.256025-1-darwi@linutronix.de>
 <20260716195716.256025-2-darwi@linutronix.de>
 <20260721130248.ndwsFtHE@linutronix.de>
 <874ihs5s4d.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874ihs5s4d.fsf@jogness.linutronix.de>

On 2026-07-21 16:40:10 [+0206], John Ogness wrote:
> On 2026-07-21, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >> +``CONFIG_DEBUG_FS``
> >> +^^^^^^^^^^^^^^^^^^^
> >> +
> >> +This is safe to include in real-time kernels, *provided that debugfs is
> >> +not accessed during production runtime*.
> >
> > It is safe to have as long as you don't use it.
> >
> > I would drop it. That filesystem is not dangerous on its own. It depends
> > on the options you change and how this affect the system.
> > We used to have it always enabled because you needed it for tracing.
> > This is no longer the case as it has its own tracefs which has its own
> > live outside of debugfs. So I don't think it is needed to mention it.
> 
> Unfortunately, debugfs is needed to configure the fair deadline server:
> 
>     /sys/kernel/debug/sched/fair_server/cpu*/runtime

So drop the reference to it. It is not "bad" to have it enabled. It is
just an interface to other things. Same as sysfs except that debugfs has
no stable ABI unlike sysfs.

> John Ogness

Sebastian
