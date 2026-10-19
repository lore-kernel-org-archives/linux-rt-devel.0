Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437855;
	b=Mu4RaDgsm78dVKs5TwCRTIEdF+FywRK+gpB93bKmHLT34zMXKgfjzq5/9HjLdQGqfuq6
	 PBWazm4ijOsfk8VlF8cMI3yocMw/PxUWurmVrhrPtsgL2kEgMVoaF4g+0IDgxffw43337
	 oCFmF9+Sx47rJZzN4Zxq1qgoFebp+ajyCmqrcNPUce4Jh6F6hKAQBkzIKcYfbw6IruxVM
	 J8vKUUDYAmEpUq8fJv9PU1/Tbmzsa3myALyeRGEa/18YkODsgygEfk0k+290zKexhWpYs
	 rjdErKdIj9bPpSe0CeqAiQEHTkVzplnqa2oXkBe5BWEPCAaKs47JuE/0g+AZp/MhilA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437855;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=nzLMEMnqyIVG02Yl5AOdRJVA5gu12AmhcxT0tW1HYRo=;
	b=X7f7JBxx4YNMneTic8zjVGXPWtpBeYaI/6ElWC8OX8IfeJMHQ5weZ+5pWPtYhAPIrbnx
	 AjGXAM5lPi9xOOsIq4KVurzWmoaTOTEIG3qddOu8XWdEQFKpeFx1xWkgdsI4NMD4MrxdU
	 DdiwdedPjWLUx0knTXXgIh80OY5O4BoBQvIhMMEzAsxbfDH/HcQHcyKmsbT3xtN5chfqp
	 fEoDnIH+atc8KN88TxPThQZvNaOrV7jjCPzbtVWpvbVo3beK+CT/LSl/WN/6EmseyPb++
	 XwYgZSqBfA5FeEeutBOubooT0bOUhrDbaSXLl4QJPpCpGmYRz40bqmtbl9XzFAjZyNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsgJLIyC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C360A2626
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsgJLIyC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FDF1F000C5;
	Mon, 19 Oct 2026 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792437854;
	bh=nzLMEMnqyIVG02Yl5AOdRJVA5gu12AmhcxT0tW1HYRo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=EsgJLIyCR8BrH7C4AnR6gYDYYoTReYwtAZjnzyV7bXf4iuM8+fT/XVXMSy0DPD1qr
	 j0j16RnMjveMF/ZLSyFwmGmXMAnhVbjCHGraDayQX9SxdChqz9d75iXNnDIPpC90lM
	 8Bsdtg9kUfoEYhAgd+Koj5LMiTBQotjCk3sjZ4ICjcWU9pqToLRCCST1+7hQBDm5tx
	 5Cujun+XbZHASVKLweNVbshkA+e18ptvvflYJn8Go6ysRz6Dhhv8D88jgdxDCCTjJ1
	 NjtECOmjnhUTwxd2M7IgE5tRWnHxFHrZHVL2W6xD4K7/4ekS0uJv2a2Axpmqi1h2yY
	 L3YNmx7TSE0NQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AA3E1CE0A6F; Mon, 19 Oct 2026 12:24:14 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:24:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <41f07019-6412-415e-8f7e-5e5023ba31f6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016121753.0da4e4e1@gandalf.local.home>
 <d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
 <20261016125453.36ae8efe@gandalf.local.home>
 <112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
 <20261016134030.6791c1e4@gandalf.local.home>
 <4a1667ce-790a-4d85-ba2b-55f8729eea3f@paulmck-laptop>
 <fee69cc3-731d-4612-8b66-ecc9f16175ca@paulmck-laptop>
 <20261018102107.210318fa@fedora>
 <846ce517-b063-4dc9-867a-603ff49bfd79@paulmck-laptop>
 <20261019143021.42fbde3b@gandalf.local.home>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019143021.42fbde3b@gandalf.local.home>

On Mon, Oct 19, 2026 at 02:30:21PM -0400, Steven Rostedt wrote:
> On Mon, 19 Oct 2026 10:30:40 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 559735f71b5dd..1fa63eee528c2 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -11320,3 +11320,10 @@ void sched_change_end(struct sched_change_ctx *ctx)
> >  		p->sched_class->prio_changed(rq, p, ctx->prio);
> >  	}
> >  }
> > +
> > +// Not for mainline, but hopefully someone has a trick that gets this
> > +// job done.
> 
> Still not for mainline?

Not yet!

> > +struct task_struct *cpu_curr_snapshot_rcu(int cpu)
> > +{
> > +	return rcu_dereference_all(cpu_curr(cpu));
> > +}
> 
> Anyway, LGTM.
> 
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

OK, definitely a big step closer to being ready for mainline.

I have therefore updated the cpu_curr_snapshot_rcu() comment header as
shown below.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

/**
 * cpu_curr_snapshot_rcu - Return the task currently running on CPU *
 @cpu: CPU to query * * The caller must either be within an RCU read-side
 critical section * or must hold some lock that prevents the task from
 exiting.  * * Return: Pointer to task_struct of task running on @cpu.	*/
struct task_struct *cpu_curr_snapshot_rcu(int cpu) {
	return rcu_dereference_all(cpu_curr(cpu));
}
