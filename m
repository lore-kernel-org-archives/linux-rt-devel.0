Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396922253A7
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909993; cv=none; b=G2pEswsdP1WJOJo3X5WusXCv0AyH+5FXbJdfwzuRS1Mc625aL7O7zl3bXn9Ap5CGzTrmwh3O9h0RVSyLBtajLKIFYOo9fJeuHicKUKofukU5QJw2Ubm7tZ64bHzeZC6VjxkI28IewAHim0HL0nw3/hqtBXJiyHIx1KjRrdK9Mhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909993; c=relaxed/simple;
	bh=ZGLhw6F82G2k+7a9FM6UoclZBOctFLO++s2igSsjfp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoOy7nYCEvZsWh4Zd+sKOz/TRyBSYQS4RRROYt3vArvk08+ZYmeylrFYcEfQ/45J+JWBm0PPJpbBNwLIap5UsDP2fJAC8wFYhK+lEiM4cooz1a6CVLatWsiQslvVFiRLdqYqR2n+f6x2aclx03e0rikAnSBjERi+t2EI0r+VUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lPMP5CPl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6JtrFSgQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lPMP5CPl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6JtrFSgQ"
Date: Mon, 11 Aug 2025 12:59:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754909989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGLhw6F82G2k+7a9FM6UoclZBOctFLO++s2igSsjfp4=;
	b=lPMP5CPlPKGJx3KIdDvsM3615mKqIkzjrbmwmc+L84Hg7rlpWhORBudJ2i0Ra17SwNlxPB
	EC9iVI6k2oqM+7zBJnInay13VcPxy0GXveokk0qVh077cxGgVeh6QwUKlkCP/eUGizD2hO
	bWNzZoJFJxbhJWiV/USgWqEikh+SMiw+fLwewiev9i3jHYQvcNQiRUzbeipYD2CVuvq49d
	nFp09A7IxVWXRDXfgqk1vpsTuVT2yfvXIc4TrA5AUc+sv6PKfNVpsxjJP1Eq4Zsi5iz6Tw
	3PS2wrvCArrsj6ZA6/TjOm52QY/cuvV5z2mxpAhBQkg8kWVXiIifCagC2ykllQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754909989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGLhw6F82G2k+7a9FM6UoclZBOctFLO++s2igSsjfp4=;
	b=6JtrFSgQqHmOl/Rjfa8A332UF6APX5qWYRNLwatGMmtCQh0W57ZQCmtRdKwI2t96Lay2cC
	3cj0FS5C27Rj+DDA==
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
Message-ID: <20250811105948.OafBprND@linutronix.de>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801102428.GB27835@redhat.com>

On 2025-08-01 12:24:29 [+0200], Oleg Nesterov wrote:
> s/LD_WAIT_SLEEP/LD_WAIT_CONFIG/ needs another discussion even if I am right,
> sorry for the confusion.

You are correct Oleg. I've been just verifying it and yes: LD_WAIT_SLEEP
suppresses also mutex while the intention is to only suppress
spinlock_t.
We have four users in tree, based on quick check all four should use
CONFIG, three of them do use SLEEP.

> Oleg.

Sebastian
