Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A584B8DCE
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Jul 2026 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823440; cv=none; b=BBZytiSPJZerV1GKP+51FfvVBwHpfszIoWM7ygw4Ur/Gemox4D6Puz7HL2oKOz339swXXQUsgwIphbonRiXJfR+n4Agyo58wINptY3y6PR9LEZ6jCN6kp8r3axRjyJaRiTkR7VV64eB5GoJiY4MGWkBtKia4Q9j3LTuY2o0T5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823440; c=relaxed/simple;
	bh=HwpUB3HAl1qkE556UG3qifZi/H+4Sa8c5nNLKBlXqjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kCxS/MmRa7mAqkDdzlxZaCe6KoeKAQjiFOPU9JeS1DNM9zEMUOeizc+TzqBaVMzCvKtCnCl3lryiBg1ZsMlB+XsTmoaImb2abJFRyuaKg+4YNQzWggB1/8J53Umvn63e1yBeDTKPecTb+QCcy0CCaHDtsZkHJglwmHbDc8FUwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=pdUm72BL; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="pdUm72BL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784823423; x=1785428223; i=spasswolf@web.de;
	bh=HwpUB3HAl1qkE556UG3qifZi/H+4Sa8c5nNLKBlXqjs=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pdUm72BL0v0H1ZJ4R0MkJKdlQ9PqTCme2YDukPEjcGQNe+AYy6XPjmAjO11tqxXY
	 SvLZUNtK4VR0XpS6GToVkYmSEl4VQ1Xux85EG0v2rYh1OzUfo6J8N5VdnG5E7R17U
	 vvkHlLEX17mWy0PtFyWls0PeqauxNRGTU3w15VkIWz45ancnq9Oo+FFGw4Pcz+bk6
	 EXmaSacA9wZTL87jdFQEKsNRdxhKfo89ZV6iKRSUmofyH1pxdLXt71EBFCd/e8bgP
	 SnOjITa+yOeo7WHKhJNRtFv8MD9lz2rveg5Yl1rXZXwiAlX9rXSyJwRxeIkWZKHLo
	 0b+ml/4vYKvV5WS1lw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmymz-1xEG1w2lWx-00cu3Q; Thu, 23
 Jul 2026 18:17:03 +0200
Message-ID: <1a0800888c2fcd42f1fcd661d8f6f50580ac2fd4.camel@web.de>
Subject: Re: [Re] kernel panic during shutdown in v7.2-rc{3,4} and
 next-20260722 with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org, Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner	 <tglx@linutronix.de>,
 spasswolf@web.de
Date: Thu, 23 Jul 2026 18:17:02 +0200
In-Reply-To: <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
References: <20260723131001.11565-1-spasswolf@web.de>
		 <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S4Na7vcjSYXLHOHGNUEL1suXA/PMqXWPxM19axjxI5aEgjrdkal
 Jce7scxQK7i6v9l52cCT+XtOgdsebX5Mm221JssvL3AhxlowRh1FqACaUt+iQMUE1b95tBe
 7gACfFiNJNzsJcRwIEAYpBF36ZK9fns6NMiwRyV0I7k+lI+dElb6TPaPxDGwqZk74BgSdNC
 5P/hP5dgrEaaGKfM3QwvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fUK9O2BOY7o=;CcKrPZjyH4VplNjI0SmERGDvrCo
 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
 bw7/eFZqhzFYg3kGBfe9m

Am Donnerstag, dem 23.07.2026 um 15:23 +0200 schrieb Bert Karwatzki:
> Am Donnerstag, dem 23.07.2026 um 15:10 +0200 schrieb Bert Karwatzki:
> > I was able to gather the panic error message from a failed shutdown vi=
a netconsole,
> > this time the kernel used was v7.2-rc3:
> > #
> > Bert Karwatzki
>=20
> Unfortunatetly I can now reproduce these kernel panics in v7.1:
>=20
>=20
> So now I'm going to use memtest86+ on my machine and then look at the ch=
anges I had in
> my userspace as the first error occured on 22.7.2026. Let's hope this do=
es not escalate ...
>=20
> Bert Karwatzki

So I've run memtest86+ for ~2.5h (2.6 complete runs) and found no error. E=
ven if my memory
contained an error, if it's that hard to trigger it would not cause freque=
nt crashes.

But I found out an exciting thing:
I can only reproduce the crashes in v7.2-rc4 when watching the reboot via =
netconsole,
without netconsole no crash occurs!(This also explains why I had not seen =
this crashes before ...)=C2=A0
In next-20260722 the crash is reproducible without netconsole.
So I'm going back to bisecting from v7.2-rc4 to next-20260722. Once I'm fi=
nished with
that I'm going to look at the "netconsole triggerred" crashes.
 Does anyone have an idea what's going on?

Bert Karwatzki
