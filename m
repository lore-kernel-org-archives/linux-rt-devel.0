Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50D21D3F5
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 May 2025 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384669; cv=none; b=AjT74LTpPBOS6UQ6Gom3m+HjUTA6DVcO6FKdnV990zW0NKV+EspWvhzjcBDf+Vml708xyBBT6g0TiaN2v54HsYiidLFsKUGgcIvz1MI7WwwlOr80us8EtUMunIwZaXBqzfo0lSMqL291MA0ZTRPKBPC4c/4hyHiRuAA27pDbpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384669; c=relaxed/simple;
	bh=dsaaq539ASGElsdDblRiI+bymC9vwMFvF0DeSf6dfvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaVICev1oRgqvEG74V8mYGQH86dRUTIMQFUTzJd8DG/xXuVr74+YXJysKBYGJn6lCXoTpk361vEV3MXDk70qaqU5oAqdGl8YgOuJB/RlkGd40UGTkg4N3xANuwr7b/Rgp16BRC2iRaoETpWJTC3Sc+tM+M+TfEujyoP9W6W8hkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKWuUfO6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKWuUfO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748384665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfiYWSSZQP5GjInQFBdw+nv+9qskNJD1Z3HudCLoGME=;
	b=eKWuUfO65NlS7WZ3E6yKHOImOVUs1avWaRikeLr7kGVFADIw9BjJVnoWdBx3Z2ube11J7+
	fVLvzT5e/HUa2Z0BXX/QIsd3SdxNLZU4T029A0nEAmcGr3OKyN+ywSMNdnrzNEa5Oo/3cU
	DQ3imvcH4zrcGG6eV2Pd1XTtZIc4Woc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-_9YLQ1HqOPmojewD5IqzGQ-1; Tue,
 27 May 2025 18:24:21 -0400
X-MC-Unique: _9YLQ1HqOPmojewD5IqzGQ-1
X-Mimecast-MFC-AGG-ID: _9YLQ1HqOPmojewD5IqzGQ_1748384659
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA5F8195608A;
	Tue, 27 May 2025 22:24:19 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.105])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC18A1956095;
	Tue, 27 May 2025 22:24:16 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Subject: [RFC RESEND v10 14/14] locking: Switch to _irq_{disable,enable}() variants in cleanup guards
Date: Tue, 27 May 2025 18:21:55 -0400
Message-ID: <20250527222254.565881-15-lyude@redhat.com>
In-Reply-To: <20250527222254.565881-1-lyude@redhat.com>
References: <20250527222254.565881-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Boqun Feng <boqun.feng@gmail.com>

The semantics of various irq disabling guards match what
*_irq_{disable,enable}() provide, i.e. the interrupt disabling is
properly nested, therefore it's OK to switch to use
*_irq_{disable,enable}() primitives.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

---
V10:
* Add PREEMPT_RT build fix from Guangbo Cui

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/linux/spinlock.h    | 26 ++++++++++++--------------
 include/linux/spinlock_rt.h |  6 ++++++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index b21da4bd51a42..7ff11c893940b 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -605,10 +605,10 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
 		    raw_spin_unlock(_T->lock))
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
-		    raw_spin_lock_irq(_T->lock),
-		    raw_spin_unlock_irq(_T->lock))
+		    raw_spin_lock_irq_disable(_T->lock),
+		    raw_spin_unlock_irq_enable(_T->lock))
 
-DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq_disable(_T->lock))
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_bh, raw_spinlock_t,
 		    raw_spin_lock_bh(_T->lock),
@@ -617,12 +617,11 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_bh, raw_spinlock_t,
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_bh, _try, raw_spin_trylock_bh(_T->lock))
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
-		    raw_spin_lock_irqsave(_T->lock, _T->flags),
-		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
-		    unsigned long flags)
+		    raw_spin_lock_irq_disable(_T->lock),
+		    raw_spin_unlock_irq_enable(_T->lock))
 
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irqsave, _try,
-			 raw_spin_trylock_irqsave(_T->lock, _T->flags))
+			 raw_spin_trylock_irq_disable(_T->lock))
 
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),
@@ -631,11 +630,11 @@ DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 DEFINE_LOCK_GUARD_1_COND(spinlock, _try, spin_trylock(_T->lock))
 
 DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
-		    spin_lock_irq(_T->lock),
-		    spin_unlock_irq(_T->lock))
+		    spin_lock_irq_disable(_T->lock),
+		    spin_unlock_irq_enable(_T->lock))
 
 DEFINE_LOCK_GUARD_1_COND(spinlock_irq, _try,
-			 spin_trylock_irq(_T->lock))
+			 spin_trylock_irq_disable(_T->lock))
 
 DEFINE_LOCK_GUARD_1(spinlock_bh, spinlock_t,
 		    spin_lock_bh(_T->lock),
@@ -645,12 +644,11 @@ DEFINE_LOCK_GUARD_1_COND(spinlock_bh, _try,
 			 spin_trylock_bh(_T->lock))
 
 DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
-		    spin_lock_irqsave(_T->lock, _T->flags),
-		    spin_unlock_irqrestore(_T->lock, _T->flags),
-		    unsigned long flags)
+		    spin_lock_irq_disable(_T->lock),
+		    spin_unlock_irq_enable(_T->lock))
 
 DEFINE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
-			 spin_trylock_irqsave(_T->lock, _T->flags))
+			 spin_trylock_irq_disable(_T->lock))
 
 DEFINE_LOCK_GUARD_1(read_lock, rwlock_t,
 		    read_lock(_T->lock),
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 6ea08fafa6d7b..f54e184735563 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -132,6 +132,12 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 	rt_spin_unlock(lock);
 }
 
+static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
+{
+	return rt_spin_trylock(lock);
+}
+
+
 #define spin_trylock(lock)				\
 	__cond_lock(lock, rt_spin_trylock(lock))
 
-- 
2.49.0

