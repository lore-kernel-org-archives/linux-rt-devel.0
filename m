Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584155;
	b=f+Ok0bCvKU2IMjCudIKOLeVlNV0Wx9j0u82fcRS1lBhIApVIZoJhnK+IjjlETZbSsA/H
	 mHNTsc+2071uBWG/p1FHrwWvMh3QQH6BzCF6qEJgFsQc429lOKEFyy9+0N/KL6TP1j+Ip
	 lhh5nr6jlfGZNZV/wyTJvgXcDY2fxdbj/29LbmdJCuz9tDwOjpCsmn/enXRZMj5CZiHdW
	 7/KP0efn+upM1dwvsjforQkaAkmvAVTLb2LqQGmXwSHKW+Nnn5de2XFreYfs6WuAfNlpk
	 oXIOrL5yJ88SZ/MzWdSd8Lwlg70lAzhNDrGb+7Tu7mA6MjO4LDNqHjT6k/u/DQfqAgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584155;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=eENWBnJtgnxkeCEWDwpBHaEkmEC443mWMB3XziA++b8=;
	b=mbKbdwfS0tU7k7kGtPf5ghv+AtajWnGVV5HWVcgQozq9231OZt2ySLFKPmFLk/aYRAzM
	 qYxYe12ZpzXyOzXlppoKotNDTRjwSgYskgHCRq0xJN2YTcKFwNDoUKyyGOO/eh+7BwDAP
	 nJguDCA2hkuovgyVaz0u7cALmCJQ3CLGx20W11ZokPwf3/1/nxDzmwWSqFYlQI6YQ+PBy
	 oLNpuw3QytVy2RS7OQbf9iBxxRFN7aufAi+sgxoNNFyoZPcRmV4DwzuUr45pVuQV5l4XN
	 2hidKkM5tfMsgKYQXh5rjRE+Hjma35LBrOq75lQpFOXgAPJgpiaBuOtc9ChEziiwqfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="xEanFWk/";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="wT/g0jrJ";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B8E606A327
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B8E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xEanFWk/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wT/g0jrJ
Date: Fri, 13 Nov 2026 16:35:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794584151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eENWBnJtgnxkeCEWDwpBHaEkmEC443mWMB3XziA++b8=;
	b=xEanFWk/eX/GNy/8MpQ0p2pI/8fGDs5oclLPxulXJgdFtRYQtGUU8HFBpDXIMU383u6IhE
	bOFHXQVgWt4p8wVFRHUXaeCKdPLlxrESDok/M29JQIPxlgU4iu5G1ssX2q+JEyxTgUpdqq
	FDKi5NQHfC/rWrbC4Ly7mSyk1MGc3HOS38mTb2lNhqRzZ2T5sWJbOPh95wn3lrFthqyj+c
	XA3ncBGy/ZVuH0YBv/bbC3+PSHNssVc5p3SRyCpKXQDjmZEGTD0Nd6JDghHfJfgbXTr45W
	75XkTd0Su/EbOhVUBMMvavQuXt2ZaAvC4zCyMZVBE8m9FWObaXa46J1MVomywQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794584151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eENWBnJtgnxkeCEWDwpBHaEkmEC443mWMB3XziA++b8=;
	b=wT/g0jrJ+6hEAou2+sVORwBr41g0MfEO5f/FbPSPfGCd6O6/0knTW3ZziVl8zgMT3JoDFr
	JqK9jFjBida8cWAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Dario Faggioli <raistlin@linux.it>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/deadline: Check SCHED_DEADLINE affinity under the
 rq lock
Message-ID: <20261113153549.Z8XPohWU@linutronix.de>
References: <20261105164856.29698-1-parri.andrea@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261105164856.29698-1-parri.andrea@gmail.com>

On 2026-11-05 17:48:43 [+0100], Andrea Parri wrote:
> __sched_setaffinity() calls dl_task_check_affinity() before
> __set_cpus_allowed_ptr() takes task_rq_lock(), whereas
> __sched_setscheduler() runs its admission test and switches the policy
> under a single task_rq_lock(). So both calls can pass their checks:
=E2=80=A6

This looks fine to me. You do the check under the RQ lock so everything
that you checked can not change later on.
If you race with cpuset then you try to revert and drop that check-flag.
I can't comment on that. It looks wrong to set it to CPUs mask which not
part of the domain but you made a comment why it needs to happen. So
stay out here ;)

You could keep the check in __sched_setaffinity() so it bails out early
if it is not possible right away. The check under the RQ ist just due to
the race window that we have. But I don't have a strong opinion on that.

Anyway. The reported problem looks solved to me:
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
