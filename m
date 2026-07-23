Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E990381E9B;
	Thu, 23 Jul 2026 04:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781031; cv=none; b=S0jCNRJ9mJ3urlKQ1el1iog1M9i7niq0uC/wbuol36cue0sume2W8Ggxeyu3F9kgDm9J7PlDSnwudlcvlxMlfE465a1h6WLSqd7SqbbjnWL2pm40Smq+TBvgCFPhSk20NpnXfjep6I5FY/kZ/NR3pWIXPERvfjsVeaY8gwFsQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781031; c=relaxed/simple;
	bh=/MZ/5EaJWA91eOibIRH6JcvSOCUjfhQBj0kTkJmcEQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rrpCuIGLr/2oQDNySjp66M8x1cJXSAMdtsm4qECCSvhRBSWQe4hV2q0yqq+OLT3vrT3ygM49JfuOfAzd89H5964MPVDA6Q4IwtxT0DMJirEijd6/trERoilB4nLw6kvU0AjdtVS8C8JGtxEBEj5WxyWqTcfUEOBpsavUWEVzg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKJQTTDe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKJQTTDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784781010; x=1816317010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/MZ/5EaJWA91eOibIRH6JcvSOCUjfhQBj0kTkJmcEQQ=;
  b=cKJQTTDeK6pf0edmiyG8qrTSy1zMv2rx8z8/m2K4Z9FG4axdjH/Fhawz
   ikcDbLcoEKIqeGozPXPBUVtSJ0ZN27+9tj+QHUFFbKgBxGPG57jJQiUtV
   RoUdq/ggLo5AiErc/vRmafMO7Bidy6DjC1MCZYDZlWu2cT+TaYlGLwOcQ
   GgZCBQ1WggWz3yvpzlKAif4SpePIYYNp8MuadHxVm+SzLCNYS0ZXgnbXq
   OksU+l2WsnlXI/Io/+4K50DnzbLtnJ7LhkNZcWVM88VTxQwo+rwZT6M0v
   Ptp2q0GUD5no73hPZCjXybMJN9UsL0Luu/Dv/XXNE3hxTgelFyIPwpoGI
   A==;
X-CSE-ConnectionGUID: J6Svr8xwSXKeqgD5Ht6f3w==
X-CSE-MsgGUID: 5Q/Xnxh3TQWDQ3NzCsXjYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="72969153"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="72969153"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 21:29:52 -0700
X-CSE-ConnectionGUID: RZdq46dBRMiFvWaV8nEBjA==
X-CSE-MsgGUID: SBIOWl/vRWCDRCQfIcFy7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="251979357"
Received: from qat-server-366.sh.intel.com ([10.239.92.77])
  by fmviesa009.fm.intel.com with ESMTP; 22 Jul 2026 21:29:50 -0700
From: Jie Wang <jie.wang@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jie Wang <jie.wang@intel.com>
Subject: [PATCH] gfs2: convert quota data hash table to an rhashtable
Date: Thu, 23 Jul 2026 12:16:17 +0000
Message-Id: <20260723121617.3775271-1-jie.wang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qd_hash_table is an array of hlist_bl heads whose per-bucket lock is a
bit-spinlock (hlist_bl_lock()).  On PREEMPT_RT a bit-spinlock is not
turned into an rtmutex and keeps preemption disabled, and
lockref_get_not_dead() may take the sleeping qd_lockref.lock, so the
reference-taking lookup in qd_get() is not allowed while the bucket lock
is held.

Convert qd_hash_table to an rhashtable, like gl_hash_table.  rhashtable
lookups only need rcu_read_lock(), which does not disable preemption on
PREEMPT_RT, so a reference-taking lookup is safe in any context.  This
removes the bucket bit-spinlock, the per-object qd_hash field,
gfs2_qd_hash() and the no-ref lookup variant that only existed to avoid
taking a reference under the bucket lock.

As rhashtable does not allow duplicate keys, qd_get() now follows
find_insert_glock(): if it finds a quota_data that is being disposed of,
it waits for gfs2_qd_dispose() to remove it and retries the insertion.

Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Jie Wang <jie.wang@intel.com>
---
 fs/gfs2/incore.h |  12 ++-
 fs/gfs2/main.c   |  10 +-
 fs/gfs2/quota.c  | 247 ++++++++++++++++++++++++-----------------------
 fs/gfs2/quota.h  |   3 +-
 4 files changed, 145 insertions(+), 127 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 614657778..7a487ea62 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -441,14 +441,18 @@ enum {
 	QDF_QMSG_QUIET          = 4,
 };
 
+/* rhashtable key, hashed by value; keep it free of padding. */
+struct gfs2_qd_hash_key {
+	struct gfs2_sbd *qd_sbd;
+	struct kqid qd_id;
+};
+
 struct gfs2_quota_data {
-	struct hlist_bl_node qd_hlist;
+	struct rhash_head qd_node;
+	struct gfs2_qd_hash_key qd_key;
 	struct list_head qd_list;
-	struct kqid qd_id;
-	struct gfs2_sbd *qd_sbd;
 	struct lockref qd_lockref;
 	struct list_head qd_lru;
-	unsigned qd_hash;
 
 	unsigned long qd_flags;		/* QDF_... */
 
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 9d6571935..25fd8d35c 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -78,12 +78,15 @@ static int __init init_gfs2_fs(void)
 
 	gfs2_str2qstr(&gfs2_qdot, ".");
 	gfs2_str2qstr(&gfs2_qdotdot, "..");
-	gfs2_quota_hash_init();
 
-	error = gfs2_sys_init();
+	error = gfs2_quota_hash_init();
 	if (error)
 		return error;
 
+	error = gfs2_sys_init();
+	if (error)
+		goto fail_sys;
+
 	error = list_lru_init(&gfs2_qd_lru);
 	if (error)
 		goto fail_lru;
@@ -218,6 +221,8 @@ static int __init init_gfs2_fs(void)
 	list_lru_destroy(&gfs2_qd_lru);
 fail_lru:
 	gfs2_sys_uninit();
+fail_sys:
+	gfs2_quota_hash_exit();
 	return error;
 }
 
@@ -251,6 +256,7 @@ static void __exit exit_gfs2_fs(void)
 	kmem_cache_destroy(gfs2_glock_cachep);
 
 	gfs2_sys_uninit();
+	gfs2_quota_hash_exit();
 }
 
 MODULE_DESCRIPTION("Global File System");
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 91e9975d2..1a4d677e2 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -52,9 +52,7 @@
 #include <linux/lockref.h>
 #include <linux/list_lru.h>
 #include <linux/rcupdate.h>
-#include <linux/rculist_bl.h>
-#include <linux/bit_spinlock.h>
-#include <linux/jhash.h>
+#include <linux/rhashtable.h>
 #include <linux/vmalloc.h>
 
 #include "gfs2.h"
@@ -73,40 +71,28 @@
 
 #define GFS2_QD_HASH_SHIFT      12
 #define GFS2_QD_HASH_SIZE       BIT(GFS2_QD_HASH_SHIFT)
-#define GFS2_QD_HASH_MASK       (GFS2_QD_HASH_SIZE - 1)
 
-/* Lock order: qd_lock -> bucket lock -> qd->lockref.lock -> lru lock */
-/*                     -> sd_bitmap_lock                              */
+/* Lock order: qd_lock -> qd->lockref.lock -> lru lock */
+/*                     -> sd_bitmap_lock               */
 static DEFINE_SPINLOCK(qd_lock);
 struct list_lru gfs2_qd_lru;
 
-static struct hlist_bl_head qd_hash_table[GFS2_QD_HASH_SIZE];
+static struct rhashtable qd_hash_table;
 
-static unsigned int gfs2_qd_hash(const struct gfs2_sbd *sdp,
-				 const struct kqid qid)
-{
-	unsigned int h;
-
-	h = jhash(&sdp, sizeof(struct gfs2_sbd *), 0);
-	h = jhash(&qid, sizeof(struct kqid), h);
-
-	return h & GFS2_QD_HASH_MASK;
-}
-
-static inline void spin_lock_bucket(unsigned int hash)
-{
-        hlist_bl_lock(&qd_hash_table[hash]);
-}
+static const struct rhashtable_params qd_hash_params = {
+	.nelem_hint = GFS2_QD_HASH_SIZE * 3 / 4,
+	.key_len = sizeof(struct gfs2_qd_hash_key),
+	.key_offset = offsetof(struct gfs2_quota_data, qd_key),
+	.head_offset = offsetof(struct gfs2_quota_data, qd_node),
+};
 
-static inline void spin_unlock_bucket(unsigned int hash)
-{
-        hlist_bl_unlock(&qd_hash_table[hash]);
-}
+/* Waited on by qd_find_insert() while a matching quota_data is disposed of. */
+static DECLARE_WAIT_QUEUE_HEAD(qd_wait);
 
 static void gfs2_qd_dealloc(struct rcu_head *rcu)
 {
 	struct gfs2_quota_data *qd = container_of(rcu, struct gfs2_quota_data, qd_rcu);
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 
 	kmem_cache_free(gfs2_quotad_cachep, qd);
 	if (atomic_dec_and_test(&sdp->sd_quota_count))
@@ -115,15 +101,14 @@ static void gfs2_qd_dealloc(struct rcu_head *rcu)
 
 static void gfs2_qd_dispose(struct gfs2_quota_data *qd)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 
 	spin_lock(&qd_lock);
 	list_del(&qd->qd_list);
 	spin_unlock(&qd_lock);
 
-	spin_lock_bucket(qd->qd_hash);
-	hlist_bl_del_rcu(&qd->qd_hlist);
-	spin_unlock_bucket(qd->qd_hash);
+	rhashtable_remove_fast(&qd_hash_table, &qd->qd_node, qd_hash_params);
+	wake_up(&qd_wait);
 
 	if (!gfs2_withdrawn(sdp)) {
 		gfs2_assert_warn(sdp, !qd->qd_change);
@@ -216,7 +201,7 @@ void gfs2_qd_shrinker_exit(void)
 
 static u64 qd2index(struct gfs2_quota_data *qd)
 {
-	struct kqid qid = qd->qd_id;
+	struct kqid qid = qd->qd_key.qd_id;
 	return (2 * (u64)from_kqid(&init_user_ns, qid)) +
 		((qid.type == USRQUOTA) ? 0 : 1);
 }
@@ -226,7 +211,7 @@ static u64 qd2offset(struct gfs2_quota_data *qd)
 	return qd2index(qd) * sizeof(struct gfs2_quota);
 }
 
-static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, struct kqid qid)
+static struct gfs2_quota_data *qd_alloc(struct gfs2_sbd *sdp, struct kqid qid)
 {
 	struct gfs2_quota_data *qd;
 	int error;
@@ -235,12 +220,11 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, str
 	if (!qd)
 		return NULL;
 
-	qd->qd_sbd = sdp;
+	qd->qd_key.qd_sbd = sdp;
+	qd->qd_key.qd_id = qid;
 	lockref_init(&qd->qd_lockref);
-	qd->qd_id = qid;
 	qd->qd_slot = -1;
 	INIT_LIST_HEAD(&qd->qd_lru);
-	qd->qd_hash = hash;
 
 	error = gfs2_glock_get(sdp, qd2index(qd),
 			      &gfs2_quota_glops, CREATE, &qd->qd_gl);
@@ -254,75 +238,96 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, str
 	return NULL;
 }
 
-/*
- * Lookup variant for callers which already hold qd_lock + bucket lock.
- */
-static struct gfs2_quota_data *
-gfs2_qd_search_bucket_noref(unsigned int hash,
-			    const struct gfs2_sbd *sdp,
-			    struct kqid qid)
+/* Wait condition for qd_find_insert(): the key is free or now holds a live qd. */
+static bool qd_dispose_done(const struct gfs2_qd_hash_key *key)
 {
 	struct gfs2_quota_data *qd;
-	struct hlist_bl_node *h;
-
-	hlist_bl_for_each_entry_rcu(qd, h, &qd_hash_table[hash], qd_hlist) {
-		if (!qid_eq(qd->qd_id, qid))
-			continue;
-		if (qd->qd_sbd == sdp)
-			return qd;
-	}
+	bool done;
 
-	return NULL;
+	rcu_read_lock();
+	qd = rhashtable_lookup_fast(&qd_hash_table, key, qd_hash_params);
+	/* Advisory read of the dead state; re-validated by the caller. */
+	done = !qd || !data_race(__lockref_is_dead(&qd->qd_lockref));
+	rcu_read_unlock();
+	return done;
 }
 
+/*
+ * Look up the quota_data for the given key and take a reference.  If a new
+ * quota_data is supplied, insert it when the key is absent.  Like
+ * find_insert_glock(), the lookup is RCU-only, so the reference can be taken
+ * even on PREEMPT_RT.  Returns the existing (referenced) quota_data, NULL if
+ * the new one was inserted or nothing was found, or an ERR_PTR on insertion
+ * failure.
+ */
 static struct gfs2_quota_data *
-gfs2_qd_search_bucket(unsigned int hash, const struct gfs2_sbd *sdp, struct kqid qid)
+qd_find_insert(const struct gfs2_qd_hash_key *key, struct gfs2_quota_data *new)
 {
 	struct gfs2_quota_data *qd;
 
-	qd = gfs2_qd_search_bucket_noref(hash, sdp, qid);
-	if (qd && lockref_get_not_dead(&qd->qd_lockref)) {
-		list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
-		return qd;
+again:
+	rcu_read_lock();
+	if (new)
+		qd = rhashtable_lookup_get_insert_fast(&qd_hash_table,
+						       &new->qd_node,
+						       qd_hash_params);
+	else
+		qd = rhashtable_lookup_fast(&qd_hash_table, key, qd_hash_params);
+	if (!IS_ERR_OR_NULL(qd) && !lockref_get_not_dead(&qd->qd_lockref)) {
+		/*
+		 * The matching quota_data is being disposed of.  rhashtable
+		 * cannot hold a duplicate key, so wait for gfs2_qd_dispose() to
+		 * remove it (or replace it with a live one) and retry.
+		 */
+		rcu_read_unlock();
+		if (!new)
+			return NULL;
+		wait_event(qd_wait, qd_dispose_done(key));
+		goto again;
 	}
+	rcu_read_unlock();
 
-	return NULL;
+	if (!IS_ERR_OR_NULL(qd))
+		list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
+	return qd;
 }
 
-
 static int qd_get(struct gfs2_sbd *sdp, struct kqid qid,
 		  struct gfs2_quota_data **qdp)
 {
+	struct gfs2_qd_hash_key key = {
+		.qd_sbd = sdp,
+		.qd_id = qid,
+	};
 	struct gfs2_quota_data *qd, *new_qd;
-	unsigned int hash = gfs2_qd_hash(sdp, qid);
 
-	rcu_read_lock();
-	*qdp = qd = gfs2_qd_search_bucket(hash, sdp, qid);
-	rcu_read_unlock();
-
-	if (qd)
+	qd = qd_find_insert(&key, NULL);
+	if (qd) {
+		*qdp = qd;
 		return 0;
+	}
 
-	new_qd = qd_alloc(hash, sdp, qid);
+	new_qd = qd_alloc(sdp, qid);
 	if (!new_qd)
 		return -ENOMEM;
 
-	spin_lock(&qd_lock);
-	spin_lock_bucket(hash);
-	*qdp = qd = gfs2_qd_search_bucket(hash, sdp, qid);
-	if (qd == NULL) {
-		*qdp = new_qd;
-		list_add(&new_qd->qd_list, &sdp->sd_quota_list);
-		hlist_bl_add_head_rcu(&new_qd->qd_hlist, &qd_hash_table[hash]);
-		atomic_inc(&sdp->sd_quota_count);
+	qd = qd_find_insert(&key, new_qd);
+	if (IS_ERR(qd)) {
+		gfs2_glock_put(new_qd->qd_gl);
+		kmem_cache_free(gfs2_quotad_cachep, new_qd);
+		return PTR_ERR(qd);
 	}
-	spin_unlock_bucket(hash);
-	spin_unlock(&qd_lock);
-
 	if (qd) {
 		gfs2_glock_put(new_qd->qd_gl);
 		kmem_cache_free(gfs2_quotad_cachep, new_qd);
+	} else {
+		qd = new_qd;
+		spin_lock(&qd_lock);
+		list_add(&qd->qd_list, &sdp->sd_quota_list);
+		atomic_inc(&sdp->sd_quota_count);
+		spin_unlock(&qd_lock);
 	}
+	*qdp = qd;
 
 	return 0;
 }
@@ -330,7 +335,7 @@ static int qd_get(struct gfs2_sbd *sdp, struct kqid qid,
 
 static void __qd_hold(struct gfs2_quota_data *qd)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 	gfs2_assert(sdp, qd->qd_lockref.count > 0);
 	qd->qd_lockref.count++;
 }
@@ -343,7 +348,7 @@ static void qd_put(struct gfs2_quota_data *qd)
 		return;
 
 	BUG_ON(__lockref_is_dead(&qd->qd_lockref));
-	sdp = qd->qd_sbd;
+	sdp = qd->qd_key.qd_sbd;
 	if (unlikely(!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))) {
 		lockref_mark_dead(&qd->qd_lockref);
 		spin_unlock(&qd->qd_lockref.lock);
@@ -360,7 +365,7 @@ static void qd_put(struct gfs2_quota_data *qd)
 
 static int slot_get(struct gfs2_quota_data *qd)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 	unsigned int bit;
 	int error = 0;
 
@@ -383,7 +388,7 @@ static int slot_get(struct gfs2_quota_data *qd)
 
 static void slot_hold(struct gfs2_quota_data *qd)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 
 	spin_lock(&sdp->sd_bitmap_lock);
 	gfs2_assert(sdp, qd->qd_slot_ref);
@@ -393,7 +398,7 @@ static void slot_hold(struct gfs2_quota_data *qd)
 
 static void slot_put(struct gfs2_quota_data *qd)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 
 	spin_lock(&sdp->sd_bitmap_lock);
 	gfs2_assert(sdp, qd->qd_slot_ref);
@@ -406,7 +411,7 @@ static void slot_put(struct gfs2_quota_data *qd)
 
 static int bh_get(struct gfs2_quota_data *qd)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 	struct inode *inode = sdp->sd_qc_inode;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	unsigned int block, offset;
@@ -461,7 +466,7 @@ static int bh_get(struct gfs2_quota_data *qd)
 
 static void bh_put(struct gfs2_quota_data *qd)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 	struct buffer_head *bh = NULL;
 
 	spin_lock(&qd->qd_lockref.lock);
@@ -518,7 +523,7 @@ static void qdsb_put(struct gfs2_quota_data *qd)
 static void qd_unlock(struct gfs2_quota_data *qd)
 {
 	spin_lock(&qd->qd_lockref.lock);
-	gfs2_assert_warn(qd->qd_sbd, test_bit(QDF_LOCKED, &qd->qd_flags));
+	gfs2_assert_warn(qd->qd_key.qd_sbd, test_bit(QDF_LOCKED, &qd->qd_flags));
 	clear_bit(QDF_LOCKED, &qd->qd_flags);
 	spin_unlock(&qd->qd_lockref.lock);
 	qdsb_put(qd);
@@ -677,16 +682,16 @@ static int sort_qd(const void *a, const void *b)
 	const struct gfs2_quota_data *qd_a = *(const struct gfs2_quota_data **)a;
 	const struct gfs2_quota_data *qd_b = *(const struct gfs2_quota_data **)b;
 
-	if (qid_lt(qd_a->qd_id, qd_b->qd_id))
+	if (qid_lt(qd_a->qd_key.qd_id, qd_b->qd_key.qd_id))
 		return -1;
-	if (qid_lt(qd_b->qd_id, qd_a->qd_id))
+	if (qid_lt(qd_b->qd_key.qd_id, qd_a->qd_key.qd_id))
 		return 1;
 	return 0;
 }
 
 static void do_qc(struct gfs2_quota_data *qd, s64 change)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_qc_inode);
 	struct gfs2_quota_change *qc = qd->qd_bh_qc;
 	bool needs_put = false;
@@ -721,9 +726,9 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change)
 		slot_hold(qd);
 
 		qc->qc_flags = 0;
-		if (qd->qd_id.type == USRQUOTA)
+		if (qd->qd_key.qd_id.type == USRQUOTA)
 			qc->qc_flags = cpu_to_be32(GFS2_QCF_USER);
-		qc->qc_id = cpu_to_be32(from_kqid(&init_user_ns, qd->qd_id));
+		qc->qc_id = cpu_to_be32(from_kqid(&init_user_ns, qd->qd_key.qd_id));
 	}
 	qc->qc_change = cpu_to_be64(x);
 
@@ -907,7 +912,7 @@ static int gfs2_adjust_quota(struct gfs2_sbd *sdp, loff_t loc,
 static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 		   u64 sync_gen)
 {
-	struct gfs2_sbd *sdp = (*qda)->qd_sbd;
+	struct gfs2_sbd *sdp = (*qda)->qd_key.qd_sbd;
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
 	struct gfs2_alloc_parms ap = {};
 	unsigned int data_blocks, ind_blocks;
@@ -1037,7 +1042,7 @@ static int update_qd(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd)
 static int do_glock(struct gfs2_quota_data *qd, int force_refresh,
 		    struct gfs2_holder *q_gh)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
 	struct gfs2_holder i_gh;
 	int error;
@@ -1122,7 +1127,7 @@ int gfs2_quota_lock(struct gfs2_inode *ip, kuid_t uid, kgid_t gid)
 
 static bool need_sync(struct gfs2_quota_data *qd)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 	struct gfs2_tune *gt = &sdp->sd_tune;
 	s64 value, change, limit;
 	unsigned int num, den;
@@ -1210,13 +1215,13 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 
 static void print_message(struct gfs2_quota_data *qd, char *type)
 {
-	struct gfs2_sbd *sdp = qd->qd_sbd;
+	struct gfs2_sbd *sdp = qd->qd_key.qd_sbd;
 
 	if (sdp->sd_args.ar_quota != GFS2_QUOTA_QUIET) {
 		fs_info(sdp, "quota %s for %s %u\n",
 			type,
-			(qd->qd_id.type == USRQUOTA) ? "user" : "group",
-			from_kqid(&init_user_ns, qd->qd_id));
+			(qd->qd_key.qd_id.type == USRQUOTA) ? "user" : "group",
+			from_kqid(&init_user_ns, qd->qd_key.qd_id));
 	}
 }
 
@@ -1253,8 +1258,8 @@ int gfs2_quota_check(struct gfs2_inode *ip, kuid_t uid, kgid_t gid,
 	for (x = 0; x < ip->i_qadata->qa_qd_num; x++) {
 		qd = ip->i_qadata->qa_qd[x];
 
-		if (!(qid_eq(qd->qd_id, make_kqid_uid(uid)) ||
-		      qid_eq(qd->qd_id, make_kqid_gid(gid))))
+		if (!(qid_eq(qd->qd_key.qd_id, make_kqid_uid(uid)) ||
+		      qid_eq(qd->qd_key.qd_id, make_kqid_gid(gid))))
 			continue;
 
 		spin_lock(&qd->qd_lockref.lock);
@@ -1274,7 +1279,7 @@ int gfs2_quota_check(struct gfs2_inode *ip, kuid_t uid, kgid_t gid,
 				if (!test_and_set_bit(QDF_QMSG_QUIET,
 						      &qd->qd_flags)) {
 					print_message(qd, "exceeded");
-					quota_send_warning(qd->qd_id,
+					quota_send_warning(qd->qd_key.qd_id,
 							   sdp->sd_vfs->s_dev,
 							   QUOTA_NL_BHARDWARN);
 				}
@@ -1285,7 +1290,7 @@ int gfs2_quota_check(struct gfs2_inode *ip, kuid_t uid, kgid_t gid,
 			   time_after_eq(jiffies, qd->qd_last_warn +
 					 gfs2_tune_get(sdp, gt_quota_warn_period)
 					 * HZ)) {
-			quota_send_warning(qd->qd_id,
+			quota_send_warning(qd->qd_key.qd_id,
 					   sdp->sd_vfs->s_dev, QUOTA_NL_BSOFTWARN);
 			print_message(qd, "warning");
 			error = 0;
@@ -1314,8 +1319,8 @@ void gfs2_quota_change(struct gfs2_inode *ip, s64 change,
 	for (x = 0; x < ip->i_qadata->qa_qd_num; x++) {
 		qd = ip->i_qadata->qa_qd[x];
 
-		if (qid_eq(qd->qd_id, make_kqid_uid(uid)) ||
-		    qid_eq(qd->qd_id, make_kqid_gid(gid))) {
+		if (qid_eq(qd->qd_key.qd_id, make_kqid_uid(uid)) ||
+		    qid_eq(qd->qd_key.qd_id, make_kqid_gid(gid))) {
 			do_qc(qd, change);
 		}
 	}
@@ -1407,7 +1412,6 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 	unsigned int blocks = size >> sdp->sd_sb.sb_bsize_shift;
 	unsigned int x, slot = 0;
 	unsigned int found = 0;
-	unsigned int hash;
 	unsigned int bm_size;
 	struct buffer_head *bh;
 	u64 dblock;
@@ -1458,8 +1462,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 			if (!qc_change)
 				continue;
 
-			hash = gfs2_qd_hash(sdp, qc_id);
-			qd = qd_alloc(hash, sdp, qc_id);
+			qd = qd_alloc(sdp, qc_id);
 			if (qd == NULL)
 				goto fail_brelse;
 
@@ -1469,21 +1472,24 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 			qd->qd_slot = slot;
 			qd->qd_slot_ref = 1;
 
-			spin_lock(&qd_lock);
-			spin_lock_bucket(hash);
-			old_qd = gfs2_qd_search_bucket_noref(hash, sdp, qc_id);
+			rcu_read_lock();
+			old_qd = rhashtable_lookup_get_insert_fast(&qd_hash_table,
+					&qd->qd_node, qd_hash_params);
+			rcu_read_unlock();
 			if (old_qd) {
+				gfs2_glock_put(qd->qd_gl);
+				kmem_cache_free(gfs2_quotad_cachep, qd);
+
+				if (IS_ERR(old_qd)) {
+					error = PTR_ERR(old_qd);
+					goto fail_brelse;
+				}
+
 				fs_err(sdp, "Corruption found in quota_change%u"
 					    "file: duplicate identifier in "
 					    "slot %u\n",
 					    sdp->sd_jdesc->jd_jid, slot);
 
-				spin_unlock_bucket(hash);
-				spin_unlock(&qd_lock);
-
-				gfs2_glock_put(qd->qd_gl);
-				kmem_cache_free(gfs2_quotad_cachep, qd);
-
 				/* zero out the duplicate slot */
 				lock_buffer(bh);
 				memset(qc, 0, sizeof(*qc));
@@ -1492,11 +1498,10 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 
 				continue;
 			}
+			spin_lock(&qd_lock);
 			BUG_ON(test_and_set_bit(slot, sdp->sd_quota_bitmap));
 			list_add(&qd->qd_list, &sdp->sd_quota_list);
 			atomic_inc(&sdp->sd_quota_count);
-			hlist_bl_add_head_rcu(&qd->qd_hlist, &qd_hash_table[hash]);
-			spin_unlock_bucket(hash);
 			spin_unlock(&qd_lock);
 
 			found++;
@@ -1820,10 +1825,12 @@ const struct quotactl_ops gfs2_quotactl_ops = {
 	.set_dqblk	= gfs2_set_dqblk,
 };
 
-void __init gfs2_quota_hash_init(void)
+int __init gfs2_quota_hash_init(void)
 {
-	unsigned i;
+	return rhashtable_init(&qd_hash_table, &qd_hash_params);
+}
 
-	for(i = 0; i < GFS2_QD_HASH_SIZE; i++)
-		INIT_HLIST_BL_HEAD(&qd_hash_table[i]);
+void gfs2_quota_hash_exit(void)
+{
+	rhashtable_destroy(&qd_hash_table);
 }
diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
index 988f38dc5..dc4ed280c 100644
--- a/fs/gfs2/quota.h
+++ b/fs/gfs2/quota.h
@@ -63,6 +63,7 @@ int __init gfs2_qd_shrinker_init(void);
 void gfs2_qd_shrinker_exit(void);
 extern struct list_lru gfs2_qd_lru;
 
-void __init gfs2_quota_hash_init(void);
+int __init gfs2_quota_hash_init(void);
+void gfs2_quota_hash_exit(void);
 
 #endif /* __QUOTA_DOT_H__ */
-- 
2.34.1

