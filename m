Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF722DA1F
	for <linux-rt-devel@lists.linux.dev>; Fri, 22 Aug 2025 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846511; cv=none; b=dAjNQ0/I/kegY/LwHfJ4vzfn7W2ltPc8fbbHfmWg6mLoii1Ct8edrgZEKnAHRLht8UPulZ7csNvpHykUD6/Q3sNE+Tmv5CXFhx0p87bAPI8oLwrtP19j2+TO2fx5IPZYi1MkeErBS4QpL4xg/PgqncCvBq60Y74xZEZMWveT3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846511; c=relaxed/simple;
	bh=RiYYB9RRi6041Ip0vziWymCsQF1qBVbQ+5R3aXmMZOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWZSXSrqT1dafp4k7jK2Dfkb82+2lOjB+HQKiwf0WvBNJRBO2gtBR/scVCacmUJ4Y365oNQwBY21V9E+6RjFVamcCLaNygeW+1Us4oCFNOP/MkJUWGxIwvofAoeGxs60gnnHvy1vQC2rpUkixr8rWI5eahhRUTr0abH6X0x3H/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FTZ9aMKm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLEL2Pbi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FTZ9aMKm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLEL2Pbi"
Date: Fri, 22 Aug 2025 09:08:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755846508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JmerSpMmrv4tSm3Y3vhQpbkigF5UyZX+JeJX6KWkHPI=;
	b=FTZ9aMKmJuvFrvZwqJOfj6mL3MjXMfalVVgwYiOq09K6mMr2JGe9N2CAvycXoo6T2gOfMJ
	DN5Nt/r4yC8+duM+kSIOAlIGO3uyOnnliS7MCgHXQXNDhDbWJmWBGWcg3kkSkVe/GcR7ij
	0UvvFzP6Ua9pNvceduIfsidUUYuYjlhIbLgLJ+hICXw1CHP0Gss8WuplHYQ/dbFw7KergA
	YZEhMV+muJBrzVBtQw0ltMbg4EmEdjhxfY30/OYuLPfgnkbdFtB+t0UXJ9MQjDEt/qFlnQ
	rkMzzAJEmihz3Pvz0pfoDkHwZKBvVCnlm4MUgPRIf4xoGLvIAmh3H18K+s7suA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755846508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JmerSpMmrv4tSm3Y3vhQpbkigF5UyZX+JeJX6KWkHPI=;
	b=vLEL2PbiOalvYhLO5pQrcouk790WJ7PmT+1IZR78fYhnWrnWEQq9kRggr78Tl/OiGu2lZw
	Wx2Hdmegqb6nDrCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 3/3] Documentation: Add real-time to core-api
Message-ID: <20250822070826.wcYXr39X@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-4-bigeasy@linutronix.de>
 <87seho8v12.fsf@trenco.lwn.net>
 <20250819080358.H9R_64I7@linutronix.de>
 <87ldnfv46n.fsf@trenco.lwn.net>
 <20250819132828.cs64VMsW@linutronix.de>
 <87349k7bdb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87349k7bdb.fsf@trenco.lwn.net>

On 2025-08-21 12:55:44 [-0600], Jonathan Corbet wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> > That would be lovely.
> 
> OK, I have done that.

Thank you.

> Thanks,
> 
> jon

Sebastian
