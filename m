Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158111EFF8D
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044431; cv=fail; b=QxSo7jDBOPtoGzGHlXIkN37rAowDwPZSYX8tAZMvfH5CjOerU3LD872M7NYVvqPjW6yMBqdaJhQ0nsOmcwNjoBeldsG87E9hLMrdeeNDd2blAb31paLsiyhtyktTuNrH/nTNG1O1VIpqRJs0NGdsB2kNawklsFzdUJBKUVixxI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044431; c=relaxed/simple;
	bh=Kvlp1mWOGLv3Yn/66hKbibE6vRHgTRbx3xmsKxkIZiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwSpfNt1Ya1GhzHqyTOpPO+mSoeIffUwXLhN+RsB+mjfBfC+9OvaaSYWzLaP7Z6EDxbEumtqXymkbD9bEKFbN6PVM/tjwQO5AeC9vA/2+qpvlqs67x83EIm5d7tmhqKCcb+M5LkXSPreBCKBlIQ+FXI9Zz9zGdbuJCoYaFsa++U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RnNNGvTA; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RnNNGvTA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bROhVNr9G34NzpDMym9t7q3F3yQaptCvsSKlE2SjJDB1laco/rQz45fdUqa5Retqa3Z28lfcjeGF6DjcRGNVlitoloztXp5AOBx/cPHMJhWt84Vd49dJjNca1xyjSB3JDjP06fvDrxG/1MEXBmYlN+YBGB4VuqmQrctoqXGfuBKDzf0KZ21Iaw73gUZlzR2cMc1K9/ya5jpYVzAp+WOsopbOsjaJCHP7zUrJMXRqHJeBqqRjNW3lEauKjqrR6pso5YRALK+rUMljbIlKx5GQ97lELH8eYwH34co9jOZm1dDemzwEcbEBZCzC7RTwpeGJn3jw5270z2Olms8kFNVt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3jrsS4C5/vYW+2SYje4Nn0Qo8aHbolgkpREtLkFtJU=;
 b=rVYkMd25476Har9nQqZfCH9+7wF/zPr7tO8qFghrB0PYPJePUgEh+bSgns1kgq3ikcxa7AQ0CtNA2ESwHyaro/fKqd27s5myU07GhX11r7ZqDSlMjB+7a3s5iMbhXbu8P9/a+Bu1GmhQBBrI5GoihO1LExEEJL3MzC2Ea+IFcsgy0QJahz7z1vhxmygKUpb0tr0zrLvN0Ot/7zEmNy1+Aj+S2x7ymO2HjJYMWUkpCz4S9mx6jMYAMm9zdhG6ID5MWvTTgf9ndjHE/4Y8TvntaqM0I5uGPr7eITNn9LAIGlxzkekLsnG4YJg3KY6TWUEh9UePuBsokm0uYU3jhsEPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3jrsS4C5/vYW+2SYje4Nn0Qo8aHbolgkpREtLkFtJU=;
 b=RnNNGvTAw39xFBVCFhKOgzX5bSTNUJdkJX4YJpT2V8bkrpN8aas9bGLiaMMPkoRaXe2KuL7wFJlb+p4CH+DlkJ+DtR40oYLkbSGQQtNtnhCHQRc45ICYr45xcVGw4KUBfUHfytEMsCVl4hGcs9FJQfkPyH/2nSOgx5Wz1Ne/0lk=
Received: from BL1PR13CA0409.namprd13.prod.outlook.com (2603:10b6:208:2c2::24)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.23; Thu, 20 Feb
 2025 09:40:24 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::92) by BL1PR13CA0409.outlook.office365.com
 (2603:10b6:208:2c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 09:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:40:23 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:40:15 -0600
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
Subject: [RFC PATCH 20/22] sched/fair: Implement determine_throttle_state() for partial throttle
Date: Thu, 20 Feb 2025 09:32:55 +0000
Message-ID: <20250220093257.9380-21-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc24148-58bf-46ae-1f23-08dd51929947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VS4in7vJe8AoRIupVCV8AxHaoJJYh+1yOigCzrRlsFANtep5qGGBbsD7z3DM?=
 =?us-ascii?Q?E7c04ls7MKlKivdNxWM0AybNp74v5BDpd7B3J7gyNlN4el2lZPecS3eHM09t?=
 =?us-ascii?Q?a5OI1k9fYjzoMNqKFhrJrL3iE12SyjIbH6MwLERNfqSKODEbdM6BumkWV03y?=
 =?us-ascii?Q?anCPBthDQPR16RW6+5Qu0RZArA/0lSpv6EQJBQSHQq79Ss/RGF9G18/1G9lG?=
 =?us-ascii?Q?XiVVV46TsUo6tKEpdRtcV6iff5nEajFkynZ5MUi8DFj/dGMhDJwN88+84n1m?=
 =?us-ascii?Q?YsNEjEuw4NsodXWkAphOUhgvcoUYYqCUtR4V3eJkWWuEkSUJ1S360y3z7HVM?=
 =?us-ascii?Q?6NzzhesnYj02RIBAAA/8locmXetIz8vFmdy9e4dz9rc8v27lEDkdCzgidtLq?=
 =?us-ascii?Q?Q8dG/7OaFYTB0LnTvugpKR70Z5wCVL32Y8NZSUC5bbv8epjBA2ofEkQJx0IL?=
 =?us-ascii?Q?hdkx34Yczaj/GOz42P5HpyINrQTPvaZc7YJD9i2NiKiyTOsryJbi9BUy+RE9?=
 =?us-ascii?Q?2Kiuz7z3ZSQUTjPiCIdNpyu9OUT0tttsbqPFvtzDOR2BJnlSBBxglP5qRbNx?=
 =?us-ascii?Q?ipG41UMrYMBk4Y5A/8x9FKOw4XxfYsi9lA3yu144yIObIqWpa1PxNywRtqjJ?=
 =?us-ascii?Q?b385V+Mevh2Fxv20lsSav9hlSqJU73r7XHi7196diDg2jAB00bz48opJ5eDw?=
 =?us-ascii?Q?XMpkgPUmCO51RyM5eveg4p0ZUAdY2IUsuE3r0GZM0dfX7vxwAuk5YAigTzAf?=
 =?us-ascii?Q?sSxW55/wx7HScojtiR+3YavnDGiRzFadZmld+w8yvE+tBxaV6DIvHRfNZBeV?=
 =?us-ascii?Q?Kt7ml5kl5hylQIdZqdFuww9CPR1QiAx5KDIq4fYlknpkZH3xxp/x2Tjl276g?=
 =?us-ascii?Q?gcsQ4QI7XLfIXviv2YQFNHA61rRIStGtTDz/qQZuqXQgFncZ4MpSIU3DxYjz?=
 =?us-ascii?Q?09OQUo8Xe4Z/TFjVtlV1nFbEhUjGKmOo1W5z3aCbJmjo1TFKGEAwWa+3adge?=
 =?us-ascii?Q?aZQ/oVSgca/uWCoLLwt7jR22WkF+Uke0y2V8U7NS8W5UgS/ds75T2oHwFKfF?=
 =?us-ascii?Q?jbVitPSUNFRTjGXqVStKg1eXdmyeOmMfXIJlR3X3xr+Fwdo/18/0RFZYdaf0?=
 =?us-ascii?Q?DdzKQWwq6JupdU6kR6+3Qfk4XJKNYoWtFC+YbZsGPIjX54fmIQIoFx5QStfd?=
 =?us-ascii?Q?7CAUWuyz37W+65EjcPS9qf607djOzIVERVVUyatIch8HcGGvzVPCnEq6F95k?=
 =?us-ascii?Q?G25KU9IQzcMgCneXRh9oLfp0X1vtuc9GRHPFddrIAlYDb1jT3hg5ZThP1eDx?=
 =?us-ascii?Q?vm83HIN4Wt224xkKTzUgR7PZ0yP+W+Ir0YTjdxGMfMqhD87Grr+JX94lEZNY?=
 =?us-ascii?Q?ET9s1ph0+K8Ir26aUv8A6sbIOL3iBYucP/C4ToMtAmG7+dQEJFaFVfLp9L8P?=
 =?us-ascii?Q?IMXuowVGuUGmdm1HOB4y17Ipeb5aSac/os9pvbQH+jJDKoObMCbFzXslqLgG?=
 =?us-ascii?Q?pB63wC1OrUVHvGA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:40:23.4503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc24148-58bf-46ae-1f23-08dd51929947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629

With the plumbing for partial throttle in place, implement
determine_throttle_state() for partial throttle when it finds cfs_rq
with kernel mode preempted entities on it. Also remove the early return
in unthrottle_throttled()

"Let it rip"

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 55e53db8da45..39c7e8f548ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5894,13 +5894,37 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }
 
+static __always_inline int se_in_kernel(struct sched_entity *se);
+static inline int ignore_task_kcs_stats(struct task_struct *p);
+
 static enum throttle_state
 determine_throttle_state(struct cfs_rq *gcfs_rq, struct sched_entity *se)
 {
+	struct sched_entity *curr = gcfs_rq->curr;
+
+	if (se_in_kernel(se))
+		return CFS_THROTTLED_PARTIAL;
+
 	/*
-	 * TODO: Implement rest once plumbing for
-	 * CFS_THROTTLED_PARTIAL is done.
+	 * Check if current task's hierarchy needs throttle deferral.
+	 * For save / restore operations, cfs_rq->curr could still be
+	 * set but the task has already been dequeued by the time
+	 * put_prev_task() is called. Only check if gcfs_rq->curr is
+	 * set to check the current task's indicator. If the hierarchy
+	 * leads to a queued task executing in kernel or is having its
+	 * stats ignored, request a partial throttle.
+	 *
+	 * set_nex_task_fair() will request resched if throttle status
+	 * changes once stats are reconsidred.
 	 */
+	if (curr) {
+		struct task_struct *p = rq_of(gcfs_rq)->curr;
+
+		if (task_on_rq_queued(p) &&
+		    (ignore_task_kcs_stats(p) || se_in_kernel(&p->se)))
+			return CFS_THROTTLED_PARTIAL;
+	}
+
 	return CFS_THROTTLED;
 }
 
@@ -7181,9 +7205,6 @@ static void unthrottle_throttled(struct cfs_rq *gcfs_rq, bool in_kernel)
 	struct rq *rq = rq_of(gcfs_rq);
 	struct sched_entity *se = gcfs_rq->tg->se[cpu_of(rq)];
 
-	/* TODO: Remove this early return once plumbing is done */
-	return;
-
 	/*
 	 * Demoting a cfs_rq to partial throttle will trigger a
 	 * rq_clock update. Skip all the updates and use the
-- 
2.43.0

