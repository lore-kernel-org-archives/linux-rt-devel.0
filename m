Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72030242D62
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677664; cv=none; b=Ch+mNGkKx8HJiQ3qteHL+BInANuDXgLnazwVa/kRuHsPnGcdFJhTaVk4FtydlGXA3gjvzXa7FpSi0k9ooOwpvVnbYLUdVmggp735YWjCiZLfITNLcCPQ9Kud70kpakTX22YQrikr6PKIlBTyImpRgUmc7juzX1rE64un0kANvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677664; c=relaxed/simple;
	bh=oQucex6RZMs50tBRvSFd4gxrcOSnqTOU+r9tuuJZYTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlk/ItC2CgdNmhTLjyhdfiQ96yeLVzan5lLL3HIs6vnYLKf+KtKCITCsdiPtifl+pwSh26mDpw+rr3kr1GCC25rY0RmQKYtjdJqyd+QDe6EeyJRd+5J6oy8Xic0az6RZEnAxS9bMl9M1e73GIh31sV8feGWJnnyS+f8YX9rw6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjwtVl4J; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjwtVl4J"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a0061bf0d3so33515e9.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790677651; x=1791282451; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f5Y1Bj47kFdGtgtMUGRUSsPhxIRB2mIpZUPvY4e79ZM=;
        b=cjwtVl4JR4qNirrqJLt2iMLGGm5APHbzYM/XpiGc8Nz/6+ACQ7v/yB7JaUgASPozwF
         OErQUJCGcldLM2+M0glJDk1goGfJOjsV7YYV0FsNPkMjM1Ha9VhsLuYlfRGrOgylmeWd
         AvabyPpRt/NbcqY8VohmpJvZfq5gYUjDpPiCGk7g9tN7FOFWiQDa4TxVPgH7i2EU8TnR
         5x/aVpV78ifDL0RF2I5rcO13VDhDjCSjvQYGDUKZSmPE1fp7MeNkUnn6S9n15kVDo42B
         IWWw/F529br3lwfpG9JXrcrRj6A4+owR8T/6Bqq6A8qHBlPFXBR3SK5ysLmFM66XbPCB
         XtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677651; x=1791282451;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5Y1Bj47kFdGtgtMUGRUSsPhxIRB2mIpZUPvY4e79ZM=;
        b=V/VxXnIu5yju81RtPHrWrNqQZpO6GHk4MYt4lKzXffvMeZw7OXLVSbzcDi69SeUTmV
         +1XWI5YC4XIblFq0sC0AFFM1m0l0Lvt0wfbKfn391bNefq5HRRbr28uvAfnN1Isk0pBS
         QenOthafNCOS661jdh7QhDfMJE5H8CoaLJwXpGIlbuTWAbKoNjOrBQdex/noKZC7Mf6D
         HegQosnv+5IX9emzMMD/hUxJ47K0SbnMa+owfcRoGn1Gb9o60jNNR18S4iPysaDUpJIc
         qc8sDl0O7dtr/HJLYW+YpBfuuoEaVYmjLZBToinhAm7KNvI6yVfZZijgn3e50VDL5wmo
         gLag==
X-Forwarded-Encrypted: i=1; AKwUvBz3OUmSAKOORvs9ozCHn28z6cmd95y7Tinr2KMIUzxm1C0GRUfHx4puxaQqA0Bm5Np/RFXPA6+lrvt0D1P5fg==@lists.linux.dev
X-Gm-Message-State: AFuF++kPOljWqcNu1N6Plx2WiNJvR40oEKmCKKLjoxwPP0AjbuQNL4Ho
	PD6TYuQayZODikSyjpUtteuPXTW0KJcL6Sw1+g9vFlFntZWQs4SdgHkQ5zjrcb6CuA==
X-Gm-Gg: AYBFou3gDIKr34FYiA/ZRtdd1/+MkZNmY5AUyX8uogI9BJZYr5Z0palvpS+XMQGZfFy
	o2tgd/E4Gabl+njOh5qiFaZ1ziaLJbhzO/3EoKn3gvsJZk8aM5/ee3Ix3hUqNHEIqI4hvmyU6uy
	f4ueXJue74aeUsB3nlSabEbSAaDpwTa/Sd4YKme125jDU49H+kdu1I+nuXFYngs6psuTfjgSZwn
	w+P6RIQQ2lnSLpuMAL/lAx6AQRd4PW6cBZfz0orFF0VuEJm7ZX4ZDdiYKk5ew2IgTegVwx9cj1X
	f4vTQXeFnodv2+m6XSiDoJuC3FIrzp3PrqAhAhErpVNCq7j8ukw7z7MuwLOOYTAwq4mdQbFedMf
	l+vW214+G7Kfe7i22yWxBhVdIZDzfhNCKAVuyaxPhHHsOgbbW1cXh1dxi+2+wE1ekNrNald1V8N
	ACfRCZrGGaF5UpNWsWSxLiJvtxAAPcbLLTrQEicl6b9AXV3Vvh/GDI0n97abpCKIof6HvewCEBn
	7TEasMN7hv2Z4wkvhlUtZwLw/1FJ0U99sEfx4P1
X-Received: by 2002:a7b:c7d0:0:b0:49f:e312:54ea with SMTP id 5b1f17b1804b1-4a00f46d761mr379975e9.12.1790677650115;
        Tue, 29 Sep 2026 03:27:30 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c10c656sm103565205e9.2.2026.09.29.03.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:27:29 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:27:19 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, akpm@linux-foundation.org,
	urezki@gmail.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	kees@kernel.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, gustavoars@kernel.org,
	bigeasy@linutronix.de, clrkwllms@kernel.org
Subject: Re: [RFC PATCH 12/15] sched/task_stack: Introduce
 ARCH_HAS_VARIABLE_STACK_SIZE
Message-ID: <aruShxHCUWEHr4i1@google.com>
References: <20260928174122.3380703-1-smostafa@google.com>
 <20260928174122.3380703-13-smostafa@google.com>
 <5c6edcfe-8332-4db6-b0fa-ca5d137a2075@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c6edcfe-8332-4db6-b0fa-ca5d137a2075@infradead.org>

On Mon, Sep 28, 2026 at 01:37:37PM -0700, Randy Dunlap wrote:
> 
> 
> On 9/28/26 10:41 AM, Mostafa Saleh wrote:
> > When CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE is enabled, the kernel stack
> > may not be fully populated with the THREAD_SIZE virtual area.
> > 
> > Teach task_stack_size() to return the size of the vm area and not a
> > fixed size.
> > 
> > This propagates to end_of_stack() which makes functions like
> > stack_not_used() and set_task_stack_end_magic() to use the lowest
> > valid stack address instead of THREAD_SIZE which would cause data
> > aborts.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/Kconfig                     | 10 ++++++++++
> >  include/linux/sched/task_stack.h |  5 +++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 45c657772362..d6fa2ccb0599 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -431,6 +431,16 @@ config HAVE_ASM_MODVERSIONS
> >  	  <asm/asm-prototypes.h> to support the module versioning for symbols
> >  	  exported from assembly code.
> >  
> > +config ARCH_HAS_VARIABLE_STACK_SIZE
> > +	bool
> > +	depends on VMAP_STACK
> > +	depends on !STACK_GROWSUP
> > +	depends on THREAD_INFO_IN_TASK
> > +	help
> > +	  An arch should select this if it supports dynamically configuring the
> > +	  kernel stack size.
> > +	  For example the kernel stack size can be from the command line.
> 
> 	                                    can be set from the command line.
> ?
> 

I will fix it in v2.

Thanks,
Mostafa

> > +
> >  config HAVE_REGS_AND_STACK_ACCESS_API
> >  	bool
> >  	help
> > diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> > index 4a808f9c4631..07d73adaecd1 100644
> > --- a/include/linux/sched/task_stack.h
> > +++ b/include/linux/sched/task_stack.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/magic.h>
> >  #include <linux/refcount.h>
> >  #include <linux/kasan.h>
> > +#include <linux/vmalloc.h>
> >  
> >  #ifdef CONFIG_THREAD_INFO_IN_TASK
> >  
> > @@ -96,6 +97,10 @@ static inline unsigned long *end_of_stack(const struct task_struct *p)
> >   */
> >  static __always_inline unsigned long task_stack_size(const struct task_struct *task)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE
> > +	if (task->stack_vm_area)
> > +		return task->stack_vm_area->nr_pages * PAGE_SIZE;
> > +#endif
> >  	return THREAD_SIZE;
> >  }
> >  
> 
> -- 
> ~Randy
> 
