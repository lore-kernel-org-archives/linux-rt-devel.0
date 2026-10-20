Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462481;
	b=Vaxa82Cx5nOa0RGvnFFmoDIUbtfAPzWfI0EwQ6Saa/ImSyy94VtevDvYEeAQyMSQ2YSo
	 5qZEcC/TXpZEA9gQ9EqTx91FnKS3DjqAj9mkJL94CwFq+JdHejQ9H0e8lJUAHTbxZ/I3b
	 A93EEF04RBTjuCcnEOi7p7yTfbP3xpnw2DPAgk+aH/eg5RjsP6qnRI94xa49L3uerlaXi
	 FX/jQuY3PfTCwH6N3KVBzJxQ1ARUJPHu1MCBXO2IJ7UocIffIqzIMW6TS+Ec9z/ay+cCN
	 6hDydrlw1eYc0Rsx/w0bv5XvvPxP7S3O8SmJDEBnUoghr0laJ6rbz9P+gmuRWbfqGLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5Iwx53FddK31aCeF3yTsYcRGG3DAdKI2xVbjXFtQkwA=;
	b=OPyunmbkA5stgaiXHhQ+DKriBWVN9wH9cAGwPd1SPUrKbmlEqFKEkT6YppiDGjCf6SW+
	 iiXBMwwUjugLPshir+md5icHi2VBzFi0SG3S/UCjBRJNKNkak5MlEq4sAYz+hyLZ9T76B
	 qGaOXWUJkYtd7CBp7/r3N9ZcV21qP5eD5xwY91gMJ2nYUmUzfoHTxfoSXjXTQxrCnT6Ia
	 iWijB0BSyjJOjTMTsaiQ9BjzyHUlI0MojEZjuako4POm/oP3zZPgAKs9NMJKsL4xH2TL5
	 3Fw7R5d3O+3w/iU3sD9ZDx5t/PjhcgZLJCaDBAxipuTJpGyY2dJLUpvWY5IqeQfT2Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZjG2+fyc;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE855606A31C
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 02:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE855606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZjG2+fyc
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48df54150dfso2069990f8f.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792462479; x=1793067279; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Iwx53FddK31aCeF3yTsYcRGG3DAdKI2xVbjXFtQkwA=;
        b=ZjG2+fycTISWbDwgYRXT+m/OKU1FGi/TjaJJZ+I3sRKfDj7Gv3RL4e4TkKAoTSi3C3
         UQJNQY0MXzvxxukyHFerspPVBCUD18sWlv4BmuTg3ImPEM0ye+gVoTKFUlTqCq6DDzbs
         1IILhQSu8wy/MtD9/sRI/5IU7yIzNE6nTtJPpIlNlPSkEQIu8XR/nexiYY14pCwvdrxr
         ovRAnuMC7E89r0O3gcFfzmAF0u5Q65eSN8Wv39VswXPxZjw/Pv4U3qeuHqt38+zNtq7b
         +XLiVO/O2wIMmwtC+r5qtEHmYzN5b6poarQZM7KFTTKgIhB2uUeR9CvwdfBYsqLHt6a4
         +U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792462479; x=1793067279;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Iwx53FddK31aCeF3yTsYcRGG3DAdKI2xVbjXFtQkwA=;
        b=J5EkS7jhyfe2pxJvrohtnyMN3QLuirpMAsZBEsHwQOwQs5A/BtJYsKuQv+rrvzidXf
         GWJUFiYZtUYQgWmNrZ3UDE/4wLDgAVT1GcvZtMsxEORPpjN8hcir9A6pGvYosLVVBJiO
         jec3tYTkWRPrsmG0HNe4FpZ8M+gCOoL2iNJOqhlwowSY+3lC2EQZf82QM61NIa/LiAm1
         hxnP5p1DXsINr4PMgr6QY2UMmEsyO34ztZWGVd3VgWaryY6EWT49DSdh5ScKMuKrpOu2
         4ti5si5hxeP2xdr9lO+jj/Hen8z8iQ+u/e4CBRcDJyqw6sORVNzx6SIfdLEzxuAJDyEs
         3BaA==
X-Forwarded-Encrypted: i=1; AKwUvBxcTJj5DjKLPGHWzw8K4jQm3Ix2VuXYxawr3io2KFZTiCmy9cC2i4lIqgoPeY5GrDVUpnnm30zTvWNrdbVfMA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKBZSt2sC78HY472vZ0JXVHP1xRQDNAnX/4U2MNEwh6c/H6qB/w
	X5UAK+mLnNnFh4LGZ+wmmlVjd4uhux60xW6X4tNuXjC8MkxRemxduZsD
X-Gm-Gg: AYBFou2bw2E0M06HsoamOtvL1Bwrs08z001JZU9cq38GpL7buCAn8dgKIR9HX2pJc3W
	Ss8dLEphBF0zpnj0zPhUZcpTvZwydOQvXlotjXWcF0vlyEQ1lIF+2mEmmJKmR+PBgiY/BVAWkcm
	DB3Yr+LiVkLgtp4COwg0Y7a6hY4lOtmSyMfMa9w9crh2DWuu5lWgP4dB7vTscvSkWiZ982LWkgX
	j+VmYFFgz2jYlylxvjUa7FBIf0mY6albGYqdjwySuCopVcOThKtLibQutstXzc32ehVUoXJKQ+L
	wMePd2R7adiqElED0NEBcD708C46lTfJwuukOpvulB6cBVqFnrKrQsZCD1q0aY1jq+Hipfz1Gkk
	dN762Zh5r7TOXxmJHhavZHDTSagCsoTsAHMm6yhHqpmcPiG23+5OJ1/lryMp3RoEt9KRtfn/Dl+
	JOlrEPku7vfXwYtOwysrTg9B9xF7W6A/APRjFVGfhNn89mtoW/4KMzK82MhymoiWjEbkUIZ6tjW
	Y/u1izIlR5qcHWffkIOX7/s92MHDcztlLVomDdFokSDDOXHAAQEyQpxjYicQFhPzP3tQ8G8jgcM
	jxMy/ryID3kgr/0lTXUtTL6ULyFObbpG0DvlsF4ozdI7gpz8Mcyp7dECv0QXQMCfAKNwOnXI+QW
	rG8uk6VRl1w==
X-Received: by 2002:a05:6000:491d:b0:488:5852:6ee3 with SMTP id ffacd0b85a97d-48e07bc2f43mr19882172f8f.34.1792462478968;
        Mon, 19 Oct 2026 19:14:38 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9c92-6501-cda9-90cd-4e49-75d9.310.pool.telefonica.de. [2a02:3100:9c92:6501:cda9:90cd:4e49:75d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208b1sm2879816f8f.33.2026.10.19.19.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 19:14:38 -0700 (PDT)
Date: Tue, 20 Oct 2026 04:14:36 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Harry Yoo <harry@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Stevens <stevensd@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] locking, mm: Add atomic allocator trylocks on
 RT
Message-ID: <atbOS2rs94fB2red@gmail.com>
References: <20261005070625.8871-1-kmehltretter@gmail.com>
 <asZ8jmWNoGk5tYce@thinkpad>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asZ8jmWNoGk5tYce@thinkpad>

On Wed, Oct 07, 2026 at 07:15:29PM +0100, Harry Yoo wrote:
> On Mon, Oct 05, 2026 at 09:06:22AM +0200, Karl Mehltretter wrote:
> > On PREEMPT_RT, a BPF task-storage program attached to sched_waking
> > can deadlock when kmalloc_nolock() obtains an rtmutex-backed allocator
> > spinlock while try_to_wake_up() holds p->pi_lock. Releasing the allocator
> > lock can enter priority-inheritance or wakeup code and re-enter scheduler
> > locking.
> > 
> > The first RFC [1] rejected every non-preemptible caller. That prevents the
> > deadlock, but it also rejects BPF arena allocation and faults under the
> > arena's ordinary raw lock.
> > 
> > This RFC instead adds an atomic owner state for bounded PREEMPT_RT spinlock
> > trylocks. Atomic acquisition succeeds only from the completely free state.
> 
> Please don't skip discussion stage and jump into submitting a very
> intrusive change across locking and mm, assisted by LLM? :/
> 
> I don't think attempts to tackle this problem will make progress without
> discussing and getting buy-in from (PREEMPT_RT) locking folks.
> 

Sebastian, Peter, Thomas, did you have a chance to look at the locking
direction here?

Thanks,
Karl
