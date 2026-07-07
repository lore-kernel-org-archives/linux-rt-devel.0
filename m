Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FEF2EEE75
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429220; cv=none; b=LalRgyKKfs4s0VPkgBadjmfLOiVe+dj0MuYVQiXNO7GsXb931frxhHJtSs1JnuL8qr9vHW3561ywEVKeV0Y3tdyQGogQcA0TECa+Pa0lXLIoqn9lU2NJTLewVOS6Rwdl9YPS7LLl+RceIGYNVT1RHvxXuEd1liUsr2tR5mmcc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429220; c=relaxed/simple;
	bh=bbIuCO06RYRG5+k7n97w09LEogLitBXzNI9yNrxFShE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dif+BzNEvxCGz+/x0VVuBKgdm5yzfyKHh3AVYUcTnsT2trQhzFvcBcYlDtxUI+UzcX1aB6omf/BXRFgBzzPbH/elnmvKogOyly80VJlgHgqBoDfxDEr3+3v6UkquHH3YP1iBoDl8BLDOGy0ksSc6cogwZ7aFKMv9NBtI54c/GSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhVyyqKN; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhVyyqKN"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c96a1a43f5bso14427a12.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jul 2026 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783429219; x=1784034019; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAK2ceJ1Zq5e1wppikpMizngj/jwkuXHZE5kwSaxgtw=;
        b=mhVyyqKNwQ4kq3MKBQRwuckApzJmd5sGpnMpEnrQcL0qvPv3pF4UCf/69mTMhzjjbx
         +VhJ6CHonjgDDhV1Ack01QVieSEJW8QtAHb0ZjIV+WjclxGrRKKsy4r5Xobp0haGSZsU
         e2Q6YUw48r86HfmS/AgC/KtWbP0gKxLUBSgq2A4q5N7QC1UQdfQIWkpzs9rKmw9lVUoW
         wapkH/LjqhIRqvKbNOf8GSG1tn9MJSySQq9JDf2jB4PBdNOMSforqsfC/GG7Q50K1ISN
         4Hzj0MRdgqfOclAymA/hcA5+NSPmQeTLAQtDbA0d2ty0/VKgK0A8anjCM4maWW8lEyIh
         Rz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429219; x=1784034019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GAK2ceJ1Zq5e1wppikpMizngj/jwkuXHZE5kwSaxgtw=;
        b=UXFokbzfd2QjIx0DSoMAFOu+g0+i2/wMmxn3QEK87HqwfL7kXlWM6TNxLhgLGF5ZFW
         Dq7TccdWcXHJEZS49M2ucYp4QHY7fjMIqthqb5Xmt0Az7oWadGePC5DcBwE0ihy18HAc
         81Uj+8qQk7zq6msPp5QW8ntS3ZbcavMaA1yh0T7aSoWHUKG7WlhAhng/0WauP8N/+BPJ
         AgZWPqUWLq8TY+p8QiVByYdirBeS7g7c4Wp3QT8hw32w5YygV8OOlzxcLwrzXuHzh6u8
         MeZyhPhzaD5X0/m83i/foJicFSjfejkLKjKNIQ0H0l6/IECfcoQ/BwGt67TxBBk7aF1r
         +6vg==
X-Forwarded-Encrypted: i=1; AHgh+RqYDmgasdlClM0mSfOJGGL5PR5ycO1iUeLEicmoNOR/zjNPrzqUDzFqBzYQMw/RSSRFF6uf7vvJ8UX8FFoMfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YztdcwMj6oLX9aUMzjj5VKa9sWO0kuCXGvSUqP1oebeI1MXR5rT
	nRg0QgETd/XDaPoi8u8KA8uwGiCESIGR+yYQ/+l8YkDHfjqo+47o6pQ0
X-Gm-Gg: AfdE7clCS5m+ng24MGAtHKFFUQCXEIp1gbA+ASdZ/YwKXlEtk9RXrSSEFdwLgdDaQtt
	Il0MZVkDwbu5YHDJ3zMWraPD1FukCK4AlcqNAy0jZ8wWyafl26dAOGCwDFvG3H8OyGDpkI6VEid
	4kGk/rLykQ8l8EOE/lwUFBBcTwOJX8U9y3GEWryPrJCsBlo8X5VmGhEiaIec6zvaCQ2ulby8EAY
	yeFrTmNltHgxteNfTtwsojo5xSHO7PG6EekepoRYpu5KocQZ/BhkDvfEhPMACG9RT9UxkM/lhgW
	l1PXFIeF05l9qYK7nQalAQA6nbSNyksyiSJklySvP85vXYGcGM2eS/TK4K8Dt11zTHCbzspd1zn
	0agbMk+32nmXuMuXGEaXqkj7VzK1Zz+WSG9SFqFMGoLFLo81Ba4p9F8mHqvFA+SMHJVRIi+n4S7
	DifHhHriCSFzbBcmBtWNGYouAbJw==
X-Received: by 2002:a05:6a00:22c4:b0:842:50fd:4c13 with SMTP id d2e1a72fcca58-8482f2be242mr2571501b3a.4.1783429218979;
        Tue, 07 Jul 2026 06:00:18 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm5415983b3a.3.2026.07.07.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:00:17 -0700 (PDT)
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
Subject: [PATCH v2 3/4] mm/migrate: add tracepoint for folios unmapped during migration
Date: Tue,  7 Jul 2026 20:59:24 +0800
Message-ID: <20260707125925.3725177-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707125925.3725177-1-chenwandun1@gmail.com>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Add mm_migrate_unmap_folio tracepoint, fired in try_to_migrate_one()
after a folio's mapping has been replaced by a migration entry.
It records the pfn, address, folio flags and vm_flags, making mlocked
folios under migration easy to observe.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 include/trace/events/migrate.h | 29 +++++++++++++++++++++++++++++
 mm/rmap.c                      |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 15ee2ef201b5..1264593ecaee 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -6,6 +6,7 @@
 #define _TRACE_MIGRATE_H
 
 #include <linux/tracepoint.h>
+#include <trace/events/mmflags.h>
 
 #define MIGRATE_MODE						\
 	EM( MIGRATE_ASYNC,	"MIGRATE_ASYNC")		\
@@ -137,6 +138,34 @@ DEFINE_EVENT(migration_pte, set_migration_pte,
 	TP_ARGS(addr, pte, order)
 );
 
+TRACE_EVENT(mm_migrate_unmap_folio,
+
+	TP_PROTO(unsigned long pfn, unsigned long addr,
+		 unsigned long page_flags, unsigned long vm_flags),
+
+	TP_ARGS(pfn, addr, page_flags, vm_flags),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned long, addr)
+		__field(unsigned long, page_flags)
+		__field(unsigned long, vm_flags)
+	),
+
+	TP_fast_assign(
+		__entry->pfn		= pfn;
+		__entry->addr		= addr;
+		__entry->page_flags	= page_flags;
+		__entry->vm_flags	= vm_flags;
+	),
+
+	TP_printk("pfn=0x%lx addr=0x%lx page_flags=%s vm_flags=%s",
+		__entry->pfn,
+		__entry->addr,
+		show_page_flags(__entry->page_flags & PAGEFLAGS_MASK),
+		show_vma_flags(__entry->vm_flags))
+);
+
 DEFINE_EVENT(migration_pte, remove_migration_pte,
 	TP_PROTO(unsigned long addr, unsigned long pte, int order),
 	TP_ARGS(addr, pte, order)
diff --git a/mm/rmap.c b/mm/rmap.c
index 3cb7f6337d38..b110548bebae 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2716,6 +2716,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			hugetlb_remove_rmap(folio);
 		else
 			folio_remove_rmap_pte(folio, subpage, vma);
+
+		trace_mm_migrate_unmap_folio(folio_pfn(folio), address,
+					     folio->flags.f, vma->vm_flags);
+
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
-- 
2.43.0

