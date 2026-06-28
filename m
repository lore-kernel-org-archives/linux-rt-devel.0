Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB43B71DC;
	Sun, 28 Jun 2026 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782682468; cv=none; b=bSN+r0fJpPKov0E/Vvqd0X8ISZRL67FGkrjND70R7ublYNjgAvIwzD0gl4Cwl6qJ4IPs+yf3vmNpKtNFhmPFCJJ+S9jpkCixmMjHogmdWbd2LF5PL5X1VD7t5gOB4duftcTRX2f8/D8dJ1lNSoGf4UNiG8o7wSSBlJBOZ4bCYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782682468; c=relaxed/simple;
	bh=98dHjFNCAKNgpvYGYpC96HVkMFFGhknoIQky1RfM3Mw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QEfgNakZGRWEI62nNz1XDvLgHgJQSDvVVg2yHtjV5r/J2FdTBz22b7VQd69QjTyh+JoA6LVlCk8QhGKu4XdmKW/0wIcDWS96F20HyR2qJBPsZgbP4n02X0wOcIYLqeYs4Qjcjkw4QahkK5QUWQIlGHpw43HximqqwZGKuGk4a2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9C01F000E9;
	Sun, 28 Jun 2026 21:34:26 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, linux-rt-devel@lists.linux.dev, conor+dt@kernel.org
In-Reply-To: <20260628-dfustini-atl-sc-cbqri-dt-v3-5-c9c1342fe3cf@kernel.org>
References: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
 <20260628-dfustini-atl-sc-cbqri-dt-v3-5-c9c1342fe3cf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 21:34:24 +0000
Message-Id: <20260628213426.EB9C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Dynamically registered capacity controllers bypass capability vali=
dation, leading to hardware errors that abort CPU hotplug.
--

commit 3d57a44029d899d70e2c81681585f914c01cc700
Author: Drew Fustini <fustini@kernel.org>

riscv_cbqri: resctrl: Add cache allocation via capacity block mask

Wire CBQRI capacity controllers into resctrl as RDT_RESOURCE_L2 and
RDT_RESOURCE_L3 schemata. Mismatched CC caps at the same cache level
are treated as a fatal configuration error since fs/resctrl exposes a
single per-rid cap set. Domains are created lazily in the cpuhp online
callback so cpu_mask reflects only currently online CPUs.

> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resc=
trl.c
> new file mode 100644
> index 0000000000000..1fb0fbe1b000f
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c
[ ... ]
> +static int cbqri_attach_cpu_to_cap_ctrl(struct cbqri_controller *ctrl,
> +					unsigned int cpu)
> +{
> +	struct cbqri_resctrl_res *hw_res;
> +	struct rdt_ctrl_domain *domain;
> +	struct rdt_resource *res;
> +	int dom_id;
> +	int rid;
> +
> +	rid =3D cbqri_cache_level_to_rid(ctrl->cache.cache_level);
> +	if (rid < 0)
> +		return 0;
> +	hw_res =3D &cbqri_resctrl_resources[rid];
> +
> +	if (!hw_res->ctrl)
> +		return 0;
> +
> +	res =3D &hw_res->resctrl_res;
> +	dom_id =3D ctrl->cache.cache_id;
> +
> +	domain =3D cbqri_find_ctrl_domain(&res->ctrl_domains, dom_id);
> +	if (domain) {
> +		cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
> +		return 0;
> +	}
> +
> +	domain =3D cbqri_create_ctrl_domain(ctrl, res, cpu, dom_id);

[Severity: High]
Does this regression cause CPU hotplug to abort if a capacity controller is
dynamically registered (e.g., via a device tree overlay) after boot?

Late-registered controllers bypass the capability validation in
cbqri_resctrl_pick_caches(). When a CPU sharing this new controller is
hotplugged, it reaches this point to create a new domain.

If the late controller supports fewer RCIDs than the global controller,
cbqri_init_domain_ctrlval() will issue out-of-bounds commands to the hardwa=
re
because it iterates up to the global hw_res->ctrl->rcid_count:

drivers/resctrl/cbqri_resctrl.c:cbqri_init_domain_ctrlval() {
...
	for (i =3D 0; i < hw_res->ctrl->rcid_count; i++) {
		for (t =3D 0; t < CDP_NUM_TYPES; t++) {
			err =3D resctrl_arch_update_one(r, d, i, t, ...
...
}

The hardware will reject the out-of-bounds RCID commands, and the resulting
error will bubble up to cbqri_resctrl_online_cpu(), keeping the CPU
permanently offline.

Should the capabilities of dynamically registered controllers be validated
against hw_res->ctrl before attaching them?

> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-dfustini-a=
tl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org?part=3D5
