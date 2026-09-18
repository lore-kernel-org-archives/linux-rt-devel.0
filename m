Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10424FD78C
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739974; cv=fail; b=PFvrhXp80zr9jrF9lj4c1Bd78hh9rgtmBEhCP7/m9DYeFO+VwgsIKHcetedit7zfYm0gmnTDjpq07KnPODNeT7RZsr86gr6b0/oRqxtpAgb9YseW4u0Q1Ms+dHMQRnzYs43BUpwyEA2z+oevzHQP/Wsx8hqeIy19wSQJNE+INw4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739974; c=relaxed/simple;
	bh=VEeAViZnRq+6NMsowCWHnTcKrpji6y5qPu+xrhQne3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NNv2TyjdR4kTgJ+XWoC3M3JBWmnh69xjLF9K4mtwsBS+x42BMEuoLwsmZGYIPHUnkrZ+hDXyPtviHgJHZON0oNeJyAxqZQtfzHp6/ZRYvA19F4j6IRkTkDX832mxIgd7lD6mEFhuKGB0RToBzke9Yk/jGaHtaeVLshX1v27iJxo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=asNCnICS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=asNCnICS; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="asNCnICS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="asNCnICS"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=O0dgqhtteblpzGB8aIEfkzKgB35zuKO1vGhnni0jLhm0YizPkToG7SCi2F9GDCASL73GT+77KJsbSUFwQdtkh0ONVx/PmAYBqyJJts3J016VLZsoBTd/r3e762CvCAXfBuLp90ADeRbKHH9rea8mmYDBbUJhORzQ5i3hTAdm878FiRXvV0sbJS3WxwMPPabCUErjavcupn8fSAEmvxUEPQpb1aioW4tRVJzAByLonTsOy7OH0Ooqke+oj1MNob15sDjt3/oHZ8uir03UW5YQ0Iyf62HL9z6Qd1pKMIueFc5c2eVUL/6p4iV85S8w4oMMqEdpE340IKWzXyjWn3vvXA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTdY2u2Ghcgs3eF/sOQefuo+uS/qDLhDOljBhqk6vPw=;
 b=fOw8znNZCN/MVG6JPqw5Ru14SFW9LcMJ4cFhcx+TvE+BzewkCiIH7BrsHJe8Qsb1G5pWEHyGah4wstMI9NxAGa+4/K8kQA+qZ3KdEk6k02/ZQIlhOcQddHotrZBKsOCcHIbhdi019Pg7JVr4VxExajHtqC9YfCZ5OjLY2W90DlilLEl8ex0m6RReOum1HdEfZWiS3iU+vtUVLVSIBqZvGPzzTfV2pEEMx3SOzOMuCb1bDHOLxwWSnp3FtjO15fuwlW4P8Y05839SQtzNlvTtK0wHl9zK8XQuBRpzc8W3JOWAg7C80mfLkGOT4UYjInxM3s7AK1SjoNnaxnAqQwhZfA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTdY2u2Ghcgs3eF/sOQefuo+uS/qDLhDOljBhqk6vPw=;
 b=asNCnICSGRH8+oXGx6VbcCU5ccAH5XiaH0Lj7SodASTn1JbGeNHqtm30j/L1DZQRijx6vNUVIhyKCJRVkHgrxO2AcEVwJp0l/m9O2INVxz8l/BI3MvtHu/p/yo9YB3PLU1PiGY8KjM0cGKK3TQdd752mYVw6YqY6AEfP1o264Uk=
Received: from PAZP264CA0184.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::14)
 by BESPR08MB399163.eurprd08.prod.outlook.com (2603:10a6:b10:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:59:26 +0000
Received: from MI3PEPF0000847E.eurprd02.prod.outlook.com
 (2603:10a6:102:236:cafe::14) by PAZP264CA0184.outlook.office365.com
 (2603:10a6:102:236::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 13:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000847E.mail.protection.outlook.com (10.167.240.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 13:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x49rl8AyXEf/y7dJmFhzIPXp4Sq6h1GDJx42RgZIiOAqcztOCVcw/i8OO1nuGICpQ8zVuDMXbCysNxdrFcauJ2LKLg+j9jPGALiAWKZFrtkv2bFcVJ9mV7e8pLpkCy6BRLUFGIorK0WKrjs+vBCJe4suNr4yQDm4ZEvmqFQ85HW057rgxf0rm32R2XYO2H1PP3+Tp+vADyd++TlOFrxSd+zbr6dNrJ3/ZKUTBjJGwDfqWnhi0JrKIpFFis8UAp+x1G4LfFuCzw6utdGDm9M8YwjzoPJieaB1qlXCh65QEUuy6/2bhU854mAeuoUzNcliDXbnsXv/FHVKCueljfaWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTdY2u2Ghcgs3eF/sOQefuo+uS/qDLhDOljBhqk6vPw=;
 b=OAH6tCcPzgqEXpoUT2Gy2EkRveIvWeWAbFLa5qTsCaFylKpTweXBDq39PxNHUu2NKd/yKK6HG4R/Y8to0XnYYiimUYPQAgzFh71iJ1UC1zdrn+ZgbEXJhKuX3IggggSzVx6HwPa0T+r/XhjiqdcRMTGOXZz11S7Co4EawGqGNsd5lUVcHiai24Jr2tHfxylZe3MCUkBYfO94Wqr156Ze1QMGrLK8Om4NgkGf0n9Py0NQY7/3CJ2aIE5sFRbsOFuBuhiZtyx8tdAk1crfDmxkdu5MHWjA4Z4y1gnfx31wI8iN7moBIZpBm2Z1zD4og5mu4m1j42AYH8tFvHhX3g1dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTdY2u2Ghcgs3eF/sOQefuo+uS/qDLhDOljBhqk6vPw=;
 b=asNCnICSGRH8+oXGx6VbcCU5ccAH5XiaH0Lj7SodASTn1JbGeNHqtm30j/L1DZQRijx6vNUVIhyKCJRVkHgrxO2AcEVwJp0l/m9O2INVxz8l/BI3MvtHu/p/yo9YB3PLU1PiGY8KjM0cGKK3TQdd752mYVw6YqY6AEfP1o264Uk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DB9PR08MB8313.eurprd08.prod.outlook.com (2603:10a6:10:3df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Fri, 18 Sep
 2026 13:58:52 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 13:58:51 +0000
Message-ID: <ea0c526e-b536-4f91-a464-41ac862b47f3@arm.com>
Date: Fri, 18 Sep 2026 14:58:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/9] coresight: etm3x: remove redundant cpu online
 check on etm_enable_sysfs()
To: Yeoreum Yun <yeoreum.yun@arm.com>, James Clark <james.clark@linaro.org>,
 Leo Yan <leo.yan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 nd@arm.com
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-5-d2b258d51747@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-5-d2b258d51747@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::10) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DB9PR08MB8313:EE_|MI3PEPF0000847E:EE_|BESPR08MB399163:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd9b81e-8c6e-4d7d-3d31-08df158d0c74
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 DUTiABNjYS+k8nguXDc6vWf2WHGsE591PPx3zaPxA2OaJbQEGAQ29ZC2S62+KbGwTlNtd3NwI4atFbwPh8TFku2P3o/nJUdXWuHKVfHaVq1A1oXPwDILfVi6QuL9nEegTwmRMby70DaZK6cUOTpdEvED6xeCylVAufQWfQBp2L3fZPhrSDrnLNNYOK08SFgBrRrC6zChvKdw7kYeuybw04sJkNznfrvdpFomRRS3/gd1XCUcJCFwePY3rrgIC3ei65KSYSITCq3NyRQnzA+lGycPVOkitbpoVU+rJl+XkIzrkKLRCHDSgXNyoOxT8RJOf4BGIAac4umc8Wh3IqfSp7mYkhHRK/omHZZtdlwjPkmBXMwAiXu2X38Li9Q8g5tGMAJ6zjWpv71eFvwVzfntGNv94JdxSM9J0p+cMowP6lU85rqHr4uyqJzNc5L9nvAajncb+aEvVWWA1e0x4L/MXcyL/icvEHYZCpgHxvPAjMYBwD0XbbqKq0GaH+KzheraVxEszexRGuAgfAaM0oqVGF6B+zdyjKlmHYj/oldbePIRpml+4KzxIqKvWPG9NHUF1Db2rDocz1WfA4k6/rGky1qtO5DlEWuImN0mQ2IEvEq3AJHR5f+M61j/mp/aqjFxt2Qp+/8SCFRLOdWCPH1YR132davg1VgMbnNRtnb1S9o=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 iKqKAVaM2g1kWZmRPXs0oMgpewcbnghjGLlTtly5q9ahaRkE4r89kO+R0SDbj68NtjE8jnL4TKtu2W5u8ErUmmL+FiR0DYKu+8QLBi1sqK/mgAYBifUm4smmI99zUXw03zTohhn3BELGG8ZKrYPU1nJILgspaFTJhoEUU00nTXoHx1gw3ZiPmRdVcuT3gIwqX3zuF3Zx1KCmJLnCaTyVJB/vXS4MUdQkRYMtylGCceFZVmTdUMhLhnjtYyxHovxT7vIapJsZL1RB0AIELGYo2aJoesQ+h5zPBbY2mWryfHJ9+GFwGyWc1Tr5cPavYkfY5PtU1FvTYmVuEuRSlkkOjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8313
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF0000847E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	51d3a56c-3583-447b-64e2-08df158cf84c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|35042699022|376014|1800799024|82310400026|14060799003|36860700016|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AJnn9uBB97RS9DvEcvtPUejgdsNHWc7tTwBa62z9CiO4oLPQvm5iY6vIdQwHvxelt7bn/J2Xrwz68oNbPHbKP+hw1CV6cw0qfIugZ09/K2SHN58XZ95lFOUVHyliVyykmerWcyXNgla4WKHYtdvbkxgtxi0W+WO94OAzhXBsmYu5oEINcHmmyr4Ju18mxJwqqZaANX8Uysd88SNI1rBQ0MXTUZrnDOfcV6pIluaDMx9BHrLJWMHSY9OlBnOq8I0zMJlU+9USmMolEc2YL/Jw9F7ipRS8R0mcKtSfPabjdqU8ILwuIl7wVKUPdLHmLBh29zl4KlQLdbbDGCUT4qFIMchycITS0RE4PuK/5i1z+yDDDroNJNw5/RoYb/GYaDftc4rR/cTSsZJ2nLssHs/CQ9GFIibo0gLY7o2QKblTqSpFj4t9reRee6CefjbFptIEMjVaejSrEYObyaXUAuEZcMBcalzbhOAeEiaalbAo25JKSk5IZToEsghNmz0B/hn90MF8gcSCoa2nd/cVg1NQj1bn4U1SVVe+DlRlcGjmulciQ6uI/x0BkF3UvyAsY5QiBC7JFk6q8kFf5+qosSbJPab82XeizwvSgkv3oFfD0B1371gChI64kCuR/3DJlcpl2L0VccUMR9yA/N9MvWecwLt9amseChn/q/QpChzOjOtiZInnWAENr/ysQWOsOuWJTMmYZZ6Wh2w9pR9W5EliKw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(35042699022)(376014)(1800799024)(82310400026)(14060799003)(36860700016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jb4cGIg8QiamqKu8Qwn7+/uOMC2rnJBUFamx76ZqFoMGNvlikuTpgLswIO/oziNqLzp9ZgeSBsKDl+g/j8W0+pb19GTV29r/6YiLfoYFcAdjPtv6HUAaQLWEcvegVoBftRoe8v8/Acujv+GUAFoGvelMeftmcA57dY4pwF6ChmZX82CAjxq0jKCvfqKVgyK8ddqAhzYBO8/bxGnlm39JIQ7EFQVgfLBUO59BWHIUoE7NuDrTD/TnvvJg7Pm/zx+mcLdg0W+LvKTtFVvL2Vg3H/mXK0PndJ5TpdTw41YeIxJGLJcgmMyRlg/Vgf3sO4NDHWQijS3/0foGY9i/lmeh6balNGPqHhrnGIHWbUmYbR4MqPwkT0zYKL8ljmBbrZiv/hFTuofdcK3XUmqx1QSnc1sYuftaFm0Xl/3xb45Ma4kITLfUXRh7X5aoN+6ZoYZ5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:59:25.1809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd9b81e-8c6e-4d7d-3d31-08df158d0c74
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000847E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR08MB399163

Reviewed-by: Mike Leach <mike.leach@arm.com>

On 9/15/26 12:34, Yeoreum Yun wrote:
> cpu online() check is done in coresight_validate_source_sysfs() already.
> and smp_call_function_single() will fail when cpu is offline.
> 
> Therefore, remove redundant check in etm_enable_sysfs().
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm3x-core.c | 26 +++++++++-------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index fd76a57e5f861..12bb38dc596e7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -515,25 +515,19 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
>   		return -EBUSY;
>   	}
>   
> -	/*
> -	 * Configure the ETM only if the CPU is online.  If it isn't online
> -	 * hw configuration will take place on the local CPU during bring up.
> -	 */
> -	if (cpu_online(drvdata->cpu)) {
> -		arg.drvdata = drvdata;
> -		arg.path = path;
> +	arg.drvdata = drvdata;
> +	arg.path = path;
>   
> -		scoped_guard(spinlock, &drvdata->spinlock) {
> -			arg.config = drvdata->config;
> -		}
> +	scoped_guard(spinlock, &drvdata->spinlock) {
> +		arg.config = drvdata->config;
> +	}
>   
> -		ret = smp_call_function_single(drvdata->cpu,
> -					       etm_enable_sysfs_smp_call, &arg, 1);
> -		if (!ret)
> -			ret = arg.rc;
> -	} else {
> +	ret = smp_call_function_single(drvdata->cpu,
> +				       etm_enable_sysfs_smp_call, &arg, 1);
> +	if (!ret)
> +		ret = arg.rc;
> +	else
>   		ret = -ENODEV;
> -	}
>   
>   	if (!ret) {
>   		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
> 

