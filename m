Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00BDDC3
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Apr 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478965; cv=none; b=mwd9wI0d2fNILU2dbPvFahllx2hy1B1LNI8KYiYtDVHp4Z5OxDnbdmcq+zO91YztYFnjILneY4wpp9aRMVthARbWZiiKEbtH5pB6gHC4nR+HZSITPVXmDTzhExFbwrc6AxbPvFfEZHup1LFNetcAazE2r84EoHYvZPp9YetJvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478965; c=relaxed/simple;
	bh=zkhUNRFxN1wVZxu5dT7cU/HABXTx8rHe+Sl1o/dwW24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHdNubt6CcqpC4hLhX6Zhh1SnrQjquv1yzhwFMiNnCUQ5D83C6mLcHfy3w0cjGLkrpBdvsa/wkR44LM+XlPWjOrsXf+q1q5GJIefy4wkmoSlVZz5savhO5CYRpA04N+p4DQLxCzrebrgNlh+yAXNWFtKMVwFOtCH530++ztmqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=toHVGeMe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IsLUglRE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="toHVGeMe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IsLUglRE"
Date: Thu, 24 Apr 2025 09:15:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745478955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2PCGrdmxoQ3SbHA+7E+kNOmoS0qvn21yo5rrDA+j3rw=;
	b=toHVGeMeU2cfiS1J7qzC0zNuHQNrnhoBv7pm+YyFA3l0Mqtw5VpFwwyrR8ACkHbSMh8PUZ
	bRVRhtLFL7PudO4ZIEFTTQ/J5srMRBTxCT/qAgA30CLEX22Kv1EpEIZX9ZWiNwX6MjcEAz
	RCgJYeR8dj17UUs2MeSz9pP1GOLkmEW9PF0pqfJGKgmrF7YmCDMabd5gNpxAu05vIaGx3T
	uTk8WkvgRXlPgXe8o4qoF0nDoyC/TCBUGyvXAcMrmh9MVmF5vA5JWpmytYFWDbMdRvUgWV
	nPPhD9aWKvF5NzI/jNGBRAiMM4MrxlvDJd8IRKmA3NCIm5mcvp+y0pAB8aJ43g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745478955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2PCGrdmxoQ3SbHA+7E+kNOmoS0qvn21yo5rrDA+j3rw=;
	b=IsLUglREf3JqL+7nt64O8XhbXk70GcRbLMhGRAWmAsPhBPqp+BJcAtp61Q84B7+dvXom/5
	Rc9wphuvfPmPqMBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] drm/i915/gsc: mei interrupt top half should be in irq
 disabled context
Message-ID: <20250424071553.yT9-dWWM@linutronix.de>
References: <20250424065609.624457-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424065609.624457-1-junxiao.chang@intel.com>

On 2025-04-24 14:56:08 [+0800], Junxiao Chang wrote:
> MEI GSC interrupt comes from i915. It has top half and bottom half.
> Top half is called from i915 interrupt handler. It should be in
> irq disabled context.
> 
> With RT kernel, by default i915 IRQ handler is in threaded IRQ. MEI GSC
> top half might be in threaded IRQ context. In this case, local IRQ
> should be disabled for MEI GSC interrupt top half.
> 
> This change fixes A380/A770 GPU boot hang issue with RT kernel.

This should have a Fixes when generic_handle_irq() was introduced. 

> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_gsc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
> index 1e925c75fb080..9c72117263f78 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gsc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -270,6 +270,9 @@ static void gsc_init_one(struct drm_i915_private *i915, struct intel_gsc *gsc,
>  static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
>  {
>  	int ret;
> +#ifdef CONFIG_PREEMPT_RT
> +	int irq_disabled_flag;
> +#endif
>  
>  	if (intf_id >= INTEL_GSC_NUM_INTERFACES) {
>  		gt_warn_once(gt, "GSC irq: intf_id %d is out of range", intf_id);
> @@ -284,7 +287,18 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
>  	if (gt->gsc.intf[intf_id].irq < 0)
>  		return;
>  
> +#ifdef CONFIG_PREEMPT_RT
> +	/* mei interrupt top half should run in irq disabled context */
> +	irq_disabled_flag = irqs_disabled();
> +	if (!irq_disabled_flag)
> +		local_irq_disable();
> +#endif
>  	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);

What about generic_handle_irq_safe() instead the whole ifdef show?

> +#ifdef CONFIG_PREEMPT_RT
> +	if (!irq_disabled_flag)
> +		local_irq_enable();
> +#endif
> +
>  	if (ret)
>  		gt_err_ratelimited(gt, "error handling GSC irq: %d\n", ret);
>  }

Sebastian
