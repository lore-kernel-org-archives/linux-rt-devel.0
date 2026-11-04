Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757580;
	b=XhUWvjPI/MUQLUZuu8potr9dpamOqmfk8K0pL4XXnS6sjfugLc5Wrw1noSutBuX7nL0/
	 1QLozu50LRkpHRnVgynajYVKv9ImbA6Arx9jHvXH5w0P19/XZpMEgBTNj2qnTKkMmhX+Q
	 0rHrtBRNlzkjm/UiaISpEaBXzNG+Ha7hUi1eEOEtbQvUW7xZcl/NbtdErzP9FuVh28gKN
	 d1HkYXzo7cf3oyCHi+8XM1ghB86COQwkt0h08m9kRsuIZzkq+scsf1O0+8WX977hstd4i
	 tcKXZBY1uNlfhp13MiJGEfcb+DxaiBiV1OWn5zUViBjKLGQa3zMhzHMP4MmGItQpd+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757580;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Mime-Version:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=6g32PsKdkRLeTZ4LSwatErJCU5OnLPMMaSmgKWyS70g=;
	b=f5urIxSBInjk168YL4qRiUwRbRIXN7tdgOAxYpa6tiz58DyghZw6wwO5dnfZRC19a2Ut
	 quiJF8CHYmBCeinoVvsHzPnNnpR4K2IVLc8huXyE73VUJFvXnQb8meeWnNofVS8s+AQR9
	 nAI+kpz70Lms7LcaLTGe/x5tCu1pa/muj0ZMyScLN3huZpcavv5r24xiq3FSjp9rs/nDa
	 vsUSlVpgXAozB9DkwZfNr9Vu+F6/eFIpUi0WHgrYJBkPQGbhI0KrLusevz11AOoVE0kMO
	 xatPWH+LSXQhWgc/WqMH3mCg+LNd8CVB3Xr9s3dux3u/qbP7faO3K2B4deTbi+bYSuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lJOD7Ac4;
	arc=none smtp.remote-ip=91.218.175.194
Received: from mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1941606A31B
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 01:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1941606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lJOD7Ac4
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=6g32PsKdkRLeTZ4LSwatErJCU5OnLPMMaSmgKWyS70g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793757578; v=1; x=1794362378;
 b=lJOD7Ac4EGChVBpEu2cuuOf9e69qfAQ8xuHZjosHZDJlHOaD/546BerZoXVDF9OGAEZfZog4
 3KX6Ha+Cb2FxhwVI/piA9jDBfg3eszdj3qeVEj2YcAYQzzW7QLj2vgEIwVhgXIGVEgPrKTX+EAb
 nzYIfcvzXfGM6x7kez45dQSM=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id b85e7a3be548a814;
	Wed, 04 Nov 2026 01:59:37 +0000
X-Mizu-Trace-ID: b85e7a3be548a814
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
 boundary=56d7954e1823c29e3c2394602d9e592c14ea976c474f7a6637894a247bbc;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 04 Nov 2026 09:59:30 +0800
Message-Id: <DMM1ZNXOFC8Q.HXUWNWMD6LKE@linux.dev>
Cc: "Thomas Gleixner" <tglx@kernel.org>, "Radu Rendec" <radu@rendec.net>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, "Anup Patel"
 <apatel@ventanamicro.com>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] irqchip/riscv-imsic: Synchronize remote state with IRQ
 work
From: "Troy Mitchell" <troy.mitchell@linux.dev>
To: "Anup Patel" <anup@brainfault.org>, "Troy Mitchell"
 <troy.mitchell@linux.dev>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261103-imsic-remote-sync-irqwork-v1-1-8b5c951fc62a@linux.dev>
 <CAAhSdy26R41W6OsTpEjMCf6iQXrtn4WrzziuGg+S9pHOHtM--A@mail.gmail.com>
In-Reply-To: <CAAhSdy26R41W6OsTpEjMCf6iQXrtn4WrzziuGg+S9pHOHtM--A@mail.gmail.com>

--56d7954e1823c29e3c2394602d9e592c14ea976c474f7a6637894a247bbc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Nov 3, 2026 at 11:52 PM +08, Anup Patel wrote:
> On Tue, Nov 3, 2026 at 1:34=E2=80=AFPM Troy Mitchell <troy.mitchell@linux=
.dev> wrote:
>>
>> Remote IMSIC state updates are deferred to a timer on the target CPU.
>> If that CPU has stopped its local clockevent and is waiting for a
>> broadcast interrupt, enabling the broadcast IRQ can depend on delivery
>> of that same interrupt. This can stall timer delivery when the broadcast
>> IRQ is unmasked or moved to another CPU, including during CPU hotplug.
>>
>> Queue hard IRQ work to synchronize remote state independently of timer
>> delivery. Keep synchronous updates on the local CPU and the timer retry
>> for an unfinished vector move. Hard IRQ work also avoids depending on a
>> schedulable worker when PREEMPT_RT is enabled.
>
> Using timer retry for local CPU and IRQ work queue for remote CPUs looks
> strange. Why not use IRQ work queue even for local CPU ??
On the local CPU the sync runs synchronously, so there is nothing to
queue. The timer only retries an unfinished move, and by then the new
vector is already enabled, so it cannot stall on the broadcast IRQ.
Requeueing IRQ work from its own handler would just keep self-IPIing
until the old CPU catches up.

I'll add more comments and modify the commit body.

--=20
Troy Mitchell


--56d7954e1823c29e3c2394602d9e592c14ea976c474f7a6637894a247bbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCauqRgiEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC/RwQEAqJNvz80iRJkb
Z8Yz+vUyyAzhmceho0CtFhLRHQoE9vYBAOdmpp4WhNu9TMxAAt7VNSpFhr/ABrrn
evvi3vN5+msG
=Sb+D
-----END PGP SIGNATURE-----

--56d7954e1823c29e3c2394602d9e592c14ea976c474f7a6637894a247bbc--
