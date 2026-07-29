Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFEC39795A
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jul 2026 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335989; cv=pass; b=YSDE4Vo1zYhoMpNqChFWAI93bvDYHuVXeGkKuQ7ybiFSLEv2U05LNrt7xLpVlRyvfGPBwS8H3GmgHobzsCN+ODEtgvGAdjm86HbwgE1+VS8ovN93afoNLUotzMrMkccUKm011WhkwCjakunOJZzDPHj12eFLaUd/nBGLkTIB91Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335989; c=relaxed/simple;
	bh=cIN/nt4h44AlqFXT+2f3q6mTYeKxvBMsv8hKikFaCh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tv52LQWZRq1sL8hqGlxktZd7QLtCluQj0T3rmExV4/EUiMAPlW+Ae1ZnMfedrHOckXCFwGspxIpL3hual/H6W7lK5z6iIX5silZyGkcD1YY4K0SrEyBi5lug1AV8bIGq7AaSy7phKtynbVyr796rX4+2Ho+v5ztT/HB8ACVD6Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5fcS0nA; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5fcS0nA"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso729052a34.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jul 2026 07:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785335986; cv=none;
        d=google.com; s=arc-20260327;
        b=outYFoKhCWPPN9BjZwQOW8Oahg/AsWNMi6Ke+x4Lshv3WjZbT2rPtECB31Mv6S7Vc4
         pbV5lhnsNJjxghU+7F93oTPPI89d8RafFtqU1TwY+G7UlAaBqBKeT1wCrt9WziFCBEyV
         GaQtvrkJrStzubNmim1SmiRxpBth8Twl3R8BCL0jZsqzxkgN7Pw8rGSYE/k4MknVTpT5
         //eGN11iLG9zTA/ge11IupCiz2yAEf5Ng8++0M9mUoe6oUA5Xqt86/ROG6fVuNCQuzYb
         m73L8i70blhIwXuxJBXVySrfLS1kP8w8zp+3HQhQWiyhf/7EFJ8E6+M1h2gsSUf6P8rE
         q+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ACwil4Mp6DdzMJNs08XWd9fqP5I4E2mCoEaZK3FvK9U=;
        fh=1CMoC5Ejdf5xV9xg3UfUHYPvm+lZ5s4V/LE7N2y9uc0=;
        b=aKXcTkqIbc1I8wkolNu7Kpq0fqygSYZ7GxmkGh50dW/aKJNBRjlV7uk90qDTeESc8J
         zdJ/jMsZijX+PP2n5zC31as3SHftB0MdHt3XTU+TVJdUOb0r4QVOXYxErZVv7w5lLIHD
         tbavHIJgf+QNyRHD1J6ZcwVRxvrJYm/RuNrBJNgikYRLeYZg5O7ywasG50V0QilS+n5t
         4n1OSElrIcLTV1jDysguFz9fjzwv5HiN7uSPrwYd7gJovTOzo4s+STerkH/Wp6TwOG+c
         c0tTvwxMiZzjqJ9bbh4+2wrWKbxEOrQBrrp/7xzxV8G7p0MswgV30jixSd0tgFKDc2Ek
         GELw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785335986; x=1785940786; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ACwil4Mp6DdzMJNs08XWd9fqP5I4E2mCoEaZK3FvK9U=;
        b=P5fcS0nAL5RQfbqieNnHvokbmCKe2QbKKwRc6bb5+Xl5IA5oMS7wO2alZgEIbB96xt
         f5uzvwprk9C45eCuJt4AtQv4OQzoekzjwObGvq5PZcpz8ST96Ts63cC+CMVL2+tUbwbo
         ZRyzniExipGvTjTN/NzEQOQFfesNGjIUMBxdZu5KHrEz0bGpze4FDXz9GvPaGj4SH32a
         OZxxW0th8jeSMCqwSkyqRYIHNgOBD3ki15N6lAEN8Xey19UhgisFl0FhsHei0k3lmGBI
         McLiRNlMCeBlphFrCL4WY3ZpKaJQ4tuclnp+bupYiMqA9a+5VAJAnMoR7lStVP9noFZy
         o8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785335986; x=1785940786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACwil4Mp6DdzMJNs08XWd9fqP5I4E2mCoEaZK3FvK9U=;
        b=E4Z5zB3Q2/CbqtKTqhDlUOm0Pgsr6xaxxtF4LajrKolN4phO0qTB85s+43PZLfMA8h
         set/SmlvAuZB+aB4jRJvi7vewD/OH5i8aH9sX1VOHop85Bz3UN6bZjzoznGQX4mzvNyq
         gdvmNldhlrt6U8szYNHuo/R8vXWDsTipeXOodGSOW3u7M/hbrbYDXuRuYh3RjKLfqli4
         l3tJfsh7h66oP+dHyE76wXx/kQptDtp4k4LCg6poj5XUYp6zkxxPdVv0fwO7ZGrSQCgm
         UD0qht/V99AmP2CugJm22CUdOljWaplwPjALO3kyZA73xtzUBRpW79K9+s8Mxs+KvSet
         p1Cw==
X-Forwarded-Encrypted: i=1; AHgh+RqeSdj0q9FOCsaVyCuNta5tj/gvbOYe/PElqWgz9SZ7Qk45T1PovHPyh5OP95q45F1larvGBbB4oIu7NpsWiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywx4IwPAUhmeoze83jpI1vSb3o7SkFPNBuR+tP8AKMTg6rP4Hxh
	Pa8KIqQcP3pA4aEmjyxTXKIaYgYvUatlS35yxNI0UsxY4DDJjholq/ijKmzDjBu1TllqW4QjHj9
	0f9UrdDTzhMAdsigftFg7txeRqJLHXFE=
X-Gm-Gg: AR+sD1357u/dONbJJlekXRwQG+GVbkYxRWCodeZHXVlDN1amvMNYmwipdP0Oknwe5aV
	eWhk9wbYmWostFEb0CRpjZt0NyJqm7jVmJM2cc9Y+goqZ+gXvXebrndU81J5bubTZKXBduh3H9L
	by9WI5dPunio9MsIxgsPwr8+4ULp6iiJs+b/KAbRLDFizF03E9M95tRu3aMUxKBJzAD0acR16vG
	VDtiiAirRQ6l/ohjCjNOZ2wD9e/Xhrni12+Fe2hF7peViHKExVYHtzWJICiMeHlq+ODO1dNXnHb
	hIXM4vqW8uR8J0z0NB1pSLlSbA7GTEBkBPR4XQlHBW5MdGI=
X-Received: by 2002:a05:6830:2696:b0:7e9:b673:cbef with SMTP id
 46e09a7af769-7efff25f6bdmr3854282a34.17.1785335986490; Wed, 29 Jul 2026
 07:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260727105059.75716-1-spasswolf@web.de> <ef1bc3d070c4156f1811c0c4a567ec98ac8fadaf.camel@gmail.com>
 <1ead313022bc62dce1f42af9f855727eb9074443.camel@web.de>
In-Reply-To: <1ead313022bc62dce1f42af9f855727eb9074443.camel@web.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 29 Jul 2026 19:39:34 +0500
X-Gm-Features: AUfX_mwXyEa-LkEfVk4HaieHl5UbmaG7Jg2hW7wYSg6MeyPwuqLhhMt1G3fmyMg
Message-ID: <CABXGCsONHe2ST-==Gso2748i7W_POPiUAF2MrrmTuqoQr7z3gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
	"# = v7 . 1" <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Rafal Ostrowski <rafal.ostrowski@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:36=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> I did try a different approach, using DC_RUN_WITH_PREEMPTION_ENABLED furt=
her
> upward in the calltrace (This would have the slight benefit of more code
> running with preemption enabled). This does not work because dml21_utils.=
c is compiled
> as a _LINUX_FPU_COMPILATION_UNIT, so DC_RUN_WITH_PREEMPTION_ENABLED does =
nothing.

Confirmed, and the chain is worth spelling out because it is not obvious
from the call site:

  Makefile:1127:      CC_FLAGS_FPU +=3D -D_LINUX_FPU_COMPILATION_UNIT
  dc/dml2_0/Makefile: applies $(CC_FLAGS_FPU) to every object under
                      dc/dml2_0/ ("Add FPU flags to all dml2 files by
                      default")

so both files you tried are built with -D_LINUX_FPU_COMPILATION_UNIT,
and in that branch of dc_fpu.h the macro is:

  #define DC_RUN_WITH_PREEMPTION_ENABLED(code) code

What I think is the real problem here: in the same branch DC_FP_START()
and DC_FP_END() are defined as BUILD_BUG(), so misusing those inside an
FPU compilation unit fails the build.  DC_RUN_WITH_PREEMPTION_ENABLED()
silently degrades to a plain call instead.  It compiles cleanly, looks
correct on review, and does nothing - which is exactly the trap you just
walked into.  Making it BUILD_BUG() as well would turn that into a
compile error.  I can send that as a separate patch if AMD agrees it is
the right direction.

This also explains the asymmetry with 183182235f6d: dc/resource/dcn32/
does not get the FPU flags, so the call-site wrap there expands to the
real thing, while the equivalent wrap in the dml21 path would have been
a no-op.  Another reason to guard the allocation in the callee, as your
patch does.

--=20
Thanks,
Mikhail
