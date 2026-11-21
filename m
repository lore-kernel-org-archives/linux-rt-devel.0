Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795270996;
	b=LIG0TEYnPVbVjFL/Ej3KnPKi9fSX5+xkeJazciYhlpky9SZVdYScbG1mQU5/SgdZhZ+D
	 yRR+0YJCmOZ4TbdHRV/zET/aXuoQSDLW+S5gdxzqAhWNVKRRvQPd+5v72G14trtlNLaWG
	 X1bBqvQ5yJSRbRQk0G3KvCY9N2TQ3WsvOQD5JuMZQW3SF5uZ90BcDOKFGnjQmEI+uoqy5
	 oGhpbaoAAT0H5vv/IxHkk4pnF9TiXlVmm8m29tN+gqmVKfCIMP1R0KG9fYViZnhQM1jNX
	 r90n7wQqHftXOGmdq6FPfFcLhzcmzOtT9ULcg2oSg39FDB7UnsPQu6YGmFi9iSH5l6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795270996;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=WqzN6zJ4R2jqDldWJTZ9k5y4S9ZfXvzqjQVQe1JBsIo=;
	b=uoqRaYQr3vczb4UQ+p2j8QOkEYfxDcHbcvsGsVHrieczIgF7aIjXC90wjv8m7pEkNzFG
	 lwh9L0YYkkj3+IsgMdoUL5kjxSH9D5YgGmKLL/XjuXCk88tgwr82xEjl6GtvNyw5vddnI
	 YAqvgwgg8iwRKsLGIUzxQpkmaixCk6c9iMn+i6hufPx2t2Aqf7chFCGqHYz1FJi6irDdC
	 A/tgY9c3vmHihsMaXtBLNhRT/h6ao9cnrh4VkWaYw2IG84xJDB+ldUHDytaztRtqDQiWC
	 /q7uIB8g5XTBzhsk1TlRRbkTPMm5Q2E4Sq2OACyj5iNUZAY6VQkdy2fDoaCv2yQrkZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Hsf/1N7u";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03144606A320
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 14:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03144606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hsf/1N7u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795270993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WqzN6zJ4R2jqDldWJTZ9k5y4S9ZfXvzqjQVQe1JBsIo=;
	b=Hsf/1N7uTb+bvG5QyOcUdPGMhF7ivw3NizIGztugYh+y4rNKAd5jAHyUCKG6o2PjBSuwhz
	idErqVDhgoLAn/1DSNLxoEIZyKeuWbh+Aa7s4ICOp6EJAw65minFMoqMTPSehi7XHzAtpf
	1x0Lfm5mWQ6TT0yaDFkbwDuHIC27HHA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Jq1rZSkNNz--QbiGDTbcRg-1; Sat, 21 Nov 2026 14:23:12 +0000
X-MC-Unique: Jq1rZSkNNz--QbiGDTbcRg-1
X-Mimecast-MFC-AGG-ID: Jq1rZSkNNz--QbiGDTbcRg_1795270991
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48fbcf023dcso764148f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 06:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795270991; x=1795875791;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WqzN6zJ4R2jqDldWJTZ9k5y4S9ZfXvzqjQVQe1JBsIo=;
        b=rurghOYF5hupCqEyn8jyyNSR0abxi5CstcejnIhDHnKCC6EUm7+yMUpxTp8cEPmWks
         KUrTS3yCPstGmpm4whRpYi19JkBBFLc2JbGbc7CdjT0EuQBb4j72BUBHHLJ96SJAhuaG
         fWdGmsFSBKY+AUn1+Dg46cA1Bs4KjHO+A0Itc3iwWiWuai7nc6Ws7OjQvfMhi6vyuHxv
         gkpVJN3Zk8GhuPGB56q4Gpe2lm4a5/7no/Ao5PH0Fg6+SroR7RT61bP0PCo4srTse2dT
         brrGC2f2zkhdihQ9dcQeHlt7hf0XeUKqK0hpyoWJFvDVPp0gN7G0TW+FOeDO5or+MK2m
         Yzlg==
X-Forwarded-Encrypted: i=1; AL+hErHxNMn8OCeE40HSm1Y2+D+jb0gtvaAsLxhrTPXgwQqIIogW7A72FGiYzbpUwXAqxptu3BY4hmnAepjVFT9png==@lists.linux.dev
X-Gm-Message-State: APuU4Z8nScNSmEUtNeZ+tucDCuHb24T4oUbCDO8SvHA1N4w0lpWFCVGN
	EVbGnF+u5W9u3HdIlw7972eTvpWHU9pvYnb8avIfJV6ES/hR3705hGJgiPeQ0pU/J/idVNCpTos
	Rg7OE2iyF8Lmyv4CqtyqKwGrD06l0DSbjd3t2Fzs7DjmeVGNCEtydK40UFv0tU1mdkfKl
X-Gm-Gg: AZFdTZeVIJ/RLQON7xqoh8Rlj3WwuafoG9AhR610wseYalhxxlKS2m8qBGuX+VY8cTt
	xNlsWuLAD0EHsJlfVXecb//eqiIUsyASPusxY7CGwjbvPh1BayPqljxpAw49GxwOYCP4Ep8mc/m
	5LnMYh2Hxek0SCkcXHkzZDOwpADH1dh0zn2qr9FeCLdOyiSg9M5KNcRlGOtx9SeMQS8vQuNzOUX
	4EwZSX7QmdHfGrzt7gFkVXNSAl1Nst2x8+H6h6+sKtvFAl1VmJzX9PbOK9tQDVnYsk0Wy95LSei
	jzj+LeG+ZmYIZDT2usYRp+WnJ/B3wDN+XgUI2lCedVwDMu0kMF2l9E8Cop1SCUNkr/XeZbSxZA0
	SyEEmwgEAVQ4gg/Pcx0XMZ9Xw+wvpPW1n6+ws0zvQdT23mpmPhAvHf6do/9RIszCOM7euRZ37Ym
	WD
X-Received: by 2002:a05:6000:47d4:b0:4aa:5396:a7bc with SMTP id ffacd0b85a97d-4abb4b849fbmr9281751f8f.40.1795270991197;
        Sat, 21 Nov 2026 06:23:11 -0800 (PST)
X-Received: by 2002:a05:6000:47d4:b0:4aa:5396:a7bc with SMTP id ffacd0b85a97d-4abb4b849fbmr9281710f8f.40.1795270990742;
        Sat, 21 Nov 2026 06:23:10 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm10354767f8f.18.2026.11.21.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 06:23:10 -0800 (PST)
Message-ID: <9419fa94de8acc8f1ae445004b77d20d0be3e98e.camel@redhat.com>
Subject: Re: [RFC PATCH v2 0/9] rv: Verify generic IRQ context transitions
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
 Dunlap <rdunlap@infradead.org>, Wen Yang <wen.yang@linux.dev>,
 linux-trace-kernel@vger.kernel.org, 	linux-rt-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Sat, 21 Nov 2026 15:23:08 +0100
In-Reply-To: <20261107171252.25090-1-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
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
X-Mimecast-MFC-PROC-ID: d5A8eszojPH60WOP2iMmNmhuKfpH87k5P8Euta0kD5A_1795270991
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-11-07 at 18:12 +0100, Karl Mehltretter wrote:
> Questions still open from v1:
>=20
> =C2=A0 1. Are dedicated scheduler tracepoints the right way to follow
> =C2=A0=C2=A0=C2=A0=C2=A0 preempt_schedule_irq() across task switches and =
migration?

So I'm not quite sure you care about running outside or inside the exceptio=
n
context tracking. If you don't, an fentry/fexit in BPF (or fprobe in the ke=
rnel,
not supported) could work for you.

That said, we do roughly the same in __schedule(), so I don't see anything =
wrong
with what you're doing, as long as Peter is fine with it.


Maybe, you could somehow reuse the __schedule() tracepoints and understand =
you
came from interrupt context, but that would obviously not match the
interrupt/preemption counts, although they are (now) guarded by a BUG so yo=
u
don't really need them.
The loop should work fairly well anyway.

The nrp model does something similar with the nested_preempt, flagging a
schedule entry after irq as an irq preemption. You may look into that, I do=
n't
exactly remember but it probably isn't really accurate and you might need
something else.

> =C2=A0 2. Is the KUnit-only hook for an empty ksoftirqd invocation
> =C2=A0=C2=A0=C2=A0=C2=A0 acceptable? Outside a KUnit run, its worker chec=
ks take a disabled
> =C2=A0=C2=A0=C2=A0=C2=A0 static-key path.

I mentioned it briefly in another email, but I don't think you should touch
softirq code at all. Just simulate events, don't cause them.
As a rule of thumb, if your RV unit test creeps into other subsystems, you'=
re
doing something wrong.

Another story is if you want to write softirq KUnit tests, but that's beyon=
d the
scope of this series and I'm not the one to answer it.

Thanks,
Gabriele

>=20
> Patches 1-5 add the tracepoints, monitors and documentation. Patches 6-9
> add KUnit coverage.
>=20
> The series is based on v7.4-rc1, which contains the v1 prerequisite and
> Wen Yang's reactor lockdep fix:
>=20
> =C2=A0 commit feb5c9a2447a ("softirq: Preserve interrupt context on retur=
n from
> interrupt")
> =C2=A0 commit 39ccedfd9e55 ("rv: Use LD_WAIT_SPIN as the reactor lockdep =
wait
> type")
>=20
> The series is independent of the early-hardirq series [2], which
> installs hardirq state before entry tracing. Both change
> kernel/softirq.c, so applying one on top of the other needs a small
> conflict resolution in __irq_exit_rcu().
>=20
> Changes since v1:
>=20
> =C2=A0 - Use bare DECLARE_TRACE() tracepoints instead of trace events
> =C2=A0=C2=A0=C2=A0 (Gabriele)
> =C2=A0 - Rename the irqentry container to irq (Gabriele)
> =C2=A0 - Add text schematics of both models to the documentation (Gabriel=
e)
> =C2=A0 - Document why irqstate and irqexit are separate automata
> =C2=A0 - Rebase onto v7.4-rc1
>=20
> Testing on v7.4-rc1 with Clang 23.1.5, GCC 14.2 (x86) and GCC 16.2
> (cross), and QEMU 10.0 TCG, with lockdep and the locking selftests:
>=20
> =C2=A0 - Each patch builds with W=3D1 on x86_64 without new warnings.
> =C2=A0=C2=A0=C2=A0 RV_MONITORS_KUNIT_TEST=3Dm builds on x86_64 and arm64.=
 kernel-doc
> =C2=A0=C2=A0=C2=A0 reports no warnings for the changed headers.
> =C2=A0 - The rv_mon KUnit suite and the reactor suites passed without
> =C2=A0=C2=A0=C2=A0 failures on:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86_64=C2=A0=C2=A0 PREEMPT SMP4 and UP, PR=
EEMPT with nohz_full=3D1-3 and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 threadirqs, PREEMPT_RT SMP4, PREEMPT_RT SMP8 with
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 nohz_full=3D1-3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64=C2=A0=C2=A0=C2=A0 PREEMPT, PREEMPT w=
ith nohz_full=3D1-3 and threadirqs,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 PREEMPT_RT, PREEMPT_RT SMP8 with nohz_full=3D1-3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv64=C2=A0 PREEMPT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARMv7=C2=A0=C2=A0=C2=A0 UP
>=20
> =C2=A0=C2=A0=C2=A0 Each configuration ran 13 to 21 of the 29 rv_mon cases=
. The others
> =C2=A0=C2=A0=C2=A0 are skipped because they need a different configuratio=
n.
> =C2=A0 - RV=3Dn kernels boot on x86_64 and arm64.
> =C2=A0 - On top of the early-hardirq series, the same suites passed on
> =C2=A0=C2=A0=C2=A0 x86_64 (PREEMPT, PREEMPT_RT), arm64 (PREEMPT, PREEMPT_=
RT) and
> =C2=A0=C2=A0=C2=A0 riscv64.
>=20
> An LLM assisted with the patches and the testing.
>=20
> v1: https://lore.kernel.org/all/20261022050712.75035-1-kmehltretter@gmail=
.com/
>=20
> [1]
> https://lore.kernel.org/all/FACA54EC-F846-4051-9ADD-DB46E7665FAD@redhat.c=
om/
> [2] https://lore.kernel.org/all/20261028033127.82193-1-kmehltretter@gmail=
.com/
>=20
> Karl Mehltretter (9):
> =C2=A0 tracing/irq: Add generic IRQ context boundary tracepoints
> =C2=A0 tracing/sched: Add IRQ preemption lifecycle tracepoints
> =C2=A0 rv: Add a monitor for generic IRQ context transitions
> =C2=A0 rv: Add a monitor for IRQ-exit scheduling ownership
> =C2=A0 docs/rv: Document the IRQ monitors
> =C2=A0 rv: Add KUnit coverage for IRQ context transitions
> =C2=A0 rv: Add KUnit coverage for IRQ-exit scheduling
> =C2=A0 rv: Test empty PREEMPT_RT softirq worker intervals
> =C2=A0 rv: Test IRQ-exit softirq provenance and handoff
>=20
> =C2=A0Documentation/trace/rv/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0Documentation/trace/rv/monitor_irq.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 475 ++++
> =C2=A0include/linux/interrupt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 8 +
> =C2=A0include/rv/kunit.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 34 +-
> =C2=A0include/trace/events/irq.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 56 +
> =C2=A0include/trace/events/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 26 +
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
> =C2=A0kernel/softirq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 324 ++-
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +-
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +
> =C2=A0kernel/trace/rv/monitors/irq/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 13 +
> =C2=A0kernel/trace/rv/monitors/irq/irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 35 +
> =C2=A0kernel/trace/rv/monitors/irq/irq.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +
> =C2=A0kernel/trace/rv/monitors/irqexit/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 14 +
> =C2=A0kernel/trace/rv/monitors/irqexit/irqexit.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 172 ++
> =C2=A0kernel/trace/rv/monitors/irqexit/irqexit.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 85 +
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_kunit.c |=C2=A0 540 ++++
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_kunit.h |=C2=A0=C2=A0 21 +
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_trace.h |=C2=A0=C2=A0 19 +
> =C2=A0kernel/trace/rv/monitors/irqstate/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 14 +
> =C2=A0kernel/trace/rv/monitors/irqstate/irqstate.c=C2=A0 |=C2=A0 289 ++
> =C2=A0kernel/trace/rv/monitors/irqstate/irqstate.h=C2=A0 |=C2=A0 139 +
> =C2=A0.../rv/monitors/irqstate/irqstate_kunit.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 2339 +++++++++++++++++
> =C2=A0.../rv/monitors/irqstate/irqstate_kunit.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 25 +
> =C2=A0.../rv/monitors/irqstate/irqstate_trace.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 15 +
> =C2=A0kernel/trace/rv/rv_monitors_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 30 +
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 2 +
> =C2=A0tools/verification/models/irq/irqexit.dot=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 21 +
> =C2=A0tools/verification/models/irq/irqstate.dot=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 32 +
> =C2=A029 files changed, 4737 insertions(+), 15 deletions(-)
> =C2=A0create mode 100644 Documentation/trace/rv/monitor_irq.rst
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irq/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irq/irq.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irq/irq.h
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
> =C2=A0create mode 100644 tools/verification/models/irq/irqexit.dot
> =C2=A0create mode 100644 tools/verification/models/irq/irqstate.dot
>=20
>=20
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

