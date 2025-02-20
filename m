Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520AA1EE7D6
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044409; cv=fail; b=bzT9jxwq+p8d2nwl9D+9Bm3F6VopJlB6tKTsG2UORkgWbfWsBWjAbK+pMuc3WfWM4pyW2b9o1Q0yg1c1koFB95Z176zmyUgOyYE0p3qVKk9d29+4Dx0I0+XkNrQY5qtyA96k5LuONkv4Deyyvmd2SBumu/+ywQMn71e8MUBQt6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044409; c=relaxed/simple;
	bh=WfEPtldfjL99H30wLhN2r3QFN0VEJvoj4Xqn6AQ7i8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjBOy0znT0MqryB3dQ9205KpsooxESvP+Ma0bnASrN5UCJy6sKX5vU0yLawVX1hxwwpbACsAVyPOKbGB/+7yCX6VnfqXrgOvBT1TeWFt+qySAjkAZpmghp86y8awg8W/KTE+FX7pulCrPBZpCMXSGDLSIG4xPP0F5NEEwNkgcS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dT/xppOJ; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dT/xppOJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dw4C7H0/VcdQjw4uqCXturVd0vDXtBfAhkGETx6bxmHL0xQ0N2FIk6QAqUpvSOu5bE5anMN9FG7qmwS9TdyPsVOjBidfSyPIbrODEMD7rE8l6iyr+WT9QdsBWXQgcNm+8v+8MOFlw+moCBXUAPaBpOh6HVKEhAt8T89dudTnuOQPT85vwGySunhR45Sipn+pVjsdQT2bL0fHGnABmjVmNIVF6l/4vOHgP8j99vK29L/m4xurWyAo+Q7wLsLWFgcbJ/aDFJV3nipQHwZS+82E1vXooCjmmKdpmzelraOLviqHiE4Ar7Cs4PRvgSKHC3lKQ0pNpr0660G8GPB5z2GpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaW/47/AixTTJrYcn0CU1cejnepHc91zlsswqtw+Bw8=;
 b=NJBfW/9pdzyZIxBWlRiGw/09IbMUJBygASaBMv5ECmmIZH2FjAO0eCrj0FdmXDeFb4XVxxfIQIsdShr38UJ5AUD5C5LNv0n8rJrfg9EF6Cljo0W7uAXLuSN4JVs3fB444XBc8lSG9AVQ4/5S2+1q/uP3QzMu7CHRaZk7yca3z7sIowltltl3fELhtwEu6OfacwaAe+l5asuhq2EPXPG/p0qN4aq3aRKBxIpUkLKIpiNdOErxvyg/lRYhV6Kq74FnLxChdHQP4wiDCVNfo5d4c4cFaDlQJEt4zJd6UbWiazdueTVhA/5xCjwYHLtTesXVqwgXK5dzI65EWW/kp0zmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaW/47/AixTTJrYcn0CU1cejnepHc91zlsswqtw+Bw8=;
 b=dT/xppOJuMxWQNFR1zXgHTGqRPt+6LHX5latq4VkJ8bpNKY9f5DhgBpXZA7igFiLhOdljpi10z69EJ92/LqxudjIX78GONPcK3iKE42QmgYW/8ngcAhb9bB6G04aEyPa6BDZRJaVYibFdGFrREIDKeY2xxOeeso+2upkTfOG7Qc=
Received: from BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 09:40:03 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::5c) by BLAPR03CA0082.outlook.office365.com
 (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 09:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:40:02 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:39:54 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>, "Ben
 Segall" <bsegall@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Andy
 Lutomirski" <luto@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
	<linux-rt-devel@lists.linux.dev>, Tejun Heo <tj@kernel.org>, "Frederic
 Weisbecker" <frederic@kernel.org>, Barret Rhoden <brho@google.com>, "Petr
 Mladek" <pmladek@suse.com>, Josh Don <joshdon@google.com>, Qais Yousef
	<qyousef@layalina.io>, "Paul E. McKenney" <paulmck@kernel.org>, David Vernet
	<dvernet@meta.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [RFC PATCH 19/22] sched/fair: Ignore in-kernel indicators for running task outside of schedule()
Date: Thu, 20 Feb 2025 09:32:54 +0000
Message-ID: <20250220093257.9380-20-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220093257.9380-1-kprateek.nayak@amd.com>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7c6387-d35d-4ebd-0a50-08dd51928cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hj5MlYNgu4z8Vav1xDyQ61VyK/zwwSKMKF5s5YsfaZO3c8N/Rfgyk4sFCgcl?=
 =?us-ascii?Q?Y5KyUsPH23cGrRcjQ5pOMEfs21N2xwiqWbWHD9kp2KOOq931bB1x/YwjyJKs?=
 =?us-ascii?Q?aHzKywfOLog2Bx0/DstEDnC+wjha87EWGotDM+UqMPMAPPrxZ4j6pYMTr1ra?=
 =?us-ascii?Q?3y5ZHy/7lBPND9pacS0J5MDxrLvYwou+xyUOXskKC2t9qgPvI/pi9qsKF5fx?=
 =?us-ascii?Q?FMSsOFYt1s656zy+zaGcwJ5tQMFgxchYD6vec+bWdamWznhD697rB64BdBaT?=
 =?us-ascii?Q?dVutr2kk+JjWEU7kMV3HzZZHchMoWfDf/BvtyJYE4Bt/L6vnYhKUCKtn7Kqj?=
 =?us-ascii?Q?yiKQ33jA8pVy0sZZ7hwds58lxOKk39+gqjEqFK/BUbLTHmrrncRIbXRWm2nr?=
 =?us-ascii?Q?Vl9cOniXtbYp/p1xvM3+RxJBgHcw3yuEdsTy85649QGS0ThPWl5+v4cxqdoB?=
 =?us-ascii?Q?5hyTdwZ1EDR7kZFrr/4R2TcxfSejSPJ4qQuFBT6TUtZkenqF3BYkqAbDrOEF?=
 =?us-ascii?Q?U2kTf6eDbNuYxF1M240bkl+Rvm2+sPZ9rwINKzt6MWDHSbu/STZvaKklwEi6?=
 =?us-ascii?Q?lng2inoeLY1Kv3lFJZ9WN+gI+CPeAR9weO0G+kyS5UQYn6LtEszXHnGQG1Z/?=
 =?us-ascii?Q?Kf+/J0xHVavgI3PKryreZvrB7cuf8mkMmyHXxHbeUvFcC9Us3U+GDlo1uVCf?=
 =?us-ascii?Q?bHUZcm5eLGqOw+5I9ZfZWNBDqXxJ/cy8Flnd6WS1JSe19hbvm4rSlJrMTiSa?=
 =?us-ascii?Q?NrlquhEwCnQZ6L7vmAmQMMIBVeD8SAXb/QmNA0G3gPOfuyRsHC20oo7++yOh?=
 =?us-ascii?Q?vADlO9TUWy2KHg2gNDo6rs4ulFws4zmPRHwJ1B8NU7vlelH9gpw2K5QHrfqQ?=
 =?us-ascii?Q?NMKBnRNoivKDk1SOeXW0RUPbgmTZl147SKhFYr510m1jHgjpskxKS1WS+B6c?=
 =?us-ascii?Q?Z5sL2p4QTrODJaf1vQMyJXhSushI2w6veCVC69K5nsGgQVT+acD9EoCuHnel?=
 =?us-ascii?Q?puxhh6mFiHGB83G2PJeiWBp+RSG7zWjX6sPgwzaDO7mOj0cuevwFGMe6sW8o?=
 =?us-ascii?Q?6q4YdDBbVN7YfgvlwMhZAKOah3vRPP54rFjp4PPbzrv+30wC0bT3d+PjmUUF?=
 =?us-ascii?Q?Pe7IB8BD8mtjpYLM+AQ64z21hJ6bQ0MNQcCSj/D7pkUWisdX2xQRPnDJcMxc?=
 =?us-ascii?Q?QQE41FBc0e7FuuD5wlIVJrFaw1n69PGm+5v3B87CsizJtd+5WLWp/KWcWnMF?=
 =?us-ascii?Q?SZLGwvl73ZLPX7yO4Xyk8vKUuqO7kD5IuEtKeG4dwHqnHWcvfwra3V4iG19t?=
 =?us-ascii?Q?03VUP4Sj7jvo2ViFyq9nuG26+70JkS7RbdmazPV3C/NqthXZLX9GUoeA5g7a?=
 =?us-ascii?Q?RapyKzvkER5zX+PP7GGCQvyi5Y7/FZc6VMu9Hxl7Moa/20vaeY3TMOxse4wV?=
 =?us-ascii?Q?1V+5XeImGeslZ0HvLhVPCNIh4GTYigycoxZQi4ZuFntnhF/PvnYkW6cncXac?=
 =?us-ascii?Q?4P/tlDpFf1qBBgE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:40:02.6093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7c6387-d35d-4ebd-0a50-08dd51928cdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965

A running task can go a dequeue_task() -> put_prev_task() ->
enqueue_task() -> set_next_task() cycle when on_cpu for a number of
operations.

Since the task is running on a remote CPU, its "kernel_cs_count" is
unstable and looking at it can lead to wrong outcomes (imbalanced
accounting at __enqueue_entity() and __dequeue_entity())

Use "sched_throttled" to indicate that the task's kernel mode indicators
should be ignored. put_prev_task() is called with prev set to NULL only
for save restore operations and is used as an indicator to set the
ignore bit. Subsequent call to set_next_task_fair() will clear this
indicator.

There are cases where the save restore cycle can fully throttle the
task's hierarchy. One such condition is:

    dequeue_task()
    put_prev_task() # Sets cfs_rq->curr to NULL
    ...
    enqueue_task()
        enqueue_task_fair()
            check_enqueue_throttle()
	        # cfs_rq->curr is NULL so goes ahead
                # Full throttle
    set_next_task() # Sets cfs_rq->curr back

If set_next_task_fair() finds a task marked for ignoring but has been
forced into running on a throttled hierarchy, request resched for
schedule() to partially unthrottle the hierarchy if required before
going ahead with the pick.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 115 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1497b0aed1c2..55e53db8da45 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6837,6 +6837,21 @@ bool cfs_task_bw_constrained(struct task_struct *p)
 	return false;
 }
 
+/* se->sched_throttled states: Modifications are serialized by rq_lock */
+enum sched_throttled_states {
+	/* No throttle status */
+	PICK_ON_UNTHROTTLED	= 0x0,
+	/* Task was picked on a throttled hierarchy */
+	PICK_ON_THROTTLED	= 0x1,
+	/*
+	 * Ignore tasks's "kernel_cs_count". Used for save / restore
+	 * operations on running tasks from a remote CPU. Prevents
+	 * enqueue and set_next_entity() from adjusting the stats and
+	 * puts it off until schedule() is called on the CPU.
+	 */
+	PICK_IGNORE		= 0x2,
+};
+
 __always_inline void sched_notify_critical_section_entry(void)
 {
 	SCHED_WARN_ON(current->se.kernel_cs_count);
@@ -6847,6 +6862,8 @@ __always_inline void sched_notify_critical_section_entry(void)
 	 */
 }
 
+static inline int task_picked_on_throttled(struct task_struct *p);
+
 __always_inline void sched_notify_critical_section_exit(void)
 {
 	lockdep_assert_irqs_disabled();
@@ -6860,7 +6877,7 @@ __always_inline void sched_notify_critical_section_exit(void)
 	 * schedule() soon after enabling interrupts again in
 	 * exit_to_user_mode_loop()?
 	 */
-	if (!current->se.kernel_cs_count && current->se.sched_throttled) {
+	if (!current->se.kernel_cs_count && task_picked_on_throttled(current)) {
 		struct rq *rq = this_rq();
 
 		guard(rq_lock_irqsave)(rq);
@@ -6873,15 +6890,40 @@ static __always_inline int se_in_kernel(struct sched_entity *se)
 	return se->kernel_cs_count;
 }
 
-/* se picked on a partially throttled hierarchy. */
+/* task picked on a partially throttled hierarchy. */
 static inline void task_mark_throttled(struct task_struct *p)
 {
-	p->se.sched_throttled = 1;
+	WRITE_ONCE(p->se.sched_throttled, PICK_ON_THROTTLED);
+}
+
+static inline void task_mark_ignore(struct task_struct *p)
+{
+	WRITE_ONCE(p->se.sched_throttled, READ_ONCE(p->se.sched_throttled) | PICK_IGNORE);
 }
 
 static inline void task_clear_throttled(struct task_struct *p)
 {
-	p->se.sched_throttled = 0;
+	WRITE_ONCE(p->se.sched_throttled, PICK_ON_UNTHROTTLED);
+}
+
+static inline void task_clear_ignore(struct task_struct *p)
+{
+	WRITE_ONCE(p->se.sched_throttled, READ_ONCE(p->se.sched_throttled) & ~PICK_IGNORE);
+}
+
+static inline int __kcs_ignore_entity(struct sched_entity *se)
+{
+	return READ_ONCE(se->sched_throttled) & PICK_IGNORE;
+}
+
+static inline int task_picked_on_throttled(struct task_struct *p)
+{
+	return READ_ONCE(p->se.sched_throttled) & PICK_ON_THROTTLED;
+}
+
+static inline int ignore_task_kcs_stats(struct task_struct *p)
+{
+	return __kcs_ignore_entity(&p->se);
 }
 
 /*
@@ -6893,6 +6935,10 @@ static __always_inline void avg_kcs_vruntime_add(struct cfs_rq *cfs_rq, struct s
 	unsigned long weight;
 	s64 key;
 
+	/* See avg_kcs_vruntime_sub() */
+	if (__kcs_ignore_entity(se))
+		return;
+
 	if (!se_in_kernel(se))
 		return;
 
@@ -6912,6 +6958,15 @@ static __always_inline void avg_kcs_vruntime_sub(struct cfs_rq *cfs_rq, struct s
 	unsigned long weight;
 	s64 key;
 
+	/*
+	 * A remote running task in being enqueued for a restore operation.
+	 * Since it has an unstable "kernel_cs_count" being in a running state,
+	 * do not account its stats yet. A set_next_task() -> schedule() will
+	 * follow on the CPU to adjust it.
+	 */
+	if (__kcs_ignore_entity(se))
+		return;
+
 	if (!se_in_kernel(se))
 		return;
 
@@ -7238,6 +7293,20 @@ static __always_inline int se_in_kernel(struct sched_entity *se)
 
 static __always_inline void task_mark_throttled(struct task_struct *p) {}
 static __always_inline void task_clear_throttled(struct task_struct *p) {}
+static __always_inline void task_mark_ignore(struct task_struct *p) {}
+static __always_inline void task_clear_ignore(struct task_struct *p) {}
+
+static inline int task_picked_on_throttled(struct task_struct *p)
+{
+	return 0;
+}
+
+static inline int ignore_task_kcs_stats(struct task_struct *p)
+{
+	return 0;
+}
+
+
 static __always_inline void avg_kcs_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static __always_inline void avg_kcs_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static __always_inline void avg_kcs_vruntime_update(struct cfs_rq *cfs_rq, s64 delta) {}
@@ -7437,6 +7506,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
 		util_est_enqueue(&rq->cfs, p);
 
+	/*
+	 * Running task has just moved to the fair class.
+	 * Ignore "kernel_cs_count" until set_next_task_fair()
+	 */
+	if (task_on_cpu(rq, p) && (flags & ENQUEUE_MOVE))
+		task_mark_ignore(p);
+
 	if (flags & ENQUEUE_DELAYED) {
 		requeue_delayed_entity(se);
 		return;
@@ -9582,9 +9658,23 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 	 * Clear the pick on throttled indicator only if
 	 * another task was picked and not for a save /
 	 * restore operation for the task.
+	 *
+	 * For a save / restore operation of a running task,
+	 * mark the task to be ignored for "kernel_cs_stats"
+	 * adjustment. Either set_next_task_fair() or
+	 * switched_from_fair() will clear these idicators.
 	 */
 	if (next)
 		task_clear_throttled(prev);
+	else {
+		/*
+		 * put_prev_task_fair() is only called with next as NULL
+		 * during save / restore operations. Since idle thread
+		 * is always runnable, all other cases will have a valid
+		 * prev task set.
+		 */
+		task_mark_ignore(prev);
+	}
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -13897,6 +13987,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_entity *se = &p->se;
 	bool task_in_kernel = !task_on_cpu(rq, p) && se_in_kernel(se);
+	bool h_throttled = false;
 
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -13905,6 +13996,22 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 		account_kcs_dequeue(cfs_rq, task_in_kernel);
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		account_cfs_rq_runtime(cfs_rq, 0);
+		/* Check if task is on a partially throttled hierarchy */
+		h_throttled = h_throttled || cfs_rq_throttled(cfs_rq);
+	}
+
+	/* Mark the end of save / restore operation. */
+	if (ignore_task_kcs_stats(p)) {
+		task_clear_ignore(p);
+
+		/*
+		 * If the hierarchy is throttled but the task was not picked on
+		 * a throttled hierarchy, the hierarchy was throttled during the
+		 * course of a save / restore operation. Request a resched for
+		 * pick_next_task_fair() to reevaluate the throttle status.
+		 */
+		if (h_throttled && !task_picked_on_throttled(p))
+			resched_curr(rq);
 	}
 
 	__set_next_task_fair(rq, p, first);
-- 
2.43.0

