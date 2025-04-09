Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DF926B959
	for <linux-rt-devel@lists.linux.dev>; Wed,  9 Apr 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216043; cv=none; b=KK7X06WqD57nLgV8v47XELKg7+6ooXJ2YiXfjEKaopbJEGiwi4vOTF9GHJXLdQ/ayr4ugeX31oJBv5uUGgycFg7OAV6uyaZS28SmJXiZ7nyUrPWURPnlFbb2JX2RqVaplAvCaJSiYV6RX2S24YgsYCOlvy+crsIeP3W3dqz84Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216043; c=relaxed/simple;
	bh=owusETY1s+j/BjQaWuvuz+kXCSomTM+MS1xmYqWk+Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hn51bIB8Dbl/Ws7cFIdwBj3zVkNK0eL7tfjwd0GVjsYIdz7J98YNvZBbUqcCngrw4A+p0KYV4c9YhGV08gH6je3KRK41t1haM9GBDDFK9DE0fSYnQOGwWhdnK3p3b5o0BHouHu3zwy5JPy0Sq7mYhXkhDad/D3b8/h2RV10rXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfIEXEG/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfIEXEG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744216040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsgiCJGgL4kjs2GhqE6JzTnn5GYHpXyhtdfwAsQVubo=;
	b=TfIEXEG/mEjF+cR8WaBivh9KgLKeiga8Pt59O9vgk/SSyY/woOrSDCgKz1zLBoAZPMjzlU
	AfLJSg5N52JAVow5oM2eN87L8fkiOUVD0V1tqKRP/Cef9bOhMwZ0oengTyf9wyXlpMoN2t
	B9vZ4XO0o+aTsvERAn3vQer2V9E+Abk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-8o6wEAkHNAa9f96do4D5Lg-1; Wed,
 09 Apr 2025 12:27:17 -0400
X-MC-Unique: 8o6wEAkHNAa9f96do4D5Lg-1
X-Mimecast-MFC-AGG-ID: 8o6wEAkHNAa9f96do4D5Lg_1744216035
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 660F9180AB19;
	Wed,  9 Apr 2025 16:27:15 +0000 (UTC)
Received: from localhost (unknown [10.22.88.189])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56AF4180175D;
	Wed,  9 Apr 2025 16:27:13 +0000 (UTC)
Date: Wed, 9 Apr 2025 13:27:12 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <Z_af4PF18ocF0bBW@uudg.org>
References: <Z_W-i-ya0Q6fkXRh@uudg.org>
 <20250409114330.1444221e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409114330.1444221e@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Apr 09, 2025 at 11:43:30AM -0400, Steven Rostedt wrote:
> On Tue, 8 Apr 2025 21:27:37 -0300
> "Luis Claudio R. Goncalves" <lgoncalv@redhat.com> wrote:
> 
> >  {
> > +	bool defer = false;
> > +
> >  	if (!refcount_dec_and_test(&t->usage))
> >  		return;
> >  
> >  	/*
> >  	 * In !RT, it is always safe to call __put_task_struct().
> > -	 * Under RT, we can only call it in preemptible context.
> > +	 * Under RT, we can only call it in preemptible context,
> > +	 * when not blocked on a PI chain.
> >  	 */
> > -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> > +#ifdef CONFIG_PREEMPT_RT
> > +	if (!preemptible() || current->pi_blocked_on)
> > +		defer = true;
> > +#endif
> 
> Why add the ugly #ifdef back?
> 
> 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
> 	    (preemptible() && !current->pi_blocked_on)) {

I had to add the #ifdef to avoid the build failing if CONFIG_RT_MUTEXES is
not set. I do know SMP, FUTEX, I2C, PSTORE and a few more things depend on
CONFIG_RT_MUTEXES being enabled, but I opted for being thorough.

I would be more than glad getting rid of the #ifdef and simplifying the patch
if that possible build failure is not a case to worry about, if RT_MUTEXES are
always enabled nowadays.

Luis

> -- Steve
> 
> > +
> > +	if (!defer) {
> >  		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> >  
> >  
> 
---end quoted text---

