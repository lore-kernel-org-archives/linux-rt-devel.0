Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AB415B8E
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183153; cv=none; b=kdTu6xDSatqhN2GCA+3cyvjSnYJGWFGu8g6Gz94mFbNWJWJ6j3BpVV1fjb1N+XZwUxPgpl/XiYXb3lEOmZWKBczV5JBWqgR0jOU8I6fpriMRhV9Lc+kgBbARx5HTK8baSdIAZ1WzGhHAaxa4PoYUjvyGNoUh9GeFhgYDa3T+lGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183153; c=relaxed/simple;
	bh=FcsM3/p9xXPCIEnRL+5Ei4+K1e041/Wv5iEDXKMcGc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uctoVfjRnRoaMO9op4sY9VxIAw7OHWTEbRkrj7oP4YkQvGIMZXL+zB/StNU5O24fttsVV0vMSUBPUAJkavo8XryE0Z8N2COKI29IzPIbY57rDwX9zXUteG7LzlsZ2/qfbTtTxpJK8+7rC4FZ3zigKfiuTotaByh1SslNvRgPVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krTeb+Pd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krTeb+Pd"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d715f4a587so49826535ad.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183150; x=1788787950; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iyuCMhGUpDra9S+DkJdLTa8SNwQ+om0mNosv5O74qg=;
        b=krTeb+PdyJYeN1LI8rD848/Tuv/LfpHTv6zVWxvEW8v08ZWKCLZ38ymQenCirqUiF1
         dAzej7dRlVLbihEJZgcUdm5vct39NXg4iIOBqBEE17cIaosy8NHQlmU6x1VlfPSPj9id
         v2XOKziUtvat5oPYDJihkCvCKhHYHS54lMZRZrTWQi0sQfjeecfhpViNeHVqYd1cwUcR
         /uz9kR+EqwoKGqhEAvIpbFXbWavOsCiQMB7YFJNdlJYPiGoN9PyRXup350hxmqmSxLR+
         ZllDvCejh+rZLH61qzNtzgA5osoxUTpyOQY8gh6EtCkd377rUkyLjQSocKHQWIbWTtVC
         9N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183150; x=1788787950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8iyuCMhGUpDra9S+DkJdLTa8SNwQ+om0mNosv5O74qg=;
        b=dbKLmVP919JRih+dx7a+MXy4LsTx4Z3ueIWQIQPyBg+1kz73BlV3MhN7tJ+krJmu3Z
         KqGM8Ncvf7PWSZgPeXjNYgMcaoLu6wCxDFbpQ2ctUXKSoXoTCJPQz+rJp5vFVCMseyOB
         0a6O18lgFytId6XueoHfiVxtZWAajrGoACavyLp5VBt/ib+zw0gWyg/7Fcos5AsFVaQW
         ODB2I9SB2mfJwqPBKy98xS+0Xy9Ec0fwMR0IRFIdrSdyJSpQfGUOVciidicGr87lj9Ct
         fM1ylwLtRe7UdiyRFxgL3iMFcfmVw6rErSXLUezp7lnwl1OW5UFyrpnM/4V8qzaPgyqK
         Yszg==
X-Forwarded-Encrypted: i=1; AKwUvBxl6JbNtEcZL6+Wr+X3Ow1LL6XH1XVEleF1008Ca1d3dwmP/R6E0kHpyVCHE2Q8m8X7a/fry9WYGZUshzco1w==@lists.linux.dev
X-Gm-Message-State: AFuF++kfdpEcJaOBhhd3uf8mM500I8MqEQkgm/ZPhkt2Vj9oCeNm/mJ4
	2guvc1c4frLGh8U5fdhiN69Z4FzUm+/+Whp5GL/pysE/I5t5wsL1JYM1
X-Gm-Gg: AYBFou126zoABJOZumgESE+p9c0jKF+3TOuAm4qgDJ2YcZuZfAdyzXEQQ0zLblUrupY
	XP8l5lKJyX5OhjvwBFZG01zCyJFNRGMJWLnz9nKzJaoxxEJH+ycTtEKpscejdf8RC8B9pn8cmxB
	qfwffM+efCxEKrR9s5WVa7/vcJx0UvobtS2Iz79sYRNT8COsQRP7z/hxEEG74WNnvHtA/kdWwUr
	nrDFweHW0lUxrXfCbCWHY5CdB1F/ux3EayksxPFKSmulyjyAWj6A0EurRIalul38QSYk1C00zDo
	922JGXQzA0GChh498Rf2XGXZM7J8Mu1g8OKz60jp3TI6JwNgNfg9B2a+/Vqq1cYF1kD8xMeM9HV
	Hnu344r8afJ/jWhLrIsUnldI/ylxjcnTNGRRYvVa1D930R5ZVvW0Fijs8gjfJl0QzEdgJw0awxy
	zHs9NvSZRNcJA5cIII9E9Qoc7GA43V5YGR9BO4E8fDqdeMWb/jDLK1n7FXfkiyV2paka7viP6f2
	7qt6Yw=
X-Received: by 2002:a17:903:2a8b:b0:2d7:1cee:3682 with SMTP id d9443c01a7336-2d74dc21e53mr406131505ad.5.1788183150392;
        Mon, 31 Aug 2026 06:32:30 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:21dc:72d0:50b1:2f22:32bb:703])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7598b8829sm36684125ad.73.2026.08.31.06.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:32:29 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ThangNN99 <ngocthang2710.1999@gmail.com>,
	syzbot+acf142088e0182172e58@syzkaller.appspotmail.com
Subject: [PATCH v3] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in kvfree_call_rcu()
Date: Mon, 31 Aug 2026 20:32:22 +0700
Message-ID: <20260831133222.8637-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831130057.HLukQ-zm@linutronix.de>
References: <20260831130057.HLukQ-zm@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a possible circular locking dependency between
&p->pi_lock and the per-CPU kfree_rcu sheaf lock (_T->lock) on
PREEMPT_RT:

  __balance_push_cpu_stop()               [holds p->pi_lock]
    select_fallback_rq()
      cpuset_cpus_allowed_fallback()
        set_cpus_allowed_force()
          kfree_rcu(ac.user_mask)
            kvfree_call_rcu()
              kfree_rcu_sheaf()
                __kfree_rcu_sheaf()
                  local_trylock(&s->cpu_sheaves->lock)   <- _T->lock

set_cpus_allowed_force() uses kfree_rcu() instead of kfree() here
because all of its callers hold task_struct::pi_lock (a
raw_spinlock_t), and plain kfree() may sleep under PREEMPT_RT.

Commit 2a8bb29ec9b2 ("mm/slab: allow kfree_rcu_sheaf() on
PREEMPT_RT") made kvfree_call_rcu() try the sheaves fast path on
PREEMPT_RT too, since __kfree_rcu_sheaf() only trylocks there and
so cannot itself block. True, but the sheaf/barn locks it trylocks
are also taken as regular, blocking locks elsewhere, so lockdep
still records a lock-class ordering cycle against any raw_spinlock_t
already held by the caller, which is what syzbot caught.

The plain kfree_rcu()/kvfree_rcu() API gives kvfree_call_rcu() no
way to know the caller is in such a context, so keep it
conservative on PREEMPT_RT and skip the sheaves layer there,
falling back to the existing raw_spinlock_t-protected krcp list,
which is always safe to nest under another raw_spinlock_t. This
restores the pre-2a8bb29ec9b2 behavior of kvfree_call_rcu().

kfree_call_rcu_nolock(), added later in commit 3bc999d944b3
("mm/slab: introduce kfree_rcu_nolock()"), is untouched by this
patch. Note it would not be a safe substitute here either: it still
reaches __kfree_rcu_sheaf()'s local_trylock() on &s->cpu_sheaves->lock
unconditionally, so a caller already holding a raw_spinlock_t would
hit the same lockdep ordering cycle through that path too.

Reported-by: syzbot+acf142088e0182172e58@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=acf142088e0182172e58
Fixes: 2a8bb29ec9b2 ("mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT")
Signed-off-by: ThangNN99 <ngocthang2710.1999@gmail.com>
---
v3 (per Sebastian Andrzej Siewior's review on v2):
 - Say "raw_spinlock_t" instead of the vague "a raw spinlock"
   throughout the commit message and comment.
 - State plainly that *all* callers of set_cpus_allowed_force() hold
   task_struct::pi_lock, not just that it "can be called" with it
   held.

v2 (per automated review on v1):
 - Corrected commit message / comments: kfree_call_rcu_nolock() is not
   a safe alternative here either, since it still trylocks the same
   &s->cpu_sheaves->lock unconditionally.
 - Removed the now-unreachable CONFIG_PREEMPT_RT branch inside
   kfree_rcu_sheaf() left over by this fix (it can no longer run,
   since kvfree_call_rcu() already skips calling it on PREEMPT_RT).

 mm/slab_common.c | 20 ++++++++++----------
 mm/slub.c        |  6 +++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index b19ba1b31484..015380ba8bcc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1667,15 +1667,8 @@ static bool kfree_rcu_sheaf(void *obj)
 {
 	struct kmem_cache *s;
 	struct slab *slab;
-	unsigned int free_flags = SLAB_FREE_DEFAULT;
-
-	/*
-	 * It is not safe to spin on PREEMPT_RT because the kernel might be
-	 * holding a raw spinlock and slab acquires sleeping locks.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		free_flags = SLAB_FREE_NOLOCK;
 
+	/* Callers on PREEMPT_RT never reach here, see kvfree_call_rcu(). */
 	if (is_vmalloc_addr(obj))
 		return false;
 
@@ -1685,7 +1678,7 @@ static bool kfree_rcu_sheaf(void *obj)
 
 	s = slab->slab_cache;
 	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
-		return __kfree_rcu_sheaf(s, obj, free_flags);
+		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);
 
 	return false;
 }
@@ -2034,7 +2027,14 @@ void kvfree_call_rcu(struct kvfree_rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();
 
-	if (kfree_rcu_sheaf(ptr))
+	/*
+	 * Callers may hold a raw_spinlock_t here on PREEMPT_RT (e.g.
+	 * set_cpus_allowed_force(), whose callers all hold
+	 * task_struct::pi_lock), and the sheaf/barn locks are also taken
+	 * as blocking locks elsewhere, so trying them here creates a
+	 * lockdep-visible ordering conflict. Skip sheaves on PREEMPT_RT.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
 		return;
 
 	// Queue the object but don't yet schedule the batch.
diff --git a/mm/slub.c b/mm/slub.c
index f9b56cb439e7..1e8bad7a018e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6088,10 +6088,10 @@ static void rcu_free_sheaf(struct rcu_head *head)
 /*
  * kvfree_call_rcu() can be called while holding a raw_spinlock_t. Since
  * __kfree_rcu_sheaf() may acquire a spinlock_t (sleeping lock on PREEMPT_RT),
- * this would violate lock nesting rules. Therefore, kvfree_call_rcu() avoids
- * this problem by passing SLAB_FREE_NOLOCK on PREEMPT_RT.
+ * this would violate lock nesting rules. kvfree_call_rcu() avoids this by
+ * bypassing the sheaves layer on PREEMPT_RT.
  *
- * However, lockdep still complains that it is invalid to acquire spinlock_t
+ * lockdep still complains that it is invalid to acquire spinlock_t
  * while holding raw_spinlock_t, even on !PREEMPT_RT where spinlock_t is a
  * spinning lock. Tell lockdep that acquiring spinlock_t is valid here
  * by temporarily raising the wait-type to LD_WAIT_CONFIG. Skip the lockdep map
-- 
2.43.0

