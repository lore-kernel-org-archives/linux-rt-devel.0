Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439434;
	b=mvJy6wtVkL/S2PM/JRTv3lygkb0AfQHetXKmU73LWXoFjLMiVbtwZdTKStzM83Ff928h
	 qh7wBbto/qS+TqPIdZuETAATcSRWqp5OSClyO/d7aOEYwznBQozSBSTCMzQUgJL1Fct1k
	 GozJGPfkyAu/PJnfXJcFFnJIaEro33ze+FK9Fabvlu5sV520W/32sqov/H52VWfnhwzV2
	 qs+l9q2fxx+M10VHK6AyfNAJXR3rZP88Sp/pQG5oa2nzA6g0bcKz2K3aFJoEpXaU1vzPF
	 A6LMLpoQF03cfffKIcAXzZRuJ0+vuRjH/MvqgRed9jrFLjJaPzFy62kJqbFIGIDk1ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439434;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=kEHGyEQELkSv86mWjpDTaJX2odWRH1ZpSoqipY0L9CA=;
	b=e5KMY3A+ip7zSK7PeG6jD/P2DBYPRc4F3RZ+LdY0MoIi9GJKfsj02llJaR7wdwEXcWdx
	 CGVO7QESyS5sRSPAZBDnjMNdEoZHN23QHoYjTX9RvB7RtIaBua4WyTRY+9Z4uIrbIyEPU
	 llaA2NjsoDdZOIsyI00wHGRW8gtRvggnLyV65l0tteNlRkn2aBqm64We/kW1hsWoy3e3H
	 g2ew4TQRolET+I0LVAmXuTlHQQA1mR8Bqeosa6/CDADywB+j9JbcWIJXhwGtaKSUhRygZ
	 TUGzJ+iiFZ51eOGv9TZolZfG+OOhC5yv+oGQ587U6lcuQpaxTpHI/iul2i86aR0hzTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=u28zKpBB;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E1606A319
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 313E1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=u28zKpBB
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id DA43DC07C0;
	Mon, 19 Oct 2026 19:50:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 2DB4860010;
	Mon, 19 Oct 2026 19:50:24 +0000 (UTC)
Date: Mon, 19 Oct 2026 15:50:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <20261019155023.500a79d6@gandalf.local.home>
In-Reply-To: <b2566542-8554-4dc6-beb7-e58720bc38e7@paulmck-laptop>
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
	<b2566542-8554-4dc6-beb7-e58720bc38e7@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 2DB4860010
X-Stat-Signature: wn31qiz5uwuxkmfjzzibkbfb1xy51es5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1858I+CTRsz0FG22VRROjtZn0ZKHc+Ivb8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=kEHGyEQELkSv86mWjpDTaJX2odWRH1ZpSoqipY0L9CA=; b=u28zKpBBcW9yyb0RKl3PTOfIx5CSslUXGn3BSk/FZLSP0T8jld4K8ntzaSREY+QWkOuOgovLsoYJjTkYNgArkPc4qNhpprV1xXkxX3yO8n7kP4zjkZhoRmi/vcn8IDeTtBhfuUCs6eyO9cytVLkhkI22y3LC/2G4btuy8f3Rk/A=
X-HE-Tag: 1792439424-706691
X-HE-Meta: U2FsdGVkX18Vif+ZxTM0YxFie8OyuI1yEmt+juc2kuK3juSBBtw96+f94lEgBcYzFQYWQDJXMUoA3jijiPi3zRb5JxFfGmhochEcxh694toXySgcAZXkDbjQS+TQ+4cHqoeS8Fr+MGByhMxpYlW5QgGsLRi0RiGGGjnx5IfBcd36e+d33KI72vIwSEsf5pkWSTqP3XXC6UNnKB5F7CLBgVfs5ik4OWbg161oCX17JAd+siN+cuNV4O+FUdV0NsVF2NAnNuMk/o8VPyt6bY2R25MzIlv4Kde65GfKIMacTyNTciYriG164ByjUny7mWHEwMb64lsbJYfnIplBm8Nq1qrqlBMaoPprXXqT6dQpV1lI2OJjY9piB3rLe8/gcMP+1vZlyQ6gvoUOu7GJwWg7Jg==

On Mon, 19 Oct 2026 12:39:47 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Oct 19, 2026 at 03:28:33PM -0400, Steven Rostedt wrote:
> > On Mon, 19 Oct 2026 12:24:14 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >   
> > > I have therefore updated the cpu_curr_snapshot_rcu() comment header as
> > > shown below.  ;-)
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > /**
> > >  * cpu_curr_snapshot_rcu - Return the task currently running on CPU *
> > >  @cpu: CPU to query * * The caller must either be within an RCU read-side
> > >  critical section * or must hold some lock that prevents the task from
> > >  exiting.  * * Return: Pointer to task_struct of task running on @cpu.	*/
> > > struct task_struct *cpu_curr_snapshot_rcu(int cpu) {
> > > 	return rcu_dereference_all(cpu_curr(cpu));
> > > }  
> > 
> > Since this function has "rcu" in the name, perhaps just make it have to be
> > in a RCU critical section. Is there any time you will think this needs to
> > hold a some other lock for not allowing the task to disappear.
> > 
> > That is doesn't rcu_dereference_all() cause a splat if there's not some RCU
> > protection happening? I would limit this operation to just that then.  
> 
> Good point.  You can use just cpu_curr() in the update-side case.
> 
> Like this?

Yes.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> /**
>  * cpu_curr_snapshot_rcu - Return the task currently running on CPU
>  * @cpu: CPU to query
>  *
>  * The caller must be within an RCU read-side critical section.
>  *
>  * Return: Pointer to task_struct of task running on @cpu.
>  */
> struct task_struct *cpu_curr_snapshot_rcu(int cpu)
> {
> 	return rcu_dereference_all(cpu_curr(cpu));
> }

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
