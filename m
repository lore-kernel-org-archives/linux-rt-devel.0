Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009122;
	b=ZK+LeZRXsT0lw9LguU/imJnahF6cb7dI+eCC60hZOrKhnKR3PsaacuGqZvgA9HZDvZZu
	 1s3g8Yjh7njEOTTtRBBbY7IJmGS6qqo7BdNXELeMoiAzqqrrIM2Y0GdeHqpx+R+b0HPZ/
	 Gxfhfhys3VP8QMeOKXQrMIAQE5f79GGGVScEN9hRcJPyvayLtDq8HJF6ntmis4QgOAgmm
	 owNRDuiGgc5ZfozlvjT5YVsgCkbKqXAuHSg12kOClp1sbnz++lDUwRCi2Y74W5nPRXK9Q
	 XINrgR/ZluFCRkSNAS9j2dfsKJWPJ6czASqcBWSPRDBrqmIgEOcZwLHefJKtKqA9DZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009122;
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
	bh=Qw+xXyUmFsyS9TygGRAqPsoYCG0hCK0dQR9lKINCibs=;
	b=kLorzJdwMP8l6NZRdDprTHfGGfFwZtrdqSz6ohJUp+fJcA0QolRerYKDSm1REV50svjF
	 FdoIE7yNAGXLrbWp802ygE9VkG83IR6SK5fW03v8c/g7uhB4XR9rwttgiov8mGVsRHfIi
	 VgGopOtEYkPwiB6/eVriBOEBhG7T2QDy5hKDoUDRykXvjfVYBrL1HDumlSYM7apQT55l0
	 UIRIZdeh2F1Y2cGNk4GndUjVyBsdw0qowsWuven8ws+nHt51vrv+78gvPQzBfRmMRGyUv
	 f56/h0ZoqCoCaT3sT1n9WJhYCSHpY/e2BCxOkdC0GsvHofEgZmIjAjsSwO+VR1UmdnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=J+6UVzkV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.76
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020076.outbound.protection.outlook.com [52.101.189.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB4606A32F;
	Wed, 18 Nov 2026 13:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50DB4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=J+6UVzkV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT5RLzIWXSEMPYzZlt+tJtTaQBMvcCCY4OfFOCRoLXXfYeW4ed/GCPJ1zQbW72HarLBBRW016ybIBbWTwexr/F8yRw7jYsXwf6yy10FY0yX9AkTVlakfshanLv+kLxZdUzU3Q1NNDkLDK6diLe1QR9/XjGXRvyBmJVUXVNccB26sbWnltrVWS1iqZOzIOdTOz0pNoC+ylO02L+fDP2vqhCAeAQDLZnvM/s9RMd8yxBIxfxmx3BspJuwZA/gLc99VywtEQ5mCtjdHyYp+LuYnctFr4M59NR3XYyP8IZ08qrjoPDxdR59ORai4zqaZWq2C2D492gyRA1164HCrCaAP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw+xXyUmFsyS9TygGRAqPsoYCG0hCK0dQR9lKINCibs=;
 b=WL7TyWFShJlaZKfTqjvlz+ryS3xQ+KWm+vuWyqf3ZLi6UbWulwJLUPDx+Eqx1iZBWttrlJbgGzUTw7KRZzqWCB+FeJZzbBcFCLXUoFbRg5h/P097hGnF1yN7PLZny61yGY2waGEBgdkXYmgAgARhzyjg3TUVbSsAaE+C6+mfVb4ublxMVmddF2H3Q6D2G+0tKuN+05GFUgKW/J13FX6aPcKvaeVcbph3r9xaPR5R8x3ocC0JhyWepIN9bivVdP52gq5nCDdXhxkalLTdFKsowjr2FpSV/fE0jkCWfJHzR1LWETQRruKxRaFgriibEeqHfq10r0TX2C+llWtM8cWw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw+xXyUmFsyS9TygGRAqPsoYCG0hCK0dQR9lKINCibs=;
 b=J+6UVzkVRWwspqrJNUCyATVYp+4tKI6VVmVROR/6NuNliu+ZLri9dh0EQsocNc1ynNFyGMIqydB44LFxsGPWUH21bouOvj4Ib3ZyGJDJ4fCT6lpcMO7A4WfYa/mHNk1k2Ekdmu7UaBYlaTh0r8aSFXle8dwGKgdLoADGhaXD9v6QU+HhN3z6STtnwwbFA/czAMaLgLX1OM0nPRXhyAyw1iNm7ox7dhkcyE/3E116n4yF0/0mX0eufs7485E3NpEWgR6YL9PDrAuwnVkeweKysGB3MNSelCWfCPjfOwssTwE5eiBPXzpZN7a441EKs8UnHOP7I5RzKI2PjHc/bX6mCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB9677.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:80::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:38:35 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:38:35 +0000
Message-ID: <c679aa54-3b7e-4dee-a729-103fdccf61cc@efficios.com>
Date: Wed, 18 Nov 2026 08:38:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/40] sched: Make deadline policy and affinity changes
 wait for a cpuset attach
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <7863f1eabf2d998cad9a6abde392e89adaa5fd7c.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219044@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-219044@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::28) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 92bae28a-3d98-4e41-9f86-08df45793ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|261021123027099003|10067099003|261022075727099003|56012099006|4143699003|261026140227099003|261028144727099003|261022105027099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PkQhdweqVL+l3HJJOU/WZ2UdcKqNzvPp7CITEOL9g98YF+WsjFpSDHjpf3jG5M+QTCdkkd6v1BD7kVmCQHM4roHdCr2crb7XEr9xquGTXOhVxRyYCrtOKxl4ki0qsFs8kDgYnV+zOnaUbdKryHfv8kD7ehqO4228G0QUfO5tyGdfolQj35pNWCbB8Ptsv+a3VjoURxcYxSpinc9F+HcQA7qg7ezginWi77Haun2CJ7pI/659YK20bCBcvTMDcQQrcn6syfrzDEm4usf723REPQer/NPdjiJZ0lHMZj8TfaBRYup9D/x55WhKa0HurpWzekZkuzZcDXOIAmZu1wLzYGu6hiLJlI6C1oQt0fXnqBF9zGTlladDT+WdfZ+AzYL/2QvEipR9Ltj6v59cCCVHPKGEgy5q+Iept8bzRZKEGvbYZKHTZYOYXRPVRuEAj9C+MJniSqja1Nm7k6EpC8IRz2wg1fzSLstOrdqJa9M97QDLrWE9S9Il27Z9lmpCHnaTOki+Go3kFCgCpDfnE1VpReJhyuADR517Fe7b/MWeilFrDgbOfkjeRN5NGCu2zstddkMZ2yP/JaWzENT2wCgd3u/jn0X73ZDOlUZ2wqcGuDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261021123027099003)(10067099003)(261022075727099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajh6ejZVTnozczloaUYrYTY2aXRqYlRsUGVXT212RkYyZ0xDMlM5TktiVGMx?=
 =?utf-8?B?TFFhZnBtZjVSZjI5UVVoRFhaZGNxRGZQZTR1S2RUbVNJOHBqK0VOa1FJdGF2?=
 =?utf-8?B?d2ZJMDYzSkxXOFlscGRyZGVZV0VXOUl4N1luSUNmbUJLdkt3QnRUMXlYVXZ2?=
 =?utf-8?B?RG1yR3JxTFJqbXJnUlVtaC82R2YvOTRuT3RVaGhncHNPME5ZOE1ZeGZXMTVm?=
 =?utf-8?B?cGd1TEpUbUcwOGZLUm56emYvaUR2ZHhjTithc1lBTE5WYnIzYkpoK0JtTzAz?=
 =?utf-8?B?SmdNL1MxNjYxZjBsNTdJMVlkTlhPQ1pYMkJudXMvUjdLYml3NFJyTDlJNU1V?=
 =?utf-8?B?UFNVZ2lSTGZSZWFOU213Mk56YjZPWlBmYTNMOTlscitzREVYbHNicXdpQTBZ?=
 =?utf-8?B?clAzR3RmU2FDSVh4YktEaXVneTVDMU9TcjhuZEgzMVJHZHV3b3VlOHFlTWN3?=
 =?utf-8?B?RFdINzR6TXBlbFhhaWtoL1B1MWYzQkp6SFpyck43b203MVVnbjFCL0psT0hu?=
 =?utf-8?B?MmlXQ2kvbXJ5aGhuMGt2Ly85VUtSTHIwTmk4dU9PVWlRUjlwTWJVZHI0Smxz?=
 =?utf-8?B?ekhJUExjME94VVdmTkN0WlkxYzhyUnNpQkdEZ1hzNW1vTHAzc01jNjJ3NnBT?=
 =?utf-8?B?MDVQWG16Ymo4YlMxU3lQSzYvV1ZlRmNEaG5mTkFTd2lZa1lySUM5aW12WWg3?=
 =?utf-8?B?WUpnZmpBa0tIMXhGT2RMbXU2OWFlTXJZUzJZK2N5WUZSNE9QbkpoV3l1RzVo?=
 =?utf-8?B?d2crV3J3MUorc1liUmY3YUtjYVNzbEcvTVhXYmZBSzlvWXNtQm5PRHZLVUtj?=
 =?utf-8?B?UFlhYlpFZ1dmMU9ZaVI0aG1Oa2cwOUZCeW15bWdsOUtxYXQxZWExdHEwN1N4?=
 =?utf-8?B?bisrUkc0dXlSQVBuelk5QmEvR0VlTW1IR1pMU09zSVNYb2t6NkwvZEpyemVu?=
 =?utf-8?B?a1VyNUJVajM0emlCZ3BFZHppSE1Yb3Z2U1VsSzFlaXBsczJNcDlTSFA2QWJj?=
 =?utf-8?B?QzFVWU5ZbXMzTzJKSGVITE9SZjhwaGFtd09jMHVYdUsyTEJjQTVsU1UzbzhJ?=
 =?utf-8?B?MzFGR0lnM1Z5Um44cVhMYXdiVlUrOE1CTEl0K0c4Q1FyVUNLRlZnSjdKZDBq?=
 =?utf-8?B?dWUydTdXazA1cko3SUQwOHFHUmZ5b2hxL05PUDdhY0NDVk5BSmdwM2tVTjBE?=
 =?utf-8?B?eE1sdThhaUF1cHlCOVpIZHJkQkk2Wm1sZ1pWRWFpRldaV2JZOXg5cWQ4cERU?=
 =?utf-8?B?d3JpWkNJNDEzMDJhazZjSDdUeGhrTWY0MTdDZlZnYUtCT3JMY25hRG9oVVBu?=
 =?utf-8?B?dWgwQmZpRE9yM243eHV1c2FHUE96ZFpGbml2L0tkWjFWdG9vVkNLWnFWSm04?=
 =?utf-8?B?bExFdWkwSXhaTlZmQS9WVU1wUmhabEtHbGpTQVNjZzIyWUdYSkprTnlpTEQy?=
 =?utf-8?B?YUNHSm9YWHlOak1seUttM1pVT0ExbUNZSjBhUktsWWRtak9oY2MvbFRUL3p2?=
 =?utf-8?B?RkN3UURyL1RHYkg3Nk5kZDNhT1JDT29mOFNXKzNIWXJpZGlCbmRCTFI2MVVz?=
 =?utf-8?B?eFpaVXljTnJ3ZlRaZFpDUy9jTkNma2M0WVhRaUphS0NZdnVmb2FBR1AzeTJU?=
 =?utf-8?B?R2srV011d200L09rYWUzSUlwTDF1UW0rQTNBZ0NrSDBnZVZLbzA3ZUN2VFZy?=
 =?utf-8?B?eEpUb0t5c3BHQjFKL0pGL2g2R1ZNaGN0Vmp4VWJHakZjeFFrY3R2T01vY1Yr?=
 =?utf-8?B?M01OeXpFejhLbllSNjE1RW8xY1ZJamRRaTJKelVkWTEzM1MreEVJd1NLaVlh?=
 =?utf-8?B?QXlJMTlkcGdUNWRkcmhZYXc3M2dWeVVTQVhyMHFUclJtd2l3Zjc1c3UvQ1c1?=
 =?utf-8?B?U2FKTkI1Ly9oNVhiajE4V3dML1Y5TjVPZ0I2NDc1TVI4MG5nZUZ3aVA2bDVN?=
 =?utf-8?B?Qzh1NENVa05xL0hPVmpaNGV5cVk2MG5yUnh3TnZxRVZvYmwvVXQxcWFXNzlW?=
 =?utf-8?B?b1Jrcmc1MUJQVWtqcUVMWk1qSWhxTjMzOEVYbGFKSDlJNDNEbi9nME01Smc4?=
 =?utf-8?B?QVFUU3FCaVhDYzdHRWczV2YvZlRUVjQxOXphbW9yOTJoMjJVZ0lBMndVYnZW?=
 =?utf-8?B?VFFUY21iSy96WjQwd21vam5ORDR5UjhFZmU3bUIxUlZhOEp5cHNBWDlyeENy?=
 =?utf-8?B?N3JLY1dLSC81N2VrRHBRMk5nOFVRblJKQ2lYcWRNcjJ6UWNURGdkSWt6MUtW?=
 =?utf-8?B?bVVORHFSbUxZQ3Y5b05GeFNYbGJZVFZyTm01cXpXZS9wR0tGcEs5ckJpR2t5?=
 =?utf-8?B?cjRaVjZ4YW1pa0hlTGNSeWZ4T0c3NXY2NDNhVVpabnE5dmRXN3JnSURrWlla?=
 =?utf-8?Q?+kUzkyc0exkBC5fk6bDYy+fEu6fqROvUJZjVK?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bae28a-3d98-4e41-9f86-08df45793ea3
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:38:35.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58KwRUeuaQ8lY2vrwXAHyNI83PMAcpmPsq6jE5jqDvy411NWBNHrdwlxnNdKe1Chm1ffE8cG4NAgolOiAMGoHLI+I//ziJDCkG1DjkHVNvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9677

> Can this second __set_cpus_allowed_ptr() call apply a stale new_mask
> after cpuset_lock_no_attach() sleeps?

Yes, thanks. The restore reads the cpuset mask with no lock. That is
upstream code. But this patch sleeps between that read and the write,
and an attach can move the task meanwhile. The next version takes
cpuset_lock_no_attach() first. It then reads the cpuset mask again and
builds the restore mask under that lock. Every writer of a cpuset mask
holds cpuset_mutex, so the mask stays valid until the call.

> In addition, if css_set_move_task() moves p to the destination
> cpuset before cpuset_cpus_allowed() is read while
> attach_ctx.in_progress is still set, waiting in
> cpuset_lock_no_attach() delays restoring p->user_cpus_ptr from
> ctx->user_mask until after cpuset_attach_task() has already run

This does not change the result. A cpuset attach intersects the mask
with the user mask of the task, with or without this patch. So the task
gets the cpuset mask and the old user mask, as if the old user mask had
been put back first. The bandwidth stays in the root domain the attach
reserved: cpuset_can_attach() and cpuset_attach() saw the same user
mask. Keeping the restore after the attach is the reason for the wait.

Both points were checked by reading. Neither was reproduced.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
