Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486931AA787;
	Wed, 20 Nov 2024 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114398; cv=none; b=V5wm1sw1bRTpGrA0O3qwvVCAbjNezVcj/Sn3RrXLaJarpz747KuyKRKBOe9tHv/8h003w1WAa5Aj3HjMA6+agsSK1sMXyDMW6QYFEm71z/2YSrWuixr2O/J54mz00m7/bF56vnmoHpaN0F2BkrS9LTpBWm2JIiwTNa6xtk5bPFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114398; c=relaxed/simple;
	bh=Y4KK/Hk7jbm9IpTdm8JLOuzzfW9pWOveIZCfUaQAXVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYpxAcp3982cwUYjlQt7672+wDpxIRXGvl7qFcLiSZcCFlW9nAWVjR/5f4CTgP6DkvN2C/QBeyINJKLwkErUp+M+tWBr9zIRhB5i2q8lVxyohBvsMfpGW5o0CAWFbNcnkKfQCMk+wmOfk9dL+pKnu532/xsijCzZwnhWNbm/zGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F1AC4CECD;
	Wed, 20 Nov 2024 14:53:15 +0000 (UTC)
Date: Wed, 20 Nov 2024 14:53:13 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
Message-ID: <Zz332cG45rNSeE_B@arm.com>
References: <20241120102325.3538-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120102325.3538-1-acarmina@redhat.com>

Hi Alessandro,

On Wed, Nov 20, 2024 at 10:23:25AM +0000, Alessandro Carminati wrote:
> This patch addresses a bug in the RT variant of the kernel where a
> "sleeping function called from invalid context" warning may occur in
> kmemleak_seq_show under specific conditions:
> - CONFIG_PREEMPT_RT=y
> - SELinux is the LSM for the system
> - `kptr_restrict` is set to 1.
> - The kmemleak buffer contains at least one item.
> 
> Commit 8c96f1bc6fc49c724c4cdd22d3e99260263b7384 ("mm/kmemleak: turn
> kmemleak_lock and object->lock to raw_spinlock_t") introduced a change
> where kmemleak_seq_show is executed in atomic context within the RT kernel.
> However, the SELinux capability check within this function flow still
> relies on regular spinlocks, leading to potential race conditions that
> trigger the error when printing the kmemleak backtrace.
> 
> To resolve this, the backtrace printing has been moved out of the critical
> section.
> 
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> ---
> Please read previous conversation in the RFC
> https://lore.kernel.org/all/20241115145410.114376-1-acarmina@redhat.com/
> 
> Splash triggering this patch:
> 
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
[...]

It would be worth including the kernel dump in the commit log for future
references but remove the timestamps.

It also needs some explanation that the stack depot entries are never
freed by kmemleak, so no need to refcount.

> @@ -356,14 +356,9 @@ static bool unreferenced_object(struct kmemleak_object *object)
>   * Printing of the unreferenced objects information to the seq file. The
>   * print_unreferenced function must be called with the object->lock held.
>   */
> -static void print_unreferenced(struct seq_file *seq,
> +static depot_stack_handle_t print_unreferenced(struct seq_file *seq,
>  			       struct kmemleak_object *object)
>  {
> -	int i;
> -	unsigned long *entries;
> -	unsigned int nr_entries;
> -
> -	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
>  	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
>  			  object->pointer, object->size);
>  	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
> @@ -371,6 +366,23 @@ static void print_unreferenced(struct seq_file *seq,
>  	hex_dump_object(seq, object);
>  	warn_or_seq_printf(seq, "  backtrace (crc %x):\n", object->checksum);
>  
> +	return object->trace_handle;
> +}

What I don't fully understand - is this a problem with any seq_printf()
or just the backtrace pointers from the stack depot that trigger this
issue? I guess it's something to do with restricted pointers but I'm not
familiar with the PREEMPT_RT concepts. It would be good to explain,
ideally both in the commit log and a comment in the code, why we only
need to do this for the stack dump.

> +
> +/*
> + * Prints stack traces of unreferenced objects outside of the lock context.
> + * This avoids potential issues with printing pointers that might require
> + * additional locking.
> + */
> +static void print_stack_trace(struct seq_file *seq,
> +			      depot_stack_handle_t h)
> +{
> +	int i;
> +	unsigned long *entries;
> +	unsigned int nr_entries;
> +
> +	nr_entries = stack_depot_fetch(h, &entries);
> +
>  	for (i = 0; i < nr_entries; i++) {
>  		void *ptr = (void *)entries[i];
>  		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
> @@ -1621,7 +1633,9 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
>   */
>  static void kmemleak_scan(void)
>  {
> +	depot_stack_handle_t stackdepot_handle;
>  	struct kmemleak_object *object;
> +	bool do_print = false;
>  	struct zone *zone;
>  	int __maybe_unused i;
>  	int new_leaks = 0;
> @@ -1783,12 +1797,17 @@ static void kmemleak_scan(void)
>  		    !(object->flags & OBJECT_REPORTED)) {
>  			object->flags |= OBJECT_REPORTED;
>  
> -			if (kmemleak_verbose)
> -				print_unreferenced(NULL, object);
> +			if (kmemleak_verbose) {
> +				stackdepot_handle = print_unreferenced(NULL, object);
> +				do_print = true;
> +			}
>  
>  			new_leaks++;
>  		}
>  		raw_spin_unlock_irq(&object->lock);
> +		if (kmemleak_verbose && do_print)
> +			print_stack_trace(NULL, stackdepot_handle);
> +
>  	}
>  	rcu_read_unlock();

I wonder whether it would be simpler to just have a copy of the object
on the stack. The only downside is hex_dump_object() which can only be
done under the lock, otherwise the object may disappear. But we can copy
part of the object to a buffer on the stack as well. Something like:

static void kmemleak_scan(void)
{
	...
	struct kmemleak_object unref_object;
	u8 unref_buf[HEX_MAX_LINES * HEX_ROW_SIZE];
	...
}

static void save_unref_object(struct kmemleak_object *unref_object,
			      struct kmemleak_object *object,
			      u8 *unref_buf)
{
	unref_object = *object;
	unref_object->pointer = (unsigned long)unref_buf;
	...
	// some memcpy from object->pointer to unref_buf similar to what
	// we do in hex_dump_object().
}

Update hex_dump_object() accordingly (i.e. skip per-cpu checks since we
copied the above).

After this, just call print_unreferenced(&unref_object) outside the
raw_spin_lock.

Thanks.

-- 
Catalin
