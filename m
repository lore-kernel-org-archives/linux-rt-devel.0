Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB343553D
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Sep 2026 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424386; cv=none; b=KtrJAhE6l7x9GHxfhCmgbeVw8e83wAIqykxhQCc1Te26Tl6SIWHV864yyEEU3yJK86aT4CDxBWoFfrhS4K2sxNzuazUxQ9OGEwQ4YQWi4aquHeMXyMG0RjcXw7MH0BlOOwVr7Ah+hmxmwmAtL3frN1iwNTc6BVi3NgxMUwot3wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424386; c=relaxed/simple;
	bh=C1+RlBHvN9fvzT0b4kNv62X9v1GMI5wMZBpkbnRiPgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agNNt+I+VmYtqvd+gLK6e7ZrPYczag7QflgsjZ2yrUwZNtv/rzquBfK8WbjipCvmFPX51VJ43IusP/mNvLwQQrP60IXhM1B5I0qlWqLe2EsZe1T0JWY3m5rCAouzEVt/4mH02ur/GLMdj86R7qCPVr2WRIqxlNZgWm6Z1aF626g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vUa9quOt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pDYT7mMj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vUa9quOt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pDYT7mMj"
Date: Thu, 3 Sep 2026 10:33:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788424383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1+RlBHvN9fvzT0b4kNv62X9v1GMI5wMZBpkbnRiPgg=;
	b=vUa9quOtdWvGrJdQKg9qmPHqIX0hijGLSqebL5wOszU/E+xMyu9t3mO/BgVc22rrwQBzE0
	2gtj5wZCMj1nMiiKxwnK5qMXwGmtBB2YBp7gL+0Slq4S9V2QyhqRYHlTGjQlxltu3KZqx3
	KWDuI+MafYFwR5xQdVu7oZRZsTWLfG38XWs0zJGjWOC+GIkSqJQad4NseEvESz1mv+X2MN
	GVTzjrJbGtMcpNgD27buFrkZeV5sb6a4iPf1BLPXRpwjdXW5AqYHzNJkTi/P6H4isoqjp2
	iTfDkeW0OaKj2C4QvA5Y4ExsyO7duoV0B58XB0UpvaKT6VQEafBV+DqNzM1wJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788424383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1+RlBHvN9fvzT0b4kNv62X9v1GMI5wMZBpkbnRiPgg=;
	b=pDYT7mMjHy+UmJD526epCpQMfULaZm9VG/JxzkXoQyK86LxfyaVsdICQtOpNwZDkryABsO
	kEso24WTDRccffBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	syzbot+acf142088e0182172e58@syzkaller.appspotmail.com,
	ThangNN99 <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH] mm/slab: disallow kfree_rcu_sheaf() on PREEMPT_RT again
Message-ID: <20260903083301.2aPFamvg@linutronix.de>
References: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
 <20260901073339.uyKHXWCX@linutronix.de>
 <47aa459f-27d5-4b2f-9eb9-36ebca63d890@kernel.org>
 <20260902104143.j8BXrjKq@linutronix.de>
 <1846af86-cf55-456d-9eca-975a88777a40@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1846af86-cf55-456d-9eca-975a88777a40@kernel.org>

On 2026-09-02 16:13:30 [+0200], Vlastimil Babka (SUSE) wrote:
> >> Per sashiko review it's actually bad too under the pi_lock, because
> >> GFP_NOWAIT means __GFP_KSWAPD_RECLAIM which can mean wakeup_kswapd() a=
nd
> >> thus also need scheduler locks. And it's not a PREEMPT_RT-only issue...
> >=20
> > \o/
>=20
> More like /o\

Yes, true. But it is not longer an RT-only issue.

> >> > It could have a pool of X
> >> > and if it runs out, it runs out and waits until the clean up process
> >> > feeds the used sheafs back. There is fallback and the run out is not=
 the
> >> > usual case.
> >>=20
> >> I'd rather not invent new pools, since there's fallback and the sheaf+=
barn
> >> is already a pool. Could be enough to make sure the allocation attempt=
 is
> >> safe, i.e. use only __GFP_NOWARN.
> >=20
> > So we avoid the allocation and just add it to the sheaf+barn and this is
> > it?
>=20
> We don't need to avoid the allocation attempt if it's done in a safe way?

If it safe and does not not increase the free-latency too much then it
is fine.
Now that I look at the kvfree_call_rcu(), there a timer, hrtimer,
workqueue=E2=80=A6 Oh. And a __get_free_page().

> Note the new sheaf can be also served from its kmalloc slab almost
> immediately, going all the way to page allocator should be very rare.
> But if we stopped doing that sheaf allocation attemps completely, we could
> easily end up having long bursts of all kfree_rcu() being deferred.

Sure. If you have memory around then there is nothing wrong with using
it. In my naive thinking I assumed it should be enough to fill the
buffers and in times of bursts having plenty of RCU callbacks which are
throttled.

Sebastian
