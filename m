Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593F3659EB;
	Thu, 20 Aug 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237557; cv=none; b=AVqLFfunpuKfGxeeyqDjtrpc6gNC9I9HW3HK49NZ9ZX0z5uRPY4cUTJ1bbwhtGcAqV2Pu8l9s33qxoMls25ps906Imb5SBw54O/QYms8Vef3Z6/00FOzr2g5ll9uLNw4IcrzcsjK1sCKAo17Tly4F6RSjb5Y9Pb8jrZ+KEvT8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237557; c=relaxed/simple;
	bh=6QJ8DUOyXiOnrtEShLzI04DusT7TNvtPhNaPpLZ6smo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m8W5ajj71qkAiPX4PnG90rxxf/Lqc3BgpHoOEWK1L3A3Ke7wLHHLDUVtt4bqSJNOoSsgG+uaB/mZ+8Rq4jlzwb9nCua5Q+l9g9eDVsoChj76QFqmjoSiNCiApOpj8YgVMpSXhPT8IC5y0dkGna1p+hhXsXfYPAf9rFsdF7SpeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbW6ZvZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbW6ZvZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5010D1F00A3A;
	Thu, 20 Aug 2026 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787237556;
	bh=sOcWDrGSxQYbQ8UbGPu1S1+aXn4pUKeYl8PTAm1xMrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GbW6ZvZT88icxutfhDqQnZQB9BBacp/RQppP0WIRf2fuYIS30CRUtGV3yztsdeVSN
	 lkSdQFqximmk34EIBTuzryRHMXslZ2x97PdvBOldWHk2h+1oR+Bw1v9kYeyJiDRlEr
	 oHz6ZE2f21PJ2X8sdm+7kVx+AGJcEcGqjlBslqESjJ12ClhmeDALNtUGS95o0rtOUt
	 3l7RE/U+Es7tGAlDvUadUqcEqla9hmXip3opGCloUxjsybchFm78AJnp7R6z2foKfp
	 B7yEhei4BQRaPy2DXiTFucXQoTiXsuN4TqsV++8DIaXqMNyE4iV+wshthPi3FUywCw
	 7ZADI45c++xzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] docs: real-time: mention the hrtimer sleeper HARD
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liang Hao" <haohlliang@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260820144655.22492-1-haohlliang@gmail.com>
References: <20260820082114.QIiSu8n5@linutronix.de>
 <20260820144655.22492-1-haohlliang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:52:35 +0000
Message-Id: <20260820145236.5010D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Documentation inaccurately claims non-real-time hrtimers are initia=
lized with the HRTIMER_MODE_SOFT flag.
--

--- Patch [1]: [PATCH v5] docs: real-time: mention the hrtimer sleeper HARD=
 path ---
commit 9bd51b2daf474d1c00caf4e2ad8da8892d995928
Author: Liang Hao <haohlliang@gmail.com>
docs: real-time: mention the hrtimer sleeper HARD path

This commit updates the real-time differences documentation to describe the
hrtimer sleeper path used by userspace sleeps. It also renames "ktimersd"
to "ktimers" to match the ksoftirqd naming convention.

> diff --git a/Documentation/core-api/real-time/differences.rst b/Documenta=
tion/core-api/real-time/differences.rst
> index a129570dab5a3..04be5789b5fcc 100644
> --- a/Documentation/core-api/real-time/differences.rst
> +++ b/Documentation/core-api/real-time/differences.rst

[ ... ]

> @@ -119,12 +119,20 @@ timers initialized with the HRTIMER_MODE_SOFT flag,=
 which are executed in
>  softirq context.
> =20
>  On a PREEMPT_RT kernel, this behavior is reversed: hrtimers are executed=
 in
> -softirq context by default, typically within the ktimersd thread. This t=
hread
> +softirq context by default, typically within the ktimers thread. This th=
read
>  runs at the lowest real-time priority, ensuring it executes before any
>  SCHED_OTHER tasks but does not interfere with higher-priority real-time
>  threads. To explicitly request execution in hard interrupt context on
>  PREEMPT_RT, the timer must be marked with the HRTIMER_MODE_HARD flag.
> =20
> +Userland sleepers usually deploy a hrtimer to guarantee a precise wakeup
> +time. The timer is initialized with hrtimer_setup_sleeper_on_stack(), wh=
ich
> +distinguishes between real-time and regular tasks. The hrtimer of a task
> +without a real-time priority is initialized with HRTIMER_MODE_SOFT, but =
for

[Severity: Low]
Is this description completely accurate regarding how the mode is set?

Looking at the implementation of __hrtimer_setup_sleeper(), it appears to
rely on the PREEMPT_RT core __hrtimer_setup() behavior to default to soft
interrupt mode when the HRTIMER_MODE_HARD flag is omitted, rather than
explicitly applying the HRTIMER_MODE_SOFT flag itself.

Could we reword this to clarify that it defaults to the soft interrupt mode
rather than explicitly passing the HRTIMER_MODE_SOFT flag?

> +real-time priorities HRTIMER_MODE_HARD is used. This ensures that real-t=
ime
> +tasks are woken up as soon as possible while ordinary tasks cannot block=
 the
> +CPU with a thundering herd of wakeups.
> +
>  Memory allocation
>  -----------------

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820144655.2249=
2-1-haohlliang@gmail.com?part=3D1
