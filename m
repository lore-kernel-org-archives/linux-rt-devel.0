Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B372E06ED
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Oct 2026 04:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791260357; cv=none; b=lHA+CwN7C82AHvNs63/7g3AkCEX2hTzQRip1B3FpBYZIbu4s1k65chXZ5zLERGzB67xr1XrYWwkWOEIgEj5EoUIoKvzFgSfah2H5DakUVXtg8U4h/Sq/4QgntZiA8kUamL8TC75SxDCLW+35uHR8W6xg8EnXZhefHXSqDeenYFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791260357; c=relaxed/simple;
	bh=k3RSUY4fxdXMS3ZnKpvJScrf6J75V/fZ8Jp7axykJk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aENv8NW3++BgphdDj6But5Bby4V1XstznpF5T4sjE485ZlW07smKnZA9jT05FcVvAPVztz+2drZF6muP0G7JPFozGfwxQRi506JWM4JAmpzTfpQdA2S5FGehtdhLs749NzASa/agtbAqiVpuwbxeXtNkht6ZoYAuTGqy6324YQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/OJwP8W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/OJwP8W"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so1689545e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 Oct 2026 21:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791260354; x=1791865154; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b4cq9NsXa/9Ah4XIfTqt/umKWCh8D9nJZ3hIc35Disk=;
        b=e/OJwP8WBqHKfSnSHW+nvZza5jU2UnzFhhACOc9DLYvPPsR+0n0Oq+KA5ziXEPXFuz
         pE+SC7AJZ9DqfHBKWYV6rhylRA1twlaxWfpm3sIbVX4i1ipBV8i/D7vG6kqFtzAWdo+t
         4L/IUco9v8hIrEx9LbsPalbrDa7MSznmbOrkU6vySgJ9DlSMnNM7XryDt6lAV9qqn6Zu
         +p+tA7hRA73zzI7OPGHA2K2Ej3qmLRT/660ECarRS/aVPqP6Vx8ITpe/Brbr2WP4WpWf
         9fB4TpVU63piAuPULQgpe4RilabmFd+nXI8yvKl2A68gvf0CvVoO8ZAZM1lcm8OM60H9
         HCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791260354; x=1791865154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4cq9NsXa/9Ah4XIfTqt/umKWCh8D9nJZ3hIc35Disk=;
        b=Vf+t6L3ldohIvHNusPp/VBYgSUZ3+Dgd4/TDOCRdnRghBmy0PJHGsOHjRHqU3crUkw
         j3n7t19r5uIylDEf3+BRRVMQmqyQyg7eOllcWKCfvWMFqXv5DMwhb5cA3DacLO5zywY4
         jeNr6p1lbOJ8laser3OG5s6FL6Ibpkv/crB4WoVPZ59AO3iHHsRKslWgot6DW6YIWUxN
         6DJGhkfIZ5a2JR3RI0sr7S4f444RQt6/QJmKiwdJTDpP/18MkRR8GF7mqKRey8RMu3ku
         RgZv2ZT9mMKWIqRROmm4bxOUw02LPlCqoRZpVGx4BFuj1pDbfpuAr1uf0TRESKebJB7o
         20cw==
X-Forwarded-Encrypted: i=1; AKwUvBythL4vfcfIsL11m4+jEU4j0h+xCSheS1yfIccQjMYeTM5L0NJc0DIOd+1AMAWWLn5RUY5jw1y6aAP5xjibSg==@lists.linux.dev
X-Gm-Message-State: AFuF++nrtGW2gziEVB9Ozw8389Tt0idGCyWdX7fe2uXU2vQ9pj1esUcK
	rphrnsoYDqSrkfpKWWI9+dFpIjNCVqe7mntG5W4dPpmigEm4KBl2VRKO
X-Gm-Gg: AYBFou1KmxcDrFUqI4wFI/HbE4upBQ/CrZm+s+8SU7MTXwGpe5sp63bgbSdOwf8OGM+
	u+DgwQsOqwa5+woeU7x/w5SsHi6nVbPh+SE4dCtWU4AbCEB83G49KKF0NiBElU8hFxO+n4uvc6f
	Hv9zFsi2ZLpJIc+znISJGHFO7gSm5RovuAQyf05+iE7BE8EUWRIdJvFqgkHMvUU5LaL6FhjDrSR
	M5mnmyQ2keuX2reaRmbEKv3k6QT+LCtll1Racl6nWKQS0pxRT5pzsvYDebqdAwAIvbpST3dXEbN
	FCIrO5ui/ti1FiuswIkfpRC0Su9Eu+qFl3VnBZX4xIs3dO4343zAskFKTE4JP0hI/Zh4hCyky4w
	IvT5zEvg+Z90/uR4iVxjRSPprb3HP20KUOS7S4i79BjWiIoIpidaYCBLBlehaKPzbhr0sGwfqtN
	ZfQFARi6ycBcfKql1vBSFkKX0WChwCCXe2/fAPflsVJcbrY2fIb58EbiA5daYFIYdFeU5VVokwh
	ZVV835Lm0bzHczeDpHcfoDLzKjLsi3TeR60FPug48p357ca2y3FL30G8YBguz1rM9ZR1pgSbmTj
	xlee/SIuUQlzWTMmnV0Kn00k44BLI/HuWw==
X-Received: by 2002:a05:600c:3510:b0:4a0:1c43:3c04 with SMTP id 5b1f17b1804b1-4a17b53e298mr3201995e9.13.1791260353780;
        Mon, 05 Oct 2026 21:19:13 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-095-117-040-097.95.117.pool.telefonica.de. [95.117.40.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1776cfe45sm44826795e9.1.2026.10.05.21.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 21:19:13 -0700 (PDT)
Date: Tue, 6 Oct 2026 06:18:41 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 context
Message-ID: <asR1TaKQJlPFqEvR@gmail.com>
References: <20260930185417.61865-1-kmehltretter@gmail.com>
 <20261004122910.1392318-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004122910.1392318-1-arend.vanspriel@broadcom.com>

On Sun, Oct 04, 2026 at 05:29:10AM +0100, Arend van Spriel wrote:
> Is there an opportunity to reuse/refactor brcmf_sdio_prec_enq() rather than
> adding a separate brcmf_sdio_prec_enq_irqoff() helper? For example, passing
> a can_evict parameter:
> 

Thanks for the review!

Sharing the helper with a can_evict argument is cleaner.

One queue user does not hold txq_lock: brcmf_fws_bus_txq_cleanup()
dequeues through brcmu_pktq_pdeq_match(). 

Lockdep instrumentation in fcmode=1 and 2 confirmed that cleanup enters
without txq_lock.

I combined the helpers, but kept brcmu_pktq_penq() for normal calls.

Karl
