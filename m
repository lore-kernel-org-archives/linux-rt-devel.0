Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE520175A6B;
	Tue, 21 Apr 2026 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761094; cv=none; b=Eli7JW4HV2P5fClHI3YgfzXYLtWxMG9xIURr+prdwKV73Sqi4TaVGxdLEre4HsL0UJn0DYVHbZGesq839cimeo/pzxMeFgMGKeaX5zRVePzQ8NdvPO1UizcDD37tY674chOt0kWY8IgPUpdvArrfWAv3UlMErxjz0kBRUivLHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761094; c=relaxed/simple;
	bh=0vsjGmDeMCKUgFTIprjFPbmC5sX/HWjVHit8MEoa2d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tdTEu7zog6I0kF7kNeG98sRIVZdjCa1PkFDl89uGrYv4GdaHTYXR42wEP6AWnhOL/RiO8Lm7o2Q5Tn4BkWicvO9pFYl56nXQZZRItIIqR+JfbgfVvPEQ2XBO0Zk8wWw5oSKOIfXyJxaGVr/zPv3MRPVflzA0yeXxvVIcN2cYgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1yB7Hb9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1yB7Hb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776761093; x=1808297093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0vsjGmDeMCKUgFTIprjFPbmC5sX/HWjVHit8MEoa2d8=;
  b=i1yB7Hb9+a5sHpmrkwt23lb8QzUBA6A/7M/aNM45tqlk8FYbiuV8I0C4
   BqGxyz+fyeOlhoCeeUcT6OJb35mYJy0jKhFxZjWHgW2Oy6w2yGXq0ocpb
   H5uBA4PmBjK1NY9FvCVol6Gs5mesTMZW2j9W2IkmV3hPySrLL/KWexxY9
   zoSBEDtfzJtT7H3qSNXGmWPkGDMLY28V0kVRibWTQ0hLA30melRi9Z6BS
   1sHBnqy6ntKumSzP/R2qQyv9qF6pRiB+kONkv1pZ02hNHnWSjrSf9GmIA
   xMC3cFvPcBAC+Y+E9A0ro4C5hN7h1nH9Wdo8MJ7mKXlp5Xw9wC8FVO3sj
   w==;
X-CSE-ConnectionGUID: E1J0cuhPQtGuoe2wNR0W8Q==
X-CSE-MsgGUID: CGw/dgs7R+KuTvkhFguNrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77759843"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="77759843"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 01:44:53 -0700
X-CSE-ConnectionGUID: AJMJhEKKQm+M8QgnFm+CAA==
X-CSE-MsgGUID: FYlqJqGKSIiTIAzSaVeloA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="255249160"
Received: from qat-server-366.sh.intel.com ([10.67.116.195])
  by fmviesa002.fm.intel.com with ESMTP; 21 Apr 2026 01:44:50 -0700
From: Jie Wang <jie.wang@intel.com>
To: agruenba@redhat.com
Cc: bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	gfs2@lists.linux.dev,
	linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org,
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com,
	Jie Wang <jie.wang@intel.com>
Subject: [PATCH v2 2/2] gfs2: move quota_init qc iterator increment
Date: Tue, 21 Apr 2026 16:32:07 +0000
Message-Id: <20260421163207.48565-3-jie.wang@intel.com>
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

Move qc++ from the loop body into the for-loop increment
expression in gfs2_quota_init().

This keeps iterator progression explicit and avoids mixing pointer
advance with duplicate-slot handling in the loop body.

Signed-off-by: Jie Wang <jie.wang@intel.com>
---
 fs/gfs2/quota.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index df1cb99c3344..b9e13fe286be 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1447,7 +1447,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 
 		qc = (struct gfs2_quota_change *)(bh->b_data + sizeof(struct gfs2_meta_header));
 		for (y = 0; y < sdp->sd_qc_per_block && slot < sdp->sd_quota_slots;
-		     y++, slot++) {
+		     y++, slot++, qc++) {
 			struct gfs2_quota_data *old_qd, *qd;
 			s64 qc_change = be64_to_cpu(qc->qc_change);
 			u32 qc_flags = be32_to_cpu(qc->qc_flags);
@@ -1455,7 +1455,6 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 						USRQUOTA : GRPQUOTA;
 			struct kqid qc_id = make_kqid(&init_user_ns, qtype,
 						      be32_to_cpu(qc->qc_id));
-			qc++;
 			if (!qc_change)
 				continue;
 
-- 
2.34.1

