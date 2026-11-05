Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905871;
	b=s9U3PiYOjOvHzoWKHWZaJQ+6uKdULwXsNNy0uPsB/8x5HlTlwQUOlsISRYYphdveUdwT
	 ZoptwL37wZVVCqQNIuK1XrvP6LfwDS5BBaH05weihRrcBj6A4umTXFEZYVFPHklI+P3nu
	 SATnSIozFxU2P+rLmhKnTlM9/KHxWkRv9ZZ5UyAL+OF56N0Ulh4yYnClCh/O+f7qcUt36
	 5pgiAYhHjWycarPJSqj3vKLta5EC1iwYtj60zvWr4cdJ7OVFzCAxfdYicNmAVY/gl4JRV
	 JKRMsk5u1bZeTIeUq4J0Ltz35sm5u1yBU8wXZVHkhy4s/nUEu1GgTo9SOPRu29Yk9Bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905871;
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
	bh=wLZdF7ZQ+yrCN08wRgsorbvTzS4dznV0u66u5cdA49M=;
	b=W+yFCRj8W2XCFdkCmDZb7t3GFtZTTLKDq0gWHnSWbKpkmB+81h9f5QwY29AkNw0WjNDs
	 eAwj8mV7pKWCA9FkRdyQN1bT3WwdK8JFuo9D7njymqoYvOm9Oe2SNYIeZt+JCbEGSAViR
	 5PZQk0sQ8gH28b/x47JMmRRHGYYGHhCvu3WkFgBTJFgsXXuDQs2ooXIB53PP16d8saVGl
	 U5kQs27Vz6VeC2qnXkLmCgOMqhGgdEsmxWxNjUzroK8KkldNxPlfIvFpjQeNr9k7aVE7/
	 wEEdSDYB434m38K6QzCpuOwEtj43dVl+Bu2NLCDJ1GT8P9tOvF5U69LpxyzRxYF9itQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="IDM/H7l8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.131
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020131.outbound.protection.outlook.com [52.101.191.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7DA606A329;
	Thu,  5 Nov 2026 19:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B7DA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=IDM/H7l8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECQD8gOaHE9HsGnoeqX5VEWAMxQYP0lVjpOMYB/wA+ndXgkgrwEm6Sn3aeOj8NyixYH67tc3hdTnDPxR1dbx0mSI5EB2Ey1Q7vL4efFI7+pqE2gQzNxXywB/zedFpyVg+/Bm9PF+M9S4qtjigJjjxSXypoelKbGNlL46t7gVqFUok9zFzxH/I/7PS1fWfwA+CRqlj3Cdh9M5kkqoEJS0dQkTKlIv0WjW+hb7ROjCAS+LHx89mMil+qNjc8vcVwsfsLe0MvYfU5Z8U3NPaOqSQTqLOJumfPj5964T89hUNQCgNy76RpEylnE82skzQ046Z6JHYSRzPc2B3/3ZHuaOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLZdF7ZQ+yrCN08wRgsorbvTzS4dznV0u66u5cdA49M=;
 b=kaFLxSxdIuSiydW9ygcaK5g2VF0s1voGXyM7r+5TENoFLNyBIskv3jFqnXozfUC0bOSvMckedMRg7IIzoGhwKUyySqF0hTonYOjwjlcY3Zukn9X1o45DOgGcM3+45xM8mFKiDdp8RGGc76d3oN7cgtMG9ceBYGJAqco4WjTyjFFO0RqyTbp9TGTroOIXCUjtHVpToiCX3INdT2y1Eg6bYl3RRuPOTZCwY5cM5Mcj78vOdIUZukazW4Izz4W2v5Wx7iHC4HkUAZYQbgorg0eTncWP8ga7DxK4oPor5/GqsE6Q7z6Uq2QXuPHzvP5KY7jOz9Zky7oIZC0AmlMEna4dNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLZdF7ZQ+yrCN08wRgsorbvTzS4dznV0u66u5cdA49M=;
 b=IDM/H7l8kqU2s9JSGwtu4c7lyz+jH5PD3rffa7YS4NRYzWO05eyAZUQcBwPCESNYan/hh3ry8bpq18jrDoNpUCiFX1nIyjPEi+ZqfaKfOPfVRaXzR+gaQe5ZVOhSlZwG8oBf8gYS/Ja9OaJxZ9UF+qB1lf3lHNrHHY4iTMOszWUl9XTkCuHONI41ahtmnJYJ1yAdz2SIGmhumIETeF2Lu0JNoAuHOebS8iirC7uEeGO+W5PdHmyoBjgRAMXOxec8SlSuh+uPBpR/es+ylRXvkLKHbekCi1WSN3jE2tsFUEbAqE6GFCRK+nRc/E5HYHEUbf84wOqzP7+sSjQCgJ03gA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB179232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:113::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:11:07 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:11:06 +0000
Message-ID: <399a3f4a-76f1-4cf1-913c-4200cb4ce44a@efficios.com>
Date: Thu, 5 Nov 2026 14:11:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/21] sched/deadline: Do not divide by zero active
 CPUs of a root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-5-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-198153@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-198153@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::6) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB179232:EE_
X-MS-Office365-Filtering-Correlation-Id: a985815e-3e37-4292-c186-08df3b708b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|5023799004|4143699003|56012099006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KgYZHdgcEGAvGfasQgf5vrr8glYuyTEapIfSS1SUpDqUbT/UY35ofptylQ4vjwfwQRfWHEbiqJ/X+vAOSZG1ZVT/rsd2pfBkY5PceEh/Kidpy3+uzPkQivFKrzUIH+yai7WUKMvQPpWypYlGjb5LuL/wcLkm7Ol+BKqmv9s6bYorOAHULjT7/yxz5VhqRMQ2p+07HH+iS9hcUNTVFgCepvlNtuGq6aYu+RIxclpqP6znGcCQ3qMCkqPZ6twXzCZuSth+3A05MJzerLFxEHSRwxYpda6X4QAmeE+dNN8XEj9xP5SxVtapAKVzvPEh/jPf+1M+V6nDLMn57XDdte9EQnZCKdtQRR7RuyaTnhIznmsF30swDSaIy8DV7UCqznSvg8n/dvKyEwOhmkhtMUtUjyXq3DsiBO0RC9GnnsdJ/EKCqjy9mQvO0upy19UNDqEaFTmIUFVEDpebK286LRCowrltCGeZHV3EbaRvA9EDG6lgbUjUcDel+05LvECCNFKKi2RuMOx5dPv3ArkD3zLHYDeEF1XIFGMpTvSC5V7+tVNZtiplo82FgEI0rC5E3usFAvn/iaVKiULjNhVOGD1Usv6/UvHh26Y6Cg+WBfo2ZYA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(5023799004)(4143699003)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1BHV2U3MmFNbDMwemF1U3hPaldEd0h2amdnUWliT0lRaVJhVVhVMmpSaEl1?=
 =?utf-8?B?cDFPMGwxMXVaaGNzbmtOMC9XWFpxZ1RDRDk2YkF1NUhNV28wVzMyNFFSRGVY?=
 =?utf-8?B?aitjNTBCY1BpWm5RMDZIeW5ETkcvbkFWdHIvcUp0K1UrM0x5RjJkdlJES0JU?=
 =?utf-8?B?dUZRV0F3UWVCeVhWdVBPTThaTU5hZ1MwR3k5b3JhVnZjK3hXVldlQldNb2I4?=
 =?utf-8?B?OEwvYU5YcXphL0pwYlZpQk5BR3EzYlVXQUI1ZmV6ay93MTVzSCt3NFhYc2Rv?=
 =?utf-8?B?dXh1VzdBSkU5ZHVqWExYLzdPckw0T0lXbXVIZDgvb2JkN2E5NjdFc3c2MEtJ?=
 =?utf-8?B?N3ZDNjl2WGlxOSs5c0NiUUZ0bWE5RWxaVTJjMnVXY2hmS0hXZUI5eStMMnZ6?=
 =?utf-8?B?eVBnYjRRNmtHb3BXcnd0V1BlWkd4V1NqMjZrUk04N2lqK0NYeDM2amltQnF2?=
 =?utf-8?B?ZlJkd2NXNFE0RHgxM0NjendxSjdtUEwzeGF1T0NPbkRXOFhtUGRES0tRTlVy?=
 =?utf-8?B?Z1NsVXVVTVBCTGg3dkM4ZE5peWRpWVVTNjYxcDl5am1HR0lVSlhPMjlHTnhl?=
 =?utf-8?B?TE1IOUxCdmRJVmd6ek5UT3BrVDNVQzF4dzdmT1pPbmRidTMwcU55bVkwYjNO?=
 =?utf-8?B?SkJCaEVtdlplamhjbnVZVHh6NTlFOU1xbldsdFpPNXlzS25BaUNBTCtLVHFx?=
 =?utf-8?B?VXdZOFNIdk1EYjF4STk0MmZ1SWVISGo2UldMK0V5YU5aVFBjaW5pd2Y3U1Zu?=
 =?utf-8?B?eFRUWjg0TE4rNk9HWnc0NE84aXFCVVdzck5tSEdJVWNQYlN5KzdRNk1ueDNY?=
 =?utf-8?B?U1FCd3drZUpGRG5vSVhHa2tWMnZIV1IwZUR1OHdFUk9oNk5pc3g5eWVpSUxo?=
 =?utf-8?B?Z0oraDErMFJaK0IyOUxuamF5VnJWdUNRSXVTeFNRbXdwbno3YU9PeGs5c3Jj?=
 =?utf-8?B?eU8vWEpIdERSb1d6aFRmTDhBRXl0Wk5zWWQ5aFFudDBzWVFEWU5hOERtQzE3?=
 =?utf-8?B?WUtEdWJhUGlkdnptVmFrdWh1YlJlZXNnMVNIWU5xZ1ZzUjdrZEExalg2WnVW?=
 =?utf-8?B?My93cTcyTElMVHQ5cjRReFpDRjVuUVcwNzZpMXB5N1IwZTZNbHBDWWh2eUlB?=
 =?utf-8?B?ZG91VEtIc0ppNkluTmlFTkl5YlBFWHRBNFRBUXNqMHFqUVh4aXRkTHc1K0xo?=
 =?utf-8?B?WHcrZjByV25vNzJZRVpYU1NmY0I2TTdTT3JheUt4MkYzK1JYMUN5NU9Wako1?=
 =?utf-8?B?SGx4UVdTZ3ZvWGF4am1GL1o1WTVPaWZqYW5rejAvZWFUQUJ6SlBGZ3Y4QU12?=
 =?utf-8?B?eWl1YUp2enB6YVFBcTMvQzNJVExMbDlDU1JUQVFybW9ES3NmMExZdmRCQ1gr?=
 =?utf-8?B?M25lRmtUamhYc2VUMnFVUW5KRVJYRTZ5TzkrYjVZS0JQZ0s0Z2VQYjd2c1Rp?=
 =?utf-8?B?RG5KbWhyUkw3VjlRcmpWR3h2cEhadkUxZE9GZnY2NlZ1bnNNTnJrZ00wVjlo?=
 =?utf-8?B?ajZnZm5IMTBwUll6R2tZZS9kTzYwTXNjYWdyTFNKcDM5bm5tUFVBclovSytk?=
 =?utf-8?B?VmhvbSs5QWZnMkp0aENiQ0xPQStJaUM4RGtGd1k5ZkdoTEJuM2trMHY2SkRN?=
 =?utf-8?B?TU9OMDQxZVcvNEt3Nmo3N1AyNGdXQTkyRFZqSFJTWWJ4bXl5akE3T1dBcjF0?=
 =?utf-8?B?RUdyZ0J2disxc2dCU2NwRktZN21nMGgxd0w5Mmo5OWN4NCtNdzBVR2RQbjlR?=
 =?utf-8?B?RUMwTlErZVhPaU4vRWV3RE50eHlvSE9KcXNmRFVrRkxSc1RMMlZsTnhDRnBa?=
 =?utf-8?B?KzVodlJmeWxlTm1DaGVsZzN5dXZ4Q1g4NE5jK29RWnVNSkpjWEFOVXdOVGFD?=
 =?utf-8?B?T2VuMDVTOEF0b1E1VTRsUXhES2IzYjNiRmdJd0VQdmNEVXhDTVNFTDNkTDlB?=
 =?utf-8?B?ck1uT202T2JGZ3ZwSUdRcFNHemZscVZpK3ZkMTlRWkpUZ0pTME9zbDFzNEVu?=
 =?utf-8?B?M2M5czJ0VHJtOWd2QTFEbHM3NXJaQ2l5M2twWnBwSzd1dGNTTmdlUEtVbVhN?=
 =?utf-8?B?RWg5VTJ3MSt3V0tQQzhlWEhORzhwY2huT2huQW1SdExvczRXaXM5eHBTak40?=
 =?utf-8?B?NlJPdnMxcEh3ZnMzTEh6VXQraVRQejN0QlBPY0pPcFV4QzUyU0hnS3NYL2k0?=
 =?utf-8?B?Q1J5V3E2YThwMU9UL0doYklsRTBkMkEzVWMzMjRDZWNyZEFaQVRubzhiOXcx?=
 =?utf-8?B?U3ZSd2NUODVPOHE5Ty9oSlJjWTV1b1dBUHhHWVZya1o2Tmlja2NibS9TOXVl?=
 =?utf-8?B?M2lEZ3hRbk05SEVIaEdnWEVzaEdIbU81WE05blJFamNmM2kwRHpMVlI2MHRS?=
 =?utf-8?Q?YL2zWsCtBTUr32sg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a985815e-3e37-4292-c186-08df3b708b2b
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:11:06.8151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jicRrD626TcLjXvQK6EqfYFZyAjOvNJ0l9Tu+Fv1nMblTrkUE3qeXLOZqEBDtiILVgqpybEE94H5ifijy/9G6Ye56XMe3AtOIuzbKW9XW/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB179232

On 2026-11-04 16:46, sashiko-bot@kernel.org wrote:
[...]
> 
> [Severity: Medium]
> Can updating dl_b->total_bw when cpus == 0 (or on an inactive CPU) underflow
> or corrupt dl_b->total_bw in the paths mentioned in the commit message?

That write is refused in v3 while the CPU is inactive (patch 4). The inactive
timer path is closed by patches 10 and 14: a release after a rebuild takes
nothing, and otherwise comes from the root domain that counted the bandwidth.
With admission control off, sched_setattr() on a task asleep on an offline
CPU still counts in the default root domain, with no active CPU to spread
the change over; the guard is for that, and the record releases from the
same root domain.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
