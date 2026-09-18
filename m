Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13D4DAFB5
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730094; cv=fail; b=Y23IbBoDhsR4D6/C+NRD16UqYWecjhjBO+9zIK+sKCjnj4W50MJbp4YH0+ZHidXE4v9jPuOT46Bvq7AoIppauCjdFn8Vz1aQRrCIRJHxg5s1bvpNUOmEVTsySTjGXo6uFZVs+e5rBRr1oqCJHwC4iBcHW9UU3L+MXF+beS7TwHg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730094; c=relaxed/simple;
	bh=62qtYYtkp+OY0Vv1I0+GNdLodHi312F3EejThR6rcto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ezno8Pr/CXm8nzFUyQuMS+XwVSk/Z5KsXKo+T8Fuu/A19R7WRBadWANonFpRlDUZhiUIzvpbpQS+fGE0oNlSk7c4reGHHwDU2gcIiaL6dC51GWroRnixkEEYvCULTu4FWHQEZPgeA7VWtMt4sAiZCCyuktlq2yU4ymfOAQ1vw0M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qq4rWcd2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qq4rWcd2; arc=fail smtp.client-ip=40.107.162.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qq4rWcd2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qq4rWcd2"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hvUXMF5jGhN8NOpu0xLqokcMJSURfpvUmButXdlbhiTYl7yMqOzEgpnvxUxMAi9iFncheWtpUc1BPL4S5z48wr7CyVrdXuP6o6KUA6AImAH1rcIWFMKtO8f1gVLd3b3z5FcBT8Yg2BhA6Al+mGtsH5HCinFRSHs7XRuTRoOR7OmpwVZuYlCRwSYrQ8JXvodAU3atzwCBS0b8qwXDUwW/qm7jhdQvEPv9FgYpD5PLNzdS+51mv0t0ncTCg6us9eF6nQgyf5DmZx0ESseU/3GRYhOgSh2MxBjWMdwwE+Lpqz4n9xasIVUIOahY49LKuUN2R6eqJKQvhdfK16+gamIf0w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igbTS1ukEH0H1stGyrR1jL5z+kOn5fQrsEjt0SVwxWo=;
 b=nP02DA/GsD2hsrdXREARTYiXPciqdtrFvEv7IqShsjZ41W1k2GQJNpp8TGnX2ezAyrmNjTgJdsAZEnITbwoiobSUiADG+HV2QLZAEQueJegFX1ONiAbJjY87+6ymUXlYI841/CZAXxSSZgzWbfsOCaabkRHTVbtZFjkM4WcEnNTAKfiAG+ekfqgcSEoy/cg1zCblzhbdc3qptclPXvCoehOMkytNvQs2ed1yNinlg9dtYZBtZZYyOXq8KSuRqeQfYknqvEBrw57DlTKJGk1xQO1cE3TgyYpptL4WhgoEvVLj3brHmLX7FHLMTYBkhrVb+Dgau8qQkXXVDFLmnI6alw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igbTS1ukEH0H1stGyrR1jL5z+kOn5fQrsEjt0SVwxWo=;
 b=qq4rWcd23mQvuQkR3wBtdwtfpT4dtJKNB2pbfz2gHxuVSC+5DXcb5UueiBhWQN64XAxC3d1WgUeKtndWIyEH5mO50iiAyqQzNZos6MKMOUpkr/CcYohiJNFk4kvyz9+WrubJNdmQQIkA98tJF+BedzT1CIFb7w38LKXeO5m2cKk=
Received: from AM9P195CA0003.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::8)
 by AS2PR08MB8648.eurprd08.prod.outlook.com (2603:10a6:20b:55f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Fri, 18 Sep
 2026 11:14:46 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:20b:21f:cafe::90) by AM9P195CA0003.outlook.office365.com
 (2603:10a6:20b:21f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 11:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 11:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHqlKfBTGOABYKKSEOBWDD8PEhVY/EgfTosOm0yLtUvVTgnzQNu3ApMXmpBOmbnpZy3G/Nd3GcWCOtNUF+vV5713ifv5VtAA+AiQYPHubeIEK2F2XHCsM/QeskZAZ6nl8BxJ3AQbqe6GN6W8JwFNnpoNOXcU8C5xUVB1qTOvMtiIldHugP8GImT8TlrdLurx//wpmHPiL8+oAalgZa9zD48LG4c1ddFzbkKh0cNX2dcmMfrUrKwAluDH5wHuU2JPqNnq2QS1WT+hIn4utW4e0NTKSWoIEMP1ZT8Ij65CqrsrpuTJNvDIiulZ1FBOtAfRYYMLvnzZAiU5k3+fOEgqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igbTS1ukEH0H1stGyrR1jL5z+kOn5fQrsEjt0SVwxWo=;
 b=Ks8vkmC8R8iIynMCalPes0CcSFehmsdALiBxz5dcbtVCg87uXR8fgnaq0iZbntQ96YvjkEWDd5Ix+lsK8Vmx3ONVAn2yIc8wxPH+Hwryr3SwbymPKmATIwwcKOBIj4sJCrDB3bqSlJVUwICnq6NINS+nIaiqQozk0VExeQqgRwMhI96Cr3ocFlUuZU+vJTapL5TY/Xj6L2P3db20sYVuh1iOxmwUK1tPAR51Ld4yzo73khJaMDV1JOQw1kE06hnSRiVej+kIB8UP7S+wkhpiQAssKCI29pE//4y+LNegdfPIGsHjicL66RqEqM+119XLz9uhSvDgvYHXJAKyWzxgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igbTS1ukEH0H1stGyrR1jL5z+kOn5fQrsEjt0SVwxWo=;
 b=qq4rWcd23mQvuQkR3wBtdwtfpT4dtJKNB2pbfz2gHxuVSC+5DXcb5UueiBhWQN64XAxC3d1WgUeKtndWIyEH5mO50iiAyqQzNZos6MKMOUpkr/CcYohiJNFk4kvyz9+WrubJNdmQQIkA98tJF+BedzT1CIFb7w38LKXeO5m2cKk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by AM7PR08MB5367.eurprd08.prod.outlook.com (2603:10a6:20b:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 11:14:12 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 11:14:12 +0000
Message-ID: <89b18b1e-65ca-4e97-b827-90d360b9e881@arm.com>
Date: Fri, 18 Sep 2026 12:14:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/9] coresight: etm4x: prohibit modifying ss_status
 and cntr_val while session is enabled
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
 <20260915-separate_etm_cfg_v2-v11-1-d2b258d51747@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-1-d2b258d51747@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::22) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|AM7PR08MB5367:EE_|DB1PEPF000509F3:EE_|AS2PR08MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: eacd6864-b6f1-4718-dd78-08df15760bf6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 ssscJn/OKPa2PlU417J4pUrDqW+pekkX+ugL5giogX75DXk4fkSC5EE2Es6qSqZMoSRbgqv8WWBkCcrlwyZyJF7HMPwyNwc8tvfiLrJdXwzehhVcnE+tR0F6aAUyRY3ixeWv7O3E0dMIewtMRcJNfjNQg0cOp5r9bZ/cZ51UaN40aWO0he4a0NoJxiXA4+Z1wyCSCnouAnp45Nupi+aPMiDFlNvP+Wc4DPqImWozhEcqTN+Dx9qjcFGF1FzxnnGwazKLqSm36sILSHtoU99J0YYwgahxcfIV8MSc0xIljdjnbXHnyA7JtNaAsdcQjdRQpsmmZuCk21t6IyRBPi9BwNmjUpkXtGXre6dDtdhtwVhU7D1yzEmfppg/qWJ2UyZ+NCIokjzhgWALIqhozw4VSjnf1wex+dWOpQZhYJbuBvxksnB8WhPV/cN6f4nJBMFhZpQH6fzE0Oo3P3hXEx4fT4w0i2j9wuTspTidO5+Lxx+4f6/22qfxbSw2uM5wl3DrrBpOvljc93hA/gaNc2rBEnQATUHPhcx3BWwpL3Idi+DPVlCJo6UYA4hsm+AMNF13XYhGwLurBJGM2KA4juO4gUebvKBvjXI5CuF8HzKw+voXfSpYVvioG/fLfEXGhhzI2qPgZb2pPvmv+HGAGO2nordX1Tq0H9NnkT3u2suWGRY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 FTrCrwI5APx1Yenjj7nBg2LYkStyMaQ8h9ptqsqBZErwD6W97t15xPRSi+r/wy178+XcAv57zI1CxP1TBozP9CAIaWXjnAEBDcPjA3KZK0zF0VAismqZH8C4hzm4cR+i0izzRWXSuBi67u8hZUgL1kM7PKbAJkwZca3fDucR5dRYtp2zdTzMx79eIMHpzfPBDQlkkavVk7sBmECd06o9YxnZF3q+t2GkLA3w445BQFnZbWxkEFyvNwUF4WIO2irLlvBFxzf9Z2t9G9AjLLfDsnROSh7OY6bR6m+FelCXW4qMaAPgXJRx2i5jlU9U7FpBQgin3pwuVFUxwIgC4QQgmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2c406be1-7bbc-43f9-1cab-08df1575f7a0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|82310400026|23010399003|35042699022|1800799024|7416014|376014|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	89ixgk7whaW+jjUFyKy7R6KWwUTKMyCspEmA0Jjyp9RnEbLAXErc9XNp/sMCfHUTF0YSxviZO10bgf+Aes8njaKi/scQrjd5B8oufCsju9/sNZX78OQz1D9pyymTDJop5OgyHEzizaxnZqC2rBXxvgGcHJES6+cfvPaKJttJxqTIH5Ot3N1PAr7W6euCnKld6McK7UCt8XnQ3lqTImIR2ZTvCm2w4vRj3UShypyOqe7163121UrRh3cXt6ggIrq56c/LgUJ7ZytLq1wX+7vCN0R6HqTW1UP8/eVsSbqRD/+4x91+DqTOEuSLRFVF4ieqXHOsybYhp1jbgYStrViFWNeEHieGtlcXGzq95XTmxfYsjOkKEQXFEXtG59alfScJrZOcC2S/tXaPs+eKA4thJxhZ3htjAI/34K2x8lfs/IM2rokURiax3wBliifGC//g8mglAkRXuAg+u1Ai9gANrwVuR/ioZZu9IvnBMPlNh2chIhU8gvt8gERlkv3MXcGw6t2WWiWNu0iBWfKEi4WfbwdPB1g2/eoViWi7AKatE0uL5sRLKMlYwZ2eczZfQK2MULspNwEgfQS0UvECoWKOMlaKXF53856E776Q9EzDPOJ3xKQ3qjONjC2z0MNtqn/lzOot5LL3LJjK6ElyYejaW2f7dfnx0DQtqay5v50UAW7ZtFzQg8c5eQq1zvW2HkKAIHdTde8IG5ArjRSV5eoJmQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(82310400026)(23010399003)(35042699022)(1800799024)(7416014)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	twCJCAVfrYi7wd3HiAZU0tmsdGiU7TkX85Ybdbf2vk8n5bVqbFmk9bl748/eNe/XhFSG5vndpq23voB5Z1gbwm6TPhIbi0KT5BBfbJFmv6DLR/7UswyEwbcecLi0kgogFfmiP0slSbbd4i6Jysqwp/I80W0pRX2AH4x83uUotbOvJux+22PvA+KrkFzf5snbm1rdiZ2HwIxfd2oQ8TKq5ta/dpTfuGrAxL6pElIQaZpH2N16Fzl9Zw4ApATS7pxc91sfCPTVKQpTo7mbQ3tMqy5F3aVh6t9DaVFuRMBTYbvpmjBKbprARZGOGS+3uiekras7mh147yavEDBYarQfwvHGlOZ4gsfe6DVcGKMy3wtk6UEinJIE1jICeWWRgQmdC372m+g8ULa0RRGeqLhl654XNABbJjw665lMfFvUaMJxH9DioVw53U56VND9emkm
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:14:45.9973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eacd6864-b6f1-4718-dd78-08df15760bf6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8648

Hi,

Preventing a write to the counter value register is correct, but 
protecting the ss_status is redundant.

On 9/15/26 12:34, Yeoreum Yun wrote:
> ss_status and cntr_val are overwritten with the values read from the
> corresponding registers by etm4_disable_hw() when the session is disabled.
> 
> This means that any changes to these values made while the session is
> enabled would be lost when the session is disabled.
> 
> Therefore, prohibit modifying ss_status and cntr_val while the session is
> enabled.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index cc6cdd3ae29d5..8d73248b840a6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1613,6 +1613,8 @@ static ssize_t cntr_val_store(struct device *dev,
>   		return -EINVAL;
>   	if (val > ETM_CNTR_MAX_VAL)
>   		return -EINVAL;
> +	if (coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
>   
>   	raw_spin_lock(&drvdata->spinlock);
>   	idx = config->cntr_idx;
> @@ -1797,6 +1799,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
>   
>   	if (kstrtoul(buf, 16, &val))
>   		return -EINVAL;
> +	if (coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
>   

This is protecting a write clearing the STATUS bit in TRCSSCSR - but 
this is cleared automatically when next time the hardware is enabled in 
etm4_enable_hw(). So the write to ss_status in this function is 
redundant as is this protection.

The actual write to the targeted control register will persist.

>   	raw_spin_lock(&drvdata->spinlock);
>   	idx = config->ss_idx;
> @@ -1847,6 +1851,8 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
>   
>   	if (kstrtoul(buf, 16, &val))
>   		return -EINVAL;
> +	if (coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
>   
>   	raw_spin_lock(&drvdata->spinlock);
>   	idx = config->ss_idx;
> 

as above

Regards

Mike

