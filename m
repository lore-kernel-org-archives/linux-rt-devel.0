Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0243328F5
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Oct 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233875; cv=none; b=gOiWRk4sgzo/MzRwvSjgBHVzK+PrlkK4hLN1YcqCFheCW0xs5RAJc71X+hoMDbiys87UdciMW2lEpRGGMrbjc05ybUnoxnJrKFh68Y12JvH93yEYOW3qLvRo7lUBPBPQIoNaKxdSJJKktCDCg/C54TjRNG47DN0IpmfN/m+r62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233875; c=relaxed/simple;
	bh=EC3g9AHLeHUmSF4j/q0gQb9YORG7GSDCE4q/Xm7Q05w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR592vOgpZUO/Dz+lmWnrfjHDJNaMlkVQDwxU7XdJiIveOdEveV9OFC8ibYa3T72DFVVS4Iayrt4kJ38cx7j0tnOsZrRzSahcYIKcXPqre2AjN5Tt5lSbr60gCzO9vbjzy83+XgCOWrRV+jUz95Pfkn5YJrYvTS3AzXuOsZOVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Te4XeR6/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=65KNA18J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Te4XeR6/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="65KNA18J"
Date: Thu, 23 Oct 2025 17:37:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761233872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Qx+sAQsaNcNRoE/7ZarptH3JJdNZEK1mG3xI8daWrs=;
	b=Te4XeR6/K5VTutVw/nvDNMCqmYAq6XShpeqs+7FKdoLP8Kz0QSpZ/TZCtCDUs7XGkca0oP
	9w8/U9Tt7gJ6gsWWXmYNkxDrR/l7ziODruGO0zb9pg3xritzhObSGvxhphuAZWQl8E/NTt
	LBl4eK00YRK9DAVdnMvk7eYOyAGh+Va9kOTe2Dw/3RBp69/z2joJZZiIBMiTm8RAD/MWH6
	vnZWyfUm49nN7ER4vyNlr+Anb56m7y4ATW1zVlOW53axvpyRGTOrcaFfK3W1ytRf95V5C/
	aVvBwb/4edArA8/sG0oXgNY7gVtv3sRzBfwji2rvWNLkef9U7KqGItIE3jtS2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761233872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Qx+sAQsaNcNRoE/7ZarptH3JJdNZEK1mG3xI8daWrs=;
	b=65KNA18JEG3+U7bqZw5KYcf1mMALWdEVC9aLw7QFq2xadkHZqjyb/prkjg12kVZRDsm01U
	SPSdpz3CMnlpj/Bg==
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
Subject: Re: usage of DEFINE_WAIT_OVERRIDE_MAP(LD_WAIT_SLEEP)
Message-ID: <20251023153750.C6EU9NL6@linutronix.de>
References: <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20251020145310.GA9608@redhat.com>
 <20251023135316.1ZRx0UU5@linutronix.de>
 <20251023152942.GC26461@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023152942.GC26461@redhat.com>

On 2025-10-23 17:29:43 [+0200], Oleg Nesterov wrote:
> Hmm. I'll recheck, quite possibly I missed something.
> 
> But. From include/linux/spinlock_types.h
> 
> 	/* PREEMPT_RT kernels map spinlock to rt_mutex */
> 	#include <linux/rtmutex.h>
> 
> 	typedef struct spinlock {
> 		struct rt_mutex_base	lock;
> 	#ifdef CONFIG_DEBUG_LOCK_ALLOC
> 		struct lockdep_map	dep_map;
> 	#endif
> 	} spinlock_t;
> 
> > rt_mutex is defined as LD_WAIT_SLEEP but this one is not the one we use
> > for spinlock_t.

I may need to update the comment then if this is the source of your of
confusion. The rtmutex.h header is required for the rtmutex bits which
does contain struct rt_mutex_base which is used below you see.
struct rt_mutex iself is not used here and has a different semantic
(this one does use SLEEP).

> Oleg.

Sebastian
