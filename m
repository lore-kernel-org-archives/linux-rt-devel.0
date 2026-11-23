Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442438;
	b=grFJ4bABWZbB2RAIEN+chImUVU++9rQrKmiJ2NufmYWDXDgHrlEUobaLe2qSkH0NrAM3
	 LKd6LNcN7xGd+6EGakEOiomPqnU2QkHK/J2KjcgkAgcQBO8N5423ImQwMj/0TNHfsPq2M
	 kLKHx1T8F7m4oKGj1OL7qQfoisk6H94w4nn29rtmvwVhIeYm74xkzkx/PJramRdxNMwxN
	 Gp/Dc8xx3Ot9O3UOkS/59IWKeegIagm0WvoWuI46UkDoJ/gKca++UB7rixNXCw8EOKl9f
	 CBsJbctLHlxT+myFB275U+nlsY2KzWuhmUhB8wmmU822ayrDyq8UZPTWyAKzJxM+MDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442438;
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
	bh=CFNd4oFYl2EQJs2yrWtFGiDya9aJN3IOKj9NkAQwrNg=;
	b=S573G+eNlB7/+WFndce1h2CBSz0g9CKNushz36bPQj6mSFmPlBBzbDTdWXV9idc95LRi
	 23KQ9CZzux8Vy/w7vgwMjbaYDaeY46hHF7tXPR/WESgOZuDIc0FrEofJswxalpzWdazrO
	 ScwpmZbhJPf3rEdo0NXTHeC3NV0gk575S69jS9upoXFk1Q5u9LPXdm1wxqfjMaDSCLDID
	 nOZpwclkN+FqGI1ZBi5PdLC6o4EKpiOB0/boqSljd0YoRFXjJ3eqDTcfKG3G1CH/couKQ
	 fpeR3VbSdlsbQOqw7Jk3KyVklA5zgR+xLd6ib+adZ/9cG+HKexnoMPu0TKogijy7Cnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=c0ZHkjrC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.117
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022117.outbound.protection.outlook.com [40.107.193.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE38606A332;
	Mon, 23 Nov 2026 14:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BE38606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=c0ZHkjrC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPIVbLnsXDWKu0OMOT0UT9JoLgw7YTnAFnPX7sYNrqN+ElReIwFWknFH259hksueQhSuAQMkVVfDgNav0RnNDrG06aZprp9gpDxRv5D32KmVRH/XZf7VvBvpAgiuUNXRacxGnGwA8ashy/qwEsHWGMqbjPMap+17nlNHtZMhGUlV/QkfYngwBWNLTqy5p9hM6dq3aYdusMFsP82XeVFLywpw+5OmJrfsSQThSifmsGRb2U4ywarFUW3CN7UlV85RVk/u2kkpW7GKAx3FRlH5no4zLTBnq8tUGyHsh3ogyyxWcZGpu5ho4BR5IPhopDuSvqSwxxACQwFrAuedcqhHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFNd4oFYl2EQJs2yrWtFGiDya9aJN3IOKj9NkAQwrNg=;
 b=gP+/3+EFZTPv+8s5fBMGi20bdGSYCHt8HcuDcL86TeUtOZXlQmZd4OYeCFUdiO0DYFus2LsNPg9CvgVIUm5ALMhmLvidZ1lMjYOveDh6XQ0/GGZ3WtjarMfrdhdGXszQxRVAlibsLWxj6RUQ1FTtZTv21M6lgkoimqn04FuwiuPUzPsYxoobaStBayYCsvR9c1LTmkIP41Z/1z0c2aB8qrjVF3kMOA1UnyGqDI5bob4MvuIvmZk89GCtBHRNRNyX2jbB4fVig08KZioBdWMcgm42ZKMD7CqAbg/xL12+GllCsAGFFJvRAoVmut9oWigSng2s5B1N0mukB3ktb9ak1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFNd4oFYl2EQJs2yrWtFGiDya9aJN3IOKj9NkAQwrNg=;
 b=c0ZHkjrC/elRJGUL3HV0+x494fmSOxwv/XRaDFlKzfTRgSXJryTk0OqhjtivSORB3hnF88+H+Uq7yi0ohqxTGyJmoFZ2NpzWeOHatL6nz6Fg1ehqLdvo2mAjA5mI3bM419I1puKNyE14Tlg5hM5z6+wOhRYxQYfmiJ8qfvaOGPgoAY0J9RDOA9CP+OzDJrbR9zCgwjcTl3sTm8p78OpgJdF+HsmrBjCnpktbj2MPooBVYk1blUEELK+jGFnmfvvXA9h97S2uuH35a7oP7KfreAORLiOJeZWQDH0LWbc1yjzHZuX6DoGFntRkrzklouOOrqUo7ZXZAwy4ZNys8THqng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB452843.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:18::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 14:00:36 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 14:00:36 +0000
Message-ID: <1ae1a1ad-7b1f-4d5b-82ec-873815f6009e@efficios.com>
Date: Mon, 23 Nov 2026 09:00:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 30/40] sched/deadline: Start a period for a task
 requeued onto an rt_mutex
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <6c7be87e201d405bdf589989cb45afca9160c2e4.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226170@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-226170@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: b091dccf-c491-4260-7ba1-08df496a25f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261009223027099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cEfzm7z5uWKZaTN69bXa4rtNBIep45yWSuhPODOVpj+siPrOS5wnIAlCsmaGzFSrDEBP4tlMno9ObrhC86oceomcKEGpgrQRWnu1vsZ+RUk9z0nFl8YKv27M1a0vulhbBJH7ZpZCKy8tgskNjhVibCsCSJspbfLrmaFo+I8/oa0LWst5PWLwgAmLHsR+nWUiRXx+naRAsk07csk/YdtzqOqqHZ4gWCEV6cKoCWZiurTMDh2k7lcnJ+7mYSF08iLNmkS2wyp5sBCzU/LJmY4W+7l6CjGxIbnXLp4pRobFhiCGTR/X6KB8UJP1/79cbjE94b00loItcqmPw9MVv/grlByI3fEKP2Xpe5B2qw6H64fU/GDnICYTJCSqM7eiC+YBAEmo0pRa2VAPpxjB5OZaDRZF4CMI4NaRsTPNhiRY7hSgnpbLft2jftniATzuCMY2Cwq42OvXlwgue2cKRMSk9R/gRz5r8f+uhQMD/egjWaljvA2358Rl9eYTL8rsyMDSCL7khRHpTHxO3PKZybEpgpyHmeJ/qrpCHL+vdd3ejGoGP3HUpwrlw6XdtAcWT7BEwyKw/2f0S6CbVm57rBrRYIuQ+RSGhpb3EdSkRdXkrNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnlRRnNRYkV6SGxkNkxFNnhmdCs5Q3ZuVFg4VVFKWW5qUi83bk80T1N4ZDFK?=
 =?utf-8?B?RGtrN2UwTHFuSzQ3S3JSWldsRUh4RlZKWEtDK0hhTTlIVUhBTHMyNmJEZ2tp?=
 =?utf-8?B?Z2JVcGRySWJ3U2dCaDh6R1ZCUVFSM3hTY0NQQ2pGSjlMNzlacGZJOFdXZlpn?=
 =?utf-8?B?alliYWNsN2lTVytvekQ5K1F0azZWY0dYeDF3WmhPWXZRa3BubHlJa0d2ZFpr?=
 =?utf-8?B?TmEyRytOMjNWTWhuZTI2SVV2SXRsOHpxc2p1aW5KYXNsa2VkaDBsekhCdWlp?=
 =?utf-8?B?SWQrWGo2bzJpUlpJekZldGlhUEQyWGZUS3VFTTlVTTk2Sm0vbmVqM2Jub1Mv?=
 =?utf-8?B?U0dQQ2N3UTJ2YjR1elpwSlFyR2ZFMXNBTThrcUdxbzcxM1p0Q292eTFHUElC?=
 =?utf-8?B?RXUycUptM0hDeWNXd1pmTkM0Rm5IaVBZc2o3ZXJxamI5WHlCOUhxUjFjOURJ?=
 =?utf-8?B?Q0NMTmx5K1NMVGd4ZU9QS05qcVFaS0tMRWxCdVpucTVHbUM5ZTRWMjFiU0tj?=
 =?utf-8?B?bWUzM0t5SlIrbXJncG5rV2dtSVVCelZ5M01scHNoMUNCQU81QU9oVk5JQXpt?=
 =?utf-8?B?QmlMQXBHRk4wT080SWFwNXpzRUcyM0lHWHBVMGk2TzUwQzZKS25jdmlkSUZu?=
 =?utf-8?B?Uy92empmVng5R3JiWi9YTktydnU1RUF4UkdKbmVOMmFQOEt1Wm1vMlh6VnJR?=
 =?utf-8?B?V0IvOVowVWpaaDVmNGtQN09kYzQ4MXNxREhtRDVQcDNSamFXcER2V1JNVVps?=
 =?utf-8?B?ZWZSMmJmbklRNnptU1NCZFZQM1Jvb3pRdlZybUZWaHA0aGxLZmorN1JEVEJN?=
 =?utf-8?B?VWhadWpzUURDdDlxNkNhZlhndHNUeUd6dXlmU1E2cjFad3BJcGVnMVRPaGMr?=
 =?utf-8?B?K28yYUJ2MCt0V1pkODYraE1qaEczRU92ZmZGa25LYnhpenluQkJoU1duUVNi?=
 =?utf-8?B?RHFSWkJyQ3V4aWY2VmpKb3NmWWVzMzBnMCtrVXBYSFpBL2JibTBtYUZMWkJ4?=
 =?utf-8?B?NFlYZ01td1VULzRtdnhaTHMrZFAvRE9Cb3oyckplRVNwRzFqdzFOU0QrSTNs?=
 =?utf-8?B?b2R4UXQ3cS9NVGkzd3IwWlNnbHl5R3BZR0RrZThBOGhQdDRYV2NtZUluc203?=
 =?utf-8?B?VHFzY2p1N0hVTUZ4d1U3elhlTFpTaEFMY3RYbXZIS0l2UXVuaGRlRmwxZnZ3?=
 =?utf-8?B?MWwvTGpxY0lVdXN6cXR1Tk1tTFYydlpwWVA3Z0YzT3h2aVJ5YXk5YUE4RmM4?=
 =?utf-8?B?VkQ1T21TTGZwWWxCbVhwS0djNDZQSmlVQnRQaFRrMWtoWWM0Rm8zdWVacGQw?=
 =?utf-8?B?dHN5b202SVNRZEtReit3Vk8rcHVjaS9ZSzY2ZkVtb0oxbk4rM2dSQXFwTE9K?=
 =?utf-8?B?RGNCZTdqWkJHdFhvaDdKMGtJamtJamprZzJxR3ZqbG84RThJZmJaNEgvVnhL?=
 =?utf-8?B?MW5MUFV2UHJmRVd1KzR6SUpKK1htOXU1MGxVR2hGQXNZVnhYMDdQYkVXZlMx?=
 =?utf-8?B?OTZzUFVYRitJYnN2WUdBeWhqbjhlcVFhSTR2dUJ1ZjV2OGhlb25UUTFYYW1K?=
 =?utf-8?B?WmYzcnY3NkhjZ05DWjJ0cWdmdlROTHBPcnlVYktJU3RHSTYzSmNXWkx0azA5?=
 =?utf-8?B?Nm5kSUlLWG9aalBWSUM2R0l5VklnTi9vb1ZDK0tvNElSTWR5MC9zK1JSRC8w?=
 =?utf-8?B?b0FjaXBPaWxRUjZGY3NxbGtOa1o1OGVGUGNoalZLTjVodi9iN1N2Y2g4NTQ4?=
 =?utf-8?B?WCttUnNVYlJWcVo0QURvMVZPNUZLWGo5ZnZqN1ZjbjEvUTVNS3M1aS9KWlRE?=
 =?utf-8?B?YjZiMlFoaGlWTzZZVS9TOURnV1NlRjdBaFJDVW8vM01xSWJBMlFGbzVUejhr?=
 =?utf-8?B?b0U3bzRzQWtRRU1pTWJBaDd3V2pTZm9LaEJtekdpc0dJM2pPQU8xOXhIQWlp?=
 =?utf-8?B?NGg5YkV0OWdRNjB2NUpDMnRwSTB0TDBDRjFIRFBrSHdBMlZFdUh2dGZnVFoz?=
 =?utf-8?B?M2xDdG1KUDZiNVhQNEN1MnRDamQrNThLS3kvNkM2NGpZbEs5dG80RG5KQ09j?=
 =?utf-8?B?Z28rSkNiTEhQcXhNVzJKbllBcVVZMGQzRkRLNExkRUhieVJaZTRZU2E4MnF6?=
 =?utf-8?B?TndnYmdpNmx5cDJtNHB2RFZ4b0lESVA0c0dhaXZhWlRBblFpN0p1dlpWY3pY?=
 =?utf-8?B?cVdkZ29rRTdPZzRTRCtXS0h4ejF4MFRwUFZwSHpWU2FFek9WRkQrVURFVGU1?=
 =?utf-8?B?cWNMMTNSSTdSS0hMd3pyQ0ZuL1dDUGlOUEUxekJMeDc1MFdZTDBlUnhJUi8v?=
 =?utf-8?B?VGZkOWd2MjNtYjhXNHFLY3dhcWZkVkR6SWRVb2F0eU1icFFzWTFZZlBqbmQ5?=
 =?utf-8?Q?LwNXcch3pu35u24q2ywcQC6Lg/K2g4noTmmof?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b091dccf-c491-4260-7ba1-08df496a25f9
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:00:36.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVwaUHO8wvi0DWWqHxI0Oa9sJwE/cKYokDlcnByQe4oXQ0faGAqX9kaH7CY5JSFJ/7+jWvTjpjoEE6rKp7tqf5DZK9WTg2VWifzhDDY8UJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB452843

> Can __rt_mutex_start_proxy_lock() steal the rt_mutex using a stale
> task->dl.deadline before task_blocks_on_rt_mutex() runs dl_proxy_block()?

Yes, by reading. v11 will call dl_proxy_block() in
__rt_mutex_start_proxy_lock(), before the trylock.

> Does returning early on is_dl_boosted(dl_se) or !dl_se->dl_runtime leave
> p->dl.deadline at 0 (or expired) when p was PI-boosted while sleeping in
> FUTEX_WAIT_REQUEUE_PI?

Yes. In v11, dl_proxy_block() will start a period of the donor for a
boosted task whose deadline is 0 or has passed.

> Should an implicit-deadline task also start a new period here when
> dl_entity_overflow(dl_se, rq_clock(rq)) is true?

Yes. In v11, dl_proxy_block() will apply the wakeup rule to a task not
in its gap: update_dl_entity(). That covers the overflow.

> What happens if a constrained-deadline task has dl_se->deadline == 0 when
> rq_clock(rq) is still before dl_next_period(dl_se)?

Yes, it keeps the deadline of 0. That needs an rq clock still under one
period after boot. v11 will start a new period for a deadline of 0 first.

No case will test these four changes.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
