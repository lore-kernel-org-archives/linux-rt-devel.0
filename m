Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121D38C406
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078051; cv=none; b=dGOu1w05s0Kq8xt7fl7ztgdPl5PwwGzn6p6ocSOCspxa0JlSZQ5KGy3f2UKT9QXfDmlOhcCdja6MKxrQ2IqLWGmk8s57mby5iO4KOMQGoqMhCvGSDWY60wV7Zw6aHXhxCkirI+NVoMeepNDoxUCWMM6lpgSfJbxDrHoqyvdyiZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078051; c=relaxed/simple;
	bh=OGlCeNJVFRgwjLjG8L15yHP4bMx4gZHLfYSDqr+cMQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGvS4TvkzAQlMs7YWvVQD2kH63Sb3aJphWjJ0XSFmGEBzft0x5bvKJxjd6fhYpjJZ+0mWzEJr8cM2X/vPzWZBYfZCQ71cdxo9eqjzhKvEt7YGTlavyQgWb3XJ5ozLhMr2dnIKdsWhcwiK56+3fvACLbP5ag+W7NLIpaYX66NtGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKgwjkGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKgwjkGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111A61F000C4;
	Thu, 15 Oct 2026 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078045;
	bh=xNwVZrCUmYnYbmxcd6KpR2qXRydVQUugSp+/fto1+ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MKgwjkGdxpakNjyfeCeIi3wpnQ99V4nl2dVO+7mkYeZwVpR1z75OJYqK0EjZcrxKF
	 W6ClAY8VtiRqCW5QOPIRNlJq+cst7p5dGq3k39HvS7Rkpbf2L4jLNbSRmBvcS0UTv3
	 n4iEYbxn42XEQBzc0PG+/o/FKqX/58UhbT+zMCuC03IW7jznV//h5gJWss4PxKzju6
	 92gnIzi+RHtwqc0dOWVIv5FCalBPYOBNHKjEE2u6TY7FLBEdRDCyAHq8frA+Qoqk+a
	 3niZevR6aWQgF+umAebw1cqWbUgMmLKK9siLMZwaPEPCh/RcalfbEgbbt7nIPc5z9c
	 yiemVnmP6vVgg==
Date: Thu, 15 Oct 2026 10:27:24 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <atDw3O5RILsTE1mn@demetrius>
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>

On Tue, Oct 13, 2026 at 05:41:41PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> While chasing an "interesting" bug [1], I modified the RCU CPU
> stall-warning code so that when a task (as opposed to a CPU) is
> blocking the grace period due to being preempted, the stall-warning
> message includes the task that is currently running on the CPU that the
> preempted task wants to run on.  (In the case of the "interesting" bug,
> I kid you not, that CPU was idle.)
> 
> Would this stall-warning addition be useful for PREEMPT_RT users?
> 
> If it is not useful, I am going to keep it out of tree.  Something about
> it needing a way to dig into scheduler internals.  ;-)
> 
> But if you want it, please let me know.
> 
> 							Thanx, Paul
> 
> [1] https://lore.kernel.org/all/8fa7f795-518c-4507-b684-60b0c1cac2c5@paulmck-laptop/
> 

Paul,

While RCU isn't one of the common reasons for a latency spike, if it
*is*, then it's not one that's easily tracked down.  For that reason I'm
in favor of using your patch. 

That said, if it's going to be a pain to maintain, I can live without it. 

Clark
