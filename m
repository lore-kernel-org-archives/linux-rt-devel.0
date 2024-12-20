Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D71BEF6C
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689621; cv=fail; b=U3Dxm0Mc69R7esOkyQSg+VNIKozBYfwwRe5HtI62m3sU5bcX9k8Aa5xvDV7rDCNLJyZ9i3hSxYMpzKJvJb8BBtZRWiJLPiR0KTO4D/Ki82QndNB+zXmVFl9Ct41RKt4+Zzp0920rRT31wK2VthAiqhclelxl0X9gLk3xyW2RNyw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689621; c=relaxed/simple;
	bh=RSWYPNI8z8Wy/gygN5TGWX01DOu/Sx05nsOEulmnEKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KdQo+UfalRqzZvgehIVXHU6oafgv14iPponxIGkvoHQrETuKH8D4Hq8g5P3d3goAm3V5HDMM5ABuXJe6aZ/KJ4ChkDR7rWAcnkFs2MiNSTMzo5sGAz+Y2/tNLK5B6RBFAYzA9aLN5nsWXjEDbcIDv59BdMZ2pw7Ie4bqExyWY+A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hKh0arBd; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hKh0arBd; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hKh0arBd";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hKh0arBd"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QworDDHkY072AZUxcivdqJAB0HBUlYtElmQ9ZJrdTmenlctNGTIhCr9ENE+KTErg2po5T0tTIpiNSb/zal/CSFOzQrlsAJI7EKQw2eUNNCN2e8MzIcZJS9LHtLktpd4UOhafoLjlEBnwyxKZO9oVkqlCgOY6wKYHunHmE5hMkn5VLWBmTxgXSWKaCCkro+S5h2MFoWK8WOD/Wu56zS1ECSIa6Gf91EhQy1DBukx8B+QeQUItstnEXZdfEQ/XtP/qD2q81g9v/njdjScQWsjBEbRXYlZQ9yel9inWhX0MypxHr0dKXDq301unC9/MPcP5uPyG78BkM+Y6+l2X+EHZGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpG26aKeKvBOHjm21QagtL3uNtREt1b3l05PWBCPkv4=;
 b=Hvw+DrDitTTbRBa7dv3/Hf37j+YACkFQLxgRhT0hfKhjzuGiAL44svJGG/9R3VgHvLRdtoSM7FtLortHb/QSdN4LGLWzX7kwnbXpKpQWLOKgr13X+F5RDz9pTpSUOUSlvqC0hqSlNOXmJrYPruD8VBJ7iH3n9re4gLItAIzewERANkpUDHTUOFqcGPZEg/N+cVMD+7J4CT2oSXEVjeE8uQZKwJwkwXE+mihRsVAYMO4ePQ6vbydm/McP68p2b8kfzAhefT9a0Tm7ovMiejw8YV8GYz5Wjcu83GGYojGmyeVkSBEa/HUtUFTse8iNSSYNYSU7HAZCp8zlSQXsswdRPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpG26aKeKvBOHjm21QagtL3uNtREt1b3l05PWBCPkv4=;
 b=hKh0arBdzqYmpCOCDCwwzwdjc1Adr3jEnvghFr4FAiqoZY/xIRpds7aTlkLgJVSipiJu+vm53iitdDmmhtIo7pHEMooYPwp0JsgtK7BD+e1Ulc7476z8PnMXT2rh7fw3ahlAJWrVoV+KP7f7gEOBjymjq1LtH/Sw2Iu7hvaaes8=
Received: from DB9PR02CA0025.eurprd02.prod.outlook.com (2603:10a6:10:1d9::30)
 by DU5PR08MB10398.eurprd08.prod.outlook.com (2603:10a6:10:51f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 10:13:33 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::39) by DB9PR02CA0025.outlook.office365.com
 (2603:10a6:10:1d9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Fri,
 20 Dec 2024 10:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 10:13:33 +0000
Received: ("Tessian outbound 42d62cca2da1:v528"); Fri, 20 Dec 2024 10:13:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ca2666e53f2d8fa7
X-TessianGatewayMetadata: tcUtm5MEj3rPH+fi296pD1Qeq9vf+Kmnxw8IFll4Xq3o4+pftjzHfsVpy30vAEkzjEgjg7MDPAvq7EGcwtbqaT3RvVEnAgsjMA59GCgSaYrCHdPIZCTkuu5dJABvjhljxIhUzKHooGoy5JEkruPKyw==
X-CR-MTA-TID: 64aa7808
Received: from Le92edc3f682e.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id E883FF8A-6669-4085-B03D-1DE80EFC0D06.1;
	Fri, 20 Dec 2024 10:13:22 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le92edc3f682e.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 20 Dec 2024 10:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhClF1IDXMYY2rEpuaeVt3Wl1jmb2udSS/HOQgFOSKh1dC4U+P1kb4jmbsJSqk2c4NPODpemKawc5oFQNem7Rj//7NlMAXIAkdMYECx9hAc72ZoB9l93guUv3EMIhrRgrMPf66U4B+1U9l9t7jPW1AprmSzyILxxL1QubokZh28/U7zd1ZDhUNIAURIQZmkoAXpG3qp86keoKbqXhNoZd0vingi7jfmGmHTAuhtrD7I9Vf++BnxjUL1kKIQ/nxrF0Btcd0yoL1NjVSKuEOmYgz1c+gdhbtUIqc5hxGAVWgfKRt8Cf7JBUbyq0D4ZmmDj+vz9uCBwUrKDuc+/dfzwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpG26aKeKvBOHjm21QagtL3uNtREt1b3l05PWBCPkv4=;
 b=n5sbISwsCUKSTTFkk+lbRVbV2ghupI3t5eRT0qZwoSWvocVGcTKvK7HecUvWVpMi7yfiCEE2XbkB4IimJRxbeVL1OUba/UkSV/HdSwFie9hB1jtIPuTZVearkjyV3nHI9RyVXv+plD3o/pqU7q8+ZYlfn47N+5t6jdK+GqtvKkwZzpaMyA+aOeRcMMMPtsApqRDpQ19uaPWuaIc+y7nY2EAjYWApDoNIi66BK4Q4cbEzHPJ8OEHYax0XQ5LH2D7qNRSHkJlXNczp978gJcueKOTqi5JfkS9Mj5bHMiEW833JRSU/TZOa8DT0L2Pu9+hTstz50xygwPxYEJ8GhKO07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpG26aKeKvBOHjm21QagtL3uNtREt1b3l05PWBCPkv4=;
 b=hKh0arBdzqYmpCOCDCwwzwdjc1Adr3jEnvghFr4FAiqoZY/xIRpds7aTlkLgJVSipiJu+vm53iitdDmmhtIo7pHEMooYPwp0JsgtK7BD+e1Ulc7476z8PnMXT2rh7fw3ahlAJWrVoV+KP7f7gEOBjymjq1LtH/Sw2Iu7hvaaes8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI0PR08MB10681.eurprd08.prod.outlook.com
 (2603:10a6:800:204::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 10:13:19 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 10:13:19 +0000
Date: Fri, 20 Dec 2024 10:13:17 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mike Leach <mike.leach@linaro.org>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 2/9] coresight-etm4x: change etmv4_drvdata spinlock
 type to raw_spinlock_t
Message-ID: <Z2VDPQMUH61THA8r@e129823.arm.com>
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
 <20241216115006.415861-3-yeoreum.yun@arm.com>
 <CAJ9a7Vj6_ek9D-ZySt6dNAGWwWV=7yX36T=n7+n-Nak=UEhMdw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vj6_ek9D-ZySt6dNAGWwWV=7yX36T=n7+n-Nak=UEhMdw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0214.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::21) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|VI0PR08MB10681:EE_|DB1PEPF000509F4:EE_|DU5PR08MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: 30445886-3fcf-40fe-2504-08dd20def5b2
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?cTBNdc4KTdnowUyQEHxtOo5wytOJjuacGGwvggV73ysUNmnmLNaRltSxuEKX?=
 =?us-ascii?Q?t6KjzRwAeGyHqd5HZCcS0Y/aMjmpXsDbuVIyv4Cb1hv/roVNF3MLXx4/+WqK?=
 =?us-ascii?Q?ksIY5SWuLpi0LNdMQOppL+mllvcDCBfsaKDzh3lBKsVLKeqd3E+0Tq2HircE?=
 =?us-ascii?Q?qBfR4LlcTdMooj9JCczVTUOsYCeD2oQ8yicMsD2F2nn6EPg1gvomJ+XHNGVP?=
 =?us-ascii?Q?8s9AWQPPTX8fm34jptGnMNzdtMJZEFrm4r9ldDOrBN9SCbin1qVhokKXcop+?=
 =?us-ascii?Q?IpsrKLT+GI2PIo63P7RK/sLj9icr2U5Wc1aI6HBRKCttHOnJ66V0kcO8+xXg?=
 =?us-ascii?Q?2oth2lWLz847VkPTAxXVt8v+jjL6WNiIFZZKNaFSbyVepN2TatnMW9P8sChI?=
 =?us-ascii?Q?rrNBDmWe6/8MJnTvOpjSiUNVs9fw50DFDzwTaDTyL+IkocqoNd+rORtlLrQu?=
 =?us-ascii?Q?BOe9bOv8KtMzxt5s+3tZBCrJ79PgVz0KVZfM1ZlL1B4hMIHH/Dn36o26OmH7?=
 =?us-ascii?Q?ELbkg5t+/RQIP4qF8KuTXPokwIUM9Gr15tfHJEl8wSpFhl5UT+lq5SbDXzva?=
 =?us-ascii?Q?wZK6eHSdiMj5t+ooGVJI3Dxbp5ccenxcmOzWbZ3SMAeOYjbOovKTWk6YelYq?=
 =?us-ascii?Q?SwnnSIN0gXZLIZgUavZDKy1RIUGVnwYhzphKsGtZubeExD8qiD03yP/k2gZH?=
 =?us-ascii?Q?SgaUeCS0PY/w+Xme8TkeOfRzG0yYqLiczHmjB9SX3dTtbTVD8baz7J9D7JIk?=
 =?us-ascii?Q?4ltz6F9OrKjoohTNIoZpAyfA4wMRZrZDVHKUEu7trqrP/Gte5AIvSPVDG3bl?=
 =?us-ascii?Q?C7JCD7x9Vv8HPiZurZ0rKgTL/aRSUvAES63hsUboFhxBPi4syFm15wteamTi?=
 =?us-ascii?Q?mmowEI8OvX+4UcSACh31nCdx61uxavt7HoqBRHGfpE3+jGcAgGe1usc02EOr?=
 =?us-ascii?Q?tJKspaaX2wG4c7CKVmYSFZY90BAF1fBiiDFzsaBjNzybWVT4ONAtBMoCKhdP?=
 =?us-ascii?Q?buu2HStp/wNBhdhSnpFgxoSimd2XSj89x1FeutvJB/tXgiYab58Sj3vARlew?=
 =?us-ascii?Q?agWvHSw2sgHDj/BkgXSaZ7bfjw/h2YSyRp0cAB7GbMKbqOPmQEbLFPYo4FNJ?=
 =?us-ascii?Q?MukIfNXY/CR8Ju8nC1O3+siMX0VOOfGJxW7svyfUc29F3QQTzUIeFmTjcGSY?=
 =?us-ascii?Q?nED2p37T7whydcPOPpq6SktxcXQsSvXqvuXZXDl39VVzgCFM7IWhQKkw+cai?=
 =?us-ascii?Q?l8m+U8g8dmnCIeySWnmy1HEx6IYLC535t14fy2fcYKbRP1/mS9tk9A6vKvar?=
 =?us-ascii?Q?lDG2n73Fj7xhvvWDMRJstEDWTKAsI3X2Q8uKIVIwWO1ga+XsDyx8BIRW8srQ?=
 =?us-ascii?Q?jWMFHjns8oH6RyUxZ+bSq0RdEsjT?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10681
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	56344e1a-8338-4a39-ddf9-08dd20deed52
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|376014|36860700013|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A7OSLNMD2+JciSr3kv822AHLn+NY7seQwhSQXjczDJX5qV940Qg+jILLJ3zn?=
 =?us-ascii?Q?9f7FYDI4YymCL4g8a4U7aENQYLe/v0aAH4fR15l/Rq9NUjq9034WQDYUjF45?=
 =?us-ascii?Q?h0cI32x+QKU2UAUv35SxeED6F0iebmqCe55B0gFgCJHYby1/8hAIRSLE+5/h?=
 =?us-ascii?Q?sLz+ecMogtHti7+3MexXOVXccd6rwT9M+RXRrJiTDewlLIDzuwr20o3GZG0I?=
 =?us-ascii?Q?oCDM+CRcMCRYpFmPclcWp88eEqIDKUtT4F+ma278GAeZFcd+4QlbUfPz+qOm?=
 =?us-ascii?Q?Gq8SHOdS/DRirlNUNHQmwTDygHDbPU2zA+r3rlZdAquFGsPyFmOJ0NnfmLPN?=
 =?us-ascii?Q?mujYawX5z/AIms4UsTdcSyt527P8B/LGluKVAzv0VM19LXBMjUZs6Ugk8U7L?=
 =?us-ascii?Q?axklrMQDbh2qtUIx/KXI0NsGi00sKrDf/7V0HfI4Ua+rj5xwSZ7J1RoaWQLI?=
 =?us-ascii?Q?6I40CXhaBq7MUae0jIFqVzAyQRgZlb0MeN69DAJgzbP1BcCE/567CgIqHg9p?=
 =?us-ascii?Q?HhOR5EtjL11IQYr3J4bo2qOLeqZAsbcEHt2icVcwT7QfFjtFYbGgvKzXpcp4?=
 =?us-ascii?Q?hjk1pGaPk7UkrwH5W36l1yujoWPNX27lU2ngeA1gUMeetLgguFNl5Z1AgLKw?=
 =?us-ascii?Q?WE4WJWiIwQmG0XRFxT9jpNoQL8YOnoHQmhySxIdNNOhqjdV7uKazpwO1zZaS?=
 =?us-ascii?Q?sUru+7YThmB+X7VXK94u5o6MRCec3TKrsJnsNiu87POf4Vfle4VtvCTL9TmM?=
 =?us-ascii?Q?CLjMza6Wm63HTYsqw25KM9tDx6vyMkzrwv7tA5K+27kC/QJXpk0Prlr01Tn7?=
 =?us-ascii?Q?5zHIuQQ26nT8QAPocGMov1CEjj6pBPhHWpeNxN2gVhr/ZYNMn3RcTplLnYWH?=
 =?us-ascii?Q?Dzp3tz/lewDZ1tTb6I0vDj00oPlVSHsI/VXY1VTRImWQsEXWFpsOej/47Wlm?=
 =?us-ascii?Q?hL1QP42wY3rm7UjKSHjIYFps0e9jWW6i2e2H0VeRd0hdzbS8Ibsmo2XNA3bL?=
 =?us-ascii?Q?sjpSQ14e6faAEfsLDNH9cCJUXve3Xn7BT6nr1ytvSpcNuKFzYygixE0gh6Su?=
 =?us-ascii?Q?PgFWLkzCw02cTfWvEnfH7Lw4RpINgBdlSOFVamwEbm7ntyAkekmgrK1553zz?=
 =?us-ascii?Q?allKTOOG/XQo9+NL6mdH7YuVEjDdcixp0AOqxrQQTCM5O1eBgMkQ4jHsi9NI?=
 =?us-ascii?Q?I9yKTvj627NiVIu8mX2+pZIzBHHva+HeVAxBAsXJifgtRh38JdHMgTsB1q8q?=
 =?us-ascii?Q?W6TVsm8RhWBigq/I6/yVVH2kYfa2trfpaNqKlUQc9aJ7ypSkmTcFbjEIzP1Z?=
 =?us-ascii?Q?eBQk7pKKZjf2qUE8V9p+Q4Pky7bAnH81u6KjYgkkNtqy7Mlvo0J28iHU8R56?=
 =?us-ascii?Q?FEFzoIZfvoinJRgPUX9fxsCG5/Rf4rY2DuwL7VR+6G3oVFkEHlhF/9POOF1T?=
 =?us-ascii?Q?G0pvj6uO/weDp1wOOpAEHh4l+/aAMXootg+jtHIur+68Evqcv6SpAz25SHz2?=
 =?us-ascii?Q?clz+TWbTiLn0Di4=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(376014)(36860700013)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 10:13:33.1212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30445886-3fcf-40fe-2504-08dd20def5b2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10398

Hi Mike.
> > diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> > index 6ba013975741..b9ebc9fcfb7f 100644
> > --- a/drivers/hwtracing/coresight/coresight-config.h
> > +++ b/drivers/hwtracing/coresight/coresight-config.h
> > @@ -206,7 +206,7 @@ struct cscfg_feature_csdev {
> >         const struct cscfg_feature_desc *feat_desc;
> >         struct coresight_device *csdev;
> >         struct list_head node;
> > -       spinlock_t *drv_spinlock;
> > +       raw_spinlock_t *drv_spinlock;
> >         int nr_params;
> >         struct cscfg_parameter_csdev *params_csdev;
> >         int nr_regs;
>
> The above changes are not etm4x specific - should be in the previous patch.

Yes, However when this changes, etm4x should be changed at the same time
because of build failures.

That's why I modified this with etm4x where currenly cscfg is used only.

Thanks
