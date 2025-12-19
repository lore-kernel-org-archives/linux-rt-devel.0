Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10C2DE70C
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Dec 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766167372; cv=none; b=CINDRL2u2RtMi3A4/5nn3sDf0YQE00qUlJTJ7xOO5oB3ybc10r0nJu37Ck8NlHtSl89k3W25LdKFF8rXGIyw1u225++DvcOXtKlyCCSF2YqXX4bgVfVRYfg9XjZdc6u4l1HDSWfKpXe0zC4YUPBYgrmCSpM4/l4Ce0izENjWW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766167372; c=relaxed/simple;
	bh=bmn4889U3wykiTCgAvaKC2q4bV6OpRmg2QNvSEwyvKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAAu6zMu0tcZBTNtrQNR+GUIS3qNXFeSRD3qx/oFH4tyuXzliIbl5DZYIvq5GlSvt8VJV7IXkMK4i+wMjuvb3EhA2E2OXYclni0EA9MvjlaScePhY+FKqt1nq51FnCtr5nDQ0eydnD5mLV8hbEfCdZ0iTbEBygCwy4NvSBjdR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5ABVsap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5ABVsap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766167370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH+aI24H1Mv6F+Km0lz8E8kB3nbFXN5ma2j3LpWd/jU=;
	b=e5ABVsapiEJlCRseMYkpzQDgAIrIu0eeHPZrxobSRw9BJ8kw3/2TJZPLfBH5cyNnrFIyBV
	PbLN+sWhCq895v647gV8AGyladP1t8QPghKKa2VpOsCUYxYrUtntpUrv0+UTfsJDQIU7c0
	4b+ebrHN4PP6YsCphzpB8u14jG1jaVI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-3P4v9Qg9Ng6HoIUWYYPajA-1; Fri,
 19 Dec 2025 13:02:46 -0500
X-MC-Unique: 3P4v9Qg9Ng6HoIUWYYPajA-1
X-Mimecast-MFC-AGG-ID: 3P4v9Qg9Ng6HoIUWYYPajA_1766167364
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BCA71956046;
	Fri, 19 Dec 2025 18:02:43 +0000 (UTC)
Received: from localhost (unknown [10.22.88.80])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04A3519560B4;
	Fri, 19 Dec 2025 18:02:41 +0000 (UTC)
Date: Fri, 19 Dec 2025 15:02:40 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
Subject: Re: [PATCH] slab: fix kmalloc_nolock() context check for PREEMPT_RT
Message-ID: <aUWRr1NI4VR9i7pj@redhat.com>
References: <20251219085755.139846-1-swarajgaikwad1925@gmail.com>
 <6fcfe0cc-3826-42c2-9c54-c127dc8379e1@suse.cz>
 <aUVTJyd74OoCtSyN@redhat.com>
 <p2kiryxpwq7iu7x6jq65kzff4uivbdd3cne7rizax5b33ce5yx@nr5hfrnfevxy>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p2kiryxpwq7iu7x6jq65kzff4uivbdd3cne7rizax5b33ce5yx@nr5hfrnfevxy>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Dec 19, 2025 at 11:22:02PM +0800, Hao Li wrote:
> On Fri, Dec 19, 2025 at 10:29:11AM -0300, Luis Claudio R. Goncalves wrote:
> > On Fri, Dec 19, 2025 at 10:31:55AM +0100, Vlastimil Babka wrote:
> > > On 12/19/25 09:57, Swaraj Gaikwad wrote:
> > > > On PREEMPT_RT kernels, local_lock becomes a sleeping lock. The current
> > > > check in kmalloc_nolock() only verifies we're not in NMI or hard IRQ
> > > > context, but misses the case where preemption is disabled.
> > > > 
> > > > When a BPF program runs from a tracepoint with preemption disabled
> > > > (preempt_count > 0), kmalloc_nolock() proceeds to call
> > > > local_lock_irqsave() which attempts to acquire a sleeping lock,
> > > > triggering:
> > > > 
> > > >   BUG: sleeping function called from invalid context
> > > >   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6128
> > > >   preempt_count: 2, expected: 0
> > > > 
> > > > Fix this by also checking preempt_count() on PREEMPT_RT, ensuring
> > > > kmalloc_nolock() returns NULL early when called from any
> > > > non-preemptible context.
> > > > 
> > > > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> > > > Reported-by: syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=b1546ad4a95331b2101e
> > > > Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
> > > > ---
> > > > Tested by building with syz config and running the syzbot
> > > > reproducer - kernel no longer crashes.
> > > > 
> > > >  mm/slub.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > index 2acce22590f8..1dd8a25664c5 100644
> > > > --- a/mm/slub.c
> > > > +++ b/mm/slub.c
> > > > @@ -5689,8 +5689,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> > > >  	if (unlikely(!size))
> > > >  		return ZERO_SIZE_PTR;
> > > > 
> > > > -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> > > > -		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
> > > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq() || preempt_count() ))
> > > 
> > > AFAICS we can just simplify that to preempt_count() then, since in_nmi() and
> > > in_hardirq() both are a special cases of that.
> > > 
> > > Any comment from RT folks please?
> > 
> > Maybe, for the purpose of this change, using in_atomic() or !preemptible()
> > would be a bit more descriptive, as both macros check preempt_count()?
> 
> Hi,
> 
> I might be misunderstanding the situation, but my current understanding
> is as follows:
> 
> __might_sleep will report this BUG if it is called with IRQs disabled or
> in atomic context. Therefore, to avoid this BUG, it seems necessary to
> check preemptible(), since in_atomic() alone does not appear to be
> sufficient.

You are correct. I focused in the condition proposed (for which
preempt_count() was enough) and missed the real requirement.
 
> As a side note, once Vlastimil's "sheaves for all" branch is merged into
> mainline, the local_lock_cpu_slab(s, flags); statement that currently
> triggers the BUG is expected to be removed. Furthermore, the entire
> nolock path in SLUB is planned to be implemented using trylock
> semantics, which should eliminate the possibility of sleeping, even on
> RT kernels. At that point, it seems we would only need to guard against
> deadlock risks from NMI and IRQ, so this condition might need to be
> reverted to in_nmi() || in_hardirq() again.
> 
> Please let me know if I'm missing something here or if there are
> additional constraints I haven't considered. I'd appreciate any
> corrections or further insights.
> 
> Thanks
> 
> > 
> > Luis
> >  
> > > > +		/*
> > > > +		 * kmalloc_nolock() in PREEMPT_RT is not supported from
> > > > +		 * non-preemptible context because local_lock becomes a
> > > > +		 * sleeping lock on RT.
> > > > +		 */
> > > >  		return NULL;
> > > >  retry:
> > > >  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > > > 
> > > > base-commit: 559e608c46553c107dbba19dae0854af7b219400
> > > > --
> > > > 2.52.0
> > > > 
> > > 
> > > 
> > ---end quoted text---
> > 
> > 
> 
---end quoted text---

