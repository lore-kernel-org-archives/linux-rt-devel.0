Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F235204685
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Dec 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349813; cv=none; b=T3emuoAW4m9Dyu05RCMV9iDm8Dh0QBERX1/R5LflaF9Grq5myhAJihiRMe4FwjzDIEUpRz2NLlsExdwz1fPSpLs7gzzKqZliwV1aHtDmunIywHckxP7Umm54wt5QzlwRpcX6M3C3RVAvRCbx7txMlh4SvkU1tYwJaIvoLahxZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349813; c=relaxed/simple;
	bh=RyiC6CTxjFlvt11l6QOa8TlUBlD7SWpUaXebEuiEjU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FFz085nOO2ntpispFNfdzzzAJmG4d9e2CoUXz1o8FvykkD+ocx8XJV2D2P3DwHz9Ovy0dNUdCJaaJ8D8DfP+dbIKzme46YalktAiDMvwLISj8q7yWOd3wOhclHCuCsBSEq04UQZLmOzgxQ9w2CJnUCHmVhxIslLNBVXwGLkjRKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67FF113E;
	Mon, 16 Dec 2024 03:50:38 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AAC2B3F58B;
	Mon, 16 Dec 2024 03:50:08 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3 0/9] coresight: change some driver' spinlock type to raw_spinlock_t
Date: Mon, 16 Dec 2024 11:49:57 +0000
Message-Id: <20241216115006.415861-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some coresight drivers, drvdata->spinlock can be held during __schedule()
by perf_event_task_sched_out()/in().

Since drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this,change type drvdata->spinlock in some coresight drivers,
which can be called by perf_event_task_sched_out()/in(),
from spinlock_t to raw_spinlock_t.

Reviewed-by: James Clark <james.clark@linaro.org>

v2 to v3:
    - Fix build error

v1 to v2:
    - seperate patchsets to change locktype and apply gurad API.

Yeoreum Yun (9):
  coresight: change coresight_device lock type to  raw_spinlock_t
  coresight-etm4x: change etmv4_drvdata spinlock type to  raw_spinlock_t
  coresight: change coresight_trace_id_map's lock type to
    raw_spinlock_t
  coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
  coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
  coresight-funnel: change funnel_drvdata spinlock's type to
    raw_spinlock_t
  coresight-replicator: change replicator_drvdata spinlock's type to
    raw_spinlock_t
  coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
  coresight/ultrasoc: change cti_drvdata spinlock's type to
    raw_spinlock_t

 .../hwtracing/coresight/coresight-config.c    |   8 +-
 .../hwtracing/coresight/coresight-config.h    |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |   2 +-
 .../hwtracing/coresight/coresight-cti-core.c  |  44 +--
 .../hwtracing/coresight/coresight-cti-sysfs.c |  76 +++---
 drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  26 +-
 .../coresight/coresight-etm4x-core.c          |  18 +-
 .../coresight/coresight-etm4x-sysfs.c         | 250 +++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
 .../hwtracing/coresight/coresight-funnel.c    |  12 +-
 .../coresight/coresight-replicator.c          |  12 +-
 .../hwtracing/coresight/coresight-syscfg.c    |  26 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |   6 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  48 ++--
 .../hwtracing/coresight/coresight-tmc-etr.c   |  40 +--
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
 .../hwtracing/coresight/coresight-trace-id.c  |  22 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
 include/linux/coresight.h                     |   4 +-
 21 files changed, 308 insertions(+), 308 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

