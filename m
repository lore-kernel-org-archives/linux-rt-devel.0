Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AF3054E4
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958110; cv=fail; b=C50Y6QfgLtnEqVsT8YpwXIfSYUNK9lRI8+W+tEwVAhLJITVKuczF+EgE7z9D5rOLdZphu4yGUnqf9TEKSkw9bVXz6ypGCE6Dnv7/qHQXkFsqQ2H+XDHlZz/Y15Hu65/dNkM7+QfEEfq1c82goj3cQwkgKp5lEAk66kgFewX1ArI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958110; c=relaxed/simple;
	bh=pH1CT+OpOkIZ5TBca/KdcJObS0Nlo3+pNryWIW2BqNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBNXGQjou9PHSEg3A4BKKgMKKX54IQ9koPO9/z5CPbP/EHfyE9Dyou2odTOqW+KToG7MfaiQNAin7Cz7Tq3r6Uy7EYMFuvIBtjCsMAaD4tNPhV3vF+Q4q1evWUstjN4rMuiK9vASpXaKBu4IbrBDfpUqnzUzJqFdXAc7wI0Qxk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SYiJC67D; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SYiJC67D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LivAzmCC5jcKyieXOfiSTJES+uCcnAvglTlXtO03px/e7oi1T/FD3ZQT2a0t1GS/xI2s/986rM0BZPiX2kHmZ+U1BoUcq1A/WtLn+1bnwwY7tHqNDf0vPTVtJU9+Ejq2ZZ8X7jjwM+H1p50Qp9EmKlEXJEHNgxzKVNLr51w7qHc9BhVCfxWNxtldok8TFZZxVDyxRdRXo/ZrrDos0wPRliz2oHQP6792BbPE6g/EdfVzlJzeGG0mtS4VfoXRf0Xxl07845SFW0nEmN/RFeKgI74g08dtQa3beJTu5koaC7MDqnjEqn+NSo9CAPwtQwh0jwMd6jinMzs+nfw1cK8sfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Exdk7tlrGUwmChLhYeDN8TQaZLX+aAssYf55GvlhiLw=;
 b=fyMDhvQ9wq/Mys9Sv9qnG4Iuea+VFUeHFVXAaFCbGXM26raaa3U5Ff+w3F0yPQpFy3UUP9/sNbz5LuB+K4FCF6PcEDWMXf83sxmzdAQ6RDGjYGCA27fjBKUuJE2fzY1zMe7bOnuUUBC7p/OydWrsk1S2kCggJYUqL4YpJGjBl2RY8e1KnXmzK+/o/c5x6cai2tKFoAyP0IfvUYOJ0PngAInyRTXdqxMzGMscrORzxaEQICaHATiYwNiodncpBRHeJxeAI9SHIt43SveqV2yhmgD9Xmdh7gDV7zjeRE4mIeKBS7IHf5ZZ1FYxmTdzgE8yJH5FhWVOqxfbeZcI2gUXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Exdk7tlrGUwmChLhYeDN8TQaZLX+aAssYf55GvlhiLw=;
 b=SYiJC67DXIrutVTIR92UMue8HDULOmtwwvM/GMGTAIjdQtMPM1fzHsAJRAdUGIi5ftvyhDAb6KUO+8oVEKlf9qrSP/ZnbNI9gJKz0HpNox97EsmuhNPIL67w4KrvDNTeKrpDsXOU/RoSKS3cpT+9ce3CrVxb9trTcOUZePgpgeJUt/N/hFeu8aShThHdft8YMv2gHDzIJE9pFbWnP+hJPJtbMVg672wqAHu/DMR8lJSMgJMkkHt2JD25iRF+rgkRYOB0q5zAVr5BKAIokYuhp/U3OLq7i41ppCKD3IKjikcDshbTJRAKUZtwroAtXVUiBIgeVCU0vPLgQh4Soj9OeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 15:54:58 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 15:54:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>,
 Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, derkling@google.com, reijiw@google.com,
 Yosry Ahmed <yosry@kernel.org>
Subject: Re: [PATCH v5 13/18] mm: Remove __alloc_pages_node()
Date: Mon, 13 Jul 2026 11:54:56 -0400
X-Mailer: MailMate (3.0r7017)
Message-ID: <399958F1-544F-4826-90E5-B471E2231375@nvidia.com>
In-Reply-To: <DJXJRNZFBPQ2.2S6CM4YAKHVQ5@linux.dev>
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-13-c87b714e19d3@google.com>
 <DJP0VKJLE8TE.6EDLC2BFI1SG@nvidia.com> <DJXJRNZFBPQ2.2S6CM4YAKHVQ5@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: MN0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::17) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: d793f495-9e14-479b-96e1-08dee0f716d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	9MnzovuPHExgrgk/+jCqJ2Iuf58v+P37Sgb2b74xwVb0QPVi5b6xVVkYCi/IYsS8CO6RshS6FpE9UHRmLPTkCpqvPZvMPQIjxpp+vLpER/cHqFiNgvDpqlBkjDoPhqHHmuWD6FnguIhzw/XaH/6Kvy46wm3TvlypkLxDDAwb/c3wS5ubgad6ISBBnANQl7W7o4+aLp6X6J81ewAlsdd7ecPv4Oczx2kw7tR15xtG9RBIJplYHevcD5dk0fTqHRfwLdrelCbhmUUgkRrkfk+tcO8tjRTTbnRoip86CSNn74/rwJgOb3OVukOsvD8RQXjaFKP1r8+5O3O7ucpRv9iWZEIIfHDYy2oKU1WYBFNtEeGs3K1YTOVGaVz02ez+6SC1JGo3WM6YcDUhA65QE21kOKwm9H4hRz9sBmjEhE+P0P1LaBOLj0MvmSTKGwoVB3fu2VGc/eCj4L6e/AVO+KRsCO9ScF+SbveozLU6djnXKHrrmTivhfI4vbDrlgFoDIve4jGO1frsUcSCl3U4rCShAV0qxaa8khYJNL1JWSqyKFR4f4m/Af3qge97sEuBedjGOyctOV/ack+NSPfnpuhaxMqCNhV7JYJKhOaHE/89b8y39TEFNp6y5Yd0jQnpz540B4R2Nazu7O820nZ5Iu+/v5peADMZ+xc66Sgq5ttOQtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVBwRUF4SHpPcGQ3VkRTdzQwTzQrN2ZmR0VkN0VNVUlWYi84d3NPcjgyN1JF?=
 =?utf-8?B?UDBGWGhlemhURDhhYnV3RjlRV3UzM3pMaTYyMGFwWFJDNjcwV0pzaTRRbnQz?=
 =?utf-8?B?SUtsNFAzSzZ2NkRtZVBBN0NHV2pVanoySTJ2NC9GN3RHQTU0Ym1lc0VpRHV4?=
 =?utf-8?B?TzhVd1Y2d2R5dkhLaDJHWHQvdnZ6bjF6R3RmZGtzYmljem1mTnVFYUd1YXBK?=
 =?utf-8?B?RXlhNEdyWDBsakh5bEtJQ0Q4Q2U2UTlRdUpna2RqNnZmYUpSWEFVZVlEdUdF?=
 =?utf-8?B?akpXK1BLL1hiTzVFbHUwazVhQWh5K1Iva2YvY0VabGp6RkJ1WmM5NkwwTnBq?=
 =?utf-8?B?bTh6bFE3WDN5RlBsQUV4WFIyZi93dTJ3Z3dOTVJXUjBueE56MXBxaDRQZUFH?=
 =?utf-8?B?WlJMMFp2S1JRRmlzbmZ0VjQ2citxb1pCUDNuYStTMzMzQlptTUl4L3pVV1ZE?=
 =?utf-8?B?N2FhYWdyYzdLWVBVTzVuZVljV1RZdXllVFFrVG1JS0k3Zzh3MkJDSS9TcEdS?=
 =?utf-8?B?a0Fxcm1MMmZyRWR2cXpPL2daQkpLbzArdDVUYUtWVTJDbHRIUnl5N2FpK1l2?=
 =?utf-8?B?TmdVQVA5SGhJTE5hVmJ4dG1pTEtkSUt1YlFyanFMK0t4ZUNDMVQvMVplTVE1?=
 =?utf-8?B?WmRyTDdMNGJ3ajdlS1BMNU1aNURBOEMxL3pKV3lpMC9DNWVLTGNTUW1IRldn?=
 =?utf-8?B?SnpmY0N5NjhtSXJKTnAyR1FlbnptZlZqMHJhak1HUGk2d3hwa3F2V01TQmpq?=
 =?utf-8?B?NmRaYTQxZVB0VUZzRDZWcDdvNlJwOTVteGZoTldFcU9MVGxITXZ3OFZaQll0?=
 =?utf-8?B?TWlnM2J6Y3lBYXYwSVd1ZFBLMEVuNlZyUnZVNm51ZXhsWXlGYi9DS2FjTk9I?=
 =?utf-8?B?cVVtdHpaSkdxTW1LdUtFL21MbWx3N25GZzlCNnVobW9Hek5KS1U0VkJDc3Jo?=
 =?utf-8?B?Z3F3V09VNCtHTkpYRHloMnJJbHdjQmtPdjdEcEdieUY2RGF1aDJjL0hhRmd0?=
 =?utf-8?B?OHNNRGo3MzdPSjBQRjVWbVVlTmFaRmNzd2RSQUxqdExaSytGeUt0L3JySnB0?=
 =?utf-8?B?ZFRKd01KSi9XRWJhbmdKOHVBOHlkWFlKSHdOTUpEa3VoS2J2ay9jUjlrcHQz?=
 =?utf-8?B?NlNIbE13RVFxSWo4d1djLzdSRy9MK29RN0I0bFdreTlDZUF5RUl4d0EyemVD?=
 =?utf-8?B?UmZ5ODJTZmNwSCtGanNxY3N2VlA2cVhGNzlGTmZLbTY0bEZBc3R3SlNzOFRR?=
 =?utf-8?B?c2d3bERXNFh4WmgwYnhzWmQ0RkxybEcvdnR3aUc5eURBeGJyWDFWaFZsZFFK?=
 =?utf-8?B?VkNlMDdXbnNHcFUyMFhyK0lia3IxSUlLWXFoTUg3NGVhV0VzQWRxbE1ick1a?=
 =?utf-8?B?aWdZbTRRU1ZxQnNSemtxUXFic2xweWhkMExMY3h3RWdkMjRlcjV0VU1DeERS?=
 =?utf-8?B?RlZjMjY1OC85RDJnU0N2MWl1V3RLUkorUjJ5b2xlcTdJTDFDaWoyYTdTOWlD?=
 =?utf-8?B?ODYxOFNiaElOcFloNVpGTEltTnJPUExhV1daZmZ0TVYrTHpXTUVPcXJaSURu?=
 =?utf-8?B?aXFKVG90VXRuNmxScWcxTVlsR1o1QWs5TmZFZ2hTazNxeUhEZ2tGUnQ2NGFX?=
 =?utf-8?B?SGsxVEdTQ3JvMUErMyt2R1p3M0thWmE2aXYrdUMxQ0p4UnUvT0N0ZmJxR3JG?=
 =?utf-8?B?YmZEQTR0L0lIZmNQbzY5RmZBcEdPR2ZVdzAwUkd0TDZwc29KOEh5WkE3bzN1?=
 =?utf-8?B?M0FsaFMyanpZUVNsVGFFSTlFbEhnNUUxRXl6Mk5OaFZxRWhDWWdDaHRKOFN2?=
 =?utf-8?B?QThyVG1MQi9KZmV0VlltY3p4TnpvZURNWGg3Q005MjhIU2kxcXJIK25XUXRX?=
 =?utf-8?B?MGFORVltOXN4UkUwUkY0YW1kdjdobFBqc0o4SVlqVVVCVzFOWEF2U3NmMXZT?=
 =?utf-8?B?WFNKTXpOdW9nemhsZWxTRU52NFZQTWdCbEtVcEJPK1VQMU1vMzNxRkVaZXhS?=
 =?utf-8?B?bjhLRVN6ZVhLYzEyczdtMW50cWJzMm4xcDZlQTE4Z0FGQnBaNCtra2R1bGE1?=
 =?utf-8?B?SCtHUTVOdEp2MUk4QXJtN3RtRTM1azRHNDFtYS9IQXZKWUczNmdyMDZnZW9k?=
 =?utf-8?B?TTdhYUtNZWE3MTUraVNrZzQ2RmVCUWwxVDE0VzQyZXpPOFRzcXBGNy8xMjZn?=
 =?utf-8?B?aW1BaStRWEk3K0l5T1AwUWJRS3EyT2I1cXN2dFRVM3g0eG5qNUthL0VWaEM0?=
 =?utf-8?B?bXhJQ3kvSHFYdENacXNIOEh0NlcwK3U4QThjM3cvNDV5Y09JL254LzF2ODZu?=
 =?utf-8?Q?86GitWKNqHhSwlC3+V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d793f495-9e14-479b-96e1-08dee0f716d5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:54:57.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S85TKTr2C5JWNAt/NKDXiUIAkRohpeq5NlscZckrakAc6eYD7YYa3JsPeB/wkWkc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487

On 13 Jul 2026, at 11:26, Brendan Jackman wrote:

> On Fri Jul 3, 2026 at 2:57 PM UTC, Zi Yan wrote:
>> On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
>>> There were only a few users, which have been removed. The only advantag=
e
>>> of this API over alloc_pages_node() is avoiding a single conditional
>>> branch. The disadvantages are:
>>>
>>> 1. More API surface, more sources of confusion, more maintenance.
>>>
>>> 2. Worse impact of CPU hotplug bugs: most users of __alloc_pages_node()
>>>    were using the result of cpu_to_node(); if the CPU gets hotplugged
>>>    out this will return NUMA_NO_NODE. If one of these paths fails to
>>>    protect against a concurrent hotplug then page_alloc.c will use
>>>    NUMA_NO_NODE as an index into NODE_DATA() and cause some horrible
>>>    memory corruption or other. With alloc_pages_node(), the code might
>>>    just work fine.
>>>
>>> Ulterior motive: this frees up the __* variants of the allocator APIs t=
o
>>> serve specifically for use as mm-internal API.
>>>
>>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>> ---
>>>  include/linux/gfp.h | 20 ++++----------------
>>>  1 file changed, 4 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>>> index 01d6d2591f49e..3bf55a5f9143e 100644
>>> --- a/include/linux/gfp.h
>>> +++ b/include/linux/gfp.h
>>> @@ -256,21 +256,6 @@ static inline void warn_if_node_offline(int this_n=
ode, gfp_t gfp_mask)
>>>  	dump_stack();
>>>  }
>>>
>>> -/*
>>> - * Allocate pages, preferring the node given as nid. The node must be =
valid and
>>> - * online. For more general interface, see alloc_pages_node().
>>> - */
>>> -static inline struct page *
>>> -__alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
>>> -{
>>> -	VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
>>> -	warn_if_node_offline(nid, gfp_mask);
>>> -
>>> -	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
>>> -}
>>> -
>>> -#define  __alloc_pages_node(...)		alloc_hooks(__alloc_pages_node_nopro=
f(__VA_ARGS__))
>>> -
>>>  static inline
>>>  struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order,=
 int nid)
>>>  {
>>> @@ -293,7 +278,10 @@ static inline struct page *alloc_pages_node_noprof=
(int nid, gfp_t gfp_mask,
>>>  	if (nid =3D=3D NUMA_NO_NODE)
>>>  		nid =3D numa_mem_id();
>>>
>>> -	return __alloc_pages_node_noprof(nid, gfp_mask, order);
>>> +	VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
>>
>> Could this become a VM_WARN_ON?
>
> Er, it will almost certainly crash later if this is violated. Personally

You mean in warn_if_node_offline() when accessing the nodemask?

> if I'm enabling DEBUG_VM I'd rather it crashes with a helpful stacktrace
> instead of chasing random poihnters, likely corrupting memory, and then
> crashing later in a completely undebuggable way instead.

In this case, VM_WARN_ON + return NULL could work, right?

>
> TBH I don't really understand the "don't BUG" culture we have in Linux.
> I usually just go along with it coz it doesn't seem important enough to
> argue about. But now I'm wondering: if we really don't like VM_BUG_ON()
> why not get rid of it completely? I wonder if there's some case-by-case
> difference that I'm not picking up on.

My understanding is that issues like the above one should be caught
at development phase, so VM_WARN_ON() is sufficient.

The source of =E2=80=9Cdon=E2=80=99t BUG=E2=80=9D: https://git.kernel.org/p=
ub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D1cfd9d7e43d5a1cf739=
d1420b10b1e65feb02f88
You can read the commit message to know when BUG_ON() can be used.



Best Regards,
Yan, Zi
