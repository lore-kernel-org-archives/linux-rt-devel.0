Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52DE2D5439
	for <linux-rt-devel@lists.linux.dev>; Wed, 13 Aug 2025 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066796; cv=none; b=CtDir6Nr93twM3h3goPEQo9Dj9Nal5n+6dGpodHCWgxfOAqXcNZ0PHTr8mv5c5cQYrs39J9LoBu8ZiA1BbT5FKBMquGJhb7g7o/1DmVRM3v7JuEbPpELlDwGOwFLODUijlS2UFnGANljjmPfeKMFEs7hfWR+hFr0UoYdl4sauEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066796; c=relaxed/simple;
	bh=55ZW5bke38OmBG0oc9mkB85Mz8oOmbQJs2DkHfThiJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBUL1ePLs1e8Xib+7ZG2sky2HyhLZ3kjmam1vRhjKoWBqUSXl+8Qrqnyn9Lyou5rStsjDaVql9uuvm0nYP/P2hnqQt6mouQRNzZWFFJdQXl80ov5Mg91V3tBbmZW2Ij+E+hsqPAMt/PWnNF3W3kGLG+UUTaMM227ih3Nq2oHyb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hJ0fiqxB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kSpRXcCN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hJ0fiqxB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kSpRXcCN"
Date: Wed, 13 Aug 2025 08:33:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755066793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sKdF4g8Z9W+EtXDMssCPla5erR9/85cWMLD/uZGyTc=;
	b=hJ0fiqxB0IgPvsMep9Xhr8cplfCzGvKGFa6cSysGnLhtfF2rKEWLYlPmpliwZglMNPH4HT
	fi/80wDf3ga7vA46xJ1ADpVx2f4JPkRkZxOViSU1mjukEcDtPAsIfmr9HivR8Lqml7sHWl
	Jbft2KH8YYwnu92RD2pJKEXimXc6ZOYihBTa1c5EB3ihI6vU3Govi5zsiaVq+2GB+C0yeu
	Jn5eDvD7Hp7sFMlBYM2oSkm9dsSWNv+VLPhqAMD+/iGpQTrge5X0xW5eUOijf5hb+udb2W
	xRdjrW3ciS085LELsi3I6vvawhltF23RH3noXSvxI329JXeNmb3ZK92u95Q7Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755066793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sKdF4g8Z9W+EtXDMssCPla5erR9/85cWMLD/uZGyTc=;
	b=kSpRXcCNsDxe30Sl8LJOMqfCVI1y1WubrTjIbuwBjTXYTXubEWltpnevdnOLHGbFbro2Yw
	MBCcB+oftkhiX6Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <20250813063311.33m0TDKl@linutronix.de>
References: <20250812143930.22RBn5BW@linutronix.de>
 <20250812145359.QMcaYh9g@linutronix.de>
 <aJuYStGVBjyfVmZM@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJuYStGVBjyfVmZM@slm.duckdns.org>

On 2025-08-12 09:38:50 [-1000], Tejun Heo wrote:
> Hello,
Hi Tejun,

> On Tue, Aug 12, 2025 at 04:53:59PM +0200, Sebastian Andrzej Siewior wrote:
> > Does the workqueue-BH code require the canceling from atomic context or
> > was this just added because the API for BH and non-BH work items is the
> > same and __cancel_work_sync() allows it?
> > Could we avoid the busy-waiting for BH work items and rely on the
> > wait_for_completion() below or do we need something similar to what I
> > added here for the tasklet API?
> 
> The intention is to convert all BH users to workqueue-BH and remove BH
> (that's what Linus wants and why workqueue-BH came to be), so the APIs
> should be able to match up, I'm afraid. There were some attempts at pushing
> the conversion but we've only made minimal progress. If you're looking at BH
> users anyway and feel like it, please feel free to convert them.

I understand this but I am talking about legacy users:

| drivers/atm/eni.c:      tasklet_disable_in_atomic(&ENI_DEV(vcc->dev)->task);
| drivers/net/wireless/ath/ath9k/beacon.c:        tasklet_disable_in_atomic(&sc->bcon_tasklet);
| drivers/pci/controller/pci-hyperv.c:    tasklet_disable_in_atomic(&channel->callback_event);

This is what is left. (There is also i915 but this is "special").
So we are talking about establishing an API and behaviour for those here
after we painfully managed converting everyone else away:

| git grep 'tasklet_unlock_wait([^s]' | wc -l
| 5
| git grep 'tasklet_disable([^s]' | wc -l
| 97
| git grep 'tasklet_kill([^s]' | wc -l
| 304

While I think it could be possible with upstream's help to avoid the
in-atomic bits for atk9k and hyperv I lost all hope ) for the ATM
driver.

> Thanks.

Sebastian
