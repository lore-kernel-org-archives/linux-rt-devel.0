Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89E1EE032
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044114; cv=fail; b=EbVvrRYFALzDMx0ufMZJM2fT94VZKYEsCGz6rCUOEFn1zvZDZ1XZOByr+8ZAR0ytOUnGSLKHWlTTHrUkuDY0RRMic/WkrxSM7VVC4sPRepzeG/WhWr/eMHATcvMFgLqQYXo6bwEp19bw3dvh1a1aA4OSoU7OuPgo740rB5GCV2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044114; c=relaxed/simple;
	bh=5Ax0oXVg4YtlxWii2Fu6KwnGPqUqITcXJuiS6WlNDOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5MOc5xuGftQPOsAXgvOlzzvLNgVHdMMpCvaDi3UJ2BL0HyaEZJKu9Rs9DIRkXylyPzbb3YtgfpOLSNuiYaCyyEy9UUq+kFTEbkBcRuV4WrAC9Oq0PTZ5GC0dhhRsv7KPd7uuW2jaBypYsCGVcjwW8IOg0Svy7CBUemU0evzwNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PJ5//6gp; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PJ5//6gp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umrfExN8wrkpTknAByMCCpnk/B2mC3GeYqOyRULRzX5AJfZ9MdfFafAP/tlEtTY/K7D7I1E16pdHGAih9eghWVS9GFJCJzPlBSMbnPGuchjkNsxHdYGWJ45kYjX48DIsHDeaWDIBw7/B4syIS7/QIsD1uDTW9qg/fTb6eObbCmNbnXdYFTXf1prnS+IknrqyXA68qbfYeK9MHa42yQ6Jei4XcrjtjtPt5eDYVk/AOwilXWFggsaqe9edguHTgvAqxdWbVbFoj+KC5C3pGef0xfizsQQ7Ht/xVszR5+pDBo1wwazMJ3nn4bVkdE4WNdh8Ap8Ha78HPWB38XNBUzI0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93U530oj7EinGA8waDM6NqWD74Bp8HhoLE/SJzu35Vs=;
 b=pEicvJHhy75H8TIPHlTp2eybZbZIQZwK/BMK/g/8ji1QaISKTDUrgg45C7iok0kIxq8Q2en2mzQtvoOA16qEy+FK89IIlGeUQ5Gck4oE7dD8sWIY/rm8C/etS5bCVveZ4Hs+uSX846Ud74ZJcKAOkeefk8pqBSAKTbU9s6/MYttZn5xh+AZkquxI5pDV+HT1hY2polx1LFmzxtPnAU337Vwz/ctrgLFZczg5F0nE9Pou7M0ge9ukE3EhMlMnKGy7I1XJuHiBUOYBu0P8isUsf/PuU8mA0kyJ0n5koV/cD7d9b0AfUiD2jY5COmAC4zy0a82o9FC32l2ckR9X4dh7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93U530oj7EinGA8waDM6NqWD74Bp8HhoLE/SJzu35Vs=;
 b=PJ5//6gpM8Yhg4UtKIZz35c3m84pvLq0Zni6sHDNibCrd8e7X8ItD+AvdeRMxvQSMK+eAVYBXXsXD+wKxPG2709FhxD9oIcxe8XHVOQw4qlu8F6FPxDwMSlnJDyKWldQ6v3ez4KvhMWlDC7xlvONKHYqpqGTeEhJA0MEYmhMOPM=
Received: from CH2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:610:4d::26)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 09:35:09 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::ed) by CH2PR19CA0016.outlook.office365.com
 (2603:10b6:610:4d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 09:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:35:08 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:35:00 -0600
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
Subject: [RFC PATCH 05/22] sched/fair: Track EEVDF stats for entities preempted in kernel mode
Date: Thu, 20 Feb 2025 09:32:40 +0000
Message-ID: <20250220093257.9380-6-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 701cbfb9-f947-490b-9754-08dd5191ddbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9sVtrYVW0FP+j+WwVFd0Du4YmmvcqhUQck3rXy3IPkbEDKZVc9mJsffNtFR0?=
 =?us-ascii?Q?Zg5L7Wv1pyQwpO+WqPC63eluIB+pACsYNDoAaRe6Q9Rlg8lOAnKXJlnXRjxa?=
 =?us-ascii?Q?GFIsmYXAVYH7+jbnuNd/fTbNsj9H8daMaMAJaI//xiPp8C2jlhPqWXWWuODb?=
 =?us-ascii?Q?4x15KJzRJ2irdE/jRqvtOrCv1aAXJu0KOFajKnaB7GX2CkTJ5ycKOnpp/GRv?=
 =?us-ascii?Q?uWcfJh/fQOkvJV4/DrEKjM8Zts2jFkzJ2QZoGOQYn5HJd2QrHA7vDBveg3KE?=
 =?us-ascii?Q?NxJ4aT8VHHodTXWgZOrsD9bAJhG7TMH032fZUY2CL7vtW25f2MQdQLRtO9un?=
 =?us-ascii?Q?V6J8dPLugmucePzRlNj2llI0iqjosTAfzSGOQiVuoBlTMyYNYAkM83AymPMA?=
 =?us-ascii?Q?JHkmlu7Q4PCTDsezEaw5OPpFtBsGdP5kvHLRwulybwuZySZQE88HrSnz4/rD?=
 =?us-ascii?Q?5TWuLlp0Q1+FtXF1WnDxxzWz0aArB301rxX5Zs8EqpprF7hGsag4pviD+wOA?=
 =?us-ascii?Q?9UlNmyI7deZJDZonVkBhOi8x9z+ad9LkwyCZipnBxdXyD7TsGsDPDwtrKGku?=
 =?us-ascii?Q?1ZpyqBylM8Iabqi7uI/auhGsRHCv8ymcHBPtSex3OC7rKHweDJGf2r6zFbAS?=
 =?us-ascii?Q?7zbm3fMPMUrsZrQFLAi+hqflgf6KqjSD0TQG5zGp5Hup3179J2l3U0sfrfrs?=
 =?us-ascii?Q?SCF+spS68ArkAAp86QRgkvZZ+DtWT/S4pideamzPWYGvIeCuoqMwyh50GL/r?=
 =?us-ascii?Q?LxEK2ZLy5cy3+6tFaP2qWSFWqZcHaBtQk7paThfyzP4Qq4ItJsj2MpPL+27m?=
 =?us-ascii?Q?4+oejUtTVzl0p0KGxNwM3KvAtWaTFmWjUdbAm8pHOm28qlsi/Y30zFRejjsI?=
 =?us-ascii?Q?0V96Gmy3NI9X0NbcPxKrDagd5qAdCl6uWRWg/O1H6Ca//fcwDbZS8FOBTa9Q?=
 =?us-ascii?Q?4NZ2fmiA2WdwC5WT/72LTGMoxWRVIce8o1/SzBD3S58c6jgw31OaV7O1vGN1?=
 =?us-ascii?Q?HpXxB1LZ9qaB9BL9Rs9HxS1w38kGrp6cNNjB4bHqgNro4Ca8hoqZGcN7+xTu?=
 =?us-ascii?Q?7SETHgGXQmGqLYV8Tcj70Mo8r+HLr4CvN59ssn2yiNHBoaCha2oA941SPzhf?=
 =?us-ascii?Q?6oS3Z375rCGDdd2FPZt5wrVoKRgafZxQNXneUIDqc7NfOfkBu7hp9siXRzqK?=
 =?us-ascii?Q?h0zou65ANDRg1jwZcJFulAKa9HyX2ckAQeyrS5e/9A4mkJxCqLIWvbMp/K0+?=
 =?us-ascii?Q?I0xcb1bGb/yxiu7UGNDZBifIB9vQinqtJ2ciep2brI1FeVdRQ/oge0DJMAfx?=
 =?us-ascii?Q?Zjgq/JL6uvgoR2xqNGtMVhNiqEswQGc8mxzskvjrDrjCXRMnt/cWh26WWKYq?=
 =?us-ascii?Q?cMdSulV0F+V+YkQ2MOIFOGfJWne2zpkwqUrp1WuagescmxXp0oAXsPOpluUx?=
 =?us-ascii?Q?MP9Bs+RUPfa3adtCTnh7A6oM1NYy7kx0yJTtXqfZYD0M8hTAZ+6VrA4ZOP+v?=
 =?us-ascii?Q?hQ13TU26hklF/IA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:35:08.7904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 701cbfb9-f947-490b-9754-08dd5191ddbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135

Throttled hierarchies will require only picking between kernel mode
preempted entities queued on them with throttle deferral.

Track EEVDF stats of kernel mode preempted entities in avg_kcs_vruntime
and avg_kcs_load which is the same as avg_vruntime and avg_load
respectively, but only contains stats for kernel mode preempted entities
queued on the rbtree.

Since all the checks for eligibility are entity_key() based, also update
avg_kcs_vruntime when min_vruntime of the cfs_rq changes.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 +++++
 2 files changed, 68 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index becf2d35f35a..cbb7a227afe7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -523,6 +523,9 @@ static int se_is_idle(struct sched_entity *se)
 
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
+static __always_inline void avg_kcs_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se);
+static __always_inline void avg_kcs_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se);
+static __always_inline void avg_kcs_vruntime_update(struct cfs_rq *cfs_rq, s64 delta);
 
 /**************************************************************
  * Scheduling class tree data structure manipulation methods:
@@ -630,6 +633,7 @@ avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 	cfs_rq->avg_vruntime += key * weight;
 	cfs_rq->avg_load += weight;
+	avg_kcs_vruntime_add(cfs_rq, se);
 }
 
 static void
@@ -640,6 +644,7 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 	cfs_rq->avg_vruntime -= key * weight;
 	cfs_rq->avg_load -= weight;
+	avg_kcs_vruntime_sub(cfs_rq, se);
 }
 
 static inline
@@ -649,6 +654,7 @@ void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
 	 * v' = v + d ==> avg_vruntime' = avg_runtime - d*avg_load
 	 */
 	cfs_rq->avg_vruntime -= cfs_rq->avg_load * delta;
+	avg_kcs_vruntime_update(cfs_rq, delta);
 }
 
 /*
@@ -6720,6 +6726,58 @@ __always_inline void sched_notify_critical_section_exit(void)
 	current->se.kernel_cs_count--;
 }
 
+static inline int se_in_kernel(struct sched_entity *se)
+{
+	return se->kernel_cs_count;
+}
+
+/*
+ * Same as avg_vruntime_add() except avg_kcs_vruntime_add() only adjusts the avg_kcs_vruntime
+ * and avg_kcs_load of kernel mode preempted entity when it joins the rbtree.
+ */
+static __always_inline void avg_kcs_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long weight;
+	s64 key;
+
+	if (!se_in_kernel(se))
+		return;
+
+	weight = scale_load_down(se->load.weight);
+	key = entity_key(cfs_rq, se);
+
+	cfs_rq->avg_kcs_vruntime += key * weight;
+	cfs_rq->avg_kcs_load += weight;
+}
+
+/*
+ * Same as avg_vruntime_sub() except avg_kcs_vruntime_sub() only adjusts the avg_kcs_vruntime
+ * and avg_kcs_load of kernel mode preempted entity when it leaves the rbtree.
+ */
+static __always_inline void avg_kcs_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long weight;
+	s64 key;
+
+	if (!se_in_kernel(se))
+		return;
+
+	weight = scale_load_down(se->load.weight);
+	key = entity_key(cfs_rq, se);
+
+	cfs_rq->avg_kcs_vruntime -= key * weight;
+	cfs_rq->avg_kcs_load -= weight;
+}
+
+/*
+ * Same as avg_vruntime_update() except it adjusts avg_kcs_vruntime based on avg_kcs_load
+ * when min_vruntime of the cfs_rq changes.
+ */
+static __always_inline void avg_kcs_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
+{
+	cfs_rq->avg_kcs_vruntime -= cfs_rq->avg_kcs_load * delta;
+}
+
 #ifdef CONFIG_NO_HZ_FULL
 /* called from pick_next_task_fair() */
 static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
@@ -6792,6 +6850,10 @@ bool cfs_task_bw_constrained(struct task_struct *p)
 __always_inline void sched_notify_critical_section_entry(void) {}
 __always_inline void sched_notify_critical_section_exit(void) {}
 
+static __always_inline void avg_kcs_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
+static __always_inline void avg_kcs_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
+static __always_inline void avg_kcs_vruntime_update(struct cfs_rq *cfs_rq, s64 delta) {}
+
 #endif /* CONFIG_CFS_BANDWIDTH */
 
 #if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ab16d3d0e51c..22567d236f82 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -658,6 +658,12 @@ struct cfs_rq {
 	s64			avg_vruntime;
 	u64			avg_load;
 
+#ifdef CONFIG_CFS_BANDWIDTH
+	/* EEVDF stats of entities preempted in kernel mode */
+	s64			avg_kcs_vruntime;
+	u64			avg_kcs_load;
+#endif
+
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
-- 
2.43.0

