Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF0832BF27
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610750; cv=none; b=Nfpir5uXJfyGRG/LBU3PTAWdWfG6oaORGcedyXqW9c+XJp99KUigE0Jx5Z09RrpyUTSKsFJjKR2whuQ1SCtV5aPqSQjaX/QjwkcSx7+B9P6txjyfI/qUbXcT0LcSwsQ6Mj2vK9NVnlJo2HyhgypLfxmjjMlZjbX4Z7XrCEiSvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610750; c=relaxed/simple;
	bh=LTIwfz+7ZLiUBkdM0n+yvwk0UNAWmFYk9FAr8uWbKkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW11trGDIjRuwaedazBiziYWeejfmQo/zqWOMZxeG+a270zB9bLrcsue4f48qm10DRCdbzknyrGIqbTX/vptlZlItexiL2IJ3irwtuShxZXtbSgVnQr79Gzq9C+MucacSzUUSRcDXxxjkVezDFVhj9OoadqJIdZGcvBeT/YPWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cRFxD54u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cRFxD54u"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb73394b4so796179866b.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755610747; x=1756215547; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24+DhovLXRowK75nxtwEh/hEzG0jJ1R1pyylOLaj9mw=;
        b=cRFxD54uFjd9n8rVtIBRa9uIuxAg77cl9dhvGQ23nQp5e+13zZp6/ZCYk81jUr6Ilb
         pBvlzSUPgdmfqDTCP+3kiJra1OMSxUizWiu45Qd5wNO+wFHlo88izBAizCzuy/zIJ0wb
         rtHP0KAqz+WIfGE24lAnou5ssnhAeqBj4fH++lbz0pOB48TvoBNfGhcE82dHp33euYAe
         vQL3wD4QY24AGFyQxYXMwDRuTBAK9yJ4Inpl6Y8pGs101KJYOrQQoQgEwTuKlbpbkLBx
         v908HqwVyMs/qL4xhwAO6u4YB7AsNbZUWHEhPKtI4Z32xbjmu0fnnFaAvSRWLMi26wXv
         iJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610747; x=1756215547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24+DhovLXRowK75nxtwEh/hEzG0jJ1R1pyylOLaj9mw=;
        b=aLLEOpr3s6u26UInqrx0BeWx45YJ6ylsld6C/K7FJNOLiOhngQp90CwSgbOfrfKI16
         dfR5bQXTbYHnlsPuotUPbCCardM7ZRL6Eue/FZn4hCz5fM9wUWVhmu/2gdnNqLI1Yp1y
         nu5Qt7u96ui24tsKMbFOH+53RLuNoHuWlFe93vUrwX963gOYSe/Cm9vN0bp5Z6pDfqls
         qtNH5R6S7NIMzrN2muoZA6Ge/2uEI+0S3Gf7g4WUQiaapD7BXCZ+QoVi56N5Kia9kVnj
         3n/xidLlKBTuhrN6hy/SzBkll2Newa5TR7pJ/rcyciXYKE8ZpVeljE78D8iP/kIdIIkO
         ojQg==
X-Forwarded-Encrypted: i=1; AJvYcCVvpjjHB5Lh4kVLs+GDfC1LfHWw+ioPQ0JV9QMdj94O69fQfwoSccqtgdWGZqq3fLAYS54klrQN82k8dBoN6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxZxqaNONIpSLSth+EmVG9JBPepqxVEoB48mDBM0/N/YQX/zeV
	PMFmfiavM3l8N1rvs6fh0H8dEZYt2VqMN+hBzdJ57yM/Cg8p6oWm6PjVctQWbUwgBMM=
X-Gm-Gg: ASbGncvhldZrGY4p2AXQUfDVfJm+HT2V/5nlZQZl3VQZB80UOP2IM0J/F3t1Y1RU/LE
	wz7kWaKDsJHBB5LUizXxZAiKyUTUQWBkhOHSGRU+YzfSqzD9dndDAvtqrjSZitquI5ZpFKzeIUY
	fq9V/PFYsrR5bPM14lIlxVWsXHOGV0YlaC9MO2tIp2XzwODxEASG2u6j/ZcqAx+onU9S/5gr4E/
	KM5pKbHH/q9oX/cJLMFeRc79+x/zTlNr7ufSlL6scp5bOZEO11o3LOfYS5N37mesFH2tCpUqY+r
	PSrdmDkKuJZLtC9J6PVvc5jvo9WXPCmXikoDWKh+9cvKTHhav3hxWh7tg8Q5p62QdJFJx/yaZQh
	ou/wKnM7L8WDkWCR096mY8yKxbQpXiK7P9Z0q
X-Google-Smtp-Source: AGHT+IFp0IGZ5ZPsxOx8ZOcQIH9irjrlcYZTRa9qnfGYi1fwrDmtMMTExjhy4Qa5CnmntZ1UkEbjfA==
X-Received: by 2002:a17:907:86a9:b0:afa:1ef1:342a with SMTP id a640c23a62f3a-afddcb8326bmr270992966b.20.1755610746926;
        Tue, 19 Aug 2025 06:39:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccd37sm1012541266b.80.2025.08.19.06.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:39:06 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:39:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: cuiguoqi <cuiguoqi@kylinos.cn>
Cc: catalin.marinas@arm.com, will@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org, farbere@amazon.com,
	guoqi0226@163.com, tglx@linutronix.de, akpm@linux-foundation.org,
	feng.tang@linux.alibaba.com, joel.granados@kernel.org,
	john.ogness@linutronix.de, namcao@linutronix.de,
	takakura@valinux.co.jp, sravankumarlpu@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] printk: Fix panic log flush to serial console during
 kdump in PREEMPT_RT kernels
Message-ID: <aKR-eBMoMBa4fnrF@pathway.suse.cz>
References: <20250807112247.170127-1-cuiguoqi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807112247.170127-1-cuiguoqi@kylinos.cn>

On Thu 2025-08-07 19:22:47, cuiguoqi wrote:
> When a system running a real-time (PREEMPT_RT) kernel panics and triggers kdump,
> the critical log messages (e.g., panic reason, stack traces) may fail to appear
> on the serial console.

How did you find this problem, please?
Were you investigating why a log was missing?
Or was is just be reading the code?

By other words, is this problem theoretial or did you found
it when debugging a real life problem?

I ask because there is no ideal solution. This change might help
in one situation and make it worse in other situations.
See below.

> When kdump cannot be used properly, serial console logs are crucial,
> whether for diagnosing kdump issues or troubleshooting the underlying problem.
> 
> This issue arises due to synchronization or deferred flushing of the printk buffer
> in real-time contexts, where preemptible console locks or delayed workqueues prevent
> timely log output before kexec transitions to the crash kernel.
> 
> The test results are as follows:
> [  T197] Kernel panic - not syncing: sysrq triggered crash
> [  T197] Call trace:
> [  T197]  dump_backtrace+0x9c/0x120
> [  T197]  show_stack+0x1c/0x30
> [  T197]  dump_stack_lvl+0x34/0x88
> [  T197]  dump_stack+0x14/0x20
> [  T197]  panic+0x3c4/0x3f8
> [  T197]  sysrq_handle_crash+0x20/0x28
> [  T197]  __handle_sysrq+0xd4/0x1e0
> [  T197]  write_sysrq_trigger+0x88/0x108
> [  T197]  proc_reg_write+0x9c/0xf8
> [  T197]  vfs_write+0xf4/0x450
> [  T197]  ksys_write+0x70/0x100
> [  T197]  __arm64_sys_write+0x20/0x30
> [  T197]  invoke_syscall+0x48/0x110
> [  T197]  el0_svc_common.constprop.0+0x44/0xe8
> [  T197]  do_el0_svc+0x20/0x30
> [  T197]  el0_svc+0x24/0x88
> [  T197]  el0t_64_sync_handler+0xb8/0xc0
> [  T197]  el0t_64_sync+0x14c/0x150
> [  T197] SMP: stopping secondary CPUs
> [  T197] Starting crashdump kernel...
> [  T197] Bye!
> 
> Signed-off-by: cuiguoqi <cuiguoqi@kylinos.cn>
> ---
>  arch/arm64/kernel/machine_kexec.c | 4 ++++
>  kernel/panic.c                    | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 6f121a0..66c7d90 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -24,6 +24,7 @@
>  #include <asm/page.h>
>  #include <asm/sections.h>
>  #include <asm/trans_pgd.h>
> +#include <linux/console.h>
>  
>  /**
>   * kexec_image_info - For debugging output.
> @@ -176,6 +177,9 @@ void machine_kexec(struct kimage *kimage)
>  
>  	pr_info("Bye!\n");
>  
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && in_kexec_crash)
> +		console_flush_on_panic(CONSOLE_FLUSH_PENDING);

IMHO, this is a bad idea. console_flush_on_panic() is supposed
to be called as the last attempt to flush the kernel messages
when there is no other chance to see them.

console_flush_on_panic() ignores console_lock() because it might
create a deadlock. This why vpanic() calls debug_locks_off() first.
But ignoring a synchronization might obviously bring another problems,
and break the system another way.

console_lock() should _not_ be ignored when we try to create
crash_dump(). It would increase the risk that the crash_dump
would fail. And crash_dump() is the preferred way to preserve
the kernel messages in this code path.

> +
>  	local_daif_mask();
>  
>  	/*
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 72fcbb5..e0ad0df 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -437,6 +437,8 @@ void vpanic(const char *fmt, va_list args)
>  	 */
>  	kgdb_panic(buf);
>  
> +	printk_legacy_allow_panic_sync();

I do not like this as well.

The commit message for the commit  e35a8884270bae1 ("printk:
Coordinate direct printing in panic") says that the primary
purpose is to disable flushing legacy consoles when printing
the backtrace by dump_stack(). This change looks OK from this POV.

But we wanted to delay this after __crash_kexec() and
panic_other_cpus_shutdown() because the legacy consoles
are not safe in panic(). They ignore the internal spin locks
after calling bust_spinlocks(1).

This change would increase the risk that __crash_kexec() would
fail. Also the legacy consoles are more safe after stopping
other CPUs.

IMPORTANT: The legacy consoles are blocked only when some
	"nbcon" console is registered. And nbcon consoles are never
	blocked. It guarantees that the messages are flushed on some
	consoles even before this call.

> +
>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
>  	 * everything else.
> @@ -450,8 +452,6 @@ void vpanic(const char *fmt, va_list args)
>  
>  	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
>  
> -	printk_legacy_allow_panic_sync();
> -
>  	/*
>  	 * Run any panic handlers, including those that might need to
>  	 * add information to the kmsg dump output.

Best Regards,
Petr
