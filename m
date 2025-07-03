Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E425A2C6
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Jul 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566109; cv=fail; b=gwtzwhCO2p6zGsoWNf9g/tViVoYQ8KefIrPDGB0Sj1rAibUWK38CkY6Dcf3QNnb3Le0pLwZLgUPurXtTJRGxaGh7vPP6t/hV4jPiTHSuob9Ew7d73pr0C9o9lCTEZlkFu0a0uuiH+9w7fpigk0M3MYX0Minomweg2TAMV9JMUyI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566109; c=relaxed/simple;
	bh=GfQm5INwvKKhPq7UKRt5Y/IAkHMON7DXdeVJlvcwsgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gf6WNNeCB/jUc+EvG24+tC3fpup+/xYds2vO9QImAldN1kFx62hNCZDky6x62l9PhtqqRl+kFRBOmUeyupsIEP6vG7Pn0Y6a+LEGR3Nf9E/YVyepAFB9Zz5wqW+Gy2C8Bmh0aXOdjot/lzkk1+8ZpvSdFfVsHs1jmC8Lw9cFHq0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q+6kFMqG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q+6kFMqG; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q+6kFMqG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q+6kFMqG"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yfFKma3lgbWU7E4xlCUX0Mcy2ja9Vr5mT6ozOs1CwyqcfESsOoc3egClqXXB5/bLRrUy45E3HGZ4temgAcU/18aOSTCnfXYvW2wkl5APaLBMy1sT2tPbZ827mAS0Ur2aD1UX4MK8GatWWlSxJ8J7Az4u0uEaYAxtHhbr2DiVZ3e2bnBX/5pFw/owCyxMWewjjDjM94eVOpMogAOeCOE5fhro4aJUn5Zdu9SBfNoQimlSpKSdPrvtWnqGIZBIlNIYcVWS/rZ9YkrI3eBI0DKbhBqDCOFOBwSYeOmxRusKYlUEnzopqsgt/EJMXdAV+C4kX5CMTG2L0WqyNNJhzZBikw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfQm5INwvKKhPq7UKRt5Y/IAkHMON7DXdeVJlvcwsgM=;
 b=pHQSIVtLN25XgdSAw2FFMKWXn1mk0wINGmJ/Y0mlBjTYBKSeWpqtGQJlJlublo1vq2cyw4u913h6Xgg4J/bY7todrvOkSA9qUaiHZNln+z7ZjEuaUOTNsvQ0ZZ/plJBLsIL9koIj7Y4y9cCwjWv+hr9nrmF4DNo9M1kmjCKQQ4G0AI59m/ucRMsFPNCGncpXMdSUcJ7nxZ1wJDzANpAfTXt1HTAwbaRv/lSmia3Js5hZprNOcKUprBnmB1Mab8cP8RODOMF8kWvXIkCJy3AejextSdEkBIB80HvH0WcGWYKO+AlV35g6JJsNJF3F33bLXyRk7xYrjMstZHMaTFTizQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfQm5INwvKKhPq7UKRt5Y/IAkHMON7DXdeVJlvcwsgM=;
 b=Q+6kFMqGAi9Nf0rUE4FEOvdBciBygl8rMJyWWjihaxU7tiKrWpCfX7uj5VGfArC3jl8R8VrPmWbXbK+fokSQGl3EZwpAMl0afPCW9brmEWKXsI0X28Zol7x+XCAlmJUgxYI7L+fyhVF5cdrjhVgARQLtaUJba2bC6FHO7GHCpAA=
Received: from DUZP191CA0053.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::21)
 by DU2PR08MB10301.eurprd08.prod.outlook.com (2603:10a6:10:494::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 18:08:22 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::b3) by DUZP191CA0053.outlook.office365.com
 (2603:10a6:10:4fa::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Thu,
 3 Jul 2025 18:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 18:08:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3c1pvEPRI2CjBqVI6CaWITmEBbKXdNjjqgga1LGMLU4UPJxbM18ciz9Gx54fOD9Z+Ly42bS8hRujTc2bSVTArPdPom6d3jJRt/5WL9OeTBcyvnLrSn8HRVB98dE257RfXkQN4dNn40RpMcxq1jnzfYQFDfeywf1FX/+Z2t7almr+HHQZgu3ZpyguYmCi0OgyX8s5ROJz4Pt+GRji7Yq67Os5VHtS4aB70N5xKmlwz1UQpHD7Aw+efZpb2+Gj8J5ziip9h1R/xMpzVu0vgYTxWim1nzxxuCUa/DhcGg8gwgq/JbORSDISPRHqIcRddNGH/1PbKfFF4M8q2YgVYjakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfQm5INwvKKhPq7UKRt5Y/IAkHMON7DXdeVJlvcwsgM=;
 b=Farv5SXiOlqLuk9WcYHPnG/MSw3AT+dSX0YTfSnzn5ZCGmhg1kIMwMmZnfIMu35sy7ml66aDjoF0WTrWHZZhV/+2EEHVW+SSsU1aII86UF369MUDOLlUWPVhIwskCRf31PKP3bADOXT23Gz4HtHSKH4OR1BoK/rQoNo//+Pb3unHuKHf+1v7uCDjxDspMWFNPmdvrLfZRosATf7OQj3xC6d/vBjqS5QyujrQ/E0YQHI0aYp/ioESIq2lz3fz7KccZ4K2SJ4a5tkha1Fos3EjxqAeOhABRs20sBTO3QprQjoyzAzDnPtGNySTo95raSM4B01yVFgJ8uQzrZFO/LkRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfQm5INwvKKhPq7UKRt5Y/IAkHMON7DXdeVJlvcwsgM=;
 b=Q+6kFMqGAi9Nf0rUE4FEOvdBciBygl8rMJyWWjihaxU7tiKrWpCfX7uj5VGfArC3jl8R8VrPmWbXbK+fokSQGl3EZwpAMl0afPCW9brmEWKXsI0X28Zol7x+XCAlmJUgxYI7L+fyhVF5cdrjhVgARQLtaUJba2bC6FHO7GHCpAA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAWPR08MB10117.eurprd08.prod.outlook.com
 (2603:10a6:102:361::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Thu, 3 Jul
 2025 18:07:47 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 18:07:47 +0000
Date: Thu, 3 Jul 2025 19:07:44 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, akpm@linux-foundation.org,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	byungchul@sk.com, max.byungchul.park@gmail.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Yunseong Kim <ysk@kzalloc.com>
Subject: Re: [PATCH] kasan: don't call find_vm_area() in in_interrupt() for
 possible deadlock
Message-ID: <aGbG8BIafyR8C0ch@e129823.arm.com>
References: <20250701203545.216719-1-yeoreum.yun@arm.com>
 <4599f645-f79c-4cce-b686-494428bb9e2a@gmail.com>
 <aGVYoEueYjoC1hQh@e129823.arm.com>
 <1a7f32a8-16ff-406c-9542-8d2ad628d7f4@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7f32a8-16ff-406c-9542-8d2ad628d7f4@gmail.com>
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAWPR08MB10117:EE_|DU6PEPF0000B61C:EE_|DU2PR08MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e574e5b-bdd7-4c1e-d6b1-08ddba5c992b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Bsj2lISUkuoIF3Orco7Q8U5jZk7c0xZiTNTu1lDIG5+WRKPGJsXyRoqiNJex?=
 =?us-ascii?Q?6yc9hMiKUr7KvZWAEpJnLfTCuk0gvRaVHY+va5AatiU9KsLquUaFDjtUx4To?=
 =?us-ascii?Q?vahiNgPrkI2jPHcPvn/ZjG3IQLYGtxYprd1ahbZm8kTp19pCy2qPOyugqx4R?=
 =?us-ascii?Q?90WOX8N2xAiiIht08Os7M2tlZ4HQdi/cbJgh9A1mwHDtLPZP9ABUcViUMGBw?=
 =?us-ascii?Q?zA47YgUNqoDDAh3PIDkz1sjU38SddQUM8ptizOdGyX1CYlGK4fqLeU/+tRBW?=
 =?us-ascii?Q?zWh80XfEqjLzh8Mnj/jboeamvk1dUz323UnZFSLo2T+NdSfuAMsJWLDrPd0C?=
 =?us-ascii?Q?HFHCQ9o3VoRigUFw/57Cnw2k0ohUxVJzDVUT+iCuE6bdGIcpqfL50dV+DfF5?=
 =?us-ascii?Q?/sDmkwvAEC9AeEHJ3Rcvuui3drgCC6NlGPC8hl87+PhyZ/UEZfgc2ZChhp5y?=
 =?us-ascii?Q?LNsbtEW43Zg4CS4FvGrBGSpztx8s8/BB8mwa7pBhR/JLJIySO/C0nXQ1voVF?=
 =?us-ascii?Q?SC/vd0D7uBrhe4BVK83kpOy5SMp5vQo8CcYPiNP6cydc+132sIuAH+iQCaxu?=
 =?us-ascii?Q?daCAHicKCKw8W+k8bLopR9U5hREMI8JreNM9z00j36Mx2VjrMHX9EVoQqrfH?=
 =?us-ascii?Q?uG8lA1XGDbb+l1tCl0sBur8XZBUOx520yMAEFbk0KnVXzFMy3QN3FmwsH4+4?=
 =?us-ascii?Q?uJXZBeDeG0+yvKFheif/bYdiKbgXL+ZHpKJFvG6xZuygTLySnYd/Z8Lr5y4X?=
 =?us-ascii?Q?tCUdXdYiGI/R+7yEnb+LRlh/kOEKhGJCSgVnY5oeYXqzNgs30k+Zsx+cwK5L?=
 =?us-ascii?Q?yCQhNhkMbwu+vXNWiKw1I3DsuE/f1icP+v+LipMB0uFScWQwwIzuk9JW6iTP?=
 =?us-ascii?Q?ieCWNWEIzbLf5+Rx69TPFyGtiH91qBpr0hNl6RH4o0mexJOh1Ln7m1T8Lojz?=
 =?us-ascii?Q?P0pynnhu/PAheleuM8X1hT/SG8ROgO/uPNp1wHS6lqMFzxkTlibKD3opBREV?=
 =?us-ascii?Q?Li7V2N5cGnHJt6sOEaa3qycws9OUazH1Sgg75OmpUM+M37Imm6kFe3TT7Lh+?=
 =?us-ascii?Q?437EAdHS53AibC6aaht/KgJmP7OoU1ZTqWb24F46R1dxPGx9HdbBkHH5ROIe?=
 =?us-ascii?Q?8uBAYursBti+Wn4HhAMQi2zpx2IRzW1sN19CdtsaSCoIPnYJSwUrr1Ah4bpi?=
 =?us-ascii?Q?RaCO8+30KqTggM/TixuVUZ/qNDqnBgTDDmqKz4R6Bc0+SqHr0bXyblBqwhYn?=
 =?us-ascii?Q?Z8V4qL02OH4R3BwXwxEgPAcsrqxtLiqohq34o9NErBiqzwsq6UzUWtx7/LXl?=
 =?us-ascii?Q?vGMc+a+6s8+zg9X4z47hHgGqwGV3toZipQQCANW3881ieJRg/5DP4fN4Ho7R?=
 =?us-ascii?Q?CSlrTK+nT2LqKxffy4Mx2f/fnLLDmpTFQORgSLaeOqmr3jGP1xHtU/YK93G5?=
 =?us-ascii?Q?h9IUtXnbw2I=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10117
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8be53bd2-635b-4b42-df6b-08ddba5c83b7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|35042699022|82310400026|36860700013|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GrFCw8m7vy88rjAwBc2NVP/pWd2LrM8zseG21DkQLzDzsAjmnQrcPZnePlVI?=
 =?us-ascii?Q?9FurgBqKQpMjEzRkspduK7gV5i2mFc/6bEh0Zp2dCke+f4Al97FvPdMYOEjn?=
 =?us-ascii?Q?z8wrRXA+mHIFsbEpH63TdMprCX5kDxTcjnc+Hq39zhxMaHnsBiGntMX8GDbe?=
 =?us-ascii?Q?aSUjgw5UNcxpQbrG5IwR3FGrLcxH+0F6gyfDRGFBFiHAhZOqT4iiXsRuU10R?=
 =?us-ascii?Q?AV7jQBozZhlxA0dyJDbufVfrA3lg6fZ56JxfxtuHTN5gdgPPA/hpexpFXXia?=
 =?us-ascii?Q?W+ikAecja7QDviirhDV1gPlB2v4p2ZITerwg3dYa27WJ8AK+N7upZQhRzrbY?=
 =?us-ascii?Q?nFxPcPqXXsjGLp18Xl4s9hP/I08tnW353c4S5b1MuIcmy+XhSvTClT4rhmQv?=
 =?us-ascii?Q?DB0N7oEUHvtUI7VvlrlqME6yJWopy7S7/sjqKP/Dj2ytN2Ylwma+Uobaaeag?=
 =?us-ascii?Q?Soh5B75RmpofZNOnUjb7+s0c+t/i9E1HuoZYrJpTQ6/k8bBAalBPKSTm5SyV?=
 =?us-ascii?Q?u9ar6ZD8ehhJxICTIvNz2E6pz4s24IW+jAHyA1rY60zj8kzV/wgS7v0fp86e?=
 =?us-ascii?Q?KiPKpi9v/hEQyNpLYarmZtCWsTopYNflGWZ9gjVobOYNPfHCoQid05nLwg1f?=
 =?us-ascii?Q?e3pV7VejNHTj+mlV1xfIz9QD6Xg2itA7FCmkrWn01CiFiebf2QS/TiZBDK5L?=
 =?us-ascii?Q?qsNu3UHS20Ca02SJ4TYKojerU/IU3ZvG6VokLIHicOmxOGIAlhXeN6yCTd9z?=
 =?us-ascii?Q?C8TZwGvAV5qHNfihfTBOiEB9msywJKcFmjJzzMtHzFhhfbJ7W74Dcy8c80Jt?=
 =?us-ascii?Q?6As5SJfQHXvo149r3lAax164mxguieEsCD15XDTGvVA1aJ4PygLuOIus19ys?=
 =?us-ascii?Q?PpK/Rd0JY2+dqLlIEVaeXMXTsoPLwaby1Y3iejM2eum/2KLyLZxvOCRynR5l?=
 =?us-ascii?Q?4E7Li9iYjzBmKagkuSuRslg5ZD6q89Stqwux6/uR4EeQygLJy3UcrUU4iRK5?=
 =?us-ascii?Q?o+ef7xNlDcCMoVZsonnOqYf4qg5UTIct6nvksMTXdU/WqgcTQxdRbAxXJmrJ?=
 =?us-ascii?Q?zOVERhn78mIfDjnh3bpsOUpp9dgNi4Ao6sumNZyz0ul0Unl4Kx0G/Ur2/97E?=
 =?us-ascii?Q?KY1GN1s2ofr1a6esItdpoVKtSIzRXbLhS7s6+mTj//VYpR2YCV2SAvv27Xfw?=
 =?us-ascii?Q?CkGytFYu3iaUV2p6jbU71K1mjjcmvuQVtKt10ley2mKgPUU16YVai6J6lXQc?=
 =?us-ascii?Q?ppQftoYD7idcTDCtrvAK9ucGcHsiktqUmGG3Yju2vB6Gh6t6hoDqbtTfZhJr?=
 =?us-ascii?Q?D2rnb4CdtZBMYcHCOym7R1O1rdaSjSB3lScRClCTF6rwgUk1etsFvFOlQrGO?=
 =?us-ascii?Q?t40hni++K4zdfAx3ygoXq/WE8gW5QQESxXMZiGj/waixkdY/tvQ0eWxK8RDO?=
 =?us-ascii?Q?8ZCjox3qxZp2tWACjc5f4pzVg2I+Irjwg7AvzZCF/YhMmHxTXy+FN2cucwMH?=
 =?us-ascii?Q?A7Jf/6sgD22e5kCmmm/ey+yBiExqbFU5LKzf?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(35042699022)(82310400026)(36860700013)(1800799024)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:08:22.5054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e574e5b-bdd7-4c1e-d6b1-08ddba5c992b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10301

Hi Andrey,

> [...]
> > Right. unless there is API -- find_vm_area() with spin_trylock(),
> > kasan_find_vm_area() should be removed.
> >
> > But, I'm not sure adding the new API used only bv kasan is better then
> > just remove kasan_find_vm_area().
> >
> > Do you have any idea for this?
> >
>
> I'd say the info from vm_struct is nice to have, but it's not essential for debugging.
> It's probably not worth trying to keep it, so I'd vote for for removing kasan_find_vm_area().

Thanks for sharing. I'll respin with it.

--
Sincerely,
Yeoreum Yun
