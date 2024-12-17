Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794E1F7570;
	Tue, 17 Dec 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458107; cv=none; b=cHyxb4aZyWGbFyoZWk3i34+s8+XpDFZN7AZw7IsBFWZgO9eUGk3sXWgnUs+CZnibv1ICETBIV7Fa4Ad7NhtuXAnVaTgLKII/hfmEl8ZlWMFi62igGm08zyHJc5xX+AR+QwvO9tUEy1ret8ieAbhMSPuWvuR22DOWtuveemz611Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458107; c=relaxed/simple;
	bh=cD1Gqc3sDcM5ikY3NfphoRIdXqHd+RiYunRrE3R240Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Te6PUOO8Bo+hxZe0DpTqy8AhfKJOmsrv/CvOSHLWdCr5lIVePpWatSusmes7rvh3crPX5YAsLaUMXIosZFwOjtjj7bUx7GHzyNp0T/AIxtJXxok+yWRmeadPCtwaSkz2e2r/LY2zXcTmEHNjn0XSB+Ta5uE3ONMTv6AV+mJwCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eryzkwDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eryzkwDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F584C4CED3;
	Tue, 17 Dec 2024 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734458106;
	bh=cD1Gqc3sDcM5ikY3NfphoRIdXqHd+RiYunRrE3R240Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eryzkwDZ7Dzu9LsXXzHFBMDpNZ+nIOE2qdhxHFlpqL1aHtDqjuQrNoFDI2kV9PVWU
	 a7RyYvwc83qSpqMheOU6ADqnueTksHpzZ+WYCwLj67G4dInWo3a/SgCLdrwTjnKtbE
	 0dG2Dwf2tFidtfAShQCLsPlWX+PKl2uqe+O3jV0s=
Date: Tue, 17 Dec 2024 09:55:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Alessandro
 Carminati <alessandro.carminati@gmail.com>, Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Gabriele Paoloni <gpaoloni@redhat.com>, Eric Chanudet
 <echanude@redhat.com>, clement.leger@bootlin.com
Subject: Re: [PATCH v2] mm/kmemleak: Fix sleeping function called from
 invalid context at print message
Message-Id: <20241217095504.ea2a3a24564af4df48cf0b19@linux-foundation.org>
In-Reply-To: <20241217142032.55793-1-acarmina@redhat.com>
References: <20241217142032.55793-1-acarmina@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 14:20:33 +0000 Alessandro Carminati <acarmina@redhat.com> wrote:

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

-rt is a bit annoying this way.  Things which we expect to work OK are
no longer doing so.

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

I'm adding

Fixes: 3a6f33d86baa ("mm/kmemleak: use %pK to display kernel pointers in backtrace")
Cc: <stable@vger.kernel.org>

> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -373,7 +373,7 @@ static void print_unreferenced(struct seq_file *seq,
>  
>  	for (i = 0; i < nr_entries; i++) {
>  		void *ptr = (void *)entries[i];
> -		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
> +		warn_or_seq_printf(seq, "    %pS\n", ptr);
>  	}
>  }

Before 3a6f33d86baa we were still printing the address, with plain old
%p.  Should we restore that, or is %p always useless?

