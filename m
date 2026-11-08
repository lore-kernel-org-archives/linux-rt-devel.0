Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794150468;
	b=MM7FFWMtN9/3l1wjiPMWiZH8Ut8bsKo+pAzgCkp+7q996t5bNUi+6LIDXBA2ajy1JEYr
	 SsDQ3a+oqOQqf0gDzcjmXp+876SA900078+G/ysqbHnHl9iAlW2JpvvlPLoHJGzq0t0IU
	 e5YKJ5lpB1wo7G+WPZ9+HCDqcvGMC4QO+MD1X9d9WX6Ffr0q1myEQKS8W5E56oEgqYHzp
	 zGpr6Ta+n/TS6iOaUzbRCFLSXP7WC8G6arrVImEDiOmaPtURlBIinIryO766oUZHwidWG
	 0WEGQwpu/VSOsBcV5pHjoNOg0A/AVhIsHpFYzb0/6eLTxLrDE3b4I/nJDUzmC7y7Ovw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150468;
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
	bh=VVU2+QheaJUA4ejBloUTFUJiojPELHo/nNMjCX+6coI=;
	b=lTm5GvM0U3Sm5K8/JU4T/gETcF3tLERbwNB3Bupbh/NvClEFuKJmNmTMbOM3PYGK0hC2
	 yCJCL2L2CGYoZLPRoCtkQjjQN7/9EkhrrfwGOpotc/VUqAgfoGtO+GKK3qsiiTQcgI2Ti
	 k7JzaTqO24iMH1rzOgTPqPTkECJNBYfq87iBOUd49oDSi0rQMLsD9V5Ln8eBv4JSf+2qM
	 Mc0qXUDEL8Q1prlH3Rc3pp13rjqBELcIGcFdCGp31VAamqvEYzX18jNQN52rPz62RQLrA
	 mZw0eJ+D8+swoLwOxvuniB7V6HPLv+A14srY6iVa7ygLrRnybNCZMItvWKwXifmENHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="KqEbV3p/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.138
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021138.outbound.protection.outlook.com [40.107.192.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A49606A31C;
	Sun,  8 Nov 2026 15:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26A49606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=KqEbV3p/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmZsM+0fxNk6m4UKSIXM6Ga+Cpfrz8zLpa5OcLLfQ1TjKhcixMjzLuu5JfSvVexO2ZJZsw6pAmGRes+hSOzIOqJ2AjczMYWM0EZ63rkWMCFM5vSvw10uAthHRrAWZy7aJwcGPOG5OeIR0YP4lcSd5hjF6eqR/I776DIjOU5bl5gqEPKK6ILeEVWljdU365H30WTXY21x/yaPMf4UINe+kSzBeAFLZXSsMVWL6aMH/F0THjJgfL/zGLxJdE8pAZPNXEsAyRsEgOwmmTu6K9u+zxLW9CsbC4IIkPc68AjJwmMWQbMjiUxzexu3gyps0vWz4YK9K47tsSb8UrbbeJLFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVU2+QheaJUA4ejBloUTFUJiojPELHo/nNMjCX+6coI=;
 b=g3vVc8Eo9TE13JjwrjHHpH790dNSWF81RzgdsGUBF53EpGVuAKa13zgNh1xeHHAJzpOat+IP2/ePlF7Uas9tRjNNZHQAqRTvBIy00rPevyaP597NxjZIQKFORh4tpZQMqRhCs/B0T0zBGAEsMx6d9czFwQjrClzKTqxwO7T+fEpAhZmQfnuXlXsgg31K5LYG3sFaK+1efMms1wNiisen7oqMe3SUR5uT+1bekvbsNPfWjDDXzs/ykA4JTCkptHsHTEBE02yyvTyH2rbRnPVd1PC+2jOR+lAEZUzo8HMoknUWJNsc+PNlpYcJadaCIXaIXtsG52ZqzMOdDXUh89uz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVU2+QheaJUA4ejBloUTFUJiojPELHo/nNMjCX+6coI=;
 b=KqEbV3p/in3LQcDm1bEM3bHppQCbVQdDdId674F3/5EwmPizNlzhIJTo0Q/d8Gb28JyTRzrneKTBGKuWmFD3q2MpgGqE0/Mi85qlJnD2nKjtSCfn3W5Jwepez3VR5isNN9lZfEp8FV6jeC3Zc3y44mrJJiaEDnrq3UUQ0l+bOnS3t4RakQMugwz/ax14mODGh++6F/Y80RsAXnDyB9V9gYmW0DiYkTW+G0WOQbcUc42VFKP0N1dTAy21EsRxJWQiNqVR1FdHSgsgcHyF/iffzst23CSne8MsIfS0r09izc6tH85KsfAxR928SklkJfsDulgcuH2QqR69hExZ5/Pqfw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT8PR01MB853975.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 15:07:45 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 15:07:44 +0000
Message-ID: <9678dcf1-f6f7-4cc4-b1e0-691c602c0da4@efficios.com>
Date: Sun, 8 Nov 2026 10:07:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/26] sched/deadline: Release the bandwidth of a task
 that leaves the class asleep
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-11-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202504@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-202504@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::12) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT8PR01MB853975:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a085c2-e176-4864-3b25-08df3daa0af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|5023799004|4143699003|56012099006|261021121427099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8afX5Z2F5j4occiV1D2FPpY6uS7Or8S/2fSrmVzk2v3UlWjPl6EbuD7LUU365OLEJ+trQ7d5dxTDKhOoThG9/N93oZO+yMEReL9z1MQ8D02AIbmhT82M/vsIGa1P/UIjNQ7Tzc0VBigcFRLNu5GGwUt/LOh+W9cu4m68UHFnGmncIcZTU6NLTNJPOkkqli/++i8eW1bZpnxy4eDbjVjtUF5a3wyFZPE8U2FFmL5ChKwKvT+hPFHRiF/zjBahYgvmdj0Qx1SOWYHYR01JIjmxma+pZwLD6/UXIuCg88EOsDNho02CpNqMbAtk9quEGW8Qb8E20rdo9xyGVYuzBo8yVVTpSk+09R3kI/zQ+SXJtmT9RHcp6cMp48rDPG4IMjV4RyBpjx/v1h4oR+DHFK/TlZ+wT9UWlXnz0amd+sebwTWng9DN/MJ6b3CtsiJ7qrHh+5weSmO6aHhfnas8l39lrWyjlPDl/S2Lag1cga018DFyixREisn5CyIf/p/BPSouhlClV5/CJDVJq33YjMMNLYRgC1WQUfStR+kP06kQTEK6mveN/UdB+3NV8/HuwstxqdHTmANd03qXZnKUggXBtQdNBy3RU/wAdR2/DjkwyUs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(5023799004)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTd0eFpJRCt4OHBWQnZIQUlqd0l1bmN3WTU4SXlFbXkyTkhBbVg0aFRNMHo1?=
 =?utf-8?B?UDFBTzRiRlpLQndydlp1MVA1bFlwVCtBamN1K015MkZ5Q0VlM2o5RXJOOTFs?=
 =?utf-8?B?aVRiRmhHY0h3QnBIcndKQy92SFV3VFJWZHk5czM5bkRFK0pxNVhZT1dWUEs1?=
 =?utf-8?B?bXVoTEU3VmFXWmhBOHhBZy9GWHhlSEdHK3FFZWkwTG84ekxtL0oxQzhPbnN2?=
 =?utf-8?B?TU0rczJBcThZdzFKVGk1Qyt1ZFNaNnJTODlnTTNhSGp1aWdxbEswQTJxU2py?=
 =?utf-8?B?L1NGTElMYWd2UUZ2VWtBTFdpMEdaYm9zcTlhUVRlbTF5SkxmY3NhYS9ZYW9U?=
 =?utf-8?B?NE9tRkNBdDh3aUZQSGNEc2U2anJQLzU0RUJscVhHVVZhZUdQMzhYZGw0a2lH?=
 =?utf-8?B?cWZ0aks4c3Z1ck12VDNndzF0MFYyMlNOcnJOS296bFJuT042WHFpcmdQWHdj?=
 =?utf-8?B?dnlwNU43Y0VZT1kwZ1ppVkRHVE5YZENZRnhRbG0rcGdvMVQ4ak1xcmt1VWtZ?=
 =?utf-8?B?NTRSZTBheUppb0Z4cDJVTER0QmdvV1lRNEpQKzM3NmpTdlR5TEJTYi83bHFC?=
 =?utf-8?B?UFJ4VmdSOHFtS1RQRFlGVmJUWGVxRTg3UExKMnJNSjg0MlAwb216dlJaZEF4?=
 =?utf-8?B?MWU3ZzBxOW51OE9iRnRyZjRWYmxOTUhVZjZuRFN2a1NybnZGWlMvVnczRFBS?=
 =?utf-8?B?SGczenJ5WkE0SERrVlZETmU4eVMvR2NEcnI1dUZHN1h1aVplLzlyR2tndXFF?=
 =?utf-8?B?RUtPdVoySmZITEF0UjBZOWRXa3FjaGFlTXRNeitzcWoxNGR2eDVleFN0anFB?=
 =?utf-8?B?R2lpTkx2YVRyaHd6YjFkaG80WnByeE1Ma1NTb0dvQnRDR2g0S3laQWpuZWww?=
 =?utf-8?B?TUZBZnM5SnJlK1RGbEFwVHFuMFdJTlpPVUZ1ZjJ4M2c3ejFlYVhOZG94clBN?=
 =?utf-8?B?aXlxWU9iOW1vV1FtandxaXBTbi9uWVV4VjA5U1FhTEIyZEtzd3ZLYjFLZ2Y4?=
 =?utf-8?B?dXdiS084Y3NtbkhKTWlKNDd5SlJyTWhSYTFvckdpeGl6dEdDZUQyQ3Z2Nkdm?=
 =?utf-8?B?NVFpS0VLQzdxL3VtT3hPS0ZrTGtEREYxaFhlR1p2Rk5Qai9ZcG80WEZqbkh3?=
 =?utf-8?B?QVRYa1l6L1FkVjZlSm5mRS9XUUN0N2JTTUNWRnlzTFN5ZzNVOUhlNzJGeFJV?=
 =?utf-8?B?cko2eUxTSVFxVW84N2l1cVF3a0xDV0N4K2VzT0tLcmYwUkR6NjE5cEJBN21L?=
 =?utf-8?B?OE81MjlXMmhWZlNQUC91Vy9mWTdRdnZUTnJZWTI0NHFBR2FwcjU2QTU1RDhG?=
 =?utf-8?B?NEZ1L2FhVTl1d0JyRkduM2JpSmg2NTBMeVl4THRycTB3T05ScGE1eC9zTnc3?=
 =?utf-8?B?eGc5cGR1SkR1S1BNYmo5NS94Q1JBN05ZeXY2bGJBQlFSQTV6WncyeTl2Wmw1?=
 =?utf-8?B?a2lMcTIwd0p4ZytLS2hZamV5SktwSzY3aUMyOHJHYXV5M29YaEtBVHRwZXNT?=
 =?utf-8?B?OUFndjVoNlVpcEQrYytVdi9EREpITlMvZm1mSTNIZmJGMEpBSkVzRzhyRDRp?=
 =?utf-8?B?dnFIU1dFQWZPQU5qbW9zcjd1YXNSWU5nNmZRa2ZKcmpKdUNOUHlNUHZpRXZh?=
 =?utf-8?B?QVVPWndWZkMyUDlCNUVWZEN3NHpzQ3FhTExEc2hXWHAwZ3BqVGxqS0FXVWZp?=
 =?utf-8?B?N243NTJvaUFxR3F2R3hRNEZpcGw1V0lvalZzcWZ6SVVWaUovazRZSFRkYkdZ?=
 =?utf-8?B?Qk10dlpGUVA4czllTWxkaWcvczFPaENLdnZGeXpoTTJUalRiaTJYSXp3WUxX?=
 =?utf-8?B?c0tOTzNjUW4rSndNWjlINDhrcEFGQkRCSUFZZFhiUCtVaTdXMWhIV29IU2Nr?=
 =?utf-8?B?aVdvMVRONzZueGtyT0EwUlM5RllGUjRzR1ZHL3ZnTm9qdWJNWnFpMXltQXRQ?=
 =?utf-8?B?UFU2NnBwVmR4b2MzR0F3N2RpMWVZNW5QcXhlVmtkNDhXczRNMEhFQ0NwSzVj?=
 =?utf-8?B?VGlyTUQxWkF3RWUxalN0eUFwR3p6NmVMa043VTgyQ1BKbndxMTg2eDczakgz?=
 =?utf-8?B?UFVXRWRVaVEvQzg4RVBXTjFpL0FOcVdnTUFldGR2elpJS0dDTzFLNVBUa1F0?=
 =?utf-8?B?RU84dmdVZmMxTnpaditvZlRWTCtRRWJnVUdYVnlWK2Y1bDZpMUdiV1dZT2FL?=
 =?utf-8?B?TXYwZCtiWlBsaGRQU1ByTnJlVWpaL1BIeEE2VWYwZHpTRHRjV1ZlZzRtaGFy?=
 =?utf-8?B?TnFDNlVoZFQ3Rlkrd09DUjVvWGxOVlJHOVZsR3lLdWFFM1NmazJzcU05MWpH?=
 =?utf-8?B?eUUxZWk0LzlaZkRoQ0d1TWZqMlZBUExRcTRpQ25CZk1OWDlWajRmL3VPZ0xK?=
 =?utf-8?Q?+vlSU1RqDDhKv/7E=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a085c2-e176-4864-3b25-08df3daa0af3
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 15:07:44.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wHXdTCWvhGwrTjNjt1G1z7qwLj66ef4s4fX0O2x851F5dusuYy3dG+dkBjYI1UZEXrHaefcEB9U4+rYtgyrJn6rRF8OF/TfYNwUWUkMJzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT8PR01MB853975

On 2026-11-06 21:23, sashiko-bot@kernel.org wrote:
 > dl_zero_lag() mixes PI donor state with kept task params

The 0-lag time here comes from the deadline and runtime the task ran on
during the boost, against its own bandwidth. task_non_contending() uses
the same values upstream, for a queued task at the deboost and for a
boosted task that blocks. This patch only adds the path of a task that
is not queued, which leaked before.

If the time is ahead, the runtime left fits the task's own bandwidth, so
a task that comes back gains nothing. If it is past, the bandwidth goes
with the parameters. The cost is the 0-lag time from before the boost:
switched_to_dl() cancels the timer that held it. So the release can come
up to one period of the task early, or late until the donor's deadline.
Keeping that time across a boost would change how the inactive timer
treats a boosted task. I would leave that out of this series.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
