Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD031F983;
	Fri,  7 Aug 2026 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136446; cv=none; b=cLP9eDaZP4eTQDEtmJDUVLttU/N7Xm4ChEX2utapXTNQJeUlJOB8VXrz6nBCcbqpD2T/ZrALrnCSGoYPWfsmIR0V7D7i/zRiaRbBqFT7Ydqwok0FvJXKQDUoVCZMBJkdOkFQ3x1jn1dggq7gWnpMX0L102PnKE8KDeMK1kL45E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136446; c=relaxed/simple;
	bh=iEs+/aoxIzAgU91Q4fVOqpFdF5MyqwjMTbZSLUFCR8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=moVUDTfxKCVgMXootgd495kDsWDwJSfoxqGfSFwrvCvNwj3dGS1LX6dXV7QQRnSbfLVT/mjoJAxpQXFiwF7saOfau0eBHAPM6I+HLMMmTYucCOKZodhM2ADXkUB3BOHABksqRJ4A3jUlCbPiqqcxVHWW1w8qPrKmxHu0k25ua2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg9Oj26h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg9Oj26h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89FA1F000E9;
	Fri,  7 Aug 2026 21:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786136445;
	bh=Ud/Vv8C4Tapcd95HxW9wphPNZP3btz5tAhD9vzQZ++4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zg9Oj26hSXQCqSJCt3h9BZA/D6BY23bP1802HKVpJZizTGQAWdAsGAaevs233jW8L
	 WeAL4bg/SrDNL08PndJNPpTi5Hnih6etZgfHvB81QY8ybcpx3cn8ain2tharviNdyu
	 Dy17R44G3uUA/6LjQNNMWobwIYfQjeTPwW7xcNNMBpfXoGV60th3FHEI7J634M5vnM
	 tGL0AS3CBeTtbh+tnWgqWfuud8ojN2ojZivCYLTWxGm8Z+2Or3DW3uVrFLM3M+k9zr
	 yaWNSG5cQH8YRcDO24NXVf6n6WAw3kGnEn1YxZEtJiduTfYrAikvgKsS7iFQAkavuX
	 8lCGOBBRrej/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] sched: pause KCOV in try_to_wake_up()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260807205027.31972-5-kmehltretter@gmail.com>
References: <20260807205027.31972-1-kmehltretter@gmail.com>
 <20260807205027.31972-5-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 21:00:44 +0000
Message-Id: <20260807210044.D89FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch mixes a goto-based manual cleanup with a `guard()` declar=
ation in the same function, violating cleanup subsystem guidelines.
--

--- Patch [4]: [PATCH 4/5] sched: pause KCOV in try_to_wake_up() ---
commit 96c5de7cc097dcbb15a79c4c86f4148070fd31cf
Author: Karl Mehltretter <kmehltretter@gmail.com>

sched: pause KCOV in try_to_wake_up()

This patch pauses KCOV instrumentation around try_to_wake_up() to prevent
instrumented helpers from recording into current while in task context. It
saves the pause state and manually resumes it at the function's exit label.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4252,6 +4252,8 @@ int try_to_wake_up(struct task_struct *p, unsigned =
int state, int wake_flags)
>  {
>  	guard(preempt)();
>  	int cpu, success =3D 0;
> +	/* KCOV: sched/ is uninstrumented but the wakeup callees are not. */
> +	unsigned int kcov_paused =3D kcov_pause(current);

[ ... ]

> @@ -4418,6 +4420,7 @@ int try_to_wake_up(struct task_struct *p, unsigned =
int state, int wake_flags)
>  	if (success)
>  		ttwu_stat(p, task_cpu(p), wake_flags);
> =20
> +	kcov_resume(current, kcov_paused);
>  	return success;
>  }

[Severity: Low]
Does this mix manual goto-based cleanup with scope-based guard() declaratio=
ns?

The cleanup subsystem guidelines recommend that goto-based error handling a=
nd
cleanup helpers should not be mixed in the same function, as it can confuse
ownership semantics and increase the risk of resource leaks if early returns
are added later.

In try_to_wake_up(), guard(preempt)() is used at the top of the function,
but this patch introduces a manual kcov_resume() cleanup step at the out:
label.

Could this KCOV pause and resume be handled using a scope-based cleanup hel=
per
to match the existing guard() usage, preventing the mixed paradigms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807205027.3197=
2-1-kmehltretter@gmail.com?part=3D4
