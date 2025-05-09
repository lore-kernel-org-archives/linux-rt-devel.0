Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72C28F930
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 May 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791911; cv=none; b=RMVYdWl5sR2R7BBIFLDd7OEaroI/kevuFshPKgKwSgj+Q093dKrPfYvNI/gqvLLMFBBejk/g1kM3FJ5DQaPNMiO9dTTtoRh/LLHxW+EpUEfeaR1YqpPQ4nXFTYen8ckpkC6fPjHbNpwQ1jQ7RhHDSfCeoWQZhQ6K5DHx1I+FbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791911; c=relaxed/simple;
	bh=dsSvYZvde6/5EkYxQikz4oG6dsceowppGFdoHhRq+tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow3RsD8gnhhLAjx6SVbUDL/KQzCOiYL/CKyevwAqjIqdYwos/XzcSTLGMDVR2re0DBe8Yr7QnW3/cryODkV2IhC6PRx3KHIrmiay4jfC1111ftlkuprk4n1vyAXIByfPEbZdFszkpONwV7XrygHkW2Cey3kkTrrNeem9MVDPCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dps4ANgQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bVQgTY4O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dps4ANgQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVQgTY4O"
Date: Fri, 9 May 2025 13:58:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746791908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=re3w9skpKOlyeZkqJb5/x4eZJzz+iBjimR0Qdp7eQDg=;
	b=dps4ANgQsKAY23evt/ksJnxsSYBpxTmvnrpb86jPq5VhPbuncazyG9hlFYK/1CA7MgIVqs
	FPAlRmWr3B0BBAEKvDPdmrPhLD1lObxgCbOVNGPtDyrd2BPdvbEqygCHcyLQ6iAu1JcBNC
	T4iEXZdpLgeqVXyKVfiSRmWR9oUM6YO7QqXU6YMwyMxQR4mMPpzj9VCIxaY9oyOQ9CZQcH
	dHJBiZIso5BPqjB8Jn3I/dVGN86AK3gRsSQVzW8roh2lTGfBV5ihG5sSNN1mnjHPNoQYUT
	XRkqvK8rAB+igjXhgL4dPBKtB2cZKF7dzmSntd8nuFhejwAk6iKOtElh6isW4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746791908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=re3w9skpKOlyeZkqJb5/x4eZJzz+iBjimR0Qdp7eQDg=;
	b=bVQgTY4O2GeXFCfSyIG1jVXxzDinK8atXj5L7Zzt0l1/J/oQfsGnu6dJvpiNhzYy2Lkuyv
	wKvBkVSyUaQYEdDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next v3 00/18] net: Cover more per-CPU storage with
 local nested BH locking.
Message-ID: <20250509115823.DriYhjUm@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250505160253.3d50ebab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250505160253.3d50ebab@kernel.org>

On 2025-05-05 16:02:53 [-0700], Jakub Kicinski wrote:
> On Wed, 30 Apr 2025 14:47:40 +0200 Sebastian Andrzej Siewior wrote:
> > I was looking at the build-time defined per-CPU variables in net/ and
> > added the needed local-BH-locks in order to be able to remove the
> > current per-CPU lock in local_bh_disable() on PREMPT_RT.
> > 
> > The work is not yet complete, I just wanted to post what I have so far
> > instead of sitting on it.
> 
> Looks fine overall but we're anticipating a respin for patch 5?
> When you repost could you split out the netfilter patches so they 
> can be applied by Pablo to the netfilter tree?

Yes, will do. I was mostly off the last week.

> And there really doesn't seem to be a strong reason to make this
> series longer than 15 patches, so please don't add more:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Okay.

Sebastian
