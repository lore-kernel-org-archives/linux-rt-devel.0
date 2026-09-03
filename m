Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127B84CA77F;
	Thu,  3 Sep 2026 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451636; cv=none; b=KvnissqG2JDvxpOKSql2QKLJ7fyHbUDMKKHG6Pwajz40s8nQpMMMBkcFQNkxISGAHNxoVzin6AsEmPu8RokgjNQfMojZ+ukU4Jgs8JPcc9hwxfItfVf4h8MtCx5KZ3AWbjiV+drneVy2z2EKTBkhS+PiwjQeoO+zVll6fXZd2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451636; c=relaxed/simple;
	bh=NhSt2URDT+IepuxkSnn7wmrY/hgpQI5zr5eWhS5hcGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj9D8D5B6UaS+B9EXv6Yv+0PemsgiaLyN62GJnZuUh/H+b9XszGolmHgRY9T7VkaKUffjODG2zJRYXtLDKe/oA3gh2y9Opz8WPi87Rtau79PnUS0ioRJg2cUXJS1midYqxaCVbIJtaEECUmWxR2jgsYYJoViFlhw83db6kI5zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xuZVTd+3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T8kn4im/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xuZVTd+3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T8kn4im/"
Date: Thu, 3 Sep 2026 18:07:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788451632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vbjCRdrjxVp6fckV1i3kt+QR+aoKiSt4PvLxtPMrkc=;
	b=xuZVTd+3e+XOsFzlbevv8WgpKXG5gTsuBBMkBxlya3sozHHOlzgelbcrxTZ3dc2S2fKUZH
	Eo2ofpB9QXz++1nNA+l2nW//I/NpSXT/vrPva2BUML6aRc3DqfHqlGlE1V2t3JJo/nIQwC
	4hoXTVevZUC8QVTDO0/gyce7p2CXCRV/uUfesLEFjgZfm0uG4U8QpsjXpPq1tbDCSMX+mx
	7gIEzaiL+A0P1bxr9Si/kf123/uOYqAAZha/i9aojgU1F18YicgLIuc7upSmZ7pQYX5oKR
	1iFVmlocKFD2B1HAW245xFUSV6/LtXCqmDzblVKJLJ/iTvmhYNie9oQEQsHYVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788451632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vbjCRdrjxVp6fckV1i3kt+QR+aoKiSt4PvLxtPMrkc=;
	b=T8kn4im/sQC5stFlPR2Bqz8b9qO4j+lZamw3HssQ6xL7wclpxMen7l/f/4CP0sh13GTOKy
	vasVqJQNc7WAdJBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <20260903160710.vVf4gEL2@linutronix.de>
References: <20260814085118.OPEA_Ssn@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814085118.OPEA_Ssn@linutronix.de>

On 2026-08-14 10:51:18 [+0200], To linux-arm-kernel@lists.infradead.org wrote:
> Waiman, Luis, Ada reported that HW breakpoints on ARM64 trigger
> "sleeping while atomic" warnings on PREEMPT_RT. The hardware event is
> delivered with disabled interrupts and perf intrastrucure expects
> disabled interrupts while the overflow callback is invoked.
> 
> The callback then sends a SIGTRAP signal for which it acquires
> sighand_struct::siglock, a spinlock_t which becomes a sleeping lock and
> must not be acquired in atomic context.
> 
> Delay the event callback until the return to userland.
> Add perf_arch_hwbp_notify(), a generic perf callback which delayes the
> actual callback invocation to task_work_add() callback. This callback
> invokes the architecture defines callback arch_hwbp_send_sig().
> This requires struct callback_head and the functions require
> ARCH_NEED_PERF_HW_NOTIF to be defined.
> 
> This was reported against ARM64. ARM and LongARCH follow the same
> pattern are also converted.
> 
> Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Reported-by: Waiman Long <longman@redhat.com>
> Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Did this get lost, should I repost it or is there something obviously
wrong with it and nobody wanted to hurt my feelings by telling me?

Sebastian
