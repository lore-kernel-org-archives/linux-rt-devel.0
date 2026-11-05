Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.85
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905877;
	b=ykQ6QIst3QC/Uk+0aKNCuVD1HXWCKpdow3UY6RM8GYAMyGYth+CpaZ6u9R3M4IAKHk3m
	 bkrxAJ/snnenV9Ntuh3gydsLTgQSDEXIv0LEnBE+p/Un3Y6h1KCp+p8Q/2gWXmfE0xbpD
	 pYFIeoCbZPs8Ga/cd6+pk26OkFE2e26FX5gaK8/kAras7onHO35OLaUiym37LS9Xbw1sV
	 JNFo8d7+MCy8Nwn0c5+lg2+K671hlFv5f1AvhiMMAWom7gi+hfwvRgVouNpZ1tVa/fiNO
	 0wTD9QsC4H9TuzXn59Uc/dsaLOaC68qsh08wMd8ucqLMiLqETqHq7Iry4v8rSQk+ffw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905877;
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
	bh=HfNhTXZCVodoFdV6eIXi5mQkV1qDRcqmO5d+4METZmU=;
	b=eq8r0fa1nYJV9z2IG+7KCtGsiZBJIYPtNVQiYE4PHJ6Bo+9DVyG9mafKNHZQ9yJCxoRv
	 XsE2pFh83czpVV6DLfRzKtT60uw1N7Cl8cIeLCwrPUqeOWH0VTqnZzwhtK4zc9yslxFlq
	 j86DSjy+RuRTdrrbGE10L/rZJGohbTrhQ440db7MbOhyNox3ob4kK1883/o7qQ4xbZ18T
	 /tG5dOm7uUClXGwGEvyS7I8y4HBGA02Tn0hK2ObqMn255sSXnKfvIPZ21et9XJetTlXG5
	 m1ApSP9Yc/jgjpmxnAJ2nlezAySL2nXrFtMUL00OyG0sKJO3w+3mIT1FW9qj5+aqa4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=W8CcYnD7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.85
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022085.outbound.protection.outlook.com [40.107.193.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723F606A328;
	Thu,  5 Nov 2026 19:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6723F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=W8CcYnD7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEAueT7rbtzMOn7ku5p4OLRGY035woT3rr18GkA6/q1saKsoPCtuQUra5ZtmcXGvdGw9Xg4hFnNZ+kAYKfeK2t2x/8F1Z8UvR0loAxBtVL0NYDC55bDMWmeg3N74edQ2ApOZeSOX+6AZebZaWSarg7MX8exklYK8vxnMyggvU20m3uhjRVkSsHjoccePBmeFpXqq+DcZnR5dB3nQq9gwBA/4nNzCqVUFJSsKOdHSY1H9iEb7jyeOQBrrerNT1aW4JmJapufgpZ9Jw/4rtF8G79JyAabkwX5C5M05NKe+q6cqD+aILk6ObzddXB3sGJo2z7gVmfwHA6wjnwXpMdkCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfNhTXZCVodoFdV6eIXi5mQkV1qDRcqmO5d+4METZmU=;
 b=puN8zpWO3Jn70fstaR5Vc5jecJ74fdf0jShYX4W6qenEim9blORDRv0JwqEn/iBJisvW6231yW0w2c1Oa3FhQtbyB2IdG70a9+VdDeQM/T0FR7gzFJwqerjebpYwMNxT1QqBuC8fhow9NfbY5tGxfhUPAI/q4/GtX9jhy0iQrSss93PV1blT9pOEyEWhc0vjnZlByuhYtSza5K4/5nY658aDmlrDEMO47ADPjwuq4hdH98om51DWT0fJQgkS3i2It0e7ooeS2wWbDy/Hfciy4/fUhJfdiHitabwrDGjIahK3G55rnz80xQVqoKN3rYKrnDeJ4lAP+Go1NsCVK/ZSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNhTXZCVodoFdV6eIXi5mQkV1qDRcqmO5d+4METZmU=;
 b=W8CcYnD7i/amO5hhIDjKzZn8/gNq0n7cFFI/3w5kpHfiu+BEszEsnW08U3MmFk6x4LyHUsCE19iHtjcIUWlN9853JhVcm26D/ElMzjjjSOnHodBuG4rd2JOuf8I+i5dWAKgAp/bH3SsqKR82JLBcaBXBdHMa4UYEn66hLcUC3xfKX28ilQTmDdUJE13+QaDVi/nC5aNK4lXNpXfS675GzIVpEo9Qpe4uLKPtWiOt5RLJvAQnxDD2uu92gyNUNL0usElp9P3acfKo7v3I9JaxLzcY7cim+UcAWwmUmAa9/0h6hPdx95RcGYtSMX//GwRhuA0QNZCoBdjV5pPybMK03Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB179232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:113::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:11:15 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:11:15 +0000
Message-ID: <34e498f8-cd3d-4709-a0ce-2dc36dd5edfb@efficios.com>
Date: Thu, 5 Nov 2026 14:11:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/21] sched/deadline: Do not release a departing
 sleeper's bandwidth twice
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-8-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-198212@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-198212@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::25) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB179232:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc67b7d-f357-4f83-b6c7-08df3b70903a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|56012099006|261102123227099003|261021123027099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9K6WA0K5SNwxjlfaOWbNBuqi08FF0DTxMZbBogwPajA34HvEDu+qRDfSmwlHx+BemPhJ0j8IxIPGsr1d7t0apJP7c6hi7dosp7CQ1SJOfopyX7M0JUS+HcBbEqhabelKEGpj3xuaHFc3QxrnEY7pLkVnWKwLtnR7qMcEE4CumtimH02CvXD2HYwQxmo6VNnN8toTlJuYpLWdu2G1i+Alhy56s2GyOIi5oqZl9DsOyhWhaeAUndekir1HlkhXM1L+3RKWKBD9F8d9Eptmij1uUdr9roNyllwtZKaQAd4400HRWvpioV1hmfm26NB9eEBTc9GF3jTzDmZV/nd9yoP8H2Vsx01OGUhECDGU/EOJiuR0vLQIwn/o+cgOEQzu2w6ShjPsQjlaT/LRYGqMPv3+1mtqPpZB58AZfCrMt4xFpYxK9zS+9KWzktLBlng9o2+X+R4s4KsAWUtPxuo/mejnT3QK8IaPzr3mtg1elEHwWcW/nE1qKb0AZs2tERlY1G8mHRpzGDdmdHhWpwbUU0Q9vwmHbrNuxXtIi5CJZY9S2LIwYf3O9YiR1cs8sEWHHxKVNcsSTfhGbxldeEqrq0VkjvSfyboB7o6NR0s+UDgIkPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(261102123227099003)(261021123027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnoxT1RWSmVZYnBXenVodGJuY1FKSEFIYlNmK1BmcmVKcURHU0Qyd1kwQlFI?=
 =?utf-8?B?NW5jcDdNN1R3ek15RWxFOTEyclhYSmVSWWVLZ2htWFlwM2FsZG1raHQvbnVB?=
 =?utf-8?B?WUVPVTA1YmJDcUh6ZXlObnFkazdWdHVFdGNMNm5xSHBWbUZKc2d0ZVFwL0Iv?=
 =?utf-8?B?R2R0dEJBd3BnbDJtT3VlL0JEY0R3cXplT3BGYWowdmI1ZjVaWXNIa2R2WWlT?=
 =?utf-8?B?TzNSZEQ5QStoYmxtcE91M3FyNHFWN1JIL1FNeVpFNi9NYkE0U0pWSmtMQTU1?=
 =?utf-8?B?NGhwbGdrUmQ0UCtRY2gyYXpqZVcyZXJDN2x6ek8zaUJuV2lCVGQ5cnYzTnJB?=
 =?utf-8?B?dExtS2JxVmVBYS9PeWc1M2ppSGFOQ3lOclNubzhoVU9TeENWdDk5ck5scWMv?=
 =?utf-8?B?d3E2dUhzVlNpcUNoMTEyeitTNVZmdHF1dHJLdjQ3bmdscFR1Sm12L3Z0bFZ4?=
 =?utf-8?B?SzdLZmRvVmQvTUhySU9UcGE3MGt5djllbTFBQlVPaGpSQUNqcFBJWloxblFG?=
 =?utf-8?B?SnI3MEFpbHlXQ2ZZZTB1SWg2M3c1Ym1kZE1xNTJ0WHlNWEFxQy9ZVWQwUUxP?=
 =?utf-8?B?Y3VmVTZ5Z3hpdEFVQ2E5NUlXMEg2cWlVNGM3SFhPOWsvbUNReW1Cc2loeGlY?=
 =?utf-8?B?R0w3RTNkQWtDUW9wcTg1NjA4OUNDaUZEMzd3Vy8yRktSby91MHdHNU0rNThQ?=
 =?utf-8?B?SFF2K2pKK3NnOXcvbXpjZWorR1BmK0xFeHlJWDlwM3krQnpnZmJjU3ZLdEU4?=
 =?utf-8?B?MXZ3RzZqcTFkOFBmM1BNS3FmUGF4Y3UyaGJBRGhNWFYwV0V0aHlKaTcrcGdW?=
 =?utf-8?B?dkNncEQwSWFNclg2S2hyV1JWYXpQUXVsTWZnbXYwWmhUSk5abit5a1NlTWFu?=
 =?utf-8?B?MnRibzJtR3R4R0hHQlducThkZVlZdnNxejV1RWdiVjB5Vm5PNWt5Zk5wTzJR?=
 =?utf-8?B?VXdoK1FRL0oxck1iMk45bExUcW1HRERuOG1EM2ZuSnRBMWpPWDltemIvUGxz?=
 =?utf-8?B?ZEpZcmpGRE1FU0pOSGdoV3VoTm5uc0ZYT3haMC9Ld0NxaWxod1ZiMjgwSzcv?=
 =?utf-8?B?bW5SUFh3UndZczJrTHhMblBMVFFTWVA2ZnpNM1dZbUxMd1ZIR01pSndOK3VN?=
 =?utf-8?B?QWhQUTE3RE5VeUVUckhncXdyRkw0cUx5UUlZeWpFaEczSEtmeDF6ZjluUXBY?=
 =?utf-8?B?STg0bC9Ta2p5WUcwUHQ4cC9yZ3JHOXJ6UUlaTUlaMlhFV0VEcnY5Mzc1bnZr?=
 =?utf-8?B?enR5WXRtWnZRNldoYWR0b1k1QzZWWkdUa3duZktFZitsd3MvenF6dHhxNFhz?=
 =?utf-8?B?bzZYdWhLQmxiY1BaaXUzK2ZhS1k0dktVYUdZRmFxcjdZMDFWc3VoVUZvTHgx?=
 =?utf-8?B?N1VHZ3BTMlUxaW50TXhJeVZUQ3pIaVlrbFZzSzVwYW9SZFlIYmR4SHNORjNp?=
 =?utf-8?B?N0RRUFJRWjhmdnBvOWNyajJyVm95VGp5Qm1lbXFiVWZ0Wm9lSEJBUUk1eWty?=
 =?utf-8?B?YkJRSnhlNnpSdzI4UERwNWlhQldKdC9aNHNVZVBwQlN5UktHK1JFTm55NHBp?=
 =?utf-8?B?dXVrSHgwZjUyVjdPNGtpNVFvQnBzanB6NlNsQ09wM1ZHN1R6RlZxM3V3Tm9H?=
 =?utf-8?B?b2oyYkREOG9zeW5nVzRDc0FGUlBSSHdXNHZTVXFqZHdTTnYyWVNNd3dPYUpW?=
 =?utf-8?B?UVUxdUZWT3p2Z0ZQTzhNLzlFM0dZYWM3SmxJazlLdkF5eEZJZWtrZTQrUmNO?=
 =?utf-8?B?UmRPL1gyUVdlbDE5THBlVGtoYUtXK3hTb0NYK2tYSXdHeUNFc1l4SkN0cFdq?=
 =?utf-8?B?Ym12YUx3VUR6dWhzeFpmRlVqVS9rVXVsRUNFTkFHME9jckVVTG0vZmNLaUlm?=
 =?utf-8?B?cWZyWm1XbFFtRHY3QkNyemgyM1V0dTg3UlBvYTA5TUh5K01VVi9ERmNxWk8w?=
 =?utf-8?B?anRDQmFlMGZlb1BRQWhWTzNBakRES3dnSUNQS2RIaElFZWpkTWltRUNZaVRl?=
 =?utf-8?B?TWVVSlVLUnZTN09yU1RUVVlKb2wxWkN4STU1Tlp5ZVZDbXhCK09EQVdhUXZN?=
 =?utf-8?B?VGFRUEhJTzExYTMrK01qUFpHZVNpUGNQamt4aVp6bVd3dXQvOEZ3cmlMTnJr?=
 =?utf-8?B?MEZiRHZPTjNsRmpCLzUrMm5oRXFUYXAyeHduMHdISy9zK29rN2dUN0ZKeGEx?=
 =?utf-8?B?NHFqcTNUam5VWWp0bk1kYTQwOVltOG5xMlVFZ2lBUWJZemhiOFJicmdDc2Vl?=
 =?utf-8?B?OUpkWkY0aU8xTWV4bUFvR3RxMVl0bTNBOUNpR1ZuUjFPL09SUytYQU54cjJM?=
 =?utf-8?B?N1pjUGRXZng0QWJmc3VxdWV6eGdUamJJVzZ5Q3VDWmhFck95aEIvMkhnVjRM?=
 =?utf-8?Q?akGu0yBocF60ltCE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc67b7d-f357-4f83-b6c7-08df3b70903a
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:11:15.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlFTOCr8sSxM6+WiPDvwf6w/nq3yjNV7XCg2ooJPIPEfS2VicSOh/n7LWJDvrYbqXslKBdXO7x2LKvFgs16PTmXcmWQewzma9IXG72AmmEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB179232

On 2026-11-04 17:15, sashiko-bot@kernel.org wrote:
[...]
> 
> [Severity: High]
> When switched_from_dl() takes the !p->dl.dl_non_contending branch, there is
> no pending inactive timer to run inactive_task_timer() and call
> __dl_clear_params(&p->dl) later. Does clearing only p->dl.dl_bw here leave
> the departed task permanently carrying stale deadline parameters
> (dl_runtime, dl_deadline, dl_period, dl_density, flags, runtime, and
> deadline) after it switches to another policy such as SCHED_OTHER?
> 
> Several paths in kernel/sched/deadline.c check dl_deadline, dl_runtime, or
> flags rather than dl_bw to distinguish a PI-boosted non-deadline task from
> a task with its own deadline reservation:
> 
> 1. In replenish_dl_entity(), initial replenishment for a PI-boosted task
> checks dl_se->dl_deadline == 0:
> 
> kernel/sched/deadline.c:replenish_dl_entity() {
> 	if (dl_se->dl_deadline == 0 ||
> 	    (dl_se->dl_defer_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
> 		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
> 		dl_se->runtime = pi_of(dl_se)->dl_runtime;
> 	}
> }
> 
> If the departed task is later PI-boosted by a SCHED_DEADLINE waiter while
> holding an rt_mutex, dl_se->dl_deadline is still non-zero. If its stale
> p->dl.runtime is still positive and p->dl.deadline is still in the future,
> replenish_dl_entity() skips both the while (dl_se->runtime <= 0) loop and
> the dl_time_before(dl_se->deadline, rq_clock(rq)) check, so the boosted
> task runs with its own stale runtime and deadline instead of inheriting the
> donor's parameters. Conversely, if the task never ran as SCHED_DEADLINE
> (p->dl.deadline == 0, p->dl.runtime == 0) or its stale deadline is in the
> past, skipping the dl_se->dl_deadline == 0 initialization causes the loop
> to advance from the stale deadline and trigger a false replenishment lag
> warning.
> 
> 2. If the task previously had SCHED_FLAG_RECLAIM set in p->dl.flags,
> retaining p->dl.flags while p->dl.dl_bw == 0 causes dl_scaled_delta_exec()
> to call grub_reclaim() when the task is later PI-boosted:
> 
> kernel/sched/deadline.c:grub_reclaim() {
> 	if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
> 		u_act = dl_se->dl_bw;
> 	else
> 		u_act = rq->dl.max_bw - u_inact - rq->dl.extra_bw;
> }
> 
> Whenever u_inact + rq->dl.extra_bw >= rq->dl.max_bw, u_act becomes
> dl_se->dl_bw (0), scaling execution time to 0 so the boosted task's runtime
> never depletes. Stale SCHED_FLAG_DL_OVERRUN in p->dl.flags can likewise
> deliver SIGXCPU to the boosted non-deadline task.
> 
> 3. Both task_non_contending() and task_contending() guard against
> non-deadline boosted tasks by checking dl_se->dl_runtime == 0:
> 
> kernel/sched/deadline.c:task_non_contending() {
> 	if (dl_se->dl_runtime == 0)
> 		return;
> }
> 
> Because p->dl.dl_runtime remains non-zero, blocking while PI-boosted (or
> deboosting while runnable) runs task_non_contending() using the stale
> parameters and sets p->dl.dl_non_contending = 1 with inactive_timer armed
> Even though p->dl.dl_bw is 0 at that moment, if the task then re-enters
> SCHED_DEADLINE via sched_setattr() while sleeping and PI-boosted
> (prev_class == next_class == &dl_sched_class), __setparam_dl() assigns a
> non-zero p->dl.dl_bw while dl_non_contending is still 1 without having
> added the new bandwidth to rq->dl.running_bw, causing inactive_task_timer()
> or migrate_task_rq_dl() to underflow rq->dl.running_bw.
> 
> 4. If the departed task wakes up in SCHED_OTHER and later switches back to
> SCHED_DEADLINE while runnable before its old p->dl.deadline passes,
> enqueue_dl_entity() checks dl_time_before(dl_se->deadline, rq_clock(rq)):
> 
> kernel/sched/deadline.c:enqueue_dl_entity() {
> 	} else if ((flags & ENQUEUE_MOVE) &&
> 		   !is_dl_boosted(dl_se) &&
> 		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
> 		setup_new_dl_entity(dl_se);
> 	}
> }
> 
> Because the stale p->dl.deadline is still in the future,
> setup_new_dl_entity() is skipped and the task reuses its old unspent
> runtime.
> 
> Should switched_from_dl() clear the remaining deadline parameters (or reset
> them once any PI donor relationship is adjusted) instead of leaving them
> populated when no inactive timer is pending?
> 

The baseline keeps them on this path as well, and so does the inactive
timer path until the 0-lag time. v3 clears the state of the period with
the bandwidth (throttle, yield, overrun, flags, deadline, runtime), which
settles (2) and (4); (3) cannot start, the zeroed deadline and runtime
putting the 0-lag time in the past, so no inactive timer is armed for
such a task; and __setparam_dl() changes the runqueue's sums on re-entry
(patch 20 of v3). (1) is a lag warning at the next boost at most. Clearing
dl_runtime, dl_deadline and dl_period needs the donor window closed first,
which is a follow-up.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
