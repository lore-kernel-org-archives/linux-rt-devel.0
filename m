Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2AC35082F
	for <linux-rt-devel@lists.linux.dev>; Tue, 26 Aug 2025 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217824; cv=none; b=naortSFW3+aP9X6QYVPWXJKr2B3fhGq8Xq1i7qErzeyyyfrL+2LFT1GG+f+hv5DX3DCASLA9WnWKKHbK/UWsRsJYRR2ACwsxdwmaCILJ4uVzEcIdpl4qJnDzMmIsnskbEV28F5pUy9zg0f109YgnQryqv7JQlBzuPI2rwq9n+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217824; c=relaxed/simple;
	bh=ajbBXe5gpy4RdalYFrkw0uSW1IfKiKe+tLxkdfAYVpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEvEAcIFhkd16BF531/43pc0sXo1F+vLvVhAciyTU5DsDAX6slkD4solf24H8+aSREnJEqxKz6pmTZwNrqBBEf18KEVltIE1TR3vcpXXtT3dK1DVfknVRRLF7bh4Dc1PK1HOZKodO57Z4hHVK06Bsa5Jd3hIl9ekehN9yvwqrz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C1Fm3iBD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uGUNaakf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C1Fm3iBD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uGUNaakf"
Date: Tue, 26 Aug 2025 16:16:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756217821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HPe46R3LdB4q3J/X7XS0kHVmAThKXah3eizvqx2Neb0=;
	b=C1Fm3iBDTC96Jkf0NwV4jjYOiUOJGF/0ifO3Di64pZ6mR7B2vgXUSoPgahTB55we4Wcjxe
	+kemMGMsw/AD+8/fzxxZxQ3XndERSGSWu7iFOCesQZXM5SU3bsJAW81kKC7P7puTmdtiq9
	DViBnaz8nzZl50xvjLkGpkAcWXTJFcMG7Mei1msihFC/s2wHSE9ssDR9iKeDLS9u1TmgrP
	TwYesAnkj+dl9JpPt9gejIfQJygozmn56F7D65NV7Dpz3drA/MYuHWOfTc4/QkoX9LHS1N
	fmJO0LGKj75fUKAIRSyUSBg8WYCBriJj5inXwGNLgHMw67U0CVsPKMYtXF2eLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756217821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HPe46R3LdB4q3J/X7XS0kHVmAThKXah3eizvqx2Neb0=;
	b=uGUNaakff2dieZWb4qqCTXlvE8xYwAtuieH8n4pG1iXtTYMyh/jyawd5dzePif7wQH0kVp
	aqW5KIgsnJ6dnmAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: cuiguoqi <cuiguoqi@kylinos.cn>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>, guoqi0226@163.com,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched: Fix race in rt_mutex_pre_schedule by removing
 non-atomic fetch_and_set
Message-ID: <20250826141659.VMLwv13e@linutronix.de>
References: <20250826110833.3274209-1-cuiguoqi@kylinos.cn>
 <20250826095615.14259d90@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826095615.14259d90@gandalf.local.home>

On 2025-08-26 09:56:15 [-0400], Steven Rostedt wrote:
> Honestly, without adding a READ_ONCE() or barrier() I don't see how your
> change would prevent the compiler from making the code any different?

Other than that, that flag is supposed to be only set/ cleared by the
thread itself. There should be no need for it to be atomic.

> It may have "fixed" your issue because the compiler may have done things
> differently, but this change doesn't guarantee anything.
> 
> Also, could you show an example of how current->sched_rt_mutex could be
> corrupted?

That would be important.

> -- Steve

Sebastian
