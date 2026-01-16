Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A988331A07B;
	Fri, 16 Jan 2026 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576344; cv=none; b=nd8V99AM4xM3qmRwB4dpc2XsSFgy14CJAMHeYHJ6uP62A2TNx3TNJtHW6fiF9Prr6eRpnvo+t18MYuYgLIRZKq0jSceIuFWFvtDzO8Xv2EZY7MWPxJ/sdMCm1ygRCIVbOA9W8HJOjSGSRbSS9Lak81Kk7ywG3FbC9eZOshmn4SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576344; c=relaxed/simple;
	bh=FiWguisrE/Lc/lx3/blCyAIEWDY/Lf/gI09UjaLWNL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oep71EF9F0/hQsgTjpRXAEsLUvno4hmrO0osdNutL5dJbMGrbKkmCf1Cs+IMDL2d283gBzdkRZ1XGPZMdHvtLg/Hv1OJyknht2VkHMwDCq/4vg7BVF5On3B2JD9h6FYBuLRjgcdeMFgS7UwcO748PtB2Zj6sMtVEtlyAkyHi1KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BABgMMte; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BABgMMte"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8jwwPm/+NByjfvPSjDi/ub7pXS4EPNaeT4AY2tDnSHI=; b=BABgMMteKKeUC8CZLqU8YLz6sJ
	gKuTkGksLV2DmzSP6lF43jBJ8USZk6Pi0rTcceIdMa8mmKHSVwGoS2Vn7tbRwj3kKizqiLyTRxvY+
	p1xY1o46P1n25HZMb4xw8chd18b+5RKuqZett5murO73BYEDTFUrW6srhbgF3yiXbwxg08KgsTZju
	t0Zn4qm8k3fjc+MTcdTagK6xbBefacu4xvdt8V3wpFaOYy02z2+HRGv2nOc9x7/q8eSjmIMwQu4iE
	GoSBFysx5Y46/NuY/mtY6lkqmME+uSDwqveV4iiZ84V0l6dohNmCMVdogZxBgxd6Rna6Hy7Qn+OV4
	LSFJrSww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vglUm-00000009VzQ-3fYp;
	Fri, 16 Jan 2026 15:12:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E716B3005E5; Fri, 16 Jan 2026 16:12:15 +0100 (CET)
Date: Fri, 16 Jan 2026 16:12:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND 1/3] locking: add rwsem_is_write_locked(), update
 non-lockdep asserts
Message-ID: <20260116151215.GH831050@noisy.programming.kicks-ass.net>
References: <cover.1768569863.git.lorenzo.stoakes@oracle.com>
 <8e343ccb9319433364f5949a69519f1bb521fc8a.1768569863.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e343ccb9319433364f5949a69519f1bb521fc8a.1768569863.git.lorenzo.stoakes@oracle.com>

On Fri, Jan 16, 2026 at 01:36:45PM +0000, Lorenzo Stoakes wrote:
> As part of adding some additional lock asserts in mm, we wish to be able to
> determine if a read/write semaphore is write-locked, so add
> rwsem_is_write_locked() to do the write-lock equivalent of
> rwsem_is_locked().
> 
> While we're here, update rwsem_assert_[write_]held_nolockdep() to utilise
> the rwsem_is_[write_]locked() helpers directly to reduce code duplication,
> and also update rwsem_is_locked() to take a const rwsem and return a
> boolean.

There is a long history of abuse of _is_locked() primitives. I don't
suppose you read the email thread that led to
rwsem_assert_held_*_nolockdep() by any chance?
