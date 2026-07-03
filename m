Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4E3D3335
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087165; cv=fail; b=oKcNOvxvK7Y2OHwOE7x1NlKQ8GwiFEMMjm1zJ8wfCtg5lOaYcJXzN5tz1x6CmUjcSgyVyvpGSgqnZNsJux11AcrArnfKyYzU85bG+r0rsD0aeVPSjS+lcUYu6jkp3s40WJDT0vW5/CUKAMjzfeNmvW0E9BGRiFWYon0bqYAKCHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087165; c=relaxed/simple;
	bh=9ZwRhsWHCJ0UrDCpW6rIvVxzxkvaWcOgLTDbrcn15rk=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=fhIb0Q4wzoJGjV1aVVcDOPJ3mWgpUMligxCXuYDYs3qRVm98rr7g+NckdSGVjlnMxOS3JZ3eysRWN/4RJ7CBYYqzj9bBIhK5Cpy0BNmnpr1+pjh97R3G5VAzgwQKgQGhyzHKU44Ix+NLv0Rq3tC39EMj1+ea2D7tG/ak8eZZ38s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fFcRuG5G; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFcRuG5G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ash/M0DamuKPsBT0oPs3XFSLil0QN1zCXKmw14PgTEtgldZ3GjxLrMX1jrGShiuDzDPIO14l/LaZz+DA/S1k8QqS0mrOh/yhbPuN8RY2RRml76N3nGm8RKjU2K0FFushxMsbfdIPOfw7Ywkj4c6m7QNpuS0N5XxBjZjBEiZMwEQlDmb5Z7VpR+pN8vtXF9FIYUmWGHXZsbpQGg9TcQ3sTK6m/Iaq/dFlUt4ylCWEZYH6pj/6EA7wd8k77E2Q0q4HwHX71l0sO6Jvx6qTgSTfqjsjrkC9xym1zh3VIDVkFTDqSagqEMdV1NwFsdwgjm7iO9eVcD/YqKqR17LrG4gQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+s5ZzETTJY4rrTeXRhkk2snrj012xgpjRqSropjxvQ=;
 b=bZpeuDrx0mBkSBoBuyaM8Xc8yHccbFeMMRzDhLUIysRFyiE4lEH6xcILAMFHTr5AVtAKBa/srqL0Y2YNecBnxvey6i02xbNjPkgX0PHKXKJ4Ql4yQNF3ykVjhJmSPwnhZ3BTVnc7B50hc3avXno8otBRwhAIfNDhCbEHeKnvb8tyas27SMSHN0HAK600Hdl0nYYvMtK1B1Vjzjo/Ws2VgZ9pjp8m1yTLH8wZODvhoiPpNYUnz2NS7vC/1N2AkdG/mWeGnwj3iCUE2q9EIRJP/ylZIvZLScA2au/GTJCSj0CSfpwyQ1Po5CfCxbYj/Y+7QE6aaRUg705O7fFnHFw9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+s5ZzETTJY4rrTeXRhkk2snrj012xgpjRqSropjxvQ=;
 b=fFcRuG5GWmqNinlqO5kXZSU9sTcqRBm0jGLksN35X4MsmKx0gdteBTQhVOFFoM12uec4S6Qzzm5+Pbf/LUqyjmDm+CzjSqHekqRtnHjyU9jnRgLs9mjfW8gMDMLM4SdDFyaRr12nVQg+gcjAt1aKTJ5wXG88XxYYY1Fd1Tk6Bs6SgYUCjhPqtwrrbMsKoreB9YPl5Y82UHInlTkfGBxP/HXtl4JCbtbpIGxRc+eVJ23vAUIfKGUjvqRXnw/+Rlqzf/fg3BvDWdcq3KAgdNpfZ8xQvpJR/d1z+goKsgi/Cl1wZ0gAYfaNxmLa+ZeHfDekK/1+2+qGqnkMJiQFiZKOGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 13:59:16 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 13:59:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 09:59:12 -0400
Message-Id: <DJOZN5H048UX.1ZVSFD48QZN05@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v5 01/18] mm/page_alloc: rename ALLOC_TRYLOCK ->
 ALLOC_NOLOCK
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
X-Mailer: aerc 0.21.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-1-c87b714e19d3@google.com>
In-Reply-To: <20260703-alloc-trylock-v5-1-c87b714e19d3@google.com>
X-ClientProxiedBy: DS1PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:8:23f::8) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: f93709b9-3361-4948-3694-08ded90b4554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|921020|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uCN63sQEdPA4UiyB1jmm9AreHEbVxWB6VmbYIGikH98H6lg3fVLNON2VDlg4QhmZU3is3VUK5pcmy4Z4c9CER28rm9W4WfuEtVpMtm68sC7a+UmWE+VHY1DHFy3oEyAaEexOvrZtDJU+GDuVykJ4tUxJ8xMQegs13DX5aLV4o82kcm8yoyiOfXrEFl4LhBoBC52JkxbPnfjpPUpDnbPXS+xwg7cKXLYEfWLOn4LeRJdLj4a/NHvQyWo3fJGUu7HUdMIpuYMSeGoF43LRLQ9LG40RfFzuvRICjWozu3sVag8K+P7EAj2KbI4QqzsdUT9cfG3KExFBbb4FiCDRUXl2lNn5Mz3sH+BfJt0yyRx0CKsFbbgz38hda8uIRF8AgEnjYt9iIuRhyJAyROHDGUwr6mBXfALmUT7Y0M3JLFvoEIt70heS6UQpQtTfbSvgFN3LzCfw5pGaUKHVUhqGPJjFa1qivi7wreNE6pahKoLXtYgZ431t6PzUhGeQc09kINysqZ2X2rYrjKkr27s14f4rjs7cqErEAuDQRUYV3EhaoQ+bC0gLPdPp14k8DniQSPyiZ+BPJwJ0s/Jpm8485vHizR84GbwKjxkUJ+2bRWJAwaLedRCbKFdOl5TUBJQASG/D+BNJM7VaT4sQdxDzP1Pw/YeAlX56ulsB1BK2EJqdQuKwxvejoPo1gT9tatnzWrC4QnKk6gXH0A0fYbJgs2W8Zw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzhZbTFTMGtIKzhqd2hvZzU2R1orbmpraXZnVURHajFpTUFVQmtINGVIdFRZ?=
 =?utf-8?B?MXhDTzZmMmNITXY5enVJUU1wT1ROYUhFZEFKeUxYZ0tmRzF6RHhKeTg5N0Rm?=
 =?utf-8?B?VFJ2U1ZiOHExblZuS204QTVYSjBuckNSUndlQnIxOUVOL3NXQUhTQndwdk9P?=
 =?utf-8?B?Mzc5N3VTY1JDMEUzQy9CckE1NnFxWW01TkhKbEpPR1hXZ1lLT002U1E2Ungr?=
 =?utf-8?B?Sk94UU0zczhZeDRlejZ0dHRVSkRNVy8vQVo4ZTc0ZVVEVVY0b29HY09DY0h6?=
 =?utf-8?B?UmtNYjV3Ym1MRHFtdEJXMnFJbWUxdnJoN3RSVnFUazBmOW9xY2JVa1JWSHgy?=
 =?utf-8?B?UXdua25wbW90di9OMmxIOTZwS0hMOXVEWC95UVR4Qm45a21iOG5JTzIxaVlH?=
 =?utf-8?B?ekk1OENDRTgyK1lBd3cvWjZRZDJSbHpCcUFndDcxZ1NuMUYwS3ZsZ3BKRHhs?=
 =?utf-8?B?amxuMlB3WEc2WFRoREM3VUVodWJIRzQra0piYXZSR2FKaXI4MGkyZlhZSnoz?=
 =?utf-8?B?eVJkeGdzaGpKV0lPV1dWdHZ6bUJJd2NzZGxNSy9SczFFdjRSdUNhTlFBYjRL?=
 =?utf-8?B?M1ZRTlNYRFROWFNUd2tiK0FJckwrSVljKzFJMGs4QUdrM2JmNll3blFaeGpv?=
 =?utf-8?B?YVpZUjR1UVVNdENzRFMzTWlRbnVzcHBGOXRuMnp3KzA0elpFT1F1TUcyMTdC?=
 =?utf-8?B?RVRkWEk0dWpGSU92dHJxTWZDektFbWI1eVp5a2xST0NJeEg0K28wNzZMdVll?=
 =?utf-8?B?MXN6Vmo1cTExakhHOXVJTVhCSDlibFozb3RPd2NYZkZwZXhpaG1ZaHZpdmtm?=
 =?utf-8?B?aXVNdzU1TGVwdWxJSlNyemU0ZDdPQWVMZnVCclpZM3BDbnp1K05iUi83NzY2?=
 =?utf-8?B?cEJjSHlNb0tDYmhkaTY3NW1NVVJQbUp3bWlnMHBHQUkzYUswLzM0RmRoQXJM?=
 =?utf-8?B?TDZHcUJ3UmxqdXVYcnR4Sm4wOUw5VHM1ZzRwWmVTd1IvQ0hGMTFvMW9KSzFC?=
 =?utf-8?B?RGxHNkZiU0oyS3B3M043SHBIaWNjUWE0aGVCVVBsd2dzcU14cm9Ec0RYSTJp?=
 =?utf-8?B?anFNMVdpM0R5djBOUUVBSUFMVVJZR2xSN1NOSkF6Tk5qdnYyYytlNmhMb0JB?=
 =?utf-8?B?MDZOZTFibytRczY0VUJFeEd5dy9RdmUrbWZ4N2FZTXozbkgvaXBYdmRtaUpT?=
 =?utf-8?B?ZWo0UjVjQ3ZhT3hqRzAyUllocWZ1M3dJRzk2TGlocW45RUh5YWNoc1A2Zjdv?=
 =?utf-8?B?TU9rSTdjMGR4MFM2Nk5GdlFXTVJPZVk2SW9heXZ0ZjMyY1JrNzc3Vk8zQnl2?=
 =?utf-8?B?MWc4NWZMb0RodVYzRmZrMkZZMDhZMkthdDFVUC9xL2o4TXE1NW40U3UvaTdy?=
 =?utf-8?B?dVJ6Z3M5V1A4azZsMUFJM2VaNDVLbXlndDcwQjJpOFRTaFJlNmN4UVRnMHZR?=
 =?utf-8?B?YkxQL1hlekhNWFNJUE1YcmhCR1dmb1V4OXhSd3NiNC9ad0Y0QUpEMGlxYURa?=
 =?utf-8?B?TWRHV0NZRWdQME8ybnVFb2c2T0pwVEZiblgyS2FVK1hzUC9DajlaOUxIZlE0?=
 =?utf-8?B?UjdxZ2Qxcmg1ZDVPSTUwV1JRdXQvV01xU3pzYlVqK20rdnhTVFhWUllTT1kw?=
 =?utf-8?B?SnVwUGNKcy94cEc0TW5acy9MNGxIclZBRnRTZ1Z1ZUZ1dEhObkYvMVVpaVU0?=
 =?utf-8?B?WkNWVEJ5dWZBZXpLNTA3bjhMVU1MVDNxYzBDRjVKcUZpRTlaSDlYQjB2dmpa?=
 =?utf-8?B?R0tFZFRaVGljRHdyeTJOS1k2YWY4ck5kNVVrTHUxS0cvUXVIeWt4dlpHOVRT?=
 =?utf-8?B?SzBDMnZzMk1yN3JKQzBCVEpMOGwzRk5HQnpUTEJ6S28zVzgyelB0c0c3dHFs?=
 =?utf-8?B?eVR5SHVvczN3QkE4MlpJTmdVT2JmbC9hcTZ6N1hYMkMyS1hQQTNEMDMzbUx0?=
 =?utf-8?B?OTFTdmc4Sll2NGpGalgzTmwzeUdoVW9rdUJubG1sbHp0Sy90MzZRMFRpcmlr?=
 =?utf-8?B?VUd3bG5WWHhRTDRLOWxXM29yRjVqQnZ6c2NkZlIyUlRnejRESGtuRHZndnY5?=
 =?utf-8?B?eStrS283L2ZmUUJXNnNsdG5IOExyVWVKV2ZmQnR1MTJLQjlMdDRqQkFrQlJs?=
 =?utf-8?B?UjgxOXlRY3RCdmphTVFJQnV1ZWk3VFRuNGxBZDJtTlBxYkdOVDNFVHcyR2E0?=
 =?utf-8?B?bkdXSkZrN3hZNGEyZGtVdmJKazNiK0tWajRYTlI3TVFHTEprUm1BNU1kQmVp?=
 =?utf-8?B?VDV6UXlhWVhtdk40cnBtdnljQzYwQzhKYmUwOXU5cjBjYkdodTVBNm1MRXpI?=
 =?utf-8?Q?N8bn4U2szix5Ry/Gzr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93709b9-3361-4948-3694-08ded90b4554
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:59:16.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hs1IBi1TEN51nFDzgIeO8iCfIIgj7qIXE+zFCml9DCWWXBUnOBasMmnG9z/3KjU4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958

On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
> It's confusing that the function is called "nolock" but the flag is
> called "trylock", align them.
>
> The function's terminology is more visible and has more mindshare so use =
that.
>
> Suggested-by: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> Link: https://lore.kernel.org/linux-mm/2399b3ad-4eac-4a14-94c3-27e9f07972=
a1@kernel.org/
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/internal.h   |  2 +-
>  mm/page_alloc.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index fa4fb69444ecd..a2b09a13735bf 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1480,7 +1480,7 @@ unsigned int reclaim_clean_pages_from_list(struct z=
one *zone,
>  #define ALLOC_NOFRAGMENT	  0x0
>  #endif
>  #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
> -#define ALLOC_TRYLOCK		0x400 /* Only use spin_trylock in allocation path=
 */
> +#define ALLOC_NOLOCK		0x400 /* Only use spin_trylock in allocation path =
*/

It is strange to me that _NOLOCK uses spin_trylock. Lock or no lock? :)
But it matches the _nolock function. Anyway,

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

