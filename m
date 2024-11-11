Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58B37160
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Nov 2024 04:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731300141; cv=fail; b=C3xJnVxFB8Ft67VkQUHqDgqLumkxRKDYYvzZAkKEE/UVp1y4o1hsHf061Q4DFdpTwwNR/hm4pCBO8Ukn86CnsrQGvgWS5/uGpVeJBfz35g+yC55yfpAKM7s9uwIjpo5KBpOr2FDMEeV79ueR8YA7YTAmW8X+vbJocwiSvyaBy+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731300141; c=relaxed/simple;
	bh=/NjPNG3QZSf5/6j5r4ZX3SOrzCX/WPsreS4UDaA5iHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kqMzPRZ3m5EMjxjpuXF/y6kjn1YEaVFH1cwyIB1u1fN4IWv5Jj65KiJkrkdzZmPsm/D77fIlangxAZec3GlXaAEPkrVsiOGwFsrEtjJXS6lCkpaUGvcI7P1ZQ9NdpML/ehY5eEQp12ZQSfoa6v4o4fDMewoQBq1f/qr9aKCUenA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zl9i2S9P; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zl9i2S9P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc/yHS8C/UJdfolFysNY7HthUKhsArHpxbfN+8c4CyfsolGk7CSG1IgnNVHe3gOpw6FWoS1Ej8VlDQb7uGxHIw1SXnZg4kpRa5G6L0jBeBEIzIqIylKY6ihy5E4YEsOG9jimL4p0ZHrv+B2bikfx+TGeCp19WJvyNdB9Stzk1rVwARTuIZWzCNDg8DS3hjgcMrMQbC9ZIlMbmQeh5RXrI6+FxBgH/3FRARukBPb9Nv/eTdiUoNg8sz4+U0tEK3pQHFUJB11CLEpcPGDuDB/X5aSA97W+lx8UZyDlMgPJbUlz+dySfg4K7rWbJ/vZx+uLFGl6f2MzEuZ+X6s9Gr+ztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHciraEHHrA7AYs4NQi4/efhBa22YhSyiezzxc20M1U=;
 b=CapXoy1MqxnCbS+Uf1dj9kB8aGwQuvpVKW+HghYAvudHQh6mYD8UU9uaE7DgBtfXW/yVwqhOnpH9uQSWc/btcX6j+FHFaWbPA9NBnfBfQ/kVKQpsqlO4hTRjt5wCxseNS1lFIygzGa2GEOOWxFoHk89/iiUNb+CFe9g+Hd6uyhPZmZ3EC1UqBecAa6lGDy5I+etxJ3ZnWaA8Sh/qNQw4imQTLR12ohuEXSMMh1I8GZ3cJmMeedpVt/NzATPF2YkIR2kQscXNwpZfiHbP8yO6TdhHj1qs8MVGhLwijYRf2nasrs61kYlBVLyf/iMWyO/+UO5sVFC5M0UpCOuj6/Ke4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHciraEHHrA7AYs4NQi4/efhBa22YhSyiezzxc20M1U=;
 b=Zl9i2S9P/fpYWrFXb8u1mLDD2yU7nwJ3dBAYEjYox5gfAi6q0+wxNxWDdeQGSe6CAunX4Nwom/UBqCYZJnOxJejBA4BR+4M3mskOkADO62myhd85RtoPPDxEFUv4sYgT12kgU2W+QAcal4oW54AFKu2LVXmAI4eGS9VxXjqk3MY=
Received: from BN9PR03CA0284.namprd03.prod.outlook.com (2603:10b6:408:f5::19)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 04:42:16 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::17) by BN9PR03CA0284.outlook.office365.com
 (2603:10b6:408:f5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Mon, 11 Nov 2024 04:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 04:42:16 +0000
Received: from [10.136.47.222] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Nov
 2024 22:42:09 -0600
Message-ID: <b311ff68-4571-cbfc-a4f0-bcfeade54836@amd.com>
Date: Mon, 11 Nov 2024 10:12:02 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 3/3] sched/core: Prevent wakeup of ksoftirqd during
 idle load balance
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, NeilBrown <neilb@suse.de>, Zqiang
	<qiang.zhang1211@gmail.com>, Caleb Sander Mateos <csander@purestorage.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Chen Yu <yu.c.chen@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>
References: <20241030071557.1422-1-kprateek.nayak@amd.com>
 <20241030071557.1422-4-kprateek.nayak@amd.com>
 <20241108121748.tGlosO1b@linutronix.de>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241108121748.tGlosO1b@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: e540c3a5-340b-4bb6-62e1-08dd020b3822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXVoa0d0eGhMN2JBL3BDY1JGUkVKdHVEaDJjRVp2empvOFNHRFNvZVhQWmlM?=
 =?utf-8?B?WEZFSHRsWUwzSzZrWkVWNzFoek1tN0lFYk9teVJtdFZFQXg0cm16N0pvdStz?=
 =?utf-8?B?S0xQYjZTVVdTNzFlajJsaElNRzJKZ3ZPTjhvZHltL29tSzRYak00SE54d2xH?=
 =?utf-8?B?RTd6MGkvTDVVeDlCOFBMaFZjRDlZQXZsS0JOM0VpclJBcTBrZDFpUXBNR2E2?=
 =?utf-8?B?a3VTWVdNWkU5YnZWbDJKYWpTRm5RZXZnN2JHYkxORzZWSWcvY21jT0pzUHBU?=
 =?utf-8?B?WWtqVXUzdDZFTWg2bzdKaXBZY3c4MjlYcjlUVUtyVVZpeEloWmgyY0htMjNr?=
 =?utf-8?B?T3ZSR3ZsTUpGZFpxeHBZT0d1bXlNZ05PVDV6dkl6OWgrbGlrUVhucytwNXU5?=
 =?utf-8?B?RW5TV2JoRzNuY3dHVWhnM3lSMllTaFlrb1ZXbXc2VWt4ZjdxTk51U2s3T3Jz?=
 =?utf-8?B?anlid1I0S2ZjT09XVWhjQ1NnOC8vd2k2b1lsVmEyODZVaXpkL21vRFBpNFJI?=
 =?utf-8?B?NmZKUTBSSzdXRU5wS2lGNUNEVkdZZVNOV3ZJSTUyT0tITEJEUmRjdlo5Zmwy?=
 =?utf-8?B?aUw5dGg1czRVSkc1NDBZRW8wOS85Njl2enUvaTh3OHZiUEtvM293a05uLzJu?=
 =?utf-8?B?Z1VWcnBGaDJZeDN3bXVmOXBVNmxpcTF6aXovQjc3YTlLY0twM1ZMR3hhc0Jm?=
 =?utf-8?B?TytYLzU5cVcxNVR6RWloOXZZZDdkSVdQYkJCMUJTTk9vcHhBc1VJS1dsQ0FR?=
 =?utf-8?B?bU9SUm5WSkF6aUtjN0JZdmUrUUMvaVN6RE8walBVNGViSTZzV3pLNDdNRks4?=
 =?utf-8?B?MTYwUkpkazZsZE1XTDYySEtYam5vZzZDT3g2elRoa3ZHQkU0cGFrMjdaZGpF?=
 =?utf-8?B?TFE1a3NkUUJvMnNEb2dPSnZJRjlieFZ2cUJXMUNPK1NXYW5KWkhzV283TjlQ?=
 =?utf-8?B?OXUrZFgxZkVaL2FRdzhXeFQzUWZHcHRUVURSODQ0YUNrYTRvWitjRFRYNWh4?=
 =?utf-8?B?MjBIWmlTaElCcS9Rd0IxbGZPcVdnaGovd2VUNktmb2VCK2hNcnRTYmIvaURm?=
 =?utf-8?B?anRDSGVGdlQxZWQxYlFpT2czTXpnc3QzMm1hYnJETUxDcUtycjdFb2ZBanE0?=
 =?utf-8?B?WTY1Q0RWdXdIcFpEbnhRbWdFMXFMcXNFSWhheXJxK0lsc2h3eC9XQnlPL1Vq?=
 =?utf-8?B?UEdkbk5lTWtEak40UjJPSDExY25TWjUrbzhXRldlMjF0cGN5MDBYK3NjWk5l?=
 =?utf-8?B?Zk9tQlRLbjNqRitaSTlPa2p3RTZ2d3QyNlhVeXBGcFQxWlE5eTlNK05Nemky?=
 =?utf-8?B?TkRJSmozMmtjTHZPYmRaNTZ1UmlzZmlTWGFqMUJIWWpFVXkxNUttSXZvc2pZ?=
 =?utf-8?B?alBxc3FTelBFa0I2eE9WQmNsR05IdVVMeXQ2MCtKQTdrbS9zZnRadjZ3Zy9F?=
 =?utf-8?B?bXpDZ2hodmdkems5YnErREZiNjhieGd0MURhY0VkV0c2U0ZBcHJNVCtCWXNP?=
 =?utf-8?B?N2p6b1MwTXUxd1NETDA0Mmw1SkZWNHlSS1BCQUR6TDBXYXU2NzU2QkRXU2NP?=
 =?utf-8?B?aWpzazZvZFR0OXFEa08zbUkrbU5taytxTlcrbC9xTFlkZWE3TTdVTE05UWpk?=
 =?utf-8?B?K2pvQnJ1N0dmb01DcFNxak9kblVZZ1RpcTdxSXU4OWo0a01ta0JXY2lTd2tp?=
 =?utf-8?B?Wk8rQnUzRXhRWnNFdWFRTlU4Z2xyeVhZYVg0WWE2SzRGQkZEcUNMSWpWZk9u?=
 =?utf-8?B?dWMwV2h4dTVDcGRmQmNGQlNLSHlDMEsrcGxKMmFXNnBBM2ZzekxWd3VvMWky?=
 =?utf-8?B?QTFidUxRaWNmb1VUb1E3THBibWY4b25wSDBSbFl6NTBaaGg5SW9KMnU1WEtk?=
 =?utf-8?B?aHJKRlRIeUc1emlhRVZUOEozVGNVQ3lwYkNySzZidFp4YWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 04:42:16.5370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e540c3a5-340b-4bb6-62e1-08dd020b3822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324

Hello Sebastian,

On 11/8/2024 5:47 PM, Sebastian Andrzej Siewior wrote:
> On 2024-10-30 07:15:57 [+0000], K Prateek Nayak wrote:
>> Scheduler raises a SCHED_SOFTIRQ to trigger a load balancing event on
>> from the IPI handler on the idle CPU. Since the softirq can be raised
>> from flush_smp_call_function_queue(), it can end up waking up ksoftirqd,
>> which can give an illusion of the idle CPU being busy when doing an idle
>> load balancing.
>>
>> Adding a trace_printk() in nohz_csd_func() at the spot of raising
>> SCHED_SOFTIRQ and enabling trace events for sched_switch, sched_wakeup,
>> and softirq_entry (for SCHED_SOFTIRQ vector alone) helps observing the
>> current behavior:
>>
>>         <idle>-0   [000] dN.1.:  nohz_csd_func: Raising SCHED_SOFTIRQ from nohz_csd_func
>>         <idle>-0   [000] dN.4.:  sched_wakeup: comm=ksoftirqd/0 pid=16 prio=120 target_cpu=000
>>         <idle>-0   [000] .Ns1.:  softirq_entry: vec=7 [action=SCHED]
>>         <idle>-0   [000] .Ns1.:  softirq_exit: vec=7  [action=SCHED]
>>         <idle>-0   [000] d..2.:  sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/0 next_pid=16 next_prio=120
>>    ksoftirqd/0-16  [000] d..2.:  sched_switch: prev_comm=ksoftirqd/0 prev_pid=16 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
>>         ...
>>
>> ksoftirqd is woken up before the idle thread calls
>> do_softirq_post_smp_call_flush() which can make the runqueue appear
>> busy and prevent the idle load balancer from pulling task from an
>> overloaded runqueue towards itself[1].
>>
>> Since the softirq raised is guranteed to be serviced in irq_exit() or
>> via do_softirq_post_smp_call_flush(), set SCHED_SOFTIRQ without checking
>> the need to wakeup ksoftirq for idle load balancing.
>>
>> Following are the observations with the changes when enabling the same
>> set of events:
>>
>>         <idle>-0       [000] dN.1.: nohz_csd_func: Raising SCHED_SOFTIRQ for nohz_idle_balance
>>         <idle>-0       [000] dN.1.: softirq_raise: vec=7 [action=SCHED]
>>         <idle>-0       [000] .Ns1.: softirq_entry: vec=7 [action=SCHED]
>>
>> No unnecessary ksoftirqd wakeups are seen from idle task's context to
>> service the softirq.
> 
> | Use __raise_softirq_irqoff() to raise the softirq. The SMP function call
> | is always invoked on the requested CPU in an interrupt handler. It is
> | guaranteed that soft interrupts are handled at the end.
> 
> You could extend it
> 
> | If the SMP function is invoked from an idle CPU via
> | flush_smp_call_function_queue() then the HARD-IRQ flag is not set and
> | raise_softirq_irqoff() wakes needlessly ksoftirqd because soft
> | interrupts are handled before ksoftirqd get on the CPU.

I'll reword the log as suggested in the next version.

> 
> This on its own is a reasonable optimisation. A different question would
> be if flush_smp_call_function_queue() should pretend to be in-IRQ like a
> regular IPI but…

I thought about it initially but seeing optimizations and checks around
"hardirq_stack" and checks to reuse it in certain context led be to
believe that there may be more nuances that I do not have a full picture
of, and I went ahead with this simpler solution.

> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you for the review!

> 
>> Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
>> Reported-by: Julia Lawall <julia.lawall@inria.fr>
>> Closes: https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/ [1]
>> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>> v3..v4:
>>
>> o New patch based on Sebastian's suggestion.
>> ---
>>   kernel/sched/core.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index aaf99c0bcb49..2ee3621d6e7e 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1244,7 +1244,18 @@ static void nohz_csd_func(void *info)
>>   	rq->idle_balance = idle_cpu(cpu);
>>   	if (rq->idle_balance) {
>>   		rq->nohz_idle_balance = flags;
>> -		raise_softirq_irqoff(SCHED_SOFTIRQ);
>> +
>> +		/*
>> +		 * Don't wakeup ksoftirqd when raising SCHED_SOFTIRQ
>> +		 * since the idle load balancer may mistake wakeup of
>> +		 * ksoftirqd as a genuine task wakeup and bail out from
>> +		 * load balancing early. Since it is guaranteed that
>> +		 * pending softirqs will be handled soon, either on
>> +		 * irq_exit() or via do_softirq_post_smp_call_flush(),
>> +		 * raise SCHED_SOFTIRQ without checking the need to
>> +		 * wakeup ksoftirqd.
>> +		 */
> 
> /*
>   * This is always invoked from an interrupt handler, simply raise the
>   * softirq.
>   */
> 
> should be enough IMHO. But *I* would even skip that, since it is
> obvious.

I'll remove it in the subsequent version. I'll wait a bit before sending
it to see if folks have any suggestion on the parallel thread regarding
handling SCHED_SOFTIRQ from ksoftirqd.

> 
>> +		__raise_softirq_irqoff(SCHED_SOFTIRQ);
>>   	}
>>   }
> 
> Sebastian

-- 
Thanks and Regards,
Prateek
