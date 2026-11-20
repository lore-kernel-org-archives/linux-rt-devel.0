Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203389;
	b=XOtjRBuejb36LgT01Bjs1l26pbJfV6MBuztj1c5YsV4krJrKBKDau64c+rYwLgGAseqP
	 AxgBPDbe3nBzLoR5O1TP8S7U4/T7yZelGO4Vrr3r67Ji1LrNcnRxBDVKAzIY2Aw1xbKtV
	 82W52kvT7QfZ+/pj8daSzfb3q+RlIsDqHLCjMF1HTf0047ogqfXgiqMpy40Hu/W6qfhYB
	 ShRbpSFXQll7s2CzTwZcJJ0LiNw58gsgvLf6dDv9MVEkxKAOzLQA3xv2XxEwk8GPP+DIp
	 JkGYamYX+9BcpjOEKOm22L9/fWwStu5rttATms5Q/v25pzYvIlfigHpyFN9QimogUhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203389;
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
	bh=k9PKnTZrhKTDzw6SghYEdOuydxnaY3+rzt9B8y07HDg=;
	b=OWfGmWo9DfKhC03zlPFqpJ1YLwWquTJV5IVaAixaehJP180UeyYJE48Br/h2DXxU9EzE
	 Bapr/rz1k8YHB14yMBFA8RfIBjHXIVw+6rt+ecWDsm2QAg8kEQ/Qg+uB7jQdtp7DyZ1n2
	 OoK/ViE/pCqXozq9A90mKeHH/F+lHAmrOO6r8Ep11wo1umZV18nrQQXR8xjCL0Rkqf+Ly
	 HTyVOHqtCoxayKmK4N6MH/zKxshM2U+PLHZ4n+spHRE5/pR3HhF49EkvTa3fgyUW3VjWA
	 Utj3RNVpKxmbVokdmz43wpuGMv/gxVLKhSAJodyO5/tW73tRWQtOdP4Yda/1+AvSYtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jTLmM3hE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.73
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020073.outbound.protection.outlook.com [52.101.191.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E259606A6D5;
	Fri, 20 Nov 2026 19:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E259606A6D5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jTLmM3hE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycCeds2gTrbcMh8oD2ga+2ZuLDDU/VJDql4KbbT9bhH2dO3DeZ6sVsaYnlha6tuooRtvWgmmHiGvJEQELNqN/cKi2RqxAp+WQWtd/BqARekafe/POfVaYwZqyNz4ilpoGB+IuGDJCqc3RObVLPIqNUUVnH9r1tyTzMGt5XUtKLqiJ9/bK+2Hv0IVWppWEhFTQwk5kEwmZPJMXVAzElhYzCeT3cLSOAKquL33VFkpIqRjUS1JvLjn6iFvViglqQ2DtIMv/OilMZlcXEs86zCEoGi9pM/UeqLY29sjrl3aEAu4UzaeuuIANeyGDt/xjihjy+QJ+pMlXlwIAvHETcl6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9PKnTZrhKTDzw6SghYEdOuydxnaY3+rzt9B8y07HDg=;
 b=hPwZ6DGArHhWgUkgxRaXM8nrv14h8LmQoNyrPNAB0VLrI7LHFQUFeMKXdq/8GqgMaWsFSIk6NkH0kQfAloRMOQTEqbfgyzXWtYrnf8Q8SQ9XIG0DuG45PBuyR6s9J2scwBrlVQlABmtJYGqQtIeky913XCyK/ce/KCfQ3yNb8dpYHdRakjUUrDobkAEe7hm78t0C+Vhap9dL2nQMefPB+5fNkk52F5A+HQCF5lU2RwtmHGTat+jeQuYfqzrbycqUjrBdFaRwZivrgk+enRC+WKez9i2vblzgiSqkG9d5ITASjD6AhIV7Bx07GNa62+I2MBmSaHDt6Gou6y/frqo0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9PKnTZrhKTDzw6SghYEdOuydxnaY3+rzt9B8y07HDg=;
 b=jTLmM3hEPSlHf1L1gJ6YUMkhd1isNRrlw8ZKeLm6P2BJODmwKnBbNn52Nlunf7y1px2yD7PwbFrzTcjEjbH2m82uEfZnamgVHUvKfGNnLC2bP9D+qr60e2No4kV5JaAdinB1HqD+38CGOV/Xfh1HvXZwk1kIeP0ymzWEh3PE1IFYaHZ0oUOMC7jKkjYMkOOtL1xFGfXcQ3EkkwK2ivh0oIp9cFt5KRm04KI3mz1geKAXN9WdAA5vv63Jm4E1jzaIJ7CugUhC5oOzDQcqL+32n7jykFEw6cEbQWyQIdYVhf2GERFdxMkZxjPO8moQPOHccKHlZ6DBr45BCYSwQaHRbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB5667.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:36:23 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:36:23 +0000
Message-ID: <ddad5873-116d-4acd-b7e0-1e2a39f4056d@efficios.com>
Date: Fri, 20 Nov 2026 14:36:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/33] sched/deadline: Keep a task in the root domain
 that counts its bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <26529637dd1398d1bce1398efa83d9b71802777f.1795181240.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-225338@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-225338@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::22) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a294d1-43c9-4187-c09f-08df473d8f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|4143699003|261026121527099003|56012099006|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	gZGWfqMiTw/d59n+FFYr7E4/zgQJCAmHxXtr77JXV1xl3rBTymKBnPT6XVBIbviCnE5A42NegaUUypuvvmL7ikVBIsbxhEjwCF+MWhbKRJsaGdvVNkViIh1OfGVa5O71n9khWebNIS+uFRydxFNDp3xoW3HQEbVlIQPL8raRL2sH2oguLcjBg0zf99kIdxRRYreHLWYr5Mu/B/WIc1YAnWo7Kl1T+zkXpTijkcZsgTWKQVgP+2v9iacYoHBPKLFwQuT56GgHN/fgOw35Z75OoWgBD/7L1QVatjG1Rsu43xayBwSN6uiyiMO/X6s+iwfojrrXmOtHS47YBwxxHsf8tqUNhgLCPSGTf2ieHft76VRv6q/GOARTZlny9k4vDYqU9AUZmpY4rTDHK3gJp8TIJcBFjnVoOQiKpJJSaHgiv5eqZM9piYMGLvx4PmEWzVc5cncViQXXpeUgpg+kc1pvnJnw1aTGefPaeqtCLyiSMl1BCxEL61C+NeMZ/thLI4mGCuNDYNLHQjtxADrQ5IwJUFL/WT9lc1YWjQQGLAEwZiR7N28jQzIsVfr40pURePRfYr5pXBBeTqsxogrNNIsNhGeWJ9mgsPbFNfvJdEUGMkM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(261026121527099003)(56012099006)(10067099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWdLNDdyZTRXUVZsQTgrdkVIWUFvTVFTTm54TThyYjNnUW8zcXJsZ3BRcXBI?=
 =?utf-8?B?U2pjN2pySWticGRPWHRYTnIzL1R2ZnUzT1hVdjRoWGtEeTJaSjBFQkQ5TkFR?=
 =?utf-8?B?RHJ6Q25xbUo5VHRCbWRmOXpON2tzYTdtWjI0Y25XU1pyaDJtaVNHSUNwYzJz?=
 =?utf-8?B?bDJmaklURGtKaDBDUzluVW9YWUluNnNqYVV4RUNwMmQ0YUNoU3p4UUErSW9o?=
 =?utf-8?B?M3pWaXgzc3pzMy8vNW5mSk5KbGMveW9xZXZ3QURUb1p4QWxoUE0rY3piOUcw?=
 =?utf-8?B?cWlsb3hzOUd1a0phNnpsemg5M21OejBNcVJxUFl1MlU2UithaUg0MDc1cjA3?=
 =?utf-8?B?UGVpMCtWNS80eVBhRDBPVlg3VFA1MlR5SW1IY0xrNHljNTlyT01EaDRpck03?=
 =?utf-8?B?b1ZGc0c0RVRrTkExTFh5UWwzT0JqdWRsQ3I2OGxPK2VvMksvYnZzR1YzVHor?=
 =?utf-8?B?ZnRlSG9yY2Nia1pHemtjUkM0b2V0WGF3SHJndDZYY2pyNGkrQ0hJL2ZGb3ds?=
 =?utf-8?B?U0g5ZXgrTVlBZzMxN3B3VU45MjdHRjFsQ3hLd2FRNWJOOTNKRk9jejJFWnZY?=
 =?utf-8?B?a2xmNkw3NmdCY2pXN0dTMkdlRGlsWlVJSVcxN2hyRUZOb01uSzRVRzRGMFRh?=
 =?utf-8?B?WmZuRkxPZm9aZ0VjZDJNblN3d3FBL1Q5VDhibWhENElVSlRxN3oyd0Y2dzBC?=
 =?utf-8?B?MXZZWFNxd1gxc1d4RytaSjkrN0N2ZkFuajJ2Qjg4ZTF0NEJpZHVzWUFuWjBP?=
 =?utf-8?B?R2NLNldyQnh0ejg1SEtFbVJROG9ZNVdLR1NjQTlSYkhsWDBYYTZrY09QUk1U?=
 =?utf-8?B?aDVzNk45NEw5dDBFVER4UzhxNEdBUFBYemRvOGxRaE9zbzBTbE9xZDNuUElE?=
 =?utf-8?B?SzJaRFlpTTdLc29VNjBTVFlUbkhhODErSE1YblJZdHZiMy9WMW84VXRaTWE4?=
 =?utf-8?B?bW4xWCtybUVDMkxCMThrMGFlOWNhNS9nZm9tREk0a0tFZEVZcStwOCswZ1ds?=
 =?utf-8?B?QXpnQTdha0RxNXdPdkM3SThVL3ZqdVVKYVd4MXJyRUtLckpBakVrNWFLUmZD?=
 =?utf-8?B?RUxyTjRIV21jdmc4L1hjVXIrcmdxcEhPRmlBWm9XQ2FvaFhENXI3Q3BuMFFD?=
 =?utf-8?B?S2E1ME9aVUpnR3l3ajU5OWhJRE83WWFDcmRjVWtkSzRtYTlHb0VkS0ZwTEdp?=
 =?utf-8?B?OURnRlJWb1F3MWtHN01tTml6VEt5d1dpN1Y0MURQeHJqL1FTTjNiZFpHbmdi?=
 =?utf-8?B?Vnh4aG50elYzZ3k3ekdjZHMvR2NXYjVmb1JWbVFYOGYwQU1xMVBldyt5UkJM?=
 =?utf-8?B?R29UMjhhQWlhMHM5QVVjb0NUOWRVMVp0eWZqU21qenZPc0tYNzZsWFlxb3c4?=
 =?utf-8?B?WkZaQzBXUElmL3ExZDBhbWtYakx4c1BJZUlWQnZEazkzYVEzZFYvaGdUZEZY?=
 =?utf-8?B?VTJYMGl4emc1ZVF4NmVFNlF0bUtsOVNpTVVlTi82VUJYRHA4Zy9CNjRERFBD?=
 =?utf-8?B?cnRmNmdVZU5qRVYxQ0puVWE4d1p1Y2tQYnFGOFptNEhqRW1IM3lKbWNvTTZi?=
 =?utf-8?B?eUVCS3kzWDhCNVRCWEllVmhZZ3ZBTzBCblhLR0IwTnRVSlVwTVBOdnhVaDVV?=
 =?utf-8?B?clJaaElCYUFmakVWNldnUUlyekZDSWMvS3FKdkZZakxSOUcwMmxseVB6ZXc4?=
 =?utf-8?B?SlhVdjRqUFpRZ2lNSGl6Y3ZmcXRaVUVGYWF6ODZ1OUhKS2E0THNWbzVROUZH?=
 =?utf-8?B?MkJ3eE93TGdEQWY1b1MyNXhFTUN2S1YranBFaUZZcEloaDY3TXg2eGNRVnR1?=
 =?utf-8?B?WXJJNU9kQXdJRFhvYUZuYTFWWWxYeCtnTk1pR3krQU9pWmJMUFNJWFp4UURE?=
 =?utf-8?B?NjBGV2gzWkJUVFc4U1VzZFRYZzNBMGVKTHNGNUQ5b01QeGdyamRBNitad1h0?=
 =?utf-8?B?b0cvQlY5MFd5K3dha3NwMmwzS0RWOEJhaDIvdEVGZFFJcEpRRjUyMkVxZlhy?=
 =?utf-8?B?V1QySzJja3d5ZFJFNUQ3QWxMNGgzNVNEdS8yblRpR2lmS0s5c0RlckovYzkz?=
 =?utf-8?B?VWpWZ3RlcXpTY1pYdlQzNE11cHcvTlBnWTF2c1VqK0FUMjVocE9NYXFSY242?=
 =?utf-8?B?Q1NraFFBOTBFOUtpSngyWkpVQ2h3SjhDSVdFc0pxbkRQV3ZhOTVqRWFmaGQ0?=
 =?utf-8?B?U1p1NDVtbGtSUVdJWnAxU3JTUkdvbjRtOHBYTlBQNFphc3RVQkVzeEtCVXVt?=
 =?utf-8?B?ZjI2VUVmZUtmZGQ1QnQvVUppaXlZbjFHcGM4NkFaMjExRzZWQWxlMk44MGpp?=
 =?utf-8?B?a2J1aDVlSnZaYUI3Qk5mNitQRVovR0tRcGRXZEFJdTZjREY1V2x6UlBqMlVq?=
 =?utf-8?Q?F+sfidDwo28Lkyfq7SO6fpfLlryrADz/AB1Iy?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a294d1-43c9-4187-c09f-08df473d8f12
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:36:23.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wlvxML4OGUaxWvNbFvR2MgZC59NRw3akO/Af1SqmrMHd5l8MTejU08LUvX9mW7J+6QXIHyEWS9zk01pzZ0syuxWHUWpe0IgtTOD4JoT2cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5667

> Should dl_task_offline_migration() also fall back to an active CPU in span
> when p->cpus_ptr has no active CPUs left?

Yes. This is the follow-up that the v9 cover letter lists. v10 will do
it in this patch. When no CPU of the mask is active,
dl_task_offline_migration() will take an active CPU of the span before
the WARN. The task then runs there until cpuset gives it a new mask.

No case will test it. It needs the replenishment timer to fire between
the CPU going inactive and the cpuset update. User space cannot drive
that.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
