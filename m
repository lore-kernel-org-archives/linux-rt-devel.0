Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD441168D
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738751; cv=none; b=TS9bDc9z7q7bPXJedLge9hEQR+6f/tE5d02sSBQxxKx+djKDYStILIslS3s/5mpPZCxl43Vhzk6LmZ2ahzcXwJhAtyeyCPhEhWYNePE34qbJDm22fHCUzi+Gfzuc6g5ZLuqQ14TWn3MQW4uPFG9dHI4NGHUDoVyhBnSkB2tiqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738751; c=relaxed/simple;
	bh=hjyh8xXLpdU2ZlkvJiR4R+e+E3s6IerPWwVa/DPBhKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5EmMAkWvJiZiqB7SFigVgLxmFCzYo+2dPwQN0kyh9BaZoyWTumv7JX4mfYdYAfLGNQ91q0N97HwzM1Z9YEF6nja1Hu6j2eRZZzmDKJTZO3YdiJ7lkNBYeMq+aeGpkHJzwvTxHFAowJvN00mvLmjRNDmxu5N/u2rKBijVEvn4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B7fSRyrJ; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7fSRyrJ"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-697e82fe603so3594178a12.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738747; x=1783343547; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IRysh5TqTjmsvBmEr1NgaWZsZT3eifgrzLdKx/xP5Q=;
        b=B7fSRyrJvBx4xgYWedPZt9IoDH72WCimEijITgC8qBFh92ICTG/0+FRn9suF8VLHPH
         7QaibXQl7AJ7WhlWg6RMZrrR+cxg0Q3gaVv46eDRGIrbnLzIdg4tm6rLf1Y0fUG9kpxr
         RwmsIMJAtg5Bg6gEKHieKMzQYa+Oxm9sO0ZiJAdszR57iI9mAoL+J6FsaYvZoAuytZZn
         iFKQg8/Jb96PuISgYP9alDBCYek7cF2KO4J6g0SdAPAEMTFIDyCwUHJ8Itx3S51/9611
         DVZzQpXhAVZYA41n91vhNtn/M/x6U0tq6ZTxT8md58g8Qmr5H0ryjO4joGUm2wE3CxvL
         YrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738747; x=1783343547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IRysh5TqTjmsvBmEr1NgaWZsZT3eifgrzLdKx/xP5Q=;
        b=PEotjLotsmatGLhx/RlleTj98UHePp2kfAA272ouI4iaFMS6fOazZfEIZz4cO4YRPy
         9YBoc7vWyVSLS5AiU8abTqJI6+NFuntA0Mi1ryjbyNt2TwthsIuGWl+kbhd+zk5lsjpf
         DONFWymDDmtB5GFWlbz1mwo+VF62KaBwty/kLfw35aCN+EK4Ofa/qy1nRNxLa0yS8E1j
         HzyAOuZBLe0+R7J/PKDlpsWU1BgYnpkT6aWhzXCQbUlQa9YBW37nkGSbFIXduSsOpJEJ
         FmaJ9pZ7YDPA2wNxtXVI1Bxao3xmpLzsWZZ+QVlm+1shiAOiWtdPaJ7aPIk6GX6ZZnSe
         QmGw==
X-Forwarded-Encrypted: i=1; AHgh+RrGaDTZgGOXHCFAOj7Y349qeY5XBu7m9MqO3mw3JB3/9QlvoUEftatlEYPobqzHRYcMl8c06g9bQ1+zj7WGDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIf+wCDOz/EQT1axC8a29PKpCsCXuDURdhXIwYddTCaB0MksF9
	0pNhi7nUIxCSnzwwnq8b4JyP1fiulBGtHoo4dEsikc2qSLIXUd3Q7P2IWeD6enfggZE8xs5A6C3
	t+3aCtZoiTyi5qg==
X-Received: from edxu16.prod.google.com ([2002:a05:6402:650:b0:697:cdd6:b90d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5511:b0:698:3365:f950 with SMTP id 4fb4d7f45d1cf-69836552666mr4278172a12.21.1782738747073;
 Mon, 29 Jun 2026 06:12:27 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:58 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-9-57bef0eadbc2@google.com>
Subject: [PATCH v3 09/16] KVM: VMX: Use higher-level allocator API
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
	Brendan Jackman <jackmanb@google.com>, Sean Christopherson <seanjc@google.com>, 
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

