Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDFE1EFF8D
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044472; cv=fail; b=nI8mkATajafytgvIlHjdYy8HvteD1pV0c29bHWKcaETYkdgS9+InbDxhu1CvY06lVVQTmR50HicAq4sPO2as9jNlsv/J+0CJpTWMaGl6Y4Gm/7lppe0WI50Bj9GbhLqtcRyD3t4OG2NjZNhEWGGP0bVPmvx1vLE2a33+ZKeloFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044472; c=relaxed/simple;
	bh=f+rub2I1ceHEufMM+Pq3RFHwT8dL31PEHEVJKWpBgO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Byr+Z1L4sQPa5+wmfggDFZjWRVZpZ8xar68cVo7WpND9QGRA33Wffb8RgS5VipZzX++R9H/T9bz+ul3rk6zgLcAe1twlLue43nfKmJEbHi944nzcvCf6cQ2gNnKukYosWB4af2VBQh7NbdQISQ2DuMugAwXbTCacERFDSoeQsE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pnniTs1K; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pnniTs1K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXzOwT1+8HIickO102oS+VrJhNUPOtOqCJVdd++/V9djJY1NSqzXtzOZ8asfqZ0kSJ80zJruKhKfZZ6GeKPjagl4ZzqSuGCIiuydM+MZCiD8HYTgz+JG4sCj0TYjSBtEjX4SRswb3PlgC1Gxs0Xcg8Q0FI1Zplgx3wHn/QWS01sGzf5MBshama3CHCPAMuI6RmZQclRdP6lXy/VbjIHjJDWMiD51hgXzfgSYpX4geLRscHwNrmmZlO3DZNFad0ecb219t7YWNtGVwVK9drJvMDqiDne+lCreVuuotWcd6YbOMb9BVcs4C76Xem0HQhON4ZWpkiBhs8b9P8uzdxIC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvVuFHTJROWVbhlzzqo+qUY7y97z8qAQmAld3AquM2Y=;
 b=IAKvJpsFfpQrtZXoWAVukmp83ZxPTQ4h7hkEuJt4+EjQv8OSFVXTkKAIRLNkHB8Y22Z9DUbY26PpBn80hP1rHwhPiLXJGAahTL3JoTiTCxxZx/RVjoSTBMgmFaRFZipCdkPD5As2C6fFQPLCIRNRXqQ8AZ90aCzfMyFBnIjBYVt7ADA49CDPTMSkten9eQ5P8mXwqfiIT65P4OmvKnwnD2hfEy8tA7n3jgYNl/kdrB1CFOisl7+S9MsZMy4QFNqzsPg8KXbwMNz+JqFb8B+q8AaRHMrxtHY5xZOajIdElhHNXmFKoKYx4ab5m3/kkG9vRKBiXfug/tLTWKiF9opc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvVuFHTJROWVbhlzzqo+qUY7y97z8qAQmAld3AquM2Y=;
 b=pnniTs1KmN6o2fJYG1Kaj3mRaziVrv66OpnyBxp70u2JCy+y0C5vcoPnh6ETm9/MOrih+XjVgqxJLIt0Vx3+oCl/LN1LgEWNX3PKdFsGQPKOGXtx/Aonr4Qut3YzZBqvaWniiT9oQ+jjulHXRnHMwYboneY2oXb7YlifdA/DMJs=
Received: from BL6PEPF00013DFD.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1d) by DM6PR12MB4372.namprd12.prod.outlook.com
 (2603:10b6:5:2af::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 09:41:05 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2a01:111:f403:c803::2) by BL6PEPF00013DFD.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.24 via Frontend Transport; Thu,
 20 Feb 2025 09:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:41:05 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:40:57 -0600
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
Subject: [RFC PATCH 22/22] [DEBUG] sched/fair: Debug pick_eevdf() returning NULL!
Date: Thu, 20 Feb 2025 09:32:57 +0000
Message-ID: <20250220093257.9380-23-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e09937-1c8d-4255-8d5d-08dd5192b21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zXLIAuh/XE/hNLK4veFHF2IiKQG/5Bxy1Ef30e2s5rOJqmmCXQXu2YkbCnzN?=
 =?us-ascii?Q?GZsuC8I21L3bCc7dIAKdhp8yT7XLhEV3ED/pToqmgY09Nao3oEHbpx8SlXbQ?=
 =?us-ascii?Q?YJ9AkG45oRjx9BplBQJZfZx3svOkdnny/s4UzUDy0g238umrqmx8f1BPkq3D?=
 =?us-ascii?Q?Ts3wDm70t0TbeQ4It6thghzckypM8FFImIB8mSLpEuI91juSFNx5kxTNy0Sw?=
 =?us-ascii?Q?MumuwqtFP9S2Z0wnpVUXoqmWEionGcyW6PHs2U/v/lA6UFCoXHq7+pD0P0Pf?=
 =?us-ascii?Q?yg/pM6DvjpKWOMc851b0S8xG1dzfNggPd8HkPRJWWH+66E0JsQtwgONo5k/k?=
 =?us-ascii?Q?HQRzrWkq+TvkO66IstR96Ctk1Zt/xP5/jDLMi4PrNq80csTDLgAAvrCYlJHV?=
 =?us-ascii?Q?DZvbX/4lGcYNtTJF/mp5oCwZuJv7s4kO4aATk6LFGG96AYHyeieoH3/B5b1Z?=
 =?us-ascii?Q?OjfaFv0X9SOjMmDHSPzcZ3blcmdgj57TsQVhYoVg1I+3IkeclYKqXngQt7ot?=
 =?us-ascii?Q?q7YM5umLrHrKpRMd1sQBDeOmQFbquQkjmuea+9+W2Owx0AOnYyqjoEWA9x2j?=
 =?us-ascii?Q?u5dzPKKRv1dtyvBe+i9R/PqcRId88s97UH3bf8dypzMtG+CdKY/sRUFfwn/2?=
 =?us-ascii?Q?2+kwP2oPSOq58wsYkj/mtr8gI1fHeF4SOLdqnyT7AfflEdI7h7VffzQmKXVh?=
 =?us-ascii?Q?qYq25/qb0TWAI5pztiKsGg0J0OGjCw+GIKC0xKkZH0oEUZjE28qJKP4T3CDC?=
 =?us-ascii?Q?8PAZx7GbI+rQTGeJulSvl6I8v2j05jvyxmxAkP6ThNEMgiGBl30Q8qoNdAql?=
 =?us-ascii?Q?1dO2Ky4C80x0gkBMqFhaGNQl0X7XvJeYSjzPuoJBGMfqKeLJcVD3iXuFaf40?=
 =?us-ascii?Q?dQHSkDso5wy7Vl+dwKjwc2ko74wOjVOytLoTTTGgQ2bndmtvG5aRC1FDREv9?=
 =?us-ascii?Q?jSLvrY86Fr6jw2/aMt2R9fMYwKLGS3Li4WSLxKROqH1Hyuvf3M9UmHVC5+4Q?=
 =?us-ascii?Q?zzDLlx6Qbe8tJcLeQJoj24m21qPTTzytq9sA8Dn89Jjm6WC5TE1tiTV1FIQF?=
 =?us-ascii?Q?IosYtKmFOoD3riy/hMYGdx6zxELtqwcXU9CPU7nnb9Ruyar0dBc53vYBULlY?=
 =?us-ascii?Q?p8PFDpcK7fEziMPkyaukW9WGI2j6D/DlL1q8EYmTse+vmvsOIUal0UXkOxYe?=
 =?us-ascii?Q?Z6IU1Aq03f7QDwDsMybZJOuDcb+8Ymxf87hSvQ27Qc8FmLIoz5XmWkPoTaxD?=
 =?us-ascii?Q?bf11kskCpm8SPvaIpFZhfiez70jz6kpZM8/V/CyH1AXMbfMHhfyQlDQGHu4A?=
 =?us-ascii?Q?6SdNe7qe13JokYbuWZym24FxWyp7JLt/8fFZ4T3QnDDFfb47PbVoJZZ8tKdh?=
 =?us-ascii?Q?+khRf2jTIfCsa2XvJU+QjhpbtAFei3J+r27kQHr60tp13pzmEZftO1K9nbWd?=
 =?us-ascii?Q?pByMxf95f4WbhJWBFhRsslsV+5F8cowUQHh5IIDQa+t88hO+WanCFPv4QZuK?=
 =?us-ascii?Q?1EgClHHdoG0U6DM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:41:05.1300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e09937-1c8d-4255-8d5d-08dd5192b21c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372

Dump the stats of cfs_rq and the entities queued on it when pick_eevdf()
fails to find a runnable entity. Take the panic that follows since this
scenario implies breakdown of the scheduling algorithm.

XXX: This will only build with CONFIG_CFS_BANDWIDTH enabled.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 97566a043398..270e5f4b2741 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5610,6 +5610,78 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
 
+static void debug_print_se(int cpu, struct sched_entity *se, bool h_throttled)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	pr_warn("CPU%d: se: load(%lu) vruntime(%lld) entity_key(%lld) deadline(%lld) min_vruntime(%lld) on_rq(%d)\n", cpu, scale_load_down(se->load.weight), se->vruntime, entity_key(cfs_rq, se), se->deadline, se->min.vruntime, se->on_rq);
+	pr_warn("CPU%d: se kcs: kernel_cs_count(%d) min_kcs_vruntime(%lld) pick_entity(%d)\n", cpu, se->kernel_cs_count, se->min.kcs_vruntime, pick_entity(cfs_rq, se, h_throttled));
+}
+
+static void debug_print_cfs_rq(int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se, bool h_throttled)
+{
+	pr_warn("CPU%d: ----- cfs_rq ----\n", cpu);
+	pr_warn("CPU%d: cfs_rq: throttled?(%d) cfs_rq->throttled(%d) h_nr_queued(%d) h_nr_runnable(%d) nr_queued(%d) gse->kernel_cs_count(%d)\n", cpu, h_throttled, cfs_rq->throttled, cfs_rq->h_nr_queued, cfs_rq->h_nr_runnable, cfs_rq->nr_queued, (se)? se->kernel_cs_count: -1);
+	pr_warn("CPU%d: cfs_rq EEVDF: avg_vruntime(%lld) avg_load(%lld) avg_kcs_vruntime(%lld) avg_kcs_load(%lld) \n", cpu, cfs_rq->avg_vruntime, cfs_rq->avg_load, cfs_rq->avg_kcs_vruntime, cfs_rq->avg_kcs_load);
+
+	if (cfs_rq->curr) {
+		pr_warn("CPU%d: ----- cfs_rq->curr ----\n", cpu);
+		debug_print_se(cpu, cfs_rq->curr, h_throttled);
+	}
+	pr_warn("CPU%d: ----- cfs_rq done ----\n", cpu);
+}
+
+static void debug_recursive(int cpu, struct rb_node *node, bool h_throttled)
+{
+	debug_print_se(cpu, __node_2_se(node), h_throttled);
+
+	if (node->rb_left) {
+		pr_warn("CPU%d: ----- Left Subtree ----\n", cpu);
+		debug_recursive(cpu, node->rb_left, h_throttled);
+		pr_warn("CPU%d: ----- Left Subtree Done ----\n", cpu);
+	}
+
+	if (node->rb_right) {
+		pr_warn("CPU%d: ----- Right Subtree ----\n", cpu);
+		debug_recursive(cpu, node->rb_right, h_throttled);
+		pr_warn("CPU%d: ----- Right Subtree Done ----\n", cpu);
+	}
+}
+
+static void debug_pick_next_entity(struct cfs_rq *cfs_rq, bool h_throttled)
+{
+	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
+	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct task_struct *p = rq_of(cfs_rq)->curr;
+	int cpu = smp_processor_id();
+
+	if (p) {
+		pr_warn("CPU%d: ----- current task ----\n", cpu);
+		pr_warn("CPU%d: pid(%d) comm(%s) task_cpu(%d) task_on_rq_queued(%d) task_on_rq_migrating(%d) normal_policy(%d) idle_policy(%d)\n", cpu, p->pid, p->comm, task_cpu(p), task_on_rq_queued(p), task_on_rq_migrating(p), normal_policy(p->policy), idle_policy(p->policy));
+		pr_warn("CPU%d: ----- current task done ----\n", cpu);
+	}
+
+	debug_print_cfs_rq(cpu, cfs_rq, se, h_throttled);
+
+	if (node) {
+		pr_warn("CPU%d: ----- rbtree traversal: root ----\n", cpu);
+		debug_recursive(cpu, node, h_throttled);
+		pr_warn("CPU%d: ----- rbtree done ----\n", cpu);
+	}
+
+	cfs_rq = cfs_rq_of(se);
+	se = parent_entity(se);
+
+	for_each_sched_entity(se) {
+		pr_warn("CPU%d: ----- parent cfs_rq ----\n", cpu);
+		debug_print_cfs_rq(cpu, cfs_rq, se, h_throttled);
+
+		cfs_rq = cfs_rq_of(se);
+	}
+
+	debug_print_cfs_rq(cpu, cfs_rq, NULL, false);
+}
+
 /*
  * Pick the next process, keeping these things in mind, in this order:
  * 1) keep things fair between processes/task groups
@@ -5633,6 +5705,9 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq, bool h_throttled)
 	}
 
 	se = pick_eevdf(cfs_rq, h_throttled);
+	if (!se)
+		debug_pick_next_entity(cfs_rq, h_throttled);
+
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		/*
-- 
2.43.0

