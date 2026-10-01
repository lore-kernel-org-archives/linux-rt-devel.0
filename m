Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23803438A6
	for <linux-rt-devel@lists.linux.dev>; Thu,  1 Oct 2026 04:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829744; cv=none; b=fjX/ybvbf7VmcVqGgJcfArD/Luf2BGQHqbor+c41MEdz3eSoNDeTIopB9f3jgkDa6HOhF83UpyvzzTCAFPi9XEEOvsj5xiyErfwVCLVbyC4zezzCePzGQT8HgH6WoAwdVS8C1hhhTQsLZ73sGoFn98VTTPJJXR0SEb8ibtY/kXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829744; c=relaxed/simple;
	bh=vZ2a1RS1CoeagLQdph6wHtoMViLnpsPlbekfBXE+tuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFvafMF82lpoEg2jfpgsqmCYGNoJHXryqmQmnZz/WPDemywPUvjuh/v2GyObpVTzeR81D9pXXb25nzEoZJyLizZhbREucf305JaOrBjYAj3hRvSY+dBh8//MTdyhOO/EGrMIXbsFsVOI1u2N1Rdmg+WhZqQS6BVEE92dtnHiGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4AT4Azx; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4AT4Azx"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a00713639cso30353955e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 21:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790829739; x=1791434539; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2Gp1DxjHQ0qTISrrSjvk99H2tt8CfuvB/h7scE7CDY=;
        b=I4AT4Azx8Oh59imkLsHkxewSm1tdeqO++ONZcu2y4zB+Um7FFKf8C3Hg17Ke3CB/OE
         DtP8PY/C3C5NeIpfIM4cuFXADmWKEgua6DvHQOp1Q2pk414dZW6PNiXP5NGg8Q0j67Ek
         zl0HYGzdpGssVUsfPxjorgshj5tl8JloRUqsr23Og2fQlQmTnuUrcvTWZZkVvfkL/4eQ
         qtXZ4z9G60JGfMhLLtAvlU0/W3Uj6f9OlvAZgu/W/XL5Irp6FitUckhXImNMBffDMKSo
         u/dI4wQmONZP3HwZVclVPE1C3z/1pS4jBmvLdmdWpviwkX5ea2uknYd13L9KRQ2qTKFK
         8tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829739; x=1791434539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p2Gp1DxjHQ0qTISrrSjvk99H2tt8CfuvB/h7scE7CDY=;
        b=lqsyAiXWm9+sERpmwyvJaBUBZuNzP7GESvmOhYTWseOBNmaOv8XQcDCkKnIJI7BMSU
         ghycgzhOcXLNSr1HgdTgQNqlMGxjBqr8q2o4AEnuYvtNfRf+43BHen6UFz/IHHoL80kP
         +bGokPtAmguwkN3As5ZOhKls1nR+VsMrbugSPUp8PStizKA1sLO3QOTd3lag743iubqU
         eaw9WkBOB7KFKfL6tHatR96EJimp6Bc6D3eQA63+qslWcV1z85a/IAzYltBEsVOp6kRR
         oZUbP4fqHZcJfHQTPFmC1kQ6X3Wy8l9KAOi7HtU1ADLcyLwpTWV4dlT/4LYtnoO2gKL+
         Dzdg==
X-Forwarded-Encrypted: i=1; AKwUvByLALrwchroYcpJ2DsXWROkYHTBJDljfBsG+Sbmf8WOjf+ShKxB6b4Bvu/hRmbU05EEo2LSewN2UFP50OMtcw==@lists.linux.dev
X-Gm-Message-State: AFuF++mIe1kxQJjqkwRCIBE7PmHwd+rVXKPyZzh/zllg8KKtorNypnr8
	N46TVBoOcj2nRHN/ceu7/6HmPjFnOwy+b/RIZ21UKKTGgrPGJpWzLMdS
X-Gm-Gg: AYBFou17w/dQlEktJDJF4eF8yQHXkZDHirE4YnUXE7OJ1qgcCoTskGjKACK+ODlfmfb
	nO+eYxlZhvyGpSPProdc99dF9ZgreOVZAHKzclbudE81KE/uWDuEthdGSc1u9EDnoAh2YDkv7kI
	GW3YH6b0G2o7++BV/TOqZ2MYZiw49TRNk79q5wiuqk7pNWIhXdXgHew8pmqzkhaLkv273KoF9B/
	Gi6iquEp3hANtEhDfi59mHggMnI0PWNwazbUmlXCuCdTtmLwGhiQo6DwqgYnaOHCKaDOLWjyvTy
	5lK3diX1IXn6EIKcOx1wBAc1h2FnPBxVzXRDnMH/twa0pZ83WuznrdtC6Z613TVxb4q+VCjQTiv
	e7Nr4UKzw8n+Ce9PlIYHzIGJoAfYGX9jDp87GyIaaNMJqtDbBVJmTMO+JDTfDcMxcQ7G+Ubzi2D
	9M8CMjyAALH1pWPyRY9kKEAqWOt+kjb/hhUIONfsYp90OPUMPfw9b5hzZrAwUNwrR6pHLv2KwjQ
	PlNFnofyqn7OhE7YDPLk30PrNIbYkJUfC9oYs4sQ/Da9eE1yx20oKVLuqTZbR4HEL0Act2REQh0
	pkIS85DuYIVmyO4nKuHj9DRlILFC9HbZyc7RXKDOSAx4wpRVSZvv
X-Received: by 2002:a05:600c:8b38:b0:49f:ce72:e930 with SMTP id 5b1f17b1804b1-4a01b13d7d9mr54875995e9.34.1790829738870;
        Wed, 30 Sep 2026 21:42:18 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-117-056-101.95.117.pool.telefonica.de. [95.117.56.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6c5059sm32619515e9.0.2026.09.30.21.42.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 21:42:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH 1/2] mm/slub: preserve no-lock freeing after memcg charge failure
Date: Thu,  1 Oct 2026 06:40:55 +0200
Message-Id: <20261001044056.75079-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261001044056.75079-1-kmehltretter@gmail.com>
References: <20261001044056.75079-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmalloc_nolock() can obtain an object before its memcg
post-allocation charge fails.  For a single object,
memcg_slab_post_alloc_hook() rolls the allocation back through
memcg_alloc_abort_single().  That enters the regular SLUB free path,
which can take a sleeping list_lock on PREEMPT_RT even though the caller
selected a no-lock allocation.

Use kfree_nolock() when the allocation flags disallow spinning.  This
keeps the SLUB object rollback on the no-lock free path.  The failed
allocation continues to return NULL.

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 mm/slub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 54ec125033571..a1f08338102e2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2519,7 +2519,10 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 		return true;
 
 	if (likely(size == 1)) {
-		memcg_alloc_abort_single(s, *p);
+		if (alloc_flags_allow_spinning(ac->alloc_flags))
+			memcg_alloc_abort_single(s, *p);
+		else
+			kfree_nolock(*p);
 		*p = NULL;
 	} else {
 		kmem_cache_free_bulk(s, size, p);
-- 
2.53.0
