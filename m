Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE21EFF8D
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044365; cv=fail; b=b0F0pD8UUyqwXybKLu8F8wvHMiOODqdeGDC9ec3d3BwMbIZ00pNBKvdGizvWX2DpUVE4JeLp4p4GO+zYVUXh2qvzQEyBb4MdAcVgkIbhR/nfxGamTP/M460yPursbIWV3cNvnCDf5/HfuSlI2hHoO5fOjjKkS8Wz5WCtIrI37T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044365; c=relaxed/simple;
	bh=FlZa9MtP1VmQZ6vjSiokY21w30KRVVVwZ6V+WOLP7Ug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5kc+kv6MEM6kSzQifcpJKJ3ho46HxyL4ZSKsY1bwx0nT5w9yH62bVYXn6FY8QtWBWDWzMgHwdEEunIV/k9gnlh+O8uTVBH6tRWmWRQ+tySVBg1ePW2DuUloryYo4O+TF6IY0QUpINmqvPSIYNJYTAdJPg1F7Xq1xy46EfVN3wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0GJ1RqFd; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0GJ1RqFd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLgYrI2xWYUoI0DuqUEFT8x4lNUiS1c6sjRboQwjJYI4ll+pTmCJAWnXDEp3P4+REiRl9lFuUyULu3FEBeCf7lRGeJamB1G0dWALXNdRmqbUhdgog8FCSdJhlMYVp48lElh/Cepr/LKIArFOBTj/SrLBpfYSvwOgFQ17+hS1XCDykRhOljAqk85+NZRPrtJrbNsIJOZDhPOyiUzTEYsB7uz9GJcJj6K3GpORCNC2DBQa/Uf/5Mn0yo4PFO1JAC/j8+ms0pec2x1DlukKke0tg8naeV3zdhtPG2TG6ubIA5TGsgeHFz6LY6H1OKX1H4M6LiAfkd5VluaDd3FPTuYKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXc+PBLmf9U1pnN5cFTU9KvcxVe9yZz/72X97T40q8Y=;
 b=U1IFfg5DS4+7L2raTp3eV1QezfiAmNk4AqRJoeY3Y94SVeXsiyZrawO1MMkcUF02twylc+8WQ+tTDKTShnKzfq+M6ubYMLVS8usE0Gz4IIGN/sQD5T4yb9H6GNJcMzQmPpVIVWmz3MJi0wTHTl85zWpOr+UT0tEJviy6c0dPtOzDjDypRx+7kOQZpl02ko76D2lQv5oM5yBXDJlpEOC9agqjKoIvgBsPM+Pz7QfSqLelVsAoPxoQT5Ta7kdts53g5rZrKK8knsYLWJu5aGM8Y8xrJ9DMklI3MXDWpv/SVu8C9fw+hMaJ4ul6E6lahod9ZnZCIgYjYMc1nm8HTTbBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXc+PBLmf9U1pnN5cFTU9KvcxVe9yZz/72X97T40q8Y=;
 b=0GJ1RqFd9/46wMuDv5woekLJdHhwoIhdA27+NbbXXiWuYiyc/6k0UjDDdNpG202p/JavdQCCzFGAKMdHGED/dCoioadRp5/tWI/GZ03xlzJdbgNB1iT4X7OKfMJsSa+i9rP7biB5fyvAtfK+k1kFwFTfHPo0n1TVHWdDJ73wAO4=
Received: from MN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:52d::17)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 09:39:21 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::61) by MN0PR04CA0026.outlook.office365.com
 (2603:10b6:208:52d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 09:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:39:20 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:39:12 -0600
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
Subject: [RFC PATCH 17/22] sched/fair: Clear pick on throttled indicator when task leave fair class
Date: Thu, 20 Feb 2025 09:32:52 +0000
Message-ID: <20250220093257.9380-18-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 4793534b-5a3e-4dc3-4ae8-08dd519273f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?02TV1xn3jo/OhxExNoBxh1Pa4iVWO2Ce4OeHnpLn9fz1e+b7XB5erKdrI8ml?=
 =?us-ascii?Q?yBT38VtCMCXmTSzcBtGyEsdM7CSShFMiB84x89oNQOqGxdMQ4ibmShg9fNhX?=
 =?us-ascii?Q?jbHOiBeTcoci5hDZoqU90U3iGS6SzqOGb19K0QAPHOFUgsWfVNtIV/DfsOCm?=
 =?us-ascii?Q?5SokJaobuzG/DHlxMaGd49kv2gYNjE1Ns3NcIrw+wYaS6mkHyxiQI6dZwJLK?=
 =?us-ascii?Q?1RKlhdeBDvEgFrKY93uRW/1BFgR/qtjFDOPSj2IUueeeAJlPJ/igvgguPlcD?=
 =?us-ascii?Q?oscliGKjixemx0LlFkwgdGsV+89d6/v5Jjr2/lILaGBuPuloNCHEVzQN+5Sc?=
 =?us-ascii?Q?mMculfsoiu2NpX64Yo1gS4yWVeKyKVRI0U2VtFojB5WH7GdhVYQRhbA8cRFV?=
 =?us-ascii?Q?4sL4VpJF711KS7b5uL60KuegFSNf41jk2lKoFHHHRCoSpnWVejcFH3Mn9+eg?=
 =?us-ascii?Q?DV/vmI6nrOaN5c0/YhwHLBQLa4Q0hqQstmGqhqtrB8Rlnudk+Rv5QduwXXiL?=
 =?us-ascii?Q?iMMjHQGJR+JNK0McgXLBaB/JnKlalPOp7OeXU0MmJctNex6IEkHAApvnAdjz?=
 =?us-ascii?Q?b7DXM61/u8AtA9hoi+aSn0ic610NWSgJfYxkF8PWF5hAlswWqvKDlI1Gq8Je?=
 =?us-ascii?Q?tNhy/ZAMYPkzmhFyYUyr71b4V0mMRIEL0pXZ2cVhK4F1rr5TuNlk2Yvt7fkc?=
 =?us-ascii?Q?kpSbyv3/+oybf+qSf7SRaHMhlUN191Y4/nJZquHGogNnZ9nUGo2cL+HY5x5K?=
 =?us-ascii?Q?Ow6zsyaySwZW64adQzJucDxbNKHsWVVYejGLnRzaJejw5rXhx49dJUEst8zQ?=
 =?us-ascii?Q?+wQ8J5dyZGPAhnC0dHGJsytpJITROYyjznPU0S504ihKTcms2gx0yOHfnzXx?=
 =?us-ascii?Q?e5SSxhRBL4rREZXGs67ilokf0YqojTWKtC80BHOxeOBybaZvQS+8N/DkGpo4?=
 =?us-ascii?Q?d4oWAFKs88mwRq0gAsmBDMWpvu9RSKrQ37ClPMKl5VIJ3Gqyeew0hnkCvLvk?=
 =?us-ascii?Q?GKOHwIahBaj/C5jK9oTQ0bNghAq9HE3n2sMtIcNff/x2jTxzBz6spECe6wkC?=
 =?us-ascii?Q?1JDzD1iE5+x4PmNkILBANXUn9A4Nsk0+/ELYoavbznXaiK2xXIV1pcr7F52z?=
 =?us-ascii?Q?DrxnCOmK75tBamCSmr1LCZrboSTTxxxEI/EMXdGVQJ9nFeOlwgqdeDFZWNEA?=
 =?us-ascii?Q?6IoiSQsT8qKEvQwXMPQchJB61RjJrFTtJzYssy57B+NpzogdjtYiABwgJrzi?=
 =?us-ascii?Q?eNFxyGosMWlJn8scLCVu2ycU26lbB/5K/yFaHsLzmPk8C+kUHM+qM5uoHs9M?=
 =?us-ascii?Q?D9S2jHB7vQx1h/OrIrpdEx535gHyoljEiJ6cjfFYMUP6Q1uTqxRzsyRx2EMB?=
 =?us-ascii?Q?ER3GFjdhxa4rPBp7pbtVPykDdW5thOtkxyPn5iGfde4qRa+citlTdMiocOCj?=
 =?us-ascii?Q?JI7u06tpP9HW6cpbJUvhXRrIi/z9QvYsHR6tEeyO+iJ9ArGiINhEMnlpZQBv?=
 =?us-ascii?Q?+Nt22V2vGtR9e/k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:39:20.7627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4793534b-5a3e-4dc3-4ae8-08dd519273f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468

Prepare switched_from_fair() to clear the "sched_throttled" indicator
when task leaves the fair class.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3bcb56a62266..423c5a95989e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13805,6 +13805,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
+	task_clear_throttled(p);
 	detach_task_cfs_rq(p);
 }
 
-- 
2.43.0

