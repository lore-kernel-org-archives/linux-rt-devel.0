Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEEE34389B
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779236633; cv=none; b=PrZb9w/pldLpbx7TZhPxTyloT3f7biNHYVJG0kyqqgTsHNoudx5tL5DcvN2QsnWNc5nUulVqpjlAQ+lkzAoSd/9VzUi+a5u8u/qknzhn2ofoJBIlVIK/phEw4SczdXb9P7AGUqA2/KWKG3uBBNV1JMy5JaXNk7O4kZPP/fF/MA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779236633; c=relaxed/simple;
	bh=yy20QARQO+iR3rXtKnJSUEWuwsSC90xgco3VbkyCqac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=N1/i0yHoVHyeOg8f4N3/reHxaIs6Jo1or3Fh45ehBHhLqPj1SxDB5QeR5+FlooYuP5fUcsgeHKpRD8E8lGuJRDjdRZSvHzsEUWbveLi0BssxbLNMmkzpmTwaPFsjh0k7tz0+g5DzomkjkFPpMO/2239/PKJqJYE821HAD+abWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuP1kQMD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuP1kQMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779236631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pm9GaObJx0pUzTbnogMJxTLRSXqMju3ZiH9MXVqRNoc=;
	b=MuP1kQMDop5JrgKCh3OjfYUcW4LPbUY0b2LzFl8Zg1ftknKzxoYP1x7/W3HRf4tbJLYW4l
	4/vAV+G3N8pG6pkNVsOBk9laXwdxrgLM/izYCnJNzjsfpVTPSz+V29ASystUPFNuISrXRI
	o3GSzayIg+YflhojxmxcNf4xi8BT/SQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-3-li6haoPeCFkJKbXxi6Kg-1; Tue,
 19 May 2026 20:23:47 -0400
X-MC-Unique: 3-li6haoPeCFkJKbXxi6Kg-1
X-Mimecast-MFC-AGG-ID: 3-li6haoPeCFkJKbXxi6Kg_1779236625
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01E0318005B2;
	Wed, 20 May 2026 00:23:45 +0000 (UTC)
Received: from localhost (unknown [10.22.64.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2738B30001A2;
	Wed, 20 May 2026 00:23:42 +0000 (UTC)
Date: Tue, 19 May 2026 21:23:41 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Waiman Long <longman@redhat.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] arm64/entry: Don't disable preemption in
 debug_exception_enter() with RT kernel
Message-ID: <agz_DYGnUsimJ3xL@redhat.com>
References: <20260519222524.886454-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260519222524.886454-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: LMdUq_ixQrfSFIE_pKiJag84p6OYEooVWnZxZyUDUVo_1779236625
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2026 at 06:25:24PM -0400, Waiman Long wrote:
> Commit d8bb6718c4db ("arm64: Make debug exception handlers visible from
> RCU") introduces debug_exception_enter() and debug_exception_exit()
> where preemption is explicitly disabled. With a PREEMPT_RT debug kernel,
> the following bug report can happen.
> 
>   BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15255, name: gdb_app
>   preempt_count: 1, expected: 0
>   RCU nest depth: 0, expected: 0
>   1 lock held by gdb_app/15255:
>   #0: ffff10007f41b7d8 (&sighand->siglock){..}-{3:3}, at: force_sig_info_to_task+0x34/0x130
>   Preemption disabled at:
>   [<ffff800080081ea8>] debug_exception_enter+0x18/0x70
>     :
>   Call trace:
>   dump_backtrace+0xac/0x130
>   show_stack+0x1c/0x24
>   dump_stack_lvl+0xa0/0xe0
>   dump_stack+0x14/0x2c
>   __might_resched+0x178/0x230
>   rt_spin_lock+0x58/0x120
>   force_sig_info_to_task+0x34/0x130
>   force_sig_fault+0x58/0x80
>   arm64_force_sig_fault+0x44/0x70
>   send_user_sigtrap+0x5c/0xa0
>   brk_handler+0x38/0x5c
>   do_debug_exception+0x78/0x110
>   el0_dbg+0x50/0x1e0
>   el0t_64_sync_handler+0x114/0x150
>   el0t_64_sync+0x17c/0x180
> 
> Fix that by blocking the preempt_disable()/preempt_enable_no_resched()
> calls when CONFIG_PREEMPT_RT is enabled.

Hi Waiman!

Last year Ada Couprie Diaz wrote a patcheseries that enhanced greatly the
ARM64 debug exception code. In the cover letter there is a discussion about
the effect of the patches on RT[0] (look for PREEMPT_RT), explaining that
there are a few remaining known bugs and briefly discussing the best way to
fix then. There is also a discussion[1] about the specific issue you reported.

I took the liberty of adding Ada to the thread.

Best regards,
Luis

[0] https://lore.kernel.org/all/20250707114109.35672-1-ada.coupriediaz@arm.com/
[1] https://lore.kernel.org/linux-arm-kernel/e86c5c3a-6666-46a7-b7ec-e803212a81a1@arm.com/
 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/arm64/kernel/entry-common.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index c7a23f7c2212..191441b22b7c 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -290,15 +290,17 @@ static __always_inline void fpsimd_syscall_exit(void)
>  }
>  
>  /*
> - * In debug exception context, we explicitly disable preemption despite
> - * having interrupts disabled.
> + * In debug exception context, we explicitly disable preemption except for
> + * PREEMPT_RT kernel as rt_spin_lock() can be called.
> + *
>   * This serves two purposes: it makes it much less likely that we would
>   * accidentally schedule in exception context and it will force a warning
>   * if we somehow manage to schedule by accident.
>   */
>  static void debug_exception_enter(struct pt_regs *regs)
>  {
> -	preempt_disable();
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_disable();
>  
>  	/* This code is a bit fragile.  Test it. */
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
> @@ -307,7 +309,8 @@ NOKPROBE_SYMBOL(debug_exception_enter);
>  
>  static void debug_exception_exit(struct pt_regs *regs)
>  {
> -	preempt_enable_no_resched();
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_enable_no_resched();
>  }
>  NOKPROBE_SYMBOL(debug_exception_exit);
>  
> -- 
> 2.54.0
> 
> 
---end quoted text---

