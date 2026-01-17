Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803930FC00
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Jan 2026 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768617014; cv=none; b=Is6/URgXi5GcCrGXAy97c9iw0TvYZdqU68ee0hXoAmQqn4OuRIytyYeHNhuH3Gsz8ltA05RW3/y6npN+EWptLgjYYeEF3K1OR2l7ZjCQ0FLZoXJh66PjxAhuv69mXw7bShHpzt4pzDV0H1dASUMVQazl0u5UQfYL2FpX1a1+5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768617014; c=relaxed/simple;
	bh=0bZnyq+Ml97kOU4TUsgrr0iIUUHrsIknfLGbXt8rddg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOX/kRQ4WzkP3xzG6ZGwd31OmYcwTA4XkIylWLA+ewTfpQs7YhLHH/L5igQh/RmVFM+5Nz1K7LmdWBi6r5iWnhKLtzL2i/pBwB5gpWlPdPDAt+k1jIdU1E4BxYvEW4KryO+z5QGfg71fE2XJGC7diZg0BIfkzYyVWms5MYCGeLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYCZvyHI; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYCZvyHI"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8908f5ed4aeso26350616d6.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 18:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768617010; x=1769221810; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7v6jVLBvVKWoS0dmG0nNndXtomcaAtap7nM7qINq/8=;
        b=DYCZvyHI2PkIo2TUI7DFvG618YcknQaQUBtdbivAE0QTRNgZ49g4KABY89xMh4Rl6L
         XygBKZdwRpgzhfKprgntptaFrDvfU2aXMG6HWoyrXtvRxLKAUPNjVaNv3FvU2h9sWEpn
         lNVQg+9iTCHZutA8IkMVe/M69BPHUYujkf9aHY8K0hJf1plz4bhjtlP/SS2xlvBsidmJ
         mWK4KfD4LhGQKeQ1WMcvIBfTsSIAwr75iKUYF5Gnr73PQO12prfV/dvmgSP5LxsyK1wk
         xjkDXH1Q8OhfrkFlsVBHH4BgWkddyEfuPtr+Pqv80ChK+wxHk/S0AjykAw8aRpw52rnW
         9Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768617010; x=1769221810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7v6jVLBvVKWoS0dmG0nNndXtomcaAtap7nM7qINq/8=;
        b=sxPSm4S8uRCcGq/qehe13jsvByKpJLFYIHFWhShVlNmOz3ndUjQwbQdSsn/7DuHbxf
         GdD6eBuTY1kNU9t4HvHnoMwDXkkmmzl+Yub38atB9Z+fzD+BohJAUhCTyu6SzSfME62T
         UACkhb35ohz/mQZ26RBl0DQZV0e5/4FtwjamnKd8GbL+JE1RdUi/9WezXstiCs+JkTA2
         blLbiNu/bD6kGuwakL6ZrBoBpF/lGoF3/bB89d/n7eLhS6tdKXbe4lJboxEIQYn09dcQ
         ji+iYC6la7XytqsqYsH7lg54r/lgs49pOz8CPnCTaK7wrmUhevYDuifc1d7Ev3OOoRD9
         KImQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+blhgTeaws91VsiqhQXFZX6I+v9H7Pesd5m5vGtySJ4nJBzz4QkDybmC9ofCHHkD4YWW3AxqK7KXsO8KOfA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/+77NBRcQOFx9D/lirl5WO36v3OVNezLtObsBhm8jZ0dSXKRw
	7bZef2B6lj4mOyoVvkI+MSuX4JbwmVVQcOm/Uq49qN4ZKTnaONowqexR
X-Gm-Gg: AY/fxX5vWXYgogjBRWn+u9vb0gbUPkiHljshedysdkaaX7AD/yhrSrDDO17LjvrLlIK
	wdGWAbFoQoBiot6Bmbs0wNveFTMdWU0ZsG4mmGqRGBkoT3tTVGTt4JtkH3f2t6ESN+kpQPXB3ak
	o2WgqYFrL3/vkEkK4q3moUlnYmtAW+UlYjkMVDkede6ODe+n05KQS4VcKMf32hutqnJxMmXbn9n
	8wjoacfx5+o0KmqfwF5vyAanjT/MsufoM8gKndlymUkedIF04XdpSYJTvGbzmaUEUoLzMF1URQA
	XN9Ttpvo0oeOE5QaBjSYpJKj+AiuSUgBcT0fT1aYTK5GK1pBnSu8CyPsiLhDQWPUp6kIfl5Lsw0
	POOAmEjLhgdRg4Gqoo7uOLbV/g+3uteu5DlmFtQCncBKSAFoApBqe5QxBqEVm/tLSH3HVf07Tch
	nHJ1epibpGhfma1AYR63fBBLjdN0882bqhgBoIR4cPQdabSHOc0b0iAGoFROM/mCNGPMyBnkBaR
	UNxgGpf7SfDTdlLn9QjWqRXqw==
X-Received: by 2002:a05:6214:2261:b0:880:5193:10fb with SMTP id 6a1803df08f44-8942e4b8ff5mr68519416d6.54.1768617010378;
        Fri, 16 Jan 2026 18:30:10 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6d87b1sm35532246d6.53.2026.01.16.18.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 18:30:09 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 156CCF40068;
	Fri, 16 Jan 2026 21:30:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 16 Jan 2026 21:30:09 -0500
X-ME-Sender: <xms:MfRqaRL--ju4zV_ISOu5lD9zKuBBxccbOly9O2AkT6D2dCeGlk9QQQ>
    <xme:MfRqabhDLTJhkDbvlKH3L7AcPMtqfCzOXh9dPHvXbgVVSuhNRITNqr-8h81dso5rJ
    MUkWoMxPEL5SyMbc08xe6WVYEKeg9a8B5cqy4Mffy6onkcJq9PL>
X-ME-Received: <xmr:MfRqaVveKIEYp7Ot9BEkqJqaTy8gceQxw3BraIMpzTKdynrvoBoI5YOP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomhdprhgtph
    htthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgv
    thgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuh
    igqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtoh
    hmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthhtoheprhhpphht
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtoh
    hm
X-ME-Proxy: <xmx:MfRqaVgFbFySiTaExKnRETsMtBEpjHwVJZum39nKdmXH3mwjMdxINQ>
    <xmx:MfRqaQd4ta15fGVKMttu2rRyHfxXOQ2EusHp3BkjbeK-VdvOWxkUzQ>
    <xmx:MfRqaSkZnYLLPvBasqV9b2RbiHU68ypVtKCh4KlMsdVxIGxHtjzCwg>
    <xmx:MfRqaSqaBACFyXVbEeiBXGBGH8TB6yKzTlb5HdIb8bYn_RZ3aar-nQ>
    <xmx:MfRqaR8RAU3Sdk6J2divnS1AK2TGSw8HBVJLUVxBMzEr3KFrLlG9dGSa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 21:30:08 -0500 (EST)
Date: Sat, 17 Jan 2026 10:30:06 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND 1/3] locking: add rwsem_is_write_locked(), update
 non-lockdep asserts
Message-ID: <aWr0LtTf1rU7iae8@tardis-2.local>
References: <cover.1768569863.git.lorenzo.stoakes@oracle.com>
 <8e343ccb9319433364f5949a69519f1bb521fc8a.1768569863.git.lorenzo.stoakes@oracle.com>
 <20260116151215.GH831050@noisy.programming.kicks-ass.net>
 <99818e30-9f88-4751-af82-0bed019156eb@lucifer.local>
 <20260116155743.AuMKcTAO@linutronix.de>
 <5ca7b2a2-1e9d-4d90-8459-1aa35b30b49c@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca7b2a2-1e9d-4d90-8459-1aa35b30b49c@lucifer.local>

On Fri, Jan 16, 2026 at 04:21:29PM +0000, Lorenzo Stoakes wrote:
> On Fri, Jan 16, 2026 at 04:57:43PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-01-16 15:50:24 [+0000], Lorenzo Stoakes wrote:
> > > No, but we need to be able to assert that one of two locks are held and we
> > > don't want the failure of one being held to cause an assert when the other
> > > isn't.
> >
> > But why don't you use the lockdep based check? That assert only ensures
> 
> Not sure what you mean, the checks I'm adding don't exist yet.
> 
> > that it is locked at the time you did the check. This does not mean you
> > are owner - it could be owned by another task which is unrelated to your
> > cause.
> 
> Yup I'm aware that lockdep tests more than a simple assert.
> 
> I wasn't aware this was possible with the lockdep primitives, mea culpa.
> 
> Also this came out of a previous discussion where I added a similar
> predicate vma_is_detached() and Suren suggested similar for the locks.
> 
> Anyway, I went and looked and yes I see there's lockdep_is_held() for
> instance.
> 
> However, I'd STILL need to do what I'm doing here to account for
> CONFIG_DEBUG_VM && !CONFIG_LOCKDEP configurations right?
> 

There is an idea about a light weight lockdep where we only remain
tracking the held locks in a per-task stack and skip the whole
dependency checking, that would provide lock holding
information without the full cost of LOCKDEP, but that requires some
work and I'm not sure whether it fulfills what you need for DEBUG_VM
tests (each task_struct would have some extra space and lock/unlock
would do extra book-keeping).

> So I'll respin later with if (IS_ENABLED(CONFIG_LOCKDEP)) ...
> And sprinkle with some lockdep_is_held() and see how that works.
> 

Yeah, for LOCKDEP=y cases, please do use lockdep_is_held() or
lockdep_is_held_type(), those would provide the accurate information.

> I mean rwsem_is_locked() is already specified, so naming is going to be a
> thing now but I guess:
> 
> static inline bool rwsem_is_locked_nolockdep(const struct rw_semaphore *sem)
> {
> 	return rw_base_is_locked(&sem->rwbase);
> }
> 
> static inline bool rwsem_is_locked(const struct rw_semaphore *sem)
> {
> 	if (IS_ENABLED(CONFIG_LOCKDEP))
> 		return lockdep_is_held(sem);
> 
> 	return rwsem_is_locked_nolockdep(sem);
> }
> 
> And obviously equivalent for the write case is what's necessary now right?
> 

Assuming we want CONFIG_LOCKDEP=n cases to work without extra
book-keeping, I think we could use rwsem_owner() for write cases, and
name the function as rwsem_is_write_held(), which tells you whether
the current thread is the owner of the write lock (we are lucky here
because rwsem is one of those locks remember their owners ;-)). This
would cover the use case of MM without introducing another is_locked()
function. Peter & Sebastian, how do you like (or not hate ;-)) that
idea?

Regards,
Boqun

> Or am I misunderstanding you?
> 
> >
> > Sebastian
> 
> Thanks, Lorenzo
