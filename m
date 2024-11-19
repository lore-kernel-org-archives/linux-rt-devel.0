Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF7146596
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Nov 2024 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731995151; cv=fail; b=EnIvCOsh3XAp7MO7aKSXStziS89hawQK2cwhJbon5dBYIAKgDDbBgFXwGrG6sn2NjWaIIpzHu6sroigjHw5Ikslhc+hT6Sa48amGFPBq9EIBeVwMK01Kb1Go/c6XkpvEyf3lqO/z7kerS5Lvn43EFAX5XZ83rLhHcR5TyRt6NW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731995151; c=relaxed/simple;
	bh=MOSwCEVScRBGxjHxi9jQzzkIWqmKmrg7wW2CnkCTk68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pi/mfmB1jDSA3GepQ0+2b6/lOg3ob4SghnIVTYmN6aPG29wSvpvUuh57hXq0V42n3bVV1SjSi8hHWdaT41vdww4GcJZSAGzeWDdB6VtTt1ylKPoqGitRfQv8YFL4LHDC2U35UxLfuFV1fVZ3lfayQuzvzLmDMuPHiQc5XLkGZDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fm8grh/m; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fm8grh/m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxWtC2DxiI8ZoSTJHUNMFEa9ly4ZKEliCq08fCgKrYYapmFsB0HwQ6K37QKvpy2ze1/xMhAlKDQbaBYoTh+fMhLybDS5+h/oK35PoZg8otDF1+Pc9bLN/vMJcrj+c+zFf/RfR2i1fXSj20EF5aItoxGBwXsxJtER/nYtTxtpvwHBLb+FU70AdxECWX+Yp1z9Y3PoPItu9fNmyjY2zYJvj142USymNV4BmibrEyT+Dc2TZSMFqDYbU+WvEqa4LEwv4E0leQz+9NHHqa43E4S57yjwNkVIzU+/a0wy4KlUexsqMPYJZruBjEs32y7R+yU6vqNfdT+DKNyArxmPzmQ1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS9hm/KjUWl+Wpcw5jNpBeKzC1ALZbApj+pKBhsvbYg=;
 b=u2AkzO8gZUnkYvcKS4HUSExWx6/Fwo6GqVQx0RJFHX9y1ZRuWH549/M42b+e9OtBuOVcGtizNpKwo0Z82j6CZbdjpdpm1fnh1LkdetVEXhC/KqymXcgOssfNoxUXuX45tn6UuEgis9CS4Uaif7tozRg9v5Fviedve0WP+8hr5zz+NB0eRx4yGUPw5OiDVS6HKlmLoMgHtO7qVmk8PuwnSkgSlZv9tS1oJ2nB0vD8QuvRVvC3gRR7MuyCkqLfWBAjniGdeT+24uRe926FhJGuVcIXI7hJFipX0yBgIXCnlL1Mh2Ec3n1HeqoOesOCB9OpcVwXPm5EkoF/oFZU6xH2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS9hm/KjUWl+Wpcw5jNpBeKzC1ALZbApj+pKBhsvbYg=;
 b=Fm8grh/mkqCXW2PBR7ZUlvu4WByhVVF/BVKxbqHng1HFdVdLU3yK72TVQ6Z1zCImBfyriS1puMyfeiSK5jdFXgT+/AG6XmAlfKtHGAdo+IZboohVFV7a1MWFTMLK9ZRTf5a1NBsufR93aNeCNwlZuOVdeRXl9evtzWYOmNs1eVM=
Received: from SJ0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:a03:3a1::30)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 05:45:46 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::58) by SJ0PR03CA0385.outlook.office365.com
 (2603:10b6:a03:3a1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 05:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 05:45:45 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 23:45:38 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo
	<tj@kernel.org>, NeilBrown <neilb@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Caleb Sander Mateos <csander@purestorage.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Chen Yu <yu.c.chen@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v5 3/4] sched/fair: Check idle_cpu() before need_resched() to detect ilb CPU turning busy
Date: Tue, 19 Nov 2024 05:44:31 +0000
Message-ID: <20241119054432.6405-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119054432.6405-1-kprateek.nayak@amd.com>
References: <20241119054432.6405-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: c4002bed-e9dd-46ce-7c5f-08dd085d69c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QimA3z+FRIE39+T8yUdNnIXcMAHOr3ELbvzNu41fLLuftO5c1stTwzB8aCFm?=
 =?us-ascii?Q?JVTxUolP9MeN0wwToq+/SC3ygHzlDvE2gh1gcxb8v3K3wYExfvUB+Qj0X6BO?=
 =?us-ascii?Q?CU8uC0qmR68qYnO7hvacxKUKyWkxgzr4Nk8MDUDbv0JpZZ/FrnCsf98cD9yA?=
 =?us-ascii?Q?1NJoKrl5z95ylWeurhioidOMBY9EyQ52r9ytKj0DmnvmEj54ceK147e4H1VY?=
 =?us-ascii?Q?iojssKrEMY7AEj5QIxhu7JmpoRnLFvPaqFa2zcu0RKCefZxTXk7uQ/VZ1zQK?=
 =?us-ascii?Q?2Kfbkr2mPYDJgn5/4RLCaxe1kmn8KYXJfVQaAoaUSbpSUH9Y2pyB5bo1U/cy?=
 =?us-ascii?Q?OLzOhhNZ0SWDmSqHXtID5mJDH6a9QVX50PVF7fSsvx0bcagKOdBZyxqvpM9P?=
 =?us-ascii?Q?ga1f1knfoX938QrJvUzIjrCDcPBu/wvzymEkzOtBzxB0OMLVi41uaf0S136K?=
 =?us-ascii?Q?xRvnTohtcHcCyDA3HgGEGrK7dmAUE84ww7JSVqdcF8tX2PGZtc5E96uCh4CO?=
 =?us-ascii?Q?TVMJWnC/GHlYSd/cquiY+JGw3ZHSTsa2Frx1mtveyVxRAZ7V2VQT6qpIbIjk?=
 =?us-ascii?Q?7VDzpV6E3vj4cFw8ef4xAwOw+17M5liRHq/XbtZPQymCjSehQ64Gy0TR78Uc?=
 =?us-ascii?Q?0Y+jNLyAtLMfW78DOG3cas3p+7CXYpFvlaWNa0vl9/tYDA7QNfnMEXNDx3Tp?=
 =?us-ascii?Q?SsThOnVuwBLaRyYTENPoe+aLcpnSDIrJYNdTFVWGHsS88rzpmylSLG7S/5xR?=
 =?us-ascii?Q?v774SHvqYdTOIy5aRnHY862yVEpjNOl0wqm2lCaZrqIwMbqO6fAMSWBdyBza?=
 =?us-ascii?Q?S8bSZs2boFs+dmsGcrgoHnBCZSpGMU3ne5n73W7YpZ1gKUFDQkGT0jQ80dFD?=
 =?us-ascii?Q?BJgBZjYFLoBP80CR+4UTXivvX6JhxxR7pQvMdAA7W+wncyiUFIdhrjCddG7B?=
 =?us-ascii?Q?stXRHMxV341ikYLY7HZyG2uKv+McWWim73AX2Fhwts7ioBHCamGBmPhtPb30?=
 =?us-ascii?Q?9wFov9Acv1dXcmvg1cRc2boiVLswSsJXrgqZ73EskNNXD9x6K492NrZR0GPG?=
 =?us-ascii?Q?h3UuqpCvyMN+gCL9KVmVqsfEiOBWlX3PBwR9W82Ptp/uNz84Rh4uNtSTJbAy?=
 =?us-ascii?Q?4qVvvPVXwWQ3hbyyA0qDrW58JyhL6v0NT7tXp42IkeGhcP/57Y0CNqd70fjz?=
 =?us-ascii?Q?Tx8R8RCDJmjeVen2bmb7gyj9zk/GiTSFWlHjkgNZKoarq2JqHg7Gj/OByw7T?=
 =?us-ascii?Q?vzLJkg+4RWyNV0U2zsO+b8yECJtuuCARSCrW6FnP+9SlKEstffB6yo67g19N?=
 =?us-ascii?Q?mEE4TDxHb4Ry0zjKdXRrBvEyCVhuFOghU5k+ihqa4XmtnTBMJbno6JbvTReg?=
 =?us-ascii?Q?u7B1X9p9Yowt587JdORyR/VKe/Lxl9rbiaVOqBEjuehGOPyjlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 05:45:45.4225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4002bed-e9dd-46ce-7c5f-08dd085d69c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600

Commit b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
optimizes IPIs to idle CPUs in TIF_POLLING_NRFLAG mode by setting the
TIF_NEED_RESCHED flag in idle task's thread info and relying on
flush_smp_call_function_queue() in idle exit path to run the
call-function. A softirq raised by the call-function is handled shortly
after in do_softirq_post_smp_call_flush() but the TIF_NEED_RESCHED flag
remains set and is only cleared later when schedule_idle() calls
__schedule().

need_resched() check in _nohz_idle_balance() exists to bail out of load
balancing if another task has woken up on the CPU currently in-charge of
idle load balancing which is being processed in SCHED_SOFTIRQ context.
Since the optimization mentioned above overloads the interpretation of
TIF_NEED_RESCHED, check for idle_cpu() before going with the existing
need_resched() check which can catch a genuine task wakeup on an idle
CPU processing SCHED_SOFTIRQ from do_softirq_post_smp_call_flush(), as
well as the case where ksoftirqd needs to be preempted as a result of
new task wakeup or slice expiry.

In case of PREEMPT_RT or threadirqs, although the idle load balancing
may be inhibited in some cases on the ilb CPU, the fact that ksoftirqd
is the only fair task going back to sleep will trigger a newidle balance
on the CPU which will alleviate some imbalance if it exists if idle
balance fails to do so.

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v4..v5:

- New patch. Add some details on implication of threadirqs on idle load
  balance and how newidle balance helps those cases.
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 225b31aaee55..fe6db479a855 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12564,7 +12564,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 		 * work being done for other CPUs. Next load
 		 * balancing owner will pick it up.
 		 */
-		if (need_resched()) {
+		if (!idle_cpu(this_cpu) && need_resched()) {
 			if (flags & NOHZ_STATS_KICK)
 				has_blocked_load = true;
 			if (flags & NOHZ_NEXT_KICK)
-- 
2.34.1

