Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004333F59E
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Apr 2026 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741655; cv=none; b=MneAD4Ep51iY8UE7wIVp82d2UmCmUJvkRWPvgPBdpm9W8qT3wIcOC6Hcx9N63/cHqTemokgSi/8oIvhK64ujSb0upR2yhhbQgp+rISXjTEkyE0+0q+FO+eWRThZOraq2uhEgHrq/g+hQjZvzFn8y/ABfpcwI1n++koA9J4sOka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741655; c=relaxed/simple;
	bh=LrVCsFpWUSr8cnxda89ZpTbNc2BFVJrcDv9d4LO1vgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HV0wpyFtuazzaNlfYvg0DwL6yiq1t0MuaEeLCWFWLc1qE41GnpI47VVw3OGQci0B5qQ1dQwAhEJ7kq0CHvFPFBFj3JEIofut6tiX0A1+DZTvLGrpyypxcQejC/XjLwZllzgfRf9+xk+pf16uRsXXGIwQg0lzPMMbAHcfh88otPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=VGRkqQvF; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="VGRkqQvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1775741638; x=1776346438; i=spasswolf@web.de;
	bh=LrVCsFpWUSr8cnxda89ZpTbNc2BFVJrcDv9d4LO1vgE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VGRkqQvFCBGqirVi8ZJVD3vzIyYu6UilMA3LREo9h793zqn/xDXns8Es7GiEliMX
	 UogBcafekaGcyZRIQ3TNa5RXipEwrumOYwIu9e1Z6jvbtkhSJ6faLKRxs2rDH3DEK
	 aYKbwXqOd2+zXjvrbWl6O4Uj/Ydpi2yIUfImcNstgIzX02E+GWgLwR0AvE9Ji5kVw
	 5v5RuvmKtAVXTwsj2ePps6XM0cwB0aTvrnH3FPrdisgVKDAa9ncfSq5z/7gRob7Tz
	 H6hGen7dVBleRqn9kkM89J2tPpPLKC38qCqSKpCHi1a5v7utz1bdghXIqhwPizLRj
	 CKE5o+SioJN2c5sNNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1vZIqc2R0y-00ZeHa; Thu, 09
 Apr 2026 15:33:58 +0200
Message-ID: <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
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
Date: Thu, 09 Apr 2026 15:33:57 +0200
In-Reply-To: <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
	 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GX4I2Xq7iTVSXwmjy1AN7uzYHCc5OIuGIUDUmG3WLxG1OI0Qe/6
 Daw18jcza5avsyEo/ZKLQhzpNzkPY2Zm7CUVOoZ1Tn0K6hURVUZzIqZcgctTYIwoBtX79If
 2hz45U3NaaesFbeuIiSqOXg6xllwJMlJ2Jg7tDeQ4c9IOuFEvr8F/agETvtU5r9YzVNR8t0
 EwSC7ooYJeFg9vMC50Usw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:914Ndzz9gL4=;7Lmx0upHzsUf2Ku7RIaESs7THj4
 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
 f9PXZScv1wSRlHajF00o43N+iXt3KuTZQ==

Am Donnerstag, dem 09.04.2026 um 13:30 +0000 schrieb Ostrowski, Rafal:
>=20
>=20
>=20
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> Hi Bert,
>=20
>=20
> Sorry that you experience this issue.
>=20
>=20
> Do you have all these 3 patches?:
> "drm/amd/display: Move FPU Guards From DML To DC - Part 1"
> "drm/amd/display: Move FPU Guards From DML To DC - Part 2"
> "drm/amd/display: Move FPU Guards From DML To DC - Part 3"
>=20
>=20
> These are highly dependent on each other.
>=20
>=20
> Kind Regards,
> Rafal
>=20

The crashes also occur when all three patches are applied.

Bert Karwatzki
