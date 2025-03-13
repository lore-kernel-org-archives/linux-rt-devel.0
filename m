Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B7870809
	for <linux-rt-devel@lists.linux.dev>; Thu, 13 Mar 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874545; cv=none; b=hVTL3mrE04tqjdiqrfpx2qrb9E6Vu3V6n8ycb2HAXR693sV9PHtXn/HnEVhsdj2vwhI4s4BCHA9Z/5tWzKuKxQKsJMgZ/IKOrSQXRKbGyk8aZUaNQdCITjRsYgdIjkoyeUgwTuiPH3uznMVpnkV1KRNI2ljhZ7UfqqmUo0ibxwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874545; c=relaxed/simple;
	bh=Vlo8Sx+8lQwIkqAjgmSFybdkDCWLY9jl4oA4pGgcsKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqVzQl9l/mBOEjgOe4IQJ1K11vJld5tUugDas9/dLQsK8Bkd04g8rwSfVmdF2ZC2nT+EO0WXOsanSXBsWENhFBVXQh2vnFliKC0cq6uKVcCxDzHh5CX8Sr71Z2DqTWtlktwZiBx4fHzAKJpSw9uriycn65ebHEaG13MZxDGHH6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a828M188; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mDHZ8jIv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a828M188";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mDHZ8jIv"
Date: Thu, 13 Mar 2025 15:02:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741874542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJBo/xMAwAIoespogCwXiRKFEyJSUb6UAMPRbJLIskU=;
	b=a828M188lUH9/SO8hYsUH6I0BuwRwh+veh+z6i+A7ctMQLMGXKnAYyLBP3CQxyz+Tyod2G
	epHsjstMEYam6lVOKUZ4R6aP32Nv0udurrMUnwvSgv/Kq/ZWt5fbYxqeS0g6o1+1/H5NFS
	WF5MoH+d8obH3QgDbNPaPj69+OokIa+GA6hC3jaW1lFBVlXrDhbGooUEyl3fwhCyPB3mQC
	ku3DHT3VnBg+RPrfuS3BvQ0KMXGSyu9k6iqZ8bFrKdCYkfsZDeotTQGhEDC8dnzP+Gb5Vs
	7v/X21lcjzs+ZqfkU1zv2Xfa0dZJR6Bvb7RyOIXHwYKDRK6fxZY7c0slYQQIoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741874542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJBo/xMAwAIoespogCwXiRKFEyJSUb6UAMPRbJLIskU=;
	b=mDHZ8jIvkby7bHqrKOdjtUkhYpvUCIRdDnDZgLRmPuG6jZnUEOKlMS0F7Q3Kzv/8R8dv+p
	krGNETXv1R13eCCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	dev@openvswitch.org, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [ovs-dev] [PATCH net-next 11/18] openvswitch: Use nested-BH
 locking for ovs_actions.
Message-ID: <20250313140220.Lyr40G7J@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-12-bigeasy@linutronix.de>
 <9a1ededa-8b1f-4118-94b4-d69df766c61e@ovn.org>
 <20250310144459.wjPdPtUo@linutronix.de>
 <fd4c8167-0c2d-4f5f-bf70-1efcdf3de2fb@ovn.org>
 <20250313115018.7xe77nJ-@linutronix.de>
 <1d72e5df-921b-4027-bf9c-ca374c3a09d1@ovn.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d72e5df-921b-4027-bf9c-ca374c3a09d1@ovn.org>

On 2025-03-13 14:23:16 [+0100], Ilya Maximets wrote:
> > originate from within the recursion.
> 
> It's true that ovs_packet_cmd_execute() can not be re-intered, while
> ovs_dp_process_packet() can be re-entered if the packet leaves OVS and
> then comes back from another port.  It's still better to handle all the
> locking within datapath.c and not lock for RT in actions.c and for non-RT
> in datapath.c.

Okay.

> >>>> Also, the name of the struct ovs_action doesn't make a lot of sense,
> >>>> I'd suggest to call it pcpu_storage or something like that instead.
> >>>> I.e. have a more generic name as the fields inside are not directly
> >>>> related to each other.
> >>>
> >>> Understood. ovs_pcpu_storage maybe?
> >>
> >> It's OK, I guess, but see also a point about locking inside datapath.c
> >> instead and probably not needing to change anything in actions.c.
> > 
> > If you say that adding a lock to ovs_dp_process_packet() and another to
> > ovs_packet_cmd_execute() then I can certainly update. However based on
> > what I wrote above, I am not sure.
> 
> I think, it's better if we keep all the locks in datapath.c and let
> actions.c assume that all the operations are always safe as it was
> originally intended.

If you say so. Then I move the logic to the two callers to datapath.c
then. But I would need the same recursive lock-detection as I currently
have in ovs_dp_process_packet(). That means we would have the lock
datapath.c and the data structure it protects in actions.c.

> Cc: Aaron and Eelco, in case they have some thoughts on this as well.

While at it, I would keep "openvswitch: Merge three per-CPU structures
into one." since it looks like a nice clean up.

> Best regards, Ilya Maximets.

Sebastian
