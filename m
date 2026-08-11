Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F633DEC8
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461880; cv=none; b=cwBma0+wB8dKoV7HK4ym8O6LIn6yIeiXxZCIaDRvZiQ2C/85urftXv8F3P4FQDUw3+K+IDe2EYEUp73LBKbDkzcxcrvCtZFX34/wbsNwzxD/SNDYfcFgztgngaEYSvgv63etEP8l0Q5l4kohrCO5IxMZmTscTGdgsoTHST3YCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461880; c=relaxed/simple;
	bh=UlhJrx4cD0iyVN15M9xGt+ngtuV5yPj/OQO+zrMn8bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9g+A4YlsMP4L7FjsLzpqq5UVksg7z1hjn0/LcUHj8jmslib0OijJQec/0BBXp7jhJXy+++2KgkGbDfVeCOE19qdTdquj5mTLOmhkdR1AtLnO8A0vKmkRIDOg0FECIHg6C645B88P5jrP5wbGKmrmIgIxzz090q8fEedSQa97P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g8MFIBcm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g8MFIBcm"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e85499ffbso3819285a.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786461878; x=1787066678; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GJpznJoS0l7uzYWTFF1MoJR9UykE3LUYDEr5DpChX2M=;
        b=g8MFIBcmSnzshWxx+aYeQyG/7XZ+ZfhvP6pqS5n7C9/5KRdb3/uCHruyjEJyF9Qcub
         wLPfCRgO71S7JCc6Ex/0ozi/7bFf2M+sDrIWM8sqbqzemv3JmLrTJ2ng1eXlinnVihUe
         6DdJK6J5+tcP9BmOyrTz0dQIBgVjsbEF6+/2O4TUkzaaCEPLeOY4ZZ449Z0eCXWRIFxN
         tWnMWVjTksLl1mZaDnHRB+0eoOlsfJBFps450zsxX9tvjd6AM0FtSu6xkF6gC6T32XIc
         qyC5kxoJlJ/RMQILRqHH9c8NVadDiDAkmEqeFf0qLhCBMI2NFzdamuzs2KnZgLAzBUg4
         k8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461878; x=1787066678;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJpznJoS0l7uzYWTFF1MoJR9UykE3LUYDEr5DpChX2M=;
        b=GCEWVqAOYBhRsCp9VQPxXIZnvr7e+RPHPaUa16hvtSByJEP+EeLRwPKdvnJB2Qub6v
         kEX6RGpR8G6XihREOZk5s4qclFYBbyPgohjdOFSzTFoG7I2L4GVasRb4QtWGJOQ06t2+
         Ud/k/er3/oWqwYQjN2wepwloouBB6JLq7y4Xey1UklKQrUzgFi02RS3QgYIEg9jxE2rt
         v2Twlq6EO8g9j9ZGnB7JwyY5f1Kl40ZW55+cJIC+2nNgsJrKKVCsztEAkVRwO/R7fvi3
         PGuTslZ+ptD5+gLqTCGx5phuQFrlAFQ4m4DdCT4Lopyc0bqaEk1yREnLoAFo03nkvSM9
         XriA==
X-Forwarded-Encrypted: i=1; AHgh+RrZ7QFJjSBjbqAp4ghlC1Ocucpx3EZRk0RgeBLN9pKZ/f44Ms49z81dTdA1AvBg0XxMLVMxSsGjgcE8Daoj/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHeR0IZH77SO4+Qh9QhgTe1shVEp/Ko+85P4nUl1xVL5pQSUj3
	KHxtTFOk0UG51o+pM9pq+UCCeT7WyHQdmbVxbYnWfCz6NRPO6e5lUD10XwMK9J/uUSM=
X-Gm-Gg: AR+sD102pN+iMAl6YUfiV3LzwH9YJOuSzO9ksW08ycE7+/Li4O5eyJ85m82VdokQYO2
	M3byT9I9QCG6LwL/uJEzMtbAYE+wD9b/oxt8mDr+WdrvQz7KKKbxbEr+KjRqlMm/5Gwr2Sf9/vR
	p3YfN3nGE1GTXS/SPRd7rKG2k041Jkx5uGuyyYAmURK3pYRBQ+c/1d/2dGndhXC58nvkGZD4ooo
	hVyjcpx/uhK4P3sUSVYRj47L24yKKYXqjXqTMNkiwzrkRC/UHBntUhpBgA5UtH2XV3MqLcPU0TR
	RHiQEa3lXVVtXhH/6ApIVnXA+SUphvkOC9/9hVdrSjuaQ16CRp52hnXytEI4ex8IKDW4GB2F66m
	749k3ThsrE3DXy+DmtVhdzQb33zRZaFW4nTm3KoKXGlbwDfzUXpq93X/8WbePqEd3gFSd68Dxbg
	kVjIQ6JNdbRyDWHYhtoIAWINPkTZr1L2+USGoMNA==
X-Received: by 2002:a05:620a:c50:b0:936:48f2:b04f with SMTP id af79cd13be357-936a8e5f5ecmr330842085a.6.1786461877528;
        Tue, 11 Aug 2026 08:24:37 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936a8472ed4sm132935485a.9.2026.08.11.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:24:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtoLD-00000002WyE-1V0l;
	Tue, 11 Aug 2026 12:24:35 -0300
Date: Tue, 11 Aug 2026 12:24:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260811152435.GH544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <15a7bd252a9aaeefe393f5609ec383ce2c61694a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a7bd252a9aaeefe393f5609ec383ce2c61694a.camel@infradead.org>

On Tue, Aug 11, 2026 at 04:15:36PM +0100, David Woodhouse wrote:
> On Tue, 2026-08-11 at 11:27 -0300, Jason Gunthorpe wrote:
> > 
> > The unstated secondary purprose of the atomic context is to force the
> > driver implementors to make sane choices that don't degrade the MM
> > spectacularly.
> 
> You realise it only does this is in the OOM handler context when the
> normal death of the process takes too long, and I literally had to hack
> the kernel to even get the splat to trigger in the first place, right?
> 
> I don't think it's keeping your driver authors honest... :)

It is documented to be like this, even if it is hard to test..

Even for normal blocking notifiers you should not be using
synchronize_rcu().

Jason
