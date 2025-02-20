Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490401EFFA7
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044386; cv=fail; b=MFs8/pGH6D6g7Wy0gWuCWrsu6voHkCYiAHxfBGuuRbZl7HZuZjnBOirv0dnGryRXhStsoFyys3rdpSxJmIfRqW8BRXK1uTqys4HdX7jwgZ+pesmuGWGeF5dm8IucZd/xPV9cF02nOkM0LF3Prm8p+O0+zmDinL2O3z9Bek//Pt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044386; c=relaxed/simple;
	bh=xSOHQHHR9j/ry/OSXFar0Zwu35XBN0HUUnugv1teHd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bK+0v2J1lJd6tzGK0wFe4oEHnr5u4J39pRyYvImH9fsFvakwGeQhFlvSIOQSdBot6QK5HLV0DC2pHHJNG5xRENWLzihMRm0Pw1RYQ513nmV1egiXoRvBL9VkXOyDfUBW74VshSVCwUjwj3qRxotoF3PDi6pIxeJk9eCQlbTWTQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bcUq7QW+; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bcUq7QW+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd4Q4nw7v2zwyWG22vLCL2t7IPkEzq4o9lJIJ4v1sAnabTV6abOqovZ0TbgR2n9SKvvcgOgjyRLZXzXRHzJHBij8D+TrtypD+cQVmPFI6hHk3mZq6l7fTwJiXJi+V0dWaFvzsY6SbpmKdqcqhLHzr/xcIXT9W9JU3M1hKcemWKUZuisg8sCcAAqj0AOhM3Az8Q++p225sBKOGZeTzl9PSAGkVW2EjMTWQ4IXC4aJKAgzZclEEuqPITh+y++nishqsFlgMVY/LqHkxZVHR3wFQedxhj2YRC2Gd8Jlw8jCMvSKNHbmIvBycL5GG00/5QjHWEAg9uHNdE4Ohl9HA+yDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXG+Lw8fG34xio6CV1T4mzUP43ASj9YircPN3WuDJmI=;
 b=scEZt0/AiYrPBwIA1FZRtB3+kTA1btSWG0eXoiwS0W8z1Bi6UZlGKfF7K2P5mNKM80JL2JHTdx6RpGY8hcTTUCADL0uwLx2PoNmVGipzhUk4j0l+pNOClZlc7ocrTrUvK0TVHINn2hhwjv7yJc3Z/38jcJvKh9Ea9kM/v8vncJjiKSx4fuuQLuA6iaNfSbNZ3QfZsaghAQCCa6O8fzQP6/FDnt8t+Ct4SEhOuainW/MG3j7fawOBgZE0EPCkyjx5ieLvm5C8qgKoEoZAo50xI2qW6jPwmuWPnsN2+8lr+/WY8v3UBcLNJapLucUz1CluqQtethX0TmSzHfEXyKwkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXG+Lw8fG34xio6CV1T4mzUP43ASj9YircPN3WuDJmI=;
 b=bcUq7QW+RnYeEdo4V0S5Ub5hWVhFx2l+sSFfWrbjcSAu1FbQIVGHIc1KQIDNW6fDVAEK2Kjmn+nU4p/KMtHzRvZ+6XjBafa+N0JGChsWcCoXenK3a9bA/zCYdC61bqT/cF1BT5pZE/P3bMp2MIZEtstP44VCxne44aGftlCCUGg=
Received: from BN8PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:60::38)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 09:39:42 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:60:cafe::9) by BN8PR12CA0025.outlook.office365.com
 (2603:10b6:408:60::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 09:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:39:41 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:39:33 -0600
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
Subject: [RFC PATCH 18/22] sched/fair: Prepare pick_next_task_fair() to unthrottle a throttled hierarchy
Date: Thu, 20 Feb 2025 09:32:53 +0000
Message-ID: <20250220093257.9380-19-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f52316-b2f8-46ae-9544-08dd5192805e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CxQW7bwgpfXg25aL97GPifQFRmHzaduCZFDv4TiMr+EIHjSrU7YrDm3zaRPO?=
 =?us-ascii?Q?n2A94ZBhQKmF2kCAQa2l9xM9lGGYai6IIuNSesT95EhM/bzLDKLuzAYDKLIk?=
 =?us-ascii?Q?SMI2zGTnQ3kByKxq204r/L2wFwyy6qwMGp+aeeLxpHIAywD7mK/OzatJSpkY?=
 =?us-ascii?Q?fefZO83DpspZ5C65/RuAT/hEUU0voEbJwDXiYlcb+GPZGz3lNXJiJALupApk?=
 =?us-ascii?Q?SHVvFn9M0eUyqM9JHfi8umkchztkwczGqpO/xYGk/E/NooyguWE/zEY427E2?=
 =?us-ascii?Q?AmkeMqyo0zVo8B185uUElp+M7TChom3oARD4vu2859abRCw79SXHwwIW4lPk?=
 =?us-ascii?Q?z87VKm11Wckg8N5kCDKd9v+1IGAgTkRdJ9ROrwKkacPcyjbt0VCcgQaS+1K7?=
 =?us-ascii?Q?fXs4Vmh4iSXtqCPLNs2tugkPd3us35m8puGoi5CuLoeyasKoninTdt6O8W3H?=
 =?us-ascii?Q?g2Q7gtagTGg6iDt2UH5/WTOgU1hVLpkWaFxwHG4/1RT2EjoNLGxK7LDUzBUT?=
 =?us-ascii?Q?FwuIW/0b2X9KOOHypOsNYTXmqp2tF6U/+8GRR3M4NtR+B/tGNq0epLRmB8Ka?=
 =?us-ascii?Q?PZE1HEXcSGYduoaEUgu5ed5GZ6RY0d6pQQ4YrEWFyQT3olpjQ3yCGCtFI70k?=
 =?us-ascii?Q?bxPDvwvrNbcNaQnq5UQLqiEUQPPH4eqR1OhIdJtqRh0mSp6+lPLCRiuniDb7?=
 =?us-ascii?Q?QbsgsYyiRGwmdPGgaEp1R3N8iO1GHEw4LS1C7RGH6hBCJCP8wh4mUIxay+sd?=
 =?us-ascii?Q?IOZ5b4sBkib183AgQB1NdlyVQd8NJOnz7dzJcaXWmHF+G81qRVk877pyEekM?=
 =?us-ascii?Q?LbMMTbTJH0gFjDTs11JCCfc/TjYOXKq4DfNJ9N+cICxJR4T99ohw2wu47N2X?=
 =?us-ascii?Q?NIGOLddyxz2aWZr5LC7QC01b011mhsJnbom5hcNSogoaigTRCooHNtEr9p37?=
 =?us-ascii?Q?70s9L08w0s+7T8AzQXWXj/gtMg1dxWzzC9cyeReL1J/oVe7JTxnapNHgqxpa?=
 =?us-ascii?Q?dLDFnulPONIonz69jRksmGbtnE7fVfArkPJsi5X53puJLx4vUyMxboAH4xEL?=
 =?us-ascii?Q?HDeaFwV/3jrjx9SUCImNRXDh3kd23ShYuPLm5aFqU96tYq/6ZO/JPlyrB70J?=
 =?us-ascii?Q?ciKGXAD5f0pEcXNbsmTpQGyyqsCdUceiYDznRvQZBs+r2pBBYgZi/gGka3NF?=
 =?us-ascii?Q?Uz+DwHyGbO0AW+7fjxBo/NAmJthK9cmA7UCYF50QKnv+YqIlVcOYJH5xclY0?=
 =?us-ascii?Q?jXzgs+LYtOJzHZp/JH/zbV6qBpzcj0fNaaY6Q43msh8ChwRjilw1rvx4tR44?=
 =?us-ascii?Q?wkCdsfYExVwFCO39TtpALZalHJYsNke02C5+3aFNb7QdE4It1ZYLDqX3+zjH?=
 =?us-ascii?Q?1l/ASBsXNFV3Jt5BRmKPN6LJhPXKh7mvLEviMZKmSV0TeEwYSqRzyfTCd1jj?=
 =?us-ascii?Q?3OdC9RsTRNOOsSCnluS5t27YatH17EjCve2KCiPWND4haB5iuEfBVaDBAZu/?=
 =?us-ascii?Q?RjT9NUcMf3sT6Lc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:39:41.6767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f52316-b2f8-46ae-9544-08dd5192805e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374

Kernel mode preempted tasks being put back on a throttled hierarchy
needs to be reachable during pick. Demote the throttle status to partial
if pick_next_task_fair() finds that the previous task was preempted in
kernel mode but is on a fully throttled hierarchy.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 423c5a95989e..1497b0aed1c2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9407,6 +9407,38 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	struct task_struct *p;
 	int new_tasks;
 
+#ifdef CONFIG_CFS_BANDWIDTH
+	se = &prev->se;
+
+	/*
+	 * A task on throttled hierarchy was forced into running state.
+	 * Recheck throttle status when the task hits schedule since the
+	 * "kernel_cs_count" is stable now. If task is preempted in
+	 * kernel mode, partially unthrottle the hierarchy now for it to
+	 * be reachable for pick_task_fair() that follows later.
+	 */
+	if (prev->sched_class == &fair_sched_class &&
+	    task_on_rq_queued(prev) &&
+	    se_in_kernel(se) &&
+	    throttled_hierarchy(cfs_rq_of(se))) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		for_each_sched_entity(se) {
+			cfs_rq = cfs_rq_of(se);
+
+			/* There is at least one fully throttled cfs_rq */
+			if (cfs_rq_h_throttled(cfs_rq))
+				break;
+		}
+
+		/*
+		 * Only unthrottle; Do not adjust "kernel_cs_count" yet
+		 * since account_kcs_enqueue() below will adjust it.
+		 */
+		unthrottle_throttled(cfs_rq, false);
+	}
+#endif
+
 again:
 	p = pick_task_fair(rq);
 	if (!p)
-- 
2.43.0

