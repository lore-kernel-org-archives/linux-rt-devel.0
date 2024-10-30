Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417F1D3578
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Oct 2024 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272759; cv=fail; b=rg3jljoO18PZZSDkahaYzpdvJESxLMwJW8tzA+mq2GsQeP//iQ1ZzJP7SVhZD3OXecKlL8rtdRlsQz6TX/CzIyATenZzpPoN+nkt5/K/dm/1vY2E6FH8dnxmUNz6/tZEeslCnEr7WGbhxWHSEpbAfAhJ/Z5VpsYM1ogcRQhBKCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272759; c=relaxed/simple;
	bh=ZoR16uCTdvEq3ak0oSRRZfrGJA+3hLmg0GMZNHhzIgs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JIOd8TWqmRfsqMgAPY+gf+QvQaSIyTfojD1F1ESnRXVEmMRf+6glfbNBfon3L3svUlP6Qk0AiaCtkRdlHz2B11GUBvgZ54XS8Tla8Kfh3NJ8lfsAj4LBQ/rUJYeIA+4bqq6SaMDv2mJn6yRS8sbQenQ5qSYGXVFPPcJzudf5otA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qeixl5NB; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qeixl5NB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqUIUMcdMEyuNWKD/tMwILdm1B03CeFxwFgv+pbdOrMsj20IwG2vA534N7VirAy3H+4vcey+tOu4Qgh93XqNeB/F4Ty37vuklKSCXjXzaU29HWU4mB+lD+BqytXH2ptSm3GMmngUPzRJeCdGunItQ5Wu8gFUkjey93HzXHzHzw1S84cuXUOwtWI0MATxVUaqtUfWhFh/4lx+CPafdYb059+TDhlH8WbnB3tcl7q/koOQdfBgKDxXzFxVooDa6IRvxtmqQ6jVRK7zRfxnLJDGDop3PJ9Lb1sC1rZ2Dhwq4prJRH0GRMEPwdWsvb/clzyf+DxD2yC1gmZvxM7H9O08uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqJsQ5e6cTzIcpcueL1IrD6brXjOY8jD4Cnyj5tswzY=;
 b=WPJ1m37UOTm8Sn4+NkFxT2NL+JEmmlF7y9CNCBssEMDEoKl+yFVZymVbBhw+vjJV7d9Ct+XQptjiJ20DFd+1rDnKRCnO7c/fKKTIJ3nibfBOsRFzR/H7+6169KeNWN3AE+qMnyVZQ9JGAlBjTsnGVAitfYez60cUE/L4G2Be7i+5kG/vbz0Wz/0LPPtTL6GygjCILMK4AKLTYlBQWqjK/plDGtct12/9/g4eplvEs0PRNdebkgLB+A6uFFpYc6M8NoDuWvjLDGCmvKH8bZCYe+MUn1b0lZ9HFnDcnZyPFfqaGze0p0Y07oJ0G0bwPXnutHvJ6iRT8mDakjdeNVev6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqJsQ5e6cTzIcpcueL1IrD6brXjOY8jD4Cnyj5tswzY=;
 b=qeixl5NBcwbr1dy6q3ZVXkHmKNXWptUy57gBO4NlOU+AMiTVqZ91d+4UVZcVCqOXVrhZDESUAmIiZ5g5defhQ+5nm1FkvsUEiNBdQ/SEDH/j2+8zj7sTLNFu79O2zIrVwBO8e8xEmWOBPyiuSqJz0x3kr2VeEJHkcHT43BsTbSc=
Received: from PH7P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::12)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 07:19:09 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::4a) by PH7P221CA0029.outlook.office365.com
 (2603:10b6:510:32a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 07:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 07:19:09 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 02:16:37 -0500
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
Subject: [PATCH v4 0/3] [PATCH v3 0/5] Idle Load Balance fixes and softirq enhancements
Date: Wed, 30 Oct 2024 07:15:54 +0000
Message-ID: <20241030071557.1422-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a4366b-2956-4c5c-c4d4-08dcf8b3259f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7K083E+G8yJh0X1I65+Y3BMA235y3W70ypXnZdc3Can5NsiFDWJqYHMe0tqe?=
 =?us-ascii?Q?n9QphJb3vzZm5TrZSTczVE2WV/67M+Yz/kDV1aJ8lDeFMigr49BU5QZ6xmxP?=
 =?us-ascii?Q?2Y9G3S/Y3UWnScGtJ6dqJH5s7dfGsYuN12NJFhXEw3uZY6AP4DFSC4OzK8sx?=
 =?us-ascii?Q?X76tdAqRyvoQRN1P+afE8bnAoOfH7E+iJ1a4SDEIUe2/ecK0/K7cnSpbxMjb?=
 =?us-ascii?Q?B1M7ktt5upFKJtAlffYpt6WiDtIEziDEs2kpx69G+r46v58+Ie8yCEniQfc6?=
 =?us-ascii?Q?bWJgaOfcMbSSYXPLLQQyvromM23SQuyH0Xi/K9wsyMt3vMnueUJFoMY/VxdS?=
 =?us-ascii?Q?VSnqpMHp8VGZJqfh2Fsk4U0o++oNoHiJt14QTHfJXwKspwpWtJWSUfXfz9dU?=
 =?us-ascii?Q?toof7ghuAoOzxY8/aVWjsE0ZL633MLpNyajmrSC4ahexh1+nrShPciA3GZfL?=
 =?us-ascii?Q?A9dJKmiv2s6MxB0EA59pByapJoCvMfXME6xgt256ApORqO2sEOiIfVRdqC47?=
 =?us-ascii?Q?dRtzk4OT/ODnf69xv++YSLKQLawAgbV3/a8ACkKjL3DHAjHwYQNHOrf+PO6j?=
 =?us-ascii?Q?vjk4Ug/2wxPb6aa4m9UnQD7y6E2f7c6q0Rwy5uNDSwtjsN7orBfAjaYR5dPV?=
 =?us-ascii?Q?NRUwV5Gi/tQSMZM2HXN+aWzqQ9lpZbBK7wKCRaX1ZHMwF7paGzCnUjfrMBE/?=
 =?us-ascii?Q?AG8qhceWpSyDj+Lioepjy1FDFqhnVB69mbEaYO60sORnoAXIxTh9A+khF+/e?=
 =?us-ascii?Q?JASaMhRTdV2wg8OsUCIbAsTQXiMhu6VaQfZiwDNEiYx3tzBG9IXBe9SA61Dv?=
 =?us-ascii?Q?XW57FJ8f27Quru5JN+h91vvWUfqdTb42490PYMrDSWXIxTSSkb1UukcnGRCQ?=
 =?us-ascii?Q?Wd9kZed06IGGArHuO6BaqczI+oBg7k+u9kEO1e/kEDrbcofwkXSOFMXqCaZC?=
 =?us-ascii?Q?Q4yGUae01MQNBcX/DG9XCy3aZGGqr6PTasOpQzop8R/D+4Uw8Z/6O3ym/QLD?=
 =?us-ascii?Q?IQ4ICHZXOl17gnc0dVWX62C1H4cBKNjycSzbYRiHFyqv9h9U0+OtI0Ucz/MY?=
 =?us-ascii?Q?VvSKPyPzEdSt7YKyqZTNzB3ju9pivr5Cbii+0nf1G9xF3/FiW7UFhmcYNkKB?=
 =?us-ascii?Q?wI4FHdJHYerc23hyz3izGTpw5ZKdaR3dVAsbf4VveXL3Dk6Y9DbxQBHRMNQw?=
 =?us-ascii?Q?nau4yTr26hISFGb2pX32ZLMH8dEYsKTOd1aKCb0G0xLdgFgOoU2t7LJaR9pX?=
 =?us-ascii?Q?J09QtFYkAbfBTG4nB9+R8bbcBmPKoNw3UXmdaNcr4tJCZ6Xyrz3moCaw0vo8?=
 =?us-ascii?Q?ad6a06IU9fxnEDSok6IhtSQTLzvIv54hJ7Up6NkHkzlfy13X+8Ep0etj/3YX?=
 =?us-ascii?Q?NAXLIJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 07:19:09.1798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a4366b-2956-4c5c-c4d4-08dcf8b3259f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171

Hello everyone,

This is the forth version with minor changes from the last, and some
more benchmarking data down below. Any and all feedback is highly
appreciated.

This series is based on:

    git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

at commit 1a6151017ee5 ("sched: psi: pass enqueue/dequeue flags to psi
callbacks directly")

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()"), an idle CPU in TIF_POLLING_NRFLAG can
be pulled out of idle by setting TIF_NEED_RESCHED instead of sending an
actual IPI. This affects at least three scenarios that have been
described below:

1. A need_resched() check within a call function does not necessarily
   indicate a task wakeup since a CPU intending to send an IPI to an
   idle target in TIF_POLLING_NRFLAG mode can simply queue the
   SMP-call-function and set the TIF_NEED_RESCHED flag to pull the
   polling target out of idle. The SMP-call-function will be executed by
   flush_smp_call_function_queue() on the idle-exit path. On x86, where
   mwait_idle_with_hints() sets TIF_POLLING_NRFLAG for long idling,
   this leads to idle load balancer bailing out early since
   need_resched() check in nohz_csd_func() returns true in most
   instances.

2. A TIF_POLLING_NRFLAG idling CPU woken up to process an IPI will end
   up calling schedule() even in cases where the call function does not
   wake up a new task on the idle CPU, thus delaying the idle re-entry.

3. Julia Lawall reported a case where a softirq raised from a
   SMP-call-function on an idle CPU will wake up ksoftirqd since
   flush_smp_call_function_queue() executes in the idle thread's
   context. This can throw off the idle load balancer by making the idle
   CPU appear busy since ksoftirqd just woke on the said CPU [1].

Solution to (2.) was sent independently in [2] since it was not
dependent on the changes enclosed in this series which reworks some
PREEMPT_RT specific bits.

(1.) Was solved by dropping the need_resched() check in nohz_csd_func()
(please refer Patch 2/5 for the full version of the explanation) which
led to a splat on PREEMPT_RT kernels [3].

Since flush_smp_call_function_queue() and the following
do_softirq_post_smp_call_flush() runs with interrupts disabled, it is
not ideal for the IRQ handlers to raise a SOFTIRQ, prolonging the
preempt disabled section especially on PREEMPT_RT kernels. Patch 1 works
around this by allowing processing of SCHED_SOFTIRQ without raising a
warning since the idle load balancer has checkpoints to detect wakup of
tasks on the idle CPU in which case it immediately bails out of the load
balaning process and proceeds to call schedule()

With the above solution, problem discussed in (3.) is even more
prominent with idle load balancing waking up ksoftirqd to unnecessarily.
Previous versions attempted to solve this by introducing a per-cpu
variable to keep track on an impending call to do_softirq(). Sebastian
suggested using __raise_softirq_irqoff() for SCHED_SOFTIRQ since it
avoids wakeup of ksoftirqd and since SCHED_SOFTIRQ is being raised from
the IPI handler, it is guaranteed to be serviced on IRQ exit or via
do_softirq_post_smp_call_flush()

Chenyu had reported a regression when running a modified version of
ipistorm that performs a fixed set of IPIs between two CPUs on his
setup with the whole v1 applied. Since this version gets rid of the
per-CPU variable updates at flush_smp_call_function_queue() boundary,
the results from testing is identical to the base kernel.

Julia Lawall reported reduction in the number of load balancing attempts
on v6.11 based tip:sched/core at NUMA level. The issue was root-caused
to commit 3dcac251b066 ("sched/core: Introduce SM_IDLE and an idle
re-entry fast-path in __schedule()") which would skip the
newidle_balance() if schedule_idle() was called without any task wakeups
on the idle CPUs to favor a faster idle re-entry. To rule out any
surprises from this series in particular, I tested the bt.B.x benchmark
where she originally observed this behavior on. Following are the
numbers from a dual socket Intel Ice Lake Xeon server (2 x 32C/32T smt
off):

   ==================================================================
   Test          : bt.B.x (OMP variant)
   Units         : % improvement over base kernel in Mop/s throughput
   Interpretation: Higher is better
   ======================= Intel Ice Lake Xeon ======================
   kernel:						[pct imp]
   performance gov, boost off, idle=poll, smt off	  0.89%
   ==================================================================

I did not see any discernable difference with this one over the base
kernel.

[1] https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/
[2] https://lore.kernel.org/lkml/20240809092240.6921-1-kprateek.nayak@amd.com/
[3] https://lore.kernel.org/lkml/225e6d74-ed43-51dd-d1aa-c75c86dd58eb@amd.com/
[4] https://lore.kernel.org/lkml/20240710150557.GB27299@noisy.programming.kicks-ass.net/
---
v3..v4:

o Use __raise_softirq_irqoff() for SCHED_SOFTIRQ. (Sebastian)

o Updated benchmark numbers and reworded the cover letter.

v3: https://lore.kernel.org/lkml/20241014090339.2478-1-kprateek.nayak@amd.com/

v2..v3:

o Removed ifdefs around local_lock_t. (Peter)

o Reworded Patch 1 to add more details on raising SCHED_SOFTIRQ from
  flush_smp_call_function_queue() and why it should be okay on
  PREEMPT_RT.

o Updated the trace data in Patch 5.

o More benchmarking.

v2: https://lore.kernel.org/lkml/20240904111223.1035-1-kprateek.nayak@amd.com/

v1..v2:

o Broke the PREEMPT_RT unification and idle load balance fixes into
  separate series (this) and post the SM_IDLE fast-path enhancements
  separately.

o Worked around the splat on PREEMPT_RT kernel caused by raising
  SCHED_SOFTIRQ from nohz_csd_func() in context of
  flush_smp_call_function_queue() which is undesirable on PREEMPT_RT
  kernels. (Please refer to commit 1a90bfd22020 ("smp: Make softirq
  handling RT safe in flush_smp_call_function_queue()")

o Reuse softirq_ctrl::cnt from PREEMPT_RT to prevent unnecessary
  wakeups of ksoftirqd. (Peter)
  This unifies should_wakeup_ksoftirqd() and adds an interface to
  indicate an impending call to do_softirq (set_do_softirq_pending())
  and clear it just before fulfilling the promise
  (clr_do_softirq_pending()).

o More benchmarking.

v1: https://lore.kernel.org/lkml/20240710090210.41856-1-kprateek.nayak@amd.com/
--
K Prateek Nayak (3):
  softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT
    kernel
  sched/core: Remove the unnecessary need_resched() check in
    nohz_csd_func()
  sched/core: Prevent wakeup of ksoftirqd during idle load balance

 kernel/sched/core.c | 15 +++++++++++++--
 kernel/softirq.c    | 15 +++++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.34.1

