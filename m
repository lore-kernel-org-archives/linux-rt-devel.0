Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798998;
	b=k84V0aqQt3E3SQ9v6pdNC+0KbTfkaKwHwINz0fq2HMfKKDHrR0NMGaVzkZML1Y6R7fSA
	 w6Oe2jcC+7u1GRrWxkWo5Da1sDZGWkdOW7mJ9e7t4pozZ7+PNSBKX6yFVShVcEfumUpnx
	 qpVYQt0XpaBQ/y+x5AFz1YQVyMSOipkFn4NIBXAwLEkNwPWz6K5+dPTYNaVM07cJ06C19
	 enOgIrwiPGa1FgEgEoV+536n+gtbO/fMV1Hl7EMDv32hp1IJuN26BHl5yXR0v0y5DuzLP
	 3YMoRbXHUDIHGqoLyqJKmRDpRTp0IzRUiKfutiEeF7J61OV8NiaCGt6vFb+tJqRqjOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798998;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=f9vMUAln9RF4ExbyRQjC3UtblgMb7Qet2HsLNIFFgQk=;
	b=vRaPnRw47/wb/ItVNdUfr8CKuVp+i5nmnUrD2j7Ey6SjNLdqsTc2GbAoKLUnXvP18PAI
	 lNDb+KLmQdO18KbXptE/Qery91fku1H551lQ5um7etSoG4VTbHzp1Fyy5DCMGVxLBNcDE
	 Pn08zDKeAy+6G5NL3NxVY3pmtNmTP2ZjwgL3gbpabV0lIWpDSs8SHi1Hoq90RPLxphY2u
	 ZxQlqSfLszKcDAQYEYqZCrZqt63F6dNuEwNUvI8Co+Uu2l51lO2bqmK9A7vG+tvmvbPnl
	 pjUhYVPuVUQpIzqXeSZHKxoJrYoS7KjYe/9zEJ0ZsyofBZkXaTNBbAZMSPmj55WVZ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=LyRAVFev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D1606A323;
	Mon, 16 Nov 2026 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=LyRAVFev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC701F000C4;
	Mon, 16 Nov 2026 03:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794798997;
	bh=f9vMUAln9RF4ExbyRQjC3UtblgMb7Qet2HsLNIFFgQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LyRAVFevgYPkx5MazjZeILe8nf+HIaMipxE5RhUD9KN0zKvQ9SX4LhtRQ6w0wax5b
	 pl6MKCva03CSsRGh5DEW5ZknGlva63h0SQAVEpY2Jx+/r7drr1fqCizZdoMW4lzrmO
	 qrvDPmonNiAAfQOtlW/qtNHjnRTJAVZMiZvyNHdM=
Date: Sun, 15 Nov 2026 19:16:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: dennis@kernel.org, tj@kernel.org, cl@gentwo.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
 tim.c.chen@linux.intel.com, tianyou.li@intel.com, wangyang.guo@intel.com
Subject: Re: [PATCH] lib/percpu_counter: allow concurrent sums with an
 rwlock
Message-Id: <20261115191636.f18859e4dd5f58b9a33e7814@linux-foundation.org>
In-Reply-To: <20261116015655.2744577-1-jiebin.sun@intel.com>
References: <20261116015655.2744577-1-jiebin.sun@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 09:56:55 +0800 Jiebin Sun <jiebin.sun@intel.com> wrote:

> __percpu_counter_sum() holds a raw spinlock while reading the global
> count and per-CPU deltas, serializing concurrent sums of the same
> counter. Since a sum changes neither the global count nor the per-CPU
> deltas, use rwlock_t on !PREEMPT_RT to allow concurrent sums with a
> read lock. Global updates take the write lock. The per-CPU fast path
> remains lockless, so sums keep their existing snapshot semantics.
> 
> stress-ng dentry reaches this path through ext4_statfs():
> 
>   statfs -> ext4_statfs -> __percpu_counter_sum
>          -> native_queued_spin_lock_slowpath
> 
> Keep the raw spinlock on PREEMPT_RT, where rwlock_t can sleep.
> Global counter updates can run in atomic context and must not sleep.
> 
> stress-ng dentry test average throughput change:
> 
>   +------------------------+------------+--------------------+
>   | Case                   | Unit       | Average change (%) |
>   +------------------------+------------+--------------------+
>   | Dentry, 64 workers     | bogo ops/s |             +47.34 |
>   +------------------------+------------+--------------------+
> 
> Dentry ran on ext4 with 64 workers pinned to physical CPUs:
> 
>   stress-ng --dentry 64 --dentries 4096 --timeout 20s

lol, this is a fun patch - it reminds me of the old days.  All those
mission-critical workloads which sit in a loop running statfs will love
it!

I had $sidekick do a scan and it told me "the only plausible routine
win is dirty throttling: with low dirty limits, concurrent writers sum
the same counters.  ext4 and XFS sum near ENOSPC, where updates also
contend.  BFQ's sums are debug-only and serialized.  Most other callers
report statistics".  You might want to add something like this to
changelog.

Also mention that percpu_counter_sum_positive callers will benefit.

> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -20,7 +20,11 @@
>  #ifdef CONFIG_SMP
>  
>  struct percpu_counter {
> +#ifdef CONFIG_PREEMPT_RT

Might be worth a wee comment telling readers why RT is special?

>  	raw_spinlock_t lock;
> +#else
> +	rwlock_t lock;		/* shared for sums, exclusive for updates */
> +#endif
>  	s64 count;
>  #ifdef CONFIG_HOTPLUG_CPU
>  	struct list_head list;	/* All percpu_counters are on a list */
>
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -15,6 +15,46 @@ static LIST_HEAD(percpu_counters);
>  static DEFINE_SPINLOCK(percpu_counters_lock);
>  #endif
>  
> +/*
> + * Non-RT sums share the lock; global updates take it exclusively.
> + * Keep raw spinlocks on RT: rwlocks may sleep and their irqsave variants
> + * do not disable interrupts. Updates run in atomic contexts and need
> + * IRQ exclusion for CPU-local read-modify-write sequences.
> + */
> +#ifdef CONFIG_PREEMPT_RT
> +#define fbc_lock(fbc)			raw_spin_lock(&(fbc)->lock)
> +#define fbc_unlock(fbc)			raw_spin_unlock(&(fbc)->lock)
> +#define fbc_lock_irqsave(fbc, f)		raw_spin_lock_irqsave(&(fbc)->lock, f)
> +#define fbc_unlock_irqrestore(fbc, f)	raw_spin_unlock_irqrestore(&(fbc)->lock, f)
> +#define fbc_read_lock_irqsave		fbc_lock_irqsave
> +#define fbc_read_unlock_irqrestore	fbc_unlock_irqrestore
> +#else
> +#define fbc_lock(fbc)			write_lock(&(fbc)->lock)
> +#define fbc_unlock(fbc)			write_unlock(&(fbc)->lock)
> +#define fbc_lock_irqsave(fbc, f)		write_lock_irqsave(&(fbc)->lock, f)
> +#define fbc_unlock_irqrestore(fbc, f)	write_unlock_irqrestore(&(fbc)->lock, f)
> +#define fbc_read_lock_irqsave(fbc, f)	read_lock_irqsave(&(fbc)->lock, f)
> +#define fbc_read_unlock_irqrestore(fbc, f) read_unlock_irqrestore(&(fbc)->lock, f)
> +#endif

Please, no!

https://www.google.com/search?q=why+does+Andrew+Morton+prefer+static+inlines+over+macros

lots of good stuff there ;)


