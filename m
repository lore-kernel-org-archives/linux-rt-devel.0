Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792825436;
	b=MBByK+RHV+7vQujvG3Ndi3WvSu+kTJsYEfXRtnfhCl4r3AF7u1jVLD/5b/KBBqXFAHRz
	 f+jGTaNY/8SaEjlKH5+ibUNTVj08OaNs+2AxANLi3xgv/Sssd4zdFfiHa6xyfDGH82S/j
	 3CDBcJHVYpFPfmld9cxZErwDda/v6p7YEQYf9c1aJ8AY4187DUYumjEgWGkJmw5tERtw0
	 9XSo+huBaF8EpKa40bZ8L85qbFQdLeYyokpOQfhwQhMrNRGo0h8ACJoESxgcLKa8CyFa5
	 TxXPKj1ruiXvFbG3hJ3N8k2b3BYMCwoRkwR+q17MDKx1yx3Uy23E7gkp6iUgVntcdDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792825436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yrjT2zKROfzZYFkQjkjZVkcJKooPMH1EarRQ32hBJzc=;
	b=lSOmTe96waUraXiOJkppCQx/Cl0V4WcD0hnoa4z2QM4i7hfzXAsbXlKmfHtWFVbNIUID
	 BJTlAcR3opfQCUfmgv11PHGJJsrSEK69icBc33Jwla45rbz2tfH9eTk1F6UQKydNEaKtj
	 AHYNQnmgGNdExmDH6kiri9S48rovpYuuODxUW7v4ppym+GpEAO777/MLYvrI1ig5EbdQb
	 jQmHMb7EYpnVTKss2xw+qKgiWUoN0MTr2/G+/MlzS7et6i8wITbXRHQYXRavASOBK0nGl
	 qP4fvdf2BjdDu564V8P8qGciDhXQOa4ZiRk4ofzwzk5nuN77iJ5DgLB6xOQ4RFDYXfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYPBnpI7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D21606A31A;
	Sat, 24 Oct 2026 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYPBnpI7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A3E1F01825;
	Sat, 24 Oct 2026 07:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792825436;
	bh=yrjT2zKROfzZYFkQjkjZVkcJKooPMH1EarRQ32hBJzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GYPBnpI7ySDWyq4vygWt6gr/6ttk+KjlZ4qG/+84OqhGIYvikRKmKTQawOR+zP2yd
	 Ch9LIk90YrG2Z2sjdEETh/e5yqeJqQ4ZkiMWH5Vi6a7HeFDiwSK+i0Z/ag26KQT5/d
	 0+fqfKJBKjjUI5wuXiUcHFRyN/0JZseMPXpOQbfwjmWuFRjiVlkEKxFieAGg9lqsSO
	 GwpidlmJNE3ufrMQTjSzdkHA4UH2bM4T4ysE+dnt0GTbTMnO52Al+XnIYEPzj/NoKA
	 5iYVA/v/bK8S26uZibiEK/hEp13rzbhy9ZPhoOCt7iAmx1Ok1AeuyuM4fyoRHVVm9O
	 fWA0vcby+5NrA==
Message-ID: <sashiko-outbox-183579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v2 3/5] ice: avoid RTNL deadlock when notifying
 the RDMA auxiliary driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Oros" <poros@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261023070258.730168-4-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
 <20261023070258.730168-4-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 07:03:55 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] ice: premature AFTER_TC_CHANGE and unlock before ice_dcb_noncontig=
_cfg()
- [High] ice: inconsistent QoS and DCB state on error path in ice_pf_dcb_cf=
g()
- [Medium] ice: unrolled state mutations when ice_pf_dcb_cfg() fails with -=
EBUSY
--

commit 0b49c36f284346b01578d0498826a110d7c3a315
Author: Petr Oros <poros@redhat.com>

ice: avoid RTNL deadlock when notifying the RDMA auxiliary driver

This commit avoids an ABBA deadlock between rtnl_lock and the RDMA
auxiliary device lock by acquiring the auxiliary device lock with
device_trylock() via ice_aux_dev_trylock() around RDMA event delivery.
In ice_pf_dcb_cfg(), the locks are held across the DCB reconfiguration
from IIDC_RDMA_EVENT_BEFORE_TC_CHANGE through
IIDC_RDMA_EVENT_AFTER_TC_CHANGE, and the non-contiguous traffic class
fallback is deferred until after the locks are released.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/e=
thernet/intel/ice/ice_dcb_lib.c
> index 0bc6dd3756879..9916bd408071c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> @@ -5,6 +5,9 @@
>  #include "ice_dcb_nl.h"
>  #include "devlink/devlink.h"
> =20
> +static bool ice_dcb_tc_contig(u8 *prio_table);
> +static int ice_dcb_noncontig_cfg(struct ice_pf *pf);
> +
>  /**
>   * ice_dcb_get_ena_tc - return bitmap of enabled TCs
>   * @dcbcfg: DCB config to evaluate for enabled TCs
> @@ -352,11 +355,16 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dc=
bx_cfg *new_cfg, bool locked)
>  	struct ice_aqc_port_ets_elem buf =3D { 0 };
>  	struct ice_dcbx_cfg *old_cfg, *curr_cfg;
>  	struct device *dev =3D ice_pf_to_dev(pf);
> +	struct iidc_rdma_priv_dev_info *privd;
> +	struct iidc_rdma_core_dev_info *cdev;
>  	struct iidc_rdma_event *event;
>  	int ret =3D ICE_DCB_NO_HW_CHG;
>  	struct ice_vsi *pf_vsi;
> +	bool noncontig =3D false;
> +	bool dcb_ena;
> =20
>  	curr_cfg =3D &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
> +	dcb_ena =3D test_bit(ICE_FLAG_DCB_ENA, pf->flags);

[ ... ]

> @@ -405,16 +413,21 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dc=
bx_cfg *new_cfg, bool locked)
>  		goto free_cfg;
>  	}
> =20
> -	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
> -	ice_send_event_to_aux(pf, event);
> -	kfree(event);
> -
>  	/* avoid race conditions by holding the lock while disabling and
>  	 * re-enabling the VSI
>  	 */
>  	if (!locked)
>  		rtnl_lock();
> =20
> +	if (!ice_aux_dev_trylock(pf)) {
> +		assign_bit(ICE_FLAG_DCB_ENA, pf->flags, dcb_ena);
> +		ret =3D -EBUSY;
> +		goto unlock_rtnl;
> +	}

[Severity: Medium]
When ice_aux_dev_trylock(pf) fails here and returns -EBUSY, what happens to
the state mutations that already took place earlier in ice_pf_dcb_cfg() and
its callers?

Earlier in ice_pf_dcb_cfg(), when ice_dcb_get_num_tc(new_cfg) > 1,
ice_tear_down_devlink_rate_tree(pf) has already run before
ice_aux_dev_trylock(pf):

    if (ice_dcb_get_num_tc(new_cfg) > 1) {
        if (pf->hw.port_info->is_custom_tx_enabled) {
            ...
            return -EBUSY;
        }
        ice_tear_down_devlink_rate_tree(pf);

        set_bit(ICE_FLAG_DCB_ENA, pf->flags);
    }

Unlike the is_custom_tx_enabled check, failing at ice_aux_dev_trylock(pf)
reverts ICE_FLAG_DCB_ENA while leaving the devlink rate tree torn down.

In addition, callers that configure 1 TC (where is_custom_tx_enabled could
never trigger), such as ice_dcb_sw_dflt_cfg() and ice_dcb_init_cfg(), zero
pi->qos_cfg.local_dcbx_cfg with memset() before calling ice_pf_dcb_cfg():

    memset(&pi->qos_cfg.local_dcbx_cfg, 0, sizeof(*dcbcfg));
    ...
    ret =3D ice_pf_dcb_cfg(pf, dcbcfg, locked);

If ice_aux_dev_trylock(pf) returns -EBUSY before curr_cfg is populated,
does local_dcbx_cfg remain completely zeroed out? Similarly, in
ice_dcbnl_setapp(), a negative return from ice_pf_dcb_cfg() is converted to
ICE_DCB_NO_HW_CHG without rolling back dcb_ieee_setapp(), dscp_mapped,
desired_dcbx_cfg, or ice_aq_set_pfc_mode().

> +
> +	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
> +	ice_send_event_to_aux(pf, event);
> +
>  	/* disable VSIs affected by DCB changes */
>  	ice_dcb_ena_dis_vsi(pf, false, true);
> =20
> @@ -441,13 +454,28 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dc=
bx_cfg *new_cfg, bool locked)
>  		goto out;
>  	}
> =20
> -	ice_pf_dcb_recfg(pf, false);
> +	ice_pf_dcb_recfg(pf, true);
> +	noncontig =3D !ice_dcb_tc_contig(curr_cfg->etscfg.prio_table);
> =20
>  out:
> +	cdev =3D pf->cdev_info;
> +	if (cdev) {
> +		privd =3D cdev->iidc_priv;
> +		ice_setup_dcb_qos_info(pf, &privd->qos_info);
> +	}
> +	clear_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
> +	set_bit(IIDC_RDMA_EVENT_AFTER_TC_CHANGE, event->type);
> +	ice_send_event_to_aux(pf, event);

[Severity: High]
Can jumping to out on error leave curr_cfg, ICE_FLAG_DCB_ENA, and
privd->qos_info inconsistent with the actual VSI configuration and cause
active RDMA queue pairs to transition to the error state?

In ice_pf_dcb_cfg(), if ice_set_dcb_cfg() succeeds (updating firmware and
PRTDCB_TUP2TC) but ice_query_port_ets() fails and jumps to out:

1. curr_cfg still contains new_cfg (unlike the ice_set_dcb_cfg() failure
   path, which restores old_cfg), and neither error path restores
   ICE_FLAG_DCB_ENA to dcb_ena.

2. Because ice_pf_dcb_recfg(pf, true) was skipped, vsi->tc_cfg.ena_tc still
   only has the old traffic classes enabled.

3. At out, ice_setup_dcb_qos_info(pf, &privd->qos_info) populates
   privd->qos_info from the new curr_cfg and PRTDCB_TUP2TC register, and
   ice_send_event_to_aux() delivers IIDC_RDMA_EVENT_AFTER_TC_CHANGE.

When irdma handles IIDC_RDMA_EVENT_AFTER_TC_CHANGE via
icrdma_iidc_event_handler() -> irdma_change_l2params() ->
irdma_sc_suspend_resume_qps(), it attempts to resume QPs on the new TCs in
qos_info->up2tc[] via irdma_ws_add() -> icrdma_lan_register_qset() ->
ice_add_rdma_qset(). Since vsi->tc_cfg.ena_tc was never updated for those
new TCs, ice_ena_vsi_rdma_qset() fails with -EINVAL, causing
irdma_sc_suspend_resume_qps() to call irdma_modify_qp_to_err() on the QPs.

> +	ice_aux_dev_unlock(pf);
> +
>  	/* enable previously downed VSIs */
>  	ice_dcb_ena_dis_vsi(pf, true, true);
> +	if (noncontig)
> +		ice_dcb_noncontig_cfg(pf);

[Severity: High]
When a DCB configuration has non-contiguous traffic classes in
curr_cfg->etscfg.prio_table, does deferring ice_dcb_noncontig_cfg(pf) until
after IIDC_RDMA_EVENT_AFTER_TC_CHANGE and ice_aux_dev_unlock(pf) break RDMA
QP resume?

Previously, ice_pf_dcb_cfg() called ice_pf_dcb_recfg(pf, false), which saw
!ice_dcb_tc_contig(dcbcfg->etscfg.prio_table) and immediately ran
ice_dcb_noncontig_cfg(pf) to reset local_dcbx_cfg and hardware PRTDCB_TUP2TC
back to the default TC0 configuration before populating privd->qos_info,
sending IIDC_RDMA_EVENT_AFTER_TC_CHANGE, or re-enabling the VSIs.

With this change:

1. ice_set_dcb_cfg() programs the non-contiguous prio_table into hardware
   PRTDCB_TUP2TC.

2. ice_pf_dcb_recfg(pf, true) configures the PF VSI with
   tc_map =3D ICE_DFLT_TRAFFIC_CLASS (only TC0 enabled in vsi->tc_cfg.ena_t=
c)
   and skips ice_dcb_noncontig_cfg(pf) because locked is true.

3. Before ice_dcb_noncontig_cfg(pf) runs, ice_setup_dcb_qos_info() reads
   PRTDCB_TUP2TC from hardware:

    dcbx_cfg =3D &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
    up2tc =3D rd32(&pf->hw, PRTDCB_TUP2TC);

    qos_info->num_tc =3D ice_dcb_get_num_tc(dcbx_cfg);

    for (i =3D 0; i < IIDC_MAX_USER_PRIORITY; i++)
        qos_info->up2tc[i] =3D (up2tc >> (i * 3)) & 0x7;

   This populates qos_info->up2tc[] with the un-reset non-contiguous TCs
   (> 0) while vsi->tc_cfg.ena_tc only has BIT(0) set.

4. ice_send_event_to_aux() then sends IIDC_RDMA_EVENT_AFTER_TC_CHANGE. When
   irdma resumes QPs via irdma_sc_suspend_resume_qps(), irdma_ws_add() ->
   ice_add_rdma_qset() -> ice_ena_vsi_rdma_qset() fails with -EINVAL for
   any TC > 0, and irdma_modify_qp_to_err() transitions the QPs to the
   error state.

5. Finally, ice_aux_dev_unlock(pf) drops the locks and
   ice_dcb_ena_dis_vsi(pf, true, true) re-enables the VSIs before
   ice_dcb_noncontig_cfg(pf) resets the configuration, and if the second
   ice_aux_dev_trylock(pf) inside ice_dcb_noncontig_cfg() ->
   ice_dcb_sw_dflt_cfg() -> ice_pf_dcb_cfg() fails with -EBUSY, the fallback
   aborts with local_dcbx_cfg zeroed out.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023070258.7301=
68-1-poros@redhat.com?part=3D3
