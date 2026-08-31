Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7CB1DFDA6
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 06:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156451; cv=none; b=D/UONVlPOZp2XnIBBZ0XEhjsoPpB0J+OPo3l3syoEFT8oC4EoEyDIWxXorj43rvH7eUSf/+T30Y2K/P1JWWVgdtwi8y67wvoOoGgRCuoN+Mx0i8Er0dMXbo6g8zZ0lzsFShKTJ1lASq+7n/2hf3AuNhBHuAXiMYmtfgoLA5blSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156451; c=relaxed/simple;
	bh=JXR3ikR0PzfPVFhh7TE8tFwEuaq75yPycMthOrlC+XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQVk9vDP+iDskcceL7dAxLn7zT4au0iirR8J1XSfl8VThECcfzcwlEkaXR9s5JxxnDk+GdnkAoNI3wgD2pvk79EsTpK+9fNmB+kF3PhlOGR1TnCoCjmCkx2Mv8yKO/0tRLxpewW+2DOYVzXhBWJiqer5su98vieNGEvMipDnMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSYyhICp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSYyhICp"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d7195706f1so29859695ad.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 30 Aug 2026 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788156449; x=1788761249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZKewmGq0J9WH8blhf/djGi6qD4AnbzKIdeFzMaSw4w=;
        b=fSYyhICphnue8nBKCmbfaBfN52VJHNdJZdTq/m9v5ZtU1wydBEJ139CyidZ2EtmuqL
         UjESvNfu34NxcTVRgjHldVO3VhArOjGfWTUiqYy2CK0sinDFikeA3PUurKd+IUgS7xSF
         5st5VOmBBoQ6GaR/NvX+Mw9/saRZe5+wcqMycGg33avAwLMOvhgpo9taEzrQ3bVWooYi
         n4qKRo8RiVEL8BxVIQ8GiJo9au418iOnrENhBIoUMrpln9hwVPaafvlhwkn/mtC0Pyx0
         5mWUXfsxhUHvYizd7S9l5oeyu9PTj9sNVhh+dzUfEfY42KqzSFG0h52vw/zQcbGQ5NSt
         o7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788156449; x=1788761249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZKewmGq0J9WH8blhf/djGi6qD4AnbzKIdeFzMaSw4w=;
        b=I8nfzIKFo9qCFix8n7+Y9XWYbVHSiBQ8B3uArKLNaUkOgKUlZ8jF+Rj6HL+gqucV2c
         yQqSxbPaKM7iOtuY1V3opQ+5TV2Ma5G41JubDJQECIE+Cz0zxIJKnCrsG/wdpx9ebpct
         Ecq8LfgsUQixEu74GR+B6PWSBeTXDXq67jI8pNA+UsqYzSeFxRzct8HPnUGa/MSUeKB4
         bB2WTViIi02KEgJ3HScfAu5+NfJF1El9pVDmqkkXAnmlaDKSakK7f0hAl6bNFwWv2+TE
         1LufTymKT1six9UFPmOESCIQvhJLFHUt5/lhaw4zVbBtQ2RiTgmJ9TvYAiTgPP2rJMR1
         4UvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQIYKCX28J2ermTOGM1U/GnAAR7zAV6pcV6ksVOOgeZ5d4AH6bKqF1WuKtrUJ304GVTzfMv7OUSHLza9uFPw==@lists.linux.dev
X-Gm-Message-State: AFuF++mjw+JUKtHAca098iPGoOlRZcBDZWwVf28sxKGlZDwaQWLW67Oq
	cEXX7dmTzIusjJsgZVO/HMrXS2zm3Ge/Mb3XeCgw9QWr41okaFzKKl3b
X-Gm-Gg: AR+sD10R1jpzC6VdGXOIyDw8j8mZcavhSebB1HS2ExgmJnuWX83szzkJRzo+nqoYw1X
	wPrSv0b8cogNgViVMWrC/qJm/TN2JRIv9FAlzDih62sJmjwsAO9O/y7sAR4I7ztj6drbjVhQSsK
	4UqV3kif0mJHGsnE2p3TTfirEO9zh5pRN+0MyUVYXq1DxKTLztshSgjKCs4KSzAH8reVc4YKsEX
	IH2FZ1Fe8EmyfANe/XRfk3Nn8jUXtfKvrTXHA18szevvbAMbY3v0Us7ShHaO/meuXJlmwCKp6pd
	jrXxHErie0BcNnkzUxjV4AZqKQsOyaEMLTmt4GdgSNfU732MZKQiVRKKoHV1KDQApvqjgJC/mEF
	UDMjGby5PW6BNILbE39djt1yGZIkY4ywOAwR1KBrK5ZgK066BAQAWZpm3oqsOZqEjOLHbNmcits
	TuO4f9s8avzYcw9zZubvlgUKWM4rzzEiBTOfrHuywgiG8T/SXiLdJCpuuLpjqU1BdM0hHxRTSJ6
	dJFnX7aLg==
X-Received: by 2002:a17:903:3d07:b0:2d8:d4d7:f055 with SMTP id d9443c01a7336-2d93fa78359mr17270765ad.22.1788156449332;
        Sun, 30 Aug 2026 23:07:29 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:21dc:72d0:980a:8660:dfa9:a9cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7598c3da2sm29795255ad.82.2026.08.30.23.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:07:29 -0700 (PDT)
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
Subject: [PATCH v2] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in kvfree_call_rcu()
Date: Mon, 31 Aug 2026 13:06:32 +0700
Message-ID: <20260831060633.6831-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831053846.107974-1-ngocthang2710.1999@gmail.com>
References: <20260831053846.107974-1-ngocthang2710.1999@gmail.com>
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

  __balance_push_cpu_stop()               [holds p->pi_lock, raw]
    select_fallback_rq()
      cpuset_cpus_allowed_fallback()
        set_cpus_allowed_force()
          kfree_rcu(ac.user_mask)
            kvfree_call_rcu()
              kfree_rcu_sheaf()
                __kfree_rcu_sheaf()
                  local_trylock(&s->cpu_sheaves->lock)   <- _T->lock

set_cpus_allowed_force() uses kfree_rcu() instead of kfree() here
specifically because it can be called with p->pi_lock (a raw
spinlock) held, and plain kfree() may sleep under PREEMPT_RT.

Commit 2a8bb29ec9b2 ("mm/slab: allow kfree_rcu_sheaf() on
PREEMPT_RT") made kvfree_call_rcu() try the sheaves fast path on
PREEMPT_RT too, since __kfree_rcu_sheaf() only trylocks there and
so cannot itself block. True, but the sheaf/barn locks it trylocks
are also taken as regular, blocking locks elsewhere, so lockdep
still records a lock-class ordering cycle against any raw spinlock
already held by the caller, which is what syzbot caught.

The plain kfree_rcu()/kvfree_rcu() API gives kvfree_call_rcu() no
way to know the caller is in such a context, so keep it
conservative on PREEMPT_RT and skip the sheaves layer there,
falling back to the existing raw_spinlock_t-protected krcp list,
which is always safe to nest under another raw spinlock. This
restores the pre-2a8bb29ec9b2 behavior of kvfree_call_rcu().

kfree_call_rcu_nolock(), added later in commit 3bc999d944b3
("mm/slab: introduce kfree_rcu_nolock()"), is untouched by this
patch. Note it would not be a safe substitute here either: it still
reaches __kfree_rcu_sheaf()'s local_trylock() on &s->cpu_sheaves->lock
unconditionally, so a caller already holding a raw spinlock would hit
the same lockdep ordering cycle through that path too.

Reported-by: syzbot+acf142088e0182172e58@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=acf142088e0182172e58
Fixes: 2a8bb29ec9b2 ("mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT")
Signed-off-by: ThangNN99 <ngocthang2710.1999@gmail.com>
---
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
index b19ba1b31484..3de1eabe6c77 100644
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
+	 * Callers may hold a raw spinlock here on PREEMPT_RT (e.g.
+	 * set_cpus_allowed_force() with p->pi_lock held), and the sheaf/barn
+	 * locks are also taken as blocking locks elsewhere, so trying them
+	 * here creates a lockdep-visible ordering conflict. Skip sheaves on
+	 * PREEMPT_RT.
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

