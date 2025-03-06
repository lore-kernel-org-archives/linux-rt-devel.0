Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012026.outbound.protection.outlook.com [52.101.71.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94D204686
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Mar 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.26
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257334; cv=fail; b=WOJ7z6+WNgzbBCGS1wIitprdZVYZI9QZRcM9PNzn3jvzeYYHwn/W8ETZYVVko8NF8AnYgg/mE8Fl8JSRflaZeq3CXNaX9Pa8b9T5ARM05DlbkUWVCkfkC+i8tybqb9+gifcR1O22WubhtY7UR0xAuB9sq5+ifas3FLC1CkyOBU0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257334; c=relaxed/simple;
	bh=2cVQcEt4CeeQA/E63ZOtbO9VPEKyh+OHYUbfahS81bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nGRsJEjZDTni7k3xUs7q6YRfkUugh2u0H2EJ+4fOtUqG5OYdMahOVDwabr8Vc2TVxwZQHftleVZsRBGWGEdK51gWQfHtV859/zjnPWNFOUa3DFf09JMBbaVRoHCZSJEFOffgMbJItp+byT6IuBJAq5NTFcBepjlNEjEeZa1U+Us=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H2OTzfW6; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H2OTzfW6; arc=fail smtp.client-ip=52.101.71.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H2OTzfW6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H2OTzfW6"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LAEtoqhQ7XIvkqtaJy+fWNyyDAr5yy9kksMp9WByHxX3mhzCFeCh50KXUY3V2njlQKshUDkD3MYi7E/zkZ7dCcdehmDD+IgmB2YkCVz145Tiy1BrxeC8WexnoZiMj9g5IyxcTIyYRuuzEEb2xKlhBbpLewtFz5RQx28NuzKm/jk7vqMLrhL2RgFegYbCa9nv5evpxijp/B4xv6CdQ6wArMzpXKXTpjckQLpkxsQaFISnFTO4hMEo+kiubZX88DDADc7/zZ3DHgJNcs2KDmZRRKlz0rtQ/4yMo6pNH2MnP3yI0lQAeqxzNXrooHRWMobhJFfZbIZDrFUAgCGY0i5AYA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPJe6Osq95MOVshmgOKz9XrDLWuhm1aRSwm/8kZ5cRo=;
 b=urBm0W1PSEVJLH9zp5TTpFStuC9TBMWs5OHNmCHNdGQO7y3102xqSFImvpJTwRsJ+EpARb1MOfQelRBQSxMMX2ji1hdkCsH6KHjyQrPs28vbkkFWDNs1Ligo2z57eAsRNNT2ZrfMV0p4vkg7GD5xh/xdA0IIpULcGO87ZrFKqedU1bv5X8yeWt8yUyx+Y2EQmT71pcinI2CajXBomhySSmzw79Xo8x/YR0ROm6a14nUDUD9LI+3lvs4TrTdZaZJOVxgl8z7CJI5hZPl2s/nGYPm2Fen3M0SAF+nZps7jhb6mgrDfhveRpZVmqNAjBEjSphgvWgT9/1l/vmJoZoT84g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPJe6Osq95MOVshmgOKz9XrDLWuhm1aRSwm/8kZ5cRo=;
 b=H2OTzfW6Yy/Yq70LYzZA0VbVDZI2p1Ay30O28KLnEloYDXEhakM7zLGDNQ3uYhQJf33DGe+hlMw5vPrcU4FfP4GHBWBXjLc2CT/8O/qhzaD+yfVwNW36p2l/f2yFT6/LtrSp/2Bx+pURoiGRt61BshNUPIdpYpJslc4WCqUu8V0=
Received: from DU2PR04CA0077.eurprd04.prod.outlook.com (2603:10a6:10:232::22)
 by PA6PR08MB10622.eurprd08.prod.outlook.com (2603:10a6:102:3cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 10:35:26 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::85) by DU2PR04CA0077.outlook.office365.com
 (2603:10a6:10:232::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 10:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Thu, 6 Mar 2025 10:35:24 +0000
Received: ("Tessian outbound c3a902884497:v585"); Thu, 06 Mar 2025 10:35:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 52d7d0d3841115ae
X-TessianGatewayMetadata: FsjKr7BPJiUQdKOU8popGwcomoCvZt4anOO+WP/7wDcmjUwsaW6UG8AP3PkKwu+a2JDEV+U/kQdBRhxYh4P4vAFNGk6w2JtN0nps9GcTEdH3CfLy9B0C+slEqCbHYngrTCQF5HQO8vzgE29zv0fcrg==
X-CR-MTA-TID: 64aa7808
Received: from Le1a992173cb8.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 24FDB75F-50D2-464D-8208-2B8554DB5D2F.1;
	Thu, 06 Mar 2025 10:35:13 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le1a992173cb8.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 06 Mar 2025 10:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCmtMxrkolc45Ahf9V2v0BBREEOzy7TZBA0Dz6yoRhLHJDskrLBIzT0MM9NIs18y9tkFSHCtAFTEpf/7kGqt0MFH7lx4+auq4J5hCIOOXpW81tZFXvUONLZlvwR/HSnqeQ2vqrT4DZ1+uCPiWOCa8esfYbhoe535aRXP3YwyKPwaUW2qE8ojC/2vJq1KhnAkALLBf7JO35qaGdX9pEBGSyDHzntmvdugzu2ZTCVLmaZ80aIEic8Sp+nXNXDnWQ2HmYbGHSjzY0Z1Kfdqyc6FeHtGX+H2ull9dNSNysFvMR3vlBPywsZ3UKeKUx2n6zXBSlFZuB883CDWRt+rGza8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPJe6Osq95MOVshmgOKz9XrDLWuhm1aRSwm/8kZ5cRo=;
 b=vGwChTAjhPTDPvKx6i5zj87t2Dh0GaoM38D9o0v7bJ3vtp3OPL7f8O/oSqpF3kCjvra4x3R5//v/dLUVxJI1ehclmou18ZXMCZPl4b+BGIUNYZ0n9XgMY5r69b3fenrQem4Oz+YMiRkgjTsW+ft5VeHsXIIbX6WyBz+hPX4V8Pqdxngvi5LGvkxoS5RtuWvvFVBUyR6ajOXQYFRH2y/jshmJmSncgtrBcdS0NspIvJzWO+P7H/gWMsBUCa4KKsstscXgt41DxiMmdwy3rWZS6xNMlvgb7UgazE2viGKZb5r+LlRAOdb9893e8SIorHp6ALVw85PQKOCbwh1qOBGr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPJe6Osq95MOVshmgOKz9XrDLWuhm1aRSwm/8kZ5cRo=;
 b=H2OTzfW6Yy/Yq70LYzZA0VbVDZI2p1Ay30O28KLnEloYDXEhakM7zLGDNQ3uYhQJf33DGe+hlMw5vPrcU4FfP4GHBWBXjLc2CT/8O/qhzaD+yfVwNW36p2l/f2yFT6/LtrSp/2Bx+pURoiGRt61BshNUPIdpYpJslc4WCqUu8V0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB7944.eurprd08.prod.outlook.com
 (2603:10a6:20b:541::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 10:35:10 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 10:35:09 +0000
Date: Thu, 6 Mar 2025 10:35:07 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: mike.leach@linaro.org, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 8/9] coresight-tmc: change tmc_drvdata spinlock's type
 to raw_spinlock_t
Message-ID: <Z8l6W8KtWkA5kS0s@e129823.arm.com>
References: <20250306094800.1082950-1-yeoreum.yun@arm.com>
 <20250306094800.1082950-9-yeoreum.yun@arm.com>
 <c7a142ee-d34f-494a-b4f9-921d739aeb59@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7a142ee-d34f-494a-b4f9-921d739aeb59@arm.com>
X-ClientProxiedBy: LO2P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::36) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB7944:EE_|DB5PEPF00014B89:EE_|PA6PR08MB10622:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd147c7-e823-4459-9616-08dd5c9a9aa4
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?K3JncWswb2xoRkNpaW1EdVdraW5HTHRiNFZ2YWUyeUVOOEt0NVRZbTFRdEZO?=
 =?utf-8?B?bGxjV1JFZTZtVEhYbTRaRHdUdWZtM3U3NnU5b2MwZm4xdEVTWmhXdjR1VEZx?=
 =?utf-8?B?bFVYUitPWW9weUNSbjlYNDFESFFSeElBdFpub25LNXZ0RlVRby9FcmxiRGxI?=
 =?utf-8?B?N0pWSGRjaFlxdDA4Q0hSRHBtRk1zM1FzWFN5K1VEV1M2TlZEd1J1dGcvRVh6?=
 =?utf-8?B?TzlvYkhEOHdDcnRLTEM5cXU1K3dmeGVyUVErNkQ5SmFRQnRPRVRienUzcXFR?=
 =?utf-8?B?cTY3cU5SQWU4c2pBM1NoSFd5THRBS1Uzd20vVS90dERBMGdleUVuYit5UHlG?=
 =?utf-8?B?U1hBMkFoeXgwVlBDMkNaSlpNSjBiUVk2dDBsTENKRlcxT2FwVkRKSlV4SEw0?=
 =?utf-8?B?ZGkwTUxVRFZKWVRtQUdwaFE0QUtwR1FtTFVnei9CODlTWWJqNkVZNUh1K3Rq?=
 =?utf-8?B?K1VESGVVWlRNem53NnZMaHByZlEwR3YxVEh4dll1RnNXTWRqdDdBSDIwV2Jm?=
 =?utf-8?B?NnZCbmlaSE54a2RBZnJwOGZIVVNDTmRmbjUyWjUyYklPK0pjSFhER3RWT0xC?=
 =?utf-8?B?WHkxMFBhclNiSG54MkZuU0ZCcmZzRnhpTDJ5a0s2aUF3THlyb0NBOWkxZlFn?=
 =?utf-8?B?Q2lhbm1hOXlpL21JQm00ZndpSTB1L0N4Rys2RmZuQWxsUE5LdU9OZXdnVlEz?=
 =?utf-8?B?UWNyMDRPMGpYOVFHcnBGWHVkRXNPTk5vb3hWM2hMa0tzTEt4Z2NLNDlBZ0lD?=
 =?utf-8?B?ekgzK1l3bEtHbVB2Zkg5bDVwczVnMEY0eDVaL0U0K1FCaW9DKzhONFB4d0Za?=
 =?utf-8?B?anVmQ25FVXNMRXlST2k0SDI0SXRDWkZEamNUUWwxdHAyOVVyeStNZm5JYXdK?=
 =?utf-8?B?MnBxUzZsRDhEYlliRFRMa3RhSGtaQW8yNEVPTDRtOWVtdzN1NTFLSDk3eVJl?=
 =?utf-8?B?Q0NxcEhsZ2FCWi9nVStEaldKbDRrc2dDWTZHWXFzT05neUJNa0Y0K29HV1pZ?=
 =?utf-8?B?R1BnRkpoQzM1ZWo4Vkh2UXAraVgyUXJsZTVvL3A5RHpObW1BU29IejFrTVN6?=
 =?utf-8?B?TU1Nbjkwa3ViY0t5K09GSlhKZHljS0ZpWG52amhHMVlkM2lWUmFvREMrUU5h?=
 =?utf-8?B?cC9yZFpOT2djRHRTUjN1UytaZCt0RlBTWERNNEttd09mK0ZMcGxpUzNIS0pm?=
 =?utf-8?B?Y3VrUnVXOHJwb0pDdHZvbFZYaUNhNnM3aDgwNU1Ya3A1cjV0cXFYRzROSGsx?=
 =?utf-8?B?UGxlSzZLcEcvMGNDZC8xczYvcEJXWkk4eUlyUG8zR0QzbzQ5YVRPMXNjNEd4?=
 =?utf-8?B?WE9BMFNiSWpJSCtzZlZxVHhhOXRZMFRjNGh1b05SdElHTzRNSVdyTjFnT2Q3?=
 =?utf-8?B?ZUYxMWNsUk5yM1E0WVRBa1J5WCtMSjVnMUJUMjJwNG5lT1VTbjMyRE40VUlF?=
 =?utf-8?B?NkxmK3daOVdYV0pNQXZyYndtMHFMVi8vR0VZck5PeHpocGdmdFl1UDlrSUpP?=
 =?utf-8?B?bi9XWTdRdDNPSExWaVdhNGxiY3lwYWxiVXU3OXpnMlVaSFZNNXk1ZVdlQzEx?=
 =?utf-8?B?OG1SVE5rbmNtdVMrZzloajhjSkZEQnljRXh4MkFnMGpscmxJN1VWT29SWG1L?=
 =?utf-8?B?Z3M4LzRRYTM0SEpGUTBBVGM3YkU2bWEyVjErYkUyZk5IZGRzM0NFTHBETG93?=
 =?utf-8?B?bUprdGg5bldyMjBoVm4wN2VpWVJUMG4rUXAvTC9SRllBZ21FNDJZL0poanYv?=
 =?utf-8?B?SDlWeVVUa2d0cTJDSWV0OE1UR0NZd1dnQWdXRXNDZ2hTRDUrR0dHMmZncnNh?=
 =?utf-8?B?SXp6VFg3aVR0Vml6K0VLcytDUWZRZEl2ZmpzTnc0RXRkVEFYZFQ4WTdUNlNE?=
 =?utf-8?Q?LFg8Em8k5XsDd?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7944
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1ff5f264-ece9-466e-3155-08dd5c9a91c7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|35042699022|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S293aHliNjFkNzd4UEE2bDVNN3RiWlZjS1VYYUNub0xVVFVLSUpaNUdIcU1i?=
 =?utf-8?B?d2ppT1MzM21YaTM1dVh6Z2dLWDhkMW1IdFh2cDJ0a0R2dzNuRmxkcldybVV6?=
 =?utf-8?B?Z2hFakhFajFrTHg1NlAzYU1jaVVDZElKSDYxWEw1bUpFTjZpQ2VHSVFkY1JD?=
 =?utf-8?B?M0JsZG81YzRlMVZla1NRZU54NEhBVjhCRG84eUplRG5CRk1yRkFxeTFMeC9h?=
 =?utf-8?B?YnhmYkxRYTNoR1Bnczd1MnlVZ2ZuS3ZvSEk4WWtoV2VmS1ZpbXNNR3dTRFVC?=
 =?utf-8?B?bzAzNmU2K2RSUEo3Qk5XM2ROcWFlWmZyRHh5QnZVQXV6d2RxTlpiWXNGdFN3?=
 =?utf-8?B?VFNTL2R3N0w1M2Jyd1RZZTBIYmc4Vy9IRGdqOHU5emtlMnBNOCtPVmluSUxk?=
 =?utf-8?B?dEorcVpsZWh4U1JYbUtGUUU5ZWgrS1ZoVTE5Q0puN3ZTTVRkZnBJanRZTFRo?=
 =?utf-8?B?RnlHYXhlSDVPOC9vWEU2YmRhVi8yR2NQMmtDY1hkbXJmUlJ2UjM5ZDQ1c3lH?=
 =?utf-8?B?TnV6d3hzWko2cVhaUmcySkdOSVV0UnR3VHNYTkFrNFFhUXRTY2w5MS9vMmgz?=
 =?utf-8?B?VTh3R1FtMXAyaEUyWEZyQTBpK1ZrVGpiQTcyTDU1WHhSZVVGVlVYV0VlMjNo?=
 =?utf-8?B?cTZ2emxlMTVCcFY3TDRDcEtURnF1TmhWUkgvc1Nnc3ZpOE9pTmJHSm5YanF1?=
 =?utf-8?B?SlpUREtIc21nd3BOWFF1RGI3eE1lNStHUUtGb1BGQzdsbm52R3VRQ1NhYnpY?=
 =?utf-8?B?OEdwbXU5VXdwaUxhd3NWNUNkOWhoYW9Tc3RyTmRQT0dQdjcyM1pERmlmVlFV?=
 =?utf-8?B?Nm5lMDdMeDd4d2J1YUFCQmVvenp4UG9NOThnVU4rbFZjVDdkV0p6bFY3bDli?=
 =?utf-8?B?cE1uT2dsQ09JVGJETnh6RHJQcDZYRysxVWhaRk9XZEJ1RTRwK1d5anlmak5p?=
 =?utf-8?B?T2RhenVsWkZybk9MU2dXVXgvUWtJbjFkZDJmRHN5VVFJUkVUanNCZUdYMkd5?=
 =?utf-8?B?alcySGlZbEVuMW9teW1BT3ZJSm5Ic3FRREZJc2xvSXJCcjJtMWdUTjk4SWc5?=
 =?utf-8?B?bUMveXVWV3RUQWNnUHZhTlcxQUl2MFgzUDI4dHdGVGQxRVBDVDVqQ0VrZlpF?=
 =?utf-8?B?amx1aFpNR1RQcGg1VjRiQWpreHhiTzRueUpFZ2JaWW5vWTBzSkFsT2g4cnVD?=
 =?utf-8?B?SU1vakZMbUgyNFpvVE1jY0J1czlhZnlCa1hIVi9aMFREK0dWaG9XbURPREx6?=
 =?utf-8?B?Sy9MZzJYcmJIejg1QlpxbHFPd0lkMDlxRmFVSjdGQVJJM3k0M041TUluUnVw?=
 =?utf-8?B?alFLSWlhNy9XUG5mUDlTaEc1NzNEL1dhYTFMcGt3UTZZNWd5TVdjL3N5WERG?=
 =?utf-8?B?VEZJNU1JOElpSHlPazlPcWtlVFkzVGdCcXI4YlprUVBCYzhUK3RoQmFLK2h4?=
 =?utf-8?B?Q1hSU1RQa0VCMXk4L1NtS1BaOElUMzFnaHJyYXpzaU5Mb21ncm5KaUpSNG5B?=
 =?utf-8?B?K1dVUTRjRnhETUdCLzhBaytxMmZXdEUwMmpmSExZUFRBdHk3WVZkampuMDZE?=
 =?utf-8?B?TEFaNDhPQUFRbGdGMXorN1EvQ0d0alBGKzZhdm9BQ0Z3VDJJd3oyR0NLaEN6?=
 =?utf-8?B?WW5abEsvN0ZHYWoxY3E1VUY3RFNlMnI1TWw1bTJIeFRqYmFzSmV0MUN0anBF?=
 =?utf-8?B?T0ExR3Yyd2NZNHdjNmFaOXkvQzN4dVVaRHNqNkozQVc1Vng5MFhPNGRZU1BU?=
 =?utf-8?B?UkNTUEJIa21GMkNUMTVZT29OZTNVRzZCMWFTaDFIY2Nyak1jZGFCZGxKNmdx?=
 =?utf-8?B?ZTZhMERidWFYdC80U29jRWVRYjQ2VGZtbHpvajhjQnlQZy9TbVg0NmprbVox?=
 =?utf-8?B?akFhZDdwTTJXSWlmMmtzSnh6bFRhY1JaY3BNUHRSUmtER3dFVkdFVzVMa3E1?=
 =?utf-8?B?TlhaSHlYNWE2bGkxUHJpZ3E4K09nc1d4Q205bVRzWXB0UkUwZWtReDNTdGZz?=
 =?utf-8?Q?MZ/YN7vlDrGuKZN6gLO0+ysc+RbOR8=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(35042699022)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:35:24.5675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd147c7-e823-4459-9616-08dd5c9a9aa4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10622

Hi, Suzuki

> Unfortunately, this still doesn't cover the current coresight next branch. I
> get build errors as below :
>
> "[PATCH] coresight-tmc: change tmc_drvdata spinlock's type to" has style
> problems, please review. This is because, we merged the coresight panic
> trace support in the coresight next, on 21st Feb.
>
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>   CALL    scripts/checksyscalls.sh
>   CC [M]  drivers/hwtracing/coresight/coresight-tmc-core.o
>   CC [M]  drivers/hwtracing/coresight/coresight-tmc-etf.o
>   CC [M]  drivers/hwtracing/coresight/coresight-tmc-etr.o
>   CC [M]  drivers/hwtracing/coresight/coresight-catu.o
> In file included from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/slab.h:16,
>                  from ./include/linux/resource_ext.h:11,
>                  from ./include/linux/acpi.h:13,
>                  from drivers/hwtracing/coresight/coresight-tmc-core.c:7:
> drivers/hwtracing/coresight/coresight-tmc-core.c: In function
> ‘tmc_crashdata_open’:
> drivers/hwtracing/coresight/coresight-tmc-core.c:361:20: error: passing
> argument 1 of ‘spinlock_check’ from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>   361 |  spin_lock_irqsave(&drvdata->spinlock, flags);
>       |                    ^~~~~~~~~~~~~~~~~~
>       |                    |
>       |                    raw_spinlock_t * {aka struct raw_spinlock *}
> ./include/linux/spinlock.h:244:34: note: in definition of macro
> ‘raw_spin_lock_irqsave’
>   244 |   flags = _raw_spin_lock_irqsave(lock); \
>       |                                  ^~~~
> drivers/hwtracing/coresight/coresight-tmc-core.c:361:2: note: in expansion
> of macro ‘spin_lock_irqsave’
>   361 |  spin_lock_irqsave(&drvdata->spinlock, flags);
>       |  ^~~~~~~~~~~~~~~~~
> In file included from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/slab.h:16,
>                  from ./include/linux/resource_ext.h:11,
>                  from ./include/linux/acpi.h:13,
>                  from drivers/hwtracing/coresight/coresight-tmc-core.c:7:
> ./include/linux/spinlock.h:324:67: note: expected ‘spinlock_t *’ {aka
> ‘struct spinlock *’} but argument is of type ‘raw_spinlock_t *’ {aka ‘struct
> raw_spinlock *’}
>   324 | static __always_inline raw_spinlock_t *spinlock_check(spinlock_t
> *lock)

Sorry! I'll rework again for this. thanks!

