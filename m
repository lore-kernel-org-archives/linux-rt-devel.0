Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109501EE032
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044219; cv=fail; b=MTqxmUvTlNjswcYlcmzo+cQPWLHMLhwDWiSXH847Vv0M5gS1seiRuGcGsiAKDop50jZYjix/LMxQOgFVhX1tRvXVGN1bAfPerrcYbT5H4eBgNg2x2Q48KpspdEf/unQ63DRdiLW3GqibYOBArGgG3EFRqehI5RY1KD8BupfNxyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044219; c=relaxed/simple;
	bh=UPIjRl6gD5NpWUvhpP6l3S3+onK6Ku7QuvRooI1n/uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNy1nRy69cgsukcvcxDadlZHMDYpxstErttXqdJ0ntld/6pcWgr8meYGigNFk/GQlXCLTazD7NSImyPXCGaxgFVvQfPeachKsvORQsjmD7gyhzTkh2aGjyXC1YlMCpSExoRYIuV76Si9u16WPWhNuEq2Sn4nZBGBrKYpBYqtdTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q7g83zb3; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q7g83zb3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icpag6sP5GQHJuaEm0Un1psv7+yxAABtoJhERwcFpvWGgFBhdVrRf3cMhp8TMHVmYRK2wuyLD9Ilm/oTvV/wQwLaTjP5s82NUCyqfKICvGnVTRy4gyQkd2qfL1dWM4tJGjSjr6CTeWGwv7dqKxzuNlPdsWGkJFHijUm1ZPbjGStlLQGBGj7pXeJFGfXoZ6oTPOks1OVfBnrVhxYWoCny+kISw0XYFZD5AvxdmEzCJQaxbcjVGK3aav5McSTtl/5Gl/+GCmZ5qnm1Kr4A5CCjy+YLm5X5l8IUXSzBKJQuPL3r3e+8d51qtum97m+4fuL+bZSi+9T27t797+UrKarbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMQc69NMTfLvejTsmV7srFHuaWBqlTGgDjfjlm5JO4Y=;
 b=wPxEv61HU5R5g/wIqnYK7alxeyMNsiKDqQ0ZQ/EnRsVfhlRVu2yvxNrox5x+7cBmrmUNtW/b5xXihOfj53dmGt2QO2CniwCTiDNnAH7zit2G9KrhgIV9qRBVHieb3uqx5ZdlUEJ6rdeMJdtSyN6F7E/YGzzZlJIyvddtze6XH0uo3mpkloXMevAS67DySQuJIVSalim1YDlW7kN2n56nQts5gbDFoJNTp8O1FTjZOgSSbz0muPg5uPjWzik1jHCubD5vW2ZdM7P87LGdHZlHMb1eJKwfMOh3zT/Eeb+CoixqtrfTwtVHvr61Zd5v3vM99awAXbbsaL9VqwKu8JEtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMQc69NMTfLvejTsmV7srFHuaWBqlTGgDjfjlm5JO4Y=;
 b=Q7g83zb3wSho3JpmIwja5bDglPMHvFb+GoheF1QMoPnNx6OLEvqq1eh6lF7PvzeE6U0YB++vOau3pP/OTi/QljbreO9L0zNigktgv3TxITB6n6NzIWoHKUut3tKTRMIPRBZc1fnc3gOStAdyNX4L4WhN/AwZKHGvILy2b5Fv7LA=
Received: from DS7PR03CA0210.namprd03.prod.outlook.com (2603:10b6:5:3b6::35)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 09:36:54 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::9) by DS7PR03CA0210.outlook.office365.com
 (2603:10b6:5:3b6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 09:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:36:54 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:36:46 -0600
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
Subject: [RFC PATCH 10/22] sched/fair: Prepare throttle_cfs_rq() to allow partial throttling
Date: Thu, 20 Feb 2025 09:32:45 +0000
Message-ID: <20250220093257.9380-11-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: e161d82e-e05e-404e-268a-08dd51921caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9a8zlsbyGcu47n7fQab1cNr33fweZ3Rfg2iJ7igs7ypBRVOw0+30nIgpksA0?=
 =?us-ascii?Q?b3+0+ov3q9nP0b14SND3pWbhN28y3LncZDo2eP4q1qT2+oqEiqLnb14S81aG?=
 =?us-ascii?Q?d4AZ6PLMjQfOrOvyFtkjVj/mDqhBT+o9y+9A2YbY2huowr7h27697IpPxdgL?=
 =?us-ascii?Q?wWvsbqJocV6vDrsmibWbmXfOLQO5uBGyf6tCVC41KI+GSpJSORALHOU1U/aG?=
 =?us-ascii?Q?o2i7xVd4B539C9BfvMxCEhvbdEWRrDUv6n+hbzhYmZk1yXgj5mFN0qEA6BCf?=
 =?us-ascii?Q?t6vw6OMcYBcF8kuQivyD0TBup+TJHd8qBHWO4tf87YmYrAPF2Z4lHH7O2kMl?=
 =?us-ascii?Q?HSiKB1Q6TcyUC+kP1FVTbK9UGMUd9VkRqD9Ucu3hc8n5NNe8IstRc/X8qerj?=
 =?us-ascii?Q?oZmqUGEmJtOkn3lE3U5zwiEQFupjyuUT8ZxdqgvsVjuGnRzoGwiyHe7IM1b7?=
 =?us-ascii?Q?015pX7vKEVOYj1Us66R7/WMv7WcXxP5TC3t6YppSUOpiHhgb6dS/BoNrCngb?=
 =?us-ascii?Q?6UGQBdhBsaw1cr9kzPt96A++TtFQTwsJRCG/D+vHonP0CdGupB4DlhHo7Uir?=
 =?us-ascii?Q?avK/WaCzzv9pSkJvd6edU7nxSiI5GnCCudE0Y+VBNcYS2g0sOQvzADaA7lJ2?=
 =?us-ascii?Q?46oauOXwqRqwJEkyYQPsQnuNPlLBkF9nFhe+67rDbwfaGn9zaC1vC8e61NrX?=
 =?us-ascii?Q?Klkdiw45i7EgHG6Lz3M0nT6zv2CxCW1ZKq9sfu2VvKzGlyInP+yCCbcnOpyi?=
 =?us-ascii?Q?MqH+U3pdr3ii7lwnpXvlPjD+NMsuZ/9zK+8/gq7eO00zsRQ4yHnQs10WyEtv?=
 =?us-ascii?Q?cgQpM3zhfPi2ghjvGIanOtwMyl9kBpxwL+vww+g2igwya/jB4RQC58swxzwe?=
 =?us-ascii?Q?GdsT15imNo1tUaVyMMBR+im8+INw2MWJ2MPR/uapbVWiv4bJusCzIkLWZHh8?=
 =?us-ascii?Q?41L8Ozefo/CmTeJuo29nME6tSbplm7pc3FweKUIvdV56SEMF7tW3j6423XGp?=
 =?us-ascii?Q?6SQrBWp05nvi7gHo3xBdF4S81HmPeLUfda345MMmmuZrpAm9NGb61Y/Ig1CP?=
 =?us-ascii?Q?aCDFrxU9Ils8zZfrI8MaUcsEsUTeM04yWEuYzcMFW213o6nYCAzXk5etVyd4?=
 =?us-ascii?Q?EmETzZbbXk8N5opWuUFRIFE+YmhDJ/AinihTMmy0k6zF7ptT4gHzbGfvqLRL?=
 =?us-ascii?Q?DuT7jLlHahNaz7ehB6b17GFjhtPrbKC5TF9Rb3AYY+2G+EjP9nxc2z0P7MUN?=
 =?us-ascii?Q?XIoI8hdDn/RAnOxsDrTigLwI1m6wEY2Q7WTNzNdxUMsSQcNYDlHTU2aeMZQ4?=
 =?us-ascii?Q?4g0pry8QN+MmcQN4EJAMROb1wHdDSEBYRsw8Hkv2mt8Q04rr70sbgNIXcdB5?=
 =?us-ascii?Q?mg0pPnqi9s/+pdUMePcdtct1ggjVcEnbKQ54HOYQ75aA/aB09I4AKl0TppZq?=
 =?us-ascii?Q?DyXy5T7DHMeIqsXutMY+ROxzBkzjTZ9s7QX9MWT+lZzi9sPRGPIQ4LetgCvw?=
 =?us-ascii?Q?QarrcuKTEZO/Oc4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:36:54.3856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e161d82e-e05e-404e-268a-08dd51921caf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281

throttle_cfs_rq() will determine the throttle state first time it is
called using the not yet fully implemented determine_throttle_state()
helper to completely or partially throttle a cfs_rq when it has run
out of bandwidth.

For a partial throttle, throttle_cfs_rq() will only set
cfs_rq->throttled to CFS_THROTTLED_PARTIAL, leaving the rest same. When
a partially throttled hierarchy needs to be upgraded once all the kernel
mode preempted entities yield or exit to userspace, throttle_cfs_rq()
will be called again to upgrade the throttle status.

determine_throttle_state() currently only returns CFS_THROTTLED and will
be implemented in the subsequent commits once the foundation is laid.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 55 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c84cd2d92343..8e1df614e82f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5894,6 +5894,16 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }
 
+static enum throttle_state
+determine_throttle_state(struct cfs_rq *gcfs_rq, struct sched_entity *se)
+{
+	/*
+	 * TODO: Implement rest once plumbing for
+	 * CFS_THROTTLED_PARTIAL is done.
+	 */
+	return CFS_THROTTLED;
+}
+
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
@@ -5946,9 +5956,25 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se;
 	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
+	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
+	int new_state = determine_throttle_state(cfs_rq, se);
+	int prev_state = cfs_rq->throttled;
+
+	/* Fully throttled cfs_rq should not reach here */
+	SCHED_WARN_ON(cfs_rq_h_throttled(cfs_rq));
+
+	/* Nothing to do */
+	if (new_state == prev_state)
+		return false;
+
+	/*
+	 * We've been upgraded! Just dequeue since we are already on the
+	 * throttled_list. Let distribution unthrottle us.
+	 */
+	if (prev_state)
+		goto throttle_dequeue;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5969,10 +5995,13 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	raw_spin_unlock(&cfs_b->lock);
 
 	if (!dequeue)
-		return false;  /* Throttle no longer required. */
+		new_state = CFS_UNTHROTTLED;
 
-	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
+	/* If the cfs_rq is only partially throttled, we are done. */
+	if (new_state < CFS_THROTTLED)
+		goto done;
 
+throttle_dequeue:
 	/* freeze hierarchy runnable averages while throttled */
 	rcu_read_lock();
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
@@ -6041,11 +6070,16 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
 	 */
-	cfs_rq->throttled = CFS_THROTTLED;
-	SCHED_WARN_ON(cfs_rq->throttled_clock);
-	if (cfs_rq->nr_queued)
-		cfs_rq->throttled_clock = rq_clock(rq);
-	return true;
+	cfs_rq->throttled = new_state;
+	if (new_state == CFS_THROTTLED) {
+		SCHED_WARN_ON(cfs_rq->throttled_clock);
+		if (cfs_rq->nr_queued)
+			cfs_rq->throttled_clock = rq_clock(rq);
+
+		return true;
+	}
+
+	return false;
 }
 
 void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
@@ -6536,6 +6570,11 @@ static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	if (cfs_rq_h_throttled(cfs_rq))
 		return true;
 
+	/*
+	 * throttle_cfs_rq() will reevaluate the throttle status for
+	 * partially throttled hierarchy and upgrade to a full throttle
+	 * once all the kernel mode entities leave or exit to user mode.
+	 */
 	return throttle_cfs_rq(cfs_rq);
 }
 
-- 
2.43.0

