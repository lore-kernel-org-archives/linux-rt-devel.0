Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE329A1
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689213; cv=fail; b=mT8vtAS2N3hAAy23pZtJaLsUs8TyKd+aiv6Us5Llg7RAISa5dakRg3kw2CHuCrE4l1o1j5lvMJ2YWAJazgpU+fQw8hTb63px/FJgvOxCT/EM7DP9ZS+PPK2y8VDGKB2YENMNiGcmkns6x/MYO8uA8pzB8jZFUWW9bkLg0RCsjIw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689213; c=relaxed/simple;
	bh=qLECX5E61yFzV7Yf85FKrWDseVlNUC4Q76tnJG257us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=umneGZBiYXdwDFoMMAKNmlT1dv0tU9qojLP1Q/SY97dq995cVDyAaC1JHN7fYJr7SrKEhOZb2RXy1gW7iKJfCihLDWY7QKdKQHNhkuGdj99bmygDL/q2i6+QUnldKQLaCUvb2kWCS4kLspulV2+6OwMkXu5HRUKLTqz27y/scxA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RNvD/zb4; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RNvD/zb4; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RNvD/zb4";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RNvD/zb4"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qKNCZd6f5OjYXvWkbtCYbfh9FZkuCyuM/k/wUPZzH+Eapi4OdzbbT5Jxq+V3R1Cvqw2TNR4Dr5ZkQgMtFs1R0yeR5ShA7AeQBTy+a94TzG0qsMsvTvOL9HtS5DrtdzIHDBC6Fo3hS6XpiM3z7mcm07X0StZwcWWHAvqPMZ6Gy/Il3Q1OIh78PVtzx+jMwOIzJ9H4JOwcNpNepLm0GsTDHLeJbwto/cjeQJH200T9F5tGLvX9tBb/1AjuHuzxfs6/lIYFlJTD6XgooEgC8KH0Qc4dmva7NtrpiRvYRbdeZUY9PFXrXbjQmL4duJ6gCRGzV6YPFr05OB0h9HJl2Yo7UA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi2D3wX94ds7+VL8S86+8OXA7csTpDwIy6Pn91E307g=;
 b=MvqvG6y7iHJpHWDHoVi6awia5J0uhiHWUkeoFFnVAsdY/P+AWi5LCgZFc4lZw/lgaIyeuLRDjWu6A5sVUp9hSpIcCWv2UI+As8saiaAbDyRNlL+ELOebO3cvU/X+OFtaCM7Qx11PxQgpAhE6yEpWDIz8pkwDcUzRDSPw6xg3HDiKr3/MMGYp1cukST8F2g6jD1nrfJ2PWVrNnz3DcUhGo04qEJDdSL8XM4m2m3blOOkCT9fweI7hofV+4XhZsm2DvR/KwLlxt5yL/0sAtWplWarSGblktQG/fcOJQ30nviS5CwHWlDrQEz6XrtyGnsoCuZXo9x1I7ebgcjrq2aXiNw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi2D3wX94ds7+VL8S86+8OXA7csTpDwIy6Pn91E307g=;
 b=RNvD/zb4dvFDkybHzgTMK7cupvX3+Tt/l5pVQuaGXA0jtwcwkk3tBHJ0+34mPQN1NYrKG95voENOREISYlhf9rSDs54EypIXk4vgudvadxAeWdhMV9NoHzjXVbIPvrp1M1k7eUgqLlLWblPzGFzhTOe5kL6MayQaVlyaDu8owcw=
Received: from DU2PR04CA0285.eurprd04.prod.outlook.com (2603:10a6:10:28c::20)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 10:06:41 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::c7) by DU2PR04CA0285.outlook.office365.com
 (2603:10a6:10:28c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Fri,
 20 Dec 2024 10:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 10:06:39 +0000
Received: ("Tessian outbound 42d62cca2da1:v528"); Fri, 20 Dec 2024 10:06:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 401d422e52448a13
X-TessianGatewayMetadata: lJNSKSG/GuAIWLatLtFIfW/L9uBhgpV2Ctzl23lUTV4+eDREGmkW40H4JEubRGiFarohrA4hKK1uLa+UuFnWYPhhjExIDwIV/ZXItkB7+h3ZzsMBq7VzAUUAjLi6WfQUjqE0EKfFoLiciAtpddkVeg==
X-CR-MTA-TID: 64aa7808
Received: from L22146301a8cf.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8373BE85-76DA-4ED7-A701-EFC107865682.1;
	Fri, 20 Dec 2024 10:06:32 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L22146301a8cf.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 20 Dec 2024 10:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cElut7eXM1GPhqnlgd5mNS1TlTWJsFmX07sqG2tE8+8N29uO3QpjaVqTIrs0qc1PNPOuZdMEZiRjCcqw7AICZGqoCXpH8mOdhPEPIN0d2azH0lbkJwMDCMdiwr5IrKFL06BV0gOB47mb10xHrvYrR2mBlKwU5ermxHsi04awb/CmP8QKXxEH44+Or7iVRYDkcGthad1aJw9P8Fv+pYfAu4ykJaUDFRec4o00PcT1S3kUY++LrECvo4j08HEFvbucJAoJ9ULsn/l2+93se883k+1htRupT7gCX2gI4SL/gybfhDf+f0pUyMQxG7hxyc38jr6NF7UgYc7vpMV5HrJoEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi2D3wX94ds7+VL8S86+8OXA7csTpDwIy6Pn91E307g=;
 b=irw1Dh2jq91hHEumJOcRn32ov6zEnDsfpJ+ZePXcdF1dJ5STXdgU0HTjupVhK636q7ZTCVPNfYzsbDc+PfURXMwUOoKWWOsdtri1fCwBjcYl76qM8+ciRVYwpJrfPkz+L3HlWVOtaMaGW0/Rv2Baq1w/C50TklBGXGTz404/6xgUFkgzXxZJTVrhVEjoL5CpWCbB5LkCzQ+cZsVuy4x0se5wjMMKTpNLZuo8oZD6CIZopRZOY9TK7SqjjbTVnBZPig1Uj5iPzeIVbH6qOD3E4uZuC5uU5GnTzT5yXqgYTXnCiSILzxLwI1zLhi9nH+QNwKQCXriJWGpAvEctwzD0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi2D3wX94ds7+VL8S86+8OXA7csTpDwIy6Pn91E307g=;
 b=RNvD/zb4dvFDkybHzgTMK7cupvX3+Tt/l5pVQuaGXA0jtwcwkk3tBHJ0+34mPQN1NYrKG95voENOREISYlhf9rSDs54EypIXk4vgudvadxAeWdhMV9NoHzjXVbIPvrp1M1k7eUgqLlLWblPzGFzhTOe5kL6MayQaVlyaDu8owcw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB9PR08MB8202.eurprd08.prod.outlook.com
 (2603:10a6:10:39d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 10:06:31 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 10:06:30 +0000
Date: Fri, 20 Dec 2024 10:06:27 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mike Leach <mike.leach@linaro.org>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Message-ID: <Z2VBoxu/pAnkiWMh@e129823.arm.com>
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
 <CAJ9a7VhxG_8R6j5uRCzOhLpy4ZmzyVvyW0+ryCcd4w7wqpZ2ew@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VhxG_8R6j5uRCzOhLpy4ZmzyVvyW0+ryCcd4w7wqpZ2ew@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::22) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB9PR08MB8202:EE_|DB1PEPF000509FC:EE_|GV2PR08MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: cc70e3d5-76c8-4f02-3d1a-08dd20ddfedc
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ZjO4eRDQMMAg1stVtFWwXkjkgbzlr/JlnVzY/W9fZWmfCu8Uh0RzynBopvqr?=
 =?us-ascii?Q?xUnPO5reasF1YU8H25D8bAuWNkYjaZSGOE3gD+PGP03x6P4j00UTyiKqwvKt?=
 =?us-ascii?Q?DM8sVv267+zCkAg5nUAgJJjTkvlnLuniu69c6DPFASsKseH0tq1APMvyiouq?=
 =?us-ascii?Q?iLZ2Sz7V2i1biIAXWoRD/lYsu5MBDIkogifWCD/KDqnitP3CSO/Emqgnyd21?=
 =?us-ascii?Q?1/lK7moJ8cyTw3KWCaNK7NA/50K3eAT46oN5tMfiMP5cOYDcY4HOPqhp6Vxb?=
 =?us-ascii?Q?rh50goBSkwJDbM1UKgzMn4GbnHSGVeqon4kKFqxFXeBO0Tk79f8D/BtMBhx4?=
 =?us-ascii?Q?FpenQB21jupYsMdlDD+4hvXFYSF3T8lgLzX3DT82llJu50mKvVXWtpPWv9hr?=
 =?us-ascii?Q?rXkkWqzbnYc9sNRsTrAitpt1vD0D4yY0gOGFX/Dbs+DVCs947DMAyNrIe4Yz?=
 =?us-ascii?Q?ZT11tCMbu4EBenhgzUWw41QtOoLW5gSm3atv7mZXLFfGClX4AD3lglHOYZb2?=
 =?us-ascii?Q?VUf4ik1j6rVYuf/xFKUmuat1GNsvHrslBx/zKZlpyd8Aqx9WZstyNx7q9C96?=
 =?us-ascii?Q?oz5d0V60hmGzhmVXrYqQD4kfYT30fdIIQDRCO6UuC9QNxgeCszJ3rzIH+mxV?=
 =?us-ascii?Q?alw8VrVH7UqW6tojLp0u4iSXuDb/qudwF4O3F4R7vKf1pGoQcIYPZx+AsIo/?=
 =?us-ascii?Q?hS8Y3FVk3Tkzth81r/U8AnZbmSEnc9iszcqS1zcQAZdmfe5n/1p6C+Fvd1VM?=
 =?us-ascii?Q?yR7s6424w5IFzTa/q26mtWovznuTxqxSdHENheVJu486p/0HBGSD51e0yJ9J?=
 =?us-ascii?Q?XrAsq6SeEOGjCaMBRtffLGw67P56k7AVQGj55XuLWQnq8AIRgQAoGmnGjKs9?=
 =?us-ascii?Q?WbdvmH1ciZchyNW4lZfjE0N7Zo+ZXC/bp8J3KiasmIML+AB6MSPMZFjyeqjU?=
 =?us-ascii?Q?NmH9teRcM/xP7M1DtqFiJG20ECUCOi7mP/nO/ydvGwi69kY41x3igALowJqj?=
 =?us-ascii?Q?O0mh1qExnhdrGKAExopiqfz/Mjzjit+r/6auKc1oBIWUkNV4/UkR4WoskAFj?=
 =?us-ascii?Q?9snQ3YZlro39QLnezxoFOswgn6/CuY1XhRySBcbDua6JwVmO3Xv8Aolesm57?=
 =?us-ascii?Q?m8SRfXFY6E5XZvlB0Bij6n9Jyg7Wm0IBIwUWq90D15f6hnJW1+Cr8V4+832q?=
 =?us-ascii?Q?PbP4S5ALis1QhXNeU6n026V6e+9qNFwm10HCJDVQo34pcTf+zpWF5noJJmpd?=
 =?us-ascii?Q?oSaHA4otCpgYVN2yvDD+RlLsN1+utXhZgYPG5noXI6K4GnqPD6YCHDfZde63?=
 =?us-ascii?Q?o2IdPFn9TGSTGx/6fpJmZvK1EDAqAW7TRepu3kGDdo4XCLVcGbJo6yVmezMj?=
 =?us-ascii?Q?O4PHruXic8CTKCjWtX1kcjxcnwUj?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8202
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eb3c2971-189d-4b38-1b80-08dd20ddf980
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|35042699022|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z+Mf5e0Cu410MeM9fmYPcIpAZmk+cKHuET+0WmB6YXDqFk/Skz/6dXyBRoyU?=
 =?us-ascii?Q?H2FG0Ohnl9gZEIVwJ0Jy9gW52BsGcWwqoUVHvAN2HJ0vcXKzPix3Shi5vddr?=
 =?us-ascii?Q?Qnx3y/Fvi8nMZneTGIUFPbO/o4sP8kLsGhRNpaF/A2FENHDdtqKg+ICgiyct?=
 =?us-ascii?Q?k1GyBYkfxc5KjKt3QSaXjrGyzx0J3YIQoNXxvrcw68iMOFkbT+C1I72fJ8Uf?=
 =?us-ascii?Q?6oFmLMPW4usrpfWsnGQjYllGIVvTvc3iURCqsxJ5V7Y33Fp1x1I8tAI6UbTl?=
 =?us-ascii?Q?Ir1j0rjdyYLyqIrE72QCh7335WRDnN7RKFSbae0sGkG2uI8HMR9wTbgsl8e7?=
 =?us-ascii?Q?c7Ccp+a5JELkpBBesUIxUiUJxLsS6uW3Y8jUmX8yO79bFueR4SFxJq25xd3r?=
 =?us-ascii?Q?eDCBD09GMuTYtMPyZHD8sTXlbt1crhfDzCM1AfEmgo/snR3qXujAQHzkyLVm?=
 =?us-ascii?Q?B7XcdJhrs7cbQb/z3ehr8rG5RO9XmBE48pwB6NwkpXv2vIWbmKxNpJ2p8TOn?=
 =?us-ascii?Q?MVcIgp55XeVxlJrn8JgEsnU2rYJmFyCdNnJHq3x0ZPn9fPr3ZGqqwVcwmYq7?=
 =?us-ascii?Q?I5hU7nBA8FioJaWTwFoUKfdqNEo29HJReD6zB+OMNF78W/twa/Fh6DN6lfTo?=
 =?us-ascii?Q?s/dZKPlYX1IbFYaPXPnu3t+26hh/EU+OpjMRmLPJQ8CqUANgm7NLSUPFTmxE?=
 =?us-ascii?Q?K5ag6MhsmJn2EfMlLdLWUL+0eMvmvf9ap3pvG+rrKi5KCdj6qxqI6j8he6WY?=
 =?us-ascii?Q?p7shw9RDsUWdDdFhYnpxz0gKJIWYuAx0faeEtJvzd/QHohAHp0ko90snNOWZ?=
 =?us-ascii?Q?AeLCLwa/lr7/p5tClZGh4yBLpXy3UN2YwsSlNbKIrHHs4O4xxd5ePPqP4ld6?=
 =?us-ascii?Q?vc/P5j3HMc8E6VVMYEgLUqO2r/0y+2QoRwwXPGaqR6IkDRUyt23LcPhfEscf?=
 =?us-ascii?Q?rg3tIaY4Mxc9sF4ETejepwjE+PcnTvGm9jYyGaVWh2QqyJfR4gSbCLkNXg2o?=
 =?us-ascii?Q?BGn1PaUGi9wbCNE3RKL8ndObAqMeP+BakE6596VhQE9hMplwHRgDfGs54Eo4?=
 =?us-ascii?Q?glPndS7UUFxJxRSZfqU6qYIuqt2gM2+Ufcz0pFT37Z10b7xGJhWSgeCrabft?=
 =?us-ascii?Q?dGAlePNMb6TaVPWrIxz2RNP2nn/E3U3Nt3axqkqhvbF8Vit2nT5R7zEWMawj?=
 =?us-ascii?Q?j8GSE33EkbWYz1mS3yxaummixGQCnwgeLKvXTmthzFu8/VWkisUQ/XWl3Dme?=
 =?us-ascii?Q?ltOLo1C6qzXeoRg5avb5FO6xDEKOqzCzVxiqjtxNCtyldbIHluHkGyPmRJ/A?=
 =?us-ascii?Q?G0Bt7hRwIspNGa0Ke+6Tu2FcgIsX/hz3cdvjgHdTgA+8Gpyk9HlH2JRgbPzz?=
 =?us-ascii?Q?1Hd8Ob0CxomoadZ2d7nnU1L+qu9NB9iXV8hePT32MQhjDonBo5SWuMH7lOHR?=
 =?us-ascii?Q?QkvHCfWK1/SeWdp9EBCTNSZaMxsp/007Rk3g2IC1g6SaKVwDUQbECHgiANKn?=
 =?us-ascii?Q?mSkQcccqMzQSQXY=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(35042699022)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 10:06:39.2029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc70e3d5-76c8-4f02-3d1a-08dd20ddfedc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8437

Hi Mike,

> Hi,
>
> On Mon, 16 Dec 2024 at 11:50, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > In some coresight drivers, drvdata->spinlock can be held during __schedule()
> > by perf_event_task_sched_out()/in().
> >
> > Since drvdata->spinlock type is spinlock_t and
> > perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> > which is raw_spinlock_t (an unsleepable lock),
> > this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
> >
> > To address this,change type drvdata->spinlock in some coresight drivers,
> > which can be called by perf_event_task_sched_out()/in(),
> > from spinlock_t to raw_spinlock_t.
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> >
> > v2 to v3:
> >     - Fix build error
> >
> > v1 to v2:
> >     - seperate patchsets to change locktype and apply gurad API.
> >
> > Yeoreum Yun (9):
> >   coresight: change coresight_device lock type to  raw_spinlock_t
> >   coresight-etm4x: change etmv4_drvdata spinlock type to  raw_spinlock_t
> >   coresight: change coresight_trace_id_map's lock type to
> >     raw_spinlock_t
> >   coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
> >   coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
> >   coresight-funnel: change funnel_drvdata spinlock's type to
> >     raw_spinlock_t
> >   coresight-replicator: change replicator_drvdata spinlock's type to
> >     raw_spinlock_t
> >   coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
> >   coresight/ultrasoc: change cti_drvdata spinlock's type to
> >     raw_spinlock_t
> >
> >  .../hwtracing/coresight/coresight-config.c    |   8 +-
> >  .../hwtracing/coresight/coresight-config.h    |   2 +-
> >  drivers/hwtracing/coresight/coresight-core.c  |   2 +-
> >  .../hwtracing/coresight/coresight-cti-core.c  |  44 +--
> >  .../hwtracing/coresight/coresight-cti-sysfs.c |  76 +++---
> >  drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
> >  drivers/hwtracing/coresight/coresight-etb10.c |  26 +-
> >  .../coresight/coresight-etm4x-core.c          |  18 +-
> >  .../coresight/coresight-etm4x-sysfs.c         | 250 +++++++++---------
> >  drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
> >  .../hwtracing/coresight/coresight-funnel.c    |  12 +-
> >  .../coresight/coresight-replicator.c          |  12 +-
> >  .../hwtracing/coresight/coresight-syscfg.c    |  26 +-
> >  .../hwtracing/coresight/coresight-tmc-core.c  |   6 +-
> >  .../hwtracing/coresight/coresight-tmc-etf.c   |  48 ++--
> >  .../hwtracing/coresight/coresight-tmc-etr.c   |  40 +--
> >  drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
> >  .../hwtracing/coresight/coresight-trace-id.c  |  22 +-
> >  drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
> >  drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
> >  include/linux/coresight.h                     |   4 +-
> >  21 files changed, 308 insertions(+), 308 deletions(-)
> >
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> >
>
> Notably missing is the same changes for the etm3x driver. The ETMv3.x
> and PTM1.x are supported by this driver, and these trace source
> variants are also supported in perf in the cs_etm.c code.
>
> STM is also missing, though this is not directly enabled via perf -
> but could perhaps run concurrently as it can be a target output for
> ftrace.
>
> Regards

Thanks for review. okay I'll back with new patch set including etm3 /
stm.

Thanks!

> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
