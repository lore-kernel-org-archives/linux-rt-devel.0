Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C083BCD37
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068510; cv=none; b=XdsspgonB7UuteBB2ckltkZ2Kovhg5AS1MKqHTV/STGxkjzVgT2QeUksYCvgLTEvjBlC7LisrWnZT1Wr3/ln5Hg/3UElaqyB452oY/9Xaf+HnHXlyZjM+lbZbXkIH+KbCTN/hfxeVr25NrJkYFjOyaEuhY7npcy2slcx7BN4QwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068510; c=relaxed/simple;
	bh=Qsbm/VBibiTv9HbUTxARjAoj1Ex1AITSRajHCYKHnck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqmiRKTYqz3ixxMeIBgXcYdZu99YXbSGIY+XrY14tEzIR2zfJldfF1QXY5XiWdrZo0Jf1xp8z00K4rtRNjjTkr8MgWFo5saeLjEj1itSRXSpazszXO1cueN0vHWhyq8khwqAd2/PkLWyOx6uKNcb9Dg7B8GGAaD4uFHfsWkEOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=QttLPmw2; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="QttLPmw2"
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B9744808D8;
	Thu, 15 Oct 2026 12:48:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 224B920011;
	Thu, 15 Oct 2026 12:48:22 +0000 (UTC)
Date: Thu, 15 Oct 2026 08:48:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Clark Williams
 <clrkwllms@kernel.org>, Boqun Feng <boqun@kernel.org>, Lyude Paul
 <lyude@redhat.com>, Joel Fernandes <joelagnelf@nvidia.com>, Alexander
 Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Jonathan
 Corbet <corbet@lwn.net>, Bradley Morgan <brads@mainlining.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>
Subject: Re: [PATCH v6] softirq: Preserve interrupt context during IRQ exit
Message-ID: <20261015084821.3fcf69bf@gandalf.local.home>
In-Reply-To: <atByy9l7zW4TKtrK@gmail.com>
References: <20261011060742.30584-1-kmehltretter@gmail.com>
	<20261014120524.5e6e6efe@gandalf.local.home>
	<atByy9l7zW4TKtrK@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 224B920011
X-Stat-Signature: cw6y79efrjsp1e3pwnt8ikui1b5ynufr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/HUkKsdimRjPlU0io/+azJMasi0C9lQGg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=H0/+PoulGnO9Buqg5kAlWZWEdOYZK8eqJ4RSGP7LZxk=; b=QttLPmw2JfHbqt5/kt94/gAp7wKPzPNJAC5+vvxL4Z+79HTpGrhXc8tzQjySQN9IreZVLMGgJSREaVHbpajbZ8tbG3HhC2SEGdE3TOWycBxSL1QZszzkKKxXLFa96qU2Rb5C9fJudH8vBUuQCrrpsGdWa2Dw/Ar22Hme2c8ObRY=
X-HE-Tag: 1792068502-981043
X-HE-Meta: U2FsdGVkX19+n9AATYUvQ4XS+ZZAZn9psXV8b1nqX66jlcei0lOsVVnQBjmzskzA78l5gGQpq18AWvg34xTNJ4qiFdRUiQvg8mWyMZ0KVFyM70AQ/0X/6FNQKs2wLSl9cmbPY24aBC0e3O7YICcEq2ZeWY8a2uq1CXa7cQ2CoQ3qZRdMyp9ZOZ//bG8EUBeZSPeXK3YR0b6qJULvT6+DE1rKrHZwzoPjz1pK7NTFZ/YE7dqaLpICqgy8SuqdUPqbRNpzyx0KMSO7a5vcniu7YNFMuON4/0v9T4pikdWGDrbr6UiZ9Bfbb82aI3JpfeN7OIcEtvuJ0J6wzbRgqXPBbGLdzGBjc+qT

On Thu, 15 Oct 2026 08:32:12 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> On Wed, Oct 14, 2026 at 12:05:24PM +0100, Steven Rostedt wrote:
> > LGTM.
> > 
> > So this handles the transition between hard irq and softirq?
> > 
> > I wish there was a way to get preempt count updated earlier on entering a
> > hard irq so I can get rid of the transition bit in the trace recursion. As
> > there's still places that can trigger a trace in the hard irq before
> > preempt count is updated.
> >   
> 
> Yes, this handles the hardirq-to-softirq transition on IRQ exit.
> 
> I am looking into whether the preempt count can be updated before any
> traceable code can run, as a potential follow-up RFC.


I went down that path before, and the goblins there made me retreat ;-)
(I ran out of time to kill all the goblins)

> 
> If that works, it may allow the transition bit to be removed from trace
> recursion.

I would LOVE that!

-- Steve
