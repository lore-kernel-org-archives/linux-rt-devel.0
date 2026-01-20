Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72A338929
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926784; cv=fail; b=FgBFfqyPJeuL5cjaxIdhmYQDRUfJDQs/kz6pYAMtlzBECW9viJkfThOZ5Rq5AZVE2m0sge8iGxZ6hkfwx8bu2teFefHrXDOQ1mjuIeo3NhAL+9lCU3IE2PnWiDTSHlqtHg+FbLHqs7j4t/SCzxZlhD0sjFdhqS1qiucxGthCWGo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926784; c=relaxed/simple;
	bh=c0bAd0aIb4rw7Q7OJNC8VjVGBP4X2k/iVxwdG650acM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OQhvsv0Fn375MevDRKK8kDwpzCAbK4VE1DQT3OZh/gJ5WjxfLT8wB7Be7MbQyxj8dgI6RJ+DPvZSQt5GAOZHHeVmwY18Nph7zsuSLPR6AWI9JmoSn4RXO4oeD4xbukrtYqbham6bIPPnsNLMHJkn1sKC6wZx36yKj/zaLpNndqs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fw6bd8PR; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fw6bd8PR; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fw6bd8PR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fw6bd8PR"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=grfEUCxzaqyBIJTM2pAz+zBgh9Sdrulao8tEjQr1sSxQgaqoSNdWO2vLX50/hyvNwcv8ypuVelZTvWMRtvhLzbk0nsUG1h8nXtYQjjtQEBK83DANDnjL5RaTSObA7aDaNzp0bmzdnvnLhwPHYdbHsh5ykbGsbaw9BD9jA02jROO4dKrCtKkQSROp1zNSHJzOIu8Q255D9YsK44O8rZYfMLYMbcG9iZ54JZFCGOr2YsiLIynP0UfY4thrBT7ED/JJii3SctOCn/xHYrzs6ddqyZLoeqmNahp98GMIH8mhUvAOwHkPJn6B3dxnPlUllK4/eSS5LWtTvpYhmsBQGwgocw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQPHako/RHiRd6nQoZT+bT7e3dEUrGcEfQWtcDVBBGY=;
 b=Xr8nie0M+DPNommHpVpaEu/urAtM7Jf+lIB3TnWvZNnQXiUD6ROy/x2EwdZifCBeQrofSOPTmnijmDvUiscLadI5DOpu6xbiJcFXxUj9w+fTNmbHjZ41ylnmO/MTLaU68vrP3nvLq+VIU1GvhffvcKjwZG5OfLF8xfwqJENZKfIgojM8kQX9jHW+ZiyeYB3Rk/1DlG8yft0RL6OSOf3Jrpy1JmTZ0taly4O1uyDeaMUEIfX8e55FffGJtNyeSlat0ZRaMGhhfirrT+AKt0Na8QRPONoRcExUBeOOVu1pF0QO4a1IgXFPWe/h2yr4zmtaJabb3z8CMlPz8YEubgaJaQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQPHako/RHiRd6nQoZT+bT7e3dEUrGcEfQWtcDVBBGY=;
 b=fw6bd8PRxmB8+uam11ob3qDbfi8AH9ZVaC3qW/VoD2ymJbikyzYmh8I+NJ0KC7ZMCIOrxkwg2yhowVY4/KgM8PIQUcyL8DfH+N2ElbN74OvuR6vRGpV63SANACcYxTutiVmHb1ss91jkDo2aoTLwksGHcKst0uJIy8bZZUHeu0I=
Received: from PAZP264CA0152.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::10)
 by DU2PR08MB10040.eurprd08.prod.outlook.com (2603:10a6:10:49f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 16:32:52 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:1f9:cafe::1b) by PAZP264CA0152.outlook.office365.com
 (2603:10a6:102:1f9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 16:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.0
 via Frontend Transport; Tue, 20 Jan 2026 16:32:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR2QeA1AjW0//3zjdiOic2E/FLyQIwSiAwjzolYw9KjGjWZLFvkadorxHBLlkqj/AMaGNHumCPJ139yO7TCW7sqyu51wr9cx4twfvgohpKa1QahmE10pd4CdInvGxSMab7THyNXr3YKexNhq3n7ZXCTSGk7FMFKDeDDklpQnSs3tq5owGG/GO57D1osHvVHb+0WLgZw6wMhroiwqrrQkc2ITJHj0RAVXwYYkOAaEluGng8495vfCvl2+hWA/khEdw0Uu6dXenY07eSmCRcxh6DmbQSRwZY5Mt1LS85CPKFfOG1kjevZlQrdrXIjKd4gH30A1IdVf6puAvq45j2aTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQPHako/RHiRd6nQoZT+bT7e3dEUrGcEfQWtcDVBBGY=;
 b=aozDyfEFeK6/B8X0VRmQBcpU5PEo1JP3FmUT+79aVR865kvpfQP+W5Jp0amN+Bt5lhSBwUUeRob1zo0ho38JfqW41qgqQRpA0wAC7O3cjvb7ka5Aa4zgeQYU6SRjV50OPDKjFxJGe+XOK2AhCWBY85OLcdmykGF9rri3xCIurHdqb4uk/PjlJPZbt0SOBMOsWRUt/Kur+GOt8FkG5GeNZ6GSdoLnEh7FuwUnQOxBxUmhALbaYd8ZkrW8xkJjk7IEXNNN6KrrjpbgI7xask7fqJLSmx1yx+Ld39K+kJMQLZB+vw2aVRDFr3iMRgSN8/KlMXf9TU8ILuDmKEdAkuwJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQPHako/RHiRd6nQoZT+bT7e3dEUrGcEfQWtcDVBBGY=;
 b=fw6bd8PRxmB8+uam11ob3qDbfi8AH9ZVaC3qW/VoD2ymJbikyzYmh8I+NJ0KC7ZMCIOrxkwg2yhowVY4/KgM8PIQUcyL8DfH+N2ElbN74OvuR6vRGpV63SANACcYxTutiVmHb1ss91jkDo2aoTLwksGHcKst0uJIy8bZZUHeu0I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAVPR08MB9330.eurprd08.prod.outlook.com
 (2603:10a6:102:304::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 16:31:49 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 16:31:49 +0000
Date: Tue, 20 Jan 2026 16:31:45 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	catalin.marinas@arm.com, akpm@linux-oundation.org, david@kernel.org,
	kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while
 splitting the linear mapping
Message-ID: <aW+t8S1LfwX3LjRi@e129823.arm.com>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck>
 <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
 <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
X-ClientProxiedBy: LO2P265CA0447.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::27) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAVPR08MB9330:EE_|AM4PEPF00025F9C:EE_|DU2PR08MB10040:EE_
X-MS-Office365-Filtering-Correlation-Id: 2903de17-067c-4e5c-0b20-08de58418e79
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?pWI3ZAzEdxWFbfpbKMvo8szFrVYAVF+16xZFHjghzRGb/1bthaXlbNA/HF4U?=
 =?us-ascii?Q?0PR8Y2uwqi+uHpaGinioYJrjQ1z6Lt4BT4H+P4ixXssa53QVi1FZaeR6Sbzy?=
 =?us-ascii?Q?eOjK0PF41cSzT3Bi/2yX+VLKM4nRH/b48m3+IBaN3zTMzMEqMQ+Rksm7CE4b?=
 =?us-ascii?Q?P9RZBsQ1teZKF5H7hy4ZQ8gLcU+Hio6jcJLS4lRAKTD3AC+5gRQ2tPVtWz1t?=
 =?us-ascii?Q?7XKbP+sjvZS/cWTgizBFGJ3iyGFtWxB6L2P14jvp1zqBVf3wPj/ZGCG3keo1?=
 =?us-ascii?Q?RTOLTF65O/A/BvlNOFjVTaO/kBkfPnBYTkkTAMWFzGAbibBDkY+W0Y/JJuJR?=
 =?us-ascii?Q?ZAHXrzPVkCCEvWpG9SxFLdoohG43PHBdJMzFUKGTPQSHz0FfCElVcDjMSvi+?=
 =?us-ascii?Q?FSEVGmGk63wBU10ImvjmPV0NyFmK0v/vfJgUWjKYK/vZqPcUEpPQNGwFA9CG?=
 =?us-ascii?Q?cC74n77j7OVuha/3E1GAy+q4lncRDoge4TY6IMuVcJpVwTtTYVRfbK1neA6z?=
 =?us-ascii?Q?bh1NfdIAcVewDZYfOWipIBkiERJCGc1hu813kSC/g6LhpJkw06J4u9mkI2dg?=
 =?us-ascii?Q?VJzYobbD85Swf4bbgXkfU7hutEthrvNNjrZyhZpZNqh/UTgHMVh/42S8BFom?=
 =?us-ascii?Q?T0HHxcoHsGJ8RNu0yWmL5CjlXeJUlqXPbh0CMHSJp+VtJ+vooUBDUkLS49dc?=
 =?us-ascii?Q?+2R29TgiY29bDU/ghJLUnK7WwZ2dbdVXp4bNIi5eX2OTmdJOF5IB+BhsECr1?=
 =?us-ascii?Q?XIx3s5KHFFg941+0k0g8JeTya2lhgt5Uz0QCLryPrn/8Sc5Z/oYNam9nzaWA?=
 =?us-ascii?Q?boaN2iV6mbZhWfuTM3JC0W2RtmDvg8sLzsrgleN8KLAn6vM7h7rr4P+RuHeR?=
 =?us-ascii?Q?rjk7bd9Cqxh/dJGzRXZdHs3ms6GpgGR879G20wM5ueQwP+Vd4V8JcpQvljH+?=
 =?us-ascii?Q?nXD3Rb5YZQLXUD9X3RwL+DrAGaacRTAC6/Po0DjuWT/7B2f0gVMX4jAKWMFG?=
 =?us-ascii?Q?BI1wxi2zPHD264+Xy2HksDczVE3Dqco9BFnCwSJAyTnB9hJHDyUzfSQiolt7?=
 =?us-ascii?Q?/UJAxvIdjta3KGa43y/aJKSCKZ5gcbAfhbmAoK+czUJBAiAVznFyTM+d3ihg?=
 =?us-ascii?Q?qmrkbHcuV4MIsXwNm6cMUuvarwR6kKwvXokRLEP2TLUbml01npanm7K5W8do?=
 =?us-ascii?Q?hKhWJz6ANrIyF1KbY7FZJY78eOrkm7OZP23bm3U3YkFfYPvJJrHCf+aplyO4?=
 =?us-ascii?Q?tvZkwbPtoEzWOKKA1WgsJvcC5Gyzf5ybXY2U3whduFiRl2ZQOdAMdJ19cTyp?=
 =?us-ascii?Q?X0oAtFppHRiKJGorkZHn0vfE9ZRkOz1tQZloE8MxMxkZgfGbwj2ubQl0t67Y?=
 =?us-ascii?Q?2RN0jUVj+Zn/1oDzlqh6Yxl7dyMRc3fmUKueVan6C895pllnrrWjxosZt+Fi?=
 =?us-ascii?Q?vn64bhwTPLYXMsmAgoePSu15OMsRCYnmIu0gLzQr28df4Cd2AlNuL/FW+o9k?=
 =?us-ascii?Q?ZZkN6qrzVONBJfQgkQDMvQlXQxAhQnOm/9QAlT+S7gIQLfeJSC83jGqLStQV?=
 =?us-ascii?Q?GTVzPQaV/3DcbTTI64ElHiIWt29+tMsQWOopJIFf?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9330
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	96169d5a-a297-457d-85b4-08de584168dc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|14060799003|35042699022|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bl0f/9XeT4tbzU96trfYSEvyshCMnHgFPNSk+iMyRavD3jwIVxn/MFKRSxI/?=
 =?us-ascii?Q?f+UvojzqGorb9NM1N/Nkl/qfwvp4eo1r7CBNh/S00YnwNHzkEeV4jcoijWys?=
 =?us-ascii?Q?vaGJmXWzh5Wsdps+D40ADriE9K6E2IFT/vfuSJVcdCpjWoDYvBSCOHSWb01n?=
 =?us-ascii?Q?T8Xv8ThmLbp+DEVpo/KgsWj6bXBvvbs2VoibP0hIjPOzF1I82LcS1V47hLnJ?=
 =?us-ascii?Q?chbMY/MkIJZqLWNzrRfSaxqAm5rg0IxDbIb7KQT1sA3iCNAUcaYhEiDhQW5o?=
 =?us-ascii?Q?y3VYzJpoCkl02afd3BQfTanE9zSXUOVxZYsR/OLwvxdKcK7yQhvP2Q1rF++b?=
 =?us-ascii?Q?HAIsFb8bFV6pyRFr8RAkUnTaikLIkjfzOMEcWM6d4nyWBVpnZ2/wA7QGt9YP?=
 =?us-ascii?Q?cc9SNp2cd28e05vVuBiSR64qJ1mLCWtyoWpzHIfSnOmO34WUUBAIAF4lG7Z4?=
 =?us-ascii?Q?YcYaAcgiZYqKP1Rh+H9IOmOiYS4lC3Iyk+nwHtQdnGZN+zY3L2tmRWOeASnk?=
 =?us-ascii?Q?QT5nDTR5xfdLk/c98atiB9HJNZBFbcRvoSUzrdlB8qUTtsBr2BFxo5Il2Xoi?=
 =?us-ascii?Q?lIqSYtkEASdzR2PYIDRW8CUqOm+HaFAevKYJlR5SeWKygpYGI18XEomsL0cj?=
 =?us-ascii?Q?EdGKKxpwP6txk9CyFELgGohsrl9xiHgBdbC2/lLQVhcvIXAGGrHBXq9sg5gw?=
 =?us-ascii?Q?9tvxbVaOoFoFHhIH+oQjn6NDGUZPnNnpVeO8ZD/1VxX98xw2ef/T2msinbLW?=
 =?us-ascii?Q?mXpoI8DfsdoJ8X6HQJNKUVmb5Rh6CUuUpUCjswbUuUfpvBhEbMsadrAQ7H3W?=
 =?us-ascii?Q?B+h1QDERzckfTOn0HkR/DYmW8ln/f6aalgeX+ZTPJHLCvweuwCpE5n82Kkpr?=
 =?us-ascii?Q?zGzO02HG7eAUo3tYMmoFL00e4hrq4/V73vfTVBsbAh66xUS3uQ+OB79z8aEx?=
 =?us-ascii?Q?D71d1+htT6/FhemFHmAIaR/lnmw8dLC0W9J3m1CTULJSeRSGkryevm9bV7EL?=
 =?us-ascii?Q?TxZUL/JdzaPcCWYnc4T2luci4eZEN3JEOVEtLt3/VMAvgiB83khMrV4bC5J/?=
 =?us-ascii?Q?UrTtRigFkFdW2M7urCThhgYRjpum3rSphqnjakR5XcAMbd8CCiq7oufIJvc1?=
 =?us-ascii?Q?WNYrl6hAq/rWtWtjVOY7zr1GPR9zb+9sdC5d4vdysqmFLnvarRovYbxHOTkW?=
 =?us-ascii?Q?fcz3D/zywp81Ds08VtXgOQHDUmK7pNh5/J9KMimymfwyghe8hqJOOoakx9zp?=
 =?us-ascii?Q?bsiO2zJz/rM5CPMfvqeEwvPr2PgIPApZwYZOzK2M1wcY3lVUsGFHx8VoGNcy?=
 =?us-ascii?Q?bEAO9lWznhSRdggeqa10FxVJF5mbbdACmOHIQqekLHyfDHKAV0zw7ZDhTrm7?=
 =?us-ascii?Q?DB7eVx0uUc9yuz4T3/z2Ul0rugbiqixT3Me80epoNWO/iDPRL/Onv2cArtsv?=
 =?us-ascii?Q?ZxJryJuhJaGKwLkmg/GB9sJ2OBWxSMOXfXZEAfBeQ2ctK5Phyn5MQLXnnAaY?=
 =?us-ascii?Q?Mte75n1vARuU5B06imiBbzjuqPh3vJV9c6+tXKNUyszNR3OlJKzWrBfzHnR4?=
 =?us-ascii?Q?PrfKb8aPsBn2e7UVMUmjLzd8mte8wBO2seBQuo6B2e7RS3KwFk+XGtFoQXya?=
 =?us-ascii?Q?A5W/wbDdUUIS1U6od7h75nqidsPSYQ/VpCMh+Y2xYJatEFJIUtqjzq/6Xy2l?=
 =?us-ascii?Q?lrnTHlxniUB8ZMIstyMgWqfqTjo=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(14060799003)(35042699022)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:32:51.8606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2903de17-067c-4e5c-0b20-08de58418e79
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10040

Hi Ryan,

> On 20/01/2026 15:53, Will Deacon wrote:
> > On Tue, Jan 20, 2026 at 10:40:30AM +0000, Ryan Roberts wrote:
> >> On 20/01/2026 09:29, Yeoreum Yun wrote:
> >>> Hi Ryan
> >>>> On 19/01/2026 21:24, Yeoreum Yun wrote:
> >>>>> Hi Will,
> >>>>>
> >>>>>> On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
> >>>>>>> +static int __init linear_map_prealloc_split_pgtables(void)
> >>>>>>> +{
> >>>>>>> +	int ret, i;
> >>>>>>> +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> >>>>>>> +	unsigned long lend = PAGE_END;
> >>>>>>> +	unsigned long kstart = (unsigned long)lm_alias(_stext);
> >>>>>>> +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
> >>>>>>> +
> >>>>>>> +	const struct mm_walk_ops collect_to_split_ops = {
> >>>>>>> +		.pud_entry	= collect_to_split_pud_entry,
> >>>>>>> +		.pmd_entry	= collect_to_split_pmd_entry
> >>>>>>> +	};
> >>>>>>
> >>>>>> Why do we need to rewalk the page-table here instead of collating the
> >>>>>> number of block mappings we put down when creating the linear map in
> >>>>>> the first place?linear_map_maybe_split_to_ptes(
> >>>>
> >>>> That's a good point; perhaps we can reuse the counters that this series introduces?
> >>>>
> >>>> https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/
> >>>>
> >>>>>
> >>>>> First, linear alias of the [_text, __init_begin) is not a target for
> >>>>> the split and it also seems strange to me to add code inside alloc_init_XXX()
> >>>>> that both checks an address range and counts to get the number of block mappings.
> >>>>>
> >>>>> Second, for a future feature,
> >>>>> I hope to add some code to split "specfic" area to be spilt e.x)
> >>>>> to set a specific pkey for specific area.
> >>>>
> >>>> Could you give more detail on this? My working assumption is that either the
> >>>> system supports BBML2 or it doesn't. If it doesn't, we need to split the whole
> >>>> linear map. If it does, we already have logic to split parts of the linear map
> >>>> when needed.
> >>>
> >>> This is not for a linear mapping case. but for a "kernel text area".
> >>> As a draft, I want to mark some of kernel code can executable
> >>> both kernel and eBPF program.
> >>> (I'm trying to make eBPF program non-executable kernel code directly
> >>> with POE feature).
> >>> For this "executable area" both of kernel and eBPF program
> >>> -- typical example is exception entry, It need to split that specific
> >>> range and mark them with special POE index.
> >>
> >> Ahh yes, I recall you mentioning this a while back (although I confess all the
> >> deatils have fallen out of my head). You'd need to make sure you're definitely
> >> not splitting an area of text that the secondary CPUs are executing while they
> >> are being held in the pen, since at least one of those CPUs doesn't support BBML2.
> >>
> >>>
> >>>>
> >>>>>
> >>>>> In this case, it's useful to rewalk the page-table with the specific
> >>>>> range to get the number of block mapping.
> >>>>>
> >>>>>>
> >>>>>>> +	split_pgtables_idx = 0;
> >>>>>>> +	split_pgtables_count = 0;
> >>>>>>> +
> >>>>>>> +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> >>>>>>> +						    &collect_to_split_ops,
> >>>>>>> +						    NULL, NULL);
> >>>>>>> +	if (!ret)
> >>>>>>> +		ret = walk_kernel_page_table_range_lockless(kend, lend,
> >>>>>>> +							    &collect_to_split_ops,
> >>>>>>> +							    NULL, NULL);
> >>>>>>> +	if (ret || !split_pgtables_count)
> >>>>>>> +		goto error;
> >
> > Just noticed this, but why do we check '!split_pgtables_count' here?
> > if the page-table is already somehow mapped at page granularity, that
> > doesn't necessarily sound like a fatal error to me.
> >
> >>>>>>> +
> >>>>>>> +	ret = -ENOMEM;
> >>>>>>> +
> >>>>>>> +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
> >>>>>>> +				  GFP_KERNEL | __GFP_ZERO);
> >>>>>>> +	if (!split_pgtables)
> >>>>>>> +		goto error;
> >>>>>>> +
> >>>>>>> +	for (i = 0; i < split_pgtables_count; i++) {
> >>>>>>> +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
> >>>>>>> +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> >>>>>>> +		if (!split_pgtables[i])
> >>>>>>> +			goto error;
> >>>>>>
> >>>>>> This looks potentially expensive on the boot path and only gets worse as
> >>>>>> the amount of memory grows. Maybe we should predicate this preallocation
> >>>>>> on preempt-rt?
> >>>>>
> >>>>> Agree. then I'll apply pre-allocation with PREEMPT_RT only.
> >>>>
> >>>> I guess I'm missing something obvious but I don't understand the problem here...
> >>>> We are only deferring the allocation of all these pgtables, so the cost is
> >>>> neutral surely? Had we correctly guessed that the system doesn't support BBML2
> >>>> earlier, we would have had to allocate all these pgtables earlier.
> >>>>
> >>>> Another way to look at it is that we are still allocating the same number of
> >>>> pgtables in the existing fallback path, it's just that we are doing it inside
> >>>> the stop_machine().
> >>>>
> >>>> My vote would be _not_ to have a separate path for PREEMPT_RT, which will end up
> >>>> with significantly less testing...
> >>>
> >>> IIUC, Will's mention is additional memory allocation for
> >>> "split_pgtables" where saved "pre-allocate" page tables.
> >>> As the memory increase, definitely this size would increase the cost.
> >>
> >> Err, so you're referring to the extra kvmalloc()? I don't think that's a big
> >> deal is it? you get 512 pointers per page. So the amortized cost is 1/512= 0.2%?
> >
> > Right, it was the page-table pages I was worried about not the array of
> > pointers.
> >
> >> I suspect we have both misunderstood Will's point...
> >
> > I probably just got confused by linear_map_free_split_pgtables() as it
> > has logic to free unused page-table pages between 'split_pgtables_idx'
> > and 'split_pgtables_count', implying that we can over-allocate.
> >
> > If that is only needed for the error path in
> > linear_map_prealloc_split_pgtables(), then perhaps that part should be
> > inlined to deal with the case where we fail to allocate part way through.
>
> I was originally concerned [1] that there could be a race where another CPU
> caused the normal splitting machinery to kick in after this cpu determined the
> number of required page tables, so there could be some left over in that case.
>
> On reflection, I guess (hope) that's not possible because we've determined that
> some CPUs don't support BBML2. I'm guessing the secondaries haven't been
> released to do general work yet?

I don't think so, since the linear_map_maybe_split_to_ptes() called
in smp_cpus_done() but in here, secondary cpus already on and
it seems schedulable.

That's why although, This is unlikely, after collecting the number of
splitiing by other cpu have a possibility to *split* which was counted
and at that time I agreed for your comments because of this *low
possiblity*.

>
> In which case, I agree, this could be simplified and we could just assert that
> all pre-allocated pages get used up if there is no error?
>
> [1] https://lore.kernel.org/all/73ced1db-a2e2-49ea-927e-9fc4a30e771e@arm.com/

So with above reason, I still think it need to sustain the free
unused pagetable.

Am I missing something?

--
Sincerely,
Yeoreum Yun
