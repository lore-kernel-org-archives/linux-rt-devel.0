Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203791;
	b=kLPOdyL1Jg3J4v4YYXjLVVtUZyunKK0L0VkZGZcizzLVhzbv6kqFPL1/r0kHydCtDYac
	 kFc+YbWgOlMsMUNNvvFuQu2UBFAdy2HNBJ8uVnQ5Ncam5vDmDvIMXtIVRmHZDiV9XIr3U
	 8SJBJ6DvfPONm/RoR+fZUZ0o7ia8zYayQVZXOz3hSzLJtvZsY2dFMdzr3LDATnmN7dtGW
	 vI0q+3UanyoTsm3uIuhW+CRu8UiyIpCR2/3/xKYGjB+LcOojjEO4qBmj0buHK4C+17jKk
	 dZG1VTN1o2WrOPOUU8Uv86QAL3kcszHdrg1KYauiLKcBgRNzgaXXKhO/rtge0buPt2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203791;
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
	bh=Da02+wIZY4QoQd9Ew6aQc/sSiyq+4ByQZJYhkDgqOGo=;
	b=5qC4td4aRhiy6Z8xYGosdH/wVF46THmowuFkY1Qy+DKOanRb/UKBHZGT4O+Rs8ILSwN9
	 UZemM2+hHG0LhH5pIPFxHGk6RQy4uQ1Hz9/QyTbs1sBQMq0Ska7WngxGXX2X76idZC1jb
	 sJfbBQnrE/CYQ7Ht7vGHszSxEwvvfBfHcAMLh4PBoEsMm7DkrS7KcsIvapkzg01P+VMSU
	 iw5bNjJgGI+qG6Fmvr0dRcIq/scJ1+cH2exU+gw/Hh9ndQfJma9/vSe2XuRu9nY5Qcn7X
	 yNsF1cPVioXh96EAkKB2+nEEi/RRzhLoBH8pj1v6COc4BGN7vVJgH3t3xahH2bnVOyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=blln8ek0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.92
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020092.outbound.protection.outlook.com [52.101.191.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0C606A339;
	Fri, 20 Nov 2026 19:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F0C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=blln8ek0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uab64picztlnmm74l9V/Mo7m6hrVBy9PCl66su8nI10e0zsYRM6rHXPNAMSJQUWpIW4U7qn1ppALC9DWRc1vahcVuZnYH9xotzMQWvSegZZ76SvrX+fshexJni7gDcIc08ZXdsF0onpcYvoGe424tT+Z26IIXBsOBcURvWmldWeHN1WQw00YGZlwKrbsNFZS0zhQQ5JFQH9JupPm+QoNrUB3cJ0+rZje8Y3l0RxshOv1zd5rwpaOp+lFod2vrrCXtFh92nDSMyK3A48o0xbFDGbuw8O/QU3lQLyqGcQ4HFJu96ifAcZdNiqDo7aMeAT12K4wdiLqS+UYrucWqoNrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da02+wIZY4QoQd9Ew6aQc/sSiyq+4ByQZJYhkDgqOGo=;
 b=bqN2+mogmgnHBzKaeWo4AJz+p3AywlKk2UPgXZYeQqk0tq/7myX2jFtHs4VPd/xZzJxEp/0eNHU3TlXtLUeNqIXi2l8NsSJB3+h7Bb3IuyYMefFh6zhKZO3vCYxYv2ZmC3tFzWJ+Jm8CRNC0/0TOPVZzggQ7kh4a5JEWvUbFzXsME+HVO20QNJOLQnvVS3clhLHmpqwK2c52TuuN7eGuUse6Y5psbXuB8J8udjwejOVCyyXhyCEFhti6hgfCH0eMhCoOF90mlABwj2NvY76mYspNBwpZeNVO11KjSrWeHAqjRCFl8Axu5ZpnyNfWn4LgAUPIWEgwTcxFfNvYUibVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da02+wIZY4QoQd9Ew6aQc/sSiyq+4ByQZJYhkDgqOGo=;
 b=blln8ek05V4fnhWJOYjNHskNI4gYdo0DH78Kgs34vzXAaxypHo2azVMA5Gyu6xarfppRe7nGvujQzPSaIDzaYg2MbZflNkHpXwL9wrHVZGaagMVart9kTtnrMv9nxSAxzp3nhcwwPHwcTBaIx4JUOPfxjiMWlVhzQl87YB3scAgbQnQEniFWqWG5ft/LjBBkiirfVeHgt2RK/hqPqLepNNDx+qcD9/UFdBUdIJ5LMsXC2MA4nF/Jd5LrLyZvnWUEkMSonm76st3c7LvvtR1FfNyahHCJgS9gA5LJI7IXiYKvKAyf/ujfXE4jZQqFUTaxEfAM3emT3VKRufV7HPDmuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB6254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:42:52 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:42:52 +0000
Message-ID: <8c429a8d-b15c-495b-84df-bcecbd5386ae@efficios.com>
Date: Fri, 20 Nov 2026 14:42:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 28/33] selftests/sched: Test deadline boosts in
 deadline_bw_test
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <3c1582ebc8887e6cb2183b47ee746c93878ce8cc.1795181240.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-225360@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-225360@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::10) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2bd423-c986-4a7d-6a95-08df473e7713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|4143699003|56012099006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KM5U1/9DsSdwOWZ3vBlYSqPJrkBFTC+KeE7c8S/xGezg60Iq5+R+rt8XAPY5OFSyK4TeZgt0OeQAQ+kTcmrzfV1aj2SWvB0yLer1QSa4mCAqNYAsy+QAXnoY7bmyUmH4ZI7uNjAfkgmSHjuCqlbmh3PdCSo1IobTI8/P5UY1DJ9y2DcH4kimc80CtavIYrybRkRnyfhIBWRsfqzru51nbS+kaIZHTUE0NYz3xdcTComwt0e27jgVnQW3/+pvjniAH4oEgnfxobsfrY1QKCHMauRzAyxNswL+GYwy1B5a6kUkG2L4OIFrdnS7oKLh0aVmiUdwE9ZZhokLv0ygGTo3YFIkBnyYaW3EjszCzAfQ+TggLIbiSg+7ZNScfZPrta6tFOZ2VDdQVi6PljssQWeobW9HMk8+zxA6YkHDeZBxzGkd33vh5mhEo1yktwZHPUZKGOI/cmVKtm5dMHcFN2Ytub94XtQLvQ2hF2zTctMf3ImNzZUhua/J+VkcoXY9dFKE9SeBHp/ktlWgy7SgM6y2LoX20KkPO228qV5C6fa6UvDRWADZ5zDCT4OdbFd1IDPF5RPpMtnACn/jfd8rLEG/tbi7wIauuuHC6bQWZM2N6vU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0FTdG1QREhXTTc3MEFuN1VaOFZuZXJTYlRHR3FldUY0R0Y3T0NmUUt0WFor?=
 =?utf-8?B?K0VnbVN6TDU1bFNMcVZDcDFKSi85bFk0ck1aekJxd0xGdHZucXFSSm1EenFJ?=
 =?utf-8?B?YVNGcGNvNzF2b2duTGN4aUMrcVhpQ0pZQXFUQmFSS0UyMktxSFRzUkpUWk0r?=
 =?utf-8?B?RmZFdmJSbHJnaXhDVlNTOW04UDV2dkNuTGs4MllYZTYyZ1JJR3NOU1l1bmI0?=
 =?utf-8?B?M0Fmck8reFduQm5vZy8raFcyamUxQzc2UDhuS3l4cDAyYm92TGU1M3F0VTdE?=
 =?utf-8?B?STRiOHQvOVo0S3QzRkZoMERBQ1JQTHRuQ3ZzWWlBV0FpRGU5VnJBV0JYOFhY?=
 =?utf-8?B?YXBKNlNuYjBabXhRZFdQKzBmUUJSQ3gxKzZBc1dHeWgrcG44ZmlBMGtVUWNB?=
 =?utf-8?B?MytabVdhcE9OeE5HN1dXUXFuV3laOXFWMTY0WE0xN1Ard0xjeHpNQXo0MUVi?=
 =?utf-8?B?QkJQcDFOcFJ1MHR0RDZvektrbTVJSm9tZWtmV05WTGJ2SWdUODN6Vy9kcTRw?=
 =?utf-8?B?NWJicE8vcS9ERjZCcElrekJuMU04OHdrMGJzcXdYa0c1aWMzb3VIbDFRc1Uz?=
 =?utf-8?B?Y1Jnem9JZkdLdDB0WXlReTlrTlk3V2hkUXI4YVB0ckczWmVSblBTS1M2a2FZ?=
 =?utf-8?B?WU5vUTB2SFk0cHRNQSticGU5T3pDUVFGR3NBa1VxcVEvQ25qZi9DRXd6TEtq?=
 =?utf-8?B?MmhpOEgyMGZZcmhDU0N0cFlrWUtlbWlwdTJKTU9xM2YxM08zQmkzZUdSVWJi?=
 =?utf-8?B?cktScXc4d2s2Vk1vQzBGMCtTT1h0SktCV2dvMVFhYkp0SEJ4QTRya1FHaWRP?=
 =?utf-8?B?Nlk5RmhqdFRkcDNOMENVSEtTK3lPQ0oyV0o2Z3U0VGVzZ3FRZ0E5SHovbW9G?=
 =?utf-8?B?ZkpFQm56S2grNFN6Njl6RkNLSG5Ca0NNNW45Z1JMYnVMU2Y4TFRDWEVOU1R6?=
 =?utf-8?B?V0RmeDZnRUVjOGcyN0IxNXpvSURjV2wxTDVvc3JRNDZJNDJVNlN2dG1XMHk4?=
 =?utf-8?B?bDdFSVhVRHhHdk5aSDNuZlJBWDBEdjMwaTFkdGFuS0U2ZmRtK0F3VG05NUwz?=
 =?utf-8?B?ajVpSGtBbkpVS3diVVZwb2toUVVOaUViUERaS0VVcUpTQWJUdlo0WEhWcEx3?=
 =?utf-8?B?M3JnVkpZV2M1cDgwR1JNVzUyUVMzeGY5a1I0aVAyTDFJaFBFc1JJV0FSOVR0?=
 =?utf-8?B?UnMzWEtoa2lidDg1S2tPUC9VR1IraE5RbDJKTmIxUE83a1F5aDJOL250Y1Er?=
 =?utf-8?B?bEJTZWZHa3VJcWJHYnNXLzdKclhCMnByb3haV0xLRUhVWHJkOGpEUWE2VEtW?=
 =?utf-8?B?cWgvbUNPdWpXTGlXQ2szMXROd0ZCTjNpVlptY0o5ZHZVL3pwNm02Yk9ETmJX?=
 =?utf-8?B?K1BxWWRvUngwT2VWcmJYYnVKQ0x2MHBaM3Iza0VpdVQ1MDlDaExLRTdQcFdJ?=
 =?utf-8?B?b2VJUjk3aCt3OGk0a0dGSEtWVG5aV3MrVSswMTVodkNQb0NZcXVHODZxOHp2?=
 =?utf-8?B?U0dEYlh2clJTcy85ZjVZbnAyU3hoVU1VcStlU1J6WW90WEFpVnFVRStoK3Jv?=
 =?utf-8?B?d1JTTzZtTkJNa201RkY2WTdXZi91enFPSzE3Vjd6ZVB5WUJvK0NURG5NTE9X?=
 =?utf-8?B?STFmV2ZoamhYOU12N0lsK0lINEJZR0d3RnNxSGdZWk9zdVpmTlZJdDZic1NV?=
 =?utf-8?B?MjNpQzU4ZU45OEVtY0hYWTRHaENsOUNkczViejJNUE5GSGx1b2lremwybHVE?=
 =?utf-8?B?U3lkNHhaZkFHTnY4YXJod2VuT1VKQ3ExUzNBaEkwT3Izc2pnSUhNY1pYK0R5?=
 =?utf-8?B?Rm9IbTV1RlY1MkdXNlpyT1J2MzRwQUFBNU01RWdKOGlZdUQxR3JkL1cxOUFM?=
 =?utf-8?B?Vjd2YjJVdUVsNEdXOG42NTRleGhaMzBPRjhqMDFYWnRFVUNGYU91dDd4S1VX?=
 =?utf-8?B?R1NpTVRnWU15alBVaVp1SGg1bUJpTjUxdWw1bGxuLzFUSnZzQjRQWVV6bWkw?=
 =?utf-8?B?bTdQYkk1N2x2NlVLc3AwMGtYRVRYSnpDRmJsWG1TUjdrTmc5M1c1M2w1WU1o?=
 =?utf-8?B?QU5PZ2h4aGR2SHFNRlMrdDZsaWlpbE1ZN2RUTHlDZG9saUlEbHpad0JoSjdt?=
 =?utf-8?B?UW41VGZXZWtCWDJDOWM4dUpENkVxK3hyWit3VFZkYlB4NWRFMm1KK283azl4?=
 =?utf-8?B?aGFEUXUwT1dzRlVBSGNMZGx4Z0NEbGtwYkFaZXAxZzY1VUZoRE83V3ZXb09t?=
 =?utf-8?B?UXpVWmNOQWVyMC80QVE2ZGsxR085WkF6NW5MdW40bWw1SmQvZEo5Mitvb2dL?=
 =?utf-8?B?WjJHSnYwbDE0b1I0aVNOdENVdngwWXRtZjFQMDNBV2M0L3hLRHZoRWxVTGZw?=
 =?utf-8?Q?qvulavEMxDXojznZC+dk3AC1O9VFjW/BH8Pu0?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2bd423-c986-4a7d-6a95-08df473e7713
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:42:52.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+kMC1zQdvFopm5rcWU8A0VLWpfWjKdGgB9PuLu1N3aGk6FtZFTuyOWvqE7T7nWWomHg7lWNzIi+KZVRNdwECfZXEYGXoG7P5td+RbMcMEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6254

> Can asleep_donor()'s 1s period outlast the 300ms wait in measured(), causing
> probe() to fail with a false bandwidth leak?

Yes, by reading. It did not fail in our runs, on up to 8 CPUs. The file
grows with the number of CPUs. In v10, the main thread will read
total_bw, not D.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
