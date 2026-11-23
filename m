Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442285;
	b=p9rrK2ECJ054f/WQpTmRGmDW7RXYrWo7TfQX1frXHSxd1Mxv+/78z9yZJjpB0sUPOQsc
	 xoAcr6haE+axPedSZOAPOS7TPsD12rl1dAGGPvjfnIuEn267wv0wSCFcppOxtemJ3tW3G
	 pw8UaVXVCQ54UJHjtrRlmSuhvltG+8LeLrzN6mW+u1FfZTlGIlOBh2oekF2M2HT8QPzNM
	 vVEXAvvhYDvT7cDe2xkJRCf/dVb53SVCKtJ3pn8hpAqcL+U3YACq7FFBTLaB+Mby8teBG
	 LXazsKsm82g4A50x6NxcU+meapM3Yeou32RmqQL95H8d/GuCeZG/QXC20hoxD7i/V/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442285;
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
	bh=3jzAUgec3ClgegYoaub9TyB2Cfq9fT3dcUaVriqoh+I=;
	b=N6dbL2fO2jLKWGrB4ks6EdrEPHH4jrqiV3Nk8Lm9iCorWrI+g5vNBDFexpzxhZiD+bwo
	 R6i/sO0eZTROXW9IJAnE75cFdZzmfVcnYqtU+wUU1pYSzSosW1fvtiwj3AsJsVvQTR8NZ
	 jCUONlG+REc3UED2SwbOleePoroOFFK9EV65QfQRe6mnsDlCXLunW8MFjT+UlcGTdGFJl
	 PSEl1hSp7q5L1NmpdLQuE3af9LZCwcJcqVhmLhvIG12JQPrDxCRkstBK/s13NsOTPiviR
	 YCNxV/myROttAuW/Cp73UPkZrUOMKHc5UTrct/DrQ+MBsnRCgnDR0l5nnyHcYb/RHTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="A6t/OFXI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.110
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020110.outbound.protection.outlook.com [52.101.189.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06179606A6A8;
	Mon, 23 Nov 2026 13:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06179606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=A6t/OFXI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8rXvr/QWGVnxBmxCxoVFTN5cwoDIY5aRB5AOIXa2pqeislOriPiqqWDK5f96djr/TS6fvNiVxDO1OsGRwnNIN3FuQwSirLKPBfgoqfCkgw11pQTyVbXad1cJzoTqZtB3cvUg/ZayVISYc8wH0H0iyyGKXyPRlJNmY0fgVZmgFJ7qAGs3v4VMmAQTY+ESxA2JjMQddl2YKcOzVnjSqgWNVx/dDKK+YsrWp+t4M0TbdEF66p4Y3PaQpBFQGl5hBEcotvmwEgtRdu6cXkxIUCiyDNKndtgd7B+HiTxFSzQRcDTMc9r5POTJ1hlpR6+Cg6mGPEjDy8hQ0uJU2RaSXEAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jzAUgec3ClgegYoaub9TyB2Cfq9fT3dcUaVriqoh+I=;
 b=aX4mreW2Dqw2WJ0LjllGYGPcwSn9Z6RXq7BbZhWuN4nmNh6Y/qSZt4Eg2hanoHWaDwBst/FktdKubkUMVWlETsRBRmIfIDe+znCCkDpa9SUhHPfHHZDmwrChUpygrdkSlxbuNZ5N5KLB1jIxndzJISz4/RWUFDBFwGxZGc4W7KvVvWOf27AOPGUiJRmeZ/OQd7Ti7Ba9ayvtcEbD/M398LpUb996kceM/kp9Icwm9NMFMc+ammBW05PR6mD6ATZrRHkVS5uk2dJxxIZEuK7qC03ShIoNSzbju5U5EAy5Stb5WfmfkDNO8CAWcioZWW1taIBgbiVzuhIP/Yl3vdpLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jzAUgec3ClgegYoaub9TyB2Cfq9fT3dcUaVriqoh+I=;
 b=A6t/OFXIFJx2s4PEdnG6ZRive43dIQ1vGpQajzsUQSJaZ2g+XKSbEEtVF7ZVssF+Kqa6vL+kMOXdWJfqq+uKIB5IuJ6+y+sqdoMfTOogjR2HKFzNswpD5fIwXt4BDsf2/fpNtZ+MJqu0bqfQoVt8KqlDiXcrKuCst1wBan3U2L37d7ESmu4RA+RbYfx3QRCqTnMdqb12UuwoHDFINjZSwHon4vApiW/F3FyVNHKxowlNXGv0qP7+BINc/I9jFutHt0BbGIigMwBSQwLXboEUNfYLR13XmeZua7MhVpeezLFT3/ZnqmdpdtxU4P/7A1ASL45MzWbC7eo9i992UkZe5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQXPR01MB5199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:58:03 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:58:03 +0000
Message-ID: <20fa7629-357d-424a-b054-9206fd486315@efficios.com>
Date: Mon, 23 Nov 2026 08:58:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 16/40] sched/deadline: Keep the last CPU a task has in
 its root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <efba6f58f1e0ef5cea319448374083b8149f26da.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226157@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-226157@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::14) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQXPR01MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 122b8d57-7988-47b7-4c5c-08df4969cabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261102123227099003|261022075727099003|261028144727099003|56012099006|4143699003|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	kxA7ovhIdZRSVJgI+OQrEHDTYeF390NKLgiU8YdDOZr2T4Xh/BO89I34WtKrZ+cTAd7UBFoKwYcK4FyuPnQmYug/ctQ1lEhEYQE34zuP8dWR2LJeH3SqGhDLXNa1kAQTGqDxtdjkouu3TA5WrLaQjykbPRqX0XzvqwqfpqaR74w67n6SOz3I0t7ieUBiVcwRX1S9BV9gYepM4W1/Gdf4xQpVCfDJuj+53LvwWRIs3O1O6n5uP4UdCMJI0oHYExA1yhyAQs8Sbpd9q5tSGobHnD6cTs7RURdBSRpQfdyrMi7ouixGzNbgaG7vAfxxvni++K1PWfklCdMoyL2NOu+xKd2akJzGXirLj2Ega8IebluTZ037sETijmEYWLxjJi30NQ0DQ+a/fZrMNIgNeXsX885JVfGBLdUgwoTyapvW0tP/0ku+AknWJ6UXclUREPqja/E5W5ThWdOzFZr3jJqu6YLGe8XQnUmrtu6msxUkSKqCCiETMoyW95MaM+lTIblluWfRL0UknYo+ZTC5KKlvXJd36lbEL+Xbe3NvfBe3NvcT8t+ZJMIvF8BSTkE1EeetxrCoe8GeOrBVvwiaOv9PmVZ2ZoflSG3ZOtYgWDTkRsY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261022075727099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUE4QWNndk84eHBYcFlOQk51L3JUZFVRTms3MGpLN3YvUTJmZDdxM3FmNmF5?=
 =?utf-8?B?a08xbGVJcHZTU1V3OTNObms1R2U4SlBpL2ZQUHVlWWV5d1lJVXB0Z2d1V1Vp?=
 =?utf-8?B?QUpSSlJtOUFYQ3ZUR2J1WTBWVGFXOXovcytNMHZWUDVsSXhmSHZWZUs1cU5N?=
 =?utf-8?B?UTdtajhjbDNqeGppbUh6dkhwa1V3ZUxzUkVJMU90ZHlJTy92cHI3djdPN3VP?=
 =?utf-8?B?ZERQd1JjUW9pNW82dkJuSjk2bm1XNGVBcElOTmh5ejZiK3dEZ2pUZmpHLzJw?=
 =?utf-8?B?RTh6UEFpSkQzV1JHdmpKSmhWMnBtKy9pM2tVWnB6RjVKSS9xWHd3NElNN3BT?=
 =?utf-8?B?SGpZWWxhZ0pNMnVuRldKZVJxYXdnaHdiQVFjYWFXNUtLa3J2L3hRblNITWR5?=
 =?utf-8?B?N3lLWFpKdHl0SnNnVFA3QWc2VHdGaTJJaG54NjRQemszZTIvS1F5b1JMZk5l?=
 =?utf-8?B?TkZkQndXNTFocDd2ZDFETnB1QTRYM1BmOFRPdTJTY1lCdlR0RFRTcnU5MS9v?=
 =?utf-8?B?ajhWUzhCVTVYSXhyQktSaTZRWFlQSUp0OXZLdTBRM2VjdU9FZU9qa2FDU1A3?=
 =?utf-8?B?VHpvVmxuczdNTWhOVVlMczF3ZXJGQzUxYlk5VllTOG9Ob2FUTDV2OTNod2U1?=
 =?utf-8?B?cTU1K0NxblBBcGpUQ3pQTWlLRjBSUjk3d1RJU0dsN2NyS3NjckQvSlRvcGIr?=
 =?utf-8?B?TjF1end5WVowcm9YRzlyM1ovSUlIRG1ieFJFV3h0QzVFekpjdHdabWZwaVBW?=
 =?utf-8?B?VmNyWGE5bURicUkraTliTWVEWWdMV09RSHpocktSbW52TzVvYnZab1hiQlpx?=
 =?utf-8?B?cjFvOG1QanhiWHdaRnJ0b1ErVzRQZWlkRnpOb25TVEV2TWwyVkFmWEpuQnZl?=
 =?utf-8?B?alUrMjJmOUpyLzlFQS9Zb1R4WGVBQ3g3ZllDdVEwNFZ6eHQvL2kvOXVqWUJ1?=
 =?utf-8?B?b3h3WWQ5VXd3c1Y0RU4xbTFvRHJXdE1NeUE1OGJJM0RZWDRwd2EydElLbENV?=
 =?utf-8?B?MSt6YTF6RE1mVlNkYzZPbzhOb3BqQkxtWlZxeGxOSkFXWlhKdmJDelY4a3By?=
 =?utf-8?B?aEZMS1RqZDZTVEgrZEk4WEc1cG9LbEV0UGl4SnZ4VnROeEVtSklwdXlGRHY4?=
 =?utf-8?B?eVFwbTR3U3J0YkxUVkYzVGFuOWowRFRuL3pyOG5tTFJuMTFCQS9kTitvVUFF?=
 =?utf-8?B?UWRkWG55QVFXUFB4Z3crbGtpWE1iUWZ3TnMrRGpHQWkwWTBFNzJFSXd0RG5s?=
 =?utf-8?B?YXRUS09aL1RBR1NiSG9YbXNPVVl0WkQreWYxODBUT0Z2SHlWUGRkbHBrTjdo?=
 =?utf-8?B?R2MyMzJ4M3VBMyt6dDIvWk8vNFVDRE1oVGJNV2xuVEpBUnBNb004Q2JqamIv?=
 =?utf-8?B?elVaVVVKeTZTWVhlRHljU1NWaXUybThEa1JGVzdXamk2Z2NISGFWQ3lhS0Yw?=
 =?utf-8?B?NFRWNVA2UHpackxlMjJiUXJJZXBVMlI1WTF1NUdXYWo4bHdpRjM1L3VpNTZl?=
 =?utf-8?B?MTRxY29LWENUeldNeHN1NDFsWDFtWUJBeStpbWJwRWwvS2ZFS2tWTU1sdEpY?=
 =?utf-8?B?b2NJOGdGUDYwMlhiSlF0UytiVEpWWnBhUloxcHZ5VHdRQWFTRzNDajMxcklX?=
 =?utf-8?B?Z2htMGlHUFFrQlpjd0NORU9QQnFaWnB0NE5PdFYwbVA2VVVNcXJEV0JrSXFO?=
 =?utf-8?B?bmprRnpGNHF5NE0wTWhqczU3ODRwS3dGbTllaVRQNHlmK2dTRm1HaytqaVRN?=
 =?utf-8?B?T1FBaHJEazFOL1M4Z0R3TmFVdDZtWkNiMXJZNzdNQXdJUHVVYUNDQ3FwN3Jv?=
 =?utf-8?B?YjI4Qll4Ti9ocnVYeWFHR0J5THRpRGNwRGhnTm1tRUw5YlBzYnpHRkMrcHJr?=
 =?utf-8?B?Q0FHR1UzeGtpVGpkdHpKRlgvTkh2QkQzeDQzUGFjcmJ2ZGo3YW9LRTdEb3Ni?=
 =?utf-8?B?VWtnOFh3Nk1YMjZPaW5xSER2V01PMUR3dnErdEhGZGxDSFoyWnkxdkRiOU1l?=
 =?utf-8?B?Y1NVVzhuNGVYTzdKNW90S3Q5NmpZRkQ0c1NORnlVSUxoczVzOXMzV1RDUm1K?=
 =?utf-8?B?ZW1pUEx1WmVtam9PMjY2dVd5RzBDd1N4MGtOK2cwR2hEY0l5MnhueHVlekNo?=
 =?utf-8?B?MWV4Z1VRT1FoVE1uMWxpQ0tUakdOL3VZanV1bTRVK3c2Y01sZVRQOHdMZWpJ?=
 =?utf-8?B?TTJRVDEwTFhjcW92MjNjK3lKZnE4WG1yVGxaNFlVaTEzYmlEMlY5emZ0aGsr?=
 =?utf-8?B?TU9oUzBpZSt0RklHVUpSK1JKU0ZLRG1PbG9HZFZZT0RCSzQ0ZnZuL0pmYXBS?=
 =?utf-8?B?cTl5OTFDWXkwZ1JQdmtJMXVKV3gxTysvTHZpMXc0WWNjOWFXRUVmdHZoZzFo?=
 =?utf-8?Q?XiG3WpfQTrQrACeA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122b8d57-7988-47b7-4c5c-08df4969cabd
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:58:03.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWWUsVHoAPQGIg27huQdmZsx/cobZmoKr+KCfNHkngTvTBZotb2KDEXv8np7uzUnZeRmf4EBgEIHI3IGcxQqwznG793Ja5cmN/PtX5uAi9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5199

> When gone is set and p was initially unpopulated with no active CPUs of
> its own, does partition_child_lost() pick the last valid sibling
> partition after gone instead of the first?

Yes. cpuset invalidates the siblings after gone in the order of its
hotplug walk, until one gives p an active CPU. The model picked the last
sibling that covers the CPUs left. With mixed partition types, a
deadline task could then change root domain unadmitted.

Your second, fourth and fifth points come from the same model. So v11
will stop modelling the order of the walk. Take a partition left with
tasks and no CPU, under a parent with no CPU of its own. The parent can
also stay valid with tasks and no CPU. A later hotplug event can then
make it invalid. So v11 will take the topmost partition above that
child that has no CPU of its own. The offline will be refused if a
deadline task is in one of its cpusets. That can refuse an offline that
would be harmless. Three new cases will test it:
hotplug_first_sibling_refused (your first point),
hotplug_nested_partition_refused (your second) and
hotplug_isolated_child_refused (your fourth).

One hole stays. The check sees the deadline tasks present at the
offline. A deadline task can enter such a partition after an accepted
offline. A later hotplug event can then move it to another root domain
with no check for room. v11 will list it as a known limit.

> Can gone cascade upward across an unpopulated parent partition here and
> in cpuset_offline_moves_dl()?

Yes. But that climb refused a real move, by luck. A later hotplug
event can make cpuset invalidate the parent left valid with no CPU. In
v11, cpuset_offline_moves_dl() will climb on purpose, as above.
cpuset_cpus_allowed_without() will climb one level at most.

> Does dl_task_in_cpuset() match sugov kthreads in top_cpuset that do not
> hold root-domain deadline bandwidth?

Yes. In v11, it will skip a task whose bandwidth no root domain counts,
with a new dl_task_holds_bw(). It needs schedutil, so no case will test
it.

> Can deadline tasks in gone change root domain undetected when gone is an
> isolated partition and its parent p is a non-isolated partition?

Yes. The rule above refuses it. hotplug_isolated_child_refused will
test it.

> Does skipping a == lost when neither lost nor p is PRS_ISOLATED hold when
> lost has a valid child partition of its own?

The root domain of p does span lost's exclusive CPUs, not only its
effective ones. But the bandwidth that moves was all admitted on fewer
CPUs, so nothing is overcommitted. The child partitions of lost are
checked on their own. v11 will correct the comment and the message,
which said "the same CPUs".

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
