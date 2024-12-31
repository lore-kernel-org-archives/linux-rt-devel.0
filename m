Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFB768FD
	for <linux-rt-devel@lists.linux.dev>; Tue, 31 Dec 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735656266; cv=fail; b=KOF0AgqDcWMiV3/hvv6YbXkaM+T8M9YZd04EZbg8kgw/f6XZb4VRw1uHi+10fAEQ2TEvHLiYK5Z7Holwp4m5Qhpptt4R2+wbPG6A8TXQnFs0CnE5uPhTEd8Ub0MJn/F8oDJakNdY+9KAPD9ChSUcN0xmPahlBIhoHR6gRX7FT4s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735656266; c=relaxed/simple;
	bh=fYYlvXO1NrYuABbmB74vEaNwmc6vDp61O7L/75mqRws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kNSkzTW4Mmyd8Y5pbxfZXnhL3LBF15AatXjxIBLn50z+vE6mgO6IiZ3UNbZQA+Y9a5sSPI73Ocw6MNSFu64ZQUdqTROln+9SLjLfsr3AqwmZgZ8jDwORUNZls288nCGuXGstDSVNka2uaQ/FK7xB55HYapnk3jC/Yu1IicUNUhw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GDmaRXWP; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GDmaRXWP; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GDmaRXWP";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GDmaRXWP"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=INh0ZbxknjLzPB6XsMHSH6WCr/Y4u25ypsbSRBPgg4KNHYo1p1QpfXma/QRwu+ZrFgk5srGirEaGwjqsiC3uxt4n3A4xgB/9TjBr+lsgpkEwhWQ87s//iJ5gTYQezaOBlJ7mWBM6mM2wE91oRsXxEP6rk2i0va9aULIyjJbmksxOMxT4CGr7TorDMcSWAQF/T0wVyXIO9WNBYbHw3L6WWG74HJB64usXiXmhzXL/lola2DOKwAnqJfFU500GAppsTef+eJ62vohLo7L2gXrXcXJLcn3JQk6AYZ3rsakZdIghSk7Q+uFF22Tzbs5SG14fYoIJM+YoqlgTdP4Yd5T/kg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvR2l0im47dH3xfAJ3k+anTAGIEx2kigThy8ykXsfsU=;
 b=V2ArcErc6aGYw/66N0V182GmFOpkhW37LMRslA9hoFJd7lTW9BpKS1NQ3gOkhrjcOxS7h1kvtMyD6Bbr5Nutra6+WwRnBEnW//K6bhMmcpu5k5uQv4Rp/xLRNULCY9FIXl4HWClvaXuSAwXb1okU2CUHIR+kWXA7r+64nqk0AgratbJFxnqZTHUNnGOQHxiRWJ2YxfLZOW3ggdm2ELDAAfMknwpPPBmN4i+Ag5vNcYaJ26fpoxkpHhphnEdjrGNnNdxQI902EPgCBE+l/WvqikEEwCdtH8kovMAFEcG1+BLgMO+zP+ugQ5y0PIw/X4o2eeMsZ0cfPHkyYjBTnnn/Dw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvR2l0im47dH3xfAJ3k+anTAGIEx2kigThy8ykXsfsU=;
 b=GDmaRXWPcK2OIiPbTHPTUTpLUW5Rp0Dw8/Z1r58j3oJub5NCLFWrWCvpJQV7MlZPuTMP9JRBL5609RMoZ4AQ76bhGBlAAe25vf948xKK9GS2D5P4Q+iwf2ZknpMq7WkcS4pTIYNJT6oMHrgbFmnm79wHJtjPwyLmEfOV//2rnSU=
Received: from PR3P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::24)
 by DBBPR08MB6170.eurprd08.prod.outlook.com (2603:10a6:10:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 14:44:14 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:102:54:cafe::63) by PR3P191CA0019.outlook.office365.com
 (2603:10a6:102:54::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.11 via Frontend Transport; Tue,
 31 Dec 2024 14:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.11
 via Frontend Transport; Tue, 31 Dec 2024 14:44:13 +0000
Received: ("Tessian outbound 7762b28e8285:v528"); Tue, 31 Dec 2024 14:44:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f06d7c9d295b3565
X-TessianGatewayMetadata: n4K7g9TJysWBe04y2D2quzCL3jxe2CD3IQn33ZST3MCRLzO77vkjjG0SWqjQFWNuVjU3KE13WCrUzuvX5U+e/bJz+9xRLYc/Ib1pjeNVzN6Ax7q6HFVfu+UP7AGUBSarnpFNrrwDQjsP3uQZqbN0krFZo9knLiDn5OnLZol6irk6x+OGVP94Ib8f9Tcso9N4UlgvNfugBenSa9vcdyHUUQ==
X-CR-MTA-TID: 64aa7808
Received: from L74ab86e0d9c4.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2112BD63-8C81-47CB-A970-5D5209032BC7.1;
	Tue, 31 Dec 2024 14:44:06 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L74ab86e0d9c4.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 31 Dec 2024 14:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFnl4v69GR2hHbFDwvQ4ZHJiPj6uuegwWM0HgWszr7XGPocUB0Bd3ZAyR5MLIrePYlNTKPHSFd8tFi71nUH4zZBbB+wYS1JylWbnvCPu4a9Fzen6AYP9TOVsKvl+R49DoN2brkOAsAWOFnDU5BrDSe9NSzHI30/aayAS03l/ktGlOkQugt5R34TCf1BPWfRWJt/X4g3kn5b+VLZy2LIIQB8k/9kKJwCrBg2ZS+4B//dvc55rtPb5LvELDDBaejIedb4lcropN1rk9dL5udyT6FM0CTo93BOE65gfA658rByjPwC/k53G6bhy0oTGv2YdTy89vlVkyt5uUM8lns0u8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvR2l0im47dH3xfAJ3k+anTAGIEx2kigThy8ykXsfsU=;
 b=ypwBj7t1ghbJXqeFOJc9BBdj+s8uqWjkbIpGJ9/3rbAMyDRIgPFzt6VoLCeo1hBRRdyoFrz/RfpEapIfWPHBsdJyYSCFSdfMzR2BrI5Ng8v3Uq1irDUB9LvW99Io+nXJz5JJUmX324fwnhSEjPdidUJ7PBoByICizeGXqw7glvK4aB1lXQRe0ZGAG9k3xCZ27FoM3mgbmD3C50g3jqsX50/tK8WLPoxVGMTK8kkgP3Xe55LFCdfOi/1sBeOxBqEg3NxN15sv17QKot72/ElF0FvN+2h4/vmDYqJlv9oW3nMdY9pbw9RmI+NOCkJp7r1OLfdiOdZmzmt886HlxVnO2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvR2l0im47dH3xfAJ3k+anTAGIEx2kigThy8ykXsfsU=;
 b=GDmaRXWPcK2OIiPbTHPTUTpLUW5Rp0Dw8/Z1r58j3oJub5NCLFWrWCvpJQV7MlZPuTMP9JRBL5609RMoZ4AQ76bhGBlAAe25vf948xKK9GS2D5P4Q+iwf2ZknpMq7WkcS4pTIYNJT6oMHrgbFmnm79wHJtjPwyLmEfOV//2rnSU=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB5714.eurprd08.prod.outlook.com
 (2603:10a6:20b:1dd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Tue, 31 Dec
 2024 14:44:00 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 14:44:00 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Suzuki Poulose <Suzuki.Poulose@arm.com>, "james.clark@linaro.org"
	<james.clark@linaro.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "clrkwllms@kernel.org" <clrkwllms@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>
CC: "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v4 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Topic: [PATCH v4 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Index: AQHbUsxKiei+YMVvyEi0xBNF5qncLbMAfzbU
Date: Tue, 31 Dec 2024 14:44:00 +0000
Message-ID:
 <GV1PR08MB10521C7324CAC9BDEF8DBC05CFB0A2@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241220104521.809071-1-yeoreum.yun@arm.com>
In-Reply-To: <20241220104521.809071-1-yeoreum.yun@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB5714:EE_|AMS0EPF000001AE:EE_|DBBPR08MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 9415c348-66bd-4039-2120-08dd29a9983e
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?hCF5jjj5fqk3lzNwoQLp4sYTvf12/RqDYYnoEY96wx/8GMft66FWmkstWUW7?=
 =?us-ascii?Q?s2oadWp5UzORWY+n4JVHO0ci0OFwGiv4D/GAoFkpJn0CQCEJ3UMWXAYLq4KD?=
 =?us-ascii?Q?M8DsNrakUPf/5DJAODKywhxYJwjODUihDcNe2SKgkMgzO7MhkCXbsiANKTof?=
 =?us-ascii?Q?rFK7DhPDkCHXljMH/g+5uaQyblWkGowOqARF66vC40YerWW/XlqtcFPdm7bX?=
 =?us-ascii?Q?hhomsVPwJyIjeThcPXRcgKUdMb49WrhNUfe5J97OvRir/VZVyOZZdBZOHWPv?=
 =?us-ascii?Q?H4PqG36yWDPaLb2sg4sNt0qBkGSJjkDN9aq3GmPw5MVZUvHJ2fORD7FNKamy?=
 =?us-ascii?Q?9b1YGdxykJwIlBlstsH+vdz2NHY2fMDLQEaLmt5XflSMd0uudSuFJB1rdP5H?=
 =?us-ascii?Q?53nEODqr5NT4iZ9Z1osv3T9EYeqUtsviqjrwV2bLdFAR68jTtBA+f4cAqfta?=
 =?us-ascii?Q?8sTugF80uMJ2IP/AIUb1LFrmm7GUcThAaLJAK6LdZpdXV+lzv7vqnH+OcX11?=
 =?us-ascii?Q?N9Jsd/IVaJSJf2GSQq/V262GZ2P6JDo0IkPaOU9E03hhSp3oj+g+R7kLRuhG?=
 =?us-ascii?Q?PJUatwPXr9G2vz0ZdUYPckwAbcbEQeIB4ew6GaBd0tk03T1VfJpV6mmuiKXj?=
 =?us-ascii?Q?QB5GiVAR5gBp6D6Js1HsYTKZ75C5EAO0sBALfshSgWSeOAubh3GLPsnjMTce?=
 =?us-ascii?Q?EHRvfLeSkpDtj1A7pj1HOhibIMCkMsnW/n+ABcKbzkai2Hj3+yKSKXPP1iS6?=
 =?us-ascii?Q?h8rcc/dNyih7DB7CljYv2EG4y1kEOh9R6hOXV+zqHpSaod0dY7yFLpqHANzX?=
 =?us-ascii?Q?O23NJaaFANLWRKaM95emUvAHk7sKPHhXEPI+FvN9dMIlseP1j+DKHzJ3Dtyg?=
 =?us-ascii?Q?q04EeAZenwufcXz88oTnDPBkDCybCSrFHEgK+44bfQV0fcJe0ScsaWPKj9AA?=
 =?us-ascii?Q?Iw5thPXEEaBBVR/p/qj0HdHGZyKkk2LY2qqoGqEp4k6oTgGxQJkU5xFF7LJn?=
 =?us-ascii?Q?tiKgBhdU2+SkQVfZsjAipfmU1nV3044TEKfAQS/FCv9m3OQDhFsLkAyXLi3p?=
 =?us-ascii?Q?aNmc6Q78TUhQmen49/u1dUdxhV7inwbBwTaZUU9pSCdfoFDN9wj2yhf8/Jks?=
 =?us-ascii?Q?WD3TK79U8J8BqC7sppnyfCyopAesf3/ghnmurZSYetBEnYbc2WTAfUGyiuyW?=
 =?us-ascii?Q?4OzUhdoUmF5Ty5NYW8CIbJQohj+ZuLl18Cwx8xVHMCbaHuuKvraRVFaOjlvG?=
 =?us-ascii?Q?M7Rw2aXwq0pzYrf0Db1tQG8ofE6Eei/k/URELhM8MUIZQaKWqL3jysnMR2O2?=
 =?us-ascii?Q?lb4Xr8GY7gYsE1IUy2yjOqRLZAMkwuO04eHkZjNwJm2izTlb0umalJn5wrhe?=
 =?us-ascii?Q?HYq2QtQlm9QB8w1coCgl8xoGiPHel10T8meBH0azA4OwzziM6xwUytvfp6Ee?=
 =?us-ascii?Q?MI+OyPDRqTGVdIJHRlsyma+399ASgcP/?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5714
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	26f9cd64-882d-4f40-082a-08dd29a99037
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|14060799003|35042699022|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T2vaPOH5z5nXa7ElTK3aYoXa/r3ctOdrpQs9g3NY+84miNU9B9YZgWvK4dhq?=
 =?us-ascii?Q?ca1ralK/0BS+Ll4fEp7Ce7ZJt9EMzY0KFP5QTsTRjRhLuOM5PqU4x1oMnsB7?=
 =?us-ascii?Q?11PGGVHlwEXsie5wOmMznPN/prEv/ou7GHUXCSIIzWfDn0CvFNcvTbB9n5WQ?=
 =?us-ascii?Q?QebOaY6z7jpLqm7Yhzq/ITn/TU6WPoTT9RggIcOkrFVoX50Y3N25715v2e9l?=
 =?us-ascii?Q?Wlhs879VdX9rtGgD/rj48rLrTEjSJRAUUT4w7WBweyVZQiZS6SEXOKKmncjH?=
 =?us-ascii?Q?RhP2tX0dlsITlSannwOEKHIE+QXZFT+ogVPw+ed6BmV66vtl2l0ekDH+CTQz?=
 =?us-ascii?Q?FlbOjHHh6RO+cGYQLapXpjgV+DqUpRoWTaJ/iSLYNKHk9/Cn2M5UNW+PDPAZ?=
 =?us-ascii?Q?tz3E7XTOlh95GVQd4AlgIIYKHDMbcU7YyDhViGwUu9/ev4IgSGZ1Z7we7k34?=
 =?us-ascii?Q?F1DeMK5SEtylAMgGGcwTECUrzMFpICyZyRmPOthAeTPghDrpoUX9V8Ir368z?=
 =?us-ascii?Q?HIxqNxo+kW3FsCAS+Gh1Y7Ap9hFcro2xIAkJJL/fM4EAa8DMbPewuj54Z4Lg?=
 =?us-ascii?Q?jQPjdDPMxwFFgUvj5uBzhih+f9Wb1VQmKCmlo3uFIIZCC5/EKX4F8BL+Gq/D?=
 =?us-ascii?Q?ImB/B39eQz31Ic2WoETygHR+07g/rHrNt/fHEcHnUm3YORty9fbCL/fE/dFQ?=
 =?us-ascii?Q?10a2aIAyZYl+TLAtQZqI/4CXOaChE/aK2EdH7rrd7YwDAhOcyJnH1fOR1Gqi?=
 =?us-ascii?Q?7ZAG1+3PgruTZhjpx5WQOlcNjlucMqAhJ26hGE302Jqhkx6AF/ooNxnNNpd3?=
 =?us-ascii?Q?5WMdT6cGSIv1XNosCSSde+mhYEroNxTK0WM3x3B52KX3/bstxTixEmrgp8TJ?=
 =?us-ascii?Q?cBRuVjWCdQj5zNBkJ0LWmM0tUS34Dyq5FU1dobrSCdWP9C+KS+aCi/i8uaNs?=
 =?us-ascii?Q?n6YBO6LZrqCPcJwME+bhPBIrGudD2jYWVvZIFMYU2M5u3nNzZjuQnAwucaJl?=
 =?us-ascii?Q?t6TBHWfjWSQ/QVLq5kfFWM/A2c0U0FBLTK+L2Z+V+vinboyTwUQGQVUrsmu4?=
 =?us-ascii?Q?MJRkPYIt2PCU6McP1av6t6XKraFJE06dD36Z156rfIEAZfsg+9eQgRLIZsrp?=
 =?us-ascii?Q?dZtg+AfmKCLMO1a59iOsfpK+zwkDj1CddybHxr/Jt+ZNaf+9UMHV4sCTLhOy?=
 =?us-ascii?Q?eZJhyeG2D8O6Sc/srwfliXCU7wYeYYkYCEPsBIVYaHA/PxVd1BGCh6qes5LS?=
 =?us-ascii?Q?p67kIMN+cMZVub3DmKUE8dLcrkYGvW0sRfAj6HCgH/0wFNNbWu0MsIFQWEd9?=
 =?us-ascii?Q?VHWhxKjyBjO44PJ+6M7tKmwHUxI1lUP74tpGtUTyC2jJRa9X1aSlwPNndy7W?=
 =?us-ascii?Q?Dr8qOBwtPole3x5bYp2ZX4LZjavhA5iCUtwzj1ZBi0Lk5YLphe4xxeCSIszR?=
 =?us-ascii?Q?qM0O6P9ZNKl0ebLunSDGo/v17dvl+SboN0bxbfPlzq6Yp6o/weGO+bMHZKSs?=
 =?us-ascii?Q?LJy3qZkw1BoHezA=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(14060799003)(35042699022)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 14:44:13.6273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9415c348-66bd-4039-2120-08dd29a9983e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6170

Gentle ping in case of forgotten.

________________________________________
From: Yeoreum Yun <yeoreum.yun@arm.com>
Sent: 20 December 2024 10:45
To: Suzuki Poulose; james.clark@linaro.org; alexander.shishkin@linux.intel.=
com; bigeasy@linutronix.de; clrkwllms@kernel.org; rostedt@goodmis.org; mike=
.leach@linaro.org
Cc: coresight@lists.linaro.org; linux-arm-kernel@lists.infradead.org; linux=
-kernel@vger.kernel.org; linux-rt-devel@lists.linux.dev; Yeo Reum Yun
Subject: [PATCH v4 0/9] coresight: change some driver' spinlock type to raw=
_spinlock_t

In some coresight drivers, drvdata->spinlock can be held during __schedule(=
)
by perf_event_task_sched_out()/in().

Since drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this,change type drvdata->spinlock in some coresight drivers,
which can be called by perf_event_task_sched_out()/in(),
from spinlock_t to raw_spinlock_t.

Reviewed-by: James Clark <james.clark@linaro.org>

Yeoreum Yun (9):
  coresight: change coresight_device lock type to  raw_spinlock_t
  coresight-etm4x: change etmv4_drvdata spinlock type to  raw_spinlock_t
  coresight: change coresight_trace_id_map's lock type to
    raw_spinlock_t
  coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
  coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
  coresight-funnel: change funnel_drvdata spinlock's type to
    raw_spinlock_t
  coresight-replicator: change replicator_drvdata spinlock's type to
    raw_spinlock_t
  coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
  coresight/ultrasoc: change smb_drv_data spinlock's type to
    raw_spinlock_t

 .../hwtracing/coresight/coresight-config.c    |   8 +-
 .../hwtracing/coresight/coresight-config.h    |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |   2 +-
 .../hwtracing/coresight/coresight-cti-core.c  |  44 +--
 .../hwtracing/coresight/coresight-cti-sysfs.c |  76 +++---
 drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  26 +-
 .../coresight/coresight-etm4x-core.c          |  18 +-
 .../coresight/coresight-etm4x-sysfs.c         | 250 +++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
 .../hwtracing/coresight/coresight-funnel.c    |  12 +-
 .../coresight/coresight-replicator.c          |  12 +-
 .../hwtracing/coresight/coresight-syscfg.c    |  26 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |   6 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  48 ++--
 .../hwtracing/coresight/coresight-tmc-etr.c   |  40 +--
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
 .../hwtracing/coresight/coresight-trace-id.c  |  22 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
 include/linux/coresight.h                     |   4 +-
 21 files changed, 308 insertions(+), 308 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

