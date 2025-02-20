Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04B1BD01F
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053061; cv=fail; b=i7gSuYXDDriuru2npfKl5pBK6h1v2ypXTSDJ1rpAf5r8V9VmGfX/gA+Fa6cBoCyOrco4AU14CNZArDq/JDcI5fB5FjWiDaGPDkKbYzHdMuydtbnQmRABNpuIJJnOKfdehjG3RA+aLs3w8qHFt+2q0V3NcN/g+y+5xsSdrhn14F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053061; c=relaxed/simple;
	bh=atOTa/1tUTY2G9Yp+btsNLqSQy6jar7AQggFYY5Zqmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eBFC+IyXSX38rvKuPOcfpOQA0prO1iO4vkqbdu5EDqgM3xF23s2DAGFgUWYbeKN9qhVzrKSFB39nRjnJ9sTJ5pAYQw+9wX6jrfYJVhZUyul4ildV4bqdg5dNTTvy4CcT2CgTbhKuXh0MycfyV2BWP1zGfvJ3nJ9RStsXQZWOdj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y6YExqCH; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y6YExqCH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhdDqPJ/BPbJ4DPAI/LYV/LKUKXweJy9EMmW/a+OxhxnrRVDy5FtxQucRVw4B7bZeUiT9zjortFxQvEeOqTgrkWLiyZBNh4/A6SGoZb7WXL/9/RS9aqWP4TizMZx+UP9vHYfXS71OJJgGWuaTbH7xa6IAJjnV906dnKUjzhFszXxNME8Kc0SbkpstAJ4C/19qPZ2qTGpxJ3oJa1/u8BmthEQsLkReKE/9zoeZm4zcsqyA1pqY9HSSi/0Oi+P7czQUz/3tCeOVXd4TUFYm9Zh54BtAI6teHl4geAvp+TC0a2D3V5s/+3X4KBoNtxIlkDOmlq1ca7ydgZ2VaJH1wuPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpwJVIexLW2S1EyzDvtcATpuzDmVYgazQNdN+Lpw5YI=;
 b=RkYNDSCNhM5dgTkmbfOhg/q7biUdYhomCIMGI7LIFfgAwCbBZTpLY7EKymESYK0E/CG5tBYweo/G7T4+gmkttdeNNC1hkT8QEjqLWmckUdRvcKAwklC6y7UZ9cLS2/CNl7g3AnXg2C3ARLH8b4QfMlx2Cm+AnGOIevZ/qXsezumBpn6rP2LG8RWgSu5rv9YSXGYNCJg1HZyqR29V13ljtC5YkCniWQoIi4Wb+Z0oLa19dKeks3JauQ7FgSTXlLnUTqnSg149V8/wAIEgyYhXBYZQLnojkt9Xx3qasT6Fp6jn/P3ChtBVz4KXXnt5KyTx6kl4aCthPbYYMVY+I1ZYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpwJVIexLW2S1EyzDvtcATpuzDmVYgazQNdN+Lpw5YI=;
 b=Y6YExqCHPysIfVsxsEH+fedwaQx+0wpuAhM1bjYzo2eAjf0JY3a5HH3Mew6Li+Uh39mXx+43xr0/LzpeyaxDnm4uWzmEou6FPlwh564VMTv76zWLDjpdZrYG72GuERtnDRRKFolh9kHQPVDeIz8qpVWMwevfRzs7gKSvm5mn1Xc=
Received: from BN9PR03CA0349.namprd03.prod.outlook.com (2603:10b6:408:f6::24)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 12:04:16 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::78) by BN9PR03CA0349.outlook.office365.com
 (2603:10b6:408:f6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 12:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.2 via Frontend Transport; Thu, 20 Feb 2025 12:04:15 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 06:04:07 -0600
Message-ID: <59d46dd3-33da-4e95-8674-d93fc00d73f6@amd.com>
Date: Thu, 20 Feb 2025 17:34:05 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
To: Peter Zijlstra <peterz@infradead.org>, Ben Segall <bsegall@google.com>,
	Josh Don <joshdon@google.com>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Valentin Schneider
	<vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski
	<luto@kernel.org>, <linux-kernel@vger.kernel.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman
	<mgorman@suse.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Clark
 Williams" <clrkwllms@kernel.org>, <linux-rt-devel@lists.linux.dev>, Tejun Heo
	<tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Barret Rhoden
	<brho@google.com>, Petr Mladek <pmladek@suse.com>, Qais Yousef
	<qyousef@layalina.io>, "Paul E. McKenney" <paulmck@kernel.org>, David Vernet
	<dvernet@meta.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
 <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com>
 <20250220113227.GL34567@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250220113227.GL34567@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d0fcd5-ae09-44e8-546c-08dd51a6b272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THUxZE9PMHl1L1VHQ1ZpaWZvTTlob0h4aENsK1Z4L2YxRmhIM3I4bUxORzBO?=
 =?utf-8?B?R0l0TExKVC8wV2xBbGFUZ04zeWRtWVVzR21admFPK2FlNlVzMzhDanJEeUla?=
 =?utf-8?B?a3huOWY5cXZETUk5MzhIOXZwL0UzNHRvbDNZNE1Ta3Evdmlob3pUcEN4NDJG?=
 =?utf-8?B?bU03TmUxVTJ3VTBKK0M4dFhtU0xHb0RwQ25ROXJwQ21RZlVFTXZrVjZPalVD?=
 =?utf-8?B?clJVT09Tekx3VkNZU3gvaXhGUHgwNkNIb1g5RCtjWGp4TGNUTlhNR1dGYjBt?=
 =?utf-8?B?ZHZHZ2VDaUs1SngxVUREcDRDUjBMdU82cDZ6Zmp6VG9aLzByVlRWeSt3S0E3?=
 =?utf-8?B?ZEdSYUtSVnh6cVBYdFZkT0FKMGtTQkorNlR0Tmx4dVRDMFliKzN5c1YrZzlq?=
 =?utf-8?B?QmQ0OVZNOUQ4SkpLYmF4eDZxekovaXExVEJFSWpObVNJY1pjYVI0VEhWdURx?=
 =?utf-8?B?NGx4MElLdzJhWXRlZE0zK2FkaldRTEVtUG5XVWtsK0h4c2tDNTFnVzJrQjVS?=
 =?utf-8?B?R3A4YjM4TVZYNERZMUptZGZ1WURsRGExN1ZNak9qcnR4azlkMVRJbVZ5a1c4?=
 =?utf-8?B?ZitWRm5PODA2bEhUMDYzNzBubW5qV09nNFArOWF4QTU1SVY3UGlKWVdzTnZ5?=
 =?utf-8?B?TWdkRytKMnFpcTRIbVBmdWZsL0JWK2RWNVZrOTQ4MGE1dDdRTDVsUVljUTVs?=
 =?utf-8?B?ZHJPN3lKVllvVTBBbVRqa3gwODI0VnJHc2lmcUp4TUVKaUJKbVdUNTlkRmpX?=
 =?utf-8?B?MTgxMzhPWHE5cFM0VkJmOFdtK0NtNElCSFdZTXc3UXQxU0l5bDBKc0RKZWtr?=
 =?utf-8?B?ZU1LYUIwK2ZJNjlXZlBMb3NENjlma0QxQ3RtM2s2djRRTEw1U2YxZ3gxcnpy?=
 =?utf-8?B?ZDJISUtYVEZKemttNTlKdDhOZG1nWk1MSkYyZjQ2V2xKRHJYejhHZHo5UVov?=
 =?utf-8?B?SVF2aGpzeUF3S0ZQRW1zVU03RU5TYWxLM1JhMVBxNmNPQmZRTlo1ZjdSRGtz?=
 =?utf-8?B?bmVpQnRvTGQ4WWRrRXhGSGZ2TUhmQ0o1a3F2K1VkTnNpODRrSjNKT2Z6SUhm?=
 =?utf-8?B?V0VObWl4bWo0dzRKSXJLN2Z3R2lkbjlHa0Q2dzA1VSsxZFl3bkVLMm8yUmw2?=
 =?utf-8?B?Q3NtUDlGblZSbUZGQ2hONFdQdmdOdmR3WnRSaE01bEpRYWY5ZXk5RXdjMnZx?=
 =?utf-8?B?ZnpFNkJaVk5rMWpBT3ViTEtzenp4M2l1TVoxMWpTL282WjRJdlJlOEh1ZXcx?=
 =?utf-8?B?YW1FMVBCYk5kdUo4eTBCWlZRUDJvVEZseGhjeTBUdCsrQnZQWjFtVWtINE13?=
 =?utf-8?B?MDFKSmxYUU1heGJENG1EaElPZGpGMkl5YXhCNXhVT2MwSzQrYmRtRVVUYnZJ?=
 =?utf-8?B?TDJYVm5oNnhSa1MwaERoeUorTndNdHNRSnhJcVNsZkY4N09GdHVoc25qeTNM?=
 =?utf-8?B?b2tpeFlURjBnOXl5L21Kdi9aUUk3OUtPdHpmZElUL2FmYzFKbnhud1RZVFgz?=
 =?utf-8?B?cmk1TEhUdFBwbE84L3pjcCs4OWhDc3pKN3h0bUFNS0NCTTlwSlRzSC9iNjBI?=
 =?utf-8?B?cDNnb3ZqVUdkSHQ2cnFIZTlvYnpiSDFaM2ZCOE1PTE5qdE5hamVlN0t6RlBt?=
 =?utf-8?B?S25oTzROdXFYajNGM3U5RkVBVTRlZ0R1dkhRS3laeWt2SDdhRTlFUHF4Y2Vl?=
 =?utf-8?B?Q25ya1FXNnMrQWpRU005QXgxZFRRcEFldmpJSmd2c3hkNDRCYVVrdEhZUUFo?=
 =?utf-8?B?TGV0c0RKbVo5bUxKYU9zNEozb21uaXFkMWtzcFlYcWpnVFdrMVVrR2xnN2k0?=
 =?utf-8?B?cmoyQjZXa1RZRkpNZElsY1NwSm40aUR1bDgwM2piYTFCNEZaVDNPQWNwYjAv?=
 =?utf-8?B?R2I5dGpQajRud1AzQWc3Q0UrdElzSy9yNmpRL3UxNmczQ0p5cVIrYzRvekFO?=
 =?utf-8?Q?oiyUCxSByBs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 12:04:15.6111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d0fcd5-ae09-44e8-546c-08dd51a6b272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306

Hello Peter,

On 2/20/2025 5:02 PM, Peter Zijlstra wrote:
> On Thu, Feb 20, 2025 at 04:48:58PM +0530, K Prateek Nayak wrote:
> 
>> The rationale there was with growing number of tasks on cfs_rq, the
>> throttle path has to perform a lot of dequeues and the unthrottle at
>> distribution has to enqueue all the dequeued threads back.
>>
>> This is one way to keep all the tasks queued but allow pick to only
>> select among those that are preempted in kernel mode.
>>
>> Since per-task throttling needs to tag, dequeue, and re-enqueue each
>> task, I'm putting this out as an alternate approach that does not
>> increase the complexities of tg_tree walks which Ben had noted on
>> Valentin's series [1]. Instead we retain the per cfs_rq throttling
>> at the cost of some stats tracking at enqueue and dequeue
>> boundaries.
>>
>> If you have a strong feelings against any specific part, or the entirety
>> of this approach, please do let me know, and I'll do my best to see if
>> a tweaked approach or an alternate implementation can scale well with
>> growing thread counts (or at least try to defend the bits in question if
>> they hold merit still).
>>
>> Any and all feedback is appreciated :)
> 
> Pfff.. I hate it all :-)
> 
> So the dequeue approach puts the pain on the people actually using the
> bandwidth crud,

Back in Josh Don's presentation at the "Humongous Servers vs Kernel
Scalability" BoF [1] at LPC'24, they mentioned one server handles
around "O(250k) threads" (Slide 21)

Assuming 256 logical CPUs from their first first couple of slides, that
is about 1K potential tasks that can be throttled at one go on each
CPU. Doing that within a single rq_lock critical section may take quite
a bit of time.

Is the expectation that these deployments have to be managed more
smartly if we move to a per-task throttling model? Else it is just
hard lockup by a thousand tasks.

If Ben or Josh can comment on any scalability issues they might have
seen on their deployment and any learning they have drawn from them
since LPC'24, it would be great. Any stats on number of tasks that
get throttled at one go would also be helpful.

[1] https://lpc.events/event/18/contributions/1855/attachments/1436/3432/LPC%202024_%20Scalability%20BoF.pdf

> while this 'some extra accounting' crap has *everybody*
> pay for this nonsense, right?

That is correct. Let me go and get some numbers to see if the overhead
is visible but with deeper hierarchies there is a ton that goes on
already which may hide these overheads. I'll try with different levels
on a wakeup heavy task.

> 
> I'm not sure how bad this extra accounting is, but I do fear death by a
> thousand cuts.

We surely don't want that!

-- 
Thanks and Regards,
Prateek

