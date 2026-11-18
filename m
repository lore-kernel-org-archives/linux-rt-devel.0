Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795036151;
	b=r1x1sZNe7sCKDkH22/b92q5Ta3+c9M1rrtQN2B64ZeScXU82L22sqkKsA/WUIdYwJBoU
	 GCdG2Szp4dCFLHaEuAnJN1q8GjvEm+fhBCDzPUvIKGUZmRegCljiClspDKuwOBp86SOhR
	 Gb4UNNjI0yvwQ7IG1+SmgQS1Du3hkVK98aHv3sJvi8sysxKrjCc8vZCTxpqcvqBb1BGe0
	 RhTVWEKap1driscR0WmYACnd31WQEMhmQFnFndC1BKGP6baACTYaetzRkZoq7qavj/445
	 4ASHeQzCKqZJt8cZQliHTP3LFlZtBjzGyYB3G6j0fIwMkE6OANkzY6L6YL5OeAESi1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036151;
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
	bh=7b5fKiKg0+tXdFgcqe10QrnbGK9AfLdK37D3Z0mrP48=;
	b=rJvhyKCU1oK30tU90vQt2GhDJm2KSaitpFcRy83WDWir0Lkb4O++CHnTs+nHBZGItNrg
	 snVHFbhD8rSfQConL+cmFwuCnEa3ZM8vNv5aw+PbrKSV8Gd91sFqf5PjPTIVHxG8eZCcW
	 vlsBrw9JlFQ4k/g3I4qbmm6oCPL0q/XpiciZjsp3Eb5fKa1g9efFaILlp/RWtcYn734bw
	 gpQuFVYLcvz11J3BktzBvkOyRcWUGDqg+t9hYejqAT9MCvV9KPWl/1qcn6RfERH9U0MPr
	 2RJl/sxjtgNWhXmhfvjZbJyijojreG0hN9kC1rlUQQAc5hAhNdaHkeXFlT2z3qZtqYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PNQXjLNl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.112
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020112.outbound.protection.outlook.com [52.101.189.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF14606A33F;
	Wed, 18 Nov 2026 21:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF14606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PNQXjLNl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7Ip624CAd6Ue3tT95WasO2+Ju2377++doGvJUaAodA/+VGyUkZvits+TsXCP++1mhX1jK1ys5v/ay6DPkMg0KLTEHP89XVw7IH0TjAjQMY93lIUMf+JXPm4yO2brFO2hlyrB1HEcGVuSAxr97yMQN/O57UR6GSKBtVEZwiK9IHS62QiAnxmlthKDxGWWKXFRWwcFMEc4sL4MaifAwAJ1cBV2u2YhSqbdyRyad5RXKmDVOFcTO+Fb1+4Zu5NIWqE492YWtJDDmeG2ocUir5xbm+6WJDjPrWCvBefHpZ9xdAy4Q8EdvlTHTJlcHKa4iWxxAY2M8mq7UqhufX8bdL6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b5fKiKg0+tXdFgcqe10QrnbGK9AfLdK37D3Z0mrP48=;
 b=GioweSGa1x8wqj2tJMalhLI7ZL6eq4Y8s507mwN7WEuf9gFi4hF0H98yhnXtZo8hiRYs42D+LV+qUjZe0eXVyKUaoiGwMkQbD3USJqAk/jq8sh0QtbmaJJHMZbJqwE5CeCjwZ7rHlQzdzgyJqqQVPc8Jmws6v8UBsIz1YdTuuspTCdtghYDgVFvPTz/aevV6S2lYNd5ZvDvogmTJtB7S6MaI88Ljmp/tWPVGaww9DUcZCI2rDEVmFZHpUjekAjXDKa+q4q9YDhqYUKhA2Lbv0zL+r3M9yoSD7tdjkwUPkyDMToUj3fmpvVPN5V1fv7WlDz70BeGucwI5nZh1g1J9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b5fKiKg0+tXdFgcqe10QrnbGK9AfLdK37D3Z0mrP48=;
 b=PNQXjLNlUDV7VvqHSsRYz/HKcRNrXKWRZyVjbU3XxI9mdWeimDOK6lGMfLyTaQgjt1ai80IVNYZE8Eq4E2Zb0nf0ecGORcYAC13WI12PLbHbAME9hMYAJH/OTRIQpQGIpzzGkJ5FCioilgi3F5a08tss1zfXPQahxROO2ikXYetWvBo6AtPOAF2AjLOlI8hi+fXwOC8CxxpTptlhwE0WJlUU0rgv3lWcUEMsyfivY741A0X7kS2+3i6cF4xzWHooIg3n9sulw6Lig+y4b6hZuUk1kk09yr1qMVYCt7dv7pVPudiR1WRsSRiEw4/cCn/vXxLYtkegla9iBTdUBIcVkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PPF3A2914458.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::529) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 21:09:09 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 21:09:09 +0000
Message-ID: <e4573767-3838-4512-ae2f-c5125b6c93da@efficios.com>
Date: Wed, 18 Nov 2026 16:09:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] sched: Take cpuset_mutex for a deadline policy
 change only with pi
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <9194486f15bb0cb36b51e4525f471d1150c0d58b.1795031605.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-221922@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-221922@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::6) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 1b7763b0-11b0-4933-5c0c-08df45b82ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	n3qJODjRhfD/29yzyCSHwmh5bYhNdw21HMMt++pVWrtRUzwt0Y2pgNzOHBY06YpVD6stXuGjqpRrDQZBBg6Dn4s9/FhsTGzgx1tAAHtKhKGHdxsULBZTM/+WvOAcg7CFvhoo2oi+glSZug2ObKdeOnW7P5yG5xghA1YpRDj7+IQnW6YES8OXLYU+pJILNA/aK2B//SYHOkZghPnrn8L45gFV6n6XskSMMcXjSYg3NDiquRndlFWHO95CwErBdrYNwOjPP1w7WNz0sE4QR0kCqIpRAh82e9wEu3TfqUYU0w6fDBqK6gkuy9gBZDBdUAZXi+pKnaF8T+CxsEaHDrTglxau+lUnn5mAJxkr/snVQ8hrLBdmOTNPhl5PD+f4LcMTeVScpnxjGi9CWruS8p+oBMkN4fy4jqrwiq/D7UG5kuPhGWFjOUTrJ4kphZNSiALlHwLQY1bGU/0AUMTAuHXyOs31A53mo1w9BMrn1vw0TXGDj2xg4FF9YSTPrdniOJTpXfe5K6q+cu9VknavHRii8bhZnVgiKdaES6wIqS16OcA2srrwLwzeLB4j1gCnlpNb7YpgpO7Qy5GUirGSc/sV9jfe6Gz+eZRH3KJTIkZ125I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGZQYk5SUlFpS05VcWV1Z1V3Y0dwcTNHdndVWUo1TU1IQ1F1UUM2WGlhUkVZ?=
 =?utf-8?B?dDV3RTdUWmNhSi9TVFE2QmxoQi9rbVZmbGVyYll4MXI5ZkZaTlBvSlVabktN?=
 =?utf-8?B?clpBUXIyYU52Qkdsb3dYYVV4R3p6akl3M1RNb2hJSDJhMzBSZWtqOStTczZ4?=
 =?utf-8?B?Rk82SkFtdXpkcG5XWDJac2MrVVpvK1VUeEw4L3FLeTR1cVlXdnpNRzNpSytX?=
 =?utf-8?B?WmNzTDU3NnZsdVdXTXRtVlYxNlRCTmV1OWpaeFd2RytFVXoxNXFvbnFrbWNW?=
 =?utf-8?B?T2krUWRVcWd4Sm1DNDU0L2t0RDFoNjVtdExoWUlpbzFvd3FrUzYyMnd2bk5H?=
 =?utf-8?B?RnltQnF6OGJpNlBUdFFicmpPVWlBUTc1UFE1RjFiOVBSYXkxVXdkanpITkph?=
 =?utf-8?B?Rlp1K25BK1kvMEl4YmplMlhSYXhucks0TnJQaVVIS3lXREloaEt1TlpqZHl1?=
 =?utf-8?B?TlJXa1o4ZXd5V2hhU2dqS2lOaEJjR2huQkRaQkI4SXdjbTdNbXVNVEYyNXo2?=
 =?utf-8?B?V0RPbDJJcjg5dC83dmVZL3RqenJINmw1R1BEaVlQUU13YWRzWkoxMWgrbVJU?=
 =?utf-8?B?ZXhmUmcrQWw2R2RucHRKTy9veVFTbmwyaUNFRHpwTm5aaE5BU3NpM3F4ZnRL?=
 =?utf-8?B?c1U0T09za3A2dklvSE9aWVRzTm04V2VaL1ZDQlkycXFqR2RxZGZvNTh5Mmlk?=
 =?utf-8?B?aGo3dERIWXJhdzF4NXIrYzVlRDFxMmlNUVUzaktFY0c3dHdLN1IzeDdGSTZS?=
 =?utf-8?B?TDQ0ZFNiNWN1c3dzNlF2eGt5VmN0S0ZWbGxyNDlGZGZGSElNb1FGSjhUaE15?=
 =?utf-8?B?VDV0eEdRVXR4THU1Z3NoNkhQRmFpbWpuYmYwc2grbm9zd29GaHNCTzdFR2pR?=
 =?utf-8?B?d0F1SktxQlQxL1RPOWo4VU9EZk9iZWp6TXhyTld1ZTV2MlRkUlBEcHVXOTZr?=
 =?utf-8?B?QXV6N2I1bXZINFFnckkrTThTV1BoSWpqMFhOVmdtT295Rk9ZcjkyZ2dsQjJi?=
 =?utf-8?B?eFBKN2Y3ZmRpSTRQT3lORlZGZ3U1UjQyYW8rK2p4NVJxNlJkT3VDZjdMR2p5?=
 =?utf-8?B?WWozMGl3TmVSZC9aVXR4QVpBQ2dBS1JoTHhuVDR6eGxUK0VLTEJ3SnFZejd4?=
 =?utf-8?B?ampNbVVUSnFwVUJTSE1kNG84dVlMZmF4Wm81SitiT05yeC96RHZHUExKeUhS?=
 =?utf-8?B?T1pUdjEzQzYwTE1ySkRxK09TenFRcUVRbXNxUkFpU2lkcDI3Yi9UWXlvT05Y?=
 =?utf-8?B?WnFuc0w1b2VtN2pvR2pHVGxLR216V0VacFRwM0txMmZxZDQ3a0hwbWo3Q0JJ?=
 =?utf-8?B?L3FBVktEMXdpVnZVbk45QXRuNU1TRm5BZlFlVk81aTY1TGdUdzFlend6R1lX?=
 =?utf-8?B?RERpMjVMNFFtTnoxVnBmZTEzTDJOWVJqQTkyZ0owb254aHdHS0hENVNuOEJH?=
 =?utf-8?B?K1N6U2o3dWVzQi9NUmxHcWo0czg5dzY1RzNvK1V4d2Q0bEFBRk93TE9lQzBu?=
 =?utf-8?B?TjJiVi9pdVUxa2JUQTRIUkZaQjluZVhHdktSUmYwUWhNcUluU3Vzakk2a1Yw?=
 =?utf-8?B?UlUxRGNuNllRZkh2b21kNUZveGNOQms3azl1aStXSEt6Qm9hR1Q0VXlOdTNV?=
 =?utf-8?B?WEdpU0NiV1l2VUszMy90UGU2WXpCL1RNSmkxcG9sYktHeEoyY0laRjl1cTRI?=
 =?utf-8?B?cys3d3VIQUJ3QU9EdWhsTVhGWXlhbzFoc0VmLytpbFFQSmYrbG90aG1rSk9o?=
 =?utf-8?B?a281TTBYTDhUY0V0eDA5bjhIV0ZZSTJSMTBSKzJjektERGkvQS9ReU5jZFFB?=
 =?utf-8?B?S21TSnNDbjB4VEl0bzNMdVRPbkJLVGgwenRCdkowTlY4bkE1WjJyREZXc3JU?=
 =?utf-8?B?b1Z4YTM0Z0ppdGhDc0VKelpEYngzM29LTXBwV0p0M2gwSktvejFxVjA4b2ZM?=
 =?utf-8?B?K3ZSYjMweFhXNHJYWVhVcTduRzBOMWRtZmY1d0xHZHJkSGNlRU1paW1QbTBr?=
 =?utf-8?B?cjVybkMzUTJSWm5YRzZzUnVPZVdFTiszOWlCTHpYUXlOVUNCdjlHYXhwMFFj?=
 =?utf-8?B?cUlSMHBlRE9XaGMyb25GZ3BnVlRSSDVTYXJXYlAxb2R6cXJlaThxSnFaczkx?=
 =?utf-8?B?ZmtnZTV3Q1E4aVdBS3UvbUNTQTAyRFo5aXZUSWM5WGxuWXNRRUNpV2k3Zkdh?=
 =?utf-8?B?NlRQU0REMjRwR09HOG5QSTZ4RlhoRWg3UW5NMlJGYjlvOHk1TlFsRmFHT1hp?=
 =?utf-8?B?QllqN0ZybDB0MTNwb2l5UDhXb0ZReTBGZjZCL3BhRERFZDhWcytCUkhWQ0E4?=
 =?utf-8?B?bGtscVdGY2VNb09oZ2xweU1rcW5ZcnZtcEtla2xGRmZWUGJGaXRPSEtHNkw5?=
 =?utf-8?Q?Fpw6JVFYrGyoSICdCF2+VuMmBp8LIDWhcgutr?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7763b0-11b0-4933-5c0c-08df45b82ff2
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 21:09:09.1856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCEUY2BnlpF7Ajs3CDQiDwdSxtMOdOvLpTeSXVWovQrxx5Teuo0SmoNg5f+aLXKDqHuGVSJqvy7dXyxv696noGnJL6ub3/EDI4PWOnRSF0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF3A2914458

> This problem wasn't introduced by this patch, but can 
> __sched_setscheduler() leak deadline bandwidth and cpuset deadline task
> counters if called on a zombie task [1]?

Yes. Patch 11 of this series fixes it: "sched/deadline: Reject
SCHED_DEADLINE on exited tasks". sched_setattr() then refuses
SCHED_DEADLINE for a task that has exited.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
