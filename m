Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442332;
	b=oM1rsgXvN3JfOjgEI2Y/+NGgbshIhrieCA/0FCWj02760N7bLv++jr9H9hAKH+vPjGOw
	 BAMBbnjfqA7KKLi1GRHzv6GVbASWozmhMcunThhE+FTJmRE0XSwrcuDFJD+F3aBWzuVsS
	 o5MzLoQ7ExbHqEiOq36sK4jP67OKbP2L8H93wj6gVV6OJDK9FDx/jyXXFBUZkveqdPl7v
	 p/UY7ygwSMxNL8viLhURt14lND2WQaJAZV6xLuqupdrPOclF3BdKSt7vcZHJGAuNwtPiV
	 d9AczK6bx5/INbMdRR7/LKIcUqi7OoMdiyAYO31SjpLG6A+nTrGFbpls5zybU/D06Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442332;
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
	bh=O6U6hRh//qZLEiMKwXrZL8AYy/9m93xPNh1n/OJwl60=;
	b=duByQ9zTlwjdNjtBcuQYLGG7dNjuG10Cf1DxZEug3iytYYyxSlYidgxz6xsek8pe8tMp
	 EzYGBPxvdWWAkKRjyeKTBLjHOfFoHyCrqxp8t2jRZNrxf7WDRZOrlftuZOOerxDOG5zjV
	 m5CEY/9ZaKY/N+wFm1xerOlmKAgHPVCK0c94YpOvzkqW38XrrT86G80hz2sgL+5WCrSVm
	 GUPu57AasPLE86e5XFmBxhAGEclBqMOVE2rYVfa2eJEmj68MmUyzvovIbHDUjBIVi1jMD
	 CnbJSjRp3jpHJMnSFz958M7q9dWCBQ/uJKmKTyfqFiNG88CHMCindTpb0lx/sGUSsGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=S93ayFyu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.134
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020134.outbound.protection.outlook.com [52.101.189.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81095606A31A;
	Mon, 23 Nov 2026 13:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81095606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=S93ayFyu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg65NYR1U/gaZWHRC+maKzS4ZNCgZGmVxMvUINV6rbw2E0eaNFTGYc/5Y4j0ETCej2BWCiusvzGaH7ANSj/t9A3nX9ML1iaqYVNWssqgQGWzYkEn9ggB/3hYDvLTeoL+gil7PzsCtRYF0yg/XnSMpnt7lcGya/U0B6mPQSCns66/YLtWTNWcTXoSAerzetwlYDq7pHno0F3YyDqRZ82p+rFk1PdXfETXVx6dcwf3s/OEt/X2nQ2zVa5S53qazZ8yijF7pVBddABi1GeXQCsDCVt8ei3u1FUYVbVmGgdDRQUNSzoW9yDzCLSZxtnysACS7GG5rc4W70gUJau03yiA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6U6hRh//qZLEiMKwXrZL8AYy/9m93xPNh1n/OJwl60=;
 b=S5S4jBY9FzLdUJO1NQwVWzajuTzkqh+blURz4+p9bFBfi7nxULzHt+L2CXDrtUNOj90AVp2dk3FYfOpDQfzsTvGMUFv8DaZLnPgFUhopSy5V3kupgtjZC1ere4Q7IWRJl6746FsAZ8Fy+FDjoYoCF3rxS2HH/dwR4SLOdaRXqXtPVt4bdgrUeCpyWoaLHW193ohY0nOJivNO26dmUGfRl8NM7FkaqzLc3kAKYmnrCwYPdN295MjmVnZ3sJ+/cp0lQK4hKJoAdKhLec8Ke5J4pG13UiZcr+Ox4c0Aj3dC2fso3jFNXCPuPWzWN/xB5aUYkMvXIdDTwiukZJLKWKzQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6U6hRh//qZLEiMKwXrZL8AYy/9m93xPNh1n/OJwl60=;
 b=S93ayFyuTwY+1YiTB+j68cCANBKE5d+3CPknPUOXpAGmicfCNXqrd3FDc2jzO9xtC365qgEnQBBnJWJUz4ig/sE+wkqSd6/rTZ9cIAV7mU8lux4PIay8PXPmNRKFnd41CsN/Tc6TeETbDJJrQrOf9aenXcCgyk+jQw9j05yPBcYW9e6Br8nG2LzN1lnCQb8ltapbz4KBC9GK4j4BJHFudZYEe9MHzZCJGqMLlWhpi0F9ecE7N/K5snawRxY7tpfqlgFBaRYjGoenndLG8EDSMvqJveh2l6Npy91yP8G4IhxxaYkfaQ4THZtr4OGP9pULdfDcP0iooGcsCO2wx7GB8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB798411.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:193::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:58:51 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:58:51 +0000
Message-ID: <c2d16076-c0d9-43f0-9215-0e946336d3ad@efficios.com>
Date: Mon, 23 Nov 2026 08:58:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 18/40] selftests/sched: Test the root domain of a task
 in deadline_bw_test
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <a0e1f11b56620173bb409d66ade1f44ffd29d519.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226108@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226108@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::29) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB798411:EE_
X-MS-Office365-Filtering-Correlation-Id: fea2b5c0-e237-407f-0833-08df4969e751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261009223027099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	d/Tg9iE5Komb0i8bN98M6XqvQF0Yn9BO2l5uJbAFPBWOYpcE0AFB8877ShYyqVS41WezfgLtMURkoy5oy1WT0LzOcDgS0UjVSQhskUZB0sKnoNDaVS9YnUVHo2KE5T9WiXwVlAH3nvWv7qitiMdj8GVIg4iV1goBHPGyIfaeNqlFpdGF3KRqHHkCkjBPQbEKn1yEAPH5xPbICNZO2FnSGIWGyvP48K+n+GJKSeolwvLHJVZ14nRb55+oBloSwBhWHMqODwdRuBtI8szmejV7ag9/VrDzo30qaRdrqRWQ/fKVh/6nFzDdDu5NwtT0Im5LWJCYE8/xcihmEWBNYSzOC8qirfmHx0peQSqBKfV2oDjRVjgdb5OlQRVrxXtegpgEfEwPtfdyW4ACXW5PaW4Squ+NB6zxfScDA0jMZ8/rGXtoPijJzEt39GVQg6H+bQjvZMREoNQeWtKq2M16UEwdzsxLIeec3CywaWGTL2Zga2sb+2P/WgkaEx43IkzhMVq1kDjseInIVzaMDpZePlmlGKghehNBCVexzXs4aWEk+qPD27uZQxS/LbdhilJfF8TS/s7makIHVjyIiuVFQ2j0nQ+nhMSWuBUPzksL+K8kZE0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0dwZlJYLzRFdnJnemh0WW9Pb3Z0MXA2S1BQejhaM1FRZFQwVWNoSmVaTk5I?=
 =?utf-8?B?cTRQVVBMQUNSZVUyUGdXUWFVVXMzK0lublo4MS9jaHVjUnlrQWx3VS93Q0M5?=
 =?utf-8?B?MmlNNURMNm4vNEJOa2xtc21DQ1VseW9XS2NacFNMNm9CanpZVXNGWFZkS0JV?=
 =?utf-8?B?TVpEM1kvZVZFQ21vSDJ2S3cvcUVMOFBseGh4OWZKTmVzajVjOWlMUCtKWFpw?=
 =?utf-8?B?R0thRmlYR3Zkd3dQdS9VUjJpamFEcm9JdmdKRDArUC9kZ1pjeDQzcWk2clBY?=
 =?utf-8?B?aFZYWlNyOFphR0NMNmdFVUlMRHRMQVFDVlZlSy8zQWQzZ3FITFcwVCtMc0Q5?=
 =?utf-8?B?dDF0OXpZd2d5UEVoWEozNmUyWDcwbldWOU1HZ1dPdHlCckpCUGZRZDB5UVh1?=
 =?utf-8?B?VHpsRFVobytDWlBrNHV0V1NuK0dXLzJVb0V6c0tHUlVFUTNFOEt3QTN1UXlM?=
 =?utf-8?B?SkVBR2t5S0xrUjJpZ3VEdm9rNzdqMHM3WjVLNnBUMmpsTXJUQmF2RFQ2UkQv?=
 =?utf-8?B?UG00anZvcGRHbDBwQlBPRnFBd2VqTEd1cEVLdHVIRjk2TVZ2enk3RjVZVE4w?=
 =?utf-8?B?cjNpbS9MYVJ6a3ZGdUU4L05NanFLYmVzZk5RSHVjUUdoTEw3ajVOcUNxYkIv?=
 =?utf-8?B?SGxzVDZSai9yLzY4b2pyeURLZTRQUVhpN09wRGlhRm1TU2Vkb3dQUGdLVnQx?=
 =?utf-8?B?WDFVYVVSTGc1OUJobnFYQ0xZelRvK2Y3czZjM0dIMmI5b0t2VzhaOEIzN0tE?=
 =?utf-8?B?bjY5ZnMxeVNTeTExbmhnU2ZQOGlUMnFJcS9vVGdEOVZMZEFVODhWdVVXNm5D?=
 =?utf-8?B?WGN2RzE0K2o1a2xMUDRrN1VWNmdUOVpoUFkweHF3MGZTMUxMbjhLVkQ3TWxV?=
 =?utf-8?B?TnM0RWptUUNoYWdKZ29NajR4Q0YrankxQlVjc0JTWUc2VWMwMTB6Q3ZiZ0RS?=
 =?utf-8?B?UFRoNmIyWnBRSUg0Vm5rK0lUbmNlTW5JVnJKK2JqTUhsYTdDNEt0SDdGdTVI?=
 =?utf-8?B?OG1nT3dTZkE0aDk3Q0U2enhlb3YyNTNrbkMyUE1iQzFmQndTdUNKcWFOK202?=
 =?utf-8?B?UU52QmtCNCs0NWlMRmdRamd1TmxGQnhjRy9HSEMxTk1MUEZIM2lqVFJsTVUr?=
 =?utf-8?B?Yk5Da0V3bnZDcUpmcGZRR0JRTjQ2TWhqbE1PaWcybWlxZ0ppbkFtamJkZXIy?=
 =?utf-8?B?THZadFVDM1lpS3JaSEdKNG8vbGVPOC9Ga1ZBSFk2bVhjK0hESFlZSHJOYkRQ?=
 =?utf-8?B?YU5Bd1NrSml6TTk1WVppN0ZKeGs2eUJIMVhzY2V6UXdaZG1uQ1JzMjhEWkl0?=
 =?utf-8?B?VzJNcGloOGk0Qk83Tk9UN2lkK2wzdHFoWEgrNk9rZEVKWno1aGFqSjBDRmw5?=
 =?utf-8?B?dEhZVytxMWk0NzJiL3FTK3VxMEFLRmF6TWphWUM5ZU90ZGhUVEUwYlh3MVVl?=
 =?utf-8?B?dTU2QUJxMkNPbURJZFdTZy96cDlGUXFQa2lOUHJ4eWZoNnRQMTFoa1VFTGgx?=
 =?utf-8?B?Y3oxYmF5RU1qKzl4UDd3clpSMWFYQWN0SkQrTEppL1RkaGFnS1pzQktNdUNx?=
 =?utf-8?B?RmdSZmFjSncrdXNCYzNhQlNMRHFlNXlNdGhEZzB2cHhJQlRBbFYrVkU1NzFB?=
 =?utf-8?B?Tk9URWhFT0w5WllDWXhyN0hleEt6MW4wTXBNdS85SUFPeXVsZGN6UzhHWndK?=
 =?utf-8?B?Y2huNzNaY3pOeURuczg2MHF3Rno0SU9ZV0dVSTBrdEd3UjY5N0QvMWIzc2k0?=
 =?utf-8?B?RkFZbmJ2blJDTjNkVDhZWWJjdjFlc3RoNCtRRktwejBxZGxoUzc1Y1ExRkJ5?=
 =?utf-8?B?NFRWM3VPeXk0VzlWTHJsK2Y5SytXUmNJeituZE1RMEwzejMwWHY3QWVzZFNR?=
 =?utf-8?B?Q3U4dFdBOHZQUnkwUzdSNWJvR2I0N2FPVlVZTEF6c1ROTE1JQ1FSbE9MM3N3?=
 =?utf-8?B?WitjOUxjTjdJYzdSc1YyOG5lcUhmQjdVOThuT3hranlwSTZTYnBWNW5mWXFJ?=
 =?utf-8?B?c2tOWXZmQ3l3R2xhY25MNU5lTWtJdW9id2grQzViSzlzQ2FFT080bnFHYTd0?=
 =?utf-8?B?cEM2WjQ5eWZWSjI4Z3phUC9XbmtoZThYM1RqQ2xENGRMUTY1K2tLZXViVTl6?=
 =?utf-8?B?VUJCWUlqcXliaEQvellEbURLVW5heDRKZzJBU3ByZWdEWXJHSUNzZnpXR2t5?=
 =?utf-8?B?K1Rtc01UMG1Zdnh5T3Zrc0I4ZkpjWGNwZmxwWDBsSkQ1S21JYlJmZTA5d2Ji?=
 =?utf-8?B?UlArV1hMSkk1TEpDb0E5OEs0bDlyTXZieVJuRVZYMEt1bEZ3bVIrelFuRDdq?=
 =?utf-8?B?UitjblVnREFIekVQTWMvVW8vWW8zNWE1SnJkYlVhZ0hHZEtZcUcrNFUwdDF3?=
 =?utf-8?Q?3XASZBM53rIrbwRc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea2b5c0-e237-407f-0833-08df4969e751
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:58:51.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DiLUgG/fSR7tBUr2Z25Fbqpof0XozBrU7DFC4ziEUhbcuHFUtIRVSDPnghGTBgzyd8jFTH7Wfkyi4T474TJ7fqQ2arz/r6l2z17DtSAqSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB798411

> Should the second call pass 0 for tell: partition_has(cs_c, "invalid", 0)?

Yes. v11 will pass 0.

> Should this also skip when !cpu_hotpluggable(x)? 

Yes. v11 will skip then. 

> Should the partition_grows_child_valid entry set no_hp to 1?

Yes. v11 will set it. 

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
