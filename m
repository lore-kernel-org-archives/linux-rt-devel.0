Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11511CAA8F
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Feb 2025 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740109088; cv=fail; b=Mnme2t5TtBVSLXbBMUVDybOH7QnpnxfuwqzMtMq7bjOS+x5Aa3wCqeD10028S9oejTsuxA9cvrxH8rph+BohlsWvtBg06LWNBTWLJLhp9ZbQFpmbl/D+wfW9Jt3EI6InlOOKPymkpsaULBVNAHXKO0We0GzdrXbNPAb5Fm84It8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740109088; c=relaxed/simple;
	bh=ysp3p3zEZsi/LJPRXhwyOsXR8n1uADNa4fSEaN0TgXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bHjzCRjRaxYLNA9THWwtcQCqCyUJSHCK5G5gAj0xme/Z4qi78urtGI2BlnUuDGvLDjsc01NGbaFFADAEQjW+yiFPVeZ7OnUWw3/zdh8Mop2HN+AMFRC/30u8V82AMaGkq0NwjyR/sJw8RU9tSLWt1OTnSVPZPGfxCYqMy8RykAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OAJNYicb; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OAJNYicb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJnqqkeNGlgcrS1Ra9TYu9z3NoB4XtepgzZPgkPQmOH1SMe/vjOJSnKRJ/w9LqTNUK/1E+MYbQZkAQXAll7VJrXsRHWLUu2L6APa6T86paasTq8mRYe5/IxSPSOd3rJ04A/jgR4gJGb9TMu873axyHoQQasDfopNPV+Auel9dC78lIZN+E42B6lOVGEp8iFTsCZpQdW9S/9jCpJA4R/wEk/QuHJ0wkaMKblZcqv/01W+1xb33QDWoCsn1EHgy//4iH/c9jTj8e7HB8wibJDlZEiXJ5BpKt4NsfLRCoj3JI037ykQQDnNMkCUklGAoU72pmo3WFx+w0OP0diX/yG25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjqlEOp/rr7+PZ+3vKFtbe15P8MgAq/itJV1WF7q2V8=;
 b=Qot+kCSd6FZinLdWoDiteApjT3ItCwmhu2klLYvkfHM7TeKuYN5pGkw4hGSq1hcR/ynay5Ooj6hg0XmDtwZTm9WgzUp+puRvszRzXzlBRvRM7XW5RPMlnVjNmTcY9z4xxDW9OhGicsQykfj9Bm4Qiu832FFI3mCBIf+cJahkTCZPV++/Ofx9ja2h8TyeRCrtAT6LFfM3iaDKFLBLGrpP+J91CAtJVJd1f4dUxFJc3+IzpFfn1BTysxKVBKda6QyckO3kyzUqWV+KQpQoZ48IYRCXy/cljxJX7O/4RxhQuDuNhTbNxkVDpAm9QlMrH+cX4m4QdYLJRcWvdAUtD81DuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjqlEOp/rr7+PZ+3vKFtbe15P8MgAq/itJV1WF7q2V8=;
 b=OAJNYicb9McpVqy7C8AYNpiv6AJb9xUL/yc3rWx00bP62I+ItsTQEng995csMD8YgMYOCWjIk9xx5DUbqAv2PY5yxAsT06hP35JcQsSzI/LfKFFjsa2Y2yq6LlWP7FDHkglm6TUP7Fu9u4QGFceG/RttFqhE2MIqFxqIVlw/s2A=
Received: from CH0PR03CA0314.namprd03.prod.outlook.com (2603:10b6:610:118::29)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 03:38:04 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::2d) by CH0PR03CA0314.outlook.office365.com
 (2603:10b6:610:118::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 03:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 03:38:03 +0000
Received: from [10.136.35.22] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 21:37:57 -0600
Message-ID: <f4fed3e7-bc64-4717-9939-cd939e0aceea@amd.com>
Date: Fri, 21 Feb 2025 09:07:54 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
To: Josh Don <joshdon@google.com>, Peter Zijlstra <peterz@infradead.org>
CC: Ben Segall <bsegall@google.com>, Ingo Molnar <mingo@redhat.com>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
	<linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, <linux-rt-devel@lists.linux.dev>, Tejun Heo
	<tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Barret Rhoden
	<brho@google.com>, Petr Mladek <pmladek@suse.com>, Qais Yousef
	<qyousef@layalina.io>, "Paul E. McKenney" <paulmck@kernel.org>, David Vernet
	<dvernet@meta.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
 <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com>
 <20250220113227.GL34567@noisy.programming.kicks-ass.net>
 <59d46dd3-33da-4e95-8674-d93fc00d73f6@amd.com>
 <CABk29NuQZZsg+YYYyGh79Txkc=q6f8KUfKf8W8czB=ys=nPd=A@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CABk29NuQZZsg+YYYyGh79Txkc=q6f8KUfKf8W8czB=ys=nPd=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca32cc3-adcf-4c91-335e-08dd522925f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NStZZEEzTk1Ja0tGT1VjazMwaWY4T0hMYlA5YTdiL0VXVmFMNWFLK2hsVUNn?=
 =?utf-8?B?WXp4ekx5ZDgvZVU5d2ZQanZhRHFqekloQmh6Z1lick5LUnlsamdQUk01SXd6?=
 =?utf-8?B?dXhMZjFmZmhtUHpydnV5NEptcU9YSVJwQ25LM0d3dUlySjRmZ1owa00zdlp5?=
 =?utf-8?B?VFRWblJOWGlnQmVSdjY2U0NzZ0NUMnc1L0RYaEs3OTFqbXdOYVNEZ296OVNO?=
 =?utf-8?B?a3hFaDZKZUhVVkdrWjk3ZUQxVFRsYU1WVmgwWTE5UTc5UEIrbVZCMnFFUVB4?=
 =?utf-8?B?UUluZHhRRUNPWktQNy8xS3ZtdWlqVEVnV0JBYXdzZzZ5TjI0Q1NuRC9rdXNs?=
 =?utf-8?B?ZU9Ld0pVMTRFZ0c1Rk9EL0tIS0o4aE85YXEwTUFtdG1yS3RMc0lMenhqeEl1?=
 =?utf-8?B?eHNwaUVDcTM5MnhqUG9sZmVjT2wyalltQ3lIdXZqZ3ROMWtOUCtaZlBiZzYy?=
 =?utf-8?B?ai9VYWtkWHplVWFFSEU2c0NoTXoveXdkNHdXM0VHMXo3L3NRTy9BbVJDNjVW?=
 =?utf-8?B?aWV5ZDNMMWw0WXFKdFRCcVgwU1NWbmlHWEQwRjBXN2VQVzZ6SXR4bjRFVEdk?=
 =?utf-8?B?eWE0ekxuV1JCMERZdDdrYnpiQ1lZZHYzWGZvWTJ1NHZzL1d4VGxvR0pRb0VC?=
 =?utf-8?B?THl2djhxUUhONUY1anZQamhQR1l4bytOR1g4Yk5MVnRHVXAyNWtmTmYrQ3dl?=
 =?utf-8?B?WWxTcFRzbTBBZ1VtNjlKbUFzOGNEVkhqYTBjUkhGMUdCMFhxSzM0QmlhUG9O?=
 =?utf-8?B?VzVxVWdVaHFQa29VbUNNcHU3aTBaMW5IL2VMLzVpV2FkSGw4d1YzRE1Oends?=
 =?utf-8?B?L2haSUV4Q2tIb3ozdVRndEFZYVN1UUs3RDdpa3ZxOTNDOC82c0kwRTlDaDAy?=
 =?utf-8?B?MkdlLys4L0VhNUY5eUkzTXJlQVl3bG5FQjVNUUlSSjRnVnlNSzJ4MTJic0pk?=
 =?utf-8?B?N1E2UnZUdUZjQWZRbkt4REErTkdrSDRKV0pRSlVRU2lxUVc2ZkcxajZtSEZv?=
 =?utf-8?B?a3JqL2tiZlU4SzEvOTQ2VW1yQlUyOGd0U2ZNekZaNDVraDA0aG9WVVhZVmRT?=
 =?utf-8?B?R2JXSUpvY0Q0eFNYbEpBZ3JzRWxMaGJUNTU3L1dNUVhMcW5LTk5ZY0tPUkQx?=
 =?utf-8?B?c1lzL2lLQWFFbjB3LzhMeXNqdEtyMlZxTE5LUXBiakxmL1pDRmtNTms3NkNB?=
 =?utf-8?B?cVg3MjRycUZndFZzV3FqTjBMMDhZSW5sdVZ1b0pYVS8ycGs2Sk44T0Z1YkMv?=
 =?utf-8?B?eVdDMnpwREJ3d0VBQzg0cGd3VzhuS213YU9hMFVCV1p4TEZtZ3Y2KzgrTnVG?=
 =?utf-8?B?d1Z3RFI2L0IxQVNGdDJpdVNaRjVqOVdrSGY0dXpEQ2ZkYzQ4TFZUbWVXS2ZX?=
 =?utf-8?B?UlFlTyttSEZhOThCanRvbmpiWEpwVzJvYnJpZTVkb1BHTjlsVTIzNlJKakVs?=
 =?utf-8?B?QWtJUUI1Q2hUdkFXVkJMT3o3MHNqdnBnM2JrV3o5MnhmMEUrSzNqZlRHZHBB?=
 =?utf-8?B?QkxDbHg0NDlkcW50S0pXRnRTZTVwY2M3b1BXeVFNWE83dmVrdElBTHB2bWhP?=
 =?utf-8?B?VlhMN2o2YVVNUTd1UElqd0xDTUpiN0Z1L3Znd2kwOG1IenJySDZERTJJQ2Vl?=
 =?utf-8?B?VUtBRnJZNi9YWURpZldHTkIvRTZKdFNVbEdTVG1QemxBdzJYNmtrVHMvQ0VT?=
 =?utf-8?B?ek1sR1paNzQxK3NNTHQ0MzdUcnhFRlFlWk02S3pFWHdOSzZibHNyUk44Mm80?=
 =?utf-8?B?bGpXaUM3aXVXdm1mSUg4dEhIL2czQ1MwNzhqU3FRM2RldTFNb0ZEeVhQVVNT?=
 =?utf-8?B?RkVVZlVvdjlOZnRNSzJBTGNkeXdNYWRFc3B3YW5jUXNJVFMxVnJxbWJJQ1oz?=
 =?utf-8?B?VmlWVjQ4SVJPUW4xVFYyUU5hS3FWRFp1WDZKS0hudVhqTVBGZFRRQ202SVBy?=
 =?utf-8?Q?7WB/wxbM/eN+fRQM8E0dNBjQP68jSUoO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 03:38:03.9751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca32cc3-adcf-4c91-335e-08dd522925f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287

Hello Josh,

Thank you for sharing the background!

On 2/21/2025 7:34 AM, Josh Don wrote:
> On Thu, Feb 20, 2025 at 4:04 AM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Hello Peter,
>>
>> On 2/20/2025 5:02 PM, Peter Zijlstra wrote:
>>> On Thu, Feb 20, 2025 at 04:48:58PM +0530, K Prateek Nayak wrote:
>>>> Any and all feedback is appreciated :)
>>>
>>> Pfff.. I hate it all :-)
>>>
>>> So the dequeue approach puts the pain on the people actually using the
>>> bandwidth crud, while this 'some extra accounting' crap has *everybody*
>>> pay for this nonsense, right?
> 
> Doing the context tracking could also provide benefit beyond CFS
> bandwidth. As an example, we often see a pattern where a thread
> acquires one mutex, then sleeps on trying to take a second mutex. When
> the thread eventually is woken due to the second mutex now being
> available, the thread now needs to wait to get back on cpu, which can
> take an arbitrary amount of time depending on where it landed in the
> tree, its weight, etc. Other threads trying to acquire that first
> mutex now experience priority inversion as they must wait for the
> original thread to get back on cpu and release the mutex. Re-using the
> same context tracking, we could prioritize execution of threads in
> kernel critical sections, even if they aren't the fair next choice.

Just out of curiosity, have you tried running with proxy-execution [1][2]
on your deployments to mitigate priority inversion in mutexes? I've
tested it with smaller scale benchmarks and I haven't seem much overhead
except for in case of a few microbenchmarks but I'm not sure if you've
run into any issues at your scale.

[1] https://lore.kernel.org/lkml/20241125195204.2374458-1-jstultz@google.com/
[2] https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v14-6.13-rc1/

> 
> If that isn't convincing enough, we could certainly throw another
> kconfig or boot param for this behavior :)
> 
>> Is the expectation that these deployments have to be managed more
>> smartly if we move to a per-task throttling model? Else it is just
>> hard lockup by a thousand tasks.
> 
> +1, I don't see the per-task throttling being able to scale here.
> 
>> If Ben or Josh can comment on any scalability issues they might have
>> seen on their deployment and any learning they have drawn from them
>> since LPC'24, it would be great. Any stats on number of tasks that
>> get throttled at one go would also be helpful.
> 
> Maybe just to emphasize that we continue to see the same type of
> slowness; throttle/unthrottle when traversing a large cgroup
> sub-hierarchy is still an issue for us and we're working on sending a
> patch to ideally break this up to do the updates more lazily, as
> described at LPC.

Is it possible to share an example hierarchy from one of your
deployments? Your presentation for LPC'24 [1] says "O(1000) cgroups" but
is it possible to reveal the kind of nesting you deal with and at which
levels are bandwidth controls set. Even something like "O(10) cgroups on
root with BW throttling set, and each of them contain O(100) cgroups
below" could also help match a test setup.

[2] https://lpc.events/event/18/contributions/1855/attachments/1436/3432/LPC%202024_%20Scalability%20BoF.pdf

> 
> In particular, throttle/unthrottle (whether it be on a group basis or
> a per-task basis) is a loop that is subject to a lot of cache misses.
> 
> Best,
> Josh

-- 
Thanks and Regards,
Prateek

