Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795036212;
	b=wJWByukjN+/W7n8Frq3xUhVe5018thbYSTuPxC1iCC4VXFnUAY8lJGzCiE1VqGrHwGvp
	 +Up7+bYYeKOclh00V77d0j20YXd9GquFxUgvDPiL7Ljv3t0pa2bxfHyq+nFXOEWKKrHoL
	 Z7rR0D8yU7JBOZDUTyZjkn+oRFLzTtqtxHsh7dXfGRTPQTu58QP3fXtl/uw1GFXLVUZDv
	 7W87ITj/Z0xLRAmjhmWbsvR6MDhikrpinCY8gNLqSy9ZQ3WBFbkxhCJ6tvTwu/wyNM/5L
	 BbCQ5uNagTyt8EtKIDk/MENbEH9xlzSXUqzlHS3BE+qhURyb6hyVY3iXNvVkNZdHBgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036212;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=bqrHCi+lQeWEDBIL9xjk5Re8M2QnhiL4s4KDcYtts0g=;
	b=gi1TroEcL4Vw4nhovMSkM/TM46jPbp7SjJJVpLQsg7XjRaIlLUoA6+h3WfKlJ35yloCK
	 B6/wnDAZjGKuylRux9+ASdAIoGXSxOjRoU6j8zndpiJO3pfUoT0GS6TOIbDvMnzmENYRm
	 ucoRWPd8Vjf7cSD1q7Yrdy8T3UvsdQjV6UF/X0k+s49SivCN9bGBH6EwTrLOlWkU2MCK0
	 pEnoGlSGvel0Gy5+5rSEJzkeCuImw5LJOSF1YS9eG0h2Sq4TlUatQeR2DpN8wG9xZEPe+
	 +VqlKd9hJLs9IjG+1tTpz4bLn3GvBHqhf3H3h7rhhQYFI+qXc5HT/pmodcO0aRd2mtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=J23pxNOM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.133
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022133.outbound.protection.outlook.com [40.107.193.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BB606A32C;
	Wed, 18 Nov 2026 21:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 691BB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=J23pxNOM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxpei0B7r40khGEgFiFjGVEwIAPhPnL0kFF36c07pS+YXxG1Cccl9x4J6ZnPREBi9gJvU56luqAXbiU+ee0/hDM1BMH1hVc16DL+kcVEvmaE5Dbr+H9oD9HcjrFivki9ut5XzQKsEMTTxQNrL8OuB4kGwQs1G7jOtRZGM3uKPvvAXLFdf++baK4qFwY9SNYSmF9TmxJTWvUmwfkcEBxGvNrUzABj3Xd3dWJG2kDRCO6XO11/pUDeKwmpN1QHcavZK1E80LJmPpMXi1cqveP4kQygMd0fwyyRhAzxaeWHS2VX76r8cYxvqAE+KQPKN+tUrBUT6JC0DaExlJ8OiyAkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqrHCi+lQeWEDBIL9xjk5Re8M2QnhiL4s4KDcYtts0g=;
 b=iwnQG+0jzxUhYRVYT2MD5sFn/N+dLdUSrov6qjQR8tu193raIm2C4v4RbHBMxw0Wk0sBNVPfDZ9C26aUwj0QqparBIps87LHZ0uEFuhJCEwRUcLjmngmLIbKk82R2hW6AFwt6KhaXiBNYRtowE4TjMXgo0ycSxqXsV7CoQK4GXXYn2E1+PvifgINziBWEHh8Z2TsamCzN8ayg3ajFkHG06aCixFLzkx3qaClXpbH6fjONc7FjTbDLdNRkEV7Ys05TPQgiv7JZRfCePibSD6pL6DzDRAhJ4N4pMOFZvRIIS+rHAimrLwegRvJvKT6iipRx9L2xZ+ejgk4wjCESNrnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqrHCi+lQeWEDBIL9xjk5Re8M2QnhiL4s4KDcYtts0g=;
 b=J23pxNOMoFhZRyaugM4dt7kpGho/5shjjl/qLUJno+M3Xi6UtsvYpR38PJqFD0w3PmoP2Fix6MT2u4TQE+wCUorjXLIqhLQhhN1tU0Q+clOxCCIMlTrDm/IdHlKnOhq2oXePr9JDpEi2nQuNadCi3a33lTBrN80YvmnWazPCsetSHKr/q3MxnrcE1jYanbAfbaOEY3e3Dd51A/cZbveS7Df8q6xmaSvHTOewSt2XWbWC0XkV7OnzyD7WiRxZKQuJoPVtVBzsaQf6m07w3VfqLftweELyniaia1d1DCSIoo2eNSXFknI33KxH/BkYYkqDjTNLp5ceGF6yCTPC1hsWOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB9803.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:8c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 21:10:08 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 21:10:08 +0000
Message-ID: <dd618c1b-bb43-4406-bd8b-0468a131869c@efficios.com>
Date: Wed, 18 Nov 2026 16:10:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] sched/deadline: Do not replenish a boost from
 cleared parameters
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <ae7a53ee206a422a9debf0cbbeb241c8b233d160.1795031605.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-221939@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-221939@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0190.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4309da-f3c8-4196-b32d-08df45b85355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|4143699003|56012099006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3SQqQGaTB+ATb82NUvOH86wkgDPit3mTFJ7MA/sAT78+UCIETUeFBLimCARtuYpm6n+kRZNwejLD84tB493lDN4rhovR+YwQwPIkiFbA6ItLxAT14JcJpbYbQ+u/JI4rbuP6HyGVLd0BUtYlNCBT+2FwvY8oNq1wVZQtXg39xPb439VnfYrGML1enn1aL73oTJLMbydn8xUk4TG6dmgSq+TMncvZwYk6zyKdoDWey+h3YjT9xS1E6BSE0p6JwwcO0r0sNI9rmWYUz8O+jqtwHcJGQDjM8roIgAbK/iwYlnlkR6RZ0nAvbTXJwiu7JU6/6tEOI/9tI8GxOgTOMfcLm6hSoKC/ACsmB1bzN25JkDiePI1m87ktiq7qEClgm8VjUYS84wpL1BkM7XCNrOyPJwDZuYpIVgoBy/MYLe4i2kweHxdQnFUXIRZxia5EXAjs52RuKiCXz5qxEXVWUFCdH2IMnVKxGhBD2bOLyzuHIFTiS3+WTt/BpK5uK7O/XnRXhdgQfxTkoG+9wjotH1NpG0AAEVgnTSuzhqEwcVVPCw+EcQNPexe5tnzhP65bif25HqPGMjnTjFiKXuRqr3D0PSIHGkqdGVf+RSMReZZ2xoM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTVQYkI3ZXRFVGxhM1pVZW5xaml0eUFnOGl6R1VONjZBRXZvY3R0WFlWWERU?=
 =?utf-8?B?M0ZKUFJrelpadmFjRFRwekU3Vk5TVzZBWGxzYmdRUnFPZ0ZDTWo4MHB5QUp6?=
 =?utf-8?B?TWpPeVB2c0RHRW5tU1hsd3BPOE5Ob3dIdTVEZTRrcGpRNS9GK2dQMy9tQmpL?=
 =?utf-8?B?SUg4V1V2L3U5STlQU2srU2lycVF6OFA2bmRKR1p4aU45NThwU2ZOVUpBYXpB?=
 =?utf-8?B?c1ZwTDJDL2s5T2YrSnZpUUJNOUpEKzgrSncwcWhDYkFvRUhkWGM0T1J2ZXo1?=
 =?utf-8?B?RThRQUpRbTU4dXhXWFhmYVVUamhUWUx3SzFudCtseVB5NG82amYzVkhPSnI4?=
 =?utf-8?B?WnhDU3pmTDkyS0YvR1lFMVd5N1dJOE5kQ3h4RC84bFBseURSczJXTmcwZkwx?=
 =?utf-8?B?UDg0SXRlUHdNMVhGODl6QmRpb1pEeXpHMHpWcVNYY0U0c3R3Rm9YWjNvWFpL?=
 =?utf-8?B?aHlYd0NHMlJOWjQ3cEV3L21iZ0RFeUVVNmttSzZkTG1rMFlrdlJYdDZLTWJM?=
 =?utf-8?B?SGU4c2txTFBXSWl4b2JtQ2dYZ21kSGtRSExGTmVNdzg1bldHendUeXA0NHdp?=
 =?utf-8?B?S1dwU2o3NG5Qc1RORnZUOGs4Z1owMGl5dUh5VWVtS0tNaVg2SXd4R1J6eHda?=
 =?utf-8?B?UnFTMW1jQUlTUW9uM2FXVVNqeW00QXN2QVFjcTU1UTdDazg1Zk4vQVphMzZQ?=
 =?utf-8?B?TmVjYVNmcjY0NDIzMEpiT25XSlhtRHpFSUxSakVZd2MreFQ0QnhGMnJBQmZz?=
 =?utf-8?B?M2dERVZjZG54WGVuc0c1WnRGV2d6MlhFZHg3M09YejBVL2FETDVFckYwRXlr?=
 =?utf-8?B?Tm9uWHBHWUZNY2h3bXdKQW14ZFRFNG8rTzRiYVY4aW9rUE1hVHZRblptNUpU?=
 =?utf-8?B?dEJTbWxTdmt2RWJQQmRoaUphUEE2aWFITzFZSzZyamdYeGpnYXR3U2lIU1F6?=
 =?utf-8?B?Z3BHTVRpYjEyRTlpcHBwR2M3cU9IV2kvTEJ3Y3A1cjN6cWNEQmZqbEN3anhn?=
 =?utf-8?B?cjBjVGsrRHlnWjRRc1ByU1kxb2RaUjRnVDhPY2gwR1BFaC9OcnB1QWhjdks4?=
 =?utf-8?B?enFBeTFScUtUWlhOdUdrOHBKSVA4ZW04RHNWQjd6ZERqbGZGNG9sa3lhYm1o?=
 =?utf-8?B?VTdhVnN3SS9JRk5vM3loRkdhZml5OUpMSkJhbWJOYkNCOWtkNmo5ZTRhR3A1?=
 =?utf-8?B?aFpvV0hBKzRiRHVpaGo0cTFLRkd0dldlT1VEM25NYjBWNU90NGJtWDVQUXJJ?=
 =?utf-8?B?cHZyOGlYSFdRMXY2NzJQTDlITVE3MnJaWXgwV2pMUTNPYWNSRzNOZExMb0E2?=
 =?utf-8?B?YXBjM2F6SFc5cDBrUk9SVWZzczNRcHpxcHArV1hVYXdGRGNScnNERTR1NHF1?=
 =?utf-8?B?Z0cwdHlQNXdRV3NnWUpUYVluVkwxZUpFczJiaTJkUmswSjlqZGg1N2hROGtz?=
 =?utf-8?B?dkM4NlBlQVhBK0E2cmw5OTNQakdhaWdERkUxaTJvY2EzUVljc1d5K1F4Z2wy?=
 =?utf-8?B?QVIydXRxVEpEMDhVUDRQNnloYmI1cFNPc1dCbHRnRlFMZ0tjazFDM2NHU3or?=
 =?utf-8?B?Q2labllDbTJCamZDTnlqc29tYnJtNWFWQnQvcG1DR3VNTlM0TUlVRSs2MTI1?=
 =?utf-8?B?ZHIyNXU5Y25mcVlaL0tiREowaFFaUURXM1B6NmttNUd3U21lYWtrVWJSR3hn?=
 =?utf-8?B?UHpvaDJoNy80bnBHbmM5QjVCV25yVjVjcm41ZmgxbXUxcWtqeDNQL0FkeENs?=
 =?utf-8?B?STg2OUl4T2hIR2dGYTUwbjJRQnV5eW03N1ppQ1VvbVNvTjNqcEcvZDNJL2U4?=
 =?utf-8?B?STg5d2haaGwxMExkKzVRWFZNYlY3NnphbWRZSnhLektsU1pYcnY3TUQ3Ynpo?=
 =?utf-8?B?NytSM0NLSUpudUV6RkZwTWp2aVZhNGkyVGxGVmwzL0lSUmxQWWJGTXp6L2tx?=
 =?utf-8?B?amE5cDlhUHIwNnVWSHhXMUJNU1E0clRtbDJIYmM2SFpZTlk1WmQ0K0pTNVN5?=
 =?utf-8?B?VDhSWGtDTGpnUDMwMTZmeWJ3aHdpODRGRGYrK0czY3gwbE5ybnBLc1lFaGda?=
 =?utf-8?B?WHBVK1ZXMmVMVEdLWHV0Z3ljaEhIR01obTVXMkR0UGJPSjk1Y09taXlaUjF3?=
 =?utf-8?B?a2dFdjBRUEc3cTNTbHZhRWZEaHF0OGlsQUxvZXdOSjBIaVRDVUJ4c3ZvZWFh?=
 =?utf-8?B?cWRGK0g3aFlQbXoxWFRaLy9kOWZ5aUN6cUNURTFUbTNPUHhjQnNWeGVGWktm?=
 =?utf-8?B?UkIvdFFOUzBqZThtU3UyakxRdFVOeG5rRGlSR1FTdURNRE9UREFvREdlT1Uv?=
 =?utf-8?B?OEczWUxkK0ZLMGxGWkMzdjIyNDFvejI3ek9sSm5CK2ZNcGpXdlpKN3NHUFdy?=
 =?utf-8?Q?/R16N60DWZPB815x9LdwqvNV1adGsSfl6dH0i?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4309da-f3c8-4196-b32d-08df45b85355
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 21:10:08.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d69x1gxNj5ktz+bCG4dD1jXqh9MLNghK/mOVqe2gIgQoHWXb116/q+hv52Zyw3wnrTuLbCT4QAbT5CQLosg8gBWMoinaf/IDznul+e+GL9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9803

> This problem wasn't introduced by this patch, but can pi_se point to a
> freed task_struct after a nested rt_mutex wait is aborted [1]? 

Yes. When W aborts its wait, remove_waiter() makes M its own donor
again. The sort keys of M stay equal, so the walk stops at M. "rtmutex:
Continue the chain walk when a waiter's deadline donor changes" fixes
it. It records the donor in the waiter with the sort keys, so the walk
goes on to O. It is in the second series, which applies on top of this
one. Its message describes this deboost case.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
