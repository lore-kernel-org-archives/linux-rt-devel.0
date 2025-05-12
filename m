Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDB1C862B
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 May 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076523; cv=none; b=pMinsiLq7m3liO6l6tjU9iH3FbmQtq4RvMC0zsybFXSHDtixp9ag5YrsKYookjUve0nMn6IXZQIb+SGpfIIbq5liF99P0xXomkI+Qc+S7K573Z9kVaDhujo+MfRmziE7GskFbgD3p6HC7gfjQaUuo4+kmzJaX7+cfygoI/59gT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076523; c=relaxed/simple;
	bh=Iw4FMLxMzOsRhPUzCitoDc187twmhNXKei/YG2KflGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9MyK2+QSwbjbEIPU7lpSAKLkv07e+RwbQPSVVC3Ymu8MUdI9NoK1bFVy/FT8L3IPfVizxtGcLnLSc9F0b6GlpDORnjkIoVZSoUG+vFQta/W2aM60/tAN0mqGU6wS7eG4e/jWZ3eIwX+u1dwEXG7GJlvsWz5RJfADdDYZxO0eV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fa++PwjA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fa++PwjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747076520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWaIpBAE+GNW2dWuVErPfYy1v7Zx0jvZfL8ijBtInX8=;
	b=Fa++PwjAMTZYEUQON1vNuI6ctN2hBI6qTLZ6475mXbNiHurWeN5VT0dlX7Ps9MncN7Zix4
	nUSJuG2R48Mpz36yJNhR+yrx55nOGFeMUtysddYkioeZ2qFJuqwzFHhOALexfjX3Ksavwo
	v2kc226yBtsfWcXHD59iJGGAp7PNkkg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-pdvLv3UxNZ24d8YSQeBYyw-1; Mon,
 12 May 2025 15:01:56 -0400
X-MC-Unique: pdvLv3UxNZ24d8YSQeBYyw-1
X-Mimecast-MFC-AGG-ID: pdvLv3UxNZ24d8YSQeBYyw_1747076514
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67EE318001CA;
	Mon, 12 May 2025 19:01:54 +0000 (UTC)
Received: from localhost (unknown [10.22.80.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F1C31956095;
	Mon, 12 May 2025 19:01:53 +0000 (UTC)
Date: Mon, 12 May 2025 16:01:52 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <aCJFoCq7Pp_luu2M@uudg.org>
References: <Z_bDWN2pAnijPAMR@uudg.org>
 <20250410064844.wm4KbunL@linutronix.de>
 <20250410075103.GV9833@noisy.programming.kicks-ass.net>
 <20250410153205.u92eJDos@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410153205.u92eJDos@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Apr 10, 2025 at 05:32:05PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-04-10 09:51:03 [+0200], Peter Zijlstra wrote:
> > > I complained about this special RT case in put_task_struct() when it was
> > > first got introduced. Couldn't we just just unconditionally do the RCU
> > > put?
> > 
> > Yeah, please make it simpler, not more complex.
> 
> Just so we clear: simpler as in everyone does call_rcu() or RT does
> always call_rcu() and everyone else __put_task_struct()? I mean we would
> end up with one call chain I am just not sure how expensive it gets for
> !RT.

Sebastian, I implemented the change where put_task_struct() unconditionally
resorted to:

	call_rcu(&t->rcu, __put_task_struct_rcu_cb);

I submitted the kernels I built with that change and a pristine upstream
kenrel to LTP and stress-ng and also ran 'perf bench all'. I built kernels
with and without lockdep and extra debug. All kernels survived the tests
without a scratch and I haven't observed differences in behaviors nor
timings (for the tests that had that information).

What would be a good benchmark to compare the kernels with and without the
put_task_struct() change? I would like to observe whether there is a
penalty or added overhead with the change in place.

Best,
Luis

> Sebastian
> 
---end quoted text---

