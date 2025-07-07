Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97EB27E7EB
	for <linux-rt-devel@lists.linux.dev>; Mon,  7 Jul 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877281; cv=fail; b=Egv0/BwIX0rm9zPd0l9ITT8+vBoESZlesaoi57RTgre3ReAnWejofQFaJOUrJnfFI2GAAlU1yzQMf1NjOLi6XIgOij9lcoBAfsovmQr4wFl4rp1D799Jp+wUtlKot5XTuTwJYvjWasQb0wZfvLbC6XEomDrnU9qeaVd4DT8hVx0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877281; c=relaxed/simple;
	bh=A0sNCNaDU5n6HHkIrKDkAkFk0+J22JfRHVQ+PMooP+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mqNI6YzDZjeUZd6Uw6CmjezS8WBil2/YC92X+otNPzBzqbc56TqVrjtgI5ygtk6GukynsoIVORJLYEVw17ERCIDDpGEU3YMpwsVQhG+1SBd+wwkRTDZ2+F5bCM6JsQpsW2fMg3wzCrrBiVrjF2Jwiyq0jE8eauRi0nyzpFMC/BI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WDeGuSEN; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WDeGuSEN; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WDeGuSEN";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WDeGuSEN"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gcYHJV8BBk3r0wtvptH0MVrYksPSIvi3uO5GB/BdBIvtPqwDcSd/IsghV/l32jNTQ+0UUOeOmD7r/c1MkJBreeuK7QvM+vTxWMqiLQAIfQ8vouY3eF1EKgCVM1EYdOzKSZheIDitI1E+3vRRuhhPixUz3ZTyz+Geb7HCqboVyLtUM7lnAkoruLSMc7s1gYLXDBo86pr4urb1FPofhsJZblQWScsZn3E81rIHSsTd+VxGHEWDxbAtlUHKgKEP0p2vPFlwn2mjGjoPF0p1Was594tul+NXQKKaYb8HMZiaM3bk6FCeMC6JMKmMaKg9ZI0Z2LzpBNboyRFIsgt8lsMo/A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssftwK5bQGlZGYg93AoXopHKaQshVcgOQeY6/NtYMSQ=;
 b=hjdCJs6IYq0pI9x64ohSGhzEmQXWMkUoXiRcacxPl401k2WuCpXGvZ+Wu66o+u4J2IDa7MFnKbcar3zouI4Za8PYf9YppBO2t9OxRd9dJwmdsboHCxqXUlLktx7as44k2es1EQrNO16wsxmCwU6l2uII+MyujjqfIk2ZwZxJKW8ew3Y1DR3ZLRvbdlEF1FT9DLNa9tb2hW4YSrUIxyR3MS4Bm1cNjM4JH8xmQconOP3V5ZrwrZuUGqSIOPJPDb/OnAl3afo4F5xMA8UrfFj4Rp+PC1/Y57yeeLdmodvzezU2BdqF0vN5CCWATZCNo+K/z3n2qnUYL62qXvXCZ9BgOg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linutronix.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssftwK5bQGlZGYg93AoXopHKaQshVcgOQeY6/NtYMSQ=;
 b=WDeGuSEN4pNl2iP2MpZJZIyNMg1QH/moDx+sexjHyRESq2hM2WWYFYP8EukxmCmpZ5mPjdhZSUOuMemDCRdF5weGPKIMNDPiMJpPcpXhbGiihB0Ezq+34esCDw4wqDmEbiWvhYR51Wzb/YuFY2zDFulenCzLOFPVtkJkKio5LSs=
Received: from DUZPR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::6) by DBBPR08MB10793.eurprd08.prod.outlook.com
 (2603:10a6:10:53d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 08:34:32 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:3c2:cafe::d3) by DUZPR01CA0067.outlook.office365.com
 (2603:10a6:10:3c2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 08:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Mon, 7 Jul 2025 08:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq4pE4qyOZ5VpsildOcPuxiC6WX0brMcUhiAVHYKZa2hW8lnkVuytNfoR47SZvv07a5tmRn2/qCypZELXSa83A0yHwQCkdY1YkRt+Qs3LdU9jJCNaQofFcycxinRSvy8re0bTF2A9TlBMgRmzDgLyZJuWk4kffpGMTah8UJlfnJfbbPoZPqhojMFSaDm7loqxq7kRGPCH2GTrurTTH895Z6SNafckdgOIylLvr2SMmNzjt777KBXz+39SDHb2wkFGwINaDWQe52okhGjd1K2WWFxTnDhZtfEv4705srTuzK7ahzJXycEeOftYfWNAli9+Ase9glVTRay8g1FBVONdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssftwK5bQGlZGYg93AoXopHKaQshVcgOQeY6/NtYMSQ=;
 b=LNGd+hRObEYS+mSZLBaya+jpZEF7j3m4BOGR6jWHcGafktzJDUZ9j9jsRb4qmJFt2Dpy/OBHuHO+d+wLfLspsWRLVRov/6uWY3GVdRcUfFJ/Q0uL8a3KEy+Z0GPhJhNryUkk33wFs5zrmP9zRhvf9cCLjpoyGW3GiAay/+4yGq6OWOU6O1JuezCBNYr9i8gcluRnmK0Egt3CnA1u5MWhLfTS2pLEeT93cZlwxCwkEBAf5477wCDk1ee623cwRk1Oc5K6ci7WBdne1aqWwmqBtHjsIng53+i0QmC/n94OPERVgZslAmV9Us++a1nBp0Ty3pGVfr48xgyWmXA3gKtT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssftwK5bQGlZGYg93AoXopHKaQshVcgOQeY6/NtYMSQ=;
 b=WDeGuSEN4pNl2iP2MpZJZIyNMg1QH/moDx+sexjHyRESq2hM2WWYFYP8EukxmCmpZ5mPjdhZSUOuMemDCRdF5weGPKIMNDPiMJpPcpXhbGiihB0Ezq+34esCDw4wqDmEbiWvhYR51Wzb/YuFY2zDFulenCzLOFPVtkJkKio5LSs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DBBPR08MB10794.eurprd08.prod.outlook.com
 (2603:10a6:10:53d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 08:33:57 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 08:33:57 +0000
Date: Mon, 7 Jul 2025 09:33:54 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, akpm@linux-foundation.org,
	clrkwllms@kernel.org, rostedt@goodmis.org, byungchul@sk.com,
	max.byungchul.park@gmail.com, ysk@kzalloc.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-ID: <aGuGcnk+su95oV5J@e129823.arm.com>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <20250707083034.VXPTwRh2@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707083034.VXPTwRh2@linutronix.de>
X-ClientProxiedBy: LO4P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::14) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DBBPR08MB10794:EE_|DU6PEPF0000A7DD:EE_|DBBPR08MB10793:EE_
X-MS-Office365-Filtering-Correlation-Id: bb360e8c-a16e-4893-3624-08ddbd3118cd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?BvpDYM1RYWG85kx5UXncIPuYPQo2Q6ARTnX9baNkQ8P7HPlw+W0NIHAl3VuN?=
 =?us-ascii?Q?FdLCyQn+68oZyODxe6LZCtdjczCed7qOg/xORzWb+PzEmeaZuc3sKzg2ZCJ4?=
 =?us-ascii?Q?u9Iu69hCee8646VHodyTnbWZ85UZGAVLysYQCMPOD0ccFtqCeP1z6j2X4t2L?=
 =?us-ascii?Q?3+6uh46CyUjlTFB1TMYyFJzyUcKX3Bvbg5CagGBNps8kGQg8bqhyZ7joolW8?=
 =?us-ascii?Q?Qrj8w65oZrZaNi+oEBHospUQI3HLswaE/1IUCQxoAO2UDGyln/o3UOAiFZFC?=
 =?us-ascii?Q?A07hCYO5FhWSiSLmTXkicy2NGNClhQDhoXiZQ5enP+2yKH2apMGHEei1BYjk?=
 =?us-ascii?Q?+OoOTzXe5JUySl0VgLV2zb6eHh9tJu25J6/qpb0S5ditK9Ygb1SdqvIndLms?=
 =?us-ascii?Q?R//U3Zi8fgurlg/M3YdCPzxchgy0FsVpgQd3QuTI/kD6Fe8T4QvSYiJ7XZfL?=
 =?us-ascii?Q?9aPmt5DZUEvlLjwQ25DgrT37vbFuj0oQbtm6CAUYdwtweqLCpV1Wid9yrJAq?=
 =?us-ascii?Q?rL+gfGktOiVwHz/8PhrJ4i/qAZs9oWb7NRVYY+XGEaQlm30sX34YjSVH0POA?=
 =?us-ascii?Q?hJGuvN7SsyKpbLrU/X0hFlYApZlrVMPprYcxlmQcZAl+n/behOn9bAfa5emA?=
 =?us-ascii?Q?hUx8XeQxlVwHOow6+L6MuMjrJ9StBfPuhsFaOpePipYEHW3eR3Z1kSfAdRdi?=
 =?us-ascii?Q?zODFkNvRrdo7NHmnhw8lMlpcm1EloRQLaB/Mrutvdo/ptp8EIGkkDXVJhAkO?=
 =?us-ascii?Q?Xgr4R/D96PQV1Bd9SW2Cnn+2puXWhRMtifbfRFVamqYiCUBPqapk1674NZER?=
 =?us-ascii?Q?KHgCidzyH3nur02f3Atrmklu4F5risBUTrwVJG78t2NJzPGE08uYwH5nf0Zl?=
 =?us-ascii?Q?uSuToiObBWBhSvTY5Ww/JUFVAmGwPrlMNRM/ZPe21jqQ/gF2kT0AafW7NOFI?=
 =?us-ascii?Q?UL2WB+3abuuCuTxgtdkO+oB0tHBSo6oAHHw//vBNJ58cfs1oW/+riU5rLbpR?=
 =?us-ascii?Q?7RJ6iTb1HSLcTWxf6+nVHueTt5hprGSQvmw7BpHcF2igpPBmtqoFcXPBkFIv?=
 =?us-ascii?Q?zCzQ5unnnjdpZusBvK/olA/xbQc3eiBcUV6a8tpUEhMbMaNX6fFKXBSvWW52?=
 =?us-ascii?Q?NazdosrrW02hmax2TbNndEycM6OuccR2S6p8kQUcFK826u9iIWvq2e2ty92n?=
 =?us-ascii?Q?0GYAz6SRPaZ3Y4BidhcDRjVwRp7hlFisVuXGrtvpj0k8c2D1aDcG+a/0zLPw?=
 =?us-ascii?Q?33CLNM0Uz1hnMZ0wrXCXTdadNSZ6nO52YAtTjHVDy7GKXyXc/UXWMTHUilxx?=
 =?us-ascii?Q?mTLnSVqZAY8dTbq1F1Jd3FZWDpjnHH9OrO8UZAP0lniiF6dOB3nYz+VDQcsj?=
 =?us-ascii?Q?HSBP298doonXI8E9vP/BJgOuTNyd5zpW1WRFlW5K9iRXd4StpMoV7Cjg+EI5?=
 =?us-ascii?Q?4GbI7ckd9XM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10794
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	19d7a799-a576-48ef-9907-08ddbd3103a0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|7416014|376014|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXfs4xaGkd89vynuLuiqmDTE9kSRrib/L536+LlVPFhXqG5LPT3Vf+UbF441?=
 =?us-ascii?Q?xFL9XBmppLSdVI6sQdKj7cZlS6Qh96FHH2ejyCNT66ot+FR6Qek29i7htix9?=
 =?us-ascii?Q?CQJNma5tCVTIVaJXLzwzy5P0zGyE3oatU2qHQ1KOTUhCxkYXPQNI7huhJl7i?=
 =?us-ascii?Q?h+/14v/GSjKcD7N5WuguRbmTcyXCz5V0dVJiYu0eZWgx7W747FFnMYkYsUgj?=
 =?us-ascii?Q?8RlfDo/QfitzUsCxFx/OFMWaysDJJ7MjPXLovQkPwotquEN7EhthwR2KEMoE?=
 =?us-ascii?Q?2xXuC9CU5F5J9oyZm4ADn7NIB6hjfzhBzgPHAhqmidv8wB2PPD8PegFF8iQs?=
 =?us-ascii?Q?zjwtiRggGenxvaQiLy+rIW/KazwS3XWO5okSjBWDfa0bIH/29Mys3x7UW6Nf?=
 =?us-ascii?Q?0K2mGY1pmLkrx89tdBV0BD3t6wXB5/u0s2HTxkmpAB8/dI211x3pqX51kXsX?=
 =?us-ascii?Q?5YoI5rqpYh8pksqnuS/Fn+OGRtjIvymQ7n0wco2KfvC20n7MA2XmHbh0rcwg?=
 =?us-ascii?Q?15US1kcOqLBuvJGBKdfCpkGn+1gHrNsl5RZ52KhcbTJpD3lZ03l1SVEqP6Su?=
 =?us-ascii?Q?ZKPJ2YTHRTX62VIPPdjFfkBj7Hs9fJwutb1baOEtIPZjbS1z8kk3dIxSvClp?=
 =?us-ascii?Q?X2PT0XMNv6+nxJWS4w9daVMuv2WpZ7jho7rJQfuYKiWsBT24SJHjpwKCQkuA?=
 =?us-ascii?Q?BElKpB4x4Mao3D+apX53h+hw8eFfGpxQPR1B3ZMTBC/2A2KPkpVMtRlWNUJb?=
 =?us-ascii?Q?5RCWzxweX9KrVb9MQj368a6U2Ph8HfzFTy7ANDO36adUPY2YvRsFW2efLoNs?=
 =?us-ascii?Q?qgo+j6xJ8ckZb2gFwNU5ACyy7ysOLdb99EZkGkWdNi/QGJ6CFEHSK8ddZIjt?=
 =?us-ascii?Q?NS1efiSIhttvFXW5Gj2GHFXdUgsVY24lIzAp+ygzS16PdOC8tLEDtPLmShIj?=
 =?us-ascii?Q?dHS91w6wAkiiOADkue//zZ1yRPzhUVzqN25Syw/Q/5BPFH9LAEpdCituWkdC?=
 =?us-ascii?Q?JdxcSacR3D4s78KFup/fUJdxmA4SZZ0FSk5iFs3GjlelaFrvoJoZsteyvpIB?=
 =?us-ascii?Q?yS0Xo0xYjFdwgPXPaCyWcqnTbnlnyEhh2nwV/LI5FfgxYdoka/UD18XIn4bQ?=
 =?us-ascii?Q?skh9jqz10+8tp7hXEUSITigv1pBYtwxDU+B47qcLVn7ptLNpKKp28AHlVfCM?=
 =?us-ascii?Q?OY+BCnrBayPFLMiMWNP8F3nujPRv6reqwuczrmdHYDeyvV0vmEKCMDcLxSCY?=
 =?us-ascii?Q?lckBB8LN560UglWx4/jc6tOMHuzr0cdZtfOCMuF3B4gHqPYEU9dmFuqIKKJG?=
 =?us-ascii?Q?BcU3nasR9Bi6PFt77RGvOLVzsZC5LaA7G1WqsKYvX6fyV7A8/UClw77rSCNC?=
 =?us-ascii?Q?j8j9aCDe6uqNLzy4Vf3ICLwhOyBRecTHzTj0YiAwpCqI+jB36Xt2gPzkDT83?=
 =?us-ascii?Q?E58WbT8ojSX101f3MO+34+TRkf4AnJh/J1mLfqIZU2GMk0pm6ry6PUUDULpJ?=
 =?us-ascii?Q?5UhP0DBRyBPibViVDF3K2a7banBNVTyfsdr4InQYZFrbiHkwVhzpoFbNiQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(7416014)(376014)(14060799003)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:34:32.2626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb360e8c-a16e-4893-3624-08ddbd3118cd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10793

Hi Sebastian,

> what is DEPT?

Please check the below patchset:
  https://lore.kernel.org/all/20250519091826.19752-1-byungchul@sk.com/

Thanks!

--
Sincerely,
Yeoreum Yun
