Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9D32C938
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Nov 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434509; cv=none; b=Sg1ZrXi9xYf6R9bawEzjGskavKQa/p2cQsryuZNtfEbDqqoZ2Y6brfCif2zwqr4Y6+4axb9RyhpNcdP/xJbvTUYE2MkRA8uSsMbQ3sGt16IfP2b29KpNrBLD5gbBMVF5MF60wP/V/TtrnqPi3OQQ5wDpkOTtzPdX+kM8saTaX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434509; c=relaxed/simple;
	bh=fXOzwH23+ookahwd5aVH4s9O59Gqn2mFDZ8BxYBMUrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXiRT3M0N5pb27T5rbsAtAe1l7EYj2Rq3+l7+AJZYEV3N86c71X8K+z4M7yS/pI0P/GIPaqiTYPGWNik9FeORKuZSEXafrCqoUBUnnV3XIbdjOYnq+F6uhOk6Y19TrLvhoQJ1X3B86dIR/40a7fK5VPqtwieBdwaikMvOlSCvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmfsKqfd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmfsKqfd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290aaff555eso9656445ad.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 06 Nov 2025 05:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762434507; x=1763039307; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DiKUXXeHtxGgchjjyt6YLNM6oJ9XFDCTJqmUwZLcDQI=;
        b=BmfsKqfdqWiWFtpeqPOx7A9C86ZSY36sxufWobBYgPq42+mbjbZpmEPliEpWmty/zN
         VGtv2ThyGpQ5p6nb+MFFViHJ1wi+17MX+K2ANdvwNiToNSRzH+EyID8TJ/LDVKPq2MIq
         wY6ZaeziezirRUuOFoSA2l2kpc2OM2S1vyUALoz9yS9be9kogh9PgUv80wrIPgck7vwY
         CsKAg/c1JcEL+puhNQYTj1H6cCud514eL6GOBHIQPUoIQnsZsjqWUXUg7Y7hyGfNZ+dS
         pP2jccWgisqn311mKWt7mB8iSeD3DE3opFyyk8ThEfwVHFJaaOv9iH5KkNhhO3TLio82
         J3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434507; x=1763039307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiKUXXeHtxGgchjjyt6YLNM6oJ9XFDCTJqmUwZLcDQI=;
        b=Qvnqg9kd3rHwjguz/q9qZzA8R5j+puVgupAR5kTTBtAvOZ5f9MK4my4c90Zb4f+ive
         PAr+xp9XUF5nAMyYAGxCPAuC5CIys5QaZg9pV/yuINnqgCPHR9Aw+jshGMVIGmhikCYp
         2qLDcMLaCz23cY7yqsSR0asWOZet/LKCIOf3RYIiIutrJ+wiGETi6I005/0qMQWcK5Vy
         HYoB01poSutOheMHQjuOK4GQR7kQauRxPOJ10SoF8S67f3+B8sp9TPGrcyI+fgWGVlTC
         Y0FMQvjHZIZ1A3I+b8BuJ/5Sbh9qj6fdHEm0FGKzxZRPC0a+H+U2f2DOdYOI8RuCdHdL
         eiig==
X-Forwarded-Encrypted: i=1; AJvYcCXkhrcdzjK+wB8WtMGexY1cYIvAnScx8vBNDnvuWRpeoL03Ag84RcnxnWRQ1iVSOhEfyDwe4F4tQgzaBI+Ctg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTyKc7cqFMHfwQC7n1U5OlP55dggP0RBkdQOkkZ2vvv3uqio1R
	+GHHqJWtjjuHLNDY2afPG0n5MlnEHSDv1OHomz288PwniYZWsvEgv7Wy
X-Gm-Gg: ASbGnctHi5yfPVVdZ9klA1Bkg1rDN7wHvT7qg70bmBX3Dxm5HKUM+ThUASQ5tq6upTT
	d9uSRM9aIQoZJAWr6bI2RdwQKR+1xAWJX5YxuOOg6g0tB3w7NNYTvBnCF3+FqUwdwes+l1bMr/t
	vJbGQuTcb1mFHggB+FMBy6inRbS0nMYWWkMiKdiNVBQMxGdlfidBwBlsL98Y+uhr26Pw+fBQOLQ
	W/T/XL1GG1zE2HwnEjjnJItlo5kI3p6DPF6jxgz35WWjN2aF27kLW7knkkGglhjaX/ss5VqtDN7
	23VzbZSt/aHLWjpkz4JY5aizgvG/E+pHdJdtuh6gQqENCrkZgdiYyz5i6VRXn7rGikhiTh6s9lw
	gMD34Th+ML2JtfMffpqcdtKGNRWMEaxjwE+N5e+5Ner21DafUAUD+guQkOYpcKOV9+2Zp3y92hy
	Z1zjmWR75ems++3nQlEeHJ7mXKdg==
X-Google-Smtp-Source: AGHT+IE58JuV5i1D6ly/rqum2FQefP1CgkfT3QO4ht/oHVyJQYHM1C33Yzh8g6xhgVumYzltifu0Gw==
X-Received: by 2002:a17:903:3d0f:b0:252:50ad:4e6f with SMTP id d9443c01a7336-2962ade2bccmr97176955ad.54.1762434506664;
        Thu, 06 Nov 2025 05:08:26 -0800 (PST)
Received: from 2a2a0ba7cec8 ([113.102.237.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8ef47sm28931545ad.74.2025.11.06.05.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:08:26 -0800 (PST)
Date: Thu, 6 Nov 2025 13:08:22 +0000
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI/aer_inject: Convert inject_lock to
 raw_spinlock_t
Message-ID: <aQydxtOtgPTPxL_9@2a2a0ba7cec8>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
 <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>
 <20251103192120.GJ3419281@noisy.programming.kicks-ass.net>
 <20251103192709.GV1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103192709.GV1386988@noisy.programming.kicks-ass.net>

On Mon, Nov 03, 2025 at 08:27:09PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 03, 2025 at 08:21:20PM +0100, Peter Zijlstra wrote:
> > On Sun, Nov 02, 2025 at 10:57:06AM +0000, Guangbo Cui wrote:
> > > The AER injection path may run in interrupt-disabled context while
> > > holding inject_lock. On PREEMPT_RT kernels, spinlock_t becomes a
> > > sleeping lock, so it must not be taken while a raw_spinlock_t is held.
> > > Doing so violates lock ordering rules and trigger lockdep reports
> > > such as “Invalid wait context”.
> > > 
> > > Convert inject_lock to raw_spinlock_t to ensure non-sleeping locking
> > > semantics. The protected list is bounded and used only for debugging,
> > > so raw locking will not cause latency issues.
> > 
> > Bounded how?
> > 
> +	scoped_guard (raw_spinlock_irqsave, &inject_lock) {
> +		if (ops == &aer_inj_pci_ops)
> +			break;
> +		pci_bus_ops_init(bus_ops, bus, ops);
> +		list_add(&bus_ops->list, &pci_bus_ops_list);
> +		bus_ops = NULL;
> +	}

I found that there are two styles of calling scoped_guard in the kernel:

  1. scoped_guard (...)

  2. scoped_guard(...)

Is there any coding convention or guideline regarding this?

> +				rperr->root_status |= PCI_ERR_ROOT_COR_RCV;
> +			rperr->source_id &= 0xffff0000;
> +			rperr->source_id |= PCI_DEVID(einj->bus, devfn);
> +		}
> +		if (einj->uncor_status) {
> +			if (rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV)
> +				rperr->root_status |= PCI_ERR_ROOT_MULTI_UNCOR_RCV;
> +			if (sever & einj->uncor_status) {
> +				rperr->root_status |= PCI_ERR_ROOT_FATAL_RCV;
> +				if (!(rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV))
> +					rperr->root_status |= PCI_ERR_ROOT_FIRST_FATAL;
> +			} else
> +				rperr->root_status |= PCI_ERR_ROOT_NONFATAL_RCV;
> +			rperr->root_status |= PCI_ERR_ROOT_UNCOR_RCV;
> +			rperr->source_id &= 0x0000ffff;
> +			rperr->source_id |= PCI_DEVID(einj->bus, devfn) << 16;
> +		}
>  	}
> -	raw_spin_unlock_irqrestore(&inject_lock, flags);
>  
>  	if (aer_mask_override) {
>  		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,

LGTM, If there are no objections, I’ll include these two patches in the
next version of the patchset and add your Signed-off-by tag.


Best regards,
Guangbo
