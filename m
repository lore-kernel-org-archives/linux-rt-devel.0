Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10C531B0E
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081358; cv=none; b=Fe3JNAbco9YcHI88DxdzqJF6d87xJSpHEIfw7z2fOuEG8Dxc2ueSKP0QU5ngC8QEGtsTN3kq1HMnsVVLYCdLBTkOS80UwGfSGDxCXYwhl1fywVaMkJ0U1ff6FE1oFKNYoYOjnfz+yOEoWyRUNw5G9Xa7s0uC0jVpg2u8po2VRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081358; c=relaxed/simple;
	bh=pBy1f4VSb3pvW4clcyc1Qy/2nViC1kPB548ufIhq5H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZEPlaRmqTmC0aqSCbDVb1Pp2s77V1Sidf1beJJeLXY4YKLVx2XU2Z6kCqi3IJ/OswJg5rg6sXAvdvcxEyI1Z/MYhnM74qhu2vUTF8EFUVOIy/frW2a1bJd52kmFYjoKsbKpvdladdqxnnhekdavMBFRHNRMY4Ty0kI/l91zPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=XnFfw9Sd; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="XnFfw9Sd"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15756f82e8aso90208c88.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1792081345; x=1792686145; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VxoANqrdqE06En2I4F3G1u8hzDyBoOsiup8bgRwGeec=;
        b=XnFfw9SdZSK+uxc5mkD60TwoKtkUQbI0ICVBCzHkHeQuped0pbLhs4In3LYU4CffN+
         RgKzYMNunlfc6su1WVz4QllegY3pdY1vbmUf7C/qJCEvRbp9AVpZPJ49L1q4YoJzRe5G
         +KXX3/z/5i0CX2OnxRcU8cdKHvyNwLMdaXgA7bOcjDectlg9XAiiJwYheDqQi1d3gNbp
         pf9vxXomhlHC0YRPFncR3s694+rhoJthG9jVTN1wEIcNbl606aJ0Y7dVa3YMHRprX4cY
         yoNlEFo93EVwTH7DEQt/9NU6s2LDJxZ8KJ6/5oeTepp0nmE5RzbzeChZGoYYIpGBQHqv
         3eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792081345; x=1792686145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VxoANqrdqE06En2I4F3G1u8hzDyBoOsiup8bgRwGeec=;
        b=mLxcwmz3XNDwsfy74TYWq+T3Q8xDGJAwS3itx2utmnukPxGt1b/5be90FYyN+SGjSQ
         a7JWnQuMRyReheTFppxbkcccTplByi4Mx5k9SgGSgKsp4G6FuPHX9cS8/yBXg/nI/vuY
         n5IaNSSdlrLu3E9zwZhIsFWJgau9ZqFQdlnLBP0U3vReh3AicZD6b9Z0WZecdOA+ydxw
         cbidp8ztVwARyjmJwBhRRifacModrLf1lg+GJ5GezxJBqbYMs/MJ7XdBG21OCbjxtqqN
         5zz/RVOcVX6WzyRDEMR74RTP+3rFbK9gWzZSEb+JiH2q63uo2fg3fuRw7w3/sOlaoSzc
         DieA==
X-Forwarded-Encrypted: i=1; AKwUvBxt0LR5dScBu27j2kBlVqFOmM3JjYdtAyCzoItfuxGK4rlRt34qvmIuvxJowGsT8meAL6yEd2qttxTP0acYhQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYK6LRToBHJ/ayz3S85q75p+17AlRIcTgMyUTQytXXuW01ErchgX
	Jg/SGp0NXc12dKN0IIrjcMYhW7dynU8fYLfIgbaXeY0INz2gc8VdY1efwEj0qY41OG0=
X-Gm-Gg: AYBFou2c1o5C9slPULLyAg7A0GXjKZrBLjQoCma2z0C1l9ZgF7P695pwudBPZo3P881
	JKnAfa57wSpQmFplBeuU8gh8c7GBeAYde7Z9XUITsAfrSMnyE9kkY1b/oFRk7l7D/pBoO4RYBKd
	qo+l0z9mQLHYAswLFioyC0bCW+WP5kdqtfd6lSADDs/KcbkejNtzjic0Wf527C4gvv3ZrWuk4B3
	v3M1AcTPRibumnNItGFxC0oFdl0/JMXRxMCbiwbxa8wZS7jaagVPjgFCbqNGO5S8snsmsIFHq3A
	u3O6fa+E9Wf4fNCwQoJX+VBzMFCSzkM1yTJA7VB3Kl97oIOZsxVEJv5G/mPWpduX9E4CZxI7Fe8
	Mom9ScxwRR7tL3blvsYLkpfV7BttwqxAJk5RmMmRvB7ixiQY/1OF/9Y7tmoEnYAn0wzddbHLcqo
	f2peAkezkNEhREAYhjz574OX03MMEY2TGRrfEapIRDJnxYtzbyNghPlEyrHJPU0geiFq0f3I/b1
	ytQxNiJthY=
X-Received: by 2002:a05:7022:b882:b0:13c:d071:f97c with SMTP id a92af1059eb24-18251e3f05bmr523257c88.11.1792081344438;
        Thu, 15 Oct 2026 09:22:24 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-182a6d6969asm23010c88.12.2026.10.15.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:22:23 -0700 (PDT)
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
Subject: [PATCH net v4] net: do not let defer_count outlive an empty defer_list
Date: Thu, 15 Oct 2026 09:22:09 -0700
Message-ID: <20261015162209.485940-1-jkain@nuro.ai>
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

Test the limit before incrementing, so the counter is only ever raised by
a producer that goes on to queue. It then cannot outlive the skbs it
counts, and the absorbing state is unreachable without depending on a
flush ever running on the owner CPU.

This makes the limit advisory. The test no longer reserves the slot it
checks, and the recvmsg callers run in preemptible context, so the
overshoot is bounded by the number of producers in flight rather than by
skb_defer_max; the post-increment test reserved the slot and bounded the
queue exactly. The counter is already approximate -- the flush zeroes it
without regard for producers in flight -- and the next flush erases the
overshoot, where the latch it replaces never recovered at all.

Undoing the increment on the reject path instead would be wrong: a flush
that zeroes the counter between a producer's increment and its undo
leaves the counter negative, and the producer's local is an unsigned
long, so every later test reads it as enormous and rejects. That is the
same dead end, reached more easily.

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
v4:
 - v3's "undo the increment on reject" was wrong: a flush that zeroes the
   counter between a producer's increment and its undo leaves the counter
   negative, and the producer's local is an unsigned long, so every later
   test reads it as enormous and rejects forever. Test the limit before
   incrementing instead, so there is no decrement to underflow
   (netdev-bot sashiko).

Note this changes the effective limit from skb_defer_max - 1 to
skb_defer_max, because the test now runs before the increment rather than
after it. That matches what Documentation/admin-guide/sysctl/net.rst
describes. It also means the half-capacity kick can now fire at
skb_defer_max = 1, which commit c09b0cd2cc6c ("net: avoid strange
behavior with skb_defer_max == 1") set out to make possible.

Built for x86_64 and arm64, with and without CONFIG_PREEMPT_RT. On
v7.3-rc6 with skb_defer_max=1 and a cross-CPU TCP load, defer_count
reached 1918118 unpatched and did not recover when the default was
restored; with this patch it stays within the limit.

v3: https://lore.kernel.org/all/20261013205416.3417296-1-jkain@nuro.ai/
v2: https://lore.kernel.org/all/20261008220256.1844072-1-jkain@nuro.ai/
v1: https://lore.kernel.org/all/20261007180056.1394868-1-jkain@nuro.ai/
 net/core/dev.c    | 5 ++++-
 net/core/skbuff.c | 9 ++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

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
index 4aea06d5167d..25f82b7dcf01 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7386,11 +7386,14 @@ nodefer:	kfree_skb_napi_cache(skb);
 	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_node(my_cpu);
 
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
-	defer_count = atomic_long_inc_return(&sdn->defer_count);
-
-	if (defer_count >= defer_max)
+	/* Test before incrementing: the reject path returns below without
+	 * reaching kick_defer_list_purge(), so a kept increment never flushes.
+	 */
+	if (atomic_long_read(&sdn->defer_count) >= defer_max)
 		goto nodefer;
 
+	defer_count = atomic_long_inc_return(&sdn->defer_count);
+
 	llist_add(&skb->ll_node, &sdn->defer_list);
 
 	if (unlikely(!cpu_online(cpu) || my_cpu != raw_smp_processor_id())) {
-- 
2.55.0

