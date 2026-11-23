Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442588;
	b=jafGltSgLg/qUsVvv50IYAV5LHVKeTodKOgkxNygDcXze8Kvf+0yQ/FLQPbChVrURR0k
	 6peDksutUALvac3o5QoKlraqz2OQwyHPT39HKGrIoyb7hO6TnM88y/XxCEuso/YqeT/c0
	 MH+k65l9KdIiDUboxKoVOQZk/ObIG7ccBNSwNLhGl/uwv8ngZvQ3FsVZQCXlvrrEFYtg6
	 ETmCdjr4MV1IzTmnToLCYXO8E1DK22I7EILx1jv8AEqhyIYr7VsF/8tWEw43R/W6QRwtO
	 HzayueqlYZmXeG9/+cZXnqzsLe/8PmFdmiAN57sIA+VAZzObCwS3t/Kaq+KxA0hk9sQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442588;
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
	bh=KPGtUeOULp8ZEREi1IkMsX0CnnzktJGwQV7F58xTWb4=;
	b=M5rqvfeloM1nXyH2b20qiVjUX2ox5bQcYa93EH7dwfDco5GaTV8ZcCOEoO/dEdzCyCoz
	 F4cVnoIVZEIEhWvu3PuSwOPTfMbEIUH7/Gh0C0cCOzqrHLINSV2Am6hPNU1k9OHKCDIZY
	 KQjRcXYmcy12ImXGeISehFP+LOBG8PDUjxgYiZWyp3enljMk2U7aPClNq9Aq2rrO5t9xF
	 HID31E5fq2qlw94d+u2FDHI+NBpQkAHSMzdnTC1FdlaZx91sLMrhdb32dXFpH38f7BFJh
	 C9AAa/IpjxYuE8CEQ2aN1MSFaZHv57sHAlnmTDVGTWHMvrZsffBcicI+xIEl6AMq6vQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=OwNxMr4I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.125
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020125.outbound.protection.outlook.com [52.101.191.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39EA606A31F;
	Mon, 23 Nov 2026 14:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A39EA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=OwNxMr4I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tszm6q/JrtEE/zyEwsFLjZp8TQthtsYvPDLDmyipPhyo2W7c6DZ4REPKazRNiwl8YYyb+LtkRDfFDiVwkyEXmfJekEBx9jAI4xADHxEUI72mVF53quAI9UOWOaPIf+UVrB2LWzcbW0Q+AXI+OPQ6kFPlfoBlSPEikOLzhU5UMjvfhRvdk2pR4IrJmTjO2XywUJfmUjJBMbpAnwQ0EmPvtXs7MQ7k32aBt7wd1Vq6V/xg02ZM75pIFpJ87IH8I671Uhh0o18ELEJ2xrq9DYxY2RKuXLwei4IMGpXe65Ul3+3lXuQ15xyWPJgw7dtqO5TGqqmKiIrHiIxT4ZcrAWLeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPGtUeOULp8ZEREi1IkMsX0CnnzktJGwQV7F58xTWb4=;
 b=Yjiaa8G88hRLLQhez3fV7SLZjqMnAuKM3rkxYiLjTLewFsdMM/ZsnrpNuv5iEO+6y5YI85jvdf4N2O3T7shBr9PeOqbkpPKiz+NQ71+zIAU7wqyD1wScok38Be7FWxap+ppHfmoqYFHLg8bgQTYTdtuuIY5P/Xgj/ERrZ1VfXeyjOXbGNI2zfExYxx9abmyR49Dz3kbyBDMXN7eENzIpqxnMH/XsuSGVZdfDdQlcURmSv21uVgsBrg1OF08oi3N+KPz5zbnMQGcV5Bezsq+jvk4qJft/uLZb3O7dfq6YysgigmzYR5EBm2E7QS+Gw3UX2zEWy92tpNnfoqM/2zipKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPGtUeOULp8ZEREi1IkMsX0CnnzktJGwQV7F58xTWb4=;
 b=OwNxMr4IB0Od5zy01db44yG4FuzR3Ityhl7lldccdPzunYw3E5wXjkXMY0plF7Jbg614ITePnBZ8lX7wlVt3VS9EpFkavmJRoRb/gkzbfu5LWMKsVC6J2lSCdU9ssZ5XL99wP5J+NZyY9m6V125qS08R6CeNQsJPEnuAA8P4hBeyqMl7x4wchfv35LRl4SYLHgBeN+w/ayA0ONg8DpRX6zrsY+RrYPlDeh6fQj92/Bz5HATblPOISmAbksr8ZPS3pvEFS3zKOg2uVlcJ1/Fs9nCbs0eN3VXGv2hE6CznMMYyFbzhjB8RWnJdZ3wy3OUDdgExfLjqSqDC214tR/NwPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB9585.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 14:03:04 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 14:03:04 +0000
Message-ID: <811dd17c-6f92-4efd-ab97-6b65e468c600@efficios.com>
Date: Mon, 23 Nov 2026 09:03:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 40/40] selftests/sched: Share the helpers of the
 deadline tests
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <62c694b97d7fdffabae640eb6dee797eceb3701c.1795207233.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226150@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226150@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0338.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::6) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: d43ae482-da10-42a6-c1d7-08df496a7df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261026121527099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/Gp+VnzTXrtGRVcDhJ3kXCWsMP9WPryhGbhPpeVkxO9N09qcw04jQWF25KS/sw/R5bLgSC+36P9biNGXpA77sakCDfZig/P1A0SfR2PyQWd5zVcnfrCAD4R3x+0MxqIaoooEf6NTLozrBkIV4oBY1ByJ4Dr03QVPbgYDnvb9C2718VI2+yeB6ItDKbHIv8w3GFGB4n/dsvSEHTNZ9dLZ/aBCNimPr/kwVKQWBhIQ0Bc6WEfQndRDJiibUDuge9dZepcIXuRx3DBOew+BALqHkA+lcZvtD748INVva+7pRPltCilC77Q5694XkVZHPOq90IrQTXfxCWfY/vD/qqHBjbQdpSs1dLvtZQ5pca1T1XBBIlP2aXUX3l74T4JI63N2BCrXQkhTYWDqaECM+llVp+JKFMd5G8LZNmf5k84lhFPBMx5ol5o0MksBUtf1q5MLF3aWG1hacHGFIdu2g0gN1w0djze8qp3r7mO5IEZPQv1hHEvpfYl6rJfrLL0T9BS5Qw67hCuF7953fOjLXCoMvdFSlCx54ugZ3dLDQxZ2uTR6zHr7M75YPBF22cyTDTgSHZcw4fK8+i3YqprVn8ul8FpMfAMwDvMvRqQFLurLS80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261026121527099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wmt1dStuM2xhckxvSmZPWnJBVWt2TDl0NXhvZERDK0NHa0hFMzY2Z0d6SFc1?=
 =?utf-8?B?QVp1MkFOOEdjWDFXWFdOQWNIbTArUEJnc0xpMnJoUEFNNjR1RlhSeklrVzlU?=
 =?utf-8?B?L2xDZGE1R3JENUJENEZCeHZmdzV4emYxUGxwbm5uNC9vMHdyM3p1L0xFVENU?=
 =?utf-8?B?Q1pncmtQbGdoQ2tBbXJyNVFQU05OZklWYWIzcmZTUHBaeEt3b1R4OHVpY2Zq?=
 =?utf-8?B?WDU3cFNhK0VQUTBLQStqTjRHNUhwdHlzRWNNNlRJM0QwVHllcXVuQ0ppSGpx?=
 =?utf-8?B?WWpjUERGaDU0Z2JyaUc0MlFSOTdNeUpwcDI0Mm9aSWgzWEgwcDNvQUQxNXYz?=
 =?utf-8?B?RWJPOUtxWlFFTmNmTjRXT3ROWTdVdEdQRzVKWDE1L0xmUkVCVjdEZk80Mlg3?=
 =?utf-8?B?VUZTK3g1VXMxYVRSTWhUU0F0cGlpSUJzTitqUjBlMDZsQ09XYWxoa1Z4cXpW?=
 =?utf-8?B?L0RjNG9FaFNvUnpuWU1DV1U2TFhna1pxOHRTVlRQN3hQOWRETytrVnNIdCsv?=
 =?utf-8?B?KzN2TmxlTzExY2R6WXlUd096Nkd4cTNoTnc0bmRwTGhUNU1HN01nNnZuNWxN?=
 =?utf-8?B?a3JhbTRmWEM5Mm8ra21KZzZ3dExZbFZqWmc3b3Q5TW0xYnJlR25mdWRNb0xp?=
 =?utf-8?B?V3FLQTZpU2dsUVZUQ3Q2VkxGTjZWTjZTRml6R1g3bEhsejZhcERyRE1HN0pM?=
 =?utf-8?B?UVdQcW4xc2ZieUU4NnNGU1pKNmp3b3dOTWkrS1hRdERHSVFmSU9mRDZkTlFa?=
 =?utf-8?B?SjlaZGdFQkNOS1RiOGNIUDBva2dOaERDU25lbXkwQWpjeXYvdkthQ0Q5eVBH?=
 =?utf-8?B?TEVSQzRZU3BLemFYcTFtTFZLVmVHNFhrRWZ3TWo3Zk5MNS9tMndpTUhRRHBO?=
 =?utf-8?B?d09iVEFQWVo5SnBnMnhjUG1GUkJaQTVYYzYzU1dqNTRYQ1pBSVIyVHU5cGNs?=
 =?utf-8?B?MFBaNiszaW9jc1AwMTRyQm55Qkt2NldheEFIaVNBYWYxaDVkbVZJNDB4ZVRk?=
 =?utf-8?B?eTlFajlPWmhJd3R3d096NWpDL3JvbHAxQXo2dzU2NitvZmFuaGxMSHQrTXM3?=
 =?utf-8?B?WDhwZWpXbnBRTlhDRTRWYWk2NUZaTlNSak9sNVlXWnAzaUNPdTZIQlMrblhr?=
 =?utf-8?B?azl4VEZGSXBRK3RiMFMrcURhd1N4a01IMkFMd0E5a2xWYXM5QmI2ODFaeHNu?=
 =?utf-8?B?Tis4WHBSTTNGN0RsMDdoZEVHVkRvbjkwOGJUNTZ5U1BHWGlDclBIK2hUU2hq?=
 =?utf-8?B?SW02bFRnblRQR3RMKytIanVTYzlCQTh4ZFdlQU1zV3lHaVZaanREUFJPVnZx?=
 =?utf-8?B?bTV6eWU5QzNrclVseGNkUldJZ3dEblZtNXZrOTViMVZaZThJekRGT3JkUHZ1?=
 =?utf-8?B?a2NFU3RNbk9pZERVdTdZbGZmQmdVenpDL08rVzR6ek1UR0Nsd1JqbE0yK3V5?=
 =?utf-8?B?UjNBd28vdzlDbGpucW5zTGRNZlA1K3hVQjY3Z0R0b3FGdm50QzFBaDlQZk9u?=
 =?utf-8?B?blg0OU83UVlFTml4NlFmZHVIWDlWcnJzaW42STNnZnVCTHBVdjNROXJKRnBD?=
 =?utf-8?B?T3pnVkJnNUZ0dHdTeEdBb25CWkdYNERYWW5iMCs3Y1FLdFExZnFwR0tHTm9o?=
 =?utf-8?B?R0VPWXF3NzRUL0JiWEV2SFVQNHJQaUEwZkRpcjF2SGRVdDNGeWpscDI5S1Rv?=
 =?utf-8?B?aWN5cWNrUnpxeFI4MXErbXF1NFZUbXpXYzFwcjZ4VTcrcWxraVp1Z3ByQ1ow?=
 =?utf-8?B?Um8walg2cXZPK2hGSmRiY3RiNW9pWUlqc2xGK1F3VEFpREF6QUViWnV4VERC?=
 =?utf-8?B?Nks0bzNNNjZpNVN2bzVINmpkK245azBLT1JBWFBpSXZKc1hHaG9YWHBBSTl0?=
 =?utf-8?B?emMxRFBSOGpvcW9qdE50VkRmOHE5N1B1SWI3K0Q5cFVCeUE5cERyZWZvR2tF?=
 =?utf-8?B?L0tTNVRLWmtMdDhFNjFHQXo0dTh6UVhoZE10OXJKa0lYQzc1a3ZVRWpRZXNU?=
 =?utf-8?B?aG4yMXlrVkpKeitraU16TXpsVXo5b0M0Qm14SWJzZmdsVitFbFNYODU2K0ZW?=
 =?utf-8?B?YWNhZ0FSRDdZL3lLQThIelJwVnhKNnZ3WGxNNTBXNUg1TTJKaTExTk84UGhI?=
 =?utf-8?B?NmlQc1oxTnhUSExCOVdYMzQ3ZTY5WC9qOTdxV0VBZm1TVWNuUUxjRng1U0Zz?=
 =?utf-8?B?YyswN0JtZEJIVnhoZXNLaXBjMWMzNGY0OURXaUVGOGo1L3U5YnNwTS8yeGk3?=
 =?utf-8?B?cFlPYzliU0djUjNGR0hJekdWenk2SDNEYXE4OE5tN0FZemJ4TGVORm9NRVNt?=
 =?utf-8?B?TXJxSk5UZFYzdWNvNlhCV1A5RHJjRUZkVXRwQnVZZyt4aTIyR3BPYVZ0aE1p?=
 =?utf-8?Q?cj5vJccwgTVI36LQFeB3Cp2ANxFym98Gr8zUr?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43ae482-da10-42a6-c1d7-08df496a7df7
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:03:03.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A+i/LqfOqfvwzzZmOkqBvKovYj2vPyorrVxYaapO5YjgI7i2Y22vcOdzacZum9ShR8RYdqaZsJc7tFWE4NvtgJCyR31YCvK1jC/DeOy7eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9585

> Does this pattern rule ever take effect?

No. v11 will add the header to LOCAL_HDRS instead.

> This isn't a bug, but removing now_ns() leaves its comment attached to
> reap().  Also, cpu_time_ns() in this file is identical to thread_time_ns()
> in deadline_util.h and could be replaced by it.

Yes. v11 will remove the comment and use thread_time_ns().

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
