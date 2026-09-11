Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BB91B3925
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124177; cv=none; b=Zw2XydErtnI/xwcAFc5skK8/hKyu7M8Y4T6hs3Z8+phFu4tS20+mEJ/HnR/1/1nd95spF6Dyk+YJKwMMrs74JmP8iXcKgNnmnFq5NyFLlbrThaKLMqoGICLSqFOSxnQhYIvuYp4emK7aOZ40KcTN0S4AnMUSaDS1NB0ImXG4Cgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124177; c=relaxed/simple;
	bh=L8EzfeK5GHg9ts95UQZjIMXReLQVDSdUBWYGEouRTwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WNMtZznZfx9KHACygni6fRqsqlbIowW0ngJEjWQfUMgAxZ2bF4iRxEIyOrMvkibz4Ufky1XBZQj+jHd/u+Lp4lxmxMTR9Ohb3cgIiGYZcvBP9QZzgtCGnP/i3xKcoGw7VN92Xe66ssdnIdzt6odnWZn4oOrQuCjBBkTyP9L5EG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FoWNhRN2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FoWNhRN2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07CA61570;
	Fri, 11 Sep 2026 03:56:11 -0700 (PDT)
Received: from e129823.arm.com (unknown [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5973F7B4;
	Fri, 11 Sep 2026 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789124174; bh=L8EzfeK5GHg9ts95UQZjIMXReLQVDSdUBWYGEouRTwo=;
	h=From:Subject:Date:To:Cc:From;
	b=FoWNhRN2PkKrNDMCkWpEKANSSmhj8pUl2ugXvG+rLVOagMPoUyWEONQZq1R2ehQKD
	 FLtFtTPyY0xeIdyhGMS9SadjMeKuVFUGxFAIpSEKYo3EAAm+KKoaqO2iS6Wtpk3P3N
	 bOtLmU5MFLTQIl/VtYxyrrjOJ5RwwtHRu/rCTdFE=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v10 0/8] fix several inconsistencies with sysfs
 configuration in etmX
Date: Fri, 11 Sep 2026 11:55:59 +0100
Message-Id: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/eo2oC/x2MWwqAIBAArxL7neAaSXWVCDFbbT96oBJBdPekz
 xmYeSBRZEowVA9EujjxsRdAWVfgVrsHErwUAUoqLXtEkei00WYylDfjfDCXEk2LnUXdudl7KOU
 ZyfP9b8fpfT9Urkq8ZgAAAA==
To: Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4371; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=L8EzfeK5GHg9ts95UQZjIMXReLQVDSdUBWYGEouRTwo=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqo95HtZ4cpF4zqoXqt5mEqsg7wKxqYq7f+aYuk
 2jGxbUKS6+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqPeRwAKCRBt1cPRWsUx
 M0XlC/9g+sHLYYPrYo3Ooh00EvSPsOSpRlswqk9J+F1lhK218YZPlskc2uLITKHOsEJ3pot966r
 Eldo4+4z7he90kmj6kd5CRmynThXHjf61AZ/wJTM0d93L7XtQf9oFC22NiSQmD+41JuRJu4rgbf
 9CFTcviIUEZ8j4GkPl6017E38c10kSqB51SEWuK5Gm3Th0Bkv0zqIQEIHkYbE/OEql0Uaw+ueNF
 UiIe2mbeAej3EmI0PPjfkvYInkN9fvKF4lBm/xipHVSUqO2p67QJUpcgvVCjtytJ/BbeVx+RgSI
 014Z9gEOTadTXxEJD0pbHJvgHd7upC7vWoSJBH40Ktsc30JuslyaF50WSw8nwkwjDUE3/IRcobB
 vXG/ZY/u4AoRYIUTSyumdDewRpD2Ndk4zJL4IGRSYaKH8a85oAHUohvPF5yvV2sYVqnbmy7NlJb
 74pTZD1w6SYc91IOv/0KYNI85YpE4kJKDYv13MuiyoNLbMbFNCWzQg+xOS0MPM5LZIuTk=
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
Yeoreum Yun (8):
      coresight: etm4x: fix inconsistencies with sysfs configuration
      coresight: etm3x: fix inconsistencies with sysfs configuration
      coresight: etm3x: change drvdata->spinlock type to raw_spin_lock_t
      coresight: etm3x: remove redundant cpu online check on etm_enable_sysfs()
      coresight: etm4x: introduce struct etm4_caps
      coresight: etm4x: exclude ss_status from drvdata->config
      coresight: etm4x: remove s_ex_level from config
      coresight: etm3x: introduce struct etm_caps

 drivers/hwtracing/coresight/coresight-config.c     |  18 +-
 drivers/hwtracing/coresight/coresight-config.h     |  22 ++
 drivers/hwtracing/coresight/coresight-etm.h        |  48 ++-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |  96 ++---
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 155 ++++----
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |  14 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 413 +++++++++++----------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 204 +++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h      | 196 +++++-----
 9 files changed, 645 insertions(+), 521 deletions(-)
---
base-commit: 9e3604d7369cfc0110100eb1a0acab1865ee2d18
change-id: 20260911-separate_etm_cfg_v2-3518a168cbff

Best regards,
-- 
Sincerely,
Yeoreum Yun

