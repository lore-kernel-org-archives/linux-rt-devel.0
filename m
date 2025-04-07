Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8F1BBBD4
	for <linux-rt-devel@lists.linux.dev>; Mon,  7 Apr 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018414; cv=none; b=TXOfiUbNOehrCooAEgUbnh9BEpdjRzhAXD9yQrVR+NrHUkK4OojGhmhbzun4GWTwO40TWq59ms6E2TNJp8zs1m9kVfWbWEpF5zRoqDtWW8MmD3l7jDYN60aPTz0YW/2RPN7WV1SKVtMWeqOfZowB6rHHT32g2Yblw9PSAP1mJzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018414; c=relaxed/simple;
	bh=tgT1LrnqYgrS5eql63LRpugnK0ui0G5PIUMiBaqknD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C9fPCHfWbPY6QF3DwG7jZdFycujnqD8opbJOFgO1u61YIxmBg/48AwhOrGXAm4mDdOvoXmGaUJvc7wwhXdw6i1e4NE2qN46n/ilkTdstCaXIa54A1vLuudSH930aM+aUMNC6WiPFkETf4kNTRFXIKCnFHcaGZJN005Yd/gZbZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ta9ZLSoZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ta9ZLSoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744018411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=441tE+Tmh6SSSq0pafdr9Ks6zWoEBrFm9sf0mm65S3w=;
	b=Ta9ZLSoZvh/bA7BqEwIfbL4WTtN7v/b8qbak++RQ7pttYBt/HucTmxCD0Vgw7X3OZp6ZuZ
	iGxt1DrKgoWVhCfecuHr70wkaQXk+Fv4J59r2zVlgDdxm/S2aGEvKAKgZpa321QpX6qQJT
	vRFO+uScFzUyfReSQPZJzj0tszsINvg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-d3olvvF5NkSxdB192Gf-Qg-1; Mon, 07 Apr 2025 05:33:30 -0400
X-MC-Unique: d3olvvF5NkSxdB192Gf-Qg-1
X-Mimecast-MFC-AGG-ID: d3olvvF5NkSxdB192Gf-Qg_1744018409
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so23276365e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 07 Apr 2025 02:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744018409; x=1744623209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=441tE+Tmh6SSSq0pafdr9Ks6zWoEBrFm9sf0mm65S3w=;
        b=jSaMZqpbM6yFlh8CuvFxiGUm5FxbswtysAZ8v8S2i36mVvSqpPNzQz1dDXPlplXfKq
         9/x294YmIXA3gmtgiDonQy3tzXB1/kkT9rnjYhcFZ5z6/RuapV4M8qYGF1tZ8szG19el
         SV7rFc0IVzVeIjqHY/RaUc/zteY9jc9EfA4zAQ+y5Xii/c0idSoWzP501uC9Oi83hqQH
         okO0o6prbww9NVlGbFkQ/OJg2T7T6h1tQ5zv4PHk/2bQWW3RqmHeP4ydDKvC6llB2lge
         kgCNUZgMK5C/0q4uHUl7QhFH5j+oxuX1CFpkZTWr5IaFUsI4/XvGgvLdDN5MjH74i1Nl
         92PA==
X-Forwarded-Encrypted: i=1; AJvYcCUnRjwHOKem1weUHQQjrNnYSu4zn0dcsLIUXPpxCAuvJ84ViOlUb8epHfiymS6OtDGlOsZDq1MCB8PyxSraWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZRIUz9yBzvBn2KsJV2W0tRYrQvC3EgiFyqAWaOMduEu8JJojw
	7t9Srx7DC24lDX8NHjOwaPRdcSxgsM8AfAP60jTpEPL81UmyXuudo7+JQYoKNk/tFpxOwBRasvr
	oXjxlpI5W/+Ze4nHrJ/L/DetFUTQKATmk4SxPBm5LuKKIC1fW9l8HqnG69OZBdpuZ
X-Gm-Gg: ASbGncsmhvNGZTAZy1IzC6pDSrEMB1j6aSj9bXSb0KgwDQB9VB6nOAK9H/3i5SmxA9P
	pNbZ/lIYoCXdvg0YBdpePf0J4qZnnLdweGqFNCsASDsucfRJ9NN079dgCvBdE4nH5AsyOXPxfjS
	+3JkggZHoZn2Rufqn93BHmzj55QGRurr9jJi2yl38g1AtiT6ah/79tJJXpKC9qLbCX5K2mt6m+u
	hIeC2R4HA/6aEk8fpGuOjuji5l8qgJbcLj9gYytmkDreQxlA/sU3ia7EmFcB8QLauWJw8Au1OXn
	q6kCCmiZKxs8DA8HDQq7brHaVoAD8k9kDQSARKYRlnK+TaY=
X-Received: by 2002:a5d:6d8a:0:b0:39a:cc34:2f9b with SMTP id ffacd0b85a97d-39d6fc291b3mr6246167f8f.16.1744018409036;
        Mon, 07 Apr 2025 02:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBolTQSF/57rvjzSXqBYXmJPqcsNVa8ShQLgffhCmYqYrNC02OtDRXnbbO61LGvPp6q95GEg==
X-Received: by 2002:a5d:6d8a:0:b0:39a:cc34:2f9b with SMTP id ffacd0b85a97d-39d6fc291b3mr6246139f8f.16.1744018408664;
        Mon, 07 Apr 2025 02:33:28 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.37.215.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226cf6sm11371971f8f.87.2025.04.07.02.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:33:28 -0700 (PDT)
Date: Mon, 7 Apr 2025 11:33:22 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next 06/18] netfilter: nf_dup{4, 6}: Move duplication
 check to task_struct.
Message-ID: <Z_Ob4niUHgSjS5x1@jlelli-thinkpadt14gen4.remote.csb>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-7-bigeasy@linutronix.de>
 <99214ac9-cff7-4a5c-b439-ed9ec2c6877c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <99214ac9-cff7-4a5c-b439-ed9ec2c6877c@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YrYEkypZVLRnFx1fL_yPopEWsH-hxPUaZD4qL318Pis_1744018409
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paolo,

On 17/03/25 18:29, Paolo Abeni wrote:
> Hi,
> 
> On 3/9/25 3:46 PM, Sebastian Andrzej Siewior wrote:
> > nf_skb_duplicated is a per-CPU variable and relies on disabled BH for its
> > locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> > this data structure requires explicit locking.
> > 
> > Due to the recursion involved, the simplest change is to make it a
> > per-task variable.
> > 
> > Move the per-CPU variable nf_skb_duplicated to task_struct and name it
> > in_nf_duplicate. Add it to the existing bitfield so it doesn't use
> > additional memory.
> > 
> > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> I'm not a super-fan of adding more flags to 'struct task', but in this
> specific case I agree is the better option, as otherwise we should
> acquire the local lock for a relatively large scope - the whole packet
> processing by nft, right?
> 
> Still this needs some explicit ack from the relevant maintainers.
> @Peter, @Juri, @Valentin: could you please have a look?

The additional flag fills a hole, so, FWIW, I don't see particular
problems with it.

Best,
Juri

