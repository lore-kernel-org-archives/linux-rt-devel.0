Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE252433E63
	for <linux-rt-devel@lists.linux.dev>; Tue, 14 Jul 2026 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073419; cv=none; b=URCybwpU3dLardJtfKISTkZ0MBI4mAP/aEep3MDgo5T7Ud2q6JgN0MkFQgmXq2mnBz3verv6by1a4tW0uBqM6C3L/yzxXDb1Ev1Likvis2IfV9VyVTyoyUGt/VWECodDcmXFAzlQOQBIhtKR58Wh9ebj450cqSnObUtOwkXuX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073419; c=relaxed/simple;
	bh=dGBZVspwzFI5l4pbtU1w5Mq4eYNTTQlm132+z5enHtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dOZUzGR8Z2eWXm/vuksHSSMRalRopBu3GdwpvQqiNvHG7oNvM/EBcD6pbH2jlFyirDwLhIJ51BJ4mykvEQDAkNmrk5AyadQt5FGbTmY6nJu7bLIIsL3NOjTBCb28h6lGE6z05IGHCuDvJzeb1lzJGWEgypRFbgfG5urJuDSaYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqygdVPI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqygdVPI"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8487eb67173so7643236b3a.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 14 Jul 2026 16:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784073417; x=1784678217; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbJLIL9gmItiz88QD6tsHYBCJRJFmibBVJcjTpkBGpU=;
        b=FqygdVPIWYkwZDOcReeoK8bXPqgoVWsR+8XmxpLZpjOFdglXQpVkJXFq+lRW/ThvMP
         ksPIi+vvdrICpyDNvgFhJpr+9v6DmtzXpZvyBMXsV2FTmmjme4OnIo76Jp8mrdOUrERU
         i4YGIj68zY9LxL2J07dPSlHyXMSrr8ucRF6xR2y7tlmJ+NOXcs9JTWJfKib5uiBR5IDr
         S8TE+Mu6SiHzMD00v/IXtIzUdRJvFYgRPyo8PZKFfN+ffxp3PqLoY8z8f7fSA5dI05gp
         m6YK1u4KG9ToKhmly8G0cAfAAwCM+WPAPDKdusLXmAwD2EHEpASkpsRlqRmlRPksRFl9
         Sjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073417; x=1784678217;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VbJLIL9gmItiz88QD6tsHYBCJRJFmibBVJcjTpkBGpU=;
        b=kFNVxC3Sqj5ygX6KDavnqj/2ap61vA8UjOje9BaMAFV9aAfugz+30gNCLrwiH5dRkB
         DKcyLOLhcgjKainR0o2f+0Pgsd0Nqh+c1A373h1Zaq0EswvbJAawGavY994z1VDMpZ6J
         Nv/ocAIl3f2Uf6RwkC/OwOi3PR6EaMcjmmBf2/JSGQkCpISYg3wsqsKblw/QDad251lU
         uv8k3dFPhNqVxPpZACcTdo+xRqgaQBHlOfDLYSBNoDAvbOobEAxZUttXQ5G7dBHWT15H
         FbbchgdztbX/0aC3VBSMUDjf+VWg5R+UUYU8bz3oXJgIZqvjnIgRJp4peHGLVyUBp+86
         9tfw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+TLgFgplZbWoEtmIqKCAi25mqgqGSVyhrjR2DhK20idSlFuUceEobQIR5/sMnvlL/SPsw+ETCjIv0HvCTCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyquKbrBywSsoCahJIEPVovQjSA017xUh3O0wCebkc9SUARWQ3M
	GX8u6w1wmaC2TmmuB42ErRcQ/SDNj+TmX7noZf4u30Y+Lo4GjGRRH5ZyDFGyIzR8C5WSIvzfb0u
	IIrNnkQ==
X-Received: from pfbim8.prod.google.com ([2002:a05:6a00:8d88:b0:847:93d8:2813])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e27:b0:848:87f0:ffab
 with SMTP id d2e1a72fcca58-84a5167760fmr5156585b3a.78.1784073416921; Tue, 14
 Jul 2026 16:56:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:56:56 -0700
In-Reply-To: <20260703-alloc-trylock-v5-9-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com> <20260703-alloc-trylock-v5-9-c87b714e19d3@google.com>
Message-ID: <albMyH4scTHvEM0C@google.com>
Subject: Re: [PATCH v5 09/18] KVM: VMX: Use higher-level allocator API
From: Sean Christopherson <seanjc@google.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
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
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, derkling@google.com, reijiw@google.com, 
	Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 03, 2026, Brendan Jackman wrote:
> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the latter allows you to pass NUMA_NO_NODE.
> 
> The former is going away and the latter works fine here so switch over.
> 
> No functional change intended.
> 
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Assisted-by: Gemini:unknown-version
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

Feel free to take this through mm/, I can't imagine this will conflict with
anything going through the KVM tree.  Or, holler at me if you want me to take
this through KVM x86.
