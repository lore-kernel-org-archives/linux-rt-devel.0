Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F54F3EA0
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679375; cv=fail; b=cRSdyp2CqCnFafrznH3eAOqA4+0RB/Ae1l7k3WDXUAosNQWM6nKIn81Y87Vu0D8IjmwKSKEmOGwyUrOQgDP91BBCZxINwa2ug6dnzqJoQAhSDz/7PpHBJZ2h4WHRG+e+1CqUBxhtkKRAGOw/cvD+ag5n6lU5feXOZhipxiolDQE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679375; c=relaxed/simple;
	bh=h06yW363JfnsywJ9kC59GBQxYGToUAxy8kOhbfeviss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HLgb9CdtLeGEfj9+tU/s7D/USFBGqwsn/N8p1Fbk4GrLDWx/Z4ugosDmQy9CgnRzYlLrzDvMnhvMAheE02xDW7aScePqpNj41WF6nykKxY9m1+/iD7aIa2FQ7sATBIpWCsoSAz0W9n1YVxymO1rgTEZb1BepSfxuqumYdlDPPnk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XfPL+IQ1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XfPL+IQ1; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XfPL+IQ1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XfPL+IQ1"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QtuzAtZ7DKQdbI+SCeVUCS8YWOr7+uHpX8/HSfpZhS7eMyCkNKPsEeD0UsFL5+xwhHml3kFi58lqxQimS6yJn/22WjucunoHqeBY7YIOmp36INORpm1V7M5RXE++3fYboL0pp9qUDs2bC/kHEfZTiD4pQ81Gr/LAT0m0rATzg8XChXpQJhAkrPXgWIYDJkpLiU6197mmGu+UZg1bKcO1IK92nClcvHHcLw6Za+MwvReOrHBA3zTI/neEoMyqh2jwGMu4gxNV68OVkwEFvaCm+MldPSacUc97iDTuCpvLYvLsw3gTTqm8IP6j48Fp3LsKoc6Ck6Y2k2vX17S68Aa+kw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEHUGDmftIGfRHZ3lc31wh5SmZZFISGXeJdgmD4SkMU=;
 b=vdYfVODn2ZfVyBihELzRE0rewKp9IvWoVpOWgNgSplWxK+ga37BImSmOQDWfOEHa8LBmlM5Foew3dxKuOZ0s2nTDFQczC/T8Gmw/ZvSA7k6yf0rb8K8qlq8ZvxJL3vfZecRKcA2RcL3oUX+ACnmgQaC3y9vsUAT5ZBhDZ7em8zHq9lI2yofa4Vbjo3yQpRgIT5bC33eneZUO/zhWQfGNslnN9oZ76IVQRRJYtpBZf7fOR7N/YOSGg9zIWDChkNkMyhxVdX5ORwAO0A/VQGnaYWwxXOlaNOJvRY/1iCl0IBJdz1FCYUcQ+9XRy3ye+b0EfxkXEHbhICDn4082z6J3dA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEHUGDmftIGfRHZ3lc31wh5SmZZFISGXeJdgmD4SkMU=;
 b=XfPL+IQ1boQfEOl2GAHS0H664x4o02K+DwWcvEzsxfI4H9q18oTGjnK1DiKDpSvDTOX4b8gRHt/1TN+GmvW/SijXYoJqQGp4d7/COhkRL2uk67G7npVOQ2Ic9age1++/Waiv/MDupRnNvuilPhTAuEAlJPMSfvnRav+5tIP4oX4=
Received: from GVZP280CA0032.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:276::12)
 by DU0PR08MB9027.eurprd08.prod.outlook.com (2603:10a6:10:470::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 10:56:04 +0000
Received: from CPH1EPF00000526.eurprd05.prod.outlook.com
 (2603:10a6:150:276:cafe::4e) by GVZP280CA0032.outlook.office365.com
 (2603:10a6:150:276::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 10:56:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000526.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Tue, 29 Sep 2026 10:56:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftofFFJ+N2s7s79Vnfis1V0YjrekEWXMoOSKdsrMSrHXbSSu0eN+fZs4xJTYFGP11JwrXuW51vNdrTBDiC1ymMFkPgfO/eaCbueAqw7+MXCTl4R3HSTCav5uIkG97TrHhzaH6GhpJG9eR2pk3Pxo/O183caujTCyeDdLMHD2t/th7gOgg9Jk0J1ZKSu7rLZLeWNEEtTM/mnPp0tpJ1mGTRgIHEyZpP47fEhcI5TFX+s7pNM62vGKFW6TSWv4RFjxORvUs3YNkSk2ThANVwbX4UTsRC+D90LKbak+w29KJDjv1usJjHqqigzRiQi0QIxpiRo4JoYi474KHcN3Qtel+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEHUGDmftIGfRHZ3lc31wh5SmZZFISGXeJdgmD4SkMU=;
 b=CEzR+paYAGlswRJSHYrvgJrVUxkBKkZklBxmaat6tCGIamqSg+2ylyHzri+mb/pfXb8fSuaFvgAthExJ/rgl2wB1lQ++MTesYaDBNZZeZhfEpuy+DIWxsE3oUPV6V7d+YMQCobpbRfc5gD/aHwMWCh+5EGWErPh1k8pdUD/794qVhhpQ6xKSwipe5CQJf0Qu20xKB+Pyfx9vHdmO91Y57jDwUgN2iQq8j6VKvTXCgRVlYYjL2wV7g02nbnmVmmNutPjqc2ijtNChdYe7ndYwKKDBr38XXWdaOAcngUPBeDe/Av1BPzD/IMhw7z7boAcN2bpTTVbZUf8yYm0k80YdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEHUGDmftIGfRHZ3lc31wh5SmZZFISGXeJdgmD4SkMU=;
 b=XfPL+IQ1boQfEOl2GAHS0H664x4o02K+DwWcvEzsxfI4H9q18oTGjnK1DiKDpSvDTOX4b8gRHt/1TN+GmvW/SijXYoJqQGp4d7/COhkRL2uk67G7npVOQ2Ic9age1++/Waiv/MDupRnNvuilPhTAuEAlJPMSfvnRav+5tIP4oX4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DB9PR08MB8386.eurprd08.prod.outlook.com (2603:10a6:10:3d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 10:55:29 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0472.005; Tue, 29 Sep 2026
 10:55:29 +0000
Message-ID: <1550cc8d-d994-44ae-a93d-28f06416db84@arm.com>
Date: Tue, 29 Sep 2026 11:55:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 13/14] coresight: etm3x: rename local config as
 curr_config referring drvdata->curr_config
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
References: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
 <20260924-separate_etm_cfg_v2-v12-13-a2b41d2f7c2b@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-13-a2b41d2f7c2b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DB9PR08MB8386:EE_|CPH1EPF00000526:EE_|DU0PR08MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f31156-c347-491f-882c-08df1e184165
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|4143699003|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 H9Hv6kcfhu8dcww086vS/Bissy1nBObq2qgCaCOmDhKoiAShfZaGK6kDT5P/Q/MqTs0Go0sm8TAfx1GiQ5VK+Hune1RP8ZliB1HgASKs284GhTIlcr6JGL9iHph+BPXhgM6Mfvm/sNnLhSM7ddUCG5QkXOidyhrM8tKL/MleOcWL3s4kxBg1x2dii0YDtYwJqlCaOGbKLGKEl2snKHcS76o9jeJw3+9XurwyNAm9c4zcxCDNosDUqsnhn16PEIPoxmVCGegXSgf1ZSuXM/wXPNIwSbrsjwVF2QLjtCon4LcnQ5OA6VaglMGRu9vvJABDJKNJUqaPfTlPOeVJkEUlenNnPkBNNWIrkl7cCm34xjzz+/eFeaWOOyYGHWzXqbDHDHfWKAfzYnbJZ5pHRQxWjnGJVdNF6FSTm8lkYOQ4cdbtgTI2wWuZvMp5/0Ec7OMfnxzeeWh/tIFQDTZBYxuCQz2uBnlVgqZq6KL4WaS3i9PSFD647XwQLSzn9FetqqxDmTuwVlZqt523uGa5iywMsiMLraspOI0sQ21ruIVNhxQaFVvu7JGc3i2Wm2FLkdDQvktVPgc28oD8qgLjTX3MzTi83FU3VJG/l0RUJuKw16vvetoaqar/SWZMm+yxy2rjVe4YogrNvYdJZoSpV0ed5G8JyBk/3C1/qYaKTV676WQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ArnsdGfuWXXU69hAhqAXujGAx0S79lE3xHaTRncF2EPy6QldcOQ83J+t/J7XY808Gs5R5OBTLtkvhlb8YSiaYNTnDU2qlsgRRRZvfYPPqirMwNvr3/E8vEzEoHA+xFRUS5S2T7TZ5WE9JtcqO+6FzDdcM9fItNOfRfuV54Fuv2ZIR8EQoxRtawDx0n+NlQIRTQo/36GY3xq5iQ+QXv1StBK1MYSxTJSjV05zGgHgq407vu5UHOpMtgP06TySSnyYQtjP7Ft/xZz1ZX5WGEM4KCBgtP9fS/9MomnaIElRCGNzsUCDPzddpfM2UI0H+nftc9SFGuneUlwaMS4Sn5BdtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8386
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CPH1EPF00000526.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	83b0c249-7db3-42d2-b219-08df1e182cbe
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|35042699022|14060799003|376014|7416014|36860700016|6133799003|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r+dShs8IitGUyencGfO9PhYimDs0PjY+/PLSyN39Mtl19T7ElFOXx3rEuoiew7kwJ9rfaSYCbTGmabiVRxtLTveP+MGZo+nXngetstmFgprWLJrQQ/pkcWFgJMHh4Y8RzdixSze9invaKfmOPZHOnpWrSr6y0XtQpQO3kZRKwvtgBLB/TJKyQK2ZKib+nqC/ihFcjvrcNdpXR5bMKBWmNptljvUr95UJKl9LfLZo121dK5K5xO/2u00qgaFcZmgc4TZPAMm99zZFoHtCVqNtqAK3xyIftdh8RbttN+a/zd+NvAwI0ccVKEMppZCyJ31sWSJbZ6Rctjj34zQ2ighvIF/7U95s5hyroPiLoIHPLFWypjGHCuNIdcwF/BELzugzUVzj77sZ707z3OYkR0ApQj+v7SCq8x6kggodtKIDghKoYLsyKWM76BVvTK3NGy1YogAyy3V/TT0PrtDq66/dKBlx/RfGYqGgrEKctxJuDgPYVIYpKYT7+4B7CcrvpcLDgU9WLsU+JcsHGsLQo2zPCNWQAmxmJcVE4q7YwGyE1JBtOuTvk78ewZ0PeuANYvoEA+lYzgAwyIJs9kU1SDKGZzWUi+IIpY/DQDj6tbu5VHtN1up5eOLR/FtmkIJ/sHRGu9qyq0z1OtU50LVyaI648UMS1CkQP7PGibPMEWn+GqAsZNtHW6QZYEAws1GB8XGZ5VG74FpFI4EaFFp6qszkbw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(35042699022)(14060799003)(376014)(7416014)(36860700016)(6133799003)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jAx5SaVZj1RmQ6UsOKUIVLXokLwDrdWZXrQsQn5nF5P2VU+jSNz1P2HWViBdYcc9cmhFtqNO7ZGyn+tGQU5+m9wGvskpr5G0P2FGLE6A4sSCsYq2EIdd8nHVsWxytSHmZxadfF8yXkJTo/JpKhFDCKQDb5y8jJ3or4sRmioD67Bmn9JVS7QWsM4bfO/r0Z2UvVWHve7/BZhOZiHR9yb9QYWg0/Ir4dBdqX4sI2iXr/CZhlYEZbf0lg9YVy8hj9Cg8PxVBFsw9PXqFt4mI2cI7kjmTJOgMqFj68zrMHy5f1b/CVhnRqJSJjhpi0hSFmkNaFE/tIeTiofUji9ph3wkfTqbgbgrOZnhTOo2rftPusULk8jMK4NlA0g9yL58ypAwfoanEFw4MqJTRtqFNxkM0pmd7GqjYtmS26n9B1JDIqC67j6vgnn9T0myf/uFblwJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:56:03.3559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f31156-c347-491f-882c-08df1e184165
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000526.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9027

Reviewed-by: Mike Leach <mike.leach@arm.com>

On 9/24/26 18:33, Yeoreum Yun wrote:
> For readability, rename the local config variable to curr_config in
> places where it refers to drvdata->curr_config.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm3x-core.c | 76 +++++++++++-----------
>   1 file changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index ca2ba179b6fb..0cad9ecb49b6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -309,7 +309,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>   				  struct perf_event *event)
>   {
>   	const struct etm_caps *caps = &drvdata->caps;
> -	struct etm_config *config = &drvdata->curr_config;
> +	struct etm_config *curr_config = &drvdata->curr_config;
>   	struct perf_event_attr *attr = &event->attr;
>   	u8 ts_level;
>   
> @@ -317,28 +317,28 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>   		return -EINVAL;
>   
>   	/* Clear configuration from previous run */
> -	memset(config, 0, sizeof(struct etm_config));
> +	memset(curr_config, 0, sizeof(struct etm_config));
>   
>   	if (attr->exclude_kernel)
> -		config->mode = ETM_MODE_EXCL_KERN;
> +		curr_config->mode = ETM_MODE_EXCL_KERN;
>   
>   	if (attr->exclude_user)
> -		config->mode = ETM_MODE_EXCL_USER;
> +		curr_config->mode = ETM_MODE_EXCL_USER;
>   
>   	/* Always start from the default config */
> -	etm_set_default(config);
> +	etm_set_default(curr_config);
>   
>   	/*
>   	 * By default the tracers are configured to trace the whole address
>   	 * range.  Narrow the field only if requested by user space.
>   	 */
> -	if (config->mode)
> -		etm_config_trace_mode(config);
> +	if (curr_config->mode)
> +		etm_config_trace_mode(curr_config);
>   
> -	config->ctrl = 0;
> +	curr_config->ctrl = 0;
>   
>   	if (ATTR_CFG_GET_FLD(attr, cycacc))
> -		config->ctrl |= ETMCR_CYC_ACC;
> +		curr_config->ctrl |= ETMCR_CYC_ACC;
>   
>   	ts_level = max(ATTR_CFG_GET_FLD(attr, timestamp),
>   		       ATTR_CFG_GET_FLD(attr, deprecated_timestamp));
> @@ -350,7 +350,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>   	}
>   
>   	if (ts_level)
> -		config->ctrl |= ETMCR_TIMESTAMP_EN;
> +		curr_config->ctrl |= ETMCR_TIMESTAMP_EN;
>   
>   	/*
>   	 * Possible to have cores with PTM (supports ret stack) and ETM (never
> @@ -358,7 +358,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>   	 * - trace will still continue normally otherwise.
>   	 */
>   	if (ATTR_CFG_GET_FLD(attr, retstack) && (caps->retstack))
> -		config->ctrl |= ETMCR_RETURN_STACK;
> +		curr_config->ctrl |= ETMCR_RETURN_STACK;
>   
>   	return 0;
>   }
> @@ -368,7 +368,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>   	int i, rc;
>   	u32 etmcr;
>   	const struct etm_caps *caps = &drvdata->caps;
> -	struct etm_config *config = &drvdata->curr_config;
> +	struct etm_config *curr_config = &drvdata->curr_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   
>   	CS_UNLOCK(drvdata->csa.base);
> @@ -391,39 +391,39 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>   	etmcr &= ~ETM3X_SUPPORTED_OPTIONS;
>   	etmcr |= caps->port_size;
>   	etmcr |= ETMCR_ETM_EN;
> -	etm_writel(drvdata, config->ctrl | etmcr, ETMCR);
> -	etm_writel(drvdata, config->trigger_event, ETMTRIGGER);
> -	etm_writel(drvdata, config->startstop_ctrl, ETMTSSCR);
> -	etm_writel(drvdata, config->enable_event, ETMTEEVR);
> -	etm_writel(drvdata, config->enable_ctrl1, ETMTECR1);
> -	etm_writel(drvdata, config->fifofull_level, ETMFFLR);
> +	etm_writel(drvdata, curr_config->ctrl | etmcr, ETMCR);
> +	etm_writel(drvdata, curr_config->trigger_event, ETMTRIGGER);
> +	etm_writel(drvdata, curr_config->startstop_ctrl, ETMTSSCR);
> +	etm_writel(drvdata, curr_config->enable_event, ETMTEEVR);
> +	etm_writel(drvdata, curr_config->enable_ctrl1, ETMTECR1);
> +	etm_writel(drvdata, curr_config->fifofull_level, ETMFFLR);
>   	for (i = 0; i < caps->nr_addr_cmp; i++) {
> -		etm_writel(drvdata, config->addr_val[i], ETMACVRn(i));
> -		etm_writel(drvdata, config->addr_acctype[i], ETMACTRn(i));
> +		etm_writel(drvdata, curr_config->addr_val[i], ETMACVRn(i));
> +		etm_writel(drvdata, curr_config->addr_acctype[i], ETMACTRn(i));
>   	}
>   	for (i = 0; i < caps->nr_cntr; i++) {
> -		etm_writel(drvdata, config->cntr_rld_val[i], ETMCNTRLDVRn(i));
> -		etm_writel(drvdata, config->cntr_event[i], ETMCNTENRn(i));
> -		etm_writel(drvdata, config->cntr_rld_event[i],
> +		etm_writel(drvdata, curr_config->cntr_rld_val[i], ETMCNTRLDVRn(i));
> +		etm_writel(drvdata, curr_config->cntr_event[i], ETMCNTENRn(i));
> +		etm_writel(drvdata, curr_config->cntr_rld_event[i],
>   			   ETMCNTRLDEVRn(i));
> -		etm_writel(drvdata, config->cntr_val[i], ETMCNTVRn(i));
> +		etm_writel(drvdata, curr_config->cntr_val[i], ETMCNTVRn(i));
>   	}
> -	etm_writel(drvdata, config->seq_12_event, ETMSQ12EVR);
> -	etm_writel(drvdata, config->seq_21_event, ETMSQ21EVR);
> -	etm_writel(drvdata, config->seq_23_event, ETMSQ23EVR);
> -	etm_writel(drvdata, config->seq_31_event, ETMSQ31EVR);
> -	etm_writel(drvdata, config->seq_32_event, ETMSQ32EVR);
> -	etm_writel(drvdata, config->seq_13_event, ETMSQ13EVR);
> -	etm_writel(drvdata, config->seq_curr_state, ETMSQR);
> +	etm_writel(drvdata, curr_config->seq_12_event, ETMSQ12EVR);
> +	etm_writel(drvdata, curr_config->seq_21_event, ETMSQ21EVR);
> +	etm_writel(drvdata, curr_config->seq_23_event, ETMSQ23EVR);
> +	etm_writel(drvdata, curr_config->seq_31_event, ETMSQ31EVR);
> +	etm_writel(drvdata, curr_config->seq_32_event, ETMSQ32EVR);
> +	etm_writel(drvdata, curr_config->seq_13_event, ETMSQ13EVR);
> +	etm_writel(drvdata, curr_config->seq_curr_state, ETMSQR);
>   	for (i = 0; i < caps->nr_ext_out; i++)
>   		etm_writel(drvdata, ETM_DEFAULT_EVENT_VAL, ETMEXTOUTEVRn(i));
>   	for (i = 0; i < caps->nr_ctxid_cmp; i++)
> -		etm_writel(drvdata, config->ctxid_pid[i], ETMCIDCVRn(i));
> -	etm_writel(drvdata, config->ctxid_mask, ETMCIDCMR);
> -	etm_writel(drvdata, config->sync_freq, ETMSYNCFR);
> +		etm_writel(drvdata, curr_config->ctxid_pid[i], ETMCIDCVRn(i));
> +	etm_writel(drvdata, curr_config->ctxid_mask, ETMCIDCMR);
> +	etm_writel(drvdata, curr_config->sync_freq, ETMSYNCFR);
>   	/* No external input selected */
>   	etm_writel(drvdata, 0x0, ETMEXTINSELR);
> -	etm_writel(drvdata, config->timestamp_event, ETMTSEVR);
> +	etm_writel(drvdata, curr_config->timestamp_event, ETMTSEVR);
>   	/* No auxiliary control selected */
>   	etm_writel(drvdata, 0x0, ETMAUXCR);
>   	etm_writel(drvdata, drvdata->traceid, ETMTRACEIDR);
> @@ -562,17 +562,17 @@ static void etm_disable_hw(struct etm_drvdata *drvdata)
>   {
>   	int i;
>   	const struct etm_caps *caps = &drvdata->caps;
> -	struct etm_config *config = &drvdata->curr_config;
> +	struct etm_config *curr_config = &drvdata->curr_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   
>   	CS_UNLOCK(drvdata->csa.base);
>   	etm_set_prog(drvdata);
>   
>   	/* Read back sequencer and counters for post trace analysis */
> -	config->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
> +	curr_config->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
>   
>   	for (i = 0; i < caps->nr_cntr; i++)
> -		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
> +		curr_config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
>   
>   	etm_set_pwrdwn(drvdata);
>   	coresight_disclaim_device_unlocked(csdev);
> 

