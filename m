Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784A1DD53D
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Oct 2024 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273130; cv=fail; b=AFi4kExumnZGMSBmlYgXq+cA14nJs+//fkzuyzycWF0XjVYOeijGKPXujQiioWxPbx835vunOSWceEGWVm+U7jWTp0pVasqtDeaFEVYq+uu2ljsUNhU6GosN6TB6LNaNeGL62uJUc41zuz8opUXEBydNIX+4IZHNVUt8wItfgAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273130; c=relaxed/simple;
	bh=l2Mksu3vknG55VmlNaSOZYEQJKgMNOfhnas6AXIPHKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSs2/YbeivkchiOXIY6nO1q5AtF6IxmhVTDmXoQfBwRi4+FfEJ2N+MqafTCFRWrXtMn93vgQP3Wx6RPEmpG+sD/kX3qbdaL4utoGHTRSarlNsuiTnJAllykFG8coq5njr/Aufn9feU6o/fKvx7PNF2tQI3WQ2U+8Tb03gl5cpUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Erb8VdC+; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Erb8VdC+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peOfh6ZI6sv4vkqZkrBKypeLbVVOxHYr/bFneT8DSysdB5hTKQARMuupoKmrwId1kmG/ioztobUf7JIbtIrU+lgiDOTNEJK8X8MUdCZ4vIrYQX1Kay7Y2V4Gv9t+03FF5IJlWEO0m2iAgOmYgpYZ9/S1MLGEaEII3DOgKhCEcH/ZTPxGf/CNFf655TW/B0J+ZvVw3t++Jnned0LsN+FHmJnEhNYTzMelLiHScFJJJH1VN1AUBsUp/HlVFDhqxniPlkvDTZqLCOsW+LJxWwSXfZWU1LEWDqmK+cxRWiVHd1mJKCuSvUiuCNaqML0ofSXaGFSDV7d3flGgoJO+3meZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48CPlsmVUY1DVShT+sl6RhhND5nxlPqQQU8pfYvZg7U=;
 b=wErvA1Ale6rIlsVD6L0Jo0uFnMive8c1GKSy7Y4OVrXkW6aZN+7qJFhRrTwiV2Arj8sfe9wrFwcvesf2oJhQhjVvERdFUButZIHIswgsO1FPEKA4v6wZFa71w4aCksm94TPjergAihsce13ZMPDNFV1Uq9CBjnkC/IwuNtnXiFqCC24RU+o7U9j6Q/rsTZg9KmSVH40dM6nqmOHpAbUs6FalAIVuLz6U5fYN0jup/JgYhdNODYyhKbJsj9DCdTboqnVrU8Y0HOi0K9Fexlht0yWuOqvTxjD7PPnCYaCV/3KOGoLHf8I31jJxsH22oufKoh1VUsuHDPTtLvKjkBet9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48CPlsmVUY1DVShT+sl6RhhND5nxlPqQQU8pfYvZg7U=;
 b=Erb8VdC+SyBUZpEhC3RmHLlYeywEzs7qQlPkIdkGeDqLhGfIr/TuLBYD/aCD2cKLpBKm/fM+QGeCWvDbGBigvFN+uPiEY6bi9wb4CV8Ax1gFeMjnqWx3MGqmIqr5w/NY+JZkqqnee+u1fH/HJie5iNoR44zqivOSUR32hVI9TFU=
Received: from CY5PR16CA0003.namprd16.prod.outlook.com (2603:10b6:930:10::7)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 07:25:21 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::50) by CY5PR16CA0003.outlook.office365.com
 (2603:10b6:930:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 07:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 07:25:21 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 02:21:57 -0500
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
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH v4 2/3] sched/core: Remove the unnecessary need_resched() check in nohz_csd_func()
Date: Wed, 30 Oct 2024 07:15:56 +0000
Message-ID: <20241030071557.1422-3-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fb2b02-a35e-4d23-1ad5-08dcf8b4034f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pbh4icQ8D2bFfDsmAFuK7GZRYcgEs6tTthHhnv2dVxEEtKOQ5wR6P4+xAk6F?=
 =?us-ascii?Q?9g123Iek5P3NfWbFq/h5oeUAizmwTRMNvgx0AfHEfUN0kzEWDjhL7/B8/xKz?=
 =?us-ascii?Q?GHd0Cim4BxHAYc5hLrdTeDCaYGQZvWzXGwlFFlUPQ6fWVYGr89D63X8iLmR5?=
 =?us-ascii?Q?XZIVUhvaa0pYyMDH84hdg1MrHjD2ZSXrGvFCqfX+Di8Ww3tSb6o3d8mDTPLa?=
 =?us-ascii?Q?qPHtUfKPDKdSOmveG6xyBd9tDWWcnjrtsuAd1lXF0WK9UaGlv1WDmrFH3tuW?=
 =?us-ascii?Q?sKo2el+xiZ1eGI4p/n9dugOdGPjui8X5y41/cA6rPOusMFBFJFjGVTE7hUUy?=
 =?us-ascii?Q?0r28Filj8xQJS346+C25HRJtqiHMYPQwGsb1PlW9znLGki7eAy+5jSmAPAVu?=
 =?us-ascii?Q?J0n79EM5H5AFmjTRKiC3WnoDs8801PC8qypUORin/8PkWPBSdxVGu2AqeYDx?=
 =?us-ascii?Q?dLGvohHtVuVOIDNo1gM0RPOWVmj++4YquS9srQyITpmAu3BXJ+JlEs63Ieci?=
 =?us-ascii?Q?XIe6n1RYfeHUDWMQDDuBeiswFM4uS+UCLOox7adkbO9+yphP6KhJtN8wJXCC?=
 =?us-ascii?Q?n8zirUJHjMhj2ikuVH5LBXADMsRs5AB6lHjxxY7AZ0i/dU697loZGbi6PTGP?=
 =?us-ascii?Q?twzOL9zXPt1lxzKCT/iu/TuN5LZM7uybchDAAYIkgP9UBdJwzRPpfhtCkl6u?=
 =?us-ascii?Q?AatoS9uT49Jtm0Tqc04/Pgej966BcZpReNVxB7SxF8vWwUIR+162u1jONZzB?=
 =?us-ascii?Q?nVpZLDlFrfFm6atot0vBAwqD226JgS0ZFEpBRjE05tkRKgQxytJIuKpQReUP?=
 =?us-ascii?Q?p26Ljhpt5rmPDEB3d1j9BIWYlOdWSl77naRz/ueE3rcnE2pYAInoL9W2M9Xu?=
 =?us-ascii?Q?NHFR5j8fWB9JsUa0/dBuUFYPP4CJtTmOo2yGRNh0tOmRKWOdKLigvEpn2iEw?=
 =?us-ascii?Q?Ge7DtuMTvl8dyNZYHglFmJ0uSFMM3zOuuUuEgfvreMLFRhJbYGCt7ZRHPrxm?=
 =?us-ascii?Q?NnE0qcLZka8ry5NaK438NIm7kfodDhf7iH6VRH7L42zVcNpfzXQU74Jp6QIl?=
 =?us-ascii?Q?slbhQyjJ6QJN2z/F/3xCwbyvWe4cgDy0VfoCBZXOCz55ShoDLbJWYI+Ahpin?=
 =?us-ascii?Q?26VQaxQyj1bkeqoFLvQJ3abYrlec5hg47Z1iJVXfAgrBFz50VPw1dyKWqEaP?=
 =?us-ascii?Q?g7HTo18OL/C43vC8cq4YJgMuxE/LZg60pHI/3P/D+ch138XzcjgY/OCNarXL?=
 =?us-ascii?Q?RlpvzWp4gs7ahp/yQLn8ZKZ0RqV83Eotu0VeDfYquA0cOeL/QJei7bwBoDxO?=
 =?us-ascii?Q?ubGbNmCFL/Go0B/kSBhqS1Ek1HrL+lANhMimMi5gdwynfBl2aadmOFzzo4ZO?=
 =?us-ascii?Q?bYksA5vRWusJQzQqEh0xcBxWFabZzgp8XS3yGyMlBP9Y4xftohQ9VrdoEH3L?=
 =?us-ascii?Q?MnItbMH6Iw4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 07:25:21.1679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fb2b02-a35e-4d23-1ad5-08dcf8b4034f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

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
v3..v4:

o No changes.
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c57a79e34911..aaf99c0bcb49 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1242,7 +1242,7 @@ static void nohz_csd_func(void *info)
 	WARN_ON(!(flags & NOHZ_KICK_MASK));
 
 	rq->idle_balance = idle_cpu(cpu);
-	if (rq->idle_balance && !need_resched()) {
+	if (rq->idle_balance) {
 		rq->nohz_idle_balance = flags;
 		raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
-- 
2.34.1

