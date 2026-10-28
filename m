Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198132;
	b=cotixp3ceW12Q6yJy8fOBIgMTHrz1o82ciEzw/GPOvFo9FngBKs1jxqZLNavaQekCjaU
	 fW+758F8TRpl3J0rEsF1LvLrM7nhIkSWhnLm0w6C866tStNTMYDVH5gGfZtmws6liRGYw
	 YDzcNz2rAOWsfOjlq8vbdDX5zPOmqqk29cQLq+f/kguwYfaW13fxRZ7ez6sDYwgjuQlkU
	 uzHx/YrgT43ZfLs4lLafVbW9Y0Hc3a04/P9TxfIxm2MjMHmFPCVcxe4SuSh1/H0I75aeh
	 kXmwg/g/OdAL7SNJMPaBZGVTDfDwlxlbQIYWz+EkXLbYi2ykS2zuUteLT0HqqS+nmiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=pN1MSQu89b3Fcl+JyWjZEXsAVAkBhCmDK4pMhtAcO+I=;
	b=wsisGm8gvWv1IRWUfLMsCSgQt7AmFACuUMOLlBI8HdqvrY+ulHevD5jQ2vXH12I3jJIs
	 b96x5cKO0HAxmzDzKlVBvMtobL67VJnL08qavqje6N03ViTqYH3YKqbrcsyUrAIe0TCiK
	 frfXJQcfv8vISpCtzkepXdusGYFzkye9LzzpV2sqG2xv+S97oZcIxZda1IdzBgd3L8Klw
	 9Tdh9SL81kl6TmDFtCUeVzkBn+2tAn6MO8oawm0BAl6pyr7GyOQvEm9R9YypAhtHWqMmu
	 TyVnn6WGZIebUnwO+4nGS/a8Rc3nWSuy0HUUz1jFY9qBgbv7pyt2JD6d3FbKb7J7/6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="pC/Ddi07";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E63606A32A
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 14:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6E63606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pC/Ddi07
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so935640a91.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793198131; x=1793802931; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pN1MSQu89b3Fcl+JyWjZEXsAVAkBhCmDK4pMhtAcO+I=;
        b=pC/Ddi07Xhrm/BrDQLojoFwUHnoZJFkwucjLCGv3vUKVM9Z98qngwj2tdMxz1ccgtI
         iQvR0zu1qFOZz/GqlUDdnjRpSAhpzUkCE5+Vp4colUWvGCP7NHlLyBAiGC2OfgNn0/An
         +s2SdcE0JOEv1c1c3XGZ+ifG86TNWKeWeBRm5uI7t/YMKpI9MxFvtsc3NYUQjrYyCxfu
         5KO5RLTwi6760ofDcC/4KV+vy7I/WaS2/Wx460xg4p/+iddPYLvd4UsqziLBaS6x4QTP
         wEhkwQZwzVKay/K2RBRUCfJrEao8V2k7swOBnhLDVWiKTFsbi3nDBhUFtTmV+5sy/R6K
         DkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198131; x=1793802931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pN1MSQu89b3Fcl+JyWjZEXsAVAkBhCmDK4pMhtAcO+I=;
        b=K1pXIP30FW2IEwHurLx+Df0e5kOdm5eLyDzRUnqcC+MJAtvN9f3lyZfBgIyOIXtk5f
         lNdvVpnfRDdsB+RzvHkXWM3S8pfmzKKigqC2pRkls0KEZ7AsUOiKnF6inpoAFzLikW+t
         pO11ng7ZVtKH0MBkBRKataUx/Z4b1xf5JRJv6EWhYayiIyazA5XjChmsUAFciKV9aqEh
         un4lf6TSQeXdW38b6wCSd5Szb5llO0sCdfOWE1lo1vrjc/JKA3b4GWthe7tny46oPvsp
         j/noWTaFSMtcW5EF0ACY6wTMPTu0KXLa774Ijn4y4XNe4f671QbUn/DU2N6Xt2rZwWkw
         +6Zg==
X-Forwarded-Encrypted: i=1; AKwUvBwC8NUG10L/RhxU+KIgbothW83pqzAm+4fIP3j686p8Kg4rDMycyEkDXzMDIKA+3iN9Zg0ePn3xwUN27NHsEg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIRJwhZQ+V96x4hl1+z188sdc7vRuiVVHvCQlLBu80SM2PEchbk
	ijD+YpbO/YMruLP7yzYK4qoc1hwWwVR5MvS2v0M/LkjMQ+rQ+3Fa1tg8
X-Gm-Gg: AYBFou1WCqIMGVjQdZQMgep38rRDev1B3WD+kbMh+mnvUZzTsNr9Nx8ekgpTdN+717d
	+Ixa6Et9qGYgf1dm7APv7QGTvmA5W7OOQWkfmHsl8p0ApV6xxU2Deed2W811AANWxq0tWMxwsLB
	2WtX8WANV0Ti4i6JazcZLFcg4Jm2+U9EsyZNIRNTB0uPvgQxg4FIJzkb35wkgJgGE+DTUlwaJNx
	pKSfnD4fcv9mvT45p2mOf1kx5SKlHIlYE0le9VG934oo2rLtYkNrR8AOqKCBdjI+aN0Uqwswxws
	/B6UjX0jhr/iYqN4+S2EBETJAZAEjLTqSpgnV439e7syxZXI0MCdB4jaikQRZG8j1yWLLoVJzHx
	JUv+u0Rhn0sCXFtrck/aw+6w4F+LqhmxFA+q7cHGuK49LukIZ06v7/euLA8BwuQ2k6M5Uer+bU8
	h6XtVAxPAXVxnbic152+GtZblDxcfPup1cR7FBilVAwid0r57jHWB7i/75NKh8STGq7/s/yCDer
	Tal9TQlceSNQmZ2W8Gh2CcYv5XH9uuzy/5Q30DAebgF68sbKQhHDaCBqcZM9dBjfT89/5v/zktv
	dLm0xwcFZPfX4faywUEuCAg1ce/bCfT6zvu4WpPqEUgcN9k6E7fRDQu2pHnp5s7G6PJtbCNNNGQ
	=
X-Received: by 2002:a17:90b:2543:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-3ae581b5095mr1763826a91.18.1793198131090;
        Wed, 28 Oct 2026 07:35:31 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a5834b1sm3422045a91.13.2026.10.28.07.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:35:30 -0700 (PDT)
Date: Wed, 28 Oct 2026 20:05:22 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, bwiedemann@suse.de, 
	ryan.roberts@arm.com, mchauras@linux.ibm.com, agordeev@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH V2] powerpc: Support for generic TIF bits
Message-ID: <auIHxotTRFuyJGBv@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20261027074710.129819-1-mkchauras@gmail.com>
 <auCJ9ZDlTpHlnyTi@kunlun.suse.cz>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auCJ9ZDlTpHlnyTi@kunlun.suse.cz>

On Tue, Oct 27, 2026 at 12:24:37PM +0100, Michal Suchánek wrote:
> Hello,
> 
> what is the interaction with
> https://lore.kernel.org/linuxppc-dev/f6c831c95f1171e0b82353e611485231482f3deb.1791975972.git.msuchanek@suse.de/
> 
> Does it supersede this patch or should it be added on top of it?
> 
Hey Michal,
This patch is applied on top of your patch.

> Also does this one need the first patch of that series?
> 
I took your both patches and made my changes over it, so i guess yeah we
need both.
> Thanks
> 
> Michal
> 
Regards,
Mukesh
[...]
