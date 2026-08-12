Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5C37E5C4
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522477; cv=none; b=aQ7FdNxLh1HKCwazL9OLy6LGjye58hKceTO8FFYy6f8bAv53TjxPo+XsHSd7JDYCX8YYOKVnKUI2JvgSn1LGg13TTXznNN1jp2gCogYtsFsKgzdsDr6zVK72DaXCcUHYTBb0nC3aaIJzAOkjDvolRmQ0mo3mYdEduwbCxY2ULyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522477; c=relaxed/simple;
	bh=h3hwx/tgdyFk6zQbEwHiApdsA3w21aWE9i24GWMIjNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHdb9KoAxFnT0B80jKiFcp8asecDDpqQE5fmoRicVmrW2hyhB2pab5obaCrgagmLs3gRS4wqQ5Se3SIdKY6RWVmkuNF34ZyUiJsiYeFUqwNYatQ1Fi4D2Z/YjwP1BZS8Aw4y4iiGbPjj98hhegXyswoK+6V2z79Sd/5gbNCw+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gtrDYHLr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gtrDYHLr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so519139f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786522474; x=1787127274; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cm73Go05IhY67+bcf6pjgSkL6qSZACbfB1rQ4knSZqE=;
        b=gtrDYHLrUgIOJjvESRghURx45/uxEouWrMitGmoFEh7AO/KqgaY4e/TTh8AqHPU2bz
         g6kQeLbt4oJupMhT1xN/8CEb1+buHXvendHhHKssDVhp+WSmyabzHawQoj1Dvs4MzWfM
         25Iu6htAFfvMkwRz3Dx4YXsdkbIJEwPAP3HfPouiQgWa4FjmJLMdkvzL8mcKbY7JvK3r
         8XRw7xrsZaRW/HL3bFL05odUQvsQiTC6h6TmPn7RJOiz/ltAMeddKJE4M70S437Rzhpy
         LPqcEYuD36gNdLApU2eBfn32MR71mTEe8xYiS/rRCJr2u1dZwg/NFbm9XS5z1usbrAv3
         m/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522474; x=1787127274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cm73Go05IhY67+bcf6pjgSkL6qSZACbfB1rQ4knSZqE=;
        b=Z3lL9VdzIR3IDgSGiJdxfwAZYLNzBw6MxgrgRVmP1H3man8lemxPktGEfkvxh0OfEX
         tpH5nIslTx9XY54jrAkNOLG2VecRoS1DofW3vKjrPDpwM9P2EDNoO/lZB6yswB9Q1LVP
         +byEJ4BcpozDfNew8Y8Mu3i3qN4AJoca4xCB45uJCt24GsuYdbR7U4bi4/6sYxHPa6za
         HVw6NqmEF0LC24n4+aAISqh1SjsjNjpJgx7YLP+IwVF2iofQW2jt/k5P6nNWD4RmADB2
         zwJ/JBqi5rENn3e+stre4Yjf3nCKFY2rB1kAW9BR6U2iK8a3kvWdwrP2zOqlDb4trXQz
         r39A==
X-Forwarded-Encrypted: i=1; AHgh+Rqot5dzcFAB/YwIVNvvLLcjNVJz+kSOUer43YojmPZETqKYDWAwPYereafqHEWkWx/YW/jQmeBq2UzF6ALSkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywm6jMZvWcDLpVrdE5WvbNn5BHz42m+8+zXARb6zITwhkLovHZv
	XF3vdZ069uKH3dN0aoWqBbfaKcyXaGXR/AXd+V7g8zjRngh1oGIzJpFu6LVoEUdTjvc=
X-Gm-Gg: AR+sD12gGwEdrBakKpwUQJnpWzwCh0RY2gEitczvGhGF26XZ+FKIWKOVqd2NOScQ52r
	eWIG/UEiN7g4q/AnLlEBF/IsKZm+TcygAZ03jgLWGiUuID47cRV6SCk5eSAkVrgxl2XNMYycWD+
	KB9o5HSnFgCD+sUhuKmEozbyvDcxKIQzUcXxTzCu+hhlsJftp+OBY7mLcyC1fSQGr7hvSt7uWma
	/k88b98KIROqDzjxHBCtM7gTW1XuVRVvtCxLQPM8B+3h/xlNrl4ZaG0H4oxwo4i5TwKXl12kIz+
	odC85aQSdUbthvqol45sITD+shvAfEat8wccaKWD6CFSvaR4ErnAFPMMtAuB6HeYw3PNDuzgUpK
	hyrh/y3Uj7G8Bpfgenz9Y4RzpfyWJQAGXkz5rln2iU8g0RurOaAM4UeLXDapd9JHaLJQWFDSDw9
	Vczni9x9XfrPOMSh6xPQh9oRC3GWTa/baWfftX+xPhe20Bp6257riAD2HybVV+5URZoJmvRiI=
X-Received: by 2002:a05:6000:4607:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-48152775015mr4164525f8f.0.1786522474169;
        Wed, 12 Aug 2026 01:14:34 -0700 (PDT)
Received: from localhost (109-81-23-83.rct.o2.cz. [109.81.23.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150bf5f0esm4963432f8f.4.2026.08.12.01.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:14:33 -0700 (PDT)
Date: Wed, 12 Aug 2026 10:14:32 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <anwraNIKJV8zwrNT@tiehlicka>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
 <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>

On Tue 11-08-26 16:24:48, David Woodhouse wrote:
[...]
> I had a second reason for disabling the overzealous check too: to allow
> SRCU grace periods within the notifier callbacks.

Is there a way that srcu barrier could cause an indirect dependency on
memory allocation? In other words what might block the scru to complete?

-- 
Michal Hocko
SUSE Labs
