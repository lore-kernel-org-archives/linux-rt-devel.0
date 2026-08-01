Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D13624AE
	for <linux-rt-devel@lists.linux.dev>; Sat,  1 Aug 2026 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785579439; cv=pass; b=Qm795duHck+TNrBOY5ogl2thGbOZXrCJX1dRGRLYzinAYimq7bdV1aKZTd8D+cIOzkDheGqcMk7ZyCDgFpfpjI/+F+7ESzgdesjcxXQaXyNFMRhDFYnbqgdo42h/DSUyqWRzACyzQfqMGV7nCZLe7zGKwb62z7Blp9rAFpGdqfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785579439; c=relaxed/simple;
	bh=fYuc91yYvMFDE6497qhGMtUAgZbd6nA0KxrauEEgHMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9JJYu4uH9Vd6crrC6gVcGC1OI5wGGnSux5mqd2jIQ4BY9lhpbS+OzH6H10mc1JXTQOZv1x7Vn5bQFP5ib95aZ1h6KRSUNGmeWPKSmAIgzzrnpuzfzFOGomY2Q9+33DWqBlB+LLFoJbbyV99KkLvfKhHEzZcii3sedsFa9161UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3zF/w3k; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3zF/w3k"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6b554044fso1604351a34.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 01 Aug 2026 03:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785579437; cv=none;
        d=google.com; s=arc-20260327;
        b=l7Epxf0kVKvNGk5EUVB7dxFoQGgsxZr3yaT+LZJ/hmU6ZLarM8kFgRC3hjyZlZgy2v
         JP8UDX9dMrQXwsIq1Yr86fpODJHAoVF8irMReakN4qqBMxfWqLKukLeSq7rhX+GM6dct
         SIPuupb9xbos+BKyAJTZz4MQMFc3wsn6X2mFwbBXNHIDSdwjgV5rd/Gp0HPCk8DuPks/
         QqG6HCfro5JRazdfcxIPbUJzpomAPBhVyo9aZC4PbCOSkl48CU3wt/6oWWR6uzORf9QM
         uXgCkFXTKrlyMHGjcuHQrX3yyrDUuZrIXfSZSSWJ+TxiMpktIyfBAZoH1JlT6VK+oH5M
         Kapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6SVVCVf5N1O+YrNArJsl/K5UcjWXbA/FoyoLNaVP5k8=;
        fh=Z3LD87kjfOMHNQAwwzJIG28UFVIEmjCgEXjil0DrSrk=;
        b=qii6K48nsk0cfA5TnwUlhic0e2dgio9PdKfqjl+5VxelFaf1VVhs0cn6S3ZRRKBxEa
         XBjnhYNicehEB+AOtmYlWhnD+gF8H2JArSQUR3vsh8j7NS56Ib/F3fcKfNc3x3LubtkG
         PwVPyDcAgPrCiH/zwx0jE+vPOsWFHz6PhQhNBlitL+7OnMJfhJzX//TQnT81qXZb9tTX
         2nhGEg2Zw1HMjA+KN6BtwdqmlHoBe4HT7bOhtLZRrDXej/vpici6vCykcYWPX8j3+1Ch
         hyejM5nAg5R8bMRCY/NETDcnrwEyd+CeI1kvLW1YS1C8ZPgyi7kriQQyqJEs5F6WZeVA
         67/Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785579437; x=1786184237; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6SVVCVf5N1O+YrNArJsl/K5UcjWXbA/FoyoLNaVP5k8=;
        b=h3zF/w3kZhz5rPB1bLtG+yzjy8JqtJ+pBXcP3mr2NkK+NryNRbwPN42adAStoUQdVv
         Kd6PtnAcISIhq3Sj545UsVB140bquv8bNTKPrYOFBiQlkcELoRT0cYk8XTUznyTzRq3X
         Kf098CKNPcjSWTwc3oQ+lFpQE+Nxa0OqPQfodR5OzTRKI+VLX41Uv8nTHwdG847BtFkA
         x4kh2tmbySurg7TuFh2pRq1BliVJEmUkK1VKcBHja/FzG1SVkQkOVtxoDZVI76/TGJp+
         d9WOuvelH8cdgHH1RCc5m/hovUqH1VViyxQLZ3TRxYOWQpL3UG83cyDOFtNRM+2J00WQ
         wcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785579437; x=1786184237;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6SVVCVf5N1O+YrNArJsl/K5UcjWXbA/FoyoLNaVP5k8=;
        b=Mm823sYkluMa7ti2vGA9OYB5wSYd2ZFYClwipGG8EikgaINEwdA5baypObpvlBJ1dH
         WlMqknO7bY3z1YZuj+vmRGYpyXMz6EpuPBmIL9Yos2BwkIdDgw7PY+nGOwKK80e+V8jV
         p7JAlkBnBU45lo/pY+XohXgD4QCghtKIbvUHGgW2a1YFCX7hmv6iRKbzu/DdKOvLwylg
         4mcISOZyg9bD+HQSIkdpztrYhSoaTZZNie4I169ovuzsWamuQ0XrbkfYS2ZCV2jh2YYe
         9Zd/9382rPXJJv3Du75futv4hzhTJemnuKhDmtOkGFImdY9NaUYgzmA3ETw3V7LkSFVx
         iOMA==
X-Forwarded-Encrypted: i=1; AHgh+RrUEasZmhdF28ecR5oGKcUPvfmi6L2Z2sU1cZxsqce59tfZt3E+Z0uOW8MOl2o1mdzKtAVpETiDCB++ydsa6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+wFyxLwjWYTlcFt4Kf5C+srADXQrOrzazBS6CbtlBPCNIiY1F
	xyMpuwcixav4G2G3l+8/YgKxSnF2YDMyVmTwRN1PcA69pa7OjYgfecO4zU2bIJ/sumWvcRF4K6v
	7DRj2ac2b0W7cWwNxIsUuGS3Gi61KAZI=
X-Gm-Gg: AR+sD10pqHzxbi44Gv+Q3VrjZlAUDkJN2ET7rj63N3Wc9ZknQY0BOH2DEKH12jgFmwT
	vnsNwZSRQK1xSTRADFZdv9d7licVMb9HwAmdUZaC6g0vPHergcgbAp1ZLC4VL2lylu7VtTgQvZH
	D8dq8XLCS1ZeyGeW/mPVvR/RM4P3kas16tGzRQIe9rP+0vt3KSf3eZ6vHsbtxaC9F9JIrw9Knei
	iUZ+w9wwNt7RbF5JlhlTOAsBmKz5YysPiEYxjw5qzg2c1oCV5vNaUTEhmONOaemnAuhnTSYNKuw
	dDyVai4eXroWkk2dO/yshPpsuPWMyCATl3e+CJrnLHYB6g==
X-Received: by 2002:a05:6830:64c8:b0:7d9:7201:1acf with SMTP id
 46e09a7af769-7f196d407e0mr6475364a34.5.1785579436652; Sat, 01 Aug 2026
 03:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <df5f0d9bb8f11d098f086bd2ace5aa0cef4c77d7.camel@web.de> <20260801071724.12998-1-spasswolf@web.de>
In-Reply-To: <20260801071724.12998-1-spasswolf@web.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 1 Aug 2026 15:17:04 +0500
X-Gm-Features: AUfX_mySPDS1tX6sBksLt_ubqUTn6yupd7v5vPVdQi51p4TGShRSsHENrQ2zzec
Message-ID: <CABXGCsMFa25HyOdcSX8QR8_=58=uJT+HMVhyus=rOFHBML25=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
	"# = v7 . 1" <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Rafal Ostrowski <rafal.ostrowski@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 12:17=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> converted to rt_mutex. dc_create_plane_state() can be called while
> inside an FPU-guarded region, resuling in "scheduling while atomic"
> errors on PREEMPT_RT kernels.
>  Fix this by calling kvzalloc_obj() with DC_RUN_WITH_PREEMPTION_ENABLED()=
.
> Also fix the error path in dc_create_stream_for_sink().
>
> Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - P=
art 1")
> Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de=
/
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c  | 2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index cdcf140bc1bb..accad9e20e88 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -229,7 +229,7 @@ struct dc_stream_state *dc_create_stream_for_sink(
>
>  fail:
>         if (stream)
> -               kfree(stream);
> +               DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
>
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_surface.c
> index 88e825a6582c..d5c6427796b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -85,8 +85,8 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_sta=
te, const struct dc_plane
>   ***********************************************************************=
*******/
>  struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
>  {
> -       struct dc_plane_state *plane_state =3D kvzalloc_obj(*plane_state,
> -                                                         GFP_ATOMIC);
> +       struct dc_plane_state *plane_state;
> +       DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D kvzalloc_obj(*plan=
e_state, GFP_ATOMIC));


This hunk breaks the build when CONFIG_DRM_AMD_DC_FP=3Dn.

dc_surface.c gets DC_RUN_WITH_PREEMPTION_ENABLED only indirectly, via
dc.h -> dc_types.h -> os_types.h, and there the include is guarded:

#if defined(CONFIG_DRM_AMD_DC_FP)
#include "amdgpu_dm/dc_fpu.h"
#endif

With DC_FP=3Dn nothing defines the macro in that file.  dc_stream.c is not
affected because it includes dc_fpu.h directly.

This is not only exotic architectures: DRM_AMD_DC has

select DRM_AMD_DC_FP if ARCH_HAS_KERNEL_FPU_SUPPORT && \
!(CC_IS_CLANG && (ARM64 || LOONGARCH || RISCV))

so an arm64 clang build is enough.  On amd-staging-drm-next with your
patch applied:

  $ make LLVM=3D1 ARCH=3Darm64 allmodconfig
  $ make LLVM=3D1 ARCH=3Darm64 drivers/gpu/drm/amd/amdgpu/
  dc_surface.c:89:2: error: call to undeclared function
    'DC_RUN_WITH_PREEMPTION_ENABLED'; ISO C99 and later do not support
    implicit function declarations [-Wimplicit-function-declaration]
     89 |  DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D
kvzalloc_obj(*plane_state, GFP_ATOMIC));

A plain x86_64 build (DC_FP=3Dy) is clean, which is presumably why it did
not show up for you.

Adding

#include "dc_fpu.h"

to dc_surface.c fixes it, and matches what dc_stream.c already does.
Please do not copy the local fallback that sits below that include in
dc_stream.c:

#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
#endif

It is dead code there - dc_fpu.h defines the macro in every branch - and
in a new file it would compile cleanly while quietly doing nothing.

One unrelated note: you kept Cc: stable # v7.1, but this version is
rebased onto next-20260729, where the update_scratch allocation is gone
from dc_create_stream_for_sink().  It does not apply to current mainline
either, so older trees will need a separate backport - worth saying so
in the commit message.

With the include added I can give this a Tested-by on dcn32 (RX 7900
XTX), which exercises the DML1 phantom-plane path rather than the dml21
one you hit.

--=20
Best Regards,
Mikhail Gavrilov.
