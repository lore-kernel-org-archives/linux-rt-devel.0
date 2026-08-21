Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F324B28
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295453; cv=none; b=PSr3h0QnhvB+AlB3y3AaxOXnlizzDDG3Tpus9m13ak2q/s71DKsUbm0dkxvGKKbFBNcS8Pax2MBnndXnqA/aGhyg/t9LqqHpw10+q+Cgw77IIk1DTTK5Mkg/YMXmrr2ZZboGyQ8S0cQh39WjgtHrAQyRc4co2sNIokHtTibP49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295453; c=relaxed/simple;
	bh=Lxe+kEbI/BoZ0Z5+9bkOjlDzeaYwc65+w83/KeW5nxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1XbaffoOfgXJEcnkIQXMxZowS9EeUelJlOghhROO0FXQGnUsIKXSmQDyL6l+SBA1Hr0diW/Rql0vuqNhx2KFmr2t5mlFaRwlIFu/+lWu5k24SaHhx6pJPGZGUG8J9l4MToSORyojhuEozYKaqpg9OfiC2BIDkxXyy6YBYFncTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tUgirkXO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Np+eVljE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tUgirkXO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Np+eVljE"
Date: Fri, 21 Aug 2026 08:57:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787295449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//H5GEZrx8xix5H5r8gAAXiNMUAXhsLPmlXNUhiqpRY=;
	b=tUgirkXO//2Xg6MfOKGf3OFDIKYL0B80RIS/QrJ2TDW55fUmSEJEsf6dzoFX0J/JSXC7fZ
	zRVaZAoLixo/p03cvkgMgsn1aCrEagZxcyHSy+Z7Kym7fqH49j/0ljxwKRPnw++Qfq1JyI
	kttBaMB/BsLVujnFIbPY41drRRlljWkAcEQQvuGlUQEHgFossD1wiE0f8+ZroFWp2CvfX0
	CdZey7u4aHw3Hq+A5+Cmhj9XZl4wSeqH3O9a97sfsE4coh7IYkuKfPE5F3GveCVBoeTGo8
	s4hx2IRWNCU+kIlT/6boTSIBLL9Dcp8wjOqiybg6iJe9sx7iTTVuWhNLyL6LKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787295449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//H5GEZrx8xix5H5r8gAAXiNMUAXhsLPmlXNUhiqpRY=;
	b=Np+eVljERw3TWhD6K2X6wafhgGDiLqKQy3Osth2WQPcl+cQ/6oBuTHT5AKIieplGmXiRQs
	ZnHbz0J5cspn7FCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, kees@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v3 2/2] net: sparx5: fix sleep in atomic context in
 MAC table access
Message-ID: <20260821065728.Grs_oZp7@linutronix.de>
References: <20260817-misc-fixes-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com>
 <20260817-misc-fixes-sparx5-lan969x-v3-2-c7c7fef723a8@microchip.com>
 <20260820143443.RTYj4Q3u@linutronix.de>
 <20260820102458.308b78ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260820102458.308b78ba@kernel.org>

On 2026-08-20 10:24:58 [-0700], Jakub Kicinski wrote:
> > > -	.ndo_set_rx_mode        =3D sparx5_set_rx_mode,
> > > +	.ndo_set_rx_mode_async  =3D sparx5_set_rx_mode,
> > >  	.ndo_get_phys_port_name =3D sparx5_port_get_phys_port_name,
> > >  	.ndo_set_mac_address    =3D sparx5_set_mac_address,
> > >  	.ndo_validate_addr      =3D eth_validate_addr, =20
> >=20
> > d6fce5141929 is v5.14-rc1
> > ndo_set_rx_mode_async has been introduced in v7.1-rc1.
> > Youngest LTS kernel is v6.18.
> >=20
> > What would be the "fix" for the kernels v5.15 =E2=80=A6 v6.18?
>=20
> stable should backport .ndo_set_rx_mode_async
> there's been a number of similar fixes, and the whole point of=20
> the new ndo was to help drivers avoid the sleeping in atomic bugs

Understood.

Sebastian
