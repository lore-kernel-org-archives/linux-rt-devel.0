Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794193061;
	b=iZlQU7V01muYa6VkK9wH6WZZal0Rlemamt8XzYotDdV63GBft4Twll0LCOd1AZmjQ0Vi
	 TbWtnQxExAaRZllhIEybeVUhUUXpRuYqsNJUj+1VIsy5R+ZHV2GzQ2wME801G5teXaNHG
	 zczJgDpdA5BDjc8dkHZrR08CtLo0ArLHzWXswA9jgna81cck7lnAwjJPSdXUI0JZOPEAo
	 e5+ysXH1JKkNFZFTakkVVWS8QntykEmGomCchdALiUyq2Lop23SaufU5T8fa33VTR0ZR5
	 KOt10x4a3KlFXL33i5KiYH6g0Hqkel6rOE2Ci1gKBZzNcFTqmVl9/WZ88i3HeGkHMdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193061;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=F/cKq6zN71WV1MJrIOLxWJ0XZrqIg7yqs3/MNpoYvB8=;
	b=SR802+XDSm9+isRc8tPQ3nq53GN3IBcMs4Rmx9RMXR8yo+x/8D11V+87fgz4F59X3PKG
	 qEJMRA95joc3bRwq3iqGGd9q49Or4wl7gGEDODg6tPkFcXMjoZzl708D9PwJFt/pthleV
	 SeSloOv83+J5lmXIRjmjRBqpVt1+U1x6T8TFAqBtCO1ZLCc5mFUIJ3MCeeM8eFIa3Xg9N
	 i2fR8BppkOUobA++SErZWI+KpK/lJFJfhumBlut982IjwKq3B2CeDOrsj5VOcY9tsVurY
	 dqv4xL/E2tveJmf8wj0gwPNM8cfrhmtsb8m27MIyZHucxKJp3wY5+r4Fkqwjde+XcVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=b32z0FY1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.102
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020102.outbound.protection.outlook.com [52.101.191.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5F606A331;
	Mon,  9 Nov 2026 02:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E5F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=b32z0FY1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpliq+/SJSmVEVSYQZtQ/clfvzgm4i72SkPixPMraLe8zR4Xg34Adin0afPSyQjyPSfSX4dOzajow56+W6P+/pkLYhWcTM7pe95NZmbXD2SDvgkBZmz1JLeActxynXZgom99l2xOPHa24kL+nCS3F/UcmlH403apzaNwH1ENeyf5Gb3Uhg5TTvAvRHpgwVhem8W0/BojHEMd2eDBA+h7i/Q07VmOgwGoGD+rG6S7rkM/CTHxibS0PWg6plIdQ6Wyk0+g0rDmSWM2Al50tH7fMNFa67egD4QG+cWfp7p/84yXyVR1epCjh/SsqJ+DGP8tARFA0rY9o6F4LNjkbU4+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/cKq6zN71WV1MJrIOLxWJ0XZrqIg7yqs3/MNpoYvB8=;
 b=YQtrtJXL3kUG+IqNHuq4TY/sOPDSMD+74Sok2tdOiNzl7PHs+Mdi6bFTcccHqmE41eyuhZYweAbOf8CjqyqoBn4SLEiVSSMNZWDFlNRyzuXEcA/7ny+3gPhYsm2ZkQENP4jLQ6s40+IKRNMhU1NLN3xZiUYu8v9RabVuFYnHWC94lDzLCBW1Lb0xuLn+n9iWPX6fAPLmLFfG+vdjTXlQXE8bk66vkaFoSoirsttn9wf90Ed0DlMyxucX818pyqfQqC7cO58ZkiJVr3mofivLT5y8UtjrXzaDwIiKdQGNmvmm1kAZxumr2l5z1+m7H9v6OW0xjQd5WdZMGHtVby2SuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/cKq6zN71WV1MJrIOLxWJ0XZrqIg7yqs3/MNpoYvB8=;
 b=b32z0FY1FrhiTC3c1xVmNJ2GDKBH8xwatPWyvDjAaIJbwNJ7t0EfFoUFMAUjHodQo05dyUluTQCFAhpdAsBY9x9FjP2/yAZTfE2ZFaKzUKdp1P+SjXHSTLuADcEoYRDEqfbAWKqBGRL2i2+qJvKDrLDC88qtLUx1CFnGeQJ9QdGpfj5jEOQybDIylBzH64liAaSi+soFAjiTNE4+9SE9cnWvOh328ioqw8Nnmly/iM50E9ZAEeOqXv7AbvsS+jGzoac4LbqhyETKMcoAxsiLtgfjLMTirMrK/YmSPaRQIaYPnh70+7u8/1Wmzp3mvlusPT/J6Iq31yXlq+HuR3s3MA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB376387.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:c8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 02:57:39 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 02:57:39 +0000
Message-ID: <2b16a58d-09b8-4068-ad91-3aeed012bc9e@efficios.com>
Date: Sun, 8 Nov 2026 21:57:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/29] cgroup/cpuset: Reserve the bandwidth in the root
 domain a task moves to
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-22-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-203956@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-203956@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::22) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB376387:EE_
X-MS-Office365-Filtering-Correlation-Id: 9221267a-f415-4ed6-4b00-08df3e0d370f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|1800799024|366016|5023799004|4143699003|56012099006|261021121427099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MCW5X/0Vg4u0EvYc4j7HGe8zirpSjO42DjflGOpmlrwuGoCnpSgbLH3t47JyzacuuwUHzz2Q+0LWXKlsQkvDCBlOixDe6u4Uc3lC0NY70tcuWAAk65supWG6pjtUAdxBNs7vtuQKVsXrfe1cQHx1mPmCHJUfhROAkkJGiL/vx6HmEcg7bGRn7kjja5nCZ4+TXq7oDYn0BgPqNOJZ6GDzvmW08tA0R79zY2JSpUTNJg0D6jeqCHwDq8N3yAjJ2HJkVfpEcDi/nQaVuYG/6swRto7aDkg+UjMh21Li4WM7xOPRGlltUuW5BgRh86QZXTMfIjuGKQtwl8GqgdR1E8WghF7HEKeHTv/fsYaMF5b4LEknWPDRsZSOZuliUQvCLQHpPnolyjMVeret/RisDhdNjrJIYvXq3uOAvJ7+PQUn0iOB8YCN4axHe9HcGW14Ne6zF2JuHjUrJU7bV5Hmryn2Soi4Ld+xPLI2Z8rcnVsFRGjf7nqWyOOQkK52h9Otwo/i3mis29PMGBLHMYEayrJVStJNMgijtgJb6lYOkY0pVL84k/MdkAzcpNO8syMjXVIpsrJLO/VrYkLNr0N7jPfQreHNs9XjgyepWLotqzDXZ8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(1800799024)(366016)(5023799004)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1p3NHY2bjlsZ2oyLzc3M0M2cGtMYVdqMkNHNFVVVmUzK1VQOThUN21hRERz?=
 =?utf-8?B?eU8rQ29IcUJwckk0L2ZJV2VnQ1pTdUdRMDNqUXJTWjVzQ0I5QUEzb0h1VEpC?=
 =?utf-8?B?enZrZmlscm5MM3QxUk9aT2xVSmRGV2dnYWVQc3IwbDV3MU1DTmNCYUJwVGh0?=
 =?utf-8?B?YVhXcWdSTExKWFpFVFQvUHFXaklwQjhEMCs4anBjVnhjZUU3dzQ5am9QZFda?=
 =?utf-8?B?Q1VXUGsrUWlrNG13M05xNGVmNU5sTS9lOXBkZFVWeWRoNmNBUW9SVFJKSXpC?=
 =?utf-8?B?bTBsUEh1Z0U5N0N6R3MxdHowa3lIeUpyVndVdm14Q0p5WFNZeUcxRWJ5TjhT?=
 =?utf-8?B?dlB1Q2I3Zi9UbTJTS2tLUEhEZjIxVzhXelBGY1lNVVF4eUxQV3FSTGlCUnBK?=
 =?utf-8?B?TlpHeWRrSTN5a3ZFNnVsaGsrUHN0WU8yMTZpVy9zbld5d3E2c0dHbSsyMDll?=
 =?utf-8?B?YkpSY2JPNnlCVDRWd1ZMcVg3MmQvZ0J2SDNxWmhRUjZ6czlZc2Q1b0JmK3Vi?=
 =?utf-8?B?cExqcWNJdFlsOXR4T05tS1JNSDBKQm5NMTR5S3hoTUEwUDNLdnVDSDFmVW1p?=
 =?utf-8?B?VEN3ZW01RzJFY1UxVTBCciswRnF5MS9Ta0Iyc3RhQ0xFVlduTEcvYlVkVTVX?=
 =?utf-8?B?RzMvK1I5TkxNZ2V6dURDbXhqWUdER1dMb1A0REpxMHVOdCsyTFVpc2hsai9Z?=
 =?utf-8?B?SXc5c2piUEFyNkRmSFVWVldNakoxRWtlMTJ4UTFyb1gvMHRWdDFsVzluUmNp?=
 =?utf-8?B?M3hYd1pWM3dMYjVDVDZRSGpya1VvOTlmcFk4ZmV1QThjZlJRTFhlaHVNVnpJ?=
 =?utf-8?B?WXg3TWVrRlZYL3FqcTNoNGx3dXFqRlJUcTFrQjdoTnBKQW4zOStteWJwRGV0?=
 =?utf-8?B?SU51WmI0UjVwNWNuQkg4ZkpjMDFObVIwUmRRWURGc1N0WEhjYmY4N3Z2L3JV?=
 =?utf-8?B?VzR5c29GQk13eFFEeW92MzFxK0lPR2VlSUFEbjRzTmE5V3F1ZVNLa0lxSE1X?=
 =?utf-8?B?MjVhbTM0UG9IK0k5a3hidW1BV3FBaFYxdWVsYSsvb09MMm9MSzR2azBwQlBi?=
 =?utf-8?B?M1lDOGJZZ01OYURydkdMbDdxR0tsTitxbXZDaDFlbnVEQWtqK1pxUDZWVDQv?=
 =?utf-8?B?MldFTXVmTFljU2t6NlJxN1A5NDZOWW8rZnhWZ0c3dGg5UktmbFp2eG5raXBo?=
 =?utf-8?B?Vm0vdjJrUDJNTCtkWlNDWWFCSCs5UzlSOTJDZHNpM1MvTTU2ZGxRWnpMTHVr?=
 =?utf-8?B?eGRyaXBhQ3FOQTFvT2hPWmhBbGMyMWtPclBrcXYzWlRpbk1ZREo4QjB2QzBS?=
 =?utf-8?B?RlJEc0ltSlR0N1g4M1M1VVptbDNuYThybVJBMlE2Yk5HeUVFS2FCUzQzV1Jr?=
 =?utf-8?B?aVBMRWNpK3d6RlN6S1dISWg2dmVuamxlU3FEb3lrMjQxKytBSUtFVEFVQjJB?=
 =?utf-8?B?QWlSMldJMWo5VVcyajVORHZCcUZoSlVGMkU0YnFmN21jK1hpRUFWS2lCaUYy?=
 =?utf-8?B?UFBrQWp4R1RrSkdzSXNJUkFLMjBjU0pMNEc3Q3JPKytacDVMa3RITjBTWTdU?=
 =?utf-8?B?QlEvMHBDemR1VTQvYkZNZ3ozTzFNVTlTSXRKSzlraUpsOW50TC9xekRncDhj?=
 =?utf-8?B?MXJOdUIvU1pkclkwM1grbXdqWHpPME9DZHIvV3E2T2dJbkVxZGgvVWxZMWNM?=
 =?utf-8?B?VjB6ZC94QlhUbyswb29GMTBOWGFpc3M2UEdKSVBZTHlPODNqRWhWK1gzZkJO?=
 =?utf-8?B?V2Y1aEJjRXlnc3l2T0FPSjBwc0xvV1hta3ZRY0RBSkcwOUk2UVZuc2hrZDBZ?=
 =?utf-8?B?Ylp1REZIK3hRM0dPaEd6THJNdnJ5dk8ycnFGNFJjV3NuTmIrdjNERUI5TkVI?=
 =?utf-8?B?S2FGVlRMckpQNDVqZ0hDRUwwR1lSbWNTS3ZRd0FrQjI5c01CNlo1ckUwZ0RV?=
 =?utf-8?B?U01UZWU5RDUrVHp6TWdmVzE5Q3hrVmR3cnErZXI1QUw4VXZTL0ZQT04ySFFr?=
 =?utf-8?B?aEtlQ0FOWm5vcGJoeERUMDZXbDdOeGh1SjVIOVFkWDdIY0l0MlhJdnowRGEy?=
 =?utf-8?B?SjJLRmhBbnJRbnRiZ09pTXppOWZPclkzNkc0N20zQkNtTUY2bS9iQlpjUll4?=
 =?utf-8?B?V3hEWHlOa3VTRmtPbnhIaFcxTzdxRFdZWTllZXl2REtIMUFTNnU0Y0FwRUZs?=
 =?utf-8?B?eEExNWJBTjlNYllMeFdyb1lrRSs0SGJuOFhBd0ZkWlkxbDdUazJFMngxODZz?=
 =?utf-8?B?NUFVS1VBVkpUbG9aTFRyV0xvdk5zc0ZGK2RVVkhpQXFLUm5CMVhxbWtJUmJD?=
 =?utf-8?B?ckpqRmIyL01vWlFDb3d0Y0ZEN0RVTzF6U3dPd0o0dFZwWXh1RTFpZUJNVVZ3?=
 =?utf-8?Q?z5E9qQC1n56vl7A8lsh8oOkp3lNPqJq2VSfQQcOKTiQHw?=
X-MS-Exchange-AntiSpam-MessageData-1: cmAdjGYBJMVWZYshrwB3ddgwGKGwdfVUXIc=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9221267a-f415-4ed6-4b00-08df3e0d370f
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 02:57:38.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEylDRYMA7sqigVJmugpr+lp15K8fzE5US7sDtNp0C7wYcSpXToFZYdeCO+bsO0gyEDyG8GAPlZnxyQl/AYYVVZtZigwdiQ9k8xlvt9dxyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB376387

On 2026-11-08 14:32, sashiko-bot@kernel.org wrote:
 > equal cpumask early exit skips set_cpus_allowed_dl()

This is the early exit of __set_cpus_allowed_ptr_locked(), as on patch
18. The next version skips it for an attach that reserved the bandwidth.

 > __dl_task_bw_move_cpu() skips move on spanning cpumask

The attach reserves nothing here, by design: the root domain that counts
the task stays in the mask. If the task then has to leave its CPU and
lands in the other root domain, migrate_task_rq_dl() moves the bandwidth
there (patch 23). So total_bw stays right. What is skipped is the room
check in the root domain it lands in. That is the same for every move
without a reservation, as patch 23 says. The next version states it in
this patch's message.

 > per-CPU reservation mismatch when task_cpu() changes

Thanks. The window is real: a wakeup between can_attach() and attach()
can move a sleeper, and the reservation is then not used. But the
bandwidth does not stay in the partition. The task's CPU is out of its
new mask, so migrate_task_rq_dl() moves the bandwidth when the task
leaves it. total_bw ends right. What is lost is the admission, in the
root domain the task lands in. It differs from the one reserved only
when the destination spans two root domains. This is the same as for a
task that changed its affinity or its policy in that window, so I leave
it as is.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
