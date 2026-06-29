Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF143B6C08
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728535; cv=none; b=XFFTurzVqVm0GOUR/YNszf9FS/BZ4j/zvE7cy50pqC17fsBkA3Wr9MFgLVZDBOqGdhbm9xcqI2EybQJxu4St9jx2nXUgRB2WEaPGAZMvRi3PYCMChP0TZ0fQkgpScCVgIccPl0bmIcIx9OVMg18DExDzgIOcjnS5KWlErOWmOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728535; c=relaxed/simple;
	bh=jwLgLR3nYwBK3/BuT+gD2ATqKLN7xJeOS1tgrZOALpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eI3rlA91BKJ9ar7ZJfLVaxH/9YiXpFoVTvHJv5FP0djeXmv6auP1AGcnAhDr2fbDUdtHtk5SFaOZkvp4WyQJYteWwPChPHeG3CqGsxyG41Do0yuHKiHA3GyYsroghbTSwXGqhgaTIMl4p5dDOcgSY7kuKgYErM0sJTO5e2/gvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=HiPq7obg; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="HiPq7obg"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8dd3fe9cf10so33460496d6.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782728532; x=1783333332; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6OASslZi7YxFlKXAz00T8+s1qFuKwk4pzWc3ZIqweI=;
        b=HiPq7obgfNyQqhvWhUKiSzvCfipVeAwanURW1FIugDUgYf0lvN3BFYH1poEEXPT6/P
         oR5o+uhc35OZou3mOURsdUl+QY0tRbCo26PnE50Tb8H1T8tBJvuj7dJIf5UivRBPeiBK
         kUX0HdpTof/TJBitMdXnfNfahfVuKHSKN8SJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728532; x=1783333332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6OASslZi7YxFlKXAz00T8+s1qFuKwk4pzWc3ZIqweI=;
        b=OCRZjuYV/x5DxY7cn8oRo/uRdCNHjAF4oIRUZuCjJodxu8fUc4F/TJ6epjZjwvU/vp
         BnFkh8OvGxB4roB4fPE8fcuolD6pvU8Yi0mL0jhgZYJZt3Bj65C+NSRlCnYyLChxa4AD
         W1y6QrG7hF0pu0EL26DrTV8gctY5/QV0eiPpiCQuj9DGpidQDB9Mu1Ap3etKZ8jgw3+A
         oHxPTYTrP0SbE0IETAx/2bBOh4rfft7+7bRZo39iHliHXJ1/mR6LFX1Jq2yjB60kph+O
         A+T+5roLtk/XHqGvIZMbd392pLg0EMsXsV3XSAIepsZpu32mPilplGU34qzwBZx0bf8t
         FlYw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9xd7NMwSp0ywUbGQRTc82PHoh0xgtQmoZYNYZiVL2tNEKG6ROXaHUksEdwzkm30tCj6rnUa78PiR8ZlusXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkVpoGG3wmI0aHi+F4T1u/92j5pOeynnnDKW0cSz5X12uYRDe2
	H/rAZPvlnjrio8/6CFLNP53Xxl5uRT2gjVJMuxljcFDqXfFuUopyb00agDGIcr/JuQ==
X-Gm-Gg: AfdE7cnDEAuPeqHCPVnpEXIiwltICfvUigPjR6f5ACKxEM4Er/cZssCr5Yr3dAInqJv
	amReOB+zOXs8FNW9QfLWWIpF7aFaacwks/2RNUuIk3gbH++fXwU20WIcOJf4Ln19oEP2LuIQ+yX
	rcWUVfvR5iidPJRHM/KD3Vlp8CU9b1qCFN4Yw3q3C8Xlz2CHlJ5VbQgTleYKO1/Nu2zO0BtpOJX
	6hd7cunjlCBRO8yTiGGbVAWIsIz+IgqJY1HH8p2X8H34dOfrSQLr9fAG/mhcXSHPJBbc3dEd3n6
	FO1ZPRCpeVpNLMZrmUWz+DOCo226DIlY2Begg1rdyWhmtOgx2udg0trJHsWJJKR69vVxONjymwk
	D13DiemAvsisIbrvmwQHggjQg8mYatBPY+R82zaMwTErfYJEOUTh5ZUxdb6d7H8QaqTsNv/x03x
	mgm2TS1g==
X-Received: by 2002:a05:6214:194c:b0:8ee:df58:e5c5 with SMTP id 6a1803df08f44-8eedf58e938mr95782096d6.20.1782728532334;
        Mon, 29 Jun 2026 03:22:12 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ef0f2b9df0sm53589236d6.13.2026.06.29.03.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:22:11 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	toke@toke.dk,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Machata <petrm@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 0/3 v2] Fix broken TC_ACT_REDIRECT
Date: Mon, 29 Jun 2026 06:21:54 -0400
Message-Id: <20260629102157.737306-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sashiko-gemini[1] reviewed commit a8a02897f2b4
("net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle") it
 correctly pointed out the following:

"
This is a pre-existing issue, but does executing a redirect via a qevent
filter cause a NULL pointer dereference?
When tcf_qevent_handle() processes a TC_ACT_REDIRECT, it calls
skb_do_redirect(). This eventually calls bpf_net_ctx_get_ri() which
dereferences the task bpf_net_context:
include/linux/filter.h:bpf_net_ctx_get_ri() {
    ...
    struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
    if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
    ...
}
Since qevents are evaluated during enqueue, which runs within
__dev_queue_xmit() after sch_handle_egress() has already executed and
cleared the bpf_net_context pointer, will this dereference a NULL pointer?
"

That issue is fixed in patch 1. See the commit log for details.

Upon further investigation it turns out that TC_ACT_REDIRECT being returned
from the egress qdiscs never actually worked. When an action returns that
code we would silently loose it and the packet will never be redirected.
After all those years, if nobody complained, my gut feel is it was never
used by anyone with serious need for it.
Patch 2 fixes it by 1) putting a warning out when someone does and 2) asking
the core to drop the packet. At least this would help whoever is
misconfiguring to diagnose the issue much faster.
I had initially attempted to "fix" this and make it work, but unfortunately
it's a bit ugly so i left i didnt think it was worth fixing

Apologies for the shotgun Cc - its what get_maintainer.pl told me to use.


[1] https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com

---
Changes since v1 (address 3 sashiko comments):
1)Patch 1: Address pre-existing issue to cover asynchronous qdisc enqueue
  operations in particular if bpf_redirect() is invoked from an attached
   ebpf program (the helper invokes bpf_net_ctx_get_ri())
https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com

2)Patch 2: Explain in the commit message that it is actually design intent to
  remove TC_ACT_REDIRECT from tcf_qevent_handle().
https://sashiko.dev/#/patchset/20260626165156.169012-1-jhs@mojatatu.com?part=2

3) Patch 3: be explicit with $EBPFDIR
https://sashiko.dev/#/patchset/20260626165156.169012-1-jhs@mojatatu.com?part=3
---
 net/core/dev.c                                  | 31 +++++++++++++++----
 include/net/pkt_cls.h                            | 13 +++++++
 net/sched/cls_api.c                              |  6 +---
 net/sched/sch_cake.c                             |  2 +-
 net/sched/sch_drr.c                              |  2 +-
 net/sched/sch_dualpi2.c                          |  2 +-
 net/sched/sch_ets.c                              |  2 +-
 net/sched/sch_fq_codel.c                         |  2 +-
 net/sched/sch_fq_pie.c                           |  2 +-
 net/sched/sch_hfsc.c                             |  2 +-
 net/sched/sch_htb.c                              |  2 +-
 net/sched/sch_multiq.c                           |  2 +-
 net/sched/sch_prio.c                             |  2 +-
 net/sched/sch_qfq.c                              |  2 +-
 net/sched/sch_sfb.c                              |  2 +-
 net/sched/sch_sfq.c                              |  2 +-
 tools/testing/selftests/tc-testing/action-ebpf   | Bin 856 -> 9072 bytes
 tools/testing/selftests/tc-testing/action.c      |   5 +++
 .../tc-testing/tc-tests/infra/qdiscs.json        |  32 ++++++++++++++
 19 files changed, 87 insertions(+), 26 deletions(-)

