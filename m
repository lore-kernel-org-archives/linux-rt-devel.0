Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF7258EF3
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091533; cv=fail; b=SqJNE0cQK+L244wk4ZTbrcSk3l+EtFlZw+1t/hfoUqWITuHsLiLIZVW6S2AXQfW1Pd3PTg/ZvFYQSfbTjAXR1XiDxBH2zOVgDyBRZeL0INik5o3swT2B+U/4L3p6bg6gfgi+6xzWkfTYwobhebdQ5rdakLSHtpSJiiU3ox8m2ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091533; c=relaxed/simple;
	bh=tkQs878eya/U5Z8AXDpkmoMYZ0nPR92JibkUCj+mYj8=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=RER/C5JSNqvDquZTCMqE3n/UdN7TSRGF8JtrSf0kOc1eAV5mROr92OQa7MbxPR401+yK9gwuDjtFf0Tuc2bKUO5ZkJlMT9oty9rko9U/c1v9X3AWifTym8LhbaBQziiWigcBqa9/seQpKcidc0oj8xXlJf9aJkuNNZmKr90eO7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dXc+wKw/; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dXc+wKw/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwqIo+3kgkRYFN2bYnmJo7D4ZGoK/q+9/0qEUeD1YrVYh4wyFB18/1bRWjpRxgGJzgG9ox7HCV3xTKn0m0PLN8KDBpB/ZYVo1KjZW/Iv4K7R0zPmySkzcA1s8ppen+UF4IgE1pmV+5aetX7w10uRV0OwszKZkqWd0UG6VmSlBEPBH76SVkuxNxgl6YvmFJccJRTKG66tMFRuWBD8VF4TwSdLa6oERrOwi7954RCN9mJ4577Rl0X3QcbY5vBybROPYSIKAJ3vStgmh9K1OnB7bkxj/foG1uI0b3FPtDnM9BkDpSFS3qZsZcTwQZaDbXl3e0RRoz5nsiphyAQkkPoJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC7lbBP4k4Ej7jn1zArzr+0W10y2aQ4Gztu9a8RlR5E=;
 b=ZGLwlogI6Jn/uOoODKZl68Vq7R0KLIsi9RD2SiJ8JQn5oZ6SAWtBJ49DP50qmTNxeAS+wfqNioKnNumQoKFMB4CUUt6s9uyQSqPImnM3pUO6cOHzQMP1qJu7WQ3/OnqKQTUViOyt211ZjLe1/sfFQQZhcRWBTshuh3ervAyebWR/ygftg8v0YAZ4BpE2PJiBgp4GIeYERTddcLGQ+xK0UikTuj1/fZjHFpjvjEUMFicadszkmmqjPjD0IS14T2Bqz2fzB62JvyVi76O5SgSXJ6Zkhah0y9iZOE2XH/w8PZ53Q8kAuu6Bp1lNgFERvMqQuIo2Mu6clAHcV0Sy+28xGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC7lbBP4k4Ej7jn1zArzr+0W10y2aQ4Gztu9a8RlR5E=;
 b=dXc+wKw/rhwyRyW7M/b70kO7gacKfKcnWGCSPC4oZUtDk1h0dzjkuf0tB76ex6xCErZ8qWX3yEfEOl2TXCgQ8yHtkpkUuqVn7a/Am/35htRWy2wK7wzqJAxR6w5zQw69gbc9QdptirMF7furyCPrv+et+c+Bq+dGTngRgtruZfB8r1wexHEAIV9VoJBqWK6A9eESkw3B5cxZBJGWW4FS5iVVAbqYymlMxLTBSH8v7gPCM8XXy2DSqK0BJRSiz0gz7sd4phuz+CXRe6nHtQOF6pTkO76PsK7vGWqSapgAYpLJv1ZCON72VdRhQABf31gTpkpxvjeOe+37VhYhmFbXHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 15:12:06 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 15:12:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 11:12:02 -0400
Message-Id: <DJP16X8Z3PHE.2YG36E6NWWDUV@nvidia.com>
Subject: Re: [PATCH v5 18/18] mm: factor out can_spin_trylock()
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <derkling@google.com>,
 <reijiw@google.com>, "Yosry Ahmed" <yosry@kernel.org>
To: "Brendan Jackman" <jackmanb@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Muchun Song"
 <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park"
 <byungchul@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Hao Li" <hao.li@linux.dev>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-18-c87b714e19d3@google.com>
In-Reply-To: <20260703-alloc-trylock-v5-18-c87b714e19d3@google.com>
X-ClientProxiedBy: DS7PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::10) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc5def0-8e18-44e7-731a-08ded91571d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|11063799006|4143699003|18002099003|56012099006|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Q0V9Ruq9KXp8gOHp4wr+tFMpikFwDSjqooi/Z9b8kxUT1fN6ocjvSx/YqbdOXfCrVwlNWyFYWwInQ4QhIXUDtZ++T8VLoWO8AeCIc79StenAjQLrqYZB11AXjYMzMSI0P76SAvV60EnJiMKV0zp3rG7EH6aqQur0839M0zXlwhOnRQQ/AUQBSuEtR7cZ53MNhZSNWpgphGG7l6PNfwBU8zd2IaODUgak2njQLydmm7Al7phf/RP6E8im42ECWxb8ZPJt7/yxq/FftODEpHbICF0xELE6xDoIcb0XpDsbk9fwx/5/2oasuJEAUA2p5o48m8ukEaKU+KIhy4manPkxn1zNylqjA7j5/nJeVBicXYr+wJLeNxfosN8u74ubav0GKecP3nlvaXM1k0LLZX4ISAFrksN1HEwRfLrI3ZsoTQ4l8kaJcDbMK33UjjfAE7vFSB1Mwf8K2L0wu+Dbq0SzHu8MTsg/wpBsM6sjNynSuHMC+2JI+QWsBBChIyLi0znqQhkBNAYBxtZDWWObOqMjB9GM7tENDturS9OCXaJ1D4HP8Z8kSitYRYRYFePa+UloHIBB5ut+Y+7Lk+WqSzC5zIcCYuJfG4SxQpCMKyCZVMM6eZ7QaAUG4xp5JMFQQh+aUZC0JxsO0qGh0sOMjgOR6KmFNOOUbMzl+PSV3WtPLHbMzpz5WWuRgmMlUrNqVjBKuCAN/AIQzQ3AwYadPUMidQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUVEOGZYdDlramZxaUxhUlluRzQxeGkzSHBJVFZkMmU3MVpOYXBsQkl3cmRC?=
 =?utf-8?B?bEJJT3VJQjhnSlhwRXk1c080cGtLYmd6K2JVL3hjdHZJZ2liZWdpNU1zSml4?=
 =?utf-8?B?d1BHazAyT3FEdGduVGhwOHQxNDZlOW5mZTUrS3ljaWxsenNYL3M5MTFIZEc1?=
 =?utf-8?B?K2lrYWs5N3hFcDV4YlpYeWx3OFd2YlJ2Yjh4WWs5aTNBSktrbmtFT2d4M3hp?=
 =?utf-8?B?aGxUcXpIZ0ViWEtRTmRJVzQ0d3VFNU1mT2M4em1ZZlVDakl1Q1gydnRKTHBp?=
 =?utf-8?B?NjhhbmRBYW12VzljRlNSVmdaWk8ySEYyM0w1cWtKeEVMRWpUV1o0WWF2VU0r?=
 =?utf-8?B?UVczdDJiQzZSdUxBVUtGbFI1T2tvT0JUc2x3Y1B6V29hbDZ6bFVTM2FOaXRW?=
 =?utf-8?B?aFp6QnJJSGZXYTgyZERGczdob1hreTJPVjBKSHlROFNJSDRFQVlkZ1grRzFY?=
 =?utf-8?B?M3ExSHpGSTcwYnJ0R1ppdVVldzdoZjdOdDFUVm0yQnhpL2JNSzhNZ29qalkw?=
 =?utf-8?B?cmdRVXFacW1OUU9YeHE2K3FaTURQQTZRQVNjcHNyVWpMV1BXYXJ6VVgxcTYz?=
 =?utf-8?B?NW0rdmlLMTFrcHExNmV6TXg4VkM1WE84YUg5a1FWUnNMYitHdWJUa2dGVGs1?=
 =?utf-8?B?Ykl3T0M2NkV1YWNVY1BaalcyTWJ0Q1o2MHhKblZ3a3hCbkQwekl3THl6dEFa?=
 =?utf-8?B?NTFzMDZpUW9OSDRQbkRJV2cra1VCbE9GaXllbzBOTHVqSmxNRmtOL2JPOVAz?=
 =?utf-8?B?OHU2TnlYNjdEUWROSit3M0FrVldaTFRydmdpdll1UWlxVFErb3d2Z1Nid1Y0?=
 =?utf-8?B?bWh2ZVZhTjR4TEtxUmFuc3lON29VZGhNMjA5R3g0TWNNTzBnU1Zhb3N3K1ph?=
 =?utf-8?B?SkNkVHEzQmZRTTFlZklDYkZRMXJnZnA5N0xvTHArMlRiZ2pYaDQ2T01LUUx2?=
 =?utf-8?B?VGpQZE1iRnplSG8rK0lKalZZK0xWS3AwWWpqY1R3ck01ejhqVEJlb1BpU0Zj?=
 =?utf-8?B?NFZyS0dLbmY2QVJReDlSRVMrTm9IZ0EwWXphZGVvd2dSMjI1VndHdlpFQVFN?=
 =?utf-8?B?MFJWRS9xRncyNHRENEt0TmQrZXhqSldyNHgrRDY3YjJ2ZUh3cnBlcWkzYjcx?=
 =?utf-8?B?bDliZjBORXBXU2VlaEU5OEpTa3VvVXpEVzFoN3pETldvVi9scGtnVFM0WjdS?=
 =?utf-8?B?aHZtUThuczZmOXdVYytETlkzbE9VcmhYWEF5OFl1WE1qMXc2ZmI4OXZDMzdj?=
 =?utf-8?B?V0FyZDBmNHkvc0JMaW5tb2JhL0pIYnNCYzBNcU1KVmRvQmZpdE44SkRXT25J?=
 =?utf-8?B?UUU2U0RoZmd4a0JadllRZ1Y4Q1hVK1VGaEJBN2hpMTFQdXpYSmJHWjg1RkJl?=
 =?utf-8?B?OGtZNnp4UllFaDBTRlNkc1JhNHZoNGEwSzlUQ3VCNk5IZ3J5VkhBbkpubStl?=
 =?utf-8?B?QjRmbjhJSEZXWWtPOTAyK0p0bXQ0cHpwNFlwQzNyV2psNzNDSS92NjRhVFpj?=
 =?utf-8?B?UEo5dkx5ZEZwUVpENkFlaHlDeGVJWmNLblMzb1pEZ2hZcUFZSFpsMVdzZjdL?=
 =?utf-8?B?NG9IZlBvMkZjQWNvYWhhZGd3WGlHbngwaWU3SmhMS1lVYXh1RmZVNDcrWWNE?=
 =?utf-8?B?NkRBY3MycnI2NVI1VEVidklKMXZNa2VpbHk0L0hMNHZxajBQVkJSdFpHU0tU?=
 =?utf-8?B?TFVNb1RFeFpub2VLQ2pWVzB5MmowWHdSVGR5aXZZL1BsWE5MV0lmS2JsWTd4?=
 =?utf-8?B?eFhkZzl4NVNNV2txang5ckRyRkYrTS81ZCtRRzFHQjk0eTQ1OUhCVzlXK3dC?=
 =?utf-8?B?Qmpkd28wYTArY1BxcjhJVUJBMTVLUkMzeUdmVTVXRTlJMldmQUN4SU1WNGRK?=
 =?utf-8?B?Tml4TmRwK0N5UGFmUFExS1JEcktNeEpGYm1MY2Y5L1ZBV1RFNVNPekNZWnU2?=
 =?utf-8?B?R2l6Q3IxZWNwQ0NQQ0tLd0c5VXk1MVRKbjhqdUFLNHFiUkJ6b2hNRXFpRFdX?=
 =?utf-8?B?aXlkTTFvRkh3Uk9UdStFN05xL1l3M0ZuR1FybGFxaHlDMk9NdkxPUXFMdlVJ?=
 =?utf-8?B?SUkxeDVHcVQvRlhETml2SkhGdW5xZFh1R2EwV21BN2N3dUdEVzZkUjh4VE9m?=
 =?utf-8?B?RVpLYUFGcEY4dXE2ZnVWM3Q3aHkxUGdyd05XYmxxekFQZmxXT0txNkpNNy9P?=
 =?utf-8?B?eTRMSEw1VlpNaWw0cUNjdEZHNHpJRzVqNm1rcm5RSUZBalAxSWsvUkZwUVJD?=
 =?utf-8?B?OHRZZyswRVhMRXlpblo2T2wyZGRkU0NZUWYzMU5wbmphNHZoUmwxY043emc3?=
 =?utf-8?Q?4TCWYM2o7ck6zw4dRr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc5def0-8e18-44e7-731a-08ded91571d0
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:12:06.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FxSHnKFUiYf+0o+ZhKSWwW3uX3d7pNS2dNC9C0EPMoeN/HaYT21LyPl5BvI62TM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347

On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
> Deduplicate checks for whether the current context is safe for
> spin_trylock().
>
> Does this function really belong in mm/internal.h or is it generic? Not
> sure. If someone ends up duplicating this logic elsewhere in the kernel,
> that would be a shame. But if it goes in some generic header, someone
> treats it as documentation about where it's guaranteed safe to
> spin_trylock(), and then it emerges that there are other subtle
> preconditions that didn't affect the mm usecase, that would be worse.
> So, just be conservative and keep it local.
>
> Suggested-by: Harry Yoo <harry@kernel.org>
> Link: https://lore.kernel.org/all/397859cb-b127-4cc6-9c71-044afc99bf0c@ke=
rnel.org/
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/internal.h   | 23 +++++++++++++++++++++++
>  mm/page_alloc.c | 17 +----------------
>  mm/slub.c       | 10 +---------
>  3 files changed, 25 insertions(+), 25 deletions(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

