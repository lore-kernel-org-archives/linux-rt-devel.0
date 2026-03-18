Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6927603A
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Mar 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845466; cv=none; b=eomuaDSlYEAKYLVOIzODxPD9XZGHKR43o7keMTDTP+i9xcCks/3TwnjRCfzjkrEMHivO1ZoRSr1McBG/ao8pMpe//FxjoleBMc3ZWQN4c8Gpy0T81zaD8cIybI0s1XELnmo0x0SD5OxlribCPJAj5NpmdlR0oWM/R1bbL5yx4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845466; c=relaxed/simple;
	bh=sjp63ygZLHeR2EJjLkjMV5oZWJ9B525iJ1CqBN8U4HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ2XhMXrJ53SoketXzB9GxsbYjVLa9EhEzi0/xq5KBpfCuGkwg1kEG1NZplcUD9CM1xEBR90GZm7Xbv0+nAREmwGwid8b/Dx/FLnPCpjsdP00bocvtS05PLLmd/LazDLhi19MflkR60cHuuiV+adddZafgnh5PAtKAZk9YJgfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PeFDKGTa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vMHl7dfc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PeFDKGTa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vMHl7dfc"
Date: Wed, 18 Mar 2026 15:51:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773845462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJK4FTcbfKscaIRry0AE0sxgOMNdmf04w//rPt5ah08=;
	b=PeFDKGTatHTl6uJeNnQ2K5o8OnnHMS7x/u7yIgNgnRqiwkbCAsDbJfI8B2zhBtDJAn2FFJ
	b40V5NFQt5fCacoO3upOugFmkkuhl8RsOVHXbAlR32CBT70CtMqQYOlFzIzZFUNu5u5F1A
	aiYTS0FliIW0eCNbqZFQlwsPHrWeH/20mBp+LIxn0+AljVkY4gsfyuLDulLTf2MiyX86ZI
	QqVa+QF3QUG0nWMBl7ACHPedcYyW6EfQ5GtdZMMSu2j+PrP5VNZlE2waZkGxmIIVg2RASJ
	n0gcEl8l5ri1MvSBH6pXhDMsKL4BwrI5te47fUeo67vvJPQbin90xtfyL5xg4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773845462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJK4FTcbfKscaIRry0AE0sxgOMNdmf04w//rPt5ah08=;
	b=vMHl7dfcJuzY/NFfC8ge+rKkcVRijjDRHp7mYWGJ6Ffa/uNSYKbWLjZMKRHvgEKdXuiUby
	I2L8hDKWJJ35fGDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Vacek <neelx@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org,
	spasswolf@web.de, tglx@linutronix.de
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
Message-ID: <20260318145101._iaDDpbE@linutronix.de>
References: <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de>
 <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de>
 <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de>
 <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com>
 <20260318111849._MMol8Hr@linutronix.de>
 <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>

On 2026-03-18 15:43:52 [+0100], Daniel Vacek wrote:
> On Wed, 18 Mar 2026 at 12:18, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2026-03-18 11:30:09 [+0100], Daniel Vacek wrote:
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > > >             /* Other cpus might concurrently change txq->xmit_lock_owner
> > > >              * to -1 or to their cpu id, but not to our id.
> > > >              */
> > > > -           if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
> > > > +           if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {
> > >
> > > Ain't this changing the behavior for !RT case? Previously, if it was the same thread
> > > which has already locked the queue (and hence the same CPU) evaluating this condition,
> > > the condition was skipped, which is no longer the case with this change.
> >
> > The above was me thinking and does not even compile for !RT. Commit
> > b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> > netdev_queue::_xmit_lock") is what was merged in the end.
> 
> Hmm, that means txq->xmit_lock_owner is not used at all for PREEMT_RT.
> It's pointless to even store it. Shall we care?

For PREEMPT_RT the xmit_lock_owner member is only stored and not used
otherwise. It could be removed as in ifdef-ed away but I do not care
enough to sprinkle it and the gain is little (proof me wrong). So I am
happy as-is.

As for the check itself as we have now, we detect the deadlock before it
happens and this is nice to have. The alternative (in case of a
deadlock) would be the deadlock detection in rtmutex code which would
freeze the thread.

> --nX
> 
Sebastian
