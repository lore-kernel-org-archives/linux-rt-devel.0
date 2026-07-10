Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5732B12A
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692884; cv=fail; b=kySHu/nTOYyxl/++OYjCDGar6sgYcyzCMVbA6pWdUVmi69gJN0XyU2gZNdHyU/uGkge7KZijxoxY6fRQMlG/1d9wfC+Am8vhq+9WablQcTHM/VKQLMz9FBYfb1GJFpwfZnz/DTBCLMvK3DFGqSxshy/dD5aYpZDVgvXwjyXen48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692884; c=relaxed/simple;
	bh=3GP2lJCDZFUYae5FaO2LkbzGs56gxePruqmiWlcKzSQ=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=ZZIuq7xSJW/GX158PX3jYrwjw3Lza83UOPrO2gs0SSO7ygrsRQOffTcK2MORjmxo7rQD36/sv102muISQY2dpmw6YOxhdC07v8wy+qZzD/0X5G97fJuLgqDqNCsd/QJyxqZDyCw84MTXKuFbUvO9L9Jw3Cjy+q6+MYKccdJC7mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iWoHsR8n; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iWoHsR8n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAnQEW9eQcQ/2JVk4pQKX1VVNCXIwRoPyvSy28YtN1u+PLMGTHoPgXYXCURyGLCJlZNAoqFyj1ii23uL0zByDQ3xRm3mBcYg3WuZ/uChWfCmSIIlaRLh52ZriObwVO+GP9/7BcEJyfrllc1VFsifvMEPvuCMVunlrULFpOhQdKZixrM1M4a1yljDajb6/Heh+EqoKNmGDrTt+7NOIkPFPUiIiCCWUvgeSDdBo6/te12hFmsRq0IVWoaGpxDcdyFP/A08nbGbtDnUoiNdH9Q5xaoLZU71Hl73Tj28lfyOsB6JqoE0CGCc1OjV06xzDvy6tG9wiFIUV5XWgAEyL8HIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbOiUqGaji+1XCxYLgx9WPwPMq0akSDh0HjTHbQXpxU=;
 b=BS6ySX65Lcya25ckZHpAejvvXhIo8RwwiJ+mstKOt6mUI+vPWAcEz911JhamxfGmxL98oreOykbshCgz2JsYmB28Q4ti3G63KbnDQ90dmi1v8t0coQuWHDIpZVDWM/Nkl9uaQMV7PYXulyfFgBmTBNhVlKsKeEYa1sK+695D5S4jUXGHSy1UR+N7SgbL7syDrvBVNWuOBVU237W4KHNdOWqHwjJJSE3AUVehohH80mThocKhbRxib+RhDhVPp2ErE4hK5UtFGy1AsyOPlaVXhRbjQxJHt1JIMYa4DEXzz/Va+DF3LT2+49ce6pEskKVch2HHqw7LEhzSeRDQOvAOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbOiUqGaji+1XCxYLgx9WPwPMq0akSDh0HjTHbQXpxU=;
 b=iWoHsR8n816yzORBQ3icsx5WvcKrE2ooyUdBoGGgXa+8G1ayWg3fZXrYPfqINSAVD/NFEw1ilyLUYfHxxC3eovo8Ci1KX3UkbBpBBIvd9xqE1Jpzb4DeRWbv9uh1bFgv3ewiXREPGn89k/Xi31w3ipqd4LA4uG7R7WAeVFEAzY2HtooPpr98f+dyMxJy5G7Tr3olncH4NZ/GyPfRxJe6AfniyZetxDCIM/gUD8amOa2PzrM3DCWP5f+WK0I7F5GkSC6rO0ZkR2ND5KbZ+LGTXKNeLHAqBF/LSiiGgs3a6SmUGmXhjU7sRT+DrOMjT6hIiZKhxfYv153q0/jOBD91PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 14:14:34 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 14:14:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 10:14:33 -0400
Message-Id: <DJUYCPR6Z66E.LC3RMX9CEX29@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 2/2] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Brendan Jackman"
 <jackmanb@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Harry Yoo" <harry@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-2-affb5fe5ed00@google.com>
 <0048210a-e186-49c7-9897-32c9b66336c6@kernel.org>
In-Reply-To: <0048210a-e186-49c7-9897-32c9b66336c6@kernel.org>
X-ClientProxiedBy: YQZPR01CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::15) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a29d52e-8b27-458c-3b4f-08dede8d9186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	9o+jm0EpEidfX/yKujpbn1wN30JNB+6FpR7O5w37jUQg5MoUUXsguX7Qd7LeRmC7GzR6esOX9iuN2fsyQWMpK+bdU5IidcWl3l2sCy4bufIvABb8ZWZ9m75pKQbpwL/T8wLfTcDCgeDLkjij5YC6t4jO/NRJvXgQiEg/lIS3+9oKlt8GmvHOIehrHDFoOB8eu1CktPKq5wE+ZxsoXqW4HeiONou2Dn8fr+xg6bY9KSqWHGgHgwU7PcUFxJsaM4YEvJJT+NGyjB1g0GMMA78Pleqs+2AH1DBZ2FKD1fKI19/oUeK3+RGrKDknc6WCMXNW9K5pCrFbIvb4ycqTvf+cCjSvwYoxQaC4Ghi4YLZsGkLiX1EXMGRl58WbteZUFYxCJr6VGWUM2cZbZ0Ti/QuqSKgP1B7FfZb7K9EiNSqulPDEV4aX1+BhcmRdjDQPFeHUVN+C9ThOGPpRhHapFGHlSeL3nJBrun09NlN9utpr0H7sNOGcs1Pu35+qynafj0qRoBBbGDhGyar28ygHpOsXqizLc+hYJCcQ2F6K20KWzT7as+ytBiR9ZNorTLOYWsey5So/q8a4KBQpQ+JSPIaXhIt2xQzYMe2RBEKSJnrWxl66MLGLO2n0o6eHl1ySpk9h3owOlGUyCDb5WrnfdHGYACUX7JelmJVQ98eD7xbT+sVRx03SKm2xMmPXMpXjDa2dXM8VPTbhtY2LBEKqRMKk3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFZ2QVFzc0tJek9sY1I0eFVOVUFRKy9qVXhKdGJ3NGk1d0R3V05rRWd0RHZ3?=
 =?utf-8?B?ZE9IZDNzQ1hlL1REcmw1ZHRmRCtHcUJSTmNCTnJrdHZ1aGNtdHpTcCs0Rksx?=
 =?utf-8?B?NnQyTnVwcEVIQXZLcHpXN3BLdC8xaFp4dnZ4YjhiOUU3aElMUFdDbWFkSWti?=
 =?utf-8?B?NThiMitGSGF4VVVhdElGQ0FHbFV5MFFkQ0xDSDluRHI1UERPMW1Mc3Y3VjE2?=
 =?utf-8?B?Q0k2dEg1bVJxa2UxU0UydDZqZTEyRUVVeUFhS3YyUy9pd1l5TXAvVzRLck9h?=
 =?utf-8?B?VSs1UnN2WnhBWElWWkZIVkZsZDc4a3U5eXRUd1hwN3I1b3dUUy8vTS93NmRP?=
 =?utf-8?B?T0JnOVFIYy9Kd2FVQXgrWGw5cWs3QVVUR1B4MzBlY0JBY0NWMW5JVm5ndm95?=
 =?utf-8?B?b0tMNTNHZDdjWDVaVG1kbFlEaGNPT2NGMittOUQxdXIvQXNhN2xFOHFzYzJi?=
 =?utf-8?B?cGVxZmtHdTFYSWZTTkozVVdQV2dDWGZuc1owSVdPZzNSNW53NHl5YjFUVEFp?=
 =?utf-8?B?QTc4RkpvY0hhejVOWS9TSkppRDhCSDY2TWdFYmlPdERnVTQ1NGJwaUtUQlFh?=
 =?utf-8?B?SmFhTm5FdGdUaS9yVEFVMUJhdjJQTkViQlBMZnZxT2xBZkR4U1VMRGdJWHA0?=
 =?utf-8?B?NnRnN3p2My9HdUhSSWFmcldKVXBWRnpFc3UrTHdqem1UTDdXS1dzUDFTdEhj?=
 =?utf-8?B?aHhIdHdsQkcvYWZ4eU1nN0RabUk1b0o0bEtFZVRiSmp2OWIrUFliTGhXVCtM?=
 =?utf-8?B?amlQVVhIYU43SHlKTnJiQllwK3c5YTlsSmh6QnFCRGs1WlEzMjdxc2V6SHlY?=
 =?utf-8?B?N2ZHa1p4cGk0RHNNa0wvMHhKS1crVEF2NXBhMDVZV3pRNTlWQ3M0RDNxNE5z?=
 =?utf-8?B?M1dIYVhEWWdreWJZR01NSHVjaG9Ramp1TVdWZGYwWndzd2RpeEMxNVZyWGps?=
 =?utf-8?B?b0V5Smc5bkdaSjdJNWg1dGVTRmRDNnBYQzdWMC9aMkoxcG9oTGcyL20rYk5v?=
 =?utf-8?B?dkp6OGptY3ZmNW42V3dESjErWVR1RW5lOEJETnNBc3RCam5JdDlPZ2tFNkRG?=
 =?utf-8?B?T1RSV3g1S3EyNk9nKy9zUSt2TGc5Skg3ektCUVNYd2VUWU8wcXdNM3BlMHBh?=
 =?utf-8?B?SGtYeVFPbk1rMzB6T0dhSzR4bERyRm9qNzRkTkZHb3ZJMmYrVmpwemZlWVdw?=
 =?utf-8?B?dnVJbVl1cnU5K1BaNklZckdSS3lETm9UelpYa01IUHdUMUhlallvbnFHK2Nq?=
 =?utf-8?B?VEpLOHdqVmNuQjh4eEtXVEFFUGpmTTRRcy9HNVdneG9PbkpGZTFQblpxcnJw?=
 =?utf-8?B?YlZsMTVrTys5WGdHRHZIMFFpUW5ybHJZUVI4ZDhSZ2Fab1p4MFZFNkpZYUc4?=
 =?utf-8?B?N3RrekZURnk0c1VaeXVMcmNqM2hneUV0Z3FGczFyaFpIWVRicWhjdEhubERW?=
 =?utf-8?B?WElVa09Ib1llc3JubGRNeTFzV0xLWkg0SWtidWJhdWtEaklaUk8rQm9IN0Rm?=
 =?utf-8?B?dVptUFFOZm9Nb2JMZE1xcVlpUE4xTktOeDVXMElqMmZXbnlGUzBJY3pGSlJL?=
 =?utf-8?B?M28wVFEzUDZjZ0FSK21NZ24xZjk1OHAvVksxNWlaTlRnbk8vWEhkWHZJYVFh?=
 =?utf-8?B?Rkw5NEswUWE2Yk1UcVpyYzdzalQ4Zm80OWw0MFo4MG1lS3VvbWFsTUFDWSt1?=
 =?utf-8?B?TTkxOENtT2U4RG5BeVorRzFCYTN5a0JUZElGNmVsMmJZdkM5UWUwNHVQSW96?=
 =?utf-8?B?NnZkTjJwcjB0TktqalJ5WkZzSG5GRjN6Q3N2cGZKVEE0MEVjcEVLbU55ZXZy?=
 =?utf-8?B?VnVPTDZ1TXZOdFJyZjBBc1c5YVY5YmdHUWdTSXlMOE1EVlhaVEtVVTdpbDZX?=
 =?utf-8?B?S09sZVFGWFQrbmxBdndnbmVseFI3NERvNytJdmUwVU5GVzlLckYrQnZ4NC9o?=
 =?utf-8?B?Yk1OYzV1VVZVSmM1eDlueExIQUZTWDlVendqUWl2NTFnYzdjRndjUWZsUnhZ?=
 =?utf-8?B?NEtaZ1dUdmYzbVVYZ1kyV3dpNGhUVXhOc0JuRGN6UThMelRyeGdydGtULzBS?=
 =?utf-8?B?WHMrekRBenNNMDUyUVV5VVRnT0hzWVNqL1BDaVo0cHNRblJWdjhvT1JCZEZQ?=
 =?utf-8?B?bTVPZG50Si9RaEpjNm5ESkZDRHg4d0ZYVVN5WkIxOHE4L2c4VXBYVmhGc1lr?=
 =?utf-8?B?Q2EyK0tCRDBBNlI1c0xJV1YweHV4dU02QVE2TDlKbWszYWxuZUl1ZWJScGdu?=
 =?utf-8?B?bzBqQTFTN2hoQTV6T0RJUThmd0VXWkRTY2YxOExLS2xLZDRVQjJtcUhHcGNz?=
 =?utf-8?Q?esIy7Xnh5GDA6SQvAe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a29d52e-8b27-458c-3b4f-08dede8d9186
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:14:34.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XetwFn3CJxDBFnF/sZRHylbYeU6WCmFSkDrbdU6orDqtC6QbGzPeRQYfwbORilY+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235

On Fri Jul 10, 2026 at 8:40 AM EDT, Vlastimil Babka (SUSE) wrote:
> On 7/10/26 12:42, Brendan Jackman wrote:
>> As discussed in the linked patch, the there is some inconsistency betwee=
n
>> "trylock" and "nolock" nomenclature, let's align it. Since "nolock" is
>> used in the public API it seems to have more mindshare so do that.
>>=20
>> The linked patch did this for the ALLOC_ flag but forgot about FPI_.
>>=20
>> Link: https://lore.kernel.org/all/20260703-alloc-trylock-v5-1-c87b714e19=
d3@google.com/
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
> Naming things is hard. Maybe it should have all been called "nospin". I
> don't know anymore :)
> _nolock() functions and ALLOC_NOLOCK are part of API, FPI_ is internal so
> it's not that urgent. Furthermore:

I had a similar concern when reading ALLOC_TRYLOCK -> ALLOC_NOLOCK[1],
since the name is _NOLOCK, but the comment says spin_trylock.

I agree that "nospin" is better and less confusing. But whether we want
to churn it again, TBD. :)

[1] https://lore.kernel.org/all/DJOZN5H048UX.1ZVSFD48QZN05@nvidia.com/
>
>> ---
>>  mm/page_alloc.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 5fe1c11f919d7..ba8d882072de5 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -90,7 +90,7 @@ typedef int __bitwise fpi_t;
>>  #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
>> =20
>>  /* Free the page without taking locks. Rely on trylock only. */
>
> here's a "trylock"
>
>> -#define FPI_TRYLOCK		((__force fpi_t)BIT(2))
>> +#define FPI_NOLOCK		((__force fpi_t)BIT(2))
>
> And here's not anymore.
>
>> =20
>>  /* free_pages_prepare() has already been called for page(s) being freed=
. */
>>  #define FPI_PREPARED		((__force fpi_t)BIT(3))
>> @@ -1419,7 +1419,7 @@ static __always_inline bool __free_pages_prepare(s=
truct page *page,
>>  	page_table_check_free(page, order);
>>  	pgalloc_tag_sub(page, 1 << order);
>> =20
>> -	if (!PageHighMem(page) && !(fpi_flags & FPI_TRYLOCK)) {
>> +	if (!PageHighMem(page) && !(fpi_flags & FPI_NOLOCK)) {
>>  		debug_check_no_locks_freed(page_address(page),
>>  					   PAGE_SIZE << order);
>>  		debug_check_no_obj_freed(page_address(page),
>> @@ -1558,7 +1558,7 @@ static void free_one_page(struct zone *zone, struc=
t page *page,
>>  	struct llist_head *llhead;
>>  	unsigned long flags;
>> =20
>> -	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
>> +	if (unlikely(fpi_flags & FPI_NOLOCK)) {
>>  		if (!spin_trylock_irqsave(&zone->lock, flags)) {
>>  			add_page_to_zone_llist(zone, page, order);
>>  			return;
>> @@ -1569,7 +1569,7 @@ static void free_one_page(struct zone *zone, struc=
t page *page,
>> =20
>>  	/* The lock succeeded. Process deferred pages. */
>>  	llhead =3D &zone->trylock_free_pages;
>> -	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_TRYLOCK))) {
>> +	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_NOLOCK))) {
>>  		struct llist_node *llnode;
>>  		struct page *p, *tmp;
>> =20
>> @@ -2882,7 +2882,7 @@ static bool free_frozen_page_commit(struct zone *z=
one,
>>  	if (pcp->free_count < (batch << CONFIG_PCP_BATCH_SCALE_MAX))
>>  		pcp->free_count +=3D (1 << order);
>> =20
>> -	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
>> +	if (unlikely(fpi_flags & FPI_NOLOCK)) {
>>  		/*
>>  		 * Do not attempt to take a zone lock. Let pcp->count get
>>  		 * over high mark temporarily.
>> @@ -2979,7 +2979,7 @@ static void __free_frozen_pages(struct page *page,=
 unsigned int order,
>>  		migratetype =3D MIGRATE_MOVABLE;
>>  	}
>> =20
>> -	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
>> +	if (unlikely((fpi_flags & FPI_NOLOCK) && !can_spin_trylock())) {
>
> can_spin_trylock() was matched with FPI_TRYLOCK, now not anymore
>
>>  		add_page_to_zone_llist(zone, page, order);
>>  		return;
>>  	}
>> @@ -3001,7 +3001,7 @@ void free_frozen_pages(struct page *page, unsigned=
 int order)
>> =20
>>  void free_frozen_pages_nolock(struct page *page, unsigned int order)
>>  {
>> -	__free_frozen_pages(page, order, FPI_TRYLOCK);
>> +	__free_frozen_pages(page, order, FPI_NOLOCK);
>>  }
>> =20
>>  /*
>> @@ -5409,7 +5409,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp=
, unsigned int order,
>>  	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
>>  	    unlikely(__memcg_kmem_charge_page(page, gfp, order) !=3D 0)) {
>>  		__free_frozen_pages(page, order,
>> -				    alloc_flags & ALLOC_NOLOCK ? FPI_TRYLOCK : 0);
>> +				    alloc_flags & ALLOC_NOLOCK ? FPI_NOLOCK : 0);
>
> Although here it does improve things. Sigh.
>
>>  		page =3D NULL;
>>  	}
>> =20
>> @@ -5532,7 +5532,7 @@ EXPORT_SYMBOL(__free_pages);
>>   */
>>  void free_pages_nolock(struct page *page, unsigned int order)
>>  {
>> -	___free_pages(page, order, FPI_TRYLOCK);
>> +	___free_pages(page, order, FPI_NOLOCK);
>>  }
>> =20
>>  /**
>>=20




--=20
Best Regards,
Yan, Zi

