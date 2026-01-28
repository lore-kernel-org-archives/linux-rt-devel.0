Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43392FD697
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599117; cv=none; b=bYH1tV2koXIXhqv7OkGQ+UQxtiw/78KXrihOZXEQyBKmNGvMtmepJmEN1fVO/i78XKYRCbFw54PBWx9Dw9odt8AkMioIZ5A/etT6Rr1lNRy96cTfJVt99gw3InG9n/u6Dlscfp8JXlktUgzH9kv92Uy1H98AWeoZO5eFwsBpdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599117; c=relaxed/simple;
	bh=c4H5rjk0oZ9opusNjn12Q0r2i1u1fX42IfQC3fIGOKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw7oCPiWGiY8IB6iQ/IVuVNMZb5iMhhG6mZds99vFkPob7jFwKB7ZWDh4Ukf4viL4OFyB3AJDtuAOT1unyzfaNATSxS4SqPQhuXBMJxiCDoITQsiWdq/EUmwMmp1HO1uMN3c1V/Ii/K6G8k9+jj6890IDX9Wyad5eiiNJ0Dwzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VzQnCZft; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YFoQNh6Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VzQnCZft";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YFoQNh6Y"
Date: Wed, 28 Jan 2026 12:18:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769599114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BuE0+YkR9qetr5imDGOoHOW4rxCJooClkC81S3EEPcI=;
	b=VzQnCZftS8+YZPbuC487KzvyJvX8vrJphOsU0eSaU/O+AyHomKDwrVwha/ooBYqOqeVqP9
	V2Vmyi6+G4luDOCRTtPLLXLHQ37v6TgXp6t8wJw5ysHh4T7nJP83A0mowMNsPk5U2uotyb
	fHV0oi/LnHxeae7UJzdd8OOLdir5BmJ3L5ab45VLdigMAbd8dZclen1hnP+MHOKZvF/k4e
	89vSjdCxCczoLtBtTU+HULdZTA9TUZJ3axtJu6XS9kNKWZiWZSO0LrHVZm2WrtvFBPHK5e
	+E17LRuHPhcA7WTCaGt1h1uTlHMWdy7MpSVKGcT2+GJs+OQi/XFTakSRlVGEPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769599114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BuE0+YkR9qetr5imDGOoHOW4rxCJooClkC81S3EEPcI=;
	b=YFoQNh6Yli1yKxYSun4KWK0KoTpLMXkHushNpv1cG8FO1QgYI1dVtL1+4xc8zft5lgTQsO
	pL0N0wwWCKUmBkDg==
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
Message-ID: <20260128111832.X9oXdXn8@linutronix.de>
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
In-Reply-To: <fdae72441949ecf3b4a0ed3510da803e881bb153.1769198904.git.lorenzo.stoakes@oracle.com>

On 2026-01-23 20:12:14 [+0000], Lorenzo Stoakes wrote:
> The code is littered with inscrutable and duplicative lockdep incantations,
> replace these with defines which explain what is going on and add
> commentary to explain what we're doing.
> 
> If lockdep is disabled these become no-ops. We must use defines so _RET_IP_
> remains meaningful.
> 
> These are self-documenting and aid readability of the code.
> 
> Additionally, instead of using the confusing rwsem_*() form for something
> that is emphatically not an rwsem, we instead explicitly use
> lock_[acquired, release]_shared/exclusive() lockdep invocations since we
> are doing something rather custom here and these make more sense to use.
> 
> No functional change intended.

This is just "replace rwsem macro with our own macro" which is fine. The
subject confused me because I expected something new to see ;)

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
