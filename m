Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489861D89E4
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885107; cv=none; b=t4e2Uctmceiuj2sa4gF422hRmQk1Qf/0P4Pf62D4Ku/jorH5dY2YLUXZl2JwOwxtIC6ip1iV6NuDf2ptMl7Bb7utsnmvwCb7NXZaOPy/Og6+GLyKavjKiSXmyhFu1j5VVffe0R3AM4o1LAuUNw7gOc7CHM3tFtwWvehoTyfNBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885107; c=relaxed/simple;
	bh=VdnIizSKaKnQaEzVJTxQTMFkT/43s85uJANzeDqLLLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrxpAGmeo9VfHDDKYUNcRSg18Cdz0HphQEpoeJr+ukqrNCEITzGvOKH1b7rZPDIeI/cXrp8TxV9JpGGwJuo2A/4cV+vHK1B0hGJTtA1Jsi2RTEb9rmJ2qPwNlsX75vMuAazw5iu5UDiSPyeSuVaDDgeLcBZRsUzqACalvTKW13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PeHBBnuV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zMvFsUCa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PeHBBnuV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zMvFsUCa"
Date: Thu, 17 Apr 2025 12:18:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744885102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTKpGtLbS7EfzjXuUckXrnmWMsKaCwDfYnf04jixevg=;
	b=PeHBBnuVdwJSEOWRskO1rqxfDC4ZdBsZRkgr59TSjhlM3osq7E682Uo1mVAkIwsIggvM89
	RWerwrWAI4vQHDLU736A6gyYrit+pTyW4r8xjyhYFr28TbuP0TKrZDbHRTeI04yT0HCHhZ
	h+KsAJaQmGaI3IKLLIBlbLrNtwijHhW6DLVtdN7gKpaGMbjbaXJFuj+u5OjDY/+WLDbcWg
	yelhWaaC8da8Art5XZDXvdhrxnK2YT+9Fi0GdJoAz0ie8VChqSh/Pj58woYrRC9Lxg3Ab/
	qYVIamNxYbbMYEbGjjbi1ScHsZPeLB4976P95tbY5SvtXAWYFJqj8BsJuKoKyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744885102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTKpGtLbS7EfzjXuUckXrnmWMsKaCwDfYnf04jixevg=;
	b=zMvFsUCaGlfEzXnBZumc9i9+cP5BwatNBbFBP6c7XG1ucWta+F6M/bdS1gdp/n6leYB+w7
	I94JsVxS3vfG4eAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org
Subject: Re: [PATCH net-next v2 12/18] openvswitch: Move
 ovs_frag_data_storage into the struct ovs_pcpu_storage
Message-ID: <20250417101820.Cd0BZc0G@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-13-bigeasy@linutronix.de>
 <f7tbjsxfl22.fsf@redhat.com>
 <20250416164509.FOo_r2m1@linutronix.de>
 <867bb4b6-df27-4948-ab51-9dcc11c04064@redhat.com>
 <20250417090810.ps1WZHQQ@linutronix.de>
 <94076638-1bc7-4408-b09c-7c51f995d36f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94076638-1bc7-4408-b09c-7c51f995d36f@redhat.com>

On 2025-04-17 11:48:03 [+0200], Paolo Abeni wrote:
> 
> 
> On 4/17/25 11:08 AM, Sebastian Andrzej Siewior wrote:
> > On 2025-04-17 10:01:17 [+0200], Paolo Abeni wrote:
> >> @Sebastian: I think the 'owner' assignment could be optimized out at
> >> compile time for non RT build - will likely not matter for performances,
> >> but I think it will be 'nicer', could you please update the patches to
> >> do that?
> > 
> > If we don't assign the `owner' then we can't use the lock even on !RT
> > because lockdep should complain. What about this then:
> > 
> > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > index a3989d450a67f..b8f766978466d 100644
> > --- a/net/openvswitch/datapath.c
> > +++ b/net/openvswitch/datapath.c
> > @@ -294,8 +294,11 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
> >  	sf_acts = rcu_dereference(flow->sf_acts);
> >  	/* This path can be invoked recursively: Use the current task to
> >  	 * identify recursive invocation - the lock must be acquired only once.
> > +	 * Even with disabled bottom halves this can be preempted on PREEMPT_RT.
> > +	 * Limit the provecc to RT to avoid assigning `owner' if it can be
> > +	 * avoided.
> >  	 */
> > -	if (ovs_pcpu->owner != current) {
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && ovs_pcpu->owner != current) {
> >  		local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
> >  		ovs_pcpu->owner = current;
> >  		ovs_pcpu_locked = true;
> > @@ -687,9 +690,11 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
> >  
> >  	local_bh_disable();
> >  	local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
> > -	this_cpu_write(ovs_pcpu_storage.owner, current);
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +		this_cpu_write(ovs_pcpu_storage.owner, current);
> 
> Perhaps implement the above 2 lines in an helper, to keep the code tidy?
> otherwise LGTM.

I've been thinking about it but the two cases are slightly different.
Maybe open coding right next to the comment isn't that bad.

> Thanks,
> 
> Paolo

Sebastian
