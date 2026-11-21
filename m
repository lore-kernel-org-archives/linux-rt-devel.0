Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795269681;
	b=mpIgFg5r2IVzZCwTNk0SJAP0pdtEvJxDqbYFUMCQMlFg9uRhNJ5d0R8bNZLayl2KWgUt
	 hsS6u0lBnu3+rDRtmU+9DfP7WsBRkYXYbJLUncDGr3rZEPgzp4oA8/IJXYbXj8VjlUis0
	 54Qzok/PDtJyN6bDDPywXvJh+RkJ7dvJuXmlFqz5Qhj0B7ld6LWZ9D6SX0/K6TU0kLGEw
	 Av7OPme1vadfqoWdAxT6dNAYMTfysVoRWAmV1/lXjmgrA+ePii9UHxnQ4983c7l6mjf6D
	 2eZOe95dGZux2ZArCysle1vEePm7qFdv1gJ++kp+rTA9yZwZgYyCtX7LpZXUIAmIsRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795269681;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=e2mOK1MMQLYi3VECCKGxNvMEni9pzQtygVngFQX5eIw=;
	b=FyjLFhY5D9itaGUTCSdUXACk6w1Xyni+UpFuTOnt8IE9YXgE/xI/Q3GE6K8jmjPYOGrO
	 tXUYxT9UhUQEwjoYWOGeDy3+muT1TvjPz/5OpJt4UbNr3hvPkLOeGkRqQSttaYlX/qFms
	 M05yGMnN6S7+bGxk+chXcMZAnp2xHXlLMtZdYMXvphnlcoBtaSoWGeJQJOvaK+uggxPo9
	 F7q8GouWlzF245Lx8hUK30PZhItJCWzSE2j7Gg52YgkHp6VPvIC1jFDNNg4MNRnjRlWOM
	 7/oWUhK6w/giHrKd5nqkd15i+g9qbCePS1mArwOXA6X464TYfvCtF2xz77pTICh4fmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SD6TGIMK;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491A606A330
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 14:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3491A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SD6TGIMK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795269680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e2mOK1MMQLYi3VECCKGxNvMEni9pzQtygVngFQX5eIw=;
	b=SD6TGIMKjQmZ/EZr+Ps5ebmHWtCZDGwOvhVTVnCxKDPjT8yNvgYbhmkXDgoQ/7qmJ1PC4a
	4Di8zLIYCQdVnBQSzOZTS+HhS5oKjHjkt9BAtStznkNmCsl6NCQWGtyM6Hci6Tqg9ayj5k
	VhiNgx4bP5ZlfpWP9IkVa2CNGB/82Aw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-mBKcbzy5Ne69tbPS2Q0pSQ-1; Sat, 21 Nov 2026 14:01:17 +0000
X-MC-Unique: mBKcbzy5Ne69tbPS2Q0pSQ-1
X-Mimecast-MFC-AGG-ID: mBKcbzy5Ne69tbPS2Q0pSQ_1795269676
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb6bbc025aso14235535e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 06:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795269676; x=1795874476;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e2mOK1MMQLYi3VECCKGxNvMEni9pzQtygVngFQX5eIw=;
        b=T8H4mHvXT6ZJUeoPzdaBwvT9nc42X4cBs3yZ6koeOxQgFIEKlAVr/Wql6MpI2ApFin
         8XbDGNcdinZBZWiVsSLoymrspYGuKzhnohJrxMEmaf8pCaLg8M0yU94L/jqlXzxbMjSW
         23gqgJPEluWLCzo1+fUU8OG0hIb1wpFTavaIgIRzgoKiyAjgm+m2KFLBRl2hmEbFxbXy
         tOHz554N70B7nFL+oezXIq/+J8O/uzDLaLL7/QMi5wnAzbcGEAZlmWaNagHnTKaMDbvg
         iv0EdYkTiwo2HJMPVlsL+UEE/PbxorHOoE5EEO0o3iNwifcA+UHtsKDxoZTemhbxvJBJ
         sFnw==
X-Forwarded-Encrypted: i=1; AL+hErF1963AymOFtB4jwYppPRd2HZwtXzaiJ3Uc+xs18pLjV+Ou9UY+DBrnHqbHdb5bpkiHWC0D6V0fhgjBXTfyJg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8wnTIUc1L620/Bqkk8NMkDH2JnE69WaFr/mpp1BymZIBnqv+PK
	x/3UI8APpNG7mrB2nfpnotROOw5edkOBxWsRSlPiZD9lpiFF8qqXJ8ncgXuvoEuAuz60l4Cn3R7
	7ahPfDD+o913UjbL+cr/O2qkHMoFxMRiIP4OM8dkTU+yzMn4LcrpnQ4Zh4Gyh22Gpwk+7
X-Gm-Gg: AZFdTZdmRgoLZ2n+iCVKX/t1BvA5g5RQaBHOI5SoZCSl6oErVRvvxRE9/kVOafxA67t
	o45wnYPSme2eOScSV5VKOZ/uXSV6be6QP2uyIPEl2JIFRerzf22KBQezqOOrxKThSubDaO8VWnl
	VKn0lyzOdiq8kYOcRElOmduFveVhx6yylpblqMx5VsytN7Cu8lJPr5jZBGVmGE0wypDxmdvqVNF
	6S1OcfVMPd5Q21FQMW+5pVwLd5w9sWBE9m6MMMW9Lr09zIyG4jQQrJHfJlnkiXdPP0v5gFJk5fy
	quhoVgzJ83CHAgmp/Bwseee1ieEZf79qIkGrtvZytMT/YmR2jZdDi4NsCELXvetq/xcFRb6/siP
	u/Qc1xsRiKmLT5R8mO6biGSRgF7j3jXortsY05OgYSvChMA70TLQ+p80LLA18DkFy27bsbGQfJ0
	CD
X-Received: by 2002:a05:600c:64c9:b0:4bb:679a:86ee with SMTP id 5b1f17b1804b1-4bb88938dbemr145650475e9.29.1795269676281;
        Sat, 21 Nov 2026 06:01:16 -0800 (PST)
X-Received: by 2002:a05:600c:64c9:b0:4bb:679a:86ee with SMTP id 5b1f17b1804b1-4bb88938dbemr145649735e9.29.1795269675930;
        Sat, 21 Nov 2026 06:01:15 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm228383265e9.3.2026.11.21.06.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 06:01:15 -0800 (PST)
Message-ID: <e8b9a9afb9587ed1f41c0fafd486ec9be82928db.camel@redhat.com>
Subject: Re: [RFC PATCH v2 9/9] rv: Test IRQ-exit softirq provenance and
 handoff
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
Date: Sat, 21 Nov 2026 15:01:13 +0100
In-Reply-To: <20261107171252.25090-10-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
	 <20261107171252.25090-10-kmehltretter@gmail.com>
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
X-Mimecast-MFC-PROC-ID: tDXVGeQ_7otGgDChHdt2g0P_0l4a20pO84C7-0_obKQ_1795269676
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-11-07 at 18:12 +0100, Karl Mehltretter wrote:
> IRQ-exit softirq processing preserves hardirq state until it finishes. Te=
st
> the resulting hardirq-to-softirq-to-hardirq sequence, including a nested
> hardirq and monitor attachment during the transition.
>=20
> Boundary and tick-exit callbacks can themselves raise more softirq work.
> Raise work at softirq entry, softirq exit, the final hardirq boundary, an=
d
> a full-NOHZ tick_stop event. Verify that ordinary work reaches ksoftirqd,
> forced-thread timer work reaches ktimerd, and a timer-wakeup callback whi=
ch
> raises ordinary work gets the final ksoftirqd recheck.
>=20
> Track the synthetic owner and serving-softirq interval so unrelated neste=
d
> interrupts do not corrupt the expected sequence. Reject the handoff setup
> while bottom halves are blocked, attach observers before waiting for
> workers, and recheck the setup with interrupts disabled.
>=20
> On PREEMPT_RT, verify that worker events do not report hardirq provenance=
.
> Do not run the synthetic inline IRQ-exit cases there. IRQ exit defers
> softirqs to workers, and serving-softirq state is task-local rather than
> encoded solely in preempt_count().
>=20
> Snapshot reaction counts inside synthetic IRQ-disabled and hardirq
> intervals, then evaluate the KUnit expectations after restoring normal ta=
sk
> context.
>=20
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

I still couldn't read the KUnit tests, but from what I get quickly scanning
these, it's massive. A total of almost 3k lines of KUnit tests for 2 simple
models is probably a bit much.

Keep in mind you are testing your unit, which is an RV monitor, so you may =
want
to stress transitions, mess around with the environment as little as you ca=
n
(e.g. disable interrupts) and use mocks/stubs where you can. It isn't alway=
s
easy, but the fact you're touching softirq.c doesn't look right. Your
unit isn't the softirq machinery, you should interact with it as least as
possible.

If you really want to test the system as a whole, you do a selftest,
which stresses from userspace, more like an integration test than a unit
tests.

Thanks,
Gabriele

