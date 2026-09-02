Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E742047A
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Sep 2026 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345708; cv=none; b=UOehFrGVzmg/HhzyEnWwZGtMYHMT2V/Q+JPKi5HOd+r4AaPQrQ7ctqKgEQh1dlkD12mrWZ2V9cEAqrAiamCO5qQr+NBh+uhK4jQxZEwFN4Ylg2qjxX+pVSLmkQI6uBzgnY4vC+eM6AmyY/eBTCO+oPM24BN96x2LtxVlgG5QnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345708; c=relaxed/simple;
	bh=gE3q2mnuqp4VNjrudaIOU10zmf2ptLy8FzzNkjTFj80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLVcoZxd8xZKuw3oqChMxg3B26+qL+YzAeL7KsHaTQUFycxIUZkb4+EdKzTGQyPQgRGZWNeyrZg6l5BqiU1duDdDL4uM7+Qo5aTt/t89G02hatg/XBXQZPGE5JMeFNgOyvjQV9XIqE5AXGA43Or6hUvhAneQZ5VNPVEHw246VIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3aLE5/+J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o0FH9ot0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3aLE5/+J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o0FH9ot0"
Date: Wed, 2 Sep 2026 12:41:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788345705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gE3q2mnuqp4VNjrudaIOU10zmf2ptLy8FzzNkjTFj80=;
	b=3aLE5/+Jn9kHSSfphKTcjdpJgFAAB6ldENs61d6YnWSU8O51QNwxrMJa5Ci6jfH13Y07DW
	o2uKkK9kGBynnpJyOAT1VjJpQ0v776RTbgOPYLzB72bhe+86ECX5LQnrxT3mTDflE9meAI
	UiaztD/cdw472KOdFUhLLWjFGjLzlu4Y/3Dc02wMttwM38daq0htwYk05M5t1185Ys9ui7
	LbAHj++23iL41iFHD2FLXgeQUQyrc2SDaBzKG/w2344Zz4ezWKt4sJokS4QtWunqJf9Hvd
	Tuj9a/lmZiujhoXkNsufwdBzuE7+IaAmNTCiGC4QmxuaIsUK9s13sZUzs8IZ9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788345705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gE3q2mnuqp4VNjrudaIOU10zmf2ptLy8FzzNkjTFj80=;
	b=o0FH9ot0MYitBBSOsIppqZaOeaITX1sSjB7A4OqOE6H7yx2LjGC2RoL6OZjnJeFkz527zD
	6+Ku5WZ/S/jm1WBw==
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
Message-ID: <20260902104143.j8BXrjKq@linutronix.de>
References: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
 <20260901073339.uyKHXWCX@linutronix.de>
 <47aa459f-27d5-4b2f-9eb9-36ebca63d890@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <47aa459f-27d5-4b2f-9eb9-36ebca63d890@kernel.org>

On 2026-09-01 15:59:09 [+0200], Vlastimil Babka (SUSE) wrote:
> On 9/1/26 09:33, Sebastian Andrzej Siewior wrote:
> > On 2026-08-31 18:02:38 [+0200], Vlastimil Babka (SUSE) wrote:
> >> This partially reverts commit 2a8bb29ec9b2 ("mm/slab: allow
> >> kfree_rcu_sheaf() on PREEMPT_RT"). It was based on an assumption that
> >> local_trylock() is safe on PREEMPT_RT from any context.
> > =E2=80=A6
> >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >=20
> >> ---
> >> Incidentally I have posted a RFC [1] that leads to replacing that
> >> kfree_rcu() from set_cpus_allowed_force() but now after back from
> >> vacation I need to check the feedback and based on this bug report I c=
an
> >> already see it makes the same bad assumption that trylock is fine.
> >=20
> > free_to_pcs() has still this trylock.
> >=20
> > What I am not so sure how good is that kfree_rcu_nolock() may allocate
> > memory for the sheaf if there is none around.
>=20
> Per sashiko review it's actually bad too under the pi_lock, because
> GFP_NOWAIT means __GFP_KSWAPD_RECLAIM which can mean wakeup_kswapd() and
> thus also need scheduler locks. And it's not a PREEMPT_RT-only issue...

\o/

> > It could have a pool of X
> > and if it runs out, it runs out and waits until the clean up process
> > feeds the used sheafs back. There is fallback and the run out is not the
> > usual case.
>=20
> I'd rather not invent new pools, since there's fallback and the sheaf+barn
> is already a pool. Could be enough to make sure the allocation attempt is
> safe, i.e. use only __GFP_NOWARN.

So we avoid the allocation and just add it to the sheaf+barn and this is
it?
=20
Sebastian
