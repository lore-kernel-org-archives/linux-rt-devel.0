Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B12192EA
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Jun 2025 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157595; cv=none; b=ecU6GtE8x/+Ns0SoFQOklz+rtXbA/NAbM/iKeoVVVzauVxc1Jizw3zZALAxG1akdgKc5sG2txPVGCuiDUxlNkagNOIsAr+TA5Mlt+e/3QAARi/TfqFAivPN43CZBrooWQ6RNWy9BPaBt90pxnOkEAGHKCbT+n8Q8T5LsX/Nl21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157595; c=relaxed/simple;
	bh=UgCGhu7fYeMI4mIfoFDow90naCmWaWja5M31mu4hz14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQe4kjOpKCtqA37E3oS4v0LXO0Ho8F7O7+rd+t+XlPGhDhd39LLNBfseXVpEu3qia61idNaPoW1deetXYo253QogPrHVZ8Ji86WaGd1um4R75VBHEuA8rOBloO2PVCA/nw4aOPvLJcNZggC9hO1d5r3NgGfjlenP8mHgwvHuJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Us4BMceC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Us4BMceC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750157592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0ncJVs04Al38TEGKEfhY3VBsmgJ1MjE0cgapDAotLM=;
	b=Us4BMceCyi3S1yUKatdf8003ld9ym99M38+A75B6bZFMXT45rPJSKyGGz6YhLR9i8Jahlj
	sPfL2ok0r0DfPLK0URSTSP0a79cSDwZv9lDl/vP1xqGVqwBorDZCsBi+WPoOlYh0zCjsvM
	3WQdzGJZ3m+ykjvqqx3C4f2bfSltdKk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-Nf1SH4g6PqWzvE_XXZcHWA-1; Tue,
 17 Jun 2025 06:53:09 -0400
X-MC-Unique: Nf1SH4g6PqWzvE_XXZcHWA-1
X-Mimecast-MFC-AGG-ID: Nf1SH4g6PqWzvE_XXZcHWA_1750157587
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43ED21955F45;
	Tue, 17 Jun 2025 10:53:06 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CD2D18002B5;
	Tue, 17 Jun 2025 10:52:56 +0000 (UTC)
Date: Tue, 17 Jun 2025 07:52:55 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, David Vernet <dvernet@meta.com>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>, DietmarEggemann@uudg.org, 
	dietmar.eggemann@arm.com, Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH v4] sched: do not call __put_task_struct() on rt
 if pi_blocked_on is set
Message-ID: <kq6edcqhqwzy25y4uurbjkty6r3vzmz74wizmmy4vxu6rvofvk@opm4sjchvegc>
References: <aEw-KjUjjP2gYH6z@uudg.org>
 <20250617092609.GR1613376@noisy.programming.kicks-ass.net>
 <20250617093627.ykSeZMqk@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617093627.ykSeZMqk@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Jun 17, 2025 at 11:36:27AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-17 11:26:09 [+0200], Peter Zijlstra wrote:
> > On Fri, Jun 13, 2025 at 12:05:14PM -0300, Luis Claudio R. Goncalves wrote:
> > > With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> > > from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> > > with a mutex enqueued. That could lead to this sequence:
> > > 
> > >         rt_mutex_adjust_prio_chain()
> > >           put_task_struct()
> > >             __put_task_struct()
> > >               sched_ext_free()
> > >                 spin_lock_irqsave()
> > >                   rtlock_lock() --->  TRIGGERS
> > >                                       lockdep_assert(!current->pi_blocked_on);
> > > 
> > > Fix that by unconditionally resorting to the deferred call to
> > > __put_task_struct() if PREEMPT_RT is enabled.
> > > 
> > 
> > Should this have a Fixes: tag and go into /urgent?
> 
> I would say so. I'm not sure what caused it. I think Luis said at some
> point that it is caused by a sched_ext case or I mixed it up with
> something. Luis?
> 
> The other question I have, do we need to distinguish between PREEMPT_RT
> and not or can we do this unconditionally?
> 

That's something I had been wondering myself. However, since this code
runs in multiple places, I was concerned it might trigger some obscure
corner-case issue. In any case, if we decide to remove the
PREEMPT_RT conditional, I’d prefer to handle that in a follow-up patch.

> Sebastian
> 

