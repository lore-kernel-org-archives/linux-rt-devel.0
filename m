Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22A34DCF3
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 05:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154741; cv=none; b=cBS9WkFzxhhDjeFX52Z3YgI59u23tyxmJPt5w05rrKpNF2XvrZvyWX3bL8XG6o4Wmcgg/OJSMRfMmGfa004Ls2jQAwrFfsI1mhTMuTtmYeLKhyp5NMfo/IAfKunWO2MMVay9X7b8Ib54X+Q18rVMSYibtBgr3tOORCA5QamcGfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154741; c=relaxed/simple;
	bh=DCkOm8Lvds3JLOGvpydJVD7KiV55OqLcq/T9TU+S3eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFhiIguvYMY8UWTdDLLZ16bseSooQ7VcQBdikpQE6x+Qh+GLePijzAKvIWXy/+F/cbeDAsYFGvNl9JaqRDwE8LruabOjdLcJmL7D1x8mogzdEnmygPzGd8IHIjnMvg6XQ73ZzaPwowB2eECcgI1vQ/9ConIZ4yuyHVHt7XGE/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRyNpBkk; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRyNpBkk"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1c7364550so3220065a12.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 30 Aug 2026 22:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788154738; x=1788759538; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DCO9UVAZL7IBEVYT4FWzK81SLKfxURvKrv7BU2smeUE=;
        b=dRyNpBkkLg2vITxfEoGMrWo3eg/U+VLAb8Wuk7UYtrlaE8mtslYGridMgCfGesDR0h
         U9hFkw8nYe0vK+9XTLXZWBgvul9lPrf0Dz5MOLtniwm7IqYmP0OqPAZjOXdwEPgK9HYL
         k2ZkixovwfZMB6087LTgRC7dVipcrP54Fj5li6PkTg4Mp8w4rC/NyGS5O36oR0aJWmxZ
         2PaAWL5156xLZpXmVQnrko/ScCFcAobn7sgEAw7ThlQ8cvNwm2M17nZwS82gszWyKRUA
         2HEZe+AaavcLxENBhISazZNdtEaSx466FnwM2mCyuReBdU0tGKCJXsJYqty3G4BYUHVC
         BwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788154738; x=1788759538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DCO9UVAZL7IBEVYT4FWzK81SLKfxURvKrv7BU2smeUE=;
        b=UJhgxOBD4IIpntIZicbUbtcJXIK+e3VCSZY8TuEwUIXvl11KIiXjFhgGbBo6qjCyVZ
         k9qiU3YIluRN2SlA9OvpgUDjqYtM5iOlDz7A/5pHKalvy8vUvVEYA3DVOHjsuzPi+W8Y
         C5yXe2QN+wrmHW5Cl5hoQhbKyN3JbDWAVlxYX0pUkivE8UDn3EdCdPoVK6T6w+G3l5er
         qDep9m5tsE0r6qex8PohNpDDJFzH2oG5k6M6JPC8/FuawNmSDpsxl5fzM2du1q17GngB
         iSw/Zs4N2CZHMohGPfNEFmmmmBWBWNG00jhEvEEB4SHyaY/l3z+OJzbKHwAdTXUQ6BJL
         eUmA==
X-Forwarded-Encrypted: i=1; AHgh+RoFT9gw1BtJpa3vEc3fm/MYGVrR6QY4+mOFCqZQjnmO8W8rgVt0fD7ypdbiMpgh0KspfKdeO8oEtzVEtdh52g==@lists.linux.dev
X-Gm-Message-State: AFuF++lE99I6ApL2f9QfVQbgPYBU/jFchwHWyjrILH2X5uS81V3oRmg6
	xff1qkUXq93HejzU8LDjLEEsiPa/phM7MgVc2WLJ2rpqVUcn1bkR9tpx3Yu2Ag==
X-Gm-Gg: AR+sD131BxcazVWN24Esv0xYf75EOlDuL4I+RTm5dnJqHCEjwimGnX0U9kjLMiWd+ol
	pP14IjvySbZQv7adAcHCDLGFCT0WsnYdjUM7Ck90qvgVoMiKcQTs4Yd5y+erSK5R7ORSgS35i2t
	nVyGpU/Fu/vciWx9xrzLn3ipy2esjN2MN46tbbn/vUMvRPS8dAJe3kK+bD+a+Blv18NkhafNsqe
	N1xmdJqO/GS4uXGywGIlYE9+LYam+SzCzjjbofA7DpbJokKNetDDoIRRyPuFh45pP2lZELlz7Vc
	WBZnSFDZJ5vGCxbYahdLwdQaqhpYHpyg+w8w3CIbbpvycLMqBCGpKKbqqV/nLE4Zd5Opix7WbfS
	UzDghTH2IgNiFfc/GcbEbe/h5e33UdkOjW/sIvsrJsskYMhQIaEGrsvtkcn6YVeYYOEdlSd4r3i
	4BX6EAnHKk6G2iAbx6/8BxIyeBxEklvASO6y5T1W1tsTyS/zUUx6PEgo4KLyeVNr3eAV8uy7FZ1
	cUUfgBOYQ==
X-Received: by 2002:a05:6a20:9c11:b0:3d0:9164:98a7 with SMTP id adf61e73a8af0-3d2686a9ae9mr37495013637.11.1788154738197;
        Sun, 30 Aug 2026 22:38:58 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:21dc:72d0:19f0:b2d5:4cfe:4463])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36dbf62sm3505850a12.25.2026.08.30.22.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:38:57 -0700 (PDT)
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
Subject: [PATCH] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in kvfree_call_rcu()
Date: Mon, 31 Aug 2026 12:38:46 +0700
Message-ID: <20260831053846.107974-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
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
("mm/slab: introduce kfree_rcu_nolock()") for unknown/atomic
contexts, is unaffected: it already falls back to a lock-free
defer_kfree_rcu() when the sheaves trylock doesn't pan out, so it
keeps using SLAB_FREE_NOLOCK on PREEMPT_RT. Callers like
set_cpus_allowed_force() that want the sheaves fast path under a
raw spinlock should migrate to that API instead.

Reported-by: syzbot+acf142088e0182172e58@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=acf142088e0182172e58
Fixes: 2a8bb29ec9b2 ("mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT")
Signed-off-by: ThangNN99 <ngocthang2710.1999@gmail.com>
---
 mm/slab_common.c | 9 ++++++++-
 mm/slub.c        | 7 ++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index b19ba1b31484..6d6cd78d00c4 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -2034,7 +2034,14 @@ void kvfree_call_rcu(struct kvfree_rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();
 
-	if (kfree_rcu_sheaf(ptr))
+	/*
+	 * Callers may hold a raw spinlock here on PREEMPT_RT (e.g.
+	 * set_cpus_allowed_force() with p->pi_lock held), and the sheaf/barn
+	 * locks are also taken as blocking locks elsewhere, so trying them
+	 * here creates a lockdep-visible ordering conflict. Skip sheaves on
+	 * PREEMPT_RT; use kfree_rcu_nolock() instead if this doesn't apply.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
 		return;
 
 	// Queue the object but don't yet schedule the batch.
diff --git a/mm/slub.c b/mm/slub.c
index f9b56cb439e7..83bc322557f8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6088,10 +6088,11 @@ static void rcu_free_sheaf(struct rcu_head *head)
 /*
  * kvfree_call_rcu() can be called while holding a raw_spinlock_t. Since
  * __kfree_rcu_sheaf() may acquire a spinlock_t (sleeping lock on PREEMPT_RT),
- * this would violate lock nesting rules. Therefore, kvfree_call_rcu() avoids
- * this problem by passing SLAB_FREE_NOLOCK on PREEMPT_RT.
+ * this would violate lock nesting rules. kvfree_call_rcu() avoids this by
+ * bypassing the sheaves layer on PREEMPT_RT; use kfree_call_rcu_nolock()
+ * instead for atomic/unknown-context callers that need the sheaves path.
  *
- * However, lockdep still complains that it is invalid to acquire spinlock_t
+ * lockdep still complains that it is invalid to acquire spinlock_t
  * while holding raw_spinlock_t, even on !PREEMPT_RT where spinlock_t is a
  * spinning lock. Tell lockdep that acquiring spinlock_t is valid here
  * by temporarily raising the wait-type to LD_WAIT_CONFIG. Skip the lockdep map
-- 
2.43.0

