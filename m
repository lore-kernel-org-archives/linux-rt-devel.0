Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B882163AC
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Feb 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691576; cv=none; b=uwL44Sr3bdD0wgxBuI7NE42ZFzpz+7FM+9KqiyIkEwnppmujdNKa5Sg3YFOQxpO5zNcyAxdUQl8JHZivqMeqwG3hY/xXQg5RbddN2Q9FT6Ehrm9Qy6cou11YX3XE7YE20BCJzlhKY2BtZsxkHAEbh0VudomjUiGCSPIM0Yr27PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691576; c=relaxed/simple;
	bh=Ij5+AAvOEp0oI4NlaPmZaEL3V4o/dX6CD6vtMOaL+9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw/O3R8jWEJp7UOh0tiERUDSJt1isw4Kua0BRH6sCztk+71I6CIUJaEE0PJonY8BWa8t1adlr1UUCqnpVNpafZw1K7frugr5xE909W3p9rk1zQWIU8lru0JHgQMQptCeLLthpfH1kceTlU6/u0Qq5UVgRCPBrc04Rxuy0ZK6gLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acYuZx2j; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acYuZx2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691575; x=1770227575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ij5+AAvOEp0oI4NlaPmZaEL3V4o/dX6CD6vtMOaL+9M=;
  b=acYuZx2jbEiYWa7WGcifFCC/1WnGdSCIUjfZJfsJfCMMFX+I+f7i7e8v
   E6gOPW10OT2aAnlpvC9UedtKPv6aHvOFkZTXL8RDa4iUgmD/EX5xuN8sv
   0YDmSe8gULsmZRMWVDWrfFEUoNW7px4BjSCRpySH01ybOUxIGS2I5fMjC
   ZVFGxwQ7RpRZBe2uNGyN4ndSq0A/JMW8I7IoztGmY/PlmTNYrAOhVGrGr
   qNtASsRqJyu7HEztFGxKiC1nggnpkxD/W77YdcB1kh3gFqJWqpc+EKwiv
   2JXKH4Ck5oqBdmYxUb5qNNLWv75o/dWurOYiJ5Swd+S8ttAZMCyyofhtd
   g==;
X-CSE-ConnectionGUID: wTyGd7INTVyJNvLOe6F9Og==
X-CSE-MsgGUID: Z6ybKBuoSze8amy+BpFD0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39371888"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39371888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:52:54 -0800
X-CSE-ConnectionGUID: wKHizxhkSN24MAHp/mtT9g==
X-CSE-MsgGUID: rypIaQFbQb67jBu8T0tSfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110652390"
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
	Clark Williams <williams@redhat.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/4] igb: introduce raw vfs_lock to igb_adapter
Date: Tue,  4 Feb 2025 09:52:38 -0800
Message-ID: <20250204175243.810189-3-anthony.l.nguyen@intel.com>
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

This change adds a raw_spinlock for the vfs_lock to the
igb_adapter structure, enabling its use in both interrupt and
preemptible contexts. This is essential for upcoming modifications
to split igb_msg_task() into interrupt-safe and preemptible-safe
parts.

The motivation for this change stems from the need to modify
igb_msix_other() to run in interrupt context under PREEMPT_RT.
Currently, igb_msg_task() contains a code path that invokes
kcalloc() with the GFP_ATOMIC flag. However, on PREEMPT_RT,
GFP_ATOMIC is not honored, making it unsafe to call allocation
functions in interrupt context. By introducing this raw spinlock,
we can safely acquire the lock in both contexts, paving the way for
the necessary restructuring of igb_msg_task().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Suggested-by: Clark Williams <williams@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |  4 ++
 drivers/net/ethernet/intel/igb/igb_main.c | 51 ++++++++++++++++++++---
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 02f340280d20..30a188c5710e 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -673,6 +673,10 @@ struct igb_adapter {
 	struct vf_mac_filter *vf_mac_list;
 	/* lock for VF resources */
 	spinlock_t vfs_lock;
+#ifdef CONFIG_PREEMPT_RT
+	/* Used to lock VFS in interrupt context under PREEMPT_RT */
+	raw_spinlock_t raw_vfs_lock;
+#endif
 };
 
 /* flags controlling PTP/1588 function */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 77571f6fdbfd..4e75c88f6214 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3657,6 +3657,47 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return err;
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static __always_inline void vfs_lock_init(struct igb_adapter *adapter)
+{
+	spin_lock_init(&adapter->vfs_lock);
+	raw_spin_lock_init(&adapter->raw_vfs_lock);
+}
+
+static __always_inline void vfs_lock_irqsave(struct igb_adapter *adapter,
+					     unsigned long *flags)
+{
+	/*
+	 * Remember that under PREEMPT_RT spin_lock_irqsave
+	 * ignores the flags parameter
+	 */
+	spin_lock_irqsave(&adapter->vfs_lock, *flags);
+	raw_spin_lock_irqsave(&adapter->raw_vfs_lock, *flags);
+}
+
+static __always_inline void vfs_unlock_irqrestore(struct igb_adapter *adapter,
+						  unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&adapter->raw_vfs_lock, flags);
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+}
+#else
+static __always_inline void vfs_lock_init(struct igb_adapter *adapter)
+{
+	spin_lock_init(&adapter->vfs_lock);
+}
+
+static __always_inline void vfs_lock_irqsave(struct igb_adapter *adapter, unsigned long *flags)
+{
+	spin_lock_irqsave(&adapter->vfs_lock, *flags);
+}
+
+static __always_inline void vfs_unlock_irqrestore(struct igb_adapter *adapter, unsigned long flags)
+{
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+}
+#endif
+
 #ifdef CONFIG_PCI_IOV
 static int igb_sriov_reinit(struct pci_dev *dev)
 {
@@ -3707,9 +3748,9 @@ static int igb_disable_sriov(struct pci_dev *pdev, bool reinit)
 			pci_disable_sriov(pdev);
 			msleep(500);
 		}
-		spin_lock_irqsave(&adapter->vfs_lock, flags);
+		vfs_lock_irqsave(adapter, &flags);
 		adapter->vfs_allocated_count = 0;
-		spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+		vfs_unlock_irqrestore(adapter, flags);
 		kfree(adapter->vf_mac_list);
 		adapter->vf_mac_list = NULL;
 		kfree(adapter->vf_data);
@@ -4042,7 +4083,7 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	spin_lock_init(&adapter->stats64_lock);
 
 	/* init spinlock to avoid concurrency of VF resources */
-	spin_lock_init(&adapter->vfs_lock);
+	vfs_lock_init(adapter);
 #ifdef CONFIG_PCI_IOV
 	switch (hw->mac.type) {
 	case e1000_82576:
@@ -8078,7 +8119,7 @@ static void igb_msg_task(struct igb_adapter *adapter)
 	unsigned long flags;
 	u32 vf;
 
-	spin_lock_irqsave(&adapter->vfs_lock, flags);
+	vfs_lock_irqsave(adapter, &flags);
 	for (vf = 0; vf < adapter->vfs_allocated_count; vf++) {
 		/* process any reset requests */
 		if (!igb_check_for_rst(hw, vf))
@@ -8092,7 +8133,7 @@ static void igb_msg_task(struct igb_adapter *adapter)
 		if (!igb_check_for_ack(hw, vf))
 			igb_rcv_ack_from_vf(adapter, vf);
 	}
-	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+	vfs_unlock_irqrestore(adapter, flags);
 }
 
 /**
-- 
2.47.1

