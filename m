Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9013033DF
	for <linux-rt-devel@lists.linux.dev>; Wed, 27 May 2026 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896322; cv=none; b=OT+PiIhi2oEG2DzGE3lMapakGwfxMpZXkQPY0Ij6G2y3XIit2BPpdVwbPl0j4Kt7IY1kdhv/fz+5LtiBLRKycA+MQZg0IWDLCsw4GsPQb3bDjqxlRqqHAog9yuoCLBVP26WcIjvWIPyLglSSyetHoeJBhMceNySAJ7lcsDYG5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896322; c=relaxed/simple;
	bh=AiSCf2SvzEfO/M5UoN7hNf2bZmPUZiogKQ7yU8QLODc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXRhVBFe9FjwyckRbBcrOqQsYvqau1zz0norRVHyjoIXG0iHACRTsEugdGxRAAtApArqV+4tmTFkBOJjqmDGbi3SZdXNjQQcYehN2LiOZ7qMfFh97otm92NfFWew8CHtEdvF17+bm97M4UccTJY7Ifum0dTKZRewG4kbebC4v2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V3JqBv7S; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V3JqBv7S"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso9416496f8f.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 27 May 2026 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779896319; x=1780501119; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N+0sHly1saG74fNtjoFtR54rOi6m8O/A/iPVNFJy9CE=;
        b=V3JqBv7SOUUWHMovLKIpI58wtTDwBiSOSxuS/nq/zD36Coe1Na7hbHddwhzubhdY8W
         oKdNkVLNW6n9CgVY8xJoT2P3TkuO3EurGFRq8GbwY37snfDbLtAnMPQJzvzhTYWmpavU
         99mflec3pC01OJqUjbZSnc2kT6jrWVaAy1ibjf3I3C2gfxAC8JXYKIMaLNNIUUgQObHC
         cAzXnenp/GuIr4XbBaz81PwsdMtoX1Mj6n8cAOVmjmTUDT2dMzBMZl4nbXYJLESN4wAn
         PR1Q/OOEsZ+AXY/d9Blxy6GaZ+I5qZWSHGFJwt/rtjTGPc949Dbguf/iPhaHkYLRqZGZ
         MfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896319; x=1780501119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+0sHly1saG74fNtjoFtR54rOi6m8O/A/iPVNFJy9CE=;
        b=i9Hji+5j9+EKVVS6YO+sXUC5lN3jAo+tmdyWa6Nk3wyt0GN1UhJwrOJXw9ZeJnCnDM
         z/g/+05T1ZxiCUQLaW4rUqyK/j2rT1blHrrIHUfLryMCxuk0YqGB+Mtj44AxRi062oH4
         Wdksr55uMzZm6snoQII0wftI+F3Nogzw3kpIQidRDDPzmKZI6HHTMNxjmssiILgEa2Mv
         lPwphVyytHzhSXTXaR+1ZRVxRC1K4uOYP/fVfeb3f6Rv9YTallWMPNgk8FVpqeLTpTW8
         hl6NwXbLy9ylSXhEFEQS+30QawZGDcAl2E3gdl8TIKt4x15OtXEckGP0l3dtRIEbyjKE
         PVpA==
X-Forwarded-Encrypted: i=1; AFNElJ9/C/ntLy5Q48sH+1SqzRx1HUan1LgK9ERPiCMQA+SIip1nzbnKcLzpk+sme6yyDyQSIVRho7kAkRQDoB/6ew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq1VMPVvQzErdZEOK+GVvLmXgWxDobuBS0JSWB5JNV9JQOzi1w
	zCU4Y+aS6myDhziBkI0ZV86LFkVdkvgadJUSfwTD55Y63WxWJiXVjtUr/T7MR8r2Irw=
X-Gm-Gg: Acq92OFq6TOJK7F5J+7oqjiwKZRaEUTjArfUmKufYfpWiuN+yLYOKq9tpFpwiNP2Pa6
	dLETP5ZqrmtgAX0ykAXJh01L9wc3hIA9hNprytTGoxn0T0+9HXKMhdWaLu8VBQjyJztz0yA1R91
	9MenmHoE5oXZSkeAKilnHc3MwXhuTgyNcdNeID19MXn6mDZUyiimBFtY2zM5wMYXXBrj6mjQ+et
	B7T358v0osZdTV3QqHW6ti/Q5G1vm/EBXdhaAF60J1rJLbMNBI0lvsq4XUJmDIACdfeijjIR4eD
	pcvenJkfN46/ZfoMBSN9YHyn6zQrMjDmWCi1h68o+D7pEwGU59QCt2F4ozAiZ7TFINolfhaF4Cx
	0c287uSHlEupZ5NKrDvUj68g0PYQ3Bq6BN1xsrJaw3R+Evrq0QbY9ERN2TpI6g3UEsOltxfL78l
	S/E+//nmvrqkonh5IW3q4WqFTMlLwtTza6dDiS3fXk
X-Received: by 2002:a05:600c:4e0c:b0:489:1a63:509c with SMTP id 5b1f17b1804b1-490422608cemr411908915e9.0.1779896319205;
        Wed, 27 May 2026 08:38:39 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908098cc6esm27933655e9.4.2026.05.27.08.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:38:38 -0700 (PDT)
Date: Wed, 27 May 2026 17:38:36 +0200
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
Subject: Re: [PATCH v3 3/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Message-ID: <ahcP_G9bD9M1_JrC@pathway.suse.cz>
References: <20260520-restricted-pointers-final-v3-0-76bca6a6ab3f@linutronix.de>
 <20260520-restricted-pointers-final-v3-3-76bca6a6ab3f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-restricted-pointers-final-v3-3-76bca6a6ab3f@linutronix.de>

On Wed 2026-05-20 10:40:02, Thomas Weiﬂschuh wrote:
> Depending on the system configuration, the restricted pointer formatting
> might call into the security subsystem which takes spinlocks, which
> might sleep under PREEMPT_RT. As %pK is intended to be only used from
> read handlers of virtual files, which always run in task context,
> this should not be a problem in practice.
> However, developers have used %pK before from atomic context without
> realizing this restriction. While all existing user of %pK through
> printk() have been removed, new ones might be reintroduced accidentally
> in the future.
> 
> Add a lockdep annotation to unconditionally introduce a fake spinlock in
> restricted_pointer(), so lockdep can detect misuse even if the current
> test system configuration would not exhibit the issue.
> 
> Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> Link: https://lore.kernel.org/lkml/20241217142032.55793-1-acarmina@redhat.com/
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  lib/vsprintf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 9f359b31c8d1..021db95087fe 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -29,6 +29,7 @@
>  #include <linux/hex.h>
>  #include <linux/kernel.h>
>  #include <linux/kallsyms.h>
> +#include <linux/lockdep.h>
>  #include <linux/math64.h>
>  #include <linux/uaccess.h>
>  #include <linux/ioport.h>
> @@ -862,6 +863,14 @@ static noinline_for_stack
>  char *restricted_pointer(char *buf, char *end, const void *ptr,
>  			 struct printf_spec spec)
>  {
> +	/*
> +	 * has_capability_noaudit() may use spinlocks.
> +	 * Make sure %pK is only used from valid contexts.
> +	 */
> +	static DEFINE_WAIT_ASSERT_MAP(vsprintf_restricted_pointer_map, LD_WAIT_CONFIG);
> +
> +	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);

Here is Sashiko AI review from
https://sashiko.dev/#/patchset/20260520-restricted-pointers-final-v3-0-76bca6a6ab3f%40linutronix.de

<paste>
Will this single global lockdep map create false dependencies and
inconsistent IRQ usage splats?

Because lock_map_acquire() acquires the fake lock with trylock=0, lockdep
fully tracks it in the dependency graph. Since this is a single global
static map, it acts as a central bottleneck: every lock held by any caller
of %pK forms a forward dependency to the fake lock, and the fake lock forms
a forward dependency to any lock acquired inside %pK. This artificially
links completely independent locking contexts across the kernel, which might
generate massive false-positive circular deadlock warnings.

Furthermore, if %pK is evaluated in an IRQ context, the lock map is marked
USED_IN_HARDIRQ. If it is later evaluated in a process context with IRQs
enabled, the map is marked ENABLED_HARDIRQ. Won't lockdep immediately
trigger an inconsistent IRQ usage splat upon detecting both states?

While using trylock=1 (like lock_map_acquire_try()) might seem like a way
around this, lockdep's check_wait_context() explicitly bypasses wait-context
validation when trylock=1. This would defeat the purpose of this patch.

Is there a different mechanism to assert the wait context without fully
tracking it in the lock dependency graph?
</paste>

My opinion:

The fear of generating massive false-positive cirular locks does
not fit here. It is the opposite. This fake lock represents the
various locks which might be taken by has_capability_noaudit()
on purpose. And %pK formatting must never be used under these
locks because it might create deadlock otherwise.

The fear of inconsistent IRQ usage reports makes some sense.
It might happen and it might be confusing because %pK fomatting
must not be used in IRQ context at all. The misleading IRQ
reports should be prevented by adding the lockdep_assert(in_task)
later in this patch set.

Resume:

This patch looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

>  	switch (kptr_restrict) {
>  	case 0:
>  		/* Handle as %p, hash and do _not_ leak addresses. */

Best Regards,
Petr
