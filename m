Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442485;
	b=zlRJyEetUCFkPcNw3XgzEFBWPrAHezDNFm7feRXhYwEvP9g7xbzkmmKQ5f9CWuu2rm2I
	 HInMrMc+LCW0fGpc8bjljOym32BHaasAahUA1UEHFnSP2wjtjXOWPWcdB8QV1OWXklZat
	 iUvd4Ox3L8r6/eEkiGSjYWh8uJK4Yq1cBO3Thpmlatq1auxtw1h4hyD4WsO7CRWThKu6T
	 nwMy/EZYAjbP9MOV7HPfzLf5fN06vvQuxHVj5D9b1v8mLBFcVRDQRIvw5PdltQAUhuRi6
	 9gRzTzTc/BIoI7vHPJ4Wka4KuUIf8JETgWa7B8/0Eoxl05EHV9s6r6/8gjKOdqNJAJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442485;
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
	bh=YsqNmmlmlDaj5EDfVN+Ye/0GnTVKriU5lb5NSQDXPus=;
	b=sL1xxI//ftW8ljiDf+UPbHdKl/zxpzwMMSEW7CIzcyn8ZYyEt+Eagk5RuPfgP6rYtDPf
	 bGOAL7JYhb73S+40iWjDuuZN44I15hJM+MdvSU/xHqooxB/0F4JxaT3SJVtfCv6fX0iYC
	 zy2YZ4nLYvVVYekeGN65CmlbFJ7UOgWntMfmN9IOKRq7HSt8HotJgsEZfKiZbEOauw5y4
	 JFLEusdWgt3uIqU9X0XE1EkElc3Pci7kcuJGvx3jDLa5OEAAcD9e3mbz7WBGTJ81Tkj9j
	 +CygfEMIxCTPUxhw0CUe2C2WXYL9UXzLXPdYgJvNreMakFcPRL5vzmBaTNXrf/6hOOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Bs0xGzrq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.128
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022128.outbound.protection.outlook.com [40.107.193.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E378606A31E;
	Mon, 23 Nov 2026 14:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E378606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Bs0xGzrq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqDsnLeKvSMzSAHrGxelp48OOzEMiw8hkgZI9iHroaqz8/OBBJoWrjfp5Mou/cOJ4X0e+XXNfkyD5Kjbe3cMsfmNXH1q0L5JsrXQs09f6XzUcf9SFO38YtNM9x/xZAWieidmIusZ/pDM/dQ8RdwNvNvN6nBPYGDJ23UiVFIjgXz3lbZrdz/9vTmORyglDcqKr/QM3nfxvIodskyVWs5pZ9oUz0iqWRi4B3xtovwVIEz4ZW2mD0pGROMR7sIZqtFPVBA3U/s2wrBjoxF0RXqJsHOYoOSrUzaLkdkNNDl+YZFtU5FwKhEeJ9XskBjAd4OtYtmzMud3vmmeKE05/OzTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsqNmmlmlDaj5EDfVN+Ye/0GnTVKriU5lb5NSQDXPus=;
 b=B2+RU3tudA4jLrGsL/60XFXe+qgoL4MnIxPnjgB/bpAqR2zFv9HF55bmhNGd3mLC+xlv3Y5HUQEM8JOIfQDliYLDP5joXRCAJtDxztPN8h+jdYx0YiX3ol5Oc7T2t/dfKOrhI2FtlJHmtt4NWoRsT4Kb/hCzzkSn8GnzFUv7/E0tTvIh+f2RLwrNDuwHYlEhhr0KNClJcKobxB/Q62NUMtVLvY5mUK6abj0skBCoK9f+lflmzgXzSTAb+gB1LhPZ+Ub8WsgWILpP8D4weGIKmcGO/XmTAwtTMMVgB5gMIFk6yrhWG1iyxk4lMjFpyG7vVNmmpZ5w1hwIQLWYM56IOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsqNmmlmlDaj5EDfVN+Ye/0GnTVKriU5lb5NSQDXPus=;
 b=Bs0xGzrqS2CS3bmkXK6ni4fGgZwrgK3x7N9M5om1Non6RLKt/Y6NJ73PHD5Q3MNLxikDccHIFwLyiwn+mW4LBCjSvNnskNiOULboKEDCBadjyWOa6SCmPNZnYdfNeVH8UeXvje4vvTGaXoO7QM5XsCK1GYJXm3SPqtTmQwPQKFxpjWvFsp5RdxiqzUu1GzuP7bW6JE04IkZoCpeDoibf5B91/4m2ajcUGK+qJVBx98YWxqWB+bm28hxcvigmolWVegiOmp7xSkOThrD+c+oMEAk8fXj+/znNCBeXyfhsJmme2DwR06Arvu0JvhJ9pIKhmB5FQECBUV3KoOLG+OpwAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQYPR01MB11558.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:a6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 14:01:23 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 14:01:22 +0000
Message-ID: <44f56c69-3280-4291-bad8-32280051d9a9@efficios.com>
Date: Mon, 23 Nov 2026 09:01:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 35/40] sched/deadline: Check the runtime of a task
 whose parameters change
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <f0f5e657ac6bccc75297da3739df812adda360b2.1795207233.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226204@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-226204@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::33) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQYPR01MB11558:EE_
X-MS-Office365-Filtering-Correlation-Id: edf654f1-546e-4714-aec4-08df496a41b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|3023799007|261022105027099003|261026140227099003|261026121527099003|261028144727099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Lp/mYEnLZfysfmgAZ9z1r3muVqHElRBdL/2sdSFXh5I0t3nIxmsbTTyOGTJhRmpL5PnGbhe18chkX9z57npkskihL5+/41nIicD3p7PA37RZEaK5Sqaybrl7dGXWNp3Mkvo4rIM4F0nfBYlJu67iBxT7vtFr9y2CpilL8L1gs72DrdQGXmWohyOQOnwj0YhstEqP4vY2V7D7aqpcBxCIF+wlUE6zyvCVbCNdcVggdzrlPXgJIc75o4zIOYssSdDnkYGr/8hOVW9TxRGO5BPpMFBwc7VKMXFhZOprV6iruB4zdgLl7j5V0ZC1Thjn1BF2UKz7v0YdXCgA/73ifSsn25LjfbzcwfSnFjNoyK7py/H8TQu0GaBUVCDblWr/eG7gSN9WvaGms/+E18wSBEAG5mfCmZV2i+Ib0WNg+PrszNn2xkmZb6EKimJsE4E7BTst8oa29RbbxP/uWOwev5UnIv3g9NO72o/3LIWvWiwwafJj9AbrSdIkA0jY/ktfJwhtFJele6va3+DwmeUHxGWrHBHF1WK1hfQsuwlev5SVk8OEohpem0nJwE868wHjSF0pCRMntvzdwrsvxkjKjKScTszUpYTU7vY4t8ICTb/aqOA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME85M2luZUlYaXppMituSzU4ZGxpeU0vUjYwSzArekVvVGtPR2JhUngrRnZR?=
 =?utf-8?B?UzNPZVpiaHhYNmtSQjRuUDlBa0c0dGoyc0t0UVpYM045MzNmNlBPeUdRUXJP?=
 =?utf-8?B?SE5aMXZhZW90RnNCT3hZbkQrSG42aGYyN0pEbGZNdEtvVVNia1VoL29GaTNJ?=
 =?utf-8?B?RDg4ZnFER3JDMWRuWkcxSnIxeEZGbFRIZUErSmhoMnFsMGtLQkxnZjFvN0lK?=
 =?utf-8?B?bXV3MDJwVGxQdld5dU5QTVBwOUhvZVE1ajJnQWpRU0Z3SndGdTBxYm1QSnlw?=
 =?utf-8?B?Sk0rZHZMSCtiWWNxbGJpN01FOEIxU1FvRmFxeHFXQndsU1g0dUZYejVmMXpo?=
 =?utf-8?B?anduZ3lySFV3cjRucDl2WTRSRnR1TC9JTnpaaE41MjdtSkF0QldOUFA1Zm1N?=
 =?utf-8?B?WmNpTE9ZL01SU1BqbXVLRU5wVFJ4Q25mb1FBMGRMSmZGV0x3bktSZDZGdGQ4?=
 =?utf-8?B?M3BIS0RzdUl3UEd0aDhxMjJyQUtGSElEZ1A1dFlITzBHNC9uek1hK0VpRkdx?=
 =?utf-8?B?VmNnbmcvSEJDMW90bzNvZ29Qdkx4NC9VQkJNbjltNGtFS0w2cmQ4THJXTlFB?=
 =?utf-8?B?NEtDYi9KbXpuQkpqbXlxYmlzaitZSXM1aXJ3Q2xQZmJxSnJCZExFQ09mUldq?=
 =?utf-8?B?bFpwWUhFcHVwSVUzaXJObEduS2lIV0hPN1NLK3RoYUNFRldQUmRyNGN5T2pO?=
 =?utf-8?B?VnRkOFdvejNad0x3MXJRS3pVS3Uwb2IrUThLdHhJbGhUQWtXSUlvMjJlNVhh?=
 =?utf-8?B?UXdFV3dUR0tJdDM5aGdXSFdLRDJRUFNJV3J3TUVKMi91WVJKTXVRaFNBa1RI?=
 =?utf-8?B?UWxPRngrVUc2ZjQxYnBydFQwNCtac2Z0bmMrUy9hRWxUR3RsNEVzMk5WaGti?=
 =?utf-8?B?MWp4Z0g2MTRuZ3dRMTNua0FxMDlEMzh5QTE0VVhTdnFtQmZMVU9sTjAvUEh0?=
 =?utf-8?B?b3QrcjZKUnRFeVJ3Z2hFVVJnTlhHcVZySjR5ZWt6TkZxdUlxL3J4dDNEUm12?=
 =?utf-8?B?dG9tV0did3d2dWJqa0o5UGV0N3hoZXhiOGRtaG5xOHVVYzlYOElrbjJCWW1W?=
 =?utf-8?B?eVFGODl5RGNYUGlCYjJTMDRia1JoL3FRUWJuWkxBRnhWa2x4S3Fhd3loa2FV?=
 =?utf-8?B?YzRKYjhNU3ZscHFqT0hWSHpCcjFlcUx1MXoyT2QwRVMyZmwyYllSeTlRTHdR?=
 =?utf-8?B?MUVFaFEzcUw1Vm5TcXgwOHNGanpxc042N1RkQ3M5YUwzc0xtdXY0VkQvNUJO?=
 =?utf-8?B?dDVYb0s1QTN3Q3JsYXdFTUJqaW1weTRHUGdQSHI5UkJFa2dxNDB1bmM3TmNy?=
 =?utf-8?B?amt3aE5rWFJhUDhZS2lqajhKRGZEZE5LckVRTFU3TkJ4Y2p5VHBLMmJEM0du?=
 =?utf-8?B?aExVbTR6a1ZZYTFzdm4za0pINkpoSnhRTHI2a0tXYnhQNTVvV1dXaHNJaSts?=
 =?utf-8?B?Vlh0SkhsUzJMM0FONWxIOFI1NDB3Y0JlQ3lacmNQVlNhbkxSQXFBMUpSdnNa?=
 =?utf-8?B?OXEzTm4rTzlWNW9COXhGa2ZxcW1tRTNVSXN3OHFWejhEWHFLc05abnI4YzE5?=
 =?utf-8?B?S0M0ZUlReERzRmttYW1nU01LS2VSUERmVHI5VXNGZVc2VGdJU2hPT2xzU2ZD?=
 =?utf-8?B?U1VZSVljMlova2YxNVpGNWF5ME5yU09vZ0ZneUFQR0xNZGlyODNiL1lzOW9R?=
 =?utf-8?B?am1NLzZKRUF6Wjg2QVUvNUl2MWhmc2JNN0hqdWpZRkRITU81VE1YL3liN2tU?=
 =?utf-8?B?MVFuUXo3RjVwblZnVnVoZlNNRmJwc1Nrazdvd2d3cUFFbW5mMEl1aTJyMUdj?=
 =?utf-8?B?UTNZam94RVkzQzNsUTY3dVFkaHNOOGcvQVo4azlYYmNlUGlpc3g2YUZSbkpY?=
 =?utf-8?B?MXVyZU8wbXdCSm5TQUNZSVFIS1J6bERia24rcTBGb2hTejBGa04rYUZrTnMw?=
 =?utf-8?B?MUM5QTN2RW1sVTBqNWc1VDA5aXcwNTluaFNOSmZvRWZUUG0zY0Q5bVdYR3BH?=
 =?utf-8?B?eHZsT2lLVUdDREpxcCtrblJrYVRBZG9LRTZjQ2FkNThCcVpucFJBOHBPTm4x?=
 =?utf-8?B?SC9QSUdGSFZHK2FhZ0hOaEJrRXgxTktiNzh4dVd5WDR3Rjh5NThZSVpwRGcx?=
 =?utf-8?B?L2lkYkUxblBTQ2VjTC9Vc2RTV3BxbUFNMnJwSmJEVitMK05aTHRxazBDdW45?=
 =?utf-8?B?cGI2WTdQN2FOai82SVlSVnJMcFR2eFppYXp0Z2tMK2FEM1hZcm9FWWxNQWI0?=
 =?utf-8?B?QXJTQmtGbEUydE5nSm1OeXcxaDk4QlBKeCtSdlczbEFEOHo3YVQxVmZ5QWtk?=
 =?utf-8?B?eXdWSUIyTmNCVFMzdGtmZWFRN2d3RGJCS0h4MkpSMUZuU1kxN3VxYjVEQ2ow?=
 =?utf-8?Q?6lAFFBJLED5TbdywAD3yWaBwfafunOcrAS7mx?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf654f1-546e-4714-aec4-08df496a41b6
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:01:22.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SChxiJpLPbn3LQc8OmKG0LedLkrQPrWaqiiZ+pZOQOW8eKXP5TQKSruqGkfrVnN6mxB9P6lu8512kudnL6c+x+IBzUKWtGXzXBgVBoMjq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQYPR01MB11558

> Should dl_proxy_block() also check and clear dl_se->dl_new_params?

Yes. In v11, dl_proxy_block() will clear the mark and check the runtime
left, with update_dl_entity().

> Can __setparam_dl() leave dl_se->dl_new_params unset when a task leaves
> SCHED_DEADLINE before its 0-lag time and later re-enters the class with
> the same parameters?

Yes, by reading. In v11, a task that enters the deadline policy will get
the mark, even with the same parameters.

> What happens if p owns an rt_mutex with a deadline waiter whose deadline
> was later than p's old deadline, and shrinking p's reservation pushes
> p->dl.deadline past that waiter's deadline?

p is not boosted. A boost never gives the owner the deadline of its
waiter. It stops the throttle, and the refills use the donor's
parameters. v7.4-rc2 does the same. v11 will not change this.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
