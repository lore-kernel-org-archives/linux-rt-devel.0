Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123B23370F
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Jan 2026 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858377; cv=fail; b=X3tJ6cUDwAC0+tikkJsYxTZjOgBsd4DTJZGvpF+wYTlSYMKmFizDJgDeTFRlM4T5wW2MwYLeMCRBXj0YKFYtVGCnJe+q2cjsZY4IAFznyvK2svkCpifk0r32WlLbvKRx3wpOEYr6/Q7aZrRy56VvQrosgna3QQITGqaHNn+35wo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858377; c=relaxed/simple;
	bh=oHaLL4LWnWgu7lwuEclPkiLcy7qsI2JYtwEdenT3Lvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQ5l+76uLt0UoYWiTNohxaaGDPS7vS/AUqOi1Iu9iBZ1MylWH6WG0XNZMYwfwozCAOJ8/C8RRHBTk7x5ZPTkoB3d7hrUZMM98goOO+5nqazZLAhKcAxesTv/aY9EI8Yx18dDMpl2eQ/UVL4B+/SQeuHRmIV8vx2pMNk6f6RdsD4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F7lVjE4j; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F7lVjE4j; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F7lVjE4j";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F7lVjE4j"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=i4+PCFE0jqv3h8hDMDmZmgJSZR+NQNjVOGs6Opv+NvFshGs1gwatBJOFrRE/T4AO8w0UyzWaHJ8faUJiF/ExNfj7GTsKBuNei9HSjQMSV/v6I6T5Xnfx9ZNIEuYXMcnyXO/woTcUIh1hY37QCDxTgDE7tj2rPy9gMbMjS2JXplzL7nD+EZzk3bHqFGWlTcsSpvSxxnlaocVic4pul4kh6+v8/2ygkje//sOOFJtZFty0eood5jJCO9GVQXxl0PYogpKfE9RRwE7K6x1yYRDfF8iYwV5X3Ieac0HcLIU/zHij3SGTCMVlmQYj8i2NEGi0c9DXz4dZujc4h9u59KFeVw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEpbCtXnjv78hJDL7RgRwvQ0/IexqZUI29+jVrjxmsc=;
 b=CnLuS0/k6vcdU6MW+Vr0FjWFSvr9ojbDzaXE/gmphaMr/MvxzfRVPV5WhDsfIxqTtRxx8YcLazsd8CpdS9+OK2bCjkEf1pPViFB2d2lNtCDXfnti7v0fM27/8Hk/QHgRSGhxKNUCzoAxhKHs3VWLOj2hhOd/l8RvOyHcEF9GtGW/9gm/gBVoMNUy6Jxn2eE2jGzvCFup7jSzbY8J2NlceDPAGj0rsbcZBslDn4+LSJxQGKysZdIKzSZbjbccpcH99XjGV5SlyYoIhckcT1A7ed55xzWHtzaCwXdHh1sfeDt3wNLjiSrzDrr8KnXw9uxiWxhzXefEJ198j7cEDhL3hQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEpbCtXnjv78hJDL7RgRwvQ0/IexqZUI29+jVrjxmsc=;
 b=F7lVjE4jhwsDRR+MKGh2GLynOfk8CxGOGvx5I1iLFsq+Zc1iHVorppviCwDGs0iLNBnCmpstamfWV+Zzp7rjzldNhsmtgAwG2mt9ne27qxLLL2IwjfoTdy941aHVd4vv+wilBJPE3u5beou9tzpJzrcAjKJhj/s5K5dwHgBp4Xc=
Received: from PAZP264CA0049.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::16)
 by PAWPR08MB10996.eurprd08.prod.outlook.com (2603:10a6:102:471::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 21:32:49 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fc:cafe::6a) by PAZP264CA0049.outlook.office365.com
 (2603:10a6:102:1fc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 21:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.0
 via Frontend Transport; Mon, 19 Jan 2026 21:32:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eglPZoJi9fv5zEi89SSUc0Un2wNPzxhJFpDjkUbdCCAve9b4xFOJsE6kECxKqoQfFTud8gQIxoKJA2X3EBYSw8NaFJss4yYVmqywiMd0cuXuu10Gilr/sAYAcMgcBZiUaoXRnFwi0RlYzk2yvCvkKnB/kkSGAFdBOkST56hTkGMqSNHzpURH25+HHt9XZDBb3aE0xRwltM8sob2TZz9HLhUjPtXfG2eGUIYjKIhxC4alvyZl0OOe8t8uN8RdGaLxbI7092XvE193CYmlekqDiB15iarkiJz/nBSGFQcXF4pyihK/auhfHjCzhmGoSTyosb1RakD3OyFWcUhXd0byKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEpbCtXnjv78hJDL7RgRwvQ0/IexqZUI29+jVrjxmsc=;
 b=GlWvFG8vBD5bWWPw58hJSuqtJMLbg3rVn1hGK1zxuhFXJUkhBxtA0tq1ghhAhVBWxHALvK11wB7YZ5d3TQFfvN4zBZnbjYWEZYVE8P2el8Bq5z6jeKNhKJrcobvaQgSI3Tn8liEKdvaLKfmYte8DXrrwRTeIMlztnPCPyo89t7KRFV2pNBHjrhTMh64rxVVHXTYbZ0eaSa23wcdKlxr1rkvopnvjNgGN8On9gTtVHyM41DIcKxO3Jxp0xf5JLM3pi+tQS1UXrjdW12tf/9wEPUxRSsaQnEUBBF6X21ktSuaLYGGMkrX1EpSsT2rI05slVZxei65hpFskbqMylopt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEpbCtXnjv78hJDL7RgRwvQ0/IexqZUI29+jVrjxmsc=;
 b=F7lVjE4jhwsDRR+MKGh2GLynOfk8CxGOGvx5I1iLFsq+Zc1iHVorppviCwDGs0iLNBnCmpstamfWV+Zzp7rjzldNhsmtgAwG2mt9ne27qxLLL2IwjfoTdy941aHVd4vv+wilBJPE3u5beou9tzpJzrcAjKJhj/s5K5dwHgBp4Xc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB6645.eurprd08.prod.outlook.com
 (2603:10a6:20b:38f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:30:33 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 21:30:33 +0000
Date: Mon, 19 Jan 2026 21:30:30 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, catalin.marinas@arm.com,
	ryan.roberts@arm.com, akpm@linux-oundation.org, david@kernel.org,
	kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v5 3/3] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Message-ID: <aW6idotkGVoD692c@e129823.arm.com>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-4-yeoreum.yun@arm.com>
 <aW5qfh_bsGNRd0Vd@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW5qfh_bsGNRd0Vd@willie-the-truck>
X-ClientProxiedBy: LO4P123CA0621.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::21) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB6645:EE_|AM4PEPF00025F9B:EE_|PAWPR08MB10996:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6c1d1e-2b2c-461b-4e2a-08de57a24b65
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?KgGnnVPcruf4RDYpj7+9dxgG2s694nuxVenhTsp9vVpXWwLF+rqqpaGSs0ZB?=
 =?us-ascii?Q?+hF+1ZWUJBueTr7Mr3m6cNa3f0gi25FDoOEnGrNlvrMwa+ysa2CgMQ8dqauq?=
 =?us-ascii?Q?YqIDJKbiQjVspJ41jPAUlUJIphC9TQiBh7NmZQhshfYvRaIdljevk+8p8nlf?=
 =?us-ascii?Q?aCd/WW0/zzm3v4FI6QWAWRoDNYwQPEV3TKH6FHiZA2XDoDlTezOaULeLug1A?=
 =?us-ascii?Q?AlqE+OaPwbacMlLXzt5IY5OCutnrPs9G62pviatNzmokshhFUAsDsZsD2nvB?=
 =?us-ascii?Q?ahkvmfQ6YRqeqZ0ezrTzmW5hTm/jLh5CIHKJExZroyVMewc/aV+XadUaZC/Y?=
 =?us-ascii?Q?J8dy0izK9lg8URcXpVd4ZsVswX0UtJaNZTQnXSMZTLMjUMObUceyikBDHNpS?=
 =?us-ascii?Q?K/BE4Ymx+/rI2PE+AP7JicCtgMQSNomBHUPGbOmlWusTmgxi8is5J1DrgkW9?=
 =?us-ascii?Q?rH3OvHeJK7wiVqh7Qh0I8RvW/rJlxeYsG5+69DVypODnA9tRpBcy2+6Kyfqs?=
 =?us-ascii?Q?KRyUfOjSNYRzpVMHW6DJLv6E40U3G6I/PD7EzVR8uqjK9fg9F5BQbXZypd3s?=
 =?us-ascii?Q?U0aiT0Fd+7EFxkFskBW+Jxvr40r4WYejd4siw13PAQNmZ23S+1I46J7eQctd?=
 =?us-ascii?Q?eNFy4u/02x/hfNIUFu18BdDYN1Ly8MnOczLqwUAjhhrSa7ticSEb1y9m4zX8?=
 =?us-ascii?Q?9Xv3n3TAHtHaRe6LJ1w9Q0WhQlUqpWqxYR77bM+h6l9BamK4nXqoy4OOWiYE?=
 =?us-ascii?Q?QyC2ABw+z7LyPa9NNDgFFjzZi7s5c5IjWMtaHGyScVMFowZRWq1H/YwqPw4Z?=
 =?us-ascii?Q?cq92omtr9DEjF1WjoKpeRXgoKfBpu70vEl8JfW3ZspqSZL5wCdn149PvBgGk?=
 =?us-ascii?Q?jhwk+Kz91ltM6iOCHsox2YLhTTTVdFh3bT1rPin2X7gyQbHzWg9dPw2Kk7Iv?=
 =?us-ascii?Q?H5HSxP87Xr/Sun4bj8b1n8M00EOGNxsB0YKw3YWVXCdwDhnHcd9tpuVm5PW8?=
 =?us-ascii?Q?3fKY6B7RtauPcyXMaELnGXxni0MfxpV0ZHqP2J9dxK7e927Mw1MGyqpMc9mW?=
 =?us-ascii?Q?yBJFKYcHEgLZLm9/EoriYSqc8ugEOQi3yUDKYYs7mt4cpZbQPCBdjxklSifN?=
 =?us-ascii?Q?S7O+0X+kvGnOX5JqXTE1tnyNBLNRVWnkVNzy0A+mYxAemWVbIbKTmhBRPOQ5?=
 =?us-ascii?Q?gwzzgTF4AjPRx5Cqa+QtoYUVIwsX8CgLM3TudFSK0qIJHEallU6qlFch30Hh?=
 =?us-ascii?Q?xZ7Lm+3VRL2M5ETVmdzmaR7zQMiK2n18RPBAofOf0hoXosB72lpcu5YZSkNy?=
 =?us-ascii?Q?O19c/9GQVokzPAhJG5VsJQgMj5VTQ0QCukDNvcDb3ZU4MHtd3EiSny7HBwVs?=
 =?us-ascii?Q?8W1UsTZ9Uw3qK44wjNiw0aMkPOj2KObmzlWth/oLWYSn5v9P3hDfuJEFsMGb?=
 =?us-ascii?Q?5FljFqu+PCbSxJyKgy7fcbuPUFxmhAZROJYxEYKfKIJffN2P2y3t0po5umfA?=
 =?us-ascii?Q?CclsgKg5koNWN5ogXLZwZdItURUX/KWOCqnQ2PWGqvq9iBuc7DYTdHNafl8G?=
 =?us-ascii?Q?1wIYjYqQ8PFYwAEmdRk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6645
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9c90a9f4-c311-4530-eb94-08de57a1fa18
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|14060799003|36860700013|7416014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BL+bzXsUxLMwIh0R4vVWzvFl+d06lHJpyNjaJ6y0jqabPbeehoZbV3Eb1MHd?=
 =?us-ascii?Q?k6+dwWOvBrAgEuDZBLf20VzQGKSRIU0TxoVXTP4phrk2bFMZ/bdOUVhbfzUO?=
 =?us-ascii?Q?5ZE89rzomYRmf7issWA8/FkuT2vgCI5yOSF42FfYjAftTIAzqqRzdkONCO9u?=
 =?us-ascii?Q?WkOPSXsFBOGeFvk55J5oVWHZ4Njb7LaamobwagVL5XKZh/ErAnFSY4lwFOPG?=
 =?us-ascii?Q?kbZyZzKCn91T0UFJhK5C/T2xY89q7CzpMEJj7DqgFqKzkVSe7vkYE3wkjyGN?=
 =?us-ascii?Q?qzICc10EPp6oC5hl+jbv50KBBoUzr+qSh+yElhErt2rlOgAUCiRrFpGj0yH6?=
 =?us-ascii?Q?DMbEEZa6sKfySOagNyOgsf3/k1jzc0rUv4DGLr837FINz8WyD/6tdpQVMYEm?=
 =?us-ascii?Q?7fiuub3xpB+MCPr3p6x596cpHJK2BdJsrf5Yj0y06ibNed9HuNXqUaOYjr27?=
 =?us-ascii?Q?QByMvTO4AaYzxF64UCiFjvSRISJEK9iXKpt6xk16tMO9tNLwXrnHDGgE0/oj?=
 =?us-ascii?Q?m+zZWP6kv08mwsyiNcSbaBQNpyswuK/2V00/Ls2RdRwfWL1/uYQXcEBxPLw3?=
 =?us-ascii?Q?RJHKV1iWaX/6eIFC8wNYZNpnvgsyhKBHy66DP5WpQfJylQrxxhshxICIS0yW?=
 =?us-ascii?Q?HsaQj2VhRWxx2tmHwV+OSTIpiFDwbwqr3KMEANjA6TMsDqhgL+Mxt9kDBPV5?=
 =?us-ascii?Q?O9EFXrV/nweY7/Wz1t0ZF1Apb6OWWjny4pWD/yusWlpoJ4OcT1v8ioBSwKpJ?=
 =?us-ascii?Q?bXkauHbeiMmIFBP4hCSBop47/jmgl4G2W6aDLHcLjHdg9xZ93gYyHFZTTu0P?=
 =?us-ascii?Q?MhsHMzKDRCKlllGiLRObWnZuizMMHR+5cYWwc9mP5ZRA0dZWabdnEHLL9J60?=
 =?us-ascii?Q?r0+2hvJ4Ngg/9MAAAEeotM/k1KJr3rnj4CMAaWqtjOx/ZjWkmj35neDzCYgY?=
 =?us-ascii?Q?Tsd5HMYRXBuzSaC8bkfx6IiijhTZyOeiYArKAyFEX5cKogOqKKxU0XaD0oc+?=
 =?us-ascii?Q?B7v/Nc8MtuDQriEYH3hSBjr32BAKC5JqIK+cVFSrRgWOEljxlG9/WB1HcONf?=
 =?us-ascii?Q?b07ppuNbeeQaVYnWuBXASze32r4xffvBm8ysD1EzeI93D2rayLITB8HGjb2f?=
 =?us-ascii?Q?McFPWYBsKACjeYJDbKXQK7L4x/o0lLUInnN8r9Dn5o0Cq3XGbbMaE6n7xBEY?=
 =?us-ascii?Q?bwrXp3GEC/IBfEbC3gtkdBhI9yh+wF8h0i3ayVXTMuaccrPHw2PVC9RxEyzI?=
 =?us-ascii?Q?tKG7vLj42+3TqAL5i5/WprIto4YAhbI6LMnMmycuNyHb85y40ePTekkINfT8?=
 =?us-ascii?Q?8OXJJauaXYX4KdegrW8aTnG4qlRWiWhFd97FpRiNcnsYlxpookM9ppyd+nsV?=
 =?us-ascii?Q?IDhWUD/ExczEq1RL+3bUnjQL+4X81eqjhCjIhJagyjY7Oqu/eN7al8nUNV8q?=
 =?us-ascii?Q?mXPLIvrFLvzq/EoAxT9HnL4fxX3rQcM9ScNBfHeeEihT3oCZzaPDHKMot357?=
 =?us-ascii?Q?ixrwLyokgmjHqmr9qSCj2WbUVn7Wyfu4eZ5bgtvxCJ8qc7ILSeaJrME8qBa7?=
 =?us-ascii?Q?SzrgJuRf90tpNgOSJ38yr/FC0I3nxjTMN8UU5o8qqzvvLjPhFeGcYum97WNd?=
 =?us-ascii?Q?mEFVwJbxwemTGPahCi0rU/Wsje0fpC/SdozrI2f3+QK8KIjC+AkgPDIfuuhH?=
 =?us-ascii?Q?5C2PFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(14060799003)(36860700013)(7416014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:32:49.3620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6c1d1e-2b2c-461b-4e2a-08de57a24b65
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10996

Hi Will,

> On Mon, Jan 05, 2026 at 08:23:28PM +0000, Yeoreum Yun wrote:
> > The current __kpti_install_ng_mappings() allocates a temporary PGD
> > while installing the NG mapping for KPTI under stop_machine(),
> > using GFP_ATOMIC.
> >
> > This is fine in the non-PREEMPT_RT case. However, it becomes a problem
> > under PREEMPT_RT because generic memory allocation/free APIs
> > (e.g., pgtable_alloc(), __get_free_pages(), etc.) cannot be invoked
> > in a non-preemptible context, except for the *_nolock() variants.
> > These generic allocators may sleep due to their use of spin_lock().
> >
> > In other words, calling __get_free_pages(), even with GFP_ATOMIC,
> > is not allowed in __kpti_install_ng_mappings(), which is executed by
> > the stopper thread where preemption is disabled under PREEMPT_RT.
> >
> > To address this, preallocate the page needed for the temporary PGD
> > before invoking __kpti_install_ng_mappings() via stop_machine().
> >
> > Fixes: 47546a1912fc ("arm64: mm: install KPTI nG mappings with MMU enabled")
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >  arch/arm64/mm/mmu.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 120874a2d35b..6ea5b80ab54f 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -1360,7 +1360,7 @@ static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
> >  	return kpti_ng_temp_alloc;
> >  }
> >
> > -static int __init __kpti_install_ng_mappings(void *__unused)
> > +static int __init __kpti_install_ng_mappings(void *data)
> >  {
> >  	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
> >  	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
> > @@ -1368,10 +1368,9 @@ static int __init __kpti_install_ng_mappings(void *__unused)
> >
> >  	int cpu = smp_processor_id();
> >  	int levels = CONFIG_PGTABLE_LEVELS;
> > -	int order = order_base_2(levels);
> >  	u64 kpti_ng_temp_pgd_pa = 0;
> >  	pgd_t *kpti_ng_temp_pgd;
> > -	u64 alloc = 0;
> > +	u64 alloc = *(u64 *)data;
> >
> >  	if (levels == 5 && !pgtable_l5_enabled())
> >  		levels = 4;
> > @@ -1382,8 +1381,6 @@ static int __init __kpti_install_ng_mappings(void *__unused)
> >
> >  	if (!cpu) {
> >  		int ret;
> > -
> > -		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> >  		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
> >  		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
> >
> > @@ -1414,16 +1411,16 @@ static int __init __kpti_install_ng_mappings(void *__unused)
> >  	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
> >  	cpu_uninstall_idmap();
> >
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
> >  	/* Check whether KPTI is going to be used */
> >  	if (!arm64_kernel_unmapped_at_el0())
> >  		return;
> > @@ -1436,8 +1433,14 @@ void __init kpti_install_ng_mappings(void)
> >  	if (arm64_use_ng_mappings)
> >  		return;
> >
> > +	alloc = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > +	if (!alloc)
> > +		panic("Failed to alloc page tables\n");
>
> Why are you adding this panic?

Because original code call the panic() when it fails to create
mapping of kpti_ng_temp_pgd and I think allocation is also part
of creating kpti_ng_temp_pgd too.
So, I added this panic() when allocation is failed for kpti_ng_temp_pgd.

--
Sincerely,
Yeoreum Yun
