Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441788;
	b=L9nDoPxaA4H/7rJGjsCRMyzWwqav6RL5KjSZSvpDEWV5Mn9bMChHC9CrS1LfiukAK5MN
	 vhNDRDLBvdtAZ20woHowcjpH4rJtniG0zekqVPnej2EmXilvTI8LIBBCbl9QmWAwcee69
	 RXWuepypdEhi9Qh1Ko7eC/Dqb3Xto2dfQ2TaIJeRdXtfAXDtCV/NuOcAPSHUj2TqC/lcc
	 1NTYsIIAVXBPOZHKg4OgnQukloJ55TzpJwJcM+9Vhi3wW7iwWdTbxQjgiWFaHSdJuGohq
	 l0UBW5yvPOBdk2s1rFV/tERfTtO1R6ft4DB8bZpy/gMmWFMg/9CJaAOkzvZOfagnb5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441788;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=UpujUNtVLMEOricETXhCsKflBHhrt+bC7MaQBA3CDjE=;
	b=mksqA/prvnDv91zH1wFMi//7me+KuaP+x9GuJdjMgTPluy9H6izN69uVN/XCtAL5IyBk
	 mcEPftMEGAhg0kJcQDaVbc3IbdblHU1sDmCmAaz4fBuJaMrhYAfioUUV23/QQNJbHZVqa
	 C3ttZnCyyPOLk6wHN4q7is7sDcXK2uCKEo81MFyBMS4YsQUBtTKnXBQgdoHV1NHBwcyQH
	 EUCU6Tp7FkkxeCHnQIcwmTgBEw6NmPBeI6OazDrNwnTh94E2KtKthGKOhnEhWuH4RKJRJ
	 Dsv3CZTXaN5Z4TwcalxprH8a2gZwR1no9RRDCzMcRaSgWpCudF6vHYoI2O9MD7hbaLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EP4WCUCo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2860606A31A
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EP4WCUCo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA78B1F000C4;
	Mon, 19 Oct 2026 20:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792441787;
	bh=UpujUNtVLMEOricETXhCsKflBHhrt+bC7MaQBA3CDjE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=EP4WCUCoRvFD6xmCmxcz9wIyT4mrvoDcmU8TlT0vOOXc7h6+UbSRUq+iyDdHP9p7y
	 HRHaLTCEsprF8IW1/IcT2LR6Zpa7I52gc0SyPHDAQRG/m3+iUWhM+9kkSTwOz9b1XY
	 +gSnZXX668jCsceHpmpkReN+DjkpWJqxWk17zQn/ZlRQn4LQByEJnOH/1zupBfnzVW
	 Oxh+i8kfBh609yy664j4wqJ2vBSvmwK1x2w+XyjWrbCv47a1JNNOk+cH/kF2iG1JHN
	 4scj+lzwrx4P/4qUb1dC5BYSEl3GQkFkRQ+u0Ni7uwxsoUB7hNZQL4VvMq+vn7sSHg
	 tvamktwT+xfAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5235ACE09FC; Mon, 19 Oct 2026 13:29:47 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:29:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <a65ce954-065e-4c12-a0c4-a7fa39d229b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016134030.6791c1e4@gandalf.local.home>
 <4a1667ce-790a-4d85-ba2b-55f8729eea3f@paulmck-laptop>
 <fee69cc3-731d-4612-8b66-ecc9f16175ca@paulmck-laptop>
 <20261018102107.210318fa@fedora>
 <846ce517-b063-4dc9-867a-603ff49bfd79@paulmck-laptop>
 <20261019143021.42fbde3b@gandalf.local.home>
 <41f07019-6412-415e-8f7e-5e5023ba31f6@paulmck-laptop>
 <20261019152833.1ed30510@gandalf.local.home>
 <b2566542-8554-4dc6-beb7-e58720bc38e7@paulmck-laptop>
 <20261019155023.500a79d6@gandalf.local.home>
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
In-Reply-To: <20261019155023.500a79d6@gandalf.local.home>

On Mon, Oct 19, 2026 at 03:50:23PM -0400, Steven Rostedt wrote:
> On Mon, 19 Oct 2026 12:39:47 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Mon, Oct 19, 2026 at 03:28:33PM -0400, Steven Rostedt wrote:
> > > On Mon, 19 Oct 2026 12:24:14 -0700
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >   
> > > > I have therefore updated the cpu_curr_snapshot_rcu() comment header as
> > > > shown below.  ;-)
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > /**
> > > >  * cpu_curr_snapshot_rcu - Return the task currently running on CPU *
> > > >  @cpu: CPU to query * * The caller must either be within an RCU read-side
> > > >  critical section * or must hold some lock that prevents the task from
> > > >  exiting.  * * Return: Pointer to task_struct of task running on @cpu.	*/
> > > > struct task_struct *cpu_curr_snapshot_rcu(int cpu) {
> > > > 	return rcu_dereference_all(cpu_curr(cpu));
> > > > }  
> > > 
> > > Since this function has "rcu" in the name, perhaps just make it have to be
> > > in a RCU critical section. Is there any time you will think this needs to
> > > hold a some other lock for not allowing the task to disappear.
> > > 
> > > That is doesn't rcu_dereference_all() cause a splat if there's not some RCU
> > > protection happening? I would limit this operation to just that then.  
> > 
> > Good point.  You can use just cpu_curr() in the update-side case.
> > 
> > Like this?
> 
> Yes.
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > /**
> >  * cpu_curr_snapshot_rcu - Return the task currently running on CPU
> >  * @cpu: CPU to query
> >  *
> >  * The caller must be within an RCU read-side critical section.
> >  *
> >  * Return: Pointer to task_struct of task running on @cpu.
> >  */
> > struct task_struct *cpu_curr_snapshot_rcu(int cpu)
> > {
> > 	return rcu_dereference_all(cpu_curr(cpu));
> > }
> 
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

Thank you, and I will apply this on my next rebase.

							Thanx, Paul
