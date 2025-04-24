Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53AD226888
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Apr 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492845; cv=none; b=J4sbaVSKzTBKJH7NprXeQD33QFFKM8nKHnaWwMYvN2ebLJple5/ZQEQL81f0uDnygALhOs/4tsxxTG63v1SqDuAcrQ1IX89c1UwdiAfzm2nyR4eoxVp8w5ZKad5WR8LIYv5pgYZilUitL4pr9LHu3BzAY1V15wjqvQtYQ2+Fp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492845; c=relaxed/simple;
	bh=r8UZ/Tr8XFBGpxb6rMI9tPh8zudbagKkA5ZM6wlikU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovT3BXnB2F0ft3a2s4Lm2sR9yvKBasmCMsxmYEjEpz7g/oAwFO0klyiL8KYzZfjsOlaol2lIDIeNc1/37W/gDXNRsDvRk0W7Rol5o4t8Rf17jfBVXb1tt50mCJF2tiq8PmlkWDmEdiZ+Xtyd3rKdYhXSZLxYfJjOOQ3SPbiuJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u9AdSKBB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tMEeZJol; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u9AdSKBB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tMEeZJol"
Date: Thu, 24 Apr 2025 13:07:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745492841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WRJsuHkDetOeCN8MPWHiqr/L5HQKRxuly+CBMzqRXis=;
	b=u9AdSKBBB5CcKRicReLrZ4FapV3FfC3Qi902J9m+SA6U63wiwB0idV+Ms1RKnwSDsGLWzG
	XUaaySGdSI8E52xU8UfwE1imvcrdGFQLcbp+2XdbjYs0kJX2CESzNoLhFrcDq0ooxC+/Nv
	IN8aEi+AVM7QmzPqzfMAjLJwTAMNioSHQwf211fFRkqYUP+cmTzzfBd2sMTWz0VgJO1sKd
	fjlgzkC0Ri3j+kMtzgU9+LQL1qW1vPanMeR42m2o8FUfkde5ubOhnbb+dxaV4lUnoA5qJ3
	CbErxpKCQb7ki4ohy4gddVl/ENF4Ext9xu7XWAhRMx2W+1bJU8uOvUTj+CtoaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745492841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WRJsuHkDetOeCN8MPWHiqr/L5HQKRxuly+CBMzqRXis=;
	b=tMEeZJolyjLH6TovceH/DF/Ix/DrWOhmw28qzshSH6VlxUcj1rO7fWTiJ3QfMvfSeVxug6
	0ANGOGJa70Jf2jCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Chang, Junxiao" <junxiao.chang@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Re: RE: [PATCH] drm/i915/gsc: mei interrupt top half should be in
 irq disabled context
Message-ID: <20250424110719.A8HbMKQO@linutronix.de>
References: <20250424065609.624457-1-junxiao.chang@intel.com>
 <20250424071553.yT9-dWWM@linutronix.de>
 <87zfg6yq1k.fsf@intel.com>
 <BN9PR11MB537042DD2F672D85765565FAEC852@BN9PR11MB5370.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN9PR11MB537042DD2F672D85765565FAEC852@BN9PR11MB5370.namprd11.prod.outlook.com>

On 2025-04-24 10:53:31 [+0000], Chang, Junxiao wrote:
> >> This should have a Fixes when generic_handle_irq() was introduced.
> 
> If PREEMPT_RT is disabled, original driver works fine. I prefer to not
> add "Fixes:"?

PREEMPT_RT is mainline. It deserves the same fixes as other parts of the
kernel.

Sebastian
