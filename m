Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F238AC8A
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873480; cv=none; b=kYVRB2h7Zx9si8VnFAqW6ZRqWNzeV4PKb0Q1dHs1j003esBuABDHL0hF2xW67VW+siU+vZs6U/GXxwEGrpT4mXT6k4aCttJFUvxZ9QiOGI1sNP8yJt5R/ibH3zD6SkSt2DqOYnPdFu0T44yXU4D9aCuuA+D7oMPfudJzL7XyrhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873480; c=relaxed/simple;
	bh=3I5dS/SQ6pCyb3i0Ix/G3rblivqux+gR9oaHKYEaKnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sqIsuFyJggabtS0+pEDFGgdIVfqgkkvmrdgH/arU7DUHe8zjDY2tCDHKCvn5CoKCeOBQ352R22x/ZXA24DNr/U6xiiJcREY7qOqTDG9+neSxSSTy5BL3qmZZ+fxoZ5RAdBB2RL45VmEvtAYgZgBnOsqHoYd3Yqeg454oojhi7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8iqMNck; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8iqMNck"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso297715a12.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787873478; x=1788478278; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brDKxupp32vlfYsuON/JY3iAK7z2zOrfUeaeP3zp25g=;
        b=R8iqMNckqp8ICdF1XGMRpN6lXgmSMtuZclfk0v5CmCWvj7stRnSSkeAs1W8VOHyoUv
         gyT8OdJL+ULHczJGs51cq+DxiG/rMbU2FD3mUVAimy2l2T6y/UIp+xdxHEbrbpOCINRZ
         v1ly7vhVipcF7M3Ff/KbAOr7LYUCTdbNpERGgsHT9HZSP+U06NofxbRuMVfaOHEyXnNz
         UzEOUcyHg/qg6TuEqZlsBKjqkyvqROcOkm0YopwMKC1eqxPH4GvxS4oj9D1g2l2Nd7aS
         VHTGRIk9t9OtjVWdGhBcBuymHbogCUJHlpe/qale/HQ0BVB7oHVYt2OebQ0ajBfLuMUV
         m9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873478; x=1788478278;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=brDKxupp32vlfYsuON/JY3iAK7z2zOrfUeaeP3zp25g=;
        b=o1nP9H7hJev7i1w0r0252LkVzQfuxoU4E4a6LaGj+R5N6OhP3fMpW5FoY0tXi/OMkt
         aMGRDIODa8Vkomd1ZJFkojhQtGf2/K+RLnwmefoI/x1aqnQrelycK5gINcm86NI78qFV
         21WMQRZDKiWTYI/sYECWkr1Tk3fSgVySpttjbvOzL4chlzCrHNwhYrxheLqfnH8F81/i
         zFnogmY7UPLAR/XUQXyAsc8CXHsLhF0J6ka2To6cTfBE8r1AlN+aXG26k7SdzJF4v8R6
         yIil+mkfo4JCarMKhCdPJLyveUlh7LqMJlFcclSjwQlvl/UkYUgPgc1fEkQx3Y9GurR2
         UeJA==
X-Forwarded-Encrypted: i=1; AHgh+Rq56k8jsLQBOuG0SiHjRzg6Juc1dahxb0uLhI9IfL1s8pSuJyBwPyKhZwgPvfoP6E4/b80N2iHuB/kLIktbsg==@lists.linux.dev
X-Gm-Message-State: AFuF++kIfm/FicVM1ufW/yvrAxdIpQ8HkGbJxVk1ksVwIIliTxlAWyDM
	j9NJmD4/7SlmVhyh4WNNEmZlf2BObrf+Sg92k+CY03PBV8GsGoGoimnO3OZ4U4KVFWoVIpzizlC
	lh3hdrEb1ctAqqg==
X-Received: from dybeb10.prod.google.com ([2002:a05:7300:a2ca:b0:328:4d52:8cd0])
 (user=stevensd job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:458b:b0:2d6:f3f0:3e7a with SMTP id d9443c01a7336-2d74dc2ade3mr36333205ad.3.1787873478170;
 Thu, 27 Aug 2026 16:31:18 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:29:39 -0700
In-Reply-To: <20260827232948.2520558-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827232948.2520558-2-stevensd@google.com>
Subject: [RFC 01/10] Add !MEMCG memcg_list_lru_alloc implementation
From: David Stevens <stevensd@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, suleiman@google.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a stub implementation of memcg_list_lru_alloc() when CONFIG_MEMCG
isn't enabled.

Signed-off-by: David Stevens <stevensd@google.com>
---
 include/linux/list_lru.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index a450fffe1550..40eaeaa3424c 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -79,10 +79,10 @@ static inline int list_lru_init_memcg_key(struct list_lru *lru, struct shrinker
 	return list_lru_init_memcg(lru, shrinker);
 }
 
+#ifdef CONFIG_MEMCG
 int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 			 gfp_t gfp);
 
-#ifdef CONFIG_MEMCG
 /**
  * folio_memcg_list_lru_alloc - allocate list_lru heads for shrinkable folio
  * @folio: the newly allocated & charged folio
@@ -106,6 +106,11 @@ static inline int folio_memcg_list_lru_alloc(struct folio *folio,
 {
 	return 0;
 }
+
+static inline int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru, gfp_t gfp)
+{
+	return 0;
+}
 #endif
 
 void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
-- 
2.55.0.897.gb25b4bd76c-goog

