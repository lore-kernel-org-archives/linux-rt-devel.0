Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FB2868A9;
	Thu, 23 Apr 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776923538; cv=none; b=GVnvWECKLSrRPoq1cFQCAFbmMlyBpj5x08qDrNzUY9/L8LQMztMg7np+zVPxHcpkLLkx1W9ty2FmGmQdZMSVx1nuoHXKHcj6ithQzC8CngcTGUD1/uhLoWPIz82Fe5sJaVJuULx3J+ptG5mKnSwhX7uUMHtxwSeldU/fO/CT1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776923538; c=relaxed/simple;
	bh=rKTzlYIzGEU/GP3toG2KejY1cHr+1TxjOTyx9Ez3Mpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iGrnEFhGF9Wj6ulqIZ1av505pibkQAadyTu8Tajr/bts5SeW/2Sf7nFEFESzcIWNDXcEdQqdhyO9MmNQa1i78YsZN+xeBhTmcL+gfNGw/y87KFD+FU0M/g+9R1EOI06dN/04F1VtBZlGJkoPrRMJn/PQ2w/KwdcxKF0ht+aBmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgPmazqg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgPmazqg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776923537; x=1808459537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rKTzlYIzGEU/GP3toG2KejY1cHr+1TxjOTyx9Ez3Mpk=;
  b=QgPmazqg3qU9g0bT4RiD9On3ZrwUvj2Mn7o8TuT+KvrD1YGr3nS0eqNv
   mvyzC+CEg7Sm8v3IbN7XXKsHv4MX6H/Z6uhBKlOwxc9ZIqtbj50VePNar
   oObjFWMOEH9iFUHrUQ/74ByBN+DvGx4HSXGGgY7LN5vBaEk2PWhuS+JUa
   K+vxNl4uPZq0IWTDcMGQJh8bPwZnBLa92zV1XWeVCcXU/Ym9Iz5IW4e8e
   gq3BBymQu44EXWUSh82YkIrar2p4ppu6FObO45doSz8+SlChPVMzrxbFO
   xO+GBibZQ04Gh/dcDo0uKxdb+7AYwjN45UyzxOIU778tonp9reZ87z7ko
   w==;
X-CSE-ConnectionGUID: NQwV1K4uRCej2XGbQMiO4Q==
X-CSE-MsgGUID: 27loXouTTrm4HEuuUOFKXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81747554"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="81747554"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 22:52:16 -0700
X-CSE-ConnectionGUID: cSaCokB5Q623OCkARR85HA==
X-CSE-MsgGUID: f4Cf/74SQgyDdoKAcj+J7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="234349390"
Received: from qat-server-366.sh.intel.com ([10.67.116.195])
  by fmviesa004.fm.intel.com with ESMTP; 22 Apr 2026 22:52:14 -0700
From: Jie Wang <jie.wang@intel.com>
To: agruenba@redhat.com
Cc: bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	gfs2@lists.linux.dev,
	jie.wang@intel.com,
	linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org,
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
Subject: [PATCH v3] gfs2: fix quota init duplicate scan
Date: Thu, 23 Apr 2026 13:39:34 +0000
Message-Id: <20260423133934.118970-1-jie.wang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHc6FU5Zx4jQ9_c7wtJeeSF=V895hwCa47OvK0Qm_oFGK1YbPg@mail.gmail.com>
References: <CAHc6FU5Zx4jQ9_c7wtJeeSF=V895hwCa47OvK0Qm_oFGK1YbPg@mail.gmail.com>
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
v3:
- Keep spin_unlock_bucket(hash) in the if (old_qd) path.
- Drop the extra spin_lock_bucket(hash) before insertion.
 
 fs/gfs2/quota.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 5290865f27f1..934397248fe7 100644
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
@@ -1458,7 +1472,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 
 			spin_lock(&qd_lock);
 			spin_lock_bucket(hash);
-			old_qd = gfs2_qd_search_bucket(hash, sdp, qc_id);
+			old_qd = gfs2_qd_search_bucket_noref(hash, sdp, qc_id);
 			if (old_qd) {
 				fs_err(sdp, "Corruption found in quota_change%u"
 					    "file: duplicate identifier in "
@@ -1467,7 +1481,6 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 
 				spin_unlock_bucket(hash);
 				spin_unlock(&qd_lock);
-				qd_put(old_qd);
 
 				gfs2_glock_put(qd->qd_gl);
 				kmem_cache_free(gfs2_quotad_cachep, qd);
-- 
2.34.1

