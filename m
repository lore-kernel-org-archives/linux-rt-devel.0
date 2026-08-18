Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D92931DB;
	Tue, 18 Aug 2026 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067744; cv=none; b=YQkzNIuRVm6jkY9wxbMZobgG6Wu54uU2bSA6diojIJZhgApa92kSYJojRew6GGmFLrnwJMcDesQSjbEvc7ASNJ9rHo15Svh5FyR2iCPSnQstaF8ey9SCnlfzZ++6h/vMkyH1IfcxuLoyz6XsHLVpfgqYuNwZ2pK/Qf4asAaDX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067744; c=relaxed/simple;
	bh=ZlV/oLL4Pw+houc+xIORV3dHefVioLh1y2FmyHFwavs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e+nCPaSInGUsPxKigRdZi5Mr+ZvOje2EleEcjut+3rhz1uzh1dt2sjU97XJIlLGUzEzpzfTEJHaGJaUVAhk7ZQp5Rl0a5R+w00sKKC+U+wLqBjfSnZ0dTx5CGeuqJ1cSNi4Csu2VFBui5v6OCT2CWyKPnTIg1LLYuB1mF3QNTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7SVnuqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7SVnuqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F8E1F00A3A;
	Tue, 18 Aug 2026 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787067742;
	bh=azFYAMbe1AKxbeHo2jztpGi5FY/M0a7bt+1Sjy+U3sQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B7SVnuqjreciwex4it6w9G+KWu21m3DzAOkWv3oLS8NGqbNRf3rkiH353CWMeK1Ul
	 SlB0EmAgqNlnZXhEUgBQ5ff5K28BND6jV0/XemjQfYo1UouIsW1ZDhrLnBwopXf1Fx
	 G1qcMh0DMp75EPksLTm/yXTr3YX2aaA1fIzxB0R7hiJuXdHbnNQmSClYPHPNcEkorb
	 fDhGZlTK1vhSavJJJTE/jnRyfQiq09DGyBfldghoszM4wLXhSNQPAb9DfUMn1O6DVk
	 cSdqudmEKWbf/PpK9fNq5sjG7EtfpcZlBjTCGEZf0l5HPWeFatj007SGgzHxqGSFQG
	 EZbGm29e7Zdzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/2] net: microchip: vcap: use port number
 instead of netdev name for debugfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260817-misc-fixes-sparx5-lan969x-v3-1-c7c7fef723a8@microchip.com>
References: <20260817-misc-fixes-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com>
 <20260817-misc-fixes-sparx5-lan969x-v3-1-c7c7fef723a8@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:42:21 +0000
Message-Id: <20260818154221.D7F8E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing debugfs_remove_recursive() on the probe error path leaves =
stranded debugfs files that trigger Use-After-Free when accessed.
- [High] Failure in vcap_debugfs() drops per-port debugfs files into the gl=
obal debugfs root, leading to UAF on module unload.
--

--- Patch [1]: [PATCH net v3 1/2] net: microchip: vcap: use port number ins=
tead of netdev name for debugfs ---
commit 8d862146f79389830b4bf1733e4f4af6bbff212d
Author: Daniel Machon <daniel.machon@microchip.com>

net: microchip: vcap: use port number instead of netdev name for debugfs

This commit introduces vcap_port_debugfs_portno() to create debugfs
entries using the hardware port number instead of the netdev name. This
resolves boot warnings in sparx5_vcap_init() when netdev names are not
yet registered.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/d=
rivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> index cf332de6bf736..2dee2ce19fce7 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
> @@ -2077,8 +2077,9 @@ int sparx5_vcap_init(struct sparx5 *sparx5)
>  	dir =3D vcap_debugfs(sparx5->dev, sparx5->debugfs_root, ctrl);
>  	for (idx =3D 0; idx < consts->n_ports; ++idx)
>  		if (sparx5->ports[idx])
> -			vcap_port_debugfs(sparx5->dev, dir, ctrl,
> -					  sparx5->ports[idx]->ndev);
> +			vcap_port_debugfs_portno(sparx5->dev, dir, ctrl,
> +						 sparx5->ports[idx]->ndev,
> +						 sparx5->ports[idx]->portno);

[Severity: High]
This isn't a bug introduced by this patch, but what happens if vcap_debugfs=
()
fails to allocate memory and returns NULL?

In drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c:vcap_debugfs():

	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
	if (!info)
		return NULL;

If dir is NULL here, passing it as the parent to vcap_port_debugfs_portno()
will cause debugfs_create_file() to create the port debugfs files in the
global debugfs root (e.g., /sys/kernel/debug/p0).

When the module is unloaded, the driver only cleans up sparx5->debugfs_root,
abandoning the files in the global root. The devm-managed backing data
is freed, so reading these abandoned files afterward will cause a
use-after-free.

>  	return err;
>  }
> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c b/dri=
vers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
> index e0c65c7ab23e1..476f7496a9d44 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c

[ ... ]

> @@ -400,6 +400,27 @@ void vcap_port_debugfs(struct device *dev, struct de=
ntry *parent,
>  }
>  EXPORT_SYMBOL_GPL(vcap_port_debugfs);
> =20
> +void vcap_port_debugfs_portno(struct device *dev,
> +			      struct dentry *parent,
> +			      struct vcap_control *vctrl,
> +			      struct net_device *ndev,
> +			      unsigned int portno)
> +{
> +	struct vcap_port_debugfs_info *info;
> +	char name[16];
> +
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does the probe error path properly
clean up these debugfs files?

During initialization, mchp_sparx5_probe() creates sparx5->debugfs_root and
populates it with files backed by this devm_kzalloc() memory.

If a subsequent probe step fails (such as sparx5_register_netdevs()), the
error cleanup path does not seem to call debugfs_remove_recursive().

Since the devres framework automatically frees this memory on probe failure
but the files remain in the filesystem, could this lead to a use-after-free
if a user later reads one of these leaked debugfs files?

> +	if (!info)
> +		return;
> +
> +	info->vctrl =3D vctrl;
> +	info->ndev =3D ndev;
> +
> +	snprintf(name, sizeof(name), "p%u", portno);
> +	debugfs_create_file(name, 0444, parent, info, &vcap_port_debugfs_fops);
> +}
> +EXPORT_SYMBOL_GPL(vcap_port_debugfs_portno);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-misc-fixes=
-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com?part=3D1
