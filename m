Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022132.outbound.protection.outlook.com [52.101.43.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1764AAD24
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954350; cv=fail; b=rPx18R+nG8Et1ZPb9WE/sn9pkckyTKg4jdthOWzEZE9tne+7xqEaTky2hpvDpJO3vf6GWxT2Y2Bhfq0Zy8kCk8LxtKkWZZDardP165lg0ZvDv6Lm8xPMlLJLFzZfuxbEjRE/MO5MzfzFWXlBAW0nrb3cFyR+mEuPPv+Eg4kTYJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954350; c=relaxed/simple;
	bh=T7+j7qUK2GyQzd4YyISlggj+nS9l34GBI1G7kkXr0Ds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZP46FncpWGYELCLzvzzzyPl23mMTbPOOYJ8dbG4ID2TNEvfoUbRtt1/v3cIdOETjyLBnEy2GCwkqSy+vcwYQNISl+dYdwyExG7bHaRwv9icSeTSgsQir0+CQW7Q6Cayyxm1uYZKuWQx4/ly0ej3VlMKvK0dg+Ie8+yp80ruCx2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=iBYaZcY7; arc=fail smtp.client-ip=52.101.43.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iBYaZcY7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDG3WtOWPwtoXPpoMCXOA4wuAB7jcLhVaa2YNKvgZeb48U/CLpUHySHfixrcwg1MlB6jF5mk887Ofurl3q+fHoz1TkEmbhtVC8skr4GAOJ5SbEMCbO3pQiksZwQUvTZVagfp/M6zmkRjdC6PouwizSQMmMkL3itNNDsT2M55r5tbq4Uff/nRkt4IEs6FrnsnKpA2llUyJOmhO96F8qa7ED7ZGOIZvI3tQB7RVfrNeH8YYpF/PC+TQW3tuUFSx/CSdcNCeWEtkoY9hUO/wSBziyNXTvciTUa2Y9Nzs8NBttLw1whM0v7W778gS2MR05uYuTvlrxGiJxNDpksFEhMdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOfEwS/z+QHgcKU2LDxKVdqHil+Oyb8QJ2pxIQVrbYg=;
 b=OKlJRVLXq90W1t4ijcSRM8/Zi1OQBLYcBii1NESJeVshjkTK1AlfmcBZyq72jgmLzLoFfK5cR6Yp+XDNVEE5SkHCt0sKyzAxv2HpmZob/da2ySt2xq3Jd1XcuUteyWa+nzotiYpoM1lUFR00gWu8FK+ongHVBfCYt3eJUOAZRof+M7tdLPG1Z8zOpRNc2p7+HHfBUD/Aj1sRROsy1yOfbnNhS99I7g7Q7Wn1QLhT8FufgedXZH2vpzvKQUnEEOL6eDDOMsHiBM7WCGxO6jdwlswOwQYHLYcuSyAnMPptNsa6htqOf6sU4EZt46i32ywrWj/DdVkCs8HIag9kW+o9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOfEwS/z+QHgcKU2LDxKVdqHil+Oyb8QJ2pxIQVrbYg=;
 b=iBYaZcY7hUKTLdsd8LXW/wYSi1eBjjHvfU9GdDITfpGxX5P1zKAe7bhRbK9Pn2PXZVRscKQRvlBUgLPm1Lut2dH6tpeaNyLaahwbY3s6nA37aM+QN7mL9ZqjH6PtdRMgZK7agP3T+ILhWuvJTA3PFGe5FHk8EGCcLV1nvkTJIzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DS1PR01MB9086.prod.exchangelabs.com (2603:10b6:8:221::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Wed, 21 Jan 2026 00:12:25 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 00:12:25 +0000
Message-ID: <02bb61cc-f0be-41e5-b8b2-59768afd5254@os.amperecomputing.com>
Date: Tue, 20 Jan 2026 16:12:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while splitting
 the linear mapping
To: Ryan Roberts <ryan.roberts@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 catalin.marinas@arm.com, akpm@linux-oundation.org, david@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 chaitanyas.prakash@arm.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, lorenzo.stoakes@oracle.com, ardb@kernel.org,
 jackmanb@google.com, vbabka@suse.cz, mhocko@suse.com
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck> <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
 <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
 <aW+t8S1LfwX3LjRi@e129823.arm.com>
 <11a01f4e-9ae5-4001-9f9c-74a746f898cd@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <11a01f4e-9ae5-4001-9f9c-74a746f898cd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:930:14::28) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DS1PR01MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f95e777-c163-4cb3-cf1d-08de5881c10d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHU2TDhnbzhLcHFMZ3hSbXlOUEhpS3hJcktvNUc4dy81OVpHL1RNaGgxT2J4?=
 =?utf-8?B?VytYYjhhSEx1a2F4eGk4QkJxWGQ5OWhoRHpEZTd6ZzN0bEx5RjdBejZjU2hO?=
 =?utf-8?B?Qk1WSzVIQ1ZDTlBJNkVieERuTk5pbkNNRForeE1TWXVFMk5CY3dDd2V1OS95?=
 =?utf-8?B?RVozcFZxYmVPSmJGNjRINURXL0VsNE8vM1laTHUvVHY0eGJtYWd2R0Zwa0NK?=
 =?utf-8?B?UTEwZmFoOWRPd2tpM281dHA4VlBjMVpjb29tbTdQSDVCY1pZWGNJcmd1ZlUy?=
 =?utf-8?B?eHBOTFNNWXhvZUN1ZFlIY1VVSDhFdDZtOTMwRS90WU4yOCtjSUVUdFBlTlNM?=
 =?utf-8?B?aHNIUVhwUm96UmJQK3BCU2I4TUVyay96VFZYY1U5Q0RQMHlxcWpTTnU3bkdk?=
 =?utf-8?B?WXV6L3BmeXBRY1NwVXp1MU9EQ3d4WFNKR2NQWGVXUmFUdnRoT0NFUFRuYzRU?=
 =?utf-8?B?cVlveDZ1RDljTzhnbEs1K1V0bDhOOUpPOVhjT0R4Zk9uMExJakZXc3RWVkVP?=
 =?utf-8?B?TUdXUjdhK3RZMTVadERMa2Mwc3ZiUXRRZU9jNVFPRTdGUGNnVVY4azRyTC9q?=
 =?utf-8?B?ZmJSZ2ZaSHdXZWxkYlZKYTNsT25zQ3JVeHhqQ0xDSFFzaE9pc214Y1ZkZlRk?=
 =?utf-8?B?WnJzV2pVODV5K3dSSm9Db29ISG9MMzk0ZGJmUXFJRXFoNEtpZy9SY05KL3Zx?=
 =?utf-8?B?VldZQmhtM3FyKzAraEF0dGFaWFVybmdlOFZvRGV3TEdVY2tieHpqQ040ODkw?=
 =?utf-8?B?Rk4wOEcrUUlRbUlBQzE4KzJFSUNPTDJKRmNJL29EK0lCZzYrZFZYYmkyZzZ3?=
 =?utf-8?B?OFh0aGYwVDJwbWl2dkVDa09paEVzVWFXaWhRQ1o5dU5NbGFDSmplUFE1MjRQ?=
 =?utf-8?B?T2NKcW9rOXpneUE4QlFOSEUvc2pBeUhLL2dIczUwdGlTanFFN2t6MitLT0Nw?=
 =?utf-8?B?ekFDY0VXSUhBU29MNE5PRjlScDl4ZCtiS0tlbzUxREh5UWRQVE5sVlRxbFNt?=
 =?utf-8?B?OVlWeWI5NzRsZzRLQTJNdkhIM0Y5dEIxbnFYRFpRWmc2ZmVndFhOd2s5V2tX?=
 =?utf-8?B?azRqSXo0dkxzU0xQZmwzcmtyN2JnclFra0FTaFhYWWxhUkdyN1RyblRYZ1Zx?=
 =?utf-8?B?R3BIT29HSFNwRnBkbWMxZTNrQVNLSHRHbzZEaUJJQlJ1QmdreGkrd1F2ZW1m?=
 =?utf-8?B?eGpxdmt1c0RQNE1VcWdhbmt0K3hEb2xNcEduQmEraXo5TmxkT3hQOEtIRjkv?=
 =?utf-8?B?VE5iM2hEdkdWV0JyQnhyelZsejY2bURFVU4yMHdvK3oxdy85TWFJVjVLMlUx?=
 =?utf-8?B?ZTNzVEkxUEhLWHVoSE9MVGxpMFZrWEhXUnZpQW5mNHIzYTNCZWtNQ0Y3QWd2?=
 =?utf-8?B?VkdkdHN3Q1FhQThhUFVJbm1BekJ6amExU0EvMTM4V2h2WjRHcjZSRmFQVXZw?=
 =?utf-8?B?eHpiVGZWNUw5MGVBVE9kbGErSEdqNHllaDNMMk5zWktxalNEMHYycU9mTkNj?=
 =?utf-8?B?dDVIN0pBL001ckJQRkVCVzBNVzZYV283am5kQlNSL3JvRTdQS3BaSXN4d3BL?=
 =?utf-8?B?S1MyZ29Oc1M3OTFwNkYySXJQN1BOeHBYZ3BaUXU3T2Y0bHNOUjVreWpMalRK?=
 =?utf-8?B?YzdnZ0RlTFRNQ2M4ZmREbk9oRDI2MjZUb3N2SXlTTFB3aDFuSnV1SFdRT1Ba?=
 =?utf-8?B?WWNkUWE4WHBKUXM3QTVkSEdHekpLYmVwbCs4S1RaakhaSFVIbkk4MlVnYzVB?=
 =?utf-8?B?dkxwdXRZS3luZklUTGk3cC8rRTVWcGFjQm1tTWJSTWNSUHhPYUJxd1pvUzNM?=
 =?utf-8?B?cTJNNndZOTYyL3U1UUtUVDNudDRNL1hDNkpHL2NteDd3T1Z6d280WWduRUNo?=
 =?utf-8?B?YTR5ZlJWTWhKOEZqMU92Mkk4WkFXTjBqeW9HV3JmeGJVZDlDVU9idVI4MXRH?=
 =?utf-8?B?a2FveTA5c1k3L0g5RU1DYWhUSnFHWko1QW1VRHVERlBSSlhJRGhjSllwWDZ6?=
 =?utf-8?B?SDNVMVFuVHJWeGZOdEJsOFQrMUxJbzFSalBoa3dCNzJvbEVhdlRqeXhtOXNt?=
 =?utf-8?B?UTk2cERtc3MrOTByMDdNYVUrdTcwbGtmcFhtMDJaWjlYbG5nemVFN1kvdXRB?=
 =?utf-8?Q?jU6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODZ3dm8zZUcwQWRIWjJsc3V4cVhPZ2VPdXAwaXFoK0Zma0UrU0xFRFYySDZM?=
 =?utf-8?B?WkhrTlNVUnNPbE1CdUN1L2VMOUFCL2xSY0xTNlhHS1h0MUIzcEZzV2JTeHFP?=
 =?utf-8?B?Q2RGN2pSYWlKOFBSNEJJdlhvSktweS9WVE9sRzFGL3AvWjRpQm9LTXVLL0R4?=
 =?utf-8?B?Ulo3WG00ZnJ4cW1CSVVMalhxWmNwU3pCSTAwbjZzZDMydVFad281elVmSjFW?=
 =?utf-8?B?R25FbElyTUFDbkZJZTk2bHM3K2dPZDBRK3NHdlZxTGUzWUlhdnhKY2g3aGww?=
 =?utf-8?B?cFZlUG80MjJYMFRPaHk4QnNxL0RIMUxSTEd1NjZKcDRwSmNaOEpwU3piUTNl?=
 =?utf-8?B?c3FGZVp0bTFDYU1QN2dzN3lGSHQ2K0NyZTZwd01OQms5c0ZQNkc4QUpSMG1a?=
 =?utf-8?B?RHJpSkJkbUZybkNSNWRWS09tQlNsNitDRzB3NDNwakR2NHR3cUVlOUlDbFRy?=
 =?utf-8?B?UXgwdzZiQlo2SnhmcEF1SHhWWEw4dkpBSmFRcmg2MVloVHczdHlFaCtjZDZT?=
 =?utf-8?B?SlBORmE4U0ZRRmxNQjVqdnF6OHhFbGQzWGtNVmFBV3cwZWdVWHF4TG1qT1Z4?=
 =?utf-8?B?MXk3Sk5vb1JDMk1QTURPdGFEYWRLK2x6MkMwUHlxOUFLN0Z3RlFUZzNYNGtX?=
 =?utf-8?B?OFVkNmV4ZGdRYkdOZ2ZRNUVyd3R2Z1JXUzVPdGxFVGlCZGM3akdMdk5xcWdE?=
 =?utf-8?B?K2puOXhtZDNnYUhad2VIb1pkTlI0dUdVNmpFNXV6RkF4Wm45VUxJdG1JK1JE?=
 =?utf-8?B?eXJ1Nm5mc1U0MGhNLzNKdWp3Uzh0Z3poM1N0WTBvQzVGdWZYcytRQU90cXZH?=
 =?utf-8?B?dkxQdVdvK3pZb3p6bnhMcmZBT0JzOVJMUzRlTm9sbkp6VWpPZzk4NUFrci9l?=
 =?utf-8?B?MGNUdkhGNXBkdzROVzEzRlRKOEQyMmZWeWNRYm1DME44aS9td2MxZUtCcEFX?=
 =?utf-8?B?SW90VXhFcXFEVGFKYk9zbGhRc0VkUGFCanBJSTk2MHRwSlc1dHl4QldXRm43?=
 =?utf-8?B?OXFlanB0T0FRWEhObnN3MmFEMFZ3UWRiWncrM1A5cXFDRHBXR1V3U214cTBx?=
 =?utf-8?B?SXVtM1RLc1JUOHhHWkNHUHdpZVNFL1RtZmtsSXg4NmhMNVdVRVNKQ1NFY25D?=
 =?utf-8?B?Q09BS01Ha2pvenV5YmR4dksxQVlJcys3R3loWENLb0hHNGVlSlgrVncrZ05t?=
 =?utf-8?B?WSthRWhlejFXc25KNXdBYnN6MlpDK1BNekxXYTZmLy8ycTM0M2JCcWhRZDlJ?=
 =?utf-8?B?MmFoSkxRcnB5ZmQ3eXpSY0IrbjNFM0N6UzZnMnZ6Um5JWmJ1ZkhkL0E0aG1p?=
 =?utf-8?B?TXF3SWZQVEtlU0g2T00yTUZUQ0dHc0NaektEYXhrb2VGRTlobFdWNTJuUisw?=
 =?utf-8?B?MVREWWlFcTN1YmlXaVNGbDBUZ2NsbWdrR3Q3T0ZGZEJsTllLeGRnSkxzTk9Y?=
 =?utf-8?B?bzJNalBxZXhHNnA1MFV1d0t2NkdzMVVROWdweUwzc0diMC9heTZNd25KYWtP?=
 =?utf-8?B?TUFBR3ArZGVGZkwxazEzdTBWTVUyZG9sTHNOb3RWcTEvc0ovQllqbExiZzdv?=
 =?utf-8?B?dGtNVCtSa25TajR3SzZnMGpzbFZwRjhpcWw3eDhwV1daTjUwRjljemxQK002?=
 =?utf-8?B?ZSsycUtTOGNYZEZaaWU5RE1UQUc3L0UzWDFaWGZ5WllVNXZFMjlVN0NNb2Fi?=
 =?utf-8?B?cUJjUll1WXBOcnhhcXppL2NGb0R0WHdGNml4dWpvQmZoL1RuYzRIdmRZbmtG?=
 =?utf-8?B?TndUQzNYQVNrQmtHMGx3bUt0MytPR1g2anA0b1htUmQrR2lwcHdTS3B1aStR?=
 =?utf-8?B?QXZGS0FKeHdVUWpSS3luMTMrSFJKYVNJdlVlUzBpdHY0MURZMHpzUmFLbFJs?=
 =?utf-8?B?TW9zaGN5ekxOK2kyNHpncUpYRldZYmNPcDFOSDZ6R0k4M0tQam82SVE5WWM4?=
 =?utf-8?B?aWdxZmZIN3A4TmtyZkVUT2N4YWw5TVJLR0NlODBMaS9sdzZBQTFqc1E0WnhH?=
 =?utf-8?B?cVp5R2pPbFptc3JQU3VicnpYVDh3cWM0blpFaWdaZ1NITmdHN2dGTUR6bmUz?=
 =?utf-8?B?d2lyWVA1cmMzMmhsRDRSVWJiOG00Q3RLRkRoQjh1QzVaUGk3ZS84NFJlQkhv?=
 =?utf-8?B?MVdPa2cxMEZtR0o2U3YxY283SjRUWkpwa0Rmd0VhQWxYWHFWRVhOemlidFlR?=
 =?utf-8?B?WmRrSWYzajhLcGxybmJkOHMvUjFENHFvakl3RGY0L1pVb1R1ZmM5UEt4cExM?=
 =?utf-8?B?K205NXhTR2dVNXlEVWNqQ2RvVXhIOVNzbGRWUFR4ai95d0JzQVR6SHh5WkJP?=
 =?utf-8?B?NC9SaEl1ZmJHeXloY3JXZFM0bUFHdlVmVVFROHVzMzc2UDJ1OFRoNk5lOWEz?=
 =?utf-8?Q?aYN0J/itRq+sofc0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f95e777-c163-4cb3-cf1d-08de5881c10d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 00:12:25.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVxo5aSUqW3jY0c87bI1MutMKSpzSh1SWdWC3kMG/zmjgpwUm7T5T+WiwqrZ0QJGM3jSEVY8HhbaCj09ZAUtpEtskw6hPX9ALkHN0jwYHVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB9086

>> My concern is that if a secondary CPU can race and cause a split, that is
>> unsound because we have determined that although the primary CPU supports BBML2,
>> at least one of the secondary CPUs does not. So splitting a live mapping is unsafe.
>>
>> I just had a brief chat with Rutland, and he agrees that this _could_ be a
>> problem. Basically there is a window between onlining the secondary cpus and
>> entering the stop_machine() where one of those cpus _could_ end up doing
>> something that causes us to split the linear map.

If I remember correctly, split_kernel_leaf_mapping() does call 
system_supports_bbml2_noabort() before doing real split. So we basically 
should fall into two categories:

1. bbml2_noabort is supported on all cpus. Everything is fine.
2. bbml2_noabort is not supported on all cpus. 
split_kernel_leaf_mapping() just returns 0. Kernel doesn't split page 
table, so there won't be TLB conflict issue. But the following page prot 
update may see unexpected block mapping, then a   WARN  will be raised 
and it will return -EINVAL. So the worst case is the caller will fail 
(IIRC all the callers of set_memory_*() handle the failure), and we can 
know who is trying to change linear mapping before the linear mapping 
gets                    finalized. AFAICT I haven't seen such WARN yet.

>>
>> I'm not immediately sure how to solve that.

Do we need some synchronization mechanism? If the linear mapping is not 
finalized yet, split_kernel_leaf_mapping() will spin. For example, 
something like this off the top of my head,

DEFINE_STATIC_KEY_FALSE(linear_mapping_finalized);

Once the linear mapping is finalized, we can call 
static_branch_enable(&linear_mapping_finalized);

In split_kernel_leaf_mapping(), we can just do:

retry:
     if (!static_branch_likely(&linear_mapping_finalized))
         goto retry;


There may be better way to handle it. But this case should be very 
unlikely IMHO. It sounds crazy to have such complicated kernel threads 
run so early. I'm not sure whether we should pay immediate attention to 
it or not.

Thanks,
Yang

>>
>> --
>> Sincerely,
>> Yeoreum Yun

