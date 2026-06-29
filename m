Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38404192E8
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738753; cv=none; b=G8yaGTMW2gltB5YdPwDa+YCM2+urv2mwBk2hVxYWYJWH6RbJhcyYaxFDs2oOFSxae7uaRD6p21X3/Yv3Yc4ayuFojQRwFKkpeXjFo5JjJ/mtlBF8odemPMRSDEHOBS+fFvtGYUD+wVtkZdqirOtuvdhLu2zL2GpsU3eoAfDnQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738753; c=relaxed/simple;
	bh=pnBmofQRrfYv+qNnpSTHfKk8BiTmntsXm3NYEz5+kXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m12KTi5FY3x7LIoH5+f27/GVfKX/c6r5FdG3kvuWMY5Q1Jbm3y0NgNOmQU7AFZbbC+hHkauzfu6VIvN11BEngsJETYPBFUCobKUgIwfnXPoZ0qFnjaNN4lIGPPoWUmGAMFn0AWNKjrSKVJJ7m2WMhyZgYB/8tcNSAqSRcK8IPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEwNm39p; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEwNm39p"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493a6135742so16824135e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738750; x=1783343550; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ktspLxRUJ1OyNjPH+J45KSRAMXmzhCyrQ93WTpQoNK0=;
        b=EEwNm39pvCoE9BuqnuEmiAOGV30hCd7NQ/aBhtJjB6wAm80+qO/zRBJNSLKzKDoKFn
         Slmva18FdeVDd1GhYouSCE156beMkGf4wrqwplv4BlQzN0YyIZ5wq9YqiBX9khyn97mX
         IaSrtRwR60dUmX7b5J6Gl67+MLTnq3Uf6HrKoS+5dSw3UAOwOQ9B4ZWOuGq9Qad9nPnb
         k1LoQM3cnJUEOOQ+Deg+SwUeQ8BsP+pnzfepxUn2RsdacPqPmG9ZsXsiULuFHfrVSBuS
         DQimWRt4ioorNarcevJFu5BHCbi38dxw8K90j4W3SzF+fFoBEeZob5802+Y7unkbEdrx
         1tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738750; x=1783343550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktspLxRUJ1OyNjPH+J45KSRAMXmzhCyrQ93WTpQoNK0=;
        b=N83f9Jec4F5F6lrpOMUTnY4K6laqbm7CY1vLBr/nhpENSF//aW7r3jtYrXmI6bKaub
         VG6ZpeS6CwEq0xYpRM0Vm/KZJONl4l2DJIleglgfuGuaC+uFZjtDkNsSPT7XJ0/9F8bB
         UpsmtQUAYJQn6VKZChi6UtsMiK59Iffy7RO7D9D44WSQoLwytCXmHneLgc/VlAa6DX2V
         0E5DV6HFiq5orMbdrLdUums9P5z/C1LYIV+GWS7B5yC0O/wL5KGvE0oYm+4sCh3XDbpu
         lURwmV2dM4quZprj92xn5owu9wjId2jhYOiCMZfCMSai5mWOxgHq+vxLEuT1SzqdGwQZ
         zl/w==
X-Forwarded-Encrypted: i=1; AFNElJ8qiKRjJK4flPQT+xb5MyO8C5QV5Ck0pp3gSCnVKiIMth0Ix6SYMtb40+DGugbmmbXruP+iQBVOGyPB4nOMsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZhb6oSFn9zYl4DiP/71/YSUhWIvhRi2k0pEyfgoDeQwYpyvQF
	WyIYt0eiUGuhoGf3TULWN9klr8pjdvHxUiBmQN1Q2/Ycga5Dq8WG7J8NTDiFXe1DmQHPWvazTNN
	MNPLlHsYOcAr5XQ==
X-Received: from wmbfp21.prod.google.com ([2002:a05:600c:6995:b0:493:b734:b4b0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6296:b0:493:a435:d870 with SMTP id 5b1f17b1804b1-493a435dab7mr98425595e9.27.1782738749960;
 Mon, 29 Jun 2026 06:12:29 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:12:00 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-11-57bef0eadbc2@google.com>
Subject: [PATCH v3 11/16] sgi-xp: Use higher-level allocator API
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
	Brendan Jackman <jackmanb@google.com>, Robin Holt <robinmholt@gmail.com>, 
	Steve Wahl <steve.wahl@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the latter allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

No functional change intended.

Cc: Robin Holt <robinmholt@gmail.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Assisted-by: Gemini:unknown-model
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
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

