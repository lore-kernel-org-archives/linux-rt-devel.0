Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82941850AF
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Nov 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329630; cv=none; b=kS9QTGJht4k9EtEtBI+VOxVxEAL/0Qe3MXJr1OnHe9GbuMmfAwa/vmO/QfpBCYlW3M/cYjU4MsDfDM2CkaPSdv+PLRX5MFs9ho1oc6aYlg2ZdDgl+gqF0xDZ90VsjtyopljkmaicgaGlgVAVfOPf/K6kcPT01/yxCfbHjvn5dLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329630; c=relaxed/simple;
	bh=FmF3bZ1r/WsmIZmkn/Wp3I4nzVPM0WOoQQ+6z63YQIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+6Gnn9CfC/NgUW5REQPmqkd+ATro53/a6/NplQ55KbnFtvkLCfNf2+jkNzmNFWxpnXfROsiEq6tFqPzFgtuMSsixABWhxGvns9S26w4RvJOcEZ8PR4YSP80Mj6pQUfti2rqwU98HLPdsk1isK85HR9XtwSMQujXu0Feg35G4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dtv0b8+a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t5hwhBcy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dtv0b8+a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t5hwhBcy"
Date: Mon, 11 Nov 2024 13:53:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731329626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w7z8yhXRBnlRYKfyfn4Xe3Y3OGC88TCWkSEzDPuPxNQ=;
	b=dtv0b8+aCLwhVivvFUjFNqplSCPxGWFTtHuKMDvxFHL34tKWExWlHHNyW10RM/mrjJMI8f
	089D2TK1AQ7sdF73yWg0qz0vACWNAENLY/QEQyRYuDTnwhNjzdyGccp1zYHtp0epqFcTky
	U/Y0Q5SMvLKYQ4zAYI1SO3PKEYD2dZ4Vc3RWNarc7vJ8+OSFhOlQhTr8atuPRInTizsNdT
	hUabpL8xT/N43Yya3ER6WSfvOoBQqJjQg5zaBA+LWBysOPwA1mdxCKsKtQpTgAN7lEIVsg
	V2WPFmskshbU4nieE/3UMDrNexHbqdABCxsutrdzg3IdHiAImLC4UaFmC2vMTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731329626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w7z8yhXRBnlRYKfyfn4Xe3Y3OGC88TCWkSEzDPuPxNQ=;
	b=t5hwhBcysw6sr0uejWOPe0jN8ijZp6hxiaMi9xUsvaQ53fESoFBjWOSwjJQXUj2QkJp+lK
	w4qAM5LVRIo4O/Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, tglx@linutronix.de,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Simon Horman <horms@kernel.org>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v2 1/4] Revert "igb: Disable threaded IRQ for
 igb_msix_other"
Message-ID: <20241111125345.T10WlDUG@linutronix.de>
References: <20241106111427.7272-1-wander@redhat.com>
 <1b0ecd28-8a59-4f06-b03e-45821143454d@intel.com>
 <20241108122829.Dsax0PwL@linutronix.de>
 <9f3fe7f3-9309-441c-a2c8-4ee8ad51550d@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f3fe7f3-9309-441c-a2c8-4ee8ad51550d@intel.com>

On 2024-11-08 15:00:48 [-0800], Jacob Keller wrote:
> 
> 
> On 11/8/2024 4:28 AM, Sebastian Andrzej Siewior wrote:
> > On 2024-11-08 13:20:28 [+0100], Przemek Kitszel wrote:
> >> I don't like to slow things down, but it would be great to have a Link:
> >> to the report, and the (minified) splat attached.
> > 
> > I don't have a splat, I just reviewed the original patch. Please do
> > delay this.

this clearly lacks a `not'

> > Sebastian
> 
> It will definitely splat on RT kernels at some point, if there is a
> spinlock.

exactly my point.

Sebastian
