Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778E2147F9
	for <linux-rt-devel@lists.linux.dev>; Wed,  8 Jul 2026 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479911; cv=none; b=jS9c/F18v2QBlqjQc0sdmtwIsUmiWMlyIZSrZCDT6D8RF0PCJELryvMmajv4AjrNpVBKrRVtjamnx3AL88JMY6N1E/QqqIgmqvoaI5uWp7kFK44wgJQzjLlLsfqCIFgVTCfyejYTn4/H2B/QhJxvbsHN0uY/fNkoYvxk/a5xv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479911; c=relaxed/simple;
	bh=lDkrN7TEV3W2iPCZlUY1PLvMiA3LImtRz8mNfzXbJ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8fpTdQJlFQKzWbGR8TllEEzDy60lsL8HJXHMLUSjnT3R2PUI8h3ZCmVj25LHaS/WLWuuEpFkIA1YIWLc1HX4SG9rM7z9+xTwg0YLt85Fc9LBtGptpozjtiz89+KTKnV6Io2FAzti1BtNk0zWOiQ5bCS2nARXnd0bi/+B15esRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boAbuGHE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boAbuGHE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cace91f112so2291705ad.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jul 2026 20:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479909; x=1784084709; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/2EyXuA0RqvzIxJQ42DvJAEkPUcEt3WncopO+pVd7fw=;
        b=boAbuGHEKvp1zqPQ9msRh8alLXSh9gsczpNQbdxZ7/I0DY/bbyKBDALvoccL1MLaQq
         nv9FJBmsWgD+6Umk3/fWJCb5MW/sqZWzrNurMWFuqBo5PoaK0pvHRUnGTxlYumMgWB6q
         2WgKRB6Czmg8F7l+REvPVIF+3Y7N4tN/tUH6B9IASseH0b2BCriUtgdHza8naA2yAnt5
         OcEJNKIKW1P5CHEOBLL8NDu+XdG6njdd9W672PBEG0wYppRMCKYhBw5+VChOknieDQ6L
         q7Hr0TEQMOu/NvotFXQ0ogPIf//vqn/p2NGfhrHMOMUUpQiYzu74TLjZ8iyH4OgW9Mo2
         OoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479909; x=1784084709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/2EyXuA0RqvzIxJQ42DvJAEkPUcEt3WncopO+pVd7fw=;
        b=RDAACg6h7/jNtINWr1Xl+ydutyoVc87M3PY+8uZwKBrTzMriLyuZb+EPvASGCSQQYg
         DHMyLfNwVDdS7cFMb6WpEkUkYrghBH6Fd/PwFSJ/Vtfgk4yUzsFIp3PUBJCz8vTD32xE
         sJzBfS6Du1J+uYf+SC2QeCHUhvEoo7q6e7j/k9lkaw/3Hv7owxX+avD/1EKYy6G9Uqtd
         7fJ2ZRMnzhxaDVrNes8H0r7Yr6E77cieCcbsVxgfoomaGTpj9+iouPR7bwksQeIdL9o+
         fI0872a8mO6N/Xe8Hc3qLfBdo28GfqosBHm8xqypnoyM3sXFirCo22INNZvhvjm2FN7Q
         hblA==
X-Forwarded-Encrypted: i=1; AHgh+RrMhK6u/Tbse+QD2NwE7ebGfxToFT15V12YWro2kCahZMCBuA5ErWlV4I8k/+K/Jw1UUPsR60i4LWnoVfoLHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiYLb8fotSHlLip/TNSNxumZSDI00PWAkmGl3pjKqSQhxbBKT3
	+6JAVxoqTsZaQr/QZVb+YF0nu1pWHXfkxfG4H68Qx1IvViPK2ewzjMNQ
X-Gm-Gg: AfdE7clYj5LBGpOpV6OLUb376g/QypYcpq2pHQ1ZvZ3+HL2sXldpt//wSShpSdYEyWB
	D16dJlE4wZtwW79F1l7Kipq3OhBJL82RYX4eJrNEN+VquhetmtI3rqMAOqcFeWZC+eA3WJpNe+I
	sG7P+Y5MA0KyYaFCa0IWmAtfOoe2cjlSdhFh2gtf2KK9bkLhl4CpIRT/0KkhA/33iC4Bqy0DWUS
	mA0wVo7qBIbn/Exym8ewVDTKP9ecjso50Pq8ManOtZIyu/Lq10SGGQWyKyMcfRjYDf32vBu848O
	DvjnOZjW6KW6VFYjguFaI1pFcHMZg2S+nMa/7y/hJpfqHI60DZi5buCOFa/XsE2C7cq8B6iToxM
	eA1OOL6VmrCMT7Ctf1sqG1MFvTxWA7foJhEF6lHVruNzsUKSApj1T2wu0Ht9UtGavDeCymDeqhu
	y6a5OQG3s=
X-Received: by 2002:a17:903:1745:b0:2ca:ed41:d331 with SMTP id d9443c01a7336-2ccea5aaac6mr6489615ad.45.1783479909029;
        Tue, 07 Jul 2026 20:05:09 -0700 (PDT)
Received: from xiaowei ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5c804sm20225105ad.82.2026.07.07.20.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:05:08 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:05:00 +0800
From: Kevin Hao <haokexin@gmail.com>
To: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
Cc: christian.taedcke@weidmueller.com,
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
Message-ID: <ak2-XJHVc3Cg6ZEk@xiaowei>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
 <akzDQrmdYwHAMMmw@xiaowei>
 <8d53c3d9-7918-456c-8c27-e9d73c896452@weidmueller.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kyG29oqcChhEWuEU"
Content-Disposition: inline
In-Reply-To: <8d53c3d9-7918-456c-8c27-e9d73c896452@weidmueller.com>


--kyG29oqcChhEWuEU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I agree that the TRM says the transmit pointer is reset while TE is low. My
> question is whether this describes an internal pointer being reloaded from TBQP,
> or whether TBQP itself is restored to the original ring base.

The Zynq UltraScale TRM [1] describes the receive-buffer queue pointer as follows:

  An internal counter represents the receive-buffer queue pointer and it is not
  visible through the CPU interface.

I could not find a similar description for the transmit-buffer queue pointer,
but I believe it behaves the same way. From a software perspective, it should
be safe to assume that the TBQP is reset to point to the start of the transmit
descriptor list upon reset. This assumption is supported by the description
of the transmit_q_ptr (GEM) Register [2]:

  Reading this register returns the location of the descriptor currently being accessed.
  Since the DMA handles two frames at once, this may not necessarily be pointing to the
  current frame being transmitted.

[1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm
[2] https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/transmit_q_ptr-GEM-Register

Thanks,
Kevin

--kyG29oqcChhEWuEU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmpNvlsACgkQk1jtMN6u
sXEU6Qf9ENUqNjx8NFL9ReOVIph7o6p3txHaKrhJNj5yOldBQKaAhd3ulWrxdDo+
mBtBwyWjckjL6a66Nknb+FHUYCOSThofTjjzujesS5acHoyVDfTOn4ygarN4h3gx
Vo9tcn9AaxvJi91DZPS0pGMyZgw0LVgiWwBwW29/z/hjn2bnvVRh8+VuCCEUPwjE
32Zn7Oqe4fk6yghgBVebUAn1LcySVtLRm0Xxi2nJw6k4GFdeb8RJ8hTTz9jGrBz4
Tq4oYVreIMzMfcC3G4vqKpinByTiswzqoXhFDlPXup8X6zu6DecFqWdz3isOa+4D
A7RfNYlyO90plRZbnLNauVS1oQZucw==
=QDLt
-----END PGP SIGNATURE-----

--kyG29oqcChhEWuEU--
