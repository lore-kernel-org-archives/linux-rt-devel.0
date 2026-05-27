Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C443E023C
	for <linux-rt-devel@lists.linux.dev>; Wed, 27 May 2026 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871277; cv=none; b=XoB9yM4IV1RjcS1dK5fxirUJLr4J1GOFVtOsli3ZVtd3kUeNwmsMHtH10LIx6E8lsu8VeJQjg3/lNS5riZFcwKPkYwjWLkFMXmhnTrE7fKNk50gUmCSkDswnoUNa3lK1/7pWrC1mQLrn4cnGDJ7tvod5mjqljjpuLUxD4MUoJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871277; c=relaxed/simple;
	bh=4RJdtlvXAonvNJZVVS4YO0NxuX760SrZITEJGLud96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu8Nbn4N9okyRjk8uQ74w1MccYha973wTiZv6IyWt6bGlGazifRt0wd/8ebaaqvxltmSuKkKBhCeZwmQCTIZEkTodqtGstf7ABueCcpzUwqKo+0UcdyVe9BaBDphGROiQJRlQtuzfIZVrHnd7BP3/9doDQ+ap7RrUdTN6NoLBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=egSC6QTE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="egSC6QTE"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso30959555e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 27 May 2026 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779871273; x=1780476073; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DS0Qvfn3wnYHQZFbMC98i7Jr1S1IM77hBEnuir22yHQ=;
        b=egSC6QTEeaq7C9dtH7LWPaHU2/ICzX09mnGUGuvi9dceWZBE5v3Po9VGYg6uIuiIaU
         dg/UlFPGTPqSXT8+0TdKHuSmMhY/1Lv41oT5pI3AsAxbcgJlgjorZI+DxhqP5ZIuxcrx
         YHmyIhQ5uxQxO+BGOSwk8pFnb4SCSv3wZ2mU8hS1rjT2MkyyLCxuiFBLkf3N2J5xk5qI
         Xv9PPhSIwHET2mkxQLpV3UJpJykGZYxU9CfbxDMfJY6iF3SkjkdefXsTrLGFpCTlUoX5
         uX3TvERuaWJljAIxdYZc3cCgJqmeXIQaN6QGZ6GZroelkFMc3yNvWfyGMB+Vpv4ugPJ3
         rj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779871273; x=1780476073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DS0Qvfn3wnYHQZFbMC98i7Jr1S1IM77hBEnuir22yHQ=;
        b=iEgIkkpXecLxgTUlsuNL0l4cRz9xAze9a9VFi/C7lZbhVNoHlzu48R/6zdNLeOXlAg
         VnpSeK1dyoAN0cdrHXKbfTnqA/smQvL1B6cH811GtTW0U31GFHpRslMdNgzTmY54i/IE
         tsFC100iPq3mnc6CVBJ0r8uJvCbt4ypSiIM8CGOcvBN2hYz/pW+5Ph6mWoLk+eJj36Qt
         TJjsSS33XN1P7RB81rH8iA3AoLiaYC8ldlQvS8KgtCC7ZZkq4APuPcJvu8Eru/st1PO4
         ide4KphKY7szaRB90nIPLMLjzBaIX4WDqxG3Z0uj2BwkBVO3cv7GgyYkAdafqmb7hFLf
         bJ4A==
X-Forwarded-Encrypted: i=1; AFNElJ9sQ7qgVApvjTro5QtF1F6Rb1UK/Ou7F045B2m+zpR2unDsvm47pIwmbVNBUXE1IjMGdvWn784lHIkZ+3v2+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmJGdIfzgGuyW4/DqT6+0AdJ/hHMlmmd3AjQFpJiHiJze5Iv6F
	knaLTxwBMTpBpVbcYC7rMoHUJcv9HIMzC1l42SUBtr24blJjUfxIYJ6XXm25RHbqsCQ=
X-Gm-Gg: Acq92OH7o/4tQUbtNpFruAfKfRsBcc6rT0oajIJrl+B0z22ZAUS98NTvXSa6EuQEqdY
	XJ4BXpjXF9xSXSiqkAMB+WPq2rCmBr3cL/fLvUVmxgnWF37IWjarvIVPGlnrlWs2Y9frTveXDFq
	o923j4kXAKb3oU0iDBLzxbbEFjJTHQZ1/XuR6fnLTG/EIqxcEXNl+C5DkanlhLFVgh4/ksMAXLU
	jHQ37kJuM8dBj+PUTA3kGPKN803l0y2qnzQdJAMcO8hPzVli+XGYmPVNDFXj6KU2FqMC8gJuSDW
	0iGS0yZ/nJsmUqKBARdQBasSlXNKiwQDqW3j8A6fIaUJAr9cWxvXXY7vNbGnJj1kiAHBnG/Jh7t
	GfB+FUulB2dQM20yBIYiaw4jzjimE0wyqSynQkO+V7maPslAJK/jN8lvEDA+HNhQjVsvDxQ6wtC
	6t1rbwv+cRF2AmoM9+4ZLJksLag5YJXMqw7DK9H0zrZNbX
X-Received: by 2002:a05:600d:644d:20b0:490:3cb4:f1b3 with SMTP id 5b1f17b1804b1-490426c5a3dmr265077595e9.16.1779871273108;
        Wed, 27 May 2026 01:41:13 -0700 (PDT)
Received: from localhost (109-81-80-71.rct.o2.cz. [109.81.80.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0cd5sm472671585e9.10.2026.05.27.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:41:12 -0700 (PDT)
Date: Wed, 27 May 2026 10:41:11 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] gfp_types: Introduce a new GFP_ATOMIC_RT gfp flag
Message-ID: <ahauJ9DAqBPnRi1h@tiehlicka>
References: <20260520204628.933654-1-longman@redhat.com>
 <ahQLVgj8zV4xQRh9@tiehlicka>
 <16b36b01-7da2-4ec4-aefa-f06216ec218a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b36b01-7da2-4ec4-aefa-f06216ec218a@kernel.org>

On Tue 26-05-26 15:55:09, Vlastimil Babka (SUSE) wrote:
> On 5/25/26 10:41 AM, Michal Hocko wrote:
> > On Wed 20-05-26 16:46:27, Waiman Long wrote:
> >> The GFP_ATOMIC flag is to be used in atomic context where user cannot
> >> sleep and need the allocation to succeed. However, it does not support
> >> contexts where preemption or interrupt is disabled under PREEMPT_RT
> >> like raw_spin_lock_irqsave() or plain preempt_disable().
> >>
> >> With the advance of the ALLOC_TRYLOCK allocation flag in the v7.1
> >> kernel, it is possible to allocate memory under such contexts by using
> >> spin_trylock to acquire the spinlock in the memory allocation path. This
> >> does increase the chance that the allocation can fail due to the presence
> >> of concurrent memory allocation requests. So its users must be able to
> >> handle such memory allocation failure gracefully.
> >>
> >> The ALLOC_TRYLOCK flag will only be enabled if none of the
> >> ___GFP_DIRECT_RECLAIM and ___GFP_KSWAPD_RECLAIM flags are set.
> >>
> >> Introduce a new GFP_ATOMIC_RT gfp flag for those PREEMPT_RT
> >> atomic contexts.  This new flag will fall back to GFP_ATOMIC in
> >> non-PREEMPT_RT kernel. GFP_ATOMIC can continue to be used in contexts
> >> where preemption and interrupt are not disabled in PREEMPT_RT kernel
> >> like spin_lock_irqsave().
> > 
> > Before we go this way we need to really be clear we do want to support
> > raw_spinlock (aka RT) contexts. This is a big commitment because it
> > dictates internal allocator locking that would have potentially a much
> > bigger impact long term. I would go this way only after/when we conclude
> > there is absolutely no other way and we need to have allocator in those
> > critical sections. Now you have a single place which complains ATM
> 
> We already have alloc_pages_nolock() which uses ALLOC_TRYLOCK internally
> for these limited contexts. So the support and commitment exist. This
> just exposes it via a new gfp flag alias. But if there's a single user
> and it's already disputed, we don't have to expose it that way indeed.

alloc_pages_nolock is a very constrained allocation context with a very
limited use. That is quite different from something as generically named
as GFP_ATOMIC_RT that one could assume is a good fit for RT sensitive
allocations in general.

-- 
Michal Hocko
SUSE Labs
