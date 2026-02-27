Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A93563E9;
	Fri, 27 Feb 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212085; cv=none; b=rXzwUT8LG+bFeDDiGcskdvm/+xRLHsN8LlsffaSxzshSvyAZojghjkXR7rgEsp/GsBsPrM+8Q5StYT4el5mC6NmSsxQPYGW7E9xiLe3cAaY07dL2FivbnLuPhgNS8Z9wa4ly/AC5CttLv5hg9OPlM/3slukysEVUxpTOMq6wHnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212085; c=relaxed/simple;
	bh=/+yB8Djtw/lq3sI9CY947SUdtQdHlwAvGnUS3Q5Fw8o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GXfbUTzObXS9rVLu/ETgaPv/CQUetPPh4TnVpk8dj4W3lCKwo5cduN+8EEWpxE0nV2F9gTcobEky61bL3wjqV6piAA6977WVeUw0sVd1gEPSuomc/L1SxVYv2THidUDFIsmWDA0bEAMu6azKfskWLu+UXyv0YhwiPFPT6nyyMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k93XZGV7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k93XZGV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45BCC116C6;
	Fri, 27 Feb 2026 17:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772212084;
	bh=/+yB8Djtw/lq3sI9CY947SUdtQdHlwAvGnUS3Q5Fw8o=;
	h=From:Subject:Date:To:Cc:From;
	b=k93XZGV7zY6JC24pbTErv93DzIA4A0OqaLX5Og3OBF1nqrUHd1ci7tJ7L41Bk9t7G
	 iMMZXwuiSMCwanZddglbkb2abKB3V/5lDZsp06Nv8wzCI1Zlr82g5ppi+0y3XyhTiA
	 IPTF3OP4xFUeve49tNfS4dLggqIVNmebQ+ZfGP8Cdl48dQXckMmvm/mv84BWWk9Lli
	 So7d8TNym5GEUe0PqHF3DZZ3+XNVKPFfRCOqVlrOLzPaFfhxk3q2CLte2qwNOWr8WR
	 DRCHIRwdUvManMTSczc6r+aiLT50nhRq7B1SSranPZhVhUOs0iox7wQR4i0FLz0HQc
	 gj0+o2PHex8ow==
From: Vlastimil Babka <vbabka@kernel.org>
Subject: [PATCH 0/3] mm/page_alloc: pcp locking cleanup
Date: Fri, 27 Feb 2026 18:07:57 +0100
Message-Id: <20260227-b4-pcp-locking-cleanup-v1-0-f7e22e603447@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG3PoWkC/x3MQQqAIBBA0avErBuwoRK6SrQwHWsoTJQiiO6et
 HyL/x/InIQzDNUDiS/JcoSCpq7AriYsjOKKgRT1ikjj3GK0EffDbhIWtDubcEactSHXeU9sHJQ
 4JvZy/+Nxet8PtD2+OWgAAAA=
X-Change-ID: 20260227-b4-pcp-locking-cleanup-b7a2d5ff2ead
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, 
 Matthew Wilcox <willy@infradead.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.14.3

This is a followup to the hotfix 038a102535eb ("mm/page_alloc: prevent
pcp corruption with SMP=n"), to simplify the code and deal with the
original issue properly. The previous RFC attempt [1] argued for
changing the UP spinlock implementation, which was discouraged, but
thanks to David's off-list suggestion, we can achieve the goal without
changing the spinlock implementation.

The main change in Patch 1 relies on the fact that on UP we don't need
the pcp lists for scalability, so just make them always bypassed during
alloc/free by making the pcp trylock an unconditional failure.

The various drain paths that use pcp_spin_lock_maybe_irqsave() continue
to exist but will never do any work in practice. In Patch 2 we can again
remove the irq saving from them that commit 038a102535eb added.

Besides simpler code with all the ugly UP_flags removed, we get less
bloat with CONFIG_SMP=n for mm/page_alloc.o as a result:

add/remove: 25/28 grow/shrink: 4/5 up/down: 2105/-6665 (-4560)
Function                                     old     new   delta
get_page_from_freelist                      5689    7248   +1559
free_unref_folios                           2006    2324    +318
make_alloc_exact                             270     286     +16
__zone_watermark_ok                          306     322     +16
drain_pages_zone.isra                        119     109     -10
decay_pcp_high                               181     149     -32
setup_pcp_cacheinfo                          193     147     -46
__free_frozen_pages                         1339    1089    -250
alloc_pages_bulk_noprof                     1054     419    -635
free_frozen_page_commit                      907       -    -907
try_to_claim_block                          1975       -   -1975
__rmqueue_pcplist                           2614       -   -2614
Total: Before=54624, After=50064, chg -8.35%

[1] https://lore.kernel.org/all/d762c46b-36f0-471a-b5b4-23c8cf5628ae@suse.cz/

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Vlastimil Babka (3):
      mm/page_alloc: effectively disable pcp with CONFIG_SMP=n
      mm/page_alloc: remove IRQ saving/restoring from pcp locking
      mm/page_alloc: remove pcpu_spin_* wrappers

 mm/page_alloc.c | 146 ++++++++++++++++++++------------------------------------
 1 file changed, 51 insertions(+), 95 deletions(-)
---
base-commit: 8982358e1c87e3e1dc0aad37f4f93efe9c1cfe03
change-id: 20260227-b4-pcp-locking-cleanup-b7a2d5ff2ead

Best regards,
-- 
Vlastimil Babka (SUSE) <vbabka@kernel.org>

