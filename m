Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849862D9ECB;
	Fri, 19 Jun 2026 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781894467; cv=none; b=lc1Ime4uU+KdtanNDDu1qsQ1zUvDdGN5WqtRXJrr1Uqcd0lAmpiYRu0GSWPjWiu58FNUjSexf0Q0wXjj47wMsecK99pB7uxrzQZ13osLvwAvd69FPJP5JHzggSM8oZKeqM1R77icMWxr9Bmxzy3MFkcQoz6OclV3xP23ZYX3Y48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781894467; c=relaxed/simple;
	bh=2xBWc5Ehyxwsgvptp0OwQDvCvG/sByjk0mFdfG+Zae0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=trj6rLoDCrfhKW/g9K09LPCY+lpDxbmVq5Wtgi0h15oX3pDvY2WsjsZG9Zt9kpqhpm3nRq/TPAYLh4rvTPsZZ1ZOjMlZefk1XgNn/xySszZbR8OcWSiy1chPV3Vk6Nv5EqoAhKwl91A/87bgGrYwYHBvtqnJ0okbaIUJa0KT2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMrkh2OW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMrkh2OW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C4C1F000E9;
	Fri, 19 Jun 2026 18:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781894465;
	bh=uiFPj1Ka8i1FskqbgQDCyLWCk9ms60orqbWQJJqiZzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lMrkh2OWpmHwxPQTNlxzSP9d8Vo+x8TbXkPKTSRIFRQeoXi8qcZAgaWY3CVTbbMZt
	 VIyqvALUHcINiJ0bb0RlDc9g2kNRQNJ0KA9wbr6kqiv8ZoBoqFC5Dm5uCdGniOhQn9
	 g5yC5HebY3I7sCLWLAUEEE/vZzTEgRyC9wjc1CnHu9s10+wMlJ6MtpUtIBzK97tMIf
	 uriMdTh7Iq/VVlATMHGDyYxxEJAfXEPS9H6nDpkXdAYwdMiOwiICD0jO7I4yjH7QVB
	 7FbK2aB6+ej6TuiC2dy5xfIYMiWAFWmgdrMjXeM/4hb/5bcahW4dz8SMCWbMtTXddA
	 /amuKKG0tUCjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] riscv_cbqri: Add CBQRI cache capacity-allocation
 platform driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260619-dfustini-atl-sc-cbqri-dt-v1-8-e79a7723fab0@kernel.org>
References: <20260619-dfustini-atl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org>
 <20260619-dfustini-atl-sc-cbqri-dt-v1-8-e79a7723fab0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 18:41:04 +0000
Message-Id: <20260619184104.F1C4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] `get_cpu_cacheinfo_level()` fails to discover capacity controllers=
 on split caches.

Pre-existing issues:
- [High] Global list `cbqri_controllers` is modified concurrently without a=
 lock.
--

commit a409dc1e72a5139a209d981205820cfe3a0eb512
Author: Drew Fustini <fustini@kernel.org>

riscv_cbqri: Add CBQRI cache capacity-allocation platform driver
   =20
The CBQRI core exposes riscv_cbqri_register_cc_dt() so a device-tree
platform driver can register a capacity controller whose cache topology
it already knows.

> diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_cap=
acity.c
> new file mode 100644
> index 0000000000000..2172432eb3287
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_capacity.c

[ ... ]

> +	/*
> +	 * Associate the controller with its cache instance via
> +	 * cacheinfo. The matching cache provides the cache id and the
> +	 * set of harts that share the cache.
> +	 */
> +	cache_id =3D -1;
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		struct cacheinfo *ci =3D get_cpu_cacheinfo_level(cpu, cache_level);
> +
> +		if (ci && ci->fw_token =3D=3D cache_np) {
> +			cache_id =3D ci->id;
> +			cpumask_copy(cpu_mask, &ci->shared_cpu_map);
> +			break;
> +		}
> +	}
> +	cpus_read_unlock();

[Severity: High]
Will this fail to discover capacity controllers on split caches?

get_cpu_cacheinfo_level() only returns the first cache leaf that matches
the requested level and stops searching. If a CPU has multiple caches at
the same level (e.g., split L1 Instruction and L1 Data caches), and the
capacity controller governs the second one, get_cpu_cacheinfo_level() will
return the first cache. Its fw_token will not match cache_np.

Consequently, the loop will never find the matching cache, cache_id will
remain -1, and the probe will incorrectly fail with -ENODEV.

[ ... ]

> +	info.type =3D CBQRI_CONTROLLER_TYPE_CAPACITY;
> +	info.addr =3D res->start;
> +	info.size =3D resource_size(res);
> +	info.rcid_count =3D rcid_count;
> +	info.cache_id =3D cache_id;
> +
> +	ret =3D riscv_cbqri_register_cc_dt(&info, cache_level, cpu_mask);
> +	if (ret) {
> +		dev_err(dev, "failed to register capacity controller: %d\n", ret);
> +		goto out_free;
> +	}

[Severity: High]
This is a pre-existing issue, but can this trigger list corruption if
multiple instances of the platform driver probe concurrently?

The probe function cbqri_capacity_probe() calls
riscv_cbqri_register_cc_dt(). Inside riscv_cbqri_register_cc_dt(), the newly
allocated controller is appended to the global cbqri_controllers list:

riscv_cbqri_register_cc_dt() {
    ...
    list_add_tail(&ctrl->list, &cbqri_controllers);
    return 0;
}

This modification happens without any locks. If the driver core probes
multiple CBQRI devices concurrently (e.g., due to asynchronous probing),
list_add_tail() will race on the shared list. Additionally, an asynchronous
probe could race with CPU hotplug events iterating over cbqri_controllers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-dfustini-a=
tl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org?part=3D8
