Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322B2773C3
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Jan 2026 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857968; cv=fail; b=ngY2NSF8Ncg8X8ouT0cn/qU76Flg+j/oS+PviL66YcNBUuEdkVl3gXhrjGPIUP1zdfrwAboI7iGTcbnaft3op7Z35K5+EvcOghz8A00S26yGBINdPArVfP3zI4arpshp+348/fTpj+Gfvaw9l0v25JbHx52MTWdXuGDC7h6YHzE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857968; c=relaxed/simple;
	bh=z6VvIixwoZCEePhvTt15I/erijMBX/89FIala7K7Tfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZpbalQ5HdIBD/6IujkDQpUvgzL8xpcHBwvE1eWUDPiMGmhneO1U9nhDsdB6ePevI1ooy+UOQie4Jn83SRWQ+MCP6m+x4xKCSktI0RPxMaZ53c6CBFf6MH1pv9ElFh54kAQP9gigdHGVaz5GkskcOskmuZOpD4BxV6lqpsqEuowQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U9ME6360; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U9ME6360; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U9ME6360";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U9ME6360"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tStHRBE5LjLGb2VVGtKJXXe2HsXwGuVEHEYiSrfEL+Ggu94Q5pOZSfLWwkrONd4oFrwiYdl1JotOQvnz8g5Nw7CtKwL5n60nlFhbOGch2JmnXAJmBGfmMlYpusYtNLjo/i0iA5Eq75Ju8Eq8dYsFqc5E7EjB2be4Ohz5Swn/gly3B87B0p/ZRczw65Q8hDUuwI9bPgf0rE88XI53CrWJ1vho2QJFgiXGhW0CUNcopr0Cg65s0zPJChN9LoNTASq+0Ulh26u4DtLgXC6kS88XokIpcCa7xAiucJ/i0SPGhZir4MxCZer/yXwe9cMjBYOQDbiebaJCL4uoM9E5ylExww==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAbrXgDCwXQ/iUAbaxB0qlwc6Yc1bntX1eCu/Ao28YQ=;
 b=A265Vk5J1yID04PwN90rlu7t/voSn9N5a476ljD7DEiprMxzjgA4szy/HO+wwN8Sfywo9CUc5nNmlnfpol6/7Dej9DakUJnQfMX3ST5PUzh9Fxolw/wmEoQnGKp79NCHjiHPI9Sh5qNQFaW6A9V6TFt0PnSWS5LCZfr1qJdQAgouIPJi5uqx0Mn05jnHVazAIb9sBc24zSY01wIu+k2qKA87VAxDlUNWWEJoMTjC7spkKTQPsOb2dreUPJlxfppZej2m9CB+r8JY8AzOfAzH+qm2uJ03Xupyz+d7NdNIxjENYneSF8m/SXJ+ePWWATuVaErYtaeGy84XLdDX6GykfQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAbrXgDCwXQ/iUAbaxB0qlwc6Yc1bntX1eCu/Ao28YQ=;
 b=U9ME6360yChH/INoJg8/2um7WX7m0Im4lzEE5xhXsHnBDwqRub/Vzsh9K6H0scTmNzmBU5A6Gxo2+U7H+Kk6r7SjV74NHBWOIE5JNp1fyJCE5zmGBYsHzQbh774PkhW9fVW7Ol6qoEXi2eJgGskFdUqh2XOCkqftXMUMh3OlLuw=
Received: from AS4P190CA0066.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::9)
 by GV2PR08MB8123.eurprd08.prod.outlook.com (2603:10a6:150:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:25:57 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::93) by AS4P190CA0066.outlook.office365.com
 (2603:10a6:20b:656::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 21:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 21:25:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmAUQTlOsHyIhLlb/a8NUFEliZltRGasUmlEVAPIV8ct33uug35hEdX7hhdx7FR0MpdO4HdIDWKzhmpuL2U5q9Xs9/+O7cRxCmTY/uz9rS/ykSSwuBWOI7P56bKdUJQTiB0yvF2IdWAN8tZ/GBX5gKdflkG2ecK01vSnn5ZDLm5zHwJn814hzGWb4xmNMjExh8MSdhP0GjXlbpZXV/XSMI8T4bl6XKhr+jrLYfgPI0Xr+OqOV19VK2woCg8/s6l6iXyWBF3dZQjmsd4UgUttKWqXpmRx1dgpBgLQhpXHRCjLu9iA94FbJAMv08iBOZ9iPU9vy7Ajik6gyE/HZ+K45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAbrXgDCwXQ/iUAbaxB0qlwc6Yc1bntX1eCu/Ao28YQ=;
 b=QoDKszeFbiJPkucoicWYvY2o5Fwz+4kq+iVcQY0zmGfZjbaxx/eQy64rAXfLOe6IERJq9NQAnpGRQ2cFRhbaxh/S3SEwg7M2bD6BM/8qAdyfGAjk1wWczNPvcbozmLmisd47oc84UoBkZCRaws1SAbsn8hvANMmmgiVF4WiIroBIJMn/WpyAdii085sZEeqfCqvUU+U0tR0o64gtjHNhlCj6LRdh9mONlOAisO+71avRatWRifZ3f5wmuPQwiMmw98nnf9dJSdUExVfDpLP3Or8xS8k+GlRa8IiFooSWE69UuqxhbRtNAnuECgRGEluG36li2o6wI0Bi7gIM1XLanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAbrXgDCwXQ/iUAbaxB0qlwc6Yc1bntX1eCu/Ao28YQ=;
 b=U9ME6360yChH/INoJg8/2um7WX7m0Im4lzEE5xhXsHnBDwqRub/Vzsh9K6H0scTmNzmBU5A6Gxo2+U7H+Kk6r7SjV74NHBWOIE5JNp1fyJCE5zmGBYsHzQbh774PkhW9fVW7Ol6qoEXi2eJgGskFdUqh2XOCkqftXMUMh3OlLuw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAVPR08MB9062.eurprd08.prod.outlook.com
 (2603:10a6:102:32d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:24:53 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 21:24:53 +0000
Date: Mon, 19 Jan 2026 21:24:49 +0000
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
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while
 splitting the linear mapping
Message-ID: <aW6hISBu3hNYS771@e129823.arm.com>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW5p1ylQBNXTEmmq@willie-the-truck>
X-ClientProxiedBy: LO4P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::23) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAVPR08MB9062:EE_|AM4PEPF00027A66:EE_|GV2PR08MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: f082b398-8b17-4a61-3779-08de57a155ca
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?0KiA1R5sDQC5TB4nRsA3sdbjnLQV5zxKLB3+As/Pu2dvFUBnZMSRFZLZSguU?=
 =?us-ascii?Q?aJ4rSaoHEBHCicX7ado9jsnNFTHNNSJb2dtrujW2bSNHK5tMBH7qIoDNFoYu?=
 =?us-ascii?Q?05dLW2T5PEq1WyRA/W5mZO959ESVrAZhAHHTOb02i81Cp0P/HnBHaQ96b8A3?=
 =?us-ascii?Q?e9g0Z5I10sB6hItf4w4zlWu6PhNuhqeXifg5BTM6ZpRpU3lPXmd+hbWUS0oY?=
 =?us-ascii?Q?z6AyJUK/A0HHIY3fqj7O3cClQGx5TqMYO5Ny6qBbUpDYtGK42A1mlCNTKEK4?=
 =?us-ascii?Q?8p4b+r8ech1bzi2Qi6m/rHAsYm+4EjuN+ztyAzHJ+s7NdecQ1CQWB1ONLc61?=
 =?us-ascii?Q?AHqcQ3W5kODEz7seQaD3AHWn/Uj31AAzW8hipdaaqWC8DTgTP4sMMPOUQxPd?=
 =?us-ascii?Q?7b4CS15LbDz5wbss1UiwcKAFSZceXrWzQvxw8X6FMIwxPOWjAKRa+HczNFnM?=
 =?us-ascii?Q?fy2kqs+BB09EZcU5gVHFZN1TpnmRnQbYaL9mUU2O70yPeElFZHTeJ5jwlQVJ?=
 =?us-ascii?Q?122DPc9LjBovFppOz5zMpNgk38d4T6NXzR+KH/3zaaFijAwjFM+6V/8QEuqj?=
 =?us-ascii?Q?rGoSlO47PCvlVh1J60RZcXREj5hdkG9YydeHCGYFH29xDwqSRZSxVM5xiYGX?=
 =?us-ascii?Q?CAy+JfGd9p85pzPUEVba1GleFRMDSC7kXlhoVWTBN4Y3QdiwKnwQawKMecEi?=
 =?us-ascii?Q?WKz1nT51MihJZvywp/jzY0kIy1XfV9eVUD4ZewnHRu+0eGSni2XHnti18oB1?=
 =?us-ascii?Q?dg96OHFG6cwnwu8cJPNpjxqrlBlxoWro2KEezyBc8gqD92QyTOjouE5UvYhI?=
 =?us-ascii?Q?XUpUS9DdtlWmKqbfsA70JvC2Wqk1Najz/I9X5IUN+wPYV7G8kfmjQgIjjNKo?=
 =?us-ascii?Q?mjKDydVK/nMhDJ09IPuVANg4sbQIYqTLnZoHSlPpLhDkTCou3reGdbfYdVbX?=
 =?us-ascii?Q?q0u0JMeWU0VXRTekx4oQFtgqjycmh2DrNn/EZqyMkHM+gkG6qEwDb02Q2X6U?=
 =?us-ascii?Q?iFENzM3daLmVj00XR4IOPNU4+uJQ9/vmdyYYXohDIiY3iPkgvpdDI3XVGIHN?=
 =?us-ascii?Q?p6Ktk63gvIKwAuyanXt0HhfXM9qPd+E2j5J7yWjDDSApWLekXBJ5nudTy1mw?=
 =?us-ascii?Q?gFSmoNbnwiHvZODKihy/Z2mR5imx9e/ykdlq2t1JYOlZz9+z8dqeTAQ0RQRo?=
 =?us-ascii?Q?r6iAW77c2cP1nVycsiUGFxvEcV67MfPSyrHw81+2kt/kz7S9RVMafRbBkHik?=
 =?us-ascii?Q?9nDHc8o7Q8svSEAYRp+bAKbu4dpx1qMU8w0OwhgxhljOsLyw0xq1tBZtLZBO?=
 =?us-ascii?Q?+7wO1SP2MUbPL77bmodW+QYUyoSAi4U97O8k6Q28JoMK9VxwhuvBJ/XzyQDr?=
 =?us-ascii?Q?11ceXukSZW7LMmS6CJBwCVXpbrVFvDpyQCR60BUSXAiledQfEoMxyMCnnvpv?=
 =?us-ascii?Q?4CcAVA6XjJW6wV0PbcyaJ6R/z5XlIm8Iv3g8rUX7DDUzpWuIeS8IjYmRErxf?=
 =?us-ascii?Q?ap++4qxxPzmbQ8PWY1rJi/begApjCkx6VC+GAKb7BjsGjwQJ9O8df7k/5dij?=
 =?us-ascii?Q?Zj0l3WADZmLjmewAdj0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9062
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5594da01-a7b4-4522-9fc1-08de57a12f42
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|36860700013|35042699022|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3aCGPgzIuKEUUAdrT4HcdqQWZOL2GHd8zzcD/WE1PeqB4MN+cLK64nmG5WdN?=
 =?us-ascii?Q?W0+2h+HXJUpkqN3XBxlNyJ3NjW/swctiPKYvkoaODL0v5GrYCm6tlewTbOkr?=
 =?us-ascii?Q?XHDx9nTwePFCAI6N3SnurWii2zXQ/gJj2xpPgGqNKBzRiJnq1a7dh7iVd3zf?=
 =?us-ascii?Q?ELZ/BUe2S68SYAjJAZ2tg5Ln4cBqby4pf7z6HQsOOTOexuHfFRD9ajP5lhpK?=
 =?us-ascii?Q?IMLIzCMYoTd1n1EYdZ0uQdFpFD9a8mxozpXW6HTfW4JptQpvUHt5xkWisgai?=
 =?us-ascii?Q?P3MGGjW8CnF59NF/cU/XS6WgtktlXLFfTqimMzcCWOEHqyL533LHZulQs97s?=
 =?us-ascii?Q?sd2AbRe6xLIbVlAGXka8e+rZ6IUh29WBvv3Zyt1Y9wREEuyazgV91Et8/9a9?=
 =?us-ascii?Q?UcrpxSeS83avWXU8cBHruLLJBC3wbIoEpH78WGWSb+LyGwjRIR5+/IvydVqV?=
 =?us-ascii?Q?0i2O7YyPMSGor1bjPgF5Bw2Dk7AjbNVT2g89tvKgC2tYXQTsCx8YMtasQlOa?=
 =?us-ascii?Q?aw4Q8aAfNq0rXuyEG2PMkl+nfT6wsXdTQtqe6+lWMkKKoL0jNsnQBqogAW2R?=
 =?us-ascii?Q?u2bkGyrVVJJWRYwdL3TisqWmxTk+teDWOpp52wTT4l3BrbBdmKxM7hCKdmJC?=
 =?us-ascii?Q?6GH7d+x/HTqCrs9xb63xWnJ4VNeuh5b/jFaIlYbg4sBfug8itbGxBLukWsmM?=
 =?us-ascii?Q?i20k9OwGv9Jf5mCoZD5JvCLM3oa8cKxq70zk+cVJG76z0mHT+GasUrKuhDSs?=
 =?us-ascii?Q?bRXdwWTeTttNmb7kjNg1TbKlaZpFoTotwuOPsIuEp3ZxHTHOnVkn98sVDKk5?=
 =?us-ascii?Q?xAK5KfeDXzg+6wSBX5y9x6IFt9HIY9atfPpRQECn0hdyM9k+dzWrzqmOweSx?=
 =?us-ascii?Q?f9WftC24dwDDJs0QmaK3s7BJZecNlQZAxXAptKVN/ivbgLmeVHXh8RmAaZtE?=
 =?us-ascii?Q?kYB9dz/FdWbYll2UDFh3taG0NF2qzaOLIOBrRtksXZUQGLvFXAYQSbdYqwQA?=
 =?us-ascii?Q?//fgCE40NBW72K8CdiqwtLViqJzLZSmgEd9L/drugxwjrw86QOvn2aOzyLnx?=
 =?us-ascii?Q?dXMTuvxrtqZ1/t3HKOVeS1LtqH5PEvbdvphkxgCnI2Qllahbrh2+rjGG4QyB?=
 =?us-ascii?Q?ZLybPVGsMMoAou4EPWCQS34j2mkDzcdnKWfwGPaM5vjyYhFuPmvOo4+H5kA0?=
 =?us-ascii?Q?cC7TSqmiRg2Ww86eur6ZGNRx7qigqhMwfy7IhmghL6CokhKkRfnPRtgviZDa?=
 =?us-ascii?Q?AIhJJI/stipDnPDSzN5bHzLCzQnfQuc4ASyxdDjQPTjEe78ynvGIEGay3jHo?=
 =?us-ascii?Q?GrUOzdr7/q0JIE0+51JWB13l8NgM1ZgX3FGTr7FCAUJ74RGVr+EG+1JKfTy7?=
 =?us-ascii?Q?d9cgATMVrZJI5niSF4htt8CJDecLKMRAtJQVhy2Oq2meb4VX/nV+YQ3AGVkm?=
 =?us-ascii?Q?2oBbAOMicWNJT3+llOjcogQlyNyNyr7Ct7OXwHD3P2GifWmO6vRP457V76LY?=
 =?us-ascii?Q?uKLgtHDAbTZZEp4PDby+JhhaUsI0LWMhOvG6n34wYIns4/IS8RBC0gFgYG+R?=
 =?us-ascii?Q?m5pCIpJgqD5qGLMOoptjMOtSARhpEs0mPZ3pQWi4jZ7nVLuOrPDoYu76QSPq?=
 =?us-ascii?Q?cacFIoq9W/OOTg7euTOsJ+OWQkXsr8CW2FPsglxNOi0pxqu6pkYgV01b8in7?=
 =?us-ascii?Q?wpssyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(36860700013)(35042699022)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:25:57.2787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f082b398-8b17-4a61-3779-08de57a155ca
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8123

Hi Will,

> On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
> > +static int __init linear_map_prealloc_split_pgtables(void)
> > +{
> > +	int ret, i;
> > +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> > +	unsigned long lend = PAGE_END;
> > +	unsigned long kstart = (unsigned long)lm_alias(_stext);
> > +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
> > +
> > +	const struct mm_walk_ops collect_to_split_ops = {
> > +		.pud_entry	= collect_to_split_pud_entry,
> > +		.pmd_entry	= collect_to_split_pmd_entry
> > +	};
>
> Why do we need to rewalk the page-table here instead of collating the
> number of block mappings we put down when creating the linear map in
> the first place?

First, linear alias of the [_text, __init_begin) is not a target for
the split and it also seems strange to me to add code inside alloc_init_XXX()
that both checks an address range and counts to get the number of block mappings.

Second, for a future feature,
I hope to add some code to split "specfic" area to be spilt e.x)
to set a specific pkey for specific area.

In this case, it's useful to rewalk the page-table with the specific
range to get the number of block mapping.

>
> > +	split_pgtables_idx = 0;
> > +	split_pgtables_count = 0;
> > +
> > +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> > +						    &collect_to_split_ops,
> > +						    NULL, NULL);
> > +	if (!ret)
> > +		ret = walk_kernel_page_table_range_lockless(kend, lend,
> > +							    &collect_to_split_ops,
> > +							    NULL, NULL);
> > +	if (ret || !split_pgtables_count)
> > +		goto error;
> > +
> > +	ret = -ENOMEM;
> > +
> > +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
> > +				  GFP_KERNEL | __GFP_ZERO);
> > +	if (!split_pgtables)
> > +		goto error;
> > +
> > +	for (i = 0; i < split_pgtables_count; i++) {
> > +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
> > +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> > +		if (!split_pgtables[i])
> > +			goto error;
>
> This looks potentially expensive on the boot path and only gets worse as
> the amount of memory grows. Maybe we should predicate this preallocation
> on preempt-rt?

Agree. then I'll apply pre-allocation with PREEMPT_RT only.

Thanks for your review.

--
Sincerely,
Yeoreum Yun
