Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0031E820
	for <linux-rt-devel@lists.linux.dev>; Sun, 26 Apr 2026 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192157; cv=none; b=bakoVVby1HDaVAC/yxiTvMUcZVMmnsFlZGT9+ReuTwClTlF1f4Kv+SMUJeRDHvzLWWShjqJLkPQrxte3m1zroQIOEZ8MCL09jZMsXMJHlxsiOQLiSlkKnn2G+CRm6cL9aMhbyJqtXqEVQB8pSQnXNwV2G4qc6UCpQh2c2vcjazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192157; c=relaxed/simple;
	bh=HKdkkZxhzWhSZNCuALP3j01kwxKX3ukZguHj7H7aQXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLVfXvcwVQZlJP6zBgoi1SlfxKxVOtcUn9j18VWYMt9J/gY38sfpfum3XrGdaC/QrO6xDLQi7w8rH5uPk8fhU1AyDUKiEqwVDN6OqEDoe1E+Oi3wd2m3/nAigFpjQy31h0jhF0erNi49OHJWwTgo4z1uHymWHaXzdAnMtx2vO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=TfN6uxfS; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="TfN6uxfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777192138; x=1777796938; i=spasswolf@web.de;
	bh=HKdkkZxhzWhSZNCuALP3j01kwxKX3ukZguHj7H7aQXg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TfN6uxfSmmjhNJXh7/eXC+oz+wKaHgCBA7rlSWm90bEI8zaEzmkMrhz5hce35fbj
	 cusl0gdZm2IET4lVoDZuJOfn+Q7ypf73EQIo9PUdI6pecQRUZHQzzudbP3FLlSCpT
	 JfQlTs6uZ3t22jTMVO3WM4mzfTZgYnnZSyjKI+HXrQfOf8fZbGMFTE3JPmxmDC3Uz
	 Bvzt2cKLUmqImCrpoHpcy7ofmH8eOfJ/6R8+AddNGR+A8DQeBd8wyyg0gH/rMunhq
	 JWm9tKxtsM3BCpJizYeMG8VQijQQfJ3KPZ+Anb/JSmVKDkDRCl4gCztSMs7Lh5Dmd
	 UCLFgEL9C9BkQld8FA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrg7-1vp6a70IL7-00OI9q; Sun, 26
 Apr 2026 10:28:58 +0200
Message-ID: <a1c86a3b83e26d86f95068e8005ce4b2efdca23a.camel@web.de>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
Cc: "Varone, Dillon" <Dillon.Varone@amd.com>, spasswolf@web.de, "Hung, Alex"
	 <Alex.Hung@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 Sebastian Andrzej Siewior
	 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.org"
	 <linux-next@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	 <linux-rt-devel@lists.linux.dev>, "amd-gfx@lists.freedesktop.org"
	 <amd-gfx@lists.freedesktop.org>
Date: Sun, 26 Apr 2026 10:28:57 +0200
In-Reply-To: <IA1PR12MB630789B32C2104D1FAC2B761F8592@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
		 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
	 <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
	 <IA1PR12MB6307AC51F4C6E4A77BCB5EDDF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
	 <IA1PR12MB630789B32C2104D1FAC2B761F8592@IA1PR12MB6307.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kQcTY/3PUzonPXpbQyWw2UThw3wqIb8voXSQJLLomU3am6FJDtR
 jZEP7YjWtr84o9Yl8q0+X5GrTyAG3qmGq3XCH8ntrf/Qermk+r/+kQwmlbZGZFG0LpAlsqq
 DzTZ25+xm1GEcinLjcrK0xqw5JmKojq2GYVPKBIIGO0j0rYGcTJfg7GeJ4+i9FqQ+btJE8m
 NFSIttFCnUI4EoF1sh+9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lpp+GaLmvWI=;l3yAI0QohbTvDX/7fIsIXyLxIoI
 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

Am Freitag, dem 10.04.2026 um 13:20 +0000 schrieb Ostrowski, Rafal:
> Hi Bert,
>=20
> I identified root cause of problem. I had to do modifications to mention=
ed patches to work well with PREEMPT_RT enabled. I tested it on my local m=
achine and it seems to fix the problem. Now it has to go through internal =
processes. I will let you know if I know when fix will be available to you=
.
>=20
> Kind Regards,
> Rafal Ostrowski

So it seems that commit
8bf0cb97edb6 ("drm/amd/display: Move dml2_destroy to non-FPU compilation u=
nit")
is the commit that fixes the issue, but is missing the appropriate tags:

Reported-By: Bert Karwatzki <spasswolf@web.de>
Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Pa=
rt 3")

Please fix this.

Bert Karwatzki
