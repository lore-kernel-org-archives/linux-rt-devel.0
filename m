Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D13DF6C;
	Thu, 30 Jul 2026 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374845; cv=none; b=IIEV0nG9SdbZBLxYIqv8VKdgQtdblmHVa2ujZMhVYfC0Qz8hx/wr2LuS0UXX5jq67pPDeGfosKzRG6cdevCWvelTRUxShhjzZkSvRzsQ3fgrhbv4Q1Oc6q1SIX3+hRSviqq1vaxXaZUx5uPJX6WcsynDmttbWy94VwURxZ2r9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374845; c=relaxed/simple;
	bh=eP2ShQTgsPosE0sjc/rtyFVtR2KbF/tu/peyvMuCY24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MKlULEa1GcsMRc24CXrfmPS5LkrmUPZK3Z/iw9J02Q4D/3vaaZ6qE3syPOn0jROZykoeVgoaK2p5mJb4u6L6tRvtTkTivSEGFwxQHxPsolNmVSnFjTQ3AawPjrvdz7yVG9NTZ7zeK26lNlO9kY12w4axGl7qYCLR1rIY/gpma64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5Xs3Gbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5Xs3Gbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77E71F000E9;
	Thu, 30 Jul 2026 01:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785374843;
	bh=z/6E3/YD2r1NUeOSgRNpPl2j7Ee6bGqW0BcMBvFd54I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V5Xs3Gbp9R5O2xGHQ1x2dYgO7GKRk+NlCSBh1egldH0cM+Tw2DucXaD/gDr+8dyaN
	 lbxNgKLWHS2ToDQNyTwf5x2fjZNMnOLUMjmkcF7rX/wpwVJDV8uiFvcSIpc9Zq0vIX
	 x6VlPvezwa9UWlZajE65F+FY5RUr/DGWRxIJIZ7vZEPe2x8BVrIfcorzNs9+7GIVfC
	 tiu36ZAXzRgY4NRhWkzFoMPIKx3hrr+LpExR1Tl3GmBxwMcmeGcH/sIlJNL/H9l4XV
	 qhkYJ+UISKDViogzmL6WFRVxdunUpPeHqjh/aQ6a2QN2I3u3Gr8B+bwg6jJ0aYNEYe
	 HFSqj/tyBhc7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/8] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260729-dfustini-atl-sc-cbqri-dt-v6-5-7c22b05d461b@kernel.org>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
 <20260729-dfustini-atl-sc-cbqri-dt-v6-5-7c22b05d461b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:27:22 +0000
Message-Id: <20260730012722.A77E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Capacity controllers registered after boot bypass capability valid=
ation, which can cause resctrl failures and hardware writes with out-of-bou=
nds parameters.
--

--- Patch [5]: [PATCH v6 5/8] riscv_cbqri: resctrl: Add cache allocation vi=
a capacity block mask ---
commit b95a917a4c4e682ec805c748e42c4a7bedae47b2
Author: Drew Fustini <fustini@kernel.org>

    riscv_cbqri: resctrl: Add cache allocation via capacity block mask

This commit wires CBQRI capacity controllers into resctrl as RDT_RESOURCE_L2
and RDT_RESOURCE_L3 schemata. It handles domain creation during the cpuhp
online callback for offline CPUs, and defines context-switch and capability
checks for RISC-V.

> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resc=
trl.c
> index 0000000000000..0c4bfa2a7f433
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c
[ ... ]
> +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> +{
> +	static const u32 levels[] =3D { 2, 3 };
> +	struct cbqri_controller *ctrl, *c;
> +	struct cbqri_resctrl_res *hw_res;
> +	struct rdt_ctrl_domain *d;
> +	struct cacheinfo *ci;
> +	int i, rid;
[ ... ]
> +		/* The controller backing this CPU's cache at this level. */
> +		ctrl =3D NULL;
> +		list_for_each_entry(c, &cbqri_controllers, list) {
> +			if (c->type =3D=3D CBQRI_CONTROLLER_TYPE_CAPACITY &&
> +			    c->alloc_capable &&
> +			    c->cache.cache_level =3D=3D levels[i] &&
> +			    c->cache.cache_id =3D=3D ci->id) {
> +				ctrl =3D c;
> +				break;
> +			}
> +		}
> +		if (!ctrl)
> +			continue;
> +
> +		d =3D cbqri_find_ctrl_domain(&hw_res->resctrl_res.ctrl_domains,
> +					   ci->id);
> +		if (d) {
> +			cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +			continue;
> +		}
> +
> +		d =3D cbqri_create_ctrl_domain(ctrl, &hw_res->resctrl_res, cpu,
> +					     ci->id);

[Severity: High]
Does this code allow a late-registered controller to bypass the capability
validation?

During boot, cbqri_resctrl_pick_caches() validates that all controllers at a
given cache level have identical capabilities (like ncblks and rcid_count)
using cbqri_cc_caps_agree().

However, in the CPU hotplug path, if a new cache controller is probed
after boot, cbqri_attach_cpu_to_all_ctrls() finds it and creates a
domain without verifying it matches the baseline hw_res->ctrl.

If the hotplugged controller has a smaller rcid_count than the baseline,
could resctrl assume the baseline capabilities and cause hardware
out-of-bounds writes by using an invalid RCID in
resctrl_arch_reset_all_ctrls()?

Would adding a call to cbqri_cc_caps_agree() here to compare the new
controller against hw_res->ctrl prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-dfustini-a=
tl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org?part=3D5
