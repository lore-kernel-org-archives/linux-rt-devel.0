Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8714B945
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Nov 2024 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731995116; cv=fail; b=qtBRJfPy1dONYOm3+yPt/gQcobeXM5qB5w6fRS+8YyBTXmtD8Wm9Ba4nxRRqJZuGYRVToIG3liyoWsd5zLn7norPH1pOKMEILb0upnQ9RGWZrpwh54D0I8/JUUXffzMLAsnpS0o8FnymOr2DhgX2ruhvWU2nIqZNOBWKUrUK1IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731995116; c=relaxed/simple;
	bh=NvfdD13FXBIn9W9vCLjDQooZjd7O+lCkzQ03b/5XHiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pgmp0cu83Vm3SgFK/JVRwymFU6i8S/ziXFcxqhJMNyqkfvowfR0D0tkN01gdIma87kE4c/rZ/OwAID5Bo9gTEHbiRdbpziz5NK5RpS7nokGsIZ61DN51kU09CZBgxoDHs2MIcgA6ZGiQ2j/2YsYpEEYo8lBThakD57M4+AVvk1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xiBvEiqK; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xiBvEiqK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAGUTmESuRFDbuAUt5dbWowPNFtK3NB9TM9p9jrQ7P8UQYM1Hv714FIZkLlXGNPr4y4Rifc0OKAVJq0vFBzS+wHoH9G2ZfVjxinMyi3kMfKjH2TmJK/JWV20MCU3lTiJd/ZrI4v1TkqK/7culgX0Bll/+VmAh/yZLJ1AjtqG/j8hV5C85Br82pN8az9/yIfWEGk0AzjcAq5GpxTyGbSdoH3j1E2axw5QriaD4QezNf5ua3Uuno8YYiXs2B+vhqNJWSlunZbxHG/I+q/enJRMX3jgHCEGhceSVAX8+G+bG9qDQavsi1BMsnI++8ktDVvxVCObd3VQ8cy1WHmfhAQw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq3KQ0DIfJbjbunTTs1DC/IYbEaojIfXvZ4R4dEbRpk=;
 b=S4lcoN+YUg4YjjrJVaM2NTZxOqumgcxhquQHIHYxnnT9g5CmzGnu/ImhpaS0Ie9wPoQbxBPhPpGMunA5HNxuccXi2jgHmWBKjWrMmB4d6WBaHHraoxouzT0a1svEdrAFs5JinX2bC03yrELKcRr9NTb8z6z6dM/Mi56w2wlF/j2UJl8HVwSCNcIPGg/odmhhweMU79AV5MTdCGRaMtOFEu3kpkI2sf5yMh1b1x1LPn74HOWVJvMmQzKxbq0vR0/QodaMyNuWbRkARMZrSOi+u2eCqxX/MScoENM3h8bgK2cyXGcFPKaVdhRRKIs44kMwVKfig12/kjbjXKycuxPp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq3KQ0DIfJbjbunTTs1DC/IYbEaojIfXvZ4R4dEbRpk=;
 b=xiBvEiqKzf6FQhgWTbHvQIby6/fCV4zyhiOjtfhMCqc/p/aiqNlIMf3+Sw9AgOeBRw51QAeU2UECYIQug+JRi6k6gjm0EOJ30n5EwzRIUqZNaAuGGWIdWNYMBjJmPd6uVhboAVCrzUAmmpRabBKPKee27/9ToYWkYrMXQX8MIc4=
Received: from SJ0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:a03:3a1::24)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.20; Tue, 19 Nov 2024 05:45:07 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ad) by SJ0PR03CA0379.outlook.office365.com
 (2603:10b6:a03:3a1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 05:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 05:45:06 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 23:44:59 -0600
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
Subject: [PATCH v5 1/4] softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel
Date: Tue, 19 Nov 2024 05:44:29 +0000
Message-ID: <20241119054432.6405-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: b3aee976-1433-445f-f939-08dd085d52d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s0U3NAu/yDD85WRFaoedgK/51LDl/ikveC7908qaLsStcR6JM52vx1X8SV3x?=
 =?us-ascii?Q?kggutFcSE53Nw6j4a7ujBYCu1XYonAjtQCTd6ibqduYmoDAJNg+Sv8bdKRDk?=
 =?us-ascii?Q?eZ358fpFvl8jMw+LM0yjVMrYahPmpFE8bwnKu92O2YjgfFEo6imU58eLeB/j?=
 =?us-ascii?Q?a+in8vu4uvve/PI6UTUiqRqZrGEOHiCnJ2AYFSMBfFn/h4FXmIjYiad4JWFA?=
 =?us-ascii?Q?eBNFIVP9uv5PGfKi0IUfmV6bZXFXK9O28hadaHQ23tmtT4jUkG1uhF6Bvbzg?=
 =?us-ascii?Q?rZJ74LcEZizR/YpyT2Q9z6nHOpfIZKXgyBvS8RsQPHfwNTsemzpDOPK8rd8K?=
 =?us-ascii?Q?dot9iNDguapoBmylIyFawQFdV9rczQuzT0K+ziTH8FPrNCMgzDVcN6XR3mhg?=
 =?us-ascii?Q?6Pf6ShL9OwYC77aawenU0Uto699LdOz0GnS+KHM2LH2n+9J6NoEQFky35yan?=
 =?us-ascii?Q?jM5phiXDEmLMWNlwTmiXKfi5wvy4lb8cx0XWF+92f2uMeeKijRzCsdXW4v4g?=
 =?us-ascii?Q?vXZeBV+axaBy+5qJDYHbG63Qm67ngJ+SjZ8RJ3boHY41YiaVHEurphoIjihw?=
 =?us-ascii?Q?y+VcCYaxKR0Ts6DDtppDFsaXC8oqh81C4Dl7jYnvOYtGk84y5Oepx0LGBMKZ?=
 =?us-ascii?Q?AW9m2cgjwty9LDMLj+lA4/JvnHvhv/TvYWtOPJzw3X89ckh5bmGq6HNm5UNX?=
 =?us-ascii?Q?jICyHbp+3VKbKId2WgdBOjlayBk3aRywzLZ5cyJOaxZzpX3sxrcUfTjC9/UN?=
 =?us-ascii?Q?av90CT/0zM/l4GWC2m1ADbrNLfnPVvN1xRxtdYwX0q4bizSjp6hxFwEQQNyS?=
 =?us-ascii?Q?9RjLmj2CXUD6/3ykWrzvvqj9ZkjqUVou3wtxBJ/oeEJTnygP8YSdM8nxwY2r?=
 =?us-ascii?Q?15tFrutYAFhEE6+1JE0SmeV/Z2lUoUZFg/732eh7bgExTbL/WID6StINOenB?=
 =?us-ascii?Q?h5b4fO/6AplljSo9Y8PN5J4zImzaMMJlwRcZOC2znEsMzikd/u46qHOFbUYo?=
 =?us-ascii?Q?F6hGiFCsRZ0lEs1n7kB1fHg9kLemahVOLV52TvC5yI/N2Ckqjawej15r1hhG?=
 =?us-ascii?Q?UZ76C0oOnxrfKgzNZ0+y02LCM1gr2TrqI/eh/87WDZhnk5s5oZij3te9Z2ZF?=
 =?us-ascii?Q?Q+QGRfugtEB4onu0t2G9ZwNCjinvuG+FCZEPnO4mESGfF68TsTHRZF0br041?=
 =?us-ascii?Q?ioewMK+pQ5a5eEtv9tlMeLE7GI5n5YuPyqmdEwbikCWU0q6h88KkJN9boAlg?=
 =?us-ascii?Q?5CHW8XN+KX3ppgPLs06mIQwYW/0Vn2ITwmOQKdfAZh088AQnyvxFhg4Row2U?=
 =?us-ascii?Q?gm/g7ktFIVlehBZq4v73sefy8alI7EuxdBprjhyCHSOK3ciFXj8Ebksln2pS?=
 =?us-ascii?Q?9OnFsZUFmSBfPsKc0hOeD+EFNi2R5wp38xsqqWP8Msk/sWkJ9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 05:45:06.9535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3aee976-1433-445f-f939-08dd085d52d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592

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
discovered to be unnecessary and will be removed in the subsequent
commit after which nohz_csd_function() can raise a SCHED_SOFTIRQ from
flush_smp_call_function_queue() to trigger an idle load balance on an
idle target in TIF_POLLING_NRFLAG mode.

nohz_csd_function() bails out early if "idle_cpu()" check for the
target CPU, and does not lock the target CPU's rq until the very end,
once it has found tasks to run on the CPU and will not inhibit the
wakeup of, or running of a newly woken up higher priority task. Account
for this and prevent a WARN_ON_ONCE() when SCHED_SOFTIRQ is raised from
flush_smp_call_function_queue().

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v4..v5:

- More clarification in the commit log around idle load balancing (last
  paragraph)
---
 kernel/softirq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7b525c904462..03248ca887b5 100644
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

