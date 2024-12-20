Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B471ABEB7
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734694794; cv=fail; b=NYJst823jV14LKUX3hjmpTxKtlCcrf99Sj9o7HzKjeVPMfCjf4BxOXOwPERPkIV0gdPUc7QNrf6ex/1I/Tf2Idvzor5hCdAB3q5cebkRI49dVv3oXi7R1AXpKusIFgEYzADDbVGW51l/+W+Ygflw/kMBeR5loTPu8nI+Esv6QF8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734694794; c=relaxed/simple;
	bh=SV/eYDdKUEzxzn2zEZbMFhcVGIha8GxArdIT2A3JiME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IcT19MsMzJ7+9jgMfGhJGX3cmdETcSPxYtxfDEqhBGDvBTCd0R0agxRmllIr0bFLvi05XNzJqMh+gin86DcWSt59hCuqPV184FQOesm2SQJky5v1Ybg6PM2QtZH7thWqJ7oZ0lkTv/gSrJfiejl5kMSFzrhCksba1SMPjRl90EA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=B6/h5krM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=B6/h5krM; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="B6/h5krM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="B6/h5krM"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wiUa9WRaJU67lYPdLQafbwX9ulfk0TJ6sQTKsxfcDVbME/621oTr3Wgq7wWiMaJaktbC1uytq+TzX7+CMRoWVje5zKC+Hw0IWwjv9mw9rjen5n3dpDQKBfDuniSy/X5U9XbY0vwdd6x2vTnZjGoZob7da1Mfo4cbSADaZZc1BppT4Z86tQqdGRTNZryA+YXr56qdWI+Fhdma+Bi13YSgmofptdlI5vAkuYAt/qalGOMQ/Pzz0jPJmpDiXxtdhsdDMsLNEFIfl0nDjmt6+K/GRCgkqKPfnbcRzqZhbKUwTaGOZOPldQnBb/oGHVlnzR459jVut3Ap2P32tjqdxzh/tQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV/eYDdKUEzxzn2zEZbMFhcVGIha8GxArdIT2A3JiME=;
 b=AnkxLr5Gf+LAFAMkEimhHif71JZgAkiiYyo3RKhMTx5oGV+3o5GeyWeAmdolD7XjA4B5enrOtAx9DVL8FxB70qusxJ48rgJ39Fexkk6kZncOYt7D+oCLOqs6Axd9GegkCtzx3TFTY4JG5AJD6ZEmPUsCL1s0sjpzJjlf+mg0tL7cpBaviJfH/aX/FNgpnR1Px5+fyJ1eD/nP+T2uH6/MbjAlahzLp4WCOVeNS/10IJ5l7+DqH8l5XlDOANNtwYHewcWdKeJ5JHxZMq5J0lRcXMFDOANNI6iRD3efHnWcxlMHHOCgBSaDPVAWz6JXr4fBZ5uitnjuGLlT/nxJfk9Dyg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV/eYDdKUEzxzn2zEZbMFhcVGIha8GxArdIT2A3JiME=;
 b=B6/h5krMNbrhrGTg3NRXyykygQvT4qbNXAT/MMjnigpr3qtDB3LzZ+AbcBwtPlDb6jBW4W+51yYm4cH6XHT2b9xDhzVMXddj21dHiskCfe3+vbTnS+O3zCO89FvSFSh4AYty5UFTMmXhQDGfTnLL1T141lwOxxEWrLhsdplazgQ=
Received: from AS4P189CA0041.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::15)
 by PAWPR08MB9783.eurprd08.prod.outlook.com (2603:10a6:102:2ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:39:48 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::d4) by AS4P189CA0041.outlook.office365.com
 (2603:10a6:20b:5dd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Fri,
 20 Dec 2024 11:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 11:39:47 +0000
Received: ("Tessian outbound 050b604d5e06:v528"); Fri, 20 Dec 2024 11:39:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 96ad9075c2614762
X-TessianGatewayMetadata: VqSotO7coeJzeQb/y9/B3pURX+HoxqJJcBCt2wPW6Zr8uLB7eNqK2s+Cx+Gn/lXUxLYJMBBOlNqR2BjHUvq3HJCj09PiXuK9CnZ7ODq87nv8gBOPJWnKuPuYkg7T9x9GtYowJadOcKSDLs6TZtS+Eg==
X-CR-MTA-TID: 64aa7808
Received: from L1020f6caf7f6.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8D464D26-C1FE-45D6-ABB4-C38E4582B466.1;
	Fri, 20 Dec 2024 11:39:37 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L1020f6caf7f6.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 20 Dec 2024 11:39:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkO1HFhhjSZLqd2dGhmnUoXVygbvn4hxfEG7RItZZXn6yCD4j7020Y3TheL0ch8z4nwWOi7UWepxhxnsYONs8JLHx+1mL/yp7s3Iv9etpdDIaNnbBF8mmTWVXA5VmGCaLIcO0dGyAQ9OXIfzaga9U/E5q5Zzoyum6gtNZjVsqJqr5obd2fuWqwKZ48KBfhJmkUg2NVUCTZEfxxIi02Um8LWnwUhHSNWLx5GMMD3sqIjewmIXoPPePSTyrJmQOMVG3rgfCIBPubZspOpVS02tfK4PNGgFZSO79Kg1iDRqRIsKVuA4znxt2KOoSW9H17WI8W8kLGgk2SWLG82YyC0PLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV/eYDdKUEzxzn2zEZbMFhcVGIha8GxArdIT2A3JiME=;
 b=u0Qg7ip23J5KQzx7spcQAnUhsvvacSqVDiT5p9q0Qi1gBUMEwchrd2aqVFzT8zLawtvz1P5BwoNHa/88DPQC51ZnkO9v9qJlk9uKHqPykCQ1eBpWOVegiZHAm+rnp/cux/zCJRms77cU+BrUS4RO1oKef+unOd9lO0GjbuZQ4cQzCPMsx/IWsvtxuoQJPZM1pOqgGeIsqP656tS5Rzo+2XfLrHhLAj7oFuo9/uVOKgM4F4Shf1c8jO1Jr9DNVgI7upgXwSm//RhDwlZ0BnVUb7+d6SxlaxwhAbNijmWlBS5QqBNxBDTcTeR21DzCMnvLIv++OvMozkgas+8RRhJXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV/eYDdKUEzxzn2zEZbMFhcVGIha8GxArdIT2A3JiME=;
 b=B6/h5krMNbrhrGTg3NRXyykygQvT4qbNXAT/MMjnigpr3qtDB3LzZ+AbcBwtPlDb6jBW4W+51yYm4cH6XHT2b9xDhzVMXddj21dHiskCfe3+vbTnS+O3zCO89FvSFSh4AYty5UFTMmXhQDGfTnLL1T141lwOxxEWrLhsdplazgQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB8PR08MB5419.eurprd08.prod.outlook.com
 (2603:10a6:10:118::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 11:39:34 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:39:34 +0000
Date: Fri, 20 Dec 2024 11:39:31 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Message-ID: <Z2VXc/R/nOLGz+Cg@e129823.arm.com>
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
 <CAJ9a7VhxG_8R6j5uRCzOhLpy4ZmzyVvyW0+ryCcd4w7wqpZ2ew@mail.gmail.com>
 <Z2VJIh2+Z40bZi1e@e129823.arm.com>
 <ac537889-dc0a-4d2e-870b-c5a33279633e@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac537889-dc0a-4d2e-870b-c5a33279633e@arm.com>
X-ClientProxiedBy: LO2P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::25) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB8PR08MB5419:EE_|AM3PEPF00009BA1:EE_|PAWPR08MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: f65de39e-ad1f-4aea-d0e8-08dd20eb01a9
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?iBPhkP5OY9kEnlP3KAYBk1ODgPQCtl0B11xpWmyQNPzoGwMm/mO+1MdNtB8b?=
 =?us-ascii?Q?SqhMrcpSnd/B0ARy4nKR9oTVdhucg9L7kkj1ryLVS42Xselme4e94Onxx1Hd?=
 =?us-ascii?Q?kHLfhUMACcp3nH9PGlcXEI11e7EJc6YtlzSW3oPzgfpG8JweAm71y1RnyF9e?=
 =?us-ascii?Q?ayARKwM4lF9XFP0EJ3G/qtnHCxz6hU2lIf9Iv0NhkrtL4oB2mKkmiPF9n5cL?=
 =?us-ascii?Q?C1shG1819reUfrBoAD5aOixek+FUfF64lsf4WUPKPIDR2gRAfzZhI+J5Fivj?=
 =?us-ascii?Q?tNXItVvvxB50QFdAC88wCQyawW3Z/a5VTNXwXsIOAi5jg1Eez6K4Rr8+BsuU?=
 =?us-ascii?Q?M49xoqGnADZ8FOos75u7oCFx23l6G8nean5OpKU3APGMOvVs96QRlYwbQt4J?=
 =?us-ascii?Q?EJcx9mN0QULhRxUT2C5Ou5ZpCYJDU8loaprNQDP7V1D4UXMiz6YTGDEMP3st?=
 =?us-ascii?Q?puBadO/9R66Bhg2qMlWB23QIUyEDEUjyczW4xgNemq42I5bClLNPCfCpP8l0?=
 =?us-ascii?Q?/Ydnr9BwSkRlZawABLkXkIGLIBHiE+itO2CHS6xRiPUNj9UhnnAcmtuL8Pcn?=
 =?us-ascii?Q?7OKXkA6wIadsznYZMSB4okz+wuXkJEkiOSBzbO+BoZr0Aicsrk7d/JeckgDm?=
 =?us-ascii?Q?bpGRR+YLzYMa0tACgRpQEYDp+nLReT4VIsINVpOaPJ9FuPuvvE5W6xIt7kZY?=
 =?us-ascii?Q?D6stZx2QOJndAWpS9jQbzz/8m+MR/N2objS6AfQG+JgNwM1u4DBltxIddwwl?=
 =?us-ascii?Q?FTIIDWPE4Vxe+nOqqgk97jWEObBs4Jpn6SvHdoQyF5qXMM4HUoJgBJ2DZG8H?=
 =?us-ascii?Q?09+zo1PM5ZYOOJqZqnzZ+cFxPUpIDzO/+NmyQZ54lpxiIctFDFljYyXdm4xp?=
 =?us-ascii?Q?t8Kf6P+xVu4CBOiYLYsVpKPkkDKs9+YjMx15UqpOXjuzKgMePC+ZXcs072KL?=
 =?us-ascii?Q?iB2aV5RhxxPGoly6qwDAnrKiI0PYO0ibJabXr2JI1giJ22/+CBdIYeZ5mEdq?=
 =?us-ascii?Q?Y7oBjm0neQEh8BNHSdg/S66NDaSiKQavIMo2l7UY3ouHOHKpzhgNbimBX20h?=
 =?us-ascii?Q?lxb3Rpdd122h7NCDNynFrqa+q9IiAGS5H58OnCVgue54ZkwTUbEzOUhqatCt?=
 =?us-ascii?Q?JUYKFbiJVI/pUOyy4OO8ydfzEDZ8OlXh768pE4/D8XHBlZoLvvGRno7yN1O8?=
 =?us-ascii?Q?5i4jz65qFoa9Yty9xXPdQfy4g36B+8q6ajQm3QvoZi7gNIJNak2RlAP01jFv?=
 =?us-ascii?Q?bHTg0iOsLvaN2mZx5sixQPsswYZdPZLwa2LHbjSjfA0AaCc/wAKlLOcDiKxJ?=
 =?us-ascii?Q?gTfdIlzKdrDvxRpxPnM2mpdbFO2dx4hHhttMYSoTXsVjvwi6FX2LRYpnA2HX?=
 =?us-ascii?Q?JitNfC8iJRZrva1o8xjjuft5Dw8H?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5419
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	547640fe-10a7-44c9-328e-08dd20eaf991
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|14060799003|36860700013|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t+cR/OJ5n6rQWuaiG19KaOU9J5aA9g2PG01uoOl5OUzSdrtUuwrsyTgvOZhC?=
 =?us-ascii?Q?8gzE7HOkmFrES6NcM1T74weCm6gfyPOLTS/TbI0Ni9CvOcpJyLpicIdLN++B?=
 =?us-ascii?Q?kcokHiooENqsJNEY4EgzBF1htqJ+nnBArgjjlLTqnZNxTLcTwhwopkShTn+n?=
 =?us-ascii?Q?6kiX24RuoAuqLym8HepPHmEsGJtYZnsXoLCWTcid3XCC1C5CwRg6JswpYGtU?=
 =?us-ascii?Q?Y5RdYSD9dn3g9yifZgHmwH/uj3P5GsSlm74l8nZUNd8PXKqrNmqtEj2OcXTr?=
 =?us-ascii?Q?CUljaCsV4tG4FzYvGKCtYNKCtDDqhgYv2t7j8aoEjnYNXJwIMp3TRXSHw556?=
 =?us-ascii?Q?mwPkCsD0Q1yAkHYykjBU1w418+Q72RMH41rEl3FjrGF2TfnYFntewROwOr+t?=
 =?us-ascii?Q?IsIlw3E6ZEOZJHtkvlf4SaepZgOs2epPQY7DCwN8e3LOeemE5rvhQMe6YHkC?=
 =?us-ascii?Q?KlBYgMH7cKGejmA6NjvvdhA+sqOrMLoenYzM0bhngI846ZfRtTHxq334EyrS?=
 =?us-ascii?Q?i9zkSG0dwOem0bXeu8GtrOgor1avbDCIyfvSjjhNngdX1G43lv4lKPdHBUf+?=
 =?us-ascii?Q?BVtPmiS7uL6ymJSte1AT5AJwd/78oAToGfk1s16crGZtPYWsXj+LhxDXO/q5?=
 =?us-ascii?Q?Vx2U5aPZaEFe/wgGa25b2ykJDkPsh86C9wb20zHmnNfW7pMKDiq7o/jXcyKB?=
 =?us-ascii?Q?U20EgZ0Joi8VKiuyqaV1Y3OCQql0nVpLtuLclW0b9FyZrsl+2JYAZTy9Hxu+?=
 =?us-ascii?Q?PCJNmbjVHWN09PAUV7jGXYyCbmy8OkzkmjFx8pk9v7kDHMYQk3w5yn74bfa1?=
 =?us-ascii?Q?gxb+IEo/KLdplr39hTHkZjsba7Hj8F3qNJYf8iOPC7sVyCs1Ti4zY8KjEFAd?=
 =?us-ascii?Q?Q+tBtqk717gMcFFOwwDEfhyRzA87Mxk0d0w71y+J4bRwFQl1uYkRjAhUQHw1?=
 =?us-ascii?Q?J9NZ3kOwmqYyk8FlZXseB0TsqGQpgyZoTgLosm1hn/JUAh+v2Kw2Mi09GKBn?=
 =?us-ascii?Q?TGvHJENFbYtjrd1JJQ8J9EBqHbgGlYFWx/t7aE3KH2QPZb3YG97pUQOIq7BF?=
 =?us-ascii?Q?lOvs42aDzE4qOhwgNrBjFVL06kVHFoJfJoZ+XaaIujmxSN9IzaeeLWTkuOSQ?=
 =?us-ascii?Q?IETKJ9v3ezzu0rh/ZiVrLyDneetbE0dE4muzAXrQOXi9LVrzqKhlWPM2yl3j?=
 =?us-ascii?Q?iN2MY5g8DtTCE9R51yx5tLVgrFhRNPtpfgtemiODeqAICBsPDKdftEwI5rO8?=
 =?us-ascii?Q?sR4NAPU8evQH8k9LnnqrqJRroMcJSTMFfjVCXFyT4AehQrPP6lePwwexyQHm?=
 =?us-ascii?Q?HqY+d9ShJq5P7RR0Ujn3gZfGVbdkz37WvQCjs+pMzMO0oJUsyaS38XwHUm/L?=
 =?us-ascii?Q?mfqdGXH3R3qiwiZ3iBuElaRiUPGCDFTf1zXB7PN/nRf7vgiKP7cAjereS8sI?=
 =?us-ascii?Q?/qQ3d7I5SAjxkWqIWZ+y+Fsu4aHOfslmxs+ZO1pNR6O1Rj/j+wakqMLBnnsi?=
 =?us-ascii?Q?X6u91cFPiSOA3B0=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(14060799003)(36860700013)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:39:47.3319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f65de39e-ad1f-4aea-d0e8-08dd20eb01a9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9783

Hi Suzuki,
> On 20/12/2024 10:38, Yeoreum Yun wrote:
> > Hi Mike.
> >
> > > Notably missing is the same changes for the etm3x driver. The ETMv3.x
> > > and PTM1.x are supported by this driver, and these trace source
> > > variants are also supported in perf in the cs_etm.c code.
> >
> > But I wonder etmv3 needs to change. Because its spinlock is used only
> > via sysfs enable/disable path.
> > So, I think it doesn't need to change the lock type.
>
> ETM3 can be used in perf mode, similar to the ETM4x.
>
> So, you need to fix it as well.

Yes. But etmv3's etmdata->spinlock doesn't used in perf path
its usage is only in sysfs interface path.
That's why I think it could skip too.

Thanks.
