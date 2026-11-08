Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794150511;
	b=QdCdkcyijhlwSeiX/dOBpzgzOiCQydKx5YNQDPWI15VkSrovYmjUXj7p3FFTLYYQ/oIm
	 ocRBQq2gTCUVnpZdvxXrQl6XTUgFuY6X1sPJMoQtFObpxD10rZ75uMughIsR/N+ookve0
	 HTA4UVDfJBZMY5zgeNW9jurh6hMLRZtRMqPWDFdQLf1VJjOcw0O5pcHgx99+VNxC3obfU
	 SNb97JqjtzM4OJWBTa5/5VX4F92fvh9Z19HdmDISiEhml5/AsQoWH6YapdFlTp82Hp86u
	 NaI5mhRT3oFKDz4rmyqFeZa6iXhaLYmYk0g95UQSKKkCRQYxiIivD1wdULTxYs7TnZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150511;
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
	bh=iUiqIs6/Xi+2Pv6z74GmLGulJ1myYQP+3etl3bdTL8A=;
	b=JQ/D+gF+VkD3ogo1xQgSJH/wseA6DR6iTr8yYjAyag+6V5Qmp0xTjjHA0aOuFKnz3fqj
	 ZOvdAaJluhX+Fh+FUiqxG7MLeKnumGBKpSkNHxGcyDRzjLtxVBS/yLpiacZZ1I7E1P9dY
	 NU4Gy53YBNBtnoGcZ5eU7TCHap5b/Y1TYYMreQzZ+Cs9RpsrMe62JhDIX/1VSyzbxcV1F
	 3xOlrGof5n6kEANGylQu06UlzZhsahwgmerSRBVOHb5YIuTh2Mxyi3yJ4he6760aTambq
	 RLcJH44zIaHw5QRq3jMIxNRaVL+QL5XH99yBktTm5vT/jDT1556AoY/AdpXTzStM9Kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PA+dAST7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.123
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022123.outbound.protection.outlook.com [40.107.193.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCB606A320;
	Sun,  8 Nov 2026 15:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3BCB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PA+dAST7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ambBHS+FnDvPSfSbnIFGvPNIQyeZzT73iEZiZa37OBVGCSTurx6edSlgEigObRzJjtqv7diGgotDCsRUXZyh6m2ewtTe2EadDMOJViz9q1R7k2f3YgUt1JLkiKSDfHdBrcIhmADl6oVbZSJYQGynlDxkxWB/EqCdRWLyPYbLRa6Jc99LhhPuTkSsCWcyzAxicZENcZbfpEOuq8lvjDnRwYzMMmMiDjBcS9VLYbq0KujDxnqAGcusyHc7zTtFRH1bQ1LF/JueqgpxdiaHAoNUB0csELM28m8b6qLkfK8NXz2mXwoOhTREeh9KkwftPFhXdYY5mqTag4iKz3ApFcuLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUiqIs6/Xi+2Pv6z74GmLGulJ1myYQP+3etl3bdTL8A=;
 b=oVd/kBopuXXv8UqGjlhCgK8jzNATLhvTe0vW+1K5lntThD0EAFBTJvWCvUTTS+boDvwpoS6NxoZ1OS6CkClYpMGOkh4eY7GfqRUEvckIdPAp/Ij3yvlrbhityh/ZRaU4pGssB+957m/3QROh0EaapgMpV427D1JdDo2gjmWpylO/17hCRALH3EJLQDlmV2oOzrYINeItj5NHDKzXqZ9mYl9aBGUXv6D05i2EMfdf6Jdz5UGdJWvYvwDUgdJea9sazeKzKP7kdeD39dvOQgJbA0ZfjaBBb5JKjqPqLWB3UAAXSW5U6KpIXxaMeOe9ysRaZAbVaVRFmpJdF3175jjhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUiqIs6/Xi+2Pv6z74GmLGulJ1myYQP+3etl3bdTL8A=;
 b=PA+dAST7jnVzloT3SMEjhA2GMBL1Qhe7fE6yIZYrFXAz2PdwMMV9Hfkg63eW/YEdbvIs9PCIrjKhK2Up3d9h5ZfM7cYI46gDcazlgIQiQhZmdDN/jxG7fb/uEP7TyzEUhea25fFw+NKggtDl6mc4WhQsqTZVVtqJnRxuB7cH8Bcr/I3a7hRVJlKyHYRHrcRGNTq5jmV1LMUIVHmwW9JEo/SegcU1bnsxEYecpzLXVaiDECfOfw0YVvVQW+KRvrE3OfFw+JYN5e8Brl2VN8anCw7tBBYF+lNfyEwWk77lDfjzABY6ZO4XcuM/44417VqJ65p8dlnjz28ntHgXkD3urw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB373984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:cb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 15:08:29 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 15:08:29 +0000
Message-ID: <38954dc6-0202-4570-942f-e720a4a2e018@efficios.com>
Date: Sun, 8 Nov 2026 10:08:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/26] sched/deadline: Rebuild the root domains'
 accounting from the task list
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-15-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202500@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-202500@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::26) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB373984:EE_
X-MS-Office365-Filtering-Correlation-Id: cbeabef8-65f0-470f-ebf3-08df3daa255f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|261022105027099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Lhd1OocuxjYOTkcr7r67sPFFeWiPHes29uuKNrbdME+NadWxT+Tm5nNewpQ6R47mqZ96m2txdf8+5gE07FOtxobi46GglEu8l0atuoixWeyiiFkIhoQCc6vZbLDHH2kNX88aiIw6xgg97sKbjVsbnVwjooDd7DHtuP1WfIIT0HwQuid/vuOf08nPfG3DS3fiAPMpSR8W56Awtp+Vs4pWPXUEJio+UUpjjNdyhoqj0WUuBCuzPjANljsam/lvFbLYnqNm64mcP2OoX68yUBj2YzqiJj3FNc61cRQf8cSopnfr9J3VwxCnCnR/5rlYjayYXO4Dd7rk1FunZei6a0/k6/vaXr4D+jJuhFDv3IjVeFHHXYyREzjvmbCpzK2x4YvmjBgc5TNmWlmW13mAOaPY1fHZ2sV3vv+ejvlDd9X4yquk0hwF0CSHwH8c8ExYopSRrryjEIIbYx8BfU6f77WynkovacDDx8HxtAVu69AZzEZgF7tVcoqyO3jR1K6ZOF3YDy5Hwr/DQHJJ9WPxFXwte/d9KpN2VK2xVC6l1dm2RewftBs9Vh4OKbyY097/f7hPn1LRQyrt5I2ZWowZ2ThLTfte1q5ho4YxHBcE0M5Fr1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0FWOGxycnZMTW9DVEpVVVByUkVjbEl4N2ZMUzh4c2ZxcWhWUUZUc1dieDJz?=
 =?utf-8?B?RUNMd1lyc01UQlR2ZEZ3NFkzOWROVGVOZG42MnFmOTAzR3gzOGhyYURQNmJT?=
 =?utf-8?B?MU1sTmhZQjM0REo0ODVBVkZyTmZ3bzRiTUpXQmtQZko5ZmZqRC81NFh0MzNE?=
 =?utf-8?B?NmJiVkRiNDlVS3lkQnhUL0Nua2RpekQycDlxNnFmNFRUbnFmUmNUMDJjSnVJ?=
 =?utf-8?B?ZE9nNnFyZDdEdEQ5bi9mbXAxMlFyWmhpSGR2VFNBR2lSZDh6OGxwS0oyZzJY?=
 =?utf-8?B?YkNteUFKdUFtQlVRUGpSOURpSS9XY0NveTY1aFk1TVVscm9Ldzlpd1NrYkov?=
 =?utf-8?B?WXBWTFhrQytwbUR1cEFpc05tZmRrYW9sbGt0L2M0WWtyYmgxNlFaZlo4SVpW?=
 =?utf-8?B?M2xiQzdVeTlrY1BFRDR0Sm02eHl6ajV1SVIvellObi9GWWJFTVRBVWc3RFJR?=
 =?utf-8?B?Q2RFK2VWUWd6U3pJb1M1c0E1azdTVkFaRlJiZ2dnbU5xL2hicmt6TGtJcjhm?=
 =?utf-8?B?N1pMTUQ5QzhUK1hFUTRFZVlIbVQ1dUNGRVBtVDdDTk91bm50YXhNckwybzlG?=
 =?utf-8?B?YVl0c3lIUk01SVJSd3Z2ZXlMR1k3REhsZVRMb0xwMkhKTnpRV0NCbHB0V045?=
 =?utf-8?B?OU90VVZwcTE1cFdCQURwUDBjcEVUTHNyT2RTcUpMVWtYamxlb29hWDlEdDU2?=
 =?utf-8?B?Ujltc3JndWNaNjhjVitlUGRCQzdXdndhNkFlb1JKb1E5elk0UEtKSlF4VVht?=
 =?utf-8?B?cHkrNjNrL2k2RWtFRTVSZjJ6WEowUUVvaVlyL0VRM3Ayd1lUSjJZaGo4NWR6?=
 =?utf-8?B?cFBwVTFqeVhzOHFxdVZoaUtsc2ZPS1FvY0xMdVR1emZpTk1BUXhyTGk1N0o2?=
 =?utf-8?B?LzczL3ZOZkN2a05QUXpPRWg2YUYzWkl4QkU5aTk1ZDNtY1d6eXE3cExuZ2d2?=
 =?utf-8?B?ZDZBWmc5dllLNWxsWlY3eVVuNzFJS2t4ekRTZGROUGVkdWNkY3Qya3V6d212?=
 =?utf-8?B?MjJrMDh4WlRLRTM4QldqUXZoN3Q3cG9iUFVGb2JaQTRPSVpFWlRNcmc5R2k5?=
 =?utf-8?B?Tm5waDJrbG92NXp6MWFDeW81b2dqeloxbjBpY2lDNlRkUzBRSlBOUmpDUHB6?=
 =?utf-8?B?U1gvRndpVVB0ejI3VHZtS0ZXYlJjVlhZSllIY3dHbGpLNTRhYTlmeERmZWJk?=
 =?utf-8?B?dkxsUXdhc0NIdmtrODlMZ3dkWmtVbTFxbDlmdFJSdUdKY1VxLzltZ3VNUjB3?=
 =?utf-8?B?cDU5bmFZS0pUdjRIeU14cGNNQXQ2NGZRTHNIbzI4TkFlK0d4STZ3Z2xIRi95?=
 =?utf-8?B?RVBXZEhFN3dJOUtFWTd0M3JhL1lGZ2FkVHpQTTdQNFdRbDZSeHp0eksxR0Qw?=
 =?utf-8?B?K3lpQk4rcTNvNnNDZklENXFOYzVtNlR4SEczaWczZTQ1Z0YxK2pNM0lMMVJz?=
 =?utf-8?B?dUJrTlBrMERoVUtEbXBXbjgzRENxNlVhUXBCTlNZYmNBWFFOT2k2angvMVho?=
 =?utf-8?B?M1ppTzFvd0JuVU1mTkZSeTVGWHlKdXZZaGxXcnkwaWpTajcybExpMjQ4ZFFu?=
 =?utf-8?B?MGhLS0wvVUh4d1did2JEc09BbDZkcUtLY2xQaDh0cDJKdDdOWkxMdFY2T0s1?=
 =?utf-8?B?MEREbk96TjU0Vm1lakxEUit0U3NReTd3TURuQmtqY3IxeUM2REFSMjQxZlBo?=
 =?utf-8?B?Mnh4VFlSTEV4TWg2YWlkeFRwSm92TWpOVWdId1NjdzZKNGwwMkx1bEhrbGgw?=
 =?utf-8?B?b1ViUTc0cWkxVXBGbm5EemR5aFpObXFOMmR3clVuRmZQTzVWRlZyMVlYUTJy?=
 =?utf-8?B?Q0ttcS8vWjNSZGt5dlYveXNBVmxRSDR4Vlo0UFJRTURWa0pZRS9rSnY0bUhr?=
 =?utf-8?B?UklYMTcwa0hYSXRXVzJXd09MU2hhUEtOWnFRQnJpTU1VQ3hhdXdSa3IwZXFs?=
 =?utf-8?B?alpIOEF3UWdOdFFVejFORVpZcGxrMml2RUlsYWcxU2NocnAzWGMyR0tKYVFD?=
 =?utf-8?B?ZkZUY0JNTEVpQUZBMFZ0SlFWRVl4V3FEbjd1UUVlTVRsaC9HMFl0TE8xWk40?=
 =?utf-8?B?Rmx5MEdkWWNBZUhXN090Y2syUDBnY3FwcUNGNFFSRDl5elJMT1E4VSthSjBr?=
 =?utf-8?B?YlRNQXAvNVZsOWNyNWVIWUJ0b0crRGVEQkZ2cWdXWFZiYTgyRFdSNkErK3J0?=
 =?utf-8?B?eHFlWFdCU1RoOFNnNVg5UWFrZEtVOUhuNTdlY2ZabEdpMWZFTTlhK0xhUjFX?=
 =?utf-8?B?WDU2dzFmZno2WU8wN2JDNXlYc3N5NG91WDVOMTVvaGUyNXV3VFhhbUtGMndZ?=
 =?utf-8?B?UXZNQkxNVFg0ZmZoNVdxZ0ZadERDWjVPV2RuVVpWMyt0eFpKbUkwL0laVFZl?=
 =?utf-8?Q?roherbucc0u76LNI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbeabef8-65f0-470f-ebf3-08df3daa255f
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 15:08:29.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sFtDSAOtFXQTzlFfw3wcuHOAj8pYB0wb5Tzp7y6zjLC1RuEH7V9qiVvTFzHoSq5SZAY54JbuF126/72Zo42Mhy+rfqUTSKbO1NtSM6lVys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB373984

On 2026-11-06 21:22, sashiko-bot@kernel.org wrote:
 > missing dl_bw_gen check in dl_add_task_root_domain()

Right. The task-list walk finds an unreaped zombie that the cpuset walk
did not. v5 gives the walk the dl_bw_gen check of
dl_clear_root_domains(), and adds a hotplug selftest case.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
