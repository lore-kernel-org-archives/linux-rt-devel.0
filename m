Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203747;
	b=tiPf5DA0ofd8q3C7uvbBIWPvEusa4EdcXk/O+tgOOWLqJwHrr4Z4To+qDdAcx6j0hvmy
	 dn6vATMZJFpdkuL8K1qCyQyXjasXmRI0/mdlfbWwIm1uRJuToVDzeObQdoZQbujt6a2mh
	 KpjbdN5ZobfS5r4jWge1lvJwwi/C4BU3YiMFd54AswK5RDtgXo3gVAqj35h89id+2SSZz
	 xO3CNqduJhJtg2JBSjAvo+1FRQmSXus3rVEdiCRG7vJEEAfJBRnbo7o4Thx/36ZfZXh3z
	 61Ktr1djkfH1EGHc+uykS65QLYwxgOKhOhbNBCJj6tXORnFU8qsihyp5CxIsT5fPYCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203747;
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
	bh=cP/gY9l7ptYLFwr6tUVi2mRRu9ZV6pOE1wPChxq7sYo=;
	b=wK+Tav122uiEy0AgBerU9647CeOG+oO2DjGjKZa1UGwaiASKi/7xDDasktQHUw8g4NeM
	 HYmBNiXeGq0E4ErRHoAs5WsIazfXxor+xAokdiz5zxeDKhJ2DkxAPAo6mX5GWQtb+w8wf
	 tKEM7Un+LwqeLtYIKkcmwFaV+QrTPX9rKcSkXqA1lkJj8V9z+L+WHVNTqdFl7XOV7jrMc
	 SO394wU9dwl7WragxBUrGEAn6gvbiGBm9pDGapVVdJUV5UpTaJCZozP67/8YnxFbMsAbo
	 LK+6HIPAt9CbdQPwB5Ikx4EnZbYn5WL6w9p0FSOmEt/gfWtkWLin0tW6zQsV3qFwhGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Mptxxz4P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.126
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020126.outbound.protection.outlook.com [52.101.189.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D763606A6FC;
	Fri, 20 Nov 2026 19:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D763606A6FC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Mptxxz4P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT7Fl3NkPO13ABYKOsCB7P0jd8hkMGDYk1b57Ha3Q7wQFV5aEPRguj7TDilC2eLvK4m6OggBy+E7ZB2S9dCGNUJiHT59eMcv1PSUan6NX8gHRe6uYkLUtN7dgxAiZ8Jl+MK3vLFivqDL/0dH9qm1bFYvL43tg2mtkHy9ZVxdAZmz43AdUcM9omNzKHNLe0BX+vcdIISs8FByREAvK0dQVGuIxPFAkW4n1Mv1D8em4V7pSz9kQSuvny4Jdv5mhknmB74tc96wHYdQGepqOAcIyQSErkhGzi6j2OdNgS+uzYIeTnBO4vNeaelgCveVfDWkizqH4OZxnkmq4VdFeTtjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP/gY9l7ptYLFwr6tUVi2mRRu9ZV6pOE1wPChxq7sYo=;
 b=dNkpBOUpX3qzdjJCUka+gstGW0PZWnEKDfjRSnz3NN0Ih2aMRJtvPEQHIh18HUNJ+GhEeQxZnHbSbJoOL7kDQ2zv/0dmgzjFnSeTD90wAQEbhnGjZmgZgFlG6i7Cyq6tP4ciz7q8b5qX+8DsmyWCNdOcr5PXE3d0TkerdcZGGnvQu3zuJchRPAZ/NzsIVkFD+Lp57Jqrx0cmbxOSLGkIImWWkhG9ZPmW2YpBaqOwAB4OAUFLfgZa8XU9lwWGypXi5+dnqZl02cQAjMg2sG3zQMC7ldo9TdUlZBtL5ZhzhGpg2Gobh5JWouWOop4XFarU24kOL8Cd332XyytgCz7c+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP/gY9l7ptYLFwr6tUVi2mRRu9ZV6pOE1wPChxq7sYo=;
 b=Mptxxz4PP10S/qW8vAm/KeURnYpjOBsGPTHFCbUNV+1cH4C1W9ZeDZ5ozhcSfSg/Bp+BpZxtOjJgfxD0OTjq4sFhG9wCvSsddsQL7julUl6QZqyaUmYWThguQwDXgHbF21B+HS+Q1NhQfGS3iU+49pY9la8qx/BVsRjwx0hhBjQ1x+dFU+y+CHtM4R71qWetZd82IvGoFuhGgDu0rE74Sx95H31auUSwErEVdsyZSNnTr5bAWnd4rqv/n/kH8m2lqFWu1GHcoNuqleSh06yuIurajNJ8T7uhfG042PX6GxFBgZVFWqh+pAo0EtN8u4JqPeFxrlfqERZukDmh/YRYxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB764689.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:202::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:42:24 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:42:24 +0000
Message-ID: <47a61567-16fc-47e5-86ba-ad09ee26ee33@efficios.com>
Date: Fri, 20 Nov 2026 14:42:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 27/33] sched/deadline: Start a period at a deboost out
 of the class
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <b0c0b935fc2c40dbd924975c77e3a0132def0abf.1795181240.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-225366@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-225366@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0189.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::12) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB764689:EE_
X-MS-Office365-Filtering-Correlation-Id: 285caf95-6e98-4967-4ede-08df473e6658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|56012099006|4143699003|261028144727099003|261026121527099003|261022105027099003|10067099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	1Izu6nTcG362ZKoTFSIRkXfZ76cYVW2FJg7O9sfBDaabeVq1w0OeloTFDsDsD6XNDFJW9A1kG67wTpj9X+tUW6L1hcji0ixKVmob3UzBhQyBC41+zC9xgmcYSmeVCnuzagzMiOppNHF7diPiJC/t6TGJj7w4cNsNeKgnxSZWPdF/rQM59GaTmeHHHvC5G80UlomHZ5Qag1vvqUKbPoadjyt5cfa/AyC0ZuFpxTDE+J88NPW0TNVUuy0364HJjpFidyEZt0NApXpxnPI0iL1+fbo4SwVf6cLtUJ8baZvFR6BQ6LAsohhLPKV6heGpPCHnjdVcEIHjYMdgjXUqTO5jYvoSwOcG3hS9esRXonDmX1IbkTS5a2BFcsB5BmUjrneIWYoV2k8lafR5cVpSHVfubs5Vbw+wwsuk5M8sB36NAp9cKbChH2fN6Ely8YSw58TYx5rCg5iYo2k+ILfaxMzz7c5fuIHV3wK8wwkBz0LYJ69yJX+XTIjXcaBTxNlVU6po0QUSol+dg32nKpeukT8kbnZjLLOE7A0f6/gyeaUMOK9Tgb7K1SEURD+DMv0b2gdZMwwInaRXDGSGxxrhjMkXwj3pFsMPUR95welROdaAeWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(261028144727099003)(261026121527099003)(261022105027099003)(10067099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3JEUWR0U2Izc0xWM1J6Q0UwSjBVMm5jV01jV0VUQ042TWZteHlqSTdTYlpG?=
 =?utf-8?B?SDgySjFod293a054ZGY3T0ZYUzRyOTh1VHZ3SXNVcDN4N1c3dGgrSytBL3ZC?=
 =?utf-8?B?UVRKNXgwRjFXVW1zaHRFdlB4alpYb255L2NyeDlYWElDTFJGU0Rqd1NBY0l1?=
 =?utf-8?B?NncvMlJucXZ6NVd1bEY5N3IvZmJpdTRVdXJ0dHVBWUczMzNiTFBObzI2aE1i?=
 =?utf-8?B?blNJWE5PcVpGMmZZbk80bkRzM1gycjVYeE5XOVAwRHY5cU8vYkZJamc4a2pB?=
 =?utf-8?B?V0djeWo5VXpsdlhxQjN0UlZ1MkRCVTRSTUEyUEs1NzJ6YUhKeG9CaDFxcDMw?=
 =?utf-8?B?aXgrclVQUk5MUldSaW1xcFd1U2lsYm9yeGo1d2cvZEJxRms2ZnoyUG5MUnhy?=
 =?utf-8?B?N1d1TFd1TkVIN1BkWEpaUnU4R1lLMHBBN0Y1Rnh0V2k0bHpmaWlxVEtTeHJI?=
 =?utf-8?B?Q04yMWxFMG1VRTA1Z3kwNTRETmw3M3lXMjV1L3lydDIxUFVIYVZPdlhIbW9h?=
 =?utf-8?B?OTAzOWRvRWlZOGdMOVZGWldXYktHL1NYU3BXbGNTYnRrMTNHbXNRRjcxRzAw?=
 =?utf-8?B?Z2YzU3lnT09yWlpsekxXcEtRZWNaYVF4eE1DNFFRNGt6NEIxa0F3VmdpTnh0?=
 =?utf-8?B?Lzc3ZE52S3NXb1ZVSlJsSkRBamd0SUprZGZSNTlDYUVVa0hrVGpTYVhZWUdD?=
 =?utf-8?B?a1QzL3dXam5LQ3BnMjFPYmJxak9RbzhoVGYrK1BwVkZjZzFPMStjQWR2blVI?=
 =?utf-8?B?MVY5d2F1N2xjTnp1eUI2UnF1akxaN0tsY0d0ZVA2N1c0SmFxVjlNWDdxaDQ1?=
 =?utf-8?B?YjByRXlNbkkyWXFlYXFjcXpwQi8vVy9iVUt2a053d3RVY3U5VGpJR2pCWmkz?=
 =?utf-8?B?ZHZZekJsWE9pY0R3cXZXL3FnOFRxMUg5ZjBpc2FCT1JiL1hEZjAwYjhoYmFv?=
 =?utf-8?B?eFdEb2UyYUYvczI2SGJVUklJclowRWxLNEV3RVNNeHpGK2ZDKzJ1WUJsZzU1?=
 =?utf-8?B?VlVMTTZ1SkJsNUREZ3hrV1Q3aDhVdWFxTy9EajkzNVZvQkY4SHdzMUpjRVNB?=
 =?utf-8?B?M2Y1ZTB6OVplam5jSHc1aThubkJ3SFNCWjJmMUZPRit0N1RkZ2s3ek1zR0RK?=
 =?utf-8?B?UTNvTW1xOXhhRXBoMzE0SWpUYTE4aFFGMkJ1Zll4TStEOEFwRlQ3WGtxcm9V?=
 =?utf-8?B?ZW1McTZMcmJFQ3cvTEMrclU1SzZodm9FUElPSlgvYjUzK29OSW9SQytBNWpX?=
 =?utf-8?B?b2dNb29BWC9sTkppZ1huT3BOOTkrdkVQcW5ndjVOOVpENlhsQkdMNGRqbEZz?=
 =?utf-8?B?ZlRLS1UyZEoybVVoc0Q5ejhHTXpGbThaWm1xbnBVaVg3N0pyRHlzTWNtQ01h?=
 =?utf-8?B?bU5HU01GOGM4NnpNSXQwbGlFREtWc2YvaWJPNFgvSDBKUnNKSHNNbXVCRmRk?=
 =?utf-8?B?V2dYb0lyM2lRYkJ3VkF4V252REdkSUwyQU9QZ0R3ZGZKRWd4OFRpNitoQlhn?=
 =?utf-8?B?ZHVKamtFN1lOY1RrNDRCcjVzSHN4TzRMMkpyb2FoS3ZnRldRd1k3WDdSTGdG?=
 =?utf-8?B?OHMzYUR2dzNlTDZueGI1SEhqb1VpVGVKeStGcEtsdktSWDBlYytERzlzYUZz?=
 =?utf-8?B?YkxxTDN1QlptUGRkWk12N3ZkVEhJL0Z6VWpnWldqOGVQZ0RscTBtSmhpUWkx?=
 =?utf-8?B?YnpoQzJnM2wzZ1BDNlJXUTV6eVJJTmZwcFNoRWJ1V0ZZc0tGeXRJaFJjL1do?=
 =?utf-8?B?Rnh1aWtXWVNqMnlMbG0vT1c2THdOQUFwdzhXMUpkRXhCbjluMzdDWUZERVFM?=
 =?utf-8?B?QzN1N0lhY0R3ZlU2c3FMTjlOQ3p1MURiYU0vWHRMMUxHUm9XenRvN215NTI2?=
 =?utf-8?B?bnVlQm9FUXlZTXdrdU1iaHptbFpWTVdYMjB2Nm13WmJyc0h1QXE2UlcrTUFB?=
 =?utf-8?B?TnBOSWI2dWluamo3ZWRMSVprUDFLdkJ6ZENyUlZBNjlPNGg3SHl3RldWS2pw?=
 =?utf-8?B?MVhualJrOEFMM29FY29hR3JDKzkzZGM5YWw2NVYyVEoybDNHemJOK1NLTjB2?=
 =?utf-8?B?cEZPaUFuT0IvQVJlNit5UVc0MFNraGdSaG5RTlRtN3hIYkxXbkxUQVVYd3Mv?=
 =?utf-8?B?ZThkT2RrcUF5Z1p0cXpBQ1RZRVZEdENOSUk0SW4vaml2K0EvbXZzeExRL0Vs?=
 =?utf-8?B?OGlVelJiSGdBNzduKzBCT1JmQW1UMFpXVWdwbkd5aU9qZEZDVFFlQmZxY0ZV?=
 =?utf-8?B?SnRGclg3V1lkeUFjT3FHVExqbkhhQTFSN1ZwSEJkR2Ivd0laWVNFM0ZZRjBx?=
 =?utf-8?B?RGJKdVdlN1FMenZCcS9NSEZwaDR6NkxHMVJzZVVZcks3VzFEL0RUaXdqYVU3?=
 =?utf-8?Q?HOurDQ0Zm+jvQkDWnXu5nvEF+JduBzQcOphPG?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285caf95-6e98-4967-4ede-08df473e6658
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:42:24.1454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5pzoaxQ6gEJtu5yP9HOEpOy7o7dRLBTZWh5Bkyfqqf6Zb3+4RaCZ9p+IJb+QBYKO24YojogHEOvHopY7PXWUMD3evCKnrfktYZjnNuJNhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB764689

> Should dl_deboost() also cancel inactive_timer and subtract running_bw
> when a donor-refilled task is deboosted while asleep in SCHED_DEADLINE?

Yes. v10 will cancel that timer at the deboost too, in "sched/deadline:
Reset the donor's runtime at a deboost in the class". It will then
compute the 0-lag time of the new period, which is now. A new case,
deboost_in_asleep_after_refill, will test it. It fails without the fix.

Your last paragraph does not happen. If the task leaves the class with
the timer still armed, switched_from_dl() keeps the timer. Its handler
then releases the bandwidth from total_bw, for a task out of the class.
The release only comes late, when the timer fires.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
