Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBC126C16
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Dec 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734800583; cv=fail; b=HeMehXu4adk1kEGlPTGfh7/bkPmRvEuejxjcqfT2kHQv/VgLiheVZKWsJTgGxbi9lwFj2uoCELV5hlLMa0oacvp2okwgeo6jnfgLx1vz4mW2JR1GBq/qqqrVCA1/J5runqo/O8X+NI+6PUHKvNlOauWEVCu4hfIJPhCMx6cBT8A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734800583; c=relaxed/simple;
	bh=fnfyfjco03XMjNnCNdSjZnnfdiL8h3uzrGvm+iX64ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tiz2VvA+5T/6pEND6YlUxLBEhYXT3q3J50a/bea3Y6OL8oGug6pQOVLw7MiESvtFZFlWOe1EBmK2ELz1VxH24/q/tq3giz1YsuVQHnFMHdH9p+MXxXafT+ui3PL0C0WRsDjjaq8Axt8jhetkq/VuqEuQNMLlSyiJQ4vq+T2zGO0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rU7EXM1n; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rU7EXM1n; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rU7EXM1n";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rU7EXM1n"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IIGxzXg3gWsIzNMyXjxsUtJ5wE9f81uYG8whPEZlvCTj0ho7ezt6mGFdJvSVnATq5PJ59NvV1uQ4fD7FMZ8aXup7IxiS7lNpMVD6JoVaLsS1BD4Jcce+uo+15uA8+6ZBaL3smD0CWflUcqvSP4id+2zzNQXf0SxPEF+qv63kKe2ju+uKiolrYIBp11WoPutqAFH87Dj+p2XM+rlLnslh2spQF8g9SXZn4XeHQxyoEKBmQnbNNfmdOFeDjLEiquxJJZcLvEqZ+aYxOMHfMBmcgkjLHHbkaTeju3jzAJFzTAcklLW4UgJSjBgEWmzYaQlmKfdI5GSGy8KjlddOJG10ow==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2u9B/SwHKymlA4mFQ9/eIcJA9pb6XvxqVFnPxJFAI9Q=;
 b=cS7T5R5nQv+vRtSy4Eq6z15osbYYsE7GXWR926AKKAtXAuV/qzF+KJvrNCy3VNxAtaUaeuXmbw9gYqmKj/QYwYogjGD0BrPS8mDBZz7HUBcXrk/aSzmo1bs6LcbneXI4QQ1QifsvWKuHEhynDrug/URl1I55wPNLTkb2egl3/rlMC2nSBYZA/xY/6+u/rK1B4uskZ4sSg+PWP0XRW3OCKrWyAMkdoLpDB6Yu9Y1xH4VYFuzktkk0s5R9VBEmUqX6hJFnfzmmEfLCRApxN6s1owrmumkE+PmhocYPtWY93GgonJf5/b3MuHwIGLlYlLibNoOCo18hPRIjn9BhjQimMw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u9B/SwHKymlA4mFQ9/eIcJA9pb6XvxqVFnPxJFAI9Q=;
 b=rU7EXM1n0cT7WIpFOhMoNsSEdvhqO7u8b5kZnETlqekpPsNVubU8Fxb5PkKUL0rKeF6aKW8JlSLK2wVezeSh5Hlfk0ixCvsbzhIBdlQDWW/fM+v1FLU8I/5R93vQXbj2HKwd7gbc0ryzrAIA07BwPc5kvZE7fYBNzYp1ARWyEUQ=
Received: from DU2PR04CA0072.eurprd04.prod.outlook.com (2603:10a6:10:232::17)
 by DBBPR08MB6281.eurprd08.prod.outlook.com (2603:10a6:10:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Sat, 21 Dec
 2024 17:02:50 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::6d) by DU2PR04CA0072.outlook.office365.com
 (2603:10a6:10:232::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.17 via Frontend Transport; Sat,
 21 Dec 2024 17:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Sat, 21 Dec 2024 17:02:50 +0000
Received: ("Tessian outbound 050b604d5e06:v528"); Sat, 21 Dec 2024 17:02:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c7defbd9267b4941
X-TessianGatewayMetadata: 2AdGQ42VwDO3dj9Sa8PeSzwGTohBGphy0YJuGEoEV8qx5P7BYkjOczxJ5+8f4+bdphBoD1f3hgH20A+GP8WdcxxfEK6Evas231AaqWRsJM80+qi+s32mnN5Nh8bazcwd0sqjaULkAIOFUXFu5WCMMg==
X-CR-MTA-TID: 64aa7808
Received: from L47691b039012.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8D6AD5CE-072F-40FC-A79D-31F0B771B0CB.1;
	Sat, 21 Dec 2024 17:02:41 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L47691b039012.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Sat, 21 Dec 2024 17:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIt+e5xZmtUZzSZylDH4lY19Ff/pr0lMmaWVQM03rZj2XaIRf7/Ewo9pJboS/gT/8mCtDT7NVqi6ihmpvl/z6w1AOVvSt7UsawCZPD7O/2SlxJreyUV8x0gBlI/ceJlHcR7VBxSp624HhzqVcNPpf2J90h25NCE8SzrFo/Aon/jorq5ffhNb6hux7qoa2uOUSnugB7Spjv9c2OikElczLuTHz8t3/fXphOxWdRtzJ2tF4L5D2BsitNKs5xnOVT6UtG6c/+k1YwbaLQFHsnL8x8hwpjNXdsHaKRajKAyGPxMO2c6nTpSb5MI6EgH6o+Cd8zPuqE5vgusYzk9tzA/ztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2u9B/SwHKymlA4mFQ9/eIcJA9pb6XvxqVFnPxJFAI9Q=;
 b=lNc3cbBHGnEtzHORotGALb8IWGBV2IKwR7gLsVQ1894bHx9CnVnP7aedXSaKMcIHthTXVR6/cZck9Fc2XKiNGrF1CcTQDOPRJ4BMf+7Uvebmlslapq0I8z/RN/17m2m7WKATHN4xHQFxMeDPyyjTxvj0E/HG4Roib8u/D2iGOmOL1jKELeNhbrJCNipTJ6Eb7bKBbU29OY+C7Y0ipDdEJXHIupZaVZTaCI865pK5qFKQcZ6w8jWxmaQSU7/MXoBMHl6i8iTiXVdh8Yt1VPdfc7Y8ILdWJt6OBIN7TiAdDGIyv+hJPW3EiFPy2jV5xxIqIMKIyTAJ0kCXSpI5HU9n6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u9B/SwHKymlA4mFQ9/eIcJA9pb6XvxqVFnPxJFAI9Q=;
 b=rU7EXM1n0cT7WIpFOhMoNsSEdvhqO7u8b5kZnETlqekpPsNVubU8Fxb5PkKUL0rKeF6aKW8JlSLK2wVezeSh5Hlfk0ixCvsbzhIBdlQDWW/fM+v1FLU8I/5R93vQXbj2HKwd7gbc0ryzrAIA07BwPc5kvZE7fYBNzYp1ARWyEUQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DBAPR08MB5685.eurprd08.prod.outlook.com
 (2603:10a6:10:1ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Sat, 21 Dec
 2024 17:02:34 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Sat, 21 Dec 2024
 17:02:33 +0000
Date: Sat, 21 Dec 2024 17:02:31 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Message-ID: <Z2b0p8XiBsa5VM27@e129823.arm.com>
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
 <CAJ9a7VhxG_8R6j5uRCzOhLpy4ZmzyVvyW0+ryCcd4w7wqpZ2ew@mail.gmail.com>
 <Z2VJIh2+Z40bZi1e@e129823.arm.com>
 <ac537889-dc0a-4d2e-870b-c5a33279633e@arm.com>
 <Z2VXc/R/nOLGz+Cg@e129823.arm.com>
 <f0c15466-a27f-4cc2-90a1-476ec278d870@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c15466-a27f-4cc2-90a1-476ec278d870@arm.com>
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DBAPR08MB5685:EE_|DU2PEPF00028CFC:EE_|DBBPR08MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd41501-74fd-4794-7b8b-08dd21e14d10
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?84jkCcGJnF5FkSwrfPm/Y4WWim3rJyYY58vZWxb9LTcHXiclu6ZEkYSba4jb?=
 =?us-ascii?Q?o2GGhajpptgJvH353ng85IaUhjiNE3Zn78CB4K78W6ilWu5h8L3MS1Rg+8EB?=
 =?us-ascii?Q?8U3noBOjFWBct3I/H//Ll7evMbGskzgUdyYF5EJLTAs6g2wMc2wqnGy2Hm4G?=
 =?us-ascii?Q?mFtfm62vuASdsmjAleZIZuiqbxaSrB1yTf/OmK/eq6Ejgfn8APCA5jodX4PA?=
 =?us-ascii?Q?feQSZQgU5N7c+aIbeMPZ2FEloR6D0Gu2sgxXSi3L88trMMe2BJqOGP862gXA?=
 =?us-ascii?Q?8kKFYJ9ORJ3hXs9o9MIl17ew0WHHA056I52eL/txrMNKwHn9+8xWbTyH7Fm4?=
 =?us-ascii?Q?qRRsQTB1NwiUbMq9jAoOeJrZl2pRgp2Z6jsO6mATadnQAYTmj3wYVU6f+c1k?=
 =?us-ascii?Q?pwn34Gdwe0QjwtKBjvBOBsEwzcRILyxgrGUMwFliFgemA5vRwh6PxnnK00S7?=
 =?us-ascii?Q?N1ZLSxCNhsof8N/JD1v+bVheFEmQRTubukyxt0pbG69VNjWcjfJ0SPvA8NMB?=
 =?us-ascii?Q?pxj6hQcJGVsGgxSv8WfD1FtI8lZ0o0D1+Li2X4Eqm5ibVaEyLq1X+H64dXak?=
 =?us-ascii?Q?Ikc0cAJQJ4kq0kGso8wGNXm39+EG7AFNiRcgXTXoIkTKCiDhyjh+vR11thNO?=
 =?us-ascii?Q?69yTY5rSM5PFcWB6eLpa61bVCCyAKhqURZJD469oA6rpql5ZuVBwI8vl8eHi?=
 =?us-ascii?Q?WzRplMR6u90Q/SKmyxlGShR5jhzuGYqSB13QXCe3Redb2P1SOL71Vff52qb2?=
 =?us-ascii?Q?YiOCFdzCpBgifeuL16gf4fTs8SpdjV8qVqRmIabotuq1lX/4m/fgl5d10lKZ?=
 =?us-ascii?Q?SNcIJs42BLz0ApRwjkOwryqim3uAKzELdH2BM/NizRZgUDK2LM7YZQKtpOKe?=
 =?us-ascii?Q?kyarKRxXAnIAloPrIU6BTXqrAEU0rendkPpsaxfh5qBKRWDuEO2c03fVa4b7?=
 =?us-ascii?Q?vRZ3z4HGjOdPPOs6lJHh9p01Vep3MqE4bC/Gsk+SNBL9Uj+qvo/9yrf5j/Rv?=
 =?us-ascii?Q?va8SidVmRljx41duimn8mIYZUubjGfWzkDw3hdWHrbxecI2PCFKwzbmCsFSV?=
 =?us-ascii?Q?Z3F9vHfDQWwt1Qir+BYkkjpE4JU7Jr39zN7wb0U5xLGNeEPgNRa2TjwUuDkO?=
 =?us-ascii?Q?M6s285asxDW0oTztykZCy9AMYiOW6gcPgIISCcyKzEVQs3hpx770TKKX5T97?=
 =?us-ascii?Q?223NiWhreRS+PXovg6URzs+Yrojg9TLVGxYHotp5+2MjWwweBBSTNoTQN0GV?=
 =?us-ascii?Q?V1EGUw9+gPs87BEzhLL1HFMQKVaM4v2EdR32m0xRQtD9aqMGmAze3B0xYaTN?=
 =?us-ascii?Q?W4LJb7eJ+YMQnj1UdhKGPyXL/75FX9yUIykCbcXfvGW3uesSCY5T/tMcjvPi?=
 =?us-ascii?Q?CCncg2jfJ6fXOLsS2a2ueyFQYevW?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5685
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ab22253f-8911-44e5-5c61-08dd21e142f9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qJlM6EPumgofopJE+kh4LfvLlDdxR/6qQQkJQj2xli1FiE6nySnu1ar74vHC?=
 =?us-ascii?Q?qMIMIrUNaRIW1i1DvDkSxCmO2Z16vCH8H7tJ9dniLJcj7QAjc7AmTg+OVMla?=
 =?us-ascii?Q?UihUfjjT3TnifACSKfOUv7D+nB4eODtuoFE5RnCNopfkhFbw8e6MImj9zMzx?=
 =?us-ascii?Q?dGcFBLghUvSL1dDOCy/DPMtykTxiqnEG13OHH37mPUX67WuaXR7olV1LhFKx?=
 =?us-ascii?Q?d+17YxPlCw/x2S34RWS/GszdxvumPx3FzuFXqVezWhUqJ8QBa6ftgxj0Q3TC?=
 =?us-ascii?Q?HY1169d679ic5ApEFKdwqxcuIYSFiOCforyjOQQ0YSUa1Npb+JC/3jVJD7VZ?=
 =?us-ascii?Q?lVPwBK9W5C0HuPAUfpxBG4kTrCoJ6/BHW/7Jt0Q9tlgjkMM2rr3KK7ivttwd?=
 =?us-ascii?Q?+KcP76jKME2e5cKYr9n6E1drqIzSjq8d2n7Rw45PfOBYykyOGybMTdSo5Hne?=
 =?us-ascii?Q?g498ia11CQDcc7d3xsxAjHDc7odLmyxuZs6m7cMxnXeajhXmbhJQnBlZM4nn?=
 =?us-ascii?Q?/r5+jSIu8Mw+djozu6jf7rmyiwlxxoZMJJg98Et94k0wvj5F9tQoqbDoc5jH?=
 =?us-ascii?Q?YC6MRF29Oimp9w+uTNK9GIKsbPwCfRzqwURQ37Kgoz8lEnEkjuRASFTenlZO?=
 =?us-ascii?Q?ivevLZ3xDmZJjlyF87aORT9tNMYtlGPzWiSbcW6DNrmNZqetXf49GIOzb1O9?=
 =?us-ascii?Q?ooa5T88mPb++5m0kpIjv+4oULFxx89EUEPMmNZf9k49zV/wTesOSny4mfvCy?=
 =?us-ascii?Q?Ko/doDnPnWwkfmWf+uvn/fo4ZjKH3PeI4WtFR+FU9TPs4EttA0nbji1QLZFY?=
 =?us-ascii?Q?qZ0UoVFiU2pZdvrnKjmwEYzQzGV7nS7czTnPNso5+AlC8zVwJelAVMvEbp7z?=
 =?us-ascii?Q?0cVXHO5jD5SKT3gN8uFXDugEJ0ufbPCk055M+hvdHka4DIX1St0Zh9ySKVB/?=
 =?us-ascii?Q?2kQsi8PFvoO/7yo4hbwYyW1uX4RK0pNSQKWaGVK2v75zcI+8XuGk85ODJRkb?=
 =?us-ascii?Q?dalsQxM3rcd1JVaynMJKaLMVLptxx5bOsEwkCXm4TIwXRcJYI5DUYROnyJYZ?=
 =?us-ascii?Q?YxZxaav4yaSGMCzWcWOodOx84ugqW4lIhpx2YtbTiG6bNdth3GGiQemRSfMk?=
 =?us-ascii?Q?HIaMlpNlIrRO9ixww+FII7yVD7bQw1Gg4kX3/tzr18x3F9sw9bMxHzaFvUVW?=
 =?us-ascii?Q?TumuAKeS8zCsKkZYo2Ann3leIjB5oREQKvK7LvYMF6Qdhkz+XepTVnNpO50H?=
 =?us-ascii?Q?9Oh2A73m/uHEHDsSWLidxM3etm7OK7AKHnWAFbtXe2yphG9zzcnv+pt5hlvd?=
 =?us-ascii?Q?gBhgQz/HJotGV796V4y10gojk0N6Mjx7YZTtW/OynPDaT1Kv//sOqB2jqmfI?=
 =?us-ascii?Q?WfmN2SvxKDoYwoMNS1+/j+MciAygUMpDUUxvjF2FvC3rk/ErV0yO+Fs71Z/G?=
 =?us-ascii?Q?1icyDtK34AxqNr1E3y+B4FVvMMdWPmP0/PR67HnI2GmLwTzauY/uKiDwGRU5?=
 =?us-ascii?Q?Jn0F3qJ9utN/PxikQ7h2DCwi3pHnXFSeNuF/?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2024 17:02:50.0606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd41501-74fd-4794-7b8b-08dd21e14d10
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6281

Hi Suzuki.

> On 20/12/2024 11:39, Yeoreum Yun wrote:
> > Hi Suzuki,
> > > On 20/12/2024 10:38, Yeoreum Yun wrote:
> > > > Hi Mike.
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
>

Here is the patchset fixing above one:
    - https://lore.kernel.org/linux-arm-kernel/20241221165934.1161856-1-yeoreum.yun@arm.com/
