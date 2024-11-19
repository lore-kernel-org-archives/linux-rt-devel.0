Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D514A609
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Nov 2024 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731995130; cv=fail; b=tOfa1n0tDJtMAkf232kX67Ks6dTCaEgqz5cfcJmUxH/ZzDp/PXNiCSk/nMAcgbDgqu1ECZPZdd8rAMS7LlEylg7Fy9JXK0Q+qeQT2aRPrNB0f3vVVzKnMQES1fNwhY1iNvNWqvfyzQRMFP6FCGBNbzILL1s528IQRuF5JQmFnks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731995130; c=relaxed/simple;
	bh=mmRXaZNEQFU51tq28QzU/6x5g+wfSEl+GY4wPLtqtBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPFd2Bogaryp/dsY6xri4P1eJILdEnOKA2yQW45JYy+ha5sm34yKGo0ixqaqy8psHuY0Y7mpQ5nEWaNmGfq6oqrCEh8cBRBmuOtnNxBAQjwp/gWQfgJivzWg3So6lMTFjTki5Y+YUeSe/QhlIqIzlABOY9ckA5Ql4iB3HZ8VXFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=079TZUtj; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="079TZUtj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK5jbM2H1yiowAcgNgPRhPzLnoqslLK+Aks3RW9XgZB3ov7ALAaFWbO1mHyw2fF6dQeaswhxO9hWfSO6Ysk+u+G5FVrnhArnrJPHEJpLcUCmeyN3Gct9zCREdVJmmHDL/mJ9WgQjsc2yqToLlxp9W8RwEA2qUnE8pm5xOeDmgyO3HQPVuX3PsxVhk5OswtSyGpkx+T7NAVFj4y0hTohg5J5401D2qbMibTcNf4s5D0ODuNL4sZWvL0vOLO9EEfP7ArMlloC1PXrIJ+BvPqTBIVjMcaLdO2r2ktXVQjNrzxH64bSgFI5WT0q2oulq34r+ZxjaKLEvjyrQQ6lC6Yw3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHbaCb8/wLcrTiweWDcgpXY+NJBc0ZRZBrBOxVOrQCA=;
 b=IV4rW4o23NbN7eywfP4gOQcPc8TrIcZEr4tw8+VYyPXaiO397eACND69GZ42JJ8sjFSDMX3H0DGxb4RCSao/CgmEOtAkQY0lt6klwWAynFaJgFvZ4X1/EDuYCKDRleIgMEa3uSpapwD7ci87SZjPVDLsoWF+SMF0Tm+jCgslqYLfxDU/s0MOHTkSLJa7tbwOQP0ISoZubkSHO+zwqdWX+nIVMfMnZOmNi1J/WDLNlFD9IuaC+pxXspRNDONbxHUhfACTlVzhGX3eI/0/OHSdjyq/bXd/AG88+m0jsdOqU4haMUlWcqVlnEF5530WSShGrlS4KnUcDzIwAnDLmpMcww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHbaCb8/wLcrTiweWDcgpXY+NJBc0ZRZBrBOxVOrQCA=;
 b=079TZUtjsiZxX/ac17VFKqqE9q9CS/kAottQzQpI675aWpZOt1ltR0Nch6dDPrhewrcVJ8re0AaNIR3E8p5oJxlbAnblpq/LFNSN23dGtrd4YzfHi8o0RrsxaIHNz4VLJ2viiVJ+0rgclji46/J/vXBYtLK6DyooNTLcHMfPp5k=
Received: from SJ0PR13CA0086.namprd13.prod.outlook.com (2603:10b6:a03:2c4::31)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 05:45:26 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::c1) by SJ0PR13CA0086.outlook.office365.com
 (2603:10b6:a03:2c4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.13 via Frontend
 Transport; Tue, 19 Nov 2024 05:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 05:45:25 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 23:45:19 -0600
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
	<tj@kernel.org>, NeilBrown <neilb@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Caleb Sander Mateos <csander@purestorage.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Chen Yu <yu.c.chen@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v5 2/4] sched/core: Remove the unnecessary need_resched() check in nohz_csd_func()
Date: Tue, 19 Nov 2024 05:44:30 +0000
Message-ID: <20241119054432.6405-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119054432.6405-1-kprateek.nayak@amd.com>
References: <20241119054432.6405-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 1768d2e3-643b-467b-fd8d-08dd085d5e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cxX1bSnt33TZzuQZR/P82KQ9iyxS/Y78PyFSqRuQAZ8mA6bSD45v4Hq+PtSn?=
 =?us-ascii?Q?5truU/MeixMEqTJjYN/LMICX3V7sjd8Nf12vCgL5KeYKdnmRK5EsmMyXmvEP?=
 =?us-ascii?Q?UlZSXvmt0/xlhnF16xlmGgtaSNwc2vlq/ISK0IcdsdGl0LFvgo7+ehye+4ZG?=
 =?us-ascii?Q?qShYcn6jRx92YU028bOGv/Z+mlArar6WNnmFKRmmPJPLxeQcOQNcUeLY7C6f?=
 =?us-ascii?Q?eSA3WeZtl8CWeiYsNH1dO/F0yuRKIAUi7RKofVAzgjis5NlUleECjH8pCx/t?=
 =?us-ascii?Q?ZAsn7bjN7Bxb/gTTvAIscPkWk0GhPe1Xb8NKDxEed0fJJc6DW8a9sOlpw5yx?=
 =?us-ascii?Q?tZdCs799oQmtsmPM4PfmRD1fbrsflPNesOoRz/kzEHQCiVV1fXn1MtUsyHgd?=
 =?us-ascii?Q?wE+D+L3/ReL84UDNN9ZHCzjMvVIPIriOyCzAmH4c+k21LcfIICRb0Sh0vzej?=
 =?us-ascii?Q?9pW1ASE7P+dJQp0i3sBregmiys2uB9cd0YxUx3ENqzC1iJJQVSe9PJzvzXu7?=
 =?us-ascii?Q?31/rrnjqpv2unKZAt0jKU4g4QV71srqYfHsGQO5kaQh7zQ0V7aERPAwQNQzf?=
 =?us-ascii?Q?EgQtxraaU5NW35IdTreTpwEIAEtPlxG2vL3D7KuHCbcyf32v8oLwUvxu4lYX?=
 =?us-ascii?Q?33sv7ipKP0YTXRIph6Ln9XfuYkHNSLnFBcofuHY8jGYrz0F+6e+sMk+W95i+?=
 =?us-ascii?Q?LOjUx6UtfSPGms1q/8dUAzlNBoGepUEKrpPk1zVZgvCunlIlbFWyMAmhJlv7?=
 =?us-ascii?Q?6l4cyiR17VbLqwL3OrQAdBjtUILVpGZW8HVoe7/6riOzxoJNWuzweJgZseXH?=
 =?us-ascii?Q?TUYbDiyAs0lL9BFW/5ncz34tTtkcXBlDBlCLCd6iy+C/Bnolqkxq03X6+dZq?=
 =?us-ascii?Q?8EQIJ6846h3Bw8t6hbMUwk05KO7nvh2kiv/QJKYSmrJtOVBjdATQCuSCQS/p?=
 =?us-ascii?Q?6en6f3z+114voYIXG/YTOCqUAZ2zZao7KPJ5129wxFN4cEV+tAkBW1Wecj6s?=
 =?us-ascii?Q?fcViFQS8gtNFIw/bWTCg6xyhCAk+rUqm4XFMJa7GrPrmQUlUW5ZUg1J4aLg5?=
 =?us-ascii?Q?MN5yPdtIi8lM9VpPleZkby8Mb6OHahBfOSDEmx6AF8O1YKY6759W8LCMtba+?=
 =?us-ascii?Q?EXZGW32ndNAaiysgCGEO5LcmqeqgJ7pNWBUxmdf9QV8P2HVK1HjBMhjm/whu?=
 =?us-ascii?Q?PwK+BksRJPPbDJ+VRTO7/qq/PwNLPI+A4hLZp1S/rVrlBAs7jcscHHONzLSy?=
 =?us-ascii?Q?eaHCzdzfiVf7Z6aRgldhhrbKb7Qgk3EGPp6sopKVigYgXTs48K5KfpKydSDl?=
 =?us-ascii?Q?yZsfvXhRG3HRQ4mPuG1vXLc2RuOnA9FGZC6+25X5w2pLfmoHk8imqn9ml8+e?=
 =?us-ascii?Q?PzzG+FVD0qjyCgESqBdtpG1KRUqrQF2lpmv038RctFcJYg47RwyA1N9Lw4ma?=
 =?us-ascii?Q?SzISK41j/6c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 05:45:25.9656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1768d2e3-643b-467b-fd8d-08dd085d5e2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899

The need_resched() check currently in nohz_csd_func() can be tracked
to have been added in scheduler_ipi() back in 2011 via commit
ca38062e57e9 ("sched: Use resched IPI to kick off the nohz idle balance")

Since then, it has travelled quite a bit but it seems like an idle_cpu()
check currently is sufficient to detect the need to bail out from an
idle load balancing. To justify this removal, consider all the following
case where an idle load balancing could race with a task wakeup:

o Since commit f3dd3f674555b ("sched: Remove the limitation of WF_ON_CPU
  on wakelist if wakee cpu is idle") a target perceived to be idle
  (target_rq->nr_running == 0) will return true for
  ttwu_queue_cond(target) which will offload the task wakeup to the idle
  target via an IPI.

  In all such cases target_rq->ttwu_pending will be set to 1 before
  queuing the wake function.

  If an idle load balance races here, following scenarios are possible:

  - The CPU is not in TIF_POLLING_NRFLAG mode in which case an actual
    IPI is sent to the CPU to wake it out of idle. If the
    nohz_csd_func() queues before sched_ttwu_pending(), the idle load
    balance will bail out since idle_cpu(target) returns 0 since
    target_rq->ttwu_pending is 1. If the nohz_csd_func() is queued after
    sched_ttwu_pending() it should see rq->nr_running to be non-zero and
    bail out of idle load balancing.

  - The CPU is in TIF_POLLING_NRFLAG mode and instead of an actual IPI,
    the sender will simply set TIF_NEED_RESCHED for the target to put it
    out of idle and flush_smp_call_function_queue() in do_idle() will
    execute the call function. Depending on the ordering of the queuing
    of nohz_csd_func() and sched_ttwu_pending(), the idle_cpu() check in
    nohz_csd_func() should either see target_rq->ttwu_pending = 1 or
    target_rq->nr_running to be non-zero if there is a genuine task
    wakeup racing with the idle load balance kick.

o The waker CPU perceives the target CPU to be busy
  (targer_rq->nr_running != 0) but the CPU is in fact going idle and due
  to a series of unfortunate events, the system reaches a case where the
  waker CPU decides to perform the wakeup by itself in ttwu_queue() on
  the target CPU but target is concurrently selected for idle load
  balance (XXX: Can this happen? I'm not sure, but we'll consider the
  mother of all coincidences to estimate the worst case scenario).

  ttwu_do_activate() calls enqueue_task() which would increment
  "rq->nr_running" post which it calls wakeup_preempt() which is
  responsible for setting TIF_NEED_RESCHED (via a resched IPI or by
  setting TIF_NEED_RESCHED on a TIF_POLLING_NRFLAG idle CPU) The key
  thing to note in this case is that rq->nr_running is already non-zero
  in case of a wakeup before TIF_NEED_RESCHED is set which would
  lead to idle_cpu() check returning false.

In all cases, it seems that need_resched() check is unnecessary when
checking for idle_cpu() first since an impending wakeup racing with idle
load balancer will either set the "rq->ttwu_pending" or indicate a newly
woken task via "rq->nr_running".

Chasing the reason why this check might have existed in the first place,
I came across  Peter's suggestion on the fist iteration of Suresh's
patch from 2011 [1] where the condition to raise the SCHED_SOFTIRQ was:

	sched_ttwu_do_pending(list);

	if (unlikely((rq->idle == current) &&
	    rq->nohz_balance_kick &&
	    !need_resched()))
		raise_softirq_irqoff(SCHED_SOFTIRQ);

Since the condition to raise the SCHED_SOFIRQ was preceded by
sched_ttwu_do_pending() (which is equivalent of sched_ttwu_pending()) in
the current upstream kernel, the need_resched() check was necessary to
catch a newly queued task. Peter suggested modifying it to:

	if (idle_cpu() && rq->nohz_balance_kick && !need_resched())
		raise_softirq_irqoff(SCHED_SOFTIRQ);

where idle_cpu() seems to have replaced "rq->idle == current" check.

Even back then, the idle_cpu() check would have been sufficient to catch
a new task being enqueued. Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") overloads the interpretation of
TIF_NEED_RESCHED for TIF_POLLING_NRFLAG idling, remove the
need_resched() check in nohz_csd_func() to raise SCHED_SOFTIRQ based
on Peter's suggestion.

Link: https://lore.kernel.org/all/1317670590.20367.38.camel@twins/ [1]
Link: https://lore.kernel.org/lkml/20240615014521.GR8774@noisy.programming.kicks-ass.net/
Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v4..v5:

- No changes.
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..424c652a9ddc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1237,7 +1237,7 @@ static void nohz_csd_func(void *info)
 	WARN_ON(!(flags & NOHZ_KICK_MASK));
 
 	rq->idle_balance = idle_cpu(cpu);
-	if (rq->idle_balance && !need_resched()) {
+	if (rq->idle_balance) {
 		rq->nohz_idle_balance = flags;
 		raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
-- 
2.34.1

