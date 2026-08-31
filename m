Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8883BB693;
	Mon, 31 Aug 2026 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192171; cv=none; b=sPIaSS9l4Hi4CU3XgPnOf6GXWg6pVdOxJjNAAGbMLXaVQUdrAUrFU+hhjDVgDJKI77PtiSn/mu4HDazlRG1yovXNbevnHoWDE31sWVmc9GDcDbvuf48TQXWMweVWhzCaYg0MfcY7oxTOjK4t/l7zHcJyy939MsbXzz3wlZ2iVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192171; c=relaxed/simple;
	bh=t7YpXBwWo44Ao0hPSQc0ibgDI7jn9UtsrsCMut8SxHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dg/jDqoc66KpsZFauLiLbSIXuHT9eAcuwn/PSbhj5B+T8t6mbFWvXQNI0ojiL1tSRSo/a/XjfXdK9Tl4/PdLtVr+FpEGjwiNO+zVv1GCUvu8DRGhJSovLDuyEOjwoyxEeKrdJD9zLeC44PmiiEwi7bcJDdx4Vl4nG/JfFGxrZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLLq/DkE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLLq/DkE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECCD1F000E9;
	Mon, 31 Aug 2026 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788192169;
	bh=NLZIuZwyQ1fPBezPmB2ZdhRAqwPCI47TD8fU8pt0GCA=;
	h=From:Date:Subject:To:Cc;
	b=KLLq/DkENe5czcupFR05JthrwbrMSnV0jBK5gyFHWeXYiZnI1Q6Vstbuv9cCZ2pbs
	 A5von/JkglphxxzTC49/MuVpJToDw8RkEufMdSw8cPtpcEEETFGOBOGTVf28DJWyuX
	 kFKmZmmxpIYM50LPWTcKcXAFvttaLA4jiL50bO5PPri65fqFt7Bds2jP8U9n/xHewA
	 i7+KM+S+hL+jPs/4trrW3TOLaQDZ8/KArl8q4GG7cfJusW0AjZMocm64jf8JA6+D/6
	 wTHyvgFm7gLe8OD3JzSRLVqDLhk3JbIEhuVDPKFGwe01ZDV55xZDSzdWAY1HKDEeB4
	 0qIphpytdDWLw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Mon, 31 Aug 2026 18:02:38 +0200
Subject: [PATCH] mm/slab: disallow kfree_rcu_sheaf() on PREEMPT_RT again
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ2llWoC/yXMUQrCMBBF0a2U+TaQNFXErYgUk5mYUUhk0hahZ
 O9N7ed58O4KhYSpwK1bQWjhwjk1mFMHPj7TixRjM/S6v+irNcoN6hOEaBQ/jzFPgX/KoEW05ux
 C0NCeX6E2/6v3x+Eyuzf5aU9BrRsxn7/FdwAAAA==
X-Change-ID: 20260831-b4-kfree_rcu_hotfix-1d3dd315bff0
To: Harry Yoo <harry@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 syzbot+acf142088e0182172e58@syzkaller.appspotmail.com, 
 ThangNN99 <ngocthang2710.1999@gmail.com>, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3872; i=vbabka@kernel.org;
 h=from:subject:message-id; bh=t7YpXBwWo44Ao0hPSQc0ibgDI7jn9UtsrsCMut8SxHE=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMWRNXbrgZpbVhA0/KjWid80qv/teud9v/dV9GdICO0+/S
 GDayaJ5tpPRn4WBkYPBUkyRpXr3CUfRmcoe0zx8P8IMYmUCmSIt0sAABCwMfLmJeaVGOkZ6ptqG
 eoZAho4RAxenAEy1sRL7Px2xw0XuzdwTxJy0Xu+Y6/J4hrXJGf+Hvwo3qjo7bzU2P6UVOO/a3hy
 vgsVWE+4pnDtsaa6kcENozYTHIq9zZ0zelDp/ntOJ0rnRj1TvpkiLq2+VajGN3Rd3Z5Vu3RNx6x
 0tew+a7hZcnObIVfxH5/LJJRPCZG7wSxytTC2t//r+Rvrffjlhwa6Tk9RMfgV8ZlSUDClb/etQn
 4bIxMW8PUycJ7gO8++Z6Dz1QZJSwWSz8F1b5fYZnwgWnMRvdnl7UME5IxvVPUedlR8qnlR+yjo7
 mOe/QtSue3Gr4q8azay8czvO8/2Pa3uuX/FL3dV73uDnicTXHww3+L3OZ+l8+7nlnF+ftGNswBm
 hGTJ2TQA=
X-Developer-Key: i=vbabka@kernel.org; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664

This partially reverts commit 2a8bb29ec9b2 ("mm/slab: allow
kfree_rcu_sheaf() on PREEMPT_RT"). It was based on an assumption that
local_trylock() is safe on PREEMPT_RT from any context.

However kvfree_rcu() is also called by set_cpus_allowed_force() with
task_struct::pi_lock acquired and there it's not safe, as syzbot
has reported.

For the immediate fix, skip kfree_rcu_sheaf() on PREEMPT_RT again from
kvfree_call_rcu(). In theory, kfree_rcu_nolock() would have the same
problem when called from under pi_lock on PREEMPT_RT but that can
be addressed if such a caller is proposed.

Add an explanation comment, courtesy of Sebastian.

Reported-by: syzbot+acf142088e0182172e58@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=acf142088e0182172e58
Reported-by: ThangNN99 <ngocthang2710.1999@gmail.com>
Fixes: 2a8bb29ec9b2 ("mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT")
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Incidentally I have posted a RFC [1] that leads to replacing that
kfree_rcu() from set_cpus_allowed_force() but now after back from
vacation I need to check the feedback and based on this bug report I can
already see it makes the same bad assumption that trylock is fine.

[1] https://lore.kernel.org/all/20260807-kfree_nolock_kmalloc-v1-0-ba993cbf7a60@kernel.org/
---
 mm/slab_common.c | 18 ++++++++----------
 mm/slub.c        |  5 +++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index b19ba1b31484..7223a7596dab 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1667,14 +1667,6 @@ static bool kfree_rcu_sheaf(void *obj)
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
 
 	if (is_vmalloc_addr(obj))
 		return false;
@@ -1685,7 +1677,7 @@ static bool kfree_rcu_sheaf(void *obj)
 
 	s = slab->slab_cache;
 	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
-		return __kfree_rcu_sheaf(s, obj, free_flags);
+		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);
 
 	return false;
 }
@@ -2034,7 +2026,13 @@ void kvfree_call_rcu(struct kvfree_rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();
 
-	if (kfree_rcu_sheaf(ptr))
+	/*
+	 * kvfree_rcu() is called by set_cpus_allowed_force() with
+	 * task_struct::pi_lock acquired. On PREEMPT_RT the local_trylock()
+	 * usage below will acquire the waitlock which must be avoided.
+	 * Therefore avoid it on PREEMPT_RT.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
 		return;
 
 	// Queue the object but don't yet schedule the batch.
diff --git a/mm/slub.c b/mm/slub.c
index f9b56cb439e7..7a7e906a0e44 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6088,8 +6088,9 @@ static void rcu_free_sheaf(struct rcu_head *head)
 /*
  * kvfree_call_rcu() can be called while holding a raw_spinlock_t. Since
  * __kfree_rcu_sheaf() may acquire a spinlock_t (sleeping lock on PREEMPT_RT),
- * this would violate lock nesting rules. Therefore, kvfree_call_rcu() avoids
- * this problem by passing SLAB_FREE_NOLOCK on PREEMPT_RT.
+ * this would violate lock nesting rules. Therefore, kfree_call_rcu_nolock()
+ * avoids this problem by passing SLAB_FREE_NOLOCK. kvfree_call_rcu() is
+ * bypassing the sheaves layer completely on PREEMPT_RT.
  *
  * However, lockdep still complains that it is invalid to acquire spinlock_t
  * while holding raw_spinlock_t, even on !PREEMPT_RT where spinlock_t is a

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-b4-kfree_rcu_hotfix-1d3dd315bff0

