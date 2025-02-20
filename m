Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F11F12E0
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049011; cv=fail; b=tqUIHxKum8odq8iXH+vJkngNT/q+dYn/QKxh+mvjVKA7zZ/RyJ7/pCq3//hQBmvfR0tYDTfzF8kukF5MCeUwHpdOX4wflupwA152YVOh5A13WnasbF+SteGK/A+3Dumnob+/FqLEiqQM5BQjVtC9DjqsH17qsmqWWl7DDEXTyp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049011; c=relaxed/simple;
	bh=CxtzJI9enoo4NyM/DlyABw9Ub7NBxZgtaHZTlulK1r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tKqxL7pnRS35kfZFztb9dsY8oW5CvDsh6AK/BSzlhtRWccdQW9c4nAn1GO0h4V1KijD3hTmEu7LQxlyfNJNwONannBxd5osv27OhkvOc/Y6g2OtXOsG3/v3+aJb73iU6yabVuuHuBp+Ajp9TjVQmgiJ/MADARKk9OmjUFt9PBc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hJrt2GmQ; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hJrt2GmQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSy/rY3PR8kaTLDiknCDYfp6EojxMANMFVBn2U1W/q+AAeSzrcO70kFvkB0uSyPm4awPOCth4pu51RaJNzGCq7cOrBv8vxGf9qfKfiFe6HijhiYkp+8NxoShUseGvB28kBCg3xSli0Zhi4tL7oqYat8wEH/39Y8+Dxowi23GeGWkmeGt+6Hib2YvpmMg3cKJ/xKMb0+lE5jLD74z38J49YJBG4ZItEv24vDfGi3FU0s1U5R80fXFSMpbaozZIdbX6rf9dRlo1VfvfKRQwRem2sF9D2XgoceXXNQfYyoBxynk510u9v2IO33e+70qhHpHQBucmjo1lGSGS3wli6AV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Swhwgp7RA5vdRGKFE5K/EHYWItn6w9KAg6e32wqHiI=;
 b=j/uoMCtZKgeIqi38QFqRZRYSkdlfRt4P1hSt4bau8wXdhdXcAeHAVLbV9xroA9GBmOse3P6bcosl/7AkD/+YRIdZwA7yvLwDnVhXqMIea/3pg9rpu0MxSfxcpuKr03UUU6ZPvigGxqlJCLHRMh1lm1pUZudWayyhzFTlR6rbOcnN5DpDaFbli7ds3ZHD75GDUuWy/BCPYH9HNcc0/peF3e/WLi/tckPlFSdtNua2vSQrluKmojjGJgMBsEaTfvzV+JiYapOgN+MR3pV2GdUhJFykDy/l6/VExDDhMY3kbSzEYJuZfLnZvWcEYpB7fPDpQrTGJuleyTmMRWGRocvdlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Swhwgp7RA5vdRGKFE5K/EHYWItn6w9KAg6e32wqHiI=;
 b=hJrt2GmQT/Q3vrNW9CTgncwGG8SLGTnyh/10tnTrW7JJKUNeJy9K8usNK+34Y0bvpAel0ZHgaPUHJIbhDYT0Sd/23F5TjJMn84kcIBX94/Emqm/RcWGbIRAZffeA6ZOXgR79dOdeg4PUs96CcmZ2IvWegV2yqeGXTcfBWfNm1Ko=
Received: from BN9PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:fb::30)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 10:56:46 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::5c) by BN9PR03CA0055.outlook.office365.com
 (2603:10b6:408:fb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 10:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 10:56:45 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 04:56:38 -0600
Message-ID: <5b4aa0d0-62b9-484d-a95f-316f5defbc28@amd.com>
Date: Thu, 20 Feb 2025 16:26:15 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/22] kernel/entry/common: Move
 syscall_enter_from_user_mode_work() out of header
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
 <20250220093257.9380-2-kprateek.nayak@amd.com>
 <20250220104355.GI34567@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250220104355.GI34567@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: de99e257-aec9-4ebd-bc94-08dd519d4477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTRNcm5PMUthanB1SHFvQ2R2dnJzWVVmSUNhbU5CcmsxMzAwZXdUM0ZGTUFj?=
 =?utf-8?B?aDBEZUpXZlI1aFpMNDVxT3FsNldXZkxyWnRYL0c1NllQN0plSkE3M0xpcjV0?=
 =?utf-8?B?OU51TWY3WDlhVVNkTG16MU9GQjUxaVlEWmZuN1N3dnlKVWR0eTFTa3B1NGRa?=
 =?utf-8?B?eGw0UTZXQjhDdC83dU4wb0Q5aTI4VzRsNmFNM3lybExFT3BzdUo4MlZEd0tv?=
 =?utf-8?B?bnF6cFVhcnRSRXBha0VLUGU2a09NNFRlY1JYZzlqdHRtUTkrZkNVRldwVlJk?=
 =?utf-8?B?ZlJxRzhYWWl3MW1haVc3aTc1ak9PR25Ud0EzQU5zenFHRmxMVWRQMDJGMDFQ?=
 =?utf-8?B?dHRON2R1eExVTXZsNVZxTCtGV1haaTRSSG5FYXBtNmx1MjBsaGNQSGgyaHRk?=
 =?utf-8?B?Sm94UkZER2ZodkYrRUpSb1ZwUVNZa0lIc2JUa29ycTZvZ05jRXQ5QlZ6Qzgz?=
 =?utf-8?B?Y3pnUkFYZTc0RnBrM0o3NHRkZTNBaitzT0hpSzY4b1ZvaElRZS96N2hFNHpj?=
 =?utf-8?B?bWN1eHdOOFo2SjJLRkgxWHYzZmxaWHVNTE83blZaS3ZoR0JTVHBXN2I1anVL?=
 =?utf-8?B?b21VTC94cVdGWDRNekVUWFZzS3pGVTIrSHZ0ZXJHeWZqL0JhODhqeUNpRTI1?=
 =?utf-8?B?RlR2UFBGS0ZiRklQdUxsVitYOGhFR0E1aGpRSzh4V3h2WER1cFB3M1RubTYr?=
 =?utf-8?B?TWlPM0NleGV1c1pseTJJOXorSCttNHFVakFTby9MZFZzOFBZU21uVS8reDRX?=
 =?utf-8?B?cWNIL0xkOUFETEJUQTVqMDFvcThVcVc2MjVLSkVha0luN2ducnVaZjZvV3A3?=
 =?utf-8?B?bzJVc2ZIVjN4YkdqKzhjZWpPbXVtT1d5Ulo2cmNkZVp6NkRnakl6RkdaRjdR?=
 =?utf-8?B?VHYzOGhZMUM1dEJqTG8rZU1rOFBjcEQ1d3lYcUZJcFdEb2lHU0ZBNG8xSjcv?=
 =?utf-8?B?RTBKMXJ5KytybmVoaDJ3bmJETUMyWHJoNEN0MUVaYm9nM0RuOHB1VzJEYUxW?=
 =?utf-8?B?ekRCQnJQOXJ3N2RjOWkzMkd4dXNRKzhnbGxRMzBHTDNDZXVLblRzMkF3cHZm?=
 =?utf-8?B?Z3dGK3JsSTJHa0J5Tk9yRXVISER5M1g3bzB2cEQwcnIxaGNUZi9nYmZtb05W?=
 =?utf-8?B?bkMzVkJMTk94dHFibDlaL3VpUGZQTU5uTldNNU9weDl2S1VSVGplNDh1Tjkv?=
 =?utf-8?B?dkxYdGo0RjFrOUhIS0x3ZXhxbDNROG8zM2FyUkhJMUVvTU5iSUkzWEdtM21I?=
 =?utf-8?B?aXhiZktTUDlJanhWakZCVEZyTXg3dC9VRnBGTitpWmFnaGVsSEpTUFlDZHl3?=
 =?utf-8?B?NjNpUWpZZUdxMTZmcUN4SjVPVHpITUxKZ2VDSG1lTkdRR1RiMm10MFVEQVgy?=
 =?utf-8?B?UUdwN2tqRVoxRkZ1OFdiUWsxdlBhZjN1bHNJYmtkTUROdEkzYXN5NG1VQ2kz?=
 =?utf-8?B?YVBWeXZub3BBQVJjcStVTVZnUFRMbldQeDBrZGN5SDY2SmV4UjZUUHNjdFRj?=
 =?utf-8?B?N0lxdnhQQTNxQ01MNkQwVFI4eXNxZzlCa1E3bHBNUkdUUGVKaUVCL0wzZVBV?=
 =?utf-8?B?eW5NRE1QbXZOY09abjlhbHZNZzQvNEZJOEFYamdhdU5aMitESTYwcGs1MG1Q?=
 =?utf-8?B?cEVpaUNTOC9LUmx6MVRxaGpYVUc1WDlkemNyZWhJaDBmQ0xNWXphVGE5aHdk?=
 =?utf-8?B?UWlPVWdTcWdWcW5JNm40dFl0d1d0RlFvUStDNG9nL1c0ZWUybS9EYzBNUGUx?=
 =?utf-8?B?ZUI3S0pGam4wMGZFeGJzKzhOU0FHYVZKQlZFc3p5QWpSejdSVFRuUTZuOEVM?=
 =?utf-8?B?dmpUYTQraElmZ2Z3UUVOOGFOQ0dJK3REbUkvaCtPa3UvbGZmaTZRNGdkWm9J?=
 =?utf-8?B?aWw0UzYrVDNKRlJ2ZmZTeVErTUhxRDJtV2szWmVuVTBBN2lwbDZTbmtLWWpJ?=
 =?utf-8?B?QnlKa0dJOVZIZUxzTHF4U1pPb3QrMnU2eEZ3Ky9iRHNPU2NxRGd1TU44cG9Z?=
 =?utf-8?Q?tPYRkg7JmpeyJCNaTTN7z4Ni2MC+c4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 10:56:45.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de99e257-aec9-4ebd-bc94-08dd519d4477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

Hello Peter,

Thank you for taking a look.

On 2/20/2025 4:13 PM, Peter Zijlstra wrote:
> On Thu, Feb 20, 2025 at 09:32:36AM +0000, K Prateek Nayak wrote:
>> Retain the prototype of syscall_enter_from_user_mode_work() in
>> linux/entry-common.h and move the function definition to
>> kernel/entry/common.c in preparation to notify the scheduler of task
>> entering and exiting kernel mode for syscall. The two architectures that
>> use it directly (x86, s390) and the four that call it via
>> syscall_enter_from_user_mode() (x86, riscv, loongarch, s390) end up
>> selecting GENERIC_ENTRY, hence, no functional changes are intended.
>>
>> [..snip..]
>>
>> @@ -79,6 +79,16 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
>>   	instrumentation_end();
>>   }
>>   
>> +__always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
>> +{
>> +	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>> +
>> +	if (work & SYSCALL_WORK_ENTER)
>> +		syscall = syscall_trace_enter(regs, syscall, work);
>> +
>> +	return syscall;
>> +}
>> +
>>   /* Workaround to allow gradual conversion of architecture code */
>>   void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
> 
> This breaks s390. While you retain an external linkage, the function
> looses the noinstr tag that's needed for correctness.
> 
> Also, extern __always_inline is flaky as heck. Please don't do this.

Noted! I'll try to find another way around this.

-- 
Thanks and Regards,
Prateek

