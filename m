Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B5175A6B;
	Tue, 21 Apr 2026 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761090; cv=none; b=nbq62cnHn/PWyRu//U0o38I+vaKg/4PCd4NL3ryCdMjAMd20qgLc8e/Z3k7gVjhu7l1fbXmx8lHmxWyXH0jISqNwHIS9KjStU6riw6OmcCMpJPQpDYTXi1blRf5vUf2RZRWHV03CRwUJM96dBcomFmLd/bsZRPYWR6cQKQaSc/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761090; c=relaxed/simple;
	bh=m5yvGRYC7jhgQtzPEzPDeeYIeiLsNfqKaGveuLlYWj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGBuVheyXN1tvHjr6IZ0DDTEIE3ffYMUqtpjnHJpwdkYObzjKwYfRzKWNmUYLD2u2jZuEgqiWFeoDbltza5KFMaajuoGtrLN2pOGWDEXw2P6+Uy9bOs5mR+jgK21I8d8y9+7B7XgjdeMpc4rRYCTxsqPK3hx6/9FbnhYK1J1/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6MoSdtO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6MoSdtO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776761089; x=1808297089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m5yvGRYC7jhgQtzPEzPDeeYIeiLsNfqKaGveuLlYWj0=;
  b=e6MoSdtOlOwcqtlnV/gouiSL3/Q43IWb1SUgir7UeI7kQcQ0SZzdP9V1
   2ivt2H8GeXzIBoMl4aLiOS74uAwel1cyBsNsLCQ3txfOpFOrcm+EnT5T5
   ZSj8HEqKoaj7m8L+H/doh8OXDcooGvuKaJoNzvl2M/hrpZ0MWjC2lTSl4
   ViNzKnygDCSRcYGs4PTCoJRW3jrlmteYJSMWNB37ukQzQLdUnxE3zRw1A
   hLAbc6a2lUcrpnulWvt5ITXytz7zAUrBOJdQ84KOVG7GV1GeLFdpuOvOi
   kjNj2e4SRmIUPWcSqktMpFUGrdceirEdiyfE1kbxhQNm+g4df+Z7Vvo95
   g==;
X-CSE-ConnectionGUID: MKrB1reURYWY2KDoVm6Z8g==
X-CSE-MsgGUID: /K+wCqwNTBeeIIDFRi5asg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77759830"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="77759830"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 01:44:48 -0700
X-CSE-ConnectionGUID: sPWhK0coR3qM1uTjs+tPrQ==
X-CSE-MsgGUID: NYkUMWG7TZeyr2LzCXJlvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="255249146"
Received: from qat-server-366.sh.intel.com ([10.67.116.195])
  by fmviesa002.fm.intel.com with ESMTP; 21 Apr 2026 01:44:46 -0700
From: Jie Wang <jie.wang@intel.com>
To: agruenba@redhat.com
Cc: bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	gfs2@lists.linux.dev,
	linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org,
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com,
	Jie Wang <jie.wang@intel.com>
Subject: [PATCH v2 0/2] gfs2: fix quota init duplicate scan on PREEMPT_RT
Date: Tue, 21 Apr 2026 16:32:05 +0000
Message-Id: <20260421163207.48565-1-jie.wang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHc6FU5vQWtHNotdA5cjxF6iE4kFRj1E9K55+BBss256KaaKyw@mail.gmail.com>
References: <CAHc6FU5vQWtHNotdA5cjxF6iE4kFRj1E9K55+BBss256KaaKyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses the PREEMPT_RT issue reported by syzbot in
gfs2_quota_init() duplicate-id handling.

On PREEMPT_RT, taking a lockref reference under the quota hash bucket
bitlock may sleep and trigger "sleeping function called from invalid
context".

Patch 1 fixes that path by using a no-ref lookup, and implements
gfs2_qd_search_bucket() on top of the no-ref helper.

Patch 2 keeps duplicate-slot zeroing correctness adjustment separate,
and expresses it by moving qc++ to the for-loop third expression.

Changes in v2:
- Split v1 into two patches as requested.
- Implement gfs2_qd_search_bucket() on top of
  gfs2_qd_search_bucket_noref().
- Move qc++ into the for-loop third expression.

The qd_hash_table -> rhashtable conversion is a larger refactor and is
kept out of this bugfix series.

Jie Wang (2):
  gfs2: fix quota init duplicate scan
  gfs2: move quota_init qc iterator increment

 fs/gfs2/quota.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

-- 
2.34.1

