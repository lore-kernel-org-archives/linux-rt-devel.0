Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67B2BE03E
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Sep 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918512; cv=none; b=QiNIaCC9X2hsJHRSfUlIM5b8ylRtMFSG5Qd16RbpnOG211ZUfcg6PH2vSCsdpoEtdla9V7C37Y1Wk7Zzfq60Zdde/D2dUYAtA1HUO+AuNM/sVJ2hbX0fZdk+vJ+DRqFLcXNzF5mS7T9rzexzJK4shCJzdhYD3PKbtnVd/DiIVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918512; c=relaxed/simple;
	bh=30uqmxUWwwZjA2mmV57rJmq7l79ruMZyoiTHZmBLM9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2WsD1/SXqOz14itcRxgmPHCimuPTLLCVqz3Ckow6dHRpvHm/Zf8XNpFhDPOlHeJZcsznwIVGtmLSKIOoZx+tTxOZMYV3tSMetjqpH6PgUzgSsFwLCLjF5qGUI8nqsUNbEiKLfgk8ecW3kwla8oG+Ku3AqdLo1ArrEn1eZDeU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so14036466b.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Sep 2025 09:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918509; x=1757523309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDdwyuaVc8VSTl6NQmoSrQNloKdIcjoMxK537r629qc=;
        b=RBrL9ufLKAUfdJS/L0a6rJvdfpG8wo+1NlCaQ1DnXPigW5Bs+IEhG6IlV9sGvz7ao9
         HlrBPvboRSFR3vwa8TthMW18/az/K+PxHtFuuc9n8MPpEjkqMDL6orx+0E1oVPuLSdMD
         ieJ7r+nn1iZRdy4VqCHqftPP/Eijzu4ign6zuPVVBweoZiDklXb4oPINSO2Og1MCZyJy
         zd73XaSizod1nFz4FOdiPo5t25h3WDZPnJUFaU+h0xLOU3G6UmKn7inYWm+8idz6KBND
         z4x7ZZ0KdjOmapwSiB4Czehsf2QGJ3P97hAOI0QI5DEyI4+7nNTaDCFuedPyWIrRCXLc
         rADQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVjIeOiqg9Df5nBZsPV22b0DhhyOZFpQODLA9avrjwoOg6/Xe+nXHTSTPiIyyc1DLoTLed6loKknUt0bnmKg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0IcI8JSai3rg2a+ARceh81kmVRnC3HWIH22Cc4AsohPhPqYGk
	sI1X4ZUQQ71HGKuj5GpMYZq1egTjhpPqPFmy/i/W9PmT2Qw0PgUbAdly
X-Gm-Gg: ASbGncv55vK8g6CJj/1ONADsooTYOSZ1/pCjZooTnpCO6mM9DlB6i8YRJjQ43BV//tz
	BAXOqqT1x3RE2x8u7+D46AiFuuf9A3wP1EgH74bHJhHL2pIHXHNYwCf91jZ6RmjJShF9Mb9RGmF
	b2O4LBNPw8wCUc+diZuHIiwsvieJyyl6ALJ8THEqY0d7b4TJH9JcX+hI8oiJ4Lkwfb90RYhH4M8
	yf+irw2kC2vhwGdpIELc2qVnQKXJJ6VFOzF40WWHXmxbfG3g5hRT2hVv0AO56a4Aj7uSwsqLtoN
	gz5hSsPXUAlsf9wd0zQzQ/KR9+vRLm1DTybAV080bwMDxknpkohfVwbi0gJmUmyL+mSjfDXWUZ/
	Pfze5tIdIVna4FdnamnxEE0s=
X-Google-Smtp-Source: AGHT+IHj2ea6XeYQe5FG+mFIfrJNdxtnyrHgGC5qizxT1Mt2Lf2mzyFI4yV+cXlZTyes3qLz69Uv4A==
X-Received: by 2002:a17:907:9444:b0:b04:4d7b:9ad2 with SMTP id a640c23a62f3a-b044d7ba932mr805242366b.39.1756918508646;
        Wed, 03 Sep 2025 09:55:08 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0236d310casm1115557966b.44.2025.09.03.09.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:55:07 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:55:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, calvin@wbinvd.org, 
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH 7/7] netpoll: Flush skb_pool as part of netconsole cleanup
Message-ID: <sz3tq6rkykm2565stkd4qhj6k6t5wtd2nwboby47goq32hkfor@xwlmwuy7y27x>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-7-51a03d6411be@debian.org>
 <20250902170938.0d671102@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902170938.0d671102@kernel.org>

On Tue, Sep 02, 2025 at 05:09:38PM -0700, Jakub Kicinski wrote:
> On Tue, 02 Sep 2025 07:36:29 -0700 Breno Leitao wrote:
> > @@ -607,8 +596,6 @@ static void __netpoll_cleanup(struct netpoll *np)
> >  		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
> >  	} else
> >  		RCU_INIT_POINTER(np->dev->npinfo, NULL);
> > -
> > -	skb_pool_flush(np);
> >  }
> >  
> 
> Please don't post conflicting patches to net and net-next.
> Fixes have to go in first, trees converge, and then the net-next patches
> can be posted.

Ack. I will wait until the invalid cleanup patch[1] lands in net-next
before submitting a v2 for this change.

Link: https://lore.kernel.org/all/20250901-netpoll_memleak-v1-1-34a181977dfc@debian.org/ [1]
