Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC70395723;
	Thu, 22 Jan 2026 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115327; cv=none; b=BOdSQisQ30732lhq4JcvpiZ7HD5kw23f8eaC2Xwclc3hDR6j5GJ56IUQekr2YWPL7w8qIXeqbyUpDXFGIpcfAHdm9x5Ymi+RBwE2xdtT3nMGzIVEUZ6GiAD+HlhycN3Hu0n8cWlpRc30idr34AVhVrHsWDsbiJnryVLO0Vh79VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115327; c=relaxed/simple;
	bh=3RonE8sCwdveY09Rm5eaaBB5Ddd2WM38NcpvZaK6rFI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cxL0z0ksffMlzkzO0IdM6ynxuUxM+1SPLDRDVaiy8WXMGAuZwcydGDTEQ/LnWntk4mmd1bMIpp3LoS3UsvHPh7DGNFVsYZQVorhZUANGYW52e0zgOmkDIJgiwf1Qv0BN6IhGfZMyuGWDyk6+TXfJM7suJmAcgg1yZRgRX6LO+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=orX3vY6N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="orX3vY6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EE2C116C6;
	Thu, 22 Jan 2026 20:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769115325;
	bh=3RonE8sCwdveY09Rm5eaaBB5Ddd2WM38NcpvZaK6rFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=orX3vY6N+v2bBEqJf/x3rBu+MQkrbKH76zrEvIeO/Ltd+mJYqg+/KAwuVnrgGQyjy
	 sErY3D3bSldRFWNzww9AlX2XJ+MDHT0VA5lGqETZEIxkdkDCUeHo+MGL3SB67con2U
	 9FEV4KOcq6NEqSw801uDKbVTutkHYIYCWpzetXqQ=
Date: Thu, 22 Jan 2026 12:55:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand
 <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Michal Hocko
 <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 06/10] mm/vma: clean up __vma_enter/exit_locked()
Message-Id: <20260122125529.1f4a1806fd918155e0a5824b@linux-foundation.org>
In-Reply-To: <CAJuCfpFFW_tcHPMtryoVcSKigEGZxfn3Bz=8BUtrJj8kgEWDJA@mail.gmail.com>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
	<f1981963e3c9421b6ffef19f15d87953895cd0b5.1769086312.git.lorenzo.stoakes@oracle.com>
	<CAJuCfpFFW_tcHPMtryoVcSKigEGZxfn3Bz=8BUtrJj8kgEWDJA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 12:15:20 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> > +       /* vma should remain attached. */
> > +       if (locked)
> > +               WARN_ON_ONCE(__vma_exit_exclusive_locked(vma));
> 
> I'm wary of calling functions from WARN_ON_ONCE() statements. If
> someone decides to replace WARN_ON_ONCE() with VM_WARN_ON_ONCE(), the
> call will disappear when CONFIG_DEBUG_VM=n. Maybe I'm being paranoid
> but it's because I have been bitten by that before...

Yes please.  The elision is desirable if the function has no side-effects, but
__vma_exit_exclusive_locked() changes stuff.

Someone(tm) should check for this.  A pathetically partial grep turns
up plenty of things:

mm/slab_common.c:	if (head && !WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&head_gp_snap)))
mm/slab_common.c:	if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
mm/page-writeback.c:		WARN_ON_ONCE(atomic_long_add_return(delta,
mm/page_isolation.c:		WARN_ON_ONCE(!pageblock_unisolate_and_move_free_pages(zone, page));
mm/page_alloc.c:	VM_WARN_ONCE(get_pageblock_isolate(page),
mm/numa_memblks.c:	WARN_ON(memblock_clear_hotplug(0, max_addr));
mm/numa_memblks.c:	WARN_ON(memblock_set_node(0, max_addr, &memblock.memory, NUMA_NO_NODE));
mm/numa_memblks.c:	WARN_ON(memblock_set_node(0, max_addr, &memblock.reserved,
mm/zsmalloc.c:		WARN_ON(!zpdesc_trylock(zpdesc));

