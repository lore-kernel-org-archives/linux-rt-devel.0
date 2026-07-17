Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFADA400974
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304727; cv=none; b=PffC9FYiW7js/RGHTsW0fSHuh/PAZ7OxR7/mm4yKGOzIuvD4wU5JOs+aUobo8Bw/pzhd+xyUTWgpd32IUh7oJwa9wQWMACchXzixeJmoqAjiuDXAwS2Q3WhqbSSTvTj+AZ6cToRAruJdby7puAw/qznWoZpR0J+qEZDYlrf0o4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304727; c=relaxed/simple;
	bh=BJtM84PuNPI9AWtVzGAf7H1xWIUEhjcPl49X5n4wpzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiBzEryLWD2KEuouA6XKNRWTgKy2x/UJOcM388XKQzMOP2y82vpNckP17QlYd9MeiFVa6vOpV4ZX/l4Br8RzKLFUhSHqeG2OEzKTc6qjsdn1hWKPsylOdqPk5OFNj+ld+FUSff2GNyjDXizSrq3ySvoH+hdgnHhE3kFLYIDDkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3BGz0Obv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ilOmU0ra; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3BGz0Obv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ilOmU0ra"
Date: Fri, 17 Jul 2026 18:12:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784304723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbA3fqdyYqx3+BHxrbfsEgpUodXHYmdKvkFVVVRQdTE=;
	b=3BGz0ObvZjFzKUZN9C/usZLCuvM7dtgyVvLpUB/4ej2WT/Zeork/TQ/Z8K8hrvEiH88APQ
	+FOUcRwAkn9mvCaxF+MkRoUrmLoGyVGbKby4W1bLDnrnxaKxzRM++sJiVLSaRnU8phg5uR
	Pt6fvPksHmc6VT+A3vwlv0mgoabF+0Oxygp9Jx0QdyEF8704HtePC3L+DogE1V9zYX1T80
	zg2TXLYS+Mf4iJVXDG7XKFYsPsdDw2GNwS+whDVEA+csj7EtJlMalVZdZ9udcH7Ss/JUuX
	/6jjeZ6dVI3mSTYj+EHl3pSD/gPe/X2QMlz4iCSU7GZA2bUv+sfAH5ylUau/Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784304723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbA3fqdyYqx3+BHxrbfsEgpUodXHYmdKvkFVVVRQdTE=;
	b=ilOmU0raIeFSzZbr2NrW1NCOoFJ5OkWZpATf10Tuj9Gpj2HtcIM52SKITn1C8X3E4SrHJh
	BaEox2Rr7sEMy3Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Leo Yan <leo.yan@arm.com>
Cc: Mohamed Ayman <mohamedaymanworkspace@gmail.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <coresight@lists.linaro.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v3] coresight: Fix scheduling while atomic in
 coresight_cpu_pm_notify()
Message-ID: <20260717161201.3jkO5o71@linutronix.de>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>
 <20260717155848.GB3998092@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717155848.GB3998092@e132581.arm.com>

On 2026-07-17 16:58:48 [+0100], Leo Yan wrote:
> >  static struct coresight_path *coresight_cpu_get_active_path(enum cs_mode mode)
> >  {
> >  	struct coresight_device *source;
> > -	bool is_active = false;
> > +	struct coresight_path *path = NULL;
> >  
> > -	source = coresight_get_percpu_source_ref(smp_processor_id());
> > -	if (!source)
> > -		return NULL;
> > -
> > -	if (coresight_get_mode(source) & mode)
> > -		is_active = true;
> > +	guard(raw_spinlock_irqsave)(&coresight_dev_lock);
> >  
> > -	coresight_put_percpu_source_ref(source);
> > +	source = per_cpu(csdev_source, smp_processor_id());
> > +	if (source && (coresight_get_mode(source) & mode))
> > +		path = source->path;
> 
> I agree the get_device()/put_device() pair in
> coresight_cpu_get_active_path() is not a good fit for CPU PM notifier,
> because the put_device() can become the final put while IRQ is disabled.
> 
> However, my understanding is this patch might cause UAF issue that the
> existing code is intended to prevent.
> 
> The raw spinlock (coresight_dev_lock) serializes access to the per-CPU
> csdev_source pointer. It does not guarantee the lifetime of the source
> or its _parent_ device. coresight_unregister() is not only reached from
> module unload; it can also be called when a driver is unbind, for
> example DT overlay removal or device hotplug/unplug.

But doesn't coresight_unregister() block on the coresight_dev_lock here?

> This is why the UAF issue Sashiko mentioned in patch 03 of [1]. A built
> CoreSight path currently grabs references for the path components, which
> keeps module alive, but that is not the same as preventing the parent
> device/driver from being unbound and tearing down CoreSight device data
> while an active session still has raw pointers.
> 
> There are also similar race window before the path is built: for
> example etm_setup_aux() has to look up source/sink state before
> coresight_build_path() establishes the path, so it might access
> released source/sink data if device is unbound.
> 
> I think a proper fix needs a clearer lifetime model for an active
> session. E.g., we could consider to call device_link_add() to prevent
> device unbind / unregister, and unlink device when the session is
> finished. Once that is in place, the CPU PM notifier can safely use the
> active path without get_device()/put_device() pair anymore.

Right. I am also not sure about lifetime of coresight_device::path.

> Hope this is clear and makes sense.
> 
> Thanks,
> Leo

Sebastian
