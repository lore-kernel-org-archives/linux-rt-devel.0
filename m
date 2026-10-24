Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792825437;
	b=QDxL+xrKdri+8S4Q2zRgJBhvEZVtdhm3tFBJWQa8zDnPl9FZnLh4cCpKKHCzlxPIGtqI
	 DiziOLcjab/+4YW5jKlA4g7ZXyiOQyMi3BSy8+kmuKtL9WJScmSmvRUZjcNmFJVavm5KT
	 Sv5J8aonpbQOQhIg5UcWGsesL4FtNruzj60Q7wQOUP6T3t03w/qqqav3NCb4YWexrSs4G
	 /1S7n9y58q0BR7aVJtcsI8jZik/a1zlId3MdTG5G/qj3pl9lVDo3AqrRHvU7RIQCOuXua
	 Z56ueQ1XjvhwyFofYZR4sf1QdikoWY4/CaKFtpqxWLYN+TO5wLX4UOqmkHH6DvzVfDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792825437;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2FdeqYZg0t+ii5NnwM8v7ZVFrQHVdVZTti3YtFSfjtk=;
	b=bW+OfQZyaEGJ/aa+XATF4cO68kV7NEo4I1w+DhP29wXYymMpmXi+Diamsr9/ZoXvysCQ
	 BCH9sCutg77BvjQ7Me0XjKtLdCAlTMG0bmiUw/uXHHM67guhBF26rF/tnSLF5flhILc66
	 tCesivNx6dAANwNzP4SO0i4FPAynuoKVd9Vro9q6IqjdcmrkY3XgaGiD0YBPzV553sCHZ
	 yVfPo0cQLUjE+BgikbfpFvAsDftosedYAK4IfbFL5ndLorW4gojrAap13IcTisJas9QI0
	 ld4sUcqFLZQ4g5VbSW3njijQcC25Djpui7TRor9aL6zSTkmnA7rRS2HXb/6l/U2FjPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O/F0XP2O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA362606A31E;
	Sat, 24 Oct 2026 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O/F0XP2O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F721F01828;
	Sat, 24 Oct 2026 07:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792825436;
	bh=2FdeqYZg0t+ii5NnwM8v7ZVFrQHVdVZTti3YtFSfjtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/F0XP2OBz8PlHx4SnKE8Fle2Ln5XX4kiHYoqARouBvRnRM+OuKBUEc1a8rjrF+dt
	 irb2gsI/FFu6eylkgB0iIWe6UsDHlPZ3N52/FqS1f+TANdEbnTVFZIpJKsmaI2XAS9
	 GvFginHrMCqXt3km2uSnJTf4jpgACer1BLxA/+kM9HPYkf85kPhl7uR39NbXBuodDI
	 jiL+hw5v5pQWXzzQQGXHtM1x8do5cs9ACQMXfAicGIkfD7mRkoMU3xkCQXviSuiDzX
	 VNNSZxFd6fx76ClMP/Le4e/rgrO90f+j4JkdxF9uTd/yF81kKyPZU5gPr5EHiL8fBE
	 VNq3Ni7fW0/Sg==
Message-ID: <sashiko-outbox-183581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v2 5/5] ice: do not block on the aux device lock
 in ndo_setup_tc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Oros" <poros@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261023070258.730168-6-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
 <20261023070258.730168-6-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 07:03:56 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ice: orphaned channel VSIs and memory leak when ice_setup_tc() fai=
ls teardown
--

commit 58934f25b30092ac8064d34365ba48edb6a32a06
Author: Petr Oros <poros@redhat.com>

ice: do not block on the aux device lock in ndo_setup_tc

This commit replaces device_lock() with device_trylock() on the RDMA
auxiliary device in the TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() to
avoid a lock dependency cycle with the RTNL lock, returning -EBUSY when
the lock is contended.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index 9de375f5c4deb..7eb653a7ebacd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -9451,7 +9451,12 @@ ice_setup_tc(struct net_device *netdev, enum tc_se=
tup_type type,
>  			mutex_lock(&pf->adev_mutex);
>  			adev =3D cdev->adev;
>  			if (adev) {
> -				device_lock(&adev->dev);
> +				if (!device_trylock(&adev->dev)) {
> +					mutex_unlock(&pf->adev_mutex);
> +					netdev_warn(netdev, "RDMA auxiliary device is busy, qdisc not chang=
ed\n");
> +					err =3D -EBUSY;
> +					goto tc_unlock;
> +				}

[Severity: High]
Can failing with -EBUSY during qdisc removal permanently leak the
struct ice_channel entries on vsi->ch_list and leave channel VSI state
orphaned?

The commit message notes that when the qdisc is deleted,
mqprio_disable_offload() ignores the return value so the hardware traffic
classes and channel VSIs stay in place until a later qdisc teardown gets
through.

However, in net/sched/sch_mqprio.c, mqprio_destroy() calls
mqprio_disable_offload() once while destroying the Qdisc:

net/sched/sch_mqprio.c:mqprio_destroy() {
	...
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

Once mqprio_destroy() finishes, the Qdisc object is freed and no mqprio
Qdisc remains attached to the net_device, so no subsequent teardown call
will happen for it (including on unregister_netdev()).

During driver unload (ice_remove() -> ice_unload() -> ice_deinit() ->
ice_vsi_release_all()), ice_deinit_pf_sw() releases the main VSI without
calling ice_remove_q_channels(), and ice_vsi_release_all() skips
ICE_VSI_CHNL VSIs:

drivers/net/ethernet/intel/ice/ice_main.c:ice_vsi_release_all() {
	...
		if (pf->vsi[i]->type =3D=3D ICE_VSI_CHNL)
			continue;

		err =3D ice_vsi_release(pf->vsi[i]);
	...
}

Moreover, if a user later adds a new offloaded mqprio qdisc (hw !=3D 0) to
attempt another teardown, ice_setup_tc_mqprio_qdisc() only removes existing
channels when disabling offload:

drivers/net/ethernet/intel/ice/ice_main.c:ice_setup_tc_mqprio_qdisc() {
	...
	if (!hw && !test_bit(ICE_FLAG_TC_MQPRIO, pf->flags))
		ice_remove_q_channels(vsi, true);
	...
	if (hw) {
		...
		ret =3D ice_create_q_channels(vsi);
		...
	}
}

Wouldn't adding a new offloaded mqprio qdisc leave the old struct
ice_channel entries on vsi->ch_list, rebuild the main VSI rings, and append
duplicate channels via ice_create_q_channels(), potentially indexing past
vsi->tx_rings[] and vsi->rx_rings[] in ice_remove_q_channels() if the new
qdisc configures fewer queues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023070258.7301=
68-1-poros@redhat.com?part=3D5
