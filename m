Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E3314D06
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458456; cv=none; b=DqrlKQX7Si+nZytYgTRE2XgmD6uQdL59n9HdTR4XAm7O0uZMvrYPuqget8M2dkgYfJokkFLjLQhGlJ2s9zh++Gez4qIDA41B9W70WSEMHQFeYKfrnL5TQ4zOu7dl2TlX1e6qwE5wfKZypThwnOLtA0tu39d+s5krTlYFTAIz5CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458456; c=relaxed/simple;
	bh=S1MnOpajZIuRKJeZjsd/WdRxI/oF2ocNH/aJeyBhuMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhPJwriWGRZX4EkhUZgnSPLfbia5RBbEKUJphmeWkNt6UCwEkycUx/uK2l8IfUQhT4UnCfxwK5Af+yuiyffD71nNpQ6Z23ArBVMfkZTa5Devi9QjHl0APAI4k0fj1j0Ji/ksdbAwTYK8uXb6pE3MeDe1F+Pn90rli+EpDjiqtNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hMpMZeqq; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hMpMZeqq"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92f0b5ed131so233989785a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786458454; x=1787063254; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yGh0jdU9hH3pMDac+rBHolUofOnAZc4NvBka4kqdBBE=;
        b=hMpMZeqqauTwyH6PIPJcFm0WH2aLvlgiHYAcf+mJo48pUx3kXMDarcPEh1RcgFcDVW
         VSlrTxqhm6OCAxMqGH41yx3sFpC64DF8SMKcLX5rydsLvsU1MVAbJDFdQbE9ltZ1yFUS
         KsOVxX6SM8KLoR9UkJw56762kok3A9r9LrSPAJPKHrxQZUW7Ccqutghmwww1xAb3VqkY
         WHh7apttpPihpiSkq5+lZBzDkd8HVXqVnFheXousOYCxJcbnOpOlUdsM1ETfKVFuvaX3
         9jGAMvrZ1x3e7/L5K0iRKXkU5AsEf6iHsGQY/p8pNCq/N2HCbNLfWbClCmjURWz3OX12
         X+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458454; x=1787063254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yGh0jdU9hH3pMDac+rBHolUofOnAZc4NvBka4kqdBBE=;
        b=moU6X2/cLQRgMwSnBMKYkJaltNhOVg5kCQB/eW2LbPOipvqCnQhpu6rbD4N04+wNSm
         1TI8n50qq9LUUh/fJn3tglgSqPT2eVZRGrVioakPtgZgf6kSi2+lGC0ZW89axStCWDii
         6U7k0BI91593aEUHdv6lx+YPumHKXNYPDtIDzeKIk830o+HhD+7L0GayLka2yza1DzN0
         8dPLpiqEXoyi0sTSDWTMnNCvzQqzupkFCl0lBhM6v2DTf/k1wxQ7j3MrP6hG95U+Bjf7
         O/SdcpQERiU5h9lCUuvhwBRj34/fHnR1fW68Nt7PDf9ZPnicXpSs9PXAMtP6YISKqo+a
         srOg==
X-Forwarded-Encrypted: i=1; AHgh+Rox1ez1gYSfZAB7GXOBG1FhEF7kueB9qAoTnky2qxxO5ffo2cwowzmhItC5EIclIIkzvArlEM9Qg1mmNz4n3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNqYGml2UgmIP8CwMn1wRZH3VR1fnjQzd2WBdbYtoyp3MmRZYT
	1ah/zalnTr5yDEPQoUjV6RnUQKcYsJz6vXjMcpX/27DFPhmAiOKXQUjR4a5CoW9/1m4=
X-Gm-Gg: AR+sD10YDHHsya0uqT2gUygv10ibwDhKYX1voXxAxCLK1rlrKuDeg07DWDJA0wHRrF0
	9tJlxyIIufH4RPN6fwIOyZtMR7Zpp/Nk83MVwPLyhI0lGc4KCPiOLVzhN5sL6vyxg/bezjHd1wx
	bxO4mjAuTfqEmfRVje8OSpPDgGigLYxXgUUlnmC6/1BxRYCUPEetxPQYdJhv/60HWSpt8k3LcOM
	8sL0O8i7WpfYYeM2/mloOAc+tCsOdT88qdNlSwU1x/d3W+raee8OupeZT/+zZ3/itPSWY8gBpgf
	JlwBFMjPj5eSVSZV1RPrCOWhriRQh9rWvejrayw+DSAiotHbMcVjAAivLsHiOxoZWE+pdNhgVqO
	O1Nh0LzM3CRGNFakQVFGvHFO+CxN2sUmkYY4W4Ha5icXeHvKEOaKSWsLgobDDd/Rr6AK768P9iD
	Fqb6Eo7ozb1fVnYvxZlt7k/QZpmzc/McO9FT+ZxQ==
X-Received: by 2002:a05:620a:4549:b0:914:bd27:2d1 with SMTP id af79cd13be357-936a8edb650mr322022485a.11.1786458453669;
        Tue, 11 Aug 2026 07:27:33 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936a849ed87sm122584685a.15.2026.08.11.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:27:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtnRy-00000002VR0-3Mpe;
	Tue, 11 Aug 2026 11:27:30 -0300
Date: Tue, 11 Aug 2026 11:27:30 -0300
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
Message-ID: <20260811142730.GG544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>

On Tue, Aug 11, 2026 at 03:21:35PM +0100, David Woodhouse wrote:
> > >  - On PREEMPT_RT, spinning locks become sleeping locks, and perfectly
> > >    legitimate spinlock/rwlock usage in notifier implementations (e.g.
> > >    KVM's mn_invalidate_lock and gfn_to_pfn_cache locks) triggers the
> > >    splat despite having no allocator dependency whatsoever. This is
> > >    reproducible today on a PREEMPT_RT kernel: KVM takes
> > >    kvm->mn_invalidate_lock in kvm_mmu_notifier_invalidate_range_start(),
> > >    and if the OOM reaper reaps a KVM process the result is a "BUG:
> > >    sleeping function called from invalid context" from
> > >    rt_spin_lock().
> > 
> > I don't know anything about PREEEMPT_RT, but this seems like an issue
> > with RT if a traditionally atomic safe functions are now triggering
> > might sleep failures?
> 
> I can sympathise with that point of view. In fact I've spent the last
> couple of years mostly ignoring this "problem" and just blaming RT for
> doing exactly that, but I don't think we can really get away with it
> any more.
> 
> cf. https://lore.kernel.org/all/787aa26cf62dfd361eea8ed19f384fc517892501.camel@infradead.org/

If might_sleep doesn't work sanely at all in preempt_rt then just
globally turn it off?

> > >  - A notifier implementation may legitimately need to wait for an RCU
> > >    grace period before allowing the caller to proceed with unmapping
> > 
> > That's not allowed. We really want to forbid that, it is not an
> > acceptable way to implement a driver using these APIs due to
> > performance.
> 
> Speak for yourself. For the KVM gfn-to-pfn-cache the performance scales
> *much* better with RCU than with explicit locking:
> https://lore.kernel.org/all/8f41cb82b7c99d5a3d1dda016e4841326b4d8a52.camel@infradead.org/

At the cost of completely destroying the mm shootdown performance with
1s RCU grace period waits every mm operation. No thanks.

The unstated secondary purprose of the atomic context is to force the
driver implementors to make sane choices that don't degrade the MM
spectacularly.

> Perhaps we could find a way to push down an *accurate* sanity check
> into the code paths where what you say is *true*? I guess it could be
> done with a flag on each notifier? Or *into* the notifier callback
> function(s)?

I think it is right and correct the way it is.

Jason
