Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213945D5FC
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542578; cv=none; b=cB6H75vHJ9xmGX+JANC0y0KL7mLVfaOfNCS9qRv8Urm3fqKpt1l49Nv11Jc9Kv0imkmF9ZX0tE4NfaL3hTbw6lcenzKrH3eHTvwNfaDWU5bkNUTDhRwO3u6fZ9Jv5mVdjzIQZy7QNtuklErrOF0s0Exx0mMfcacWMMeUJ4cblhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542578; c=relaxed/simple;
	bh=LvwifihpyQl04XWVsmiC/g59oClWiM8qKJQT0nS9CgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncRMesJkwAhrlapfywG5l+h2Qm1H4BqRlvKwdyAP01JO8+RcOyfS3yyDh4rZPOhTBKas9jm4Vl6HPyuD1ZVGac+fRYL3Nf1LSq/9a4yOo+lLbheTiAYUkqzvEC84qmqUVIfsQM3udor7ox0IBW5bf2UKAZQtKgbIVDvctLwv7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gsALXSwk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gsALXSwk"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfad59921so3735831cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786542576; x=1787147376; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kc4Afb6aXWQXjmXmnDB66MIWvaDryZWAnPWngJIIDAE=;
        b=gsALXSwkP9mORiwj4mNE6hEjjJYlZ2XxCbUqckMRKmyPG4C+h1Hs3n9nHfUC/wM6kN
         /8hFK62EXozGnh3AVHl4XTX8/mR01rySTJGkO6w+cQw4Vag2kNeqXKZ+J4hwWQ/fEU9r
         oIKYWYT70akf9kulkg2y3KklSDMkGIA8b4R/PATHmn3u3jGOYi8ReBNYoqj7TYNgy/6E
         kfsrGWT2eDG3jOZ9d+6g77p6+xyKqQvaxTINOmsJgUCMwkl+To2FMFwXKcb7mwmNiXXk
         Yldfv65CgNqExy2rqgfLxFGr/l45W6UYiLZlvmpHd+J4SE118TbpMTjl8m0Kndc/EUvK
         M/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542576; x=1787147376;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kc4Afb6aXWQXjmXmnDB66MIWvaDryZWAnPWngJIIDAE=;
        b=FLZ2ewuuu4U0hI2DMx42Y87q5B9r3pZ/aMuTm/r6bnEqjlVDF2f7jVc2vSCpWJxsST
         Q9UtbILZoE3GKccKBDDUs1WR/08oIVEiBCTsCECZY9brDnVtpnbkzyK6T2YInQoNa3X5
         0Szj0TuxcsRx8jqYKylRYuoGJ1MC61cahAeyt3vE9qrwNJ4YOef1kFnRKU6DG0AMWhCx
         TGGifxB8ZeLg+2H5bqGyHtsKYAwK6I44x7iAJCxqcMaLtMRg9fZ1gAnjCbrVOmu7YKFt
         T9yNt4/lRnNUDu7iF5/whk1yr3YRmN1oKy9spJseRbT52VExqKC61furlxjs07lkIJ/k
         KhHw==
X-Forwarded-Encrypted: i=1; AHgh+RodbUnxBl9rgMSI80pZuWvDWCrIvrqouFSuuXhXpn8OKCFaEeG5Mqp1uAnjd9LKJT4HKmlrjoxQLgaM5GM8jQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoDxXxwbC8LNsZFSbXbtezNPmDN4gnqd2TgcvawjN+yK/F57tj
	KKbSyW76/2WA8Y3t3AvJm8G/PUlDcG9Z+ntRL+SDE60owKXb9SXCToFCllShocW3Gko=
X-Gm-Gg: AR+sD13HoiSMUekvDOMACTozaMBnEGv3hl9xelP9ee6AP7bVAmMvs6jughnawV5VdQO
	0SaX/Yrsakb9CnOvwtwYBDh646moOvo+PwSE341om3/OpME/PB2eyKoI77X7A7CZSCbOfawsN/j
	nFoMSB6oNljMxwHeHDpmO9k+G1YDVvi3eBlQ4lVdUK7NgAc3j8e77A/1scmZ5n+9dVGojmkIANO
	YqSfzvFmRVEwGawkiGfTY4sedtNRk8bLchycgkB1xJ/jTqq43nKdZWDL8YOS3n/GYLYKH4tKcl2
	KJkDUhMvo9bVF3DO19+FF0pPLK322Eg/QKUP8A+1ENXWD99d8es+uFv+vbwidoHU74l6x6A1XzB
	iW88YXjrpMIzFVLYbow9bxRFG/ATnKizScl5sHAqhAg/+kuEtxBQ2pQ+PHFfMNff89oM2N/TEYW
	35x2EO7jxqHG3GTVFOtIhy8zImAVWDudYMYDYmZg==
X-Received: by 2002:ac8:7f47:0:b0:516:dbf6:f8e7 with SMTP id d75a77b69052e-52d646fa46bmr42007131cf.17.1786542575667;
        Wed, 12 Aug 2026 06:49:35 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61c0821esm18333021cf.4.2026.08.12.06.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:49:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wu9Ko-000000033xl-0724;
	Wed, 12 Aug 2026 10:49:34 -0300
Date: Wed, 12 Aug 2026 10:49:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
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
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260812134934.GC662699@ziepe.ca>
References: <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
 <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka>
 <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca>
 <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>

On Wed, Aug 12, 2026 at 02:46:08PM +0100, David Woodhouse wrote:
> I hear you. I'm less sceptical, given the use case, but I'll certainly
> concede that the universe is known for inventing better idiots.
> 
> I'm certainly not averse to having a wrapper so that the read sections
> don't just srcu_read_lock() directly, but also get a sanity check
> (non_block_start? local_irq_save? what would it actually be? does it
> have to be different for the hardirq vs. process-context invocations?)
> for free.
> 
> Or instead of a GPC-specific wrapper, do we make it a first-class SRCU
> citizen, SRCU_READ_FLAVOR_ATOMIC? If it disables preemption, we'd know
> that lock+unlock must happen on the *same* CPU, which could potentially
> simplify my new try_synchronize_srcu() and/or allow for a *spinning*
> grace period if we really do want that (although I'm unconvinced; it's
> *latency* we care about here, and punting to the WQ when we *already*
> have to wait is fair enough).

These all seem like good ideas, then you don't need to touch the
notifiers..

Jason
