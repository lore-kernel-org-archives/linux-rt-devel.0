Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4814D8D93
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985803; cv=none; b=qwfIh0hlm2Osg50JBUq77SUh760il1tFEI+j/622PZw7OrGg0VGuhWrbrNSnkiBzLGI61/lqFJ50DCxJBJGboCYtiu2df2mvhgeFF5otse9QSxqzMuEEZzkc2Sh8vPROLBMA3JedN4mfW037oNfUiAkalklYBA/HrqAJ+jm4P20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985803; c=relaxed/simple;
	bh=e9Aq/Lhdfl1yJqNd6CCQ/UnT9sivz66ucPj4rfg4nxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qu4Jntf8fUhbHg/vh+sxzP+l82xcCPiM4Pp9GdMebKxVl+JfL/sgCwpRpgQlEzJOdN6ewwjSRs/+yVrPOV/tvn/fpIlNKazNKUVgD+uXmp/D2CzQQ9d1RqB4eGL2mLnHcyKxgzIMQ3Vc6nz5K5drzB1XJP0Z/BeRhzeCCQsRqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NyWfvVBD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NyWfvVBD"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493c619bb52so3521255e9.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985800; x=1783590600; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lC0ttmwMBcsuhLErJ+9tppRyqpd5bumu/+XIyMEHUjw=;
        b=NyWfvVBDFds201A4YwYOKhgquk0Va1pKW6rQqyAphzYp3MXqOxjYIYrb25vhPO8bTV
         OHxmkvXyorFmiXyvRk2cU/VGi9WUntad4l1ZG+SpAhw5AmX0+Z1OjryhMqlHDjBsI8Ug
         L8km0CU8jqlxRqT0CzVT0oyHaaflLOphH4THOEwBL6OMVE+RwGkvwtO6aKLVcp2I6xwJ
         dQtEyd8XByLwcxBUjs/HMNIY25yeUS2K6H2gW+FpgtPA0okh+iLI+x7a0E9skGci7Jtt
         QCFuMhGS7f3yGHPFuc6AWBgYiHavmkTWzauh2NgtaOKOXY9Y0ljiWVgsux0PInzKUXuC
         XxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985800; x=1783590600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lC0ttmwMBcsuhLErJ+9tppRyqpd5bumu/+XIyMEHUjw=;
        b=sWhemBGBka3DM721K8TnG9+IXn/sSoapk1CIMq7F3G8unDVo7psnLQMgRtETAcCnwi
         8NnvId07TkOZIz5KozL3uqGDwl35ChwA/3YoHmA8o+49fAuMxdJrjauv/e95a5Xc3H1y
         Bcu5PvPZ1WuRGw7gtZ/7uo/TCq7gy4DpHNh8xWuP1e5Lef7Gh09QSZVNHVgUl1UlxAdU
         fqh+UWsQQUlC5rGaEzMrflf3MNdJobpcBYOftRyfIeULBOO6GNGTP8L6WGeuKHjKGJ9Q
         +eDIThOh9Bo0GOygxDph+7CP+JnwvpYzsOBq94ZzepDYbrOZx6HtaQobt7xLaaw2kIDb
         DHSg==
X-Forwarded-Encrypted: i=1; AFNElJ9DP8Ieh1NdlMEtQ4Am1v4NmBpYy7fLZ0xQMjPS6eksa9Kq/upWZfFBpT7ysFU7CR8TfoW6tdR0ggUBE7uo1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ60OtHukWOE5AmUNZ3G1LnrQR8l3CSgCJZDCwftF3wVgXrZOF
	2uEKk1/hC3GGlmivKfuHckh+a5HrN8GUqtgjcO9JcUhHYWUtx6kH+rUizW+IA0QirgCxkFwk6xN
	k2ougmWyQRmtR+g==
X-Received: from wmga17.prod.google.com ([2002:a05:600c:2d51:b0:493:ae35:2761])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:37c3:b0:493:b771:de06 with SMTP id 5b1f17b1804b1-493c2b3cc56mr64184155e9.5.1782985799206;
 Thu, 02 Jul 2026 02:49:59 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:41 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-10-0af8ff387e80@google.com>
Subject: [PATCH v4 10/18] x86/virt: Use higher-level allocator API
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	derkling@google.com, reijiw@google.com, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the latter allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

No functional change intended.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Assisted-by: Gemini:unknown-version
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/virt/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
index 7e9091c640be0..a236447ac7a26 100644
--- a/arch/x86/virt/hw.c
+++ b/arch/x86/virt/hw.c
@@ -196,7 +196,7 @@ static __init int __x86_vmx_init(void)
 		struct page *page;
 		struct vmcs *vmcs;
 
-		page = __alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
+		page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 		if (WARN_ON_ONCE(!page)) {
 			x86_vmx_exit();
 			return -ENOMEM;

-- 
2.54.0

