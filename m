Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF4026AEC
	for <linux-rt-devel@lists.linux.dev>; Fri, 25 Apr 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568052; cv=none; b=OL3e3FyRdHQTPLwk1uaimNKckDnxuwrJzpm4rljxdhgt29jlw9EtTxeb2PPJkw+ImgZ07BHcq726ZcKjKszUJgsG955ax2nhb4k1KNhs+H6SxnNXkIZN3cxqSXTy/r29s/SovTYRIc09pLamg4FWmkX6fsFRE6RQ9Az8zvyL1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568052; c=relaxed/simple;
	bh=c6TIoXsjX95rpwlTor+k+SVGfkqfhOsAsRW9lkoCB+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p9rxQcNeTel/yJOALqxqGu+UKT/CfQwMheS6PlzYeo1IU/we6WKhFkOyKbah5DWz4S0TkLuNwypO5q1dtXCNbKW+vdEjDiWwdHxAguDpnrwXrmCwRlkuYpyf4dFd+g65p0Y7HcN3WOuNSJIrgD2pUPxnCjGWDOA2cxUqgM+qcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAXOvlue; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAXOvlue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745568049; x=1777104049;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=c6TIoXsjX95rpwlTor+k+SVGfkqfhOsAsRW9lkoCB+0=;
  b=YAXOvlueCNDGJ5XzvkU+RwF6scX+ij4py3YeYsv1aU09LqYh7k0wH7es
   3Saon7weds9IlqOgFzfI6G78FBvMyvCL+ILf2u6cA8t4ZOE+FoWsZ9fMM
   EWL/TikJa9wBS6mHtYCM/Do6AIb4Yphku6bIuTCR94mDkz0Evkk4ip9+Q
   gxxWp//HFV7uJiqnzCYsftZ0lMSlJ2UGPJM4sYlKPj3A7sDu4a32wKx7z
   TWtm7Xikxt9WsoEM+CE6z/4MTDG1IWSVX+NXmcFHQyvJa9f2o82ruc8Pg
   m3lmUJIxCYKO/abcq8FMJhe2eqVLoMyYHYaLwKoPs4wnsk9q5jJlYVJos
   g==;
X-CSE-ConnectionGUID: caZ9e4l1SzOWSJbwe2GLuA==
X-CSE-MsgGUID: gtjTY10XQlys8bzduI5XaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57864546"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="57864546"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 01:00:49 -0700
X-CSE-ConnectionGUID: Puj2tsmFRT+bEnbXCo9i+Q==
X-CSE-MsgGUID: 5mh8FrHBRICDDfsPHBC+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="163897606"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.83])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 01:00:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Junxiao Chang <junxiao.chang@intel.com>, tomas.winkler@intel.com, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Daniele
 Ceraolo Spurio <daniele.ceraolospurio@intel.com>, Vitaly Lubart
 <vitaly.lubart@intel.com>, Alexander Usyskin
 <alexander.usyskin@intel.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: junxiao.chang@intel.com, furong.zhou@intel.com
Subject: Re: [PATCH] drm/i915/gsc: mei interrupt top half should be in irq
 disabled context
In-Reply-To: <20250425060455.641008-1-junxiao.chang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250424065609.624457-1-junxiao.chang@intel.com>
 <20250425060455.641008-1-junxiao.chang@intel.com>
Date: Fri, 25 Apr 2025 11:00:38 +0300
Message-ID: <87v7qsy8k9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 25 Apr 2025, Junxiao Chang <junxiao.chang@intel.com> wrote:
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

What is "It" in this case?

> +	ret = generic_handle_irq_safe(gt->gsc.intf[intf_id].irq);
> +
>  	if (ret)
>  		gt_err_ratelimited(gt, "error handling GSC irq: %d\n", ret);
>  }

-- 
Jani Nikula, Intel
