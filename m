Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92C1FF1A7
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070716; cv=fail; b=dLYQdMlsnnlqT7+RTlT7dLhvxUBS06kn+0kIrSOAeS4ZLzE5IzFq2bsk7kWwiviUyoPUma2ha6zwaStvWTggKL/bmi7WIFCCO4jSeTN6f4/LZRLEVW4meOnyIdtZAPGKMZBiql0cv+ZpR1FsZLtTevHzcVwCizILU78Z3QPf2+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070716; c=relaxed/simple;
	bh=DDRQXYf/TDOVc8oqbfXXk31OQ2q4LxawIwdZB/mMC7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qxYLXXb/61W+ZkTQyzSUN+uEX5YM/2WrK0BVkHuMcODLhZ+9LrHVP0JLs63/SULNqhADomBUwhte0Kg1ypabJgrFGDJcnbomwmcv0hlXO/BfX4XWC7T6y2fRVHl2ggzKdQo0GMg4FXufxe3MCfdtzT055Ik1dD4nRbwF5rs67bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dDzb0Wp1; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dDzb0Wp1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoCVqzq6V7C7Pl4Z5KVG74TiShTT1igz3uPX0zODSIMJ5v7tmvA/hBhYMOs7FtqOaWA04v/If3ZUk8iJlal1pHCyndaIyiNSn7r32df0Be9gDkUvprgmw6BTAyFb5J5/4e2yM3A7/lh1B9PK3Jo82puErhZ3/CbwZywn4qimevgiuJCXPqmLzjlfs7UsuhhJTlLriPDsvrrKUczB0uOtKPvFHgjnWoS7US7wK3IEtvF8k59WgXQA7JyuiDYraIVmBs7dqM4bj3Vek7BtkQskEmWu+Z0b0ZoxBR+p+zQVvrHPl9DBQxOYYcZjlgzTaRjO/Tnh2zrqocRz3uS7KEddyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQTgQ+FEkgtuBCTeg/JyBQJC67k503x9J4R3lPu+mCw=;
 b=i0f6ZaAao00UZwwbowEycvGXL12b+gnBp63TVaiQfRYr8b5AjT8ivhjK5JdS+9b1Tb5G35B56D3jfJyUuZHrIPdxT1PkG0uA0ty8doEy2jO1Mmo9X70jj6G6nwrWUGm+lMBV9mvEom3aULc/TOII1G71HvrhMHudXvUE9EoPSzgPXLG0o/V/+PgK58w+CbsSmROdHVS1v2r/VQbu8A/JZTydstVDxSV8FRWEyBlb6nH1VW7REo3xdgA2XyiyPZaxCAHvSIDVGwZf47jjN/QNfydSQM2JNdPm2V6s/XuxiCNHlepsUq/sJisLJqlPGUFlPEFb1kTVUPMXqJOp60nt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQTgQ+FEkgtuBCTeg/JyBQJC67k503x9J4R3lPu+mCw=;
 b=dDzb0Wp1g8GMNI/DtQ2tBG0kPxtBV3+aaiHQ33INhL8bqvbJH9yXJBY9cC/RaMeB8Iq1HlHJDMzcRdbcM3+F7yJZ//nR8fAzS2fKU631Cg0xXGwXocAuwETeTdRNfhF1tQWfOnTRjJMa7WSRKTLDyQVA0wtHhuXRe7mA6pKk4DQ=
Received: from BY3PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:217::9)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 16:58:32 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::89) by BY3PR04CA0004.outlook.office365.com
 (2603:10b6:a03:217::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 16:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 16:58:31 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 10:58:23 -0600
Message-ID: <4c709652-449c-457d-bf29-7fe3a872ee62@amd.com>
Date: Thu, 20 Feb 2025 22:28:21 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
To: Valentin Schneider <vschneid@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Ben Segall
	<bsegall@google.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski
	<luto@kernel.org>, <linux-kernel@vger.kernel.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman
	<mgorman@suse.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Clark
 Williams" <clrkwllms@kernel.org>, <linux-rt-devel@lists.linux.dev>, Tejun Heo
	<tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Barret Rhoden
	<brho@google.com>, Petr Mladek <pmladek@suse.com>, Josh Don
	<joshdon@google.com>, Qais Yousef <qyousef@layalina.io>, "Paul E. McKenney"
	<paulmck@kernel.org>, David Vernet <dvernet@meta.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
 <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com>
 <20250220113227.GL34567@noisy.programming.kicks-ass.net>
 <xhsmhikp44oan.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <xhsmhikp44oan.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e39898-2bd6-4f19-e3b1-08dd51cfce15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXZkN3owM0Z3S0FpajdSbVk1MklFSkFqSjZDL2JtNG14S1VtTnNvZDV4d3BS?=
 =?utf-8?B?MmNHekFFVVZUb05BeVRmcGVVeWVuQUQ3U0Fpc1VpaFpERWYwbi9ILzRpYVQv?=
 =?utf-8?B?R1BQZkNXWWUrbUZjcXFnemM2SjMrL1Nyc2doTjR4T1ltRkd3SXNYT01lK0Z6?=
 =?utf-8?B?YTJ1QmpNeG9RazA0ZlcwWlg0ZzRIbjYwalZ1TVRLeDEraXdpckJINytNUzZP?=
 =?utf-8?B?cW5GOG1YTlBZTml3TXFVWnl5T0hlV3dDU1Rwa1dUdjdRWGRSRXZKRWU5M0pW?=
 =?utf-8?B?QjVncVpza3RjVmhTVC8zRmtlUTlpR0pwSTR6dGxJVWlXR1pLRkQzdnJxR0cw?=
 =?utf-8?B?bHQxVWtnUW9Ea2hyTktVTGgxOHZ3ZmtkVVJFczdPVWI0UlpUNXlWQndXM1Qw?=
 =?utf-8?B?STdSa2IzR0RyMDAyRW5zS0RzaE9tdGdLbzhxenBOeFhaMHBGai9iK29IOHhQ?=
 =?utf-8?B?ZW01Vi9NWHZCTFZ2b1FLNGlEanhJa3NFUlB6eUE2alVDdUFHNVJHYmdPRzRL?=
 =?utf-8?B?UG1JZEZ4Qi9FMEFCMkVZQnd4cStRQ291MlczQ3dqLzVrbFk3b3FzZUZpa1dT?=
 =?utf-8?B?VlYzUTlRUmNVNVc4TlU4WEJLU3V4RnpXakVITnBPVGh2UEM0VXg3amFXbnhJ?=
 =?utf-8?B?T1hJcnNVZnBuaHRkTEkvdTVEZUJwWUI1eGhtSUJ2eVFqL0QrWEFkaDNNWkhL?=
 =?utf-8?B?NVc1MTFrMUxsVC9PZ1krRmZwYkhVRktXNk9XaEhRZ3R0TEErcUpLRGdYM2FF?=
 =?utf-8?B?WlZ5YUFqaVVvRW1Tb3VpNi9GSTlDakZYZmVGVTcrNUxtZGtoMlJDTm5SYmhn?=
 =?utf-8?B?aUQ5L08rUFVCRktCTWtadkM0OG16c0dPVW9Zc2NzMC9HUklFVE94QWtYVFlw?=
 =?utf-8?B?cFNzeGs1S3pTenZ1QWZYQVJCY2FlZmpad3pDWFBLMC9DVE5BNFBDM2dwWnk4?=
 =?utf-8?B?QXJ5OTNuNTlXQ21PL0VURWgyZlN0ZWduNjZYYzVrSUlmUTI5Y0N5MDhiVk5p?=
 =?utf-8?B?UEZmVkRocTg3QWdvR3AzSHV4eG5ON2c3TkJ4U3NlKzFDcG5IeW9NZWFpNWRp?=
 =?utf-8?B?NWlHNVdRTHQ5dlQrUWozaFBHOUdtaEp1ZXdlSFRVaFJKNzVvMytpNnVtTy9v?=
 =?utf-8?B?Vml0em1nSXlGeUhzUnBTZkxPQXhXOVo1dE1TVVdUalhIa0dkQ3lpdFRFS3Ix?=
 =?utf-8?B?MzB5SEhTak5Rem9hZjlXR0ZwVjhsd2RlYXdJcVVkZTNDUkFIT25BdVhXaURI?=
 =?utf-8?B?Z2pON3ZPTGVLNG9hYkI4MmNiTjQzTXlsc1V2emhRTjdjOEFwdnFLcTB1RndW?=
 =?utf-8?B?U0thYy9CK0hZdXBqVzluNmp3UFdTZ296UGxmRkc2Y0MyVkFIVzZFd0VNd003?=
 =?utf-8?B?OURFSWpIRlZmUFovaWRLeWZJQjR1U2NVK3JnZFUzQTdBNzRYazI0RTNFOTh2?=
 =?utf-8?B?bjM1RG9udTVRVlA3cVVaVGtCdjRCd3o1bUxCSS9MNjJzVG9LUTZreS9YcVN2?=
 =?utf-8?B?R1ptdHBmWTBITDJGMUYwdVJOaWZrSW9Vd0MwQTNiU0RuVTl5cEd4SmtEM1Zr?=
 =?utf-8?B?dzVqWFp1NWJIV1BNM2NvM3JkaHpHRWorRkRtVkF3OE9KQ2d0L2hrL0xYSENo?=
 =?utf-8?B?VTJwT1NkTnBjT2hJS09RNE5nQTVtZllORFQvYlRDYUF1VHFkVkVOanZremUr?=
 =?utf-8?B?cVVDemJLMHB4KzhzSU9sa2JtbEIvRkQ4TTJUd2xGZTZDSFIwK3pGV05QWUVi?=
 =?utf-8?B?M1ZxSUJycFR1L0IvSmVHdFBnNWZiQjFheFNQQng3Qnd2ZXZ2bjJZdTEzejhw?=
 =?utf-8?B?bHovV1NINFZiRzBZb0E2WGUvdmIzb293cjlkZVZSY3V2Q09VOXd3TDVBc3hS?=
 =?utf-8?B?UktseVdhcWNXQk94aG51M3FhM1Rhc0hlWm84WFVTMXBoaDhhMXRXeU9zSmR0?=
 =?utf-8?B?T2ttK2FOb2hMdHdVRXI3QmtNL3gxcU1GTEdhMkh1Nm9vLzBkalFISWUyTlRB?=
 =?utf-8?Q?RwHqCpbTx4mjD/I+behBLE07bx4u04=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:58:31.2537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e39898-2bd6-4f19-e3b1-08dd51cfce15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317

Hello Valentin,

On 2/20/2025 9:10 PM, Valentin Schneider wrote:
> On 20/02/25 12:32, Peter Zijlstra wrote:
>> On Thu, Feb 20, 2025 at 04:48:58PM +0530, K Prateek Nayak wrote:
>>
>>> The rationale there was with growing number of tasks on cfs_rq, the
>>> throttle path has to perform a lot of dequeues and the unthrottle at
>>> distribution has to enqueue all the dequeued threads back.
>>>
>>> This is one way to keep all the tasks queued but allow pick to only
>>> select among those that are preempted in kernel mode.
>>>
>>> Since per-task throttling needs to tag, dequeue, and re-enqueue each
>>> task, I'm putting this out as an alternate approach that does not
>>> increase the complexities of tg_tree walks which Ben had noted on
>>> Valentin's series [1]. Instead we retain the per cfs_rq throttling
>>> at the cost of some stats tracking at enqueue and dequeue
>>> boundaries.
>>>
>>> If you have a strong feelings against any specific part, or the entirety
>>> of this approach, please do let me know, and I'll do my best to see if
>>> a tweaked approach or an alternate implementation can scale well with
>>> growing thread counts (or at least try to defend the bits in question if
>>> they hold merit still).
>>>
>>> Any and all feedback is appreciated :)
>>
>> Pfff.. I hate it all :-)
>>
>> So the dequeue approach puts the pain on the people actually using the
>> bandwidth crud, while this 'some extra accounting' crap has *everybody*
>> pay for this nonsense, right?
>>
>> I'm not sure how bad this extra accounting is, but I do fear death by a
>> thousand cuts.
> 
> FWIW that was my main worry with the dual tree approach and why I gave up
> on it in favor of the per-task dequeue faff. Having the overhead mainly
> contained in throttle/unthrottle is a lot more attractive than adding
> (arguably small) overhead to the enqueue/dequeue paths. There was also the
> headache of figuring out what to do with the .*nr_running fields and what
> is reflected to load balance, which isn't an issue with the per-task thing.

I believed that with the differentiation of nr_queued and nr_runnable
now, the counts would be simpler to correct (I might be wrong).

This approach retains the single rbtree but yes there is a cost
associated with maintaining these stats. The stats collection can be
deferred until a bandwidth constraint is first enforced but yes the
small cost remains in every enqueue, dequeue, put_prev_entity,
set_next_entity path thereafter.

Arguably, this should be no more costlier than the current tracking of
h_nr_delayed + min_slice in enqueue and dequeue paths but I might be
wrong.

> 
> As pointed by Ben in [1], the issue with the per-task approach is the
> scalability of the unthrottle. You have the rq lock held and you
> potentially end up unthrottling a deep cgroup hierarchy, putting each
> individual task back on its cfs_rq.

Agreed which is why this alternate approach to retain the throttling and
unthrottling at cfs_rq level was worth a try.

> 
> I can't find my notes on that in a hurry, but my idea with that for a next
> version was to periodically release the rq lock as we go up the cgroup
> hierarchy during unthrottle - the idea being that we can mess with part of
> hierarchy, and as long as that part isn't connected to the rest (i.e. it's
> not enqueued, like we currently do for CFS throttling), "it should be
> safe".

That is pretty nifty! My only concern there would be the case where a
part of throttled hierarchy is still reachable on unthrottle but a part
has dequeued itself - some tasks might have to wait until it is queued
again to be accessible during the pick and a bunch of rescheds follow
with each batch of enqueues.

> 
> FYI I haven't given up on this, it's just that repeatedly context switching
> between IPI deferral and this didn't really work for me so I'm sticking to
> one 'till it gets somewhere.

Ack! This RFC was to get feedback from folks and to see if there are
any takers for cfs_rq level throttling and the reasons to move to a
per-task throttling. Safe to say I'm slowly getting some answers :)

> 
> [1]: https://lore.kernel.org/lkml/xm26y15yz0q8.fsf@google.com/
> 

-- 
Thanks and Regards,
Prateek

