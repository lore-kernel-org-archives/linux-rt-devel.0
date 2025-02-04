Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66821638A
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Feb 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691577; cv=none; b=lziu8qKTYK7LMpu/XjW3xffABEd4ZWPuatDb42hfjSOpKKRBz0y+XxKbjunZfGmpsdm/4VQGhbbg/Na1wXZ990LTpsdnES1XyxFzAA0GR3q3uUrhWcMoMMy5L1n8U90sLwYuI83Ql0OEpACLRfzu/6vr3mS5yT3IPwMvkB9SuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691577; c=relaxed/simple;
	bh=DjRRCNPcLPWjuJq1XFZ/jGqru4FOEvkn8qDPdjG7ZKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av+6aauJH1HdQrC5DX23xsqe6KDJVD8dVe1njREyb7lRgGcUCa44qhf//ZzK5fp/7NKjM61Hj+MGQWpN90XUMgZZ5UcKyvU7/jT3P9gAAKdvRJS5af6rpvXcHh8E4CoW7ola+Q9Ght0nvq1YJ+Kw/8YyyKgNPTD56Teh3zVkXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3h9Tiez; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3h9Tiez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691575; x=1770227575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DjRRCNPcLPWjuJq1XFZ/jGqru4FOEvkn8qDPdjG7ZKE=;
  b=e3h9TiezhLCXAS6Bl3K1stMFQjUHilOnd4vu1T2Vc0MVFRd1wYoOPKVU
   fUq3A+jzHmZGw3Xxhtg9+UAe8uJlmEghgNLIXemfBLAwW+UBw3uD9KwS+
   gszXKO57Ww4Y0Hwjzsvv/LxmaqbPkcACsFyrP0h0Y9cMe9vAnTcg5RSVY
   9lJ/LOJ5e1CLDVv7jGhddFBdorbxyL7acDYg3Nb9oDFniRsRyy+/gkADm
   vRX+mVWBxmxDrqAGqytYgQeo+CSxkuI+7x9n+hAh7EleAN9SqrAxEFZzz
   ga+53NeT7zLaYfBvZvtrc0OVXdHCezCpK2/CKl+b/pJ+I6o1erkbAfMRa
   g==;
X-CSE-ConnectionGUID: xXhX5JSgT9G8qR9g835bww==
X-CSE-MsgGUID: LYlGEmDlSR23aq4kATwEqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39371877"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39371877"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:52:54 -0800
X-CSE-ConnectionGUID: 7mdMjiabSVS+VCPErw1DRw==
X-CSE-MsgGUID: +MHDgjemSuqPDMEu8JTX+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110652387"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 04 Feb 2025 09:52:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>,
	anthony.l.nguyen@intel.com,
	rostedt@goodmis.org,
	clrkwllms@kernel.org,
	bigeasy@linutronix.de,
	jgarzik@redhat.com,
	yuma@redhat.com,
	linux-rt-devel@lists.linux.dev,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/4] igb: narrow scope of vfs_lock in SR-IOV cleanup
Date: Tue,  4 Feb 2025 09:52:37 -0800
Message-ID: <20250204175243.810189-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wander Lairson Costa <wander@redhat.com>

The adapter->vfs_lock currently protects critical sections shared between
igb_disable_sriov() and igb_msg_task(). Since igb_msg_task() - which is
invoked solely by the igb_msix_other() ISR-only proceeds when
adapter->vfs_allocated_count > 0, we can reduce the lock scope further.

By moving the assignment adapter->vfs_allocated_count = 0 to the start of the
cleanup code in igb_disable_sriov(), we can restrict the spinlock protection
solely to this assignment. This change removes kfree() calls from within the
locked section, simplifying lock management.

Once kfree() is outside the vfs_lock scope, it becomes possible to safely
convert vfs_lock to a raw_spin_lock.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d368b753a467..77571f6fdbfd 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3708,12 +3708,12 @@ static int igb_disable_sriov(struct pci_dev *pdev, bool reinit)
 			msleep(500);
 		}
 		spin_lock_irqsave(&adapter->vfs_lock, flags);
+		adapter->vfs_allocated_count = 0;
+		spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 		kfree(adapter->vf_mac_list);
 		adapter->vf_mac_list = NULL;
 		kfree(adapter->vf_data);
 		adapter->vf_data = NULL;
-		adapter->vfs_allocated_count = 0;
-		spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 		wr32(E1000_IOVCTL, E1000_IOVCTL_REUSE_VFQ);
 		wrfl();
 		msleep(100);
-- 
2.47.1

