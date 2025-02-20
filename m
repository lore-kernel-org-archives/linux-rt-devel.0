Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D841EC018
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044030; cv=fail; b=aVu2rOHAfVNCnhD0SboJeHvh+BRb8FZZDmIpO4y2FePIevFIAgqXcxGeYCXXNSgQrd7EZQB0udv5KMFQd3RH0SVC7eeFX6paNxHZGqb1D+wCnQLtS6b6CmVrfDA14RkBWnZlOtIHja8QliVmkkY+DsBjrkDgrOwEaIQA1pkcZVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044030; c=relaxed/simple;
	bh=EY+ZPV2UDAjmwvuZF/12xh8zj5ylqkGD63zKcIAWjLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKtRg5dbEYFdipcbL1NifrfnB1oz9kcNw6mO0hExvRCgiKRo6BQpc91DuMmo/3EosRwmkvoIFEn6Nd0rpbavQYiyMv92NQe4MLLbb/Wi3U8aaYgbmhXQpFXiwO4GZm5GwH0LAlR1IMFL2QjBOxDkKOGRGB7yeMgUFhyuROmpj90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XVig+p7w; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XVig+p7w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSnU1FnvCkq+CO3hWBmKiZgamGhlL96SaDwTAEXiQK5hTXeKKOOvqXFF9iTQfkChiveef8Bd86/7nCiHGwBr/xmHCpT0eWAcw/ZpcvnS94bU0n2zArz77sqoJhpzCu/wFdOnUN8SDU55ElqpH/kuoyX2JbTql6lftKBKqdNdRt0emNNMlDtDt4V9IeUqzERh51/JmdruK0juIMkgZweiiCL0A8oYcTPljud+/kyvCe4tCdrFEgkbQAl4gMQM7LA5s5QZqXLJPx7wMsiLo1QcBlpVKAVqaszHx1pMQWksvJva97BVUW8nGtoNgksi42iB3tRhJfdCzRJU8MAi+z2Axg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mgLUF5MCAG2c+vMAAZrM47apPNBTI4L3mAjcPGfHXY=;
 b=XREX+YGBIbI6YWyY6Okav8xF4Fb+d7QhSSRwRW+ntSJHHqAA15vnNdKK95PgPlnFNY5hGLkg+pDpU31C/L+xOmm0XuzsauIEBVJ8GfULEZpEYxjCRUnTdgDT0bYY+/nei/HRehb9etXRVRgaJIwBAihYVBOZeAH2I2PYJDjIGRn21uUgP1sD6uEnr2cZhcHvfSM9TnWanrKH2i6brfoWFSaQ6J9xgXKWCTmWzwCcErRslekD+Ia1PJtDOgcRuyxYH83bydKpc633MeWphlCmd19dx/3+BkxKeztP0lH7MghJBAb6TH4jGVOJV4tw9OjnwEDjJspfoLKdthqnRY61DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mgLUF5MCAG2c+vMAAZrM47apPNBTI4L3mAjcPGfHXY=;
 b=XVig+p7wqYsQkZHdKFi/p4X/AcUqWbSwoTMrdMfu5PXI4+6NrpE3z5w3OncMkCZDn+xfSnwUa0Fy0+DUeyybIHcoIEcixhFo8zSMWwy2MwW/rcQcLMVuGUh+kddmx/YkpiEJKah7jSEAOQkOGVsT8yllSmxByAFQ8PREGeVsbEI=
Received: from DM6PR11CA0006.namprd11.prod.outlook.com (2603:10b6:5:190::19)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Thu, 20 Feb
 2025 09:33:45 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::97) by DM6PR11CA0006.outlook.office365.com
 (2603:10b6:5:190::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 09:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:33:45 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:33:36 -0600
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
Subject: [RFC PATCH 01/22] kernel/entry/common: Move syscall_enter_from_user_mode_work() out of header
Date: Thu, 20 Feb 2025 09:32:36 +0000
Message-ID: <20250220093257.9380-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ee9450-b483-437f-d1ef-08dd5191abdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KHhypdHr4SdziSCL8oBmv57iljV3mnTOTSzhiw44T3EtqlPggjXF3Q8qoyk?=
 =?us-ascii?Q?ifU8K3eJB23BaORTum4xQ59NcePlcBSqSq1aRwSvFnb70GDU+yiIa0nmhzFv?=
 =?us-ascii?Q?Y2f/JRUeByBvmhZnSye2fjEAV8UhAqMMoLXsniPLoowwCjHFjg1oGrEFottK?=
 =?us-ascii?Q?3vl/iBqMjPcocusXgvvoS1C3oKAItQlBdxylamuQklq9OY4JIccCposOMhD8?=
 =?us-ascii?Q?UCnSqYvuJxyGHAtrYwz5AFgokFVjf6aP4hIAnLwsHiCAI5COFOeC9oN+ao5O?=
 =?us-ascii?Q?l4KNNx7mXyLlItNXlvQ1btJ/qyvNoclLz/UNjtuY4WbOYMfMGyQCb2w7VKmh?=
 =?us-ascii?Q?kIrVXHMLw3Bt0VgBCLOTnY2g1IFcSTOvdaMt1IANskHyXmHFUUHuQD1mXy0t?=
 =?us-ascii?Q?Ywpa83gt2SrutpkXvOIRupOVY9G+OSK4DF7Vo7/u4jSuLwWxc9yuQqL5kvue?=
 =?us-ascii?Q?2d4L+kPrEkdnUMbPRpeA14RjQ/RBeH0AHJl+IfLY9mfQK1uu+U0Yzi9ipR+5?=
 =?us-ascii?Q?D04iyD0ps6WNvxGrI5nImfvpMJxCO8yB0R8fucdOdh7qQkDcadC5lASlO7IT?=
 =?us-ascii?Q?1VwQ1yejNuHl6eN1PWG6mUsaU86dZW05R/V/h0hDotp1/stNGXYg34bdgEag?=
 =?us-ascii?Q?fAPg0ihrElEhb9M9ORvpTcz3FouOqAz1VeV/Zph3DqjlATS4B8FLW2+X6aAv?=
 =?us-ascii?Q?dfHv/mc0RPGEDRW0UphDyUBW+xhgBqD37613HH4ZJPDN6EPsa4T5SGVQEiOy?=
 =?us-ascii?Q?M870AJ/TcAlU5x2ZLdO80kqK20LKnDDLwmDZPnO9tM0RymALhcPVd10zBCwN?=
 =?us-ascii?Q?cjkB8IP7nG/Y3DS2MHTF1aAX+MBIHFcqfVChj89ThHIcJNKrntno3XhmlMOC?=
 =?us-ascii?Q?iWs4BgtLFml6ptOj6S6SJA+fpNqFREquIrbPfIK+LcOY+viA6NiedL4QAaxJ?=
 =?us-ascii?Q?v8LmHL0DQGg8tksRiKNEXuzCw2E18DgufN8c+7Ro/ANzX15xw4fk68S0TWKM?=
 =?us-ascii?Q?xwanB7DoSaNA9AuvAWK8J0vwaOKLJxCwpYuQ7XBdMdnA3KOUkK4j6lqwMHoA?=
 =?us-ascii?Q?DFsxrRW0cwZXY7cAU0L9lDz3EHeuqwBC5NYVgpJQAduxwii+GgW/kYmr+LSp?=
 =?us-ascii?Q?QsgyaYWOGwTW+OvkKsPx58zkdGWKbxrv3qKKDt7RnmIKiegTKiPAsCeXkRbZ?=
 =?us-ascii?Q?RP68mL/nb8byMqCTpMMZIYBedtlrcBn85nwSg1KS17LnC66OFV/enzMxwkhm?=
 =?us-ascii?Q?yNRIJQWoBpsMNqNG5lYZmxp4ThzVuzdbCZ9FyVcx8z+SHSjdRVcxi8kBqFBt?=
 =?us-ascii?Q?lpoUudruV4RokZc+DGjFyZU05DeE6FIT9IHUt5CNZm5p1m5R9A5wf/65HUhI?=
 =?us-ascii?Q?p9gD2waYmZdBOhB5AdXgby22GIR6LDW6CGEm9cPa0v5/fMvusPI7VrL7VzxY?=
 =?us-ascii?Q?m8/FpJrE3gKfNjeaLQjJpyJCFguXLIZNbkR22S1kuoHf7WV8hZ8I432ExEVQ?=
 =?us-ascii?Q?J+zchvXQoi2Plrs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:33:45.0802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ee9450-b483-437f-d1ef-08dd5191abdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990

Retain the prototype of syscall_enter_from_user_mode_work() in
linux/entry-common.h and move the function definition to
kernel/entry/common.c in preparation to notify the scheduler of task
entering and exiting kernel mode for syscall. The two architectures that
use it directly (x86, s390) and the four that call it via
syscall_enter_from_user_mode() (x86, riscv, loongarch, s390) end up
selecting GENERIC_ENTRY, hence, no functional changes are intended.

syscall_enter_from_user_mode_work() will end up calling function whose
visibility needs to be limited for kernel/* use only for cfs throttling
deferral.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/entry-common.h | 10 +---------
 kernel/entry/common.c        | 10 ++++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fc61d0205c97..7569a49cf7a0 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -161,15 +161,7 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
  *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
-static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-
-	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, syscall, work);
-
-	return syscall;
-}
+long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
 
 /**
  * syscall_enter_from_user_mode - Establish state and check and handle work
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e33691d5adf7..cc93cdcc36d0 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -79,6 +79,16 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 	instrumentation_end();
 }
 
+__always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+
+	if (work & SYSCALL_WORK_ENTER)
+		syscall = syscall_trace_enter(regs, syscall, work);
+
+	return syscall;
+}
+
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 

base-commit: d34e798094ca7be935b629a42f8b237d4d5b7f1d
-- 
2.43.0

