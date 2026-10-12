Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AB4534AC;
	Mon, 12 Oct 2026 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795966; cv=fail; b=DAnOz72eKwfIaSr/MgjrZvp2S1mfiTpI3tdVJ4uu86Bh9kQ7mm9DIvbn43Q8JqVkDkB5qAkKLVQMFU3DpNAqRt5P2Hky6W1tfZF9/p3E1o/01P1SUE0oAFap7UO7avcGemeMnAK6/zEI2xnYPtDNE7YeRHAFokrz8SJYxVJL/48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795966; c=relaxed/simple;
	bh=cw2xq3w+Y0kkAvDMjBi2l+64o7H1Ux2tozArdBpEuwQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QvQG/a9qferWaFXV15eIR5w1Q1hp9nausqwOlNZERGaK7wfaW0Z8A5hbGEx8vammz6v9ODiO8zKMleD2Wt0kRe5YmZWhLPEcMVewwjKjrGIJHQTxlB5kH5v/zoauUBQwl2MowJKkkAlBFyNJSPIiUgSq9v3rLyzcSi+uLgnYWto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=GO8V44mq; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="GO8V44mq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJqP1yIWPuICCwnEJqZEJ5JIkTSrksx6c42IC+2250J94PCLvFGSr7MKR0uiebPwvIS1J70d1jfwML3yH70I+2O+osd4tiHJE4ZUr5Kk4RDHR/RcQFPObckxNmJC0wHhDdCM2kICXxGGn646DpNMeHQKlTDSRpRtVnsdbs64S3LVP1IiT3ePR+cAs0NiK0/QMxZSIvJ64bTleTubjhP3XEc8HC8Yzi0oBmzGcrgecT4fHKmowEy+BjT99xUiW+q9FPOqtSl8cOkfA3qZtoYCPBZrzMu2+WmfSl3uUxB8xc7Zs1QabTT210swpQeLyQzhajnIw+4hmjWT7uhUBMWNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw2xq3w+Y0kkAvDMjBi2l+64o7H1Ux2tozArdBpEuwQ=;
 b=nZVrFV0cE6kxTtvnnOVVNGdpCY7f3zkyW//J/4ia8r/nzgTbHBh94jwHKOw27A6yofj40cJt2na9/n3KwsN1dLMs8xbFIm1WDqorI/d8c7PPhh9XzZWKJJOLapnS/ftColT2jQDZTDySctk8TeHZ7Vd3t+0psLPNhI00IL7txRfQrjWoSIkfmlnMPk5IMWvwgyW8Nn8le9K1QF4ZkgGiodRIxmYxO/lsd8yWwqaLSVqjJWu0+znBVskJzrLyp3nQoaFS81qcoEQdWvaHjlbbyEeuFI5Rkn1d6aeT2lKGM4jIk5eynkRSoRP0vFlywxKW1ghqQ8I0x1/xrUHyU+au5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw2xq3w+Y0kkAvDMjBi2l+64o7H1Ux2tozArdBpEuwQ=;
 b=GO8V44mqloF8LTErR71lNiyMCfQE3K7zME/DhvW5a2sKtgrnANDgFYM0nEtvE5hliezLVUEKzNDtIhCY8Zdvyn6Xya/pWBTsoISCe6vNKte7oSuKO9kRhD6mjSll3K+xcGGEIsMzCWtSHItMOPGYP27p2XKlBXd+d/6gMOrWeDA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from GV2SPRMB0069.eurprd09.prod.outlook.com (2603:10a6:150:31e::17)
 by DB8PR09MB4375.eurprd09.prod.outlook.com (2603:10a6:10:15f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 09:06:00 +0000
Received: from GV2SPRMB0069.eurprd09.prod.outlook.com
 ([fe80::4805:b1a5:d3ec:2d22]) by GV2SPRMB0069.eurprd09.prod.outlook.com
 ([fe80::4805:b1a5:d3ec:2d22%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 09:06:00 +0000
Message-ID: <b7a65799-191a-43bc-abbe-60dac519de00@mobileye.com>
Date: Mon, 12 Oct 2026 12:05:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] irqchip/riscv-aplic: fix asynchronous probing
To: sashiko-reviews@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20261012-aplic-async-probe-v2-1-868d7684c9d6@mobileye.com>
 <sashiko-outbox-167856@kernel.org>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <sashiko-outbox-167856@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To GV2SPRMB0069.eurprd09.prod.outlook.com
 (2603:10a6:150:31e::17)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2SPRMB0069:EE_|DB8PR09MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e8010f-46af-42cd-c9fe-08df284008ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|261009223027099003|11063799006|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	oHV94SWHRWZcQWfYyPqA6j7AT2IxJTpjXH9h7WRHahSNy8OdPSMMIT6ZsDFiqJyXG/h8WH15dAAl60hQheMEkkHeNXdujL+YbU+dgMAB3CCZ2fbD37QSdo1vvObnfTZBszsXO/YbKtnUjifvwdcSa2wBs0SMzNxUuCVHeFmie4bwyrn8Jgfmd8Cw+n6ftFJ3emoMEwArbOUOPZGKHInJ3H+NfEuRsu8SDi+INaro9bZSTxunVz8vVS2WxiFm3hkyEfmhHGSkh/xGotpQrYiIZ3V1LjYiDjonCSFK1AE7nC/nfvQNza4VzroEuvlSl7oDGNRoCDICdxVB/9NveTAYau+R14S8/Px1bYZwKj428LSjRJyimwEJJooAKTT03MXJIsqNPS+aVHiLokxx877ucA/VGi7ByzYioYumnbT4tpk/++gUoL4oa7mr7NytvYnz4d2VB5XKv0Ie1QeB3pyRIOgHiVTponAJHcDnPnZIKAgSct6M7vbWZj8jxgKCRVN2mKfxJIsFKEn7trhLt8VQWOis7E4bra+z/hYkFlVjW2eTYzZU2dNawVOSpL+UVRRNRbejZ/JCUe5ByZQ3IK3gB+mLoJO+XWXkwvNGXCmVQclms01S1fQhPdCVRpbolrOMt5AS6zpwmQGMKDWt8A2+yZYgvfjkXHODiZnSACnSKV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2SPRMB0069.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(261009223027099003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEdSY1FUOE1EbXcxN3NNUGREMVU4M3c3NTl2akJVVThVVTJRcGI2K2haOTNv?=
 =?utf-8?B?Z0prYm9HdjhmZS9MVHdWeHBrNjlIdWhjR1pmY2MwT1lGUlI1SXhOeTJYSU5Q?=
 =?utf-8?B?dm1tZUh6MnBBWjA0UW5iR3ViODlIb1B1OVFRaUVic3EyTGhyRzBrMUdOcG5q?=
 =?utf-8?B?TERRYW5vVlRJcTVySWJMdzhCc3FwcHM5R1NwUWVubW5mdzdOb0NRdG5aNFB4?=
 =?utf-8?B?Y3RxSUtnTmIvTSsrUEtpWktRc0VxcVJxQjJsb2Z5alVuVmRWZ29KMWJmT1F3?=
 =?utf-8?B?bERhcmNGVVpmMGRYVXJWQmpqZVlHaEdGOStRcTE0emRBOElkWC82bXNKcFhO?=
 =?utf-8?B?d0Q4QStTdFptb2p6SW5FQjB1QlN6S2ZlMjBpRjNKR0wxUDc1MVRncE1YMTZy?=
 =?utf-8?B?SjZBZjE1WkFiZVRhc0RzVFM5Nktjc0VQa1ZKNUlkZ1J0dld6SGw2ZmVtMldR?=
 =?utf-8?B?ODRKNnMxUWErNmtjVG1oSkJYT0Q2RUdLb1ZKeEl3eDVjazEwcDU0U05waWVt?=
 =?utf-8?B?QWhJQUp3bWpXdGFaa3JJWStqRDV6cGEvWGZvZkE3YTM5a3dLb3BGRDgxTEdJ?=
 =?utf-8?B?eUlxdkFVTVJ1R1M0RDJWMTJ2MVppK0lSeDdqNGptK3ZvTnZMMHFPb2U1anNl?=
 =?utf-8?B?Z1B1SGVUcHN3TDk3U2hxancxajNLbTFIanNEZnRvUFNmc0dNOUFPOVIxMHVT?=
 =?utf-8?B?dlVxdmpDZTk4aGxPMVU5ZFEvOHc1UEp3MlVGd2xlNGoyMkJ0T04yQWtVajU0?=
 =?utf-8?B?ZFozeDJOUDZYOUJWVUpyMDcyN1pubkw3bWFGMUF0Tks4MEVIYXNqdG1mSGZh?=
 =?utf-8?B?SzdaMndyUm01WUxPUGZSTmZkb3F5RXVsaC8reXUxTG9BeWsxZUhSZHNVY3lG?=
 =?utf-8?B?Y2RSSzl6d1dQaHV0VXNOZ09XWUN4dUJoK0N4MnJuajJTTysycHVML0lSV2pZ?=
 =?utf-8?B?MjZ1TjJrR2JHS1BEUXhrRUZvdnVsaVdWaGZEY3ZQYmR2VzZLNDlOYnFQTXh6?=
 =?utf-8?B?bFRyQStST2hNTi8xdW0vVHFoVVJ2eFp2ei9JcmNoM1Z0dlIrU3Q3TW8xOE1s?=
 =?utf-8?B?RVFCNEVpUjVtOHZ1T1dWNWVmTUl4WFJkR25vd0dkNEMwYy9ZdHcvM2VDU254?=
 =?utf-8?B?SGI3Zll0OVJjT2hQbTBza3F4MXZpam80bWh0SzJ1YW9Pa0RBaXc5bVhQUWJn?=
 =?utf-8?B?MitFaXpQc2pRcHU3ZVdiVFZmREhueUpFbEw3dG9WQ0tkUDlnbG9XekZQVHox?=
 =?utf-8?B?VEZxdnhVN2pFUHVOS2RpdWd6dzc5OU52SnBFMVFJK09HbGcvSnAxdGx1NTRG?=
 =?utf-8?B?NUM5MUdkWkkwV3o3eWJlV1dHZjM5TEt3RC9xYm94OXY3aFpJNlIxZ3JqR3Fr?=
 =?utf-8?B?VXVpdFFwSEhEdFBEQUZLSFRHYXpYWGE4OVBkQlVvalE0b0VERzhTaUFMOTVO?=
 =?utf-8?B?K00wM0RIMUpCNm50akM1bEJ6TVFnRjBvT0huTXZjZTNPN0JaUnpCa3dtTmxM?=
 =?utf-8?B?YTNCL0ZPZ1FnTzgxa0hEcFJ0UUZtc1dqS0lpU0ZUSjZLMkVRMWt4ak81YzhL?=
 =?utf-8?B?QzRzVzFsVm9XT2laVGVzekxKT0FIUDIwYzQ5dTg1aFRwOWluU0k1VnY2ZzF4?=
 =?utf-8?B?d2pSOXRpM2o1ZVNvNWU5SmZaWmdiSWw2N21VU3pxR2xSb29rV2l6b0lSTGtJ?=
 =?utf-8?B?RS9Wd3NWYmtRVGRwck5WZ0ZmZGJobXh0cDR1R2FXUlFoeGxhWHpXOHpDdUJF?=
 =?utf-8?B?Qkp5ZzBlRXRQNjFWQWxFMVhVVlA0T1Q4T05yR0krc0pITEVnaTlPcWFmK1RG?=
 =?utf-8?B?Nzl3MTZqZEh4NTNad1R3WnNHUGdpLzZIMy8yU3oycndXYkZWc3Frb200UUVw?=
 =?utf-8?B?VlBidVUxSUdHdkNQMlllR2FMNXhBanRDZFBYc2RCVUhTM2xCenpzblhEUWtl?=
 =?utf-8?B?OG5lakNIYmkrMTNnSXZuLzIxS3UxajZsYkpLREU2dzY1YiszK3BzM05qMlFP?=
 =?utf-8?B?cDlrQmxhMUIzNEdnZHhMTHRqTEhPUFo1YkJtT2xSYzdYYzdJM0lVQmdtVUM1?=
 =?utf-8?B?YmoxQ3BGSHp4VmY2eFhReDRWcXB4UVliRU5PNXF6Qm5oYTB3M2k5N3hVRmg1?=
 =?utf-8?B?MlFNRTBwVStHOGJJMERDMTR4L2ZaR1E0WWxobkhDYlJnbkVRL005SE1vY0Q5?=
 =?utf-8?B?bUpQbis5N2cwU2x3a2MxS21KbGRGTkgwREpjeUh0R0dpQXVBWVg3RkJYbmpy?=
 =?utf-8?B?ODV6NmFKWFZUQUxnNUFKa25DWnRCTzNJNGNLYXJKekJiSHF5OVFkdm9ObjBW?=
 =?utf-8?B?OGhvZjVqSmhLZHU1NUJVOGJIbDV0Nk9wM25yYzMvZ20rcWU2V2trZz09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e8010f-46af-42cd-c9fe-08df284008ff
X-MS-Exchange-CrossTenant-AuthSource: GV2SPRMB0069.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:06:00.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+ID9SAHNaVrM56V0e1LwPuJPiN24MvvwX6A8DgmBRWaIy8Px8ZWEsQk68Tzbl3/CrH4GDSBJmUzc/CbaVAnHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4375

On 10/12/26 11:41, sashiko-bot@kernel.org wrote:
> Does the __ro_after_init attribute need to be removed here to safely
> support late and deferred probing?

To be honest, not sure. This patch retains same behavior,
the `aplic_syscore_registered` is written only once by first probe.
If __ro_after_init is not appropriate here, it need be removed from the
original code as well.

Anyway, removing __ro_after_init

Thanks, Vladimir
