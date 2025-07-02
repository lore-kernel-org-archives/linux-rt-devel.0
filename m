Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F50221543
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Jul 2025 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.3
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437749; cv=fail; b=mQ6slSGBs4XAZ1uFppixhLTlnrb5iaIogjtc1HiRLUZf3CDj1NyOenzVQHbbugcjimAAkrHxEg87h/JTW9mlSdQdgktSlxcUXME7n6GWWbOqOSl2e8Yp59GOszQh5O6XyRq3S0jL1EXH6sEUMrXKz22zsZ8fOaR8/OKGjb0MzIw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437749; c=relaxed/simple;
	bh=Wf1aN65yRBw4NSJH687lR1lt563k7ZviGLlVFwb/pLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SnCiFvflm1lu9blAcP/uUId04dKWuqwQRCz6nY8kgSHcMiqNgOkXvKR2gevECsnBh8WiRImubKtqINgiLaKRzOs9rXSh41E0mrHLIu0ApJVEU9W7f294eBLE7fSgh2icKoaw/jBPoc7cM1RCkfSryb53HWt0jJeP8pXOPJQkE8o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cSXDhWGk; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cSXDhWGk; arc=fail smtp.client-ip=52.101.84.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cSXDhWGk";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cSXDhWGk"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=O3Ekt1eyegW1HmkfzpHf5gt/a/T6lxxN1jygyL0+/n4ZuzlwBCUeECXCYBGAlHJAUSNCT635sewtpM2dAZ0dGM0iDujINHzfRZ/AX3vuHfzntrXMOeSD4JJkSo7m9GZmfo8IaPkuXyvMfFAsFleZX+OK2RPXTQawFHkVo/hLAqTLIr6rKqbyiXI0bLXBsU5IG2oQT8zpMb8D2ijpGClrphqZt2bulnRLS8vpCXekJccvW/DD4wY0RHZTjoW9YZpDdQ38hUpaOzdisdB8Rntp5W+I7Ax0PAw+OB16fOi/lp1VhXbZYknWcPKo3ij/F5ax4eU0sSeQLcTdrEq29VQvhA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R73T2HGZUtCyve4ettdgKoIcEJ4ulWSeCUy5JoNULx4=;
 b=x6/MjZOk3lEpx4ld1stdRV6IhPtO5MKBeSeKFBq9ybRFdIE4q40Z4XiGW9TTeMk6Y2kXyX/Hx5nUeI9JaWC98A+8IHTiM8U40j/aMEguEKDzFM7K/Mn3CkqSgW4cRxHfdr6ckYbY2WvMXZUuZeT1IZt4QTDbf+M2nzgh8p3vKJcMaUtdwtUo1yCVOg3UJvdoJAs/aG2AkfJ24qTL2Bm/Wy5zWv1lwW3RR5HQ3j1K9JYX1nGGdtXQF6kFDggFr7qHXlEXnmHzYRoUHPVycO6OUwbAUHKj/vk6Efst3jVvYquLxxlvGJH6KEaoFW3XodMteDzJkZ0VGU+cciwQQtQDSg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=sk.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R73T2HGZUtCyve4ettdgKoIcEJ4ulWSeCUy5JoNULx4=;
 b=cSXDhWGkmvYS7Cdx190vkN/ms4sHpNQdzJoegQtR11TH1m0ag/9bY8+1G9KWxZNIxK/hlFV6RN25TNAPBR3GbfA+FDEcd6mlBCNohppeRu2kycjWzhWV3BExOYH86BwhGLFMS/aAtHoUjtFmPGaHvuMkK/VkMAqHSokYyEWCyUs=
Received: from CWLP123CA0259.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::7)
 by DB9PR08MB6506.eurprd08.prod.outlook.com (2603:10a6:10:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 06:29:01 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::f7) by CWLP123CA0259.outlook.office365.com
 (2603:10a6:400:1d5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 06:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20
 via Frontend Transport; Wed, 2 Jul 2025 06:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvz6x3FDcUNRq2E/5D+G044LOtIEhDJmlBN2zEf9IDkTzB8xldbbLT4yHrq8cvqqfL9/4K5n76lM8eJj9QDcLllWkExRu2MkxO6fC31kSXU2A8ChIXw3lHvNUCDE3gsCdcd3HI4lMUjA/rJBfXnHGvnjipliY1TeifpL8Z2LqrvfnuL6SMSfFpMb5M6v7FnCfLGazwKmTy9szdCOiGiYFqyWZNuEXusvgO9qI6Ntr37UyLUX1dC/+4hFeDH+gFRa5inLM7IkXDN01B/goGqxcZ5ZwA7FGjc5PoxKOwmhPi5F15fx+DHZV+rhqNJd52+XP+b+rLlQK9d/iANudfGQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R73T2HGZUtCyve4ettdgKoIcEJ4ulWSeCUy5JoNULx4=;
 b=HCbnJMdeY8yuu9G/O4ZvzuKU444qQ7OOPtJEIkbv2Sbm+CwcFEP2jzhWOWpTSKN2UUCejey8MpomdKbZuIDv15Oy1tW3gooyaSV+TOmd/z6cC/cTEAeJpb1KKNYt6NvDzU2on3TZcJmaHEG7fPcgB9fE9NbqTwigvq21tGZ2qsQLqMsJU5PVPBtoLRg6dKVlAUFKo3zYj73ioNWvpJmLeY9uJVSaPSTo+QxfU0CyaKaY6cone2fLW/wbA8WxwKPT7DgLv2MEG2mWjBZMtHY70ssBX7ZRY8ENl1MteT8WkbA4krUoq7JXi/ARhlny6RICLIwSWGyxG7UI8Goc8E7hTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R73T2HGZUtCyve4ettdgKoIcEJ4ulWSeCUy5JoNULx4=;
 b=cSXDhWGkmvYS7Cdx190vkN/ms4sHpNQdzJoegQtR11TH1m0ag/9bY8+1G9KWxZNIxK/hlFV6RN25TNAPBR3GbfA+FDEcd6mlBCNohppeRu2kycjWzhWV3BExOYH86BwhGLFMS/aAtHoUjtFmPGaHvuMkK/VkMAqHSokYyEWCyUs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB7988.eurprd08.prod.outlook.com
 (2603:10a6:150:9c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 06:28:24 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 06:28:24 +0000
Date: Wed, 2 Jul 2025 07:28:21 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Byungchul Park <byungchul@sk.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	kpm@linux-foundation.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	max.byungchul.park@gmail.com, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, nd@arm.com,
	Yunseong Kim <ysk@kzalloc.com>, kernel_team@skhynix.com
Subject: Re: [PATCH] kasan: don't call find_vm_area() in in_interrupt() for
 possible deadlock
Message-ID: <aGTRhaHrkjCNb2S4@e129823.arm.com>
References: <20250701203545.216719-1-yeoreum.yun@arm.com>
 <20250702060138.GA5358@system.software.com>
 <20250702060949.GB5358@system.software.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702060949.GB5358@system.software.com>
X-ClientProxiedBy: LO4P123CA0379.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB7988:EE_|AM4PEPF00027A5D:EE_|DB9PR08MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f1812d-0108-4e59-2047-08ddb931bb5d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?KdRB3W+Plht+7PeEdqxp/P/fwz/MxTh2odYDC7o/AXFRj94LWO3+20s1ZHSx?=
 =?us-ascii?Q?pxFvDnm02r6pmWY83TWhZ2reDix19JE+YLlCa/gS5y9vBgaVODBSsdh6GeVh?=
 =?us-ascii?Q?hEynPueJ3eQTh9q7ZiMNnv54gzqKGOW9NyI5VK7piE6wvdZoCVuyz3hLzsf5?=
 =?us-ascii?Q?Ut/Ns8JumT1yd2Bp0EFcDt9njYsEHwGrNwfX9HUo58qHb8KuTQbDA0bZiPbi?=
 =?us-ascii?Q?OiGgDJAzoF6ZA+VCBbqyhfrW3S4/LQCuOavXVNRyW5oLwrQjvX8n/j7TSEu/?=
 =?us-ascii?Q?Ls3/cY4eJpWm7+bfpJgXxxU4onBmbeq1mbwD33eyp9fE/PT3DhvYoZ09qaP8?=
 =?us-ascii?Q?XtzxioloOKG0yuJKpob3mJn6yU1bNaySZAJ1Vy8KgBIimHxnxfax+tN5W/nI?=
 =?us-ascii?Q?tPD/jn9QDN/0JSKflHuwnPzFm5wV9EkqL9Y0JZRa7yfYxtiiGVHSXHXsfQqh?=
 =?us-ascii?Q?dfHUMBdnbUndlPg1JpI1QrPDQf1Vrf8sy34nliKGarODStZUQa8XDI0c1Dur?=
 =?us-ascii?Q?1AVZuuHQM/5+UD3T4PW0/rPLCionQk2quiRXq54tLvicI0zdLmU/DqVfNcOW?=
 =?us-ascii?Q?9sTItQgWCNIL6b75ELKgH/EcsVskiweLlDc/6ve2/Wm0b0wN3a8BDgvECZ9F?=
 =?us-ascii?Q?B0s657sB1WGmjb64/8SVzR3XrZMkORHhn7PamtPFR6UvICqd3f+AgF9j/qeL?=
 =?us-ascii?Q?5SVG+ZEkqymYv06JFurTql+CZN2VR7TzqaWD68rlgDzigOnrJWbJ+V8aHPFr?=
 =?us-ascii?Q?7Mxpf9SCp8ojU+5csH5YBVMMKAh/hp7X1xowv2ls3XDPeVzlyqRk0y6TnhMB?=
 =?us-ascii?Q?0Lc/E7dyFnWDN2XMScBh3JPI5vZsImMOzrxv/EO1bsOi/TlK/JmIgzpI41a0?=
 =?us-ascii?Q?ZNSBLpzC1RLy/YNamSlBLGWEWE7i965MTnu99mbwqrZQvQV1PfS82GUbJgtG?=
 =?us-ascii?Q?9Is9Q6CU7N5SXBLOpaUBxDPEbWAuI8NNAkRjQfcWkN8/7fM2jLaVc0pu/mmx?=
 =?us-ascii?Q?2BnbQFZSaIZP/BluQXRvD5mGf2rovcCkbe9x6iYl54qxNr5PuqQLBmc618yg?=
 =?us-ascii?Q?DKO737dgnVNFyiirDlsj2MyemPSeJ0sC9QUf9McwcdmpOGKY5ivYf87rC2jj?=
 =?us-ascii?Q?BMWDQ6n7EhVAiA85eKxkHRT0PCEjt1zWpR3v4ENU9WI11Rwv0DGYt+QFHp9k?=
 =?us-ascii?Q?VCUI1O+LJji1tU4+DX2a+gXS3aAiHITN16gKHOQtuIRF9inRJhIJH1soyHGu?=
 =?us-ascii?Q?cxRlOT8QQ5PT0a92a2wFEhr4fgTK6jcc8HxG5h7V9/M7/pM/q9R68ru71Lsh?=
 =?us-ascii?Q?XrUpULEaPNUTe9UcXd/DR7JkDZuy4xhGQOhePnspVZ5m+1DrskHyXoJaO2Fl?=
 =?us-ascii?Q?HZMq9wVFO7biUYY5lRapwZzfViossoKDPOMoWeL1Duoh1E23vD6+CQ38FEFT?=
 =?us-ascii?Q?X6tOZ6t1zps=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7988
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0f6a3e63-05b5-448a-7a56-08ddb931a5e8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|36860700013|1800799024|376014|7416014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HhRIHqqDcC5Ei6QpHG0zk7hauiC5Fr1zEMTfEe/U2RtlsLkT1vtpKau1O/+m?=
 =?us-ascii?Q?utFeMn05GJqwR0y9bhCkVOdWvxjVEJKwh1pU+vnTcZw6gitxkOrte4sAqYfo?=
 =?us-ascii?Q?7kvvNhi3SFudFmPU4m0CqFJ1j52CUZ9Z0MmEBsf8q57i41nSL1WZ2Pp2SJVi?=
 =?us-ascii?Q?lHQleAuc+q16MQwOouCrrcDFRScO76b8Eezas1UYAq73S9y4ys8gzqQh/KWy?=
 =?us-ascii?Q?pL3ZNgQb488erT23hxxOlQGsyEq4jMg+EUcfETh/Op65BbBYeis8XwxP9AYE?=
 =?us-ascii?Q?+/01IswPcezBjBWzdsinZixebQaVT2bdkdFeth2lVSb94fkkqJy+5YOUiJAM?=
 =?us-ascii?Q?TArv0OyLN2oZiJev+J22YZX71NaiJBR6g7/YTVRsbsxYfnN9s7KfCoeeG5CT?=
 =?us-ascii?Q?oQxnbQLnCWw4Z1CWZqF+hhYxN7PBuTVGvZr7Mwm5BEedvput0u9LWNdLSqu6?=
 =?us-ascii?Q?NTKKEAP2jOY99Oh2Aaz7R36RrDZDyLOA+gXAjL4Bz4FcM+sbqFz+OW3SURgO?=
 =?us-ascii?Q?Vu8TrTlcG8ff+JcKQ7usLc6VQiDKHc/xLBbQsSQfuMc5QVGPCNbLOcx10ZSM?=
 =?us-ascii?Q?Y0dv1g8UyG2x/k8x9IpenEWULPYfkdesMXUat2IX+rRO+X2X9Bmo036ZSuhJ?=
 =?us-ascii?Q?mbQPOV+IXdGR61Uz272B9M+++1lc7/RhCaXxzh9AfxsDUYD6FZKlpvrpE7UW?=
 =?us-ascii?Q?aJCgJL9+ChM5I05R30UHWEscMnhI7G7T+ubJyGz4Uwizik5s1jV5TJbsjC9j?=
 =?us-ascii?Q?lhVNyjPNZxToa0SLVJdLqUT7o3tTiOLxNglpVp6aN/Tb9/mc8vUkKInQ9MyY?=
 =?us-ascii?Q?kMlr2IspgSuOxgwrcB7WvQ2fSS9l5Bl76XvLDiGRPIRKe7QnzXwVdpE99Hap?=
 =?us-ascii?Q?Buk3e8Q+vvuajawsxjX4EszD/aZAAS4YZ3aWaWnmGgYUiAVoFIwUfICKdE6o?=
 =?us-ascii?Q?yrSLvD0RwphrS/7DYflVqSaDYj8+QgrwLwFucj9czqBx1EJSUzyMTfprWIg+?=
 =?us-ascii?Q?gnkNbTht6G1nFqvMhjwpuCUreGfry3cC+98k7S/kg4mOiEhTZtDsnrZJK48l?=
 =?us-ascii?Q?HwD98USuSVyKDfhiMgq/UoHEgqmSJn7FRT4UtFT80Q4qwmViIKacu7IEhNeS?=
 =?us-ascii?Q?3wWVyd5DiHM3yoY4ppofJg1FwdoYDpjRoak8SaLzTI5lCG7DaIGIb9ziIUPY?=
 =?us-ascii?Q?ljnelNpgst73YNluzEQYFWVF9Z6bTt7tf2+aQDwyTg/pkqdyGUX9umBWYkrr?=
 =?us-ascii?Q?6qJ+gQvC2M2fs3hmfx8G/JIFuV/X3B3plhMkBzjwN1CdTpBjIPsJIPg+pGnf?=
 =?us-ascii?Q?y3d5U/UVqICrUZF48JR9wg/k6AtWKAyvDdgTHRGzG+RQl207QgxevoUkyYOU?=
 =?us-ascii?Q?g+yEq7oxQV4JSpgU9Kv6tZeDle9CU4T0Ehz4Vfuu6FSZbWLS/7pjY+8f8F2S?=
 =?us-ascii?Q?Ut39/maiDC7iDWdShqlCp19AaGUYIjY0Nfydzg19xHEEtXEO/lGXiXUlBeFf?=
 =?us-ascii?Q?JGNmxQHlCi9CwMaayBFThZx64lsZYX8SXkGs?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(36860700013)(1800799024)(376014)(7416014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 06:29:00.3483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f1812d-0108-4e59-2047-08ddb931bb5d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6506

Hi Byungchul,

> > >
> > > CPU0                                CPU1
> > > vmalloc();
> > >  alloc_vmap_area();
> > >   spin_lock(&vn->busy.lock)
> > 			^
> > 	Here, it should be spin_lock_bh(&vn->busy.lock).
>
> spin_lock_irqsave(&vn->busy.lock) might be even better, assuming
> find_vm_area() could be called with a critcal section of *_irq() or
> something.

Agree for this change and I also thought about it.
But, I'm not sure changing to spin_lock_irqsave() is *better*
since it makes a unexpected schedule delay whenever
vmalloc_info_show() is called via proc.

Also, I think the find_vm_area() is designed for task context not
for atomic context. so it seems the misusage in the kasan.

Am I missing something?

Thanks.

--
Sincerely,
Yeoreum Yun
