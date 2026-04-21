Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287339D6D5;
	Tue, 21 Apr 2026 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761092; cv=none; b=KeZxe27Utf69ZnQiDsKKEzLXHbYXuYwfI1h5ymOYnA0iYcXEVJD2pt5ZaDh5zXH21yd74+fTeUsmcNIaSSh30OqYPd4cKN+VEhx003k2Ab/nwK+OGdw1BxbtdBdtnAAZSwo4b2NPQfJ41M5WcYyOZHeqK2a50ZXGUnNqiLVoGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761092; c=relaxed/simple;
	bh=AQjUld+Anqo7+aCIA2gl9QkbgLroPMXgrUUWnDgJ1Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsWSxmbxxKMSESVXpdBvbkJQ3XGYF3dZBveiefklBb3KtDU4Gv3UiUNvUEWGj4vQfPvQUncBo1OxixxI4vsWdXAz1KNrOnHGxYkliTBCediiBo3J0c8gr/HNvVyiR/zKrJNTibANNqJZmgeOm3B1oZ4Hm4muSEQNuLwqXdg/EU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9/zD5x5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9/zD5x5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776761091; x=1808297091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AQjUld+Anqo7+aCIA2gl9QkbgLroPMXgrUUWnDgJ1Kg=;
  b=N9/zD5x5kQqRyrR6Jez0EDpohcbwaavMf5JkK/3wwHaYa8QDPNysHpsb
   3aBZFNd1LCHNU7g6KQcINTsCVdjY5GDqatUPY+J4VlXqLFR+IptO7GkcL
   QGBH5g7uXcCGj6xNG2XRzT5kmwFMOgva0DgipZsYxXX4+UikhYLtS1CZ0
   Bqw7x4WaOSR/7QH94vY3mPveMtOAtzqns9q1nqr9r1j7S8VqVO9capv7q
   6yJaxQLIrRFRlLX16+nTyD+fKlL9Pn6FTv5fs4HOZX/GsFo6vMx/XMWsV
   HHw+bqBwBET8yjIJXT65z5LUZ0CLzqkiM8nXGkDUWcEJZziAPNDRBprit
   w==;
X-CSE-ConnectionGUID: eCBMhpxFSG2nvwe4Sxuubg==
X-CSE-MsgGUID: CzgUG3waQty29kvCB5E0tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77759836"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="77759836"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 01:44:51 -0700
X-CSE-ConnectionGUID: 1DYzIWz0RJyGf8pGO4Dv1Q==
X-CSE-MsgGUID: LQaQ3VMiRayEuryzYKSyBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="255249155"
Received: from qat-server-366.sh.intel.com ([10.67.116.195])
  by fmviesa002.fm.intel.com with ESMTP; 21 Apr 2026 01:44:48 -0700
From: Jie Wang <jie.wang@intel.com>
To: agruenba@redhat.com
Cc: bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	gfs2@lists.linux.dev,
	linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org,
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com,
	Jie Wang <jie.wang@intel.com>
Subject: [PATCH v2 1/2] gfs2: fix quota init duplicate scan
Date: Tue, 21 Apr 2026 16:32:06 +0000
Message-Id: <20260421163207.48565-2-jie.wang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421163207.48565-1-jie.wang@intel.com>
References: <CAHc6FU5vQWtHNotdA5cjxF6iE4kFRj1E9K55+BBss256KaaKyw@mail.gmail.com>
 <20260421163207.48565-1-jie.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_quota_init() checks for duplicate quota_change IDs while holding
qd_lock and the quota hash bucket bitlock. That path used
gfs2_qd_search_bucket(), which takes a lockref reference via
lockref_get_not_dead().

On PREEMPT_RT this may sleep, which is not allowed under the bucket
bitlock, triggering "sleeping function called from invalid context".

Use a no-ref bucket lookup in this path, then continue duplicate
handling without taking a lockref there.

Refactor gfs2_qd_search_bucket() to build on top of the no-ref helper
so lookup traversal stays in one place.

This patch fixes a bug reported by syzbot.

Reported-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=642d0561f78362d67d3f
Tested-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
Signed-off-by: Jie Wang <jie.wang@intel.com>
---
 fs/gfs2/quota.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 5290865f27f1..df1cb99c3344 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -254,9 +254,13 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, str
 	return NULL;
 }
 
-static struct gfs2_quota_data *gfs2_qd_search_bucket(unsigned int hash,
-						     const struct gfs2_sbd *sdp,
-						     struct kqid qid)
+/*
+ * Lookup variant for callers which already hold qd_lock + bucket lock.
+ */
+static struct gfs2_quota_data *
+gfs2_qd_search_bucket_noref(unsigned int hash,
+			    const struct gfs2_sbd *sdp,
+			    struct kqid qid)
 {
 	struct gfs2_quota_data *qd;
 	struct hlist_bl_node *h;
@@ -264,12 +268,22 @@ static struct gfs2_quota_data *gfs2_qd_search_bucket(unsigned int hash,
 	hlist_bl_for_each_entry_rcu(qd, h, &qd_hash_table[hash], qd_hlist) {
 		if (!qid_eq(qd->qd_id, qid))
 			continue;
-		if (qd->qd_sbd != sdp)
-			continue;
-		if (lockref_get_not_dead(&qd->qd_lockref)) {
-			list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
+		if (qd->qd_sbd == sdp)
 			return qd;
-		}
+	}
+
+	return NULL;
+}
+
+static struct gfs2_quota_data *
+gfs2_qd_search_bucket(unsigned int hash, const struct gfs2_sbd *sdp, struct kqid qid)
+{
+	struct gfs2_quota_data *qd;
+
+	qd = gfs2_qd_search_bucket_noref(hash, sdp, qid);
+	if (qd && lockref_get_not_dead(&qd->qd_lockref)) {
+		list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
+		return qd;
 	}
 
 	return NULL;
@@ -1458,16 +1472,15 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 
 			spin_lock(&qd_lock);
 			spin_lock_bucket(hash);
-			old_qd = gfs2_qd_search_bucket(hash, sdp, qc_id);
+			old_qd = gfs2_qd_search_bucket_noref(hash, sdp, qc_id);
+			spin_unlock_bucket(hash);
 			if (old_qd) {
 				fs_err(sdp, "Corruption found in quota_change%u"
 					    "file: duplicate identifier in "
 					    "slot %u\n",
 					    sdp->sd_jdesc->jd_jid, slot);
 
-				spin_unlock_bucket(hash);
 				spin_unlock(&qd_lock);
-				qd_put(old_qd);
 
 				gfs2_glock_put(qd->qd_gl);
 				kmem_cache_free(gfs2_quotad_cachep, qd);
@@ -1483,6 +1496,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 			BUG_ON(test_and_set_bit(slot, sdp->sd_quota_bitmap));
 			list_add(&qd->qd_list, &sdp->sd_quota_list);
 			atomic_inc(&sdp->sd_quota_count);
+			spin_lock_bucket(hash);
 			hlist_bl_add_head_rcu(&qd->qd_hlist, &qd_hash_table[hash]);
 			spin_unlock_bucket(hash);
 			spin_unlock(&qd_lock);
-- 
2.34.1

