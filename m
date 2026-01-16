Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A13303A07
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579068; cv=none; b=Jl0bwI+53WRntMB3RW4PewSxFoRYJlf9UnKY5mwlCKggC1hm/LODo68Ga0Ri8ro5uWEXCvIWzK2c4U5XBjMvY7Tj1LTVT69jRGp21hBkAkI0LMBdDDADO6aXM8sBUpLC91zdOBVcHenjMV11IdObn7kGJVltJMqyc29mEcXQBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579068; c=relaxed/simple;
	bh=n9etu3sCjCjTSqJooigB4P2AvUUWV708r9U+I1MOI/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+au50rZHehYUJfYrjWH4QSCO8wPBGZNjd6TYMwyMkrLClSkFNnj2DS1f5WcBXsSqnmhd+RwqLcc6Zb//PjvhQuVKxWpBaHM9FXkLdOJ9UbCuSAEXKqv/O4j72HcD2CEg7+bVfvf06xnv36KL3eLRCBrHSAJbDY1BUkKSEXY9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vR/nqsXE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEt4DiTq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vR/nqsXE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEt4DiTq"
Date: Fri, 16 Jan 2026 16:57:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768579064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9etu3sCjCjTSqJooigB4P2AvUUWV708r9U+I1MOI/Y=;
	b=vR/nqsXEkrmj920u4bSRlsg8D3RS5CLxH6+3Y3x4mGfnNhgVONyOrOCuM5Vwi6Nf+MOwvW
	hbzgjfqAfJfMQpEnXb/aoJCtEfA4H3dy4czCbD1dR4AG2dMpcygEITq80PBX9lGmLeK87u
	CXk9oyHMgXWQkzZb7t/1OYdOFV0d6+19Fd5gKygD/xly8P3t07enM6sMkn21vpF8tURjCn
	vw1eoPKrScIxMy8PV/NiqNQK694r61tw1HG5gmmrFWYf+xP4NbvZuJMWSO4VBg0hDeTjC+
	83zcWJ/4FQZAjTpPGfMG5bVz3myy4MclmipJBnLWwVj6xKFdwZoXAGM2MqelYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768579064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9etu3sCjCjTSqJooigB4P2AvUUWV708r9U+I1MOI/Y=;
	b=gEt4DiTqASRp7Z/aRq58bV9igLDbT8eP3Ad+TbHeuHcOcmClxTSb4LPcO0wCm9loMmeqGl
	M4ZTRH8MP0SZRwBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND 1/3] locking: add rwsem_is_write_locked(), update
 non-lockdep asserts
Message-ID: <20260116155743.AuMKcTAO@linutronix.de>
References: <cover.1768569863.git.lorenzo.stoakes@oracle.com>
 <8e343ccb9319433364f5949a69519f1bb521fc8a.1768569863.git.lorenzo.stoakes@oracle.com>
 <20260116151215.GH831050@noisy.programming.kicks-ass.net>
 <99818e30-9f88-4751-af82-0bed019156eb@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99818e30-9f88-4751-af82-0bed019156eb@lucifer.local>

On 2026-01-16 15:50:24 [+0000], Lorenzo Stoakes wrote:
> No, but we need to be able to assert that one of two locks are held and we
> don't want the failure of one being held to cause an assert when the other
> isn't.

But why don't you use the lockdep based check? That assert only ensures
that it is locked at the time you did the check. This does not mean you
are owner - it could be owned by another task which is unrelated to your
cause.

Sebastian
