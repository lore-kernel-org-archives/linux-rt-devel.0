Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.114
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203514;
	b=nytzoGRR6Th5zRfgfiiSJVRKc/6UhZTDwvfr71wQPy/1vIETwqmPtdHE6lZsHYy5ibr9
	 PnZh7MNedo6d0E5pUoPSLa5wvFOHsYHzkgFAiZloHjX9kO4JhXWWLKeJ1GVw+gH+Jprv6
	 /tB7wfb8GXGoAlf9PR3ShxbVWLvSne0vt6WNDP/T2vECFan0GBYlPr8zH+/lbyKvSITsy
	 kVs/AC9Or8ZL8WXVLT0jpFltkprq7pXR9Kq4xhYIOnqjd8Zn6uOdZJIFRoFKMbC19Cd/S
	 zdW8d/IEpdIybzgEfO61ertHflRlWoUwZj7Mc48Kg/NvGFXkZxmHAirPN6Qz7HFp6zA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203514;
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
	bh=2EXT+lcbYFz0vO8aWChRr8Hv6SNnHJEV9BnKyHAVweE=;
	b=jqT6OgMcRQwwIe7gaUXvUeI1o+ZUkdMFPKNO/PZS/yXMYWjc9tfvnuKGLgLvqvXmQbeh
	 ICwK3hklxaYDKju2wH5C4rqik0QR95NzMgLti2U7yrr1YIggY/bkeLdD8s8w3fVDuanZH
	 xhdUCjp1Gb+ONlSZMoCZDss/vIec/H6cU/EmvVh6D5oyA/QvYSAxweop4wOS3VR23Km+J
	 PlpFN20tcEqCvrKr4fYG+oTbUdnOkaZaM6TNFTKpCSiGztkc6ZqCGf4tIHLk5xJl/6xav
	 qIJnR9+3C/n0pVNBTFdKKnft9jnRgjwnWA+5EAtueF0gmCF4sIXntVaobeMstbWNjAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=JXjviK4W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.114
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020114.outbound.protection.outlook.com [52.101.189.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8A606A6E6;
	Fri, 20 Nov 2026 19:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBB8A606A6E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=JXjviK4W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a65XAY8YURbAi0ewS5uM3pKjFFj8e5tA1zZHPkfFGPRf+lgVTW782GLyivxF+1qqezmmMHuiEIpPldDCoqmFiuh+dYUtFuOwG0tY/pZQd6FrzW4ZU8y6kci+WksbCf3c5FBd/10fkvDdzlujTvD8UvgPSUFcNjWo9HrGQOSENNuqf7yRh82BPJ+uH+ICMrk1oX3a7As6bG8mxE8g6CSHbawAjeMD8Or4dNuVJ55HeYGK7aElxcz/HMVqQ4+eCdzg6igkmTtWQfO7NUE9ez2epCdGk38Qc6hmkXrcKh3WLtJkkVBhw1BOj0kk5WVVYZIEvGBAYKGEWli9+gz2IlIrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EXT+lcbYFz0vO8aWChRr8Hv6SNnHJEV9BnKyHAVweE=;
 b=SU5jB6X7cPdu6EHyQ+Jd3d5eUdIBCWd8ia+8zn6FZKxVutjtvl+qDSuP+mQhBRJAsdtdfJqC2gXzQGh0OlUW1aje2lirrADZ6ET+X9YH8iOeexRc1MciK7mFHUe4s9CqVthEvTGpDfIFGZt8tPffOntQRciBNX2UnQ/o2Ee0+WCg+zTBqirAwov9hXg9Glmcp2X1fDhbc1GvakrrphFY8KAFZNddMOrZ4H0qKw1yhBEfK+ZEOeM3M+7he+kt9ivhk+C7l6mJNSjc/+gGHVh1NcJHc9FEkLsBgnyCpuFXS6d7tmdKHLJ/PldO+28thKzB/uGJXoYZFWy2+znRO4UcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EXT+lcbYFz0vO8aWChRr8Hv6SNnHJEV9BnKyHAVweE=;
 b=JXjviK4WQvGKBBK2ISxdtlo39GRTWToapakIgBJL/maMZIsFttM24TPcPyj5B/sL+rHx0t0889Xn1FDzSbDc7g+bj1tr43S8e9ekXsyc/LkCPIw4a0k0TWdIAYzzvmiW9I66Sd/0YtKRVB1ovy15OO5AqDiwaDFvBQlFhmNxAiJWWdYN52HN6E6bNOq5N+0f7J/DuxxqEX2scflyaY4aTqOWa3clyyHwKBySUrZcza08M4hvWdDGT+4UEQ82DgYAfA4Xo+w0RCHJQcIKblcdnBnJWMycm49544S/pZ29PmyTSrgmgDoHDEF+zZbnCi71G83UlrNsPwceKx54DIeHjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB500710.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1ba::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:38:30 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:38:30 +0000
Message-ID: <8487f631-9c32-4f80-b250-1c0256a7b570@efficios.com>
Date: Fri, 20 Nov 2026 14:38:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 17/33] cgroup/cpuset: Refuse to take a deadline task
 out of its root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <4baa44df95dd38644a85999954acce718b79661b.1795181240.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-225378@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-225378@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::13) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB500710:EE_
X-MS-Office365-Filtering-Correlation-Id: bebda842-b78d-4614-da53-08df473ddacb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261026140227099003|261022105027099003|261026121527099003|261028144727099003|10067099003|4143699003|56012099006|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ln5TnGjOyWBimKMIR/b4WThdSfrrjxLHJwWQtwCeoc0lGmiYVSVrhfN0JbAsNntldp52jijfkvNY2PlLmvHkA/cLdMbadHq5y9HPmNSChd1q8M1ybeHlnjKafEUoS8DuzddI+N38cT51cwvoP/NJ9PC+PEapnPHrp01vT/Z52vqV5mSncJPJadotmQ58EohKJ0ajlVt0FP48MkBO5RnxAd5kPNXVL97SZyNlyV0Kzs+Pz3dYtqPfB3NvF/u2SF/o+nGLawmrBiPHyKh6pwDII4Rv/VSdYcVisP++/TcABjWSr1msB7CZue7Y2FryaJOMz7Vg8e/m/PfgQXRmPAfiMD2dFcZE9AcCy2+dz6gI33T44BL5aimmu5Ld8ggE0NOV7YvWiLEU9zlQ376EXH6ex7CJg2TXIiPCDq9S7nZJlY05jjxDbOuksN2+SUTQFsfltVNR8nOsLrs0Ni3PsCOSLYYSYk1PnYBjTvwsqj1baQjHk3Tf4VFiKOgwbDWtnnc6U1nD5uVlKl1WYGX3aRmODk8+3pOnklWIa3rPLzNXbQ1IMumVZR5FSb16m+ZiogCq7ex5t6WEgjVdQ5bHGTbieB+WHeXHFme+BxbzsOq/Xq4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(10067099003)(4143699003)(56012099006)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzlOVlErOTIvZW4wOG5FTGE4WnFEbkdFSnE0YXN0TERKdDYvdklTSjNPMFJn?=
 =?utf-8?B?ZU95blFrbDF6bzhrVGJpV3ZoR3Y4c2NqYWtBcHdCeHNoR09XSkVhY0FIMWMv?=
 =?utf-8?B?ZFYrejdnSDA2Z0tuMEdwbVRTR1grVXVZb2QrUDVSTVc4THhwZWw4Nk9RMUNt?=
 =?utf-8?B?Qk1rOS9DY3F0NWZ3Rys2RTVkOHJiVmxhZHBKU1U3WURhNFZIbHhiK3Z5T1NL?=
 =?utf-8?B?UVZ1WktjTG5laU1DdS80ZVk2c2xnRmRkMzBwM1kwQ2NuUW5NMW1CRDBha3do?=
 =?utf-8?B?L3ZwNXgrUHk0Z3F0a1dxRkhnODFBcy9PL3pnSDNWZEhhS3FaMlhQejB3ZDNV?=
 =?utf-8?B?WCtsVGM4VTlsN3NuTElZb1ZuSC8va1M0OWxoNzJ2ajI5TGRabmNRS0xvMHN0?=
 =?utf-8?B?V2hBTGhNNWErbDhZNWM0dEhUdW5WcjJPOS9RMFBsQWVLZFoxWW1Jd1RwYmRj?=
 =?utf-8?B?UnhlZ0RTNFZxRWtPMXVoR3BKdlA4elE0KzZlVVJjOEcwRndtdUZwYnppSzBz?=
 =?utf-8?B?bkQ3Q0VycjRCQWhYYmlHZm41OURlc05NSzlZMkZGb1M5eXhHRk9ORlUzMXZv?=
 =?utf-8?B?RzlaQ1ZiZnd1VG1XQlJiRU4xUml5a1d4cUxnWTVSYXRFU3R1ZjJTRGY5TGJJ?=
 =?utf-8?B?YkcxYmhWeEFKK1JCM1VCQXV2YmJpeUtnMTU4VXVjQjk5VzVYYlVnelJ3SG5j?=
 =?utf-8?B?SXM5WjFGaFpOLzdtaUpPbDJmTGpyNENKV00rcUQzZmFJaG5ZZGZES3hTc213?=
 =?utf-8?B?Zjk0bUFRUWoyWG5pRmtneWpRdDVlbHo3Nm05cEpNOHo3LzhrRG43M2xKSi8z?=
 =?utf-8?B?bmtzeWM2NTFORzRjTXdQNjZUT1ZIcGp4RmdEWmRMcWhXZlVTS2JqcUpDWms5?=
 =?utf-8?B?ZWlYdkVXcUdHWnpMamplL1R5SWNJcjBQN0pDMjVMS3ZZU1dCbUJIVDVTVDV3?=
 =?utf-8?B?OEdjK0R2K2FWbjFGQ0RwS1RXWnVBd2E4elJYSHV1d2tkWG44K0o4RXZEbFdv?=
 =?utf-8?B?eVZhVEx5RHMrTGc2dEx5eXNOQ1FKNUNoRTZ3TGZObkdENXRydXUrYXFSNmo4?=
 =?utf-8?B?YjJ2S3VFbFlFZWpHUGpjZzJweUxwM3VqYlRiaFk2K3pWejl0Z1N4UnNRVi9o?=
 =?utf-8?B?RG40SU10OHdtdTlZOWFFUzlQdUlDR3FER2VZalZOU3EzSy9JNHZhTWJwWGdI?=
 =?utf-8?B?ak1pVEpGK1lDTjIwMTU3YytDMW52cWJ1SDhRODByYWZSekNlaUkrbUdvSzRi?=
 =?utf-8?B?aE1WdVpTWnh3MjdlcTRJd3ZMKzlHbEhaTHFJU1c1clBJZWo4R0E3WlVNSkN4?=
 =?utf-8?B?ZVp2RmVSYy9zSHpHb3l6L1J2cGNNbllVWWhQbUpSSzlJdEhOUjhpeWNaOXRF?=
 =?utf-8?B?bjR2NDVzU3hSRWRJajVCWnFhVWhuUlgrUm43NXRRcmc0SGF1cnhoOWJITTRS?=
 =?utf-8?B?SHV5WDA0U0lHd2tEM3BoOGsxaGlGSXlWcEk2UHRzUEM0WGppYjg0b1orOFhO?=
 =?utf-8?B?OFpnL213ais2cWEyOTRFZ0JLOFJQaG5sbmpkVVdsVVl3a2VUTUlidDRkbkk5?=
 =?utf-8?B?b3Bmcm9JajdXK3lkV2E2Ry9vMSt3eExWdVZVS3NEcnZBNE1xU2IrTkx1VGxT?=
 =?utf-8?B?N3NwSDlmK0VKS0EyVUtQVUNCUWZyQUVsa1lvak9ZdEt2Z09YMEw5cm5sc2xr?=
 =?utf-8?B?eW10T0FUdXdxdnRLZFM3dTVGcllXZHlxR1lkbk45YjZFWS81WUpsbGQvaGFl?=
 =?utf-8?B?V1lBZHpzK3o3M2NkMXhkaUxZczdCQlR6eHJaU2VvRFk5VytqemRySFJPTjV5?=
 =?utf-8?B?QVhZcWRsajBmcXc2ZjNibWRUeDJrZ1FmTGlsNVJ1T05pTHJwbXBOaWhoNWJm?=
 =?utf-8?B?QnI3SmNkVjZKaStRUGJwZ1RrcSs4eWROMmV2S1VVcUdJNmFBeWFheFBtaW5R?=
 =?utf-8?B?Zlhuejk2M3JCV1pWNlM2YWpCeFJGWjVBejR3eE5xN3VaOTAwMEtqaVVFREIw?=
 =?utf-8?B?OEF3L2pvN0s5MUlwWWh3VU14eVp5MXY0bUFmWWVrT2RNSVZ6SGlzNFdMbk55?=
 =?utf-8?B?YTRmZGwyNjg4amoxdjBBNmxjazFOSnhKdnp1M2M1dEk0NmxBRnRDbmprdlZF?=
 =?utf-8?B?YSsvS3N2ZVNsZlc2MnlZWDZwSWtEKzg2M0V1YUxlMWFVTUo4eFNFMllZU1Jk?=
 =?utf-8?B?eHd5Tkl5NGtXNkJXU1ZnQnBYakJQY0NaM1Fzc01pQ0l0L2NCMmY0QlhnOFNn?=
 =?utf-8?B?SjlqamJmSm5TOVVoTW5yaFJzbEQ1SzEwL0hLd2ZEdThzZVJiT1ZGcERnMTRQ?=
 =?utf-8?B?OWVnK2xqUjZ4THl4dSt4OXNnRjdqTzd0WmZmMFNQektxNUNDMlNBWStNQm1s?=
 =?utf-8?Q?9XKV3Tn/6PZT62Q2IGwCH/1I/10nz6mug3BqW?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebda842-b78d-4614-da53-08df473ddacb
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:38:30.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbI0QDYby+FIvkS5hxiAYxXyM9G+gf0CCa+6/gKel2vJOQuLOmVWPsgWCL3qzs1FaTDF/WHLhDXDIfjCH/tSfqB921Sc5R3lKFEKdcnrbZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB500710

> Can this dl_tasks_keep_without() check fail with PERR_DLTASK against a
> stale root domain span before the sched domains are rebuilt?

Your first case: yes. It is the false refusal found on v8. v10 will
fix it. For a "root" partition, the check will also accept the CPUs
that the partition root has after the change. The rebuild gives them
to its root domain. A new case, partition_grows_child_valid, will test
your first case. Without the fix, the child stays invalid.

In your second case, the partition staying invalid is intended. Its
deadline task is counted in the root domain of the parent. If cpuset
made the partition valid, the task would move to the root domain of the
onlined CPU with no check for room. While the partition stays invalid,
it runs on CPUs of the parent, and the root domain of the parent counts
it.

> Should dl_task_keeps_root_domain() check &p->cpus_mask instead of
> p->cpus_ptr, as dl_task_leaves_span() and dl_task_rebuild_cpu() do?

Yes, by reading. v10 will test cpus_mask, as dl_task_leaves_span()
does. No case will test it. It needs a task preempted inside
migrate_disable() at the time of the write.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
