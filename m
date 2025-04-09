Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FE4267B00;
	Wed,  9 Apr 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213333; cv=none; b=D0d40ubzWXrrZnrrA3WSai+20j+jg/9DBCzAa52SZ+nDV2qOXbUnbRAp0vMhQ5gtWTLzuNN+DzJ3zuO1dK949tYEQk40bmQ8fD2W+egouCr40WIFPPLKY+Ue/krm6mEmDxsXlDspwPO6r1HqojtbGLxA2n+LNN8GYULsu7LLVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213333; c=relaxed/simple;
	bh=WC1VfsSLvnSOjUPL0QpZTEJJPqGDT0zFmkUzfy8MhBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTYC7X4tCEKM3CFyE8ZrP54x0mlzPBYY1R3iOYNV32uahwss18VuT+QyaIijHduUv1YgUGOp6jU1WUqrnHARkhC/RuwqCKNk+I+dDmcHs3aiQQsyNAfoW7HUNROlAsVyePnghT2W0xBiN9fb/dzPVo+OtgXuU755LLtvPhxNOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314AEC4CEE7;
	Wed,  9 Apr 2025 15:42:11 +0000 (UTC)
Date: Wed, 9 Apr 2025 11:43:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Tejun Heo <tj@kernel.org>, David Vernet
 <dvernet@meta.com>, Barret Rhoden <brho@google.com>, Josh Don
 <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Juri Lelli
 <juri.lelli@redhat.com>, lclaudio00@gmail.com
Subject: Re: [PATCH] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250409114330.1444221e@gandalf.local.home>
In-Reply-To: <Z_W-i-ya0Q6fkXRh@uudg.org>
References: <Z_W-i-ya0Q6fkXRh@uudg.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Apr 2025 21:27:37 -0300
"Luis Claudio R. Goncalves" <lgoncalv@redhat.com> wrote:

>  {
> +	bool defer = false;
> +
>  	if (!refcount_dec_and_test(&t->usage))
>  		return;
>  
>  	/*
>  	 * In !RT, it is always safe to call __put_task_struct().
> -	 * Under RT, we can only call it in preemptible context.
> +	 * Under RT, we can only call it in preemptible context,
> +	 * when not blocked on a PI chain.
>  	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> +#ifdef CONFIG_PREEMPT_RT
> +	if (!preemptible() || current->pi_blocked_on)
> +		defer = true;
> +#endif

Why add the ugly #ifdef back?

	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
	    (preemptible() && !current->pi_blocked_on)) {

-- Steve

> +
> +	if (!defer) {
>  		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
>  
>  
