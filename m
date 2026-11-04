Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793807576;
	b=rlaGXih2OcNTasK4DGBiwl14IYFviA+I77mvpMD1ELdV3vGvKioHzMov1U5qNGlDXZzD
	 aaumd1WhYbLobWSaEHUws9yh6yK4j6WIoqawi+3hugtr5gpFvm4NGPe5wiCuECBBgx/lH
	 DrWkzQFTaL/SQLWDFGXLfQX4K68M5oEkle7m4FJFMbIm5PChW5e/+HtIl52UBbl6cxA0g
	 nTJeRmtd1J58kgrTUIGLHVoczCwHdWVavUaM1ne/JMPK+t/633OYQmD1ZqEmrFVmD+tqC
	 w70jQP4+NQYcQDdvLONLNpLwbHT4K/T3wvuNrElvdpwg/bbFHTpw2PpWYZQkckqB3/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807576;
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
	bh=ijuyXKd32Xx9ycQ6BG6SnY8WquJ2qX6Gh2bEPvbGbA4=;
	b=bK1Fxfq7JJn4j98HQ9RW9ELqRu0MLuO70VYCVd47bG1XWvLtzdxohg7SGIl9BrpllE40
	 CyFOvxX+yCguqsWAydm7Zb+D1VQl4hLq10dhwuMDArFbwtrOuG+QE/ABWx9+QKiV6Kr/2
	 IWG3zSqp7Anp6/gm/E7xwrUrpcQOaLwfOiYWE/je7iMOg94uKYcBNLQjUIq9+rlkg3+Ua
	 FifTBInqwgSHfNSW1xmt+XfhXM/y+UL9au6yNTF4OsXLHBIxW+OhjhJj0hyizl92VC7TH
	 IEiVacSlo0N61z1/YhrgIj82U/yY4i18z8rNI2rYNPJlXUK2lJF/WMLpyh5qieQDXdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=TmMIMy4r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.97
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020097.outbound.protection.outlook.com [52.101.191.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA46606A32E;
	Wed,  4 Nov 2026 15:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA46606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=TmMIMy4r
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNUrIeTnoXwcmy5XGwPMze4uTbj67F118Q7SITTTWopEtJcA2lHrKWLGaVmk4lOe5xL9xOllj9a++JQ9DJu6uVJ6oCY1EmRJeV+DXUiwbmAn86nMsklSiSKorfGXk/53QD4wQqYVVi/6ohEZAO0jCwkXQHPfPGp181d+BVfPAo2aor3pUV183Wc8nitYKZ3huvsM+0CBzQXcKN4htSVBY5lklEey/z/0bwn+SZSxcGEk4vY+TcXaGEPnT+PmqJN1vpx+VFOQ4jPKWeUTiD/oCO2DPPdibV+ADolaQiQ4xPixcQlbhTpX7IcEiLKkPb/SGEAFF4MWSQQNoHLINObjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijuyXKd32Xx9ycQ6BG6SnY8WquJ2qX6Gh2bEPvbGbA4=;
 b=mn/YYF0Q32Cf4sSUZaTPMTI60Tq+mgEu8dMtWGvPWgnFa490JzPujS/vd4/k4aFbzS5FpZdCdMoXIFvHQ95DxIckoyJ2tk6Pza3unj2K8scL2H1aYqP6a2STewN9RUNu3DEf+SuFkynAOyNeNAGrvGsi4Jo7RpcgjqldNcL3sL8AjZ0qcuag33OECjMdFKjIqzjdwphLxYomjaX2ulXZK+P6AkSZ4e6M03eE0QXZQWwqZkwByb9sFeLP+v2OKaf7l3rlj0dw1QvY/WilKt9ofnyJLmSLdxN3rT/IE6O+vNWTY2fzstXNugxcgxQaCEJisKevAGlpPr6lm997mxL1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijuyXKd32Xx9ycQ6BG6SnY8WquJ2qX6Gh2bEPvbGbA4=;
 b=TmMIMy4rB18aEg0hqqp37vhnTs4swGmj3KKU5lvjWVepaZTAJ9Q3PoRflj3DwVPDzgyvvvwA1pE4o0kYJV8EdhpoTcO1JJzyJ9NjdLWk1ZS8xBff4gSS2RwaH4Il25IAR2DZIrBQjsetpDQ5TaGbkiybZ3Y6MfrsQOGjhsBA7FtsCLIdlpndLaK40SmRhSBaEzLGPqVXwgcEOb5TmilOzVKReRju0YMn0muxWhzwbEMoz0YjrJi0U2QU9FMCPrUper+Ww9mkVElSgnwbxG3XGMXQWM70bG3fBdLlXP4Dbh/gMD3PPmd/3xgIZZLNmNTPtBqY6w63SrSv81kLt254JA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB8181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 15:52:52 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:52:52 +0000
Message-ID: <22a163dd-32fe-4f68-9282-3fd5d60326ea@efficios.com>
Date: Wed, 4 Nov 2026 10:52:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] sched: Reject SCHED_FLAG_KEEP_PARAMS before
 reserving deadline bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
 <fc36341b93c2e994ccec71a5ab6d5c8e76b3d73c.1793804635.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-197505@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-197505@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::10) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 02468078-18c3-41cb-99c1-08df3a8baeff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|4143699003|5023799004|56012099006|261021121427099003|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	qxV0mDPMZD+pSYVT7C03icE7syXLov1C0fKttzTgsf5o79CxzwiDlpVmmDYD8yYQ+/ZDKBNzvZvzrOGmVhGYoGOFkHs2r3B805bGW2pysSRBokGwIDw1TzsQGE8gCHIjvbPlteivawI3u2b+PREMEO3Zh/7acK2mHOMLnZesEdVpvO04hZwbb2FwCKDSnVcZ9S0R9UGEnE8VPwg00php/IzFjv8dq0TG2JCP52lrx6qFfZswKAFUIwh0RV03GwggKraym6z6W/HbOVCQiaoGUXaYB40jFv/w4kipXLpYcyokWB36pUmdwc40vOJsZO8CKOMZK+y3WsY0vVC+gKpEhaBHvt9ZS1TdSgGuU6+D5i9IxlNiIDdndtFr0TBceSGYgadoei6ksWaRSDkeZnnydMonz6p/UHyRIaG5vrzD6+Qih8Le8mCdZpy9bwWw9uDrm+2OXbC2OJeZ3kJAxAcNShQa9XbE9VMJV5GT0EOLSb8g9WBK0dEpO+w6aU2BVYTrZ3LbSm8tgz2V2peTJVrqaeYF06HWAwfm88BCKk540hapsxGpZdOzJcwcbu9E7QvYcBBJTXEOqDHhKj+11fkLsAQlWngRTOeiTWTtUWKE8KA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(5023799004)(56012099006)(261021121427099003)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXBjcHJTY0o5Vmc5alNiZW5xVko0QlpMUEpUMDh2bTdlby80UTFuSG1XT2lB?=
 =?utf-8?B?K0dVZ1VSeE44eGwzZ3BzajI2L3RpNVV5SUkrblhjc3N4K2pKWFdrdkpiRG1H?=
 =?utf-8?B?Wm5mcU9PaUZ3bUdrK2FzUXhDRGdyT05SNHNtODNpVWtpSDR6VGRCbUo3aTF2?=
 =?utf-8?B?bU1wMGh1cW85MnZQcXpKUmxPblZ6STRONGtvVk9zeE5jc3hLcUhVTGpZRHly?=
 =?utf-8?B?NVVpRWhrK1grbmEwRXVWVGkrcDkxM2RnV0NuUnRqSCsyY0pUYzhYNVJpOTJH?=
 =?utf-8?B?Lyt5SDVmb0FGT29QUGhjWVFIV1pLUytEMFZIQ3E5cDN5UW1sOUxub3k2K0NN?=
 =?utf-8?B?UVJ1QkpuQTZvN1RwRjRXZTlnSXk2d1YzdDYvYTJGR1hiQkMvby84eG1ETFBI?=
 =?utf-8?B?ZUJ0WVdVZmZrMVQvOTYyNTNBeE5uQTBsd2JPQlFJSWRzamdwK0p0RmY0YVk0?=
 =?utf-8?B?bVBudzcvVHByK2ZCMjVlZmgrbzZWWGpFb2hYSXY5SUI5dlBzL0RtRkZwNW9G?=
 =?utf-8?B?ZHllenNGcWl1NGl6SWswTHMyV0Fld21QaWJwRk9Gbm5LMXArWkgvb0lnQlpH?=
 =?utf-8?B?U3pMNlh1cVZHcG1ySzU2dUkvZUpHR0xZRzQ2NktlMTdWODZwMzlDK1RmVzA1?=
 =?utf-8?B?RmhLOVRUNkVjWWwwbGlxUnozYmZEZU1xc3doZ3o2ZU9Na0V0TjN4aWhBeDVC?=
 =?utf-8?B?ODJHMGNidHRINk9JNVU0dWFHNFRic21QSXhEd3BidTkrbUZxMkdNbUxaVTE1?=
 =?utf-8?B?V3N2MXh3U0RiWUJBZHZueXM2MTJEOWtPSVdScGE3emIrWk8wWkFVRVVGR3E0?=
 =?utf-8?B?MXIzQXhSSkRQK2hITUhVSS9BWUwxYUhHZllEUittQkUxVzNkb1h5d1JrRmpJ?=
 =?utf-8?B?T2FsY2F3NEIwTGd0blRpdmRJbi92YldLbHhaVnNqQldVUUFwZ3Nib3g1SVFR?=
 =?utf-8?B?MGYySHBvNjNKUjJTNnYzS0pxVVJNTUxrc2lISWp6N1laczNPaXFrNDNlekRx?=
 =?utf-8?B?WUpydldadGZmMWxtL0xjVG0zWU5pdDFPbXdBcEZDS3pNcEhnRG9zT3hXcUN5?=
 =?utf-8?B?ZXdyaG5nalhWYm42bkxGYUNQRURlVGJydzZCWUZOU1BIaFIwV0VuZXRad3pP?=
 =?utf-8?B?YTQvQ2dTK1ZTZEVZYzF6QTlhZTRZWmgveE5saGR4cG5NYW00NGc2WTdOSFpp?=
 =?utf-8?B?SFJaYjJIM3RYZ2lPeU50WnhHNG5EdmJ6R2daazhaeGFOM3NyZitGajZ2aUV3?=
 =?utf-8?B?bWcrY09zS2dkenNmYWh5THBBNzcvSjlVamZNZ3NNbUdoR1FGWnB2eit2TVpQ?=
 =?utf-8?B?dGs2Y2UvN3hldjZ0LzdxQmR6MFZobXlEbEhkd3lMUFRyVXBxTmp3OHgrT1Fv?=
 =?utf-8?B?aGVZc3doL0NLVFJManFGM05IUU9rWS9FNEcwUGFxUW1RRzF1cmFBMHNPWCtN?=
 =?utf-8?B?WU9TdStwQjhPQ203UTJiSFdBbzFKY2FSUGdoQWxwZUZJRXFQbU85QWlTTStw?=
 =?utf-8?B?d09zKzgzNENBT0V5ZjRaYjdya0ZLNk9kSUJEUU91cC9JQWxDRG1sSCsvOGIy?=
 =?utf-8?B?bDhQT3RiUzdJWnFLeitNYkN6dW9iN21aODVsaHVmRWxTK1NhamI2cE1xRmFp?=
 =?utf-8?B?ZGVLdFlRMitGS015UzBSc3VaaHVXQlkyVW9qYnF0UzJZcjZLRWRnRUY5UVBa?=
 =?utf-8?B?Wno4NDlVbzVVWnJCL2M2MDdLNGdtMGMxOEJjWFhITTBDUmxlSmlEWGgxOE1i?=
 =?utf-8?B?YXp4dUlGT1ZmaXBJSVYzcUJhd0VhakQvUGZaWFdWRnVnNXhzVXlaTnlPbVZ6?=
 =?utf-8?B?ZlRLUGlPOGFVY3FZVStlVjJUcFJvc2piRHBFWktMWHJqajhxQzFNbkNKamVi?=
 =?utf-8?B?UWRzNWhXNjM0emFLbWtoKzdsSGo4SkdjV05HT1hxU0U5azBZcjZPdWE5N2Jh?=
 =?utf-8?B?L0hQRXM3WU5HelZiZTFRT3R3RTZ5OHlNYzFNRTVIZy9aKzJnTi83bG5obWtQ?=
 =?utf-8?B?K3RaT2I2cUJzdWgydWdSdUlTSVJPck9kZGZqcnZLUk95djhjNkIxZjcxUGNF?=
 =?utf-8?B?WjJJcnUyK0w3YTNINUk3VEdDQWZXdHJOOE9IekIzUi9ucFpoMmtHdGUrUmxB?=
 =?utf-8?B?b3YvSFlnZXZ3THZoMDFmWDBkT2szVnd1NzRJaFRmVGFiblNwaXpXNitTenFz?=
 =?utf-8?B?clFYdDk3TExTME1uWGcvT2pLYk95d1NrcEZ2MnhGUTVaa0xXazFodXB1N3J5?=
 =?utf-8?B?RkxiSXBLU1BQWUx5SDV5TVEyTnBWaU4rekhNbkxYUXFKT3VDbm1KZjc1MGxy?=
 =?utf-8?B?ZTBFTmViZDUrSE1oWmpnVlU2T29FVExDV1Y1WGZYbmM4VXo4andvb0hLVmlS?=
 =?utf-8?Q?alDRjKVwj/k6C21U=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02468078-18c3-41cb-99c1-08df3a8baeff
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:52:52.1659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6u1nUBm+sGoe0/L/UfR99EyetyahfJe0wy38hiwUKDKpgxpmnGfuAqI3a1/CEXiRJJ3FwnZ/Ng/pUU6LtLA+aImsAiSf9FRWYVYSMUfm9Ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8181

On 2026-11-04 10:30, sashiko-bot@kernel.org wrote:
[...]
> 
> Should __sched_setscheduler() also reject SCHED_FLAG_KEEP_PARAMS when
> policy != p->policy, and skip sched_dl_overflow() when
> SCHED_FLAG_KEEP_PARAMS is set?
Both, and the first one is reproducible. Thank you, this is a real bug
and not the one patch 1 fixes.

The boosted case, confirmed: __normal_prio(SCHED_DEADLINE) gives
MAX_DL_PRIO - 1, so next_class is &dl_sched_class, and a task that
priority inheritance has boosted is of that class already. prev_class ==
next_class, so the check of commit 8a70415351ba ("sched: Reject
SCHED_FLAG_KEEP_PARAMS when it would change scheduling class") does not
fire, sched_dl_overflow() takes its first branch (p->policy is still
SCHED_NORMAL, so !task_has_dl_policy(p)) and adds the bandwidth of the
request, and the skipped __setscheduler_params() never gives it to the
task. Its dl_bw stays 0, so switched_from_dl() has nothing to release at
the deboost.

A SCHED_OTHER owner of a PTHREAD_PRIO_INHERIT mutex with a slice of
40ms, boosted by a deadline waiter blocked on it, with one
sched_setattr(SCHED_DEADLINE | SCHED_FLAG_KEEP_PARAMS) on the owner:

   total_bw 419424 -> 838854 (+419430, 0.4 of a CPU), and there to stay

in 8-CPU VMs, on v7.4-rc1 with the four deadline fixes of sched/urgent
as on this series, so it predates both.

The stale parameters: also real, by reading. sys_sched_setattr() fills
the request in from the task (get_params()) with no lock held, and
dl_param_changed() then takes the stale copy for a change, so
sched_dl_overflow() moves total_bw, and this_bw and running_bw through
dl_change_utilization(), to a bandwidth the task does not have; the
release at its 0-lag time takes the task's own dl_bw and leaves the
difference behind. I have not reproduced that one: it needs a parameter
change of the task to land inside the window.

v2 will carry both fixes as two patches after patch 1:

  - refuse SCHED_FLAG_KEEP_PARAMS that would change the policy, where
    only a class change was refused before. This also closes the boosted
    case, and it stops the kernel from answering 0 to a request it
    carries out by half: SCHED_OTHER to SCHED_BATCH with
    SCHED_FLAG_KEEP_PARAMS returns 0 today and leaves the policy alone.
    That is an ABI change, so say if you would rather keep accepting it;
  - skip sched_dl_overflow() when SCHED_FLAG_KEEP_PARAMS is set, since
    there is nothing to admit for parameters that are kept. This is what
    closes the stale-parameter window.

Both carry Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to
support utilization clamping"), which added the flag and the skip of
__setscheduler_params(), and the selftest of patch 12 gains a case for
the boosted one (params_keep_boosted).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
