Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF3471255
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657308; cv=none; b=cFVEokHPI4wL80t2xhzUGqbhg9g4n/wMujHFaPJU4HZbdE8YO9Haatza/PIuED+/dO8QzR2ZjYWWNSTs9DVCVWTZT1wgPWXveBVOoN/e4+7t4U8vwVgrE/8kiNsm2h+hhcy4iunoVocboogBiVPKOV97U9LtSIXBeNcRWrfuCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657308; c=relaxed/simple;
	bh=z/IDNeo3CYfMaSBman2RZmqnvh3FinzpYHXH5rjaeQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVyT+GgAWVIqiDTbcgJ6C3v9kg3KCPkLZNRUPz+NlGca1Qw85jQj0614Tu/F0D7LSfhP7U6nDLhCMBFfH4BULv44/ObuPIVVnCQahqKX0TEU5d4T8bvJ7w69u/FChCE/3ebir1UCgIOC6wXGy3iBxzBin4zBOLnN58/Ma2ZVukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gS0Du2K1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P3sCM1aB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gS0Du2K1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3sCM1aB"
Date: Tue, 21 Jul 2026 20:08:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784657300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yFentBsonVa5YUM+Pkq+IObssXO7JGS8Ljqy5X8W/OE=;
	b=gS0Du2K16qvjG19Z0OiqiW45JIigAf2vGlRxFRuTtWpbridHz25QuV5lgNSNT779miSYes
	glyFC9mhUhfv0WDSuU1UlTaUVKu7263UduUR04tqn0i3JlniCs5iY0SkPsti9SdonjuYFw
	fL7GG5FLq08L/V4IhT/jqJC1Msxg2UAxXG94bBqsUsAEZadnE7lBNFdefg5RIp0IV4WLN9
	XrZ9l8M/MuI3BQofWnu7KSUF1eC2yhb8EZ+FNFJC3BGkUIVWCGQpEMnDQQbQrwSy8p9cw1
	F/ubMbkv9X6jvmsUTAgAHhzvV+0GY022GatQQT3LWiQPhTaEIOMIM+kmUInJqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784657300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yFentBsonVa5YUM+Pkq+IObssXO7JGS8Ljqy5X8W/OE=;
	b=P3sCM1aBFGA+2mjcOWPtuaLcb2tK+TnKzrOQYOlscGvoaoA4KE0/aXqzyRtR7tl5iPOcks
	w6XLC8DEZU8QG7Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <20260721180819.DY-zkSU1@linutronix.de>
References: <20260716195716.256025-1-darwi@linutronix.de>
 <20260716195716.256025-2-darwi@linutronix.de>
 <20260721130248.ndwsFtHE@linutronix.de>
 <874ihs5s4d.fsf@jogness.linutronix.de>
 <20260721143606.NqT15H0p@linutronix.de>
 <20260721104806.64afcd8f@gandalf.local.home>
 <20260721152114.wTED4bR5@linutronix.de>
 <87wluo49y7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wluo49y7.fsf@jogness.linutronix.de>

On 2026-07-21 17:58:00 [+0206], John Ogness wrote:
> On 2026-07-21, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > On 2026-07-21 10:48:06 [-0400], Steven Rostedt wrote:
> >> On Tue, 21 Jul 2026 16:36:06 +0200
> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >> 
> >>>> Unfortunately, debugfs is needed to configure the fair deadline server:
> >>>> 
> >>>>     /sys/kernel/debug/sched/fair_server/cpu*/runtime  
> >>> 
> >>> So drop the reference to it. It is not "bad" to have it enabled. It is
> >> 
> >> I believe that some distros feel that it is bad to enable because there's
> >> no real auditing of its interface. Although, it is now only accessible by
> >> root.
> >
> > Yeah. Either way, there shouldn't be anything real-time specific that
> > requires the user have it enabled or disabled.
> 
> The fair deadline server is certainly real-time specific. It is the
> new/additional RT throttling mechanism. Generally speaking, RT systems
> will want to disable it or at least reduce the 50ms default.
>
> This document is not about runtime settings, but if debugfs is not
> enabled, the user will have no way to configure the fair deadline server
> at runtime.

I would suggest to delegate it to the proper section. Also, maybe we get
a proper interface outside of debugfs.

> I am OK if it is completely dropped from this document. But if there are
> distros that think it is bad, it might be worth mentioning that this
> config is important (if not critical) for real-time systems.
> 
> John

Sebastian
