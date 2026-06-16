Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DFE3B5835
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Jun 2026 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601297; cv=none; b=HYausghe0lbkTlDxi90Sla4OhDPdTozkKp5i84nrJyayQ82nXg7S+F/N0ylyfOzpSe2QgRhxpPMWL0Toys7E9g4kPmC/C3VJ3qPxdTTzCLDnPByoTFBfTFJnbcVreiZuMgPQXv9niPc1LHz1ncC9VYNrwgf/zbCH1NPhOc7M3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601297; c=relaxed/simple;
	bh=36QuOsrDYCjnp8U7ww8EIJ3McAUGN/4LJTtMIwuyMRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYoh2fRq0XxxvMJTUL0SsoSJaXNKWlnzygNyWoQClqk8vWryi3J7Jx9VU/i8yGjkpv+C1eAbRa8WzK0axclQXk+z2vuFhSvD3Qh2gNVlA3SnWSXM5Y+6g52+uVSgyBmSE7hQ3JU+vifLi0a1easshrPuJ3/4SjNQAFmv2mNxD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dCJuf2Sh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dCJuf2Sh"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso2900025f8f.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 16 Jun 2026 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781601294; x=1782206094; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5fVPPL/MiFjakxmgMV5dR14morQiFY0hOlZW95hlco=;
        b=dCJuf2Shy3t+stgN2RP4z0a5yTUwjhSYJP74oPic6CiyItcCvZtHtZXPum9Ry6Aws1
         DkzzfYyA7e6qoTldLLYtfVkbyl3HnI43W4wo4CppbzRlFrhs2yMNRnPZDSIlnJfWPOt7
         PqpxxkrtgzFXr0Au7490EMJtXDu8vVUlwvjGUNOlDAopjHd+2LMT8RAY8SlcyRIfVQqI
         BTIjofQktTVkRvwqIOD1PRa4tjXYDXQK29s73i34h1pXwCpnfiN3fgRvtGGJsuph/jHS
         j2hSP72WAAkHqVTWeijZ9MPU4w+RKmMyPcGNx2Vjtz4hkPcJQbAAS9c3KGhaoa7t5ImG
         tiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781601294; x=1782206094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5fVPPL/MiFjakxmgMV5dR14morQiFY0hOlZW95hlco=;
        b=T2uwpp41H6atQrcxXT1ssMfNu9iZj3DIuVZIrhWqGFWokZDUZGvLWUIMdQQZnHJH/e
         XgvEuW8S6Ly51t8UxsBj6ABLUJMTJ7aJ+2Sou/8dtsDWlKmpuzkmqpRl3sP3u6PJwuMa
         zQq8euWP1NgfTuiVbMhYa38hcuGZQzjcIwbL061Z8b6lU1CLlyic38ulYDs/kP/G5aLY
         2VEZiE4ZIvtJ/jPDs4ey7Ep9IW5njMNNQa3loRAk9yLFgBMohNJpjR8wqGE2kcZoizYd
         7xMNFsqKL8oKuzMpIMcBu/U1Ze6wgdTQb7Uy2LHSUGDtgKBBLdJXYIQ2H5z3xAxU6yxE
         AHgA==
X-Forwarded-Encrypted: i=1; AFNElJ9SJnE20uvZ0ILiqWx8L9xS0Jy2do4UPRGFCsivst+facbJRL+enH7yL+u8fo5X5mofxv8vl7LJ5byFwTwhRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZTLQmntxhezuNiyvwou+cDZufV03jOc7JCxyd3yeqMEH12qUy
	/1JncrydbZT3HWEDSaDU2YxwbwUSBmT9rjPOCqhFj/qgJJscZcvB/CL13u9Z3db6VVg=
X-Gm-Gg: Acq92OElPJro8PPUL4HFrdFx5zVQYO5k+2S3OWI76nyioXfqN6YNZKCChBzmfYw38dc
	K/3Fg/h2PuWD7S4waF48skQYBQnQtXJxRjpSy1SKVquc9vrwnjDBA9n/HwkHf72Sb468YoFD3y5
	Oii8RQtBzck+aqCGfRZEY1Br9tqzAs+2paoqIASBGbhdgZPKIv5YRedhVtqc8mOYIKvGoDa0O4Q
	j2JZw9AwSUXaPnF5xyfmFZhmxj8JEI6akUutInTTzpNtpIRtFlptptwRnLKby+s+Ng6+yfa7JDf
	Py+V6IVH1QxA4I9SIMfiboN+a0LJTRrq6tbsbZ5V+GVnFrgOEG2dVAtnTi+qoDpSGD/DKEojdIZ
	oOKNK7W4T7DHhgM2INfr6KmshGIdhAPfnREeIdKwpscbAlhKrvwOSTfSd70M4Fp4byy5SQbEBf9
	eONe1zLmlGmosPu+u9BZtHnA/4Kw==
X-Received: by 2002:a5d:458b:0:b0:460:1387:19f6 with SMTP id ffacd0b85a97d-4619f3cfa3fmr3458320f8f.36.1781601293594;
        Tue, 16 Jun 2026 02:14:53 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619b9b7750sm14890498f8f.6.2026.06.16.02.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:14:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:14:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 5/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Message-ID: <ajEUClmHBPiiB4eC@pathway.suse.cz>
References: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
 <20260608-restricted-pointers-final-v4-5-9a436615799e@linutronix.de>
 <20260611120615-4252b75d-55aa-4bed-b64b-0316b2148d2c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611120615-4252b75d-55aa-4bed-b64b-0316b2148d2c@linutronix.de>

On Thu 2026-06-11 12:09:08, Thomas Weiﬂschuh wrote:
> On Mon, Jun 08, 2026 at 04:21:45PM +0200, Thomas Weiﬂschuh wrote:
> > Depending on the system configuration, the restricted pointer formatting
> > might call into the security subsystem which takes spinlocks, which
> > might sleep under PREEMPT_RT. As %pK is intended to be only used from
> > read handlers of virtual files, which always run in task context,
> > this should not be a problem in practice.
> > However, developers have used %pK before from atomic context without
> > realizing this restriction. While all existing user of %pK through
> > printk() have been removed, new ones might be reintroduced accidentally
> > in the future.
> > 
> > Add a lockdep annotation to unconditionally introduce a fake spinlock in
> > restricted_pointer(), so lockdep can detect misuse even if the current
> > test system configuration would not exhibit the issue.
> > This is intentionally a single lock instance shared by all callers,
> > as that mirrors what can happen in the security subsystem.
> > 
> > This check comes intentionally after the in_task() one, to have the
> > clearer diagnostic first when the function is called from IRQ context,
> > which will trigger both.
> > 
> > Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> > Link: https://lore.kernel.org/lkml/20241217142032.55793-1-acarmina@redhat.com/
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  lib/vsprintf.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 09e0e5194d41..728a1acd69ae 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -864,7 +864,14 @@ static noinline_for_stack
> >  char *restricted_pointer(char *buf, char *end, const void *ptr,
> >  			 struct printf_spec spec)
> >  {
> > +	/*
> > +	 * has_capability_noaudit() may use spinlocks.
> > +	 * Make sure %pK is only used from valid contexts.
> > +	 */
> > +	static DEFINE_WAIT_ASSERT_MAP(vsprintf_restricted_pointer_map, LD_WAIT_CONFIG);
> > +
> >  	lockdep_assert(in_task());
> > +	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
> 
> The kernel test robot found a lockdep violation with this patch:
> https://lore.kernel.org/all/202606110945.d3871219-lkp@intel.com/
> 
> My suspicion is that this is a pre-existing problem that was not visible
> to lockdep so far, exactly what this patch is supposed to mitigate.
> I'll investigate some more and try to reproduce it.

I was curious and found the following. The problematic patch seems to be:

[   92.754552][ T3827]   lock_acquire (locking/lockdep.c:5868)
[   92.757345][ T3827]   class_lock_map_acquire_constructor (linux/lockdep.h:557 (discriminator 1))
[   92.759895][ T3827]   restricted_pointer (vsprintf.c:874)
[   92.770231][ T3827]   pointer (vsprintf.c:2582)
[   92.772166][ T3827]   vsnprintf (vsprintf.c:2956)
[   92.774145][ T3827]   seq_printf (seq_file.c:392 seq_file.c:407)
[   92.776083][ T3827]   tcp6_seq_show (ipv6/tcp_ipv6.c:2147 (discriminator 1) ipv6/tcp_ipv6.c:2221 (discriminator 1))
[   92.778212][ T3827]   traverse (seq_file.c:112)
[   92.780125][ T3827]   seq_lseek (seq_file.c:324 (discriminator 1))
[   92.782106][ T3827]   proc_reg_llseek (proc/inode.c:283)
[   92.789616][ T3827]   __ia32_sys_lseek (read_write.c:391)
[   92.791786][ T3827]   ia32_sys_call (kbuild/obj/consumer/i386-randconfig-013-20260610/./arch/x86/include/generated/asm/syscalls_32.h:20)
[   92.793792][ T3827]   __do_fast_syscall_32 (x86/entry/syscall_32.c:83)
[   92.795973][ T3827]   do_fast_syscall_32 (x86/entry/syscall_32.c:332)
[   92.797992][ T3827]   do_SYSENTER_32 (x86/entry/syscall_32.c:370)
[   92.799987][ T3827]   entry_SYSENTER_32 (x86/entry/entry_32.S:835)

If I get it correctly then traverse() might take spin_lock_bh(lock)
via:

 + traverse()
   + tcp_seq_start()
     + tcp_get_idx()
       + established_get_idx()
	 + established_get_first()
	  + spin_lock_bh(lock);

And then it calls vsnprintf(" %pK" in

  + tcp6_seq_show()
    + get_tcp6_sock()
      + seq_printf()

By other words, it calls vsnprintf("%pK") with disabled softirqs.

If I get it correctly then this might create a deadlock because
vsnprinf("%pK") can be called also with (soft)irqs enabled,
then soft(irq) might came and want to take the spin_lock(lock)...

As a result, we should not use %pK in tcp6_seq_show().

Best Regards,
Petr
