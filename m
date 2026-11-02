Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793630739;
	b=s7DQ0FsxWuOb0WFAxTqy25yDytyo8WRgDMJoefAYn/wy+RXHj1DUzmARUWHnTjTjQ0gS
	 2LDGpf7MM6XZ5nS1/iD7AhSGByGfYSo7EqjeO1V9tYaIJW98NDU7lOQb349l1UsADiSoQ
	 DAtbVPjc6BclAL66wkOborcnAz/MQrDFVwkCP0H7r8S8CBB4aV3NyFsnQXQZ3eIxc6yIW
	 X/XaTV6cEwKs7e0kbfTFPcdwcciXDPbN/R5bu/pb7/jDNUxWaitkxyeoZ0eaTpgv2iDK4
	 U8wsRRXOMBzDa+Y1WoPLUvCTVmMFpheCGYznZZ3AOw93N06RTYUJvTaA/jPBhKKBl3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630739;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=o02rHD9v+JGcz3ggq/xWtxGHij5/nt/N2OmphlHjnUk=;
	b=fviuZNVInYemu5U/GKvoOxmV0AU72Gy5ceR2TDzaGyog8jboVuNWwWfWWjNRjjN5K7O6
	 hiOjdEwk/+QcWVQkt1mni/jBVRoLnHtqdkeAFidCjjSbVgySfl2auO1ImEwTyJ6LV4Q/I
	 594yBcGgl6CBX4pAc0ueX6cJBSWuieRCU7Rmcn1PDNBjyR+o+wP2ElYTcatHg9onMh2mV
	 iKvzNJK8bDfx7gimgn+DpqKZW6GgEqGMySnCjLRN43E1ZO0JC0gappKTIXDnNokDnpqp+
	 ZRMs9u1VlLwaAS43iBPOm8ln1/9G6gcm1jdV2Nq/tgBzPYjAVfMJx4xvr+n3RDvYD/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.139
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022139.outbound.protection.outlook.com [52.101.96.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5FE606C56D
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 14:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D5FE606C56D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBTf2m2+bF1MgAN2ZMWt6qPkIj7NyAXs3vRylYg81bB0dPBKwX5NL8Lc7W7WNYpkbXkpoybTh413HrXN+3+33RHUQJgDowAf8z2thUbuM+omqfU6qkpgj9uo0BahYBK1Kno7Lx7QEN6JWGqNJsRcut8wrxgTFbTseS3KEL/OCwIDRV16t3OdxcN0v98zRbaWJJ+GOnMHiEDqob9o5usE8HgjgJ7DZJJ7CgsXpNJ0ZEjUuX+HdnQOUxpcH0r7e4e8qsv6YUjax0i1QfOehVneEijVjM+cwMCjn3HsZWLbmCCTImj0ZQPmH8Xm6p/MW9kGw1F6NNf/2Lr1auKKcuyDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=o02rHD9v+JGcz3ggq/xWtxGHij5/nt/N2OmphlHjnUk=;
 b=S1OxSJ9wKtkL+/ti/N3dXhSv0ofzHj//7o9npJRyBlFLO8xBhucde3v2adDUTlfh6o1bKXmj+LrQpsDIrX3hFJvMQnbT0wAkeSkw/+iSoCE0uOTFJx21lI3jQhWPjiT841ge4jcvYFJrenCqrZw7hFmf0XqGHddcYJSmXqnx+RQ6BLnhVbObqmAtXTkBpzz4WCK0gCzYludutd9z5ODjk0XH/SX7U8oroOAzteWDR19T0rOy5u166BttuLb3lHolbJfClb2QeWBq8l/DVqIl5aSPXeRJ97FEIsdX/TyALHxKvGvvvbwOhvAyCqNoroh7bO4E7TXvuBJV6Q9hraLYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:45:34 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:45:34 +0000
Date: Mon, 2 Nov 2026 09:45:30 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix spurious -EPERM for
 migration-disabled tasks
Message-ID: <v5c3zc2sy66bsummtsvw6ciri65kc5tphm6xs752ifh5eujn6k@qflvq77fph5d>
References: <20261102135420.244745-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102135420.244745-1-parri.andrea@gmail.com>
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWLP123MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 860dcce5-64ef-44eb-a80c-08df38eff330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|20052099010|22082099003|18002099003|261102123227099002|56012099006|261021135927099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	fY4ht+2iwD/2rfsgwl+Oo4tJhW+2JiT85F81P++fDLayOkL2a0ZTTR8lpIvhGvUI1AGh+8HRY3DRVfhGD8J4F0nXKHgO6eUEAz2xqXG9pXhdAbnUkEu5OGsS2a1yNVp/warqbBLs+9jLLL4wsZWXFEjx26RUe8IwJf2Z0fiZelDyB0uSgyZHTtMGueEPr5st8WUZP3m/azGZsfkq+BZVGI/KFHLT59YCTYcDxmyOQLjyp+5XcVNfje/xd3B7kj9ocrlynkg4UgJ//yP6cXjg9Budw+MQo+J7i17/inYa0u84uOKCuywfu/cXkY1tI+tXEG2CWZprsG0H2oyxO/JA+TNAuiFmOzeAKWbEmsL3feAd5B6lzf4UZCzKhLsQJ3Vz2PdVa3SEUoydae81ptQXeeMwrzI1NWvPQGAqGkwLQ6B3mze0jqf+at1nQFOwmxVG87+K4Xz8jcFm7R7UgkGkF/uW0rqFGnia0VxhVMI5MOU9d9ecJVnxPlQDXJqZAF4uA+UxZmClkYFR00mMztnhFvmz+nxSB0ioUcHN8ETufePIJ8XrcYT4iahMnqnfzggMsejbqKsc40QVKrBaDvyxaiAebyPS9anpQbdH7Ht3KPTiWXMmA7Tlo2G75GLLwTTy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(20052099010)(22082099003)(18002099003)(261102123227099002)(56012099006)(261021135927099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS9pbGkxNVo3a3AxalBMcUtaK1hPc2hkeXkvN3VibXJ0c3ZtQ1J0QWRNUnAr?=
 =?utf-8?B?enZFbnR6Z0g1VG9WYVRaV1FuQWJ1UUxIdUsySVFqMjV0Qzh2ckp1ZW1ocE1w?=
 =?utf-8?B?amZUZkhjbnpVNE9VdEFVMzgxL2R4d0RRalpYMVo5TDkybml6VWFTY2lqRFBT?=
 =?utf-8?B?UnRFdTRyMmxDcU5ydDZmUEdIZFRveW1HZFlPTysrQ2M0YmlLMHRIVkZoR0l5?=
 =?utf-8?B?b0Rrem0wMTlic2ZKTFpyZEdxR3F2bUFyME5SemhwTGtyS2lhRGMybUxnNEhE?=
 =?utf-8?B?d1F5YnVxNUwxbjc5QXpiaGY2MmRYNjFYb0MvdWRndnNaMy9YV0hjMmFkMXE2?=
 =?utf-8?B?K2FNbWhxOFlRZ1E2aTJOc2dpT2w2U29tcXowREg1UGhhWHVUZzVqSWI1V2Jt?=
 =?utf-8?B?UW1vdlBYQWlWam4zdDVLQ3l4bitmRjArNjJjMlR0VFdOSHFzTW5MczI4cDM4?=
 =?utf-8?B?QkRNRmFvc0lDeHlrQUdnRU80UjEvYnRFSnBVQURHUysyRXRldmJmcUJTRzVo?=
 =?utf-8?B?VlF1THlYSEQ5eThoRFpIN0hpdVA4Y00xems5dG1wWFdhQWV6bTQ1ZHFGYWVL?=
 =?utf-8?B?cTJLSWVEaXdPU0dJQjBOY0UrZUhmcGpTNlBCRXo4TUNFb05FbThJbTZxQ0Np?=
 =?utf-8?B?cWxjWWsxNXhZczNLL3pzWEdwdWFMVU84SUxXenBkS1hPOU1MSy92VVU5N3VG?=
 =?utf-8?B?dmVsa0RpbGxBTnF3N3gzcksyNFdFbHd4WVE5anloZitXTDdYdjlwL21LQWV4?=
 =?utf-8?B?bXRlVnF4S0YwWVFJMm04SkxQV29jNFFFRjhhWEhUYndtUGlqMUFsV3kvL1U1?=
 =?utf-8?B?VjAyZkNWZklPandBUGNjUG9qZTdMR0tUTWd3S2s0eUZKTlBpdVA1UEs0bC9r?=
 =?utf-8?B?R0d4eTVLbkdTR3NIYkJuQTNDaGl3dE16TXFIbWVFZUdmUmc2N0p2UnZDZGxW?=
 =?utf-8?B?M1c2Z3VhdWlmYzJmYVZWYnUwK2xnWjYvV1E5WTRFeG10d1EzemNsSUJDdE9R?=
 =?utf-8?B?WThZQmwwT2hjSkdKcTZmT1lzUjl0bExnOU5YdGNMUElZVjBzTmo2eE43Yy9k?=
 =?utf-8?B?TGkvZDJkbkovR1MzaC9IbkhNYk5yK2JHQmcvWXliUUdSbG1JV2RPWXBQLzJF?=
 =?utf-8?B?eTM5NnNGZ1pHNEV0MURibHZ3Um5zNjBIekYxaVdrL2lMemYzOHlIUUJzNCtl?=
 =?utf-8?B?aXZoaVErNGpxWWgrSTVLbVpCakUyYzBBOTNwY2hrUTczWlVqNGtlQzZ4akR3?=
 =?utf-8?B?V3hFaDNDWGR1K1A0eDNNZkJ3dHBIRnoxSFpaQ2FGemk3R3NHSE5SWjFETUJI?=
 =?utf-8?B?WEFKRU5TdnFqNFJ0dnlOei8zeFZpSEJzV3VzRjhpdDdBOUZyQ0lKdjNiK1JV?=
 =?utf-8?B?S1g5ZXgzeGpicTh1am1wZEcxaXVwakFHUGgzWjZaMTRpMklYS3dMQzZ5a0lj?=
 =?utf-8?B?c3JKNVBmaWd1Mjh2cy9uSm50cGxpTXBUM0dtMEp0cVE2eW81OUNLeDFzTGYz?=
 =?utf-8?B?b1JQNVNVRmdST0g0ZTZZQ0M4dmRKZFMwTXhIS08zSUF1OE9VaXdhTHdpcmRN?=
 =?utf-8?B?dWVNYUlTQU9mVzNreW1nMmc3bmFuYS92WmlZem9TK1paSjJ3SERkQzFBN3FS?=
 =?utf-8?B?Vmt6T3p5b0FGeGhpZnh1aUpMZElsVS9UYUwwWFozRG96U2o3TUNFWFlMZmhp?=
 =?utf-8?B?MUdndjZCTHVkblFCTnU2cDB6T2pYUjVwclYyNU9EYmdsSUM4bDZKTHRrcVVi?=
 =?utf-8?B?MWNSc0d3VzNPSnU0cDRtQ0VGK2NWWHJ5QWk2VGw5ZTlyZ3pFWmV0Tm1mRmpN?=
 =?utf-8?B?cXp0VlRqUlBPemI3eHVML0QyV1RrSjVwTU05KytzOEpySDNGSTVGTXNTUzI2?=
 =?utf-8?B?ZzBnVjc0NXI1cDFzTm1lbkExcUVBcVBybUhRME1DQms0Z09wN0J2STZoc3A4?=
 =?utf-8?B?WjlvWGtXMG1ZVE1WYWJvRUsreUZGNlY5aURONGhOVTBXemNlcG55Umtxdmdh?=
 =?utf-8?B?elIyc1JrMCtzMGhQYnJ3TFRQOVZwMldOUmRiNkNhVFBQYWEwNGx5WDFxZWdJ?=
 =?utf-8?B?SnQrVG9yVTY0empSNVBESmh1MUFYM25kVVBGa2RUMVlXL2gvYnIrTVYzcko5?=
 =?utf-8?B?eElTQmZLYVpWRTJyMHhFN014UHg2cDF5Z1RGRUR5Y0ltelBFQkFNdkE5YWtT?=
 =?utf-8?B?aW9DUVhGd3dNdGNSQ0kvNFBBZEFESHBEMFdsNzVoMHB1bTlEalJIWHpGS0Q2?=
 =?utf-8?B?VHRJSERlTENMOVpwTUxZSnFGdCtJeWI2NmZqdzR0azBOVWxRN0UxemJRWXMw?=
 =?utf-8?B?QzI4bTlsS3owVjVja1AvcHlvL0NKdHNRYjhXeVU0WHB5dk9Eam1jUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860dcce5-64ef-44eb-a80c-08df38eff330
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:45:34.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pofWSYccOXeanecgV+mba5kCLm0Vslu58+dRZK0vMQrpW+5267RSqROEd26A6YS8RW6w/eUbAYlrEyUvVudyXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6574

On Mon, Nov 02, 2026 at 02:54:19PM +0100, Andrea Parri wrote:
> sched_setattr() can refuse to make a task SCHED_DEADLINE with -EPERM,
> even though the task's affinity covers the whole root domain. A retry
> can succeed, but the error blames an affinity the task does not have.
> 
> __sched_setscheduler() tests p->cpus_ptr, which is not always the task's
> affinity. When a task is scheduled out inside a migrate_disable() section,
> migrate_disable_switch() points p->cpus_ptr at the current CPU until
> migrate_enable(). On PREEMPT_RT every spinlock_t holder is in such a
> section, so ordinary kernel work opens the window. Elsewhere, seccomp
> filters run in one.
> 
> Test p->cpus_mask instead, which keeps the task's affinity and is what
> sched_getaffinity() reports. This should be safe because an admitted
> task's cpus_mask covers the root domain, so set_cpus_allowed_dl() moves
> no bandwidth when migrate_enable() restores p->cpus_ptr.
> 
> The following program, run as root, had 553679, 453720 and 424623 of its
> 1000000 requests refused on three boots of a 4-CPU PREEMPT_RT guest, and
> 236182, 217174 and 237183 without PREEMPT_RT. With this applied the count
> is 0, also with lockdep, and a task pinned to one CPU is still refused:
> 
>   #define _GNU_SOURCE
>   #include <errno.h>
>   #include <linux/filter.h>
>   #include <linux/seccomp.h>
>   #include <pthread.h>
>   #include <stddef.h>
>   #include <stdint.h>
>   #include <stdio.h>
>   #include <sys/syscall.h>
>   #include <unistd.h>
> 
>   #define REQUESTS 1000000
>   #define INSNS 300
> 
>   struct attr {
>       uint32_t size, policy;
>       uint64_t flags;
>       int32_t nice;
>       uint32_t prio;
>       uint64_t runtime, deadline, period;
>   };
> 
>   static volatile int stop;
>   static volatile pid_t target;
> 
>   static long set(struct attr a)
>   {
>       a.size = sizeof(a);
>       return syscall(SYS_sched_setattr, target, &a, 0);
>   }
> 
>   static void *worker(void *arg)
>   {
>       struct sock_filter f[INSNS + 1];
>       struct sock_fprog prog = { .len = INSNS + 1, .filter = f };
>       int i;
> 
>       /* Reading the arguments keeps seccomp from caching the result */
>       for (i = 0; i < INSNS; i++)
>           f[i] = (struct sock_filter)
>               BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
>                        offsetof(struct seccomp_data, args));
>       f[INSNS] = (struct sock_filter)
>           BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW);
>       syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog);
> 
>       target = syscall(SYS_gettid);
>       while (!stop)
>           syscall(SYS_getppid);
>       return arg;
>   }
> 
>   static void *hog(void *arg)
>   {
>       while (!stop)
>           ;
>       return arg;
>   }
> 
>   int main(void)
>   {
>       pthread_t t[9];
>       long refused = 0;
>       int i;
> 
>       pthread_create(&t[0], NULL, worker, NULL);
>       while (!target)
>           usleep(100);
>       for (i = 1; i < 9; i++)
>           pthread_create(&t[i], NULL, hog, NULL);
>       for (i = 0; i < REQUESTS; i++) {
>           /* SCHED_DEADLINE, 2us every 1s */
>           if (set((struct attr){ .policy = 6, .runtime = 2000,
>                                  .deadline = 1000000000,
>                                  .period = 1000000000 }) && errno == EPERM)
>               refused++;
>           set((struct attr){ .policy = 0 }); /* SCHED_OTHER */
>       }
>       stop = 1;
>       for (i = 0; i < 9; i++)
>           pthread_join(t[i], NULL);
>       printf("%ld of %d requests refused\n", refused, REQUESTS);
>       return 0;
>   }
> 
> An LLM helped find this bug and write this patch and its test.
> 
> Fixes: af449901b84c ("sched: Add migrate_disable()")
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> This textually conflicts with [1], which rewrites this line and keeps
> p->cpus_ptr. Whichever goes second needs to keep &p->cpus_mask.
> 
> Also tested on PREEMPT_RT with lockdep by holding a 1ms/10ms reservation
> for 3ms at a time, so that tasks admitted while migration-disabled reach
> migrate_enable() as SCHED_DEADLINE: no warnings, total_bw unchanged, and
> none of 6788 requests refused. Without this patch, 826 of 6645 are refused.
> 
> Other !PREEMPT_RT migrate_disable() users were not tested.
> 
> [1] https://lore.kernel.org/20261030151307.768523-2-atomlin@atomlin.com/
> 
>  kernel/sched/syscalls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 45a127deeadd9..fb8f332074b88 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -628,7 +628,7 @@ int __sched_setscheduler(struct task_struct *p,
>  			 * the entire root_domain to become SCHED_DEADLINE. We
>  			 * will also fail if there's no bandwidth available.
>  			 */
> -			if (!cpumask_subset(span, p->cpus_ptr) ||
> +			if (!cpumask_subset(span, &p->cpus_mask) ||
>  			    rq->rd->dl_bw.bw == 0) {
>  				retval = -EPERM;
>  				goto unlock;
> -- 
> 2.53.0
> 

Hi Andrea,

Do you mind if I include your patch in my series [1]?

Also, please detail the LLM used as per Documentation/process/coding-assistants.rst:

    Assisted-by: LLM [TOOL1] [TOOL2]


[1]: https://lore.kernel.org/all/20261030151307.768523-1-atomlin@atomlin.com/

Kind regards,
-- 
Aaron Tomlin
