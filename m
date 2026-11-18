Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009251;
	b=NXU+S1lmy4OfgLHrc7zNdDejjhqmL3xZcyFlnLAoQPp8pR5CfRgZ0PjewPUpnDOv1DhN
	 Y4kbzzi5L5cAWWL7iKLcE1e2yGHJ7kPsdIMx7fWesTgTleUpfKXok6AthctclY3shZCvW
	 OK77vsXV6cwQRzCmAIg3NcE2T1zdl0GTUBO5C0/Qqw4HfLzmtMeVbAbH3KjQdq32O9Zt6
	 FHIV9+QSErlFXqmwk2AhjrMoTO0mgOzd7XOrbTprDlqdIh8wnKaE+0751BZJVbeBFISSi
	 DLxZ6hbsUkOjOHgwnWeF+ukwFLKW4aktPfiPSQDY1M2zJ65yuYXO7PhckkBbN5p33rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009251;
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
	bh=IUxCw9Ow3UgLkwA5cg28Xan86zSyPag2QkRbk6oXJgI=;
	b=4c36BCghcJL9RKXLBuiYeASIKrtJxW8vF0NEbgMmcyXQ+f0yd3DTzYrbBhnjATFHr3AR
	 0FrA956HwOUURVEmdiLzKFLhyPb11EfhrmXh9MJHW/1Zvc6RMq5Qfoyfmn1uCJRG5DKpm
	 jFvdS45CdPyy0EgrxctOnqEgLCb2nHcYXutCh6QBUCABqHE5WvJeyeh2Itd9ojhp+gdPx
	 3XdNx07lDj2JlBLwQq/yaWHmQrMHWL64A7ylMWxKQqYU14nDeZLTfViIqXLBGtEMyhiuG
	 l23n81m4g5QuFySZ9OI+ODuAZGEuuGpMjZ/DLqzc55YQQbG66yL7m3fhWj30S8FWjCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=KQbgY2tJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.83
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020083.outbound.protection.outlook.com [52.101.189.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2ED606A32A;
	Wed, 18 Nov 2026 13:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F2ED606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=KQbgY2tJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3ZGS82Fx/hHTh+90+/wUECwq3EakrTIFu+gDIxje35srqlt5d48iaH/RWCOwEhcqO3+qd+1inOjM4YH4rVDc6B75sBbRVoFuhhpkNM82iYZ5aPMHH1vOiZPFewf73ArOd7GUXXpRV0bX3opAUxAflAEtcGyb1BpqCXe/KMzHQxMoBe6olgrzErUyv9iEl+P/iz92qE1vN0FqN/cHpn+5ziCVdUuGLB38WSTKPS8tBmhJWl9JIEIhGHHkqpMW19MSHdlv2UYYCgxHwISGLXlDSd4AyXsWtI4Sucg3O1xccRLhlEt8drEaBr9/SlbW7KD4feDYymu4ylWfSZQV8jgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUxCw9Ow3UgLkwA5cg28Xan86zSyPag2QkRbk6oXJgI=;
 b=HDLoJzieJVub4v6H2rBqHyj6mPga89aHI8Gi49ykvLC9PAznnpii8G9GDThHNtmpVCTDhxMHy0bakrt5vp1gEnvpWPyEjXnwA03ffqdCg14YrO7ncGX7H76BZZWFEjqVz3g4JOtwnp84rs1EEKbRae52xOrAU8aF0ncZcRW8dIzzlGmCxqPVoyR0xMQgQAZpymtVpvChYru/pHBzSysfBrCMQr3UjiwFwG0AUJaUj1x0LKzYsdABEi4yxc6ofb3zgHkWQAWffTWU4/pnoRYPIT8Xeb13qpM1CR6VOrf63AQ6pnqcMzRzLN1IPAg15z1kQMhmU43Wgyy4W5Wwl4PfcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUxCw9Ow3UgLkwA5cg28Xan86zSyPag2QkRbk6oXJgI=;
 b=KQbgY2tJjUl6LgvS91rakqRag6zoRSJdSENIol157RVS0lJMCaFqFitqr/Gf63q3Eqn8nwNNlvBbhwVpUckq4YfSQpa5SdgjF2EALmei9EFk7etEQGd7Q+16nxWN9hZcONExQbUbMpPD3iUD2S8orPR7NOHSYA7UpbASE/CaxRWNsWM0P/fegXB6HKstAzTm9ZEt2d69T0wA56zUqAZtGowH7VfVNuVuHcl/lE4CWwYNhqfU1ytmCcSaZHPggHmgEWh/p0DTQlG+BxohNH8u9Smn2XSmdggoV1JA3tXj5ccV5AXhQCiM/AnynuzrMJ5J+977zNN61rtaO8wpv8fzcg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by QB1PPFA2F60E653.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c08::274) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:40:46 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:40:46 +0000
Message-ID: <805aa37d-66e5-4bf3-a282-b3961ebb516a@efficios.com>
Date: Wed, 18 Nov 2026 08:40:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 28/40] sched/deadline: Keep a task in the root domain
 that counts its bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <2c1a48adf25ac3528a1f88632bda53826db5399e.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219085@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-219085@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0295.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|QB1PPFA2F60E653:EE_
X-MS-Office365-Filtering-Correlation-Id: d197d14b-9566-4add-4211-08df45798ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261026140227099003|4143699003|56012099006|261022075727099003|261026121527099003|261022105027099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OtRSGCJbex9dyqF8XLZt7+OFO3mlqq2xX+w7Ak7kA2UbwNpQBuvqbmEpF0ujoCdc8VJz/jvEGaBsAqN0IlpYa6KQs/3dCGklEZiDKg2LgvRlJb0/GLcN9kAQ5DgKSGCojNe2MXWk2XoJmQSE2goZCstNn95PLAk76Dcwbwmo9XWf3nccwdRn3pRda3vBRpS9A8rvdEyLmaTw5ENfjcQ6r+sMfCnFTXj/o5Trz1MayFDWSAh0GsZ/95EI79K7VcCeP94ROCjf7tFXkPT9Ltt5rZdrTe9ztdPsDmvqLYQYudlPxyJxFICwvnjgDFMvW5brXK+9SrFoFxj+Kz4/1OrWbPtoO45aD7li0vd+bcizXmZ1YR9q9VqvnCPtRMKT0vQVtbH9d528x7wyb6L6v3pujUtGuz7UBdeTHKTFJauiZPIPv9sSEasXbCAEnM/YoQJWUNE0wkA9tO1rQq9quAszc3g/9ClYedDJZfV3K23Vsrh93UJFe1AFgMzvK37tC53zu1pnwalCFaqOK+XFCQeUV/lGYkJ1feaKG9N/Lnp0k/gFdwnc5SrMOq0sts3DcbKb1E1sPKXp+82p4vgGCL8wi5AP9CBkscJre0JHuvd5fng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261026140227099003)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0NWSjZhb3lSQ3NrL25xeW5ZMkVuZmErcUwyM2o3bWExKytvWkhCNVkwZDRI?=
 =?utf-8?B?cmQzZittSTB2b3U1bTRNSHh4ZlR1R21rNEVtV1YwaE1Jd2xNaGZ3V2J4dFNE?=
 =?utf-8?B?b2tRd3FuSEFRbHhlS0tHNmRiUTdjaksxOE1BblBWN2ZtWXlleHZEN3FZeU5D?=
 =?utf-8?B?VmVoa0RSSDBoT0NaL1V2S2Z3dmZKK2t5cnZ4RmZDTVdRTjV2eDdGZXk4UGcz?=
 =?utf-8?B?UmlpZzBkLzFOa2M3eG9MbEx3LzBkOWhBbkpicjVpelVLbEtidjYwS05CbTkv?=
 =?utf-8?B?L1M2WWxuWXQ5Q0FmTXNxKzh2ZDlPUHlEMVVuUjd3eFV0Y1NsS2JqTXkwbUdy?=
 =?utf-8?B?bktGMGxzY21KRXFweVEvdmdEVzdFdW9GZ2taZWNwT2VBZFlBTTFjT0hVL3dF?=
 =?utf-8?B?d1pGRVk2T1h5Wi9rZW8vQnZtQnp4VkpWa2FoUzRNM1RYZEQvYXpDUjJvRU9x?=
 =?utf-8?B?L2tWa0U5VnphWW9STitFUWV3WSthRjJGTlpoSUJTemRhMXFFK01ZQWtHbDdX?=
 =?utf-8?B?MG1BOWZZY2wwcDZMenlWN2h3R1V6N3daQ2t4bFZ1S2kzVGVsUDZXd00vZGpY?=
 =?utf-8?B?aUFyNWFKTHI4bENELys2elRFZzBQK1hkQzhqcWdFUW5Cb0twbVBJYTAvaXhq?=
 =?utf-8?B?Y3JHbFJsNjlPK3dZUHZ1M1h0RDZya01IcktBK0NrTEdYa1c4Z29ZdFMyVFZv?=
 =?utf-8?B?cUpkdmdzRHB0Rld5RXZ3QzFTalVZaUtJZGw4N2g2Q3lWNnZxTmhVdFU4cXJi?=
 =?utf-8?B?M2lQYlJHSC9GRDVBTWZNeG9SY2E1cU10U0hFQVRwWWs1My9CY3BaTmNsVEJu?=
 =?utf-8?B?ODZlZnY3UGxCTzFPUlhINnpodlJhRzFFdktxRTQyc2prbGFiTHR6NUJiWGZz?=
 =?utf-8?B?aEpBR2NlRWkycjJMWWxtYzBvZUVSdVZsamVGSkZrSVc3bHZ6SDNvSjQzTmhx?=
 =?utf-8?B?aFFNR0wrdnREeS9SOUIraEZVL3BFeEdwT2VCakFEdnkvM1BnVlVjQ2xFM1p6?=
 =?utf-8?B?RFovNWNOdnJXNExuMHExSk9yYVlLdi9CWWtRM1JVeUgrbExEbTAxQUlTdU9i?=
 =?utf-8?B?LzhuTFpRN1lTLzdHQnBva0hwL2NYSUNBWjFnQ0orMndvOEVrMSsrVXVCMHVG?=
 =?utf-8?B?NS9BRmdsenZDUFZWektyVFJHL0YrZUFFM0JDZS9FZDcydkYvYVVTQTRSRGMy?=
 =?utf-8?B?V0p1U1g2N2xEeCt2M0ZWeWJpeUJaSkRIUlZvbTZDZWt0VHBOdW1NQWNzTEtt?=
 =?utf-8?B?R1daZnlIdk9rSDdyUjRuZzlzNkJuZ0l4UFpwZDNJUGplY1k4TGtkTjZrMEFS?=
 =?utf-8?B?Y1JTUld3UXd0NEFpWENpUUpPczFjOWRtU0dzaXdJdkZxbDgvZGgrOHlsQytR?=
 =?utf-8?B?Vk0wYjFGUCswM2tFNVRhT3NhTVVKV0pCNHIvRnVybW5RR2FNZ2gxTm56VGFM?=
 =?utf-8?B?ZHR4dFNuODRzTWloS0J0dUwvZGlJU0tDenRwbmNDYmpJSG9hK1RSR0YxQUVY?=
 =?utf-8?B?QXpkUWVDUW44ZTFpNHJYcHl1eXRCTHlxVGREN1p1eDZPR2tTU1pwMm5JL3pR?=
 =?utf-8?B?Z0Zpc2xqWmVaZG9yVHJKSUNXOXoyeDdPYVZtQVd0YVNSVWJqcEVVL1VwNmJZ?=
 =?utf-8?B?U1JzMmFwaHhlcng2cDR3RHFNOGkvc1d5T2VSYnBPU3R5Mm92VnFqMFBsN3dj?=
 =?utf-8?B?TnpDbjBOTEdURzlXVGpFZU1pOFVOYWYrQ0N3ais4Wnd3RzVXLytjQXNXaXJ4?=
 =?utf-8?B?eDIvODRiOC9hK2RhUkRqTnJWRmNpMXVMQlhTTStGVGphSUZQQjUxS0V1a1pB?=
 =?utf-8?B?dGhCUnVQVXlSbmpwb0xJb3liMURrNDc1TzFTS0ZpelpMRzJkTk9uN2xUeTZR?=
 =?utf-8?B?ZjluWk1hQi9wYTRTSDJ5SnJsV0dXWTEzNGNjRkJoZFdLNld0MEE4YXE3Sm1j?=
 =?utf-8?B?WDlESTBKN04wQkx5TSsrWkQxR0ZuWVRYblV4WDdQTDdQSnk5bWNCTStUMnZX?=
 =?utf-8?B?SGJSYmdudHpBWWx3SFNOVnlGWCttYTZib2RxUUVFZys1VlJERTY4SWVPTFpk?=
 =?utf-8?B?RlV0Qm9SMXdrQXFmdUVDYi8yalNHRW5ZeXBCdU41OFBqQmpaMHpPVW5vVGQ4?=
 =?utf-8?B?dTJFWExBd3lYaElMYVVqd1ZhVVlGUk9mL3I1RGJnb2N0UjZxRmNiUjhqcmF2?=
 =?utf-8?B?Sjg1U0pJS2p3MkVURnIyd0ZjZmphMm9XczYvTit6WnI5TGlVbkJzTEMvRHQ4?=
 =?utf-8?B?eFJpR0FPSm9XNm9RNTVtUWt3TFp4L0pmVDM3WVk4Nk0zcWhZdkN4anVwQWpp?=
 =?utf-8?B?aUFQRjhJQ0xDaTJ3VC9pNXl1Q1RXWTJNd08ycDBFci9yQTBzckRYQW0zZW1L?=
 =?utf-8?Q?hFpZBaDYKY4YXJhFY6Vwb1uplXC1+a+ywXEM8?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d197d14b-9566-4add-4211-08df45798ca7
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:40:46.3845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJb1JvALBVl4y4SFcBii7UMcGVumPz1FtoFxKTG0yG403YPG10nadKgxqlhhRAmDMZD1f1dVrpURrEV7CH7dxnN5Z4OKSMRtbfbsE1f7uXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPFA2F60E653

> Does this leave p->wake_cpu stale when cpumask_any_and_distribute()
> already picked a dest_cpu inside span?

Yes. The stale wake_cpu matters only for a wakeup during the rebuild of
the sched domains. Outside it, select_task_rq_dl() prefers the span. The
cover letter lists the rebuild case as a known limit of this patch.

The next version still sets wake_cpu for a sleeping task whose new mask
keeps its CPU in the span, as you suggest. That narrows the window. It
does not close it: during a rebuild, find_later_rq() can still look in
another root domain. This was checked by reading.

> Can dl_task_offline_migration() still move a throttled task and its
> bandwidth into def_root_domain when dl_task_timer() fires during a
> sched domain rebuild?

Yes, thanks. Upstream makes the same move. But with this series, the
walk then counted the task on the isolated CPU, and kept it there. And
the cover letter says no bandwidth moves during the rebuild.

The next version uses the same test as migrate_task_rq_dl() and
task_woken_dl(), dl_bw_move_blocked(p). So dl_task_offline_migration()
moves no root domain bandwidth while the sched domains are rebuilt, or
before the walk counted the task. The bandwidth of the runqueue still
moves, since it follows the task. The walk counts the task on the side
of its record, and its next wakeup brings it back. The task itself may
still run on the isolated CPU until it blocks. That is the known limit
of this patch.

This was checked by reading, not reproduced.

> Should p->dl.dl_bw_cpu be read with READ_ONCE() when initializing
> recorded in dl_task_rebuild_cpu()?

Yes. The last schedule of a dying task can clear the record while the
walk holds only the pi_lock. The walk checks again under
dl_departed_lock, so the race is harmless. But the value must be read
once. The next version uses READ_ONCE(), in patch 26, where this line
comes from.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
