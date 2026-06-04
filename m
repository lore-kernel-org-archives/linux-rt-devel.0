Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5697374739
	for <linux-rt-devel@lists.linux.dev>; Thu,  4 Jun 2026 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540711; cv=none; b=QEqu9Y8VYaLyEW9j2vgw9+KAoJ4vnPUx+K9zdmA8RIT4Srigbp1wO+pVDvOmJ01JzZWj+/odwbxPwl6YH5GGL/ohZHk2hotXxUt43ysOEs/g0c00Lx9/gfC+HFBq9DCYP7zFApjzTbTxYKsufyacRiRAMP83HTpz/T5GGZFyrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540711; c=relaxed/simple;
	bh=wwCoW7DmfdTZZnPyFRGmgps6+GicUaepEB+MXmFgDxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aieIFmtp0zqJy09fPLk+2ZMQHSzjukQEFh3unuCAl4KN/1N2YJ0/XSMcvJv+W6NKbRZP5+g7GGxkEiwZs614uTem9GAve/SlygPPudFCEOyEUb0idHBfyKZuKhMT8PwnvfpN87GhfbmjccQOPc0vdvRCmpNHde2Rhk+hXHnVmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwkKKPRR; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwkKKPRR"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso108348a91.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Jun 2026 19:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780540709; x=1781145509; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnVgPGbeod1FIMU1/Hr8h7dHeMhQCz5JwUfAc3OgklU=;
        b=WwkKKPRRBCFPbhvRkfL9ybP1iekNsXgoEq2d+//l06NO0p+LoLlYD4TTs74ORzjg2U
         fKWVS/GnyTj6y9tY1R+JLEQ4NDdATJDBhUXyxyO+IcCRZYaLUR0iltZYVYX2QWTLZ8r0
         YQT/FTZZsertjXfEd3BrDM+BBeAmtozDtBlvCVWdgBCs7GuN9BF+g5xd3kW4szg8ZkWx
         zeGEzovMIz6b27fS4x3mN0GP9bqiaUkZcgnX/Z+AyJST7acgMOZtNdBWNgg3+WWmbpLg
         zypbacP/zAzpPGb8K4Is+NKzmOe+gWJBG5/21qqhfOWCxRUG6hmW3BNLCR5B9q6rlnEO
         rqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780540709; x=1781145509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnVgPGbeod1FIMU1/Hr8h7dHeMhQCz5JwUfAc3OgklU=;
        b=nxn0iM67wIzTX9R6pYUIwQGIENf/LdRDRsDpWHvGTtGNx8jHIdTYRX/I5Js2atbuy3
         SslBubvwXbDIR3OtWc86N2eSYdQJc1c66fVd9sBuCRanQr5jX5kHMm/JvUW55mH+7of7
         Eqc4CXjdqaTcawZOuIIeOVhcJ55V8kWrEGlqOQMj7BXKFaHQS22zElYWRsR7k/IaUt+M
         9WVCk1jaljYYP5jJVXCZSoVvOUA07yO5KOAFtQfXEqE9GA7GvnXa8CCZwrNJa31UQymS
         xavBPf4ZzIyt5ywsyb34vSt6EKmcEfbIEXlbjYrRWBovMWqcx9etll7E5YV3M5B8IEmC
         H0FA==
X-Forwarded-Encrypted: i=1; AFNElJ8oZHf8WEQB7R+bju9+gB3O/INLfkrawyjt0PAxDCEHuNy/3lzakGEnaoTsjVIcInr5mmmLXYphAeQNUYgijw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxrj54ElR210mWAbsQNRyN9lkaIVZDe6I43xIfiamusul10Gu91
	ZT30oo293o3RDRFsd/LWLAgllWqBnxg6ziDK40yfWne9rpJ43od25LBb
X-Gm-Gg: Acq92OEuO49eIQavVfkGkqRW69k7XfDA7K2ILnaO3omsDVDoPhnDE+Wd9I2D6l4dpo3
	/FHetLGGplpKOeqW4mQzcEQ+9AiJO5Mzf/ras5VaTXETqviDrWhJYuLK2jj1yVsWcM3emd2Knqm
	od3gqhLzagXtHQmvq/jbMgRfyL78+qYFEIZkoRmhUvhkbPZa9m54TtgcMeHNYLii6iZL9kWC7Uy
	cKB7Cjq0DFGWiubvrMbOE8yQ2dr+RaAda7U2aWVTbpEjePfPYMES+qJCHVHl1JE1uJryVnc/a2G
	hhrOVzEbbtAovLEOd37vXogrROFeiewtH5YSZiynr1fsm0uLe/2KTssNe1IYnnf+xHgIw1SoxR8
	m44LA1zzO+eD8/uJdlkL0hQ1S/TMvUJ5e/7U5hkA6w0qo7HNjdJC/0nO+vQ4YDze237idc5cQJC
	+bySGgAmCFZ1BrfscEw1MgV5bslxXADuxXBfbAQ99SCg7vgC8=
X-Received: by 2002:a17:90b:5610:b0:369:7421:b376 with SMTP id 98e67ed59e1d1-36e32949e58mr5612929a91.19.1780540708922;
        Wed, 03 Jun 2026 19:38:28 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6dba8573sm1253072a91.14.2026.06.03.19.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 19:38:28 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	Alexander.Krabler@kuka.com
Subject: [RFC PATCH 0/3] mm/compaction: honour compact_unevictable_allowed in mlock race and alloc_contig path
Date: Thu,  4 Jun 2026 10:38:09 +0800
Message-ID: <20260604023812.3700316-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

vm.compact_unevictable_allowed=0 is meant to keep compaction from
touching unevictable folios. In practice there are still two paths
where it does not take effect. This series fixes them and adds a
tracepoint to make such issues easier to diagnose in the future.

Wandun Chen (3):
  mm/compaction: skip isolate mlocked folios when
    compact_unevictable_allowed=0
  mm/compaction: add per-folio isolation tracepoint
  mm/compaction: respect compact_unevictable_allowed in alloc_contig
    path

 include/linux/compaction.h        |  6 ++++++
 include/trace/events/compaction.h | 26 ++++++++++++++++++++++++++
 mm/compaction.c                   | 14 +++++++++++---
 mm/internal.h                     |  1 +
 mm/page_alloc.c                   |  2 ++
 5 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.43.0

