Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E22528FD
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197513; cv=none; b=mxP8aosArUSZWvR/H1Axp+5BwCls+HGgMtJH0StzJkT8ITEmsXgJd5zIwocjPGMWd3c+HkfRB+KCPuF3wzI5XRgvOmrbExb/RcRoeXqcckcuwGotU7X1X4Uim2rFT+hnms35mYotXKjeUbYqRPMqT5Tm3kSM9qmcUHkuKOZ+Y5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197513; c=relaxed/simple;
	bh=EnW58wjUZzLHH0kmASDa4WNdQfuc4EB1UDxkeEIolzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izkeil3i5e6Cm+eGhP5WvT3P3KbLLTxGUgKCZl+lEti20tzh4aXiEvRNuuAXLM5Pdy/E3huRars99DR/xTt9tyVsbTHUEOusPIxNKKW0Nm4v65NbdZbJ4UMEkRv76rLMuBtPh+OomR8Xwkl18uUetUMJU3s/d/ejDQMPAwEhMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bqMvMye0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/6xCl8BO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bqMvMye0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/6xCl8BO"
Date: Mon, 10 Feb 2025 15:25:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739197510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1vWLuCbK7H0/XbL5hiAH8Qspdgx/y77kys0v1c8WNbE=;
	b=bqMvMye06P0vCJgC9iRO7t+cH0gAejDkGd+gzF69uFUC8DtFGyw8SpZJWpqi1/ZM6+D0z5
	tdk2Uia5EtUBjbkSHNT0Uzu/ePwnfmO4gcVrq2st9cayG38Q6Mi8LrBuHwCtltLZPOBN6h
	DBNyxCGiFshaCz/aZnQtWpSPjys5hsaFMoJ3WVvGihordxfn6NeaWHPN9lEe11hYC3JPFp
	ro2G3c2z5al9NnxBnuGS/qdrcVAgEJvBPIwZ4n97nXc0Tlvhu/Y6g7GA4nxM5IW5kuYJyU
	qFpqaXwXlf3V9tYDsqI1b3ec2bMStL5kdnV9bOuwr3zkJLG7ol98DQTcbJj+/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739197510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1vWLuCbK7H0/XbL5hiAH8Qspdgx/y77kys0v1c8WNbE=;
	b=/6xCl8BOB85LeK7geGOncv1o6lssisxynRkhnUg55mat89XZIT/oSjc5swWLnLOhxTLVrE
	dCd12ZXpJNASGuAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/9] sched: Add a generic function to return the
 preemption string.
Message-ID: <20250210142508.vmMQUDkJ@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-2-bigeasy@linutronix.de>
 <0d4418ab-d531-413c-bbbd-6c97ea320490@linux.ibm.com>
 <20250210105240.FTbUbs_F@linutronix.de>
 <b7740edc-ea89-488d-9d6e-d31f5f1dcae1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7740edc-ea89-488d-9d6e-d31f5f1dcae1@linux.ibm.com>

On 2025-02-10 19:51:33 [+0530], Shrikanth Hegde wrote:
> No No. That's not what i meant.
> 
> I was saying, as peter mentioned in the previous discussion, can we put
> something like below in changelog/comment for a easier understanding.?

Ah. Okay, sure. I didn't realize anyone was asking but for this.

> "
> RT+DYN:	 PREEMPT_{RT,(dyn_mode)}
> RT+LAZY: PREEMPT_{RT,LAZY}
> RT+FULL: PREEMPT_RT
> 
> DYN:       PREEMPT_(dyn_mode)
> FULL:      PREEMPT
> LAZY:      PREEMPTLAZY
> VOLUNTARY: VOLUNTARY
> NONE:      NONE
> "

Sebastian
