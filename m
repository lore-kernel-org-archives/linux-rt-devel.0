Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91111CA0
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Nov 2024 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731995169; cv=fail; b=oidAyrPcad1NMrSPssOEddqW8roaZ2ntPsWnCltEEF5z08bmetUJR5kJZ9QGkBwnrvPWtz4UEC0aKkn39Q9fxDUG90yvP7GtJUCvNt9xGfc9EZiHozPaHs6OiakgkyHoWEnEA4Vi81g19YFS1NA4BnSxzf5phvePqWjNaW/2vWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731995169; c=relaxed/simple;
	bh=+ZoSNuKGOS6XN/mIyhHo6fbq8jMula5qsReok3p7RjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ey0tDGnqoFXme4Op+0NyCpMP1hDuDEPW8yl5cHvTNDE5GM/LHtFhkIhjHsnOQXFw6tgPAKIOXj7OSvuVnKlN38qjUwnWCoVFxwjY2fKU+Qnh2707NZeI4KQYWOVKEgsuAcVpDcsMphUq/SDp2hpYp6PyXzXXecj9pw3Lc0ecKgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pV45TzxH; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pV45TzxH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdtXU8J/vrOT1hoBZi0NL/qCy92XUMijVcuLRrtolqfzn3iM/8UJDi3p8YW+w6ulC5L8/mzTK+CXrgQaci5kHVOIl8wepjlgdVBB7sV9ic8BQzLXcPUJifr3tKlRw/UQu7DwBV+rx0jwF1ec2o/K7f6pLLqHkjBgqba2QKYWkVJYjG9qMP7j7Vo4CPUJ3t9ZZ4evlpRZwv511GfGFceTu21HUTs3Em2ZRaoFmzVmuvLgeD6AUfvXCBrEkAndLb83JRh8tcUjK+EVsgMtsE1s24wHU+BxOB/RutE/zF2kjNilqA5eERYkmsdyr/F1uHTDegkp1EKsYY3cxuiTSF7A2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX9FQvjzKlDgiiet3apd6ajpe+k9G1eYy7N4Swy2W9Y=;
 b=gfW4R7Bbb9xl9lDgf3esxlCtFW2Du9j8CTsfhyeoXCqGGDm5DIy5Ah+4/DlnMQCSOKIprcfwHzrOSMHXX7KIPjiuVT/4UGN2AO01z8LA+loWnQlQc9KGg/CgX3i1aSPrEZwTyNcoLP/X9sQMFgKDRC/seHAACEAujnR5asEo+QviVLoQwt6IPmiBLXUrxqedEph8AyZg0vIMHnm2HBDmN7ItPZQyo4GitqRsEypdFR4Sjm5hx3qM9c2oKwjr6sYFELnSgs1tGxLuXdTaxWEJiZX8sc5JBkxRgGz+9j9ilQR5LwfO1VIxjiqn/uzE7Hy2YW/1wwdANk+4ZLeSWEfd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX9FQvjzKlDgiiet3apd6ajpe+k9G1eYy7N4Swy2W9Y=;
 b=pV45TzxHhV0F2WmmSVKbtG/r53VgZQHJFCxBh6jm9dFdPjabaDbu6Y95QLF2ygAAuZRwVf6jOIwDssaNItbDH0oc3wNZLxV2DUP0jgbRts1RPvJChAt//HEh2Tjlb145s4EbInIPXcwCJA+a51RsFdE8Y5/1iRGi8m8CPNFD0hc=
Received: from PH8PR05CA0011.namprd05.prod.outlook.com (2603:10b6:510:2cc::28)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Tue, 19 Nov
 2024 05:46:05 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::87) by PH8PR05CA0011.outlook.office365.com
 (2603:10b6:510:2cc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 05:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 05:46:04 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 23:45:57 -0600
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
Subject: [PATCH v5 4/4] sched/core: Prevent wakeup of ksoftirqd during idle load balance
Date: Tue, 19 Nov 2024 05:44:32 +0000
Message-ID: <20241119054432.6405-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1417b6-1690-46d4-c8c1-08dd085d7524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EzcJULrDLWtHj0YpIu1EpP0tyGXPK/Owtnxa5oQrXn1MX5w+I3rEl4tYRw1s?=
 =?us-ascii?Q?6dU5eu9Ef3TF8Idp3vONWd8HQAV5UmKhehHx1/hcDZCSPGrHlJ0KNvNNStNr?=
 =?us-ascii?Q?0g7U3B2ygOQZ+INnLFLNlyUxyRHk5AC5d2CGZPCsLQftX/61aczsdhXMAo34?=
 =?us-ascii?Q?23fUiEg2YQg3bV/JHBi+1SwV4dm3y8h5yKeWEdiQ3+Q/h/te7n9NasXLmiAz?=
 =?us-ascii?Q?tBhgid7kGfDDYYKB2sSM31obbIJo2zduePyVtYt5EoSYU9QactDq6DipEQ4W?=
 =?us-ascii?Q?yrClR1aa+nD0NJXk6IDDmb+tZfxK3b+9YItLZ5csdXUPEYLRO3Jk5USiAqB3?=
 =?us-ascii?Q?PrPIWXgipeC7NYSv8NUlNXi9QbPDpzhi+aPKmM2BnIsjZeiRoWqJUZjas/Tt?=
 =?us-ascii?Q?b9CcnrinF9gDRneTYmL+9b+zNPMpTouX+xkOFWXXcgIQmNrgWaDluTtRUWK4?=
 =?us-ascii?Q?24puEMc7XX4HoDnizgOENvzuPvl6EKL6yR9BZl5qcMLIk0rNKRzAX6Y+JT9q?=
 =?us-ascii?Q?Z1Y4b7XIpqkJXgmMYFWkp5/NMYDijNDIRod2UkgYNWoJdJfI8kLbvUOfInFV?=
 =?us-ascii?Q?KCk59S4QD8y8IMHNj+j1ixVZQBlESC4zhnlqry9gxlfnz65vU9D1drNbDnER?=
 =?us-ascii?Q?yMbkxvO7dHd/8DZuAAHuCpZ2lAVkH8eQdM4HP4kRdcEKfB5EKWS/yerMR1KI?=
 =?us-ascii?Q?BzlWPptPj5rb97Pw1enSrMVO/Ggn9QZClErbE3gKJtBJ94tst3Qtfu1VBHgY?=
 =?us-ascii?Q?x600JTA65AMViVqhrnopfz0/z2x1wSVMkaKhAvyDwAgIgrIpxYJtJMbhfGE6?=
 =?us-ascii?Q?fwzFuzn5u8Qjzc019sEGKftzQVJx6PUJvEOCpx3RYYNDwCmMR3j+0QgCayuJ?=
 =?us-ascii?Q?uPJ2mysLxhNeeM1Nr7RB9l2UycidvpU8nB3EH48qYPE4TxLKPX0KtumCmP89?=
 =?us-ascii?Q?ClllJsGfvUQnVdfHJsDAWAEM+9Z2Qp53c4xBRQZFb8/oOFrPb/CCak8t1MVY?=
 =?us-ascii?Q?WlPpW5ypj9E2xlZvxRalXKXklVU5RULWc35bDY1n6dJT6afDPoABRnx7/tjX?=
 =?us-ascii?Q?ZXwzHtZAzOtYYpxtxCW+eKYdN2azdtos16Va1ZuYUaHqjdjq8D1KyJIF8Yz9?=
 =?us-ascii?Q?6R7DWRpKAJwTt1bd3xAlK55VsMUkhpmsNB9zEO/pB+CLtHwrE4ZxgGynGr/p?=
 =?us-ascii?Q?3gjdGqlW+tkIKp+LmQ3vBFRDzGjT6BF6UgnheaR5YFl9JF6rA2/c0V/gOk91?=
 =?us-ascii?Q?E6GAwCLES3oq4EtfIgRRYomxUsHT/ez363KOKnTXsfO3ZU3E8tTo/UPEz0e3?=
 =?us-ascii?Q?0R7swCIQrAU4bcWdLet4L9l1UHoZTBb7r6p3DRvCJvuem4yoEyW7oBUUxWBm?=
 =?us-ascii?Q?P61RN+LG38bxmQE9teVJkYml+tvyMbOjSUing7g0/keJMj9LAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 05:46:04.5866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1417b6-1690-46d4-c8c1-08dd085d7524
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658

Scheduler raises a SCHED_SOFTIRQ to trigger a load balancing event on
from the IPI handler on the idle CPU. If the SMP function is invoked
from an idle CPU via flush_smp_call_function_queue() then the HARD-IRQ
flag is not set and raise_softirq_irqoff() needlessly wakes ksoftirqd
because soft interrupts are handled before ksoftirqd get on the CPU.

Adding a trace_printk() in nohz_csd_func() at the spot of raising
SCHED_SOFTIRQ and enabling trace events for sched_switch, sched_wakeup,
and softirq_entry (for SCHED_SOFTIRQ vector alone) helps observing the
current behavior:

       <idle>-0   [000] dN.1.:  nohz_csd_func: Raising SCHED_SOFTIRQ from nohz_csd_func
       <idle>-0   [000] dN.4.:  sched_wakeup: comm=ksoftirqd/0 pid=16 prio=120 target_cpu=000
       <idle>-0   [000] .Ns1.:  softirq_entry: vec=7 [action=SCHED]
       <idle>-0   [000] .Ns1.:  softirq_exit: vec=7  [action=SCHED]
       <idle>-0   [000] d..2.:  sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/0 next_pid=16 next_prio=120
  ksoftirqd/0-16  [000] d..2.:  sched_switch: prev_comm=ksoftirqd/0 prev_pid=16 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
       ...

Use __raise_softirq_irqoff() to raise the softirq. The SMP function call
is always invoked on the requested CPU in an interrupt handler. It is
guaranteed that soft interrupts are handled at the end.

Following are the observations with the changes when enabling the same
set of events:

       <idle>-0       [000] dN.1.: nohz_csd_func: Raising SCHED_SOFTIRQ for nohz_idle_balance
       <idle>-0       [000] dN.1.: softirq_raise: vec=7 [action=SCHED]
       <idle>-0       [000] .Ns1.: softirq_entry: vec=7 [action=SCHED]

No unnecessary ksoftirqd wakeups are seen from idle task's context to
service the softirq.

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/ [1]
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v4..v5:

- Reworded the commit message as per the sugestion and dropped the
  comment above __raise_softirq_irqoff() (Sebastian)

- Collected the Reviewed-by from Sebastian.
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 424c652a9ddc..e45f922e5829 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1239,7 +1239,7 @@ static void nohz_csd_func(void *info)
 	rq->idle_balance = idle_cpu(cpu);
 	if (rq->idle_balance) {
 		rq->nohz_idle_balance = flags;
-		raise_softirq_irqoff(SCHED_SOFTIRQ);
+		__raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
 }
 
-- 
2.34.1

