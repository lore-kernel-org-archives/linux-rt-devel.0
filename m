Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AE1EE7B7
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044020; cv=fail; b=JuIHrCUmvbbQDNDjXjKmKcioA/cui+cPJyZY2i5gwjeNPdUqQI3JCOnqFfK9/2HyNREznGtlZdLevjFN432nlfQphmGVpZqpy+j7wjcH8ITGJmQaLXSk3D5zTXOuGzsEv6frwaqBQu74vLlWhqzP1f9mj42PeGQ/ly64RkeVRZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044020; c=relaxed/simple;
	bh=653fmx49yV1YUJFJ8IuUtUIO6KklVupvE8TtpbpxGHg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uak5vTCVTS9/3AzeHAZopld1uG8Qw6eLG1kXZF9ZWTsPpuUnsdd3Olgsuzvmm7NT/m1IluRE7nUePawjpTEWRkHO13Wx6tuKoosTjMgpkedyClvCG74dglrneMS41DcKDPcXrOzni7rLgdTR1J9yDwZDdvSL5ofloR12REGL8es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=180iyNIQ; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="180iyNIQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAHZuIDUYiBfPMbIGxPbexgt98a7ae28aHCFjtQD68RRotrcKc9kKMDpCg+vzvTA45I6V/lw7JSBYG4E5FWa3A8i7OevIBtwavcaSE8AZYgD8OkoOfUPJVLGb9Sv7GEAzKsSMbrABpFurCRcaNyJervzHq/gAuaQi6WvN4UZLC62eMnBxkUjDfFxgWzTDRCux2xR0T7AqMYLJYVlcq6xVtjnpYeGFlmPFW9BfKMmVzKf5ftUGWkOEhMw1IMD47eEKUJeJL1YCHtYa+9rtms3AHD9CEdUU1KayyfyR1l5xQxxaOCXiBeVPjPA1/YjCf5r6lIY29nSzKfFklsG8nLZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHZ0DIK83kJzqWnrhkK//1MUlDKq5C5vTADCd9sU7oc=;
 b=rVQECZgD3b4jUcQtVUZKBkwLvLYquuAOTkEJVNmZEaosXYQLbWhiUAOX2YCIuGfDWlwRex3fYdFV24b2HK41mODgwwuIKrA196zgeE417bkeBByaANlGMN4YfihxPCa8QX1OxOz3Nw2v64ELbpH7NV/kx4Te3ORj1K71l8+dn3iuE2dC3u3TTAtz0nfYrgOIGQoWGqFI1coBuySuKxwp6QgSZZC8HJtkYNwuY+yD4B+jCCywxUOstVC2Zi8b2TrfC1PXfZuE8JwDGw1NXNr4NC5QTmR1o+9qWlhA0j7Qq3xaC4Tcc7r8hakbAiqEAo3GqbdeJAKHTu0uqX/OrbZFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHZ0DIK83kJzqWnrhkK//1MUlDKq5C5vTADCd9sU7oc=;
 b=180iyNIQITIHGyFrn0szZgmQ6QcBFvNZUua825jcWDuuYctlY3Ob2/BMFI/ciwBCS3pR7eIsSKJbCN3WnpTHUSA4ztwbEjTTrs8LXzQuicjH5lB9Hef8x5Ysq5KfHQHw1+hbOUuPCTsYifCf6TsbcQhDt3bwvjTYW0fnezTQV7k=
Received: from CH2PR19CA0021.namprd19.prod.outlook.com (2603:10b6:610:4d::31)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 09:33:24 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::82) by CH2PR19CA0021.outlook.office365.com
 (2603:10b6:610:4d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 09:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:33:24 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:33:15 -0600
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
Subject: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to user mode
Date: Thu, 20 Feb 2025 09:32:35 +0000
Message-ID: <20250220093257.9380-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 515b2566-e4cc-472e-846d-08dd51919f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KVedlqF4W/WYRfr5RAi2NbtXu/WUP09cyx35Op2tDyaE56j/33BV1xJtXdZo?=
 =?us-ascii?Q?bBIQOULMEdviVlAhaB9Oyhh+qLI5kjxZ9v4td1EOxEQYy/09YpdkkRSlA8pz?=
 =?us-ascii?Q?lrxZmZYARnwKUIewqytOttxsBA+zVx4PAjOajfmL2JKU0VocomEd68HKxkG/?=
 =?us-ascii?Q?B1TZbpxSbSWwbXikMgXuYVQLFuYS+xlh4y9+PL9rgNbW3r0ajZVNZ9SKOqmb?=
 =?us-ascii?Q?VSH+BaqV0oFVMBiSRFiatKkxJzwuoXwai2Myf/19U+obSZmiZORsKuBOhBSb?=
 =?us-ascii?Q?l0G06hQuqeMjJvKGin2R3vUqeAWQZ1hdXUZ4ome5pVohOUSDcz/vl7CVQCM0?=
 =?us-ascii?Q?hFiGlzIDU22n7zmrhoijf6pHkU26o+muGCvKfjXclYdfJggK/036EdbwIngy?=
 =?us-ascii?Q?FwdV0eOYv3iz8kfZRrgP3CanzRemsIWBj7K3Ri2JdezqN42i7M1LvbSr4vPu?=
 =?us-ascii?Q?ysJymOqf5eERpmepzW63AXG2kWoP4CInt4/tCpinhGSYpMwTBu9F2fczx/FO?=
 =?us-ascii?Q?NVRUFVEd0LGjvDLdOeLcA97LYq5lWFzuw8G6lV6F1An12zUofLo8NrcvFdzK?=
 =?us-ascii?Q?hqkzXsapqc2jSrp2lnM2zc5LYwecsCkzG7WXUiiBZoqC/mVAXYA6Gd/azZ2I?=
 =?us-ascii?Q?6uA5FeOPXt9HqoqtmCVTfVnKa878DMO9h5Nhnu/6IwLUlwSAm7tMPnxl8Aba?=
 =?us-ascii?Q?ubpVAwGTHA8Uxu6KmPH61IejWHdBRA2OaZr11X8lX18m2889Qsmfi8GzjfeD?=
 =?us-ascii?Q?dOJ3Jm5B9t26wD21TE9X2Ao6+NfGcGR8lBRtsEGn1pZm2QDkRUnxwo3YMJa9?=
 =?us-ascii?Q?EKdNhoHSFS9OSnWiMllCWTBQIVhZ4HcoW+K55qU1eWalwYZ1J4tmJM2BmrJo?=
 =?us-ascii?Q?aK5HU5U9wtQquoFCHRUXhnqYGyicy/6VNOFIBKON3hsc8I/Wj4LahDptwI4x?=
 =?us-ascii?Q?GTrqZtfwgF7WtSCHQIbVtBMK6P4A5IEvBMPWfi9SfVqereC9gpCRLGq1Fe3A?=
 =?us-ascii?Q?1vhGnLJeaBICkQ4asD7ryP86s0LAfF2oPGgVJ98ZeBjOl0R+JlB4fmp7aF+/?=
 =?us-ascii?Q?OKsXRxGIkJzMfPHqiJKsgOSBBJkrJcp/aR6Aoh1MeO01UxomWRXMQjP1qtSz?=
 =?us-ascii?Q?u1AwLXHs/wnP8yRijZbm8XJQSw/IlZGGxJ0fX1ZSUmImaSl5jxbnorY4cqo1?=
 =?us-ascii?Q?ipcNb+Z3gkr1FuhcEiu74fQ1o67sjxiY3T40BU95if54AjSAoqNr/9zFC+h9?=
 =?us-ascii?Q?ZDir0TqD5KsePpX5NBtzOOQnsLyj7lLrU15La6scsZgfC5QU5foY0GKBbaR6?=
 =?us-ascii?Q?m/x5xoCPgYJ5U4Y1jjkNwD+Qyu40B08hhIu7avPznNrXn5FGHtMVS16eqhdb?=
 =?us-ascii?Q?P6OQuQPq0nQKOjq259w5/xnuA59CJlRF2v8hwmdOkjSdTX7k51HxyDF1+D/D?=
 =?us-ascii?Q?kdAgL1LCH4GMJzyv5RVQF1yMaaY22r7u?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:33:24.2902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 515b2566-e4cc-472e-846d-08dd51919f77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250

Hello everyone,

tl;dr

This is a spiritual successor to Valentin's series to defer CFS throttle
to user entry [1] however this does things differently: Instead of
moving to a per-task throttling, this retains the throttling at cfs_rq
level while tracking the tasks preempted in kernel mode queued on the
cfs_rq.

On a throttled hierarchy, only the kernel mode preempted entities are
considered runnable and the pick_task_fair() will only select among these
entities in EEVDF fashion using a min-heap approach (Patch 6-8)

This is an early prototype with few issues (please see "Broken bits and
disclaimer" section) however I'm putting it out to get some early
feedback.

This series is based on

    git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

at commit d34e798094ca ("sched/fair: Refactor can_migrate_task() to
elimate looping")

With that quick tl;dr sorted, let us jump right into it

Problem statement
=================

Following are Valentin's words taken from [1] with few changes to the
reference commits now that PREEMPT_RT has landed upstream:

CFS tasks can end up throttled while holding locks that other,
non-throttled tasks are blocking on.

For !PREEMPT_RT, this can be a source of latency due to the throttling
causing a resource acquisition denial.

For PREEMPT_RT, this is worse and can lead to a deadlock:
o A CFS task p0 gets throttled while holding read_lock(&lock)
o A task p1 blocks on write_lock(&lock), making further readers enter
  the slowpath
o A ktimers or ksoftirqd task blocks on read_lock(&lock)

If the cfs_bandwidth.period_timer to replenish p0's runtime is enqueued
on the same CPU as one where ktimers/ksoftirqd is blocked on
read_lock(&lock), this creates a circular dependency.

This has been observed to happen with:
o fs/eventpoll.c::ep->lock
o net/netlink/af_netlink.c::nl_table_lock (after hand-fixing the above)
but can trigger with any rwlock that can be acquired in both process and
softirq contexts.

For PREEMPT_RT, the upstream kernel added commit 49a17639508c ("softirq:
Use a dedicated thread for timer wakeups on PREEMPT_RT.") which helped
this scenario for non-rwlock locks by ensuring the throttled task would
get PI'd to FIFO1 (ktimers' default priority). Unfortunately, rwlocks
cannot sanely do PI as they allow multiple readers.

Throttle deferral was discussed at OSPM'24 [2] and at LPC'24 [3] with
recordings for both available on Youtube.

Proposed approach
=================

This approach builds on Ben Segall's proposal in [4] which marked the
task in schedule() when exiting to usermode by setting
"in_return_to_user" flag except this prototype takes it a step ahead and
marks a "kernel critical section" within the syscall boundary using a
per-task "kernel_cs_count".

The rationale behind this approach is that the task can only hold
kernel resources when running in kernel mode in preemptible context. In
this POC, the entire syscall boundary is marked as a kernel critical
section but in the future, the API can be used to mark fine grained
boundaries like between an up_read(), down_read() or up_write(),
down_write() pair.

Within a kernel critical section, throttling events are deferred until
the task's "kernel_cs_count" hits 0. Currently this count is an integer
to catch any cases where the count turns negative as a result of
oversights on my part but this could be changed to a preempt count like
mechanism to request a resched.

            cfs_rq throttled               picked again
		  v                              v

    ----|*********| (preempted by tick / wakeup) |***********| (full throttle)

        ^                                                    ^
critical section   cfs_rq is throttled partially     critical section
      entry           since the task is still              exit
                  runnable as it was preempted in
                      kernel critical section

The EEVDF infrastructure is extended to tracks the avg_vruntime and the
avg_load of only those entities preempted in kernel mode. When a cfs_rq
is throttled, it uses these metrics to select among the kernel mode
preempted tasks and running them till they exit to user mode.
pick_eevdf() is made aware that it is operating on a throttled hierarchy
to only select among these tasks that were preempted in kernel mode (and
the sched entities of cfs_rq that lead to them). When a throttled
entity's "kernel_cs_count" hits 0, the entire hierarchy is frozen but
the hierarchy remains accessible for picking until that point.

          root
        /     \
       A       B * (throttled)
      ...    / | \
            0  1* 2*

    (*) Preempted in kernel mode

  o avg_kcs_vruntime = entity_key(1) * load(1) + entity_key(2) * load(2)
  o avg_kcs_load = load(1) + load(2)

  o throttled_vruntime_eligible:

      entity preempted in kernel mode &&
      entity_key(<>) * avg_kcs_load <= avg_kcs_vruntime

  o rbtree is augmented with a "min_kcs_vruntime" field in sched entity
    that propagates the smallest vruntime of the all the entities in
    the subtree that are preempted in kernel mode. If they were
    executing in usermode when preempted, this will be set to LLONG_MAX.

    This is used to construct a min-heap and select through the
    entities. Consider rbtree of B to look like:

         1*
       /   \
      2*    0

      min_kcs_vruntime = (se_in_kernel()) ? se->vruntime : LLONG_MAX:
      min_kcs_vruntime = min(se->min_kcs_vruntime,
                             __node_2_se(rb_left)->min_kcs_vruntime,
                             __node_2_se(rb_right)->min_kcs_vruntime);

   pick_eevdf() uses the min_kcs_vruntime on the virtual deadline sorted
   tree to first check the left subtree for eligibility, then the node
   itself, and then the right subtree.

With proactive tracking, throttle deferral can retain throttling at per
cfs_rq granularity instead of moving to a per-task model.

On the throttling side, a third throttle state is introduced
CFS_THROTTLED_PARTIAL which indicates that the cfs_rq has run out of its
bandwidth but contains runnable (kernel mode preempted) entities. A
partially throttled cfs_rq is added to the throttled list so it can be
unthrottled in a timely manner during distribution making all the tasks
queued on it runnable again. Throttle status can be promoted or demoted
depending on whether a kernel mode preempted tasks exits to user mode,
blocks, or wakes up on the hierarchy.

The most tricky part of the series is handling of the current task which
is kept out of kernel mode status tracking since a running task can make
multiple syscall and propagating those signals up the cgroup hierarchy
can be expensive. Instead the status of the current task is only looked
at during schedule() to make throttling decisions. This leads to some
interesting considerations in some paths (see curr_h_is_throttled() in
Patch 8 for EEVDF handling)

Testing
=======

The series was tested for correctness using a single hackbench instance
in a bandwidth controlled cgroup to observe the following set of events:

  o Throttle into partial state followed by a full throttle

   hackbench-1602    [044] dN.2.    55.684108: throttle_cfs_rq: cfs_rq throttled: (0) -> (1)
   hackbench-1602    [044] dN.2.    55.684111: pick_task_fair: Task picked on throttled hierarchy: hackbench(1602)
   hackbench-1602    [044] d....    55.684117: sched_notify_critical_section_exit: Pick on throttled requesting resched
   hackbench-1602    [044] dN.2.    55.684119: throttle_cfs_rq: cfs_rq throttled: (1) -> (2)
   ...
      <idle>-0       [044] dNh2.    55.689677: unthrottle_cfs_rq: cfs_rq unthrottled: (2) -> (0)

  o Full throttle demoted to partial and then reupgraded

      <idle>-0       [006] dN.2.    55.592145: unthrottle_cfs_rq: cfs_rq unthrottled: (2) -> (1)
      <idle>-0       [006] dN.2.    55.592147: pick_task_fair: Task picked on throttled hierarchy: hackbench(1584)
   ...
   hackbench-1584    [006] d....    55.592154: sched_notify_critical_section_exit: Pick on throttled requesting resched
   ...
   hackbench-1584    [006] dN.2.    55.592157: throttle_cfs_rq: cfs_rq throttled: (1) -> (2)
 
  [ Note: (1) corresponds to CFS_THROTTLE_PARTIAL (throttled but with
    kernel mode preempted entities that are still runnable) and (2)
    corresponds to CFS_THROTTLED (full throttle with no runnable task) ]

The stability testing was done by running the following script:

    #!/bin/bash
    
    mkdir /sys/fs/cgroup/CG0
    echo "+cpu" > /sys/fs/cgroup/CG0/cgroup.subtree_control
    echo "+cpuset" > /sys/fs/cgroup/CG0/cgroup.subtree_control
    mkdir /sys/fs/cgroup/CG0/CG00
    mkdir /sys/fs/cgroup/CG0/CG01
    echo "+cpu" > /sys/fs/cgroup/CG0/CG00/cgroup.subtree_control
    echo "+cpu" > /sys/fs/cgroup/CG0/CG01/cgroup.subtree_control
    echo "+cpuset" > /sys/fs/cgroup/CG0/CG01/cgroup.subtree_control
    echo "+cpuset" > /sys/fs/cgroup/CG0/CG00/cgroup.subtree_control
    mkdir /sys/fs/cgroup/CG0/CG00/CG000
    mkdir /sys/fs/cgroup/CG0/CG00/CG001
    mkdir /sys/fs/cgroup/CG0/CG01/CG000
    mkdir /sys/fs/cgroup/CG0/CG01/CG001
    echo "+cpu" > /sys/fs/cgroup/CG0/CG00/CG001/cgroup.subtree_control
    echo "+cpu" > /sys/fs/cgroup/CG0/CG00/CG000/cgroup.subtree_control
    echo "+cpu" > /sys/fs/cgroup/CG0/CG01/CG000/cgroup.subtree_control
    echo "+cpu" > /sys/fs/cgroup/CG0/CG01/CG001/cgroup.subtree_control
    echo "+cpuset" > /sys/fs/cgroup/CG0/CG01/CG000/cgroup.subtree_control
    echo "+cpuset" > /sys/fs/cgroup/CG0/CG01/CG001/cgroup.subtree_control
    echo "+cpuset" > /sys/fs/cgroup/CG0/CG00/CG000/cgroup.subtree_control
    echo "+cpuset" > /sys/fs/cgroup/CG0/CG00/CG001/cgroup.subtree_control
    echo "3200000 100000" > /sys/fs/cgroup/CG0/cpu.max
    echo "1600000 100000" > /sys/fs/cgroup/CG0/CG00/cpu.max
    echo "1600000 100000" > /sys/fs/cgroup/CG0/CG01/cpu.max
    echo "800000 100000" > /sys/fs/cgroup/CG0/CG00/CG000/cpu.max
    echo "800000 100000" > /sys/fs/cgroup/CG0/CG00/CG001/cpu.max
    echo "800000 100000" > /sys/fs/cgroup/CG0/CG01/CG000/cpu.max
    echo "800000 100000" > /sys/fs/cgroup/CG0/CG01/CG001/cpu.max
    
    sudo su -c "bash -c \"echo \$\$ > /sys/fs/cgroup/CG0/CG00/CG000/cgroup.procs; hackbench -p -l 5000000 -g $1 -T& wait;\""&
    sudo su -c "bash -c \"echo \$\$ > /sys/fs/cgroup/CG0/CG00/CG001/cgroup.procs; hackbench -p -l 5000000 -g $1 -T& wait;\""&
    sudo su -c "bash -c \"echo \$\$ > /sys/fs/cgroup/CG0/CG01/CG000/cgroup.procs; hackbench -p -l 5000000 -g $1 -T& wait;\""&
    sudo su -c "bash -c \"echo \$\$ > /sys/fs/cgroup/CG0/CG01/CG001/cgroup.procs; hackbench -p -l 5000000 -g $1 -T& wait;\""&
    
    time wait;

---

The above script was stress tested with 1,2,4, and 8 groups in a 64vCPU
VM, and with upto 64 groups on a 3rd Generation EPYC system (2 x
64C/128T) without experiencing any obvious issues.

Since I had run into various issues initially with this prototype, I've
retained a debug patch towards the end that dumps the rbtree state when
pick_eevdf() fails to select a task. Since it is a debug patch, all the
checkpatch warnings and errors have been ignored. I apologize in advance
for any inconvenience there.

Broken bits and disclaimer
==========================

In ascending order of priority:

- Few SCHED_WARN_ON() added assume only the syscall boundary is a
  critical section. These can go if this infrastructure is used for more
  fine-grained deferral.

- !CONFIG_CFS_BANDWIDTH and !CONFIG_SCHED_AUTOGROUP has only been build
  tested. Most (almost all) of the testing was done with
  CONFIG_CFS_BANDWIDTH enabled on a x86 system and a VM.

- The current PoC only support achitectures that select GENERIC_ENTRY.
  Other architectures need to use the sched_notify_critical_section*()
  API to mark the kernel critical section boundaries.

- Some abstractions are not very clean. For example, generic layer uses
  se_in_kernel() often passing &p->se as the argument. Instead, the
  task_struct can be sent directly to a wrapper around se_in_kernel().

- There is currently no way to opt out of throttle deferral however, it
  is possible to introduce a sysctl hook to enable / disable the feature
  on demand by only allowing propagation of "kernel_cs_count" down the
  cgroup hierarchy when the feature is enabled and a static key to guard
  key decision points that can lead to partial throttle.A simpler option
  is a boot time switch.

- On a partially throttled hierarchy, only kernel mode preempted tasks
  and the entities that lead to them can make progress. This can
  theoretically lead them to accumulate unbounded amount of -ve lag
  which can lead to long wait times for these entities when the
  hierarchy is unthrottled.

- PELT requires taking some look at since the number of runnable
  entities on a throttled hierarchy is not the same as "h_nr_runnable".
  Audit all references to "cfs_rq->h_nr_runnable" and "se->runnable_sum"
  and address those paths accordingly.

- Partially throttled hierarchies do not set the hierarchical indicators
  namely "cfs_rq->throttled_count" anymore. Audit all uses of
  throttled_hierarchy() to see if they need adjusting. At least two
  cases, one in throttled_lb_pair(), and the other in
  class->task_is_throttled() callback used by core scheduling requires
  auditing.

Clarifications required
=======================

- A kernel thread on a throttled hierarchy will always partially
  unthrottle it and make itself runnable. Is this possible? (at least
  one case with osnoise was found) Is this desired?

- A new task always starts off in kernel mode and can unthrottle the
  hierarchy to make itself runnable. Is this a desired behavior?

- There are a few "XXX" and "TODO" along that way that I'll be
  revisiting. Any comments there is greatly appreciated.

- Patch 21 seems to solve a heap integrity issue that I have
  encountered. Late into stress testing I occasionally came across a
  scenario where the rbroot does not have the correct min_kcs_vruntime
  set. An example dump is as follows:

    (Sorry in advance for the size of this dump)

    CPU43: ----- current task ----
    CPU43: pid(0) comm(swapper/43) task_cpu(43) task_on_rq_queued(1) task_on_rq_migrating(0) normal_policy(1) idle_policy(0)
    CPU43: ----- current task done ----
    CPU43: ----- cfs_rq ----
    CPU43: cfs_rq: throttled?(1) cfs_rq->throttled(1) h_nr_queued(24) h_nr_runnable(24) nr_queued(24) gse->kernel_cs_count(1)
    CPU43: cfs_rq EEVDF: avg_vruntime(3043328) avg_load(24576) avg_kcs_vruntime(125952) avg_kcs_load(1024)
    CPU43: ----- cfs_rq done ----
    CPU43: ----- rbtree traversal: root ----
    CPU43: se: load(1024) vruntime(6057209863) entity_key(12716) deadline(6059998121) min_vruntime(6057124320) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(6057184139) pick_entity(0)
    CPU43: ----- Left Subtree ----
    CPU43: se: load(1024) vruntime(6057198486) entity_key(1339) deadline(6059991924) min_vruntime(6057124320) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(6057184139) pick_entity(0)
    CPU43: ----- Left Subtree ----
    CPU43: se: load(1024) vruntime(6057128111) entity_key(-69036) deadline(6059919846) min_vruntime(6057124320) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(6057184139) pick_entity(0)
    CPU43: ----- Left Subtree ----
    CPU43: se: load(1024) vruntime(6057202668) entity_key(5521) deadline(6059894986) min_vruntime(6057124320) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057124320) entity_key(-72827) deadline(6059915644) min_vruntime(6057124320) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Left Subtree Done ----
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057196261) entity_key(-886) deadline(6059984139) min_vruntime(6057176590) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Left Subtree ----
    CPU43: se: load(1024) vruntime(6057176590) entity_key(-20557) deadline(6059967663) min_vruntime(6057176590) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Left Subtree Done ----
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057198406) entity_key(1259) deadline(6059990321) min_vruntime(6057198406) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Left Subtree Done ----
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057206114) entity_key(8967) deadline(6059995624) min_vruntime(6057197270) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(6057197270) pick_entity(0)
    CPU43: ----- Left Subtree ----
    CPU43: se: load(1024) vruntime(6057202212) entity_key(5065) deadline(6059994879) min_vruntime(6057197431) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Left Subtree ----
    CPU43: se: load(1024) vruntime(6057201766) entity_key(4619) deadline(6059993029) min_vruntime(6057197431) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Left Subtree ----
    CPU43: se: load(1024) vruntime(6057197431) entity_key(284) deadline(6059992361) min_vruntime(6057197431) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Left Subtree Done ----
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057201845) entity_key(4698) deadline(6059994381) min_vruntime(6057201845) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Left Subtree Done ----
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057201956) entity_key(4809) deadline(6059995233) min_vruntime(6057201956) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Left Subtree Done ----
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057203193) entity_key(6046) deadline(6059996320) min_vruntime(6057197270) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(6057197270) pick_entity(0)
    CPU43: ----- Left Subtree ----
    CPU43: se: load(1024) vruntime(6057199892) entity_key(2745) deadline(6059995624) min_vruntime(6057199892) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Left Subtree Done ----
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057205914) entity_key(8767) deadline(6059996907) min_vruntime(6057197270) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(6057197270) pick_entity(0)
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057197270) entity_key(123) deadline(6059997270) min_vruntime(6057197270) on_rq(1)
    CPU43: se kcs: kernel_cs_count(1) min_kcs_vruntime(6057197270) pick_entity(1)
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Left Subtree Done ----
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057210834) entity_key(13687) deadline(6060002729) min_vruntime(6057209600) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Left Subtree ----
    CPU43: se: load(1024) vruntime(6057209600) entity_key(12453) deadline(6060000733) min_vruntime(6057209600) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Left Subtree Done ----
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057215347) entity_key(18200) deadline(6060005989) min_vruntime(6057215103) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Left Subtree ----
    CPU43: se: load(1024) vruntime(6057215103) entity_key(17956) deadline(6060004643) min_vruntime(6057215103) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Left Subtree Done ----
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057215276) entity_key(18129) deadline(6060007381) min_vruntime(6057215276) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Right Subtree ----
    CPU43: se: load(1024) vruntime(6057216042) entity_key(18895) deadline(6060008258) min_vruntime(6057216042) on_rq(1)
    CPU43: se kcs: kernel_cs_count(0) min_kcs_vruntime(9223372036854775807) pick_entity(0)
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- Right Subtree Done ----
    CPU43: ----- rbtree done ----
    CPU43: ----- parent cfs_rq ----
    CPU43: ----- cfs_rq ----
    CPU43: cfs_rq: throttled?(1) cfs_rq->throttled(0) h_nr_queued(24) h_nr_runnable(24) nr_queued(1) gse->kernel_cs_count(1)
    CPU43: cfs_rq EEVDF: avg_vruntime(0) avg_load(312) avg_kcs_vruntime(0) avg_kcs_load(312)
    CPU43: ----- cfs_rq done ----
    CPU43: ----- parent cfs_rq ----
    CPU43: ----- cfs_rq ----
    CPU43: cfs_rq: throttled?(1) cfs_rq->throttled(0) h_nr_queued(24) h_nr_runnable(24) nr_queued(1) gse->kernel_cs_count(1)
    CPU43: cfs_rq EEVDF: avg_vruntime(0) avg_load(206) avg_kcs_vruntime(0) avg_kcs_load(206)
    CPU43: ----- cfs_rq done ----
    CPU43: ----- cfs_rq ----
    CPU43: cfs_rq: throttled?(0) cfs_rq->throttled(0) h_nr_queued(24) h_nr_runnable(24) nr_queued(1) gse->kernel_cs_count(-1)
    CPU43: cfs_rq EEVDF: avg_vruntime(0) avg_load(156) avg_kcs_vruntime(0) avg_kcs_load(156)
    CPU43: ----- cfs_rq done ----

  The vruntime of entity corresponding to "pick_entity(1)" should have
  been propagated to the root as min_kcs_vruntime but that does not seem
  to happen. This happens unpredictably and the amount of logs are
  overwhelming to make any sense of which series of rbtree operations
  lead up to it but grouping all the min_* members and setting it as
  RBAUGMENT as implemented in Patch 21 seem to make the issue go away.

  If folks think this is a genuine bugfix and not me masking a bigger
  issue, I can send this fix separately for min_vruntime and min_slice
  propagation and rebase my series on top of it.

Credits
=======

This series is based on the former approaches from:

Valentin Schneider <vschneid@redhat.com>
Ben Segall <bsegall@google.com>

All the credit for this idea really is due to them - while the mistakes
in implementing it are likely mine :)

Thanks to Swapnil, Dhananjay, Ravi, and Gautham for helping devise the
test strategy, discussions around the intricacies of CPU controllers,
and their help at tackling multiple subtle bugs I encountered along the
way.

References
==========

[1]: https://lore.kernel.org/lkml/20240711130004.2157737-1-vschneid@redhat.com/
[2]: https://youtu.be/YAVxQKQABLw
[3]: https://youtu.be/_N-nXJHiDNo
[4]: http://lore.kernel.org/r/xm26edfxpock.fsf@bsegall-linux.svl.corp.google.com

---
K Prateek Nayak (22):
  kernel/entry/common: Move syscall_enter_from_user_mode_work() out of
    header
  sched/fair: Convert "se->runnable_weight" to unsigned int and pack the
    struct
  [PoC] kernel/entry/common: Mark syscall as a kernel critical section
  [PoC] kernel/sched: Inititalize "kernel_cs_count" for new tasks
  sched/fair: Track EEVDF stats for entities preempted in kernel mode
  sched/fair: Propagate the min_vruntime of kernel mode preempted entity
  sched/fair: Propagate preempted entity information up cgroup hierarchy
  sched/fair: Allow pick_eevdf() to pick in-kernel entities on throttled
    hierarchy
  sched/fair: Introduce cfs_rq throttled states in preparation for
    partial throttling
  sched/fair: Prepare throttle_cfs_rq() to allow partial throttling
  sched/fair: Prepare unthrottle_cfs_rq() to demote throttle status
  sched/fair: Prepare bandwidth distribution to unthrottle partial
    throttles right away
  sched/fair: Correct the throttle status supplied to pick_eevdf()
  sched/fair: Mark a task if it was picked on a partially throttled
    hierarchy
  sched/fair: Call resched_curr() from sched_notify_syscall_exit()
  sched/fair: Prepare enqueue to partially unthrottle cfs_rq
  sched/fair: Clear pick on throttled indicator when task leave fair
    class
  sched/fair: Prepare pick_next_task_fair() to unthrottle a throttled
    hierarchy
  sched/fair: Ignore in-kernel indicators for running task outside of
    schedule()
  sched/fair: Implement determine_throttle_state() for partial throttle
  [MAYBE BUGFIX] sched/fair: Group all the se->min_* members together
    for propagation
  [DEBUG] sched/fair: Debug pick_eevdf() returning NULL!

 include/linux/entry-common.h |  10 +-
 include/linux/sched.h        |  45 +-
 init/init_task.c             |   5 +-
 kernel/entry/common.c        |  17 +
 kernel/entry/common.h        |   4 +
 kernel/sched/core.c          |   8 +-
 kernel/sched/debug.c         |   2 +-
 kernel/sched/fair.c          | 935 ++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h         |   8 +-
 9 files changed, 950 insertions(+), 84 deletions(-)


base-commit: d34e798094ca7be935b629a42f8b237d4d5b7f1d
-- 
2.43.0

