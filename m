Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A070231DDA4
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685997; cv=fail; b=c9SGSXjhNu/SeMogDG5L1XNysft21HET+5yofOmgtHfPWu2EuASy+biev3RlAgxwxPfg6WlC8uYU4Xzbyee4t+rvbfSxCR53Ut3u2CNA9K3SNVzHdJ2FlLrXaiirqDSPR0QmQl9p3SWZH47CquMeWFXjqku7IkSaZGyeKfsB/wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685997; c=relaxed/simple;
	bh=dMQSLgNr37Vy2SLoLVGAkD2hFEcms3PkgY+amdJZ7Zo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AnVy0XzHts0HITvZhnDk36IZO+WFm5ejOAoPDVGmLWcqWvtKRtL7WOi3Z8c3aq92M1VL4GBLSbozfUqtGlwhKw6zfGZg/l6pMi0F6h19Sflg8GeRbt+M3S6UnBHmmhXXVTNq3gE0vM71hISPcSorE7bs8qVNYRdz4o92tYGpFvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fBbCLnkW; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fBbCLnkW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVGT1TOg3x5xlSs2xGB1KuX/fiz3aSgCBe5QAhU6S7EloRAQVAxZU9pGfyKdZ/ELE0bgazpXZ8ZYmECGn4denT6a0JndLhnn/g6/cfrtXgN4CT36f1KvyyLXOYRwhU7Iun9qWJlo1b2lmI1gnaEumX/9kbZ1cjOVQiAA56h3Uo0jm0UZGlIBmIM0Ck6MyF2ji8Khs2M3z+N1EwrRIBCteLtCVakImhrDVSnY6mdm3+k4QWOJtOyslFEyLLw/xcUxgeXfcI3xa5Z/TMmoq/JMWhhrGhTVuXh6/1iML++cAAmuStXvP0BAnHRKceLhZIQLGrRjEfNlC9wbfYADsc7LAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27c6a6qC9K03JEwuAqsWVckosHc7KCXIxLSVivcWmw8=;
 b=b3kWnMc1c1gL6jKuc+LYI5eqInmutn5ZQTIcj/MJJiRuXwW0L4rUXCe865gEupY8y28HKEG4KOeZhfDBkp6tN5LN+SvmoDmQWZP3ZVr0DczilYjtj2POrfTdC4pT9xjOQWIyrzfwHakmZH5wwkSxvwpoK/Pm5T3YAUnYVUWARU7K4AT1MVVhqWMFzdQJa42eIplMYANGNivGCwXVcdPdwia+2tL9sqkf7kf8duPzNWZ1jyXtfmeA2F3hUaU9CiBgy3sIvOl5imFTkpjcN15XDq/HfNr9itRy9l7K+zPOc272Sunx9tDMfXqoAtWr+unXjo6cRWj0nuHHNv96Sy9zWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27c6a6qC9K03JEwuAqsWVckosHc7KCXIxLSVivcWmw8=;
 b=fBbCLnkW8cKKu631+iAzX8UKccn3FJuY9PPTQFyM5eIGSoTjc8ID0O33E4DDIKH+yqwNwXrCW49sI4hasQ/f99/xddd2QtCUpScNcYSj9x4DTmHho1z5CDTH1G/e4qT/Mzw8QdvffnQ6/CxkLl9x3Hkt1Osgr+FAUanAZk1qq6E=
Received: from MN2PR19CA0064.namprd19.prod.outlook.com (2603:10b6:208:19b::41)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 07:53:09 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::c6) by MN2PR19CA0064.outlook.office365.com
 (2603:10b6:208:19b::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 07:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 07:53:08 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 01:53:02 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tejun Heo
	<tj@kernel.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>
Subject: [RFC PATCH] sched/core: Stash task priority after dequeue and put_prev_task() in sched_change_begin()
Date: Tue, 6 Jan 2026 07:52:39 +0000
Message-ID: <20260106075239.279072-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 206cdae1-9dfc-44b5-47f7-08de4cf8a229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4niUmwRC3o9O27hkxKX0OowL5bg9gL2wUjOxC+LHEOAhaQUBhLee/fPBSRLD?=
 =?us-ascii?Q?p0tVEa0GtqoVJoaU+inFPkzS+AtYfEdB7qimEI7RBNFf/B3dfmPYQSB6X1CR?=
 =?us-ascii?Q?maakRlp8O8/WvlCVeeMxSSyFfGawbZZfo1Hpjlgspn+ZJa+l0rj4pHwRcPNc?=
 =?us-ascii?Q?tVcYhRPI2+Q8r4DQh234r5mW4V65+Mi63SOIB/ZSUCzIV386EFjJ/TZlbYn1?=
 =?us-ascii?Q?/Wnh/L5zgFotsXWG9qNoxMjxXvlsQIrpSo2MK5OPdV2M8bQpWIu1Xc9N6M3l?=
 =?us-ascii?Q?zG1nOyU1S6ue8CQq1uBoiOhQfmL4VomUHUf2aWqtCBBQHjqn9qgRxwjSKPPJ?=
 =?us-ascii?Q?pS8bj7qkdsuPDfWFcGtIBT3sBLLxBV1zvklhBBoxSYy9Fvdnp+d1jy7NKg1I?=
 =?us-ascii?Q?0NRN7gzNIxo6U0qt46PcxRpmKWXR72yDeWr3foRJbVITOGqjvT+YPH04gGe6?=
 =?us-ascii?Q?ioHlBqpxNbOwYgF407+AItBImhfkx1T6WdYYKUR4qQmx4zP43jS1dFyEjyPv?=
 =?us-ascii?Q?5mPPxzFh1hm+vFjUzBdWYEPxupbehqz+gWF53tFXjSlhz9OrQPThcArrl+tR?=
 =?us-ascii?Q?i5MZwVRx9dbQA4nDhuuQzALMxqsRO4IZIF1j8hv/X3clC7uC6WUZe4Olhg0a?=
 =?us-ascii?Q?mPGQhf0s6JF9PXc39BJqk2fbxvltbFaIikxA3+SZKiP3BETkF/EjyCkCazav?=
 =?us-ascii?Q?VKeR/YLwOlau/w6Ds1xcDP/VUKLi4q6YNCszIueEMr9iDame3tkdc6kSRIlm?=
 =?us-ascii?Q?Jqcr1nbTD789mhHUzCLk3R9/My9FjgeX4rpb9AXz6fN59x4OJU4qz/EaIDwC?=
 =?us-ascii?Q?G3ht0wTrm/szt5MLYLGkts5BuTBO+qL6IrSw7kkcqQubiRoYQrbTcZP4GA0R?=
 =?us-ascii?Q?vmcU4o4xy6z8BwXtIaym2oQcojcOgYcv7xwncd491L6z26VQf02Q9uHvvYX1?=
 =?us-ascii?Q?dJQKHdvCFmWHf8pIvfVZzwsp1HrYWSBmGhLjx5MWIp0RjZUrY+CjV/MFqhYb?=
 =?us-ascii?Q?SnL7WPsmpPKvFgklvor9RdDUP9kDdapz1/jOVtqti2qcK1o7hVajqSnLRgzI?=
 =?us-ascii?Q?B55dmmTjYuZoVHYUkO0FBpbSqtLLEMKBgpqpU7yMKFkTKv8rNW5a5FlTXuSv?=
 =?us-ascii?Q?rXsf9l/05BGieWLOFAoT3suJlsAmC9/upUUhHFWUwtaqvuDDMYTqNQKDPwE9?=
 =?us-ascii?Q?eGscODEEvYBbK1/LI9sWcr7es5usQPu0SQESTW0jJYKfxLG2yrt3HOtM9pvE?=
 =?us-ascii?Q?K6kOJktJtdeIBzFRCJCN/baCA1Bhf7sXXpChl1EtdhTasOCOTsC7goFN2xde?=
 =?us-ascii?Q?wPa5RQF56ctpw7pvE4Ln9nO8f762LHATr4kgO9PJDxHsyQ+Ww6PTMaCCeF9i?=
 =?us-ascii?Q?3rdqa1crcPNrF8+5nMR9sdbjkKf3ljnLugIl/b8+wO/6OK7BQiwxdNome5nZ?=
 =?us-ascii?Q?GDePHtAT6yA/cO6jGzmanQNPgJooF3kETBdti6VjUFZi14RvdMRBymnMd7RI?=
 =?us-ascii?Q?OQMu1iiWiu/S5YWuNJmD7uYBbUVVtWbep1xB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 07:53:08.9044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 206cdae1-9dfc-44b5-47f7-08de4cf8a229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320

When running amd-pstate driver on a PREEMPT_RT kernel on a shared memory
system (Zen3 and prior), the following splat was observed from
triggering the WARN_ON_ONCE() in rq_pin_lock():

    ------------[ cut here ]------------
    WARNING: kernel/sched/sched.h:1807 at __schedule+0x122/0x17c0, CPU#8: swapper/0/1
    Modules linked in:
    CPU: 8 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0-rc1-rt-amd-pstate+ #153 PREEMPT_{RT,(full)}
    Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    RIP: 0010:__schedule+0x122/0x17c0
    Code: 3...
    RSP: 0018:ffffd2f8800e7a50 EFLAGS: 00010082
    RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000005
    RDX: ffff89f2fd41d1e0 RSI: 0000000000000000 RDI: ffff89f2fd432480
    RBP: ffffd2f8800e7af8 R08: 0000000000000643 R09: 000000037328de2f
    R10: 0000000373168f59 R11: 000000037328de2f R12: 0000000000000001
    R13: ffff89f2fd432480 R14: 0000000000000008 R15: ffff89b4d9072810
    FS:  0000000000000000(0000) GS:ffff89f34fee5000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000000000 CR3: 000000807dc4a001 CR4: 0000000000f70ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? psi_group_change+0x1ff/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     preempt_schedule+0x41/0x60
     preempt_schedule_thunk+0x16/0x30
     try_to_wake_up+0x341/0x7c0
     autoremove_wake_function+0x12/0x40
     __wake_up_common+0x78/0xa0
     __wake_up+0x31/0x50
     send_pcc_cmd+0x133/0x310
     cppc_set_reg_val+0x10e/0x220
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? amd_pstate_init_boost_support+0x33/0xb0
     amd_pstate_cpu_init+0x159/0x270
     ? srso_alias_return_thunk+0x5/0xfbef5
     cpufreq_online+0x6b0/0xd90
     ? rtlock_slowlock_locked+0xce1/0xd30
     cpufreq_add_dev+0xa9/0xd0
     subsys_interface_register+0x10b/0x120
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_amd_pstate_init+0x10/0x10
     cpufreq_register_driver+0x1a7/0x370
     amd_pstate_register_driver.part.0+0x2a/0xa0
     amd_pstate_init+0xe3/0x3a0
     ? __pfx_amd_pstate_init+0x10/0x10
     do_one_initcall+0x47/0x310
     kernel_init_freeable+0x33c/0x500
     ? __pfx_kernel_init+0x10/0x10
     kernel_init+0x1b/0x1f0
     ? __pfx_kernel_init+0x10/0x10
     ret_from_fork+0x222/0x280
     ? __pfx_kernel_init+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>
    ---[ end trace 0000000000000000 ]---

Inspecting the set of events that led to the warning being triggered
showed the following:

    systemd-1  [008] dN.31 ...: do_set_cpus_allowed: set_cpus_allowed begin!

    systemd-1  [008] dN.31 ...: sched_change_begin: Begin!
    systemd-1  [008] dN.31 ...: sched_change_begin: Before dequeue_task()!
    systemd-1  [008] dN.31 ...: update_curr_dl_se: update_curr_dl_se: ENQUEUE_REPLENISH
    systemd-1  [008] dN.31 ...: enqueue_dl_entity: enqueue_dl_entity: ENQUEUE_REPLENISH
    systemd-1  [008] dN.31 ...: replenish_dl_entity: Replenish before: 14815760217
    systemd-1  [008] dN.31 ...: replenish_dl_entity: Replenish after: 14816960047
    systemd-1  [008] dN.31 ...: sched_change_begin: Before put_prev_task()!

    systemd-1  [008] dN.31 ...: sched_change_end: Before enqueue_task()!
    systemd-1  [008] dN.31 ...: sched_change_end: Before put_prev_task()!
    systemd-1  [008] dN.31 ...: prio_changed_dl: Queuing pull task on prio change: 14815760217 -> 14816960047
    systemd-1  [008] dN.31 ...: prio_changed_dl: Queuing balance callback!
    systemd-1  [008] dN.31 ...: sched_change_end: End!

    systemd-1  [008] dN.31 ...: do_set_cpus_allowed: set_cpus_allowed end!
    systemd-1  [008] dN.21 ...: __schedule: Woops! Balance callback found!

1. sched_change_begin() from guard(sched_change) in
   do_set_cpus_allowed() stashes the priority, which for the deadline
   task, is "p->dl.deadline".
2. The dequeue of the deadline task replenishes the deadline.
3. The task is enqueued back after guard's scope ends and since there is
   no *_CLASS flags set, sched_change_end() calls
   dl_sched_class->prio_changed() which compares the deadline.
4. Since deadline was moved on dequeue, prio_changed_dl() sees the value
   differ from the stashed value and queues a balance pull callback.
5. do_set_cpus_allowed() finishes and drops the rq_lock without doing a
   do_balance_callbacks().
6. Grabbing the rq_lock() at subsequent __schedule() triggers the
   warning since the balance pull callback was never executed before
   dropping the lock.

Since the dequeue on a deadline task can push its deadline, stash the
task prio towards the end of sched_change_begin().

The modification to priority within the sched_change guard's scope will
still be considered as sched_change_end() will supply the priority
stashed at the end of constructor's execution as the old priority to
sched_class->prio_changed().

Fixes: 6455ad5346c9c ("sched: Move sched_class::prio_changed() into the change pattern")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Since I'm not too familiar with the deadline bits, I've marked this as
RFC for now. If you require any data from my setup, please do let me
know.

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

at commit 6ab7973f2540 ("sched/fair: Fix sched_avg fold").

To run with amd-pstate on PREEMPT_RT, you'll first need the patches from
https://lore.kernel.org/lkml/20260106073608.278644-1-kprateek.nayak@amd.com/
Most of the testing was done on top of Rafael's tree (v6.19.0-rc4 based)
with the above series where the issue was first seen.
---
 kernel/sched/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5b17d8e3cb55..ce05957e8055 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10791,20 +10791,19 @@ struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int
 		.running = task_current_donor(rq, p),
 	};
 
-	if (!(flags & DEQUEUE_CLASS)) {
-		if (p->sched_class->get_prio)
-			ctx->prio = p->sched_class->get_prio(rq, p);
-		else
-			ctx->prio = p->prio;
-	}
-
 	if (ctx->queued)
 		dequeue_task(rq, p, flags);
 	if (ctx->running)
 		put_prev_task(rq, p);
 
-	if ((flags & DEQUEUE_CLASS) && p->sched_class->switched_from)
+	if (!(flags & DEQUEUE_CLASS)) {
+		if (p->sched_class->get_prio)
+			ctx->prio = p->sched_class->get_prio(rq, p);
+		else
+			ctx->prio = p->prio;
+	} else if (p->sched_class->switched_from) {
 		p->sched_class->switched_from(rq, p);
+	}
 
 	return ctx;
 }

base-commit: 6ab7973f254071faf20fe5fcc502a3fe9ca14a47
-- 
2.34.1

