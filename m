Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1467F1E8320
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914572; cv=none; b=Rl8rmG7s88tACKgsCnDPv8Eb+enRkCg+wBOlZKggd/vEMUOEJtZ7blPJlAtZN8WbbZH8yxaPMIyEZifVHmIsFMYBQ/0BvbHcKOHV8DewdR2aRGJHx16iF0QOjWxOPT6tgzIFxmETe+WEokIX2Zh0ekFUsvipb96CZxfVXoXeAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914572; c=relaxed/simple;
	bh=3kwatRnYk3RX35FlFlbtS2MVDULbtDc8/9WTF951bWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW0KSr47wHwv3Ze8Cj/KCUas2DoWqq+7D7wHLBU18Q4D4SUX3Yyr/6apMgjeeDSlwfWmHwDFRx3nZFaMVjfXhShrO03ZoRsI5P/2FWfsJnnLwGWs7Kqg4trkOBJu1K9uZvZGvB3k19NsN+Rbt8oh4Mxfr1eXxnmhh95M3qngjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2k3dTJRB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PjgZgDp8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2k3dTJRB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PjgZgDp8"
Date: Mon, 11 Aug 2025 14:16:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754914569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOTmBQpM+cQ1IjodLpqZoppxDe1NCdgUTVoiL5h5BpQ=;
	b=2k3dTJRBpAPbF4IkUC5BZgaDrbe4Ql6DG3qRfy9uhrhdJ9SSx+VR3sYwhebsI91NyWW4JA
	JjMirW9RvZKoXIt1a8cUxas94m2/MabKzF6MZPIZbk8QBG6qvMJnNdBy+x3igtVNwiqFAy
	fgNLKCrn5mGbV9RriDsEH3+9RU/XbvEbcUBlsFxdS2hdFwBE8fnw0p0lSOuOFC/0RkiMta
	o5SNUoH8SOaKrT2veeJI9wMPqVUNTG1ql9UYykMYcoHlpKAIbMnWbDpNb3Zw9UbTjn0r/8
	SKY1tSwo9RtXs8VBDtUzsW1uCb+ozfBy7GPnfBW04Ni6GiVxI3j8v4cjOSPSJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754914569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOTmBQpM+cQ1IjodLpqZoppxDe1NCdgUTVoiL5h5BpQ=;
	b=PjgZgDp8Qn5nnwmaByZDNCgs/PHv4p4zFqsuEydspUiCOEAbYiK4ujcFMBMimM62UUnD2D
	SKd23HPf3LaZw/DA==
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
Message-ID: <20250811121607.Z6G889tB@linutronix.de>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20250811110617.GB5250@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811110617.GB5250@redhat.com>

On 2025-08-11 13:06:18 [+0200], Oleg Nesterov wrote:
> On 08/11, Sebastian Andrzej Siewior wrote:
> >
> > On 2025-08-01 12:24:29 [+0200], Oleg Nesterov wrote:
> > > s/LD_WAIT_SLEEP/LD_WAIT_CONFIG/ needs another discussion even if I am right,
> > > sorry for the confusion.
> >
> > You are correct Oleg. I've been just verifying it and yes: LD_WAIT_SLEEP
> > suppresses also mutex while the intention is to only suppress
> > spinlock_t.
> 
> Good, thanks.
> 
> > We have four users in tree, based on quick check all four should use
> > CONFIG, three of them do use SLEEP.
> 
> Yes. I'll send the simple patch when this patch from Luis is merged.

Okay. Let me cover then the other instances.

> Oleg

Sebastian
