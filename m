Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A6455192;
	Fri, 28 Aug 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927757; cv=none; b=cOSA8KeI0QYi3fdckNYvQCb9sRbnLPy7enSvcgoGtwCEK+keE6xLEMTt9JEHRoO/eZzXw3dnzfQk/Yl81+ElcRVe5TatLIHmhdsQtd5uA8/yWxXWt0K4aITTX4knBbj7a+w8gKNCfiiQ6k5w+iFMA4GsuGi9x0puu9jbkEEE8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927757; c=relaxed/simple;
	bh=qt1fLQhXwiuhTakqhObvInwVmK3ImTBo4G1+BsTtet0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXy0Hz2O8yfRZPtL/SNcaBYDJj8ujuTopWd9q0yw8q9/RjDCbRF+98fPCD9xnsEU4gMsewJrDasd9RkWXCUtrSvkL1wduSlzg0YYQqa1/Gze12g4uT9E4ust/eGpK4MGMOLJEgP7THpk9Xu4Vv0kE71PlS6kyd7GaK3tlp2Ypv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j/13ETx4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j/13ETx4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ckaGVw74rY49wuwKahOscpW27wYJycDGKErZJGjW1ng=; b=j/13ETx4G/dFNQw+O8eobyyQgc
	vb65HchRPDcYLjcyC/fkNRFPF7qas14vbb7S1GpoV2I2Af6KgW93+TAewKnJQ9jPgtqk2OZ4eDYpF
	0eGT9oIxEXXxMOGJnz+Zvxpz77VhnwgFGBfGc5FM67FuzGeN+I5Mafj28D5LTj5F8G/dZkV4yJK4+
	g/PyiaahSQ3iyujx49bRLJZiZUJ+yXgaIlR0W2Rw3AYelbw6TU3UACtgxtALW4lUBvYYMD2rKLFE7
	q1zfp3Kbtkb7ki2dRGweNoxO9hxDIgG19FTnmrcPYemQ1XaAxnkT1xTxBpc0pWM6eJJY7vgg4Z1ww
	by1BAlOw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wzxgE-00000008KRq-2kIR;
	Fri, 28 Aug 2026 14:35:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AC76130030F; Fri, 28 Aug 2026 16:35:40 +0200 (CEST)
Date: Fri, 28 Aug 2026 16:35:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Stevens <stevensd@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
	jstultz@google.com
Subject: Re: [RFC 00/10] Reclaimable kernel stacks
Message-ID: <20260828143540.GV776954@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260828124758.GP687043@noisy.programming.kicks-ass.net>
 <20260828103328.633bbfbc@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828103328.633bbfbc@gandalf.local.home>

On Fri, Aug 28, 2026 at 10:33:28AM -0400, Steven Rostedt wrote:
> On Fri, 28 Aug 2026 14:47:58 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > On Android, system processes typically have 2000-3000 threads. App
> > > processes add 1000s more threads on top of this.  
> > 
> > WTF ?!? Why does that all spawn *that* many threads? Perhaps work on
> > reducing that some?
> 
> I guess you never ran Java ;-)

Of course not; why would you want to do something that silly ;-)
