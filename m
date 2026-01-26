Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB1133D51C
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437337; cv=none; b=qn9GbpJfmbqcEQChz4fKOSh8/TH/7dGsToci30Sy4hZCdmMCTHheQdaH09qjshx7liiwDhpQU3/2kGSEq5m3rjzEg1DYUk5gCtVt0T5rz8FXCR1v9wtnf0lwxaumxBwmIrKHyoKASa22yybwYXJfTjfeBPeSJpTWbjSqIvpKoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437337; c=relaxed/simple;
	bh=YyOwNrDhHyhIeuNrfjmrB/sotm26q39JXO8vlFcE7l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6eXlyqlAN2SBfbGW07arFfG360HeE6xvzANAoiZhrVzc/i7sQCs6QLholk9itszVkM70+iEXCEN3u4Oo0/eXaWCJIY0BbNwxaHusmlDiQ6JkAvGl95g+yPN8E/ZDBcSGJv1UAIRfKYqD7ZImyD9mCbK5g/bs7rSel8/GNiTG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDJgC/Ix; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDJgC/Ix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769437336; x=1800973336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YyOwNrDhHyhIeuNrfjmrB/sotm26q39JXO8vlFcE7l4=;
  b=IDJgC/Ixpag6M2Oi974b45yvpUrgGtFaSTFJszoQPBkaljGx4PHAb8Xg
   BZVyUecnxocbAczLJwra1RbXikYOIMiq7SKjxVxrFGEDzDPiQRNaCQO1V
   ckeh3miiGxZdvLDlpluhcF4nQ+akvxsmgee2KPK9kMUMES1+l9qL1I7db
   okZUijrw44LjZyZAqOWGqF03K4pe9ODkeUEKydOlCcYOsPjxbgjGccFCa
   eSCG4SkJc/gg6LFiG8tVbvfM1SsQV74F1GfoL6j4KuzKvBVPzMblXEKDq
   Umbe6PjI0E9K0HBqcZYGQjE89ED1L56dIAU5FlCzjFW0pwj0FsN0XZlMS
   g==;
X-CSE-ConnectionGUID: mylCBWIwQUWvq+7RRRsfUQ==
X-CSE-MsgGUID: DrIJRqg5TeeEBIQSnAzVCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70517202"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70517202"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:22:16 -0800
X-CSE-ConnectionGUID: DDNU3I6gSR6VUUhjWFKMDQ==
X-CSE-MsgGUID: XB9p31RxTF6rqe0+orXf1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="208116586"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha) ([10.124.223.78])
  by fmviesa009.fm.intel.com with SMTP; 26 Jan 2026 06:22:13 -0800
Received: by kuha (sSMTP sendmail emulation); Mon, 26 Jan 2026 16:21:46 +0200
Date: Mon, 26 Jan 2026 16:21:46 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 13/21] usb: typec: fusb302: Remove IRQF_ONESHOT
Message-ID: <aXd4ei347Bv6GwCU@kuha>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-14-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123113708.416727-14-bigeasy@linutronix.de>

Fri, Jan 23, 2026 at 12:36:59PM +0100, Sebastian Andrzej Siewior kirjoitti:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> Remove IRQF_ONESHOT from irqflags.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Fixes: 309b6341d5570 ("usb: typec: fusb302: Revert incorrect threaded irq fix")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 870a71f953f6c..19ff8217818e7 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1756,8 +1756,7 @@ static int fusb302_probe(struct i2c_client *client)
>  	}
>  
>  	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
> -			  IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> -			  "fsc_interrupt_int_n", chip);
> +			  IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
>  		goto tcpm_unregister_port;
> -- 
> 2.51.0

-- 
heikki
