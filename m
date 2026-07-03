Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A553D6475
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083475; cv=none; b=uCF7hTjnErBcODfd/3prYO+xp2kRzYZ7ijc3g6vKJgRxeOC4s22HnDllUjmvso2VOzU2yx9S+z/OcmyjerDGa8Tujx4lsKoCsFWw0e5UucP4feXBnqP4vFc6pTM0GNFxuSk9ZIV19prvV/Qnb1t5+bFHbbaindbkD/3e2AP6eMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083475; c=relaxed/simple;
	bh=cUYLgm33UwA/w0qbxU2GQ8KauuvgqtMyBfNTDnDKIyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O2LZy+JAR8FqMw5dyJhyZyHTj/bF92XNnqhvOJklVLVrmY61LoOgn2+pI4mQ2yK7xhMIkoN8jk3t4BhoDyZkoAX1NdVubhgZHiYohMOVIWmXPEn/gzG5q4W7qwzd6AVGzJJDp/NPR3b8qAJb5ywQcfDlfuRhNQwz62sv2sqUSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFDJJDMo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v1RWWjRx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFDJJDMo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1RWWjRx"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783083472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExOHSK3CI7w8Qx7zhNqd6+97gfyapZZ4gckpH8gnop8=;
	b=gFDJJDMoLngo4YmHo0ybSQlBpP1891OHy9boiilNkhlrNk7irpKYyPH1gA8782eZZg1cJC
	zIwmgaL6mlnakEtCcinhZ40DqDZ2uKPR1IVDQOQITD1EINWKhCBWIQHl1Q7Wde0H0wCQ1N
	v4uDbikok2cI9yx4ceqs7LzFGkIwjGlxrWTjLQx7wtIPliR1DE6mVEppE5KrAhm6o+izNJ
	jTk6GpaBgdR7wrDL8bPSa2h9/wEixZSwOjVaChigplU1yZxlKhWHnSdojbjkdkuw2vtoO9
	U+C0saXH0ExMiUi2v9XxOvwC4DQvv37XScA8FO7oKHDxH5nwrVFcdkZ5Zsz+Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783083472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExOHSK3CI7w8Qx7zhNqd6+97gfyapZZ4gckpH8gnop8=;
	b=v1RWWjRx6NJRFvACEhlyvXJxTa3oTzptyUySp2/ZfBTTsP7MKcfIMBECLVHncRNsz3jHxJ
	MSdOhQ9ywN74rNCw==
To: Andrew Murray <amurray@thegoodpenguin.co.uk>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Russell King
 <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
 Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
In-Reply-To: <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
Date: Fri, 03 Jul 2026 15:03:51 +0206
Message-ID: <87zf08w7qo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Sorry I am so late to this party.

On 2026-06-30, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> diff --git a/include/linux/console.h b/include/linux/console.h
> index d624200cfc1708bf73925892a466efe0c95c5586..3478b556c0eb9579530409dc6fbb9b5a8bff581c 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -290,6 +290,8 @@ struct nbcon_context {
>   * @outbuf:		Pointer to the text buffer for output
>   * @len:		Length to write
>   * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
> + * @emitted:		The write context attempted to emit the message. Might
> + *			be incomplete.
>   * @cpu:		CPU on which the message was generated
>   * @pid:		PID of the task that generated the message
>   * @comm:		Name of the task that generated the message
> @@ -298,7 +300,8 @@ struct nbcon_write_context {
>  	struct nbcon_context	__private ctxt;
>  	char			*outbuf;
>  	unsigned int		len;
> -	bool			unsafe_takeover;
> +	unsigned char		unsafe_takeover : 1;
> +	unsigned char		emitted		: 1;

This is the wrong structure to add this flag. This structure is for
the nbcon drivers.

struct nbcon_context would be the correct structure.

> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 4b03b019cd5ee25d68e9ace84392045e91241a7f..ae45cb0589c0effafc66f1756bdaecd1c1e53ab9 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1525,6 +1532,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
>  	}
>  
>  	progress = nbcon_emit_one(&wctxt, use_atomic);
> +	if (progress && wctxt.emitted)
> +		printk_delay(use_atomic);
>  
>  	if (use_atomic) {
>  		start_critical_timings();

This is too deep (also pointed out by Sashiko) because it multiplies the
delay times the number of consoles. For the legacy printing, it would be
more appropriate to put the delay inside console_flush_all() and
legacy_kthread_func().

> @@ -1584,6 +1593,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
>  			if (!nbcon_context_try_acquire(ctxt, false))
>  				return -EPERM;
>  
> +			wctxt.emitted = 0;
> +
>  			/*
>  			 * nbcon_emit_next_record() returns false when
>  			 * the console was handed over or taken over.
> @@ -1600,6 +1611,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
>  			if (nbcon_seq_read(con) < stop_seq)
>  				err = -ENOENT;
>  			break;
> +		} else if (wctxt.emitted > 0) {
> +			printk_delay(true);

@emitted is a flag:

		} else if (wctxt.emitted) {

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index cc203327247aa4f81f55b907c66ac88f30ce6da8..5278d9cb19e4177a00998fba5c1438251e033578 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3211,6 +3208,8 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
>  		*handover = console_lock_spinning_disable_and_check(cookie);
>  		printk_safe_exit_irqrestore(flags);
>  	}
> +	printk_delay(true);
> +

Again, too deep. Let console_flush_all() and legacy_kthread_func()
perform the delay appropriately between each message.

John Ogness
