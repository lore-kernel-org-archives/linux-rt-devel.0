Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795153035;
	b=itPsXN5F2U3lgu/WqNql0u09S8jxSHOdGWQ/EswjuMnDoLcfkpohPty7+NIyysKWE6SK
	 1e/fyRAh+A5efyhDPC7QUbWrONzG6n37iiv2By8EHzBtQGfY6eHgoVxMRAXa1Vpwh+d15
	 wGmfwGA9Jv0D25cGrkU8ckh5sWgKbiJIWdHHHWyr9JarYNV5XSrGKiLbHmE/Nn4p7c508
	 SJYJbeECauHvx1N/sIYVaifRFViiH56rn5nQ3Cmx6RhbwK7LC8eUpmfxb/IQEHeFkmipr
	 NB4rYJbAryAKXmJBD/RvADYzaJtskC2Z2130xmymsedS+Hf8TINnsZVrW4pvvkicwZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795153035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=B/0atRX3itSILPoLTT2jiynyQu/IGk6Wpmy+FZVV2so=;
	b=tj+ss0YYHmGbLFf/YKwYTDNkeX/pfrN8O0JgC1JT6dGY4a+zIevV7OYgO1fq9GszGzXo
	 v4uqq8Rvo+tImfnY0XrULDlNSM6aZWRA79R/fmT7Ap8WE6etGQqUehrj7E92gL/0VOh/a
	 J/DKj7ENm1GWm7WL7A4403gjmYHEps9dc6vTQoDSbd/sBLxpVPlj1Mww7oElvfTIv5QnM
	 DX11RivfdEvB6KnmTvoAFqfr+UbnPqBELyDETKhLurYGwfaUCVpxlVDvadV7Wvb0SUw7V
	 Lyd5td1+19i4IASA5oU6GBCd/HkDjzsOj0BzolC+mLOPumr9ZAHKuB3fC9qrRvgz4+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ao6peS9q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367D606A326
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 05:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3367D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ao6peS9q
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55ade1de0b4so6492531cf.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 21:37:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795153034; cv=none;
        d=google.com; s=arc-20260327;
        b=ZMI/kc+qfXLrcmnOPpWP1XBtYiLX9ERA4vM/2wIRuc1LyTcCObjaVHVmj6fqYCPZwl
         rEjvwNoPuC1WD/Dm9Yu7kj9w6SCzTi58NJJTmVi6fXjVSCZ0LmVLzUWk1D9j+znx05uc
         hGxbW9/JLq3m6hesKWYEW7usTo7+UyLRMg/h41vVX3cYBMBnut8FVArxFX29GeQLI5ic
         WfiKTy3IxElZ2gXhwk8yemCzTJ/hfbcN+A/BmRn3X+sy/+MginpZxg00BlzRao/aJ3PK
         kZRrNeWoesNecQW1VOY8/gGK0JshyYOdFTdcv76w3xgM27TW0PyAW1j2Z5mh2RcRZfzR
         zbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B/0atRX3itSILPoLTT2jiynyQu/IGk6Wpmy+FZVV2so=;
        fh=IRRR7TE/EiMpdHwcQOBZs+enxVO5gQ+l8mN4GAHtpdw=;
        b=Sj6UwXrD6gkNXDZsb5xrIJkM4+E0m19xRnsuYhDXimau1LdS2eZZ/FL4ORe2YN00Oq
         sPgJkD8mTvotJjaOXinqIyJWTHi/lhaG/1eucp+8Z4UTXXVrTTV4iZ8nze+EQ8SfnPSi
         QGzGdOfRo4V/nY9miRppi/JGkTZaGSsA4I9XJ/dX9jt8NsRo0wLXh9KgqYSoe16+Ru/i
         9+kAlV9YcoxRUyHs53aL9yoTtBHWVF8V/3CrcBnOMnqqaXjWwv1XoNiJ9Lc4HXaV4UzC
         jwxEOLuP83O3PVIMrrQJH/IfPTyq4dydmqTz/H22spCF6LsvxyGBUPKv9VTmZDAe2WoX
         b71g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795153034; x=1795757834; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B/0atRX3itSILPoLTT2jiynyQu/IGk6Wpmy+FZVV2so=;
        b=ao6peS9qfMEHzwqzmb/MsFN/9oW/JXdrvp2finU/3+fa2nCsNNzlebRfLKS+NY9RRm
         sS6SPlLU7Yrlk+McQfxUBqUBmoyxmMbplSmHJNeBhM4a9xGn+DWvaSlC/G72l6wvHGMl
         lyF6VoBW5A2r8yunVqKN3iu2e3ZVuXh4X7erJjr96/JgcwzYV6yAEYx/Ikl2uzWUYMf3
         pbTSbskXmMuG5zKMi6NDjE8rmeHKd94A+9VahhMuHDyCRdJKvRIXK2OGOTbKJVWlHyqQ
         g/xJH1neZQXO4cjTqfDTUWfhLqIjx5wllO8zXd3nDe6acf638knZn5EIIvwG3Gsgzbhq
         O9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795153034; x=1795757834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/0atRX3itSILPoLTT2jiynyQu/IGk6Wpmy+FZVV2so=;
        b=YoMzuDvx9v/OTI4gY/HOUVVSX9i57qNZzj2QF/WWSSQOkg1wmnEGv1LB1+EtvEmdfE
         engQVZoRfDbV+uhEis7HDrmsBbiMa0ceA9eqDEQqI3IifeqBIoOAlkPmxQgrPt5U0oNA
         hzrm75KEdxTkf2oWIw1TpJCRHWQV+NbvuUFPmZYdSLIXw/Fww5aJ8uXrtzbKst7WVJHn
         CtiTiTVDogeavNDix/vlBRMJ8moBr4iaPK0Vq1gZCGG+Ql6fJZc9WeKTg5zWYSmDxr9E
         +Z2jmaOrkh15j+Id29GIA/K2inl0eeoyea3YsPqzN2o1BcaRdL/GLAwQDHjauO7Kfx2O
         +ptA==
X-Forwarded-Encrypted: i=1; AL+hErHEnNf9ucEEJH7tcQsSF3JpfO5ZU0t0+TYiEFlJRWg7l4pgEuM37cNl7Exdli3lDt8LWHMfS9FpVZeFLmAZYw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8JkS6atqzn6pYLH296shHe1Fsde4k2FTOLzOpzSVP1KHD8sU7X
	mbV4gz2KUBYVBll/yPRPxPe1ddUU9R9KjcJ6wR+w4mlTKn4mOe1oWxJ/OxBmyKi65h4E6/dm0vU
	ShX8UyU7mzntaafQC1dnnUS9snLNJNPQ=
X-Gm-Gg: AYBFou2KR64yQ6FiAkjgttb4TmSskNRlLWN8foimN1XMoWCe65OzVKtt942V7WFOac2
	ZoiCpDdhW4OW0D6u24ebSqA/jw+FvNQICiQuwM0LSbvl19GcPnBtZFW/SUKBfx6YVLm/0JvALxx
	v2byeaw9qXvkltOJrhiLAwFXuDY5kOP9xzm3ONaM9PCysXLpytYGCmfOgY42WO59JWbslBuuvRP
	BAVmeK/aB0Be2ZCsOqhvQ7fQsoLBTO14aeSSZCX9TK/PwNOSgF4Ov0PPjtusDqSm/yBkO8pFVj6
	PjAIdNYlaCABHUDpSFIbG30EVvQnqoE9ouiudHqxVshRBr7Nc9uMSGeLUGow+qOQo/wEHy1P6OT
	wjzzrjc9jlOR7uhMD/wIOiEinuwtRbq1aQ3OMRb8=
X-Received: by 2002:a05:622a:228b:b0:55d:2caf:ae7c with SMTP id
 d75a77b69052e-55d76a6e947mr36676041cf.19.1795153033968; Thu, 19 Nov 2026
 21:37:13 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261118081625.2399247-1-a0282524688@gmail.com>
 <20261118081625.2399247-6-a0282524688@gmail.com> <20261119101233.Z-LmZvya@linutronix.de>
In-Reply-To: <20261119101233.Z-LmZvya@linutronix.de>
From: Ming Yu <a0282524688@gmail.com>
Date: Fri, 20 Nov 2026 13:37:02 +0800
X-Gm-Features: Aa3M54rJzQMDbjIWqoH0okOv_GH6h7gkNtMRDZ7Tenmh0mHV2sFIdcgXND8rGn4
Message-ID: <CAOoeyxXMPyG+PWiW5X5NHiH5WMaktCDPjH5-069MwjD-TC=amw@mail.gmail.com>
Subject: Re: [PATCH v10 05/13] mfd: nct6694: Drop the unused IRQ enable mask
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: lee@kernel.org, Ming Yu <tmyu0@nuvoton.com>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	mfd@lists.linux.dev, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Sebastian,

Thank you for the review.

Sebastian Andrzej Siewior <bigeasy@linutronix.de> =E6=96=BC 2026=E5=B9=B411=
=E6=9C=8819=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:12=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On 2026-11-18 16:16:16 [+0800], a0282524688@gmail.com wrote:
> > From: Ming Yu <a0282524688@gmail.com>
> >
> > The .irq_enable and .irq_disable callbacks only update the irq_enable
> > bitmask under irq_lock, which is a spinlock_t. Nothing ever reads that
> > bitmask, so the callbacks do not mask anything. They also take irq_lock
> > while the IRQ core holds desc->lock, a raw spinlock. On PREEMPT_RT this
> > is an invalid wait context.
> >
> > Remove both callbacks, along with irq_enable and irq_lock, and keep
> > IRQCHIP_SKIP_SET_WAKE. Without .irq_disable, the IRQ core falls back to
> > lazy disable, and handle_simple_irq() keeps a disabled interrupt pendin=
g
> > instead of calling its handler. The behaviour is therefore unchanged.
> >
> > Fixes: 51dad33ede63 ("mfd: Add core driver for Nuvoton NCT6694")
> > Signed-off-by: Ming Yu <a0282524688@gmail.com>
>
> This sort of makes sense. But how does this work? If the interrupt keeps
> coming the irq-core will just suppress it?

Yes, that is my understanding. The NCT6694 does not provide an interrupt
mask that the host can program. The firmware reports a 32-bit status
word, through the interrupt URB on USB and through shared memory on HIF,
and the transport handles every report and dispatches each set bit.

While a child interrupt is disabled, handle_simple_irq() only marks it
pending and does not call the handler. When the interrupt is enabled
again, check_irq_resend() replays it. The parent should not be flooded:
on USB it is the URB completion, and on HIF the handler clears the
status on every interrupt.

This is also how the driver behaved before this patch, because the
callbacks only updated a bitmask that was never read.

> If that is your whole business why not use dummy_irq_chip?

Thank you for the suggestion. I am looking into it now. As far as I can
see, dummy_irq_chip only provides no-op callbacks and also sets
IRQCHIP_SKIP_SET_WAKE, so the behaviour should stay the same. It would
also let me drop the irq_set_chip_data() calls, since nothing reads the
chip data after this change. The only visible difference I found is the
chip name shown in /proc/interrupts.

If you agree, I would like to switch to dummy_irq_chip in v11. Since
this changes the patch, I will not keep your Reviewed-by unless you are
fine with it.

Please let me know if I missed anything.

Best regards,
Ming
