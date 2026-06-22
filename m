Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289FE3A16B2
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122517; cv=none; b=iL3F++oVQdg2Q+dZQQCv1ruV/gCshlFGJJ4Aa1A9oyRQ97L6RZbrICUpmt/MTrDAlJSoIEXvp2whYg6qFObixplZnmmTQ858vd+ROSBMTM6f/MwFc/L5PxtP6Fk1PQJ3WPt/9e9scJJX/F1207kpcgvIoZp4pqGnBAb/+XONDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122517; c=relaxed/simple;
	bh=dCcMAMLOMeAw4obuTGRcGO0t+lrz+rjvtnsdBQ0mhf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PT+VlcigwDi2BWJ1ibhT+qC6eupTa7mN3rKs5rPo0lktIiaDNnEFnAVgvGL0fCHALicbornVuI5ShRAPAchTyFAWhhNJXTG/IlwHLCAHDcbDFnu6xK0TPanyKLDU42kJc4+wPWfiOYlLDXTEcEBirMOhWtgbUVOxfgPC36UFh1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQPX4gOv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQPX4gOv"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490afe64f26so17226865e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122512; x=1782727312; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SzngTEUmnpI9e8CaEbeiYK4MLoCzByF+Q/8MZRzDpKY=;
        b=UQPX4gOvf8jeWyQztm3w6cC6iZoIIBXe5VPPbWiJAL9CDqaGOVZN9eS4cNhham2oP9
         XTAQJgPA3cmbdG2IBP0rMKG9KfTyuicc7T8WKvwQWuLIe2ufahVbL4WjwWah9CtaTf84
         k7ywKxYKYEytLp2XoITlickkV+Iy1HyHJZB87vHlSHjLMjp4rMv89JTtzKFflsqETkqk
         jUY1veQ7/5zfnnfD8epsMaDsDmjcA44Jh5arYGHB+BrLlCzL1Pe78Pw90NbT3Yto43l3
         xJ097GCxCPsOKjVqR6HgKNF/Sl0+WbH4C9UopedBBwtaoobtZkXsqNsCuLPjNEn4HTQf
         lTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122512; x=1782727312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzngTEUmnpI9e8CaEbeiYK4MLoCzByF+Q/8MZRzDpKY=;
        b=ErXSslpox2xUQSVuCmA94X+7wnTPL8kW6nRIKbvLffjTaAh04SaXI9GJnU1GWxWdT1
         Yy4SM61qTaS/lFWAn/B3f5OWuKrk6h8AE62VqCFtDNGwSjjEqndZnz9GSv8Nbto72/WY
         BiXIfA5HSWNEl3q+/rwxEAErXZ6yrGfFPzWPTs6bARYiUs/Tps4QlPLDfuDUynVQR3jH
         Y6cEq9GGoUA/Ln9u8g9gCBYBto4TgPGpqQ+w3iYJKUu8hDH81C0EZNn3wY11J0mmGLZs
         o6YDkw7qbUwfl2beQq6ZxYYKrLRTwz5aQq9dNO8C7khMEv5FCn4Wg3EtBleRQDNEU3D0
         LISQ==
X-Forwarded-Encrypted: i=1; AFNElJ/N64OugrJTmyrJuNEHY2TD1KJOILdMe2On6bOI3fATjgJaYZ/S5k8JORLGk6wN3/vLQzgDzS3bOU1q+yZDUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyTu6s879bHkcNNL5KJwrmDmQSPMjXBS2UJy8LJb+AFcDylFrx
	y9XzwJM9t2OdUMXbQ9xbl93E3vY6v0RR8qdM2vi0W4F9FqVtKgjKZ5QYJLKf/lkwZJlZ83pt4xl
	5Oh3vZjgbUwpiAA==
X-Received: from wmpc6.prod.google.com ([2002:a05:600c:4a06:b0:48e:6f63:7624])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c27:b0:492:4871:7e21 with SMTP id 5b1f17b1804b1-49248717fcdmr138183195e9.10.1782122510601;
 Mon, 22 Jun 2026 03:01:50 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:34 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-7-31f31367d420@google.com>
Subject: [PATCH v2 07/13] x86/virt: Use higher-level allocator
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
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the former allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Assisted-by: Gemini:unknown-version
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/virt/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
index f647557d38ac5..4251e410474fc 100644
--- a/arch/x86/virt/hw.c
+++ b/arch/x86/virt/hw.c
@@ -183,7 +183,7 @@ static __init int __x86_vmx_init(void)
 		struct page *page;
 		struct vmcs *vmcs;
 
-		page = __alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
+		page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 		if (WARN_ON_ONCE(!page)) {
 			x86_vmx_exit();
 			return -ENOMEM;

-- 
2.54.0

