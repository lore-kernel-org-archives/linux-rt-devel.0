Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025163F3281;
	Mon, 27 Jul 2026 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150678; cv=none; b=tW8NbeoGlJGj9T36vE2o3nknaS4qYJmszX2VwWWBMTeNHKa5M9NsmlNCeHI3h2UG1iG464C4C/CsV6qp2dj+1tDbRlU4Zx8bjctbBdvO7tFgpL2WREALGD/qd36nWvzyUV37GLGOJOWsrQgWQDWYHMJRgsMbIERZZI2NQmxfXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150678; c=relaxed/simple;
	bh=OKEalbowvVwYWYQ/mWx9qTlJBilPsjA/0F0pCI2xtck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DWgdE6rWxFlrJ1GyWg9KM2G1LlSkGBpt0ZuaTPRC7SJyljVOqYckyU38Si5UEJ4J80G//cP+nZFD13pwdJO6PYbSVamtBbXo3RxyTd3gUntE/3TrmVUrWQ/WJ7DgKd+yAn4qci9Odvm4wKbK70nyyzFlWQq87Sn6nUe2U966z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0yRteld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0yRteld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D26C1F000E9;
	Mon, 27 Jul 2026 11:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785150676;
	bh=jUOm4SpbPha8J4lwZkA14GyOsHkM+mjKZ4GXSYTtT8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0yRteldDlHUeuMmTMsvEBeMgxT1tc/X4lDpU4XbXjIBQR9qFwlUzls3iujesrRoB
	 WSxI1Z/kHK8clDZabd5kWeQF7tmlI1G3gZWus90TgKapqoyS+0TrY+R4T1aGnWssTt
	 0QlI0to8TUB5EFUVtMCnFpxTualDs+0SNZ9Qfcso5+Wrgf9f0ZoN7zwAqypY+M7e9q
	 9Yv3WEGH5h9kqt4sXhSCrApVkRhIA60ludQNvaLsADYFQRx9+P5lm3VQLVpgWyIHbq
	 9vcD5JeWRnbhb083ifxmUv7JsBX7jNdDE0kTqjxZvVDykFhE6RxhaQPM04Kmh+G5oL
	 HKncvuRSK04VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bert Karwatzki" <spasswolf@web.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260727105059.75716-1-spasswolf@web.de>
References: <20260727105059.75716-1-spasswolf@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 11:11:16 +0000
Message-Id: <20260727111116.8D26C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping the FPU guard inside dc_create_plane_state() and the erro=
r path of dc_create_stream_for_sink() corrupts callee-saved FPU registers o=
n architectures like ARM64.

Pre-existing issues:
- [High] The patch addresses 'scheduling while atomic' bugs on PREEMPT_RT b=
y wrapping memory allocations in FPU regions, but fails to apply the same f=
ix to the symmetrical normal deallocation paths (dc_stream_free and dc_plan=
e_state_free).
--

--- Patch [1]: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} wit=
h PREEMPT_RT ---
commit cf0d00c09a192f136eba5d73a1ff01aa518ca2f4
Author: Bert Karwatzki <spasswolf@web.de>

drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT

On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
converted to rt_mutex. dc_create_plane_state() can be called while
inside an FPU-guarded region, resuling in "scheduling while atomic"
errors on PREEMPT_RT kernels.

Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index dbc12640b01c0..4ac835777b586 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -233,8 +233,9 @@ struct dc_stream_state *dc_create_stream_for_sink(
> =20
>  fail:
>  	if (stream) {
> -		kfree(stream->update_scratch);
> -		kfree(stream);
> +		if (stream->update_scratch)
> +			DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream->update_scratch));
> +		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
>  	}
> =20
>  	return NULL;

[Severity: High]
Could this cause floating-point data corruption on architectures like ARM64?

If this error path is reached while a DML algorithm is calling this as a
callback inside an FPU block, DC_RUN_WITH_PREEMPTION_ENABLED() terminates
the kernel FPU context.=20

When kernel_fpu_end() restores the user FPU state, won't the floating-point
variables held in callee-saved FPU registers be destroyed upon returning to
the DML caller?

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_surface.c
> index 88e825a6582cb..d5c6427796b65 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -85,8 +85,8 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_sta=
te, const struct dc_plane
>   ***********************************************************************=
*******/
>  struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
>  {
> -	struct dc_plane_state *plane_state =3D kvzalloc_obj(*plane_state,
> -							  GFP_ATOMIC);
> +	struct dc_plane_state *plane_state;
> +	DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D kvzalloc_obj(*plane_stat=
e, GFP_ATOMIC));

[Severity: High]
Similar to the stream allocation above, does dropping the FPU guard here
corrupt callee-saved FPU registers?

When a DML algorithm calls dc_state_create_phantom_plane as a callback while
inside an FPU block, it calls dc_create_plane_state().=20

Dropping the FPU guard here allows the hardware FPU state to be overwritten,
which appears to destroy the caller's FPU context.

> =20
>  	if (NULL =3D=3D plane_state)
>  		return NULL;

[Severity: High]
This isn't a bug introduced by this patch, but since you are addressing
'scheduling while atomic' bugs on PREEMPT_RT by wrapping memory allocations
in FPU regions, what about the symmetrical normal deallocation paths?

For example, dc_stream_free() and dc_plane_state_free() call kfree() and
kvfree() without FPU/preemption guards.

During bandwidth validation, dcn32_internal_validate_bw() executes inside an
FPU-guarded section (with preemption disabled) and can trigger these frees:

dcn32_internal_validate_bw()
  dc_state_release_phantom_streams_and_planes()
    // drops refcounts, leading to:
    dc_stream_free()
      kfree()

On PREEMPT_RT kernels, won't these free functions still attempt to acquire
sleeping locks (rt_mutex) and cause a scheduling while atomic crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727105059.7571=
6-1-spasswolf@web.de?part=3D1
