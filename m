Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011267;
	b=bI3TARprNPioDO3IOuAde+hQcyLf0a6ry0FBV9I/+lc/689mTrzvzMqfkymeGCHfrWtH
	 1JwhkEdDAGp9Ejp2GSbRteAAMwpPIFV/nV17hzYQEyFuPF3UsA8GGWUEUdvyNBSU2ng9p
	 Er+ZYae4f9hqN8K5HHPXaUqOy3jcHukwCEakq5iA1pqqAOxnrFX06oNh4VFB3l7sdfRh1
	 B4b6i5HNliubYY0xyNXV0j6oRHM6ZcIXdOpP8l0gV0Z7YTore65npc9Z7ZP6m0WMrewad
	 lEaWlhAymhBceQi+nDS6ZtIxRTo5ETulJBgpQQ2Ha7rif/3lQgHdOeQcrI4W7nWFYEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011267;
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
	bh=/+vVRIyW32vOghLXxbONLDwv3gTRZh4JswP73O2nzg0=;
	b=JO8rOMBZ+9QvR8ClqfADq8EHvIe9g+1JTs5R3K8I4jt/p8H7pkWYmr7qyRgaNp3ylDsa
	 wG+s9DFE4IwOAiYywsPaUa1Wcx6PdFOyskt8bDA9lEp7W5r9tTXyp0QfiLIotHPgrbrZf
	 o+mflX7k2BquLBOOzUrgDo8hpn81cHPstxadrx9cM2XLM/QjBTyYoXW8n7edWK6R36ldP
	 inNhPRW51LbdaPTFQx1E4GISEV1ve+ojMhmRvPT9EQDcH9tOCWjtOXDpdkw8s0h6bc/tU
	 eNhbS2nsr4rmph3psDpomXpRWGh58KJ2NQv1Txwe/MTZiJ0dYhSUtQy/QHCPswMTBgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=fPvDqzbl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.97
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020097.outbound.protection.outlook.com [52.101.191.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4227606A32C;
	Sat,  7 Nov 2026 00:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4227606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=fPvDqzbl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEXHE3GCwOxIVfGzNcS1U86Hcl0ssOtgSCtKblqKfnmR2k5vkkTMcjH6q6ay3l9p7/frXS0V23/yTmP/sp+HmyCn6N2o4Myoz4xkA4Se994fAqx+ImyvhTxMnJ10H9s/Z6TSnDrUsQxTMbbpzUbRos/KjvGHLFxHLMRF5D8eRVhHrvK1S4dQNfm9JFYMfJZfke27s4PrZtkkfbqo8H1dD6EJgWDR+4LgGJXYZTtbsSxLipdvma95QQzdO8u7Sy3DBOS2NCiN13lXnaRLOE5DC2YFn8/LLLuPqkPkGhwLrjRbTdRy06dIfJDldgIo9rUZDh143sqDJKTGrEtZarP0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+vVRIyW32vOghLXxbONLDwv3gTRZh4JswP73O2nzg0=;
 b=CAwh+K6J+rJOP2cxiX8bVvyNL3RjVWVxXGDtcuKYwyhexR8owjI4fLdbEBhtCPKaEvXIosKFu5A70MKjHTEv4JMIqh+m8J+tJwYdjprr2hZNPWq67NoQ6k4K+okeoS/GptQN0TdGjq89aTKVvN/nlFZv0GlSO1MDufrbCR3ONDtNhGKSg1K/V8inNXk1DS8gz3OVEUSQEFKrToK1UnYRqbX05y4KDD41ey7Huoa8Qd8x7+A92AminagSeegN2xX7oI1zVnqqtKYN25JRUjS6PHye7O87W55Z3wUJ4OX6azkL72NdMvcI/mVfu+MFfvZ6E3DE+3FIiktXlj7GbQxnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+vVRIyW32vOghLXxbONLDwv3gTRZh4JswP73O2nzg0=;
 b=fPvDqzblYbm74eCNFBxqKoBgaHO3Yu0YjxCsGqvOJlG8cFkHCveO8Ni7IPl6pt7e2OhGf7lgBq0GFnT11SzfvmLZCSzQvJoLpCDyUSgns7Pq/uyQMju4K7XlgER2pz1lG1hZRxjKVuE+QR6wzmrpROrElDdOPD0b9HSgLT5/aolCmJSWGtP402t1qEoTWYbRvFvRshZfSmM33b8ipELt4RYEoRSps+UXKSkLAHJrgi5eyzA4cnDx8hQwDQoA62a7+3EGRBIGgxhoZ1/KRr9hJi/CHBcVO504DaY9XTBj7eLPNrcn1nMz29u74KI5Gw2Cy/SnbVuHURtblNAkGJq5Gg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB6245.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:38::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 00:27:37 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 00:27:37 +0000
Message-ID: <81e4b915-0c18-49fc-b015-b543b26d1a8e@efficios.com>
Date: Fri, 6 Nov 2026 19:27:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] locking/ww_mutex/test: Time an ABBA with both owners
 running
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
 <20261106235931.1478800-6-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202413@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-202413@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::8) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQBPR0101MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: c778b9e3-5475-4955-9c65-08df3c65eca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|10067099003|56012099006|5023799004|4143699003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	rJU6ivq/JPQEVeL45WYGq3n1oQ341k9FTSv5gqdGdNfb90d9ktAr7QWKGmej/3URSc5hb/qfuoBTUZo8McGwtDvaaUB+JIi+k9xe5PMwAsHYIgqkU0xxZd16uSMKwoJ0Xfze9ReFatc4h3vF1xSLwhYzdHH0df7crWZq50r/dzNGSMYvx76JUbTlAy/GH7UpSmZRIZ8JsbdlKIZwe0eq9mDiPTY7TxY9VUQdOy69nfgBNPCwLZ1U2Qm5uqkTDXdTBUWYPP1IVz1zpAGAKbnHTX6UyeoLVH/+GG7wfl8hInyhAW8kYpcg7w9LsnbyifP//hCXZ+jwGImO87tCywyOyz9v2sQdaVgsMRMeu9E+ztkYDJOigsfx6VOVlDU0nIt/YUUAciHaqH5Q3fi8dsVDY/W9t5/LAN+gXOc7mKfH1Jm6g3PFBiSwq4PiIiftbJJXtx7d3CGBTuKEK8ajsqKpH56jzadg4LWyk21TbejYAEyxecIX3AQ/8je3flRWEhUJzIIp1wdY2KJk+w28oTO5v7e/UCTgOPnCh/e47xzuKe+a9/Gy26DXxkQjuP7nAG65rQ10tcH0RYtFAlS8uKc6wkgsgvMq/KV9KdxT9KlvBLA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004)(4143699003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFhRMEZCQ1hEOU50cUsvWDFkTWY4NjdTdnhveXZYb1FtZXFWV1F2MWo0M3pk?=
 =?utf-8?B?L0lQTHdLa0pzU3IxMkVRem1xSUFNU2RNUlBxWVY1QWVyMGt1TG5iZEdqbUQz?=
 =?utf-8?B?WG1BWjRJYkMycGl1MU5vMW1NcUx1R00zcmU3OVhiNmk0WllSdHpZZUlqWEsv?=
 =?utf-8?B?dXdIRFFydGh4MzRKbFZ2SjlXaDRvYldzUHJ6T1pncjZPQURnSVhpNXVoMkZS?=
 =?utf-8?B?UWU3OTFuSWVWOHJxcjB2RitzNFJNUURBNUpHdzFCSStPQ0FCK3RRQStQaXpR?=
 =?utf-8?B?TkE2bFU3ZjdXSnRyQUlTdEg4enpHaUlCQlRTZ3hOSUd3RTVMSkRmR0FDZklG?=
 =?utf-8?B?UU5ISjZjMUNuUEIxVExVWWFheng4ZHgxL0xCU2JFVXB4NmdyUGM5Z21ZQXd5?=
 =?utf-8?B?TlNqSXNsY0lRV29jVWxXOGFmQWlQK0dRRVFmZ0lHUENWZnR4RXF0WHFZMHJw?=
 =?utf-8?B?djZ1K3UvdHI1U0NyT1krcitHQ1g1N2hiL0VqWThVUmJkK055QnJDVjVxQVRs?=
 =?utf-8?B?dFByNjg3VHZFMFFSR05MQzJyYURVWWpCMjgzUGdRbkNtemtRQ0VheWoxYmoy?=
 =?utf-8?B?bmp5Mjk0VWhaSFBrTTdzTXBPWDVMOVZDUUNHWDJYbDNHRjFPaDJjc1dQYm5y?=
 =?utf-8?B?ZmVXWGlmSXhhWG5wUFAvd3VqQ0lJdFYybWVwcGpDVzdpdlpiMFVveHF3ZmFJ?=
 =?utf-8?B?V0Z6RE0xYnBjWUpuT2lMUkJHdEJ2ZVV2SEFGdGFldGswaHhkN3p3R1JUNzNl?=
 =?utf-8?B?RjhFbHpVekFwTHVjV3RCcWdsR2hhTnRUMVVmRlptVXNRUmYxOXNGVWgvNTE2?=
 =?utf-8?B?L2RXajdUZHpVMTZRb1NHbEVrM2JxYm9rWHVINWYvVzBCM1VLWEFoanpqWmN5?=
 =?utf-8?B?aTRWUGZkQXp1ZXJkMFUxeFRUeGNCVVA5dkFqclVla29CNGhNQ2xUY2lpSHkr?=
 =?utf-8?B?bnZvM01XQm5NWmJUTUJmVFhYSG5MUVJWbkZpRXB4OVFYQVBlZGduS2N4WnF0?=
 =?utf-8?B?M2lkK0RHWHZSU3JZRmh3cG1PaWtLQWdjbnI5QjA4WXpMUStlTlV1NzkzNXd2?=
 =?utf-8?B?aHlidndmVkgvOXpwdVRsUEJXMFhqVUZFUnAwWFNpZVBwUjN5YS9Id2hZdStK?=
 =?utf-8?B?Y3lGMVBIZk5xdmwySmY5Y3dwQ0JPb0FpM1VPSStrbTBUeTVrZStsN1duT3pC?=
 =?utf-8?B?VXl5N0Q1VzhsQktQU2llWGJlblVpcHhGSW1Lb20rc24wbmRiOHM2UVJhUFhM?=
 =?utf-8?B?ZWRXME5uUmJ1TlBPaWZvSUZYR1BUUEwwK0Q4VXdkaWU5bzBzMFBaRnlJZWJB?=
 =?utf-8?B?ekRFQWgwa1puamlLamxHamlYK2RkdEExNlhxQ01oZ0RnUkhjZ1ZXVHNibENH?=
 =?utf-8?B?eVNuQkJHVWxFaXd4aUFTUTRwQlE3c2NZeFN0bUlaOFU4RXB2ZHF6N295ZG1j?=
 =?utf-8?B?UFhYeHVJUzcxM2dzMTVDT2RnSXZ0aktWdHBtVW9WczN2K1E5TUJWVzg2SEgr?=
 =?utf-8?B?SW9La1lRdGxlOTJUTXlpMkR3d3d3QmV4TTErV3NPQ0o2S0lpckpIby9mRW5h?=
 =?utf-8?B?ekViWmJUZ2dkRzJQcTEvL0YvZG04dE9qb0IxZ0tzNFQ1Qkx5djcwTWxTU3ov?=
 =?utf-8?B?ZjZyVnFzTWtiUjhtTXhSVlo0RXlPZUdBSnZtOXY5K05nYzBkeDRLQzNiUUpG?=
 =?utf-8?B?K21DcmUvZWlUK3BJWC9UTFc2Nkt6MFdKekFNa2pYWXRPN0piVEczaHBMN0xB?=
 =?utf-8?B?aDVGNGpUQ25iaGhuR29QaXcyMlFQZlZsaFFpTytrZ2ZPcjdmVEtnMDVWZDRC?=
 =?utf-8?B?SXRLYjBvL2F0OUkwQkxNdlZMVzJuY09QcXYxbmdZMVVXemZ3cExwdHFwYUoz?=
 =?utf-8?B?Uk9pL21Kb0ZEak1pQU03SUFLa0J2Q21Kd2tXRnZFa2U4cEtkaHIrbGhQWDVU?=
 =?utf-8?B?c0RYMURyUU0vZlVSMEh0K05WSXJVTGh6bDBna3lvaTkxMnNxd01nSEswSmlt?=
 =?utf-8?B?SHZhcU5ocUcrUmg2MFBvZ0hLTHpxS3NHUTd4MUloTm1DLzNKNTN4WlJ6Skla?=
 =?utf-8?B?M0N1T1JGUjJyZFg0MmJPQ3A4RXZrUndyRkt5NGdJY2FIbjhCdzJ5UURySHlv?=
 =?utf-8?B?L21jRGMxRENXWHhOMGtvRFRON01obDExNUVSVW9OS1JRNSs0YmNWL1NFaXVy?=
 =?utf-8?B?dThxcS84NUFYRDBxNERpbFZxNjFNVFEycG5QaitHTHRVTHBoVzF5TkhjaitC?=
 =?utf-8?B?S2ZKRzljM3N6K1V5RmhPcU42UXYxZ3pWTzJvTXd2cTQ0aTBhczNvV3hmNXVu?=
 =?utf-8?B?YTNpZ2V1dGp6Szg1M21WLzloYXo2MGwrV3FMd2ZpUzUvK0ZLdWVkUTNTb2FN?=
 =?utf-8?Q?RJhBWYCwopaafH/s=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c778b9e3-5475-4955-9c65-08df3c65eca1
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 00:27:37.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sV/F2y7e9Rzxg0D1XnDJzapiFXy/BxQZusxdnW6Q1Wez8cT+cNvXm/6QF1iGuDD7NKSvgicBqnOR5DpeZH6ZAu7VsMXWq7iLlNGorNL/Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6245

On 2026-11-06 19:11, sashiko-bot@kernel.org wrote:
> Can abba_spin_young() obtain a smaller ctx.stamp than abba_spin_old() on
> weakly-ordered architectures?
[...]
> Using atomic_set_release() and atomic_read_acquire() on s->stage would
> order the stamp allocations.

Right. ww_acquire_init() takes the stamp with a relaxed increment, and
nothing orders it before the relaxed store of stage 1: on a
weakly-ordered CPU the younger thread can take the older stamp, wound
the other one, and the test fails with -EDEADLK where nothing is wrong.
x86 does not reorder them. v2 makes each stage store a release and the
poll an acquire.

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
