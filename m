Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4765402433
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Mar 2026 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954850; cv=none; b=mWnj64FLYvDJjI94E20gaOqyQh1V3w7O+Fa81K4fWZXiqtoyyVhJCt6OL8oHeYmnNmKsB4pi55NIdb+EE04OweJvqnWX0baiHiBDy7HoVcr9MA9HSdj5uM4JOuAdyv+PHJjzu60THe5msGuV9YEGKI2HtAa4/CvJQuXggI61XH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954850; c=relaxed/simple;
	bh=oRpzbw8xGxDnBQtkUrD1pw82znTvjifsBtJ+zx1wwAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=B4PVpMVtaVZ+tOSusoyF+eUOsMPVLJ+xSaWLtrN1nes36QdHPV6U7noIQavgNLVDxxWyxRxjNtSZq3UvoS0bK3NzSQSrMeLcTkRz3H2PCrraPJD+8G/wTQqnDTGj06+mxxTmVaJ/iUANtPe+IwitaOfaORfkWybN2ovMYLaQy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O//n8t3L; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O//n8t3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773954846; x=1805490846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=oRpzbw8xGxDnBQtkUrD1pw82znTvjifsBtJ+zx1wwAI=;
  b=O//n8t3L8qCw9ekOaxxx99GGTyngwUtcKf4a/39UN1fGhUW4d0hvEC6h
   P2Bwq0GCdzmad0Xkf+UOEyiD/4s4hM8iOWfkFh3LsxWgvyLPh11WxO8Ds
   wePwQtke4XPNt2+yfvHPnSqAGQ+MG6CBg2bLtzSvywMLSAqboPofUt8mk
   CcuurIKsU2xEePxQAOmScz25wdCqQSHlEVKDI/H2R+QGzAE2G7YXvZaMa
   iOatXqZHWbP4Ps3Lrr1kF8HkVVTeWgvgfWWzCDrNLV0AlXmflm8grTskG
   QDgn2YH1ckTQZb8TWcr7UDDxmUZTpdmMqO0mdQzhnr8hufLJZDC0r4mth
   A==;
X-CSE-ConnectionGUID: U//0w35hST2O03hGk5g/5A==
X-CSE-MsgGUID: Tqmz2iRjSMGYZkQctUwYXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86116377"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86116377"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 14:14:03 -0700
X-CSE-ConnectionGUID: REe93wI8QfGVVyM1f/5zkA==
X-CSE-MsgGUID: JCzPACKwTgKixmtbe025Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227221175"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 14:14:02 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	sgzhang@google.com,
	boolli@google.com,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2 2/3] idpf: improve locking around idpf_vc_xn_push_free()
Date: Thu, 19 Mar 2026 14:13:34 -0700
Message-Id: <20260319211335.23236-3-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260319211335.23236-1-emil.s.tantilov@intel.com>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Protect the set_bit() operation for the free_xn bitmask in
idpf_vc_xn_push_free(), to make the locking consistent with rest of the
code and avoid potential races in that logic.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org
Reported-by: Ray Zhang <sgzhang@google.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 582e0c8e9dc0..fbd5a15b015c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -402,7 +402,9 @@ static void idpf_vc_xn_push_free(struct idpf_vc_xn_manager *vcxn_mngr,
 				 struct idpf_vc_xn *xn)
 {
 	idpf_vc_xn_release_bufs(xn);
+	spin_lock_bh(&vcxn_mngr->xn_bm_lock);
 	set_bit(xn->idx, vcxn_mngr->free_xn_bm);
+	spin_unlock_bh(&vcxn_mngr->xn_bm_lock);
 }
 
 /**
-- 
2.37.3

