Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61D369D6B
	for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057302; cv=none; b=kZLvEPockjoJBn6Y+kPrbs8T+zRxIdTWzPIBmmtvQcjk34o/2p0mZtFe8CZeCL8MTn3Lql+/Tjz/KYw+xefz5A7ntoRZJo+pwLug5OpfYqU3kSg0gLJcAlfKBmdFocv/YcSmFNn0PiXRrFX0lBnVX5VvBzHU3xaP/ynKQDtZIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057302; c=relaxed/simple;
	bh=K+/FyB5WY2rfHsP/2J2VOpMApdZG6GG+CHiM/Tcqx8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RELb1wi3ly+OSM29Rmdcm4GuC9LwJ7y4OYbfW8YAAeKm7ZhmAa3uk6YPrLD/wOoklBj5rlHIvn/hhrxS+U6x/x3xiP1ci040oQLbZiUE6f2hlay099s4eHOqex5S2FVrCtWa9dw7V3lr1dOwb5R1Hophjl/B7Z0a/3ZftRB4Jl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MKgyE5Ci; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oHVgbi/z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MKgyE5Ci";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oHVgbi/z"
Date: Fri, 29 May 2026 14:21:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780057299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lk6J8Yay4yJw29ZMp1a44IgTYA3zIlsMamRU59bPHEk=;
	b=MKgyE5Ci4fmUYnA5JOEnB4n4ljFf5Au4EUx66ry6llbuCwmprN1bF9bi91TPTzfqcPG/rh
	UdAaxjYkl26wGci7upMeJXE4aQsyKimpRJKJgu10pRFDT9zDZe+u7U4jFReNbVB4dBmoG4
	+ng4kxcR1YkcKmhaT0vcTbtHI5S4FWmujTC9+qlywDmoNIa2BUEv9NBG1Cl8k7nAhuvhCB
	Rs15yPqHLzolELj25UgKJia8ckEm+ikv2vKE/CMgmAno0K3n3CLwIm7wE49P3BUYDRDKBz
	IxwTtVBWHzfrNu2G0QG1sHHjqzoatLBVyxmMj4OqGbYxf0X7iJojHr7fdvEkeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780057299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lk6J8Yay4yJw29ZMp1a44IgTYA3zIlsMamRU59bPHEk=;
	b=oHVgbi/zFlD1tQdiDiwM6YKnRLFgyzv6Lnl4DT2HVyxg5F/aj3ru4qKlT7az3qQRzXBfv/
	K0fGA1qi1JoTY5AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
	clrkwllms@kernel.org, rostedt@goodmis.org, jerome.anand@intel.com,
	pierre-louis.bossart@linux.dev, tiwai@suse.de,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE
 audio irq
Message-ID: <20260529122137.VZtFvQvw@linutronix.de>
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
 <20260529074816.k1K16jyy@linutronix.de>
 <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>

On 2026-05-29 11:50:18 [+0200], Maarten Lankhorst wrote:
> Hey,
Hi,

> It's been absolutely rock stable since the last time I submitted it.
> I've been using it on my local machine, and the amount of times >100us
> (evasion failed) with and without PREEMPT_RT are identical with
> the vblank changes.
> It still applies cleanly when rebasing.
> 
> The vblank patches are the most involved change, and they ensure that
> absolutely no lock contention happens in the critical path with irqs off.

So that is the good part.

> Unfortunately the status is still same as the time I submitted it before it,
> and pending reviews on the series.

my memory is that you have no work items and the auto-CI isn't worse
than before. The series just waits for a review then?

> Kind regards,
> ~Maarten Lankhorst

Sebastian
