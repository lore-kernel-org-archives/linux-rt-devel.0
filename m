Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80EE284689
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599172; cv=none; b=Ggq8Y1twk57pt54/aRpnytIUo62dX93MSiwXyhuNddsByjiK9rgQ3n1fr8GGXV81VJEBzDihEplMp0j8Po0Gzfv6fTHkkb//vDkAUYja5ouuQdpRJ6Nw9fA8gTGADg6aha1nIK0E0QuDzOZFR3X27VWfVmr9UweNYSqD03wWJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599172; c=relaxed/simple;
	bh=3bn2wHNalDwZ/lSyGnuadMAEP0yF+VwohFcFdSElLQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+L3/1t0ambmJuAJmTpz8uzBuU0z6EEDesgjSafP+sXscmFzSmvaU6gDR8UYJwVeLmVBsdrY/Wj/YgtnqpXYmYg7YRrAnAx/2zX9ywYTqDx6ug7mgMJGFJQABU31VTvxgysfpXeaChM/X9S/DDoEWhda2jexM8C78rgAuQMNPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <dev@lankhorst.se>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH] accel/ivpu: Remove lockdep_assert_irqs_disabled()
Date: Tue, 15 Jul 2025 18:59:19 +0200
Message-ID: <20250715165919.33754-1-dev@lankhorst.se>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This breaks on PREEMPT_RT, and should be unneeded since
lockdep can track irq disabled status itself.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/accel/ivpu/ivpu_ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 39f83225c1815..5f00809d448af 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -141,7 +141,6 @@ ivpu_ipc_rx_msg_add(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 	struct ivpu_ipc_rx_msg *rx_msg;
 
 	lockdep_assert_held(&ipc->cons_lock);
-	lockdep_assert_irqs_disabled();
 
 	rx_msg = kzalloc(sizeof(*rx_msg), GFP_ATOMIC);
 	if (!rx_msg) {
-- 
2.45.2

