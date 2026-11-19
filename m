Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795095547;
	b=O6O+Khf76MHYgOdbX6blKaiqersvu9kptRRIEenYyK+n8Cg/RQl7CGobMn989cGqUkwo
	 f0DShly9ZjNIGjfYtD191h42CZbW63RcT2WMPj9k9Z2R1xV14Yb5YQtudfCemIO3KgNvJ
	 Znmvj1Ez5OaCLVsqh2/sZasmfDz6fuCELoEu8ffgoY4vCGCM/yT/7KyCJBC8xdsW0l0Qb
	 iiz5cgNwIn8NnAc9DStXZSyAZJ06sSrugs0vMquIcqLLREN9sujBfBlFKIy5S0SM1XrTY
	 hhFkmQ6El+iVju3aqnahbI/2CjQ1vIZcOSTBtJWFWzGNZ8nGyzj3V0q89yP0fTPEbHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095547;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=VNwTd/pM7z/v1m3ZaAtqdYUtIQwpoZvIWY5vc68d/lI=;
	b=e6CGIkHgZrpD4lenm25xiXg4GJgiSef1+y7ihDHoMpLFcyfWTeFiRvHXbsoE7lrDqRxJ
	 QEY9wEabHXQM+8yxnUP/7L5aDC6GK/ixqsfTpQSlz3C8PaXdwFpbGCM+XCpwhh/KafGgH
	 vnWvYmijFoBCld46s7kAF77mDuQX7l9f4/UU+7/8cwGar6hDQcwA/re8hfNVQQkd2xLkd
	 BiY/qjPnIFxJpntdH9j8XopXJl1EC9UwdMn9XiPxLhlpiC93Z4X2BNfjPLmt4ACv18CZ+
	 wyciQx0jspfRUZLkVJS+Ax6EXMMl+t+1dzsTjBz4GCppI/a8C+6sKejs49NfrS/P5fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PHZ1jIWV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.76
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020076.outbound.protection.outlook.com [52.101.189.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE119606A320;
	Thu, 19 Nov 2026 13:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE119606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PHZ1jIWV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYvp9c1B/iLgbHNPhZOInsHKuvVtS2i92wbMUs+NKZcgUvwBY6n3LHQONJnlBuHGHjyQ9TaIyYa/0Sr1TbHtskzBHkExyDe7IJ7E2PvktWBGYpTkjtjmlBsUTF341ly47Dc+GXJMNiaV29SkJPaPRFw62uCUjaadpejLH54pHI+SCugUvN7biqAJx1c04kSWim4rFW2ErRpQvS7YW+8FqjMTBuH4SMJFcqxl/uKGKwHXBUMwqdec8e6lv9avCGSgp8PNtcCIKxoJGy8xkstbgV0X1paZlsLeIubMEKDVw2dsudlAI0IHtro2K6wRtavMiRnRf3mdOwqePXFg8G5mQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNwTd/pM7z/v1m3ZaAtqdYUtIQwpoZvIWY5vc68d/lI=;
 b=Mkwtxa0MCOOcS5NBa14xTumv9iDU1ZRqVPaZVlB9nto/16mqSN1mi24flNXGLu9NkMnhZHUJStgi2Y5lUyPQ12uUyWtZI3ao7spXoNKCeO3a7/g0xqOPlal0lV/IVlSA0NJBC2gCsv27yI50rgCSdztSlrFhFlTSugK9vwRFBhuHUzCyUVc8eyCLDm1zQKa1rGOxQZPTey82P+kGiV2BfPb621QS3eKD3LTrKDOz2vDYgqZz1kpxZVxSHfWnjI38mwNCTmjYf8XjT+xHRw/mESI5fWLNT65XbdncgS8IUn7VMN96kfpHHQzFw/NhVB2sGyBOKtedKATEXtKhqrG1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNwTd/pM7z/v1m3ZaAtqdYUtIQwpoZvIWY5vc68d/lI=;
 b=PHZ1jIWV9CiWNbDSgdDknSWflOxjBXlUWExiBBDJIXoInT/tunvkcCAIPH+ga9tdUOu2T/dbw1FdNt8wXg6UbkCB7m6Ivjw/QaQiDk1JF2FmVQUF1qQ8tcCJOabj0co1LzN9YumFZ1adSbkdfTsRcy7HYUT393AZoDno8i5zSH4u/Zfrl2kcN2WFJC+GQqMExkCYlv0wj4mzufAWJfpM6VkE1BDdVJcCqB3tnF2qHfnWf+44hpofhe8bnijF+5g8pVlUNbI8U0phGTbn+UwOneYXvY0OSUGWRgDmwm28HLvdyAcZ++bWtsXnyI3nT6Ku+2MZainuANd7j9kgtI/HzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB5329.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:61::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 13:39:03 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 13:39:02 +0000
Message-ID: <08263cdc-02fd-48ba-9b8f-b2c7fa41fbf2@efficios.com>
Date: Thu, 19 Nov 2026 08:39:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] sched/deadline: Reset the deadline and the
 runtime with the parameters
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795037078.git.mathieu.desnoyers@efficios.com>
 <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795037078.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-222024@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-222024@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::9) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ab50ee-02aa-4c94-849d-08df4642795c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Gsaa4v4wW3LbuD7DE+Xbpyjd/fFTqaPPLDoZWHef9rPHuWvmiHuD5Pa3b6FZiydo059+d7mtgx3bBNMMik3mCjsZctfWh7VOCd7GMpi108Jsk91fYMd/88rC5VDordiWBT2zg/J6wlmgmk2jgL7MtKYcRjG01K/VJs3ZzMdsxI4gPGQL5XucS2G0fJogX/xUgHrcpcVIlH3tPcWeRED/4/mpuZYcP3ZFDu7ZrPVuqgWULfrO0pqJf3Mtfd77UsDZzfJMWnVd93w4QTiYdZEhZ0D+S3gqE2VPQMsKPOOcQ1AMI2m0p6X0OSE9WTdB0BArSaJskYSzjYW8mdn/h6qrLXgti63DQj5sZCmclBoPztp117BCyao8icYXsCYdJr3hL7Ly3FIqvTwRFIPmW5g0Jre/TZqV6w7s+LzY3uhneXQc3lU3EamKD3ZVaa/uTdIe93N8r4Uczf7SOiVA+FnDdKCLXOg7bqQm8JGta00Eeu3DrmgPiEGsLVe7yMrlaZXWmgoR/ydkSUQrBGysMyEA95YZy4I12ilbrD3W6nTdQgZl8ijzMhFBwNmZJnMfCWJKRizQLKC/ogFGmCq2C+9Wb9nH9BC3gdrAhAy+wYMenpM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2hpTFBKOXVoSUdUei9LQzNhMXVpZnNOejBNc0xSR0U0NDhOdjRxUGYvMHh5?=
 =?utf-8?B?d2VHREVWV2dDK3p4eXdRajZxMzZGKytSSTlXdXJFSDVBQ0RqY0J6ZmFidHJ1?=
 =?utf-8?B?QXZRSVhaQ283dHdxcWdmOXVxcGo0eG9tNnNGcXJSQXpJc2duQnFOMmN4TkpS?=
 =?utf-8?B?ZUM1QnhkdDliQWt5Z0dsd25FWHM0eW05SFJBM0NuYXJ6cHprREdxRnZMVG1K?=
 =?utf-8?B?RGtmc0xWVGNDZFQwbWJudXlZeEN3RTFkMjlFYXE3dDVBcUpRWnhLVU1ENjFD?=
 =?utf-8?B?Q1ZYaUNaVC9POUlpZ09IZHAvK0FPQVFCTFVsNW1oZDVSREZxbm9HazhMclFu?=
 =?utf-8?B?a1gxZWFUSTJjd2tzK0RiRmdCc2Y0UGNuVlBJTjErQmNXcUVBVnNMc1kwYTRs?=
 =?utf-8?B?TkdraXMyOGJnK0gzRnk2ZzZpRmdmUmhQTTE5c1VTUmFVdkxBZlJycFhvOUJV?=
 =?utf-8?B?UzNZa1NMMi9kVEF3L1VCajJyZ0tvZHRTYW9na0xua3VLWEREVy90bTNyOWVW?=
 =?utf-8?B?MElBbk1vNVdiNERJUHNnQWIwNlJxQU1Pb09UMUlMbkZqY0RpSTN2WU16R05D?=
 =?utf-8?B?TjdjZkJucDdCRzNBNmp1V09OYTVreVRWTmdoVzloOEVSU2V5Z3hMSTBGK2RC?=
 =?utf-8?B?bWIzTHhXdW53NGxiRloyWEJSaDdyNVNNeFJQcm1jZmsrbDFNTndpY0dUT1B6?=
 =?utf-8?B?NjFJUDV0QTFNVlFNSzQ4UFY2VUFiaHdkdEVEM1B0Y25HNjFUWG1DdmQ0ZGIz?=
 =?utf-8?B?WElyWDNFWVIwdDhUdzRpbi8yZ2hIUXlyQytNT0dRclNlT21OVmpRWDJSYmpk?=
 =?utf-8?B?RmQwUmQwVWdkL3VGejdvaisrZG1lbk5WVWgvM3ZibWVQellxWithcHc4amRE?=
 =?utf-8?B?WFJ3QUpDTGwyV0lZSFRoZXpvbEgybFl3UythRTRocXB2Mk1NanBXYlFHUFdM?=
 =?utf-8?B?YTJ2Q09Pb0thd0hkMXpqVHNGdlRMZFpicENyQnVwSkNPWW1USWxEL2pTYnpl?=
 =?utf-8?B?bjc0ZVlxejk5TGVQbGw0a3NYR0lVTmQvdmJhOFlmcFNDV1h6bVVLQmgzRVB5?=
 =?utf-8?B?OGRkN0hqUG5HSG9MUTJiSzltbkovMEdYellBN0lwQVp4US9wNnIyTnV2bzNB?=
 =?utf-8?B?NzdJRW0rbFNNT2UrNnNJVmR1cGViTjNWcEdQS3ZCb0xrZ0Fsb1EvZkNXcHU5?=
 =?utf-8?B?RkVYVEZkbUFzcS82T3NxM0wyc3BkWkYvYStiNnlYMy9qOS82N0JHbHFpVkFl?=
 =?utf-8?B?RURaOFpGcEZVbnNPY00wejdRTnU2Q2s1bU1rOHB2RkIxeUU4ZmFtdTJSRjU5?=
 =?utf-8?B?VDI0MjVycGN2R3ZTcjhhMDkzdWZLYTd3UU5heE1ha1ZnNkpoc21XdEhiQU14?=
 =?utf-8?B?b2FnbUhKdUt2ZFRQeVZvcWRDRGFjVXEwbVZqTkUyL05tL2l1ZE1DN0VwL2Jl?=
 =?utf-8?B?TER5eGtnbVREcE5JUjlpbVlydCtCak9WMDhjOWpjdVdhQm9aZExQa2QydlND?=
 =?utf-8?B?cHJrNmxMK2JnbEZhaVBXNlI3aytQUllQUUcwNlplYzZkRVVZM1B1OW1IYUtt?=
 =?utf-8?B?OUxRaGVsdmFNNVg5K2V1YVYzVnR5TWlIMndkNnZIZ2VQcmJnSGFpV3VmOWF3?=
 =?utf-8?B?UWg3UTlubU1adjhZNklBS0M1WWUrVndpVUdjNTVRTnFNR3g5c05jNUV0ZTVJ?=
 =?utf-8?B?czQ2M2tJcEtIZTdJT3ovNHFDWU4wV2Q3dEh1UGRqUEpiZDRkeHlVMW90NEJM?=
 =?utf-8?B?TmM1ZG5ucVovMGdlMGxPeDFCcDF3ZWhqbmhjbERqNTFVRzEvRlpxc3k4YnJO?=
 =?utf-8?B?NytMTWlXbEdDdTVrOEJtK2lYY0huUHZ4RUJON29Ib1FaZDdMSVR6RWI3Zlcw?=
 =?utf-8?B?cjh1VThadXNUZkZ5cFVHUGc1YXhid0p0U08wUkdXL04zaFIwY3R6OWtzdlh5?=
 =?utf-8?B?R3Uxc2U5M3kxUWhwMjM1SGF6QW80MjdSTnhUZHd5cFhZOElKdGhrWFV6Vi8x?=
 =?utf-8?B?cFhQRmhTekhSVTFSUk9OY0hCSjIrTHozbWhzcEJqdmdQM1pnZ3l0TjVuQWFK?=
 =?utf-8?B?amhJOFQ2L1VjK2wrMnNNaytJa0FUWWFlYkxNS3JJeEVFajN4a0NBb01oVWJa?=
 =?utf-8?B?OFFCU21UYmJaQ3J4Mm54a2trU2YxVTQrMUxURXdmZC9peFlOdUpWSG02MEZM?=
 =?utf-8?B?dFlQd2pRUGp4RCsvWXVnSHB2Y3QxSDJ5ZWF5MmNodVZFaTFoU2RMVEhaWEQ4?=
 =?utf-8?B?U2ZmdlEvcTl3MjFVREF6OWg3ZSs3TUFvTnB4NzlhYzBBcUsvZ3QrWHRBbi9Q?=
 =?utf-8?B?T0ZHd285N1BNQTljamRGZ3B1eDhSYWZCcnhZK0RnMHd6aUZpdXk2ci9PSTg4?=
 =?utf-8?Q?6z6zirrIvDllyqvS+4PUkipXhvRu3Jj0ENFJv?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ab50ee-02aa-4c94-849d-08df4642795c
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:39:02.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oggqEp//KNNkxD76lizndkw0k5pbcoZ/OnYWzIqgHED8/WX6Afuf5+PNgPNE1ishsJENVz8SDAC5d379G/pXVO6zwB7fGr2+AgwyCgJjiS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5329

> Can a task still retain the donor's runtime and deadline after a PI deboost
> when p->dl.dl_runtime is non-zero?

> Does zeroing dl_se->deadline, dl_se->runtime, and dl_se->dl_throttled here
> without canceling dl_se->dl_timer leave a stale replenishment timer queued
> from the old period?

These are the two points of v1. My answer there still holds [1]. The
second series handles both:
- "sched/deadline: Reset the donor's runtime at a deboost in the class"
  and "sched/deadline: Count the bandwidth a boosted task is given", for
  the first one.
- "sched/deadline: Cancel the replenishment timer with the parameters",
  for the second one.

[1] https://lore.kernel.org/all/877b1999-a01b-4bfd-8986-c41b059ea1b3@efficios.com/

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
