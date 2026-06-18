Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1235E1B3
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Jun 2026 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768436; cv=none; b=bqf9izOYNT6UjdHh6P8KXbYff/qZebhwfj5vbGfYuxlgJffbLNbUn51FUwMML0OUxbLDjQcXpe8EEhkAEUgxfHaQneh1+ePvtBW5loUnO8gddFh0HBffpoc25RVhQinpyCOhz5JaddIW8c0d+50sRwsTGPQ6w7WBa5qX1Gjg8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768436; c=relaxed/simple;
	bh=TLSPGn1X7APXd9mpj0fYFz1rYawux3LLayDrWOYO0ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nllhn8D3covTpwS3nuswdcE0yIu0Q2ALpSKT6nqKnhVvdD7BQdVNHqV9YFjxExF/orRWY4zb/R4q9kLcvYMWSA64eVV/79TG98qf0Kv0YEyXYh21YOBIbVEB6x6Ec/xKy7qlrdGEjIuMZZeUqo6VwiwImVp0LMhhbbqBMqdGKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cK1LfgDe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cK1LfgDe"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-842358aaf36so230432b3a.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 18 Jun 2026 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781768435; x=1782373235; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjiRzYxjlgb1391C0ySksvTAaXp/63Cihk5oFrsX1z4=;
        b=cK1LfgDeyhcz/ngLDg4Rwx9unx4cEoWh537wi2+OMmlQtN5GoI4gvKYtpDQow1RnNv
         lMSoVxRB55Pqw7gvPZqGgG9il8iBOVB2/13ACe3m9CNYF6jrROV6ZYOJp0JkYqkJlPax
         6/7yF4T3tbhbsHVbrVn/mD2RWtsqBPc1PGNq0cMIRxSHuXGL0wTgY4JIcRHK0p9fEh7H
         8ssZdkT+RhGWzugyQvVyp4pyEZCGyH3j8TH/hTSBiboeuAQZptDTWaqyTikgMOvNkinN
         XtyvlKGUQUurutOIngpqoN8Y6AwH6aiWD64aydhZsf4hX0Nyw4VcDlaNXcGmmu/BftVc
         4rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781768435; x=1782373235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjiRzYxjlgb1391C0ySksvTAaXp/63Cihk5oFrsX1z4=;
        b=E1/k3M/r3rhku0QL0mAvtFm88Sv9kR6yUV+T9S/JWL7xNy6ol/5tq9Ec0PvAbZOhZZ
         KkHR5FnP+YJ07rpn5SCCZNJWkd0sjuKFTuTXvN4rlSo/iln2v06IO4jfNVNhx10iXTOn
         R+rs8DBFbV0nLMoGjhqEn6XHEDdSUoK5GSww16dNpO42DHEKT+tNdXqjYmgI8PCSlewf
         RoKqYMwYPNgyuRWilRqmeWnllzj6FopPBnhizPYfCK7+dx94Wr0gPyFgl8ZmEoZ8mAZ2
         HDZhQl+76Fhxwfn3Ap2bPaGD1ekkOBvSEjqtBm0AgRDtJeesBCxPxu9TmFiDd6UocctN
         Vx5g==
X-Forwarded-Encrypted: i=1; AFNElJ+2RjtC4szOMQKokqv0e8D2myAKi4gcHx4G8C3xiJjzTqgOqxXYF10ttlhPpPtSoB5jf6fXe95KXc15Ba6JoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjhHzw3kXgEReGEgM3eehxegKLTBq+Ph5VP4dSbOjeMpjrD30c
	uL7sHvey8moyOhNEJGWwe+fN6YCKD/eCExkMMY9oBPnCa8K5ANRd0GcjOv3Ol8zW79c=
X-Gm-Gg: AfdE7ckq6cgocljlSX44W5h04d72acuCrxlIb86feCITRVvzi7kt0YVz3ZR2ifttwqZ
	kZ3ogGzGNhQ9afIlHVAQGn77PujeUZdoJU3vvZhRVbx9ycpTyJJuw+TEHrImS8uBSLm4RQ+LdHZ
	jtXVaUvGt+Fgv+rGTPlJnILoANJ8gHxzF9G2D684R97Rq9CoEQXOZuCnIEpt/6AVvlbKS0NRyBt
	cMGxu3EwmtEfcpCAEwcLSd2PhyIYxiwmMGFv843Ly3gzuzJ8b6jGcpoYJS7wHttnaTrLZek6LH3
	PF09zAQbBJUWCixIpXkn+RO/dJUVdAsITDp1dLYlDtdFvNMcq2eSl2j/ZFMSWtHQ3sC/gFEZOOn
	JPgrNbP8YCsSFJbz2oV7v2HidYYig+X9njjEo5jm1cIkZ/VTnI/lBN3rWalv73056qT2brN/Mr1
	FqbV1Yh3OKRJvK
X-Received: by 2002:a05:6a00:cce:b0:842:2419:6bfe with SMTP id d2e1a72fcca58-8453b0df8eamr2701471b3a.7.1781768434721;
        Thu, 18 Jun 2026 00:40:34 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b020b53sm17785056b3a.47.2026.06.18.00.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:40:33 -0700 (PDT)
Date: Thu, 18 Jun 2026 13:10:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, 
	Herve Codina <herve.codina@bootlin.com>
Cc: Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, linux-gpio@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: Question: SPEAr PLGPIO irq_enable on PREEMPT_RT and regmap
 updates
Message-ID: <sj3oxg5ymbe2ac2geznsidsxz23rkqzqc4ir3pkjc7bsrzaorw@cw3waaj6xxkx>
References: <20260618023418.213453-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618023418.213453-1-runyu.xiao@seu.edu.cn>

+ Herve (the last guy to work on this driver).

On 18-06-26, 10:34, Runyu Xiao wrote:
> Hi,
> 
> While auditing GPIO/pinctrl irqchip callbacks, our static analysis tool
> flagged the SPEAr PLGPIO irq_enable path, and we manually reviewed it
> against the current tree.
> 
> The path is:
> 
>   irq_startup()
>     -> plgpio_irq_enable()
>        -> gpiochip_enable_irq()
>        -> spin_lock_irqsave(&plgpio->lock)
>        -> plgpio_reg_reset()
>        -> regmap_update_bits()
> 
> On PREEMPT_RT, plgpio->lock is a regular spinlock_t and can become a
> sleeping lock.  Since irq_enable/irq_disable can be called from IRQ
> management paths while the IRQ descriptor raw lock is held, taking that
> regular spinlock there looks unsafe.
> 
> A minimal Lockdep reproducer preserving this irq_chip::irq_enable carrier
> reports:
> 
>   BUG: sleeping function called from invalid context
>   irqs_disabled(): 1
>   plgpio_rt_spin_lock_irqsave
>   plgpio_irq_enable
>   request_threaded_irq_probe_path
> 
> My first thought was to convert the PLGPIO register lock to
> raw_spinlock_t.  However, that does not seem sufficient because the IE/EIT
> updates go through regmap_update_bits()/regmap_read()/regmap_write().  For
> the syscon/MMIO regmap used here, regmap may still take its own regular
> fast-IO lock unless the regmap was created with use_raw_spinlock.  So a
> raw_spinlock_t conversion in the PLGPIO driver alone may just move the
> PREEMPT_RT problem one level down into regmap.
> 
> The repair I am considering is to keep the gpiolib resource updates in
> the fast irq_enable/irq_disable callbacks, but defer the actual PLGPIO
> IE/EIT register writes to irq_bus_sync_unlock(), after the IRQ core has
> dropped desc->lock.  The driver would keep per-line shadow state for:
> 
>   - IRQ disabled/enabled state
>   - pending IE update
>   - edge direction state
>   - pending EIT update
> 
> and then synchronize those shadow updates from irq_bus_sync_unlock()
> under a mutex.
> 
> In other words, the fast callbacks would only update local shadow state
> and call gpiochip_enable_irq()/gpiochip_disable_irq(), while the sleepable
> regmap writes would be batched into the irq bus sync phase.
> 
> Does that sound like an acceptable direction for SPEAr PLGPIO, or would
> you prefer a different fix, such as changing the underlying syscon regmap
> locking model or handling only the IE register path?
> 
> The draft patch I have locally is roughly:
> 
>   pinctrl: spear: defer PLGPIO IRQ updates to bus sync
> 
> and it changes only drivers/pinctrl/spear/pinctrl-plgpio.c.

I haven't worked on this for a very long time now (15 yrs). There are some
people who use this hardware, and so it is not removed until now.

Also I am not sure if RT kernel is a valid use case here for this SoC family.

-- 
viresh
