Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577FE2512F5
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067813; cv=fail; b=gpEQ6KUdLouk6U9a8PUTxxpyNbl4D7eIk4cT9apxql844ZcDbCyrslcpLZGt5lQ8mO+R1a1bKbLRMYv4XNjvZuMy0X7T+2vObYa5/h8nnhd8/6E9QpfnKZAud2rvxiKoY16Am7hfmniBCnurZbY7bQkutkdeUTQFhxRrQNLc61c=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067813; c=relaxed/simple;
	bh=q3MoSSsXM2LVDotwXgc/+LHlvnWCq533VdOW+J/w1y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WIy7njnbon0FKuI+Zy98eXr+lRFcwVPhn3AV1JRq+Uga5dHxVCGLrqkXR2G0Pz/7jSohHA7BWh5J3u1Fv1/peOSp4Uq5IpfbfCSquKzy1PWENfv+BKT38yl3kRvYghcG28gaTLkzrwxZKxDOLaaa15MKzcfEoyBviCEqEH356Nc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=T4+u26V5; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=T4+u26V5; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T4+u26V5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T4+u26V5"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QOvGLVs2byFPRsiHblPA9vSESlZd9ipGqoyNnRO0vR2/yOwg19UZpBduXMz2G9f8hImBnNRxBo/WI5KzuEEogA91aQ3fn28IxQte4vGTt1jpJmJ8j5svfd17KSSlR21gDDAu5qskjvGSeS2gZCUiqOFfkfEiUAUXX3kAOLwT+rhV+Uw0kfzXS8/XO6a6zgQszePZ8ZnnWG5SAvWLF4oktyPbOxN+z3eYl1kAGFApcCrLvMg1fECjQ8XGVTYC4936ZO18gIAE+n/pGS5G/KggcLCk0soOZJYrRPw2KrJutgPKzyerKyuq54HZeNBDzPfohie9YBz18T7AlwtEqJK6BQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GoXCWyzlhu5giElwo9I/z4e9F7KUioGTVFS8hYcLJ8=;
 b=s4EuxgT3EG9yEqeVA9S4eCKY9q34v+A6yF4rrQfgvDiLXK1AZvNoqyDe2Y7AVpy7VnJ2JKC4Jbc0BUTN61ygUAdaFmRl+R+DUza6FrcXHpCmgLu89v3Ne2xXELR2l/Foo4hLIsSZNoNcvBEGOEeg7dIZiumNzSNWdJtUZL1iQk9QOoTHpDvGtkKOWeLBUddsjIsWGLQpUwFthoTJzqqCRNBAcEaHzLVwauwvPq+Y5oZ9xI2GK50nCW0LybFMZIljGvAI5bVSN5nGbkV8oqqlU3jmeBq4pfzzv6cR9nFY7M51nuZY3aos6vbxBUK5hYKtdSryfKRcoaoG04Hxyhso1A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=os.amperecomputing.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GoXCWyzlhu5giElwo9I/z4e9F7KUioGTVFS8hYcLJ8=;
 b=T4+u26V5Q49doZaGKSE10t/kuIqGvT9uOd8iA0alZJTdkF9IAJLobpMoMwS313PBl4c55AhvBSsK9j6lkOAUooHmB7TSHWxibmLmUMbC6sWHBLXMCJsp44v8WmKIQJPKkcXrplHH9f6p69MKOkOnTq9/7Pk4f0ABKunkBE/VOQM=
Received: from CWLP123CA0094.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::34)
 by AM8PR08MB5747.eurprd08.prod.outlook.com (2603:10a6:20b:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 07:43:20 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:401:5b:cafe::52) by CWLP123CA0094.outlook.office365.com
 (2603:10a6:401:5b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 07:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Thu, 22 Jan 2026 07:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPGZkTt9VDqlYRqRJiSU7vjMS/y6k3UCet1xPFY5zBfEL4shSKa+4zvFVqDpBh94hPw4bm9vvA/i7xXZwmJ+o92dUd7FG4dZ3J/WX6BJGNYKlEE/yktYdHXfJuwQ9V/4BV2BcnBpBvQJ+HvV8TEDkvlseDlGRGIDedtsCieoPI7Zr+zdCCR0VzCshUk5+LFI8Fss3I9szaQ64F4Qk2ENbvyg/gvQVXqp/FVB1kOfyJKrjeCmCUijBeYdsxOSHE1alyvEDlZXMlYwsg4zCXfQ3RwA4dhsSWlhflLWI6NnGChN5OCGV9zVijWaGa5dZtpBbnFddhnDRuq51pBtzw+Y3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GoXCWyzlhu5giElwo9I/z4e9F7KUioGTVFS8hYcLJ8=;
 b=AQ52pZ6LSC41ztqlgSDMJLSTe2I7RQgFv3kjjQamPCzSNLxkZ/7KgeRMNGwf+sx1QzHdx5zh5KIu5svrVYSJHCbZEI2gdWkQAHh81bERbCg045ebLm/V/8IC00ltlU559woTg3Vt7tOXHtywnoAItrS+9PixWYhbCgRJbmrdeP0BdL9GsBrA4ccbBSEnvpahvLW/Zvvja7cz2RIIEzu7tkjStXOtOpqjyVWe/WnJmsEIVH1Q87R8obRK41+/wANR08Ycj/29c2WuEcd5H9QdDKvz22vE+aUFW/9snKpxWV+4fM3RLRCmPRt/+N+3T6ZDspV5TyRPRGQqLgdelCtn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GoXCWyzlhu5giElwo9I/z4e9F7KUioGTVFS8hYcLJ8=;
 b=T4+u26V5Q49doZaGKSE10t/kuIqGvT9uOd8iA0alZJTdkF9IAJLobpMoMwS313PBl4c55AhvBSsK9j6lkOAUooHmB7TSHWxibmLmUMbC6sWHBLXMCJsp44v8WmKIQJPKkcXrplHH9f6p69MKOkOnTq9/7Pk4f0ABKunkBE/VOQM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS4PR08MB7781.eurprd08.prod.outlook.com
 (2603:10a6:20b:515::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 22 Jan
 2026 07:42:15 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 07:42:15 +0000
Date: Thu, 22 Jan 2026 07:42:11 +0000
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
Message-ID: <aXHU02hsrB64Zopo@e129823.arm.com>
References: <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
 <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
 <aW+t8S1LfwX3LjRi@e129823.arm.com>
 <11a01f4e-9ae5-4001-9f9c-74a746f898cd@arm.com>
 <02bb61cc-f0be-41e5-b8b2-59768afd5254@os.amperecomputing.com>
 <aXCPHaylUbRJ3CME@e129823.arm.com>
 <ee2bf4ba-0121-44dc-a465-4c186dc18f19@arm.com>
 <4c98a1b2-6215-4e71-8bb1-eaeb1722e7b1@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c98a1b2-6215-4e71-8bb1-eaeb1722e7b1@os.amperecomputing.com>
X-ClientProxiedBy: LO4P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::14) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS4PR08MB7781:EE_|AMS1EPF00000040:EE_|AM8PR08MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3625f0-d5d1-4a33-047f-08de5989ea24
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?c05vVEU4OXdvTXlUZUVlVVNPSnV2Q3lrVWhrdE9rSFNwWjJ1UmJHTmorSk1I?=
 =?utf-8?B?TEI2YlNLM1JZWUhNRjJKVWhiQmlvcU5RQm1naFRqMzlvcnRzZmw4OUpmbE9j?=
 =?utf-8?B?bEUyT3JjVUNsMTRMYVFJUERiSmxKTFhNU0x0V2FaOUdmTWNiQ014V0NGOE1B?=
 =?utf-8?B?bWtTajlrTUU4VzV2cG9GNEFva0dTM3dKVHp2YXd1OGRzS2tuYkFaS1BrL3NY?=
 =?utf-8?B?b05iYS9IdHRNSmh1WENMaitlUEs5NVozL1crTVRjQTRRQTVwaG5hNUJwUFhx?=
 =?utf-8?B?dm5RakYxV3ZFOUp3bnJENVlHN3dqOFhyd3NOV1FhSGllWXFiU0Fhb3Z2WEtE?=
 =?utf-8?B?Y0JuaFJJdGFidmhDbW9tdytwdjhVWTJWUUg1RlJ1eGd0bm1ZV0pDQVNXREtC?=
 =?utf-8?B?dUx5WUtVK3Y3MGl1eUxVNzM0TW1lT0JuaDJuejB3V0VzUU5pTFRPdFlXZk5l?=
 =?utf-8?B?UllteW9rVHliSkoycDlXY1RRRnV1Ym9YQm1iL2ZPdG9VanNVUm4rOHl3NzBC?=
 =?utf-8?B?RmpneUZtd1ZtNXN3NE9KbVJIQmE3dGF1ZTN4YXJVOUJHL0FBWHBQdzJBcERs?=
 =?utf-8?B?RWxVRlVHNWl5Yng1OHRKaGg5TWtYQXdlQVZZaVVwaTFubFE0UXd1MHMzb1pU?=
 =?utf-8?B?SHRyYUZXN0ZTUGhUaWJndmpQUWdhY0xoMGtYdDNJRzlaQVNXYkRTWjFubFRI?=
 =?utf-8?B?K2l2YTMvbmdySkMxVFNtM1B6Q3N0TWRLZVErdmRCaW1FYUl5d1NaRjhGYlhu?=
 =?utf-8?B?RHVSa0trNUdOWmtOM2hLdENlU1huNitDaG8zVEFTZTFXTmdFbzl2Rm9LRU9r?=
 =?utf-8?B?cmtUS0dpSFNqT0t0cWZ5U09sNlY1bGE0aG81ZWRqa1Q1OGROYXRTSlREamts?=
 =?utf-8?B?U1FWMzBZRHU1ZGNLWWJ5Z1ljdXVibXoya2JtOWIva0oyZVdGOUEvQ3E0R2ph?=
 =?utf-8?B?bGFTZU5zTS9CVGRrcExmRTRBM3RycXpUOG91c2p4QUN3VWFaTjhvdDVyK1ZV?=
 =?utf-8?B?WmxmWktlaFM2alR4ei9CWnBiUHNXMm1yWStYMWJJckEzQWdBeE1DZDZxYUdB?=
 =?utf-8?B?S2pMSkdYM1h5dDYxdExhMUZlN01JUnJKVlRQNVFYelQzOHE3UzdEOHJGWTZL?=
 =?utf-8?B?eHI3YWRCdmFacHQ5TzFNWnBFaGVnMnNidXNZRVh3UFNSZXp5RnNvSk9WRUgv?=
 =?utf-8?B?NkpOVUlJdXlkUGM3Zkh5U0ZBbWt4UldYaUJXTUFBOUovOGJXazlML2ZpOWZD?=
 =?utf-8?B?YmZxcXlvbDQzbHZBbVA3NGxGMThMeVo3L3JZSzl6aWJHWFJJRlAvUGVmSDRj?=
 =?utf-8?B?NFlTYVJuVXVnRkd4aUNKTS81bUpQUFJIeGV5WUdXL3NzNXVkbFl3V0FlU2Jo?=
 =?utf-8?B?ajZaZFZkMDB2QkM2dGpqOHo4MTgzNnkzdUtNVFp4ZUpQSnFsditCeVBtdXd1?=
 =?utf-8?B?T29PMWdRN1JqRWYraU96dWVCekdIZmMvZ0MveVh2Rjk2M3hLeWJicnZ3emZa?=
 =?utf-8?B?TjBwaG5RWnFwemlUeWJvSHUraE84RnhXMGJ2eXFzbUQxZmlkcjg2ZkI4WUFu?=
 =?utf-8?B?ZnB5TWVhQnhBMjh1cjZ4Vm1aUWZYOEtlSjFKdkE1ajBseUNkOTB3c1YwU05M?=
 =?utf-8?B?RDh1QjBTc1pvMVZmN0h1K0dFYWlnWkpyUzN6UDVBS295TmdIL0RNNFpISWVJ?=
 =?utf-8?B?ZnZ5MzZNc2VaVkkvRmNJQ2RrazJ3a0J4UFpYMWlVK2VwNEsrTG5CdU40YkdP?=
 =?utf-8?B?UVZ3YzNwZFI1L0lsdlFjTFpmM21nb0ErQklSTWR2NThUQlJLelR6QXJpTWpl?=
 =?utf-8?B?ejgzZUNlMDZzcVdTZmJ6ZTBNL1phQTBkOWZyOVNERzltK1k1VStrWmZQSm1t?=
 =?utf-8?B?QjByU2JwMy9VWW9JWTN1WWZrNkh0Z29PS0xsQ1VWbUNsQjlUR0szemdYbDdw?=
 =?utf-8?B?Zy9xWFRMWTU5bnBPRDcxeDdrZG9tQUVHNDRQdFRxTUhQTzBWUVpFelA4aTZH?=
 =?utf-8?B?S2hUZ1gzNDZXL1hIUlNna1U2Q0UwVHcwcXVKeU8vRmZQR1hBZVpJbHdnRkRa?=
 =?utf-8?B?YTBsWFlCVDk5WUpzdDBVOVc5bnRJUWZReGs0UUJUbDZ4MjlPVHA5OFk3Wld6?=
 =?utf-8?Q?/oKA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7781
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	194684d6-4478-4f27-30cb-08de5989c2ee
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|30052699003|376014|36860700013|35042699022|1800799024|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGJhNHJCdW5HeDhESndneDI5SXAzQ2h4WXlpRnFMQ1VvR2dJYk5sOFhqNTIv?=
 =?utf-8?B?Tm1ZK0JEaGtIY2h5Q2JmMGk1TUlyeTJCeTU2N05XRGFaZTZpV3VzcEYwcDlx?=
 =?utf-8?B?R1Q2N0NQQ1daMUphQkVBOGl3Um82Yzg0a3pCMnNlVHpPRkZDd0lFOC83cDBC?=
 =?utf-8?B?OUlZMnRCcW0vaDNaaGU0L3JVQURNYUM2VzBPay93bWt6RTVNWk9MZC90UUs1?=
 =?utf-8?B?YzZDSzN4WDFPa0dtYmw4U0Y3RTVibXZWditjMkFpM01sMG1OeEhOSGcrOUVG?=
 =?utf-8?B?UHdxV3pZQzMzUWFqQWhQcEoxQ25zTkdXRUloN2hBOURIQVloUm1EN3ArdXQx?=
 =?utf-8?B?YnZySzlUbStLRERlbyt2UXo3OFVpdHpPMkZkUTFIVGRDZDkwRktJNkZ5dzJO?=
 =?utf-8?B?WjU4aGFaL1BkcXVLOEFZVThhM3RDbWdMaUdkMklEa2tKMlhyOWh2aTdIOWhi?=
 =?utf-8?B?TFNBZDA3USs0VjZveUVPUHJ5alVKVGxRSGhIelRaS2VZNWpQNHdEVFAyRVlL?=
 =?utf-8?B?M3BRUWtTdkVTbWRKUXdpR2xWMktqdXJ3SW5MK2NCbWFxL1RTcllGMWd3TEFR?=
 =?utf-8?B?WXpnb1FnbmlJbWRwQ3paUnlaRXE3WHZjUjJ4eUt0cENmTXlxdWJCZmRTVkJR?=
 =?utf-8?B?cHdUY3RQOHB6bWRKOXJqM081S3dvRkNGb1RjSVowbitERHVrOUYrTGthR0Jk?=
 =?utf-8?B?NlBUUDVaak5XeSt3RGRPQy9QdGIrNS9MaWFLZlgwdk5hc2VsR3M2WWFQN1E2?=
 =?utf-8?B?UHRtMmpkbytRdXlEMlIra1dtUFo4S1Zzdm9IK2xIZUxwbTdQVUxyUUJRNzVk?=
 =?utf-8?B?RWRZRXVLUlJCb2NreXk3ZHhSR21qN0xRSlh3MEYvQTFuSlpxV0pENitoMVRR?=
 =?utf-8?B?SmZNZGR1TEkwWDhOUEprWHZDKzZOdmlEdVZNdThDV0h2cmh0OHRQb2tFYTF0?=
 =?utf-8?B?dm1ZOTFRcmdNdVg3TVo3ZEc5VTlNWU9KK3JVaE1seWF0alZ2YzdiWjN0NzlH?=
 =?utf-8?B?WmEvRmJBOGJaejlNZGhVRU1HM0hLWHZLUzdqREpkNVNxK3dzY3JqS3FOdTJy?=
 =?utf-8?B?aTNUN1ZmWkdDdWNwU2UvVHF6akhIMklPd3ErVVE4aUhzZmtaRjBKZW5NV0dz?=
 =?utf-8?B?WGNBN2JIQk0ySXQzUkpBZ1ZIdHR5ckRJNFBxWjQ1ajhhMDVLTDcvVDltYTJy?=
 =?utf-8?B?QmtaU083d3c0aWhLa1lKN0t5bzY1SEthbkwraUhBTXIvaTVxN0gwcWRkelJY?=
 =?utf-8?B?cjJmS2t2SG1UdXo0ejhHaGx2TVo2c0xkSmowY0lpWkVxblp0WThqdXMwYUhh?=
 =?utf-8?B?WXFzQSs2TFRkQXpIN05tTTBuTGZjdVpmeUVOS1lwenhWWWtJTnhGT2xVZjcv?=
 =?utf-8?B?M243ejZNdVBuUTFWcWxyS3NUNXM4bjA0TG15Yzd3TEFzMXJ2MVlYdm52L2gr?=
 =?utf-8?B?Wm4zSFlwZTg5cUVmRHRhaXc3OUFacUJreU5UaGM0SjVVL284YlJ6US92MTdR?=
 =?utf-8?B?VGFqTkdqYXV6eFpQL0xjRXZuYklnUURQVHg5YWRxWEd5YUU3dnQ2ZDczemxB?=
 =?utf-8?B?YkhDZzREajJ1ai95YzYrQXVqck1zamdsRmVYZTlCZWxVNmRMb3ZIdXVqNExt?=
 =?utf-8?B?eVU3cVBkOXgwb0tuc0U3UTlHUHpFZkZwUHdNQVZ4d2dMTTdudTc2NDdmQnZ0?=
 =?utf-8?B?MlMxYTU5M0QyNnB4b3RyQloyREU4U09MdWNUSTJSV09CN21jcXErcmtGbkc0?=
 =?utf-8?B?RFpyZWpYMFpzVzBSWE1QYVFzWTRFcU43eitzS0FDN2duSTNzRkpWd2JTamY1?=
 =?utf-8?B?Z2k3NUpqb1QxbkRqNTlVTDRaWGhUTjltV21zZ29DaEE3T05sdEdzMlVOcDBU?=
 =?utf-8?B?Y1FaN3dDY0pFdmJHeExUSzlPeEo4NDQyTjQ0UkEyS05acVpCbG4vZWtnU0px?=
 =?utf-8?B?RnIxdHVQaFpPMXBBNWZmWlJiRlBleUJ1TE9MRFozTGlPeUdua1BoT3VEWGtq?=
 =?utf-8?B?NGVyVVQra3Z0VTIybHJjUkpFMVpNMit3L0hYM09DWVlhcHBQRWJDemd1K0Vp?=
 =?utf-8?B?VXgvYUpnM3dBN1F1blRzcVQ4aWdkTWVsNjVWREZ1L0toVXU1cnpEWlo3amlI?=
 =?utf-8?B?K0tBdUZwamN2NkZlSVV4NlhqRGJZMWlQTG1WWFRIVDZmREhNeFNud2k5OVZB?=
 =?utf-8?B?cEdkVUJvdUVEaW1yYTNaei9LRlViclFxNkttaW5WQzdEYVNVM25rWFE0SS9W?=
 =?utf-8?B?NjlXRGM5U1FqckJ0NUNmNkwyLzVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(30052699003)(376014)(36860700013)(35042699022)(1800799024)(14060799003)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 07:43:20.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3625f0-d5d1-4a33-047f-08de5989ea24
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5747

On Wed, Jan 21, 2026 at 02:57:28PM -0800, Yang Shi wrote:
>
>
> On 1/21/26 2:20 AM, Ryan Roberts wrote:
> > On 21/01/2026 08:32, Yeoreum Yun wrote:
> > > > > > My concern is that if a secondary CPU can race and cause a split, that is
> > > > > > unsound because we have determined that although the primary CPU supports BBML2,
> > > > > > at least one of the secondary CPUs does not. So splitting a live mapping is unsafe.
> > > > > >
> > > > > > I just had a brief chat with Rutland, and he agrees that this _could_ be a
> > > > > > problem. Basically there is a window between onlining the secondary cpus and
> > > > > > entering the stop_machine() where one of those cpus _could_ end up doing
> > > > > > something that causes us to split the linear map.
> > > > If I remember correctly, split_kernel_leaf_mapping() does call
> > > > system_supports_bbml2_noabort() before doing real split. So we basically
> > > > should fall into two categories:
> > > >
> > > > 1. bbml2_noabort is supported on all cpus. Everything is fine.
> > > > 2. bbml2_noabort is not supported on all cpus. split_kernel_leaf_mapping()
> > > > just returns 0. Kernel doesn't split page table, so there won't be TLB
> > > > conflict issue. But the following page prot update may see unexpected block
> > > > mapping, then a   WARN  will be raised and it will return -EINVAL. So the
> > > > worst case is the caller will fail (IIRC all the callers of set_memory_*()
> > > > handle the failure), and we can know who is trying to change linear mapping
> > > > before the linear mapping gets                    finalized. AFAICT I
> > > > haven't seen such WARN yet.
> > Ahh good point! So this isn't quite as terrible as I was thinking.
>
> Yeah.
>
> >
> > > Thanks for the great detail :)
> > > I've missed system_supports_bbml2_noabort() in split_kernel_leaf_mapping().
> > >
> > > > > > I'm not immediately sure how to solve that.
> > > > Do we need some synchronization mechanism? If the linear mapping is not
> > > > finalized yet, split_kernel_leaf_mapping() will spin. For example, something
> > > > like this off the top of my head,
> > > >
> > > > DEFINE_STATIC_KEY_FALSE(linear_mapping_finalized);
> > > >
> > > > Once the linear mapping is finalized, we can call
> > > > static_branch_enable(&linear_mapping_finalized);
> > > >
> > > > In split_kernel_leaf_mapping(), we can just do:
> > > >
> > > > retry:
> > > >      if (!static_branch_likely(&linear_mapping_finalized))
> > > >          goto retry;
> > > >
> > Yuck... But I guess it might work as long as the primary thread never does
> > anything that would cause an attempt to split; otherwise we have a deadlock.
> >
> > > > There may be better way to handle it. But this case should be very unlikely
> > > > IMHO. It sounds crazy to have such complicated kernel threads run so early.
> > > > I'm not sure whether we should pay immediate attention to it or not.
> > I think we need to figure out if this is actually possible. We bring up the
> > secondary cpus, set system caps and finalize the linear map in smp_init().
> > That's called from kernel_init_freeable() which is called from kernel_init(),
> > which is invoked as a thread pinned to the boot cpu.
> >
> > sched_init_smp() is called after smp_init() (i.e. after the linear map is
> > finalized). I'm guessing (based on the name of sched_init_smp()) that nothing
> > other than the idle thread will run on any secondaries until after
> > sched_init_smp() is called? (I'd be greatful if anyone can confirm that).
> >
> > Rutland suggested that it's probably too early for any PM type stuff to be
> > running in the idle loop, so based on all of that, perhaps this is not a problem
> > after all and there is basically zero chance of a secondary cpu doing anything
> > that could cause a linear map split during this window?
> >
> > I'm inclined to leave this as is for now.
>
> I agree. I don't think this would be a real problem.
>
> Thanks,
> Yang

Although partially using GFP_ATOMIC might not be an issue given that
there is no contention at the moment,
technically using a memory allocation API inside stop_machine() is problematic
for PREEMPT_RT, and the relevant page tables should be pre-allocated.

That said, taking a step back (I’m not sure why I was being so stubborn about this),
since the kernel_alias area is mapped using block mappings,
a simple calculation based on your dm_meminfo patch should be sufficient to
determine the number of page tables that need to be pre-allocated for
splitting the linear mapping, without having to walk the page tables again.

So, after your dm_meminfo patch, I plan to respin this patch based on that.

Am I missing anything?

--
Sincerely,
Yeoreum Yun
