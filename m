Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011045.outbound.protection.outlook.com [40.107.130.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AF3E95AA
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995131; cv=fail; b=JVzIpZfTCxnAbGd75XKNTD2eXruKg76DMqmRdYaN0tYJ+5ZYyaQcwbURprraXyLKUYdXYknMlBM1IcpZCiYuWNvDxTFU8kPiVyLkFrZy/1g1/hzU3flXzk4p4jlATL4yfvL+go0WTnXhMRqUzW0M2BGs7iOUxuKwe37WBLu/Z3g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995131; c=relaxed/simple;
	bh=KgioySNmhEIIxv2LH94m9teQoh1WM167t6nL1fafDwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hrz2gLKk67MdUTq72fz4IzP90wVW3qfotF/+3lB0hRPrWBCD14G0im5SQ3/ZyRMazQsXQf/Vy9+FGSz8WiqzQx2gpjdZxoBsbQk/arElNPg3bxLcEWpqFQoJw5B20pB2YamJBdSIP4SHtTm15ul+YhT1rhBi/pVpnJ0RGnLmoPM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jBqwbtu1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jBqwbtu1; arc=fail smtp.client-ip=40.107.130.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jBqwbtu1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jBqwbtu1"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=San4I4T64j92T6CnPxHOACmEY/PH8MaSQuLCFAnyOw3BKrn6H2PlnyvWVhdwAc4kFRmexpW25E2ixSutts1riny+JPNsYmWtOJj+Qa2D5qehLMetwLs2PSL5j/Kpit8leoPEitIchcZQyOXh6HxhJ9czz942j1NiBjRz+aTVSXEmSHHM/j22Fqi6KSx4YhYkxK7vdhAhE6eY22DZnUup+nopKCprcOKA5+FZPD6g17iCam3UQJKKA8Vf1d8uQ8M4UBP//Jqy0ATbVUEgTUxxNgpCg+KgcxpgniZXXAqc1CZrvpDlm7QtUKCVWnJ0h2C1KdPol6/A5NadGgfiSmc4UA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgioySNmhEIIxv2LH94m9teQoh1WM167t6nL1fafDwc=;
 b=w6jXpevLu4nyPKx7tJrKjmLC3q0CMxEFZxapkCmju4Qr+vXyQHF5UoOLy6vVCYvy1+afvxTyMKpb2AyI/bPSgtmoxlYSvXIBV8TY+3dVZ3Q0Dw3WSzDB20a71W54WExgBSXD0teVah9/6prCf53n9vphLrzuuqjjDt4H0Gps5vSiZ5i3/0xtjTS0i56+ckgwz8Mcvr7SQHsvLuWD1qtPsYjYRooHFJchHA5OUXC/DKhDsuVpSICSrOZPsJpm4w/nyn74h8jUc+bXkR3WMdokYHIn5W2mhPxWQwqC6/JZ89ZlsnXcIjlhc51IhN9AiMoqXuSHGYz37Ts3LXCW5H33EQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=os.amperecomputing.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgioySNmhEIIxv2LH94m9teQoh1WM167t6nL1fafDwc=;
 b=jBqwbtu1MQVh4UBejIKZXKT5u0bggBZAIVFmL+gEem/yjs4EQSFJ30cQZoC15bCiM49NhZwaAZo6z+ZBsnWGY9KSFa0Ha6vlgbkChTC1WDwlRcTD6aavW9sFC1wylqXE8sY+681uJ1tA02zMrXIMJ3EGyQU86NzC3w44JZF57aY=
Received: from DU7P251CA0030.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::15)
 by PA4PR08MB7521.eurprd08.prod.outlook.com (2603:10a6:102:26a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:31:57 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::8e) by DU7P251CA0030.outlook.office365.com
 (2603:10a6:10:551::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 11:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 11:31:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrrYSVbhHzpnbB9VPvzST+qCmuUH7Pa9JjOOWbXyShaIdM6rMS7QA6hjI+AEU8u+W6zubCxgwqZ2diuriZQNIQ0Yo4ssIaPOAY3UW/4HZQsSVAxQDgABD5suFEhXnMG+XXoGNrsj6q2yg5bQkHvk75HwKxrkPcjtkebW+Q5uNwW6bJ4bhYS8Irtjm3V3FM7upOsLDBRwXPTk5+RwdO4X+9YHNDBp3ttwgWSLXC0ioyn7DYxQ1ZyIXYhQJTE2sNnHXgbH1Kr+9fTwAeahcSoR82URTWKeWGLsMnPUMphKcV9HEpcsxLaIZsj+uNws/3+tigPRxA1XUaQC0ruTMGvhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgioySNmhEIIxv2LH94m9teQoh1WM167t6nL1fafDwc=;
 b=Tow3yR7/veoJq0WUqepXJQP91/lvFeOsEQJs9kdOR5U+wFCnF/KksSA7TfvtnNIdEq0zCTXnRTooHPTV6ZGBfTQTwC1Y5ZPjwod3gdxoD2o3WnLadXVnE/Z3uXF9+HAzhc2kbL6pfo0bKpYDf+CQXtpeXVHuj6bDI1DlBzNGAwNXSkxhEUr4B7yFtfDKcZ7m9dfjKft+P8hUbLWbOT7AY2vWaFpYkOAL4h33XztsQSqHOdnddN0CL3sZ7+X4luK1NMuOVNIhLbeejm3EnegT90oVCvbLxwj5/auz4eker7lFzGyzXcbuwnMFB48xFodoA+k08Qpf9y3S5+sRYgYI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgioySNmhEIIxv2LH94m9teQoh1WM167t6nL1fafDwc=;
 b=jBqwbtu1MQVh4UBejIKZXKT5u0bggBZAIVFmL+gEem/yjs4EQSFJ30cQZoC15bCiM49NhZwaAZo6z+ZBsnWGY9KSFa0Ha6vlgbkChTC1WDwlRcTD6aavW9sFC1wylqXE8sY+681uJ1tA02zMrXIMJ3EGyQU86NzC3w44JZF57aY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB6517.eurprd08.prod.outlook.com
 (2603:10a6:20b:31b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:30:49 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 11:30:49 +0000
Date: Wed, 21 Jan 2026 11:30:46 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, catalin.marinas@arm.com,
	akpm@linux-oundation.org, david@kernel.org, kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	chaitanyas.prakash@arm.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while
 splitting the linear mapping
Message-ID: <aXC45qHHYiAgZgKn@e129823.arm.com>
References: <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
 <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
 <aW+t8S1LfwX3LjRi@e129823.arm.com>
 <11a01f4e-9ae5-4001-9f9c-74a746f898cd@arm.com>
 <02bb61cc-f0be-41e5-b8b2-59768afd5254@os.amperecomputing.com>
 <aXCPHaylUbRJ3CME@e129823.arm.com>
 <ee2bf4ba-0121-44dc-a465-4c186dc18f19@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee2bf4ba-0121-44dc-a465-4c186dc18f19@arm.com>
X-ClientProxiedBy: LO2P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::21) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB6517:EE_|DB1PEPF000509F4:EE_|PA4PR08MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: cd72631e-72e9-41a1-67a7-08de58e0af1f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cklvVjZraFRjTEhzdHpoRnFPVVc0SGlSb2F6amF5cU1LN0czRnBIYTNMSXdV?=
 =?utf-8?B?elBrdS95TGRxdE05cVppRjVXWVFMamlIcVpzU1hmOVhrdC83OGM5MG1aaXdO?=
 =?utf-8?B?YXZzSCt6MGRPWjZXd1R2VzR6NFN6QjNrYnJaRlpVSjh6REM1UTdjc0kwTjNW?=
 =?utf-8?B?NW82eW5weU9uMDM3SDN4TzlFdzZXRUVDWTFEaFJRWFpLMkRzMTRRMjgveE9w?=
 =?utf-8?B?cFBWTHh2aUtEc20wTmpaN0FPUjFZWVdIZFJxeE1rMkdJeXJIbGdkZS9FL1d5?=
 =?utf-8?B?UWxyalNMem1TQmxyZURPSnBHcC92d0I2Y2ZUWDVhc0xlaVZqYWpoMmgwaldV?=
 =?utf-8?B?Y2hRb3FHdHRFTkt4cU5nQ1Z0REh3cWtFVVVKcFdqUHRrZ3BxYVl6RzRwWFQw?=
 =?utf-8?B?emZqdy84K3dVaWtVamNVa2RzdVVuNTNpV3JBa2RXU0dubUR4Vlp5WXJvYy9w?=
 =?utf-8?B?aFUvVllGYmErTExNRW03NzNkZ09wczNZdUNaTFlCSWwyeFNOMzF1ZWozZGEz?=
 =?utf-8?B?T1RCRUFDVzR2emNxdFFPeit3ejBENFZBYVZpSXg5aWlQY2FkQkhiQ3NaVzNH?=
 =?utf-8?B?Y0VybDFvTVVTTDVNVHdrcHAyNjYyNVhMVlNCTXRySVpiTkVYdnlrL04wdk8w?=
 =?utf-8?B?VlEyd0IrUFRQd0psZnI2V1FxV2RxRjc0WG51QzllSzRSYnNEUDNCQUpmNm43?=
 =?utf-8?B?Sk9yNjlQcUNiSDlvVC9xY0lpTitFYm5Vd090NU05ZlRhdFVadG55NDREZ2xD?=
 =?utf-8?B?RlBlK0RWRzhDOHc5b3ZOelZpR0dwUVlSTlJMRHRlOXVkeGoxNFVUYUx3cW1J?=
 =?utf-8?B?QnVadktRREx4QlZRcWxUdE9HMk9kcHNuMmQwenR4bVN6TG5ERk8ybStHbE9V?=
 =?utf-8?B?Z0JtNi9lVXdLU1puVm5hTmlUS0IvSmN5Q3NFQ2E0N2Z3TllyNHo2NFVvSjBQ?=
 =?utf-8?B?WVk5RDBJMGJoZ2hYMzBOc2tEUDlDQSs3Vjk2bUt6cGVwZjBwRkRrNFU1cFU3?=
 =?utf-8?B?VVgzOGkyd3VEUFVzTGV5NjhRd1VYYjdwQUlyRFZNM3JiVUQ4N1dEWnVMbElD?=
 =?utf-8?B?V3dIOXBNaVQzTC96dExmNEZvS0tIWHlMbnBwM2xHTXU1YTE3K1Robi95a0lW?=
 =?utf-8?B?R25lbG1wbHBzUDk2Z0lmTENEU3B0SHB0NkhKSE4yOWI0TlhjWEc5amlZaWlX?=
 =?utf-8?B?elBxMzR2SUwvTWtZSTNnYkFtNERKMEs0cU5XbFhiQlYzd09Tem9yUUF0ZlVn?=
 =?utf-8?B?enVXZlcwc3V6a1Q3bWVDK1N6R2JNbVJDUHRYYldZNUNmSUhWdFVZQnVpdVJt?=
 =?utf-8?B?S29HTy9JYmJKRkp4dDVoN1UrQUZ6TUVFUnFaSEhBSEw4ck95VDlkS3VEK1Ro?=
 =?utf-8?B?K1Y5Z1duWk1LdHFzS1JxSGlGSi9QRG8wK3gxYVpuUGFiVzVQNEpaSTdxN2Y5?=
 =?utf-8?B?YkFGV0hRem1sVlVwK3dsMk5oaHEyUUFXanl5bXZJa2Fzb0p3MlpuclFienF3?=
 =?utf-8?B?dmdRY0QxVTVEdTBLa28wa1FmckZjMUZnbEU3Z2RtVUNqR1NOeWhkUWxUVUQ4?=
 =?utf-8?B?a2dmOVRsY1JlODJpZ0tJT0pkaElPekw5RWljTFNiYVNtRzdmMyt2OCtWZ3dR?=
 =?utf-8?B?bjFJOVQ3TXNyaUVsMDlpcVJYYkpndDh1dW5OUk8yb0ovcDZrTTQweFhuWUor?=
 =?utf-8?B?Vk5DU0FRWGdSZFp3M1lmV2VRZ2l1OXl2TEpaQ2hsQzh5K2NnaDhUYUVoRUd6?=
 =?utf-8?B?Q1hodFVGcHkxSnBCSVlnQitXdmphZ0hsb3ZTS0xPdHdtcUtqdXpDWTVwZThW?=
 =?utf-8?B?WFZjV1BoczBNa2dtVmhBNVNMRkRsUzF0b1RtMklGOUJCVmpmbHVPbExTMTh6?=
 =?utf-8?B?NG85cUhVLy9BalNIK2FDYldNdlBUNzlTRzRLSDRwUWk3Qmd5QUpKVDNlVEdJ?=
 =?utf-8?B?Rm5YMHh4amJkNjN5akVveVQ3UWdxditIVHU0ZDRtT2xJT1RIMGsxb0o3dEJs?=
 =?utf-8?B?SEN3MWlSaCsyMkd1Slhqdk1SVnMvL0pZMmRIc0xrQXFQN3V3cUh1d3UxaGIv?=
 =?utf-8?B?b3RiRjlMNTJDUE1RN2UvNWhqRHV1WVh1ZnRhS0Qrd01PNUhubHBJVDFmNjBp?=
 =?utf-8?Q?Ogv0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6517
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	59a0d74a-c429-4f0a-202f-08de58e086fb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|30052699003|36860700013|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkQxcnVMSkI4WGVpTHJwalQ3cUlETzJpS1ZyUlYyK3ZaT2IzZ0dVMUNKMTFt?=
 =?utf-8?B?anNaSXcwK2puZlNzRlRFZVRPc3o0bHpyUXBkR21Da2lPeW8yRk03OHlCMzlN?=
 =?utf-8?B?UWE5bWVaNnBiWkFoU3pXVFVKRE5TYk1kbkF0YVdvQWcwSXRoUUdDVXZOditN?=
 =?utf-8?B?Y2RYQWNhSkZXRlRSc1FLaU94Q01sWU9xOCtVTVhueWFmcUtSbkdLL1hldzJv?=
 =?utf-8?B?eHRzU0JWR3M2Y2l5V2hQL3lHdXNLcVlxU0lvaWlTbExpbW9MOGUySldVdk1t?=
 =?utf-8?B?azRuQ24vdC9CZGk0VW9kbUhBWFdXUit1UjUwQngxTHdmam5JQTBuK21pc05m?=
 =?utf-8?B?RzFNeXhYcVQrK2FralRERGFyN1hSTDF4MlpOc0RjRVpiODlBaHRFcWZ2ampT?=
 =?utf-8?B?aGhBR2VlQkR0R3RyZ3pRblRyQjFCOC9rQWxjSFN2eWcza3ZHNEx6U2w4TmtE?=
 =?utf-8?B?NFk2SUhWOGFiR0pyUHZKWUdJZW84cHJPb09KOSsrQ3Z1aHR6eUh6bDd0cnlq?=
 =?utf-8?B?T0NqNUxSSmRzVTFIbHBONnRmRjQ3SW9pbEV4bzh6R2kxbEhteEdHQlIrR3JK?=
 =?utf-8?B?STUrRUg4Wk9ONkZrQ2U5SlplVjJvUmFZaHBWNXZQUlBJS3ViOG9pMmFoZjE1?=
 =?utf-8?B?bUpUcHBSY0FybXY3bDArc3krOGZsR2hHSVB1NjZ2SS90dzd3QkdGYURXZ2pi?=
 =?utf-8?B?cHVVVEVJK3hUYzdZd2h6ZEVDZDhISjAyRGE3Skt2YzhpY2ErNkVZanlCR1Q3?=
 =?utf-8?B?RDM4YXMzWC93VFJzQ25ZclJkRGhTS3EwNGxuZ2lDM1dmWUFTaW8rak5FVG5F?=
 =?utf-8?B?aEhpUUdyalU0UnJIc3NacDhKREpZQ3VUNWpldEp6OUdzUjR5RDBzbXZTTmU0?=
 =?utf-8?B?bWpDUnJiMGxOWE82U0dLQWc2UGZqMHpud3JrSEVmcFA4R1p6WjJzMkZTVVVE?=
 =?utf-8?B?Tk1QMzZrNXRoNmc5ZnJ5eUhoTTI2WjJtODdnaCtYZmltUEdzb1VKR3ZsM21Q?=
 =?utf-8?B?NW5NQTlkOHEvYkVENVhjSGlqYWliTklFem5ZRHlrdzI3R0dVdGJzM2lNVTU4?=
 =?utf-8?B?RldvQ09wVnFXWFRuTkZ4Z0VrQmFnZFlqU2dzTXNyMzJqSFpUNEwwTTFURkpa?=
 =?utf-8?B?emFsTmxheEVaMUlnSUo5bWx6LzE3WHZBR2pNVVBBcGJqcGttVzZmR21qV01C?=
 =?utf-8?B?R21NRUVRVkpPSVhzSFA2Y2ZuMHVKZzJScFNVL1JoVE9iUHBKcWRpc0x2Q05w?=
 =?utf-8?B?MGpRNWVpZmhRTEFZa3dXSXdmcHF6R3M5NHF0RXNHUHVMcjJEZFl6OC91eEVP?=
 =?utf-8?B?Q29tWnlYakdBVThreUU0SGZRQkdRVmJMdENKUFlSdWdqWm9BU3V6Uzg2cVY1?=
 =?utf-8?B?UzBHeVpsWFA3ckNWRVQ0aGlQWnJFdWFNTmZOcXZwSW53bzhsZWlPZkRydm5J?=
 =?utf-8?B?K1VENElwMm5KZ3RGUkRkai9VODQ2M2FYK2R4TG44cjlpWS84UWFPZlpyZUNn?=
 =?utf-8?B?YXpFNms2M0NIYk1uY2dvcDJxclhjNThIaU9KR2xnN1hlM3g1dm1qNmpnRm1N?=
 =?utf-8?B?b3RyVlk0dXBWbHc5WkVrcXJaMVFwNXZWTHNiMEhtZ0JmWUo0YWZ5U2lVNSsw?=
 =?utf-8?B?bnhWTHpyMzlxUWwzMjN0LzFIS1JlTlk1bk05Z0IraUZ6TFptRmZlYkxGNk9H?=
 =?utf-8?B?STkreVJyd01CNTVnejluVktnTS9BY1Nzck5EdURkdml3ZWtOTlFyc3FMcmly?=
 =?utf-8?B?VXpGTDhocGFWa1J0VjZwTDArUWhNRTFVYkhBUkk2Szg0MXk5dUppa3orZXlL?=
 =?utf-8?B?Q2pDTzZGV2FLR2Y0Z1h5eDFaU2lpNHQ2V2IzbXNXSlNkN3YveG8vNnJMYlhG?=
 =?utf-8?B?STF3S1pKMGVEU3lOek4wOWVSNDgyTHpDMHpSVHZHNmJkWkhnSkZSUXkzNHNo?=
 =?utf-8?B?d1RVaWFiZk54UWRsSUFGSWs5ZmQ4dnpGejh3OC9Bb1NhRVAzZFFXVDhTRGJ6?=
 =?utf-8?B?dlFpTzRTcm9OZkFoQUZYOEk5T2hYVllVMUc1NE14OXJmNXpPUGVzdGNMT3JL?=
 =?utf-8?B?VVZ4eFdLeW1JdG9WZGZrWnAyeE5xVW9LMFJjMWgwajQ0ek5PNGoyeTEwODZY?=
 =?utf-8?B?enlKRkVIS1BmUlVIMENvZnByY0pGY2FJMzAzcGhsbzhSKzRDd0NQeStRZWtW?=
 =?utf-8?B?Z2hOd2lCaHh4TzBsblN5WGg5NlJRNmFEaGFUeUxodTh5bGs5M2hKZGJXanZM?=
 =?utf-8?B?TklFaE1wU3JYaHV4SHJuQ2JiN0R3PT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(30052699003)(36860700013)(14060799003)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:31:56.5974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd72631e-72e9-41a1-67a7-08de58e0af1f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7521

On Wed, Jan 21, 2026 at 10:20:52AM +0000, Ryan Roberts wrote:
> On 21/01/2026 08:32, Yeoreum Yun wrote:
> >>>> My concern is that if a secondary CPU can race and cause a split, that is
> >>>> unsound because we have determined that although the primary CPU supports BBML2,
> >>>> at least one of the secondary CPUs does not. So splitting a live mapping is unsafe.
> >>>>
> >>>> I just had a brief chat with Rutland, and he agrees that this _could_ be a
> >>>> problem. Basically there is a window between onlining the secondary cpus and
> >>>> entering the stop_machine() where one of those cpus _could_ end up doing
> >>>> something that causes us to split the linear map.
> >>
> >> If I remember correctly, split_kernel_leaf_mapping() does call
> >> system_supports_bbml2_noabort() before doing real split. So we basically
> >> should fall into two categories:
> >>
> >> 1. bbml2_noabort is supported on all cpus. Everything is fine.
> >> 2. bbml2_noabort is not supported on all cpus. split_kernel_leaf_mapping()
> >> just returns 0. Kernel doesn't split page table, so there won't be TLB
> >> conflict issue. But the following page prot update may see unexpected block
> >> mapping, then a   WARN  will be raised and it will return -EINVAL. So the
> >> worst case is the caller will fail (IIRC all the callers of set_memory_*()
> >> handle the failure), and we can know who is trying to change linear mapping
> >> before the linear mapping gets                    finalized. AFAICT I
> >> haven't seen such WARN yet.
>
> Ahh good point! So this isn't quite as terrible as I was thinking.
>
> >
> > Thanks for the great detail :)
> > I've missed system_supports_bbml2_noabort() in split_kernel_leaf_mapping().
> >
> >>
> >>>>
> >>>> I'm not immediately sure how to solve that.
> >>
> >> Do we need some synchronization mechanism? If the linear mapping is not
> >> finalized yet, split_kernel_leaf_mapping() will spin. For example, something
> >> like this off the top of my head,
> >>
> >> DEFINE_STATIC_KEY_FALSE(linear_mapping_finalized);
> >>
> >> Once the linear mapping is finalized, we can call
> >> static_branch_enable(&linear_mapping_finalized);
> >>
> >> In split_kernel_leaf_mapping(), we can just do:
> >>
> >> retry:
> >>     if (!static_branch_likely(&linear_mapping_finalized))
> >>         goto retry;
> >>
>
> Yuck... But I guess it might work as long as the primary thread never does
> anything that would cause an attempt to split; otherwise we have a deadlock.
>
> >>
> >> There may be better way to handle it. But this case should be very unlikely
> >> IMHO. It sounds crazy to have such complicated kernel threads run so early.
> >> I'm not sure whether we should pay immediate attention to it or not.
>
> I think we need to figure out if this is actually possible. We bring up the
> secondary cpus, set system caps and finalize the linear map in smp_init().
> That's called from kernel_init_freeable() which is called from kernel_init(),
> which is invoked as a thread pinned to the boot cpu.
>
> sched_init_smp() is called after smp_init() (i.e. after the linear map is
> finalized). I'm guessing (based on the name of sched_init_smp()) that nothing
> other than the idle thread will run on any secondaries until after
> sched_init_smp() is called? (I'd be greatful if anyone can confirm that).
>
> Rutland suggested that it's probably too early for any PM type stuff to be
> running in the idle loop, so based on all of that, perhaps this is not a problem
> after all and there is basically zero chance of a secondary cpu doing anything
> that could cause a linear map split during this window?
>
> I'm inclined to leave this as is for now.

IIUC, since it before the sched_domain creation yet,
the wake_up_new_task()'s cpu selection via select_task_rq_fair()
would be always the same for prev_cpu. So I agree with you
this case would be a zero chance of a scondary cpu doing anything.

>
> Thanks,
> Ryan
>
> >
> > Thinking about it again, I’m not sure whether
> > it is acceptable to use a sleepable synchronization mechanism at this stage,
> > like split_kernel_leaf_mapping() does with mutex_lock()
> > (even though it may be technically possible).
> > It also feels odd that this function can be called at this point in time.
> >
> > If this is indeed considered problematic,
> > I think it would be better to simply return -EINVAL immediately
> > when linear_mapping_finalized has not yet been completed.
> >
> > --
> > Sincerely,
> > Yeoreum Yun
>

--
Sincerely,
Yeoreum Yun
