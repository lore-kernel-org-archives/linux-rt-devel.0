Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863843D5C12
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090163; cv=fail; b=QlKS46BWpL3LOpmtprwMwXDzbQOGFFNYQEuNuroEjYfUVoX8JTGfC8Ou7GMcZAIeFuFMbchF3lSGdWfsfjrfAdwwD4CTvZeyi813tETZE2e4fd+aUQ2MoLW3AeaIWZWKk0ilIWM5BT0Lh6eShPREGRXTt4ypxO5Ni4bNFSvPtQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090163; c=relaxed/simple;
	bh=ErzI/3Kf/C590YTluhXmmR/SuJPukTq9Zku2vq8MHBs=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=WV1DNcH3+ZAlDn7jJCGeNsIVU2OfawHheANMFCmCUP3Mdf2196XZ8A0usD9ts/WV+ZgjT+9puZoXof4Xvmd6uid7B50KzpwRuwdePWXgXJffFsp35GPwxs1z3LtpgGuGFdml6iqydqTkpZYzpg8iUev48I2+KWrBuNsd7eYPb+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oXE7aUYH; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oXE7aUYH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gm8Fl+TModh10sxeYuvK0j/ONWydVF3WqOvKojWGgIbdAdsJHRLIsUiD+LjO0kElJ1a8htrQENYAKyJwm1CEZn+cy7tmYaaep3CGDJHn6/qXKaVSfPG1Gjaihhq1ucb869RkNr7wwALEn98NttxYfLFnrPW44wvQXIei8BsJUEOxrGRT4feO2d+nq1QlrQ/JBaeeul45xfjZihagTbh7qIB15stqaI9+/QwguiA2J14kwZvSkPOTqR2yQXvTA/q9FMGVSSOddG/AmiZtVOqN+zoa1uzoqGkGl34k8396ZYBQ83TmlS0AeU8pxB5BjiiaB+tKvuWYlgylzxQkRkL6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohWGpgZoIFf348kDRmlfgAc6esVaBmR4V6KP697e42k=;
 b=dqgwHhsPaGmeUfA6JnUOxMDRaPufuf4TxmcDt0pQOEsYd97xHMKEw7esLl/pVLzvgvVDfK0WekbslQgFXIO9dentXoIYnvUZFX5HMwioP0vbci8QMIEgfc7aSYqNinDxT5hdIy2JGi3/f/VxjlMvNgiPKC32f70o+lyfaPGOPvZmG3xTlMN5iJNG5cBlHhq3ANSGlDELTBCWwaTKeiAPn5RS9eknEb+1wl6T/ZQiSDnRX54dsa3wGKt2saR05YbNSCBN3W2u8hHbrUeZ2yh6ps42YBteOUImoHB1SVSUGaTism1/wYzdfUd2dwEcCI9/2c1FLXKG9iXen46jP/VVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohWGpgZoIFf348kDRmlfgAc6esVaBmR4V6KP697e42k=;
 b=oXE7aUYHPw7f0cGhvQnoZkEneU6PFgOSnZYsgRi7kAHcTRcrkmj+fOTjZypH54LsasycIrXLViefqg14JSQ5V5+Crlu80uoIt0YVlksQkqolgMcbqP0nM+vWEBss2hLqWxXQNQ4Qr75OVmz9/DZA6m+y+PApvlU/jaFlK//ujCKjcsyw+a8e9ZewMPHofNUqT5au0KTKEK3si4KXTply4VtEG1TSEQBMpBQlnrfBP8iNyEceI3CUWDYyC896jbQe1z1ikB3dT4CT3iQ+AX4ROy4UqySH0R3y/utyWljqqWW9vMsvrB8pG/qBTP3rj5aREhuwO1cFogcPRSEeF5eORQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 14:49:16 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 14:49:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 10:49:12 -0400
Message-Id: <DJP0PFJHGPQ8.1IVH8WK3P6TR9@nvidia.com>
Subject: Re: [PATCH v5 08/18] perf/x86/intel: Use higher-level allocator API
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <derkling@google.com>,
 <reijiw@google.com>, "Yosry Ahmed" <yosry@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Arnaldo Carvalho
 de Melo" <acme@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Alexander Shishkin"
 <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>,
 "James Clark" <james.clark@linaro.org>
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
 <20260703-alloc-trylock-v5-8-c87b714e19d3@google.com>
In-Reply-To: <20260703-alloc-trylock-v5-8-c87b714e19d3@google.com>
X-ClientProxiedBy: DS7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::6)
 To IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c779052-b9bb-4b6e-6f2a-08ded9124154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|921020|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	f01nYlUElPKVwtR4XWV8pDG0yZU367fOV7J9Yu9z/dh4MVvxRb3n1WQC23aBg5U/gu/7gR6rZkg6Ov4kQdcRgUp+NyOio+29f4Q+LFTrROslvq5sOC1eaDCZ9JMej2idDnHZcjsh3363JSOcZHxJnUo8IUeBWMLYrUm+5gHmxqcTuJeZ1g/+htHqJ4BGn+lYob5oMFtFeytkftkJa+MYg6RlA/tiYMz89BVXvwI528hFx65e11uvh8AoYAvKy0aCHqXKHgLG5Qqxi7g+YQfQLvXV+z9qttqMjlfJjqFlwzbJlfpuDCptcLEX9nW1rmh8GsExggoPvODohbDf4LIIUTu+STnFv3CEOAj/0i3v4WhFhSxFS7i2jwUDWPOKYJHW4CbK8O8ZQoCE4VNvordGS4YRH2RicppbrOeSZrGoCEoEPUKMMfGmuG3IWo6/vU1wmcCQ4F6TbFBBKblNuuvNg60wX+dqIKRmdvhiqvcBHubpyspqAVIdee+mvWLclQUmQOfscpe92oVCCrwVy5AVz4j/2h0r3LO3umhB8TxaBC3+chzd1TWR/8gKqPzIoAZnuJiQUeUlwbBNFe4GIN8ORBaXgTre2JqkJ3XMJYWnk5+Nn6j7aPqzf59WH58LLqhe9X3YNuUrzUcuZuSXpFpCopDuAND88cafthdNESynOe4p2c/aDv4FE8K4VNj3v1sAoMyXqMinOrlllPOkzjkg4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(921020)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzdSVm9rZnFUanRjK25pUmtYM2kzT0FXeFl4WGdlVjMrb1ZEQVA0NTNPVU90?=
 =?utf-8?B?TC96a2Z3YWRyeFNhcmV2V21YSllKai9tU1A2dTJXd2hJcXVkQmcvNkFmV3Q5?=
 =?utf-8?B?R3BsbUdLbkI4cHgyTXU2aldROUUrOWJTRFY3Zks1Ynd2REhILzEyc09ob2hj?=
 =?utf-8?B?cUF0aGVQVURsTDkrV0RLQzd5YUpDeGE2SnRwbElRRFcrY3haWWxIMkhtL2tx?=
 =?utf-8?B?WGl5Yzd6T09sekxLSEZwZ29vd2Z4enFYVkxJOU5RRzVTWnR1V1VtY3ZqYm1q?=
 =?utf-8?B?bFl2QldYc1E1czgwVHpUb3c5Uk52V1ZWaWxqaElENkltaHlRRVVVRmFCRGw4?=
 =?utf-8?B?R0VneldySVZvbmUyTWI0NHRZczNHK29JS3dCczBrWFdVc1lkTVJpYzh3c1JP?=
 =?utf-8?B?Znc5Yi9mcVZvT0w5akRzV0t1U0tGN09uQnZIM1A5R040TmR0b2JVQUJHMmdO?=
 =?utf-8?B?cXc3MkU5dWZPakl4bEszYVpvUThwdy95QlhEOGdJYnlFRUxLU09Kbmh0K1NJ?=
 =?utf-8?B?U1FLWjYzeUlFaldzSkhLeU11SDAyU2JYRXBYZ2lWRFJnZDlDQm1qN1dlcklV?=
 =?utf-8?B?bzZiZzdXR3h2QnlmZTVIWnpqcHhQNXdOSm0xc1BaVGh0SlozVUhZbUJkOWNP?=
 =?utf-8?B?WEF2ZHVWeXdXUFB6ZDlRVkRBbFU3dmZpT1FNcjJZNm9XaXFUckIvMmtueUFD?=
 =?utf-8?B?V3h0Tk1xR3dWVzFYVWFTMzJOclZkZGdWQ0NMWVNIZ3ZGSVVVNWtvMktsVFlP?=
 =?utf-8?B?ZDFTcitWVUFXVm9mT2lTNjVRMVlQZ2hjeG0vQUgzallGUEpXUmJlTzV1djNL?=
 =?utf-8?B?c1kvUFFiMUtuK2pPL2ZIeTZQRVJmTmgvNTNGMmwvVGhvaXNFNkhDcXh4SkdP?=
 =?utf-8?B?YWk1U3pHRnJwTkhmMlUvdzB6ZGlJaXFuWFlDclgwRUZ2QzIxbGQ4WVAzR3l3?=
 =?utf-8?B?L0lJYVpma0tyUTVkcE94TENSRDlnT3YvOExYS2VzNHp2OUszbEo5eFBqRlls?=
 =?utf-8?B?YlRrU25OWG45bHRhWFNSdXlSWmdqaHZyQ3VHTVlqc2ZpUVF1VVJBcng0dGIx?=
 =?utf-8?B?RTdST3p1YXJEa0xaQ3hhdzVMZkt1MVZzK0pyeFdhRUNhOTN3RXd3RDBBSUtm?=
 =?utf-8?B?c3RGVEFMUWQ0a0Z4bW5kN0Vta21Mc3FlUE9VUVUzWXhiODd4cU5oT1FYRWZE?=
 =?utf-8?B?TnQxZnVRNnlPaG5wZXhjTlBJd21aa1NpeFk4clpGNE5aWk5QM3NqUHBNbDVE?=
 =?utf-8?B?RVdnM3AwcHVqODVWUFA2alpsSFFJYlJLVzR3dkJ3Qzl0TVl5a0NZSzFFSWU5?=
 =?utf-8?B?VTRBeWJBZUg5Y1NPRTA5Y01LV1ZEWWRUeC9sSHE3ak8yTUZDRkZjRTRBNWhi?=
 =?utf-8?B?NVhDRzZFOG0xWG56M2NySkVMS2ZWSXZCdGNaY3JmVU42UDJXN1Y2Vm9FMlBt?=
 =?utf-8?B?dWtvL0h3bkgwcXVXWWxxQ0szdTg4ekM2c0dmTTF6cmdXc0thN2FxaFd2OUhy?=
 =?utf-8?B?T3BrYWpYZkxtZWM0WGs1VU9USXI0Uk1pNFMxR1ZVVGF5b09SMzE3enRCOXM2?=
 =?utf-8?B?LzNhMHhxSXRQYnZHblZnZ1d1ZWR6Q0pFNTZENUsvcWUxOC81aWVxWmk1VVd6?=
 =?utf-8?B?WTRDclIvNDlpbGN1ME5mNGJVK3EwNElzdXJLdTZhdGNUaFJEMDAvL3QwSlp6?=
 =?utf-8?B?UGxjVy82ZDIxOWhqYWJ4TXV3R2hZa0RxVGhDUm0vb09wYk0zV1RoUXZOQ3ht?=
 =?utf-8?B?NDdWcytpdGFqT2MrUDlEUE14MVFwRy84ZlZ0VlRoVDRhSm1Pd3M4cXo4dUll?=
 =?utf-8?B?TGswVFdEK2tuMkNnWENtYkFBSHZsc2o2VUM3eXRQT1FQeVNCQ1hDOHpCeUJx?=
 =?utf-8?B?eE5DbTlXZjVXTjFGTDZpeDROUzhsZm9Nb1NOOFQ0Q2szY0Z6YkFoWUh4S2dm?=
 =?utf-8?B?YjFNVkFmRGtIOWlsL093QXdsVHhxcERFUWVud1B0bmhSc2d6QkZSZDNxOXZx?=
 =?utf-8?B?ZHdzcmsvMVNET1k5VDNtUmpnWndTa0xLQytZcExFUU5lNEVzL1dnenBtRktw?=
 =?utf-8?B?c0E3TXo2QzBpQ2JDRnBMbk1pb21yVFZ4Q2tLaGVDWW5PekM2ZVdKSXpKSk9a?=
 =?utf-8?B?V3pIZEZUMmNpUEl5SVg1R0dyUkxsK21leXJpSDF4NTUrZWtEcUxuYjhVUTZm?=
 =?utf-8?B?dTdBUWpvTVBpYUR3UjVWUDlpQk9BclZzRWcrdnNrbkhoRXlCV3dZYmtlL2tK?=
 =?utf-8?B?Q2NJZFlCU240TWVGOWlWdEdOSUluQWQ0a0pJL0pnRHVId3RWZ0lJSm4vYVIw?=
 =?utf-8?Q?VFwK5rGKwCbuHczyDI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c779052-b9bb-4b6e-6f2a-08ded9124154
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:49:16.3369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgs3AjhmYCiCPgPd66QPaLG7wuLcCUHODfQgKHx6XjUq5JbcsFne1wm4gPD3x2+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the latter allows you to pass NUMA_NO_NODE.
>
> The former is going away and the latter works fine here so switch over.
>
> No functional change intended.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: James Clark <james.clark@linaro.org>
> Assisted-by: Gemini:unknown-version
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  arch/x86/events/intel/ds.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

