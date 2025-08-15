Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A024E4BD
	for <linux-rt-devel@lists.linux.dev>; Fri, 15 Aug 2025 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249624; cv=none; b=gEfc18UZ1dVvgeWPJ7kObi3Kj1WnUOPAgaQujOIjVpAktbk73zggVTO4/soLWFx/FjLRw9XYDs2uc64J0GiRytIlC1lsykJdV4fkzIQaF6biY4Ne+BAcfd2U8XcRssIQe/GtjfKqnfRpIxwoYxiqltNHfSFHtvxzXRPv0Uo+hDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249624; c=relaxed/simple;
	bh=KG2+fnJpIx2NMqstgoKNpNnE+HWM0QGt9UgjidkNy8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXtPDpsT8JbLhj4mbEH7QHDduz6MeMJLB3ig1EG20e0usAmvu1zUOshAgQ9T68b/Hif0tiyuxqEzXRsanHO//r2vf+eaZHjl4hodduSSfGtXEkSo3PkuHep1y6xknyAyzHEHzFFxaAgmr7vKgMlCSVKCmCiiz2G/ECRpRfPlops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hKvj224/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9ZeAegd2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hKvj224/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9ZeAegd2"
Date: Fri, 15 Aug 2025 11:20:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755249621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnorshHHbLPDgCMGHLAFyLgo2Y6yF3hic/k3HY3FcUQ=;
	b=hKvj224/7awgp0KbQmOGNajfOgjmbt+Uv04X3mvqVPGFsDxLkZ1IMFApo9kCYS90uspOC5
	PnxUbQF4JiJxjjOck8a3z5SjgJriEfUp+i6ecQesi1Sq72x0j90gUF/0vhMipgjs2rmu2g
	9yfv+HpNA53WwBKggC2PlT+i+Gy6B2oJJBoGDeZxdtRbfrN8uRB2nj8HHLBYJ9lA/oedvh
	77ZSeu/CeNkCewAe0dfrF8AfpGrtTbvmqSq3PCvws51rcUAQNasITEZj9L2VcRZzLaxDu3
	8vY890ZYnxr8Qt004yckfGiZuV4kkUGXv52NmW7KGgkFZUl0oWEclWHfAxLRgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755249621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnorshHHbLPDgCMGHLAFyLgo2Y6yF3hic/k3HY3FcUQ=;
	b=9ZeAegd2Ht11PEvjxIqRiQlInctKBDPR6sn5j/nXtFuVmAPUEl9eBljsckInAPKTHQXY/U
	73lHbn5xLMITl6Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] Documentation: Add real-time
Message-ID: <20250815092019.EAd9FdNN@linutronix.de>
References: <20250715144127.697787-1-bigeasy@linutronix.de>
 <20250715144127.697787-4-bigeasy@linutronix.de>
 <87v7ntdwp5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7ntdwp5.fsf@trenco.lwn.net>

On 2025-07-15 14:29:42 [-0600], Jonathan Corbet wrote:
> So overall it looks good, but I do have one overriding question:
> 
> - Who is the audience for this documentation?
> 
> I think it's an important question to ask, because something this easily
> becomes an unorganized pile of stuff that somebody thought should be
> written down somewhere - better than nothing, but hard for readers to
> use effectively.
> 
> A good first step would be to supply a paragraph or two in the new
> Documentation/real-time/index.rst describing the nature of the
> documentation and who it is intended for.

The main audience are kernel developers.

> Then ... think about whether a new top-level directory under
> Documentation makes sense.  I've been working for years to reduce those,
> so I tend to push back a little when new ones show up.
> 
> - Is this documentation for kernel developers in general, with the idea
>   of maybe helping them to not break PREEMPT_RT so often?  Then perhaps
>   documentation with that focus under core-api/ makes sense.
> 
> - Is it, instead, intended as overall design documentation?  We don't
>   really have a good place for that now, maybe we need a new design/
>   book to gather such material.
> 
> See what I'm getting at?  I'm not saying that these docs *have* to go
> somewhere else, but I do think it's worth thinking about.

While thinking about it I moved it to core-api. There might some user
bits which in terms of setup which might fit under admin-guide.

> Thanks,
> 
> jon

Sebastian
