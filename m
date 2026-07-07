Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F963D891D
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429184; cv=none; b=RZT8GInjl22YrsQorbWvyz1djx99o7+XV8DhCmiwYLotChx18MXQkwWpEGqecNdnPhtPAZ8BQ+pyG3XUdcAQ6Xp+hwi/WzMV+suBiMmfp0xB2Q5TgAwTG/Im+yEvKRfnzY4Rs9oakT7h0kIaCeLFynLnus5R8xPkrdSBEqd8ZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429184; c=relaxed/simple;
	bh=Byg3OJZRe1xd79dRgn/Udm67f4fCX5ulQy5iFP2kz1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YL8FKUcPU7uTZ2A3ib4846bno4pW91Rx9awJD2GAmEjjx8zI0QL13JwSywFAHLjnXgysLS4ja2qzRkF7TiPsUPJ8jgFmUWjLjHilSjCJ5hssPhf5Akvo3dtchl7Pu/EbPMhhr/eRSR/6+6EkWBojzjmesW4zx23mhjy0D6xWiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1J5eXT1; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1J5eXT1"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca696c4b152so31487a12.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jul 2026 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783429182; x=1784033982; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bqawGs/D2kwMuaBURT3A7nHx9bziQ0g0fHDee9Yijoc=;
        b=h1J5eXT11hisPvvumoCK14lNRPQMOEUcs87i4iK8GHJCRRu8NsbLMNNgo8raOgxRGK
         ZxdcpCDCEes0e76RmneY2xUX9gN3Z2D5J59ZsFRVGLlfZgle0XltMX8x87n53Qbbak87
         lItHyoidXfu2BVwOMdxlYjCs82d2IszbSkXhAFPO/0CJOXwoeaGfPc9K2L5HmnquUEdt
         iuNgzVaUAylS6CJYvhMmoWcWp50gw2FhgTc8Qw4ZQB3hScEY21RYyE2uSGXAbwTSl/Dj
         S98RHZypIz1lSWrykK737GauggSPz7gjhF6D5VGo3yLnQ7fMDxo1Sr2QHcV6gBinEvXq
         8Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429182; x=1784033982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqawGs/D2kwMuaBURT3A7nHx9bziQ0g0fHDee9Yijoc=;
        b=aW7J4/DrE2dJl/J+TYqFPzzP+gubSaL7XZtZAdJMFdcmlwdNaaxzz1AXUxosXgJjYc
         /mr14tWpr2vyuGJFwtElteXwfIIhaYzFX4Jp+8lP/7wN8gfhamW8CjjciFkzL1GkVc08
         gW1VOorxTIMugtoybYCyJH6KvIS9FfI6JkUteWrG+4foKaW+udN5HtND4vjO3rc+hWtq
         Zffl9KCFXTtB49kX8o4rG2Y1VgnMQmDOykdnlkYZMYLCywzfFT2qKL0Jo9F2jrUHdZlT
         dg8Muq2/VeQQW8o3n3TEoDZmt/tbVkSVdy1+zFvLO4hWy321J86XDqDJFPClcyn2Gipg
         oYzw==
X-Forwarded-Encrypted: i=1; AHgh+Ropzrcf+stoIbp3p6GRuqMxtJUgolFh2qEFVrAHHMnD1PAABDWLID47dQ4I5epx/v2Y4fJhIUEg5Cwmo6MZmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzEryIOfgdX6CFSnJyT4iTQAMYlcvIuHrF8cnvomZUrdlOJkoQ
	CSXEJ2weAWJxN/oN7566JhxEHOrtlQ5gEtmc/sVXyUAcJeYUhZQnFiuO
X-Gm-Gg: AfdE7ckvwBlvRjFiATMnKSfItOFSKc9lgiw32fxHRxOYoRHFsVGyrxlnylX9CEuaEfX
	WEFkCvQzZRRVZ1x0/NWcQ1JAbM00w47iNmezDqH4gTEOKNgSv2FMbUjEBgSsbv2f64ZG3MAN4GM
	9Q35r87YI9lbqX/gzlq75JgaW1jynD/nDrtZN9RsX3kMpx4lErsd/CfbUEgPils1+TcVeixccAH
	smG7bpOphyAIKEnF7++X4xltB283zBexSG+5BWMxKZoDln3f38bhS0z/Q32dLuU5xNSGq8C8cI5
	Uc4C4xsz1fqJFfz1NtSvHsGZYx0SLDjaQ3NcnvFwZAnHdAY3xTWPNOIzLzOkJFAZN5sG0IGcVe1
	d5t2hM19UtAbC9X5qN6IjSR3hhDCiXrev1iLeQG83T3fsVu/GTTWkn1Cx+Qx+7x4AMYg4I+8Ons
	ysxzhGvyvBUML+hMYqXQjEAheGfQ==
X-Received: by 2002:a05:6a00:859b:b0:848:32f5:4999 with SMTP id d2e1a72fcca58-84832f56f1dmr1523190b3a.30.1783429181654;
        Tue, 07 Jul 2026 05:59:41 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm5415983b3a.3.2026.07.07.05.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:59:40 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: vbabka@kernel.org,
	david@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	Alexander.Krabler@kuka.com,
	hughd@google.com,
	fvdl@google.com,
	bigeasy@linutronix.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	pfalcato@suse.de
Subject: [PATCH v2 0/4] mm: honour compact_unevictable_allowed in mlock and CMA paths
Date: Tue,  7 Jul 2026 20:59:21 +0800
Message-ID: <20260707125925.3725177-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

vm.compact_unevictable_allowed=0 (the default on RT) is meant to keep
compaction from touching unevictable folios. Several paths still migrate
folios that are about to become unevictable, or in CMA regions,
installing migration entries that a later access must wait on, then
causing latency spikes on RT kernels.

This series fixes those paths and adds a tracepoint for diagnosis. It is
a rework of the RFC [1] per review feedback, mainly from Vlastimil.

RFC --> v2:
1. On top of the isolate-path filtering, also filter by VM_LOCKED
   during the migration unmap step.

2. Make mlock/mlockall wait for in-flight migration entries, ensuring
   the folio is on the unevictable LRU before mlock[all] returns.

3. Dropped letting CMA migration take unevictable folios; instead
   migrate CMA folios out during mlock[all], avoiding migration at
   cma_alloc time.

4. Moved the tracepoint to the migration unmap path.

[1] https://lore.kernel.org/lkml/20260604023812.3700316-1-chenwandun1@gmail.com/

Wandun Chen (4):
  mm/migrate: do not migrate folios mapped into VM_LOCKED VMAs under
    compaction
  mm/mlock: wait for migration to finish when mlocking a folio
  mm/migrate: add tracepoint for folios unmapped during migration
  mm/mlock: migrate folios out of CMA when mlocking a range

 include/linux/compaction.h     |   6 ++
 include/linux/rmap.h           |   3 +
 include/trace/events/migrate.h |  29 +++++++
 mm/compaction.c                |   8 +-
 mm/migrate.c                   |  23 +++++-
 mm/mlock.c                     | 142 ++++++++++++++++++++++++++++++++-
 mm/rmap.c                      |  16 +++-
 7 files changed, 216 insertions(+), 11 deletions(-)

-- 
2.43.0

