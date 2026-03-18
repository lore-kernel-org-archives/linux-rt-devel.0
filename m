Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AAE3DBD49
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Mar 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845907; cv=pass; b=Rj2ahZETziI0HzFIfBSmeAPxPqYffjPp5pdj64NHv2pcBtOGnodOo0u3duksRKg4NAM85kMzvNh9Br0oC3Dh0dcl0F4jbMfvqV/maEWmAbuuhaPbHc8TRxRb02b0ZQSO50VUBT7vnEBUaKsVjrJFCGP8+AlU4TJJ9oeSnsj4osg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845907; c=relaxed/simple;
	bh=N1NXpkaQAjN2dHwsSJVS4d7YXJxzt2UyIFGHIrbpYCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqFplrrfESOeq+bKZG2C2xCyC7u49jGWHnaibkoHnl9mxj28W9keMiGVgUG3tGa1dn4uDOvyLbx1fPT+bgW7KYfDChYo6axsBFgD5A3EHPL0vgkd2PF9yqEM7MLKz0Gordg4HkK6EOO5kwj0RgrNhUzyLnLVqVWWb8XkKGYcgvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C2RZd8aO; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C2RZd8aO"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso2393366f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Mar 2026 07:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845904; cv=none;
        d=google.com; s=arc-20240605;
        b=cnWuJQriMTpY+D8mReh45dI60cic+lLJJXLAK88AHJuz7HhscFF/bpFOqmqJph8UdX
         t8OBXg/cKZ/gPaBCmCNm2jqMay2Y/wGWrLwYlSh21Nc3FSDn/HqmoJxW0EVivsx0F8F0
         bpkBpHgt0f7qi800rjowXVc1qtwjX/rcVI3uMOywjzWLqh8IaoQlqRFGrwMxv3X/mdBG
         OyzNkl1fzJSEDRMTFGxNq2gYuIuKJhEOyOWlNGqe/iYeVnogoQqf49NoCUYVVExQmcHl
         +a2/kZHjrafsVjVKI3qogwWjgqLwZD9F6Wo7yzmr24nPs3Pppxtsd/rDdC/tz1EVecDp
         lTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=67Lxa4BGXjz9Zo1vWHQleC/2O1UPzPcZCuH/+UGL6f4=;
        fh=uF2RgLRfRslwAX97cTOVm9r0rR0BbqDb8+xcxDBA3kA=;
        b=YCga0FxaGqSCRLE1QgQsabge6qCOdRa/bEbRWtuRb7OqpOaz3KsDDjNaQEZyiD1MY8
         68okdu8pQQq/Zfo5u+WN4DQrLHNd36FSiZLrJW+GooI5HUd5VDF4VAos4cP2RLMjgx4l
         rf897nT7CIGJyiS97yUThPzTbzvTJ3SQafD9x8aHw95E/KqQYBpDlspgkQk4AGUQa5zh
         8Xwo1Sr3hFhHVvbfvQiQWoY9WhQxVDP6djJu6wUitvpT3RwpNXhMJAPfo2P9osfLPDs8
         VToc3q75iNTqdgMLBd8VWDjmog8b9G//LYN6tUx3aU+rF4j7Abug52RMbyfsYQvNV/xW
         6Ssg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773845904; x=1774450704; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=67Lxa4BGXjz9Zo1vWHQleC/2O1UPzPcZCuH/+UGL6f4=;
        b=C2RZd8aONblUo3eUd1B69D1QtPQV97Np48VwPDMiE+rae0cQ/IgePZrawKOeW/QpP2
         lyPz68MQMls4r1l8nB3ouKzOCL0j5EvEhVGk43Rm7u6Mt4lNhIDC9EofIY0AbkytO+Gl
         C9zRJCVYAooPdFZARJ6ML4Mjnw220qLDF51ypf96wkKpyk01QToqcTMl5boqnQj8M+E4
         cKFes3zbHsK63W21sZ5hA289Hrsc3j0F2XnA28ONLmvs7vf52wqPBRPXw2qWL3JHYtmi
         1TuRaCKanS1fUcsMSUf++d7N24JSL0NZAByBai+NwQOGKkDkBb8HaKlZvORYdKt37w09
         ti7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845904; x=1774450704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67Lxa4BGXjz9Zo1vWHQleC/2O1UPzPcZCuH/+UGL6f4=;
        b=YIlOS3R8qoqKGsdnR1fnppyHqthtsT5Fo+IgweeWUl3OU4FFY6OUrNw9ANwR4cgrNz
         CGTQMEe4xnLxeXnQI064YTJNEaOxWQzXntWgDg8CyTUlQ3LdbLLTXTYArRVhSY1No3S3
         9SQM4VDaMYmPPbpGv6qsCfnmdhfqEChrAgxIueXgIMGJWj31f75+Um6g47+F78tMX/pL
         KxnbvlSBRuYfFc5ud4OMclaqyRIckmtDS6BGuMHlrGlwq1gpU/J5SatREau9nOhiBxXg
         +R87DogiOjuRtlNKoPhVd5ze+Fa8LFSCLI1ojx4zvKzrmxKDQjEpesVXW+nh0ME/JpRE
         ZODw==
X-Forwarded-Encrypted: i=1; AJvYcCUtWeqRV2C4usIC8CknGcbG07BB2onfi6NJU4M8tK+jL4kV21wiW/+xYoLtxx695xYkC6os/34bz2sKxXLmKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwA6uiA4+c18psRmiJKXK9juTbmbTqQbgyaLVuvxHbpQEnqXsRC
	QO3LVTQ8fQZHa2RG/KpbI1uWfgxlgD9NN6eiKgLt648qaRVwJoqh6/v0a6No5gLDXHU9fZ2+S55
	preDK976+9Z7r+Km5ZIAV40iydY2sBVgYoo9JWxNccH4QmA3iYZJ9
X-Gm-Gg: ATEYQzwy5qomD5dYQaQxl8iDyJd+OYzsRdJgOTMapBEVvVS3OB+aySAoX9l9ZJIr4uI
	LhJz2sVR4odV9nuvSf9U156pt9kLG7hkltj6lPCQLee4jryV+FhzQO2+vlEL5Hd1xQKRNcjjgp9
	47jOXsJgfSBLTVAVVIHyUjhppVMaZ/P0WmTXK/MH8F4d0lL6iEObqPhMJd27NJmSbGZF9t5wFPC
	K5v/r+nxN4RIIKYWbd8fhV1lBNWut8ERzgz6KZcx5LCZGL9rFxkcIXqx99EGdAoOfqH/qf5b4L9
	ga66IDeHORTJ6TD5bLhqJlqWsp0E3AfijWXnbOyaXJuVSniQZuFihNWw3T/Gzj4eojb4cp3bKt2
	lfTw9
X-Received: by 2002:a05:6000:2207:b0:43b:4212:2ee8 with SMTP id
 ffacd0b85a97d-43b527ad12cmr6672969f8f.24.1773845903651; Wed, 18 Mar 2026
 07:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de> <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de> <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de> <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com> <20260318111849._MMol8Hr@linutronix.de>
 <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com> <20260318145101._iaDDpbE@linutronix.de>
In-Reply-To: <20260318145101._iaDDpbE@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Mar 2026 15:58:12 +0100
X-Gm-Features: AaiRm53t-9KWev7fdqpI90WAqJrBtJ0EukL_N5dFdMvYQ9imwz4FysyBvwXfPUM
Message-ID: <CAPjX3Fe3J1_JgON6iJBN1KXWUr2cPkEQbdTBp5vQt2zMMsf0MQ@mail.gmail.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, spasswolf@web.de, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 15:51, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2026-03-18 15:43:52 [+0100], Daniel Vacek wrote:
> > On Wed, 18 Mar 2026 at 12:18, Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2026-03-18 11:30:09 [+0100], Daniel Vacek wrote:
> > > > > --- a/net/core/dev.c
> > > > > +++ b/net/core/dev.c
> > > > > @@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > > > >             /* Other cpus might concurrently change txq->xmit_lock_owner
> > > > >              * to -1 or to their cpu id, but not to our id.
> > > > >              */
> > > > > -           if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
> > > > > +           if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {
> > > >
> > > > Ain't this changing the behavior for !RT case? Previously, if it was the same thread
> > > > which has already locked the queue (and hence the same CPU) evaluating this condition,
> > > > the condition was skipped, which is no longer the case with this change.
> > >
> > > The above was me thinking and does not even compile for !RT. Commit
> > > b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> > > netdev_queue::_xmit_lock") is what was merged in the end.
> >
> > Hmm, that means txq->xmit_lock_owner is not used at all for PREEMT_RT.
> > It's pointless to even store it. Shall we care?
>
> For PREEMPT_RT the xmit_lock_owner member is only stored and not used
> otherwise. It could be removed as in ifdef-ed away but I do not care
> enough to sprinkle it and the gain is little (proof me wrong). So I am
> happy as-is.

Right. Sorry for bothering then. I missed the merged commit.

--nX

> As for the check itself as we have now, we detect the deadlock before it
> happens and this is nice to have. The alternative (in case of a
> deadlock) would be the deadlock detection in rtmutex code which would
> freeze the thread.
>
> > --nX
> >
> Sebastian
