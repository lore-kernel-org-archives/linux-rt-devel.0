Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92781A9F90
	for <linux-rt-devel@lists.linux.dev>; Tue, 28 Jul 2026 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199921; cv=none; b=BcWQOsLpZH8TBU8VGzZkm8p18jj987BJJKNIVBAkDnwkflOp5zeLqvm1jhD18kmB65hXyZUCUZ9epJZr8I1rVfBHGrOKebDUnIsDa4dG6RedT53LDy9ROolgUcdZuIgUeDF9Y3GtWcL7ZWCIL3atjQG6ywOMfdZCx8PA+/H7LIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199921; c=relaxed/simple;
	bh=Z5GRTOSO0S9G9u7VZF3YwLNRY4a8OnVa7f57JM8Jl3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bc+kRma9EOJ6i1Sasxm8Whn+jHF+fqgtiHjn3Vw3aaWSng2NiRyKfXpQs7AsY8jEXCcGngjjsvY7S08G24vFoFY8bVzHoZnaT+WvRP3PtR9Tft79pDFUZOzXWV4X3+G02gMoC5bDN1CULLdW+/j6sljvecGJYTMDh0aJ0uW69Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIw02T2K; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIw02T2K"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39d4c864bfbso28466551fa.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 27 Jul 2026 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785199917; x=1785804717; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YyiWxM0l+pV+N+P60T/IcxD0yZfdk4dsxpPoSCJ6HvA=;
        b=MIw02T2KlDlXxIo+A2/dbUngVa34PrFarsQWo/rAZEzbLJF9ina8MzAtp7URsL9mqy
         DiB485LYVOd1doXqN4BbfL8kcLPCKNpQAqA4Nx2m0z7xTamsv5mG1wsFnv4fe6s/nrfu
         NbSt+vKXv8NaYMNpFQ8kjbIoBrynb1CkRx9n8W5F2iNDvTGeuWrBkqUtdF00grW3ORgn
         hABFKTikvm+dHKLfJJwVEJduRrtfKMNaF4qx2U7By8qYt2K4icg3ueiUZGJ47aaOPa4s
         oIogsZPKC6LLY+jdCcyOd2FIJ2S1fMMuhOJtSM/Y6Iziw93F0F0RullxAPripYhql4Xu
         nzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199917; x=1785804717;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyiWxM0l+pV+N+P60T/IcxD0yZfdk4dsxpPoSCJ6HvA=;
        b=R++dlW6gIWpgTJu1hCEKR1aUNpZBRGEpMyUWzPLxlD/4cshrZmFMr880lfuM6d3xyG
         Uumtv/1//PGKfGCUAx1q034P+9yjFXD0dfYLSSMFLJk1jvuApsjjSxnmOF7NEWcChLy9
         r95T3wW/pQybELngm/Lg7Ws2nDEnQmD6G29Qpepi4JJ73G/eyug95Ns8ZsF3MabyFx9U
         t5mM7RJbJzS2528Ax2mkHIyJM98QdUdy2lgPg7KRSd5KaSoYyWI2LJPEu06uX6G5Hq7w
         KKmLdB/w7ieB0hgux+hdV7ThGRLiOTzxPVLnXaDDFpKKr2dQGSEwR0MQ4DfLnRsnVOro
         n3Ag==
X-Forwarded-Encrypted: i=1; AHgh+Rqwp0jLQH56GcfEOuIMKxYZ5Qrs32p6IC3Y3vLZOonBNUvP/ZbubMrbLYjdz6GgNMDijxrLQV55IHs+N8zAVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YydSA3B4Inl1jPwWq+tn0zQkWwv3YYHeNvBXP2zptmO5vq0RrRy
	hCqdBWgbPcBfiBkHAtnbF8W4zRfmLQxKPqIh+h4x1dspJU3bYPUHkcKw
X-Gm-Gg: AR+sD11PT06z9OruUDUTJlnG6IvibRgZSF45x1WmLcFRTo9+RxT8NG8l2bTj5jezKsG
	PZ4tv7obq1+KfP2pooomebnMBg7OBT208mdHoaziQ5qj+XAblHmGla2LMnhgjeJrsaXJLWwvdJ1
	kAdOrHbbn/GtWRZjZHD2KHIEhdJ8PL0ehex4qqFHuNpSEhBOIYwEGhrjMF94PbqDKwnAPI1s91s
	76/WdTqJP/zNZsj5O04Wtmpq/9007y7yxq/O3NMlyLHEFiRqU0epeIJtI+P+tHEhyaPKr+xbw3g
	Q+SVSCHqC3m5yjK9A6fLbIukrXHmbD2YpZjTw19YwOFVj01ZOE7pelLeSh8c1jBFGGqhp0y2cZF
	hAU8wPDbYYcAnGb6gEjLlEbx8OzU/4fz4sbcq96DTuUepZj1uPb/yzFRi99zvcp8BwC+e5Gk6gt
	jcWlz6/WCvRvyU0f5zqmOx
X-Received: by 2002:a05:6512:3407:b0:5b0:197b:9811 with SMTP id 2adb3069b0e04-5b2d023bef9mr31905e87.53.1785199916589;
        Mon, 27 Jul 2026 17:51:56 -0700 (PDT)
Received: from primary-ws.local ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be077c14sm1758822e87.1.2026.07.27.17.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:51:55 -0700 (PDT)
Message-ID: <ef1bc3d070c4156f1811c0c4a567ec98ac8fadaf.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
From: "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, "# = v7 . 1" <stable@vger.kernel.org>, Alex
 Deucher <alexander.deucher@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, Mario Limonciello	 <mario.limonciello@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,  Thomas Gleixner
 <tglx@linutronix.de>
Date: Tue, 28 Jul 2026 05:51:53 +0500
In-Reply-To: <20260727105059.75716-1-spasswolf@web.de>
References: <20260727105059.75716-1-spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.61.1 (3.61.1-3.fc45) 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2026-07-27 at 12:50 +0200, Bert Karwatzki wrote:
> On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> converted to rt_mutex. dc_create_plane_state() can be called while
> inside an FPU-guarded region, resuling in "scheduling while atomic"
> errors on PREEMPT_RT kernels.
> =C2=A0Fix this by calling kvzalloc_obj() with
> DC_RUN_WITH_PREEMPTION_ENABLED().
> Also fix the error path in dc_create_stream_for_sink().
>=20
> Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC
> - Part 1")
> Link:
> https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/
>=20
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
> =C2=A0drivers/gpu/drm/amd/display/dc/core/dc_stream.c=C2=A0 | 5 +++--
> =C2=A0drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 4 ++--
> =C2=A02 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index dbc12640b01c..4ac835777b58 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -233,8 +233,9 @@ struct dc_stream_state
> *dc_create_stream_for_sink(
> =C2=A0
> =C2=A0fail:
> =C2=A0	if (stream) {
> -		kfree(stream->update_scratch);
> -		kfree(stream);
> +		if (stream->update_scratch)
> +			DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream-
> >update_scratch));
> +		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
> =C2=A0	}
> =C2=A0
> =C2=A0	return NULL;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> index 88e825a6582c..d5c6427796b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -85,8 +85,8 @@ uint8_t=C2=A0 dc_plane_get_pipe_mask(struct dc_state
> *dc_state, const struct dc_plane
> =C2=A0
> *********************************************************************
> *********/
> =C2=A0struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
> =C2=A0{
> -	struct dc_plane_state *plane_state =3D
> kvzalloc_obj(*plane_state,
> -							=C2=A0
> GFP_ATOMIC);
> +	struct dc_plane_state *plane_state;
> +	DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D
> kvzalloc_obj(*plane_state, GFP_ATOMIC));
> =C2=A0
> =C2=A0	if (NULL =3D=3D plane_state)
> =C2=A0		return NULL;

Hi Bert,

You may not be aware that the same allocation is already wrapped once,
at the dcn32 call site:

  183182235f6d ("drm/amd/display: Wrap DCN32 phantom-plane allocation
in DC_RUN_WITH_PREEMPTION_ENABLED")

That one only covers the dcn32 DML1 path, while your trace goes through
dcn401_validate_bandwidth() and dml21 - so wrapping the call site could
never have caught your case.  Which is a good argument for guarding the
allocation in the callee, as you do: dc_create_plane_state() is reached
from every DCN and both DML generations.

On dcn32 the two wraps now nest.  That is harmless, because
DC_RUN_WITH_PREEMPTION_ENABLED() is conditional on dc_is_fp_enabled():
once the outer instance has left the FPU region, the inner one expands
to a plain call.  But it does make the dcn32 wrap redundant, and I
think it should be dropped in a follow-up now that the allocation is
guarded in the callee.

One thing that may be worth adjusting in the commit message: this is
not only a PREEMPT_RT problem.  183182235f6d was needed on a plain non-
RT x86 kernel. There DC_FP_START() takes fpregs_lock(), which disables
local softirqs, and dc_plane_state is around 335 KiB, so kvzalloc_obj()
falls through to the vmalloc path and hits BUG_ON(in_interrupt()).  So
on RT any allocation inside the FPU region is illegal, while on non-RT
it is specifically the large ones - two failure modes, one root cause.

About the FPU register question raised by the review bot: as far as I
can see it applies to every existing user of
DC_RUN_WITH_PREEMPTION_ENABLED(), 183182235f6d included, so it looks
like a property of the macro rather than something your patch
introduces.  An answer from AMD on that would be useful either way.

I have dcn32 hardware here (RX 7900 XTX) and can test the patch on
non-RT if that helps.

--=20
Thanks,
Mikhail
