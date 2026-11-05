Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905887;
	b=JoQbKMN+dG6A2wACZjkQW7kDCRRNunmG0wGbHrGmzPV4XDe28Yq3MKqx8FBhnrqs3Yb9
	 wedQKg2iKH1GjFzLAeAJ4FnVnsROyaQbcAWckofPg+4q8ZdgFxmVTVPcriGlUbm08cdfD
	 cS/KJEVFs163CRRczNPJGrK3ZnG1Z13lrDQ5lU5zPJMUMp5Vg8j2GCaq34KxIuhU+GANc
	 o0i8zc4yFDva+ALpHcCr7YsAIvRB4tfZEyK+C7DZnMCJmZoXPuuKkUuAa9SBIkiIM1uYV
	 t2jIHD897j7uU+6poo3LcJaP8jzq+mjzPmnuEQIRpS8iZUe8BGzoEyWt3hakeKbf2Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905887;
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
	bh=nk+4efmjiYcgYse/P/9Rm6OyWsSsxvDo3CokQLJCWPk=;
	b=q+IGCAFqc59OeZHpb7OduKhluyDLvlAHvnGxVQlT5sOO7COvnWT5XfWicqw1D9SNhaNv
	 pskILpog2Okb6pqYTgwu/yiVsSRwQxbJdoM/OkGIxS4GLcLm3nI98NVR2H1lAPLJbuXSb
	 sUOdRXz0V0SwihElXy/fS2bEsVNzL0iFAY2nFZTb2ppNsO4VepMgmqDGcpekuZZFUytXB
	 +YNtHwIQ/FgVTDy+9Fxza+wu8iZI+KNTc6Xzk3PBr0ZbD2z4sSghyyH0R/PcJS+dh/NAS
	 FY++k2FRUcKJftOmpQfEYWg04v36+ijQkUE7EykGNFe6wSvZvP4CbyyK/Ul1knjSsKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=iVeY7tq0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.106
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020106.outbound.protection.outlook.com [52.101.189.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42C1606A32C;
	Thu,  5 Nov 2026 19:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D42C1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=iVeY7tq0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1rQyU+VIb+m24aYXOOR++Aj6BaC0se1ljJOdyfPg5IFwM+GwWicLrcLACFSsrmsQkHsC0cf252PAPKh9CbyyxDibK4iYVYBj7WMSPEAdWxiQex0uKkhGblM5RTeDx5hZVHDeuSS+xeKx4kZdPVxKhrOQuNGJQ6VO/+Zf+dMGBhW5CnpJ9m600tWz2BkPRWsJu33AiJXFFxhp4Ew8GJkQp1STpe5yuXn4A9sFdXiPkYa+81JIR0aUVNwaz7x9oaF4UbKe0fG1FNa7I1Wm/ilOdnO2w9NAEYqCJRMkvQon5JowWSYFM7srAi0usTVjcbhNrIi/plAdXpK3QksdRx+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk+4efmjiYcgYse/P/9Rm6OyWsSsxvDo3CokQLJCWPk=;
 b=h8I4V2Y8Oe5zN0ypRll+8NSYI4r4uj8OE/nflYIBvf78QF9RtBilKMbDPdwz3K0ld2ar1/oTqMw6cadjOQrtJETMDSq2y05KK1W0xCHYyOMSAudiRApRTcb+zdIOL+Fjm3Yb3FA2kmlCpODlHIYE7b/DdjSRO1muK05EP/4/b5zGATOevZTkoYtWOsdSDs9BePKh8NaOsyOiIiGGlrFV2HeKKx56Xr3WOBqM6eGdGpczafRqggA5QAvQxSzbKGd07AmlTWEfp8wc9oyaAgDj4nL1xV/wgcDqsPSBIPM9eJs8jMFA8CMUKdUWBEdim66eW0OzI89sLBkRaFC0YwK54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk+4efmjiYcgYse/P/9Rm6OyWsSsxvDo3CokQLJCWPk=;
 b=iVeY7tq0P6JzdJxSR6+n5AJIzDo4VonZo1R3eJEzo5k7cJlz2jQgA9btuBnAqTBQQc57XFSWuQ1yPyhl/jV088c1MZmDsP8aUaARBrtdFMZaBOTZ5mKZUNerUygdn1oI0tkNwjyCzx7VzuC5F/Svfx5YKHEgvOnBNhAyL+guGIEXA5UBTAAxz5HPmQDD8ZD+0509BmkhuL7ePpTJzCEMnc9x0OQ+wRX92jiQn9xkm48tvIMQYmoBh6JGOmlRGpsHQGHlcAcou47cSscqdgniIgN6+DrakGbzP6Psy0yCLFb0kcRx+Twg3P1x41D7QnHcWIzt9A+2skjz5MjsgKsJRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT4PR01MB179656.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:185::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:11:22 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:11:22 +0000
Message-ID: <550d3b35-5780-4726-82df-274b4d39d401@efficios.com>
Date: Thu, 5 Nov 2026 14:11:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/21] sched/deadline: Record the root domain holding a
 task's bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-16-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-198299@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-198299@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::25) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT4PR01MB179656:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d2671e-89d4-4da4-884f-08df3b70943a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261026121527099003|5023799004|4143699003|56012099006|261022075727099003|261009223027099003|261022105027099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	oH41EPz+3WG8EomOE1qFOLYdq0NLnxDxKMeYtSlG3utPrGv4Ni5M3jF5HpAWJ6Cd+oVG7rMnsaOx5r3hq0+kHzNQT8xN9ewW3bX9zgcFU0rMR8ieNiChb5qbujIX2OHNzn2ocgWgD27Ynr6YuTvjTLZjAwWhXnkjOjdLr0ppjDAtV4n1TuqdUvyKyAFvYkud6tXkN9G/z3kyA5Rjh1sDhookvJJFftVO/8Khy5dwZWtFy92myMFppgvDrTfsN16qy2EsPmlzXu1sDOe336rI5iUnddbJWWYmrXIRszbUCxGqkAiGg1H6Hla+TZX7nupt0888srNzs9sNCvlJKdiP99Tem4u4YQfBe0igveT624ETn396+uPNRQpK5W3gG6AIS9/FxtxxTKCrTTypLaNQf07ME2aVO5AqUnB3rGhSSuLXfq2eMlDLasHwVq/ihySUjwjHg01EicxLyI4Ao5Rve8aEW6gUBtkGv7pBpwFkdw9HgtkmdTQN8JVOvEFyhP0rwQ2pjjurI/WCpUg5bJd8S0Ym7ndaGlM9l5X6I0ngs9e5DLVMLtA6WXbVKh7mXTlncq8guaaOFsrXKCluSkkNi2B+X6hZsEoBd1IGqsvXV4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(5023799004)(4143699003)(56012099006)(261022075727099003)(261009223027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTErMUpWY2ZQMFRsWEdDOGNNdG4xOTcvdGNZZFgrYVIwNmRERGsyWWx3NE04?=
 =?utf-8?B?ZWI2RG9mcXdiMVdWRzVSTngwOCtaSy9FYlNDa1RUbDZtWkNOUFlkZzZWQklC?=
 =?utf-8?B?L3VHcnVuQ1VodUFLZ3Q5MXBOZEZ6M3Z2QUZ6b1p6YWFwZllOczBQN3AvUTl3?=
 =?utf-8?B?Z3U2SWtwQ1JncXYzbWFjMWcxNzR6UmhDd2pHZjlWRDZEZ3pYeXRHMm83eG8w?=
 =?utf-8?B?ZC9yWjhBRXU2WnByaS9rYVRXbmd4Nll1ZVNIemJLdEM1cTljSHN3dTRXcDNM?=
 =?utf-8?B?RGNtd3F0VW5ISnpsK2VrTUxRWllIRFljSzcyRnorN2k4bEN0clRVNVhyK1Vt?=
 =?utf-8?B?a0QvdWlTVmhBdUlWaENIMTFLV1JFS21uODNpKzJSbGtsWExxb1ozRU1CTUJX?=
 =?utf-8?B?ckFSZUNBYktZMWhyL0Uxayt1TjVLTWRwTURONTdLL1J0T2c5YzM2Kzl1UEVX?=
 =?utf-8?B?Nm8zc2tWc2FyU0E0eVhJbkVvUXgyajg3ZUVaTkFvcWtYZDZaZktrbkRLVHRz?=
 =?utf-8?B?UmI4dEYxOFdvTU1pY2pMYVRCZC9hbmMxeGdxeFNLMy9uL1dNaGNyelFBayt6?=
 =?utf-8?B?eFZ2bzFmMUU4aUErQlhwVThhbjI2RGYzOVBOWGFhNS9ZUFowaXZVOTF4N3h6?=
 =?utf-8?B?VWFjYndLaU9FK0NPUmw3VWhsaXZjSm9zYUMyVnBMaklRT3VSUlpvSDdVeHgy?=
 =?utf-8?B?SVhzeUVKWjRxTUQ5UDA2eWtmRUlLb0JZTEFDVEN5b3RxMXhhWVcxa0hzejRF?=
 =?utf-8?B?WTgySUx1Q1FYanUzaVRzQ3c2QjB0SU1lTXduR1ZTL3VuaWlyYm81UE9WLzJ4?=
 =?utf-8?B?NzMvblMvL0tZU2hKbkd5V3VDLzdUbUY2UnNQaHBySERjdU05N2grVkRUcno3?=
 =?utf-8?B?d0ZFSk1WcUJKRmFmZUN3NmdvV1N0V3JBRUV5S3FoRHYwQ20vdFB5cVdVdFdl?=
 =?utf-8?B?U05aWTRxbkhGV2Q0VWxFMnlmUGxFNWRyL1NMeFpCdCt6bUI4aHJqd0NzZmNI?=
 =?utf-8?B?Z3UvdUYwQjJ0Q2JvY3lqSUJQdG95cFZlWWlheVU0K09zSDU1b3Ayb3FsRGhw?=
 =?utf-8?B?RFBjN2d4bDh2MEg5eHVrVm5Wd3J5cmYrcld2dFdMZzR2cU5QQ0dmR0d2NU91?=
 =?utf-8?B?ZngwRXFpT2x0RWpmZXdsZjZjdE1Md292TDh2YTB2VjRjMEZxUVUwOWVra01F?=
 =?utf-8?B?OWxrMTNlWVpQS01LaXo4VGZIY2lURDlQR2ZSLzBvMmlRVjFPcUlqaVd6WkRt?=
 =?utf-8?B?QTZOeTVMZjFCOHVSMFlZOGZOaWZOaFFVSmFDRGlvM05veHFoSlRLdmNaa3F0?=
 =?utf-8?B?ek95SGVlL2lSQ0F5RVRGdXZCTXZ0S2N3TlczUVhmVm4rRVpUcDdQdnVvR3pp?=
 =?utf-8?B?bDlWZkNZd1JWUjVtcFRzdGw3ZnhncXVHSS9KaUNaL2dDZkk1cEJBQmFrWW5Q?=
 =?utf-8?B?L3l5Q1I1d3Q4cXVvWURja05xOUdMSHlNV2o1ZlVGVDMvWFVnN2Q3TFZkaDVv?=
 =?utf-8?B?NHJoejVYekY3dUZuOWdIdi9paVJvcG83TzVJczlBQzJiWHo4SnNoeTBLV29W?=
 =?utf-8?B?NTFaYXhlVXZZdnpreGxId0l1Y1JMUnlCOHM4dlU4bGExbWpudGNaRDdiQWU3?=
 =?utf-8?B?WjB4NWNvcjErRGNHcGgyYWQzZWJGdGVkSm9hM2lObzlLQWVxelpadXRaMVc0?=
 =?utf-8?B?OEFnallGWit4S0hYaFJVQTk3dWJuVXY0UEsxLzZKRzhZWmxGTm9pQTcyMkdh?=
 =?utf-8?B?Y1kyYVFCYmx4K1BRUThQSnFMVXhHK0h0MHpncGlyZTRoNEk4ZzAxYnRST2pr?=
 =?utf-8?B?OEdRWjVJdFQzVStmNjNoYzlGTWFGOWJCNWR3YnlRa1Zmd25vN1F3VlRMNVVz?=
 =?utf-8?B?ckZCbzlYbHN2OExHTVBSWXVmaWFmWjVrZ29ZRmw2NlplUDd3bWwrK1VtYU8z?=
 =?utf-8?B?Q1ZFbzZzd1RNaExKUytpaFBBc1JmL1JqWlhtQTJqQzA1N2Z3MExyeGJ4RG5L?=
 =?utf-8?B?M3ZlZ1VIb2t2bXRXcGsybEVFeFVzUVhMMXoxRnFKdm9lQ2RIWWpkVXg4UU1J?=
 =?utf-8?B?cEYxU2gzd0FQUlF6UExqazZ1YWJTWXMvcDFobHFIdkdDWEN6UTJGSkI2UnBp?=
 =?utf-8?B?S0RTZ2JETWhtL0dVU1l6ekFSV3NYK1gxQmFEUmRNMHh2K293MDUrck5EeHdq?=
 =?utf-8?B?NnRVcG16UzNnT1E2SG1ZcWlWN25QR2JNSUxibzhhVll0UFhPajBkeG1Pcm5i?=
 =?utf-8?B?bWJodlgrVkdJMWowZERFditvcktaL3lFWWVWOTBXbXozT0JKYk4yTlF5djBR?=
 =?utf-8?B?Z2s0Wld2OEdSVzcyS0FBOWFHWVVDN3grUXlvOUUvamJNQXdNcER4M3JaK0VI?=
 =?utf-8?Q?mdA8sGNzXUS8fCNzrGC0RjvxNiN8/whdbVHia?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d2671e-89d4-4da4-884f-08df3b70943a
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:11:21.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8hSs9cVR+Wa+Rki8HYiLPgS7wPOBDDgaqa/v2h3VYnzd/IYp7Uzo+UxxseJtYgLfkW1JkF96r2nsJGH9GPLNktnuaShtNZzdJsCnsEDvjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB179656

On 2026-11-04 18:31, sashiko-bot@kernel.org wrote:
[...]
> 
> [Severity: High]
> Can root domain bandwidth accounting be corrupted during a rebuild when a
> departed task is boosted into dl_sched_class via priority inheritance before
> its 0-lag time expires?
> 
> When a SCHED_DEADLINE task leaves the deadline policy before its 0-lag time,
> switched_from_dl() arms inactive_timer and calls dl_task_depart(p) to link
> p->dl.dl_departed_node onto dl_departed_list with p->dl.dl_bw_cpu recording
> its root domain CPU. If p is then PI-boosted via rt_mutex_setprio() ->
> switched_to_dl(), dl_task_undepart(p) unlinks p->dl.dl_departed_node while
> preserving p->dl.dl_bw_cpu.
> 
> If dl_rebuild_rd_accounting() runs while p is PI-boosted,
> dl_add_task_root_domain(p) sees list_empty(&p->dl.dl_departed_node) == true:
> 
> 1. If p was moved to another cpuset partition while in SCHED_NORMAL (where no
> deadline admission check ran because !dl_task(p)), dl_add_task_root_domain(p)
> ignores p->dl.dl_bw_cpu, adds p->dl.dl_bw to the new cpuset's root domain via
> dl_get_task_effective_cpus(p), and overwrites p->dl.dl_bw_cpu with cpu. Or,
> if an earlier rebuild had already dropped p's departing bandwidth, this path
> resurrects p->dl.dl_bw into p's effective cpuset.
> 
> 2. Because rt_mutex_setprio() only holds p->pi_lock and rq->__lock (not
> cpuset_mutex or dl_accounting_mutex), p can be PI-boosted when
> dl_clear_root_domains() runs (so it is not on dl_departed_list and is not
> restored there) and then deboost via rt_mutex_setprio() -> switched_from_dl()
> before the task walk reaches p. switched_from_dl() puts p back onto
> dl_departed_list after dl_clear_root_domains() has already finished, and
> dl_add_task_root_domain(p) skips p because !dl_task(p) is now true, dropping
> p's active 0-lag bandwidth completely.
> 

[ Repeating answer to PATCH v2 09/21, which is also relevant here. ]

A departed task boosted into the class before its 0-lag time is counted
once, wherever a rebuild runs: the walk finds it in the class and counts
it in its cpuset's root domain, the record is updated, and the release at
the deboost reads the record. Where the deboost races the walk, the
departing bandwidth is dropped for the remaining lag, as it is for a
departed task whose recorded CPU went inactive; the generation keeps the
release out, so nothing underflows.

A rebuild that finds a CPU for a task an earlier one dropped counts it again,
which is the intent: the bandwidth of a departed task is held until its 0-lag
time.

> 3. For a regular non-deadline task with p->dl.dl_bw == 0 that is PI-boosted
> during a rebuild, dl_add_task_root_domain(p) unconditionally sets
> p->dl.dl_bw_cpu = cpu, leaving a non-negative dl_bw_cpu on a task with zero
> bandwidth after it deboosts.
> 
> Should a departed task stay on dl_departed_list across PI boost/deboost until
> its bandwidth is actually released, and should dl_add_task_root_domain(p) skip
> tasks with p->dl.dl_bw == 0?

Part 3 is fixed in v3: the walk skips a task with no bandwidth of its own, so a
boosted task gets no record. A departed task need not stay on the list across a
boost: the record stays, and the release at the deboost reads it.

> [Severity: Medium]
> Does updating a task's deadline parameters while it is asleep after moving to
> a new cpuset partition still use the stale task_cpu(p) root domain in
> __sched_setscheduler() and sched_dl_overflow()?

The EPERM is the baseline's affinity check of __sched_setscheduler(),
which compares the span of the runqueue the sleeping task is on with its
new mask; out of scope here. The uncounted path runs with admission
control off alone.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
