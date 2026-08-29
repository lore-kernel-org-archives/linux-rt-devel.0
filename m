Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4BE356755;
	Sat, 29 Aug 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787993030; cv=none; b=jR5sUaBnatst4sV90Nhwa2OOQ02ggiTk+Lzjjx23kX+2YRXi+5wNSwk1js9FsA3jZXcPHUYQYddCs6HYX0KSPwqTxEA4+K3Ah51f/Zrw98FSpLYeBXH4FruDA5xPKAg1Wjvg79f+EvVSumL8ZFME2bOtG/JdE5ytZ+QlRJedOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787993030; c=relaxed/simple;
	bh=x2zVC9edQ6JJXJ2K+hLc6Qkkokuc7cl6FdxJo14qlR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsU7nPgnC6+L8kjDvilml5ax0FF5I0Hc/i8ueDsyOBKWxTtLxyV2R7/zyT85hFW3In9FAyMTcIBtPhLhUojDm/qucWg45thxhbdcEMCHZdGT+IC7ZUREuSwBoZuvYxp/aHpD3Z4Cpikxp1sjhdL6w43mBbHP6VuznMyNq5JEqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZvkODfUj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZvkODfUj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eHtGfUyv+NDEIFhJ+rL3MIjkKe1E4CjtH7InBn8uMWg=; b=ZvkODfUjRXxzIXS3gx3ArInBac
	P7e8ollFJxQa2Sca0uHxuOn78euth+7/OAAiWvXv6gEwDtQknf7cRvXWnrXRC2yeBBdca7QE2cGUH
	JLa79YPVenz9rxuNyOEFGhm+ccbJeNvWEB/Z9nIUAC1YCfAmY55xMmC+9uUBr3nXDppmCSjZZpwnO
	vlJJLLxWzK+kbzE/MwrXBaW/lg+/Mrae2Kn9aV6xeIJ9gZQMa/vniKr1+V2AjwDvjTcBspOXTbRnY
	1xt11Kr2Yb71UtBujJZUKVfj22zEn/HMC9+E3dvI9A4FxgJ3Tw4qpqLo1axhRxTkOeP/iD7/GtYdA
	m4xg5f1g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x0Eew-00000008le1-27hC;
	Sat, 29 Aug 2026 08:43:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63BD7300382; Sat, 29 Aug 2026 10:43:28 +0200 (CEST)
Date: Sat, 29 Aug 2026 10:43:28 +0200
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
Message-ID: <20260829084328.GO788244@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828120408.GN687043@noisy.programming.kicks-ass.net>
 <CAOiLmNHWGSwAqH815X3JWMrQCc2nh-fRNsNZ0hjQGv8JvFndag@mail.gmail.com>
 <20260829083929.GZ776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829083929.GZ776954@noisy.programming.kicks-ass.net>

On Sat, Aug 29, 2026 at 10:39:29AM +0200, Peter Zijlstra wrote:

> > The optimistic fast path for repopulate_stack() could be modified to
> > try pulling from a pre-allocated pool of zero'ed pages. That would
> > reduce the function to a couple of memcg_kmem_charge_page() calls and
> 
> Afaict memcg_kmem_charge_page() ends up in a local_lock, which is a
> spinlock, so that cannot be.

Perhaps just don't uncharge them on reclaim, then you don't have to
re-charge.


