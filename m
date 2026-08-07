Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766E47606D;
	Fri,  7 Aug 2026 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786109510; cv=none; b=nv0IetqY2Zd+B/dMqiLDB7+jjmf8rE7c7A3HqIXKac+MuzLrwhc9I3uoQhnO0CBgZ+Ghos3nc4P/WXMDgtsyDpg0S7Q7jXToW1E3zgzwB5sPvb3N9Y6ZXU+pAcja4Pg43qRKNr8Nqlby+D+cEGTqoiY9G/mahq8JHknfUo6wrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786109510; c=relaxed/simple;
	bh=B8ymhp02zgxPmgwtu7e2n6Ecfi/ODOHbKH7ft3RuU3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M52Wu0kuYe9QpCSG8ied5KnDI/yPABp/L5Zq5vLLzn42ZRJro8mgGXeNPhOx+T3cJCUgFCKPo6HVcj70aFtJRKWe1wsYIK6g2LVl//QA6YfqfW3VCp13rgtMvF8gBUVu0skGQbkz+/Ti+UT9KuXBG+tw0kCKDFsHsncansj3Fiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGI+7Vm2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGI+7Vm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1D81F000E9;
	Fri,  7 Aug 2026 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786109503;
	bh=tkssVBKHKnnpR9x7NtJoh+miHiwAdLhn3foqr3aaM3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YGI+7Vm2lCfqcd5kfY/RGI+HXonQN9BMgGxJ9ascva8m9qiRYKFAyQaqJ/cwM4oui
	 1h7V13gHG3aIBCdn1wCnXTMkQEqvXZAeyitTExvOGKgwTYOzhXII52SJeM+SqhdNmY
	 2vo7DaBtfY27MxvxBN6UVk4OkrXdE8JV0EBwtQUnBLaCpa0dIMMErwhU28JU/Z2L9m
	 4QiQJ9UFYIPXsD89bpja9bE/J+seTj1Bz2Rs6UtxIGOEUWTkvpufNc1z9h2DxXJkJG
	 PhSL7qB6CqI+3J5Qvj8wz0mhKwbrljJFfopp2USv+23a4JpIZKwdZ1HVTBefewWhSG
	 DvKM2dtU24YEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bert Karwatzki" <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260807125832.157856-1-spasswolf@web.de>
References: <20260807125832.157856-1-spasswolf@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 13:31:42 +0000
Message-Id: <20260807133143.1F1D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] DC_RUN_WITH_PREEMPTION_ENABLED() silently clobbers callee-save=
d FPU/SIMD registers on architectures like ARM64.
- [High] DC_RUN_WITH_PREEMPTION_ENABLED() fails to enable preemption if the=
 FPU recursion depth is greater than 1.

Pre-existing issues:
- [High] The teardown paths for streams and planes call kfree() and kvfree(=
) inside FPU-guarded regions without dropping preemption.
--

--- Patch [1]: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} wit=
h PREEMPT_RT ---
commit ca829d4b6abc0445e9b58703c783e610dbd244a1
Author: Bert Karwatzki <spasswolf@web.de>

drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT

This commit addresses "scheduling while atomic" warnings on PREEMPT_RT by
wrapping memory allocations in DC_RUN_WITH_PREEMPTION_ENABLED() in the
plane and stream creation paths.

Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c

[ ... ]

> @@ -208,13 +208,13 @@ struct dc_stream_state *dc_create_stream_for_sink(
>  	if (sink =3D=3D NULL)
>  		goto fail;
> =20
> -	stream =3D kzalloc_obj(struct dc_stream_state, GFP_ATOMIC);
> +	DC_RUN_WITH_PREEMPTION_ENABLED(stream =3D kzalloc_obj(struct dc_stream_=
state, GFP_ATOMIC));

[Severity: Critical]
Does DC_RUN_WITH_PREEMPTION_ENABLED() silently clobber callee-saved FPU/SIMD
registers on architectures like ARM64?

The AMD display math library relies on FPU calculations. On ARM64, the ABI
designates certain SIMD registers (e.g., d8-d15 or v8-v15) as callee-saved.
When the display math library calls dc_create_stream_for_sink() from within
an FPU-guarded region, the C compiler expects these callee-saved registers
to be preserved.

When DC_RUN_WITH_PREEMPTION_ENABLED() calls DC_FP_END(), it invokes
kernel_neon_end(). This enables preemption and clears the TIF_KERNEL_FPSTATE
flag, but leaves TIF_FOREIGN_FPSTATE set. If a context switch occurs during
the wrapped kzalloc_obj() allocation, fpsimd_thread_switch() checks
TIF_FOREIGN_FPSTATE and skips saving the hardware FPU registers, erroneously
assuming they do not contain valid task state. The hardware FPU registers a=
re
then clobbered by other tasks. When control returns to the math library, its
local floating-point variables stored in callee-saved registers will contain
garbage.

> @@ -229,7 +229,7 @@ struct dc_stream_state *dc_create_stream_for_sink(
> =20
>  fail:
>  	if (stream)
> -		kfree(stream);
> +		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));

[Severity: High]
This is a pre-existing issue, but do the teardown paths for streams and pla=
nes
still call kfree() and kvfree() inside FPU-guarded regions without dropping
preemption?

For example, phantom planes and streams are destroyed during bandwidth
validation by calling dc_state_release_phantom_streams_and_planes(), such as
from dcn32_internal_validate_bw(). This validation executes entirely inside=
 an
FPU-guarded region created by DC_FP_START() in dcn32_validate_bandwidth(),
which disables preemption.

When the last reference is dropped, the teardown paths like dc_stream_free()
and dc_plane_state_free() execute synchronously. Since they call kfree() and
kvfree() directly without being wrapped in DC_RUN_WITH_PREEMPTION_ENABLED(),
these allocations are freed while preemption is disabled, which can trigger
the exact PREEMPT_RT bug this patch aims to fix.

>  	return NULL;
>  }

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_surface.c
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c

[ ... ]

> @@ -85,8 +86,8 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_sta=
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
Does DC_RUN_WITH_PREEMPTION_ENABLED() fail to enable preemption if the FPU
recursion depth is greater than 1?

The FPU protection in the AMD display driver supports nesting via the
fpu_recursion_depth counter. DC_FP_END() only invokes kernel_fpu_end() (and
thus preempt_enable()) if the recursion depth decrements to exactly 0.

If dc_create_plane_state() or dc_create_stream_for_sink() is invoked from a
nested FPU-guarded region where the depth is 2 or more, the
DC_RUN_WITH_PREEMPTION_ENABLED() macro will merely decrement the depth
counter by 1 but leave preemption disabled. The subsequent call to
kvzalloc_obj() or kfree() will then execute with preemption still disabled,
which will still trigger a scheduling while atomic panic on PREEMPT_RT.

>  	if (NULL =3D=3D plane_state)
>  		return NULL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807125832.1578=
56-1-spasswolf@web.de?part=3D1
