Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295633;
	b=amT2w6xPIUewG0K9JE1b4N9xdJqWZLOB/oqLKrpcq/UV+Z28GPpdYlvdy6xz7BYXLEqL
	 g3/pA2APm0y5xm8IkkpWxX5/yXZYyjV3pvRPpdRZo9xYUibxSv4GE4C/cTTp5QfTyzGeu
	 b2AiFaVpthc/Yv67fr0zHRzwmfYFCdzywGsd07l6A6gXCLqikgRBxd3NO2LcJDoF5Iogx
	 bCQvLtTxavtrHm67GwAk5cVJL1ffUVWGw2SrduXGlm+2mDaQCaJqaXPEqGK7p+DQ4wg8h
	 pon7ktY+bDTB6OLsgyU343oGwZLDk98b8pv8/gUd4tJ3Z2mWmGLElTPDrlQPKcl+jtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295633;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Mime-Version:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:Content-Transfer-Encoding:In-Reply-To:
	 References;
	bh=Jlx3khHmYf11Kc5Nu+VRaLVD/aQQv854yonbfkQB8wE=;
	b=NmkbXnHLroWse9kS98V17U4jaDcCvb94aeF3AZ+ow3vd21nVhsqnKw0dQLQVjakZV47X
	 iH5c0TurtE2FI0Q16Zi5M27VDhx7QUP7muB6a9GPuFap40OKKH5DP/lAOkBQK0JragQgB
	 KKHJH+76f78mAy0i/0JTEgaEq5/L72O1VZwjcdwUJoY3elSpP8i+MzhMW9zUesUZlLgYJ
	 1zheyDZA0qdJGd2eJ21xJiiA1GewqTEuo+XzRCvqMuY0vBKbSgjv+uHFIWR3VSviTyt4j
	 kRde5bQ9uDZH8B0Vbj1HLqGUFKqVodLE13+X45ZKbgRcOkgrVBFHdOUjYyvj0M2SsEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="k/0Z+8zO";
	arc=none smtp.remote-ip=91.218.175.124
Received: from mta0.migadu.com (out-124.mta0.migadu.com [91.218.175.124])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00189606A321
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 07:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00189606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k/0Z+8zO
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Jlx3khHmYf11Kc5Nu+VRaLVD/aQQv854yonbfkQB8wE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794295631; v=1; x=1794900431;
 b=k/0Z+8zOfgOMl6NA4BEOQ0qeKBitu62vgo/5NeIS+mb/A6RUrUwOXZPmtW9s+5rx3nfrmDwn
 djwe7x7oGcf5Wha9+pT2n+LPB2suxhSq1LcWHzUgxaprv1fE5tNqIIIemoTvB3BxKgDTfuGPbGV
 1EEnxS0xRYXPtPrabdMqv9Jw=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 354d447854a25624;
	Tue, 10 Nov 2026 07:27:10 +0000
X-Mizu-Trace-ID: 354d447854a25624
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ce428c8fa94fa432a281a32dcc895308571207f4b952ac431a0f37b483fb;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 10 Nov 2026 07:27:07 +0000
Message-Id: <DMRCPRZVNPGZ.3HTEULWLQ76YL@linux.dev>
To: "Anup Patel" <anup@brainfault.org>
Cc: "Troy Mitchell" <troy.mitchell@linux.dev>, "Thomas Gleixner"
 <tglx@kernel.org>, "Radu Rendec" <radu@rendec.net>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Anup Patel"
 <apatel@ventanamicro.com>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] irqchip/riscv-imsic: Synchronize remote state with IRQ
 work
From: "Troy Mitchell" <troy.mitchell@linux.dev>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DMM1ZNXOFC8Q.HXUWNWMD6LKE@linux.dev>
References: <20261103-imsic-remote-sync-irqwork-v1-1-8b5c951fc62a@linux.dev>
 <CAAhSdy26R41W6OsTpEjMCf6iQXrtn4WrzziuGg+S9pHOHtM--A@mail.gmail.com>
 <DMM1ZNXOFC8Q.HXUWNWMD6LKE@linux.dev>

--ce428c8fa94fa432a281a32dcc895308571207f4b952ac431a0f37b483fb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Nov 4, 2026 at 9:59 AM +08, Troy Mitchell wrote:
> On Tue Nov 3, 2026 at 11:52 PM +08, Anup Patel wrote:
> > On Tue, Nov 3, 2026 at 1:34 PM Troy Mitchell <troy.mitchell@linux.dev> =
wrote:
> > >
> > > Remote IMSIC state updates are deferred to a timer on the target CPU.
> > > If that CPU has stopped its local clockevent and is waiting for a
> > > broadcast interrupt, enabling the broadcast IRQ can depend on deliver=
y
> > > of that same interrupt. This can stall timer delivery when the broadc=
ast
> > > IRQ is unmasked or moved to another CPU, including during CPU hotplug=
.
> > >
> > > Queue hard IRQ work to synchronize remote state independently of time=
r
> > > delivery. Keep synchronous updates on the local CPU and the timer ret=
ry
> > > for an unfinished vector move. Hard IRQ work also avoids depending on=
 a
> > > schedulable worker when PREEMPT_RT is enabled.
> >
> > Using timer retry for local CPU and IRQ work queue for remote CPUs look=
s
> > strange. Why not use IRQ work queue even for local CPU ??
> On the local CPU the sync runs synchronously, so there is nothing to
> queue. The timer only retries an unfinished move, and by then the new
> vector is already enabled, so it cannot stall on the broadcast IRQ.
> Requeueing IRQ work from its own handler would just keep self-IPIing
> until the old CPU catches up.
>
> I'll add more comments and modify the commit body.
That was not the whole story. The retry cannot stall, but it can be
late. The local CPU is usually the one entering idle and taking the
broadcast IRQ, and the timer it arms on itself there is not programmed
because its tick is already stopped. Nothing tells it when the old CPU
is done, so the move only completes on its next interrupt. On K3 with
deep idle I see move windows of up to 0.5s.

So you are right that the timer should go, just not by requeueing on
the local CPU. In v2 the old CPU will queue the IRQ work on the new CPU
once it has released the old vector, and the retry timer will be
removed. Move windows drop to about 100us. This will be a separate
patch on top of this one.

--=20
Troy Mitchell

--ce428c8fa94fa432a281a32dcc895308571207f4b952ac431a0f37b483fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iI4EABYKADYWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavLHSxgcdHJveS5taXRj
aGVsbEBsaW51eC5kZXYACgkQmAnvgPkzNC/vOAD/WlHPe+g+zvOYYsakVCaeWRP6
QCEqDrKkV4pXEccSnO0BAI1kWUqD4O/X7XbtTiBVBJQEtacNA95laJHyT3AOg2EA
=Q5bv
-----END PGP SIGNATURE-----

--ce428c8fa94fa432a281a32dcc895308571207f4b952ac431a0f37b483fb--
