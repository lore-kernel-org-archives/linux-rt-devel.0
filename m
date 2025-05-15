Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856DC298CA1
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 May 2025 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313353; cv=none; b=pTmE7wE3PQuSkc+Ev78w+oSGWrkjBWXiTLwusUm0Z6/zs+Hwx24bxxCBuXVSuHaMiSs+GN5P4yW1G5BEfyMEcnhYkKGIaVAkQpQ7Zj61T3v/MEwY4M2dnh+qSo9dsa5g/DrrD3Kzhb4clBdoHGg5chL/4O0P7Xv5U6VQs+xiII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313353; c=relaxed/simple;
	bh=dCbb8ywsZWcjBClreW7efNTzbOoYTzghPq2VmBHjgqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P84p/9k+OrwFuL2fFramw1sabH3oAYhrPoho0qOkfO54AxxYyL7yrdTT4KNFBAHAocb7bxgIkQujNcaTRaYd38Vm/CwXIDlLjKRPdVNS4ecbfc9qJ2CPCpZMnMFeiZr/jjTzNnYGDX2MFMlOXI9OusUFPvNmLR4XQnCQxbUlu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUlgD8M+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUlgD8M+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747313349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7XavHWSM3i2z8lTnk9nHsfzQ0iU3Bzb+tsiNPqcmRY=;
	b=KUlgD8M+k1+SPVADu8KnL9IEk/k7G7FTaP+R5Au4wVzN+eFkbIg2gUwuVyg4GDqpNyuxts
	C/SUI3n3lQswc5ALEuumseE6w0KgEdtmWlFrXxnltH6YKmSkpG53TcCf9J6yAvr9EFEwh5
	tFXyK71/EaUcmtR/TyBNkKat4yBv1u0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-wGCeur7kNTqVjCBI-nXkUg-1; Thu, 15 May 2025 08:49:08 -0400
X-MC-Unique: wGCeur7kNTqVjCBI-nXkUg-1
X-Mimecast-MFC-AGG-ID: wGCeur7kNTqVjCBI-nXkUg_1747313347
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a205227595so460369f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 May 2025 05:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313347; x=1747918147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7XavHWSM3i2z8lTnk9nHsfzQ0iU3Bzb+tsiNPqcmRY=;
        b=o2NwrIsSqZ3L1N+R6Q24U8sKDl5zQMS6e2DfhxzneYvi94nDXlTZy3kwQyNXypUarh
         swBaMMiBfUQ1WD4xDqVTuBNlSNcwUQX/mOhiKfuvZYDFZkPxFiiH6nEVeeVCYQhCgD7Z
         FJmPPfAyvOPPbH7gIyD4RniGPLw9mgqDWJtforbzqpHpDaIqrqWi8Wz4j6LwBhqw1OSS
         Il78EYLBMz81c/cb4U60jT1XkzwYZmJNpF5voXWSy3De/xY/2aWj+QvKI8wIVAZFDfor
         4c/NTWjCiTctvtQWXUQtnMyfexEuMrmwaq+Zt14sV5GwFQIuJ2p95psW2CeeM2rHNwAv
         4v6A==
X-Forwarded-Encrypted: i=1; AJvYcCVXRuN8CxPDrhiqFdH+arEUhdrXVKr/JmN++OSpTSP80DuLQhjDTmlH0Lg79GJhy2+YYwUX8C3frLoL079hdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlWohOyi7CAuyuRd4IaZ0wuhd+9qPtmYVv6kTbULx1jrHmwTmj
	QM75N6AEX4UtQX4inDo+VJGRSnZMOVHF989GFx/E+yJEcaddf9gdDg2/3reY94tuVwRfc7OiWfQ
	u1JzQ542/ttX07WaZUNRwrt/l+W6gvQJxRISrbXcMKLeKzQA6cbPTqDKNW6WKnb74
X-Gm-Gg: ASbGncsAcaTQ/V61zAL/KS3fJDLlinw0tc4eWyw0br9QX77LBHUoqnSm9Nw4li5sd0y
	Az9yeeUF88q3jdrdsVTbipVyvLW1DE6aSZci16poqbct+7ZnYuRcDJzh+ONVM9YKFQuFo/caOam
	a0qct1G4z7ha0wm7QN07ckgkXTKL5shjUTZKty3tf5iJdV1lQT/ygAsIWB2zWayZiy4398Pn1wq
	3LpTmsGb4YN9pULdhreasuGHGGp5Sp2oVQTJiCTxb7PP0ntLyqOfsjykKcNUZqcewLnwWpEWf4D
	hqcfBCSC9Yp3qETsq5UyVoohsmh8+n9GtY+3Bcl3sA==
X-Received: by 2002:adf:f909:0:b0:3a3:55ee:8658 with SMTP id ffacd0b85a97d-3a355ee86cbmr1329998f8f.0.1747313347154;
        Thu, 15 May 2025 05:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0z8Z4IWABZZNTzRaHczvZipon+iso448bnAeHeqBaILeA/0ES4MK3K+jZgSD1fRZNH+rKXw==
X-Received: by 2002:adf:f909:0:b0:3a3:55ee:8658 with SMTP id ffacd0b85a97d-3a355ee86cbmr1329971f8f.0.1747313346769;
        Thu, 15 May 2025 05:49:06 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.93.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f8csm22339420f8f.42.2025.05.15.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:49:06 -0700 (PDT)
Date: Thu, 15 May 2025 14:49:04 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v4 10/15] net/sched: act_mirred: Move the
 recursion counter struct netdev_xmit
Message-ID: <aCXiwEVJ8sLJLzxc@jlelli-thinkpadt14gen4.remote.csb>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
 <20250512092736.229935-11-bigeasy@linutronix.de>
 <235b93a5-6989-4131-9099-c0c03bb6afc1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <235b93a5-6989-4131-9099-c0c03bb6afc1@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wdM-lKtZPk4gXRfVRZblgukthS7zmqjem1PkjPCu0Vo_1747313347
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 15/05/25 11:55, Paolo Abeni wrote:
> CC sched maintainers.
> 
> On 5/12/25 11:27 AM, Sebastian Andrzej Siewior wrote:
> > mirred_nest_level is a per-CPU variable and relies on disabled BH for its
> > locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> > this data structure requires explicit locking.
> > 
> > Move mirred_nest_level to struct netdev_xmit as u8, provide wrappers.
> > 
> > Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > Cc: Jiri Pirko <jiri@resnulli.us>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  include/linux/netdevice_xmit.h |  3 +++
> >  net/sched/act_mirred.c         | 28 +++++++++++++++++++++++++---
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmit.h
> > index 38325e0702968..848735b3a7c02 100644
> > --- a/include/linux/netdevice_xmit.h
> > +++ b/include/linux/netdevice_xmit.h
> > @@ -8,6 +8,9 @@ struct netdev_xmit {
> >  #ifdef CONFIG_NET_EGRESS
> >  	u8  skip_txqueue;
> >  #endif
> > +#if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
> > +	u8 sched_mirred_nest;
> > +#endif
> >  };
> 
> The above struct is embedded into task_struct in RT build. The new field
>  *should* use an existing hole. According to my weak knowledge in that
> area the task_struct binary layout is a critical, an explicit ack from
> SMEs would be nice.

Agree. Still fitting in an existing task_struct hole.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

