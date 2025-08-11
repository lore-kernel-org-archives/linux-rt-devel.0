Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A342D3229
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915258; cv=none; b=O9Gmh8snnKIGZOttkzxO4CcosKsLbKu12nrQ7PcW6jtYGnMlOWN8b2vexCrulYdXIaT5gEzFXPez/pfVZom3lP3bOHZX/lDLDQgMH73LY4b4LLiaFyihisCIpUaOtOAzFO0YqIYLgSeWndRDlU2V4pdSiIZxeGm2rdGebpOHiAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915258; c=relaxed/simple;
	bh=XsvfqUPtKZ4R5JsYCTQxyoTypXysanL0Qk+TBWV/LGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEKy2OrNunbHF9KQOnLRhHfu4gUTvTKlzoOVudSZPT/ueM4rXdLvtfQxMuhS5SuEGjBKPMQdgPh0m8AP4x54q08BN2C6ulD3nRlyb4cUmKBVDD8wVAbRL+dFY5R2T+sh6iz6BJb4sVPQcZ4tniXjLexkfURnzfwmd6P4J2eALPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HyYMSUYR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oB5B3nKa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HyYMSUYR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oB5B3nKa"
Date: Mon, 11 Aug 2025 14:27:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754915255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQI5GMXGo+/Qvjb0QyFw6bVuSkOSNieqkY7FKf2HmFE=;
	b=HyYMSUYRsBGOKzroaOvxudXJBArX0Rr8PCDXFBeiXcnzvi9/sJeATeElZMshHLdT97qwmm
	RSb6XFXxJ7S9wusFCZk92LJjD/zrznmcpWX4GUqjFmzMHON+N/3h8NQcYwB/PRoOc4Ute/
	odoweamFyBit1r/MwywcJEweANd62uGvpcbPIohV9Lvfz6B/LWAuo9lFC9DVi8wPsU3OjX
	nOeA0oboQgduvLl9w3KzQkEZ1Puz1jnNs/VDo4DKhRf46h/+xzA9uZ3Hc4xcTTYmm/gA2s
	olbVMqM576nb71QiAMaYlaJE+d0Ofn4RLFYkte5lJmpEKqq3PR6ZIUUbDSeKmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754915255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQI5GMXGo+/Qvjb0QyFw6bVuSkOSNieqkY7FKf2HmFE=;
	b=oB5B3nKaOAvbytCSJtKjNE4hCvjhTuzvbnUDPZj+xWvBWS9udIV24+2kN6BTBNJi3P5epJ
	C0oFhKgO05w2jqBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250811122733.U8EJGatr@linutronix.de>
References: <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20250811110617.GB5250@redhat.com>
 <20250811121607.Z6G889tB@linutronix.de>
 <20250811121951.GD5250@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811121951.GD5250@redhat.com>

On 2025-08-11 14:19:51 [+0200], Oleg Nesterov wrote:
> > > Yes. I'll send the simple patch when this patch from Luis is merged.
> >
> > Okay. Let me cover then the other instances.
> 
> I was going to update them all, but feel free to do.

Oh no. Please do cover them all and I review then. I understood that you
make a single patch for a single instance.

> Oleg.

Sebastian
