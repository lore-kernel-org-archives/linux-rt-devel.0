Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011042.outbound.protection.outlook.com [52.101.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D647799A
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984428; cv=fail; b=BGzsC7wZ593qBYQAgJ6M9V3b7gnXNjeJrM27iDs3TfRrSJyY5hY8ESY/020PEVB+l2EBd4VqWyGDk0H9eH5B8CHqBISJFNW/noco10cqHyxPJgldffrvlN9ACOzCl+QpEic82jAGrrvuPsT7DcqdlOTEIGMv6IMSn2poxcqKqlM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984428; c=relaxed/simple;
	bh=630tUyQ7cTJdJBtTCJv5gthmJBWYpYigO/DMA/mKWuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drt5XOxYaRUWZGmiujKQ6+WKR2h2JoBgMg5tMBKsh85jfr9vnVIjueTdNJMS0A5UhC7d0ayU+czLtDfFKSWeKyQCPftzMevOtjvvJazP+fhJnZMcGwyZtGnPzEG22+XIP3yNBlfPGobCPOjPIs5GPVBZnSn1fH36lLbvxhMtIY0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lKx0iBfS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lKx0iBfS; arc=fail smtp.client-ip=52.101.70.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lKx0iBfS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lKx0iBfS"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dwCM52slr4px+fIY19TnQJvsbPeRHgFDj8QuEOzpdkCblBMge1GhKBnzPFHos14i7KLkW/BiBtKTBUnbb6hcIw7yqTcPkUsR6+DPb94wQlx2s2GiHW6h8aEupWqhrRpk9va9OB64xgJQcKcL7jFmVAbaK8Ga3/4bnsytuSM8Agb5mgiuIXD+1K3xs9D8AsYCMRsvmtOyEn93Exx0xiWT+j3bFu09eAyBAI2VputXVq7Ce1rpfzdDhohPT/bW+FzRU/BTdQDlW20lH99UBYg32p3WcgJMHHQ8CmFAKbce5d9+gzNg6luzOFqDHVqXB3wIvqEebYUTcm8J5zwYwFrdWg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=630tUyQ7cTJdJBtTCJv5gthmJBWYpYigO/DMA/mKWuA=;
 b=tQmeBdiXzfkN0kpgpb4i+fiKxBIK2h+PRMsE/Nc0vZRtsL/s49/2ni2jcBj+IdUsfOzeSP7nmoETKGEtnJxgDXAxugyQJS+UafLzYgrXUIXHqetPqWQBtEQZ0qay/KYK1T+8ax8T06rWGrSJJqo68qWrbl1ZmCAQZqRGh9ckVFQRBgugTZVMiA4HD8Agk0s9pNZQqXtv5r5cFG1elHJOL2CS1GOEeOnWrBE3H1292TG9Rlf/p+qMMWQgLgm5hB88831eQ/6ftYej2q8YxcxPSITFiU4UzhMVtuTViCtbs8YOPvgVwbajaOpSqMaR4GzMK48bHtli2Y78js41ZCt3TA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=os.amperecomputing.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=630tUyQ7cTJdJBtTCJv5gthmJBWYpYigO/DMA/mKWuA=;
 b=lKx0iBfSKR5UwNH3cA+Ld/Zfxj+Qf6NQvC/17lXJWuzhZNF2zCRQ5A+9IEKJnUw8x5Xvo08HREI3TW9E44n/tBn84qUuQgyMR4NqOIrsl0WRgSmpJTvscBN9/NSt3j7AXcBOP8aBKGT9LaZfsfSccSkpaCDchLEadjnCXEC4s10=
Received: from AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::12)
 by VI0PR08MB11515.eurprd08.prod.outlook.com (2603:10a6:800:2fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 08:33:40 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:150:cafe::6c) by AM0PR10CA0032.outlook.office365.com
 (2603:10a6:20b:150::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 08:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 08:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd4RjA+nlcAQz9/z8HoEE1GUEuDtWX7hTX66W7JHWAWIoGZvn+01wQwabxbT7Gc0tjFkKt8IYJQ9l9xglux+FBD3xGNZfZbd6oLsHRAyy5lan0l7t6caYrvE4/HbNDwi3QbYOa84NSFZCYFBn4oSwRPar449K64ZbuvHuV9dlPvj26WiDrH0AndXQ4N0f0rXo4V7my8gjNKSTwBbO5fTIhJMbrE6KVSoS8OUdTfUmPPYZwnUBdrAPSCyvsUsIPIgJtMuOSHvh1AntL2GMnd9xuRD473xuMDkp7f3Hx/HDLBxjEmrzuokPnYGwGUjICp3TmC6+f6UNBS4AfhHUkO0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=630tUyQ7cTJdJBtTCJv5gthmJBWYpYigO/DMA/mKWuA=;
 b=JxeP9jHTuPI0NcAOMxrhXAShytACxF7G6OERBcej6wkbiZx53rgb+9DjGTygGWUXa7pjySUwlNEUl9u45Bro1Kl+V3Dw1/N+UQdZtzv8I/2Coe4syaZsbzLkX53s2l+W4z2RJiStj6Er7Yww0DUmVpog51nBTZiiBeIyaJ/BSLJMACyglMVFQQ26zFZIONqNbI5hBpIKiNBqaOGG5VtL9UW7cbP+6YazeDR3SdY4IVbB/t9TNDffPKB96LsQBWY3IwgFG4/yTcUE0Vt0XrVydgpijchobF04CB1rnF3LQgs1C9VLjW9K06T9aA6cd9odtFvmkCVg+khXRq9VvKQAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=630tUyQ7cTJdJBtTCJv5gthmJBWYpYigO/DMA/mKWuA=;
 b=lKx0iBfSKR5UwNH3cA+Ld/Zfxj+Qf6NQvC/17lXJWuzhZNF2zCRQ5A+9IEKJnUw8x5Xvo08HREI3TW9E44n/tBn84qUuQgyMR4NqOIrsl0WRgSmpJTvscBN9/NSt3j7AXcBOP8aBKGT9LaZfsfSccSkpaCDchLEadjnCXEC4s10=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB8995.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.14; Wed, 21 Jan
 2026 08:32:33 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:32:33 +0000
Date: Wed, 21 Jan 2026 08:32:29 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
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
Message-ID: <aXCPHaylUbRJ3CME@e129823.arm.com>
References: <aW5p1ylQBNXTEmmq@willie-the-truck>
 <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
 <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
 <aW+t8S1LfwX3LjRi@e129823.arm.com>
 <11a01f4e-9ae5-4001-9f9c-74a746f898cd@arm.com>
 <02bb61cc-f0be-41e5-b8b2-59768afd5254@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02bb61cc-f0be-41e5-b8b2-59768afd5254@os.amperecomputing.com>
X-ClientProxiedBy: LO2P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::32) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB8995:EE_|AMS0EPF00000199:EE_|VI0PR08MB11515:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5220a2-4cca-443f-a6f9-08de58c7c75d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WDJMOTJMZHh6eDJxOFBWaldtd1hBakZFUlp3bjFHeHRhdW4yM1JuKzZCUWh3?=
 =?utf-8?B?anRoMlNZVFZqV3NEWEdqTnk4RkFvNHZ4NnZMYzhlcUpXdngreS9NYlRuZXNK?=
 =?utf-8?B?d0VRcHk3elpiWGw2ZlBMRWNhTDZaSzM3djRkdjRUZVArdkxySjJYZURqSERw?=
 =?utf-8?B?NVcvS2MrcmJjRG14VkNEcjZoaFhZZDV5amtMcFpxQ3I1UkV2b25GK3lGT09Q?=
 =?utf-8?B?QlJVRFRzM3NYWnVCMUVOVGRWRVdjQUVNNCtCeWFURTdNdnBWQkxzL1BtV3BU?=
 =?utf-8?B?TDZveGR4TXZ6T3FjTnlid2xmT3Buelhyb1ZmQ3RVQ2Z5RXVwQlNNVjRNUkkz?=
 =?utf-8?B?WVB6RlhvOXovbkpteEcrTVJNUkExRUJJZ1Nhd0RMcHBZZGNlc0Z6ZG16Z1lX?=
 =?utf-8?B?eml0WERLZFV0a0gvVlYyQTBIWENwd0s0bTZRaDExTFIvTEk2RWUxc2U5UVVw?=
 =?utf-8?B?V25aYzJyWnBlRHZiOXZpaTY0WDNVNGJmSktROVJCK1pPTVF1L0M3SG11Qy9z?=
 =?utf-8?B?YlE3YnpoVEIxdkc5aDlXTFY0VE42SzIxNktoU1BxKzdEMTdMWjRXL0Z6bDlp?=
 =?utf-8?B?eW85bkxINVhEZVhWekNxdld0SzhvRGdpdWxIZzMrRERxUlpZZnlTRUdtWjBi?=
 =?utf-8?B?MXZWNEtBRFhTR2RkbVpkanFOWjJGNmxSejFsZWxuMk5IVGxkL1M5d2JTeVpr?=
 =?utf-8?B?RnV4MFpzSm1PUGVlTlhrMmF1YVhES1Y1VjN2SmVsNmhnQmtmQ0hFQnVHN1lQ?=
 =?utf-8?B?NkpRdGlTNU5yRkZ6aDFLREc1eStJNk9OOEtwRmx1WkNIYXNWb3RCTTA2dU9P?=
 =?utf-8?B?UWRwZTBUTm9adDRBTllJMERoS1NxRS9GVEhtTFpKRkFRdXQwOTVobG9OUnNn?=
 =?utf-8?B?bXNCZXpYWkdHeEVTYUZMeTBPVFlNSktoSmozR0dCNFZoRDZNSFVwankwVDV4?=
 =?utf-8?B?MXpuVXJRb1JsRGxNSTI2QXFFYWdXTVRoZ0dlNXQ1Q2YvaktKeXN2U3ZNVlFu?=
 =?utf-8?B?NTRPek4rTmdMakl1SlRKOG1Ic0xnTEFPM01kbENpeDNWTTVad2ZXa3VHblpU?=
 =?utf-8?B?T3gyL3lxZTYyQ3M4WUo3NlZXWVhzOEo5Z0JnN25WaER5MmZvUXVRMWJOdVZS?=
 =?utf-8?B?SGNkbHV3WlU0eEJ5cnRMa21VOEpKTmxVbTNHRkdCWklVeFRKb2VpSTkvdWVX?=
 =?utf-8?B?b2ZQeDkyMWU5MkpONlZuM3UwQkFnRGU3UnREYkhzT0RxK1FMaG5wYXhzcE1S?=
 =?utf-8?B?UGFTZmlsK2IxNkJ1UHIvOFZWM1lWOTNXaUYrTEF3ZXR6cTdvT2pzNklwVEpX?=
 =?utf-8?B?NTUrRXhXTFR5Q2Qzd01HYlMwYWtiRzEweDhadkdyWVpscUVWY3ZpSEJrY3lH?=
 =?utf-8?B?VkdaT1ZWL2IyUDN2d0Qrc2ZGZzJYTmhFbW9wb1pWYWhJT1A0TkE1cnJrREpQ?=
 =?utf-8?B?amJaOHNlRE5vclY3eG5ZSGhxelZjcVRFVDRpc1RvNEZxeWRsUHpsMTZIQm4v?=
 =?utf-8?B?TldsTGo5VHVXb2RFaXhRYjYwdllkTFlRN2loa2Y5N0NBNlBYU2krelphZm1C?=
 =?utf-8?B?OUtEaGJWU2g5L0JVWXNnRDh5em9EOHVjczNrdzdkODhHYm9STkhYUW12MXFh?=
 =?utf-8?B?eWxMMTFGV2pJOWZxRElJbmI4UWlwT1l2Ky9qK1FGSG9KK25VOUR0ZmE3bGp2?=
 =?utf-8?B?VVMwZnBNRWVmcXVUdlBsOGVaNFcxY1JnVjJkUkNRM3REclhpbWNLdnJFeTBL?=
 =?utf-8?B?OGhpT1VJS0JMTnljeGFER1Evc0Rhbmc1RVN6R3hLbFV4bGR3c1JTVG9qdTBn?=
 =?utf-8?B?cjlzNy9xSVhqazU1NGJ5eHg2eDc1eFh2YWRkUit5N3lGU0hpMEx6UFJYdGlu?=
 =?utf-8?B?cThsbUVlKzM4eDdhTGpTSDlWSkFoanBhbUtiUjVTWlMxQUxtVHMrVkw5V1NR?=
 =?utf-8?B?WndydURFNk52ZUJKdGJ0OTRHd3NqRXR2dVdrbHd3Kzk3eUgwWm45YndkdExV?=
 =?utf-8?B?dE9ETHA5L0djVTRLM2FsRS8veXNTdzdiVjYxSHgzMS9LZU82bGM0T3RyR3Jk?=
 =?utf-8?B?MXIrZ0ZKbHlrVExqMDduNUtpUFd2T2xVWGpVdFpremZXb0tDRjFtOW9qMUpM?=
 =?utf-8?Q?0V5Q=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8995
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	00bd09dd-9f69-4642-52d2-08de58c79f8e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|1800799024|35042699022|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFBYc2s0ODFYYVBXVThuN2Z5aGJXdENIRDkrZVExQTZxUlV1Zzk2SWRiQ29K?=
 =?utf-8?B?WnVyV3hVS2J3SE5OOFhYUXZIY1VGVjhEQlgzUDVFV2drcGhKNjc1VzBHZWtN?=
 =?utf-8?B?dEpmRW5QT0JNL1FiSjBCWGhkYXNod3VQbmE2UlVod0pCMUU0aHphZFMwQWxN?=
 =?utf-8?B?ZW1nVUprMkYwN2M2YWhGTE9WTlBicndBQVRzUWVRUkxsUFRncFdZU1IwZE1J?=
 =?utf-8?B?NU5uZXl4UFNtMnpaOUNhTDJaTy9zQ3R1ZEsyN1ROYUFZMk9SWGl6d0cwQjRK?=
 =?utf-8?B?MFlFUUJMYW9SSjQ1OHNlK1NOZW5KeHYyRlpZcTJpZThvY1hCUEMwTEFYM00w?=
 =?utf-8?B?QU16WmswNjVlZEx6aEIzK0lCQjZhcS8zcTJFci9td0JoQXNlUzlYUmZhUGdm?=
 =?utf-8?B?WDZadjhTbmFldzM2elA0NFJRTjM5RDFBODVVWi9LYWwzZGhFYktBdWZKNVV6?=
 =?utf-8?B?OE5RY1FiQ2Rod3ZDbG1Bb1E1UDZpS3lCZU5Qa3Z5Rjl4ODMxUG5ObERGOWxo?=
 =?utf-8?B?K29DcDBhcUhNU3orM2E4K3NpcVk3T2JZZGRnQWdJdGN6aytCMkZrS3A1ODBE?=
 =?utf-8?B?bHBIdnpMSWJSQ3NxUjE2WUIvcTN4dVR3cFl4TE5XQzdNLzhkRWpycFRxMW8r?=
 =?utf-8?B?a2RJT3pOME9KK1pIcHp2cEhlUnpDNlV4Q09PM0gyZmNvRjAvdGRLZDVCY2ZL?=
 =?utf-8?B?Z2FhWGJWR3JrdFFaYmtlNVFzZzBKRFhvZzFQV3Y4MVZGNVUrZjRSUkI1WnUx?=
 =?utf-8?B?cXhZai9LNFNVVVEzZlp3U29CazJoMmpvZnNCVDFTcCtxVVF5aXU5enYweVJh?=
 =?utf-8?B?SEExamY1SWtLRm01NEU1akovRjdOcFB6bTlKVk4yYy9ueFNJRCtPRUMwb1Rw?=
 =?utf-8?B?ZjZqcXVIYkVmRjg1R2o0ZDdKcWVleEtzZWgzdzJNWmF3a0d5Qkx2NzR2Qno0?=
 =?utf-8?B?TVlzdG5FR0ljQzFyTzc3bWo1YlU1TXZxQVFvNHY4R0lUZ3JUdHZHQzlHWEhP?=
 =?utf-8?B?WnJ6RUcvRzhvaEZoZUc0RTdobUZid05SbEpWM2V3YWxtMlhnSXA5a2FWSFRq?=
 =?utf-8?B?eWpvV2NVMHEvWWd2QkFxSDUzSUhEMm5HZGM1SkltY1VQdWxzbkZlYnc0OGw3?=
 =?utf-8?B?SWNDUmpsNDhpZzRqSXY1SFFxdjlSekZOMVBpTjdSckdsdWIrTEpvd0FXY1cz?=
 =?utf-8?B?ZU90QWpmS3VrN0FOc3JiM0JJUXluVncxbkllaWdxdHVNekRyWHZWWndQdzhr?=
 =?utf-8?B?LytYb1c2Z3hPbVRYY1B3NEhKVnA0MlZSSk1kVGpwQlE4Njk3U1pyY2FFU09I?=
 =?utf-8?B?YmRUK1IxNkhKKzNUbXJmSksyNlMwV3ZDMWVlOXhqTG9sWWxOKzJBd2ZPd3Q2?=
 =?utf-8?B?WlpnQ20wZXZReEpMSHZOQ1NyTHhWdTg0VFJkOUozY1cyZjNlMTkwb3dKSHlS?=
 =?utf-8?B?NHJOcmw0K1pXa3Z3RU4ydlNHNWRKZmpUNnZqODNTZW5SY1l3cHMwWmxaTjJX?=
 =?utf-8?B?eXZpR0hIbG9PYis5c2FKTHFjTHFCRk9xQ2g4d2xhOUpDUzg3QWFCb05EaFdl?=
 =?utf-8?B?U3VQRTRFVmNWLy8rcXdUbWF3U2Z5TWZ4RmV2alVoRHF2dDVjL0xMZ3hYcVB4?=
 =?utf-8?B?MVRQVDM3YlJLQ3JoeExIUVhFa0x6YjF3TTAxRVExNTRnbTdUN2IrV0RVdnhJ?=
 =?utf-8?B?V1lKNjJkWnJ5UFcwYUlUTzU4NDFNcGJnL0Z6SFBXalVKL2pyN1dZQURna1N3?=
 =?utf-8?B?dkRYUXc3cVNnNytpL2pEcGx3TytQUllxbkVVSTBFS1pFU0p4SGpxYVkwUXJH?=
 =?utf-8?B?Mzc5eHBodGlueWdGYzRWbmxPUTBRcWFHUk5WVFo3a3FZSnZaYzl6dTF1UkE3?=
 =?utf-8?B?RmZWM2toUTV6elVEdDNKRXpKT1BsaUdkcTV0NkhsLzRJdTFxMG1pYXJLanVG?=
 =?utf-8?B?N3ladThrNjJIS1g4L3pHS1FhWCsvZE12UlR2N0pESytwaGR1UVVONUJvZGxy?=
 =?utf-8?B?RFFHR2NIS2NvREpEdUFwWTF5S0s3TjgzU2hqcm9VZHRZa09SMm0walRCWHFY?=
 =?utf-8?B?MWpVWHhhelIzRCtPdWcydFNhaktlRUdwR3d4K05sUmIvblBwSS9ZcmJVR3lo?=
 =?utf-8?B?a0UvQzhqZFJ0Tk4xVUg0VzcvTTNhem1ITDB1Z0NMVkF0UVFDZGlTQ25pYmU0?=
 =?utf-8?B?Q1Q1a2ZJdEZYUlhScHFlVlR6cXFQZVo4ZkpyeVdDWDB1WnJPUDU4cnhoU2Ez?=
 =?utf-8?B?aUVoRzBieVNyUjc2Qk0xeHhUQ0pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 08:33:39.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5220a2-4cca-443f-a6f9-08de58c7c75d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11515

> > > My concern is that if a secondary CPU can race and cause a split, that is
> > > unsound because we have determined that although the primary CPU supports BBML2,
> > > at least one of the secondary CPUs does not. So splitting a live mapping is unsafe.
> > >
> > > I just had a brief chat with Rutland, and he agrees that this _could_ be a
> > > problem. Basically there is a window between onlining the secondary cpus and
> > > entering the stop_machine() where one of those cpus _could_ end up doing
> > > something that causes us to split the linear map.
>
> If I remember correctly, split_kernel_leaf_mapping() does call
> system_supports_bbml2_noabort() before doing real split. So we basically
> should fall into two categories:
>
> 1. bbml2_noabort is supported on all cpus. Everything is fine.
> 2. bbml2_noabort is not supported on all cpus. split_kernel_leaf_mapping()
> just returns 0. Kernel doesn't split page table, so there won't be TLB
> conflict issue. But the following page prot update may see unexpected block
> mapping, then a   WARN  will be raised and it will return -EINVAL. So the
> worst case is the caller will fail (IIRC all the callers of set_memory_*()
> handle the failure), and we can know who is trying to change linear mapping
> before the linear mapping gets                    finalized. AFAICT I
> haven't seen such WARN yet.

Thanks for the great detail :)
I've missed system_supports_bbml2_noabort() in split_kernel_leaf_mapping().

>
> > >
> > > I'm not immediately sure how to solve that.
>
> Do we need some synchronization mechanism? If the linear mapping is not
> finalized yet, split_kernel_leaf_mapping() will spin. For example, something
> like this off the top of my head,
>
> DEFINE_STATIC_KEY_FALSE(linear_mapping_finalized);
>
> Once the linear mapping is finalized, we can call
> static_branch_enable(&linear_mapping_finalized);
>
> In split_kernel_leaf_mapping(), we can just do:
>
> retry:
>     if (!static_branch_likely(&linear_mapping_finalized))
>         goto retry;
>
>
> There may be better way to handle it. But this case should be very unlikely
> IMHO. It sounds crazy to have such complicated kernel threads run so early.
> I'm not sure whether we should pay immediate attention to it or not.

Thinking about it again, I’m not sure whether
it is acceptable to use a sleepable synchronization mechanism at this stage,
like split_kernel_leaf_mapping() does with mutex_lock()
(even though it may be technically possible).
It also feels odd that this function can be called at this point in time.

If this is indeed considered problematic,
I think it would be better to simply return -EINVAL immediately
when linear_mapping_finalized has not yet been completed.

--
Sincerely,
Yeoreum Yun
