Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105E515890
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679394; cv=fail; b=KanWMTwHi12nJxdv9uFZSnc3mTUpDUxFkpzjMmlGJU8GfKQXArNF15GTa5h5f9rUecPmVODOL5lI3EhJnpN5FJFCNF0D0zwwYnARQAiA+hMkCqZHAkD+eagvnwXxC61iBX1ZHWtFl4mbPn3O13WgZwEegH7x8ea5bmTtysgPfIM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679394; c=relaxed/simple;
	bh=fjWlNJAqnSWANXUYUiIbR7kJZvJyOnoF8HMvAerp4/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jQj5JrddN7WXvqhpj3C+VcpnXAJ+IWFBH7LJgbrUgx7IZyfMHRHMnh85cGoPhAqSaTyQfEdKebDCWzEGCqehiLZZSvIHHrbR9rYkIYQDwISa+CZ/CeoMa6x0Tc70Wx4CYbynYEos6ardLhxKvkBzOSkdUzJFD7ELYt/DmJecSyw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QfLUIY6A; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QfLUIY6A; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QfLUIY6A";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QfLUIY6A"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kraGsuKYZLW35FF1sbYOKBFP3+oO8qTImn8Ta4HrZps80k5rK698SjrPvE0NgxGIVbeaU2VF3XsDO/nT5myCoiAWFG/QW3lipdfXE7aIdZ2+MVsBNv3qAmaDE8KP0I9oATBynrsIRqT/CwvZvTLBmtyP9De2/GydV1EIz7YvWCUvRfS625xbIraauRsEoAM4cI8+S6nDZ0YdQ47EWxQdOAMrXGe5LBs+hyb93rA9p36n3wD0I8QY6+cX3/yLtqr7x632INHrBU3HQUumN9pCceruCz7A9otajqlUTYmRMUVhIOtvkeCMEM/br0FoFN6tA19rVJ29jtk8l3wH2mTTXA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LDPPNyljYsApOVnSVfiygGF2+3olTioBd/s2t/85L8=;
 b=OYW2dxCbYLNP6DEXZLLvifKnS0CZlu5Z80NPtlkGNBR+Cw3qsnEwms7lyULBI2sSgIDPX/oygFfAeQO89GLb1andRKbcJp0adlq2DrRQ2dc8UZXQtJNcHvgUgqgebCPv4h9UXSAZfn0C3ciKAFXe23Bp55NecMIOLrWvTeyvEMLZQASLyvYeG9x7tvXQshTSJWKQGaE9WU7dTDFWmeBliSg542tMlxbo5+5E0jdrJZ7s2VTQkKU/ka0QyaCxJmBtL5N8MMMPDVtaTUcDI4PWc855AB9gWhSrHids4aks7J5vCta4m/egF6AolXnsueuSrY9uOOBD+eiUE7wW5r/obQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LDPPNyljYsApOVnSVfiygGF2+3olTioBd/s2t/85L8=;
 b=QfLUIY6ArtkVq/ltg0tINbG7IxrOX/02jeU9M+Mi5omQ7jTB+xRI41Qxg8E3sttZyEbZeIsn94jI/Bbt6bDSywr+AkD6SnYV4o/53SUmW8VZbSgsckhmgETL2Eh+NqrbonqH/CHJMvEECjCmFS3U/g4WdNDelrPJOnEWhS+2cpc=
Received: from MR1P264CA0198.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:57::16)
 by DBBPR08MB5900.eurprd08.prod.outlook.com (2603:10a6:10:200::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 10:56:20 +0000
Received: from MAD0EPF000008C2.eurprd05.prod.outlook.com
 (2603:10a6:501:57:cafe::1) by MR1P264CA0198.outlook.office365.com
 (2603:10a6:501:57::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 10:56:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008C2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Tue, 29 Sep 2026 10:56:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzkceuwHUTsP5w0iBWZENU5/4c8c9qx6mrei7nyrF1l5DOXnkdeV9Dehoqs02eIL4aRiCieDhvSE+o/8yk59f18KCBZe9p9uoXPb4+upNvRV+wCxhRYZ0GEM1u+sZs44eHjNLrRzpk4t2SvBXMsNv8QE2zdmtXcpBcZusU7o8h3PxxiblTx0DadMZfosFX/ruI5ymtmxn3x121+YKdCyWh41L9z5hcJKpPHB+8fzpqu4mpV9r6+5cK8yjo6jO35+HZwn5Ont1y5Mi8WbHeg77JbNZhtFkesWzvGRmgv8Gurfenon+63eDOlXhrJzDalt6Wuv9dzaY1dqWgtxft9hag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LDPPNyljYsApOVnSVfiygGF2+3olTioBd/s2t/85L8=;
 b=qivQKBbXzqXcG6YcohJzntLE5oO0VJsZXr6u84vs16iCWdK4Q/Gf+OcepeNVYlu41yK3fnKmLxJ7w+lz2laznhJRBPjrN4IynRhQ2A1Tl3orgkJYXAoYbJLO6aWcjURl45tx+Myto+vH40d+CoaEzeo7IgGqoj0iG9Dp17hk7UHoeTw/TjIJhSil2Cosp5CHuYdysIMRju+2bhRMNEao1gnXfukSWvxQa1D0vdHGTXTOTSz4+xm1OBrYf6U/pZNrk4ww9P+1kWCeemJwMS4hRgrdxm88qUdNL2AgFCnfJ5u27FKc/NlyyYE/KwArrHNrGjfYEOxA68lujimkUO4G6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LDPPNyljYsApOVnSVfiygGF2+3olTioBd/s2t/85L8=;
 b=QfLUIY6ArtkVq/ltg0tINbG7IxrOX/02jeU9M+Mi5omQ7jTB+xRI41Qxg8E3sttZyEbZeIsn94jI/Bbt6bDSywr+AkD6SnYV4o/53SUmW8VZbSgsckhmgETL2Eh+NqrbonqH/CHJMvEECjCmFS3U/g4WdNDelrPJOnEWhS+2cpc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DB9PR08MB8386.eurprd08.prod.outlook.com (2603:10a6:10:3d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 10:55:47 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0472.005; Tue, 29 Sep 2026
 10:55:47 +0000
Message-ID: <909df49b-01a0-4db1-8240-f71856e3bf74@arm.com>
Date: Tue, 29 Sep 2026 11:55:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 14/14] coresight: etm3x: rename drvdata->config to
 sysfs_config
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
 <20260924-separate_etm_cfg_v2-v12-14-a2b41d2f7c2b@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-14-a2b41d2f7c2b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0114.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::11) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DB9PR08MB8386:EE_|MAD0EPF000008C2:EE_|DBBPR08MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 0361e4a5-dbe8-41a8-9643-08df1e184adc
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|4143699003|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 dA5s4ajkIP2M/KN2Ej7HWpocBw/Uy2ktp6x+ypN/e30Ct2VowSR41wnijg96Py/2qY6DaB6dWU7fwiI7yDJqu2HzaxRWZMIkW7mU1YaSSKHmOkY/3Wj6Qm3i3ThKxgvV0noDUad9QVcBqaFuRzQvcV9CB9emlhCBkAYYGpww0hPdGDcudiDSw4AOEJtd4ZoYZrj2y8oTP7MQ6BmnE+Mr9GcO7o8Erk8V82nQB6ondMhBL0ufSibyMLpipWNW1V4RMl2AxgSUoRbPdbzv4vHrPTJllGRvoW+st0RmqxmOPzgSWcFS0KyunSFThfc88l6tXiHAo8/PVZCsOeQWeEkBbPaIbkggHGgwa685TuxlQIsmabgVnMkSoC/+HH2zXqPkYsLvJiRsw+btU8nKy4sAh+oWtqEawQwEF8O/RXzFKxItrvD6u4Gxo1WbmPBxM1wa3GXEXkMk9r4ENjFY861v3khJl2fmj0G9J8VXAyYvCyZYCL2KzepVMMULlmpd2CCLYsRtSymDvlrZU99gdLKxyby2fmENRUZ/EMRBwC67D3raFcSRswUuMbt+d32BGSBxza+ZBMje1uTgcptIxYH2CVoqwfqhIfTzI1UC6rYlc1qVx6ZUeSr8IQ5w7CcPmF/uGbLBUM56kHO94x5EnXuc4d4T1+lNBxQu9nHfooF+y8c=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 DO1JtLbM0roTJoMi881pUeV/prxxlkp4+uyErOgJ+PpX001JHIXhvAGyPlSKZeDBbvxsEC47ilNt7HvRr+gvgt7eiT3gTgbI5KwKX+vZAZRBoFHcUR5gmAeHXjJNVXYdcKFenwY+xw45D9I/CroK7qbSRNpz30XwHZ6XdphBSgne9jD/SmA+8VC4GNq59PURMdjgHlFyoVldyBZspIUCXX99AjGIr8mmWOba15c64JZo3aK0syvCYPr2cfYI9R973xmo+lUJ8ifQ47510eEnZDTwRQZJWg/KmgFIbVtd2fK9u8ZYpr9GRorXF2kv2MyMM7fJFfv60edWqVn1ZqTCjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8386
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5e5f3c35-68d8-497a-9041-08df1e183775
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|1800799024|14060799003|35042699022|36860700016|6133799003|18002099003|22082099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	4xb5PZuZ5dvVAEiYZp4bg9LZmZUmk5iMNkv7rho2lU/NLERdFGL0yZho0zUEkxa6CNMnayBWe5TB5wLzNc3N2rs1mI2NdvoIkWHu3NCn7WsQ8wphbOQcvWWGNyp9AOlS1w6sUVajQ0j6lmBksdKoSHofOgWIi8M/TYtlDBkNW8Ie1Zk9c2T/Eplc0rCzP+J0IzJzpxr+Eny7VDN4h949SdvHsTp/jXXun5nBWrnJAlQiqZpxwGSu4utCru9RUo38WPeDt3SURZWY+6rrnv6jtzjqol/G9DS6Eo13Tiw+QmvHDC47gm3ais9dkeWAiG1ysbdnsZjvJzoqNTFrACTRtty+1CuXcjaZVAVc94r9GtWN55iq04ef/Lx8+Jl4AfvtGE13mjAYoawr3dGKpuwCOagMcDUwzV1bfrWyvrn39GmR/ewEVwmByvPBN0jXa9crm+u3JFXkYkMJeqAjSF3xskFcpoyM+O+A7zOqnYtIsJSvmGGy3cmcleg8tjiPFddUQH1ycL8zX7RWN4MCrY0J4LLcWftfpmi2NwSI1c40rNxEuV/N3cHrYHOTONREUUxFNFshI1CQhHTdPILhytRgrcpPrA09N6LrLnV+knOWOXLnhKxs5prmL8CiGAXZR0h2HnTKF8H8r9TvkHXU0fv6OzbVRgmiAWiQ9QmXzoFWDJf6LStWUMVEe6FH3REkJGMKBAHfvAHpMxz8fZhJ9Wnqbg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(1800799024)(14060799003)(35042699022)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4pdV6H86uDSnRb75DC9+UonCm/DQyH3CULc+XMGTlIxFp3MXr4De9vEqdB6qB3vOUhMfWoEQEZnh8S1PEew2zDApVObgRl/tA8YskHlMrKFZpevVfRD9ilA4o0UA+sStjKz5aJTXLpGxohcs7ezmYf16Ktea7tBZgwCUwLrcLXcFWN7ck+xVvu2SkS1KjOVZ48hdNABdM9MdhMOlx2WeAjbPg8218ZDBnshh448O8dyS8wIMMxeYU7K8vvrqa6LQxvHJnkeiTDqCwQaeKoW1TbOPhjkCH0a40N/H/NU1eobPG6PKOcdwKkRWQRyIIoSFGznoGX7OT2qWjcqxaxbU1+nWZH1A8c7DIWLbKSv+ujGIjZn4QnqZG0rYViOiWYP9ReskfMH1Rl/2IJydUhKjrtOcDYzolAP9hhgHToCqX1+CBcNUK9e3gI+y/lQ1iMK0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:56:19.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0361e4a5-dbe8-41a8-9643-08df1e184adc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5900

Reviewed-by: Mike Leach <mike.leach@arm.com>

On 9/24/26 18:33, Yeoreum Yun wrote:
> drvdata->config is used only by the sysfs interface.
> Rename it to sysfs_config to clarify its purpose.
> 
> For readability, also rename local config variables to sysfs_config
> where they refer to drvdata->sysfs_config.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm.h        |   4 +-
>   drivers/hwtracing/coresight/coresight-etm3x-core.c |   6 +-
>   .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 356 ++++++++++-----------
>   3 files changed, 183 insertions(+), 183 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
> index 560a58a3817c..cf65d89a8e98 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -244,7 +244,7 @@ struct etm_config {
>    * @os_unlock:	true if access to management registers is allowed.
>    * @traceid:	value of the current ID for this component.
>    * @curr_config:	structure holding current running configuration.
> - * @config:	structure holding sysfs mode configuration.
> + * @sysfs_config:	structure holding sysfs mode configuration.
>    */
>   struct etm_drvdata {
>   	struct csdev_access		csa;
> @@ -260,7 +260,7 @@ struct etm_drvdata {
>   	bool				os_unlock;
>   	u32				traceid;
>   	struct etm_config		curr_config;
> -	struct etm_config		config;
> +	struct etm_config		sysfs_config;
>   };
>   
>   static inline void etm_writel(struct etm_drvdata *drvdata,
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 0cad9ecb49b6..67f1b71de881 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -518,7 +518,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
>   	arg.path = path;
>   
>   	scoped_guard(spinlock, &drvdata->spinlock) {
> -		drvdata->curr_config = drvdata->config;
> +		drvdata->curr_config = drvdata->sysfs_config;
>   	}
>   
>   	ret = smp_call_function_single(drvdata->cpu,
> @@ -627,7 +627,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
>   {
>   	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>   	const struct etm_caps *caps = &drvdata->caps;
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *config = &drvdata->sysfs_config;
>   	const struct etm_config *curr_config = &drvdata->curr_config;
>   	int i;
>   
> @@ -844,7 +844,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>   	if (etm_arch_supported(drvdata->arch) == false)
>   		return -EINVAL;
>   
> -	etm_set_default(&drvdata->config);
> +	etm_set_default(&drvdata->sysfs_config);
>   
>   	pdata = coresight_get_platform_data(dev);
>   	if (IS_ERR(pdata))
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index c27865d719eb..d185fb8270e1 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -104,7 +104,7 @@ static ssize_t reset_store(struct device *dev,
>   	int i, ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
> @@ -116,14 +116,14 @@ static ssize_t reset_store(struct device *dev,
>   
>   	if (val) {
>   		spin_lock(&drvdata->spinlock);
> -		memset(config, 0, sizeof(struct etm_config));
> -		config->mode = ETM_MODE_EXCLUDE;
> -		config->trigger_event = ETM_DEFAULT_EVENT_VAL;
> +		memset(sysfs_config, 0, sizeof(struct etm_config));
> +		sysfs_config->mode = ETM_MODE_EXCLUDE;
> +		sysfs_config->trigger_event = ETM_DEFAULT_EVENT_VAL;
>   		for (i = 0; i < drvdata->caps.nr_addr_cmp; i++) {
> -			config->addr_type[i] = ETM_ADDR_TYPE_NONE;
> +			sysfs_config->addr_type[i] = ETM_ADDR_TYPE_NONE;
>   		}
>   
> -		etm_set_default(config);
> +		etm_set_default(sysfs_config);
>   		etm_release_trace_id(drvdata);
>   		spin_unlock(&drvdata->spinlock);
>   	}
> @@ -137,9 +137,9 @@ static ssize_t mode_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->mode;
> +	val = sysfs_config->mode;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -151,62 +151,62 @@ static ssize_t mode_store(struct device *dev,
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	const struct etm_caps *caps = &drvdata->caps;
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
>   	spin_lock(&drvdata->spinlock);
> -	config->mode = val & ETM_MODE_ALL;
> +	sysfs_config->mode = val & ETM_MODE_ALL;
>   
> -	if (config->mode & ETM_MODE_EXCLUDE)
> -		config->enable_ctrl1 |= ETMTECR1_INC_EXC;
> +	if (sysfs_config->mode & ETM_MODE_EXCLUDE)
> +		sysfs_config->enable_ctrl1 |= ETMTECR1_INC_EXC;
>   	else
> -		config->enable_ctrl1 &= ~ETMTECR1_INC_EXC;
> +		sysfs_config->enable_ctrl1 &= ~ETMTECR1_INC_EXC;
>   
> -	if (config->mode & ETM_MODE_CYCACC)
> -		config->ctrl |= ETMCR_CYC_ACC;
> +	if (sysfs_config->mode & ETM_MODE_CYCACC)
> +		sysfs_config->ctrl |= ETMCR_CYC_ACC;
>   	else
> -		config->ctrl &= ~ETMCR_CYC_ACC;
> +		sysfs_config->ctrl &= ~ETMCR_CYC_ACC;
>   
> -	if (config->mode & ETM_MODE_STALL) {
> +	if (sysfs_config->mode & ETM_MODE_STALL) {
>   		if (!caps->fifofull) {
>   			dev_warn(dev, "stall mode not supported\n");
>   			ret = -EINVAL;
>   			goto err_unlock;
>   		}
> -		config->ctrl |= ETMCR_STALL_MODE;
> +		sysfs_config->ctrl |= ETMCR_STALL_MODE;
>   	} else
> -		config->ctrl &= ~ETMCR_STALL_MODE;
> +		sysfs_config->ctrl &= ~ETMCR_STALL_MODE;
>   
> -	if (config->mode & ETM_MODE_TIMESTAMP) {
> +	if (sysfs_config->mode & ETM_MODE_TIMESTAMP) {
>   		if (!caps->timestamp) {
>   			dev_warn(dev, "timestamp not supported\n");
>   			ret = -EINVAL;
>   			goto err_unlock;
>   		}
> -		config->ctrl |= ETMCR_TIMESTAMP_EN;
> +		sysfs_config->ctrl |= ETMCR_TIMESTAMP_EN;
>   	} else
> -		config->ctrl &= ~ETMCR_TIMESTAMP_EN;
> +		sysfs_config->ctrl &= ~ETMCR_TIMESTAMP_EN;
>   
> -	if (config->mode & ETM_MODE_CTXID)
> -		config->ctrl |= ETMCR_CTXID_SIZE;
> +	if (sysfs_config->mode & ETM_MODE_CTXID)
> +		sysfs_config->ctrl |= ETMCR_CTXID_SIZE;
>   	else
> -		config->ctrl &= ~ETMCR_CTXID_SIZE;
> +		sysfs_config->ctrl &= ~ETMCR_CTXID_SIZE;
>   
> -	if (config->mode & ETM_MODE_BBROAD)
> -		config->ctrl |= ETMCR_BRANCH_BROADCAST;
> +	if (sysfs_config->mode & ETM_MODE_BBROAD)
> +		sysfs_config->ctrl |= ETMCR_BRANCH_BROADCAST;
>   	else
> -		config->ctrl &= ~ETMCR_BRANCH_BROADCAST;
> +		sysfs_config->ctrl &= ~ETMCR_BRANCH_BROADCAST;
>   
> -	if (config->mode & ETM_MODE_RET_STACK)
> -		config->ctrl |= ETMCR_RETURN_STACK;
> +	if (sysfs_config->mode & ETM_MODE_RET_STACK)
> +		sysfs_config->ctrl |= ETMCR_RETURN_STACK;
>   	else
> -		config->ctrl &= ~ETMCR_RETURN_STACK;
> +		sysfs_config->ctrl &= ~ETMCR_RETURN_STACK;
>   
> -	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
> -		etm_config_trace_mode(config);
> +	if (sysfs_config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
> +		etm_config_trace_mode(sysfs_config);
>   
>   	spin_unlock(&drvdata->spinlock);
>   
> @@ -223,9 +223,9 @@ static ssize_t trigger_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->trigger_event;
> +	val = sysfs_config->trigger_event;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -236,13 +236,13 @@ static ssize_t trigger_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->trigger_event = val & ETM_EVENT_MASK;
> +	sysfs_config->trigger_event = val & ETM_EVENT_MASK;
>   
>   	return size;
>   }
> @@ -253,9 +253,9 @@ static ssize_t enable_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->enable_event;
> +	val = sysfs_config->enable_event;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -266,13 +266,13 @@ static ssize_t enable_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->enable_event = val & ETM_EVENT_MASK;
> +	sysfs_config->enable_event = val & ETM_EVENT_MASK;
>   
>   	return size;
>   }
> @@ -283,9 +283,9 @@ static ssize_t fifofull_level_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->fifofull_level;
> +	val = sysfs_config->fifofull_level;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -296,13 +296,13 @@ static ssize_t fifofull_level_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->fifofull_level = val;
> +	sysfs_config->fifofull_level = val;
>   
>   	return size;
>   }
> @@ -313,9 +313,9 @@ static ssize_t addr_idx_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->addr_idx;
> +	val = sysfs_config->addr_idx;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -327,7 +327,7 @@ static ssize_t addr_idx_store(struct device *dev,
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	const struct etm_caps *caps = &drvdata->caps;
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
> @@ -341,7 +341,7 @@ static ssize_t addr_idx_store(struct device *dev,
>   	 * dereferenced multiple times within a spinlock block elsewhere.
>   	 */
>   	spin_lock(&drvdata->spinlock);
> -	config->addr_idx = val;
> +	sysfs_config->addr_idx = val;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -354,17 +354,17 @@ static ssize_t addr_single_show(struct device *dev,
>   	u8 idx;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	spin_lock(&drvdata->spinlock);
> -	idx = config->addr_idx;
> -	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> -	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
> +	idx = sysfs_config->addr_idx;
> +	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> +	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
>   		spin_unlock(&drvdata->spinlock);
>   		return -EINVAL;
>   	}
>   
> -	val = config->addr_val[idx];
> +	val = sysfs_config->addr_val[idx];
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return sprintf(buf, "%#lx\n", val);
> @@ -378,22 +378,22 @@ static ssize_t addr_single_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
>   	spin_lock(&drvdata->spinlock);
> -	idx = config->addr_idx;
> -	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> -	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
> +	idx = sysfs_config->addr_idx;
> +	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> +	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
>   		spin_unlock(&drvdata->spinlock);
>   		return -EINVAL;
>   	}
>   
> -	config->addr_val[idx] = val;
> -	config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
> +	sysfs_config->addr_val[idx] = val;
> +	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -406,24 +406,24 @@ static ssize_t addr_range_show(struct device *dev,
>   	u8 idx;
>   	unsigned long val1, val2;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	spin_lock(&drvdata->spinlock);
> -	idx = config->addr_idx;
> +	idx = sysfs_config->addr_idx;
>   	if (idx % 2 != 0) {
>   		spin_unlock(&drvdata->spinlock);
>   		return -EPERM;
>   	}
> -	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
> -	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
> -	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
> -	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
> +	if (!((sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
> +	       sysfs_config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
> +	      (sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
> +	       sysfs_config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
>   		spin_unlock(&drvdata->spinlock);
>   		return -EPERM;
>   	}
>   
> -	val1 = config->addr_val[idx];
> -	val2 = config->addr_val[idx + 1];
> +	val1 = sysfs_config->addr_val[idx];
> +	val2 = sysfs_config->addr_val[idx + 1];
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return sprintf(buf, "%#lx %#lx\n", val1, val2);
> @@ -436,7 +436,7 @@ static ssize_t addr_range_store(struct device *dev,
>   	u8 idx;
>   	unsigned long val1, val2;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	if (sscanf(buf, "%lx %lx", &val1, &val2) != 2)
>   		return -EINVAL;
> @@ -445,24 +445,24 @@ static ssize_t addr_range_store(struct device *dev,
>   		return -EINVAL;
>   
>   	spin_lock(&drvdata->spinlock);
> -	idx = config->addr_idx;
> +	idx = sysfs_config->addr_idx;
>   	if (idx % 2 != 0) {
>   		spin_unlock(&drvdata->spinlock);
>   		return -EPERM;
>   	}
> -	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
> -	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
> -	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
> -	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
> +	if (!((sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
> +	       sysfs_config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
> +	      (sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
> +	       sysfs_config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
>   		spin_unlock(&drvdata->spinlock);
>   		return -EPERM;
>   	}
>   
> -	config->addr_val[idx] = val1;
> -	config->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
> -	config->addr_val[idx + 1] = val2;
> -	config->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
> -	config->enable_ctrl1 |= (1 << (idx/2));
> +	sysfs_config->addr_val[idx] = val1;
> +	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
> +	sysfs_config->addr_val[idx + 1] = val2;
> +	sysfs_config->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
> +	sysfs_config->enable_ctrl1 |= (1 << (idx/2));
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -475,17 +475,17 @@ static ssize_t addr_start_show(struct device *dev,
>   	u8 idx;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	spin_lock(&drvdata->spinlock);
> -	idx = config->addr_idx;
> -	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> -	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
> +	idx = sysfs_config->addr_idx;
> +	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> +	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
>   		spin_unlock(&drvdata->spinlock);
>   		return -EPERM;
>   	}
>   
> -	val = config->addr_val[idx];
> +	val = sysfs_config->addr_val[idx];
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return sprintf(buf, "%#lx\n", val);
> @@ -499,24 +499,24 @@ static ssize_t addr_start_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
>   	spin_lock(&drvdata->spinlock);
> -	idx = config->addr_idx;
> -	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> -	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
> +	idx = sysfs_config->addr_idx;
> +	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> +	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
>   		spin_unlock(&drvdata->spinlock);
>   		return -EPERM;
>   	}
>   
> -	config->addr_val[idx] = val;
> -	config->addr_type[idx] = ETM_ADDR_TYPE_START;
> -	config->startstop_ctrl |= (1 << idx);
> -	config->enable_ctrl1 |= ETMTECR1_START_STOP;
> +	sysfs_config->addr_val[idx] = val;
> +	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_START;
> +	sysfs_config->startstop_ctrl |= (1 << idx);
> +	sysfs_config->enable_ctrl1 |= ETMTECR1_START_STOP;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -529,17 +529,17 @@ static ssize_t addr_stop_show(struct device *dev,
>   	u8 idx;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	spin_lock(&drvdata->spinlock);
> -	idx = config->addr_idx;
> -	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> -	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
> +	idx = sysfs_config->addr_idx;
> +	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> +	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
>   		spin_unlock(&drvdata->spinlock);
>   		return -EPERM;
>   	}
>   
> -	val = config->addr_val[idx];
> +	val = sysfs_config->addr_val[idx];
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return sprintf(buf, "%#lx\n", val);
> @@ -553,24 +553,24 @@ static ssize_t addr_stop_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
>   	spin_lock(&drvdata->spinlock);
> -	idx = config->addr_idx;
> -	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> -	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
> +	idx = sysfs_config->addr_idx;
> +	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
> +	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
>   		spin_unlock(&drvdata->spinlock);
>   		return -EPERM;
>   	}
>   
> -	config->addr_val[idx] = val;
> -	config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
> -	config->startstop_ctrl |= (1 << (idx + 16));
> -	config->enable_ctrl1 |= ETMTECR1_START_STOP;
> +	sysfs_config->addr_val[idx] = val;
> +	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
> +	sysfs_config->startstop_ctrl |= (1 << (idx + 16));
> +	sysfs_config->enable_ctrl1 |= ETMTECR1_START_STOP;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -582,10 +582,10 @@ static ssize_t addr_acctype_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	spin_lock(&drvdata->spinlock);
> -	val = config->addr_acctype[config->addr_idx];
> +	val = sysfs_config->addr_acctype[sysfs_config->addr_idx];
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return sprintf(buf, "%#lx\n", val);
> @@ -598,14 +598,14 @@ static ssize_t addr_acctype_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
>   	spin_lock(&drvdata->spinlock);
> -	config->addr_acctype[config->addr_idx] = val;
> +	sysfs_config->addr_acctype[sysfs_config->addr_idx] = val;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -617,9 +617,9 @@ static ssize_t cntr_idx_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->cntr_idx;
> +	val = sysfs_config->cntr_idx;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -631,7 +631,7 @@ static ssize_t cntr_idx_store(struct device *dev,
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	const struct etm_caps *caps = &drvdata->caps;
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
> @@ -644,7 +644,7 @@ static ssize_t cntr_idx_store(struct device *dev,
>   	 * dereferenced multiple times within a spinlock block elsewhere.
>   	 */
>   	spin_lock(&drvdata->spinlock);
> -	config->cntr_idx = val;
> +	sysfs_config->cntr_idx = val;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -656,10 +656,10 @@ static ssize_t cntr_rld_val_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	spin_lock(&drvdata->spinlock);
> -	val = config->cntr_rld_val[config->cntr_idx];
> +	val = sysfs_config->cntr_rld_val[sysfs_config->cntr_idx];
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return sprintf(buf, "%#lx\n", val);
> @@ -672,14 +672,14 @@ static ssize_t cntr_rld_val_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
>   	spin_lock(&drvdata->spinlock);
> -	config->cntr_rld_val[config->cntr_idx] = val;
> +	sysfs_config->cntr_rld_val[sysfs_config->cntr_idx] = val;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -691,10 +691,10 @@ static ssize_t cntr_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	spin_lock(&drvdata->spinlock);
> -	val = config->cntr_event[config->cntr_idx];
> +	val = sysfs_config->cntr_event[sysfs_config->cntr_idx];
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return sprintf(buf, "%#lx\n", val);
> @@ -707,14 +707,14 @@ static ssize_t cntr_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
>   	spin_lock(&drvdata->spinlock);
> -	config->cntr_event[config->cntr_idx] = val & ETM_EVENT_MASK;
> +	sysfs_config->cntr_event[sysfs_config->cntr_idx] = val & ETM_EVENT_MASK;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -726,10 +726,10 @@ static ssize_t cntr_rld_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	spin_lock(&drvdata->spinlock);
> -	val = config->cntr_rld_event[config->cntr_idx];
> +	val = sysfs_config->cntr_rld_event[sysfs_config->cntr_idx];
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return sprintf(buf, "%#lx\n", val);
> @@ -742,14 +742,14 @@ static ssize_t cntr_rld_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
>   	spin_lock(&drvdata->spinlock);
> -	config->cntr_rld_event[config->cntr_idx] = val & ETM_EVENT_MASK;
> +	sysfs_config->cntr_rld_event[sysfs_config->cntr_idx] = val & ETM_EVENT_MASK;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -763,14 +763,14 @@ static ssize_t cntr_val_show(struct device *dev,
>   	u32 val;
>   	unsigned long val2;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	if (!coresight_get_mode(drvdata->csdev)) {
>   		spin_lock(&drvdata->spinlock);
> -		val = config->cntr_val[config->cntr_idx];
> +		val = sysfs_config->cntr_val[sysfs_config->cntr_idx];
>   		spin_unlock(&drvdata->spinlock);
>   	} else {
> -		ret = etm_readl_cslocked(drvdata, ETMCNTVRn(config->cntr_idx), &val2);
> +		ret = etm_readl_cslocked(drvdata, ETMCNTVRn(sysfs_config->cntr_idx), &val2);
>   		if (ret)
>   			return ret;
>   		val = val2;
> @@ -786,7 +786,7 @@ static ssize_t cntr_val_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
> @@ -796,7 +796,7 @@ static ssize_t cntr_val_store(struct device *dev,
>   		return -EBUSY;
>   
>   	spin_lock(&drvdata->spinlock);
> -	config->cntr_val[config->cntr_idx] = val;
> +	sysfs_config->cntr_val[sysfs_config->cntr_idx] = val;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -808,9 +808,9 @@ static ssize_t seq_12_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->seq_12_event;
> +	val = sysfs_config->seq_12_event;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -821,13 +821,13 @@ static ssize_t seq_12_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->seq_12_event = val & ETM_EVENT_MASK;
> +	sysfs_config->seq_12_event = val & ETM_EVENT_MASK;
>   	return size;
>   }
>   static DEVICE_ATTR_RW(seq_12_event);
> @@ -837,9 +837,9 @@ static ssize_t seq_21_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->seq_21_event;
> +	val = sysfs_config->seq_21_event;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -850,13 +850,13 @@ static ssize_t seq_21_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->seq_21_event = val & ETM_EVENT_MASK;
> +	sysfs_config->seq_21_event = val & ETM_EVENT_MASK;
>   	return size;
>   }
>   static DEVICE_ATTR_RW(seq_21_event);
> @@ -866,9 +866,9 @@ static ssize_t seq_23_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->seq_23_event;
> +	val = sysfs_config->seq_23_event;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -879,13 +879,13 @@ static ssize_t seq_23_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->seq_23_event = val & ETM_EVENT_MASK;
> +	sysfs_config->seq_23_event = val & ETM_EVENT_MASK;
>   	return size;
>   }
>   static DEVICE_ATTR_RW(seq_23_event);
> @@ -895,9 +895,9 @@ static ssize_t seq_31_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->seq_31_event;
> +	val = sysfs_config->seq_31_event;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -908,13 +908,13 @@ static ssize_t seq_31_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->seq_31_event = val & ETM_EVENT_MASK;
> +	sysfs_config->seq_31_event = val & ETM_EVENT_MASK;
>   	return size;
>   }
>   static DEVICE_ATTR_RW(seq_31_event);
> @@ -924,9 +924,9 @@ static ssize_t seq_32_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->seq_32_event;
> +	val = sysfs_config->seq_32_event;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -937,13 +937,13 @@ static ssize_t seq_32_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->seq_32_event = val & ETM_EVENT_MASK;
> +	sysfs_config->seq_32_event = val & ETM_EVENT_MASK;
>   	return size;
>   }
>   static DEVICE_ATTR_RW(seq_32_event);
> @@ -953,9 +953,9 @@ static ssize_t seq_13_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->seq_13_event;
> +	val = sysfs_config->seq_13_event;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -966,13 +966,13 @@ static ssize_t seq_13_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->seq_13_event = val & ETM_EVENT_MASK;
> +	sysfs_config->seq_13_event = val & ETM_EVENT_MASK;
>   	return size;
>   }
>   static DEVICE_ATTR_RW(seq_13_event);
> @@ -983,10 +983,10 @@ static ssize_t seq_curr_state_show(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	if (!coresight_get_mode(drvdata->csdev)) {
> -		val = config->seq_curr_state;
> +		val = sysfs_config->seq_curr_state;
>   		goto out;
>   	}
>   
> @@ -1005,7 +1005,7 @@ static ssize_t seq_curr_state_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
> @@ -1014,7 +1014,7 @@ static ssize_t seq_curr_state_store(struct device *dev,
>   	if (val > ETM_SEQ_STATE_MAX_VAL)
>   		return -EINVAL;
>   
> -	config->seq_curr_state = val;
> +	sysfs_config->seq_curr_state = val;
>   
>   	return size;
>   }
> @@ -1025,9 +1025,9 @@ static ssize_t ctxid_idx_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->ctxid_idx;
> +	val = sysfs_config->ctxid_idx;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -1039,7 +1039,7 @@ static ssize_t ctxid_idx_store(struct device *dev,
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	const struct etm_caps *caps = &drvdata->caps;
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
> @@ -1053,7 +1053,7 @@ static ssize_t ctxid_idx_store(struct device *dev,
>   	 * dereferenced multiple times within a spinlock block elsewhere.
>   	 */
>   	spin_lock(&drvdata->spinlock);
> -	config->ctxid_idx = val;
> +	sysfs_config->ctxid_idx = val;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -1065,7 +1065,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	/*
>   	 * Don't use contextID tracing if coming from a PID namespace.  See
> @@ -1075,7 +1075,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
>   		return -EINVAL;
>   
>   	spin_lock(&drvdata->spinlock);
> -	val = config->ctxid_pid[config->ctxid_idx];
> +	val = sysfs_config->ctxid_pid[sysfs_config->ctxid_idx];
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return sprintf(buf, "%#lx\n", val);
> @@ -1088,7 +1088,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
>   	int ret;
>   	unsigned long pid;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	/*
>   	 * When contextID tracing is enabled the tracers will insert the
> @@ -1107,7 +1107,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
>   		return ret;
>   
>   	spin_lock(&drvdata->spinlock);
> -	config->ctxid_pid[config->ctxid_idx] = pid;
> +	sysfs_config->ctxid_pid[sysfs_config->ctxid_idx] = pid;
>   	spin_unlock(&drvdata->spinlock);
>   
>   	return size;
> @@ -1119,7 +1119,7 @@ static ssize_t ctxid_mask_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	/*
>   	 * Don't use contextID tracing if coming from a PID namespace.  See
> @@ -1128,7 +1128,7 @@ static ssize_t ctxid_mask_show(struct device *dev,
>   	if (task_active_pid_ns(current) != &init_pid_ns)
>   		return -EINVAL;
>   
> -	val = config->ctxid_mask;
> +	val = sysfs_config->ctxid_mask;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -1139,7 +1139,7 @@ static ssize_t ctxid_mask_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	/*
>   	 * Don't use contextID tracing if coming from a PID namespace.  See
> @@ -1152,7 +1152,7 @@ static ssize_t ctxid_mask_store(struct device *dev,
>   	if (ret)
>   		return ret;
>   
> -	config->ctxid_mask = val;
> +	sysfs_config->ctxid_mask = val;
>   	return size;
>   }
>   static DEVICE_ATTR_RW(ctxid_mask);
> @@ -1162,9 +1162,9 @@ static ssize_t sync_freq_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->sync_freq;
> +	val = sysfs_config->sync_freq;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -1175,13 +1175,13 @@ static ssize_t sync_freq_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->sync_freq = val & ETM_SYNC_MASK;
> +	sysfs_config->sync_freq = val & ETM_SYNC_MASK;
>   	return size;
>   }
>   static DEVICE_ATTR_RW(sync_freq);
> @@ -1191,9 +1191,9 @@ static ssize_t timestamp_event_show(struct device *dev,
>   {
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
> -	val = config->timestamp_event;
> +	val = sysfs_config->timestamp_event;
>   	return sprintf(buf, "%#lx\n", val);
>   }
>   
> @@ -1204,13 +1204,13 @@ static ssize_t timestamp_event_store(struct device *dev,
>   	int ret;
>   	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *sysfs_config = &drvdata->sysfs_config;
>   
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
>   
> -	config->timestamp_event = val & ETM_EVENT_MASK;
> +	sysfs_config->timestamp_event = val & ETM_EVENT_MASK;
>   	return size;
>   }
>   static DEVICE_ATTR_RW(timestamp_event);
> 

