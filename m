Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2551AC458
	for <linux-rt-devel@lists.linux.dev>; Fri, 25 Apr 2025 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569652; cv=none; b=mK+Y8lxKGshh9ssAH3zCX+TMN07FV3/4qperfd6kjMQe7lO1eUGCXIac9LH6ZXQL9owyacaXQw1luv/2e0H3ZYrVKsOYXAdfBHcWB7F/6N9tAPtRWmTfL400Viai7woGEzKnVxfsY/GIQVS8W3evyEdvF7sFqph/YSMX90WhhAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569652; c=relaxed/simple;
	bh=dj0VyeZM4DQ+yC1nQ6mYmlEHFimAQiSWDvopuv5UeSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvjINvwQHuIIpZCAn3p25r60ApablYUOQXTz6VJz35zSua6BdlzU0BYv8YULhfbI9OagILhczXxZIOKmIQ9L4rRXkM4HAtjnrtRuFr5mz710X/NuZt0+ViLoOjy0p9g8fPTsQiVCfu68hCbrS85/QYERBwsQN6WPhFo6Jkl0zA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZBKIpvw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PVOi/gi6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZBKIpvw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PVOi/gi6"
Date: Fri, 25 Apr 2025 10:27:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745569648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwKc8vWDzsGShvSx8/ujEE3vSUGRy3MUCHV+p+G4yOM=;
	b=KZBKIpvwvkXoKwK4SyKQlVDvDURRV3Awgp4XWdhfCQ/kvw4/+prjS74f+0cfZTiCNThQHP
	SUZTrzh1MqpfaTFgfxOL/Afi+rwNmZBqAPsv2g7rI6q/eRAAMqF2FarnHsoyOcQuHdCyoh
	JCVgXkCcXxVT8EVeE7hjmKgkDN1X2oDZheVA/sMvcomZJO05Kb3ph6BW+cf1N/4lTVqsG1
	D0l1Pu/1LwDemaCW6wg55nnXsE+qCHjQaaWHitNqZ5dUh6k9Lx+iazIsojLEVu8xtKAUQS
	6A4nYAkyLYUS9okHgSGVkrl/mJlkNdjsLYFG7qzUqU/95ezUtQ4pJzWp43THjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745569648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwKc8vWDzsGShvSx8/ujEE3vSUGRy3MUCHV+p+G4yOM=;
	b=PVOi/gi69ZVtKyEIcPPxTfvtIYIfLesnLQgo3tRdrBwYTCpNcLJHYy2PtD0qW+oqfHAwhV
	QaQ37ecJPxP0TNAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: tomas.winkler@intel.com, Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	furong.zhou@intel.com
Subject: Re: [PATCH] drm/i915/gsc: mei interrupt top half should be in irq
 disabled context
Message-ID: <20250425082726.Z3fE3m9I@linutronix.de>
References: <20250424065609.624457-1-junxiao.chang@intel.com>
 <20250425060455.641008-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425060455.641008-1-junxiao.chang@intel.com>

On 2025-04-25 14:04:54 [+0800], Junxiao Chang wrote:
> MEI GSC interrupt comes from i915. It has top half and bottom half.
> Top half is called from i915 interrupt handler. It should be in
> irq disabled context.
> 
> With RT kernel, by default i915 IRQ handler is in threaded IRQ. MEI GSC
> top half might be in threaded IRQ context. generic_handle_irq_safe API
> could be called from either IRQ or process context, it disables local
> IRQ then calls MEI GSC interrupt top half.
> 
> This change fixes A380/A770 GPU boot hang issue with RT kernel.
> 
> Fixes: 1e3dc1d8622b ("drm/i915/gsc: add gsc as a mei auxiliary device")
> Tested-by: Furong Zhou <furong.zhou@intel.com>
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_gsc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
> index 1e925c75fb080..a099d885508ac 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gsc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -284,7 +284,9 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
>  	if (gt->gsc.intf[intf_id].irq < 0)
>  		return;
>  
> -	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
> +	/* It can be called in both irq context and in thread context */

I don't know why this deserves a comment. However, generic_handle_irq()
is used from the IRQ chip, everything that signals the interrupt. This,
if it comes from an interrupt handler itself, should use the _safe()
variant. It used to be a issue also with threaded interrupts on !RT but
for other reasons this is no longer the case.

> +	ret = generic_handle_irq_safe(gt->gsc.intf[intf_id].irq);
> +
>  	if (ret)
>  		gt_err_ratelimited(gt, "error handling GSC irq: %d\n", ret);
>  }

Sebastian
