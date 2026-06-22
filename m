Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0B39B481
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122512; cv=none; b=BBRA+T7M4ORy2JoQ9CRhbLhatkWL7+paiI1PGY6j4T352Rva+8cr/C65eYcvaOk40Ek99sprT3ms8ChEYwFCBkuQE6yARyNrgG06GOULqZ+vRN0zP59BVt/Xv+lANvwQs1WjyycrRStfICm+b9QaU16ZDz9jg9UQhKHM4bW6pho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122512; c=relaxed/simple;
	bh=hncVUkOBSjCSge9NF4UibQdahRu3NGfGamSBeSw65MU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CpuouqUwIM1gKCsaqjH8HlBLwzGyqKHG5AYO4WWiaFgJuFykmJtQ8KLH0ieXOj9rxUavzB8yp8V8Mj3etCqUv0Djj1jqWiVJ2ZI0Q+QYNBVG4TgF/pXI2pKL+dxJW039XXSj9zlMJ7aT0THqcwZv+HD+ocRwHlYPb/9su4aKAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmS78JmZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmS78JmZ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-49246459bc4so15907055e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122509; x=1782727309; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAXfb8BCSbPGPrK7X9VVeT4nqNdHAMMoqJF1QOMo6js=;
        b=JmS78JmZZUbtpYOR9dhOS8Dw1hfB0YSj+ZhrsC/zbkkJBX3CHOIPZnMXwvK7RE4rpB
         FNWnIDPoqIkyBqRQjOADdel6cMV644TUuyRvhWiLpLif1OcBpiukjnkcn+Lz9seBBrYm
         8RqeyMHlHT/Y7k++wUS4FMG6x0uiggf3BuNZnppofc9pihvk0RF03HW1m6UlpSKilCS0
         ohmEB1FUJPqbPMnn1+ThVD2VQwp0OMy+UvyYGEnWeB1r1phbFNtNtZUR3nPTy3Z83vIh
         XohRGoKXqUEv67gYyqD+kAkMGxWCquPMy1f3XDw9lZYU+9iL1frvedGOkZOi50QtTOJD
         LmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122509; x=1782727309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAXfb8BCSbPGPrK7X9VVeT4nqNdHAMMoqJF1QOMo6js=;
        b=UXr2gsAYsUJZmcbzplCk9UJ1pU3RPW4QDNZPb+d+qzMhxG2af0gbtnrTR86Pc9hsNj
         FV2KUmmn0qszahq2bbJLeLy29+yxHQ4zRMxZi/ZZ9nA5kSQPKRxN7CAUsQVM8WnMD7KT
         VpX5G3YnPnY4p4yX/j+cqKw88f3RFXqWIuogKtrJF+MGyvvXmpD1wtoz2w1ib3oJPVZu
         bjfyGmWs4Abh2XVaiBlHOlyyAt5r2rb6rha7pDf9QHVA8Z1dnVDx2zZZNgcIwnS+qi5T
         NNPWH6IDku+DaXYUD5nHfCWiAWpQgQfe5AxwJFitYeSjpSF1Cn6Bw7gLKlGybK3njK4w
         Z/vQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CzVk/ENzTVB+WXfieaDeQMvHH3bycTW0ZL5597sMkKq63QVLEcOsyNYQsCml3dnITD9uf+8gJB7QryuCmow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWZ/YXa2fYObcmZ7NugZsyc+6sxB0VIc7T8gbDjqqk8IhLXUii
	Ne+pVnR4Bukk+4Soa0qBbM0ym2klTV2S7AQbVL353a7vQeg/y6ffwqw7nDJvqh8hzXDK4SGHmki
	3lFrpiEv+R6Tyfg==
X-Received: from wmhj19.prod.google.com ([2002:a05:600c:3013:b0:492:463f:2524])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8653:20b0:492:488c:f627 with SMTP id 5b1f17b1804b1-492488cf6c8mr100943345e9.11.1782122509368;
 Mon, 22 Jun 2026 03:01:49 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:33 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-6-31f31367d420@google.com>
Subject: [PATCH v2 06/13] KVM: VMX: Use higher-level allocator
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
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the former allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Assisted-by: Gemini:unknown-version
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b9103de01428e..23ba400b30eec 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2994,7 +2994,7 @@ struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
 	struct page *pages;
 	struct vmcs *vmcs;
 
-	pages = __alloc_pages_node(node, flags, 0);
+	pages = alloc_pages_node(node, flags, 0);
 	if (!pages)
 		return NULL;
 	vmcs = page_address(pages);

-- 
2.54.0

