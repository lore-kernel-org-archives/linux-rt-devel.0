Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794854890;
	b=WIZ2ZayllXeLLS6JHTDkMa5MYqs+7MYw+dgiIkMVSMTAuuepkGoUKqSVUHiYO8aq/Kkw
	 olLs8MgHfuGdQ2hu/MlWOVlIkaH+tATCunt2qqP6b0XwuDP7cRxlGDnVCXKE6CZtkk8eO
	 SFoM4HBNtNpNUOR0nUCGiI4BaO/F8MAK7T3UV51bw/WMfKHJImh1hny5HYGu7hhPcveD5
	 w0palq5WktA//gwQiaiwOKDf5TmAkXj0Qf3XjSdtoqOXMssAuZADLOlkl5i7YBZGqr90a
	 hhgaoYAnY+41URWtpOlIOlqoZXKWLDf1pRxFEzrU7sKlf1jFONy7NYKMOJ2DQWhHDRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854890;
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
	bh=mD0ekEnszyC8YClnkqpkXRBroG0rF5DOJ4Pq3Vf7Yr8=;
	b=RlRhbix4ooErQO9MaGocri/dm+NnV7RRy0T2zAP5m+XVLMgjadECGyzcly1GGo8NK4HC
	 Ouz83y8yZ2MmmQhK6/5eYpQDRC+LoP/wAUX10XSS4pPSYsYtS61n+ddnTbZO775DrBEFR
	 fu/NNVCC69rOLyYaihDbnPiTAtSPn2s3wzrBodF8bbFYG5IpSuJ+MsgPdSTUkVHTXp7Q8
	 X37JwL7FcdmR+ule2wHMHOinNEKTKDW8FwReebkgPv91XmfhkVWMAE3rGJia3oEAXrpKM
	 4OWsGI1LorNGplX9e6QVJ+dMR4//VJWLzeLb/RooeX7EbxbDy3uovv+pcnvPrT4bYxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=qgqcwzqX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.74
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021074.outbound.protection.outlook.com [40.107.192.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048C606A32A
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 18:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6048C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=qgqcwzqX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsQayleL6FhzMzdqycEjbWToMJPfyP7mRspGH3Ro5m0TRqCYzRmA+Pl+B2Z5J4FcW5xsqndPpJpqLhPED/3K6AZT4BV2+Laxylz7y5cWYUXKXOM0QpijPXOUZ4PP9bQR6RZFj1/JEXXnCNTq7qAzCZIoG+VJUvNSENuuG2djDrtLJ71boKdtmKnBRQ44u7LxH/lYpMDlxmPGP67hs6IXaoWEZiwlmu/6QxDAC+vh6OtyjM6wKvxqKXWVAdzPN9WLX1wAaiTyRG2xASsaPE6rddSGaOqNn1FQP6QPlr7fQHCSGPxxonIcgL2oFGSZ4Ki5xU3Mur3vdKXnCS1DYqPwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD0ekEnszyC8YClnkqpkXRBroG0rF5DOJ4Pq3Vf7Yr8=;
 b=VEmh1CRV3Nbqzv0a8123SFTXSIacZoa3BOOlaUpqHkG+fZL7cKFP/4diJWQAPxDbN4Bf4jiQ4EPFT/S/ENDPW2Pp94NFX/nNMziAMg6Af2vSWE5MFYIhZ6BX7U6lbAF0jWryEbAxFdGNByyvepLHWJJFYwSZevYO7NWzDKJbMMosM35+JSadKgmMaTj0eUdo/Mprfr7StGImvTQ33hNkHBvBVpkc7t1dMxVd34tqfPxCGaMQlwHw8u7i6RXAu033W743Qc3k6GPVvjITvkxPLPxXlBhyPjSOHy7hpiy9mrLpEnPexgFiq3uf6zsLpbCdcp+7t2hBnHyFjqlRMclwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD0ekEnszyC8YClnkqpkXRBroG0rF5DOJ4Pq3Vf7Yr8=;
 b=qgqcwzqXps7G4JEJBjSYFJF95YESp88EoC53ZO58yi8TjA9CkAkxl3kNCxAgQW4ooR5uxRhJ1G8HqSntaZkKriGrakfMB1FzI7sgpI/U2ePt8KCJCa0+G2QUCr11jByD/AjZK2XAYty3mi5pPHoRl+6qJWxEMlkZYZ3Itgda6tGyuDNPt9s+BYQzyBFZD/6uZ9WY+YgZ5ZcVf5vLAmO7/BTH/zjcksBCA2quUSPytMMwk9rDtGCXi+ECJwmtKHfTVDS6Skn78Tn8M3Ij0FkKiZrgJzgqmvcVE9YkT8gFjEOwB9R1HzZyE3M8P1dnIImsMPhjz1Z00z25X+Er957xBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB9303.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:48:03 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 18:48:03 +0000
Message-ID: <c1eed141-1f24-433d-b043-fbcb815f5223@efficios.com>
Date: Mon, 16 Nov 2026 13:48:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] selftests/futex: Test priority inheritance on PI
 futexes
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
 longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 shuah@kernel.org, juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-5-mathieu.desnoyers@efficios.com>
 <20261116165609.RMK-DX1Z@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261116165609.RMK-DX1Z@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0301.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::10) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB9303:EE_
X-MS-Office365-Filtering-Correlation-Id: 1124b3ef-b88c-42c0-8b6b-08df44122541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|56012099006|261026121527099003|261022115727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gAH1f5wiCwiAI2wY1fYPc1tLWU+PiqdLL0zVRgu/OnYw8NQg6pn5VtGMDuEH9UpFRbF5bZSwf3wGDnAsot3WDgMWtnE9/jK/Euu8vRuI3+DCRQqc/gb/SsQo3gN/52clnKmFu+GVaSS8d8DqlIp6zjvWJtg3gaYr9nCVV5yERS42iUCpivWDiUrzwSwmQrxeUzrJDhDCq0SkeQ14vGbDdybgI4PW+EyamBobwUt+OAnFS1rDsBovDwux8uMBJYY5OktS/SOhGvgNxSSaGv1H2KbGfL7vtElSh6Tz+KMChCdnEsoWhScqtwwHRUhSP6wsuL0sTlFO9JIq22jOjqHuKTrBaPfn09447lbeoTdfQSV/DR+eU2ooaNXtqoGpFLQK3pyGqEEaQUMogHK+8n/dYflzFixSqyFrxi8bw63bXsGdQgZf4Ls4zuBG75kDW6eT9UNYI7obaaCs6kGuOfoUhYvX4Y/1islUaXtJLNqPCMmCySaloTq8vSKrl+DGPfB9ifcbgJ6xEEEeJ2bCYbyH1pJXOXe6Dvb1RS5ZQcED6oVy+J6TBaRUiSuvTsm15+87R0Rr/JXgYmVCiuYfrCAXEXubUM9bcxwEEKbj/KeIqP8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(261026121527099003)(261022115727099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVZ0dGp1TUFyUzBBc3V3aXd3OXU4RXJQdWk2dkNDclRwczRNQ3NZMm1HeFhE?=
 =?utf-8?B?U3c4S09oTGRUc25jaUFFUVc3VWZabnFhUFBTaWFhQ3BPbVhBbkdsdFh1WFlz?=
 =?utf-8?B?TmtvS2hHL3RZTXcvSzYzTUJGL3A4ZjN2OUNXN2poTlhiRTRlQm51dm1xK1hV?=
 =?utf-8?B?WS9WWmhkWnR0QlVlQ283Y04vM0RXWjIvRDFxL21CMFgva1RJbnRPM25FcDRz?=
 =?utf-8?B?bUd2Y3hhR2cwLzRrSjZ2SG5pNlJLdGNQYzUvWmJxVzhYVkZoMjJyNXFySXFZ?=
 =?utf-8?B?REJmdnRkTVZxbjNNeHVQOXA0ZVgrN3lVY2NLcVhGU2VBWVdxNUZuNE14SEJr?=
 =?utf-8?B?dmdSVmcxbFRSd2UwZHNjek85MEE4a2JFL1RRandmYkpxNkNWa3FqbVlpL0l3?=
 =?utf-8?B?R2NLQldEc3B5YmZEd1pCRzFmaW5jRGtiN2Iwc2tZRW9LczVrQUtOOHdSM0lZ?=
 =?utf-8?B?cVpRamxWTW9YaVJUam93SXR2ejRxUnVXMzVYdGsxNlJ6d0VJSmtpOXMxT1BE?=
 =?utf-8?B?dW5oN1NIMEhwUzE1aU1pK21DL0VSK0I0K3dHZEV2RGxNblh5TVU2aXdmK3h3?=
 =?utf-8?B?MzB1bHNWbmVrQzZBYUVXMmNtaWdiV0YrSjk1SnBXUWZNOWtIaDZEcGthM2t5?=
 =?utf-8?B?RjRKL3dZcFViUkt2eVhKN1BJT1NabVpKcElZeGFzWE1wQU1kSnVSUHo2dnVP?=
 =?utf-8?B?cUVzMXlaSm5KdE9acjlPeUY1VExNY2oyMGV6RHYwcW1hVHRIaFJkN2FhSlRt?=
 =?utf-8?B?MXVOL2ovTnQ3Sll3U28wSG80K0hVcWo1U2hONVZqRnowd2wzc0h1ajlaWDZU?=
 =?utf-8?B?TEhpM2RrcGd6QlZ3OWs3VXVCa2J4cFFBbmRsK0hkc0ZJdjM2QjB6dDBoeG11?=
 =?utf-8?B?TlJTSjZ3akIwY3pqNU9VNy9iaFdZT2NGNU9jN0hzVnVWN1o1QmhoQWI0anFm?=
 =?utf-8?B?emRYbEM0SytoYWMrUy8rS2FhbmtjUUVzWE5qaUExK3pvNFgyVVJaYXJQQ3Z6?=
 =?utf-8?B?VmhRZ0VZSGxjN2V5TDNCcjBaOWxVV1B2ZXVhVHN4TGRxMUt4ckxrRGQxOG94?=
 =?utf-8?B?ZEoyS3lmRDlNSjN1Z1dxRVVqT2pxeTd3TWJCRnltanpZVFRZMjdEbmxkNkth?=
 =?utf-8?B?d1dFbDNRcEh3M056WUdvczVGTTFlVFlydytxb25MWGVpWmRnSnVqdThhZjBZ?=
 =?utf-8?B?b2ZJd2ViVjdHaGVJQnlqaEh6ekprQUhQMmxraTByYkJFQzN5NHNqZFE3Mkhj?=
 =?utf-8?B?cUcvRCtXVFAzS0RNSTdVSkxNbzJzTko3Z2JscFpCcnU5aDRWNGRlTlJ1S2wr?=
 =?utf-8?B?NytHbjFWOXc5M3owN2toaXpTL1RUaS9QSHVzcXIzQ0dIbHhIbVE5SVRTYzA0?=
 =?utf-8?B?NjNFNzVoQXoyUjNqVCtuVkNXWVIzTVdacjVzd3NtaGY4OTg0NHoxRUIrQVR4?=
 =?utf-8?B?QThVeU5TZE5VQ25zTlBNNTFuZE1IckFoZThoOTFpdXRIdCtrOWhrQjNqV3FS?=
 =?utf-8?B?RlFFdlkwQzJKS1JFaU1MbVhhcXB2andEL1A3WmQ5V1ZkRUoyU3dacndSdFNo?=
 =?utf-8?B?dGY2TkRvalA3eGV3MVdBRS9TZmdybndXNVpCbXRCUUJ1OVU5UUY2Q2hTclpK?=
 =?utf-8?B?OWRCT2tLL2cvZXZzM1ZoOGswVHA0UlJ5K08zMWFod1hBRnNXU3hGRm1hTE4x?=
 =?utf-8?B?N2pEakJmd1N4YUtmdm8yVmFNbldPUXg3TFcyblFIZU51MmkrM2RtSHVLQmpU?=
 =?utf-8?B?Sk9lZ1VXa2FkOUprVnRzTHRta1BzVkp5a2M3WXFPbU4vRURWOEgxM0plNEdB?=
 =?utf-8?B?ekttVnkxTUNzYi80dXJuMENRSEdyNnJ3MGxrK3NZdVlUcVBubDFxWmtWbmM4?=
 =?utf-8?B?dFI5eGhOaGV0YmlsdFpPOUZFYmtYQ3UwQzlZeXcwQUU5MzlwWDIvLzFPZVVO?=
 =?utf-8?B?aDc3UitsV3VHRVlWQ0FITVd2YlU2M1gxQm5Qc2xtZjkzeitrSUVSb0hMQzNL?=
 =?utf-8?B?NGJzc0R5MGEzMGxFS2ZlWFFibmdTLzExNDJGR3grUE1TRFpKTU5IMDlRYWhW?=
 =?utf-8?B?QnNYUTdOZk9Pem00SmtKR01BQjA2bDVUVjF1YW5ycW5sKy8wRWt2KzMzQk1r?=
 =?utf-8?B?TStXaXFuOGU2L0tteWs5eU5POEtlOXVpR0ZEcGlaclNINDdwZ3k2eW8zYXU1?=
 =?utf-8?B?aDdBc1k5SnpwSi9JWW5SSUJaalJ5b3E3ZFVwZSs3bGpLQXNPMlg5cVo5L0Qx?=
 =?utf-8?B?Z3N5Nm5qSUVIQTEzZ2JnWmtXY0VOUGppeldMRHpoMmc5Y0sxQjJCTGZEZEtv?=
 =?utf-8?B?eGxTOHpiaE1kSWNFU21adzZpbThGa2xCSFFSNUUxL0RTbXVNZllQRC9pRVRJ?=
 =?utf-8?Q?/gYjvyX3rR7gn2pQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1124b3ef-b88c-42c0-8b6b-08df44122541
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:48:03.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0X3tPWBiA8P5Yne6dL58orTzhdjsF80xGv6FMm9/o+o10c+sotI1Gunynibowz8kYFPJRnRZrYg/1PimxSbMLQAxcg3Gk7Jyls5yoYUmkjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9303

Hi Sebastian,

> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks. I will add your tag in the next version.

> This breaks if your timeout is something like 1.5s and ts.nsec is
> already > 0.5s. We usually do
> |         while (ts->tv_nsec >= NSEC_PER_SEC) {

The whole seconds of the timeout go to tv_sec first, so only the part
below one second is added to tv_nsec. The sum stays below two seconds,
and one subtraction is enough. I will still use the while loop, since
it is the usual form.

> Could rename it to start_pi_thread() or pi_start_thread() rather than
> just start?

Yes: start_pi_thread() in the next version.

> I can't imagine why one would set a stack size 64KiB here.  It
> shouldn't matter.

It is for the max_lock_depth case. It starts max_lock_depth + 2
threads, 1026 with the default. Small stacks keep that cheap. I will
add a comment that says so.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
