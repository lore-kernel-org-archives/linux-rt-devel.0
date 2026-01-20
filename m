Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A33D1CB2
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901461; cv=fail; b=JIgoqm2KyABkr42zHjb9Iotboya5hVYlL/0bWkkfXw4YtbBsJCf3QBI2eSCOvNsAb71zOGYJkJFOqQWw4yopIEmNg9gPy80LOpk5buJM9yv/H2DwTq+29BqOgA6J7Uv3uuwp7kN2VuYexmUclV/KtLt1qXwl/B5MjJh/FxPMmsA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901461; c=relaxed/simple;
	bh=OLPOE0hexToh7BBiJQbgsjYrRiiHe/REZLWS00P/8GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bSehBzha0WGjMzrPEA37T52ImMMiaPrCc62QZP6x39f9rxajtsLOcJlnoWv+Bl4JcTZQq2l6HIYyS4IVmI5Zf3hIYoah8QmvQjnbu7AZ1nZd9priKLKGPlN+JvzdRcU1k0qL3znaAHIgryyZPxVaXFL3Nmi1xJN+HNGRhbEvPLM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IRuNSOwT; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IRuNSOwT; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IRuNSOwT";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IRuNSOwT"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PKskKvNfUUIPW3HIVmYQz607EjDXm6HqX3lLb8blt2QuuL9LqWHHvcRsX9aQ/gULOOtwN9HxqS34hVpb+Q8m8VFuJAxAq2Kxo/TC6dGDwnponCJeQ6EwbnV+e60Rx7tdWax4MQlyNvmu0N1/bKD7lWZZRFH23OFCeFv3HJfbysTu09dDuaT0jGV8fWkI5JlASlFMx8dwuHif5iBk73dVpWVBLY6ohtR6B35uQh7YCZS1SZ1skJIK/W2wq6IUnLn6FSmQYFpvNr4ZFTNxYWw5e7R7EjUHses8B0IpAbi4ATplcAy8VEzNgvD+Y7rt16APXsRvJ7wWIsuj6gv0M7Y90g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1YijwatR5E2A2rH8JPicYu5qYSA4KYWhtkdy8yMACc=;
 b=HI8GITsZ7Kj8sOOO46LVZzy9+8iO+PqD3Vad+CCcJbP6mvys44C8bWHYT8pY9CwEwFbh2zZBKPHh1FmY28AroLisfjw0Z5cpCOSHQOzIKHqTgOQ9X+r7fHlkGhiUqKDdjU1w4HjwI5zvV8pVljjmLFJGS+wQJcLO3XvPOtF95YraY9AVNBLGbb6wR7D2Zn9A9esqFICpVVRuMQl7fWSAvxxcvmZkQAwPHHJOgigXST6bg0NUKJwP2U9QRY2ffpGQ6e7pgQYskf3ovFPGc3uN4+32HCbeiHm7eJW8fUBPUD+qSOxrw1W93tSnydGnSTQkQnfP7hFAiRCuGNRMX7kilQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1YijwatR5E2A2rH8JPicYu5qYSA4KYWhtkdy8yMACc=;
 b=IRuNSOwTjCwReZTnsi480lqbAtGOV8Y10/X17xHjCATVIl/bSStzOXNxU4c6tc1tESgEOz0VxHEXFnjHnqJn0cGbj4ycwYM87Mro2GhZrWAec0Xyp4RAi7IcUSR7G+squL7eNAP1uau3tNcXhbJxaAVHhjwAHRvMMYlt0Yadshk=
Received: from DU7P251CA0030.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::15)
 by PR3PR08MB5836.eurprd08.prod.outlook.com (2603:10a6:102:8f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 09:30:52 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::cb) by DU7P251CA0030.outlook.office365.com
 (2603:10a6:10:551::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 09:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 20 Jan 2026 09:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3qXDt5qB/JR7GH3qbXuLCR1XZJV6t8aky+LKR0My2z042GwEkfew7/uSDHuguO6v7krTV7j8Du2udeYpzILthv+1mbVst+SjBNIrY2Au6uCaw1fW3VHwnxBstAsDYuBfN/PuG7dRtmb8vMP18Q3qZaTyo33EGSOsnCBQk2G5l1cYNvpFwBwa2pQjaxAQOaPITegVKX39alSoh2dJAOtL8m9ns5IilIs4nyP0DmcqoMyRh/Iwk2Iih0S7BIqupRK71ZlRtQU6YFG6hw7j1ihAEIH65VvtiKM+3sy1gKglG6hUtSmJIPbYYKwy5Xuh0Fzwdk6wILEMseBvyThrwguiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1YijwatR5E2A2rH8JPicYu5qYSA4KYWhtkdy8yMACc=;
 b=Kn7ewjoiqAWef34Sj2b0uHEB9aMlrbWSdtcFOJ0NIX4o7R4jVbycUfBxH8AtLZPPcUCAM5dTZZNs1GhvCf07ghXqt4wnM7qmEdlh0hxwff+L07Nz6/sPHRNm/+n5K/70P33IfIB5xaglTXOCMfndM+GvQfiKBeppvFo9Le+OGU7gm0cbR4Vru5XoOc/JdJ4QLVQNQMUS8RDidojRrN8wsD5JCQo5lTLGaLwZS3I9Ii4t7MDS/SegVr/dMBJIiP9dxXK4BARwzOvMnKvmeKIkGn51+Pm34RnbtSmDObkQV14uYM3FMeH1AnIBVVkJk6SCA5NuhJmmVqCbKpdmIaSQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1YijwatR5E2A2rH8JPicYu5qYSA4KYWhtkdy8yMACc=;
 b=IRuNSOwTjCwReZTnsi480lqbAtGOV8Y10/X17xHjCATVIl/bSStzOXNxU4c6tc1tESgEOz0VxHEXFnjHnqJn0cGbj4ycwYM87Mro2GhZrWAec0Xyp4RAi7IcUSR7G+squL7eNAP1uau3tNcXhbJxaAVHhjwAHRvMMYlt0Yadshk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB9198.eurprd08.prod.outlook.com
 (2603:10a6:20b:579::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 09:29:49 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 09:29:48 +0000
Date: Tue, 20 Jan 2026 09:29:45 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	catalin.marinas@arm.com, akpm@linux-oundation.org, david@kernel.org,
	kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while
 splitting the linear mapping
Message-ID: <aW9LCX92T9t8iDco@e129823.arm.com>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck>
 <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB9198:EE_|DB1PEPF000509F9:EE_|PR3PR08MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f3c366-7cec-4774-f29c-08de58069ae7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?WwFTnA1u7X4C0lfs9X7/XD6XiGx7njThc1KGrsZnxJF4swTKeGl9D+IhNUsZ?=
 =?us-ascii?Q?qgkhUruBYCIrab8yTbM71t1fiulUhXo2j2XSNKJld08k+pmBzWOyrmpkb1nQ?=
 =?us-ascii?Q?FoxlQx00TZ7vL8q2zTlpH7X9iyYT9pDdoGHd9sW3QwLhFoFobvNJEuCfc6Fz?=
 =?us-ascii?Q?ctWQbqlIQJry1yf3qSEr/EFdK0zGLrR2W14IBg5OWSqLLl54UaflmR5MJZgk?=
 =?us-ascii?Q?0zN6PtPAI0z49HCnN/Uik0dlAvnHkMI3C0naAbApp4wTEhhMPn69u6kVWKeu?=
 =?us-ascii?Q?OOsYutoIk1v8I5I8hKDPo+SzSePsqyJL6fPm1sYKrQgtig/PuZ4TrPRLeHe1?=
 =?us-ascii?Q?F/0WrXl4lWXK5mIbQlHGQiNId2ChpqUslXo7e+8hisE0KiecubXmfMdeyaaq?=
 =?us-ascii?Q?TcoeMxAUpHK11naB7+Xho9PlpLEsS2RkwG4hNmCScujt2bggOmwPC1bkXwQ5?=
 =?us-ascii?Q?kKfQwwt9m6vUGAbMEtQe1PLGCf/tk1VD09GCWcBE1U+tYz81UccmDPHAmQ5U?=
 =?us-ascii?Q?5SXxadd0d0uiOTAcQx6GmPwF6UGeApMA+HehXAXXa1hBmNv6jbbwrvvOSnxp?=
 =?us-ascii?Q?kPPaD1QGt4KXOdvR3w53PnhWYY9eO2vXpLvJ+LM18wVDOvGig5/Gpq5fXFe3?=
 =?us-ascii?Q?1c9XfZru8+Qrp8nTVjhmnP5yVSDY7TtIDy5SV/Ffj2jCRK7q7/Jm2NOykRCU?=
 =?us-ascii?Q?/HGpt4sdZNMwJE3P1cqmomuuMq3Lufzk4hCv9MFnCulgfudvXC42w8bXSQCV?=
 =?us-ascii?Q?COBgoPgCnjvd4dyOWzrFwPHtPJyQWjCZMHV1MCTZpQnL+uAlgtXBE+ViDdKU?=
 =?us-ascii?Q?Ggca9fB1unM8KgOgBJVOc10CQDyfOVwOdflWcKMzVmm2snBHhVr2I8jalWNy?=
 =?us-ascii?Q?GyZI0KnbSsEPE+ulT57Sk66Npt3QsTLlzac6Swv7adrTFBdQY2Gqqa9Tz0Wd?=
 =?us-ascii?Q?vfFMFmIpSxQZjjJ0EDSEMM3DC50shjEEuAzTkYtACQUrHItXOrDO+U2oLUe6?=
 =?us-ascii?Q?i9PAh9iHb0/8BlvLs9Up/rKY/Tli8MvgxD6MZn1URklg581D4mZRLltfXF4D?=
 =?us-ascii?Q?gHhv+9zr1LjFnOgWCJRREd0vREozvRDJ80FO8CyfqyT1Y0WZJdZIUKMrGUR6?=
 =?us-ascii?Q?YBBpUkpMv555Erka3yyW67v2or4pPTjXhUG+qgt3kWrn22wO0W+YDvFOgmx4?=
 =?us-ascii?Q?90rffi3j+tlvPHL6T7WUD/udPtno+afG4BVHvsArvAUoXa0kJ40foJUmDuND?=
 =?us-ascii?Q?CeCLdsnbfKyhdCHtuyPzEbzvUbXDm5cBShQvEudnUJKMeXb/PLTHV9qd6kuJ?=
 =?us-ascii?Q?PA3z3u2MH3yzcOVFgXQJnXqBhQXPZfFCD4Y7MkhiGVdonFb/AY+GX6O4Qq51?=
 =?us-ascii?Q?QqAYX1uk8qQh7G0o16wigNmv653cMdXrqZ+FIAj4yy3DcFy+ZaQGDm0kt0WW?=
 =?us-ascii?Q?VScYrdjyRyWgZ98UID/0CALEdjoXeo92tM3m7GoQJZHshLNuDIFYZEeecgAp?=
 =?us-ascii?Q?RK4PHzcv6WrTZVIa7vLZlcZqTBMayowADG6xCYwSXlbtrawA3fviUH+kCkDF?=
 =?us-ascii?Q?zauIV9mHUNh3kSTTb7U=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9198
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	411e0038-8745-4a50-9930-08de5806749b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|14060799003|35042699022|82310400026|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?044vWPsSmjiFGE2fwQP0F3eLe2A8oDVuHxCUQ2Pq4mXyrMFy25qVV1ypeYOs?=
 =?us-ascii?Q?wBfI762Jcik6j6J9ivuasBCm7+2ULowg+1fRM4kTCWUATB44hug/S+WFlrXd?=
 =?us-ascii?Q?T4O5WGovQpsOWSWE3Iy4gXRjZsV6tsB6/RRIyDLK3dJSkpiGKacNtaM5JO1j?=
 =?us-ascii?Q?hFN3x1/cTqyIONQE7iauT2PhytUa3rfARi6jaMuarPUpBcYZib+Nu7/Apfv9?=
 =?us-ascii?Q?uyxglRbBQBNf00ASxOTGt7Av9s3sWs0E6uCfrK4LayWK9lyyLLEuN7YFx8Yf?=
 =?us-ascii?Q?c7/6uoIyTRsZ5cEy5vaUXUHITk2lNPsnfFPkn5isfsAJNfNn0zYG0kIS+YfR?=
 =?us-ascii?Q?sa3sBxol5OJgk/YvdaknE5l0CJzJ11CAXJ/X4gBdKw6gcoHI++KxMFgedTc6?=
 =?us-ascii?Q?35QGVCcbEURt/w1V2JxQTVBzl2aXSVI6HbPfYKrfl2cVo4GQEOu+NnTkoiIq?=
 =?us-ascii?Q?x2O5rcKgeOkJQL+ZG5aYF4Meoj2toM//VhbZkkGCOmIQKg/8ZPkXr8/B4RW0?=
 =?us-ascii?Q?Wqg1cHxfA60i9VCCQdo9mEZ8oU9zdW6vh20GQJ0qbJMI4qBbb5S02BCQzlgf?=
 =?us-ascii?Q?3mlzbk7W+KB4uIYXLQc55ujkVhQf9KFzehzHB/SYIoS3gPqRjCGHAZuHs1HX?=
 =?us-ascii?Q?XnhlITSMrnoKcChRWuky7S7JIBE+YstQkrpHkMaA+sb/r3lcPfZX0BHxmuhh?=
 =?us-ascii?Q?omNHiLG9wR9DUiJ2uewGaAsZpAoTmELsg/oPPT71+DSOzoSFTSIr46x+Mysd?=
 =?us-ascii?Q?wDL1oKYcCJucK5dTYhURwh26v+0z0Hh2hVD2n8xvyDueybknPnFLSnKmUYPL?=
 =?us-ascii?Q?N7cd/Nyi8kSAXP4HU6tCSw4j501BZfZfYcgwtIg+dFQ0t4WO3gzrn+aC1m6a?=
 =?us-ascii?Q?d591RhDXCuD0TMgMwFOlqPeHVq6EFy6UA9CjrETc0PWT9ZYahLybFKt2VeGA?=
 =?us-ascii?Q?/ENjTt6GbQCxdrSVWRF/XBqEsDN8JfV/dQ5oVtfZJwKCqRcmjxU93TCv/LWE?=
 =?us-ascii?Q?yLm10JLQF1XGdNw1AOCj2fyaq3DXZgtBB4y9SjjhjyU2XHry9d0Taz7GoDKl?=
 =?us-ascii?Q?KPGvDr1/lzgz9//4l6J9hbAInmtmJ3FZ9q936JsNIIIu2TZEVXoPnhAFtbA3?=
 =?us-ascii?Q?k0iNw0FSqMHW7LliSp7KMkygfxhnOcEKLlwOzPefqCGH2ie4qPGNkPlnvs/p?=
 =?us-ascii?Q?SNYOaW356MQUBQlOBD3aUfa7G/1S1XMiD92Rm7dKSAx1rQBE3DkTDQaibgqk?=
 =?us-ascii?Q?po3JvA+UCHG9UGmAmxRpBGwgWsnLP5c5Oe8B9SuDnmZK99M7xAaBlahNkxpP?=
 =?us-ascii?Q?K3t0hoQp2wq6qt25TJtUDIT9Zxw1qD3rkUhHfIZ9ddadC1loLZkFDPX8C8mP?=
 =?us-ascii?Q?O/ceQdv9kaXkdPcSaDrnfK98/ZuOoBhKLdwPticaRFRt7NS8p0gi+hXl2hSJ?=
 =?us-ascii?Q?M63G/mkjn5vGjg/byFgHIbWeKCu0OrodBPHxntb7HOvbdd7Iig+4IXufRFLS?=
 =?us-ascii?Q?v62GLeWllQL7Vb2xENKozvD7UU0/NEMZOMGBWlOg7HDgu/encjyrLRTnpcCs?=
 =?us-ascii?Q?lepYIts9gkl7TI4rDalEoMQWYbUulkofmxq/3al+EMlaeVA73auzxfaB3ehK?=
 =?us-ascii?Q?8elFgsLViGjA429xrZjdx7FCg0l1FFS3al0Fklzw58h6DTuM4KRDF+J0okH3?=
 =?us-ascii?Q?LIDZvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(14060799003)(35042699022)(82310400026)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 09:30:52.3561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f3c366-7cec-4774-f29c-08de58069ae7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5836

Hi Ryan
> On 19/01/2026 21:24, Yeoreum Yun wrote:
> > Hi Will,
> >
> >> On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
> >>> +static int __init linear_map_prealloc_split_pgtables(void)
> >>> +{
> >>> +	int ret, i;
> >>> +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> >>> +	unsigned long lend = PAGE_END;
> >>> +	unsigned long kstart = (unsigned long)lm_alias(_stext);
> >>> +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
> >>> +
> >>> +	const struct mm_walk_ops collect_to_split_ops = {
> >>> +		.pud_entry	= collect_to_split_pud_entry,
> >>> +		.pmd_entry	= collect_to_split_pmd_entry
> >>> +	};
> >>
> >> Why do we need to rewalk the page-table here instead of collating the
> >> number of block mappings we put down when creating the linear map in
> >> the first place?
>
> That's a good point; perhaps we can reuse the counters that this series introduces?
>
> https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/
>
> >
> > First, linear alias of the [_text, __init_begin) is not a target for
> > the split and it also seems strange to me to add code inside alloc_init_XXX()
> > that both checks an address range and counts to get the number of block mappings.
> >
> > Second, for a future feature,
> > I hope to add some code to split "specfic" area to be spilt e.x)
> > to set a specific pkey for specific area.
>
> Could you give more detail on this? My working assumption is that either the
> system supports BBML2 or it doesn't. If it doesn't, we need to split the whole
> linear map. If it does, we already have logic to split parts of the linear map
> when needed.

This is not for a linear mapping case. but for a "kernel text area".
As a draft, I want to mark some of kernel code can executable
both kernel and eBPF program.
(I'm trying to make eBPF program non-executable kernel code directly
with POE feature).
For this "executable area" both of kernel and eBPF program
-- typical example is exception entry, It need to split that specific
range and mark them with special POE index.

>
> >
> > In this case, it's useful to rewalk the page-table with the specific
> > range to get the number of block mapping.
> >
> >>
> >>> +	split_pgtables_idx = 0;
> >>> +	split_pgtables_count = 0;
> >>> +
> >>> +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> >>> +						    &collect_to_split_ops,
> >>> +						    NULL, NULL);
> >>> +	if (!ret)
> >>> +		ret = walk_kernel_page_table_range_lockless(kend, lend,
> >>> +							    &collect_to_split_ops,
> >>> +							    NULL, NULL);
> >>> +	if (ret || !split_pgtables_count)
> >>> +		goto error;
> >>> +
> >>> +	ret = -ENOMEM;
> >>> +
> >>> +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
> >>> +				  GFP_KERNEL | __GFP_ZERO);
> >>> +	if (!split_pgtables)
> >>> +		goto error;
> >>> +
> >>> +	for (i = 0; i < split_pgtables_count; i++) {
> >>> +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
> >>> +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> >>> +		if (!split_pgtables[i])
> >>> +			goto error;
> >>
> >> This looks potentially expensive on the boot path and only gets worse as
> >> the amount of memory grows. Maybe we should predicate this preallocation
> >> on preempt-rt?
> >
> > Agree. then I'll apply pre-allocation with PREEMPT_RT only.
>
> I guess I'm missing something obvious but I don't understand the problem here...
> We are only deferring the allocation of all these pgtables, so the cost is
> neutral surely? Had we correctly guessed that the system doesn't support BBML2
> earlier, we would have had to allocate all these pgtables earlier.
>
> Another way to look at it is that we are still allocating the same number of
> pgtables in the existing fallback path, it's just that we are doing it inside
> the stop_machine().
>
> My vote would be _not_ to have a separate path for PREEMPT_RT, which will end up
> with significantly less testing...

IIUC, Will's mention is additional memory allocation for
"split_pgtables" where saved "pre-allocate" page tables.
As the memory increase, definitely this size would increase the cost.

And this cost need not to burden for !PREEMPT_RT since
it can use memory allocation in stop_machine() with GFP_ATOMIC.

But I also agree in the aspect that if that cost not much of huge,
It's also convincing and additionally, as I mentioned in another thread,
It would be good not to give a hallucination GFP_ATOMIC is fine for
everywhere even in the PREEMPT_RT.

--
Sincerely,
Yeoreum Yun
