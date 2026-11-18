Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.95
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795036130;
	b=jgrihAEKiZOs17RkwO5zIlJp8bve0MoNRORb//FryJCu2aQiELr7xijiXYthNCw7Q13D
	 WH/xXGjB4W2X1MpuiVi1iozDjK7qz28F2npZ97r0GMj4i+uBstKX4tDLoZKpQT96fA5pg
	 BtKRwF+5DzhO4RHhHBV1CwK/ioVb1yyY8u4HDDi/3vGcRWzD0tCWySyuYTfMWTfqfpmOP
	 oVseim4O1yvhyEFpQmp14yPyzzFh7bIyOd1/IqSmT9IRstzuGwYdzpPqW53OiprbXKqSZ
	 4bX+jBa5D8M+Ip8HAqXmnA4J9Kh4HBPNHpkWQbKmb/FiKZh6G1RfKMTYTK+3sZxG9/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036130;
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
	bh=j68X2hcjcmVDecUEchRlIGSySRKyzUcJSvJg5E3IuIs=;
	b=Pvv2ms+c8fXsqpz2BB8Zw+It10lHE+fP5+Mt2/nRHL1YDP1PCPWqqqgD7F9hddVn1/nT
	 OurbK46XkHBb++njrNU/9F9t93HPqlOaAtX9qcMYqnQzZkvdCZ/LluaNl6EH3vJzUriLx
	 FmKJFlXwr16RvYdc5zQZcNcG7/uQqorvW9Mv2EOEhfTNhxv69TFWb30fLnKSF+lnlr8ui
	 YwtY9ERDMEvsK/qpad3CBy4NjoXq5H03QIkd6veg7NtZ4XQ5TJfbE9dtS3bl5ogFdPWmB
	 5hUS4yRbgptYKTiKfDMOsvibXjtCvIMNXMz9olSQhNyT076ac2VLbyU5zJ1q2YMxUrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=YPWlK0ms;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.95
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020095.outbound.protection.outlook.com [52.101.189.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FACF606A31C;
	Wed, 18 Nov 2026 21:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FACF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=YPWlK0ms
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmuXYOrBek6Ls1jeufSTnmMfcxRuw6tyygQP6lDSnv6Fd5RQuOs69xg+Dwxj2w44sGB4kMQm7lUJVWjjVWC5Gk6QydVtoHVsY89Ra7VKA2sMOKRwFTkiRQjUsnS+miInzvigbhVthxyTZ8TkZJ0gFcrZMPKsJs3+yirQsLRNdvEj7ukmj0gzRjMBLvihM92LZI0GrDo3SpHCeGS0bAP2dt1Lwq7AYCDsbecLhQUPG08yIBkjVaH43QiLI5LKRZrP3JF1+9yfN5J2pNB6L+c+6GeWB1fMsuOHYkdx/ZsF5N7n12epP95WXFBhkjy1a1YKHPIzM4b783Pq/mO9/wdOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j68X2hcjcmVDecUEchRlIGSySRKyzUcJSvJg5E3IuIs=;
 b=O7guZb7iymJNkykfJtzDzoOIWB97PbCeWS7ppaDujstSKaWfapNSHvC7i8jG1jAaRoOJjpx4z2LZtdssrqN427Pxc/KO4X2iO9Zmd6D7AwNiAHZmMTzyHjP9bByQyi0l+jzCYpBeKYPSp39zFYrway+xAVPMYllwApUzQNqovw7t3xEeF3taHHnj4IwEGtz0w5I/JX1VJTJ8aNGs222kkz9UqIgxJlM9jv2HE16PrU/75c83MT6LuaRZCOlMh3WI72G8beKTu6txZmN3JTa5NRLE2E/phV98Lz530OHazZ0Xf9sWzFrNbqvW884eryOz2kjKla8IoKMi8z1dKm/0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j68X2hcjcmVDecUEchRlIGSySRKyzUcJSvJg5E3IuIs=;
 b=YPWlK0ms/aybtFU0jtEMkwlRORFOe9gnmyNHt1WZXn8Se3rLAMxU5dr84faL39ubXLefGEihhV0t+D1phmdTN6T3zf3MVMI0M256WqlA4z8R7UHo09igDdJDEDlBiSIztHunDThhWnf8Zj6ggjdUhqF9az/7/jZaiOKIFElVEXIM5fRDOOba9VIYdDVUY/EIIfcA9XCQoxHydp6qBSCkHs/N/2MInnmTDZYu/3gjRFBJWnv3CEIAOOmM/2N67otmhlPEqR/rbDtdZLx63IEuGUwMKuH47qZZOLHbDl8VyqDMJl5jD5FnyNwHLr4dDAp5kZ4S6tAt0SqWygSguJwdLA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PPF3A2914458.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::529) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 21:08:44 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 21:08:44 +0000
Message-ID: <4aa16bd9-61c7-40ee-b343-b1b5ec97003a@efficios.com>
Date: Wed, 18 Nov 2026 16:08:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] sched/deadline: Do not divide by zero active CPUs
 of a root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <46cf3d11435498c167e87c1e402c6ab2522f71ab.1795031605.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-221930@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-221930@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::9) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT1PPF3A2914458:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7361ad-8421-4964-fe0b-08df45b8210a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|261026121527099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gbaERsNR1YaivNUeX2yM2dHkHEGZ+Y0dqGzx1zWOZu/ytWJ9qqd1fvkUmZblu2ZM7Z8/AzILIiDpKnChxGrdf17hIti/cFkhYvJe2ZAI1EXhza2oD7+o0u3u/o6lUmx21Hwk6LTiRxfYn71nLbfXPhmr+9MbUI1shjSerF0ppy4iUGWHHkZ1taA6VB8UU7mhwlky7wkw5W7fj5ywYGjKGX6uCW+M1iYykqmiV7hW0+2zDegoK63tDypb/1lrHy4U2d5Xp6gCkpSFpgSaOR9OHLpjr50DsLb9Bps92MUavixDnUmDc4XRbH97QHi2JaAj4OOZoTOypmXGpbW77k4t9tPUdhhA0NAAs6LHTjDg38KOdgvizmoaryqnd5Gx7Y/SD6tBN+HEIkxcmdnccEbjz4jm/Yiy+Vhq0vUw1gHRanwkel2itaHlJ5Dzj82dSZ5I4Z+xjJdYrTjNZEY/ihcvWYZRZ8hJkH7PaAIw83IiMLpvJJ/UMof7GR1iLoM6Jlb+WSUW60zbWQU6VoZGixwd9vO8ANB6YEsGkGMk9TAzSVfEzjQ6qVDxMo2CWSfch2q1T/YXjoUf+1q/LA4FJ1EA0n1TE9Gef5/XyhZ7SwCwvy4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(261026121527099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGlML2JUVVU5aWlxRUR4RWZnRWxpUlpmUHlXaks1MXFxZUVaeno5UVF5SlVY?=
 =?utf-8?B?dTdFU29rbzcySDRMeFk0T09TMTdCNG5lQmR0ZDBQRzBFOFhVRTd5c0dwT2Vh?=
 =?utf-8?B?SSs5MFlwcEgyZHZqQ2ltZng3M3BrOW84V0ZkTXc4S3U5bmM1cUFPcXRtbGxL?=
 =?utf-8?B?K09sRS9DKzFHc1IxU3NOYjdnWVp2cVZtR2g3Q21RaUx4Q1J0ZmZieFY4Rkhy?=
 =?utf-8?B?c0ZET0lKcnJaQ2IrMmlwcFlXdkZ5MjV4azI3YjJ0N3J4M05NbVRzVW1teG1u?=
 =?utf-8?B?d1ZLS1BxYnVLNmFFWUI2cjRZM1lCV3c1RVE4THRkVEx3b2ZGazJDcG0wdnU1?=
 =?utf-8?B?Q1IyaGFWZ0JCalFRT3F2RGRWR2lJRStEallwNjZWZTFnVFR4Y2kycUFjYlor?=
 =?utf-8?B?RGZoLzFRUDFaaXVnczFrbXc2VlVZWGw0b0tXSEM0aXVIOEl0cVpGekljZW9M?=
 =?utf-8?B?N1N3aXQxdjlpVlF3THdYMXZOekRMaWQ3MXIzTG04bGFja21iZGhLMENJWGlL?=
 =?utf-8?B?K3FYQUNpWmM1dFd4Q3krYXh2L1AvalYweXFVanpNcmpMZzRSYlVxWjlOY2VE?=
 =?utf-8?B?OUY5SVUvTDRaWWdHMlRJRkRuSjZ3L0UzeHphTE5IeXNycUwrQ2xoc3lWc2RV?=
 =?utf-8?B?UVJnNWVNcmY5WTIvRVRJOHpLMzJ3Sm43Zjg0bkp0a053a0VvZzdZeHBuVGFF?=
 =?utf-8?B?Z0oyQ0VDRXFsUDU5RnBNK05mRnBWdEFaMjN3SUJmbnlSQXljeEJtK0VUUWJE?=
 =?utf-8?B?VDZxNHVVV1BXcTBuRGJLZ09rWUVFUmRnekV1VXo0UzBhWkJzMWNJM25zejZS?=
 =?utf-8?B?QVgweitnMGhJN25tRTgyWFNYKzNLYXRab0F3V0NjaThvQTNMU2lxeUJYODRD?=
 =?utf-8?B?WHVrUlhQWERBQzVweU11QlRtTFBmL0o1OFAzcnpLV0g4R2ZLd2dYemJLRXd5?=
 =?utf-8?B?cHluMVVROTBmMW5jdGFPV2l4b2FvTnZ5Z214R3pCbXUzVGRDTDdnWUFlVEVY?=
 =?utf-8?B?ZzhwV0V6SmY0NTIrR045ZDlpbzhObEY2SkRBRDJvK0ZxOTFTR3prOUQySFAz?=
 =?utf-8?B?Y3JXOWluZUN6UWRGK0k0ZjVYNTk4SUg1RURhNzdMbm5Ub2NRczh1NnpTdE1F?=
 =?utf-8?B?cktxTnJjRC9RZDM0UGJBZWZwQmJRdFYxZlVwdFp3eDBpdUpHZzk5eU1uUFlm?=
 =?utf-8?B?dWtVZlljZnl2dUZDY2NQL2h5ZHpkbWRXWXQvUTZ3YUowQ0I2a2RpMnhBdzFt?=
 =?utf-8?B?SVNsNzJoTHNPOVU4WVNjenlPRmFBYVViRFJWVXN4UlowRnlFR3k1N3BBQndL?=
 =?utf-8?B?ZDF2YU1SMFFMOWRuZjRhcnVTTEw0ZzUzbDlkN1FPN1ZYVTdleHBuWVk4bTYw?=
 =?utf-8?B?L1JRTWpRb1NLTXdrTFZqU3FMRmJGMUoybWNYWjBma3g0blZYU0wrYTlkQW9Y?=
 =?utf-8?B?N0lNQktaS3dXZnN6dmdTMmFWb0dMYkIvd0xjYmhpcmdwQklDQjB6bDl2TDRM?=
 =?utf-8?B?N1BWLzA0bHR2VmdjL1dUcUhaK1p3S0hDM3h0eW9zSVUxdFQwOGFyTm5GVFlj?=
 =?utf-8?B?cUd3aTlBVnpZbE5SM0tsUGxweTFUVmp2TW14ZjEzTGxna05kcS9zR29DZnpF?=
 =?utf-8?B?dWhhR1pIRUJPcDFYYkNpRW9GRUNmQ1prNlN3Q3V1TE5oMVdlV2dGbktieHo5?=
 =?utf-8?B?R3lOY3RyUVdVdnV5VEVVL2drTHRqdksxS3E2NlR3VXdxVnpnL2ZuYlA1WW4r?=
 =?utf-8?B?emsvVUsyU2ZEVGlTc2Z1djJVSjhCaEx2SlFFRXhGSXBUTVFhd2pLcW51cThY?=
 =?utf-8?B?WTJ5bisvTFRsV3QzRFZXdG91RDl1NzI2a1k4MDFGRXJmaEJja1Q5V0dkQXJs?=
 =?utf-8?B?WHdqZEg1cXBmZDBKVkFsSWdrRndMVDlRU2xFMVpTeWRvSUtWY25zcUtLMHdJ?=
 =?utf-8?B?WXFrdUkySmNybS91VDVyOUgydkxraGRIRjRhQWZibjRkQ1FoT0tGazhjalBV?=
 =?utf-8?B?TmNlS3hNeUFEYWFHdVF5RldpMG95QllteS9FdUV6OGd1S2ZFMTlUQk0yaXl4?=
 =?utf-8?B?clE3b1FEMkJPSytJclhqaW11dFhZVXBuVUhiVzF0Y0d3Z2F2TU5RTHUwTWQ1?=
 =?utf-8?B?UGFEcXJ4Yll4K3NTdHdTODR2OTRPWjB4VXJrKzM0d2lVbi82ODFrZXJ3aGd5?=
 =?utf-8?B?QzJnTWZ4YkVmYU1KdnVVbG1TbWV0WXlsdmdHWDZvcXdHdDRMZ3B5VGJjeUt0?=
 =?utf-8?B?NHBwM25qM2Z1dW43ZzloajltQnQxbURpUTRxR2VZS3JwRytZNFU3RkMxWUlE?=
 =?utf-8?B?a0NhYzBqbkR6TTdMdzU1Y21ESXBPdG52WDh0QWtmMHdxTzV3UzNaNFRWTGlG?=
 =?utf-8?Q?4gskoi1SMLANyUl8e0zJUD7WQ2w4H5dyjOwlT?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7361ad-8421-4964-fe0b-08df45b8210a
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 21:08:44.1404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXx1supynPQWF5wDD/06poUMmEQLoqYXLglwujuH9h63yVhq/3bcBI4KnOpY+ygf2HdXdYt9pyzDqywX+jwHcn7/4GeZXtBf6MFiCCazrv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF3A2914458

> This problem wasn't introduced by this patch, but can casting tsk_bw to
> s32 in __dl_sub() and __dl_add() overflow and flip the sign [1]?

Yes, by reading. cpuset_can_attach() passes the sum of the bandwidth of
the tasks it moves to dl_bw_alloc(), which calls __dl_add() with it.
One CPU is 1 << 20, so the sum goes above S32_MAX past 2048 CPUs of
deadline bandwidth. That needs a machine with more than 2048 CPUs.

This series does not change the cast. I will fix it in a separate
patch, with a 64-bit division.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
