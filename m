Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3D2F12DE
	for <linux-rt-devel@lists.linux.dev>; Mon, 27 Oct 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567656; cv=none; b=EvnJO35rh7esAzLa2xzzZ8jmNOvsiDy+NI5bYuCxHwKxjrobTJK5lHw0U0/14i97ha+fL+kaDxP8w79HGd33d+569NPihHRHKFJWb08ovDvFlDbRAKVaNEQhwcOKn1ZcbWkfA1G9fs8eXbybI277bg+WjcinUaEQoldqE3E49hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567656; c=relaxed/simple;
	bh=8+SPhn7qqMJrmXX2oM/ERKmut/L/wxL9NKjHEeV08B8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6KrANvlT9fpiYjweMdSvLYfPGg5+lF4n1yPquCCSG7L94/Dt5KuM14fMDlxziiL5zzT2dkoN+MKI9KI0KxgV9HNN2uxwLUzPDPktKBPv1bBblE7OcL9f+Qm2LrAp6XMSNIVdqckw/aXs8HRva47X7v8U2pujXRD1Yitrbqpk/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGqhksdw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGqhksdw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761567653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m8yw+KdoDk1+GlObHpWFGVZEPL4sfsRTgvMthBW335I=;
	b=YGqhksdwhiC4wvKzqTmK6M+zDtaj7MULdjCeB42++BYypeNNdmucbWYFe7MfZdaohvtrha
	4tE8x4tC6GndYc87FpClFprDT8k5C21jR2cbuYhCNkmm37sOnbDDrcF6r/rBnijmvaXz9s
	WGtGzEuJ7w+uQ1z15SDBi8j0lBQmR+M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-aEmwzzDNO6iapIhx4Z5oow-1; Mon, 27 Oct 2025 08:20:52 -0400
X-MC-Unique: aEmwzzDNO6iapIhx4Z5oow-1
X-Mimecast-MFC-AGG-ID: aEmwzzDNO6iapIhx4Z5oow_1761567651
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471168953bdso43157135e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 27 Oct 2025 05:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567651; x=1762172451;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8yw+KdoDk1+GlObHpWFGVZEPL4sfsRTgvMthBW335I=;
        b=pjx6ouV+txes8QPCKG72zW9VZoUa3//jDkvsBh2MmyingSlR1/SMG2TZ//lVGmgUmr
         pDi5xZYa6B+DgxApzQIM+8y/ijsAsndpQBu8vahIhRe24CDpvdD1pyUX0tXQ9XZpLIv1
         5sEvuzip5wAOb5lGWVyDdKvhMSaA64+2Qnd+GUw/VAHPZCuU5PZrAixhWNBvCHYXboY6
         B+WbPjZYY/xbK2C/MKAW89LcoKn8p8vy/vbsAMD+8cXwbQGMHSY5fJTywpB3ifWKGHUI
         MssVpyduPLo6PWxSZRU09iZ1gHNC7Ad0qFMFUxsiq+ekhr9hu42vMoI8xazeRfK/TpcY
         lnsw==
X-Forwarded-Encrypted: i=1; AJvYcCU93hY2jXFU3Qbx/rDZVVdWqeTgbnDruTSvZOX72BEqsXVekGTGeH6bnUpFObiBlWb/TIE/VyrvhRgDrw0K9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUNLJpArDmAIcxHwBmYiLmpobhXGliZ4u+oreuei9huyTcHgxm
	ZqggCxctj15rFqUDTS8hVW1wKsgGlmCJ5Ba+l+wysmp3Roj4hvEioK4dG94+wn3CchZB9yLE3P+
	k75/8A89u8ARpsXXlNvaXrZMQa5xVrJ+awHrpbqBz39IRCFWavvL3zsGsQvkfytL0v55p
X-Gm-Gg: ASbGncuSMhWcf2/5ynu/6JRJyL4td8LmUk4Rp0KofET45wtd7t9OqCgFVtL4iLB27Jd
	BNSdAFa0mwF5h56Mcmx/G3Qzc33SRO1EF63qu9K1ibrkAbOVf3m4bSLZyeKlwhsHoCClhjyNDzL
	A/XZg7ZP6DS3JY1CGtgQ8qytBa3rcwOmpgAMW5Zu85AmOVTzpukpIUsGywHkSBgHlWVXkyivjEv
	HKCHBYkdNeOK2OgdmqYddMpp3iiEdj9mLoazGN37IVsDcyHyjYs3GzjsziEPgNSj0/cnKF4ejqq
	LLQxXYjDY9XH9TRB0jX2yKclJvLCA+a0y42fpi+MMVS7O8jznFUejvh45iXuGxE2RR/sAV/B6rC
	Mq10O4TlzVrtdvAYB9RrMQScK
X-Received: by 2002:a05:600c:3b84:b0:477:c68:b4da with SMTP id 5b1f17b1804b1-4770c68b594mr44482325e9.20.1761567650876;
        Mon, 27 Oct 2025 05:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUHD5VEEMHXlx8Mtjq4Vh0L1doDEtzRU6V1VECOo/Fbuys+lVjtxXIKlXHDWL4p5T28mhLPg==
X-Received: by 2002:a05:600c:3b84:b0:477:c68:b4da with SMTP id 5b1f17b1804b1-4770c68b594mr44481995e9.20.1761567650452;
        Mon, 27 Oct 2025 05:20:50 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd02cd6dsm137827585e9.2.2025.10.27.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:20:50 -0700 (PDT)
Message-ID: <d23d133b52ef574d669f1656789b78d07c91c9f5.camel@redhat.com>
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via
 RV (Runtime Verification) monitor rtapp:sleep
From: Gabriele Monaco <gmonaco@redhat.com>
To: Yunseong Kim <ysk@kzalloc.com>, Nam Cao <nam.cao@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tomas Glozar	
 <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, Byungchul Park	
 <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev,  LKML <linux-kernel@vger.kernel.org>
Date: Mon, 27 Oct 2025 13:20:48 +0100
In-Reply-To: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LeSUOtsf4ohAD_UHCqTsYQZcHVPoB7L3N6t5sU38sT0_1761567651
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-10-27 at 15:54 +0900, Yunseong Kim wrote:
> Hi Nam,
>=20
> I've been very interested in RV (Runtime Verification) to proactively det=
ect
> "sleep in atomic" scenarios on PREEMPT_RT kernels. Specifically, I'm look=
ing
> for ways to find cases where sleeping spinlocks or memory allocations are=
 used
> within preemption-disabled or irq-disabled contexts. While searching for
> solutions, I discovered the RV subsystem.
>=20

Hi Yunseong,

I'm sure Nam can be more specific on this, but let me add my 2 cents here.

The sleep monitor doesn't really do what you want, its violations are real =
time
tasks (typically userspace tasks with RR/FIFO policies) sleeping in a way t=
hat
might incur latencies. For instance using non PI locks or imprecise sleep.

What you need here is to validate kernel code, RV was actually designed for
that, but there's currently no monitor that does what you want.

The closest thing I can think of is monitors like scpd and snep in the sche=
d
collection [1]. Those however won't catch what you need because they focus =
on
the preemption tracepoints and schedule, which works fine also in your scen=
ario.

We could add similar monitors to catch what you want though:

                     |
                     |
                     v
                   +-----------------+
                   |   cant_sleep    | <+
                   +-----------------+  |
                     |                  |
                     | preempt_enable   | preempt_disable
                     v                  |
    kmalloc                             |
    lock_acquire                        |
  +---------------      can_sleep       |
  |                                     |
  +-------------->                     -+

which would become slightly more complicated if considering irq enable/disa=
ble
too. This is a deterministic automaton representation (see [1] for examples=
),
you could use an LTL like sleep as well, I assume (needs a per-CPU monitor =
which
is not merged yet for LTL).

This is simplified but you can of course put conditions on what kind of
allocations and locks you're interested in.

Now this specific case would require lockdep for the definition of lock_acq=
uire
tracepoints. So I'm not sure how useful this monitor would be since lockdep=
 is
going to complain too. You could use contention tracepoints to catch exactl=
y
when sleep is going to occur and not /potential/ failures.

I only gave a quick thought on this, there may be better models/event fitti=
ng
your usecase, but I hope you get the idea.

[1] - https://docs.kernel.org/trace/rv/monitor_sched.html#monitor-scpd

> Here are my questions:
>=20
> 1. Does the rtapp:sleep monitor proactively detect scenarios that
> =C2=A0=C2=A0 could lead to sleeping in atomic context, perhaps before
> =C2=A0=C2=A0 CONFIG_DEBUG_ATOMIC_SLEEP (enabled) would trigger at the act=
ual point of
> =C2=A0=C2=A0 sleeping?

I guess I answered this already, but TL;DR no, you'd need a dedicated monit=
or.

> 2. Is there a way to enable this monitor (e.g., rtapp:sleep)
> =C2=A0=C2=A0 immediately as soon as the RV subsystem is loaded during boo=
t time?
> =C2=A0=C2=A0 (How to make this "default turn on"?)

Currently not, but you could probably use any sort of startup script to tur=
n it
on soon enough.

> 3. When a "violation detected" message occurs at runtime, is it
> =C2=A0=C2=A0 possible to get a call stack of the location that triggered =
the
> =C2=A0=C2=A0 violation? The panic reactor provides a full stack, but I'm
> =C2=A0=C2=A0 wondering if this is also possible with the printk reactor.

You can use ftrace and rely on error tracepoints instead of reactors. Each =
RV
violation triggers a tracepoint (e.g. error_sleep) and you can print a call
stack there. E.g.:

  echo stacktrace > /sys/kernel/tracing/events/rv/error_sleep/trigger

Here I use sleep as an example, but all monitors have their own error event=
s
(e.g. error_wwnr, error_snep, etc.).

Does this all look useful in your scenario?

Gabriele

>=20
> Here is some background on why I'm so interested in this topic:
>=20
> Recently, I was fuzzing the PREEMPT_RT kernel with syzkaller but ran into
> issues where fuzzing wouldn't proceed smoothly. It turned out to be a pro=
blem
> in the kcov USB API. This issue was fixed after I reported it, together
> with Sebastian=E2=80=99s patch.
>=20
> [PATCH] kcov, usb: Don't disable interrupts in kcov_remote_start_usb_soft=
irq()
> =C2=A0- https://lore.kernel.org/all/20250811082745.ycJqBXMs@linutronix.de=
/
>=20
> After this fix, syzkaller fuzzing ran well and was able to detect several
> runtime "sleep in atomic context" bugs:
>=20
> [PATCH] USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels
> =C2=A0-
> https://lore.kernel.org/all/bb192ae2-4eee-48ee-981f-3efdbbd0d8f0@rowland.=
harvard.edu/
>=20
> [BUG] usbip: vhci: Sleeping function called from invalid context in
> vhci_urb_enqueue on PREEMPT_RT
> =C2=A0-
> https://lore.kernel.org/all/c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.=
com/
>=20
> This led me to research ways to find these issues proactively at a
> static analysis level, and I created some regex and coccinelle scripts
> to detect them.
>=20
> [BUG] gfs2: sleeping lock in gfs2_quota_init() with preempt disabled
> on PREEMPT_RT
> =C2=A0- https://lore.kernel.org/all/20250812103808.3mIVpgs9@linutronix.de=
/t/#u
>=20
> [PATCH] md/raid5-ppl: Fix invalid context sleep in
> ppl_io_unit_finished() on PREEMPT_RT
> =C2=A0-
> https://lore.kernel.org/all/f2dbf110-e2a7-4101-b24c-0444f708fd4e@kernel.o=
rg/t/#u
>=20
> Tomas, the author of the rtlockscope project, also gave me some deep
> insights into this static analysis approach.
>=20
> Re: [WIP] coccinelle: rt: Add coccicheck on sleep in atomic context on
> PREEMPT_RT
> =C2=A0-
> https://lore.kernel.org/all/CAP4=3DnvTOE9W+6UtVZ5-5gAoYeEQE8g4cgG602FJDPe=
sNko-Bgw@mail.gmail.com/
>=20
>=20
> Thank you!
>=20
> Best regards,
> Yunseong Kim

