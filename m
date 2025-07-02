Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E45277CBE
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Jul 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472330; cv=fail; b=P3FK6TYSg/oKJUDpZdu4eqPrAB1z7fV6gcUKet8cZtKlIJIbXsKlbexgZ3gaiO3rKuT4B8OkJQSli6tcwL3qEp8DtGSxE7qwWobtHxaCK98HyNqN5GbKtgLiU3npjVZahmNi3w9POuxJjA6h/OZFElt9nv93NyBMhFY9OWa0mbs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472330; c=relaxed/simple;
	bh=SIy6LWyf99IAK2vRzQUK23NSjakqcPG+Zamp4GatPHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BG8CuUNL76FZY8TEU7joSjFBopDxNPh25/67TchYubJhqmDCBg22zldBJ77wioHMaQ4WtqVy8QpH48Bgo1jOONFC7rT62p2ncj0k93F+dSS/Lz6O9YJS+GfbfsBV0SeYA55jBeFI7SpdIc4WfWdzwZhF7LwVILgUcDCMmKExHbg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lhWWobyM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lhWWobyM; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lhWWobyM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lhWWobyM"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=i6k3kjRafHN7ratnEM5ga3dN9NgDcfabAQMYCdvyGMl9zoklLt7CsL1hDJ0+VtGFn6ub1W8lV91Q6sPMya7Am/3inQ0lodR674ycP6VLl1CM9wTYaNmWQM8hiLdGxR4uFsB8HTXhf5FAAwwpzV6DavWKsPoA6C/dMTw73k0lV5zBl7NXJkmWGrveRka5TvsazeDK7eOXo9Zjgem7TR6EF6KsfvPlWBZXkfXZAdt02ZGC7Mi3rl668+Fa0SjHU1ffUzTlTM4AizLcevemeQaA3nUfuN5zBwTuczEKuAbBN8zElMhLG7Oviqm90SyTXZ6iTZFWokZqcmnvjks7T7UUOw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd0LN4d76BfimfewCr+2SSbA5uUsl+ULDX/iasFx/50=;
 b=VmjNteDw2hxoYL/9WFFT91ycBMtw0jD8MO+h+IzLsZ7QaNO3BH+DpA/gJbSJnt/UlzMGGFnTAmjkoXoKwEVSUbXzFVK93paCt5ZE+/DrSzvptNdovCXx0+Sxnjm423Sq4Rii8xYMTIXZSmy0B+0d2aMX8+cHIJkovH9am/LpTBaTwUpX59QQZzNrtL0IHog4U2HYqnqrtc9YudwjCfUlc7Gc2569foKtNT5v9O5Gh36qnOP+SxudAJZOZN/ipZuFnW2I22RYYCLi4xTQLwVCqgWgzmGL7/lM+0DwsyqV593hpyB3ZuGHbMayZtovGDzf7gc+ZXseK/dFycp9hySSOA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd0LN4d76BfimfewCr+2SSbA5uUsl+ULDX/iasFx/50=;
 b=lhWWobyMv6N1rgVFigcbnejdbj0GCygAH1gKkHngM+Dm/tf6PHtjPchCT60+WUafFuNOCP606UuMPs6uIMdy3frvqINs2ezaLdkjjwpSqQGPtL2a/wu/t4PmvrXD9LsHeXUf95DPfGh8GdMj5RPOqMYbmt55rdyW+/pHzas/HIs=
Received: from DU2P251CA0003.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::13)
 by AS8PR08MB8734.eurprd08.prod.outlook.com (2603:10a6:20b:564::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 16:05:24 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::f8) by DU2P251CA0003.outlook.office365.com
 (2603:10a6:10:230::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Wed,
 2 Jul 2025 16:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Wed, 2 Jul 2025 16:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR9wqnZ4tMuqnXEzyn9/Nl+FSsimlXtQ0yLgJR4s6OHoLQJPSXGlefIFrLL7fmGrvfY1j52hsW+IJ7U7VisCZoZ1lJIey0mpwxXtGAI5H4K/eLvb+DRC0sbCjhtXq28cT43pmsbtHEY2S0BiXOqHkItA1yHG7/NpUgMNxo2CNUZZ1YS3caqMbm5RizIK0fPMGM+Q81TKAWYonfZrm7pwiUGqBB2XGzyZAJzqlAb5+2q8fqKgFGF12LVSAmTPOS60110yXeff+MGMd+rTXi2uIRdMiVKAgIcT2AFXdXCYEC3p386pbOlkVcAK015qQCIrxvo7v+22xuO1t9zV+N5QRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd0LN4d76BfimfewCr+2SSbA5uUsl+ULDX/iasFx/50=;
 b=PXa+xpFyZuOe7GMwO++SFf/VGDHY0CFHCLBeG+16Gpgu3S4RWvisqYnaKCgsqy35qyD+RTJU6Y0FZc8Zvr0HSOkpXJWBuoTJRpigFvNZ3V0EOce1Xazr/3TsiKQEZNllUaRbC0S/NieFqgxcYWh4LueY2/P4IRgd7PRYt2o8OazR6yiqd49j42yVzWPQlf6VO0aWVTT5E1TjFkSKwEWxIO1LPvHUEt/LVLhlZke9gdi8GYetCZfVKWCmiH/C3O3og1vQ+R4fj3zQvhioFXXmUpnD1mQj9BHaQtTfOcNzSJ++gyMkvpkluDqwelyKjQK2dK8V1/ul9a/2jjrxF8dmNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd0LN4d76BfimfewCr+2SSbA5uUsl+ULDX/iasFx/50=;
 b=lhWWobyMv6N1rgVFigcbnejdbj0GCygAH1gKkHngM+Dm/tf6PHtjPchCT60+WUafFuNOCP606UuMPs6uIMdy3frvqINs2ezaLdkjjwpSqQGPtL2a/wu/t4PmvrXD9LsHeXUf95DPfGh8GdMj5RPOqMYbmt55rdyW+/pHzas/HIs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 16:04:51 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 16:04:51 +0000
Date: Wed, 2 Jul 2025 17:04:48 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, akpm@linux-foundation.org,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	byungchul@sk.com, max.byungchul.park@gmail.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Yunseong Kim <ysk@kzalloc.com>
Subject: Re: [PATCH] kasan: don't call find_vm_area() in in_interrupt() for
 possible deadlock
Message-ID: <aGVYoEueYjoC1hQh@e129823.arm.com>
References: <20250701203545.216719-1-yeoreum.yun@arm.com>
 <4599f645-f79c-4cce-b686-494428bb9e2a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4599f645-f79c-4cce-b686-494428bb9e2a@gmail.com>
X-ClientProxiedBy: LO6P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::8) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU2PR08MB10015:EE_|DB5PEPF00014B8D:EE_|AS8PR08MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2232ac-cbf8-418f-1c45-08ddb98240a9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?mxJOFFoUpaiH0+gEhPOjVxZLD9N16j3Gyy5sbhS88NQfKUQBN2DZ81zbcWtv?=
 =?us-ascii?Q?e6U3OthCPByhRRvaJRhugwzQR+7COWrTGWgzA5vXWh6C+9cFwQJcKLNVZKgG?=
 =?us-ascii?Q?gcvwhO9KqtfgwR0vcq0FGn458Oxjj8X7j5bqrOj9tZlzXyE+3ZnMAn1KjMMS?=
 =?us-ascii?Q?lqikCvOclBwqZ8Q1qwDkhtQObsaTu/EqQvMsrRYdZAsA5Bx7isOdIb7/Sm2B?=
 =?us-ascii?Q?AUjYEjmMc6UvrvGbH8xlnZCVKrj8TjY8lIOsG4hHt23MrSe2ukZRq+g0RZFd?=
 =?us-ascii?Q?2cSXpfUbZfB7/MGj2TnO+KZs0EVwLjLeGjpwZtfBRVYBB0HNCpLDgxNt0uUI?=
 =?us-ascii?Q?yGugdg0k4Y1vp/3e5Nh4+YfNQrUKWas9Dh8ZyuXftuSwlv50tRS+8BkSEHSj?=
 =?us-ascii?Q?Fb326GgrBBbT5tsLl5xJrH0uz6zX7HUL7csCGfsq8dh1iJSOh4jfCLMpMJUM?=
 =?us-ascii?Q?n4uKQALldfO8u15rHSAWJ872hNsNSi2nwSCJzQXvRkmNwqsJ485uL3j6e+fc?=
 =?us-ascii?Q?LwUkttoaG8CxI9XnF9fws/MREYnAjUrMceYRsT2nEF4vG/lh8YrP7suIaUNC?=
 =?us-ascii?Q?kUwwXNel6PTaay3J1GJzFt4WE1RrMoztJPHX5XxjDpk1qOYGo9uMFsj2ienj?=
 =?us-ascii?Q?DCUlEKkJiBvNEtZ+9OlEJFsJZcVQ2umyrlhgJZb5yFfRluGLp/u/3iCziT3m?=
 =?us-ascii?Q?NWD9kjKtpNmpevSOrwdfM43D2ZP/tDSu+YjVmus+R0lD9VMiMqIzeKGA0B5t?=
 =?us-ascii?Q?vUn8PU1s5+iAEtK0ktQmAiQHMYCSnHC2thE6HmEfXIRLSMDUgJ8zSxnwiRvQ?=
 =?us-ascii?Q?zCwNiIGdSDgl8bhNAekWqemBmMRYkDFVlixljvHbZKVk0zQ9irSGl/hJhOHi?=
 =?us-ascii?Q?fm6iKXlkBLp7L17x51RUuYzI7+LRT0zPFgnUO0ial9bezmxYXzCiuvTCnU/F?=
 =?us-ascii?Q?AoMVz1IPT4JNm0gyVvS1s7c1M8tPpvmi/9H9ilz7ub7BXDU8R0T7IFKUyd6O?=
 =?us-ascii?Q?2E3JRV3IJIlJg+9LQeeMor1P2vc6ncaHW/Z6cTEyUGYIMV7TGbV56LqIoH+Y?=
 =?us-ascii?Q?j4VSFkLHj/QosyX0Cn7U8zrTUb+YPCKEE5c52nVHk30ZwjU2f4QQkgbbgZpR?=
 =?us-ascii?Q?Si+TtElxFiiv1/AUiN8zyKh5lr68i0UJGhM0HdjOc4ts++ZtxGAraPIctx69?=
 =?us-ascii?Q?vtZo64raML/suz7oJvFhn/L+iz9DOiylkgULSz7dlHN26/5KLwMNhf24C2ur?=
 =?us-ascii?Q?E5goU2CSV6VfjEz452kt9KlJ4Wt7maCZrajLN7FCo4H029wtYiqCk2hBYb6k?=
 =?us-ascii?Q?2reWJuRhCVWqcVCYlI1ihkLHHKPha6vZgtHgZ5lVWBKfrdIYwVTrNlhkbwQM?=
 =?us-ascii?Q?74Ce/q2llL7FKYqhiHhwqUnWmTTe8HHQHPle2ZxAQGQFmEqRUPi1UwAiSyho?=
 =?us-ascii?Q?5dc4QIvUL0U=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	975ee4ef-1a50-4fef-f05c-08ddb9822d14
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|14060799003|376014|7416014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7/Dl+0HiEo+vPnpnLAWaudZnccKWR7p91c02fFU3Ujo8Dm6UDYn2lNa4KoqG?=
 =?us-ascii?Q?9offP250V4xlLsa0Cd5IPsC+/s7jNEQgBL97xv80JlMewCcxEPLGwuelQZ0d?=
 =?us-ascii?Q?OXCgGJ/GCl6NI0H17K4+FkJJ9NVgg/Yq5ZcRD8rPFOR32RvtKxoDOFw+cnOx?=
 =?us-ascii?Q?3JM5eiHdpxFXBjKTSaJL6kO0mRZWm18Fkax7z9fRLN0jHzQQGyrQyXoQFFGG?=
 =?us-ascii?Q?YGQmCcsBDABXGBaed8cr260+jA6T5f2hNIVZU3TYiwWNthX6KnlLRQ91N/my?=
 =?us-ascii?Q?YV7C0zdKxf9SHP7SvNLveO2pS193jZiXRvnx9m/D+eWmD4c54qesV/3MlPGu?=
 =?us-ascii?Q?0QeyJeZvKBZjCvh3SlWflrXnxhgw6od19UbevZ2rJKrvRRcP+t6Fib8uqacJ?=
 =?us-ascii?Q?kUCWJeHPFOqxQEUepq9TdwKDM80AFrRg31SkezH+yZOU32jNn8W+KrebpmIb?=
 =?us-ascii?Q?CNYwOdvCBFkIBhERBEtAqVWUKDVkWSCsNXWLgx5LsVrbkFk/gxENwHSRtcv8?=
 =?us-ascii?Q?QprAe4gy38OcAGVIb7QJdd8vc/JZ/lcCfW8P8VWtql1O+KtlHd651ZsZvT/7?=
 =?us-ascii?Q?xS26O6cg839DkXJl7+0tiPaL73Yar5RyahestDq6jvX10sN//Tq/diWjcCag?=
 =?us-ascii?Q?96u4OV1NhV1MYPvXNMM1Cf15MRSBWLz6MnL7W7bJcYjeYZZq8srgNeex7gLY?=
 =?us-ascii?Q?Ddl87vTIHuqGCcz7hVvG7PCvbokn/S1K18fLq6gHH4Ng20ZOUOgV9IU9198D?=
 =?us-ascii?Q?PN1YPeAEpDA+8IXLsvo3A+puWfpiokejA9e1iEh7oJbj/XdM98aZxyCziwUI?=
 =?us-ascii?Q?UOCdO8KZTSXqFrSg1+Y7XNhBCZyGPey8hFk+Tt/Qk1KPQz8pGRzEX851wJ4z?=
 =?us-ascii?Q?5WAOBp9VHN02tzA9fbVhx06WLv0wxvK9isCkHUOCbQc3RPUFK7AWz99CRPhK?=
 =?us-ascii?Q?slqziZmNxzMF9IWz8et//M4IN6/vpwbJMO5umq7EdnE5sMQVqGqXmHkGYrCM?=
 =?us-ascii?Q?HwDGUHFsTIWeN9tR8XFrOU7g5P5MtV13mCJFlBc9LmcqLpY+wmDaGE7iZFLJ?=
 =?us-ascii?Q?umfvrgnReUV2vAzrKoOFZVUavJqlvw05uliylk++xKOb20Dm6UM2ixL+Y3tZ?=
 =?us-ascii?Q?MmMumEv/YurD0MmGWC8t+yjhNPlgdfFVY2kiuV4B6og6DLFn1CJjRntAA/7B?=
 =?us-ascii?Q?zr7N8iy4kLY25XS31jrnnqf97Df8QpSsPaL6v5aMjCVKQuQY5vckvuaBLEQs?=
 =?us-ascii?Q?/0K4ZFGSndRVBgDcgeVs/g6dMLp0dyVA2IRTyNUVvHO70xI87DNaJ8R8WKa8?=
 =?us-ascii?Q?RUdNj/m8woseuLZBnuLdoGaKprZwOvGKzbdLsp30J+2fPtxHIMgx0qpfh6mL?=
 =?us-ascii?Q?taMn50za8N8rJBvz2M+KzsHvlaDN0K3P/y+7V1g8kW8uNiUEIK9kEZ1CR2SM?=
 =?us-ascii?Q?89FDNByzpyBgUDAhEK3H4hGPVmwf0otH3gTLR4CFWKjoJHYNkWF6Ig2StMty?=
 =?us-ascii?Q?LCIi0FKwMcTZW1USuvAwcWtSNDBHcD/Lams5?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(14060799003)(376014)(7416014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 16:05:23.7228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2232ac-cbf8-418f-1c45-08ddb98240a9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8734

Hi Andrey,

>
> FYI some of email addresses in CC look corrupted, e.g. "kpm@linux-foundation.org", "nd@arm.com"

Sorry and Thanks to let me know :)

>
> > In below senario, kasan causes deadlock while reporting vm area informaion:
> >
> > CPU0                                CPU1
> > vmalloc();
> >  alloc_vmap_area();
> >   spin_lock(&vn->busy.lock)
> >                                     spin_lock_bh(&some_lock);
> >    <interrupt occurs>
> >    <in softirq>
> >    spin_lock(&some_lock);
> >                                     <access invalid address>
> >                                     kasan_report();
> >                                      print_report();
> >                                       print_address_description();
> >                                        kasan_find_vm_area();
> >                                         find_vm_area();
> >                                          spin_lock(&vn->busy.lock) // deadlock!
> >
> ...
>
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 8357e1a33699..61c590e8005e 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -387,7 +387,7 @@ static inline struct vm_struct *kasan_find_vm_area(void *addr)
> >  	static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
> >  	struct vm_struct *va;
> >
> > -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) || in_interrupt())
>
> in_interrupt() returns true if BH disabled, so this indeed should avoid the deadlock.
> However, it seems we have similar problem with 'spin_lock_irq[save](&some_lock)' case and
> in_interrupt() check doesn't fix it.
> And adding irqs_disabled() check wouldn't make sense because print_report() always
>  runs with irqs disabled.
> I see no obvious way to fix this rather than remove find_vm_area() call completely and just
> print less info.

Right. unless there is API -- find_vm_area() with spin_trylock(),
kasan_find_vm_area() should be removed.

But, I'm not sure adding the new API used only bv kasan is better then
just remove kasan_find_vm_area().

Do you have any idea for this?

Thanks.

--
Sincerely,
Yeoreum Yun
