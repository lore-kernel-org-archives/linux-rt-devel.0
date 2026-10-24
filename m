Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844017;
	b=ieAd+isYYNDG+/ohlQFWO+fhm4VxIliRCdOky8ukACs5W/W//ftmdncrSoDqZP5hd+ru
	 uccD8QMypQPiPi4Jxw/NFtjxF6kfhavbU99werC+sonhwnjBxHO+je9mYqDkBzzxqsrfQ
	 UF37QvawTeC+3lhqD9Xy5aY69ZvrZWuXuQj/eDzNGj+EyqsNSWICZ/veGm3MmiAv/WcK1
	 BY+n+JG+HMkun73p6eRQ5kcyBWBVobrbV/HDgz/jr5P/tPboPsYkJG3uYK3I4x6JQqGDN
	 9WhG7KVsYo3N6HurvEj+B+Ax9oI4pg7FV5VVRc2YmfzZYbmq3ecSFouxK3m48m2bb9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844017;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=UhqDzvylCUClPcAmFlf4zscztq4m0z25fogi1NkYGug=;
	b=cg2p1DTMBHgmX68b2DRmwynkWu2b87mQpx1ktDiX2hN9gv/pZxm4qGO0YexvV4OugxbQ
	 z5TXepGGICuk4u487R9o/NrUgVGe8/2rSIHXEW9F/X2pQ/RdqyK3KH4qALtWzBBT/UFyg
	 D9cB5h9UZrZx73sZuNmDKScSJYZFNC7bpZNGQjr4esxfu6xoKi+YvOJR5G1yDRVvfr3Qt
	 Anxh4fuJE0rspcAydJ5dW/wwW9eZA/KTktaaymqhp8qbdG7bhgtaoMOutTpZBHajnxfH+
	 dzfxfVUKkjQAG1r7TN9ynH8FjZBTsrNLtajW+sjbY3xTmNpueEGtoycfvKLLdbAYvzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fUnje73F;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22FF606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 12:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A22FF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fUnje73F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792844015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhqDzvylCUClPcAmFlf4zscztq4m0z25fogi1NkYGug=;
	b=fUnje73FvRLfi7lIAOdjFrQXz9xIZgFwKWMU93lsI3net4ybQAvJcZBMVKvRuUKvGlmUPE
	UMm6FK3qqhI3N9Ml+Tdk+XxOVoLCPeQc5EnXH+9bE5ptm7Orj4SUgcaF0ZvkJSGmFBTifK
	H8wq/HBk+01HzF5FvIbKAvxjHqKyaEQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-SyX9flCfOdW1y_hHaugMKg-1; Sat, 24 Oct 2026 08:13:32 -0400
X-MC-Unique: SyX9flCfOdW1y_hHaugMKg-1
X-Mimecast-MFC-AGG-ID: SyX9flCfOdW1y_hHaugMKg_1792844011
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c41b03cd1dcso159713166b.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 05:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844011; x=1793448811;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4C00/XzUMl81Cb9nPtDyYxb7VozrfQ6cNr56bWwPUU=;
        b=Cwo/DhNkdDlMw1GogmJnunT7WJKrbFGYTxCKMKWK9tRYExC1WKGK5ELyTVk5WASwT+
         5tL31/hf5K0Sc59ZCaTaNhz5Sy1eLrjpSO94Xm/NFbklIfPFWvaXUTcz4zcUcNbFobVO
         qZLH8N5pi5FUm6Qo5dqnVr+iuTug5K8TObelS6ZPp98t92wnqahB0dlx6QMxZ7tfSfap
         nsY5Scst83taVcwp9x56ppzVY5bkrdcad/g6E+/FuToYqluqP3I9/i7YThoyQ7Z9+NeK
         N5HR3ya1EmTQAORZFXxEnrkkzhnjIpQtiu9atuwxhSDtvtBCuJ2/sQLnDNIoZ5y4Fi1R
         XN1g==
X-Forwarded-Encrypted: i=1; AKwUvBwNYZR0XI+iPRsHyzZhnAlhzo4b/cdq2nJZV0+byQk1jOi2k5TqeGU+ZebjfeXsux814Ge3aBTSTCa6pSLYvA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKhKikJFFMfbaD0E2ITPgrKH1fFN4TTDH89RFRXTrnCeW16KaSo
	P8WO0cg98IGGzNBFDHPecJXInkFZBLi0+CFuOp3UBofWpKmJ6JCAM15pzsZOKgIsfDKpCHIsQIq
	bXnEvRzMFpg/Nfi/otYptgxIsTysB6PUxoEN4Yo8PL8HoYGtuniHo4nOXWzBj+Sd2+8Df
X-Gm-Gg: AYBFou04P7WJduY9PZVOwcwsuZtIVJPot8WuKwCtRXS3t94oWzCdosIyDVTl9e/9UDZ
	NZvmxJCVZJX+guGWR0uw6CSZkZAo5ecZYYg7RadyHP6tjDWtY0RY/ze7+PRwKPuUAA2NI87uNGI
	TB3N5iylJbxZqoyNLZOOT0qgZ2lPY/GNOJPFE2OvNn8LPAkZCD7rR+c5jdZMAGhqd2fqUqTnRIV
	UTvMPkczJmsVCpJY6YFR5LtCvJaYHpey1y3Sg/ZGaBDb7z+U15g9ZePdMyQ/vq2sUKQKu+/FuUc
	0nRP968Nki+/TKFK9Z2XTZwnbce0dq8Ynf57iCilWsIZwsAOXSdpc0e9BgpDB2M=
X-Received: by 2002:a17:907:803:b0:c45:60ec:32c8 with SMTP id a640c23a62f3a-c46bde93f0amr177898266b.38.1792844010999;
        Sat, 24 Oct 2026 05:13:30 -0700 (PDT)
X-Received: by 2002:a17:907:803:b0:c45:60ec:32c8 with SMTP id a640c23a62f3a-c46bde93f0amr177894266b.38.1792844010612;
        Sat, 24 Oct 2026 05:13:30 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:7c80:0:3a4::13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4ea39fsm83877966b.29.2026.10.24.05.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 05:13:30 -0700 (PDT)
Date: Sat, 24 Oct 2026 12:13:26 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] rv: Verify generic IRQ context transitions
In-Reply-To: <20261022050712.75035-1-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
Message-ID: <FACA54EC-F846-4051-9ADD-DB46E7665FAD@redhat.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q6nZqsLMGGz4QOwq8tOX_hb4fmYNKXr896hKUF1RpeE_1792844011
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 22 ottobre 2026 05:07:03 UTC, Karl Mehltretter <kmehltretter@gmail.com> =
ha scritto:
>I would especially appreciate feedback on:
>
>  1. Should the context boundaries be trace events or private RV
>     instrumentation?

There aren't any RV-specific instrumentation sites. Now you used trace even=
ts, for these you usually need a broad acceptance because they are visible =
to user space. Have a look at tracepoints (the last ones added to events/sc=
hed.h are good examples).

Otherwise you may have a look at my BPF series and use other BPF-specific p=
robes (fentry/fexit), these won't need any kernel addition. Just mind that =
the series in an early stage. [1]

>  2. Are dedicated scheduler events the right way to follow
>     preempt_schedule_irq() across task switches and migration?
>  3. Should irqstate and irqexit remain separate monitors?

Feel free to merge them unless you see a use case where one would launch th=
em separately and allow violations from one but not the other.

Also the irqentry collection with an irqexit monitor is mildly confusing na=
me-wise.

Gabriele

[1] - https://lore.kernel.org/lkml/20261001152042.124445-1-gmonaco@redhat.c=
om



>  4. Is the KUnit-only hook for an empty ksoftirqd invocation acceptable?
>     Outside a KUnit run, its worker checks take a disabled static-key
>     path.
>
>Patches 1-5 add the events, monitors, and documentation. Patches 6-9 add
>KUnit coverage.
>
>This series is based on v7.3 (c03c1a14507d) and depends on the following
>accepted change, which is not included:
>
>  softirq: Preserve interrupt context on return from interrupt
>  https://lore.kernel.org/r/20261011060742.30584-1-kmehltretter@gmail.com
>
>A pre-existing issue can make rv_test_dummy intermittently report a
>false-positive invalid-wait-context warning under lockdep. Wen Yang has
>posted a fix:
>
>  https://lore.kernel.org/lkml/5586dd00789a0f904cc299cd8889744b8c6f8dc9.17=
89412799.git.wen.yang@linux.dev/
>
>This series does not include that fix.
>
>Karl Mehltretter (9):
>  tracing/irq: Add generic IRQ context boundary events
>  tracing/sched: Add IRQ preemption lifecycle events
>  rv: Add a monitor for generic IRQ context transitions
>  rv: Add a monitor for IRQ-exit scheduling ownership
>  docs/rv: Document the IRQ-entry monitors
>  rv: Add KUnit coverage for IRQ context transitions
>  rv: Add KUnit coverage for IRQ-exit scheduling
>  rv: Test empty PREEMPT_RT softirq worker intervals
>  rv: Test IRQ-exit softirq provenance and handoff
>
> Documentation/trace/rv/index.rst              |    1 +
> Documentation/trace/rv/monitor_irqentry.rst   |  398 ++++
> include/linux/interrupt.h                     |    7 +
> include/rv/kunit.h                            |   34 +-
> include/trace/events/irq.h                    |   70 +
> include/trace/events/sched.h                  |   51 +
> kernel/sched/core.c                           |    6 +
> kernel/softirq.c                              |  308 ++-
> kernel/trace/rv/Kconfig                       |    5 +
> kernel/trace/rv/Makefile                      |    3 +
> kernel/trace/rv/monitors/irqentry/Kconfig     |   13 +
> kernel/trace/rv/monitors/irqentry/irqentry.c  |   35 +
> kernel/trace/rv/monitors/irqentry/irqentry.h  |    3 +
> kernel/trace/rv/monitors/irqexit/Kconfig      |   14 +
> kernel/trace/rv/monitors/irqexit/irqexit.c    |  172 ++
> kernel/trace/rv/monitors/irqexit/irqexit.h    |   85 +
> .../trace/rv/monitors/irqexit/irqexit_kunit.c |  537 +++++
> .../trace/rv/monitors/irqexit/irqexit_kunit.h |   21 +
> .../trace/rv/monitors/irqexit/irqexit_trace.h |   19 +
> kernel/trace/rv/monitors/irqstate/Kconfig     |   14 +
> kernel/trace/rv/monitors/irqstate/irqstate.c  |  289 +++
> kernel/trace/rv/monitors/irqstate/irqstate.h  |  139 ++
> .../rv/monitors/irqstate/irqstate_kunit.c     | 2062 +++++++++++++++++
> .../rv/monitors/irqstate/irqstate_kunit.h     |   25 +
> .../rv/monitors/irqstate/irqstate_trace.h     |   15 +
> kernel/trace/rv/rv_monitors_test.c            |   29 +
> kernel/trace/rv/rv_trace.h                    |    2 +
> .../verification/models/irqentry/irqexit.dot  |   21 +
> .../verification/models/irqentry/irqstate.dot |   32 +
> 29 files changed, 4397 insertions(+), 13 deletions(-)
> create mode 100644 Documentation/trace/rv/monitor_irqentry.rst
> create mode 100644 kernel/trace/rv/monitors/irqentry/Kconfig
> create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.c
> create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.h
> create mode 100644 kernel/trace/rv/monitors/irqexit/Kconfig
> create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.c
> create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.h
> create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
> create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.h
> create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_trace.h
> create mode 100644 kernel/trace/rv/monitors/irqstate/Kconfig
> create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.c
> create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.h
> create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
> create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.h
> create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_trace.h
> create mode 100644 tools/verification/models/irqentry/irqexit.dot
> create mode 100644 tools/verification/models/irqentry/irqstate.dot
>
>base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
>prerequisite-patch-id: 6ac7167f0aa7c5319dac78bf5b06a989fd7dfac5

