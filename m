Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCBA3DEFE2
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740367; cv=fail; b=iqjTRrCAZBoQBmuPzxx+6SfBWd845v2pUg5jpeRi6UWXL3h4rWHZkOyFDLE1S3MZNyhILT7wWnGMRjOu+nPXWGYT9wLqqybOCcKfUd1y7inaZ95XueqD8gaS+ldWkw0L872AjHuvHprcej7hHsLAUAwtzPuiQk+OpmSZdGnvfyI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740367; c=relaxed/simple;
	bh=6kcxZeYhhksvtFNwQHnCLHC/N0wN3+R+biP9c1HPWgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KRFEecx+3nbRQAN0DA4nM4nDmpGqk+vSW/dmgQAp4UQ3HTU4X1aDO4/P3jT+MdZyES3suiG0krSWgC2395bLlPjm7CUVfXpou9zZIY/CTlbVuNfRfoYDuD7kVRA0PElwXHLvrR3xqgUYwLZSJ+43gEwrE7oBbIu3oSLEpQ34Mjo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LcmkCcOk; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LcmkCcOk; arc=fail smtp.client-ip=52.101.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LcmkCcOk";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LcmkCcOk"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Zk7BkwBOLxxuXbc1wxLSEsFlo5rj+UNs6Tsti3FQ62Wi3HohxdA2FB9IPaHYWtm9OikYGGUV3kWtxQxP4/vXT1wjItRZ3sTTbpQCjybjD2/ooCVW/wq/vts4m2fU/erjN1RRPTr5aYrfYf1NMVEFXf600o6fVvYov5Ed2UDoU8nKiiRRktd7XJQhVXiMMZA5T5A5z7MI94HCO6fuyoRzeKrXPMUW0hc4aI9f6A8pl77a9OOwKRTr42jkAcz77ztuMWZwGVnWUeBa9w2UOn1UYHWJKMELO/y/CNxsThdYCWnCGmGgB4o9DBlA/kxbaR0x+Bew21wSUC0KT4NKEDIJzg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny/UZYig6AcEZj2xpPQf1IEHO/HJcPd36hPME3bWO0A=;
 b=kCFzzZvHTw3nxaHD5WPo1eMUSCozTsMe5YR0TbFmmz9ORquzeDLoLTOnspzqho4HMZZc2xYcogweAkDLGDQMfJB0mwRIFTagf+tsnNvMFKfQljg1CdqwHPT4w41BmnGxtklJypF0M9YMulHVE5ssu27wJrN8Cf6iFRVWximwToGwYnk35PVLVjnbLcNjpDbQP/RLecLEBbdk8EmTZmU9kwJ7YMBxtFAGYiH2jI39DpyBm+y9plpmZ5bdADVq/kl03Hrz3G+XN1isuxnS22XJ/Ija/tozgRR4XQgQEep0n0/hBjaGlP8Ck5ZNaCGGjOdjiDhKcyC6ALkn9nhMDe0Ujg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny/UZYig6AcEZj2xpPQf1IEHO/HJcPd36hPME3bWO0A=;
 b=LcmkCcOkMkXYOSPqbNJpDUK7ACnRLB/kHr647F5lVbPVeCB0Vxa9lApPFdBo3gUfI2Q9gFzEcGRGmpx2z/5ers0yFhKuVqRxwgG87o5lKQKtJe4LChUXxEHvUvzvlrQCGuTVwBnBcNug3toQBzaqJ6DWAqc/gkga1PDqhdARwS8=
Received: from DU2P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::9) by
 FRZPR08MB11000.eurprd08.prod.outlook.com (2603:10a6:d10:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Fri, 18 Sep
 2026 14:05:53 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::2d) by DU2P250CA0004.outlook.office365.com
 (2603:10a6:10:231::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 14:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Fri, 18 Sep 2026 14:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5O82g7AOiwgWpCj1XIAweClZC4QuylIioTdYzxd1Czva455W51ON3IXfgnjLjlO55ZPODEO4bfSqqEFrqhKtMVk8KcYnJTjGf5Bag6+42tA+Hk000tpaDlWiaoTuVNzUrN3ZkB/646LQGvNRUy7BgbY9b+VA+YXV2CQRLVA/j5hcyXDuq7/gt9zGhzN/du9MXSYCPtim8musQga93IA2YVIIF31pbA864WT0HXNEtBos3lQlsdmsMODUrrCteoDli0kbuSgVNqwsV2PZwFbgUJY7FgCqSMQf8LSjDaDI43yp0xxQJj5Qi/a+9PbXxgdCZmJl9jrr0SmtxvpEx1qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny/UZYig6AcEZj2xpPQf1IEHO/HJcPd36hPME3bWO0A=;
 b=vuyhiMfaKi6HspGMWwUTjjRkVa+AfYYRO8KXj//uxprNtcWTccAA6j1fRnyBKaEMh9JwDdXUS73K3NQXSoe1m4tUeWtIr8z3+yuBergQ/cqwK02Kb8gM6B41kZp3uQHhQ4YGAX9UZTVRtghDu321wvHeqguwtGCAwg6q4dV7SZvUGi7ZPF7e3KIi8jPcepVcYQTzbVu16jMBZFgH+xyGzgepCtUqfvXhQfHY7AeNxG6d9A/+j31h55axuNcKjqnp4mCqPE3IVar1OKxc9z9iH0tmcxzPzoupIyqsxvYHckDbPk4h9rscrYOt6DcOREQj0XYAaGKEbybb/kSEMNjLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny/UZYig6AcEZj2xpPQf1IEHO/HJcPd36hPME3bWO0A=;
 b=LcmkCcOkMkXYOSPqbNJpDUK7ACnRLB/kHr647F5lVbPVeCB0Vxa9lApPFdBo3gUfI2Q9gFzEcGRGmpx2z/5ers0yFhKuVqRxwgG87o5lKQKtJe4LChUXxEHvUvzvlrQCGuTVwBnBcNug3toQBzaqJ6DWAqc/gkga1PDqhdARwS8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DU4PR08MB11008.eurprd08.prod.outlook.com (2603:10a6:10:570::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 18 Sep
 2026 14:05:20 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 14:05:17 +0000
Message-ID: <212419e5-a984-4f57-8a30-1d4558eb5c93@arm.com>
Date: Fri, 18 Sep 2026 15:05:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/9] coresight: etm4x: remove s_ex_level from config
To: Yeoreum Yun <yeoreum.yun@arm.com>, James Clark <james.clark@linaro.org>,
 Leo Yan <leo.yan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-8-d2b258d51747@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-8-d2b258d51747@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0368.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::16) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DU4PR08MB11008:EE_|DB1PEPF000509E3:EE_|FRZPR08MB11000:EE_
X-MS-Office365-Filtering-Correlation-Id: abc8eab9-45df-409c-909b-08df158df3d3
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|3023799007|4143699003|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 j0EVy2xgYHilLXvhhB/uA1Xwpa0iE3J4ID5AZl3jvnLH8lzAtEMOtIHIuqXTBFAt2iu9OCojT1qzoBzvXAuCt26CwqGr1qNRNpApceOVC6q8nrWOz+q5xBe4CxUWYchs6oAdTHj1Z0bkvUBfYeEpaMeoAw86xjv3qMGgqzdEOc9+jyhYQGNiECpjkN8QvWWSFQV2y3VUKcpQm8DKGXayPOUF6Eho9pfeJOO+sdSD5o4JQJ4lfzUfmm5lP8MuyQGT7ZNa+clo1sManxNlzMtjfeI38pJgpbSI20z40furf+SuQQ4fdZZK8LcjqUBmJXtfDmHHRnkvfvQ1YAXsWs6enwZdGUrFdn5JsRr9IV8m3WChGT68WPktDrfH8bbk8GePxFWGMOwJfkagimyc7RkZiKlRwu7b8930JEVz9yjrYd4c3YRQkPW5/5HljvUfZ0UasFNCZ5MZ9/DQ9FYvlC009Z7iVcL0rrksM8RrlIy2Rh6lH0TIJdlywLdhlAj89wVTcHxNGSTFpmmuEwjHfh0C/WZ1Rh01vrkNduk1dac33IeQOgLJAFtEN0ufMrvV1Dk6NT4TPJiC76pkKwCDOBO6RvbgP0H61HayaiiBzOEnrAQnIq7L9dz4XQZTmHjbyiQ5lBsmuS36VNv34fH8BN0WEh8CzeCDC87XmrFBGqhcYUY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(3023799007)(4143699003)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 qbaYNQoFfJcZkI5x20Uo9YcMrnQm/hEg2JLLtI3t/aC7DS/PNzkb6fCtQ9oxJx+FUzR/MarYLaaH++F5Tnj2ICPU8fmhfu6FjaSOHnoG9ll6fZoYdndKIzfOOa5DTgt4QTvnhu/q1Jxo0f9MFGgSQni982BSioNb5wCRqRLTiJy+nCJDctUbLwJV6YMIVZRrQuzJVWCQN08jK5lewZJlxT8D0rS+O2QKeCdP4XVUn66lU1BANTRzEwC1zB75by2EyWC1ONdu30kOsXvw7YAnf+qhQ0q60uKWBsG83uxMfyCCbpmVh6UhAz0XuBN2FPYx0hC0MMF/SjO5CAAMKcY7VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11008
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	644b79dc-5e24-4fe0-b457-08df158dde54
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|35042699022|7416014|82310400026|14060799003|1800799024|23010399003|6133799003|3023799007|10067099003|11063799006|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	eeMjrmNeDDe2HzuEid5t4qaa4FywSzMZ9NsWqWhvbtcRTOgGbkJrUVm7VbATEr3Y38bl0g5BI2QMll7KvfGswuVbwmlBaauZrHlxS3ty3ObOftG8zWUxGJT6ISn/2bjiEnGFQpQdPgZ+s6OPRTTCPMak7svfAsKHQBXmb7Qgtj8zkLMZRsOOZ82n+Pom8qEbENp2/AS22fsaQ4N+c7SouTE4nykWEWQSVzsx8Oenvo8vtQTyZi/AfKDJnLisk0L5BKw/edkF1TTYOE1jB+x9XNx/sK15QZ/YfBjBWjyGi62vmH/NQLMc93g7F6Mk3u24CxDVNOEZipU84pKEPLY+S80nfw5i/lAuOTUE7+VZ6oEdWPvBpVuHuVBoh4tChr2V8v3m6J8rXNche+Dh4VoiPhlBT+zXkuIwB+Fq1wUzKr7xubjzKkpVeg1lomznEJoGQ4ecXXm+qX2Gk0AWMbb4CE92I3RUX4ToJ8lFcSuViuYEbZFeTQ8XXyl93PVOR6r4B4R0qPt4H5vVVrIQI0Y4VtoEEXEVuFHFa9R8Y+1IlpfaRAL0GL91MTxeKIKOQ9otL3Gz8gAzrtnqOiyRD+bN33Of1Ze1TGvxJjFwZ7c262shKEd5tGKq9GVMdDGpbXS7TN6RCRTsTbBTn3xtjHgiFUAzmmdoBVxN5DfOY4J2772iGDU7JRC2qX/iyXkGGa8LN2SMnxrwxby1Q4WPIj6avg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(35042699022)(7416014)(82310400026)(14060799003)(1800799024)(23010399003)(6133799003)(3023799007)(10067099003)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hlOU7pMZdT8wTnwMao5/vTv+O95AYjr0RwADiMRS6H8vD3Oz/ehZmpulo1ZhByxiNnyd+84FGjZOJns4rM9YD5SUwiRg/E7a4ocf5RxgrzCpCL/SvBGUngETKcJxhIzlJC2trMwNkn5GhNgCR6pGq5+HSUl7Ok7r39tyZR7ONP8F6w6mHhtnxX0SP8lHfO2varNGGbhKzA6fMBX60vTQ0AcGSx5SzRXEJbS4QIuC+NgEaQNe9J7378gpytkuGpxBegCc5oESlJdpcbv+CpVtkf6IO7lRF22cDghCqJcrP3h8M9TImjt73Dnw3sM5aMzpIlAIk6oAkU46b0C9EBuhdivAMXntRoZF6uJFGRJEsM8IVuW2GYR2BOTUfaSCbKO4/OJPBxtpzjYk+RwUIS3r3UXaa78ZgPjLeUpdNSQLbSS3tDE8qmsIhE4HexaG3cK8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:05:53.4143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc8eab9-45df-409c-909b-08df158df3d3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11000

Reviewed-by: Mike Leach <mike.leach@arm.com>

On 9/15/26 12:34, Yeoreum Yun wrote:
> s_ex_level is a hardware capability rather than a configurable parameter.
> As such, it should not be stored in the configuration structure.
> 
> Remove s_ex_level from the config structure and pass etm4_caps to the
> functions that need to access this capability.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 58 +++++++++++++---------
>   .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  2 +-
>   drivers/hwtracing/coresight/coresight-etm4x.h      |  5 +-
>   3 files changed, 38 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 9de0c268ff954..e484e12572732 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -66,10 +66,12 @@ MODULE_PARM_DESC(pm_save_enable,
>   	"Save/restore state on power down: 1 = never, 2 = self-hosted. MMIO and DT only.");
>   
>   static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
> -static void etm4_set_default_config(struct etmv4_config *config);
> +static void etm4_set_default_config(struct etmv4_config *config,
> +				    const struct etmv4_caps *caps);
>   static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   				  struct perf_event *event);
> -static u64 etm4_get_access_type(struct etmv4_config *config);
> +static u64 etm4_get_access_type(struct etmv4_config *config,
> +				const struct etmv4_caps *caps);
>   
>   static enum cpuhp_state hp_online;
>   
> @@ -803,7 +805,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   		config->mode |= ETM_MODE_EXCL_GUEST;
>   
>   	/* Always start from the default config */
> -	etm4_set_default_config(config);
> +	etm4_set_default_config(config, caps);
>   
>   	/* Configure filters specified on the perf cmd line, if any. */
>   	ret = etm4_set_event_filters(drvdata, event);
> @@ -1471,7 +1473,6 @@ static void etm4_init_arch_data(void *info)
>   
>   	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
>   	caps->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
> -	drvdata->config.s_ex_level = caps->s_ex_level;
>   	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
>   	caps->ns_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_NS_MASK, etmidr3);
>   	/*
> @@ -1556,19 +1557,22 @@ static void etm4_init_arch_data(void *info)
>   	cpu_detect_trace_filtering(drvdata);
>   }
>   
> -static u32 etm4_get_victlr_access_type(struct etmv4_config *config)
> +static u32 etm4_get_victlr_access_type(struct etmv4_config *config,
> +				       const struct etmv4_caps *caps)
>   {
> -	return etm4_get_access_type(config) << __bf_shf(TRCVICTLR_EXLEVEL_MASK);
> +	return etm4_get_access_type(config, caps) << __bf_shf(TRCVICTLR_EXLEVEL_MASK);
>   }
>   
>   /* Set ELx trace filter access in the TRCVICTLR register */
> -static void etm4_set_victlr_access(struct etmv4_config *config)
> +static void etm4_set_victlr_access(struct etmv4_config *config,
> +			           const struct etmv4_caps *caps)
>   {
>   	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_MASK;
> -	config->vinst_ctrl |= etm4_get_victlr_access_type(config);
> +	config->vinst_ctrl |= etm4_get_victlr_access_type(config, caps);
>   }
>   
> -static void etm4_set_default_config(struct etmv4_config *config)
> +static void etm4_set_default_config(struct etmv4_config *config,
> +			            const struct etmv4_caps *caps)
>   {
>   	/* disable all events tracing */
>   	config->eventctrl0 = 0x0;
> @@ -1587,7 +1591,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
>   	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
>   
>   	/* TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering */
> -	etm4_set_victlr_access(config);
> +	etm4_set_victlr_access(config, caps);
>   }
>   
>   static u64 etm4_get_ns_access_type(struct etmv4_config *config)
> @@ -1619,21 +1623,24 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>    * This must be shifted to the corresponding register field
>    * for usage.
>    */
> -static u64 etm4_get_access_type(struct etmv4_config *config)
> +static u64 etm4_get_access_type(struct etmv4_config *config,
> +				const struct etmv4_caps *caps)
>   {
>   	/* All Secure exception levels are excluded from the trace */
> -	return etm4_get_ns_access_type(config) | (u64)config->s_ex_level;
> +	return etm4_get_ns_access_type(config) | (u64)caps->s_ex_level;
>   }
>   
> -static u64 etm4_get_comparator_access_type(struct etmv4_config *config)
> +static u64 etm4_get_comparator_access_type(struct etmv4_config *config,
> +					   const struct etmv4_caps *caps)
>   {
> -	return etm4_get_access_type(config) << TRCACATR_EXLEVEL_SHIFT;
> +	return etm4_get_access_type(config, caps) << TRCACATR_EXLEVEL_SHIFT;
>   }
>   
>   static void etm4_set_comparator_filter(struct etmv4_config *config,
> +				       const struct etmv4_caps *caps,
>   				       u64 start, u64 stop, int comparator)
>   {
> -	u64 access_type = etm4_get_comparator_access_type(config);
> +	u64 access_type = etm4_get_comparator_access_type(config, caps);
>   
>   	/* First half of default address comparator */
>   	config->addr_val[comparator] = start;
> @@ -1664,11 +1671,12 @@ static void etm4_set_comparator_filter(struct etmv4_config *config,
>   }
>   
>   static void etm4_set_start_stop_filter(struct etmv4_config *config,
> +				       const struct etmv4_caps *caps,
>   				       u64 address, int comparator,
>   				       enum etm_addr_type type)
>   {
>   	int shift;
> -	u64 access_type = etm4_get_comparator_access_type(config);
> +	u64 access_type = etm4_get_comparator_access_type(config, caps);
>   
>   	/* Configure the comparator */
>   	config->addr_val[comparator] = address;
> @@ -1700,7 +1708,8 @@ static void etm4_set_default_filter(struct etmv4_config *config)
>   	config->vissctlr = 0x0;
>   }
>   
> -static void etm4_set_default(struct etmv4_config *config)
> +static void etm4_set_default(struct etmv4_config *config,
> +			     const struct etmv4_caps *caps)
>   {
>   	if (WARN_ON_ONCE(!config))
>   		return;
> @@ -1712,7 +1721,7 @@ static void etm4_set_default(struct etmv4_config *config)
>   	 * full instruction trace - with a default filter for trace all
>   	 * achieved by having no filtering.
>   	 */
> -	etm4_set_default_config(config);
> +	etm4_set_default_config(config, caps);
>   	etm4_set_default_filter(config);
>   }
>   
> @@ -1760,6 +1769,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   {
>   	int i, comparator, ret = 0;
>   	u64 address;
> +	const struct etmv4_caps *caps = &drvdata->caps;
>   	struct etmv4_config *config = &drvdata->active_config;
>   	struct etm_filters *filters = event->hw.addr_filters;
>   
> @@ -1789,7 +1799,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   
>   		switch (type) {
>   		case ETM_ADDR_TYPE_RANGE:
> -			etm4_set_comparator_filter(config,
> +			etm4_set_comparator_filter(config, caps,
>   						   filter->start_addr,
>   						   filter->stop_addr,
>   						   comparator);
> @@ -1810,7 +1820,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   				   filter->stop_addr);
>   
>   			/* Configure comparator */
> -			etm4_set_start_stop_filter(config, address,
> +			etm4_set_start_stop_filter(config, caps, address,
>   						   comparator, type);
>   
>   			/*
> @@ -1846,7 +1856,8 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   	return ret;
>   }
>   
> -void etm4_config_trace_mode(struct etmv4_config *config)
> +void etm4_config_trace_mode(struct etmv4_config *config,
> +			    const struct etmv4_caps *caps)
>   {
>   	u32 mode;
>   
> @@ -1860,7 +1871,7 @@ void etm4_config_trace_mode(struct etmv4_config *config)
>   	if (!(mode & ETM_MODE_EXCL_KERN) && !(mode & ETM_MODE_EXCL_USER))
>   		return;
>   
> -	etm4_set_victlr_access(config);
> +	etm4_set_victlr_access(config, caps);
>   }
>   
>   static int etm4_online_cpu(unsigned int cpu)
> @@ -2172,6 +2183,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
>   	struct coresight_platform_data *pdata = NULL;
>   	struct device *dev = init_arg->dev;
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
> +	const struct etmv4_caps *caps = &drvdata->caps;
>   	struct coresight_desc desc = { 0 };
>   	u8 major, minor;
>   	char *type_name;
> @@ -2201,7 +2213,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
>   	if (!desc.name)
>   		return -ENOMEM;
>   
> -	etm4_set_default(&drvdata->config);
> +	etm4_set_default(&drvdata->config, caps);
>   
>   	if (etm4x_always_pm_save(dev, init_arg->csa))
>   		pm_save = true;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 50ef2e957300f..d826033d52e24 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -443,7 +443,7 @@ static ssize_t mode_store(struct device *dev,
>   		config->vinst_ctrl &= ~TRCVICTLR_TRCERR;
>   
>   	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
> -		etm4_config_trace_mode(config);
> +		etm4_config_trace_mode(config, caps);
>   
>   	raw_spin_unlock(&drvdata->spinlock);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 8c1c1364b1c44..f252da868b6de 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -955,7 +955,6 @@ struct etmv4_caps {
>    * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
>    * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
>    * @ext_inp:	External input selection.
> - * @s_ex_level: Secure ELs where tracing is supported.
>    */
>   struct etmv4_config {
>   	u64				mode;
> @@ -998,7 +997,6 @@ struct etmv4_config {
>   	u32				vmid_mask0;
>   	u32				vmid_mask1;
>   	u32				ext_inp;
> -	u8				s_ex_level;
>   };
>   
>   /**
> @@ -1116,7 +1114,8 @@ enum etm_addr_ctxtype {
>   };
>   
>   extern const struct attribute_group *coresight_etmv4_groups[];
> -void etm4_config_trace_mode(struct etmv4_config *config);
> +void etm4_config_trace_mode(struct etmv4_config *config,
> +			    const struct etmv4_caps *caps);
>   
>   u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit);
>   void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit);
> 

