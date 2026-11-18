Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795036177;
	b=h5onX8K/YE5HLdPZpmNBYKFmEcJQtKkAfeL4taE+nLUBlM90q5XtuN2WpEFPJy3hlARm
	 nPAOvk+EaTzcewKVj/rQbISqgYlsTBl3J4aJwN1rr2Ut4z5hKOZZEa4hCYjXQCJDeYbpn
	 jtLC+AaUeIK4ESY1AfuaGfbBxobjOm4i4g60yrVGzlt27b/SXn+6lWETFoP0uw5T3O/Jv
	 MShuphX9bQeABHzBDXHvNZpvT7hIKuMgD0/LqOGGb7+IY9bxnEDU8+0l84PArcs5r6dAH
	 7nrielCRMeSbcfb76+wEXUx4p6qKpKTf90Djs7lxAADRqhm7bl1mBkf8lN9KVO72+dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036177;
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
	bh=RHNQ9W+HyhYDwL762h8hI4Ct2sgK35usTzUwzxJmE5c=;
	b=RTcLnyb7UPwJ/UKSG6AdjhUETenp+/Nl7fNalvqmq15gUSAeDJpXio5Gae3cXeZJJD+C
	 cToqVSDZkX8g+A6cx96z9GPGyDUoBtHanTVLGrPKr+ZQi7vPzNufQkreqtHp9gWmQrkLl
	 3SZB/JgpfVUzIo9ryCmLJiSw1awm1mvSJ0Ovh3gQFThNVGWipCaCikOS7m/I2Iik+bq2G
	 TBdlN082ugody6ooBXE6PL9RBL4Kj/fYyks74A1i0FTqe6qeqRYpjSuoD6SnHu3KyxG+L
	 yx+ufkgbPHhZlQy8CDNrivesve3TD8O8ZrS5J/pUCmn4AMPtdkjHl52NUtRPLZslC9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=WjWrTVAk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.78
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020078.outbound.protection.outlook.com [52.101.189.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB5606A332;
	Wed, 18 Nov 2026 21:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CAB5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=WjWrTVAk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH3FUnOs72aTNhKjBD5kh0lfZh2YTLKKimIN+YMZzKGcPuua5gLf75I6Frv9Oxvq4qnAUs7jjY2t3Kw2OntCP+4BEBQGqZyfx3vrwl4SQksuBEQbHltJaeDKWwVJMpeeK8ScOJzEQYJ+nG4fNCg7P+6HZxmuMJK9nQmw+tDUT8MwzanPHqSTK6+rePtkSbryxgr+R6KUcbR1kLXJDydYs3wko1WJ0Uk2RZ9lPxIBuM8VvBRVsR47w7Au2XKw1/MUsa625Mkeh22j8qHCogwz0cDv+dcGmiqkfQqhtf7iNgXAeb88oAWlOoJEbzHU8Wzyb1ZYoO9dAosQVwo3Lz3jrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHNQ9W+HyhYDwL762h8hI4Ct2sgK35usTzUwzxJmE5c=;
 b=AsdtfbMoP8EymWJU35MocrrErXQ/srNRWLgIlyr/cfgsYJSopESZ9AoVxDkrmO1WI+7XZ1uMBGPvM24CZAPn5x/WLM/EAeaCYvpZ8mOjh7kk2IwslzToC1vXD7GXdgZNlsx3ZonFeDwhNk4FcHCy7NsnhcLEWr/VcFgsc5gpbNW0SZWzCWwIjIjhDFeUR012F5aW3hcFS+0CSEUC/i4nqhO47mP9e2XlisTyv/LpYtHJoZ0quUBueYZbKFifdJMIux0goZQLBH0cWVhZrUqzOsFs+CmaRJe5YLMAwylu5aGlgkQwuOqtN/+Pwu3zmqpmtHtve5Hl0ZsQ95muNyKFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHNQ9W+HyhYDwL762h8hI4Ct2sgK35usTzUwzxJmE5c=;
 b=WjWrTVAkNTNmm/nyojc/CV1L8D4/Zsk2gfVpBP0LcCPL5/TfSZpelBqqFY1M1xK4zo885XyF9O6tnPKaNCE/Uy3zNMsVmTX9SY0OG7UEau9xzigEsZoz+S4zPRW50NGIWwhU6kvAE55DdptdwQrPj15DGkNLqx+5dwyvGP5kk5OYh2azdICV17mKUAMn0b1D7MnE4nw7tl9sAFqhnHOejtCzq1gwxGFPAJHmeoJW+VQzoSDMlXZSSbfTLP5koCE6MT+hRr9iVMlZqSPlnW9wgnjztQnH4QKBNH4SgQUwgV2dsD2V4J80Opp0TdVHe/fxCVDrroXHoPhkKCF9FJtS+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PPF3A2914458.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::529) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 21:09:35 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 21:09:35 +0000
Message-ID: <878090e9-2ed5-46ac-a1c0-219ed114a741@efficios.com>
Date: Wed, 18 Nov 2026 16:09:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] sched/deadline: Do not lose a throttled task
 switched out and back
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <e58738e763010632a024a6874a97f1d980b90ce3.1795031605.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-221937@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-221937@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0182.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::24) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT1PPF3A2914458:EE_
X-MS-Office365-Filtering-Correlation-Id: 54be92bf-10ad-4f24-fcdc-08df45b83fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|3023799007|4143699003|56012099006|261026121527099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	0/UdFx/yjWUFnDaRkJDpftTNguKz0sX7MxS9UwpUS4raYzvGwm8P+//plGVKG6gzjXJ42e4+y6mxCmF0BaXiXLsqX22xfIUcokyMFsYDM2vJ+3XACbgSYOKwCeVNbhu4hkeuNNhPOmeQfPUHIm5prrXvhc/5ATcc8Es6uwAy10O0lHTPIIGLOEk3BTYYJ3FR0ZxGZYI1gaMVJWGNfhzdE1No2Ag6dDRrBYsIiVNKpM7QrB8zSe+AeBhy6VXMGQXAuYFTGdvQ93lTeffiZdHxpxf3oLf7b1UaePC60VPnaN5q7OSLMV0BCfvPDSEZqWePtllFUWYeIIjepndToX2XH8l1DvHvW4fKJjG5751/Z2zY09Il5GeWPL7bcWzXP0ra6MlHFCGqJduZM6cs15UaGYOGFRg5GJpPkWkzff/o50zERlOTU6Y4YT5OFRa8QcvDmcgaJ17cIy3E/44niriMTSp86mU7F6WAdNuqbVVPZCmahEPByr7yr/oKbzCNH4mB7Nb59FprJJbTKyCTdqrtartogbOIHwmPuLsXYljHRJKcjAiD9T2RRCFTgvxV12HuA0IJ7oH9x7nsWWoOzEjmZ+22knNwE3KDF+Nq3H371pE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(261026121527099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qy9Kemphdko1aG1iZVlxWFR4NkdCRjgxazhIT1VNSC9ZUVNBQ0JvU2JpWGRL?=
 =?utf-8?B?Y1czN0s3TzFvRXlOek9UMFBPbndjcGxsQ1JiYkc4L2U5TWFQZkIxWEYwRkRz?=
 =?utf-8?B?K1BWalI1WVBDWnR3ZzZCcE9lcGJjU0krZloyL3FNMU5EY2xvL2R4OHJ6cmsz?=
 =?utf-8?B?anZnZktpVFc5cnU5QjRJVGxaa08zRUlJUWxQdlJmRkFYbTJhVm4rYU1Hb3Iw?=
 =?utf-8?B?eFE1YjhaWXp3V3M1c2NVZEE0N05TTUdFRWk2SUM3SVhkRlRGdzR6WklzcjI1?=
 =?utf-8?B?NTdtckFOa05SYkRVRHZvNm54eVNmSVcwNXVMWXcrNzRFRDhrMlNvUVFJeG9F?=
 =?utf-8?B?c3RIVDN3MUFrNlJyeStweVpJNWhGTDFHZjNweFREbHF2YXk2V3VndndMWEdO?=
 =?utf-8?B?eXJhOEgxVjhRUElCaGtMcngyRmF4N1phTXlzSVRjcGhVRlRRa1hRbEQxTTJL?=
 =?utf-8?B?WUZJUnpUU2NQTXBYbnVzODI0d3BGNUVVVGEwUmlqaE5PcU42T3dHdUt2WEk0?=
 =?utf-8?B?dDJFQnloeVdNd1VCUkF6UnBnaVAyai9uelQ4TkRHdHdtNDRmb1gzck1CdGhk?=
 =?utf-8?B?ZGFWUVpGdjA3R1F2VFVPdHQybFAxcEhiY1pNUktqQS9Wb1B4bDRSZkVzcmUv?=
 =?utf-8?B?NjJVdjA4ZzgwTFV6UGliM3VoampMVFFDdThSMko2emhzR1NCanpwdFg5UVZD?=
 =?utf-8?B?ZWlGckFuWHdjMTh5RFR6ditodWVEWitnOHFYVW1DZ08wczl5VGNMb1pHMXVt?=
 =?utf-8?B?dmtZd3BUek4vb2N6NkFQaEFuM29ZejhUakFtakRWbVczSDNLWmY0Q1k5R3ln?=
 =?utf-8?B?TDdyeVNMc0x6MTJ2N2pzVnI0R3dXaTZ6NFh3K0p1WTJsTFVzZHhuUyt1TVZm?=
 =?utf-8?B?RFd3MnJ5c3lXZ2RiRGNkN3YwV3AxUmFoWVYvdVNoZktIbkU2QnZTSXo2VGVB?=
 =?utf-8?B?Y1M0c3hEVS9xbElHYUZPZmtxQXYyS0pUV0Z5bmhYbDFHSjRsTHFtM3VQR2JI?=
 =?utf-8?B?VCs1UXVDUHJBMGdvalh3Wkw0OGFHWTRWWS8xYjlNOE1QQUFVVE5rQjgvekN6?=
 =?utf-8?B?ODdveVJqLy9sQnN4VHZaTkZYcWpZOTMvdHNQZEdKYURHVFZJRHoxUkFEbFl5?=
 =?utf-8?B?ODdoSHRyZ2YvK2QzdFFhRUJxOW1Xd2VYaG9VWFNWejRpZ1YyYkxYb0hQQ2FD?=
 =?utf-8?B?ZW1YdE5ORjRkdG50ckRYemFjdURtY1FDcHFWVUdXZTVXZ2NmOXBBNHhYRHVD?=
 =?utf-8?B?RDhtdDlVWk9tWFZGdHFQM2tvYTAwaTdGRHZ3Q1A5clFsQnloSTY5c25OdUlP?=
 =?utf-8?B?Q2hFeDUwMFFkYzhPWUkwTTdkTUVvYUEydVhUMXBYUUJYemlNYWtjc0xEeUNq?=
 =?utf-8?B?S01ReWtHUjc1KzZzd1hML2F0cTlXZDQzMjNFN0Z5ckNnTmxnMU5sUTc4YlFQ?=
 =?utf-8?B?Z2VWS0QvV2hWNUlSek5INTQ3dGhBN0JSWVpqZzFyWXp6RG9XZHVQemlESnAw?=
 =?utf-8?B?dmhMTHhCdlJNaTAwY055cjFLRHE2TDhWMEwyODNqWDdhb0hRSGNVZXRYVENG?=
 =?utf-8?B?M3hXOUFtckN5NlFXTnBQSEFQNlA4Znp6QnZZUXk2dVBXWHl2dVROdVVUcE11?=
 =?utf-8?B?aDRWTXR3WGJXQ2VOK2xlUWxYUzlPSUJiaE9BRWg2TzU2Z1pjVVozd3I0TEJJ?=
 =?utf-8?B?bExTakR1cGRQcVhzNSt2YTJuME1yUzE2dWJ6ejZvMm5EeWtpem92OHQ4M29G?=
 =?utf-8?B?aUJNRUJvWnAvVm5CZU9pcWRjUE1yUnZyMUtHRWtmZ3NodnhBaHBvYmZsbHAx?=
 =?utf-8?B?OG0wNGxHUjMxZzIvOFBhN3VDSTVIRGsrajVLbnNiL2NYRjlMSHcySVFoVTRP?=
 =?utf-8?B?a3hXRG1xVEx5UDJPUWczTTh4dnRvS2xjV1kvUzJEbEZVUEdxUGJsNDdHL2Ji?=
 =?utf-8?B?dDNoVEdJalkzQ3dZQS9vbGhKN0FGcCtRandsZ0R0REJoczI5UUVPUU5RWndo?=
 =?utf-8?B?MDR5UUFibkFiby9qOVprT25qZWpEeVJybXZZaDNHSC8rakNvbGRGNjdGVjg4?=
 =?utf-8?B?UHVVZ21LMFErbVRyWGVYeitBOXFjQXl3U0ZDcE9uSWlhSUFvWVVENzMzS2dx?=
 =?utf-8?B?dlhpdy9GZ0xCemloRVdWajVOSzdDT3BtUnY4MlE0WXo4eDVlY21xRTdPc1Aw?=
 =?utf-8?B?NGdBcGhCbW1JWWxwcUNlVlg2bkZhR2hLeTArV3VlUzRPSXFoYVRRUUZXRm4r?=
 =?utf-8?B?UFdCdlpuVzRvaHJjb2JROGhTVk5QSDBrZHozc2hjbG01ZG1WMWZtTCswa2hD?=
 =?utf-8?B?WVhXM3d5NHhkREErcld1V2hyYXZSWWZ3bXAzcVllYzZNVUo0dHczbUdFcnVr?=
 =?utf-8?Q?qW4Q3JA43Bt0qobrvIlGzWJMKxLu7O0A301GH?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54be92bf-10ad-4f24-fcdc-08df45b83fd1
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 21:09:35.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otqxKTcok/h+Oq2jo/V/VbVscj/E7vBnRszs6s2GtGyRmM3Ss7qdnnERdiwFnzz2zbbFL2k9ckJ7QnYbBz7/YoSvSfLcXd6Zn+PIlaWv42Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF3A2914458

> This problem wasn't introduced by this patch, but in the opposite order
> where the 0-lag time elapses before dl_se->dl_timer fires [1], does
> __dl_clear_params() leave a stale dl_se->dl_timer armed along with stale
> dl_se->deadline and dl_se->runtime values?

Yes. Two patches fix it: 
- Patch 9 of this series resets the deadline and the runtime in
  __dl_clear_params(). It is "sched/deadline: Reset the deadline and
  the runtime with the parameters".
- "sched/deadline: Cancel the replenishment timer with the parameters"
  cancels the timer there. It is in the second series, which applies on
  top of this one.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
