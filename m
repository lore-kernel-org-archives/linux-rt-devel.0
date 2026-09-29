Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013025.outbound.protection.outlook.com [52.101.83.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D854FECC4
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679226; cv=fail; b=Glrl5Efvn7jErlBpIKAlaZmJVIpa10M/geVU8bP2pSYs7rz0o6VUE76+zRgi5AcAwH7S5cqmBbmo8lVXG0mrGw7pdDYFDQxucZSQNAtyx0AzINU8i9v4cYV/u5bfPupOjhopPYpaisSGeAPT2kj/rRU1pyFKuddRpAD5NrAAqUI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679226; c=relaxed/simple;
	bh=iGY+Ns5tJI8S+Zqhq35oP11fx6Vi5kDq6WmW2pPKeuk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k4h7etQp1UFTStLd/gIPteeStKScXpKUAw6hLjLAWVSSrLy24nU2L9O2uql0hWVUDV4sU4o55Up8Lf04SemddbKwQ226vL3RxNnbIRVQ/cTsNHaj2/X6+sNaRYvve6We8Ueqkfio6xzV8/DmojtTCkuKVuCMXSIZ66CNTnH1huU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CsC1uSGj; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CsC1uSGj; arc=fail smtp.client-ip=52.101.83.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CsC1uSGj";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CsC1uSGj"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qsQvk3ONhCa7wsKJk7FXDJqSWCzuAyjhuVdb9/x2wD4MfExyWGIKsJcY5AI/ry3r0nk86U4gszCMXHOA/+g+I239g+KdHOnKtfklANxFuMW62rW/U6wH6Mhz0K5ROdYmheRrdBJYLxnLCU7SjIgAH6qu68Xuc156+g2Fkd9Q1PpWxtMhz9KyurxC3HiUO0sG+Dph+CjUaS3Xs/4il7mi251oFefQMZkj7r0zDtNW6jX/VZzB0/B/Ppo3BKltnPkt85lnKj1Ju0P+8a+TTohAvyzUjnUVr77Dgv+77mi4NsXYyzW4T/1ALkLZtR8qciqjS4m2elPfTpzAWEvBuRuVGw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS5zRiYxPZ07ZI2JFXqN1hn+wlNUQWnWzWWwsjNhFmI=;
 b=OzX/pF/frswE9eKtCT11kximoQeCEEdcaH43+sIURiDDQJ3lbIv/lYmjVrQafma97EldOGVZguAb2HW/Bo0cg4WjFD6Z7htPBfsBzsz3CFbOkJ6XnnP4H86gc93rg34gu58iWQE62AldUS4TEKlQZkmdule0iCdb8ZLkh6Wxv6JpWXCt8PEoNVPGLKQGaGG3uKByTamzmQOQZnjzbKSnusaJg5SafD24McVZiquZVsltrMfPHYxo4EDCR0rprSP92WQjv+BOiuI9p6YfEV+nYGUah1ue2O+0KsD2MQuos+TFdO97YpTbT36seuLPf8FnFxBMb6y2DR50VUF1mtviWw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS5zRiYxPZ07ZI2JFXqN1hn+wlNUQWnWzWWwsjNhFmI=;
 b=CsC1uSGjicdAqCE7K0qy3KrRe2Dw5AmMynHNT+8mk1LQU7LCnZuDROrZuQmBwiVnUgjEaqNp1A+b/e1V/G4KGi3qMqJ6smLMn7sVyFMwUZSxxP3Hx2e0pkmLVjSWDdlW4Qp9SLmMBXEkyhRZXHNOS5/HhbnN1GoctvKVewqb45E=
Received: from ZR0P278CA0204.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6a::13)
 by ZR6PR08MB462591.eurprd08.prod.outlook.com (2603:10a6:910:d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 10:53:36 +0000
Received: from MI3PEPF00008484.eurprd02.prod.outlook.com
 (2603:10a6:910:6a:cafe::51) by ZR0P278CA0204.outlook.office365.com
 (2603:10a6:910:6a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 10:53:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008484.mail.protection.outlook.com (10.167.240.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Tue, 29 Sep 2026 10:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHx6vp4uDjylOx1pBY38df1nUAPmlHLBbiv9IvebVR9yKTz4muAh2N/d+IhJ2ofEMD3v2y8Tj01b6gfNq0yGHqJP1Mu/SvqHfo6OL13T26NiC6bmsaoaXH8EdnxnGrfESAmzdPebzb1ITiO5TIYjGVZn6SHbCg+771NXNx+z8CoV98ExHWOMSuYBP0IcDK9FZ3fFNR/dL/d51dLdLkCPObmHayCZ+NNlI3U/UmAl7NRXbmAnJMF2O9uS6QQm3MMIHTQL9k4DpruXorDW/jI+guR3Ge40b3ojsR0M35wK451TWiuDNw4mXnSDQ2rrQSZCdenVc8N8l3yMRTNYy10wCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS5zRiYxPZ07ZI2JFXqN1hn+wlNUQWnWzWWwsjNhFmI=;
 b=N5hFa67Eh8vg2dGJk/sazgJzUW0gIDmYI3Cd7xjcRY6YiYnH8u+/08eeEqF5OrK3YULD7bizMZWEeGyYI8NKZwGhaWiIqCwzWE4hMbrDe74TIzpZpTyCqLbrsCKpDHUUtwDoXeVLbqVZoqx0gPlfBVNY30vkkR/Xf1iCyBvAJoymFGUVfwVgtt5j8N5kpt2La0qdQQwvQwnbdimL3/513XNTyd8YSZ7yYUUeeiPJx+y2NVQDBVv5UJZ1kGjply9JglAOSYryev0gMuYtST6HCAbkGj58DPib2WidWDV6PfvusVqdHh4tZZexpBBbvINXA10YCaCwgba1Z6b7P2R7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS5zRiYxPZ07ZI2JFXqN1hn+wlNUQWnWzWWwsjNhFmI=;
 b=CsC1uSGjicdAqCE7K0qy3KrRe2Dw5AmMynHNT+8mk1LQU7LCnZuDROrZuQmBwiVnUgjEaqNp1A+b/e1V/G4KGi3qMqJ6smLMn7sVyFMwUZSxxP3Hx2e0pkmLVjSWDdlW4Qp9SLmMBXEkyhRZXHNOS5/HhbnN1GoctvKVewqb45E=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DB9PR08MB8386.eurprd08.prod.outlook.com (2603:10a6:10:3d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 10:53:01 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0472.005; Tue, 29 Sep 2026
 10:53:01 +0000
Message-ID: <2c8ad485-2912-46d7-9726-c34717d625df@arm.com>
Date: Tue, 29 Sep 2026 11:53:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/14] coresight: etm4x: exclude ss_status from
 drvdata->config
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
 <20260924-separate_etm_cfg_v2-v12-8-a2b41d2f7c2b@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-8-a2b41d2f7c2b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0013.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::20) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DB9PR08MB8386:EE_|MI3PEPF00008484:EE_|ZR6PR08MB462591:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c10196a-6c96-48b8-c119-08df1e17e966
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|260925021311599003|260925021911599003|260925022911599003|56012099006|11063799006|4143699003|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 /Z5kxI2Z8UYBScnXLJVLsmUmF2lvC1SuEmSD2d+7MA72+MedIlxd43x3GV7A+46+0ys2xQRE0TwOYVxFkGlDDfhHneQ0DKvZ0gEFNYg88pH3mdN5ERFSVmPB1kK3JIJJdu59tlfZe9UA0ktTliSMdHE9P+BYy/gizBL8Sy7KCf5v/pP6DpNqwTm4izh73qm1iT+wGUO8kD06aDZelkYF59T1k52JU+8VT77lGz3J859LdtRvpXRuCDFwwZcmW3MrnwsBNfcy3zeoN4BUJomMmDe7MvEhRXlXFr3pb+UB1Cpj3Prsv5bFFrj+fg0/xqBMXm37wP2kPQg7GJNSFHlZIrYYQNVPt2kg4JeE4MZIHG6IVRRosv26kwQIV/TKX3W58KLib3rKkxSdMtcTUEfTFpRS4QUlUDtTLlmybH5FVPrxHH/RXpeSGQqZH68RKlIjHDsKAqmPnVqRzfM3Z2QpwD7Nzn8U9EDsQdGKkfcCURHGNLTNTeqLF7aouhh63bLzO7lgxm/bDhVA42uN36OROAmVH5JKWqCCixVEmQ/mEQCapkh7l+Ybjf+fVdYUAoks58OSlrgH7dtDXiclK4fwyOqqrjvdb11Ld1Zda9jg+Lq2pH3bUhvwia3T05oM0dYW2k6/NBORHiuOqbOknjiWBTwePywYzebJV50Zqzg+4X0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Q/G5FaB3NqvggSbVWsZ1H77iKjvZe4PrV8Sa7NT+QeLpnhZeGfeujfSmxp4Wsop4xZEXBWdbxHNuBUR09L5Ck3jnTYb84CMjrUFV9ey27ln2qUAUk6dJaSajCmOPPUdPDyY/90a8lp/vNwDi/kIS0NN1sAxyEJcoYLrTquQllmRrtNyT2vF93j0H5nzf52nhwGbV6rV1IoHlbdwLllpEV7zPY4YUhce+iXVhrLHynnp/Ocgn7DPn+YU2xnQmx+85nIeyOhS2scNk7T8z296f/0J1BrOg3p2FD+c6J7SnLDZJDeqK3UN5Q58QmX/aCSPI/T2c5m6kqgkrGUXcsS74Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8386
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0f3a55df-e879-44a7-533a-08df1e17d4c5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|1800799024|14060799003|35042699022|36860700016|6133799003|18002099003|260925021911599003|22082099003|260925021311599003|260925022911599003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	oUd5QgJEifOLY1UroBMU4ABAlmYkEKU/9Ie9dlSlNT8zVtoW/G8asS2IgG0o9gAiI0Zpsrxsi7HWetxULfCA3dojOnLWChcmoE8ntLwuCYhZPKW0o45awCRnoCOyglaXyEzUHv8tBGxKzabzS2I/PWYY5ljCm4gagWfrmXIncuJi8uI/fKl50icriVmctP4PtKORDmF8QBbF8LkYehI14b0PU79bqwkkG5olwLZrfv4lKu5+ArOMp4yzOHnuNiUz4gxzrUWewa8s2VgNsQgAmBRcyRabWsKoYQ2rcwu1nlqxYWqaMVYyVTWgawoj3G3iGkmekBO71GllxmuEO8l1mGjWaZee/3DRqaUftK4lslU/UFLuL88O+xUlvKB253TogefYXfRiCbNF6uU3n687IhVSwX5KBijhpp9eWpJHMg5NNj1H9K1mUTbVM1dha7o1Vqc3+MAe5evdPaRcALBpfI3u4EMcW20oncmYA0aY1JoC+mGSs+rqfVmHXdcz3dlOw9SwT670EQqkBbfB/cc7FG2SFsfasC+pQ7BwhaM0Mk42zi1oE8soNXz0CIt/3t0sFDqMrEcM3RCiWC9Uq9hadHfKBrWu45msJB/lLVlwk2mXW4zR3PEZTXJzbdyMKkWLZ+rVZu+PyW06pBW1W4DOxiBT86E+JwQBwIM4lCqhsdtsTuWqgWcDFnhyQ9XLPmzf8uWzHHVhHGgCC8+eyF3Rew==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(1800799024)(14060799003)(35042699022)(36860700016)(6133799003)(18002099003)(260925021911599003)(22082099003)(260925021311599003)(260925022911599003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NJIMSRpiweu/i4Dg077i6f6eaMeK/v/6Aa8Ul9WMgpMADK+kSzJPOEfnNL2f4QQ6yT4jCHKrenWPueKM5o4XvfcquxvafcJfq5pMYHqDMP/IJWhr/ZF/rexb9nHsIIIZKb15i+u00XhPhnTFDZJ6L2pjEG5ltkbPDJV5yqfs/5XlCag8eMyu1WEaKPCbncr85pKxVrelb6CQ/OJpLyqMY08igwuz0ajV9L4mldVquZaldYwJJFz0tlM+8Y3TYoGuBeWzlXgDXP1eVtHOF4WEvFjRUCvzO4M6WchsuSssNHfn2C2SQcpNzpoQnkwkrQRYb4DfJwvv6hkQ5F/QPnse1suxzb8rIKer+TV/EUnvCoCwWIjSma1bDojzxe/HbiXdglvDr5CS8l582ZdNrglgySApKqh07EFj9tbT8uliwQ0j9m8eRQ5T6DlV/iwUZ0wq
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:53:35.6717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c10196a-6c96-48b8-c119-08df1e17e966
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB462591

Reviewed-by: Mike Leach <mike.leach@arm.com>

On 9/24/26 18:33, Yeoreum Yun wrote:
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
> this patch intentionally preserves the existing behavior.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-cfg.c   |  1 -
>   drivers/hwtracing/coresight/coresight-etm4x-core.c  | 18 +++++++-----------
>   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 10 +++++-----
>   drivers/hwtracing/coresight/coresight-etm4x.h       |  8 +++++++-
>   4 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> index a9f6ed47a2f5..52cb036bb04b 100644
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
> index 3900b96e9c7c..4a8c1070bbcb 100644
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
> @@ -572,11 +572,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
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
> @@ -1078,7 +1078,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
>   
>   	/* read the status of the single shot comparators */
>   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> -		config->ss_status[i] =
> +		drvdata->ss_status[i] =
>   			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
>   	}
>   
> @@ -1163,12 +1163,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
>   				 drvdata, 1);
>   
>   	/*
> -	 * Userspace may read ss_status and cntr_val through sysfs after
> +	 * Userspace may read cntr_val through sysfs after
>   	 * the sysfs-session has been disabled.
>   	 */
> -	for (i = 0; i < caps->nr_ss_cmp; i++)
> -		config->ss_status[i] = curr_config->ss_status[i];
> -
>   	for (i = 0; i < caps->nr_cntr; i++)
>   		config->cntr_val[i] = curr_config->cntr_val[i];
>   
> @@ -1528,8 +1525,7 @@ static void etm4_init_arch_data(void *info)
>   	 */
>   	caps->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
>   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> -		drvdata->config.ss_status[i] =
> -			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> +		drvdata->ss_status[i] = etm4x_relaxed_read32(csa, TRCSSCSRn(i));
>   	}
>   	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
>   	caps->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 0f1f50b588f2..a66f34c942ba 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1835,8 +1835,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
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
> @@ -1850,7 +1850,7 @@ static ssize_t sshot_status_show(struct device *dev,
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
> index b4579261868d..67071f7cbdbc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -213,6 +213,11 @@
>   #define TRCACATRn_EXLEVEL_MASK			GENMASK(14, 8)
>   
>   #define TRCSSCSRn_STATUS			BIT(31)
> +/*
> + * TRCSSCSR.PENDING is only implemented by ETE and is therefore not
> + * described in DEN0117. See Arm ARM (DDI0487) M.c, section D24.4.59.
> + */
> +#define TRCSSCSRn_PENDING			BIT(30)
>   #define TRCSSCCRn_SAC_ARC_RST_MASK		GENMASK(24, 0)
>   
>   #define TRCSSPCICRn_PC_MASK			GENMASK(7, 0)
> @@ -980,7 +985,6 @@ struct etmv4_config {
>   	u32				res_ctrl[ETM_MAX_RES_SEL]; /* TRCRSCTLRn */
>   	u8				ss_idx;
>   	u32				ss_ctrl[ETM_MAX_SS_CMP];
> -	u32				ss_status[ETM_MAX_SS_CMP];
>   	u32				ss_pe_cmp[ETM_MAX_SS_CMP];
>   	u8				addr_idx;
>   	u64				addr_val[ETM_MAX_SINGLE_ADDR_CMP];
> @@ -1071,6 +1075,7 @@ struct etmv4_save_state {
>    * @config:	structure holding sysfs mode configuration.
>    * @save_state:	State to be preserved across power loss
>    * @paused:	Indicates if the trace unit is paused.
> + * @ss_status:	The status of the corresponding single-shot comparator.
>    * @arch_features: Bitmap of arch features of etmv4 devices.
>    */
>   struct etmv4_drvdata {
> @@ -1091,6 +1096,7 @@ struct etmv4_drvdata {
>   	struct etmv4_config		curr_config;
>   	struct etmv4_config		config;
>   	struct etmv4_save_state		*save_state;
> +	u32				ss_status[ETM_MAX_SS_CMP];
>   	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
>   };
>   
> 

