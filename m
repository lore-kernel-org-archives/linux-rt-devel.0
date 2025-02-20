Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25821EE032
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044348; cv=fail; b=W6S0n7TKD5HLbW3ccsaLpsz/KybSsYlPU/2CkIYpizyswt09Zcl+9eNn2x1GfMcjA0Qu2FOX5YBcHQQczTwNT3RqgQBfcatCru2BZVkeWMVD5Qf4DBP/TSMyvpnGYbU0NYduJImYAjpM3vhUnVvZs67T59e1EmI9GSjGWlOIvXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044348; c=relaxed/simple;
	bh=2JsbmonhzJebd+yJNYZDQ4SlblGVT7Wq0RF80rcD48U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaRbfcfOE8kcbOBK7S45PCsK8o6r+9zSGNiywwG+Ggi60e0wFPqXsZYxmtCBj2R94kis23y70AVULMaNqG9E8Qmvjwlk1nnQhl8AYr9dfTaFPit8/7sfm8vrkniMPuGmp7Rbxkb5CHEFvTxOPGzNrGFi745nGw2ik4gxWqCgvR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZAhFHFLI; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZAhFHFLI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BagdjJeWYxehshpho/ZCUU1ve/5w9sKn90wVhKCjEqGHu1Jy97uWyiWjftZrSx9nt7po/eTrExEuZrTNqQCET3IKh6yhBXskWL8Zs1Ul3z4eeQRN7EUZVCPiiajIVunPbmHhkexC30RaQmU43DAttXbnvDc7/vzLJ+GVw/i/DnR3KRgAlnVM4ppLmg8q7RRMq4khzH/blLNeoFU1FR5k3/Xhudf2/94FvFXpHm5qR8tXNUohes18BItP7Tb3Gp2rTEW9pGG9NkblCG3Q6yhlYVyvvKhcS6esoaFAwKiCPb9eQCxXVJZGg9/GNndoDZfkjROxxrsRXUKM8ItOQuIeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1UqyyqS99cOtGpEyaC22+Cd0Yn9s3uScy+YAJ1jqz8=;
 b=oZQRreDIx0fApnKWA/bARAje6jq3svlpPi0O4Wa9x4yWkrNk+GET0JtJrOhrTzJireGhPiBhElJMNdp6o4gFApsCmxHJr1cW5oQJwpjP9nSnve9I+gZraYwTWsRwm1z9p1WLRbEKIEfkhkv0ZSMP+7h2dKkENn/CuwzYKxMfdL7MadBpSHOh45kHnLH8X4cCKmTgl5V4adV71cT+J77UEWglLFzSRiGi8pxQ3eR1r1CmNAHjoCkFqg95l/IWN6iMea+wmmBirUNXyKifwr+V8TE2Q/1tWR83SIGe1hmM9TypF50D8mwzbBjc0rc4BNhy0dsaKfIuXCKZjw3E+hZkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1UqyyqS99cOtGpEyaC22+Cd0Yn9s3uScy+YAJ1jqz8=;
 b=ZAhFHFLISDF7RjAg3a2jQnksRtoA6Cmsa+fyjmmtBkBEJT77siKaOHMW+PCl3Plf6BX5eMp0YQpAp0HBgizKotuwDUawud89DaHYNUXQ504ney2hYMp2llUZ+eDA8sbhsVaY7J38px9XGKSvxDNbQ1IefJz6Jx/EZV/0I0A4Owc=
Received: from BN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:408:ee::25)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 09:39:00 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::fa) by BN0PR04CA0020.outlook.office365.com
 (2603:10b6:408:ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 09:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:39:00 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:38:52 -0600
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
Subject: [RFC PATCH 16/22] sched/fair: Prepare enqueue to partially unthrottle cfs_rq
Date: Thu, 20 Feb 2025 09:32:51 +0000
Message-ID: <20250220093257.9380-17-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 63693129-f655-4846-99b6-08dd5192678b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w5q/n6RJdzrNDYwUY5GkLYSSQizF4bII2L5V2jEROW1oCsolW9RTXkeQLdAo?=
 =?us-ascii?Q?+JvQpxl8Dlf1Y43uFim2IZsUlwQE3TykHt5qyyfEeYTJ72uMsz6OJrlDhv3R?=
 =?us-ascii?Q?piFEi1OC/E4i12UBmqAcBBlc7QfLaGLaOzBKkA15p9JgDzc6fmtBC4izGDFZ?=
 =?us-ascii?Q?xVme2qfF/huzh0KQvT0Iw/fDDc3UsAfoyC286IotKrxvKjBH3I553nChQt4L?=
 =?us-ascii?Q?dhe1PptoFqG/ELw81ZsRzL8rkXZNaMiuOz2oKyItkMe0gXPTD7f7TaMLERcd?=
 =?us-ascii?Q?t4XdWECyAj/xavGn3UkaafsmOJZ00BjtbgV2MCURw1Hury9ZJ2D4gHo+APdO?=
 =?us-ascii?Q?b0oPXG1IsxeTz7unRW9pyuG6Afhqn5UEN1M411ulcKLfmOhgKUMffFy19rv7?=
 =?us-ascii?Q?VIJcPaOg2zNTUBrtMRabp6qFKGXy6sGcDwi2sHE/Z6n7StKsH8XI3FdaTg67?=
 =?us-ascii?Q?5zev1A364X7NjtcFIJL3rhbNS19zXdiU7sqHO3ixlMWIDH/d/gOtlXY1Gamv?=
 =?us-ascii?Q?yg0G0L1TeA7QqBewHMxwA83r6yRg2W5LvD05eJdrdJk2ere8fIah8lkrpj0G?=
 =?us-ascii?Q?MIPFnbCDnIHlgozTaOQqLsLRB6I8L6NZTk0kUAR8CRRRo6QpeYNO0+hUEy37?=
 =?us-ascii?Q?rPhglEMgTvypM2DnTPaGw4EwQeb83T/O0yvU4mSw53LfDJ9rPmhCLJpVlOlj?=
 =?us-ascii?Q?Hr60Mf/2Q1rfkM/lC0qAasNCbcVFTzSanlSO6e1bA1bUM+534FJ5X8cE2kI9?=
 =?us-ascii?Q?vBIGEzSW5WgD3v24p6yJuGHpvN1lsulEq22bc3uJ+/O7iwCfcTrESBQCXqrw?=
 =?us-ascii?Q?GuQQmzTHv+mvCPODlkBBa2sBkoU22PVth0BZnW/2M5AFHHNkMfkNPWrcE2kW?=
 =?us-ascii?Q?PSDlVA4Z6DoTk67W6sX85ZNdBjYRkIN51aS3lQllhdsrrEMVvRs/cZhqy8eT?=
 =?us-ascii?Q?SL8IbtFVqTFAOkfUJr8jTRk1ZtDkZLlr12/LBLi+XqbmZz9XZiok153n7/M+?=
 =?us-ascii?Q?8fkDXm41/iki3ea1t7/2N03B5ZqN16YzNRgQHlxJMIyXfYajDaKI0dlejSYz?=
 =?us-ascii?Q?QyZ6jj6GIEGxW8mwPs9djOuFTuQ6buGsPSNIss1CkILDLG3OUpJsEG21Gkbu?=
 =?us-ascii?Q?zwv1RqlelL+6QMZmWFdHDoK+xeRuPCjWYltfghl/HDGXJRgn32IbmVB/OUfJ?=
 =?us-ascii?Q?q6KBPFvq04kk1wkkH55xuDNZgrUucxu1YvZiXY776c728gAdGl9AssMEfxke?=
 =?us-ascii?Q?MLFxDFSvBXtjnKxRZ4se8qQ8K7/TTNCzwh1a0M4ngAU4Kjp6yRG/8q9yw3fo?=
 =?us-ascii?Q?sxsrt7ZfIPNhxlKbLB2+iXafxpEYO150HFUBHVhFWW0kL+/cVX+db6EF0kVo?=
 =?us-ascii?Q?L7ts8KeYkuM7D7Pixay9z2rw0IiqEbZBObSZpKGMIUs1cTU1INVHVupl14v6?=
 =?us-ascii?Q?kk4j9uzzmuaycenvX6H4iIMAzEtyPmwqhfVTHQh5++Y7vleQ2McmgEdfeKIS?=
 =?us-ascii?Q?keCGt0+1n5Eb5CM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:39:00.0130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63693129-f655-4846-99b6-08dd5192678b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

Partially unthrottle frozen hierarchy when a kernel mode preempted
entity is enqueued on a fully throttled cfs_rq. unthrottle_throttle()
will be implemented once the plumbing for partial throttle is complete.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 56 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0332e95d36b5..3bcb56a62266 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7117,6 +7117,43 @@ static inline void account_kcs_dequeue(struct cfs_rq *gcfs_rq, bool in_kernel)
 	SCHED_WARN_ON(se->kernel_cs_count < 0);
 }
 
+/*
+ * Unthrottle a fully throttled hierarchy when a kernel mode task
+ * joins the hierarchy.
+ */
+static void unthrottle_throttled(struct cfs_rq *gcfs_rq, bool in_kernel)
+{
+	struct rq *rq = rq_of(gcfs_rq);
+	struct sched_entity *se = gcfs_rq->tg->se[cpu_of(rq)];
+
+	/* TODO: Remove this early return once plumbing is done */
+	return;
+
+	/*
+	 * Demoting a cfs_rq to partial throttle will trigger a
+	 * rq_clock update. Skip all the updates and use the
+	 * last updated time.
+	 */
+	rq_clock_start_loop_update(rq);
+	unthrottle_cfs_rq(gcfs_rq, true);
+
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		/*
+		 * Fixup what is missed by unthrottle_cfs_rq() that
+		 * enqueue_task_fair() would have done.
+		 */
+		update_cfs_group(se);
+		account_kcs_enqueue(cfs_rq, in_kernel);
+
+		if (cfs_rq_h_throttled(cfs_rq))
+			unthrottle_cfs_rq(cfs_rq, true);
+	}
+
+	rq_clock_stop_loop_update(rq);
+}
+
 #ifdef CONFIG_NO_HZ_FULL
 /* called from pick_next_task_fair() */
 static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
@@ -7224,6 +7261,7 @@ static inline bool min_kcs_vruntime_update(struct sched_entity *se)
 
 static inline void account_kcs_enqueue(struct cfs_rq *gcfs_rq, bool in_kernel) {}
 static inline void account_kcs_dequeue(struct cfs_rq *gcfs_rq, bool in_kernel) {}
+static __always_inline void unthrottle_throttled(struct cfs_rq *cfs_rq, bool in_kernel) {}
 
 #endif /* CONFIG_CFS_BANDWIDTH */
 
@@ -7444,8 +7482,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_h_throttled(cfs_rq))
+		if (cfs_rq_h_throttled(cfs_rq)) {
+			/*
+			 * Since a kernel mode preempted entity has
+			 * joined a fully throttled hierarchy, unfreeze
+			 * it. Since unthrottle_cfs_rq() adjusts the
+			 * h_nr_* stats and the averages internally,
+			 * skip to the end.
+			 */
+			if (task_in_kernel)
+				unthrottle_throttled(cfs_rq, task_in_kernel);
 			goto enqueue_throttle;
+		}
 
 		flags = ENQUEUE_WAKEUP;
 	}
@@ -7471,8 +7519,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_h_throttled(cfs_rq))
+		if (cfs_rq_h_throttled(cfs_rq)) {
+			/* Ditto as above */
+			if (task_in_kernel)
+				unthrottle_throttled(cfs_rq, task_in_kernel);
 			goto enqueue_throttle;
+		}
 	}
 
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
-- 
2.43.0

