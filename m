Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A95478E39;
	Tue, 18 Aug 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067743; cv=none; b=oZZjx7rIngIzjQWGjbLzMXr6nBTFVMjP8nhyKhEUcfT6kHDa1rg4WcI134LgSI9IxS9KwrAVherZuHVdykuHW0rVubi6av3Yc8vxMNvZHNYSmOfvI4Te+P7mO1lpsdK31RVw6GgsxlvDCvgSIhLJOS0evpa/ilon9qUzd+Lu8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067743; c=relaxed/simple;
	bh=xFaVxfjHVzkEbO3e5d9m4H5orn7hyydM/xGLXN/E9D4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sNsXPKBHxSp9+5Buv8BV9JkWdiirbxROjoX0CZdR2gU9Xwxe/EvRQClw37K3WMu1tXipho40mznTU7xVM/fn1mS/y28SPJIfGatAv/hrNCY49DrPiwTYfnOeLaVVeaEssJJymA4MzymBsgtAuds/33G3eCx6ottDdri1IOeViU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjiOQmxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjiOQmxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540831F000E9;
	Tue, 18 Aug 2026 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787067741;
	bh=uJcCpMImIvzGL1vfYedIR0z39i5TJ8F6Fv5CYaZck6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QjiOQmxdEBZDG7IJ0vunzEhct0A8hSohPIC1REkN+z2+BfclTd1t2AbyoV5ZsLWct
	 +1pRNvH2MeXBM5uCjbWml2VOZUBjr/NQQbIKThTwjPsQCO68a4Q0INiuKWXKHOVi+K
	 G/zngy+9F5dP2/voikQWgngGUMXNMm1AquO3XZVdRGDR2wXqwNyU7QW3sS8rUDoNaJ
	 7vnaOpCoMxhtU9/kuMW7CU0YVvnYN9sNxQFDTpSxZ++JSgCxl4eAgT6twirhUSXqZH
	 DbZM4gvG+80SgvwtGlkF1yQPpNof9OZGMCvr8zR47jQI8DvnfaWNRah0RacLIyEPXM
	 vgZ7hVJXbYT2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] net: sparx5: fix sleep in atomic context in
 MAC table access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260817-misc-fixes-sparx5-lan969x-v3-2-c7c7fef723a8@microchip.com>
References: <20260817-misc-fixes-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com>
 <20260817-misc-fixes-sparx5-lan969x-v3-2-c7c7fef723a8@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:42:20 +0000
Message-Id: <20260818154221.540831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The switchdev bridge join/leave handlers manually call `__dev_mc_s=
ync` and `__dev_mc_unsync` without holding `netif_addr_lock_bh`, corrupting=
 `dev->mc` list.
- [High] The driver destroys its workqueue prior to unregistering the notif=
iers that submit work to it, causing a use-after-free.
- [High] Dynamic FDB MAC entries use `devm_kzalloc` and `devm_kfree`, causi=
ng severe O(N) devres list traversal overhead leading to lockups.
--

--- Patch [2]: [PATCH net v3 2/2] net: sparx5: fix sleep in atomic context =
in MAC table access ---
commit 0271557455a8033457131b5edf4c50d634d7c1d7
Author: Daniel Machon <daniel.machon@microchip.com>

net: sparx5: fix sleep in atomic context in MAC table access

This commit converts the sparx5 driver to use the ndo_set_rx_mode_async
callback to avoid sleeping in atomic context. The previous ndo_set_rx_mode
implementation polled the MAC access command register under a mutex, which
is not allowed from atomic context.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/driv=
ers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> index 1d34af78166a3..4dedf5d926416 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> @@ -162,13 +162,18 @@ static int sparx5_port_stop(struct net_device *ndev)
>  	return 0;
>  }
> =20
> -static void sparx5_set_rx_mode(struct net_device *dev)
> +static int sparx5_set_rx_mode(struct net_device *dev,
> +			      struct netdev_hw_addr_list *uc,
> +			      struct netdev_hw_addr_list *mc)
>  {
>  	struct sparx5_port *port =3D netdev_priv(dev);
>  	struct sparx5 *sparx5 =3D port->sparx5;
> =20
>  	if (!test_bit(port->portno, sparx5->bridge_mask))
> -		__dev_mc_sync(dev, sparx5_mc_sync, sparx5_mc_unsync);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the
__dev_mc_sync changes, I noticed a pre-existing issue in the switchdev code.
The bridge join/leave handlers manually call __dev_mc_sync() and
__dev_mc_unsync() without holding netif_addr_lock_bh:

drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c:sparx5_port_bridge=
_join() {
    ...
    __dev_mc_unsync(ndev, sparx5_mc_unsync);
    ...
}

drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c:sparx5_port_bridge=
_leave() {
    ...
    __dev_mc_sync(port->ndev, sparx5_mc_sync, sparx5_mc_unsync);
    ...
}

Since these are called under rtnl_lock but without netif_addr_lock_bh, could
this corrupt the dev->mc linked list if there are concurrent unprivileged
multicast mutations (like IGMP/MLD)?

> +		return __hw_addr_sync_dev(mc, dev, sparx5_mc_sync,
> +					  sparx5_mc_unsync);
> +
> +	return 0;
>  }

[ ... ]

[Severity: High]
This is a pre-existing issue, but does module removal destroy the workqueue
while the switchdev notifier is still active?

drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c:sparx5_unregister_=
notifier_blocks() {
    ...
    destroy_workqueue(sparx5_owq);
   =20
    unregister_switchdev_blocking_notifier(&s5->switchdev_blocking_nb);
    unregister_switchdev_notifier(&s5->switchdev_nb);
    ...
}

If a concurrent switchdev FDB event occurs after destroy_workqueue() but
before unregister_switchdev_notifier(), sparx5_switchdev_event() might
queue work on the destroyed workqueue. Can this sequence result in a
use-after-free and kernel panic?

[Severity: High]
This isn't a bug introduced by this patch, but does the driver use devres
allocations for highly dynamic network state?

drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c:alloc_mact_entry() {
    ...
    mact_entry =3D devm_kzalloc(sparx5->dev,
                              sizeof(*mact_entry), GFP_ATOMIC);
    ...
}

drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c:sparx5_del_mact_ent=
ry() {
    ...
    devm_kfree(sparx5->dev, mact_entry);
    ...
}

Because devm_kfree() linearly scans the entire devres list under the
dev->devres_lock spinlock with IRQs disabled, could this cause severe O(N)
traversal overhead and lockups when handling thousands of dynamic FDB MAC
entries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-misc-fixes=
-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com?part=3D2
