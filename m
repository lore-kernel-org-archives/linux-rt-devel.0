Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491940;
	b=JzGESDPP+QrnYv2VuEB2sX6Wy7ONHfBNxPUAC/kAK4vAYuVlLxsv5RlQlWNgBRwKpdYt
	 Mx9IXyV7gScwwOpsGS4E/DXGiQSwFMeO9xHxDFrBRJ/vz0Y+BDJdsSwInr0j3hPOmj4q1
	 7ZZf8VNe74yc7htuEutqJNUkAUOIrunoXFjJTW5nlZMmdgFjW268VVgphcreOYRzRnSHp
	 sqWQwwV8DK5xzoaMkO5ZOo49L/evAbWEMY47vDch73ThLCJBoLWGMK/VScHScyco3NfMH
	 54+Hn8g+s2IHDxYoxkxR+YDfidRlpHgmtfuoM/M0E8RxgZ4Ag7100btcAqZP71/gLbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491940;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Mime-Version:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding;
	bh=zV+nK/AlTUTdbSetbUQ+U98EtEMkeemH/yNGT5K9skQ=;
	b=uWBxFagpdgk40e5aywWf1tbyw94N/M7uZmAgq6+xsdxX/xjKRU6SUpLi7I39Pl31NZ1/
	 5JoVIREQZfpkI8lCpLbEFWOIP0+O8NqGSZdSAkwYCFx3c9wN74W46eUB9JVSCaFeYalNj
	 C57ya8a21RKo2wuY5Vguya0WDBqWpQeC90/zIYvZfN4xzyMOkIvQH2lxAkTHuZs0P0ZpP
	 47Psg3DdiYrsKvcPCQ/CkzHPuiXpNURti37I9O0hTYej4zVlNnV4PSn4RMdyZmBXGdOQr
	 PE4grZ/nmNThjnQr1ixVetLiDGsxtnr/B8bkmvnPD6NHboJKnLrDYotlRDqpnzKkP3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dZTpG39k;
	arc=none smtp.remote-ip=91.218.175.22
Received: from mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC78606A321
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 13:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC78606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dZTpG39k
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=bb3AFCzgVIDc1qwR2keW7mWoaFQLbnEJBXV9iSdukp8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794491937; v=1; x=1795096737;
 b=dZTpG39kP94h9wkkuUPQIK6ymqIkc/xyQ2lfamSOf2XGF4cDtlATlfHoJwx2V/jRSLBZTQOF
 c89ICT/gw7pnGQ8LQTFJuP4yQM0E+bE1WuXAiealD9HZpNdsWgyK4UbOnIgIj8DBoyuIJNt4hea
 +EDCH8iQqVCIfn4fmY0ZoBCs=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id ede3f35cb65e7420;
	Thu, 12 Nov 2026 13:58:56 +0000
X-Mizu-Trace-ID: ede3f35cb65e7420
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
 boundary=a9af0bf4469639ffd39239db22e9ea1ba44d1ee2f09a947b7c85873e16e8;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 12 Nov 2026 13:58:52 +0000
Message-Id: <DMTAAT48IDFT.21XSI5A57I5C2@linux.dev>
From: "Troy Mitchell" <troy.mitchell@linux.dev>
To: <sashiko-bot@kernel.org>
Cc: "Troy Mitchell" <troy.mitchell@linux.dev>,
 <linux-rt-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] irqchip/riscv-imsic: Complete vector moves
 without a timer
In-Reply-To: <sashiko-outbox-210743@kernel.org>
References: <20261112-imsic-remote-sync-irqwork-v2-0-680f65b24ff6@linux.dev> <20261112-imsic-remote-sync-irqwork-v2-2-680f65b24ff6@linux.dev> <sashiko-outbox-210743@kernel.org>
Content-Transfer-Encoding: 8bit

--a9af0bf4469639ffd39239db22e9ea1ba44d1ee2f09a947b7c85873e16e8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu, 12 Nov 2026 08:35:16 +0000, sashiko-bot@kernel.org wrote:
> This fixes a bug in the two-step vector move synchronization and local
> retry timer.  Should it include a Fixes tag?

Yes, will add.

[...]

> Does calling imsic_remote_kick(mvec->cpu) here wake the destination CPU
> out of cpuidle right after it takes over the broadcast timer?
Yes, by design. Only the new CPU clears move_prev, so it has to run
once after the old CPU is done. The retry timer did the same a jiffy
later.

> Until CPU1 re-enables IRQs and services the IPI,
> new_vec->move_prev remains non-NULL, so if a third CPU enters
> tick_broadcast_enter() with an earlier expiry during that window,
> imsic_irq_set_affinity() still sees imsic_vector_get_move() !=3D NULL and
> returns -EBUSY.
The pending IPI ends idle at once, so the window is the idle exit
latency. The broadcast IRQ then stays on CPU1, whose handler still
wakes the third CPU in time.

> kicking new_vec->cpu twice.
irq_work_queue_on() skips a work that is still pending, so this costs
at most one extra IPI.

--=20
Troy Mitchell

--a9af0bf4469639ffd39239db22e9ea1ba44d1ee2f09a947b7c85873e16e8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iI4EABYKADYWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavXGHBgcdHJveS5taXRj
aGVsbEBsaW51eC5kZXYACgkQmAnvgPkzNC/AbAEAjXWRzqNk9SgbDmMiW2BNh3E3
7Lt7TyjEWGsoa3ghCmMBAKHRbKnqmPoOWPk+T7lRENaY6alk0kEd+STaO8MvYw0E
=p/bY
-----END PGP SIGNATURE-----

--a9af0bf4469639ffd39239db22e9ea1ba44d1ee2f09a947b7c85873e16e8--
