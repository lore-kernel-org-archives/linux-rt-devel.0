Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011014.outbound.protection.outlook.com [40.107.130.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09DA2F365F
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Jul 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.14
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568946; cv=fail; b=Ax4umRPQOOFW/fd6CgZWkzyALRZHytKQwtThOXWHq7a6qj4cazrGVP17LJ12GQ2ryqPeyV/2k6Fs6jRDkj6OB0IwskJchDy+Xgp9ZzrVy7wXsNW2hGmx2h5IBk9qDBOJ3JczRZcPCRghIlLvyxH97bY6Pr4fTouzUIA1M5RM51E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568946; c=relaxed/simple;
	bh=Af4Aic9jPIAp7qsNDuvXXGH+JzTYC2myKEtfM7qajIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rQ72D4CgrCoAs1lVPZcSRrXrv72NLRhxa5grvb9C2XSnQ/cby6TBZce1QnE8nSe5c9FIlAFfYlTljcCcuw60kjojPDAKzEOpBxsnK+Brpu43Gmxm/zA//5fyje40T//dAUNZBMKVF9M4PGdVfxi4+AsJflKVl7XwY1kXCM6P/aE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RChKMpUx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RChKMpUx; arc=fail smtp.client-ip=40.107.130.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RChKMpUx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RChKMpUx"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZP8CMtMlA9MWEamwrTkIORvbCkBPY14hYLpKgrTfuUlMGYdWWEvS5xD+itHaMiMDPw3kQwLrob4MheBrAq+QIFjjZCcWfsc7BSeTwv9OQybyfIxQUoQANSS4TU3M4x/EJKr1MA5nY4jEaa6OLcbcAl1v73MO4NnC9RytN7uv+skMUlOrV2mjJgdoBvQguASKPPAQENEAK44Pgq6PeIsiIPlXAa0r5NYEAErW8rTESdQWRaaMjYSoMql5OKCCiJhA2iulRTgGWKVBU8sHGghl/IxrDx/x0rM5zEdea//VLd8YmSa9lCmGh6ID/CLPxHkKgOrPIX5Xtw/qMJxDZkDfEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZw4qscm6Odl02eAKUFBl+K4BWWENTOF8o7MLivTahk=;
 b=AX4rB1l2iu3uWiOnoIBVvSFhX/13n1u4CGQikX6VbR0h/tv1vuyLItrGwRcPHimso5YYwNmytcNJD/5EXm7cOcj4D/3t5+iQgxqAYmCXI4OkBmXzf3yBxR6eKs47RkC6wd/X73GzvGt/cz/bgc6nUi+MNUMmVGvaqSLZylsGgHzDUiK5ek5ufnfQwt+VJgNWxgsyehlAnX2sjhwrsy4aC9kkkPE+cvs1pIHeGgdPUzWztmXN7weymtmfWJWTFF4R0GMC1B2gDECIbQEiWD8fJ67XSv1ewwOOpVlIewD5rI8k9fytO+/Kgjj/UrQC5k/qwbqCycbl57lx+hSjowP+3Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZw4qscm6Odl02eAKUFBl+K4BWWENTOF8o7MLivTahk=;
 b=RChKMpUx/Vo0uhRSA8QPozskjM6Gp9lqlUvWPZQWUKMi6df6VS1A0shRAHezTU21Be56xOB0RoIuMI5c45ByIYyBHCczGWSXjrq+8MgtoSnJZczUscPaaC2z4rOs8ldS23VwWY3Y8dKTJyIOLNY1XEPUfMMKj43XR4LRLRlWmzs=
Received: from AM0PR03CA0024.eurprd03.prod.outlook.com (2603:10a6:208:14::37)
 by FRZPR08MB11024.eurprd08.prod.outlook.com (2603:10a6:d10:137::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 18:55:39 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:208:14:cafe::35) by AM0PR03CA0024.outlook.office365.com
 (2603:10a6:208:14::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 18:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 18:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGNOfibb+sZM84Z0SMQvOdN0j7hb653XqzcYIiLeOuIcbXDORhXuzNjYrZRJrV8Z7axf1sK7pdvmht6DXtnIZCd0Ky0Agi5CZOMzKUo7C41EUZuUxmdQPwCNMmxLSrADFWZ5azh4vC0K1knd4Y9Emv0xok8cfIHH0TiQjgPiJY6j9MDQWQTRAtewBr1m3MUZdf+dWgIB0P4xo78QZpnoqzaDcYA+/foem0rjyFNSgGUsJosDQhcA7MYRXbv4HF55lX6RHIl2MWEnl8MN489jsUTow8A10p2cg9bemdJ9KMm4UR+FDZsHkeoh7J42aFfSPAGCeM8RXqzpKLfmlkBBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZw4qscm6Odl02eAKUFBl+K4BWWENTOF8o7MLivTahk=;
 b=IMaKevwB2sprsD0KbjGFbloYmwc5J12jw9i5QtcZRniV4qpcEppQWd7EChP+Q0IMUbd19rKp0wV9l6iHupA5a3MxUl+hUe51AVikCO5OQDDqu8iMeMfGkXjysnN+6YiJi4QSp48rPaP2ojbpR6FX6/eSVqClOxA/AKinhUhkEulkaAiC3miitsJK3+gGkrfeBv8B3UsAFoJnm9dAb3/VIC8NhR00G6lL2xLd3Qyp/cJDU5vcKGAde2vgcRR/qQwstS8uaY6Q690KMNSE9Mu5WntVvpumWMLgFEb36u16UF/UkBXSX0pzIheKrxNebkFpcYa0UpPbldN5gw5i5cVs9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZw4qscm6Odl02eAKUFBl+K4BWWENTOF8o7MLivTahk=;
 b=RChKMpUx/Vo0uhRSA8QPozskjM6Gp9lqlUvWPZQWUKMi6df6VS1A0shRAHezTU21Be56xOB0RoIuMI5c45ByIYyBHCczGWSXjrq+8MgtoSnJZczUscPaaC2z4rOs8ldS23VwWY3Y8dKTJyIOLNY1XEPUfMMKj43XR4LRLRlWmzs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB4PR08MB8077.eurprd08.prod.outlook.com
 (2603:10a6:10:387::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 18:55:07 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 18:55:07 +0000
Date: Thu, 3 Jul 2025 19:55:04 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org, byungchul@sk.com,
	max.byungchul.park@gmail.com, ysk@kzalloc.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-ID: <aGbSCG2B6464Lfz7@e129823.arm.com>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <CA+fCnZeL4KQJYg=yozG7Tr9JA=d+pMFHag_dkPUT=06khjz4xA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZeL4KQJYg=yozG7Tr9JA=d+pMFHag_dkPUT=06khjz4xA@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB4PR08MB8077:EE_|AMS1EPF0000004D:EE_|FRZPR08MB11024:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f47e9e-88e8-4222-b6db-08ddba633422
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?btdki1ZELYEVhsFrjZ1om64lXz6dO31IxQSW7diTMxiyhT2SHgKzUusBFj5h?=
 =?us-ascii?Q?0iFPa0x7yOMcD8wa7E5QNHHDRQdsrG9Dm0M6hwpKT0YLoDX/Ybq3xlozpXH3?=
 =?us-ascii?Q?teiqu0FSl5GIEqQOOi7MfX5tHdz9FBRsgt+A8NENOC+lvnGylxec+rV6KQbw?=
 =?us-ascii?Q?t54YaiW2odsHsNt15KKSDn9W2aNnvIkbAE7zWg4i/yZa4lvIvX9Eo1iNWpwu?=
 =?us-ascii?Q?ObhheZFxr/xPuKJa8kTqd9ENkjplcuge7U6xV0U8lD1MTz1vXPfxB64By1Up?=
 =?us-ascii?Q?0Xr5YjVOFmP0I/9NghKC+6F1SNEuwHJ/4ZWioWqBNmA0y9ylBtMeXJOt0SdX?=
 =?us-ascii?Q?h+iqYsn3WvK8uCGup3zZhrOpsLA70QmKW6g6mgjKMTGuqLWUzJlxCh3GnEB3?=
 =?us-ascii?Q?ZHvwHH9bsAUIh8GGu67UhwLU6s7RkMi2+M1RE/Mi6tC7ZpAwGd6h3IYPSmhv?=
 =?us-ascii?Q?tPQzdw4lmEijn0oEkCAPrsFBRIK9haPm8P090ORsDSViaTCejlrd7NvXbx8S?=
 =?us-ascii?Q?VZBHUFCD3CP2Itgm4lGZAxfn7nDe4pdXQmg9KV8Jsg73TZTUTj6uWP/Ie7/L?=
 =?us-ascii?Q?JvHzbEZtjcHksBJKupSgE+LYS+Vbsr0EX2xx+wK3pVKiFI7FPigkudpIHdPO?=
 =?us-ascii?Q?1YQ562E1b9GF0oCmE536lxVybZVHikL1F/Gtva1Aj8qjA/7mbj5mZZJoOW53?=
 =?us-ascii?Q?PTS7VzvzFCxzq/F7JWUkXOf2jVcdKVWszqAU4m4g48iaiZx9AoZdvkCtEZoz?=
 =?us-ascii?Q?AkPI+IbqkfO1xYTA0B3zSqk8fu6TlUExWlyIVutaMHCt2CWSpbDgBlR30OMZ?=
 =?us-ascii?Q?OvrFdLH0qCWQH+0BSjuaJQRTJyM2fBqc9AQ+kRNck8sLMHAsiFw+H+DInSOx?=
 =?us-ascii?Q?xGdq+qI8uXNuBRq6FbElFhLtwSmo4Nbct85REu/QHhkAw52vRejif5Rd0B15?=
 =?us-ascii?Q?maYX5HN6c1wZU49Qt2haeCgQjg3bDoPWG7DXj8NXZ0Ik/rj3/Mm+vT0GkpG9?=
 =?us-ascii?Q?fLgEu15kJjamZy9JZuB1PymaMwKs9ZQ8+Q/vmY4GcbinEi4EyXkjaJTz9rGE?=
 =?us-ascii?Q?u38N3YOUExYiOYFgABeeP9sL5vX4YNfsM2yj2Kj0PP4wAPLNKgM1JfCYbpWT?=
 =?us-ascii?Q?pIi2yNEv3Q9Rk6Ue8hiWs+Jk8Ll1l22rmv+vF9Yz8UTrt1WGL5wsnFDNfFQ3?=
 =?us-ascii?Q?R8duMVfgy77bTJG8YhRRleFFR4gJJTeTkyyDx9NH2zaLXTmlpF3jBlCWrfYu?=
 =?us-ascii?Q?PrP/pkWe18JZV/kuAs01u9N1JaKpQTqu/rd2CM0J4XD3s0tPVoVVVNnUUO6Y?=
 =?us-ascii?Q?sLR9KC4mIftQmaH2puJVscyKH6FZmMjhKFyf/644f6f1SE4uhHlwPceLp9wy?=
 =?us-ascii?Q?NJw21DlOJgbeHLLxUzPfINICBsi1JUkq6tPX0k5k4eBG2YEi82LBDsNFf7lx?=
 =?us-ascii?Q?Ztkeq085NAA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8077
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	14534c07-9a58-488f-7397-08ddba6320a1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|82310400026|35042699022|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HnMHFhlFNScq6yV2vZ6S3/ku0RTpbkGEYYHK/XuEG9jJNzYXpseTlbqLAaKN?=
 =?us-ascii?Q?MxhYCmQiZrDzKB24sIG3lIa537HATdxvb7aTQy7Br6vHr7O2EBsMBbEX0Xg4?=
 =?us-ascii?Q?5wRw11fOuWpWS75j8YxlqZVqNVTPj7I1sSz2yS083gFEWctjKbcCPLeeuq6t?=
 =?us-ascii?Q?CO4VhBJGuNzOVlihexLkFl8QRzqFAMYO0EEHES2dI4iV3FbIbsEMZvS68tQY?=
 =?us-ascii?Q?2b6MsmaenboRBt9NAGxCvFmxQiBMstkCuR9tW3ebkGY1c1Sfta6KZG+pOHGE?=
 =?us-ascii?Q?Exc7T0CYMgluuR3Izd8VS7+xE+hYLGotpwUz3Hp9AG3T5Vi6/v6bylBVLf1D?=
 =?us-ascii?Q?lKv25lzc7XXy6ICizW20YyXzGXTlxYa00c8oq2SY+NDT+bxPsTxzOWQjqpLn?=
 =?us-ascii?Q?+Oxk9WdN75lI4/c5mvdaS+GbQGdb0HsxO76vMQPqqCsBFyle/8GYBsXCSu9U?=
 =?us-ascii?Q?9yR9xRvScWt2yYpKRZjlWjBJmzK4xi7eO0v5O8vB/RJZoPA+mpn/7qOmcZcP?=
 =?us-ascii?Q?lSfG/ZK+fkJuOWEebMJOXABjoeFTnkiUaevBHVei+85xfRgrG0Wuuq+5vQoC?=
 =?us-ascii?Q?f9DWwYHZwoFO+8Oo0jlzexQ5DjRsy6lbNkgf76w0si2KNBS2GTBrwIgNUQJN?=
 =?us-ascii?Q?+U7BQcn2QLuIW/ktZ0gipMIITsaw+cLmV/bkCggAhtF1QFhmU51u0kE8dLTn?=
 =?us-ascii?Q?E4KapyMlo0nm3jrkC2eDGtsixrr4byqYwWrn+3DdSNIqotQNwIfCtLbsaCIw?=
 =?us-ascii?Q?a0Jo/atcEX7MxZ672mEsMTPIOaKlVriaYeMaOi93BPw4khX4MtFzMuyXwCwm?=
 =?us-ascii?Q?G5pp8dzFFWnxO0yPO8cBHsXRVe0WmNIzpmrhEeYgLQDttEacR2lYodM5kS82?=
 =?us-ascii?Q?vnUPe0ql1UIOnsrek+2kdauI5cCH/NPnAx45l7tGoXoxZxUAcMJ92UZa1wMa?=
 =?us-ascii?Q?OU6UzUZD9qd4JslLAoHcudDvuB9LlcVr4vKzXoWyId2Dhy2FFnyW2GG8q527?=
 =?us-ascii?Q?JB5DlBsidZR9LoLs7xnpnqZ6MXnIBV5/LkKsivVoAeLTRWmmeZR96WxumcO/?=
 =?us-ascii?Q?0OBBwBUUlbSmbhIKCdVbmxMdbZBU6Gckg7js2wTvB43lII0jNGlS9suU/0la?=
 =?us-ascii?Q?Slvwit9V7VbvB420wxe0hh7S/PvLk+EmjljiVI4VNTTl7uXseGn2Xv1Qu9Rs?=
 =?us-ascii?Q?1uQpcPLYnJtzo51ZOWuRRb03LTH6a35MdtBBfUTjgahIYHAEm1+gNGm5Y5PR?=
 =?us-ascii?Q?h3Nahmb0CsIVL/6iMBxPNvCNYHhoymZBsqxd8xBjMC5hPwXntTOg0Q/jsAr6?=
 =?us-ascii?Q?qXYVMpqCGsNgDzw6g4RrvkMr35rYIFhBz6SbAqUZ6yLZTZcpcP8MF9iUr7cg?=
 =?us-ascii?Q?wO83laRlgCIA70JgY/36VTrLhUolNNKZblmfEcNDhnFJdgVNtF6emy8hXq3N?=
 =?us-ascii?Q?r6qI10klrK0ZJX9rhd79zRKN/EPEXobkNUb+hCA1+seI1a+hzNpBaqGykZZ1?=
 =?us-ascii?Q?cpDYKxQUGJmkaPdEo1jDbHeldj/owqB7NaaR8d/HNqN6c4u8jZGM+r5fpg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(35042699022)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:55:39.4817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f47e9e-88e8-4222-b6db-08ddba633422
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11024

Hi Andrey,

> >
> > find_vm_area() couldn't be called in atomic_context.
> > If find_vm_area() is called to reports vm area information,
> > kasan can trigger deadlock like:
> >
> > CPU0                                CPU1
> > vmalloc();
> >  alloc_vmap_area();
> >   spin_lock(&vn->busy.lock)
> >                                     spin_lock_bh(&some_lock);
> >    <interrupt occurs>
> >    <in softirq>
> >    spin_lock(&some_lock);
> >                                     <access invalid address>
> >                                     kasan_report();
> >                                      print_report();
> >                                       print_address_description();
> >                                        kasan_find_vm_area();
> >                                         find_vm_area();
> >                                          spin_lock(&vn->busy.lock) // deadlock!
> >
> > To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().
>
> Can we keep it for when we are in_task()?

We couldn't do. since when kasan_find_vm_area() is called,
the report_lock is grabbed with irq disabled.

Please check discuss with Andrey Ryabinin:
  https://lore.kernel.org/all/4599f645-f79c-4cce-b686-494428bb9e2a@gmail.com/

Thanks

--
Sincerely,
Yeoreum Yun
