Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E031A38F9
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739399; cv=fail; b=X9jBNgSDbbLGhMF0rinM+Dd02W/SKtAx88LiKaB/Q9wbbwvrCH+Yu6lgItvi8ftHaFkml0nJ/BUAZG0o7zaoT/OP6sKKLZnqdNuQN02SDLDeIMUPHHByrWp5/TKJMdSO4K1HO151IP8Yh+NryktYzEj2g9tu+iZ/+xoQ0TVWffE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739399; c=relaxed/simple;
	bh=tSCgUJ3kKmXTy320uPuKEbqOfSUTiorqIsYp2PGTBVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IOdinKPrgJwHdCNNM6aQDh+YieG9D6SjP6m/e4hmAbHTYQAQZ2WJZPi9eFWjKbgd0XywCIMrwDvC1WUZV6R60xbNufiMJt1vkTa4tohcnHFqVZFTa6f5HT2BwvfZkgKTNY2mgNul3BgpoyPPfQDU0h5mE4l7mMeQ0OvIzF+6eTk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=B+bN4jIJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=B+bN4jIJ; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="B+bN4jIJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="B+bN4jIJ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vlL/6qFQciiyrcZ1DCxuGiD99f52TjDf+ezAnmIKhV1TZ2iGz2sC8mubYjbHgcn54wxCptfQwnog4KqSVqdifbQKFjXd0fqyP27LAmE6ogCrjuAcV7iqwc58fvQn37l02hl77b2LsECoNn+fQNPFpndA/HBuYqhPA2QDrBTE5wXXLMfcKCsoEYGYOkGR39hQEWCw5GY7o+ogGxU3t1Z/FgUjr2uOVuExVBRU44EnMdfgVt0JOPtfBa/V/fkLEapd1cvAyGy+a/jgFQumIQY5q7M26rNO2RvBpziNbSge1yrHcVAeMrUarn7p9HHsv9iG0dE/tq1/rP1OHEnJVaSzZA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcWnwec7uqVkMYjRHidWykuidcVNylxvNN1HBPlUU4E=;
 b=OARknrNwGeeZGL85pVuCXmSuooxccb2qUhkVE2Eq8n4WgdvP70lns/lY1J0fBZ0lArtJt0vfJuUqOt+/rEBn4S/w+uerLMev30Sde94uG0t5DzddefO0ETxFENfFfWgLdk7JdORgRDys8YrAWy4yAtpJv1p6+c4DQBW7laFcCF7Uub+PcJKLmw3c/D0PgDvHwdNVRn3G+3tPWd0hR9m1C/xI1iPJ3rAy4TuwFCP8L9/l0P+Fw2nAqBzZtzUOQBcH+5OrHlKRzKA+9WwG4mcIKsIygANUiw76bFh0VhTS/yxusHHwt57QRMqhRY1U6Fp2IZyNmkgI+wSZnZNWF7xIqw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcWnwec7uqVkMYjRHidWykuidcVNylxvNN1HBPlUU4E=;
 b=B+bN4jIJzX8ozIhkmPK11mf4xTry/KGYDFjNw8HvRC2uWt76OidbEpW0diTXpNU3Njbf/pA7ODytGk9llDPQze6lzAspZTnJf2Yvhi+W6X9cNE/5j4lzge6m+MPSOYONEQP17awQG5pSk0fa7wYM/U0Hn6GEK+qRxu6GNVZuOcU=
Received: from AS9PR06CA0715.eurprd06.prod.outlook.com (2603:10a6:20b:49f::34)
 by DB9PR08MB9540.eurprd08.prod.outlook.com (2603:10a6:10:451::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:49:44 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:20b:49f:cafe::2e) by AS9PR06CA0715.outlook.office365.com
 (2603:10a6:20b:49f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 13:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 13:49:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3fEo7vhaU0vnNxbySWE+6kyYwPezMQnllqeY7wzfajA2xm66l6OnS75cH8LSPhR6Pg/l3BxQzx+/7Rv+Iq6IV2FQs2LFZ2WV2yRmKf7bO+1BKL6k9k9pc4A7u/3afJ3laGUOqvIoyi9Be1OvdYukTbiMExtkQKnkUtePd1tuZUQTaSKoVIHuRQgJ/KVd26ZWtoRuAIyM1w2tS0bTZFlcN0vykhqxorNdMYzo4aZ7dB3+vkAKQ567GXDVyodDXik0/KD0/U4iD0ba0N7IiWxXt0hRyf0Z/GFFerFu0c9L/lctw2thmIKBYyOWPdi8TeNPzPV6H8gM5lwxmPtfwM87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcWnwec7uqVkMYjRHidWykuidcVNylxvNN1HBPlUU4E=;
 b=uEw1mQp1SCWpQsS/UHz3s/KhP5X5DOWL4oaRyv7IBcP6t4xR/+l67XHzYCl15YrOKWwVKDAKSGrknjuvNOKmAnRZLPnldO5ltFdTH3WBtBYSNaeuCQOx00xAedobz/kt84UEQ1iApb3YK1D3X7JB3KGyDjaSnwCE3rsSw7scC8uJEkvSDVrSJvbSgfGI7cEVEsZTyuGawP+FPMid+OTGqDENsbiQJ59302edn8EZzsIqmRs8PRoIX9B6o76GQjfYFnZyuFG8XAh0EOrz6eGm8uG3sz9OyJ3UTblTqGDjxHu/7oOtdlpCwsNgwYS65bltmSG5d4EBPz6Jp7/W0RXWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcWnwec7uqVkMYjRHidWykuidcVNylxvNN1HBPlUU4E=;
 b=B+bN4jIJzX8ozIhkmPK11mf4xTry/KGYDFjNw8HvRC2uWt76OidbEpW0diTXpNU3Njbf/pA7ODytGk9llDPQze6lzAspZTnJf2Yvhi+W6X9cNE/5j4lzge6m+MPSOYONEQP17awQG5pSk0fa7wYM/U0Hn6GEK+qRxu6GNVZuOcU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DBBPR08MB10793.eurprd08.prod.outlook.com (2603:10a6:10:53d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:49:11 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 13:49:10 +0000
Message-ID: <bf0dea40-8dd1-4108-a3de-28288a31a668@arm.com>
Date: Fri, 18 Sep 2026 14:49:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/9] coresight: etm4x: fix inconsistencies with sysfs
 configuration
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
 <20260915-separate_etm_cfg_v2-v11-3-d2b258d51747@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-3-d2b258d51747@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::29) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DBBPR08MB10793:EE_|CPH1EPF00000520:EE_|DB9PR08MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: df8cc95e-d6f8-4cc0-e143-08df158bb19d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|6133799003|3023799007|18002099003|22082099003|10067099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 mCyB5nraCeDkXI6PUiT+ZV6KGNUJTZfrjEAjaFZv2F76tsD7HIJ7y5z/VWn6cjDg0SL7Ap9cfIm2u9i19Jjg+5kp2kE+DIWLV3hjZZmcZAETpcIgv7gUgZwmkSNs27TI3gO1upTr9EOpycNTY1kT+sNqtBBwbAJaJO3TUPjPuA3ZDa/an91w3vmnjmuIEsrAP3MIKqQdTrrX3ue1WrSzXGbBbBLjTMU081fepPb0SSeV2d3cr3FYYlesF8vZuRvVX7oFnlYf42MvgyalZEV8ELXXyef1Z53tQ8+loy1AcT0Sd5yzi45SybPCqYEsRrqdgmoyCvn3Ov3U9kiXEiPAmBCzpOmx8FEVzGMAu2xqOQ+fUISfGZT451cLMRhGiHzyAXANtN6p79LQJH8g1znstm5hfQTpM1TbBBtZ+rm7lDWbT61cHr6RlhW9B2Nag2KKVRz1ACxFaBa+rHza9R8/kXP+AbXcMQA0Ang2Ss537Zsxjb9A3TYfW4Vfj5biLGuqtGscP27pRdi6lDQjz7tt5asXARZmDMCHrX+PCXjtVsPcOIW3xBXm9Py6HYc9Sr/PjbdDyOO1dcu6aXjFlJR7wytvqfGjFXa6Q/+EytlG9Pql07SmP0Qw7SIhpNKLrqaxXlFjZuOIxd+wNmQNsc99Eki0OgRaTzNV6T5TCE2jfgk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(6133799003)(3023799007)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 hpWVFznBn8wIAE6asfMh3WvT4VPVKxp0kIovhsZKKMFcsNEGG4HZiGAj1KiSRTlWJmiROTClT1Vrh8bfxND2T3WbWXB1oxXLkEPasMr/2bBCBKEEWpxwTozKmCS/77/wcZXh5oR0zrQxfGSvxHyUxGbdopqeR0ah7tljfKbRWOT6ygicQY4G4GVHYhUbNFSSnkMG0JmNvj7UG/xJJP3yMKqNIEl/ZHmn93i7/h1om/vfJVvNreKEHVk6bXhcdegsjad3g5QsJQgkzHv1f0p28aetxEOjBZ3TdYwsqg2ZILQh+3sc2CrAPWSMwYAPe7B9i9HviKgY/I5yhRVdW0k7+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10793
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8c299f7e-9988-4a10-8502-08df158b9dda
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|23010399003|376014|7416014|14060799003|82310400026|36860700016|1800799024|3023799007|6133799003|4143699003|11063799006|5023799004|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	aJW6tTahf5H4LTo5lZSnk2L7QJH7qC4ToeAXOtsfSdpVVMX/NloHdXMlXawqdu4QWQO9AW78Siw6uE3glAhI0WFpnO1whFl7mNN5tUsB6Ua6VzhfEUAmqHkOY9Rr4Kvh4CGqTPhBXNcrvqV+S0CJxRmAwrR+/4frIsuVAL9EUWGFRYdvMnBIBWfvgSE1NMfkq+nR0G+sR98zC1ta9LyYJOW1KWaQFfmfzxAORma87U4S3OBWmhM6HE8kH1DwKzvEq18vLy2tiNZAOrUFya9mJQlu381NknDAQwle4x+Z5nMoQVj/t8jjRw0V82q6r0iG1SsrnTe+oY83xwAv5Tuxz+OcIw/zrmOuz/2Q4R5Ki3SHuUgzokNBizAuaPgaXFcO49xmoLk+eYLeOOnGTqzpueKflDQV9ypG9MdsmXsSM7q1PmmljQ2lhzPLks9tkV3a3T0FmRfW+0qATzfhsKTCpOaVcMuMybOsyJVZOvR1G+xGuLOHoBqlkDACx5JtYHY+pC+w0pEkBBbyYeJDFVdVtGKjJfrAp0dsvMoaI0tvEYlN91ep4NJeRRxHbCyoa9Gmu2c5iRcN3/0SEAYJ6PNAUchrTSnaw95S0aLD9ZtsfN8ix2amMUI9/6rRynYjz16lhgxNN+jK34FKg4TMPiBGqBSB36azLbW2dymBIxPlRj0Iw0b++YqvS6WysdLTl+j4QJ/TFApv+aw+pqZQqTTa8A==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(23010399003)(376014)(7416014)(14060799003)(82310400026)(36860700016)(1800799024)(3023799007)(6133799003)(4143699003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SrOTOHGNnHUlFHV5m0tj0QpOX+YM/1B77Ee0tmEIpoyHsuHf/7USYud4mjX7+VYtEIU5BeJWkxmcAtk4YuN64famiGFpjDqGRZAswHwpU6ysbBIZzTc3oZx5bp6Wh4z55DQA68bsKBpJ0HiBSdUpu+k4PhbkzOWXvFyPAHILV2yfmK905KbSAB6z1TOHS0nrRgxuiY5EwrUO1GOFLY/NKbSBhP4A4KpAQ/1NJM0NFbQzQ/9etSgVUW/DndbeE0uf3b9gVvKRQWMjarx0SRHdJgnndBQkHroWFZMwEVIbEp5EN31MpUWf6wdqkSi0qMjEoSfW9yeHtM959K2vA43Rxg3nbjADfWrdvCINTiMfDkWKgnv6ItCwRci2ZSxyrSvau/HLtARkns6YnUAHYoEbPWoAednT4awMazLJB8hoMLFdd0BxU3jbU91fal3rkjum
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:49:43.2608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8cc95e-d6f8-4cc0-e143-08df158bb19d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9540

Hi,

On 9/15/26 12:34, Yeoreum Yun wrote:
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
>    - active_config: the configuration applied to the current session
>    - config: the configuration set via sysfs
> 

I'll add a comment about naming here - active_config is a bit overloaded 
in the code as it is also used by the csconfig code to represent a 
loaded and active configuration - which may at some point be applied to 
the active_config above.

If active_config is for the current session then curr_config would work.

Additionally config also appears as a local pointer in many of the 
functions. If this is the sysfs config then sysfs_config would work better.

This should make all the code a lot more readable, and easier to spot 
exactly which config we are dealing with.



> Additionally:
> 
>    - Apply the configuration from configfs after taking the appropriate mode.
> 
>    - Since active_config and related fields are accessed only by the local CPU
>      in etm4_enable/disable_sysfs_smp_call() (similar to perf enable/disable),
>      remove the lock/unlock from the sysfs enable/disable path and
>      startup/dying_cpu except when to access config fields.
> 
> As the active_config is used for cfg-configfs, etmv4 doesn't need to set
> its lock for the cfg-configfs since the active_config is proceted by cs_mode
> otherwise it would make a possible cpu-stall when it get interrupt while
> setting the sysfs configuration.
> 
> Therefore, set the drv_spinlock for cfg-configfs as NULL and
> let the cfg-configfs disable irq without grap drv_spinlock when it is NULL.
> 
> Fixes: 54ff892b76c6 ("coresight: etm4x: splitting struct etmv4_drvdata")
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-config.c     |  18 ++--
>   drivers/hwtracing/coresight/coresight-config.h     |  22 ++++
>   drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |  13 ++-
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 118 ++++++++++++---------
>   .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   6 +-
>   drivers/hwtracing/coresight/coresight-etm4x.h      |   4 +-
>   6 files changed, 113 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.c b/drivers/hwtracing/coresight/coresight-config.c
> index 4f72ae71b696e..0e296289f286d 100644
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
> index 90fd937d3bd83..ae6295e308131 100644
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
> index e1a59b4345052..d24f533c623d0 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> @@ -47,7 +47,7 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
>   				   struct cscfg_regval_csdev *reg_csdev, u32 offset)
>   {
>   	int err = -EINVAL, idx;
> -	struct etmv4_config *drvcfg = &drvdata->config;
> +	struct etmv4_config *drvcfg = &drvdata->active_config;
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
> +	 * drvdata structure of etm4 for configfs is active_config and
> +	 * this active_config is protected with csdev->mode by restricting
> +	 * access to active_config after mode changed to PERF or SYSFS.
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
> index 2247ad55d4442..2df7f592bb5cf 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -239,6 +239,7 @@ void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
>   struct etm4_enable_arg {
>   	struct etmv4_drvdata *drvdata;
>   	struct coresight_path *path;
> +	struct etmv4_config config;

drvdata contains both active_config and config - why the extra copy here?

>   	int rc;
>   };
>   
> @@ -264,10 +265,11 @@ static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
>   static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
>   {
>   	u64 trfcr = drvdata->trfcr;
> +	struct etmv4_config *config = &drvdata->active_config;
>   
> -	if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
> +	if (config->mode & ETM_MODE_EXCL_KERN)
>   		trfcr &= ~TRFCR_EL1_ExTRE;
> -	if (drvdata->config.mode & ETM_MODE_EXCL_USER)
> +	if (config->mode & ETM_MODE_EXCL_USER)
>   		trfcr &= ~TRFCR_EL1_E0TRE;
>   
>   	return trfcr;
> @@ -275,7 +277,7 @@ static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
>   
>   /*
>    * etm4x_allow_trace - Allow CPU tracing in the respective ELs,
> - * as configured by the drvdata->config.mode for the current
> + * as configured by the drvdata->active_config.mode for the current
>    * session. Even though we have TRCVICTLR bits to filter the
>    * trace in the ELs, it doesn't prevent the ETM from generating
>    * a packet (e.g, TraceInfo) that might contain the addresses from
> @@ -286,12 +288,13 @@ static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
>   static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
>   {
>   	u64 trfcr, guest_trfcr;
> +	struct etmv4_config *config = &drvdata->active_config;
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
> @@ -299,7 +302,7 @@ static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
>   	write_trfcr(trfcr);
>   
>   	/* Set filters for guests and pass to KVM */
> -	if (drvdata->config.mode & ETM_MODE_EXCL_GUEST)
> +	if (config->mode & ETM_MODE_EXCL_GUEST)
>   		guest_trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
>   	else
>   		guest_trfcr = etm4x_get_kern_user_filter(drvdata);
> @@ -492,7 +495,7 @@ static int etm4_enable_trace_unit(struct etmv4_drvdata *drvdata)
>   static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   {
>   	int i, rc;
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->active_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   	struct device *etm_dev = &csdev->dev;
>   	struct csdev_access *csa = &csdev->access;
> @@ -612,27 +615,44 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
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
> +	drvdata->active_config = arg->config;

This can happen before the smp call removing the need for arg->config?

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
>   
> -	/* The tracer didn't start */
> +	/* Tracer will never be paused in sysfs mode */
> +	drvdata->paused = false;
> +
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
> @@ -669,7 +689,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
>   {
>   	int ctridx;
>   	int rselector;
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->active_config;
>   
>   	/* No point in trying if we don't have at least one counter */
>   	if (!drvdata->nr_cntr)
> @@ -752,7 +772,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   {
>   	int ret = 0;
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->active_config;
>   	struct perf_event_attr max_timestamp = {
>   		.ATTR_CFG_FLD_timestamp_CFG = U64_MAX,
>   	};
> @@ -919,46 +939,36 @@ static int etm4_enable_sysfs(struct coresight_device *csdev, struct coresight_pa
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
> +		arg.config = drvdata->config;

Given as mentioned above that once a mode is set then active_config is 
protected, this should simply be drvdata->active_config = 
drvdata->config; ??

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
> @@ -1044,7 +1054,7 @@ static void etm4_disable_trace_unit(struct etmv4_drvdata *drvdata)
>   static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
>   {
>   	u32 control;
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->active_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   	struct csdev_access *csa = &csdev->access;
>   	int i;
> @@ -1086,8 +1096,9 @@ static void etm4_disable_sysfs_smp_call(void *info)
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
> @@ -1130,8 +1141,9 @@ static int etm4_disable_perf(struct coresight_device *csdev,
>   static void etm4_disable_sysfs(struct coresight_device *csdev)
>   {
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	raw_spin_lock(&drvdata->spinlock);
> +	struct etmv4_config *config = &drvdata->config;
> +	const struct etmv4_config *active_config = &drvdata->active_config;
> +	int i;
>   
>   	/*
>   	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
> @@ -1140,9 +1152,17 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
>   	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
>   				 drvdata, 1);
>   
> -	raw_spin_unlock(&drvdata->spinlock);
> +	/*
> +	 * Userspace may read ss_status and cntr_val through sysfs after
> +	 * the sysfs-session has been disabled.
> +	 */
> +	for (i = 0; i < drvdata->nr_ss_cmp; i++)
> +		config->ss_status[i] = active_config->ss_status[i];
>   
> -	cscfg_csdev_disable_active_config(csdev);
> +	for (i = 0; i < drvdata->nr_cntr; i++)
> +		config->cntr_val[i] = active_config->cntr_val[i];
> +

Readback of TRCSEQSTR needed here too.

> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
>   
>   	/*
>   	 * we only release trace IDs when resetting sysfs.
> @@ -1690,7 +1710,7 @@ static void etm4_set_default(struct etmv4_config *config)
>   static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
>   {
>   	int nr_comparator, index = 0;
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->active_config;
>   
>   	/*
>   	 * nr_addr_cmp holds the number of comparator _pair_, so time 2
> @@ -1731,7 +1751,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   {
>   	int i, comparator, ret = 0;
>   	u64 address;
> -	struct etmv4_config *config = &drvdata->config;
> +	struct etmv4_config *config = &drvdata->active_config;
>   	struct etm_filters *filters = event->hw.addr_filters;
>   
>   	if (!filters)
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 8d73248b840a6..f64c0acebc701 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1613,7 +1613,7 @@ static ssize_t cntr_val_store(struct device *dev,
>   		return -EINVAL;
>   	if (val > ETM_CNTR_MAX_VAL)
>   		return -EINVAL;
> -	if (coresight_get_mode(drvdata->csdev))
> +	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
>   		return -EBUSY;
>   
>   	raw_spin_lock(&drvdata->spinlock);
> @@ -1799,7 +1799,7 @@ static ssize_t sshot_ctrl_store(struct device *dev,
>   
>   	if (kstrtoul(buf, 16, &val))
>   		return -EINVAL;
> -	if (coresight_get_mode(drvdata->csdev))
> +	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
>   		return -EBUSY;
>   
>   	raw_spin_lock(&drvdata->spinlock);
> @@ -1851,7 +1851,7 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
>   
>   	if (kstrtoul(buf, 16, &val))
>   		return -EINVAL;
> -	if (coresight_get_mode(drvdata->csdev))
> +	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
>   		return -EBUSY;
>   
>   	raw_spin_lock(&drvdata->spinlock);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index df9e0748d71ec..c33700711154d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -1019,7 +1019,8 @@ struct etmv4_save_state {
>    *		allows tracing at all ELs. We don't want to compute this
>    *		at runtime, due to the additional setting of TRFCR_CX when
>    *		in EL2. Otherwise, 0.
> - * @config:	structure holding configuration parameters.
> + * @active_config:	structure holding current applied configuration.
> + * @config:	structure holding sysfs mode configuration.
>    * @save_state:	State to be preserved across power loss
>    * @skip_power_up: Indicates if an implementation can skip powering up
>    *		   the trace unit.
> @@ -1077,6 +1078,7 @@ struct etmv4_drvdata {
>   	bool				skip_power_up : 1;
>   	bool				paused : 1;
>   	u64				trfcr;
> +	struct etmv4_config		active_config;
>   	struct etmv4_config		config;
>   	struct etmv4_save_state		*save_state;
>   	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
> 

Regards

Mike

