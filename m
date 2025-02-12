Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C7134A8
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385373; cv=none; b=g1NA47/fqusFuzITqHpLggw8hzjvK1R/F7VsNPpm+MHPAVyikbAERbtoGg/cjPc7m0FqQo37AIX93DsT3YVoc1K8Q8WCl0z0OuYh9L0TxMtPfFdCagi+eeyhFvRZUD3z7HVWx4ZXaUzbBM/YhLZ2E+KowltgbLNFQDnN1e85Qvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385373; c=relaxed/simple;
	bh=YHk5qXpxX8K3uqw7yVx7O/E1naj2oGZHN9j5riyna4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWRcnWk2WfejSZ9DWO4FiwRC+4FEqVyarGK9W1Wm0p4T2PPEGBFNwaphsn5ahrVPwjnvT0kAVdczE4T1K08LotHJqSsfqMXQ5BfZ9MBL/zMyTVmhbgEzeLXZkoR6YU38pOk6fsitR67fP1bxzFMrSK40v0+gSXLMY36VehDbGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1kBkAi0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1kBkAi0"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f48ebaadfso124298715ad.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 10:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739385370; x=1739990170; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3INDGe0+r//SOKzJGUZQ68KFDz8XFg3A/jpc/renCis=;
        b=m1kBkAi0bib21YA7IskMlQLh7Q/Uf1UI64GlFoZm8PYoxppkv+jXPm4K6GpzntWSSM
         5vsk+ZmduoMCG5kQIJZxBpZtWcX7Y6YfW9S+f76MCKUlIaOQvNXJ1qz5jqQBzR6CzgSu
         E6bs2Vevh7jJRwLqxcpDEvfexl9zruoZglE+oiS+fkONGYmv86JBRNhyyEKHZR3VT/Dw
         mmudFkWqfs9w3jmi6IH6bmIozKfatiInSMHBxJY+J+JUazsM3kqSlKS9dcMf0IzUxLTS
         uPbju4ZkooVELdXUtOjSP7e5OkLOW6uHLCbbvwY2Z90lGWwA5e1txsc6qb/BbVs12KCF
         Pv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739385370; x=1739990170;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3INDGe0+r//SOKzJGUZQ68KFDz8XFg3A/jpc/renCis=;
        b=OI915A1uZgZPs4IkG/sjneByEB6u8nTAtcyaTJpPvTTZx04OvMkSDnn9h4oRi6dY4Y
         ggeNGLNYbeaYHqj9wrJhdBW5kPvVBD+Ja/1WQ0WWYxWTxQvI89P96/8SmGNvhF7QnAHa
         tsMlyMqaNKqWRH01+eX9Oans2bu6XfIGOdn+IBGP0UnbhWZtcAvY4b131VZDM5z/SAdv
         Itwt8fAtILj8CsCQscMxnW92K9mm4VJ4zCHknVzansiUVc5b1uZOH5uiMs6vKx+8bjSg
         pYHOaBfcm7Lk3Er5/9E61Rd7vKXX4mMQX+Ffo85htQHTEOLZN4pqzNXmXgVJELIoqmff
         tjsA==
X-Forwarded-Encrypted: i=1; AJvYcCXS+IzxBTn0ui7XoinJWBmE34t7aFslVW84NF/podearrH7ff9r67JUok5QjHsovUTqx4nIF1gvZqQ0bBK+3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFIYC0qc3G0qveHFKi2QPqmIThVo31R2LCetOdhSXzptfC68MM
	ks8UHgupiEYEkYmbnjU3Akt5EFGShBn8yw6lg+JaKvWTts+zha8A
X-Gm-Gg: ASbGnctSTQBsYPWXWfWbhKW6NC/kzl1VhLkbGPtTkuFAYu5T/51hVH7XKwQnVXDmpeK
	jf7R0zYiibmbxRMGbXPhaHTEEwWiDAyqIc/4X0wubClj3KajXG4y0Vqfn6piUbJcAjs2OyetQzb
	z/zXYXcKFsFgRcuzJzhw1Q11J4jm/vgNHYaQM5/iHJY3tGnx4Xqy/EH6wWSGJ0hXYIuUaFtYEdO
	Fii+z4BOubFCRTSHRTf7RqkbzAS5WzTop59djz1eCmUhVfxLWGT4HtMUmBUQcSYVmrqBG27SKkx
	fiimNwDGuyDAqWrA8HLOMMR7886RamdJOw8O4u54Pje3jIbMWBqv8bNjBeuXkXnn
X-Google-Smtp-Source: AGHT+IHzAAF0+2oKRMH3EIm25ieva0Thp+wNAyAEpUQxObrouLtrOjl1/ui7vpxhC+ecryx+HfeiTA==
X-Received: by 2002:a05:6a21:7a49:b0:1e1:c054:4c58 with SMTP id adf61e73a8af0-1ee5c72e426mr8527219637.2.1739385368242;
        Wed, 12 Feb 2025 10:36:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-731737c81cesm4182593b3a.156.2025.02.12.10.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 10:36:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9aec9f06-0566-430e-a708-d22bff0bc697@roeck-us.net>
Date: Wed, 12 Feb 2025 10:36:06 -0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible circular locking dependency backtrace seen when enabling
 PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev,
 Steven Rostedt <rostedt@goodmis.org>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
 <20250212165612.ogWjReMW@linutronix.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250212165612.ogWjReMW@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/25 08:56, Sebastian Andrzej Siewior wrote:
> On 2025-02-12 07:56:44 [-0800], Guenter Roeck wrote:
>> Hi,
> Hi,
> 
>> when enabling PREEMPT_RT together with lock debugging, I see the attached
>> "possible circular locking dependency" warning when instantiating the pcnet32
>> Ethernet adapter with qemu.
> 
> I may buy you a virtio adapter :)
> 

The whole point of my testing is to execute as much code as possible.
I _do_ test various virtio devices, but to limit testing to virtio
would defeat the purpose.

> What about this in the meantime:

Yes, that passes my tests (with and without rt enabled).

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> 
> diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
> index c6bd803f5b0c1..c7648045917a6 100644
> --- a/drivers/net/ethernet/amd/pcnet32.c
> +++ b/drivers/net/ethernet/amd/pcnet32.c
> @@ -754,6 +754,7 @@ static int pcnet32_set_link_ksettings(struct net_device *dev,
>   	int r = -EOPNOTSUPP;
>   	int suspended, bcr2, bcr9, csr15;
>   
> +	local_bh_disable();
>   	spin_lock_irqsave(&lp->lock, flags);
>   	if (lp->mii) {
>   		r = mii_ethtool_set_link_ksettings(&lp->mii_if, cmd);
> @@ -789,6 +790,7 @@ static int pcnet32_set_link_ksettings(struct net_device *dev,
>   		r = 0;
>   	}
>   	spin_unlock_irqrestore(&lp->lock, flags);
> +	local_bh_enable();
>   	return r;
>   }
>   
> @@ -890,6 +892,7 @@ static int pcnet32_set_ringparam(struct net_device *dev,
>   		pcnet32_netif_stop(dev);
>   
>   	netdev_lock(dev);
> +	local_bh_disable();
>   	spin_lock_irqsave(&lp->lock, flags);
>   	lp->a->write_csr(ioaddr, CSR0, CSR0_STOP);	/* stop the chip */
>   
> @@ -921,6 +924,7 @@ static int pcnet32_set_ringparam(struct net_device *dev,
>   	}
>   
>   	spin_unlock_irqrestore(&lp->lock, flags);
> +	local_bh_enable();
>   	netdev_unlock(dev);
>   
>   	netif_info(lp, drv, dev, "Ring Param Settings: RX: %d, TX: %d\n",
> @@ -988,6 +992,7 @@ static int pcnet32_loopback_test(struct net_device *dev, uint64_t * data1)
>   		pcnet32_netif_stop(dev);
>   
>   	netdev_lock(dev);
> +	local_bh_disable();
>   	spin_lock_irqsave(&lp->lock, flags);
>   	lp->a->write_csr(ioaddr, CSR0, CSR0_STOP);	/* stop the chip */
>   
> @@ -1065,7 +1070,9 @@ static int pcnet32_loopback_test(struct net_device *dev, uint64_t * data1)
>   		rmb();
>   		while ((lp->rx_ring[x].status & teststatus) && (ticks < 200)) {
>   			spin_unlock_irqrestore(&lp->lock, flags);
> +			local_bh_enable();
>   			msleep(1);
> +			local_bh_disable();
>   			spin_lock_irqsave(&lp->lock, flags);
>   			rmb();
>   			ticks++;
> @@ -1125,6 +1132,7 @@ static int pcnet32_loopback_test(struct net_device *dev, uint64_t * data1)
>   		lp->a->write_bcr(ioaddr, 20, 4);	/* return to 16bit mode */
>   	}
>   	spin_unlock_irqrestore(&lp->lock, flags);
> +	local_bh_enable();
>   	netdev_unlock(dev);
>   
>   	return rc;
> @@ -2106,6 +2114,7 @@ static int pcnet32_open(struct net_device *dev)
>   	}
>   
>   	netdev_lock(dev);
> +	local_bh_disable();
>   	spin_lock_irqsave(&lp->lock, flags);
>   	/* Check for a valid station address */
>   	if (!is_valid_ether_addr(dev->dev_addr)) {
> @@ -2305,6 +2314,7 @@ static int pcnet32_open(struct net_device *dev)
>   		     lp->a->read_csr(ioaddr, CSR0));
>   
>   	spin_unlock_irqrestore(&lp->lock, flags);
> +	local_bh_enable();
>   	netdev_unlock(dev);
>   
>   	return 0;		/* Always succeed */
> @@ -2321,6 +2331,7 @@ static int pcnet32_open(struct net_device *dev)
>   
>   err_free_irq:
>   	spin_unlock_irqrestore(&lp->lock, flags);
> +	local_bh_enable();
>   	netdev_unlock(dev);
>   	free_irq(dev->irq, dev);
>   	return rc;
> 
> Sebastian

