Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE15274B2B
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767370545; cv=fail; b=b2N+w0rob4lvoU1tfM2jCUsDqJkQ6swDD+5/ojvsAISYDiuRVSWZo/aNd5ZdsHjSo4mCSmWfjt0lI+28EM59LGz/lIwpu2gbTaESiqQNannICqX0eIJDjPC9aqToNzYvVWY2NkCtT+KNbWZHX8kYRzb2G4EtENeG3hZGKU+ks5I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767370545; c=relaxed/simple;
	bh=ru/d4XGsMB1vVWN1Qqput1C0iHYSDQG5N9X0oDengQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mVz2Zcex1Fhohyp3qUBIzxhR71jUZU7Bnh6bPRIBOj1x2LqCjfKpQlwq1sVn5eyBIDLBmNe71GQjSCLpPfAf8/WApY3bUnxzXgH8GJMdJ9Xso2b0U7lo9IeT3RTA3SbQI8CMuQ0KcIdS1Nvk84tJ8p+JE+JlJ84PoG6zA0M0oAE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Bho9878h; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Bho9878h; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Bho9878h";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Bho9878h"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LxVy489fueVor/yxW3+xpeU9ygU5QWvjzclOzPSS4xbsWNe8M8EgRW/1uirAGZcjly3ZKcIZplAY6VLbuRbEGYd8qxqYxP87D7JpksdKB/Ju7yXMRY1BTi7rh5G+1TXQPGrZZ1g6q4onI97srHB55XEUbDbsZZgzyG9BdPgZtA3MpmH9a3CtUBR0Z4GzkpaCPcZZ0PWUga+UVI26Q18kdY5WXaRDbMDiD5ym1nbtAEp30O3Lgx86Q+nmNmJDivkwNCvd+V56QodlwgTgV79Yl0T65+ufbnVF4uLJVAiLZDYrYkEsOFt4nQi5B+D8UppMTdVBstKBqRhJ0iXh34HRbg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN1Fj4IxzDwCTFA6cXIWMIJL++/9022ADQDvp0IDPxY=;
 b=xpGvSE2jZs1iTqJsAM58a/JSebZx8K1mD4vGNjrowutsfVculSXDRqveQhSnYEqaumxKDnVxwKylfa7mLmDlxogCdcjZ1uz8XOgWMX/EO3gwVwxDeN1A6IZ6l5SHud1eBvkIxW+o1bCh+nuc4jTyGBQ7Uw62BGuYoM6ctj/gmtqT0resRhWZb12T4h6eyrOxkcg62fL4oZqXWgUfwWaSbOSNwGAt9XAHKahk9DKnEI8+XANd5CU/zUEb8e45cYFIvlyBejVUFW7V78YVwFoNTuqhmGNANV3tTaSH+b07NXFjlXXSwiTYvtbGpJHIpQi8qGqU6zNEoVU1V00HmMl5MA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN1Fj4IxzDwCTFA6cXIWMIJL++/9022ADQDvp0IDPxY=;
 b=Bho9878h1+wYsKB16TRiu1+VLUNA+rs7JKFrFAATF+s3RLPsYrA9c7TlVuZBtS7j/rLywoqj61Y85SyGZhLKjqdCRjW8fx2vxbTpRaKAi5GcWBAhCjWRoj9hxfTAyA2+kBGzXGw+QUyyHQkZ/eXRDDe9AA+QNmWaWhpG+Z+qmj0=
Received: from DU7P191CA0005.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::28)
 by VI1PR08MB5453.eurprd08.prod.outlook.com (2603:10a6:803:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 16:15:36 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::b9) by DU7P191CA0005.outlook.office365.com
 (2603:10a6:10:54e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 2
 Jan 2026 16:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Fri, 2 Jan 2026 16:15:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukB7FN3QxEHQU9G3YCNQxOUhcsn6/qfV3Cqb6GeW835AJG6CTz4N7il+AnH5nEYh5w1zC1VCXtV0kNuehyNCo+V64CgQ0UjHTvZAXmfk3ighrGKxg5LEPxybrWFEJKXe7sYCeVpR33rNY7yO+QO7BtKj7L0pWZrYbVnvFCTCfL6VxbRnaJe3kvpmSzRXsfrUvkXtaxmL9mdkZiLQ9REtWLBK/FcEOT+lFfDk8rTrdQbmyh8h4Gbv7ujDQMvykiR8vCoyIyXgyX1RkKd0Uk6g1ZIZ0PJ2LKDklPH0fx9lln042nkZT+IVWm+3+zYB1dk7zRWU3bTtVeJoT8Ob2BlDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN1Fj4IxzDwCTFA6cXIWMIJL++/9022ADQDvp0IDPxY=;
 b=QMzOXaQPrRP5IBDYNWLwzS2CsB4wBJQtEZYivoITL5XL15x7If9Y9HPW1qDvI8JhNpYj9FV4k8MBG2FWBvvQu3WhBz/c1m/MguZdH9J9CAgDLo+ozpOtcpRfLPOp7J6Y2juFRpAkE4M5fEcT8HhzY8JOnNkYbyF0Z46aYuVf+8Q/m+CSXiHzHHfMfrwphfT1739gq+1VjW6BQV5d1lFCbfvIVzw/Z8LXZcS5UXHuBPD+Okx2qmfxpkui4G5xdpq/yad+UDzx7DRiD3mh3ghVMt16dn0Vft0y9PCiosvmXB313TSk8NZ/w7OAZ2xN8AU87eEbjxIYgHGB9LWOU43V7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN1Fj4IxzDwCTFA6cXIWMIJL++/9022ADQDvp0IDPxY=;
 b=Bho9878h1+wYsKB16TRiu1+VLUNA+rs7JKFrFAATF+s3RLPsYrA9c7TlVuZBtS7j/rLywoqj61Y85SyGZhLKjqdCRjW8fx2vxbTpRaKAi5GcWBAhCjWRoj9hxfTAyA2+kBGzXGw+QUyyHQkZ/eXRDDe9AA+QNmWaWhpG+Z+qmj0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by GV1PR08MB10671.eurprd08.prod.outlook.com
 (2603:10a6:150:16e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 16:14:31 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%5]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 16:14:31 +0000
Date: Fri, 2 Jan 2026 16:14:28 +0000
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
Subject: Re: [PATCH v4 2/3] arm64: mmu: avoid allocating pages while
 splitting the linear mapping
Message-ID: <aVfu5EZM1XyJjrYp@e129823.arm.com>
References: <20260102150736.1378818-1-yeoreum.yun@arm.com>
 <20260102150736.1378818-3-yeoreum.yun@arm.com>
 <df057023-7a06-41f7-ac6f-caf6b8d8c144@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df057023-7a06-41f7-ac6f-caf6b8d8c144@arm.com>
X-ClientProxiedBy: LO4P123CA0166.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::9) To PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA6PR08MB10526:EE_|GV1PR08MB10671:EE_|DB5PEPF00014B98:EE_|VI1PR08MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0368ea-d7c6-4f71-da4b-08de4a1a29a8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?N+eOSsCBVBLkpsUZa7kxU+lOK5ttV+nz266gOU6zXsEx1NeZrd4P16pgpQYS?=
 =?us-ascii?Q?+U8DTIsjGb2Ij9Bz6m7VbaBz7+C6Wwns+hd4H1mAH2VQX9Mxgy4U8K1oNxbe?=
 =?us-ascii?Q?Zagrm61xDk6MaNuQAX2e4HGoFj92lVot0mjGgwc5Ljp/zj9q/KG0QI1GT9as?=
 =?us-ascii?Q?TSsNniDEPHFZzW4yUrSmztyPVlS5J+pZPTlNhbyWg/psOOgtZtzJ+umu1n59?=
 =?us-ascii?Q?EKlvIrUMpgVI3x/i6UUV3zGWHZeDv7Id0Nr0bHdW+ARx7ZIcWNzUQH81o1eC?=
 =?us-ascii?Q?yV0Gw8I8LyMW57osmksB/CkA+RIanOlhnNzFTLP6vxKhVXVlf/YjBMo0oFjX?=
 =?us-ascii?Q?z5fLaGMyA+dhpCZ7IK/ZvCeWfuVQM6LVQrqVfoERGgotnY6bE1E2pDmSLaag?=
 =?us-ascii?Q?mPdjAej6GrF0vUbO4/UVS4MG5gA69UZk+74BmZIO/LW2QZ9s9gbYyNdQLV7W?=
 =?us-ascii?Q?KLNmyStX7UMZ61U4EMECtgO0sWAAOOia1Vw05G0ATwQOeu7qpRleRpg4CaZX?=
 =?us-ascii?Q?wNbMXIYlBBTkyITMTLXSNMbsnFiWKvpYHd/uwH85/Rh0Chtx/vM9CEFX14/g?=
 =?us-ascii?Q?pexfs2EIQYPBwc+3VIh0Yxy3k74X/hcaZ1y/7d16vR+BRCD7Xuh0Y8CWWqWr?=
 =?us-ascii?Q?B6IrM15M7tPOwbkRFF1YGeKEEywccWtAm1xZZZiDcG49LTlsnoksioO4ZYNr?=
 =?us-ascii?Q?Y1JXIu7ZInXbmjAQQo8wdarRFz8coOarIXVNzGI2S/wRxZSUBxl8buSqQe+e?=
 =?us-ascii?Q?F1uJPlTfzSmFURZiQ3fCA9UJkkAlB1gLJYbyL7VxHVYW7S5PvOnH/ud9F9k2?=
 =?us-ascii?Q?8U522px9wkCUxMuCnCK+36+d5J33hukqoq+1ESA04ylZ2udjfHehNsTKgGAl?=
 =?us-ascii?Q?QRtL1hjwtMQR9UVu3PCke5NauTbVTICiolg0RWU7RERUZx+8PHAJNN+43e1c?=
 =?us-ascii?Q?zh8JRODr+EpM2wmTpknl74wNNC6RNWoHg46K0E4CXYUU7YyWNYX9HEMl5UoC?=
 =?us-ascii?Q?rgJ8LKLCcBIVLvUg2V9RB4pCVYIFh/OWcWwFVZBZ4tr7yvIv9TrO7aeMNN/g?=
 =?us-ascii?Q?vLRsqGn1whcJ5hZA4u4yQGQ5O77I/10vCq+/bM78mAUYA25zsB97PrtwcwRf?=
 =?us-ascii?Q?I4EMv/V2azh622UjGnrxPPj2922JXyXiVXip+J+gJnn5TN/qkwzthyhqovKc?=
 =?us-ascii?Q?ZugxNcKiirpfGKu31Gcha3erzANaVHOetWYvVNH+LTyKi99XfJTRxsHcMFlQ?=
 =?us-ascii?Q?jFs+YsR7JG/akKeISEd85fZ+MKdWfGuzqsgKXoggOqO0rasBNnAcRjUq149F?=
 =?us-ascii?Q?hHh+03Z9Nb//FomyCIJQA+ewaBBAHqi2AMqxtno1cerTlvkHONlcwIGaNUtZ?=
 =?us-ascii?Q?tEObc0cFJTlEuZb8Kll3kD5unM2DeM/aryaifwu2umASc+e9/R6GFG+FcK8A?=
 =?us-ascii?Q?YWNhLokyVGpONXhJuYLiiKD53PKZmW5H?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10671
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	444d74ae-8ab1-43d5-58b5-08de4a1a02db
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|7416014|376014|1800799024|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T4SIP81NySOVpRyHYWRNbZMjDlMduvbTmwlQDgSZpfMm2spRHbcMUFib4V66?=
 =?us-ascii?Q?3jhT2NW19JUjVeyP4ZSYcUdOU1ev7+2/Xc/2+692erBj/RwLtVmlpvpGgFt1?=
 =?us-ascii?Q?C5yyKn01AuUao9djfn0mn6My+MDD8iwNIJ4dIE9MSaMj54hcNBLv8HOAl+Jb?=
 =?us-ascii?Q?BMrHIqgkLLItitrypFH7UEK+2CYAaqIW/rP2Ahd83nwZxJJWRCmDJuNVHF07?=
 =?us-ascii?Q?jwk1lqpWh5lFvxGh/vBPaFO73dz1S0ELQtRGx2t3O0YgOWeoWIK82qozNj3N?=
 =?us-ascii?Q?+v8VSCvctvt4Ogy5iD4YYAseLi0ezIJ+UOqVzUdNWKwTg8nL5mkLmAi6ZPgk?=
 =?us-ascii?Q?gUCBnP4sAa1fyjbRCRlsVtt3O+f3OaR+iS8xv/ZTy8yjD/6jvJyh1l1XdyXs?=
 =?us-ascii?Q?zmYa5m7c8FRGKxE06FsavxbLR2hObwlhYkJfY0x8/qjRp++zE4dDabJgDuu/?=
 =?us-ascii?Q?CH00yIJzsRmPbR4htkxXu8ESQZl6s70JHICI0GF2bwXNeWdsUugEgLQFEkn+?=
 =?us-ascii?Q?1pMEYTHwbSpQj7KHxzG+pivR67e254bTJH43C4zpJdP5V3PomvHOgy+g5MJe?=
 =?us-ascii?Q?ptePhL1JyP8/2BA2O2ua20cKVyYw+GUVoF9FOtJuuztmglFlhp8hfUJFlKrW?=
 =?us-ascii?Q?CHnc9SvJFd7Sf//TEYJAXSKwIgBcty55rzmGtSI1AHx3Qc19K6VQZY0y2Bra?=
 =?us-ascii?Q?dvYGAf1bJgomJxe4n9nZ16hYMOhby+nipnjJbhZauR3vO2z2dB9ROALN5c6+?=
 =?us-ascii?Q?ivXTsyGusaDo056tecKbAppLAQ3ef/FmD5C4l03zl1h3Limk6MkXqr2hr3qQ?=
 =?us-ascii?Q?TnRdI3/1Ytbd2qZjoeUlJSsZwTENwsHuW2Po2St8CF0PuHS4YLcNJGrLKaHd?=
 =?us-ascii?Q?mj2QCameK7uqslNNcNk/W7gtb4KQp4nNUVJVAy9VeNwryS2P6od6x53uyBly?=
 =?us-ascii?Q?swdRBlFLt0fP9LD9OpZeq30LXjBRsAj1sUUKwODrhOk1m4z3Ec0uOYlKFlZv?=
 =?us-ascii?Q?ikmY85Lgud63xa0V7EvvYnvbQ08JyA6f18KAVzrpOxKk4JDdwjHYDigqUJF5?=
 =?us-ascii?Q?q63vJlHPS4dPmpCXG1jLup8iGy4H30jyseRalb+Nk6ndQmzc6oRG9xKWGISd?=
 =?us-ascii?Q?Xp71Xxq0KNM6PIbbTd8TnY+TI84PWilYT7YuehFYkNQvLpgQfctAl8XKf7kG?=
 =?us-ascii?Q?uuLF5Hg0Q4fuxG4aqM1SogbXo087dqWRMd6RksQoROXBe/kaX26TRaQJHabs?=
 =?us-ascii?Q?ggCpISSkuFuFKl/aMwW+7/jrmTfWAzaDHnrH6jBGJTl96Jhr4GCGUkKXJkg/?=
 =?us-ascii?Q?Aj0exRbgAa2/3aWIzA8EJCK8IhuG8uwwbL14WtWhe8BHvSbGyMw/nPIVkF6x?=
 =?us-ascii?Q?7EEGOJ68kr1y970WLy9dL8dQBr+VWljA4bqXd0jv7lrkA7RrfamAa/Oy2YIm?=
 =?us-ascii?Q?/4p58P2kfO9cqWpVbCnezF40adGk04exqKnqGsrF1NGCYwENTHtU3KitMVol?=
 =?us-ascii?Q?kt+RldVC31a3iq5keidPuxuK3VJT2qxC22gLHN+t1dKtxEXrokDZwqPxlw5J?=
 =?us-ascii?Q?VWsW3S41Txalipxwq3k=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(7416014)(376014)(1800799024)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 16:15:36.0641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0368ea-d7c6-4f71-da4b-08de4a1a29a8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5453

Hi Ryan,

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
>
> Looks good from my perspective.
>
> I have a couple more small comments below. With those addressed:
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>
> > ---
> >  arch/arm64/mm/mmu.c | 204 +++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 166 insertions(+), 38 deletions(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 4b4908ae189b..cc086e91a506 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -529,18 +529,14 @@ static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
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
> > +static unsigned long split_pgtables_count;
> > +static unsigned long split_pgtables_idx;
>
> I think these could all be __initdata, if you make
> pgd_pgtable_get_preallocated() __init (see below) ?

I don't think so since range_split_to_ptes() couldn't be __init.
That's why there is warning while compiling below:

  WARNING: modpost: vmlinux: section mismatch in reference: range_split_to_ptes+0x3c (section: .text) -> pgd_pgtable_get_preallocated (section: .init.text)
>
> >
> > +static __always_inline void __pgd_pgtable_init(struct mm_struct *mm,
>
> Is there a reason for __always_inline? If not, I think it's preferable to just
> leave it static and let the compiler decide.

Okay. I'll remove __always_inline. Thanks.

>
> > +					       struct ptdesc *ptdesc,
> > +					       enum pgtable_type pgtable_type)
> > +{
> >  	switch (pgtable_type) {
> >  	case TABLE_PTE:
> >  		BUG_ON(!pagetable_pte_ctor(mm, ptdesc));
> > @@ -555,26 +551,49 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> >  		pagetable_p4d_ctor(ptdesc);
> >  		break;
> >  	}
> > -
> > -	return pa;
> >  }
> >
> > -static phys_addr_t
> > -pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
> > +static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
> > +				       enum pgtable_type pgtable_type)
> >  {
> > -	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
> > +	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> > +	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> > +
> > +	if (!ptdesc)
> > +		return INVALID_PHYS_ADDR;
> > +
> > +	__pgd_pgtable_init(mm, ptdesc, pgtable_type);
> > +
> > +	return page_to_phys(ptdesc_page(ptdesc));
> >  }
> >
> > -static phys_addr_t __maybe_unused
> > +static phys_addr_t
> >  pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
> >  {
> > -	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
> > +	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
> >  }
> >
> >  static phys_addr_t
> >  pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
> >  {
> > -	return  __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
> > +	return  __pgd_pgtable_alloc(NULL, pgtable_type);
> > +}
> > +
> > +static phys_addr_t
> > +pgd_pgtable_get_preallocated(enum pgtable_type pgtable_type)
>
> I think this could probably be __init?

See above.

>
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
> >  }
> >
> >  static void split_contpte(pte_t *ptep)
> > @@ -586,7 +605,9 @@ static void split_contpte(pte_t *ptep)
> >  		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
> >  }
> >
> > -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> > +static int split_pmd(pmd_t *pmdp, pmd_t pmd,
> > +		     pgtable_alloc_t pgtable_alloc,
> > +		     bool to_cont)
>
> nit: this will easily fit in 2 lines and still be within 80 chars:

Okay. I'll change it.

>
> static int split_pmd(pmd_t *pmdp, pmd_t pmd, pgtable_alloc_t pgtable_alloc,
> 		     bool to_cont)
>
> >  {
> >  	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
> >  	unsigned long pfn = pmd_pfn(pmd);
> > @@ -595,7 +616,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> >  	pte_t *ptep;
> >  	int i;
> >
> > -	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
> > +	pte_phys = pgtable_alloc(TABLE_PTE);
> >  	if (pte_phys == INVALID_PHYS_ADDR)
> >  		return -ENOMEM;
> >  	ptep = (pte_t *)phys_to_virt(pte_phys);
> > @@ -630,7 +651,9 @@ static void split_contpmd(pmd_t *pmdp)
> >  		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
> >  }
> >
> > -static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> > +static int split_pud(pud_t *pudp, pud_t pud,
> > +		     pgtable_alloc_t pgtable_alloc,
> > +		     bool to_cont)
>
> nit: same comment.

Thanks for your review :D
BTW, except the __init related comments, Could I add R-b tag
after fixing others?

--
Sincerely,
Yeoreum Yun
