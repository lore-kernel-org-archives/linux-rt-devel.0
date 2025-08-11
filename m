Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205D2D0C60
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911370; cv=none; b=q9tJojQMlcfv/u5gpaZdMjsde3lN0/fOcEtPuuqkbZoXFZUrTRJXnrLwux2Dacyhu2kohnyaibLzYeh97fWaizzdiVN3wdLGIP9t4zDRmgw1AY819BGvr6yskZEUMSqDmIo0iby3TkJ7gFYNqD5EeaMPUU2Vg6u6xheFw3ZY2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911370; c=relaxed/simple;
	bh=ZOqfIENZoCDHfFICtEOL8YJoPa60molw2ph21bKNCGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oij/yWQjbO4gLfahmHKRBEKZW7sw7QHAt0klKkAByDUzdbGpqEj5Vi+RsV8yNQWI96n0R2dPeinJVSvyJqLOU5XkQ6k9t2AlMWiKAOT6nuYhqZ+4jrs4NxWrHF4dI9Y9Y4c0pKWCO9W4apnDt0W6dXgayk/IP6+VAdkD25g9VFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAkmPaVk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAkmPaVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aTv5PwSwqaTOZ1ypCe+ttHkuGMC/kFwpTVvvw1cs3Lw=;
	b=HAkmPaVkbHSa/acXU+UGDnPPwAAgyX+zGzPNF23tJJGmNO39VM3GiifmMvo2On6sFjyS3F
	uYce1RiotQQlZh+0BQxvAP8+dt+DHSnpmCeCFC0Vz33V+egeKiJYdI1rpZ8cEPQW/9LwH4
	z8+mNLCN/wAS7hlpLiJOw4mbovuEyYE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-h1gUKyDaMoC7qTEaY5RMSg-1; Mon,
 11 Aug 2025 07:22:44 -0400
X-MC-Unique: h1gUKyDaMoC7qTEaY5RMSg-1
X-Mimecast-MFC-AGG-ID: h1gUKyDaMoC7qTEaY5RMSg_1754911362
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDC441800285;
	Mon, 11 Aug 2025 11:22:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.234])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 13EBF19560B0;
	Mon, 11 Aug 2025 11:22:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 11 Aug 2025 13:21:29 +0200 (CEST)
Date: Mon, 11 Aug 2025 13:21:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20250811112119.GC5250@redhat.com>
References: <aJOwe_ZS5rHXMrsO@uudg.org>
 <20250811100624.LuYV-ZuF@linutronix.de>
 <20250811104033.GA5250@redhat.com>
 <20250811110501.nTDNkPnM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811110501.nTDNkPnM@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/11, Sebastian Andrzej Siewior wrote:
>
> On 2025-08-11 12:40:34 [+0200], Oleg Nesterov wrote:
> >
> > What exactly do you think we could do regardless of PREEMPT_RT?
>
> Do what we do now and have one free path for task_struct regardless if
> PREEMPT_RT is enabled or not. The one via RCU which delays the freeing
> until after the grace period.

Ah, got it. I won't really argue, but...

call_rcu() is not free, it obviously delays free_task/etc. To me this
!PREEMPT_RT optimization makes sense.

But lets forget it for the moment. This patch

	https://lore.kernel.org/all/aGvTz5VaPFyj0pBV@uudg.org
	[PATCH v6] sched: do not call __put_task_struct() on rt if pi_blocked_on is set

removed that optimization by mistake, this doesn't even match the changelog.
I think it should be restored, and this is what the new patch from Luis does.

Then we can discuss this all again and possibly remove it, but this
should be explicitly documented in the changelog.

Oleg.

