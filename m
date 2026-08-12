Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058232D43C
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522394; cv=none; b=Fe7qfsGqIBN05ZjdHvSr74yNnb+WKas2Uvs41pJ+IbBLbVlWOuCx7khwi3n2SyCrMBhUUh1pp4fIvLW6u9rZKQT44ZKWbJJVgu3YO2RJNNLXQnyh/B5JHq0mAxX5LYE2PSkuldwUCCtdX8x8Q6ebXaXv3vplu2d+V/yYYyDAsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522394; c=relaxed/simple;
	bh=LZfvAz1OdH+4vvnegdGNwqfqI7AlK1EZetVAI3vqD3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC8FuUt+P1sK0/EB10KiZ55F/hbVVwZNsRIf8iyWQAgXNpK9vn+G49Uvtnq4Js9LG2JjViVNnZyWWc2vcpP0uaQSWNV25YSP90IFsuuT/gdx1H4TbKPiA+ZaIsZ5wKjigTv/8jJvFiXIlqr33pohyJeEsoLgjl5sBZh9hqlez5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jhs33hbg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jhs33hbg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4957eefd361so4676015e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786522391; x=1787127191; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ul3j3WGcIwdB94lLOJYR7d/dt/sRRRqyC+QOYhiAFkk=;
        b=Jhs33hbgMowSQ8JAfW99kaTnqNOWOmAf2Lpqk0TpAjhwf7T1jCtBUeQSF1do6soq4h
         nM0BcPFZOG/BJjkcVMQa0gMbx2rryORVzAmer0DEnGihBRkw6mslijAbqwy8Kw/t+5fs
         nuuo/v80Mx0pYeL4pQUotTOzDqyKerNjAhnBdo2nuplMexRbp2K9u8wzSS5xDpx5YRfh
         LzJRZvxDe0A0JaaKjfCqqhVDp+2oPhYt/t0nMhxfmA9deS5gR3O8uefMEmZQA+/B4cER
         v8OqiFvt20OopoK57oxGO4HzNzFK3VQYwSW9qovineC6cVL5pCCc03rtpClblyBSEm3v
         eZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522391; x=1787127191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ul3j3WGcIwdB94lLOJYR7d/dt/sRRRqyC+QOYhiAFkk=;
        b=dp6o2G494M/XuA7tvzzIAvl1AytiYmUEquyUwTdJfX4onIG+OsmPioWq3krvn7ztk2
         sP6T+dSC65YuZulBZhT1szFe0oHQtI8ZPpP1xeQuZ6jWV3i9TrmCgKwPzAiUdF4clmRo
         Qn5kLUAgGXq7BlHoC2JKs2FuUJRwF9EyFeibNEtIJXsmfX+dijtxOGiEq0yoMWuJe6qK
         EmlC39fZgjhLcsTMeKVPtG2koFEfpFMKveA9Whs39k6XR7QoC3atZqAjUpaOXyLVXe3P
         0RJoBTHYECAsPth6P4//Y274TFHUyp3g1Smyo5OY+gZpl1XjtV2AR+jVPUYz2cz/z51v
         D1Fw==
X-Forwarded-Encrypted: i=1; AHgh+RrI3IwHX8JANwE0Tk8bW1lUq3w1hTb69sz/3haeEYM4SsxPZapdsBvQSfGVuXy/HmjpZl9Gd5gRkWmm55CufQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOiHt4FobKQs+jHd413XcEOgyalyOhha5XTVFpyyDFLzHT4Mt4
	z9yEmVdc7AakindMOXguoKQ/a9PpEAUE43hHNEhx3zrsdcYtvzSQzq+h9Shpn/wojUg=
X-Gm-Gg: AR+sD10Pcdp6jD/xjGgWsrG8XlR5QFWQMPBOd3Egc1CAkDWRY4luLLmvbr6eAKpDFR/
	Ci0XtG8IMlG+LuaTUa/IQAxaNHNGaM5tFM/xXF88cLshnxbSNo17CgmBNtDZVYeUIkaBErNojED
	LOxu3XzMqQT8yJTG6Ls8WO1pxHnT2ZHa4U7Sn8V/Pba3r9n0GfAgielCu4mbqzHuYkVuW+W/Bg5
	h3k+OCsFNSUQ61pYyGxTDHAOQx6uvadLqE/rCnqhEpi72Nka1ptytLOVev+qU9guboQbr4ygEE5
	czt9xOSLZhQixz2f9VnBxUEmY/rs+NX26ZkD1PxCXr2eyHah0CBxFqntX1REWmQsbCZFZ/EMPq1
	eq9QPnhv0nrknsfcs4eLPfvJe7xSt6BKTvvBuW9Kp6WGoWN1v+mTaqv5020VeS/EIRYjTtO1QHH
	r7GYqtHmErnxD9/2CVeBOASJeZRqSLa7xO58vEK8cKj2cjXZQDFEeCNIoxC5S8fS6VFyzZ9d4=
X-Received: by 2002:a05:600c:524c:b0:499:7410:545 with SMTP id 5b1f17b1804b1-4997c145066mr36029645e9.12.1786522390781;
        Wed, 12 Aug 2026 01:13:10 -0700 (PDT)
Received: from localhost (109-81-23-83.rct.o2.cz. [109.81.23.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b237ab6sm26020375e9.0.2026.08.12.01.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:13:10 -0700 (PDT)
Date: Wed, 12 Aug 2026 10:13:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <anwrFZEKcW8bPJTY@tiehlicka>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811104229.72fdd928@gandalf.local.home>

On Tue 11-08-26 10:42:29, Steven Rostedt wrote:
> On Tue, 11 Aug 2026 15:33:18 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > > If might_sleep doesn't work sanely at all in preempt_rt then just
> > > globally turn it off?  
> > 
> > Turn might_sleep off? Or PREEMPT_RT? :)
> > 
> > The RT maintainers are on this thread if you want to pick either of
> > those fights... that was not the course of action I chose to take.
> 
> I guess the question is, what exactly is the reason for sleeping to be
> prohibited? In RT, sleeping is allowed in most context because most context
> are threads (like interrupt handlers and such). Now, you still can't sleep
> in NMIs and hard interrupt handlers that were not converted to threads, but
> I'm not sure that's the case here anyway.
> 
> If the non_block_start() is just a big hammer to make sure things are fine
> in non-RT, it will likely still be fine in RT even though it may block and
> sleep. But what it blocks on are sleeping spin locks that likely would not
> cause an issue here if they didn't cause an issue in non-RT.

Yes, this makes a lot of sense to me. While it is not really great that
the oom_repaer gets blocked by a RT sleeping lock because it delays the
whole operation this shouldn't break the "do not make any direct or
indirect dependency to MM" assumption as those locks are normally
spinlocks so there is no way to depend on blockable allocations.

So the warning is mostly a false positive on RT configs and what you
propose below makes sense.

> 
> Thus, perhaps something like this:
> 
>  		if (ops->invalidate_range_start) {
>  			int _ret;
>  
> 			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !mmu_notifier_range_blockable(range))
> 				non_block_start();
>  			_ret = ops->invalidate_range_start(subscription, range);
> 			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !mmu_notifier_range_blockable(range))
> 				non_block_end();
> 
> ?

-- 
Michal Hocko
SUSE Labs
