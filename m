Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794043231;
	b=A6zf2Ai1fOtE45oFmK8o5CI92NArlrZIq8CnHNFFVSbA3SuDVt/YnSBfiWYsbCrQuEoo
	 OTcSIe5Lh+NxbavyQMNPyBOf+WF/5VyCCmmDHZ1D+CIvef0BrEs4mDK8eoePxnuTLuc+s
	 rLKgNND81iNPnP+qyPV8tGgq46hEBirIZbB73VCkQ1GS/XTB3wSw4ab2PxT1y37xcmZyF
	 2559jKFlw4h9xgTLI/lc8RjZMtxpdxNfaAadL/ZyS+pF6RyYAEeZAxNTUNcKTTGFvLAnw
	 FDG4/O05/J//S/DbgdjtJ/2DQAXJLprN7trVYCvuVfgWYdc5eeYdTu9zpGRJ+u9B9Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794043231;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mytq27GCvjVtjhZyxy6ZOX8ca1Sa6YxKOVjRkooxOsg=;
	b=GxmIIvQ4/VYQTNIlSK/4ZE7wjHNOC+tbTizfl87/noWznwBoz32qMTHsrs4QAmg9F/Lq
	 Ei3SbTuYcEFt6FSqFcaaModu0dvw6XVybvblhSBEfSOg4RbrgQr5pQMq288ynUTaKe7n1
	 Xe9ieman2koNhfSohjKnuCaTqBtL0064CgB6iqbf1Hisn+XnpomX0Pf8l9q0agtRfjhKW
	 oEYnnz/gpefvzp834FFlgDYqOWHv7A9JtFVyA1JVR7oJzuZMIGSCj/YBMP3q8xUTOaVKl
	 4fJXy3OTXtWC7fdGRFtEISMqRqhTsQQJLEweCTb4Alh1jhBBWO4x5QJRHCD5gl+8ocQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JN6QImBD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D30606D80F;
	Sat,  7 Nov 2026 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JN6QImBD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23691F008A3;
	Sat,  7 Nov 2026 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794043230;
	bh=Mytq27GCvjVtjhZyxy6ZOX8ca1Sa6YxKOVjRkooxOsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JN6QImBDWSeZGNpWe5B/yfe9u26ABED/y06IwG46O7S9iH2LDTCnHO51j3dDBfRyR
	 iUDu9CKulKiOAGjuX2A497t75uwh/ykFgLybWS0jw/B92apFcId7HXE2D2TB0FKzrx
	 rOn0cpduK3GyLcMPN+VQIq1lJLROdAoVzEWJttkV9lX/R+K2mmS1zsREcrKmte5DVe
	 d6Kfe+E/5RQi6dAUs+JpwhIWhbp9grZinG1tRYg6TqSBky2Z70EtxmnSxuDLtjnXpE
	 evtE9zDTwB4jHI80Sv4yJuVd3InwVjIQSIvzRA7afZvMTxQqE7GYecdyCaowJRkjmW
	 nRv6nxxxyKt6Q==
Message-ID: <sashiko-outbox-202762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/10] kconfig-checker: Introduce overlays schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed S. Darwish" <darwi@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Ingo Molnar" <mingo@redhat.com>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>
Cc: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "John Ogness" <john.ogness@linutronix.de>, "Derek
 Barbosa" <debarbos@redhat.com>, =?utf-8?b?WmJpZ25pZXcgSsSZZHJ6ZWpld3Nr?=
 =?utf-8?b?aS1Tem1law==?= <zbyszek@amutable.com>, "Daan De Meyer" <daan.j.demeyer@gmail.com>, "Luca
 Boccassi" <luca.boccassi@gmail.com>, linux-rt-devel@lists.linux.dev, debian-kernel@lists.debian.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261106091922.7560-8-darwi@linutronix.de>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-8-darwi@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 09:20:29 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] kconfig-checker: overlay.yml example uses invalid expected value
  allow
--

commit a10c99db2994945ab80143ea62fe4f2801513046
Author: Ahmed S. Darwish <darwi@linutronix.de>

kconfig-checker: Introduce overlays schema

This commit introduces a JSON schema for kconfig-checker overlay files
that references base.yml without requiring expected and severity on every
rule.

> diff --git a/tools/kconfig-checker/schemas/overlay.yml b/tools/kconfig-ch=
ecker/schemas/overlay.yml
> new file mode 100644
> index 0000000000000..4ac9a364a3441
> --- /dev/null
> +++ b/tools/kconfig-checker/schemas/overlay.yml
> @@ -0,0 +1,28 @@

[ ... ]

> +# and a custom-overlay.yml:
> +#
> +# rules:
> +#  - name: CONFIG_DRM
> +#    expected: allow

[Severity: Low]
Should this example use "expected: allowed" instead of "expected: allow"?
base.yml restricts expected to y, n, or allowed, so an overlay written
from this example fails schema validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106091922.7560=
-1-darwi@linutronix.de?part=3D7
