Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794296399;
	b=bZrP4Qy7Sj4F3xWfLRMKRQhSX2islvHg5z7tKubq56lowMmEVVGXaT3q1DnHQet1I1WM
	 KRDWoXEDlvwUPrZxGAx/6j9GYDTiRqXlhnJhmhdkIL9+EVoOsuMpDK05VqVJv7e4l8Wto
	 ly3rFvkjtCsIw+XUgArm/riWLblcKOg348grhlAhn+reIsjm+3B3aaksuiT5UkP8xdx96
	 GDFSJFFs+Mw6eb+QyTC4dDrtj4r9lTepi8w88rbUdA0Fcwwuboyl+tfa1uMaRZNJsVMt2
	 UxsENN5fblLMu/e/HdRMqtJrbJhIGH/5R6v8XGcPaEptcRQMpKYY6wRI/PQTrkmVskQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ERnrn3wThP1DJNLbDKWT7d2OEC6GO11+OEarircH9n0=;
	b=IgcRtYY+T1mQkLUxIT+y9K9sXeJ+LcRAWla8ejG5y1bkezJNpM2KE44ydVGKydcOG8Ya
	 WRfGx+17t0fzL5qVjIEjgpf+gLH9nkfGZx1TIZehJsBvbVpLFFlblDjs2jZ95LIjrx0rM
	 fx5Iiyf5CgrTRsEd+vIm+RfDPlyO1M7qNFIuThlMrZWjtBzLyfkKys6kP7AR2YxyUE2QS
	 MI67NT8KfGQHAbBezQCEeWqZCSyjt2LlfNCr6wlMu8sfQGpU+qCVjbJIPmdTG6LkGd8RV
	 RpIANcAFYpn7Ps0yfArfaeoj25Xbz/bgBniCydq3Vry0nBsgKrZMaviaVi61S+J57Jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b="QON3/W5O";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E6606A31C
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 07:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A7E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=QON3/W5O
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-49318428d98so856514f8f.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Nov 2026 23:39:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794296397; cv=none;
        d=google.com; s=arc-20260327;
        b=cMOQz+ZqPktnXyEeF19i4UjP0R4ZwD5bz1NHRNT1LbSIhpnKK/UsXwdbovzW/c/1Q0
         dDQkhRm1vofjbGLuQL6ru31gv1jHUzzn4xN4KPQ1HGq9jIF2g4D2sLBXqFM8VAJXyaME
         Wn0BUrl3g6YfhP7x/KMm+K5pt3M1q4HrkW8l9q3NojtoQHFav8O0tCNW9wlYsFQcmmMM
         M4rkTe+3pXqNAYCPZ/7U4u2PSaQblipt9/ChVOCjsZHszTM+xyq9dsCj4zGVeK8k7HgB
         rVA4+HuKQDdK/bkrO33PFcisndXY+EhQYVy96by1oXNrb2D3He8sxX8jt/s8kO/QrFCO
         w+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ERnrn3wThP1DJNLbDKWT7d2OEC6GO11+OEarircH9n0=;
        fh=If1+n8Wc2kZlP+8LljdLKQ52hr7QtO86/Gacc3B6ISU=;
        b=LQD9RHTOelPzTlbBBl4A0KOsjCa+AgtlPDWKIoMaq5pOUv8LOFk489Jf+F0FwS3oG9
         WkAmrK4uhRgvuLtKqf3F9aj9fBtfBNE/wYVl7axPC4pqUEkyCXfJqILIQaN6jgOHe1um
         0rEOP1noemfSkO57rbNlFBwhu/Il1hEhtotv4f1zTtUBWa5vYoaI5SJr7s+RGuSfM4jB
         uToxVP2OjVxVkTApxWTtQjmdZb+Y/oeyF4whZmtEO5yTbmp+qUukm1aiXZIJtEAmcZ8A
         uCNale0dSlJraytBXFe4FnjSzdu9RTPYfiYKzKkPrtkp5t4PW5ppMue9w5p6fJin5KpV
         cxcQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794296397; x=1794901197; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ERnrn3wThP1DJNLbDKWT7d2OEC6GO11+OEarircH9n0=;
        b=QON3/W5OOZYNdLljCvBH0SIfjo5coTXc+3BfMp7SdB2njqSRx1El+kAnwR77wJP0Zh
         HStARy2PE+LoDvTnmDloBcalit2ewUk6aSepSklrHslhF5WyezrLtrUGwCTGIEt5OLm3
         I4yh20vXwxX1M7oA6p8RBTpem+qvsgbJAslfo7pLmmsjXAela7PbiKc9NMOpg0DbbXR7
         jXZE7p7lhrgMj98RlH50I8sl7ZAlZCdxa2dvJ99H9fXALd1ZBpbB3l/5mJif79fmtWqw
         pODaZWPQ3GmThgJsGg2TgiKUk3qBRgM2gUf2MHr1wm4KJGGB9lwd+3d3a5fUW/Enk1U/
         CQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296397; x=1794901197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ERnrn3wThP1DJNLbDKWT7d2OEC6GO11+OEarircH9n0=;
        b=tal4nVTGacgJ9TO4pTeOwEeEm5UguSHQIzgeZYqr6cTNXne5I7MaqlFuxpeaV72p6B
         WENk4zKG0cgHPvHWdw+NQS3pilBi1afOhrtZ5QEUx9ofACtbMZDYt/qKIfN5268DjlgH
         4cwULA0zar8+ZuWRc+gxQurdn4bvbcc3ChYNeQx6HjmZeQBlmYVRNzU/n2tFzBRzf89F
         1edYSqQ5V2h1j+GEHb9kClBKbFk8KVXdaoXIF6eOLAdC/W/NZaXoNMhzc+pmqmT01Jqd
         3dlfiDlr+Gel5G5MzcMKzCJuoP4hDQ0oDDY8Qo9x7MB8tYuS2uEdoeWyDA8XXWchp6Jx
         5QFg==
X-Forwarded-Encrypted: i=1; AL+hErGX5JSy3dBaLZ5vTbI7PLaxpGo4IvXwaO2cAEYxuEOqalskE3zT1uRCxPIG2iDOXHfg5gtNHwHRatBuFEtUgA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/8nYTZgctoGZmmT3XGmnzcmFt0bm/FYhmYwLq4hbnIABwoBKQo
	QANmVnkJCx0PgZwOgDatbTjgVM4YZ8o1LSc/UsEjSP5OvXcQ+x+4hU2QbU3hShrL8MLB42PSw1a
	I0g+39uXdNDSq8pgAqbaafwZqcLkRBJ9N67auXMJaUg==
X-Gm-Gg: AYBFou1dIj4q28/+dead4PDUrjllvkYiGitz9j0us4RnLYT9WRpKM9zEKYXAqqckQ3b
	ZvVAv2ziNLMPHTM1aqZckBKcIrUQQvQ8J8zl7+AF2Cr31mIiWOH2LUdUAGZ3Ko3XWjcOKl/DwQf
	sZBPLYhMbc9RQ5qcu4NkYa1WaRRorPTcNUmx9Ah6nkuA30eSQRvr/oj42r32BufVDlfjiXLnfhn
	LN6L0+PaYwU6lCxzvqowKr7RldPggK78eObRwr+FGDZvTXhLu728u5/LaHOqz/c9LX8q2MJtyrD
	91X6jl2SnoCzg6Uln0owVgtIBnyMgTLpnjzslAFfrnZ1slBed7mcQoYYturitdfndq7IcE1uQK7
	HmRxeNThLv37tHRMuBvw+DpSG/yNPIWK0nDYvNaN84mRpoYHPx4aw2S2oujCrg/cHtpkODqgSSR
	7otucvH5ULmQoIghCiqEf/BKbpSOGUgsyaZEvHLnASRUBRvmo6BayK0Tc=
X-Received: by 2002:a05:6000:3c5:b0:48e:e98:8b64 with SMTP id
 ffacd0b85a97d-4982e82c23fmr2760008f8f.19.1794296396722; Mon, 09 Nov 2026
 23:39:56 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103-imsic-remote-sync-irqwork-v1-1-8b5c951fc62a@linux.dev>
 <CAAhSdy26R41W6OsTpEjMCf6iQXrtn4WrzziuGg+S9pHOHtM--A@mail.gmail.com>
 <DMM1ZNXOFC8Q.HXUWNWMD6LKE@linux.dev> <DMRCPRZVNPGZ.3HTEULWLQ76YL@linux.dev>
In-Reply-To: <DMRCPRZVNPGZ.3HTEULWLQ76YL@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 10 Nov 2026 13:09:44 +0530
X-Gm-Features: AclHuK-Jx-abf7O_I5yc8hPnEgpzrmNOfkNJbf5mYeWeUvlFuYAELASCvt4ok7g
Message-ID: <CAAhSdy2B=THE=m0eLG=S3XiufV=j5amnnkH1b8ydDMOmHtuZZQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-imsic: Synchronize remote state with IRQ work
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 12:57=E2=80=AFPM Troy Mitchell <troy.mitchell@linux=
.dev> wrote:
>
> On Wed Nov 4, 2026 at 9:59 AM +08, Troy Mitchell wrote:
> > On Tue Nov 3, 2026 at 11:52 PM +08, Anup Patel wrote:
> > > On Tue, Nov 3, 2026 at 1:34 PM Troy Mitchell <troy.mitchell@linux.dev=
> wrote:
> > > >
> > > > Remote IMSIC state updates are deferred to a timer on the target CP=
U.
> > > > If that CPU has stopped its local clockevent and is waiting for a
> > > > broadcast interrupt, enabling the broadcast IRQ can depend on deliv=
ery
> > > > of that same interrupt. This can stall timer delivery when the broa=
dcast
> > > > IRQ is unmasked or moved to another CPU, including during CPU hotpl=
ug.
> > > >
> > > > Queue hard IRQ work to synchronize remote state independently of ti=
mer
> > > > delivery. Keep synchronous updates on the local CPU and the timer r=
etry
> > > > for an unfinished vector move. Hard IRQ work also avoids depending =
on a
> > > > schedulable worker when PREEMPT_RT is enabled.
> > >
> > > Using timer retry for local CPU and IRQ work queue for remote CPUs lo=
oks
> > > strange. Why not use IRQ work queue even for local CPU ??
> > On the local CPU the sync runs synchronously, so there is nothing to
> > queue. The timer only retries an unfinished move, and by then the new
> > vector is already enabled, so it cannot stall on the broadcast IRQ.
> > Requeueing IRQ work from its own handler would just keep self-IPIing
> > until the old CPU catches up.
> >
> > I'll add more comments and modify the commit body.
> That was not the whole story. The retry cannot stall, but it can be
> late. The local CPU is usually the one entering idle and taking the
> broadcast IRQ, and the timer it arms on itself there is not programmed
> because its tick is already stopped. Nothing tells it when the old CPU
> is done, so the move only completes on its next interrupt. On K3 with
> deep idle I see move windows of up to 0.5s.
>
> So you are right that the timer should go, just not by requeueing on
> the local CPU. In v2 the old CPU will queue the IRQ work on the new CPU
> once it has released the old vector, and the retry timer will be
> removed. Move windows drop to about 100us. This will be a separate
> patch on top of this one.
>

Sounds good.

Regards,
Anup
