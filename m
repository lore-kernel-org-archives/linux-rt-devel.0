Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795153786;
	b=vwvZ2PlzZJwD9ECmR9VGqVgaWWRxOg8+bYBCFUfMa0vCxEnnv8G9i1Ko6fZ1fX9Pxrq+
	 fUebJxpuX13V2DgVM1OvEpCAW7rvoZ26Kn+BDtjNq53PD49zQTNxkZhCE2Uo5aZAhM3kB
	 IbilHTIBbEv44gQVmVysuaXRzjktfdar23u6p85nRnn6wWc58arZfISbTPuLIeW++MQBz
	 HnwF3L34iSCHGrCilA67bS8me3Bu2GQYozfyjbiw/urHFbtRNKB0cO5Ncl4oaRyXPoU97
	 XKzRqB38I+5LfADzRJUsrZvIACsElQUp1G/TaNW5D7uTtiK2EDRfYRmpWf2lwxj1fgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795153786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JyHFHTeXIxD8sZr7vyTW3XbxyuYJmaqt6BcBQ9cZztk=;
	b=jvoI53KWjDZt8Y9dzVj4qBxtO1jLl1HPORcsiy7pYvbdtPUm8uUZOP5WPIrZ2HRPJGVa
	 AYbPejAOQmO7AD2wBVRXh6N1Fi/vxScuEHWaCBIR7wjPfBEnaAyxL3/F3MWzOeZTiK2mD
	 1iqMfDlob5zXsJOttT6Qzk+UjLDM8R9CFN/iDhBVGAidXDvLTemjgtxR3m4Ediwbud6rp
	 Gb9skBOtPTx388iH9tSsUtFRoB30PKBCASNepH7vWo+ykocRifYC4aCWS+HQqpo07C31c
	 Ssw/eRRFo3cdtXCe788hX8cV1c0cE+KnBTmW7ccqkwSAFn/x6v55hLluOFOCvQ+gH1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsdSTroV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4D606A320;
	Fri, 20 Nov 2026 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsdSTroV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FA41F000C6;
	Fri, 20 Nov 2026 05:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795153786;
	bh=JyHFHTeXIxD8sZr7vyTW3XbxyuYJmaqt6BcBQ9cZztk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WsdSTroVKjsh//emRn8AG7FZdP3YFNLq8KYBdOdNfZMAI3BTCjnh9+YwVB3Rj7dO3
	 bC4dtQGpdJkBrWPuMjVCF1KAL6RVCVkAIEhslKWzk+dOVvYlLtUrQqLs1XEyPvWSvU
	 OORYcQ6gPwnf9EnygwoB7b/cSEKLGYKCAcfW35lJTpLCVkQQoynB81LjN5ohquzFD0
	 8N8q6A+4BH1Cv/8gBiQ14ZKxQ8HRj5aJjcY5Jz37PoOW5BqCNU9b1wpOiQfvVTnTwa
	 gf3jMfIcF4pjxDxnCsSCU8Tu/hGt30/E2p/6OQVg3VXIzIBZCMEV7acIM/YHyTytLj
	 2WMFEGVTaEyLw==
Message-ID: <sashiko-outbox-224515@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Documentation: real-time: Add boot parameters and task
 isolation section
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zixin Wang" <w1355457260@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261120054242.523606-1-w1355457260@gmail.com>
References: <20261120054242.523606-1-w1355457260@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 05:49:45 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] docs: real-time: outdated sched_rt_runtime_us default and
  throttling behavior
--

commit ae882b9844760c78627ba7cec7ca4d357c476313
Author: Zixin Wang <w1355457260@gmail.com>

Documentation: real-time: Add boot parameters and task isolation section

This commit adds a section to the real-time kernel configuration guide
documenting boot parameters and runtime tunables for CPU isolation,
nohz_full, RCU callback offloading, interrupt affinity, idle states, and
real-time throttling.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220633
Link: https://github.com/elisa-tech/wg-aerospace/issues/222

> diff --git a/Documentation/core-api/real-time/kernel-configuration.rst b/=
Documentation/core-api/real-time/kernel-configuration.rst
> index d7f08e7b87604..6553249646f10 100644
> --- a/Documentation/core-api/real-time/kernel-configuration.rst
> +++ b/Documentation/core-api/real-time/kernel-configuration.rst
> @@ -216,6 +216,140 @@ just by being enabled.

[ ... ]

> +Real-time throttling
> +--------------------
> +
> +``kernel.sched_rt_runtime_us``
> +  This sysctl, normally set at boot through a ``sysctl.d``
> +  configuration file, limits the CPU time available to real-time
> +  scheduling during ``kernel.sched_rt_period_us``.  The default of
> +  950000 us per 1000000 us reserves 5% of the CPU for non-real-time
> +  tasks.  A value of -1 removes the limit, allowing real-time tasks to
> +  use the full period; do this only after validating the workload,
> +  because a runaway real-time task can then starve the rest of the
> +  system.  Recent kernels require the runtime/period ratio to stay
> +  above 0.05 to preserve bandwidth for the fair deadline server.  See
> +  Documentation/scheduler/sched-rt-group.rst.

[Severity: Low]
Is this description of kernel.sched_rt_runtime_us up to date?

Since c2e390197ad1 ("sched/rt: Update default bandwidth for real-time tasks
to ONE") and 5f6bd380c7bd ("sched/rt: Remove default bandwidth control"),
sysctl_sched_rt_runtime defaults to 1000000 us rather than 950000 us, and no
longer throttles SCHED_FIFO or SCHED_RR tasks when CONFIG_RT_GROUP_SCHED is
disabled.  The default 5% CPU reservation for non-real-time tasks is instead
enforced per CPU by rq->fair_server (50 ms per 1000 ms in
sched_init_dl_servers(), tuned via
/sys/kernel/debug/sched/fair_server/cpuX/runtime), which is not disabled by
setting kernel.sched_rt_runtime_us to -1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120054242.5236=
06-1-w1355457260@gmail.com?part=3D1
