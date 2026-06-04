Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF92FF164
	for <linux-rt-devel@lists.linux.dev>; Thu,  4 Jun 2026 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540730; cv=none; b=GfkOYbf+TPWrFInII1OvHexCrGgqPOrbd3wUuek1FqKqo1wdrUG1gkq7vvlP18MVWrdiyJoxeSL9CR6uN1uCd3Y/SfywELALHGLzqfDthykWRhXr2BEbl2tbr5bdy6hc6viR57GRw95Ge1SqzGRRFf8QK1cDa2/d9eTK7f+qz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540730; c=relaxed/simple;
	bh=IYmoyLg/EeJdFRiogqb1Pp9mqFRQfPgEPlVgRs+mRvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obrGdGzLKuguBMpyeKvhDr21CeQ2EQuwlNqWfQbl+MWWxklNn/1jTATp4rK9rdg0srEfa09rwMzH1it0+Km/ZjtJ4XRSjBUePfoch3tkHPUIPHLW+pDJcrr3JKcvZ6gcyitOYZYZVDsruzl1mzEm5s0nGLFZzBGTnSd0UnI8KpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+h7WO35; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+h7WO35"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36da151a152so116246a91.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Jun 2026 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780540728; x=1781145528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=903p+XYNW6RRuBbLdT64GGYbi0Y3SIaWw22qBNVgp0Y=;
        b=T+h7WO35N50F7Y091kiQURvmzPef0NMIN3jfrvSl8u8bWhxDsOu08+8gJAgjNo6ULx
         XJ1pO+0s1cVKEtwfLcry3d/Yj5e0OVwxhfVT+6hlITCaBFVakq1a7DPnjvpER3yToYvL
         WMQr8v9BcVOv4uRXtdI78/jljuVwNo1c8kC9f4ZrSOMEXs46Tx+DVMq3DH9nPkK7yaii
         rLFHbk9Af/4JxUZcAyNGJoz8ZBGTw4e8jg+EryTud7YkfVwdakCcxuaq3aOQN3zogR/u
         IttJiMje5gU/ulI41PpV/HFFoR85kODTQ6LzKneV0hItigjV/hgibXvivNqm9CKAFOwl
         kqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780540728; x=1781145528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=903p+XYNW6RRuBbLdT64GGYbi0Y3SIaWw22qBNVgp0Y=;
        b=WqRfcIqz4jiSw1Lo6A9gYHVU1ezVP0iSxhFXz/e5DmQIXSw6bXEs6esok8dQERIj2d
         9Ru5XyuKX3YcRDYpUgvMPW4Shsuz29yKu4OUpgYnytrjprJNoWHzmCbMVP9aApzRmX9I
         T82hqVxI8B3rnUVoVS+3BvQH8uwFnWPcATST85uv3G7eBRLxt8JWd+wz74bYgdBpN5GC
         ghxfl6OdUrJ/gmu4YSFJsiYsiuAxJH5IhUtv1n1o8snscxWQ0Xtskbx6EBaexfV3e8dM
         +9zf52uLPRU56o4HxoSbHSibKDbLIAr6bJsCARQz6vxsOjTwT2FF43WmFR/oEnN6QApe
         fjCA==
X-Forwarded-Encrypted: i=1; AFNElJ+o3Sxyf0tVph3e/m8+suGcZsCfGA1NFCsujJith9bxkcuZHjM7nufe++TZdVL9nbUdMhOP7ocSEEQD0irevw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzewJDtFQjGVQXA4BvNaBYpCepx/LDjXcELYzK+goIjo7sLMDjc
	ROLeY5JEN3oBH/SnDAQS9KL4JkcRMjGPnZ3EMbla15WnU8ycVGUwL7cN
X-Gm-Gg: Acq92OESssMkMxyYFLYT+IOpnHPGdCSOuSnmEHtCkcGUFDF8RSRHBlH2SrY8ZalusDW
	HP19kYJeQcmOHY7TkGqxzhNSbk1jo8wgVcR6vc+zz0Fw5GB5+xxeWSb4WZtPKWGzrv9MInbDw4o
	BizZtxR+rMQPbgjQbQyWKMaE2IIAchLNN1gcFpdpMQSonlo+iLGNzr3DTDNCz25DEAhLxWh4gSE
	eIbWzB6NXlL2qENpDLalJ4AHzvcvRuXaomxnXHQdO8ssfqxYTmj/E99ypEq0qx+G+OzQCMA6QDY
	zoleFJwW6mMea6957g02hA9K5ZkGiO0y12pa811NKAtwcSCQ4BLTWttd3pTLmc5XkE8UMmbBYAZ
	t4GLV26GhXCKk9JVzxzNE12FXKl7o1F5pWOZ/MXmyhtCK2tX/uFZVdwiCjNtKpmDGDK6sEY7s9+
	iEVOJGQuFTjyxIGiSJfPsf8d4Gve1SDSjPWUPVx1eoG2LjOfc=
X-Received: by 2002:a17:90b:2b86:b0:36b:aed6:235a with SMTP id 98e67ed59e1d1-36e33106b26mr5951841a91.22.1780540728330;
        Wed, 03 Jun 2026 19:38:48 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6dba8573sm1253072a91.14.2026.06.03.19.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 19:38:47 -0700 (PDT)
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
Subject: [RFC PATCH 2/3] mm/compaction: add per-folio isolation tracepoint
Date: Thu,  4 Jun 2026 10:38:11 +0800
Message-ID: <20260604023812.3700316-3-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604023812.3700316-1-chenwandun1@gmail.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Add a tracepoint that fires once per folio successfully isolated by
isolate_migratepages_block(), recording the pfn, isolation mode and
the folio flags. Knowing these makes it easier to debug unexpected
isolation, such as mlocked or unevictable folios showing up on
PREEMPT_RT kernels [1].

Inspired-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/all/20250820142919.HTybedrl@linutronix.de/ [1]
---
 include/trace/events/compaction.h | 26 ++++++++++++++++++++++++++
 mm/compaction.c                   |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index d05759d18538..8b8b3ec0f324 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -76,6 +76,32 @@ DEFINE_EVENT(mm_compaction_isolate_template, mm_compaction_fast_isolate_freepage
 );
 
 #ifdef CONFIG_COMPACTION
+TRACE_EVENT(mm_compaction_isolate_folio,
+
+	TP_PROTO(unsigned long pfn,
+		isolate_mode_t mode,
+		unsigned long flags),
+
+	TP_ARGS(pfn, mode, flags),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(isolate_mode_t, mode)
+		__field(unsigned long, flags)
+	),
+
+	TP_fast_assign(
+		__entry->pfn = pfn;
+		__entry->mode = mode;
+		__entry->flags = flags;
+	),
+
+	TP_printk("pfn=0x%lx mode=0x%x flags=%s",
+		__entry->pfn,
+		__entry->mode,
+		show_page_flags(__entry->flags & PAGEFLAGS_MASK))
+);
+
 TRACE_EVENT(mm_compaction_migratepages,
 
 	TP_PROTO(unsigned int nr_migratepages,
diff --git a/mm/compaction.c b/mm/compaction.c
index 7e07b792bcb5..007d5e00a8ae 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1223,6 +1223,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 isolate_success:
 		list_add(&folio->lru, &cc->migratepages);
 isolate_success_no_list:
+		trace_mm_compaction_isolate_folio(folio_pfn(folio), mode,
+						  folio->flags.f);
 		cc->nr_migratepages += folio_nr_pages(folio);
 		nr_isolated += folio_nr_pages(folio);
 		nr_scanned += folio_nr_pages(folio) - 1;
-- 
2.43.0

