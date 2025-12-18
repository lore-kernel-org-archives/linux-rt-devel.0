Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6482D3EF5
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047109; cv=fail; b=kJts8m5mS9+vAEYKZqB2ST6maVrwsG4XV+RKQG0ioDMaFgIRdgkUP1I/ZRiGQmSwWrzEN0qcREYT2KZxaU0K6gaU5lc2/VD9bHfQBNx60LnPa55jMLAR6J44jCYDtXWDL8/zrFs9Uia76iLzqqrRVxhRtgwNsORkzvxPzgu6gpI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047109; c=relaxed/simple;
	bh=GuS3ZGoRKT8FbFT6bx1omtSj9coZkZ07lc3f6M20oso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f/VvKGp9SidRXox5XF0xNAC7hvejPbCxC3SiM8HK7Hzi5nLtsmIcxzsxg22JBMea6hnOfRrqezy61gEUj46vhCI2MuKc+FZuugzcVqqvbU+5g/mrElhfHBM3raexX+q9DfljPT8Okc8W3X7TEKU1hZmlXyEsmjqnCJMqNqCr+ds=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qBlh56og; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qBlh56og; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qBlh56og";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qBlh56og"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VSJLcxlPELZ0EpfEJr1F1aoG1TKi2OpgwKXiQSRqDteMwpQYSnq2d28PRWK/iJStqli0TQIewlnbHE/F+4SO5qpiZ6FgtCFq0B2elRjfYGKWUvul1y5PQsbJFEFXdHSiIP/n0jBy3C0lSyI75CJa/dKMb0jx+8nBI56AzMR7nQOzQOGAT1Vqlth7T8G7NSTxdJMvLjydwMTZZGcQdp6ALD9dD+CPTgNWo+2feVxFnfMBQMY0MQOY4A5rh2IvZoEtDKHLoH6CeSws8vUXwT47ad/wNIEsgE6yS8psekgxB9UVQu/C9fouDU41ouuHDPHzcC9xj28e2Ewi0cbI+hSWTw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuS3ZGoRKT8FbFT6bx1omtSj9coZkZ07lc3f6M20oso=;
 b=pi8aoZ24HS5J1cm0VoI+dAOc98F5+qDpQ9nsPJzokbfuICS6+QrVAR2jGrpIuRSukXsdMI2PowBMSkJpjQ1prSgkOtTxxxtryw6tgBsUwsfTk1+OtjZqTP/VqZWkHQKcXKREB9v2BjNF7zCLD4mRBOz9PzaFvxbDJXaYw8ftogzHjZzuXogPku0WaYF5nbmW68tTUG2D/HcLbi3JSMg6ozmRw+obMFk6wvGqmG5lMa0krR0GKDXyE6/MBfJCSmWTN7ta920DlsuE7QNt/JuF3YeTKTc94EBogeRU6JEAK/oxn0OvANtNLkg1zTsN+QCO4B+fOJzqleMLuCBn8gV5cQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuS3ZGoRKT8FbFT6bx1omtSj9coZkZ07lc3f6M20oso=;
 b=qBlh56ogMnJ5fI78Op7i5egPBStLq2sh9LCj6r5iseRtuMn/PC9+wb7K8Z2mnUQjF+PB1EpE0vE3edJfZY+gaVl/nV/0WMpDX3MHEBZajYD+GP733s5Z1kYv8dfyZP7ilzZTPaVhkE6njAVBMNvttXlXpGj15kPBrTReviEoXj4=
Received: from CWLP265CA0276.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::24)
 by VI1PR08MB5536.eurprd08.prod.outlook.com (2603:10a6:803:13b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 08:38:17 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::b2) by CWLP265CA0276.outlook.office365.com
 (2603:10a6:401:5c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 08:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Thu, 18 Dec 2025 08:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYX5gtPqiqoJRuxIbuGYCceDSulo4VWRiDob+yEimnTbMBPupAg4a0q1orKPewOvh0kHP9MAhKY5hI1V3Hz18Pmyz7rakJVl2rMsqNi1YTdwvCxLkUwVRaXmsuw/dm4s82LEwLaUNfYWJB8XlZcbuaAkl0Hbkt2KFsLVmIqqm2hEQ4JGsgpM3lhWOKm9aiejD5axLpSWIkZxQe5DLd3E0XkbR6triXrhZqJxo6dyvIKlTKKGlLZx2Ew5TV/CmMLPgWSqixLGGl3jwBP14dpIO9cD0KwXr8O7mAruS6RkcJ/xqboyuolpHChAnq0VOS4eEEx7TNBQRozlGcCmYmgOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuS3ZGoRKT8FbFT6bx1omtSj9coZkZ07lc3f6M20oso=;
 b=pt04eUQruUU7X81GqElLXv1I/i/fSIfl1I2tX+gdL7c/B2NWLhndafckU7XOgq1sOw10fePA/8dUANoVHN76JJI25aCYPAPRd8xoO09Ts5Q53SFBjSyC3ZeEaNmXR/orX9KiFF66bz6XRso+ilZln/dthCi14SQuBkA4VEv1weKcQp8HADNKJgB5PLP2LldRp59D/Wc2ovrTKS/Yw+8x72rGMHUiIHQALeGy4xuRt0rZww5TMwDcHtVNui17Y7jQirnm3fqqpUc35xjoFIjIA811PITeqDb7je1wNdHtPzrW0/USBL+y4Kvulezl0RjyePDCnfWgFW0T1xVnGx5s0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuS3ZGoRKT8FbFT6bx1omtSj9coZkZ07lc3f6M20oso=;
 b=qBlh56ogMnJ5fI78Op7i5egPBStLq2sh9LCj6r5iseRtuMn/PC9+wb7K8Z2mnUQjF+PB1EpE0vE3edJfZY+gaVl/nV/0WMpDX3MHEBZajYD+GP733s5Z1kYv8dfyZP7ilzZTPaVhkE6njAVBMNvttXlXpGj15kPBrTReviEoXj4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM7PR08MB5349.eurprd08.prod.outlook.com
 (2603:10a6:20b:107::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 08:37:11 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 08:37:10 +0000
Date: Thu, 18 Dec 2025 08:37:07 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
	david@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
	dev.jain@arm.com, yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/2] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Message-ID: <aUO9M/oN+nx3nfW+@e129823.arm.com>
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-3-yeoreum.yun@arm.com>
 <731e3f48-e0a3-4c89-a13a-65ef37faa443@arm.com>
 <aUL/zJlJFRz2/Ybt@e129823.arm.com>
 <72aaa252-6ee6-4353-84ee-b6e10e9920c6@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72aaa252-6ee6-4353-84ee-b6e10e9920c6@arm.com>
X-ClientProxiedBy: LO4P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::16) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM7PR08MB5349:EE_|AMS1EPF00000040:EE_|VI1PR08MB5536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8747c0-2d8e-4ad1-4254-08de3e10cac4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?S/vn+u8WEQVwJzOP61o1bMq6dK/cqlw5egPXgaifHNOCtGjMTBOxq2tZEz3a?=
 =?us-ascii?Q?8b6fkmCnQUmNM6I+doS8K5xc2Knq4K4ctTlh8uIxwa221MrwpRtarcZt9ydE?=
 =?us-ascii?Q?44LBxdzI7ZhA9Gf6j4nVZeT8n0hZkJg3+ETd6a294kRoH5p1D5A7WzqJtTaq?=
 =?us-ascii?Q?ZR1nw2/SPK0ZXv1Tnurro0ef//LaKaILl/gwgcuq0wFOtCOXQzK9iLJ3GeOt?=
 =?us-ascii?Q?d+kgLnazVqPMYqdnIMdnG1N6tqo59EYeA4L8Lob7z1RrmZNs0Yx73d4DC/p3?=
 =?us-ascii?Q?2PsfrVXmiKvwKGOwlUIi9LBY4pCiEZLw9dB7exQmAU+Z1opy1Y/KP4uLBOII?=
 =?us-ascii?Q?7l4+0PGomqV30okHCENghxWa2n2OcBjFVwqV6Rq2XvhC59+Dd5K/aEq5nCmp?=
 =?us-ascii?Q?WrQf6ATgZcjMWN+RR+NkTqk2k3/iHqNYNQvMEL8VSVc5v4qum80W+GLaIPJp?=
 =?us-ascii?Q?jYUuGZeRseqKjtYA76vRxjK3Hm8Eb6aiDIJ7vNCs4i39307VT4xxdBosXkeU?=
 =?us-ascii?Q?1yTy1rUbDSZBgOpdNocerqQPNGhDR/GAgDOZ+3eGr4QnmDcx8S+qU1Z3iUjV?=
 =?us-ascii?Q?AvUnzjAOOFfRRJTY5cAMyLQjbz2P/+eToi2xl3M6aDOitxUnQdfaYA6kIaNu?=
 =?us-ascii?Q?lcGii6nH+iExNKDT4FmunmyY/y9PYGSdEDOaPTwy1EXjul6NUmH2fQY30vYk?=
 =?us-ascii?Q?V+qND+DuSnCIGpJbpmPyqxTRbMWYqDcst+SdEcb5N1yYwQQXYlmcalO5pkrt?=
 =?us-ascii?Q?t1WIxIa948EIqriRi5Nn3lVpNztAbrhxUf4LGnCRZTJ4IE6CQ/MLb+ZU4EQk?=
 =?us-ascii?Q?jm2oqv0F9ocO2g6wiG5v6xruQIR6FFbDr6gWy0PXIne7s2lETzlvyKhl6iZp?=
 =?us-ascii?Q?ZbcsLr4ClUa9cPTAHHIqHziy2MrmZlshRLYkXYdVf46pdB3XuXbAUxXoMyMI?=
 =?us-ascii?Q?hxtKu4HGVgFX3+ZtdTXMSHvAoQ7dSdCyXK1+oq61soyaVfH0ySS+QPSTk8YM?=
 =?us-ascii?Q?fzAhULrz7LdcHpgTVzAiU5B/aC8Ln3Q+iUFhyeJgX5ibhndICvLXEpSk1aVl?=
 =?us-ascii?Q?9fPpRqT4XjOcuOeOaFIGCrOuVvFz0tYxrTKpRwC3LW0QXFtDYOeIr+awLEZD?=
 =?us-ascii?Q?poP+p/rPCU6wivJF5ZKn9eMmuHVjGVVMNz8NG9z7mK6jbToQ73KyhffkbWUg?=
 =?us-ascii?Q?NyWl8JZSHRi+/909M/j3WKmtN2X3WVlSyDJBBoOKiJSVJPIZLMMHOLh8MyHQ?=
 =?us-ascii?Q?8Wypnay9FQe/Oiu2UpRxu6a17ZJNpESTuTuQIufbTRALAcET3f2etfI3jwm9?=
 =?us-ascii?Q?+HLbMlAvWXCpTABNP0VAsfg3+2WIRPIORv3V5fl6oRc3cv1GggrLuKgfVQc2?=
 =?us-ascii?Q?qvHIVLlLmWNf7iLwDXlc6ppyHYLxmN3SHWLVQOUrBPchRpfF7ks0Sui0XGfV?=
 =?us-ascii?Q?NrmvuF1kDHiFlPMZaZwcShDbATMStDpN?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5349
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	363bdda7-6979-4f34-f111-08de3e10a2a9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|14060799003|1800799024|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3McSnz9L0XFMwmXSsc1I1HzGWbN3BezP6sPyetPlsDBdBmQ+6NCcVtrne93v?=
 =?us-ascii?Q?SiaNkWq2ahX0s/dH+L9HQIUH8pl5cFsjBbd2EOFiSQNm108C6BYGuNZbuXpc?=
 =?us-ascii?Q?2Sey2Y6c+W6c8l1sBkJbZr1xvXvfvLHhFE9FelS8HfCfl4bXa1Vwea9KYusI?=
 =?us-ascii?Q?gkhcjqUyHR/VBRH/8X2sVUG3cViZ03RlLU5D3DvC8WswW36wkMXnV5gYr0QD?=
 =?us-ascii?Q?fIhZ6dyJxo0iI4TxDmeIhNOLEWwARvrQWpSLUHHJu7wAplEq992A4/m0BDEk?=
 =?us-ascii?Q?R6chBUzJRbNP9+zx1doKq0hhKPDXFvkSDDjmjtmGGGzGPzp+zsThidx5usgN?=
 =?us-ascii?Q?LGxYR8bNa0v4Hq6llZfAgnbegF/Md6qCtjGbB9Ae6Hd/aLOJfnhfXlz88dUc?=
 =?us-ascii?Q?YPWRyv9VT2gaZe/KSsS5OIePeoFi0v6x5TnhNKxc9valjUyG5RLah5GAXF8h?=
 =?us-ascii?Q?dgocvvdPpKHSEW0hRKY/CoWGsNXv/3eQOTWSDtkRHhRPSdjwnVBobBV9C+nk?=
 =?us-ascii?Q?wVsMR4I3GVn0TvC//+wSKLaaw/3lsgqVq3SPNYDacBn+aOTf/XJHwIgUyawb?=
 =?us-ascii?Q?hQuz3CksmxlS5pnZd1NCgMCifqXo5Cr3UrZqisUbvkx2WZCQ2sdVu8RGjPYO?=
 =?us-ascii?Q?GwmR7zzZT8geeYT3BgUV0zmWqyoe1c1U1TSip1Yg+s2iI9JQhKE93kI9cOHb?=
 =?us-ascii?Q?oe0QtCztUxc2ZWB6jftaOTyN0pxavfengiHDpR9LqzNt0UzgkxGTfk1F8G1R?=
 =?us-ascii?Q?YbD/QekXfGKk6gTjS/GMmKTH0DMooCJENsNAmlMJ1FvYEr2CKIUjyJZvZMvb?=
 =?us-ascii?Q?vzpFBH9GjcCSpmKfA6Y9zoGeULKQzzgxgWXAcKCSf92DUKOfNT0fZK3VVI5R?=
 =?us-ascii?Q?Jp71z1m0gcJ+ygi8d8q5IwiFRr3XTcR1dI5lZrXlcP9dQ1G9/zfP4Rohimtf?=
 =?us-ascii?Q?eCp1uHRY/RVjM81yj9D7qSTo7dEZ+ApRZpNx4XLqC4YkIQcLHIABL1lGg2Vr?=
 =?us-ascii?Q?dQtpUDWaJnOSe805GVfNC0FC/61AA7xenNrh1L60+QgA6i8eGg2lE6Qm4cCu?=
 =?us-ascii?Q?YcCa/O0k5shuHz3hlY19yAced2JQJG3JMoSS5l9m5t7WwxwT7ijaI+bPBgap?=
 =?us-ascii?Q?tkX+JD/qxoOEXkEhT3PL9sTJK0Jqf9kqd3dpd9A0/BLlRvj6nZlbj/umYa+j?=
 =?us-ascii?Q?6FOIQFODHfYAeInTeri+Dw023GLoCBqtqia5RwwV09IzP5iFmQcWj0WJN4le?=
 =?us-ascii?Q?JJEIj3eGYkRe3u+SbAe0mb0PRWB8MRjPO6tU2LVn1/0IpNRRI/UiJELl7hNZ?=
 =?us-ascii?Q?Vxb7GnyVa5TgXub8ksfYpfTMWGenS+EuXiJ1PmpSEYxtd6ipknQWw5tUjwoz?=
 =?us-ascii?Q?18RA3P7DoA9h3eMpinZFNqsCsL+wdilZ4JYVFWaUOmf0+C/2XcviH7aI9vdr?=
 =?us-ascii?Q?gq1tDRRh27BLAQ+XCsQtR1mFhu2Qx1ZggZqGyE+0xVx/WEqH04kmDdAAZlE9?=
 =?us-ascii?Q?WH7sW8rcPZN1VNsMjWIopl2TEF058N7huMnbqbU4K5w4I/4AtGFZuCcO/XEx?=
 =?us-ascii?Q?a9DyiNAkwetv4tlvDxw=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(14060799003)(1800799024)(35042699022)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:38:17.4516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8747c0-2d8e-4ad1-4254-08de3e10cac4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5536

[...]
> > I think it would be better to use only __GFP_HIGH in here since
> > when kpti_install_ng_mappings() is called, "kswpd" doesn't created yet.
> > and to allocate page with assurance, It would be good to use
> > min_reserved to.
> >
> > Am I missing something?
>
> Personally I think we should just use "GFP_KERNEL | __GFP_ZERO". Anything else
> would make this allocation look special, which it is not. If we fail to allocate
> at this point in boot, we have bigger problems.

But I'm not sure *HOW effective* to use GFP_KERNEL in here.
Since it's before the any filesystem inited.
IOW, in this context, almost there would be no *page cache*
and I think it seems meaningless to use "GFP_KERNEL" and "direct
reclaim"

So to get success for allocation, __GFP_HIGH | _GFP_ZERO seems much
better.

Thanks


--
Sincerely,
Yeoreum Yun
