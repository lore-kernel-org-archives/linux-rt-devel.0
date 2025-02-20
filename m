Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC21F03CB
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044178; cv=fail; b=gCuKtP8UT3IkzzVTLOQPpvkzS6uXbUZSQ+BDhafoe4MXNe9RwDy+uP8JGyi7bLwbC4yg8TZt5jc/O4lGiwVXbKkTjGZSndOVoKyIK32WIPJi1d6Bx79ipVW/9deqO+LVV1VGxUGoJgD8KneJtaVrg92uNMcrFv2q2R+7zFXMA4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044178; c=relaxed/simple;
	bh=p1LMJdt8iWYYnZE2IuN8pGcIx+K4RX1RZN0a8NXhk5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCjCosG+MI1dk/x2j0Sm/BNsWCBSpJaDqsLTrlAaF5qs6EMQdDM29X+d5FaCNktPirwlkMX70BPLKaB2aCLYbOOTPo/3TVZTDjRw+C4giYbTF6mQd4fAGHh4w6IpmCyudKoszrM2wFfpo0UXMwGCq3nXZ7YeKNv6azRLTscvZoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M/ekUtoc; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M/ekUtoc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLgbFvVIUxER6zQh7fAGdY6wxGvrwu5h5iglXrx5k2Hoo2jNEdR7OUSHFqf2uvgs0/4feF7Iynf0Cn6S6nRxJe4EHt9Gy9QDPht2gqtrXNECawc63KzQxBIyA2MTV6xJYWG4DdaR6SXGsPrquXTV5y7XIGTbd9xRKh/2tjSVnNgbAmHIIidPAG4Jk1FvYGj8zx7oiwVy7syuXTtyOeDEBr0KwBg3zIYttFm1MgxBV/qKl+HULY69UMnB6JdbcLZxMPjI7Z40rs7KjC6+Xs4RwgDA/+55ytNP9EC80/hkbjOCbSeLidC6uKJWpdf1tbqdqXtBwRnKHo1WFCsBP5spUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsyHr8OIJjB23ZLAsncS91MPiMVjz60/hNOFvMm07Xk=;
 b=xIWXaGKeBOmZlHPIBI1UniMI2RlJimBWaQ4MHpRgmcpqgqUSjmzUSA6TW52aYLUaOPy3ATXPcOWzbVeCqhdKdv4KcietIJi8HOpN+62HSIcJ+jcD95cZzzQevIz8GD+/2V4Qdf37iJ9niYem7HmuWhFSc2NwbGp9IoWvk0oQSo8xXCIFVc1A2gVmYumwn1Xmx0wE/9MnIZBYJKDBd1L+iwVQG1iUhN55TGXoz8890uzNhJ4t1XzSCzXnC3qvVWohII7D6G6LhmTNLNGKU3QOwpLu2klvCN7GUsfM1IMc58oOMoUXNKQAVz3uE+dRpFGYc+X/v41z7u3y/us4qL8ZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsyHr8OIJjB23ZLAsncS91MPiMVjz60/hNOFvMm07Xk=;
 b=M/ekUtoc5eJun7fLbMiS6unni5ZdMGBWT6tndU2Z2h+uk/jb2PzaWIhujomE5w2Z1chBJv39sn/hZI5apaoqTLtKrHTLnZGX6lagtNg7oOfQBiAi1RmQEhyHHgymon4VEKwfPdPjYPZUL2i7VhhKiBcYvrbaWDo3HcLKPM82ioQ=
Received: from CH0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:610:b1::12)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 09:36:13 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::c7) by CH0PR13CA0007.outlook.office365.com
 (2603:10b6:610:b1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 09:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:36:12 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:36:04 -0600
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
Subject: [RFC PATCH 08/22] sched/fair: Allow pick_eevdf() to pick in-kernel entities on throttled hierarchy
Date: Thu, 20 Feb 2025 09:32:43 +0000
Message-ID: <20250220093257.9380-9-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 929b1135-e3d9-4546-4ea6-08dd519203d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mCq2HbXEpp2UCt2sBn7CkbhkwQbE6wCAtwM9BP+gfXmFSDArZ+cXqM44Tst1?=
 =?us-ascii?Q?PuMpKCRF5e0YPK7+aUZ2knFj1iC4OhZODlSWRcP3d4oG46jdfvYE950hVJ1O?=
 =?us-ascii?Q?qp3oyq3c2020sTIk6x/ma4Q9N9boElPX9U1bp2nw6HY+6+ancPXfP6EcMdDf?=
 =?us-ascii?Q?riSmlFW1/zxOeAuZX4sQ8V2igqb3H+t/XjwVOMZoqpSTtWSEoHbEFCjnOrfB?=
 =?us-ascii?Q?NKT4VPsSuxic/jmM2JLQb12shvM5PB6nvPx8X8S5E/AyThpdkHqEU+IxiE27?=
 =?us-ascii?Q?aZqkUH4jVLueNyGGy3no4fajYtrPomUjlHY5xjbSHWt0oBeym+niJepmFAKc?=
 =?us-ascii?Q?x1iAHluiEHUlRAGi+q/WJElbuZfX2szCDGxkpmTf7lDvI1BsMBggCjjAtwAx?=
 =?us-ascii?Q?xbtxpVrrmSfnP9WPJ518W8IhwRFPX0fXlWk61kubobdazQxaEmhtrq5yHBdf?=
 =?us-ascii?Q?nQR2YwZdoUENYLzMtMjjFp0chIOfACiWy8FvMZsXm2JbAHdyVu4gRnvf518h?=
 =?us-ascii?Q?2+42JAulbIbVL5F1JrywD4dsUnHJrlaiRl/VV3PY/vA6oqOlZ/NwDraaoRWo?=
 =?us-ascii?Q?9vbmVHx+6ym+U6GhxhKRt6KDfE/LPkYjrdBvr5waw+8M5ecSL/iv3YvZPCub?=
 =?us-ascii?Q?jaL3FseI0i4kZilBDw8f9w4Z2C7PAyuFk+CaI3JGcqQHVzk+twZAVSO6qgwQ?=
 =?us-ascii?Q?QsOfLYPXcXYWwhzr3nMfS9qsynxEZa3UA7hEgzSJJw01O2hdLnJOye9PK6+E?=
 =?us-ascii?Q?QAZ/dN4FaYiSRGpd7olqmuQKYrU1fL80OGuGeAcTON9osSds1mKQM44KAevS?=
 =?us-ascii?Q?s3zSvx3t1Q6zs5CeFr44XuhTqHl95BEhK5fakoHwyf/fO22w0tdtX04x31Gt?=
 =?us-ascii?Q?T1xBrFYOoKZaApF97+hfQETh9dRyrCyoRYm0hlBBFKcG8JnW8L7X+Y2nwoLi?=
 =?us-ascii?Q?sPjGSdDpuE11fOoELs+dPvBnOdzG10xJ8cjzRNiEWDqYWet/dF4bvQ/9P6vZ?=
 =?us-ascii?Q?ZUiw45AUHSejKLLBPoS01Drm8yyrInvc2mXBjheE0kTDWPa/qmT7qwXPEPeq?=
 =?us-ascii?Q?FwpC8lqVyQPwkHt/3KUN3VWYVHCeMT/221IdLsw0ETqan9CYottJFMhS1Wea?=
 =?us-ascii?Q?eJOMRo7VpOp+F1ZuKm8Xi9IdNJbwFn8+vwODGJ4W/7RgLzYGOolQaXW5F8gU?=
 =?us-ascii?Q?gJrxIDA4wCOOBTPv/YKq+0vDayTJISD2GWkgGITaVCtpNNkqx0hN7s+vyq+m?=
 =?us-ascii?Q?KdPQHRcojb87G5RLBv+gAfXwsgz6UDoxSVFtTKy5BlMh4pGKWsdVTwTJpny/?=
 =?us-ascii?Q?mK96R7B1o5SKqW/qoARR3H0ywn97EOUarN1MPCCyqPnE8TAGcFPigh11enQ/?=
 =?us-ascii?Q?9Kj0Kzji2Cu1z5I/hXIYDF4zlYxGsK3rl6uzUuj31Reb8rYqNrskmYDwXZkO?=
 =?us-ascii?Q?iYkoMEOPuvAc0M9MU1a4eR50VsHdckUjODctX2xXgdEUSwVfT3ErpHvF6b6o?=
 =?us-ascii?Q?CcQn8kFj3qA4Eq8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:36:12.7123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929b1135-e3d9-4546-4ea6-08dd519203d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

pick_task_fair() makes sure that the a throttled cfs_rq is dequeued and
unreachable to pick_eevdf() when it encounters one during pick. With
deferred throttling, it is possible for a throttled cfs_rq to have
kernel mode preempted entities queued on it making it runnable.

Allow pick_eevdf() to find and return only the kernel mode preempted
entities when picking on a throttled hierarchy. Introduce two new
wrappers - pick_entity() and pick_subtree() around entity_eligible() to
abstract away the nuaces of picking on a throttled hierarchy.

Introduce pick_se_on_throttled() and pick_subtree_on_throttled() to find
the eligibility of kernel mode preempted entity or its subtree amongst
all kernel mode preempted entities still queued on the rbtree using the
EEVDF stats.

Since current task is outside the "kernel_cs_count" tracking, take
special care when accounting for it in pick_*_on_throttled().

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 134 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 124 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f28624e4442..4fd70012b479 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -526,6 +526,9 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
 static __always_inline void avg_kcs_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se);
 static __always_inline void avg_kcs_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se);
 static __always_inline void avg_kcs_vruntime_update(struct cfs_rq *cfs_rq, s64 delta);
+static __always_inline int pick_se_on_throttled(struct cfs_rq *cfs_rq, struct sched_entity *se);
+static __always_inline
+int pick_subtree_on_throttled(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 /**************************************************************
  * Scheduling class tree data structure manipulation methods:
@@ -750,6 +753,24 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return vruntime_eligible(cfs_rq, se->vruntime);
 }
 
+static __always_inline
+int pick_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, bool h_throttled)
+{
+	if (unlikely(h_throttled))
+		return pick_se_on_throttled(cfs_rq, se);
+
+	return vruntime_eligible(cfs_rq, se->vruntime);
+}
+
+static __always_inline
+int pick_subtree(struct cfs_rq *cfs_rq, struct sched_entity *se, bool h_throttled)
+{
+	if (unlikely(h_throttled))
+		return pick_subtree_on_throttled(cfs_rq, se);
+
+	return vruntime_eligible(cfs_rq, se->min_vruntime);
+}
+
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	u64 min_vruntime = cfs_rq->min_vruntime;
@@ -936,7 +957,7 @@ static inline void cancel_protect_slice(struct sched_entity *se)
  *
  * Which allows tree pruning through eligibility.
  */
-static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq, bool h_throttled)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *se = __pick_first_entity(cfs_rq);
@@ -950,14 +971,14 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (cfs_rq->nr_queued == 1)
 		return curr && curr->on_rq ? curr : se;
 
-	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
+	if (curr && (!curr->on_rq || !pick_entity(cfs_rq, curr, h_throttled)))
 		curr = NULL;
 
 	if (sched_feat(RUN_TO_PARITY) && curr && protect_slice(curr))
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
-	if (se && entity_eligible(cfs_rq, se)) {
+	if (se && pick_entity(cfs_rq, se, h_throttled)) {
 		best = se;
 		goto found;
 	}
@@ -970,8 +991,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 		 * Eligible entities in left subtree are always better
 		 * choices, since they have earlier deadlines.
 		 */
-		if (left && vruntime_eligible(cfs_rq,
-					__node_2_se(left)->min_vruntime)) {
+		if (left && pick_subtree(cfs_rq, __node_2_se(left), h_throttled)) {
 			node = left;
 			continue;
 		}
@@ -983,7 +1003,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 		 * entity, so check the current node since it is the one
 		 * with earliest deadline that might be eligible.
 		 */
-		if (entity_eligible(cfs_rq, se)) {
+		if (pick_entity(cfs_rq, se, h_throttled)) {
 			best = se;
 			break;
 		}
@@ -5601,14 +5621,14 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	/*
 	 * Picking the ->next buddy will affect latency but not fairness.
 	 */
-	if (sched_feat(PICK_BUDDY) &&
-	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
+	if (sched_feat(PICK_BUDDY) && cfs_rq->next &&
+	    pick_entity(cfs_rq, cfs_rq->next, throttled_hierarchy(cfs_rq))) {
 		/* ->next will never be delayed */
 		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
 		return cfs_rq->next;
 	}
 
-	se = pick_eevdf(cfs_rq);
+	se = pick_eevdf(cfs_rq, throttled_hierarchy(cfs_rq));
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		/*
@@ -6795,6 +6815,89 @@ static __always_inline void init_se_kcs_stats(struct sched_entity *se)
 	se->min_kcs_vruntime = (se_in_kernel(se)) ? se->vruntime : LLONG_MAX;
 }
 
+/*
+ * Current task is outside the hierarchy during pick_eevdf(). Since
+ * "kernel_cs_count" has not been adjusted yet with put_prev_entity(),
+ * its preempted status is not accounted to the hierarchy. Check the
+ * status of current task too when accounting the contribution of
+ * cfs_rq->curr during the pick.
+ */
+static inline bool curr_h_is_throttled(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	struct task_struct *p;
+
+	/* Current hierarchy has been dequeued. */
+	if (!curr || !curr->on_rq)
+		return false;
+
+	/*
+	 * There are kernel mode preempted tasks
+	 * queued below this cfs_rq.
+	 */
+	if (se_in_kernel(cfs_rq->curr))
+		return true;
+
+	p = rq_of(cfs_rq)->curr;
+	/* Current task has been dequeued. */
+	if (!task_on_rq_queued(p))
+		return false;
+
+	/* Current task is still in kernel mode. */
+	return se_in_kernel(&p->se);
+}
+
+/* Same as vruntime eligible except this works with avg_kcs_vruntime and avg_kcs_load. */
+static __always_inline
+int throttled_vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime, bool account_curr)
+{
+	s64 avg = cfs_rq->avg_kcs_vruntime;
+	long load = cfs_rq->avg_kcs_load;
+
+	if (account_curr) {
+		struct sched_entity *curr = cfs_rq->curr;
+		unsigned long weight = scale_load_down(curr->load.weight);
+
+		avg += entity_key(cfs_rq, curr) * weight;
+		load += weight;
+	}
+
+	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
+}
+
+/* Same as entity_eligible() but for throttled hierarchy. */
+static __always_inline int pick_se_on_throttled(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	bool account_curr = curr_h_is_throttled(cfs_rq);
+
+	if (se == cfs_rq->curr) {
+		/*
+		 * If cfs_rq->curr is not accountable, it implies there
+		 * are no more kernel mode preempted tasks below it.
+		 */
+		if (!account_curr)
+			return false;
+	} else if (!se_in_kernel(se))
+		return false;
+
+	return throttled_vruntime_eligible(cfs_rq,
+					   se->vruntime,
+					   account_curr);
+}
+
+/* Similar to entity_eligible(cfs_rq, se->min_vruntime) but for throttled hierarchy. */
+static __always_inline
+int pick_subtree_on_throttled(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	/* There are no kernel mode preempted entities in the subtree. */
+	if (se->min_kcs_vruntime == LLONG_MAX)
+		return false;
+
+	return throttled_vruntime_eligible(cfs_rq,
+					   se->min_kcs_vruntime,
+					   curr_h_is_throttled(cfs_rq));
+}
+
 static inline void __min_kcs_vruntime_update(struct sched_entity *se, struct rb_node *node)
 {
 	if (node) {
@@ -6969,6 +7072,17 @@ static __always_inline void avg_kcs_vruntime_sub(struct cfs_rq *cfs_rq, struct s
 static __always_inline void avg_kcs_vruntime_update(struct cfs_rq *cfs_rq, s64 delta) {}
 static __always_inline void init_se_kcs_stats(struct sched_entity *se) {}
 
+static __always_inline int pick_se_on_throttled(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	return vruntime_eligible(cfs_rq, se->vruntime);
+}
+
+static __always_inline
+int pick_subtree_on_throttled(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	return vruntime_eligible(cfs_rq, se->min_vruntime);
+}
+
 static inline bool min_kcs_vruntime_update(struct sched_entity *se)
 {
 	return true;
@@ -9045,7 +9159,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	/*
 	 * If @p has become the most eligible task, force preemption.
 	 */
-	if (pick_eevdf(cfs_rq) == pse)
+	if (pick_eevdf(cfs_rq, throttled_hierarchy(cfs_rq)) == pse)
 		goto preempt;
 
 	return;
-- 
2.43.0

