Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7C3502A8
	for <linux-rt-devel@lists.linux.dev>; Thu, 28 May 2026 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954592; cv=none; b=KulqxFYaWvFf6pQLa/MyGxo33oASkQayeT1RsMRMw0gbxT+hdIK9baqx162NKt7w2gxh6izsYMNWyu8TY4atk5rQGi5r6fIBjbEj5czP2TiD5w1qy+o9LR2SGNYgD0FgRt/yn+U7HWbHbv+xKadUmoDBuztB0goa//aBaBIdrl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954592; c=relaxed/simple;
	bh=AhLJT0xAkoIlWmIGmKS7xR4cRQgg6hLZU6ZGxK1AEiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taLshTsEx7bSdf9lxxnrgOI16CIoIZhVFRn1RbLv8oXH8WvsIE8OTYX2kv7UKrlxoUEoMv+NTwOSlVIF+WrCfT46Eb41y+XKVAKcbUq+h0dnrgd0SbD+31ceuH6SXEKG03vcNszrBtEUy6Xnt5HOv4JzFJHhwYIcVk0sfa7d+Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wiYU3SXw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jkrk+wvd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wiYU3SXw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jkrk+wvd"
Date: Thu, 28 May 2026 09:49:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779954580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBJJEzwFyWamBfG5rntVZOiaXmknM5Hgfp5p5kRX+uQ=;
	b=wiYU3SXw6Z7hLakLrz0nfyDti0fVJeCsKff55qpGRNMOEsgalQAGPsof9DYTx8Uf7Q6QJv
	111f5jHwEHb7l0rAA8Ls3My7Ok9OWAn0k5tRb9Hj/DJl6zlAD+Z3POCYVmDLXpf0svZwqb
	AT0DYL44HFSLagFaIfYysBdpLdtzJiKTrRWcNaxcw6QnMyuIfmgF0o4Z9MnUfkT+jz9QBm
	UmQUVtoztkOGWaoat0dDG28tIBZy7WCaSmJZXnYK8KzWXlgZANsA++Zq5xh0+CBUdfKlLV
	xPAS6Mpidoa+6qxpkkiRbyI66Z7irOewpMR31JB+qFNtlFU/yEbyyoFK6LKmng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779954580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBJJEzwFyWamBfG5rntVZOiaXmknM5Hgfp5p5kRX+uQ=;
	b=Jkrk+wvd7jHJuFUfr/zmgTqf0jJP7Fbiimy2TpUNo9dIH7ISdPfYagNApTEAtzmr7gnp0C
	kzlBRoLcBki8f2Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Byczkowski <by@by-online.de>,
	Eliav Farber <farbere@amazon.com>, linux-rt-devel@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v6 3/3] pps: convert pps_device.lock to raw_spinlock_t
Message-ID: <20260528074939.7MLrIhrM@linutronix.de>
References: <cover.1779733602.git.calvin@wbinvd.org>
 <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>
 <ahXdZFrw79US8MO3@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahXdZFrw79US8MO3@mozart.vkv.me>

On 2026-05-26 10:50:28 [-0700], Calvin Owens wrote:
> It does seem to be correct, with CONFIG_DEBUG_ATOMIC_SLEEP I get:
> 
>     BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>     in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 31, name: ktimers/1
>     preempt_count: 1, expected: 0
>     RCU nest depth: 2, expected: 2
>     CPU: 1 UID: 0 PID: 31 Comm: ktimers/1 Not tainted 7.1.0-rc5-00004-g85f7c8ee247a-dirty #3 PREEMPT_{RT,LAZY}
>     Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
>     Call trace:
>      show_stack+0x1c/0x38 (C)
>      dump_stack_lvl+0x58/0x78
>      dump_stack+0x14/0x1c
>      __might_resched+0x128/0x168
>      rt_spin_lock+0x34/0x180
>      __wake_up+0x2c/0x70
>      pps_event+0xdc/0x2b0
>      pps_ktimer_event+0x44/0x80
>      call_timer_fn+0x34/0x2d0

This is all threaded and the atomic contex gets here due to the lock
swap.

> The lock isn't part of the lifetime of the pps_device object, so I think
> fixing that really is as simple as not holding the raw lock across the
> wakeup, something like below?
> 
> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
> index dc7fac75ec27..f85929d01e3d 100644
> --- a/drivers/pps/kapi.c
> +++ b/drivers/pps/kapi.c
> @@ -203,17 +203,16 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>  
>  		captured = ~0;
>  	}
>  
>  	pps_kc_event(pps, ts, event);
> +	if (captured)
> +		pps->last_ev++;
> +	raw_spin_unlock_irqrestore(&pps->lock, flags);
>  
>  	/* Wake up if captured something */
>  	if (captured) {
> -		pps->last_ev++;
>  		wake_up_interruptible_all(&pps->queue);
> -
>  		kill_fasync(&pps->async_queue, SIGIO, POLL_IN);
>  	}
> -
> -	raw_spin_unlock_irqrestore(&pps->lock, flags);
>  }
>  EXPORT_SYMBOL(pps_event);

This does not work because the commit message claims to allow
pps_event() to be called from hardirq context. So if this is called
indeed from hardirq, context as claimed in the commit message, then
dropping the lock early does not help here.

Does it need to call pps_event() in hardirq? Patch #1 takes the
timestamp in hardirq deferring the remaining part to the thread. What is
the crucial part here that needs to happen in hardirq context?

> Thanks,
> Calvin

Sebastian
