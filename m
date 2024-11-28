Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2066.outbound.protection.outlook.com [40.107.247.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C24313FD83
	for <linux-rt-devel@lists.linux.dev>; Thu, 28 Nov 2024 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732775996; cv=fail; b=R463FiEpwvaNR39PAZzgrGqAkX9tdew1RDmGHjGRQYHRPujdbnR2tpPBk4rFmoD5hfjhj+ckdr6QUcZP9g34tVgWrNqPMN+6/YS8lTHokXTrh+ACb92xFXfC55T34W9LnyXdUugbdBHZLZZmmMqztOUX5ydE6c3IHpgJh5uSUAA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732775996; c=relaxed/simple;
	bh=+aoMCpH356omVntog99tdxpr0Qy2Oe//iOD3wmNq6UE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LmAFMlbi42h4g04ZMVJTQkivZtxmDcqaUp1uEsZuG8AnP23yGQxVkjYxTmoQDjyx4BkIWEpy8XPUiNQRFsSSEPY/Cw64KwIJjBKxbkXFxR0l0eoSl6Rwo6wkcum76R7RvSKGsFK9+IKghkhcva+WsosNUpsFT1C+PSDdCsRE49Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MeuUQIMZ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MeuUQIMZ; arc=fail smtp.client-ip=40.107.247.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MeuUQIMZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MeuUQIMZ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dADgdrFQriawSBtQVmIfIc9769gnUlY9D2p0sVIyi0FcMMuORuWpQf0ax/2d48NLQnHne7+IzF+VfBSoi8I26Xd3vxlPleFA3mhdOAOJW3l4+Z9EnXvGOlKjMgEeyX6K0ma8UP3VhpmbK0/QaukU5vCwTjhba+M/PUKVjXUPpkHFIN/PQ/+ag97iwDpR7TvklbUMmNjDN/lEUpWVQpMvrk8ie5PxtqRIvcgI1pmaPORDf6neza5MhQMGWIB05kkBr3zjP9PYV4MNqaUbQccqgQ2eHOH/bk5PsYd5ppX2z07dBpI3T07c7/+Xtt+JmDA84XnWUVSD2tJNITJP4LeCKA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aoMCpH356omVntog99tdxpr0Qy2Oe//iOD3wmNq6UE=;
 b=t9WdwtmexO2L7JEx5F9Cp5ImOSc6CfX/5brJOcWrpWbv2gSkh5Cn2mzyYa2x+CyKKjbnk8mufDzI9L5V/bcsnmpKevEY/2UkEDsaOzkpYB1QynN2w8xt+PFWsv/bVQU/mpFMOEJnrnPVCxSGSBX4MmDuAgPhy2caMV1LldwZ3JNlXelbXVlZ+kN9wXnHQ1Z+VTHaA/mRSXE8WD3HhmZHkCmuswhyvYwU8G7FpgokJoifPaLMFjz05UWXq2AWNky4KY9qF3EXLDMEwqaIB+Eevlx23thq1ZYKldrkx8+rrjGind9dZReRnswMF7nzDfjGPvDd//aRBA21KRkWzDlW+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aoMCpH356omVntog99tdxpr0Qy2Oe//iOD3wmNq6UE=;
 b=MeuUQIMZ16CJQsqbu4hQsycbSVRyxIDeEA3gIB4GYUdb18gA1aDFGu5AZmb7xUWdRjIwWkORLbhMgwqALvHYdWP0MF4hMxPkKwbivlnL3j2iabqNnq49s2keINQ8z+umYbqnZD/Oq+SG2KqxEEe2Oj/4WtI3g19Pey2yP5KrGHk=
Received: from AS8P251CA0015.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::14)
 by DU0PR08MB9902.eurprd08.prod.outlook.com (2603:10a6:10:476::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 06:39:48 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:20b:2f2:cafe::31) by AS8P251CA0015.outlook.office365.com
 (2603:10a6:20b:2f2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 06:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Thu, 28 Nov 2024 06:39:47 +0000
Received: ("Tessian outbound 2e0b2b8680ec:v514"); Thu, 28 Nov 2024 06:39:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0c8a664c0d5c8a9f
X-TessianGatewayMetadata: nDKixdBfzbXPt2+Dz/zblatzw5zj+6We+y1e7I5vZOj334c9psx2Oum3VZ2hC/+mMbfVZY0nrPIIk1iTkiQIo0J8upEr3wKk1ZLmAqL1vPLg4S0HQ1aE1rfAPDmUK8hvrp7XYejvV+sPWdDTvvBsnIUFxeB7wWFb6IxHXsBuK9KBxwxNpbx9RORngiuSQQTOnSpcsGM9a0ThLUAG/zbfAQ==
X-CR-MTA-TID: 64aa7808
Received: from Ledc7acb6e79e.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 277FAB56-E488-4395-A830-6F64534C8C99.1;
	Thu, 28 Nov 2024 06:39:40 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ledc7acb6e79e.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 28 Nov 2024 06:39:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUxd2ffbSk1RcRpoQ6r0kmBPL+Dhuu0dsXUPH09VVWR73wBfGBUQfagYWLrhysg1BXoqom/YXBnUYbYfb64jzmm2G+rRD2EMMp/AP+wOV3d0u/QcenDyzAnj1Yt+GnsUUzsu/zoCeD9F+SJ1KdBQ8yecWgVuffwsTjGm/iLEVFyjKqVH0Z7fHdkKdIw6/1AfbHokyCEOTlCDwu0cucZtQudgA08SjTyToHu5uDYmqZW+xFslT/J7f0fu7fVBvxudJB7qRiDEIdsMRnXt237dv2Cc6T2gRFK6X83K8O6+XjxkIZmrMKZUdFYwS3nniyD+Td/fKvKa987Rge1i3spDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aoMCpH356omVntog99tdxpr0Qy2Oe//iOD3wmNq6UE=;
 b=A0YdpnOplac/vnH0ZtOGqWa3mgY/3Ad7GNhLtfHE3MkeGV4f+p6inPbj00w60pqV0AVBqvcyFIaR3eC54erFkL39FCK/l/VmbrYZbfg8+0ozY1fkkoDnX5tZjB2Hio7St622yC/zykY5B64uTRloY3kfMazkde0xfM0FviFjC55VyqvFDZFDG1eVYnWxdz/9Q0ZtyTlJB8UNtKsalktkQUCJMLpLANzd4SRd+adzwnmJm3bopaNOAqkfn0iP7eklGS5dA5fMa3VKHqDSp7B3LHbS9njVlKCpikuyvitfRTT+R25PT0RSSCQE/3YOIXUujHM/dJMOdGXaHtNbQCcT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aoMCpH356omVntog99tdxpr0Qy2Oe//iOD3wmNq6UE=;
 b=MeuUQIMZ16CJQsqbu4hQsycbSVRyxIDeEA3gIB4GYUdb18gA1aDFGu5AZmb7xUWdRjIwWkORLbhMgwqALvHYdWP0MF4hMxPkKwbivlnL3j2iabqNnq49s2keINQ8z+umYbqnZD/Oq+SG2KqxEEe2Oj/4WtI3g19Pey2yP5KrGHk=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA6PR08MB10394.eurprd08.prod.outlook.com
 (2603:10a6:102:3c6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 06:39:37 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 06:39:37 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: James Clark <james.clark@linaro.org>, Suzuki Poulose
	<Suzuki.Poulose@arm.com>, "mike.leach@linaro.org" <mike.leach@linaro.org>
CC: "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH 2/9] coresight-etm4x: change etmv4_drvdata spinlock type
 to raw_spinlock_t
Thread-Topic: [PATCH 2/9] coresight-etm4x: change etmv4_drvdata spinlock type
 to raw_spinlock_t
Thread-Index: AQHbPx84d5utnNsCpUiY+BlleRX5/bLLVRAAgADqXZ0=
Date: Thu, 28 Nov 2024 06:39:37 +0000
Message-ID:
 <GV1PR08MB105217A184D21CA8FB7C4E6BFFB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
 <20241125094816.365472-3-yeoreum.yun@arm.com>
 <ec11e7f4-ed82-44eb-8e72-5a5094b67cda@linaro.org>
In-Reply-To: <ec11e7f4-ed82-44eb-8e72-5a5094b67cda@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|PA6PR08MB10394:EE_|AMS0EPF000001A3:EE_|DU0PR08MB9902:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3d564b-7cf4-426c-04c5-08dd0f777402
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?TyaOWIBDWP5f1X4iP31vTe78XIyhrT/lUJ5oN+qX1w0IIIJenYKP9DL1Cj?=
 =?iso-8859-1?Q?KSB2go9yGSXTa8cKqxaRGJ1RUxBizej+v1PzzuDkkRCBtnAB1JNRyU5lDT?=
 =?iso-8859-1?Q?JXeKYbRLJm8fw3hvvgaUYUqk7E7NaU2qVLLq7cPGtaXLZOPTxvMxAIyvVR?=
 =?iso-8859-1?Q?/7+tWLHfetfCkMPOuoJeRtnoJBHkWCXtd3JWp8pXGKo9X3AyqsY8+9b6WM?=
 =?iso-8859-1?Q?qf0z/feGvCILcJ/rXTyWbS1fY6dNnkuWbfkko9+cnOVrD0BiUyQVtMqrDQ?=
 =?iso-8859-1?Q?mpEX2xqULEEhqToHkDEa43IPrkkzYGfnjZaImPxkmkrfQhZlyReRMhyeg+?=
 =?iso-8859-1?Q?auGan4fKdBOLkhFOmRvjnb7+xyVQNjvtDcMDiHc81jLe2zB+axcfq1HuT3?=
 =?iso-8859-1?Q?/zFSqG7rCTj8Bhvajg+0dZXCDmrpJgFFuWVpUvjmcveYUBfH0VRqyhe9gh?=
 =?iso-8859-1?Q?Azt+2uTYn3bK8AIv1u7Bd5WcZX/nONYdwS/ZBA3nzXuTN7+yydQjY6CcsZ?=
 =?iso-8859-1?Q?VUYxS7Qf8YvXy+Ah4ND+3+QgcEw5HEAIYTfuOqBZC7v5wHWjJMM0E8fkfX?=
 =?iso-8859-1?Q?xWqmE8c6u9B3OtG3DHq3SwRtu93TYMbMCH2fAB4mkcYqgGSTeK56qqB8ic?=
 =?iso-8859-1?Q?79deC3T8LHH4RD+eL0BexsTGhQ3VfDdWEBn0Ke5T1DeddOtLbeX1smQWUx?=
 =?iso-8859-1?Q?ukaSFdRB+JTruRWnxsRmLwgZ+2RCo7kzomPl1rN5uolt3vcGLX5+3Sb/rP?=
 =?iso-8859-1?Q?8NvFQx5qiMItQykZxwzIALElicuDRu7LAA4qBeigsOK+zIwYEs4SsGMJDR?=
 =?iso-8859-1?Q?/gxNiBKl1fMXblxkPnDw97oDxhhlOamoMi2KwXbY693YuJGN3iO084DPV9?=
 =?iso-8859-1?Q?olFYUlLjmgw03tIRZ0kKbRClMvQC+6nmzWgRW3yTjw+5VMcaXUdq8GmXs6?=
 =?iso-8859-1?Q?UUwqM8XflI/4PQ5iAUh0KWzJG24m2ddRUgb0WVXNZ1uNTKffoySV5ySVzO?=
 =?iso-8859-1?Q?8/cX7hmVq0ZCY3JRS3jLVeKvS+2JqtucpnLxeh4nI4PzhsAvPXrxkIUtYn?=
 =?iso-8859-1?Q?It+hZiH1yXGNE1CRcsj+hXpG9gWYGwcRx4yYldsvDLq0T0DMoI6/6B2lD3?=
 =?iso-8859-1?Q?wzWHgAj77PDNJ2RVgLDKsaZKfxMGrIrtQYLLU/DoZBdApIPawp7TCJTDww?=
 =?iso-8859-1?Q?OS0qcH+gcukOaHVkOk3f21Q3AH41XKO+wtvdyYHxo3GlfaKZYbHUpRKL+U?=
 =?iso-8859-1?Q?/7YJAQ2Xxf94WPh4NGE/aJQzlAGcfuRvlnI8HfNXhBBPJnRVcBn+vIVrxz?=
 =?iso-8859-1?Q?dchAAMHGAStj738q+pRyW1Y21KjMT54FXAEG6bFV/0ZpZKPTORf+N4Ceun?=
 =?iso-8859-1?Q?ls6lVwM907H/v1Xf2ynf/VIkXAoYTl481Ymeh07ZiNAtP6BXYTl6iIpQ7o?=
 =?iso-8859-1?Q?1qgzHihtxs7WAflK96UuoTGHvvDC6dXyPdpA5Q=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10394
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1a37b7eb-48f3-43ad-9a13-08dd0f776e0a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|376014|1800799024|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Y6VJssDtaKxlO5mS0lXgqS0bLjTGunqOPysCZu7HEwDdYQp3r9mThrqes+?=
 =?iso-8859-1?Q?qzzkg1X0bdtFZwHKDA7tKZD4J6iLMkkyNLhosRhrohDBCHbt2/haFkAm6S?=
 =?iso-8859-1?Q?tp9zO5kEVuqPdJTZwh+YKg0+VyiPmZKpFliX626OHxaMl7z5ZDUX09KgAj?=
 =?iso-8859-1?Q?tZEcwAdwNLH7nQuQ/KfLMOU3YMyxeE53zDqQUZYVv1QeSkxw4OTqa60nRp?=
 =?iso-8859-1?Q?Teynth/wrK80S2HNWaMp8NIeDtntSIox7NZRPqAdmgaHMqAxfuR/txct/U?=
 =?iso-8859-1?Q?mznaU7vsBoVOVvqYNUz6+o9tBcs4h31OIkRMtiiNxKER53H2LEhGPvPG04?=
 =?iso-8859-1?Q?lRLpkhvZtL6CJdukM/bJl9sSq07LEd3IyIJlQXOhav4+1AHHJb1anlIog3?=
 =?iso-8859-1?Q?xLLmrYHOR6jUg/llTDlVplQi96xZpziJJEeNrixweOGOeQObJeBurVodTm?=
 =?iso-8859-1?Q?Z/FLDWenx5UNuwJqX3hsg9txBo1H043JiQ6ysai2F3dLGVdrLOb40zv7Cn?=
 =?iso-8859-1?Q?Mg51Jbhv6AZhpuP0L+EQ+2RJa29GsDdlU1mnLq2opE5TC1H42bcxhqqdu6?=
 =?iso-8859-1?Q?QzhCZlWPJOi1otpJs3aQPlGYUcFp3FC2kvnw2V4vfQ62GsbNn3AG0hggXw?=
 =?iso-8859-1?Q?GSFkMOlqhEDZrmqPy3tx7feoPLU7iMDHmkFmK9G0KXjlVuMi4RGGz9T9+9?=
 =?iso-8859-1?Q?WcinAZ3RJS0qI0SVGXi8VC586CSYpR88l2ovOhnRxMm6KFybHR+3u7qXKO?=
 =?iso-8859-1?Q?+Zl/yjvXYVen2hC4zbcxi6+484iGM6GxE2z9w5s+3zJV48aFnFaAP4ozOi?=
 =?iso-8859-1?Q?X9NXzi/JyLMZ7mjALrfNy7k2d0iTAC0cRnXFzUAywbznT+U3CrXMWA/Inl?=
 =?iso-8859-1?Q?3vP4eDbEUF0BBjjDLUMarI/teeJ1lqT3PRXm7NMMOTpD1fVYghg2B5V02H?=
 =?iso-8859-1?Q?opbarMXxVT3ZPXceqaNAIIkmu3eCRUaJTHQQVrYHzY/NlqnkQEY4FSn3eg?=
 =?iso-8859-1?Q?en/Du2DIdXeFjrudwZ7TepFCNlpkRY7gLCY9wSxwaJ1TMkkw7hJ9Eplz4c?=
 =?iso-8859-1?Q?thfcM5ObsCcZnVvmqU7X9ulyt6IfpAbJX8s/jSKDzeQUjz15XRR0c4843E?=
 =?iso-8859-1?Q?4c2TGnpIZD/8BhtUL6PaCTg8weAGnf73WQziaHOZEKtHN0oEqmLuo753yj?=
 =?iso-8859-1?Q?PZhzPaGx3guREqCXHpTKCCCpcvQr3zkxZ2r7a23B/9P4zL/4OcIiTac11j?=
 =?iso-8859-1?Q?m1TvRz5Xo3W3W9nS8XIQoAN4kLETU8m1MRvjjatoxaeLhBhTegeFX7gzor?=
 =?iso-8859-1?Q?9kXTkaNK4swMWBiBNRRoAMlynCSWO2QhSvmHvmABINWurX6l0bb+JbEPdZ?=
 =?iso-8859-1?Q?uHlUQqXLlIpv3H4H9Jg3WZtde2E6weeWONQEXrNh1TEmAvTGFwe69EOBDP?=
 =?iso-8859-1?Q?JosWTiLcw8VVK2pFmUylfR3U9z03gfAfreii6pxoql+unCJH0hpu2LK9nb?=
 =?iso-8859-1?Q?0oa2laASQnNolpaNnfr6uC?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(376014)(1800799024)(14060799003)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 06:39:47.7823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3d564b-7cf4-426c-04c5-08dd0f777402
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9902

Hi James,=0A=
=0A=
> There's a lot of churn in this function just to use the new scoped=0A=
> guard, but there was only one lock and unlock anyway. There are a few=0A=
> other cases of this in the whole set.=0A=
>=0A=
> The scoped guards make it easier to write correct code, but I'm not sure=
=0A=
> we gain anything here other than a bigger diff and more to review by=0A=
> changing already working code. Having said that I did review all the=0A=
> changes and I'm pretty sure they're all ok, so I'm on the fence about=0A=
> whether it's worth going back and undoing all of them.=0A=
>=0A=
> Surely updating to raw spinlocks is a search and replace to fix a=0A=
> specific problem, and the scoped guard stuff can be done on a case by=0A=
> case basis when anything is re-written in the future?=0A=
> =0A=
> I don't know if we're considering a fixes tag, if PREEMPT_RT is 6.12?=0A=
> It's probably not necessary but if so we definitely want to minimise the=
=0A=
> change.=0A=
=0A=
At first, thanks to review :) and as you said there's no functional change=
=0A=
except change of locktype.=0A=
=0A=
But I thougt making seperate patchset to change locktype and=0A=
apply scoped_guard to two patchset makes people do duplicate review for=0A=
the same code and almost same posittion.=0A=
=0A=
Since there's no functional change and reviewed,=0A=
I think it doesn't need to seperate..?=0A=
=0A=
Thanks. =0A=
=0A=
=0A=
=0A=
