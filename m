Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2781EBFFD
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044094; cv=fail; b=HwWwzaEdDFq/KIl+LYzAdWeJI0pLBjRZGIFPil/N4DhNJoI5Iuk5I7axMwni4terFCCYq49ccbCpM8liXSbKtqlRjb11U5Onl/Kbj2e6PwN8PEm0ZfYyzgg/xhx8RC5Bw66yEb64XTJdKcJkE8rWpc2TTCmC53nYkO+zKLBnbwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044094; c=relaxed/simple;
	bh=tmeAss37SoNQc9EHx3hocH+nRv7twvt5nQlycP+Sk8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtsWRDrcsaoGsq5e6HRosIGS9QC/zM7cBvWUrd841GkI9QtbNCOVKBs91fsW97xqLH4PAwstIo8RAAShxxZCsxJamkgnW6PTHVzUqi2AFLordfDniyHsL4T+Lj7UqweVwLlSEcAB8uejx1ngFULtCHbRbfQBFrjgtKiHmvzI9go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hmSexrhP; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hmSexrhP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRznBieZjjazhJVDUXCpdzMc2Z6pKpik2gE3ZqnVTQQhMuZIPkKkZdfR5N+a3YeAjSQOXf7Inc6YXAIf+IwXliZqpaPz/rrDP9uQYxrU8+DLcwQjXwagX9OqW/5jfmtFJS3zOAa1p4R9Hy/yWz8FBoYzBmLwcsrLIazI00V0dwhtfnaYNuynz8/XGcV7ufVYqbr6ZW3xZ7/T4qAfqDWuPxAgFGbKy5xvonmTmF1de6PUaQ1Zh+/Ml76Z/zcx+CFyhZ+kTZyseoIgEAWuDt5C9V4hEZQVPPDq9XBfRefWkLeYgQmA+zMclrB1bC4RYEKDV5Z2l/EwJaSg/jpdcXYDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGuJkEZJ1okMvOGxv+Hz5pvHTp/JxaKF5Hqh6V76DJg=;
 b=SG72a8pOkU9IDq3fZpXd3LtIxApjLOcJxKOL+f2BUQYF/L6v4BcA1qlicuyLYtHzNDvyE4lcTCNzyIfcwfVnxLbLn8dgkjW9YwjkU9xcT9fdi6ad1esG/SMEa7nJPFzayLn/AApAwTx/6PZI3wgR28vn4E4euKCEafdRs1JqNrHFioMYXCzbW1/Wx59ZJPdPRGpvg/s4bVRtni6sBw5DxOJHl4ZMeLPDglT3tI/nrAcc6fbZ4D/e5TGHhtpqXPfnWBwgbL1t6ippE8nZnU/tLJFP09dDQObBBApou+VhNJyxb91z9U+bd9y/K6FLzO5XfCDqQgjsox2bgKRdRIZ9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGuJkEZJ1okMvOGxv+Hz5pvHTp/JxaKF5Hqh6V76DJg=;
 b=hmSexrhP97HN5Bqt6Fqety3nSSn7Qd4T8qQ44YC8rCbDezdtEvt7UNYAUJPOruAZ7mo3VC2ABYLL5PRqfPDVHO446MpT1Z553DkSACm7DclQiKl//C3VNV5KPGdOMFqiVCPBldx3cRRrPgRF1osiKdtd7RoakHlIwkqZG7SHf+s=
Received: from DM6PR11CA0032.namprd11.prod.outlook.com (2603:10b6:5:190::45)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 09:34:48 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::35) by DM6PR11CA0032.outlook.office365.com
 (2603:10b6:5:190::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 09:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:34:48 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:34:39 -0600
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
Subject: [RFC PATCH 04/22] [PoC] kernel/sched: Inititalize "kernel_cs_count" for new tasks
Date: Thu, 20 Feb 2025 09:32:39 +0000
Message-ID: <20250220093257.9380-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3acc76-aa93-4692-50a6-08dd5191d16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KR2FQmxrpZCgdDCfLscv5/bhwMX+80eCDgVu9ATUGVIEEyUNuWR2fbcAnuk9?=
 =?us-ascii?Q?qvjXc05e23om97qutRjPy7s+AZVr+CYbJWluFvJ5do9IlgIzKQXZp4LbrdSO?=
 =?us-ascii?Q?JKdptEVKygSRC1rxKQfSPjZ060bHqkYPjN4U4W0X45aKeGAQKIfvxUznF43D?=
 =?us-ascii?Q?lGTvxOI6Nq5ydsMW326gC50cRufL6jDlmyCcI92mbTs6YuKLgBhwufyNIz1s?=
 =?us-ascii?Q?brqFeJQ5foVHkShOiIK6q3Uyesw1VrMik6wp/ujybOiKsvh8LIEMDAQZZ3xR?=
 =?us-ascii?Q?mcMJSzLWPVEUcW0ISvnqovJ5sChKqUXnL6W0ClJMN4/QZhFxKvd269gGQpMS?=
 =?us-ascii?Q?YpW3LISib1weKOxqCa5swprE+9Fce72Akq1W7voWy74KCOLU7wBcAqwOwVrz?=
 =?us-ascii?Q?kdwDGiwLionX01h1wAtpCUiZ08+6CD0l0G8QAKY9QuFjcELD4a5UhDJRlWNG?=
 =?us-ascii?Q?09mWiBPMf5UaZtjhOj2d510PRYnJ4LmPnlcWV28YE7AtIvbRmy58QAj3oaFS?=
 =?us-ascii?Q?yz3H2+Qt9Sy4OKCpep1u69qNGHVxZxput5sn5GjPICZVqi9SG6SpedtUf9lS?=
 =?us-ascii?Q?uBwVKfFpWliGPnp64UXzUTv/DEWRry1lwad8RgbAlBz24Nfgf820mP/yVqVZ?=
 =?us-ascii?Q?/hDMvYLelVZf0Vby2fN5ENwBO340mESA3qQZ9aorjAwXUhAysq4IOCuyYQBk?=
 =?us-ascii?Q?Yt7y8EsZPG5++zu0ajHOZHj6C4hQiS46YMJQBULNwLaseb1TA3PHtxXEet9F?=
 =?us-ascii?Q?1A3LtI3+FjrNr+Q0Yw/k5tL+5KSUaImAkWBMWReiTvLlVcMdpU+SwgAP4d86?=
 =?us-ascii?Q?SMcCvOLrDDD9oCsDUbF04qsz4gJKrEbYD2LTEbehutQ/6+zgfuQBV3OyEwzE?=
 =?us-ascii?Q?d8HdyZPArmkv85f2ycx0kuHPEgeank/E85rv+Fi65xGTY3gAXZ6Bi35CJMWv?=
 =?us-ascii?Q?YAuiSN72yXaPCp1RIXguUcE2xt2/v+Cd/SkE+RJSkPARxG/EM5tHrzDzBTrO?=
 =?us-ascii?Q?7EQjbZ+7uM6PYQV5hwg51YRql6s9WwTW8a5tfjtxp0KfOnJLiYlp6vyU/OW6?=
 =?us-ascii?Q?6KJRfyVIv46U280t+qhSrpTQBydwOwJDSsVMocHijKoxv0xH1nFcJ2DkzhNO?=
 =?us-ascii?Q?R4VqwSZjkS2PI1pAZakQeL0zfFyXdh5mHIh0Wh7sa2jRd5k3pRk7JKrFEeLE?=
 =?us-ascii?Q?L9xJqWqfO1Ua/ZAkbNN5SsOeZ7/X2l6EjjU/lzpnNw469/eDOxM15ANbZEUk?=
 =?us-ascii?Q?xbwj2N2Jq0Df15XlW3n0gt/aCNllpp4M6rp85Q6rOvpFBEUxmm1Snfan1aBD?=
 =?us-ascii?Q?o1W1s7ROUVBbbQNiLqBRAqyT7VvNkSYObYZWzMd0qDH8d/eFIRQfVLTdiQbc?=
 =?us-ascii?Q?HOsuAm2HSXWffHxg22aAXEtC7YknDnlaOOjvBMctTdNGUyMHGxxi+z11cYrq?=
 =?us-ascii?Q?3hIOwwpjJYiOoVT344rcDZmuzBokh+ZFggxqsgBs5W7h4uT+ZpFYkk58NOD1?=
 =?us-ascii?Q?YjhY8h+Qo3fdkjc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:34:48.1119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3acc76-aa93-4692-50a6-08dd5191d16b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759

Since only archs that select GENERIC_ENTRY can track a syscall entry and
exit for userspace tasks, appropriately set the "kernel_cs_count"
depending on the arch.

For arch that select GENERIC_ENTRY, the "kernel_cs_count" is initialized
the 1 since the task starts running by exiting out of syscall without a
matching syscall entry.

For any future fine-grained tracking, the initial count must be adjusted
appropriately.

XXX: A kernel thread will always appear to be running a kernel critical
section. Is this desirable?

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 init/init_task.c    | 5 ++++-
 kernel/sched/core.c | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..90abbd248c6a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -88,7 +88,10 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 		.fn = do_no_restart_syscall,
 	},
 	.se		= {
-		.group_node 	= LIST_HEAD_INIT(init_task.se.group_node),
+		.group_node		= LIST_HEAD_INIT(init_task.se.group_node),
+#ifdef CONFIG_CFS_BANDWIDTH
+		.kernel_cs_count	= (IS_ENABLED(CONFIG_GENERIC_ENTRY)) ? 1 : 0,
+#endif
 	},
 	.rt		= {
 		.run_list	= LIST_HEAD_INIT(init_task.rt.run_list),
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 165c90ba64ea..0851cdad9242 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4493,7 +4493,11 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
-#endif
+#ifdef CONFIG_CFS_BANDWIDTH
+	/* Only the arch that select GENERIC_ENTRY can defer throttling */
+	p->se.kernel_cs_count		= (IS_ENABLED(CONFIG_GENERIC_ENTRY)) ? 1 : 0;
+#endif /* CONFIG_CFS_BANDWIDTH */
+#endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
-- 
2.43.0

