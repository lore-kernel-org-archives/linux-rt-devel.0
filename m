Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331C4D2EEF
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985801; cv=none; b=LnNorlX7r61qYe58z5MemkKRX3Ewur6xpcjJjZMTxwiiZjWmqQNO5Kl9jWWu5CK/pORCHxB0BWaFfMwwLcA16+UQ05qLTXKGPdgAg97n0C3b84yBc/SB0L9xBbUcqFD3bUoiKci0joLYlx79tOFYz7q/Jh+/VzT3bJAet0GUSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985801; c=relaxed/simple;
	bh=Q3JRniqkyMXg2dBXWW+1anuwJps6VyhynpsJv8q7DjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DspvO9RBLE6pq1PJEKIDBB3+RBn0uRrBZ0NjhMbR/YO7lD7qtKJVNA2369daR180A1ldMI61mGlAvWQuTFDYUZteh9mAxFzi5Dl5jUfjsj4pYFApuAWI2KOMOqJphbDktn3DKhgwJI3W2n/v4i7xVhr4ArX70OW9T/Y0P1nMUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RX1vbcTo; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RX1vbcTo"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-47248bd8bc0so1441596f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985798; x=1783590598; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=84+Rn6wYUXeYiLyW3+xzYg/p7pJRku5hcVgAFmLjUag=;
        b=RX1vbcToi9fu2IbwO9+kyGEUw2UlWleB20061jgi05oA4FI3UzwxjhfDHa/aeYLIf7
         HqLz0MrjSr2dLR4qPX9WyJIEDJTIfcS4bA49pRYWFbwJzPlKpjgw7CLYrNZBWt8CtZKj
         ZBHdQGsLlyAFE4tbBgQ6PmQ73L2vsK21Qlqn+TYlUJe+gBcXDb1v9gdum4Auz+hTToXo
         tcWbd992SHG9ejpmwz1Sm3TYqJg6h3JUJIqvMpxNLCQ5J8Na2wlZbhmilHa0o0QeM8Bs
         7wgr/bN0OqPVCa7+YkPfIx8gT+WZa+UPe29v1r5p4gPuEhMZYJTVb350jKcO5bOF17ww
         a9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985798; x=1783590598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84+Rn6wYUXeYiLyW3+xzYg/p7pJRku5hcVgAFmLjUag=;
        b=pq20I60GA5JZboxd4APh1vbZ/6V3mRT8CNPXKg8uRj9GebhXw90dJsedrOFyCttilf
         xpf6jIGpxJh6ca/4+1m2U2USMaEJz8zu33rvW9fscYA+3dWDlXjzVTwHSmDir83ci2WI
         XF3JwmEgsh9GVgA/OoLHfK6X6kAFby9XDEG1aLgV9SWvDVb0RJQVnpMIqT1raaLcQBiU
         s2Evl+EEqL3DPnNBCn8VKxJhC9EcjDOm9LFEDENwO9UVN6jubUuhK4XwQtC5M6BkKjs+
         7VsZw1DE3KnDUR1hjduFF+0OHSiT0EEopSDObzz0tZdfoUw/ROzMNTjzgJXqcxUP9FIt
         kd0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpDTJdi0xib+n5x6vRhaw6vX7YG7nyEeMP8JRhknkrcKWZZn+Bxjj0wQpA4zWIbuM5X1VZQIZms+R/bMRSu2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR1PFCOs9h3EnGn9aU9qcJJWkYb3VGRkNkndh1b4AOkCK3AbWc
	d9fmY/kMQ25pdgySgSFql4h58J6nbucijaqj3LiniGam2t17IW3VeDx7xWvMCYdkak2vIKasu03
	rzi1Z6Nrfz7ywng==
X-Received: from wrbcg15.prod.google.com ([2002:a5d:5ccf:0:b0:46d:32b0:5fa4])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:420e:b0:473:c18:f2cb with SMTP id ffacd0b85a97d-477af4f8f3dmr6971262f8f.18.1782985797975;
 Thu, 02 Jul 2026 02:49:57 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:40 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-9-0af8ff387e80@google.com>
Subject: [PATCH v4 09/18] KVM: VMX: Use higher-level allocator API
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

