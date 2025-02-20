Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7761F463E
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050352; cv=fail; b=sRleCiLXXwx+87GcDacGGTpFUw5GyCzU6v9XYYCjmq6CQ/E6AZyrR2rfwQ4LK0Y1KtnULxPbMrcXvcn85Bt8SRRPIL2h/tQnXwEiDFmWB3MAhVLWHTPS/bgkS1cN+6dLZu59xRjn1xgDOgsYfFybG4dZuNJbXimJyM4gWtFEbkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050352; c=relaxed/simple;
	bh=ehVF2b0YfIl2xBtUJBLXRRlx9JiL+rbjGb+xgdfNZjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KriIgCVpyjZoSCJ29Ls++ZAdedOL1/5j12m8n8LJww35Zr9CD5CX1PQdvhp2jXz7xXvQLWlyvS4w3LQ5zIfnSwFf2s961KUvPFOJbuEyz19YcY8nhQOWvFD3Ko8qEY2DENyGHD3q0qXAwxuW8A4MzFxlcNdJ2cLQIYQeJAvPlwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bF+/65/c; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bF+/65/c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odZn6rUUe3t05HQ/NnJnTWash6HveaWACk2FLXWjvsksiDR0wigYHktIm3Go1EjENap+A4720h7sM5nlol12yKhCAo4DyvCUeWDYZtr+HplhAmfeA8DXed0A39OC8OOGf+faUI64abvR/4EenTXAAQnLvSShnhInm11n48PHBV8ZSEoMfB8aMQ0UUjywHlQoPqug0C0GAq1ImicYd01kxD9nASMxB070WKONtE6Szx+aPZHnSg0Pk19e7AnythkrEAVCv5XNKvr+1nZCXD7n2WzWYBe31DpN5sNz8k4IxwMvuZlKQGVAGG6tJYYd+wUG3Wd/fWHrMwX5+qQQiFrD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY/a5eudWltG+fU4QS0hsgD1zK8MWp/oX/p5+S7akDY=;
 b=OgTClsmJmXM+bY48Rblo9vEbPNJLe7mzELq7+kHuQy7kdTzP+G4mrDp4DLKTFf3rQT70xrsyYhBChhNyhpavbIpnNE7v5cjT7mGnrwJcadjd9oO3G+Uu0LvGPeUB6P5lUJhdOWC9FhH2iaMCMmInKFCyd7JMHOb5vjPZNYjjZHMFcfa8U/nBsGDAXWHkje13s9dHsqenqii2lhOMRR/gEf4wQYSyaUpR+n91Hxg6/9EwiMLpvJP4WOjkxF/9FzwQrI8phLGkxROvWk4CShbrRqaBjptt0yRvQArqe68n7YKsduINqhKicq3nklIpO10Tyf3SUqRDY+fXzQcJHUcqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY/a5eudWltG+fU4QS0hsgD1zK8MWp/oX/p5+S7akDY=;
 b=bF+/65/c9hEg/q7zJq8YAaw+rT3Qq8MO5bhQMdrtLgJS9BwzzMKHH1+p2NjNrCHFT216WRC66nsx/MzTkvjuEUp/saFDbf711nI7/vmDDCnIEH5l5PVrBlIcAWJaqBSBrofEUVEKh+9DmxbQ0Yrqx+K3SW0ars4k8l+6Mb/AuB0=
Received: from MN2PR15CA0047.namprd15.prod.outlook.com (2603:10b6:208:237::16)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 11:19:08 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::7f) by MN2PR15CA0047.outlook.office365.com
 (2603:10b6:208:237::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 11:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.2 via Frontend Transport; Thu, 20 Feb 2025 11:19:07 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 05:19:00 -0600
Message-ID: <b2386349-2879-4dce-afb0-f6486c24c117@amd.com>
Date: Thu, 20 Feb 2025 16:48:58 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
	<linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, <linux-rt-devel@lists.linux.dev>, Tejun Heo
	<tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Barret Rhoden
	<brho@google.com>, Petr Mladek <pmladek@suse.com>, Josh Don
	<joshdon@google.com>, Qais Yousef <qyousef@layalina.io>, "Paul E. McKenney"
	<paulmck@kernel.org>, David Vernet <dvernet@meta.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
 <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 59202572-cc88-4749-28cb-08dd51a06467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3hmeUhSK0xBK3FvdHhsT05TdjcwcVR5WkpVQUQ1clNxcm1tSUo2SE5HV2pH?=
 =?utf-8?B?eHpsZkZhS01kbEkvTlVQTytvYW8rb2ppVFhObXd3RWVudlhEdDF4UTNHSUk3?=
 =?utf-8?B?NGV5bHZxNnZGa3VONElzM0NsMU9xL3JyaG8xbGswTlRXNnlPc2NRNGtMMGRz?=
 =?utf-8?B?cUwyZ1FGS1E4dGtxaFQzSElLSldOZm0ydUF4dWhUQWh3Q29UWU84dXVHQndM?=
 =?utf-8?B?VktWZkIzZUFGTTczTXdiUnJzYnVMT2E3UjFFMlpiOGRBZDQ3dFd1VzJBY0ZF?=
 =?utf-8?B?V2NEdkxvOEgrK2V6dTZJOU82ZnJxa1FoVjJEZTlGdVpHWEpPb2s1emJ3RDZi?=
 =?utf-8?B?QXYvbkpCb1UzQ25iVG42dk5iQWZuUmYvMVBaa2YwTlltZkQwMUF5c3lNZ0pU?=
 =?utf-8?B?Zm1zUEhHVThtZlNRZE94NE84dUgxS2JSNUdtVUtEaDJUeXUxVkZLL2UvWTVV?=
 =?utf-8?B?M3MyRUl0UEllZ1VtMmFXTHlDRjlsc3VHNnFGWTlUOTVXTEVudjNaWDlQMkFr?=
 =?utf-8?B?YlYrOGlKYTl3aE1MSGlMdHdLamRvcDN5Mm8wS3lXTUVGQmEyS2pKN3NSTHVZ?=
 =?utf-8?B?c2VUVUFYVmRjVGtzakN1b0dlTThpNS9GSlBxaFczUEYvYStPVE5CcjV2Rllt?=
 =?utf-8?B?dXFxYlVSbGMwalR3blI0dUZ2NzNESXluRDMzcURiclZMdS80bHltTU1wVFpO?=
 =?utf-8?B?NC83N2Z3bEVuL2pEV3ZMUm1UTzE1RlI1R0djczN2YVhzbjUydzV5YWFIMEFJ?=
 =?utf-8?B?RGtBU0F1UHdGSFNyRTJtNDVicXBsN0prZ2Z2VzkrUFJzZC9oNjlTcjJPMlE1?=
 =?utf-8?B?ZnFDUTJIT3ZZTUlxZmlaRnpaY2tiRDlLU0pwaGVHMXhGNkVpaGpsSFpnYkg5?=
 =?utf-8?B?TnZLVkNIVXNXVEpKMGV4ejJIajJOSlovREYreE5lOHlNUEc0NTF0RWQyRHNC?=
 =?utf-8?B?VkQybGVQR3drMis2UEtzQ2hrZTlvTFVTUzBTbDNGR1dXdCs2ZitWakhBMGIz?=
 =?utf-8?B?SEpaRWJwSFZ4SU5lWk5DL1VoM1FydGJxTi81SXg4d1l0NGZtc1lDeWRzVTZp?=
 =?utf-8?B?Y2p3TTVJZTh4SkRROGdpRUcvUmxEMmRHMkxqVFZnZUJWTHI1U2JzMUFmSmNo?=
 =?utf-8?B?V3RkTzRRU29KQ0g2MzBsd3lReHAzbWhZNnorRFc0WlR6Zm1oNi9kTXhDV3RJ?=
 =?utf-8?B?UlJnRW1MeDA3angyem9qMkswQnkyemZscHF3cWNpQTJKZUx0MU8vZVZjRERF?=
 =?utf-8?B?ODJsWW0zRXYyclVHc2p2SktjYUtnR0N0QmhtVXp5cnQ5d1F2eVhtbU5Valoz?=
 =?utf-8?B?ZVEwM2cwM3hsaDlZa1QxOGE3UDlXYnZoblBWdFdzSUZEQytxZnV3NjMzOHVL?=
 =?utf-8?B?NkpnUWU2bC9QVk1VUVRQT3hGeUY0WjlIMVlFS1BUM3k1UjB5ZndQVlJ4Ykhp?=
 =?utf-8?B?Y21nL00xT3Z2a2lVMFJsbTFMKzZuQ1FhZ0RWdSt2c0NKOU1ETW5Bbk14NHRs?=
 =?utf-8?B?bS9CUlZWZW1kWnpqRFR5Rlc2Q1pJVGNheFVKNWUyeHVjTUsrTmk1Q3VycmhI?=
 =?utf-8?B?c29ZRXYyYzlqSlA0ZlR2d1FvTXhMbmhjdkt5eUJvakpzZFEyWW13b1dCa2ly?=
 =?utf-8?B?dWNQRmZSQm5mSmp4amZTN2hFQ2NHT3NTT2g5Sk9uZUVnZ3dTT2RjTjk5ZVd1?=
 =?utf-8?B?Rkl6K3JDWjQ5anFZaElwaU8reVNRL0dRVWp1UGp2ckFPS3UrZzFkWWg1VGxT?=
 =?utf-8?B?MXRiaUNVaWtBVzJNRi90UlNxV0EwRkxOYmtHUXZOTTJtUk9TdmRVdWRJTFZC?=
 =?utf-8?B?eU00d1dqSWVwNW8zcjVFSUZGSkVBOFlZNnU2WUxuaThaWVZwZkdJOTdVaVlw?=
 =?utf-8?B?MjUxYkxWL0NTZ2pLYVk1dzM1b3gyYWRVc1pGOXgzaWpzR3FOem9zTFc4Z1d0?=
 =?utf-8?B?T3dvU2xFeXcxaUdEdDd0eTRhQnBTQjEzaCsyeXduTW8wdGUrZTVlRTFUSXBT?=
 =?utf-8?Q?h1eSpOHM3ymCbemwacX86+jL/dggFw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:19:07.7109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59202572-cc88-4749-28cb-08dd51a06467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333

Hello Peter,

On 2/20/2025 4:25 PM, Peter Zijlstra wrote:
> On Thu, Feb 20, 2025 at 09:32:35AM +0000, K Prateek Nayak wrote:
>> Proposed approach
>> =================
>>
>> This approach builds on Ben Segall's proposal in [4] which marked the
>> task in schedule() when exiting to usermode by setting
>> "in_return_to_user" flag except this prototype takes it a step ahead and
>> marks a "kernel critical section" within the syscall boundary using a
>> per-task "kernel_cs_count".
>>
>> The rationale behind this approach is that the task can only hold
>> kernel resources when running in kernel mode in preemptible context. In
>> this POC, the entire syscall boundary is marked as a kernel critical
>> section but in the future, the API can be used to mark fine grained
>> boundaries like between an up_read(), down_read() or up_write(),
>> down_write() pair.
>>
>> Within a kernel critical section, throttling events are deferred until
>> the task's "kernel_cs_count" hits 0. Currently this count is an integer
>> to catch any cases where the count turns negative as a result of
>> oversights on my part but this could be changed to a preempt count like
>> mechanism to request a resched.
>>
>>              cfs_rq throttled               picked again
>> 		  v                              v
>>
>>      ----|*********| (preempted by tick / wakeup) |***********| (full throttle)
>>
>>          ^                                                    ^
>> critical section   cfs_rq is throttled partially     critical section
>>        entry           since the task is still              exit
>>                    runnable as it was preempted in
>>                        kernel critical section
>>
>> The EEVDF infrastructure is extended to tracks the avg_vruntime and the
>> avg_load of only those entities preempted in kernel mode. When a cfs_rq
>> is throttled, it uses these metrics to select among the kernel mode
>> preempted tasks and running them till they exit to user mode.
>> pick_eevdf() is made aware that it is operating on a throttled hierarchy
>> to only select among these tasks that were preempted in kernel mode (and
>> the sched entities of cfs_rq that lead to them). When a throttled
>> entity's "kernel_cs_count" hits 0, the entire hierarchy is frozen but
>> the hierarchy remains accessible for picking until that point.
>>
>>            root
>>          /     \
>>         A       B * (throttled)
>>        ...    / | \
>>              0  1* 2*
>>
>>      (*) Preempted in kernel mode
>>
>>    o avg_kcs_vruntime = entity_key(1) * load(1) + entity_key(2) * load(2)
>>    o avg_kcs_load = load(1) + load(2)
>>
>>    o throttled_vruntime_eligible:
>>
>>        entity preempted in kernel mode &&
>>        entity_key(<>) * avg_kcs_load <= avg_kcs_vruntime
>>
>>    o rbtree is augmented with a "min_kcs_vruntime" field in sched entity
>>      that propagates the smallest vruntime of the all the entities in
>>      the subtree that are preempted in kernel mode. If they were
>>      executing in usermode when preempted, this will be set to LLONG_MAX.
>>
>>      This is used to construct a min-heap and select through the
>>      entities. Consider rbtree of B to look like:
>>
>>           1*
>>         /   \
>>        2*    0
>>
>>        min_kcs_vruntime = (se_in_kernel()) ? se->vruntime : LLONG_MAX:
>>        min_kcs_vruntime = min(se->min_kcs_vruntime,
>>                               __node_2_se(rb_left)->min_kcs_vruntime,
>>                               __node_2_se(rb_right)->min_kcs_vruntime);
>>
>>     pick_eevdf() uses the min_kcs_vruntime on the virtual deadline sorted
>>     tree to first check the left subtree for eligibility, then the node
>>     itself, and then the right subtree.
>>
> 
> *groan*... why not actually dequeue the tasks and only retain those with
> non-zero cs_count? That avoids having to duplicate everything, no?

The rationale there was with growing number of tasks on cfs_rq, the
throttle path has to perform a lot of dequeues and the unthrottle at
distribution has to enqueue all the dequeued threads back.

This is one way to keep all the tasks queued but allow pick to only
select among those that are preempted in kernel mode.

Since per-task throttling needs to tag, dequeue, and re-enqueue each
task, I'm putting this out as an alternate approach that does not
increase the complexities of tg_tree walks which Ben had noted on
Valentin's series [1]. Instead we retain the per cfs_rq throttling
at the cost of some stats tracking at enqueue and dequeue
boundaries.

If you have a strong feelings against any specific part, or the entirety
of this approach, please do let me know, and I'll do my best to see if
a tweaked approach or an alternate implementation can scale well with
growing thread counts (or at least try to defend the bits in question if
they hold merit still).

Any and all feedback is appreciated :)

[1] https://lore.kernel.org/lkml/xm26y15yz0q8.fsf@google.com/

-- 
Thanks and Regards,
Prateek

