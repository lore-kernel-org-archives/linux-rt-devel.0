Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F85257AD0
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380020; cv=none; b=A/QxchorxuwV7fOCBnddRjvpxPrklrCjbduZJMJ4j7KfKnvoLyFUqmaP5SoiYhDoyciNjGIHC/oIbjDYhyvDjdpCLQJ+W+QsjAVeOpiEQGgrzte0yJNbTUZHcz4RTZbje/vYikmG0CaIkW/B3OHaTCIMX3hdaoj0zo2DLgXds/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380020; c=relaxed/simple;
	bh=PKnBU/w3oILEA0b0uyHfd5RnUVzF56l53yBLD8PAfRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHXSg8Br9Hb4Pv6VBwx4otfwV8IYRym3NbFoiw+6ztZj19T8o3ETMKOSRFATAlXmQqHMsWX5y6ObilPba887rqLP91KrAA+At9TtF6RvceiL537ofwDzKy/mzzfYeVlfjY/nn3kBKd4pt8f9WXwD1s/Mh6xXy54tdJDsOpz1XYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6D5C4CEDF;
	Wed, 12 Feb 2025 17:06:59 +0000 (UTC)
Date: Wed, 12 Feb 2025 12:07:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212120706.7e169c2b@gandalf.local.home>
In-Reply-To: <20250212120328.28fe4123@gandalf.local.home>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
	<20250212114531.4e95ffe7@gandalf.local.home>
	<20250212165908.DoNnHJ5v@linutronix.de>
	<20250212120328.28fe4123@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 12:03:28 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 12 Feb 2025 17:59:08 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2025-02-12 11:45:31 [-0500], Steven Rostedt wrote:  
> > > 
> > > Shouldn't the spin_lock_irq*() variants for PREEMPT_RT also disable local_bh?    
> > 
> > Better not. The consequences sure wouldn't be funny.
> >   
> 
> Why not? It keeps the same paradigm as non PREEMPT_RT. Do we really want to
> litter local_bh_disable around all these cases that spin_lock_irq*() is
> used to disable bh?
> 

Expanding on my argument. Why does it work for non-PREEMPT_RT but not for
PREEMPT_RT?

-- Steve
