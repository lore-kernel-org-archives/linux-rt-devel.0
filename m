Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991D255F2C
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600274; cv=none; b=Uw+e0Z1iK2MZz5ggchRQpTAQqXjzUUAHQreUGX43zScm7Kjto8rIvSPm4BTDzLyqpSfG9sA2Tsekq09QSEGYvEKQPSGYjW2ESKgArDTuYbSXuPR31PLbIqeCBLXMRsLT4dxfut7WpQljqx5YFu1wE/66zKV23b4rYODH2BOR9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600274; c=relaxed/simple;
	bh=HfnI0QUucx5Uo+79cQa7yfD5auNZ15dSJHI9lQN1+gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRrCFplSGXGdfg4VxarwSBha2VOl9OYHIJdw2UpD+YPHIPKdNGGl1eVnhpJpy0BrAda3yrNGAzydKfG2UamaZn1PH6CIlmUOjyoLlY9ctUQTiZ3reU18HcCuzgtrTLgGf4HNbhqOpj0CHujhVoAGsNSDzoOhpw/nlh1RqVTlvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jECwzv8B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhFYLLD9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jECwzv8B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhFYLLD9"
Date: Wed, 28 Jan 2026 12:37:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769600270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtyO7XYUaz9mOuesnWv95Jo4C0Zc65c4VM15labksX8=;
	b=jECwzv8BRRAbVPN1XHND+5m14GiJR1JxVaaes+gZcYKB3hkIlz+n8Z5JbRRfOSzpi+eESH
	xFXOCta6VH50L2NLlym5L1ExphxEaYFBlZjnOYs0HGC/pRF+J4Q2/dniNngbA3SsLM2OgK
	gYEj2ajwAqV7a2+vovTmeqy9mldXBN/AwYJ9feZOL1JAgNG6LodtJiJeB270J3bQmIuZl2
	dR7rfXqQOhqEx3ZgQrk+3T6e7QHY7mzJrrz5sagI6AFydoGl6umcGrJWoRNU9DQpYGy1uT
	KNOXuuVOCHSAUrf090UzRsY+8ZgwLkgnH/qBbCOeIP//nT7n2GYd6/UnQgM6mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769600270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtyO7XYUaz9mOuesnWv95Jo4C0Zc65c4VM15labksX8=;
	b=qhFYLLD9tfYykNB2DRE2Fk9t3+/bbeA+5JcJi0VnRgghHk9FVWEvsf5SMlVmXGU7PlFATQ
	AmKZnTicB/bgCiAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 04/10] mm/vma: add+use vma lockdep acquire/release
 defines
Message-ID: <20260128113749.osNjwNqo@linutronix.de>
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
 <fdae72441949ecf3b4a0ed3510da803e881bb153.1769198904.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fdae72441949ecf3b4a0ed3510da803e881bb153.1769198904.git.lorenzo.stoakes@oracle.com>

On 2026-01-23 20:12:14 [+0000], Lorenzo Stoakes wrote:
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -78,6 +78,37 @@ static inline void mmap_assert_write_locked(const stru=
ct mm_struct *mm)
=E2=80=A6
> +/* Only meaningful if CONFIG_LOCK_STAT is defined. */
> +#define __vma_lockdep_stat_mark_acquired(vma) \
> +	lock_acquired(&vma->vmlock_dep_map, _RET_IP_)
> +

After going through the remaining series, I don't think I found a
matching lock_contended(). So perf/ tracing just give you a few
lock-acquired events. Wouldn't it make sense to also some
lock_contended() events where the caller had to wait before it could
acquire the lock?

Sebastian
