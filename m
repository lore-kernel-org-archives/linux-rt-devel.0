Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E53C4B91;
	Tue, 23 Jun 2026 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200707; cv=none; b=rS6Si39nF0bvEv9oRFoIJYQZu0NMtlNQkMm9MsszdJ5gosVuQenLN7SzX0Kgge2uLnVLXJelhTNGh5c7Bs8nBu2tGbY4IbWd2xvCkfoky5IVim/8A9ycbOLZ0MRmVs4OonjE9B2zqmvPaleFcuyKnfr5fSjSk6cYH/HupCv4V9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200707; c=relaxed/simple;
	bh=Ma/LtFg4NQwrfP5qWJRSc/6F5wDSbMuqrMqkCKWCbZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uQ6L6T7Ly0UVdXdXKp4JCPv4A1FK6Oa6vDn40WAzblqhMx5Am8uc69s7IwiiN6RYbqBymZABspAnxm65gwzKK7hbW+OH+ynfXOtxO2Vs/gAN3CIr3QU6ybyIbaJyowtuLbCmeYMLciHOllqA/h26/ac2+xf6j0jsfTN4IMdIJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU08bFJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU08bFJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477D21F000E9;
	Tue, 23 Jun 2026 07:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782200705;
	bh=WX6/fUJlkDZd5Y6/2Iwf/S0NcF4s25maCUC0kmxPow8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KU08bFJIcQEnctag3UrGW28m2Cf+HH9Fm7CbJ2fLL46nLWCtr4z4vC8mfB/qibeZD
	 0hVu3VfUEGd/4vBbwUFwIwHUpusB+78SqXjTxIS8suBouOHwO2Edt+yNbh4S/jNM/i
	 TFFoOB8fnMHWVujvi+H+FspmM7LXolfdz5CKZzUghplL25IX0oVU6zwyBSfYjtLLKZ
	 1zE/ByNMwtv5mnxVjM5eopXN+Vs6fwOAQLhZ82xiVJqfH6TjFrToSvR9EiORN1Ts/O
	 RizxhfmNNTys5BMmnWbrdYK9y+sRwDFa/yrSZaGosOGKvi0c69gEQpwGqVVqjJm8aK
	 /YR6C2hfZAAnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] net: mvneta: re-enable percpu interrupt on resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Zhou" <yun.zhou@windriver.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260622074350.1666290-1-yun.zhou@windriver.com>
References: <20260622074350.1666290-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 07:45:04 +0000
Message-Id: <20260623074505.477D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe call to mvneta_set_rx_mode() without netif_addr_lock_bh() i=
n PM resume.
- [High] Race condition in mvneta_open() and mvneta_resume() with CPU hotpl=
ug causing double napi_enable().
--

commit bf4b34826006aca50b2726e755de72b6f2a7c330
Author: Yun Zhou <yun.zhou@windriver.com>

net: mvneta: re-enable percpu interrupt on resume

On Marvell MPIC platforms (Armada 370/XP/38x), mvneta uses a percpu IRQ=20
disable/enable scheme for NAPI. This commit fixes an issue where the MPIC=20
per-CPU interrupt stays masked permanently after suspend by unmasking it=20
unconditionally during the resume path.

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet=
/marvell/mvneta.c
> index 0c061fb0ed072..744d6585a949d 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -5900,6 +5900,9 @@ static int mvneta_resume(struct device *device)
>  	rtnl_unlock();
>  	mvneta_set_rx_mode(dev);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call=20
mvneta_set_rx_mode() here without holding netif_addr_lock_bh()?

The mvneta_set_rx_mode() function iterates over the net_device's multicast=
=20
list:

drivers/net/ethernet/marvell/mvneta.c:mvneta_set_rx_mode() {
	...
			if (!netdev_mc_empty(dev)) {
				netdev_for_each_mc_addr(ha, dev) {
					mvneta_mcast_addr_set(pp, ha->addr,
							      pp->rxq_def);
				}
			}
	...
}

Since rtnl_unlock() is called immediately before this, it looks like this=20
unprotected iteration could race with concurrent softirqs handling IGMP/MLD=
=20
packets. Could this corrupt the list and lead to use-after-free crashes or=
=20
infinite loops?

> =20
> +	if (!pp->neta_armada3700)
> +		on_each_cpu(mvneta_percpu_enable, pp, true);
> +

[Severity: High]
This is a pre-existing issue, but does the resume path have a race conditio=
n=20
with CPU hotplug?

In functions like mvneta_open() and mvneta_resume(), the device is added to=
=20
the CPU hotplug state via cpuhp_state_add_instance_nocalls() without=20
preventing concurrent hotplug events (e.g., via cpus_read_lock()).

If a CPU hotplug event triggers concurrently, mvneta_cpu_online() could cal=
l=20
napi_enable_locked() for the new CPU:

drivers/net/ethernet/marvell/mvneta.c:mvneta_cpu_online() {
	...
	napi_enable_locked(&port->napi);
	...
}

If mvneta_start_dev() then runs and blindly iterates over all online CPUs=20
calling napi_enable(), could this result in a double napi_enable() on the=20
same NAPI instance and trigger a BUG_ON() panic in the core NAPI code?

>  	return 0;
>  }
> #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622074350.1666=
290-1-yun.zhou@windriver.com?part=3D1
