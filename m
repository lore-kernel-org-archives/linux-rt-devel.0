Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203676;
	b=LtafCahkfSkZTk5Pp/7xR2YtgFO/LNtMOtgDE+zDTzxwLKIzYiVJCOor862vLUjoeoxA
	 kxf/pc68EX/xypoHeIQVyGjIeQDYbhr3G159mAGWBsoNF4gzfKsH/0q/QEQ67onhY9Jra
	 ut9TZrK7/4gOfIF2bAiM1HBx/K9gYYN3UEDeQxbt6BT9AQPAa1xklWpIYxKXYinzDcrVq
	 KyCQF1o1ZR3eJUKTZ78FEO3Rh1MjGDg1VvktQC8KH3rA9M4SzSA4YgT21T/vA0mcLPBg4
	 Bgt5jVS9+qub75dU91Y80H5KFd1NkRhoarCmUu9AvG4ohN/7AKFS1uJ+jBiPZGs+vGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203676;
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
	b=UGZOL0+aCPdtflFDnfAandSgTUvVUTCLqLBYh+aPriNGWCzfU1gYp+uV2NyPKssxaFMf
	 heaEfWbvQe8plCJ4DZrH11SxESxNfjMA/nB0ZI+2i44mpRtVChq5xt1oP7d+y8L6h3Tpj
	 eZZ6KWLw7ZemmQFyQS+GBZSsCHMafDewxbdCr3X4+o7xHG6fFEZCuzg3rdkYc0IiMinp5
	 nJA9ICcehu0fco2mqxgoLub7v/uUW6W/ulZkRRlKOkPAc015X0tQndjkIMp3WV3aKWe6l
	 0SI9Cxv1V2mr10IsNjUAVr0oWw48tS/Uxx0ku1HETDcNQOPlLBhMTeALXxbNfWH6dKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=VPhCpAml;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.77
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022077.outbound.protection.outlook.com [40.107.193.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C319606A6C4;
	Fri, 20 Nov 2026 19:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C319606A6C4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=VPhCpAml
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUBnA9gKBa8O4shcLFjTnXKJzI6Mn+UniHSx1JO8nXZvUMJQp8ic5rBCknjTHC4rnLvxQg3Yl87Lovz19DFtYkqfYsr/gzefig41I3ZRqtdzQnR3dm9q484p7J0tF1xMpmuYF4ydb+sNct7bNcmdpSSfYrT+7Y63Q6iyzKfFFS5+uQCnMzar5AlbUHFIwdVjN9ThLBeZyGbuPI8604ZyiJeAO82a9EvmdIQbH5VHTEodkWBtC7CY/gYs7WIwASxecfDRTgncrAIJGtvN4MVDIcAa0JkJVBXwKcvo3ePSW6qHNAYx0K68vy4za4KwwAzU7juk5xrm9irCmRnMya/tmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP/gY9l7ptYLFwr6tUVi2mRRu9ZV6pOE1wPChxq7sYo=;
 b=cX+IYlEOyfVQXKPshpdXMBPgbx75G8AUIWDpy/Y8oFMNkFEM8bJ2JsF8qNkAni5fta6D30Ln7KrRbwMSHw4D0a3E31bg8c+Tl/2cGXHUZQI+HsMPOWoDHowilKyU31UN3wuS0XRjRtIPRN68HhsqbBqgca+roR0+H/7cFSIDNT9llvagyJfzdhjZQV+u17ZFQ5XYC5iWSYQfgvXwEIcCi/FwBryxK1l9jZKFe4hS6UGijCzdTnqYrHcHIFcEYqnzZU9QorlptxTCQcZ1681lsymKa3XiCt+bt/Oe7SteOzLBBoFkzXJEh49WSySXU2PHhBSlGVxQ5+1ErmciJlUssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP/gY9l7ptYLFwr6tUVi2mRRu9ZV6pOE1wPChxq7sYo=;
 b=VPhCpAmlGYi7GY3fyXBR1WLkwWIbJDbhJ6AJ1gQyl2XriAjphNrTvYSz5IFtyggMFKXgyX6+8Hpla0cmoTiV4qljBNta96G3q9vaIMZK3SoPDyrqSP/sCQbMsxnQGdfADnsJjKmYNYgmF3D9Bybb49P0Tgon+3AdG7OpfxSNsbamHgH/g2XOmBo0ZPkB/dAwz7qyYR6sg/4ERfs2A4M24CU+iMhdTrBm6mTQV0n/rl+UEmRuKYe6w6pEWXezqGaqm5lZeYtZglOxIMuPjYaSGx5NUZ3aasfuFx2zivlZYNlBXqedAsivpaSgQH6P3BiL/hBVYnFzA4f1wHS3cZYUAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT8PR01MB067206.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:41:13 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:41:13 +0000
Message-ID: <088600bd-37cf-4491-9156-ebc1cb197bce@efficios.com>
Date: Fri, 20 Nov 2026 14:41:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 32/33] sched/deadline: Check the runtime of a task
 whose parameters change
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <d65436da41c304678dd3d77f003f32d05583fed7.1795181240.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-225415@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-225415@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::29) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT8PR01MB067206:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7584c9-e81a-493b-c077-08df473e3c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|261026140227099003|4143699003|56012099006|261022105027099003|261009223027099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IQnoSVqtY/CcCTTeby+GMd4uct4+5fJuxPN6Jqln88F9j9unoaAQiMFNYvH7sq9LfDOgSdFaMeVPzVRBmd+SVBaPl2mmaUJPzgELW+bfl1iA8HW0WVjZMvkFBAaQzNJezc7Kb32l1MyNcXuhlyVhdZC0b8OR7bCvqjbi3R0IXMAWBvo0c2LT5HWzpJsnQeKUbf0RD976lYnIzlGD4kDyTxG+d7ex0zGSDCDi+2wQkoCO6aEDXktFew9ZTQEkbZPydbHJGDTIh7ixqVuUMpzB/ZmPrcZ/itj3Td/dgszSd9e6znc+pOppDAJcnbrmMIcQ1WTr9BnLnYHEzs6JKMKb8cXcV5dh8qLltUjZpnBXWNPCm2JT2Xrt12oafUqd7ooLsZw9K83lVLUlsdIf0LQShWIg0LxqGDwiGXcE1tvhwC1/L7t4K7sMn98dpRosshg1fepiGmDuZIynZnJzAo6N/F9KLrGhHNQJX8zpSYUzxz8ObVmY9hR/43bneyejBlpf8J0Ufju6iGk3SxC3s1PMW2ilfcfWI2O6fgX1xJ8bP+RKbXLBweJLg6ya9c82MTrTP3Jru4KXRQ5zmDT3kGVHXprxokxSBzwm0DLCo9SJ9ek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261026140227099003)(4143699003)(56012099006)(261022105027099003)(261009223027099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2J2Nko2MkZNTEhGdUc4VjlUY01udUFmTjg1KzFvZmpNN3JGcnJqUUpCU0hH?=
 =?utf-8?B?RU96R0pQd0hoNTNKTTVzVkdvTkpsWk8weGZwOTJHV3dyUm5uSVRaaUhrTCsz?=
 =?utf-8?B?Zi8xekM3YVVpRXJraUxtckRRNzhQQXVMcGRDT2VWSVM2ZFc3S290cVJTNWJW?=
 =?utf-8?B?S1RiMFBZVm93bTdqRkR0ZzRNd3htTnpabFFWSTlsbHg2YU9MdTBCbzJ0OVRT?=
 =?utf-8?B?eWRtRG84TDhNWXdnc0x0Yi92QUVaUzRwbUZVemtxMUpqaW9tRER0cDlObEdK?=
 =?utf-8?B?ZWtvMFl2akp2M3JYSXFFUU1nMTVQNWZOY3JtTWpFZEZvaWZNblZveVV6N3Mw?=
 =?utf-8?B?OWkwNGpFTlpWRk5pMkIzQnY1aktHays5L3J3SHBicmN3TkcvbDF6RmZpcWpK?=
 =?utf-8?B?WjFxbnlZdDVmcW8zMjRVUEwvcVdUcmhuNkRxT0tFKzdoK20rbFIrT2V2S2pp?=
 =?utf-8?B?cUQ1T0FnV2Rsb0pJMDF4UURUa3p0eEJ1enBTY3ErTTJHZ2FpVURYRlk1bVZp?=
 =?utf-8?B?dkZQMGEzMGsvcWtzOVlXc24zOHpic25mR1V1cThzdEtGSS9lZ29CcUpRTDFD?=
 =?utf-8?B?VmhncVF4RGxhVkhXdTRoUDRpWCtLLzRCd0RGMkJENi9sMWs4aGJlcHBuSjI3?=
 =?utf-8?B?b2ZNOW53M284Zmw2dkN1N3VianhINHlqakR2QjNqSTZmTSs2MUFpU2REUDM0?=
 =?utf-8?B?dWhyOTlQWG1qUDJ3ZytueXdRUkpqVHZEaGpRamg0bjQ1RU91QjZPUC9QdFAx?=
 =?utf-8?B?QVhzS2xUalVjK0xrd01lYy9xZGJ2eFNBZmlXOVFVWk81UjJMOGZJcDJuM3pL?=
 =?utf-8?B?QXhYSFc5aXpoOXNDLzczNmMzMko0M08raGtnZkdqNHBLbmM4Y3RQajlYamJX?=
 =?utf-8?B?QVBmdWF3WlJlaGtuZlp6bDdyekh2bGUyak5uaC9QbEplUGlyNnZMTlV0dnBH?=
 =?utf-8?B?TFNEOWtxWXQ5TThuWkNqUDJEbnFFK3lMSXRRL2tqYXJjVFRLWCs4UUxGOStB?=
 =?utf-8?B?NFVYUS9YRjJSeE9oSVl1OVhHQ1NnTUV5Q3ZIZEJUTUNrc0V3SURZb3NIcE5m?=
 =?utf-8?B?YXhVdlY3V0RtRkxaUFFkRkZ1RU8vbGdKaDNOUFNCM3lSblF2UHlOT0dJYThO?=
 =?utf-8?B?OElkN2xPUFhRU016Z2NQTTdJdk9Ba0h5RjNrWHErQXEvMTlTQ1cxeTJzNzc3?=
 =?utf-8?B?a3FRYU54L0NYZmFZRkZkLzB2VGxxTGNYd0xSaHB4cDNUb25YaHcxS1dCZXd3?=
 =?utf-8?B?dFZ5amN5TngxZkpGSXlyUGVUOUZ5T0lnTkc5SHNLajUycFVIaFlhaFpXSnlR?=
 =?utf-8?B?cFNiSThpMlROVzhJbTlQbXpIcU5DZW5aYUZWcE1pVzVKU05MQVZEQm1Dc3k5?=
 =?utf-8?B?S2NPVTFsOURxYzhyT0o5d2d1V0s3RG5PdE9lemFqdXphbk1FSDhwWE5mU3Bo?=
 =?utf-8?B?Mmg0Ym1JMCswaDRWZ29Lc3h1OHBtTVRNVFRIQkJNaHRmNjBGWS9vUGxMY3pW?=
 =?utf-8?B?ck5UUTBoUkVJWVZMamVqUnhxK0Y3S2drMU1sbW9LdUxUNTJScjB5TzI3NGF1?=
 =?utf-8?B?SytCQmhqVStVRXRhNlFpalBJT29PN1RkaTVUQm5WMS8zSnowR3BzVSt5ZlNL?=
 =?utf-8?B?dUFHcXJKc0JUbExzL09sUTRUL2JGRmIxcWxCdFo3V3lEZ0lMWGtOcXQ3T3JM?=
 =?utf-8?B?aFY1YjBwbS9WQXlWd2FFSHczL2lOSVZjVTM1aUx0N0RGTitVSG1LYnVTbElh?=
 =?utf-8?B?bm5qMHpHek8wQzlIaFFqdThUR3hyZ1VzVGYvcDZ2L0hMRytucm13ZzU5OFBs?=
 =?utf-8?B?bFBLY2ZEZDZYaWNMZTlGY001YWRvdnEzRkRXMG9tdE9IZ05mWEZDL3lvaUR2?=
 =?utf-8?B?L1JJRUVUVXZtcXZGZ3NvUW9tV2JHM0RvMUZNT0w0QTdiT1lGT3Q4Y2RabU9n?=
 =?utf-8?B?VnI2ZVZETVBWQzBDQ1ZiNWxoRTJkNmtSQzZOWll4S2YyMDVUcTNHRHEvYS8r?=
 =?utf-8?B?SUsxZmVsS1FISFI5cDhxcU1YNnFTREJhVUpnTmtKVXliRnl3OG8wNmZudWdK?=
 =?utf-8?B?OU5kdWVqS2lPekU5UlFTRXE3eFZjbkVDUnJQUERmMkZ0c1hZd0VvVnlJSnM5?=
 =?utf-8?B?NENWaGpEdW5PSVcrUFJuSmh3RG9sNm1qYmdKZ1B5RGZsaitJWXE5U2NtREl5?=
 =?utf-8?B?eFhya1FlN09YVmV1T3RxVHNBRERGTk90ZFU3MlV5MldBczh2Nm5Qa1JWeGlP?=
 =?utf-8?B?bGhKVHdtcXRsVlZYbFo4dFFQdzAwbUc2OHdEYjB5Y2trbERST254VzBrQWIx?=
 =?utf-8?B?ODlzWGhrMHRtSkRJeUNQcElaVThyck1mS1hKOXh4SDBFM252bmFHdkNLd1NR?=
 =?utf-8?Q?sjdovuGMzQk6cNIhT5+jARgWEwAqlet8Uk8+a?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7584c9-e81a-493b-c077-08df473e3c37
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:41:13.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVjWHnSF5YwrO7aFKLaIgBblka3FPb1hxyhFVs7zIzhQ2i6UR0NjpAwJk9qZUJkhsotK0QnT/+1yK7VmsWHRjqeEedOXBZ/QTGMd9mrJptc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT8PR01MB067206

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
