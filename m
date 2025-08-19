Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29C49620
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590643; cv=none; b=STJ0JvICwAiDhGrZJ9GzgvW0DSiTmoXohzOQD2WPE6j704o2n1ZwvGaSb/szAN28kgPLKzBCOXTP5GsP++bq1TjVWAtbAPxmSc0IijN0cDkYoK6hQG6R5SyXLVRRgFoKoxIG9LeARLjUd91p+pkmKtmu66OvnyO0uERBiEH1S14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590643; c=relaxed/simple;
	bh=o+GhxMSjLHuGqjJ8c1+AE4D5V08s+XzlJaf4edpTOeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVRIWIbcwazwyIFYe3EXoaauUmw0YHteuL15WCHQEPeAXKVQs95L4tdal1M4mPlXhjlvdzjnxXt9+VujRBcm7SyXm9UiUa/oQmHbuug+BKy8snDrNauAPjFldQN/bTb1lEzdLCtJ5C7rEc7lJfuaIAv78U7zcl0UFZyvab/WAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=095Ez6P/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=claD+OEY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="095Ez6P/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="claD+OEY"
Date: Tue, 19 Aug 2025 10:03:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755590640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1gSpu6/ssZRPlPWCatq5ADgMRkNSrJr6QQcFGlfXj3k=;
	b=095Ez6P/m+l/Wv8URnGFNdyRVMExWAvqVuyTwzh/xVRJNu4E5/7C64HkYIdoq/tfvwef7E
	4QgqG6DHsWd2Wl+zD6bsOJCcvovtLlq8DOLD0fnkmr4EYpBJ10a8d0hB1pPDWHmEK+tCsc
	h60ClF9n703sbAdzPWNdOSYnp+sc9OFT6ChYn/fiEmZf+FrA9t3kTDHxuZum7c9pzfXVMY
	GAko9UpmD7T8AB8BQHxOqOqkJZ8Nx/pjU4Fes8LaqyTb1VweSZLFF7cevHR0Q4GcW7VDpw
	si6ncWVA1hbQMJQoZXHkJ6rBwyIGde3DI/5E7jMXwB5uh31gEnIHOrFs5s5I1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755590640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1gSpu6/ssZRPlPWCatq5ADgMRkNSrJr6QQcFGlfXj3k=;
	b=claD+OEYuqZGTuc+irwi0DIx78IlcSQ0PyrlbtuLC5Se2NauisCCuFXiLUVt69JncbGMyf
	0cnl8taWM7TLDJBA==
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
Message-ID: <20250819080358.H9R_64I7@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-4-bigeasy@linutronix.de>
 <87seho8v12.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87seho8v12.fsf@trenco.lwn.net>

On 2025-08-18 10:16:41 [-0600], Jonathan Corbet wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> One nit:
> 
> > diff --git a/Documentation/core-api/real-time/differences.rst b/Documentation/core-api/real-time/differences.rst
> > new file mode 100644
> > index 0000000000000..50d994a31e11c
> > --- /dev/null
> > +++ b/Documentation/core-api/real-time/differences.rst
> > @@ -0,0 +1,242 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +========================
> > +Significant differences
> > +========================
> 
> That heading text will appear in various places, including in the
> rendering of your new index.rst file.  In such a setting, "significant
> differences" doesn't give a lot of information.  Something like "How
> realtime kernels differ" would be better, IMO.
> 
> Otherwise, this all looks good to me.  Did you want me to pick it up, or
> did you have another path in mind for this work?

Right now this is it. Do you update the text above as suggested or do
you want me to resend it?

> Thanks,
> 
> jon

Sebastian
