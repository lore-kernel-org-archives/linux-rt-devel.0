Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CCE4AA574
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730168; cv=fail; b=iIMGZk+X7XqivPvspanuIdgmF67QVVAZVR4REPAWv62FP3ocq6xedJeFny9iF9bvJX1K0xPJqYEx1Wu3v/n2+4ygIq+DHiioACuQtTS38P70+R/IekNT+G+56icf6eCDc0POoMgJyIB1QFXJAobBjfoYeM5AhRPWJfZmmBrfB8Q=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730168; c=relaxed/simple;
	bh=ev9lDDXHL+OrP+oJpiZy6jk6mWMh9uB0wO3b8L4aZI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CkqudDayyCq99n7iTekkJGMpZd8JdVE9pRPDmf7E20T32IzGxd9ZsJ2zc4T8MLgbWR4lxR2xrStSnWY1w2CD9Pf233FWLvpJDziRO06pr41+rJ8I8rQlo0fNLMv1gJKzNOpyTT1xwYUIOsmBe1teKBJNbn7p4jvnyNDM1lLGf9A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DuZyq6IM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DuZyq6IM; arc=fail smtp.client-ip=52.101.72.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DuZyq6IM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DuZyq6IM"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Jg2R67ul/i/wWxxWveKlxDb+wWvyLt8Wlb+y5yI6rkO9ip8rF2GB9qO1AsU2BvVxAsnVhIgBWiYJkuwx+zNohOepcvl/J/eNcqlvytcU/AyEnXgAf60HFECtdAKrw9GFnuJ9iMEWQBeJNd3a3eVy7i3hsNvL2X3BMof90QtCbbXiQ6NVcftPJBb1bHCOMbrf0VrII6Oxv/2lPnoIwv99Wi06Aahxx4CAJ2Dz3YLXcUox26vNPxVbrI+i0KKPZaE6wjJxPND8xI8IjQewnWZ0ZWAWz3AAqXXUWdwJQg9AFSuYf3QJhGqRsmAM0k0g+C09qoM5Ilp/VIHhtBNwDkbfFA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T842tHG7BmpzBaa9pa7obT2GcZR03IP588DdKquHW0=;
 b=X8U1DKmGTRCy28P5yTXEXS4e2KDJd0hMZHv0TjFNpXEAIvDvqHkUXM/wQ0eCc8u2sWAmxzqR2VUjRFwNY3+dx4HsIbaZGnbahWyQOrSzYwm+woeLCEPMIORXnvyTIvdFXuhTRMvqwxqUKOD2kgURMCMmLprT3BA3lr48exHEjMAWdWdnU699xfcDoF/urAg1q2wraxN8vgogJQHQ/le+i+bsUdESY1Y2m5jJz6wTiMvknZanl+GhojIo77AMCLgvZotNS+fxbJhGlstUIFLhuHzZwbpg3nUL5AfJIqS2jRZUX/TSKVYsFI1+ZEP7MXGxBch7hEE5OUpEF/MmpKxSCg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T842tHG7BmpzBaa9pa7obT2GcZR03IP588DdKquHW0=;
 b=DuZyq6IM/JNQ5SvVgOskfK5x4cswsQUd6qu3n1YLNxpOCTi4WgluU1PlrrXSl2jdcjW2VswXBA+fmC6/LH1cN/5F92/z873SKcZn9h5B0EP+i0myl/Kc9n8HQT2H6k4c/hBeAux2MDukNrBF+FcQtdVbdiHvo9mbQnLxleN/VPo=
Received: from DU2PR04CA0028.eurprd04.prod.outlook.com (2603:10a6:10:3b::33)
 by AM0PR08MB5346.eurprd08.prod.outlook.com (2603:10a6:208:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 11:16:00 +0000
Received: from MAD0EPF000008A8.eurprd04.prod.outlook.com
 (2603:10a6:10:3b:cafe::9d) by DU2PR04CA0028.outlook.office365.com
 (2603:10a6:10:3b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 11:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008A8.mail.protection.outlook.com (10.167.241.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 11:15:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDBYFG+oiM8ZumTXFxBO//QWFWqs+4h1c5CiyMV3WFlCxl4n1zlxx+fhU9KERF+KUFX8tjnGpcCKFb4vppZ1DVQqIc1j3Dy5YDKl4xxl2psVIMec1/nizSLfkpzpCDT+wHdRX571EhOEG5nnqwheIk+4LTGjlwNMHW1FhRGse3iWbct3IPiv87bS4l8wqBEVt0ob6vWmdB6GarBTRpyxkmxesuBex1qir40Z7lHs1rQn+WmUz9h6OnABAu/xlCbnrtJCZR6WRFyyjZW3stdDZw3N1asXS6MLa2cQ06y41MB4pSoe2YTNk3NRXe1w0pfCpFT5T3k5ke6kINJktPiOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T842tHG7BmpzBaa9pa7obT2GcZR03IP588DdKquHW0=;
 b=XrCb9FUNASRF/g7zZRsP2Zx9qwCDZuMqs6JFlRKobQPyy+hhrFtsQdyv4blFePGAbbPUfpSXDhdSpwwB6XI/6DcAdacJCQhrEhe+BzVLWRBPAQm79ZawI01MxD+rkdAYmVpZDjdwLm9ARss6ffK5kt3QMl26ikfQuIdbk5+IyIF/yFPtL/FGhu7st38Rce9v6hgc5n36Tl+eW3hpU6Id4FUv1JqRWhcbYikD7SHisFNXPGvH/qdruWa5lzrQOhxspydYnrcnbv5MYDuczfIWHPIP8SLMIInunYDIVHALwjPKiGmILgBmh43vCDft6vEqaULUBs9aW37WC1Vw24IDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T842tHG7BmpzBaa9pa7obT2GcZR03IP588DdKquHW0=;
 b=DuZyq6IM/JNQ5SvVgOskfK5x4cswsQUd6qu3n1YLNxpOCTi4WgluU1PlrrXSl2jdcjW2VswXBA+fmC6/LH1cN/5F92/z873SKcZn9h5B0EP+i0myl/Kc9n8HQT2H6k4c/hBeAux2MDukNrBF+FcQtdVbdiHvo9mbQnLxleN/VPo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by AM7PR08MB5367.eurprd08.prod.outlook.com (2603:10a6:20b:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 11:15:26 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 11:15:22 +0000
Message-ID: <2ea0dd0f-eff3-4b46-8959-42d44b2ac562@arm.com>
Date: Fri, 18 Sep 2026 12:15:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/9] coresight: etm3x: prohibit modifying cntr_val and
 reset while session is enabled
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
 <20260915-separate_etm_cfg_v2-v11-2-d2b258d51747@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-2-d2b258d51747@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::14) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|AM7PR08MB5367:EE_|MAD0EPF000008A8:EE_|AM0PR08MB5346:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ab44c5-4c34-4189-37f2-08df157637f6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 Ea3xXUBVdCZMRqY/934w6f3HNez1diPMWA/KuCbmj15kOeT2LqTI82oLMbSpYq0fkVk+180s8m50r0+d8k4evtLhH9pSY8BHJu3u2kLH9jRedU0pYv3iO4cndg0L6oO5ZD6xc9rSPmfnkGPc7GA6zS8pyhpcjRvucXoMP7JnHN0MVWjvPoAoicwyTBz25YVctksOdmPOp5qkC0TO57ss85jy79DwoJxCJ7BLEywrWAhXn6ZRMPZ09HA8prZBsXm4s6mDfmu8oIsf3KzRB61lf+ZH7GI5aL8svBoDCTqoyeb7bkhsAAyEMJXOlyIpjfWOA8uZSO8oq2C7E6x8WnL5VQymuqzBxSPD9Ca5p86uraXw2hYuML7zquLhr5Rzbor4p6lizFoYLxZPYeIKoFZ8Ou97/enA4KR8XwBZsiDR5AHIzQlio3TqewJXTXqDrPq9hHSBzqULwjCoRw5ajM0RJGk+FexSG9UYEJYmwFQdwl7XL9xked0SXH+bOYTXidggvW7B6kGiC7QflfxAc2jGzGRzpvr1Muo7op6kqf/3IoJhKXGkZ/RtJiNdcS3PqXUy14dNAkPtcvcLO6bYsLQgxsJuU+Ta6kPM6EhplwcSowO4DONhKgjTLmSaJsPN+f7SzjE9SqWrYSVF3Z8aSwDS+fxaVnC0IKOfyB4utbPB/PM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 pLAME2KQzftO9WiOYcrSyu+O6z/3rp9gggTTfLku6VGGq7PTbF+ZHtv9dAw20jOF4J6bpagLQgpi0KsjzVviw94h6ii77ANcD3YWJNSCxaI67p6J48+ylWJV3gj3Xsk1W6PHMfnnPrpNizb03LEZRBLoHFkpLhW8Lojd+t/paOGK2sIZb2gsa8c4oI613NAWdoTFzDH1cNhbn8UMb9ZOStQUpWJ4Iy2N2qW/iqkJj4GzLa+uX6smS8fz82xXkHW1GMUw4imSd7KOaZG8ozlKbBnprsxYAESwRikaSGHph1LVG2jbxf9XYOgZ9SsbNLFnc+xXDfBKXiYceFrnaLhPLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008A8.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f4ae1e9f-6cc9-43b0-2c33-08df157621c6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|14060799003|376014|36860700016|35042699022|7416014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7NIxzTlxGP6je+i0VSeG0jj7l/eEffc1mEPn+0arL/vtdfyDSC0eUtTuS0wHjMMPf/QXo2GDpvw+dMunHYywDc6SgzSpooYQKLRIKESln7URdBaYuXbCfn7MgyqMpvdpH/J0X9EA+Q9Z3O/eSxeuuKCNA8P0mQAfICoYwtrQmaNZhV1AX6HeA38ZL98fs3zZsS+Ods4EnO/9CXawLjc4saaHcuDihgc9VCUWHbCYlVpQlW2LMNsCPDzsjInk+zRaF5hmwwV/HQfgIBlZOm9wpDUanYED/sdMoELtJmvIZ3RfLmuWiJ/ofNDLQ10dDLAvHMuzS/oRBmYAjZCQutKGDTzALCxIuunm3cqcBVHjbP1fJje3WgsvPV20zZ8yLCKTWcty+v34M+/0HUoML1zkbuzmpR0e8NCHLbYO1k/yCnrew7+7NDnZvgRyd+iAmDnISBsKIvjbo9fnl2qltbWz8CYrv9uUP2YB5nA/Myzak8buVdCzyh/Gaj7u0siIIMviSp7Z/JqofxtTSnCTh0ASFfO1RMabTwFL0iW1tN8shasAaxSTTv1s+UpBfgi7qf33tHptxZjlxNfZejs/ieyPdqsNmHRfr9q/GU2Xbi071521egLXeDv8bNt5G1B0v8Psx8uTgU2b0NuVAnofwgbdijIg+JFYLeEVgnL0ZE6HzCrWqDWEsNX7/RG0ud+oLQJaNJfoUp3OYD76Ll+NvU9P6w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(14060799003)(376014)(36860700016)(35042699022)(7416014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mh8/a30XnhaUTl6KlOOgNBi9FTScd1+H6uDMZ1f7xN/FvipTwUkuVOpDsguo2pOcPgjBTguBC9bEed9ShgVduEzl07F1JlXhUyJ0Jxvb7fb4H+DmUmKstzwoA8MEiru2Nncipm4yi4yTbTc6OrTKTQ5b1NSHHdYHhlTJd0XyAB6AzgJiaIpXQbBusAvB5C5ZB7dmLHjgiY1BwysiFPOlvbtYdNGxllDTC9QHekWxfBoyC6LAh2wTP+CGcLRUOrN0IVzTsXIzVSz4mnM2LStny0Q7RYsYDdE1Mfs+NcvtJsLwGyKzaroOHDuouTocbUNAGQLbSugqz5potWazhbwadG4WhP+ehSq8VX6rubnIZiEeDQ+R00/Vc1yhDb0SeRbumXyAcnKxpCL7oqKNMLVBvK6e2+xFyqhleMHlk1lAaOk+v3XBSkMrZLErg1Hv4D8I
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:15:59.7492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ab44c5-4c34-4189-37f2-08df157637f6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008A8.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5346

Reviewed-by: Mike Leach <mike.leach@arm.com>

On 9/15/26 12:34, Yeoreum Yun wrote:
> cntr_val are overwritten with the values read from the corresponding
> registers by etm_disable_hw() when the session is disabled.
> 
> This means that any changes to this value made while the session is
> enabled would be lost when the session is disabled.
> 
> Also, reset shouldn't be called while session is enabled.
> 
> Therefore, prohibit modifying cntr_val and reset while the session is enabled.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index b3c67e96a82a4..d4846d6364945 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -74,6 +74,8 @@ static ssize_t reset_store(struct device *dev,
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
> +	if (coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
>   
>   	if (val) {
>   		spin_lock(&drvdata->spinlock);
> @@ -744,6 +746,8 @@ static ssize_t cntr_val_store(struct device *dev,
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
> +	if (coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
>   
>   	spin_lock(&drvdata->spinlock);
>   	config->cntr_val[config->cntr_idx] = val;
> 

