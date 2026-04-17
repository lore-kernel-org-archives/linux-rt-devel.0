Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B932E728
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Apr 2026 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407442; cv=pass; b=Yktb+kBYs5J14kQCtWNe40p+QkBS1Hm7kPFaxoxbD42vzdrevvsRTziBwNgBvbog2+M8ZmRprUWX/pUumAuhiXYFXNrJDQRLcItpq9CFfYT5+k6aYxHT/LOZjgHWvqFZRu4kyrAe1djewZqmIGFMCaH39GqlNH2SbGHz7To0BGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407442; c=relaxed/simple;
	bh=eQjf63Fv03/lLp1JyzRkc1/XN3bTfq1vV7Et2P8WcaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2G6MCN5PmBdI9o4WJtrrbHoSw75ysm5ZZTv4DXgZIqxYpFZTRcV2AfbGqC9ugyIsTDdkHjCRGRT3a0MTM3UnEW1rGQhYhDh50Njo9PjS+9k1aB6qT+Ivs44RS0bV1MdBjSiahyJvPAyN0UavDPVIUdjDIhm7lCtQmOZM2Yg/y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCP9gQxs; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCP9gQxs"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so353959a91.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 16 Apr 2026 23:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776407440; cv=none;
        d=google.com; s=arc-20240605;
        b=OY5jRLIx1uXi82oR3dYgb0A0WjRGRmW1FMVXtQb4QFpYHkfb8RA918VdTEc5nIOOjX
         Rf3wdu6+f1he1NgurOYg0jJ9OGPn6VTtCcbn7PlpnDcgPkzFr6pYvmE0GjuOLGddPs66
         Nuya6Vv4xp+zpmB/kNu/dOYsaoVpfgin/i2DlvzDDOmH7Ucv61sNvQo4L7cRpX5nLYaE
         bx+xzMaRTmcce5/kHluGrEF4/qIy7XzLaxSoF44ctik1dKLocnKT1w3rvKUSj3VrOrVW
         7Gi/Voh9g8yBlaUiuzDTdL+F+KRgj99DZB/6tP5l2clAGOqRfxSGQDWBmIL1Ked9pMz5
         +HJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eQjf63Fv03/lLp1JyzRkc1/XN3bTfq1vV7Et2P8WcaY=;
        fh=VJu+dEMoHHUav+HCVWnoTafYiENUR+4ugBNwv5mQ8u8=;
        b=c0fliFjC1ukpVIc1THqfc+sULXRU8eYEdKZPB1clWR701JWXFSg8wRvL4NO4Xm+nLp
         MhqswgugcCkfKNF/SZy5Yv7brZF+/mIb8GU9F4ESK83nZikkGlgHlT8j6Uv6TsRHKdbs
         VST0nrUi9WF2WaeZXUxoqxsE+DudFIcZmmf2drmHGfcanSsT1L33luI9h0O5X/MproJ4
         lU2279oAc1m5rmxbcP4OzReL8ljnoOS7ACuFQJGr66Wqa6syItH0qTYhbG7CuJbdlAvv
         wLLPoz522sCpKKoeIFu3lp6B4uEz9Gm1B078Cu9xUvxbJcB1v2uGOgLAx9F/uNhT1Cw8
         84+A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776407440; x=1777012240; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQjf63Fv03/lLp1JyzRkc1/XN3bTfq1vV7Et2P8WcaY=;
        b=VCP9gQxsvxXm+EYDboKlvYNF+LzDfkwgmgltwbHZj1BPi3c7cHOLpSIn9NB95EkAi3
         ZWfQxb62zXDUfm0RNQ83127cnX4Qmx1KSQOMPUEbyKUF7NbBdBSwwbwpispy9qy6tHtD
         9vQKWWV0ogFWO7dB36cxFT+DkqvUOpuMa9ztnR4EF5lSlFko5VWgUrxpwwo8RNMJ1+P2
         vMblKIupsG5j+KhQ3cyRb4I5mvXIn10ZF2ZA4Tc0GIsNN3/dFabHFQnBCZd6729KcBU8
         psxlYl6q8v0ZpLKjnJdRyP4yMwFgEM14hDUCe3BBOWo3o7NKMM0cxRlI/b1iPondz2Vo
         FM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776407440; x=1777012240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQjf63Fv03/lLp1JyzRkc1/XN3bTfq1vV7Et2P8WcaY=;
        b=FAuHEz8oLxBpEpd/RFuY61ksm+HG4SbT+Oa4Usv1cX+XZnXNAfSJ2wcJOJJc7qGVEK
         XdsCV4fZaYINFow8R340guCmkN14PuUmlaBL8teWOJL0MvCcrN2uLKGcjqsxuOZ8IvJn
         7DejcsjYwcHmladZ7JESYMY1OJZEGUgvEo//JrN/fQO8MaeWS56zoLcqqaXdbfsJnVN7
         3pWxFG5FHe4Lju1TLGRHNj56W5dJBzWQxjvEQwnqLvY/dvLZttrQzTd8h01SmmHrqpx6
         C3lJDcIzDSsqo2aQcTd1yQrwu1ESQH+Quz1cb7kVBgKNySgKGeOQyHlQ9ppYgoh07R8G
         U24g==
X-Forwarded-Encrypted: i=1; AFNElJ/W2oJKDnkilPp/LJkPa7znjHOZMSvDBNW0er4PcFxemg4h4D5D8Tix6hnHBn7fGjQkApaqYNJEW5YpE2cWeg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywk5l7r5MW7jXxe3KH1Gy44WsYSUAKLm+gc8QxKVfnj+VQlYc8D
	7UoE6rt+bTCDvWjHi3OAtKOqSCTx2SfUOrpAkhUBiiU7b34SZ6YhamQZLNt4kvyq5BpzxkULOZX
	y23UpfHGvmJrXGK8xyHL4iSKuVpE7VcM=
X-Gm-Gg: AeBDies3KkMKdB/DHH9S2uwaNzB7tIksMGJ3klpZM8uFGm+d3oRWiiA+3rhpfKEL6/9
	XpQRIy5c2Ht7eI8ZGmum7pKeDoGM3k/SbSl1tvagb4JfXukfZzpzfcy/hOGtJl2qyPLFo1sEKTy
	D9rFaFU6+FQgEce6I+1xUu+04ZeYpWG5kFw7MweI19IJz8Rtoc0XloNQ/ov8LUM+CKOBIdUjlG4
	m95lLtMkRlNx+TWinfpBQP50nS8Vbvjg8owhsnmxov67hoVI4rZ49Vy3BGxTM5bG9eqIbLiGWeX
	nHlVzD2wkkZddOk/dgSfsJ256tX1fq8AINP76lFBrwXvdz0yRg==
X-Received: by 2002:a17:90b:1dc2:b0:35f:b306:5d47 with SMTP id
 98e67ed59e1d1-361403af9c4mr1787310a91.1.1776407438810; Thu, 16 Apr 2026
 23:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com>
 <ad539mUd8A0lDWAw@slm.duckdns.org> <CALP2E1xwgfNmW+u=oyQ6bVW0ZeuQRZK65gR5RXyQyzy1n6U_8Q@mail.gmail.com>
 <aeEjhTftzK_sjYi-@slm.duckdns.org>
In-Reply-To: <aeEjhTftzK_sjYi-@slm.duckdns.org>
From: Fredrik Bratberg <fredrik.b.bratberg@gmail.com>
Date: Fri, 17 Apr 2026 08:30:28 +0200
X-Gm-Features: AQROBzDycB-ddt_eDK_taw9Z2FZr9wIEEwxZPEGnQIUgQQDiog8oYYhEX0pTcXs
Message-ID: <CALP2E1wVZS-mRo3-Cdp0c0D0GSqv5rK-w2D3T0_sFXgwAg+AbQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: add CONFIG_SCHED_EXT_RT_EXPERIMENTAL to move
 SCHED_EXT above SCHED_RR/SCHED_FIFO
To: Tejun Heo <tj@kernel.org>
Cc: Henrik Austad <henrik@austad.us>, Peter Ziljstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, linux-rt-devel@lists.linux.dev, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:59=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> In the current form at least, I'm afraid this would have to be carried
> outside the tree.

Totally understandable. Thanks for taking the time to explain and review th=
is.
