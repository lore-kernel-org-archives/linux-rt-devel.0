Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431844;
	b=a/5Gq7Qtcrs/2X6/RCPXqiVNwb/OxqK9zmgGblNehDrwQpjpKvAfNqZI+qdRCIioN58p
	 QbqpQMYTY2G5d+OJI3Qjr91UAr+xify1+ywYqH+HEg+OpfCrZtnwadLZSlpsc5bpHbCvS
	 eTmy3m6SFGbBcfgZUF5QkfgASoai9whMPspqjY9cLHweXapDs0lqTCr2Nge/vfrIZkG5r
	 9t3WtUwe7DuQQVZBsnnXfJuzPmNV/R5/itubCo1C9vceX8a8E4i5RlAGKvL4X5i25sRni
	 iJRLfupO3uGGV6gclhHwDW7Bop1rcze0+CWMenhU0KhB83B4p5CYUWnQKvjTki99zjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ds7FADVPaOufPM8wkPqgl/05L1wAkB8WIhvDryqev1I=;
	b=Ebs//nGsGPr7bGd/pavtlrv4beSlQzFdCRMkLRIisPhLgp4QS7t0U2tvd4Kh8CosqHD4
	 E601jvjYKJIbl8Zp+hYmF80JMlD2EVytnTBSPRFdXGoV1L/zq8tOAX63f+fZKbLp9iHTI
	 F1iIZjM1Igd499TVQj/DY+4EKND469fo4shdswdr0mfKMgBT6PH+sxb3hs4Cfylo+xxH2
	 RZIzGwGHf6AxEJBrFZUW7ZSvkP5YbI5Y75rdVf4OleZt0d9zTeSFebRWu35/9CdhySBsL
	 LH6MV2J4KmyFpBIIqeYQk4gHHxnIIN163qSFf2TnZayP0GHbUd9bHYuiV032rXrgV+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	dkim=pass header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=drnqGEyj;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E4606A31A
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 17:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F1E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=drnqGEyj
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so2086470a91.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1792431842; x=1793036642; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ds7FADVPaOufPM8wkPqgl/05L1wAkB8WIhvDryqev1I=;
        b=drnqGEyjI6KSfc7ITgT3Z+R+GKmcMV459i+EQEkRRoSC+H2eycs/8fJvtxe5NLPxiV
         /1hIooO0QyIlcRKPTqvpcfn20pHuUwXPjmvMl1WNal4Yq+hcZlykRhwqDEK1QJ6KCDdN
         dQxse+h4KYGXyNCEqvJu7Vo3wdUTclqdCCr7Klqf00FSm6amxo9B8Js5na9gDGexIacf
         bohoUw5Rt2S37vsqMRYeQk0d9/kQAaVk5NrSrQnKlkgY1kbhpU8YudczXTQMeg59O/4q
         hWcfXWRkRPMZcwI8zkcAxCT6SvwCcV5udvmzZXOMC8SdimzRlYWjmsMgZbDT3EtDBCJg
         J6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792431842; x=1793036642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ds7FADVPaOufPM8wkPqgl/05L1wAkB8WIhvDryqev1I=;
        b=B4xBvc4HmOfmNQQLVyS6V1QI5AUTrq/GbdoiaoJSZ9CrwW/LMx+3qRoxw2qCEe6kol
         FrqaYdX7r9IMFqpwc49RxdQs6haTdBTKnGWrxqY2SNT4yiL8Imm0VA9E+KVe+uLqLRg7
         GCBfApwkZx9AcUl1Ufyvaun0Lg63LPPZiIGRtDkv6DvP58p6yoJo6IaOq6Q+s2rggPIq
         NT40OQmE7B2Q5du1ExWYamnXidtTE7384E1NK+lDqGSWE/Ud9iJQWKGUBtSV8vnJK6jb
         WOtekqOPKBQ0DW/EFDdMW2j2+BScvTe9P+YYQ09/kgeyhXuurS51uqxjwwN6fWaN+7Tq
         eDCQ==
X-Forwarded-Encrypted: i=1; AKwUvBytTlxxid5rRW6OHcmXWGuX07zvUQvUQtW6PdewZL0Cvl+WvZ3Mu7q0X2bk7aRsHFMzXptvR5JifccGlBVBdg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIng62qI+SE7GqG4fEGPbHxTG+UQF99/DpngW/xDqQwkDOidWpB
	3lgC2nFs9QcvxxLtK4Xp5P5CjRGeSrhHberD05Zz27qmXO8Kvk4MZHm/+YTd7oz/YLA=
X-Gm-Gg: AYBFou1tUxbrMveSKnp3PPgZLwMxPy8BC2BIJOaqZvuD885h4C6ORaTw2xBXST1OKGS
	IPubyxC+nEJPqFTp7cWYRWU3n5pMhRSs53+V+lMWWl7LtGF3nu1QXy7fDLbW56fGe/usxGffOr+
	ytSmEihGveD6xAc4i8mRluWaNK+zZFHoQvtB7YAt+IJkTXLhHZRB2SUw+JLoP3HeUbN+6GKb1/M
	jQb4eMgjN50Ee3RRt3owHIFxw4h/3sGjFb9Bqrr9XKfU5J+QxaEbl2xQhKEBS+A3v0KhMQcAnAZ
	kQAIBtFSwgDd1eaBQUJT2SMoCi5IFLr1L0IeGGy9qfN9qmo2146/s63PsAlr5TkluxMDComofd5
	JjbI0qZFInBvLRUDdulPR+mmV1UFcsBs/PQi9RE4nfNl5F2tYcfZyAH3Tdbh+7Ofm478WmRk1LG
	/QQolG/H69XACkJKphW8h7o5CRnP4sas0fMPh4sF3a/5PrudTcDep5mxL2TTyOX6HOKiRqg+Uai
	OdcoSnHDXQ=
X-Received: by 2002:a17:90b:4c4c:b0:3ac:450b:164c with SMTP id 98e67ed59e1d1-3acef15a266mr8174170a91.47.1792431842342;
        Mon, 19 Oct 2026 10:44:02 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d400505sm453912a91.4.2026.10.19.10.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:44:01 -0700 (PDT)
From: Joseph Kain <jkain@nuro.ai>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joseph Kain <jkain@nuro.ai>
Subject: [PATCH net v6] net: schedule a purge when the defer queue rejects a free
Date: Mon, 19 Oct 2026 10:44:00 -0700
Message-ID: <20261019174400.1377093-1-jkain@nuro.ai>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__skb_defer_free_flush() can leave defer_count at or above skb_defer_max
with an empty defer_list. That state is absorbing: every producer then
takes the nodefer path without queueing, so the list never refills.
Deferred freeing stays off for that (cpu, node) until reboot, and
cross-CPU frees fall back to the page allocator, which is the contention
deferral exists to avoid.

skb_attempt_defer_free() increments before testing the limit and keeps
the increment when it rejects, so a rejected free leaves the counter
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

Kick the purge from the reject path instead. The reject is the one place
that observes a full queue, so scheduling the flush there is what stops
the counter outliving the list, and it does not depend on the owner CPU
ever raising NET_RX on its own. kick_defer_list_purge() already coalesces
through sd->defer_ipi_scheduled, so a burst of rejects costs one IPI.

This also covers the case where skb_defer_max is lowered below the
current defer_count. The kick condition tests equality with half the
limit, so a reduction can move that point behind the counter and no
later producer ever reaches it; rejecting without a kick then strands a
non-empty list the same way. The reject-path kick recovers both.

While here, test the limit with > rather than >=, so the effective limit
is skb_defer_max rather than skb_defer_max - 1, matching what
Documentation/admin-guide/sysctl/net.rst describes.

That also makes the half-capacity kick reachable at small limits. At
skb_defer_max = 1 nothing was ever queued, so no kick was ever sent, and
at 2 the equality was never hit; both now kick. That is what commit
c09b0cd2cc6c ("net: avoid strange behavior with skb_defer_max == 1") set
out to allow.

Also drain before clearing in the flush. A producer that queues between
the clear and the drain currently has its skb drained but its increment
kept, which over-counts and costs deferral until the next flush.
Draining first matches the ordering __dev_xmit_skb() already uses for the
qdisc defer_list.

Found by manual code inspection, LLM-assisted, while backporting the
llist conversion to 6.1 after hitting the sd->defer_lock contention it
removes. The latch itself was not hit in production; it was reproduced by
lowering net.core.skb_defer_max.

Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Joseph Kain <jkain@nuro.ai>
---
v6:
 - Keep the increment and kick the purge from the reject path, rather
   than testing before incrementing as v4 did. One atomic instead of a
   read followed by an RMW, the increment still reserves the slot so the
   limit stays exact, and it also recovers the case where skb_defer_max
   is lowered below the current defer_count, which v4 did not
   (Kuniyuki Iwashima; also reported against v3 and v4 by
   netdev-bot sashiko, whose suggested fix this is).
 - Describe the two resulting behaviour changes -- the effective limit
   and the kick at small limits -- in the commit message rather than
   only here, since git am drops this part (netdev-bot sashiko).

Measured on v7.3-rc6 in a VM, 8 cpus, cross-CPU TCP load, sampling
defer_count via bpftrace. Dropping net.core.skb_defer_max from 128 to 1
and then restoring 128:

  7b63ef2d55f2 (unpatched)  defer_count climbed 701404 -> 3244783 and
                            stayed at 3244783 after restoring 128
  this patch                defer_count stayed within 0..1 throughout
                            and returned to 0

With skb_defer_max=1 and a cross-CPU TCP load, kick_defer_list_purge()
is called 0 times before this patch and ~756k times after, over ~750k
skb_attempt_defer_free() calls; at skb_defer_max=2, 0 before and ~163k
after.

Built for x86_64 and arm64, with and without CONFIG_PREEMPT_RT.

v4: https://lore.kernel.org/all/20261015162209.485940-1-jkain@nuro.ai/
v3: https://lore.kernel.org/all/20261013205416.3417296-1-jkain@nuro.ai/
v2: https://lore.kernel.org/all/20261008220256.1844072-1-jkain@nuro.ai/
v1: https://lore.kernel.org/all/20261007180056.1394868-1-jkain@nuro.ai/
 net/core/dev.c    | 5 ++++-
 net/core/skbuff.c | 8 +++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

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
index 4aea06d5167d..643666d9f4c9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7388,8 +7388,14 @@ nodefer:	kfree_skb_napi_cache(skb);
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
 	defer_count = atomic_long_inc_return(&sdn->defer_count);
 
-	if (defer_count >= defer_max)
+	if (unlikely(defer_count > defer_max)) {
+		/* The kept increment only comes back down when a flush zeroes
+		 * it, and this is the one path that sees a full queue.
+		 */
+		if (!llist_empty(&sdn->defer_list))
+			kick_defer_list_purge(cpu);
 		goto nodefer;
+	}
 
 	llist_add(&skb->ll_node, &sdn->defer_list);
 
-- 
2.55.0

