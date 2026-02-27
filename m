Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0BC34B425;
	Fri, 27 Feb 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212095; cv=none; b=mlSl4ff0R2f7afMTQ3a5IW0ZznXM2XxCV8n06FkNxb2dZlvwXdGDS+UYLcoYnPrYVSKi+hZiQu5MPAGNcAGGCLrTOEVY/Y36RIhvTvwqVcrUdu21HLQvplOcYluXKZyOQegHTV/RhBOmgszQX833A7J2eLvobPUuZLr5TyDyZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212095; c=relaxed/simple;
	bh=ZHsMfkpb8Z0NsJNQxwMtfHR8hmqWgsxeSPDgYVWSXNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aY3drznBR8qOQgvMGI6eD6irfRleqWyOTbR1lMr6vnrdoNTu9bMO+C7pHwWNQY86GsgiF1ej7ez4+j9ZkUyERp2GcmHRKDQ4cxudyNcswetPToKFOZnpKjvQPrlupzfcGKc+SnvGt6KeXHtX0vcGKqF+WXzrPTcTOsLKu4/fI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtxnVYNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtxnVYNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16081C2BC9E;
	Fri, 27 Feb 2026 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772212095;
	bh=ZHsMfkpb8Z0NsJNQxwMtfHR8hmqWgsxeSPDgYVWSXNY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PtxnVYNvAXCJ0AvExijB+9VlsYSOS0chDtohot4FhDXzNLcfeknAAMcG/spA/0f+D
	 cF1j5qXDZIctqhBDMzsoEzd4wKLasrfaLl2ruaHJeuVyG93FQ97/7h+Qcx0epxdv9W
	 QMy8rJtv/Ug6PYsVk7byrvI/fq6NrZnE3BD3VsEMdbImOwngtuO5KEFkEgTAgp7wdF
	 YQxHA5fQ5Y4NgOmqjj1CsF3NhN330pHH8rEv8Hj/MbUulBRWV6vS8irzIDMLZFgosw
	 34CDkWj3nCDF/MZqCxp6Lx8PF3hSsMNTdGt4fTt6TKGJt22KUIdxDiY2Au7JN+xn7k
	 vAm1rmgjELXWw==
From: Vlastimil Babka <vbabka@kernel.org>
Date: Fri, 27 Feb 2026 18:08:00 +0100
Subject: [PATCH 3/3] mm/page_alloc: remove pcpu_spin_* wrappers
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-b4-pcp-locking-cleanup-v1-3-f7e22e603447@kernel.org>
References: <20260227-b4-pcp-locking-cleanup-v1-0-f7e22e603447@kernel.org>
In-Reply-To: <20260227-b4-pcp-locking-cleanup-v1-0-f7e22e603447@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, 
 Matthew Wilcox <willy@infradead.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.14.3

We only ever use pcpu_spin_trylock()/unlock() with struct per_cpu_pages
so refactor the helpers to remove the generic layer.

No functional change intended.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8e5b30adfe40..b1007afa9492 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -112,35 +112,29 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 #endif
 
 /*
- * Generic helper to lookup and a per-cpu variable with an embedded spinlock.
- * Return value should be used with equivalent unlock helper.
+ * A helper to lookup and trylock pcp with embedded spinlock.
+ * The return value should be used with the unlock helper.
+ * NULL return value means the trylock failed.
  */
-#define pcpu_spin_trylock(type, member, ptr)				\
+#ifdef CONFIG_SMP
+#define pcp_spin_trylock(ptr)						\
 ({									\
-	type *_ret;							\
+	struct per_cpu_pages *_ret;					\
 	pcpu_task_pin();						\
 	_ret = this_cpu_ptr(ptr);					\
-	if (!spin_trylock(&_ret->member)) {				\
+	if (!spin_trylock(&_ret->lock)) {				\
 		pcpu_task_unpin();					\
 		_ret = NULL;						\
 	}								\
 	_ret;								\
 })
 
-#define pcpu_spin_unlock(member, ptr)					\
+#define pcp_spin_unlock(ptr)						\
 ({									\
-	spin_unlock(&ptr->member);					\
+	spin_unlock(&ptr->lock);					\
 	pcpu_task_unpin();						\
 })
 
-/* struct per_cpu_pages specific helpers.*/
-#ifdef CONFIG_SMP
-#define pcp_spin_trylock(ptr)						\
-		pcpu_spin_trylock(struct per_cpu_pages, lock, ptr)
-
-#define pcp_spin_unlock(ptr)						\
-		pcpu_spin_unlock(lock, ptr)
-
 /*
  * On CONFIG_SMP=n the UP implementation of spin_trylock() never fails and thus
  * is not compatible with our locking scheme. However we do not need pcp for

-- 
2.53.0

