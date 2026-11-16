Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843049;
	b=ilEIB5cI1AqO5nyEsnhQDv2XTyAQG7fGhvIuDzb6nyCk5cIDqwLc4XNz1VyYfpDq/PM/
	 mHZSF9X3+kP1CbqCw1G/T6j0ucR09X77ernA6tTeEMhvFYilHILC/5e18YMZvUgB8+f/x
	 OXynluIn1FenXgcpn/5Rwa4opK2BB78RYc+s7gqRIt7J2ldXZ3Z5RUTYoNFe2HJv1pRsu
	 6aPUy2fB+IUFS7kOHCxMq8CK94/GZNJzk9oclukG7VCrHaP+BfQeJIVVKw7cPvWnIGW/g
	 ace9ZlBeRX/7UbMmBTZjL5++oz7dd5iuivzlJOaHsrllocEpOhsDfJZGOHAT5TeFNeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hPr9IOYFjtJaYI4q2QerjW2bLfRzLv1kPuZUspzu/XY=;
	b=wpus4ko0PVmYTDiux8+qSjduP4lt065FSXH1CYVD7cuhw+rAF1pHjRO8SapuloEqRBzc
	 mv1bsBSgdXBt987TRKCGiIrk311tOSCLdf6N6HY/Euk89zC7m+oY7/KDw6COXAhuFoVJp
	 6mkj1d2qRScy/KH3cKxlE227MU95M9vsCjqlRDqnn7jjAlhmPQEn6rjZUXYcPqGga1RuJ
	 fCqMi72OQwDsySJktSzB0ixACBmAKBnLaikEL4tDcpl4mz+HAFYVLMR1q1f51/HIJTFO6
	 Pwhw1xOtr2nVd28VK7eavvNmZbxvKg20Z5EAlnIIphwFw1CJUY8LwkaXKOjz/Kj+cnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TW3F5G04;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64835606A33B
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64835606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TW3F5G04
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb606491faso11411535e9.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794843047; x=1795447847; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hPr9IOYFjtJaYI4q2QerjW2bLfRzLv1kPuZUspzu/XY=;
        b=TW3F5G041sWrQOjb6DUOfb/wHSzjlPj0aeJRpb9jF13GV6dPcJqcXw7wRSGJrkFKaX
         4J9wOUP5rjKqUCl0DMheDojIuG6/SCzje4/qDCEyPiq86frbyMfnFNVVFfFtcFV2bc9/
         DGZbg5mlOLjlcFacHBd7jyCBjql7vAQ0EfQLXDPpPL16KhVG/7GyLmRM0r+boJLKuJcV
         ERaIblejTUYvwozghJBDe27i4g3w4ENAKo2JhmrZ1i5aWJLPNKneSr1cfSyBLFO03pkp
         UfebN66qCzLCbKL27iZpOn5QZ7sdlgq4M0sjGidWi099br3NCcgHgqzsYFQjSwAb4F0M
         FHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794843047; x=1795447847;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPr9IOYFjtJaYI4q2QerjW2bLfRzLv1kPuZUspzu/XY=;
        b=ZdjmCo+ocM5lpZWkYU/tcKARl3nyVPhu/OIwZviS848SnkJMaJJGNleQPH5Yk9L1Lq
         XSd2lACx4g3OGuWEXO0AnNMXOzG2Vv6O5rr3xS/CMOdN4gVgLPSI99k+viQnUEOPdyt+
         AxiO3S0UxSFclC5Q2HaStp0/1RAJWGBuHl978wxHAFnOIZgbVwZWvfckZbbA2s/K8DYk
         LP/7RE+ekZgGiNMz0qmSI0tYFyEeajcgLdKiYp6SL97S6tlu0nW6u3F1uTXTYiBQQiyJ
         ca9eFpqya2yfpJALB9P9sorSYJ6yEdzzHF1kiAdg9oHhxw1SequeXFSHqRkRrxPDvmfm
         3t0Q==
X-Forwarded-Encrypted: i=1; AL+hErFHRtorjAwEEJKCmjDipofheuPpLT0lZ+85NAfS8Ln7RVtUQS5lkxzuu7ldgVN59EREeHgzmMFSOfoAHzn8qA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+yuiQSWZEzGkG1BbkhdH7MU2ebsGG4XU2tenoJUOi6z20fGQGr
	jjj9ygc5H3XV3DYdVfB5jSNo9+deSq1f3cr6Np8TaSXc3dNt/b+x0WyNTkq9mvG/Iq0=
X-Gm-Gg: AYBFou08ysg4gh5pttncqKNGanyhGFWSZMIjgotSku4Oxesh8InV5JDrjRI7o2cJo67
	nNfIaTiI0lbRn5tpFBv45SBv0DWzTRv+5bws4NtyJlv+MkZqVvNdZb79y5Dx2dPmj+j43s2veNi
	A//9gG/WgRSOqtpYrhoj8igvCxym9KcgTj3xJNtQ+A3wI5VTrlWVXy1iMg71bnRJpqgCaFgC9yC
	ohPcXLO5tE1SzsucFRnNx9OuR58ZACp8nS/1JgCDWCT+q38TxtAJl8vYP1xBAQwIsMDn31pij1X
	7cQgvBYhtxgmXSOiHyIH7pyuT+bUqZhdH0CgNpW1lKpaYqBGWWu0/zIbHJSAXGTgsHcLEVUyKBy
	0akeqCKt9FNxSKM7htgSgetLy3mLr1O3SwvUNgh75X3Jlud8MC9+ijYVqgQdXtNsqnoBRUSUi2q
	0gGwRyWbRLVbZSuGkgjy4vQMjhi1eay+Hsh+0WYc5NxpkPOqUxR4pPvVEAJ8UFB5Ulp62PmSkYR
	CVqgd/L968SsHjjAZBQnWAAwnkt5mBztphBG5g0TQM97BA4VWOD94RUbFw+ei9UT4QRr2EDkmCq
	J25zIEAYklufgPQk+PgPgDV49qOsh6A=
X-Received: by 2002:a05:600d:8449:b0:4bb:5f07:10d7 with SMTP id 5b1f17b1804b1-4bb5f07134dmr146384475e9.26.1794843046610;
        Mon, 16 Nov 2026 07:30:46 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae5299sm315252695e9.11.2026.11.16.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:30:45 -0800 (PST)
Date: Mon, 16 Nov 2026 16:30:42 +0100
From: Petr Mladek <pmladek@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: john.ogness@linutronix.de, rostedt@goodmis.org,
	senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev,
	hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH v2 1/5] panic, sys_info: Fix duplicate and dropped
 all-CPU backtraces in panic
Message-ID: <avshouTNBIeM5qtP@pathway.suse.cz>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-2-atomlin@atomlin.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103024453.922373-2-atomlin@atomlin.com>

On Mon 2026-11-02 21:44:49, Aaron Tomlin wrote:
> When sys_info() was factored out of kernel/panic.c by
> commit b76e89e50fc3 ("panic: generalize panic_print's function to show
> sys info"), __sys_info() gained an unconditional call to
> trigger_all_cpu_backtrace() when SYS_INFO_ALL_BT is set, while
> panic_other_cpus_shutdown() retained its own call to
> panic_trigger_all_cpu_backtrace().
> 
> This causes two problems during a kernel panic:
> 
>     1.  vpanic() invokes panic_trigger_all_cpu_backtrace() inside
>         panic_other_cpus_shutdown() before stopping secondary CPUs, and
>         then invokes trigger_all_cpu_backtrace() a second time inside
>         sys_info(panic_print) after secondary CPUs have already been
>         shut down, stalling for up to 10 seconds waiting for offline
>         CPUs to respond to NMIs. Furthermore, if SYS_INFO_ALL_BT is
>         configured via the kernel.kernel_sys_info sysctl rather than
>         panic_print, panic_other_cpus_shutdown() misses it prior to CPU
>         shutdown.
> 
>     2.  If sys_info(SYS_INFO_ALL_BT) is invoked on the panicking CPU
>         prior to panic_other_cpus_shutdown(), calling
>         trigger_all_cpu_backtrace() directly bypasses
>         panic_trigger_all_cpu_backtrace() and leaves
>         panic_triggering_all_cpu_backtrace unset. Because panic_cpu is
>         already active, vprintk_emit() silently drops all NMI backtrace
>         messages originating from non-panic CPUs.
> 
> Export panic_trigger_all_cpu_backtrace() with a panic_on_this_cpu() and
> one-shot guard so all-CPU backtraces are only emitted once before
> secondary CPUs are stopped, consult sys_info_get_mask(panic_print) in
> panic_other_cpus_shutdown(), record prior Oops stack dumps in
> panic_try_start(), and route SYS_INFO_ALL_BT in __sys_info()
> through panic_trigger_all_cpu_backtrace() on the panicking CPU.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -451,13 +452,21 @@ bool panic_try_start(void)
>  	old_cpu = PANIC_CPU_INVALID;
>  	this_cpu = raw_smp_processor_id();
>  
> -	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
> +	if (!atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
> +		return false;
> +
> +	if (atomic_read(&panic_redirect_cpu) == PANIC_CPU_INVALID &&
> +	    (test_taint(TAINT_DIE) || oops_in_progress))
> +		panic_this_cpu_backtrace_printed = true;

This would be pretty hard to maintain. The complexity of the check
shows how many code paths affect the decision. I can't imagine how
to synchonize all the pieces this way.

We need another approach. I remember that I have already proposed
something some time ago.

The idea was to enhance sys_info() API to remember what has already
been printed. trigger_all_cpu_backtrace() and frieds should
not longer be called directly. They should be called only via
sys_info() API.

See https://lore.kernel.org/all/aj5tFiwhRqPkAkqU@pathway.suse.cz/
for more details.

I think that this would be a better way to go.
What do you think, please?

Best Regards,
Petr
