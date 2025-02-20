Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BBF1EE019
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044135; cv=fail; b=RLtHusJwdf6Z2rW8glntB7zPr60pt3ADFaut2CMd7G1A4/VO/OY0pdRCC8OuJpfTojcCbrpNAC5TudIeJSO7s3HfCURMbEONt1wRgNrHZzgJbeTJBnGW/2xNeLQV641wqplbBQq6vkNqZEooqYXJc5y//GO6RgscJwD2mifKIac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044135; c=relaxed/simple;
	bh=GCFiVpZ/z4C+JvopM7kOFTVVu+xLGhSyVX+GUz4m2OM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIaqxY/06/hTqLtO3/nImABHje+/GK/ZX1KLSAOy14vq7d18bYOSJCZSu93d7g3l9zoQwSl9dQ96nFu385sIUHHHnJTCuSzUHbumkEuTTW4Tlff0hPVld+TGbjieQp7JkqJHfuaRCSkE4UyqVG7W7qC4Q+9mPizwP25gztG30Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QhXceTQ6; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QhXceTQ6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOXkZn/SHjhpTNvk/9Wv2fYUPnALhhwPlzIIK3KiwveVQS9bMvHxsn5xp9Ohxk2MlbGr0SS9na+fmtXOS9azH751/tcxMzbLShhH2fexMPY7Nsou8yXzcl3LTme36so0ns5j1TruVtrv8apooxuLDDYJMh8ExiMNdWrOJSwdK/gikIX0FAoCd9H6l3qHTPFQQmDOZDI0+IlWQzZk8+aLCl7q08dNA2wvjWY7sX6rtaTvL/moHsZcceAAUEP/gBEf11lmGI0Ai+P49KxLkU2l4Ri+1Bf7MRZI5ej2Dan8gPA4Yt6fIj6Q98c1aJ0XJUaFzmgglvEx3p/2lfqExLlNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0T1MRunkRoyKdShMPDMeq1UnsU+Q8JfvCgI6ycNwe4=;
 b=rXCIXE6/2nyA9aZVPC3umNAT+jP2oStzpEPNhIhnaheXmvyCTyJlehyjwYMRWbFJabOiItjaFxlsbjbFsR6/68Dgk+D7Ic8PAG7+D1Vw/EZODDMcmoUud9K7Sxo2kk2wmmpFuRZarxFWKVcVDvxlqrfNqOniR5rTp9F9wjI+CbG6eg5LV8BdTjnqAckDIm/BXfJrPgTLlow1yV+XOSpYzRc5TLb6+xMs1oimAxfu84qoJuxyz0+NlnMIHwzf2Avsm90tgSsZO/8KllYZGmNOQASVYhTxT+S1JYfMGjLJ/HUIec9eCW2QFJAPigE6YDGR4Oi3ksQOqBX3azSPDP5X7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0T1MRunkRoyKdShMPDMeq1UnsU+Q8JfvCgI6ycNwe4=;
 b=QhXceTQ628XGHrAylEnoZGYx8Tu8VT94RJ7MGR6sRCAc3nvPdEWZjF/jxf9gZBWvphTQq3VfJX34hnsVHh6ZjhauuhWEpTzo7IBrsQc7eKdYKvahxu63EYUCysAY0KJUZJBBFLhlYK1G4ALIDlmOhzc/kWHM5ZlwrY3clFqEZ7I=
Received: from DS0PR17CA0015.namprd17.prod.outlook.com (2603:10b6:8:191::23)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 09:35:30 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::3b) by DS0PR17CA0015.outlook.office365.com
 (2603:10b6:8:191::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 09:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:35:30 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:35:21 -0600
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
Subject: [RFC PATCH 06/22] sched/fair: Propagate the min_vruntime of kernel mode preempted entity
Date: Thu, 20 Feb 2025 09:32:41 +0000
Message-ID: <20250220093257.9380-7-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: 21dfb24f-206d-4044-e499-08dd5191eab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SS5tJfmnCMPcbmV8LZFbJRSLhSSpMCYHzwofrfgbZ7LP2ZE+ZbYrErH4/brY?=
 =?us-ascii?Q?CLsFAp6MKTt9RorVJQpmDMqnf9i97gaiw5AtQc7ovVKDQSPal7YBQPzWpyeP?=
 =?us-ascii?Q?sJGDgpH/7wAAEbgXDcxPm302yYAPFFWgYlQutCM9QjXJRY5LQQMTlWLAdNF5?=
 =?us-ascii?Q?QJ4++3vWZTGBpiRxFfDGreez+kpxzE+uTcDwIeycoUTyf+1PRSmYurW0azDE?=
 =?us-ascii?Q?EinITQOBg37D1JauRIochMWsSXtbGCn8yeak10m1U75HPJmU3KzRCxfYWyhF?=
 =?us-ascii?Q?ypwB7AmTURUZvk/i/8HKFFcyrhY4xom74cHZkriltCRE5cA4HeTqLJfz6VTZ?=
 =?us-ascii?Q?mdDNd/B7NTAXPh6adw1CvCr+jXtMFLCOF5ujrlwDXjb5wZe2oB7KMS1l5wC3?=
 =?us-ascii?Q?4dQ0MJ+aP+bmo3nFsGHkaLdFNYkOBAZPnYN/MX2K8wYJAniSvUVTDBQiuF0E?=
 =?us-ascii?Q?8mjYsdAjP6TtZXCj0sb3oSeccWeE2RVfi/m7Ewxha23zKpjDYwAjcCiW8L70?=
 =?us-ascii?Q?WlRlfoSMlZIlRJPlrF7FU4yOUnnvTuzJSnzJFLBKyiOmFzrT+HHk4BiTIVuL?=
 =?us-ascii?Q?LA0DeL5DJgR78NulFKJGN98JSRKySBHUvfn53ETr2LfQSp8erjcFbz2jRxjN?=
 =?us-ascii?Q?wzqRUVjaNjYdmSwjeVHa0/LN8cs9k8irOVpMSblJYjQB92st+sYLtozI1sqG?=
 =?us-ascii?Q?GzFaempYbuTn/17GrYDM9WIabsIMRoSlk8fZTn/rnbSG0QUMnveMOX/YQyeb?=
 =?us-ascii?Q?wsXQbMTB5ZrbcOvnSFNOyiBe1yz8j9CINpugOrge/vWZDrzFlM8AtFols7uJ?=
 =?us-ascii?Q?Nmohxm9sZ2cEu7gjkWDBG2pww1UlgLWqsPbR7woWeKmbZolflFkiYL90sMI7?=
 =?us-ascii?Q?KHncjbnIpUj3lUIxsJs/6UAKAHCA77lanz9qX178/QLL08t9tVlRJmb4AIXq?=
 =?us-ascii?Q?iTA8t4ACHC/J0FDoFRC43qDou9MpdCH3KXGD5MWMImukmNfjlwMaQvV1mBt8?=
 =?us-ascii?Q?N4IHLj/qzu9JVVnvf1h7lG80ffQ1kB512MDmf2Zt0J5zMKZU7oYKSac6shUG?=
 =?us-ascii?Q?1gJXLp2phHjfqmBR2e3dO2PNFdCNwZYFn1IFynpzypheEGOPoGXNOetSRqIc?=
 =?us-ascii?Q?dNuW+LM5ynecPvOc7kjCgeu+9shoViR8HFmBAdbhpnQU6B7QQ/B8k6UBCp2Y?=
 =?us-ascii?Q?FjX996JUmCnNtJdpy0LaGdmU+ZjVLGL2l2rnVfn9Exr9usb16vNP9shn311Q?=
 =?us-ascii?Q?MmV3hiqiq5kOWdGnPz/9X6abEGTqhbpDtS17h5LT28OgsLLDbDWLClJqW480?=
 =?us-ascii?Q?pQTv4wmUoF9U09XLAQ3A4TvZUMw8DEUsuTgY17QsIE1CVdJ3zD0rfy2cyZKV?=
 =?us-ascii?Q?urIhpISdeB5kJIblgl7v24pKlbh3MiQEmZFpk48leFlQNWk6wUfJKIlRW3g4?=
 =?us-ascii?Q?VyTYHKOO0+7295vVkRQUxavqub/RqajB7lW99sMfsAf199krUyylgI3VzGZS?=
 =?us-ascii?Q?TzUxHznHPKG8Nc4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:35:30.5856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dfb24f-206d-4044-e499-08dd5191eab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF

Propagate the min_vruntime of the kernel mode preempted entity to the
root of the cfs_rq's rbtree. This will be soon used to pick amongst the
kernel mode entities on a throttled hierarchy using the similar min-heap
approach that pick_eevdf() currently implements.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h |  6 ++++++
 kernel/sched/fair.c   | 47 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63f3f235a5c1..4bb7e45758f4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -593,6 +593,12 @@ struct sched_entity {
 	 */
 	int				kernel_cs_count;
 					/* hole */
+
+	/*
+	 * min_vruntime of the kernel mode preempted entities
+	 * in the subtree of this sched entity.
+	 */
+	s64				min_kcs_vruntime;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cbb7a227afe7..ba1bd60ce433 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -828,6 +828,9 @@ static inline void __min_slice_update(struct sched_entity *se, struct rb_node *n
 	}
 }
 
+static __always_inline void init_se_kcs_stats(struct sched_entity *se);
+static inline bool min_kcs_vruntime_update(struct sched_entity *se);
+
 /*
  * se->min_vruntime = min(se->vruntime, {left,right}->min_vruntime)
  */
@@ -836,6 +839,7 @@ static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
 	u64 old_min_vruntime = se->min_vruntime;
 	u64 old_min_slice = se->min_slice;
 	struct rb_node *node = &se->run_node;
+	bool kcs_stats_unchanged = min_kcs_vruntime_update(se);
 
 	se->min_vruntime = se->vruntime;
 	__min_vruntime_update(se, node->rb_right);
@@ -846,7 +850,8 @@ static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
 	__min_slice_update(se, node->rb_left);
 
 	return se->min_vruntime == old_min_vruntime &&
-	       se->min_slice == old_min_slice;
+	       se->min_slice == old_min_slice &&
+	       kcs_stats_unchanged;
 }
 
 RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
@@ -858,6 +863,7 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
+	init_se_kcs_stats(se);
 	se->min_vruntime = se->vruntime;
 	se->min_slice = se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
@@ -6778,6 +6784,39 @@ static __always_inline void avg_kcs_vruntime_update(struct cfs_rq *cfs_rq, s64 d
 	cfs_rq->avg_kcs_vruntime -= cfs_rq->avg_kcs_load * delta;
 }
 
+static __always_inline void init_se_kcs_stats(struct sched_entity *se)
+{
+	/*
+	 * With the introduction of EEVDF, the vruntime of entities can go negative when
+	 * a lagging entity joins a runqueue with avg_vruntime < vlag. Use LLONG_MAX as
+	 * the upper bound to differentiate the case where no kernel mode preempted
+	 * entities are queued on the subtree.
+	 */
+	se->min_kcs_vruntime = (se_in_kernel(se)) ? se->vruntime : LLONG_MAX;
+}
+
+static inline void __min_kcs_vruntime_update(struct sched_entity *se, struct rb_node *node)
+{
+	if (node) {
+		struct sched_entity *rse = __node_2_se(node);
+
+		if (rse->min_kcs_vruntime < se->min_kcs_vruntime)
+			se->min_kcs_vruntime = rse->min_kcs_vruntime;
+	}
+}
+
+static inline bool min_kcs_vruntime_update(struct sched_entity *se)
+{
+	u64 old_min_kcs_vruntime = se->min_kcs_vruntime;
+	struct rb_node *node = &se->run_node;
+
+	init_se_kcs_stats(se);
+	__min_kcs_vruntime_update(se, node->rb_right);
+	__min_kcs_vruntime_update(se, node->rb_left);
+
+	return se->min_kcs_vruntime == old_min_kcs_vruntime;
+}
+
 #ifdef CONFIG_NO_HZ_FULL
 /* called from pick_next_task_fair() */
 static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
@@ -6853,6 +6892,12 @@ __always_inline void sched_notify_critical_section_exit(void) {}
 static __always_inline void avg_kcs_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static __always_inline void avg_kcs_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static __always_inline void avg_kcs_vruntime_update(struct cfs_rq *cfs_rq, s64 delta) {}
+static __always_inline void init_se_kcs_stats(struct sched_entity *se) {}
+
+static inline bool min_kcs_vruntime_update(struct sched_entity *se)
+{
+	return true;
+}
 
 #endif /* CONFIG_CFS_BANDWIDTH */
 
-- 
2.43.0

