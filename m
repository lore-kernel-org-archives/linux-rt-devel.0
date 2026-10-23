Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771538;
	b=0zM+6Ly14gbwVPzTOI2yqOWbCxiXdL3U4aZkTvTWDowSRDn/2e0hFf3VIWI1LYcXDIxf
	 gTwGwr+r48BIfobdSTRFlhEhR+LMLzigipyjsbdM1Yk5mYE9qCoAwhQa9IqcN9u2bxebW
	 YFSHIicCg3+RzBl1pQBpob3mnPlTbujJOqZ1/dwCIZIuqUmFXMEFUpAZo5wUjM5A561tv
	 4+cT0BoQoTR9DBX5MrCPdncwQxZFWJoCKhGEOp5iug+wAZ0jPXxvkeNG8x9ELDM+ALAaW
	 19qyOOvHllYJ8cn2wS2sKmorDLK9cmiz2Qx0rJe1JVdDZJUTeeqpUCOVhom1E5MSu7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771538;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=K14cnwecKDZXuHS20WMKxtkA3ZjcXzFbG9A0UfcDyZs=;
	b=GXIxjCPRnJ7ztnuOMaOgseekWERYkXijUmCXUWOEYKcvNRt6UeUsrMUBYapn1BYS5gmf
	 1nD3YKlnUEClQsEMRG3vTkvLvsgvFD7rHH4YueR4ht1G5Djn9JV49WbBx6CauxiC8ZYuZ
	 10g1v7F77laADAcDGF/PmKIXzjk8oGCU42kC2R4TNXgeZMPpuF5XO52iGsBPwBy586s33
	 +T1BT18+JYZEJM3oCnCnZOQVTOD8X+oW4O140zkht3ijCKfHv4fdBQ7wkehU6B1bgr1mx
	 wbUb3RCDRvfI2st79nZtvg2bJx6m8kA15qACL+NKvK5D+ImVVCm/ShKUA0ItvAJS05A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f7fjgzf6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1D606A31A
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Oct 2026 16:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F1D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f7fjgzf6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792771536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K14cnwecKDZXuHS20WMKxtkA3ZjcXzFbG9A0UfcDyZs=;
	b=f7fjgzf6Khkl/ZFPkz2neLM5hyPuDZGbst+5FWWM8wM3QWYgSkrAb5Wg15J7bkaq8mgihZ
	K7X6xc+NtThfWZhbP+TXtU5Y5NU3Zvpq0XYvEaSCm8QyvyKEI3u/T/SESrgYPeDTOcDWcd
	faTkTutIeeMNhoM9e7ka4MMXfzFCaNM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-sDEgpaerOH6ctMnHrgMn9Q-1; Fri, 23 Oct 2026 12:05:35 -0400
X-MC-Unique: sDEgpaerOH6ctMnHrgMn9Q-1
X-Mimecast-MFC-AGG-ID: sDEgpaerOH6ctMnHrgMn9Q_1792771534
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1895ffc83so7691795e9.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 23 Oct 2026 09:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771534; x=1793376334;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K14cnwecKDZXuHS20WMKxtkA3ZjcXzFbG9A0UfcDyZs=;
        b=ncS2i1R9EVlSZhFbrTapPAazrlbnDJ4W8VfVabpzoZ53qsRSmpnHAHLQj934NBAKlV
         e2tDb+Dh1bO4oPaTSnUShPIHaOUeyqrUUW8cOyA9tAAFvrwh1Ax2N7uZMPrQAtII303r
         B+omJMMnvXXupEiQ7ehZ2e1r7x8oBXvpF523ZjEhLr6aF1inNc4U6KpOmVdclKZ7mMXl
         ms7yvMXUQFTNrHItcJcHM8W4WLwiRbbajfsPyRPhwLQ645lir3dJVio3VctpJPjbSiSJ
         evyCO/fodD4kKdrlLF1iojWJcttNES5JaN0R6oVBtA8M712fVdeWg9JFAMLiOJIruzPs
         n5pw==
X-Forwarded-Encrypted: i=1; AKwUvByI1+YO+1Cs9CgKJ80FUwMnX5EQK/1n2+WP8QRhMMS0A70Bq7Eiif+mN8zmnsK/JZsJPPQ/QxTQJfITQpz7iw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJjfW2lDUTkSjQQOv6IADPdwQZXVj2fRTm/SaW2d6xVVGFG26Gt
	Aa6gYuTBo6bsWfxCowdNacJN1DXhHOjEwUeqZIlwktDrEuhvni+vviYMvA26IS1psPALWvm+a8q
	qK7P5np1lY3NebLJ1PWNVSDwfW270h9jtKiJQ1T1R2JgbDTngGv+mstUlIQDHlJOwCGKy
X-Gm-Gg: AYBFou3hkoVga1PZPj5WiBHe0poQPQ5xwoKbi5xvvx6yl5N8xYHCWDPgZuEbowtwTRF
	mMXEfTHRz2k038yimfLFOifdCNJQPZVPTa6qse6CIotRtG1dVuM+IFq5RRC+kcrL8Fxky49NIu/
	WrD5J7LA4pS/PfLbkIYzqkEvamlSbPn21Y199HiiKqCgkf8x9JfWO2b4ayLZ0HIcO7tbItQTfcA
	98/EPSkMtxi1j2d+BqgobVxukWSP4RIf0aiW6ePjMC5h5DYgNGHvvKq8polnLoAQaYnc2CHafWK
	xOK42ljDuCzwPcvZscuqlWB7R48Mvk6Ey5m3DEtfklvbSndeu8qTWl04zpbKBc7yVb5GrSi18Nx
	+kt9GcycmfOVmyzst2zgMqYMAjx1E
X-Received: by 2002:a05:600c:3514:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a211ed7602mr43987685e9.26.1792771533995;
        Fri, 23 Oct 2026 09:05:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3514:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a211ed7602mr43987145e9.26.1792771533585;
        Fri, 23 Oct 2026 09:05:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a312ea914esm4004515e9.2.2026.10.23.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:05:32 -0700 (PDT)
Message-ID: <5b3ff014bf2f571b935f9519f422966a1c665c32.camel@redhat.com>
Subject: Re: [RFC PATCH 0/9] rv: Verify generic IRQ context transitions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers	
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@kernel.org>, 
 Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Ingo Molnar	 <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Andy Lutomirski	 <luto@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot	 <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,  Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>,  K Prateek Nayak <kprateek.nayak@amd.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,  Randy
 Dunlap <rdunlap@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 18:05:30 +0200
In-Reply-To: <20261022050712.75035-1-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
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
X-Mimecast-MFC-PROC-ID: oJUMxhA0DNagkfXUqQSOOY7BzxwW7ozm3pdRMV5KZuM_1792771534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-22 at 07:07 +0200, Karl Mehltretter wrote:
> IRQ action tracepoints describe handlers, but not the lifetime of the
> enclosing IRQ context. One context may run several actions, and an action
> may be dispatched outside hardirq context. PREEMPT_RT may also enter
> serving-softirq state without invoking an action. This leaves no generic
> event stream from which an RV monitor can check IRQ-context transitions.
>=20
> This RFC adds events at the generic hardirq and serving-softirq
> boundaries. The irqstate RV monitor checks their order and agreement with
> live kernel state. irqexit follows the owner of a preempt_schedule_irq()
> invocation across task switches and CPU migration.
>=20
> The hardirq events cover paths through irq_enter() or irq_enter_rcu() and
> their matching exits. They do not cover direct __irq_enter() and
> __irq_exit() users, raw paths, or architecture-specific entry and return
> intervals. irqexit covers preempt_schedule_irq(), not the complete
> interrupt-return path.
>=20
> Boundary callbacks can raise softirq work after the pending-work check.
> The series wakes ksoftirqd or ktimerd for remaining work. KUnit covers
> nesting, monitor synchronization, PREEMPT_RT worker intervals, provenance
> and late-work handoff.

Hi Karl,

thanks for your contribution!
I'm probably not going to have much time to look at this soon as I have a f=
ew
holidays planned and other series to review first. But it looks interesting=
.

What points my eyes is that you didn't include any schematic graph in the
documentation.
Some folks don't like RST, but I find having a textual representation of th=
e
model there easy to understand what you're trying to do without having to b=
uild
the models.
We use graph-easy for that (and adapt things if the model is too complex).

Do not send a V2 just for this, but please keep that in mind for next time.

Thanks,
Gabriele

>=20
> Cross-architecture RV KUnit testing also exposed an Arm-specific opid bug=
:
>=20
> =C2=A0 https://lore.kernel.org/r/20261020035158.90190-1-kmehltretter@gmai=
l.com
>=20
> I would especially appreciate feedback on:
>=20
> =C2=A0 1. Should the context boundaries be trace events or private RV
> =C2=A0=C2=A0=C2=A0=C2=A0 instrumentation?
> =C2=A0 2. Are dedicated scheduler events the right way to follow
> =C2=A0=C2=A0=C2=A0=C2=A0 preempt_schedule_irq() across task switches and =
migration?
> =C2=A0 3. Should irqstate and irqexit remain separate monitors?
> =C2=A0 4. Is the KUnit-only hook for an empty ksoftirqd invocation accept=
able?
> =C2=A0=C2=A0=C2=A0=C2=A0 Outside a KUnit run, its worker checks take a di=
sabled static-key
> =C2=A0=C2=A0=C2=A0=C2=A0 path.
>=20
> Patches 1-5 add the events, monitors, and documentation. Patches 6-9 add
> KUnit coverage.
>=20
> This series is based on v7.3 (c03c1a14507d) and depends on the following
> accepted change, which is not included:
>=20
> =C2=A0 softirq: Preserve interrupt context on return from interrupt
> =C2=A0 https://lore.kernel.org/r/20261011060742.30584-1-kmehltretter@gmai=
l.com
>=20
> A pre-existing issue can make rv_test_dummy intermittently report a
> false-positive invalid-wait-context warning under lockdep. Wen Yang has
> posted a fix:
>=20
> =C2=A0
> https://lore.kernel.org/lkml/5586dd00789a0f904cc299cd8889744b8c6f8dc9.178=
9412799.git.wen.yang@linux.dev/
>=20
> This series does not include that fix.
>=20
> Karl Mehltretter (9):
> =C2=A0 tracing/irq: Add generic IRQ context boundary events
> =C2=A0 tracing/sched: Add IRQ preemption lifecycle events
> =C2=A0 rv: Add a monitor for generic IRQ context transitions
> =C2=A0 rv: Add a monitor for IRQ-exit scheduling ownership
> =C2=A0 docs/rv: Document the IRQ-entry monitors
> =C2=A0 rv: Add KUnit coverage for IRQ context transitions
> =C2=A0 rv: Add KUnit coverage for IRQ-exit scheduling
> =C2=A0 rv: Test empty PREEMPT_RT softirq worker intervals
> =C2=A0 rv: Test IRQ-exit softirq provenance and handoff
>=20
> =C2=A0Documentation/trace/rv/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0Documentation/trace/rv/monitor_irqentry.rst=C2=A0=C2=A0 |=C2=A0 398=
 ++++
> =C2=A0include/linux/interrupt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 7 +
> =C2=A0include/rv/kunit.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 34 +-
> =C2=A0include/trace/events/irq.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 70 +
> =C2=A0include/trace/events/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 51 +
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
> =C2=A0kernel/softirq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 308 ++-
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +
> =C2=A0kernel/trace/rv/monitors/irqentry/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 13 +
> =C2=A0kernel/trace/rv/monitors/irqentry/irqentry.c=C2=A0 |=C2=A0=C2=A0 35=
 +
> =C2=A0kernel/trace/rv/monitors/irqentry/irqentry.h=C2=A0 |=C2=A0=C2=A0=C2=
=A0 3 +
> =C2=A0kernel/trace/rv/monitors/irqexit/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 14 +
> =C2=A0kernel/trace/rv/monitors/irqexit/irqexit.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 172 ++
> =C2=A0kernel/trace/rv/monitors/irqexit/irqexit.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 85 +
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_kunit.c |=C2=A0 537 +++++
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_kunit.h |=C2=A0=C2=A0 21 +
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_trace.h |=C2=A0=C2=A0 19 +
> =C2=A0kernel/trace/rv/monitors/irqstate/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 14 +
> =C2=A0kernel/trace/rv/monitors/irqstate/irqstate.c=C2=A0 |=C2=A0 289 +++
> =C2=A0kernel/trace/rv/monitors/irqstate/irqstate.h=C2=A0 |=C2=A0 139 ++
> =C2=A0.../rv/monitors/irqstate/irqstate_kunit.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 2062 +++++++++++++++++
> =C2=A0.../rv/monitors/irqstate/irqstate_kunit.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 25 +
> =C2=A0.../rv/monitors/irqstate/irqstate_trace.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 15 +
> =C2=A0kernel/trace/rv/rv_monitors_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 29 +
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 2 +
> =C2=A0.../verification/models/irqentry/irqexit.dot=C2=A0 |=C2=A0=C2=A0 21=
 +
> =C2=A0.../verification/models/irqentry/irqstate.dot |=C2=A0=C2=A0 32 +
> =C2=A029 files changed, 4397 insertions(+), 13 deletions(-)
> =C2=A0create mode 100644 Documentation/trace/rv/monitor_irqentry.rst
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqentry/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_trace.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit=
.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit=
.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_trace=
.h
> =C2=A0create mode 100644 tools/verification/models/irqentry/irqexit.dot
> =C2=A0create mode 100644 tools/verification/models/irqentry/irqstate.dot
>=20
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> prerequisite-patch-id: 6ac7167f0aa7c5319dac78bf5b06a989fd7dfac5

