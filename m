Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512F83750D7;
	Mon, 20 Apr 2026 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776655145; cv=none; b=U1A98wZov7EwS7UW5GSuAmuwYQ2zx94usEkr/uI8rb2aVqzj1uh8/cPIpsSI8jhPF5cH0cjleD1jYNXoXuxeMhz68pN7T3YLLkIZDrkEZ9+4j1VEziKNfECol32Pi7Ovdgs13idPM3PehddN+0MS+pKxGIllkgler8pQwbdBcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776655145; c=relaxed/simple;
	bh=1bxUidDXnuX4Rrmsk0OJ2++qsMgWu032Ens3VIhCm0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amOvOLCXwtIst2lcRscK2CTBEBjOSSO2r6ieLCBVa3smTbDseAMiH5TrEnAHXA+QiC+RBjgUC/TX/qbr0ruL2KWYk/bEeWv7Xm+sAkvJmNmD4/aorAgCxMRjn9X/G5rKsf6QUWAA7ws0SflO37c3nUMF8MuMgbXI0HQ281qKA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cG512nBl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cG512nBl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776655143; x=1808191143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1bxUidDXnuX4Rrmsk0OJ2++qsMgWu032Ens3VIhCm0E=;
  b=cG512nBlTGBKGiIqEM36lMUzau4VdDJtoayIz8T6qsWSTupqbagUZWHu
   ZScsqF+IBq35VrtxqRnEOPIZQwjhEgK4f2dsTc9zMnmymjb9dyeXyQFH1
   QKIyiPPM1VnTbWbUJplHY+9AIQGVZAaHmgp8scjWAiOaFlkYvcgizDzjR
   p2XqUoahE7IPruxOBJrDa6yTk1WIzSt8tLQ0E1tptv4IZC7xYwwHzWfUd
   1K980RlAuuHmpKgcO/Hwv5dsLaWdvk24hSC6gDmHspIgL8Hk0aqEwhCfA
   0Re1ZXVp5oWwgRaeBIGldWjeVU2aXVipjOhMoVx/4ScFFqakWlukMRSgz
   w==;
X-CSE-ConnectionGUID: Zrc9NWZ0RjGkgjYhJTm6vw==
X-CSE-MsgGUID: nVG9Uwt+QgSKu5F2raEP2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="80153592"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="80153592"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 20:19:02 -0700
X-CSE-ConnectionGUID: oAjuM7i7ScaGz4zFrO+pgg==
X-CSE-MsgGUID: E1jeWM3iRXqbP7yLfpKP3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="225097829"
Received: from qat-server-366.sh.intel.com ([10.67.116.195])
  by fmviesa009.fm.intel.com with ESMTP; 19 Apr 2026 20:19:00 -0700
From: Jie Wang <jie.wang@intel.com>
To: agruenba@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: gfs2@lists.linux.dev,
	linux-rt-devel@lists.linux.dev,
	Jie Wang <jie.wang@intel.com>,
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: fix quota init duplicate scan
Date: Mon, 20 Apr 2026 11:06:22 +0000
Message-Id: <20260420110622.9742-1-jie.wang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_quota_init() checks for duplicate quota_change IDs while holding
qd_lock and the quota hash bucket bitlock. That path used
gfs2_qd_search_bucket(), which takes a lockref reference
via lockref_get_not_dead().

On PREEMPT_RT this may sleep, which is not allowed under the bucket
bitlock, triggering "sleeping function called from invalid context".

Use a no-ref bucket lookup in this path, then continue duplicate handling
without taking a lockref there.

Also save the current qc pointer before iterator advance, and clear that
saved slot on duplicate so the correct on-disk entry is zeroed.

This patch fixes a bug reported by syzbot.

Reported-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=642d0561f78362d67d3f
Tested-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
Signed-off-by: Jie Wang <jie.wang@intel.com>
---
 fs/gfs2/quota.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 5290865f27f1..0191ba211670 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -275,6 +275,25 @@ static struct gfs2_quota_data *gfs2_qd_search_bucket(unsigned int hash,
 	return NULL;
 }
 
+/*
+ * Lookup variant for callers which already hold qd_lock + bucket lock.
+ */
+static struct gfs2_quota_data *
+gfs2_qd_search_bucket_noref(unsigned int hash, const struct gfs2_sbd *sdp, struct kqid qid)
+{
+	struct gfs2_quota_data *qd;
+	struct hlist_bl_node *h;
+
+	hlist_bl_for_each_entry_rcu(qd, h, &qd_hash_table[hash], qd_hlist) {
+		if (!qid_eq(qd->qd_id, qid))
+			continue;
+		if (qd->qd_sbd == sdp)
+			return qd;
+	}
+
+	return NULL;
+}
+
 
 static int qd_get(struct gfs2_sbd *sdp, struct kqid qid,
 		  struct gfs2_quota_data **qdp)
@@ -1435,6 +1454,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 		for (y = 0; y < sdp->sd_qc_per_block && slot < sdp->sd_quota_slots;
 		     y++, slot++) {
 			struct gfs2_quota_data *old_qd, *qd;
+			struct gfs2_quota_change *dup_qc = qc;
 			s64 qc_change = be64_to_cpu(qc->qc_change);
 			u32 qc_flags = be32_to_cpu(qc->qc_flags);
 			enum quota_type qtype = (qc_flags & GFS2_QCF_USER) ?
@@ -1458,23 +1478,22 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 
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
 
 				/* zero out the duplicate slot */
 				lock_buffer(bh);
-				memset(qc, 0, sizeof(*qc));
+				memset(dup_qc, 0, sizeof(*dup_qc));
 				mark_buffer_dirty(bh);
 				unlock_buffer(bh);
 
@@ -1483,6 +1502,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 			BUG_ON(test_and_set_bit(slot, sdp->sd_quota_bitmap));
 			list_add(&qd->qd_list, &sdp->sd_quota_list);
 			atomic_inc(&sdp->sd_quota_count);
+			spin_lock_bucket(hash);
 			hlist_bl_add_head_rcu(&qd->qd_hlist, &qd_hash_table[hash]);
 			spin_unlock_bucket(hash);
 			spin_unlock(&qd_lock);
-- 
2.34.1

