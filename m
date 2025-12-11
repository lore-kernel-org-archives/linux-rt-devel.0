Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8312F9DBD
	for <linux-rt-devel@lists.linux.dev>; Thu, 11 Dec 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446133; cv=none; b=VGZV1/wHH55t36MkIPDOfnF6CD9nGx+ol3U5IAjKU5s/NOlPxFiVN9YW1ALxcmRo8zkJ9P8ITtUg4CEZCsyUhXrsFDwQ+0uM2DDkbTvU0mNHX/11oG8WiB0tpjERuVCwmbtPT8Viz58oNgmoZI0Q0irnVkEwUbjhJRPREKpCKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446133; c=relaxed/simple;
	bh=dMpqiFCJMHAu/S8QPIMqKAclh6zs9Butm4v+vxWTzu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjB2KdekP1ae95jGe7+Or46aigtFR08E/66ffEtY3x7kmlCM97KJECt1IwhNr+01o+Lxj5T/U52aWZ1+cAJh6i+Ubj4oM6ypiB0cZTylz8LY30kDBo1cUiDdd4Yxg6PwDpKJlI1QYTX+kC5H8Cds3Wt0AjbSTsriqzhysYtukP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=HvulFSoM; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="HvulFSoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1765446124;
	bh=dMpqiFCJMHAu/S8QPIMqKAclh6zs9Butm4v+vxWTzu0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HvulFSoM3N2nKQW39FmjmTaowyywmfU5JBjzT47ZA1TdF9xJa/sYNTd8/k4wEBW+s
	 Y5k9JFF+AkTArJmWMsIGlAZYLPyxLhtFv3HkauF5ILghphcSZXbqQGnIl9nwmZmApe
	 TtfZgPkviZyqSIIfc3rWzf00YlV7P00YE19SvE2B6xgoxa8JLbDk5OR0g1oX07U2TP
	 KnpW4WBIswLLCI4IyJ+o9kpDk7FND8jjEWdmCQ0nbZ2dJacHnp30oXx7bIfI8FbT14
	 mVT1IRa+jLbfGqLJ1lz1LYu6ZoziprrDv4E0sRca4oE2xU4coh2XspEFDwZKMRseEq
	 Vbr0zd3GwNvsw==
Message-ID: <d6c4af43-0b79-4d4e-980b-0135b05da74a@lankhorst.se>
Date: Thu, 11 Dec 2025 10:42:02 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/me/gsc: mei interrupt top half should be in irq
 disabled context
To: Junxiao Chang <junxiao.chang@intel.com>, lucas.demarchi@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, airlied@gmail.com,
 simona@ffwll.ch, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, daniele.ceraolospurio@intel.com,
 alexander.usyskin@intel.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Matthew Brost <matthew.brost@intel.com>
Cc: baoli.zhang@intel.com
References: <20251107033152.834960-1-junxiao.chang@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20251107033152.834960-1-junxiao.chang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the patch, I pushed it.

I also added Matthew Brost's r-b, as I submitted this patch separately, and b4-am recognised it as the same patch.

Kind regards,
~Maarten Lankhorst

Den 2025-11-07 kl. 04:31, skrev Junxiao Chang:
> MEI GSC interrupt comes from i915 or xe driver. It has top half and
> bottom half. Top half is called from i915/xe interrupt handler. It
> should be in irq disabled context.
> 
> With RT kernel(PREEMPT_RT enabled), by default IRQ handler is in
> threaded IRQ. MEI GSC top half might be in threaded IRQ context.
> generic_handle_irq_safe API could be called from either IRQ or
> process context, it disables local IRQ then calls MEI GSC interrupt
> top half.
> 
> This change fixes B580 GPU boot issue with RT enabled.
> 
> Fixes: e02cea83d32d ("drm/xe/gsc: add Battlemage support")
> Tested-by: Baoli Zhang <baoli.zhang@intel.com>
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_heci_gsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
> index a415ca4887914..32d509b113915 100644
> --- a/drivers/gpu/drm/xe/xe_heci_gsc.c
> +++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
> @@ -221,7 +221,7 @@ void xe_heci_gsc_irq_handler(struct xe_device *xe, u32 iir)
>  	if (xe->heci_gsc.irq < 0)
>  		return;
>  
> -	ret = generic_handle_irq(xe->heci_gsc.irq);
> +	ret = generic_handle_irq_safe(xe->heci_gsc.irq);
>  	if (ret)
>  		drm_err_ratelimited(&xe->drm, "error handling GSC irq: %d\n", ret);
>  }
> @@ -241,7 +241,7 @@ void xe_heci_csc_irq_handler(struct xe_device *xe, u32 iir)
>  	if (xe->heci_gsc.irq < 0)
>  		return;
>  
> -	ret = generic_handle_irq(xe->heci_gsc.irq);
> +	ret = generic_handle_irq_safe(xe->heci_gsc.irq);
>  	if (ret)
>  		drm_err_ratelimited(&xe->drm, "error handling GSC irq: %d\n", ret);
>  }

