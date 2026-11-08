Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.143
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794150619;
	b=YjCSBq6LnHfRcQ8mvEGK3sLEQ21yRCugCNQtXGzmYDZx/UIsxEEWsjucfQ2EiLnYDUSZ
	 zsrLYiYXSEQLSWhGKgBTgmnD/cGbUNHOPli49Nxdx5p3TPxS/gL/yETnX5deDjIEAee33
	 KNz2YQLgO0JoxOQCqaYkNyr++3Z0SQP+U68iIGQ78qKvrTygGAhdVoTY5tYyrcZuZ3tXF
	 o5LWc3YAHEe5N4VTnIVmvpdALs96//F6YfGI3RbYfc/XFRaQGqPVJ2QEgGtoWFdlWY2e5
	 0nUHRvGBrBb7vCB21HXS98YDM34MWblKXMLUGMV5c9ySd7GQJXAxCn9GmxLQIA99Prw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150619;
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
	bh=NTubyfFtpyK+QuUhhoD1YDzUSx8hcDa6GkgrBLxOqbg=;
	b=4iAgDUVdPpdJ50WS/4JdCp+cDQCiX6Q4yBwq7MYegXRP0t0nRgZTQI//fkOu7fNhXX2h
	 dRNt7S/lAE/8vAJjxkH1yspZuqThDozq105m1FwFNj1Ne/9ONbyiqsZlkxyNXfVos9zmt
	 6RUxtrVhMkY4JXX45X+7afgPa9xNUfn21sHa3Gb7667FbUBArr445WHvd2ZJ4z+RXd0BR
	 FwJ1/CHFqaE5km9XU3X9Od1BNCmthrd01k92hTEnyQtr/ys999TbML1p334McEL4+MNrp
	 IcJgF+dpySgmNXDdc/CiYDGLY3PSHAKiW3tM2KMxvu9A3kScf3wSG/rcdjhrdn24ptg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="L/t5d7mW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.143
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020143.outbound.protection.outlook.com [52.101.191.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864E606A320;
	Sun,  8 Nov 2026 15:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0864E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=L/t5d7mW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRxF20MDDLkU4xHXBt6TJtznTbledqmnaq1X8oQSKyPUqSSHnMpJjGrAc0FSbKsh1D9Gm06YJReMiDEsmyGBwjr4nIGgK2nCD5LIEkrNp97jdZAOvOXzJbKvHpQZizKS9hmnN2IQNIHqvAvTzDYiAHDTZ89x+KmfbMBZ39Goxxk6kynvgrfF5vIcBh76oxBtbgT8RZdh+AD9+5QTvsjBeZuLUc7jQLPIZNnw9XzybQ+5nGIKtbnqKoYcP7tQ7wrWVhYTMSq6vzkjMM1Ezba83kLQVwRtlr2GqmZvTJi0lnU/GBA4A+ZlGG/vYLt52I64+s+omH0MGsZRh8WM26e11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTubyfFtpyK+QuUhhoD1YDzUSx8hcDa6GkgrBLxOqbg=;
 b=DoNbzRcyfJWMLqAFud4BnruPQ7EyoIHZCsDpnsL++GHPQ2RJJPmQNeV17hdL9rJS6cHb1B5bwAsnlyeHjvu67uVZ44RaZ7J8BS211O2uVmL61qiwCqzt2WwAZUb3WNtO71SBuMUVvM365OKrq4eOiswY4A1GrNS+olt3IE+Q7rkXnKt9lDu58HHJdEXuXbG/xx0IebRb2JBGm6JmfUt9CwDu/KE8s6MJfM5F0WVQbrjKxBmAEqeGYj8Z5pej1LLqTcyGs6F0UHS2t24DHAJjUvy6BJvFjzdn7SbLy+HCsw2qNTO41frxflbMdqljfbpcq3aQbso/gl6Xf9MMUrw2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTubyfFtpyK+QuUhhoD1YDzUSx8hcDa6GkgrBLxOqbg=;
 b=L/t5d7mW+P2PsjlQgCS7gRcjJYYQrURNHjutOv/0vskCQYBxv9bXq+fJBlSSLGSxM/lqU0Z7xs7u41ePuIbMQIpai+Kmt5D1l3DCEBgEfpPLuU7E02a/wnpEci/4QJ+ozLVatgZmvHen+BmM0AyFlx6cot1I0FSiZS5rNEAqvLDxb56dlSIiYTKS+bYTl8KR43Nb3s3zBCl/AP5hnHD7PLnE4wBjzN1nEZuuYybNtC1hGHJEpaTHkdaamwudDvTukF0IcYyxArcwLjhaf8qn9bdni/yNGbnXhXFbw5sVcFsNC+ySXvtMk+3k/Odqym5vaeSvWtO0kwMegX41EkyWpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB373984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:cb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 15:10:17 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 15:10:17 +0000
Message-ID: <7a8f6db2-aa1d-4881-be1c-09a2d8af5290@efficios.com>
Date: Sun, 8 Nov 2026 10:10:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/26] sched/deadline: Record the root domain holding a
 task's bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-17-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202514@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-202514@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::16) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB373984:EE_
X-MS-Office365-Filtering-Correlation-Id: 21922160-3560-40f4-e30b-08df3daa65ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|261021121427099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YrfB54woAigcFLfnVcJhmz3HmB0cbJaotcyp9lgDuD+P2ryBcFwWYBB7bOSnhDC42A/YxE6FLrXphQ3KDzSTc7Aon+fodxX7RcpepiEWdO7EMUwwZem5LH3ueeK86UT1iJ3Zx9agLysSf54BgEOr3d7RRHy8NlTXoW4jdiw7+QFnEl88IH+5PLJ4sQlTat6p1bUUL5cnY2CvHtX3MMF4sYE5/9+RUWORfJyJ6dsxgKnnodjlqlVRE0hqbiyOlROMZBuxO6Ak1zmH1qjlC9FX2gw7yxcqdjdLV0ZLMQDtERk+xJDrHpAowy6rlrOTEPh8WhHydV0OCA/2HfkqmzGg+ZleUH5Ww5B4Jtm3oGZIlnDmx2pfsCqiD4pgjjLdW5uAduW9u5bK8sngtIeiAznrQTdtdkk2MhPjctjP7vVI4KIZzIq5hJMgU5xWT20j9U6zpG6AkEa8dRcTXi2HCHiuebM5R2G/DyM7tErYwBXX7hisKEL1xS/1ssV4lku1T/SO+nRe6vxk5UdD7Ysu5sskD2PkI3NT//a73GLbU+9bjILp2XMKJNsGqbPKFypHM3dfcm0qufoiT6d1aiTdulGIqKJb7R2z0zc+9GPKwH78bww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dURaWnFyeUgwcjcrSW80Vnoxb0JJTjhheWlWY011ZjBBZjFIMDNyTW0vb3lM?=
 =?utf-8?B?V0tDWUxHbGhWWmxiLzRoVTAwTHNvVERiQkl0SXprS2FBQjZnWEFWSGVsVnFx?=
 =?utf-8?B?SlhwbVR5djlwTmx1NTRoZWo2amlMSzAraW05ZTRVMXdrV0I2MDRUNXZUYmJa?=
 =?utf-8?B?VFZLRWtiUnRic1lNc3lOU2lKSm1DbHNqTGdCMTQrdEJqR1lCR3hzVEp1KzN1?=
 =?utf-8?B?Q09ybXJrU0ZTUUJacVJUUndZKzNyR3RlT0RuTDZ4ZENyY3A5TGFtMU5LLzJC?=
 =?utf-8?B?N28ybkttemRzeDZXb2dyVytzLzFjckpaR2MxS0lxSGpFZy9jTE91KzZUbzNS?=
 =?utf-8?B?YWtCNWhMekk0SUE5VUNUTTZiVjM3NW41azRFSGFSYkloeDRVNjU2TDZTV0xj?=
 =?utf-8?B?SlpHQkxDQkpYaE9RQ3NxSTBIM24xR29ab2o0bUxEM1JrVVVFVWt3cXNqNkdX?=
 =?utf-8?B?TlBEMDBqbk5ReXFQMEJ1L21sTis2OGhrSmNtdkhhVFpsc1hmbFJhVWNYV0ZK?=
 =?utf-8?B?VHRMLzJ0ZGhYMkRXSGZkd0IveW51SGMvM29VdkRhM3E5dHhONVVHVDk5TEhr?=
 =?utf-8?B?UzhJaUVpMDJBUlNEbG44Z2xtb2hCUEQ4R1gyK3ZWVmhKa2J2K0NKMjExcVly?=
 =?utf-8?B?enZ2T2x5azRxTEoyWVZTUkNZVWF0SVQ5UE9CSEExUlVBaTUzMTJTazZreU5v?=
 =?utf-8?B?eXU0MWJpWCtURmw4ZkFvcnVETlFIV2c2QUFLM1JPbWRPMzdkb2FjZTNFR2FY?=
 =?utf-8?B?cC80bGNLdHQ4Q05zN0I3QnZ5WVA0U3NPK3o0RTF3V1QrOWd6QitUcG9CWU52?=
 =?utf-8?B?VGZLdmM1RWVRSk9hd2RHRzdaMkNBV21WYUhORit2UkZsRlpvRk4zN29jcVdI?=
 =?utf-8?B?U2JEK0dFeWtFUENhdnY3MmpVQmdNN1BmTXBhZ09OR2FOdkJvbmRETk9pWkcz?=
 =?utf-8?B?T0J6b1F3QWNLZU1uRnUrZjR1SU5VTWhBYncyOG9KY2QrMFpVM1Jxc0drbDJH?=
 =?utf-8?B?UktwNGNPZ2ozbjFtcGIvVTd5ZU16WEhpNmlIK0FLWXh0aWhhOEY0UUthcktw?=
 =?utf-8?B?cFdKYTNjWTdIb2tlYk5ITlVVQi9XYkV6QnhaK3hjS0N6TVBabHhhczhheWtS?=
 =?utf-8?B?emdnN3dRamtobUVwNEZqZlhSdTF0UTRlUUE3bDY1b0pEc1ZEWDFVZXRFUHdQ?=
 =?utf-8?B?OVIvRnhwczVCNkhHWWQzMmU0SGF6ZzZLd200RU9BdFM2Z2xDdy9vL0o1ejhJ?=
 =?utf-8?B?WWthSlR2QVhrbDlqMXFmdExsRnBRTjhIWlNqelJNUzZzR0EvZE03QkNnVnFu?=
 =?utf-8?B?VHVCNkVuOTMwZG1YY3RXNk4yL0dUWWRxTEtBUFFiV3o2V29BUHRrTEZzdzQ4?=
 =?utf-8?B?T3o5Q0ZJbUZQNTN1K2xsdzlwd3pPNWVKZll5S2NRMEVXQ1lwNVpQLzNsaTNI?=
 =?utf-8?B?blVJTTVvMjlrY0hyRXNUT2lWZWw5WkRSOTl4MTFyaVBFMnUzeVZ5MyttTGt5?=
 =?utf-8?B?TFVqam1NaDAveFRFSGRzUEU3dGoxMHljNUJiaGdVeVdML01WZGJockY5VWxB?=
 =?utf-8?B?Q213bEdTVXJkekZTbjUwRDlGSk1IOGovMWpuc3ZYUnpkWVZkSk1IL1czQW01?=
 =?utf-8?B?Q2l3Q0xxWjlaUWk1eGZQaU96M2c1Y2YxMm16OU9ybWhDSkdzTm5Ma1kyenZK?=
 =?utf-8?B?K25rWnRhWlpzanZ0NlowYjVqSkFrbjVSVmgyQmJibXhWS0MxR29TaVhUSzli?=
 =?utf-8?B?VVBOTGp3T3BwL2FKSVVpelRGcGNwVU1UUTJ4UEVtTXVtMkVPeTRPdDB0Kzky?=
 =?utf-8?B?WmZON1owUEJ0RWRWRlhISllXMU85V0V6Y2pWR01zZVc0MW1BMU9CNEJrRDZ6?=
 =?utf-8?B?RnRiT2RaVUp4L1oyZGNGSWMyMFlTeEozelNjbDFVekExdFA4Ly9qNWM2aGxU?=
 =?utf-8?B?OUFFVXJONTJ0ZVFoMm5GOThZVU8wL2E5NDdRbno5bUd2Q3A0M1VqanNiQlZm?=
 =?utf-8?B?YlNPMUFkVGdJK1dOQUlNeWpmekFqblBmMjJ0Mmg1cXhhcUFweWQ4MmcybFFv?=
 =?utf-8?B?bVk5TXRUZ2xQakdMbGZCaUEvN29NN3BYQ2w0aU5Kc1dUVEV3V0RmSWxDZUlj?=
 =?utf-8?B?bW5IT1d1Q1FVOFRaZzhORmZZU09tbERIdXBXb3kyS1NwZ3p0WGVYNW16WkM5?=
 =?utf-8?B?dkw4TTJVTGFpMjBqQzZaMWZqbU5PU1I2WWdpVzRqT3l5eTBuTENORG1OY0xt?=
 =?utf-8?B?YityK1lFL0N0NXh3TDN0MUttaTJaRTVZcEcyZmplOG5LWnBGbmx4b1gyYXE2?=
 =?utf-8?B?ellTWkpKdTdkdHczZnM1dDZkWGZzVXBWMnVSSThpd2Y0N0FMUVdhSW40MklJ?=
 =?utf-8?Q?Sw/+4jlbUgcewvTw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21922160-3560-40f4-e30b-08df3daa65ca
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 15:10:17.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxPm8Nex84rPXSJU+RKww/mWuIytGu6zmX1z1AcrV6bKiCd7k8MIc+NboJpQEDU8pl1EwIXy1Wh14WNH5us4hUDUAVZnhjV0PF2+0EeNxD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB373984

On 2026-11-06 21:35, sashiko-bot@kernel.org wrote:
 > dl_task_undepart() loses departed state on PI boost

This is the case that the v4 cover lists under "Not changed". A boosted
departed task counts as a deadline task. A rebuild meanwhile counts it
once, where it runs, and records that CPU. The deboost then releases it
from there. A deboost that races the rebuild drops the bandwidth until
its 0-lag time. dl_bw_gen then keeps the release from removing anything.

The move in (ii) is admitted in the destination by cpuset_can_attach(),
as for any deadline task. In (iii) the walk counts each deadline task
from zero, and the release removes it once. v5 documents the deboost
race in the comments.

 > stale dl_bw_cpu when dl_bw is zero misroutes bandwidth

Right. No move updates the record of a bandwidth of 0. v5 makes
sched_dl_overflow() use the task's CPU for it, and adds a selftest case.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
