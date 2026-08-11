Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33173C455C
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465467; cv=none; b=QUBR9B4Wn59NlleWahmU7vVBc7AnHFOnLlLO9fhN1ro6v6SIB3+Iud8Pmokh4X8Mroog8OV6zpL8M2TnlhBcRxw4shxWRxChMLmpHTaOjQ0Jb35Bm7febS2Uz0/G8lfF5xqsLwCxjIxNHb9HJNXs4m/+VWTx344shkvh8FTovtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465467; c=relaxed/simple;
	bh=HwC3T/puzehhf8bSut7phAm1yYtmjq0Oh6XDbBl2A68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlpBf2Xsx8Qi62dyuhpTc8zK6eE6gSr41TsrCPxJsPE8yuxBxArWlgO50Nbs6XDSTnW+z23IKpwRHUZEMsEcGFS/t/Y/m/b8gkCZX0SsJT5b/zE+OKY1wMi9c8xZM8WMx9+ZMOUWiB0RCP9aOhiB4ebpI4K7P1xMKVpxol66uKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xx4C5trx; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xx4C5trx"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9063b380982so180216d6.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786465465; x=1787070265; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ge2DKXL/0cigzsh3KdWGGLhQNvufZEJOXUsvNTDWwxU=;
        b=Xx4C5trx1WiOdFm07O6yHc+VFLVoW6+exKhxHtqvmVAUVkHZNvfjB6hDZgfokfc6w6
         pQ5FUPjCuoVJMhmWdj/ftSYLfe1bPVSkUA8NtW7OocFgugNPVLgA1Xmw1DZ29EaMzFaX
         PEDB2CaAl0c8uI+hsPpYD6/M4FOWVhQQEkm7PbKQBZ2RA/Mi/edq8vrc27fnIESN0sZt
         sfS3hENhDs7LvXB9UwwgHf5/05taZm5O0MrR3cuPygFcDAfCQubMl6G5oImckTMiY5jP
         IpEynTgi6v2jqrH6RctYfifxUpIyzb3t6mgWKEUM7NlzRGs4ThV1TE8wFc1Jz608wbmb
         EMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465465; x=1787070265;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ge2DKXL/0cigzsh3KdWGGLhQNvufZEJOXUsvNTDWwxU=;
        b=ShVudbchrLVLJjk9ox90cquBZ0ArvpRe9y2BrcuIklotr7uM1BANbwIlK3TwVWnwWp
         gKpAvR0p07uqIFSB/Nlxg42xlOiKjZQVYIsW+riPPI/pH75/e5cHXBVcPwPvfYgWKHtV
         yHiPgIHqVFljuNiCgQ/1rVY7fyHQvEPntJDCve6Rco2bDHZ87K73sXe+ZNGmtJgESzXH
         4QdBijwQ/I/I80/pywZSP67JMS8zC0GYuXDJe89WE6pDhQfNtpMuwgyE+rLMQCz2BqHC
         EiOVyWdFWU5JheLLMRmvG7N0m6dfc+AD9QxCXk17ZhtSEQhOoqQ5bXHa/hyOutG6kbpC
         ZJRg==
X-Forwarded-Encrypted: i=1; AHgh+RqYfPEg6BDXHEOk+LAg5WhHfU+WnuTX4hH1pBQr2WSgc7vxJVBLOJ+MjnUxyTSrYSBE+U5eV7Uj2orkULx1Ug==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgCZCNEnL2fkZz6aCDArbxTDZeOuVVXSL4k9z4PaIkHyV7quFv
	rdGcB1b+0sg77EO6utJTir7NZMFw5Lmrq/RdFmsZNeTOvE+l+9dZjLuDuphvm3m0/Nk=
X-Gm-Gg: AR+sD10CuXE0R/p5AQB5cyqqY4H7aU8ShTQFMrG92/8gLdbHI9Tv44Xa+TjbvWmvTXu
	DD992+WRmw7IRP0dsp6r9MAe/cH6XqjGON2o8tiPwzX+qj3skwb9cATemvXTKvCXAtKqN3U2eKy
	BVQzp3GXsiD1d0K1ZwQHYEzq6iZDfhBNz0wdslBpKRXOW3DUxlmuXdiqvk+Vpibz6eeQFxy7mBc
	CWLywOB8DyGeb1/VerLX8fbrsZKxJMrg18AzrSMKcGXai1UAaN0zL2wVU8PIb368SlXJHBzvsKJ
	8S1l5Ebvnjo8deyOEJG1nOQb+X/fxpaf8IfshgQnnzEGc4gpXkFsIt1dE5748IwwTnKEEM3SaL4
	MdHN5q/bgT+24r2fkz99eynqeTiEuJQ0hHi5ptVARtA2MzDH7i4CYd/i3cI5KlVEnQ/GnGGWNpc
	1mQSJGkXe/na3LT6mtky0rKPRaMsgAULk907DkocB/AYvf3UNs
X-Received: by 2002:a05:6214:5d81:b0:8ef:ea2a:2728 with SMTP id 6a1803df08f44-90a66df2c02mr43379816d6.19.1786465464725;
        Tue, 11 Aug 2026 09:24:24 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3c38c4sm2442696d6.36.2026.08.11.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:24:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtpH5-00000002YAS-0rLs;
	Tue, 11 Aug 2026 13:24:23 -0300
Date: Tue, 11 Aug 2026 13:24:23 -0300
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
Message-ID: <20260811162423.GL544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <15a7bd252a9aaeefe393f5609ec383ce2c61694a.camel@infradead.org>
 <20260811152435.GH544626@ziepe.ca>
 <eac6f58590798a0bd96573d0ab15e0700937ec1d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eac6f58590798a0bd96573d0ab15e0700937ec1d.camel@infradead.org>

On Tue, Aug 11, 2026 at 04:29:55PM +0100, David Woodhouse wrote:
> On Tue, 2026-08-11 at 12:24 -0300, Jason Gunthorpe wrote:
> > It is documented to be like this, even if it is hard to test..
> 
> So don't change your documentation :)
> 
> > Even for normal blocking notifiers you should not be using
> > synchronize_rcu().
> 
> This is SRCU not RCU, and the read-side sections are converted from
> rwlocks and never had any allocations inside them anyway.

To be clear you should not be using any synchronize_[s]rcu() primitive
inside the invalidation callbacks. These are well known to have
multi-second delays on loaded systems which are a completely
inappropriate performance characteristic for these mm callbacks.

This statement has nothing to do with deadlock.

RCU is always a trade off, you can make the read side run really fast
and the write side is ghastly slow. If you can't handle the slow write
you shouldn't use RCU techniques.

Jason
