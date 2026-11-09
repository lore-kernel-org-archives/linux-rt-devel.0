Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794193096;
	b=Gk7aDIVsBM3j9MZLCKuwIdIn8XfetT6ftL1O3uwGXfUU8pZWVfC1UTJhB4duSLtZGJIv
	 KwjovXHvf1ZbQEKoh1x1mJ4MWOxsz3cpRhsXrvOUTu3M/V0H19sr+LSUomj2QcYYVrELB
	 yn9MSDhDBXxD9YnycpL+I1A9r6dt98YpQ7VTz2kKWnIn6Cnt6my9AfE/758UC8Ysna0eF
	 FTmnx+HegGPMyeTbNs50Kvh/SeVXo4tO39MC9ypokKUGzA1Z3lod9ZowazWf8Ufqg28OE
	 2KqHxtTAMvZkIwtQPbsvbpWL6pp5u41EOXqOtiU1rUb+aCpVs3RGUhRFPUf6PLuP4Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193096;
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
	bh=eW8HjNaXFvBfQWQ/DoxiZeKP0nLYy7HJrQ2yJ/SOw80=;
	b=Z4xhRS74uC5J0EHI11XpIDNKTiN0/1M1j8waCMwusUKLFe2LhirXhyS7BEL5TM+1QRMX
	 j8gMNQ+FF/yvMtOnd3H7Vf6xvj7dsvoambJRpDWeQ2IntzhwlBpizaHWbNK0zdUPxuG1G
	 qjAEPrE6P9GOz+k4Tt6tkfV8+e2caecdJfaufN7FkV62kEOhMIBUxHVsmMsBfo/pSKVGs
	 sgKLtoIJqAMEnjq62NIWEOKaa7u2y3sOj3GZEUBrZVxUjPUY/NpMXXwmrtiTKvDDuoacU
	 IirZXNGTq507VIzUoRgRH/4btfATy2eHg49CCFWkDg2Xb8XGmZdyJgHN5TFYWu9DsNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="f84//GZ4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.91
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020091.outbound.protection.outlook.com [52.101.191.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FD606A323;
	Mon,  9 Nov 2026 02:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 720FD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=f84//GZ4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4oZxf/gizjVQ1d7JtXLS9t2zRzWKWiFDChlDqTk/qXmHcxPbWhnOEb1/s7SVxncuTKfJIBzqzkgL6+yTJWXNeFw/qblm+2flUYYWw8V+ZY+im4hLmZ+5vx/SSDzakzbhIwffMR/fD+xLzHgkTs74x99Xz9vDjcPPMSXNxXiEgxkcstGuMHz4JWeZ53gfBfHp4k726JLZIH6kVi1rzAkePpcSdkvP3lNnKgjOaa/kKfX+zFk65V7/b3jIVOpfbPNIbpDFVoJuaozK6xlRoBuFJlXDjV6HWYkJu0DkB5PGMy7EmNw670V6XdLnA1SzfKffCnwDEyZpMi7X7njMXiUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eW8HjNaXFvBfQWQ/DoxiZeKP0nLYy7HJrQ2yJ/SOw80=;
 b=eprNvLNysigOlVxiKiQ7kUVkrmi5zxw/GWf6aeaqDT3w+Qtx9WNPCKmAXMqKq1z3NkqEneMQtl62vuLoFdIOVroq04uZOuY7JfWwVNWwhnho3+VcTPlLaBV+OeTey44pPov8MxgWoPUBaMRkojcqaDhXwTzGLm8XUXHSfqdHWNlw79G2F+wL1V3Kd0z+UXew+LVFNtBEwkYwBRy6SRBUhrUodySV5hCuJt1zXXr8+2xNEXWA9QKyLDGAukGGoeKbsfZ/8ZtHDjIGN64bQuqSeMbk6G7ZabgUr4+5bMN29Msy4YyciF/zBH+mAOH8x60DhjcJJXbJf0qtWIqYuNgXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW8HjNaXFvBfQWQ/DoxiZeKP0nLYy7HJrQ2yJ/SOw80=;
 b=f84//GZ4YwnIHfcfdpagNhzeuRyaTOs3a+26pP/y+WyWKkkO6Z453gw1Bq4shvaUn1wDswfidg4qzhpmVjKeuEtHGAscBYIwOt2fqG4Y12kRI5OgajDNMMT9sI2v9WewcpOx+xYsPvZer7DLH1eG2wvN/Gm0Dvp0cDgXlIch+Lc/mc9potX1OpiJyrQXrKROhu2cc2eVDZe869L3zWPrA655njbcEu4Y8Tz3S+ajZyr/X466iC2cqthiKpkXWxSihPhu1asU2NqU8sy2N3LmZaf91ufPOFLlE+lNCKlwAEybNBMGb8wfN4S152IQv5KR51zLXoX0mfnPLCZSmIklig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB376387.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:c8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 02:58:14 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 02:58:14 +0000
Message-ID: <cba919a2-c540-44a2-af3a-bbade50501e9@efficios.com>
Date: Sun, 8 Nov 2026 21:58:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/29] sched/deadline: Make a rebuild use the CPU
 recorded with a task's bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-23-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-203947@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-203947@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::28) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: b99f0a1e-d039-46a3-8a45-08df3e0d4c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|1800799024|366016|4143699003|56012099006|261022105027099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xxIilez1+x9E2aIWfC2Fu1Ur55B3qiKHKOXwnHqWJb+QUtWiNQqMUVgQ4C3riLkiDeQilunSRJJzAam19cHidQR1pVmQEZ0xkCMqn7r+EuROkLmgjh+Aj047vZFoluvLjhP1fZLLtMuF+xfN9/aZ2jqSIA760469e6aU+svAizQCW9ySdzPyu3AGxyxTpuSuRguDpXUUP8DJCaWtHxKq/SNQGPNAeLO3T8FxRVbXy6TEYESwj6J+ncNfebbUQDr+IETsKJOKonzgkbB+LOgo9/7jDJrQXfp63DkOElhhS6aK1MIbAO/16C4L1OZm9ShM9pHk09h3uIg6JxFHPJzLZ22z/0PV5HV3D2rwydPM6hCvC/WkMxLh8WPGEcwuzJcL3k1SZ05ttI1qqK7PD0YLKCfyS15JpHpf21gP8LYK3L7/1TKWJn8DAWXi2DGhxVLN08JWltphcOuHTOYsGagY7TIPdq9T+zq7iQKnxYWaaVXQw0+DXDheEdSh5SkgxTWhO9ETZSM+AeX27teWBn3hM9R84CYAdK//AhumUdm/RG9JNUdxbpSW8zfmzyL6tK689Kn5Dsx85Cokko7i3P3zrPkq11GtZ/usNVWTciFg95o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(1800799024)(366016)(4143699003)(56012099006)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0dvZjVzS1krOElHNDZNNkZ3eUxTUzF2eUJ2eUpGVnZIVjQ5dHM0UVk4VWxx?=
 =?utf-8?B?ZE5zRHRWNVdMSUwzaHhFeVJTQjZ2Szg4aklDLzA4VUs2NDZQNlF1REhXMDZY?=
 =?utf-8?B?K1AwcVB6bHE3RzB5bEdLTXFIRWVVb0Y2N0p0bnc4R0JvZkF2bStPejlNQzd3?=
 =?utf-8?B?MEsrVU1GMEpPUmVuWXc2TGNxSjRxbHJFMTdiT3RXSDg0M0xQQVpxYS9FUmFp?=
 =?utf-8?B?WGVXeGEvc3FZamlETjdrMUJBZVNLU2xScVJydTNycDlyMTZOcERscGNJcXYv?=
 =?utf-8?B?ZHlLMUFheFdOYUZIZ3RITUV6Ri82bDk4VFpTQXZiMlVlOGZIbGhaT0IvaDVp?=
 =?utf-8?B?ZzJqQXlUSG00MmFta3Zqa3ZVejNwYi9TYTIvdWE2aEVubEpha0h4KzJUbW9x?=
 =?utf-8?B?RzdKSTMrZ3U5T3FtNWJtclNiRXMrOUoxY3ZrVEJtQS90MkZKd0tnZXZ0VWFO?=
 =?utf-8?B?WTU5Ly82NDdLZ3FUdHNFRGdvSWl5UENjcll3cW1NZzNjNllqQ1FjNXNCVHdS?=
 =?utf-8?B?czc2anNYYVBXZkdJYU9KaUYwb25hTitKSmJCT05GSTZFS1hyNkNUKzM4RFly?=
 =?utf-8?B?MWJQM1NEaG1iYU4zbHorNy93bE9JQXhqM3hWWmhkbnVlUWxhTFRQb2I5bjRL?=
 =?utf-8?B?RlJIZFJJYjdiemVlVzNYOEtBZ0gxZjN2U0JoVkFGbGRweWpZZEtOK3Y1L1JH?=
 =?utf-8?B?MFpNcTdBWElaUEl2TmFCS1hRSklYUDhWdjRPWFBUSGVkdWpReUhvd2haZ1Yw?=
 =?utf-8?B?QlQyMGNEMjRBaFljTnJZZHBsSllJZFQ2Q0pUWktrRkI4NEFEVjRuRHJMb0k5?=
 =?utf-8?B?dzQvVitQdHFpWnFhRDhFbmxZUjgyK0JwTmlQNmNTQUJobmcxSEYrWmtMMDFi?=
 =?utf-8?B?ZEZlMFAvZlQ0cjRCbTFVNW5iZnZIdnpDL2xuTlg1NGtBSVpjdWt5WjJpaTJO?=
 =?utf-8?B?UUt0V1gyUmRXNFZnNmV1T3NjS1p1ZUt1NzQ4eTJaUi9WSmlxR1NDUWFxb3VX?=
 =?utf-8?B?aWFxY1RiYnQyT2IyTHVmYXJNWVNzNXBNcWZmRisvc0t2K002TjVrMS9mWG1U?=
 =?utf-8?B?eFFzenNMSERIZHFpOEN6UGtCeUJ3MUVia0xaWjBhTDVpRG5TUjlXUGYvRWJs?=
 =?utf-8?B?bnRvOGtOSmlRVWNSZmlqejNiamU1YjloTkc5a0dkczUrL2tpYlNHOUZyQXdH?=
 =?utf-8?B?aFNvWHZWMVB1MGRBLzBCVGF5aDB3Q09DZUtqOGpETVlhWVFnOUJOZVdpOVBT?=
 =?utf-8?B?SDYwQ2Z2UEl6QVU0RFAzeC9kSjcxZEZIVmRqdmU4VExFZjU1VElLd0FoWGNE?=
 =?utf-8?B?NTgzVDAvQ2xBR2pVVXVNdy9sZUd1QnRKVXcwM3dHWGp0aEtxcW1CZjVDMHFU?=
 =?utf-8?B?M0Q2aFJLZ2JEOEhOd29kdDJoZndBOWRmYkhYTlNRWkFmbGd6aGFQSk80SDM4?=
 =?utf-8?B?MUwvUDJMdnptSlhNMUYwaExpSUlEdmJuM3VrTEYvNU5Gayt3Rk93eXdxSG82?=
 =?utf-8?B?dHFjWFY4M1pMcUpBK21FUnNxUWltdlMrM0V1VUI4TXZLamE0YTE2THo2UHRv?=
 =?utf-8?B?aUtnL2hwOTRzTDJ3a2hjL1poWUhkeFpzRkNQeGdvYVIvNXVRUDVGTU45am05?=
 =?utf-8?B?WWxSdEwxVFoyWTV6NmRkWFNVT2M1aEsvdzltVG5ZV1c1MFdkOFlrUThLSzBo?=
 =?utf-8?B?ZE1ZOVZoYXVadmsxelZZQkNYMmhLZVArTzIxM2Z3ZGdldUdzLzE0eDJobzNO?=
 =?utf-8?B?TDBGaW5KdnNyWENEVEo2OWpCYXVXUGtZdC9NN1dEQlNoaXRjQXVkaHJIM0xJ?=
 =?utf-8?B?ZFBzZE0rMHZjUm1Rb3UrS1Q0d042TVY2dVBIMGNDZXNQSnZTR21PMVFuL0Fp?=
 =?utf-8?B?akwvU1U3eE8rQ2Zwa0QyaG9BeDMxT0QyQVJPdXlwc3VQZHVjamJXNk1xK2ov?=
 =?utf-8?B?ZTBRdlUwVWJUdUhBQUxBWlprY3Z3V3dxZEVmbFUyYkZzODRKVDk2cVFDTHdv?=
 =?utf-8?B?K1JvT2FHUHJYcEE5ZVUwSWJ2L0N3WmlnTW5EMGRROWJIaHRDM2lkTHd6TFA4?=
 =?utf-8?B?S00rdEFHL2NLMVp3UzF5dnFycmdRdWJsem1ZT1psRFRteUg5Q2s0YnZmdFQ3?=
 =?utf-8?B?eUczQ0FIbFlBQkYxMndGcFZTWXpiWmUwMTFlMm9PTTYxS3FKRE9NcGt1VTU2?=
 =?utf-8?B?bVJ3bDdPZlA3UTJPUzJKY2ZqOWtkSGE1Y08zU1l3bFQxS2p1TnFLaGRCVW4r?=
 =?utf-8?B?TUc4alJVOGw3V0RBREhQdTc5Y05sYnYwbkZYTzZGQVRURldsb1dqMTUyNUJD?=
 =?utf-8?B?NlYxNXBGL2dFU1RhcURVak82VFZsMVBFSkJZSkxtam91QWZOYTZVd3NoenVu?=
 =?utf-8?Q?3/0ZsPQ3aKRcv1ON2RYErfmZPe4bL+ylzH15Z3///Y0kQ?=
X-MS-Exchange-AntiSpam-MessageData-1: s8NpxL/xBPLmz56/AAhW+lIN72kWWewIfPk=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99f0a1e-d039-46a3-8a45-08df3e0d4c4c
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 02:58:14.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C/OOpR35Bsn5SrCsvd8Z7xYdm25W1pCrNBTWJdnsexe8rsdVXjXDhi+m8PJP2Elxh7XL83CzXO/N/KlwoiopfnhJGr/x/ig0HZ0nnjpnmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB376387

On 2026-11-08 14:25, sashiko-bot@kernel.org wrote:
 > wrong root domain in dl_task_rebuild_cpu() on empty mask

Thanks. The path is as you describe, but the partition is where the task
runs. At its wakeup, select_fallback_rq() widens the mask of a task of
the top cpuset to top_cpuset.cpus_allowed, which is cpu_possible_mask in
cgroup v2. It then takes the lowest active CPU, CPU 0, in the new
partition. Had the rebuild asked the cpuset, the top root domain would
count the task. Its wakeup would then move the bandwidth into the
partition without room. The case also needs admission control off: with
it on, a deadline task's mask must hold its root domain.

You are right that the test of the record after the cpuset fallback
cannot succeed. It serves the other path, where the mask has an active
CPU. The next version makes that an else branch.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
