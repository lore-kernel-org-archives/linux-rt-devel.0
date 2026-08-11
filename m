Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EB531715D
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462158; cv=none; b=o1ztd9H6rjczWvLXk4bKtmKk1nTVleHk1eNER0auQ/+Qkmc7REZS8utCjQXbXXVHPLgDDU9Zh26MQ3dGaPcB7PjoP2k4AAKHRASrew551NmaQRegKLIbkbi9XoOQ9ooEZcP3ewoQOgT9QvWD5IP3ihV7Q+H6E8bZ+9xMenJ8cOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462158; c=relaxed/simple;
	bh=UHHefDh2EvrnsEzLDkapnlP+pXYEV924LvKFh48lZrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du0EkPlJ0bkJbxhlHj08+p6/Z9CoWYQbsQSeEN2XFhtyqJjEl+rnhljdx7TKQXvrNrZrmaNuE+I8W+zGdTM5vBeukZ8evVPbEgN06Or+/RQB7WlH4QlDy+yTToTTVjO5BEYaT41/gskhN42V4kv60OUEfdqvC5G6owgQ9+tO6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dCFSag8f; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dCFSag8f"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f0e5e36912so5734206d6.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786462156; x=1787066956; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PH0RdPEa3oSLEapGNLL6x5bM2qkhDfi4j65pHbraVdA=;
        b=dCFSag8fW9Nt3E11BO9K8HN6CUszDjdZnOFKWGAVc4Xfi675c1q6R79ikvPFxBtkqT
         1CXoeQuc+OdoqXDL71E5dElIEDNndMGm0+guv5SIsXSSSKdIcYi/sfWhorJ6qaQLtXdn
         zR8ua1d6vx0HZugEpRNL18t1dBPry51oBqSKak6IsPI3oF87KrwwgL+YswyNJmt57GHT
         cRiLW4+yOJ8EyQMjaeok5fSNfqMgZtTc6pQ8FZL0gN9GIV2tpdrXkbkrUsqGcnfa9ox2
         xnjE5avmV57GO+LlbVmXJn02wGyzV0zn13ec210a8c3R2GeZ+WBn5MCYZeAjC9dc+JZR
         XKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462156; x=1787066956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PH0RdPEa3oSLEapGNLL6x5bM2qkhDfi4j65pHbraVdA=;
        b=H3bALlkqrNGSxQliJNJtNs3OzAJexb8XL2vakwB+Zw95ZGCHwd7oagueYZQEJbDaLb
         cSZfZbtX6euYS1K+bc+U/qmqRupCYjaZnYip7Jr1MKzyHcBFTbhJyDE9LgP+ZOsgel99
         +YrjsmTEiJj8i1lBGSk5/UGgAzvkK2qnJOOYiDNuutL85li0tgc8pbNSmt5tLqQy+PD7
         SiJsewOTChgcw6yVNomgZAM3/2qljjvrRsIRZ6G5XaOgdQSfWadAC+tBUN2Bj087xJfa
         YY0bW5bW5gGaS+zw43RVGV/Z6TeetnFjfh4HP6NLjAILUJ3IoGb2D6XL/rOeCjEPIGjL
         DcJw==
X-Forwarded-Encrypted: i=1; AHgh+RrtfTIovBC9XbtmFJBiEEQkken/7jpCx6+Qfvfu/FGmVfLDamZ3cafVi3n/zUU3Ec2kDnj2WsvHrYYtMfk5yQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOpn9qr7wxqRNM0smOwvuDonL5Ig3m/9/ovaIx8j5U2/SqGcxy
	MDc8eEMEind/BjMTk6lxQt45EmYPHL1Gvrt3juVJ0ztEaPmfWSF4S9Ver7Eq+GIF43I=
X-Gm-Gg: AR+sD10Np4xA78lNNdV/8aDpIbDLZpzVNI8R5ePtRUIB2UKsJJHy9AYYzskzKzw2NYM
	OUHdtyEc+uyiu9XYv1YBe94mvWUqIP3QRUh7X3yVljeAjS2f6x+aDF/ziHAp9Q3bnzRuGDV//lL
	HH4iCMzSuEVml/9kRp2fIdS5uNIJKeQx4Yufy6tLundP7+L4/zCfNbn+v3s74qhHanqoP5dAcCO
	HsqM2KVDHmr0uJAGELmC6KjbWfOEvCaMNapm7JSCewwEVXayjs0YT7iGd6maztzRziJpmGlFVD6
	8lAADOMlpkox2XoEWbhQKaT+wbziw2DmVq52qH86cffw8O0ZsOSQ9dnrJ9ZbLuwtht7wUT0rliW
	MeDpX+tyz+am8tlqSOHIZaXICpnu7xZpq96QxxiaaC1+w6jAr1OZQnxKBsCWytImHN5oIasfyDB
	96T0AoGxraDQ+mZe66AF41AiB6wpMzDJnqzkloKw==
X-Received: by 2002:ad4:5ca5:0:b0:90a:6016:deab with SMTP id 6a1803df08f44-90a6c0dc16fmr9015366d6.8.1786462155946;
        Tue, 11 Aug 2026 08:29:15 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3c1d73sm1372206d6.34.2026.08.11.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:29:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtoPi-00000002X6a-0ioj;
	Tue, 11 Aug 2026 12:29:14 -0300
Date: Tue, 11 Aug 2026 12:29:14 -0300
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
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260811152914.GI544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>

On Tue, Aug 11, 2026 at 03:33:18PM +0100, David Woodhouse wrote:
> > At the cost of completely destroying the mm shootdown performance with
> > 1s RCU grace period waits every mm operation. No thanks.
> 
> I feel like we're not talking about the same things here.
> 
> The KVM patch which this enables does *not* behave as you have
> described. Have you looked at it?

It does, it calls synchronize_rcu() from
kvm_mmu_notifier_invalidate_range_start() - don't do that...

> Nobody's suggesting that we force any *other* MMU notifiers to do
> anything that they don't do today.

Sure, but nobody should implement their own notifiers with such a
heavy locking primitive.

Jason
