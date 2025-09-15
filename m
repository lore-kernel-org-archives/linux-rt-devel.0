Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117830ACF4
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939848; cv=none; b=slE//xGb5yMzIBxad6h4jAJGbRYAxd22n8/pnHnlKAyUTtA2vj+7991fz2I4DC+U5DebQrjx2UxQkgqMiL1nD+PT36Qz9DhWzcbzIO0QcsoDDwlpCMhf/GaR4cU1OL0b9K+zB3MOpJBAc54uSXNbZ5VE8O4jnf8Uur1rTfHk8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939848; c=relaxed/simple;
	bh=qErRF+ZkzR/2d9f5jzuFvHcbXIF0j2F2MSdSyb217EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrtF329EOXyHCyrbIbM2P+b/3wyGW9dUgav87RuUnZ6XJXafR88Cg8rIV5B25WGvzKnq0ozuR3dPHBttHSlfKyu++U+VORCLdZPgDzWO3f+66ssHXCl++v3w8ExGUdSxIkZFQ3zPe3dfqgdvw/cwAZIsLEM9FuDx3bcX4qtk1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlruPaRi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlruPaRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757939846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXC7btW+NGjT7JV7tXtXvhma9AjXqM64mx3hmsORla8=;
	b=TlruPaRifLoLiKW8CVzov/+ZcCfGgU1af7/Uitb+nQIpCAOz6OYNV5KmrDiMhl0nRQmvEw
	3rphzkaAaWrk0Go4uwYksK9IGwy4FfDTpJASYfYPJ2WMQQJVesbPvLhSbsVlAWMSKsdhGg
	dJIbi3X5aEfzekfyIAg+Rjkq1TV3LXo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-Ut06nOnVNRyMw6SjOGDqbA-1; Mon,
 15 Sep 2025 08:37:21 -0400
X-MC-Unique: Ut06nOnVNRyMw6SjOGDqbA-1
X-Mimecast-MFC-AGG-ID: Ut06nOnVNRyMw6SjOGDqbA_1757939833
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51BE91800451;
	Mon, 15 Sep 2025 12:37:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4108319560B4;
	Mon, 15 Sep 2025 12:37:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 15 Sep 2025 14:35:49 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:35:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RESEND PATCH] sched: restore the behavior of put_task_struct()
 for non-rt
Message-ID: <20250915123539.GC23082@redhat.com>
References: <aMf1RzZHjdoPNOv_@uudg.org>
 <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/15, Peter Zijlstra wrote:
>
> On Mon, Sep 15, 2025 at 08:15:19AM -0300, Luis Claudio R. Goncalves wrote:
> > Commit 8671bad873eb ("sched: Do not call __put_task_struct() on rt
> > if pi_blocked_on is set") changed the behavior of put_task_struct()
> > unconditionally, even when PREEMPT_RT was not enabled, in clear mismatch
> > with the commit description.
> >
> > Restore the previous behavior of put_task_struct() for the PREEMPT_RT
> > disabled case.
> >
> > Fixes: 8671bad873eb ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> > ---
> >
> >   Note: This patch is a fix motivated by Oleg Nesterov's question at
> >   https://lore.kernel.org/linux-rt-devel/20250728201441.GA4690@redhat.com/
>
> Right, but I thought we did want to make this behaviour consistent.
>
> Why have !RT behave differently? That is, why isn't this simply a
> 'buggy' comment/changelog issue?

Well, this was discussed several times, in particular see
https://lore.kernel.org/all/CAHk-=whtj+aSYftniMRG4xvFE8dmmYyrqcJyPmzStsfj5w9r=w@mail.gmail.com/

And task_struct->rcu_users was introduced to avoid RCU call in put_task_struct() ...

But I won't really argue if you decide to remove this !RT optimization, although
I think it would be better to do this in a separate patch.

Oleg.

