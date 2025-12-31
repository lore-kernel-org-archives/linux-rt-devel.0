Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A6830F924
	for <linux-rt-devel@lists.linux.dev>; Wed, 31 Dec 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767175727; cv=fail; b=f5SRiSbR3sNxY/0ziEF36giqqH/sdc/5K0K2KmEEV3YNjD20JyIcEN+9n+2HumxKotoF0dgkhdntFE1+fBOwOZXlrr+FI3Iq1YHR8wB0i5l3gnjQQiZh8I7gQx3JC5hWpGeroky6fBd+SJcMYRneV10ZhhFb8UIOP+ENQwD9Qtw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767175727; c=relaxed/simple;
	bh=o9wt8MY9e0obS9izx2AuVOBkuhxSBDkN3AYANV5aMko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EjX9o9Y/1LTmeaW8ivgHNXQCEpS4qLA4eFF4HRRvfBgfqnvwhNIHG1nB7IBmYt+mf6T8z5VmvW1HQ+wf4qasz+iP8xicuzSstxPEsjPQR9fFU9MW3Om6BB6wDiMjEYnvpPeL4zmRWg43POKRZZWz6wHR3fW5un4wgpSmNC0rp94=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a32WJqhq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a32WJqhq; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a32WJqhq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a32WJqhq"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZHNOor+48S6f0Pz+QS4Rp5R2exdQFVu74aQV59mZItvlilaruIcC2XAjW8/jI8/g4fJJaY2QS0RI7UifV4Gl7tuyHaVAHp9e8cuitqcZFvjHvYf5iojn8xBRHQfe/Gt3O6ydBCAQH6zI4ZCj7W7S7apGS5Gf6aO+SX6lm5IumFNue+rEuB7AeDTTCiMWANSpH6/j2YretPa4W5qC6pEKCeI/GaraIbrJ8n4tcCy5BcPChOKPUQkBmoB6IWCElfTaj/rrJx1hL9z8hnWyXXoZ3ODK0tYtzMYh6Vm7oSvCJt5ty8happNSOIdLbDngtK4L5QKqamVFabzECTuzhpnrsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGTwVr1QlsNogiOSgBIRjHArUYB9aHuXWyIaDdkMV3c=;
 b=aCf1XJYppzMEPdsSWqIzMhESSOsTgsHYGFwtu+JDplSsUrRCzQrsIV2RQYJ2HRjSJfvNZvcqD4kcr/4Hl2A94wY9x0zMFknIO1eoppU+6cOhnaIedJhw25BYFfIMT4pWoEE9Fcx/baxIJt2dWVFF4mRwMvImdGYKX+kxhWY0FCGRTaL6J5PsM5q8c1bQQwKrZiMo8CfIgKGw0iARJFlyXVjGawiN7Q/ZSm2eTG9W9TPj75JLlrT5WDGoQfqp/0SKfxjK3BFyJwGkEgwXvbkewtjHtJher+4Z8wDlzuWVlTNkt47lD2Mkx1F+VWrbA8A0z+U7ouJO6PYyG0lncKU9bw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGTwVr1QlsNogiOSgBIRjHArUYB9aHuXWyIaDdkMV3c=;
 b=a32WJqhq+cVcXx9W+Juy1tv07+gGcwDqIBWtegvnzjBXRnZUC1b+zFb+jOxjoFIgxFZ+GE6e0eS6Ocm/9tT4KflhGBgh6tQX2wPVTWW4QCxzCG9N1HZTkwB3sz3HyGvfWi5YYdYn6xHuVWMo5nbOI0xmstqT73mvBcl6kl2phbM=
Received: from AS8PR04CA0156.eurprd04.prod.outlook.com (2603:10a6:20b:331::11)
 by AM9PR08MB5972.eurprd08.prod.outlook.com (2603:10a6:20b:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 10:08:39 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:331:cafe::11) by AS8PR04CA0156.outlook.office365.com
 (2603:10a6:20b:331::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 10:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4
 via Frontend Transport; Wed, 31 Dec 2025 10:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnnsZk5xFdHM79EamDqatvAEkBYOelGBsezpGwxDwskYkTbYLdFLb9F9V7sWXd9tli/b5P30YYM6m4WNHkXz8BibVyp1tFseWRxaeemjxOKpRgjmUgfqx/wfHOgHrNFL6mm0Fmu7fUvIbAnLj2Bjf3BzDv2uxiRstsgJqW0DgGlsp0CcIPxKM5vWnoJx3e056vYX9HRW2FeU+61JIuqN38yXVaaMWPCF6hUIwD8TFbRCV3M9B6G+psUMiUaeK0GnG2J7DiT9sCeyfIDlX87Ivq+OQGiyXAXvgMNtK5SuiIitNbehKUpkQWtsq77UFYAtWX+DdT1voBafnyQZ0nfTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGTwVr1QlsNogiOSgBIRjHArUYB9aHuXWyIaDdkMV3c=;
 b=d5K2+ySZpFvn57EaWAw0c2iyCwCcErnnFC9q8LdPnzEIj7JzWQSw+EF90NnwJ9r5gdL5bxXLRyTixfbXGGNOkU9LYtaLcgSjbAE6Lj/xqwA43yf0QO3OLyYbhz2p/xucyfSsryio8kaGvtWb7NypUIeUOXum9lkdJitvJHjbOtKnf5btmC04yZeVuAgDQ62b9xQdwn5ffrDzCp9uvJSC2AgNuSeudKPzzdqHSKgGeylDzg/07QtUHImyQCkmKnz/uDCpOIZ6TnVNV/qB8EHjdvTlQwVEA07cxBXZ7xgkmjn5/J4TPy66lQGn5+4BpNezWCZNGNTFvcmhyXpdEpBD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGTwVr1QlsNogiOSgBIRjHArUYB9aHuXWyIaDdkMV3c=;
 b=a32WJqhq+cVcXx9W+Juy1tv07+gGcwDqIBWtegvnzjBXRnZUC1b+zFb+jOxjoFIgxFZ+GE6e0eS6Ocm/9tT4KflhGBgh6tQX2wPVTWW4QCxzCG9N1HZTkwB3sz3HyGvfWi5YYdYn6xHuVWMo5nbOI0xmstqT73mvBcl6kl2phbM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB8970.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 10:07:36 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9456.013; Wed, 31 Dec 2025
 10:07:36 +0000
Date: Wed, 31 Dec 2025 10:07:33 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
	akpm@linux-foundation.org, david@kernel.org, kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 0/2]  fix wrong usage of memory allocation APIs under
 PREEMPT_RT in arm64
Message-ID: <aVT15bhN4hEBNaOg@e129823.arm.com>
References: <20251218194750.395301-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218194750.395301-1-yeoreum.yun@arm.com>
X-ClientProxiedBy: LO4P123CA0393.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB8970:EE_|AM3PEPF0000A78E:EE_|AM9PR08MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 5428dcab-fe7c-40d2-5d9c-08de485491f7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?PLs72Srae4RF3S14zG066ppNx+YLr3jm0dlqLSt2e8GejJ/jPS3rxdtPukyY?=
 =?us-ascii?Q?PbjBFyCluLPzT73kf7U/Fs3Ercs5c9M6CMKGkmwyc+ITjcynpigbMpOW+mUj?=
 =?us-ascii?Q?8wxNjoExkkxFOCxV5cruNqxJzjq2rLvaAjxc1LB8W9Yhknv+jweCpSe5qlJH?=
 =?us-ascii?Q?u+hkeZ1W2MS01E1YaWHkJREUpGEq0y0GeBMZg96Zvs0hQyGM9uV1n5fiwWPF?=
 =?us-ascii?Q?mWXNnh1iVeBvRXTdWeZtlz4yAvUPFUOWe49YCbtdfoHoDrEX+eHrFwxCjrY6?=
 =?us-ascii?Q?G7tBfkV1mvCPsD5A1L4v5VNAme5T2DyZFaAY6LCOR8FfwPZmS2dHTJKHWsO4?=
 =?us-ascii?Q?en8nxUuAGODv7Qj1y2gVlGalShQJqk9DUcqUD+mUBvF810Is+oiUU/stW9rK?=
 =?us-ascii?Q?Lf5VSU9Snr8zEh2hhd5/dwh09Xc3srDaXQ0Fwj0oJ49fjE8G3S+2r7G005Mr?=
 =?us-ascii?Q?MpWjHdXayA4gg/WJG8apHLjSjIRFXqogNDl5f6Z8R4gmkWj7m6aSeTG76xd3?=
 =?us-ascii?Q?X+KUAZWIHVGRaY49Onyzj9hF0JUwMsJHHQM09ON6ygyagiz3eaNU2/v20tul?=
 =?us-ascii?Q?mHpYyvpxb5iSg2NjstlR9st3lHdTTurWlDTXTPkfouNKrF/ZE/Kwvsc2FfBZ?=
 =?us-ascii?Q?CPMoZKSEiKvnYITLsUYXsKFmwjJHsh6IjWUd9sBc1Ysb1tsrZeRGZuxVO5Ap?=
 =?us-ascii?Q?Y13s9KvoGUWfKtJA2ZFXcyR9nd5L2SY1+fYXoVxbZzPs3vCvlaKUheKxTILt?=
 =?us-ascii?Q?S1yggg0eT382tqqnfBl/TAh4guet5D5eWY4IzJIZ7Lv73fQn5+sCyxNbV7CP?=
 =?us-ascii?Q?OPxkE2Ho4klBDmodrZ0LAwA+1LnI9D3n1hxY82NKDIfl20GDJKi1XUT2zvjs?=
 =?us-ascii?Q?nOYsw97zHLOdNGYwfndFOo8dpDUmtfPYk7AyNRTsylTKsuBqqBpkklXhRq2l?=
 =?us-ascii?Q?PjaGhq/yCpdf5XtuMp/RbpJytz609QZZHMUr1DPteEEwA+J6ZlLsteZw4/va?=
 =?us-ascii?Q?QCQUniZQokHj+vOUECfwDibepCfJWytZ13sA58q7Y8dYrw0XXMhCdiiaSAzV?=
 =?us-ascii?Q?IILDHdKYBd7yM941EQN5p4AdDPQ9eo70C3EiHpF+y9BUQy7DsDp5mZ947d+V?=
 =?us-ascii?Q?yjzxQLROna2CeLw+H/DYTuANlTdrdAF+sb+PNCVQ9DAOBKlgfIBhjHvS7C27?=
 =?us-ascii?Q?3UMDnvJCIMWEtqiChVQ5CifjNYiuDdcOEb/zT6uxDc1ZtgVNeKGoL1LBNAn9?=
 =?us-ascii?Q?/YZNw6OTUAWbSB3aMbzsAzaqk7m8Tt8uT0wYj4Xn1PGZ09AKkJO86IA8vBVI?=
 =?us-ascii?Q?sWfUcB/8y050wIVZ2NmfYSqV6YUwkuTzi+QZjTRnUscZPMAR8KXTSZxLwraK?=
 =?us-ascii?Q?sRtci6wd2ufmaVCI5mCfBHgkma7ar17HfY+cqO9aYNXC1KKa//Ns/0cDmhSR?=
 =?us-ascii?Q?3PfSM8Tv/6nFU3xWSPc2T1QA7yOrvj8ubZYUL1xImCK4jRiSOTlVOqL2zIsF?=
 =?us-ascii?Q?D0AtI16fqpSCwbDWTI9ehoM8KuT8HC2AJ3jh?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8970
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d26c49ec-e01b-4cf6-31e3-08de48546c2d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|376014|7416014|14060799003|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NUTkni8icGr+lCHpBI08OR4lTMc8kFuScnrBFNikpcqsXvDlx6eOtwV081TW?=
 =?us-ascii?Q?bWPgVB2rfvPAY9YIp84pJvR0DKShiPZNa6kbs8gOl+QHiW5RCeD6/8gd+hTl?=
 =?us-ascii?Q?f54mIII55JmGFyr8vMTRsz/EBV2eNN4Qu0mYZlWIYiH77jqH+gVU1qCVlrRm?=
 =?us-ascii?Q?DGXKYYVfKKTDv0ajsoWOGUS+f5wKBqetnaUcodAPGjUBznK/PzvKhNW+uUB3?=
 =?us-ascii?Q?TAFoCoKU711Qz11Y/9NByqPx0TOkmsnowvxiPb8tGPXmv0hHqChGEo/XnDjf?=
 =?us-ascii?Q?kVhwUgPWK19kxnrvOrAtqBOK8CC1xNMEGvxqxUZPQT2YbiMnmAHsCU2qGo8h?=
 =?us-ascii?Q?lwjsLaA5XhANoM6DQyCKTBmvyLTiHBHBZAsB1oZRltEoLLhRb2+8+CUWq+Cb?=
 =?us-ascii?Q?iYIbV7VnQURzSWoW9PdDVGNp/BkCOJpkKwE99Fc/r/NOq6rJqbnPI64b/mQd?=
 =?us-ascii?Q?qKZPg74Hn43BIU2qY/2aYoXWRTGZeBFKkhU/KBe0OvPmsgA/YHHKIDsl4AL8?=
 =?us-ascii?Q?56NtaE+HiJeDTmgGINQslZa5tZS+NyXBOG1xaxg3gqBuWVzxIUyC3YDNXtLa?=
 =?us-ascii?Q?n9kCpZwiobxC5N40SHOWZ8xUNPXaxkQF0xH9DUW3OdvPIjd30e47DmBp17EA?=
 =?us-ascii?Q?TVGg1m+I0Nh+EA2YgJTO0GaILiEJObOvZCw/zNrzEzM3SNOABo7Y6NsAGKeG?=
 =?us-ascii?Q?fYC9haD3odm/E3v+NrFLxlEYQQAU12AwYUlNBNBJZ05U2PLF3JhpFN3csXpS?=
 =?us-ascii?Q?w6HffRmf/qPnQ0jSg7lhChDOjOEj1hXGapK7c8kbV/GR93SPwYwFlaRCbn3z?=
 =?us-ascii?Q?W+uT5LGapIIlPC9auPMNOt3VqtV0EQ+KlHGbSu/Dqa9mNQLpb+VTieBIEJor?=
 =?us-ascii?Q?CPqearMVdGwAc6NDyIfKqtZRrlXycodC7tAglgMANCOwNwGrPpBJWLvjAt50?=
 =?us-ascii?Q?jIB5AmE8l0NqK1wif4GkA/EY3QUs9nMcV2X+l7h6MbnOqcByBr4tK8mL6KKR?=
 =?us-ascii?Q?i6r468gkVt7a+4FaKIPYlK/WSxz9xTIiItYyYSv0lGNApO5ZR1vSD0qepvWz?=
 =?us-ascii?Q?4lK8wsh+/6MSXxabLJV4dWYLmqZYpvpdu0aWxSNocUtqpXGJ+sbEpxZeUhs0?=
 =?us-ascii?Q?2DgXDRVJwGqq4NxSiOdIX7K71b1juMe9Rts7xCfIhzksxkykw2jAUaLCKM+2?=
 =?us-ascii?Q?cfLneP705rVkbtgGPgRNYF3rS05BpY98nNQ2C0aLLxolvTk6FL9u+tuH0wYG?=
 =?us-ascii?Q?aOxw7+8RB2LpHiMKkxugFJ944FfUsVRQ6yh5b9j2LQYi9thPpZ1krQL8/mrx?=
 =?us-ascii?Q?4BpE7cNXSQNLIwhISjLw+zyp75Pc5rw920CEOORHUZlCLQIJWbOyXM3ooU/N?=
 =?us-ascii?Q?vT95S72zxINKtMghh8h2yq6In/mDePAKSZHDjs4xYms+bPbKHt/n44TQ30yN?=
 =?us-ascii?Q?Sa4gbmw/o9KrhC04imb691T2dD+dUHYl/4W6YOL/E4PMvI9bL2vBRogn5srs?=
 =?us-ascii?Q?zTOOgW0JMgOtj7sbOr5X2iFEIBrxfiBWRSrue2iA+TSu8wDIpTRYYgYsuoqi?=
 =?us-ascii?Q?fF7vThgdBFAv+Zgoa8GrLisGeaiXUSuhVtMEun1ENsxmAkt8Y8c2aG3bl/JT?=
 =?us-ascii?Q?Bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(376014)(7416014)(14060799003)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 10:08:39.5598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5428dcab-fe7c-40d2-5d9c-08de485491f7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5972

Gentle ping in case of forgotten.

On Thu, Dec 18, 2025 at 07:47:48PM +0000, Yeoreum Yun wrote:
> Under PREEMPT_RT, calling generic memory allocation/free APIs
> (e.x) __get_free_pages(), pgtable_alloc(), free_pages() and etc
> with preemption disabled is not allowed, but allow only nolock() APIs series
> because it may acquire a spin lock that becomes sleepable on RT,
> potentially causing a sleep during page allocation
> (See Documentation/core-api/real-time/differences.rst, Memory allocation section).
>
> However, In arm64, __linear_map_split_to_ptes() and
> __kpti_install_ng_mappings() called by stopper thread via stop_machine()
> use generic memory allocation/free APIs.
>
> This patchset fixes this problem and based on v6.19-rc1
>
> Patch History
> ==============
> from v2 to v3:
>   - remove split-mode and split_args.
>     pass proper function pointer while spliting.
>   - rename function name.
>   - https://lore.kernel.org/all/20251217182007.2345700-1-yeoreum.yun@arm.com/
>
> from v1 to v2:
>   - drop pagetable_alloc_nolock()
>   - following @Ryan Roberts suggestion.
>   - https://lore.kernel.org/all/20251212161832.2067134-1-yeoreum.yun@arm.com/
>
>
> *** BLURB HERE ***
>
> Yeoreum Yun (2):
>   arm64: mmu: avoid allocating pages while splitting the linear mapping
>   arm64: mmu: avoid allocating pages while installing ng-mapping for
>     KPTI
>
>  arch/arm64/mm/mmu.c | 254 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 197 insertions(+), 57 deletions(-)
>
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

--
Sincerely,
Yeoreum Yun
