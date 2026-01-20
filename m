Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844843DA20
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931461; cv=fail; b=Rw7i+ta3XW+6rAnmE13eJqsGXFUM2EMa+39GxksFiYq1FxWgpyO6GsTncueJWDfK0wT+mC0Hb5PH7Ik9somsc+pOFg/2mWZrBRi/oip4LxBbJv61/bJ0dZ9jrJ/tGfwjlcSrh7iWxlfDrdL/GA2xuG1myvgVHLOY9UqnCOk8HpU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931461; c=relaxed/simple;
	bh=4fq4umy7koU5gAAa5CsIbLOVkTqNGNxi4YQ+Yob2Tgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WjQXqk5+PUBLdZ0YqgUm96HfymT40Ihl3HK5AfD/6f03XKIvO4s1JcVOu/KjmU2Ebk4CEq64crWtM2WlahQtJM+JwBKGL/NsVLwFEF8fvPFwX2mr0dRw4t6EV4+H4v3kHEPvtC3KEX0jwt17KEPCZbf66PQYu6rmaStQCYK6VS4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Tl1H37x4; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Tl1H37x4; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Tl1H37x4";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Tl1H37x4"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Fmx1Gti9x3U/r0wzvA5qHCY57jHVdI1OErPuI6To0tLPj+RiooEl64nG0GyeJRNkN6lDlOlG9oLFg7jg0oEwm0bORWC1wCpOWEOJ/sXObm8Wf4JZ4Ek0GBVGR6SHAID3qt5TrjxwAR13VW/Ye7F3ztryQg17Do9B12dNhDYqDEzCwtihjTo3wNDoD4lduteYY0m6nS1Zhqt0toE49PngT72uDLG0y2mIamQ8Ax2JkbT/zQIC2cvVxyiiqfuxg6D5CsrHu3ImI+hTxBuXLfKnGh2XDz+HhEP7Jbo6xgIeO+uipp5VrTgoeg6AGWRS5+ZZCcAmnXNckM6jDRRPl/YqkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJQwXk0cLnj3bEG/bu4UIpiOENbgLNqJEy10fSk1oQU=;
 b=gsfc3rZwKFrthywEp6aA2HxyBlzDOGyYUmGuYqdRmqxEYYwSlIw7IAEw6i/p9ijqvSMWJZxDW0Yr/Wt9nkcV9XFPf9namwuE4Mkw+byuPdx1fUevghWvxwdfv9DeFTSiEqvGQpxb+75amGJyL4zsCPexb2P2VehDB/izgRoiQZHefLZbxO2qrJiqBeqac8Wsd21IXaIpTFJqTS37T/XCo0cjSct6sp8iN0P1+spYMSDslm2C6yAH1L9fe4fsKVL3MLmTChq8WLD8QO0WpaT8ulPpRCrT4ilrjakhXoBlsA0ZoLa+Zym4e2fEV5fjSbuJ1NBnKNP7/31wBQIrzhf5ig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJQwXk0cLnj3bEG/bu4UIpiOENbgLNqJEy10fSk1oQU=;
 b=Tl1H37x4uOXvmR1OZRux/asDOxiuLpghRF4qgMqkZIgZCWJBP0g54OHMUlBtkpOss3xtjKUkYh9X0pFybyiC0Pv1WG5o1FXdnZZG4/GdFNu78ssd4lCc8hBL9I9fhnidgKg8l/Wtu6iq04L+SiMbjLJSyBh3Jmh7SDoeYTbJJEc=
Received: from DUZPR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::28) by DBBPR08MB10592.eurprd08.prod.outlook.com
 (2603:10a6:10:536::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 17:50:53 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::5) by DUZPR01CA0170.outlook.office365.com
 (2603:10a6:10:4b3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Tue,
 20 Jan 2026 17:51:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 20 Jan 2026 17:50:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upwmtuL3hq9R7EWRdLex+IMWpKebfAiLKAAkVi4eF4T9sxz4EemjQf01PKmWsNH21bD9xWP6dSxsHvD/ePlNr6KGLg0BKXzSSJtlAmKLouroJyY9f35fe4IM1H6qp7eX9JIyk6HjaLJZKTUxNfdOqipMs1Mci9UKBU5OTaKGFQfaf8CeTgYqOHI0BonkfIB53qyCYFqO5By92PBb/CbLSWmP7Jbb9H2S0yxa6zREwH8CoRXWAb/GRS7DyXYLCjB3IMWZJFMILoAjOJpD0S0mfDmddv9d0nYQcIta9c28CMUqnz8LZrBMd10YPIzOsk7AjAL0bjm/SO0H2M+Aramt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJQwXk0cLnj3bEG/bu4UIpiOENbgLNqJEy10fSk1oQU=;
 b=DSP6yt9xZiWGqcsHFe3PE7u3Unt5bceED2ZXnL/QKFJzxYB8vEKSEkH2cMNfjevkos55PFsoC3x6ax9Fh6OD3yb7v/Uh7PIuVlIPENLJfCPip7FI6B7hE3OHgtCC6/aHwxtS3sc5Q+/Wj5OZjgmB8pODxNNKc6XDm9gkPFBaVAq1pus1xipjJf2JgBl8k4+GyjUu7ApCzV0/3Cla1gz3Z5A/Ts67glKtfG66LoJuIQc54OW9mi8Z/vFXJfViLm8aUUKHvIVj7zyHas99px60lW+NiAnjYPIRh8Ow3Rn3RyTb3hPCOYFWwtuvM2me6GYHTuNyCN+taTkKDBpG4GkDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJQwXk0cLnj3bEG/bu4UIpiOENbgLNqJEy10fSk1oQU=;
 b=Tl1H37x4uOXvmR1OZRux/asDOxiuLpghRF4qgMqkZIgZCWJBP0g54OHMUlBtkpOss3xtjKUkYh9X0pFybyiC0Pv1WG5o1FXdnZZG4/GdFNu78ssd4lCc8hBL9I9fhnidgKg8l/Wtu6iq04L+SiMbjLJSyBh3Jmh7SDoeYTbJJEc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB5PR08MB9999.eurprd08.prod.outlook.com
 (2603:10a6:10:4a5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Tue, 20 Jan
 2026 17:49:40 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 17:49:40 +0000
Date: Tue, 20 Jan 2026 17:49:37 +0000
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
Message-ID: <aW/AMfg34flDNvcS@e129823.arm.com>
References: <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck>
 <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
 <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
 <aW+t8S1LfwX3LjRi@e129823.arm.com>
 <11a01f4e-9ae5-4001-9f9c-74a746f898cd@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11a01f4e-9ae5-4001-9f9c-74a746f898cd@arm.com>
X-ClientProxiedBy: LO6P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB5PR08MB9999:EE_|DB1PEPF00039234:EE_|DBBPR08MB10592:EE_
X-MS-Office365-Filtering-Correlation-Id: 4021f610-5274-41b2-cfa6-08de584c74eb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ZFcQorIILwiHDImi3CpwGsBkbDzJ6An2Je2CTm1CiOVM/xUIjtQ4Aw8F2aeo?=
 =?us-ascii?Q?Mdtxlmo3pGP6GuZxvwqz4P9poz5IfFQxgb82MucJc4fc8G/uhPeQhWk9ixDg?=
 =?us-ascii?Q?LUxUTyrCzKe8uHP6DE6eGXv66EwfTXJqHwg+tWyLmmGH409R7BrQBvRtMwCb?=
 =?us-ascii?Q?Etw3odlAV7SMliXCqb+WgmsER0UQmmQF5CQ8dc/Dr350STIbeNMnyELpq7lC?=
 =?us-ascii?Q?gHNuW3uiQKfIwl+Z1EdI3sh8JkGiWTCDlzM6hxT6esWhwdZMKyvfHIUav7AZ?=
 =?us-ascii?Q?ldpaAu02paLspMZRzClHkhM24lLadG7fITfBDUYBL+ZCsO/tFrXHnWmv3OiF?=
 =?us-ascii?Q?ubEnntelbzbttDF+txtUaOQ3UWMhHouoiu2AnJqcpnZPlwox65LuP1TZJnHR?=
 =?us-ascii?Q?SA15YFqxYn/wgDf5e2liyw7FFWz1232ZI6YMfAHoO2GOgk9sw8O9AwhQt8tV?=
 =?us-ascii?Q?oas76HfVQJrV15X4y1IFBTy9/QclbkMM7eqKb3gTzixZROPfbv350s3eB1DK?=
 =?us-ascii?Q?geBV22YuzHXeEsfCupI8KcXUIXZraFefZgoP7EpLkfALnMrej50UmqjFjhGA?=
 =?us-ascii?Q?DysrdX84+pif6B3HN38HvgQQnEMlDiHJnEkcdNm40mngHWM9x1uZC4OI0Gxr?=
 =?us-ascii?Q?ZUT/DLIPuThwADsvuzkxzd5FniW3TwrVTE09WdL5U0LuZclnYK7YiwqeDqFF?=
 =?us-ascii?Q?h169UZfbs1/jtV+7fFm24R59RxlGkqjldhpd/BYahvbqlfYsFlUjJaRsCSjr?=
 =?us-ascii?Q?TLP9B2inC3vou7tFk+39WvM/EjvayPEB3vB4JT0q9QGotZg3Yk/IzHPMAH5T?=
 =?us-ascii?Q?KSfPydFy/pVBWPU1lpkUcGtcnJJfH8VYCEN2HSjVIZSGNTN0aPgJeUoXzQYe?=
 =?us-ascii?Q?BP95wgDYh7fUBnxw32wCCvirYWANExjwKJXWmuXE6ZF4q5qKps8+qQf2pliY?=
 =?us-ascii?Q?X4TG1Hr6r5Vg+/o3Y9RUfgW8kt2w5Kf+zgyoshYiv/C+rYQMSGA9VUKcPGva?=
 =?us-ascii?Q?a0FTAjQbse4e7YHQjsjqWoWybbOvon5ECF5MPWMjVaO1p5LGUsmUnQQyRK77?=
 =?us-ascii?Q?rVWiZ8ZLiQyHVS6zdRo1uVKdsHFgk+qFEHYmJJk/cC8D5huZOC6KDH1b81vh?=
 =?us-ascii?Q?IWUZ0uL3J/hGqFdTShlxbAiXm/m8JZ73fl1pVulIbD3A5EGRAjJLuHepAM2E?=
 =?us-ascii?Q?cIRdkYZkquEpnZECpe3jAUGt7kOB7S5rZVopqJedP3Z3r3zK92vvKpLveY7b?=
 =?us-ascii?Q?eqTEUdd4PjS6jRO7b0YKRIyWogBQETUIUfSnFfxbHdlxxKpifMIWZApbTpQ5?=
 =?us-ascii?Q?LnJsqNJsBHAMQfLCDMhO5MH64VBusFBQGl+dI4G1aNC1oCQb4PcFzBzfNp3b?=
 =?us-ascii?Q?5czXcbBegi3b6CHEhOqlZrRW1fVVbWyXG4JVn6suT84Zn7EZSwHMziSpuGlR?=
 =?us-ascii?Q?SFcUA4SVb2gAAAMPSMB2x+3VA+B3hhmZu38dD+0VaWhchWYj80bv1PVfTckl?=
 =?us-ascii?Q?EefMPV6xlE9jlBVG67gfgtBgeaPeTKm0hrgm92jbVLmR0lnmcWkooPoLFKbK?=
 =?us-ascii?Q?7lFs999LTzsEt7+CuJgKxQuiOwkCCNa8aHeaWmOw?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB9999
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4aaa1ac9-09b8-4449-ae83-08de584c495c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|7416014|376014|82310400026|1800799024|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6GvI7i5wZ5ygjXHCELjBaz5IjO9a6m8Q4fatOM6PtvnXRLvcBTobkH4Dhiot?=
 =?us-ascii?Q?iFvW/JViH7HmtJ4rKKpHv7p9d5/UoCtTGMzrF+onIPWwP6M6IXPHl8IOWkbZ?=
 =?us-ascii?Q?uRDrrfyOTIVTsD6RYLWuDiE1Z0vFJS7G6G0jpTbk8QnzBMo8LXuBLTgWhxrb?=
 =?us-ascii?Q?Tk/WQbR1WqdZ/9f00yLK6c71JbSN/xLJLC9Q84rFoxtxOQaD/4H2t/ZdR+1R?=
 =?us-ascii?Q?TbE6rkflLP//XbBvYvgTFZ1sO18a95f5L8OBubxuzY7twS25OGGmM2bxz2vW?=
 =?us-ascii?Q?Mo1/p1x97CP4n5Kz86LCcbdeWGm5YxMLkiuse5A+6FK/G1AcWshnFsfT1JHY?=
 =?us-ascii?Q?DSWY7hNRJ2tUNGzlVQtB/nGVKXu6hr9CCzWHQmRruHRKo0K23e4/aANv58Js?=
 =?us-ascii?Q?uRECb2udzLGKv7TdD9xC/CEvD2aKvzEadauu6znMBUSgzyam8H/Eb/GoDIgq?=
 =?us-ascii?Q?RwZgMdnQUlnBUwnJm6zvSETA4wItzfhR90oE7mWkJCdMczNJ292I6HONg86Y?=
 =?us-ascii?Q?7vO3arZnXDXvevE1nFOHe4waZIt6V3qOy+7OkkvQ5JAgYYkqM+IQbcQTIMoW?=
 =?us-ascii?Q?kuIX+Ii0NgcfTI3721EQhSg2OqRawBT3QlOgHafDFmW1njKp6EgB+Nscohdu?=
 =?us-ascii?Q?Y52wjMUqSp7W+rdnur24MmAEK8YfTlb2kJr98xdQROaOFrjulU2a2i3sH131?=
 =?us-ascii?Q?4df3oYKqnR50bpTkYlW5XW0sf+w1MXAV3L9q/mR8m/vSxNVwkboPYMoqOxco?=
 =?us-ascii?Q?dIcZlq9VmCOOIT+Jya5PfcvSNWWQhSgZOcGGN88zo1FSMRLM7A0bNtjOxA7A?=
 =?us-ascii?Q?2kCoSH6L4kDLi0DGD+z2I9JDA2xh5OpVRaEWiiolK5ZZzGlI9PyQeg0fSdgE?=
 =?us-ascii?Q?TUzbs8wz0fHDmhp3un2JHnt9o/80rKirgYOqc67oYUwBld31WvR+j+vu6aLB?=
 =?us-ascii?Q?8sEWE6IHzJhX25PAG3vE0++9oMYRGuYGUt9xtdv8bRqWAFsvFwxjl+Q4I/97?=
 =?us-ascii?Q?RHRJKrP1cUlC0Q09U/D6Ju5xRBevLjUHOk5avFbr4t3J4UQFxuAmcJ6gA7xl?=
 =?us-ascii?Q?YUG+KJM32yquPvIFC7I9GxJGa6AbbguWAsOToCnd6xS1MDHS0X91udx3Kq4e?=
 =?us-ascii?Q?7gQjRoYOADHYI2EEGNZVRBoROGJ+HSOFrx6QrRmyqJEom/ClChzGnLvxMR2t?=
 =?us-ascii?Q?YpBFKDPDlB3wSGXEfD7fA7E2Md4C5nrSXXdk/IEqgjeiQOPgWQYdZhPSO9Zh?=
 =?us-ascii?Q?gJfBNgmZstqiM6+7iwg0tIG2F8Q56Z100d5wJ0qb1vSlzhwFaSoR1y0Dxt3e?=
 =?us-ascii?Q?TFoomijyMiQjk/MVYRqCBnxjzrLmjepP6PrIUXiaxz8b7APIAjsA7QjfqYTl?=
 =?us-ascii?Q?RMVFNJqKpMcbLSdYuiUrPjv+pki19rR2583C10nSPeYLyhKBz1AQ1BH+U6pD?=
 =?us-ascii?Q?NhZM+LO4O8bFIJCIbyiAG/qi3r3IZNIqI0BJUbdspdRNurFFie9Rrw2Qd9cf?=
 =?us-ascii?Q?1QpyMFKSZD9tvY/KEXTOkPqCfqRMxTn3RNAirMYxggFOAa9rrWZb8tuRQM+8?=
 =?us-ascii?Q?LjGBnnkMoyqJW/MO0oWvGgOYrNzs8/hq5HybJGRIHLLGp6++OFNLqgPJSiSR?=
 =?us-ascii?Q?1ZSfj62S0eMSu1PZjzlxL06Zm68B/7kOb2MGFR+Ce8psYZpS/WyakW3ZkHc1?=
 =?us-ascii?Q?XG4kcfhzQ5kUZ6U7XYimHxDpxt8=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(7416014)(376014)(82310400026)(1800799024)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 17:50:53.4343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4021f610-5274-41b2-cfa6-08de584c74eb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10592

On Tue, Jan 20, 2026 at 05:35:50PM +0000, Ryan Roberts wrote:
> On 20/01/2026 16:31, Yeoreum Yun wrote:
> > Hi Ryan,
> >
> >> On 20/01/2026 15:53, Will Deacon wrote:
> >>> On Tue, Jan 20, 2026 at 10:40:30AM +0000, Ryan Roberts wrote:
> >>>> On 20/01/2026 09:29, Yeoreum Yun wrote:
> >>>>> Hi Ryan
> >>>>>> On 19/01/2026 21:24, Yeoreum Yun wrote:
> >>>>>>> Hi Will,
> >>>>>>>
> >>>>>>>> On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
> >>>>>>>>> +static int __init linear_map_prealloc_split_pgtables(void)
> >>>>>>>>> +{
> >>>>>>>>> +	int ret, i;
> >>>>>>>>> +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> >>>>>>>>> +	unsigned long lend = PAGE_END;
> >>>>>>>>> +	unsigned long kstart = (unsigned long)lm_alias(_stext);
> >>>>>>>>> +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
> >>>>>>>>> +
> >>>>>>>>> +	const struct mm_walk_ops collect_to_split_ops = {
> >>>>>>>>> +		.pud_entry	= collect_to_split_pud_entry,
> >>>>>>>>> +		.pmd_entry	= collect_to_split_pmd_entry
> >>>>>>>>> +	};
> >>>>>>>>
> >>>>>>>> Why do we need to rewalk the page-table here instead of collating the
> >>>>>>>> number of block mappings we put down when creating the linear map in
> >>>>>>>> the first place?linear_map_maybe_split_to_ptes(
> >>>>>>
> >>>>>> That's a good point; perhaps we can reuse the counters that this series introduces?
> >>>>>>
> >>>>>> https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/
> >>>>>>
> >>>>>>>
> >>>>>>> First, linear alias of the [_text, __init_begin) is not a target for
> >>>>>>> the split and it also seems strange to me to add code inside alloc_init_XXX()
> >>>>>>> that both checks an address range and counts to get the number of block mappings.
> >>>>>>>
> >>>>>>> Second, for a future feature,
> >>>>>>> I hope to add some code to split "specfic" area to be spilt e.x)
> >>>>>>> to set a specific pkey for specific area.
> >>>>>>
> >>>>>> Could you give more detail on this? My working assumption is that either the
> >>>>>> system supports BBML2 or it doesn't. If it doesn't, we need to split the whole
> >>>>>> linear map. If it does, we already have logic to split parts of the linear map
> >>>>>> when needed.
> >>>>>
> >>>>> This is not for a linear mapping case. but for a "kernel text area".
> >>>>> As a draft, I want to mark some of kernel code can executable
> >>>>> both kernel and eBPF program.
> >>>>> (I'm trying to make eBPF program non-executable kernel code directly
> >>>>> with POE feature).
> >>>>> For this "executable area" both of kernel and eBPF program
> >>>>> -- typical example is exception entry, It need to split that specific
> >>>>> range and mark them with special POE index.
> >>>>
> >>>> Ahh yes, I recall you mentioning this a while back (although I confess all the
> >>>> deatils have fallen out of my head). You'd need to make sure you're definitely
> >>>> not splitting an area of text that the secondary CPUs are executing while they
> >>>> are being held in the pen, since at least one of those CPUs doesn't support BBML2.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> In this case, it's useful to rewalk the page-table with the specific
> >>>>>>> range to get the number of block mapping.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> +	split_pgtables_idx = 0;
> >>>>>>>>> +	split_pgtables_count = 0;
> >>>>>>>>> +
> >>>>>>>>> +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> >>>>>>>>> +						    &collect_to_split_ops,
> >>>>>>>>> +						    NULL, NULL);
> >>>>>>>>> +	if (!ret)
> >>>>>>>>> +		ret = walk_kernel_page_table_range_lockless(kend, lend,
> >>>>>>>>> +							    &collect_to_split_ops,
> >>>>>>>>> +							    NULL, NULL);
> >>>>>>>>> +	if (ret || !split_pgtables_count)
> >>>>>>>>> +		goto error;
> >>>
> >>> Just noticed this, but why do we check '!split_pgtables_count' here?
> >>> if the page-table is already somehow mapped at page granularity, that
> >>> doesn't necessarily sound like a fatal error to me.
> >>>
> >>>>>>>>> +
> >>>>>>>>> +	ret = -ENOMEM;
> >>>>>>>>> +
> >>>>>>>>> +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
> >>>>>>>>> +				  GFP_KERNEL | __GFP_ZERO);
> >>>>>>>>> +	if (!split_pgtables)
> >>>>>>>>> +		goto error;
> >>>>>>>>> +
> >>>>>>>>> +	for (i = 0; i < split_pgtables_count; i++) {
> >>>>>>>>> +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
> >>>>>>>>> +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> >>>>>>>>> +		if (!split_pgtables[i])
> >>>>>>>>> +			goto error;
> >>>>>>>>
> >>>>>>>> This looks potentially expensive on the boot path and only gets worse as
> >>>>>>>> the amount of memory grows. Maybe we should predicate this preallocation
> >>>>>>>> on preempt-rt?
> >>>>>>>
> >>>>>>> Agree. then I'll apply pre-allocation with PREEMPT_RT only.
> >>>>>>
> >>>>>> I guess I'm missing something obvious but I don't understand the problem here...
> >>>>>> We are only deferring the allocation of all these pgtables, so the cost is
> >>>>>> neutral surely? Had we correctly guessed that the system doesn't support BBML2
> >>>>>> earlier, we would have had to allocate all these pgtables earlier.
> >>>>>>
> >>>>>> Another way to look at it is that we are still allocating the same number of
> >>>>>> pgtables in the existing fallback path, it's just that we are doing it inside
> >>>>>> the stop_machine().
> >>>>>>
> >>>>>> My vote would be _not_ to have a separate path for PREEMPT_RT, which will end up
> >>>>>> with significantly less testing...
> >>>>>
> >>>>> IIUC, Will's mention is additional memory allocation for
> >>>>> "split_pgtables" where saved "pre-allocate" page tables.
> >>>>> As the memory increase, definitely this size would increase the cost.
> >>>>
> >>>> Err, so you're referring to the extra kvmalloc()? I don't think that's a big
> >>>> deal is it? you get 512 pointers per page. So the amortized cost is 1/512= 0.2%?
> >>>
> >>> Right, it was the page-table pages I was worried about not the array of
> >>> pointers.
> >>>
> >>>> I suspect we have both misunderstood Will's point...
> >>>
> >>> I probably just got confused by linear_map_free_split_pgtables() as it
> >>> has logic to free unused page-table pages between 'split_pgtables_idx'
> >>> and 'split_pgtables_count', implying that we can over-allocate.
> >>>
> >>> If that is only needed for the error path in
> >>> linear_map_prealloc_split_pgtables(), then perhaps that part should be
> >>> inlined to deal with the case where we fail to allocate part way through.
> >>
> >> I was originally concerned [1] that there could be a race where another CPU
> >> caused the normal splitting machinery to kick in after this cpu determined the
> >> number of required page tables, so there could be some left over in that case.
> >>
> >> On reflection, I guess (hope) that's not possible because we've determined that
> >> some CPUs don't support BBML2. I'm guessing the secondaries haven't been
> >> released to do general work yet?
> >
> > I don't think so, since the linear_map_maybe_split_to_ptes() called
> > in smp_cpus_done() but in here, secondary cpus already on and
> > it seems schedulable.
> >
> > That's why although, This is unlikely, after collecting the number of
> > splitiing by other cpu have a possibility to *split* which was counted
> > and at that time I agreed for your comments because of this *low
> > possiblity*.
> >
> >>
> >> In which case, I agree, this could be simplified and we could just assert that
> >> all pre-allocated pages get used up if there is no error?
> >>
> >> [1] https://lore.kernel.org/all/73ced1db-a2e2-49ea-927e-9fc4a30e771e@arm.com/
> >
> > So with above reason, I still think it need to sustain the free
> > unused pagetable.
> >
> > Am I missing something?
>
> My concern is that if a secondary CPU can race and cause a split, that is
> unsound because we have determined that although the primary CPU supports BBML2,
> at least one of the secondary CPUs does not. So splitting a live mapping is unsafe.
>
> I just had a brief chat with Rutland, and he agrees that this _could_ be a
> problem. Basically there is a window between onlining the secondary cpus and
> entering the stop_machine() where one of those cpus _could_ end up doing
> something that causes us to split the linear map.

Regardless of BBML2, does it means it would be a problem call
set_memory_xxx() API during this windows?

For example,

CPU0 (boot)                                CPU1 (secondary)
linear_map_maybe_split_to_ptes()
  collect the number of pagetable
                                           set_memory_xxx()
					      split the specific linear region

  preallocate() and spliting().

TBH, I'm not sure why this scenario could be a problem?

> > --
> > Sincerely,
> > Yeoreum Yun
>

--
Sincerely,
Yeoreum Yun
