Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59D343212
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947790; cv=none; b=Hbj54CYScuwfOmbwfo1dZaKKg2cqU3/UTD3eJGfWKR+n2x/aeN49TJKXKovQWS/fijQNVmiH7+2n1HDiLqkBaX4ZzHFFNZWu9iJfasIX2LLKWuFPEl3P74Iwz39EKw/ikmmKcZ4GwMiAM6Iq4uvaMGr5QTUT9Q3ntU2biIZAT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947790; c=relaxed/simple;
	bh=EQrR3as8r6JttpBYEwX3XQQTxMYtTk/VHuoMMD/Weqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjIO+p+Ux+hwxAX39ReLqt6tDfewH2bYKterSSAfkaioLZXaPFGMBadv5qnysg1C+QBJtdILVu/EM703PZCqgmjzatcK0Fi2tfPBPNoI2Xf8yRBnZYARK7UU1ci/sSt7TG2Va1IUXMn0Lact68IYKLcAJhoxIp6SuHcUsi1CylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3CMw3ge; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3CMw3ge"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757947787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkA/y861UY0j0NSM/jI1mVaVre4MXQ6jr6/SWw+imII=;
	b=b3CMw3gedORayB1+XeAnpOlCDQmQS0MZaUc2F64Y1YEN2mL4bALguJJSZs/IcmkS8JlTX8
	RTKKO1fldkZ7reMgq+kW9NEiLebCjk5QGrtWdxE0YvNsX+19OENicNXiMmbJtEtYkN0foB
	MyW7OriJlul49dt7ovIr7QggeG0Xp84=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-oP7DMVCmMkaCpixDQ5C5Vg-1; Mon,
 15 Sep 2025 10:49:44 -0400
X-MC-Unique: oP7DMVCmMkaCpixDQ5C5Vg-1
X-Mimecast-MFC-AGG-ID: oP7DMVCmMkaCpixDQ5C5Vg_1757947782
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6BF81800447;
	Mon, 15 Sep 2025 14:49:41 +0000 (UTC)
Received: from localhost (unknown [10.22.88.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19A651800451;
	Mon, 15 Sep 2025 14:49:39 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:49:37 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
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
Message-ID: <aMgngWdtqUKuqLcw@uudg.org>
References: <aMf1RzZHjdoPNOv_@uudg.org>
 <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
 <20250915122444.Gg_Tsymz@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915122444.Gg_Tsymz@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Sep 15, 2025 at 02:24:44PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-09-15 13:38:12 [+0200], Peter Zijlstra wrote:
> > Right, but I thought we did want to make this behaviour consistent.
> 
> That is correct, that is what I asked for (either consistent or a
> compelling reason why not).

I received a ping from colleagues investigating a problem possible caused
by excessive pressure on RCU and this change could make the problem worse.
But last I heard from them, sounds like the problem they are investigating
lies elsewhere.

That said, I don't have problems either way, limiting the change to RT or
keeping it general. I will follow whatever guidance I get from you all.

Luis

> Oleg pointed out that the patch description does not match the change.
> That is the only complaint.
> 
> > And IIRC RT has been running with this for ages, and never seen a
> > problem.
> 
> The syz-bot picked up RT recently. Other than that, yes, RT had it for
> ages.
> 
> Sebastian
> 
---end quoted text---

