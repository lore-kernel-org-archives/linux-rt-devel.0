Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0561D5CD1
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535377; cv=fail; b=uD8Y94oUMgrT8flyrs7wLLWjv1NYTQbdYAgEaES8ileGyuMyKHbTdliTO/BrXTu7wxAvnCRhXVGBw+8mu8SBAcbe26lq7V1lGT/5ebRqF6esW5NyilbN6VAOMwkNXGUXzL5XVtFxHT4gMrx1LW3iWZ1k0eOLWc/zXAQ+l4AHEp8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535377; c=relaxed/simple;
	bh=zv8yzzHcz3MU5xnyt7TJb5oyH3O1FBnxmQrQHfhBMj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sKVmSlgmfdJ7pRI+/UxMoiw+eTIYp1Y7ILRsN80I/rpD0EPFYY7cm/+sdITDSOGAitEcOF4GN3DcWovYondNFFBKfiD9nojOrvVRs9qu/1tdojR8I+3aUPxuW7Z8mt09/MG+nn7/93E2Y8uWofxmCqIgcpZKr1M01ZIcYSeOAE0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mj9v5oyJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mj9v5oyJ; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mj9v5oyJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mj9v5oyJ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vB1GH3Ft1rzNahjX3avxy/RULMoCXq9+ki3EsuKHWpIP7g6vXz19GEwTF5cCfFJv88qhiejJAKOhXwCLDBnoikT6N/UHyped8uylY6xrQfY/fgG4ruEsTv1JYz0QFCJ8NKfwLISEbdHFcNRZLM1zIKZoZRoSvuTAtM6Q4yJCKaMEtGzLq0BBnnW4VmW8j2+31J7KNWBlY/jQ8BNk/XUTf2BYrPP1CXC3lcbep8gTV4Fc8o6wuDXhEg+513cRVke/uT3nvOe9lMKhlgdx8C5j3QNgrSPch7noQDJyq9DLP6YTCgJdHBWLjaN9PYcGM41D4UcoI2isKfNn5er7BsAxvw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iE7Hm00X8Pj7oeci400jGxYZ7JzmHInZBktzySylDPw=;
 b=MN8YZTeQIuqQyGlXQVK6tgUPsXpuB+hwoYs4Ba8M2QmmQ1V3Cj8e+By3fI3N7sgoVK+9Mo42RILM2xGoEDMZUWiTSZ1Wn0a+4qw+w/450ilth7PS4GmjWaCX8GeUaB0tBtzNnhILyr5V/Bn/Q2jnCb0tDX+ZPoLwUqhO5gwKBfF3mZ1Md67sJcuLY29NSbPBIi6u38cIJhN2Qu4gKCjwq3Evyt8kEU90v5LLN+i8wpWt6cmda+HJPzBU63Ix2nk3AdNhu+TfAuECAJRxKlIt3ApWPoFA60WRNJ6jq/xBLF4j9F9Hj5PC8ZX35pgV9nYcEcGpJbeJ3P+Sv5Z8HVfZDQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE7Hm00X8Pj7oeci400jGxYZ7JzmHInZBktzySylDPw=;
 b=mj9v5oyJ+zQMRMzd7WWY52WcJY6O0K0yvFbI49tGjeYLCvvNldlqz89OZaG8CjTD61xeRVfd5dC0PuDGQUKqz/hrTPse1ztF026CuvN9PXbxU7/FJa5F4r4GELfOavFPIQsuw4CJEoiEbOLmOBSAypgQF+gSPayCWaCUFVwYB+E=
Received: from AM0P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::33)
 by AM8PR08MB5795.eurprd08.prod.outlook.com (2603:10a6:20b:1df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:22:49 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::ce) by AM0P190CA0023.outlook.office365.com
 (2603:10a6:208:190::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Wed,
 18 Dec 2024 15:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 18 Dec 2024 15:22:49 +0000
Received: ("Tessian outbound 867970499bdc:v528"); Wed, 18 Dec 2024 15:22:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7152911ee2f950e2
X-TessianGatewayMetadata: UYLMx6KR8xL9Bm4jdJOsdnPAoCsug48O+gHTVme+G7wJN6X/B7m7Bb31sPLLBrACuHCpwjaZUHV2MqW38T9VQWyr5h4sGiaJ6sFdndKLjqvMS9J6RjXcLMmV0z/ORGUKxiQBq8yb5QL98ea9+PGd4/wH/O1uxaTwdokfjK5jJsj6d156sdQLdM3K6A625eMqBe0au/L1+hPFwjpS3eT3JQ==
X-CR-MTA-TID: 64aa7808
Received: from L4410abf62bfc.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 387FD48E-92EA-42B2-85B8-24A72AEE74BD.1;
	Wed, 18 Dec 2024 15:22:37 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L4410abf62bfc.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 18 Dec 2024 15:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvENnCkgwyVHD2wybhhardC9FCyzp+ki8O5rqb/w0zc7muSpLJ7vo/RoHVDuFk1rsPftxNClMZGHVkrpM0UDtAOX7FNDqq7gZANRQxwhiAz9zUOvXN78lV6Yu4fxQ3Fwwecq2sVwy9dXWs16E6nzS2B4mNEwiwX6e1J36xD7o6L3cKYd1NSt5q7E5go6SHXcegbIQ22cLjd+tFHWn9mklR2ATMViRtLUrone8N0XB60URwBbM4IVQcOrz+L2N2gDcFIHtZtWdo7xlxp/7zVM3zk5Xdzx665nNz6QYR7KAWSAtnDU69btELsYJTgIcp4yfFRrxI76pRYAmzAFoiwxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iE7Hm00X8Pj7oeci400jGxYZ7JzmHInZBktzySylDPw=;
 b=L5yU2pmAxISl8FSiDzCzXmiY+QqIoc2HUuv2KFFdohYqlyQW6mxfxD8yoCT4jOG2X+G2uTgxvuaK26l3XF2ldSr71ijZT5ZnJw/lSGv1dTBrT77LQLRDv1pdMHUsMPuLtKCDyxm32F6xD+GzpvY8xwUT1iZJyNJhPLV6ZEuS0/eiI0sfI8qnMUi4ZfQhhSJuNOVIry4tYVi+AdFylZy+f3DY5iKpX7M4OWfsmDePrrPqyYQXgrvImbp38xbEWVhv5mVDvF2KsIWrMioSJhtfyCFfkVRffdfJEadxwdIhokanDu83xvx1+1i5CnExt4k5SFGSYTAbEQDgw2WFuGvthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE7Hm00X8Pj7oeci400jGxYZ7JzmHInZBktzySylDPw=;
 b=mj9v5oyJ+zQMRMzd7WWY52WcJY6O0K0yvFbI49tGjeYLCvvNldlqz89OZaG8CjTD61xeRVfd5dC0PuDGQUKqz/hrTPse1ztF026CuvN9PXbxU7/FJa5F4r4GELfOavFPIQsuw4CJEoiEbOLmOBSAypgQF+gSPayCWaCUFVwYB+E=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA4PR08MB7410.eurprd08.prod.outlook.com
 (2603:10a6:102:2a2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.23; Wed, 18 Dec
 2024 15:22:33 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 15:22:33 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Mike Leach <mike.leach@linaro.org>
CC: Suzuki Poulose <Suzuki.Poulose@arm.com>, "james.clark@linaro.org"
	<james.clark@linaro.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "clrkwllms@kernel.org" <clrkwllms@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>
Subject: Re: [PATCH v2 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Topic: [PATCH v2 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Index: AQHbRXl3XK0qSrIPr0e0pGVelZxLa7LsGwaAgAAawEw=
Date: Wed, 18 Dec 2024 15:22:33 +0000
Message-ID:
 <GV1PR08MB1052108680D14C3AD04282270FB052@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241203114942.697188-1-yeoreum.yun@arm.com>
 <CAJ9a7Vis9vcdJOzu9tvNQ4eAacmXkbhbZBaRYd1acOrd8G-ZUQ@mail.gmail.com>
In-Reply-To:
 <CAJ9a7Vis9vcdJOzu9tvNQ4eAacmXkbhbZBaRYd1acOrd8G-ZUQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|PA4PR08MB7410:EE_|AMS1EPF00000041:EE_|AM8PR08MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0ff6ab-a233-43f2-6cdd-08dd1f77d51e
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ixXVDxiY8xOurcv0fENaoT6qEUzk6LkeXkpqY8HeVE7r3ALTSazr5pH6XiSq?=
 =?us-ascii?Q?4soF2H6271JGR4ydh63zMSetNo2sshluRpi2D1P1ps+2J7dPJg7S5LDktxpR?=
 =?us-ascii?Q?gfYhFYVV95H65bFZG6+ydGBUO9myzUPxp0zPMKzho7ZlnmU+RClBIPbVXXKt?=
 =?us-ascii?Q?SY/r9lZiUOs57dzfzzc3Rmv9W+q1rXg5QIrU5xXgXMiysqoyGBGguSoPYzmB?=
 =?us-ascii?Q?YUX71phwyg4FcZE362MsdU4T72EOXu5Xu4JFODwNtOPkURcWWlvbKi+X2XNS?=
 =?us-ascii?Q?cNx/fQ6QqwskLW+gs9StnD7fpJ/N2RXUPo2fZ51mlM+wjzu54N0WnpSqrlKo?=
 =?us-ascii?Q?5L2pmqyB/AWAHIeDKvGdBlUn80GfYzbfc0kjN9fw7qfnU8tLlMx6Y3Py7bPk?=
 =?us-ascii?Q?bdqyi8h+Ho0lSv8dJI1dd4HN3gTYvw0YXdwtlODIXC4SRLtos6BfyEB3JeMG?=
 =?us-ascii?Q?uN4IY/pY7kVirHBE8aAoizXGyHCkbieJ++2DnRmJfguS7ZEqz8fiFPjTQz1N?=
 =?us-ascii?Q?bRJXUd9Xmlaced9ST3vVvHB1Am54YtPqok4u8VKYVq2xh8YBL01wqJ9DEkJV?=
 =?us-ascii?Q?zrTeg5NHHP4vTCEo2x8nS30+mvWsnsNEpRWscfAX7AMQ9BYEe3WNVElu4Pw5?=
 =?us-ascii?Q?LaOT+zV3+AFM+Vygyl8ETMh9LU8scyJPYphEXnWUXzEicnuXXROAVF6YD9ah?=
 =?us-ascii?Q?5LEJON4cvLUjk9hQfhPLwQ8Tc5UL80qi+y5lL+G4oWTqjy99TU8t93mWtH5L?=
 =?us-ascii?Q?foh9CF0ndu5yiIh1bIYgIbRmOTbp2e5OP4TVt+nGw5tkwX5ewqCvizbPe/WO?=
 =?us-ascii?Q?BMniO3m6XSQwdMFUla1Wl5J01aQL7jnmlzftB800/INkoTYxZKzbP0uI9R6/?=
 =?us-ascii?Q?J7faWFX+Z+/VmbOSFw1PV0ZjuhU+8vaUcwMIIebzBXF+dJjodFVfkVFOJ7Fa?=
 =?us-ascii?Q?FZMLx1BdK4VTy7Q4uYEWbJmYKYygUOLhZOeOCKNVaM4PNm6ofyHEmU8JC00K?=
 =?us-ascii?Q?O/mfs0hEcIykSGzYZabVp+SqodWO6ga6CWDKoo8j6/zHYoACQ2+3e5PXt3QG?=
 =?us-ascii?Q?UzIEbqEic95W+1fnTyl6a357lYqfawNoGidt9NK27mcWwT+HE+6OIPY60Wbj?=
 =?us-ascii?Q?OGnydby3FT4KwX7ElgdRltgaVoflbe90dmzbG65Jb0757SuGW3kmvFQGdwr3?=
 =?us-ascii?Q?q9FGAohGe4A8/SxXqDqgls46oK+58++gEY54Z+GI9anGoG6FDJ+u0ykjhHe+?=
 =?us-ascii?Q?1cDjkN/XZoJtJbMc3nmAXnTgVOtxXNHGUg2+f+g4nBjze6sOLvT/tYhKbfna?=
 =?us-ascii?Q?ucjMxYzev0ywyF6uWxmMuI4ayz2+DBCms4KPYNwZze4jiOWQPBWWsNJ/nSbg?=
 =?us-ascii?Q?rn8yg6p3170g9QFTrFE6dm2bx7rkwiH8y2Wds65u0KiVpSTJAeNRQvmixAxl?=
 =?us-ascii?Q?OyHanzkL53U=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7410
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4c46429c-4eb5-4593-7627-08dd1f77cb88
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LYqK75xLFQR7HCsjKB/FOjWRJCAqjjYSTskktU1iP+wekNgTQaEcxKmD6khU?=
 =?us-ascii?Q?9zVMQk9gY7/c2R5x/F512Qape3HxMb9FT1X0Jdo5lFH43vnRND/UcGhw2+QT?=
 =?us-ascii?Q?Oxq+1JwjgBq1imABR5GbhMnkk0by1aIlxQJWDWntCMnaLxH9f0V2sPF43UR3?=
 =?us-ascii?Q?fJ9Dwol5jnHAcIZ7DKW3G/3yBLt/QOaVDkf4BazAj3jyokOR6mchLwb4SClu?=
 =?us-ascii?Q?dJcLtFUf/ZSMhhjLXEbDCsniL0PV6wW2sFe4Io0wU6rC86oM48ZSvfgPGdvL?=
 =?us-ascii?Q?tJivwwwHDnGcdcCqzvYp55kCawxojDh6ZkSqPvhlRoI2Y4ccaCvKYp4oSlOk?=
 =?us-ascii?Q?/apfzv+32/QYIsphGfykQmu024z6Zxf5CUgTYHMr9SfPVuBi51ymfyreJ31G?=
 =?us-ascii?Q?gguuyxvwA/dOpUcepZACKsdAvMfPY4AapdjSU/6lgLtHjElMm4k9XXgkvR70?=
 =?us-ascii?Q?RGXdnpjFcs06mnrYEpNTRgmv1MoDoRbgLYf5a//cUKrW3AvjlmuWwfCr9VVW?=
 =?us-ascii?Q?SVwIdGhDzH5BqXfrtrqsImnrfzzLcnz1MMA3V3ShSkbhIeq13MNK5dvtpzTC?=
 =?us-ascii?Q?5Uen2yU0gOz18IkmvsclKSIygxFafZhOyJFZY1YZJ16KGEqIO/6nXlnq8WVL?=
 =?us-ascii?Q?4p32IBtI/JD2Wq0LPgpW3ZwQpqzVJSB3T1LkZr5kc1uEYUMmkbvtWlHSyzF+?=
 =?us-ascii?Q?1nLQGVRfJZeGZKf3vCladxr5BTN7sLuLNNU1xFnTHoeBvmvhgkr2MpFQbqUs?=
 =?us-ascii?Q?noS0ARifBJ9bVmdbrx6BtoxMhltaV6gL02QcD48ThPJ0I5EVCl2VapkVphnL?=
 =?us-ascii?Q?Oo25nL3zBMOIaskOF40XK/LRDrURat4SdpthMR+M71Nf+zcjUCug7WuHb4VJ?=
 =?us-ascii?Q?wVjWyBdXndFouu+sSYk0lTOHSuRrJGl06ZIo8PdoGeuR1YwOpAIvmzx1dA3L?=
 =?us-ascii?Q?NnT4bwEZ/TEDs1TGeU16VDocA0izkoU8YHha/9xeTzOX90I1PZHhl/nMs3uC?=
 =?us-ascii?Q?1Vt90XhPL0aqw60zSwANvfWJv2B8wqp/DVLwQufBL6CtgYTTUJ8y0eIZBJ2k?=
 =?us-ascii?Q?77WoOcVrxOROlOhkJHOwKOB4y8gl+CjEb2lJpAdOGLQWNgof0iTzH9ToQx9K?=
 =?us-ascii?Q?RftN0mCdKj8Gocx/pAQegFBbPQrdzNgP6s3ChH5GujD4vbzDF2e43lnczhoO?=
 =?us-ascii?Q?MW1Dk7pL/E5Yt+p5pAVxkFZeOp+DIv14qoLC+kedcT//PxsbFV06I9e57QnC?=
 =?us-ascii?Q?7qg7+a/TZNlRV8k52FPkj6KISCJmtcn4Dn5W4o4Ikh1CeMR/CugBzYXw7bpe?=
 =?us-ascii?Q?UWxRF/8+UL96eOI+Jce5mxXLzc4UixugjIMGMrklcT6jCnWkQ88DWRaKrBrS?=
 =?us-ascii?Q?IZ3vKj/Uyv2XOErOhKOzLDd5Wyd1t10kLXMAarlLPSKRUc4mxH7Q8zTE+S6w?=
 =?us-ascii?Q?O3d1yY/JA+i4dsnVZbE+aoVocmESFg1yBQR4HGWpsG1JnaapB3JcbOqBXi/d?=
 =?us-ascii?Q?iuINz32QE13DA4w=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:22:49.2182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0ff6ab-a233-43f2-6cdd-08dd1f77d51e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5795

Hi Mike.

> etm3x - which provides support for ETMv3 and PTM, both of which are
> valid trace sources in the cs_etm handling code.
> stm - can be integrated into the kernel STM via configfs providing a
> MIPI source for ftrace.

about etm3x, I have a the same opinion with James.

But, In case of STM, Is it enabled via perf interface?
The cs devices which could be called in perf patch were changed but not for=
 cs devices which never used via perf.

Am I missing?

Thanks.

________________________________________
From: Mike Leach <mike.leach@linaro.org>
Sent: 18 December 2024 13:44
To: Yeo Reum Yun
Cc: Suzuki Poulose; james.clark@linaro.org; alexander.shishkin@linux.intel.=
com; bigeasy@linutronix.de; clrkwllms@kernel.org; rostedt@goodmis.org; core=
sight@lists.linaro.org; linux-arm-kernel@lists.infradead.org; linux-kernel@=
vger.kernel.org; linux-rt-devel@lists.linux.dev; nd
Subject: Re: [PATCH v2 0/9] coresight: change some driver' spinlock type to=
 raw_spinlock_t

This change seems to omit devices:

etm3x - which provides support for ETMv3 and PTM, both of which are
valid trace sources in the cs_etm handling code.
stm - can be integrated into the kernel STM via configfs providing a
MIPI source for ftrace.

Mike

On Tue, 3 Dec 2024 at 11:49, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> In some coresight drivers, drvdata->spinlock can be held during __schedul=
e()
> by perf_event_task_sched_out()/in().
>
> Since drvdata->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
>
> To address this,change type drvdata->spinlock in some coresight drivers,
> which can be called by perf_event_task_sched_out()/in(),
> from spinlock_t to raw_spinlock_t.
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>
> v1 to v2:
>     - seperate patchsets to change locktype and apply gurad API.
>
> Levi Yun (9):
>   coresight: change coresight_device lock type to raw_spinlock_t
>   coresight-etm4x: change etmv4_drvdata spinlock type to raw_spinlock_t
>   coresight: change coresight_trace_id_map's lock type to raw_spinlock_t
>   coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
>   coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
>   coresight-funnel: change funnel_drvdata spinlock's type to
>     raw_spinlock_t
>   coresight-replicator: change replicator_drvdata spinlock's type to
>     raw_spinlock_t
>   coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
>   coresight/ultrasoc: change cti_drvdata spinlock's type to
>     raw_spinlock_t
>
>  .../hwtracing/coresight/coresight-config.c    |  21 +-
>  .../hwtracing/coresight/coresight-config.h    |   2 +-
>  drivers/hwtracing/coresight/coresight-core.c  |   2 +-
>  .../hwtracing/coresight/coresight-cti-core.c  |  65 +-
>  .../hwtracing/coresight/coresight-cti-sysfs.c | 135 +++--
>  drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
>  drivers/hwtracing/coresight/coresight-etb10.c |  62 +-
>  .../coresight/coresight-etm4x-core.c          |  71 ++-
>  .../coresight/coresight-etm4x-sysfs.c         | 566 +++++++++---------
>  drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
>  .../hwtracing/coresight/coresight-funnel.c    |  34 +-
>  .../coresight/coresight-replicator.c          |  36 +-
>  .../hwtracing/coresight/coresight-syscfg.c    |  75 ++-
>  .../hwtracing/coresight/coresight-tmc-core.c  |   9 +-
>  .../hwtracing/coresight/coresight-tmc-etf.c   | 195 +++---
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 199 +++---
>  drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
>  .../hwtracing/coresight/coresight-trace-id.c  |  93 ++-
>  drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
>  drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
>  include/linux/coresight.h                     |   4 +-
>  21 files changed, 751 insertions(+), 838 deletions(-)
>
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
