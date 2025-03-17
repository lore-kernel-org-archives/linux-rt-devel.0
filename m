Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11A214A8F
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Mar 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207642; cv=none; b=B52Jj0TQtT+Wjh8KpIDRtw6O3yeRcgPN+oDhf7Aog2rZUqYQo3K//0CMOrZmLVtfXphMpvJtsnNU8YmINhFcPDlA9EBIIQ3aNI9rJwrM7UwxgGK2QyEWGjNxhvCAfY9M7lP+0qxVelEtOPIxoCZgjpnwDDlqrTemehTJIu2V73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207642; c=relaxed/simple;
	bh=TDl6EmF79vCErstAMkDQ0wDJ5/H2BwdP75Y7L+Dzrg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TV0pfjDat2TFGikR2/iHksXVe0Em+RTsibIaFYWtidCH3sJHSHqHOk7JCVeMdQE/A0K/0wKgrjyFp4sFZAsxfgdFvVrgNa7ZYCzb70XOMErUHPjX1ofgB/FOLRIXo2cvzKG/jM2R4XPoiMdUvkm0QUUdFqMQPRb6k2Ny7+KFFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ry3y9Sur; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rgDoORSw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ry3y9Sur";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rgDoORSw"
Date: Mon, 17 Mar 2025 11:33:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DYRxylyxZUUgv9lODip/DW6anufG9qy8IRiDemV9lNg=;
	b=ry3y9SurH5mI8wIBg02I+iDHGYCqM9G0FQ926ot5MOjqud1CVGC8nSaw0LA14a1inIu4Qy
	Odhx97UyytA7GXjdB7LEkUm+K22NjCwNKpyp/5MXdW6U9cIm0fyK8lh8Zyxv5lu2jNcBux
	Q+svz2jVC009/onKleBAvi0ioEclVta1aIizNT9BMlgIijaF6Kil+bziTdvekINYxg3FhF
	/hMP8G2wNgd7E5Nf41kiDdm6SfQ1dlyRudIBWFz8vWBYPSJH1p/qxX4+N8Tl/r7CrJSC9s
	1MMpFpJhgZxrs4E/WakFV7RTwVVxTRQid/vsaDQsnQ3q6mMzkiLBgTBk46cspQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DYRxylyxZUUgv9lODip/DW6anufG9qy8IRiDemV9lNg=;
	b=rgDoORSw0/ukEk9hakX/yTEwgLUYKXfY4lnwDCvKf1CxIluFn5yUVtFBzA6iL4P4OF9eU7
	AWmAxCauRE8sSuCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 1/9] sched: Add a generic function to return the
 preemption string.
Message-ID: <20250317103357.O6YuNbpr@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
 <20250314160810.2373416-2-bigeasy@linutronix.de>
 <Z9ay49NsoC73dKXe@gmail.com>
 <20250317083155.9g9ksofZ@linutronix.de>
 <Z9fnf9g_zmbNXICh@gmail.com>
 <20250317092526.S1MfZldy@linutronix.de>
 <Z9f2_exjFEpTpuRr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9f2_exjFEpTpuRr@gmail.com>

On 2025-03-17 11:18:37 [+0100], Ingo Molnar wrote:
> Yeah, that's a valid concern.
> 
> The thing is, CONFIG_SCHED_DEBUG is mostly meaningless these days - all 
> major distributions enable it because of the statistics are useful for 
> system administration, tooling and general software development.
> 
> So we should enable it permanently and remove the #ifdeffery. I'll send 
> out a series to do so soon.

If that is the way to go, the please Cc me and I rebase on top of it.

> Thanks,
> 
> 	Ingo

Sebastian
