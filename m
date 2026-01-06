Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362AE283FC4
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717640; cv=none; b=kApU+ZNW03DK63cKh7YBYZ8+5r2dJrDFB4QJxpcUjNuKBxWZg2JLAhU6cSDKGa30EEDDpnmife+rOF/C7H/ILLZEnwQ3ICYaj5FRFSdYf7Y8FJWKeS5uikt4b+k+G09BDPLz4yYt1JBlZpslPgPaCFfYbsBvV7CdUD++PH9U7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717640; c=relaxed/simple;
	bh=cv0CNqbhvwhXwGixk7KZ84VrSqqQadGv9IM/BJcvbo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lB3UX1rmqRjAqGlEcd6o/LpEQQ5/xf4l/og1CCAxTEyj3YctwiYnLX4CejYEFoX+IxmDnZrFUJvbJfILipqqZin4CUTMwkRYulWkpmpyUESPh1QlLstMNae4VTfz89J/upUmqiewAmKfuvN12NAJZm9ekTEe89Vis/w5bqKjGQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 01D2BB99D1;
	Tue,  6 Jan 2026 16:40:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 0D6A82002B;
	Tue,  6 Jan 2026 16:40:26 +0000 (UTC)
Date: Tue, 6 Jan 2026 11:40:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, clrkwllms@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched: Further restrict the preemption modes
Message-ID: <20260106114051.61248cfb@gandalf.local.home>
In-Reply-To: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0D6A82002B
X-Stat-Signature: 8s366ckf5ikwsyc5osrgtpdmmofuoyt6
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+gozk3ARDPYZcrurgDcL7qgjFnD0PTsEI=
X-HE-Tag: 1767717626-176335
X-HE-Meta: U2FsdGVkX1/Lv2nomsfkH1PDzUzGbfgfAOoSx2VmxzlzLwOE6bHLjByniWn97zNhMtzpstogTJxEom72go+SgN6AgQhY+XbXbWYXw+2aeFLbPWi4v/gLo/G+ppPfJa+2mwIIZrSxXGw0uBNzLvkQeqSaeo+Q6h+MzNyPSVir6atrTb31hd0K2Dz0Hl5DvNXJ6IuA0sAUdqRtF3MRm6k0EG2pcX5W//zq6Z1GjEnFd+3kkLupkjJCUabZGfzTusi56eyjskgTkPfpFaqgYpc6Uc/iCcjBu7p/e6kmrfUJs4pCtFBwv58PvcDVcRmt1MKuthSHCOgMaPXb9QSUQVWybCD8BiofouFFCf2zul9wkdYGK/1AWl6ZyN6Wp9Hqp9L1

On Fri, 19 Dec 2025 11:15:02 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -16,11 +16,13 @@ config ARCH_HAS_PREEMPT_LAZY
>  
>  choice
>  	prompt "Preemption Model"
> +	default PREEMPT_LAZY if ARCH_HAS_PREEMPT_LAZY
>  	default PREEMPT_NONE

I think you can just make this:

	default PREEMPT_LAZY

and remove the PREEMPT_NONE.

As PREEMPT_NONE now depends on ARCH_NO_PREEMPT and all the other options
depend on !ARCH_NO_PREEMPT, the default will be PREEMPT_LAZY if it's
available, but it will never be PREEMPT_NONE if it isn't unless
PREEMPT_NONE is the only option available.

I added default PREEMPT_LAZY and did a:

   $ mkdir /tmp/build
   $ make O=/tmp/build ARCH=alpha defconfig

And the result is:

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y

-- Steve


>  
>  config PREEMPT_NONE
>  	bool "No Forced Preemption (Server)"
>  	depends on !PREEMPT_RT
> +	depends on ARCH_NO_PREEMPT
>  	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
>  	help
>  	  This is the traditional Linux preemption model, geared towards
> @@ -35,6 +37,7 @@ config PREEMPT_NONE
>  
>  config PREEMPT_VOLUNTARY
>  	bool "Voluntary Kernel Preemption (Desktop)"
> +	depends on !ARCH_HAS_PREEMPT_LAZY
>  	depends on !ARCH_NO_PREEMPT
>  	depends on !PREEMPT_RT
>  	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
