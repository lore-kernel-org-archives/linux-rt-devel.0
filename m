Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167C1F8904
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Dec 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239863; cv=fail; b=QNJQkbTEkrciQB9PEl0oWcRKZ+6l/hCIyz6INK8FtGAAojKjiheUL/At+Ec8/rQF4wTNCMVfRt6QypySbotUN7QDmx6LC2PXjLmguJrZNSf1GdSnhC5PCZepZaktGIP7v2uFOqERPpq/p4CB0YVLcgTwolNbTwpqtmq1no9oY/0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239863; c=relaxed/simple;
	bh=tfLrDR02eXRs7mLK7mPmodLUQekUo5xUaIK/CIJvgug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TPvDfxizOVK3kmy/dLn+gwjKzrSCJ1UaNTDpvTphcblm76aT6VWsN/wzCJ77uP5rUhFrOvi66XY8jRxWcsHHUHrlksXZ17bXrjGeccGxp0fy1bjcm1VsUD3oQset1QHeMYZVgz12km5SoxNwWfTTHFuvALIX7kujjU1NFpSRW5Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z29DVIqD; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z29DVIqD; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z29DVIqD";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z29DVIqD"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XT4aAy2NFxR2oQDMC0M+uM8VHHmgBsFJaSRcHDpIdFdsbdF3ubdbVmtKLCWVt7hGxcDjzrCHn4kbZ64YSc5RCpd2YDPb2uki0n4teXjtKKvMwx09TLrei5ic9hzjCHAGUsw9ERcDVe49lhJuWOEcq7HmVjBplm6cFhdtHhq57/U5BMFNztIMDkRpfV4XMV62ExVJOekVXUZCBLwWlCWIiakiVeZj6BwDLyrtLwpwySspFNWlWVYjVoUboK1pbEtyvAuLAaJ9jotJlr1/H0/ASOAMRQGQf4glpYURcAkaVG1YXVZjd0wfDDm3YV1qYmPQfPhwfQwKmH2yRtDwioiLTA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfLrDR02eXRs7mLK7mPmodLUQekUo5xUaIK/CIJvgug=;
 b=M4528yTNm30ZzN0Te0f+bV7Bk1kc+rcf0m48uRkqaJB45Sxs31bVJCSVPWII1sMIoZGjZEou83AjR94lU1BMbzTFF051tSQ91r+dNrqkzylsSgbQI+BFqqGr9Ur2u4VAmzJTtHf2qkMgzpIdBUFPwJxnE0r12Mqs7ye7BUnTyGNtXEeLxtAwLjgUK8A0tXmHcA3tR/QlbKLEeSVnzPMp7KDdm5HuDbFR5EdA73GJcxBd3EVTifxAQl6c/loyq+B0aslpxTA4k2QehI9kaDQqNWIWDFBbSUDPPCfeIY6ZHaq3nCaUqupmszbHOUzjMRlB2cnyE0NXVM9xcQI3s0aRjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfLrDR02eXRs7mLK7mPmodLUQekUo5xUaIK/CIJvgug=;
 b=Z29DVIqDhBj0lObZJPLBVXuBdY+CYJ+afk9ibTRiBaHHu2X76nMiSy4CWku218q/BE8R2Wq9tw27oaULPrfNHw4gKFCQxJXSNM+nFL1v2ThwKssM2yGVIIdzeYaheTYEBJ4zg7sDYW33ztFO8EUn/7XIEfsmw7/q+87Jpts++9M=
Received: from AM4PR0302CA0028.eurprd03.prod.outlook.com (2603:10a6:205:2::41)
 by AS2PR08MB9570.eurprd08.prod.outlook.com (2603:10a6:20b:60a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 15:30:55 +0000
Received: from AM3PEPF0000A79B.eurprd04.prod.outlook.com
 (2603:10a6:205:2:cafe::dd) by AM4PR0302CA0028.outlook.office365.com
 (2603:10a6:205:2::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 15:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A79B.mail.protection.outlook.com (10.167.16.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Tue, 3 Dec 2024 15:30:55 +0000
Received: ("Tessian outbound 206fab1c37e0:v514"); Tue, 03 Dec 2024 15:30:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c393e09ce843bb2d
X-TessianGatewayMetadata: nCgfyCV/rkCti776tiCSQahB+vKsrsTG+Vbhaj8sw3pEvWi64XD5BhIVh5V6E2AVg+K3dRNd193+6ASpZku4SFDlEvaYbTFa3W4nmJP1uii/BIgas1zplPeKlqpshUo7asCAVGUUFowW3OW/q7KHGZGhPseYeaz2LU9j/zKFvsZkOLf7IrHRYR4tys+DFNblC70iHMFIfnsfWezRIPSvug==
X-CR-MTA-TID: 64aa7808
Received: from Lc94fc43f3c7a.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2A27920B-5733-4BE7-A5A3-46525A7984E9.1;
	Tue, 03 Dec 2024 15:30:47 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lc94fc43f3c7a.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 03 Dec 2024 15:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lATzZ0Ca88qqjh2QkJclLfYy+Hg03a0GX6jaBRN9wGxsZSnM5Zjt6d2dPOz0lj8jyMDs4EMjrRHIJxL4K0mbGpxJNA25LKJ61ILqEw2Cj1t54dAwgUxrdUBWBFazVGO9QDDEzG2Nxr6iDqb1JyrBjpfUME/2MLc5UJAs6ORr5xrJhjgzXWDTKRX8gRJIcZEKYA0hu4xVEpfF1MqH0Kv8kPkGBxBRq9V6mncB9A/mHTVpEbZzk6vzeB7eBqyEU58RWAD4zOFV5icuHkF2Ugooe3vHka+BG8VUcQeFElXhSUOtlL4Sk8ZBf69a8w8rv4EMfUneTtTDjgqIkVEteqo9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfLrDR02eXRs7mLK7mPmodLUQekUo5xUaIK/CIJvgug=;
 b=ReMIwdCO2lsyNDX70/tz57QN4nU0f9sA6H9UzQYz99rzdZbUd3sKkAk9iuOetTJNPSLegnQQXuADAJ6RXZM8wzYAWU17y99IycrUKkRzDlORQzuyEOGqPIkBLYalrdw3Pcb9k/+atmWd6YVa7ER0dWydK/EV7xyKVfB65T54Y7yKsetYFgGpwDAlPoypC9vmAfbphv/L5vsPJyvK7d8E+8lOa+/RDkH7Ipd8+Ilif0DnWeQjq7iQuanP1TNfaFG/FyDJsMVMA9jjE8Vziu4YFoh1u5OXbCc/6Wt4Y6yHEcORBbP/BlQcR40IzxQJ0nTwJvFnLc0FpKuxKF0QK6rapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfLrDR02eXRs7mLK7mPmodLUQekUo5xUaIK/CIJvgug=;
 b=Z29DVIqDhBj0lObZJPLBVXuBdY+CYJ+afk9ibTRiBaHHu2X76nMiSy4CWku218q/BE8R2Wq9tw27oaULPrfNHw4gKFCQxJXSNM+nFL1v2ThwKssM2yGVIIdzeYaheTYEBJ4zg7sDYW33ztFO8EUn/7XIEfsmw7/q+87Jpts++9M=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB8443.eurprd08.prod.outlook.com
 (2603:10a6:20b:567::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 15:30:44 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:30:43 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Suzuki Poulose <Suzuki.Poulose@arm.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>
Subject: Re: [PATCH 1/9] coresight: change coresight_device lock type to
 raw_spinlock_t
Thread-Topic: [PATCH 1/9] coresight: change coresight_device lock type to
 raw_spinlock_t
Thread-Index:
 AQHbPx8vuTignQOEcE2iGTau3pde/LLLYBwAgADpbc6ABtjNgIABGYcAgABzv4CAAAFbSA==
Date: Tue, 3 Dec 2024 15:30:43 +0000
Message-ID:
 <GV1PR08MB105213222FB18FF328443148BFB362@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
	<20241125094816.365472-2-yeoreum.yun@arm.com>
	<20241127120954.0facd34f@gandalf.local.home>
	<GV1PR08MB10521520ABD7B72D92FD60DE9FB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
	<20241202103853.26db0c13@gandalf.local.home>
	<GV1PR08MB105212FEF9251CA2B3AAF7FFFFB362@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <20241203102047.5844de81@gandalf.local.home>
In-Reply-To: <20241203102047.5844de81@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB8443:EE_|AM3PEPF0000A79B:EE_|AS2PR08MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f901b69-5c3e-4f5f-1959-08dd13af7aa6
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?0nmgu/jXWswkb/7UbmOE3d1GWfjlOQE9o3WLZio6GRy/BHZvzSg+9I5Q1K?=
 =?iso-8859-1?Q?B0+/wWfPqNrQOLqY6/BTtIZTduBx03Igk3zRs5UN0RFH4ej/A6lLwSyBJ6?=
 =?iso-8859-1?Q?1kCNQM5MeME7iH3xesmu7et598jCtV4CxtyL84uoK/Z81ryKSYqYNfPD2z?=
 =?iso-8859-1?Q?wqgil/WzkhnTl7mhiySyjqJ9aOc6y1nA8AaHtQ1tp9S39Q+XdnEQ3PfxAF?=
 =?iso-8859-1?Q?U09rs9dPchbwh4A+CMhZdLl35pYEoDspLFIQjw5LZ0kyACC27QSAI7g16E?=
 =?iso-8859-1?Q?s9QrY0c4uHp7yBi8F4fVALsRjvYJp98BI1dZoShy1G47boVqGkcX1xgbql?=
 =?iso-8859-1?Q?7RuoALDm7HKki9cXVDa8GVx3gle4dF6IhDY6XuMXMWqyvCZlsS0M+qCm7g?=
 =?iso-8859-1?Q?wMi4uf76mmNjJSDVZJapF7vXIsZH0HA/abUuAbOkhoovBzmYhPAJLU0jtP?=
 =?iso-8859-1?Q?AxCOyJQ4rF/2iLMgGbxMtMWzr1rq6FDHoFkEwkWoFHghxv0BX/gexiVgRB?=
 =?iso-8859-1?Q?yHPZTeRdcBCL7utKezMjmi6eevtPDdoZkOnlIUg4M8bqU3lviPEO+CLwqc?=
 =?iso-8859-1?Q?QcnNwXUgGP5jgtFweP8fN7LTlNEpqs28GfaCJvPCrc5xnhfSxlNBczxZR5?=
 =?iso-8859-1?Q?8S5DLkQqSY0BCw2o6c3nGgUqujhxhpeN8fA8+wUaM2H7LSb/n/laMfmPj9?=
 =?iso-8859-1?Q?2pjQGzeiVtuNgzwaBLYycrAxKfX5DnprG7h1Zok9A/x0TN4rQUuDlHOPEm?=
 =?iso-8859-1?Q?4W1zFiQuyDsABUATz2pQe7FZQnlj7TPi4Ih300mV10Uj6gnOCP4VXZ9YRG?=
 =?iso-8859-1?Q?4XYxF3xHvGih7PGOoQLlQHHQHhdnt9kBXIZ2prjE7HUchxxFdynF2a61mu?=
 =?iso-8859-1?Q?AgykghpjhWB85ZharRZgg8ySBOw7MZ5czwaL8pV75k1uk5iUyKNZbbtyDL?=
 =?iso-8859-1?Q?kT0yFdr7UC2CxXJ97nZ/u6Vsb0xIRye107+amqTgSfyo1OH09+SvKmfhGk?=
 =?iso-8859-1?Q?ihm7AfD3Ko0FBodJ98lxw0C7tzPs7VStBZ4Wg2Ry/vzud/Nj52jMQgBD8R?=
 =?iso-8859-1?Q?iBCHGMg5Dhgt0oXGkkZbGbw8pJHRGkTtJpuoFhRwvzvi3ULAwgl7TXtlan?=
 =?iso-8859-1?Q?LK0iptdLBGPiVfXX0bC+BM9jTqoIhrbc0/Pz2Kcjvkw+aMirNZyWCrhAjG?=
 =?iso-8859-1?Q?bWtBiVp7niAB910Lswg84K9idMyZF2jeHDoqW+9+PQmWnXy+0ziI+Q5SFD?=
 =?iso-8859-1?Q?A+373k3/C4F9rYfgTKev94+9gjJy+g/imFS+Mu4BcZwg4wE6Zls1r+CL/m?=
 =?iso-8859-1?Q?i0jbGVLSxLro+3QnheILygfPmGCkKLxiDBOCEDnjS6/I+gWwF3GNFTgy6n?=
 =?iso-8859-1?Q?1P4Pja89+YFtSd4REpdlPAQRDzC+1WSCQQwEPji+Kz2EN+M6lHjZ84867w?=
 =?iso-8859-1?Q?HvUYP17r8y5Ph5kTwfgytFFxsmbkJWaHuGXRYg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8443
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d57271d3-3062-4220-5c7b-08dd13af73a9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|36860700013|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?vdvmt27UUPOrqdsC/ttSqYw2vmkITAedjApeA7yE4BuFdXAyTyul1sHEum?=
 =?iso-8859-1?Q?2Q15yWmDt2Z8JtV/mGpmPcLhO6Zaf33mpIMCg7vhTnmKfEo7qsMuO/hNkU?=
 =?iso-8859-1?Q?0qW+q3C5vG1Wuwsj6+U9xhWkvosIUvlsfwrY6FH+ME+obhHKSIZDc635EG?=
 =?iso-8859-1?Q?lXLPcdFEJ+/HJ6R+vytxyGhOA3Exp4cYiYN3rcb7fCL1W1w8pmtOUVnZUf?=
 =?iso-8859-1?Q?Hn4sTVmP6ecV0GMy3DA53pcYWIoP5bzD21RdxKm7wgkrag1Ahzrk3iCR5r?=
 =?iso-8859-1?Q?sfx7zrf90KJ59JS0ADIVxADxJQVimW0vEWBCj/Y21Wl0CTYuqM2dov+vJf?=
 =?iso-8859-1?Q?Eiob/nk8QNpKe+o9NAeNXaAuPFjNCK105N5DPnipfNrVjN8IHUccaW8w6r?=
 =?iso-8859-1?Q?PselAWru3xG/lKC9xoAtGXPQ0iRBytYGUehmjCS0o88VFaRSAZjbv/Prt/?=
 =?iso-8859-1?Q?NeW3lMmxH8WLttOpAVCMx1zLyA0VJOQ3WLktYHaKWjrAB2tZLUmKcC8Gb/?=
 =?iso-8859-1?Q?EcoVNUK+h8cHK+KMfNT08MN3CMIxUqw4yi0jA3QetRwjcAfu3uzW27guC5?=
 =?iso-8859-1?Q?I8eWpZSyuSmwbwvgrlpfophxcIPbm1Sv5iFNdvxf4wwvkY14tmgB5tdb2z?=
 =?iso-8859-1?Q?mIh/ayVDNlmRvraDSyMiDaipg6klEQ1MSMZrMD60z8D/ubp2OpGGFBGOsJ?=
 =?iso-8859-1?Q?2pYRx7EzgyAn4NqkN72W7lnnOc4PAnvXwofIO7jwqdlAW2RGs8WzZ53B9Q?=
 =?iso-8859-1?Q?TNzB/cv5rwxgCQ/i+IyamILTfbtk4FgQJqAObOfgDrjbluYzyqtXFAYbrl?=
 =?iso-8859-1?Q?a7CBLboQYoxDp9+vB8IOmvts/bL1lw4d6Aq0kTHJdxK6Veqxa7TQFVybIi?=
 =?iso-8859-1?Q?zpMPD7glAJyFuTcn0lD9oOATzYVFRP43U7+P+kzxTWovV1SrqSkAYNtcfy?=
 =?iso-8859-1?Q?PRg2qgABUpVoqy5OQWq1t8YopPu4GRvTf0XwCa85Y5YHfDtNNOk3l2a3TA?=
 =?iso-8859-1?Q?NTTGqbJnQAXDHG0tGWgGUWSWI4SXZHI3aNuUhEoH3Oh6w2O5I+O9+Lj5Gl?=
 =?iso-8859-1?Q?tGRgekL1P1lazCBU0HcHgg5KCsMi7WIEx8Qlcpqm35613eXFj24iw1Oro4?=
 =?iso-8859-1?Q?6v+byQFfnwKokuYAdOXNoVMJE/tIq5VcO1LjPEANeMjQp0pcbWO7lhjZ5n?=
 =?iso-8859-1?Q?ghQTByl/Am7hKFnK34C6A8P0dUQN57SKX1AwT0UEErvKe2sydo6gmadAdn?=
 =?iso-8859-1?Q?27h3LL5CZjQymXrWKpIfKyXNnDcI9EMR+xkK7Lm/HAOrsuko/AOG6BKmNR?=
 =?iso-8859-1?Q?Ml4IdSbx5zgpaCIA5SIkjvpPKr3TulJSHtSofodv7ADXAgECggfpXyZYHC?=
 =?iso-8859-1?Q?9N7oYebSKFxYMgHWOCZZ96ZRYoyrdMeE90jr2JbD4TdpelCmkl1/zA3Y0L?=
 =?iso-8859-1?Q?0BSYrFQmz9+SNh0iTRzItKp6m7fCLCpHQOxfihgUS3EF25f7rM1Ow1Wjf6?=
 =?iso-8859-1?Q?0jNH7XaWH8vXlm+TaeV+Kj?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(36860700013)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:30:55.3763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f901b69-5c3e-4f5f-1959-08dd13af7aa6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9570

 Hi Steve,=0A=
=0A=
> > > Still should be documented somewhere. It should describe the maximum =
number=0A=
> > > of feats that will ever be loaded. If there's a max, it makes it back=
 to=0A=
> > > O(1). With a 'k' of how long it takes to process the max number of fe=
ats.=0A=
> >=0A=
> > But with other patchset seems better=0A=
> > since not only this function, but also for other functions too.=0A=
=0A=
> Which other patchset?=0A=
=0A=
I mean I'll send with seperate patchset to documents this.=0A=
Because I'm not sure documents here or in other file...=0A=
=0A=
>=0A=
> BTW, is there any example describing this I can refer?=0A=
=0A=
> No, it's on our todo list for RT. To document the RT behavior of the=0A=
> kernel. This is just one location.=0A=
=0A=
Thanks to let me know :)=0A=
