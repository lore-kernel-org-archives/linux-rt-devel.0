Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1A40243C
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Mar 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954854; cv=none; b=AIL6Au6juZ7CgNFttj0bjiYoe3ATGJvWPGnLxR+/BevUvXVYFrDs5OFCp2tmNn3vhcmxr6APlVya8hvofjzKsrUt4GPPYjW+tkplEMnFrmwXbf1PnxcgRBGZfgE3hvKjybSUAq1R/FnJW7P6cmloRW8PHZKlC/1RRFPS5lbbw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954854; c=relaxed/simple;
	bh=yOUQh/Qr8P8XqIix5oGN+qhabvQxrLR5JATDwg1qSaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VOVhm2tw/qSzWyWGNiNaIHcJuAVJzU+PVDevNyX19ic2pZkQoSYRLpeaGj0k/zswtHreXRZ140P3lEZSuWOs+WarBnYVe/7BUdS0SN4P8WNqUt326vdpiExLmDyyalt3pFnIfHxpIW9pngqV7UYrRGSANHAh82xjy6/WTOKUgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSt48YOB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSt48YOB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773954850; x=1805490850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yOUQh/Qr8P8XqIix5oGN+qhabvQxrLR5JATDwg1qSaw=;
  b=HSt48YOBxK4shti4845+4jscDna/teQg4FAnTnyHCsHbvYcHt6cpzWe9
   Wihn3K0+QNO6GCTDxT8gZm2wOGziwXZ2025emTIjZrvbgh9KCxz8dlt7C
   KnIK+dv3G36jlqx3KN3MIdCb/kwBDQq1N4fDBFXbK83URr1EXjy8wkN8Y
   vMu+IdJxM8bOUpemYeJjDFbQmiEi6yuC2o9oHVd0a5L0b/1o576/Qtuhb
   qqwywlf+16suyF3KjaD7m69Ah1jNN4iczPGAVlvXfyNEyp4NcuRshXG/b
   KgaVkd0nGCr2aXUZ4OWdGQShGq7A6e4eRBIzfL4MaLNiTeHOl2YE9cB4C
   w==;
X-CSE-ConnectionGUID: x0sy35UCQry5erhJM+irZw==
X-CSE-MsgGUID: LLVyNXqEQS61HaVTfGCnFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86116389"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86116389"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 14:14:03 -0700
X-CSE-ConnectionGUID: 2EqDeqCLSlSYjS+eULEVQA==
X-CSE-MsgGUID: 3BQchCY/SRWvkrVajC8CCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227221178"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 14:14:03 -0700
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
Subject: [PATCH iwl-net v2 3/3] idpf: set the payload size before calling the async handler
Date: Thu, 19 Mar 2026 14:13:35 -0700
Message-Id: <20260319211335.23236-4-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260319211335.23236-1-emil.s.tantilov@intel.com>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Set the payload size before forwarding the reply to the async handler.
Without this, xn->reply_sz will be 0 and idpf_mac_filter_async_handler()
will never get past the size check.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index fbd5a15b015c..be66f9b2e101 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -615,6 +615,10 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 		err = -ENXIO;
 		goto out_unlock;
 	case IDPF_VC_XN_ASYNC:
+		/* Set reply_sz from the actual payload so that async_handler
+		 * can evaluate the response.
+		 */
+		xn->reply_sz = ctlq_msg->data_len;
 		err = idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
 		idpf_vc_xn_unlock(xn);
 		return err;
-- 
2.37.3

