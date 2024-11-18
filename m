Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC81E871
	for <linux-rt-devel@lists.linux.dev>; Mon, 18 Nov 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939763; cv=none; b=tW3qXqx8Y3PlmI3t2k3jPl0SOVSwwobf70h/c1drJJn9VDNQp/tFgBE883yfBq1yP5kcwAfE47rx6VxvNehE1VPDMAc0wwsguGdSlhHvksWLpIhBeyO5Gdnaqm+bM7lnmrpV02CuLiwvnpIVIvN1NLzaEqPqOT75ruO4UqsGpXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939763; c=relaxed/simple;
	bh=3xsdy2uS02/Uz8yRS3Q2Klf1v4N3WcywG0ZjChxUP9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDOVhXcrlanSSQ90z98ZyWEunIQWsNXrYSCHYFkZvbOiWzvhulV9RxfaZYlx0CKyyS5VQFVTH0JwEqWGKS4jDYJWnPLLGVsgLp0RGaHk+WvO0DD0L6hzCiw8faBZfskDzcsOhzvkUUB9b3+wKjdMs+Sbfw8H1gOaPcWYKPTJu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LgM9k66L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JC+++jkx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LgM9k66L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JC+++jkx"
Date: Mon, 18 Nov 2024 15:22:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731939759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gu4CWMX3V/82ON7Ch4380CqxNl3Nb1JT34Ac7zMXwLY=;
	b=LgM9k66L2EQeONBvbX5GnPfY2cni15inUqScSqd0wdhYU0F46h6KnToW+RYoOWC+sFsyLm
	6Lt6wAS+xm0PiUoTBg7T72o/rcw5nfZ/yn9+gSy3mWNmiI0POgEpzy+7TYL10Fvaaw6bSw
	XNKFlaLaXxcPS8z8pBft3H3uv4WIJtiUp0LJMdkP2iLX3QLrzffxSEhRR9HD2W7Iw3K9Iv
	lT7/WcN65PRk+b9QAywPmW7KN5MIthnho2+y0i10THcT2XPcZDt/LFYi6Ti3SQ9ZV3qPpQ
	ffmo2jtVYoXbt7XdwsEI+bBEfIwFR3vpoEurjcmtNvJvQeb+JKuH/eXEfJecPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731939759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gu4CWMX3V/82ON7Ch4380CqxNl3Nb1JT34Ac7zMXwLY=;
	b=JC+++jkxrboqECgjjfCMXa0U2CZDVBf2f+w5SBzR4CirvENhGaUSpBT0p8ZYZgnGdJhX5R
	kFT5ZygXSpKHwpBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>
Subject: Re: [RFC] mm/kmemleak: Fix sleeping function called from invalid
 context at print message
Message-ID: <20241118151351-5a465d40-b8d0-45e4-bf9b-6d3add8ce98b@linutronix.de>
References: <20241115145410.114376-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115145410.114376-1-acarmina@redhat.com>

On Fri, Nov 15, 2024 at 02:54:10PM +0000, Alessandro Carminati wrote:
> Address a bug in the kernel that triggers a "sleeping function called from
> invalid context" warning when /sys/kernel/debug/kmemleak is printed under
> specific conditions:
> - CONFIG_PREEMPT_RT=y
> - Set SELinux as the LSM for the system
> - Set kptr_restrict to 1
> - kmemleak buffer contains at least one item
> Ensure the kmemleak buffer contains at least one item
> Commit 8c96f1bc6fc49c724c4cdd22d3e99260263b7384 ("mm/kmemleak: turn
> kmemleak_lock and object->lock to raw_spinlock_t") introduced a change
> where kmemleak_seq_show is executed in atomic context within the RT kernel.
> However, the SELinux capability check in this function flow still relies on
> regular spinlocks, leading to potential race conditions that trigger an
> error when printing the kmemleak backtrace.
> Move the backtrace printing out of the critical section. Use a stack
> variable to store the backtrace pointers, avoiding spinlocks in the atomic
> context.
>
> Implement delta encoding to minimize the stack memory footprint,
> addressing the potentially large memory demands for storing these pointers
> on 64-bit systems.

The stacktrace is already stored in the stackdepot.
Shouldn't it be possible to take a reference to the stackdepot entry
inside the critical section and then use that reference outside of the
critical section for printing?

> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> ---
> ```
> [  159.247069] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [  159.247193] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 136, name: cat
> [  159.247241] preempt_count: 1, expected: 0
> [  159.247277] RCU nest depth: 2, expected: 2
> [  159.247388] 6 locks held by cat/136:
> [  159.247438]  #0: ffff32e64bcbf950 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb8/0xe30
> [  159.248835]  #1: ffffafe6aaa9dea0 (scan_mutex){+.+.}-{3:3}, at: kmemleak_seq_start+0x34/0x128
> [  159.249053]  #3: ffff32e6546b1cd0 (&object->lock){....}-{2:2}, at: kmemleak_seq_show+0x3c/0x1e0
> [  159.249127]  #4: ffffafe6aa8d8560 (rcu_read_lock){....}-{1:2}, at: has_ns_capability_noaudit+0x8/0x1b0
> [  159.249205]  #5: ffffafe6aabbc0f8 (notif_lock){+.+.}-{2:2}, at: avc_compute_av+0xc4/0x3d0
> [  159.249364] irq event stamp: 136660
> [  159.249407] hardirqs last  enabled at (136659): [<ffffafe6a80fd7a0>] _raw_spin_unlock_irqrestore+0xa8/0xd8
> [  159.249465] hardirqs last disabled at (136660): [<ffffafe6a80fd85c>] _raw_spin_lock_irqsave+0x8c/0xb0
> [  159.249518] softirqs last  enabled at (0): [<ffffafe6a5d50b28>] copy_process+0x11d8/0x3df8
> [  159.249571] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  159.249970] Preemption disabled at:
> [  159.249988] [<ffffafe6a6598a4c>] kmemleak_seq_show+0x3c/0x1e0
> [  159.250609] CPU: 1 UID: 0 PID: 136 Comm: cat Tainted: G            E      6.11.0-rt7+ #34
> [  159.250797] Tainted: [E]=UNSIGNED_MODULE
> [  159.250822] Hardware name: linux,dummy-virt (DT)
> [  159.251050] Call trace:
> [  159.251079]  dump_backtrace+0xa0/0x128
> [  159.251132]  show_stack+0x1c/0x30
> [  159.251156]  dump_stack_lvl+0xe8/0x198
> [  159.251180]  dump_stack+0x18/0x20
> [  159.251227]  rt_spin_lock+0x8c/0x1a8
> [  159.251273]  avc_perm_nonode+0xa0/0x150
> [  159.251316]  cred_has_capability.isra.0+0x118/0x218
> [  159.251340]  selinux_capable+0x50/0x80
> [  159.251363]  security_capable+0x7c/0xd0
> [  159.251388]  has_ns_capability_noaudit+0x94/0x1b0
> [  159.251412]  has_capability_noaudit+0x20/0x30
> [  159.251437]  restricted_pointer+0x21c/0x4b0
> [  159.251461]  pointer+0x298/0x760
> [  159.251482]  vsnprintf+0x330/0xf70
> [  159.251504]  seq_printf+0x178/0x218
> [  159.251526]  print_unreferenced+0x1a4/0x2d0
> [  159.251551]  kmemleak_seq_show+0xd0/0x1e0
> [  159.251576]  seq_read_iter+0x354/0xe30
> [  159.251599]  seq_read+0x250/0x378
> [  159.251622]  full_proxy_read+0xd8/0x148
> [  159.251649]  vfs_read+0x190/0x918
> [  159.251672]  ksys_read+0xf0/0x1e0
> [  159.251693]  __arm64_sys_read+0x70/0xa8
> [  159.251716]  invoke_syscall.constprop.0+0xd4/0x1d8
> [  159.251767]  el0_svc+0x50/0x158
> [  159.251813]  el0t_64_sync+0x17c/0x180
> ```
> I have considered three potential approaches to address this matter:
> 
> 1. Remove Raw Pointer Printing
> The simplest solution is to eliminate raw pointer printing from the report.
> This approach involves minimal changes to the kernel code and is 
> straightforward to implement.
> 
> While I am confident that omitting the raw address would result in
> negligible information loss in most scenarios, some may perceive it as a
> feature regression. Below is an example of the modification:
> ```
> - warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
> + warn_or_seq_printf(seq, "    %pS\n", ptr);
> ```
> This change may be acceptable since the %pS format outputs a hex string
> if no kallsyms are available. However, it modifies the original behavior,
> and in the kallsyms scenario, the raw pointer would no longer be present.
> 
> 2. Modify SELinux to Avoid Sleeping Spinlocks
> Another option is to alter the SELinux capability check to use
> non-sleeping spinlocks.
> However, this approach is not advisable. The SELinux capability check is
> extensively used across the kernel and is far more critical than the
> kmemleak reporting feature.
> Adapting it to address this rare issue could unnecessarily introduce
> latency across the entire kernel, particularly as kmemleak is rarely used
> in production environments.
> 
> 3. Move Stack Trace Printing Outside the Atomic Section
> The third and preferred approach is to move the stack trace printing
> outside the atomic section. This would preserve the current functionality
> without modifying SELinux.
> 
> The primary challenge here lies in making the backtrace pointers available
> after exiting the critical section, as they are captured within it.
> To address this, the backtrace pointers can be copied to a safe location,
> enabling access once the raw_spinlock is released.
> 
> Options for Creating a Safe Location for Backtrace Pointers
> Several strategies have been considered for storing the backtrace pointers
> safely:
> * Dynamic Allocation
>     * Allocating memory with kmalloc cannot be done within a raw_spinlock
>       area. Using GFP_ATOMIC is also infeasible.
>     * Since the code that prints the message is inside a loop, executed
>       potentially multiple times, it is only within the raw_spinlock 
>       section that we can determine whether allocation is needed.
>     * Allocating and deallocating memory on every loop iteration would be
>       prohibitively expensive.
> * Global Data Section
>     * In this strategy, the message would be printed after exiting the
>       raw_spinlock protected section.
>     * However, this approach risks data corruption if another occurrence
>       of the issue arises before the first operation completes.
> * Per-CPU Data
>     * The same concerns as with global data apply here. While data 
>       corruption is less likely, it is not impossible.
> * Stack
>     * Using the stack is the best option since each thread has its own 
>       stack, ensuring data isolation. However, the size of the data poses
>       a challenge.
>     * Exporting a full stack trace pointer list requires considerable space.
>       A 32-level stack trace in a 64-bit system would require 256 bytes, 
>       which is contrary to best practices for stack size management.
> 
> To mitigate this, I propose using delta encoding to store the addresses.
> This method reduces the size of each address from 8 bytes to 4 bytes on
> 64-bit systems. While this introduces some complexity, it significantly
> reduces memory usage and allows us to preserve the kmemleak reports in their
> current form.
>  mm/kmemleak.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 0400f5e8ac60..fc5869e09280 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -274,6 +274,44 @@ static void kmemleak_disable(void);
>  		pr_warn(fmt, ##__VA_ARGS__);		\
>  } while (0)
>  
> +#define PTR_STORAGE_OP_OK	-1
> +#define PTR_STORAGE_OP_FAIL	0
> +#define PTR_STORAGE_CAPACITY	32
> +
> +struct ptr_storage {
> +	unsigned long	base;
> +	u32		data[PTR_STORAGE_CAPACITY];
> +	int		nr_entries;
> +};
> +
> +static int ptr_storage_insert(unsigned long p, struct ptr_storage *s)
> +{
> +	unsigned long diff_data;
> +
> +	if (s->nr_entries != 0) {
> +		diff_data = s->base - p;
> +		if (s->nr_entries < PTR_STORAGE_CAPACITY) {
> +			s->data[((s->nr_entries - 1))] = diff_data & 0xffffffff;
> +			s->nr_entries++;
> +			return PTR_STORAGE_OP_OK;
> +		}
> +		return PTR_STORAGE_OP_FAIL;
> +	}
> +	s->base = p;
> +	s->nr_entries++;
> +	return PTR_STORAGE_OP_OK;
> +}
> +
> +static void *ptr_storage_get(struct ptr_storage *s, int item_no)
> +{
> +	if (item_no < s->nr_entries && item_no > 0)
> +		return (void *)s->base - (s32)s->data[(item_no - 1)];
> +
> +	if (item_no == 0)
> +		return (void *)s->base;
> +	return NULL;
> +}
> +
>  static void warn_or_seq_hex_dump(struct seq_file *seq, int prefix_type,
>  				 int rowsize, int groupsize, const void *buf,
>  				 size_t len, bool ascii)
> @@ -357,11 +395,13 @@ static bool unreferenced_object(struct kmemleak_object *object)
>   * print_unreferenced function must be called with the object->lock held.
>   */
>  static void print_unreferenced(struct seq_file *seq,
> -			       struct kmemleak_object *object)
> +			       struct kmemleak_object *object,
> +			       struct ptr_storage *s)
>  {
>  	int i;
>  	unsigned long *entries;
>  	unsigned int nr_entries;
> +	unsigned long tmp;
>  
>  	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
>  	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
> @@ -372,8 +412,8 @@ static void print_unreferenced(struct seq_file *seq,
>  	warn_or_seq_printf(seq, "  backtrace (crc %x):\n", object->checksum);
>  
>  	for (i = 0; i < nr_entries; i++) {
> -		void *ptr = (void *)entries[i];
> -		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
> +		tmp = (unsigned long)entries[i];
> +		ptr_storage_insert(tmp, s);
>  	}
>  }
>  
> @@ -1625,6 +1665,10 @@ static void kmemleak_scan(void)
>  	struct zone *zone;
>  	int __maybe_unused i;
>  	int new_leaks = 0;
> +	struct ptr_storage s = {0};
> +	bool do_print = false;
> +	void *tmp;
> +	int inx;
>  
>  	jiffies_last_scan = jiffies;
>  
> @@ -1783,12 +1827,20 @@ static void kmemleak_scan(void)
>  		    !(object->flags & OBJECT_REPORTED)) {
>  			object->flags |= OBJECT_REPORTED;
>  
> -			if (kmemleak_verbose)
> -				print_unreferenced(NULL, object);
> +			if (kmemleak_verbose) {
> +				print_unreferenced(NULL, object, &s);
> +				do_print = true;
> +			}
>  
>  			new_leaks++;
>  		}
>  		raw_spin_unlock_irq(&object->lock);
> +		if (kmemleak_verbose && do_print) {
> +			for (inx = 0; inx < s.nr_entries; inx++) {
> +				tmp = ptr_storage_get(&s, i);
> +				warn_or_seq_printf(NULL, "    [<%pK>] %pS\n", tmp, tmp);
> +			}
> +		}
>  	}
>  	rcu_read_unlock();
>  
> @@ -1939,11 +1991,23 @@ static int kmemleak_seq_show(struct seq_file *seq, void *v)
>  {
>  	struct kmemleak_object *object = v;
>  	unsigned long flags;
> +	struct ptr_storage s = {0};
> +	void *tmp;
> +	int i;
> +	bool do_print = false;
>  
>  	raw_spin_lock_irqsave(&object->lock, flags);
> -	if ((object->flags & OBJECT_REPORTED) && unreferenced_object(object))
> -		print_unreferenced(seq, object);
> +	if ((object->flags & OBJECT_REPORTED) && unreferenced_object(object)) {
> +		print_unreferenced(seq, object, &s);
> +		do_print = true;
> +	}
>  	raw_spin_unlock_irqrestore(&object->lock, flags);
> +	if (do_print) {
> +		for (i = 0; i < s.nr_entries; i++) {
> +			tmp = ptr_storage_get(&s, i);
> +			warn_or_seq_printf(seq, "    [<%pK>] %pS\n", tmp, tmp);
> +		}
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
