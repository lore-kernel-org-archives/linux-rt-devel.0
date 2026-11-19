Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104338;
	b=rLVHsVpS+uk/U8odGMmC8ayjAZz5a1LJ4HLGqjaZc+JNXFDOm0EtOasMduh1eKUTvzOM
	 DTmzxOmaoSh4G5tDBnKdTodYNbWrOahLUrqR8EgO3Tw+t2RXxXPAz1WSnJ9pT8SCfn6Cw
	 a/hVxJXQwZpatJyZvB4Eg/KWdTNSpcP/lgpxttrZ1BTzXQMw5Pb0HfSsI8endVAhN9sON
	 ks3vlLCDUfoSa3g1oYkSJkehMGn17jdrYkOOPM2W8jGe9P4eEwmKInP9V35eigMJojAzh
	 Y0U59gLuvKObb5jQxeLgVHsDhyNT/vcSn4v99oOesUv5I+fmykDXSssLH6ZK9VdRonw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104338;
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
	bh=ZkTnMHuzlyTLUAJsk4yMTlYuQbgw47EfWiASTp6L/K0=;
	b=453OJ9XP7koB0/pqWunxGTM3zivIu6uHO8cvsz8WI6kaydzyFa/8hjV65B4Q83S7XMUn
	 ARuyQoHUjlvawgn3XMxIHBQG5stP4OUcbcmohPoqw6eIKQVAw2BoYN9YNH7tsdJ4KyZBE
	 G+/uPaUd5hnpW4PlIfbw0X3SDLE7v0/vGHPKu2qiHkwSq5MFTsfEUjiOB0FGJYdLex6JJ
	 1DnWDDWyhM2DhaDxOFdP5M5Va5yDWzXkiQ17/jjRxpGsb31YSn9NMmzKsNE1EoPZX/kuo
	 8K250cPtzPzIbyZAWHvsgFz38ObEjK+JKf5HwG91ZsQ+ViwcteC6qk1U4dcefZUQ7Cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="N5oX/P5v";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.131
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022131.outbound.protection.outlook.com [40.107.193.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26B606A32A;
	Thu, 19 Nov 2026 16:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE26B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=N5oX/P5v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II/Smr/OuYmPqw/tAmqSMNBjPZDzZAwk4KG2M5IMrnc5CI66WNZvx6210XwDYJYAGGmKdjw3U/gqIrBrgtuSZNBYgMlSVkKAM2m7upCfaQDSVspDeanh1aS5mkOn2ZWpnsx18H1PRryftSBb9oGfBukAQsyp9wrcCsFAVybMPqTFMvwz7pi5g0DffUrL+OfQM0sFRUxb6WZHLU6+KYkP7Gf59qP2P+DW7bUFe8AOcch8VwqYsSlclyCSO9oQmjTxSSy4NsQJJV3gQCG7/S+UATy/XwHl6jgInSnIIPoh1FfxpBrP+KdR/s87lXbmX7NvFRGAf/qGwJbaUTbnbXedEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkTnMHuzlyTLUAJsk4yMTlYuQbgw47EfWiASTp6L/K0=;
 b=dl0VCGTVV4O2IQE7F9IMW8w7fvw3NIuLyX6grCLNVpdn69ic5DjkrKVM3RuytE7mfUbjAzwO//gmkH+mEo8lnI70Wls69ouV1ZagN0v1eYEtikNJxadLF/Vh3er0mYXkEmxnjeSfFAlkmtVYOtId7W7EBHyvmdk6ApQtctYbMNDD9gXVvBraGAoP1O4BfKKrqQiYm/CTsBXpefEiFelBBlzvmwx9iQ8h4qKMiE4Ljh8PRyFoGiXmVWrmtBejX302NsPS5w87oXQX+hRjh7eE46iEunHB2SEBNffNOKamFHvtPb08UUG/rsHNHfQVWlfA16zULRRlK3r2LRm6bQUcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkTnMHuzlyTLUAJsk4yMTlYuQbgw47EfWiASTp6L/K0=;
 b=N5oX/P5vYFZTJeJaFd3kIN2lLG5HVypXzmjpkHQxt+L1EaNE82o5WzWgohsdVRGstVirya0h0hRvWZkL0olXuG2l2xawKd8ECZARPLliB4yWn3cE0Ol9LaJMTYpRItxMoQKAs48HMKhvuHJNnq6oakgTefNhBFby4YyCd48VP1bYOwTwPsiG6uAV6GRSyGZmflzS0amxey/Q0Z4mYcvYGWghI3b8F1fuwJnWPRaRDTFQ8mvVHfSwq6bKr6/kgyG132uGsALjbf4YF66libeiFgWlUJVHU8e1Ge6X4W3+bmJEaTujG4GRX7FKVvmhi5FPc4l1kwY3DOalwM0q03/HzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PR01MB9418.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 16:05:32 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 16:05:31 +0000
Message-ID: <23767c55-cc70-4837-a4f2-2e5bd71f93c4@efficios.com>
Date: Thu, 19 Nov 2026 11:05:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] sched/deadline: Do not divide by zero active
 CPUs of a root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795092090.git.mathieu.desnoyers@efficios.com>
 <46cf3d11435498c167e87c1e402c6ab2522f71ab.1795092090.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-223252@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-223252@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::30) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT1PR01MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfbf55b-47e3-4820-7bd3-08df4656efdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|4143699003|5023799004|56012099006|261026140227099003|261022105027099003|261028144727099003|261026121527099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	n9sXgcJoa6RXRix69KrFTMk2m4OQwRp9XI5XC4UeWjbZKeQoQBFtwqJBTF4QyDtejS45YY6eyowlAx3E5qEMLcugKFQYmhRfgQTvkbIvWmuY+oHSI9+wZhyMS0LN437tzEF7i6+PQAczLFgbxOmsLwAai0+PAWHQ9FbldeddhuRXbVoO1Sg6IsEhOIfiEEy9cyHg//IM5rIv+5f1Tw1Gf3zXODmPyhTpmzkfu0BQOJnJkXICEsYW7Ev3LZTBVs7GtuhzheqlB7qdNu2FRkH4wboXAfGmN/begloNW1Lb8vpTuO8dvtBbpyYUNM7JqjxEHhl+GTASOJ8nKLTdpYsBSrC7tUiNqVpy29xfwOS4yqr2itkrnqQ1XQ/0iHxMA2+RcOZzwTsNWf56qWzDUA2CT1n3p/+/AK1BVBJAXw9c/Rfeh8/qnZUo96PFZL3pg1xsjH8eWNFKxklGV0e92aVi9tYl1EP4qAsUQK3thch6VzVuVRoYloAYrdkeGG0Mm1Yx86VXAIxZ1hjArD5En1l3yh1IP2ZBJpiYWpJ8eWSgeFxcW4JXfoxl9JE1crwprQ8xcCEyTaa+YOaKWg/Fn0wFs8onZff1ysl5l8CdXBxEZXg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckNROENhb29KaFhac2RpZWVnYXdFRW9Bb29qc05qeWtQUENGUitJN2xYZ1Fx?=
 =?utf-8?B?em16MjBnMi84QWs3NFEwRFcrQTlBVWQvTHdFM3A1aE1mWkZGa3V5b0tKdEZv?=
 =?utf-8?B?N3hoazJHeW9RQ1FTT2pKTHUxc0pMWUFMRklxYnRWenhtNzhlR0NuTS9ZcFpD?=
 =?utf-8?B?L1RSSDdTTzRuNmlmd2p5UUxvMmZSKzlPMHp5ZG9udzJDTFRWc3RkcGNZWjc0?=
 =?utf-8?B?R0c3UW10aVdrNUl1dDZKVWRxZFZRTVpnTkRpRFRGa05BdUlEb3FkbDJ5TWRY?=
 =?utf-8?B?TGJDam9mSVVCT0RpY0pkS1hiUFp1azVJeHlwK2FtOVhOek9Xenh0eGZlcjg2?=
 =?utf-8?B?SEhCMTAzbGQvL09EUlZZZ3YwNndsRzdLZi81bTFJUUs5b0JLUVlmMkRQdXpu?=
 =?utf-8?B?RVRtbHJtbjVhWGt2VGRnZjNTcVFoaVJML0xKdkJDdDI5dGhhZEYrSjZaeVRs?=
 =?utf-8?B?dHFoanJNOThaRHQzMEsxM3g3Tm5Keko4SVNWV0ZzdFVjYXFLalFOL1BqYXhV?=
 =?utf-8?B?QlZRRjZhbFJkaUxQRDBRWmZPdjIwbXBVeUNlQXdOZ0xtdmtvY2dncFRQMzN2?=
 =?utf-8?B?dnhpZ3NTWTdTZ3pQQTZodmtRVUJxblJkQ0Fpb1p6UkZlMnBiQ25sZFRoK3R0?=
 =?utf-8?B?dzVBNGdiUTQ3RTA5dnViNkJzVDFkaGdBVU1KcC9rZVllb0ovdnpuNEhEM21n?=
 =?utf-8?B?WEtnVkRxc3gvWk83ODBON1VMR0N5L0kydXliUW5WRDBKUU1DcGRhMSs3Y21y?=
 =?utf-8?B?Q3ZBelptMWNibkMrSFRoWTIzdEFsTHVWdU9JUktKMWYxVVNYVUM4dnRObUpu?=
 =?utf-8?B?eEhvNFhwL1U1b3dOdHNDL3U4K1h4L2ZOUmYvUjh5SmJRbGRJNjZiNlFLU21p?=
 =?utf-8?B?UGJNdVR3MlBPMjlEamhocXZqM3BhVWxKelcwNGEwWGxRTzZORTYvcnVNMkZz?=
 =?utf-8?B?OG4va05DaFBpQUJtQVMrb3ZTcVRJQzdRVnFUQ2pnZVZ6V1ZzWGcyUGZJK2xE?=
 =?utf-8?B?UlhSTjVSR2YzdWNYbVJ0WGs4YzVIQjZzYk9pWVJYd0htQlhNRkRkTzI0RzNC?=
 =?utf-8?B?NVNVYXM5V0tMcVlZd1ExTGFRTDJURVNxSmF4M01ud1J0MDRjSXoyVC9qZU5x?=
 =?utf-8?B?RGJtZjVVY290YUdJck5lWk00QmpHeGd6MmcxN3ZTOUJ3aUttbDQ3NHo0RDBO?=
 =?utf-8?B?Y3JIdFh1QkZZeU5wbXpiektSNmRlMS9VVkhicStGc3NBemNPUDNSRDBTTDhy?=
 =?utf-8?B?bGF4OFhaa0ZUaUM4MjU3WGRMYVVRR1NoNDNVTDNycFVaRm4xUFM3dFFoVVJ4?=
 =?utf-8?B?M3V1Z1lSQWNtZ2x2Y2VDUXk5S1EycFdqREo4ZHRCUmZLUmNqTVo0dmlaZGt1?=
 =?utf-8?B?SGFYYzRNZFRDUmt1bzl6emFUMGIwUFFOYnRMdFhSYUt5QWJDa1BHTThHUnRY?=
 =?utf-8?B?S3k5d0pxVmhXRmFYZDJuSEErSjVCbjEyUGhJV0JEeFR2WDg3TFdMYnc0UnVB?=
 =?utf-8?B?N2IvK25xZC9zcVh4bldxSGNLN2xHNGJvNkZlVERrempHRzR3VkdaV2szSlVh?=
 =?utf-8?B?N3VVR0w1eGRpcGoxV2Q1ZEk1Q2syNnJnQzlpNk9rYlNVRmQ1ZnJKYVpZWjd2?=
 =?utf-8?B?eUNsYVgwRXdidnAwNVJPMDZHNllaekZIOTJlNWNBbEFKek8yYVliRDA2S0VO?=
 =?utf-8?B?Rzk3ZTZYaVpXcG9YYnRkaC93WFdYSGw5M2RHMk9zL1lSWWxJZnlqRGgrbUU4?=
 =?utf-8?B?UFVEREV4dktwdjh3enRjYXpGcmJ2ZVAyWm9lNGNSR0FlajdGdGdTNWFWUHQ3?=
 =?utf-8?B?VUdOYmRxd1BSZjhrNHprSW1WVUMzQ1Fsd2pSbHFBZjExNHNpZmlDU0tydnR6?=
 =?utf-8?B?NWl3Z3RhWHVJSldrTWtLTDhSenI0MEp2amcrL0ZZeXNySEdSN1Fadmc4OERW?=
 =?utf-8?B?eTZubStuZEM2ZGpCRUczbE1qWlRDMlFUN1IzUEd5WjJWdi9iOTdkR1Z2QU5q?=
 =?utf-8?B?ZkN5YmROdmFwOHFHeThkSnVnL0toNzhEdUFHcS9WVHgySlN5UGRpNE91ZzF4?=
 =?utf-8?B?TDh6VnBtV1pFSURhMjZrRTY0R2dxQ2tSaFNNQWI4QW9yaW1JYS9nR1VhN2V4?=
 =?utf-8?B?eGlXR0FoQWQvR1RQeU9DRmF5WitKUm1Da1dSOEVma21kbmJhM2c2WjdTQjJq?=
 =?utf-8?B?V0FGWXhqckxPYlFHVDFpQllIRFM1Z2lUUURmak9sNzhQVGFWWXliWi9hSkRt?=
 =?utf-8?B?WHVkbFYxVVYvMStyWllWUVhWSnRJeG1mZmUyK0p6bjlFWm54VURVS3FVSlh3?=
 =?utf-8?B?UjFnWC9ZZ29maEVIVXE0WGVLdG5vVkNaNzVCd1VXSmpQMmxnRkU2QStsaXlL?=
 =?utf-8?Q?cYxihjwDb69RFlaKy/D1TY9eNFDt3SkNyI+k4?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfbf55b-47e3-4820-7bd3-08df4656efdb
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:05:31.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vd2htzZD1DVspK7bHwh7N0mYvTu4+a1+gJHMdNka9s0Qd6Gqyt9i9Db0yLpFwfVb5WpyLwyIph8vQZypIIy+ajI4GjC0/hZEtj9OYDp87ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9418

> Can updating dl_b->total_bw when the CPU is inactive underflow
> def_root_domain.dl_bw.total_bw?

Yes, by reading. It is older than this patch. The subtraction from
total_bw is upstream code. This patch only skips the spread over
extra_bw when no CPU is active.

The second series fixes it, in "sched/deadline: Record the root domain
holding a task's bandwidth". With that patch, the timer subtracts the
bandwidth from the root domain recorded with the task. It does so only
if no rebuild dropped the bandwidth since. A rebuild drops the
bandwidth of a task whose recorded CPU is inactive. In your case, the
timer then subtracts nothing.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
