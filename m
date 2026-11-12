Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470089;
	b=Fqd5xfj6W/YqLHs8d2u+DWdLqDIeUZQJ1KpCavxNBiA3b5ZprWKOxKsWgBwZ7SJqNXsK
	 1C4QUN56BIkZYm0AxmBm3DO7v6TWpqZC0ulzmWgjgsPdywQOBhsVzXfwU8gY/xnJFhQnz
	 DIIV814zDl2P1LoMfj+FWZG9WneIZE6IvPoxW6QoKcfMCgItNi6CLWTnpTlCK6gf0kW/+
	 GR05q9wkb2aYe4vAWUH/6XWrIj4AhYOYum7PVUpN8noeNIqiWvG0nOBrXoSD6HdzJouKB
	 XNTtk2yWQaMNj3rip+r18yCP6B1i0RITG04qJXnUURhhfLhidpyKSnOrL4GYxHo6jWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470089;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=GdumA+ui0I/vMjTxDpFdZJKUXAvfrXsIiU09rk2W+ug=;
	b=CgC2liRk6N5kpe9fWWvvK8PQ4vVEksspAPj2Tnr5Zt7P84v4LtfMGznmXC3NMCM6QFKF
	 To1o7y6j3sGKQj36PCff9UXC8aDgd5c9RIM1FBbxwEgC88DhNRdljr28685ChQodDq9GU
	 5VI11+d4PxghsslA+74kroq1a8l3JpbjkCzfK6/xXffjYW5zgBlMYNKjDR24kVsMb6qxO
	 LqUQTRDTybmClDi3Hjofn2yEPcSqFHs0ojCj3ihoZVSVphjx8jSBGrCO0XaUvH3vokj5C
	 seMGAGEf6lPTZTD5UIrdkm38HrTi5XuOHB1ixja5eou9vLNVKkSVF5+mbJ4vKNXuhUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bdbMLUmv;
	arc=none smtp.remote-ip=95.215.58.87
Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD939606A31C
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 07:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD939606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bdbMLUmv
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=rSgeVwXMercvODJ72G3zhDYUS9M8zGweOiCTfF7t/NY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794470086; v=1; x=1795074886;
 b=bdbMLUmvQLDrQjWK1TBfZjUyR+Rhi+ATuqyudmImffUxetHNHCO9eN5cAzPnJDo+LLnO/tPG
 00y8AkC4EPQsq32qH7ejzPx6rnnVUSZdHjBmvutFAO23M1rQLv9xUp+uAe67V6CH/G0T7lPCAQs
 QuJBf1lx1tEbXvO0Om3YBhEg=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id b042659b714d5ad4;
	Thu, 12 Nov 2026 07:54:46 +0000
X-Mizu-Trace-ID: b042659b714d5ad4
X-Migadu-Flow: FLOW_OUT
From: Troy Mitchell <troy.mitchell@linux.dev>
Date: Thu, 12 Nov 2026 07:54:33 +0000
Subject: [PATCH v2 2/2] irqchip/riscv-imsic: Complete vector moves without
 a timer
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-imsic-remote-sync-irqwork-v2-2-680f65b24ff6@linux.dev>
References: <20261112-imsic-remote-sync-irqwork-v2-0-680f65b24ff6@linux.dev>
In-Reply-To: <20261112-imsic-remote-sync-irqwork-v2-0-680f65b24ff6@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Troy Mitchell <troy.mitchell@linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7729;
 i=troy.mitchell@linux.dev; h=from:subject:message-id;
 bh=rSgeVwXMercvODJ72G3zhDYUS9M8zGweOiCTfF7t/NY=;
 b=owGbwMvMwCU2g/N9w09jE33G02pJDFlfC3Y2TVO2m1JxZEfmy6isj6d/flVtL7X45Mvgub3jm
 92lG7aJHaUsDGJcDLJiiizdD3i2FfhE2RYIFPrCzGFlAhnCwMUpABNJ4Gb4n7/yz6Jazw82iSUi
 S1nvMakaTqladfynx0+jz2L6i5Xn9jIyHDzhs9jF0LbeU1iLMWDREUPrdWkqH0sfc65i+Pr1LMt
 NHgA=
X-Developer-Key: i=troy.mitchell@linux.dev; a=openpgp;
 fpr=3FE5535CF1B0E658E57DB59BAE1C2FBEA7DB42E1

When a vector moves, the new CPU clears move_prev only after the old CPU
has released the old vector. If the new CPU syncs first, it arms a timer
on itself and retries a jiffy later. That CPU is often the one entering
idle and taking over the broadcast interrupt, with its tick already
stopped, so the timer is not programmed. The move then completes only on
the next interrupt of that CPU, which took up to 0.5s on an idle
SpacemiT K3. Until then the IRQ is still marked as moving and further
affinity changes of it return -EBUSY.

Let the old CPU queue the sync work on the new CPU once it has released
the old vector, and remove the retry timer. Wait only while the old
vector still points to the new vector, since a released old vector may
already belong to another move.

IMSIC synchronization no longer depends on a timer.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
---
 drivers/irqchip/irq-riscv-imsic-early.c |  5 +-
 drivers/irqchip/irq-riscv-imsic-state.c | 90 +++++++++++++--------------------
 drivers/irqchip/irq-riscv-imsic-state.h |  6 +--
 3 files changed, 37 insertions(+), 64 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 06726a062b75..06ee402d3f47 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -96,10 +96,7 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long local_id;
 
-	/*
-	 * Process pending local synchronization instead of waiting
-	 * for per-CPU local timer to expire.
-	 */
+	/* Process pending local synchronization first */
 	imsic_local_sync_all(false);
 
 	chained_irq_enter(chip, desc);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index f6373e4019a2..36f4b7ede76a 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -125,11 +125,24 @@ void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend,
 	}
 }
 
-static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
+#ifdef CONFIG_SMP
+static void imsic_remote_kick(unsigned int cpu)
+{
+	struct imsic_local_priv *lpriv = per_cpu_ptr(imsic->lpriv, cpu);
+
+	if (cpu_online(cpu))
+		irq_work_queue_on(&lpriv->sync_work, cpu);
+}
+#else
+static inline void imsic_remote_kick(unsigned int cpu)
+{
+}
+#endif
+
+static void __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
 	struct imsic_local_config *tlocal, *mlocal;
 	struct imsic_vector *vec, *tvec, *mvec;
-	bool ret = true;
 	int i;
 
 	lockdep_assert_held(&lpriv->lock);
@@ -151,13 +164,13 @@ static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 		mvec = READ_ONCE(vec->move_prev);
 		if (mvec) {
 			/*
-			 * If the old vector has not been updated then
-			 * try again in the next sync-up call.
+			 * If the old vector has not been updated then keep
+			 * this vector dirty. The old CPU kicks this CPU once
+			 * it has updated the old vector. A released old vector
+			 * may already belong to another move.
 			 */
-			if (READ_ONCE(mvec->move_next)) {
-				ret = false;
+			if (READ_ONCE(mvec->move_next) == vec)
 				continue;
-			}
 
 			WRITE_ONCE(vec->move_prev, NULL);
 		}
@@ -199,30 +212,15 @@ static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 
 			WRITE_ONCE(vec->move_next, NULL);
 			imsic_vector_free(vec);
+
+			/* Let the new CPU finish the move it may be waiting for */
+			imsic_remote_kick(mvec->cpu);
 		}
 
 skip:
 		bitmap_clear(lpriv->dirty_bitmap, i, 1);
 	}
-
-	return ret;
-}
-
-#ifdef CONFIG_SMP
-static void __imsic_local_timer_start(struct imsic_local_priv *lpriv, unsigned int cpu)
-{
-	lockdep_assert_held(&lpriv->lock);
-
-	if (!timer_pending(&lpriv->timer)) {
-		lpriv->timer.expires = jiffies + 1;
-		add_timer_on(&lpriv->timer, cpu);
-	}
 }
-#else
-static inline void __imsic_local_timer_start(struct imsic_local_priv *lpriv, unsigned int cpu)
-{
-}
-#endif
 
 void imsic_local_sync_all(bool force_all)
 {
@@ -233,8 +231,7 @@ void imsic_local_sync_all(bool force_all)
 
 	if (force_all)
 		bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
-	if (!__imsic_local_sync(lpriv))
-		__imsic_local_timer_start(lpriv, smp_processor_id());
+	__imsic_local_sync(lpriv);
 
 	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
 }
@@ -257,11 +254,6 @@ static void imsic_local_sync_work(struct irq_work *work)
 	imsic_local_sync_all(false);
 }
 
-static void imsic_local_timer_callback(struct timer_list *timer)
-{
-	imsic_local_sync_all(false);
-}
-
 static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu)
 {
 	lockdep_assert_held(&lpriv->lock);
@@ -273,20 +265,17 @@ static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu
 	 */
 
 	/*
-	 * A remote CPU may have stopped its local timer and be waiting for
-	 * the broadcast interrupt whose IMSIC state needs updating. Use an
-	 * IPI-backed work item so enabling that interrupt does not depend on
-	 * its delivery. An offline CPU synchronizes IDs in imsic_starting_cpu().
+	 * A CPU that is not the current one is updated through hard IRQ
+	 * work so the update does not depend on a timer interrupt, which
+	 * may itself be the interrupt being updated. A sync that has to
+	 * wait for the old CPU of a vector move is completed when the old
+	 * CPU kicks this CPU. An offline CPU synchronizes IDs in
+	 * imsic_starting_cpu().
 	 */
-	if (cpu_online(cpu)) {
-		if (cpu == smp_processor_id()) {
-			if (__imsic_local_sync(lpriv))
-				return;
-			__imsic_local_timer_start(lpriv, cpu);
-		} else {
-			irq_work_queue_on(&lpriv->sync_work, cpu);
-		}
-	}
+	if (cpu == smp_processor_id())
+		__imsic_local_sync(lpriv);
+	else
+		imsic_remote_kick(cpu);
 }
 #else
 static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu)
@@ -514,8 +503,7 @@ static int __init imsic_local_init(void)
 			goto fail_local_cleanup;
 
 #ifdef CONFIG_SMP
-		/* Setup lazy timer for synchronization */
-		timer_setup(&lpriv->timer, imsic_local_timer_callback, TIMER_PINNED);
+		/* Setup IRQ work for remote synchronization */
 		lpriv->sync_work = IRQ_WORK_INIT_HARD(imsic_local_sync_work);
 #endif
 
@@ -557,14 +545,6 @@ void imsic_state_offline(void)
 	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
 	irq_matrix_offline(imsic->matrix);
 	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
-
-#ifdef CONFIG_SMP
-	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
-
-	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	WARN_ON_ONCE(timer_delete_sync_try(&lpriv->timer) < 0);
-	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
-#endif
 }
 
 static int __init imsic_matrix_init(void)
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index a36b9f0ef840..0bc4dccac238 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -11,7 +11,6 @@
 #include <linux/irqdomain.h>
 #include <linux/irq_work.h>
 #include <linux/fwnode.h>
-#include <linux/timer.h>
 
 #define IMSIC_IPI_ID				1
 
@@ -35,11 +34,8 @@ struct imsic_local_priv {
 	unsigned long				*dirty_bitmap;
 
 #ifdef CONFIG_SMP
-	/* Remote synchronization must not depend on a timer interrupt. */
+	/* IRQ work for synchronization from other CPUs */
 	struct irq_work				sync_work;
-
-	/* Local timer for synchronization */
-	struct timer_list			timer;
 #endif
 
 	/* Local vector table */

-- 
2.56.0

