Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442374;
	b=C8NwCegE4WrThd0dfyuEjAINCRWRvo6BMXsrU1pf5lxTKfVfwgE5kY9uycOuyXATfARC
	 O3YoSBNIhLjv5a/L/9GZb/fmRMYehyLnYIhp/GLcFS2YtjH2uySbf0a+ChRBI+oSjGWII
	 1MxlnoHVnW5g2sX1KvlaKNyElWFvXSPKg97dCVxW80goOWdDiFwmgzPTIdxn89GBJpoCN
	 1AxcOYDZOWISTvcMKjIv/nVBcw54OYxWUK7eJsAd7ZQIOpOR+TceT90Rc50p13wjUnlgT
	 u3FnZkUqSYZRSE7ECGZQomtqXc5A7yhvoQxgyolhFXkFsPVhrOPqqKqKAYT6Wrf7rDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442374;
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
	bh=ARD51YlAnVa3UCoD/aSmPpNI0RwWPeNKU0zntfjbuYE=;
	b=wmg3yixpVibvAIVz3v3oDRZu5+i4QtcnmsJmCzy2XGoB/uSOGQRsdaMhmk+ym+LE0wyy
	 DDXeDDWDo0ZghsUnPNS2h1fIi5UJdZRJJDuDYQrDogrARyy8wkEnG/BsstBJPd35jw+QM
	 1mXasUzEDiQ4jMx/7l6kx9XbbOCZ/LtjE2hLxXSUP+zSg6ZhsGRUlMmvIcZXF/NAVL9vk
	 Y+8ygaSGokQfCLFyxidYmXzPhjv4KuQe8AuWDSL3CfjB2X3f1xp/lPMmNb6/Hcf5uTJ/6
	 Aw1FiFORHXTGiTwicdAasp6K+d/OgIeb4QOOhpiBRWkJIEjw5mN8+rUQCEjKMVxVb+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=CCZvBZAN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.126
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022126.outbound.protection.outlook.com [40.107.193.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E505606A337;
	Mon, 23 Nov 2026 13:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E505606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=CCZvBZAN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NH2RcrGlpJS1Er/6KidZKCVZU/7wcKfjlWsdLJDdPdsQroKBRQZ31xQb/Plfvl8UnJA1RhQ58GpQr3BIf6hsFfsxxnr1oheGgwRlQCV8HlPAVJhbgci3dz7XYxr7GlA+xFa6DQy89Z87aDppXRDWfr0PShNt+EuTEqPRL5zkhVT9MUDp2ZnUuE6K2f85Zt6C3Xz128ZkMg5nNBpiTtR01rx2KdtrWMTJY+qixHajRCMXcbxWyyDGeEx9GLMTfYd0zhqPg8GiW3VXCE55tAMBgEV9Mhk8mT/dd8DDfCTcMAdY1iJNEPvgPmp9T8tEariWHx+a6Wxkj0tnU9rDHDNr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARD51YlAnVa3UCoD/aSmPpNI0RwWPeNKU0zntfjbuYE=;
 b=J/BkHwfqIB5PVlhGCprj1yMY6WZ2gfNMZTsBKu/gHnTtYTL2NqjNLR2bepLom7hlV4WsdbegHDmr4dfu1Q7VN4OUBzV2t9Gu8ae02wfl8b3TJIYqkvgA2Wk+gxhh4dyBYXP1hNc4Cm9cgarEy/qfe3RXnvs13D/5gQU61zNuSP/biNEtW+pHNSCOOH6sWud18M+wEvARwj+Z1hB5SRtRECKfnGNCw9kLkVyl4+tO4JtSXbqfqJHdys56QO33kS99hspsIAmjX3RjjTJjJeHvmLvMqhG6GnHifwEPct62G2DNNeyqVQjnFJAMgdy6BmHow19g7ZtWC/63BintZiixtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARD51YlAnVa3UCoD/aSmPpNI0RwWPeNKU0zntfjbuYE=;
 b=CCZvBZANGcmxi9BUyrlMScS48QuP/er0PhW008oGYX7w9ApbWpoanCziwZhsjA56Op0m5xvCHteOtBWlNRkGFMQLLdrDkbU15IMHr0Twe75rrp8ad0XI4766Gu/Tb9PGgsE6nvehtB0cfm0iElUCQnro+0LFLmEM4xgbb+NJLPiRku93UJjR7BBvIMkBzADo1mazg3Jd06INjhas3R4f6F7y1C3iDEEGm7Il8ttVpCFkzYgfe1N79l/l9B25qsCG48g3U9vHiET/RVODcg1SgUOe5f7E6bNQscjSFt2FelOqGgdfKxtOxWo5tZtH5bikCypE7DiBisC8pHZ7h+ioRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB201539.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:113::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:59:33 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:59:33 +0000
Message-ID: <641c8e32-b0da-469d-b516-22f835f42650@efficios.com>
Date: Mon, 23 Nov 2026 08:59:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 25/40] sched/deadline: Reset the donor's runtime at a
 deboost in the class
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <a16410b68dd594967dd00f2b2bd03f1ac458c1a7.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226175@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226175@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::32) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB201539:EE_
X-MS-Office365-Filtering-Correlation-Id: c5eb7c96-a720-431b-36e0-08df496a0053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	V0l80ULiBnPuz9W5GG7ZW2SDl0DFbw/oRR7ycIxZadpGuk4Ww6NIo+TR1I6Lg+zABBgtrIOWKI3vvl7iIHa62vkg1uA5oigg2zoST4pMv7swhpeoYMOLeJibODcMpB9LcPoWWNFroXTEZgH8gsesd2TpUHStL03REroMVGA6xX5KBCP1G050Fi+PCI6vmGREyDVd1NZt9w8ZDPlS5qiYQEHTMOfF2bH7RdjoB7eGNndCxEhx8p6+XUmUe4v0ZZgGyrYGSWzT/WFkqDTagozT9+ZuOEtH1/mhH3JmTpop6pY9WGfHmBJMXoMsoX3bCegM4xmb2hxvAl15OSm/oLLilZbVwedhBc6hR/Ve4HVuCB2roVJ7VRRI++g/zdo5EBT+cVPeCS3QICaCb3Lp4xw3ns/1P1ZsCSV3RvrYnxBh0lnNlF4yxH1D8DlCLawnyBnxF8Gf3OjXC8I5zKeOgTqZb4WC8LFDM6WzzGxcZcHDsw/lKytbIHJHeveF41wa0XTiX+g2l0wo2Gdjq7z0qiQlJ8BZHX0LA+3YywgKNczlmcpUi5I11///KYqDcUsbJJoosUwcRsxo3IkPLAhkZv9efHAkyOhhUXA/cywJ+FJtuMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzRrTlF0OWszZWRjeGRLc0Npbm80NjR3L0ZIWUFTWXMzV1JtTVZtWjU0V2ZD?=
 =?utf-8?B?UkNtaVBnelkwN0dDS0d2bjBFVnl6bDlsbndaQVRVQm5tRTFmaDE2TXdPalJL?=
 =?utf-8?B?TEZsN1dxclhMbWlld2pXQ3VUbkdPNVIxUXhLa01sdHVGUnhoc0h1YjNubGQr?=
 =?utf-8?B?cXZaalhPbjNMaXdGbzVjTHhGR3FtbE11RjBTOWNVbVFJN2Z2czhOSzlMUnBW?=
 =?utf-8?B?MnpaQjU0TVZVTWFYK1V2WWpNRCtKckkwcVM4ellyY0dMd01JUGlhM0RZUVV1?=
 =?utf-8?B?M0o2SWpuQUl5S0t2dTlxdlV2SVUzSkw1cUJRemhsazFNMXg1MXd0UHp6d1Z4?=
 =?utf-8?B?UFFNZURaTkdLZXV6Y1pyVHNXZnErYkM2d0x1VVU2bklhNEoyWmRieEs2NXRp?=
 =?utf-8?B?cTlBR0RUVGxhR1VySXVSZi9EVTZCNVZIQWVVUGF5aXBHN0RjcE9wL0ZpQWUw?=
 =?utf-8?B?d01iRytQMWRpa3VUcFpaVTB1eTVwcWdKc1EyL0d1aWlqU3htN2FhdUtIQ1JV?=
 =?utf-8?B?aGdSRisweWpFNXN4MWhDNUFWbm9wSTM4Q0VFQnljZnJvbFBkbHZqRlRWbm52?=
 =?utf-8?B?cC81Ukk0VVcyNm9QY2pEaklybmY1c3Fjdm1hNW1Dd2JjNHhEQ3N2dFRjNk1z?=
 =?utf-8?B?RCtQTmtUZVRoV2dZYy9vTkI0cGcva29ycVJ5clBQNWl2SXhEdjNDYS9USEpj?=
 =?utf-8?B?dS9mQXFqNmoxSnpOc3p6TEphTm42UlpocFhITHY5VGhZdXZoTzRQcjBPZVJD?=
 =?utf-8?B?TnEvaVdDSlRCazhPL2hvS0RTQmt4YnhmaVRuNWU2QjZ6SkdsOElzUy9GUnNy?=
 =?utf-8?B?ekszcTErdnBQZFJPbUx3SkNuUDRZNHA2UnF0M0NQWVArZGtGT0pGa2l1eUpv?=
 =?utf-8?B?VE1sbVhxdkUwQVd4aythOURTZGZ6WHdkNjBhMFhRemErZlpGRzZJckloZjFR?=
 =?utf-8?B?R01pQmZLNzM3U0lCeHJKZzlFR2d0Rno2MklFTm9ZYTFVWWVOb0llRDY0OUpo?=
 =?utf-8?B?V2FtY0pqVFIwUDNtY3ZJZDlEMVkyOWtKSGlYQ24vblN6ZFpSNVFmREwvOEtN?=
 =?utf-8?B?TzVRSTZFV0ZWbUVQM1BWRUNCVkhudXJEZmJFZWF3Rml2eldSK1pvVVFpWTRC?=
 =?utf-8?B?SjVwYUREOWRqWHVpSTVzaDdPbGNJN3pmVG1wOVhxNEFqVFBhQnNBWjRPVyti?=
 =?utf-8?B?TmNXRG4xelBaNG5kWVRPZ0EvZTVxblVlNjhVQk9tYTdWTlBFT00zaXBVdDZB?=
 =?utf-8?B?bExQS0NWQzRHVzRHdURHVk1oZmU4Y1I3MERBTjdYaGRVOXlCTTUwRmVDSis5?=
 =?utf-8?B?aFc2ekZDdVBydjYzYjBZN29OelltN3VZL1ZDTWo1TEpqNHdJRUxQZHpjQ2hC?=
 =?utf-8?B?bWZ4U3krdHljOFRtbEl6cDBxcUdHMVFWTExDd1JheTRsbGJ0TDhBZjlpbXdq?=
 =?utf-8?B?WXcyUUx0US9ETW5EYUJPRTdzUHVyeGUxc3BTR3BKMXRwRENHaEpKWE5qam82?=
 =?utf-8?B?SzI0MUo1RzE2enhuUXZNYVF4aUk1NVV0dU1PUVc4VEJTb1lFRGxXR3UvSHJR?=
 =?utf-8?B?aVc2M2lnM2xBbkxVVDEzUFlhTnFVczlFTFFzeDB6YXA3czVUQWRjV0JBaWow?=
 =?utf-8?B?dytGYnM3dTFFOUtBb0FyK1c5azZhTUthZlFmN2lsSHpQdXZhNjhrc0VVZ2Vh?=
 =?utf-8?B?eW9Ia0xuRUdDblNHcXdFZ1RpVEx2clhIZXpvbEs4U2R4RkJuckhpSDZ5NVBO?=
 =?utf-8?B?ZVk5STRQYXl0VXFKRWJYWEFTaWI3SHJCa1B0SnI1ajEwZi9jOFYvZTBFUld3?=
 =?utf-8?B?OGpRcjZMazdIdzY1b1pyVTVhRTc0bWJTMmNkakJoaU1MVEhKTmJWdm9aQUd4?=
 =?utf-8?B?Z1VzRVNCWjFmUWJ1WFIrLzFTTEc1RW40OUtlOHlFUDh6c09aTnM5OWxBdkxp?=
 =?utf-8?B?VGpQNW5HbEJFN05tNmppajUyb1JTQmN3MXkvc3RaWlRZb0FoUkovd1U3L3JR?=
 =?utf-8?B?WXVweGhOOWhra0lseFFmRktaalZ6RWFOeHRwVFpGTGpWZWFRY3E2bDl6UURZ?=
 =?utf-8?B?NWxpenRBSTIxaG1jalNGRmxCM3BGamxjWlA0Uno0dGMyUllQMGFTY3RKNVE3?=
 =?utf-8?B?UE0vdzhVbld0ZEZyaXhzaGtwSzVLSzY0L2diOWsrZHh0NGhzQ2QwWldFbU1T?=
 =?utf-8?B?L29ma2ZZc1Q0VFhQL3F2ejMwT3ZwL0Myejk5R1U0ajNYZTlEaG5RSmQ2Zisw?=
 =?utf-8?B?RFNEWFoxRXF1RHA0NzR6UzBGNjUzTXNpL1VDVUUyV0Izd3prOEduMVRiZDZK?=
 =?utf-8?B?VVg3UXVpZWVzSG9lbEdPYTNuamEvby9QQjZqbzdMb1VtR0FmQWdlZ3Z0dURv?=
 =?utf-8?Q?rZPhRHBg8M/DtpKE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5eb7c96-a720-431b-36e0-08df496a0053
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:59:33.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 211g33yjsjcO1s5kLGdlYwjuMBQb+Yq7dPNDnGXG8E5zDwNkTZcK0B5Z3ABGUUJbh0W015x3vpCHZMw+eey04L9GLQFYd/QQxK3Qv/8hNcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB201539

> Does starting a new period in dl_deboost() while the task is asleep cause
> a constrained-deadline task (dl_deadline < dl_period) to lose runtime or
> be throttled when it later wakes up?

Yes, by reading, for a task asleep on anything but an rt_mutex. Its
wakeup then trims the runtime of that period, or throttles it in its
gap. The task can lose part of a period. It never gains any. Moving the
period to the wakeup needs a design of its own. v11 will leave it, and
list it as a known limit.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
