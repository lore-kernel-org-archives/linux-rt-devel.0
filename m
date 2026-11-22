Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378869;
	b=AX3pLrcNqUaxHnrg8tjJdMrCCs90q7ixyXEa+PMJo3uqArjQyuo2fE4VCOM4k+kPlMsI
	 9emyvjgFo350MpMt/gLEml7nFfp841szQyybrSw7z1jcPkpLN7SixnSE7PIbqF0TIPiD9
	 5SSOJJ6YJqVhpbi5NE6NaQTYvl7yTtkeoyVMr4xSl3KXsA8Bgou8ySDjusGds5Yfc+hKj
	 3ju7CSx/NtyVTDmavMwSyCR+3qEAgdoKsgWfH/dclEVQRlT5pzMbwyA9asKYpKOIXtMSZ
	 Gdu5BfK6fZFOg22mKIGrdJxpqeleRvF7VIBkmu1ogrP/BzVgjmYF8/262ZQwWRzo1Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KoXhXnM3oUjZYemCskQWf/r+E20vle0w0i0hVE/eaXs=;
	b=0v0jIz8ADCMJDWqqM9+a2TtJJKOGV7rR/Nu1OXD3XvUPCEMYr2tH28BOjMgE67/w/c6p
	 brC1BPU9VMCbwgkDBSGG1trV6CFJHNsGj1iOFCr8FxzmutP5dCnDMotAie5g3sIi5DjnR
	 xG9oGGI7K7i6jQEEn7RdLBRAvpuBlDLr4r/HZTV7IIzg1xQlUokT6GqfxPjiLMU4yGWd3
	 b9jgz4oWNtuYl8mFR3GR1SdbUCVLSSCw47hfIxLcz+MYF1zKGoMpEkIlKa5B7KMTShgKc
	 RIBa/ZBII3p5muht5ou/YtvMUc+lalzYq7FsyN5d8kKylk5jYSLw5NQ/geUbTdhnZ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3CHOYNo;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E556B606A31E
	for <linux-rt-devel@lists.linux.dev>; Sun, 22 Nov 2026 20:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E556B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3CHOYNo
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so24829315e9.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 22 Nov 2026 12:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795378867; x=1795983667; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KoXhXnM3oUjZYemCskQWf/r+E20vle0w0i0hVE/eaXs=;
        b=D3CHOYNoCfohmS1tK9Sbtc1xuRkprgJskHW4+t4f/ycSnfpI6AVbKN3182BDGD5COq
         N2ENvxYUjoPQaymw3FrJgJSi1J18JErsfOSEZiu3Orttn+jZjJbG7neCVa0qvAMdE+VU
         0O/ksVxTdTMKK/iYXrKOfILHcUhOKYXX+JJK5YPu9agDSvTwgqBaf9hOKdkWDKpJicVl
         hEp2vaqHd6ePuNrS+ihro/ZSAv1ryimrMb6HytDonZF+ZAvPiHCOCIjpLdxV8t2u/Q8O
         X2UyFmjTzrSzlOIhQMbq7H4HWcvHzZrdMbpv3cfMWYvHT9XkHFI7LxNJX8HkydWsXr9q
         p6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378867; x=1795983667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoXhXnM3oUjZYemCskQWf/r+E20vle0w0i0hVE/eaXs=;
        b=c9gJ/yXAIK5Oxf37B4wvRv945y3i7ARFP7aQab9pZesq4fFPYduG0tcpyQR2Afla/q
         Z445Fu88Zb0/VBQb1UKAVashKl+bMomIwmYVyI8mTFlhuOR7KDaQFf+d/Ca4pgpJ5Y1H
         oMY87jNxc3IFejtu5j/+H0bCYfgBySF5+jvk9ImR301dI4D12GpC6KFencVonWIP2LMI
         2uydRDFf6miYagY8ucsiBeRxpozegtXBWl/KKAcMbs7+5mkwLHi1HltbsCyo8hsJ9RQn
         o1pd5s4MQgCkdy1ebwaKDr85N4WX/2FmlZew3+yPstEV/jOEcbUYjW77fn9VSNKMdSbZ
         CqIQ==
X-Forwarded-Encrypted: i=1; AL+hErFdUpVvK8exRF7RvZOvNy3s2LoPfx8cjGp529Nvox7P07PaBfbiZRpyfRIRhFOhbx+Wn30BRZRkZ4w3DfkUhw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+dYq7x55CvgN4BuLXvpA+QJ6pkLsn1gIRtZlryjGlqKxe891H0
	98EylfQC5YR1WVJ1qk+O7KN/lNpQr5ItDSkBakDijDTP7GEl4e5SGKjF
X-Gm-Gg: AZFdTZdiVcG1mMXmlFA+X9+A+SZDIpDUf0w+X3wuZLsum/BzkcfuYLs+UkuH+AkiSM0
	NdMMNEpZqo/yJA/P6ZVsFfkAO7Ou+YOpO+jLYOXo4JzNcKhH2n+ngt9vYJvR19HxENvaYeG+6My
	27hRXKPIOSPeaD3JbkVqM1ttw/qRgbxU6BiCJbWQt/TafVkq545JHc94PDmOnqaR5MvMZalitY6
	4Fpw5SVLDri8q8Gr022goGT7xFbEgtZkIfmOgoYPJgIgJ55bGp8M6Zjk+LnAdMTN+R7pwRts80s
	EpdGV7QQQC921qM7F42NREwr2ei7+bBhXWogyxY/I4z3qPu01N8mLsAE5VxJZrmhg1rxtaAzg73
	uopXmpUHNIBcThvkvwe2YapP75q2RKReeH1mki3iedbC+f10+vIJ3Pwe8ROeTth57066iRlABfU
	E/hptlyUt7Z59P9J9kmplV4y2aolatSGJ4PVcop5T5tpLNGCR8HX6XpKqjKPq653iOSBk6opC2m
	tjJZ7w0mpeFn/KTGggv+rI4lf/LwcxmbbBIPLc0s3Euq0f4Cli2KKVyMJuy8rh1L7p2H2P1cCrE
	tIQs9GxuriBa6ymzOKFRwIdzRFNfbSHnD86kyqcTkENoNRYnm3b3b0KkgwgxB52fJ3YcADcMFuK
	p7uz7BQKeXhxFM6aBtmL5TMZBJXc8IhzFyc+o2HUWiT7COjV4cKhD3f+Gwi1wAZ1cXmI/MDsIBI
	FDNWNzu2KLnRvuSfiUwlqYoRVO7d5Miw==
X-Received: by 2002:a05:600c:4f07:b0:4bb:5dbf:af06 with SMTP id 5b1f17b1804b1-4bb88804d58mr235773315e9.9.1795378867083;
        Sun, 22 Nov 2026 12:21:07 -0800 (PST)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a14a-2801-2d6d-9df0-1f3c-62cb.310.pool.telefonica.de. [2a02:3100:a14a:2801:2d6d:9df0:1f3c:62cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm381533945e9.0.2026.11.22.12.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:21:06 -0800 (PST)
Date: Sun, 22 Nov 2026 21:21:03 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 9/9] rv: Test IRQ-exit softirq provenance and
 handoff
Message-ID: <awNNrVvXCFVPhgk_@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
 <20261107171252.25090-10-kmehltretter@gmail.com>
 <e8b9a9afb9587ed1f41c0fafd486ec9be82928db.camel@redhat.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b9a9afb9587ed1f41c0fafd486ec9be82928db.camel@redhat.com>

On Sat, Nov 21, 2026 at 03:01:13PM +0100, Gabriele Monaco wrote:
> On Sat, 2026-11-07 at 18:12 +0100, Karl Mehltretter wrote:
> > On PREEMPT_RT, verify that worker events do not report hardirq provenance.
> > Do not run the synthetic inline IRQ-exit cases there. IRQ exit defers
> > softirqs to workers, and serving-softirq state is task-local rather than
> > encoded solely in preempt_count().
> > 
> > Snapshot reaction counts inside synthetic IRQ-disabled and hardirq
> > intervals, then evaluate the KUnit expectations after restoring normal task
> > context.
> > 
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> I still couldn't read the KUnit tests, but from what I get quickly scanning
> these, it's massive. A total of almost 3k lines of KUnit tests for 2 simple
> models is probably a bit much.

Agreed. I'll cut the KUnit tests down to a much smaller set focused on
the monitor transitions.

> 
> Keep in mind you are testing your unit, which is an RV monitor, so you may want
> to stress transitions, mess around with the environment as little as you can
> (e.g. disable interrupts) and use mocks/stubs where you can. It isn't always
> easy, but the fact you're touching softirq.c doesn't look right. Your
> unit isn't the softirq machinery, you should interact with it as least as
> possible.

Makes sense. I'll drop the test hooks from softirq.c and simulate the
events instead.

I'll address your comments on the other patches as well.

Thanks,  
Karl
