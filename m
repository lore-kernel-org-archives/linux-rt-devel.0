Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E442DA756;
	Fri, 22 May 2026 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440810; cv=none; b=sQijqIUM3/HVRxXquLOJFPh5nT6WP46CPKAKxo06dFPII+3IifhL7Fc4Nyum31RDW1fq0jnLceDh1ksfzJ65M8LG/ZfEVboWVfxBu07WoC+oKqaJ9yCf+O2S3qCJJocu3x+/1fqN2kLhPWGSaieftKplQAD9ZuDMr9E2E2D/Es4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440810; c=relaxed/simple;
	bh=ujtyoNewSYh4v6zjtHI3Fh0qt4+8tAK8GCaWQtmgFAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9n8HRbLOuKFCex1CxJfKWCfpSKhHuMaX7yITen8og1UikFxo9wc8gAD99Iob3AqmJX2ZZKdOwffgQo4Eq744P+IKnVf/WQdah7+saEu90jg/5Litcx88VYqtLvUGS0Z/exGC7SQxa/cwC60PUaUTl5k4y1V5FLjKx8+whNZBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHh9Mvku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHh9Mvku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701E21F0155D;
	Fri, 22 May 2026 09:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779440809;
	bh=3c05gl0H/GpWSA6qaxgxfypMYcQADyQffOHZBAKPcvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AHh9Mvku4Tnd8U5EQXKfG07xtqXD/gmOXK6xZTxiIvJAiMFkn1FNVmOhV3MWPz75/
	 IV9zCMOtUNQoilLVACbSZK+6EbGvqrV5e1yPfiLurnr2w835AOHAnwWn2FeYnpdyPC
	 fhxUWLFapRiDSRH2XCyrWgKKh58W3k075AIgm7/R4TgvNhK5wwhclvtlNGngiQjS3a
	 8cPy7dmRejgOL+ZiWJjl6IzW4cEoNz5h+OsGrMMS+AA8hglPmkdWuQ+LPZzi5AbFJI
	 epMFfBExLfqLf6f4l8USRqpiRmVtZyXHsW2kjK3jYOy5jDOEQO77z5X28B5fJPEHYd
	 LKQBvrIrMTVsw==
Date: Fri, 22 May 2026 10:06:42 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] irqchip/gic-v3-its: Use GFP_ATOMIC_RT gfp flag in
 allocate_vpe_l1_table()
Message-ID: <ahAcWjiPbf-V554w@lucifer>
References: <20260520204628.933654-1-longman@redhat.com>
 <20260520204628.933654-2-longman@redhat.com>
 <861pf3x3hc.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861pf3x3hc.wl-maz@kernel.org>

On Fri, May 22, 2026 at 09:17:35AM +0100, Marc Zyngier wrote:
> On Wed, 20 May 2026 21:46:28 +0100,
> Waiman Long <longman@redhat.com> wrote:
> >
> > A longer term solution is to defer the allocation to a later stage of the
> > hotplug pipeline where interrupt isn't disabled.
>
> And that's what needs doing. Not papering over this in a bizarre way.
> I proposed a potential solution a few months back, but didn't get a
> chance to work on it. If you have the bandwidth, that's the way to go.
>
> But papering over this issue this way seems like a bad case of short
> term and unsustainable hack.

Yes, agreed. It really smacks of trying the fix the problem at the wrong level
of abstraction.

>
> Thanks,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

Cheers, Lorenzo
