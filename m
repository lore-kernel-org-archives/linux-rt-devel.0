Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254467;
	b=Jt3MHfXfYdURx82TkSNWxIcyALr/HmdXoj4MBUbX3ilie5XbH/LKHAc7ft05k3RZ0XMe
	 1aGBP1W10RNIoOlcbMpxdMYTb4T9z5BqGlueKMceq2LB11fEbzDE05rahk2V11/RS1Br7
	 2+KuoX60rwy1IAc60NNY6X9rdITU4tcsFbJDAAPVRGsyf6yU8ERrnfugd5gBSEh2Kt8I+
	 ezeUSRVYCtngM5yAwg89wGRV4CFbvIpdRlujg38tFPtY+CE/77BZovptZR/Yyq5GqZ+au
	 q7YVWTMjUEggqPI20TTKCA3A07P7Fr1N+cSOwz/c5aMyev03MNjPU5ap9UCG8w8r1eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CAPaKBNynChhoBR+JdV51jsmwTjPqfgVdgixIftrlAI=;
	b=e6aq1g07IjarcCmsUDRLPkh6VFswqp/G452cP/TnmAcJJPadoRxY00qwywJbHtHILa+3
	 RcNcmf5vY6i+S/pxqtmsfUJxWlBXW+aCTOAHZHv1Y/ixZlaYDObFh0dEJBQ1CETdEz8wG
	 pQkGmhB8qwkTGB/N6WMpvwMTfbj5fKUqmI44mpeBE27hp1pune1HVuzAuEphJagrWK0NH
	 fWXxxKSBQLwA7Di1mk3sNU1mjLG7TdDKsAPORnzuEPTrzMkrVkjOAzrSQFZSNmSumSXow
	 mU5Gh7Y/hMO9tendo89PqDMg3CfLBG3dX+TtjG9T5Mtfos9VcH5gYZ1f2V0JiFSyk4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQoVasYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A125606A334;
	Mon,  9 Nov 2026 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQoVasYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A9B1F008A4;
	Mon,  9 Nov 2026 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254467;
	bh=CAPaKBNynChhoBR+JdV51jsmwTjPqfgVdgixIftrlAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQoVasYdRITslxBIVz40WUbq0vDYY+GgvuhG17X6IzKv4G138XgKG5zBXKo8SB+P/
	 wLPj8mM2T85lfH5LEO7ZwJBg/TcGutPoRYfHBKf8SWIVoDviTASTApc/OnZn0bWcZX
	 AAqxEXNEJfkoQxRXYrn/9enQZUc3Jdspab9PHqCnw8YSecgUfp7Y+WkfoA1FkAsxom
	 IOnNxnDwlbJ6bILfzeW+pbPzKfXR/QVemc0rWjlm13wnz3PxYiWFVrMf0e04Y0RvPn
	 mMGLzTYCHdUwGM3xpyK2QU8BunW4HQsMd1BdETmemqWHGuLbo20USVMNonAQPDHkaA
	 Kt+4bm9ajYB9g==
Message-ID: <sashiko-outbox-205522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] usb: chipidea: udc: give up when the endpoint halt bit
 is not taken
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Behn" <mario.behn@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261105205343.982465-1-mario.behn@gmail.com>
References: <20261105205343.982465-1-mario.behn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:01:06 +0000
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
- [Low] usb: chipidea: udc: missing Fixes trailer for hw_ep_set_halt()
  hang fix
--

commit a303d4e574823163c056eaedbfb37d82c4fbaacb
Author: Mario Behn <mario.behn@gmail.com>

> usb: chipidea: udc: give up when the endpoint halt bit is not taken
>
> hw_ep_set_halt() writes the stall bit of an endpoint and loops until it
> reads back. On endpoint 0 the controller clears the stall bit itself when
> a SETUP packet arrives, so when one arrives while the driver stalls the
> endpoint the loop never ends. It runs in the UDC interrupt thread with the
> controller lock held, and the SETUP packet it is waiting out can only be
> consumed by that same thread.
>
> Seen on a Zynq-7000 (an ADALM-PLUTO class board, PREEMPT_RT) during the
> host RNDIS initialisation: the gadget stalls the GET_ENCAPSULATED_RESPONSE
> poll that has no answer yet, the stall is refused, the interrupt thread
> spins for a minute, RCU stalls and every other USB operation blocks on the
> lock. With a bounded loop the condition shows on 1 to 3 percent of boots
> and is harmless: the pending SETUP packet is handled next and the host
> repeats its poll.
>
> Retry for about a millisecond, then warn with the endpoint control and
> setup status registers and return -EBUSY. The callers already report a
> failed stall.
>
> A loop timeout for the same hang was proposed in 2021 (usb: chipidea: add
> loop timeout for hw_ep_set_halt(), Jeaho Hwang) and not applied.
>
> Signed-off-by: Mario Behn <mario.behn@gmail.com>

[Severity: Low]
This fixes the unbounded polling loop in hw_ep_set_halt() introduced with t=
he
initial driver.  Should this include:

  Fixes: aa69a8093ff9 ("USB: gadget: MIPS ci13xxx_udc")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105205343.9824=
65-1-mario.behn@gmail.com?part=3D1
