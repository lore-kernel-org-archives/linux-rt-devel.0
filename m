Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.142
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182646;
	b=hiyUe0bcD5wUTNdcPurlIdoxQO89Zpw+xhsxSxUH1q2zMHKhMN6rWXqQuGSTDARBc3dJ
	 mCk4oSnQ0v68Kwm9YmAbDmvVYW4yQ7rgau7qBwT7VOzHIA/KCUnfOTVkxcTjVUv0Zs9yU
	 EdmKPYmWzAhs3pDbBQFg1YFHHcdrqW2a5/qBzrVPPEvsAoPpmte3YucN7zU7VLWl2Tfs3
	 jH7hZ7FJUVDXP7Uue09LgfSFcJsD71rzzuERZrPY3H+ZT8yiaPyPPMN3Z755kplsLdkOl
	 NmesUy8j/2OM/j6wCHKGUh5+Hjt4839zbT4Eli8wvVSXJLPOUid+zugnKibHfNAExFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182646;
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
	bh=JCrN5ufZgtAIjrJ7yv/2rK85BGx5KcfIn+G3Sc5lTsk=;
	b=OlN5HvgZZGJN6OJAQVBKE/wrQ9h3chgvc8Pxt1QpF8XDh0R08gPLjMazWgD1vDOUPqdC
	 cH/rcns8kIVS2IdSWOYi52vjbt+Ws19lVocF3NvbbEjNkYzYpX7UAsWUThz3tpXTsTPh5
	 R8T9dgiI8D2Rkb04TeUcCU3Wk+C/iTyrP5qPvPMC7uFg76utJV6UIgSgvjUwRqAUHskWl
	 0KbduEk3QOMOCECb+kkvEDCa/j53G+kNGLW1PUcDDPJM0nCtLC6B4vXH6iYPI9jvn3/PI
	 1W4W2V9eKfOa4wLtvQybvTG5LgMxSTw14xdbh0BDXg0VC5Joy+ZM8Vb/i08Y9CJdWEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=sSbtGPan;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.142
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022142.outbound.protection.outlook.com [40.107.193.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2087606A32A;
	Fri, 20 Nov 2026 13:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2087606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=sSbtGPan
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvi54ctztT/Q/wy86/L3k40fJwslCheUvNZ/doU6XKaZhWwDpGylZUW5/FIF0aTpwovx2W7QSkUFKYlzKdGVHWtJdeZkDnb0RSTyVVkiJw4u0T1gcs9f1U5zhMzf2IU0amySYxT+yQaBcvL1vAWsscx01b0rPX4HR+HFAGudYv4l7ORk1m8FySGx8dN976YzmJ1nn9zSNoXazAq4SbXoVVTgHS1LjtDjswdnTXMUBVLvo2JTyQrqACQMkJnNgV3Dt1xtotxorFLoid9hp5o8WzTssFVMpX29KCL9yaZR0cnxDDq8StYaWTT3wb8+vik1B9sfIgdcFeHKqy09Ezk+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCrN5ufZgtAIjrJ7yv/2rK85BGx5KcfIn+G3Sc5lTsk=;
 b=ta1lfUtpZcC2ReeqcBT+B4ExJ0f/bzhpb0XthpgcX4TdZLZlCVjjxWLp/IVcYC4ffTBwI/OZxKxVlzzvqOrZ3kwGk/UkrFPWpB6dxI3iU17urPe2BEqx+atwYUtQiwZqApnuE9ceZlpkPh2aYE391/H4DUyVYoeUp4ZZ8bK6C98flCttWbD67vpKfe1GX6BRUxRAgYMn4zZV6BptFA6QWW2W2zepsBmSkgJ3xq+w95be+BvEY0W09lRa9MxItDtz6p4ixxOL+QXinXuMdcEKpQvfOdwaFRywBoV0m8pMmkMhJ2hgrhgqRkw7HTNGwQoRO2jW+mJDvnPZskDue5kmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCrN5ufZgtAIjrJ7yv/2rK85BGx5KcfIn+G3Sc5lTsk=;
 b=sSbtGPanjL/t5m149yr7pBt8lPPIimmAnTI73xGQ7gJqMQuQtYQARcTKcZs35hD2KeqaM3izAWmt5HDz1wke/6UYIfngboSzz2HNW4An1DhrNsvK2tz04ifcD8vCHIzvQTmn1dOHjLjn/MwEfcbHp79uP4s4/IK9ziS3WjEaNj5HURtK+76vOGnA8hFnATToNa71OUi0HhNI6wLW0dtTL9qc8Bok/JILEWwSqoSbnzkS8R+5D9YO1QI8osNcQMWiWJ0Yyq0cYeQVgKc+TWmfpi7CgAuk1B+hiTDeBJnIXkK7LQKU8uh92YzC/cJZxYnxNBGUNoAkicfx0BVylPZjow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB165033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:200::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:50:43 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 13:50:43 +0000
Message-ID: <fc1dfc96-8c56-4cf2-add7-910b1071ae69@efficios.com>
Date: Fri, 20 Nov 2026 08:50:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/33] sched/deadline: Keep a task in the root domain
 that counts its bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <35ed0190c119025d684ab89cd51e4805c7f7dbad.1795116791.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-224072@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-224072@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::6) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB165033:EE_
X-MS-Office365-Filtering-Correlation-Id: f3467b65-7cb5-464e-d0bf-08df470d4542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|261021121427099003|261022075727099003|261102123227099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	maX/0LY4hUP5sGdpW9b2f386A5uFSEH4t/3ogLta8jVcJ8cnXjJS4udfTv4pVKIbuvNQZNzJMu2YnSBiDKryKBvqZohfkNtR1JJVajXfL8WdGhK6hN+r5Gtaab71aPQF5pbTu9UfoHqwUpRBGkUUrnIVYGHgQeUxRZluujPnQuZdYJb5ouqQQpATCMePsmSWjBjGKVVB9zyDw7ZLUiUbloWX+gHTF7ww14Y4MBcU2PwOTJ3wWm9J7WnaI7Oox8+98kYaDBmRDs/MccBvspGsphxpWhaBQCTuNNDs4/Yb+UFc6E6C0s+ercwkIaugbaCI9HCxWXvsUbmmvnKiagqVsT0ByUbt5P6NRki5GL/xkleyqxz+tsereEnCd1K1YlTPMKfhXyD/avwzYR9xz8bGHy3UOqSnLCPDlz1C6yuOd/cLwmOXKXGW+zb/H7d66++2Kz3nP5MF51eWy0x2oUF48ZN1LSY4LrVbO/zewnWD+zlUGM3rG/4FRsZsfi29k4uMGfb5vS0ePwnx9+SpsggKctXuDVz6DbTVXDtT+C0QqOQ3pEsYQ1l5YzA8Msm7q4MDrq72qJ+b3AunEDwv7C8HOn3d/UvqTBLf5oPTsIsJ7i0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(261021121427099003)(261022075727099003)(261102123227099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXBoYmVIeXU3aTlaSGlVR0VjNEZsV3pFd2dDaDlranBFUFJ5Ry9VV010eTVr?=
 =?utf-8?B?SFAwNmg0WnJDa3M5V3dJRERQRHhwRU16MEhrN25NS0FlaDd4L0htaXc5Uk00?=
 =?utf-8?B?Yi9Vc2VvYWo1T29pUjZmU24xOUVLUzVtL2prTllNSEIyNHpMemFKM1QzMmo2?=
 =?utf-8?B?U2JtQ1lGczFvQVc0R0ZSdTFCRjkyK2xEUW5OeUtxM0hMdVdkdmU3cllIN2lH?=
 =?utf-8?B?WkVSN2N6N0RWM2sweUZLRFB0SkEwcGtGSmExTEpIdTFsTkhCRFQxc2RuWFJr?=
 =?utf-8?B?cEVBeUNHR3pvekJJNCtQUFZPVVp0WmpSem9CMS9Kd002YlAzTlRNUWJFZ0lm?=
 =?utf-8?B?UlNqLzNwaHNKbC9SdGVQaERzdk1oOVFoM21CZzRUWXNXY0gvL21YMUZwRlYv?=
 =?utf-8?B?cHpSZW1UNjhrMjZEalZXek9uZlpzWmZhaUVQalA5MzY1aEllK3h5NUxRL0NU?=
 =?utf-8?B?UTU4OWJvc1MzRnRwdTRvc2owRy9IMTFsS2VsWjFWeGdSMDZEMW5JbS85N2VX?=
 =?utf-8?B?MHYwbTlma2M2YlpNRkNZRWtIY3pTYUJqVUJ6RGZ3d3REaWFJanlQS1NvSzFX?=
 =?utf-8?B?VTNveGRDRGhaeHNSNWwxMUdJODlHRG1Rak5RTHBpQVFuSExTMGpybFdHNXdi?=
 =?utf-8?B?YnEya3ZTQXlKVEFQR29lcmhpQ0dFTi9sSE8wYXdPazN3WFBNcE9KZXNLSXpo?=
 =?utf-8?B?YStPSEFpUFM1MnBUSVJhbVE2MkNQYU9oREhyWjEyNWJNNGM4QWZ1UkF1V2Fl?=
 =?utf-8?B?SHMybzJ2U1FNTCtEcit3dmRaTlArcEJ2cEQ3bTRDZkh0OTVFVUxtR21LSEFh?=
 =?utf-8?B?clV6akp4bzBjYVY2bzhzcUpqSzVaNGtsdG0yTWxQclBJTDFmbjRqWXdqSS9h?=
 =?utf-8?B?OWpyV1hVUzZjOVV4TnVPcHhKNys0UTR0VnY1YnZLNm9ha2puWWhIc3hmakVI?=
 =?utf-8?B?MTR2dzhscFhCcE1id2ttSHFlK0xkTW1ETWgrSFYrbE9OUTIwMGE3K1h6eklT?=
 =?utf-8?B?UEI2WHpFNnRCckg3UGlKd0lFYWhkVVFkSDdmR2FBMmo2aGhydjJQaElSQmZI?=
 =?utf-8?B?UUt0SVN3OFdXSk9uZzVTZlM4VTNaZTBxazJKRmdVb2VRemRLSzFvd2dCWENR?=
 =?utf-8?B?WTRYREl0WkZPTVB6SGFPZnJMaUk3ZHNVaFlLcXI0dkJHUHB6VElHaXpGNkhy?=
 =?utf-8?B?MVNYbkV1bFZNd2xmR2swTGZWcHBCUDgwQ0ptMkgxTmNMT2dWOU5KaVh3RTJV?=
 =?utf-8?B?Um9FbzFIVWlMVmxPZGxkaVY4Mjk2QXB3Q1NXNGpUNUczTEk4ZTc2TE5kR0Vk?=
 =?utf-8?B?MENEelRDWGIrMU9BaUQrSU5lS2ppWkRMUE91dXZkL2RsZjRQblFiaVhaZnVY?=
 =?utf-8?B?T3FIZThEVk53NzFrcFRKeEZxdXIwNDlXaXkyVVJtT0VNS1NGdndwRUhXK2FZ?=
 =?utf-8?B?ajFLZ3pCZzBtUG1lVHIzR0tRdytsMkEvV1N1V1d1cjk4bHVBMldKWTZ4SDNv?=
 =?utf-8?B?WGxQRkNRamdqR1hWaDZ5dEtKMUJ4SCtDYTl5eVdWWWZmWmpSMFc0ZjdGYXVY?=
 =?utf-8?B?Z0xUdDJmckRIeTF2azNkblBmaVcxOUxXLyszMTA2RW1qNEFNbUxhb3NqcHJr?=
 =?utf-8?B?ZXFZSTlEWHM5V1NLTnVLWnNjRGNxS1BVVVJZL1duTlF4WExoVUlPWjFucjdt?=
 =?utf-8?B?YjYzNFlsU3g4eEhWNjhseGtXZ293QUthcEppQVRqd1RWaVpaSXk3SHNwOXlv?=
 =?utf-8?B?bldxRndIay9ITHJUSG9mY05LRDBVVW1aUW9Tek5DV3lDcUxBQm5vajM1VG5I?=
 =?utf-8?B?M2dsa0cvYWNJdEtqMlVqU215WHRqWmNjaktmK25sdnlFaWV6ZnJMcnFIanov?=
 =?utf-8?B?V0wxc2lHNWcxTlVQN0t3OFZObm1ZZWx3SWJpZUtXeEJsS09rVWE3Y2lGaEN5?=
 =?utf-8?B?TFFXaGFMTHRiK0JlMytsd1M1Y3FqQ0JXbWJ1bC80T1hRTHlqa1lYNnFCMDJP?=
 =?utf-8?B?L2FKOVpqK3RlK2NqYXdWcDVHaVk1SlNrbmgrRjFQbHZsOWZicVVyNC8wVllJ?=
 =?utf-8?B?TUphR3REb3RrNXhVU1U1SE5uaWRzUVhRYzFEajNpVUZyajA0MWxTU3ZkcVVK?=
 =?utf-8?B?WmhOQ0NoR2xsSWJ5M2R3blpJYXNFdkVUMzZlRlNodTFITlZCbjVnQkNqc2Ro?=
 =?utf-8?B?eTZCamVKT21PdjNzWWVrR2tubWtoWDFPOGxkWVBjS0VoeVpVMGNHaWVnaGJo?=
 =?utf-8?B?TVFPWjlsQXV2enlTSFBLdXRtUFg2L0tya3hXcFdRRGhqdzBBa1BqS1d2am9z?=
 =?utf-8?B?WU9xSzIySVpGdWQ0Q1JCYzJmMGFOUXZsMWlhbjg3cThlSTlEYkJwSFVNWUVn?=
 =?utf-8?Q?51rANphu4GCfMUfl9vsMdaSaGdQntfYHG+Kl5?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3467b65-7cb5-464e-d0bf-08df470d4542
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:50:43.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUU1WEwEwMrXclUQeDDWpN+8CnG1KTXQk8yoNztWUFVosIblSKJQvZUEav67UBD3VXn7pFJM9jg588RG6ekCeS9TVdTy7vXNn1R15X1ct08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB165033

> Can this overwrite task_cpu_fallback_mask(p) with span when state is
> already fail, and hit BUG() without ever scanning the fallback mask?

Yes, by reading. It needs cgroup v1 or no cpusets, and a deadline
kthread whose span has no usable active CPU. In v9, case fail will drop
the span and try the fallback mask once more before BUG().

> What happens here when p->cpus_ptr has no active CPUs left, but span
> still does?

The WARN and the pick of any active CPU come from v7.4-rc2. This series
does not change them. I would rather fix this in a follow-up: try an
active CPU of the span before the WARN.

> Can breaking out on dl_bw_move_blocked(p) leave p's bandwidth uncounted
> after a rebuild?

Yes, by reading. It needs the fallback of your previous point, during a
rebuild. v9 will fix it in two places:
- The stamp that v9 will add to patch 14 marks a task that the walk
  leaves out. dl_bw_move_blocked() will not block a stamped task. 
- dl_task_rebuild_cpu() will also take the CPU of a task queued outside
  its mask, not only the CPU recorded.

> Are the sequence-counter memory barriers complete between
> dl_task_bw_span() and dl_clear_root_domains()?

No. x86 is not affected. v9 will read the counter with
smp_load_acquire(), end the rebuild with smp_store_release(), and read
rq->rd with READ_ONCE().

> Does this return NULL when an offlining CPU belongs to def_root_domain
> through runtime cpuset isolation rather than boot-time isolcpus=domain?

Yes. HK_TYPE_DOMAIN_BOOT does not know the CPUs of an isolated
partition. Patch 16 got a finding with the same cause. v9 will record
with each task whether def_root_domain counts its bandwidth, in a new
field, dl_bw_def. dl_task_bw_span() and the rebuild will use it instead
of the boot mask.

> Is it safe for callers to read the live rd->span cpumask returned here
> when they only hold p->pi_lock?

Not for select_fallback_rq(). v9 will add dl_task_bw_span_copy(). It
copies the span into a per-CPU mask, inside the window of the counter.
select_fallback_rq() will install that copy. The other callers only test
bits of the span. A rebuild that starts after the check can change such
a bit. The task can then be placed once on a CPU of the wrong root
domain. The walk after the rebuild still counts its bandwidth on the
side recorded with it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
