Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29051120D
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679305; cv=fail; b=kBS6irz1YWs8iUxF+hxoHaptwCKywycIZZEN0O0ni1k47nYALmxq3xs8wx1Mu2asnadrEpRrbF0S5/FrTXGeiv6qdN/Twxa0yOGPGa7FCmYBfPZuwKbtwAOIgQpLBIPxJHadgyk/eIsd/UJG/G7QGD0uzDOUZjGFbeERUU6cfB8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679305; c=relaxed/simple;
	bh=HhQMTyOON/IwX8GLwu/8Gj0a4TGrtzWs55JLxwSgRfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OKECKLU14/y8tFJ8jHcv9tHhbjursKNb+YDHPOeJVxSB5KWFxPuB1d/WtgSmwaXT/nyYMqiYE6BNcJUzjmWpcUvSqsj47foROo1rmuj5i04olmM1Tkzkb0DCn3ereIKnjGTHNOs89IxNIA2xvS5arWbhTfCT2C0/s3VJZeTjTUg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YHuIGTM8; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YHuIGTM8; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YHuIGTM8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YHuIGTM8"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=u7vUEmI40oRrruGoF+E0DPUKsiSA7qmdu7/JoD6Qh4Imkm0ZnukoXxfMiSTEqJVc+pceFIZz4t2nePtxT9HD5qcoUaMv9PusgvzSuYLzE2+0m0+MnyrJDeXy3rhJL59rnJSXFFqYQTorYkjBG+yVY6fcLBknRDtlr2Nrmn4S4BRtGx58E2R74pWXVdTqOyFdirCZB+xBuLQ0GDC9QiHJKJRmDbIBoBBtTONjFs2rJTDwyeResNgx6m6ipClALr91lQVt8iGrz2lIBTPBd1zt8ySd3oLbVsEZzbK9w19OcBbHii3dX7Q63H9N6E8nvSNgka41qrXjLwb54EHa36D7DA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIDGsaZDjRXKSDNIamXvX0Kx3iMn+lP142ap8vP87f0=;
 b=SduTSS7en3pHgrSFwd3MmMFTHDUvH+/xEgDrcYDaRbs2pydNmygHRxezqFx/ML7GN51ioRa2XV1af7CP23gGhdX/016AoTesIiFnbV2LjaM/PN0YkHSQcXBQIS4eAMT3AEbvlo8Hnoq4/tX203+DNW969MTuaQK2dnOHK3++rtUZTYugM+wa1+WXg2tKrCSGfhxjoZoohS/9Iij2OTMNdfhPQ8Egg+9bRD4ejJVRxgkG07ZOK91CjKK/09z35IXx57wLmZz9m15F8YFZHBxRfVR7Q8tfQvhFUdSiw7BJFNiMwc1XxxskKzypeB5aqqqXruqPWwIFeBtXdhx6GgO+1A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIDGsaZDjRXKSDNIamXvX0Kx3iMn+lP142ap8vP87f0=;
 b=YHuIGTM8qwypiLOaOrfybnFnhlOrwTkdaFAFU8dukvCj4vHYlN9+M3jArzYSsHrxZ7majojIVDgW/CF97yPE+DUOiyqqHOcnMZwI9xO5/x32BLS4gHZVoeLv3I+okKRgekU+CHn0tfboS7wH0xB5ap+Ye4NF+K0BQLXqCsFqwBY=
Received: from PA7P264CA0097.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:348::15)
 by DB9PR08MB9515.eurprd08.prod.outlook.com (2603:10a6:10:453::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 10:54:54 +0000
Received: from MI3PEPF00008556.eurprd05.prod.outlook.com
 (2603:10a6:102:348:cafe::3c) by PA7P264CA0097.outlook.office365.com
 (2603:10a6:102:348::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 10:54:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008556.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Tue, 29 Sep 2026 10:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaDcUZcL5O/6mHegoNZypQZAGKRnxqaxFNlbyfAubNgbqBLsCb1UAZdwH9UTB6SpJF+/LbQUXAUG2reIXuAbNymekZt9ncXdyByIaco8ApdYftEEnZXLauh41ATSa6hIkTl9lQfyG0R1qUjL5W7mGOYurWFTrRAR303lfZiooCcf+m0+9JpiLNkUnUj0U5v34d5GJW7q3EVQ7x6X9R1ASrBXwljo2JO4oiqpKKu0HscVpPPPLntk7adq3O4zlcVcf19WNf3S+sOIyAh4BHj0f8IZO9ywUUg4TFYhvJCz1T6CY7rAYrgEutLkNm5sA1EQGMwlA265Y2cNla8F/dR9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIDGsaZDjRXKSDNIamXvX0Kx3iMn+lP142ap8vP87f0=;
 b=UBj4wLYD49zupatvQXhOye2sLKvu/QouVxqcBVTUAQnxZH1bupb5+vTli2WtK9S0m/AeWSfs7v9blcGb4BFBNlXRcdJxAZEcIWG50t0cGhfbvNGLeeKS3sfQZIe+8ZNYl/W/DoozttJOpTbLP/rzpyzMjttPsCRkjKxfVQMAl7VGb5Fl+GMS541j7WVy3OwUf+RdDicz57cUJqpjDojHxZlGd9SDgsLUtYcOq2BGKUFyrIFiJazx8BY6S50MfuhclOpz1Me6GaheunBwu8u16dzJrURaXWgYak+W7P+553pBTza3SIJUgnJWYcvLQ2FfniCDayfAufpa7kzVcC4/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIDGsaZDjRXKSDNIamXvX0Kx3iMn+lP142ap8vP87f0=;
 b=YHuIGTM8qwypiLOaOrfybnFnhlOrwTkdaFAFU8dukvCj4vHYlN9+M3jArzYSsHrxZ7majojIVDgW/CF97yPE+DUOiyqqHOcnMZwI9xO5/x32BLS4gHZVoeLv3I+okKRgekU+CHn0tfboS7wH0xB5ap+Ye4NF+K0BQLXqCsFqwBY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DB9PR08MB8386.eurprd08.prod.outlook.com (2603:10a6:10:3d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 10:54:17 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0472.005; Tue, 29 Sep 2026
 10:54:17 +0000
Message-ID: <49d2c3c2-8274-4bfc-86fa-1b7762c230ed@arm.com>
Date: Tue, 29 Sep 2026 11:54:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/14] coresight: etm4x: rename local config as
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
 <20260924-separate_etm_cfg_v2-v12-10-a2b41d2f7c2b@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-10-a2b41d2f7c2b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0505.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::14) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DB9PR08MB8386:EE_|MI3PEPF00008556:EE_|DB9PR08MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a36b0a1-30fb-4a8d-dc13-08df1e181804
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|5023799004|56012099006|11063799006|4143699003|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 ukPqIaSWPMoBu1uaqo3zWeHT6jyBkM+uBPOO+S5RFOY6PX3vGXhwTIPAx3SANQkz/sny2O4gbSzuAbxUgykNAEQtDeXKMhw8S/xh6kH8cfLJFS7tOfoj4d2Y4TbTqPbIV5R0U52z2Hx44tzGQuXfqcktvomZvI0LjYO4NEDCvn+5pnsY3IlXwXFHq2mvND44MHfkf1mOxlRR8m+90Bgm5xxtvZzca6lcDrnfzsimSUOl/XfknnB+lCTf9rcMwycfjY6kYZIvtqptGf2Vqcy1HkYf0B3wWO9dUrt/Oi8K03QTCUnWM81Bqjf1Ub4DVrxoBWJqmyBpi2xXzXOoYp6SRFoX2jYoNUYvWA+Fx7IOkW8VhEZMsi4cyFuVjy49CtYwaPR6lstShoxS2NUqBDK6FlTGiW2Eqqmts5ukdmCBT6DXetvlBf3YMbWAJ5YSQpf6/1jnijUAKhJ0WOUlWPyfmPmZFO3hscmIq8EKd9T5W9hA1jpifDK3mP4GXRq+b3EFXmCbQyozElbJ6OTUXL8qjgBEi8dPffe32lz45reuAXV6ifIL944avU5kcwi4lPrY1tCZOkRMiHmevqN8seFuJ44huRX0UoIM7PXQDX+kmPvq352qVs6HhgVsAHFUb7R9iC0cL2ReiUpEB+p8W9EKI93yKTolrPYeQxwTHlgZ6O8=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(5023799004)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 hCEUBNxDieNhHbxIeWvxIghAguJ7b9HQJd1lpGveiK5k4iPp9qX7mIO8SfCnWLe6cnpMrULj3QcqCqAF70xklPj7K4rjFCWLRh3HHa+43d9i9sGBCjugI7lINoXwdY+rsq0qQw3m3b9//U0PlYLMrig6DOqfbyrQXMxAIVxJsfsTlG+s95fVyI69PWRDhCWGAK6QfAOd2x85keJGMFE8uWwoSJvrXD9cZV/b+KR/2DD6E4WrxW2NkDFHe3v+bLW0fDUx3/IVv/u9X597EgIcjNVqAkBVE54xPn3DsZcJpLc2Xf6WpASRv8CDrfF72sABvyZeDPXPfyYzkcyC9sPeVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8386
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0a89e24a-f16e-443c-511a-08df1e180218
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|82310400026|35042699022|36860700016|376014|23010399003|7416014|4143699003|56012099006|10067099003|5023799004|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Bhx2bYh2tSJK8mQ9c0q+++hofizcG63y6/EB4M3ek1Mhd7ofxZzXXNsatj/71lRxWMdAGoOSEyBIpAFHMW3SdgO4oFsPX/P/E/7TzhP6agjoAfQkI3Bn1xBEaFYY9NvaucT2W9xxLz61rqeReiOLvIFFS4sEYWDwR264h9uCA0ElgyD92Q5kpBx43J4MSDnb9pNVjKVdmvlBq6Oaz+oayASk1N5xAg4xgIW+lA6zqLnIsezZUKenvSwR0jK9fKHUFJoBnxGVFSf8M6lQmn3oYdUqhS1WDsl4J2vCiyRnIll78dLsc4yCrWDKRiR6y6fwrRVnbAEvhDyN3II+Fz1cmzRgHh7FIFtpA676Ew6fC3Qpc5qfgsIeXAvvIS2gK1bq1gqvzvJzotDAv91AU6D10Cwc1QuCh9P8mq0erSQeuOINRCb1LB+mTw6f8w41mi14EFWfSiIia9iqXnoPKxcyDTDiztHDXtocnVkpGNRekUb8rrRPqy9DhN1Ujh4NELTinTa0+VfgRHytFF/ZsvTz+/2S0du8WXWFdYOnqVsKsEOkq5K3e3HtfCqXHXhXZyRu1cII+1soBePRzrrNHXPLwa5yT+eYPdUGUfmheKmDSDY1OKpglhOF1lbGRNLUnEa5IDy8s/iMmmEeDKBLylY8CUsztYABxEwBwMagLvBvjTy0heQKd1xWeHgKbm2NAoRu4eCD7dtVautZ0FtYaDlv8g==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(35042699022)(36860700016)(376014)(23010399003)(7416014)(4143699003)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R9alMMMK/z/4NLCevcOXL8+M2qfQDEsjqxoLPJw5nXjHoCziqCnUm7wuyMX18Ftq5twbtqnVGNzlGbjTt/5IkIwQzy1F4NzfrK4jaje4VNDzlzd2EaHQmjMEKSD6ENZOlOt1gb+NH/W3u1VkSMvM9kOwpB80HlBNRPkxDdy8ckhWAFyfe9X8TieoGCWNJXdXdF2lokhjQMhCBKPnYRsthPWoJcM3+SXse5b9y+GNTrug5r5PMLihaLzh3fejTavs8hibPUekcR511TE4H8kQuWrFg0a4V3pQ0jAGtMb6cr5a7Y139biPjUoayrmNG9U1XYpIr4dWBj9PfST62cTRacLjVHRDmwBdpvlNDulIgNpYRfS+piX4h/OcFJwasWoJodOSpnIv2XOYrVHKqwQwy49zANkEQ5OUAwevbZaHZb9Re9WpuFOaUINu+/UlYBf9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:54:53.8979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a36b0a1-30fb-4a8d-dc13-08df1e181804
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9515

Reviewed-by: Mike Leach <mike.leach@arm.com>

On 9/24/26 18:33, Yeoreum Yun wrote:
> For readability, rename the local config variable to curr_config in
> places where it refers to drvdata->curr_config.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 164 ++++++++++-----------
>   1 file changed, 82 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 99d4e2d39e66..5db11309bfbb 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -270,11 +270,11 @@ static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
>   static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
>   {
>   	u64 trfcr = drvdata->trfcr;
> -	struct etmv4_config *config = &drvdata->curr_config;
> +	struct etmv4_config *curr_config = &drvdata->curr_config;
>   
> -	if (config->mode & ETM_MODE_EXCL_KERN)
> +	if (curr_config->mode & ETM_MODE_EXCL_KERN)
>   		trfcr &= ~TRFCR_EL1_ExTRE;
> -	if (config->mode & ETM_MODE_EXCL_USER)
> +	if (curr_config->mode & ETM_MODE_EXCL_USER)
>   		trfcr &= ~TRFCR_EL1_E0TRE;
>   
>   	return trfcr;
> @@ -293,13 +293,13 @@ static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
>   static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
>   {
>   	u64 trfcr, guest_trfcr;
> -	struct etmv4_config *config = &drvdata->curr_config;
> +	struct etmv4_config *curr_config = &drvdata->curr_config;
>   
>   	/* If the CPU doesn't support FEAT_TRF, nothing to do */
>   	if (!drvdata->trfcr)
>   		return;
>   
> -	if (config->mode & ETM_MODE_EXCL_HOST)
> +	if (curr_config->mode & ETM_MODE_EXCL_HOST)
>   		trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
>   	else
>   		trfcr = etm4x_get_kern_user_filter(drvdata);
> @@ -307,7 +307,7 @@ static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
>   	write_trfcr(trfcr);
>   
>   	/* Set filters for guests and pass to KVM */
> -	if (config->mode & ETM_MODE_EXCL_GUEST)
> +	if (curr_config->mode & ETM_MODE_EXCL_GUEST)
>   		guest_trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
>   	else
>   		guest_trfcr = etm4x_get_kern_user_filter(drvdata);
> @@ -501,7 +501,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   {
>   	int i, rc;
>   	const struct etmv4_caps *caps = &drvdata->caps;
> -	struct etmv4_config *config = &drvdata->curr_config;
> +	struct etmv4_config *curr_config = &drvdata->curr_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   	struct device *etm_dev = &csdev->dev;
>   	struct csdev_access *csa = &csdev->access;
> @@ -533,37 +533,37 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   		dev_err(etm_dev,
>   			"timeout while waiting for Idle Trace Status\n");
>   	if (caps->nr_pe)
> -		etm4x_relaxed_write32(csa, config->pe_sel, TRCPROCSELR);
> -	etm4x_relaxed_write32(csa, config->cfg, TRCCONFIGR);
> +		etm4x_relaxed_write32(csa, curr_config->pe_sel, TRCPROCSELR);
> +	etm4x_relaxed_write32(csa, curr_config->cfg, TRCCONFIGR);
>   	/* nothing specific implemented */
>   	etm4x_relaxed_write32(csa, 0x0, TRCAUXCTLR);
> -	etm4x_relaxed_write32(csa, config->eventctrl0, TRCEVENTCTL0R);
> -	etm4x_relaxed_write32(csa, config->eventctrl1, TRCEVENTCTL1R);
> +	etm4x_relaxed_write32(csa, curr_config->eventctrl0, TRCEVENTCTL0R);
> +	etm4x_relaxed_write32(csa, curr_config->eventctrl1, TRCEVENTCTL1R);
>   	if (caps->stallctl)
> -		etm4x_relaxed_write32(csa, config->stall_ctrl, TRCSTALLCTLR);
> -	etm4x_relaxed_write32(csa, config->ts_ctrl, TRCTSCTLR);
> -	etm4x_relaxed_write32(csa, config->syncfreq, TRCSYNCPR);
> -	etm4x_relaxed_write32(csa, config->ccctlr, TRCCCCTLR);
> -	etm4x_relaxed_write32(csa, config->bb_ctrl, TRCBBCTLR);
> +		etm4x_relaxed_write32(csa, curr_config->stall_ctrl, TRCSTALLCTLR);
> +	etm4x_relaxed_write32(csa, curr_config->ts_ctrl, TRCTSCTLR);
> +	etm4x_relaxed_write32(csa, curr_config->syncfreq, TRCSYNCPR);
> +	etm4x_relaxed_write32(csa, curr_config->ccctlr, TRCCCCTLR);
> +	etm4x_relaxed_write32(csa, curr_config->bb_ctrl, TRCBBCTLR);
>   	etm4x_relaxed_write32(csa, drvdata->trcid, TRCTRACEIDR);
> -	etm4x_relaxed_write32(csa, config->vinst_ctrl, TRCVICTLR);
> -	etm4x_relaxed_write32(csa, config->viiectlr, TRCVIIECTLR);
> -	etm4x_relaxed_write32(csa, config->vissctlr, TRCVISSCTLR);
> +	etm4x_relaxed_write32(csa, curr_config->vinst_ctrl, TRCVICTLR);
> +	etm4x_relaxed_write32(csa, curr_config->viiectlr, TRCVIIECTLR);
> +	etm4x_relaxed_write32(csa, curr_config->vissctlr, TRCVISSCTLR);
>   	if (caps->nr_pe_cmp)
> -		etm4x_relaxed_write32(csa, config->vipcssctlr, TRCVIPCSSCTLR);
> +		etm4x_relaxed_write32(csa, curr_config->vipcssctlr, TRCVIPCSSCTLR);
>   
>   	for (i = 0; i < caps->nr_seq_ctrls; i++)
> -		etm4x_relaxed_write32(csa, config->seq_ctrl[i], TRCSEQEVRn(i));
> +		etm4x_relaxed_write32(csa, curr_config->seq_ctrl[i], TRCSEQEVRn(i));
>   	if (caps->nrseqstate) {
> -		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
> -		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
> +		etm4x_relaxed_write32(csa, curr_config->seq_rst, TRCSEQRSTEVR);
> +		etm4x_relaxed_write32(csa, curr_config->seq_state, TRCSEQSTR);
>   	}
>   	if (caps->numextinsel)
> -		etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
> +		etm4x_relaxed_write32(csa, curr_config->ext_inp, TRCEXTINSELR);
>   	for (i = 0; i < caps->nr_cntr; i++) {
> -		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
> -		etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
> -		etm4x_relaxed_write32(csa, config->cntr_val[i], TRCCNTVRn(i));
> +		etm4x_relaxed_write32(csa, curr_config->cntrldvr[i], TRCCNTRLDVRn(i));
> +		etm4x_relaxed_write32(csa, curr_config->cntr_ctrl[i], TRCCNTCTLRn(i));
> +		etm4x_relaxed_write32(csa, curr_config->cntr_val[i], TRCCNTVRn(i));
>   	}
>   
>   	/*
> @@ -571,32 +571,32 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   	 * such start at 2.
>   	 */
>   	for (i = 2; i < caps->nr_resource * 2; i++)
> -		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
> +		etm4x_relaxed_write32(csa, curr_config->res_ctrl[i], TRCRSCTLRn(i));
>   
>   	for (i = 0; i < caps->nr_ss_cmp; i++) {
>   		/* always clear status and pending bits on restart if using single-shot */
> -		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
> +		if (curr_config->ss_ctrl[i] || curr_config->ss_pe_cmp[i])
>   			drvdata->ss_status[i] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
> -		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
> +		etm4x_relaxed_write32(csa, curr_config->ss_ctrl[i], TRCSSCCRn(i));
>   		etm4x_relaxed_write32(csa, drvdata->ss_status[i], TRCSSCSRn(i));
>   		if (etm4x_sspcicrn_present(drvdata, i))
> -			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
> +			etm4x_relaxed_write32(csa, curr_config->ss_pe_cmp[i], TRCSSPCICRn(i));
>   	}
>   	for (i = 0; i < caps->nr_addr_cmp * 2; i++) {
> -		etm4x_relaxed_write64(csa, config->addr_val[i], TRCACVRn(i));
> -		etm4x_relaxed_write64(csa, config->addr_acc[i], TRCACATRn(i));
> +		etm4x_relaxed_write64(csa, curr_config->addr_val[i], TRCACVRn(i));
> +		etm4x_relaxed_write64(csa, curr_config->addr_acc[i], TRCACATRn(i));
>   	}
>   	for (i = 0; i < caps->numcidc; i++)
> -		etm4x_relaxed_write64(csa, config->ctxid_pid[i], TRCCIDCVRn(i));
> -	etm4x_relaxed_write32(csa, config->ctxid_mask0, TRCCIDCCTLR0);
> +		etm4x_relaxed_write64(csa, curr_config->ctxid_pid[i], TRCCIDCVRn(i));
> +	etm4x_relaxed_write32(csa, curr_config->ctxid_mask0, TRCCIDCCTLR0);
>   	if (caps->numcidc > 4)
> -		etm4x_relaxed_write32(csa, config->ctxid_mask1, TRCCIDCCTLR1);
> +		etm4x_relaxed_write32(csa, curr_config->ctxid_mask1, TRCCIDCCTLR1);
>   
>   	for (i = 0; i < caps->numvmidc; i++)
> -		etm4x_relaxed_write64(csa, config->vmid_val[i], TRCVMIDCVRn(i));
> -	etm4x_relaxed_write32(csa, config->vmid_mask0, TRCVMIDCCTLR0);
> +		etm4x_relaxed_write64(csa, curr_config->vmid_val[i], TRCVMIDCVRn(i));
> +	etm4x_relaxed_write32(csa, curr_config->vmid_mask0, TRCVMIDCCTLR0);
>   	if (caps->numvmidc > 4)
> -		etm4x_relaxed_write32(csa, config->vmid_mask1, TRCVMIDCCTLR1);
> +		etm4x_relaxed_write32(csa, curr_config->vmid_mask1, TRCVMIDCCTLR1);
>   
>   	if (!caps->skip_power_up) {
>   		u32 trcpdcr = etm4x_relaxed_read32(csa, TRCPDCR);
> @@ -694,7 +694,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>   	int ctridx;
>   	int rselector;
>   	const struct etmv4_caps *caps = &drvdata->caps;
> -	struct etmv4_config *config = &drvdata->curr_config;
> +	struct etmv4_config *curr_config = &drvdata->curr_config;
>   
>   	/* No point in trying if we don't have at least one counter */
>   	if (!caps->nr_cntr)
> @@ -702,7 +702,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>   
>   	/* Find a counter that hasn't been initialised */
>   	for (ctridx = 0; ctridx < caps->nr_cntr; ctridx++)
> -		if (config->cntr_val[ctridx] == 0)
> +		if (curr_config->cntr_val[ctridx] == 0)
>   			break;
>   
>   	/* All the counters have been configured already, bail out */
> @@ -723,7 +723,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>   	 * by 2.
>   	 */
>   	for (rselector = 2; rselector < caps->nr_resource * 2; rselector++)
> -		if (!config->res_ctrl[rselector])
> +		if (!curr_config->res_ctrl[rselector])
>   			break;
>   
>   	if (rselector == caps->nr_resource * 2) {
> @@ -733,7 +733,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>   	}
>   
>   	/* Initialise original and reload counter value. */
> -	config->cntr_val[ctridx] = config->cntrldvr[ctridx] = 1 << (ts_level - 1);
> +	curr_config->cntr_val[ctridx] = curr_config->cntrldvr[ctridx] = 1 << (ts_level - 1);
>   
>   	/*
>   	 * Trace Counter Control Register TRCCNTCTLRn
> @@ -743,11 +743,11 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>   	 * RLDEVENT = RES_SEL_FALSE (0), reload on single false resource (never reload)
>   	 * CNTEVENT = RES_SEL_TRUE (1), count single fixed 'always true' resource (always decrement)
>   	 */
> -	config->cntr_ctrl[ctridx] = TRCCNTCTLRn_RLDSELF |
> -				    FIELD_PREP(TRCCNTCTLRn_RLDEVENT_MASK,
> -					       etm4_res_sel_single(ETM4_RES_SEL_FALSE)) |
> -				    FIELD_PREP(TRCCNTCTLRn_CNTEVENT_MASK,
> -					       etm4_res_sel_single(ETM4_RES_SEL_TRUE));
> +	curr_config->cntr_ctrl[ctridx] = TRCCNTCTLRn_RLDSELF |
> +					 FIELD_PREP(TRCCNTCTLRn_RLDEVENT_MASK,
> +						    etm4_res_sel_single(ETM4_RES_SEL_FALSE)) |
> +					 FIELD_PREP(TRCCNTCTLRn_CNTEVENT_MASK,
> +						    etm4_res_sel_single(ETM4_RES_SEL_TRUE));
>   
>   	/*
>   	 * Resource Selection Control Register TRCRSCTLRn
> @@ -758,16 +758,16 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>   	 * Multiple counters can be selected, and each bit signifies a counter,
>   	 * so set bit 'ctridx' to select our counter.
>   	 */
> -	config->res_ctrl[rselector] = FIELD_PREP(TRCRSCTLRn_GROUP_MASK, 2) |
> -				      FIELD_PREP(TRCRSCTLRn_SELECT_MASK, 1 << ctridx);
> +	curr_config->res_ctrl[rselector] = FIELD_PREP(TRCRSCTLRn_GROUP_MASK, 2) |
> +					   FIELD_PREP(TRCRSCTLRn_SELECT_MASK, 1 << ctridx);
>   
>   	/*
>   	 * Global Timestamp Control Register TRCTSCTLR
>   	 *
>   	 * EVENT = generate timestamp on single resource 'rselector'
>   	 */
> -	config->ts_ctrl = FIELD_PREP(TRCTSCTLR_EVENT_MASK,
> -				     etm4_res_sel_single(rselector));
> +	curr_config->ts_ctrl = FIELD_PREP(TRCTSCTLR_EVENT_MASK,
> +					  etm4_res_sel_single(rselector));
>   
>   	return 0;
>   }
> @@ -778,7 +778,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   	int ret = 0;
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>   	const struct etmv4_caps *caps = &drvdata->caps;
> -	struct etmv4_config *config = &drvdata->curr_config;
> +	struct etmv4_config *curr_config = &drvdata->curr_config;
>   	struct perf_event_attr max_timestamp = {
>   		.ATTR_CFG_FLD_timestamp_CFG = U64_MAX,
>   	};
> @@ -787,22 +787,22 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   	u8 ts_level;
>   
>   	/* Clear configuration from previous run */
> -	memset(config, 0, sizeof(struct etmv4_config));
> +	memset(curr_config, 0, sizeof(struct etmv4_config));
>   
>   	if (attr->exclude_kernel)
> -		config->mode = ETM_MODE_EXCL_KERN;
> +		curr_config->mode = ETM_MODE_EXCL_KERN;
>   
>   	if (attr->exclude_user)
> -		config->mode = ETM_MODE_EXCL_USER;
> +		curr_config->mode = ETM_MODE_EXCL_USER;
>   
>   	if (attr->exclude_host)
> -		config->mode |= ETM_MODE_EXCL_HOST;
> +		curr_config->mode |= ETM_MODE_EXCL_HOST;
>   
>   	if (attr->exclude_guest)
> -		config->mode |= ETM_MODE_EXCL_GUEST;
> +		curr_config->mode |= ETM_MODE_EXCL_GUEST;
>   
>   	/* Always start from the default config */
> -	etm4_set_default_config(config, caps);
> +	etm4_set_default_config(curr_config, caps);
>   
>   	/* Configure filters specified on the perf cmd line, if any. */
>   	ret = etm4_set_event_filters(drvdata, event);
> @@ -811,14 +811,14 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   
>   	/* Go from generic option to ETMv4 specifics */
>   	if (ATTR_CFG_GET_FLD(attr, cycacc)) {
> -		config->cfg |= TRCCONFIGR_CCI;
> +		curr_config->cfg |= TRCCONFIGR_CCI;
>   		/* TRM: Must program this for cycacc to work */
>   		cc_threshold = ATTR_CFG_GET_FLD(attr, cc_threshold);
>   		if (!cc_threshold)
>   			cc_threshold = ETM_CYC_THRESHOLD_DEFAULT;
>   		if (cc_threshold < caps->ccitmin)
>   			cc_threshold = caps->ccitmin;
> -		config->ccctlr = cc_threshold;
> +		curr_config->ccctlr = cc_threshold;
>   	}
>   
>   	ts_level = max(ATTR_CFG_GET_FLD(attr, timestamp),
> @@ -840,14 +840,14 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   		}
>   
>   		/* bit[11], Global timestamp tracing bit */
> -		config->cfg |= TRCCONFIGR_TS;
> +		curr_config->cfg |= TRCCONFIGR_TS;
>   	}
>   
>   	/* Only trace contextID when runs in root PID namespace */
>   	if (ATTR_CFG_GET_FLD(attr, contextid1) &&
>   	    task_is_in_init_pid_ns(current))
>   		/* bit[6], Context ID tracing bit */
> -		config->cfg |= TRCCONFIGR_CID;
> +		curr_config->cfg |= TRCCONFIGR_CID;
>   
>   	/*
>   	 * If set bit contextid2 in perf config, this asks to trace VMID for
> @@ -861,13 +861,13 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   		}
>   		/* Only trace virtual contextID when runs in root PID namespace */
>   		if (task_is_in_init_pid_ns(current))
> -			config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
> +			curr_config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
>   	}
>   
>   	/* return stack - enable if selected and supported */
>   	if (ATTR_CFG_GET_FLD(attr, retstack) && caps->retstack)
>   		/* bit[12], Return stack enable bit */
> -		config->cfg |= TRCCONFIGR_RS;
> +		curr_config->cfg |= TRCCONFIGR_RS;
>   
>   	/* branch broadcast - enable if selected and supported */
>   	if (ATTR_CFG_GET_FLD(attr, branch_broadcast)) {
> @@ -879,7 +879,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   			ret = -EINVAL;
>   			goto out;
>   		} else {
> -			config->cfg |= TRCCONFIGR_BB;
> +			curr_config->cfg |= TRCCONFIGR_BB;
>   		}
>   	}
>   
> @@ -1061,7 +1061,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
>   {
>   	u32 control;
>   	const struct etmv4_caps *caps = &drvdata->caps;
> -	struct etmv4_config *config = &drvdata->curr_config;
> +	struct etmv4_config *curr_config = &drvdata->curr_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   	struct csdev_access *csa = &csdev->access;
>   	int i;
> @@ -1086,13 +1086,13 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
>   
>   	/* read back the current counter values */
>   	for (i = 0; i < caps->nr_cntr; i++) {
> -		config->cntr_val[i] =
> -			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
> +		curr_config->cntr_val[i] =
> +			     etm4x_relaxed_read32(csa, TRCCNTVRn(i));
>   	}
>   
>   	/* read back the sequence state */
>   	if (caps->nrseqstate)
> -		config->seq_state = etm4x_relaxed_read32(csa, TRCSEQSTR);
> +		curr_config->seq_state = etm4x_relaxed_read32(csa, TRCSEQSTR);
>   
>   	coresight_disclaim_device_unlocked(csdev);
>   	etm4_cs_lock(drvdata, csa);
> @@ -1729,7 +1729,7 @@ static void etm4_set_default(struct etmv4_config *config,
>   static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
>   {
>   	int nr_comparator, index = 0;
> -	struct etmv4_config *config = &drvdata->curr_config;
> +	struct etmv4_config *curr_config = &drvdata->curr_config;
>   
>   	/*
>   	 * nr_addr_cmp holds the number of comparator _pair_, so time 2
> @@ -1741,8 +1741,8 @@ static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
>   	while (index < nr_comparator) {
>   		switch (type) {
>   		case ETM_ADDR_TYPE_RANGE:
> -			if (config->addr_type[index] == ETM_ADDR_TYPE_NONE &&
> -			    config->addr_type[index + 1] == ETM_ADDR_TYPE_NONE)
> +			if (curr_config->addr_type[index] == ETM_ADDR_TYPE_NONE &&
> +			    curr_config->addr_type[index + 1] == ETM_ADDR_TYPE_NONE)
>   				return index;
>   
>   			/* Address range comparators go in pairs */
> @@ -1750,7 +1750,7 @@ static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
>   			break;
>   		case ETM_ADDR_TYPE_START:
>   		case ETM_ADDR_TYPE_STOP:
> -			if (config->addr_type[index] == ETM_ADDR_TYPE_NONE)
> +			if (curr_config->addr_type[index] == ETM_ADDR_TYPE_NONE)
>   				return index;
>   
>   			/* Start/stop address can have odd indexes */
> @@ -1771,7 +1771,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   	int i, comparator, ret = 0;
>   	u64 address;
>   	const struct etmv4_caps *caps = &drvdata->caps;
> -	struct etmv4_config *config = &drvdata->curr_config;
> +	struct etmv4_config *curr_config = &drvdata->curr_config;
>   	struct etm_filters *filters = event->hw.addr_filters;
>   
>   	if (!filters)
> @@ -1800,7 +1800,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   
>   		switch (type) {
>   		case ETM_ADDR_TYPE_RANGE:
> -			etm4_set_comparator_filter(config, caps,
> +			etm4_set_comparator_filter(curr_config, caps,
>   						   filter->start_addr,
>   						   filter->stop_addr,
>   						   comparator);
> @@ -1808,10 +1808,10 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   			 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
>   			 * in the started state
>   			 */
> -			config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
> +			curr_config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
>   
>   			/* No start-stop filtering for ViewInst */
> -			config->vissctlr = 0x0;
> +			curr_config->vissctlr = 0x0;
>   			break;
>   		case ETM_ADDR_TYPE_START:
>   		case ETM_ADDR_TYPE_STOP:
> @@ -1821,7 +1821,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   				   filter->stop_addr);
>   
>   			/* Configure comparator */
> -			etm4_set_start_stop_filter(config, caps, address,
> +			etm4_set_start_stop_filter(curr_config, caps, address,
>   						   comparator, type);
>   
>   			/*
> @@ -1836,10 +1836,10 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   			 * etm4_disable_perf().
>   			 */
>   			if (filters->ssstatus)
> -				config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
> +				curr_config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
>   
>   			/* No include/exclude filtering for ViewInst */
> -			config->viiectlr = 0x0;
> +			curr_config->viiectlr = 0x0;
>   			break;
>   		default:
>   			ret = -EINVAL;
> @@ -1851,7 +1851,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   
>   
>   default_filter:
> -	etm4_set_default_filter(config);
> +	etm4_set_default_filter(curr_config);
>   
>   out:
>   	return ret;
> 

