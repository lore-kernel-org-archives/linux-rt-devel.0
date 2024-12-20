Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC681C5CDC
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734695470; cv=fail; b=N6GJzoaf0qVPYL+2XikLN4xPQnjn2zL6D+l96jwXo1A+yLbCJE5wlqJmRv+gI7fFpp1JZbcKpZnyfc4wsTkfdcIAJ/P7VuTJAVCJSKvXMAsvVdOZLKTaHIRDoaoCLveSz89Q58Z4bR1bnRXQWn3/INQCiHG+2OZx685v/6ZIGW0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734695470; c=relaxed/simple;
	bh=2GFGzDi1m2n6SnO/vinbs3Gt5r1iN9VdAulvmUPY3FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A7VervqdmVZqmXeEmHspO611KYfeCCG1Et4Ojz7zNf1+tmesgSX9EsHg6+Jb+ThbmdcNXKeTc6CANYGSRgplRqlHzJrSzQKEgrojvA4kf26hfSrb9zxJogeeiHeROKZavXKQ9I0OZdqHH+FupD00s/UkSQ5xnsVzLwWI+6/ctww=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kGmbloST; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kGmbloST; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kGmbloST";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kGmbloST"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nyNrIsQddBDMF7+z3DM0nZ5xtrtfxVqiJomitGTDX7/ImIEBpzeqKMR7s0iEUVDaJ3iy34qGpK/PHaQfJXPXzPL6EFkpNN+6ny6xymjVjCv6e8Qi7OSrjfzfc6UDta93q9R/yHCDsxSe5KuJ4nxnXDofEePU78bKOVW4Wx3Zh8a5MJ1uD99F3hQQB4WgeGoCugxz/gkFXMpEOcU2d6tPU0c6R/2ViEOs0Kaq8ve5pENFS/uCRhsOSEGmdEVG8GVF1WKo5IZB1aE2QZ1g6NlJ2mBsHlKSfo09Nan3cB3ZUAlhuV+zYmTDgTzxjz/sFXyc2LwVH9eRkGc69cITiZJ0XA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GFGzDi1m2n6SnO/vinbs3Gt5r1iN9VdAulvmUPY3FM=;
 b=nNID6uvZfS9/UZqiSHQJPQmtK4OkHwtBbpziSCgo272z8txmSqjIU1wtxXgoQG6lYN91CXNn9BaN2rJgVZOfM19V9tEhVTFnY67N+CoF0mAYg2eGehdMFJNr0S0mEy2C4IRsq99+TKDktrMTrX3adt9ZfJn3YawsGgAF8CX81LPQ3p1qtaIubIxL01/LdqvI8ZLobDCBVvIWcjtmZpKtuOujYmfaKNcYOZKb+oBjmxsI+ukKbscLrQ0q8ttsZAbRR7Z3nIElhdt+If6avBVNcNBh1gOQdxMqH0UdFbCAn2JQCUjHAMsZGGSx7TRQpJxfCfkz7kdMGpXvfyfNSN4oBA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GFGzDi1m2n6SnO/vinbs3Gt5r1iN9VdAulvmUPY3FM=;
 b=kGmbloSTwowhPIv6u+q1xLU1jWHL5TFV0ojRc3IrPFqUMklYJIyPFA4mel8v1Ke5twT45m/8N7RD5XaMqYg6imqugOpSRf1/+Ov94ib6vCdlnqQj2MHSWMcBHLuJDl5/glT01h/EdjXabFol6LfmQbFCBqNArH14V4OZvB3jCI0=
Received: from DUZP191CA0066.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::9) by
 AS8PR08MB10247.eurprd08.prod.outlook.com (2603:10a6:20b:629::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:50:59 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com (2603:10a6:10:4fa::4)
 by DUZP191CA0066.outlook.office365.com (2603:10a6:10:4fa::9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16
 via Frontend Transport; Fri, 20 Dec 2024 11:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via
 Frontend Transport; Fri, 20 Dec 2024 11:50:58 +0000
Received: ("Tessian outbound 7d3f896333d7:v528"); Fri, 20 Dec 2024 11:50:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8fff45cf16e77dfd
X-TessianGatewayMetadata: 0YSOECxg//rI1O9KiHAx91JD3Ua9FFbl33fnxibuzYek4jI9nluBevuuGnpKwCs9lC5gBhXDr9QIWk5fudYY+j9C1BoRy0sATLO8fUD+LXoUOnNRj0+XPipyB+NJujg9nVw7YlTKY6+ThUHHc7fbdA==
X-CR-MTA-TID: 64aa7808
Received: from Lbc8b66a43c76.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id BC77C0C6-C887-46B8-A415-21FCF5D8F857.1;
	Fri, 20 Dec 2024 11:50:55 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lbc8b66a43c76.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 20 Dec 2024 11:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moQXhD8fiLlkF+UFhqC+dxGJONuJRVIWeDNxbIhdBvslFfRuS8WTI/LGL4u8trhUi6lIdHvamFjCgKr7Ss8Ng/5a3AyRWXmRDA4reVBmTFeW/5ody8QMsuPzbac3Xxf8EIBCabfgl1zRByfVHUCrQ6uRq4VmS2Cduay8PUFNH7ufZZXBOEIsNGZ4JQo90CgFK0yldLy5QY/O4xAiGYz+w/M+FQMAu50o98o4joc4tcx5LpNV6zWviOgcKyuyegCluzPGNVk7l2muv8+2Wv3r1xCx4nyeingkV1AxM4kOHiTMTMPjG0KQI6UN+I6hvZcisnF9pBkFdDLM7sIltPXLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GFGzDi1m2n6SnO/vinbs3Gt5r1iN9VdAulvmUPY3FM=;
 b=iDDoZU9sRzyM2wzjDGT4R/+xhJmSS7LhIfpeYXcUUUEdpcG1jmXkriQgiyw7gayRwcEz9pDZZFJGosc4ESzuy9ImYX0ntIjXZRxEaoio3knlStOanqL0nNPtoZp6t2lRLWi8fZ//vg5tuSDCK9N8Ae++Qo5N/i62RvQKQVrMZj85dhwQAPqVPyaDuqaHT15B2vrWt+ZsZNACspILyrUmht892SSgtoO+5jjjvmmGakXIM7FLJoM/pFWdUdKfHOOJ/hr3k3YTsImrjJykRsjFuKppR9lA7cfXmwdp6aVBAd9QMBa0vsfZUzS0HNnTi6qNGbf+z9cu90QRh1TXt4bkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GFGzDi1m2n6SnO/vinbs3Gt5r1iN9VdAulvmUPY3FM=;
 b=kGmbloSTwowhPIv6u+q1xLU1jWHL5TFV0ojRc3IrPFqUMklYJIyPFA4mel8v1Ke5twT45m/8N7RD5XaMqYg6imqugOpSRf1/+Ov94ib6vCdlnqQj2MHSWMcBHLuJDl5/glT01h/EdjXabFol6LfmQbFCBqNArH14V4OZvB3jCI0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU4PR08MB11186.eurprd08.prod.outlook.com
 (2603:10a6:10:577::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 11:50:48 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:50:42 +0000
Date: Fri, 20 Dec 2024 11:50:39 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Message-ID: <Z2VaD0K+jNaFYmbn@e129823.arm.com>
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
 <CAJ9a7VhxG_8R6j5uRCzOhLpy4ZmzyVvyW0+ryCcd4w7wqpZ2ew@mail.gmail.com>
 <Z2VJIh2+Z40bZi1e@e129823.arm.com>
 <ac537889-dc0a-4d2e-870b-c5a33279633e@arm.com>
 <Z2VXc/R/nOLGz+Cg@e129823.arm.com>
 <f0c15466-a27f-4cc2-90a1-476ec278d870@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c15466-a27f-4cc2-90a1-476ec278d870@arm.com>
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU4PR08MB11186:EE_|DU2PEPF0001E9C4:EE_|AS8PR08MB10247:EE_
X-MS-Office365-Filtering-Correlation-Id: ac380c5f-8e81-4f83-404f-08dd20ec91f0
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?CdR2IU3fXO/HIE3dUjzehiCoP/cf9koYWCtve+RHm89HlJhk8F+MYzm8VFQx?=
 =?us-ascii?Q?mcIeL8tIftgAUD4/hO5ZufKoYFz7QwS8f1byjU/kfb8nat9Q5o01ocZek/v+?=
 =?us-ascii?Q?w5BCDstv5nDfMO1PngMGxBBAhrjOn03yOvLG1JEY+Gr9A/ib3joHPFc+W2Kh?=
 =?us-ascii?Q?zoCfdBcyQkjLBuyJ//Jpz8hL0mDkDmnZSTPTineRLbGl4gXyZFz/hWYwO7Ww?=
 =?us-ascii?Q?rlk+bXovrZHT6AF24ERUYP4xvwntbXGqVGuwl/7MC9H6MmmKx70PyMOy8pKZ?=
 =?us-ascii?Q?rKq0AhYtIg28OKgf+KXAgFQ1HSmPvGkd3ZsCfdXguQm1jimWuMrAr1hoM7Xx?=
 =?us-ascii?Q?5TUUAQdqlAZKD2iHJegbLitECJVAdA5Mvm8OFtfFL7X6vd0udF7FDWonASLi?=
 =?us-ascii?Q?2gWLPhAqY2Q5Vqy4Eecf6I4VxPH2B9HUclfUXFpF+9BvYwc6Y8y4CiPooeI2?=
 =?us-ascii?Q?5rJeYsbbfShNWIy2Hzql28lvKx7xP1NIglUwIWqjDmDFyERPZN5hYteJMTwA?=
 =?us-ascii?Q?7U0c8dyyjOPf1JaS/3YAsSpPW16ae9hOCrzeD6UaZpjNARGxL+5c4WLjgapY?=
 =?us-ascii?Q?m5oBWXh/ALcyp1Tstb3K7bdlswJOLlGgHrrVxkrWXvkJf9uhVtKUCF+fDHks?=
 =?us-ascii?Q?BxzsmeNK4d7uJJ9kJ6qEXX1MaYNqm4fHCmoDK7VH6q8xXSemqLG8Am9fDk3z?=
 =?us-ascii?Q?WUGs0cRb1gCQ2jUcPjwlQSwzXjnSCdHi7eJAsBwLLqdwJR3iq6D0F05tYamb?=
 =?us-ascii?Q?JMuO7L/ses0qd8ZclpUWG6ZkeCOthTzEkNfL+6zkiRupjVmppE2gPF3b7Ist?=
 =?us-ascii?Q?cvelhjfelWieQ03U8ww6khMVOySnTJbz7tgQA9QgyjfPoro+Q2F5aYTXAcQl?=
 =?us-ascii?Q?DlJRiUnvsm3GVXUfjHTI3uRRaKEJ2FLao4qOhYGaH3tRK+0j4L65ylONEYb5?=
 =?us-ascii?Q?ktxS23vuqpVN3szOwVgUGCly6rHvjKt059c4YYegFD7n0363pJFr9f8ZI7lb?=
 =?us-ascii?Q?akRyh1Ut3ZBeTNP3zsnla4t+G9Skvy5YPXV0xiJp1ttyOrzP+gdZ26yVhnS6?=
 =?us-ascii?Q?tG1WA6kOaPWZ3DPanBT/Ls4VhZ3KooAyRzrNSl04AxUmzx9DMkwZglxFVEGe?=
 =?us-ascii?Q?cmPrR7knjey8ZqAG2RnIdQdFqv4bu+v5VWI4wiLV8oZjkEO7OYkUEj1bGFkJ?=
 =?us-ascii?Q?bVHJA2mRcr4rTtdqTt8oD7n4JQ3mJzWG2pGmNbS3Stz5pWka8aIEp9f8vsI0?=
 =?us-ascii?Q?kKOJVQBoKqCKpP3tZnW1rm2Ra8fYLw65ocLnh8TYzIydbiP46YNZ9wm79jwc?=
 =?us-ascii?Q?sOBVyUb/0AxJ3fIHcNsR7VgwKPrqdtQl9JOXH6Np2YC/WkHHjbucCJcp7Ejl?=
 =?us-ascii?Q?j9IF4KQolHWUJF2QDizVeiAVfXO5?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11186
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	80f44d52-35d7-45ad-ab44-08dd20ec87ce
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FF4FZVcZdH8XpskgzHjzqg3wWuenEOPqG8F4PwV2skYXnpopy4rtrNvj6kms?=
 =?us-ascii?Q?VeVuDwL/S7DqDIK/Noi06QcROfiloo6EWfiqfdPmfqX31XtcBJFRdB+Of6WK?=
 =?us-ascii?Q?tD+zwN1w0g3eHPSdEVWn00eSJ7NK5cRCAia4K5Bo6bh3r3KtMmG8432zkYMv?=
 =?us-ascii?Q?6Kinx2mjp77tZpj6EimlZvFMHneJZrK9goUq6RSHjnG5PVEvStsL5mNQsr1q?=
 =?us-ascii?Q?Rg++LQeIdYzNhv7L3OZUU1bwNgWWD2nBjDHncKpy+9fZMid8aaHx3BtVbWpC?=
 =?us-ascii?Q?5J8j7+/VkQt8Ch3XRFciyB41M9+CbOg6XYxjgbZ7RlOdYdN5z50fAvyAIaV1?=
 =?us-ascii?Q?AVZYOZI7byatvZ7R4RCbbG8YUKrfumNr2IOf6eyqufJ7rzTjNf9JfdLGvUFo?=
 =?us-ascii?Q?REXplgbLqI2J4iO5K8JnpF2Vj6IkXadUGHgOCCSd8OtEEAJOX683IPCyOxzR?=
 =?us-ascii?Q?Uk4j5/iZMV2fvosiBLbEVCxZxQOztRsDxEcbgjmT+tvxGuJ/0OGh4txiEbzR?=
 =?us-ascii?Q?ZTwWt3GifSGdSEdB30bdSmoUVOcOn20Dx8+vzjMPeccdQLeXG2obDEpKmvjR?=
 =?us-ascii?Q?TnWhvjI0zx2K2XqJ95sKmeBdFaRkYNUOGg7bkfgXL/Kgay0cQeM91EVpDkIQ?=
 =?us-ascii?Q?vLwp8yRC+ag42BHBAdTLadFnqj98uvGsPUcI2IPKWT6AmIchGMPJImSCJ+Tm?=
 =?us-ascii?Q?5K2BlS5l+x9dNY9fA3AwysaWphm9zy1nvw0afs1XUJ+pD7k2CFgH3KqRHGAM?=
 =?us-ascii?Q?Cp8DshBGOxnOxxVs77CJBoUhM+bYfbbZbNWrtNJ/zqvrOus4E2y/J+hZsewN?=
 =?us-ascii?Q?mNuFIJbuWMW8LRMppQkZRVjcItxzgNb/MhfyvF/SWzAbfONu5qjNw4vLf154?=
 =?us-ascii?Q?OZWvgKGP51FrzRDadgHb04szLK+vIjL0tdzyBtIxotH/VB7orIqlYNnMEsHs?=
 =?us-ascii?Q?l3YDWfJmV1mYMfcWXyx9ub2+4tQRlkXJq3PBwNmEjPDy6T/rbILdwd2Ga0qV?=
 =?us-ascii?Q?nIJlBENDzFiz9oVHqr7T+T8a9Z8p4DLWLN1DhIr9MuszFmnCgA0pDT+WNL3H?=
 =?us-ascii?Q?pLX/OUVwSMDBWwIKZkgTI1xSEA/FLXMzKEfsP6/girnPZpi0uQrAcM12Cm7A?=
 =?us-ascii?Q?F9utyvnNwoHZge7YmCOrIN0O+9ndfpwogL/q3eUpdO3peITTnenFNpEhBCl/?=
 =?us-ascii?Q?CjrfNESpJ/6MUfKldrC69lZrIFyK9kxFMcKpC5Np5JjHtpJLkFxitzaEetcq?=
 =?us-ascii?Q?DO+n6mpet66EIdSDySpsdHZhzexmM09TlX2pHvDhFZxAXRGApVfG1Mcz+y4T?=
 =?us-ascii?Q?o6q0kP7tQaI0p1o0xN3YKU8M2j+SaDu0lAIe73JCGTgffX8FOs5/LesdhDyp?=
 =?us-ascii?Q?vYaGlKx9oQXkJh2Ga4ykBt8Cz63X6T83ksBdvLR6uY1amCXZs1038MHryf4F?=
 =?us-ascii?Q?c987zmlCzy7FYprjfqu5Y+XvnxfYIYN2RZFedmSThyVnlXBGfm9upVMIuXrr?=
 =?us-ascii?Q?loS/6+/qKnCLK10=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:50:58.9290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac380c5f-8e81-4f83-404f-08dd20ec91f0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10247

Hi Suzuki,

> > > >
> > > > > Notably missing is the same changes for the etm3x driver. The ETMv3.x
> > > > > and PTM1.x are supported by this driver, and these trace source
> > > > > variants are also supported in perf in the cs_etm.c code.
> > > >
> > > > But I wonder etmv3 needs to change. Because its spinlock is used only
> > > > via sysfs enable/disable path.
> > > > So, I think it doesn't need to change the lock type.
> > >
> > > ETM3 can be used in perf mode, similar to the ETM4x.
> > >
> > > So, you need to fix it as well.
> >
> > Yes. But etmv3's etmdata->spinlock doesn't used in perf path
> > its usage is only in sysfs interface path.
> > That's why I think it could skip too.
>
> Ok, which I think is a problem, since the sysfs mode could overwrite the
> "config" while perf is preparing the config from the event parsing.
> And we would need it there. So, for the time being, we can accept this
> series, pending other review comments and address this issue separately

Agree. also it has the same problem in etm4.
I have a patchset for etm3/etm4 for this. but it's based on this series.
So, after this patch is mereged. I'll send related patch.
Thanks.
