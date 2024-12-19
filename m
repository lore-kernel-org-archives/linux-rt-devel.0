Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD186337;
	Thu, 19 Dec 2024 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627314; cv=none; b=oEoFqf/zgrXc97LTHtnL4c+8c2LADt2kIV2YHA7haw63wBr6axRyxwbfxBhDvFBQktki8oupnz9Q6+kAwNiwoeV58s4B2rzDDK+yhVdcKh8O3iT/xmjsmbjSjGLOQ02Hwyy2lSok4mvg7NJPWTtpcNL+OqQuj3GEbeCAQugBADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627314; c=relaxed/simple;
	bh=taHqxFBlN2jnYnEE4b9B/2oFmRjSF0KgCYVfPRSv2fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD39yVwwMHNZONT3wtP5UzU2clUaQrsLpg3fQ/P5pcQTI3mq2WsiaJMMZPvFK5vgL1+0SPeMCjUmm+6MROPPp3weJmdsZbqZD1sy0EGiNxskLfr1qLWKS/QZFDhHL8Uhe3s+Nf7x5rrZW/cTZSz1Yhu1xFMDMn/PcEahpbFSHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D453C4CECE;
	Thu, 19 Dec 2024 16:55:11 +0000 (UTC)
Date: Thu, 19 Dec 2024 16:55:09 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH v2] mm/kmemleak: Fix sleeping function called from
 invalid context at print message
Message-ID: <Z2RP7TVCnulHeY-9@arm.com>
References: <20241217142032.55793-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217142032.55793-1-acarmina@redhat.com>

On Tue, Dec 17, 2024 at 02:20:33PM +0000, Alessandro Carminati wrote:
> Address a bug in the kernel that triggers a "sleeping function called from
> invalid context" warning when /sys/kernel/debug/kmemleak is printed under
> specific conditions:
> - CONFIG_PREEMPT_RT=y
> - Set SELinux as the LSM for the system
> - Set kptr_restrict to 1
> - kmemleak buffer contains at least one item
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 136, name: cat
> preempt_count: 1, expected: 0
> RCU nest depth: 2, expected: 2
> 6 locks held by cat/136:
>  #0: ffff32e64bcbf950 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb8/0xe30
>  #1: ffffafe6aaa9dea0 (scan_mutex){+.+.}-{3:3}, at: kmemleak_seq_start+0x34/0x128
>  #3: ffff32e6546b1cd0 (&object->lock){....}-{2:2}, at: kmemleak_seq_show+0x3c/0x1e0
>  #4: ffffafe6aa8d8560 (rcu_read_lock){....}-{1:2}, at: has_ns_capability_noaudit+0x8/0x1b0
>  #5: ffffafe6aabbc0f8 (notif_lock){+.+.}-{2:2}, at: avc_compute_av+0xc4/0x3d0
> irq event stamp: 136660
> hardirqs last  enabled at (136659): [<ffffafe6a80fd7a0>] _raw_spin_unlock_irqrestore+0xa8/0xd8
> hardirqs last disabled at (136660): [<ffffafe6a80fd85c>] _raw_spin_lock_irqsave+0x8c/0xb0
> softirqs last  enabled at (0): [<ffffafe6a5d50b28>] copy_process+0x11d8/0x3df8
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> Preemption disabled at:
> [<ffffafe6a6598a4c>] kmemleak_seq_show+0x3c/0x1e0
> CPU: 1 UID: 0 PID: 136 Comm: cat Tainted: G            E      6.11.0-rt7+ #34
> Tainted: [E]=UNSIGNED_MODULE
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0xa0/0x128
>  show_stack+0x1c/0x30
>  dump_stack_lvl+0xe8/0x198
>  dump_stack+0x18/0x20
>  rt_spin_lock+0x8c/0x1a8
>  avc_perm_nonode+0xa0/0x150
>  cred_has_capability.isra.0+0x118/0x218
>  selinux_capable+0x50/0x80
>  security_capable+0x7c/0xd0
>  has_ns_capability_noaudit+0x94/0x1b0
>  has_capability_noaudit+0x20/0x30
>  restricted_pointer+0x21c/0x4b0
>  pointer+0x298/0x760
>  vsnprintf+0x330/0xf70
>  seq_printf+0x178/0x218
>  print_unreferenced+0x1a4/0x2d0
>  kmemleak_seq_show+0xd0/0x1e0
>  seq_read_iter+0x354/0xe30
>  seq_read+0x250/0x378
>  full_proxy_read+0xd8/0x148
>  vfs_read+0x190/0x918
>  ksys_read+0xf0/0x1e0
>  __arm64_sys_read+0x70/0xa8
>  invoke_syscall.constprop.0+0xd4/0x1d8
>  el0_svc+0x50/0x158
>  el0t_64_sync+0x17c/0x180
> 
> %pS and %pK, in the same back trace line, are redundant, and %pS can void
> %pK service in certain contexts.
> 
> %pS alone already provides the necessary information, and if it cannot
> resolve the symbol, it falls back to printing the raw address voiding
> the original intent behind the %pK.
> 
> Additionally, %pK requires a privilege check CAP_SYSLOG enforced through
> the LSM, which can trigger a "sleeping function called from invalid
> context" warning under RT_PREEMPT kernels when the check occurs in an
> atomic context. This issue may also affect other LSMs.
> 
> This change avoids the unnecessary privilege check and resolves the
> sleeping function warning without any loss of information.
> 
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
