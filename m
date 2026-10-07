Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A4F4D794C
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Oct 2026 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396201; cv=none; b=DXTsYGShVH3y2ZmuIwLr8dJld1/gD3EJINJHlgwCooWei3BoLrTgI2SPMghxUR/l2y95WbU0gIjzU3y4AYiEqGh1b1Rw1kUsBCtQus3Oj+QHWvWBAg2aqoZxG7o7MU0XvMLg+dM+NnngNb1Bs7Rl26vvNzsJZb/5t6mdYlBZ/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396201; c=relaxed/simple;
	bh=Ltv/RLIwQoMYY8n388CV2rbSvSpwVLlUtRxsUfEVhTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dajLheYHOPmcRVowRJkSCe7HTClrQ5NVon4CKfpqXEBuwKhze5jrye6D8eDppPUIGpQj6fVO6XdWItVkCGX0o7G1Mp3Zz8fG+45xvwy5XIIUlJRQ8GunGalxWBBM7hxQ3mpr/8qH9jjIBJiA4wtdKeyrqnlA6TTtWhKYD4rJROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=gtWPRd73; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="gtWPRd73"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15354aa70e8so142407c88.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 07 Oct 2026 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1791396198; x=1792000998; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qgm5+nCeTJXdCx0TLpkqzAsPIchFKXrgB4ZQJsFcySE=;
        b=gtWPRd731Dq3L8gro7nwk0SDRY+tuZMUhBvmSZCaJINcvZn5fwzCxSvjm6Q7Zqud02
         zgmKqE1W05eltIzIuiSzHnzeh2ZryfciJU/ueCjTx44MmuHyS0ZGe1dKepIMKc+Uh/Y5
         FX/O7QnbXldIbnbGKznxrho9CR5sJQvWhYlpqXxyjWAgPIoZEI8SNmx4XHgq55YR9+Ho
         vAC12EpiL0CS18Ze798knSl0z8LZ/H6gKQUlneNFwzWl1/lk1H+l1KTX+ob7urfJqhFQ
         SgVlqtHzzjmAovXOv5z52KVhWNY66mNUJLKFmv0rlX9ZIAodKNSuZZMBX8z6zJKlsLLC
         fEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396198; x=1792000998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgm5+nCeTJXdCx0TLpkqzAsPIchFKXrgB4ZQJsFcySE=;
        b=KPM4YpnK4utDTnI5/X6MwhGAIPhfCExor7FY/L6kbR5K19Nxx8/xDEMtyySwW6B/hz
         uEDrIw4XEV9cjFWTZGKx6BcHrkUujATEEUOQVORZniby3z3orAdZKSAY5H5AvqdTXpqw
         aVMoOWd+Xm3o7HHa5G0/swpKKku7a2KyXp2rumlrp+DN33RlQ4F5VuVpPFODwXTXTKv3
         OG91C4BIv9icYnjokZUMuVCQmXUvNmQUjL/tsH3v7afNLJvmGgy1B+6uTHQTTSo8/npi
         BJHX1pZpna3F9JgVvLelkY9sxjs/XYte/EUSsr6IThvh3ScFsQLmWfQvT+X4WFB6SeX1
         lRzA==
X-Forwarded-Encrypted: i=1; AKwUvBwgk225QjbmNoTUefzQ3eK4gs5viiRBgaHySCmeQANpvBwMvwGhkpodCll4vNHoXleupxTAtz8DVZ6bSoNINQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lOFR0XAUN1uyL5JMHp9pDCbnoSMh5fCqTNCkmfP913UwoqpES8
	Yt2yBAPcnZCzgnDv9Mf/R8+fq/pxnASJSNrVgCl1cnNej60gryOnxvQrc90OHsj6ZQs=
X-Gm-Gg: AYBFou2mZdG26jMYPTtZBkkWhUIm27ut7NlMskeJPccNB4Z7nChgAmpW+qzYZSLeoFM
	0n9ZeguN42eXRBLsiiyXf3slujkSiQ+I6h0wMjQuGIb3TPyNyG5/+htCVcO7wKw5soj1zfUAKHc
	GfgDiyT62NKXQDhsyvFJcngIzwFkUBUTim+qz/YYq8W8EO8K/aT49YEiwBRm5ruqzVoHziEYC6Z
	cxNNx/N0FUc+b7AtD+2ZJ2wdSGkIJtedV6T+Vtf56tH9HSzixZEm6Sc842TpOqHkXQKUDOpYEP1
	kxMN+YCGGBT2V0TUVAUStGd+WsarOI8sHA3CiMnWxfnKmcOpeHHXs6fd4KvXXFrhH1EtMfzcNJj
	yk/Rid3rjft6rwSJvlAhSoMNE1MKa/a9fG7xyLLvULK2SjeQAsoocFpA7pKgyLscT41zYZKaBjL
	NNxUzvoUArWvvVU4/F1mCnhQCIdPS/x6Xi4lpLvzit3saOARb5jJi+8K1H/Es9sq7kuWIy7juR3
	4fWmBvZO38=
X-Received: by 2002:a05:7023:a56:20b0:148:4522:560c with SMTP id a92af1059eb24-16205bcce04mr3445142c88.11.1791396196809;
        Wed, 07 Oct 2026 11:03:16 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616602b33asm7842425c88.3.2026.10.07.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:03:16 -0700 (PDT)
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
Subject: [PATCH net] net: do not let defer_count outlive an empty defer_list
Date: Wed,  7 Oct 2026 11:00:56 -0700
Message-ID: <20261007180056.1394868-1-jkain@nuro.ai>
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

skb_attempt_defer_free() now increments before testing the limit and does
not undo the increment when it rejects, so a rejected free leaves the
counter raised with nothing queued.

The flush clears defer_count before llist_del_all() rather than together
with it under defer_lock as it did before. A remote producer that queues
between the two has its skb drained by that same llist_del_all() but its
increment retained, so the counter drifts upward until it reaches the
limit.

Neither needs PREEMPT_RT. The drift needs no preemption at all: the
flush normally runs in NAPI poll on the CPU that owns the list, while
skb_attempt_defer_free() only ever defers to a remote CPU, so producers
cannot be excluded by disabling preemption on the flusher. PREEMPT_RT
only widens the window, because local_bh_disable() does not disable
preemption, so the flusher can be scheduled out between the clear and
the drain.

The latch is also reachable with no race at all:

  sysctl -w net.core.skb_defer_max=1    # frees increment, then reject
  sysctl -w net.core.skb_defer_max=128  # does not recover

skb_defer_max has .extra1 = SYSCTL_ZERO and no .extra2, so 1 is settable.
0 is safe, because proc_do_skb_defer_max() flips skb_defer_disable_key
and the producer returns before incrementing, but that guard covers 0
only. Recovering from the latched state needs a skb_defer_max above the
accumulated count, which an operator has no way to determine.

Drain before clearing, so the error can only under-read, is bounded by
the producers in flight, and self-heals on the next flush. Clear the
counter on the empty-list path as well, so no count can outlive an empty
list and an already-stranded counter recovers.

llist_empty() has already loaded that cache line, so the added read is
free; the unlikely() keeps the store off the hot path, where it would
otherwise bounce the line against remote producers.

Found on an arm64 PREEMPT_RT system running the two commits backported to
6.1. With skb_defer_max lowered, defer_count reached 788,888 on one host
and 122,399 on another with the list empty throughout, and restoring the
default did not re-enable deferral.

Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
Signed-off-by: Joseph Kain <jkain@nuro.ai>
---
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

