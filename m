Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550396;
	b=KSSb4cmc7Qp5LYBR9sR9FA0q2OgtiC4ftOexzeFPaR7JMK3cJj8N6LAdCjtLEyYtize7
	 TKwwmK+EhPQgpHQcRbeJ4MqdHXeO5Dp2G5rlIP3TLnERSI2Sp46fHgEXEj7bdB/HokaFN
	 TyF2hdTx0CGYy67Xk76eqMoT4E1w9rUb0LUKWvS/Q52lHNNY1QEzWkAxfx5iVDrsD5WzF
	 qqtBEckC2Xp+aX5jtE3YtkzgA1oRZhh339o0910rtnmWjuYntK4yYocLUXmRHrh1xgCa7
	 K2q0cLPEj5wJzTq6dZeXWD4XtFZlsUUzpiUNndfHgOXMoTKjyZmPPl47fT97C/xG8cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SIfdYuKrZowGGWCzHHgolNoCF8XMtQxMyZQ9b0XJkH8=;
	b=WzQwBqKcVKVVuZYEVZedLt/m0cknroTbooDMQRly4DVQO4/VyRME0B3DS1wYO57i1KmY
	 JwMQpYZ7DDZXZnZZ/9eNqeZn211qRt+LzZLmz/5WweNpmjD+txFg47e0l8s7Lm3cAHGfo
	 FZwNKcO4lxucvu8UCg7x21tOm5jsb35W6vmwWUSgeTykl3NIpFbSxVOyiWlHKCPxhzgiM
	 87gE7dGQqAAW+SoO8EgK0Xsyw0IJiMW2TOTOoUBHKMLLqLHoGqcZKxmwXiwyxyjpEUiVd
	 o1tssASZDh3TKSy7uDDJAnRKHqZGck4jdPDOF3nzXEZo6cHmBPjEu5Nr8IqDUnG2Hbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WgHku+Cz;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395960A2616
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 02:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B395960A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WgHku+Cz
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f3c616c84so24419385a.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550395; x=1793155195; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIfdYuKrZowGGWCzHHgolNoCF8XMtQxMyZQ9b0XJkH8=;
        b=WgHku+Cztln6C8p7O66ynywXCGqE065YRqkca/RYa7Z9z0P3Uq/29dTnPPE67yoqif
         +0KxNmxIVKVCiLhVLMHJ1YUv39rO0azF5/WWlhsD/vi3Mizi20VBXj8FPArRcjlArLlX
         OvnLid32y48GzLZHihPorDtg3ttk1HbVfyyygge/YvupN2sbZmBNoaxeNatG+kFwxZe7
         PTNBCP22bdBjRnNb1PkpQe8Mdc6wUwJ5VVbqFiB6CxjwqTaIApqFt2VHZlQmHukb+A6C
         2GfyOHoMON21Q7MKYzOAEtFFUau6xFetms3sqck6FZSjZu3MlBHNuvavMfhrIJUAH3wE
         99UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550395; x=1793155195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIfdYuKrZowGGWCzHHgolNoCF8XMtQxMyZQ9b0XJkH8=;
        b=N8IoH0F3ztBw2aVzZps7SvrVI3ITvZRHNFmC62XSYuJ+1mRMQC+bOFHIwov6HHtIPq
         QyMRxuNZa992NZCg4EZ1KcP6BbsCOjI8xV1/G8GZBI5fxDi+0IPArf0H9Iwrh5WzkpN+
         SoU65SQYE0vTIh+qravGjTNyUO5eU63LiqhS+dBewrerrF3Ei9R+TumoEdY9UHnSmz/U
         Tp7JM+9Fn54X1hMXBFhWOqHAHf1GY5Oill7TmQgfhmaK23f5GBuQD0g8Qq5MkAGKKGU/
         xIeBzdgzaH4Hc7wEytUHtaWHhdQ6BE+PEdMqcrdrwLr+PMHByhI7vodZzf1EECY9x/+V
         CmMg==
X-Forwarded-Encrypted: i=1; AKwUvByhsKOxwpL/nkcnMxQlaXin9obNXcImyeopnKjkSZyDDt0srXuwEg/20L33zq6bOuA6EsC9vcTC8+WGmrFkAQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ5u9oOGu3xALcPctX+/5FemEBjRKvoEIFaC39Cp5+RIEF8KRfH
	dKgDNJM2agkQzjQecL+KPj2pDFANRFl7YewXVyeGUEk5YpFUaH2nzySYuZMlpyRSOSY=
X-Gm-Gg: AYBFou3UbRsyGOpqmTNaAGt4p+KZ8nEuFNaOHUcW1SFilLTI+4RIlptwrbyjPCBftZg
	i3Wq1tgluIST02W29mfpzukH0wbglP0EhGjVqtRakFtGnoL8h3W356gJjFFTGUnshGHclAs4uqp
	MOQ7Z2CIqpOBpwX3Mj+kfv1pFdh5Q+qto8XsR+4GYZlQCHVxFAUhq62h7Tqk6GcOscwvvtdS77z
	F+IcWHXwDnEMAXeEeX/cBHo7ehBRRWEoMlu7BUhiCwRybWnvBa899bt5hoh7Z7EpAopJza1F2T1
	msrw4FE2678eetZIG7hDNKdLXbKl3ajrLld6FStS4/xrdpnL9rSP43DFK/ypgbF6C+x/YXPs/mb
	XHYFuOFpwjbf8CgJ+SptlCy8yiO0T+LDGD1ct0M48Sr9jwrTnAgadqbKHC/0EuxqCjm+ftCFCQu
	gUOlD4BIOAIRJ5DRK7ESdWDlKFZcQZKd9wRV7ibP7ri/yPgFF8Uq6EUMxRXBAtZ0MJWDeVzpkzc
	hxFhjithO2zkVkipyijGFbBMlH9GRThccP6g5Yzj4SDtNWQszBt9b9F0PaZew4f39295xQ2otWz
	0GpyLxrb04KJT5qvIZuIPd0ePGZVYkUAYXHa1FajQWgfHFD7u3KfIsSt5k9xgLo=
X-Received: by 2002:a05:620a:260a:b0:93e:48fc:aa85 with SMTP id af79cd13be357-93f57f1d75dmr211957385a.43.1792550394720;
        Tue, 20 Oct 2026 19:39:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:54 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v3 6/8] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Tue, 20 Oct 2026 22:39:38 -0400
Message-ID: <20261021023940.1940971-7-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021023940.1940971-1-gourry@gourry.net>
References: <20261021023940.1940971-1-gourry@gourry.net>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone. A hugetlb fault bound to one node
can then take a pool page from another.

dequeue_hugetlb_folio_nodemask() picks pool nodes by walking a zonelist
with the policy nodemask. The iterator approves a slot by its node, and
the walk loads the zone from the slot afterwards:

  CPU 0                             CPU 1
  dequeue_hugetlb_folio_nodemask(nodemask {2})
    slot 3 (NORMAL2) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [.., NORMAL1, NORMAL2]
                                        -> [.., MOVABLE1, NORMAL1, ...]
    zone = zonelist_zone(slot 3)    /* NORMAL1 */
    dequeue_hugetlb_folio_node_exact(h, 1)

Check zonelist_update_seq before using each zone the walk returns, and
on the way out with nothing found, and restart the walk if it changed.
Checking before the dequeue leaves nothing to put back. Reset the node
the walk last tried on every restart, so a restart does not skip it.

With kprobes holding the walk across the online, a hugetlb fault bound
to node 2 took its page from node 1 in 3 of 3 runs, and from node 2 in 3
of 3 runs with this change.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/hugetlb.c    | 13 ++++++++++---
 mm/page_alloc.c |  4 ++--
 mm/page_alloc.h |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b37d7d0db7fc9..8edf323baf0fc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1293,11 +1293,11 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
 static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_mask,
 							int nid, nodemask_t *nmask)
 {
-	unsigned int cpuset_mems_cookie;
+	unsigned int cpuset_mems_cookie, zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
-	int node = NUMA_NO_NODE;
+	int node;
 
 	/* 'nid' should not be NUMA_NO_NODE. Try to catch any misuse of it and rectifiy. */
 	if (nid == NUMA_NO_NODE)
@@ -1306,10 +1306,16 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 	zonelist = node_zonelist(nid, gfp_mask);
 
 retry_cpuset:
+	node = NUMA_NO_NODE;
 	cpuset_mems_cookie = read_mems_allowed_begin();
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
 		struct folio *folio;
 
+		/* A rebuild may have shifted a node outside @nmask into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry_cpuset;
+
 		if (!cpuset_zone_allowed(zone, gfp_mask))
 			continue;
 		/*
@@ -1324,7 +1330,8 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 		if (folio)
 			return folio;
 	}
-	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
+		     check_retry_zonelist(zonelist_cookie)))
 		goto retry_cpuset;
 
 	return NULL;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dd8c9046f9a06..5ca8e57c5fcbf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4411,7 +4411,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
  */
 static DEFINE_SEQLOCK(zonelist_update_seq);
 
-static unsigned int zonelist_iter_begin(void)
+unsigned int zonelist_iter_begin(void)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqbegin(&zonelist_update_seq);
@@ -4432,7 +4432,7 @@ static unsigned int zonelist_iter_sample(void)
 	return 0;
 }
 
-static unsigned int check_retry_zonelist(unsigned int seq)
+unsigned int check_retry_zonelist(unsigned int seq)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 2b1017a91928c..53df6b8a0c00a 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -265,6 +265,9 @@ extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 extern void zone_pcp_init(struct zone *zone);
 
+unsigned int zonelist_iter_begin(void);
+unsigned int check_retry_zonelist(unsigned int seq);
+
 enum fallback_result {
 	/* Found suitable migratetype, *mt_out is valid. */
 	FALLBACK_FOUND,
-- 
2.53.0-Meta

