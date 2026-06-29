Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E9408623
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738752; cv=none; b=h9Na2lCnwvcNLs5oZ/djJUKeDUA5y6H/0zzVmUKmuSCss1H8OWMkc/CMmLEoONsimmIQmpnlF2USQtqwBuGDiR6C1Cx0jISKtOOl7Iy2dheFaaGWFCAVNrkY/5nCphyNRN/o5iEngGF8msS4bpJsOjkINpLwdEoRT/9oU+PqBjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738752; c=relaxed/simple;
	bh=V2SV5hBAY+QbyfGUIYBviPUk6rVr7WV6JfDjYLCwOGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lMZDTsGjbofgFk5um+MqYwQDPP5rWw/AYlTeuKgeHLoBgd5kKRE8uNMFtewqct2wXOsIOWUHz/jfy7OCCUujjfMHHNLZho4R6SMZJCUoLFi8L9N/m1JtHpPPJKRISlOAVTqOAGMSMP9nqqh5F63XuMhh9eGzSNMYkUjkhiK4e3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lxqQ9AUA; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxqQ9AUA"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-473de38dcfaso551202f8f.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738749; x=1783343549; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ78q8Al9VbD9+7rxBEKZgyEVtSkV4vtK1mqsIB7EjY=;
        b=lxqQ9AUA4XA6TqC6FvX5DdDSGULwgUHKyJ3UXp0n9yuIug0yP4Y2XPU2JtN+Wddp5z
         AgoYnRueYnKTfgaWelElK2uA9mPWnXx+cLqy6qlakq8sOk6BzdHPrZdiOeNgP0WVJkkQ
         oW9Vs2bo9dJSApueCgBHg77lNZse2nfnLlnJL0ko2xSzwkYLhKX2hcuvWPViLMvB6Mjt
         QUsNp6F+54f07HgnWnyEjuAhxNadqYGSpAa076KB4J5l4pgN//RYmSOI3EQVhEdUBv2z
         CgpxoEsWdP3p5MzPUx7wwOT7ghtc1964XwgHI3Qq1d2GyzD6xo6NhZ14ZIjtAQ/fKs/o
         kbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738749; x=1783343549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ78q8Al9VbD9+7rxBEKZgyEVtSkV4vtK1mqsIB7EjY=;
        b=Gr7fzq/pyw+zFLfCTNfORulZYBcGAOD9MNKtZlKsIpvFOb4go5X/ImfoLl50BrP7/L
         OVpubGepr2zr7kuXbqc0eVv+xfW+4T58q7K4vaMQDrDa89BCZoN4+u9qr63atbpujeQ0
         JcIGxC+hdkHnRf/YvxwUW52noEoXSXwAi2dxA+nVhr9yqt7WYzjWg6zFrTkIfmKOH+gx
         eA+GA6UPyoVV+OdgfM6Atq/Z3dzMgfUmYZ7FdIi2yxihBapYA2WrbCi5i4c7iLXccMDP
         ITAUNHLHMURjdkW9tocuX5Q4+Yk/Ro+bY1/M/FKQY17E5wlWIpiN9mvWGY4/b9OchWQG
         Vg6g==
X-Forwarded-Encrypted: i=1; AFNElJ/C2xeuYPnERdZ2UUkQd+mrMDQy9zcunM2WycmWQS5MtMqwpqBpDfv6z91QjFnbvBSRH1qKPirR/ZjquZhJ6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yys9Gy4Rr4wfm4L6lLawlbEpiV6SrDMPcX+ssiSzGyxVmHGjGzt
	RX2D8p+qOdecNcb6jqYU9lpLtj1BlaDziG4VQmhC4QU78Tl8CmtkDW0bOJihd3nhBDycmrVF0Mx
	fxQ/MwSfOknsosw==
X-Received: from wmbdy18.prod.google.com ([2002:a05:600c:6592:b0:490:5e18:ff1c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:6409:10b0:490:ce99:d2ee with SMTP id 5b1f17b1804b1-4926fc43078mr145672575e9.15.1782738748573;
 Mon, 29 Jun 2026 06:12:28 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:59 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-10-57bef0eadbc2@google.com>
Subject: [PATCH v3 10/16] x86/virt: Use higher-level allocator API
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
	Brendan Jackman <jackmanb@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
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

