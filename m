Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104432;
	b=LeFTNqE/OH+1U2JsnHDXxPEskHg8usBaw/jNeJzbRlT+rNF6HZLpDtOAlQAklysnVqj0
	 3b5+fI99LvriUB/tMIRDHvAglRRTa9jFyAXjiPXVQyPn4+wkXv2Y9tK+GnRAOJJzcqLjr
	 bo4lrwXiOVUrdh2Zhowp21oLE5FznNSr1ijW2ZfnuohxX5fIghUVtPZLB5DQkHyG6EOB/
	 Zfwm9OFfBAr/Pu8J1ubQbhqAT7QSbZsNasos9leSGmWdVrEIuf70uxcLmQxhD4KKr6D+V
	 Q88fzHTCMLBrHHb1DiHdAGwsU+ED6flvcUmhYpIYngPfLapL3eMszAMy3ksPw28ffLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104432;
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
	bh=1bzL4kiRVEsmteml7pz8v2HAHb6aaC8PV/1NM61lQYc=;
	b=MDtt3ChpVQZCfZOvnVvZaWhvq+wu0Kt907gQpPtsn7i3JaS6Vn3IqMrTknkDnBfVoM1K
	 ZhMggE+BH17mOKt5ChNu1JP6NRfqmDOOdCt58VlsFCA10uApJU3cHCru/oFHYEPI+F6Aq
	 zCldCKOA6WyWsvssq9PRAuJ+d67MZhw/MOiGN6q8mlxXvsILK0DEXznJrVBxbgtW+xdkR
	 dzRLrHDMouiUtsxuPQt+uCYEXdtPjKxF565i/jyWDFBtg72hYEBr/GgnusPretGlhmhGp
	 HHneNIz0vtBeTTrJydnks3zAURJcYhY94LFFRWUVprdDPwgaS1O2td8Ef5isotxFISQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=oKi657GF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.76
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020076.outbound.protection.outlook.com [52.101.189.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58097606A330;
	Thu, 19 Nov 2026 16:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58097606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=oKi657GF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7WSYE/m1c59/MN70fvypWpBVn4bzvuFnyKKEFMCm75CnMiXIvzzRVj5q7Cgc6D89ouA/R/ADAF7a3RPcoxVJAUbi8xnHhS9s3MEE9044naBT+JTQag0sCs8nGDYIxoCwUvkr/ml6jLGJMLlw+4XR4Fgvexjop+k8WnNEN1SZ7X04LJ78LqE6p0o2JLSckxF0b3EDC+InV9mgNXA2tCPp3jd6oKrJxKsZwg5vTlfigtkAIlXkJ3v8QRCaqGAzZXpBZLEpO/vXI6SswqiU38f6EsTxwi4WQviMp5CSdrUxwINaTZtSuBco8HlR2KV7TG43x1o0bkScZA2bD7VFdbHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bzL4kiRVEsmteml7pz8v2HAHb6aaC8PV/1NM61lQYc=;
 b=yI32RMe7LdedAVHRNk46jDr3RYR60HVygQExho5Lm/BaifUdV7/OjuWHLU0LVenYXO4YVu+zwsCs2b6qcv3wpFmCozSp+RAQikV7X2mZMfjXeEwRs420rVvSRNyRtpF+ycmSoNc693QdM+oArkLlsUZIpgml532zjzlR4k3YHKJaLr7F/IsO+7FSkdvCj/Rq8Fb2qtebYqeNJks0yZL1w8pY9VenbpVIWmqPlwwMe/N+gBotETZ9r6Gtr5QMiISnyyRji4YYlp6oJ5h8D0YWu3aXkIho4AehEaHGXSfgRnzaN5mi4yn/wsfiaztpWqt6yRgMQ34vBhDKZPv23QSYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bzL4kiRVEsmteml7pz8v2HAHb6aaC8PV/1NM61lQYc=;
 b=oKi657GFsclN6kL4RLtLC7IUlByWS9+wW/vCwAHHOnlpXVvQkmldLLAEO7AddaJOU3LMchjB9Y12R2SYo6PU1KvupfWj2Qr73elTpQOW19S/oruYcv+QO9yAmfbLJ0nCGYyBSNI8Ryx/Q2faCLj7zPp0NCbBrbqDQXK2VE4OzPQd1a13s3gxWe62zNbsJpoQj2CFRzAZpkVILXJCMTay0pO9qh5OUU9Y9Rdq0TYNK36kbqcjZwFi/SHSE/I7mC39iXOXtm4L1BEiA83j3kT0LX+Cj3FeICUZbyLp5sR9vyOjxYjnbJzBI/Qj+YhvPYuiSDfkq/FAIvKKPMbOlet3Rw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PR01MB9418.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 16:07:07 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 16:07:07 +0000
Message-ID: <5548c126-7781-4390-87da-53739f809c76@efficios.com>
Date: Thu, 19 Nov 2026 11:07:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/17] sched/deadline: Fix an overflow of the 0-lag
 time with long periods
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795092090.git.mathieu.desnoyers@efficios.com>
 <b341033dd787d5bd4a5259cf654fb725f57629c2.1795092090.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-223251@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-223251@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::6) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT1PR01MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 5666af7e-604f-4c16-f526-08df465728f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|3023799007|4143699003|56012099006|261022075727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hNEtqo050obgK5rYFJHuECn4vZo90mslRiK3PD2+vfQ2B0iZ3W6svJQdR3DgSmlZ8E3NM3yIa5xKfsVJ0yG3gVBwxBEL3pG53LAmHcpmwZz391Ura1Zw98XaplViBZz0VPDKPox8KZR7GCucUdmUn/EHYlZ0p178IZsLS3yi7cpZDGSsybw0BFU/8X1UM2uqeD967I+tEXKkgeA90efeAg3PGMd/m6dErgqH6hyACNsu2f74zGmTEfjyLAdX60zu2jIT9WuNbMbHp5xcDmJdk1sG3XP2VqX5QHK7hca3g9eZn3J4+Y7V9XBiYPK8WTpB0IMb6Ajz0nLsDljkEOieKBoCjNbVICh5vYYVh+m0f3+uDjna7/XNk2KttJhf1hRIPPMYs2NlXOtfVWrQ++JWcI981x0a/UL+0gJse7fj5xQjt5uFRsFA15+0Ug39K06n71y22N5sXCkOj1m620OAM7Z44IUiIGYfxkYhqrvGwCDMSOMS5iwgidKeR0URGmfnQHbl4fK9L8Xz9QbYVeZzIftPIwK8LVFZCfu1RKbf5WhHeO4B6XxV1cTLTOGpiJetEqBXRs/vDws3tKMfB3Rq9JGEADtw/A91VT5JuVIhqns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(261022075727099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXYzMlpWbzdTMytUSHU4MXhPclV4UTJ2UkNuTzdoRzNOSzNaOUl3K0RYRVVG?=
 =?utf-8?B?SG5rVWFMUTFWYzJXTnhKdTlVTWE3YWJ1MVVtVVlpN3dsZnRYVlJ4L3JadXIx?=
 =?utf-8?B?SUJ1RzZ0OXYwQWQxeUQxZXlwS2c3cGVVbVJrVE1IVVE4bFRTTjR0YmtBS0FI?=
 =?utf-8?B?UE5TZmdQbmFuQ2RtTE9UMDhwWkpuOG82ZDIvMUNHMWNmN3R0UElWV0JhbS9K?=
 =?utf-8?B?UmRFR21NUWlrOGVQakZkTWdvMWZvbGp5Y3R5VksxRExFbEFjZlBCb3BGTXVz?=
 =?utf-8?B?WVdkSklNT0o4VkhYakFtZUdpbzdxNVhTUENBQk9OVUpkd0czWEFzYTYyakJF?=
 =?utf-8?B?RisxVWNOQkFDWDJLRlBsOHl2MmhtU0ZEMXlXeWVzMjU5ODV3OC9HVmsxU1Nw?=
 =?utf-8?B?aXpwVFoyd1JwOXBpdmVjbi9aMGNNZ3lMODdtckJoMkp4czJwSlg3UUZML0p2?=
 =?utf-8?B?cURobFNzRVVxc2ZCVENBclVZUUpoeG54TXArWDFJV24wckZWUDNKSHRQbDVK?=
 =?utf-8?B?SURYS0p6c2cyOUl6MXQ3ZVFJUnIyL1A2eVREWDJENUw4Z3BUeW5hNHZObnNw?=
 =?utf-8?B?dVQ1Z2ZlekxCMzVncUxqSkhkNFBXY0ZyZHB0YkI5Q2RmVGFucVBkYTllTnhS?=
 =?utf-8?B?T3hFK2EzdGY1dWUvVUgxMnNmV2w5K1JpRFY1VE1kUFFySWNKMktiN1IzVGNO?=
 =?utf-8?B?bFQ3Mmg1ajgwVk5JeWJab0FQeHJBRXpjSW9QZXUwcnBhdWZTbFBiRGNDbm5H?=
 =?utf-8?B?WmR5NkcvMXh1TGNHWWVKdVZBOW5VTklBRXlsdExjMmdSWlhRL2pPbDlFY3lJ?=
 =?utf-8?B?RWE2a3h6L20yV1NINGJJeVBXWDFLYk5KYWMvZFA3bWRUSTZ4aVVuenc1Lzcz?=
 =?utf-8?B?akp4aTZ3SzhUcXhJZ1Y3QzRBZTdyVHBxOHYwUmdiUEE1MGhwR1R0clBySVlh?=
 =?utf-8?B?N2hnbS9yWnJIOW1FTk5GVkV2NXRHYnlLNGNyWHpzS2t0RXgvY3JMSzhGdExk?=
 =?utf-8?B?Sk9xYVJ1YTRsOVA0UUxMMEN0djJ5bjhRdTdvcTFFbHR6NEFhT1FDOUNwZHpR?=
 =?utf-8?B?ZGlFelI5VXBIY2dWMmFBU244Z1lWWkVyRHZHdWJxdXo3TGN3UEZjU3RMdm1T?=
 =?utf-8?B?U254TDBVampKWXF4cy9GRmFWMFY0dlFKK2VVL25RL0htOGsyczVvZVFUMWFt?=
 =?utf-8?B?bFg2Unk2clJ5WURMdVV5S3BndXNXRmVvaE1NTDA0a3doMkdFdk16SHZrd1JB?=
 =?utf-8?B?UHR2ME5iaWRHYk84TUp2T3NXTlRpd3NEVFlKTlI0dDFISnlNaisrakV6V0Mz?=
 =?utf-8?B?TFduOHh2Uzh2ME9QbVhsTEJHbUZlRm1YZzhhdWxLTUoxOFE0cUhHWWFYdGlS?=
 =?utf-8?B?SFRlSkVpYUpxR3V1VFdMVTlFcUJndDlXMDFwSkNGU0pFQlFGcElQcTFpRFd1?=
 =?utf-8?B?azBuaHNsc2R3c2VCcHZjcEx1N29iMzFiVjdWb1hzQkVwUWhBUncwUjRnSmZ0?=
 =?utf-8?B?K2h1aDRPTnJGdU4xa1NHK3hxQ2piTHlnR251VnFDUWcvbzU4aDVHeEpDSHpK?=
 =?utf-8?B?V3hZcDRGT0N2OGIyaXBvQUdTTjMzY052N0h0enh6Qk56bVU5Q01wVWJqbnBh?=
 =?utf-8?B?RDVIR0IzZjVpR0IwMU1Ld25FNzZxYU94QlBES3JxRnIzL3RZV0o3QW5INXlL?=
 =?utf-8?B?RzNVd3NEeUxwQmY3TEx1d2pJc2toWit0NjJIWmd5cHkrc29ISW9LTWlHUlM0?=
 =?utf-8?B?RVNJTXcwN2krMXpDOFpES3UzYlY3U0xVMC9Td3VzK0hHWGhGSUNRN1Jwd3d1?=
 =?utf-8?B?cW5UMG9aaVlDbGo4aWxSYlFrTEdZZENqTmZPZmRDMGhsSnF5ODV1NitnRk1R?=
 =?utf-8?B?WTI0UjN6Q2l6OFdFOGFCcmtPQ3huSmtDTWMxSlVGdk85UnJaTEhBK2NjbGg3?=
 =?utf-8?B?V1FLNk4yS0tPdTFJUVBKdXhFRlhOT1RRMXB3TjlBd09tUm83dGVPWUlienov?=
 =?utf-8?B?cEVUZDhFb3JWSmkyY0JDZjhkY2dvbWFXRXNPYTJhSk1xMHhkTyswNUdoc2hN?=
 =?utf-8?B?K3dRUEpzd3VpSEk1Wmd0ZXhHeVZubng5LzRjcWszaTFtcVc0eFE1cXUrUHM0?=
 =?utf-8?B?cHpkUnlUc2h6Snk4NlNGL2xTZWJtRjVSL2JuT3A4aFlPT3MrblM4UTU4UkFX?=
 =?utf-8?B?WjFwQmFnNlBXdGlHWFhKUXFNUXN3RW1zQVZwaGNpby9qcFhTdWNTQmdnLysw?=
 =?utf-8?B?WS9KMTYvNm5IUnBTd3Q3cGdhSm9FK0YydUpGV0oxWFBkaFNabnBaOUQ5bURD?=
 =?utf-8?B?OStMWmdjN2pKT0pETFArQk9xektqZnptanV0NHM5OHZ4Nldtck42S00wN1Nl?=
 =?utf-8?Q?N9QnD8qXClr5C0FbZ8hu8suKserCHuufnlJfa?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5666af7e-604f-4c16-f526-08df465728f2
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:07:07.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e40Ksq8uXuspYu3tpZ3R/1s+iDNQDo94mez9yzTjJYHAVCPzMncuxE0Tj3KUFqslbS+mO1tTNCCTxoY4HTUYx0UjsKxTngXvtg7SuHD8Njg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9418

> Can mul_u64_u64_div_u64() trap with a divide error (#DE) on x86-64 or
> overflow s64 zerolag_time when |dl_se->runtime| exceeds dl_se->dl_runtime?

Yes, and this patch brings it in. The old div64_long() wrapped there
instead of trapping. I reproduced it in an x86-64 guest. With the
period limit at 300s, a task of 150s every 300s shrank its runtime to
1024ns while asleep. Switching it to SCHED_OTHER then oopsed with a
divide error in task_non_contending().

In v4, task_non_contending() will first compare the runtime left with
what the parameters give until the deadline:
  
        (deadline - now) * dl_runtime / dl_period

This quotient fits in 64 bits: dl_runtime is at most dl_period, so it
is at most deadline - now. If the runtime left is larger, the 0-lag
time has passed, and the bandwidth is released without the division.
Otherwise, the quotient of the 0-lag time is at most deadline - now
too. A negative runtime is an overrun, which the next tick stops, so
its quotient fits. Two new cases of v4 will test this:
params_switched_asleep and params_shrunk_long_period.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
