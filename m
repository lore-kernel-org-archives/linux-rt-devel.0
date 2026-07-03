Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3CF3D45EA
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087636; cv=fail; b=Nu9Lk1EXScqkZyChUrZiR5Em2OnkqZ9vkENCMhq7xZhv/9APphyLqz8nTwBhDSrpqBmW0L2NYYDjsLyWWgKwX7GKIDW1LJ62htxNejYn8jfuL64GyTXWoNxzB72J9cPHpi8BLIzws3Ylya6NdZzO1BJ6iEUVoX/YB5L2fHujV58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087636; c=relaxed/simple;
	bh=MmZjOHG4Q7pWqfXA4CkGwwSlspZCXtX0MT+63QGAdUc=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=YTrZfoJsZLFA69pPrHnyCQFJWCjqYE0EQOASVgej+EsamqnRP4F0p0INzFwSSZkL58dOVjX8WyWTLJF1SaAXtksf/QHuCpMURtKBdVWsugD8VYrVGuNKHr0iFCJCFdwzyvec5sA5MVZ6UiwTRFc8sKfuWUdBl5mbbl4PbshMmTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FmJFlUM0; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FmJFlUM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSL+ueDbw1PJkWCzegcxFdkLjd+HwZH7YL6Icjep1jQ7A/3BMEuEB+zYOFDLE8jCsm8Hoy4720aaXA4k0gwqRRtNt7W7QyGijnhRWhbt44hwLAqNLgvLmr18lk9Q8SZ+YyO0vRMNsPGxjg73Btr8so9i6m/bY6EwbRn1gzgkcOVi+/jgOWCgfLZOmaGNcWSfsDuKUsS/hkXwq6kI1Ap7ttxf3SUlYur9E2t8xYdExzduXNWtR1xDfIcALqI/HFLvQoh5+oQpv8KLzAI8Vp7SlGgRpEMv6UY6BaFXKAo+QhM8CDLfVHzZ/kLIliMly6aQ6uY4ZZay/N+uBgsx+hJgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5SsvOiulisatS9mB/z4aC3rLtARcX2CCixaRThcDWQ=;
 b=tMNKx5tD1sQ62sIzNOfDWo3FWBjJ1lTn5dXsg32QnFMZQRimLtLF4Ck5uEc8bQoIxuzWJJ8p2O6uUyqIZCoUOA7Sa3UwxVIpjAGX1gz3YBjYwTImj4q6b7fHzX7tcsOLrL4KntJocHS2YrBNebWQC/LS3uMMEjI88Lq9CU7JuaBqrPAY1oHXXRkBaTVoUIB0bLQ/kCmoESLo6TZtAUzImpoheVK6SKjGGG6kuTS4paSJFHe2GrleAIlRKeK+8d8pB35HJ3WkjCjgjKfih2mYAzADAqz7QdebqA9dXKbaqLn4uwp5zxK5SRV8RJyW/8jRUzl19bvo944HmhQouveVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5SsvOiulisatS9mB/z4aC3rLtARcX2CCixaRThcDWQ=;
 b=FmJFlUM0SdTkpTNq2jWNyJn/QUxaq4UUie/hGuOMmTRs7BW/9/0aI7AjI8vipKOzHyLV/+9h56791TQwArrwvzHw/0bD6Ra0Xm4y0BILcPrL0piEjq4rgkKSJ/iw6dtcVaMRXhF/x/qpQh7qP8BeYhjkoKgkjzYV62N6ySpHQfQYN0s+IOKbO8O9xnCIo99uOTPHNmVM7cSCvX3QAn8nTrOLvgBxp2RMHueaADrRt/hoeWp5fBbdx2FHrZsoF/AbfHB6c2sFqdgl0ozIDNqIZL67ZmPKpvrfGaDOSOcsEJ4W6PPeKDcfE0slAwV1H4kKWtUYbsgg87GkmlBB6kVDUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 14:07:06 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 14:07:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 10:07:04 -0400
Message-Id: <DJOZT6IW4YGT.1U1IO3ERN9NMN@nvidia.com>
Subject: Re: [PATCH v5 04/18] mm: Split out internal page_alloc.h
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
 <20260703-alloc-trylock-v5-4-c87b714e19d3@google.com>
In-Reply-To: <20260703-alloc-trylock-v5-4-c87b714e19d3@google.com>
X-ClientProxiedBy: BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::15) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4294d2-cee6-4ee0-3610-08ded90c5d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|4143699003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	hw0R/6jp8qKkSodU/ltQoeNxKmw97YI9YBHdvsxJx45unYEoQoG9CK6YsPu6lTGRO6Esq6U92Yu7DTc/j3WuOhu+KhMccCwlDWnkv7GSMV3HZyGx3UaSBxh1AXtPvUYuLI2wq33eACKuR+cZhiQLloxOWXQWdC+wr4qb2ojSitXE478nmQKX4U3Bw25kuvnalpRoo+QV/Y1sDPepW9IqiJjzhzWgUxO+F7T2kxKwLx3boGpERchbawAR48QcUyNRgU7EoiP4XdCr2vB58bjUDxKzoWl2xvq/3lmvdA3rKIm72QjIcUEQ99+QLQNFBD2CjFoq5qfz/T7eK6vVtpx2/PrAwJHrxRPIWxtFxZ3bGO1nMO7jn3hn9GirOZCWZ/EkAKw6fJy0jkl0ssygiy2ir4n8k1AGi1mwlFT/h8Osme7OgUG7L0jtqWoUIPXA/Ngj9u95enZyTpd0AMUceSGwTPzV2DnGLjj4vxSGoAX1cvPGrk8mNWybciNPM5gBVXyOdSC00RYJfV/gSHlo95FgvZT+6lgTcfP6g/NThaC8KXJM5FqPqbYD03DVChaKd8SsUbzpZpnIwSnwsFbP+UUdsHEmQKz+nRrFzLz/Dph7pIiIDF0FAt+9uijFEGTn+waAilsLf2zb7mJLNazVVP8SDd6lRVfp0qJLQyIuHFU5yDI8sffT4DqelF2sAZt9Er3BGazMhIQWxM80ASdobHcF0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TThOcVFmVzRDaUk4bUFTQnBVNWJVOW1jMElpM3NDWmJJSnVOUWNQSEhEbHly?=
 =?utf-8?B?NkJFRmNzWE92NTFJYmx3YVRxMlgwVXFVRkVFM09LaU0xc3ltNVQrc2J1Q25B?=
 =?utf-8?B?MW5RNTFmWDhnNWRhSmcyaGU1QTV1QkhIWkRRS01CSTlPYXZSemoyRGZBUUE2?=
 =?utf-8?B?Ky94VkRQWjh6UmlyK01jM3cyYmE3RTZ6elBuQm1Lc3ROSHJlMElLK1dlV0Ja?=
 =?utf-8?B?S0JRaU1yRG1COVVjdGM1UmQyMzBKc2lqWmYyTFVhOXpxak1LVnBtclFMS3hM?=
 =?utf-8?B?b1p0TW9sK1Nqb2pob3JRR3BMNHZjSzZQNEpvQjhzcGNoVXFuNHZpVDRocVhs?=
 =?utf-8?B?R2M5U0RwQVhuUi9GSURwVFkyT1hpVFMvTmZ4MFNIV3BUTnRleGlqY2R4Qkpp?=
 =?utf-8?B?aUFBaE04TmhEQlFFUVFCOFBMM0Z1dVQvbE5tMU1vUUZvUmJSNUVDSjRWc0ZR?=
 =?utf-8?B?Q21CUEg0aVdoTjNvV1ZGb0poZVFic2hIdWtyNmdCdVNiR3UvZWR1WFM4aTA0?=
 =?utf-8?B?Zm1yOFRLNjVTWE1VWTA3b2dYRXhTMitIcDdaRTI3WE1jeThpYTZSRmR2RDkz?=
 =?utf-8?B?V1U0Q2tTQ3JRczd3ejZNaDAyTnlzODd5SHNIK1NLS0MvOUh3RDBXWkF3dzJ4?=
 =?utf-8?B?b3F6Q0VOc3dQcnZaYTRQME1nNWxsVnBNYnlFbk9WeklHZ2pqUkZqUytlbU5R?=
 =?utf-8?B?eUQxYndaSXU2eWJUZVBlYlQxcmVneEdtWXcwdWtXU1FaUEdYQU91TDZ6b0lt?=
 =?utf-8?B?TC9OQ2dLbkp6WTBMYmlCenBtT0NtbWxuL3JjYkV0OURkR24ycE9RYzZKT3hv?=
 =?utf-8?B?S3o4aWNwT0VDOFNnMFJncklHeDE4R3pGOHRzdFlSNCtiaFFYVGJGRmdoNHUw?=
 =?utf-8?B?dW5tRERPR3VOQnZJWGd3UWFHbDVpdlpHV3kxbm55czFQTVBSNFh5OWZWMnZH?=
 =?utf-8?B?cGNPa3VsRXRHeU5PbmxwNnpMaUJET2dlYTdVemlHVGkzSW9YZWhDWVNqZThY?=
 =?utf-8?B?VjVBYXBUQ0s4RnNaRHBpTGpJOWx6ZGRxSG8xZU4rWnFVUjVGTWwxRXcwZU11?=
 =?utf-8?B?TkQ2SHFuZWswRmhIR0FwWU16OTdMUWI5Vzl3MGJrZkROQjF0QThock0yU0RK?=
 =?utf-8?B?V1ZVek1LNWtER0VMc1BXMnBJU3FSTnpOZFM4eXNUaUtsVGt6ZS8rVFhuVTNG?=
 =?utf-8?B?Z3U0OTZUdXlxcm9WT1p5M3R3SFRMbURFL2F6R0hIWjBGNlJxR21MV1FDZUo3?=
 =?utf-8?B?ZHplYllnN21DSTVlbWNUR0xyMy9FSnRLbm83MzdiS2YxKytUNThKSHdOMXU3?=
 =?utf-8?B?MEJCek9nR3VnSERjRmM2dDA3VVdHcmZyeGE1OEFWOS9NRWZEM2hJSnk3eGh0?=
 =?utf-8?B?Y1ByMXJEZ0JEa2c1Lzd2dklRMmluQjd6M1VJMGxwa3Uwb25zRWwxRVVLb1Y1?=
 =?utf-8?B?UmN5elNQemRZMlVTbmhLeEIwQXMzOGt2TlBkSlhzazNtK2kxTmhLcmpnbkQy?=
 =?utf-8?B?eEFHU0VIc3czbXBoNytxMFJ2MW51ZXRaWTBJb05Xa1V0ZmNSZ2h4Y2RLS2ZZ?=
 =?utf-8?B?d1pPRHVkMVdjV21KTVpKZ3MwTkJmeHY3enRHdmdZSDQzMjJOWkdyT0k4Y1Z6?=
 =?utf-8?B?eDFOTm9lNlBnenlrUEw4R1Q4ZW53MWw4UDVTelBxbTdqdDdwLzBVdkNoK1li?=
 =?utf-8?B?cm91L0dtYkJlWVJBNUZSa2VSYzJ5OW9Ocm9lL0tqRVczSDk3emNJU2ZtWWhU?=
 =?utf-8?B?WmYwYnBrQWE1Q1Nuc3lmMHk2dVJBK0h5RmFPdUtZeEZZUUpQWTJkcmcwVkpR?=
 =?utf-8?B?QTRTMjhNb01hUU83ai9WcXlWdHlBanFsYmU2U3Jwd1VXQnNaZkU3SkdJY3pJ?=
 =?utf-8?B?VW5venJoMFYxeGcyc21kK0NlTE5rVWxwMndVVENlNk95V2tVa0lnSi85MGVJ?=
 =?utf-8?B?eS9kb2NUakNNWEhiN0ZrejczcjUrV29ZMXYvNWpkbGlybWhEck1VZExOY3o0?=
 =?utf-8?B?VVRBbGlyZUp0UTRTTWR4NVFvZWQyRVg2NjRJTmQ1NnBCaDlCWXRsNWJhajNK?=
 =?utf-8?B?aysyT0d5VUdZdGJ0YitFRVdmOG1ENDhoY0QvQnZNdUY5TDJibkdnTmZQNWlY?=
 =?utf-8?B?cWEwa3BJZmUwUUV4QmxReXVaT1RQUktRejQrdDhMQU5FYkgxVHhMRXYwTnM0?=
 =?utf-8?B?b2VmQUFSM2tHOTdSVlVnS3RWSE5WbzJmaGM4YisvMnh4ckp5VzBRTFpGSFFo?=
 =?utf-8?B?SHBwZHJaNTNPYkRZYXJjd2xvUDJLb1JPR214QkQvTzkrR3FXK3BKWFhwY0Vy?=
 =?utf-8?Q?Ssu2rRcuHunOD/RVp1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4294d2-cee6-4ee0-3610-08ded90c5d4c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:07:06.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5p5KO8PwWyAxsIBqu/yhjjGDyjUWr+ynhsqRo3f0GnuqZF25peofDJIMN4gm4vwi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308

On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
> internal.h is a bit bloated, seems like time for a page_alloc.h.
>
> Where it wasn't obvious, the heuristic for deciding what goes into this
> new header was "does it support/correspond to a definition in
> mm/page_alloc.c?"
>
> Only need to include it from ~20 .c files out of ~150 so this does seem
> like a genuine reduction in scopes, which is nice. And there's no
> circular internal.h<->page_alloc.h dependency, so it seems worthwhile to
> split this up before that inevitably emerges!
>
> Suggested-by: "David Hildenbrand (Arm)" <david@kernel.org>
> Link: https://lore.kernel.org/all/41e92bab-6882-401a-8de9-154adbdcfb36@ke=
rnel.org/
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  MAINTAINERS          |   1 +
>  mm/compaction.c      |   1 +
>  mm/hugetlb.c         |   1 +
>  mm/internal.h        | 252 ---------------------------------------------=
--
>  mm/khugepaged.c      |   1 +
>  mm/kmsan/init.c      |   2 +-
>  mm/memory-failure.c  |   1 +
>  mm/memory_hotplug.c  |   1 +
>  mm/mempolicy.c       |   1 +
>  mm/migrate.c         |   1 +
>  mm/mm_init.c         |   1 +
>  mm/page_alloc.c      |   1 +
>  mm/page_alloc.h      | 269 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  mm/page_frag_cache.c |   2 +-
>  mm/page_isolation.c  |   1 +
>  mm/page_owner.c      |   2 +-
>  mm/page_reporting.c  |   1 +
>  mm/show_mem.c        |   1 +
>  mm/shuffle.c         |   1 +
>  mm/slub.c            |   1 +
>  mm/swap.c            |   1 +
>  mm/vmscan.c          |   1 +
>  22 files changed, 289 insertions(+), 255 deletions(-)
>
Thank you for the cleanup.

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

