Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF11EDA08
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044071; cv=fail; b=Iisw068akwRNaoRyY2pTww9Z9UOwHQ0WduZHPEJ6x3+F48JEYBGPS+4znaFvhG6wJOvv16sr/foVhSYaUYlvPJdIu17qrQv5hu1Px0DoJNuP3HnaRnD+nW/IQgNturg6e9VNerakMWIepxQ08F2Z2eEATJrWkUNhVU8+wALYIDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044071; c=relaxed/simple;
	bh=PXBnxvdSR08axr/5ulrd+i+xg/LYAleBs9/oKfVm9Wk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkX9oPdPR/Z2V0nAEjam9kBY5E2M+2voavISAePFelekYWAmBmXGux1TT5OMauHIIKusLffK6Dl7WO0w2C5ltLo/oWV79LzIyyebCtwKzGCjXhiudR/Ps9mOyCqyZlDn+Ioeio+fxO491UQSUSvtufdxHJRCHK2Es6kj8jzxEKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tb7dstII; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tb7dstII"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdKs+oDO11Ui3JfDruSnl8pdOe5lTDEyz1PoVvIOFZIRjd6I+2Y3TSKlaU9qRSvdiczip96KyqiF1qdALF70dSYHQgoKkJNb+eDOea2asEThjPP8KItUTNu8ehnkXJyn8qBqOfLHCAWzLkGKZtRQdEZwp8/QsLqTO8tAfIRmlwvQUFNcvW12Bw0GcXoX2Cp92VS9CHzAJe2+bCD/KNZpvIwQu9LLFRRTVG5NTxmDfJpH0ToE/cQsXnuJ4bvToZU94nJr5n0sfVlD+Imis7DOixcWSa1W0i1SHH/fL8Sz7rUA8Gj3TAzjTh9tCtcnw1JSaG9SGkvrniVOOJmAGpwXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo5YEpkAzZH6uuGbbFuGZkNa23/Az+vfC+Spr7Rc8Tw=;
 b=ujLOyWLheJJSUJs+Cl4sccCsyp+jCwtjggnICekeY6CGEYZ+ZUXGxughesvAYOcyyRiSZjC9xjG6C40xZV4S6AVumeuPyBgr/brz7q3pXZ777Ir0cxB4zFyxxzDuwBHISK4td0mGkD4nhC/Goz1zw+R8B6DR1ymBt7wG3AGU1XTe3l7ji+4ltuMpWX0BvYIytndFoSsmj+YFpCH38mS+d0rTyUEESUHYF7jMlMcIs0RBcahJ+uAm1kLJN3Ix4eYbyICERQSXnJfqhJf7P8TNeQICxDx1vBj4i9L1EPXUWK3YOhd3u4ULi9Hotdp4IyV2EqPyMaCMiW3yTTYoSNPviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo5YEpkAzZH6uuGbbFuGZkNa23/Az+vfC+Spr7Rc8Tw=;
 b=Tb7dstIIgBVStolojTQV1oI0vJpvDpr9UfY93ZHXL+027AONcX81voAWT/n3PSVB9YBQke6FiYd7xI7xEz0J2zN56PdL+UZvA4395BhxZCKf2kJDkMZw4n7EvWh+miknu+Wl+pHVVYopmmXadveHb7GvdBpdDLysZrO0Z+ytKFc=
Received: from DS7PR03CA0204.namprd03.prod.outlook.com (2603:10b6:5:3b6::29)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 09:34:27 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::78) by DS7PR03CA0204.outlook.office365.com
 (2603:10b6:5:3b6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 09:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:34:27 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:34:18 -0600
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
Subject: [RFC PATCH 03/22] [PoC] kernel/entry/common: Mark syscall as a kernel critical section
Date: Thu, 20 Feb 2025 09:32:38 +0000
Message-ID: <20250220093257.9380-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1d4e04-5742-47af-83fc-08dd5191c4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N8Z6UVSx5YEnxe2nusjEETGfDPJ1d74q5pRLnseupmCfTMsqp/3oQwDoz5YE?=
 =?us-ascii?Q?6QygecdpZeonSBz0A2Magw9m1mDcaWJ5PlWcRt0ZVFsQSGvpgCvRoibJYHvX?=
 =?us-ascii?Q?DKsfLmkWAOh9kPNukDvzr639lBLuabS6DAz0fGxHOK1auN2oz2m5qRU/nnPK?=
 =?us-ascii?Q?PV0WR2vyDMfYfXq5XNDTevrSYTQkwmCU++1Tgpd9bRUJuB54/zEctHd/uo+x?=
 =?us-ascii?Q?WnL5ydEnCN2E11ZIZvRniS8jyicbTvc5avqIhpEq8UEKOeaBmwfDIuwANz+c?=
 =?us-ascii?Q?T7TY+NeJ+fxk1ozCZPMUo7oAoUvCliAc+asR+Lu984hybXjbYKWbbQmDE9Kz?=
 =?us-ascii?Q?2qD6aJfm9YBw35GyYZbvt8Fo0SD1z884jSg9pDxg8W10UcXjfuszzRXgSurK?=
 =?us-ascii?Q?tRdIflieD9fm+jGXBmCzGFwauBYUx5l7/+k8wU8vw1BicCzQh1W0fBXbZyWW?=
 =?us-ascii?Q?oNaKEb2UBmt1b9KKs0SyDLcazoq1SqvBs3YF18V3mrilQ720V/rmfuk+IDbc?=
 =?us-ascii?Q?TctGT3qLvFuFwpOv7oaGgcJscNLtb42L6LLepPVQ65EPhgsIRq4QzCalkffR?=
 =?us-ascii?Q?xV86kzUYRTWZIH4M/lBHQVJm82X6d7OqgJmH9iwe8d8z+OOVXz3g+SlYLdSO?=
 =?us-ascii?Q?hhRdzu3M3zo0rnglzKS5dofWB1ob9fQlfm8GVUEB0nhPsslab6MrrVFqQl7T?=
 =?us-ascii?Q?ILRs0z15NEr7F+xXQNvZr3/EhNsiW3duCoE1+VSbx9fgHRAfYkC4QP2QDN3N?=
 =?us-ascii?Q?dzPIdibnxSgxpXK7cKaC6syMxUfz37GCEv8IcQrP1tO+UhhEDVYYhKPOJ9GS?=
 =?us-ascii?Q?ifclIQLvnwKd3AfN+g0pFX89BvLfJ5K4/TBlawcqEBJX93sHwL9LqIJFBu7o?=
 =?us-ascii?Q?u9fV+yS78rHkA9r6027Anr+7xcUXqUonNfNMmG4yoJRK5+hNpu+jg4KBUBsT?=
 =?us-ascii?Q?bP9jaMUgdewaBUr62+wcwFvCkndjTy46ByFDBVAzysR1UDPbK1smQ1cXj8Pq?=
 =?us-ascii?Q?DOWTqy1ny+rMgT/khIs18PaNOeQ2x6TQ5OVzg1ubZgxBshPr9YmVixZH59ro?=
 =?us-ascii?Q?DuFc2ODet0mY+CEIudxdmqrUtIzRwS9Ss9g/OqM14J8TMWbBDqf+ajzzOAFw?=
 =?us-ascii?Q?ZVvC/XPiYfr9Isz7M/QIHSPfxDQyMdFqhniYsDevQfptDj8ykkCLA445+/5m?=
 =?us-ascii?Q?lTuwJCP/f4d+kqs/bjXIwuO1LQVFnXtt6cwZwTaeM07HAZb2kuruIt1Ngsxk?=
 =?us-ascii?Q?/6hinmZJfu2hiKtkLvoTEoSR+tjS/1qvgf7jNHMpnW8SUdxDiFQAIfZZkxAx?=
 =?us-ascii?Q?ON0ItBE5LYnD5NZbLDHqRxmQT+s5Jn7Yx1iy6+FKAy+rool/JgatUhlOqYXd?=
 =?us-ascii?Q?bNDq00YDnLy0EB6clOO/yoiDBmSbRQi6VFhsuicoi/5/kM/oPLsbxqDaikUy?=
 =?us-ascii?Q?c3R90xC5waJsR93O2NDQiQykMQUnWrogbEq7sWni7p1gayzr0yYnxi+8zZ00?=
 =?us-ascii?Q?hOF4u7e7oofLsK0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:34:27.0737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1d4e04-5742-47af-83fc-08dd5191c4e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488

Mark the syscall boundary as a kernel critical section. Use a per-task
"kernel_cs_count" to track task's entry from userspace and exit to
userspace. When "kernel_cs_count" is non-zero, the task is executing in
kernel mode.

For this Proof-of-Concept, "kernel_cs_count" can only be 1 or 0 for a
tasks and the implementation will run with the same assumption. The
critical section is defined as an integer count to allow fine grained
control in the future where certain boundaries within the kernel can be
marked as resource holding critical sections.

For the sake of simplicity, the whole kernel mode is marked as a
critical section in this PoC. For future extensibility,
sched_notify_critical_sction{entry,exit}() helpers are defined to mark
boundaries of kernel critical section and is similar to preempt_count()
mechanism.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h | 19 ++++++++++++++++++-
 kernel/entry/common.c |  7 +++++++
 kernel/entry/common.h |  4 ++++
 kernel/sched/fair.c   | 20 ++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 34862d904ea3..63f3f235a5c1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -577,7 +577,24 @@ struct sched_entity {
 	/* cached value of my_q->h_nr_running */
 	unsigned int			runnable_weight;
 	int				depth;
-#endif
+
+#ifdef CONFIG_CFS_BANDWIDTH
+	/*
+	 * Keep track of tasks, and cfs_rq(s) that contains tasks
+	 * running in kernel mode. Any throttling event for the
+	 * cfs_rq will be deferred until this count hits 0.
+	 *
+	 * Semantics:
+	 *
+	 * - For task: It represents if the task is currently
+	 *   running in kernel mode. It is always 0 or 1.
+	 *
+	 * TODO: Describe for sched_entity when implementing.
+	 */
+	int				kernel_cs_count;
+					/* hole */
+#endif /* CONFIG_CFS_BANDWIDTH */
+#endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_SMP
 	/*
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index cc93cdcc36d0..b132b96e2b96 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -83,6 +83,8 @@ __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, lon
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
+	sched_notify_critical_section_entry();
+
 	if (work & SYSCALL_WORK_ENTER)
 		syscall = syscall_trace_enter(regs, syscall, work);
 
@@ -214,6 +216,11 @@ static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *reg
 {
 	syscall_exit_to_user_mode_prepare(regs);
 	local_irq_disable_exit_to_user();
+	/*
+	 * Notify scheduler that the task is exiting to userspace after a
+	 * syscall. Must be called before checking for NEED_RESCHED work.
+	 */
+	sched_notify_critical_section_exit();
 	exit_to_user_mode_prepare(regs);
 }
 
diff --git a/kernel/entry/common.h b/kernel/entry/common.h
index f6e6d02f07fe..73e699a4c3e9 100644
--- a/kernel/entry/common.h
+++ b/kernel/entry/common.h
@@ -4,4 +4,8 @@
 
 bool syscall_user_dispatch(struct pt_regs *regs);
 
+/* sched notifiers for CFS bandwidth deferral */
+extern void sched_notify_critical_section_entry(void);
+extern void sched_notify_critical_section_exit(void);
+
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 857808da23d8..becf2d35f35a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -58,6 +58,8 @@
 #include "stats.h"
 #include "autogroup.h"
 
+#include "../entry/common.h" /* critical section entry / exit notifiers */
+
 /*
  * The initial- and re-scaling of tunables is configurable
  *
@@ -6704,6 +6706,20 @@ bool cfs_task_bw_constrained(struct task_struct *p)
 	return false;
 }
 
+__always_inline void sched_notify_critical_section_entry(void)
+{
+	current->se.kernel_cs_count++;
+	/*
+	 * Post this point, the task is considered to be in a kernel
+	 * critical section and will defer bandwidth throttling.
+	 */
+}
+
+__always_inline void sched_notify_critical_section_exit(void)
+{
+	current->se.kernel_cs_count--;
+}
+
 #ifdef CONFIG_NO_HZ_FULL
 /* called from pick_next_task_fair() */
 static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
@@ -6772,6 +6788,10 @@ bool cfs_task_bw_constrained(struct task_struct *p)
 	return false;
 }
 #endif
+
+__always_inline void sched_notify_critical_section_entry(void) {}
+__always_inline void sched_notify_critical_section_exit(void) {}
+
 #endif /* CONFIG_CFS_BANDWIDTH */
 
 #if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
-- 
2.43.0

