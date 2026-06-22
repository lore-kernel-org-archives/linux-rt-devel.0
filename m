Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF521ABC9
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122504; cv=none; b=owVUpr5TNxsAAW6EZEowQJAwFGUo5ndxQTN5qxIhNdDR4GJsYTXf43zLpJpwpoPrABXrBRi6KQIY188qlsRxKiHHdMEhjSzCq9DPxCQ/aACiilqrv01eVqMjtGWadvuUo/fRALKGHrxFYi0LdxKaCYHrzumHfjVOAoP/8RO9NBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122504; c=relaxed/simple;
	bh=+nQt9gc/ypinFH7bG50wSrra09RllLYc74CI3Q9dfX4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B0Nre65daFZXTJwkEvCmAGRbjVTpntdLWNWO3cTCWFoXO91CBvORLFJTYY4v8OHyAZaTLeBEKa6HpyA5+f15zVYmBHma2WYoqRCf3Zfz7purXVfbmL7PX2TNplD9QJrNty3BoUVVniCgJvoF2AUowonnhKwcZZulnw+1n95KDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+NKYXpG; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+NKYXpG"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c0793772071so478851066b.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122501; x=1782727301; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HyN6/V2JO4AYCUsSUM4Fyt9cHVBJWqwO25DnwWB+tqc=;
        b=E+NKYXpGvDKRnbthGJkh7xjgAhVPupPj4AXSK048BmCKkH/wxQoMp3N6RL9UxCyWth
         M8Zl8+49syAK4hE+KANgXcMjGaZCmHDLhsigsVonGOpZfqe5j3xAerKJVfpUk/9eQ6sQ
         a+TAu0bWMyBMhAg/ERhQXzNkhCjBnjB3yJn9t6O8vNja9uWSKgy5+0pRXqqesrMg27Id
         5suAtdEAI97WOoYCr97ZbSY6s9OU7aKnsKk252Tky06ub7Y5amTgwxWP18x5P+zpQQCU
         xG51bwQKPz17I9p7CYsbRLx4d9BRpAhSvHGfE2f5t6HCJCdS333MjN90jQd4TeleTiY/
         TmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122501; x=1782727301;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyN6/V2JO4AYCUsSUM4Fyt9cHVBJWqwO25DnwWB+tqc=;
        b=JjE0z5wdSyCLIr6XkCjIXvkJKRCZoJFgtx0Bg0N9TMwi4tA0Tltc8SfywMgRVqRmti
         rF7TVDTfc/ltJiLNaNg0c8IsvkVsja4DiPMBM8EPTsuAV/PBkQAUAkZF6D4SIKbyK1Ay
         XT691vpt5Ql6Pjusp4ctE31L7d+SHnoMJE3x8zGwdXueonIeumaXSvyIrk45PMrz4jlc
         iCKYurkKxJFJ6Z27tG9K4uixH/HpAcr4CvsYGhVPvTo7Zu1c52R9Ga5GKOBH4wqYrUNC
         BYjuGkQ0Vq0FodxqNCXUnMSIgD2yvD5vffmXifntos92TNQdRVR0awTO1fFfZ/7oav7h
         h20g==
X-Forwarded-Encrypted: i=1; AFNElJ/I3foQEKv/B0ir27tAF6AgUkmGlXPEKtQl346XuAubR/BH2llB3JgmHAq1e/LqfnVyh4pu+Sm2l/GeQMQdDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb//qE/uI863K0oew+pOQy6VuHa+tNfN0AT1v0jakCIm8HguDs
	Dp3/4qMXR2N/XMhuxzLyucAi/iTh0f2ya66rnqE5CXDOcQfkjjExRLC+JsQZASNgzaRjLwvPhiJ
	WjwTJlubVp53WRg==
X-Received: from wrbcp34.prod.google.com ([2002:a05:6000:4022:b0:460:672f:ad65])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7210:b0:c0d:46ca:3ae9 with SMTP id a640c23a62f3a-c0d46ca3b73mr292642566b.3.1782122499355;
 Mon, 22 Jun 2026 03:01:39 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:27 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPcHOWoC/3WNQQ7CIBREr9L8tZgCWogr72G6oPBL0VoMYGPT9
 O5CXbuavGTmzQoRg8MIl2qFgLOLzk8Z2KECPajJInEmM7CaNXVDBVHj6DVJYcnxIPSkDBdGdZw
 LyJtXwN59dt+t/XF8d3fUqUhKY3Ax+bDshzMtvX/umRJKJO+NkGcpOcOr9d6OeNT+Ce22bV9+s r3vvQAAAA==
X-Change-Id: 20260617-alloc-trylock-14ad37dab337
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Subject: [PATCH v2 00/13] mm: Some cleanups for page allocator APIs
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
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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
Changes in v2:
- Fixed up whitespace in nolock unification patch
- Introduced ALLOC_DEFAULT to replace literal 0 for alloc_flags
- All other patches are new
- Link to v1: https://patch.msgid.link/20260617-alloc-trylock-v1-1-83fd7858832e@google.com

---
Brendan Jackman (13):
      mm/page_alloc: rename ALLOC_TRYLOCK -> ALLOC_NOLOCK
      mm/page_alloc: some renames to clarify alloc_flags scopes
      mm/page_alloc: unify __alloc_frozen_pages[_nolock]_noprof()
      mm/page_alloc: relax GFP WARN in nolock allocs
      perf/x86/intel: Use higher-level allocator
      KVM: VMX: Use higher-level allocator
      x86/virt: Use higher-level allocator
      sgi-xp: Use higher-level allocator
      net/funeth: Switch to higher-level allocator
      mm: Remove __alloc_pages_node()
      alloc_tag: Move to mm/
      mm: Move __alloc_pages() to mm/internal.h
      mm: remove __GFP_NO_CODETAG

 Documentation/admin-guide/cgroup-v1/cpusets.rst  |   2 +-
 Documentation/admin-guide/mm/transhuge.rst       |   2 +-
 MAINTAINERS                                      |   2 +-
 arch/x86/events/intel/ds.c                       |   6 +-
 arch/x86/kvm/vmx/vmx.c                           |   2 +-
 arch/x86/virt/hw.c                               |   2 +-
 drivers/misc/sgi-xp/xpc_uv.c                     |   2 +-
 drivers/net/ethernet/fungible/funeth/funeth_rx.c |   2 +-
 include/linux/gfp.h                              |  28 +--
 lib/Makefile                                     |   1 -
 mm/Makefile                                      |   1 +
 {lib => mm}/alloc_tag.c                          |  18 +-
 mm/compaction.c                                  |   4 +-
 mm/hugetlb.c                                     |   3 +-
 mm/internal.h                                    |  20 +-
 mm/mempolicy.c                                   |  10 +-
 mm/page_alloc.c                                  | 254 +++++++++++++----------
 mm/page_frag_cache.c                             |   4 +-
 mm/slub.c                                        |   6 +-
 19 files changed, 193 insertions(+), 176 deletions(-)
---
base-commit: cbe5256a15fc26f592efb037e528da54b2139ee5
change-id: 20260617-alloc-trylock-14ad37dab337

Best regards,
--  
Brendan Jackman <jackmanb@google.com>

