Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561262080D9
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356593; cv=none; b=WYK7B++dIzuHD4HWV/bv/rYoHbtGdVkDaLumjbr91XEYYr/loc6uOibuwuVj+9d8TaTztB+PIJxstDMzG5D02UosFwbHTxeYBW/yvPQ964hzqI99sRjMa7zi7TghZnA9HyGxfZRodW4/RmcF5h/QGVME3g6Mh+IGGUeEy/droiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356593; c=relaxed/simple;
	bh=EIpYAhIq9NNYuXKRKrzmwNFmlbVg4UQ/2hUVkjXh0Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLbNpFxMiVUtNYcAcSfKdkcekuY5lrbD/ENVfWZc5IJMmlNrXZOI8E54tIJZusvftHfPgi/USzfzUwD2kiJ4xoj6QKL7LPFCV1Mw6u6R3sCffa8+7rrU+V8joBCOkWxMdRh8Mu8XZtWxySyI5VW9Oeh/jBVsdmEwthvW2/tfiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odhJFPuc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9P/fYWQz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odhJFPuc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9P/fYWQz"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739356584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJW3NSnH6JLJPW1kGy+sRGD72uADSV9Hs0Zlg+mi+gs=;
	b=odhJFPuc321yWuJmSm0mDNmKSUUAmFEI6gA+uCkcvAFfG+RYX6epWO388u5F8g1IgoB6tx
	WuoLu4bef2olSj5C2fDYP9z51d4SR4w2P0USDMhyODyAvlA0mflAFtyb3O/PCw4TYNPUkX
	JDLtqsIz9YhlTBHnFxMAd5xbRtyOzKFD5U7BXQj26z952Mla+s9lLfKPYh7quBmX8UFpph
	wfdkaaFD+PJZ8X6R8HohNCLUjduOfPH+VpuljbtP9Cvj/sjYeIH3k5XUaRMDgkYr2LGThf
	rp+OfV7sQQBC4Zgbi/RSbbhgaxjRSSYRkIcKY743eeXIDNwuqgB9TFDtntgg3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739356584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJW3NSnH6JLJPW1kGy+sRGD72uADSV9Hs0Zlg+mi+gs=;
	b=9P/fYWQzxKMPrs0ZH1P7Tmrv6wC0xJNbrBoK/B+rSzWnoKqsmlS8aKmp2ZvvDEWYzPC3Xx
	WBXz7DoIvXPaILBg==
To: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()
Date: Wed, 12 Feb 2025 11:36:18 +0100
Message-ID: <20250212103619.2560503-2-bigeasy@linutronix.de>
In-Reply-To: <20250212103619.2560503-1-bigeasy@linutronix.de>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250212103619.2560503-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

disable_irq_nosync_lockdep() disables interrupts with lockdep enabled to
avoid false positive reports by lockdep that a certain lock has not been
acquired with disabled interrupts. The user of this macros expects that
a lock can be acquried without disabling interrupts because the IRQ line
triggering the interrupt is disabled.

This triggers a warning on PREEMPT_RT because after
disable_irq_nosync_lockdep.*() the following spinlock_t now is acquired
with disabled interrupts.

On PREEMPT_RT there is no difference between spin_lock() and
spin_lock_irq() so avoiding disabling interrupts in this case works for
the two remaining callers as of today.

Don't disable interrupts on PREEMPT_RT in disable_irq_nosync_lockdep.*().

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/760e34f9-6034-40e0-82a5-ee9becd24438@roeck-=
us.net
Fixes: e8106b941ceab ("[PATCH] lockdep: core, add enable/disable_irq_irqsav=
e/irqrestore() APIs")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/interrupt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 8cd9327e4e78d..a1b1be9bf73b2 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -448,7 +448,7 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned=
 int maxvec,
 static inline void disable_irq_nosync_lockdep(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_disable();
 #endif
 }
@@ -456,7 +456,7 @@ static inline void disable_irq_nosync_lockdep(unsigned =
int irq)
 static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, un=
signed long *flags)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_save(*flags);
 #endif
 }
@@ -471,7 +471,7 @@ static inline void disable_irq_lockdep(unsigned int irq)
=20
 static inline void enable_irq_lockdep(unsigned int irq)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_enable();
 #endif
 	enable_irq(irq);
@@ -479,7 +479,7 @@ static inline void enable_irq_lockdep(unsigned int irq)
=20
 static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigne=
d long *flags)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_restore(*flags);
 #endif
 	enable_irq(irq);
--=20
2.47.2

