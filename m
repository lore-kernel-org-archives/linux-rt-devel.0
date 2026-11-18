Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795036281;
	b=42HJmdbPAPtDCj9dCLWlQYyn9Uk9yNp+N4yuZ+Qa5gxtXW4wydG3fPG0JQXTj+JADDEj
	 Z2FP8VSrn4tJwwPGL+31GwBBCGhHFqjPzk59V5Z0TZ1OeYAzlvrFtqjA+t2tfPwY4SSMJ
	 o9qwP4abAiGvUtk941eMZz1+ohgU3E8ymJFww+BnOuO1avPuyxRheXAqEhmDEBs90BefW
	 Nt6vQeG5t9gpWVrCCQ/48yi6Qb3mzoQrDBkEDU32DS1d3DXhj+meNCe7myC5q7lagYK7J
	 Qmjof4Nj7FxFV3KYIjo3En3nJk7oQ0LlSuvn4q90pGxynKJUZQc8sCo2uG0UbBvELGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036281;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vauRDhwAs6ZUMK/+xAGhDGlTiezcjHNh6zc9sitromg=;
	b=u1kykIs6rN0Ss1//Gxavw3NGDM2UBqdOpXLtlwLfgBsev4MdpWSAwRjcR9bh8NHQfQ8u
	 vBtkZXeHemfWlQ22N+3w7ANU8AD7xSizIxjf2UQII2oYO4nLqDFzbQTMSrYKnaYmehaDj
	 Da6hDGFrhozg/mTLNzltifttvRFT5LlkIvz3MMYdNpnLzUPfNNdwJVGsJN9+JOnnYlX/C
	 A45iOEA1bWw4wmQAnuKAt12nqVmuetd9lezxqFrC4St6CDTUqnUFIuVeuUo/4PLuvx9kQ
	 dDNVE+6hxsuZ6F6OUgJGptiT6sGpqB/CrPecUnguKRSWNRodrJP/p+pwlbgzzzQb3QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=mChICBvE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.89
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022089.outbound.protection.outlook.com [40.107.193.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7D606A33D;
	Wed, 18 Nov 2026 21:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BED7D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=mChICBvE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJJiGDXYWRbqpQRIrUy2dbzAckyOv7FSwTs/d6XuUbMl2qIuGuUyrs/csVMZaDU69zKPqdrj9GSuAxdGkR6Bvbk9RR5YBTVkYVEZW0ykuu7LPvE2m+YY/qNqQN4rjwKTATqBMsoMBWMYt7c2p1VQWgrw5C/h8FU8E/TvU42iX9D8hhrT8CFIQOLsYBHps6dpYphJ+Xbx+Tj3Cxj60sRiS6BCcCD8G3G59jVqN5LIF19PBwjLLKCEJzoLWagP4MhAweqDCF3bEz/+4MLsb3gOJFDjqr9TbLquUoqmGrNAOc4g+gc3LsdXf+0+HrZC/uOfM+5gRik3sgM+j15bFjoK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vauRDhwAs6ZUMK/+xAGhDGlTiezcjHNh6zc9sitromg=;
 b=QYof/6NdxhzHIHG+aeOv6+Ffw/29Y1ER2thbBzmZB/vT6PvJXDktQ/gnRHF5ygoJgtnsPCvrYDtZc47RhmSsVUz68iRsn7b28zQ9fqE4T5Dug2kVp3IWgOfoQUCYlqfosFjAQ17gv/By05XJf4OejXg7OLImnHcd7cY1u+u3PODYErYWU5onHMAxG8es1/t8UYd1dQf39RIIvYbCv7aU1U7U4inagbbBnY0wZAlS7UI1oHn37axyitz6wURgUjT2lWHrPvbaVLmrNO3y6DczLzmqYw6UAm+i1RimN23wizOf08SV0zBXEBpfDO9bjiw2v+UD8YRr8vp7BD4ZN89D8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vauRDhwAs6ZUMK/+xAGhDGlTiezcjHNh6zc9sitromg=;
 b=mChICBvE3FlgZU4xBTCAyPndudXFnTkGJVj6SKXgHeOhr5HG5CKaKfs4axgoWohy99cfPOAuEaM/EDAnldGfbcd0f/2cxIWCKAhQZwxGrjC9Hjvpe8E8UnCD9rtjDzzkYdpQTRuzlCSUFoDfWne0LH4uADzFp6pRD6paA1unK0Y8NsscdfJmW4V6pP3fQoRdj07F3HYjieKmERYj6VV92DqbsFXoBfEJ+BVp+G+4+zmorFxwRXUUgyNt/qtIj1J1mXznDxP+H6J+Tk4H5SixAnwOBbzeHCqSUjmkSIPHjs48QOBVj340XAReSMRWrpRlvYOgra8t1o1fNGc1KWEXyA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB9803.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:8c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 21:11:14 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 21:11:14 +0000
Message-ID: <57d55cc0-cc52-4d0d-8a7d-0ec4252ac04f@efficios.com>
Date: Wed, 18 Nov 2026 16:11:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] sched/deadline: Fix this_bw when a task is changed
 during a remote wakeup
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <dfe9865764c347295703c25e9a781438784f061b.1795031605.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-221950@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-221950@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0192.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::13) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4a241a-1f18-481f-0ebc-08df45b87a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|3023799007|4143699003|56012099006|261026121527099003|261028144727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	vcZ6npr8cVztqGk2dNWTfixvPiWWo4U7EDlqD32L/kFmk0kplajqSpkQRqvon9ypnYJvZn/fNOWP6rogiA1JUlaCIQSdRB8Rm9YdOeyIqSf3J9imP5ufhad3403Pb5nSfEP6Yac3CEcNvksCtsdCxNAHBh9NZCK0y5H+tzWF5z2UAVUcC8Gj9VnhcTGzEAL/v+HctymsaxkjIHK7jwTER0cF0yssI/uTfsehEAx2ALBugCejKlE8SZlDkkK0GrNC1LSHoFpbnQoWwPEzjZnYRg/kMB4f59peWQLdhgTX8ZLpHkwQX32BCqIBA3tJWg90UMaGZPWiG09gKzfEPsNv0vh6HhJGfMX3wi07uArWAP5KffioWeNjSt6epvQdic8VYk2e5f7WSXCClkIdcaBB00JSsQb00VqnU0K95pu2pNuVk1ysmq5/sXpiShcTU+a4SV+XgF8ahwFVB0lWT78go88mlnFi6omMhLz3G9xBzBGZo/BPT4eaaEU/kIXMIVhuqVEd19os2wAGLpd6MD1nbxbmv2oDZRzTUDK61K4+t1ptv5zDjY3wp02/r4OboJQRaDTr1lhfgech1uoPimU361bX8OrBUNmwjnYneJCIkfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(261026121527099003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHBBWXNTMkFhUFkybklNZE9OTGhPQ0FHYWQ4MkJoYXkrcUxLQlJQelFNd2Zk?=
 =?utf-8?B?Vi93OFZtUC9DYVJUNGJjV1ZPZzBZZncxenVqQXh0ejF3UU9meXR0bVI4cXFI?=
 =?utf-8?B?R29YSmR6NFZCRmQxR3kyaldqWTZIZHNZSndRY29lS05jeWpNR1U4WTBtaks5?=
 =?utf-8?B?Y1B6Tk1WaWN1Z3hZcXJaNHpSZ1MyY3o3QXJZSm96N2tuQ3ozTGJvc2FKN3pm?=
 =?utf-8?B?UXNtTnpZcXRnUkw4aDlWNGdMbnNGM2g3cTNqRVE3eFdVK3BWVForMnlvRC82?=
 =?utf-8?B?ODU0TUpIdlpNL214ZEdIYk9zMEpGZDVaeVhpMGdUZGVuSmFTWXVCT0piTkFM?=
 =?utf-8?B?NlA4ZUpFbDFSVnBrdXBIKzBXb2dNQ2pmbk9VakFUelJ6Vi9QVTEwemZJMFZG?=
 =?utf-8?B?VUlVbkxoU294Y0lvbW9NOUxIMndTYnB6anhGZWZzNWo3Y3ZUNGFrbTBFQ2Nx?=
 =?utf-8?B?NTR4dkJodERxZko4YU0vZVJZcFZialdNcXA4ZnBhVmJGWmFscDI3T1cvckJ5?=
 =?utf-8?B?cDROejJ1c3JjTE9WQ0NFNzdWQUwyZFdYbC9NNGdCNGhIS2Z3SlhFMHludXMw?=
 =?utf-8?B?M09XazVobExtSUg0UEF4WlJnUGlIQVdKUFdJSmFSQnR2bjFyOVVrZWlnY25K?=
 =?utf-8?B?c21iMTNyRnN6cWUyYTlvMGFZUmwwdVdDdURLOWNZemRvdVdiM0REUTBBbk5n?=
 =?utf-8?B?YXdMZHF2ZkR1czZSeHNSRlZEMWszVkdPbDR5VmJFeXZTNHJMdExWMGtNSExP?=
 =?utf-8?B?R3BkM29adHhiNGMvd0hCNHgzU2tBWXVCanZkcXdvdERpd2hRNW8xOTBXRHJ4?=
 =?utf-8?B?ai9SU2l4TklSSmlYcTEwcnVBaG9LT0U2TU1hN3k1YWVtSlNLUkNIMmpUQ3ZN?=
 =?utf-8?B?M0ROcWdhNHJwQzBQdmtBOUphbnc4bTVwMkJUeW1hMUdvc1h2VUd5dHYyVVhX?=
 =?utf-8?B?NGxMai9FZVUwcmM0OFJza0Nlb1hUTkV2SHlFNWdZTnYzZmJ4dW5abVV3WVVR?=
 =?utf-8?B?MlRRaGkwUGJFdTNqdGpYWThST2Zrd3lKR2FlU0xHMWU3UDZ2aDBibkI3dmgz?=
 =?utf-8?B?ekZXZTA0MmFISmt2ZjQ4YTJPUWRIV2t3OTlFRGlGSE9SeG9NRWtGRE1udEtn?=
 =?utf-8?B?ZVlQWFJBU3lHeDViV1NyMTRsZFRVWGllZXlHbUM4NlRlcStVMnJNYlNuVzlL?=
 =?utf-8?B?d0plWWtBUEJxVmpaUHAxYkpHSk9ENDB2cmlteS96enFGd05UNWtuaSs1Qk1P?=
 =?utf-8?B?NVVRK0Q5NWRweStkMHRGSzN2MllBK0lyV1FsWEMvRHlJV2dYbldTTm1paGhV?=
 =?utf-8?B?QnRIRHZnbW44MVRZYWVNN2RRUzlHamp0WFl2WEdJZ3hNc1hMd2VUbjEzck9p?=
 =?utf-8?B?V2tuZktDNlU2c3BuZmI3Z1Y5ckdFRWt6VVRRSXVGUmRGMEs0eFlHZDlmSlI0?=
 =?utf-8?B?a0RZcDhHaDUyODVvYitHc25zM0pHS09HUXdlelpKNURYdGlQWnU3aDJqT2FO?=
 =?utf-8?B?NlVzb1lmWUUyT1lzS0V1R0JJRmd1V3JsZ1llSkt4WkgxYVdOQk95SFJzVG0w?=
 =?utf-8?B?YTI0MmtKcTc4cGtNb2pyQUE0RTF3OGdDREJVM3FlQmFsdmdFd1p5dnpSaERD?=
 =?utf-8?B?M092bHZTdTY5Wmt5TEZBc29iM1F6MmVnZEdUeFl1RTRZYTZQcVdreGxyckVQ?=
 =?utf-8?B?RjhqSVlTdkRNRWY1LzgwWmhJR2ZUM1Q3dmN4ZkM0bWJTK1pwZnlOc3BScmgr?=
 =?utf-8?B?cWVUR2NRTEExazI5eGhtZm5BNUlBMk1BSlBEMEFEVGxMYWF1cTd4R3M1c242?=
 =?utf-8?B?SEdOODRxc1l2KzdzK0Y5SFBubzNZRmRpZGIyZDF2VG4zOVRTVVF5bXhYZGU3?=
 =?utf-8?B?K1o3ZlMvYjFKdlAvenBsTlphNDB5S2duOEdmdlVsWVNkTCtVa25iVStIcHFi?=
 =?utf-8?B?VnBjVFRDTFNVV0U3c1JaUk1LRkNJZ2o2bmdyT1lwYjdBVmJGUXJkWlJEMEVu?=
 =?utf-8?B?OExMQmVqSjVlSVJ2NGo1VnJ5c1VldE5jbFdNL24xM2pqSnFwYXJSOTh5ajh2?=
 =?utf-8?B?OTRQR0FtbWgybUhiVk0vRUZYRHR5YzhVdjZRcVkwMU90QjlLWElJT2IxMG9S?=
 =?utf-8?B?Z3lMb0V6QUxSVGVjRlJZczBQYzdwaUdkS1BkSVUyK0dWenFsZi81MHQyRU5m?=
 =?utf-8?B?UVRmczJ1MS9FazVOS2xFdlRacitrYWtFQW1rNGQvYUZKTFlzc3pvWjFUL3d2?=
 =?utf-8?B?dDdhUUwyQzJmL2E5UGIrelE0N0RyQ0xCOVVlZWVhRHphZjBQUXI3cmZtUGNI?=
 =?utf-8?B?QWpIbTlCdGdjcmZaTXJYa0RsKzM5dVhsd1ZUTlJSK1Vpb3lHKzhqYWU5anll?=
 =?utf-8?Q?a6N2KhsrZ2UljkbNbrYoTj0rbFxLvZpzZO+TJ?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4a241a-1f18-481f-0ebc-08df45b87a94
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 21:11:14.3535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQ4wDwCZrl2O2cMM/5Rbuos78VcsCi7TtsXKRwQ8P0P81dJcFf4p//jg333LQ4n028i2+A4RPyK9WrqKXw/HwaaUtQS9nu+sr1ZBcVeQ8Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9803

> Can add_rq_bw() set dl_bw_oncpu = 1 while dl_se->dl_bw is 0 for a PI-boosted
> non-deadline task, causing dl_rq->this_bw to miss a later SCHED_DEADLINE
> bandwidth assignment?

Yes, but this patch does not cause it. Without it, the boost adds 0 to
this_bw too, and the same sched_setattr() leaves the new bandwidth out.

"sched/deadline: Count the bandwidth a boosted task is given", in the
second series, fixes it. __setparam_dl() changes this_bw for every task
that gains deadline parameters. With dl_bw_oncpu set, the old bandwidth
of 0 is replaced by the new one.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
