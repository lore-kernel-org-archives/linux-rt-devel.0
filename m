Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96DF3C0A16
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511221; cv=none; b=OwYPG5GcXEHB+wWiTrjaZ4wThXrK5gkJP7H+YF4REWqaVhN1YFcBYxq9BBKjE4EydI+gme/CSgVJr+PBWcM6r5KQ3mmC4IIbXAxbFqarmShsQyA8682hkzndmPY8s1c/DQ3zRQDAodVE7oCsDVfMeG2IaQw6fAIh86x3lbBY3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511221; c=relaxed/simple;
	bh=Qgdj0dkb+IjIDtWTuXh7o4a2XDBRKLhl6mKOKP5fDwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdm+bD6938DgIAXK2Xo9dP1wingAqz+HKhmxyc01m29GDQiMiGpLFPjqx8i9vEpVVuC8ZpmqHKPgttWk9hbtbdjl/pY/E5wGw3I6u7gYHxHXaqGQkVF1J94mf8Xwv8ZTOBOBd7Dt6JdQnA4wm7UOwJqUdqho7R9e9bRzpoYF6h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q78gvIbh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L69U6WP9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q78gvIbh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L69U6WP9"
Date: Mon, 15 Jun 2026 10:13:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781511217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERV8qo+XISRjEI2pq31fS3oFYd5RWtEhuYxOH/yw4VY=;
	b=Q78gvIbh+rrcUC//ANxWfGVmd9QA4AXz/tFfm/DgPkpQEc2E6KJCRZb7HXqLaqzdXWwwFZ
	Aa27m9M7S0/QXeeEALT0ZPhqvmcSG+ZOqNdk+8bwtb2BqmnX9Mg1pguKtKXMQNlCMGPbFk
	dG9S4Pgl1vo7CuzQx89iExDMWnjiD+FRP9tLcohogAuajhwgML93W6fv4+WbKKICBmU/5G
	igLCfRc0QGtpGa62St0rTpkkjIcrO0Ga5csnJOxkf5e4q/tz0jlPTY6YVE+3dm1IgS/xL0
	C4k68Xd4f9YbqYFLmLqNVxRGoB5QKUzRa5P0s6iRwyZ0MPfXCPoubcHMtbvGuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781511217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERV8qo+XISRjEI2pq31fS3oFYd5RWtEhuYxOH/yw4VY=;
	b=L69U6WP9dZk5OvecztTDEHx/OL06WWQ2eZXzsoMdlT97QSFmCg56viWxDok95V0ypbjBQb
	WOpVETkzuh2Kb5Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: index.rst: add entry of other
 sub-directory
Message-ID: <20260615081336.9RXj7yGR@linutronix.de>
References: <20260603080430.344391-2-manuelebner@mailbox.org>
 <87pl1v5zga.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pl1v5zga.fsf@trenco.lwn.net>

On 2026-06-12 13:30:13 [-0600], Jonathan Corbet wrote:
> Manuel Ebner <manuelebner@mailbox.org> writes:
> 
> > add reference to scheduler/sched-rt-group.rst
> >
> > Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> > ---
> >  Documentation/core-api/real-time/index.rst | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/core-api/real-time/index.rst b/Documentation/core-api/real-time/index.rst
> > index f08d2395a22c..661b419e7f8f 100644
> > --- a/Documentation/core-api/real-time/index.rst
> > +++ b/Documentation/core-api/real-time/index.rst
> > @@ -15,3 +15,4 @@ the required changes compared to a non-PREEMPT_RT configuration.
> >     differences
> >     hardware
> >     architecture-porting
> > +   Real-Time group scheduling <../../scheduler/sched-rt-group>
> 
> This file already appears in the toctree in
> Documentation/scheduler/index.rst; adding it elsewhere can create build
> problems.  If you really want a link here, the way to do it is to add a
> cross reference instead.

The long term goal is to remove sched-rt-group and replace it with
something else. Manuel stated that he just found it and was not/ is not
using it. Maybe just drop it entirely.

> jon

Sebastian
