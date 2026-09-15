Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2EF4C4F7E
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472094; cv=none; b=uFWHnsHRr/KaRAqVkidSMxeprOptUXsqxV94roOK1x9rcMMrvyTkX36/r17AX/4eKw2Vh0/cbBIJmoas5j8mGieUFiJCCS45n/4sgjfigWBVqLYd7v9jJtFj9h2p6sWsQfuoihtS5md15BS7AsNzSPBaD5rp87M+QMooj0gy8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472094; c=relaxed/simple;
	bh=ASSjsXnuAzfqz0oWZqhM1o3UsUzefrnFTTMP5w2pCFk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HlQ3FEM6EDftFtG//lzJn8oBpbpKZnhI+vZ/zqDp7uMh/wD7mOz0S1TUxZipiJyBxtZUdWRDd8tk0VrisJpqazvOcUuOTC71+aXYDpYJvWaw3UntJ3CAUhvMnzHa//Hkspgald2zp1zJ2gdmAgpsRQXg1bAlQINzAPm8qHD9/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NQKTWTzc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NQKTWTzc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5958D153B;
	Tue, 15 Sep 2026 04:34:46 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34FEF3F86F;
	Tue, 15 Sep 2026 04:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789472089; bh=ASSjsXnuAzfqz0oWZqhM1o3UsUzefrnFTTMP5w2pCFk=;
	h=From:Subject:Date:To:Cc:From;
	b=NQKTWTzczili1mqN98mR45xKrLn/c4BJ83oQqCk1DUuAoWu1qWdkuobV3gO6r8RXN
	 3hqhSh/IOIdsShyaRJhVE9bqDkYdJR/V4Fy4tl2mKrxnuFf96+M3ke1w41EjOnh5eS
	 4Zg0WDpLPwQZf+x+9h1p3z1lx8ScVTKuyF8gCa+Q=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v11 0/9] fix several inconsistencies with sysfs
 configuration in etmX
Date: Tue, 15 Sep 2026 12:34:35 +0100
Message-Id: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwtqWoC/32NTQqDMBCFryKzbkomxZ905T2KSIwTnYVGkiAt4
 t2beoAu38d73zsgUmCK8CwOCLRzZL/mgHgrwM5mnUjwmAEoqSqpEUWkzQSTqKe09NZN/a7Eo8T
 GYNXYwTnIyy2Q4/elfXU5zxyTD5/rZUf5w/+FuSSkwKHGctSlVrVpTVju1i/Qnef5BTAch1a3A
 AAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4871; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=ASSjsXnuAzfqz0oWZqhM1o3UsUzefrnFTTMP5w2pCFk=;
 b=kA0DAAoBbdXD0VrFMTMByyZiAGqpLVGij0h5BDqLSBuiBFYD4Nv4RnptiWxeS4smV8yGblVep
 okBswQAAQoAHRYhBC2D4JLdBTO4WHWknW3Vw9FaxTEzBQJqqS1RAAoJEG3Vw9FaxTEzTZYMAMlA
 7SScm6mCVsze05suXyXFxjPgk29htCaMe3/+PalNPJj4TzuTDB1TYITaGpquyXHqZh+P4zBPo8u
 8aANH1W8myAF9gCPP9lLhmzMH6FxWdvLY5v08eWF5yw2CAYcRpKUo+M0JRP2JOGncgnRM6G75w9
 da8E/nssLH9WDPl7VS8/AxHiM7QiBwyg8Zsuro0h/SpuRXc91HpMecwtepjcjrqLmKmcT+Wnho2
 4WPjUP1pDHQ/XUtlrz10vVTcg14E9CjgTNcH5NWsbw/LPueoYUuZ+T+StijRWcU9QJMoMmuPr2Z
 NLgufhL1inGouZ29e6hDJAztc2ZX1uYMEMsZm3PwqBJbtbLK7oHN+QbfuE93kjnFpv/1DgukgfX
 eOsQwy2KPX47NgUVfjIimcJjnLQCxrkbNnVBcUHoeknGfAFlYMx6mWSJNndM5hSM5IPHb3IJX+G
 g+TZKjcO3UyUuk0Qx1Gb/WtHCLgphoQZH+drW1BlM0CxXKjAuOTaYX5k2BJw==
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

  - active_config, which is applied configuration for the current session
  - config, which stores the settings configured via sysfs.

and apply configuration from configfs after taking a mode.

Patch History
=============
from v10 to 11:
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
Yeoreum Yun (9):
      coresight: etm4x: prohibit modifying ss_status and cntr_val while session is enabled
      coresight: etm3x: prohibit modifying cntr_val and reset while session is enabled
      coresight: etm4x: fix inconsistencies with sysfs configuration
      coresight: etm3x: fix inconsistencies with sysfs configuration
      coresight: etm3x: remove redundant cpu online check on etm_enable_sysfs()
      coresight: etm4x: introduce struct etm4_caps
      coresight: etm4x: exclude ss_status from drvdata->config
      coresight: etm4x: remove s_ex_level from config
      coresight: etm3x: introduce struct etm_caps

 drivers/hwtracing/coresight/coresight-config.c     |  18 +-
 drivers/hwtracing/coresight/coresight-config.h     |  22 ++
 drivers/hwtracing/coresight/coresight-etm.h        |  46 ++-
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 126 +++---
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 104 +++--
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |  14 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 426 +++++++++++----------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 210 ++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h      | 196 +++++-----
 9 files changed, 676 insertions(+), 486 deletions(-)
---
base-commit: 9e3604d7369cfc0110100eb1a0acab1865ee2d18
change-id: 20260911-separate_etm_cfg_v2-3518a168cbff

Best regards,
-- 
Sincerely,
Yeoreum Yun

