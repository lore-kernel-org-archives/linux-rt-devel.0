Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794150357;
	b=g6EwXFKh1gfopbOPz6NRa1m1R8w6euBlZcLSW+pdEwtaJ/XL2cg7KneBqLBeEWVYnEb8
	 +NLJHDd4+RKfeivOG+j3IT3RKX1J/IzTdVUqBQl2zDPlXia0ladJw3oDtU7wmDwZDqwp7
	 ump5HteaTeoZVlB8m8AfD+JYvTftQQ/0/Qcy9ERe+y89EGHuVdlcTe5zxywpELY2dsH0M
	 VaI5Ir4BRYDWKpHnTXC9k2uQI2FYtHJaMTmdv/T9kn2D0DE0cFuffVwZtnaFPEj3u7vud
	 Hec4RJPzmLFIW8yS6rkRyfHNRMm139vEnp4uXMP/PgR01Q2Jr0+3MQ+5Ht60FkOr5Rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150357;
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
	bh=uNvaQEDuj5smWwujTL3ynVOXADDeUAov/z3m3dC5S78=;
	b=nvhPwemZSZK7NBBJ+P3qtoVX03omzGBD9dDxvDM6ASpHBpi5RCxgoVErowEZmALv/Xrk
	 Yd1PwkuXGz5o6UxFb0AqfWmgHFDVvQNqy9VTEeBr5P5h7+VlUNceheJjV/Snpo9Wejw+t
	 zcG/KI4DrEpjYB8Vl2yozHzoeyvrfP8lNbi0mNRlVsTe8lArgtvaMgD1gnzh/0+fcy/Ht
	 ydHOgjZbRB5u3Eh/w9NQcPm3QieZQstP48cz2cQK5hddnEraQ0TXUN/SDGc2/hvCQsgws
	 hRehYzjzgo4wQdOyPdcEXvVkV+SrIZ5ZhhD/4ymNzdPZtz0baSXBhcDh/kMUcc03ohQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=nTdkuV4p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.117
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020117.outbound.protection.outlook.com [52.101.191.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EEA606A320;
	Sun,  8 Nov 2026 15:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78EEA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=nTdkuV4p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOJ7EL0XZSR+kko6YKHPuU0eF4E/3QMhEjFXFOorzydGVJ1zvTuM5KrPXfRElKJSDypPz07pd4iD4HVuQ+zF+M3YNRV8Qv/lJnF20YBuAkJ2wqhU2SdnO3ZyDn9mjvFubBYDsXaC+To/fyZbtr69wAXzy7oHWXKU9JpUJXJwcPhtevZEXDdSljUdmRiEmZaoO5yBPL5wGvezUAPt31WFZqbdM/k+fVaxvfic4bn9ZsIgIttGeZylYCShZjmibjMKHMy1kJuL174hcqrniY5cbAgz3Lyk98gWQXUWx286nXncu0nTZkBl9PMAoxnOrhuhf+0FV8pHY/OOq03Ixc0Vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNvaQEDuj5smWwujTL3ynVOXADDeUAov/z3m3dC5S78=;
 b=TBa/ljT+BwD9HO95K8DKB2eHDF680ljUwfLl70Ph/JkiJL2GfMLy0cp0B4iKC300tymB75E7HyycsxhJsgELT2bNrfFFybeERTuWPmhVnalHvHst5+//xPDbwaEcS4vVbn1ieei0Bjbi+XqQNg0PoWzf0YuL7hpsERnS7yvPXCNIQI6+UdcBdogS4tJsYMvyK+DscbFMkBxU+MhrPuRQTO+RmEAbqX9w/B7RCjFXGQuYCEQfSkZpLGfK4Vdk/HjcU02CdrCTIEb0F7rfnxG9lN2p299pnj0hFFQXmMC+Mk1kOfOMu+79Vq3yTZAbnJDGxdv34WSleGvlyZKn2sTN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNvaQEDuj5smWwujTL3ynVOXADDeUAov/z3m3dC5S78=;
 b=nTdkuV4pzn7ww3TcupTvmffziu+bCgsZgaWB8x0GD+rICi5ZiQG9iYDyMpi5W1qfMmEnsoAZvi75dIg67Vc6XPEmUOheCeOPdJlOHMQgqVi4A/zRhM/P5WDlAomoxuh1trislD61x6wOpCtHumkRNu0tFS5aU86waAVK09crD9TOfCiwlqbboORfarDvqsv/pLzHTogC97gIdP7S3Y7id05OkFUOvWlnDvSA/zS4MedDjtMbEUhLBLM17NftyUSQltCchHf69hQkH3qkjdxX6OYCTSk9bBCZ43fAtdamU8M4/LKNTePG0zTclSZTeBbUi1YKzcm5CNFNAixsAAyf9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB8139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 15:05:53 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 15:05:53 +0000
Message-ID: <23ce1e6b-a3a4-49ff-991b-d183861d8a11@efficios.com>
Date: Sun, 8 Nov 2026 10:05:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/26] sched/deadline: Reset the deadline and the
 runtime with the parameters
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-10-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202497@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-202497@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQBPR0101MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 572f6301-ed7a-4e9e-4260-08df3da9c87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|3023799007|4143699003|261028144727099003|261022105027099003|261022075727099003|56012099006|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	t+aDtvaqXfhaF20XwH7cyj5sksx/2ghL7jOgDhVTtkZmzaYMZ42y5BuKLAxeUVdKr6tzKWzPCTb2JDK9SIBoU6xIasfO8ronz0ESO5VsnHhMWCO0bezQApE3MNcn40zhFlzOxr6kPfRJaAlFYfLivTRx/A9fnFcZ3+6HXHKT9+JCW/I9CwA71dCn7BKDBiyHzfWA/Yk97h8k8gijxSKbcp57e0/snSwBA6o3fDLi6rleO1VgzMoFJC0JbvPwDOW8ss3Jtzx7S5Z611figtBcKcfU5QWDqbocTBv+PnO1/X0kKwoqiOBMKMHCcaROsPHomwkfgtveI78gpQdc4UzZAm2zKgKStcBn7q+iYxUA1D3fPNciArNyiiuJKiRmS6yNvF89kU4CzktYCv9jRzJDRYPel3OTR0x2+T0jtmBGe2JHzODO59A0Pp+NIePseofCdVaqCQxxnUokiJjWF+DGZsIMDY+GMB8RFc+A/9lVPP/bK2O0WxhsBmJApFABjAvc4wBX+zKpgm7oAIW8POhaq8EvoaDLatSzC6vAPbR4ZQrVcjC9DymRZ02PHPsvTfTfFK382QS0yEk9qUf5DsvSOw7ojOC4+pp42JY50lszErA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(261028144727099003)(261022105027099003)(261022075727099003)(56012099006)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bENKdUVCdnlzTExoY2gycVpkLzZLckRnSEprSmY1U1ZzNU9mbUx2QjZ3Nzlt?=
 =?utf-8?B?YURLYm43VkVXeTZKbUU1dFdKNFFoRmlYRi91RWI5Y3kwVWIwUG1xaWx6R0JI?=
 =?utf-8?B?U3BrTGx3SjdhRWRWSUxCVzNQUkNSS3lpdlNsaDV2L1B5V0VvNUZvQ2FqUTcw?=
 =?utf-8?B?SnMvOE5obm90all5S1JUbmduZDVva3VUMUc3Y3ZJS09McUVqdFBRV2ZpWXNQ?=
 =?utf-8?B?M21tbXMvS2Zxb0EvSW1xZTR0dEozWG5QbVBuaG9sa0JGTWNldWxYRzZHOVZD?=
 =?utf-8?B?MlZLSEcrTzZJS0pZU3pDL2dYbStnV1BCcHFHNUlPbWRvMENMc2JuSnBZOUZE?=
 =?utf-8?B?djB6bU9ZSUJveEZLYUZLaGRqc2hmWGorOEc3ZjE0TEt3dTBPT3JOb3JVaUNj?=
 =?utf-8?B?MzNRUE1JVmVGYVFHUnFsdlBzem9PQjMxSGpJc3UrSGNLY1RqN0M0aStnWXZ1?=
 =?utf-8?B?eHVZN2VGSlpiNlNqZ1NlZ3BaZ3M0NlRwYkd0MTVLNTVlODhaZUJPMnd5WVQy?=
 =?utf-8?B?T2ppeE9TcnRwUSsvalZvUW1yTGNkSVQ3cVJWWnRHellucVZ2b0dyY2NldVBu?=
 =?utf-8?B?K04rZFc5aVhWQlZsZFd5ZGhUYk9LazdXMnI0ZkJBSExXZTRaTzExSnRKODV3?=
 =?utf-8?B?ZjdVS0NOclIrZkg4T0JVdnlBVzM4aXBrSE9hdmsxcHNjWlB0ME8wUUNVUGR2?=
 =?utf-8?B?NkpHUnJRU2p3M0pBTlpFK2JvbjNVSnRSeUxWNFZWQjBISHI1bHV0V2ZoLzBE?=
 =?utf-8?B?K1ZBL3dZRE04aW1TQ3liYnlSeDdNNXFMYytKbkhBeHplS0Z1Q1BiUUlIb2M0?=
 =?utf-8?B?TEJyNmVMMjJ3Sm5HT1JnaGpvMnd2SnM1MWVtNTRUZkVDNWo3KzgwbFZEbW1P?=
 =?utf-8?B?eEFxZ2s2RXlXZVI1SkoxYWFRaUJsY29qbytTVmpwb1Z4ZnZDUGtBcVE0U2Nk?=
 =?utf-8?B?R2dsendWaWxxQk9vUU5OcGx4NlhaSXQ3L3JxZi95Z3hoT3M2UnpsR2VSTk02?=
 =?utf-8?B?cDUwaGlJQWNhV3pad3BCK3cyUkQwTmVnbUxLQ0d3ZEdrRUFBVkZxUGp3eGZh?=
 =?utf-8?B?NjBVRStJLysxbDAxSnI0VEZENlExbFZvcHVzd0hTZ2ZFT2UxazlBNjhEdXpx?=
 =?utf-8?B?QmFwVjQ3dmpIeGoxNkNuQ3FPQ0NRczZlT2h2SkZubjhFMGNkWTRxMnE2bll4?=
 =?utf-8?B?WDlrOFQ4Ym9HRmk2M29rb0VyVG1vd3pGVXp4SE9qVEEzanhQTHhWRm5DZ0M3?=
 =?utf-8?B?TEh5amR1aGFTYVE3NFNlRHkrN09hQVJVcTR0WmFuSVAveWFwV3VpVGM2RzJD?=
 =?utf-8?B?Tnp5L0VkSVIxMjhkMXBoMWE2Z2lJOU9ZVUpmUWRZVFJsTnQxaU00QjVlc0xL?=
 =?utf-8?B?THgzL0ZhY0pvc1RqNlNLL2pPRlowVUdhSS9lcFJPZ1JPb2FFaUhuNzZudm80?=
 =?utf-8?B?U2tuMVB4TU81djFpRkNnK3E3OGV1OHUyN3JCK010c3h1TzIyWHJySGh3bFNs?=
 =?utf-8?B?VkNISGJBMTVSZkRSQitqZmpLNzM4TnhUM25ER0VWNWNJWU9QblVKNXNlem5x?=
 =?utf-8?B?WDJGUWErOS9xNVZrTzY1WHVFeXpKbUpmTC9sc3oxenJjQ0Z6QVZ2NWtGZ25v?=
 =?utf-8?B?WjFQRUlndmJyY2hzOVBBbFZZaFNtZm92Vyt3dzFtVW5hNWRqTTVmOXg0a3pO?=
 =?utf-8?B?TUR0cTFiQno5MzVQRWpLZzB5bnBYZFF6YkVaNkxqdStkWm1ka2laSW12cURK?=
 =?utf-8?B?OTlGU29RM05OUW9iN1NYMWdxYS9jemtJYkFxRS83aUFzaXRXbzJjWWFBME4y?=
 =?utf-8?B?Rm43VlY0ZkVmMGhBL3FwUG1hVzU5bW42dE9OZkNubjhzQjdZYXpQUHpxWW53?=
 =?utf-8?B?U1VWb21XRWlCbUszLzI3bFR1NEthSDNzVzltU1ZLWklYQm81czVJMmFicDRu?=
 =?utf-8?B?a0F1dk1haWpGelNJY29TNVV4TE1QWlJzbkhsYlllNkFLc3Yzekk5V1Rua043?=
 =?utf-8?B?eFVWM25NV2d6VVFUenhhb1o4V29YTEdwZ0JvSjZaWEx6UUdtTjN6emhQQlRV?=
 =?utf-8?B?QzUyTDFEMGFlSmFHWllxRkwvZWFpQXRjNmx5eGtvOXlIeEZuSW41VkJzY2lY?=
 =?utf-8?B?Q0pWZnNaSFZZMDAraGptbWs5VExIby9IZkQ4ckhPSzV0Y3FSUEVxUzRCdUZi?=
 =?utf-8?B?dTdzcDh0cFlNdXplTFBHTDNBeGNFUFRubGY4Y2JIS3pZK05sOUJJckxYczFq?=
 =?utf-8?B?RThweGMwNjB0Uy9MTy9NNkw3emFNcTZFekRSRlV1WEdQTXNMYkVPeC9SVFEv?=
 =?utf-8?B?NXlCZ1BSZmJlTzlaTzNpUDJXRUFwMGJtVGoraUZWMjJld05Ya2NUSzVNU0pw?=
 =?utf-8?Q?1iCsVUudwOzh0jfc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572f6301-ed7a-4e9e-4260-08df3da9c87b
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 15:05:53.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnIdKiy3wQ33qvlmP9CZXq7UgP1UyNZbIDZJn71jantFTzwDVp0XQNFZBRVElQHtmX2ah/G0IB2pMv0ffFdlYmeigOR5XoUPEItpdAZ/Zek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8139

On 2026-11-06 21:18, sashiko-bot@kernel.org wrote:
 > unreset donor period in switched_from_dl() when dl_runtime != 0

replenish_dl_entity() does not take the donor's period at the boost
here: dl_deadline is not 0. The donor's values come at a refill or a
wakeup during the boost. At the deboost, task_non_contending() keeps
them only if the 0-lag time is ahead. That means the runtime left fits
the task's own bandwidth until that deadline. Otherwise the bandwidth
goes, with the parameters, the deadline and the runtime. So a task that
comes back with the same parameters runs no more than its own
bandwidth. The release time is the same question as on patch 10.

 > donor deadline and runtime kept on deboost after setattr

Right. A task that stays in the class at its deboost keeps what the
donor left. A deadline task boosted by an earlier waiter does the same
upstream, since 2d3d891d3344. v5 adds a patch after this one. It resets
the deadline and the runtime when a boost ends in the class with a
runtime above the task's own. It also adds a selftest case.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
