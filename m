Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182840;
	b=jjLDGVnSWY5qhbNLJmzEOFKttXVKXIJ2SHgYQOHVjCNBf7sHoqWaGqAlwvNcVWJtuROU
	 YRZSMKrNgxUZ104GILaQbeSVGwro8qpPRDW32CG29B2mCXcZ45YYycmOXlVaJC0UFSE6f
	 LC+adcBrqtkRkcX92W1FBlvAicEBTn477vmUfE2+61CAtZO2pKXSe3ugieHz3QlYLYDmG
	 kZz0UBuw8XM43TiENshFDCbtgvbydwF00iBazy0omMAZkoWn8ZqKDa8vn+wo3tU7gjKZN
	 zBXQLoHkvtN5pr5DyN36FepvPXv2+mVjxCsaAbD1yvT9ziJJtLGpfgmOesG5NOhCksw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182840;
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
	bh=xfUNPdJxK5wQMmw0TKWNr+P9bsc1H00mnFmIr9+au7g=;
	b=ZbPiKQl2i1sffYZuU1mNMoiZdFerSZn9Mfs3r4ARBgJj9aYCtWhxc7hxAU15XbZbfgTq
	 QMIS1dgkk44YOnzCwTKsbOyJd4cEjGqYtMtNP4weDE8bXSmQFUCeRB8s8dAfZNHc1cUd5
	 eMuBVZqCLaZinXX4HKSHa6TRLF2onP9JT4jeRw9nsjrx9dfPGEthwc0uQn3hFiZd7jCuI
	 OYZ0w+uaKtGWhScOkOxSYLIMLcJAdxr9yYwXq0hCa/6jvhvLc06n6qpI4VV1aIx/iKqoP
	 jLAz0Tv7Ydu2VLC8eJyKQZxc+t8TPv7Qny6+TJdwHo+ZUVAVmgpdAei4HJsKYhYAong==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="SHCCRL/R";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.98
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022098.outbound.protection.outlook.com [40.107.193.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A61060A2601;
	Fri, 20 Nov 2026 13:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A61060A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=SHCCRL/R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCd5rvNS/WgmLsqhI4/ZuttlgJyeZyuXow/oiLqLTstZVsNJWwKxUF0E+OjerfEC8r/gxVH3TozTnaEoSflcTysrAgOzXE5UKPEuA4hrPywd37PmY064p07uIVFMX+bjaXjLR/zmUdTEhqNsQLtzXklHaT94sVo55++ArOmxZBNfXXyZYbT3sMFYYD7SKKgIat+7BDBaYb7W++72mEfhahdgK0O84DtC8Uq0QjyYh2YKuNzB1hCyeK5XYOztOwaKVHlWOs+JZTvEJtmJxDCK00eN+2tHNZsCKK8BZwNisyUppPtSnTds92r8M+1BXhyW6UtqWLfRfP5pHieq6gXM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfUNPdJxK5wQMmw0TKWNr+P9bsc1H00mnFmIr9+au7g=;
 b=whgn9aHxh4xuVcvnaCkBiqT6FnBGLEbLEmUtng3xpwnSi6hYIx5wKh3FJfr4rZ7PZckSHjwMkkI9/5W/3WfWQ0JUq4R0kJOfjkRl0r7gXc9frUT2w6RYKOGmtXMK109zWEfGhUqhettmdbrJRmucQ/2VFEFLS877wkipINpwdWMdLFW1IG3hy1jiKBoMFhYCtYjWZj6b1LMYiF4f9AM3i7Mrs/B3s0qN8Dy5DQ3Oh/wXnTMNmh8oMWd9Osb+oRoxSlqOx/yO8/w8csEjE9K5PeU91/En0z9v3RYXxB6b9LK8I99wKqlVBQVZA6kCD8rgrk5oqWaEfiyZQcDOD3jPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfUNPdJxK5wQMmw0TKWNr+P9bsc1H00mnFmIr9+au7g=;
 b=SHCCRL/RW6xUIYvkNO3rTAlOnV+XxzH4L2MekIhxyhb2wjNvf6nhai86bA2vIS3y0ush67X8F+dGel6e+MZg26kmqpTdolIUFJW38HeC/yuCFo2v/s+qSsiDEP8GOU7ak4ZfHnd9XMxvmzSWWFZ0ugL5YjgE6Gl5VTBmVElNDQX438S32b34jlQz7J24HtdXRiZ+i4SV5tPdNjVbehKSmOun2kkXTUy2SGi2HHfniK07cJHgTjlxHktiSPqeTGcJjebdBsA2q03PcYcVRDZr7RQU2UQi+cCj41KNYpPeXnPrLQ9UwzZaFGEhr+iHG4kPVIduQPx66d3BBPoEMqBQEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB8724.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:7d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:53:57 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 13:53:57 +0000
Message-ID: <126ced8e-f0d0-4d1e-bd34-ebd5aca81395@efficios.com>
Date: Fri, 20 Nov 2026 08:53:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 32/33] sched/deadline: Check the runtime of a task
 whose parameters change
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <efcd611a473f0da0161243c58f4af7c7ca73e2ba.1795116791.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-224081@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-224081@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::19) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a13d0a-7ce9-4656-6292-08df470db8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|261009223027099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+3pxLNJkW8/wNihmobLso6Fbp3LNfR3o7qc1V0HI7zesg+kuogpFP8RnvIFEIG1pITYwqS+Mluy/kVe3hI5pt0KcZoF1PNyysscpM54/YNeABI8tk0s5DATYLX8MHH6M+eyD3wvXAPSpcXyDDNeXU+2odv2u+Ou67C25WFC/YqszKqFw411BOacMPJhceAvnjCg8usP/LCA6itnVendd0rqYPot4EF0CrplRieqeHxWd6jfekhyiCo89or+M+bzk4EENGCzSUlFU2jECyLSbzfoa1Yo5F7o1ewRxX8fS4LYqmLxbHBjAfGiDsl4d0ilk2/9APEm9wG2cWzLGwcjkQFBjjkJy1RVqSE2/YzkJqFXc0ihLD9f4Lwcza1Kx2LpWj8GbQaB1ip8zouahP5TDLJcH5qIiCHsR6bpYqGf1SY7tNm87D/CE1yoLoMaFugudBCA1t4P6GcFh74qCQQOKAAfiVFFsGtUZThf5h51zBSpN6EyE2o13fsWiEyOnySgQc4/cBQtFlREURfFJleb+gGf2jal/FyB0wxMk4RZuqU8Xi7OIb/E9Gm7HJYH1p1hxJAzk38bjQu/poXhAorGgu5qp2qVIdeTA/dpIlfqITg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(261009223027099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0NBTmpvaEJGeWxHL0wwMk8wS3Nwb0p3Ym43aktIRHlmRWpLMXdLRG1qRURt?=
 =?utf-8?B?OFM4TERHSThuOC8vcWlKQTY0N2Z0TWdjeEdoaUloQXhWbnl2WWdRRlBtWlhu?=
 =?utf-8?B?VC9yMGFjTnJoeFFuMnNkY3duNVl5R0V0ZlIvb2VNWGpZU2VvWjMrVnRvOGho?=
 =?utf-8?B?eXVWS2x5ZTlyUUU1anpnWUZEWURIbGd5WmlmZ1VSL3lybG83TEZVU0RmMGtj?=
 =?utf-8?B?MWNFVlQ0Ykh5MmhiSTVVWnNENDhoTVpmTU1rNmtpeFJLM0hUMmJRTG1qR3Vz?=
 =?utf-8?B?MHlYWVdYZndXMWMvNnUyMVFKTDAzU3lwMkowUkxzbEJpSUtWSjBEYm1VTnUv?=
 =?utf-8?B?OVFlUDZETkRORUl2V1FqRG9heDdySWdHb3hKRVVFMkxzUEVqSkVnTldxRGhO?=
 =?utf-8?B?Z2phR056MEx3QmNScEZuS0JET2xrOVJZeHlDdmp2LzU0NzBzckg2QWM2SDVU?=
 =?utf-8?B?SnJSN3lJbkNNMWZZZXNYMGpIaXhkQ1JLcm1LSy9icUtmUHlwR1lkK1p5UkJy?=
 =?utf-8?B?Y3k2ck5TelNiUmZzNkVub0F0L2xLRkRFRFZ5VzhyNXlLM3RHODNnbVNEdE5w?=
 =?utf-8?B?VmI1elF3ZjUwekkrTzBJd0g4aXFjMDBwcG56bjVRL08zeWUxWmpUQ29VV2Jh?=
 =?utf-8?B?ZVV1UWVjOWk0cEF3bWlmWHpqdXY0TlViYWRDSmFpUDVVWXliM2xzZjNaZTJi?=
 =?utf-8?B?VUYzNGtnMmF1YlBqQmIvY0w5bm5SMnBxL2tlbGwzQzBPaWppdTdwZmVqc2xm?=
 =?utf-8?B?VDR3eFprM2dLYkZBUms3c1BnVEJKVUVhNUM3bVZMdWdZWFM5bi91UGJQcTcr?=
 =?utf-8?B?L2RaVjFvUlJkcXE1YkxwVXEyaXlDMEcwRlFhQU9jV0ZqaHBHRFdPOWppdm53?=
 =?utf-8?B?cGxSQms5TUNHN2xycUJnWUlHSFc1WG5xMEk1YkQvanNxd3QzWTZPMS9TdkN3?=
 =?utf-8?B?Q3FRUXNuMS9XMXVUQWxsVWpwNU9YblJmT2Y1Tmw2NEFYU0pPSEZrZ3RRc0Ur?=
 =?utf-8?B?bDZoV00rZXpmOVhKOEtGNmtIMnVUbTErczRoeU1ZRTR1dFNlaUFad294S3Rz?=
 =?utf-8?B?dElMRUlvdkN2V2g0RVpDVmhTWEtuQmJUNzZ5Wlc4NWdNQm9yUVFCTlFTNkU5?=
 =?utf-8?B?S0R1M1d4SFFCVFdIN1pGc0sxdGVuWUdLVDBpOFg0WHBZV09TUG5ES3lNSnNH?=
 =?utf-8?B?MXlKbWkzYWMvMjJENGp2VTl4Tk91ZkRvbG5xQnJ6L0xpWW5wNnBhOGhDc0Ja?=
 =?utf-8?B?VkdqSVFSWk1ZczNDNTg2elg0SXRzaUEyOVh2WUJsRWtCWTE4QWg0Vllpamhl?=
 =?utf-8?B?YzB0bW9JTzdRWlJEUWtnYi92cWFTdlZYaDdMTER5UjNMR0ZvWTB1b2cvYkcx?=
 =?utf-8?B?K000bmd6Yk1hWW0xSlh2em1DYkxSL0RoMDdlVEFBTXkyOGl6SmU2NExKK2xi?=
 =?utf-8?B?Q3JXUld5SWNKc2h4WGdqTzM1cmZTa0QzMzE4SjI1UkNyNjdSeWR1a2llYVBv?=
 =?utf-8?B?bkxzbnVNUHdDcWMya21PQ0lZZXpCdnJzNG1ma2hkeFlETld6VE5HRzhJS0VQ?=
 =?utf-8?B?RnppV0RITVc5cmw3QUlseG45a1B0aWR4TW9jMjJqTXdCazZQWHVPRExLaFM3?=
 =?utf-8?B?T3VjTWNPZVVTSVZCb0E1QWFNZC80d2lnd09yYmxBcjNOWmpVRGViQ3FKQU8r?=
 =?utf-8?B?S3MrcmRGR3N1a1hXS0xLNXpwa1NWYkpGbGlUZmwrZUFYMTUvWTZ5RDkzWkVm?=
 =?utf-8?B?Y0h2RUcyTVFCa1JIbzVIUEIwRmpyenkvK0JGWjdpeU9UTlhIUjhVV3o4bGo3?=
 =?utf-8?B?dG00bmR4aGs5dUovaTYwZDJITjArSFJENWlKMEJaTGxXWkVtS2xMcDZwelZH?=
 =?utf-8?B?NWE1cGdVRVVtTmtMMUpKazFuSjhNWGpVRmFtL2k1bVVoem9NLzhRMDZJVWUw?=
 =?utf-8?B?YzMxL0owTGp6eFovZi9naEx6WHdqTkc2Mkk3bHRRai92TUhXaUNoZEovZ21Y?=
 =?utf-8?B?Mi9hYVRsbld5b2RGRU5JN2pMc2xlM0w4ZDJuWG5XdGhUUVp0NFM0bVkzL0pS?=
 =?utf-8?B?UUhTa3lsTjgvbm0wTi9lMlNjTWowUzkydG9NWFZiRDNrYlNKYVBnUDhhTDNH?=
 =?utf-8?B?bkkzR3JLUDMzdlFmSWR5ZTd6ekRhb2JOWFQ1Vnd0c3dDRUlNbUtxQUtJZ2ZI?=
 =?utf-8?B?MzZLREx3dFdEYkVEejhCbWRFNFNqMUk3cmNIa1FBN1pzbWxwYjl4ZzNFM3hv?=
 =?utf-8?B?T0hneXdXNVl4WTB2OUhzSnN6WGtEMmdxVjJQWW5DM3hQUThBZU5OaDQyb1lB?=
 =?utf-8?B?cTl0WWVCUklBMWRXTWRjOUxZd1pheUZPZHlJRFRlUmRsbS9VTGY2bTZ5MGN5?=
 =?utf-8?Q?cnRPsTODwA9pUaV4PKUvl90LzjkcEybYQlAza?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a13d0a-7ce9-4656-6292-08df470db8ae
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:53:56.9189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElwAYvSbzM1MhKYZxYgXCG2ZdtQ0gPF+VlZu6YNsz/g5R4KDeXBbdpKfS4bh2rayqP4XiH72+kS8DoAL2XLm7lKjJub8VKHTmWWyFaup9FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8724

> Does calling update_dl_entity() directly from dl_deboost() bypass
> dl_check_constrained_dl() and update sleeping tasks prematurely?

Yes for a constrained task. In v9, dl_deboost() will leave the check to
the next enqueue when the task is past its deadline and before its next
period. The enqueue will then throttle it, as dl_check_constrained_dl()
does.

For a sleeping owner, the wakeup checks the runtime again. The early
check gives it no more runtime.

> Can an unboosted SCHED_DEADLINE lock owner miss a required PI boost when
> update_dl_entity() pushes its deadline past its top waiter's deadline?

Yes, and this is older. On v7.4-rc2, a replenishment or a wakeup can
also push the deadline of an unboosted owner past its top waiter. Only
rt_mutex_setprio() compares them. This patch adds one more such path. I
would rather fix all of them in a follow-up.

> Does __setparam_dl() leave dl_new_params unset when a task leaves
> SCHED_DEADLINE and re-enters with the same parameters while PI-boosted?

Yes, by design. A task that leaves the class keeps its CBS state, so
that changing class gives it no fresh runtime. This is the intent of
commit a649f237db18 ("sched,dl: Fix sched class hopping CBS hole"). If
the old deadline has passed at the deboost, the enqueue starts a new
period. The leftover is never more than a new entry would get.

> When sched_setattr() shrinks the parameters of an unboosted task blocked
> on an rt_mutex, does rt_mutex_adjust_pi() use a stale p->dl.deadline?

Yes. v7.4-rc2 has it too. In v9, prio_changed_dl() will check the
runtime of a task that is blocked on an rt_mutex and not boosted.
rt_mutex_adjust_pi() will then requeue the waiter with the result. A new
case, setattr_blocked_new_period, fails without the fix and passes with
it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
