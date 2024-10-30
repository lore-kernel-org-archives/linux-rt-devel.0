Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5B85931
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Oct 2024 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273075; cv=fail; b=i//NEwu/jRuRnsA9uZexBsqSnhhen2qw75gAxMeqaWPDC6vMTKSgDpbQwobo6AsG1VKrW9DrYhbDmLv7OPVx2HNbtSUZ2DB4QYzW6iJuA6b0szwn3UQxlY33N0UYeWAnGW+ssxc/9kVWRrZicBTqRERRspTzxaT//T9lRETum2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273075; c=relaxed/simple;
	bh=ivAkjxRInKCrJijX6z2QgcNwgOBTlXg4OaSIz++RegA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Djbpk1b52FfsbZU84Z8YiPvhe1R0azKlnB1TtPmZwR6Kld9XXS39OFDbT5KS3EoMrjh6BHQUo4bjW2XhZbRkIMXwl+Bi1UtMxx7FYM17u9is2SbIHUiDtP0VJhd3OUR+1ud4GCXgtoLWrS/bBGvJkhvxgYx0s3eW5nD5YS3mCMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZsftkYoy; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZsftkYoy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMG0xyCMrUflifS8DeZJQe9UVl8f2Pd+Dfyn5ZxVJgo9Fi0wrN/4w0T67WbTlyhwx5ogx8eMRRpL0oFZwKH2Hn2fY01bv8+XpzVbp9sWHe3L5BSiuxW53rF8UHmgF/gntLyKMPgsD6nFCwvvalNnn4/lPjTXb/1ZeqzVwOyYZIuY4HSiyQd+aumiRv6d+6//4d9jbpO07ZM0NrihiUBVHsPSL8ipxeRFB8MLB6Pi9G0ftYo9oBRBXvgKVLgmbR6IbXxsda9HNrLH5HJPwWZKpJXu7qt/KCQNEzugKb6/3o5MSTCPeke3thiQx6NRHmZu6sv3zzFZKIcd939D1VxWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiPGwGdlnV+mXmiNMMmzO3h6RM4D8jANcceN+D0b71Y=;
 b=QVg3l4UbFN6xGJ+HkIuIhDz1uV3A6JX6KwDhU9xB6V9BAOsrDQo7SCZZtACCR4In/zsBj9wCGQ+Z9hKz1nVPsvyuXOncoxbymuSyPvwf1Fq6FoTcHhoha8iT3MYm9M1FZ1CtedKHL5MGFm7yaHYOxYcj4gNuCdGLeEayV2mKeYn7KZF2Q1p0i1b2oOrsxlmWnSgx5TyjzXXvl8QrHzALRMQ/afVNEW6UMNBkAMJjUZU94U9DQeQFnmLyBnHeYFHNZ94/luDJCoUDlEiTVMzDxn7PDmABWzFOgAsBe3EKZFYgQrUbzQ6W9GUKmSki/djh8mjyV9+NJ4HvxKed6dUr4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiPGwGdlnV+mXmiNMMmzO3h6RM4D8jANcceN+D0b71Y=;
 b=ZsftkYoyDP1w9RIFN0Z88AKcnv4kOs9+YjNneC06wkujWY3eejIp0aPHfbEzDrykZm76aAsetPw+2CENDc6GbOAy2puYB2N1sdvb+ZU8dwHo26xIzyKso+/yK2AVh9GbltFnyAVCPLebNJ8IXqjg+WPRWV3ymh0nAKN01fEA+9M=
Received: from CY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:930:10::25)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 07:24:25 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::ed) by CY5PR16CA0028.outlook.office365.com
 (2603:10b6:930:10::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Wed, 30 Oct 2024 07:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 07:24:24 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 02:18:37 -0500
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
	<tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.de>,
	Zqiang <qiang.zhang1211@gmail.com>, Caleb Sander Mateos
	<csander@purestorage.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH v4 1/3] softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel
Date: Wed, 30 Oct 2024 07:15:55 +0000
Message-ID: <20241030071557.1422-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241030071557.1422-1-kprateek.nayak@amd.com>
References: <20241030071557.1422-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 538c9f4c-e133-4eff-2673-08dcf8b3e191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B/AUKmx2SvYOq5cjzg5ux1KdldXb14KJmhLNr4I2DSJbL7nbpm7L5dmsFuYn?=
 =?us-ascii?Q?e34SHtO7vxVdXnI1uezF5gnw3Gus+5JOyhRIqsxO5EvdfTsHLe8zn5MN9vkA?=
 =?us-ascii?Q?xsYYcwdoaWZmOjftKO1RgPCfhtRUfEXN17E64PMkeXRtdw82PKgPi1VBb0Q/?=
 =?us-ascii?Q?B1iUkjiDZf/+aG9A/b/Jzr1rdBgbodgjNvepyNV9ZwpTyTM5fuK3p2D57q+n?=
 =?us-ascii?Q?IA9eDLlixiDRx0jPYUTQAsqsFp4P/Z9ZjiNDvAKpcVZ+9Tn08WoR62dxcqfx?=
 =?us-ascii?Q?GcqpTHJ8t/KBNWW/lqwhMgsfCtVD1oNPOcN0Ddt8SEIkt0exZVFoCf7HFuto?=
 =?us-ascii?Q?RNY9v/QmGFPP4PeXcQ3LTg3AlRelPDvFHfp/AbalIo+i3tS63G2/VNoHoUbS?=
 =?us-ascii?Q?8tq2K7Icpa/01BQ93Ut5G6IEsL7d1uMqMDaR0Io5urJfBU/LzG8ahVQNxlH4?=
 =?us-ascii?Q?TBXe/dLgwsallpM37QJGvzaI1Vv28SUhABsN4L4iLdki9v7epBThV9avKfLC?=
 =?us-ascii?Q?FINp35+MbShpOvfH0jmVsop47HMM7Zuw4R/WAZOfP3eTWKRFwJzTPhGy8zZT?=
 =?us-ascii?Q?XUTMpx248/EieumjGAvn6FqBS80wPeJYvl16oJPe+6Us6NXBU6skAIwzLiNT?=
 =?us-ascii?Q?SvktB0/iAxTXLNilz6DV/J4B7LFZJ5UceRFrkvK3VUbYFEyTxmmgUlCZLiUg?=
 =?us-ascii?Q?nWUiZ+72vHUsF1hdW5YLRqC28/s6pSAsWEQ/hKmwxudwMBzJ5EvheTL3yalQ?=
 =?us-ascii?Q?YA43Mrx+I8lkiLNmEQ7DZFiFuKrjC8igGXZBCVirJoUuB+/xtM5YIZoIUXVU?=
 =?us-ascii?Q?c+opzWhHEvtUslVjyL+/fsKISvrrNcigrpgMarWGvZU0GMSx5r8BxCbcYQ4j?=
 =?us-ascii?Q?QzOZ5Y+cdOsFHV38livmuOBhtxcesB6Y3ltmXfRWYIMkZQwhURFy7dU1beeO?=
 =?us-ascii?Q?Me+gt4grdkCnusTyo/AxDsY9Sk3Jr+lrzEk/VfKe3PbLbtsfX2cl04WaLPt5?=
 =?us-ascii?Q?zoKvfen9exRuM6YW7qH+y/zPp1KkWbJIwyVwz4tqxB9SbCMgbqShUA6JSYkd?=
 =?us-ascii?Q?TT1MLI9rDb0iDBqpldUfVkuRiVP3YgQp6abwGoQM87mDPw7tbvVCBpUB54OZ?=
 =?us-ascii?Q?wg+VRI9AkLJosEhhU1R0Qj3fcI/PbRykssbfZiaF6aRWDtk4DP+Jh3il7Ybc?=
 =?us-ascii?Q?x2yUNHdjVzPMoIzhU9FrsyiuYST3G5RtsQWeIehQllKSZcNzs0s3pm3L2nPE?=
 =?us-ascii?Q?TMMAW+vP2A3doWSc3DHkFwWdfWE+jl0I9nuhmKxSmLjQcRuCaGKg5HZoFPjL?=
 =?us-ascii?Q?Z1/zweWNCBd2iKsh/rH96eX3Nm4ipsQ56kg/YG8H37SFoCCUW2rKO6BnQu3Q?=
 =?us-ascii?Q?2QYFM8ZkK8jpIK9HQ8KtljdherWY4YahW1UQS5OvS/xtm3gHzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 07:24:24.5269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538c9f4c-e133-4eff-2673-08dcf8b3e191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

do_softirq_post_smp_call_flush() on PREEMPT_RT kernels carries a
WARN_ON_ONCE() for any SOFTIRQ being raised from an SMP-call-function.
Since do_softirq_post_smp_call_flush() is called with preempt disabled,
raising a SOFTIRQ during flush_smp_call_function_queue() can lead to
longer preempt disabled sections.

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") IPIs to an idle CPU in
TIF_POLLING_NRFLAG mode can be optimized out by instead setting
TIF_NEED_RESCHED bit in idle task's thread_info and relying on the
flush_smp_call_function_queue() in the idle-exit path to run the
SMP-call-function.

To trigger an idle load balancing, the scheduler queues
nohz_csd_function() responsible for triggering an idle load balancing on
a target nohz idle CPU and sends an IPI. Only now, this IPI is optimized
out and the SMP-call-function is executed from
flush_smp_call_function_queue() in do_idle() which can raise a
SCHED_SOFTIRQ to trigger the balancing.

So far, this went undetected since, the need_resched() check in
nohz_csd_function() would make it bail out of idle load balancing early
as the idle thread does not clear TIF_POLLING_NRFLAG before calling
flush_smp_call_function_queue(). The need_resched() check was added with
the intent to catch a new task wakeup, however, it has recently
discovered to be unnecessary and will be removed soon. As such,
nohz_csd_function() will raise a SCHED_SOFTIRQ from
flush_smp_call_function_queue() to trigger an idle load balance on an
idle target.

nohz_csd_function() bails out early if "idle_cpu()" check for the
target CPU returns false and should not delay a newly woken up task from
running. Account for this and prevent a WARN_ON_ONCE() when
SCHED_SOFTIRQ is raised from flush_smp_call_function_queue().

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v3..v4:

o No changes.
---
 kernel/softirq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index b756d6b3fd09..d89be0affe46 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -280,17 +280,24 @@ static inline void invoke_softirq(void)
 		wakeup_softirqd();
 }
 
+#define SCHED_SOFTIRQ_MASK	BIT(SCHED_SOFTIRQ)
+
 /*
  * flush_smp_call_function_queue() can raise a soft interrupt in a function
- * call. On RT kernels this is undesired and the only known functionality
- * in the block layer which does this is disabled on RT. If soft interrupts
- * get raised which haven't been raised before the flush, warn so it can be
+ * call. On RT kernels this is undesired and the only known functionalities
+ * are in the block layer which is disabled on RT, and in the scheduler for
+ * idle load balancing. If soft interrupts get raised which haven't been
+ * raised before the flush, warn if it is not a SCHED_SOFTIRQ so it can be
  * investigated.
  */
 void do_softirq_post_smp_call_flush(unsigned int was_pending)
 {
-	if (WARN_ON_ONCE(was_pending != local_softirq_pending()))
+	unsigned int is_pending = local_softirq_pending();
+
+	if (unlikely(was_pending != is_pending)) {
+		WARN_ON_ONCE(was_pending != (is_pending & ~SCHED_SOFTIRQ_MASK));
 		invoke_softirq();
+	}
 }
 
 #else /* CONFIG_PREEMPT_RT */
-- 
2.34.1

