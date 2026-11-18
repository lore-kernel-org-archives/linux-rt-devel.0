Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009018;
	b=EZNQ3+Oc88huYR1gVKBhPnIDbMDCigOszgMu0UE67FBSdcNJtbkhRiCD4J2SwB3TXP7P
	 M2YldMYHqb7U8vwObS3WZM/+FNBKfrzs4c85DzASi3MOtSF7Q+5K6IE8uz2vZohXvK++P
	 rZaamRnm0sNMOO3MK2DY8vZaIfeCkWXRuzMh2/T8ef49b4HfabRQRBzf66sLEHu2MVj8X
	 glpwTB6qF2gMKo6hNSGuhPbmY4WPQ9WxH5btW/AEZzCxeoRC4M1PsP+p7u+t0umPlO/kA
	 ynssrccLKsNJdGMQKZoWPu87yiHrdeYRsGoktkSntKkwvhNhkVP3vGVrAqu2nETi06A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009018;
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
	bh=tIb+MfinYrnAZGrwSHlP2U1W9EeIzIRSLcWY7yTB7Hk=;
	b=gbKkitPBJ2quAJQM/g5sVHtRzf4OFbHAgWxL/iMxl6OmdQbgy2aBJ3EHaWzqulIUn1cT
	 +6Lj6StFM+a6n4TVD2YLxhBRQu4KbK0Ej5xkhAuCJj7mINk+mJCwDDl63meIOWwtEzDC9
	 SvaYBmTJh0DisqOkrfcFtHAkvqRzouCIMo6NA95KuKgzeuh3MDxyTR1JVskNmIGTFWVH3
	 WKE1TCjQMGKXtqZzqh/sIQ0ghL4op6cxL1ZoO6q2G83TQZJJPjJEiA48oWt+L4Qbnv2AS
	 Qjke8NH1VAlPJ6UqnTYueTllBKAPjsi9GnNKeXVDPFSShV9x+LuXF3SnNRP4YQFHueg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=igYl9HSa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.106
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022106.outbound.protection.outlook.com [40.107.193.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCF606A32A;
	Wed, 18 Nov 2026 13:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADFCF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=igYl9HSa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBe/c4sxSMA+J3pjqGGNl2LyEV2dY99KEOazYYMZqW9gSEb9rWfUbvuuY72+8ldYV9+dEsbUPmk4tbsRJWtGRUDdFSAe+jvQ6vxw049GdDdf4iAEF7sb5Bk4MJV2FYZT/Ij+tXsaubAyQYSAaak4Sb3k+yK3CjFfppGMr1TdNco613xnkNUzhPye/JYrwR3wNUnR73sH/nWh0hikXboEXMWGbtmcpVl27b+igQTdNOGOQTCd30R2ZXkuedffKcA6+5+WvQlqMm8F7GP1fGK2eZDSHEqL7NMHwWDMZpAzMX6El8Xrp617c6ndIZME87W3E8/kdIGaYh6dZi3u+LxBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIb+MfinYrnAZGrwSHlP2U1W9EeIzIRSLcWY7yTB7Hk=;
 b=S3R+R7JsfYoFRHdX7HSqHttcE66CtiiwzRxrsRNPUo3EN7S/fRbkBu70R2N9t+gDNnC8owjMLyvKb3NyPrpseWDaAvkr1I2KFVROdQaRlr0tmiD4PzgaUWnl3htaH+1KBksr9SudVV060C9VaL3L5CbldaPcXmQFk7tYPw4VKSkyKtMgWfFK8ppRxoJPJ0wS8r8fzNA+KF7YUCBFF2ocju9Mb0ZEv6Qxwog+JfspuDdtIg+ofpZbFyFtB0VfU+ayJHxecl5SVN37eMHSf5VMjGJig87m32l470QAZ1GWNxlvB15APODHAj5zEUIL2oR0apcti9ZK5sNPlqRBDBVoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIb+MfinYrnAZGrwSHlP2U1W9EeIzIRSLcWY7yTB7Hk=;
 b=igYl9HSa5w08KqAO2mQaVySHyZ4yrj7wmEKn6JpKOVyUegD8gKwPeYhoey5+L6YAnPx3kNZyWmC1696MCZhLsyNae5sLHRpHlxny2qhYyl8qVQzfyL8FmKxxY496OkWgFfkR5B/Xc23GY+t9kpdsodqWx1ZfbWbxOTqgg05LprLKZeS9pxdGTBDeH/6B6IP7u8PlMoRVg7hOQaS7qk+/cgRkGYL5IF+anBb8ihJKFxF+IRT2t7yV5zSonMMMNFb4BNZetsBvOio3Pz2fVi7WnLyyjuA7IcXfnW5E1EBH8caJEMbCYBmiUZiT5mXE3Wttot8p07SQVgmKvWP5gnm/HQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB9677.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:80::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:36:55 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:36:55 +0000
Message-ID: <c317b815-8afb-477f-9454-6f56766b5263@efficios.com>
Date: Wed, 18 Nov 2026 08:36:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/40] sched/deadline: Replenish a throttled task
 boosted while asleep
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <7bb821fa298ce41c9f6e49b5b6f5e462b41db8d5.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-218998@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-218998@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::24) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQBPR0101MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2ce6ce-3ee0-4d13-de5d-08df457902d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|261021123027099003|10067099003|56012099006|4143699003|261021121427099003|261026121527099003|261102123227099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	S+nXoWT4TqtX+7OYWaHHA0x1xfMEhnyljWp6ma4F084me0DHTf7cSgBeI4fFNUN+ahTeUvXzhtplWB+4YX9vRfhoMHWkl+eh7Gvo9bGFMcBHrcEqwBZpmsRWT/Z+3hMLBPKmNxLscvFsUo0NreHehDq+jxlDyipPmQcngfhmWQ2k3a2DUpnkWWYJ4pkLzvTuJsFliMwzcD3rIlUKOCIpDX/wL83pxH0ua7ry5L9QrLKfH51g0t/IGSR8a84icXHC3VlTHj5xhQVySOwJt1nGZItqg/v3cBO2hJhVXhvifwPJd8Cjmn7w62EGoxarj8SaYfTbeBy4QWwiB8pH6/CWflXZxdscKcLHXU/sKp93HoC78sxBr1B+DORY7IRzsYBbt7qnygyxsdx+NYOhqBgaKF7PRtqCA5NUcMXJqCZMyDkxBKxGKztQ2mkEFHsosub8pmhPzKfydJbpGTwizjHDwNOJOnhgBWYDrDFtSqmcgvpq14fIZ8VAXuCjiH/Bf+aJO4xsq6VR2UhPCSJV+h5JWLlhBnMBo/FWNaSOkC5HfKa2zIdJ/Aav1HHjwXO2IK1aCEqC1/uAEj5/RJGG0euivosIO+IrcA28htATfYhXS8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261021123027099003)(10067099003)(56012099006)(4143699003)(261021121427099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWhsYWhBcUVQYU11T2xTSWx1SjRoSmEyYzcrei9xRVRNcHJoS2RDa0FwYTlF?=
 =?utf-8?B?WWo4TmxFaEdSdFNhWjhPajBzNmlzbUR5cUdFYmlkTFNTK0h2QlE3M1l4NkNu?=
 =?utf-8?B?bUh5QktMa1h0akJZWExwUDRhekNqR3VzUUQwYWtkWTdEWUhFZmhoNmtCYzBi?=
 =?utf-8?B?a3lkWE9YTTMrNG9OaGl1cWFxR3NjQ2hmbGF6MUZIbHBkUUpWTTB2WmZxSzJr?=
 =?utf-8?B?NGErUFYzZVZLUktCN21Oai9SMDZqODZtY1VJNGNKOTV4V2t2OUhFaGxuZE5t?=
 =?utf-8?B?dWZjR0hreVlFU1Y2NWEybi9FekZtc3k4YytqVDFad1VnaHVPSXpYNXdmL1U4?=
 =?utf-8?B?M0JRNE1TZzEway8rOWRMdWxhV29OY1EzMjIvaGZlNWFBRjRKcy9zRjZYUDA3?=
 =?utf-8?B?bXdEbVRmdVhwenhVWktWMWVQcFZIS0JvaDNVNlJEMklndkdsVzI3SkdnTHkz?=
 =?utf-8?B?QWQ3djlpQjlQalNDTmsramJUTnJ5OVBvRmN6VmllVjFOdFBFWkpKakNLc01G?=
 =?utf-8?B?Q3NGNjhaK3RWVXkwV0tFQkNsQXJ1QW9nclpBZUFheVFXM0RwWmFEbjc2bmJi?=
 =?utf-8?B?bzU2em00ZU5FdkdrSmN2ZENWczdMbEFiOGhzM3JnU1VwSGFiUy9hcGhOaHBl?=
 =?utf-8?B?aUtVSEhRNmdCTmtUTGpFOTlvUmljYlJ2a1ZvU005OTlFV1Eyc1VrbCt0bmFF?=
 =?utf-8?B?TFBjNE1VU0ZreTdLWnVCZ2JYeGtuRXJaaXhONlk5RjZ6eDRWVHNRdkVkVFNp?=
 =?utf-8?B?VDQ2UGlDcHZWTWNLTElGTkd4MzM1NEdrQURGWmlhbk9TejZqRFNGU1hZVzU5?=
 =?utf-8?B?ZHc4dGVtSjBaS1Npem1FZmhEelA4Y2R1ZWpkclAvTWVVcTh0N2IrZzZta01F?=
 =?utf-8?B?emFMWWd2QjV5clptUitoUFdVOEsyY0RxKy9DT1pHS3JlTlgvVTlXRy8zWUVE?=
 =?utf-8?B?aFM0cnAxdlF2Z2JTeWlMNGx4N3RPeUs5QjR4cllGSmtSeHVMdE9HaFJVZUZu?=
 =?utf-8?B?OW0vd0dLOXoxYXpoSHZZVUFSWmxiMFdUME9JZE8xeTZQODRybThhUEcrSnJF?=
 =?utf-8?B?QmlZTkwzTkVBT1pyMGRiRHoybU4yN2hzYXUxU0ZRQ09KdzAyOHhMZTlZb29S?=
 =?utf-8?B?emtxM00wYnQzRmNBTVVxUjZvNlRBUVlUd3dDVkFrNXY3V1BHNWxxQUdVbVdY?=
 =?utf-8?B?VC9LOUNseHhXM2pBVUM5eEJ3NDRxOTNjVmI0aFJTbmdCZjhoNWs2R0tiVW54?=
 =?utf-8?B?eWpFdE9pZ1lsbWdTaEZudkQxZ3ZpQ0hvUEx0aEV6WjlvNVBoNzJuVEI3ZUhw?=
 =?utf-8?B?ZjhuU1NDZGN6ZUdBZWdjTllIV0VMUG5qZFR1bitLbzRNYjkyc3dmaS8xbFhz?=
 =?utf-8?B?VXE3NUhZK0Q4NGFIWDlUNXEvOGVFSjRvdnYwRXhGa2t6ajVUVXE1MVEvaXI5?=
 =?utf-8?B?WVRGV3FGenN5aGpzRTBOZEdBUjJEeGFocFI1czFHamZDYzdCYmdzY2YyZTBk?=
 =?utf-8?B?ZUhoT05NL0FhTVhsak5qMm94VTJ6UGpIdGwxUmVON1N5U0F2bE1pb0lQN1o3?=
 =?utf-8?B?bjluYVlzUnV3azhFeThjb3k1WWh6NmRONUhvZ3YwZHlLMDNEY0VEQWtIdlN4?=
 =?utf-8?B?TU0vVVdjR3VmQjA5a2VCTjBENzFmOExVcnh2YjZGZHloOHN4RHdpSlNnUndJ?=
 =?utf-8?B?RjVtSldyUkVJZTVTcWNEbEJ4T2xaZ0MxSmV5R2gvcEFwamFwbGNlenp1dFJt?=
 =?utf-8?B?WFBJZFFDTWJsbEYvaVlZbFY4MGRiY2tYa3NaeXl5RjE5MnBPWklkTklSRzFj?=
 =?utf-8?B?QjBGVW5uYUV4Ym5nQzRERHVmbG5OdTlEajRjTnF4cFowSGljc0RzNHJ0ZW4w?=
 =?utf-8?B?NjBqeHI0M2RDTHFUZjRnSDYwWFA4TEZmNHREN0ZsVk03YVpNaWsyeDBTcDZo?=
 =?utf-8?B?VUs1Qjh2UWIveXIvVVI4ek1JczJwcjNJWmk4aWJxWU1oRFVjYWdVSmpGemV2?=
 =?utf-8?B?K3Vpa3JlNkgvOTlHTUw4TDZqQlhYclFqY0JMOW0yOWthVXlONUtuTjBEVjFM?=
 =?utf-8?B?YWcyZHpXYjE5TkNGRk1Ga3MyL0lFVCs1RHVmdSthMkZHanhHUWZ2dE5ieFla?=
 =?utf-8?B?ak56am1MU0J0eTJWRWFZK0pGek1jeWNxOHdRaHVHODZmTnp0TXJUMCtPMXdh?=
 =?utf-8?B?Nll6K0NKNXc2eXlCbGNkUDNIVlNtYXZqSzNidThIbFNlUVZWcWZESlRHUHFi?=
 =?utf-8?B?OG1heFIzNHJJa2pQUm5BZVVEUmFURkZ1UktxUCs5b1VJcVEyblpZdXY1RXJN?=
 =?utf-8?B?S0w5M0htN0ZlR3M1QVpWWWlBM0ZmMVl3dHdpMnlEYWpCYktuczBSUXF0cUoz?=
 =?utf-8?Q?8+XvbQhuwI1QbjuBucqQKndm8SRr0npEm1Ld3?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2ce6ce-3ee0-4d13-de5d-08df457902d0
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:36:55.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/VofWR1obVuJ14CldikA4As8xu/GvRgcZCDOVujnEDJXKOKcDyXfBH7yvOudHXe2nRShgwTFMeW5zxPuJMfHjM3u2a1oDVZ5qRCkHgSqa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9677

> Does letting a sleeping boosted task fall through to
> replenish_dl_entity() corrupt its CBS accounting by refilling its
> pre-boost deficit from the donor's reservation parameters?

No, it does what the boost of a queued task does. I checked it by
reading. When a throttled task that is queued gets boosted,
rt_mutex_setprio() sets ENQUEUE_REPLENISH. replenish_dl_entity() then
refills it from the donor's parameters, with the same loop. That is
upstream behaviour. The timer now gives the sleeping task the same
refill. Before this patch, the sleeping task was not refilled at all. It
hung.

> dl_deboost() resets dl_se->deadline and dl_se->runtime to a full new
> period, forgiving any runtime overrun p owed before going to sleep.

The overrun of a throttled task is the delay of the overrun detection,
up to a tick. A queued task boosted while throttled gets the same.
Without the flag, the task would keep the donor's runtime after the
boost.

> the while loop above pays off p's overrun in multiples of the donor's
> smaller runtime and period, which can push p's boosted deadline
> several donor periods into the future.

The same loop runs for a queued throttled task at its boost. It is how
the base pays an overrun while boosted.

> and falsely trigger the "sched: DL replenish lagged too much" warning.

That message is printed once per boot. The code then starts a new
period. The queued case can print it too.

> If the donor left SCHED_DEADLINE and had its parameters cleared
> before dl_task_timer() runs, the !runtime branch in
> replenish_dl_entity() skips dl_note_donor_refill() and the deadline
> update because dl_se->dl_deadline is non-zero, leaving p's expired
> deadline in the past after dl_deboost().

That early return clears the throttle, which is what this patch needs.
The task keeps its own past deadline until its wakeup starts a new
period. A sleeping deadline task keeps the deadline of its last period
in general. The cover letter of the next version lists that under "Not
changed".

> Finally, if p changed policy while sleeping and boosted, refilling
> from the donor before 0-lag time leaves donor-derived runtime and
> deadline on p when rt_mutex_setprio() drops the boost via
> dl_drop_boost().

This is the known 0-lag point of patch 10. The cover letter lists it
under "Not changed".

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
