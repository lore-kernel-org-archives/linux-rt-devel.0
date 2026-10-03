Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4128635D
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995760; cv=none; b=VWv5fUoBzrWLegwLEHww9Kh4O1W/NX5V6XNlgdm2EppWeFIxVEItBoNCMww45MMsdu5Pyhpb1kkVlcIE/UfCvE8dDcbqma1WLjPqYB47XKfbL/442P3TLWJ+uxIRs956cY4672bTTP1zJlccghU+yhLurAiGEZB5c1+X0e9LtDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995760; c=relaxed/simple;
	bh=I3vdyRRDlefC1oAiQIJXDmUOiroJlVmudGdEn1cielc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXJMVvYV2pBcOscEQhwyTZDCwD8KxpGfbqDztZE8LC96n+sbp3HO6z8z+Q5SmitLlcXzFkqtlBrlSi4AFJbULWHnYfGsTD66u+UcMoIBnbwQpuUXbADnFx1wOSUAuOi+WwmR6zSsz9Ehyhq9+8LAGQUoMgKqo+DUFml9/O4up6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M+hp/Kog; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M+hp/Kog"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9488C2F;
	Fri,  2 Oct 2026 19:49:13 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72063F763;
	Fri,  2 Oct 2026 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995756; bh=I3vdyRRDlefC1oAiQIJXDmUOiroJlVmudGdEn1cielc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+hp/Kogl4r89iuULgtbNgsxVSeyZgDt8goPgeVRNoE3dRaV5kKbE7YpeGVfF1OoR
	 xEKWuBh+ijfzy4XjDZZ/uDO+N6QnL+M+UxOAim6NpRsZQixCcovlDmX6EYGwv5s8q1
	 NV/9ak4la0JMisfPT06nH78LX2/XEZTgDo7n0Evk=
Date: Sat, 3 Oct 2026 03:49:12 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH v13 00/14] fix several inconsistencies with sysfs
 configuration in etmX
Message-ID: <asBtKMMdd38ZpSlI@e129823.arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>

Sashiko's review found one typo but others are not valid and
I've commented for them.

Therefore, I'll resend again with typo fix only keeping the version.

Thanks!
> The current ETMx configuration via sysfs can lead to the following
> inconsistencies:
> 
>   - If a configuration is modified via sysfs while a perf session is
>     active, the running configuration may differ between before
>     a sched-out and after a subsequent sched-in.
> 
>   - If a perf session and sysfs session tries to enable concurrently,
>     configuration from configfs could be corrupted (etm4).
> 
>   - There is chance to corrupt drvdata->config if perf session tries
>     to enabled among handling cscfg_csdev_disable_active_config()
>     in etm4_disable_sysfs() (etm4).
> 
> To resolve these inconsistencies, the configuration should be separated into:
> 
>   - curr_config, which is applied configuration for the current session
>   - config, which stores the settings configured via sysfs.
> 
> and apply configuration from configfs after taking a mode.
> 
> Patch History
> =============
> from v12 to v13:
>   - add r-b tags
>   - Link to v12: https://lore.kernel.org/r/20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com
> 
> from v11 to v12:
>   - rename active_config to curr_config.
>   - rename config to sysfs_config.
>   - remove redundant config argument in etmX_args.
>   - add read-back and copy from curr_config to sysfs_config TRCSEQSTR
>     (seq_state).
>   - add r-b and t-b tags.
>   - Link to v11: https://lore.kernel.org/r/20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com
> 
> from v10 to v11:
>   - replace direct register read from etm3 sysfs with IPI.
>   - fix issue cntr_val and others field which required to be shown after
>     sysfs session disable.
>   - prohibit the write for some etm3 sysfs while sysfs session is
>     enabled.
>   - drop locktype change in etm3
>   - Link to v10: https://lore.kernel.org/r/20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com
> 
> from v9 to v10:
>   - rebase to coresight/next
>   - https://lore.kernel.org/all/20260725113645.57519-1-yeoreum.yun@arm.com/
> 
> from v8 to v9:
>   - add feat_csdev_lock guard interface.
>   - set feat_csdev->drv_spinlock as NULL for etmv4_drvdata.
>   - https://lore.kernel.org/all/20260629090007.1718746-1-yeoreum.yun@arm.com/
> 
> from v7 to v8:
>   - accept @Leo Yan' suggestion to handle error.
>   - small minor fixes following @Suzuki' suggestion.
>   - https://lore.kernel.org/all/20260519154812.254884-1-yeoreum.yun@arm.com/
> 
> from v6 to v7:
>   - rebase on coresight/next
>   - add ETM_MAX_SEQ_TRANSITIONS define
>   - remove redundant patch relavent cpu-hotplug as coresight-pm patch
>     merged.
>   - https://lore.kernel.org/all/20260422132203.977549-1-yeoreum.yun@arm.com/
> 
> from v5 to v6:
>   - fix missing of calling cscfg_csdev_disable_active_config()
>   - add rb & fixes tags.
>   - add ss_status field in etm4x_drvdata to expose STATUS and PENDING bits.
>   - https://lore.kernel.org/all/20260415165528.3369607-1-yeoreum.yun@arm.com/
> 
> from v4 to v5:
>   - add rb-tag.
>   - fix underflow issue for nrseqstate.
>   - fix wrong check in etm4_sspcicrn_present().
>   - remove redundant fields on etmv4_save_state.
>   - rename caps->ss_status to ss_cmp.
>   - fix wrong location of etm4_release_trace_id.
>   - https://lore.kernel.org/all/20260413142003.3549310-1-yeoreum.yun@arm.com/
> 
> from v3 to v4:
>   - change etm_drvdata->spinlock type to raw_spin_lock_t
>   - remove redundant call etmX_enable_hw() with starting_cpu() callsback.
>   - fix missing trace id release.
>   - add missing docs.
>   - https://lore.kernel.org/all/20260412175506.412301-1-yeoreum.yun@arm.com/
> 
> from v2 to v3:
>   - fix build error for etm3x.
>   - fix checkpatch warning.
>   - https://lore.kernel.org/all/20260410074310.2693385-1-yeoreum.yun@arm.com/
> 
> from v1 to v2
>   - rebased to v7.0-rc7.
>   - introduce etmX_caps structure to save etmX's capabilities.
>   - remove ss_status from etmv4_config.
>   - modify active_config after taking a mode (perf/sysfs).
>   - https://lore.kernel.org/all/20260317181705.2456271-1-yeoreum.yun@arm.com/
> 
> ---
> Yeoreum Yun (14):
>       coresight: etm4x: read-back TRCSEQSTR at disabling and prohibit modifying seq_state while enabling.
>       coresight: etm4x: prohibit modifying cntr_val while session is enabled
>       coresight: etm3x: prohibit modifying cntr_val and reset while session is enabled
>       coresight: etm4x: fix inconsistencies with sysfs configuration
>       coresight: etm3x: fix inconsistencies with sysfs configuration
>       coresight: etm3x: remove redundant cpu online check on etm_enable_sysfs()
>       coresight: etm4x: introduce struct etm4_caps
>       coresight: etm4x: exclude ss_status from drvdata->config
>       coresight: etm4x: remove s_ex_level from config
>       coresight: etm4x: rename local config as curr_config referring drvdata->curr_config
>       coresight: etm4x: rename drvdata->config to sysfs_config
>       coresight: etm3x: introduce struct etm_caps
>       coresight: etm3x: rename local config as curr_config referring drvdata->curr_config
>       coresight: etm3x: rename drvdata->config to sysfs_config
> 
>  drivers/hwtracing/coresight/coresight-config.c     |  18 +-
>  drivers/hwtracing/coresight/coresight-config.h     |  22 +
>  drivers/hwtracing/coresight/coresight-etm.h        |  48 +-
>  drivers/hwtracing/coresight/coresight-etm3x-core.c | 196 +++--
>  .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 461 +++++-----
>  drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |  14 +-
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 567 ++++++------
>  .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 961 +++++++++++----------
>  drivers/hwtracing/coresight/coresight-etm4x.h      | 199 +++--
>  9 files changed, 1340 insertions(+), 1146 deletions(-)
> ---
> base-commit: a3281934612608db9e1d24aaf913c846e913de89
> change-id: 20260911-separate_etm_cfg_v2-3518a168cbff
> 
> Best regards,
> -- 
> Sincerely,
> Yeoreum Yun
> 

-- 
Sincerely,
Yeoreum Yun
