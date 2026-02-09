Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11017284898
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Feb 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653846; cv=none; b=EgdK4+0VAaXicgY8QP8hlJU3l4cJJs3GUjNmUnCxw7ZydsWRilfidySMOAfPq2hZWg5XhvBybf8cJdRwfEg9MVMa2mv8ln3m+RgamNrNBmQ1vcBUdzVHmgg3sDxJuFEOraiwYg/IcYqfeonRl43l71CSgeLRqYwP54j0BxJEE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653846; c=relaxed/simple;
	bh=QLn9UJBSWT6jlcMbbaZa68IHkR+F3SHMyeahLxtfE60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iIjmlG5PrSuH4dGYoBjH46g7SgRjR2i0CiHxARQy0Ycytl2slRO0HhWjDkVlV46szUOQRQSZKMxRhI2zw79IuxfZuLA7PDzEVgru8EI0Nesq1WTmToKmKPXsztIQKmgj0yHnTUq4acDCKHOKKEBFaT3V9+8h5fljniTJzRdcR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORoB7KRY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORoB7KRY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a962230847so19958525ad.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Feb 2026 08:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770653845; x=1771258645; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fYDQcjBg2vU5GI5xW0lALxWdgLiVRXFArD5ZQ3GcGuo=;
        b=ORoB7KRYuZVv3F/6mBqOdYDvZSm10j2+ElsYnxT6YL6w8D9awQbBkZdriux0ZYBqPU
         Iym8WSgm8Su7K9KO4eAM7hwQPCgiofuORWUCY2Xpiv87vB9wiju2TXJ4LOlUiIRUMSPp
         oaUyLojrZ8JIQ7HNJ6sSzteXo284RihSdo0SZE37Qbn2Q0OcfFkWFBZa6lprZEQHRRLE
         jOEXgDsVkRyoQECgM8fe2Gpim4RzW0qew6wEnZQAk+QXeLn03ViAMr/spMSQiXaCIhWr
         sj+zId7KahXp34gfLthzWGgvwQ5HBrXOviGN6DEP2lYb0Eyob/0DBl2ymuvlAkgUpA8H
         qHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770653845; x=1771258645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYDQcjBg2vU5GI5xW0lALxWdgLiVRXFArD5ZQ3GcGuo=;
        b=r3gcwuG/1+y7KqTjKFg7yl+WU1NjoFDcRQ6vlmz+jwMnPKYZzMtdLbi8GQ6vX4rJpV
         AhKOYILVz80E8p46PyAxKDQIw16EyjaTf3wt1YNtRAG6RG5GsMnZ+8vj6ZO9Xxr618Yy
         riiv+lMWPiIjjoEZLTcA+MCiqe9mm/WYJtaLdDBj+zB8ZIbH3fRlSmqs5XW0s3WZs7op
         4flsoqJqpnGcpd0/NelGr8E/hilXijFf89uPJkbg4WT9VqOVek3sb7odgQ62J9eVbhhj
         d25/sx8iN0C5NtgiBeoO1ZBuBdE9YYuNBcS78Wm89TGmeg2EiBHCv4T/SIwvRuXI+SlM
         gwgw==
X-Forwarded-Encrypted: i=1; AJvYcCW9NJXb+ylcOw5rGY1cnSMqL0dhpNWB9Qtk7CtZqo9QFebbr5/I/gIaWIRbn0GC2tE0TmX3yHj5MAZ16FDrsA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyzhxawsi4CBfZ0F6QDsmiZE0Qim3iS1MmiD5Ihbi/MIGCJw4Kw
	1LlWp05qZCnwfcgV3Emd2eBaDuPU+deOwwrbGGOkIq1bhGfnZvFiQmBm
X-Gm-Gg: AZuq6aLLqXJal06H3ASnh5j2OlaaTq6vibsFYXCBO/h44jS3CczKMdLWF2ZTWWcjd0T
	7HzMBUaHj7Iqu1bIlF8E/jBOaUKkxakl9oG62oeuCiFaFbN8BnVl5jM76kxTuOiZwhfoIxO+IkK
	I1viI8Vrxus7x7SQ0Npzg8lqTe/IfNeMWuaJFSho74ND+a8WuYBYEDQAfHmRcWxL6BzP6stV9ai
	Y64X+xcHoFKFWu8dmW6EJOo1sI9BP+jl1x2D+gUowIfs67f9OgeoK1F6qGRyXtTk+poV6OqNpuv
	iwJZ7zgot2RnpW/M4Dpr7rJE3yrgnBJBzBx/0zYC2ZoB6JiM7a/MsToiARjC6OAL6hPhGYBr+dZ
	/PabYcJgfk1fcD2ExCpCEqCjF+SdUuYnxtXIex3NPfkW3ridCmCvg8k0g2zQQx2BFq3jLVE/yLx
	VGbNXz08qIgcdSf/J0ftvxpBvCP0LdFcj07lq34w==
X-Received: by 2002:a17:902:e54f:b0:2a9:6165:6e87 with SMTP id d9443c01a7336-2a96165754dmr82914955ad.59.1770653845268;
        Mon, 09 Feb 2026 08:17:25 -0800 (PST)
Received: from acer-nitro-anv15-41.. ([27.7.91.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a95bff42f7sm91648125ad.68.2026.02.09.08.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 08:17:24 -0800 (PST)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "shaikh.kamal" <shaikhkamal2012@gmail.com>
Subject: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping for non-blocking invalidations
Date: Mon,  9 Feb 2026 21:45:27 +0530
Message-ID: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmu_notifier_invalidate_range_start() may be invoked via
mmu_notifier_invalidate_range_start_nonblock(), e.g. from oom_reaper(),
where sleeping is explicitly forbidden.

KVM's mmu_notifier invalidate_range_start currently takes
mn_invalidate_lock using spin_lock(). On PREEMPT_RT, spin_lock() maps
to rt_mutex and may sleep, triggering:

  BUG: sleeping function called from invalid context

This violates the MMU notifier contract regardless of PREEMPT_RT; RT
kernels merely make the issue deterministic.

Fix by converting mn_invalidate_lock to a raw spinlock so that
invalidate_range_start() remains non-sleeping while preserving the
existing serialization between invalidate_range_start() and
invalidate_range_end().

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
 include/linux/kvm_host.h |  2 +-
 virt/kvm/kvm_main.c      | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d93f75b05ae2..77a6d4833eda 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -797,7 +797,7 @@ struct kvm {
 	atomic_t nr_memslots_dirty_logging;
 
 	/* Used to wait for completion of MMU notifiers.  */
-	spinlock_t mn_invalidate_lock;
+	raw_spinlock_t mn_invalidate_lock;
 	unsigned long mn_active_invalidate_count;
 	struct rcuwait mn_memslots_update_rcuwait;
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5fcd401a5897..7a9c33f01a37 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -747,9 +747,9 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	 *
 	 * Pairs with the decrement in range_end().
 	 */
-	spin_lock(&kvm->mn_invalidate_lock);
+	raw_spin_lock(&kvm->mn_invalidate_lock);
 	kvm->mn_active_invalidate_count++;
-	spin_unlock(&kvm->mn_invalidate_lock);
+	raw_spin_unlock(&kvm->mn_invalidate_lock);
 
 	/*
 	 * Invalidate pfn caches _before_ invalidating the secondary MMUs, i.e.
@@ -817,11 +817,11 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	kvm_handle_hva_range(kvm, &hva_range);
 
 	/* Pairs with the increment in range_start(). */
-	spin_lock(&kvm->mn_invalidate_lock);
+	raw_spin_lock(&kvm->mn_invalidate_lock);
 	if (!WARN_ON_ONCE(!kvm->mn_active_invalidate_count))
 		--kvm->mn_active_invalidate_count;
 	wake = !kvm->mn_active_invalidate_count;
-	spin_unlock(&kvm->mn_invalidate_lock);
+	raw_spin_unlock(&kvm->mn_invalidate_lock);
 
 	/*
 	 * There can only be one waiter, since the wait happens under
@@ -1129,7 +1129,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	mutex_init(&kvm->irq_lock);
 	mutex_init(&kvm->slots_lock);
 	mutex_init(&kvm->slots_arch_lock);
-	spin_lock_init(&kvm->mn_invalidate_lock);
+	raw_spin_lock_init(&kvm->mn_invalidate_lock);
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
@@ -1635,17 +1635,17 @@ static void kvm_swap_active_memslots(struct kvm *kvm, int as_id)
 	 * progress, otherwise the locking in invalidate_range_start and
 	 * invalidate_range_end will be unbalanced.
 	 */
-	spin_lock(&kvm->mn_invalidate_lock);
+	raw_spin_lock(&kvm->mn_invalidate_lock);
 	prepare_to_rcuwait(&kvm->mn_memslots_update_rcuwait);
 	while (kvm->mn_active_invalidate_count) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		spin_unlock(&kvm->mn_invalidate_lock);
+		raw_spin_unlock(&kvm->mn_invalidate_lock);
 		schedule();
-		spin_lock(&kvm->mn_invalidate_lock);
+		raw_spin_lock(&kvm->mn_invalidate_lock);
 	}
 	finish_rcuwait(&kvm->mn_memslots_update_rcuwait);
 	rcu_assign_pointer(kvm->memslots[as_id], slots);
-	spin_unlock(&kvm->mn_invalidate_lock);
+	raw_spin_unlock(&kvm->mn_invalidate_lock);
 
 	/*
 	 * Acquired in kvm_set_memslot. Must be released before synchronize
-- 
2.43.0

