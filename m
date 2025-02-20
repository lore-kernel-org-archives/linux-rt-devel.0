Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569431EE006
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044326; cv=fail; b=FDwRcttj+XqR0GV9eem80FklUMuSM4Cr1dzN4BDyaoOEUydRS/an3f/cWcfpsteI87DOrVlCdA+HrcFBwW1b4U+RLhOVIMQMOy9hxYvUUersUZg/fE5R5O5P1ztz/kfdY8Gt7iRD5mwrdE0vJtTkT+EEZhHmmw1T7b42AR9Qxdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044326; c=relaxed/simple;
	bh=uOMAFWC0FfqVuawHy7qpWWvZgglj88NuSg2svmpxMLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvFaWmrgpYcPN6SQPzYtCJ2kBzMaZEcBg1E7pUi8rveCd7c+5NMbzszYzXXW8PT2h7yce24N6emYvDNB5EWlgLXV+Yt3xhOIfm+b4wSgcZKxqUAEZgzil6BAhBeizl/DLNe8urRqgrEMTTE+siQj503ayJw6ZKIhilzScDAc7pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mK8T7fHL; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mK8T7fHL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9eXf7bmnq7nFrVCQdkow5alAZPgDezODB2d3BN7qSHc8uSY6MNASQf+W0UhTNsujM4ikeQWnHQbLlQea96nXFM/8cqcos2ViQhuPCtAqFxS9gPRYqPX1m7894ADKd2eTuNS8LIfGVMFLSOiHdrmTwhJfpN25TWoFehbCaDwK/9YwZ8I/a3A/fFqxcN1Ml79jbfRgQmOuluJGr3vdz8jkCAvryPivhveCAbnMeS/ubZTvxJ6Bkdr8hQQQR6yH12pIM1THit8hY502C/F+NGT0R9ZTM+ErRDk5dq+rf149lsnXgNXJW3jy4oH55iSWYV/SetfIjGUfSkj5rgm09RF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+VOB9lL33fkfvsjnklkiZYZ+D3epSxl6jgPoBUqQe0=;
 b=sqN83jewZGv1l+HAsELUWahax8g5NAuFiSKKlFY7kg2urbTfTQ9wm87Kx7VoMFI9oHvY5lpUuxajZaMDRKET9RWVKksvyQ/7CTlsnrnEDKjHrf5Hgo4bq2WHg6jNixY3pXX9aK9V1cAlnHqape1wCrW+by44L27J06OKaVnMPkSLFr3NpAwx7gDaz5X2w+h/QVE6vd5IIpdwGL+K5hq/CJXWR+IpWoAJ7FBD7SUzJhXeg+DNqJCQ6Tfw9rp0J0LH2IcHiITkIl7qg5Vaw+2+Mh3z48OCHvrOO/oOn/O9fR21lkKcjVmmkHyIVgLYv4ALRiztTxU2Vs09NRcr5DnLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+VOB9lL33fkfvsjnklkiZYZ+D3epSxl6jgPoBUqQe0=;
 b=mK8T7fHLXGL7o8CQ6JvqGKOLxc099xSe5oLsr1prr4/OOVgMLvIMIfNyi+6qtstIuMLwjbvVUOirzMc+sB4xLIMA59zW435KxRYbUb5v/j2gQckEwVg+dUf/6cyh36Ikm/S54DfCLMn9mr2h2o5Fxq4B8SEWfOwQecHv4wUeG4E=
Received: from BN8PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:60::33)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 09:38:39 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:60:cafe::a6) by BN8PR12CA0020.outlook.office365.com
 (2603:10b6:408:60::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 09:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:38:39 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:38:31 -0600
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
Subject: [RFC PATCH 15/22] sched/fair: Call resched_curr() from sched_notify_syscall_exit()
Date: Thu, 20 Feb 2025 09:32:50 +0000
Message-ID: <20250220093257.9380-16-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: e60fb49d-7932-4404-5bec-08dd51925b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dhFX8o8x8r1fhpg+uLiAlpWi07HiZ9m5QUvIucwryjgHGJ90A+KKoMpHD+21?=
 =?us-ascii?Q?tmXHSVF4/g6ucVhYd2JDe9wwX3YumipeS8g/VrD40c+fEqvNxoKNkfQYE4yd?=
 =?us-ascii?Q?/4ikoUhdb7Im9MJoNKHt95S70QFfP/4j0T8YylaskQooxKPJVsmiRNU9nkRP?=
 =?us-ascii?Q?vXwWrxznIHeUwZ3vhrdpq3qwwBMw6EROByuxiOwfPaRiG6f+prxa8nOo37VV?=
 =?us-ascii?Q?DIuZhVYU3a4ua6FNQyJGoqvr26bym/oDJARUPE0N2fU5cxMHnO3LaIF4Z60V?=
 =?us-ascii?Q?KSREl07PDikj9oQYwwujs1yu9b2WLBmp6kxTS9TymGUHJoWayFJ5GByXwBC/?=
 =?us-ascii?Q?XkBauzywBFkmXOlblmjHEddhhSkxOHHdV2Vvo268V8remqWcDyTkwgx+2ceT?=
 =?us-ascii?Q?vcfy9roJLMq405akevKcJHP2ck5SpIOZsWagG9TOyV3ZkAh8Xa5hHylr4aWv?=
 =?us-ascii?Q?jOuHLAmgEYqmGr68P3oiCTsNrXxzOYZYznuu+yTcvDRJFWHUKZlRMuHBMvr9?=
 =?us-ascii?Q?vrGDsAcrQeCHvOzoU4H0RpVTAXHawGyzr6SrLMde6r+eAMEaF0ggfD3rAzdn?=
 =?us-ascii?Q?sCE6aHuDGxA21N+vCikyVyHo5+6hYL5RAEmSID0u84gtXgdBZ3KXkhzLncPh?=
 =?us-ascii?Q?+QVegKqolAdQ5ylLfwCkBXcuwsxgyC7QBtd1W8PJBshRp58ycPFo3VY8xeyk?=
 =?us-ascii?Q?ZxsCmfzeCGoKXUHDgU63vg3Fura4RriSZQIdFHtzECzhmW2uf7nt576aj1YL?=
 =?us-ascii?Q?gTIUy4nzPrR+Tk7BbT7fx2QREeKIziryfFVkQcTVvgrd60DpNViWBq6bBA8N?=
 =?us-ascii?Q?gfEifDe2Mv3UaiR3FxFu/8szSiHWSg/rwugXeeb2KYH2pR3wV32Obh8192BU?=
 =?us-ascii?Q?sSJa9iz+Ez95dN46fjyVc/hRdVtXXYZcaa7f+DrVNqizqR4o2T9NbGlsldIV?=
 =?us-ascii?Q?dZCjBIk+PZ0QjHoVC/yqYtStUZlveB0NRdfEotmtQQe6vNy7LWMKwTuwjRP1?=
 =?us-ascii?Q?l5xzV5xPQok6lhRGuBrq0k8cNia7ZCDB4YbY9zujIIQMU/rHi915qzRo01C+?=
 =?us-ascii?Q?BV4LzjHIszTsOxI/qW6fp1XU+4ynFITcWPJ9WDeyRytQcJQoPL7xmjbuZoZf?=
 =?us-ascii?Q?3+Qc+TaU3ezp/uZVOdvvHhI07mzVTnQS2Ka4grNWiTuCtWTrNnLD5EfmYQn/?=
 =?us-ascii?Q?ARFdcffsII2FTvoO24ZsHhC08okVOTZWynHMl14EucI6V4daP8TF+DcP580Z?=
 =?us-ascii?Q?5fzJ7saQYBBgtMVo0v1YOGN2JiLucGiSRsb87RFEaxOlVXnKdPNjsYsCK8RU?=
 =?us-ascii?Q?asNkVPk1ZvYHAsdA9/JsliTcLqJI/eMa7NYijCSY3GTJqMmjuFZGSy/3VXDj?=
 =?us-ascii?Q?iH4ZLumWXgBDWm8zgqxtTnFqx2pu3OZnu9LO7KZE5VeyhtcyuPTzuRCJnsFa?=
 =?us-ascii?Q?XIDZ2S9nceXBVb6uAkrWbEKRWPhE5B0P5ApKHviewWwwhKvPZMvq5Erejkl1?=
 =?us-ascii?Q?iyihuekjRl0cEtk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:38:39.0359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e60fb49d-7932-4404-5bec-08dd51925b08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047

With pick_eevdf() marking a pick on throttled hierarchy with
"sched_throttled", reschedule the current when the "kernel_cs_count"
hits 0 if it was picked on a throttled hierarchy.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 68c194169c00..0332e95d36b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6839,6 +6839,7 @@ bool cfs_task_bw_constrained(struct task_struct *p)
 
 __always_inline void sched_notify_critical_section_entry(void)
 {
+	SCHED_WARN_ON(current->se.kernel_cs_count);
 	current->se.kernel_cs_count++;
 	/*
 	 * Post this point, the task is considered to be in a kernel
@@ -6848,7 +6849,23 @@ __always_inline void sched_notify_critical_section_entry(void)
 
 __always_inline void sched_notify_critical_section_exit(void)
 {
+	lockdep_assert_irqs_disabled();
+
 	current->se.kernel_cs_count--;
+	SCHED_WARN_ON(current->se.kernel_cs_count);
+
+	/*
+	 * XXX: Can we get away with using set_thread_flag()
+	 * and not grabbing the rq_lock since we'll call
+	 * schedule() soon after enabling interrupts again in
+	 * exit_to_user_mode_loop()?
+	 */
+	if (!current->se.kernel_cs_count && current->se.sched_throttled) {
+		struct rq *rq = this_rq();
+
+		guard(rq_lock_irqsave)(rq);
+		resched_curr(rq);
+	}
 }
 
 static __always_inline int se_in_kernel(struct sched_entity *se)
-- 
2.43.0

