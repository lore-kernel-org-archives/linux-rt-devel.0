Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A712421C9E5
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Nov 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854487; cv=none; b=DdMQ8sEDRBXmY2znvzkrQ2jHCs2L4baII6N76r6KA6K1po5gNFLjClfflfqRe65RX9JD/kGwaZVF0e61TrszRdz54UkgmcZHKc5+LuPq2NStUqi8qTW0MKIb9K/K+0SWViyor65Wh27GOpZ/yrqEd/BRPdl6Nehl1Wi5ox5TGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854487; c=relaxed/simple;
	bh=s4vZRjeHf8xm5v486mrL1l/04vl1J/l595ZP1oCwGXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpnxDkXgeN+akpaCZd7QE11kc9wgT5CDOWbOz+fcZj4Lba/4jFX5nc08ri82Zj0KbA/qNf8nBlxq4rhD9jsmDZRgKcGv5CgdDbq2OK0k4/nuKnBz+nujkZ3d1170pmbU7AdgqysWpgWXQvi0VKiPv1AjVtb+39y6ONQhleVIJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ipoXYAyj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RjNwJsoS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ipoXYAyj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RjNwJsoS"
Date: Tue, 11 Nov 2025 10:47:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762854483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUPk8N8N0fajnspcbCfKKCzQcyP7edfMte98l3Q1XEo=;
	b=ipoXYAyjp91Nfb7CBlgWlVlWnoajYxUnSFBQMBg8ycaepgegc6av2qBU5AdsztGRMH1Kz4
	ILwzFZB5aSNXXhplOEybXBmas4+bCFW2qwNdq54ScMbEi6y8vakJw4RzRn8hd5B7wEXYEr
	HwyG6JI+/NO+vPs4YEx026V4kyTZsl19KHBOIHgO52XbFnq+RWJ9RpldG8wIKZ8HqnNVJl
	bf5vzKhMjatmOsThgAV3W6Fc6cZymuuxQRjq1F9c+hFUeAbcb3iY+AnGKathXit0TKAF5k
	mLwn1hIxeLSokqKpGiRFa9Mhg9ks5IKqplSSRiCZwPLgPJn4wcu5fbmi5tymBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762854483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUPk8N8N0fajnspcbCfKKCzQcyP7edfMte98l3Q1XEo=;
	b=RjNwJsoSUpmg58g7J10+HQCv8XxW43yJsRcSXPWVEVD8a5WBmWtCy3lbQF+I/yN2KLP42t
	eu3FO7yDlKylt1Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev,
	Mario Kleiner <mario.kleiner.de@gmail.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/7] drm/i915/display: Handle vblank evasion with
 CONFIG_PREEMPT_RT
Message-ID: <20251111094759.Y1Q9-nug@linutronix.de>
References: <20251104083634.670753-1-dev@lankhorst.se>
 <20251105134740.NseZnpeZ@linutronix.de>
 <32bbb93a-3606-4488-ac3a-3dcd1fd38304@lankhorst.se>
 <20251110160958._fKhNf8i@linutronix.de>
 <7a370923-d430-4f3a-94b2-1749b452facf@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a370923-d430-4f3a-94b2-1749b452facf@lankhorst.se>

On 2025-11-10 19:17:46 [+0100], Maarten Lankhorst wrote:
> Hey,
Hi Maarten,

> I would like to recommend dropping the patch below. The hardware doesn't like being
> programmed during vblank time, and may lock up or show glitches on the screen,
> especially at older machines.

Okay. I did include them for testing as requested. I would keep them in
the series until we settle on something upstream.

> That's why the whole complicated preparations exist, to be able to complete
> programming the hardware before the vblank.
> 
> I created my series to be able to run that the timing sensitive parts safely without
> any jitter from locking in between.
> 
> I tried running the following series through CI in response:
> https://patchwork.freedesktop.org/series/157258/ 
> 
> After looking at the results and investigating more closely, I think the FBC warning
> you mentioned is a false positive.
> 
> The code either runs in intel_pre_plane_update() when programming the hardware directly,
> or it gets added to the list of mmio's programmed by the hardware, without the
> vblank evasion mode active.
> 
> Still I would like to clean it up, but it's not as urgent as it was.

Okay. Good.
If there is anything you want me to test or look at, just le me know.

> Kind regards,
> ~Maarten Lankhorst

Sebastian
