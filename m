Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5D38F620
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Apr 2026 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722239; cv=pass; b=MrUYb7Ced/QuXgtjeoP13k/2XLtQneL1Sl4XCGApeJ7ooD+NGpLuUZU6Q8+KvP8axkQNMM00LpP6BrvhB8VyollfmuSYKTT+Fb3wXU006DtgEwxy5YvVXxlSF5MxqzPQSPdVqr37cLOBp0anTwzYrF3yPiY9Up5wUU5pU8DT38c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722239; c=relaxed/simple;
	bh=v9QIYML/zg/aOAPCJtSeT5qfEgNWsyXfyw1uy75N0TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jj68NDeXXFRXEkPbxauT9b1csnjOn5zniYNF317EKyUpMhqXJk+p7Z4CXJ93xGQT8/NisWNCtuyZyaGEzd//sM+tYhcbUaEyHGfphgoCi2UukEcTdasPrCoE9lBFTTeYzjlrIcnDT4YW5U8Fn71V8ibeeouFFOi+kNbAe+Qrb4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbRREjER; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbRREjER"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b3488fb31so6849791cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Apr 2026 01:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775722237; cv=none;
        d=google.com; s=arc-20240605;
        b=XSfCN6ICM9wkeyfLvqfVmZLq2rirU634MWjuEjsLOGA8cr75V57GtZ0isl18T+aKHN
         0at1AbJPmVy3kU1k0JgX+rciyrzfdtFM9a/B1g26bgUApIke7ZDzlCvP9YyUjL5sp847
         8b4e8Stoo6zRsunjR+bOhvutzvrj7sfR4S8rBKcD4egV+H/bQrfnaFPJWykjUGtMphcw
         pSAskGhyDKJXHVqWugAR5wd2HLShkyXx85ZYNH7Fbd4AhUqmac1xvO1tj3CrUshCTShx
         DfnTQgo7o86PrKRdCBaLYV+Oa64HD4ETRSNT8EtGUy+WPuY0ituAJ/lR5OtM3htv77cc
         GMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v9QIYML/zg/aOAPCJtSeT5qfEgNWsyXfyw1uy75N0TI=;
        fh=+zkozjRWCCRq9Alg3+6IxlY10lXESul//x52KrLE5sk=;
        b=DwM56mryr/Ky7XHj14WjvJEQaWhUM8z2wbIVTRtQGLhfBTslTSj0oWGcqvTFNLA87n
         Ps3pW1gLkJ5igRBzK6uzaU9U3yuURgJ1Yzr93NxpxIVzrcXzriTmKkwEZiZGEyZCgkqU
         W4diTyCUpKfxDfKyZy8BT0p1XcuGEzyl2jAKKMmfO2PbOnvPW/bK6Szeqee3qMGGS4Zn
         i6wDOAnPt4W9SeKCMFYdoeG94EYX8itYndmabtNaKPs+8XoFYXI/g0QMPm1bci1esN6m
         reqH6y17ihzhRht8IQetqGd4Jx6HgcgxYJEAJ+4muEWFBhRer8J65WF04ztHrn8XqIz9
         s1eg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775722237; x=1776327037; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9QIYML/zg/aOAPCJtSeT5qfEgNWsyXfyw1uy75N0TI=;
        b=YbRREjERNslcRKJKBJ7EAOGun8RcHym4trKC3l/IBzVz//5hbTsUb16NT2ga9mYhUr
         5tcSCaQdt++hk9I+rDK0xwJK8OBwtkojSH5xd3assE2uh9z5IJMQNvNvZw2ieClTIUim
         GM9JXypflGIFu8ZfftthUvxZNuSGY4/wuyFf+UB0KrQlIl14BniyzsOSu5yUXSYe3V96
         mOWDbLZWMGKcSm7GUB1KlYYx09JosBzAmIBoEA5Ee4NMNGR9IiQ4dpgnuQGk6QoDq8HN
         fVB8F4AL+MJtw37GEEBQsC0j0513YyWcjKQ2v3suSjcCchIlxNHWN+D/PNnuQxAwNL+S
         lYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722237; x=1776327037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v9QIYML/zg/aOAPCJtSeT5qfEgNWsyXfyw1uy75N0TI=;
        b=D4U8YuLh+Bd9Wuvcr+siU0ivknYhb4Np8p0dLPnR51XkdQYiRfhbyH/CxF80fGxABg
         +bIkiOAG0gzg6l+UYqBQQfm6g5tus57XDCfwFfJyPAwCadPLUr9PdefV7SwgBQFYunFi
         a7yiCgTdOhiRK7OMtz1I4G70n8z7CAS9LwG+dGMphFOAGSCmIMwlrWgxIVqOi2/b7fwI
         EoitwXDSTA7cddJL3NvTl7CTLfRaGOOXx54YuoVLKQxb3drHo7DmlFSl2q+z9EUwkdc+
         lDtV3bkxrAsndIZZbaWuQRRF/e5Sf7JgvLmcMYyYwTcodEGqSPFXnUvKau5kFX23vM/m
         fH2g==
X-Forwarded-Encrypted: i=1; AJvYcCVLmyQgnQGosHQ6Z0Vczvv3eoyCuKb9U1mP6/LPt3dMG+ny5UQxXMmR3ZgUnQwUFckwrwyNDxt5kpVVt7719Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz392SOKqfZAS9sUr9BhYzwi0Oa/5FNByZYQxPypyz+zTIHs7YI
	rVPr2YbAjBzQvG72C30BM2paYkdYEQArTyaPtg+tx4mjCsLnVs+QSZtEtFxLKGvoN2KN013JekD
	20ZfDUstlP96KIBcCmA4Xv/izdKYhl9dNjZS6cHed
X-Gm-Gg: AeBDietkjp5eSBM97sJe5GNn2KqaiP+X1afU84aWxtoff24r7PWL03nntFE4HuvEzLv
	Z8xUtQQ+SDuoZmkWgDVV6/ozLRy3rNVALtTS+pxcIdmiQFsn7QjTpQTsK9BZPginTK20QUA8MBW
	1Qcx1pRKpUUl1Bk54k/Wg4y1f9rtBAEDbq4ZdFG5ctfoiHGB+l258PuKQYT5UZBY1v0zeJMXiL0
	NU9p/vSo37iDd4/SEpSoHsWmAgeTRHxHf0Qr2Ni1qg6wxEpzpDcROwUzfDZxUFdy0nSx3MhZd9x
	K9SP/9v4g/oTMtvUDg==
X-Received: by 2002:a05:622a:1b15:b0:50b:2542:e16f with SMTP id
 d75a77b69052e-50dc1a45100mr30831291cf.15.1775722236548; Thu, 09 Apr 2026
 01:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260409035344.214279-1-jiayuan.chen@linux.dev>
 <CANn89iLEpVVo=q4FPpBQ5FomoLmdrfW3su7Mb0ZES4EV9=Q4xA@mail.gmail.com> <8c761de0-4d8c-4b2e-89a6-80f12016fd78@linux.dev>
In-Reply-To: <8c761de0-4d8c-4b2e-89a6-80f12016fd78@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 01:10:25 -0700
X-Gm-Features: AQROBzCBtDoZDHyHWUXGSZbLoakt6E4qIMNHHWibRdm3YQM3Mv3ItHOQNXPah5g
Message-ID: <CANn89iL5=jdmPayGiri1O2P9CYANcq=mNF4QE1-4eSmMquZb4g@mail.gmail.com>
Subject: Re: [PATCH net] net: fix __this_cpu_add() in preemptible code in dev_xmit_recursion_inc/dec
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 12:50=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:

> Thanks
>
> I checked all callers of dev_xmit_recursion_inc(). Most are fine.
>
> The only problematic ones are iptunnel_xmit() and ip6tunnel_xmit(),
>
> I think adding guard(migrate)() at the top of both functions is enough

Seems fine to me, thanks.
