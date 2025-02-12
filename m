Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED620F066
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369478; cv=none; b=TZsz0gWmpmFWiAZwFzmGILfPv0cvfOiPHUThB1AxoEyu+sq9BFyVPF4Ttzth+cIMqeSWy9sxtK9V41pShh8gCaAuboSlY8wyeRUQwVaA8AU/01rMcMGEdVvAerfC7tDQQRocPntOeFrPaCPrXJYYmMfi0jmzR7PD1kxbKHguOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369478; c=relaxed/simple;
	bh=SZDQzEdFU0/q9RtREdktP8Ivyi5yYbZN3/bLAVSEb8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMMwJwjl6iweyVxJeEtwtvJVoXrq62fMNy26jw+++60UzPMXwruwNSWS//R/K0RUT6u/QZmpSF5BHKvfOj/GNq692n7jrgg5ql0qHimedYYO8+OGkRY1xl3XH6mUdcrmqKmCq+oAO+tQch1jtzOSIGHz1N8UihSX3vi9DS5VVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBJxpnSz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBJxpnSz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f818a980cso63944165ad.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 06:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739369475; x=1739974275; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stjpwGS2G5dhidrt/nQRRHComZAXCWzFNOoGsvIGoxo=;
        b=JBJxpnSzIeupdZ+ujg4L2CQ86qKfafjusWwK3Z439eiMRUyFHqCNb5EFytUSgYhXV9
         RrGOmTFW3/Y0CNS1BZHvEOo7MkOhCfs50dXRWM2fRkJKPGDE1wi+VuWtQaubC6XRurcg
         eROCrK6sj58cSIwAJ954XF2r038mz+Qjthklbb0dGI9INy+QbKbmeggM2nAe5QeEoTAm
         oDePBtK150s2WrJJCfhNlM4C2FHjOToi+rPAJpQQttg2OG7GlutOt29z4Fa9a4Vdc9FU
         8x7DM1I/DYVMZ68paGckUGgI/x45Hxr6I2bRTbAQx3m/qHFMZcGfPnj98Db2wrpjI+Oq
         YYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369475; x=1739974275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stjpwGS2G5dhidrt/nQRRHComZAXCWzFNOoGsvIGoxo=;
        b=fAIxFRfCW9xZEzn9Q2BE/9T4j4z41N3Uz2LAnbwVSUpe2vFTTjUnTuwov3Kfu8yvoI
         x1XqxgcHti2kdDzNbZjhXuQSEGZ++ID7RuBntI9aAEMipVnAH+m98epf6EY/nWDDjNey
         uFoiTB5+VfVmnaB+skrKf6Tk+cafcR8tLs8Dp7EuBm7KYKdo6sK6myWNzFAo9dqdzGKH
         +sJF/c0XKojgIIoDFewyikyV8gQTReW+hXV4ixlHk1Oo7+ktrBOg1Be+YRC1XDkAEWvs
         GvyRffr4JVSQ/M0GW+by7QacdW1/7pl2WdivLv5DzFJuBqTF8PZ3vUcnzdUyLjT1qQRu
         7qNg==
X-Gm-Message-State: AOJu0Yx5ZDzi/zScVzOSKgY0HkW1L3yIXIfWMXCd2aLPSrNWwOOIalib
	UhPgjzNTpc/AzW8/ViEn9gU+HzTiduAdb8bA+oYk0EPISx4h4Pcf
X-Gm-Gg: ASbGncuxs9M8Fr+Ixzup32eYi7ryudlDsQiPv6LP9pTmsB//gOEd70mtGzkkO7fWbpv
	1hBHCSmqFjjUON+iBe1R9dKdEGXXTvlueoZSRxER7J8wAOVKI28SeRjljyYIINb7/jq0VUkwQok
	kZ3uPrV/MxT6/myEubFmTLURu5kyGo/KLj561M6U5PLTjFmn5Hc/DhOEI5Jf0cZ0Ab2zyNz5ueK
	ixc0qpmlCADaRJKsH0L8JsEpsRld70zMN5J/QqvfzX1NPIXkWuSTZM1wsjUZupWNtNgUBDZVLEz
	ulEAByaL2MaJ6B6MATlQyBhfzfql
X-Google-Smtp-Source: AGHT+IGqS5h3LITR2enOnLxAheGDNK25N/qKWi94gwDYPmAY0WnE01AlSp1naByLsZ5ToRI7b93Ucw==
X-Received: by 2002:a17:902:f604:b0:21f:85af:4bbf with SMTP id d9443c01a7336-220bbaf8ffdmr57225035ad.20.1739369475494;
        Wed, 12 Feb 2025 06:11:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220c8ee9dbfsm4942525ad.182.2025.02.12.06.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:11:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Feb 2025 06:11:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] lockdep: Don't disable interrupts on RT in
 disable_irq_nosync_lockdep.*()
Message-ID: <2e997e85-fcf8-44bc-92bf-7d035c24abda@roeck-us.net>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250212103619.2560503-1-bigeasy@linutronix.de>
 <20250212103619.2560503-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212103619.2560503-2-bigeasy@linutronix.de>

On Wed, Feb 12, 2025 at 11:36:18AM +0100, Sebastian Andrzej Siewior wrote:
> disable_irq_nosync_lockdep() disables interrupts with lockdep enabled to
> avoid false positive reports by lockdep that a certain lock has not been
> acquired with disabled interrupts. The user of this macros expects that
> a lock can be acquried without disabling interrupts because the IRQ line
> triggering the interrupt is disabled.
> 
> This triggers a warning on PREEMPT_RT because after
> disable_irq_nosync_lockdep.*() the following spinlock_t now is acquired
> with disabled interrupts.
> 
> On PREEMPT_RT there is no difference between spin_lock() and
> spin_lock_irq() so avoiding disabling interrupts in this case works for
> the two remaining callers as of today.
> 
> Don't disable interrupts on PREEMPT_RT in disable_irq_nosync_lockdep.*().
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net
> Fixes: e8106b941ceab ("[PATCH] lockdep: core, add enable/disable_irq_irqsave/irqrestore() APIs")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>
