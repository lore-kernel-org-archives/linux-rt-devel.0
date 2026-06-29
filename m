Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A03A7F5D
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738736; cv=none; b=Y8Vj2WNBsgEaYHX54CtVpg9yeWAYf1g7fQP4fVetkycI+incLtq1FqKXXAkRrpbJUXYaKURllcDHt2ssmUhm8JPIvHTRFLlAn3X4RKzgIdZMXTAnHyotw6kmTauUnH3Vm/QiX3YXsnbIE3jJmpFiPUIyBEyPyKUS/sYMpkrvIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738736; c=relaxed/simple;
	bh=yl8UJzfw94+RluOWLSRe+6uSxW0yCUn50ynO2wSJYLk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gFvpEennPD6mkEU0aHhptSId5MXqYU8sdn96oc4AftJF8sAPq1nLqev+PGCYKFFy7wB+UgDQuZSaXIC8aDXiXPqLp/+KTjAfWj2zjpfedB0mw/XZ2BhQ2tq603LTPJW8YCPew26xbHSfc0w/sP04GR4FJJlv+WQc4GmBY/rMYfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmnU1HCb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmnU1HCb"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-492488f8583so35357115e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738733; x=1783343533; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+OGVCu9PX8rESc8mve/w/hG+ePzfafqERhXCKmxfjYg=;
        b=pmnU1HCbN10G+J506A1G389OxtwSwDYtkDmHpjgW+13E37eoYnaYhSESYMc1v+Zb5Y
         SW104mlUpV1XiEbx2gOglgIQAPNLJGlgZy9XmPf53P6+IZZtXaigP8F58Dd2Ws6frotP
         o+7nJQ8xkTPcqFYvsHsBkSyGX0KFYa06q4a70XEr8K44135NVUCRrindv5O0iT46MDZf
         j86AV/1B7H9laksEWmwrudlZeo6P6pM9GK1YFDVDlKr2EvGBLa53omyuJbJ3x4lwQhIo
         WeVD6dE1iJkkmdYdTDZuMQaUoTPgkgwTQt9zy/c3JlL9tjNJ6xSeqAdl+00TkLNs7xAA
         PZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738733; x=1783343533;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OGVCu9PX8rESc8mve/w/hG+ePzfafqERhXCKmxfjYg=;
        b=aOcKK4FwS0PvSCY4r0gGaMxp5juA0OIyisdfgj/bzd8k2lSNYWM6P6QCWTHz9u6MfU
         weMVn0AiX6Nlrf1PXNDS8hp9mFWhMBJTlDZmdfyQe8G+zEQX7Kw+NpDdsxC8A+IQL28y
         IKzsDFjh2RikFIEO1JhHJ43j2aoqIP0BbWm1ooNEPJzTtxlhVUWBZEx4UIpiR903HljP
         PYj4SjPERJSC3mwmCcJgr0grHVXNhS1qeobvFMTKQrHyBw4wHghfMhw8jEIsE0KMs4sn
         JlbLo+znEzUxWM7Rir1DFieaq4aSoFayRQcjJqXBWSqHTenjnpGryAlydv0Ux5xKPL4q
         LDxg==
X-Forwarded-Encrypted: i=1; AFNElJ82dAErXEqzqvno4WTpMaCSSKexACrqX6E00zaHSCPvz8ZoWOmvEr17fqPYfP7wZ0oMi72ajUrRIgSfiV20KQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9jetaQ06p6GHZeDFpJqqMB4NZKaDA9/JztEE7eZDrt0uy+AHJ
	wZfFmntIPyZXZZ8TZVXY0MzUmEQqX19/decHLsFEcmdpJpIVQOmZxTkhpn3P3I4VpDX161ppeh2
	GPj3LWF+cdfoYzA==
X-Received: from wmbjx16.prod.google.com ([2002:a05:600c:5790:b0:492:2b56:8534])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6218:b0:492:700b:deea with SMTP id 5b1f17b1804b1-493b71a21c5mr11624665e9.13.1782738732542;
 Mon, 29 Jun 2026 06:12:12 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:49 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABZvQmoC/3WNQQ7CIBBFr2JYOwaYWhpX3sO4oEBbtBYDldg0v
 btQN2riavKS/97MJBhvTSCHzUy8iTZYNyTA7YaoTg6tAasTE055SUsmQPa9UzD6KZ0rsEJqFFr
 WiIIk5+5NY59r73R+c3jUF6PGHMmLzobR+Wl9GFne/WtHBgwqbLSo9lWF3Bxb59re7JS7kRyP/ EPn/FfnQAFZgwxLoQtOv/RlWV622qbA/AAAAA==
X-Change-Id: 20260617-alloc-trylock-14ad37dab337
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Subject: [PATCH v3 00/16] mm: Some cleanups for page allocator APIs
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
	Brendan Jackman <jackmanb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dimitris Michailidis <dmichail@fungible.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="utf-8"

This is based on mm-new, it depends on moving alloc_tag to mm/ [0].

[0] https://lore.kernel.org/all/aj5QBtJcphPElczI@lucifer/

Some tweaks and cleanups for page allocator entrypoint and flags. This
is motivated by preparation for __GFP_UNMAPPED [1] (which will probably
become ALLOC_UNMAPPED in its next iteration), but all this is supposed
to be an improvement to the codebase in its own right: unifying code
paths, reducing API surface, and removing GFP flags.

[1] https://lore.kernel.org/all/20260320-page_alloc-unmapped-v2-0-28bf1bd54f41@google.com/

This started with unifying  __alloc_frozen_pages[_nolock]_noprof() and
expanded from there.

Unifying the nolock allocator entrypoint with the normal allocator
entrypoint means adding an alloc_flags argument to the later (only
exposed within mm/). This presents an opportunity to take advantage of
that arg to remove some GFP flags, if we add that alloc_flags arg a bit
more broadly to allocator entrypoints.

To distinguish between mm-internal and "public" allocator entrypoints,
it makes sense to use the __ prefix. There are already some public APIs
with that prefix. For *alloc_pages*, just removing those variants seems
like a nice cleanup anyway, so do that. For get_free_pages, the "__"
variant is the _only_ variant and it's very widely used, so it doesn't
seem worthwhile to modify that. Therefore, scope this "__" change
specifically to the *alloc_pages* API, which means we leave the
*folio_alloc* API untouched too, even though that could probably be
cleaned up if so desired.

Tested:

- KVM, mm, and BPF selftests in a QEMU VM

- kunit.py on x86_64

- For the ALLOC_NO_CODETAG bits I just booted a VM and read
  /proc/allocinfo. I confirmed that if I remove ALLOC_NO_CODETAG, the
  kernel crashes in early boot, so I was at least booting code that
  depends on this logic.

I used Google's internal version of Antigravity (AI coding harness) to
do the repetitive bits, those commits are marked with Assisted-by, the
rest is manual.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v3:
- Created mm/page_alloc.h
- Fixed EXPORT_SYMBOL() issues
- Reworded commit messages per Sashiko's pointers
- Dropped rename of alloc_flags arg in prepare_alloc_pages() (Suren)
- Renamed gfp_to_alloc_flags_nonblocking() too after rebasing onto:
  https://lore.kernel.org/all/20260623004600.113347-1-jp.kobryn@linux.dev/
- Link to v2: https://patch.msgid.link/20260622-alloc-trylock-v2-0-31f31367d420@google.com

Changes in v2:
- Fixed up whitespace in nolock unification patch
- Introduced ALLOC_DEFAULT to replace literal 0 for alloc_flags
- All other patches are new
- Link to v1: https://patch.msgid.link/20260617-alloc-trylock-v1-1-83fd7858832e@google.com

---
Brendan Jackman (16):
      mm/page_alloc: rename ALLOC_TRYLOCK -> ALLOC_NOLOCK
      mm/page_alloc: some renames to clarify alloc_flags scopes
      mm: name some args in a function declaration
      mm: Split out internal page_alloc.h
      mm/page_alloc: unify __alloc_frozen_pages[_nolock]_noprof()
      mm/page_alloc: relax GFP WARN in nolock allocs
      mm: move some stuff to mm/page_alloc.h
      perf/x86/intel: Use higher-level allocator API
      KVM: VMX: Use higher-level allocator API
      x86/virt: Use higher-level allocator API
      sgi-xp: Use higher-level allocator API
      net/funeth: Switch to higher-level allocator API
      mm: Remove __alloc_pages_node()
      mm: Move __alloc_pages() to mm/page_alloc.h
      mm: replace __GFP_NO_CODETAG with ALLOC_NO_CODETAG
      mm: remove the __GFP_NO_OBJ_EXT flag

 Documentation/admin-guide/cgroup-v1/cpusets.rst  |   2 +-
 Documentation/admin-guide/mm/transhuge.rst       |   2 +-
 MAINTAINERS                                      |   1 +
 arch/x86/events/intel/ds.c                       |   6 +-
 arch/x86/kvm/vmx/vmx.c                           |   2 +-
 arch/x86/virt/hw.c                               |   2 +-
 drivers/misc/sgi-xp/xpc_uv.c                     |   2 +-
 drivers/net/ethernet/fungible/funeth/funeth_rx.c |   2 +-
 include/linux/gfp.h                              |  54 +---
 mm/alloc_tag.c                                   |  22 +-
 mm/compaction.c                                  |   5 +-
 mm/hugetlb.c                                     |   4 +-
 mm/internal.h                                    | 253 ------------------
 mm/khugepaged.c                                  |   1 +
 mm/memory-failure.c                              |   1 +
 mm/memory_hotplug.c                              |   1 +
 mm/mempolicy.c                                   |  11 +-
 mm/mm_init.c                                     |   1 +
 mm/page_alloc.c                                  | 259 ++++++++++---------
 mm/page_alloc.h                                  | 316 +++++++++++++++++++++++
 mm/page_frag_cache.c                             |   6 +-
 mm/page_isolation.c                              |   1 +
 mm/page_owner.c                                  |   2 +-
 mm/show_mem.c                                    |   1 +
 mm/slub.c                                        |   7 +-
 mm/swap.c                                        |   1 +
 mm/vmscan.c                                      |   1 +
 mm/vmstat.c                                      |   1 +
 tools/include/linux/gfp_types.h                  |   7 -
 29 files changed, 506 insertions(+), 468 deletions(-)
---
base-commit: ec005628e9dbcef26b761fa860f264fe6e5fd690
change-id: 20260617-alloc-trylock-14ad37dab337

Best regards,
--  
Brendan Jackman <jackmanb@google.com>

