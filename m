Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579E2DEA97
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Dec 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765999468; cv=fail; b=hdLrVQWmCsBUZHXP8Ei/OvtEUbA+9jtTnGPyLKY+k5QzLXYxyBnx04TDPd0J3tZuEveQSr07a7EmLSw6scCO0zpxfEwfeZoKhraCJlMQihpjlSchYjsM+1pg1Kz5XnN9jdofjbBPeS5qt//Jll1dwdU1wMashQwQ51nblLANwHc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765999468; c=relaxed/simple;
	bh=cI8PSFcXLgpmAPdCGR9dIe6oSGAqX56uM/mu9kC4yw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=efZfZc3hZ7+Hy2/lRCP8F2NZXGKKIpA/sLCs6fyPPY5/towZ3whi0HD/2rvbM9ZNJ7haLBQ8zj6l+vezXag7uTEXVfbb5soPdBiywKQ1Jhat3dCty5mFB+Ks3WEp3vcYahs6NwtIHGvXpv67blKe0Z4t+KIhbtZH/YDEZemkcYg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sKee/ayw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sKee/ayw; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sKee/ayw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sKee/ayw"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jy8pqu5mWmV0oKG0a5xBxM/GK/ca7NFDNiERiADBfMWUPenQNAApJO3UsxlMv0Y9stuwT68KbN+kup61ZjqoSqOh1GRZeKlYltTev5DbybMS+rg4sTfqUoXdrpP3uBhe+SEpgA29NCEQD5nI0yLFYR2fdsBCy3FEYEcr86uuP8/lB5LwF66ydXut8ftsSI8ioezlfqj1IPXvOsI+eZLj1/2AfYg3VtuDu3SFffIb5ZCwjCX/piDpJnN+qp1MIhguTPUWDXodahB3f07FTt0Zbkf14cJSTanv3n6hCocVqDQDvoCcWFXrbzMXykGRqvDT9+PzTjOC71Rbr8tgdJoHIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agtZ2YTD/cWE3d6zlqciyMMiBDVxrthRYc7BwnJgRAk=;
 b=nPZgghp+d2Rmpe+3TRvndtK0Tv94oGGIUlFaglpnHW3TPyTtuqm9cejtuIdY7GZ8hyVuknFHkMjVoG6+uErJiNoyW4tZOBzFvAkzcdryyFzKt/Z9mfCFADXEDI6texs5J5VYjuMiK5ZFtGt6G2TBvPTcU0MVBNkisuZzyX3x5Xo0Mb/+vHzwB/jz+m7EpxhcR7dTExUsih5b/xaoBxnmNmayXInjRP83PNzPoyB0IhV5xDmOCrRmTBnKwZsQXdpv65PyaE4GqAiDhrlLku08eFPUqvI+JK6UCmN0yzkADB17xpZlAmLdx/ZMmJDNuhonEFwa6JcNy5/OaB6ZGmq8/w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agtZ2YTD/cWE3d6zlqciyMMiBDVxrthRYc7BwnJgRAk=;
 b=sKee/ayw37qqABGfngxWkDTxjgDP0NP7Uq2TN/ayLS+YPtk6+1WaQQMHv0FCciJpZXwq8e5CQ50lkg9vGddIYjHD6s8THAZHdmTmb1GECXqDmMKhwoixBBlhz/ubpM3lEzT4MLK3miawUHRc9JK/5Td6MouryH0xioVs4Zt3/ws=
Received: from DU2PR04CA0336.eurprd04.prod.outlook.com (2603:10a6:10:2b4::15)
 by PA6PR08MB10815.eurprd08.prod.outlook.com (2603:10a6:102:3d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 19:10:08 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::7a) by DU2PR04CA0336.outlook.office365.com
 (2603:10a6:10:2b4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 19:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Wed, 17 Dec 2025 19:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODtLbSw4jfmokSO9HnwPWIYq/HU1hJ0UaDo09qF34Kbywfw8w6UclbOfCGXX+2KbSiOrhELeO9drhbiPFtBrlc6IMIMhW6yzqxqJ1pbGvfwRJyBOQMlIYwYMBtLlkaH6CJGmS49/TXj81NrQ+5CWEXcFD4aEdCTJflNV4ZL7+eM7z23Qyf8qAHWh2EI4B5FGp7uP0GScOrx/gTI9nM0vsP5xMySeKbFufBwdVBWEXfLlcBl478psLMflV+ZUTiuBGlQkXwgBKPyKMgoQBHVs1UiG3qzM63P5JmCpke/Sz0bujAS1VL3nQbcmQReRZeouVzMCeb3WgcoTISMEhmSN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agtZ2YTD/cWE3d6zlqciyMMiBDVxrthRYc7BwnJgRAk=;
 b=Xb77na3fDDkh3OUubihv2i3VmY1SJv6m45qGopbV1XVhHuvwtyBkcsW06FEy4prNyTWUGxufuuWEf/0RkU5wNH5JnWM5L/06ntxYKtVLdpSLRCke08qbvNPOOOfxm/L/6/08r0pVEM4P6jvtoFClmZSpCoKAxn+Sq7CglJQeuWEvYx0j+nSp7c8Mn/fQvI6gNCYc7Fy2Ec5JaUph0v92fbc6vIBmiwaJMgOnUrLw0WCxXzI/cDn4uyAKb0DEDbufp0mMuAUaV+Drfw/mkRK8QDKkmfV56EtewHEBfzEltxlNhyXNfRqJwL1fV8/UKRtcYA24PT8lgaGXm9gG0Wq/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agtZ2YTD/cWE3d6zlqciyMMiBDVxrthRYc7BwnJgRAk=;
 b=sKee/ayw37qqABGfngxWkDTxjgDP0NP7Uq2TN/ayLS+YPtk6+1WaQQMHv0FCciJpZXwq8e5CQ50lkg9vGddIYjHD6s8THAZHdmTmb1GECXqDmMKhwoixBBlhz/ubpM3lEzT4MLK3miawUHRc9JK/5Td6MouryH0xioVs4Zt3/ws=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA6PR08MB11585.eurprd08.prod.outlook.com
 (2603:10a6:102:521::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 19:09:04 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 19:09:03 +0000
Date: Wed, 17 Dec 2025 19:09:00 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
	david@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
	dev.jain@arm.com, yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/2] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Message-ID: <aUL/zJlJFRz2/Ybt@e129823.arm.com>
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-3-yeoreum.yun@arm.com>
 <731e3f48-e0a3-4c89-a13a-65ef37faa443@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731e3f48-e0a3-4c89-a13a-65ef37faa443@arm.com>
X-ClientProxiedBy: LO4P123CA0579.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PA6PR08MB11585:EE_|DB5PEPF00014B8A:EE_|PA6PR08MB10815:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fd0d36-7f50-4534-c1e8-08de3d9fe4ae
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?D7Uh1PHP6y6UqlS6wuWtkWtaIXUUSlN+jKkFbE3ctn5KKIqOT9/Kz0tmiDhS?=
 =?us-ascii?Q?iQsS8Tbb/YhW0ECSNUsfk8DkChWmUm9J80Jh1uSxBEytAj5MUJ5Kb20kOm6f?=
 =?us-ascii?Q?sNxgnR/iMRjgZNjiJe6o7/3aBbjC5OAqoqa2En0ShsVpHKHfKPHBfHlkGPox?=
 =?us-ascii?Q?MczGjdPhlA4KOmBOXmKF2E1GfpF+gr7Cd/tS3Bk3Q+ZTJ8da1TdXEyIJZCxp?=
 =?us-ascii?Q?FFTtCZog8rmqSxhzoyJFSmzkrvsgu/ooX2GOCz7PnkcZX9QxYizTJfGlHcjp?=
 =?us-ascii?Q?BTyoFfb1vUrvo48VBw+RuV6b1KCjNcU7IKEuww4OPRLYXMLOk4ZmLLAwp+td?=
 =?us-ascii?Q?OM7AxcBZ0wcG65xDYXshQ1fV4dQ9VetrajsGpJWFb6dRwpl7wxOiquBPNIWT?=
 =?us-ascii?Q?+oN9SqNo0NFWKc9C0/1suxgPNHrot5Eg2F2n1XBjqMfRNYfdbk+n1styYsNO?=
 =?us-ascii?Q?F43DiMaPHl3cKEGb8Jvc5+Mzfp+w6bfV8+2LuqfBrkLw+Uny8NrnGtWQtPkp?=
 =?us-ascii?Q?35eOCxygl+JkSHqXfqcl9fFE7hqpSO2BdHC5S3OvvGwW6CSUcGHzns9oO5bf?=
 =?us-ascii?Q?6OFbqFXAtA7XmzuIrbBMhMVgonHmIMAhw9/lJol60oeDkYutNBkFYh29Ym2L?=
 =?us-ascii?Q?LCGK+d+C3hR7T8irVSJhOQCNdIdg6060+RozdWvfVK+QgozVx0JNdDKN8Byx?=
 =?us-ascii?Q?hFdlwUgfGMN/MWx31QlrbpU0o0+JbLaO1rv4Mhwi50dmBpgax/Go69UIulU5?=
 =?us-ascii?Q?x3aPJyiPKZ/o/cXyiMW3eKZwkU2mmz+FGiV4dPXO8vEEpSR41IebGywyzIw3?=
 =?us-ascii?Q?gLwOIQhB7Wr6Ng28bUpAI4IGZe/zF7GvrPBG9WARZT1hnlQMJ10PAK0nOR/G?=
 =?us-ascii?Q?5YiM3i37wPS/9eQdc0t7sdKfPFNwEhSIesBjolFnXaKjxHJMLy87jqaXB1/W?=
 =?us-ascii?Q?GwsTr58VQWldniEHBoSAqwGVNbl79pu6sfxFFGdut6UWgch4SkehzvlJxt65?=
 =?us-ascii?Q?uetmhnNpD5qavvR+nfO0dznqeHB+wX+rkuWI7WwC5SWYgOaQjd2pCAMGrGvC?=
 =?us-ascii?Q?QkPeS94YxQ4XQ4BWPqnJZ5prdgKMLpTak1XQQY3eSjgz4XbOGZeOg+HnXY6Z?=
 =?us-ascii?Q?YZT5CdkRYlbThvBQmFG09dV1xXOF63djdVa0xu+ONN6ETpqBNF814ThlRk42?=
 =?us-ascii?Q?Mk6bNwaxAOnG9vdFCSDfbzB9v2DRsVTXh6M0p1HSpZMztS7TO64Lx2qn7Maj?=
 =?us-ascii?Q?td0ISb5hw84+ZpRtDVJtdxvt3hLQPlOvkM/TFe7mdXOHnIl0CMNUPbRoi74v?=
 =?us-ascii?Q?J8Rx0dgGHUaexygsESNaWSStk/fRpy8pWerlnYYOmgaowhHc7pWI3nKeezmt?=
 =?us-ascii?Q?Zcx4XtAa5H0Gnfaz7C9MDapI3CcJsRu+4bcof2JYKaIG++kgAQv7Xx3KkAhu?=
 =?us-ascii?Q?oZEgdHDvWJNWQpHOYN1zr6Pn4O5KGLdA?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB11585
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0f7224dc-88fb-4e42-44d6-08de3d9fbe42
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sJslX/YrulZY+4/hEhNH3apztwjcMAcOgeAjlqbt36F6IX2IX3VyJq5dd9K3?=
 =?us-ascii?Q?XgWXeLFfmHxrsyYl9uAzilWUbHE3Gb7v/Rh0CIv/qXRigojq8Z8+A0wsSKG7?=
 =?us-ascii?Q?EiYUbuwMapEcmL/9U2r3wyyFXoGdopQdgRU0TEPhLdgdihGzAugHP7hVEGmP?=
 =?us-ascii?Q?JVAb7ZmXmmOyHJIRaSkJ+5+daIqwX5VcqRONc2IUNXr3d2SOiEwUWjMul9J/?=
 =?us-ascii?Q?YNzrN2CPQXaARkNviJpdC+gejuvcOrJbngJ4TH1KBUzJ9ZrFL50Uh7jjhCEb?=
 =?us-ascii?Q?B82C2Z8Z20MslIRAoYHKyx/RYjEJakbwZ/eNgy4SIXlggNGRXz+JvomDx33O?=
 =?us-ascii?Q?ZJ3tvGJZBp4Dz0ZvmsFoERceXHnNh7qr5D1zVgLwaQdhVquXrynRmong0Xoj?=
 =?us-ascii?Q?JByE6ugtxvPmjKT+BJPKyPySD7NIh9az+hdJ8x5BTO1PE1jJgA+sdctwRyLV?=
 =?us-ascii?Q?+uXhwYPymNomyfk+asVmWF0NtDzB4RT5NuRV4+MDsZFifioxlbcYuOVEewhK?=
 =?us-ascii?Q?5L+oev+Cuz+qRHZd5mVVJdELAo3MCUpY+sEtNEWXXUzBzXoujON0MP/9MAnF?=
 =?us-ascii?Q?lJC7zS/8Se7D+lJirXup66OC+4weaPDR7CxTh1bdzFRHMoZlVs2SFfBIEkhU?=
 =?us-ascii?Q?VZqIwPBfTQ4uFRC+TlDLSVN7ZLeUL1S7o2Ugw0OfmLutzg/BJJI8VXIFaZUN?=
 =?us-ascii?Q?7UIWO7+4pwOx03bph8jl7RYgPqFI8HxJ/0rWI0FWSkZRWbtfURun1Y8HJSRm?=
 =?us-ascii?Q?o0aKAMYdWibbM4yAtVnLDgb88jly15gtyVKQH2ALQO3PQJw64NKQq5dYey8t?=
 =?us-ascii?Q?CFqcxW20XY1AOKWAVOGHCLPWxOoYbbbm6F5sKvCHhl9EIAtGBnW21yqv07A2?=
 =?us-ascii?Q?G4/4n1doH5u4TSxHllgETUAjYomxO71VK/8X4AMmAXOA4e1as2cypPRFnKmz?=
 =?us-ascii?Q?5p+eKuWZHeb+S9LlK19qRRwVle/uylsl4W3sv94U3RrAa/kEl9oomRgxoS3g?=
 =?us-ascii?Q?EWkHjZaPp0QZ0X4Qqxm7xbBZoffHk7irAO0znp3zDeHDmUdBNU/MHN+aZQzd?=
 =?us-ascii?Q?eSapdmaN5YrD7XT746bYNQ7EtgjUYxvAeq84hPyX+W2Oc1MQMx8rd+PQM0Bk?=
 =?us-ascii?Q?bqXk3yTQZsGF/B+tE1eimiPERJY14cUh+BZ1kIXaJNjV2dYeurPt5ZWFKCHi?=
 =?us-ascii?Q?UoqPWjsrMjq43PtzOQGfetjaC8vCNjpT5k8z15LqUKZl3rzfs1WPOPhgps/t?=
 =?us-ascii?Q?6/H2I0B5pMmy60xSj3VIODEm+hq+6VPBu7v16rifv8MJF7JDgfNuPzB7ZzYW?=
 =?us-ascii?Q?OrtFvsGC+3vHcAMIf/Hbs6cleovrL3aNtRunUUDY0aop1QW/xEJJ1al5nl4z?=
 =?us-ascii?Q?vfnZpcm040ODUUribuOFIVo0rFwAo/aHfVWzOD07W6qUk//5o/KPICprDHGb?=
 =?us-ascii?Q?3Ir5pQsr6DCqY9ZGNjwh+M8LGxFrYqM2hGKFJKMjknyUrvqJ3/x5n4Yj/I9U?=
 =?us-ascii?Q?CdBidblHZqRKBSsXH9YCBS8iutb/LoED6JviAQbjjDIgkoQpJhf7nY+6uyi6?=
 =?us-ascii?Q?m+TvL2p/xQoCioEf0YI=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 19:10:07.7917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fd0d36-7f50-4534-c1e8-08de3d9fe4ae
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10815

Hi Ryanc,

[...]
> > -	if (!cpu) {
> > -		free_pages(alloc, order);
> > +	if (!cpu)
> >  		arm64_use_ng_mappings = true;
> > -	}
> >
> >  	return 0;
> >  }
> >
> >  void __init kpti_install_ng_mappings(void)
> >  {
> > +	int order = order_base_2(CONFIG_PGTABLE_LEVELS);
> > +	u64 alloc;
> > +
> >  	/* Check whether KPTI is going to be used */
> >  	if (!arm64_kernel_unmapped_at_el0())
> >  		return;
> > @@ -1436,8 +1434,14 @@ void __init kpti_install_ng_mappings(void)
> >  	if (arm64_use_ng_mappings)
> >  		return;
> >
> > +	alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
>
> I don't think this requires GFP_ATOMIC now?
>
> With that removed:
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

I think it would be better to use only __GFP_HIGH in here since
when kpti_install_ng_mappings() is called, "kswpd" doesn't created yet.
and to allocate page with assurance, It would be good to use
min_reserved to.

Am I missing something?

Thanks.

[...]

--
Sincerely,
Yeoreum Yun
