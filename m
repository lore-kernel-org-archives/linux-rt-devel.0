Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB903B38AA;
	Sat,  1 Aug 2026 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785569728; cv=none; b=AN+AzcXoWn5G9+o3SPesZ6N1klRulbANXMALAIEJDtpxghx/w5mqiWhGuchyZLPN3SAG1lhA9aIbTO3By/gSpc+EWo3ABCaKLPX4uRe+Uje9LFmPtI5HxnSMABkhz7WYykuT3FwWP2RzqILNiuv2YijbRPZk9kd6FRhJMB+T3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785569728; c=relaxed/simple;
	bh=yzSciKhdH21hCO5XXoZak5b6qvoPWReiYyYNkn8DpQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KBIIO1pqaoaP22RBy+0Cd/BLaW0j070LliWBSCzY/+gXXT08RA8LEH/5mo9Z5F1xKdVgQcGNhfSi37lma+EHThrBs6nmLPBwVwFJmeyrVcDKdB88xiDhjT3L2hogJUr7/rdI1E2RGtqsn+EqDHsmYDa7ntNUIzg5BdOp2LaJMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUztwyEK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUztwyEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1539C1F00AC4;
	Sat,  1 Aug 2026 07:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785569726;
	bh=eAOVACVOMoGc6gVm4TNhXV3jPbCY3gzNXHDbk7//JyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jUztwyEKMOTgsToahDrvZATZi+wEwvr9T8vJ8Or2dnC0eX8xt8q/pyM6Yk6idLknn
	 nXCOiydClGlITcYfHGYVOMf9ExFnhl8M5G9eXc2+hIMv53aFOZNKvQmvgoyzuckGZ6
	 0OGDlsa8ihBE48QXYmrtJPGewpglg9nWc63/a16BEJub+4CiqG+xftB9TXHC1dOZ9M
	 f5cUBYLZhExsyx6QfvgZ/zSxzDur04K0kMfRP4rw7nWhe7tFPRnjw1yyoioJ+ZP8F6
	 Sf59V87M81CnIVp0jCDy4Utf3caso5DOCSz/VHparg30ZeRVbh8HnFNiIh0pxz9M0y
	 8Q3kZop/mmu4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bert Karwatzki" <spasswolf@web.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260801071724.12998-1-spasswolf@web.de>
References: <20260801071724.12998-1-spasswolf@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 07:35:25 +0000
Message-Id: <20260801073526.1539C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch wraps allocations and error-path frees in DC_RUN_WITH_PR=
EEMPTION_ENABLED() to fix a 'scheduling while atomic' bug on PREEMPT_RT, bu=
t misses the normal destruction paths which are called from the exact same =
FPU-guarded contexts.
- [Medium] dc_state_create_phantom_stream() leaks a phantom stream referenc=
e if tracking fails.
--

--- Patch [1]: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} wit=
h PREEMPT_RT ---
commit 333ce260a6d2d044dc84469ac2172b5e7123c941
Author: Bert Karwatzki <spasswolf@web.de>

drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT

On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
converted to rt_mutex. dc_create_plane_state() can be called while
inside an FPU-guarded region, resuling in "scheduling while atomic"
errors on PREEMPT_RT kernels.
Fix this by calling kvzalloc_obj() with DC_RUN_WITH_PREEMPTION_ENABLED().
Also fix the error path in dc_create_stream_for_sink().

Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index cdcf140bc1bbd..accad9e20e88a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -229,7 +229,7 @@ struct dc_stream_state *dc_create_stream_for_sink(
> =20
>  fail:
>  	if (stream)
> -		kfree(stream);
> +		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));

[Severity: High]
This isn't a bug introduced by this patch, but does this fix need to cover =
the
normal destruction paths as well?

The patch wraps allocations and error-path frees to prevent scheduling while
atomic errors on PREEMPT_RT kernels. However, normal destruction paths are
also called from the exact same FPU-guarded contexts.

For example, when dropping phantom streams inside an FPU-guarded block duri=
ng
DML bandwidth validation:

dcn32_internal_validate_bw()
   dc_state_release_phantom_streams_and_planes()
      dc_stream_free()
         kfree(stream);
      dc_plane_state_free()
         kvfree(plane_state);

Should dc_stream_free() and dc_plane_state_free() also wrap their frees with
DC_RUN_WITH_PREEMPTION_ENABLED() to avoid triggering the same panic?

[Severity: Medium]
This is a pre-existing issue, but does dc_state_create_phantom_stream() in
drivers/gpu/drm/amd/display/dc/core/dc_state.c leak a phantom stream
reference if tracking fails?

If dc_state_track_phantom_stream() fails, for example because the
MAX_PHANTOM_PIPES limit is reached, it returns false. This return value is
ignored by dc_state_create_phantom_stream(). The stream is added to the main
array but not tracked in the phantom array.

When the state is destroyed, dc_state_destruct() only drops the reference
from the main array, permanently leaking the initial creation reference.

> =20
>  	return NULL;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801071724.1299=
8-1-spasswolf@web.de?part=3D1
