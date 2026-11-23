Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442396;
	b=1sNyBJJtxLvH1Mgjw6lj9DMKxGz4PDqYXVJ9+EKPaiVLsrgu2y/ezqMKz6kgFFqWNCd3
	 erb68dOMnMTY7lara8BTCmFYISsv9CT1zZlxX5uiixR0T5Hn9IYXZDtziBVs+PGlZqBbT
	 Ix7S/s3vTexHnWWB9VE7tVOFww0OgJ0aqYXJjtlJVRAzsjFRLvrhNHDcrXwcbCE48Mu/E
	 VC5mlKhWvhPVVY6lxGQvGDg3fPyG4ZdIxy6hcz3HGbEn8Kd7Rn00fod6SssudBF2flIP9
	 yK3RDRluz2tBSA+Papz9ctCoW+YFF4LXdcfWA7d8UEEdMXHGOcCAioJHyxtGOnQ6PJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442396;
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
	bh=TGrIdYTJoItW1yAgFtDw6K8HXQRTTrCT5hRS8teyozU=;
	b=iKKuTLMZbdMu6/wKC6s4zJHiSKT3sSwJayUzirlIf754nbownoJP33KiV99O1GH4Ce5K
	 ZhAlvcgeK9jeXhRNMgLqQ3VjqLyG6fIPiz/sPhe8ogh7l9+KbfZpsvk1snBJifOG5pI2D
	 8nAytvyaSShrmIRBp4f2bLR8+kspAYJJM2CqLVqjmTB24WX48gCIn5+7yw95m68mUZslQ
	 na353itPNEm1hTJxIdRUCpLHFQnzRq5gZJbUvZL6x7dClTCqs+9N6kxxHPv+A+QlW5vO9
	 Wbgb14kxJBt8q963/+tPktDSv7SDvpVpd91sAdLVEiLtjFLqlcpgaPd4U52+tyIsQuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=R6b2tNFi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.121
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020121.outbound.protection.outlook.com [52.101.191.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC0606A337;
	Mon, 23 Nov 2026 13:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FBC0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=R6b2tNFi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkJliermXFLGQ7E5c417qOWcVduxe8EDn5WB2tVbvU4gAHz1CsifDUKNdEUAEIvbwU177U3Z65t578Sirb6WOkNJEDq/oUB1H6LFyZh1vdlvWLkiVzVvjGPIp7Dw6IMEoavNp1/DYIJVAu2GkCul2XXb5YfQHzLgtQrhFH7vrKoLWdvj8HI9aDhKgiygi8SFGCcQkzOQPzaFfzUPT+QbjljfCpHZ0zv0de2Siy/kdFd7Ke4WDpldKDOo48NL8m98nwWhfHGbYAi5Nue7zGRAO7XvJGpT1GgMMFRs9i6cMtfm13Wg+H2g87OJ7Rghc2iqPfdmVWWbOB7adC0OV1Pg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGrIdYTJoItW1yAgFtDw6K8HXQRTTrCT5hRS8teyozU=;
 b=H7ErqGoPX4pQ+yM8OiCxlklxVY6Vr79WhW8boefECqJzpaVxqaXQjHJTmmvUQ8yYms2SUBPG9qqu72taxHNwzl8ILZTrAIhfvGOyjncSX9bwkZpAlNa6taHDQ3GKbfWZx2Begtb6w9+jZRq7xoINRbfNXTIsqETgtJNxCl9Axi/N0zbQs/VZJyf7jVdNXlL0JFpJPPGkd6xMa0K6Tu+CosvJmQIWlFmsbY1sAG+HyZgxEYxZRSaPDdfbNS9hkHUdggBR1ro1TdRoVQ2QSxySumNsGb7NGuvhleMEwk+5uw0wiyPdjpsPOGzXHY9S4KkRVRTbNsSzh1gTwMiNJOuXVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGrIdYTJoItW1yAgFtDw6K8HXQRTTrCT5hRS8teyozU=;
 b=R6b2tNFiU+oY+vGJNY8H5p+AE9kUVV7i9FlzA7PuWKVOltH583wMWbJbmx3b9FZ6OqaLnMW1luGlse6rIY4Msv8yVA4JWQrxXu0NAS3GjN2MfgAzlommJGv8l9Mmb5BHvOlACLRT3FkW0+ZF9r4g/CBHgfsodKCbqM7Dr49mzcFR3op1Y7w/RF8wx8br14oEAnSFD3yT+BFzrRvLSVz6vRuT2T3Ocll3WKZaA6UaqG2SKPMF3sf4pRf52udajKrz8ZLsOpSdQzyP8BxypW4SI1ourQsSXcbXeAQkl31lBXtDYxUt/je4/gPFQ9f4pEMuB9s2ZcQxk7ZpGkbsF87Q+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB452843.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:18::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:59:52 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:59:52 +0000
Message-ID: <1934e37e-c061-421c-86ca-4382761657a4@efficios.com>
Date: Mon, 23 Nov 2026 08:59:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 26/40] sched/deadline: Replenish a throttled task
 boosted while asleep
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <9c0cc7d7c43e0562a9fc9f363898178b36c6e9c2.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226168@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226168@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB452843:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bf6e9b-bfdf-41a5-d3c5-08df496a0bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|3023799007|261022105027099003|261026140227099003|261026121527099003|261028144727099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+mHvPBrSf4SKqK1wPf76AlTpXVzIKpTi254/CpcsoWitk+wZxmZJ5PQW37S/phF2XFU6zk1qXSm07UNroOec9UKBM4ZZKRcVJUoKei+Ex1sIHAucjF6pBe1QSsTXV7u+ez4shwDJitaumIh7srZVeERuB0PYnLBs+On2SSYt1wwRGney66WA7mh8gGt8Lfba4BSMCoM9Uj2NOZa46XBOwpsBgLAEGHzpykfZX3LAQ7QLmMdM4FrQRtEwClG1HG6wKv5kVhkE1TJcEwMASsH2lNkjgRQjKxt4V3uVWm0B7wib6YaHxUuztTwoyCOC/2o21BwsGDFc/RybGBBXLgJ9FUMyum15bFLK8d+zf6FyIoI+10LSo/9zQOEJnliRyHLrRS0TyBzo5Z2f7QrID7uqnbQ8+yXdOotoiX9udusW+fvr+oSDuLsonBXu2ug9VAzHbjJkAp9XgFr/AkdWy6WIhrP/oxbMEZd3O28F6+BIjncw5oJ15EhmMIdZ4ui6BuuaN/l1MAuePj3l+wa9nNr8jwvlhneAqi1H3WIf89dopiEg0lRuVb/RkQstcv7JNiF7oRC6hef1Qu+TJAkXV4ry5IhzUqfmWrtylxd+ePmRK8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am9LOUExQzJSdU5Tb2hQSkZ1L05yc2tsUkc2V0crVWt2MjdUVU1xRHp1Si9q?=
 =?utf-8?B?aFNXSlp6YWNZVXdIay9Sd2ZQMTNEa0NmL1pndEZpMmtzRlpybXVNbmFrTkZC?=
 =?utf-8?B?azRlWHhwa29EUnJGVnlRWXViTmhVdFdQekxWT1dLdFNwVGI3dXMrYjRXRHJS?=
 =?utf-8?B?MXBEY0NBeWdrYVowOFBpbnZkRjE2ckE3TXhWdjZFd1JaQ1Q2UHBZVXVUQWtr?=
 =?utf-8?B?Zlk2YzNYb0RFbzZhV0UwMk1aS0NNRi9WOHJhSWZoSDBXUElBUWFsTzB6bC9m?=
 =?utf-8?B?WVBkNk5aS0JqMTZyUDdBS0tmd1liV2FibVVuVmJCQXlBSE1YNE90emw1NTh5?=
 =?utf-8?B?eW1iOFNIbWgvcFFVdXdOOWIrcGkvOWtkbi9CZG5DbWozMEpZQkhWVnd1THVp?=
 =?utf-8?B?Y2g3czZRaEdUWjU2R3UyTndHTW1VVlJHWERiVzM1WEVhVnp3VDgwdmxsY1hH?=
 =?utf-8?B?VDh3VURSRWpkZkJYSzlyZm1MMDhRSTB1Ti9Fdk1rMGxDWEtzeHZOL2V0TGpE?=
 =?utf-8?B?UFNQdDE4QVRYMXM3WFNMS21WZWFnQ1BmUHFVZXVtZ05GZUxIMnBxUE9oZjFZ?=
 =?utf-8?B?a0xBek1RMGZNT25GSkZRZWV5ZHNObFNaYTNOZVVNZkREY3hUN1Q5Z3VTb0NY?=
 =?utf-8?B?R0dFeG9kOFFKOUJCTGl2YTY2dGZ0L29pb09GZzJXVjYvOEZGT3lxaXRrQ3ZE?=
 =?utf-8?B?a3o5NGgxdFBQM0VOdnJiSW5UTHhhT1hqSC9BTWc3YlRCSnNyNnVtQWRVV3Qy?=
 =?utf-8?B?TTJjQXV4eG1NaDBiUmdDWFhoQ0hHK1p2ZG45Ni8zZmIxaHBhcmtkRVFvaW41?=
 =?utf-8?B?VmQ0K1J1T0dmTmd6VnEwU0JhaDlIcU5TODNTOVZIVUt4dEtNOUZWcGRyU3V6?=
 =?utf-8?B?alorT0JaMHF6NVJvSllTZ1N4d1VtQkVRMWtLb3ZsY0VDaUtxZ2dqa0NNcXBH?=
 =?utf-8?B?bjFyYjlTTlFVUDdTZ0RBdG9JK3ZvMnUvMENFMHU4MUtHaEU2NEMzRnFnZnBB?=
 =?utf-8?B?QkFCSmVLK1g3SEViaXVZZDJRd2JOU2RVcVdrMU1PT1hmbTBYZ2ZOeEI0Qlkw?=
 =?utf-8?B?c3VNZnFlbUdGUVlCQUJqUUhZN3lJa2FpTHpqbldFZzZibW1xRFFDbFNDS1NO?=
 =?utf-8?B?U056MVJ4T2V5UE51bXViYXJuVng5MXlJcUNiNnM4ZGFKZWJqLzVMeWxZdTcw?=
 =?utf-8?B?eEdEZEZxZldzbWtRT1A1dnhiVlZydmpwbDVoUEU3eUVPbGlrelR2VVNmaHhy?=
 =?utf-8?B?QXN2aDJGUzNLcjlLQ0NCUkJveVNiWlRIT1F2ZGRTU2JBWXBHWW5HaHpTSG5u?=
 =?utf-8?B?anB3SGJXcmNpcVREdWRReEVpb3FqSEFzcHVaNU1oUXRJTEtnYTdHVmU2ZEJj?=
 =?utf-8?B?VXkveFhacnlYVHNoNTlSVVBjaWVOU0NYbEQwem82dkM1UlEwU0psNkRocTVx?=
 =?utf-8?B?bXJLVUU0M2xQRmtTNDV3WWFOWU9QNlZnNVZraXBPWEIxWktVbHUyeGJEd3FL?=
 =?utf-8?B?azF5Z2xPS0p2bFd0eWZMKytHclBNWmRubHNwTG56K2FMRkZqbWFscTBiL0hu?=
 =?utf-8?B?SzVaa1NiZ2V4ViswK0JmOGd5aGxRdEIwNU1qK2xjWkNrK09saDh0eGxGN0c0?=
 =?utf-8?B?Z2lQMjRYUENJNklJWGk0Qkd2b1NSSE1sdUVyZ2NNZVlQRGVrOVFOTmd2Q1E0?=
 =?utf-8?B?eE5JSEVyTlIwVXFmd2Y1OFhFN1JXd1Q3cVBqUFBtMWozZmdoZDZXS1dVUkly?=
 =?utf-8?B?RTZVb3BnMFBIQ2tIUXJhb1Jabmt4cmhsNU1TVkFWdllMLzVoUVhENTArMExT?=
 =?utf-8?B?M0NIYlFmeURiRDFEeGZMRjcxdjV0a2kzWjhSUExHV1dJVkZUR1RrOWw4L0pV?=
 =?utf-8?B?U2Q4V0RmNnprNnhBMm5WWGN2S0VWK3VzWGFhNXl6cy9Ja3ovbnp6OU1UZjQy?=
 =?utf-8?B?aTJiZEFtcGpJYXRKWC84bldWT2Roam9IMkllMDVkUzRNMUlqa0o4VTZuWW5s?=
 =?utf-8?B?SDNiWkxiSkVldm1Oc2ZsK2M3MWsxWlcwRnYzWnpZOThlUlBZZjZTL3lqSUkw?=
 =?utf-8?B?a1FGWkEyNlg0dVlFWjd1dlEveFVGeXJkaG9PNzlqcThOamlrVUVBYVJGckdp?=
 =?utf-8?B?QzQ1Y09tc29VTkt2Y29jUVJaSlgxUTFnRHowbFdrTG9QYUZBQkIvWXIxb0Zn?=
 =?utf-8?B?MlNkb1FRZ01rQk8wV0NXS1FpdmVTSUg3L21EU2d3dzlzTElkeE9ZNXQyakhi?=
 =?utf-8?B?aGJJOFdMenJ3Q0NMTDY5cGlFTHJobmJTc2E2V2ZYVlJqVFAzTU9zR2FRQlp0?=
 =?utf-8?B?VEdEdDZvR0F6dGRlRGMwZHZ6V0NIbmNZYWZZTDF5azJJM3h1bEUwNCtmTWtP?=
 =?utf-8?Q?3nvqhenBuAcnylMM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bf6e9b-bfdf-41a5-d3c5-08df496a0bc5
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:59:52.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2wZXboqS5C0dgSmhJBxzee8uPsvfaGN2MhzZAZ+TcfjxRWq07Bu23iVZpG5EbeV3bsF9D9mrn4o9JjzVG89IZLp7AWLu2enJWoHjIHQI3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB452843

> Can replenish_dl_entity() leave dl_se->dl_donor_refill unset when a
> sleeping SCHED_DEADLINE task's donor has its parameters cleared before
> dl_task_timer() fires?

Yes, by reading. In v11, that branch will note a donor refill for any
boosted entity. The deboost then starts a period of the task's own.

> Does calling replenish_dl_entity() from dl_task_timer() refill a sleeping
> task's pre-boost runtime debt using the donor's parameters?

Yes in v10. v11 will close it with your patch 38 findings. A boost of a
throttled owner will start a period of its donor at once. The deboost
will put back the owner's saved values. It will throttle the owner
again if its runtime is used up.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
