Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196EA432BC5
	for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113420; cv=none; b=oZTa/2Zd10uOaLi6+PMtcaDdMZC79nkVX176MnxJJBZ145hPtHf8aDcn+ii2RtvQjfqojsKA5f03NKsbIgZDHlwa2GrtEBeI1G/rR2Vyq4yC5CUy9+nEI/4lUS6HUip9aecwiI/eTG+y9TrlQMq1is8gczDGZllIiFq0ZovARc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113420; c=relaxed/simple;
	bh=OuHNTKCxUIMX67vpWylAoqXnFPUPv0sLTOv0JBYEmnM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mv1CGBfTbSpLo1tZHWpvMTHkJLQDmbUWkNbpuHJSMeg4N/xNfLJYs9ZSkQjdJog4KKrmnGtKobE5SlKH+lfCkhDWMqOkBh1bdusGqt/22PhSfPpKh9ao3kIPLxzfvMfy1YY1l0ClPC3H5MCHatMVVwiTY+yFNy+Ar7b+0JI/KuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZT7O1/OM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZT7O1/OM"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493c20d0468so22344335e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 04:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784113417; x=1784718217; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BvOk2rkLE/yZxPV4YYeXjAMJoxjIiJfLSZRx9VhA7SI=;
        b=ZT7O1/OM8rW4PFTfitMXQDEDyhFzNJqhmZ88zaPUZFSXFMOVAyWKiFBHuc/XN8gmjT
         ESRUdH5OQVSeASwkuyT7ZfUL/YbGk9190f2G+kyH//cKxRuW9nMjmr5gSCgDFhQ0x1fI
         kr4M4yCj7Ssemq73H4fmAqOZ8yo+LpIxdVLB859AKgvimVGVU0lWboKF+Qm//2NbNIEM
         Yl3uhDyrQEDhRy2ooQEUgfJR5MIat3CNKHJdXWU4UIKmhnGMzbK3+F6ksR7HtPdEOgtX
         0uZPOuPJAk+9n+qAsXydvhnLxvSqAcWigzKd68E+FlTovlVq66sxbmXV9lNt0LOm3ZS3
         Nuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784113417; x=1784718217;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BvOk2rkLE/yZxPV4YYeXjAMJoxjIiJfLSZRx9VhA7SI=;
        b=qsK/QN50jckrTdhsQFcIxu8GZjR45GcFgWxKPMzT2YhSb+ObxhSYdqNQQahRrcwWwb
         ijnmB74oM8NvgvS5k/mXrJUo10dnpSQUzyFFnFWJDImvQtriDCaygOYv7ICLXD7noUZ1
         IPZzvGJsY0ytuRl8ExXRbsbR+hJdIOEz4wIA0xlgzEiQ5NxfPYdEz7BzH2vYlqAeUiKg
         ZoF8mNQ9QkvMbjNyDAPVh0u7iJOBytg0tl0qM+APGnCl+aNZqtwR3h4HlqROW10ExMG+
         81qwXu93peABMHQ6CyJ3eqiA8I6qXjAhVXt8j8HW2GvLugnzrTXLcRzUMj1cg99qDCeN
         VlVg==
X-Forwarded-Encrypted: i=1; AHgh+Rroj98hKh0nZUFlMITe1skJ81dphTzOrozLK3ulYSj89iPMC6B2/BiX63o3aBpoSHJIhGL3vUjR6u0R1d7Vlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxReUeb9cE8AR6AsOC2x1UsjBewDx4te5C4spKrEiQ0XP5TTRGX
	iiOE6oT7aELKXuwiwRQS8dLR0C8QvYlGe2lkmIISNiDIrynHUAom4yNMUcXgZSl80BdLMx5LZdQ
	VMrGNoNWn3D8/SA==
X-Received: from wmoq16.prod.google.com ([2002:a05:600c:46d0:b0:493:b593:ca9f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f8a:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-493f87e6e9cmr175096055e9.15.1784113417076;
 Wed, 15 Jul 2026 04:03:37 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:03:17 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPVoV2oC/4XNQQ6CMBQE0KuQrq35tIDBlfcwLqD8QrVS0kKVE
 O5uixtdGJeTzLxZiEOr0JFjshCLXjll+hD4LiGiq/oWqWpCJgxYAYcUqBtUT0c7ayNuVBqtzWM
 aKOdMFLxAaMqShO1gUarn5p4v7+ym+opijFhsdMqNxs7bsU9j79+HTynQSso6l5hjA3BqjWk17 oW5k3ji2SeT/WJYYLhgEAjO6jT7YtZ1fQEIegvxFAEAAA==
X-Change-Id: 20260710-spin-trylock-followup-332c636e0d99
X-Mailer: b4 0.15.2
Message-ID: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
Subject: [PATCH v3 0/4] mm/page_alloc: couple of followups for recent cleanups
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>, 
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>, 
	"=?utf-8?q?Michal_Koutn=C3=BD?=" <mkoutny@suse.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, sashiko-bot@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



---
Changes in v3:
- Fixed Sashiko Links: (Zi Yan)
- Fixed kerneldoc syntax (Sashiko)
- Removed extra VM_BUG_ON() (Sashiko)
- Link to v2: https://patch.msgid.link/20260714-spin-trylock-followup-v2-0-=
3c20ed032b14@google.com

Changes in v2:
- Separated from functional fixes
- Added cpuset cleanup, comment fixup, VM_BUG_ON() removal from Zi Yan's
  review of [0].
- Link to v1: https://patch.msgid.link/20260710-spin-trylock-followup-v1-0-=
affb5fe5ed00@google.com

Based on mm-new, these are followups to [0]

The alloc_pages_nolock_noprof() comment fixup could be squashed into
"mm/page_alloc: relax GFP WARN in nolock allocs" - currently
11770f8836f44 in mm-new.

The VM_BUG_ON() removal could be squashed into "mm: remove
__alloc_pages_node()", currently fba100a6cdfc5.
[0]: https://lore.kernel.org/all/20260703-alloc-trylock-v5-0-c87b714e19d3@g=
oogle.com/

To: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Brendan Jackman <jackmanb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>
To: Tejun Heo <tj@kernel.org>
To: Michal Koutn=C3=BD <mkoutny@suse.com>
To: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev

---
Brendan Jackman (4):
      mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
      cgroup/cpuset: update some comments about the page allocator
      mm/page_alloc: fixup alloc_pages_nolock_noprof() comment
      mm/page_alloc: remove a couple of VM_BUG_ON()st

 include/linux/gfp.h    |  1 -
 kernel/cgroup/cpuset.c | 13 +++++--------
 mm/page_alloc.c        | 22 +++++++++++-----------
 3 files changed, 16 insertions(+), 20 deletions(-)
---
base-commit: 59c684a9908d2e6f7a791f7f033eae57ec2b3a61
change-id: 20260710-spin-trylock-followup-332c636e0d99

Best regards,
-- =20
Brendan Jackman <jackmanb@google.com>

