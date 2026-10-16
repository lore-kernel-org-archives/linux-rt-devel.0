Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A14E3259
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172436; cv=none; b=NWn+h/rRMT/DORinqGgzTlOEV/x2TP5DFxgSrDFhi0Y58uO1HFtjLjR3hG37HxvCVCTxGFuZPHEX0bGghnnvYBHerio+AbgZUsUoqE4ryU8SY0BTrqKpYH7RddHsiLAxyygqxZrf+24V3WlgDfa5XYSxCbdn9d0pTU9sP8Hg8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172436; c=relaxed/simple;
	bh=D3/lag8pJSn1gYeTmtSrPcsSt4ivK6BulehEZUHQmLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JW3ShxH+ZBapNH0A1Lp8DAUtBh4Pl/UNLmr6P6OkXrGROAqjYw2Lmn2HF/JmukGIJdERh59qc4TSoEdLPx4Gff+LNCXhcnHfB2NK3s/qMD/v7aQS2C2zM1f9lgoLmt15e/xkp4wZi4UeyzbZNkuDnmUVQLfHc4UDYqTE/Tji8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Utf5nqH0; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Utf5nqH0"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 59C871C3C7C;
	Fri, 16 Oct 2026 17:40:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id ABD032000E;
	Fri, 16 Oct 2026 17:40:31 +0000 (UTC)
Date: Fri, 16 Oct 2026 13:40:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <20261016134030.6791c1e4@gandalf.local.home>
In-Reply-To: <112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
	<20261016112339.6d6ac80a@gandalf.local.home>
	<7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
	<20261016121753.0da4e4e1@gandalf.local.home>
	<d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
	<20261016125453.36ae8efe@gandalf.local.home>
	<112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: ABD032000E
X-Stat-Signature: fenare5qnhfapk4zgig51q9xmshaokzd
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/szY3aDJaUPmGqX2QZIk0OkouSMUfnGQ4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=DJYnKEceEi3vHm3lsfXU8ZEMuW2LY2dfcVLgNAS3r6g=; b=Utf5nqH0MOjlUunp4IUvF1g6k62ogjlPyzGTZBEWbS5dFxf6RTIMNAaIup5w/WIFn/L21qTRSVFZfSSuMwCgoFynIrqm+OJ2dOjBDqklHy87lz0E7C0uq10ca2DSTtR5yNVI9ZJwNAt89xua10s3zuE/gJ0N6or1DpvWgiBh5CA=
X-HE-Tag: 1792172431-359204
X-HE-Meta: U2FsdGVkX1+xkpcuFfEcH2D8lNmYGIhHlgGDhfwfoL55Kf7ZbZzDX4KmInwgIZyK7pg7IBsckYlkf700cL7vSg0d70LxgLtmI+vezTEZw/FEmLSTfASgNtuw9fri9fx59/S0/DlEQRnCgsXFUkHZtxm9depDbb4zf0nIpURzRSrdF/DOBkOes3GbIlT/Pxp3DBLL3zYcOMKJghjzRRl5P6T0y9cyaPl7EAA5ZNpmtLtee/OoNm9FRGsR/rVci0Os2wrUJJAMo1SvsGlmTE8/U8pvkRBcfh7asnNu35v36blSLHyv82gzFXX8rhnjKxxw+uo9GqxhYaWvI5gaJ9w3A2nN9nMP9VBq

On Fri, 16 Oct 2026 10:05:02 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Which might mean holding the rq lock in check_slow_task().  Except that
> task_call_func() already does that for me, right?

Does it? It looks to only take the run queue lock if the task passed in is
running. But isn't this task usually blocked?

Maybe we can add a special get_cpu_curr(cpu) function that could not only
return the task but also get a reference for it too? Or NULL if idle.

-- Steve

> 
> Like this, to be folded into the existing patch?  Or am I still missing
> something?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 33e953bb40b33..b314d79c07840 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -336,6 +336,8 @@ static int check_slow_task(struct task_struct *t,
> void *arg) rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
>  	// Interrupt are disabled for RCU read-side critical section. 
>  	rscrp->rcu_rdr_cpu_task = th = cpu_curr_snapshot_rcu(cpu);
> +	if (th)
> +		get_task_struct(th);
>  	if (rscrp->on_blkd_list) {
>  		rnp = READ_ONCE(t->rcu_blocked_node);
>  		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
> @@ -402,6 +404,8 @@ static int rcu_print_task_stall(struct rcu_node *rnp,
> unsigned long flags) }
>  		lockdep_assert_irqs_disabled();
>  		put_task_struct(t);
> +		if (tc)
> +			put_task_struct(tc);
>  		ndetected++;
>  	}
>  	pr_cont("\n");

