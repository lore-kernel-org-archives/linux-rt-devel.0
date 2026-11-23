Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.115
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442527;
	b=ER1Y/5pL8ZD8fVxbp80mKcElCXYi2b2jAQZRrRW8ls2zK96yqLLdGBoneqocsSBkKBmq
	 +pE4+vtDswt5RJVxG0eqUydJnPfCogRqR9Xx9Dwv1BlNfzSXDNvS+/4SiE3bSC3VGZnVV
	 s7M+A42Rs/0dbvIjd3OPxslkqq1tCHq82OvBeXVJaraCBXeaB9nzlxRbpId8Q15noQJZ4
	 X5PFqax5wgDZJqoXFX/9+075VdiF4PIcXkzFsFJ0N6kw169sH4Xmv4aR0bZHsyOyoKtEE
	 PkkRpTPZ5d5mgMrkKsNyjlSS7KlnF81QOSguo7RLcFbL+0Sl0rINGvw7Acr2b4KmasA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442527;
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
	bh=2SD7j5QwJfYvyL+maKbFg4gKBF3uH2T1LNyFyTT0oE8=;
	b=FNLbL/dkeNFrHxz0Y01n371ZOc9P5nHZY5WduSi9Ab1xypViklUQouekO2KW6K73a1aM
	 viLnZ32eF3NVvFd3qd91zHRQFaNK2XpsWhZ4JwbpWEBAhwRsEDCOLzOn+b4EnKQ6kStl2
	 4S27QaVCcaeDoIWthQy23ZcawcqXb2fhOWreU5hul+TytTQEmaJpGvoGNvkQ4z+hF+vT7
	 KMUi8ZgOiEZ9TU4gFyNbugHvVwZZZEdLwE7KL7hRTJw0ndr6kwqhRFK2GTljdhjJqTKNO
	 VdTdwxQ1K4dqyzzZkfTSbWwrq/Ey8raY1RiE6YMHH+64RFFMD3q1sjxWGqCBuQiLdYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=N08jEpGl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.115
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020115.outbound.protection.outlook.com [52.101.191.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB7606A31F;
	Mon, 23 Nov 2026 14:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33DB7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=N08jEpGl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6qRyyaxrd2g6myoWUokHGoMd0Q579V2WJCKEyicUubOF+p7FWjvGwg0ilqnpb9Q2WU1WE2WKJ1OLKt515gEI+gecPjmdknFEBOahCQavXnRazz9Ab6o2Nrme7FogzQO+FlQ1OziuxYRjaLnwRqNzkbj/TVdwe/ps2YPROLMaRbkFJCJZuG8PXbOnkrp+YX9tOy+1HYjmKwGDTVLXPv/nscUOv49V4CHnjQDd+lCly4B1FUI8SPEHLF+0uUpUPulT9YgohbG5yrb9VuT0pvbyFwxCOuax9wbsHBFJlwMQw1KDlZbo3ZiViGOnawUwUBxiX1BIM7AJdKkHKyVYfe/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SD7j5QwJfYvyL+maKbFg4gKBF3uH2T1LNyFyTT0oE8=;
 b=YAi79exwzRTjrROEXCy7txxdUmoxuWr+yrbOtkNK6a70QAalBs+HLRrRrVK0CI6l073CMj17gDDvCnSOnOpyO3SxiVzAscEKZ0Non13jlULuhU/4gIH9uXzV8tk4yXc6QgpN15254BMD950st+eVwYmEYGMfkrRumYcyyr1qQIBF+MI7fsoELtUqOgsRyfygbH3K1LxdF/dnHjsmugJ7Ptz+gb7iIs6tGgRXqr79RB/6Nt86wJuAPQSU4JpwVFXYSXfnl4YdLd6ofilXXSDOanVHRgQSktaF/GlXmOdlKIvnKS2d3i/7dGZt6pMz2eCuhBzs62sRAG+iwIbaB0M/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SD7j5QwJfYvyL+maKbFg4gKBF3uH2T1LNyFyTT0oE8=;
 b=N08jEpGlVHmCsYCffLjefWZj0AG6Vw70yWuV2Ji+J6EIGuElcvilSs5Y56Ic1nx6F9OAZR+UUput+N8e/fxXmkOi4PCETUWrl4Pz+sHUkcwgg9lpooYSP90XnBcFo26wZSm/OL84gMHnClgEGvDR5vYUFScLfl/Lsgf72XFmS5K4FC8XdE9nZ2mRMwoejrscY6b0zWMPU5nbh6tEUVgxlHqAtCtIf289cw4SK1mpyKpdjO8PFhgVPaAePNjY3LB9G+ddzMu2bTjKfmmHdyZD/IBlpYn7LmJ1KwveewIXEEEEpPC2eZ34BF6ITijG++ZEcezskmVTkT+CBg2m36k+Cg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQYPR01MB11558.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:a6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 14:02:03 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 14:02:03 +0000
Message-ID: <6a09b614-b136-4fff-931a-f169a530ae5f@efficios.com>
Date: Mon, 23 Nov 2026 09:02:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 38/40] sched/deadline: Boost an owner that cannot run
 on its own reservation
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <297755d1d8dde37f65e12a4cd502c6332011f44c.1795207233.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226195@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226195@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0336.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::13) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQYPR01MB11558:EE_
X-MS-Office365-Filtering-Correlation-Id: 818df6e6-76dc-4d35-1892-08df496a59e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|7136999003|261009223027099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261102123227099003|261022075727099003|261028144727099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	gQGvBiE8uuEvtwTm6NZ8pQOzmZgmnyEhgynSe/Fd7obQ+R1UOrER36m9n5CRdZMxN8VoGcM2+6UYKCSjgaz33wPDiND4JmdRSkmMkUUmVUUUUWJ67I1qFE7AN8ANrASdIpI28aOFGTIthz97EMQrvsYxnOHIxGgOJEJvzyzwwExB/zmQpL66luqGOeZavpJM755UQpV9TPK9bufpOu34Tj95Ae76+ZSdbe3y5gT6Pso+TB3rkEZkXQSajQeOptBx0X4ZuT3C+JCVM5em9LEuXf9Z89z8BPanhHwzA6cxmpbjIEwkGUiJJUuUawNd3UaTK2Aqajq5VJStdXis/MGzR/ZJIBNzYMVL3abfnG5Qa+MSiCLynq07H2nlUuZR5Z5fCYMYy3/j5+ZljskhEh4GD9eOXbNY6x1OLCcV30gWyp9XkZlo0aI6yITOq5YDhfNVpvY/xTpxoEF/VacORuTGiOlBt/+3o/M+VUKUbHAjey72xrBFR1FdEbkXFHl10pQMvgbtaIpLvbRPZGfPqeKlDZF/T/2RQxZZFiZx0SXL28+T8wUrHjZzc7NVqDDnQOScVH3N4m5ugEAlMNGWXYCNddsyXtU9+UCv7nzQ8H+aCB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(7136999003)(261009223027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261028144727099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDRha1Babk9QZWtxak9HUUVWR01XNGZ1M21vUlhjY2Jtc1QweXNNd3hrNThk?=
 =?utf-8?B?Y3FhbnZnaG9zZGo1ZDduVHlXTURCVmpLWHFKVnU4NnUxWWQ5MFBsMmpjVG5i?=
 =?utf-8?B?SDRvTjc3dXhtMktwSlE0V0g0U05TTTYyQnIvUUNnbllkMDlLUVY5Qmt6MGEv?=
 =?utf-8?B?QVFSS3lRcFZtQmJMdm1aSHNGMTByYUJmcUhNQVdiTHhReWFOQVcrTTBDVzRN?=
 =?utf-8?B?YWJuK04rdmVvQ0QxZFZxRGJUWGdaaXZFZ0xrM2NJdjNwZ1V5MGEvM3p2eHhw?=
 =?utf-8?B?WllJZjBsdDlFWE4wcFY2MkFvWUxVSUdMYS9OWXFJTVBLaFdTQUhMOVRrN2x3?=
 =?utf-8?B?THlQN2R1NGhnT2o3VHl6UjQ2T3JPQjJ2RUNKMGhYcXN4ZGRLWmdWc0UzQlhj?=
 =?utf-8?B?cVVsQ3hzNk1lRElYSmNkZG1pMXM0eGIzRDBBVmNSSnVjSHFlZ1gyT1VzaEF2?=
 =?utf-8?B?dWlPN1pWMm5RSkZmTXdWUFZOTkZxR1p4dlppSWIvcG1jcmtielNqbGJDRkxa?=
 =?utf-8?B?SlgyQUpwRGQ2TWJwaFYzVlhuSlJIcHExZytTTjRXVm4yQ2hEbk5KTTI3dDNK?=
 =?utf-8?B?L21ZY1ErU2Y1RzZtOFYrYVA4cjU4QlN2N2FmekplTnZXeURnMWIvQ3hadHZY?=
 =?utf-8?B?dDhHVkV3cDNHaFdRTXRkMGxzNDRIYnpsRmFlRGdNeWE3OFZJSllJeWVITms0?=
 =?utf-8?B?MXRHYUNyRXFITnZrUDg0QTV1UGJaNVZ4ZjBzSDZ5amE1b0M5eXA2dmxBbGcy?=
 =?utf-8?B?amVRc2U4anlhcys0VHQ0TnJXbmNRNElNNnFyZWp3THhXV24xMngxZ0Z0V0s3?=
 =?utf-8?B?YVI2SjJYckJON1FBam5ldE5sT0JlNG5PdG5YQkxYR250c013UzJMSFdsWUNo?=
 =?utf-8?B?SGJMTDNTbytZWUN3SnJoUllDTFArVGtUVk9mNnpaVlRydmRjVGxsUytFZ2Iv?=
 =?utf-8?B?UkpCa2JuVi91TlRORC83bzBFUVdPZmx5S1ZsVGVkT2RMdVgvWnRBZWZIc1pj?=
 =?utf-8?B?UzlrTHF0RkYycDdmaSt5RkxOcDhaQVJ0SGxFUi9JZGZqZ2hBdFZjZjRkaHJB?=
 =?utf-8?B?SjRNc05JTzBVOGZCOHplajh0VXAwQVdldTNMZWdLei8xbGdobkhHenp5UUJh?=
 =?utf-8?B?ZFBVczFoNXRrZGZqRExpNFoxS0VMTTlsZ3hnRnU1VmxNUE8wdGg2dWJ0WnVX?=
 =?utf-8?B?MDdvcWtkdnlCTjdYRitLUlhTZ2ducTVweWcvUXloT2xWQ3BvTUxtNy9JeU9m?=
 =?utf-8?B?ZGVHMmZ6K01yemY4aFBXazFpcjdac1pkQ1hhdjhGb1V6ZUkzNE9BdnN4YU1F?=
 =?utf-8?B?eWJYanB2Tnc1N3doT3JGc0JOSy8zeE44THJDQmZnQlA4TDMrekxXT1MyazY1?=
 =?utf-8?B?NnRreVVKUStHaGpZUDNRRjB4akNwUC9SNC9BaUtIdEcwZWJPRnkvc1UvSjFR?=
 =?utf-8?B?cHFZZktuZWRTUjA1ZFdFY3QySTErTWZBbFEzQkl0MldwZ0VQbjJ1N0dYc0x4?=
 =?utf-8?B?T3lLZytpelo3L0k0UTVnUnNieXllT1lCMWlFNVM4eEtreTQ2QTZxZEFPVGV2?=
 =?utf-8?B?YlNyaTZwTE90Um5Ud3V2Ulo2UDJLNnhST2RxU0toMDBhWS9YR3ZxNVlCcHNO?=
 =?utf-8?B?RS9MVm1UYXluTTZ0WEFFelRuOFoxZ21WczVVejE0T1BqNHdkamxZdC9ROFcy?=
 =?utf-8?B?TElNL0phM2l4WVEvTlJudHFMSVFBYWNxVms2VnA1MGZjRFR1cU0xTDd2Vm5B?=
 =?utf-8?B?WmFRYVdzV0NucDkrcDFMN1hsK1hXZDVoQm5BUnlYZEM0bmdMekdIczRCQmNN?=
 =?utf-8?B?RFJSVTZoTkFNUTkzMm05S2hDQ3dRNTFtOTJ6VzFDL0lXNTE1VUtPQm5lc2N2?=
 =?utf-8?B?UTlaMG1saFVwU25QazN0STQxeXY3akw2Zng2ck5yRUhpRm5UTithcHdqTU1p?=
 =?utf-8?B?MU1Cano5VzFWSHFEUVBvM3N2QTFVbGdBV0dzWVVYRzB1QzB3R09wKzZqNzNM?=
 =?utf-8?B?bkRma2o3ZVlUS05VcjBPTzVkYUNiREk2bTVVSWpzK0U0N3VXVFlKRjkwYlVE?=
 =?utf-8?B?a2VDZzFHUnZncy9qeGN0WGpaUlg2MkxSOTZ1RjNTMytBd2wrd0pIMXBOMlpp?=
 =?utf-8?B?WGxNeFZwcTlTdkNFWlJ1dVM3RW5hL280b29pcVBHS1B4Q2lZZ1Z5cjBobFBv?=
 =?utf-8?B?NWZWanA0K2V0b3VVNkRYSVZmK0pVZzBJWFRPZkpsanU4L2RpcDRPdFVVbWpI?=
 =?utf-8?B?L3RQaVgzNXFBRlZqamZsLzRPanduNmpJa2JVNnVkQnFMcURnc04xMzc4U1RI?=
 =?utf-8?B?b0lrSHg2c2l1Q3hyTjE5SVNxSjQ3U09NL2FxZUloQlZITDBkZHN0b3Z4RlI1?=
 =?utf-8?Q?M/nSw7mO72NCtvVzxf720vDEGLZgLMvbbYGBs?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818df6e6-76dc-4d35-1892-08df496a59e7
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:02:03.4282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pkLWOf8pW9NyZxxRCpdfzPNXo8vqEQii/DU6IPJjFOvCJx0HDja9+WCDWjKlnxvPHwRh0T2sDD3sSFlhD0ltk05ydb5LxDODRatr4sZAiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQYPR01MB11558

> When p is a deadline task blocked on another rt_mutex (!scope->queued),
> does dl_boost_blocked(p) leave p->dl.deadline stale for the rest of the PI
> chain walk?

p keeps its own deadline in its waiter node. A boost never gives the
owner the deadline of its waiter. For an owner that cannot run on its
own reservation, v11 will start a period of the donor at the boost. Its
waiter node then gets that deadline.

> When a task that was boosted while throttled (own_runtime <= 0) is
> deboosted before own_deadline, does restoring own_runtime without restoring
> dl_throttled leave the task runnable on dl_rq with exhausted runtime?

Yes. In v11, the deboost will throttle it again until its own next
period, and reschedule it if it runs. A new case,
pi_owner_held_new_params, will test it. In testing without the fix, the
waiter got the lock at 103ms, instead of before 60ms.

> Should switched_from_dl() also restore own_deadline, own_runtime and
> own_period_start when dl_boost_held is set?

Yes. In v11, it will put back the saved values, as dl_deboost() does.

> Once now reaches own_period_start + dl_period, dl_waiter_boosts() compares
> pi_task against now + dl_se->dl_deadline, but if it returns false and
> triggers a deboost while p is pi-blocked on another rt_mutex, does
> dl_deboost() restore the expired own_deadline instead of starting a new
> period?

Yes. In v11, the deboost will start a period of the task's own once its
saved period has ended. A new case, pi_owner_held_long, will test it.
Without the fix, the refill prints "sched: DL replenish lagged too
much".

> If an owner is throttled while going to sleep, boosted while asleep, and
> then wakes up before own_deadline while still boosted, does
> enqueue_task_dl() fail to replenish it from the donor?

Yes in v10. In v11, it gets runtime from the donor period that the
boost starts: see your last point.

> When a runnable throttled owner (runtime <= 0) is boosted, does the
> while (dl_se->runtime <= 0) loop right above this check advance
> dl_se->deadline from own_deadline by the donor's period instead of
> starting a donor period at rq_clock(rq)?

Yes. In v11, dl_boost_start() will start a period of the donor. A new
case, pi_owner_throttled_rival, will test it. In testing without the
fix, a deadline task between the two deadlines ran first. The waiter
got the lock at 53ms, instead of before 35ms.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
