Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BE261B83
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Jan 2026 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767763884; cv=fail; b=hrtJOD2yYQG95nJvWaggHmZnd8QpvPMbBhw9T5TokhzA83pZ180uQ497nEpF/bMmC3ngMXAGsNbMNi8zOtt884BseyB42t/wWwWRnt4Rp8kJHfvfDtROcDhq/xYzqLIpJh8FiuKc+/9bDCapdLgmBTx7EIx3JG2WcwgcSYPF6W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767763884; c=relaxed/simple;
	bh=H4EHUgvIL1ovnsQEZKaLVHF166cwSWzyseKrKiGcZ8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BFUhiMOBegKh0yiYO9PFudaWI/S4m1z7Q07dCY1nhyYJF8SkpE2h3fWbwcpuhXQXZjTYdZemS9lYk4twkTv5rx203BfsrPWI1Bh3ehmq/NMp7XhK0Wnb/mfeLtV6jOnOr3eftrHVCBXrG84BMoaZqGSQq2oLhy2o/AwLmZgfmkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QZrbM1PX; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QZrbM1PX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odzpOWUjK6aKo3rKKOmPhvMF83CDBZkXMZco9ii64d4YzU4MLS9wJjVstEYvSE/sUgKMuEDt/Mf3QtyIKK0o2W7gPQqfA2l22/f3gey4WBX8LpVlO7QFd35MMDbKOMP57ip/aBi59H+nNan9oUOFol1PcTvaWcRmRMaK4aHZqSqF9b/PrSJ5s99vyddWC77BIPDFoqd7hGEOXbYQ2CYIp2fnPI9ZMGQfFrQykf/9M1i3BEGejakTGQCgiZXTkVcPBRR30C1Emxm5WV6E1lzFq+IE8ew79HDnEUQnofiCrrP0leCn7wza6IhScmsB4z1BA8LQjswcF6coOv/n1J4+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWeh4nmS+YFYKULop6/0/AYD2aGdXYsK1fA6QXASikA=;
 b=Q1Y5CKFKmQacZ4DYdhAZ6NW9jT3Q1SYF6u6x8cAiHClnsuRoS2RMRRF9zZvyc+LGsvZDnoo29yEivDssd3jiK0gHgmwL04J4FMlw/E+vO9F+UMl3enZBN87Cs8etKeysN5p1RkFsyfl+zcMS6iz4GlTeutx0v8lxS3mbYeKRBdjMDiefYQLGfxeZhv1bPdgloOyY8bEJmCDtkVIAoXIm6v3aIH+53iL5wESjrAxZ2TrQwN+glqdYSNaiJnGrcMOz1H80L9H2P6LlI/tMqcOW+rSxb5EjDTMYfzURt0PGMQ6j81EzVPfYkElKVQIPpXzNGeywaLcwiJ7EsTN3dGLr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWeh4nmS+YFYKULop6/0/AYD2aGdXYsK1fA6QXASikA=;
 b=QZrbM1PX3szGpT3LpoLoLeCPi4BmPoZAMGLUkRUrrkLF8sFp56arMKbn/f2qKibwhz1Twa2jiMNGH3mvbRILEdVZE4C5q6SDdri/+Pw+UMFNL50RR0cL1q+J5QlPLL2cy9aIgs2OO3LR1cLkSEfM+RMeklFmkbAcPHnRu1Glvqc=
Received: from BY3PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:39b::25)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 05:31:17 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::ab) by BY3PR05CA0050.outlook.office365.com
 (2603:10b6:a03:39b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 05:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 05:31:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 23:31:17 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 21:31:16 -0800
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 6 Jan 2026 21:31:13 -0800
Message-ID: <693c35a3-a83c-4ed8-ad5d-5ff4ab7b40c6@amd.com>
Date: Wed, 7 Jan 2026 11:01:11 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/core: Stash task priority after dequeue and
 put_prev_task() in sched_change_begin()
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
References: <20260106075239.279072-1-kprateek.nayak@amd.com>
 <20260106104113.GX3707891@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260106104113.GX3707891@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfce886-c52d-4b51-e166-08de4dadfb5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUtvZzAydytONXpkNStNOVdNd3Bzb1JUTFNqUkVLRGVpWmN2VVFaR3lyVllI?=
 =?utf-8?B?dDE1WVVXOG1EeThEOE5pcFNvNlRiQ2VPaGZnc2xsUVJHM2VRalB4dEJqZzF1?=
 =?utf-8?B?L0E0TmNmSVl5dnpaU0o4MmZ1alVrQlJhL2d4aDB4Ynk1TCtzaTBUYmVZcEx5?=
 =?utf-8?B?d2RkM0xMZit3NmNFMlZKamtrVjhmbTZGd2lUcHdoVFkyVGR1cEdONWxucXhM?=
 =?utf-8?B?MUhzaHltTjZlTitKdkRXV0NRY0hZdTUrNlp0VEY1TU9MdGtYTWFzc3R4N3lU?=
 =?utf-8?B?K3ZxWlgwNXEySDhqcVVnd0I4eEYrekF5VWE2c0piNzFGRWM2bTJsN1Jpb01F?=
 =?utf-8?B?alFVUmNDd3JuMzFZWStwN29Yb1QxQW1VcTV3SmJDWHVSaU5xU3FtQ1FoRXk3?=
 =?utf-8?B?bzRsMlltSEVFRXQzNmg3Q09rS0ZuM3lKZmVrQUd3SzkrQ2hkbjBHeit0ZVpO?=
 =?utf-8?B?dUk2VVpEcGlhRmNqNUVpVDlNYTJCZzJNdTI1QnMrNEs5UmZLTGMvSERpb0N6?=
 =?utf-8?B?aXlWL016TUViVHNadjBrb2VJTGNHa2M1WDh2d2t6VzdQTWs3WkZ3V1pTQlVC?=
 =?utf-8?B?TTJEOHVNczlVeUFOcW45RU8rV1puLzNUYUVCemxzMGt1bEVCUVpiMWdJcmNs?=
 =?utf-8?B?OFhySy9ianNzWmt4RHVrWUt6bVdPSDZFUVU2N2VkQ1J6RnFyWTN3aXJ3ZG1y?=
 =?utf-8?B?SnlTMk13bVlyakRYTzZ4UTV3TndLcUdyUE55dHhlT3l6SVczbjROaElEODBs?=
 =?utf-8?B?NGxMN2RuUVVOZGFWSXpodjNhdDdzelh1cjF1S2Q0SS91ampuQkNEd0NTaW9y?=
 =?utf-8?B?N09LRWdkY1g2VDczamFtd0lnaDZIbzE0c2J2SHN0Wk5wd0hNWTVmQ0t1SVFo?=
 =?utf-8?B?UzNqbkNKcmlwVzhFNTZ0c3l5ZGl3NmxvRmkzWUgyZHpvaTNJZWg3TmN0enFB?=
 =?utf-8?B?ZFBUSVMyRFovVEcvNWdQcmswV3VIdVhBUGd3M2NzWU8yVEVWaFN2dW1Gei9Y?=
 =?utf-8?B?d2dwNjlaTlBjazlmYXJ2dlV6UnlYM3o2ditmMS9VTW5yVHJNd0Y1Zi9YK25P?=
 =?utf-8?B?cm1Hb2lUWjNjeU9NdHQzSllQWGRwSVhiQXZGQWQ4cWpmSVYyQU4zdkpYdDVE?=
 =?utf-8?B?cHVsK1g3MEw0bU5vVjB5eGlLWnpDZCs1akxiaHQrdVpZcTU4STFzamlpaSsz?=
 =?utf-8?B?QUtIOUMwNXdFZmcxWXAxRHlxUjNkdG04S013UVRNejhSK0k5NFZ1RnVYa1RG?=
 =?utf-8?B?eWlVTW41VWszaXpSV2dLZHhTcEgzZHRsT2dwWkpNakJmL1B3L1VxM0tISEty?=
 =?utf-8?B?QzZOQVRBTE9IR3NGT1krOTQzcFhMbUNBSTZLUmhLbTJrUXBnTGRQOU1ueHRh?=
 =?utf-8?B?czNxa0hFY0JrbUlHSmlyUGxjQjE5ZzlMMTRqc2JZUGhZdko5QlR5UlltTGRF?=
 =?utf-8?B?blcxSE9OcERYd2NUdGg3YWxmaEd1S3pjdUdvVjZLNmx2K2VrckVRYy9ISkI5?=
 =?utf-8?B?SzhxcmZDRXgrNE9tc2ZQbTVIMUNFOUtrZjVMN2NwbnMrVkpFY3ZEaG80U25z?=
 =?utf-8?B?QThuL1lhenIzUzg3MEVWVytSWkY2VVdCOVZ3bDlLY1ZPS3czTHNJR1d4UWJC?=
 =?utf-8?B?VlA1ZW5INVpDUndEaWloMHpPUlI2ZXdudlc5QnhDTmpsaDI4dGJjWWNQc3BK?=
 =?utf-8?B?c2hJa0dOZmRDR1Y1K0xNUVI5NHBXaWFJQVNOS3pobjJXLzVkWVkxSnZ5Mzlr?=
 =?utf-8?B?VzdoSGU3YWQybXFRdGdwbFFjUTJ1K05RNm9ZVFZuWDQ2ZXZXNTM2dU5xWEdN?=
 =?utf-8?B?UW13NSt2OVFrYSs0SFNGenZRV1ArWVVDRWxpQStDeVBQRFh6c2NPRkhaNnQ4?=
 =?utf-8?B?Q3FRUjFYUms2ZmpNUjliMlRwNG4wQ3F2NUJvVXNxdlpYdVNYM1FFYkY5WmdT?=
 =?utf-8?B?cFpYU1NwNUc1cGhYZVJnK2pGUVBQNnNsZThYVzZ2VlMrTWs2SWFCaTNscXVT?=
 =?utf-8?B?TTBOejZTdUpxZ3lqbVJxVStwbUdqdkRoVm93MC9ucXNYb1FURkdwa0FiVkJ4?=
 =?utf-8?B?Wk9nelcwRU8xWEtiQXY3YWhmeUtieHNSM0w2dDY0d3lXb3RGVXp3OG9Rd0V4?=
 =?utf-8?Q?cT9w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 05:31:17.4419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfce886-c52d-4b51-e166-08de4dadfb5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323

Hello Peter,

On 1/6/2026 4:11 PM, Peter Zijlstra wrote:
> On Tue, Jan 06, 2026 at 07:52:39AM +0000, K Prateek Nayak wrote:
>> When running amd-pstate driver on a PREEMPT_RT kernel on a shared memory
>> system (Zen3 and prior), the following splat was observed from
>> triggering the WARN_ON_ONCE() in rq_pin_lock():
>>
>>     ------------[ cut here ]------------
>>     WARNING: kernel/sched/sched.h:1807 at __schedule+0x122/0x17c0, CPU#8: swapper/0/1
> 
> Can you enable CONFIG_DEBUG_BUGVERBOSE_DETAILED?

Ack! I didn't know this was the config that printed the condition for
the warn on. I'll make sure to enable it henceforth.

[..snip..]

>> Since the dequeue on a deadline task can push its deadline, stash the
>> task prio towards the end of sched_change_begin().
>>
>> The modification to priority within the sched_change guard's scope will
>> still be considered as sched_change_end() will supply the priority
>> stashed at the end of constructor's execution as the old priority to
>> sched_class->prio_changed().
>>
> 
> Would not something like so make more sense?
> 
> ---
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 80c9559a3e30..60e0c25aae78 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3306,6 +3306,8 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
>  
>  static u64 get_prio_dl(struct rq *rq, struct task_struct *p)
>  {
> +	if (task_current_donor(rq, p))
> +		update_curr_dl(rq);
>  	return p->dl.deadline;
>  }
>  

Yup this makes sense too! Feel free to add a small note like:

Catch up the deadline before returning it from get_prio() for the
current donor. This ensures the sched_change guard caches the latest
value and doesn't mistake the subsequent dequeue to have changed the
task's priority.

and include:

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

