Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB236D504
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983420; cv=fail; b=GIBuAcKr689rMKAUxq6N5jPLvymHn0pIw9+tbcD41uLSBy82u2dr0jV6Dd8/enU7Ql9r0BEimRwYxop7GQuA0PaeURuk1YeYV3G6RKxbbmZ4J6b1oNKjDEQp8K/E8GMiXAor9mpu2UR4g9hnaqZsmuNplj0cKmYgGhrTotMwEwM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983420; c=relaxed/simple;
	bh=Gf5ju+0fNyDeB78rxMQ/1GYp7z8Wv1pH+5GChh5R8AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I0urM9iXE9SipCNy5k6om44V5ptpnMbFxBmp8KA1m0Ki/PMnLupNA//BTt1CV2DyIlSxAbvlq4Vo+sAedoejBR4MjFufC7kcqr+AQ0WOPDJYuO97SRBlY+CiyySZUfmIzlTdeGJYbwbffkTV6XTk6H1ULQDj4OMOrdMLimqwLVE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BlyEY9hM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BlyEY9hM; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BlyEY9hM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BlyEY9hM"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=by+EsyohABTG/0c+gNCp6DeclZXheoqZVYGA6jLkDmEOk1Hz9Iu7w4rI/Im4XtdU5lLXb2FUPcBQmsfg2SLk8v0PtGL8RRE34ShquB+3GEenvSgir/mZRYpMJdnnk3TXBwy4NAL+JjtRrmu6l+IO4C7lt+nDA4l5J1d97XwfNS3s8Ic15PfN8VGTJ3auEbdaH3eamHOVKR+s2JKbHKDIkikjIkrVvofPrBQtnnlP9jo9uWSIyboSycnoC3DpSmZrMGJm+z1yhEiaWQU2MFVsXTP9N6NastbaqF7GQDq0fA8goJFbtq2FqV8+BF7fBzJSqB3TpW4F8Tf41ntgnnPHEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz8zYjljR6Wa89PjsrHl6ayVXsFqY7wXMpix9HPUqWY=;
 b=LUhceigfR5d1h7pozyVWIH3sjBCMiOViFSP8Job3Peqd5SXTmdRgFxox8OHr6OSxt4Nx1eJ7te7bzhAXzoNw/XaHkEw8YP4tafRdWIt8Rp2gQ1cWC7Ie76ueQRyR3SJ6ebf4nuCnBOGjhd/UmZZF22+qguJbcoj0LZ1nrOSq9OpdPJL67mvcWZ6Rz+HwOTWNAhv4S5BllKQTqvsV60rSa6w8zX9BBcTWqRC5d7N3+5wKTHYj3hijyghJ4ceC88bN67WuicnqyRvCyCj0n/UbQMg3kWei+U/Ol1QxNFiPeqBweCFhmMd/RECG/HaMy38E33+5cbNBh8MX0JNXoQg+/Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=os.amperecomputing.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz8zYjljR6Wa89PjsrHl6ayVXsFqY7wXMpix9HPUqWY=;
 b=BlyEY9hMv6HWq7Egi3dNGR4qlV1OINSF5nlTAxqyvFV4Tnqm3EAB8xa/61+qohEGMjCJzogQmhJYA7lBeYGOsbcCxvQfT+toandgHbBufSEHLptg8isqw6bgJNyhK5iFcwfEGyl/C6CgEyrx/jUCOmyKjj1/GSjGWaSsuA7ZQm4=
Received: from AM8P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::12)
 by PR3PR08MB5787.eurprd08.prod.outlook.com (2603:10a6:102:90::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 08:16:51 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:218:cafe::85) by AM8P189CA0007.outlook.office365.com
 (2603:10a6:20b:218::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 08:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 08:16:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXzLbyXl6WBzw9u0y4dDYFrJaVZz5wJ5OL5VzgajAya1B3dUC5ov4tDl8gStYqKMDFn7yuXnDFLRUmq6dDr5XSKJTNXcyj3kqoVWHz2LS7dGM7GTAynex8Uh14Reru2RkbkXZxlLwopBVyemvs3YCC7p/1dnvlohoSDwkC6UxJaLLcDJpBlyiFj2YTvr5NkmUhT5KqiJiFgfzcIu7OVgaSTJBBk65EtswGXU0eaYYk32jwZVfi11e2a7gvPKQoWw7HUtVDhKl+qbSXPKstTUuyow8A6RRUJy9PiiXR74A4ZvSdaVIaw2ql7gIz+rVrgJA1S1oJGeVaM0U/KTnNQYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz8zYjljR6Wa89PjsrHl6ayVXsFqY7wXMpix9HPUqWY=;
 b=vNrcFeJwc3CDmFYP92FJeN5Sp/clzNQGs9AW1tWbDjgFkLu3i+2hfFdVtlkfOrmWASyyk7kTNSnNPirGWzTN4Izx/wtxZbWApw/UXDFUHxSPCTtB/EcSk+L69Tucb/iHs6TfNZc0/HaY4LJ8HHAibX5N7B6rQlzAH6r8UjLIo8aBoS1olQw1nJOrE83KyS+JSPPC4TP5lJ69Y42NPX+XQcwuCcQUs/1Dj6/vapVo3wp61WHzL6cATOwi3bVpR/ZxdgE6gSQeeUK6xUfNIhhw+ppQJGYVOOJCaUcIwNfzkqk2cfDbzm5+60VkQ1v5XRRDWA+BbCjo+S02HfFXPwemFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz8zYjljR6Wa89PjsrHl6ayVXsFqY7wXMpix9HPUqWY=;
 b=BlyEY9hMv6HWq7Egi3dNGR4qlV1OINSF5nlTAxqyvFV4Tnqm3EAB8xa/61+qohEGMjCJzogQmhJYA7lBeYGOsbcCxvQfT+toandgHbBufSEHLptg8isqw6bgJNyhK5iFcwfEGyl/C6CgEyrx/jUCOmyKjj1/GSjGWaSsuA7ZQm4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM7PR08MB5383.eurprd08.prod.outlook.com
 (2603:10a6:20b:102::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 08:15:46 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:15:45 +0000
Date: Wed, 21 Jan 2026 08:15:42 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, catalin.marinas@arm.com,
	akpm@linux-oundation.org, david@kernel.org, kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	chaitanyas.prakash@arm.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while
 splitting the linear mapping
Message-ID: <aXCLLg8BVJ55fwqL@e129823.arm.com>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck>
 <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <5a5c78a4-0b07-4337-8b31-a2cdce1834ea@os.amperecomputing.com>
 <aXAJRx5JtTenw1Ou@e129823.arm.com>
 <2a18acfc-7de5-4ff8-bcce-14a3212cef75@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a18acfc-7de5-4ff8-bcce-14a3212cef75@os.amperecomputing.com>
X-ClientProxiedBy: LO4P123CA0153.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::14) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM7PR08MB5383:EE_|AM1PEPF000252DA:EE_|PR3PR08MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bfeabcb-9744-432a-922a-08de58c56e12
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MzN1MVNiSmtleVErdmx4Yk96dElVMGN4Vk1DdzdaRVA0NDdxb09Jb0QzeFZV?=
 =?utf-8?B?RjkrZ05vMi9zRWJrcFFLS2hrTU1Lem5vN0RReWdTMStCZ0RQR2VibGdETzRs?=
 =?utf-8?B?dWIvOW9IM2JhK2lPeVUxU1Ztbnk5SFNTdEp6cjd5TVg4NnN4QUZWUU52YkNv?=
 =?utf-8?B?K1VZb2xFUzBpcTVCUGlIOVhkNkhBbWVaVEpQeDNtQUp4VTVRdkZIN2FyblNF?=
 =?utf-8?B?aEhITllZVExNNkNKVzkxeUhxamNVM0s2V2p6cmFJdGFCSENXdEo1bTVMZVky?=
 =?utf-8?B?bTVyQ0pJRzRqUHhuMmYzaXdmeEZET0hzUzRnQXZsMHdFSnRpMUdPL0hGVGtn?=
 =?utf-8?B?ZDh6c2ZGV1ZGR1djL0krVkVLVTEyTVpuMFFRSzI5RVpXbitxbzF4eE4vbDQr?=
 =?utf-8?B?TXFBMVJBWGRPc2JieHJXNmtHa0drdnJURVlKVmtpbXJ6WE1KYS9FQVp6Vk54?=
 =?utf-8?B?cVllaGQyUE9jQzl3YXc1ZHZKWEYvVGo4dHB2QjJxa1E5RituM1BXaDFIWU1H?=
 =?utf-8?B?bk5ZZlZlTjhubXJZcHNQdnRLUlA5R054bXEvUmU0VUtFbzJlNXNLeFgxYysy?=
 =?utf-8?B?Z0RieEpTQ3NKNDNoLzlzbGNIVVA0NENITWZ2aHJQMmp6dGIyaGZ2VkdnbXFj?=
 =?utf-8?B?aW9oT2VIR0l5d2lmajJJM3ZwTzFoTTVQMzNXOVVsQXZxRXU3ekFld3FRdHZ5?=
 =?utf-8?B?aDA4cDB1VWNWMUUrQkdOREJWZnlXZFlFQTFjK1FTalZaN1pZa1FFdTE1RFR6?=
 =?utf-8?B?d1dPeHlaMWp3VlNLckNyT0tmNEx2UFJDaFgrbzFacmp1SXRqUjRGWmM3MU40?=
 =?utf-8?B?ZktjTkJwejlQa0pOUStkYkdpanJyRkZIVEdhZU1xaWk0MGJlUDExVUVjZDdJ?=
 =?utf-8?B?ckNWZXdGbWFPMEZvczJQRnFoZDRETUNGcHVubVV2UTV5eXFLNWs1Qnk5TjIz?=
 =?utf-8?B?Zk1VWkJoVlF6RFdrdVJzL21haWFXbGVqYzhBSVVTWEVadHRKb0ZiUlY3ek5k?=
 =?utf-8?B?VmJVSVdha2RDWXdUeFc4c1lLM1B4S1hrQ3NVMG1remwyTFUzUk1iRDE0RFhP?=
 =?utf-8?B?WHdQdk5XeXFxbVc5NTNoT1p1eGwrbHVZeDJxejNZUE16Ukx3SWNjUXV0OEtD?=
 =?utf-8?B?MzhHdlJVdi9LeVRacWFXdWhoaHcvcDI2MTJZeHF4Vlh1bXFxK1FqcWo1bWY4?=
 =?utf-8?B?M25LK3dzR2M5bmpLWTlrU0MrV1V1ZG9oeCsyOVlJbmxtY1Zkd2VUempXbWhL?=
 =?utf-8?B?SVVnUlpNemlTQ2ZPQi80bXlvMTFvZVpYaGtEeVlNYU9OcXZqVWFVUlJFamZJ?=
 =?utf-8?B?SnkwODFBRklXdTFQMTFCSzlZNVJyV0JZV3Q3b0plUU1vS1dCOTlUQ21lZVdS?=
 =?utf-8?B?NmxjZUxBWEpEK3UyNE5DSmJUQWszZ21nR09Oa0xGK2VtT1hZZDBTTURlMXFs?=
 =?utf-8?B?TCtPRXNRVlNzWTlOUmd6WEVyTVU0VGhtVDhENVZvUzI0MWtya1VBbzMwbm53?=
 =?utf-8?B?Sk5GVEtpdmx5UllsU0x1a0pENmprc25IOUd4RGh2RmNTUzRqUys3ODlOcThJ?=
 =?utf-8?B?QXN4UGdSdGdlTlg4a0ozMjdBMFdRc3RUenZuSjBHeUQxSDNaUGtrNHoweVkv?=
 =?utf-8?B?b1BUUTdKMHFJWTNJcllOVDFhRzU4TEtDYWlqTFdKWE9WbDMrTHhKdWlkOTNV?=
 =?utf-8?B?QlNPcVFHOFcwN3dsTlhUSko0bmU0L1lTUnJ6SExIeHFvNzJrU3hTYVk3VkdB?=
 =?utf-8?B?L2M1OWdCMjMrdDB3MldDNnEvMUkwdnNHcjdIWFVIQUMvU09IM2cwM0JZdWhJ?=
 =?utf-8?B?cVNFVTMwd2tWeEJaenJydEh3WFdYRXlYZ0hYcmRCQjZPckEwQWtLcXZkbGZl?=
 =?utf-8?B?RDJDSStHUThFSmFPc0tJeklhclAzM1dwaGtncWdrb3RwREovVHFnOGljZ0pr?=
 =?utf-8?B?QWE3bE04V3BmOW1TS084T1BDbFRCVkw1WmlwNG0rSklBTWpqUndTb3ZpOFdw?=
 =?utf-8?B?MVQxOGZUQU05aHN6aFNNZmNGYTNlTjNhNkpXTTJnWDgvT2ZQMkJyTGgySmlp?=
 =?utf-8?B?R05pa0Y5NTNkdVoraStRamhGVW5RelhSU1dyTldXZGwwUWpGV1ZXclI0Q3JI?=
 =?utf-8?Q?V0Oo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9cbc790d-acab-45fe-73bd-08de58c546e9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|14060799003|36860700013|35042699022|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUxma01ISEhHTEFrWnZCb0o3anljRFNHQTArWGVXTWhrRzA3aHY1bWxOWms3?=
 =?utf-8?B?RURES0VNVWx1b1pMZ3NwQkVWN2tJR2tCQW1CTWtZaFROVm9rSkZ0WXFQUFg1?=
 =?utf-8?B?ZXdteUFCbVFOM0NNclVId2IzM2VHaEZkVE1vL3JGdzZyMGMrajgzQ2s0a2E0?=
 =?utf-8?B?Y25NTlcyLzZKb1JENWVtNGhmQ3V4WDB1TE1xU09zK211QXpZbjdYMHFOc0Q1?=
 =?utf-8?B?MkdYc0tWN2pyQjJ1eUkwOEZMNmMvNzFDa0NCalczK0NDV0RPQlJlZThNWlM0?=
 =?utf-8?B?KytqM1I3NnZCZW9YQkwvbU1uaStLaUJISFpaNy84K015dFIvelhPb2hJbUha?=
 =?utf-8?B?MWlOL3h0ekZNZUkvUzBCSDl6ci9wbm95S09KcFRNeEdIYlJFNWpoWVpGb3Ux?=
 =?utf-8?B?YTlLeWZpLzdiamo3QkJ0eExseDlSQjY5bVRQYUFmSTQ2a1F1bFY1NmRvOW5w?=
 =?utf-8?B?TklQck1WcjcxOTB3K1ZlVlFtbEQ3MTJHSU81R2hpb3lidmdSenpuay9LRHBL?=
 =?utf-8?B?a3RjbG4wRjZLaHIvbC9pMHNQTjZvSWJCZ0I5SGtJaUUwaUFSamljM1RqQ3VJ?=
 =?utf-8?B?UzJybHVWZFlUZGl2U2hxSDBLaS9mK1hocUVPa0l4YmZXL0ZKcE1KYlAwbGt4?=
 =?utf-8?B?MUhPNTNoR0F5a3dXVW14M3N1VEVtcEFNaktaaFV5UEY5U01XeEJVMjVvY0Fr?=
 =?utf-8?B?STA2Qm5QTWsvZ3JieVhnT0JJWkdHeTJXd3V3SmZNOG1vd2FGNlJpT2FEQU90?=
 =?utf-8?B?cmJpRE00S2NibkxsYkR6TDlkL0xuYllkc1VKQkZsdmttV3NMY0VQakVza1lX?=
 =?utf-8?B?akxaSXNxUENiV20wWDF1aFVTOWw5VGFYMEwwcTlxVmRDbk1COG1YM2xiVGhw?=
 =?utf-8?B?NEJDUUpoRXRhNGZGekxnWmlwdmFEakhHTkZvQ3FnZlQ2UnJYK2F0eXdsVVBi?=
 =?utf-8?B?T1pIV2xRN1dYNUU3OTA3WWlzNzVsWEdybTl4R1B3OHhWNTEvd3c1amlQRWdz?=
 =?utf-8?B?WHIvUzQ4OWt3NE9HVkpGcUg4a2JNR3p1RWxIbXhidEFSNGhxckZXUXlwTGRw?=
 =?utf-8?B?UlFJTnRjOEdBRG5ucldma0Z2SFkzRklLZHpmUElOTVlpeWQyby9kbU5oL3lI?=
 =?utf-8?B?UVNka2V5M3gvY3dSZ3ZkbHYrTGxHdVhhN1NCZ3E0R2U2SEk2bVBpSEZtSDNv?=
 =?utf-8?B?YmFTNVpGOFRHUGs1RWVhdWNsTlN0R2dlSkEyWndGUGowdkVLVW1YWjhaUFRH?=
 =?utf-8?B?ZGlsaEFaVFJ3blNab1BvSk9JSFFKME9mSVZJTVE4ZFpLSmEzQlgyN2dTbVkz?=
 =?utf-8?B?ZVZKNzRYUTl1MEo4NWZBMmY0TFZsUkZCUEFtK1NBdGtWbkhUTmFVVFpHZ2VM?=
 =?utf-8?B?d3dneGVnTDFmbDZ0STQ0aEd4dm5yOUJOMFdrbHB5SzZSRDB3RjY3N3VJQ1JN?=
 =?utf-8?B?ZjJYU2hoREk5MmJGc3gxSk9hd0pUOURKenU0TGlFUHJvekIvRHBFZ2ptdmZZ?=
 =?utf-8?B?blhQN0NiQ2VQeXZFVmpwaWMvcmNLVk1DU2dWRmhDMjN3QlNlRkd4bm9LQnUz?=
 =?utf-8?B?M1dOSm1qaCtOZ3ZES1Z5Z0U4MWkyMEc3NmtOMzRwdlZXbUhKeWlsSUozcmxu?=
 =?utf-8?B?Y2VWLzl0bUhhYVZZSjROM2dEbXU0VlNoaGIvZmV1alVKcnNTS3NoSnpLak8r?=
 =?utf-8?B?eXk0cStKN1ZPSDF3c0E0VmY4UlQ3NjVkYVdnL0Q1TG5yS0NOUlZPM3A1Zms3?=
 =?utf-8?B?bzhrYm14b2dvS0pMRTd4a1JuL05oWVdhNmVOMm91UUFDc04rdERVL0RDdWZo?=
 =?utf-8?B?K2xPS0VQZ1RXNzRONmxoS3lhWnZ2YzdHam5McDZaQ3lVZERGL0F3d1d2K2tW?=
 =?utf-8?B?b1YrWWMyUzdoTVlIUXVIM0E0MzRTbUlYMUx0MEo3R1JFdXpIOFpqaGx2ZkFO?=
 =?utf-8?B?SjNIbkpGZmRWUTRzWEsvN1d6UVpvcU4rM0VOSlI0SlhTdElUdlhLaU05S1R2?=
 =?utf-8?B?Rm0xSWVUR2svbzQycGlObjdpcVhPUmlJSlorRkJOcnNDeHdGYWljbkJMYUpF?=
 =?utf-8?B?Y3YyNGF3UUwrY0lJZ2dNdVZTZnVNT3cwckdmaUhBMVZBRHNHSi90YVorTW9K?=
 =?utf-8?B?QlF6ZkhSd3BCUnNYYjVNa3h2azRwQno3NSt6c0FrbnZ6aUJpNzBURkR4VHVm?=
 =?utf-8?B?ajdNKzlJV2UxZllLblFIbzBYY3EyMHdkZ2V2U0NrU3hCd1ErZ0pQcEwxVUhG?=
 =?utf-8?B?bUZHbDVSZHppODhxTldzYmlQL1p3PT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(14060799003)(36860700013)(35042699022)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 08:16:51.0756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfeabcb-9744-432a-922a-08de58c56e12
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5787

Hi Yang,
>
>
> On 1/20/26 3:01 PM, Yeoreum Yun wrote:
> > Hi Yang,
> > >
> > > On 1/20/26 1:29 AM, Yeoreum Yun wrote:
> > > > Hi Ryan
> > > > > On 19/01/2026 21:24, Yeoreum Yun wrote:
> > > > > > Hi Will,
> > > > > >
> > > > > > > On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
> > > > > > > > +static int __init linear_map_prealloc_split_pgtables(void)
> > > > > > > > +{
> > > > > > > > +	int ret, i;
> > > > > > > > +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> > > > > > > > +	unsigned long lend = PAGE_END;
> > > > > > > > +	unsigned long kstart = (unsigned long)lm_alias(_stext);
> > > > > > > > +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
> > > > > > > > +
> > > > > > > > +	const struct mm_walk_ops collect_to_split_ops = {
> > > > > > > > +		.pud_entry	= collect_to_split_pud_entry,
> > > > > > > > +		.pmd_entry	= collect_to_split_pmd_entry
> > > > > > > > +	};
> > > > > > > Why do we need to rewalk the page-table here instead of collating the
> > > > > > > number of block mappings we put down when creating the linear map in
> > > > > > > the first place?
> > > > > That's a good point; perhaps we can reuse the counters that this series introduces?
> > > > >
> > > > > https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/
> > > Yeah, good point. It seems feasible to me. The patch can count how many
> > > PUD/CONT_PMD/PMD mappings, we can calculate how many page table pages need
> > > to be allocated based on those counters.
> > >
> > > > > > First, linear alias of the [_text, __init_begin) is not a target for
> > > > > > the split and it also seems strange to me to add code inside alloc_init_XXX()
> > > > > > that both checks an address range and counts to get the number of block mappings.
> > > IIUC, it should be not that hard to exclude kernel mappings. We know
> > > kernel_start and kernel_end, so you should be able to maintain a set of
> > > counters for kernel, then minus them when you do the calculation for how
> > > many page table pages need to be allocated.
> > As you said, this is not difficult. However, what I meant was that
> > this collection would be done in alloc_init_XXX(), and in that case,
> > collecting the number of block mappings for the range
> > [kernel_start, kernel_end) and adding conditional logic in
> > alloc_init_XXX() seems a bit odd.
> > That said, for potential future use cases involving splitting specific ranges,
> > I don’t think having this kind of collection is necessarily a bad idea.
>
> I'm not sure whether we are on the same page or not. IIUC the point is
> collecting the counts of PUD/CONT_PMD/PMD by re-walking page table is sub
> optimal and unnecessary for this usecase (repainting linear mapping). We can
> simply know the counts at linear mapping creation time.

What I meant was that the counts collected via dm_meminfo already
include kernel aliases, so adding separate code to
count kernel aliases again seems odd to me.
That said, I do not disagree with the efficiency of
using the already collected counts.

Thanks!

[...]

--
Sincerely,
Yeoreum Yun
