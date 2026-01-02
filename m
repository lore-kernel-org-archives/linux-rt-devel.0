Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8492E11B8
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356566; cv=fail; b=NPtVZtSjhgeoTiSrh2PTZJaSOVinYORzbuyU7RtvNzDpHy3QGwQ8TjbtFgyQjeuSCHtT9H9Bh1aDODLSkoBcu8g/lRzxsu+uDhbPNa5ygQ2bGlgvK4ZEXoxyvQK4wKIwF3I8Km33ncO4WwjPKMC2mdeBxNkMaYN/B3GhSLfGqpE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356566; c=relaxed/simple;
	bh=F604t7FI29FVj3AZzG9vmOx4GViLZX00RIjaUVDNvig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NwkkBJrvpGi+U68/FHlosxrRJPVppDVdLl+BqC369TBwcPyzz2To7cGJtLyuW2Tp8ikAlADiuCUchZvDRG4daFBuRRFCPtCqYNiznFscFGxAkC0a9gMTktOoXAhG0IKc+CP2Az6NslNjR8ANpKSO+nrlr7QrfemMsDQMcU8tO+w=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N7ftnP1q; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N7ftnP1q; arc=fail smtp.client-ip=52.101.72.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N7ftnP1q";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N7ftnP1q"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YoOk1BB4J0/tZG/AOIfazHt6sJeKnOlbrN1Nd9ifSEMfeUOFbr/EBRhrTDeHsZ3kNPDVzDuy+EzplPQwkBMTRwG4McI3W6q7WyRqWBIhe0GEh+MGOZiNVIXzbeg58z6sQQe3EjtbLBOau3Hvm8SeJymPE5gltnyFWXdUTOBjHf9Jqsn0ES6vbuiyLDYB+uC+X5FH8ZftKbvcyo1w0oLZvLcMyoHVV7Vmnl3QYdabl7hx8X6hT0AeGWn5z6Y+YHfThFOBXByuIGwO6QqL7gqAgViB2fRKjNDKchPpgfFXRRHGl/dd3ruo0UefUmFgbQ3iHXsvU+kwS2U6ASGpMT7brg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3v4cZXaDFqMnUlcgkVr7FWrgA7XXUeXS+vfa9CotMg=;
 b=VDejupK3NR4+xprO4NflCDcEQCb/ESijSFgTrb24gtNK1wSpYczF0ouai3Uic9YdOorbtkGC2pasmFEzTVCBBAOjoNDdNmNaO0o5M0jtn/mq5A5ilKB8995x6R7l1Mn1vyvtaCUCHRQTc7zI3Oyqfx6WSJ/jMYZYd6SR0bqmNUV7QKN5ezI59aWRZpERZ59GQAPdKS+d/iV/JM895T7MMSAUNbDh4KaWKw4aqfEg9ivxfsY2wfIhOdxgI7zX12A0iGpMUtjio3XDJ1sArhdE73GbU/P5Kq8wqWQ0Ee636rHUE4UHIURNK1qyVxKkRGjG7UYoxp6RrTGxl4Ke10zPUg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3v4cZXaDFqMnUlcgkVr7FWrgA7XXUeXS+vfa9CotMg=;
 b=N7ftnP1qrMRt+IdcXwLbAztmUr4guW+lhOFcD/RdoWIN8rKjRXC2Ptz/vzuZM1Ge9UNIRkex1Q3Q8smwKQAYnPeJWjdcnHqaSQeQgyvjNvktZ90TBU0VeBC0eO7nRY0+5jx5hqvTGOQiy0dPIGVO/Jg7LwaomaMoeCJTG+1ybRw=
Received: from DU2PR04CA0357.eurprd04.prod.outlook.com (2603:10a6:10:2b4::32)
 by AM0PR08MB5364.eurprd08.prod.outlook.com (2603:10a6:208:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 12:22:36 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::59) by DU2PR04CA0357.outlook.office365.com
 (2603:10a6:10:2b4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 2
 Jan 2026 12:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Fri, 2 Jan 2026 12:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAiYOyhAS0ncOo27Q2OC7PifgV5q3HhHTefnmEt9BcTY6glL6y0MHlYpLZ4IcmaS+x7iUliL5AE3xw+V2QDaZF9nbiZJ3DMlHhvbxjsJiZ+Nh/mxo4xj49hNR6K/aOykedVQWVyfdM1+KPanO93eSJYkJDkzxLS55rpEWx+zcHiWk2VR0pW3RZUTt4ZY6WnqcxyRlypsDB5DJNYo2aCuetekFuGOPdt+BJWKbvoPT+klpzypItHqn688GyH8LAFjM9DgdUXN8y5lC3AYqadqaExvg8xJfzsOlV5RPmR3SZ7vJoPCx751XPmILKO0xfAx1GRvbkFRvwrBudOeu/FT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3v4cZXaDFqMnUlcgkVr7FWrgA7XXUeXS+vfa9CotMg=;
 b=dWMlRXtRBCV+0QJYi4ehwMg9eCvVT22wYkAqx6LQ1S0js3MCnubk4UrFtTphTWwBB3NylSH9fKpzbHxXpYnNfWfucFB4vV5rk3XWMnIl7eUyif+PTIE6RIi0uFIVO7rGwmlgTzaoNSjFGD//eTxI11qCVT5sIIMvaDAAPatMen35ly6lm3l0DW5458vCpHTnSaBHj7NnbfqtILgBAjLHH3/R+wORsP01AZ8Kj0Lsp0X+bbrWV7bbw+eVH5YmWJ3/jR6UqafFcrrE2cjcfgsDETP9SA8WmKrXJQFUvK4vXSPAlgWhlUXM8aCysVhjItVN8CylDhP2gh2UkGw0eBhCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3v4cZXaDFqMnUlcgkVr7FWrgA7XXUeXS+vfa9CotMg=;
 b=N7ftnP1qrMRt+IdcXwLbAztmUr4guW+lhOFcD/RdoWIN8rKjRXC2Ptz/vzuZM1Ge9UNIRkex1Q3Q8smwKQAYnPeJWjdcnHqaSQeQgyvjNvktZ90TBU0VeBC0eO7nRY0+5jx5hqvTGOQiy0dPIGVO/Jg7LwaomaMoeCJTG+1ybRw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by AMBPR08MB11569.eurprd08.prod.outlook.com
 (2603:10a6:20b:6f1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 12:21:33 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%5]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 12:21:33 +0000
Date: Fri, 2 Jan 2026 12:21:30 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
	david@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
	dev.jain@arm.com, yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/2] arm64: mmu: avoid allocating pages while
 splitting the linear mapping
Message-ID: <aVe4SmuU1arLs14O@e129823.arm.com>
References: <20251218194750.395301-1-yeoreum.yun@arm.com>
 <20251218194750.395301-2-yeoreum.yun@arm.com>
 <cd1c9dd0-dc1a-497c-b78f-d6c6dde898d9@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1c9dd0-dc1a-497c-b78f-d6c6dde898d9@arm.com>
X-ClientProxiedBy: LO4P123CA0076.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::9) To PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA6PR08MB10526:EE_|AMBPR08MB11569:EE_|DB5PEPF00014B8A:EE_|AM0PR08MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: b062a24a-f199-4e10-63af-08de49f99d28
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?0aImBn5oH7KRsYkn//Z/zQIIhuoNhpmmE6WZ89KSS2nuXInSALyXl7GZr6FR?=
 =?us-ascii?Q?bqyQXOAAotCC76uweLy0mnkoc7Qc5vhsVkkeGa0d2yRsvGEZZaxX7h+VxI5a?=
 =?us-ascii?Q?5HeVLWpgDY5Lndt8f7CMu+IO/5RXPl0lgIsim4SmLBBdSKixi3envsMJj9Ca?=
 =?us-ascii?Q?lumPXt6iJd+Vis2qqw+jm/VEVQBNAgAr7e08rbbhZ2z9LxrH12XCrxYWTPkI?=
 =?us-ascii?Q?ZrzAJFiVsAVu5PPYkcYyIUsxdjVQ3ZC6xxS8u54eDT/W8PeS7aKqpPWLFqzx?=
 =?us-ascii?Q?ZM//nAYWuGbOdNC0qK07VsEk/I4Yw3crYUYflQVLgTNcSNjNByjgi0k5REss?=
 =?us-ascii?Q?NgJXas5rKnSmHkXd0Nu9LIGmBfM00p+R4LOmznWE6v/53mBw/XreBZpi45Gg?=
 =?us-ascii?Q?r1olRHsnhf7zxkuzV5z7oeBtW/yc/TMj3q7LpDdSpsojKuJkHba0QFWBfsAB?=
 =?us-ascii?Q?iXWMbEBr9a/vJ/SW9uTUp6bDmVDSa/30K4UAnXxuGfo2ITXeLKoZzC69EPay?=
 =?us-ascii?Q?edRvGhuXoUZR+dN97b4MguEZrLkR/XkuEtqx34QPAVl3JnYYBcyeG0LBrcOY?=
 =?us-ascii?Q?BFphe+MU26vCSWr+SK9j+S0A7dBJP6JF12SqWBJuaNbblBzmXYc5+7z+bcUv?=
 =?us-ascii?Q?mAs3B/UCbFltIOz/Rd/4YQagPCIR4amt4R+MfDu9+ncCrs3HFnr0K9EfVMtr?=
 =?us-ascii?Q?o+Hbscs07aNO/+lhAwyu1bxZqEICghMdZGJlcwqRGv3U6y2XH8Ln1juxBtEv?=
 =?us-ascii?Q?nWnSG9YZvsEfeHssgpWxnU/7Nj1okj4tfOyPIFNzENGP7HmtCxeKGQqeQDI5?=
 =?us-ascii?Q?GICgC4pnb7SN/t8LTN5I8CyPZoPhYdidwJeZ1c3o3CDkG2XWpiPf51wWD7gH?=
 =?us-ascii?Q?UcwmiAtEcnQHhgytx94Jh/Sn1OHAstq/p/1tvmYJ3iHnqV2RV4UTN6b3kqkG?=
 =?us-ascii?Q?twe8Slhkyv9DaI/C5e4nVKh2oHKjNPbysLOKClrsDMp/nZEenamG97IVOZW5?=
 =?us-ascii?Q?PIj8tGJDiORdAUa1+ZjsKVxukyw1adJMdebqDNCixvv/Q/17LiQ3cEQ06+A9?=
 =?us-ascii?Q?R6lz3owpZgRxQ/8VTDFWb6YrUWxNKMCqzOpyO18ePR+fAlcIVY9FLHpy2Brb?=
 =?us-ascii?Q?74EIgBxMSJlkYeO0xbTeegEdsQYOjnVIkW7E9D2FnOCbTPnA0SU2XT2k5gzp?=
 =?us-ascii?Q?XjkPh2CmnakPHDCYCnS7F+CqTIFvd75dRV6ZKkHv1ODTNm2UA10g9Sm31Gd8?=
 =?us-ascii?Q?OnIjfGwVmscoPieY2SNwn/BwJi8q0pnbSIUXiVRhdbm11DGG+5CBbKd0Wb9D?=
 =?us-ascii?Q?PSAiUvg2vsW0ur2hoHX7ghyn4Ao1qgPIp85KknVhBJ2c4fOuAN1hKSMNqAEn?=
 =?us-ascii?Q?pOJowtnR7KKKsH44l5aCnPY64lRmcfLRwYawY8SEcz3fzkYTQS5YbkmQuJR5?=
 =?us-ascii?Q?7wAmi0qVdDhuzhaurDz1XfzXEeQBBNLk?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11569
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c353d6ed-9494-484d-0728-08de49f9776f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|7416014|36860700013|1800799024|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ZoABTiNbsFd8lTyuOHW8KVHDQKYaDHjrk+gzJnHcNNq1eBjIIOcKrT9ejxO?=
 =?us-ascii?Q?cpa24wDqJ4nAQY6vC1u8L/v9xwDGhGFVF/dEeUkeW4kQfBqY/7dmEnpbspQ2?=
 =?us-ascii?Q?HPnWfUt3+Ryos4St+Wpy7QHjz3TBrIyflYjfTnsOJFH5Vook3ITn+Bh7rvZH?=
 =?us-ascii?Q?md6lUQGbNSydyJL6Jf3dWNh3xRcCJOuMMGo5nAI+zGbtZBygL2lO+PvgXQBg?=
 =?us-ascii?Q?My5zcPG+Md7Tny5s44PCDuctXc/pzugc9NwxEyrK/CFPdqHdnUSLNnn9Jt0k?=
 =?us-ascii?Q?cQv4rZz9YZ2lcmW0i5ACYThNkjzPdrshKpBCtQ2b0HuP28R66JF0XW8YtYOk?=
 =?us-ascii?Q?wtcgiOHc1hjbuYY9Q4/878F5X+W4+3HgfCxgSNZt/OribPTUwli1aiWlfPP4?=
 =?us-ascii?Q?jB3JvDCAFs5aPEtCjVjGKybCxs3QFb3Fvr8jWGJkHslzGDjDzl9Pv+pMIC8W?=
 =?us-ascii?Q?ovw0K2PA4+FjTdt1seaylGsKtxvZSxzHIci+GBZTCXEQE54wEMujgmwzMFPh?=
 =?us-ascii?Q?94IfShifXTEjAzPbgeuNuRj+cWSippsu1Xtwa2v70vB83K4md8pfMdednDrT?=
 =?us-ascii?Q?N1aet/DJFw+7ER2EzHK/kLebMFlC2IOFrc5vfaXvBJjxMiFzzMsUTzxfXUNy?=
 =?us-ascii?Q?wb6Y2v8xlJtS7eGdXYRZN+xj8DKJPOroHKOjZEk/ahkYADOshYjESazEYH7D?=
 =?us-ascii?Q?rbjAOLpvyzhTJlq9mcrn8qNaMHHd/sX1+RnmT19pa3ADBTuPkDaL9cmW3vR5?=
 =?us-ascii?Q?TfpMrKkjLp8MuGjKUgGPBypGiI8qfKNGC5zBlVep2N50IqDXUwgdS9oWBLyD?=
 =?us-ascii?Q?QTX947YlxFeiTdknO/FSA4peDa30bsRGh3BOJp3mYUbugPuC+lBvlW2bbJs2?=
 =?us-ascii?Q?ZEE9mecF7qRCkpqjJ3l1OtNyWcjtsv4T01aPPhwC04cAbBlen/tMGBmWA2CE?=
 =?us-ascii?Q?aQCpOZNewaciMMV28QYU6Jy4vrQAljh2z/HHDfcaNzPHiv4N1thmgYU7jLwy?=
 =?us-ascii?Q?MdD07yB6qYG+lQUa+ZvwVmfea0z/Y3DNB1tgXHT8w+opsymbo8CfkV+lYOuL?=
 =?us-ascii?Q?91ewpnLtAdcZThFdFiZxuDULdp91sQ5J7arntJC33W7aL63J2+yS7fuZWiJx?=
 =?us-ascii?Q?TGQ2AJuO9/5G4vVxo1p4FplM5Qb4en6CI30p2y8szKbkXZBwZ3WkVKufuAJe?=
 =?us-ascii?Q?CrLqoXf3DNbVFAfkLSCEI2ukknqT1PGZJFrDttpDXaP3ZP9gTZEmdA5xCh2/?=
 =?us-ascii?Q?x/+op2pa2H5QMrmqDdBsZDqe4/SNSTUSSK/Qe7rRAo8fayQfQ7tANSqXvPdA?=
 =?us-ascii?Q?EaInYH9VMoqhRO6Klul4b13DEiiS+mMVDzZOvyzDHRfASHjnZVvTyYydX264?=
 =?us-ascii?Q?YNQ4c3TM/NcgY8RfkCjzKfvuEvzSIiSFGb08n3AsYKn6/C41a9PPxuXdxBMG?=
 =?us-ascii?Q?MJ/7T41y6DpbzjepmKjWs2rk10nO6gwQd8g30weLdfIuBYUUuEKg8HgXg0cD?=
 =?us-ascii?Q?wGjZJPYgLEQ0dr/2sEmtM9owcsCYRDbeetWoNL5pvyYWn1gMdXiChNMvLqus?=
 =?us-ascii?Q?q4aexDFU7PJlO5NSH9I=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(376014)(7416014)(36860700013)(1800799024)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 12:22:36.4458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b062a24a-f199-4e10-63af-08de49f99d28
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5364

Hi Ryan,

Thanks for your review :)

> > linear_map_split_to_ptes() currently allocates page tables while
> > splitting the linear mapping into PTEs under stop_machine() using GFP_ATOMIC.
> >
> > This is fine for non-PREEMPT_RT configurations.
> > However, it becomes problematic on PREEMPT_RT, because
> > generic memory allocation/free APIs (e.g. pgtable_alloc(), __get_free_pages(), etc.)
> > cannot be called from a non-preemptible context, except for the _nolock() variants.
> > This is because generic memory allocation/free paths are sleepable,
> > as they rely on spin_lock(), which becomes sleepable on PREEMPT_RT.
> >
> > In other words, even calling pgtable_alloc() with GFP_ATOMIC is not permitted
> > in __linear_map_split_to_pte() when it is executed by the stopper thread,
> >  where preemption is disabled on PREEMPT_RT.
> >
> > To address this, the required number of page tables is first collected
> > and preallocated, and the preallocated page tables are then used
> > when splitting the linear mapping in __linear_map_split_to_pte().
> >
> > Fixes: 3df6979d222b ("arm64: mm: split linear mapping if BBML2 unsupported on secondary CPUs")
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/mm/mmu.c | 232 +++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 184 insertions(+), 48 deletions(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 9ae7ce00a7ef..96a9fa505e71 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -527,18 +527,15 @@ static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >  		panic("Failed to create page tables\n");
> >  }
> >
> > -static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> > -				       enum pgtable_type pgtable_type)
> > -{
> > -	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> > -	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> > -	phys_addr_t pa;
> > -
> > -	if (!ptdesc)
> > -		return INVALID_PHYS_ADDR;
> > -
> > -	pa = page_to_phys(ptdesc_page(ptdesc));
> > +static struct ptdesc **split_pgtables;
> > +static int split_pgtables_order;
> > +static unsigned long split_pgtables_count;
> > +static unsigned long split_pgtables_idx;
> >
> > +static __always_inline void __pgd_pgtable_init(struct mm_struct *mm,
> > +					       struct ptdesc *ptdesc,
> > +					       enum pgtable_type pgtable_type)
> > +{
> >  	switch (pgtable_type) {
> >  	case TABLE_PTE:
> >  		BUG_ON(!pagetable_pte_ctor(mm, ptdesc));
> > @@ -554,19 +551,28 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> >  		break;
> >  	}
> >
>
> nit: no need for this empty line

Okay. I'll remove..

>
> > -	return pa;
> >  }
> >
> > -static phys_addr_t
> > -pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
> > +static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>
> nit: all remaining callers pass gfp=GFP_PGTABLE_KERNEL so you could remove the
> param?

Agree. I'll remove it.

>
> > +				       enum pgtable_type pgtable_type)
> >  {
> > -	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
> > +	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> > +	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> > +
> > +	if (!ptdesc)
> > +		return INVALID_PHYS_ADDR;
> > +
> > +	__pgd_pgtable_init(mm, ptdesc, pgtable_type);
> > +
> > +	return page_to_phys(ptdesc_page(ptdesc));
> >  }
> >
> > +typedef phys_addr_t (split_pgtable_alloc_fn)(enum pgtable_type);
>
> This type is used more generally than just for splitting. Perhaps simply call it
> "pgtable_alloc_fn"?
>
> We also pass this type around in __create_pgd_mapping() and friends; perhaps we
> should have a preparatory patch to define this type and consistently use it
> everywhere instead of passing around "phys_addr_t (*pgtable_alloc)(enum
> pgtable_type)"?

Oh. I miss that __create_pgd_mapping() uses the same callback type.
I'll follow your suggestion. Thanks!

>
> > +
> >  static phys_addr_t __maybe_unused
>
> This is no longer __maybe_unused; you can drop the decorator.

Good point. Thanks!

>
> >  pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
> >  {
> > -	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
> > +	return __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
> >  }
> >
> >  static phys_addr_t
> > @@ -575,6 +581,23 @@ pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
> >  	return  __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
> >  }
> >
> > +static phys_addr_t
> > +pgd_pgtable_get_preallocated(enum pgtable_type pgtable_type)
> > +{
> > +	struct ptdesc *ptdesc;
> > +
> > +	if (WARN_ON(split_pgtables_idx >= split_pgtables_count))
> > +		return INVALID_PHYS_ADDR;
> > +
> > +	ptdesc = split_pgtables[split_pgtables_idx++];
> > +	if (!ptdesc)
> > +		return INVALID_PHYS_ADDR;
> > +
> > +	__pgd_pgtable_init(&init_mm, ptdesc, pgtable_type);
> > +
> > +	return page_to_phys(ptdesc_page(ptdesc));
> > +}
> > +
> >  static void split_contpte(pte_t *ptep)
> >  {
> >  	int i;
> > @@ -584,7 +607,9 @@ static void split_contpte(pte_t *ptep)
> >  		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
> >  }
> >
> > -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> > +static int split_pmd(pmd_t *pmdp, pmd_t pmd,
> > +		     split_pgtable_alloc_fn *pgtable_alloc_fn,
>
> nit: I believe the * has no effect when passing function pointers and the usual
> convention in Linux is to not use the *. Existing functions are also calling it
> "pgtable_alloc" so perhaps this is a bit more consistent:
>
> pgtable_alloc_fn pgtable_alloc
>
> (same nitty comment for all uses below :) )

You're right. It just my *bad* habit. I'll remove it.
>
> > +		     bool to_cont)
> >  {
> >  	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
> >  	unsigned long pfn = pmd_pfn(pmd);
> > @@ -593,7 +618,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> >  	pte_t *ptep;
> >  	int i;
> >
> > -	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
> > +	pte_phys = pgtable_alloc_fn(TABLE_PTE);
> >  	if (pte_phys == INVALID_PHYS_ADDR)
> >  		return -ENOMEM;
> >  	ptep = (pte_t *)phys_to_virt(pte_phys);
> > @@ -628,7 +653,9 @@ static void split_contpmd(pmd_t *pmdp)
> >  		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
> >  }
> >
> > -static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> > +static int split_pud(pud_t *pudp, pud_t pud,
> > +		     split_pgtable_alloc_fn *pgtable_alloc_fn,
> > +		     bool to_cont)
> >  {
> >  	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
> >  	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
> > @@ -638,7 +665,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> >  	pmd_t *pmdp;
> >  	int i;
> >
> > -	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
> > +	pmd_phys = pgtable_alloc_fn(TABLE_PMD);
> >  	if (pmd_phys == INVALID_PHYS_ADDR)
> >  		return -ENOMEM;
> >  	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
> > @@ -707,7 +734,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
> >  	if (!pud_present(pud))
> >  		goto out;
> >  	if (pud_leaf(pud)) {
> > -		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
> > +		ret = split_pud(pudp, pud, pgd_pgtable_alloc_init_mm, true);
> >  		if (ret)
> >  			goto out;
> >  	}
> > @@ -732,7 +759,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
> >  		 */
> >  		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
> >  			goto out;
> > -		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
> > +		ret = split_pmd(pmdp, pmd, pgd_pgtable_alloc_init_mm, true);
> >  		if (ret)
> >  			goto out;
> >  	}
> > @@ -831,34 +858,35 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
> >  static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
> >  				   unsigned long next, struct mm_walk *walk)
> >  {
> > -	gfp_t gfp = *(gfp_t *)walk->private;
> > +	split_pgtable_alloc_fn *pgtable_alloc_fn = walk->private;
> >  	pud_t pud = pudp_get(pudp);
> > -	int ret = 0;
> >
> > -	if (pud_leaf(pud))
> > -		ret = split_pud(pudp, pud, gfp, false);
> > +	if (!pud_leaf(pud))
> > +		return 0;
> >
> > -	return ret;
> > +	return split_pud(pudp, pud, pgtable_alloc_fn, false);
>
> why are you changing the layout of this function? Seems like unneccessary churn.
> Just pass pgtable_alloc to split_pud() instead of gfp.
>
> >  }
> >
> >  static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
> >  				   unsigned long next, struct mm_walk *walk)
> >  {
> > -	gfp_t gfp = *(gfp_t *)walk->private;
> > +	split_pgtable_alloc_fn *pgtable_alloc_fn = walk->private;
> >  	pmd_t pmd = pmdp_get(pmdp);
> > -	int ret = 0;
> > +	int ret;
> >
> > -	if (pmd_leaf(pmd)) {
> > -		if (pmd_cont(pmd))
> > -			split_contpmd(pmdp);
> > -		ret = split_pmd(pmdp, pmd, gfp, false);
> > +	if (!pmd_leaf(pmd))
> > +		return 0;
> >
> > -		/*
> > -		 * We have split the pmd directly to ptes so there is no need to
> > -		 * visit each pte to check if they are contpte.
> > -		 */
> > -		walk->action = ACTION_CONTINUE;
> > -	}
> > +	if (pmd_cont(pmd))
> > +		split_contpmd(pmdp);
> > +
> > +	ret = split_pmd(pmdp, pmd, pgtable_alloc_fn, false);
> > +
> > +	/*
> > +	 * We have split the pmd directly to ptes so there is no need to
> > +	 * visit each pte to check if they are contpte.
> > +	 */
> > +	walk->action = ACTION_CONTINUE;
>
> Same comment; no need to change the layout of the function.

Okay. I'll keep the former layout.

>
> >
> >  	return ret;
> >  }
> > @@ -880,13 +908,15 @@ static const struct mm_walk_ops split_to_ptes_ops = {
> >  	.pte_entry	= split_to_ptes_pte_entry,
> >  };
> >
> > -static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
> > +static int range_split_to_ptes(unsigned long start, unsigned long end,
> > +			       split_pgtable_alloc_fn *pgtable_alloc_fn)
> >  {
> >  	int ret;
> >
> >  	arch_enter_lazy_mmu_mode();
> >  	ret = walk_kernel_page_table_range_lockless(start, end,
> > -					&split_to_ptes_ops, NULL, &gfp);
> > +						    &split_to_ptes_ops, NULL,
> > +						    pgtable_alloc_fn);
> >  	arch_leave_lazy_mmu_mode();
> >
> >  	return ret;
> > @@ -903,6 +933,105 @@ static void __init init_idmap_kpti_bbml2_flag(void)
> >  	smp_mb();
> >  }
> >
> > +static int __init
> > +collect_to_split_pud_entry(pud_t *pudp, unsigned long addr,
> > +			   unsigned long next, struct mm_walk *walk)
> > +{
> > +	pud_t pud = pudp_get(pudp);
> > +
> > +	if (pud_leaf(pud))
> > +		split_pgtables_count += 1 + PTRS_PER_PMD;
>
> I think you probably want:
>
> 	walk->action = ACTION_CONTINUE;
>
> Likely you will end up with the same behaviour regardless. But you should at
> least we consistent with collect_to_split_pmd_entry().

This is my fault to miss here. Thanks for catching this :)

>
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init
> > +collect_to_split_pmd_entry(pmd_t *pmdp, unsigned long addr,
> > +			   unsigned long next, struct mm_walk *walk)
> > +{
> > +	pmd_t pmd = pmdp_get(pmdp);
> > +
> > +	if (pmd_leaf(pmd))
> > +		split_pgtables_count++;
> > +
> > +	walk->action = ACTION_CONTINUE;
> > +
> > +	return 0;
> > +}
> > +
> > +static void __init linear_map_free_split_pgtables(void)
> > +{
> > +	int i;
> > +
> > +	if (!split_pgtables_count || !split_pgtables)
> > +		goto skip_free;
> > +
> > +	for (i = split_pgtables_idx; i < split_pgtables_count; i++) {
> > +		if (split_pgtables[i])
> > +			pagetable_free(split_pgtables[i]);
> > +	}
> > +
> > +	free_pages((unsigned long)split_pgtables, split_pgtables_order);
> > +
> > +skip_free:
> > +	split_pgtables = NULL;
> > +	split_pgtables_count = 0;
> > +	split_pgtables_idx = 0;
> > +	split_pgtables_order = 0;
> > +}
> > +
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
> > +
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
> > +	split_pgtables_order =
> > +		order_base_2(PAGE_ALIGN(split_pgtables_count *
> > +					sizeof(struct ptdesc *)) >> PAGE_SHIFT);
>
> Wouldn't this be simpler?
>
> 	split_pgtables_order = get_order(split_pgtables_count *
> 					 sizeof(struct ptdesc *));
>

Yes. that would be simpler. But I think we can use
kvmalloc() for split_pagtables since
linear_map_prealloc_split_pgtables() is called after mm_core_init().
So It could be dropped or Am I missing something?

> > +
> > +	split_pgtables = (struct ptdesc **) __get_free_pages(GFP_KERNEL | __GFP_ZERO,
> > +							     split_pgtables_order);
>
> Do you really need the cast? (I'm not sure).

Since, __get_free_pages() return is "unsigned long", cast is reqruied.
But as I said above, I think it could be replaced with the "kvmalloc()'
for split_pagetables.

>
> > +	if (!split_pgtables)
> > +		goto error;
> > +
> > +	for (i = 0; i < split_pgtables_count; i++) {
> > +		split_pgtables[i] = pagetable_alloc(GFP_KERNEL, 0);
>
> For consistency with other code, perhaps spell it out?:
>
> 	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> 	gfp_t gfp = GFP_PGTABLE_KERNEL & ~__GFP_ZERO;

Using the gfp_t gfp is fine but comments should be changed
since init_clear_pgtable() isn't use while split instead
spliting fills the pgtable with former mapped pages.

I'll use gfp with the proepr comments. Thanks!

>
> 	for (i = 0; i < split_pgtables_count; i++) {
> 		split_pgtables[i] = pagetable_alloc(gfp, 0);
>
> > +		if (!split_pgtables[i])
> > +			goto error;
> > +	}
> > +
> > +	ret = 0;
> > +
> > +error:
> > +	if (ret)
> > +		linear_map_free_split_pgtables();
> > +
> > +	return ret;
> > +}
>
> I wonder if there is value in generalizing this a bit to separate out the
> determination of the number of pages from the actual pre-allocation and free
> functions? Then you have a reusable pre-allocation function that you could also
> use for the KPTI case instead of having it have yet another private pre-allocator?

I see your last comments for this :D. I'll drop this comment.
>
> > +
> >  static int __init linear_map_split_to_ptes(void *__unused)
> >  {
> >  	/*
> > @@ -928,9 +1057,9 @@ static int __init linear_map_split_to_ptes(void *__unused)
> >  		 * PTE. The kernel alias remains static throughout runtime so
> >  		 * can continue to be safely mapped with large mappings.
> >  		 */
> > -		ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
> > +		ret = range_split_to_ptes(lstart, kstart, pgd_pgtable_get_preallocated);
> >  		if (!ret)
> > -			ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
> > +			ret = range_split_to_ptes(kend, lend, pgd_pgtable_get_preallocated);
> >  		if (ret)
> >  			panic("Failed to split linear map\n");
> >  		flush_tlb_kernel_range(lstart, lend);
> > @@ -963,10 +1092,16 @@ static int __init linear_map_split_to_ptes(void *__unused)
> >
> >  void __init linear_map_maybe_split_to_ptes(void)
> >  {
> > -	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()) {
> > -		init_idmap_kpti_bbml2_flag();
> > -		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
> > -	}
> > +	if (!linear_map_requires_bbml2 || system_supports_bbml2_noabort())
> > +		return;
> > +
> > +	if (linear_map_prealloc_split_pgtables())
> > +		panic("Failed to split linear map\n");
> > +
> > +	init_idmap_kpti_bbml2_flag();
> > +	stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
> > +
> > +	linear_map_free_split_pgtables();
> >  }
> >
> >  /*
> > @@ -1088,6 +1223,7 @@ bool arch_kfence_init_pool(void)
> >  	unsigned long end = start + KFENCE_POOL_SIZE;
> >  	int ret;
> >
> > +
>
> nit: Remove extra empty line.

Okay. I'll remove it.

>
> This is looking much cleaner now; nearly there!

Thanks for your detail review!

>
> Thanks,
> Ryan
>
>
> >  	/* Exit early if we know the linear map is already pte-mapped. */
> >  	if (!split_leaf_mapping_possible())
> >  		return true;
> > @@ -1097,7 +1233,7 @@ bool arch_kfence_init_pool(void)
> >  		return true;
> >
> >  	mutex_lock(&pgtable_split_lock);
> > -	ret = range_split_to_ptes(start, end, GFP_PGTABLE_KERNEL);
> > +	ret = range_split_to_ptes(start, end, pgd_pgtable_alloc_init_mm);
> >  	mutex_unlock(&pgtable_split_lock);
> >
> >  	/*
>

--
Sincerely,
Yeoreum Yun
