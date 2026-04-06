Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DB30F55B
	for <linux-rt-devel@lists.linux.dev>; Mon,  6 Apr 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511045; cv=none; b=EpyQNQ8H1I9zlGv3VYWx+GghmGWJwpowd/AlMpzLoacsOTtUokNyKkd1GB2x4xzWkeQXFGudNYOhicOLX8mNmIqgmPKB+NoRUiK58GvYf3L9UdCSXFYrA7Xy8iuLembjRgerjl1iZlEdzTolfyrpWPbtWtxr4u5KB8+pY/8gdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511045; c=relaxed/simple;
	bh=MB2fVYyMYCmQvw4kqR1JgkxKBAlJ/OcpfBqFXmVy+rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMbLyDYHq2Kmo3dBjfDefHlDzdtnOXV1TQbTWEVvp6QiULtX9jmrs978bwMWdFuzmUUmtxU/fesMH/rBOObI34sMJJ3aF4KVYNqCLtSzrMqKjh+eiGGP6gnYREqjBXhoYMjEbv/E8m1ceiEhwZaqxLUw8XE5kzogfj49D9thLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igvDLmXs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igvDLmXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775511043; x=1807047043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MB2fVYyMYCmQvw4kqR1JgkxKBAlJ/OcpfBqFXmVy+rg=;
  b=igvDLmXsBGOKxq/cZc5BnNf3S8MDK2AtTC+HD0vTvWbZXB/nKaX/99vJ
   beFTF/fmyfvXzM2gT9icYpmcYbuD9rb78/is6DSmlj6Rjvd0er/mhdvR/
   8WaRED+6EH9ixf6fHg/8qJyJOF8G95C3mVdvnUck3HxDmGAs1gxAUBFic
   yhEjBNHVLlywieDuh70lIZdEaHGRQFglreXgISnWa6wUMmvyFJvGJzEHa
   RmjUEvQhGhV4cixxfjP+tIjEE6cda7SEDwgt4+O8u34r6Tg1MM8V/vMmF
   p+A9SxXLKGtugZtl0Qc9liv7y5Fe/yhFlVsBDvv3K1mqeXclsYq0hlTGQ
   g==;
X-CSE-ConnectionGUID: XOPZ8U/dTG2yvE+u6C5HWw==
X-CSE-MsgGUID: bBRcnJhyQa67aQIR2zTInQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="79057381"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="79057381"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 14:30:41 -0700
X-CSE-ConnectionGUID: k0y2AoyvRASaLeCsM3/+jA==
X-CSE-MsgGUID: mBhsy9hhQ6ei28myPHHX8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="228248104"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 06 Apr 2026 14:30:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Li Li <boolli@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 3/9] idpf: set the payload size before calling the async handler
Date: Mon,  6 Apr 2026 14:30:30 -0700
Message-ID: <20260406213038.444732-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
References: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Set the payload size before forwarding the reply to the async handler.
Without this, xn->reply_sz will be 0 and idpf_mac_filter_async_handler()
will never get past the size check.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Li Li <boolli@google.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1

