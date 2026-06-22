Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9C39EF0A
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122515; cv=none; b=eFR58cBarjXSZf6PB9gp1eOu7bvK8AqILVRJ88ptgnLuUTl7ffWFfj4t0OrzjXpEcHD9c/ZqpqDt/vMJiB1RrFd+fszsKb/5MaT3UwO08BZ/QAg/Dz1kvHJLzJgaUANfk/hL4+swLO69w25w3PSVCVbvpGB4M5McZ4a1/b9DtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122515; c=relaxed/simple;
	bh=fqDDoNx0gA8PaVQ9DiZkZ4IxAQW675N6jb5nQtG5Jfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZ/wch6D41MkL7/SJjUff3iEXwPelncp++RqsTYeeg0tXQi/ZO87X0CVL1Fkm9KuI/oit2rhI0QX2iFJ1ap/ld+pagS3mbr5nSG/cLJ+/+2Sk37JlnUaPHvJ3aJyxVlvrYzl2oCtBSlC4GP0Zfe56ndp6iTajaR6ZD5jB0KUaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWOwQIFg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWOwQIFg"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490b0682d2fso31490715e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122512; x=1782727312; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=anP6XoH/y5KwBW1jK93UnwjV54q17yZa+JENUx+IL4g=;
        b=VWOwQIFgWwOnnTmqvUFo95d1CJgkXQCZ00dtp5R2SzXlMa7nd2dYF4XeWHW5QvuBhq
         NRUovauHvgg0XtqTIFEFEopt5m76mg4BqDxMXpnPByOyb5N2/K01iob9lKeXrSa8wePi
         24aq6BeB8207xxX7S2/Rkq4bV8IuF4cdk09wOQyIQF9LJE71hIUkXCYp3K7xN+FfqYty
         htts33f+Cso0LXfPAaF+6TK7Vuw43NAUIP/nf8wsjgJVgq30aYnwt81muJVgKG+3scd8
         04oE0Viki7j8ukGIebTBCL57XsBvGgsV9s2LruWk6mXLHussTSCIhxifIszJ8avKXFYw
         4X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122512; x=1782727312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anP6XoH/y5KwBW1jK93UnwjV54q17yZa+JENUx+IL4g=;
        b=kgsG2NBQLhA1q2MU5t2bSf0M+8ryXuStXZpFg89CMYTauHQSWvS/PJj091hpB/jl5L
         SElKKrHeTeXvgltGEbGN2Thirlx9uMhJ2h/mnkskZtIQYaXbpmIVATDpDxH7/PjsY+M5
         GacVIYRBs376yWlx24WMuq6wHcVjX2V4Cp8ltGgCYSUY/de97Gf2PImr++nQcdYW2Eqo
         56w2Ez6GZaLSVW1r5GaZm/2On2SP0oGdkV19WzEYPpagv4vvmkwShmlzV81cF1vRCoiI
         zgbZalfDDCfKNvWYZI4fIR6H+xxQT5DV6nwjBIMSCiqN0JbphCSEn4jHcTF9Ot4PoPRJ
         UevA==
X-Forwarded-Encrypted: i=1; AFNElJ+ixLB5pUvzeqryi8L56UOpS33GbLRy7LcSFg41JF5kyiJg+PpK0ReKeiqmMdpVjJWzvpfNoBmuUQUtGEm2GA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzREfGAKpS7Ghk+vCzUM5T1VBRHkQ1KcRMb2HApDkFot2NlWiom
	CcEMyA5AH5ypHnG5I63dE/FzG8m5hvK20HtXZbHfR3edxvsWYOkzV1Uiza1UxaN+uTmVeQs6JcF
	s7X+VXSNJHy8iiw==
X-Received: from wmk16.prod.google.com ([2002:a05:600c:290:b0:490:e9bc:6058])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5020:b0:490:d946:47cf with SMTP id 5b1f17b1804b1-4923ef47d08mr224907005e9.4.1782122512201;
 Mon, 22 Jun 2026 03:01:52 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:35 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-8-31f31367d420@google.com>
Subject: [PATCH v2 08/13] sgi-xp: Use higher-level allocator
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
	Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the former allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

Cc: Robin Holt <robinmholt@gmail.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Assisted-by: Gemini:unknown-model
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 drivers/misc/sgi-xp/xpc_uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
index 772c787268932..aacff70204241 100644
--- a/drivers/misc/sgi-xp/xpc_uv.c
+++ b/drivers/misc/sgi-xp/xpc_uv.c
@@ -170,7 +170,7 @@ xpc_create_gru_mq_uv(unsigned int mq_size, int cpu, char *irq_name,
 	mq->mmr_blade = uv_cpu_to_blade_id(cpu);
 
 	nid = cpu_to_node(cpu);
-	page = __alloc_pages_node(nid,
+	page = alloc_pages_node(nid,
 				      GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
 				      pg_order);
 	if (page == NULL) {

-- 
2.54.0

