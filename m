Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C251CF7D
	for <linux-rt-devel@lists.linux.dev>; Tue, 29 Sep 2026 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679067; cv=fail; b=jo8Ruzt9rfRKEzd8QrlTZjnvC/G7WMvUn+nKm6hIU4MSQ1S9iXoJrL/bMHOQNCH93l/ftqZADn4H6KehTdY3JfaU6USckhEOgbYXVO5PRgwPF5oOTpyS+8q7+amDtpkrppWhYOuIKRMHk7/OwZg12MPfYZD2b3GUBkpNwCG9Z2Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679067; c=relaxed/simple;
	bh=4AgH1LJCRLka9wrpAGw10L0k8PYsyIjKQQ3HwpR8OD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S1FkfJusqlmUXFKl2BaJdRoeElTIkjOs7aKKYAnXEo4xyC5VgIxNraCEr8ltCh6lNAkJrWNZ2F5JdtG5cQRDQvkmzzoxkw9sc52PnzyJ0K37nhMwvxvVneAaz/gf50hqSYJmCPNpUqUWnBiq59Ilru5+esoGKt4dV9BxfaPiYpQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fgcAikdy; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fgcAikdy; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fgcAikdy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fgcAikdy"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FSPP21JiRmdBDG9elXqaJPSfIUGA+uArO/NpDFtwVZMHo6dF01Rq6JSNXbNISiZk5rBSCDI8OJ6HcaTlihVNV30jZdPvGNhOz8tU+Hh6a3oLq8KtDumsve5Khn03wY7lJPLPcTIVw5F7P/d6U/OpPY3jRTHjBLQW9Nrqxcegu6JO10Nf2YcWxypvuEsU+wN/uaGBG3REu13AVZnw+B2VLqjz+o8j+uCdh5xCnzqbRa8ovVNCq1AoXR98IjLkVdLcyE/i3UI7E3K8LDtQMMzQx/mfS+Evgarq5NmE3RcDo9UJ7iFHqQUH01Fr82k4B/0l5KC4jisMrxygDIZd5n/H/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG6HQCDkEgumtiy0eF3ObpNIOPXPTGDuscb5KgTFVdk=;
 b=wuyZ3rRM9tQ2fXHTuxT3IVIds/jqzaFyCPJNyaReQviCVtFFcOmbSbgob6LMItBNc/rAF5FQmMigv8bI49uvDhjxyaFzEtNGAFjAmSH/qTRC69vnjFEwuia71dkHHRqj2I1mottSYftKuD87oEjS4FnhjUjo4Vk4o0mAwpVfptoLj+mqoUysVnqm0l+VdqxiUEcTbl/qsN4jSIMVhO1vv8gh50tRyvCQTe1m/iFYgwuVbuPmYSJK8jWMdIEzhHozAMnzKY2InvJ/LL2Dk5IO1dTGH//KBZAErh9kRntQaaA1LGMRjwIsT1bfVgFuSgwFF8RTY6m0xJS/lim58it5ZA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG6HQCDkEgumtiy0eF3ObpNIOPXPTGDuscb5KgTFVdk=;
 b=fgcAikdy11UKxOpOX9jta4garcl/LReJx8ep+7aXyvaINAGxCJGnntHPD/ZFKFttd6M0rHnywwa//2pX96/RVdywP6oyGum53cAc+Y7v+Ua59m6SeGTejAp649X+Bh7x2xZV5pHxFxn3gL8TR5uyqi2EK7ZzSUP9um5j3ZreVJQ=
Received: from PAZP264CA0199.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:237::12)
 by PAWPR08MB10898.eurprd08.prod.outlook.com (2603:10a6:102:46f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Tue, 29 Sep
 2026 10:50:25 +0000
Received: from MI3PEPF00008498.eurprd03.prod.outlook.com
 (2603:10a6:102:237:cafe::4f) by PAZP264CA0199.outlook.office365.com
 (2603:10a6:102:237::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 10:50:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008498.mail.protection.outlook.com (10.167.240.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Tue, 29 Sep 2026 10:50:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWbTLSCLuOLYg7u+ZrSSRWg8auypIr2ED7GAJoCSGd1nEb55uo55JTJEZo55nCaVK23BNs5FYFoEzkqgjDJbmsaMY7zWSPjDg+uLMyx4NEUSYEXoiYttQsVCr5btu8h74OrnIBsTTFaThkOULXrwZRXzJGtvtpFDRUBWlMh594CmSd5H5M+I1jqBUFOCInpY6asfSpCHhyFWwj9KIqO7U0K9cTVuc1RvBennd+GfERIaQbGW5uHBr7bjvSwyrUZP3USRnAhCGK5UyLCZ4xdxkmEy0YAtha4wSDd/Vczf7PjpwvkSz+DDJEUkI8rmcUXyy7gMXMChgJDFD1uBQcjQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG6HQCDkEgumtiy0eF3ObpNIOPXPTGDuscb5KgTFVdk=;
 b=qdD7Jyh8dP49OxlumhhxG603RDm1Uho0RxYvnVr+k4oDWEz+gM3jcOoupZZdvs7tJU9xn2BP3kh58Si8A/zA5laLxYvszGr4GKPN03xqjGrnhs+Z7fKozV5/i8/Amvx/hmGjghDaDvMl7HmJNVpIU/wzjmSWU4vc8xBnVkBQ7yrUsZ1jCSyJFWflUCgOlU0GNbeQWKaBqXJM19v8WXTsLnDXCO2MbBDAtcEq1OZC5EXMaXTp4Mu1yTfXcTISVmIfCXDWFF+h9ZX7hmWdphAh1ckJkJoZIv28hmNWcpkWlqFoCa+M5Idb0VWvY/oYkbUeYxUUr4Z7NuxWo0yVZGqjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG6HQCDkEgumtiy0eF3ObpNIOPXPTGDuscb5KgTFVdk=;
 b=fgcAikdy11UKxOpOX9jta4garcl/LReJx8ep+7aXyvaINAGxCJGnntHPD/ZFKFttd6M0rHnywwa//2pX96/RVdywP6oyGum53cAc+Y7v+Ua59m6SeGTejAp649X+Bh7x2xZV5pHxFxn3gL8TR5uyqi2EK7ZzSUP9um5j3ZreVJQ=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by VI0PR08MB10684.eurprd08.prod.outlook.com (2603:10a6:800:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 10:49:49 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0472.005; Tue, 29 Sep 2026
 10:49:49 +0000
Message-ID: <d237c23a-6fa5-4113-8902-270147f1b423@arm.com>
Date: Tue, 29 Sep 2026 11:49:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/14] coresight: etm3x: fix inconsistencies with
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
 <20260924-separate_etm_cfg_v2-v12-5-a2b41d2f7c2b@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-5-a2b41d2f7c2b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0015.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::11) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|VI0PR08MB10684:EE_|MI3PEPF00008498:EE_|PAWPR08MB10898:EE_
X-MS-Office365-Filtering-Correlation-Id: 254b0a26-b2cd-4caf-ca96-08df1e1777a5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|3023799007|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 POLkDQkC4AjiQVgSMC93D3eyky5f/4E7M52LTpLDn5ea91mghh1p4yF60YzgafCAwaim9GgzYzcd36QcFHvh5SBN5t8bGLHxEROLeudEmAVyLKw8ypcxjduycmOLZwfB1x90PRwYHXNYAyQ5A55BIOyuxp9VKUgUJQyHdxw06zf/B0iFcAgrM3Qq8K7RoN6MlEJ4S7Z3neVVK+h6rctafqjIjOgeZIBLHhHUj+KwN8rJrTOrb5TyDOvX3WOwoPMkX0z2OP8V91/bBMuFAyyVNq7Cm68gBS/PGHuzhdPLp/EfuwOwrmyT46FzMev9qVmPPY8pIhqG0A9fv0P8X/wm6WPztKKyHzejMFhJJswq7fm5atpxAwb+gpEirPHxKGjT4g6yYPaTVjG6KwU6zKHC7c/gT5Z02GCl1iQdOup4XVKfr6VrZrEM1ZSvLOK5vfSKdZe5HLD0LpTNYxTZ/W7o4KE/B45KQJmhYOuoFaiqSrkyQGyEUH/L8Qr/5066CeJr1kaYOPRb78cSqZCxUmJy8huv3NrBm0SzOKCmsZN6VIhqJwkwu9+nV6KRQ+Wt4noRv08LbBnMCQb/j8CCq9rXYBGViBbPmpseggcC9b1rJA2oLyOruu5MXrb3qBjCyQjHZ4atMShGkC+wc9VFpjB+HSJw8CQGz8AJPYSzl45dNu4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 xkxBNcdYJVtzw0/udp/OO8g1rvRHMKMbXzOwJdYnvNiIq2sPCxGuSaBo9yftwK1bALNDEtbwqyvmPu7mDuumtUSKj/c0a0eDxzQeqKYrITiFhXMIBZVGiSIuj3n50sd0XH/8ZlMa2oDwuS9k8HRbhS7qjOKoE8IN4g/BHqww94W/Z0vtVA0RW0B2YD/N3UV/zqvAwcX4n2rhUV10HVPCSnK8LhP/vWYi8D1tS7fg/tg4oZY6YffL1RKCbaLaRbv22lSI4V5IvFsO27yHIrByVHPBBYUffAWUVvFpyzkE69jYyrgmDaStGLHmjagmE1wBkdxZYUZ5E6A5gR+vMjpUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10684
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF00008498.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	977685d8-2c9f-4a99-ab45-08df1e176239
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|7416014|376014|36860700016|1800799024|23010399003|10067099003|56012099006|4143699003|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ekm11LPT9YIbhekmFY/YGasQ2+vcIWZXheE1msrgkoTbfAtFFrcUQnroVgI6r+GMx7BjwwgQwveHYeRO7ilwYLCl5mjjNTDe3+M45Jhg1dMpD5XVuPSeWprXY/n9UlobjTHtQIrBYtvo5NY2CV2opjDrMTfsFfDzZsFQLsre1ekXLZgra8fdacIHNPlmSFmTVWUqoNzrP3hLRL7PAI1O+XxlocHjtwOm3Q+AZSNaw8bs8+o1UQUfn7+GzEAeBSjYsyUFZDZ83+bHhoGVnUZHcrmuquqho4yeoW7rpbm1zSQjueHzfiIcrzvh445Li4xW6VnuhgglIyWF0NYAxtk/fUbLAsGnEY+lqXJlm8xT6/kSiTYf3QhSWUP8HqKXwxHYBI0279J0tTb5dGpxy2lqSIHJYduJARphszikAsJ/E6LNUySI1fbK3+aPBpv22qGLReIJT0WiUpb+J3+AfHV+yQfRrhEeEgVjqOixiabvGasFbZ3lhTrp2Kf0BRh/BXBD/wacNP1O8i0Y9jMiDnUoUK0Q3zjTjuGDXeZgUIOo0XvkqzymdjsWsIMJ32+9gYHx0FbN2VMnuQTx8vmMTVFKPZDjJddoELaz0pWVI4xAjRaajARw8hBhaomHsmCTs37jv8uv8V/rAtBPtJWBVGMRPg7owldF82Vnh2vwImrbvgC29OXXLIGPz0VPE8vLtYBeEA7OHwO51rCTk4IlP6hWcw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(7416014)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ut3YtV5iN4ycNnvH6IxqIbL5SKTp+lHrCgN9A2uEe0Q+ZlMoBeMhrwuN285xe5qEaQTQ0essWv5ExZgdXaJ6lkuLPK0B5Z2WKt9IE2czrvGoWqujXrwgD8q4UikGumkXNWSuErVvu3LoQ/7jeEG1O7/POt6PI7qt/ES4/fFD9eYcAnEZPFKY7fQCN0DUVG8cZG0L9x9MODRc/F2tQD2COIAWUYNpL/nwAmauISJWKdOavM1h45Mlzb+vWHm9zgJs+1Qjg270zEsRxKNnY3nE4qssFWyptYYXIgIzGoSUYB+y9zgxEE/JvTkWSvRyBBrgMDwtSAqRIWq5o0mgLMTptROTiKY1QwSeoGyAkLhTONimDEelKF3fQCCM0PYpHHbUPtN5uisLwPGCdQG1DgXMpvINXFMGhgmrL4vwQMoTx0YF2HfrruOw4fYAPwZZkn/b
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:50:24.8433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 254b0a26-b2cd-4caf-ca96-08df1e1777a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008498.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10898

Reviewed-by: Mike Leach <mike.leach@arm.com>

On 9/24/26 18:33, Yeoreum Yun wrote:
> The current ETM3x configuration via sysfs can lead to the following
> inconsistencies:
> 
>    - If a configuration is modified via sysfs while a perf session is
>      active, the running configuration may differ between before
>      a sched-out and after a subsequent sched-in.
> 
> To resolve these issues, separate the configuration into:
> 
>    - curr_config: the configuration applied to the current session
>    - config: the configuration set via sysfs
> 
> Additionally:
> 
>    - Since curr_config and related fields are accessed only by the local CPU
>      in etm_enable/disable_sysfs_smp_call() (similar to perf enable/disable),
>      remove the lock/unlock from the sysfs enable/disable path and
>      starting/dying_cpu path except when to access config fields only.
> 
>    - Some of sysfs interface read etm register directly. To reduce lock
>      scope while the etm_enable_hw()/etm_disable_hw(), handle it via
>      IPI so that registers could be read from on proper CPU.
> 
> Fixes: 1925a470ce69 ("coresight: etm3x: splitting struct etm_drvdata")
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm.h        |  4 +-
>   drivers/hwtracing/coresight/coresight-etm3x-core.c | 66 ++++++++++--------
>   .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 80 +++++++++++++++-------
>   3 files changed, 98 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
> index 1d753cca2943..52f23a3c7364 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -226,7 +226,8 @@ struct etm_config {
>    * @etmccr:	value of register ETMCCR.
>    * @etmccer:	value of register ETMCCER.
>    * @traceid:	value of the current ID for this component.
> - * @config:	structure holding configuration parameters.
> + * @curr_config:	structure holding current running configuration.
> + * @config:	structure holding sysfs mode configuration.
>    */
>   struct etm_drvdata {
>   	struct csdev_access		csa;
> @@ -248,6 +249,7 @@ struct etm_drvdata {
>   	u32				etmccr;
>   	u32				etmccer;
>   	u32				traceid;
> +	struct etm_config		curr_config;
>   	struct etm_config		config;
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 862ad0786699..dcadcc383012 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -308,7 +308,7 @@ void etm_config_trace_mode(struct etm_config *config)
>   static int etm_parse_event_config(struct etm_drvdata *drvdata,
>   				  struct perf_event *event)
>   {
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *config = &drvdata->curr_config;
>   	struct perf_event_attr *attr = &event->attr;
>   	u8 ts_level;
>   
> @@ -367,7 +367,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>   {
>   	int i, rc;
>   	u32 etmcr;
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *config = &drvdata->curr_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   
>   	CS_UNLOCK(drvdata->csa.base);
> @@ -448,26 +448,22 @@ struct etm_enable_arg {
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
> @@ -512,9 +508,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
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
> @@ -523,23 +520,27 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
>   	if (cpu_online(drvdata->cpu)) {
>   		arg.drvdata = drvdata;
>   		arg.path = path;
> +
> +		scoped_guard(spinlock, &drvdata->spinlock) {
> +			drvdata->curr_config = drvdata->config;
> +		}
> +
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
> @@ -565,7 +566,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
>   static void etm_disable_hw(struct etm_drvdata *drvdata)
>   {
>   	int i;
> -	struct etm_config *config = &drvdata->config;
> +	struct etm_config *config = &drvdata->curr_config;
>   	struct coresight_device *csdev = drvdata->csdev;
>   
>   	CS_UNLOCK(drvdata->csa.base);
> @@ -593,7 +594,6 @@ static void etm_disable_sysfs_smp_call(void *info)
>   	etm_disable_hw(drvdata);
>   
>   	drvdata->csdev->path = NULL;
> -	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
>   }
>   
>   static void etm_disable_perf(struct coresight_device *csdev)
> @@ -630,8 +630,9 @@ static void etm_disable_perf(struct coresight_device *csdev)
>   static void etm_disable_sysfs(struct coresight_device *csdev)
>   {
>   	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	spin_lock(&drvdata->spinlock);
> +	struct etm_config *config = &drvdata->config;
> +	const struct etm_config *curr_config = &drvdata->curr_config;
> +	int i;
>   
>   	/*
>   	 * Executing etm_disable_hw on the cpu whose ETM is being disabled
> @@ -640,7 +641,14 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
>   	smp_call_function_single(drvdata->cpu, etm_disable_sysfs_smp_call,
>   				 drvdata, 1);
>   
> -	spin_unlock(&drvdata->spinlock);
> +	/*
> +	 * Userspace may read seq_curr_state and cntr_val through sysfs
> +	 * after the sysfs-session has been disabled.
> +	 */
> +	for (i = 0; i < drvdata->nr_cntr; i++)
> +		config->cntr_val[i] = curr_config->cntr_val[i];
> +
> +	config->seq_curr_state = curr_config->seq_curr_state;
>   
>   	/*
>   	 * we only release trace IDs when resetting sysfs.
> @@ -649,6 +657,8 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
>   	 * prior trace id allocation method
>   	 */
>   
> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> +
>   	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
>   }
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index cdb70a4382eb..284998f18017 100644
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
> @@ -76,7 +109,7 @@ static ssize_t reset_store(struct device *dev,
>   		return ret;
>   
>   	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> -	    coresight_get_mode(drvdata->csdev))
> +	    coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
>   		return -EBUSY;
>   
>   	if (val) {
> @@ -721,7 +754,9 @@ static DEVICE_ATTR_RW(cntr_rld_event);
>   static ssize_t cntr_val_show(struct device *dev,
>   			     struct device_attribute *attr, char *buf)
>   {
> +	int ret;
>   	u32 val;
> +	unsigned long val2;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	struct etm_config *config = &drvdata->config;
>   
> @@ -730,7 +765,10 @@ static ssize_t cntr_val_show(struct device *dev,
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
> @@ -749,7 +787,7 @@ static ssize_t cntr_val_store(struct device *dev,
>   	if (ret)
>   		return ret;
>   	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> -	    coresight_get_mode(drvdata->csdev))
> +	    coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
>   		return -EBUSY;
>   
>   	spin_lock(&drvdata->spinlock);
> @@ -937,7 +975,8 @@ static DEVICE_ATTR_RW(seq_13_event);
>   static ssize_t seq_curr_state_show(struct device *dev,
>   				   struct device_attribute *attr, char *buf)
>   {
> -	unsigned long val, flags;
> +	int ret;
> +	unsigned long val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	struct etm_config *config = &drvdata->config;
>   
> @@ -946,15 +985,10 @@ static ssize_t seq_curr_state_show(struct device *dev,
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

