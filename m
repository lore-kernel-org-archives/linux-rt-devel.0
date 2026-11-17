Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924893;
	b=GJ24DXvERjdzzPFJgpTHajghE+FPK9gWdyewTzkf6HtfGr4WZNjvkSABt1ryhDU0fGQM
	 TVVX9ozR63dBeL89pj+XF5JmJBRd94HODO1bqqdqbH/itJWFgAjeR2OoGSF9pzM0UahAH
	 dLFIMfaTtq5m+FW8NCTtO8PwJ5C4J2XBzdHxWKdQOPJ8aekysHkqp9Mld/d0yu/3Z0mzw
	 PoQj38d/bk7hIZR4YHgZI3KXTgUyuc/FsHGW0ydqvIkY32PGv7D+Bs9SYumJKoGU8oQD0
	 I72p2eVobD08LWBP4/R1Lz7o6zWl4NJ589Z/Fl8zYaIhAHfjKBzvs4U6E9lxX0ollNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924893;
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
	bh=coCo/Ks2kyomQqsIYg3JBdDbAix8IQoBtR/0WzCHQII=;
	b=q9e+HINXRy61NV1X7X7z063XjfFKWoR7pLtuPT/gJSGVgZuib7k6T4wqqr1G58uIVOO6
	 QZGOKZXSFOuDPPjwV0RtwXmYNNvYdsP2cxjSMPHZ6ARP/qR4Xf2g7Gh3u6cuU3OM3rSbJ
	 BCKFFZHQGj1XcoymEvgVnLFmGEQTITfZFY+NJLcIVlxgfFsMcCR+SF3CWfLSRwkomJN/F
	 lH5yyEL9+uzLJUOqyUZ/pj8MPPQwOHHqSFSsztQm6Jv5q3t/qGolJlh7MNO+T/sNmx6Oz
	 qkyqq7u6AVQiIsGK14Pevwj6nsO6Z0xWd+JeFkd/wndxDZ3P+76Uxdm/EaLfKMwIf5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=eBMvu6UR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.139
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022139.outbound.protection.outlook.com [40.107.193.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12988606BD9E;
	Tue, 17 Nov 2026 14:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12988606BD9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=eBMvu6UR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ook/sq9owU5Bw6MkC9n5hMtEhVfz/eutDRm1DR0yF0JSu/+4SyJL23g2nyA/GyGHlqkOclvs4zKB2acahCKzU//5XHam2r/37e9Es15HpScR9cVP9vgihQs55aDv5voWxW8KKjkMlfL0ME0qrGHHtbmzzCqL7VbBWDsNjJLyL9lnodwVtjviekTpmxumzCSY0F8HV3b754eVK9ivs3U7u74/k8f/p0O8zOg5/oNA6IRHVOMLhV0qPUMASqYnQ/85+MUcy3Zu17grJrC8ptaqmtQNPqtRkKb8lZTJuIZtiYe1xoXHcWxFamssqayPc8nmlWmRPKXQDFdRN3Gxa/4OtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coCo/Ks2kyomQqsIYg3JBdDbAix8IQoBtR/0WzCHQII=;
 b=L2ErK+28CXPd1GB/biwM+lSHLNdAAg5se7dzWUo2/7ML93BughHp9Q7gUCucvXgo3GpsYkTwcnLDNEZhGrg7p5Xda5f8XG1XRsl3KokYjmt7Rfzu5hzqEgYtVo9St/hDX2ofZZWr6n7jnS3udF4SUU3vmObJcCN8+DfAqRIWRZj2VjRBF0rvwCi3UZ3bVU93JljqL0cWfqaAKKketYHjSsVHFUiL2z5OmQS2EUl9FadksxUoQjjM3Zv6P2SMnrlExwyZP3wg+MQrQOm0qui+mhfgoqDWutZzp5+xYPVUHnQctJfMSs7R0XwER3NZpvj22pnXogXPymOzUkxNBthjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coCo/Ks2kyomQqsIYg3JBdDbAix8IQoBtR/0WzCHQII=;
 b=eBMvu6URcuqordMVl3XtEsa4DOo1+vHC5EQ9IpZ4yaIp5iGbHVi/wJ7DsghNUR/SEKGz9yL0DUMZOki5SjzAylUjIBtT0OU6GBChVn6UvtW0/07wJ6Asq0C9wbg3SC43/TIIMT6EE2mQEvjICMim0qKT/79oVek/U7YMwccXT9bfm9zkCCnpq5oKqf/zEdxNvOEvvq0MsX/bdKpvLc8Ffzr3OIMEaNqbHOcHBN9+YMl1CNeFttL2D/gX5LpklTYd2ERZyufqPTQ872Y0FDY8xl7GYqjjjM14FQoaBfMwwEXEYzS8svHk+Nggt+PmTdMA+sFX4AJDu9XMmVRHXfK+bQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB9777.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:14:49 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:14:49 +0000
Message-ID: <b975f96b-4811-4033-ab73-e819de1f4f7e@efficios.com>
Date: Tue, 17 Nov 2026 09:14:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/37] sched/deadline: Refuse dl_server debugfs writes
 while the rq is offline
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-6-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-217565@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-217565@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::24) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 9630c287-730e-403e-5081-08df44b523b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|56012099006|4143699003|261028144727099003|10067099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	c16oloGhMYoQ3mWQWoFjawFbABRMBiwddZ924PgyAQqowylaK0m+rmb/xjErZyiFq+XjTJY06YN+gcR1kiEjYIQ4hTJu6frZMrxD0juyw+l/PepXy5zYAtg/cxqaE9O3eTOGbOFwJpgnsk3ONcXAtlyFb2ssP1NKOkCC6r7LpyY/VJZ3KYO+9WhsMhjEeN5NU8xbtw1jP0PIOYnpaSsYe/jXR2tvewl+hscsnkjgdQXUY/rx+lp5bLyATNEh8eL8ZQHakB1HKpbj4Ft6VxUpojZUsAyKurKqOdZrWj5qASIMgzYt2xXhIpJYW7CEgxzRVrDMaOquZf0yP+cz8LQC8jlLDmR7e3RH/XC69te8VgJ/+u/37ynCzNjKu9TWUvOXm68y4iuLYFF2pI0u/EjmfMalRgLUYf/tVKyRhKnSAMssxAvcNb932XawrPJUJatsUUxgQFTFBO1355gvfsVaQGx1sDBgfPtPrPsj2gBW6xF0eu7EsoraT6WvaCaIutx6ULASowTW8DYtu8uWE3WLlk6PMB7HdZKPpvqu8thGRLQALm4LVBFjL9kmMerLs4LuK8UraSkYxhtQpszKNQcoJgUsFOymi0+ITq9o+ZYVMJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1ZuK3VPaEFmMDhGRkNrMkpHVFovUlFiS2N4NUJPdTlyNkxWM0dLanhoZjhy?=
 =?utf-8?B?NC9uYVJGdjgzUlViYXRkTktZcUJVT20yNFNPSGxHUUxHV1Z1d1RraTdFRks5?=
 =?utf-8?B?bFFBZHlrSUZyYWpJVjhzQzQ1dVh1bWpUSGt2Z2tQOEdndURxZE5GU25Mem01?=
 =?utf-8?B?ZmUxWFNnUU50aEt1b0oyL3d0ZXkzV0tScnZ0Z2pwUk9idnFSQzZ4eVdwTnVr?=
 =?utf-8?B?elN1NmZmWXNFZ2IwZXhUWWhENG5jTEZBTEd2WlRkRERPN0FBSXA4amtyQUlN?=
 =?utf-8?B?VUNkQVpXUzBPSFZhY05wWDNqc0l1M2ZwNUo5eEMxU3YvYlFzUFNlbnJJR0Vl?=
 =?utf-8?B?cGhqSk9MNGZ4UmQrbGRYN1BudUJrTk40VUFYNXhqN3RlZlB6WW90azBPUVFI?=
 =?utf-8?B?eDlLY2V4WjZJUUwvRU9ERGtlMk5uZEhQUzNBMlJlaGpwRVpINkFLcTdYcGZ3?=
 =?utf-8?B?czVmLzcvc1UrbDdSSlRXY3FUekl0bnZjWTBJejFsMFhhWnQ5T05pbFJzSW5r?=
 =?utf-8?B?MDFMSUZOdlRTYTBmQzNwZ0xMNThpZ2MrY1V6RVJjek9ycUxvVXluWHZ0Y1F6?=
 =?utf-8?B?NXk2dWVCZnpOTVFzN2R0YXp4TVI3SnVSN2haTVdoYVJscjNVaUVoZ2dPdHVn?=
 =?utf-8?B?VXFFWGRYRk5IVFAzd0Nzc1dQWnRSY1lEYmhuaWZmZzlXblZXd2VQREhnYzJ6?=
 =?utf-8?B?ZEUrTWN3TDZhODUydkVIdUN3ZlJJcFdlRkoyZnpDWHhNSWJrdis2QWFpUEgy?=
 =?utf-8?B?Y2xmR2p2ZDdQZnM5M05hd2s4YkU3VFBHbUdkbmlOOGR4eUloak1LMEx5M3Vs?=
 =?utf-8?B?NUx1R3RvK2VVZUM4VXMwMXVUYnV4QlA2QjN6emhGWFVkbG9MY0ZucVgvK3Ir?=
 =?utf-8?B?U3dJTkRhMDdjNkdieEtTVkJXRExaWEp0S0lmOCsvWFJabXFWSWZFb3l1K1lS?=
 =?utf-8?B?L1NRcm1WdTRjSDVRSFpqczdYTjY3TVMrK2V0Unl4azZaM3F6dm1IRkJTY0FJ?=
 =?utf-8?B?VGhLa05TL0phaVFxbklrU21uTDQrVHppdkU1QVhsMWNtR0F2dlBmb3R6TTlK?=
 =?utf-8?B?dXJJUExSSVdqaDcvR3JEaUFOSXBNUUx4MGV3VTZyRmo3UkV2RmhJZmNnUld1?=
 =?utf-8?B?c0l0RDg1YVFYbVdUUU1QTVFSaUErV09pc2JjcCtyb1haZmZtQm82WUdacmZO?=
 =?utf-8?B?VTZ3T2lxL2grM2JIa1EzNjRidUo0bExhRjc0WE9WWWVTRGVKZTRNc1J1b2d2?=
 =?utf-8?B?QlV0Tk5lQkpudlpHMDdtNlRpbDR2Y0ZuU2dsMVZubmN6ZnY5bUR6Nkx5MFRT?=
 =?utf-8?B?Rml6OFRaN29LK25QbFo0RGRJUjlETGYwNFZVV3FHWU5tSzhMVzZWOU11b21N?=
 =?utf-8?B?c0VCL2pnTFZTUEJqNjVzWXB0NmhhVEs2V2RZY1ZYcHFHQU16RVNTWC9hcXB5?=
 =?utf-8?B?ZEhsU0VTdEY0UzJDOHRhb3ZEOWtQMG8zVFNLTFRHY0Rkd2RkNDFveHlJV3dK?=
 =?utf-8?B?dHV2WFl0WUl2OU5DQzJXT09PWG9ZRHhpN2ExOEtwOHBtTkhnbnB2UW5DQzZ6?=
 =?utf-8?B?U2FPSWlmZ2ZyNjAyN3hqT1pYeHpsV1FvR0dpNVcyWG5wRDdhMWgzYjlYbkIx?=
 =?utf-8?B?SmRqaGNGcmhRblFnVXdRUU1kR1hIa3hDVXhRTnVrMitNNElxRC9DLzFtd2pa?=
 =?utf-8?B?Mk03RE9LZHdualovbnpobE84VXN1TTBycHVyajVwSUc1bXMyek4vVlV4WVFq?=
 =?utf-8?B?Q3VCNG1wazZHVi9FZ0lQWU41a1lpaXVFWEVpcG5lNkhBOGRpaWMwQlJETDU1?=
 =?utf-8?B?Q0xqdDFTUHN4QllNZHdZZDVsZnZNYmE1c29CcEVJck5QYzdYb0RlRnF5eGkr?=
 =?utf-8?B?OVZ6M1ZuLzRSYW5hOVhrNThZRHErOEpLdU80b1d0YytkR0FhRVVRUGZZOWRy?=
 =?utf-8?B?ZHYwRXpRN2U3UHpVUy9lTE5MeTZlZGppSnJpbkQ4QlRkejUrd2tXOEd4WU5D?=
 =?utf-8?B?VkdGOXVKZmZJZk5IT3NDQ0N6WWdwZHBqM056cXJFakFYRjQ2RUpWdTdqeUNs?=
 =?utf-8?B?UytYZlh0UjJ3bVdHWW1GOTJSMnp5MzBDNmhXWXkyQ2dzazNwV0lnZUpqUlQz?=
 =?utf-8?B?V2ZkYi90dUM5THlWYXRMNC9Nbm54QWpHYVhxaWxZT252aS96UlhoOERtS3A3?=
 =?utf-8?B?SHU4UmY2OXdZR0dkTXpHUmdXZ2Y2d0Fzb2txclFDYVlDc1NuMHpsdGxuQXFV?=
 =?utf-8?B?cmtQYkRJUU5Ma3BUOUlCZnMyOHdKajhObFNJYzlzWmd5NzFZcElRSkt5Q2lW?=
 =?utf-8?B?ekdMenZWRVhRSngvc3lBc2ZmME9VbmJVZ0xnSTNPbzlweHJ0YUdtUVZaNGkv?=
 =?utf-8?Q?c9SsRQh9SjwEerks=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9630c287-730e-403e-5081-08df44b523b0
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:14:48.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bW5mZZ0E/3+dhH3pcL46uawBGt8Qni92SFEs07X5PgnsN0SLQHii5bYL3J/Ke+DttO6j/tRuwWOBdW4xPafZg9jfPy/ne6HyO4TQedndv5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9777

> Can a debugfs write still slip through during sched_cpu_deactivate() after
> cpu_active(cpu) is cleared?

Yes, it can pass in that window. It leaves no wrong state, though.

> if other active CPUs remain, __dl_overflow() checks N servers against
> N - 1 CPUs' capacity and __dl_sub() / __dl_add() miscalculate extra_bw
> across N - 1 CPUs.

The test against the N - 1 CPUs that remain is the safe side.
dl_bw_deactivate() just made the same test. __dl_update() spreads
extra_bw over the active CPUs only, so the divisor matches the CPUs it
updates. With no active CPU left, any bandwidth above 0 is refused.

The rebuild at the end of sched_cpu_deactivate() then resets total_bw
and extra_bw. So the write lasts until the end of the same call.

> dl_server_start() also re-enqueues the server on the
> deactivating runqueue after balance_push_set(cpu, true).

The rq is still online there. Any fair enqueue on that CPU starts the
server in the same window.

So the planned next version keeps the rq->online test as it is.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
