Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06839B969;
	Mon, 31 Aug 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210852; cv=none; b=Mnx62iRMMu6autSPEub8HwLNQIiBKGW7YqPmz8reNEN8biegHw8QpNF67fyXpHaHrbmRf40fb9NmbTXdYPCT2ZSQzv4y52KJaQNXvRZewAloX/DOuIirr0C/qgEQoB7FyTcr09b9MqcCcQ687mts8uctejlsIP6cbq6vdrHAHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210852; c=relaxed/simple;
	bh=izjsFml2VSe8OHfQH+B+NRyEs476PKcZRmMH2wQ2+O8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q9aGFzAtSmWPnyCy44DySARl+Hhxa2EgfKyXsyRw2LIotYR8aqwmwE8rzE50eS8K6egueHH4za+UhIS7imR8T16q26z+LuOO3DOuaoZKXmBumDFI+J6+gfN+dp6Nt3zNOwr2scIEJ75QvTQVjHwd1d940mIBD8ln4jlEsH6BPUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyFbjs+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyFbjs+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0117E1F00A3E;
	Mon, 31 Aug 2026 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210850;
	bh=cQW7ikKg1qRQG1VUvMZ3GJ85wXZ+YIFlEJ0lVNtN6Yg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eyFbjs+vA9hszmGS+JjOb0Vai9HIWQjmHEXZ4wJeLD/fK6uGmqSzkXPF3lS/NNNLJ
	 RgbJr7gycJQaLPS82EkulSzh3b6OB5qKHOZeL5rfByOMcnPPOITXQdiGv6pJWnl+cf
	 0baiRIxlxMkDJzVUG1QpdCZlJcZ9VAJysBbpGqJgu+XV4kM3PX/fDKVHfcyDepQXGk
	 gEkralVicTmGbTJ3BwaPuMRqwEBDn24wldFQbdTu5n92oTgOMNDRw3S//z1SFU4ZTm
	 ViXl7KEstya4LAOumKH6Z2RGFA3fKzcdSEnYmGYzi3pMlKYQNeH+CbWDifTENqCzWY
	 A6nBQvyfff/5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cpuidle: psci: Assign domain callbacks to all CPU idle
 states
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S2V2aW4gSGlsbWFuIChUSSk=?= <khilman@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260831-topic-lpm-psci-domain-callbacks-v1-1-4a47d95c9c79@baylibre.com>
References: <20260831-topic-lpm-psci-domain-callbacks-v1-1-4a47d95c9c79@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:14:09 +0000
Message-Id: <20260831211410.0117E1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The genpd governor bypasses the cpuidle governor's short-sleep pre=
dictions for shallow states, forcing CPUs into deep sleep and violating exi=
t latency requirements.
--

commit 377e8584faa669a41142f336e4973cde237d354b
Author: Kevin Hilman (TI) <khilman@baylibre.com>

cpuidle: psci: Assign domain callbacks to all CPU idle states

This commit assigns domain-aware callbacks to all non-WFI CPU idle states.
This ensures the domain-idle-state logic and cluster-level states can be
triggered regardless of the selected CPU idle state.

> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psc=
i.c
> index dcf20ea5ef5e3..db9aa57c51f55 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c

[ ... ]

> @@ -261,14 +263,22 @@ static int psci_dt_cpu_init_topology(struct cpuidle=
_driver *drv,
>  	psci_cpuidle_use_syscore =3D true;
> =20
>  	/*
> -	 * Using the deepest state for the CPU to trigger a potential selection
> -	 * of a shared state for the domain, assumes the domain states are all
> -	 * deeper states. On PREEMPT_RT the hierarchical topology is limited to
> -	 * s2ram and s2idle.
> +	 * Assign the domain-aware callbacks to all CPU idle states so that the
> +	 * domain-idle-state logic is triggered regardless of which CPU idle
> +	 * state is selected.
> +	 *
> +	 * For s2idle, enter_s2idle uses dev_pm_genpd_suspend() which is safe
> +	 * on PREEMPT_RT. find_deepest_state() will pick the deepest state
> +	 * whose exit latency fits within the active QoS constraint.
> +	 *
> +	 * For the normal idle path, enter uses pm_runtime_put_sync_suspend()
> +	 * which may sleep and is therefore not used on PREEMPT_RT.
>  	 */
> -	drv->states[state_count - 1].enter_s2idle =3D psci_enter_s2idle_domain_=
idle_state;
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -		drv->states[state_count - 1].enter =3D psci_enter_domain_idle_state;
> +	for (i =3D 1; i < state_count; i++) {
> +		drv->states[i].enter_s2idle =3D psci_enter_s2idle_domain_idle_state;
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +			drv->states[i].enter =3D psci_enter_domain_idle_state;
> +	}

[Severity: High]
Does assigning these domain callbacks to shallow states bypass the cpuidle
governor's short-sleep predictions?

If the cpuidle governor predicts a short sleep (such as from frequent
interrupts) and selects a shallow CPU idle state,=20
psci_enter_domain_idle_state() calls pm_runtime_put_sync_suspend().=20
This drops the CPU PM domain refcount and triggers the genpd governor.

The genpd governor calculates idle duration strictly based on next_hrtimer,
ignoring the cpuidle governor's statistical short-sleep prediction. If the
next timer is distant, the genpd governor will select a deep cluster state
and update psci_domain_state.state.

When this happens, __psci_enter_domain_idle_state() unconditionally
overrides the CPU's chosen shallow state parameter with the deeper
composite state:

	ds =3D this_cpu_ptr(&psci_domain_state);
	if (ds->state)
		state =3D ds->state;

	trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
	ret =3D psci_cpu_suspend_enter(state) ? -1 : idx;

Could this force the CPU into deep sleep, causing exit latency constraint
violations when the expected short-term interrupt arrives?

Additionally, since __psci_enter_domain_idle_state() returns the shallow
state idx, will this incorrectly attribute deep-sleep latency and residency
to the shallow state and corrupt cpuidle statistics?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-topic-lpm-=
psci-domain-callbacks-v1-1-4a47d95c9c79@baylibre.com?part=3D1
