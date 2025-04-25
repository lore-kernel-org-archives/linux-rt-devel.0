Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87324EAA3
	for <linux-rt-devel@lists.linux.dev>; Fri, 25 Apr 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745584730; cv=none; b=NVTG0R9ZbBbjulEy5y8ysgGPAmSrg1MujduDCbqQS2wnv8elMSVuw1ltQi20M1cRErYwbAGL0hPs6d/Edd2JavB6kBdFzrTHmEtiEFTmpx0CfyCcNm45beDYnChN1XBBUjMn9vDpiLlcZez744FH7vMTVFk6QOeNiTfx+5qHt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745584730; c=relaxed/simple;
	bh=UaEHjkrav58QzWEQYJ3psAW3X/7Q8vaktivABWGQcAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuIXxxVHPPfPXT2JNxGJyLRm+3GsZSxm7gZWZoocQIWsfzW4cTgS7ZbGsPCLzWele8MgGIFFr+Q2f9H2+G5Fwgn//wS523kcfic9/3YYtYkKRev/iTFbPTMWNJVibKL6TgyxZb1kkJkdeY3JGaCtHs2nmISBuwsYKyC06Gkd/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1CZVFk+W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uvV9jF02; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1CZVFk+W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uvV9jF02"
Date: Fri, 25 Apr 2025 14:38:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745584723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZPyv4uLm5m3lXM60eeBAr4Pa+FEkY9VUO/+vDhA2yc=;
	b=1CZVFk+WgcPK0XTsQZeAunbgSImetLhsoemPz2Kb8gWyMQb1tVcgvWiAIchz8/KaReQz7r
	t16SJI16RlN6LrUnoKM3imcJK5xtMg0CyKw/sPX27aXpUXy5Fd6wuZQVUQX/ZbTbx3thuf
	MfLGnOE/BufmUbHRy4Tl2GeQ/hHSltNzzasyWv7QIejULq9teCtGay81sXdQlRV1CbaGUm
	gIMHRm7NQS4XQ8tMyZHwz5ROGG6Vl1NqvHBxR/K8ZUcHLchMPzO0shx1JtKsegIvIhMd1m
	pLBBEEnqq86k4Xb4WqD5db/pezRAQFyPQcuiYbzW4qXZkw15fSy11WnL65C7Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745584723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZPyv4uLm5m3lXM60eeBAr4Pa+FEkY9VUO/+vDhA2yc=;
	b=uvV9jF02bncF/kDggrxemt3avEtt6IamggWWaLp328TjyEhiNVI8+r40LaZNc5N2HFORQq
	PtaQyTaD8O9eK9AA==
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
Message-ID: <20250425123842.pXx0RJJU@linutronix.de>
References: <20250424065609.624457-1-junxiao.chang@intel.com>
 <20250425120444.642779-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425120444.642779-1-junxiao.chang@intel.com>

On 2025-04-25 20:04:43 [+0800], Junxiao Chang wrote:
> --- a/drivers/gpu/drm/i915/gt/intel_gsc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -284,7 +284,8 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
>  	if (gt->gsc.intf[intf_id].irq < 0)
>  		return;
>  
> -	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
> +	ret = generic_handle_irq_safe(gt->gsc.intf[intf_id].irq);
> +

that extra line looks odd, other than that
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

>  	if (ret)
>  		gt_err_ratelimited(gt, "error handling GSC irq: %d\n", ret);
>  }

Sebastian
