Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689721C17E
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jan 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436458; cv=none; b=dEIUH50MbVTwAf9zI0Uh7dRnFmUt1YbMhALkHWp56Y87tpff3FSGXimyH1RbYolGUtfXGkpOQ6Iq798FRqyISZvNvdNmwgFRiwB+9tT44t7w5xpTS9vCf8iGT1RecwUulcvcAtJzbdCR+qaYyqaXPGZKgMoU4ZH1loXIzCLLG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436458; c=relaxed/simple;
	bh=zQjJhVh7utJZJG8BQWG+QfdMYCyuEesMXGPA340vxvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn0JS6srbNNeo7Ihb/MxGqcpo3LHxQAObMavy+41J0MwBuZ8yApDxvN5fPcIm4CzUSgyF+2Y1kfkGtxiS/IGb8hbbNcMBZQSVZ/hjyOMcJoIq7/cb6TMWYCYiFTFtumvjFF8FhsfDslyIKkZnzNiZRU/gPCPAbYnH3BxLRD7iC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O+ijyXXu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Wnu4+Cc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O+ijyXXu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Wnu4+Cc"
Date: Thu, 9 Jan 2025 16:27:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736436455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQnP3Veup7OOCFZ0vZUfpJZp1Woizb2YRyHSwwI/Mog=;
	b=O+ijyXXuMBEq36lXYys9jtJQncnalcxQaEGmxz4uBwOIvTfwiLBamOyRplmN/Vp6da6g3K
	6Gp2KBNeZtf+YEkA61UmY4m3+/z0MxLEK8H7SWCs58PThBJoSe7ME+njJByecdtZnHDFd7
	WBu9XIz58eZCaE+1CrQ6J1paEtZhKCmtGjQAEIzT6kn0T8JKtVrw2pZIswp3sWRhQOsRjO
	Gxz4jkOBd4Q2g/A+nBRFSk7tSj6MHZXXXWsDNnMepHz9QfJDcwoPc5b21bfGHDuvR0f3V+
	QoWeDjUxBNfjmtlaLPrbBfC5fuxXbPpqx78GGKDEou+kitSxf4H80jM69n/QHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736436455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQnP3Veup7OOCFZ0vZUfpJZp1Woizb2YRyHSwwI/Mog=;
	b=5Wnu4+CcHY2TEIUFJ8tmCPQlgMGYoYYuecKrUAkY2PK2DD1vNSuKZYIC844TFiJ2UCClJG
	iUTDWXlUsA9kA+Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [RFC PATCH] preempt: Add a generic function to return the
 preemption string.
Message-ID: <20250109152733.VIh584yu@linutronix.de>
References: <20241206113431.Q-VXMlru@linutronix.de>
 <20250109114339.GB2981@noisy.programming.kicks-ass.net>
 <20250109093702.5fe3400d@gandalf.local.home>
 <20250109143701.GA5388@noisy.programming.kicks-ass.net>
 <20250109144124.a7MWASit@linutronix.de>
 <20250109145408.GB5388@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250109145408.GB5388@noisy.programming.kicks-ass.net>

On 2025-01-09 15:54:08 [+0100], Peter Zijlstra wrote:
> On Thu, Jan 09, 2025 at 03:41:24PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-01-09 15:37:01 [+0100], Peter Zijlstra wrote:
> > > Upgrade brain. Also the proposed thing was just plain wrong.
> >=20
> > Was it?
>=20
> Yes, things like:
>=20
> > +             if (preempt_model_voluntary())
> > +                     return "VOLUNTARY+LAZY";
> > +             if (preempt_model_none())
> > +                     return "NONE+LAZY";
>=20
> don't exist and make no sense.

point taken.

> > For the !DYNAMIC case everything should be optimized away except
> > for the current case.
> > Let me try your thing to see what is different=E2=80=A6
>=20
> For the various cases it was supposed to print something like so:
>=20
> RT+DYN:	 PREEMPT_{RT,(dyn_mode)}
> RT+LAZY: PREEMPT_{RT,LAZY}
> RT+FULL: PREEMPT_RT
>=20
> DYN:       PREEMPT_(dyn_mode)
> FULL:      PREEMPT
> LAZY:      PREEMPT_LAZY
> VOLUNTARY: VOLUNTARY
> NONE:      NONE

Good. I do like it. Let me make a patch.

Sebastian
