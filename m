Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801526A095
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491625; cv=fail; b=O5iGT/hbszHyN3wlTG8qu4UFciJBJXyhW7BhblUb0SBbzn8SaET/f/03j6QmaX31AdECrdxa59VB2XvuM9UX52omisQkV2OSFqjQplBMZXKQHSwcrlImIs6LZR17Ou1+6zjOj/elrEHg75Bouxz2tMLqv4+nRDD7BFVH20PU0sU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491625; c=relaxed/simple;
	bh=nvC+d5PgVuMNxTXMlLRFuZwh9R6de+79dCqOvI5qqus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRiCS092bzUFB/zbmgjHiKkiZGWATU9z7YrtOCEHiLSns74cewSntjthjNU0muOIMwCadAxU387FqyW8FUeHl7JSM5iFQI7Jj/fDbbicuRF4aZX/c/QKEZvWF3GkBpnBdO5GHRPc7Ih0hVBdh4RShSetOnlMATubiydJ44bfMi4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JW1ETh2n; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JW1ETh2n; arc=fail smtp.client-ip=40.107.241.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JW1ETh2n";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JW1ETh2n"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qGK8xLtI+997OCDfYQB346ZiHK9+KDp/UOgWJz1P2FeZTkXVjTO0b7nBk4jhXPgcMWezevTzyIzNXTJ4wn8zzresDvYQEbsV4+KNhi0ENMc9Cz2Pf1OAMMlIEL5psrJ5M3J2UVF9R4uLyT2tIjLoYl/wbEf3pn9h68rPTS7oaq5UxFLmXIwPGmSF5Chi/Q/1zUsF1g/HmaZKmJHqbsQuYkQSM7Vck3z2t0RGfSn0ZXlPVKhOqDI31shjOUJGcHdj9poPRfUyuG4bVL+hc5a5HIEBGD28PpOO4l7QAJtUrUAs1eEGvMX9xN8ve4YfkmHoGQke0cRg7iYebjUnl0CBVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvC+d5PgVuMNxTXMlLRFuZwh9R6de+79dCqOvI5qqus=;
 b=mCxbHiEhVMdTVCPpaRmdqgumM6PSHHN44uzLL1vJ5EO+wpxnPs18H+WVjtS/nvbrQ4styMpQ+P997gSSrfTDtCfxkreLebot04Kab5x4TXnPXgVEF/cYDlBsdVLeC0Hm7rdafZjBsT98bpMTk7ypXcKddLQdIMwowzeeXTePLujhiufU8cBfi1RHhPQ0c8RNniKKxckITdibvbZUgoRj35xIb6XKxOg81xrEwBt4PjVPKujoqeIrSCk5osN+sW8L7rkFdcKqZOZ2DW7r77ZsgoMityfU8fZqSozqzyBJlfiSrIz0tl8HjW+wGxiJkSSQqgK3iaSyc8QHGVc7Ze7lbQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvC+d5PgVuMNxTXMlLRFuZwh9R6de+79dCqOvI5qqus=;
 b=JW1ETh2nVispAx8KTGVyoKZ12XURKXBOeGR8RCa26FwAllZe48Ymq4us5brL3qjUSUYr4sZhSK/q3lUSqtpf39j0/2eUWfYSzA0zKFmfUsN+JHNiUUKz+yU6KoeUr6eScD7RIolbEgMZl6MkWquSFKIje16d4TOCf43euRdBAHE=
Received: from DUZPR01CA0254.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::26) by AS8PR08MB7911.eurprd08.prod.outlook.com
 (2603:10a6:20b:509::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 13:53:38 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::fe) by DUZPR01CA0254.outlook.office365.com
 (2603:10a6:10:4b5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 13:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via
 Frontend Transport; Tue, 25 Feb 2025 13:53:38 +0000
Received: ("Tessian outbound 678e42ac23ee:v585"); Tue, 25 Feb 2025 13:53:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f3990364643ee3d2
X-TessianGatewayMetadata: HIIHIEr2RltcOeSVcrWdxBeyCedQ2VE9NtVB3loUAh2hWZ3xsZqUNcI/RPklh9RWdfU9jef3o+P0iUsPhoJ3nEUlsKQaF81bSid26Wyg9yZBEWDJ+LIlSAJWx5jJWmAZf7qEoZiXLQDMT4fO/mXDFQ3QY2/5gKlrWzO1Y5RWH/aNw/AHvulL7lzCHJfhXlb3LcJcqYnojgxMzkOJ9jsizQ==
X-CR-MTA-TID: 64aa7808
Received: from Lf76c0b68e131.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id BE01BE9C-1BEF-4BCD-85E7-E2149E05173C.1;
	Tue, 25 Feb 2025 13:53:31 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf76c0b68e131.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 25 Feb 2025 13:53:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJEo+diJm/w8ccvTC1522QuoMHge0+BK8nWBc/fAND21LvGjuj2cYKmUi8Ecj4fbdEhAsHaDSMRce4zgDoJJgleUh6SkPBQuGJwznObeyqF984NtnUUB4gIYVuM6Tgg58pe3hiqtwsSl0enij/jsEVUi7I8I8wl2S62l/fZQGKZixxSuf894K/Zxz7lzeRsmmc1q2lM0Uoiudnb1fBnxT4eszP2xG4mdPo39wcl0+x+oJNgwCzx/GBS4OSxT9ImCQMiNPkBqbRFbGQv0joRFJll5DoZgvawFjkEavu2M1XOkZ3aoOb17OZ48Y5qrMc/3G0009CfPlLwVWzROXHfiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvC+d5PgVuMNxTXMlLRFuZwh9R6de+79dCqOvI5qqus=;
 b=IUlsdB4FAXSmnxa3R55LPSHIZCXUrR3gJtAF4/FdHK2o07xVgsxkPCftArL7xfniL/dfFIvzkSz3YgdM4oPEnJ5jNGeWVJZg7wiP4uj7UQK4XQ2vSaq1iqSbB1rfjLXXom5CJ0kBsRI8KGejWgNVesr1hPrIFM0rpvB6FLuJv27HENWbHpihD04AKjiE3GV7lj6MCQbMu1IQg4TibVNHx8/9/Wb4am8QtiCiyE5zoDkhDteYyhpV1zrON0sM7xfSX35LQdGN+lGAVLQijw/QFyFdFpU2njVi4wUI3121coh3aoGfqK/uI0tnrDAKBrYCZ/dRdJgnphEvL2Ig20cC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvC+d5PgVuMNxTXMlLRFuZwh9R6de+79dCqOvI5qqus=;
 b=JW1ETh2nVispAx8KTGVyoKZ12XURKXBOeGR8RCa26FwAllZe48Ymq4us5brL3qjUSUYr4sZhSK/q3lUSqtpf39j0/2eUWfYSzA0zKFmfUsN+JHNiUUKz+yU6KoeUr6eScD7RIolbEgMZl6MkWquSFKIje16d4TOCf43euRdBAHE=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB6402.eurprd08.prod.outlook.com
 (2603:10a6:20b:363::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 13:53:30 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 13:53:29 +0000
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
Thread-Index: AQHbUsxKiei+YMVvyEi0xBNF5qncLbNYOPGAgAA6bCs=
Date: Tue, 25 Feb 2025 13:53:29 +0000
Message-ID:
 <GV1PR08MB105213206BC42F2968A2F638EFBC32@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241220104521.809071-1-yeoreum.yun@arm.com>
 <6c00cf65-af68-49fb-b762-675186f45abe@arm.com>
In-Reply-To: <6c00cf65-af68-49fb-b762-675186f45abe@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB6402:EE_|DU6PEPF00009524:EE_|AS8PR08MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 355fc75e-7d2b-43d2-437c-08dd55a3ce4c
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?rnDP5ClQ3LTBVegLFRLy1JkJuqckqmmAWA92TxkIUUdTjQteAivK6awUHL?=
 =?iso-8859-1?Q?U4KPN4/EnFFZGbRQBbw1th+qnxmr7+kaQFgyyzb9cOrPFNdlMKOoYu9o5j?=
 =?iso-8859-1?Q?IfPBX3Q8na+yPyAlv/1UedvQUdd3r1+mJn4TexeAfICGxhG/n1++Mr/1Ak?=
 =?iso-8859-1?Q?qOA0bHnYF2aFWHV1FtFsAqiAGpfP5kAevvkVndS+MjfeLYxq/MD7PF5qS7?=
 =?iso-8859-1?Q?QjT3FkMt+dP665UeYIdbtOB2f4sN/aBv07wLsGLoVy1lloSEzkFe4C7GJ4?=
 =?iso-8859-1?Q?Xj98TCGyrus1frs74OmkC/e+jKU/Mohm1o7bMBpJZ3yvBsKmx+OMd/ntke?=
 =?iso-8859-1?Q?3wnSY2RYAs0yn1VyMMJA7orVbY/VsNi02q5qAY/m0KCmRezUJHNVOYST0W?=
 =?iso-8859-1?Q?hKVEw8di9MG+oY9OUCMkEyprkToGY56XWMAQCdUfMxyZNwzOPeYgZEfRrx?=
 =?iso-8859-1?Q?YuEsXnQUHLPBHLqfgLyV4ESqPzlBYydKkOs46VBxb3tBH2pVuMYVzVf7Z7?=
 =?iso-8859-1?Q?dlr7eCuzJ9o3Q3+MUonc4N5lYYGw8+nBd2nxmrpXyVb2pdRhMblZHUFWVi?=
 =?iso-8859-1?Q?MTB1mntMAvW0kj/k5ZoVCyYgBCaEE/TsOZkT/Ris6RzkyF4nMPW8AIKx+n?=
 =?iso-8859-1?Q?LL0IbjZWISH4Q3kIVqxNPCs/vRVyjpDlekmtyUJR/tnDSLnOoEsuYrBcnG?=
 =?iso-8859-1?Q?Uee7B3TIcI5l8ssFiO3TZgPsO0UXJnwYLKBoAZY5yGDdMWZtrf9aaFkaut?=
 =?iso-8859-1?Q?wN19ueQ8ATllu4keWZ50YtkVxlk+3n6/iXYYuCvHaB4d7tK9B1obAGgP18?=
 =?iso-8859-1?Q?1TDX/Ib52xJhs3/dAsZ3POAwjFjOp63xgZcQCsUSKDaCusK0bI2Tv0pHUm?=
 =?iso-8859-1?Q?A2JrSCBpFGurF9tDmnFtXybjMuC61aEH5NspdU8Rx8WQTsQMAmxagOdH9e?=
 =?iso-8859-1?Q?59eV5pnSNfspgcErKH6pGjXtzPSfmdLC7gm7t+i6hn54EHQksmJwvOHomD?=
 =?iso-8859-1?Q?m8hOloaP8PPYnJmEoMDlUDxVv0WdTVu8L2au4eQgCnxAIrwWSIlGMbJ3bF?=
 =?iso-8859-1?Q?HkwYdzIl/lHoO7bTu9wx0neQqVgHcD2qW+bdBFKmIrMyzdGbEHeUhj7aWj?=
 =?iso-8859-1?Q?emv5vaiecybN+nH8jRoUzIIayhjno3aIGCCbK9VeTplZ8txzJfefMC9ekM?=
 =?iso-8859-1?Q?LdqlKpj+twIbUap4EgS/KkBZVJNTM6kXhSPqtRR317hkgcMoHy2MWqbeda?=
 =?iso-8859-1?Q?VHgUKdfim9vtfNUxKp3vhmktD6IhaTTfDFWSVI+raEXuqnYeWKZu69zeCs?=
 =?iso-8859-1?Q?Oldw+squuhbSQ7Q8CDOoI+/WIPc9Pah+JEUd/K3ZE+PMdDqCbHs3MjXgSr?=
 =?iso-8859-1?Q?dkhjnDx5lb1dX3ktPl/qfggcDSAFgbovOJWG1u/057rSvSH3J4GrJ4BaI9?=
 =?iso-8859-1?Q?oCEO1+gFktVse9l2u0YLkilpAKz3vPg5uEbxMpgayPLHLoC0h0mI5OkOfi?=
 =?iso-8859-1?Q?CSoUKUeeYWuB0DVmJ38bPS?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6402
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	96aabd7d-6208-409f-f647-08dd55a3c91a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|376014|35042699022|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?8TqBaLOjg2V171E/rZTgZrLqI1oB0AoDNdzMzQ79cZlXT6BnjrK7UPSW8A?=
 =?iso-8859-1?Q?k39wFe4aNtROscY8PqH1iimUAfNCcf62Lirg9tHC9kmcrj7E08WPXzzedY?=
 =?iso-8859-1?Q?8uOsTpZFC0qwlKbG74iaLopnGx2Js7wxG/sqAmipU/P+EyC9RJ89ijCdTd?=
 =?iso-8859-1?Q?wVX/AU0Q7RF8RtL7qbtTTJsPhDHi9o74GuswbCj25es4ysUtZ8jqW5Aj9u?=
 =?iso-8859-1?Q?OrS/p8dCYQS8aTuLvaOBIzWV6g8MD1HTkhuWTPnVhwjOB8Ddrm+oYbbBGe?=
 =?iso-8859-1?Q?Nn+JYR5mccbwQUHmQcEjJQGlYZh9OCUoIimtpLLkySR44zMRpaK5QpOOwI?=
 =?iso-8859-1?Q?XJ/eL8K7VR4DDUgh6jnBjCCgbLLcmMx8qvETKXq6Y4MjZ6Il6gL/Rc62U1?=
 =?iso-8859-1?Q?SYoHHUmpxbmPRQB23rzRwpGLdpA8pxgahw42/xrRiF7rLcHrAhMidq7DBC?=
 =?iso-8859-1?Q?JwE+Cp/GEvdGZ8qscKNJak6V52GU2LfhAZGI0ABD0FL9DAvu4dPETq3PXv?=
 =?iso-8859-1?Q?Gp+jeCslXOaMDb6acymXuFCRTY6iWIauK+d5ySITUbM6i2Lt/Gp50Yvjwx?=
 =?iso-8859-1?Q?ys+SLdt5F8e1XF/sHHX2y3202ZzAI4jDP8b69/aSwpyfb2YZrJvvpip+1N?=
 =?iso-8859-1?Q?BG8DaWSI4hSchwPZl6Kfz2fb9vF+JBLOJbYVLpcRKoSpJM4OjyuZEAHsAu?=
 =?iso-8859-1?Q?nm0Lre7C06fCt2qEZNS3+8gd0xTp8fHtMXdAH5/q78hiq1lXbI4FuRPCsM?=
 =?iso-8859-1?Q?HankiXtcRuGr69sfvK9hibP+96jOgIPI9FY5Xwt4kAt+4f+hxJGHQOb/1n?=
 =?iso-8859-1?Q?nMli640zqEMObbnxX/05SVhEYHHM2OHFZLwxUCK2yOyDUPPSNTG+h8TL2t?=
 =?iso-8859-1?Q?xYyoSwqufFTTo4zVMlZL59NKs/T2ECKx6pPjGwKfdMcpbmuoueGMWoWLZ+?=
 =?iso-8859-1?Q?KYjm9rFx7BD+2ayWX17ft7UVVV19GDwEdgFMhbDBe9RYsyLXY4keA4SIdM?=
 =?iso-8859-1?Q?IYPdbYFvtd3wx0WDNJnW1TC8mGIcz+Vqgc3iOSyU3B9jMPCN+rwX4nH7Zf?=
 =?iso-8859-1?Q?B+L8J7719WLKdmztzywSIpF/MTDWqW9Lbkn2iR2RE76+gozMZYZVzfF9oz?=
 =?iso-8859-1?Q?Yyb0xblloD4D5/+NM3T4AhrlZJI4KITN0C3eCzvdLScsC4rZGeuGrQpRLz?=
 =?iso-8859-1?Q?qn+JGVrR1ZwWgSqcC+af03Tt6CfdyQ8QLY03vUancT9+5KvwERqd1XO9JA?=
 =?iso-8859-1?Q?FjlfahBsZDjTABt1MpsmadNmM6sl1SMyKPePGKGQLM9BurKjLeQzhtNlmL?=
 =?iso-8859-1?Q?tIm1r65itVZMwnjP9ycyJz8yeKQBbW7bYisUyzI//xmXNVjANLJO3TXzuB?=
 =?iso-8859-1?Q?MRFtZBQafFwBYkWR8apwQRqI66vcTxqYgBVhdVXuLcIIxuW5GU2cVKaVsb?=
 =?iso-8859-1?Q?rfgawQF10w7DbEQ4NL9SeiJ7q/CHmMy+m+5JAUyLrWAvZgSfVfEbDm2O4K?=
 =?iso-8859-1?Q?vs7G/nzUbyASG7Oq1O74JjTOSKfauW9GwAYX7ag8I/X1/D5GxzaI6veQau?=
 =?iso-8859-1?Q?pr/7IyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(35042699022)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:53:38.5456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355fc75e-7d2b-43d2-437c-08dd55a3ce4c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7911

Hi Suzuki.=0A=
=0A=
> This doesn't apply cleanly on coresight next branch. Please could you=0A=
> rebase on coresight /next ?=0A=
>=0A=
> Cheers=0A=
> Suzuki=0A=
=0A=
Thanks. I'll rebase and send again :)=
