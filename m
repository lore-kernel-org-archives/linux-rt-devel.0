Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677424BA9E1
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271256; cv=none; b=RQ1/jm1VzVxa/ThKjj8bno6BdRT6wxol+pCJa8JigOYaUkBg4eOTAA5Sr+1/df+N9Fn4PISzjNi8YUhkYcPRvLhroDfKlOsZ4Wz1fC5btTr7UKwF8ZrPvEjeD+ZUoujszVAI27eIRQzD3nEODNlDkg8gJzYGtigujTCQZ01XPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271256; c=relaxed/simple;
	bh=QdGBmO5V0iQIW02FrfgvhrRx27to9UxuZH1EW+m6zG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ee+/qVn4RLOflb8lG2J4tq5hrpIywc/WFZPLDXH1QO3lmCc546R3x355U/BW0im+PKQ8fRhaMr4qcvQygJngM2yUQa6jNpaIRbr3lNUKprH9rptwv4bU73adZLB5l0wSTgyVMwMyXAPbAaBZtxhqmMOnO91RVcFNuRSjF1hV30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=imnQLMT8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="imnQLMT8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 387471E4D;
	Thu, 24 Sep 2026 10:34:10 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A6A3F86F;
	Thu, 24 Sep 2026 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790271253; bh=QdGBmO5V0iQIW02FrfgvhrRx27to9UxuZH1EW+m6zG0=;
	h=From:Subject:Date:To:Cc:From;
	b=imnQLMT8axqY8MaQE9nuSLfvCEFRogkiODOjHkxYcq/BmYAwsn7cjqp3tCpgra20n
	 S+jb0YTxqK4DCYgv71tbSwgMZw9CHpeJvwnu9FIAZYPRSxN+iMUvxeI8C9S5Hn4NT8
	 +Gxjb1rCQY4TS40sEQrlRWNtmHMIt97bOswwwCPI=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v12 00/14] fix several inconsistencies with sysfs
 configuration in etmX
Date: Thu, 24 Sep 2026 18:33:38 +0100
Message-Id: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPNetWoC/33NQQ6CMBAF0KuQrq3pjJaCK+9hDCntFLpASEsaD
 eHuFja60eX/mf9mYZGCp8guxcICJR/9+MgB8FAw0+tHR9zbXDAUWIoagEeadNAzNTQPjXFdk5C
 fJFQaysq0zrG8nAI5/9zZ2z3n3sd5DK/9SwKx1f/BfMQFh1aBtLWsUemrDsPRjAPbvATwbcgfB
 mTDYouyshLUWX2MdV3fuhhT8fsAAAA=
To: Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5641; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=QdGBmO5V0iQIW02FrfgvhrRx27to9UxuZH1EW+m6zG0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqtV8L0XTVwGE93MoHZp9g+aF5HqImnglOzDEyv
 xfFaAKDtjuJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarVfCwAKCRBt1cPRWsUx
 M+75C/9pZInzTi1gUtVRTAsaf1UmnFVjIWxX8WJ/VhjoyspfGHH8REdzBdL/Ysik32ry10T3r2f
 nj9iZuKlmbd9+ZkfuUxdll35XW+j3ZCZ4/HnQZtq1u7RMZgs+RwU6Ae+PW+A5eYbYqYUTR3tKiV
 eJnGfqpr7GkueCA/kZk8bEv9bHvSzB5LAJ2p0fHWBMyIQbP087Xx5KyowY90N9pDylG7gtblavg
 jf4VsB85ObVtCrJmrNnEDxnRPItQlWCrHgSAiHo2jvusE0cQOFrE8oeqcljnEr/Xjf9NNZenblT
 5A6G9aDwtcAIH66RFe+cuhwUQjYhO4tQiUbokKcJueq55/hd3vX+PV7FIewuQMfAFu7ZsyEc9Xu
 UMm4EGDN7Iap3GsYDVs283sdq4zj+o5FA59z7oU+s5T/7z5zAOugh/GHIW0JewjuNl2ad+nKTae
 vSm/Xk/BVk1V+NCv07xallonqzB6jjgJbNXfFSZgLTifDKRrA0+5+3eo2fpQs5MXr+iHQ=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The current ETMx configuration via sysfs can lead to the following
inconsistencies:

  - If a configuration is modified via sysfs while a perf session is
    active, the running configuration may differ between before
    a sched-out and after a subsequent sched-in.

  - If a perf session and sysfs session tries to enable concurrently,
    configuration from configfs could be corrupted (etm4).

  - There is chance to corrupt drvdata->config if perf session tries
    to enabled among handling cscfg_csdev_disable_active_config()
    in etm4_disable_sysfs() (etm4).

To resolve these inconsistencies, the configuration should be separated into:

  - curr_config, which is applied configuration for the current session
  - config, which stores the settings configured via sysfs.

and apply configuration from configfs after taking a mode.

Patch History
=============
from v11 to v12:
  - rename active_config to curr_config.
  - rename config to sysfs_config.
  - remove redundant config argument in etmX_args.
  - add read-back and copy from curr_config to sysfs_config TRCSEQSTR
    (seq_state).
  - add r-b and t-b tags.
  - Link to v11: https://lore.kernel.org/r/20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com

from v10 to v11:
  - replace direct register read from etm3 sysfs with IPI.
  - fix issue cntr_val and others field which required to be shown after
    sysfs session disable.
  - prohibit the write for some etm3 sysfs while sysfs session is
    enabled.
  - drop locktype change in etm3
  - Link to v10: https://lore.kernel.org/r/20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com

from v9 to v10:
  - rebase to coresight/next
  - https://lore.kernel.org/all/20260725113645.57519-1-yeoreum.yun@arm.com/

from v8 to v9:
  - add feat_csdev_lock guard interface.
  - set feat_csdev->drv_spinlock as NULL for etmv4_drvdata.
  - https://lore.kernel.org/all/20260629090007.1718746-1-yeoreum.yun@arm.com/

from v7 to v8:
  - accept @Leo Yan' suggestion to handle error.
  - small minor fixes following @Suzuki' suggestion.
  - https://lore.kernel.org/all/20260519154812.254884-1-yeoreum.yun@arm.com/

from v6 to v7:
  - rebase on coresight/next
  - add ETM_MAX_SEQ_TRANSITIONS define
  - remove redundant patch relavent cpu-hotplug as coresight-pm patch
    merged.
  - https://lore.kernel.org/all/20260422132203.977549-1-yeoreum.yun@arm.com/

from v5 to v6:
  - fix missing of calling cscfg_csdev_disable_active_config()
  - add rb & fixes tags.
  - add ss_status field in etm4x_drvdata to expose STATUS and PENDING bits.
  - https://lore.kernel.org/all/20260415165528.3369607-1-yeoreum.yun@arm.com/

from v4 to v5:
  - add rb-tag.
  - fix underflow issue for nrseqstate.
  - fix wrong check in etm4_sspcicrn_present().
  - remove redundant fields on etmv4_save_state.
  - rename caps->ss_status to ss_cmp.
  - fix wrong location of etm4_release_trace_id.
  - https://lore.kernel.org/all/20260413142003.3549310-1-yeoreum.yun@arm.com/

from v3 to v4:
  - change etm_drvdata->spinlock type to raw_spin_lock_t
  - remove redundant call etmX_enable_hw() with starting_cpu() callsback.
  - fix missing trace id release.
  - add missing docs.
  - https://lore.kernel.org/all/20260412175506.412301-1-yeoreum.yun@arm.com/

from v2 to v3:
  - fix build error for etm3x.
  - fix checkpatch warning.
  - https://lore.kernel.org/all/20260410074310.2693385-1-yeoreum.yun@arm.com/

from v1 to v2
  - rebased to v7.0-rc7.
  - introduce etmX_caps structure to save etmX's capabilities.
  - remove ss_status from etmv4_config.
  - modify active_config after taking a mode (perf/sysfs).
  - https://lore.kernel.org/all/20260317181705.2456271-1-yeoreum.yun@arm.com/

---
Yeoreum Yun (14):
      coresight: etm4x: read-back TRCSEQSTR at disabling and prohibit modifying seq_state while enabling.
      coresight: etm4x: prohibit modifying cntr_val while session is enabled
      coresight: etm3x: prohibit modifying cntr_val and reset while session is enabled
      coresight: etm4x: fix inconsistencies with sysfs configuration
      coresight: etm3x: fix inconsistencies with sysfs configuration
      coresight: etm3x: remove redundant cpu online check on etm_enable_sysfs()
      coresight: etm4x: introduce struct etm4_caps
      coresight: etm4x: exclude ss_status from drvdata->config
      coresight: etm4x: remove s_ex_level from config
      coresight: etm4x: rename local config as curr_config referring drvdata->curr_config
      coresight: etm4x: rename drvdata->config to sysfs_config
      coresight: etm3x: introduce struct etm_caps
      coresight: etm3x: rename local config as curr_config referring drvdata->curr_config
      coresight: etm3x: rename drvdata->config to sysfs_config

 drivers/hwtracing/coresight/coresight-config.c     |  18 +-
 drivers/hwtracing/coresight/coresight-config.h     |  22 +
 drivers/hwtracing/coresight/coresight-etm.h        |  48 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 196 +++--
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 461 +++++-----
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |  14 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 567 ++++++------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 961 +++++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h      | 199 +++--
 9 files changed, 1340 insertions(+), 1146 deletions(-)
---
base-commit: 9e3604d7369cfc0110100eb1a0acab1865ee2d18
change-id: 20260911-separate_etm_cfg_v2-3518a168cbff

Best regards,
-- 
Sincerely,
Yeoreum Yun

