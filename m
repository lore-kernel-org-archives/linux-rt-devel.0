Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0D1EB188
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044056; cv=fail; b=fQam0TqrMQFs9R8oAVVbNZstcW+HthEp8RfB2I1Zn7AXDYNZtcMJPGO8Zwbv71laCI4ndUOe4/+LDRD/uDbkkma5oB3fGhJckGJ5cfTBHXTeZ6KI0MfqTCj2K3qgIPpPQz8GYSlxjaqIey06Dz4RYDtSqy/0ROXKuUpvO6mLiJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044056; c=relaxed/simple;
	bh=UIPxSCJkI06Infgf3LtjZGZLjH0nyNtzfUngkyYS9wY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7GVd1w91YFZjUINatIDKNxrmAKvShXm39mx4XzWAcQ5bw7UbtCmV8euGs1j7rmvIYrxB6ti1xqwEtfpLxGOmCki5qtRJ7R9Ko4Ds47Os4voXtGC+bettjtckiPOaqnkqUsI1//ODOooGiQEAXaSQdmxgZxd7VaXlOszVCTKNh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OLTbf3WQ; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OLTbf3WQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lF6HtKz5skpercyepTyzsiu/BJ9BGyZwGRctuWFHiHqYh0ARCU0tWfrI6kgceG5Gb35M3yLugfbkD4HIc0TRlbNUKhKbm8LhuCADVJOuGfSBki1EXUugWVckl1yaE871RI9RZfjhusRmo4wGQdDmlIcfxOhO20FwtSZVsJKt3xqHW5q0BqNciMUzhPiyYUEI2YZw4E3LaCDTxd1Z4oDV+FZcJDreiKcwdF8fmUS/z9kEiyZZNEVaANLQHaUwpcVT8OcVFKFjQlJ9OgGd4wUbpoOFrGZyQVsI0uYvbXM3V7A2djXB8AGberHozOOXXzwTWIdsBlAwt+h9cd+o6C7r4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBFdh1DRzZ9UpkhGFDk3x4FN526UFdoen+gchhsFbEM=;
 b=GwXYotqGlZVxF0tynzSQMcmTTRMNJllh0IcTTjSGpRAZ158IAoYRCG2FNMPQSzGlePp2bzXPLCn3V23mk26oAKQ+2pBxplhxQqJDzQb1A8VbGJwbSAGuwcs7cK4H73ImwtdMskEWqeYI34kAMxjCLPSfnweVJDRu/yqRMjJB64l9qYsxmUUo/lKRC1m00vUeHaqKBZKLnwK50CtVreG8+Z/1m4R2ri37A4X7B9DnABwJMN3GG58gIprqQgTfkk4HhGULPXF5vvTpmIplceP9lNqb+217rMqKfvQOIT3h2qlNfY4cdhNRTqv7wJnz+wadz+ZDGKhduBI6BbLU6cAS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBFdh1DRzZ9UpkhGFDk3x4FN526UFdoen+gchhsFbEM=;
 b=OLTbf3WQILbm0uTS4Ch5mM8UNsuZURvFomyhzMef+jYIwTV3bHc6Vbi4OjyzJxgu1qMCJR/JiYRle6DSBdKXun3c5m+qcMa9IJiL/dPVrsYU2fbEU2oiVi162Z1f2jMLCRp2vMPT4i/fh2Q92q1juwb5JDsmuUnjvKWFTj7vb+0=
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 09:34:08 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::df) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 09:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:34:08 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:33:57 -0600
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
Subject: [RFC PATCH 02/22] sched/fair: Convert "se->runnable_weight" to unsigned int and pack the struct
Date: Thu, 20 Feb 2025 09:32:37 +0000
Message-ID: <20250220093257.9380-3-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c893e11-182c-4c08-1535-08dd5191b9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T2wZKpaPn7tjPK0GM/+VhoSfhGc9G5Gg/mcnrZd5a8oDc/IFLN07L3Jyfg6+?=
 =?us-ascii?Q?f5oNYncdkQe/EoPotQpW/dtPC4vxZTJSufA5RK62J5qI+yQv9JvCB+os2GGy?=
 =?us-ascii?Q?LEZ2/Xrab7QtgBT5fdf0XFJtIz7j2zP0YPUOFfz5CfRkX8MlRog/nvgVwuq9?=
 =?us-ascii?Q?LPgdW7ItpVAAs9ZskGTtjSMQgzQaUG/qQx+HeL4DZDCp0QdwArrQAUjiWO3x?=
 =?us-ascii?Q?NxeDamkkDpT62/LKV3tCVovUwDVd8ENfIjZbugrHy5XtklCNHO/cvRess0IZ?=
 =?us-ascii?Q?/3k8qwWjKe7S4KIll6r1b0MRv7YjI2d78NlYtq/4UltU0pJzRD+yxjvTr/tE?=
 =?us-ascii?Q?EM7oP7wgYB7wOEQ210uJFhtaK2nC5M8BuD9SY5/hNvhJWrXUs1zn32lfT1a9?=
 =?us-ascii?Q?gmmNpykpsmNDGCNuSXtyyH8m+ScjzAXguIQzGdZeMJ8pl4m5ldNEctksA9OM?=
 =?us-ascii?Q?FbUKsdWMd+rbrBKaa1fb1+1t6ZNE+QJTIsrOf7004c5ilOH8vaiMTUWMVFMv?=
 =?us-ascii?Q?SXF73T+21XinHskD1FaM7BE38lRRnFoTDxIshokqURNxitimgPV1MTrN/N8Q?=
 =?us-ascii?Q?Ol0xH3VXIJC/luBTDq9qAvUSVO6nm5pzd1Tk8SDshxV7S0iMXOVIsIE+KEo4?=
 =?us-ascii?Q?kv4t1a64fhCHaCon5GQ1DLB43rGy8cOaeDYjqg2kLJlLzT0EBtMvNsI0pDgx?=
 =?us-ascii?Q?aHnlW/7ezLOczvWHgYcb9dK/wgNxbm2ryA/fs4/Ezc08QmvpiJ3x39+i1Qi/?=
 =?us-ascii?Q?9REPMakc7CMH0TI28q0lYYZbKohlEPOTWmu3CXRmkthy7FwT7QrswacW/EHq?=
 =?us-ascii?Q?tawJD2devn4z5t4sbb9HIEKvhmmMSVaWntQPFWfQvFPb5Tm2Oz302gCdZJwb?=
 =?us-ascii?Q?jbdcJtCbLCv86l03YieRUVYoFZOVICLL2ls0Qf2Dst7KqunDAwcjv+j+53PM?=
 =?us-ascii?Q?i8gRIRewdYjjKCqzG9xo4S9CJowc5bo9BSjn7NuTbUANu3FKzTDO2VXH2vIT?=
 =?us-ascii?Q?Ryx6bPMPZCE4LbVpqtNS11DP5Dq2bBY/0rjmvYwFkcAufb20rzyO+wMimzpH?=
 =?us-ascii?Q?98nIaapMXOYkz1F2bjZsrFK0VE1owI4EUkBObVKeAz0nJv+9q5+HLJr4RsOR?=
 =?us-ascii?Q?t0dQhNqSUZaivcv1l9rMcJMbm+11L5EjMa2kUujwSmvNExEqxz0JazLnkq9d?=
 =?us-ascii?Q?CK4kTS3qrC8sG+m682QpjaBlAVohXD66KR825YhBoEfKpOmNR/PauXy8Sv4G?=
 =?us-ascii?Q?gGrYXNq9KmIu2m4NqJiufsxJV+BnZMGf9Z8v7mq39aZ71ytD52QzQYRlRvua?=
 =?us-ascii?Q?yfayBQ+YVZsaBlUAzRYG5LyLWvtDVbnAMMEmWr6jDkGEr4ibvA2nnT63+W69?=
 =?us-ascii?Q?bPznhZwyr9AFUCZxFFxvgKw0GTE0piYNkzpLbc30d1c0Mur4IaupHqgE26AW?=
 =?us-ascii?Q?Z2OjfzZ/UqQsZR4/B+Q0L5twHDntie2+RXMXaXr9TGIT1wNHKbiPtNVFcTeN?=
 =?us-ascii?Q?R5+b4u3rVrgytNI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:34:08.2055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c893e11-182c-4c08-1535-08dd5191b9a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823

se->runnable_weight tracks group_cfs_rq(se)->h_nr_running which is an
unsigned int. Convert runnable_weight to an unsigned int to match the
types.

pahole notes that there is a 4 byte hole after se's "depth" member
since depth is an integer. Move depth below runnable_weight to prevent
the 4 byte hole and reclaim 8 bytes of space in total.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..34862d904ea3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -569,14 +569,14 @@ struct sched_entity {
 	u64				nr_migrations;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	int				depth;
 	struct sched_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
 	struct cfs_rq			*cfs_rq;
 	/* rq "owned" by this entity/group: */
 	struct cfs_rq			*my_q;
 	/* cached value of my_q->h_nr_running */
-	unsigned long			runnable_weight;
+	unsigned int			runnable_weight;
+	int				depth;
 #endif
 
 #ifdef CONFIG_SMP
-- 
2.43.0

