Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235850EBEA
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739900; cv=fail; b=cexOK0vTwNOiNRq6F2lZgpx/f48ASQl1C8url4BAnfPf6Jc25IcVU3e/apMsU0AHvh3OhsAg20w3PcyRNc0iRa+ELTXMdfMADmv+JKaD7WC/jIjl8fovbXCAnExQi8Y9cMNojKdqeRoum9GreQmiNtAUyV2Paex1o0QL4s0QytQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739900; c=relaxed/simple;
	bh=twmy9xZrpRFw4cIEKeszMc2QPeIPSiAf8v/LXW94qVY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r56xBeQLj8Vy9+wi1khdNJMqZmeetH89UaeKPcP+89+B0pz0IIciFSZPNfS+wSD19mwTF5RqAbhQrItgp4/6PXwSBlJVDSi8dkA2mPRGj/wiQiwq2f6tLx5AXacgHrStu+gsk/2Ymp6QfrNg7dpPiObmHPo0wtnwkUGbMuVXq3g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZOVl0yuI; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZOVl0yuI; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZOVl0yuI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZOVl0yuI"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NwklkHVo+OWdevj1ZKBHt2Wn/5ELXtFioB5wQzrKzy/v2q9TZD/Xt/arkIg7L08okQJ26CTdapZErphtNuY/8KWrnc8LkNSJht0QQT7A5T8XIs+WAHxr8GPRYrXE3Rf5xeJTSWPx3bi18BJjjfu9yM7+Vc5WtSMuIK7cnNTjxVotKEa4BPONk+JkNosxzMH5Pe9ar/GXK5w5vro9dFPDUHw53WV1y3fYHNeJk9znyWo1DcfWvJ6gY91y1eTP5o5JVDoH+76CqtOhdzzPhLk2ozGwpLF0zikPlUbewDIIyr4om+zEokUGceFNvG2g0NcXKx+Tx8SXBzZj34u1KO4wwg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXU9KucFyfOHLtuPjWyUNB8hyeFkfV8BxyIGIBQdjA8=;
 b=TYajpe7qQPVY9VHDqWw+h/84JkObaWi21Om4DxwsWEHVTHd6u9P1Rn5ZEVjWrcE/PQDejRDQyquFBcvpczup3X8Q90DICfRpdjkNOMu1B6NZ92TlxLnZ587dqyTmsQzhOjJQ6O7kg1eeJxZxcI4Zreln+IHaijlg8iVtr41Nt6tpg/ok5L7doImAkO303V7eM/qQ64gh6yZADIzhgG53rhw8e+P/eYnqrG0urhhIDlHTVqgOwhjvBLYCl5+OnDZ/QZSntD3LCH73wmUPEu8tbQeoUQrjido0pEcMNRTohi0ylQWMM0ln7L4r7QwAe/ilsSgjormoeZaN8Ts3rMKqLQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXU9KucFyfOHLtuPjWyUNB8hyeFkfV8BxyIGIBQdjA8=;
 b=ZOVl0yuIH/HjK+CG5HqGTPlcSFckYrC2mH6P8ObdL2eIFDy5p7/yLrbOpPMP41ySQRNwGwDrnMHhUPXmZwy+SnXzL5501ANNB7kcGMyKp7jmcsZAKbvHXovXDIjm3xGALsKLZz138gktJFWVr6qfJ9BiIM22FXBjIDCtP6BwVUY=
Received: from AS4P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::11)
 by AS8PR08MB6712.eurprd08.prod.outlook.com (2603:10a6:20b:393::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:58:12 +0000
Received: from AMS0EPF0000056C.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::5b) by AS4P190CA0018.outlook.office365.com
 (2603:10a6:20b:5d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 13:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000056C.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 13:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nw+uy4EiIK4NFj06tMpnUCGTlv+w88f7hHrAxvszGSAgAjNeWxf30wykH7eoxDBTNlehH84Y4gXpm/Ww4AvgH8kkfQ4mBEVWbnxNDqotAnmWrtRD/5LDs1BttRYqnxh3l8DaZLVqrLz5k2XqRuNh6El925xuTA/eovvl3sPfpdqOKEJ8mvHpYKVVBMmZ/9RMn11V9LESvhC1HdH3OwovTCfFqkg8P/5hQ1TRaXLK82nVjrZMehx8XxSMm+IgZEqTsC/AsPeM+9ipEXWBOHhy8VGpwrlxImXmGdgeQQq7uvVchCRvG1q+upy1IaidU1jrGFkFR0BU0Nk/iTMrw0uxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXU9KucFyfOHLtuPjWyUNB8hyeFkfV8BxyIGIBQdjA8=;
 b=hgq7CkV+ym2idau25hjQX+72io0BmRsvXSQMDdPR/iZ7i7b9tW1bT7SyADjgSa0MCrHyrETh+NT+T7i0WHFpYodwnhL/jNGH1mz7U4DrAoTMQm9qSpwFRytTbX4IS3N9sFYmffCTNdX7MwRxopQRWsEdLB//GA8h9kjqtSe7RvSdgcLDXWLcldLsdrXa+el+oC5nqsIccECvCeDdJz6qoOTu3Ib5XwuYePVsK9QaB0fFPEp9rhDaAueEuqsSpNRjea37/i8s1dq4Jf5VXBB6Tx3OKDN/U3zxR+P4G+/6MsDPcihrmL+tgVdf0yWbfWHq52pgknKw08KklxvCZzCDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXU9KucFyfOHLtuPjWyUNB8hyeFkfV8BxyIGIBQdjA8=;
 b=ZOVl0yuIH/HjK+CG5HqGTPlcSFckYrC2mH6P8ObdL2eIFDy5p7/yLrbOpPMP41ySQRNwGwDrnMHhUPXmZwy+SnXzL5501ANNB7kcGMyKp7jmcsZAKbvHXovXDIjm3xGALsKLZz138gktJFWVr6qfJ9BiIM22FXBjIDCtP6BwVUY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DU4PR08MB11008.eurprd08.prod.outlook.com (2603:10a6:10:570::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 18 Sep
 2026 13:57:32 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 13:57:32 +0000
Message-ID: <9b7086de-df87-4d5c-8a7a-fc2f7c724c0b@arm.com>
Date: Fri, 18 Sep 2026 14:57:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/9] coresight: etm3x: fix inconsistencies with sysfs
 configuration
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
 <20260915-separate_etm_cfg_v2-v11-4-d2b258d51747@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-4-d2b258d51747@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0056.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::31) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DU4PR08MB11008:EE_|AMS0EPF0000056C:EE_|AS8PR08MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0a5ed7-d63d-4492-acbd-08df158ce0e7
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|3023799007|4143699003|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 XlokwWaQX6t3taJolBSy7GuH9vKoPFrgF39JQA9Wdc+oN3ywtpVXgFLErcGq54SPFJpZ8BN3UOT+XUK3nza4c/8D8T9+k6cHyteyf7if9kemuYVFosuvPg3+0mTHfprOPsZdNdOjhOQc/BZdz/PAyAkDPzVpc7Nk5iTQ8j7lq2rxgxkg/+PnDJzkilG27iN231IWilkKkGDSUumw562k/1KQdLx76Ph7FItkKRNcG+QMSNKJH67OdDLRu6frAtW9lOLE/juyThuWbwb+QXiGoOCf2vVGQSjdOFjKTzXWyaDkgjrAvy6sDqvrN7nzh+pP1GZvPxuHL+9pSpA3bW06+Z4A3edrG6joY1sRWGq3ahhjgfeFwrYq0BMpU9jGBrapsJsT9Libw1aC7lYZl1YxwYM73RZME+iJjQvO4UHrWkdEyEMKcfOlgYcmH/YhEnyXVSrYtyTY/EK+wpAwz5Ppu2u1+F8cbETIuH3OcaA9FwsXSS4rFbLofeLJpIihyEOiaL64glbf9Bjt5/Gf9+POJXZ2OULpX43iSOi0tOIdlF9fbKBFKA5CYtCd5TUWXLvJC0Wic6sqo4spjFuZlHSpBviePLohH+74OHdtQNE8dxStlRXp+KpqDesNNe1jQWS439GbKFB3JlkvIWdmuvhVC7AB515bHjzomZTTWJcmMyE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(3023799007)(4143699003)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 N/JxJZ/WW8k8UhE8LFEKwKZlRsNdydJSsl3BqlquN4CzrCEn7M/TsO7Hg+YCq5Vc+u1gWMqrCrCv9GMhhxup6NpacQEd4ipTcw7MBzTFov13dpEGjYAmeCkDQerSLeCplgg+dpRHAQGc6v046opdA5nBpv3JO2q76AUJ0WDEAxYov7EuJEQZxy2ZI7b5vXsd4CGMU/TDLGiSny/wS+LJTIiP6SEpX46qKVzTkJb7mRXGfVA5UFPfjBR2CGaXPZom5+uyjgepD9nBH9sjNwdRMSDdjL6AXjrb0Qrtj2RTmNh5UbH0GDSxwWGgOeyYtUJcAc9j8gTPYPH/Dps96771Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11008
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000056C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7f03c133-c96d-4715-ba61-08df158cc8c1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|23010399003|36860700016|376014|1800799024|7416014|35042699022|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AMNTBOmPh/XR4MlGv9pYH7862tf40ODS/VauCAMy4Xj6a5vEhrUPEwZS0Igj8yQKcrcnQmEH+CUaya/K+4aMgIRTMLU6SmrjPPnEF25v+LIi2+cPbjhEHgm4ssbPIRb1FfbfLg6BiAagHWUunlGXIVxLsOrSCA7yMn+ARJ031u8hHnqt9MYeOEC1qXiUXKB+Y+Mfgcfb76VkJTHbjRUuT6taG5sgwGyGVdIMowcFPBYYrVbiJ1jtdjsgAjykrK2WEhDWYe20vbumwRk/2PcbK8I0CHhjxUtIqEn5y7whJsKM4wyvnjvQvsN4+cqUUffRQl/ceexmx15wRfq57gucuGNbjQj+Ksnu+SO9Mh851f8Nh5PjP4UdxR7Fkuaql4KZgvEy4piUK1FcEwXdxSDYQE5baNRAACHd5vFpwe4RnRXINNrj3xDvUb1khJmvPmPPPTi2Q33M2bClfnoTUt87VcIeKwYYAB6hD7O7/1RBcK0A4xOPzeW+HaQAVuWH2NyV8ahyVtRyOZNFetQ6eeXVJJyQ4bhWJHpmFLXVN/UH4o5EMDI3QFPOe8VZlTgvPHaqVwrdIHTNPcmZEkhHRsq2NxB1R0ZuSYUGYADQ0gk25QWmgi8XUco63I/133x7fqQXtVA4Oz0YPktVVuNDNidM3AXJGZBXHNd+2yLGReud+k7lE9+U1xlj5Sjn7L81fojDDEOxZAJ494VBuP0K2Ci+fw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(7416014)(35042699022)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zerbA3A3jPfzvSUZ9Ga6vJuj6rTQ6ZTknAMZw+89YjxGu6fQ9Be2AX57o9iKd/Df8cpG2rPRNTpQuVynFbZ2OdMnUFOs7fBJ/EeSEiO46vxVYPQJIWzS4AJsO7uehB+SlLIyP3hCeXXOGCSud3sUoxf84ayFKt4yFTufkJowih+qArP7lboQLnPv36zZKIy+hGJ1IK5SLZV1NI+4b6lbiVQQQi2QmwXKUYwgSvAFN5kGG1SCHNVSUbHPOE8Vbhl3F2I5jjnK5yhFlVsQNaupUzJbiZrG2tUALmN/LelzuKSz5jDgM4KXwP8WhjZbpdVeEM/Cxmj6gv5B/BTj7oXCaPs0iUjL1r7iVBpp5rhBL6jeyJtOfbZDyhClPaRTqTmXWWSVBKrZj9d613DKtHuggl0SCPXhVUFasdkEBz2QcW3ZC0ACiOzb9WQNBi2WFLef
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:58:12.1751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0a5ed7-d63d-4492-acbd-08df158ce0e7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000056C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6712

Hi,

On 9/15/26 12:34, Yeoreum Yun wrote:
> The current ETM3x configuration via sysfs can lead to the following
> inconsistencies:
> 
>    - If a configuration is modified via sysfs while a perf session is
>      active, the running configuration may differ between before
>      a sched-out and after a subsequent sched-in.
> 
> To resolve these issues, separate the configuration into:
> 
>    - active_config: the configuration applied to the current session
>    - config: the configuration set via sysfs
> 

Same comment as for the etm4 config naming


> Additionally:
> 
>    - Since active_config and related fields are accessed only by the local CPU
>      in etm_enable/disable_sysfs_smp_call() (similar to perf enable/disable),
>      remove the lock/unlock from the sysfs enable/disable path and
>      starting/dying_cpu path except when to access config fields only.
> 
>    - Some of sysfs interface read etm register directly. To reduce lock
>      scope while the etm_enable_hw()/etm_disable_hw(), handle it via
>      IPI so that registers could be read from on proper CPU.
> 
> Fixes: 1925a470ce69 ("coresight: etm3x: splitting struct etm_drvdata")
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm.h        |  4 +-
>   drivers/hwtracing/coresight/coresight-etm3x-core.c | 68 ++++++++++--------
>   .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 80 +++++++++++++++-------
>   3 files changed, 100 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
> index 1d753cca29439..f3796162168d4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -226,7 +226,8 @@ struct etm_config {
>    * @etmccr:	value of register ETMCCR.
>    * @etmccer:	value of register ETMCCER.
>    * @traceid:	value of the current ID for this component.
> - * @config:	structure holding configuration parameters.
> + * @active_config:	structure holding current running configuration.
> + * @config:	structure holding sysfs mode configuration.
>    */
>   struct etm_drvdata {
>   	struct csdev_access		csa;
> @@ -248,6 +249,7 @@ struct etm_drvdata {
>   	u32				etmccr;
>   	u32				etmccer;
>   	u32				traceid;
> +	struct etm_config		active_config;
>   	struct etm_config		config;
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 862ad0786699c..fd76a57e5f861 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -308,7 +308,7 @@ void etm_config_trace_mode(struct etm_config *config)
>   static int etm_parse_event_config(struct etm_drvdata *drvdata,
>   				  struct perf_event *event)
>   {
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *config = &drvdata->active_config;
>   	struct perf_event_attr *attr = &event->attr;
>   	u8 ts_level;
>   
> @@ -367,7 +367,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>   {
>   	int i, rc;
>   	u32 etmcr;
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *config = &drvdata->active_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   
>   	CS_UNLOCK(drvdata->csa.base);
> @@ -442,32 +442,30 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>   struct etm_enable_arg {
>   	struct etm_drvdata *drvdata;
>   	struct coresight_path *path;
> +	struct etm_config config;
>   	int rc;
>   };
>   
>   static void etm_enable_sysfs_smp_call(void *info)
>   {
>   	struct etm_enable_arg *arg = info;
> +	struct etm_drvdata *drvdata;
>   	struct coresight_device *csdev;
>   
>   	if (WARN_ON(!arg))
>   		return;
>   
> -	csdev = arg->drvdata->csdev;
> -	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
> -		/* Someone is already using the tracer */
> -		arg->rc = -EBUSY;
> -		return;
> -	}
> +	drvdata = arg->drvdata;
> +	csdev = drvdata->csdev;
>   
> -	arg->rc = etm_enable_hw(arg->drvdata);
> +	drvdata->active_config = arg->config;
> +	drvdata->traceid = arg->path->trace_id;
>   
> -	/* The tracer didn't start */
> -	if (arg->rc) {
> -		coresight_set_mode(csdev, CS_MODE_DISABLED);
> +	arg->rc = etm_enable_hw(arg->drvdata);
> +	if (arg->rc)
>   		return;
> -	}
>   
> +	drvdata->sticky_enable = true;
>   	csdev->path = arg->path;
>   }
>   
> @@ -512,9 +510,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
>   	struct etm_enable_arg arg = { };
>   	int ret;
>   
> -	spin_lock(&drvdata->spinlock);
> -
> -	drvdata->traceid = path->trace_id;
> +	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
> +		/* Someone is already using the tracer */
> +		return -EBUSY;
> +	}
>   
>   	/*
>   	 * Configure the ETM only if the CPU is online.  If it isn't online
> @@ -523,23 +522,27 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
>   	if (cpu_online(drvdata->cpu)) {
>   		arg.drvdata = drvdata;
>   		arg.path = path;
> +
> +		scoped_guard(spinlock, &drvdata->spinlock) {
> +			arg.config = drvdata->config;
> +		}
> +

Again I think the arg.config is unnecessary

Regards

Mike

>   		ret = smp_call_function_single(drvdata->cpu,
>   					       etm_enable_sysfs_smp_call, &arg, 1);
>   		if (!ret)
>   			ret = arg.rc;
> -		if (!ret)
> -			drvdata->sticky_enable = true;
>   	} else {
>   		ret = -ENODEV;
>   	}
>   
> -	if (ret)
> +	if (!ret) {
> +		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
> +	} else {
>   		etm_release_trace_id(drvdata);
> +		/* The tracer didn't start */
> +		coresight_set_mode(csdev, CS_MODE_DISABLED);
> +	}
>   
> -	spin_unlock(&drvdata->spinlock);
> -
> -	if (!ret)
> -		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
>   	return ret;
>   }
>   
> @@ -565,7 +568,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
>   static void etm_disable_hw(struct etm_drvdata *drvdata)
>   {
>   	int i;
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *config = &drvdata->active_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   
>   	CS_UNLOCK(drvdata->csa.base);
> @@ -593,7 +596,6 @@ static void etm_disable_sysfs_smp_call(void *info)
>   	etm_disable_hw(drvdata);
>   
>   	drvdata->csdev->path = NULL;
> -	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
>   }
>   
>   static void etm_disable_perf(struct coresight_device *csdev)
> @@ -630,8 +632,9 @@ static void etm_disable_perf(struct coresight_device *csdev)
>   static void etm_disable_sysfs(struct coresight_device *csdev)
>   {
>   	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	spin_lock(&drvdata->spinlock);
> +	struct etm_config *config = &drvdata->config;
> +	const struct etm_config *active_config = &drvdata->active_config;
> +	int i;
>   
>   	/*
>   	 * Executing etm_disable_hw on the cpu whose ETM is being disabled
> @@ -640,7 +643,14 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
>   	smp_call_function_single(drvdata->cpu, etm_disable_sysfs_smp_call,
>   				 drvdata, 1);
>   
> -	spin_unlock(&drvdata->spinlock);
> +	/*
> +	 * Userspace may read seq_curr_state and cntr_val through sysfs
> +	 * after the sysfs-session has been disabled.
> +	 */
> +	for (i = 0; i < drvdata->nr_cntr; i++)
> +		config->cntr_val[i] = active_config->cntr_val[i];
> +
> +	config->seq_curr_state = active_config->seq_curr_state;
>   
>   	/*
>   	 * we only release trace IDs when resetting sysfs.
> @@ -649,6 +659,8 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
>   	 * prior trace id allocation method
>   	 */
>   
> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> +
>   	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
>   }
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index d4846d6364945..2c8c129228589 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -6,10 +6,48 @@
>   
>   #include <linux/pid_namespace.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/smp.h>
>   #include <linux/sysfs.h>
>   #include "coresight-etm.h"
>   #include "coresight-priv.h"
>   
> +struct etm_readl_cslocked_arg {
> +	struct etm_drvdata *drvdata;
> +	u32 off;
> +	unsigned long *val;
> +};
> +
> +static void etm_readl_cslocked_smp_call(void *info)
> +{
> +	struct etm_readl_cslocked_arg *arg = info;
> +
> +	CS_UNLOCK(arg->drvdata->csa.base);
> +	*arg->val = etm_readl(arg->drvdata, arg->off);
> +	CS_LOCK(arg->drvdata->csa.base);
> +}
> +
> +static int etm_readl_cslocked(struct etm_drvdata *drvdata, u32 off,
> +			      unsigned long *val)
> +{
> +	int ret;
> +	struct etm_readl_cslocked_arg arg;
> +
> +	ret = pm_runtime_get_sync(drvdata->csdev->dev.parent);
> +	if (ret < 0)
> +		goto out;
> +
> +	arg.drvdata = drvdata;
> +	arg.off = off;
> +	arg.val = val;
> +
> +	ret = smp_call_function_single(drvdata->cpu,
> +				       etm_readl_cslocked_smp_call,
> +				       (void *)&arg, 1);
> +out:
> +	pm_runtime_put(drvdata->csdev->dev.parent);
> +	return ret;
> +}
> +
>   static ssize_t nr_addr_cmp_show(struct device *dev,
>   				struct device_attribute *attr, char *buf)
>   {
> @@ -45,18 +83,13 @@ static DEVICE_ATTR_RO(nr_ctxid_cmp);
>   static ssize_t etmsr_show(struct device *dev,
>   			  struct device_attribute *attr, char *buf)
>   {
> -	unsigned long flags, val;
> +	int ret;
> +	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   
> -	pm_runtime_get_sync(dev->parent);
> -	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	CS_UNLOCK(drvdata->csa.base);
> -
> -	val = etm_readl(drvdata, ETMSR);
> -
> -	CS_LOCK(drvdata->csa.base);
> -	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -	pm_runtime_put(dev->parent);
> +	ret = etm_readl_cslocked(drvdata, ETMSR, &val);
> +	if (ret)
> +		return ret;
>   
>   	return sprintf(buf, "%#lx\n", val);
>   }
> @@ -74,7 +107,7 @@ static ssize_t reset_store(struct device *dev,
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
> -	if (coresight_get_mode(drvdata->csdev))
> +	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
>   		return -EBUSY;
>   
>   	if (val) {
> @@ -719,7 +752,9 @@ static DEVICE_ATTR_RW(cntr_rld_event);
>   static ssize_t cntr_val_show(struct device *dev,
>   			     struct device_attribute *attr, char *buf)
>   {
> +	int ret;
>   	u32 val;
> +	unsigned long val2;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	struct etm_config *config = &drvdata->config;
>   
> @@ -728,7 +763,10 @@ static ssize_t cntr_val_show(struct device *dev,
>   		val = config->cntr_val[config->cntr_idx];
>   		spin_unlock(&drvdata->spinlock);
>   	} else {
> -		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
> +		ret = etm_readl_cslocked(drvdata, ETMCNTVRn(config->cntr_idx), &val2);
> +		if (ret)
> +			return ret;
> +		val = val2;
>   	}
>   
>   	return sysfs_emit(buf, "%#x\n", val);
> @@ -746,7 +784,7 @@ static ssize_t cntr_val_store(struct device *dev,
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
> -	if (coresight_get_mode(drvdata->csdev))
> +	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
>   		return -EBUSY;
>   
>   	spin_lock(&drvdata->spinlock);
> @@ -934,7 +972,8 @@ static DEVICE_ATTR_RW(seq_13_event);
>   static ssize_t seq_curr_state_show(struct device *dev,
>   				   struct device_attribute *attr, char *buf)
>   {
> -	unsigned long val, flags;
> +	int ret;
> +	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	struct etm_config *config = &drvdata->config;
>   
> @@ -943,15 +982,10 @@ static ssize_t seq_curr_state_show(struct device *dev,
>   		goto out;
>   	}
>   
> -	pm_runtime_get_sync(dev->parent);
> -	spin_lock_irqsave(&drvdata->spinlock, flags);
> -
> -	CS_UNLOCK(drvdata->csa.base);
> -	val = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
> -	CS_LOCK(drvdata->csa.base);
> -
> -	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -	pm_runtime_put(dev->parent);
> +	ret = etm_readl_cslocked(drvdata, ETMSQR, &val);
> +	if (ret)
> +		return ret;
> +	val &= ETM_SQR_MASK;
>   out:
>   	return sprintf(buf, "%#lx\n", val);
>   }
> 

