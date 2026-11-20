Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.118
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182777;
	b=YuB3luX2mj6+gQJmkeGLgKSMbwP5wMVb2a+FYWHp/rt77y2gSAPiRuo3Dtj4VjDEh6VL
	 ehQFBduumqPWSzjUV4O6xrEo6aoPxISFFufJ49rqiISZTgzGp9JhpdEs2WHv1bFy31Kf6
	 H4oFcvZjnYaWLDPJI/Mk+PwQw2cPGfIEM7TpmB2VVGFvMDlYbi6HzaXOCEW3ym84lTS5x
	 zjrgU5oitVb0Nsq8QtpGswQwvg1xW5ex26i+QBFMBzDImZr47AgM/Gs8jfpruMc8eTlmJ
	 8Dd+PgnnXfUoZqXotiDwnJbtsHzTpl2dHikeUBJOd2q8igta9+Lll0QODM8wfRilZuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182777;
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
	bh=W9+ukhaIbiKG4qeeiOVrxXDzLhps5J9IRk9I79UUpAk=;
	b=PzxDc0FESgkATeETMC3FEdGqW0ubVXV/Ayz0VeBO9YtEQt8v0qI+ZFZ8edJcFgIFd83i
	 5oOwIqiXItBUMbwCQlQ08/iVo9cC3b94XwpsCApeCpkvwVTt75zZk30+COZh0ld+Wdvgt
	 2/FxA8UKJ5AvseCdH7qpJZOLJfvsZLpUo+qjL/0u80hpnNDXqjL3Gc5WraRsl7W+m5JbF
	 JO3MrT7gQaOOHQTQiPy24DEorxp4uIlSGTF3w6DrkiVtLbJLFOWDOSlhPAfyM4fHSb6/1
	 BUhSxh1m4VShxkVfZjcpQ0id8/j0tssCMCjYY0isNgJpf/icoDQ6kAt2nEPyKMRJ1lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=mOHB9Gg0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.118
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022118.outbound.protection.outlook.com [40.107.193.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52C606A325;
	Fri, 20 Nov 2026 13:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B52C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=mOHB9Gg0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyxRaMpeIiYDddUmThQWQmq35Fio9IBEp3KEEwi+5WEo/OXxtL6XNLYSO/GbT735hzLiU1nXqzvKW7JCDIxHC+qio8sujG1B2t3qM9DhdX8kLRkXHcm4zLrEgM+aqdHQtYIR8OCBxdonT2K2aaVnR0XAcnnlfFBqrBeE7YscX61SGC999OVdonzZrAUMJZKrsUI7rs9+tYvzI0gUtALOLM1zMFgPa5yvRju+HmP8c9B1cvsYWEotL+D5XPmYabG0FWkD/a5ughESwkoGQkOl3xbUT2z0zHQIgzCECAbNMdh9uizb5iabIxwP7/ouU6YNO3FeXOk8AoILU7kYU8fjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9+ukhaIbiKG4qeeiOVrxXDzLhps5J9IRk9I79UUpAk=;
 b=KoXMF3zn8RssxS6r4BPJ9V0tp4D0kNGjBly5TG3jdIhYQrLjll/ZTc+PqE4ScKPQYyeZvrjf2pFCltbG0a2ne0TZQpdSO2WfcicngdGWHDTlon6S0bpgUFRXJDQOnUPwAjsev3v79CAh2Z7lFFd3Mi5DImPTBfBWz90DSyymPsaNjnPb+WX1exvEmfMb3cjni7SuHJFiueeyBG/pFF5FT5tZ1g0O/VOM6yZK7hhZmlmqpMrVnWXzheSdS7ZjEj0rr/xKgbLM3MqB32vqBg546+CpscK4v+K3/KOZhaWx9p1fy/mXA8q/bH6M1Tsz9n2mijLAoyxBa82tKx+VyvsGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9+ukhaIbiKG4qeeiOVrxXDzLhps5J9IRk9I79UUpAk=;
 b=mOHB9Gg0cmj9GhOX3qDMwhUyIl/NPYvwWeeymjDmDDjrYYDBPhcATvC73WFn8MLcTMnjuSfi9R8JL/qwj6ZwMjrQpWGahLBPQL/tU4XyZjQnmbHcjsw0ka/3a+X3pZGwUwkxo9U9DbU1uctVaALQW8rKApl5euWccKM7BjGT5dh3F/Y749RWwDgWtghJdxMDne77IT+hZPCOHLrv/+x8kNEZsBBw4iMwhFVb8gI17FnTrZaEW1uiDq3v1OBr6jkRv5fn/rV+otWLwZ41XZAsaLEK8tCBRl5ApnYvh+C5Cx8gJhNX8+KosZlBmeMPkPQLFMt7hLosVw/51S2g/mWdFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB11587.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:52:55 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 13:52:55 +0000
Message-ID: <496b5bc1-8ae9-49a5-9cb4-2534b654f60a@efficios.com>
Date: Fri, 20 Nov 2026 08:52:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 26/33] sched/deadline: Start a period for a task that
 enters the class blocked
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <b218275f5c0dabbb914bf1ae9cf6a32f0551dd0e.1795116791.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-224078@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-224078@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0259.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB11587:EE_
X-MS-Office365-Filtering-Correlation-Id: f6614689-3f87-4b20-0619-08df470d9410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|5023799004|4143699003|261021121427099003|261102123227099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KBxWoSQe26naG4Z/X0BE1qpgSkodDLVkiJ57X76alexOSirE6APt/bL39aAI6sDU+M2TmxDipur8ZASBZoqFLCHfnAsxQrvel4Ybyx8xswLCx7rcP+6Fp50m1pEnLDI6NU+vldcq630Do/BqPjRrv6zrs66fv1Rj9IzS/WmSgshnqbMLwQxpSBRnaI8R7wX8xgkOEfB3iJWy1MqkYsi8V6U1zesRUYKzDrcW2pVjkCmKvpXraISkfGnPO8dnUCRs4aXr9SmA5jsa51FPwjiFRBShYMcAdDnTrL/gkUS6oP4XLRk2KOwD/km5i7bRCFwycXBWWTXHHwk3/bjESwidCxStMybKUPx3Cgr0Ye7sImOh+MraNxObnAnNFuPlmUVZeXwxm0rdSvpJQmJnP+ljSF7vIUAldBvykSxmYwc9xHUEooNeMhnWKqpIZZ/8WSm9a0217iigwpHehvPLBcZHBdu6Gz6T5oXJIDIcmQe3Wp5GeT/i3fSwMVeXhUfs7lj8DLoUkgQWPkFqBXmm26CSRVUrGCb1Db4+0o7En6sLKZrfosnqcncfyTqPR4lTqhTalhU+nSpSK7u4P5KlogAkTK8lHikliwGuzNS17ijT6cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(5023799004)(4143699003)(261021121427099003)(261102123227099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHJjbjlkRHk5KzNTYi9xckJjOXNyeEJ2WmZ1elJnMFZxUUNXTmkrNmRrcEdT?=
 =?utf-8?B?emk4VUpLemFORFJIVEpvaEtIZXl2NFV0N1JBUHp5YlU5M0RPOWhNNEFFYk5K?=
 =?utf-8?B?d3RSOWJYVFFram5TQmJsOEpWNG5sbHBCdFgremg2YWlpVHloQ2dScUtEd2xm?=
 =?utf-8?B?andVNTJheWtMMW8ybHB1V3FDcTlzUnN5RExjbEd1UmJyb01Hek56T1dIZlhm?=
 =?utf-8?B?UTR3cXRUMndYcWlBa1VDU2VuS2Nid0RzbVZHZElBQmZ3SzRLNTYxVWo3ZmhV?=
 =?utf-8?B?M3NXMHovY20zNTV1aHhPRmNNa29BeHRCeitaVjdSV0JwaHZJN2ZpMEpyMTJy?=
 =?utf-8?B?RHZyejdPTjFpcytXZis2SmNIZ1EyZUN4NDZmOWdCV2t2YlozVjJPNlhieXFO?=
 =?utf-8?B?cWkyR0ZtMGltcUVtR3FTZ3pMa2RTTE5Dd2FkR09jejl1OWtCQVBKblJ2Rm4v?=
 =?utf-8?B?MEpKMFhzUFdwWllhQ1NrdFN1c0hKYVl1VzAyUlAvNlpYd1pZYjhOU09HcHBY?=
 =?utf-8?B?MlJwVjlsaVpnSy9NMFBWdW4vZ2t1bzVNUHdhdzRleUZQT3ZEL1FzMjB0a0dT?=
 =?utf-8?B?UFFFVGFCYjB5eGcyWlBDQm8rOW9JZ2wwckJHOU9QNmZkTE93eHo4YkZTNGpT?=
 =?utf-8?B?V3pKUUt3aExOMTRnVTBjbTB1U0hQUFlwR2FVQ0JuNjN4MjQ3N2RiY0VVMlBW?=
 =?utf-8?B?SzlDODZ1YWV2Q2dlK3pNSGhXT0w2TDJobFRJaFZjNFUramMvVXdjcXl3Rk01?=
 =?utf-8?B?SzdlR3QyeHowdmN5VDNSeS9ocEU2azFwcktjRERSSUZ2aElZWkZocW4ySHhU?=
 =?utf-8?B?TWY5aEUzV2lzRzlWekh0MTNGbzJrdVN5TGZFbW1IZ3k5THRBYnN5UmJrT2di?=
 =?utf-8?B?TCtqMFY0aklNL0dud04vSVNkU3lKdGVOSGtTc2puaWs0ZnllZFdob0MwSmdh?=
 =?utf-8?B?L0U4b2o5ZnA5aEFsUmFwMExSbEFRNitZYXI0VnpPaUNNTEVzMzR0ZmJ5REx4?=
 =?utf-8?B?dVgxaEFRL1phWGJtTXBtdks2V3dpVEswaitQWmNVd1Y2T0ZXTGNDdWh0WW1m?=
 =?utf-8?B?VWxscmI3cEs0U0N1bEwyRHlZZXpzOEYxM1h5ZGZ2S05rVVJYR1lqRTF1UEUx?=
 =?utf-8?B?aGtQK1FEUFdSVzkzUm5zZWtvZlhIak1RYmJrU05iM3FmWHBJYVYxYTYzdnQ4?=
 =?utf-8?B?aVZkNjJZeWF1cWV0akZRU1dKbytLSWYxeis0RzhuallMNGx6OFJzYUswcmZZ?=
 =?utf-8?B?SmNGWnJxdE1MUjlWaFM4YjNGVHVRdzZ3c3l3dW9hTldXWUl3Vm8xbmFQSGJm?=
 =?utf-8?B?SnJ3VjhkaUx3ZGNHOTFZeTFpdDNEdXZ6ZTloejZqbTlMWXFhaUZveWNhVUUz?=
 =?utf-8?B?dGUxdzB6enNDaWZCNVhDN052dStsZzYxTmhNQ3F3UWRSWVhia0RIQnBTWWFW?=
 =?utf-8?B?bmFoUG9ySmdIdjZFc0ZpOG45ekJRQjBpVGVFUkR0YjEvQVhIY01CQmtjNlNB?=
 =?utf-8?B?cTAySENCbjU1b0FzSS9SaVk0cjVxMFNYY3czelh3Z2xObnhhM1VPZTNtcWtB?=
 =?utf-8?B?UTFYSmtGczJvdG5xcVJqNFhJMWIrazBYRE1tNWZjSmNUV3Y5LzRxT1JMaWZr?=
 =?utf-8?B?WGkwMmwxOGlPdXRnbFdpRXJPNkpIZjIxZm4zaFl4V0VxK2FPMmlWNklTODZE?=
 =?utf-8?B?ZTA2RUlTdG01ZWEwS2NNRkNzZnNEbzZUT1JXN2ZtdkRaZ0tES3k1NzFqVFRH?=
 =?utf-8?B?d2J4Z1E3YmxJZmNXdzJJQmppM2JCckNZU21DQVh5RzBIMnU1dm81Zk1WSGlp?=
 =?utf-8?B?c3lTNWJITWpyNzQ0dUQrZzlWT1FLcFhXTkNBWWt4YW1QM2lmRDgySitLZkVK?=
 =?utf-8?B?Mk55M2dSWnFMK3VJWFdpeXFMYkFFMXdZMkdvT3ViL1BlL0xWSGRZT2tPWi9U?=
 =?utf-8?B?WE9nSk1YQ2tLNXE3aEs5TDNqZmluNmh5MW1hd2Y1d3ZSZDBPcHJsVW5WcHQw?=
 =?utf-8?B?NmorMEF5TzBEWkE2clNHbE9oYUFlZkRBODUrMkk0cFVIUUtZYnZadFhiYnNW?=
 =?utf-8?B?MmtWQ0hDbm9ocCtIUEpCT2VudUw1WjBOVU83aVozYWh1Uk11VXd2ZDVuM0xI?=
 =?utf-8?B?c2xzcFJTdlhQdG9KRVZBUXZ1MXIxblZkWEhjVGx1MjRGYjFuaDJJcGZIcWxo?=
 =?utf-8?B?c0wxRWM5SEtxcW55NG10bktoMnRkenFrendsd2ZCL2xEdDA5MGVpTjVuNExq?=
 =?utf-8?B?aEZHMDlobFJEVmpBWHYrL25CZkIyTEFJNDVWZEtVdGFubUhFUU83RUlXUXg1?=
 =?utf-8?B?d2dQZm0rQWgvVlhQNWJGOFVuS2ZiSGFRT2l3ZVdYL0hPRFFjbG5PVzVWY251?=
 =?utf-8?Q?Qggrh3ZadnghbDv1jWndgnnQjnk6qOEDuiGvg?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6614689-3f87-4b20-0619-08df470d9410
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:52:55.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8slSpCHp0T76MjAZmExTpQ8Cap393IJjVUvkCzm1iqrr5V5N/pXw8+7qGcHCxXzsKjwFbkqRJGiHIl38AjYwF+EA6Eq/bYrQGqu+MMkhhR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB11587

> Does gating replenish_dl_new_period() on dl_task_pi_blocked() leave
> p->dl.deadline at 0 for tasks that sleep with p->pi_blocked_on == NULL?

Yes, by reading, for the requeue: FUTEX_CMP_REQUEUE_PI copies the stale
deadline into the waiter. v7.4-rc2 does the same. This patch covers only
a task with pi_blocked_on set. A fix would start a period at the proxy
lock, when the deadline has passed. I would rather do it in a follow-up,
with a test.

Your second case, a sleeping owner with a deadline of 0, is older too.
It belongs with the missing boost check of patch 32: same follow-up.

Your third case is not a bug. The owner is not a waiter, so nothing uses
its deadline until it wakes up. The wakeup then runs update_dl_entity()
from its donor.

> Can checking !dl_se->dl_deadline in dl_boost_blocked() miss a non-deadline
> task that recently left SCHED_DEADLINE before its 0-lag time?

Yes, by reading. The waiter is then sorted by an expired deadline. On
v7.4-rc2, a deadline waiter blocked past its deadline is sorted the same
way. A follow-up can also start a period for a task out of the policy
whose deadline has passed.

> What happens when sched_setattr() gives a SCHED_DEADLINE reservation to a
> blocked task that is already in dl_sched_class (for instance, because it
> was boosted into the class by priority inheritance)?

The state stays consistent. A boosted task runs on its donor's
parameters, and its waiter takes the deadline it runs with. Its own
parameters apply at the deboost. dl_deboost() then starts its own period
and checks its runtime. The chain walk requeues the waiter.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
