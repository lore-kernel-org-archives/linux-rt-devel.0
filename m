Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F13CC33C
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163692; cv=none; b=GfkZU0GfNOjFUVFQnebowsC0EYOVucx3xoU4HVNeYBHJabStQ29IWvSaZvo7nwumxpWqxiS53pBK0evahKQq5B0xfz8QRh8g//IDXiWVcOi3TYdLfYeiU89Gh+8d2PKwywJQqO5JJUSKIHAzn4sOXsQuadvdLEtu/vbWBX7QSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163692; c=relaxed/simple;
	bh=UKX9q9oIJSnrg3PkOmKbLEBVHZJHu9rSC2zcqfRiq/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sToUXSYx07RydCErt7N66mP45uY71ydvrRHzNLtyyF+M5SRuWH/9mZ/fnnM8IIoggfj4OudHUjV+sD1+BfEpJogO7+NVYF7x6rDLq/ZGLjhu8PuzRsCEBpgX9D23y2jK+5XLjIfTwMD9p0th7Hl2sEuc/hUJO0Z9Gm91+PRYY70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UqyAcgbk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9IKktNN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UqyAcgbk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9IKktNN"
Date: Mon, 31 Aug 2026 10:08:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788163685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kOSOst4In022OAgVRNxSdoYjl0jKl41mZxfh1QOXGYk=;
	b=UqyAcgbknTYn3fJW+77HU4qPPnTrytzLhryZvvJYqEuIx8qphJckoDifDfdm+rCRRjuKx3
	X5AYx39fVc8NNQX0G53A5jZPrsmNKDCRCO17shC7V7IzmBfEvXg+awsNTsMSRKtjVuoish
	6esMnTvDM2bG4LZr+N3HLR7SrxRC29FZ3/9FFEJPR5tIXTO8wMMMtHknvUzs1BeoJHSEES
	fjqXjpkR/1miN9p7UOSQgsfBnbgFNVII3NxwD42wrshQxcc3VIE4WWUYwfm+VVzt4DLsDf
	KxMDmIxUDVB+MF902mkKdqmc/xK1S4lVk0DJdJ9CvipP2ojiOg/aG7AJ5W14fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788163685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kOSOst4In022OAgVRNxSdoYjl0jKl41mZxfh1QOXGYk=;
	b=N9IKktNNqgpGblx0PmDvTe0TsNYwsV/Spk75gDgAMfcaFRBv4+VoIfFsyYXqyU/3U78EvG
	MvmNWirnPXNVdQCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Stevens <stevensd@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>, suleiman@google.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Message-ID: <20260831080803.LhShiZ4V@linutronix.de>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
 <CAOiLmNHK5Hw55omycg_EAHzi=g1iqJn1NTap1Mt98im3xTXcvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOiLmNHK5Hw55omycg_EAHzi=g1iqJn1NTap1Mt98im3xTXcvA@mail.gmail.com>

On 2026-08-28 14:17:49 [-0700], David Stevens wrote:
> > Did lockdep see this?
> 
> What are you referring to by "this"? I did stress testing with lockdep
> enabled and didn't see any errors, although I will admit the bulk of
> that stress testing was !PREEMPT_RT.

I am (was) just surprised that lockdep did not complain about the memory
allocation under the PI lock. It was pointed out in that thread later
that the new trylock usage could mask that.

> > If I understood the whole exercise correct then you have a kernel stack
> > of two pages and in best case you can unmap and release the second page
> > while the task is napping.
> >
> > What might be a tad simpler is to memset(,0,) the remaining part of the
> > stack. Since the stack is vmap-ed it should be swapped out on its own
> > without additional tricks. That memset() would help zram to compress
> > better so it uses less memory. ta-da.
> >
> > What also should be simpler (and I am not saying just to move you away
> > from the scheduler) is to have a shrinker which iterates over all tasks
> > which are marked for reclaim and then similar to swap just unmap both
> > stack pages and release the second page which is not used.
> > Upon wake up the task should create a page_fault which would be used to
> > allocate the second stack page and map the whole stack again.
> >
> > This sounds simpler.
> 
> There is no swap for kernel memory, only user memory. I did contribute
> to some previous work that aimed to only only prepopulate one page of
> each kernel stack and then to dynamically fault in further pages as
> needed [1], but handling that architecturally and guaranteeing that
> memory is available when needed is difficult. Full-on swap to zram

but faulting it in while the task is running is sort of complicated
since the task might have page_faults disabled. This is what I missed
initially (the task is with disabled interrupts in the scheduler).

But unmap the stack while application is sleeping (via shrinker) and
fault it in via another thread on wake up should be doable.

Sebastian
