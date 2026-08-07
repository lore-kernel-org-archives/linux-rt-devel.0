Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45B47A872;
	Fri,  7 Aug 2026 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108430; cv=none; b=LargGicJ8gvWFNMpSnTqGhV07F5wUm2ADWAVG2zfGUz5gu2it/ZQhJkectSWJwyLHe1O/xLuKmH4uehfHD1S/rV0R0oNe2o2+mXtKefETIxKhtAWtpTzUn+q7KBfTFnUSXHGZy6OTxNkfZW7GVhEKNKnGUwKnhM8LfSgIqetSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108430; c=relaxed/simple;
	bh=dkk0Uf2H0JSzxOYmQTn2vE2+DxvVn6LtuAQfVKdF7tc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X1VCc6ANMaOJOOvEv4t1QgN5KGqUi7noSS4t6XaZwP+n0SipMvNxfp3OX/en65ypo1UY19/UrkLdyOQHgiSf30xdIhUcNCGwCdWjgMhGAsJhR05bOMME04DH6f0K+koygYSNdBsuNj9VpG+XvuSaWpBVGExgciWtsB8x3rx2+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd7RkK6G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd7RkK6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AA01F00A3E;
	Fri,  7 Aug 2026 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786108417;
	bh=wtFWNw+mNHwrtNgx4W+wmWJt2IAgXbaoZAd+uHn3EcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jd7RkK6GppERUC8I2Y9mxRt1kDKYrkD7OWxGSMyCO5nD5HO3Cm5u8y/RM+AbV21s5
	 Lat9msnmIIGrJKz7Fh8CmejIbcR1ZqRedUbBFPXiFkwPRLAUg4iWCjt8c4+Y0j2UOK
	 bZsDvzCWu+b5L1WhZ9dQiCrporZcfVLsDMzi+N/QcFIGMRdQTEzEPRrYLKx7cGbGBM
	 aVgUtBAe4vO0HwxB96SNZAi+qTUOGoJ+SGqaSLOSp/YkLVpl+U2lHpOlhtFegSK/je
	 x1BWT54v/b9Z6qfHQpTXXEYLeUEAWVR7KzU5gmdCFZJdhGP/6vEH+hzOU1kpSYuh00
	 NdLL8ceveSwsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7.2-rc6] drm/amd/display: fix usage of
 DC_FPU_{BEGIN,END} with PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bert Karwatzki" <spasswolf@web.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260807124944.154232-1-spasswolf@web.de>
References: <20260807124944.154232-1-spasswolf@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 13:13:36 +0000
Message-Id: <20260807131337.47AA01F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix: Normal deallocation paths (dc_stream_free and dc_p=
lane_state_free) still sleep in atomic context.
- [High] DC_RUN_WITH_PREEMPTION_ENABLED fails to re-enable preemption if FP=
U blocks are nested.
- [High] DC_RUN_WITH_PREEMPTION_ENABLED corrupts callee-saved FPU registers=
 on ARM64.
--

--- Patch [1]: [PATCH v7.2-rc6] drm/amd/display: fix usage of DC_FPU_{BEGIN=
,END} with PREEMPT_RT ---
commit e67f6942f0899807d82dcd2276705097e892a34b
Author: Bert Karwatzki <spasswolf@web.de>

drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT

This commit wraps deallocations in dc_create_stream_for_sink and
dc_create_plane_state with DC_RUN_WITH_PREEMPTION_ENABLED. This prevents
"scheduling while atomic" panics on PREEMPT_RT kernels when sleeping
allocations are called from within FPU-guarded regions.

Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index 7666cdc78f4ed..a5a304a3f8029 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c

[ ... ]

> @@ -233,8 +233,9 @@ struct dc_stream_state *dc_create_stream_for_sink(
> =20
>  fail:
>  	if (stream) {
> -		kfree(stream->update_scratch);
> -		kfree(stream);
> +		if (stream->update_scratch)
> +			DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream->update_scratch));
> +		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));

[Severity: High]
This isn't a bug introduced by this patch, but will the normal deallocation
paths still sleep in atomic context?

When dc_state_release_phantom_streams_and_planes() is called from
dcn32_internal_validate_bw(), it executes under DC_FP_START where
preemption is disabled. That validation path drops references to phantom
streams and planes, which synchronously invokes dc_stream_free() and
dc_plane_state_free().

Those destructors unconditionally call kfree() and kvfree(). On PREEMPT_RT,
slab allocators use sleepable rt_mutexes, which will still cause a kernel
panic from scheduling while atomic. Is it possible to apply this fix to
those deallocation paths as well?

>  	}
> =20
>  	return NULL;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_surface.c
> index 72845fc788f3f..04982673ffbc9 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c

[ ... ]

> @@ -86,8 +87,8 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_sta=
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
This isn't a bug introduced by this patch, but does
DC_RUN_WITH_PREEMPTION_ENABLED() fail to re-enable preemption if FPU blocks
are nested?

In dc_fpu_begin(), preempt_disable() is called unconditionally on every
entry, meaning preempt_count increases with each nesting level. However,
DC_RUN_WITH_PREEMPTION_ENABLED() calls DC_FP_END() exactly once, which
only decrements the recursion depth and calls preempt_enable() once.

If the FPU recursion depth is 2 or more, preemption remains disabled and
the wrapped kvzalloc_obj() will still crash on PREEMPT_RT.


[Severity: High]
This is a pre-existing issue, but can DC_RUN_WITH_PREEMPTION_ENABLED()
corrupt callee-saved FPU registers on ARM64 when used here?

A caller compiled with FPU support, such as
dml2_mall_phantom_streams_and_planes_create(), has live variables in
callee-saved FPU registers (v8-v15 on ARM64). It calls
dc_state_create_phantom_plane() which routes to dc_create_plane_state().

Since dc_create_plane_state() is compiled without FPU support, it doesn't
save v8-v15 to the stack. When DC_RUN_WITH_PREEMPTION_ENABLED() calls
DC_FP_END(), it invokes kernel_neon_end() and enables preemption.

If a context switch occurs while preemption is enabled, the OS scheduler
will not save the thread's FPU state since the kernel has yielded it. The
v8-v15 registers are permanently clobbered, and execution returns to the
caller with garbage FPU values.

> =20
>  	if (NULL =3D=3D plane_state)
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807124944.1542=
32-1-spasswolf@web.de?part=3D1
