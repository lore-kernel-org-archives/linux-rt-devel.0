Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F14366045
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Mar 2026 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709553; cv=none; b=kondFkK1nwh4PW3W0XVdYS3oRYtF9J+kifeEQGYNDk2edkZTqalCchoP1pNYTlDh+GRXdIEWnhGsyki9Cle1jbF2gcWfGO0ba5G81IbMYuBqoafP233/jkTzkKAUoOd3yCQXlKd7hIxGh8mc384x3IQYbGSoJgTX6g6cJGaH40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709553; c=relaxed/simple;
	bh=OLOVNLzkgKZr6pl7bNGGllfA0IdilTf9V2IBstJHMXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GupMnyPAg/wd2OR6BskkssGH5O3c41xMNaCt2VY8MZghcxKzVfl+GuebRPDzRONdW+kPsm7uiep2sQPaPXf/+qKubSMPX75W2i+Cql5he/1WtAwtHRmYF8uqWCRykTO/dJ0In4eqjjN+NTQKHq/YTAhsBEzOSyJIij1a1APf5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T8jnhV/g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2wGBiOL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T8jnhV/g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2wGBiOL"
Date: Thu, 5 Mar 2026 12:19:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772709550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLOVNLzkgKZr6pl7bNGGllfA0IdilTf9V2IBstJHMXA=;
	b=T8jnhV/g40XG8LivknAXA2L9jKfffKrA4x+FA/twWq3hm9NOP2mPYZNCKwe+76ZnRjWQDs
	2JJWvHfur49km2Zsq4DM7hYMwN0E9oec1e4VQqeS6qV42jcASvV/7B3uOCQ43F8INn48nT
	E968kk7X6w1kXwwjDQSx4d914ekRCtJfRbiXb2bfXC66EKGeQPXCZA5i5ZvHu7An9vkaco
	etYZLqjjw5I3jH183WPA9g6BCOpPA2zhW457pwvkAWjIC3SX/xUidibrO7WYty9aOrLaNp
	8SI9QTw3vdRIF+nYPEWjUQZ77LqH/bGjWgXcAy/C/AdAJPxzHtn3lpOtV47GEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772709550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLOVNLzkgKZr6pl7bNGGllfA0IdilTf9V2IBstJHMXA=;
	b=s2wGBiOLk/C92P1XkAEBUXaztaon2ye+0MCGwIgr+AsIN1xYpdp/iRrjw5MeFCMlrDIO4z
	jhesiWiOHTia9wDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [i915-rt v6 00/24] drm/i915/display: All patches to make
 PREEMPT_RT work on i915 + xe.
Message-ID: <20260305111908.eiL2_aF1@linutronix.de>
References: <20260224162703.Q_taYjEC@linutronix.de>
 <20260224165903.2mn24oQy@linutronix.de>
 <20260225075806.XNtXjZ5E@linutronix.de>
 <7ee8b784-a714-4329-aab2-a571f25c3baa@lankhorst.se>
 <20260226120715.6Ug1Qkse@linutronix.de>
 <20260226141942.Z6vUrEQ3@linutronix.de>
 <20260226143857.4ZJAFzf6@linutronix.de>
 <98af7aba-f86f-4ff0-a53b-60e0e9784e37@lankhorst.se>
 <20260305105022.cc1qAMoO@linutronix.de>
 <08ff34aa-acb2-4110-9dec-db6dde6edd5c@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08ff34aa-acb2-4110-9dec-db6dde6edd5c@lankhorst.se>

On 2026-03-05 12:11:50 [+0100], Maarten Lankhorst wrote:
> Hey,
Hi,

> I think it should be possible then to remove signaler_active, and change
> the reader side to if (spin_is_locked()) { spin_lock(); spin_unlock(); } ?

If signaler_active is only going 0 <-> 1 then it should be doable. Let
me get to this then.

Sebastian
