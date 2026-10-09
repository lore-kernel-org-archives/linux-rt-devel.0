Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B8361941
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 Oct 2026 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565483; cv=none; b=MJRGT2hpkn/uRJiNRxeElTe38drQ17rZT6UqSrM+WZ6PMTrgJm5b1Jt8GLXX5YhY4m7ue9UbwWCHNn6rCmqGkSQzak3UkKV7+NtxUaA8B6WXokIDpjHG50goi+i9yV5pzIXOs6rytM5vbkDH0weCHxDbr13Or/s7MEHRS6otOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565483; c=relaxed/simple;
	bh=TPMxjHFy6NAhtBScqVVzIjOVVdFD4MHNL/+9nutj5ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/VwmGl44TUBxPTiLub5TsBMYUnIVm9qaXzjOnih7++ODHSSMyjnxGOUeUOMWCSngtzjQ4sHOth9oFpH252aNVOXi8t0IIpsc+GWbuwPXeftV5ETFL/KnCtGBsRo64VTmoRE522xydG/OFkyuCJncWKlxugRDljvfdW+q82tsxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktIgst7n; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktIgst7n"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso526675e9.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 09 Oct 2026 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791565481; x=1792170281; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LrMC70e9+PTh4RX8wSyKvGIWWB/E2Z8AYGozH2Gp3A4=;
        b=ktIgst7nU76GVorzvcRhRHPHoMF+Goa9H9X1LvDVn1IsAjwG4pL8N0PAKAgoNnGG5b
         LHEWxmAdxWduT/ItttyUt895267ix6QB3WUBDw7fRopdbasIWXk8nJEoquP/LFaOenRa
         KVM9U40nMg48KeSBzAYQ1uyD3TSkXTH+Hh+vUcbJqSXqBV8VZFiM830S2fCAHBn8PgyN
         NWkHvBXjEZ3j/SjKVbsLy9N0KsA5DfE6SeiSs3mYUiRfPuLlzU5tK/KlVTgmIA+TRiQE
         mu0aRzCCvysucxT5LBd0HwpkozqD1s4f5V6RvUDB0/fcJ+yhLg0O1TcNaYxBeruzT6Y1
         TZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791565481; x=1792170281;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LrMC70e9+PTh4RX8wSyKvGIWWB/E2Z8AYGozH2Gp3A4=;
        b=la1xnOsuNInTUDb02+0ukq2Uz7Kgzk+JrQSy52L/q7E1kleMUEZqL/3eDtiW5QavPR
         DxEiTF7Rh3dRwKdWIMJdUJEiCMuPkECIS3HPgwZ34zQq02I2D2o1XCNQkzYpGXIyMeqk
         GnVlNFDSB7bxagUAv1gFlGcb8W0BRaKB/8A8CeWFOvVHjWSMCBVQPCIC3OygSgyP0gQd
         uHtC/rQwuTy3TKp6ePyDyYMuk/NNTvk0Pyd5ffvP40orPW8Z8qX+fQOy4M8jHvWoAYo2
         ELQ+r+WVRa9FrE3gASAY8RAAeE6ATcgNV1DVJFzrqn5oJjx336yWve7uMJeGrOXWxdFB
         hf7g==
X-Forwarded-Encrypted: i=1; AKwUvByTBen4GlsemWmyyvvep5KT15H0TrCUC5v/ZlD1LYMtYWSOdTLVtd4cueER7zY2SWKM7jxtGArrbgwPkXlFCQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nHOVqGjColPIGcZfSrqgILsYOEAW5dhwodHCzRIXVCuCJJI47z
	bQbrL/6iS/pCXAPdnKofquezVMmJRv6a+8jjKOjAxGYNtrfp6BNDNySP
X-Gm-Gg: AYBFou03uHTn5jash5vuWyPrgIiGcyUl0F0tLEWQ8j9BC9Q9Oct4PW3/fnES5f5uSAq
	U3ws5VPQiT0Z8/X4hCbVSmhZR0YmBUKBjpjyJ3yRHGrJnoxfPQbLCGKIkDioEbGHn/iJDeS1sWR
	DXQGjc0nIJ+6v4eByRrrtNuO4Fq2YCtTxybQGF2oIq7UVpA3tiLoftTsGO5j05C85+ICkaK6v8m
	GoBE5P21gKtVVvGO1/d7p1IsFj3DZEsAyL1fdjGkamqThoAT27H5BQ87VFYIIbpGod09yb5ONmx
	1OlVms9nk3WXYTWos5XrJbS/WZxsE/vbxVqfiSpfcql0Zh9hpnevjqRY27nkTa4+A/C1wNv7pnM
	9rhe9l4fuG9nLChJy+rTTdhsO0rrrTQegpZDmknc0OOWiyCx9H2uGWO1V5Cfv0y5L0Nm7S0cvVI
	h3IbCjbCWJrS9YYm2InsAAM8KAOB0aQY4m9wFDIX3Pw7ZsnZGC8107k3JfMSD/nVKnOoi5QaHLe
	5TFdLSy64zx/ufeAlnDqRuRAag5xa9RuNaaZnGvL922cj6gYBg5SvegXScNk6Mlw7AGJG9jSIBM
	z9q4Kpem8RkxSSLxDttGDv0Ki91fV7tQX+2B6nPbziwIAgtDydphcADFuhUHVpHCEj6z6b4PtyU
	=
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a18e4aa206mr51409345e9.27.1791565480423;
        Fri, 09 Oct 2026 10:04:40 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a128-aa01-297a-7094-853e-a20c.310.pool.telefonica.de. [2a02:3100:a128:aa01:297a:7094:853e:a20c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abce2fsm4945670f8f.33.2026.10.09.10.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:04:39 -0700 (PDT)
Date: Fri, 9 Oct 2026 19:04:38 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Bradley Morgan <brads@mainlining.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5] softirq: Preserve interrupt context during IRQ exit
Message-ID: <askelKsbreC8HLpa@gmail.com>
References: <20260930191432.62760-1-kmehltretter@gmail.com>
 <asTG09Me93-zP3aG@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asTG09Me93-zP3aG@localhost.localdomain>

Hi Frederic,

Thanks for the review!

On Tue, Oct 06, 2026 at 12:00:51PM +0200, Frederic Weisbecker wrote:
> > +static inline bool softirq_handle_begin(void)
> >  {
> > -   __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
> > +   bool from_irq_exit = in_hardirq();
> > +
> > +   if (!from_irq_exit) {
>
> Is this variable necessary?

No. I'll drop it.

> > +   /*
> > +    * Wake the timer thread even if the interrupt hit a softirq or a
> > +    * section with BHs disabled. Only nested interrupts and NMIs are
> > +    * excluded.
> > +    */
> >     if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
> > -       local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
> > +       local_timers_pending_force_th() &&
> > +       (in_nmi() | hardirq_count()) == HARDIRQ_OFFSET)
>
> NMIs shouldn't ever take this path, right?

Good catch. I'll drop the in_nmi() test.

> > +   /*
> > +    * tick_irq_exit() relies on in_hardirq() being false for the
> > +    * outermost interrupt.
> > +    */
> > +   preempt_count_sub(HARDIRQ_OFFSET);
> >     tick_irq_exit();
>
> Can we also extend the HARDIRQ_OFFSET context coverage to tick_irq_exit() ?
> From a quick look I haven't found anything that would prevent from that. You just need
> to turn the "if (!in_hardirq())" test to "if hardirq_count()) == HARDIRQ_OFFSET"

Yes. I checked the rest of the tick-exit path and found no other
dependency on HARDIRQ_OFFSET being clear. I'll make that change.

Karl
