Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AE1E04AE
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044158; cv=fail; b=OOsZMH43jk5zJACDirXVbk5ji4QioLMQ0aDE3voMOV8QNrgeoeZrn8TQMSfSIvLlYozz8JwvTbY5NlcrnssW1GzugvQsJYpUuZ7oPWaIgALV67ZtkcG/JgMkY51vhjuzQ9Do5R44G6ZJNs6OMmaGHzflj4aGuHrAZJHyz00cqb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044158; c=relaxed/simple;
	bh=gEJNMxBDe3sWUsSn19wU+R+KS/4ddbI8seGEJVwGxpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkYC11PY0Hr0f4xS8+KNOBVghLywQXmiZyGS3cGPD09XC8EtBVxR3ThX+aj2UHwMKQO7V35vZ03XtcOgwD7ce4BzzzNvpQY+0jdhbYwjuxDIrFdsveEprc76DL5t+mqdtizlTX4a+O1hctU9Z7xx2DzlxhoyGzr5Nh7zdyMP99M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OI+HP+dp; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OI+HP+dp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irl6I4I4T7iSK4T18wn2tFDRe1VvZHoJyRJcCHYv/p7PMEhIR2pSUiuhKWOSLNv4njX1r+T1ebIQQmpOV5SNfakU2MSYXxw0bb9FCTdUb6Qhzb0xazstwYc7t5uvWHhZuJXVJR4cOBZARxf+aNpV5a7WLUpz9DtfSaazN1ZoqWwWEq2FADLtMktpRLbfnTG3dKs/JOiHhU/k/gchOScsLLtvpJMo8N+YE6hvP2qB4e+Egz5J4KyNtTEJvNFO21ptspwicIhJLGoj+tFMTQt3tc5DiGC5HG8+Ja/+FIKlsKS6WV60xYceZxE1Rp2iZFGotn/OvjgE4HOFPrSlCZeIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHWX5d7o1X/WWHhVJpbpRN159IorwOAvTto4D1H/Nho=;
 b=ftEEEIcEX1CwUUz0pXZlbiZDsLvNgkPL0QneAWqdXyQZP1NVFO2+lpUb/gIkUS4z1PG9dSSuuFd7+oCxvtS/27fVQ2fcmGFLCNG5imxBGdISNt4291r6Bgc2Y4cWI1yupjiGWzzXFbxFAt/MGKabiHQtLzMyR7hJnfwt7Dwmh+uKI0PgzHtIid5uzqWXNa6Gl2T81FU2eXv2EKnPjDg1SFi6qasxDZA+y6dH9cAcuj3UHRJMY+xzAYGSeoMpn193W1zEDrUa5DgHtQX0WQ2iapb8MYBl+l3W0v+MOFZNiWGglONMVPzcj++F88Jl2agPYa39HmESsy4SDX5r6uTTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHWX5d7o1X/WWHhVJpbpRN159IorwOAvTto4D1H/Nho=;
 b=OI+HP+dp26RCEoOGRnpR5e4psFESXr7xvbSuGTaYyJlgu/Dt1AuW5aJQZAiTCfbzLPzv+ILDppYB43taKNN+Ixq16sBunnphRbISJJciEkofiwBGZRTC5GEoyksqvqGLfqRjcR59MBmkigbN/a8biNaD7ro8eUGvoy7woLSI11I=
Received: from DS7PR03CA0204.namprd03.prod.outlook.com (2603:10b6:5:3b6::29)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 09:35:52 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::e4) by DS7PR03CA0204.outlook.office365.com
 (2603:10b6:5:3b6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 09:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:35:51 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:35:43 -0600
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
Subject: [RFC PATCH 07/22] sched/fair: Propagate preempted entity information up cgroup hierarchy
Date: Thu, 20 Feb 2025 09:32:42 +0000
Message-ID: <20250220093257.9380-8-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d1426f-96a8-4178-4a7a-08dd5191f767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EHIYfl/HanvZQ83qOmPsSvqXheiF/0AFRfjtnxUz8kl08btcbLsAGkwXSX9l?=
 =?us-ascii?Q?jlQ5blFOZpGK33DFXOeOmYh/mFM/Bg2qLhpOEc9d1Hj0U3PzxRzvJoa0zjMN?=
 =?us-ascii?Q?gCGryXiY40s1Y2eWBbN2eNlDaCcVYwsfKGU2S1qmBiOIXZs8dFAyqt4zJzIJ?=
 =?us-ascii?Q?BiBA1keQWyzhTfociuCRCEyro4ZeRAWeGEifBtGZxTqKkzyr4qtv1zskr1xA?=
 =?us-ascii?Q?Ob4i3XSXkE0Rk9YKk+tKn4VL3nZu4bSU1/bK8Gkvnr0hZWzcmjquaxT4Aks8?=
 =?us-ascii?Q?xFHORi7e442hI8t6gI26Si/2cS66Y443FEpHgDHZS3/C5ulQiWX6gX1eZFN+?=
 =?us-ascii?Q?3ieyh0iPM5e7mrgN7j5JaEai2EYJwavg9yJmBJHjIGH6f2+K3gNH67DKMT3W?=
 =?us-ascii?Q?AyuLjoAD1YP+mpoO5VNlXpstPGdu3PRPOanqgs2sBpQq8mcVyvbMfrn41h5A?=
 =?us-ascii?Q?MuEh+vx0ab3DJjlMU6CXsdoOfFKvjkmJity1wnRMYT3TTIIJeX+3fEgXFyTz?=
 =?us-ascii?Q?MaommAfQyItPtI/hvfv2HDwG4659tRvi2bv+6LByUrCGRfwPgs8Vhc4itMVH?=
 =?us-ascii?Q?SGwOWhOefNegOORmHc/rDOTea3GDXqHN+CfWxpEXv2HU91vasJrMklNAYIM7?=
 =?us-ascii?Q?UV7dzrHwdu7OdHc0mr5aodS5yl/rtHyl+3jNaw0C4pHDoWco6VmXOg+NYNLf?=
 =?us-ascii?Q?GmTpj7whQ0ibMKmEcyYoVCoZf2Yjx2tKPKDJYg5YCOFTEwYG18sv07Nl//Ez?=
 =?us-ascii?Q?AcVpj2E5wOElyGiHsQoyCshnTuK024LvSObMx/58s/cAUm243ZONvKop+fvC?=
 =?us-ascii?Q?A/zlfmleSUkdaUQZwBgdS4vXKFZk4pGObB6lVARsyzh9nXKhyDV12Xy16J7C?=
 =?us-ascii?Q?ugf+48qL+qA5/iTFUe1qzVAg+uyt+C1bLrA5ARaAEK3P/YNMmVW/aMe6uyPx?=
 =?us-ascii?Q?B/HlFChuzrSOVjTDu4pgDrc587Bv7V/8SHwexRg6FEVH/agcJZJgoBCm4Byq?=
 =?us-ascii?Q?XiZeSVCUB6hPD6SHXwFIkASZe13/ZZo0laQOZzSiqBSSPLNWSGAX3L6Tnnm+?=
 =?us-ascii?Q?9urpZ3NckQujc3ABcj+DdHGXYDnD8UpYzgwiiw5DlpeP3wItbKMlrrCChI/m?=
 =?us-ascii?Q?2IBeAsVa7soCh5qb7TBvKBs4YSqK0PBWN00b6EQzo270Hfvf8B684zr+AKrr?=
 =?us-ascii?Q?nHJPF66x6el1q0sXvoWMa7l5utI1QkzYZc6yr36kml/TTsJWSJgvaPYvAqUV?=
 =?us-ascii?Q?E75j0jNhbnMUs67w0NVaTb88awlCl8yIB8UKabf/lONoLud2Jmhf3xSb4nfB?=
 =?us-ascii?Q?u+OJdllpVhX0VrQxtUinr0d25SzjvGFIPxmbyVQOitN6nFlAmv5mheHOYtRJ?=
 =?us-ascii?Q?Lg7j4pEqvsGyE4wj7T11cCT1GraUpoDSs7Vw6Cq/TdbcjQSh0mbHPecK50XB?=
 =?us-ascii?Q?j5CpHMToVxLViUroELXXBRUsatM2qXCinu/Mnq4GLg12ALGSnCXSNxb3iTl1?=
 =?us-ascii?Q?C+6KX0drdtLXfbM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:35:51.8390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d1426f-96a8-4178-4a7a-08dd5191f767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001

Use "kernel_cs_count" in cfs_rq's sched entity to track the number of
preempted entities queued on the cfs_rq. Since the current task can
frequently switch in and out of kernel mode, "cfs_rq->curr" and the
whole sched entity hierarchy of the current task is treated special.

This is similar to "runnable_sum" except "kernel_cs_count" does not
have a corresponding count in the in struct cfs_rq.

The counts are managed at enqueue, dequeue, and task pick boundaries
since the entities on rbtree have a stable "kernel_cs_count". Use
min_vruntime_cb_propagate() generated from RB_DECLARE_CALLBACKS() to
propagate the adjustments to the root of the rbtree.

Since propagations require the state of the task being enqueued /
dequeued / put / set, expose se_in_kernel() to generic code to
streamline the propagation.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h |   7 ++-
 kernel/sched/fair.c   | 121 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4bb7e45758f4..48115de839a7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -589,7 +589,12 @@ struct sched_entity {
 	 * - For task: It represents if the task is currently
 	 *   running in kernel mode. It is always 0 or 1.
 	 *
-	 * TODO: Describe for sched_entity when implementing.
+	 * - For cfs_rq: It represents the sum of the
+	 *   kernel_cs_count of the entities queued below it
+	 *   except for the "current". Since the current task can
+	 *   frequently switch in and out of kernel mode, its
+	 *   hierarchy is treated  special and its contribution
+	 *   is accounted at key decision points.
 	 */
 	int				kernel_cs_count;
 					/* hole */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba1bd60ce433..9f28624e4442 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6732,7 +6732,7 @@ __always_inline void sched_notify_critical_section_exit(void)
 	current->se.kernel_cs_count--;
 }
 
-static inline int se_in_kernel(struct sched_entity *se)
+static __always_inline int se_in_kernel(struct sched_entity *se)
 {
 	return se->kernel_cs_count;
 }
@@ -6817,6 +6817,76 @@ static inline bool min_kcs_vruntime_update(struct sched_entity *se)
 	return se->min_kcs_vruntime == old_min_kcs_vruntime;
 }
 
+static inline void account_kcs_enqueue(struct cfs_rq *gcfs_rq, bool in_kernel)
+{
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+
+	if (!in_kernel)
+		return;
+
+	se = gcfs_rq->tg->se[cpu_of(rq_of(gcfs_rq))];
+	if (!se)
+		return;
+
+	cfs_rq = cfs_rq_of(se);
+	se->kernel_cs_count++;
+
+	/* se has transitioned into a kernel mode preempted entity */
+	if (se->kernel_cs_count == 1 && se != cfs_rq->curr && se->on_rq) {
+		/*
+		 * Must be done after "kernel_cs_count" has been
+		 * incremented since avg_kcs_vruntime_add() only
+		 * adjusts the stats if it believes the entity is in
+		 * the kernel mode.
+		 */
+		avg_kcs_vruntime_add(cfs_rq, se);
+
+		/* Propagate min_kcs_vruntime_update() till rb_root */
+		min_vruntime_cb_propagate(&se->run_node, NULL);
+	}
+
+	/* Sanity check */
+	SCHED_WARN_ON(se->kernel_cs_count > gcfs_rq->h_nr_queued);
+}
+
+static inline void account_kcs_dequeue(struct cfs_rq *gcfs_rq, bool in_kernel)
+{
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+	bool transition_out;
+
+	if (!in_kernel)
+		return;
+
+	se = gcfs_rq->tg->se[cpu_of(rq_of(gcfs_rq))];
+	if (!se)
+		return;
+
+	cfs_rq = cfs_rq_of(se);
+	transition_out = se->kernel_cs_count == 1;
+
+	/*
+	 * Discount the load and avg_kcs_vruntime contribution if the
+	 * entity is transitioning out. Must be done before
+	 * "kernel_cs_count" is decremented as avg_kcs_vruntime_sub()
+	 * should still consider it to be in kernel mode to adjust
+	 * the stats.
+	 */
+	if (transition_out && se != cfs_rq->curr && se->on_rq)
+		avg_kcs_vruntime_sub(cfs_rq, se);
+
+	se->kernel_cs_count--;
+
+	/* Propagate min_kcs_vruntime_update() till rb_root */
+	if (transition_out && se != cfs_rq->curr && se->on_rq)
+		min_vruntime_cb_propagate(&se->run_node, NULL);
+
+	/* Sanity checks */
+	SCHED_WARN_ON(se->kernel_cs_count > gcfs_rq->h_nr_queued);
+	SCHED_WARN_ON(se->kernel_cs_count < 0);
+}
+
 #ifdef CONFIG_NO_HZ_FULL
 /* called from pick_next_task_fair() */
 static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
@@ -6889,6 +6959,11 @@ bool cfs_task_bw_constrained(struct task_struct *p)
 __always_inline void sched_notify_critical_section_entry(void) {}
 __always_inline void sched_notify_critical_section_exit(void) {}
 
+static __always_inline int se_in_kernel(struct sched_entity *se)
+{
+	return false;
+}
+
 static __always_inline void avg_kcs_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static __always_inline void avg_kcs_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static __always_inline void avg_kcs_vruntime_update(struct cfs_rq *cfs_rq, s64 delta) {}
@@ -6899,6 +6974,9 @@ static inline bool min_kcs_vruntime_update(struct sched_entity *se)
 	return true;
 }
 
+static inline void account_kcs_enqueue(struct cfs_rq *gcfs_rq, bool in_kernel) {}
+static inline void account_kcs_dequeue(struct cfs_rq *gcfs_rq, bool in_kernel) {}
+
 #endif /* CONFIG_CFS_BANDWIDTH */
 
 #if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
@@ -7056,6 +7134,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	/* A task on CPU has its in-kernel stats discounted */
+	bool task_in_kernel = !task_on_cpu(rq, p) && se_in_kernel(se);
 	int h_nr_idle = task_has_idle_policy(p);
 	int h_nr_runnable = 1;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
@@ -7110,6 +7190,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->h_nr_idle += h_nr_idle;
+		account_kcs_enqueue(cfs_rq, task_in_kernel);
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;
@@ -7136,6 +7217,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->h_nr_idle += h_nr_idle;
+		account_kcs_enqueue(cfs_rq, task_in_kernel);
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;
@@ -7196,6 +7278,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
+	bool task_in_kernel = false;
 	int h_nr_idle = 0;
 	int h_nr_queued = 0;
 	int h_nr_runnable = 0;
@@ -7205,6 +7288,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (entity_is_task(se)) {
 		p = task_of(se);
 		h_nr_queued = 1;
+		/* A task on CPU has its in-kernel stats discounted */
+		task_in_kernel = !task_on_cpu(rq, p) && se_in_kernel(se);
 		h_nr_idle = task_has_idle_policy(p);
 		if (task_sleep || task_delayed || !se->sched_delayed)
 			h_nr_runnable = 1;
@@ -7226,6 +7311,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->h_nr_idle -= h_nr_idle;
+		account_kcs_dequeue(cfs_rq, task_in_kernel);
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
@@ -7267,6 +7353,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->h_nr_idle -= h_nr_idle;
+		account_kcs_dequeue(cfs_rq, task_in_kernel);
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
@@ -9029,6 +9116,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	 */
 	if (prev != p) {
 		struct sched_entity *pse = &prev->se;
+		bool prev_in_kernel = task_on_rq_queued(prev) && se_in_kernel(pse);
+		bool next_in_kernel = se_in_kernel(se);
 		struct cfs_rq *cfs_rq;
 
 		while (!(cfs_rq = is_same_group(se, pse))) {
@@ -9036,18 +9125,35 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 			int pse_depth = pse->depth;
 
 			if (se_depth <= pse_depth) {
-				put_prev_entity(cfs_rq_of(pse), pse);
+				cfs_rq = cfs_rq_of(pse);
+
+				account_kcs_enqueue(cfs_rq, prev_in_kernel);
+				put_prev_entity(cfs_rq, pse);
 				pse = parent_entity(pse);
 			}
 			if (se_depth >= pse_depth) {
-				set_next_entity(cfs_rq_of(se), se);
+				cfs_rq = cfs_rq_of(se);
+
+				set_next_entity(cfs_rq, se);
 				se = parent_entity(se);
+				account_kcs_dequeue(cfs_rq, next_in_kernel);
 			}
 		}
 
 		put_prev_entity(cfs_rq, pse);
 		set_next_entity(cfs_rq, se);
 
+		if (prev_in_kernel != next_in_kernel) {
+			for_each_sched_entity(se) {
+				cfs_rq = cfs_rq_of(se);
+
+				if (prev_in_kernel)
+					account_kcs_enqueue(cfs_rq, prev_in_kernel);
+				else
+					account_kcs_dequeue(cfs_rq, next_in_kernel);
+			}
+		}
+
 		__set_next_task_fair(rq, p, true);
 	}
 
@@ -9114,10 +9220,17 @@ void fair_server_init(struct rq *rq)
 static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	struct sched_entity *se = &prev->se;
+	/*
+	 * When next is NULL, it is a save-restore operation. If the task is no
+	 * longer queued on the rq, the stats have been already discounted at
+	 * pick and should not be adjusted here.
+	 */
+	bool task_in_kernel = next && task_on_rq_queued(prev) && se_in_kernel(se);
 	struct cfs_rq *cfs_rq;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
+		account_kcs_enqueue(cfs_rq, task_in_kernel);
 		put_prev_entity(cfs_rq, se);
 	}
 }
@@ -13424,11 +13537,13 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
 static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_entity *se = &p->se;
+	bool task_in_kernel = !task_on_cpu(rq, p) && se_in_kernel(se);
 
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		set_next_entity(cfs_rq, se);
+		account_kcs_dequeue(cfs_rq, task_in_kernel);
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		account_cfs_rq_runtime(cfs_rq, 0);
 	}
-- 
2.43.0

