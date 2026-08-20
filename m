Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A83368A4
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Aug 2026 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236488; cv=none; b=deSab+k5dYsJ9SfrDc7cRXEnIQuF0OdM+N8MMcBNqHUaivLsD1376FTy8NtErs55UvsSKiUnDIJ2te5cdzWbzXnMO3VswKqNxWCUI2fXQEszYJckdC6eiGXw6SMPfUotLLcAnk/qrQN2U1tcnMd0nRfQRphWHT4gYZE43FFHtXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236488; c=relaxed/simple;
	bh=KYGsZx4+CC/WDyszOLkEfKaZAqbTH64INyhGQq5kiDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN8dNwIbcEsuJkINceUN1kOgztddkYBULbVoEblggVDlFfdQGeg7M83TNbq06L4n8vUos8G1NXhNnfmjV9TLebxUs9vK2lsCtGOJVb6W7MSkP/yQH4kTmACjlOulaK2EDJ3IHjGBu0gaOYpGSLnVzqA58omkzeWdRuotBmiclcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ny1S9Smj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ZJxG6Nw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ny1S9Smj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZJxG6Nw"
Date: Thu, 20 Aug 2026 16:34:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787236485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxlVhm2iZdvl6splt92kTKGhaPF1bkVXKJNBeMgxGvg=;
	b=ny1S9SmjOp9NsmmNoh0Q09yETWOdwBOilfXZtbTkRhnR7rODPyAaiH7HCuXDx1/nnu8fw+
	ekFOfRiaKLGotpX0d8+XPfnid3pxR/un1Dc5meRE0srYponRN5WL1yC1WiyHbUuQcksiLz
	9jWYvnFPRlKDk6mbo8mGfAYaD4hzaoWzsEWPGJJKaKOxoCS9WQUgxXBC7sq/Rz2KO97GaW
	emewRRneg9jlc+AJerldFZTEaU+RgQb6QWob4is03ugQJSInxHRyopYCq0RaIwFIJA64vJ
	6hDACW5iMDSBAjoA+yoRqWClovg7p9HqnXkDfV5nB4rLkyhv/+V9BXKcr67oUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787236485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxlVhm2iZdvl6splt92kTKGhaPF1bkVXKJNBeMgxGvg=;
	b=1ZJxG6NwzDUEYTjgcDSPNZ3ftByYfwAjdMnF0ckgCPF8aiHGptGcgYtUA7AQQM/weqhabd
	h2aGVaP89BB86UAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <20260820143443.RTYj4Q3u@linutronix.de>
References: <20260817-misc-fixes-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com>
 <20260817-misc-fixes-sparx5-lan969x-v3-2-c7c7fef723a8@microchip.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260817-misc-fixes-sparx5-lan969x-v3-2-c7c7fef723a8@microchip.com>

On 2026-08-17 17:41:59 [+0200], Daniel Machon wrote:
=E2=80=A6
> Fixes: d6fce5141929 ("net: sparx5: add switching support")
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
=E2=80=A6
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/driv=
ers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> index 1d34af78166a..4dedf5d92641 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> @@ -249,7 +254,7 @@ static const struct net_device_ops sparx5_port_netdev=
_ops =3D {
>  	.ndo_open               =3D sparx5_port_open,
>  	.ndo_stop               =3D sparx5_port_stop,
>  	.ndo_start_xmit         =3D sparx5_port_xmit_impl,
> -	.ndo_set_rx_mode        =3D sparx5_set_rx_mode,
> +	.ndo_set_rx_mode_async  =3D sparx5_set_rx_mode,
>  	.ndo_get_phys_port_name =3D sparx5_port_get_phys_port_name,
>  	.ndo_set_mac_address    =3D sparx5_set_mac_address,
>  	.ndo_validate_addr      =3D eth_validate_addr,

d6fce5141929 is v5.14-rc1
ndo_set_rx_mode_async has been introduced in v7.1-rc1.
Youngest LTS kernel is v6.18.

What would be the "fix" for the kernels v5.15 =E2=80=A6 v6.18?

Sebastian
