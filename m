Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009421;
	b=V//Ct43Qf4hl4KZPZXD0jeMZklxgKepYWCCQ06UTx+UnyLbLZcB8CZfnvfx+ygnzIJJv
	 94w9tT5wYxwzPD67hYBin5hRhIT51Fu07GCcqZqhpH05VV9iseNsSestZvolquPUsQYMV
	 yVJcZ40pV9yeYt6p0eZ1ichfptLdlm9zBwA2viqxkFPWz+owo/Vskvasulykd7fe95epd
	 B0wSq9KVRh/PgeHReu9eAwET1/D9TFXfJxbqYTLb8ENUraaMLr2cF1MkHUlGin4nngoDa
	 2Dgh/7T08sS37vacCp0BsumGgq0r5vPxkl++527cuGvTMQhMhcoikFSqaIBvKPq7UrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009421;
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
	bh=jr8rdrIwnHMqy0xL7Ixkjba4yxagVKTcmGYa/UzbNL4=;
	b=v3a97ZwBbpWxAqAZ6904Eu33ridmDIp+E805D/9WH8ZjN82F0BNj1u0SqC1HVkCHr7Fr
	 E+O/sX5fcm7F9zsXGmApHYAwOo+NbtpXRcn+pk/U7FJN779toF+F2ak//EoVMLEXTrHHm
	 0VxcEgJaelyX+wF8OTJqR0jrkaqosPb51wXgtVDffJjnNmQVLltBtxmXfamcn6GlHQWnP
	 v2RzONyqWABEMckk96Hx4v9jcCkQbF49Iz1USSFZWSqgvPffaXIJbfOMBMIUjk/hFvAhX
	 R8hwvlZPk+8Aw1Ri46dB/ZQSPk5L+yZaPAZhz0+5jnDcOjFOJDIpVsHvl5oFHaUxWRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=D2tZBW6U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.134
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020134.outbound.protection.outlook.com [52.101.189.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364E6606A31C;
	Wed, 18 Nov 2026 13:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 364E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=D2tZBW6U
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXDTzwzpZIsRQo5u40txtbC90RzmlUKIvPZaL1EQuQqJzTvnyVrU1nrRXEtEVbTriOG84YfUDaOnnjGJJU8la91Q3wE1BPEY0K/h54CXmlzVNayghOcHLd7rCbemKr3sPVNUuBytH88KlppTbhKlUYcTQosT/uuiiAmgAWR/fIfzsnDrO6UJFt2v6WGtdy0HoZmdPRFUqR2ALLb4NpjqNBAbJ81t3djT3yOnYpBmnBy7OqMWj1j/lkakfJ3iAgbfEL0SQXs60B8N/LJ0gnTMNQqDzNF8GUoicbKaTbIX4n2hB2aAdjv/81ifL8VGFky0e3WXeQIV9KUtQWiMLen2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jr8rdrIwnHMqy0xL7Ixkjba4yxagVKTcmGYa/UzbNL4=;
 b=me4tSu6ZkQBy60OC84hCROW8o6gwsu0SxMmub6lMmTbdwtNAZXLhTh9M4TXINiEsSi9nVz6quHzYAK90riXGaZXLG237JL1CITuB5pe0k4MGKo/cT3EBVsb3xWSGUpeLlPyM3F0H2LtrEZktwEcxv8pfpmy9HwXrwu9sm15oWCjYj6w8nxTPjd568BTVy0BlY3TD1NxuuDHJi/HUjxp8Lnv4JhkJMQfW6f1+/3R067LOBCi9EpJPGnsZVmz2dBSeDbSMBrOSpXQDra0OTaq4lFao0qImUkFzGbGIWmuUJNF1haPvll0VkqILGRiMSMcKQeIwWaym0Yl4ZAcxS6rjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr8rdrIwnHMqy0xL7Ixkjba4yxagVKTcmGYa/UzbNL4=;
 b=D2tZBW6UEmwF+qmQg45B9Y7PCzTYbhbOdMgW8aRKLBSQXY9BjLahB4TvcE+gVjAGRRM4OOXCeDsiYPu2MnikbvPb0VSeXhowY5FpwbyqjpI97MKeMjHogBognbKt7CMV5s0yvBtTCXfyM+fkREoXp2QNS/oRd3M3EkVV6uxELS4t8ndKRJdI7UsyiRpmSFmSW2jQljTcU9dVNu65IgL2jd/e/raQMQ98g+b7AJwtT3GkHCRac0eTWvsxsnRdq7g50QC7JYW/ApwCK6rQGPRY//kQw2hNncgLdmmS1CUCxtacVIpMyaemt2L6VHTRpWPbZcPBz3kZ5TRD8UFvtCkOjQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB8248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:43:31 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:43:31 +0000
Message-ID: <a8a0dc12-ab90-493e-90ab-c88309591b1b@efficios.com>
Date: Wed, 18 Nov 2026 08:43:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 38/40] selftests/sched: Add a test of SCHED_DEADLINE
 policy round trips
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <eb355ec19fcfcffd3e7f8dbd79dff377581a7a87.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219058@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-219058@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 8767eb40-3aaa-4ad5-a90f-08df4579ef16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|261022075727099003|56012099006|4143699003|261026140227099003|261028144727099003|261022105027099003|261026121527099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Xv6t5VglEGpT65wIldVwqf459SH3XNY6PaHI8bdkLi69AVhhPeeMo8FDguK20skR8hzk4fNxJEnaUFUE9C63qgeBuNzMl1UNR4vWEH9vR9AnfrDquUC/stXc9vmGS5J/qOdCNzoqcmyXQHuOTwLPrIQ2L5K8TsD12P5Ck/7OM+tDt+q4nKsfXhmqwumaVuJB+mC4k8RqhWMHVkbGOkcI7BzHXUN61/Vxx5E1UB5dgPY6aA261xLzrHoObdV/JDokuGOojbxfepNOC15mRLdrkX1EEETwHlFb/uTVakmR9ZBgOKKMvVEGnvpeXQlvm40+oZ0a19fG5GdZLNv3jZk+7ar9s6hlBkfWTXVhePI9lof4S2XziGbbz+IR9UlYYUsSr7RWAKED+5KdixG7/JxQEuUHpzFhsm6rfCqMVnXSzKb9zVBU5tfUH3wva2/DwuY/NbZzLVSR8GZ9Cwo/tsr7IHwkznSbSsq8hWdrO+CNZXqSh0JmtSoMowsO1Tm0IdFNocHZcTorSec2BvHuKZLCPse013+vAfR0RZsdOLhg9yzJ0TqEsWT5TIKXE1DQnTKgWzOqeMtF71uIGDRlCPIsn7TfostlsP2rWKS0h1BUdFw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(261022075727099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmIrMUR6d0Y2endFcmJqV0Rpb0dpMzVka1NvL0FyNTd1SEVYZjFQTkw5NWN4?=
 =?utf-8?B?aXZiZ2tiZUZBbVduZEZ0ZDRGemZ0UmJQMm5xbTlyU1dVQ0lGUGZRd3ZKVUta?=
 =?utf-8?B?Vk1SU2NUZTNUZHFzNHBtUGN5Qnc4TWt6aGx2TDQrQmhpY2dNSFpCOG02UjhQ?=
 =?utf-8?B?ZHUwRVI5ODZnM1BSeTl0K1lBSnNOTlo2enJ4WTFKMGI1ZmNRb3ZSdXNOS3Qv?=
 =?utf-8?B?SFRuZzFNVmxBL3VRdXRncWlsejh3MncwRU1tbHBySHJBK24ySjRWaXVsZmJG?=
 =?utf-8?B?UGZjT3JnYlcyR2pGRWNJNFRJVjA1ZEIvNEFHWlBjdHBVZHVYcUhrVDIxYlFF?=
 =?utf-8?B?cVdabG9MaVBlMHAvcFQzUlIzSHFuOWlaNHMzb3BLRFJaTnR5NG4veDlBOFc5?=
 =?utf-8?B?N2VzalY1ZkwzeUFrbzZqRksvbG1ISkRoTEpkZHlIOVZHeVhZb05vWGhiazQx?=
 =?utf-8?B?alMrV2pUcVI1QVFTd1R5aVRzRXFZZGZ6d09xeGRacmEzYVpvdFBRK2IrSzJK?=
 =?utf-8?B?bXlKanJ0YXNiL0I1a3VCWWZ2RjVJZUtiUjlobC82b0taNmFMdGUxbGNvejNz?=
 =?utf-8?B?VXlWWXhnbEFONkorcXc3eDZYNkN0akJWaEVTdzdrYktOcGZYOVJiNEZkVlJP?=
 =?utf-8?B?cHdYMUxIQnhSNUx5Ymo3T2xxUXQ4aFZ3ZlpxczJUOWlnM3lIT09YWG1wYS8z?=
 =?utf-8?B?Qkptc2gyNmlXN2xvSGNqSit4ak5KUWVoalcvaVpjMTRKOElTUUs0Nk8wU1R0?=
 =?utf-8?B?MzZtSEZFWERTMlVmTlVCa1h0RUJMZTFOQ1BMUXZJaGk3eU91TE5jVEhBaXpY?=
 =?utf-8?B?anNnSllaNnJRUHpGcHZMZytQNHN3ZWZPbFlqRFJYNkQ4aHhCMXlWMzF5ZWFP?=
 =?utf-8?B?SXVWbmZLelY0Y0gzY3lrNVp1Z05CRFROTExxTGowUW9BZjBoYkk1YTFIUFhn?=
 =?utf-8?B?cWc1aGVwV3RyTnc3bzgwY1NabnpqYTdtMEhhcUJ3bmhEajFLeFI0TjdvbHJh?=
 =?utf-8?B?M2d6Qk5zaDJ5R1MxM2RRNng5SVFzWForT3ZsWnBjbi9PdWFlWkZ5aXM5WTRN?=
 =?utf-8?B?Zk5lVmhUZFRRdmdWbWY5eFBpSVFLdThYUFUxMzdQdnRVNkpUYVh0U2w3cE9B?=
 =?utf-8?B?OUpyQUNMTEE0SGRieVI1bGxOMElSSTVrQ2w3cG9aVklxS1hkNEVGcEtHWnd2?=
 =?utf-8?B?RVQyenpNdFRNKys4L1ZkdHpmVy8vRXhibmEySFR2RmFnbkJxRkxmTW1abmxz?=
 =?utf-8?B?cDJUcHNqanAwYlU5ME5ZUW1ZOFZ2T0Z6SCtmelJZNk44NlY2cEMxdE9WVXNK?=
 =?utf-8?B?ZS9qMmMyMDhsbUw0T1BjcWNWSTdEdGVpdE5YZ2VrOXNTUzlBRk9TWXN4Wkp5?=
 =?utf-8?B?MEIvWXdpOUsvemwxUFVRcklBY2FJZ3hkdmtxRWE1eGdjeHY1U2N1KytDb2l3?=
 =?utf-8?B?VW5kQU9UdXRSUDlaSWlCamRxRWwzRG9LbHBnazF5WHBOZ2p6TzZhRUMwQWxX?=
 =?utf-8?B?cjdJdzVneURJNENHZHdjM0hxZngwUk8waWFXbG9LM0xVcGV6RDl4TEVVQnhZ?=
 =?utf-8?B?WVdNVndzbndEdkM1anVpSUFHeElyWm5xa085WURtRGplNkVPKzdkZk80ZWpk?=
 =?utf-8?B?NU9jbCswQklMeS9CRlJ5b3pOeHNVelVUTG1RSmpwOXZ5SzhzU05BR2k4V1dz?=
 =?utf-8?B?RnVkZTdGOFJ4QzYwL3dsNEVyNnB3a0RHZmNxZStQOC9OVjRtNHcvZVBkZHFK?=
 =?utf-8?B?OXR3UmZuYldnd2JSNm80UEJJOGNMcUxRQ3k4SlZjcGlINEdsOG5ML3c1TFA5?=
 =?utf-8?B?aG5sQXQxa3RuWE4xcStRenRRU25qYktrWlJ4b0dMK0RFVTdhMk4wVnVuNlhN?=
 =?utf-8?B?TEZvRlFCOFU0ZThHRElPM2x2YXp4eU90TDdycUNPRFI0WWRFdUFNQVJ0TDAz?=
 =?utf-8?B?YXNSSzBHaWlZeUZrQ2JmTm93a015WHpDWlQ4dmgycGxsNTl0K2RoZVhYRlV4?=
 =?utf-8?B?UXAzRVlXVjVRT256SktteUdpaFVjU1Jhd0JyYmdtOTQ2d1QzRWxTZkljU3dK?=
 =?utf-8?B?cUN0dmp3NjV3V2xpSElmaysvdGdaYUg4Nmk4LzZXMVJtbU5jME5xV05aOTFN?=
 =?utf-8?B?ZlZTcm9nRWtsZitkb0RRL28vbm1KcE1qVGREaUQwWWJ5dWhhOEI3dEFVRSs3?=
 =?utf-8?B?NDl6SjFJQzRXNnZRQURUVVBUaWt0SFV4UVlqMm13V0Q0WXhsZVpGSTcza1li?=
 =?utf-8?B?T1JtaVFnbjlGZWlzKzJnTnBVRlcxUjg4U3FkRlZSa1A0U3BkenlJUnltNWgv?=
 =?utf-8?B?aXgrbEpJVElMUnZsZ1JPWkg4Z3pRa216MGYxbjJSUkxBQ1EzcmJJOEZyMGgw?=
 =?utf-8?Q?24DeyVpkAmDL/UlBqylRvHEnti6ZqfWaKPFXt?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8767eb40-3aaa-4ad5-a90f-08df4579ef16
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:43:31.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: je+xFXIdB5UjQ/i7v7IsAsbVyVTpF0BzADR4GIaFelFPiDushM35j5esNdQxFsfmr1ZtP+emVYTBHVcfmJ6ob4rnikahblAN59pIIC25Ruw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8248

> Does pthread_attr_setstacksize(&fa, FILLER_STACK) fail with EINVAL on
> architectures where PTHREAD_STACK_MIN is larger than 64 KiB, such as
> arm64 and powerpc64 (128 KiB)?

Yes, thanks. The case then fails in its setup on those architectures.
deadline_bw_test.c raises its stack to PTHREAD_STACK_MIN. This test
missed it. The next version raises FILLER_STACK the same way.

> Also, pthread_attr_init() and pthread_attr_setstacksize() return an
> error number directly without setting errno, so strerror(errno)
> reports a stale errno (typically "Success"), and this error path
> returns without closing filler_pipe or destroying fa. 

Right. The next version splits the setup, so each step prints its own
error. It prints the error number that pthread_attr_*() return. The
error paths now free what the setup made.

> Should test_sysrq_boosted_owner() and test_sysrq_running_owner() call
> sem_destroy() on owner_locked, owner_go, filler_ready, and waiter_go
> during cleanup?

Yes. No thread uses owner_locked when the second case initializes it
again, so it is harmless in practice. But POSIX leaves it undefined. The
next version destroys the semaphores at the end of both cases.

Both points were checked by reading.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
