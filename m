Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D73F65E7
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Aug 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149848; cv=none; b=QP8/RCvEonWEHE53gN7RWJ+gvSLy+YRlBHfdPqrhcRR9fEyuz8LtLPipxrCnGvVp0uD9wp3HWU0c9oseLut43W7eB+Cqr5Ox2406/bJlhM7BfQMqZeXX1JlWGvc2+70RcyIUpXzizSbFeKvxMlxfHn3N2ypef0wToR8aoRNyf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149848; c=relaxed/simple;
	bh=chBfGMfp844oBzIINw5wmS5LW9kGFWDQ7Hz8+j5O7rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=awPHVVPrqiTMifJjGjlFIsQOYMrRohzMURY1nvzyEuh8Oa0mUAIPizgwBvH69nLfoH+7oUXlzUiQSQMM9JVCGgKOcrhjaIcYzpyaFtZ4tFBssDnstIgFtXTJvb/PcQEa92ljvdwb5aAXJE0CCrTGgUXgh4A9kjajjOIEFXvVUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bU551jOP; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bU551jOP"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202608191430331e2c1de7ec0002073b
        for <linux-rt-devel@lists.linux.dev>;
        Wed, 19 Aug 2026 16:30:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0N9FotERGZ2lP2bVikDRA8ACC8o9IjXehs1SgZCuBjA=;
 b=bU551jOPa15ZRd5Mh4WqHDNawdcmCuNzOmevR9LSg4HtaKLsiC/ge2AHvfsT9g0oAVOgcb
 mmspCU9JWhIFcORYKWAy1IbD0jP5VIi56LP+CUzJ4MDCAUV3w5ksOyPxN8t2bc6TfEAULMKw
 BUMO+ZzMYNF7hRH+v/D9vpml07Woh4+/BJyoC5yPYrNCfKFnoh2zbfOBvhi8bFDSDhnDAFLz
 kpGZ6D5kWqoe5TkaVi8jKYE8UvrOJo4scovH11cVqgxLVUkwQsSl9Oym0l7h2ksrgQ7SrIGi
 T5kGgrgcVkj1tB5n1aDVDPu7jhNs7uZ9zAuTdYiTLvV4+UNR0gvPo79g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 19 Aug 2026 16:30:32 +0200
Subject: [PATCH RFC 3/3] net: stmmac: Migrate IRQ balancing to
 cpumask_local_spread()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-3-3f79a99cadaf@siemens.com>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The previous balancing mechanism was based on num_online_cpus(), which
is a problem for systems cpu-isolating workloads. IRQs were targeting
CPUs that were isolated for those sensitive workloads.

With a migration to cpumask_local_spread() we
    - get NUMA locality
    - honor the default SMP affinity mask, which avoids targeting
      isolated CPUs.

This also aligns with the pattern used by most network drivers dealing
with IRQ affinities / affinity hints.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a71f0df263785dd8badc45292ca3067ab33bda05..949ced7e46d2814b57c6bd86b4886ac3bf33996c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3826,11 +3826,16 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	struct stmmac_msi *msi = priv->msi;
 	enum request_irq_err irq_err;
+	cpumask_var_t affinity;
 	int irq_idx = 0;
 	char *int_name;
+	int node;
 	int ret;
 	int i;
 
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* For common interrupt */
 	int_name = msi->int_name_mac;
 	sprintf(int_name, "%s:%s", dev->name, "mac");
@@ -3916,6 +3921,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	}
 
 	/* Request Rx MSI irq */
+	node = dev_to_node(&priv->dev->dev);
 	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
 		if (i >= MTL_MAX_RX_QUEUES)
 			break;
@@ -3935,8 +3941,10 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 			irq_idx = i;
 			goto irq_error;
 		}
-		irq_set_affinity_hint(msi->rx_irq[i],
-				      cpumask_of(i % num_online_cpus()));
+
+		cpumask_clear(affinity);
+		cpumask_set_cpu(cpumask_local_spread(i, node), affinity);
+		irq_set_affinity_and_hint(msi->rx_irq[i], affinity);
 	}
 
 	/* Request Tx MSI irq */
@@ -3959,13 +3967,18 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 			irq_idx = i;
 			goto irq_error;
 		}
-		irq_set_affinity_hint(msi->tx_irq[i],
-				      cpumask_of(i % num_online_cpus()));
+
+		cpumask_clear(affinity);
+		cpumask_set_cpu(cpumask_local_spread(i, node), affinity);
+		irq_set_affinity_and_hint(msi->tx_irq[i], affinity);
 	}
 
+	free_cpumask_var(affinity);
+
 	return 0;
 
 irq_error:
+	free_cpumask_var(affinity);
 	stmmac_free_irq(dev, irq_err, irq_idx);
 	return ret;
 }

-- 
2.55.0

