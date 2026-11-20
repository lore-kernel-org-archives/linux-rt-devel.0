Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182571;
	b=3W3U5+FjVLl2BY/dhhigcOp1OffXlHJiuyGsHrccpByO6wZ/4UIrkqqN3nGI72xLTBoQ
	 byLUZblqGkfNVrqZFo1HQ67mvE2Dy6uq9bJGKgZQm103WBagIlg8qgfWvzsODjPdA+oJo
	 DYuMcwGHkbX8fJlnWx3wIPqNJ+my/zhze4qCP4/d36ynUDnWsUAX1mOG0KudaTDZlCzha
	 sj+qrXrl99U5DP5dH3jFmS6K9BuTiEiQRr+tc1d4wfd/TaPPa4g8V9yyIuRL9H+G/VFIw
	 tLO2Sdh+DBunWicYGth2l8gumMrxiF+bbx+zpSbXmcJ8TzukalGq/0v6L1c/zhCvBdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182571;
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
	bh=Cm8Hu6hir4AydBgZDY+ytL+p1j7/ApqdiMY1BJx2qVs=;
	b=3h+OtAN8yvxandkATA//vm3CSBykyO6+Q7ZEwfM/SIHvDQCR0fntKOnbaQv6KacXgUom
	 pHxEaKJKvScy1qaor1W3ef3yeLOxVmF3x7Wj2H1YdgfUB9W+/rteHVMstnluugMND9CS2
	 If4RcTx7mlfDA/XyK6j8HsaU2iMoo5C2VeWf/LtNCRficoy6JKNTdhoxSSYgukjKCrxWQ
	 yUiuFOsI3S9Ct6hiOXW0VxH37ydwmxHOrk5SnV4Mu1lZgh9NM910UErQ0D9hpCJ+4+UBL
	 sSyBmK71Fkc41O23Yo2esOuriXgnkYrNWryvR2n2f3QrO/d8mQeZqU14Ta0p+j41zZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=KHNaopea;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.77
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020077.outbound.protection.outlook.com [52.101.189.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424760A260D;
	Fri, 20 Nov 2026 13:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8424760A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=KHNaopea
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiPpecETm4olrtX1TFLvbOdu1xJNum42qAqkQOreNLeg+X8aFom7KjwlpRXxGpj0TFOe1AncOxEGfpRPioAMCWT5wI12zcmRs660QB1FdWhGH5I+b4fsfuL0Ng9DjehawtnxzPpNVSuI2qdbVXGCyQZqwe04gAOSnSNN3lD6XyyWZcHpdqBITtui5U/+mqFk4uaRf4lAPi3nSV7VlxPHmAbmcQ1PBKbJLVt6nn5UmJFGsj2KJs3BcnVbRG8Z2ZmnlGLOTE8A/o7OX+CBDi48UCDguAr9bFjGl3TKxxm1NPRdkJTECEDuRiYFDzEyVAF0saXDx/eBAVAxyinm6hZ4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm8Hu6hir4AydBgZDY+ytL+p1j7/ApqdiMY1BJx2qVs=;
 b=E2DWd5nAMENPpSvJ+cOhKw4VPZhwaQmbvAxCiah71x5XVtcLJmAQb1GmjSuvlyKnv4Y6KYgv2JKF3CLXgbl1iPo3rz+Xto+fVhFsTrvd8TAHzuaVp5V63in0wf9I/VDBysZFD8OZJVpmyAiBdx3TuscVUWPJk1kkMP1CBRiNghB+hxeArdwk9DrD/g6tsF5nNWOMM0a/Mxl5RC6O9zBV3kK+c4P4nRnlAqjQAlOhct5UG+nobFp4mutsLcQMOB5Oxi/GE3e6iVBc9wPK03PA5FujBcOssLWMr5UISJVHu3CtfzG8Wmjgo0YLAhLTS1MRBynAmjcZmFFEpsr4QDZNXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm8Hu6hir4AydBgZDY+ytL+p1j7/ApqdiMY1BJx2qVs=;
 b=KHNaopeadgjLzH3NUi15dJqUSEIWALyLtg1sXDYBDFf3ksE6/Wyt9/NlAJbhgYTZOfBH6EshKkBIyQ5muarfxxxnqPZjMgnflOBLjFd8mg5bAapcL+LN422/khqWctHyGwBixthS7gmp+izqKVA4jn4+4TVu4OdTfumOPSlYcCHMLrPGzxPdNzT6o9thbBVYYw6JeCrCCpPqOhyiJGhr1G82dmoxn7gM4H1H7L8DwWHU7o3i/0eS+K+pUoL30o9lqPTCN8c04IDv0l7M0Nw/A4BZy1r+bHNvsNcgTxJILyUt0VsfrKE00nv0vaLZMSFkb3rL1jIPN0nsd11hoZdAqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB10747.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:49:29 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 13:49:29 +0000
Message-ID: <0d8b6fa8-cd73-44fc-8d6d-8e67ca1cd42c@efficios.com>
Date: Fri, 20 Nov 2026 08:49:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/33] selftests/sched: Test SCHED_DEADLINE bandwidth
 across a root domain rebuild
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <2c85e2efab1ae7eb89b6d6e334c933348486c542.1795116790.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-224022@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-224022@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::18) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB10747:EE_
X-MS-Office365-Filtering-Correlation-Id: f12afd5a-7823-43cf-d4c7-08df470d1946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|4143699003|56012099006|261022105027099003|261026121527099003|5023799004|261026140227099003|261022075727099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	S7KYWaOhmvW0j5KYLiq/EAyl38ixevUWWJ227KXkHhmodTxc7R7GboZFdpS0PDaq5HiF/4SkaNpc8VHjAo1UZ9pmLTgLUL8Js/Sw2N9knm/1hIvBYStIaVLm0lS+Lg5z/ewe9dC/mPkT2bZ5kHraaI8T4+cJX2wLTdODHSfmB3Iw8iUUM4holqP6YmqIjy4yc0Vrl5nFA9oJDJJ1cwgU1goJ44jbLzoI0EmFXueRIJrn+pPHk5wKpMd6rmmegvagWpkfG+nz7geQ4zKrPzx5x3aYqwkabbdHtrcQ2YNS6oesQYYD6u88bSOCbZutjo1/g9H6uqxp2grGWA1UG3PENrxsj7Z0RulPe1ryxsEelc9MCtNlYH9RId3ny7QAjTo9FrsW7tsHomne/fRHpGC6UnecbP77AeoB2oHh5o9NM2xqkXTbZftdBGYy/w+TyzsSpK8+Q+hyunf8G1I2uZrvphjzrLDSX9NUWo+m9eemh02P2LacgK9DpHpl2C7Ie7gfVHxXibs7YjLpkw1ZCfT88QSBnZ5EoHrC4i6E05pJfPKWmNPJctF1tAZf5rF3ixnOPujkJxTxonL1pada07+xmd/ZtyQY9DgObQILbdpm1VY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(261022105027099003)(261026121527099003)(5023799004)(261026140227099003)(261022075727099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTZ5a1RxZmlzNHU2S29xUTc5TDJ6NHZFNm9PSjZHcFdHQ1pwYUFtRnVpRWxH?=
 =?utf-8?B?cENaUjN4eExhSHdLN2Nuc2g1R0RINW10cFQyWlB2djdtbmpPL0p5akhIOVlK?=
 =?utf-8?B?VXVVdFF4QkFtVnRGd0liM0RIb3prenVUK3VrYVdjK1R4YkpYUHowaWJCNDhM?=
 =?utf-8?B?UnpRSnJPaVA2aTFQV2ZLSzU2YjMxWEhjcDlETnNJb1ZKM1IrRjFhSytPVUdl?=
 =?utf-8?B?N05vbENlT2syMmhMaElSTFJlMDlFRkpXUG5sZXpCTzdSZ09QVHJwK213bWha?=
 =?utf-8?B?STNxbzMzTTRLZDAyRldtM0lMWWdUNFFCeFR5NWM5anliQ3E0eTRyRkxsYnNn?=
 =?utf-8?B?T3AybEhWOGdtOTV4K2N1NjB0QmhDSWJERUN4MG9PNytOK1c3ZU10UkNva0xj?=
 =?utf-8?B?bzZQWk5tbHFidERyV2tzTFFvQlA4NCt1dFhZcHJLdnFVZ3BUNm5DWTBpdnlx?=
 =?utf-8?B?bVcyWEtqZmdtYzAzbUczNGFDQ0l4Zk9MSy96VkRXZXc5aGlFa1JMa1pwSGJq?=
 =?utf-8?B?YkN5Y2lFQUREQ0hCNDBWK0VrR21xQytObGUrcWlUanhQeWpvL056TkcwV2pv?=
 =?utf-8?B?Yml2TGp4VGNTamdsb210OG9FZGxSamxkZlBmTXl2YStqSTIwbUlMdXZKNUwx?=
 =?utf-8?B?WkhXdGF5bHd3WTZ2UTBOcDl4S3B2OEhDQnE0bkxpZW1iMDVKZnFoakczTUZk?=
 =?utf-8?B?NGNvemI0UUJHeGJGYW5tbnBaZTQzWnptbGd1MHdOejhVSWhtSXZtamZ4bWR2?=
 =?utf-8?B?NFdjNjFBSUpDMStvUGJUbE43MnR6QmJQRHlDMGlaVko5T2JzZm12dnh3ZVdF?=
 =?utf-8?B?ZTM1b3UzTGJOK0FBWE9HSzVrYklOaTR5TDgyeStCa2xJeWNGWW9vSkVEcHFV?=
 =?utf-8?B?Q3B6aWRaUmdXTko3YXpHTWpvYkNmM3NuaDRtUmUzanF5V0ZlU1ZYbng5RVFI?=
 =?utf-8?B?ZzgvcnNaQittdnpCdXdLaUVobUgwbXR6ZzF6KzlkVmU0aENkTVJxTUsweGdj?=
 =?utf-8?B?aWJWazZTM1FESElNejJBY2Q4T2J5aWtjS3Y4RGpPRUh5QjNTeWo1NGpBQTRq?=
 =?utf-8?B?Nm1GdW9ldmh5dGY1TUpPcUxnN1lEZERZdWRuOTJDSlNYeUUxSzNvWDRvQ20x?=
 =?utf-8?B?OStDMHRiUjlRRE9sZEs5eld0NWJwR0c4b1ZYODA4dm5wZFBLQkowd2VFeHIv?=
 =?utf-8?B?ZnRpUXE4Z0k4QUpzNWZybGN1QXpPWmNHbkJ6OGRZd0t1S01mMzRQdkZORTVG?=
 =?utf-8?B?R1N0T1QzeWVKVFp1eUtweklwc2orNnNPNmdQWmlkZDBkdlpWM05GRVhDVWVD?=
 =?utf-8?B?dzdLak1pd1FhWG5aVWhNT2ZkZjMyZk0vaTdwakdPZWIwR0JWNTB0dXRKaVVW?=
 =?utf-8?B?dlhIc2hWVi8zMEZIMlAzOUxqNURyVzdML0NEYnBtdjRJNGFsWUw2WHFFbUYr?=
 =?utf-8?B?M0VYN0c3YXNwNlRYVGtndVd0RG9qeEQ1SnhtSEFXTEJMZm5pblJTd1JtMEZs?=
 =?utf-8?B?cHNSU3RPQkl2TU1ZSGIydjdtYmg1UVR2UFVIaEs3OVM1ZVFkUnZwWHJMT25m?=
 =?utf-8?B?dVYzWHRFVU1STHNBZnNXSVFIck1YL2xDQXBZTktXa3M2K2RNTHd2RnpJRnJq?=
 =?utf-8?B?ckJrMkpWZVZsMU50SHh2bkkxbmNSMThrOTk1UVI4OFBtOHB3TnlFSE5nU1RM?=
 =?utf-8?B?Yy92cHlKd0Iyd0F2eHg5eFpaT05WVDVtRFhKaFYxVW1BeXpmbGcxU3l0Q2pT?=
 =?utf-8?B?OXhrcm1XeUNzRWtIUHp3alFOcThINC9pZllKMGdkSU0vZitIV1dpZEp6eG9i?=
 =?utf-8?B?K0UwTlN1Uk9GaUZ2WGR3aU51TDR1Vm9rc3YwN21OWVlHUEhpbU5zL0FlUmtx?=
 =?utf-8?B?N3pGMlgvTVE5SklLdCs1TTkrS3V5a2hWM1h0RVhudVBQckxQTnhtZ0I0dmRn?=
 =?utf-8?B?U1BPS1NmOTkyRHRhTkVVa2xXUlBYVk5DVXEwb3J2MkVBNitkNnNTVXFEa1Aw?=
 =?utf-8?B?bUs2ZnV4c3p0enBBa3pFTXAvU1N0OTVTRkIxRmZlLzJCUXVMYllmSnpFeUdK?=
 =?utf-8?B?VkhTczRQWDF2Y2Rtc0hHWUVzNGZnaVk5VVBjVCtEOEtoWllYUEFwT3NIcW5j?=
 =?utf-8?B?SUM2S21XN2hqaStCTlVMNWxScEhDOTJMelRSVGhveUdJM3RNN2dIcUU4czBD?=
 =?utf-8?B?aFdlTEhoWXFOR2dGNk41Z3ljcTl5bktDUmdPZVRyUytMVEZ6S2NGbFZMbC93?=
 =?utf-8?B?UkZrNHdIWGN0UTNKS0NSaVlyek1pMTI1TGd4Mlc5TDFWbklEQStGRjhXOHdx?=
 =?utf-8?B?VkszMFZxVjZUbXl0cnlnM0VwVzV1WHJ5SDhvazlvYXlLR2UybnN1ZHNSTkpT?=
 =?utf-8?Q?RZHdQNGXMWbM/aHERpPPc/wJDLFdDGNRI8b8Z?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12afd5a-7823-43cf-d4c7-08df470d1946
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:49:29.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG2UnmB4QPeRzTgc6lm0DXB7KAvCTuNsBwzeZpcmvF+OwdyDRHF8K+bjHFJ3X9XMOoXckipr04trMBkPTvFD1FlihUL6erv1ytTZaMch8HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10747

> Can snprintf() truncate path[] here and trigger a -Wformat-truncation
> warning when make_partition() is inlined with cg_p or cg_q (which are
> sized PATH_MAX)?

Our builds give no warning. v9 will size path[] as main() does anyway.

> If the test runner is killed by a signal or kselftest timeout while
> children from departing() or sleeper() are alive, will those children stay
> blocked in pause() inside cg_p holding SCHED_DEADLINE bandwidth and
> preventing cg_p from being removed?

Yes. In v9, each child will first set PR_SET_PDEATHSIG to SIGKILL. It
will exit if the test died before that.

> If make_partition(cg_q, ncpus - 2) in test_rebuild() or enter(cg_p, pid)
> in test_move() fails after departed() has succeeded, does jumping directly
> to out skip waiting for the departed task's 0-lag inactive timer?

Yes. In v9, both cases will wait past the 0-lag time on their way out,
once the deadline task has run.

> Can picking CPUs ncpus - 1 and ncpus - 2 from get_nprocs() fail when
> online CPU numbering has gaps or when isolcpus=domain is configured?

In part. With isolcpus=domain,6,7 on 8 CPUs, the test picked CPUs 7 and
6. It then skipped its three cases. That loses coverage, but fails
nothing. set_deadline() does not fail in test_move(). A task of the root
cgroup is in the housekeeping root domain. The span of that root domain
is inside the mask of the task. test_move() passes with
isolcpus=domain,0,1.

v9 will take the two highest online CPUs that are not isolated, from
/sys/devices/system/cpu/online and /sys/devices/system/cpu/isolated. The
three cases will then run with isolcpus=domain,6,7 too.

> could these helpers be shared (or these three cases folded into
> deadline_bw_test.c) so online and isolated CPUs are handled consistently?

This test is a small reproducer of the first fix, and it runs on its
own. I would rather share the helpers of this directory in a separate
cleanup.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
