Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2B207A32;
	Wed, 12 Aug 2026 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530088; cv=none; b=MlCJaS8S37TFxkbDcMv7kVl/urCiBaujE4RrlkKPkR5VdaFlhEkESWTSa1jPm5jv9r+vW0y9pfXSFV/n5mc2MFdwakf/klLhE/VzfqhJ0ogDFHPyitM7/kVYPXHvbgFyBOp4TKaKUzPw/fblCZ3P7ztu1w8mf0f5NXlFXSSLI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530088; c=relaxed/simple;
	bh=Z/kzjdpfVLvM5JPMv3GfcSI62SyYJQvVXSbAJDtdPEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk4rvGgRHJKszyqTDzhaCVjrCH17rNzQeMtbL0GIiuhf7gs1t1Pt1RxBcno9WUIN3clDtbPbvUyLwKqeQT1qJqHr5rmO1Mhwr8hdBIwkNeEGEHYvDcZgHOMh95dm1wJmbHFwuX7yT3P89BLb61UeAc4fkJNWpuyqwhfscZLuXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c/QgNx/w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/QgNx/w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z/kzjdpfVLvM5JPMv3GfcSI62SyYJQvVXSbAJDtdPEI=; b=c/QgNx/wM9vtTCmvFBsEQrOXJK
	M8K9XCO5nQxsdo7doEQpG7kbRB50jT3FhBuzh55FViF7Z9DQK8nlatCH4Rg56DEMC44d7AEzXmbz8
	OpX6AGfQUQdvY3K9GoOUimbE8UAdrobxUuTc8mEfFh7XGH9iWVVaVcAmgybZR6cjAdsWbq5Diuy5e
	vy+To/AS0xxqI4uDacZ6gpczmOdLgOl9N8P2r1CdkmsJBF7AG/9NEPrw/D4zhLwRNI3GSccncg8WB
	bPkcjMaAW+qkri/H7THrm3BUON+Q8BuVF30MYFADxKkj9Qk5Vl7uKI4V2VYhc6F7UQQSEuGiJtNrB
	r1ccL0FQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu651-00000001oQ3-1lgI;
	Wed, 12 Aug 2026 10:21:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E44C4302FFB; Wed, 12 Aug 2026 12:21:00 +0200 (CEST)
Date: Wed, 12 Aug 2026 12:21:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Bradley Morgan <include@grrlz.net>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] hrtimer: Pause KCOV during deferred rearm
Message-ID: <20260812102100.GF776954@noisy.programming.kicks-ass.net>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
 <20260811154111.64669-4-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811154111.64669-4-kmehltretter@gmail.com>

On Tue, Aug 11, 2026 at 05:41:08PM +0200, Karl Mehltretter wrote:
> Deferred hrtimer rearm can run after HARDIRQ_OFFSET is dropped. in_task()
> is then true, so KCOV attributes the instrumented timer-reprogramming
> subtree to current.

But that is clearly noinstr code; there should be no kcov calls in
there.

If kcov is emitted inside noinstr, then kcov is a broken piece of crap
and needs to die.

NAK
