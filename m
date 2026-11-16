Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824484;
	b=5WiOWbZtrcX/9boAS9oHF9MEyRS5vJFV08JnFqr8AFQ6R1Z3PCHuE1cRGlANL7DxCxL8
	 C4bHLurpm3QMbLag7Iu9GanlgM00tnhA3ALgtkAYVMC2bgw34BZUlv1byJaiiI/g5IZud
	 v8iV/YTfa1cz+9FMpI+eXtF2oZgDZjGE5nyiB4XmIujpcnkxHb9rjpmaqCpzrA7H0tpg+
	 0zxIxqaiHeJj9N/pDIcQPE6rgmYPufAXo0ccKE5Byh2LK44L+biqK8FT/bMXtbY7YSUoU
	 QqsjlpMeXLr5yuqhUJR+CPWF/yLncz223Bnf5BJT4ZVs0PT+yBwpdu0mkxSLG2zViRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824484;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=TtB6NVTta0tvsTqH3AzztjW+y0F8Qfmd7U44QxV+Lc4=;
	b=pPs5ejVuZpOAaDSeFXU6KsuNkDTjVnw/Rv22XGDao8nXPYGvQQGzj/wcBBciiGD4axeg
	 Q0IrPl4R6Iqh/4JusolX0Q0tCT+zeK14xmGlwzAiiSqTN/XrZYLVsdVYfKoXqtk8yjG2z
	 WiB/0ozv6GXDGXaGdYwrarHnvhSyw1FExHzmqdEjWkPHLaFjLzXvWkg43gqKfyLaLnOwy
	 hvPAFrVsShQK+fkrSQLn+wi/7iVF9mrNVgzYgx2DdM9vZbjfL9467LZerZGfHGkOtT0/4
	 7y4pjJbJUjeBtKa4YZdLWPI9Af1EJyn9H6KML55nnNX+Yu0JBjrCt5KI6Urj+/9E6MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="BtlfG/ib";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA11606A33D
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 10:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CA11606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BtlfG/ib
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794824483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TtB6NVTta0tvsTqH3AzztjW+y0F8Qfmd7U44QxV+Lc4=;
	b=BtlfG/ibnUDXfglnm2wYfFWn9PbRAFkNmSFKe2ORa6hecuVghenvFD5ru88vVg2IqrQI/s
	QLKdf3+AZrYm8U9OsuuFTzczQMjgH1wGCR9aCfdqJfWERJ6pKmBAauvxj5kx+kgrj0l4QQ
	7xZRSvVVUXx2Q1AdejTT+ezdWmHpiNk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-m4z9eUV2P_it5f-jKh2LMg-1; Mon, 16 Nov 2026 05:21:20 -0500
X-MC-Unique: m4z9eUV2P_it5f-jKh2LMg-1
X-Mimecast-MFC-AGG-ID: m4z9eUV2P_it5f-jKh2LMg_1794824479
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-49337a224a8so2089408f8f.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 02:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824479; x=1795429279;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtB6NVTta0tvsTqH3AzztjW+y0F8Qfmd7U44QxV+Lc4=;
        b=AoF68imQbPMDYmFxmOM21gzYULYahFtDTcKEBjMiOJzX1f1Ek1KNO2tbJKPbgyijWU
         XVFsWGzUaEUoYCjX8mBuZUDK9NLQT3x2ETtkiZTgM5L1Gel9qYLdctXUyBKxdN6PfnUJ
         qnLbQd+ESIdMojZQM6vwSdVYajdiJCjOPlFtmd/LLSge0M37CqK7gnkFzd7wj9DaEee4
         KdVqAe/p+MepLNlBnyc/EeA4lYXFoy2Y8/JGPDWe64WW6pUoO70YRIuLaJ3qkiM6dHn6
         k/gM3i5oOH78uiXHRqUH/57NwDomqA8pSrRiueTmntXT8Yr1c37lKYH7ijxTzH4MNA4R
         QnrQ==
X-Forwarded-Encrypted: i=1; AL+hErHuTpWwaHZv0MSkBY16HPWGDwGmCwbUfTB1qawcZDGxbxdrTafxbOYYrJhstTcqx66x7OMdMs/bwGd59vBEgg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/pyHJuk2e0E4ILzhL/eUpu9eR21ten1uoTWYhBPLnaFMAKJDJc
	R+zf6wDT4B5d+sSOECzr3eJAGC1xhaIlHMRcuTojnL32WJ/Dxz6aRLDov8i/q7+9yZ4u8SsbtzN
	cOyTgMz3A5w+8BN6GBbjitP6nd2R/oTfPT+u/BZEMZJ+GCJUJI8sIw/N6a8fLIz68mVcP
X-Gm-Gg: AZFdTZc+e0oXQrs1BMa4KHvsPAuEfPoHv5aea7TGxomvaPw6bJOc8ZwPwNz7esfDE3p
	ySB/qp6vUj+INYzUG61vwze4PyxtNia5doMQlcGc4CLH2lCGaxiOKJlxazggIoP5b+jbl0MkzuF
	7j1nKnJV7a1sxrUNKy70VNYo8GMeN6Obs6IQy1DaEyoPmeKqwghBCvMG7193HVsb8yVSmGu4aKM
	WERpFGUMSFKIz2WRWaHAXglbr5YPBNGhnJn4NbFW+G3jk/RrxzahSsq8w7ywN5Jvm1WhhZIpHXo
	+4zhviNOy/Gtn3lkyo6GK338q5Wm0ldmsXc1tlUxWn0KefV+UAK0xqmcW5i2EAX5oEzKhSr2oPf
	s7xUHxABIfbpKBqp76msffgPB9AgC/jKsYa3RwFHMYSVoc4c8mSqNKRJLEiSccwmlbsdGvYR6W8
	jL0VE=
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr20874701f8f.45.1794824478793;
        Mon, 16 Nov 2026 02:21:18 -0800 (PST)
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr20874640f8f.45.1794824478326;
        Mon, 16 Nov 2026 02:21:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60116323sm20991495f8f.32.2026.11.16.02.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:21:16 -0800 (PST)
Date: Mon, 16 Nov 2026 11:21:12 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
	tglx@kernel.org, will@kernel.org, boqun@kernel.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	luca.abeni@santannapisa.it, mathieu.poirier@linaro.org,
	longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
	bigeasy@linutronix.de, clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 13/29] sched/deadline: Keep departing bandwidth across
 a root domain rebuild
Message-ID: <avrZGPNdCwZMd3B4@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-14-mathieu.desnoyers@efficios.com>
 <avRmoK08LoIeySBL@jlelli-thinkpadt14gen4.remote.csb>
 <c3e7054a-486c-4e5a-a646-eee42e815ce4@efficios.com>
 <20261111161912.GP1779021@noisy.programming.kicks-ass.net>
 <83b2244c-f68a-4af3-9c8f-0fabb4eacbb4@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <83b2244c-f68a-4af3-9c8f-0fabb4eacbb4@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cie05XEjsol4L5qu3-yOn1A4C-g4sDhk_XzG5zEd6Zo_1794824479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 11/11/26 14:19, Mathieu Desnoyers wrote:
> On 2026-11-11 11:19, Peter Zijlstra wrote:
> > On Wed, Nov 11, 2026 at 10:35:17AM -0500, Mathieu Desnoyers wrote:
> > 
> > > Measured in a 64-vCPU guest with sleeping deadline tasks:
> > > 
> > >    tasks    today: rebuild, longest irqs-off    single list, all irqs-off
> > >    1000     0.75ms, under 0.1ms                 0.12ms (0.19ms worst)
> > >    10000    7.4ms, under 0.1ms (0.3ms once)     0.9ms (1.2ms worst)
> > > 
> > > The rebuild itself is 8 times shorter. That comes from updating the
> > > extra_bw of the CPUs once per root domain, not once per task. But the
> > > longest section with interrupts disabled grows with the number of
> > > deadline tasks. I do not think that is a step forward for a real-time
> > > class.
> > 
> > This is domain rebuild? Do we really care about performance there?
> 
> My worry is not performance, but rather the contribution of this
> "iteration on all tasks" on the irqoff latency of the system, which
> is relevant for RT.

My take, of course let's have Peter keep me honest here. :)

> What I don't know:
> 
> 1) is 10k deadline tasks something that we should consider as realistic
>    for sched deadline, or it's way beyond practical scale ?

It doesn't seem a very realistic scale to me. Yes, I've used this kind
of numbers in the (far!) past when running experiments with DEADLINE,
but I can't think of a real workload reaching these numbers.

> 2) is a irqoff latency of 1.2ms (rather than 0.3ms) something which is
>    relevant in terms of irq off latency on a preempt rt kernel, or is it
>    in the noise ?

Very relevant I'd say, but 0.3ms, unfortunately, very relevant already.

> 3) are those domain rebuild expected to happen with a live RT workload,
>    or are those operations expected to never happen on a RT system under
>    real-time constraints ?

In small systems, single workload with few housekeeping CPUs, I would
expect the setup to happen only once before the workload is started. So
no worries here. But we seem to have people interested in consolidating
multiple workloads on big machine by, say, using containers. So, in this
case there are several exclusive root domains each running its own RT
workload. It would be undesirable (to say the least :) that a
reconfiguration of one (or a subset) of such domains could potentially
introduce latencies on all the others.

All that said, I now wonder a couple of things (which can be addressed
separately as an RFC if also Peter agrees we don't need to tackle this
right away):

- The 8x from updating extra_bw once per root domain instead of once per
  task does not look like it needs the big lock? Maybe it's a nice
  improvement we could have on the current scheme as well?

- The deeper issue the scenario above exposes is scope, not lock
  granularity. I wonder if a rebuild really needs to re-count root
  domains whose span and membership did not change. Maybe some kind of
  re-walk of only the domains that actually moved CPUs would shrink the
  scope making reconfiguring one partition a non-event for the others?
  Again, we can think about/tackle this separately if it makes sense.

Thanks!
Juri

