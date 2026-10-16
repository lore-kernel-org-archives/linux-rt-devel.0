Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F73750CB
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163391; cv=none; b=taCGc5gG571bkoQGQFH0ANmKimiu1fTxZJJc4+oT84gNKf8Yig5tCJ/CD4bdJqKHzIpUfbAJl5MeonnV8IwcsEi5sEfxvDI62n5xVxZYS3cg7eIfOY0ROODY1Ti+hpDuvs+3Rk9CxCJyADLzDUt7NByGjQyICrDrKW4CMpKGQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163391; c=relaxed/simple;
	bh=uWyTM3QzjfAD4cNWYb/S3ihfcGvrBtefXvrfNc/jAgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvJYQilEMyaTGTtdTxrABiPdEd1/ygMhy0z/HaQoi+NIJI9XPmSReBSUYw0yj8YsxQdBj/Bdel4vlFFjN3B6NkbxyaoQTPPiIY8YK/+ErciLVSfrtTyPjV6C6b8JhTOqGaOzHjc7wnkCW87szIm4664MLcX2a+nDfBfETdreN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDo7lxLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDo7lxLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94951F000C4;
	Fri, 16 Oct 2026 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792163389;
	bh=5NTPuMloTMtwRtcAyf1/vkKOVdjWKYSFYdBUlzNG4/M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=oDo7lxLD6/1OmNupwwCaYNhIVFh4gtPgQ5s4jbFhPE4UxvjvZfRWyDjE2hKrUx0jC
	 YzRDONGR5p1n2P7m2aWoSJ155v9t8gUN+XEnHBy5xXvQx/sgKdC3oNVr9BkX7Bf83g
	 EjvErc2AakOnZkfTrnhg9uMEiBEii3VQDriHNvmNNd5b69ShmTH4rnS7QffE3YuMaK
	 QFQgQzY7GrwPmQYrhhgBsT3hjOhZs2SmUhQKdzbcCVX4uPXMQDaQ1NOcW0BKNLRyDX
	 F5xK04uRGvyNBPRiHUk8G9ER0Jchq9gCD230xFv5t6WDPPlceXpBp6lrnvyfPhoxTT
	 Md4ei6Fhm65JA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 56164CE0854; Fri, 16 Oct 2026 08:09:49 -0700 (PDT)
Date: Fri, 16 Oct 2026 08:09:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Crystal Wood <crwood@redhat.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <952d44e0-72e1-424b-aef4-a0fa9bf30104@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
 <atDw3O5RILsTE1mn@demetrius>
 <876c9f1a6165b3a865811e7a94522afa2d4844fb.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876c9f1a6165b3a865811e7a94522afa2d4844fb.camel@redhat.com>

On Fri, Oct 16, 2026 at 02:13:15AM -0500, Crystal Wood wrote:
> On Thu, 2026-10-15 at 10:27 -0500, Clark Williams wrote:
> > On Tue, Oct 13, 2026 at 05:41:41PM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > While chasing an "interesting" bug [1], I modified the RCU CPU
> > > stall-warning code so that when a task (as opposed to a CPU) is
> > > blocking the grace period due to being preempted, the stall-warning
> > > message includes the task that is currently running on the CPU that the
> > > preempted task wants to run on.  (In the case of the "interesting" bug,
> > > I kid you not, that CPU was idle.)
> > > 
> > > Would this stall-warning addition be useful for PREEMPT_RT users?
> > > 
> > > If it is not useful, I am going to keep it out of tree.  Something about
> > > it needing a way to dig into scheduler internals.  ;-)
> > > 
> > > But if you want it, please let me know.
> > > 
> > > 							Thanx, Paul
> > > 
> > > [1] https://lore.kernel.org/all/8fa7f795-518c-4507-b684-60b0c1cac2c5@paulmck-laptop/
> > > 
> > 
> > Paul,
> > 
> > While RCU isn't one of the common reasons for a latency spike, if it
> > *is*, then it's not one that's easily tracked down.  For that reason I'm
> > in favor of using your patch. 
> > 
> > That said, if it's going to be a pain to maintain, I can live without it. 
> 
> RCU isn't usually the reason, but it's often the thing that actually
> speaks up and says "something's wrong here", and being able to print the
> task that has a good chance of being the problem (in cases where the
> stalling thread is runnable) sounds quite useful.

Thank you!  Thus far, we have two in favor and none against.

Plus the scheduler guys gave me a way forward that I am testing now.  ;-)

							Thanx, Paul
