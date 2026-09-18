Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C554FDE49
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743501; cv=fail; b=rCwAmp6uyip5g0otDYz9dwR/Lb1XFOA6T7/7JTO2faPM/qm6nBAcFyAe2sBPvydBzYXKItc68oIaXuMp1cMH0kAX5DzTIoksaiZ/NIIGOAyNV0kJBDVrniFixg31dwEKv9/AigsKb/NGwLxwCeqgIigNI+BJvYuJUrsINpTf/sE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743501; c=relaxed/simple;
	bh=pe/Gtou5fWlSpImbZ0qo0owj1/R9k47jjsNIlttgJq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V80/EHhfvFZ5UV1xQAVsXSajUX/UusKABiCasEmZdFoQDP5HOpKGY9gR7QfxdlytHcMPTQBTf+vvmoPvoP3U7F5VHV9uXUF3sOPtDs7AupGvgNFrQreuEhGPAE2552hxhCcn52p6q/O0/OsJBDwvtexYarb4vDVDETf3UMPLhqM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iyCCAu4v; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iyCCAu4v; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iyCCAu4v";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iyCCAu4v"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=G236crVJihbJE/EU1ZJzLSngLQLDXSUDgNwOs09uCb5CRK2bK3Gx8fZ2+BCPyh9mHx95C9mNDrIRWbwC1sAtVDJQ4L2DqPqovKAnNOl2dONClUzTCIm8OlM/tZ3jYxURYQLd2jS70qRCd4/CP03h9l78NrAYMLun5UdXX6vKYH4Man6HqYNjHYQmL8TNSIFgoQdkMxb9Mf5IW3ExfUR4qYLvNTTk2NrQhLV6lc/Y1TWBY7xAGkFXPk25R+bXmyKrkV7IksjeH/G+7KWNdF7OzFM3LrNP+gAOi51GC4Lf1XlGPYmsW3yP8TFT8xqc0+qFUMJahI//q5GBA25sQZd8nA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42YPCI4QCsZaMNyDC5mW32bMOIACfYflBli7hCrEV5k=;
 b=OWJf6zjWBDcbJhdXJWUo7oGaqlLPIQK1K/rKYtSwmyvFB0J83mXTi/xLAlxB45oVmWnvSwozyhUb/mD9ccu3uYKUe5WXS3MJDyaytU76pyLQvypDv0kFricQv4sdfZjegs9ACqcFYuoHruGed/igrFKQhHYeAgCI3hSSojVKehyDppvwg6nCCUql052cRFGF/iOm3x644ZDR/7mRHtPa6bP0sW0UNx4LKpdJ8njuF/udds6OERMW195uUmwcNlUJ0WZul4FODBRBIzO2b2u3/MXVimWRIwUkLXObj/ajw8iQb7S19bVnPOJJkZCvMJR/woq7YHjeWJbTPvEt+PUJVA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42YPCI4QCsZaMNyDC5mW32bMOIACfYflBli7hCrEV5k=;
 b=iyCCAu4vT6oTsyroAkCH7t58gJXbndjZMWnxAEUL2ee7kw3AA865C4YhPdshIlA8Qdh4gWRoXMIYo5XlqWKLv9EzQSU/MJa3Giu/fuD/NJKpAZqNbiOiKOsUTtKc6PwcDy4vL2Xjc/UwyfAe750leGb382AsbTtYjTua4gE9/OI=
Received: from AM9P195CA0020.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::25)
 by DB5PR08MB10310.eurprd08.prod.outlook.com (2603:10a6:10:4a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Fri, 18 Sep
 2026 14:58:06 +0000
Received: from AM2PEPF00070CF5.eurprd02.prod.outlook.com
 (2603:10a6:20b:21f:cafe::72) by AM9P195CA0020.outlook.office365.com
 (2603:10a6:20b:21f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 14:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF00070CF5.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 14:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUjIQ6B0XO2gC6tGVau0U4CDbmnX5xZq6D4fF/L6WLsi9VNlwXNANw1tNF7N1BwOQqTTuo6ki2Jlyg3UVzNlrRfEb6v6aHX+ziT0JrgrwsDt0X76FWf0xthh/xCQ7aiPNlYJi8wJZ1GhWgdERQLQcYU02VIpsuFyTMBGa2Et0Y9DB7p2+Kusi/K0fXY+DOjTirKWyaWwLRu1k5f+RJiFs3f+z+7Zno0qEcd5lwCbHAS/nO5kf35xgxNjKKXH6UbRWR/hZN7KDXcSvF+paUhOJO+BC4cX24H93IEnHV65m4b1GoOcPyc7MLX/QjwQGB8/ui1lYCKbfUNIra0Mp0rF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42YPCI4QCsZaMNyDC5mW32bMOIACfYflBli7hCrEV5k=;
 b=kyoKpBn6Zo2s6JAb1M4r9+M17VvhRXrqhPyt7cKP01cbkbIRxRZPChXkVscZA/QwqgDQWgQnlIP4/GaB+IrZFX2PuBJ6mBQE0ep0Ot+VMgngWZiDzdmQB3bIIOVqppH5fTfjYH8QrohET7Lm5SX/qNmWYLedRJtrHaIyDBtx7vmOjrzy4Yi5bWYYbT0njvqSl+0xbWyeNqotHiFpTiUgx5JmGfFUZBVuNdce9Zm2XNwNg3g57BmXypbMuOca9hNcHkMbIi8wJnjOkQW6dTOqE8qhdGheXCmErDSLtVriZroOz7EINpGcCTzJ76fA4sNQPDcN6aAF6/s0dzoMXP2WuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42YPCI4QCsZaMNyDC5mW32bMOIACfYflBli7hCrEV5k=;
 b=iyCCAu4vT6oTsyroAkCH7t58gJXbndjZMWnxAEUL2ee7kw3AA865C4YhPdshIlA8Qdh4gWRoXMIYo5XlqWKLv9EzQSU/MJa3Giu/fuD/NJKpAZqNbiOiKOsUTtKc6PwcDy4vL2Xjc/UwyfAe750leGb382AsbTtYjTua4gE9/OI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 14:57:33 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 14:57:33 +0000
Message-ID: <3f91ecea-05ad-4b95-9352-37ae2203807b@arm.com>
Date: Fri, 18 Sep 2026 15:57:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] coresight: etm3x: introduce struct etm_caps
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
 <20260915-separate_etm_cfg_v2-v11-9-d2b258d51747@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-9-d2b258d51747@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0522.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::8) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|AS8PR08MB9908:EE_|AM2PEPF00070CF5:EE_|DB5PR08MB10310:EE_
X-MS-Office365-Filtering-Correlation-Id: b51139b6-96a6-4ad9-c225-08df15953f10
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|3023799007|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 LJ4gcsdLQeRJC/J0pB1chgX4U5pSXhxgl/tEULhZ/fweX+NKBuB8/I+z57srH8Qwz1g/wroHxGxOjn4jVk1bN0XdOurxLi5eyF3aC9RAcwTPS89WlYt5pGu4D+0uAaIv5FkM47FLPqrUFGwVXv6/MzoWg+/cZUzS+IOjgmpvwMAGQHtzB+oRZ05dbl+66IpjU1lm7zrP0bZiyHJ+ufMC4W+vP+TIWL12mqO6ebz/GUU2uMJZqtWk0ROaYNn2WE086ifr//gos/Paz3MOgvQ3Qi/ra1EVOs5nZspvzmbEJUhP5X05gebQ3ILVPQIGwIOBJzFO3cWsWTO9PYXw4YYbQ5sbUFb8yhPZdimiofN8fay8VKUsHlNLFZy6vmqqZN+im5VZ/EH9JoWVHeM2agUgHIh50a5i5ib3UaxzT1E+OI3XPIzFbNarDJ+9YKkshePFu8SdnrF8YWCB2gbvbmKq7IAU3hHBiPAWe0vYvPR1CSgRFqrzcK4kFnpJqYMn8jozR9+l6Gh37Y89N+v1UOhrZ26ryRwXYhDrv+oXznLUPnXLoepPaLRZpF2yJRIDPyFVgyozYoTQ7eyf+qrYpy0jv3BLmQeMy+njU+cVhyZ2hmiJmrpjhvhU4vSkUPAigYeaYrnh2x4ky3g75EeoNETNBtoDZmoKxS0+zd7hI91/Vrc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(3023799007)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 jLeFcOVsX+J3LKM11gqwm14aVP9IDHDcqP8v9r4CC5qZ7ynN8SPKVNAfoddW9QspfmgqJVdUjzWuSbimdBSV7MdCbpqEylBstsEIatnRjAXYjUDAA72/fLpvUCKp9Y8njrtdNGxKY6+Bx3FLFYdKz41FgwpIYQzC3O6Wbcjq13iC0MBw4+tmlkyNejSjqkX0aVZIAG4YYYvm0pweyNX0cqChnSq/CEssHg4fL6hrsWkzi47l6KvviX6jE8lzBvPFACm7QUA53+0/896huMeIMpSAhrdA2u1o2rAicsXB+PnTMAl5ZGAVJ8g6zYXLM0z/pmclxU4CxYXeapb+nKBr5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF00070CF5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1ebae819-ad38-4c6d-3e45-08df15952b4c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|35042699022|1800799024|14060799003|36860700016|7416014|6133799003|18002099003|22082099003|3023799007|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zfNanLIgeTKQdwDEjewOkSjmbhKihF2VqFFTfzYh1XxKPpzsGfeFHcxHcr9+Ao42jYLFKZQYsAE+GnwJtoWwDxwgBbGNcb0fJSG6V6+LKbzlOWkv1CvWCWWCaHbkJ1RjVMeK8jEm96BqKlWwRdDWCjKEl1FIpOlU1Uj9y8/HRmYW64vVv3gBmorxwQSFN229VX7yUfHCMwkBpSevpa/yOXY/MKMB7A7ktzLSn50wNmEWs09zr39NJudPKBmdJ6PsBTDgt3tpifG409y8xLBW8Epz7eaq9NhpC48A42rRFXijuE5+JCJnPDFEhsPTHLujYhHEQsY9dGkVq+gMZRB4Z+8EAQP3kQTjnB3A5SoOMdDZbYCBhqcyfTch/J9ebYbtQXYR6d19+jEIBerWzpaWgD7CGCbGjmP4l4PQjDO+KI/G7vrXKZ2RtJV6f7F9VpuUdBZb2QLryX+TLRMEtEUcEAQi73Iwqh4jMB2+Ty2PGnxcnthjgYFtRNwy5x+Lf5hD6e2BH8/3u9WL4zBLP+5Rz+2/p37TFNHClEJQyLTFB6ivzJo4CMsLpbcZw8s0revkyDFpAp78QiS8jurlh9As2JMykyCE+fPZrCvhsif+hZxQ8fUTAFt4vOoHY732VbxrobYbc2apcLks2JvRpXnKTwrN/SgBwM0/rcBczF9NjiQFQmhXBwtJgg81fjBYrvrL3xkDElAxluGHd6/HnoKsKg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(35042699022)(1800799024)(14060799003)(36860700016)(7416014)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1l7FwcpR9t5r6mDeMH3PjwlMNryib4fzdVnBM9Hck+mes7oLr2oCZT0I3DnX/69O1J1T4xbmy5bIPuvyVAk2Z+BCB3qQ0OQMESIbjMj3IIrulYWrAtFQdqIC6V0hVuWgSvhkaBPY/9+VerD3MG21ziqKEt0VD1upMtT/iASc1sEerSxY0TFBfsjSld+asAkolRvCPEnISUFx5CrsvhsKtCsUwKWUqGdkldE94On5eIHTwS1I26eTt6/kLMspkbSk6ShIqP9ZQxsFSHfzYhoXgPo9roJWINZgYx3Wurq/AbBlJ6OyTG2olUNsOjDcMdw52HpFEa99BwwSqscFQ0gjpPDDnRvDgdDo8cikwuojJaj7xdh2QrwHPXsbP/39DgPfCwcPEqbGg+RfI2X2F+uHzFfbSCROavKzUUqUsORtKGbwWbzVWVyrYw84A+ZdhI6D
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:58:06.1268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51139b6-96a6-4ad9-c225-08df15953f10
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10310

Reviewed-by: Mike Leach <mike.leach@arm.com>

On 9/15/26 12:34, Yeoreum Yun wrote:
> Introduce struct etm_caps to describe ETMv3 capabilities
> and move capabilities information into it.
> 
> Since drvdata->etmccr and drvdata->etmccer are used to check
> whether it supports fifofull logic and timestamping,
> remove etmccr and etmccer field from drvdata and add relevant fields
> in etm_caps structure.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm.h        | 42 +++++++++++++---------
>   drivers/hwtracing/coresight/coresight-etm3x-core.c | 42 +++++++++++++---------
>   .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 24 ++++++++-----
>   3 files changed, 66 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
> index f3796162168d4..cb5f18dcdd974 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -140,6 +140,30 @@
>   				 ETM_ADD_COMP_0		|	\
>   				 ETM_EVENT_NOT_A)
>   
> +/**
> + * struct etm_caps - specifics ETM capabilities
> + * @port_size:	port size as reported by ETMCR bit 4-6 and 21.
> + * @nr_addr_cmp:Number of pairs of address comparators as found in ETMCCR.
> + * @nr_cntr:	Number of counters as found in ETMCCR bit 13-15.
> + * @nr_ext_inp:	Number of external input as found in ETMCCR bit 17-19.
> + * @nr_ext_out:	Number of external output as found in ETMCCR bit 20-22.
> + * @nr_ctxid_cmp: Number of contextID comparators as found in ETMCCR bit 24-25.
> + * @fifofull:	FIFOFULL logic is present.
> + * @timestamp:	Timestamping is implemented.
> + * @retstack:	Return stack is implemented.
> + */
> +struct etm_caps {
> +	int	port_size;
> +	u8	nr_addr_cmp;
> +	u8	nr_cntr;
> +	u8	nr_ext_inp;
> +	u8	nr_ext_out;
> +	u8	nr_ctxid_cmp;
> +	bool	fifofull : 1;
> +	bool	timestamp : 1;
> +	bool	retstack : 1;
> +};
> +
>   /**
>    * struct etm_config - configuration information related to an ETM
>    * @mode:	controls various modes supported by this ETM/PTM.
> @@ -212,19 +236,12 @@ struct etm_config {
>    * @csdev:	component vitals needed by the framework.
>    * @spinlock:	only one at a time pls.
>    * @cpu:	the cpu this component is affined to.
> - * @port_size:	port size as reported by ETMCR bit 4-6 and 21.
>    * @arch:	ETM/PTM version number.
> + * @caps:	ETM capabilities.
>    * @use_cpu14:	true if management registers need to be accessed via CP14.
>    * @sticky_enable: true if ETM base configuration has been done.
>    * @boot_enable:true if we should start tracing at boot time.
>    * @os_unlock:	true if access to management registers is allowed.
> - * @nr_addr_cmp:Number of pairs of address comparators as found in ETMCCR.
> - * @nr_cntr:	Number of counters as found in ETMCCR bit 13-15.
> - * @nr_ext_inp:	Number of external input as found in ETMCCR bit 17-19.
> - * @nr_ext_out:	Number of external output as found in ETMCCR bit 20-22.
> - * @nr_ctxid_cmp: Number of contextID comparators as found in ETMCCR bit 24-25.
> - * @etmccr:	value of register ETMCCR.
> - * @etmccer:	value of register ETMCCER.
>    * @traceid:	value of the current ID for this component.
>    * @active_config:	structure holding current running configuration.
>    * @config:	structure holding sysfs mode configuration.
> @@ -235,19 +252,12 @@ struct etm_drvdata {
>   	struct coresight_device		*csdev;
>   	spinlock_t			spinlock;
>   	int				cpu;
> -	int				port_size;
>   	u8				arch;
> +	struct etm_caps			caps;
>   	bool				use_cp14;
>   	bool				sticky_enable;
>   	bool				boot_enable;
>   	bool				os_unlock;
> -	u8				nr_addr_cmp;
> -	u8				nr_cntr;
> -	u8				nr_ext_inp;
> -	u8				nr_ext_out;
> -	u8				nr_ctxid_cmp;
> -	u32				etmccr;
> -	u32				etmccer;
>   	u32				traceid;
>   	struct etm_config		active_config;
>   	struct etm_config		config;
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 12bb38dc596e7..79c7cbe2084de 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -308,6 +308,7 @@ void etm_config_trace_mode(struct etm_config *config)
>   static int etm_parse_event_config(struct etm_drvdata *drvdata,
>   				  struct perf_event *event)
>   {
> +	const struct etm_caps *caps = &drvdata->caps;
>   	struct etm_config *config = &drvdata->active_config;
>   	struct perf_event_attr *attr = &event->attr;
>   	u8 ts_level;
> @@ -356,8 +357,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>   	 * has ret stack) on the same SoC. So only enable when it can be honored
>   	 * - trace will still continue normally otherwise.
>   	 */
> -	if (ATTR_CFG_GET_FLD(attr, retstack) &&
> -	    (drvdata->etmccer & ETMCCER_RETSTACK))
> +	if (ATTR_CFG_GET_FLD(attr, retstack) && (caps->retstack))
>   		config->ctrl |= ETMCR_RETURN_STACK;
>   
>   	return 0;
> @@ -367,6 +367,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>   {
>   	int i, rc;
>   	u32 etmcr;
> +	const struct etm_caps *caps = &drvdata->caps;
>   	struct etm_config *config = &drvdata->active_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   
> @@ -388,7 +389,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>   	etmcr = etm_readl(drvdata, ETMCR);
>   	/* Clear setting from a previous run if need be */
>   	etmcr &= ~ETM3X_SUPPORTED_OPTIONS;
> -	etmcr |= drvdata->port_size;
> +	etmcr |= caps->port_size;
>   	etmcr |= ETMCR_ETM_EN;
>   	etm_writel(drvdata, config->ctrl | etmcr, ETMCR);
>   	etm_writel(drvdata, config->trigger_event, ETMTRIGGER);
> @@ -396,11 +397,11 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>   	etm_writel(drvdata, config->enable_event, ETMTEEVR);
>   	etm_writel(drvdata, config->enable_ctrl1, ETMTECR1);
>   	etm_writel(drvdata, config->fifofull_level, ETMFFLR);
> -	for (i = 0; i < drvdata->nr_addr_cmp; i++) {
> +	for (i = 0; i < caps->nr_addr_cmp; i++) {
>   		etm_writel(drvdata, config->addr_val[i], ETMACVRn(i));
>   		etm_writel(drvdata, config->addr_acctype[i], ETMACTRn(i));
>   	}
> -	for (i = 0; i < drvdata->nr_cntr; i++) {
> +	for (i = 0; i < caps->nr_cntr; i++) {
>   		etm_writel(drvdata, config->cntr_rld_val[i], ETMCNTRLDVRn(i));
>   		etm_writel(drvdata, config->cntr_event[i], ETMCNTENRn(i));
>   		etm_writel(drvdata, config->cntr_rld_event[i],
> @@ -414,9 +415,9 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>   	etm_writel(drvdata, config->seq_32_event, ETMSQ32EVR);
>   	etm_writel(drvdata, config->seq_13_event, ETMSQ13EVR);
>   	etm_writel(drvdata, config->seq_curr_state, ETMSQR);
> -	for (i = 0; i < drvdata->nr_ext_out; i++)
> +	for (i = 0; i < caps->nr_ext_out; i++)
>   		etm_writel(drvdata, ETM_DEFAULT_EVENT_VAL, ETMEXTOUTEVRn(i));
> -	for (i = 0; i < drvdata->nr_ctxid_cmp; i++)
> +	for (i = 0; i < caps->nr_ctxid_cmp; i++)
>   		etm_writel(drvdata, config->ctxid_pid[i], ETMCIDCVRn(i));
>   	etm_writel(drvdata, config->ctxid_mask, ETMCIDCMR);
>   	etm_writel(drvdata, config->sync_freq, ETMSYNCFR);
> @@ -562,6 +563,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
>   static void etm_disable_hw(struct etm_drvdata *drvdata)
>   {
>   	int i;
> +	const struct etm_caps *caps = &drvdata->caps;
>   	struct etm_config *config = &drvdata->active_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   
> @@ -571,7 +573,7 @@ static void etm_disable_hw(struct etm_drvdata *drvdata)
>   	/* Read back sequencer and counters for post trace analysis */
>   	config->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
>   
> -	for (i = 0; i < drvdata->nr_cntr; i++)
> +	for (i = 0; i < caps->nr_cntr; i++)
>   		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
>   
>   	etm_set_pwrdwn(drvdata);
> @@ -626,6 +628,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
>   static void etm_disable_sysfs(struct coresight_device *csdev)
>   {
>   	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	const struct etm_caps *caps = &drvdata->caps;
>   	struct etm_config *config = &drvdata->config;
>   	const struct etm_config *active_config = &drvdata->active_config;
>   	int i;
> @@ -641,7 +644,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
>   	 * Userspace may read seq_curr_state and cntr_val through sysfs
>   	 * after the sysfs-session has been disabled.
>   	 */
> -	for (i = 0; i < drvdata->nr_cntr; i++)
> +	for (i = 0; i < caps->nr_cntr; i++)
>   		config->cntr_val[i] = active_config->cntr_val[i];
>   
>   	config->seq_curr_state = active_config->seq_curr_state;
> @@ -726,7 +729,9 @@ static void etm_init_arch_data(void *info)
>   {
>   	u32 etmidr;
>   	u32 etmccr;
> +	u32 etmccer;
>   	struct etm_drvdata *drvdata = info;
> +	struct etm_caps *caps = &drvdata->caps;
>   
>   	/* Make sure all registers are accessible */
>   	etm_os_unlock(drvdata);
> @@ -751,16 +756,19 @@ static void etm_init_arch_data(void *info)
>   	/* Find all capabilities */
>   	etmidr = etm_readl(drvdata, ETMIDR);
>   	drvdata->arch = BMVAL(etmidr, 4, 11);
> -	drvdata->port_size = etm_readl(drvdata, ETMCR) & PORT_SIZE_MASK;
> +	caps->port_size = etm_readl(drvdata, ETMCR) & PORT_SIZE_MASK;
> +
> +	etmccer = etm_readl(drvdata, ETMCCER);
> +	caps->timestamp = !!(etmccer & ETMCCER_TIMESTAMP);
> +	caps->retstack = !!(etmccer & ETMCCER_RETSTACK);
>   
> -	drvdata->etmccer = etm_readl(drvdata, ETMCCER);
>   	etmccr = etm_readl(drvdata, ETMCCR);
> -	drvdata->etmccr = etmccr;
> -	drvdata->nr_addr_cmp = BMVAL(etmccr, 0, 3) * 2;
> -	drvdata->nr_cntr = BMVAL(etmccr, 13, 15);
> -	drvdata->nr_ext_inp = BMVAL(etmccr, 17, 19);
> -	drvdata->nr_ext_out = BMVAL(etmccr, 20, 22);
> -	drvdata->nr_ctxid_cmp = BMVAL(etmccr, 24, 25);
> +	caps->fifofull = !!(etmccr & ETMCCR_FIFOFULL);
> +	caps->nr_addr_cmp = BMVAL(etmccr, 0, 3) * 2;
> +	caps->nr_cntr = BMVAL(etmccr, 13, 15);
> +	caps->nr_ext_inp = BMVAL(etmccr, 17, 19);
> +	caps->nr_ext_out = BMVAL(etmccr, 20, 22);
> +	caps->nr_ctxid_cmp = BMVAL(etmccr, 24, 25);
>   
>   	coresight_clear_self_claim_tag_unlocked(&drvdata->csa);
>   	etm_set_pwrdwn(drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 2c8c129228589..36d4673537930 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -53,8 +53,9 @@ static ssize_t nr_addr_cmp_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	const struct etm_caps *caps = &drvdata->caps;
>   
> -	val = drvdata->nr_addr_cmp;
> +	val = caps->nr_addr_cmp;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   static DEVICE_ATTR_RO(nr_addr_cmp);
> @@ -63,8 +64,9 @@ static ssize_t nr_cntr_show(struct device *dev,
>   			    struct device_attribute *attr, char *buf)
>   {	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	const struct etm_caps *caps = &drvdata->caps;
>   
> -	val = drvdata->nr_cntr;
> +	val = caps->nr_cntr;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   static DEVICE_ATTR_RO(nr_cntr);
> @@ -75,7 +77,7 @@ static ssize_t nr_ctxid_cmp_show(struct device *dev,
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   
> -	val = drvdata->nr_ctxid_cmp;
> +	val = drvdata->caps.nr_ctxid_cmp;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   static DEVICE_ATTR_RO(nr_ctxid_cmp);
> @@ -115,7 +117,7 @@ static ssize_t reset_store(struct device *dev,
>   		memset(config, 0, sizeof(struct etm_config));
>   		config->mode = ETM_MODE_EXCLUDE;
>   		config->trigger_event = ETM_DEFAULT_EVENT_VAL;
> -		for (i = 0; i < drvdata->nr_addr_cmp; i++) {
> +		for (i = 0; i < drvdata->caps.nr_addr_cmp; i++) {
>   			config->addr_type[i] = ETM_ADDR_TYPE_NONE;
>   		}
>   
> @@ -146,6 +148,7 @@ static ssize_t mode_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	const struct etm_caps *caps = &drvdata->caps;
>   	struct etm_config *config = &drvdata->config;
>   
>   	ret = kstrtoul(buf, 16, &val);
> @@ -166,7 +169,7 @@ static ssize_t mode_store(struct device *dev,
>   		config->ctrl &= ~ETMCR_CYC_ACC;
>   
>   	if (config->mode & ETM_MODE_STALL) {
> -		if (!(drvdata->etmccr & ETMCCR_FIFOFULL)) {
> +		if (!caps->fifofull) {
>   			dev_warn(dev, "stall mode not supported\n");
>   			ret = -EINVAL;
>   			goto err_unlock;
> @@ -176,7 +179,7 @@ static ssize_t mode_store(struct device *dev,
>   		config->ctrl &= ~ETMCR_STALL_MODE;
>   
>   	if (config->mode & ETM_MODE_TIMESTAMP) {
> -		if (!(drvdata->etmccer & ETMCCER_TIMESTAMP)) {
> +		if (!caps->timestamp) {
>   			dev_warn(dev, "timestamp not supported\n");
>   			ret = -EINVAL;
>   			goto err_unlock;
> @@ -321,13 +324,14 @@ static ssize_t addr_idx_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	const struct etm_caps *caps = &drvdata->caps;
>   	struct etm_config *config = &drvdata->config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	if (val >= drvdata->nr_addr_cmp)
> +	if (val >= caps->nr_addr_cmp)
>   		return -EINVAL;
>   
>   	/*
> @@ -624,13 +628,14 @@ static ssize_t cntr_idx_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	const struct etm_caps *caps = &drvdata->caps;
>   	struct etm_config *config = &drvdata->config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	if (val >= drvdata->nr_cntr)
> +	if (val >= caps->nr_cntr)
>   		return -EINVAL;
>   	/*
>   	 * Use spinlock to ensure index doesn't change while it gets
> @@ -1030,13 +1035,14 @@ static ssize_t ctxid_idx_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	const struct etm_caps *caps = &drvdata->caps;
>   	struct etm_config *config = &drvdata->config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	if (val >= drvdata->nr_ctxid_cmp)
> +	if (val >= caps->nr_ctxid_cmp)
>   		return -EINVAL;
>   
>   	/*
> 

