Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86303033FA;
	Mon, 19 Jan 2026 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843743; cv=none; b=BPSXUxJMvy4pzKWNhG458WmSKRK5TUU3WRb3jbyzpXffabwJuPXseoSaBt9wg2wYZ46AP3WEq7Q3hxk6FYtfO3DDMmjSWFqWEMR+PZMwoqntS7MQ8zw7Ar90+RFKgdm2QjJbz+h613XGpUZdq12MzpSQ7HCLjNeu++ajCzOLGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843743; c=relaxed/simple;
	bh=VSaRBPhMwDUDvys3EnSvaAtLjqimGoG5C1rbWN41zss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRG9s8jZkSTtZWS5JQA7hOMUq826JDi0C+ZBviL/5qiuryKTUzM0ZFqQ+RMOZRZcvismpgr1MBTQfAW86RRSl332LMuw8gU7ZKh/9dnN+zoihTWQPwmne0wpK/nF5sXlsbghgKQodTEa8u+ZArukEhECn01/59lOZ67ZJ3pji0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQQViHD3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQQViHD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E04DC116C6;
	Mon, 19 Jan 2026 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843742;
	bh=VSaRBPhMwDUDvys3EnSvaAtLjqimGoG5C1rbWN41zss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQQViHD3Omr6dYepJRuFBaBqjCLsKYGcd4a4bTlRtVMELBDHhMA91ANBQANlFcoFV
	 hgIWgykCS2f3erLk0fpWpiC4klD/+2p5UFne9yCt4YzKgcBhKSfFeRVuIWg+cJ2rVV
	 yvgSi2eFzPxyEuoD0A+KBSGbiWJ8qDcBW+xCUDQGJ+UdUuhh3l4UfAkad7ecVecLND
	 XkNI35ireWIn7D66fFHmF5O9FktztlY4gXeXfMDt7qrC1TKoMg9SwE8TCb+qCF07Eh
	 92zYn7/qNa3efLLc66ad6PodMRWdOTV0K/rQSw4S9U7Qmk55isDPGLRcMkeMqj+7Cj
	 s7O2mWA6IA+bA==
Date: Mon, 19 Jan 2026 17:28:55 +0000
From: Will Deacon <will@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, catalin.marinas@arm.com,
	ryan.roberts@arm.com, akpm@linux-oundation.org, david@kernel.org,
	kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while
 splitting the linear mapping
Message-ID: <aW5p1ylQBNXTEmmq@willie-the-truck>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105202328.2418990-3-yeoreum.yun@arm.com>

On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
> +static int __init linear_map_prealloc_split_pgtables(void)
> +{
> +	int ret, i;
> +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> +	unsigned long lend = PAGE_END;
> +	unsigned long kstart = (unsigned long)lm_alias(_stext);
> +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
> +
> +	const struct mm_walk_ops collect_to_split_ops = {
> +		.pud_entry	= collect_to_split_pud_entry,
> +		.pmd_entry	= collect_to_split_pmd_entry
> +	};

Why do we need to rewalk the page-table here instead of collating the
number of block mappings we put down when creating the linear map in
the first place?

> +	split_pgtables_idx = 0;
> +	split_pgtables_count = 0;
> +
> +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> +						    &collect_to_split_ops,
> +						    NULL, NULL);
> +	if (!ret)
> +		ret = walk_kernel_page_table_range_lockless(kend, lend,
> +							    &collect_to_split_ops,
> +							    NULL, NULL);
> +	if (ret || !split_pgtables_count)
> +		goto error;
> +
> +	ret = -ENOMEM;
> +
> +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
> +				  GFP_KERNEL | __GFP_ZERO);
> +	if (!split_pgtables)
> +		goto error;
> +
> +	for (i = 0; i < split_pgtables_count; i++) {
> +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
> +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> +		if (!split_pgtables[i])
> +			goto error;

This looks potentially expensive on the boot path and only gets worse as
the amount of memory grows. Maybe we should predicate this preallocation
on preempt-rt?

Will
