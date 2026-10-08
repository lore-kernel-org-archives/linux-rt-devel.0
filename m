Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75F3C872B
	for <linux-rt-devel@lists.linux.dev>; Thu,  8 Oct 2026 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497039; cv=none; b=gee8PlkA8ClZYuc17ymxxRRimYllpPwEh9g353GJADPYEDZKSXSysPL3QkAPNbELQJBhCrdzsbezskrc+08sLgvuKyvlFmn5+fjKf4S4jNPvcLcsCiy15yekaHpfRpXGc0Pfbva8c2PERfTMcpmKHWimt0ZqnRT8UW93qEbYJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497039; c=relaxed/simple;
	bh=8k95RK6Zf52oGbmUpDyrJ6APv7VVAvduP/WK/ehltQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLTwhlIXPhrvMgi7Mv0yb2aPHwV+FJgAMOElho+zjsD3wDfhv7SaBBVpm+SByXtL9b4vTvE0VMdZM0hvASu3pLrnnwkb1qYoD7dzNCuZ4MFQ1GUKxS810hpDnFyt/wVI+p43nJSLSRiqy3M5Wf41dJik5tzpk3OimFgvf6kGzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=iXxW2OqJ; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="iXxW2OqJ"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3515f9a5d25so1533926eec.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 08 Oct 2026 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1791497036; x=1792101836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6q2ZgKyEielHB9fMBeVKRfxouhNXO4dRwouPOAg0k8=;
        b=iXxW2OqJNcLGilh3cFsT4xYNnDwMqybB5zc2X6Qp5zY2TJSyOzMefdBBKXvdT7swiM
         Lc007EqR0RhI/5+a7H8sJS2pSGOtUtIctZaCCnhYkwJe0lg7bsCG9VXvUXix0qLsCLba
         XXCEBLGFohjVSU1afNUMnA4x5MuoGJlXfGc5B5jSsTpXf1A2pN7n2S0fa9L3JSltnYms
         Ff9XEZosTEcVYShqpw2OYOCX/nmh/hB7prTGjfxSjM537zPV9F/hgDCPbj+H9eVllKaq
         KoBtg5oAWNVGBxN9qmgMPVviM7/JI/Q4RYcYggY9DUqZlqNRZTTyLQOlHPtQjOizrXX1
         4cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497036; x=1792101836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6q2ZgKyEielHB9fMBeVKRfxouhNXO4dRwouPOAg0k8=;
        b=gCjlA2Y+lFR0Qi4tTwi1WblD8Ax2qKtWpSPsZmVfpOSOYf9nJcmL15UmOnl4jplLlv
         TqyQeuJFurNqTzBqbGJ8v5M8/vKZiVeVINcln48soEGtyQH26tul3P7KXxMK+G4TfObL
         D+B8TFpC08g/hD1EmAOTLo4jaOY7SxyTxvpviwrYjFvpWEnrPEOV4IEug382Y7ID678W
         QDVw58gOY93m9i7gVkT9cLA0vi1/1k/y15c+iitebOeTIu4N3DzRGTcRULd6hcvRWiyp
         x4gx6a7bqmt7feBUjMdkkp9fCeyiX+I3v3SROV7zF7/GVTtfJrPZX7HZANETPqAFn9wD
         WfNg==
X-Forwarded-Encrypted: i=1; AKwUvBzBySrdrKu2iuSlOrhdJolem2Bgb6Bg/qh7Fr2KtBXwpc4WZl3MI8g9YefEUbkFTNfz+qdO64Jjbrp7RNigAw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIP/FYJimDAvdKSUJ8zwZOWT15/QQ9H+iLaYKPS1VnYYy5aYibb
	LmelmMpUi+JtU28pmgNNggcjGokCoikJPnjC6UPNqO8dnM9RHqfoBL7Xb2p1Gxx14WA=
X-Gm-Gg: AYBFou0Si3yTzdjNjKPq+HZ5mwORAXxBRcpGB+hsilRotCmSAEKnvkMtadBwcFSbWMD
	ir8EvgMjDVf8IqPAtNOmWv4BVybB/S2uCuPwOxksdtHhKPRna8DqfFbICSeCgd3Feld/Ld5v9Ma
	9Ag1u6RPuFVkfJFeSUMAcbYHUUnruzsxzPkhnQIX1Z5J1nqPzXnZNo3cXwJ8/DVz6QKQV3b4Mej
	GhCQCZoY2PodrMGzKWU79uZUYCUFfHAF4TtyNqcae+uiFIq26rH6g2a5Pzmz+bY6fgKR7hN8i9g
	Dh8l144jClD8SOmYoUiRBNXTLNOXKUGthXT+1iuJkQPG0tHhjUorq87VSfybEkV8+Z0oAJrb19K
	g9J38RTEP/tDayY3NxvLGXf6/0NEa9oz0WJaJaxVNv+RLXN6g4zTewkUa5ApLUbpZTfom06PXKD
	zVLCdDFkX2kEwk6lFSVp61CLmA/Blf8FPRMAwi6ygNytQkwsnRjdCqnTlwen7vknBsKQd1beGon
	Dupg6jZXy4=
X-Received: by 2002:a05:7301:78ca:b0:351:750d:dd3b with SMTP id 5a478bee46e88-3537dde75a7mr339836eec.4.1791496985629;
        Thu, 08 Oct 2026 15:03:05 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb5e9sm920601eec.20.2026.10.08.15.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:03:05 -0700 (PDT)
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
Subject: [PATCH net v2] net: do not let defer_count outlive an empty defer_list
Date: Thu,  8 Oct 2026 15:02:56 -0700
Message-ID: <20261008220256.1844072-1-jkain@nuro.ai>
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
takes the nodefer path without queueing, so the list never refills, and
the flush keeps returning early without clearing. Deferred freeing stays
off for that (cpu, node) until reboot, and cross-CPU frees fall back to
the page allocator, which is the contention deferral exists to avoid.

Two changes from commit 844c9db7f7f5 ("net: use llist for sd->defer_list")
combine to produce it.

skb_attempt_defer_free() increments before testing the limit and does not
undo the increment when it rejects, so a rejected free leaves the counter
raised with nothing queued.

The flush clears defer_count before llist_del_all() rather than together
with it under defer_lock as it did before. A remote producer that queues
between the two has its skb drained by that same llist_del_all() but its
increment retained.

That part is not cumulative: any later flush finding a non-empty list
clears the counter again, so lost increments do not build up across
flushes. Reaching the limit takes skb_defer_max - 1 queued increments
inside a single clear-to-drain window. At a small skb_defer_max that
needs nothing special. At the default of 128 the flusher has to be
interrupted or preempted between those two lines for long enough, which
is where PREEMPT_RT matters: local_bh_disable() does not disable
preemption there, so the flusher can be scheduled out at that point.

Once the counter is stuck at or above the limit with an empty list,
nothing lowers it again, and that half needs no race at all:

  sysctl -w net.core.skb_defer_max=1    # frees increment, then reject
  sysctl -w net.core.skb_defer_max=128  # does not recover

skb_defer_max has .extra1 = SYSCTL_ZERO and no .extra2, so 1 is settable.
From v7.1 on, 0 is safe because proc_do_skb_defer_max() flips
skb_defer_disable_key and the producer returns before incrementing. On
6.18 through 7.0, which carry the llist conversion but not commit
08dc30de1a40 ("net: add skb_defer_disable_key static key"), setting 0 and
restoring the previous value strands the counter the same way -- and 0 is
the documented way to turn the feature off. Recovering needs a
skb_defer_max above the accumulated count, which an operator has no way
to determine.

Drain before clearing, so the error can only under-read, is bounded by
the producers in flight, and self-heals on the next flush. Clear the
counter on the empty-list path as well, so no count can outlive an empty
list and an already-stranded counter recovers.

llist_empty() has already loaded that cache line, so the added read is
free; the unlikely() keeps the store off the hot path, where it would
otherwise bounce the line against remote producers.

Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Joseph Kain <jkain@nuro.ai>
---
v2:
 - Reworded the drift description: it is not cumulative, since any later
   flush finding a non-empty list clears the counter again. Reaching the
   limit takes skb_defer_max - 1 queued increments inside a single
   clear-to-drain window, and said where PREEMPT_RT actually matters
   (Eric Dumazet).
 - Noted that 6.18..7.0 strand the counter via skb_defer_max=0, the
   documented way to disable the feature, since they carry the llist
   conversion but not 08dc30de1a40 (Eric Dumazet).
 - Dropped the paragraph describing where this was first reproduced
   (Eric Dumazet).
 - Added Assisted-by.

Built for x86_64 and arm64, with and without CONFIG_PREEMPT_RT. On
v7.3-rc6 with skb_defer_max=1 and a cross-CPU TCP load, defer_count
reached 1918118 unpatched and did not recover when the default was
restored; with this patch it peaked at 1.

v1: https://lore.kernel.org/netdev/20261007180056.1394868-1-jkain@nuro.ai/
 net/core/dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 18dc88990510..043a7f9166a9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6938,10 +6938,13 @@ static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
 	struct llist_node *free_list;
 	struct sk_buff *skb, *next;
 
-	if (llist_empty(&sdn->defer_list))
+	if (llist_empty(&sdn->defer_list)) {
+		if (unlikely(atomic_long_read(&sdn->defer_count)))
+			atomic_long_set(&sdn->defer_count, 0);
 		return;
-	atomic_long_set(&sdn->defer_count, 0);
+	}
 	free_list = llist_del_all(&sdn->defer_list);
+	atomic_long_set(&sdn->defer_count, 0);
 
 	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
 		prefetch(next);
-- 
2.55.0

