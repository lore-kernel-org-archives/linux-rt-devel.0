Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005E83DCDAC
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678978; cv=fail; b=avrpnArChE9UpzE6HWUuGsHCNNQ09NUG0M9Jt9WNc1UC/DfFHH0LWGDlSbJjBhoR/IbPz+DSjJ4XaK67OtrjtY4W3c6YUrOWwnU6Q9GbvsVN30R8R9im12AC3IY1QjS+Xg0PlgAfmKwKiCG++eMXrGm5LMoXRGid/vis3fjpafk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678978; c=relaxed/simple;
	bh=R9NSvLzD5/LKoPly/YXVNVulswn38zvI5fMdsHSbTbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nmDkZ84BWAMDw4dDDi15MB6hWZZsUz63qJO/iKxvQwOim6Czhi5GktC5p3zMDUSJq5fySHKypftuCZI/69aZSiGVER7SXT6TSERGDa6PNLOkHg8qVLEUFZpiKm54mpedMO+FMcMR3lncW9Cv11i23Txe2+HKZ+pgjRKure512wY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nbGq7cLl; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nbGq7cLl; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nbGq7cLl";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nbGq7cLl"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MXx7vyefo9O3HAGGKhLAWMm674FCHz2+Jk84OjiqpGsk6XWJkKJtrurui6PcQxGbioUGlCSjzj0Kf44ldtOTodbymuDfj+/Fz5XhMGEkq0tWv6zi83Udlz730pGspq7l0ghwMkoCwmNuSwQnnq8GVIxgMeAcRN3BCa6L7GfiN18AOQcZsZ4SkF1Xv8l3tZvjrNZv0ez0glRzlwi02HvOBRjbdYJ4I0z0okojl2ENVaw16cbMVTvfJsM8bacw8PUclDqlL6eeYmRXcwm5OeqHjNsI9rDM4a1uPFQhgD17QCxwV+07r1vsgFCDXm4s8/c0gLxB6/3pkqH4lb54Z42jTw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLMVtCtq+d81zYt+Wj4J+y9PZ0y7NHraQShkuwSJCyw=;
 b=MAMXZHT7uYFsfcyICIpVTzEs7by2UlAME20xD7hC9NpVqxoO3UsCVk5wiJ3sbqBSwcTmnE1AH2hiE5DNhXmbXgcsEy0e621q6cFHKJANMdSzsl+T3qJ5IdEz1Lg7YJJA+cklnFb3G0A92XSu8bORZa6SlH5FgQf1KKINaHZYirF4v/bEcjumkZqh+cgUl4yZL5x45ZdguFReyPDBnoD2gLg+OjTYcFBCIu+LMA4QG6q8EwY2c5eBZT17NqYbIiVfj/4WHf+Wci111Oc8T63E8ArTf7QKaaGa8u9CEM2MklNjOYLArGbyIs4l8Cn1+fZXNvRgDBHVhjeIdxKWt0o1pQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLMVtCtq+d81zYt+Wj4J+y9PZ0y7NHraQShkuwSJCyw=;
 b=nbGq7cLlln9Qklhui4Y7OXIYBzeLFSyaRMi5p0uOs7qrH9eVHn4/tvDWv3QpVWRWV10w5JemrnYj/KGYtb8Ct7TV3mKxRxGoRgmIf1Z9zP7q+WlqHWUc0PJgMM+QrDbhp8qYO42PJEzaIXgo1gmnC8VO0YIjrZITTFLx0adzwDQ=
Received: from AS4P192CA0042.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::21)
 by AMBPR08MB635056.eurprd08.prod.outlook.com (2603:10a6:20b:7ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 10:49:24 +0000
Received: from AM1PEPF000C1AD7.eurprd02.prod.outlook.com
 (2603:10a6:20b:658:cafe::43) by AS4P192CA0042.outlook.office365.com
 (2603:10a6:20b:658::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 10:49:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000C1AD7.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Tue, 29 Sep 2026 10:49:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNakrlE8Ok4GxNcllb8nBg2fHelOHYPzifY2X2jWgGMhE+SY9cJ+8zWZ+PDWObwuVnPgpl3clKW4JrvcGmAWEEEBoXiN07KcwVfBofJo2RcRE8LdQioo5vJLg568f6bkAeQXPjwyKH1A+elf5LjlZyLUF3wh60hDvLnktfnSnEpp66CtKY6VVH4ScoboxXXL7XARRyeYaUGup49+hefxVuQbHR9auv8sQoZlLOZ/gSSecNgogYYd3xbrNOqoG6xZXi9Vy+slYfAtwjEVvH6s4Ho/CSK5n/Lf7DegXYwuxr/MP3O0KjP2fXKc/YKTqk3f84dxAxkzw9Fk7z+2sjv5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLMVtCtq+d81zYt+Wj4J+y9PZ0y7NHraQShkuwSJCyw=;
 b=f6RMgyr378Oflxq4IFz1Zufe2e1TwdxP3NTQUBwIFlxb0OPgZ1TBRnv87AxVtrzJWVxE0MBUeXWxkk69mskQADTeTZyMxKWjP5Tgw0GSnIUiqELO7EIqsyQ1z3DjdNj2LCFbyJuDpFfzHvC3F63zg99qk8w6KTRd4PRDpDR7yQZmS8XY68sK1yncE286qjMlpo51O6vTxUme3i9xgSZV6gT29SHJDQe7KHGXEp0BEGW4tFMf80JCyeQ/ee7TUHRjoYiKqkoMQx6i9YkCsJ8uH6oWqKfZjleQmNI0lhGFQ4kQtvU9kBpkn6FbOI7r6d4bDtm46N4fgKWoYMy6BWI77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLMVtCtq+d81zYt+Wj4J+y9PZ0y7NHraQShkuwSJCyw=;
 b=nbGq7cLlln9Qklhui4Y7OXIYBzeLFSyaRMi5p0uOs7qrH9eVHn4/tvDWv3QpVWRWV10w5JemrnYj/KGYtb8Ct7TV3mKxRxGoRgmIf1Z9zP7q+WlqHWUc0PJgMM+QrDbhp8qYO42PJEzaIXgo1gmnC8VO0YIjrZITTFLx0adzwDQ=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by VI0PR08MB10684.eurprd08.prod.outlook.com (2603:10a6:800:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 10:48:50 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0472.005; Tue, 29 Sep 2026
 10:48:50 +0000
Message-ID: <99fb72a3-fd3c-4f9f-80b2-db04a0eee434@arm.com>
Date: Tue, 29 Sep 2026 11:48:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/14] coresight: etm4x: fix inconsistencies with
 sysfs configuration
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
 <20260924-separate_etm_cfg_v2-v12-4-a2b41d2f7c2b@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-4-a2b41d2f7c2b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::13) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|VI0PR08MB10684:EE_|AM1PEPF000C1AD7:EE_|AMBPR08MB635056:EE_
X-MS-Office365-Filtering-Correlation-Id: afaeed07-0e2a-4cb2-d047-08df1e175360
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|5023799004|3023799007|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 +/MbZedQk3C2B4fg3HvJWcLhNDW8h0KxwsqhUmrnqUN7GNbsa2eKBV7a0BCBmsBVDWS0OUtRUyG8YwjumBRsTg8ZOG5YaKPLrls2NcamEc4cpuhkSrqfrwM8tgzyLvWp6y/SdgpHhBgPEzdBnd7HthDE9AYzRi3k0gQGCgrmhml8dkBA+34QPx9YHAemxBgFHbgmYWhDmrCWLSuv4pdr7hXqkzNwQ/RLnTvZcZ4WIU1lEjPmaIO6VWA9bdMpr8iF85Lj2BWGcN26SbZSH69b/P2ciX1ChccsM1+pDoGfhZPhTjJoQBe4R/HKoQR+Lak0wkyXAeiiMpl6JYjxXWL0WcOzwGDbBNRfCzCHfBzlAyTNFw/8sHv5LkMQHlrINeoSkAhl7uFOrvlN9pNSVNYtoXGt5djLIO0++5ZyZj6SqRdmXg5Kwn1DSI3ECzgkwvnBxswYY+V+lzxCdsp8M67KbBVaWkOuhwhbzCMDhKJ7C31C7h08A8Re8HpHHAqYWMB3F+iEWJhuQ4mcWIAnK7/rjJZYFlDlCOG+F5iDpJvH30kYFG+9dCY7f9hPSat4RASUXX4S1HCTYfkFM8ieJcCg2bHnJr6M+PrqlkqN4q3naS0Kh2EQJiQ/Ye4TnqvygWgbY4G6f39gFrHRxUTvMabBlMek5aPzDZXQlEs8SGxfMF0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 MMmqb0paqUq73VW3QdmuZKC+pHHF58XX6Gd34QoRWc1baaEAUFwJW5KhoBvIyoWxOYxS4ZkM8PLWz4CQ5UqmGhKJCWP+Ffv+xxQh8d0IKvQIkTehxqSkhuxLFjByg33sqeF13li/dwBfOvjvOZsKRqoZ2mi6lhlvI1Y8xr5PI5uU4jszHMqJXkm5i8eqWGaKyjyi8PtiqLaEG5RrTlRRMcKdoxybKDe1pk2Iw4ZEaPaW2kBbFEcDMuWgyx3FAof2gM2ZOGRqVmmpevf8QoEHpN1aHC0le9ulZ4q+mPF2w4dBs7rbmQHjzIQij1+FV8S1Tb7f33RyVkMLvy+T1qygVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10684
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000C1AD7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	deeef11c-6257-4106-0c22-08df1e173f2f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|14060799003|35042699022|23010399003|6133799003|22082099003|18002099003|3023799007|10067099003|5023799004|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	hjGZoKgE64aEht1LtaHZBsXvy2DMaX8HRteAoQG5ZRKSgD3cRbV3GnGxKffLBD/CxwMAMF6JaWZFFE2HHEcrAUo8RKJC23JZzK2Fts21WGncPx/5vqoK2hroyNMXu2980b3TQUdXBtZERcjxwLDTUAZLiRhAjeHZCAYjeKZWnwV4mhWebWTgyKHr7N1xwiF5wQ5AqghWXtfMLrcxgYMUbeXhEbxUX913kGXjmJLL7w4lIa7ayjgiDmZWHQuP3DIiOVV9MkqcRYiJuugn1xjr/EMNj/1eIMvhChQ6jP3aOnVoJB6mjQPaw8FGbfg69pUJRt6wP0zPGTpuycwCckQxEOf5pS4vOarcWnSjdL+qAw1NhqWmi7v4eeABx8DcRc4x/iT8oB4JPQTiTQbAV+kyKJ4acuq8OVqdQiWurdsleBtFgl5U8o7TtAeBwHZoH5kjE+dt8DjokPCXn+ImyX01YUhRvCnC7ge52KS5EYpWLs6fp/4iMd48BGHGw8L/OljVI5VWYf9yLEG28frrcNW+fJGLvb/9I+sn6G9JIP2WFRO6mo6NUZcM1dldtn0Q+vHASkdQb1KhhnoeEa+pz71c0Uj8lrafQJhoJDLFQm3ChC+WH8NNvAyr7gVqXdefX/BkjzDBMl37iDhbumPLBvp39QbkMZ9XosV90/QctGfoe8uNmU4ftzCdiWltPvY+ymBymgFXjDCiqYS5PViqur4/3A==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(14060799003)(35042699022)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KRNLnGJzlJnrQvtAvgbDMrpvbhNGKjwnsAaFrfgnUhjySR7znamYXfhnUxQCxmkag7RQlLYG9dBjKG5C0wK1q/zN1OcvLcZFyYjFfiHdjJ5KNp5CStopDbgkUEDn9k/cHuZ7Dhz9aOzpUHkrhASe81RznqaPeuIWoJWixIP6UTMabbm0Z1NuAYGcVUNrtyJKBzVwz0O8iNY/zw0RtdD+mJMUbNTWBklHJKdCkzcZsg/+9Wa5U46PTfMr6a/iZKBdFWzA0iQBnC3Ma97ZH/Wk43ofxYIJRMKmEdcRraHkMVL+yNSsLCVirimevk+pVbq5Gi0yq9yN/D3cC/Aw1XGxVVcmUE6iyvIRpUekN2VzcQ8KzuLErO0108LHZspx6nBIbxY201B12cMMWu5PcBSr5veNBbL7XvgKn6Vml7EUZl/lIEDoHlmxpYfXWqkntSpC
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:49:24.0851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afaeed07-0e2a-4cb2-d047-08df1e175360
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1AD7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB635056

Reviewed-by: Mike Leach <mike.leach@arm.com>

On 9/24/26 18:33, Yeoreum Yun wrote:
> The current ETM4x configuration via sysfs can lead to
> several inconsistencies:
> 
>    - If the configuration is modified via sysfs while a perf session is
>      active, the running configuration may differ before a sched-out and
>      after a subsequent sched-in.
> 
>    - If a perf session and a sysfs session enable tracing concurrently,
>      the configuration from configfs may become corrupted.
> 
>    - There is a risk of corrupting drvdata->config if a perf session enables
>      tracing while cscfg_csdev_disable_active_config() is being handled in
>      etm4_disable_sysfs().
> 
> To resolve these issues, separate the configuration into:
> 
>    - curr_config: the configuration applied to the current session
>    - config: the configuration set via sysfs
> 
> Additionally:
> 
>    - Apply the configuration from configfs after taking the appropriate mode.
> 
>    - Since curr_config and related fields are accessed only by the local CPU
>      in etm4_enable/disable_sysfs_smp_call() (similar to perf enable/disable),
>      remove the lock/unlock from the sysfs enable/disable path and
>      startup/dying_cpu except when to access config fields.
> 
> As the curr_config is used for cfg-configfs, etmv4 doesn't need to set
> its lock for the cfg-configfs since the curr_config is proceted by cs_mode
> otherwise it would make a possible cpu-stall when it get interrupt while
> setting the sysfs configuration.
> 
> Therefore, set the drv_spinlock for cfg-configfs as NULL and
> let the cfg-configfs disable irq without grap drv_spinlock when it is NULL.
> 
> Fixes: 54ff892b76c6 ("coresight: etm4x: splitting struct etmv4_drvdata")
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-config.c     |  18 ++--
>   drivers/hwtracing/coresight/coresight-config.h     |  22 ++++
>   drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |  13 ++-
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 117 ++++++++++++---------
>   .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   5 +-
>   drivers/hwtracing/coresight/coresight-etm4x.h      |   4 +-
>   6 files changed, 112 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.c b/drivers/hwtracing/coresight/coresight-config.c
> index 4f72ae71b696..0e296289f286 100644
> --- a/drivers/hwtracing/coresight/coresight-config.c
> +++ b/drivers/hwtracing/coresight/coresight-config.c
> @@ -73,13 +73,12 @@ static void cscfg_init_reg_param(struct cscfg_feature_csdev *feat_csdev,
>   /* set values into the driver locations referenced in cscfg_reg_csdev */
>   static int cscfg_set_on_enable(struct cscfg_feature_csdev *feat_csdev)
>   {
> -	unsigned long flags;
>   	int i;
>   
> -	raw_spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
> -	for (i = 0; i < feat_csdev->nr_regs; i++)
> -		cscfg_set_reg(&feat_csdev->regs_csdev[i]);
> -	raw_spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
> +	scoped_guard(feat_csdev_lock, feat_csdev) {
> +		for (i = 0; i < feat_csdev->nr_regs; i++)
> +			cscfg_set_reg(&feat_csdev->regs_csdev[i]);
> +	}
>   	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
>   		feat_csdev->feat_desc->name, "set on enable");
>   	return 0;
> @@ -88,13 +87,12 @@ static int cscfg_set_on_enable(struct cscfg_feature_csdev *feat_csdev)
>   /* copy back values from the driver locations referenced in cscfg_reg_csdev */
>   static void cscfg_save_on_disable(struct cscfg_feature_csdev *feat_csdev)
>   {
> -	unsigned long flags;
>   	int i;
>   
> -	raw_spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
> -	for (i = 0; i < feat_csdev->nr_regs; i++)
> -		cscfg_save_reg(&feat_csdev->regs_csdev[i]);
> -	raw_spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
> +	scoped_guard(feat_csdev_lock, feat_csdev) {
> +		for (i = 0; i < feat_csdev->nr_regs; i++)
> +			cscfg_save_reg(&feat_csdev->regs_csdev[i]);
> +	}
>   	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
>   		feat_csdev->feat_desc->name, "save on disable");
>   }
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 90fd937d3bd8..ae6295e30813 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -7,6 +7,7 @@
>   #ifndef _CORESIGHT_CORESIGHT_CONFIG_H
>   #define _CORESIGHT_CORESIGHT_CONFIG_H
>   
> +#include <linux/cleanup.h>
>   #include <linux/coresight.h>
>   #include <linux/types.h>
>   
> @@ -259,4 +260,25 @@ void cscfg_csdev_disable_config(struct cscfg_config_csdev *config_csdev);
>   /* reset a feature to default values */
>   void cscfg_reset_feat(struct cscfg_feature_csdev *feat_csdev);
>   
> +#define feat_csdev_lock(feat_csdev, flags)				\
> +	do {								\
> +		raw_spinlock_t *__lock = feat_csdev->drv_spinlock;	\
> +		typecheck(unsigned long, flags);			\
> +		if (__lock)						\
> +			raw_spin_lock_irqsave(__lock, flags);		\
> +	} while (0)
> +
> +#define feat_csdev_unlock(feat_csdev, flags)				\
> +	do {								\
> +		raw_spinlock_t *__lock = feat_csdev->drv_spinlock;	\
> +		typecheck(unsigned long, flags);			\
> +		if (__lock)						\
> +			raw_spin_unlock_irqrestore(__lock, flags);	\
> +	} while (0)
> +
> +DEFINE_LOCK_GUARD_1(feat_csdev_lock, struct cscfg_feature_csdev,
> +		    feat_csdev_lock(_T->lock, _T->flags),
> +		    feat_csdev_unlock(_T->lock, _T->flags),
> +		    unsigned long flags)
> +
>   #endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> index e1a59b434505..a9f6ed47a2f5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> @@ -47,7 +47,7 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
>   				   struct cscfg_regval_csdev *reg_csdev, u32 offset)
>   {
>   	int err = -EINVAL, idx;
> -	struct etmv4_config *drvcfg = &drvdata->config;
> +	struct etmv4_config *drvcfg = &drvdata->curr_config;
>   	u32 off_mask;
>   
>   	if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
> @@ -154,11 +154,14 @@ static int etm4_cfg_load_feature(struct coresight_device *csdev,
>   	int i = 0, err = 0;
>   
>   	/*
> -	 * essential we set the device spinlock - this is used in the generic
> -	 * programming routines when copying values into the drvdata structures
> -	 * via the pointers setup in etm4_cfg_map_reg_offset().
> +	 * drvdata structure of etm4 for configfs is curr_config and
> +	 * this curr_config is protected with csdev->mode by restricting
> +	 * access to curr_config after mode changed to PERF or SYSFS.
> +	 *
> +	 * Therefore, it doesn't need to protected with etmv4_drvdata->spinlock
> +	 * to feature applying and set the NULL.
>   	 */
> -	feat_csdev->drv_spinlock = &drvdata->spinlock;
> +	feat_csdev->drv_spinlock = NULL;
>   
>   	/* process the register descriptions */
>   	for (i = 0; i < feat_csdev->nr_regs && !err; i++) {
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 9ca03a5913a3..61e9971bdc6b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -264,10 +264,11 @@ static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
>   static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
>   {
>   	u64 trfcr = drvdata->trfcr;
> +	struct etmv4_config *config = &drvdata->curr_config;
>   
> -	if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
> +	if (config->mode & ETM_MODE_EXCL_KERN)
>   		trfcr &= ~TRFCR_EL1_ExTRE;
> -	if (drvdata->config.mode & ETM_MODE_EXCL_USER)
> +	if (config->mode & ETM_MODE_EXCL_USER)
>   		trfcr &= ~TRFCR_EL1_E0TRE;
>   
>   	return trfcr;
> @@ -275,7 +276,7 @@ static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
>   
>   /*
>    * etm4x_allow_trace - Allow CPU tracing in the respective ELs,
> - * as configured by the drvdata->config.mode for the current
> + * as configured by the drvdata->curr_config.mode for the current
>    * session. Even though we have TRCVICTLR bits to filter the
>    * trace in the ELs, it doesn't prevent the ETM from generating
>    * a packet (e.g, TraceInfo) that might contain the addresses from
> @@ -286,12 +287,13 @@ static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
>   static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
>   {
>   	u64 trfcr, guest_trfcr;
> +	struct etmv4_config *config = &drvdata->curr_config;
>   
>   	/* If the CPU doesn't support FEAT_TRF, nothing to do */
>   	if (!drvdata->trfcr)
>   		return;
>   
> -	if (drvdata->config.mode & ETM_MODE_EXCL_HOST)
> +	if (config->mode & ETM_MODE_EXCL_HOST)
>   		trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
>   	else
>   		trfcr = etm4x_get_kern_user_filter(drvdata);
> @@ -299,7 +301,7 @@ static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
>   	write_trfcr(trfcr);
>   
>   	/* Set filters for guests and pass to KVM */
> -	if (drvdata->config.mode & ETM_MODE_EXCL_GUEST)
> +	if (config->mode & ETM_MODE_EXCL_GUEST)
>   		guest_trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
>   	else
>   		guest_trfcr = etm4x_get_kern_user_filter(drvdata);
> @@ -492,7 +494,7 @@ static int etm4_enable_trace_unit(struct etmv4_drvdata *drvdata)
>   static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   {
>   	int i, rc;
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->curr_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   	struct device *etm_dev = &csdev->dev;
>   	struct csdev_access *csa = &csdev->access;
> @@ -612,27 +614,42 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   static void etm4_enable_sysfs_smp_call(void *info)
>   {
>   	struct etm4_enable_arg *arg = info;
> +	struct etmv4_drvdata *drvdata;
>   	struct coresight_device *csdev;
> +	unsigned long cfg_hash;
> +	int preset;
>   
>   	if (WARN_ON(!arg))
>   		return;
>   
> -	csdev = arg->drvdata->csdev;
> -	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
> -		/* Someone is already using the tracer */
> -		arg->rc = -EBUSY;
> -		return;
> +	drvdata = arg->drvdata;
> +	csdev = drvdata->csdev;
> +
> +	/* enable any config activated by configfs */
> +	cscfg_config_sysfs_get_active_cfg(&cfg_hash, &preset);
> +	if (cfg_hash) {
> +		arg->rc = cscfg_csdev_enable_active_config(csdev,
> +							   cfg_hash,
> +							   preset);
> +		if (arg->rc)
> +			return;
>   	}
>   
> -	arg->rc = etm4_enable_hw(arg->drvdata);
> +	drvdata->trcid = arg->path->trace_id;
> +
> +	/* Tracer will never be paused in sysfs mode */
> +	drvdata->paused = false;
>   
> -	/* The tracer didn't start */
> +	arg->rc = etm4_enable_hw(drvdata);
>   	if (arg->rc) {
> -		coresight_set_mode(csdev, CS_MODE_DISABLED);
> +		cscfg_csdev_disable_active_config(csdev);
>   		return;
>   	}
>   
> +	drvdata->sticky_enable = true;
>   	csdev->path = arg->path;
> +
> +	return;
>   }
>   
>   /*
> @@ -669,7 +686,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>   {
>   	int ctridx;
>   	int rselector;
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->curr_config;
>   
>   	/* No point in trying if we don't have at least one counter */
>   	if (!drvdata->nr_cntr)
> @@ -752,7 +769,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   {
>   	int ret = 0;
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->curr_config;
>   	struct perf_event_attr max_timestamp = {
>   		.ATTR_CFG_FLD_timestamp_CFG = U64_MAX,
>   	};
> @@ -919,46 +936,36 @@ static int etm4_enable_sysfs(struct coresight_device *csdev, struct coresight_pa
>   {
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>   	struct etm4_enable_arg arg = { };
> -	unsigned long cfg_hash;
> -	int ret, preset;
> +	int ret;
>   
> -	/* enable any config activated by configfs */
> -	cscfg_config_sysfs_get_active_cfg(&cfg_hash, &preset);
> -	if (cfg_hash) {
> -		ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
> -		if (ret) {
> -			etm4_release_trace_id(drvdata);
> -			return ret;
> -		}
> +	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
> +		/* Someone is already using the tracer */
> +		return -EBUSY;
>   	}
>   
> -	raw_spin_lock(&drvdata->spinlock);
> -
> -	drvdata->trcid = path->trace_id;
> -
> -	/* Tracer will never be paused in sysfs mode */
> -	drvdata->paused = false;
> -
>   	/*
>   	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
>   	 * ensures that register writes occur when cpu is powered.
>   	 */
>   	arg.drvdata = drvdata;
>   	arg.path = path;
> +
> +	scoped_guard(raw_spinlock, &drvdata->spinlock) {
> +		drvdata->curr_config = drvdata->config;
> +	}
> +
>   	ret = smp_call_function_single(drvdata->cpu,
>   				       etm4_enable_sysfs_smp_call, &arg, 1);
>   	if (!ret)
>   		ret = arg.rc;
> -	if (!ret)
> -		drvdata->sticky_enable = true;
> -
> -	if (ret)
> +	if (!ret) {
> +		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
> +	} else {
>   		etm4_release_trace_id(drvdata);
> +		/* The tracer didn't start */
> +		coresight_set_mode(csdev, CS_MODE_DISABLED);
> +	}
>   
> -	raw_spin_unlock(&drvdata->spinlock);
> -
> -	if (!ret)
> -		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
>   	return ret;
>   }
>   
> @@ -1044,7 +1051,7 @@ static void etm4_disable_trace_unit(struct etmv4_drvdata *drvdata)
>   static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
>   {
>   	u32 control;
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->curr_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   	struct csdev_access *csa = &csdev->access;
>   	int i;
> @@ -1090,8 +1097,9 @@ static void etm4_disable_sysfs_smp_call(void *info)
>   
>   	etm4_disable_hw(drvdata);
>   
> +	cscfg_csdev_disable_active_config(drvdata->csdev);
> +
>   	drvdata->csdev->path = NULL;
> -	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
>   }
>   
>   static int etm4_disable_perf(struct coresight_device *csdev,
> @@ -1134,8 +1142,9 @@ static int etm4_disable_perf(struct coresight_device *csdev,
>   static void etm4_disable_sysfs(struct coresight_device *csdev)
>   {
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	raw_spin_lock(&drvdata->spinlock);
> +	struct etmv4_config *config = &drvdata->config;
> +	const struct etmv4_config *curr_config = &drvdata->curr_config;
> +	int i;
>   
>   	/*
>   	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
> @@ -1144,9 +1153,19 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
>   	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
>   				 drvdata, 1);
>   
> -	raw_spin_unlock(&drvdata->spinlock);
> +	/*
> +	 * Userspace may read ss_status and cntr_val through sysfs after
> +	 * the sysfs-session has been disabled.
> +	 */
> +	for (i = 0; i < drvdata->nr_ss_cmp; i++)
> +		config->ss_status[i] = curr_config->ss_status[i];
>   
> -	cscfg_csdev_disable_active_config(csdev);
> +	for (i = 0; i < drvdata->nr_cntr; i++)
> +		config->cntr_val[i] = curr_config->cntr_val[i];
> +
> +	config->seq_state = curr_config->seq_state;
> +
> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
>   
>   	/*
>   	 * we only release trace IDs when resetting sysfs.
> @@ -1694,7 +1713,7 @@ static void etm4_set_default(struct etmv4_config *config)
>   static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
>   {
>   	int nr_comparator, index = 0;
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->curr_config;
>   
>   	/*
>   	 * nr_addr_cmp holds the number of comparator _pair_, so time 2
> @@ -1735,7 +1754,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   {
>   	int i, comparator, ret = 0;
>   	u64 address;
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->curr_config;
>   	struct etm_filters *filters = event->hw.addr_filters;
>   
>   	if (!filters)
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index a547de5a3f9c..9c237507ac30 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1437,7 +1437,8 @@ static ssize_t seq_state_store(struct device *dev,
>   		return -EINVAL;
>   	if (val >= drvdata->nrseqstate)
>   		return -EINVAL;
> -	if (IS_ERR_OR_NULL(drvdata) || coresight_get_mode(drvdata->csdev))
> +	if (IS_ERR_OR_NULL(drvdata) ||
> +	    coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
>   		return -EBUSY;
>   
>   	config->seq_state = val;
> @@ -1616,7 +1617,7 @@ static ssize_t cntr_val_store(struct device *dev,
>   	if (val > ETM_CNTR_MAX_VAL)
>   		return -EINVAL;
>   	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> -	    coresight_get_mode(drvdata->csdev))
> +	    coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
>   		return -EBUSY;
>   
>   	raw_spin_lock(&drvdata->spinlock);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index df9e0748d71e..52f66e26ceaa 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -1019,7 +1019,8 @@ struct etmv4_save_state {
>    *		allows tracing at all ELs. We don't want to compute this
>    *		at runtime, due to the additional setting of TRFCR_CX when
>    *		in EL2. Otherwise, 0.
> - * @config:	structure holding configuration parameters.
> + * @curr_config:	structure holding current applied configuration.
> + * @config:	structure holding sysfs mode configuration.
>    * @save_state:	State to be preserved across power loss
>    * @skip_power_up: Indicates if an implementation can skip powering up
>    *		   the trace unit.
> @@ -1077,6 +1078,7 @@ struct etmv4_drvdata {
>   	bool				skip_power_up : 1;
>   	bool				paused : 1;
>   	u64				trfcr;
> +	struct etmv4_config		curr_config;
>   	struct etmv4_config		config;
>   	struct etmv4_save_state		*save_state;
>   	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
> 

