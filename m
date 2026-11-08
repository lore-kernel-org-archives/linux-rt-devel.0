Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794150297;
	b=MsTylp1y7XBRUcMcj619jjmDPCY22votdE5yt9vcy9WXZgrlArrGUorThVJSugsFzHVw
	 Un6JDDrujxOilY57JiqdHPKiGSaZCV7izBcJTcaEgh5yASifMTYt4z7GDoJNadxEtVltX
	 4v0wih30NAmDlgemgKfZARoHfguVuE8jQYxE7O3Rn1NQSjSNZWalEXay2pTaGFZjfC7fY
	 cq9OoPb8SxLjz+5h0aZWKcD00g2fyw8eDIM77ggvk4Sv1jyGuVIqhdpPSaQDgzK8X5pHp
	 I4GarE3XoOFfRjC3z1pnuyNT2fnkzBOzEaN2FsCI1u6pPq3TaLOSDMnsPdkKGL9Oa6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150297;
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
	bh=Jv/JfyjIFfCqoojAaLHWiDoLIzgG03fh7dFVU2pAe6M=;
	b=JJRzIzMZ1mxGB5/vytZ+sdyzs22lryZf0APiqPad2BKMzItYATNJyERxUhwDnmvu0myW
	 Hs5Xg3ZaieDQmWKRTjWMDgJmE/lxs68XP219ABFq1iyzlL2TV2nVPwPYzJ/+K3Mw0fq/q
	 T6Tu7xl9dZfM2jUDnmxjlFWBr9NB8a/74AoVusFIzR5rH+XhHhLQR2lnmarsqIyyCnpUT
	 LMZlzohqUqqhh3VzHj5c2wYPARgU60Tj0F3BHMWmQ9QxBm47X5OCsjMzHGlourPW5ZXLX
	 MKhMcAEbK2NwyPwPLKc8o6vDLhPxFqlooVMFOlnOflIvbstsjof7PU8uFkxTuj5e+MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=rgc+N8Uk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.102
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020102.outbound.protection.outlook.com [52.101.189.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD74606A320;
	Sun,  8 Nov 2026 15:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AD74606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=rgc+N8Uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOwNwjnGl1iHAdKM4FtzxbgG2KXdzKS5w07B5TyOJUMapCMRlXem+Rdbh5neU4aDtf7XF824lZS0cYHSHSy+Y+IAK9+q2n4I1euQvkww92JqQLTLfj+5X+50HtiMGVMhrtfzUT29GS6F0sezffQQskNhbRTqlcaK4nHH5gi9fd49QmUGSRxis4AmqXsAhMXcSOpuAseI9JdHFlQBZQV776BbiGCG6rsStjC20RkK1xPwQYinRCYek+YE7LVkd66NWEjqKps5YmfrC0JtuoQgI8BSJtz2uMoxvp9apMYH8ZWdv39RJEtdqeL6MMGlVA03lFUF6dL/FAXjrdE0OUOjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv/JfyjIFfCqoojAaLHWiDoLIzgG03fh7dFVU2pAe6M=;
 b=m6ri65gCn7/w3wdIXH8rBIBgOLys4WBTnKm/Uih7PWSt98lUCvrSfyUGBDNInZn8z9BDKPCHgeg9SjFU/vuUTEGr84xrkMRa6j875jBZ8BTIHda5CnED+3DVehcYHBj3LyskoNzP8DjqQYEwG9m0h6yT89kNs0OI9t262I7sGEoSVT3NQg/6pzZVQ3g9YsgICWUVMinoyOhCV4z/byJ+kqGN9xsZEvHw8UwMV6JJ0HgSLxbv3bZkmBlp4JA9p9XKA3Wzj6zmuJN/yrfOBxUNYA/+4MRxl7uMHe9EOnOJOOzkB4PBmF7TJXca9EyZ07oHHW8z2lvCTJsyD3J8eayJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv/JfyjIFfCqoojAaLHWiDoLIzgG03fh7dFVU2pAe6M=;
 b=rgc+N8UkAnnoVoerWZsgzmiQRSbNFejfJIYbGzHnOR4gpl3uzSxXcQHuybULZcHBR3BdTzY9BnkS2EkR2qvFoRrdKbk8jpjopdnf8/eT2RpZxNRpajcfFUCRXaB+RhvGZnvhfyy4TNIMlOi2hzTfYFB+tRmeknb0EU47Nfb3XnHR1vc74dHBWWOfWdnPqhxl5qcIkWvbcPFx7IiX34mEJoVNW+b+QglwIj3aNMeftl9lPuDm9FCpC38b2878lpD5XMx7Fs7mjzcG/B6QVa2weTdHdEhSsy40A9rUnN9jmHDPbQU+Fs5HOsWiTF1PTKNpMeYZqceqojo9/sEKwgTdxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB373984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:cb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 15:04:55 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 15:04:55 +0000
Message-ID: <ef4d5553-b922-42a6-be8e-46f75ce6a3e0@efficios.com>
Date: Sun, 8 Nov 2026 10:04:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/26] sched/deadline: Take a deadline boost from the
 waiter's rt_mutex node
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-9-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202507@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-202507@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::14) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB373984:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a767d25-7d66-4c4e-2bfb-08df3da9a625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FMH3a+yKWBtZ4jF//JZzKSfo7zRpEL4GysGlRgnglQ4eTp+5O5NdWsvMYHLbTZ1oBAs07sIrxazM+ybgjYnUARMXuPOX8f94U7E9hjf93GflikUEjn1RSTeNGisLBYBc6CaNL8jLqTPzsisNf9DjRyV/VE07zKi6IGpQAqHWfLUSKNgAf6lBf67p6iLEKGHAqTudDAj0c/0sLVs+6a8nAfEkA7+Jz8OvPxH/KWVAt1jmld5nUlrWD+Ueyu43kTyCfELxOuJYvmClnhRLOkhxBWVqbk92CekCFG2bJlZ1qHMbyKb7qqYV2Cd86POgaQZLyRyuLQkxd3nwmv9HOvX8xQVCEPfWBuh/lMhO/o4KoykOtt0HJbTx8zHkAEn3MiOWusufTnXxx9JDgNZ3MMMcAJooyLzdBnZh/ZmJmgT0Qiom68U8RmcausEMAmtcPPduYG8LFC8YH7Hndyp8k661IoXZbRTbOa6mb/10sNvgql3yUdCAVF+OGj/T6IMqOxgAIECbjDJcbhDLqzejGfUwDsWPXoOgqgA95ZnvZm0/42IJy4dtUziFscFAoz0BR0+rKy3dcfYLhFqChpbeuTfsZn+CSM6HfWB5aKKxaeW2eZs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckJyRTdKclFIZmJhNk1kTW1lSFVhWTVoQzdTdkpPb0ViQ3kxMVJBQ0VMdnZR?=
 =?utf-8?B?Rklia2pBUHIyTmVYRDkwU3pCN0xRVkVYWEZnTmpKTE92Q1lBSFdYZmM2a3ZF?=
 =?utf-8?B?cVJ2bXpZYjEycnNwbDRETkpNTFNFdkhhTWQzMWF6TXh5Nm5JM2RHWmVVRUZz?=
 =?utf-8?B?WVdrUjAxamFycmZCUGZlSjdZRko0Tk1NY3ZRTk5LNEFjdVdtSE9wQ013bmJr?=
 =?utf-8?B?bkN5cUM5Z0hWSUt3TmhmTXJ5aHpzcjRRQ1gvY29ZZFNSVklyWTU2c2dSQTBT?=
 =?utf-8?B?aHhvWFYzUWhLSzhRWDRiOEVaUkVhVnZrSFdJTkVxTVExOGk0QWowWGRRNHlo?=
 =?utf-8?B?MVZzdVJUWTFITzR4OHg5QXNPdEY5TkFPRXNRTmtQRnF5ODFITVFCMkp4Tnl2?=
 =?utf-8?B?N3B0azVtKzNSZDRXMU5nd2oreUpBQ3d4T0ZwdDNVaFZEK1U5WkRaS2d6UzFT?=
 =?utf-8?B?bVBkNFliRzBuWklaRElsMnFXY3ZuWHVHd09jSzUvQnpGYWdEVTVldGlocG1P?=
 =?utf-8?B?ODhJcDRvQ0lSSEhrN2RqL21GV2pGRytvbGRFKy9GcFVzeldYVG15Wkw4bjQ3?=
 =?utf-8?B?QU1hNnhNZEZNYWdtUjJKL1U3R0ovSE1pVWJsNm1FUDlXREp4K3Qwb1ptSUR0?=
 =?utf-8?B?YVpHb0grSVkxSkEzSDVRZDRGdHo2WE56VjdLUC9KbFJLVGtyci9JSENRejkz?=
 =?utf-8?B?VW1vNC80cGZ5LzI4dmRyNnFsUnhDRkpjZDduNktMandEN1ZYdE01L1BkdThp?=
 =?utf-8?B?Kzcyd21WRG9YMEUzZVhJa3d5eGhVczhKRkpRckJCNmhESG5aT0t1N0lzTDQv?=
 =?utf-8?B?UXFpR09jemNGbkhpbnNGRWVIZ0FKUzBZZ05DaThVbGgxWXlwK1c3S2Zmbmhs?=
 =?utf-8?B?Szl2UmdlN0tQZVBicmdndzlTQ2QweVlTT2k5NElnN0tDTmd2K1NOOGFrY1Jk?=
 =?utf-8?B?UGVSQ2NCTThIRGk5dVhqbkMxbHUzZkdONGZ5NGlCZUpFNDdKQ3dSYnhrVWkr?=
 =?utf-8?B?K09YaW56bVY5Zng2ZW9wNTU1ZnA3MjdnL2xJNWE4cEliOGNwOXllblRPTDJL?=
 =?utf-8?B?WXhpZmE3SDl3OHJJTE5PR2pGMWNIYXdYWjVDMUZ1OWNQcDZJWk5xUzJ5V1p5?=
 =?utf-8?B?VXN1S1czT1ZoUkl6WXdRUE1aem0xK2FPc2hWM2c3NWgxODkwSHNoemJ0Vk1r?=
 =?utf-8?B?V0xISnNEWVd2SjVRTFh3eGVNcW5HVnNjSzJzMUtKS2ZveUYvVlRPbnVjbFAy?=
 =?utf-8?B?UHZLUTVMSmVYVjF5K2pOZk1GOTJ0V29IdHRjcVVBVGQ4NEZNZ2ZkenRGa2Zq?=
 =?utf-8?B?UVlvUVpjancycklyRitxeW5pbzMzdU9vc202SzQxV3l6WXZUb3prN3hnOWFt?=
 =?utf-8?B?VFNob2pCT1dHclVqUVR1NEZnWTdlYWVrTldSZFY2UlZtQWd5MHorQVh3bzlO?=
 =?utf-8?B?OFlEcDNDU28xNTFCcnBQenR4dkJTM2NhMENSeXE5WEM2YlA0b3lPRlRYNy95?=
 =?utf-8?B?MER5cVYzTlR3azNrVEVYdW0zTzNaN0R6bnZhTW1VVnRra0NVUmRkQjRab0lv?=
 =?utf-8?B?OGhHUEJUMHJCSmsyN2wxMk5pMjU0dWw5MXU0L01BZFcvaHhpeHNpbjNKWTlG?=
 =?utf-8?B?SWJhbE1CRHpMbUtOb3d6TXBpdjZwMnIxT2xId21hQ2taQ0hvZk01T3JvVkpZ?=
 =?utf-8?B?ekFwODh5WFVyVTRKRnlaeXNmWDdWdXg5ZXBlZVVRalVZQU42clg4YW9mYTcr?=
 =?utf-8?B?N1pJKzBCdlNiQjg1RUE4RG5yZmFaZjlIL0c5R0xIYUN3YkZxdDVFYXF3K1M0?=
 =?utf-8?B?NDhna1libWJsWGhNY1ROZENjUjZSQmhPdHNxZGJmeDJ4MS93UkdEb3d4K3JY?=
 =?utf-8?B?Z05neFNHanlNeUdrZzMreGdIYTllZlFZeGs1YmQ3bGVaNHh2YW1IOFJaNW1p?=
 =?utf-8?B?WVF6SkR2T040M25CSXdWd1JKekRSSXRhWHhoZ0YxOFMzN0VBdGNOaGNlY2NB?=
 =?utf-8?B?YklySDlzVldUUUtzMXg5c3JXcWpLUXNlVVdVaVFab2R1eVY1UTl3eC9DWUh5?=
 =?utf-8?B?OTRvcFlHSTB2eUFhc2kvZ0k2cmlmemthMytTVWc5NGMrNmxSZlZRZkVVVytz?=
 =?utf-8?B?QjB3SE84V0s1WjJVcTlBdjIzMUtFcVprRElRTDZGVWo0U05WeUtnblJzSk54?=
 =?utf-8?B?Z2hRT05XbXF3dWZZUk1aUUpiRkorb3RraS9SSkFEejl5a1k4c0Rxa0IxSW5N?=
 =?utf-8?B?L1QzYlZDWWduZEhSTG9VWFozVXVIVlg3MmlYL1Y4cVlBWFk0QnVoODNkSHBZ?=
 =?utf-8?B?aFJheWtxblFrdmY4TVhYbHJUalZZQ0ZDK2hkQjZUdWZHY2trVG9JNVNtREcv?=
 =?utf-8?Q?ZiE0dyOvEhJpz87c=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a767d25-7d66-4c4e-2bfb-08df3da9a625
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 15:04:55.6771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns2bvcE9+tlJVnJdihv2DHQIlhtPlL1eKtSo8xWEAzb/iKjreejc66LhyLygY2fCFyKu9ynoL0BvvSfmdfwQ7C7PS7gP67bwEMkvPoceFpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB373984

On 2026-11-06 21:25, sashiko-bot@kernel.org wrote:
 > missing reset of dl_boosted in __sched_setscheduler()

For sysrq-n, this is the same bug as on patch 4, after this patch. The
v5 fix of patch 4 clears dl_boosted here.

For a boosted task that asks for SCHED_DEADLINE itself, this is older
than the series. In the base, pi_se keeps pointing to the donor in the
same case. __setscheduler_dl_pi() only acts for a policy other than
SCHED_DEADLINE. The patch keeps that behaviour, with a copy. The boost
ends at the unlock, where rt_mutex_setprio() clears it. Deciding it
again at sched_setattr() would need the task's new absolute deadline,
which only the next enqueue sets. That is a separate change.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
