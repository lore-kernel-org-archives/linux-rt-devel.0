Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442225;
	b=iNheHU/ud+eZZ+16xgZFCTI+qmG3sFzYNmYEIe0FQHKwAX/Lwx1pRlGxtYmdu98MMHGZ
	 IpMEZpK9VHv5oRvckLD7xCyRCKPN78sx8GOwyJPiDCQiAzSlPOibzZEls0ga/Pqh/T5lF
	 +uvRWqqtpoc3TkcrGV3NpwGhVKgCMx/7hVwy6DNb/FP8KCvyTmVCfUTO9/IUu18zYMYcj
	 Ow/KL4az0H341fx+t3gjyy/SupJd0tY+yTKi2wFBtomLjCK+bdWYyUn/zY7UJvHSHL64x
	 k5894UgUMzukJtQEIfwmVLJ9cB+1anZ8BtC2LlapRZhjHKX0CQbaqjlZNcRiWoCW8DQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442225;
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
	bh=CCEv+Vr2WxA8JFcA/JlvCcugBlYDsyQuHHAwp3uOVFM=;
	b=j1co7jJe6EHxCyIOB5xQV4sK1IrqAuMoW9Q7pfnFIbhHhXXcSlQScPERAAOlsGB8cbCv
	 Mlg2T4FI/4vo8AsA5+KXPFy8fwOoBGC7Od0hRObIwwd9FWiyIyoSYSTy2n2O2CO5484Ax
	 YXJi2h5w9hhfQ9y/podssbk6NaHjPHmfirv3LUeL6YSpFj9z6x16R9P+KNT7/6cAVv0Nq
	 T+/HgeDCkckJ6NwTO+ZsV2WfKcdIQ0o1UaGcvnfuXgi2To5sDeIHKOjLvZ8eB7NA6Ibzd
	 aGbL/ir3s9w6v3sBntJ3NCZt6/UC7tyoBnsHgwFLrQMJ8/9MlPdx6G55iAQq/Yv/iiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jyTs+VEO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.117
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020117.outbound.protection.outlook.com [52.101.189.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7939606A31F;
	Mon, 23 Nov 2026 13:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7939606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jyTs+VEO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/y25aHHahI0dHS/AG8ozDRi708blssqHcDTLqb4zS2ctv1e7mwDRyE1lq4wQpeMptq3nsCb58yOPeUy1Bcfb3Ru38aGvgENqOfLS4iW4lgRW1Vstwz2OUDqSGdrMkb64YasuHH+NlRWSi+1lHyTv183IBzesi3PrYlt5qrOJL1/0kMomew5YM17ivcWq0vkz6up1GWYNoO674xz7S4kMwFqbmeZZCSY2vaTuqyZNPHEy3HF1sz4sXq7rhFJ5qz5hsfRYX/xntebe2YjS+T8Ebk4WK7/ZQywEgVQM4bu2fPdoLEIC3W8m37HrakX6mfSKJrSjJzsWvXPRNLSTQBf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCEv+Vr2WxA8JFcA/JlvCcugBlYDsyQuHHAwp3uOVFM=;
 b=P+GjjJ3u3sAe1U9hPHLNkzMi8isRFBLVGmcEpluhptUw+hl8WrFT8uQECKBOdSAFc0bryWDcGX7svcgkCbpRfvGXDK5xjkroUNgVO12bOCh7HX5Av2H9FZQzSD429GUkKofHFD3pTKn71Bof9RCApWE7zFlOADt6Nf+fpPyK7gbiSa022YuHjadcG4CyvjuG6CVSBpee+xafplg4vM9goX74JHJ/VpIg3J+OFrO7IrNLEs/6pVZ1/X/JH83DB48O4YfymzMLc1Fc3pJ1b74/utauyS54mqRMPoOM6PWqHQlX7dQOPhJULZTDQ7JLgFPoz+cGUS55jdIXOCfwtrcqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCEv+Vr2WxA8JFcA/JlvCcugBlYDsyQuHHAwp3uOVFM=;
 b=jyTs+VEO8b4r1RLl99L9A4Dolq4r4UPSr9WnZro72jXcnqGk8KiluDTFPxLFiJuibZPqmvZcvnZokdrerp6Vt9D83cAy/4weOp9GIMyOzHP6oECORYQMpaCvj+dX+vXCNtYGwN6u5Qo5vSeAnd63ckOd35LfSKkwueL6NR26AiEQg2cGnVyuGjTwForZAiA7RlMb/yag0juLfSYmTruBP8wZPERC+GJ6Y5DPu9+KrKY9HulzPB8yWU5puzGq29/hPrsxyo8T6yknXaQw7Mp9qzWj9MkS05W1aQWVkiFbghS8QFU8PcX4QqhyWymjt3iiWFGzxxqAElNwUqBoEJCFUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB798411.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:193::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:57:01 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:57:01 +0000
Message-ID: <aa2537ec-c6f1-4b54-8212-c9c18f10fa93@efficios.com>
Date: Mon, 23 Nov 2026 08:57:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/40] selftests/sched: Test SCHED_DEADLINE bandwidth
 across a root domain rebuild
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <4bfaa652a0e1e4c92a628472be5bc3cefd29484d.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226141@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226141@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::33) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB798411:EE_
X-MS-Office365-Filtering-Correlation-Id: af89feba-cb7a-4f51-ca4c-08df4969a5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	XjpxT52DI705laRb+gChgmruKBltiGM1yyAloffit3UfqSzsQcQ7eiZxws8SOImtOYGG2cJxZaMN6IckIYADD94v9VzsdnHsVRTnK/uUpynXEGlFFX9+6c/JPSeuq6ZrNLuYISfTyW/XNbtI5oDDniFg0psPVPlB/rRIWZR28D/d4+ynwpZV57IdmL/V+5y3QpBfS1Xyd0yU4gXneWst4LirxZD0jBJKeAl+wlg5sdVF+EOob0wEiYvGufezVpOuX0kNuAmrRDk1o2Olz6+YC+aAadirbXHelquY3Wly/UgwEJUref/ewHxJXYd7+GcqNVr+pnoUFelriMhnC3rx0WdcQFIRKTD6HBVkH8nTEOOTSKhQsafBTXfeuHrBJZ63XcgW1GNRKqsRGvFJMxO7JvHILVFUwEhxF+bWjiHEHIfYpcu7Rnl9k71s2Hb7PQ5F9zZfXbJFoWPLSj5wB9SiHI301UEdmnzTfHIpPmsuKly06yZYF8grjGdm+j6AJ8z95wXFWkY/hp1bTqFCYB+kFQg/AfKYJ2sybp4qYOS924m8YN+2lKn51tntr/2h+eMighC/KZgkjGykkCCCxa4gBnTaIsMpxd07PkSrPU8e1H8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zlp6NW1kMzF1K2UxbXpnbkVNTmNJMU93TjNlWFpJZjF6YlBIWkV5MFNaeEs1?=
 =?utf-8?B?RTh2Z1FwWVdrWGRqTEdoSVRmRDFPckR6cWFRU0pYRTZXMlUxU3VaQU5udUYr?=
 =?utf-8?B?K3JMdDNueHRnQndyUndsSnNOaisyZXlYNitRY1RvdzJIQ3M1Yi83UjBRM0p3?=
 =?utf-8?B?Vkd1QXQzc0lCbmgzMjFUbE5vc25wMGpJVXJZUDF2RjM3dW9sMi80TG9hYVBl?=
 =?utf-8?B?UlBOeE5vdXEvNm9tS0hSK0JlSmxuYnRrK3RXTkx5K2J1eWxnandpY3ZITHR1?=
 =?utf-8?B?SStTc0JWNFVRZkZENUlCb1JES2VRYnM2MDhsM2hyZ2UyQ3VLYSszZjdYczd1?=
 =?utf-8?B?QUo1aE9tWjgvcGJCY0dPUUI0dlZQM0Q3UXRrVzluUkJBUHEvbXNiZ0FBcTMr?=
 =?utf-8?B?L09kOHRmaFRVcWp6OCs2bzRNeUlnd2d6M3BDL3Jxd20xQnAyTmluczhReWVp?=
 =?utf-8?B?RndGMTRKbzhZNGtvYVhzbWpjWklFL29FVjV5TU1QNTRnQUF1K1JaOTN2NDJ5?=
 =?utf-8?B?UDNhRVE0aE5laXNUZlFVVFBhRk1MZEg1QkMwM3k5emJsY2dvUEVKcThNVlBr?=
 =?utf-8?B?cFFJTm9zanpldVdiOWV2MzVRNVdjUHdZdjZNSFB2WU9VS2t3YWJacDh3VjJm?=
 =?utf-8?B?Um8yelJwNjc5YW5raE9rdWR4cFQwak0zamVMR3VGbXpQY1pDK2NDWDRJNXlL?=
 =?utf-8?B?aDUwbGFtVzAxV0pOMldsU1VCYTR6NmNNdzh5enowY3VpWklzYUZKczMvdzY4?=
 =?utf-8?B?ZHpLeWQ3U25tcVRrNUNGaXdFU0w4dGE4M2h1ZTM5L3htVUtpeC9Hb25kRmpq?=
 =?utf-8?B?RDlabTlpS2IvdS8yMGxWR1BBTUl5ZTAyRVh0OWVudlZzNDhQTzdJbTJWMUo4?=
 =?utf-8?B?YmNuVUxaaGpXN0J5ZGQrRGlqRnloSVJvdmVvbGFodUI4Tnl1MmNsQnUwMWs2?=
 =?utf-8?B?cy83T0xWZDJCYXpMV0lRMyt1SmdsSXVkaDdHVDhDNHphS2VrN0t5cGVSUTdY?=
 =?utf-8?B?TCtzK0dyVWhYbWtDem9XZ0tTeXY2QVhEUmJvSnBjbFdWK1JDeW1FUHpVTWlt?=
 =?utf-8?B?bThpdzc3NTkwU3Z0by9MWWQzVXd2S1pPVHBQd25tSGJTOVJ2NjRrU29zWjBM?=
 =?utf-8?B?OXpaUStjTjVWaDJxbExGM1ppbEZ0QXovNDErUW1NM3lCcTNFRHhneER2Q0l4?=
 =?utf-8?B?RllRZ2M1WFNpcmg2RUEwY2JzQXBjWVJqNCsxRTBoVzhHc09Ub1NRL0lNVVNz?=
 =?utf-8?B?UkIvanNTUXp4RDRTVkJyODRnUGNXUDJPV1dHbmFEM0Z6cU5iVjNWZzBua1Bj?=
 =?utf-8?B?THY1UTd4cUZPSUI3TnhwTXFFZTkrQWdQenV2am9ENFY4Y3AzYmUzbDczdWd1?=
 =?utf-8?B?UFBWSFlZcGlURjBDK2llcytrWXMybGQrcDc1czFqVUdPM1JnbWxBUnBiRmZi?=
 =?utf-8?B?a2pJdHk2VUFENUdYc0ZFYlNNV1RuYjlwY3Y4eXZxdUlKQ1RvZ0xUN3NuZERa?=
 =?utf-8?B?eCsvL2lRNk53SVNEVFVyWkFiZ3lmaXlsVWxhZFFTb3JWVlNXb1U3RUVVRFJX?=
 =?utf-8?B?TFUvTFlidFJKL0t0aldTMGJKNmxna1N3bjVMNmk5d0YvS3lwbmlNTERoVlFD?=
 =?utf-8?B?dTJWenRQOEE1azIzdzFIN1FDK3cvWFhiZkJobThXVzR0QTU3SDBna1g2cXFY?=
 =?utf-8?B?eGpHRXBUZzV3T3NueGN4R1h3cjd2RVNIcUVyYVFsbldXazdHU0hKUC83YXFI?=
 =?utf-8?B?WlpYQTFYVXFncnlrQnNwYmlIZnM0YzhxSFBmZWtCQWhZSHZ1TUdpbXd6dFhK?=
 =?utf-8?B?TE9Qeis2NFFYRlpxZzFqbmRhREhLbUp3MDI1eVhOZXFRVXh4Wi83blk2MHJL?=
 =?utf-8?B?YnhjenUvamg3WHdnL0JkN1Aweno5d3RJTG1sdyt2UDJ4SDEvNHdUdmpEUnZJ?=
 =?utf-8?B?eVZ6MDJleVExSDV3d280REoxdis1T1JjdWgreWZ1eTZLOXRVVG1qUlM3RGRy?=
 =?utf-8?B?ZFdqZkF2dnZSVy93aURKamxIMCtjNTJnVUU0cGhibzdyMTJacVpFc2NGOGUv?=
 =?utf-8?B?NVZWeGFtekhFcUhuMlFnUllNcFZrWTdhNW5ybElDSXcrT2VMSFVaZ3REWWdR?=
 =?utf-8?B?STg4Ujh4d0tZbHBzMHlJSTVBL3F5MjRqQ25XWkxDM2hURkJ2cHMweWNEYUdy?=
 =?utf-8?B?NVBQa0lTdmpYMDlpbGc0VFRCU3JwWmlkaHdlSXl3OEExU00wdXZKa3FFUjl4?=
 =?utf-8?B?VzYrNkI0M1ZsY2pmUENERGNtSUtaRXgzZDJtTnZJQmxRY1ZidkcwMDVWbzdT?=
 =?utf-8?B?QitkaVRGNGtZZVJsU296UlFhb0hMVjVHRkVpS0o3ZFJaZnN1em9nVkYyKy9F?=
 =?utf-8?Q?JpjJMupc1S2/hWHc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af89feba-cb7a-4f51-ca4c-08df4969a5d1
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:57:01.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpC5SC/GOm7uLHI2pdqKCeND4XRiC+m/tBcvbOGGMEfyg1wDBRdfgj9Z/9wQS1cQsYALpNbJCAWt5/8P4kI8+6vCfhXThBIKY9ayKl7y6xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB798411

> Should pick_cpus() or main() also call sched_setaffinity() to pin the test
> process to the non-isolated online CPUs, as deadline_bw_test does?

Yes. In v11, deadline_rebuild_test will run on the online CPUs that are
not isolated.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
