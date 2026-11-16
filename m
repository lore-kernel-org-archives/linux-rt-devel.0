Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848914;
	b=tuVDmHeJisnBgilQC03I+S41FjsrUs8F7LggXGHhW2W2hIjPbINvprn2ZKresCO6Sb5a
	 5MlJBofCNO7JU0juQT549AF8EzucYlTakPAI8Ihx4fX98Ceiaw9/gKnen/6NSsr4obiFl
	 OqgIrWKyW4xD8Tr3McahQLLMLvlSfZvREboa1LS5BFWzLa7OL9cJYd2b7J6VYJFo1Fjeb
	 IbVH1h7i2RnMsT98pVbGcBetVhSU+ZubOudoEr7GWu2f6UiWv/NsmXoSQetBoyKSVLECQ
	 dltykj/bELWNePEp7e1WbMLvtEf2E944sYIk2B8EmeEu9NT/gAH/99OLJFRMMbPRKKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=z/lO0d4awc7COFA/57IeDRMAZfL8lXDL1xwEp8NDS/0=;
	b=c16YzpkOTEMvw4eOtWtD7oA4CpM8CBsugLwKBENCDZIlhtfMVpXDkNlxmtJYiqZXnTYt
	 IbvW6zjb6ZczbKR0Pe5mF4A3H2I5A+y3ee6ookw1fQ3MMQU4ehPEFgyvZce/dODxdANUx
	 DKkUiqFDHmkcvBMiZvWm3j1sGE+AK21dGkuvVZpmUxRJksQmjrAFgMg7qT1BgZZoOdsr5
	 jlXedSkEqQ3EA+cfLGcEboAWTHykN2wayPj/juHtmmhqhy4kE0L8MPZWq/FUF7Ro/wsiG
	 BQ7Cu79ZPIuX5nJAxd7eDjA9KqTtiP5mPAuNZnFKiMNjRvwSSNMlHtOA5boLi5ZkMHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GaveqE0x;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713DC606A880
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 17:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 713DC606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GaveqE0x
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a210470b49so30700695e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794848912; x=1795453712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z/lO0d4awc7COFA/57IeDRMAZfL8lXDL1xwEp8NDS/0=;
        b=GaveqE0x09vPtVzmiFYzlZrweKSyotyJYr9cmYB4ab5jvjkW7/E/rI+CkkFcs+g43W
         jxdi4yz2Tz/FxFORoysYxHpmxu2mpdumVILchaPCO1X2FzdcMDni5+ktfSPgEGwEQ9cy
         0bo7mZebQMGALB70jszVPxUetkxSuVRLv0h2Hqk3bJbNy6ubfEuWTnegO/bEW22yxz49
         8HnPERXiuW5JozwecS+gpWNof611sFlX+Gfdk0yOuv/0FThSkJvipTGFxeiwxx7b1lpX
         nQLbGd4z1oEQz5fCOBl+NaiDeXUu5yJt7aW29XfHUeXQHLcj41fcPhl4xLU+XB/CdS5y
         Gjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794848912; x=1795453712;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/lO0d4awc7COFA/57IeDRMAZfL8lXDL1xwEp8NDS/0=;
        b=Tlw2Z6ACNnFQtJnDjvxl5qrJdav8qdWbavQWf4sPeyKAwCnLssT/hfexdXZKaNL8W0
         xmXb894R+OmFe0PWCA5E8F/7T60ozaAyeb+9S6D22G5OVcgrmA1Sp5Now4Fc8nXEz8cC
         mGNIMbQH+w8n+VS+WUhP7gGJ1gwA1nKPkzMvJEij1EWRgC12zQTUlIrLplPdg3IO6/nF
         BsogVfQNFX3cDoi+2zAKARnwsC5Yoz1yuwMVZSdGdMl8HRPMZiqm0uV7XQ0YMr+huhav
         9O9DuSXV4sP7dKjhz3QNFXkrPHb8Cs5VWrotZ7eb+2XV+atM1NOnTYymDAaRjZlDIYjS
         w22g==
X-Forwarded-Encrypted: i=1; AL+hErFJI/Yw5xHXldJVpC0+CU1z59KEOAYOEXIN2aatn5Jz6rqp5dHf4nRSj7MY9W7esYzCCGUFpI3xfMNbM1VPyg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/iGx+dfaBTMZIbJTC/TKBxbBfxHoxaJvMkWJIDQlzVjW2/pXqX
	8OepmFqrYgvqT7h+AODIrTXQA4AcWG3w/exewzG1Ovja4b3Jm+QbPqmNZveXfuHqdrQ=
X-Gm-Gg: AYBFou1FP6e6mXidjJ/aZtURmWh25loQ56Iz6JlpkvvNVg5hlriIoNyDiUHh5J82kC9
	+EBIyRrGJLf9wDRZ8u3RXF8DX4E6/KJoBdSZi8CCXVodW0Nzwf+rpMEmF5E2DpT9FO2WzBHwWXO
	/FtoDakoVOv5L1kJ+YpKFGum/g+ie/pfBSaidLOWTCO68EdTwixXcUEvMtis2vrmp+LQIcl8mIQ
	WpxgIaG+bU1zOKkrukhkVwbD6w4p8Hg1wGmR7JYMApWU2POFsMX5IeWYPeDPNPvWMYZXC0vvhlY
	zVJOU7o28ZomiQrzCuOVqSeibF2h5SILlXiQDN3ZvkYThqdTPAEiHaaKh1two6FG5lKg2XMC6nB
	jmPQr1KcxyI5j8XYS/zQi0m6buLLHjnD/oB670zRHCNnh88o47IWCg4b90F2o47wB8afd2uaJYk
	sKalUD0W19A8RwLutNPCR/NRmUA2bHl7Dl7SjfNf3+KKnL3W4+7LBM3wdygrUwvYvaZYPVuUXzO
	Cd9gzcGx8AtmNYeOiqS7Sv9Mn3+2wEYluRKQTfEF6NF1ljvsL8p1rwTsqh5LE2XW5p/o3BahzIy
	S3Z2otDnLFfOQbTFEzZjuOptYtLSL78=
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb6c71c232mr97325545e9.6.1794848911805;
        Mon, 16 Nov 2026 09:08:31 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c77393700sm22964108f8f.18.2026.11.16.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:08:31 -0800 (PST)
Date: Mon, 16 Nov 2026 18:08:26 +0100
From: Petr Mladek <pmladek@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: john.ogness@linutronix.de, rostedt@goodmis.org,
	senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev,
	hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH v2 4/5] printk, tracing: Support console flush
 suppression and tail pinning
Message-ID: <avs4igB_mEc9U-Yw@pathway.suse.cz>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-5-atomlin@atomlin.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103024453.922373-5-atomlin@atomlin.com>

On Mon 2026-11-02 21:44:52, Aaron Tomlin wrote:
> When collecting high-volume diagnostic output into the printk ring
> buffer during a kernel crash prior to kexec, synchronous console
> emission can stall the panicking CPU for tens of seconds on slow serial
> or IPMI Serial-over-LAN links, risking external hardware watchdog
> resets. At the same time, uninhibited ring buffer rotation can wrap and
> overwrite the initial Oops, faulting registers, and primary call trace.
> 
> Introduce two scoped mechanisms for in-memory crash telemetry
> collection:
> 
>     1.  Console flush suppression

Nit: We already use the word "suppress" for filtering less important
     messages on the console, see suppress_message_printing().

     I would prefer to use another name to avoid confusion.
     We basically want to "block" or "pause" consoles here.

> 
>         Provide printk_suppress_console_flush(bool) to clear the console
>         flush mask in printk_get_console_flush_type(), guard legacy
>         record emission and kthread wakeups, and suppress
>         wake_up_klogd() in vprintk_emit(). Records written via
>         vprintk_store() are stored in the in-memory ring buffer while
>         bypassing synchronous hardware console emission and kthread
>         wakeups.

We already have similar infrastructure for suspend, see
console_suspend_all().

We should not use a completely different aproach to achieve
the same. It would just complicate the code and design.

I suggest to add CON_PAUSED flag and handle it similar
way as CON_SUSPENDED flag. It should be enough to:

   + update console_is_usable().
   + add console_pause_all_in_panic()

, where the console_pause_all_in_panic() would do similar
things as console_suspend_all() with the following differences:

  + no flush
  + take console_srcu_read_lock() instead of console_list_lock()
  + no synchronize_srcu()

And I think that it will be only a one-way operation. We do not
need a resume part.


>     2.  Ring buffer tail pinning
> 
>         Provide printk_mark_panic_start(), printk_clear_panic_start(),
>         printk_freeze_tail(bool), and printk_is_tail_full(). Recording
>         the next reserved sequence number at the start of a crash (or
>         clamping to prb_first_valid_seq(prb) if the crash output itself
>         already wrapped the buffer) allows data_make_reusable() and
>         desc_push_tail() to continue recycling older pre-crash records
>         while refusing to advance the tail past the pinned crash
>         sequence number. Once the watermark is reached, prb_reserve(),
>         prb_reserve_in_last(), and ftrace_dump_one() finalize the last
>         record and stop reserving descriptors or consuming trace entries
>         so the primary crash context and remaining trace buffer remain
>         intact.
> 
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -377,6 +377,90 @@ static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
>  	return (void *)&data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
>  }
>  
> +static atomic64_t printk_panic_seq = ATOMIC64_INIT(U64_MAX);
> +static bool printk_tail_frozen;
> +static bool printk_tail_full;
> +
> +/**
> + * printk_mark_panic_start - record the ring buffer sequence at crash start
> + *
> + * Pin the next reserved sequence number at the beginning of a top-level Oops,
> + * fatal warning, or panic so subsequent tail freezing can recycle older
> + * pre-crash records without overwriting the primary crash output.
>
> + * Context: Any context.
> + * Return: true if this call newly pinned the crash start sequence from
> + *         U64_MAX, false if a crash start sequence was already active.
> + */
> +bool printk_mark_panic_start(void)
> +{
> +	s64 panic_seq = atomic64_read(&printk_panic_seq);
> +	u64 first_seq, next_seq;
> +	bool pinned;
> +
> +	do {
> +		first_seq = prb_first_valid_seq(prb);
> +		if ((u64)panic_seq == U64_MAX) {
> +			next_seq = prb_next_reserve_seq(prb);
> +			pinned = true;
> +		} else if ((u64)panic_seq < first_seq) {
> +			next_seq = first_seq;
> +			pinned = false;

What scenario does this handle, please?
Why do we need to move the "pin" when there are concurrent callers?
What happens when the original caller clears the pin and
the other racy caller continues with panic()?

> +		} else {
> +			return false;
> +		}




> +	} while (!atomic64_try_cmpxchg(&printk_panic_seq, &panic_seq, next_seq));

Are the atomic64 operations safe in NMI? I would expect that they use
some locking.

I am afraid that we might need another approach.

IMHO, it would be much easier when the caller knows whether it will
panic() or not. And the panicing caller would just freeze buffer so
that the next_seq will always stay there.

Finally, please split the console pausing and ring buffer freezing
into separate patches.

Best Regards,
Petr
