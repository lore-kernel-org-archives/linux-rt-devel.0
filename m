Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628B2C21D3
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922140; cv=none; b=BTvmmMtRXs14icPS0GzhOf+WZmShKpWsiNTz84PPfKLpKq1cXwYkSLERY0aYRXpNiWZ/zC5F++/7wZzxf+fm/+lN6/FqsHTOQ1Pyx5PFDAs4hM4qgEFpsSR7w+b1e6NJ61cctGlh+CTKLCnDFEKT6vKU1UhbJbubK3eTxGJISaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922140; c=relaxed/simple;
	bh=TL+Nmc3i/qX0W8acIf9+HWe22GQU4yhqJJ7zxNGIMuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuKeS8i9qWmEjKI96okp2gMfweuo5tGgz5LFvqNipvwh4tJ688j2gci8amomobUwYO2REYlitcd3nC/0zuGZYKGmzo6B6M2XiPKBi+hezRj1cEDoE8cJUqJgYXVErgY5raDao5LHRx4WX1z+q0TFhNHmaFIQhJNoPMCk3irylPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E2qxO42G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dj6qrJNk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E2qxO42G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dj6qrJNk"
Date: Mon, 15 Sep 2025 09:42:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757922137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CaQJ8YpJx+npBQA7NSeqOcr1sHlKEZKmCMVznqYCbXU=;
	b=E2qxO42Gtzb++MUBsbv9d8F6YgW/gM3cprOKvMzy2hbJk9a56VlD8cO+71Oksx5ht5243P
	CSBqtNJrxwZAduxLhzEk0/Cv9JfYRky109CvS5zu4snet2sAaIk5OKATlWQLaqrNybCEZ4
	LTN4y2Cs9dRgsXOG8LEdrmagZD9eSWl0DflhCP0jez2gh8La4kw8m6K+STseRfalmNIG+N
	e9gfon55Wslk1Z6/CLqbFLzDym7zjAB81JeRa4saRlbKLBizPtMQUCg426H34FAKhptTBv
	zf00p28tqjOAo8kCiNy1hIGJJZuOyU/LBV0rwRkJ79995CUv4xBEq9cUww5Hew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757922137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CaQJ8YpJx+npBQA7NSeqOcr1sHlKEZKmCMVznqYCbXU=;
	b=Dj6qrJNk0loJQXvVvCQJMO6TKPNaF+Jo0kXQD3DFZ7PIOvDzKpNM7rERCSL56Q/ut+Db2g
	cWuvi+JwEHCjdlDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 0/3] Allow to drop the softirq-BKL lock on PREEMPT_RT
Message-ID: <20250915074216.VIaWMfNY@linutronix.de>
References: <20250904142526.1845999-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904142526.1845999-1-bigeasy@linutronix.de>

On 2025-09-04 16:25:22 [+0200], To linux-rt-devel@lists.linux.dev wrote:
> Users which rely on synchronisation within a BH-disabled section as in
> - access to per-CPU data
> - per-CPU timers
> - synchronisation against another user within a BH-disabled section
> 
> rely on the local_lock_t lock in local_bh_disable() on PREEMPT_RT.
> Almost all users dropped their dependency. The remaining (identified)
> user in networking (pipapo) is in net-next.
> What is left is the infrastructure as in tasklet and workqueue (for
> bh-worker).
> Both are part of this series. The last patch in the series adds an
> option to drop the lock.

Could we please route #2 and #3 via -tip?

Sebastian
