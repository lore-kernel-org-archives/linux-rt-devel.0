Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182603;
	b=HIf9BRrYxiRvtaaHH98bpoOC6Qs8qkpqy4bJNFuEzsxYja88U+L1f1hHXdbxa7JKCsxG
	 bhgDemRNHQsv0nIGP0QJ/KJ1AJwKxiE189SkZrkBXGFSD9x6mlxNWjPwRvql4C0xeYWL8
	 u85eUALXxzfsEPt6V1Qy8GNn0W0TSh0SQ/SEjwW3msZVeSNOuEwvEg2Nr8K+NKbATxRZP
	 cb84AeIPWX72eN9B6OxQEkJXzVW8QqQlg6ncnqBFPKrj04CUBvdUfuZQMeeZLyIBqlEzO
	 lH+Zxd28KX1YY8LlNL9q+U3JmkakrIw1M51oOlLIRY01zziPkbeTo3MpffAmb9z1IEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182603;
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
	bh=D5vxolDMIGPbwgd8RsWQHzKNdnUhbYLzfa3AY6fRNG0=;
	b=QluIv83+qB2tuat8XQZWPJezJ/VgRMQ/3Rs9CfkTnRlnHj+RcIRBmBHA9qlojv3jrtSC
	 KcD4EsugFTVVcDFS6JtyWry7uswnRl3WQ4OL0wr+Hsm/uUAO7R+ghx9Ks9orAYUWAG2Z5
	 WMAFLOKhGtlQ/FlaydlZ4JXwoKtTqxOYIyvIFP3H0Cqnpw18epmZ2jtXlIhJZzNmaLlI3
	 95ngbk9uwTXh19HXOBclBDbrgiNVaR8m7VooC9Ui8QzoBMoL4BlOOacAnhWvpiKFlDAtd
	 AFBAomxJQxzqNIqgAcryOjUzgrkIkWjDfXaEZ0EJC1ieHcJqMLb4xZ9IASjFjBJHFMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=RVdNGW7n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.82
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020082.outbound.protection.outlook.com [52.101.191.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E00606A33D;
	Fri, 20 Nov 2026 13:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E00606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=RVdNGW7n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHxR1WgIAV0oGg4OvLxyoQ5gXevoh4t0Rg9IO9lI6isnSooblagYLl4vI13jMAlS4xkakja4YGXk0P+bTTs+qorVrdjfu7zmGiylp+MfDKqupaBBxOr6m5OkXPKfC6vZGzJfG9jDta6s7POkegIFlUxG7NG4Bkox6gx8fRvbv6Ibeb9hikuaGqdvCizYS5hT9mvpcBOP9yXCjATPrvHxMBnjr3F/gC4oNIe9uSE93BNKxWjGD1RYfxh9WojVSQNEXaBV3vXLSSX06IvlBlPCHUAzvp/QsN8/JtEU935LKWeNrAp/H6cfOFZakFU9CFV/a+gX3yrx/a0AwFT/f2koiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5vxolDMIGPbwgd8RsWQHzKNdnUhbYLzfa3AY6fRNG0=;
 b=a6Vn/WZhGAgSsFGyWDM5O8GHgHSP1t67hOsLEbZIAC/Yq+muwqgcMboNC7V92fcFz7CsyEioFbT2prW20WJPljljMPlEkI+loajkuWKzSiJUsixDYv4VSaix44SlRIPu6q4TPpRiAhCxeRFoQ/9pdZjGZVIYvhTpbZPibRqgWYbIxSdkAj/p7bEk9o974So6SfB2QOITcgqF9R0OeZ55SJEAHCByYYcmgE4zqNidJNa3QFvQ/NIKBZBH1uu+ofTI4xdzs2tsBSICA93nvSQIMLhZpb5Rf+Aqa6reGfzm8SdQcUDoauhb1pnbswpj/uiCVV4760qH5YkUVvsKgd9lcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5vxolDMIGPbwgd8RsWQHzKNdnUhbYLzfa3AY6fRNG0=;
 b=RVdNGW7nSMl3He2BhywMHwE1c1AgmMpGTTN1P19mO3oQPMydPYxVKCPACeAPIO5BPxFiuDzO3WKBVnj3CqcAj49793bZ9sZA7J7vtBWKDdmdMlbtzetDQyI4YVDid0FULWbrMy7ne7CuwWacglXv2f4fHlsCtpbEBPoP5CdFJvYqe+awClJnC7Yorsc0+chnjGmWt7sIcIMWFci/+o/3IhpKoiP8NeZOjytHjgrmfF1vSYR3ifJPXrtGQN0d2/g5y5EgOrTtzJLldENfkesB7Rfjk0bFRSmoXmUc+2yNlCL2TRle9tc/lmoyrtogjfQOxjqUuidWO2bcsW/P5B68Yg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB165033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:200::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:49:59 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 13:49:59 +0000
Message-ID: <391ee5c8-325c-4e85-902a-e5d24e480ac5@efficios.com>
Date: Fri, 20 Nov 2026 08:49:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/33] sched/deadline: Move a task's bandwidth to the
 root domain it runs in
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <b4bddc11bb05352bb1eca11dd5e0060479aa2e5a.1795116791.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-224061@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-224061@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::11) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB165033:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f91e08-0f75-43bc-918b-08df470d2b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|261026140227099003|261028144727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GRtgurOmqLYgZvuSnkzqao8fu6C1DJdSqZlEXIErG6LBIz4/JUqsSGvNEpjlYinzlMJJjiGInbwerFQ8VQStIMbuXGHDAT0wzIr65FpOeqD7uEDVI9sYDvV6uRVgygV8mWG7+BF73mgdwM1oe3h3RdNP89KpxBKMVF1XSTftKuoXIzFA4zFZEyQbGxW4P0ZV2RMysvGn+/YbjguZmt71xSoODU8OZ8kf2rM01mKbvSPkrsbUXeX1pCd1aN5U9rdrHljbtp0T+nPs3aq/KHseJLpNKz7Lj4K3eiTYrcxOKz6mnw/TBsNM0EaDyrZBA/NhgRsIRfQ9xZD1PKGp3uI3NRT7Pbi8/9BjFVNikYkuPhd9aOcOfR602ikZYDGd+EsMvajAczE9an3i3Qo+rEiBv5agQfVa92VwSBgMjjLWaoCxUm7G/ab+ZA6bZc28qtxvTgZnhKhHVWV4sAU9R/lG97PZPqbwxZg1VnXK4mOqoNjsY/LFQvUBBP3UYpCzTI0PYFdhEymctQymVGCVvnVqZEa7JQ+ZkZvEeP2D6wO7wqH7WsuOYVt2ZrNH38WHKOldanExuOo5j3XHUB2SRJd2RxVi2Rh7/0xz+O0UYfLmrGU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3J6NWw3dEREd0RWZTVjT1QrbGRZNmw2THBmNGNxNDZDWmIrZkwzZUowN3Iy?=
 =?utf-8?B?VFV0MWVCdk5nUW8rZkswWTRoK2dLRExDRVU2NWxmU1RvWHlmYjk4bzVPd1Rk?=
 =?utf-8?B?bVUwZ0lKVHhXTTdXTzNJaml6Tm9PMmxBUk9oOEhqdHlJd1FIeUowdTZ1TFlK?=
 =?utf-8?B?Y3JaeW8ya1JKVS9Ha3FtbjlVM0lXQVNkN2VzMUtXaWF0UVJnN1JuUmt3azJC?=
 =?utf-8?B?VWYrVEdDbTNZbzlsWXNEOXpVTWxHa3BrL3JwRE5KQ0YvQWVYTjR3WE1ucFlD?=
 =?utf-8?B?VjR6aWdNMkRQZVBncjJvR2NtNU5xcCtQRndNYTNybWd3M2s3V3hwYVVvMkJ6?=
 =?utf-8?B?M3hpVVBiWmRvUVIyV09BZEpvd2NVVmV0MzdjK3k3U1lJZEtDSjZVN1FmVmNm?=
 =?utf-8?B?bFg5dktzQzhxbUZWd3V4RGxqZjNZMnRZeTNVRXV3YzNiK2h6Zk9xWXFhcHlX?=
 =?utf-8?B?anRCTUxJZ3pDdFlWci9KVHN1RXdNSDBzd0UzVytUSU50QzcwaG1LdDZqNWQ2?=
 =?utf-8?B?TzJrZSs5M3h5UDUrTUJCTUpocW1rOG81TDNRNmpxNVpvU3RUZ0RMVTZDLzEy?=
 =?utf-8?B?WTZRRXhnSi9YUmduNXVMR29LUjJEL3hXUjcvMXBlNnFDMUdnbGFHRXhnR2Uz?=
 =?utf-8?B?a2pFOVFxdnRYSmZ2UTEya0ttOWNlM09MTUJ0dEcvZWZxejdhQTZmejQ2MWJu?=
 =?utf-8?B?WENWYnBmUC9aSmxsd3ZFZ2d6RFl5U3VYNHpzSDBQeXY1R0NRV0VIdU5jTUZB?=
 =?utf-8?B?bnNlTzJEOHJSSlNGbVN2VkdvUnFDK1hsdDQ4MjJLTCswNlVseTRiZkJNaWpS?=
 =?utf-8?B?SGJkcUVNcHo3a242c2pKMmpGemhsWWRDOVVvNEpjKzFQRDVDY1hOTVBjUS9T?=
 =?utf-8?B?ZzhJSWNYN28rMElDdzBOdU1FWVJvYzlWSFg1UWdvblVFc3FtK29pUTdEZmtr?=
 =?utf-8?B?KzhISjMvclZuZ2xvVENScTY1M2tsamN2Q1h2Z1VSS0ExYmFoZHRyci9MRTNu?=
 =?utf-8?B?cVF4VUxLY25jRjZwM01pcGU3L3REVU5GM0Z6dHFpczVyYWxtcjNEWEh2SDlz?=
 =?utf-8?B?WXlFSW02MHZxeVRJbVhOMUJIREZEYUFrb0Ivb0grMlY1c1JFWU1nR09nRVpj?=
 =?utf-8?B?emQrQktUTUxZUnh1TlVpN2lvajNFc2hISWlEOS9aNFZ4N2p3SmpHVGRZcEZJ?=
 =?utf-8?B?dkdFMlpRQUV6bW9PK0NRem1BQkxJSlI3aVFaTENPVGFoVnZ3MzZkZ01ZYnRQ?=
 =?utf-8?B?SnZPbTN1bmVLeWlRL2hyWlNremswSUh0MHVrTHZhaEZseGovY0srSjRrbTh0?=
 =?utf-8?B?RXVwbzAxa1pNL0tFZ3RTR3JBRWZBNUYwM3c5UjROZWdISUhBc0g2VnZsV0Fw?=
 =?utf-8?B?TlhuaklPWmhBSzEySEtKdWlrdlB6bTBMVkZqNk9Xd1o0L1lPa2dqY09XUnl4?=
 =?utf-8?B?aFlmRitKL2QwblRqVkt1WVgxT2NGaU5kYU9HQmxSSk9PL3psQzJMSWEvTXpt?=
 =?utf-8?B?TldsV0UwMmhYc1VlWWNSTy92TEt4V0VrTno4YVMrQmlTeTJlRVJ6M0F6eHYr?=
 =?utf-8?B?RUdnYjI5RDFkajFtR0sxcHBjTXZRYzZvVDN3NXh0bDdEWEtjVExESERwNFB0?=
 =?utf-8?B?NTVXZ3JmNGRiRVNUOE1NY0ZMT3ZYektPMHJ3VWV0M0JIVTR3cGdFQm5Banc5?=
 =?utf-8?B?dUFTZzFDRHIzcnRHcG1uaXJoSW1jQldnc3RRcHd2cDNPZTE0N0hsVDVsWW5v?=
 =?utf-8?B?ZU4zSGEvekdFWHlaWDB2RURpaDRvREVsSEVJOXkyUnJzYUJwU0lPS3pJS0FV?=
 =?utf-8?B?RkJVeW9BOTVyNi9EVDMzY2ZIaXlNYkdNSmVaSU9rbVlmN3g2UnNldUVWQ1pK?=
 =?utf-8?B?L2FDaWpzelU4c0t1Y2N6ZDYzQjc3cFNDUm8wa1FUdjlWdzZESTFDUm8rZ2xX?=
 =?utf-8?B?a1dpUEVCZVk2QW0zbVB6T0NESDB1OFFjUzFCbXAzWGNXVkpNZXp1R0Q4c0U0?=
 =?utf-8?B?U09pM283YnBHdkN5SGQyZVdiN29ZeVFvekUvYk56aVhRMXd4QXZER3k5SGFz?=
 =?utf-8?B?L01BRkFnT0VsREVxNzBBV2x5UHBmNXhSMW4zd1MxZjBUMDcwZjJ6YjJZTUdY?=
 =?utf-8?B?a2VsbXM3QklpdWFqNE1GYVdDUGRTQ0VFTS9YdTlLZENmQlB5QWh3L3kzNHpF?=
 =?utf-8?B?d3RGNm1PYU9Ta09wR3VzVTA2YjJqR0NQMmpNbzZTamw2M2wrT3Y3SUFZWVhr?=
 =?utf-8?B?UXltWHBWMjU0c2liQm5ueFY1Y1h5R1FKdmNHOXM0d3oyRnpsYVkvYVFRZC90?=
 =?utf-8?B?SGhDTUsxQ1NTakcrdTNSdFo3V0xxQlB3SkROMUdQS0JQTWxuenp6bjJSbm9Z?=
 =?utf-8?Q?XdJGGOV8KZzbN3ApUuSXq4EVURz06Zw4orQw0?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f91e08-0f75-43bc-918b-08df470d2b5a
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:49:59.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qmTEsFNM8KAIXDgPMAeqli0hKb8JdPt8TkTuf9TmPrKIQJQK8uuL8cKSde7fjGtxCuIwKqFcc/B5auWvTolojCq1Oa3PTqVxZ9/gSXtMCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB165033

> Can dl_bw_move_blocked() prevent a task that dl_add_task_root_domain()
> already visited and skipped from adding its bandwidth when it falls back
> to an active CPU before the tasklist walk finishes?

Yes, by reading. The walk and the wakeup both take the pi_lock, so your
order can happen. It needs a task with no active CPU in its mask or in
its cpuset. The task then runs uncounted until its next wakeup or
migration, or the next rebuild.

v9 will stamp a task that the walk leaves out, in a new field,
dl_bw_skip_gen. dl_bw_move_blocked() will not block a stamped task. The
offline migration of patch 15 has the same gap: the stamp will fix it
too. 

> Can dl_task_bw_elsewhere() and dl_task_move_bw() move the departing 
> bandwidth of a non-deadline task that is PI-boosted back into
> dl_sched_class before its 0-lag time?

They can, and this is intended. switched_to_dl() takes such a task off
the departed list. The inactive timer then no longer releases its
bandwidth. The task is a member of the class again. So this patch counts
its bandwidth where it runs, as for any deadline task.

The comment you quote in switched_to_dl() is wrong after this patch,
though. The bandwidth stays with the recorded CPU only until the next
wakeup or migration. v9 will fix the comment.

> If a task sleeps inside a migrate_disable() section on an active CPU while
> its affinity and bandwidth move to another root domain, does
> task_woken_dl() move the bandwidth back to the old root domain when the
> task wakes up on its pinned CPU?

Yes, by reading. It is most likely on PREEMPT_RT, where a spinlock_t 
sleeps with migration disabled. In v9, dl_task_bw_elsewhere() will
return false for a CPU outside the mask of the task. The bandwidth will
then stay where the attach reserved it. migrate_enable() will move the
task there.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
