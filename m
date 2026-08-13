Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B656478E5E
	for <linux-rt-devel@lists.linux.dev>; Thu, 13 Aug 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632044; cv=none; b=HxSCimTBeY9vmhBwvD68Z3/qJr7jl8mcREJBFq3ocCNcOlagDq7L5k8J4Z8GmHg6qFj7aMrtCMH9QqdVCA8Uc3FNuAzzAtCLMXsafNM2nY1FWw+EN4VAZsH0zyEXWCtShfYUXJj2oKyXuyUyDxntom3QBmy55nRAL4nciEOy8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632044; c=relaxed/simple;
	bh=Fn7/Kun1Xj3zANVPU/qpma4EzgtzFyOKv79nRQkl1r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9IAqhhq9M3cWrdEyYUd2WiTrBe58IWYaZVrRspwIZTfofEIRkNNFjhm4j1tK4pm4W6o03uxaz+o3v0dkPnoCKFiAcejGtOWBQ2tapjpHRB5FRnwV8vphbDEuhcE47nh6VwlXbdui73pccu3NJdh1gteLG8W2Q8B/CyobJGD8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PLqi/h0Z; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PLqi/h0Z"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c2a818fc4so5427211cf.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 13 Aug 2026 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786632042; x=1787236842; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BsutUma4J7k9K1EQrc1L+Fl5PhES1nmDAUI72Bdk2Yg=;
        b=PLqi/h0ZZLQo7iIrvdp8pYgRp+v2EiHSJiHrOAICXZPc3Turh8RNlL/uEtk/7lcIAS
         D2BPHwz9i76YByVX+/WS03JASmRFNb/LfRhADJHZXRBPTshgIHEC8ItRvD5/VPEWSR4E
         uBWP7iTxHTvHhxx7vPTLEC9V/EWfzl1NzDirTtj+LARECpbPNFoqV3aEERG3k09BL3bM
         Iuf0XYgKPU5pB7A9gqicDX1fW4L1p040wX0+hQl52aTwOYZ44go7Qd3+kUnvXIdHHNjL
         iDx+Bss+XT9Iv/+Zt6P3LRhn10UbTQNcx6/00Ys+Lzg3y0UyZ1dcbkupBLo8TeaZq4IE
         HHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632042; x=1787236842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BsutUma4J7k9K1EQrc1L+Fl5PhES1nmDAUI72Bdk2Yg=;
        b=dCHQQy5dReRMAbAdwtbL7KDCc/pfkCLwJIlAI/fJyly4uQCdTwLLr3Ms3wSSwAEiZ3
         LcN0Cuxn2hILr6WS+EaEx5ah/NetbW1OgXLk+h2ftqDQQ0hD4dgYk8k7mYgLM4h0o0SH
         3Vnq+8vImBVEk4Cuv3kOZw5h79qF7ozjjjCpM5SXUejEr5GDB42lXmWI1SyUdGRqitnT
         xktXzb/gTbSvJQMk7l8nqIzYng0mzVdUOGuoXithWoWdVhrm3noGYqSdP3ihjNkcbdCt
         tWeeXTzg7S3fM40gXMVy+P4nkB9z2gJHaMRdmIISW0yNfb+7YorQttZUTHfrMBoae24K
         01pw==
X-Forwarded-Encrypted: i=1; AHgh+RodWpQegYqlOX3Ahrnm1KVsFQsVHj9K40/Wp73mXP2//vq4TYBo/wEOYVOfghgRveEdFrpVv0cN/lamAml5kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUO5kFFseZLP9Ph+Ok765dI5JRxK9b/+VCdZYnE5kRoqasE7Hs
	igoupSwzwszEWvSMzC09DKDd9nWRPsYMAyEr1ZJC7JP35vnnzFd/rLlAAgcnsAyoPFo=
X-Gm-Gg: AR+sD12fEYnpxE7799Fsx0yk3lgaQQtXHcFSeM6wqQ3RubjQnM1RsglIwFamKCFIU35
	ndbSQD1RVvpOoLp0lz3SIdAfcv2+jHe/dDEofJ8amoV370DanaYuFhR9P2f4M3P1sjwHaDM2MFC
	s8J9SfvbhHsZgZCjMWDpB21v//YI/wjGcKY4LPCYaZN/So+oGmIxvNSl2VYDm6+6tdP/V8haTz0
	gFhEbbGcZR3pMQ1ltkMOG1WBKEnm4vmenjNQp5OrJzUov2jGqvz1WkRAc1tReXcw7VDIg9tAEDv
	6pTO4p7d+Esa5CnvkfIpxnLdA5XZaLXlCuzP9oxBwk8OHDOaSrEfz59vde/nkhn+j8cogXH7RAg
	xHr+ldpHiMSUZz5czIDHSFIWwvIrxMt1LulAtuZmBg+nX1TGdLO7VsICv9XKxY50hZ6rW/7++Ek
	2R3kOR4eVIRU3lbGzsHgnky4P89f+LjRQ3k3C6LixPzCZbgFXcjvCGUfxFAuny
X-Received: by 2002:a05:622a:2299:b0:51c:857f:9c12 with SMTP id d75a77b69052e-52d73c272demr67730661cf.4.1786632041981;
        Thu, 13 Aug 2026 07:40:41 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d74005849sm18256301cf.30.2026.08.13.07.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:40:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuWbn-00000003oi2-45RH;
	Thu, 13 Aug 2026 11:40:39 -0300
Date: Thu, 13 Aug 2026 11:40:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260813144039.GA905583@ziepe.ca>
References: <anwraNIKJV8zwrNT@tiehlicka>
 <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca>
 <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca>
 <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <20260812142659.GD662699@ziepe.ca>
 <9e65be44430e7d013fedf9a1626caba020ad6d94.camel@infradead.org>
 <8ba4860fec45afeaa305bcb011d732ef0da302d6.camel@infradead.org>
 <an3NyIYrdN3li0ag@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an3NyIYrdN3li0ag@google.com>

On Thu, Aug 13, 2026 at 06:59:36AM -0700, Sean Christopherson wrote:

> > On the other hand, they are basically *all* false positives from the
> > point of view of what the check was actually trying to do. And in KVM.
> 
> FWIW, all of the KVM false positives are due to PREEMPT_RT turning mmu_lock into
> a sleepable lock on x86.  So killing off the restriction for PREEMPT_RT would
> "fix" the KVM issues.

Yes..

Still, if you want to get rid of the non-blocking feature then it
should be replaced with something else that still achieves the same
end of preventing recursion into the OOM flow. Maybe some smart
lockdep scheme or something.

The non-blocking thing is pretty nasty, and it would be nice to
upgrade the drivers using sleeping locks without MM entanglements to
be able to work with the OOM killer, but I don't think anyone should
attempt that without some robust scheme to detect the invalid cases.

Jason
