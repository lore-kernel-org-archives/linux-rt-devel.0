Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D75224C694
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284481; cv=none; b=pta037+tZlqRCEN+cdUu0MuHxBaWa9aoHjUKHMf/X9XcDSNRuMwDaMFieqWcctfRCjmhSyP8O5su1Zae7Jpv4WcAqEMRM0UX7dw3ooTC91+ooERqqiZzDVPKYg+91rQuPWs8ultrlMUu3wIzNcRqN/+GQlFVxV+o1fe7/uLJAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284481; c=relaxed/simple;
	bh=fWyMQLn4yLP4Imj5JVok+6j6i+bMIv2+UnKhp6NUsFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz/yZucGNfpTbJrNvhlJNR7vmvK0UdTNPmSENiBs6c8jWm/PrhXQbH9i//8mKDK/6322ulCCeHLgth6LYcwwaNxphc/exCCNhPKFov2otVeRPqAGt+VL2cojhu+3GYlbDokaaWNKaMIM4ACgmJ9EpCuzIWgxDtjWror9rQoOWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEAqrlC3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEAqrlC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739284478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z4v0Gu1VZ5S/3jICytTcnROn9VRGURI+wKWgp6ANjQ=;
	b=eEAqrlC3n7rzwTeOXWiLLDnXC2uXs2L6t4DpA3qOW03ZIGzYE4UMtLSpSD9VA7zO91Y3fJ
	daIu1MZjZQ4a8WUAyhWUYqESs78l9AxqoYiTpdgdw10KrQih4RGqOMr4N4kFG3DAnjUl8Z
	d088Z6zCk8EToSFYIlZkmjnpTZDRSIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-qYkoHTQ8OMilXTwvVLY07w-1; Tue,
 11 Feb 2025 09:34:32 -0500
X-MC-Unique: qYkoHTQ8OMilXTwvVLY07w-1
X-Mimecast-MFC-AGG-ID: qYkoHTQ8OMilXTwvVLY07w
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5DB81800879;
	Tue, 11 Feb 2025 14:34:28 +0000 (UTC)
Received: from localhost (unknown [10.22.80.65])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6433C18004A7;
	Tue, 11 Feb 2025 14:34:27 +0000 (UTC)
Date: Tue, 11 Feb 2025 11:34:26 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: debug_exception_enter() disables preemption and may call
 sleeping functions on aarch64 with RT
Message-ID: <Z6tf8iDhNriSGjeC@uudg.org>
References: <Z6YW_Kx4S2tmj2BP@uudg.org>
 <Z6n16cK85JMyowDq@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6n16cK85JMyowDq@J2N7QTR9R3>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 10, 2025 at 12:49:45PM +0000, Mark Rutland wrote:
> On Fri, Feb 07, 2025 at 11:22:57AM -0300, Luis Claudio R. Goncalves wrote:
> > Hello!
> 
> Hi,
> 
> > While running ssdd[1] from rt-tests on an aarch64 kernel with PREEMPT_RT and
> > debug features enabled, this bug was triggered on every single run:
> > 
> > [1] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/ssdd/ssdd.c
> > 
> > # ssdd
> > 
> > [  273.115597] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > [  273.115607] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6077, name: ssdd
> > [  273.115611] preempt_count: 1, expected: 0
> > [  273.115614] RCU nest depth: 0, expected: 0
> > [  273.115617] 1 lock held by ssdd/6077:
> > [  273.115620]  #0: ffff07ffd77893e0 (&sighand->siglock){+.+.}-{3:3}, at: force_sig_info_to_task+0x58/0x200
> > [  273.115642] Preemption disabled at:
> > [  273.115644] [<ffffad24518bd1f4>] debug_exception_enter+0x1c/0x80
> > [  273.115653] CPU: 47 UID: 0 PID: 6077 Comm: ssdd Not tainted 6.13.0-rt3 #1 PREEMPT_RT
> > [  273.115659] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS F31n (SCP: 2.10.20220810) 09/30/2022
> > [  273.115662] Call trace:
> > [  273.115664]  show_stack+0x34/0x98 (C)
> > [  273.115670]  dump_stack_lvl+0xa8/0xe8
> > [  273.115675]  dump_stack+0x1c/0x38
> > [  273.115680]  __might_resched+0x254/0x330
> > [  273.115686]  rt_spin_lock+0xcc/0x220
> > [  273.115692]  force_sig_info_to_task+0x58/0x200
> > [  273.115697]  force_sig_fault+0xd0/0x120
> > [  273.115702]  arm64_force_sig_fault+0x48/0x80
> > [  273.115707]  send_user_sigtrap+0x88/0xe8
> > [  273.115712]  single_step_handler+0x100/0x160
> > [  273.115717]  do_debug_exception+0x94/0x160
> > [  273.115722]  el0_dbg+0x54/0x150
> > [  273.115727]  el0t_64_sync_handler+0x134/0x138
> > [  273.115732]  el0t_64_sync+0x1ac/0x1b0
> > 
> > The ptrace usage in ssdd eventually exercises the code path that starts on
> > el0t_64_sync_handler() and may end up calling do_debug_exception(), which
> > calls debug_exception_enter() that disables preemption.
> > 
> > Looking at the backtrace, later in the call chain force_sig_info_to_task()
> > tries to take a spinlock, which on PREEMPT_RT becomes a rtmutex and could
> > sleep in case of contention. That triggers the "BUG: sleeping function
> > called from invalid context" warning.
> > 
> > It is also possible to reproduce the problem in an aarch64 kernel with
> > PREEMPT_RT enabled, no extra debug features, by running ssdd in a loop.
> > With that we can see not only the backtrace reported above but also other
> > instances where the process is scheduled out while preemption is disabled:
> > 
> > # while :; do ssdd; done
> > 
> > [  754.673678] BUG: scheduling while atomic: ssdd/7340/0x00000002
> > [  754.673682] Modules linked in: qrtr rfkill sunrpc vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu igb ipmi_devintf ipmi_msghandler arm_dmc620_pmu arm_cmn cppc_cpufreq arm_dsu_pmu loop dm_multipath nfnetlink xfs nvme ghash_ce sha2_ce sha256_arm64 nvme_core sha1_ce nvme_auth sbsa_gwdt ast i2c_algo_bit i2c_designware_platform xgene_hwmon i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod fuse
> > [  754.673703] Preemption disabled at:
> > [  754.673703] [<ffffa87a17ca470c>] do_debug_exception+0x54/0x100
> > [  754.673710] CPU: 102 UID: 0 PID: 7340 Comm: ssdd Kdump: loaded Not tainted 6.14.0-rc1 #1
> > [  754.673712] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS F31n (SCP: 2.10.20220810) 09/30/2022
> > [  754.673713] Call trace:
> > [  754.673714]  show_stack+0x34/0x98 (C)
> > [  754.673718]  dump_stack_lvl+0x80/0xa8
> > [  754.673721]  dump_stack+0x18/0x2c
> > [  754.673722]  __schedule_bug+0x90/0xc0
> > [  754.673726]  schedule_debug.isra.0+0x128/0x158
> > [  754.673728]  __schedule+0x68/0x690
> > [  754.673731]  schedule_rtlock+0x24/0x50
> > [  754.673733]  rtlock_slowlock_locked+0x1c0/0x350
> > [  754.673735]  rt_spin_lock+0xcc/0x130
> > [  754.673737]  obj_cgroup_charge+0x54/0x138
> > [  754.673740]  __memcg_slab_post_alloc_hook+0xcc/0x300
> > [  754.673743]  kmem_cache_alloc_noprof+0x304/0x338
> > [  754.673745]  __send_signal_locked+0x90/0x428
> > [  754.673748]  send_signal_locked+0xe4/0x140
> > [  754.673750]  force_sig_info_to_task+0xd0/0x160
> > [  754.673753]  force_sig_fault+0x6c/0xa8
> > [  754.673755]  arm64_force_sig_fault+0x48/0x80
> > [  754.673757]  send_user_sigtrap+0x54/0xd0
> > [  754.673759]  single_step_handler+0xc4/0xe0
> > [  754.673761]  do_debug_exception+0x7c/0x100
> > [  754.673762]  el0_dbg+0x40/0x158
> > [  754.673766]  el0t_64_sync_handler+0x134/0x138
> > [  754.673768]  el0t_64_sync+0x1ac/0x1b0
> > 
> > In this case one of the local_lock_* calls in (the functions called by)
> > obj_cgroup_charge() seems to hit contention and, as it is dealing with
> > rtmutexes, be effectively scheduled out to sleep.
> > 
> > The scary comment on top of debug_exception_enter() provides a reason for
> > preemption being disabled at that point, but it seems to open a can of worms
> > for PREEMPT_RT usage:
> > 
> >     /*
> >      * In debug exception context, we explicitly disable preemption despite
> >      * having interrupts disabled.
> >      * This serves two purposes: it makes it much less likely that we would
> >      * accidentally schedule in exception context and it will force a warning
> >      * if we somehow manage to schedule by accident.
> >      */
> >
> > This is the data I gathered so far, using both v6.13.0-rt3 and 6.14.0-rc1
> > for testing. But due to my ignorance wrt the debug exception treatment in
> > aarch64 I can't devise a solution for the observed behavior.
> > 
> > Any suggestions or comments?
> 
> I don't have an immediate suggestion; I'll need to go think about this
> for a bit. Unfortunatealy, there are several nested cans of worms here.
> :/
> 
> In theory, we can go split out the EL0 "debug exceptions" into separate
> handlers, and wouldn't generally need to disable preemption for things
> like BRK or single-step.

If this is an acceptable workaround, until we have the real solution,
I can work on that :)

Luis

> However, it's not immediately clear to me how we could handle
> watchpoints or breakpoints, since for those preemption/interruption
> could change the HW state under our feet, and we rely on single-step to
> skip past the watchpoint/breakpoint after it is handled.
> 
> That, and last I looked reworking this we'd need to do a larger rework
> to split out those "debug exceptions" because of that way that currently
> bounces through the fault handling ligic in arch/arm64/mm/.
> 
> Mark.
> 
---end quoted text---

