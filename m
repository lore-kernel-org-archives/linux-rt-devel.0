Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438788;
	b=SgaM20Gs+qw4kFGPRormZ9025zolzCypgTf/zJZTU9TvEnhIjpn0E7auo4mY4BHVrPBT
	 IEH9PXUFeAPaf1tutlPjfVDyffNAAv5ZS6wNggTjebJDl2vg6+9w4ujOzXsVaSVuckNLC
	 YoNdn7KGY01srQTNcGoVZIjdy1N17AuSeAdTfe/uHCbY+Q5ykvfW34lV2QZh8y2gUNhwD
	 V28074CV3AXvQu4czoIJg9HlAE4/irornLs8rIOrGPZ34NXBVHfiu9x3gW8AaKOrnqFVp
	 65riao5ZO/0z9lSQBmFlzkh8eE1nUkjGzsNd/oD1fOHqbLY2VjxLtEAuEqKelaA+TuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438788;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FwUq9Y8bgAgK/5rvUtxb/X/PaDuJtyewBNoCqm0RlIQ=;
	b=IDBZApHaQff73NfD+/55nGID0M7Da3sLTkhYx+J+NwnW4LsS5r3Acpg/PS9EVsZO5kTu
	 Qv48zQpaAFeZ9lCoo2XhGzwt4Ty82smerPc4/d3ojGb2MiGUmfQ9m0LgOYt0wxm1SLLJz
	 biisAr4Spzzc8LuVPWDR8Xuje6Qsna8Lj17ZmgSGB5oQyKsiiqPYl+aVrpQUVpLGd5IDV
	 hTvMFAZixGTl+Uug+b6ufvnEYp9gd3ugLCj86lYj+IKY/+WxblUd6x4cn5pAJAQ3N/nVJ
	 GuiOuL+6MNGg0z8RbAeswfTPADn7ozRllvq25q0jkD5Mb835bObccRqj1NWnK+qXVlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtrJMTJQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AAD606A326
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtrJMTJQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816B91F000C4;
	Mon, 19 Oct 2026 19:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792438787;
	bh=FwUq9Y8bgAgK/5rvUtxb/X/PaDuJtyewBNoCqm0RlIQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=EtrJMTJQuPhgLQlIhV66aWVvFYSI1dtAvcU0wpTY3475ux6F2UAg3Uos82fbQOFCz
	 c1nBfrZWXJw55DgjIEK7r/OshbZMnvvagl8S5to7jvwvnEIGAb6MaTPzodT0d7oN+j
	 d3d2HcPj/Cvy+019dDf6Os9RE9Eqq/0lNMkLuBDqZiAL6eUZX8cmUkb+pdtpSLuCHI
	 c/Ox43RmWX/VLyfQPwf4Th147GQqwhT36y67ca13Vf0t1A0u2s7iBKJRPDwJgL13Ba
	 tn1p5y72xQUgxL3z9EBnNqWnPX2lM+i/1fY7WVMLnSsbyQTnY4Q9ArDDLPHRieYNAJ
	 MWsiZxLLshe7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4224FCE0A6F; Mon, 19 Oct 2026 12:39:47 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:39:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <b2566542-8554-4dc6-beb7-e58720bc38e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016125453.36ae8efe@gandalf.local.home>
 <112aa888-a2b9-438c-b850-d802eec54e7d@paulmck-laptop>
 <20261016134030.6791c1e4@gandalf.local.home>
 <4a1667ce-790a-4d85-ba2b-55f8729eea3f@paulmck-laptop>
 <fee69cc3-731d-4612-8b66-ecc9f16175ca@paulmck-laptop>
 <20261018102107.210318fa@fedora>
 <846ce517-b063-4dc9-867a-603ff49bfd79@paulmck-laptop>
 <20261019143021.42fbde3b@gandalf.local.home>
 <41f07019-6412-415e-8f7e-5e5023ba31f6@paulmck-laptop>
 <20261019152833.1ed30510@gandalf.local.home>
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
In-Reply-To: <20261019152833.1ed30510@gandalf.local.home>

On Mon, Oct 19, 2026 at 03:28:33PM -0400, Steven Rostedt wrote:
> On Mon, 19 Oct 2026 12:24:14 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > I have therefore updated the cpu_curr_snapshot_rcu() comment header as
> > shown below.  ;-)
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > /**
> >  * cpu_curr_snapshot_rcu - Return the task currently running on CPU *
> >  @cpu: CPU to query * * The caller must either be within an RCU read-side
> >  critical section * or must hold some lock that prevents the task from
> >  exiting.  * * Return: Pointer to task_struct of task running on @cpu.	*/
> > struct task_struct *cpu_curr_snapshot_rcu(int cpu) {
> > 	return rcu_dereference_all(cpu_curr(cpu));
> > }
> 
> Since this function has "rcu" in the name, perhaps just make it have to be
> in a RCU critical section. Is there any time you will think this needs to
> hold a some other lock for not allowing the task to disappear.
> 
> That is doesn't rcu_dereference_all() cause a splat if there's not some RCU
> protection happening? I would limit this operation to just that then.

Good point.  You can use just cpu_curr() in the update-side case.

Like this?

							Thanx, Paul

------------------------------------------------------------------------

/**
 * cpu_curr_snapshot_rcu - Return the task currently running on CPU
 * @cpu: CPU to query
 *
 * The caller must be within an RCU read-side critical section.
 *
 * Return: Pointer to task_struct of task running on @cpu.
 */
struct task_struct *cpu_curr_snapshot_rcu(int cpu)
{
	return rcu_dereference_all(cpu_curr(cpu));
}
