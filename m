Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFA448CE8
	for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113439; cv=none; b=nx+lw9stYPFen3y6QCkrIRjVu0CerEHx4ctUfiI+tWICrd1awBBxPIWeZYrt9x77gKG16cB5RQauRXebDdGlCD5L3jF3k4UgRqzzm014+pHfnTBJRsaZ0ThAvFe8AbrkgaP8olBzOf3M2K7cT/dqbwSjuxkuhBsemehBiSqjGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113439; c=relaxed/simple;
	bh=yMYx9T08PdeyCEUHBvkxhJ5enBp6n+9uUVKhIzF7q88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iJpfRp7uGd6ZEfyDFh0R3rnNoiI6dieH0qfHgK4j1Prr6lz1G/RIXjqEHBvMYRwSJ/jdczaENV9u7T05BXpbFod6xk7qUCz1RcKXWprsGHv/MNUfkg7iSCL1J7cc2G1gO//mmVa8h8w7jwgMidq2UmrUdDL3GoxB+ujNWvE45Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YducKLL0; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YducKLL0"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so3225716f8f.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784113421; x=1784718221; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7jfYCvKZRG50MPG0jJuxwEVxoiBrjqYJeMDmdl5htM=;
        b=YducKLL0qNy7cUz6HuFIlkKGkGUqOCt2dSlszERWnMa1mlLkJ1vAt8Q7m7o9kpt7IL
         vMO6tyYvIwqxuk66/BNS9CCbNSLd5TPlGU30W0e1fVhJDidfZfJW2ZQKzwk2DV2RLGrS
         Mq0QFMJyafDlaSUBq80eJIkSqZcR6pcvYVuz0H0MTbgg1gdcj8VFjp17ZkxpcZWi0Tzn
         6z60ihc8G9S3PLcDY+rFNABxDY8Fi173hQw3gHnZPbAab2GOVSyV86MdhmLmJmfBRx+r
         L7lDw6XpL3s9KI297J0x43qQioeeCHAlEfFLC+m8APrQ5HBRq5zyyMm7IPuM/6On68V9
         fTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784113421; x=1784718221;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z7jfYCvKZRG50MPG0jJuxwEVxoiBrjqYJeMDmdl5htM=;
        b=MQnFGKJ5tMeZwIOlOgFwVbtEWA+WHj5CA2INyNZ3NZXjbdfcwYBbpQglszXlGUbEBr
         dtBowffoE9wcaCya7XYMWVUsHQQ4sZDbHFFtIn6R/19TpICJgjnNwlIdL6DL3tlKL3jl
         pTEeOr69mKPRksHJHRSoTALdRnvKu/f5CCiEBMRjMSulLR7vZcLUrEKIq5q4GCsHUSPW
         qr5IMbRD14ED2Jt66zQ5FCnfMqtKaTg8xKZENKFPwwV8ESrPb8DCbj7oC1ta6qAUYM1n
         xpan8JidhPqI4ujp9U/VfXl6XMyZ9W6ktkD9t2BoO88BsIF/JmBKW88UXg//o+G9Ab1i
         tEGg==
X-Forwarded-Encrypted: i=1; AHgh+Rrvu0lRAnKnoGrMLffUT0x1sTwFS9XhcVrljOB4Qr+FWJjeECSsWpF4uOfxxyVflfXcivzoGnTt33ec/8N4UQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRYYm+gYi36ifkPVqWIriQMS434EmA3edho/7PMD1VxjxKOWos
	jEj5yl6Tl82pC3Eajqa9L688YlYngnVeuRarcffT5TM4KRQ6tqxP8L7ZtzBTtU6RFhjMm9CEtLV
	ASvgq5Cktyi9dNQ==
X-Received: from wruj11.prod.google.com ([2002:a5d:618b:0:b0:46d:8498:a146])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6989:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-4953c1555a0mr25987965e9.11.1784113420581;
 Wed, 15 Jul 2026 04:03:40 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:03:20 +0000
In-Reply-To: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260715-spin-trylock-followup-v3-3-fc4d246f705d@google.com>
Subject: [PATCH v3 3/4] mm/page_alloc: fixup alloc_pages_nolock_noprof() comment
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>, 
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>, 
	"=?utf-8?q?Michal_Koutn=C3=BD?=" <mkoutny@suse.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, sashiko-bot@kernel.org
Content-Type: text/plain; charset="utf-8"

Update the comment to reflect the recent change to allow flags in
gfp_nolock.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3%40google.com?part=6
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c2da85e69a0f8..25a83a57aab66 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7983,7 +7983,8 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 }
 /**
  * alloc_pages_nolock - opportunistic reentrant allocation from any context
- * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
+ * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, plus some flags that get set
+ *             internally regardless (see %gfp_nolock) are allowed.
  * @nid: node to allocate from
  * @order: allocation order size
  *

-- 
2.54.0

