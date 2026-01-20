Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62009429801;
	Tue, 20 Jan 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924420; cv=none; b=Fiw7tqKv19lAyo637XzlTH1CBrf6obppDLLfv9lhAnk2+hcnwjOFRd8LeIBLUllt75vPrh8N2L5MD28c3X+y8SZem9vMl0Wyjx5cFU7/T3iWZLBH6eeCjD6osLpU8TUOs3eppcMsSUIoeYVYMp8n7it27QcbAFPVEomDUcfWKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924420; c=relaxed/simple;
	bh=ttf+N0kR3c58C8SYDnyBbTonPTv45YxeZLChEaJxV1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHbzzFgiTBxu3hQeeHc6nyH1veSnB2V5ojMCxQrXxJY8sSos5snx5HlKzBI0PRyTgqf83goCu1m53An6wpEGk82cE+X3DaOYn/LlbDc1v6gT7n6eZviY1OnqVVAfraQnrG3awBT5piDfuPms6m1zo0IzsMBpFMan4SXeAnzUy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYhAQvZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYhAQvZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A7BC16AAE;
	Tue, 20 Jan 2026 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924420;
	bh=ttf+N0kR3c58C8SYDnyBbTonPTv45YxeZLChEaJxV1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYhAQvZSSxVTiEsGz61MOiR6RsQ9DY5MaMOc/dFYQ4IlU/PV607XeGDMN6DC7l+U4
	 mXpE+pl5LzMScSRfXrIyNlhzsPhDiYawIy6J//lr+6Z0ozd4Pj3xCYk0n1CEkSdFdf
	 SHl/+DrMm/fVNmdtiB3BZFVuRobTbHsk9WtDWVZfj7c7EFZERRL8UYGffrh+qjJe1m
	 yH+HxtATKDsczqsX7mzoCrkLvEVdQAGE3pRLJmRBq8XJnhKkeub/EsYfojztxEVAQg
	 P3aFz1aLU/iRdBY8Pzd6pEfRxZ92u7PRpsxSjwK0Kpm6K7jNgNdxygWQ+1uDbQcFXx
	 0gjsYL4pzsZ0A==
Date: Tue, 20 Jan 2026 15:53:32 +0000
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	catalin.marinas@arm.com, akpm@linux-oundation.org, david@kernel.org,
	kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while
 splitting the linear mapping
Message-ID: <aW-k_D1Q8jpYMPoI@willie-the-truck>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck>
 <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>

On Tue, Jan 20, 2026 at 10:40:30AM +0000, Ryan Roberts wrote:
> On 20/01/2026 09:29, Yeoreum Yun wrote:
> > Hi Ryan
> >> On 19/01/2026 21:24, Yeoreum Yun wrote:
> >>> Hi Will,
> >>>
> >>>> On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
> >>>>> +static int __init linear_map_prealloc_split_pgtables(void)
> >>>>> +{
> >>>>> +	int ret, i;
> >>>>> +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> >>>>> +	unsigned long lend = PAGE_END;
> >>>>> +	unsigned long kstart = (unsigned long)lm_alias(_stext);
> >>>>> +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
> >>>>> +
> >>>>> +	const struct mm_walk_ops collect_to_split_ops = {
> >>>>> +		.pud_entry	= collect_to_split_pud_entry,
> >>>>> +		.pmd_entry	= collect_to_split_pmd_entry
> >>>>> +	};
> >>>>
> >>>> Why do we need to rewalk the page-table here instead of collating the
> >>>> number of block mappings we put down when creating the linear map in
> >>>> the first place?
> >>
> >> That's a good point; perhaps we can reuse the counters that this series introduces?
> >>
> >> https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/
> >>
> >>>
> >>> First, linear alias of the [_text, __init_begin) is not a target for
> >>> the split and it also seems strange to me to add code inside alloc_init_XXX()
> >>> that both checks an address range and counts to get the number of block mappings.
> >>>
> >>> Second, for a future feature,
> >>> I hope to add some code to split "specfic" area to be spilt e.x)
> >>> to set a specific pkey for specific area.
> >>
> >> Could you give more detail on this? My working assumption is that either the
> >> system supports BBML2 or it doesn't. If it doesn't, we need to split the whole
> >> linear map. If it does, we already have logic to split parts of the linear map
> >> when needed.
> > 
> > This is not for a linear mapping case. but for a "kernel text area".
> > As a draft, I want to mark some of kernel code can executable
> > both kernel and eBPF program.
> > (I'm trying to make eBPF program non-executable kernel code directly
> > with POE feature).
> > For this "executable area" both of kernel and eBPF program
> > -- typical example is exception entry, It need to split that specific
> > range and mark them with special POE index.
> 
> Ahh yes, I recall you mentioning this a while back (although I confess all the
> deatils have fallen out of my head). You'd need to make sure you're definitely
> not splitting an area of text that the secondary CPUs are executing while they
> are being held in the pen, since at least one of those CPUs doesn't support BBML2.
> 
> > 
> >>
> >>>
> >>> In this case, it's useful to rewalk the page-table with the specific
> >>> range to get the number of block mapping.
> >>>
> >>>>
> >>>>> +	split_pgtables_idx = 0;
> >>>>> +	split_pgtables_count = 0;
> >>>>> +
> >>>>> +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> >>>>> +						    &collect_to_split_ops,
> >>>>> +						    NULL, NULL);
> >>>>> +	if (!ret)
> >>>>> +		ret = walk_kernel_page_table_range_lockless(kend, lend,
> >>>>> +							    &collect_to_split_ops,
> >>>>> +							    NULL, NULL);
> >>>>> +	if (ret || !split_pgtables_count)
> >>>>> +		goto error;

Just noticed this, but why do we check '!split_pgtables_count' here?
if the page-table is already somehow mapped at page granularity, that
doesn't necessarily sound like a fatal error to me.

> >>>>> +
> >>>>> +	ret = -ENOMEM;
> >>>>> +
> >>>>> +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
> >>>>> +				  GFP_KERNEL | __GFP_ZERO);
> >>>>> +	if (!split_pgtables)
> >>>>> +		goto error;
> >>>>> +
> >>>>> +	for (i = 0; i < split_pgtables_count; i++) {
> >>>>> +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
> >>>>> +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> >>>>> +		if (!split_pgtables[i])
> >>>>> +			goto error;
> >>>>
> >>>> This looks potentially expensive on the boot path and only gets worse as
> >>>> the amount of memory grows. Maybe we should predicate this preallocation
> >>>> on preempt-rt?
> >>>
> >>> Agree. then I'll apply pre-allocation with PREEMPT_RT only.
> >>
> >> I guess I'm missing something obvious but I don't understand the problem here...
> >> We are only deferring the allocation of all these pgtables, so the cost is
> >> neutral surely? Had we correctly guessed that the system doesn't support BBML2
> >> earlier, we would have had to allocate all these pgtables earlier.
> >>
> >> Another way to look at it is that we are still allocating the same number of
> >> pgtables in the existing fallback path, it's just that we are doing it inside
> >> the stop_machine().
> >>
> >> My vote would be _not_ to have a separate path for PREEMPT_RT, which will end up
> >> with significantly less testing...
> > 
> > IIUC, Will's mention is additional memory allocation for
> > "split_pgtables" where saved "pre-allocate" page tables.
> > As the memory increase, definitely this size would increase the cost.
> 
> Err, so you're referring to the extra kvmalloc()? I don't think that's a big
> deal is it? you get 512 pointers per page. So the amortized cost is 1/512= 0.2%?

Right, it was the page-table pages I was worried about not the array of
pointers.

> I suspect we have both misunderstood Will's point...

I probably just got confused by linear_map_free_split_pgtables() as it
has logic to free unused page-table pages between 'split_pgtables_idx'
and 'split_pgtables_count', implying that we can over-allocate.

If that is only needed for the error path in
linear_map_prealloc_split_pgtables(), then perhaps that part should be
inlined to deal with the case where we fail to allocate part way through.

Will
