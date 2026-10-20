Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510039;
	b=3Zsr42LWaNyQCiNiGbYudhwKf+svyHQ4gvLi6EhjSUEg/Jtc0CzVKT92JTvlA5QoBTlO
	 hd5qKuStd0yaKCdkT/R7hbaIn+5Q270w8O+umuy/mUlQXv88xI5n2dQTbb+QOuoqxxwLY
	 RzNJ41YwfVrJazSnQpFLnA5VS20MFOjpg6BL2B0jyxMKu0KHvVfvAD5mCZUlXxmPpE0Qu
	 01TLG6OkxmO+9rjvQjxhL2SEx1FUBZ7MOhE2LnXcSLwvlrWtbxFkMWIDPOTurIdzv0Hi3
	 jcWyuPtlcu75leuLHXWq4e/qStUS+VGmFNmZLVbxT4yeZraYTl8kBgcPZ6FMkcTaHXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510039;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=AMP8JdgNkDiR02HwTbm0bVfT+4C/h/UkSkbT7J7kPuA=;
	b=1e90Q+wn0AYTAUWBvdg5FhEcuK1VToJ5kg2Ul9rxJlwOa3VuoetztlBReGd2NAZ0dsOd
	 fCbIIedPneQChpFVMY81c/rMfCDXn+Xul8jdxCa6CZuLQG90aL9+O/0fmvEd0pS5Gr6J7
	 Owg2hfJsqz5JMg8YPTavknszactTGw4Rkdg/Z1BGs7L5n0nHr4RDicCczVYKoXiIrNitJ
	 jX4V5qgXgwWzG2iKvdOgQ3u0FH2bynte8ScmmjvIsvSiezbdpWoxUUPFJI67u4ShHMVRX
	 LxlDDyOfJf418DByULprpaacB9VJCpl6ynGwsKxQPPklLXE/wOfS38R9l/P8ZBBGfmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2r02bKXd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uu8FjPbF;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE5606A31C
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 15:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACBE5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2r02bKXd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uu8FjPbF
Date: Tue, 20 Oct 2026 17:27:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792510030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMP8JdgNkDiR02HwTbm0bVfT+4C/h/UkSkbT7J7kPuA=;
	b=2r02bKXdXozWpDueyORgIYxwfRMI1Ao9/3XAElBBhlV5gMYcVyo4gVjbr0dtBqDRL4GSOH
	bzKSeGq52DgH3aF/eyniApMAaO2RWJQC1aw7wah6pP5TBHjy3aejp81Umu+vBn61HIpse+
	Ohu4iaU+3c3dCDpkdXxi7Gbuf6AXW9SqpmXmngqSlqS2ugEjtBnKGqkLahp0bVoy/M3Fsu
	MEXZpEg3pbeIRdjabpeyJsIDAfK5Sx5h9ITs5tQew4HSSiQG9BnEtbL/t50fi+JPyzP14J
	42wATqH09Zuuk8gt3t7rJMcYZOwIUUKjARVS8bPd0FNm+UrIMWvVCfWGT6GRpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792510030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMP8JdgNkDiR02HwTbm0bVfT+4C/h/UkSkbT7J7kPuA=;
	b=uu8FjPbF7WAWVQD/GH1wBlh+67p1e0H4uQT6K/4f8AvNx0BtJsnx7f+nV4gHIb73oSnA7B
	W+6bBIuocl25n0Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Stevens <stevensd@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Amery Hung <ameryhung@gmail.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] locking, mm: Add atomic allocator trylocks on
 RT
Message-ID: <20261020152708.3atPlnSl@linutronix.de>
References: <20261005070625.8871-1-kmehltretter@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005070625.8871-1-kmehltretter@gmail.com>

On 2026-10-05 09:06:22 [+0200], Karl Mehltretter wrote:
> On PREEMPT_RT, a BPF task-storage program attached to sched_waking
> can deadlock when kmalloc_nolock() obtains an rtmutex-backed allocator
> spinlock while try_to_wake_up() holds p->pi_lock. Releasing the allocator
> lock can enter priority-inheritance or wakeup code and re-enter scheduler
> locking.

What is it that you try to achieve and why. Why is !PREEMPT_RT not
affected? Half of the problems origin from PI-boosst.
Why has the nolock an rmutex-backed allocator.

can_spin_trylock() skips hardirq and NMI. There is a trylock on the
local_lock_t.
Why do we have this mess and couldn't we avoid having it?

I looked at the patches and there something about hardirq-atomic waiter.
Wen don't have this. I don't think we want.

Sebastian
