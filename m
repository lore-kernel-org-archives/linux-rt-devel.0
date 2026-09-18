Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDC34EEFD
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740292; cv=fail; b=rDUVRap7ODJ7ashecuF5LjiZmKJYDipJOuE0ITtjZqJlQqpKnKWYAbyf3eqSuwOgbvgPyuz+NeUnygCX1qPSqdxPwq2ZVzaBQZDPv3MIXWvayJ9S4YPidQfnrwbSa83wa5yHW0VsOSlD40uoOSW5penPjQtg20n/4mjneqFOn0E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740292; c=relaxed/simple;
	bh=EYAVD+sQBIb+Qw6R2PHG2tg/PqhxCNFdxvLw5rMUp9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nQRGb2sEJhO2Rf1Zkl8OE9lq2wH6qCwgivZoUZBv5FBd4Qs3pxHtgarWT7e/qsCRw8xsc4UReYkUqzlxy5FNKM94m2B148f0pbs4P63UYrV/zwqma3drVdOB2LrQ650SgPUTqrPMhG6+DdrVXQ29FTrYnp2Jr4yN4QgEc4F5Iz4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XWdPKoFB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XWdPKoFB; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XWdPKoFB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XWdPKoFB"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=l2JbRHHRN1BPAcVP/eXhCnU7Zw1CT/rfH05S+/8QmgNPLFCH9a3273kgSyDT1zDrYSize0vAPUUHeDdszPLJqHITD71ENym7YakGIW/BcLeWAlUhjYGu0HVsLn33tv0gZn6bNO5o27FB2wOlEbpiLp/4XjFtXu7jQxua0j6pMr/7deaC2a6oATDVokAaz289JKlzcRtCtIuDVsM+BCiQvn7qMLqpA60g+0JzwQwwUY/1Hkqyaf8lCsBPcjyQID5uT4f/InvnA/RRExO4sJ1As9L/nztr2Y9UWCsXp8T2qKVykXGdK3jDYfhWv2Tcc441etzrp9S9noTFjr3lPtTC+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecgBncPB496y+REBuiOtQ+oR2koDyXeh5TEqP0IBmRM=;
 b=drpHXkRp02cA2Uk/0O2VulDxtfN8zKvvm573Mw+yJ5WT+ZI1IQfkrcz2PJMps9dO3JAA9Ca+A7kz/yNnXV4jKENQqJbDqXRTLcrlj3HcOJPC+fylDTWVWQH5G4ZQ/uxvqHpD3/SiSwmVvrW+zOMwsrWKBapHBUfBayQOnKABJ2O67yvmUyF/nkJ3jnoxmOeUpks+VT/pj2RiVvFjSdvbjAPN3clPz2woNJDAclc4HGbxWk9dir/GPedeXp5gAuPFlg1PYdNtXjOjy0wmYZCDRBZQ0MGr7iiUro7kZBZGwSwm+adPUSkawcSC41kYYI9PwLjcJq8pZB8PcxJ/17Owsw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecgBncPB496y+REBuiOtQ+oR2koDyXeh5TEqP0IBmRM=;
 b=XWdPKoFBWpf++f5wPDDDKvRUSpCHkygRTqG4pv/xq/xxPGrXkS6PFAZ88tq6GjrbXY6PUamrXS8sr2Q7eTlJDqjhW3jjMXecf1Ym/lXFt4/2zieP1zXC8GtrlnB3mKlkTzJNYngVttbcx3P2boNnJq9fyp1mk6d0IBhDajNqxnY=
Received: from AS4P251CA0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::12)
 by GV1PR08MB10369.eurprd08.prod.outlook.com (2603:10a6:150:a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Fri, 18 Sep
 2026 14:04:44 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::4e) by AS4P251CA0010.outlook.office365.com
 (2603:10a6:20b:5d2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 14:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 14:04:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzltvgbEqI5poEf13DNXpsn0n/cFctKS62cVA9QWUYGPvrftnuXpCeuKANG7YjuM7jGOYO7m5nbxzBMvz58tRCgjGEmc1P5Ix7aklEF02WAmyn4pRmpryRSkZmTJhIyvObbBRTFh/T9x3CRLN3fvf0wUc5QIk82Ixo5TopSpe7RkUabEM2Kku03iRd8M9nNXO5zbYBW1n762RlkTC2IrN1YqfsCFZLh1fB51u3sEnDyfOPw2l+nMrP6XErCEeD3oh3oFIhWYFp5S8M+CrnCZCQEgZlph9+7Y3q150LZjE+MhEQk15NgNQbgcWnXoolCLuOsDl49ZLbd0+kt97k9K8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecgBncPB496y+REBuiOtQ+oR2koDyXeh5TEqP0IBmRM=;
 b=rI4uuq+Y4ovsWp8v4rThiKhW4Q+dOymnNNilWngwKyZdtyHi0rGmgX3X1G/5YA2GVkngth/Qyl3TJmnSITHSqZV0qxgmN7M4700KEt1RP0hN6QeLF8lTsWaMt39qWXIXzKV8oiU8YsyDSbkzgi/HYmJzgWvXm3k+TZIF+GxlQIUmgTp6tTz6W4Vfi4dxfgfl00zpbZ3j5ns6RrN/bmVIiaOs3oziUv1eGm12jdFqRZ0WhHyOXCJE1ePHdr0VR6pMJSpA7plfBsWqaY/KiJ6pDIUPPzTXso8hdf6WmevOTwC67uWU9f9lKLufViKXJAyX1h9jr8+2wKbfR60/QOQ2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecgBncPB496y+REBuiOtQ+oR2koDyXeh5TEqP0IBmRM=;
 b=XWdPKoFBWpf++f5wPDDDKvRUSpCHkygRTqG4pv/xq/xxPGrXkS6PFAZ88tq6GjrbXY6PUamrXS8sr2Q7eTlJDqjhW3jjMXecf1Ym/lXFt4/2zieP1zXC8GtrlnB3mKlkTzJNYngVttbcx3P2boNnJq9fyp1mk6d0IBhDajNqxnY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DU4PR08MB11008.eurprd08.prod.outlook.com (2603:10a6:10:570::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 18 Sep
 2026 14:04:10 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 14:04:10 +0000
Message-ID: <32d15bef-4ecd-45eb-8d4e-1a4276eb6e15@arm.com>
Date: Fri, 18 Sep 2026 15:04:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 7/9] coresight: etm4x: exclude ss_status from
 drvdata->config
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
 <20260915-separate_etm_cfg_v2-v11-7-d2b258d51747@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-7-d2b258d51747@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0318.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::8) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DU4PR08MB11008:EE_|DB1PEPF000509F7:EE_|GV1PR08MB10369:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0c2586-70a1-41f8-2082-08df158dca19
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|4143699003|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 rKPgVQwB3PS9dkoweeL2pJpskfIjhpvQL2V9Dt/YQJ2uzWLI0XZmgu/9QwFuJYd4ZwE18jcdkWPYr+3CQCs2bu79Ha/Ct32D2COrZl7yhe6i5UxEQkRE43zcj1KUtM3xdodcOlD3vUyiV18Da1D9naqUj5YNvdK6BpsNGCwGqB9yOOpAeTzQAIg9lwX3LfqpdurWKxgbQx3CXLu5ibDFlgooE0ztY9ck/7pH0yls3t5QnzEMthw7umYkRvN1L7yHnEvym0mp6z2Ep+SBbKdLPxKXe0LryeQQFyMKOGme+Mr1xg5RysjAMsb0Zp7fUUGfCaB+0ROBP/vWaEjnbREvAT+NFoPfHw1qReB/1ooxDhHQ33X/QbF4ECA7SJslFx8RgUU9lGwPQXJzbF8gEMZ2DxZTKNLhJfd6LOKUHShNkug8P1RPZCI+mYcuSaHcdTk5I1+ZjmGEzr3KMXiJret6lSFirsj4Fh0l6F+UwBMnNIXTajujZAFa3wEccli8chd0danCJDqmi6w72JHkMnxy7bxoQAVB3a1DCljFQgGOOBVQ+11ej/xy1844JEgM+q6KrhqAIZ/kvIg6zztyOCEZwdgxeklUNAHQdLQvibhs8sxTKyJZj9s+XHqX1sBFquo8xfN5W9Rouv+ra0iQGoYVSoKsE0BLKH8UnwHQxCb10K0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 IQ6CvBVPpFSJ2Fho5gn3FKAHb98Mrg+V8EXvcoBUpazQVtCCWOBleMrMIYE1bJaYaiYqDm+e1csAh/espqRAdXvGIUY5GwC3isSIQgQt90PBZWkaG1cN+FEdueYe2dO8f560Ummx1xX8o67uqLHvrZWwbQE6t+DvqzSTs+5w5/BOsMmcDFIjEmkAqv4bfj1VOqKagRMAUrROa64j41wV+jFP9p8n3JZZcamoLqflywF0jaQv8bIFczmZt9hArR9o2Bdk8R5VbjlWqZb5Z85prhoiv5o+zbPkQ9cEp63mHYNv6TaBXvPkfsM1Je3mTCgak546CEW8gi39152MUJ6xiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11008
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e46d5726-5f10-407a-d246-08df158db658
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|35042699022|23010399003|7416014|14060799003|82310400026|36860700016|18002099003|56012099006|6133799003|22082099003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	j0egZeKNJXKHvN74nsPdFPhrSDCTUQSwdUnYw7IHLXu7BWr/kLeJdIsNWps2VT5cSC2PHA5E/HlKg0mXdOE7GTiITMJXfqdJmKZps35lQ55ykus5gLKY8LsJQXx9ku2IlZAkKz8bf2PUzlPGYip/QTGaWYcFc/2QfyKJ5PcM1A5xFMdq9rpw8GCXSTucHiFeChCOXdrQ5JiZ8+sxslk6W93NGtvv3z5oKi6b8FXgeWmgAU3UAXhKR6swY3NfFiDka+6VKgQVGR9Hhi8LHldWHNZWKL9HHB722NoAAi7XZh37iY5ANoiwBRqxxEZ81txwXC0RTNlngabltJCJql3b9k4aXP9muYf7EwKDpM2o19F/tjlrUbx7O9PvBUoyR9lybsv4n2BZhe/e/lWYWmrFJFZz12ueZNjwe8NUqCGlfXDpS07xS+wc4ngx4x4SRZSXFM1iJQn+11v1HMAVIIeWbylT0cAbQy88xMx/GnxnQjgEmRbb6PC0zoWjPuAHTDImd8e0hriCE3lYtcyjc7F1ZcnFuu2OWxhT4pI1F5Da8U8QZfqdWq+04ox9ytQQYiKNz1VHVM42svZ77RDZo975GRMVXkgWZAbrHig/2isLFmNP0qgsONixF4aOsz85/Yn0mAZl3YCBCCLYjEw9GaHxME0BBIhP+dHJRt0VxTfebksO1GCA0064QG2nmjGsoVYcq9DNdti5inaRC2Nj0Cg5cA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(35042699022)(23010399003)(7416014)(14060799003)(82310400026)(36860700016)(18002099003)(56012099006)(6133799003)(22082099003)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dDifCCirZNkrvAxRJr3fqbPrQv+YvEUraZbxjdzWB4uWVNMbO8eNom2nj6kdOxAzwPEouImm28UevL8jWOODX9+ZDQtahF52k5++lN/FxomXNOFd8ngGtA4RlfosfWt4I7v7lL056/Ntiy03G1nCaYpKxHX7dG26f8ZwcuOtZm+Cb6FxiDIz5qzMU+aAZQ6hCDvg+q/8mUTYs8ERbzjYZgzh5h5E1xAJw4RME68MFoE1zbff2zaRGE7JKBaDpZZr0/svJTpOdFymK+mYQ1BYg4E6sPX+0gfMUSk25n+OJab74WZs4erUmQdgLbYVmBCDJvhD8Qp9M9cu/wOx8m35zW/5PhRM1qh4l4i+f2HQfys5LIQCTPTIlwapxSugOwXF7g5H/IYVNa/dk0mlfO3EQM5B1Es3jnwKqEdeyov66NwVOGnyfRZd4kvMGhO6X/Hh
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:04:43.3872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0c2586-70a1-41f8-2082-08df158dca19
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10369

Hi,

Actually replied to v10 of this patch before I spotted v11. I'll repeat 
the comments here to keep them together.



On 9/15/26 12:34, Yeoreum Yun wrote:
> The purpose of TRCSSCSRn register is to show status of
> the corresponding Single-shot Comparator Control and input supports.
> That means writable field's purpose for reset or restore from idle status
> not for configuration.
> 
> Therefore, exclude ss_status from drvdata->config and move it to drvdata.
> 
> Before this patch, clearing the PENDING and STATUS bits when enabling
> a perf session could trigger multiple single-shot events within
> the same session. This issue will be addressed in a future patch;

The hardware is designed to have multiple single shot events - the reset 
bit in TRCSSCCRn specifically programs this behaviour.

But the basic point is correct there is no need to have the status 
register as part of the configurable set of registers.



> this patch intentionally preserves the existing behavior.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-cfg.c   |  1 -
>   drivers/hwtracing/coresight/coresight-etm4x-core.c  | 20 +++++++++-----------
>   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 10 +++++-----
>   drivers/hwtracing/coresight/coresight-etm4x.h       |  7 ++++++-
>   4 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> index d24f533c623d0..098aabd2b922c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> @@ -86,7 +86,6 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
>   		off_mask =  (offset & GENMASK(11, 5));
>   		do {
>   			CHECKREGIDX(TRCSSCCRn(0), ss_ctrl, idx, off_mask);
> -			CHECKREGIDX(TRCSSCSRn(0), ss_status, idx, off_mask);
>   			CHECKREGIDX(TRCSSPCICRn(0), ss_pe_cmp, idx, off_mask);
>   		} while (0);
>   	} else if ((offset >= TRCCIDCVRn(0)) && (offset <= TRCVMIDCVRn(7))) {
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 70a5c0b4fad1c..9de0c268ff954 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -95,7 +95,7 @@ static bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
>   	const struct etmv4_caps *caps = &drvdata->caps;
>   
>   	return (n < caps->nr_ss_cmp) && caps->nr_pe_cmp &&
> -	       (drvdata->config.ss_status[n] & TRCSSCSRn_PC);
> +	       (drvdata->ss_status[n] & TRCSSCSRn_PC);
>   }
>   
>   u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
> @@ -573,11 +573,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
>   
>   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> -		/* always clear status bit on restart if using single-shot */
> +		/* always clear status and pending bits on restart if using single-shot */
>   		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
> -			config->ss_status[i] &= ~TRCSSCSRn_STATUS;
> +			drvdata->ss_status[i] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
>   		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
> -		etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
> +		etm4x_relaxed_write32(csa, drvdata->ss_status[i], TRCSSCSRn(i));
>   		if (etm4x_sspcicrn_present(drvdata, i))
>   			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
>   	}
> @@ -1081,7 +1081,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
>   
>   	/* read the status of the single shot comparators */
>   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> -		config->ss_status[i] =
> +		drvdata->ss_status[i] =
>   			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
>   	}
>   
> @@ -1162,12 +1162,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
>   				 drvdata, 1);
>   
>   	/*
> -	 * Userspace may read ss_status and cntr_val through sysfs after
> +	 * Userspace may read cntr_val through sysfs after
>   	 * the sysfs-session has been disabled.
>   	 */
> -	for (i = 0; i < caps->nr_ss_cmp; i++)
> -		config->ss_status[i] = active_config->ss_status[i];
> -
>   	for (i = 0; i < caps->nr_cntr; i++)
>   		config->cntr_val[i] = active_config->cntr_val[i];
>   
> @@ -1525,8 +1522,9 @@ static void etm4_init_arch_data(void *info)
>   	 */
>   	caps->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
>   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> -		drvdata->config.ss_status[i] =
> -			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> +		drvdata->ss_status[i] = etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> +		drvdata->ss_status[i] &= (TRCSSCSRn_PC | TRCSSCSRn_DV |
> +					  TRCSSCSRn_DA | TRCSSCSRn_INST);

The unused bits in this register are RES0 - rendering this masking 
redundant.

>   	}
>   	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
>   	caps->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index f6d053f73264c..50ef2e957300f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1833,8 +1833,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
>   	raw_spin_lock(&drvdata->spinlock);
>   	idx = config->ss_idx;
>   	config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
> -	/* must clear bit 31 in related status register on programming */
> -	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
> +	/* must clear bit 31 and 30 in related status register on programming */
> +	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
>   	raw_spin_unlock(&drvdata->spinlock);
>   	return size;
>   }
> @@ -1848,7 +1848,7 @@ static ssize_t sshot_status_show(struct device *dev,
>   	struct etmv4_config *config = &drvdata->config;
>   
>   	raw_spin_lock(&drvdata->spinlock);
> -	val = config->ss_status[config->ss_idx];
> +	val = drvdata->ss_status[config->ss_idx];
>   	raw_spin_unlock(&drvdata->spinlock);
>   	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>   }
> @@ -1885,8 +1885,8 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
>   	raw_spin_lock(&drvdata->spinlock);
>   	idx = config->ss_idx;
>   	config->ss_pe_cmp[idx] = FIELD_PREP(TRCSSPCICRn_PC_MASK, val);
> -	/* must clear bit 31 in related status register on programming */
> -	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
> +	/* must clear bit 31 and 30 in related status register on programming */
> +	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
>   	raw_spin_unlock(&drvdata->spinlock);
>   	return size;
>   }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index ffde48b6b41b2..8c1c1364b1c44 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -213,6 +213,7 @@
>   #define TRCACATRn_EXLEVEL_MASK			GENMASK(14, 8)
>   
>   #define TRCSSCSRn_STATUS			BIT(31)
> +#define TRCSSCSRn_PENDING			BIT(30)

Minor nit - PENDING is ETE only - worth commenting in case a reader is 
looking at the ETMv4 spec.

>   #define TRCSSCCRn_SAC_ARC_RST_MASK		GENMASK(24, 0)
>   
>   #define TRCSSPCICRn_PC_MASK			GENMASK(7, 0)
> @@ -730,6 +731,9 @@ static inline u32 etm4_res_sel_pair(u8 res_sel_idx)
>   #define ETM_DEFAULT_ADDR_COMP		0
>   
>   #define TRCSSCSRn_PC			BIT(3)
> +#define TRCSSCSRn_DV			BIT(2)
> +#define TRCSSCSRn_DA			BIT(1)
> +#define TRCSSCSRn_INST			BIT(0)
>   

These new defs are redundant if the masking above is redundant

Regards

Mike

>   /* PowerDown Control Register bits */
>   #define TRCPDCR_PU			BIT(3)
> @@ -980,7 +984,6 @@ struct etmv4_config {
>   	u32				res_ctrl[ETM_MAX_RES_SEL]; /* TRCRSCTLRn */
>   	u8				ss_idx;
>   	u32				ss_ctrl[ETM_MAX_SS_CMP];
> -	u32				ss_status[ETM_MAX_SS_CMP];
>   	u32				ss_pe_cmp[ETM_MAX_SS_CMP];
>   	u8				addr_idx;
>   	u64				addr_val[ETM_MAX_SINGLE_ADDR_CMP];
> @@ -1071,6 +1074,7 @@ struct etmv4_save_state {
>    * @config:	structure holding sysfs mode configuration.
>    * @save_state:	State to be preserved across power loss
>    * @paused:	Indicates if the trace unit is paused.
> + * @ss_status:	The status of the corresponding single-shot comparator.
>    * @arch_features: Bitmap of arch features of etmv4 devices.
>    */
>   struct etmv4_drvdata {
> @@ -1091,6 +1095,7 @@ struct etmv4_drvdata {
>   	struct etmv4_config		active_config;
>   	struct etmv4_config		config;
>   	struct etmv4_save_state		*save_state;
> +	u32				ss_status[ETM_MAX_SS_CMP];
>   	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
>   };
>   
> 

