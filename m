Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013001.outbound.protection.outlook.com [52.101.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591570838
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Mar 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271882; cv=fail; b=EZSbRtE/sSANsR5QaXU/jHMevfAM1DPk5yNXze0Q9NR0koTMAKZtV4rQLfmGiA3VqLX0YZc2wYZMcWzCl5xyXSGpQj4qQT6Sd7VTBynVNWjWmJuLwQMnCr4aNJrhTTCZNc6c/CNs4vCLPpN7ybpBUhqYyjzSg5qFoUTD2GdbErw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271882; c=relaxed/simple;
	bh=HgYKpwb1zpLpMgjVyD+anb575tSqqqTSsqY9Sxf+SK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jzWKf2N+wVU/+0TbXubzIbIox9bf9Q3jUkHBWr6G72nGkdzV+uF363tv97992nvsjJbowGOO0E/DJZsSZNvGBgJ5UufxPWAODZJRtzggq20Z+yRbEfjpJitv/COQiEkS5/7oBAZnfpreVB09YKro5+doxpirZc17X6G6hPA+xFY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OhLNHnou; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OhLNHnou; arc=fail smtp.client-ip=52.101.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OhLNHnou";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OhLNHnou"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ygZbpn93DkZZF0zjQCL8K3jnRIpuj0JufSMAtoAicALlhaDJ+tPOq6fj3tUNyhiPPd0Rx+imoxbvEYeVgJ9yCqK5DYzWbm+00bfUVnkFQJulOarK/c5jDt6oCgk+PD2YxaNgIkUk8UVndEWlQ/qjexCQFCzFDPh8MYYrEhqA0cTyzKVNXhndFKa8rGmfNhRPhmtuaHSMO+BlzWESczvfUvivfa2Vk2EnbEp8T8kZmukiyperxDE2SBxkVTS8qpb2XAO59rnbw8xqcPV4GCx96iLxnMmB4TNV1CPab9sAkGavjhCkn5WL2bt4qsKHIK9M6Rt6SFsa0NOgJ0WuBIIPVA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOvlUZOc1n/MGIjKD/9YOZaVszAp2gsVr3Iy066nDsk=;
 b=gECm2pGNCmXyw90Wq4Erjxt8TbiiSNTKbm0NIpF8yTyPx+Lam+uKCyV7aoDJ3e/ETkcWAFrRI5z4ulU1u/pNj7HqTBtZLJIiELRrY2PIHoRqdPsLFQQ5fOiYOmuyAzUEp7Qoh7jHq5IPNQhrizughkt7VTS0PUjKkXYfAJv0WFfygUpcRdvvheGR0ddIJdLG69JIW/Tm1ubh6zB9l07ib4/1xLqkyTfzR4dVZrYmkYZL/eiu/b6EPSluY4Qz2DOD368c2y3BaBh0s1Zp+INdayLML4gR8CkwGQqvEYJ12rn70d6IgXIMfE7+g+KmPS7yaq7r6IhKOUcTMixiapYPtA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOvlUZOc1n/MGIjKD/9YOZaVszAp2gsVr3Iy066nDsk=;
 b=OhLNHnouceGnrLkpwq5jL16r0KkMgPr82NkT1aT4E1CE2amca7pcRYLYxkes0HURryyrMHg4sbq3GaZgRFBfag4BxO5DkWfE6pNX9Z0rXNifP3JMhUyPAEKRClTDYnwtQ7WXU6h21rGwSm5mbjR7I6e+p52rDeBfMyLr6+fVSYg=
Received: from AM0P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::32)
 by DU5PR08MB10821.eurprd08.prod.outlook.com (2603:10a6:10:527::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 14:37:55 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::47) by AM0P190CA0022.outlook.office365.com
 (2603:10a6:208:190::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 14:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Thu, 6 Mar 2025 14:37:54 +0000
Received: ("Tessian outbound 93a06e49d4fd:v585"); Thu, 06 Mar 2025 14:37:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 58b9c54bdc31bfca
X-TessianGatewayMetadata: deAWYjpjz94onbbAxOEaBCvl+LXT+djYe/v/vOvNtaFZKVg3XeH+OHLAj4Uw04Sr4jU41Au9h/5WUI6LQDYurVq4B1zEkvwAzbCIYvOmCbz/R5XNgyWWBZencW2S+NBZzoDqFIXbSHQBR8eJKVretA==
X-CR-MTA-TID: 64aa7808
Received: from Ldf03ee2da3e2.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1A9CF1D5-B243-41EE-80AC-7A4BDAEAB902.1;
	Thu, 06 Mar 2025 14:37:44 +0000
Received: from OSPPR02CU001.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ldf03ee2da3e2.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 06 Mar 2025 14:37:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtGcVvtL/2LWKo1CiwNdt0/7VWjR0qRMs962yc5sZ6yECDaxsQZKYA8RfaU5cbYtvanE9bIcclVmiTVid+5Ek+GYpcflGZs41m2YjuDE/UHLahgtHWiJeb7zqoObDiHo9Md4OnW3mnsl959zUOCQ1t5If56PuuEVgiGWYNo0+Cbb8nOgaMLIaEAMrysfVhnPvb7EENf8i2zw666gcU7fg5JgKE3MoSAi5YtPC7b4uhxwVpTR1BKk+mjs9h8C6oNg27kUeupbWwjyu/NqfOz6/z7idx9cv5BJxfExSos0jBHuYm/0BeFFvIFuD9/BPLydqnZ2X5sd+Osrlrz5ydITfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOvlUZOc1n/MGIjKD/9YOZaVszAp2gsVr3Iy066nDsk=;
 b=sHlx985VNPKQYIfhdmtJMHnfQSxPjwCraqHJfeaF1FpwnP44e9ySnAU5X7lZlgWwicoVmHsWlZNbiq6th4Ltrt87dS0QfCRBS5ZgbDup++qvXNU0/WM/FUEhjUhQVieYfi7hZi8ITOcvNzxAcI/kXZ4qNlTQ/IBe2OLGTDZUF46bJqcu7pgGWwL0fvHMUmIF9BThX4jSs/9sDxSwQAWmghWUH5A5bVBr1scwl9qKWqYTl+nhwJPcwUVZX9yEbbFLms0WWssfEhymfmE3WhEIpDmRdnpIUBN+N84M41qvbxHUOl2iKfK/lg4+0kyQ7ukmx/CEae+Fxf4NJaTdp9ISbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOvlUZOc1n/MGIjKD/9YOZaVszAp2gsVr3Iy066nDsk=;
 b=OhLNHnouceGnrLkpwq5jL16r0KkMgPr82NkT1aT4E1CE2amca7pcRYLYxkes0HURryyrMHg4sbq3GaZgRFBfag4BxO5DkWfE6pNX9Z0rXNifP3JMhUyPAEKRClTDYnwtQ7WXU6h21rGwSm5mbjR7I6e+p52rDeBfMyLr6+fVSYg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB4PR08MB9286.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 14:37:38 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 14:37:38 +0000
Date: Thu, 6 Mar 2025 14:37:36 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: mike.leach@linaro.org, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v6 2/9] coresight-etm4x: change etmv4_drvdata spinlock
 type to raw_spinlock_t
Message-ID: <Z8mzMI2xGm3qX9an@e129823.arm.com>
References: <20250306121110.1647948-1-yeoreum.yun@arm.com>
 <20250306121110.1647948-3-yeoreum.yun@arm.com>
 <bd9040a2-b03a-4e4a-96a9-27f6a8db1d48@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9040a2-b03a-4e4a-96a9-27f6a8db1d48@arm.com>
X-ClientProxiedBy: LO4P123CA0592.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::9) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB4PR08MB9286:EE_|AM2PEPF0001C70E:EE_|DU5PR08MB10821:EE_
X-MS-Office365-Filtering-Correlation-Id: caee01be-8213-44bf-ac1a-08dd5cbc7b43
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?UceU1VHfGetIRuV5rpEoHudThM02JZXFJu/lvGx2ImbT3bxWK4/ZVCsVd0M6?=
 =?us-ascii?Q?nqdPgE+DBvgTdoZk1uH6J+dJ+ycX8JzQvLUPMAG4EDLiP5Ue4IwjYIPW9k8P?=
 =?us-ascii?Q?kFCSneNhGSIH+dYRe35G2XQa9Zs4jhY2mW3YSo3GXD/570ceAvAniQcGd61k?=
 =?us-ascii?Q?wsxoon+piQmq91rOWy5rlOIML2mz9nMoSyg9mesXpqUz5uHDn6QCDxwlEpCR?=
 =?us-ascii?Q?ULZ8NLNXa2f0mJUo3YLB0HJUGT1wCUe0ZNQeQCPBpPjpCX5sv2WBLo8eMkca?=
 =?us-ascii?Q?v7DqMDvc/PWyygEiX/M5jHAr5IMw+VdaGU9F8ImCl+trB8gZBbXgp2z/lyN1?=
 =?us-ascii?Q?x8gmsgrsNTrxnok7cpmG7wdRRPexCE6mqci8GoQKS9t36CVlh5z6BnNh1Vxc?=
 =?us-ascii?Q?e7GRF4nA7rZ8Zjlr5soqLZRV0pzF55xlt8ukj91DHcU8a0GUQMamug/roGkL?=
 =?us-ascii?Q?0cvhmRVbZziEtiTCWqtHBID9IfTiy4WWz9u+Ob9lRzjDEeyJR8VyKRH1gMHw?=
 =?us-ascii?Q?A4qeqc3mzRM6avea6MyVTtbitE7tfN7AVWsu67Rp1RpOKKucLwBLJXyFkGkE?=
 =?us-ascii?Q?qupICRvipHth7LP3ewAnp6pGGxL8Pg+W+qsBKXGetbDmOfrWMethhYKDZXkC?=
 =?us-ascii?Q?X/IDwa8gxi6lQrhS3/bLupYxDwncYaWA5frSYFZR7tqVARkOw44qQOXNXetC?=
 =?us-ascii?Q?IoEhevpKnohGZtiWOZTbP4UU2ufAxfwN/prfADlqXqty6nmMjQhdwKxvZ1xH?=
 =?us-ascii?Q?MoT32pyDUKg6cDv2+CHNs8uU4OOXKZNI2m80soxGYyxnRnxZodBsUHHeLyls?=
 =?us-ascii?Q?613mxXVp0Sx/Nia89zmtsFNZRgGe4t2qiTPNVEMS4EG90g9uYYKbpkYwATMu?=
 =?us-ascii?Q?B4k9xsvYTLau+p1Eql879MpEx96FXebrYvgn//F6/lhVTWfWUKaCpsUjbF2Y?=
 =?us-ascii?Q?NJlpMtPQkhtaTnn9CgrYPiyDr6Z1K7l5gyl0579vlZGvA39TT3hxSHnnmakG?=
 =?us-ascii?Q?emyPZlUIO3of3Suk+3oh3U/dmxyAlcIO6gfG+tEfjSVYB96GoM9e3t94YGAo?=
 =?us-ascii?Q?ajLCeQyA2i5EdFOUD7bQHGoFQj+DDBfe4QUrkcgV+wjmltCLBXIbjHD8JMPa?=
 =?us-ascii?Q?F5sE+Rs/48O7QT+UssFWrIYWBrIvtAkviReh9q/CODBfHD8Mct81gSWhIcB2?=
 =?us-ascii?Q?zKJsNPXEF7DdOZXuNxVg9SIHFIj5ut7iEpJqE27C3f3ddYmHpFfCnuIbvJiw?=
 =?us-ascii?Q?/SNXtE/5KhnJDC/++mpfA/w1gEXJmrnzZTnV+RFv+gXB/eSh46onRQICoTkh?=
 =?us-ascii?Q?/ENWgbRQvI9Ybsv9lXqrdAIKROx2dLnFaRELKK4Ajj4LCe+h8pS36T5108dO?=
 =?us-ascii?Q?irrVOd/KDPwV8UCTQm9zJxnlD/BT?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9286
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	58d1e47a-ad77-4aa9-0920-08dd5cbc7172
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|82310400026|35042699022|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GiRvKVcj3Bro0nmBTGEpEgkam73s7lgf5A7jvnw1NM3EBH/BvTWgdT8ORAaM?=
 =?us-ascii?Q?mDDNcFdN4OCPKsMnYObSZc56+yJ+sa2exSOxIaCQxcml0dUpknqflgJmzsUX?=
 =?us-ascii?Q?iWs43MVg4+BD2AYXihNg9TxK4HC6Tg11ptZqAKkeSBVqLMoJyH+HDEMzUg90?=
 =?us-ascii?Q?VdN0S9KYdus4T10ymbpeAj69Lq0vnxbiHggkoY8ww+/hjnqqDUarJFkgf/+t?=
 =?us-ascii?Q?VhL8FdX2fvjiUd0e3W+7HFPzBIGKLW75tlpDE8IORS956uDMlesjPCwNjQf4?=
 =?us-ascii?Q?veLLG74JDl6DYxga531K21FP5SXyNju5Uvv9G2L06ymKyT2dAzb40hC0cVIy?=
 =?us-ascii?Q?0z213oUegVejnD4cCv2m7QHcSMdJEkqabkgFasArvYlsBawYrTpCdnuwH40e?=
 =?us-ascii?Q?3CP0v4JLSKlyjxQ65K0/DH7/mHwO4HfKAU6IhtCgY1LaDMjSzeRSFRXrZWlc?=
 =?us-ascii?Q?tku0i4uwAaqDrkCCT94ExPwiOjyqF7Qyf2bSJFI5qzQQNrksHLYmHm+/rcyB?=
 =?us-ascii?Q?sFz6Bz2lESpXF/mq8GNfHBKSgZR2uObH+mkGC+Xxz7I64C7Q551Zdk3NVPYW?=
 =?us-ascii?Q?4t/1fWvyzdEKlp2dqhHZjcopEwrkZPt50gbGhipOSxx9fXbDIJJ43htey/Hf?=
 =?us-ascii?Q?QSt93rw8459fxQu+aK0kQViZsdrx3yJ+MUayRTs4S9qlYKq43kFd2bHVJIPI?=
 =?us-ascii?Q?L9qiWUzaY/KrTQPoBBnk4J9z1HC3RbbWrTvoHaPSIb2fgQBk/cEFUXEtAQ7U?=
 =?us-ascii?Q?tlm7+24AIQia52zkmt2Q2bBaR9OCeax7HGldp8WmBiQlNvj3fe5WeCsW9dcV?=
 =?us-ascii?Q?BVDm4DX1SCWcsoeE71comuQ8mH0yN1AGE7sOMhzT0TOXaZY5UfqBZDCZ3zHt?=
 =?us-ascii?Q?egR+Y7PInVcPJOrCcWWdfU2ct4B3l51mQyFv6pollRFXlvRiZEi1/qxJq5sN?=
 =?us-ascii?Q?hxi5wpxVUbZzzQp9EdSkQ+IWpD9YbSlD2R3Ar24qSFtz2WDBz3l4MswxTkwB?=
 =?us-ascii?Q?2uqELe5tqECfFfU70GBPtUEa4zpyooQ1FBUMiDIovHmdrbBeEZQFnIJ8ieW2?=
 =?us-ascii?Q?x/QFwIiDPeSEzJp9xsFzZ2OKGovTKLG6qcYVlsY1yTNfIimWduWLPhQRbhb5?=
 =?us-ascii?Q?zA4YMK/beYJ1CjjzR2MXQ8dB0fU3HjoJ6f1OCPfnV2G1X/rdxMtJrk7Y2OrF?=
 =?us-ascii?Q?7SHqr85Hajh1c7Txrno+G236uLAN0F09RjvrGZDfRdAFPaFEkC2LeLF4c/wf?=
 =?us-ascii?Q?ul2LMJRMGE2pGlxsA7viaizOhaZ79HY0E19zeLpP3NiT8M7/IMyX2xG7XdnG?=
 =?us-ascii?Q?rIY0hvrNXDizebFqRi+VUv19Xnj9wbt7fV08PW6Udn9Y7iy3r/GNuSN6UeLM?=
 =?us-ascii?Q?Yv9+k39liAItp9TVOJJDimR4zjJ181XjHF7ZNehJxKQ4OQAQ72xIKOIALvZP?=
 =?us-ascii?Q?iIl0NsvHf1/MZuKSHc/LCbzyVxOZQwNbZuPj+dDxjhYyBGaqZ/oElNZBpVlt?=
 =?us-ascii?Q?GzY5BGZmwgR3lqg=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(82310400026)(35042699022)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:37:54.7649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caee01be-8213-44bf-ac1a-08dd5cbc7b43
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10821

Hi Suzuki,

> > diff --git a/drivers/hwtracing/coresight/coresight-config.c b/drivers/hwtracing/coresight/coresight-config.c
> > index 4723bf7402a2..4f72ae71b696 100644
> > --- a/drivers/hwtracing/coresight/coresight-config.c
> > +++ b/drivers/hwtracing/coresight/coresight-config.c
> > @@ -76,10 +76,10 @@ static int cscfg_set_on_enable(struct cscfg_feature_csdev *feat_csdev)
> >   	unsigned long flags;
> >   	int i;
> > -	spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
> > +	raw_spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
> >   	for (i = 0; i < feat_csdev->nr_regs; i++)
> >   		cscfg_set_reg(&feat_csdev->regs_csdev[i]);
> > -	spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
> > +	raw_spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
> >   	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
> >   		feat_csdev->feat_desc->name, "set on enable");
> >   	return 0;
> > @@ -91,10 +91,10 @@ static void cscfg_save_on_disable(struct cscfg_feature_csdev *feat_csdev)
> >   	unsigned long flags;
> >   	int i;
> > -	spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
> > +	raw_spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
> >   	for (i = 0; i < feat_csdev->nr_regs; i++)
> >   		cscfg_save_reg(&feat_csdev->regs_csdev[i]);
> > -	spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
> > +	raw_spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
> >   	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
> >   		feat_csdev->feat_desc->name, "save on disable");
> >   }
> > diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> > index 6ba013975741..b9ebc9fcfb7f 100644
> > --- a/drivers/hwtracing/coresight/coresight-config.h
> > +++ b/drivers/hwtracing/coresight/coresight-config.h
> > @@ -206,7 +206,7 @@ struct cscfg_feature_csdev {
> >   	const struct cscfg_feature_desc *feat_desc;
> >   	struct coresight_device *csdev;
> >   	struct list_head node;
> > -	spinlock_t *drv_spinlock;
> > +	raw_spinlock_t *drv_spinlock;
> >   	int nr_params;
> >   	struct cscfg_parameter_csdev *params_csdev;
> >   	int nr_regs;
>
> The changes above seems to be unrelated etm4x and not called for in the
> patch description. Is there any reason why this cannot be separated from
> etm4x changes ?
>
> Suzuki

This is change for cscfg_csdev_enable_active_config() function
which used in etm4x's enable path.
currently, the user of this function is only etm4x driver,
I've included these change in etm4x patch together
to solving the issue in etm4x driver.

Though it seems unrelated to solve the issue happening in etm4x,
I think it seems good to put together.

Any thought?

Thanks!

