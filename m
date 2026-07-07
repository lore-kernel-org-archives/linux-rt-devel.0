Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA132E12E
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415630; cv=none; b=TpXJvY0ir3jjtQFS7Ofp+SbHoLV8HrkcnYzFZKciiifgbUXF7P0D6usCgOCbsoT+eoqiaae1s3D4VX0ms2t74fXj38xJvDJbj7mtr0SyQd3BcJf+O74cHjB1H505ZoxzD8aVqDUyKB+bn/1EClMqE0H2Q2TTukzRclKZpOdCkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415630; c=relaxed/simple;
	bh=IN3rnUdx/QJ9tTUWniQhk33tdcHEWAN8rDsusiGV/JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHGiQeiJojXfJG8+aCupbpDDbH+JGFWgrQhYJvRcOtrlbVYXqNEF9WPcixVTUsc/dOZWmHR8mHR6FCTXOUtjHS1oJ6JPuU5JilHYNvwttn2+nlZxkl4ozBcbwKav26l+UCOK9qXl9NVO8Di6skPdmGi9oEZ1i2xECZmD449OJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN+SH21T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN+SH21T"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacb8416a1so32828975ad.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jul 2026 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415627; x=1784020427; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ZzKVPkDUFjHWiE6AseaXJ61s34t3U4h5G25MP41TIk=;
        b=gN+SH21TlSVpDnNSwFPIiiWdBQXcMyNQVu9Ojo0BF24gxs54FGVxkUANM3gfK/C+Tr
         XLGDM0gTrBSjidVG4ymgoDmg06q2UTDeGsdYJb9lfxyv8iry3ZsxBpNTp3HCJ4pTCU7W
         tJblzfLdk9FdTwnSHJHVzmxZ73ORFcF434qgsJ2Me85XjXASlVXgc+iDXcrRPQJV7+Fv
         luDBVBXAhksApTdre1+xnynZmpZBR7HMygsC5IGY+WFYE0h8cSwOieSeVsjBowxawJHQ
         2AOpwfzaa9GI56eBC7cIPoqvhhCNjldrM1o6HN3VTXkHWBRr/mUT1+Va8E5GPDdcUhft
         KVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415627; x=1784020427;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ZzKVPkDUFjHWiE6AseaXJ61s34t3U4h5G25MP41TIk=;
        b=JA5qScTs4c1t5SEWbpuLgRPPR3a91FDlOoNJ8do3sFKTKp8lOzVy3eKw8WhxPW1ROl
         e5p3lXY3Nt2SHzLv2z0voshf9vIwO92oLoUuU/F7mz1GzAfThVBYxh9KlhNws0bbIL7y
         5b5uTdld36yHHB9LYmZbHVqTVuB5bRE+GtWR7mFqfIKsQCHeqSgnv6sHayc4Nd+2LOoG
         QEkvUpIPsw5sQbXehKBhiMSJbrhVeJM7dVzF6WNjeYHBDXgfWEaO+ny2SGBpuekxrDbw
         yim+x4U7AEgkgu+v6W+44GMsQy6uEkANbDhOBCObKMYhjeQpUe+v993dj3xKcH/8u2B3
         7xuA==
X-Forwarded-Encrypted: i=1; AHgh+RpxSRqyIvcX1gT6IRV6/85Vr2muZRXvc8OtE1zQJZ/E1Az8m7mWumHYBryKgE4AYXCaYTWb3xgg8iVgXTUs8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOI2IdO7AcIPzVF5q1zLgFVwxiNX5IPc99nhooRlmpDYuPx226
	Wu0z08rYUmzH6GtUVM782qBHMkxBxxipf/gxJ5UdFtKx0ykTc3KvV0AO
X-Gm-Gg: AfdE7cnOcCXovZqIwQ58UKHS9VbAgY6cgMLfJJ/Dqz8Rj5fH/lZGjastMEP/7ztCJ+2
	C7EJLGYWViQ0NI+arpK+FLsBvTZ1BRDArB/riV2tZIjSeMH1KkEExZJk7M+ARucqhsxXQ3F5tSw
	Z9bJM5Qu/Hg88KjOqIVuY+fVlFnkOkQtemy8rlqt2VMUsheC9fWk+kvHEtV0vOhK8Z+p5g9NsOO
	2l+a4ipWoYmZlN5ZyD6Enb3gJDcoAx0FEJ0zgXQH6rKNsnSdKjyH/wvw7WTqSIKEhkxhbgzByxU
	+GzLaIp4xfbRQdfHjJQrTGH6+bhBZpBuhq8wTWtAqNoRd5AAyF1C+lyU4dB49m3EU6h8HmaRsYC
	l3qdCHwZGZKAnF7tGKi8R2v/Pk0rtwL6KMF0OKi3d3g/gv2h8Fy9zjCxUYVudfWjcbQnEgO7JFp
	A1HV/vVKA=
X-Received: by 2002:a17:902:f790:b0:2cc:dacc:fe27 with SMTP id d9443c01a7336-2ccdacd016dmr645665ad.30.1783415627151;
        Tue, 07 Jul 2026 02:13:47 -0700 (PDT)
Received: from xiaowei ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c100adsm8167815ad.32.2026.07.07.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:13:46 -0700 (PDT)
Date: Tue, 7 Jul 2026 17:13:38 +0800
From: Kevin Hao <haokexin@gmail.com>
To: christian.taedcke@weidmueller.com
Cc: christian.taedcke-oss@weidmueller.com,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the TX
 ring on link-up
Message-ID: <akzDQrmdYwHAMMmw@xiaowei>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NDb1+SKKlMxGRi/m"
Content-Disposition: inline
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>


--NDb1+SKKlMxGRi/m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 04:02:14PM +0200, Christian Taedcke via B4 Relay wr=
ote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
>=20
> gem_shuffle_tx_one_ring() rotates the software TX ring so that the
> tail sits at index 0 and resets queue->tx_tail to 0, but it never
> reprograms the hardware transmit buffer queue pointer (TBQP). Other
> paths that reset tx_tail to the ring base (macb_init_buffers() and
> macb_tx_error_task()) also reprogram TBQP to queue->tx_ring_dma; this
> path does not, leaving TBQP pointing at a stale descriptor.
>=20
> gem_shuffle_tx_rings() runs on every link-up from
> macb_mac_link_up(). After a few link up/down flaps that leave
> un-completed descriptors in the ring, the stale TBQP keeps pointing at
> a descriptor whose used bit is set. When TX is re-enabled on link-up,
> the GEM reads that used descriptor and raises TXUBR. macb_interrupt()
> schedules the TX NAPI, macb_tx_poll() makes no progress (work_done =3D=3D
> 0) and macb_tx_restart() re-issues TSTART, which makes the controller
> read the same used descriptor again and re-assert TXUBR. As the MAC
> interrupt is level-triggered, it never deasserts and one CPU is pegged
> at 100% in the threaded handler, eventually triggering "sched: RT
> throttling activated" and a dead network interface.
>=20
> Fix it by reprogramming TBQP to the ring base on every path of
> gem_shuffle_tx_one_ring() that resets tx_tail to 0, mirroring
> macb_tx_error_task(). The early return for an already-aligned tail is
> left untouched as TBQP is already consistent there. This is safe
> because the shuffle runs from macb_mac_link_up() while TE is still
> disabled, so the transmitter is halted.
>=20
> Fixes: 881a0263d502 ("net: macb: Shuffle the tx ring before enabling tx")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index fd282a1700fb..b11cb8f068b7 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -820,7 +820,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue=
 *queue)
>  	if (!count) {
>  		queue->tx_head =3D 0;
>  		queue->tx_tail =3D 0;
> -		goto unlock;
> +		goto reset_hw_ptr;
>  	}
> =20
>  	shift =3D tail % ring_size;
> @@ -869,6 +869,13 @@ static void gem_shuffle_tx_one_ring(struct macb_queu=
e *queue)
>  	/* Make descriptor updates visible to hardware */
>  	wmb();
> =20
> +reset_hw_ptr:
> +	/* tx_tail was reset to the ring base, so TBQP must be reprogrammed
> +	 * to match; otherwise it keeps pointing at a stale descriptor. Safe
> +	 * to write directly here as TX is still disabled (called from
> +	 * macb_mac_link_up() before TE is set).
> +	 */

Could you elaborate on why we need to reprogram the TBQP here? Based on my
understanding, the transmit-buffer queue pointer automatically resets to the
value of TBQP when TX is disabled. The following is quoted from the Zynq
UltraScale TRM [1]:
  While transmit is disabled, bit [3] of the network control is
  set Low, the transmit-buffer queue pointer resets to point to the address=
 indicated by the
  transmit-buffer queue base address register. Disabling receive does not h=
ave the same
  effect on the receive-buffer queue pointer.

[1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm

Thanks,
Kevin

> +	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
>  unlock:
>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>  }
>=20
> --=20
> 2.54.0
>=20
>=20

--NDb1+SKKlMxGRi/m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmpMw0EACgkQk1jtMN6u
sXFKuwf/eTcO0PsGfR3477cVoSGkyYKAr7uk3TUnIpXDtesNZNlFvS3NQCuzYKuF
WCCLByw6cPcu+N86dZUiaaNDAzKQl2v6D3eL8sgOEa3TIFemYcVOW0FOrrYNoWxO
g9woZQguWKXkekrGrcTg9teWqCdFRwspZfZZxW5DAJVaacOW1As4Yre/i4dNeBL/
j+02Z0TMji6q5z9H5QH/BmBQqx7oHDR4hjrQv00yxY9lf05LOhi3s3spWInhvgZD
ONZs1FsZwnQeMYYnUu9SZohTSpk2aLv0T66b2k1Ybel4WMaZq9vDBR4DWdCkwr3l
BdFPsNA9io8VvXRctioGwNmU3dHgxQ==
=kMC1
-----END PGP SIGNATURE-----

--NDb1+SKKlMxGRi/m--
