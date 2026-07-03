Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259C3F44C3
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089793; cv=fail; b=IrqF+O2KI17z25JmLEz7NIXHxMcjS5VPz5Ai8UJzlTYc6cXXBT5MExAvxsoQs07y8wJGqmpLOzaGWgHKHmOdoe5wJLFtmhdL3R1XRxXitiiruDqeJkEYWOZbocA2FTPu+1ApE9Q0S22gX8+t/v6NxuGoAhZnqrjX9sR8Wpr7MxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089793; c=relaxed/simple;
	bh=neMU2SwqlU9+n3013G8wQMD8/+ybPMEtqJcrBFa/lXs=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=XDAml7jdwgYT2sdIYnzA5esVFt8rY8h2J0lNrJRDmKzYvELn2N8WQwpYTXtm/6Ozc32mLibKuQ8atEa0HYLcBDgLEgDzxgQHNz8lNdNViAsoHvMlGhpINoxlU2hX8jN5zAYwWc0SGyBePfoAaobLt1ebwKYvaG6BRtua6WLNzs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l1pv+bN0; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l1pv+bN0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DybtoVpyFTPEPJrF3HqqO1Xq9EWfjgkUGjbLzh0cDKcVTo285KHzgzvmndIeg+WOZ0KSD0kwsEeuoEFv0oyyRyavKSp6PnAZUERJOC0rNlz36RYrNVMA04TZhIqJ2T0Qv41oSS4PdCZ5hMkqgAGYTexhjT5nnSDrxjlny0XoMrBOdQ9h0r4EIKJFwQZ1TLaoc0oLM1N6oBOFgB4IGoIXAovjdoMFs2ojozMq83udXQZQqQyieyR7YH2clb3f6rItRP8A8Kksy+V0e6m8ykbqwxMXCJiAts1hI5CprDjrg3jJtdDxlpQf/IF1mgjnWO10bhdd6iy7iB1BiitsF1xqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59r3adBU3T8PyU9iqduPBMVeNlmkYGNnGK7aXrJUsps=;
 b=gRs2m62+N8ofkUlc3LGst15ThD/wxeXNJOfFzcJn/gh+bHr+nymMp8h43qbdXiuxFUxrPQ/sQAcz0wBkL5mBFWaBFGAJIk1zsQZGISgvvxYicna1H152Q1DVlOtafClkSmVPCeuih47DOeEUSnPJGdnKXpBes75sMXN+wVlP8bJdzRsmyNfJDdmmj6OHzncz9FrowjkCvTRFHrc/DAZRUPGTxzIgQ/4CYUlBNc/j2/nfiKnfu8xA4JEfbF0SMu4xERZEwI6nkTI5LMgFxxA9X2MDEIzSeQ9kCWj1nC6DKghxWzddUGl20YEtdY/VqTHX+LKHta7+rcE+86I/iC7Thw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59r3adBU3T8PyU9iqduPBMVeNlmkYGNnGK7aXrJUsps=;
 b=l1pv+bN0iUj33S5489OT1yPZNQ4cUh6oG15CexJyRornt92atjC/18FHmPDjBElhBbcvxorhElFjAB9eYmUrxkyaZYQZRijvxiQW8p7plOs4JTBqrme6UgZIUhAr5+rsshOVBCEtftAWlj5SjjCyX88NJ4R6cYKCxHrd9pSMvyz7C+BprP3Y9e0ooD6Y877+HJiYbMzn6eC9oaSgb+TVA84HOaS/73RflzrOaKRSV+BvGEv1Ub5ma8/oE3+qEmb+75ETqMhXmeQ+7X5qP2O4HkzGNpjLnDU7MGykxQQ1DELkhvqNBCSs63oJuCIsdyM3rxWlzYXt05xclhb6biiBLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS5PPF18A985A10.namprd12.prod.outlook.com (2603:10b6:f:fc00::645) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 14:43:00 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 14:43:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 10:42:57 -0400
Message-Id: <DJP0KNE4S3WN.209EE744YM0YT@nvidia.com>
Subject: Re: [PATCH v5 05/18] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
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
 <20260703-alloc-trylock-v5-5-c87b714e19d3@google.com>
In-Reply-To: <20260703-alloc-trylock-v5-5-c87b714e19d3@google.com>
X-ClientProxiedBy: YQBPR0101CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::25) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS5PPF18A985A10:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf23909-846e-442c-bb17-08ded911610b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	RzYimLoHavZxDv9X6//UjMaOC9kxyhHw9nAt36InkH5J80xxRJWqSL/TJvv+zd2m4zDtg7kDhuCXMI3fGPngW8gT47frlCip+VqbLa8qJx8HqPQ2XytvPwTRgt3Jo5mRTLyazSAa3H6qxHIkpjtvKqaQ/UU+Ucr1xgp7OF10Dy39E2meUOES/1RJTzeaPaDWuI4T/tBzybXIjIsCFwbNQfja4hKYWkBxIc3nnKwr5U8laxtTGheJ3YwOyQkmSgc77cxP/HG8LoCIStni5j+SfyBybpOCgOAtVwQ5MlF6Lzt2XXJKQXsekjYDPFIWkO9qiMX4hvBs4veXfQzbsdv+xw/qJ8BUDclG0WCsccSTn+UFFuRAxgdeIGX13UjhNAxD9cd74lLPJ2lhxBkc7sTN/oKc2ZPZ7g3ak8uzRGRkJ9gmS4wOjUNPinw0JRaRkEuCWRcbzZYzgRLP14JHWHMh26REbL1t3yHDi6+da5RuTR+SYwGseq9bbBWWQY5IBZRspxpztnPo9dQovSfAFyYKmzvSD674stUoE/qrRWOzlFvhLCH/757QHpbYRDAaYNkxcTM8UPabrnYFPfgrWMI9FktyxYh78pr2MPo0kFczwaP0vRxghEKgKSF7pXkubROyydNbHejLx246YCrib/IlLcW0L3V7bIN0n6Ua0nkml5UhFVlH0nViioGLcvYmRrxTvKj0OpSa3Bc4g7PbTTqX7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzRmL0hCRTArRFhMQktxTGQvRUc1a25uZEhBbDZvYWd6VVFwaHIzcjlSVllT?=
 =?utf-8?B?bWovWTVTQjhoWWdsK0oxaDY3bWdUTHJOYTF5bkttRHNHZEhhZjVJNGlWajd2?=
 =?utf-8?B?OE9FcVRhSkJlb0Mwdi9vV3Q3cU9sWEMvR3QyWmNSRkU5aXo5cUtDc2pFWElT?=
 =?utf-8?B?Qm9QQmVxa3Bwb3ZreHNYLy9LVWpkd1dOUkpQdFJ0aFpTbnVpaXREd1lSUTJp?=
 =?utf-8?B?eUNkYWtTV3RLcDNzVHdzTWxQNEhSNXJlNlRPR3N4R0FVS0J6U1U1eldPVlVH?=
 =?utf-8?B?bEEzZitFZEx5d0lBRlV4MDVYNnIwZWNYN3FhWWxyZ2tyaFkzS2U1ZEo2ckxW?=
 =?utf-8?B?L3hISGh1UEloMk83a00rRStNM3dDbmFKdGlzcUhoWUJLMjZXK1psZFJuVUtR?=
 =?utf-8?B?bFNtck9YamFlQWRTVFByQWFPbTZ3SmRxZ3dJUUliZ2ljVk9hbHMreE1tN1Rv?=
 =?utf-8?B?QTJhd29FOGl5ZmFuVFl1TTNJRkwwRUMzRlRMbWFuT2hjRC8yVXRTUVUyNkEv?=
 =?utf-8?B?aEg0WVYrbTdDSW5LNnNSUlpGNWRKbjlSQ05pdkVmUy90MEFOVXVTTS9aOGor?=
 =?utf-8?B?NXpwcE5KWUQzeVlMWFY5VnJ3NHpndk9NU283TFptNCs1L0RYalMxRDUxdXNr?=
 =?utf-8?B?ZUVORVlPZk95SXBvWFhWUjhVeTBTQ2JvdXRGem5hRWpGdnhhQXAxTmxJUGxQ?=
 =?utf-8?B?aitma3BTUXZtRVdSY3llbWErYjV2ekErUGQ4NmhhdjZsM2lVZm1mOFlXdXlo?=
 =?utf-8?B?NVZtWXJYQXdNdEZ0Tkk3OWtCVnB5Wlc1bGdRYnlTRk5qczF6TlhGNVY2RjF0?=
 =?utf-8?B?bG95NjRKQWsxOVVJQVlHTXdmNHRkdmZKUm9ZbVp5anpRazM1Q3dFeWhlWWxL?=
 =?utf-8?B?OTl1TlplNUtnbUpQcm8vekxXVHk2eS85RFpXbVI5aUxJdENGVDlsSDFmVnNv?=
 =?utf-8?B?bmZpSkI5NmYxOFFpRzh2V0pxZmk5Q2QzSnBJY2FrOWc0dUNaZGViQklUL25l?=
 =?utf-8?B?M1JTR0k2WG91RVprZDVUVDhmdzd4TnpKMHdrd1czTC9zWkJNSUgyK3MxRlI3?=
 =?utf-8?B?bVd2ZUdLbUJDRjhyS1ZSUCtEU0JUZkdiTk5TNWNDRzIrKzZDNlZCY29FeGN6?=
 =?utf-8?B?aCtmcmY3eTlmQmlQTHNWUTRrYXFHNm5GQzF5T1JTRUJMd3l6WTZ5a25rV3Rh?=
 =?utf-8?B?WmFMa3JPbGttbG5MNEdtQVBZanRqWHBKQUt2TWJBVlQrQ3JSVVN1Z29GWDFj?=
 =?utf-8?B?TzJkOHR3enhFdkJ3dzJCS3RzVlpxVFFqUlo1bFlZaGhVNlNpZ2UwdyttbGZQ?=
 =?utf-8?B?TnkzVktFTkZmdS9uVUlENTNuWUdJbkh6SEltZERLY1ZNU1Ard2dXb3hhSU03?=
 =?utf-8?B?cmZONGZHM2U5QlU0YWxaR2NLTXpOTmNYcWJ6a2YzSDJCRUExVzcrYm1FV1VD?=
 =?utf-8?B?RzlOenkvMXRvU2ZCK0ZOTS9ybWtKeEd3bW1KTWxQVTVyYnFxK2FwZXNVcWZi?=
 =?utf-8?B?eFMwS216L3pwdzA0TjJEM0RSNEc4ekdJNG1LT2hHNy9vWVJjazN3Y21qTVF5?=
 =?utf-8?B?RHdCbXpkQlkxT05tZ3JUQWRKWkcrZ1RNWVU3VTZ5SDR2b2MreWhqT2RjOGRu?=
 =?utf-8?B?MjkzQ0tPUWhqbHhnWVlDd0w5cW1WTTJ1WWVWYW9yaDZHMWhVaDFuQ1hodVlT?=
 =?utf-8?B?bks1bVFHeUZnRWdPeVlCWjdybVp6MW0rRWZ6bXc5S3ZMSkhOcTUxQVVvdFVP?=
 =?utf-8?B?VXFCdW1FY0tISFFlaGNsS3czclBJYUZZcjhTSFQ4VndHRUszUGtQbmlCa24r?=
 =?utf-8?B?YnVINnplVHlZRmlkd3RuaWgrbmZOK3BnUHM2elZVaVJyNHBreVBQTFFlaVdr?=
 =?utf-8?B?bHQydWVQdGNWdGVTWjFUbnNyTXowOGw4cE03WnhxeithMm93Q0FEOEE3cVkz?=
 =?utf-8?B?VUlsL3FtMDZBL3VoUTA4a3RkNkVSdlZkOFJHNHJJV3ZRZ1VLY0ZTdFQ1d2Qz?=
 =?utf-8?B?L1ZkZk9NZ0t4eitNWHMwV2lkbXZ3dlhsdzNCN1hSSXVvaVBiSnF3ZmloeEV6?=
 =?utf-8?B?YmdtUUR5OVE2SXkvbDRTQkwwakJoR0J4OE9NZmZpKzgxQjErekNwWVNTeDc5?=
 =?utf-8?B?NEZlNHI2SWs2SUlWRytjOUF4Slh2bE4yR09RcXowTWhDWmRwRmozamw5Q25Y?=
 =?utf-8?B?N0RoZGFEbmpxMGhhWTZyRkpxdXJIRmU3L1dvSHd2YnlZVHZmNk5QdmhPK3p2?=
 =?utf-8?B?ZTRodXdoTHczTWRTSVJ0QWh1Zzg3WHAxS2k1UlAzek52T0QxWEpFcGpWekEx?=
 =?utf-8?Q?mEOFN5Q8WEFWOaWoVu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf23909-846e-442c-bb17-08ded911610b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:43:00.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsKX9NR8wFFn5RKVjeNaWsBn4QsAqfsiM+vmvueVILDeGpiMZ4z5tArntjLMA6wx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF18A985A10

On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
> Currently the core allocator code is controlled by ALLOC_NOLOCK, but the
> main entry point function is significantly different from the normal
> __alloc_frozen_pages_nolock(), this is tiring when reading the code.
>
> Plumb the ALLOC_NOLOCK control one layer up in the call stack: create
> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is only
> exposed to mm/) and then turn the nolock variant into a thin wrapper
> that just sets that flag (as well as handling NUMA_NO_NODE, similar to
> how some of the wrappers in gfp.h do).
>
> For consistency, set ALLOC_WMARK_MIN explicitly in fastpath_alloc_flags
> for the new ALLOC_NOLOCK path. This was already "done" silently in
> __alloc_frozen_pages_nolock_noprof(): ALLOC_WMARK_MIN is 0.
>
> Rationale that this doesn't change anything:
>
> 1. Simple bits: A bunch of the nolock-specific handling is just moved to
>    the new alloc_order_allowed(), alloc_nolock_allowed() and
>    gfp_nolock.
>
> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>    previously in the nolock variant:
>
>    a. Application of gfp_allowed_mask; this only affects early boot,
>       only flags that affect the slowpath get changed here, and the
>       nolock allocation path isn't allowed to the GFP_BOOT_MASK flags.
>
>    b. Application of current_gfp_context() - also only affects the
>       slowpath
>
> 3. The slowpath itself: this is now just explicitly skipped under
>    !ALLOC_TRYLOCK.

s/TRYLOCK/NOLOCK

>
> Ulterior motive: adding an alloc_flags arg to the allocator's
> mm-internal entrypoint can later be used to do more allocation
> customisation without needing to create new GFP flags.
>
> No functional change intended.
>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/hugetlb.c    |   3 +-
>  mm/mempolicy.c  |  10 +--
>  mm/page_alloc.c | 192 +++++++++++++++++++++++++++++---------------------=
------
>  mm/page_alloc.h |   6 +-
>  mm/slub.c       |   6 +-
>  5 files changed, 117 insertions(+), 100 deletions(-)
>

<snip>

> +/*
> + * This is the 'heart' of the zoned buddy allocator.
> + */
> +struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
> +		int preferred_nid, nodemask_t *nodemask, unsigned int alloc_flags)
> +{
> +	struct page *page;
> +	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
> +	struct alloc_context ac =3D { };
> +	unsigned int fastpath_alloc_flags =3D alloc_flags;
> +
> +	/* Other flags could be supported later if needed. */
> +	if (WARN_ON(alloc_flags & ~ALLOC_NOLOCK))
>  		return NULL;
> =20
> +	if (!alloc_order_allowed(gfp, order, alloc_flags))
> +		return NULL;
> +
> +	if (alloc_flags & ALLOC_NOLOCK) {
> +		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
> +		if (!alloc_nolock_allowed())
> +			return NULL;

At first look, I wonder why __alloc_frozen_pages_noprof() needs to care
about alloc_nolock_allowed(). But the patch's idea is to centralize all
allocation policies, so it makes sense.

Ideally, I would want alloc_frozen_pages_nolock_noprof() to filter as
much as possible, so that __alloc_frozen_pages_noprof() has minimal/no
awareness of ALLOC_NOLOCK. But ALLOC_NOLOCK has different preferences
compared to the default __alloc_frozen_pages_noprof() policy like
ALLOC_WMARK_MIN vs ALLOC_WMARK_LOW, skip slowpath, and more. Maybe we
could do something like:

__alloc_frozen_pages_noprof()
{
     alloc_fastpath();
     alloc_slowpath();
}

alloc_frozen_pages_nolock_noprof()
{
    alloc_order_allowed();
    alloc_nolock_allow();
    alloc_fastpath();
}

But it still cannot remove ALLOC_NOLOCK completely from
__alloc_frozen_pages_noprof(), like the nofragment skip. Anyway, this
patch is a reasonable cleanup. Thanks.

Acked-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

