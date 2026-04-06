Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43971514E4
	for <linux-rt-devel@lists.linux.dev>; Mon,  6 Apr 2026 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511043; cv=none; b=XfgijTisYcpSHprkZ29XefQjcB4f3jjBX9fyyFEr5/aUxWa/tHtx2rt7L6X27hDgKEgixaN5kDJf+GLYM4vjWSVEyK8t6PqLBGTChNpSTfDbnQuMoDrfvzHRFsfXW53Hpos264MlClCmbPFXTGjPfxN2GpOjryTK0Fd1Mx4PD7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511043; c=relaxed/simple;
	bh=EBBX5AvIPQbD/OevBQffUNUxIiVWvmO32BVoUF8K2vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYnOGYFYQwE/Wk2K5kbq+fUQFs0y3bSZIkVSZk4Iky2BXpZLrhiOF7zFRevHMtUQ4JFROdqPZVokk8vrk+Fx8z6jZQbKYVREfWFHvAdAwj7A0NNqhvDAVDYp4oBvB4Xsatr5Stnz0Hp0zw3J/rXm9IEKm7RzE0z3UGaeOM498Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhIAt0/b; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhIAt0/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775511042; x=1807047042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EBBX5AvIPQbD/OevBQffUNUxIiVWvmO32BVoUF8K2vA=;
  b=UhIAt0/bNd2kf3pRbuxXTw0zYZPRcPQiScNDESLZD8KfBIcnG3lbkxhe
   oTT6bVQ6qYKx9i/RlGG//Jat9O4xHhpHc5/mJno7Xmjwtw/PhOTH0XdAc
   QtoMFGhkB7gb1o1Zsdd1w0VIbZ8Ocs5dR9Vq3+WMy3/W63UY10Msgv24p
   jBrFwj15Nm3Y7VzseFCQ2Q3qNPYJuqmN1voEdDlJjlGtaqy+n6szcMg9E
   gUahQ+oZBMX6rxE1YLft4yxSbfD/20w+ECcj3APRewM4HJ5TCDDdnZH0q
   c20cfUQGw5TuDv2ZVH/q5tncPbJ6zVgKpXxoM3xoN7odazQ1Vu8rKZiOS
   A==;
X-CSE-ConnectionGUID: uuB58y/kQWKoxjfwW16QoQ==
X-CSE-MsgGUID: W+T/5UDtTh6BB6NcANdyKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="79057372"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="79057372"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 14:30:41 -0700
X-CSE-ConnectionGUID: 4Jo9KR5mRWqdTESjopBtWQ==
X-CSE-MsgGUID: wlc/CXaaTCeXh1hCfsQNxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="228248101"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 06 Apr 2026 14:30:40 -0700
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
	Ray Zhang <sgzhang@google.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 2/9] idpf: improve locking around idpf_vc_xn_push_free()
Date: Mon,  6 Apr 2026 14:30:29 -0700
Message-ID: <20260406213038.444732-3-anthony.l.nguyen@intel.com>
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

Protect the set_bit() operation for the free_xn bitmask in
idpf_vc_xn_push_free(), to make the locking consistent with rest of the
code and avoid potential races in that logic.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org
Reported-by: Ray Zhang <sgzhang@google.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1

