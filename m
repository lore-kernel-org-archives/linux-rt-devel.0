Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.100
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795112093;
	b=PC4OkECau2cRdN3wT7zfui/+ACxU+1iWHBJoYnI2gsGI8Xh+UDSaVbtBNbrlCz76xfHM
	 0YuQWWulVJABvOIlf/SQigS3S4lZ6ggLVloozOxRRHivGCP3lX3G+A8eg7nsGDEcVl8zm
	 3MvZC9J8ABZ3dMw62X43u4PidDApcrxbbUbwzpFFLzNg5BnZv7lASOrPWoSjbXtZ3EQGj
	 8XNieRvtxF0UfiE6lfU/rb1lsAuvi4tSundhc8yfSR9eRKDOngbnHNOk/LHk8pPpWNMfU
	 qydxUuzAXzOWBaHJP+aOKa9gyeBC6K7jdFfQrP/ew03e+7m3zMctFfN/RlJtW5i5SVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795112093;
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
	bh=vNnmwpdfQoofkGGCvrNbHcbzT/0OxvfGGtGe6HrDX0Y=;
	b=46xErnN4R3S8oYEf7oMjLQScfL7F/8eMtcHfPDoQEsgfD9GqJvNKhWkJFTK5mBoQWbO8
	 xS6TIkG6BzwVxOZe75kE0/dkX8pOUbtx2j1Beyzv2bmDS31y4aJPUQbYQKoyXJM5k6Of9
	 A4AcFUAD2XO897Ji+xXZGHqmei7xOFAYLq6kMf5O9z7dy/XegYG8f0JPN+C8pDBoAnlat
	 kBlwgAva5FNjU/V5ZaeCG3u7CdHS9l2uUNAp1GT9UqC8NsFs4pzEwL1aVpdYAZuuxVU4o
	 +feN0Y1CryLWWPPGYRAkpxbFFqxBl47rkTHSiXCdzOR0lFM2wZyOKPaBidHRh9quNwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="fVjs/RhR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.100
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020100.outbound.protection.outlook.com [52.101.191.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FE606A32C;
	Thu, 19 Nov 2026 18:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 991FE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=fVjs/RhR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGdH0/cyDkkCXLUlwEqYvsB8ng2AdLHbstd+0hd3qBm+ubOFiCrwsee3ICJbG1yzczCyBJFgCY9iK0S6HSJUnQ8v6IgBYVv70hG/YH18ybOtsPgzz+GKwGCgbW/1O7ynA/3+l60Xrswg24F3MsT033GLM3BBJc1taxPPLUgtQv3qGJAWmF/Y+WKfCHNA2cnulbjB+dTtywQtH1wmveuuk2GsvVis+0fgcioYSGiRR7nQPRrKYvM5GDVFcWSSKEmIcoNe1LjVVs5As2QFsvKNmTMXKb380r8iNcFUcaLQZWBYfYtPlBRFzNRy+jJCS4c5ZIiO0+r9Ro6hWX3oxFVvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNnmwpdfQoofkGGCvrNbHcbzT/0OxvfGGtGe6HrDX0Y=;
 b=ei7fJseK75vxgMSiwEMFMKd08B/v1D5jqlbpPZLmZ6K9L+T1C9AdJ1FfzcBSBTMqThLJoKlzIjgEa2uWP3j5yyCavu7dZvH3BU2cOfl33eQQMY3qF41anPNxTmfpFnf2ceNvycqI28QbTnbVUa6KcSQlwGoMDHbirOTmLgoc202A/V7NArZDCiAQlZ46WItxiUzXqwWKvSfB54YV8YgG5pR0QHNyZsPtBlB/Jh+9h5+fnjh4ea6yKyE9V88jTAjiUsWWf4qpo9XOn78j1WReDmkeGcynWz+xN+jEQsXYoStSR97L4fq9YnoduPzJxp6mMAgjHXCc07fsP/3mw7sDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNnmwpdfQoofkGGCvrNbHcbzT/0OxvfGGtGe6HrDX0Y=;
 b=fVjs/RhRlrQWNqiQjV82ZH7v1BIwMjR2KkTjnG0obXns9cFgnfu+F0bh7XqxAz35B6VOG5VZ7AYpXJpLEOIUEx7q+fBsyFpjd5a+TWRaVwuly99gNkpseJe+BmfYNr1s21BKGpiBUVLsYMIfM6rgJ5Dw7O08Q2yBUpS/QU5UpBA1Fmcf1IhsNdClfamtrGzxQig0nfMsGJh74RXA+ZZDLBo4gPY0P5RXrbXYKTikHJywwJITfnrmG5TtCv4/3rof73ewHt4Csz1dak8eAAkLh8PWkCFJXz1/u4tfipfk2KLXvRhdWXmqGfMBzeYOJ2vpiQgmHmBfUcBz/Fbc4H2RJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB9472.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:63::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 18:14:45 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 18:14:45 +0000
Message-ID: <4aa1c606-e569-4f46-8a05-f5c7be3b4365@efficios.com>
Date: Thu, 19 Nov 2026 13:14:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 10/17] sched/deadline: Fix an overflow of the
 0-lag time with long periods
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795105408.git.mathieu.desnoyers@efficios.com>
 <abbad2aa0ec392b1b0ede00b66b2d177d2b7b2df.1795105408.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-223567@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-223567@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::29) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQBPR0101MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb2bee1-669e-44f6-8be1-08df4668fd77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|4143699003|261009223027099003|10067099003|261026121527099003|261028144727099003|261026140227099003|56012099006|261022105027099003|261022075727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jk6J+ZLmQrptUn/czBhWykK8kSwp3GPwzVsfkLnTZeZRIdmi0AuEjQBlG6Vkz6kihwSmeLeZ75Zhsq+8ukqoGJKsQYrQ6bc2Hb5ALt3NoFTRgedGUUvxe/ThOhg/X1elW8w/92hxhPsbMwKv7eC+38TcSqk4IxVHjW60AAdB2ChpCJww5Si1QoBzwH9tcwCCDsG47LB/MU6CnIOF1PKW6bpQ8KW683I8yCykFRiUqNoFQgZVyQ8BaT7IfppDEn/Il9NuC1wIXB++oyMZivkoQ+10mczjd2NyKcSm2ZtaudvHNMBXQBTzk3b9tsIl50XOh6e16oyDxD41XVex59fdPFl88CZxcpn2MUfdpNt6YkTOE2YFc1cmK9cAJ94NU2wN3b92yFL2oon99COsuF5LVCjNTx1zjoVoXVRx5drcLzkkTfHHzpMwHO0th0yT/HZNkYtW6FFzNE+ZwTAARJazZZJUn+dPoFYDkUrYaN/64AX9DkvHMr5gkCG2aqmp1WhZXZxBQY2veVo7ritKcNMcnd6s6EJTNXgQZ26kpIfelRnBuSBk0BEkTi9R9DYFYM0iQfOWrLfTHLon6mUCg8MIHPLrlAdkDoQ3q1iJGZXdWhg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(261009223027099003)(10067099003)(261026121527099003)(261028144727099003)(261026140227099003)(56012099006)(261022105027099003)(261022075727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUFRWDQrZ3VKMTNWR2t4cE1aS29icCtGOElrYmVmb2FVc2hVTG84V3Q0RENP?=
 =?utf-8?B?eWNEbCs1T2FVWW9lVEFUSThsNXFOcDRSMnE2VklFVmZZT0s2c1NUTGFmRFJa?=
 =?utf-8?B?T1FzaHNRbVN6SVhoRkg5cUcwcVpCQkdrUXFBQlVwTVRWV3Z1R3JVbWJtVm45?=
 =?utf-8?B?WWp4NlBSVUgrcGhEYmYwbGpENFh3M1lvK01IdEZQcDRuODFqL0FuQVZIeTIr?=
 =?utf-8?B?bWYzUFF2K3N3eVFUdnlNZVJYcWVWTWc3cEZBSzdBaVVYSVd2cXRXRmQ1V0Ir?=
 =?utf-8?B?RVJlVWdJMGZjZFk5Nm1kS21KVDh4NVZBdVI1M0JKTytrVURsWU5qQnVHSmxN?=
 =?utf-8?B?SjZyd2VGV3hmekhPVHpuUWthOVJxUkRKRFlPQllTckRYZDVFaUIzVTk2K2pC?=
 =?utf-8?B?Vit3Q2hyTjVjQ3VQaE9md1FtcTVDRytmZENWMDJLQmpONVo2aUFXOENrc1ht?=
 =?utf-8?B?dXMrQTFBbXJkUytRWnRrN0dEcUhmMVV2S3o5L2EvakNmWWJtTlFqVTczRzhC?=
 =?utf-8?B?SU1sQnVBTWliT1ZhOXpEMFE4VGtPVzNUQ0dlREcyMlZaSXByakRsSjd0cko1?=
 =?utf-8?B?ZmF6QmRXRnJ3cklWVC94RmhWb3drTHk1Z2hEMml6WnVWU2tMdnkxMjRTUUI0?=
 =?utf-8?B?L2VYdVNmem5yTWNVR3hBUEtmelFBbk9GaVI4Tjlxam8yU1pVeFp6U3U4cURS?=
 =?utf-8?B?K215bGswQ0xCZFRzU0ZzMkhuQkxPdVVVYm44aFdaM0xGRzU2YkQ0TzhEaHZt?=
 =?utf-8?B?a0ZlaDg5UGh6TGtIY3FTWEdpRHk3bExxRXJXK051ZGpFRlUwYlhJb05VY09r?=
 =?utf-8?B?OStxWmhGUmpJbUpTOEJvOTdGKy9kUXltMEJFV2liYTZxNlY5aVArVExyak1m?=
 =?utf-8?B?NUp5QVlYbXlZdTNhVFk1aTREUFppOS9RVjJSQzVZSDYrcUt5ek5KSnEwVHQy?=
 =?utf-8?B?QkFjaGJPa28xdjZUdWNrc1RpWDJWUjhHZzBGZE1VNnNnSXdMMkpQZnhMalNn?=
 =?utf-8?B?YXVyeHM1d29xUGg3RUNudlB1ZEVKYlRRZmFZMUNtZVpQTW16MkUyWG44LzNO?=
 =?utf-8?B?aWxnT3hZcFdnTUQ5bWNHNWxlM2NHQjRXWUdCVTZTQmYxOWQybHd6NEFldloz?=
 =?utf-8?B?TlI4cTNZVkd3ZUMvK1B2RzlmNFZkNThhYkNLQ1JwbmpPc1BqYnUxVkNobEZ0?=
 =?utf-8?B?QVI4NFZnOHRZRWJSS1FYYnQ2aVMwbTQxMTlWeXVORDU3L2VNMEQybWdJV2Fk?=
 =?utf-8?B?U3dDRWJBSzFuSk00OFFRaWczOXA0dG52MHNMYWdwWk5uZjBJT2YyRWRiTGxJ?=
 =?utf-8?B?T0F1LzNoNmFyUFlxRXY1VUVkYXlLYTlycWYvdUgyLzh3b3VrZGQ4R2RxNEFJ?=
 =?utf-8?B?S2ExMnFCZ1YwZFRNdDZCaklWOGkzTDY1TGEzKzhTcWhPamVWT1BjNllOTHFr?=
 =?utf-8?B?ME45Y3ZIR0tqNmdRUFg3bThkQ0k5MjZvVUVMdnlIdzNSeFRkYUFuL21MaWQ5?=
 =?utf-8?B?RUxCUVNWNUJlMXZrY0F4NE9pMHpOVDQ0Y2x1Vkp2QVphaWJNS1VBVzJ2T2Y1?=
 =?utf-8?B?bXdEaVdzWnNCM2NGNVdNZ2pJdXhRVG5qeE4vMnM0bnRZN1M2VEhtYUNLam1O?=
 =?utf-8?B?NFdSWTdtc0ViblVNcGxDOThkS3cwSzluMEVQbW5QOTg1QndWN051NEtGS3M4?=
 =?utf-8?B?ZzZvSTIyWG44TXBLaGJGOVB1WmNPNW4rN3JIa1AyVGtCM0U3dFRtWFIvK0VL?=
 =?utf-8?B?VWRKZDBxRXRlY2pzYUZ5WVpPV2lXc3RwMU8zanl5SW1SMTZnNzcreS9QUDRx?=
 =?utf-8?B?ajcwMjhUanhYSy9yL2pZTjNtWm50OGdKdWFhU3ZjMTJaMkdYYWxjelFrRno1?=
 =?utf-8?B?eEdSMXVPRFhGVm5saHR5QlJ6TkFwemRNYnVNY3VrNzFrUVh4K1BoeEtZWVNX?=
 =?utf-8?B?Y25Ob2lxTk1aTlJiZDFUVFhzQmVpOXJMdmdkY0RWaE1uUjZETXFFWmY3THNC?=
 =?utf-8?B?K0IxNUpmTUtWdFlDYUZ5YklWNFN2eDl2ZC8vUjlUVC9iZHVnSUtvcW52NTB2?=
 =?utf-8?B?QzBRd1NOdmZyYlE3d29Na05pOTRoa1pMeGZkQTdnc1dXeWtSUVM5Vm1yMm81?=
 =?utf-8?B?SVBWeXNHSnJiOU1JMFFSdDlpZWJMNFBtYXRWU2tvNVhYYXpiTmFBK2N4ZXpE?=
 =?utf-8?B?UWs5T014b0crb3pTZ1VMSE1keDlyWHp0QzlMVkliSSs2R0lqMXNKRXhVSWo3?=
 =?utf-8?B?cnhUNmxQZm1HUWNKU0JseWc1bi9tZU1Bb1JCQllNSHdzVmdJT1NwTmN2R3pj?=
 =?utf-8?B?WVlwbFpsM2lmeFN2R0RiNmNMZkxLQUF1R3J0dFV5dFpQc0l5RVI2VHFZdHFT?=
 =?utf-8?Q?tBHzLrD+rUwUx5732l1nTakPzDebPxhe7/oze?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb2bee1-669e-44f6-8be1-08df4668fd77
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 18:14:45.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HegZXlNjfXG+RGWmr5e9QWj+dSMsuzYFqs2wVUfiUXyvC4gHRJckX36CF8cKZYeH68Mpl8fy9u0LoSg1fdT+WZZKWS8wSDg0nGH9Mr57tRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9472

> Can mul_u64_u64_div_u64() in the dl_se->runtime < 0 branch still overflow
> s64 or u64 when dl_runtime was shrunk or the overrun spans multiple
> seconds?

Yes, by reading. It needs a raised period limit and a stall of
several seconds.

The runtime goes below zero within a single update. update_curr_dl_se()
throttles the task at the first update past zero, or refills a boosted
task from its donor. So your rt_mutex case adds at most one more update.
The tick does not stop while a deadline task is queued. An overrun
therefore lasts at most about a tick. Only a stall, such as the vCPU
preemption you mention, makes it longer.

With a dl_runtime of 1024ns, the quotient exceeds 64 bits only after a
single overrun of:
- 4.4s, with sched_deadline_period_max_us at its maximum;
- 63s, with a 300s period limit;
- 4504s, with the default limit of about 4.19s.
Only then does x86-64 trap. One tick never does. The s64 wrap needs half
of each, and releases the bandwidth at once. v7.4-rc2 already wrapped
the product in all these cases, and with much shorter overruns.

> Even with the default 4s period limit, scaling a single-tick overrun of
> the old runtime by the new dl_period / dl_runtime ratio can arm
> inactive_timer for hours, locking up running_bw and total_bw.

Right about the hours: about 4.5 hours for a 4ms tick, with a 1024ns
runtime and a 4.19s period. This is the time the task needs to pay back
its overrun, at its new runtime per period. If the task stayed in the
class, replenish_dl_entity() would push its deadline as far. v7.4-rc2
arms the same timer. The timer holds only the task's own bandwidth, the
new dl_runtime / dl_period. Here, it rounds to 0.

The comment of this patch says that the overrun is short and its
quotient fits. This is too strong. The next version will cap the
quotient in this branch. Its comment will say that a stall can make
the overrun longer.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
