Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB65D410D00
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950167; cv=fail; b=lKBEM9YLL6l766joGL529ep5O6bHPeUoC9LnlqhGHGGl1tgsPhEKVsTnYG0GtDX20EooPWAAm5X0Hpy2KzV/Lo6dhpfIC+xq69JUqwV1hdaZjYk/gKAgbAa8zOWBU2FbbXnRY31OTcAXrTu9ctPWrMZMw0TmVSGI8qACnPxId8c=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950167; c=relaxed/simple;
	bh=cq4QRZik71GrLQ2bADuSnJoYdtEHdz5eoK360tQ8VH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mQNDiFdNcKyVmm3hclHs3YgiJvGbIO48+P6OZPdVkCT2NcVi0aILK3VPLh+1gWeX5xUPxCUzWKLE6p91hU90Ho+Xe9jFcNqhJiyP9TSBCagpWM46bXhCFGzAczm6EZdiY2IMaPYgYo9cLMmgV1t87zfn86F3egVL1OOYuSWxA0g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KdGcab47; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KdGcab47; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KdGcab47";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KdGcab47"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=D+GYw0KW+QiphutrQ2MlNyY10knkNttZEx9s8+Mr5Yj3e+9/v4QoGg/b8JtxXo2EjFvTgF3p8obUk9nZAR533af0dFhGg1Xlm4Fn9jhFhMyk9TUj0LEgC6ifGlkvAk8jxE394kvnIvT9HMPpwLjI9u4Y9WyEilskY4bMmoN6IngPREL9WQeTn9pgRWqQPyvmQBg+cjxKL6uL3IzWSr6WvFwqoSNU+4hGHwpREp6fCTxk3i1dDz4E7FM8b4mBhmoOXczHcMZXig80k2psX/BuicQDF+Jq+VnKgcivvLtFEjT8Y0ux1fLN+Nmv/cDq1hBlz3iuNU6gTwcsDXOhm1PiHw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMYQlcg6V9RbaXRxnQ1D0dPnrGNdtOHgkJOeVL4bFSA=;
 b=MmsAD7C3j5IR4aJz13WE+bdgsP1zBQOe62z2p9YT6q9cxqIRuEUPQ5lFu9lGx1iLOXgLr8EmEAwO8UGZ730oRLTH4oe0oBrePsrwlveQ1aX3fHfgNqMES7Snwl5aQsO8ik1DBRqXR1aF81mU2YtBPBqicRGNtGaQ7QPKKRuUSlhLAhVKOi5fE2Cdpj9/dznYn/yNWf7xs1OBDjKhH1DEwhlU401YUAUo1KTpHwoUSThPVioE8zTS/llDNEO4MxNVi7WbOR+Px1JzP/oYk2lP2YvQM+IsJ/YI4bNTvPjQIAeqwDFSopsWfP4/ltLVYRiFA46RkyCed39CMr91QiKFEQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=os.amperecomputing.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMYQlcg6V9RbaXRxnQ1D0dPnrGNdtOHgkJOeVL4bFSA=;
 b=KdGcab475FZxQJRcWg3GxnhoMucFFdz44q/5plhiLMpphgMg2Byoma5pY+12gvrKn/QuTa3mUBDgb5Hh8eR3GI6EL4GocbIaiOM5dHCQaCeker9RBv5i/G2Tb2FzwBHXiqkcyXHgARMH3qvcFYE51Xi6AcZeLqxMKb1v4KWnXFg=
Received: from CWXP123CA0015.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:73::27)
 by DBBPR08MB10625.eurprd08.prod.outlook.com (2603:10a6:10:53b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 23:02:38 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:401:73:cafe::6) by CWXP123CA0015.outlook.office365.com
 (2603:10a6:401:73::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 23:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 20 Jan 2026 23:02:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYWSCbi0KoMIMHcPQjxQgqz0n0mzH+QVypHYzaUMwJ2rzTE+9W/YxjgTUjH01a9W+qKi9ckIvQXuVoZEReTbpuy+gh7rCEUJreAYWoomy1STzMv3hM42mkanIS66QMIMoU2Hvkv1Gcum+F3m65CWFV5c1+OIoLfRXyG6XiYLJMiQONDRrMKJ2WrCLE8p6xZnO0JfiNKgwJ7wvPGUJh5kzPKSrwQZj4hW4cJrRzBy5eo9b2J5doT4eKfNhR4uuHvgdaLWMJruAHLDeucBOQLEFOqAdNsA4FG+Ti0iStE34Y6MtSb/EeHxchN88uKxhnkX8h1N3y1sE6yG/SRdTd/f9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMYQlcg6V9RbaXRxnQ1D0dPnrGNdtOHgkJOeVL4bFSA=;
 b=fF1os7CEYsRG3NeRu1wHbI62j2TnSZLZ0pYjRA7NaVspWD/cHj89UTMvDlgl3m93luGI3TjQmNjyD4rq3ACfTwvaltB3Z2LzSrwR5E9uFo4Q0D16EWS7Phw94SQpypSK15QOpLUDd8OzhJG0i5wp5m5KTmNBASSAdqVNJg8bhPZB3HOucSwu4lv9iYNK6CMtI9T2OlZMp+wM88G3++KXDqtmlb9/bGyEb8b1p/e1J2VbIlc/3BX/dQuJVzdDXEDAzJgeVBqKjlAE+lPLmJMqI5iRm3dMMet99jxKuKd5F6PP/MT4MGbpyp7Vqk9xrnPbub2b6HHYM5y0Q80pKmiq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMYQlcg6V9RbaXRxnQ1D0dPnrGNdtOHgkJOeVL4bFSA=;
 b=KdGcab475FZxQJRcWg3GxnhoMucFFdz44q/5plhiLMpphgMg2Byoma5pY+12gvrKn/QuTa3mUBDgb5Hh8eR3GI6EL4GocbIaiOM5dHCQaCeker9RBv5i/G2Tb2FzwBHXiqkcyXHgARMH3qvcFYE51Xi6AcZeLqxMKb1v4KWnXFg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI0PR08MB11062.eurprd08.prod.outlook.com
 (2603:10a6:800:255::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Tue, 20 Jan
 2026 23:01:31 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 23:01:31 +0000
Date: Tue, 20 Jan 2026 23:01:27 +0000
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
Message-ID: <aXAJRx5JtTenw1Ou@e129823.arm.com>
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck>
 <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <5a5c78a4-0b07-4337-8b31-a2cdce1834ea@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a5c78a4-0b07-4337-8b31-a2cdce1834ea@os.amperecomputing.com>
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|VI0PR08MB11062:EE_|AM4PEPF00027A64:EE_|DBBPR08MB10625:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c876f8-dbaf-4294-d9db-08de587800e3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NXU4VmdHbndUZzBsY3lJREk0THByVmFFdmc0Q1pWRjY4NzdiZHY5bEtMK3d6?=
 =?utf-8?B?WnJ3bGFuT3RCWmw3UEJEek9XOTFBS3NJU1lzdGFWWG5DQ1l0ZzZOOXA3OXFQ?=
 =?utf-8?B?bi9pSURDU0hXaWR5S0IyNlFLK3Y2OFRqMGUrZTcwLzRTVHBCSWJseW40UDFG?=
 =?utf-8?B?TDR1VG1yLzl2ZUsxYkQrVUtWQTlTYktCMjAxaVNIOGxzQm1UT2s0Q3JkMlo5?=
 =?utf-8?B?RHBUVlo1d09Ka0kycjAzWkwzMzBvdzEzdHhuaUs1ODh5anB0YWJsZUc0SHZ3?=
 =?utf-8?B?N3VKeVJ4L1FaUmo1cFowc2NZOGJWTFhJNy82QTFlZUhxZ3NtTDhHZWJmVGFN?=
 =?utf-8?B?NEZjNVl0dkE1VDJEV29hUlVURndGQUFzZ2ZBRk5DLzd3c053SkRFN2RvYmRk?=
 =?utf-8?B?ZmlFTjNJeEIrOGh0ZFplTmp6UlpOYUM3dnl4c05Ib08zL3h3WExrbWlVZExZ?=
 =?utf-8?B?SmQ0ZGpnT2ZESjQ5LzBPQi9vbWs1b3lvaFVlV2VLYnlDeDFETHprNUpYbS9R?=
 =?utf-8?B?dHRnQmgzSmZiSmluVFJZaDBRZE5RMUVza3dSZEMxRlIwamFSaUhuRDVhS2Q2?=
 =?utf-8?B?QTdqbVVtRENKSnJSTkNVSjlKRUlCZ2R6YWFMWmEwWVQ0dnVrVmRZZ3E4dkJ4?=
 =?utf-8?B?Zk0rMS9UODlVN0xaYWMyd3ZRY0xJM2I4QVJERzc2UHFXUkJhZDkwaU9sTGRH?=
 =?utf-8?B?ZDdjbmM4ZWs3eVQ1L21DUkN2TE1tV0RrZmx4MHl2SlpDN3NZNWNWUW1ta0pj?=
 =?utf-8?B?czZuZkVTWHRrSElDS2xYUE81eG9MTDJhQlUxT2FoSnRGMzRFTGxQQjRrdExG?=
 =?utf-8?B?MytIT0NqOE9pWHd4NzlrRkJ4c3F4bEtFaS9kaFZRMzV4QzRQMXhoNHhzRk5Y?=
 =?utf-8?B?SFlIbDZqMEFuY05YZ2I4Q3dpd2QvNWJUSVFBNEZKU1ViQ0hkZnhDSlJ3akdH?=
 =?utf-8?B?THV6ZU16eEdSZDY4a1RYL0lYZWh2MkMyWGZ0SGp6TWxjVjJBNkZxTWkrODkr?=
 =?utf-8?B?SndyUFRGaDArbGN2cm0zY2hUL2FYRngxZ1lvL0hEMDBKbTA2WlBtakxKYkll?=
 =?utf-8?B?QkFqVVNXNmtBWHZOT0t4SzJ4bVhaVkdGcmtFU1hOc0FHZlZ0czVRMDkzVUtm?=
 =?utf-8?B?ZzFnT2hvR0lpRVhicUtQbkEyK0VLTkRaV1pJU0lTWFRPaTZFNDBjWVlLWnh4?=
 =?utf-8?B?SnZEZ2p4V2trOXFXb2U1cWtCUDBjdUg4RGwxWWc1MGU2dERpbzdHVHk0WGVV?=
 =?utf-8?B?K0FuMm5NQ1FJZnJ2OHpVbFdmVU52T3VZTFczVnFFQThodGZwSWlzdUJwS1Jo?=
 =?utf-8?B?cFRiZm9FK1BtUWcyYlVPOWhlU3JIOVA0S2J5ejZxcFlrb3VIN0dVdHNWSXhV?=
 =?utf-8?B?QUZ5TTZQL0VCSURHS1FyM1A2WnZjcThpS1hIVE9sbGJrdmM3WGdIQ0puZE5Y?=
 =?utf-8?B?NklKbHRXUERXa1pWaWxmNnZUTU13OEIrSCtSay9XRkFCQWx5bWRmNDhRUFFu?=
 =?utf-8?B?MTgyUnBIT2wvK1RCUk9NZ0xYUWxyRHBTSy8zYnl1NlluZWR4bWdocXdnbFAw?=
 =?utf-8?B?WDI0T1NBWXBoclkvL1FmWjY5M0xYeUptaDQ0K205OWJTWTkxK0xqQXBtSVVB?=
 =?utf-8?B?K2hHaHpsNjVoenlJZXhYV2wwaFBSMy96NjJTdlVNR2ZrT1RnNnF0T0F0c1Iy?=
 =?utf-8?B?UmtXZUlKOXJ3TEs1d2RVd1JHUDVkNWl5OXFIZnRvTk9BM0gzWHlxNXVVbWtO?=
 =?utf-8?B?RUtPaHhMejZXcnNha3h4M2s1SVc4SFZ5OXVZSFM1OEY2dkZ6QTM1aHFqdFcy?=
 =?utf-8?B?Vk1MOU9ZWVF2cCtJMnRlOCt2UnNZQWlrVEdoRlQ1SzJ1ZGx1R0t5dnozNGx0?=
 =?utf-8?B?OStLUkZ4b01jRjR4clF4TTVOWFd1S09xak5LaXBTOHovTWNTNHpjbWRBQjVt?=
 =?utf-8?B?cVg5d0xkdWZXZjBWT2Y1cXgwZFpzaGprbkxjQVlvcVYwYkNHZGV2MVlSdkJa?=
 =?utf-8?B?ckQzaHp6c2xpQU1KNmJmUFVKNXJIbmd3OGhkVlhTSmsvR2gxQUR1OVR3OTBY?=
 =?utf-8?B?dlRTQ0Ewbk9UZncwY0s3TDRSQ2xjdDNSbWZjUWZJYi9uZGlqOW1Rdm42elhX?=
 =?utf-8?Q?izPE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11062
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a7d25619-af26-4764-f53a-08de5877d993
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|7416014|376014|36860700013|82310400026|14060799003|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2N0TTBIMjBOZWtlcXBBalg5SjlOMFR0WENXSXV3RGZ3RE0xUVZ1b04xZVZE?=
 =?utf-8?B?REpKM1Y3ZVNyb2hJbkpNWGhYTzFmWnVKczNOUnpkeEhQdll0RzZ5NVoyV0Rt?=
 =?utf-8?B?Vllxb01kSHluWC80QlNGVVVDQTh4YTNyQ0NyN0NUeFFYZUpZdTVZWHZzNUhV?=
 =?utf-8?B?cnBqNkV0SWVLUm1ENUZWVUpzMmNsQWx6TDdUSkFZcjhENVlPeG9Jc001MUxI?=
 =?utf-8?B?YnZ3QmMrVnlQNmVYMys1M29wdks1cU0wVXdScXI0U2loLzRobTh5V3NSYnk3?=
 =?utf-8?B?bzRaWHA2T2FVQzVSSXBaQWhkd2F3ZC9qc0RzWkdxaGdGdTdiVTZZb3FTNm1w?=
 =?utf-8?B?SmdjcDNIbUdnblVTMm10eUZaSDdKRXJmQ2I2ejJsbnQ1RkdHN0kzZzhiTERy?=
 =?utf-8?B?UmtjV2NrNnlmNDZVc3pjbXh1SzI1VlE5WlRackU0R0V2NlpwMEIvUWVZZ0la?=
 =?utf-8?B?UHJQSHpzVlhqa3RaakdXMEo2RFdEOS96ODF2UmNCTE16ZlFJY1JSL3puaTE0?=
 =?utf-8?B?SHhvTGczSUc2czlzaW5jejdLbkRhV1RnSXk2K1QrMmxUb25BWm9ObFFqWEh2?=
 =?utf-8?B?UENiZUh4SFl0U3hwWXJtOHdXZWRDMCt3RGU4ZExvOGlIQThzbHFtRzB3NEdu?=
 =?utf-8?B?RjNVemR5WGRjQk9mcmNwTkF2Rm13R1RJRXdRZXM2UXNpWUlGSW51a3RDaEFN?=
 =?utf-8?B?WGo5Rnh4QzBGSlVpYjJkd1JNRGpkai95Q1R0TXdRdkswTlUvelhUNE41VU5t?=
 =?utf-8?B?R3lLZE9ON1dQeXdkZytQbms5b1ZiZ2JkT1ZtSG5PSlJYMS9kbG9yZDUxWWRH?=
 =?utf-8?B?ZUhDenBSbXVxYkNmWXh2ZEhhUDA2WHlzUFVjdEpBOENhQ3R2dFpkbFdRQmxw?=
 =?utf-8?B?dU9PVFpCQ1Z2Wkhaa2Z2WDRXdHBHNzhDbjRxM1ArWTQyTDdjUDdpaHhoUCtL?=
 =?utf-8?B?amNadEJhV0V2byt1S1hWVGJOdlY0RWN1UWRiekhmQTh2b2hKUmpPUTVEMG44?=
 =?utf-8?B?cUdoQ0hZYk9jNUxwRmxRTmpjMEdIenJCY3YxRmNRdjkzd3ZuQ3NjdWpRUm5L?=
 =?utf-8?B?cTNaemc4ZXZaUUhqK2hZekRZbzkxZGN4VU1OazRLTTJvVTdscDRNdDdCV3pP?=
 =?utf-8?B?ZjBGNWRqUHhta0pOUVlwSS8xTElUdE5kbW9qa2pjdi9CN08xeUJ2dFJoeHk4?=
 =?utf-8?B?T2VjNGsxR1dzTDlVTW1iMEVqb3FCbVJpamU5VGJ5Nm00elN1dTM1bFFDcTll?=
 =?utf-8?B?d3U4TFl6UVJ1bm4vdGdNdkxnb0tSYXh0SkVpSEg1dGd2cjJpV3N1SklxM1B5?=
 =?utf-8?B?bnFobzkxZGkxZkxrSEJXV1RpcWl1QU1scnFGczVRaDJLWDk0bWNwQnNxWndJ?=
 =?utf-8?B?eCtHVkZzQmhneWFCc2I2VDBKUDBYYnFFK09ZSnJ3d3M5OWpjdWkycFpEZ0Zy?=
 =?utf-8?B?aGdLTGFtWFBaZGRDeUtkZFNHN0RxdUxVUWtUZldYTWRHclc5ZnNUQ3hzT1R0?=
 =?utf-8?B?cExQQkVSWTlXdC9lSFJwbzlIOEtMQ1dzYmF2bSsxQ21aNFBhMkJDMlFEVjcw?=
 =?utf-8?B?ZEJLTFdBaFVaeldxaWpZK0JFTE9SSmRkcjJkMmtZL2JudXV2UkprM1Q1WFgr?=
 =?utf-8?B?WDd2ZmJwWDFIQlk0aklDVnRtM3djV05XdnpqUWMzaUxqbUEvT21BMjVadmxl?=
 =?utf-8?B?elQ4c0FjYVFVeVZsNC9nR1hpQk53dmVpZUYraUlUR3hTdDFPNDdNTm8yRVA5?=
 =?utf-8?B?UVN6Z091cE9SRzRtUDNDNlVYZ1k5Q21HNlpNa05raVJiOW9HdkVxUlBoWUs3?=
 =?utf-8?B?YW5iV2RBb01iMU5ZendoTFNFTTlKK0NzanVwa2Q1K0lsdjhyNEdsdjN4czZm?=
 =?utf-8?B?N29WMnpFZjROUlcvb0o4ZjJyalhCdDhCaytOL21tMk9NTkNIM24zbFBvZmZN?=
 =?utf-8?B?Z1llOTcreGR6Y0NwQXRIUkJzUkVKUU5sQ0I3dFh4N2FrRUp6ZzNGalNvZGl5?=
 =?utf-8?B?UjlNWitzbS8ydnZzWmh1L3JkYk5ORThqOEo0MXJKcm9seE5KeXNabkxSUG16?=
 =?utf-8?B?dVBpdnQ2dHkvUmVMWlZNa0FWWElQekRaMWVXUm95RkFpS0xNYUdBOFRCSjZj?=
 =?utf-8?B?SG1ZeVhGWjlrWC9IL0Z3UXJGRnNNZEdPcGdIYys5TzhwL2FCdjZ0QmtKM1B2?=
 =?utf-8?B?UGlqVk9UbVgxOW9CcXRLd1hhdUQ2WEFVOFlwbzVuQ1YyZDd6VzlMWjF1bU1D?=
 =?utf-8?B?aWNEL1lHdWRtd1l0d2xGZitYRnBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(7416014)(376014)(36860700013)(82310400026)(14060799003)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 23:02:36.6487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c876f8-dbaf-4294-d9db-08de587800e3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10625

Hi Yang,
>
>
> On 1/20/26 1:29 AM, Yeoreum Yun wrote:
> > Hi Ryan
> > > On 19/01/2026 21:24, Yeoreum Yun wrote:
> > > > Hi Will,
> > > >
> > > > > On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
> > > > > > +static int __init linear_map_prealloc_split_pgtables(void)
> > > > > > +{
> > > > > > +	int ret, i;
> > > > > > +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> > > > > > +	unsigned long lend = PAGE_END;
> > > > > > +	unsigned long kstart = (unsigned long)lm_alias(_stext);
> > > > > > +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
> > > > > > +
> > > > > > +	const struct mm_walk_ops collect_to_split_ops = {
> > > > > > +		.pud_entry	= collect_to_split_pud_entry,
> > > > > > +		.pmd_entry	= collect_to_split_pmd_entry
> > > > > > +	};
> > > > > Why do we need to rewalk the page-table here instead of collating the
> > > > > number of block mappings we put down when creating the linear map in
> > > > > the first place?
> > > That's a good point; perhaps we can reuse the counters that this series introduces?
> > >
> > > https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/
>
> Yeah, good point. It seems feasible to me. The patch can count how many
> PUD/CONT_PMD/PMD mappings, we can calculate how many page table pages need
> to be allocated based on those counters.
>
> > >
> > > > First, linear alias of the [_text, __init_begin) is not a target for
> > > > the split and it also seems strange to me to add code inside alloc_init_XXX()
> > > > that both checks an address range and counts to get the number of block mappings.
>
> IIUC, it should be not that hard to exclude kernel mappings. We know
> kernel_start and kernel_end, so you should be able to maintain a set of
> counters for kernel, then minus them when you do the calculation for how
> many page table pages need to be allocated.

As you said, this is not difficult. However, what I meant was that
this collection would be done in alloc_init_XXX(), and in that case,
collecting the number of block mappings for the range
[kernel_start, kernel_end) and adding conditional logic in
alloc_init_XXX() seems a bit odd.
That said, for potential future use cases involving splitting specific ranges,
I don’t think having this kind of collection is necessarily a bad idea.

>
> > > >
> > > > Second, for a future feature,
> > > > I hope to add some code to split "specfic" area to be spilt e.x)
> > > > to set a specific pkey for specific area.
> > > Could you give more detail on this? My working assumption is that either the
> > > system supports BBML2 or it doesn't. If it doesn't, we need to split the whole
> > > linear map. If it does, we already have logic to split parts of the linear map
> > > when needed.
> > This is not for a linear mapping case. but for a "kernel text area".
> > As a draft, I want to mark some of kernel code can executable
> > both kernel and eBPF program.
> > (I'm trying to make eBPF program non-executable kernel code directly
> > with POE feature).
> > For this "executable area" both of kernel and eBPF program
> > -- typical example is exception entry, It need to split that specific
> > range and mark them with special POE index.
>
> IIUC, you want to change POE attributes for some kernel area (mainly in
> vmalloc address space). It sounds like you can do something like
> set_memory_rox(), but just split vmalloc address mapping instead of linear
> mapping. Or you need preallocate page table pages in this case? Anyway we
> can have more simple way to count block mappings for splitting linear
> mapping, it seems not necessary to re-walk page table again IMHO.

As I said, it isn't not only vmalloc address mapping but also
"kimage" mapping too.
In this case, it need to be split to set the specific code area
with specific POE index.

The preallocate page is for spliting via "stop_machine()"
since page table allocation with GFP_ATOMIC couldn't be in case of
PREEMPT_RT in stop_machine().

Also, the spliting text-code area to set specific POE index would be
done via stop_machine() so, the collection is required.

>
> >
> > > > In this case, it's useful to rewalk the page-table with the specific
> > > > range to get the number of block mapping.
> > > >
> > > > > > +	split_pgtables_idx = 0;
> > > > > > +	split_pgtables_count = 0;
> > > > > > +
> > > > > > +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> > > > > > +						    &collect_to_split_ops,
> > > > > > +						    NULL, NULL);
> > > > > > +	if (!ret)
> > > > > > +		ret = walk_kernel_page_table_range_lockless(kend, lend,
> > > > > > +							    &collect_to_split_ops,
> > > > > > +							    NULL, NULL);
> > > > > > +	if (ret || !split_pgtables_count)
> > > > > > +		goto error;
> > > > > > +
> > > > > > +	ret = -ENOMEM;
> > > > > > +
> > > > > > +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
> > > > > > +				  GFP_KERNEL | __GFP_ZERO);
> > > > > > +	if (!split_pgtables)
> > > > > > +		goto error;
> > > > > > +
> > > > > > +	for (i = 0; i < split_pgtables_count; i++) {
> > > > > > +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
> > > > > > +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> > > > > > +		if (!split_pgtables[i])
> > > > > > +			goto error;
> > > > > This looks potentially expensive on the boot path and only gets worse as
> > > > > the amount of memory grows. Maybe we should predicate this preallocation
> > > > > on preempt-rt?
> > > > Agree. then I'll apply pre-allocation with PREEMPT_RT only.
> > > I guess I'm missing something obvious but I don't understand the problem here...
> > > We are only deferring the allocation of all these pgtables, so the cost is
> > > neutral surely? Had we correctly guessed that the system doesn't support BBML2
> > > earlier, we would have had to allocate all these pgtables earlier.
> > >
> > > Another way to look at it is that we are still allocating the same number of
> > > pgtables in the existing fallback path, it's just that we are doing it inside
> > > the stop_machine().
> > >
> > > My vote would be _not_ to have a separate path for PREEMPT_RT, which will end up
> > > with significantly less testing...
> > IIUC, Will's mention is additional memory allocation for
> > "split_pgtables" where saved "pre-allocate" page tables.
> > As the memory increase, definitely this size would increase the cost.
> >
> > And this cost need not to burden for !PREEMPT_RT since
> > it can use memory allocation in stop_machine() with GFP_ATOMIC.
> >
> > But I also agree in the aspect that if that cost not much of huge,
> > It's also convincing and additionally, as I mentioned in another thread,
> > It would be good not to give a hallucination GFP_ATOMIC is fine for
> > everywhere even in the PREEMPT_RT.
> >
> > --
> > Sincerely,
> > Yeoreum Yun
>

--
Sincerely,
Yeoreum Yun
