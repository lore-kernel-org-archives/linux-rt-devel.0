Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED9379EFE
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Mar 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703696; cv=none; b=fICWfAPtOzompBuFCp0zAm+pqCUnl+4QCGdpRXZZOWxghUbM3I94V0MCqBDnEd886neCA0OXHhmJLXdUOOVZ0HQ/P6ztuMU1FjXnwRelhPmZrwohXpKPHjYNTHb3Gi6rl0tn/sI3aVrLtTIDsqMhBF8YnoFhIE5tCW/1jXs1hXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703696; c=relaxed/simple;
	bh=CAIUH0+yh38w0o420zH+OMnFXaDbOeNykS80/u8yIBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j4inEFySDZvdW2VgDdlIqA7NuJ2O8/iDKGIKUZDFREULstRbbOuNxhy2HgBbPULU22nM3Sv6TLEYz7sWOt1I5RSV5vawYLNYJq/KxhPI6X3DTTFIu8TxHjxZrWg6/jVUlBVwiat7ahUwde9xSP96ycG70VQN72SJxEDSaDJT3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aO8SEMaf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aO8SEMaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773703694; x=1805239694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CAIUH0+yh38w0o420zH+OMnFXaDbOeNykS80/u8yIBI=;
  b=aO8SEMafjoPt1ok9sixX8WdkiKbSWkfwVctPzs7qPYs2qF47Er2fEsMQ
   4f7UQsObFR432oifP82DSa0a/PEOMLDOm6DQ+OcLRXP8XXf2pTdrb7DYs
   QeR6zOkGo4No7Hh4jWZrNPHMkeUdNB19FZwe0Ko+KmzpcSevjhGmRUF5e
   XARI7N1nAWG3gmalgdQL9wP5jCu/9hWg1GJxJkfQ0ewGg91jLhXVLmefB
   O0FBMYqG+qypGPF989Uhkuxiurrui7TR5ZGzxuWCTJohcEqsBQPgJltTf
   cuMPpE6h8qdhHtuBAuIKRdZn/Ur9w7TWv0B0Ptao0TvBdNAIW6LI5lWom
   A==;
X-CSE-ConnectionGUID: ca6SMlMxQA+HX5ajFLtYTA==
X-CSE-MsgGUID: CfZh6MUERG+2sPh9AcLygQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74912811"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74912811"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 16:28:12 -0700
X-CSE-ConnectionGUID: E8ySiVK7SmurQ1p8rk3GJw==
X-CSE-MsgGUID: csyx8qbAQ5Ws3qsMJ4pZmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="246842468"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa001.fm.intel.com with ESMTP; 16 Mar 2026 16:28:12 -0700
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
	boolli@google.com
Subject: [PATCH iwl-net 2/3] idpf: set the payload size before calling the async handler
Date: Mon, 16 Mar 2026 16:28:18 -0700
Message-Id: <20260316232819.6872-3-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260316232819.6872-1-emil.s.tantilov@intel.com>
References: <20260316232819.6872-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Set the payload size before forwarding the reply to the async handler.
Without this, xn->reply_sz will be 0 and idpf_mac_filter_async_handler()
will never get past the size check.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 21a6c9d22085..6b9692b30040 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -627,6 +627,10 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 		err = -ENXIO;
 		goto out_unlock;
 	case IDPF_VC_XN_ASYNC:
+		/* Set reply_sz from the actual payload so that async_handler
+		 * can evaluate the response.
+		 */
+		xn->reply_sz = ctlq_msg->data_len;
 		err = idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
 		idpf_vc_xn_unlock(xn);
 		idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
-- 
2.37.3

