Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F14D8D9D
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985804; cv=none; b=HKPKHWcIgl8gvTixLs+AGmlykd09x4wLlbDHFIZoMlzfDcgGV9x7H5lnIcMjdNFpSb9xWWPWM7ojtcxUguHhUrSf9ZLUpV9BXglcf0IsHVU1qllemzQwf7X6u6lhKvaxWedAba9XWaX957W8f3wHq9aNXip8Fu183zQ6kr3sw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985804; c=relaxed/simple;
	bh=KNqrD2+2Bt6o9OriZEPOrcJLAbYLOMYUdx5zH9TW50c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9bMAKKDf2f6qYz3DLSmU//GXJrNNV09R5YfUnYAk9Q8b4Ulf/EzdXiLjRDwLOGiWaklqClcMQtXJDMa94JXAUDpYYRlM/hHiZTH7EMVtXp88tes89+7gifMbvJDL5CNIHhELIUJAmxVGnNI9bF3MKdHeLsjgQBAf4Zi+7UP/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UbARwPu/; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UbARwPu/"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-47248bd8bc0so1441628f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985801; x=1783590601; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oi2WdNtyn6OBAE6+L/wDlXe84IAgE1icOUsCwlXzl0o=;
        b=UbARwPu/0R62CEobB3no3EYKzY3u+lBP6pM5zNEZcqwRzelVZnqh8mPuk61fHs0TcE
         jfzOGde2l9iKomAeKWq2utapMfiV8bqwUFs0vE9PzmY+HOmrkxF7u+LAXPQOT4r50vvW
         i4ASesdJj7ap9NMTCsD1P7ob3yDmbiMw5qLTzj9yQHUO10P5NYOa9296JuwD28hqD1Ey
         Z7TroHgbc696KryPNB2WUVnDlIRQdm0M6EpHs/jNeh1cC/8shK6Y+VAFWKjImBppEtGo
         s4Cr+ihUl9snotElUUMM4wESEcqGy5OWh151taJbBXj01XQ4g0s6iq/6rPos9La69n/e
         mDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985801; x=1783590601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oi2WdNtyn6OBAE6+L/wDlXe84IAgE1icOUsCwlXzl0o=;
        b=DxFEjU5F8GISOU1ZP/VwwhqO++/kK8tHIrLpqZCN1SFIzlRF7gJ9VA7Irgvf8ibD4T
         /Kq1367RKfpFdHJLsP/SuIFae57A0gjDa2KwbK6jLggJHc4kRZPZKdVvbHg5rhuqFYRZ
         WNYQ0JRODLCYlSwFzECU/1LlARxR+EFcI2VR1/4kxNUUKcDjH8TG7aoEc8juLBFMQTpP
         vNC5y5i4/dr++uiH3GF/F6VHpYwmRr0+Sd0W5enRyY55EmqvAAqAI4uvax76rl8vx+V0
         OwbE9iwHPX9XtwBw55cAMmRvkgPuwkmfgQvyjoEKLoOaCbhFSmEKQK+hJdvAXNUWDZP+
         KF/g==
X-Forwarded-Encrypted: i=1; AHgh+RpfDsfjSE3Vg2RsigzEM59zPMohOFlshEaxKalns1PeXNPqXuEzm6+/6qWYac1uV2YOBF6sGxqaBJoIMC0k6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFKbJTEL6ml95c9O1EA+cP9v+rABJTFMCD5vXzMUPnoxiqOMDl
	L3doF/tXSlrnIwgkUSE7EcOsNjHxdzSqb321w46mdtQ6rChb1ab4mJz2LwYjeS97JaeTXtZYMBh
	ztHHGBib1NpJSPA==
X-Received: from wrry9.prod.google.com ([2002:adf:fa49:0:b0:470:9980:87b1])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:fe8a:0:b0:475:f0d1:eb5e with SMTP id ffacd0b85a97d-477b206b4bcmr5224333f8f.57.1782985800390;
 Thu, 02 Jul 2026 02:50:00 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:42 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-11-0af8ff387e80@google.com>
Subject: [PATCH v4 11/18] sgi-xp: Use higher-level allocator API
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
	Yosry Ahmed <yosry@kernel.org>, Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Acked-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 drivers/misc/sgi-xp/xpc_uv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
index 772c787268932..79c2f00ed4d70 100644
--- a/drivers/misc/sgi-xp/xpc_uv.c
+++ b/drivers/misc/sgi-xp/xpc_uv.c
@@ -170,9 +170,8 @@ xpc_create_gru_mq_uv(unsigned int mq_size, int cpu, char *irq_name,
 	mq->mmr_blade = uv_cpu_to_blade_id(cpu);
 
 	nid = cpu_to_node(cpu);
-	page = __alloc_pages_node(nid,
-				      GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
-				      pg_order);
+	page = alloc_pages_node(nid, GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
+				pg_order);
 	if (page == NULL) {
 		dev_err(xpc_part, "xpc_create_gru_mq_uv() failed to alloc %d "
 			"bytes of memory on nid=%d for GRU mq\n", mq_size, nid);

-- 
2.54.0

