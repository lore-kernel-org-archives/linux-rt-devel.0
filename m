Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDC5304D3
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924873; cv=none; b=SBhohCMO8FQtfroGsHHuhOymxOq0L1pBQOJ83jUpU/UQmYTEWaBMWzPkfeKUTG4ZSuH5yBXeSbb0peVjlZa93DZmmpqRHOf+dEy50q9ZBspM4AIJhmZ76UlrnryXyvix5ihtfeyH86JyeXU+R9gUp0zw0QMIX+jYtqL/KlEQmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924873; c=relaxed/simple;
	bh=Jcv91dvn9z2wVjfYdXVBn/Pe0mEV7prkLqGANvQn5K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cy0fbE5RrdnirUx8s3jClM/+/DLSo61g5xXPZd75DFdY7+xhEHxC9kaHQ+nXbmeDUFphR2MEUOyv5WwhtoeDjhuE14F0P4FvOPOoVlLvlGAQDjIq6Te8WTRDQrSgYL57yGtRYp2ZpsYKvpF4go9seJMC3JWd20oAyqfs1zpSlpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=db98tcaJ; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="db98tcaJ"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35834f72d94so6180483eec.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1791924870; x=1792529670; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mw9CyD0IeLmmZlhl0elWzXiE8Rnh26O9y+sTBiJSyuk=;
        b=db98tcaJseIeknf8CeHB3X+vapHE5SR8tjHP6/t18P5u4qZQYQUTUr6MaSQAD1Mlqi
         2e13eaxSesXKuVcBO7+DIfg7e3RgCJexyUxn4elME59P2ItOoxuNHEFYOi3KSdMasndV
         iuy8Vg123UvCFHYxsSNQSTVZG4cpqcqQWSDlv1fsogPhSjtarVFH73bsVVbBNnElC/u5
         L/KK5Yc1XsGcqydxnmdllFjruZwZZ3IB/Lhj/dlWgXMIosA/OYcasFNi6SYgsl+VId/g
         X6aJy47VRZtyCBHQwCSEY4akXKbKppzsKQxu85X8AKZeuif2LL/i2B2ymiwER5m/XJoF
         GT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924870; x=1792529670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mw9CyD0IeLmmZlhl0elWzXiE8Rnh26O9y+sTBiJSyuk=;
        b=tCXd0OFWSZIcPRRfHXHfIL46IFknfJ6vp1tIqoPU7NdI5PSbVnxNUXsptSg5MK8uU4
         2MPUEVjdg7zjnEagkMYDvjoa8zZIS/fRpcN+L5hPABNYWCFoRElxima+2Lr69oXEIQhC
         k10PBZQ+Dvrbb/qZCR7GUlI/357a3Kt+AHXriaxA/eGdv0uipy48cE024zKYXdk7VxxT
         PRmvHyJvqgK9GCqN2O6+IVz8OOHS1BSqOwfIFbDNrhEAWjegcbHkL6uFUn3ltInETb/h
         9ClBVAYoY4b5lU91cZunsjBinomZiV6/BDTHPHeHVd7YJLyzRLS5uCG3qAmkP9S6VNeA
         ubog==
X-Forwarded-Encrypted: i=1; AKwUvBwd65YmwLxoJu1T2LvYwVa6llloPB08DOu+Ae8nnG96HI4lWlfomnzBRwj+dTeCSgKvilac3xFviqmdqW/FaA==@lists.linux.dev
X-Gm-Message-State: AFq9FYI1uJeDsVNcjF8cfyllm0qTAlCQYG/nuRppO2Yp46enZkkJACKR
	cGKv8QNv6hoVWvv7ihR0xuvU6oski5iP4DfABgpc+07w/GqjXpkVdWl9osl6gwgWOyc=
X-Gm-Gg: AYBFou3yunvbTXL8FVv62gsksCyx8a5oN8Mww6NvzNRYRrTfWGmY+vEFkhEkHiJ3mwq
	LRx/HykLqJgRUP2FeDlwb8woOH3B+SpcBKvOUm9OGZ0866ELcNv0JyGsdqf/jGsQntbt1xI4s5L
	85EafOBTFY3MTfn5XsD1sFGl4pKxyDd6ecL/xtIlULcQHd0J+WuyeHt6Jq5T78PyWRDTrN9qE1L
	/jEJgBzz40ycCJdd1LGQSTRCh0edOcGa0VKPcCFGjZ3llHbGldNfnN3HP8fvtPp2Ojv+L+ul/Uy
	fGizJCc0E3xFCy+4d9eJy9LzLHNRxdiY/2FFPbrbO+ZrPRI1aFtl110iK2pilzPI48q/E1jYngw
	ZXlr6es/mVLmf3iQj4Tbm8HQJlKx1xQ3hs6xNvOjMDncnW6tAQC+zx9yJtmZ6yZaV0nS+DQF4Xv
	Ej3jU8Xsq3vxeRl66p1LXbNpJRpuoDAoX+Bo+wImnbJtL/6V+qg5DnOfTKAM7ETs7JTjQr40GaI
	LTEewjP7M0=
X-Received: by 2002:a05:7022:2381:b0:144:fb31:a597 with SMTP id a92af1059eb24-16a645d3a02mr25557379c88.47.1791924870065;
        Tue, 13 Oct 2026 13:54:30 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1dd57d0sm41277613c88.8.2026.10.13.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:54:28 -0700 (PDT)
From: Joseph Kain <jkain@nuro.ai>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joseph Kain <jkain@nuro.ai>
Subject: [PATCH net v3] net: do not let defer_count outlive an empty defer_list
Date: Tue, 13 Oct 2026 13:54:16 -0700
Message-ID: <20261013205416.3417296-1-jkain@nuro.ai>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__skb_defer_free_flush() can leave defer_count at or above skb_defer_max
with an empty defer_list. That state is absorbing: every producer then
takes the nodefer path without queueing, so the list never refills.
Deferred freeing stays off for that (cpu, node) until reboot, and
cross-CPU frees fall back to the page allocator, which is the contention
deferral exists to avoid.

skb_attempt_defer_free() increments before testing the limit and does not
undo the increment when it rejects, so a rejected free leaves the counter
raised with nothing queued.

Nothing brings it back down. The reject path returns before
kick_defer_list_purge(), so once the counter is stuck no producer
schedules a flush on the owner CPU. A CPU that never raises NET_RX itself
-- an application CPU doing TX while NIC IRQs are pinned elsewhere and
RPS is off -- then never runs the flush at all, so clearing the counter
inside the flush cannot help it either. proc_do_skb_defer_max() neither
resets the counters nor schedules a flush when the limit changes.

It is reachable with no race at all:

  sysctl -w net.core.skb_defer_max=1    # frees increment, then reject
  sysctl -w net.core.skb_defer_max=128  # does not recover

skb_defer_max has .extra1 = SYSCTL_ZERO and no .extra2, so 1 is settable.
From v7.1 on, 0 is safe because proc_do_skb_defer_max() flips
skb_defer_disable_key and the producer returns before incrementing. On
6.18 through 7.0, which carry the llist conversion but not commit
08dc30de1a40 ("net: add skb_defer_disable_key static key"), setting 0 and
restoring the previous value strands the counter the same way -- and 0 is
the documented way to turn the feature off.

Undo the increment when the limit test rejects. The counter then only
accounts for skbs that are actually queued, so it cannot outlive them,
and the absorbing state is unreachable without depending on a flush ever
running on the owner CPU.

While here, drain before clearing in the flush. A producer that queues
between the clear and the drain currently has its skb drained but its
increment kept, which over-counts and costs deferral until the next
flush. Draining first matches the ordering __dev_xmit_skb() already uses
for the qdisc defer_list.

Found by manual code inspection, LLM-assisted, while backporting the
llist conversion to 6.1 after hitting the sd->defer_lock contention it
removes. The latch itself was not hit in production; it was reproduced by
lowering net.core.skb_defer_max.

Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Joseph Kain <jkain@nuro.ai>
---
v3:
 - Undo the increment on the reject path. This is now the actual fix:
   the reject path returns before kick_defer_list_purge(), so a CPU that
   never raises NET_RX itself never runs the flush, and clearing the
   counter inside the flush cannot reach it (netdev-bot sashiko).
 - Dropped the empty-list clear from v2. With the increment undone the
   counter cannot outlive the skbs it counts, so the clear could no
   longer fire usefully and sat on the common path of the flush.
 - Added the comment on the deliberate clear/drain race, mirroring the
   one in __dev_xmit_skb() (netdev-bot sashiko).
 - Reworded accordingly: the reorder is now an accuracy improvement that
   avoids a transient over-count, not the thing preventing the latch.
 - Moved the discovery provenance into the commit message (netdev-bot
   sinfo).

Built for x86_64 and arm64, with and without CONFIG_PREEMPT_RT. On
v7.3-rc6 with skb_defer_max=1 and a cross-CPU TCP load, defer_count
reached 1918118 unpatched and did not recover when the default was
restored; with this patch it stayed at 0.

v2: https://lore.kernel.org/all/20261008220256.1844072-1-jkain@nuro.ai/
v1: https://lore.kernel.org/all/20261007180056.1394868-1-jkain@nuro.ai/
 net/core/dev.c    | 5 ++++-
 net/core/skbuff.c | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 18dc88990510..60d86bc21632 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6940,8 +6940,11 @@ static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
 
 	if (llist_empty(&sdn->defer_list))
 		return;
-	atomic_long_set(&sdn->defer_count, 0);
 	free_list = llist_del_all(&sdn->defer_list);
+	/* Racy on purpose, as in __dev_xmit_skb(): a producer landing between
+	 * the del_all and this store stays queued but uncounted.
+	 */
+	atomic_long_set(&sdn->defer_count, 0);
 
 	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
 		prefetch(next);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4aea06d5167d..6e0872569ccf 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7388,8 +7388,13 @@ nodefer:	kfree_skb_napi_cache(skb);
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
 	defer_count = atomic_long_inc_return(&sdn->defer_count);
 
-	if (defer_count >= defer_max)
+	if (defer_count >= defer_max) {
+		/* Undo, or the count outlives the skbs it was counting: the
+		 * reject path never reaches kick_defer_list_purge() below.
+		 */
+		atomic_long_dec(&sdn->defer_count);
 		goto nodefer;
+	}
 
 	llist_add(&skb->ll_node, &sdn->defer_list);
 
-- 
2.55.0

