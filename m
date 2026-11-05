Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890856;
	b=HB9cmQrGoxljkCXjTuo/j5vCbeb30afzDhOvqBGuc5uXODCkFPmoM9CCn+THxUMDouFN
	 iz0fKJpo/aM1iWRLOhmCdhYDpB+SfUqrnxW5n3n4iigiIWbsjd1j2o6RuwGYoco8mFa+W
	 GzBW30O4x8tVhbDLFv9xq+YgbqmdmG8gde/4wXyDMOoFEwqHJLm6FjbFPZ95Ob7M2ZqRv
	 O0LQXNsICtoNs6z/7Pvo02UkpMytKafCypkkLt3YqseQC8rcCHEXykC5ARnMNQFuKGHeK
	 SmNihQ0xWHfcX3CIwbidIFfQfQ1S6r7gkFAr3XPP1LJqZk+DJ+H5ZAvDhUmVdP3vTtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890856;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=leAQgaahqk6ie+8K1Enx+eS2rtZduvQyWhwKq33EErA=;
	b=ZAMmocB+s0YzRdbBPnBRgBjvGaCGPNaGrQM7e9pMNL0CN+wtcahSekC3oXfxPhSnlokn
	 rAC9a/ecNVdlAgcPCmz3XyNKJCvh/du32t80e8l1zZATC6tgRlNn5fVKphujH1QAbSJk2
	 VNvDIl4OQEp6fsSAthubf/CSJq6vBeN9/W3f9Lg7PEoXPLimNXllPLwWXg25MVCtlXDdC
	 tG8+3Yn5QBQ6beUpCfIUmjCnkz6yG6Xw1Abigt6THHtnCTsPZKecEWhojaes+ESDDyVe8
	 KzsJVlV9xTO9tTKb3svSJDkn7/tVTGQhNlTeGyaYIhEFhUzGktQ6lnYQHBT7l21Dyhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cX+4UnMn;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF25606A339
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 15:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FF25606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cX+4UnMn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793890854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leAQgaahqk6ie+8K1Enx+eS2rtZduvQyWhwKq33EErA=;
	b=cX+4UnMnrVyBAq4AazkUqBaYAkBZ3DjkVbYELumwk1ir4sLK+18et3tVQkDU2roQ9MdUcg
	+5ur5FvdrhExkbwHCJRh2N77eC9qW3HgrgikyU+1k/LJ1eJTlB2B3utvDKX3YOkTi5U7Uq
	/0/kBxvB7i7ThN14TNgcB5tum5M3qIo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-kugnP-bROPqRncRGzr6mMw-1; Thu, 05 Nov 2026 10:00:53 -0500
X-MC-Unique: kugnP-bROPqRncRGzr6mMw-1
X-Mimecast-MFC-AGG-ID: kugnP-bROPqRncRGzr6mMw_1793890851
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so11153775e9.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 07:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890851; x=1794495651;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=leAQgaahqk6ie+8K1Enx+eS2rtZduvQyWhwKq33EErA=;
        b=a6nYdqpLwCNLo96rajqfwsQFN9STZLpFke2qX49ELf6bngJPKZ3Km1qfaiYc1Zm9eq
         GCaiu9EwN1dHhVFdS75YYWHl5PStjnEcnKa+qoKlG4srkL6XEflo5YHwtZ61UP8MNvP0
         s85diBIvcjRmLwqbdVd5MXKbarlxkXWO26HrEMaD3nDW6hMyR2TkbCUGf1jPU2vqzyVz
         he9ue19hVA/ep6LjqhJlTSM6s9D9blr0KoEuf+RBSTdrWFXB3XrEdyTytYOAVPtWD9lE
         CJyQAvLjhRfjEkNyn+MEoL1F+yTixIaSpd3KXZI8SqI8Z+PBiV7QJJtj4HNdcbCOQBQ3
         q9uA==
X-Forwarded-Encrypted: i=1; AKwUvBw63w9x6RWhD70PjZWXjjYCh4zBzYRRcUFLr+5C3U+RSEW4n7jDH7pljXRWKUiwCxJKVLFNy4I/786WYdGv2Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/oqYvn5ow2zFFMhYCDc6sXEEEv1F4J5HphuaKC8OFjeukULmTJ
	QbBUDy6v7PRCmr2GWnEGnN/qt+OHVHyHwJZClJ/FvWXCbjnIbOKqT+1LAKBR7F8a5EZ7In4GM5G
	PvqiVykiqT6GKi71qm2GyDhg5NC2l656pJ2PuoTTKv/iZO2uGTmAXXPpjXFM9MzCXaKNf
X-Gm-Gg: AYBFou0fqEZagB5Uq5XSReGOJazhHsLDepKZuFWow1ztHNJWiFtIaXXynmjhMihabrK
	D2q6KqcqTC5tv7FhgWLmahY72+LyEG0hn4FB+8CBzkALkIofw7mrEVzUK/ZLVRtFj27uLCfTwVT
	RZ+68cCd1RV9QFC2kqCua7Zjgi9vgt+99i6dpmNpzrOMV9cvbpRU5P3ZgXa9Zpwe6l/0eo27L99
	2sZLl+FY/G4p6qaUTUZOF3UKIL+gcn0C3xu6eIedDh1J6ESua95jt2VOu7gTGzbO9W6qWuo0k86
	bYHXKkzAC0cVXW6Gf7TZ9BCKOqOkV7Tam+gjtte0nu9p1WZYpMsYV/NWEx3M8IoL2OXA+PMUGhQ
	5b8Lzwosl4HTGiS0xIa1ym7BVTUNCTDAOGUU522uOtmFLE13IDiAXs1hfKRbqug8=
X-Received: by 2002:a05:600d:82e2:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4b55d7d7a2amr55606855e9.10.1793890850756;
        Thu, 05 Nov 2026 07:00:50 -0800 (PST)
X-Received: by 2002:a05:600d:82e2:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4b55d7d7a2amr55605885e9.10.1793890850041;
        Thu, 05 Nov 2026 07:00:50 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b452eb99b1sm108926575e9.3.2026.11.05.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:00:48 -0800 (PST)
Date: Thu, 5 Nov 2026 16:00:46 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 08/21] selftests/sched: Add a test of SCHED_DEADLINE
 policy round trips
Message-ID: <auyaHi0W_R_LLXUE@jlelli-thinkpadt14gen4.remote.csb>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-9-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104211207.1392343-9-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WfsGM9vhiYyAMFiDWwiHtRA6exHKSSjRhpmB7EyCAnk_1793890851
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 04/11/26 16:11, Mathieu Desnoyers wrote:
> Add deadline_switch_test, with a case for the fix two patches back and
> one for commit 41a7968022ca ("sched/deadline: Fix total_bw leak when
> switching away from SCHED_DEADLINE while !queued"):
> 
>  - throttled_round_trip: a task with a runtime of 10ms per 2s period
>    spins, so that each replenishment throttles it again at once. Right
>    after a throttle it is switched to SCHED_OTHER, and back 200us after
>    its deadline: past its replenishment timer, and before its 0-lag
>    time, which the overrun scaled by 200 puts later. It must run again
>    within a period and a half. Three attempts;
>  - asleep_round_trip: a task of 9ms every 10ms, running 0.2ms and
>    sleeping 50ms, is switched to SCHED_OTHER and back while it sleeps
>    past its 0-lag time, enough times that a leak of its bandwidth at
>    each round trip fills the root domain: sched_setattr() then fails
>    with EBUSY. Skipped without admission control (sched_rt_runtime_us
>    at -1). A kernel that leaks is left without SCHED_DEADLINE bandwidth
>    until a reboot, so this case runs last.
> 
> In 8 VMs of 8 vCPUs each, v7.3 fails both cases, and v7.4-rc1 with the
> four deadline fixes of sched/urgent fails the first; with the two
> previous patches as well both pass; every time.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Thanks for the selftests! Very useful.

FWIW I did propose some already in the past, but then didn't get time/
tokens for a follow up:

https://lore.kernel.org/all/20260306-upstream-deadline-kselftests-v1-0-2b23ef74c46a@redhat.com/

We can probably re-start the effort with yours and keep adding as
needed.

Do we want to have per-policy subdirs under sched?

Thanks,
Juri

