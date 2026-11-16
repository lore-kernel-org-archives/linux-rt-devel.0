Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859215;
	b=gIyo1DtXq6jM1aMDdnMl6im7mSfnUEnO/dZbTIsYUJfJheU1ErhcGVfb2ZGI+R3lEEBt
	 ldNI5YfjOJccvhZbtaN9BlQEOCO+KU9jXCLU1oGuruyinLu0kpq0YstObzFDZGbVTLfBB
	 jKoQoZcMe/UiG8OWNa8H8ZbcpfmQtqz6gAXjY2AaIoCjQ3G6t5sPa5O7E40gQCoCULo7P
	 fjGfLBlDv385ff7gnl+z+H5WFPd1ks6qrz2V4y/ooiFi7mN+ew/I2+M0p7aM4HEL3SAPF
	 cl8CEm+bhrWAIQ8lfmrYd6SxUJcFYG7GzIjWlR2uLbF1ucvn0wtjrJsRubgt346o/sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fgYoS8Jg+X3AS3gIOJEgllVRt0eGZvLJAbdMyeSaVoE=;
	b=IkKrB/JZmhhr9rUBiQU2dCXzr1xvCaD64avr4g5EyN763MhkraH86ZRoC/2/ydYlhVvj
	 a/tDDiMux9Wv4nVJxsUIp+lwDDNuoBZKiqZvtmhB+uc0VMkLZif8xBadRrSflb6PAt8RU
	 JbNCq1zEC9H4wKtWoqLdeyz4GQErZ1P8aw6Mt8ZBbU8VKZ6NddNO/3vXwvvEhurdGIgVB
	 rdVOiK+qBBHFFO542oUQ9DvTIuKnRY91uhqpAn9pw03aWH0XjUacXx0JpAz/E7nQaJBAB
	 FXa0yanL/ZD30PFSLN+Xq4hOrSXuvYhJ2PfmjBAPm9oiVeRJrbsYt0kdui0JCvyq/uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AlDI2Nz8;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B6606A332
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 20:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 357B6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AlDI2Nz8
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso15495085e9.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794859212; x=1795464012; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fgYoS8Jg+X3AS3gIOJEgllVRt0eGZvLJAbdMyeSaVoE=;
        b=AlDI2Nz86t8DRBwPaqXVa3foveebjbMOzqfKuhRyZRxkP8cU7G25A7Bxz8h2q/OB/R
         6l32r5r0I00P4x+qBm9CasJ01HzuaoElLiQuHmPD/bQ9hr9HO+wj/GQmO1g7C/zmD2QO
         gAEPHUNaMWkEXW/Zjs1cA4vp+Lbljgg4vs6ax0aCNov2y1QreGiq/xNLG784aHPO3npc
         wmG1MOPDgT3YHVpskefQOd2JJSS6WY453Mw0q7STE2FPlTj+UcidrPztU3Cimw/kmQEr
         evqEB36MxYC0G4OF6OxrAEgKeb5EzynlfOmfL3hIeG6OhT4NwqpN56A2n4Mv2mABsXJ+
         1nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859212; x=1795464012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgYoS8Jg+X3AS3gIOJEgllVRt0eGZvLJAbdMyeSaVoE=;
        b=v0Fuo+jvOjPwVxwFZcNCMjBoYzgIJ6xJpXNl45KSox1Isb33ypUMzeatLpp6SKbeyz
         6IfYBt++aAa8RHc56TA1kUwAnzt6eeepFb5Bxg94kEpUeb/fNe1CIMxSwA7XGm+94ysY
         tJpwzXvh+XhYmRXkF6R5XE1lMsJpAvEo4PHWFQA4igpmcX97S9PjDW5NdPWSg5P0z6Mz
         DkDIphS88dFHEXCUYUREZK20ieETTaWbYpCHsA2g42v0OQTmsVmG8yXlLko5XmQHzfTM
         U4v0zO/aXF7s/IaNvOanpLz0dRe82Xh3me+ksferOATGbT8MO2Cj3/iNxMDuWQVJVw9t
         ac5w==
X-Forwarded-Encrypted: i=1; AL+hErFwkoXEp+MSrhEV1SmxTo3rbNlk5BnbtmPglvYEnVmeKUbI3uZMyuBvDmDD9qn+Rbbl3u7ogHEDsCV2o9poMQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z//0iMyL+xuFiNeUc4Fxa1kYWUe95HChtYtk91uVh9E0V7db25i
	lAeNmADfdE3ECtExu8TlpkO25TSm5HFyhiQuOaUDqmUhMBVZIL23+8wQNx1vX3z01Yc=
X-Gm-Gg: AYBFou1qbrlQZ90d/pWTN3HmhU3lByDm9crW4oDv1I/6mDh27i/h3rrpin8C4M84QGP
	u70g+78kDkIASZmyvsErKLoGj2EbT9/CCl2ZUJX4QTUB/Y5QJx92cwSD3Lu0LyGT9kZN6ur9DOz
	Vaaw6dxnuBjuHG+GAdqj05i3JXfcL/AAps//FEST/I0eiCl9uzaic33utWVh9KUyfxsartS3MQD
	0XYUsgyk7K1dCV2Lcgw0AWlkGSPQ2PmQN3CsrimqFp8d0RO5KWVO+HDy9xv3CQjNf3bW3eTMI9O
	iV6oUVTqlD0Thg18j4uXkYMKXbBnom9tkHtyIqa/9HWx8bkMQIpxHAhN9CL92AuUyxdpcndt/GZ
	idSvTNFwlKlVa6TAIieSwRtGuiKS19vH8j9eMFGKauWabYzEeQNGG38Be/Pazw7WSGBdejePkbp
	50RLzXB/n3fjZ31AaiMEWlM9lj0BicPPRhN6bOR07HlJKMdaUtfHUweBr/WAkvDv0QBuZL8F4zt
	LQtDLiWZbq38NQ7tAMmeLFEmN3JH7K+4t91TqceznxwOhz7ecXuW4whiOpUsAlGdvgDjdfkwLQa
	PKoodzSEs6KqvK87/Nwkj3Fq/HGKPa4=
X-Received: by 2002:a05:600c:8709:b0:4bb:73ad:c1f0 with SMTP id 5b1f17b1804b1-4bb73ade318mr72004685e9.23.1794859211890;
        Mon, 16 Nov 2026 12:00:11 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78386902sm14032225e9.1.2026.11.16.12.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:00:11 -0800 (PST)
Date: Mon, 16 Nov 2026 21:00:07 +0100
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
Message-ID: <avtgx3WkeDvn7zoK@pathway.suse.cz>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-5-atomlin@atomlin.com>
 <avs4igB_mEc9U-Yw@pathway.suse.cz>
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
In-Reply-To: <avs4igB_mEc9U-Yw@pathway.suse.cz>

On Mon 2026-11-16 18:08:31, Petr Mladek wrote:
> On Mon 2026-11-02 21:44:52, Aaron Tomlin wrote:
> >     2.  Ring buffer tail pinning
> > 
> >         Provide printk_mark_panic_start(), printk_clear_panic_start(),
> >         printk_freeze_tail(bool), and printk_is_tail_full(). Recording
> >         the next reserved sequence number at the start of a crash (or
> >         clamping to prb_first_valid_seq(prb) if the crash output itself
> >         already wrapped the buffer) allows data_make_reusable() and
> >         desc_push_tail() to continue recycling older pre-crash records
> >         while refusing to advance the tail past the pinned crash
> >         sequence number. Once the watermark is reached, prb_reserve(),
> >         prb_reserve_in_last(), and ftrace_dump_one() finalize the last
> >         record and stop reserving descriptors or consuming trace entries
> >         so the primary crash context and remaining trace buffer remain
> >         intact.
> > 
> > --- a/kernel/printk/printk_ringbuffer.c
> > +++ b/kernel/printk/printk_ringbuffer.c
> > @@ -377,6 +377,90 @@ static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
> >  	return (void *)&data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
> >  }
> >  
> > +static atomic64_t printk_panic_seq = ATOMIC64_INIT(U64_MAX);
> > +static bool printk_tail_frozen;
> > +static bool printk_tail_full;
> > +
> > +/**
> > + * printk_mark_panic_start - record the ring buffer sequence at crash start
> > + *
> > + * Pin the next reserved sequence number at the beginning of a top-level Oops,
> > + * fatal warning, or panic so subsequent tail freezing can recycle older
> > + * pre-crash records without overwriting the primary crash output.
> >
> > + * Context: Any context.
> > + * Return: true if this call newly pinned the crash start sequence from
> > + *         U64_MAX, false if a crash start sequence was already active.
> > + */
> > +bool printk_mark_panic_start(void)
> > +{
> > +	s64 panic_seq = atomic64_read(&printk_panic_seq);
> > +	u64 first_seq, next_seq;
> > +	bool pinned;
> > +
> > +	do {
> > +		first_seq = prb_first_valid_seq(prb);
> > +		if ((u64)panic_seq == U64_MAX) {
> > +			next_seq = prb_next_reserve_seq(prb);
> > +			pinned = true;
> > +		} else if ((u64)panic_seq < first_seq) {
> > +			next_seq = first_seq;
> > +			pinned = false;
> 
> What scenario does this handle, please?
> Why do we need to move the "pin" when there are concurrent callers?
> What happens when the original caller clears the pin and
> the other racy caller continues with panic()?
> 
> > +		} else {
> > +			return false;
> > +		}
> 
> 
> 
> 
> > +	} while (!atomic64_try_cmpxchg(&printk_panic_seq, &panic_seq, next_seq));
> 
> Are the atomic64 operations safe in NMI? I would expect that they use
> some locking.

To make it clear. I think that it is not safe on 32-bit system.
This is why we used 32-bit lpos values internally in the ring buffer.
Also we use struct latched_seq for "clear_seq" in the printk code.

> I am afraid that we might need another approach.
> 
> IMHO, it would be much easier when the caller knows whether it will
> panic() or not. And the panicing caller would just freeze buffer so
> that the next_seq will always stay there.

I know that your proposed design make the new API easier for use.
You just remember next_seq at the beginning of a potential panic()
message. And you freeze the buffer when you realized that it really
ended in panic(), ...

But the proposed changes in the printk_ringbuffer code look complicated.
They are not easy to review, definitely.

I feel that there must be an easier solution. For example,
desc_push_tail() reads the state of the tail_id descriptor
including the @seq number. It should be enough to compare it
with the pinned sequence number and return failure when
it is greater or equal.

One more variable might be set when the pinned sequence is reached.
And prb_reserve() might then always fail at the very beginning
when we could not make any more space reusable.

I am not sure why you touched so many other locations. I guess that
you wanted to allow saving short strings when they would fit
into the remaining free space. But I think that it is not worth
the complexity. This feature should be used with a big log buffer
so using few more bytes is negligible. And it might even be misleading
when we store some random short string later.

Best Regards,
Petr
