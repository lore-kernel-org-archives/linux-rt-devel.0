Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E471D5CF9
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Oct 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273162; cv=fail; b=Aiid+SoEQb7SFJofP51fSvxZg0bxv74G8KyS7yqejFDj14m7nJih8STsguRqUJPYmqnQqivrBsQsrSPKtWAaYTfF/T+QPsU637AO2VVqojGJgoR09TABrS86WP+y5rxlh00bc66yJ+E9hiXtKcndkYyd88p4kMUBbEzeRCAShAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273162; c=relaxed/simple;
	bh=7cN/piHL+RmLwlBogUSCxkXXlV1zB5xh7nO6DwvH/jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyBAhuFj8DPqwxkhANwZtDABgCIGEODjReweyw/xCia8c1RuIXoEBN6l5yoelLhqGgzAi3RPpJ8KORvF6GL80Gvb9947E3NDgDSwIdfU0e3ZdRn5DoROjB1M6c2JDEaZMGn4qPg62/JtHrSprpgjcz3PztMC7T0EAG1O/ryPqw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s30IwE5k; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s30IwE5k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N94Bbg2+nQ4It+kR/4ISLm88F7Y7wr259QQEQr3+g2XIgBX+eP/RKPQ3fb71JHV0sCNq19yhqy0vycPj+rN759MY8qmzP4pnQm6zqVi92Yhrhr6yHA9ikMRstuVZ6L3b8nevnMNe4Eb3ay0guCn25otHxOd61K2PGO55M5hoWl5Qc68IstW9QeYu5YbMTIcHUKTb3PX99RWnRG72n5c9Cunx7mwSPFBXQQJDIj3anXob/1vgv5X+rdvDZZ7ldj8R7NCwDax0pQ/YOV+ziZe2L2vnckAKiV0sezT3gksjIi7GVypinD+eKvC+PsGMvxueb1lpXc+WfnZ5sIMsCritFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nkzv30Ezz7l8xAfvMAVylfwv90yAkDltxvmkMfkX8M0=;
 b=Cy8GQMCKkbG0SLlIc4EmyJ9B0DyXn8vqbVCgoI7u7fZ9jnGByEb0Kt+xISWrjgN/o42wcyvm7KYsQtivhthb/QW343MoFuIblO05eQbo4sgjXXvyEA8SVFUNqzhEEAgHI+IK3Vu2cxv09TeEvtS6C53viv3I03O1nfPBPd3aYbJmnARTfip5COv4tmTZSlJ9O0A3XY3t4fAL3qb/+9vzbu2b2m8VQVK7NcEikDNsMWEVhYvvRQpgWEbkUKQrnYzeSBMX+BAOhnNmPWe2kwlULkwzEpRBEL39/sGNjMuXvil9dXYt8PY2iH/tFI9UhAKK3DoCBwottaUzu3z5Jf+VQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nkzv30Ezz7l8xAfvMAVylfwv90yAkDltxvmkMfkX8M0=;
 b=s30IwE5kJe/ocIY3u5JP71vGBTpPM4b7TldMqWC6qwUL3EmQJf/4hGrSLe3AyXK93CEP7GKoGHYS24cyp8I9VP3ALr7AWz8ZdsI8w2jXRGgtfQJTpuTo2jG19D4sWP6lik8F2GM+ALs+d2VuR5ikIcaNmNM3uGHWx7cpIA7ZhOg=
Received: from DM6PR07CA0062.namprd07.prod.outlook.com (2603:10b6:5:74::39) by
 SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.24; Wed, 30 Oct 2024 07:25:50 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::3c) by DM6PR07CA0062.outlook.office365.com
 (2603:10b6:5:74::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Wed, 30 Oct 2024 07:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 07:25:28 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 02:25:17 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo
	<tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.de>,
	Zqiang <qiang.zhang1211@gmail.com>, Caleb Sander Mateos
	<csander@purestorage.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v4 3/3] sched/core: Prevent wakeup of ksoftirqd during idle load balance
Date: Wed, 30 Oct 2024 07:15:57 +0000
Message-ID: <20241030071557.1422-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241030071557.1422-1-kprateek.nayak@amd.com>
References: <20241030071557.1422-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfcd6c9-4b2d-45e3-33ab-08dcf8b414a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cBVMkpEyiWBYAxHw2JsnfCOusi5x3HZRUHvb4/ZITKq7W6EmE8Ra3/SgwGjU?=
 =?us-ascii?Q?3oGpojRFO5Pin3mqSQmv8irU5dGjtDDDeWDj33f5+48j21wyRz+3EW7AdgBi?=
 =?us-ascii?Q?oxrq/lVfm/4MnTc6LFPJkNIuNmYEoIbtzOwkcKHKd8YAeK3sLq3lELmvEYqY?=
 =?us-ascii?Q?t5WA4TQHxdWuWbG6PRQwx/pPoRVfMRtx2NEgvi2r/DQzvxxe54pnSLu7V8kt?=
 =?us-ascii?Q?Kdr1G1ri52604DN2c8rmrmsMJe7zMBB+LFRrgFSxYHlVs+yW7wjW2d0O3UlO?=
 =?us-ascii?Q?D3cku/k50SIfKrLn9b7NVTIAoh0CNxXoCVB53C09LC5JRLELkgMHs7/w4/Lr?=
 =?us-ascii?Q?UVW88ME/Y1zQMBdGeqOFMYIs7XYFhhCUEyR+lMCt9v2E7GVOGQhU5q5p03p9?=
 =?us-ascii?Q?zXVJMDZw7aFSuU2jnQWI4R6+SHilSIHXiEFgZ/ne2UlczeCFpawVPnpjdEoh?=
 =?us-ascii?Q?DirV/WTSwyxY/qoz75xmXsBORr2h7kbQUr02v5RqfUCsnjHdFZlWziRKZvk3?=
 =?us-ascii?Q?ivQy1SMoDfKuNPwmo1okPJe3FH/XYOH5dDzkuPG1SvCXgbZrMpJXIUb1M7IC?=
 =?us-ascii?Q?uV2OgYivS34nIoFEzZ3SWCwgMP8yagBeR2ntiaDTjzd7+mYpvDVbxi0l+7+f?=
 =?us-ascii?Q?4X4skuT0ixTLgghvcCDahg1WIV9UvkRv5JgZtLQ+TFqLzMELGB2OCdtNE9Gi?=
 =?us-ascii?Q?7nhr+4DvuOvEPuK45gj5sfcCEl4MTKMCdL+G8sXjkDSWke2kOrMpMW5aqi1T?=
 =?us-ascii?Q?9L+36+TCTC2m0gWE40YM3zp4r2nh7vOh+wdK+9US5C0OUQX5X9HjVQ8au/kj?=
 =?us-ascii?Q?XNepNhHbZi8td3FperoxPLM1soWKinusOWcDe6Beaz3RvxFPrzoRcfCh1CU1?=
 =?us-ascii?Q?UlipwKca8JuvDLSGRXVoelaueTSEpxTKRB8szSzUEmg+ASpXZiu7udS4rq+f?=
 =?us-ascii?Q?6OMOpbxQH2pobIyLL+OTG1XvSq5DUtkC2/dc2rQs5t51imcBPqF0Ou5CiYwT?=
 =?us-ascii?Q?gwSbhNnx/lia6VNbM5NwY5GKRKiSQe6OhHrUnxYY8saYIl4WWIQOYCkvnwj1?=
 =?us-ascii?Q?aAz6mLnroaqWTl212bR9N78xnr2kxhJ51+dGB1EqBB81p7jE1/2xQV0egcPy?=
 =?us-ascii?Q?h5I6qScOXXqrnRuyn+tm9m5yhwHeqNbUKAKOn0S5aeBuiWRw502fHomYzwnI?=
 =?us-ascii?Q?Vdn4ZrVEVvMgJ+2G7CZNzISCZWufaxOz9AGweSlRXlSaCCl44QzOPh1Qwo3P?=
 =?us-ascii?Q?PKIbWUBXhpJegVC8C7/mN/FaEvi03ggehgZ/uWDzhXPF8EozuxRlQhG2olE2?=
 =?us-ascii?Q?SP3p6nPx088hffkxyNEllJWiMzfc51pvJCfzw+RhXIC/sA+6qzYqtXTwR2kK?=
 =?us-ascii?Q?HiC+8sl9gEro2M7IWV2cukZM3NLg2Tugtk35ERTjLaJk5fDfdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 07:25:28.1598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfcd6c9-4b2d-45e3-33ab-08dcf8b414a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132

Scheduler raises a SCHED_SOFTIRQ to trigger a load balancing event on
from the IPI handler on the idle CPU. Since the softirq can be raised
from flush_smp_call_function_queue(), it can end up waking up ksoftirqd,
which can give an illusion of the idle CPU being busy when doing an idle
load balancing.

Adding a trace_printk() in nohz_csd_func() at the spot of raising
SCHED_SOFTIRQ and enabling trace events for sched_switch, sched_wakeup,
and softirq_entry (for SCHED_SOFTIRQ vector alone) helps observing the
current behavior:

       <idle>-0   [000] dN.1.:  nohz_csd_func: Raising SCHED_SOFTIRQ from nohz_csd_func
       <idle>-0   [000] dN.4.:  sched_wakeup: comm=ksoftirqd/0 pid=16 prio=120 target_cpu=000
       <idle>-0   [000] .Ns1.:  softirq_entry: vec=7 [action=SCHED]
       <idle>-0   [000] .Ns1.:  softirq_exit: vec=7  [action=SCHED]
       <idle>-0   [000] d..2.:  sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/0 next_pid=16 next_prio=120
  ksoftirqd/0-16  [000] d..2.:  sched_switch: prev_comm=ksoftirqd/0 prev_pid=16 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
       ...

ksoftirqd is woken up before the idle thread calls
do_softirq_post_smp_call_flush() which can make the runqueue appear
busy and prevent the idle load balancer from pulling task from an
overloaded runqueue towards itself[1].

Since the softirq raised is guranteed to be serviced in irq_exit() or
via do_softirq_post_smp_call_flush(), set SCHED_SOFTIRQ without checking
the need to wakeup ksoftirq for idle load balancing.

Following are the observations with the changes when enabling the same
set of events:

       <idle>-0       [000] dN.1.: nohz_csd_func: Raising SCHED_SOFTIRQ for nohz_idle_balance
       <idle>-0       [000] dN.1.: softirq_raise: vec=7 [action=SCHED]
       <idle>-0       [000] .Ns1.: softirq_entry: vec=7 [action=SCHED]

No unnecessary ksoftirqd wakeups are seen from idle task's context to
service the softirq.

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/ [1]
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v3..v4:

o New patch based on Sebastian's suggestion.
---
 kernel/sched/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aaf99c0bcb49..2ee3621d6e7e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1244,7 +1244,18 @@ static void nohz_csd_func(void *info)
 	rq->idle_balance = idle_cpu(cpu);
 	if (rq->idle_balance) {
 		rq->nohz_idle_balance = flags;
-		raise_softirq_irqoff(SCHED_SOFTIRQ);
+
+		/*
+		 * Don't wakeup ksoftirqd when raising SCHED_SOFTIRQ
+		 * since the idle load balancer may mistake wakeup of
+		 * ksoftirqd as a genuine task wakeup and bail out from
+		 * load balancing early. Since it is guaranteed that
+		 * pending softirqs will be handled soon, either on
+		 * irq_exit() or via do_softirq_post_smp_call_flush(),
+		 * raise SCHED_SOFTIRQ without checking the need to
+		 * wakeup ksoftirqd.
+		 */
+		__raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
 }
 
-- 
2.34.1

