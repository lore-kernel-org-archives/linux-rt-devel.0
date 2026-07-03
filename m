Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671583D333D
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081959; cv=none; b=RTD28ZYaF1bfQtBo5FT7lRexoaH0MRv6ek15VcV3NOrinEd7tqqbK0vi3OoH1CY6F2LILJvHoeflhBff9AVINpVeWU3h4oRRIZuaNXIXrn38UsaC4CBL7hTuqXl19bHoC7+dPLYoCcU2WzT8GyyyQX7NcOTnMvGYp2zKQMLEYTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081959; c=relaxed/simple;
	bh=Q3JRniqkyMXg2dBXWW+1anuwJps6VyhynpsJv8q7DjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AkfoA8XPQk6ZFT05SBwWbiVMZrFzZbb5GAgOeK9VyZuvAqwqcNK5eEyk+DhC1jWDChtM2UcGCOlYeaNWOZ/T2UmgTY53PmpC24S1z2IyaOcGk8ENpxq2O0x3f93rhrj+WptM26AkTtjvkDH0Uz64ywOMMY6lbrHxEunn7OTkHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exa9LeQZ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exa9LeQZ"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-492714d002cso4043465e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081951; x=1783686751; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=84+Rn6wYUXeYiLyW3+xzYg/p7pJRku5hcVgAFmLjUag=;
        b=exa9LeQZZqlvPDKJD1FfMrDkjws2u8gZiegIU5omx2aDZQvT+TzLAwtPEjYM9b+ghN
         S949LTcpuJ2vxu36XavZrhmjWDE07DgCA4hXz9zUWPraUcCQ1WW7etMJugMn2oHzsXOz
         ziYQAENAZocY55ezxFEkvfT3vL5WENixGKDgYbPNFXCkKCOP2KPH8mnT1z5OkFl8uUAN
         Qn6Y5val41Zwzs1erGRng7U0LFHuHL4FPb/LJV2euFwOBpwqV8qShehJxyK/6Ix4Y3lT
         Aa/RF8JJ2gzmX3FH+f7dmCaToSGUxZZVLcWYlzU1MQ//Vxsn/OsEL7PbuJodJZaY02Cw
         cLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081951; x=1783686751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84+Rn6wYUXeYiLyW3+xzYg/p7pJRku5hcVgAFmLjUag=;
        b=Xu2nh8Pdgx7nS5ydjEfwwhJPMmN4SEwde+9HOmk/dfdW/oMCId8StOV8ohW/0qI5Pt
         r1omcoSSjEqAZC0afzdo0VxxV3o+wauV3JBh15z0qjad3e582K0E/slsMFdkjeokIqOz
         r6gonZDexLc4/7s3fpkhPW6cGDGq7svF5cJ1U7Ub9mABmlEJ/HDvEpk7wedaKsL57ARD
         W0QD8G6oWigqOnoHejUEMFC81KCtwkY9t/DMLwFhcGjQI371iDkjCw8WYWSQEIRnR14/
         skfnuBNn1VaFl5bR+HPpcH/8pcYk4HNtaKc8oxfdrzViMXY73d3aP8o759fDxayQXF+l
         Px8w==
X-Forwarded-Encrypted: i=1; AFNElJ82KXZSG1Jt9nJUcazRt7/MLKmDcIxE/qn4JtR+eDyyVavWgpKjAA0Ou+Djn5CRnbDjyT9uZcLYYJBZjPh1xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEXUAhzoqDQc+B+XYhdLog1X5lbo9gO/9DWlUdQmzN7TCWGjUa
	tUolTTrlF8ocQ+KrpwiPPI3PK8IpPG9+dN/pskS9S49wyvLb9yx4vwwtl0ing0PJ0FJ1m+VNVOf
	I/gcnpp62vS+nHQ==
X-Received: from wmdp17.prod.google.com ([2002:a05:600c:5d1:b0:490:b2b0:c4aa])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1991:b0:493:bba7:e9f4 with SMTP id 5b1f17b1804b1-493c3cf2d58mr138687005e9.18.1783081950438;
 Fri, 03 Jul 2026 05:32:30 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:49 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-9-c87b714e19d3@google.com>
Subject: [PATCH v5 09/18] KVM: VMX: Use higher-level allocator API
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
	Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the latter allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

No functional change intended.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Assisted-by: Gemini:unknown-version
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2325be57d3d75..ad6a7fc6a54da 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3028,7 +3028,7 @@ struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
 	struct page *pages;
 	struct vmcs *vmcs;
 
-	pages = __alloc_pages_node(node, flags, 0);
+	pages = alloc_pages_node(node, flags, 0);
 	if (!pages)
 		return NULL;
 	vmcs = page_address(pages);

-- 
2.54.0

