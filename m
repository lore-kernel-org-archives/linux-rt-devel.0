Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5144A3F1;
	Fri, 28 Aug 2026 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918082; cv=none; b=Hb1TU+0/t8GTKWab95lC3pm91D1ba/bDwnFtlcDrgGCpjE3TRaIPLexU3nMSgEsdnAL5SOikN+4STG5KexNAgWM7ZUWyyG3/zsraNH5LbQ42lID5Wq/UCQ8symwVs0iXWNjVRMBS3ZuLzZHP6r/CDRejtJoFqSDu+RP57ua8tPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918082; c=relaxed/simple;
	bh=/lOeYdMQM0yEpqRm+8VJ/e9jItYU1+vsePznvGbz10E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vbg1/YmRuRV48bLfLtv/r+2QE9gi1f0BmrMLrIzlo6CRxNcxEvUF1h4a/vNMaiWrIu8/c1P1FUCi+xrdqj5XF+O+SSLSQmwnu2/BUsjmbqeWbu1XAUUEqaNHlif1KUYsGpkDUGS+gz30lJ+M4yY9DyGTUpZGAZ0yZfS9Dvj47dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g5q3o2RC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5q3o2RC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/lOeYdMQM0yEpqRm+8VJ/e9jItYU1+vsePznvGbz10E=; b=g5q3o2RCbyi+Yqbp+LTKaPTquE
	7gXYHP3tdr0knxX02PNNzCPOBFWn57YdhfVMe2wVBn0jGTz5C70WZiFqi6q+gGpJPkpRmT276v/iI
	Nx0JCxTzmg7piqalBDEI5CPqK/IwzqOegpNF6bmFCbfFSyS7FPEGTGn4XOICrl7KJogrp6jKLKtiQ
	BFLUSYdoBlhM6+BShUVl6Sc7u4HOo0ZtjEDUm1F2Mv+GRSw0GDtY23DSYzC52ibhjXBiKIkIMO7OJ
	m942aboClPHVMssGPyAA7ZQN5VBksW6w6zHJtn0ckV3dbahbmennTJsAMre8Tcbx+K52/+vDwChBY
	c6XrVZ4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzv9w-0000000EdPK-1I3d;
	Fri, 28 Aug 2026 11:54:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4D3CF30030F; Fri, 28 Aug 2026 13:54:10 +0200 (CEST)
Date: Fri, 28 Aug 2026 13:54:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Stevens <stevensd@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, suleiman@google.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Message-ID: <20260828115410.GL687043@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827232948.2520558-7-stevensd@google.com>

On Thu, Aug 27, 2026 at 04:29:44PM -0700, David Stevens wrote:
> A new TASK_STACK_RECLAIM state is introduced for tasks that are
> blocked waiting for the stacks to be repopulated.

Not yet read the full patch, but *why*.
