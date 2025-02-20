Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794321EE032
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044305; cv=fail; b=m2JbuFKQMPk+h7DW8+8h4NPFZ+78Xs+WzEVSC2x1ln6jUcsO9a9+f7ijkWIsc1d8W7+cZiYYBraDSY0SyitxH6IWH5nAfpHZveAa+HLKNK6C17qEZc3E1hCljzVMHthH2V0h83CTMfvbOLTPpjqo4jlKfUrfOEJWgQ+shP6tcts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044305; c=relaxed/simple;
	bh=7DsmJ9pJi2aGFH+fxFfh7c6Zm4gRix7r/JLV0o+xCDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tdgbau7AMZJiWgncMyWBBsIR/MSSk56yJyiCesR0XiAnH7HEuG0W38dvcFCoyVhBnkCRmz79B2jtuzUuz5pRg2DzrhgUADUHCzZGypa7Jj+6hT+tCUPLdOyLwn1IFwRt9EnZeM6HAnH/R4EQEoOCRiOw6ZoVCzt/KLC+bjLL0Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bxR3nvb3; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bxR3nvb3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFethb5edMfYvTTRjqFTcx1rLIgqljNkknazoX0wn7kBPLxaL2BJAOhy428i5aPjy+BEYwIsVZZB3zaj8zneSAX0uzu1m9k/Pa8N4vTcvxR7RwJqdmfCVObC4nJxMmPL/SZ73tiaxpUIxuxGb+6H1SkhJsDT6N342bK/O7cz1bqFO51vSLSz8bv5HtCnc8X8pFxeFkr3PNQbCXMXK0Q6a5bepOstAIJ2/ZkHRi82tLJKYvF1vxxjUfWq8FftGoYnPOUZciYpmQ6dmjdEkhl5fdvDKAx3bdlgWSiEmQ6yaXWHvM7bIa9mhGoq9M1MieCHbl/8YUOzvpPCEvd1+yLkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/pCy8bdFTh/kb/9k+el28421njpzz0Pzj1UasNPQ9s=;
 b=HiYt9g5ZaV5M9iN0DGK+q1Tdq5hje2TaQVWDg0G75nVO0ZYMNJ5nfF9PUwqIc1KWAgEWahcXiH2LUyPYuCYkVe3aLQObMk8xu6aZlMVzupMAfDi7hSNAseMSokSlA8jyT7kmJ+01/xAVwFo7vWeBoX6En/Tru1zbWrWSjP3ihc/BIb1JAsDRpb5Sv5AoBzkBGaX9vVHoHVx5F1ih40YHfI5CjkIAbyaR7TZ4ptT1iwinFunMZpd53I6IFJmoC2Eg7um+PzHsK+IXiGTJd1sF4HprtbmGf4yC2g3YJ6nUwKh4aPs9T/E2tEToAvsqv/KLsYbRdOfgoFRkXHspgXIXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/pCy8bdFTh/kb/9k+el28421njpzz0Pzj1UasNPQ9s=;
 b=bxR3nvb3fRCifxDR1Ng0WG9CYJzPZnOTgs+C8KMs7oLgc4HPKI9KUs55Dukcfde45v1SgBI18IL/GrGnGUhJRsDivCgGfBhhGmJTZONzpQc3RWNeRR52R+KsyGdO/HLcZNqCcmr1rJHUFojFqkD6/LM+oYr8ZdWvhOiSdqBdcBQ=
Received: from BN0PR04CA0024.namprd04.prod.outlook.com (2603:10b6:408:ee::29)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 09:38:19 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::41) by BN0PR04CA0024.outlook.office365.com
 (2603:10b6:408:ee::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 09:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:38:18 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:38:10 -0600
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
Subject: [RFC PATCH 14/22] sched/fair: Mark a task if it was picked on a partially throttled hierarchy
Date: Thu, 20 Feb 2025 09:32:49 +0000
Message-ID: <20250220093257.9380-15-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: b9061e71-6b4e-444f-7a56-08dd51924e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fUwNCtlKaimXtmIxeG+durD0bY3nt3HsYemhAm2e/wIKsOG0Sj3o+aA6Q6c9?=
 =?us-ascii?Q?qQLpsemCt89L7QNnbR3ivkklQPNt/8Y3WajSBBbv7L1EIPHxYjOH4Pl2bLnT?=
 =?us-ascii?Q?X1OLTnbtwccVkKw7ObfPs4e2/4J/RsZPyJwvMRng9We1sUPIKTiGEW3xl1S0?=
 =?us-ascii?Q?/WLCdNXzZ7e3+CioF56322EByQ4Jaw0NLE8aU+VcZeCGDNxPKRx5JluGvfrV?=
 =?us-ascii?Q?Mf0PRDgRkywNIj4evRT0fEBBFVIOa5hEYeUE4WIb2m3yX5Fm8swPzO+RBCyK?=
 =?us-ascii?Q?dHDbkieXIkdXUs1rbJHgQneoYd3pFFRxJrDkgK1+UidHnCZDwI41Q0jVvi4h?=
 =?us-ascii?Q?wQF2FJ9v2MbD6h74QT2//ZurPaDK/llZab1xJ7BD24iZctTudWZ7h51Esd7L?=
 =?us-ascii?Q?oBM6uyLZcjExP+6Ytx5OyeRhvnvGO1jmm9fRgQZNhND0qin6k1pX+ObYRlRS?=
 =?us-ascii?Q?yKs9kdCwmuQVBmLIf7PJeSW2jVTMDs/dvM+Ok2dnLht3UBcUTQKSm4dKOtca?=
 =?us-ascii?Q?z5Up69RlP1koQQys48jvOPLX1I9CWDkKkFJ/0/tuQU6zJlweSks1nijrwue/?=
 =?us-ascii?Q?KC8y0BERotmV4bKVIX1i8/k4r9BZ+5Vodmr4hcYABRljnK5tPpRFS77fcCzN?=
 =?us-ascii?Q?OnoOqs2EysQsng0Hv/R1IN8IhT1TorZ0Mvs5L6ZWi/WxKGqqjd0XfQG1M9GD?=
 =?us-ascii?Q?MG4EFE02zJm/98lNJQjEgs3pqZetIpT4xjd9PjLvhJq9qOq/QBoeLmuJqdoM?=
 =?us-ascii?Q?W20rBkBVoHaMRBTGhp/tvJsL7RYRAx30637bhfC3BohgRAVBkOTUvH6UnCWx?=
 =?us-ascii?Q?IQEalXUyfy7HimDjx1Q/vMhlRbpARNe7UXO/6V9wydvczTk6yNNm64kJWINH?=
 =?us-ascii?Q?YA0GwN2X/UU2/w/2DvqreBOA260s3VK+z5j3ywqhkjF7/W3c0nzJx8drQENg?=
 =?us-ascii?Q?9Aj45xtJmxDHM49Q/EW0I2YZby2n0Ly22fcxcHAvJZLW6GoXs5GxcjK47iqO?=
 =?us-ascii?Q?XWN+2XN9L3d6/dtVwTssT8ECAY3xi9y+JSR/FXLvIZ9w4EkithM7P1htPOX8?=
 =?us-ascii?Q?7g49bz8Z9riweYYgXLycAAeBr64G9oFQy/7xKMLsbkBA7PbPoYxplr2Yqi/J?=
 =?us-ascii?Q?W37AKrtRlHdzB8ESxggEpSFUUpjK5pelCh4zC/EQTslcp2B+qviWUEYRSqFH?=
 =?us-ascii?Q?7MHYVh8LMXQYdcdx9u6noLXzp45A116J/bL4qu6NUSABpmXbWX4Bnqkg7bKF?=
 =?us-ascii?Q?gxTmAU7ofj1jMtpfPI13ogPSo5UMCACNTMV9a6dylYYmuFmypH+y6lfp90AM?=
 =?us-ascii?Q?qO5Dz+/8clBWWTgYsPMwbEPr8HdCMG4FiXTHo74x3UrPocDpxV4drVGNKfsY?=
 =?us-ascii?Q?FfUKv6B4DnHG55ad00NDESsOi4sqEUY4OCXjwsbF7OkuiBifabLBATjYdRzT?=
 =?us-ascii?Q?d0gVlAyjo2vhVyZw4GtfCCiBkJtS+FZUx05YcldUpD7LmfeqTkBt5FVa9G5F?=
 =?us-ascii?Q?tYBYshitpfgVvfA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:38:18.0912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9061e71-6b4e-444f-7a56-08dd51924e8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

With partial throttle, the hierarchical throttle indicator, namely
"cfs_rq->throttle_count" will not be set. To detect a task picked on a
partially throttled hierarchy, set a "sched_throttled" indicator in its
sched_entity to trigger a schedule() when "kernel_cs_count" hits 0.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h |  3 +++
 kernel/sched/fair.c   | 30 +++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 48115de839a7..200cc086e121 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -597,6 +597,9 @@ struct sched_entity {
 	 *   is accounted at key decision points.
 	 */
 	int				kernel_cs_count;
+
+	/* Entity picked on a throttled hierarchy */
+	unsigned char			sched_throttled;
 					/* hole */
 
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d871509b246..68c194169c00 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6856,6 +6856,17 @@ static __always_inline int se_in_kernel(struct sched_entity *se)
 	return se->kernel_cs_count;
 }
 
+/* se picked on a partially throttled hierarchy. */
+static inline void task_mark_throttled(struct task_struct *p)
+{
+	p->se.sched_throttled = 1;
+}
+
+static inline void task_clear_throttled(struct task_struct *p)
+{
+	p->se.sched_throttled = 0;
+}
+
 /*
  * Same as avg_vruntime_add() except avg_kcs_vruntime_add() only adjusts the avg_kcs_vruntime
  * and avg_kcs_load of kernel mode preempted entity when it joins the rbtree.
@@ -7171,6 +7182,8 @@ static __always_inline int se_in_kernel(struct sched_entity *se)
 	return false;
 }
 
+static __always_inline void task_mark_throttled(struct task_struct *p) {}
+static __always_inline void task_clear_throttled(struct task_struct *p) {}
 static __always_inline void avg_kcs_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static __always_inline void avg_kcs_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static __always_inline void avg_kcs_vruntime_update(struct cfs_rq *cfs_rq, s64 delta) {}
@@ -9281,6 +9294,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 
 static struct task_struct *pick_task_fair(struct rq *rq)
 {
+	struct task_struct *next;
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
 	bool h_throttled;
@@ -9307,7 +9321,11 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
-	return task_of(se);
+	next = task_of(se);
+	if (h_throttled)
+		task_mark_throttled(next);
+
+	return next;
 }
 
 static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
@@ -9349,6 +9367,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		bool next_in_kernel = se_in_kernel(se);
 		struct cfs_rq *cfs_rq;
 
+		task_clear_throttled(prev);
+
 		while (!(cfs_rq = is_same_group(se, pse))) {
 			int se_depth = se->depth;
 			int pse_depth = pse->depth;
@@ -9457,6 +9477,14 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 	bool task_in_kernel = next && task_on_rq_queued(prev) && se_in_kernel(se);
 	struct cfs_rq *cfs_rq;
 
+	/*
+	 * Clear the pick on throttled indicator only if
+	 * another task was picked and not for a save /
+	 * restore operation for the task.
+	 */
+	if (next)
+		task_clear_throttled(prev);
+
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		account_kcs_enqueue(cfs_rq, task_in_kernel);
-- 
2.43.0

