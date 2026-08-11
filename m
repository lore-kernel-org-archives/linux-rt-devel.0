Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380D37B40A
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472359; cv=none; b=a37Ra8GLmUI7G1n4+0zxY7PlTd6PzGQOyU1govp+LFfjrTlOe6cfaZaOKaCNHT82ZFp6idv4N2/Y63ATYZ8/uNTl5NnY6LEGmWs9WIP9pR2BFWYs5sB3zbXmJz7YAFWLdnQaVdv3IIkLJhryTgwiwegCpxodr5fVOC2m7QKBrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472359; c=relaxed/simple;
	bh=q9Epwa7qAc+1FtYECVkBZAqgd+xV7L2totBuG3xJDSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhUJX7fbBeweefyKhJXDcrKJvIG8PqXH5gkfUfYE+tswiyxzRljZQ3hX1sysbuj+ZDhB2UyLW77JlIVXxMQoZo1ciOjvYqRS2980FRWMY7uaATaDN1nAP4vU+EtzF7NOMKAGpB151OZM7jA/Q3u6iKsZnoOh/QvOPcUcPefLpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zuqm4FiW; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zuqm4FiW"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so1066086d6.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786472357; x=1787077157; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Juoz6itPiwLzS63SjvZr3Uz5ivFoN4JzwWEODeoXz4=;
        b=Zuqm4FiWlJgJr7uw+FhUDMber4KpwgSpiKgh00QCuwIigSrHvXV//qXuOq8uq+oPHH
         ore7ChdfaA0lec4KUSTky0z5ga1zo6jSWQO9Tscrnxxa3S02NjuAklheWPbuRP8rzbiy
         RixftOpG5zTwMv+BKGboOyl6HIpTtDlAJ8bmhZk3Jld01P5PAe8sexnrEfVBiIndzlNQ
         NZrz+8SU3bEW70hkm7oIlC2ns0Y5dvnFbLt/4AMlPbDKPfpixVoocgrsO5bPSi5mFRXN
         OaC/PUb9bwcKt41zHIOsgfibASAJ9lobh/SnfmihSvAkK4TnEztqRiB37HM2SdqT3SKr
         I3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786472357; x=1787077157;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Juoz6itPiwLzS63SjvZr3Uz5ivFoN4JzwWEODeoXz4=;
        b=VdtpcFSXB/otBqt6a3wXza3A4XDT9SxCb1CS9oPCnPpm6CpSdhh7BR5hj7kPU3jG4i
         aVI2KcINDf7KNiJ5zGLLHc2pBbiHktqeQprH1k5WbqrcQvwJtDrDl6oZMzeKeLY4oFlk
         gG1+P5z5MocGJiLFpH4RYOKFMCruhY0+GBKwo5ooCJIF4dbPfkLyGJUCRlk11WfmtQhb
         z2Y9jXoORjZsnPMdsU8UHc9QyHLlYaegAQrkFhE7HzLlf7K5JUIxnjk8fBqQ+qvf+XJs
         aZpWZMZFOdtOLdV/UxOhFgevbS7jNW3PKyDIXahrHJ5o1Wm0KsJELVYez2fUBTTjZfc3
         b86Q==
X-Forwarded-Encrypted: i=1; AHgh+RrGERWOm6qiRdnafMvQoG8BewIv0eWp6EHP77KRM9kWdeGide6Yo7dURTpV1BPUaiWBVNXCj8Zy4AbAnRrh1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBjiDdrhCOq+vc9uVSsBb3nYw+tMk+gzGEjWII5ZxqbznofZL7
	i1rsgRxKSRsLvksDLGnOILmLOFupjglINi0uKDNbbP5bgoU20Ye8Sy6Ou2QUF+fVIt0=
X-Gm-Gg: AR+sD10Qi1x48ltbbMNnEp5Q+eMrHbbGe7l5CzCejw9GiHjzTl+5/Ec2rsChi2P7pw4
	Gf1AX5S47ijEs6PO77Y2Uug6k4fTGYFBa8endDQnS57pvf7QbzKlCPhj8dRv/IsXr/I0LhsYZck
	hZ8SZrgp4a/uEWftc/9UFsrQ+cKIcSNfybLPkPB8lb24L0aCHPdXK7Jt8u5/uOv95/J6JNKbsM2
	levrNQ1F0AOE4q4PZCoFwul+ZfPLHDCBH/m27iqNVEegz90ek8Z0m3TCTUm0zZSz7csLdh2a+Ek
	WnHjKK2gFMLQ3DC8A8gcraPdidVLuz7Ay2t6sjg1LAF2DWWW0aGRzZIdXB+c6Ihw2CMA64Lr3/I
	xL8Hz/kTFNVU6PSLjURd+AVTPzfQqi/UZcnyUyK9PqM5joAoBpB246023jFJuns63DlI7AJTWiu
	Vb8qNBK2WyoGRe5UEUITbs/d58oKyJAolHKBi99j4Tdg+zMoU8
X-Received: by 2002:a05:6214:e4a:b0:908:958f:4db with SMTP id 6a1803df08f44-90a66922571mr43184126d6.3.1786472356695;
        Tue, 11 Aug 2026 11:19:16 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c395bc2sm4671866d6.30.2026.08.11.11.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 11:19:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtr4F-00000002kR7-20cJ;
	Tue, 11 Aug 2026 15:19:15 -0300
Date: Tue, 11 Aug 2026 15:19:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: akpm@linux-foundation.org, david@kernel.org, mhocko@suse.com,
	rostedt@goodmis.org, bigeasy@linutronix.de, simona.vetter@ffwll.ch,
	jglisse@redhat.com, christian.koenig@amd.com, paulmck@kernel.org,
	seanjc@google.com, pbonzini@redhat.com, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260811181915.GO544626@ziepe.ca>
References: <20260811162423.GL544626@ziepe.ca>
 <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>
 <20260811172627.GN544626@ziepe.ca>
 <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>

On Tue, Aug 11, 2026 at 06:59:24PM +0100, David Woodhouse wrote:
> On 11 August 2026 18:26:27 BST, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >On Tue, Aug 11, 2026 at 06:22:12PM +0100, David Woodhouse wrote:
> >> On Tue, 2026-08-11 at 13:24 -0300, Jason Gunthorpe wrote:
> >> > To be clear you should not be using any synchronize_[s]rcu() primitive
> >> > inside the invalidation callbacks. These are well known to have
> >> > multi-second delays on loaded systems which are a completely
> >> > inappropriate performance characteristic for these mm callbacks.
> >> > 
> >> > This statement has nothing to do with deadlock.
> >> > 
> >> > RCU is always a trade off, you can make the read side run really fast
> >> > and the write side is ghastly slow. If you can't handle the slow write
> >> > you shouldn't use RCU techniques.
> >> 
> >> The multi-second horror stories are about the *global* RCU/SRCU
> >> domains, where the grace period has to wait out arbitrary readers all
> >> over the kernel.
> >> 
> >> This is not that. It is a dedicated srcu_struct, private to one VM,
> >> and its entire reader population is a handful of KVM fast paths that
> >> until now were under irqsave rwlocks.
> >
> >Are you sure? I've never heard that srcu has those kinds of properties.
> >
> >If its so fast you should just propose a non-sleeping version and
> >leave the notifiers out of it
>
> I've got torture tests running for correctness on the GPC RCU
> conversion. I'll throw in some metrics on how often even in that
> pathological case we hit the wait case, and how long it actually
> takes.

Well, to hit the bad RCU cases you need to usually do some other
workload too..

I guess srcu does have some meaningful functional differences, but it
is hardly guaranteed to be fast or non-sleeping out of the box.

I guess you are making an arugment that if SRCU critical sections are
atomic themselves then the synchronize could also reasonably be
atomic. That seems plausible, and may be worth some additional API
surface on the SRCU side to expose this use model and drop the might
sleep that is causing the trouble.

Some sort of "atomic RCU" that has a slower reader but a faster atomic
writer.

I'm much happier to see a formal API under the notifiers that has
strong properties of being reasonable than KVM using SRCU in a way
that just happens to do that by accident, under the current
implementation..

Jason
