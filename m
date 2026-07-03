Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D83D47B3
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081959; cv=none; b=PXuTvYMIJQp+p7LIW8pnJqy/cX1s34jmBm7uzb40LFBIcr1wmAPhZ4hdlWBWOHCFaa2pu+lSa5qjaDE0GGvdQS2Ei2dVo/XaIRpPNswDlbVAxdK3Jw1JcvPN905G27Nxwjm6DrNmQq9ahcFgFE+GAKQ6/lioNDAiarZYZhNDQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081959; c=relaxed/simple;
	bh=e9Aq/Lhdfl1yJqNd6CCQ/UnT9sivz66ucPj4rfg4nxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=smYicLUEWyoovneJy29yXZxIc6zysG8BVdzyv6jBvLeoFZuFDL/OeZz3oNpv21l2jwcF4xzeyXoz0yfEIIWPHLX/M5DK+R9k1xJnI6rzn5nDvyu0YixTtVlrO4uVCFPLHcKWfgygI2ojccKQbiCFlt+oVVH2OGmdoTXfg18PLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufnTvkvp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufnTvkvp"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-473e18559b2so331120f8f.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081953; x=1783686753; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lC0ttmwMBcsuhLErJ+9tppRyqpd5bumu/+XIyMEHUjw=;
        b=ufnTvkvpWvOUraYHd9MYbY7neGHen2P8sFuukjp3FmjhNJYmGh9Y/m8VfDVAqVkJ4i
         ISwg1VrKWTnyK3rHMV1ElzdK/3+oy7qGV82VaNiHZXqryCDz77srbhQdtXK8Ilub4j7+
         o9AKFuFbd2VmVY7hQSX6uy190SlBIQrfDUeXmdYeLTDWcoVNSs7l1KQPY4OUyzMnswVv
         cOHM65YyP0avXwbscgUfI5wN6KSozo+duGxPUbPTqE2HUzU3QgO/T4kbZNEalAeu7Cb2
         CWGg8ss0CQEPqdaENt3gPW/WWuJjQtlDSyKsk375rjBkgWsEl+sbnChSGKILopcnuTXW
         S4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081953; x=1783686753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lC0ttmwMBcsuhLErJ+9tppRyqpd5bumu/+XIyMEHUjw=;
        b=jDnvvwb0BxQ5Rgh9Q1yqThHIwsOr4nuFaoDDGdplirN92z/e6Wicz5jEZP2pTVxObl
         iiK4UfRqvoBKSiqOn3+USRPPVXXgGpafRLmsMUP7XmJa1m1up/yc6f5a+RDq1q9MbVxk
         CxtmeFqd6t9M3qR8kIhxS88roaXXQvPbQ8c1G1N583G7GDJEScn4AHZTUwFuLFCj0ulR
         LFV55wHLMPpnKbiemOxUxLkFJzlefFpPAXLhc5hLBspXNpVsLjXW++C13fjUs7xFPD3U
         Dslih+vG+4uemc+DdKsApLBawEcMCx/37Z1LABHcfzF3Tl7jhGRz5geezaKVhhYdiVmc
         JZeA==
X-Forwarded-Encrypted: i=1; AHgh+Rrki55Vn/ZkUXPP7RjiUZABKrjeC7r1CfFXyl2ViMP111riyY89xbqfb1xuF7fV1XyCial4uVakroLx5hchFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgfkmDJLpRNJJiOM/RNgF7m6L9mAl5vmvCb/tMAiUeS8et+Ldy
	r1Ig2aJcRdWNi+wP/TDEH/kNB45PuZ7Ag0LdKf72vgCilbRch9MNetNu2scCBg5hokpe0AoM38p
	y/I3w4TRRgBkU2g==
X-Received: from wrou11.prod.google.com ([2002:adf:ed4b:0:b0:46f:e7a6:2dc5])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a7:b0:474:d7a5:4b6d with SMTP id ffacd0b85a97d-477b38897b8mr13728542f8f.21.1783081951915;
 Fri, 03 Jul 2026 05:32:31 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:50 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-10-c87b714e19d3@google.com>
Subject: [PATCH v5 10/18] x86/virt: Use higher-level allocator API
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

