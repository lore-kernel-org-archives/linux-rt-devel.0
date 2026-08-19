Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466AE476CDF
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Aug 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149852; cv=none; b=h0OjAmCV8zrf396cSX7RddrGLu7awfJOk++lWlMAhfAvsMkpMij4rBzTJAzrOz9eRWT4gnjgEmvAT91PWhCipJkLGh4vqTzBl2Ee5/bNnzY9vW7CoQWESdHLnoXacJQOgddi8KT4CIAtCNUDU4tlM7zucERHZWiKhT0H1y8j4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149852; c=relaxed/simple;
	bh=4xhhR3bu1NVSWIwX5g40uWrKhyT+t13dMc6Cm+ZB6p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rzyUhrEUdin9s5dlbl0sNAZcDtr6a+8HBzMspzkaEMCvQgJtqkiEqX3YrNDi58MMRiWCl3iI0SyWM4bXd+2yWtKIUtQXlNTWKDrHv5WpIKWPJIZeGbXuL0lCYRgusF6YGDEQ8+0bttKOBLeRFfmpOSfvKLkydFNGstniXijfPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QVtxtt6M; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QVtxtt6M"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260819143033d99b877957000207ae
        for <linux-rt-devel@lists.linux.dev>;
        Wed, 19 Aug 2026 16:30:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Vvv1sBUaBjcEUFUZGnIymSGGot8dFYipkz2vCCdspeg=;
 b=QVtxtt6MaUFxp1ZH6eI+kErHX2u5GQOB9t6Xmhg/I+9OPexC3uPKmQZg0ZDD2Dk4ISPW6j
 oOMnQx18jh8IyucabgFrayd4vxBC9nHrwe6ucjxiU010Ep/V9QuDxLVsPG5mpSJLLzQQ2qey
 +TerQIBTfK0X1gf5rbIgT0CuKkp2cagerI8MxgurCS64y8jZRCWAERtNwe2LuXpDJMU/clcu
 qBR/doqvchL5NmXqbV0w01cohq0NJAG5uexVi3cu5oWp9xOpVnHAvFmXhGwG9TuFuID2u/HZ
 jN+fkIof+zI4Wx/kDJ/OzYqXDQF3yQ0RPBhsLv+sVxarCq3nzgTlVBnw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 19 Aug 2026 16:30:30 +0200
Subject: [PATCH RFC 1/3] cpumask: Honor irq_default_affinity in
 cpumask_local_spread()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-1-3f79a99cadaf@siemens.com>
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

Many drivers call cpumask_local_spread() to spread IRQs to several
CPUs, mainly to get best performance and balance CPU load. For
realtime (PREEMPT_RT) and other cpu-isolating workloads the old
implementation was triggering an IRQ placement problem. IRQs were
targeting CPUs that were isolated for those sensitive workloads.

Userland will tell the kernel about the desired IRQ configuration
for new interrupts by writing a proper cpumask to
/proc/irq/default_smp_affinity. This cpu mask has to be honored to
avoid IRQ noise on isolated cores.

The default for irq_default_affinity is "all CPUs". So all CPUs will
be taken into account for spreading when userland did not configure
something special.
---
 lib/cpumask.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 5adb9874fbd0f5a42ea8cd9e6c3729a70599781f..73e7b60a9201174f83df6067effbe7d1889dcdb9 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/memblock.h>
 #include <linux/numa.h>
+#include <linux/interrupt.h>
 
 /* These are not inline because of header tangles. */
 #ifdef CONFIG_CPUMASK_OFFSTACK
@@ -81,8 +82,9 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
  * @i: index number
  * @node: local numa_node
  *
- * Return: online CPU according to a numa aware policy; local cpus are returned
- * first, followed by non-local ones, then it wraps around.
+ * Return: online CPU according to the default IRQ affinity and a numa aware
+ * policy; local cpus are returned first, followed by non-local ones, then it
+ * wraps around.
  *
  * For those who wants to enumerate all CPUs based on their NUMA distances,
  * i.e. call this function in a loop, like:
@@ -110,9 +112,9 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 	unsigned int cpu;
 
 	/* Wrap: we always want a cpu. */
-	i %= num_online_cpus();
+	i %= cpumask_weight(irq_default_affinity);
 
-	cpu = sched_numa_find_nth_cpu(cpu_online_mask, i, node);
+	cpu = sched_numa_find_nth_cpu(irq_default_affinity, i, node);
 
 	WARN_ON(cpu >= nr_cpu_ids);
 	return cpu;

-- 
2.55.0

