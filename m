Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1F2DB794
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456541; cv=none; b=if1+lgd5SNWYOvcs49aKo+BXLhPRtsNfav4oucxKhQOCoes/OXYMVpJaC6a8eXMoxzgOduP1XI+Lw9/ekKoN7tXWaJIRe7M9IwZq6ny9DudZ/7qjcGLkudVNyGpMyD/9okQbpuH6/EsCgPKFi8POr3SppKGLBYKFK32Rzgr4ybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456541; c=relaxed/simple;
	bh=2eYYxqEe+PVheZ31u+T+PddfjluSsh9ADg0MARNd0Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ8fsnMCuOaQ+1qgcz1EBznYcyZklEK5vZnlHv+aK4smDXMRdegyVUc10JougaXScA66PQ+E4vcEQwKheIkUc8zOquvy4p4PlN+q6ER/NgeWd5v47K2C0AKOUOM0fTG0O/AO5v/0btBwIqn6gvYZV9K6dE4iQ+EVSV6PErMX4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hHXGjhVt; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hHXGjhVt"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c1372f84dso19792361cf.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786456539; x=1787061339; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xauE7W5wOY3LNWuplU4mgV1n8xBkZN1XfpHr0f+D+b0=;
        b=hHXGjhVt8W+Pn/r0vaM1yQWMB+zD85AxqioL67YbCh6hcqglNWSyWr9Q92siPLmX/z
         Q+LMqxhRk7rxTNRfQ79OFV1UM52ivCJel0SVHpiUNR4faL8ENe42EgbB8ZMFw9p/iItI
         cuFt/wBMc0jTc4XrOB4xaqycNIOBjIRR7s80ZZhMCxdYa6rqZ737qUGshrqR68eOe/Jr
         wMTaT4wBxPt7z3oYZBIsvVAvT1rFkwlOREn92yh32SaqRmY9TJBHyiEHo747Bv/yEmu1
         /0Kt5Oi1uI7vtPA2OJQ14xqOU2sEmEjUAq/vriEPn+xSfAIt5+T+Qu6NXeXN3xw71Q9F
         x4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456539; x=1787061339;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xauE7W5wOY3LNWuplU4mgV1n8xBkZN1XfpHr0f+D+b0=;
        b=g0RTTh7wAuBtfmT3T+8rhqEjWHcinnNTySuB9tiqc05UspcC9kH3iYvOn/smje/MX1
         4FlMo1wIECU9QG27KyJzrd6uhNsC7thHsJ3Jx+O55Rww3ukzGscETNFa5cRiOy8gBN6k
         koTkfY0qW4EDrBvMMNR7ywDljWep7kcQRigAu2iWXTqUNrBf/2Qs0WuBykDXylwDD4ZK
         S/Otx73OpedLY28reUi2JfsE3r3G1Kgh9qlCZO7HOfOV6+A/hUQCFvcJfdeGyzylRGOa
         kQj4mLsTpKIVcNRsWiwl47n7CtIv1nu/6bp0UQwO3gGHGXVmn8BnmLhGcZP/Q09xAoxv
         7c2g==
X-Forwarded-Encrypted: i=1; AHgh+Rr+6WX8yTdlRL3gcpfVi1d2bhis1134c45VdWLOIPZNdtEYemp0ZU41ot2BRaEEgT4hbmSN+vKxD0K0C0VbdA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1VQ2gUeA10Pt7TrJR5L8RrejLUqlPOCUMGE27e/FUsnDVdwkU
	6xuytUTf9BswjZ/nKhGdl7r027MWXOhMx4Iw9jiv7QSMF2D2UMG2aCSyvPYOCVpNQx8=
X-Gm-Gg: AR+sD11m746ZCLdLgroZD0PDKZ3fmWntPk+BO6yIo+ZBvm1vydGVSr/RZVx86Rdif7c
	6Vrsy6RlV4V21qRb82dWJJ732COXBbOp5c+e48G0SmuMZyYtTAJfbBLJSpASev+Wto1UdXyyafE
	Iwv1KhB0NUpx1Q2lJBXFm4bMEBsMuPQfTMmGAWj+LXn7GxIXx1bLDV2FIBk/Ghlv5+RbJqF/vZv
	+Z7O+G89O5bpgU/kmFE/8PdaJiWmoxtafk9PIYgMMFf6l99emHFdO33aEEKgVt89npqKQ7LQ422
	OvMJ5hIZYtPcH+03TV0zKZyU0ZYBvJm7Ztak7lllS/IklNL7Fc05IzuXcTldFTRxde0HNxqgcer
	ufacS+Q2rPCL4iggt8Ok7xhXzvCam9qXbSDXHg9hg6jNbNv3rdrdjBpaxVAx5VioaE/o7fyg+dW
	BfV62crc1hZpqTFrSAKCuJdBnE2Qr4S4Ro16NnuA==
X-Received: by 2002:ac8:5cc5:0:b0:51c:963:cafc with SMTP id d75a77b69052e-52d5867f904mr29812841cf.41.1786456538732;
        Tue, 11 Aug 2026 06:55:38 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d57c749aesm11606881cf.31.2026.08.11.06.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:55:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtmx7-00000002UhD-1Ab6;
	Tue, 11 Aug 2026 10:55:37 -0300
Date: Tue, 11 Aug 2026 10:55:37 -0300
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
Message-ID: <20260811135537.GC544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>

On Tue, Aug 11, 2026 at 09:58:44AM +0100, David Woodhouse wrote:
> As Michal Hocko put it when the
> annotation was first proposed (quoted in commit 312364f3534c
> ("kernel.h: Add non_block_start/end()")), the OOM reaper "shouldn't
> depend on any locks or sleepable conditionals" and checking for
> sleepable context was "the best thing we could come up with that would
> describe these demands at least partially". 

Sure, but we translated this into the notifier must run in an atomic
context and everyone has been happy with this.

> That distinction now matters in both directions:
> 
>  - On PREEMPT_RT, spinning locks become sleeping locks, and perfectly
>    legitimate spinlock/rwlock usage in notifier implementations (e.g.
>    KVM's mn_invalidate_lock and gfn_to_pfn_cache locks) triggers the
>    splat despite having no allocator dependency whatsoever. This is
>    reproducible today on a PREEMPT_RT kernel: KVM takes
>    kvm->mn_invalidate_lock in kvm_mmu_notifier_invalidate_range_start(),
>    and if the OOM reaper reaps a KVM process the result is a "BUG:
>    sleeping function called from invalid context" from
>    rt_spin_lock().

I don't know anything about PREEEMPT_RT, but this seems like an issue
with RT if a traditionally atomic safe functions are now triggering
might sleep failures?

>  - A notifier implementation may legitimately need to wait for an RCU
>    grace period before allowing the caller to proceed with unmapping

That's not allowed. We really want to forbid that, it is not an
acceptable way to implement a driver using these APIs due to
performance.

Maybe change this to #ifdef it around PREEMPT_RT.

Jason
