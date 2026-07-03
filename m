Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852383603D5
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090354; cv=fail; b=oXVFoX3F/t3LXvm6Ew9AztBm475dRwVo+1QLKojEqPDsTjKWxwLh4Q+JsBn3liFNdet6YM88axQGGVrQ0rU+yclExs+qlf9eP5ibGq/GP773H984cC1RTvWx3fW/3v1MRWTcJyvkW+nxeuDMyefOIp6CoLmShsTcZi3MAN5tGrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090354; c=relaxed/simple;
	bh=wTvbPH/jkDYF7cb7c9f28FpyLSSyvyzUOlhNRGp/d6o=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=LlYMokzVEfai1jiy6gTf4ZMBWl0EFTrcTRinHo5Kwe8zGU/swmDagPSauaWYVBZpUS4pqQN+i4XUopaRagBlf7ZqoOtX7guwsslyWqWIetBVvLPIcqoycfNkvWH3SJEvRW+ozQZKSOJBDHAPvz68nDlb2XilQc0xMAwBnaUTocY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rR6Ylh22; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rR6Ylh22"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agQsM9QyJahbL2giH0XO98tLq9lpapn0BjTSZRTFX4jznTejGrMcd/eXw8M5AjLEr9NW4MBUbCSea8ny35/VUbX6TGDPKAwwtSC2LlH6Yz27yzV7ReB6idPXJSeW+JH8/GMuYemLWOI6QeN/5AuNU+tKlwTUY6pQtTCmWuZiII4juH1XwUcaJbrKBsVw4sXlYulCrP1cJClfUzJU+vpeUAw6/4C1ZvBTAVXaZMz3Zwd9A2fVoHK3x2NpkaA4J8a6+JSPJDpXG5TTS0q4Wx5pkutmjwwtAlHd4//2qu1xUl5hAxGhcr0xHCJsjMgiANfe6I0jPfwiDLzQF6vAXkh71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13ldJ0K283TytbWx/mOvlI7DkhWT4w5ruBQ47oL1M6k=;
 b=cnHRQC+Gu31WlUpTThW1on72FFcounVf5sVPtcrrWTWcV3sDbAb6aqiZivkbbArWNGcsjCJMiPs/hmdfJla2zWl9ato4bRYTr/PqfN0yvJaEoFQMgna7c4DQ/RhyVq/mGqrQMmgkq+7OLbZFX3qctjr6ZChEdQWnOoVoQDAnHcPxXQ7UTsNh8T4zPlqUKLcukZ+0VecFbPPa+27DV4FZzVwf/EEJRmfyl0EPprgAOc0JzWlw4fpjmJ7hylIa6EQgEQN4iifarMWMr/KQ2kL5yg62Lii0rGhRtgwTpnL0w2t4ZU1CbqCBB5o7+26AgL0fa5hRYerNRb7GcGoAQfuCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13ldJ0K283TytbWx/mOvlI7DkhWT4w5ruBQ47oL1M6k=;
 b=rR6Ylh22WcivqvuCyJBrGilkXMm434wjOA9WfW7kNT8f9uqCNSA1GAkbOLPl05EpFB950Z1uPaH4F/B2zpAOIDQd/36FY1+32evITTcZAFI8VnL3r83rqW2/pJFasHZjDmx2KhiAFfdDyTEPTLggHfhivwScorjsMV0im8n9D3jzUGnRQ6mGh4mNBdZSDg7oBY5E4Q2oAu02X8wyEu9IKxRiwHmzBlRAQhH7+8MxaK42RhDKYP2uEjqHfWZQWccmAl40ufiC/ZqDva05YYUrRPeRbXEkdvSe2AS4OGGC6JjWAk4ETkaqIK5i7aspVpPNQZSJCXxh4+WgWas3T0/zLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 14:52:23 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 14:52:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 10:52:19 -0400
Message-Id: <DJP0RTH411K1.3S9HHV01U16S0@nvidia.com>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <derkling@google.com>,
 <reijiw@google.com>, "Yosry Ahmed" <yosry@kernel.org>, "Dimitris
 Michailidis" <dmichail@fungible.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
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
Subject: Re: [PATCH v5 12/18] net/funeth: Switch to higher-level allocator
 API
X-Mailer: aerc 0.21.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-12-c87b714e19d3@google.com>
In-Reply-To: <20260703-alloc-trylock-v5-12-c87b714e19d3@google.com>
X-ClientProxiedBy: DS1PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:8:44f::17) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba770c0-74c1-49b2-79e6-08ded912b103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	6mEVGXNzh8hNsyJsBOwIdpsf2CFz4Y1rfewevWQat0pH4qZSIcHzpJuEJAH9ivu30glvxG3YO4LUO7ilCX18IkPrpRw8SUK9UEBfp4sGPPVBfw6e+V0L3ulRssuH4pxZmO5hz9MPRUiNl6McuFGFa9BwPVfVLPFkhHzD89/FiF1kn+P6tN59wju39njwQX1T8tTPLIxc+7A1X3keUI+3X1SOJsuQdgIyFLiiMWHQJ8YZewYYZu6+nmOIekr1YZ/0XM2TkOPAy0ALDfaLFGJ0SQHmmZTj4Y/e5ARjxwczYOxO9ihyXRBUef1WKtAU99nNGRUU4fW3+lJn4jxKVQb/mmvFJ3WOHrVHtazj3yKSbqHl8hiYAf4xXnP+EOZiVgRG67x4iNS4bjStxFEwBwLR/0/8sAAWTUwlxWNSFdnTUeWmgvmvOOoTJIDj1IM9bZ+5MJsyS23HA7tYie0w9G5QXu8agS60LsDuDcc9hvkZTbmpO09pLs3O1fo/sb2/qmUx163Lu5Z7fMHWjczxsR2yTslcTOAzNSWDT9ts03CmeCp7C/AjuHRVs2+ea2QqhI9yCdleIbyWSO9QfBjgS5jBKpfiYvfaB3tjjsOWpLNXLGxib6e/pje+fxvjpPVzlR7yqKFb1Pv9lq/Ip+RR007OB4suVzuD5WcsW9RGuLOAye3PrpQOlDnCl+vE4hZXIWv64CXkuDNYWmJIOzhr0nn6Nw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aSt6MnZjVmRZM0Z3NGQwTXNTSXNoSllNcng5U0JCNmRhY1FIcXVqckVTNlNS?=
 =?utf-8?B?UHdYaGVBckx3TEo0cnhOaUxBMElHZU1VTFYvaGVNL3p5YkZxNmM4LzJ5ZDBq?=
 =?utf-8?B?bnA4NHI0Y3lJNDhwK0VXblRDTjdBV0t5KzlYb2h0ZGdHeUVVc09nVEdEY3g5?=
 =?utf-8?B?bjdDelNjcVBybzRENGpNY1NGcTUveFlSWE1mdFB1bTZxNVdiamZCc293aTlW?=
 =?utf-8?B?aThmZTNFRkdtak43R2E4L0ZlT2pGSXVIYWwzT1Q1ZkowN0xoMzZQazBuZk90?=
 =?utf-8?B?MU5IUVBReGlvWXBkcVFIdGluM3llRWxrUHp0ZkJSb1dlbys0bVFOV2MzUkx1?=
 =?utf-8?B?dlJCZ2JMb1FKZTJlTll1NEg0WWptYjY5WjVheHp6UEE2a05NSUNGRzF1WXhQ?=
 =?utf-8?B?WHY0WmtLcEk2WmhNdW1MemxDTGw5amI4RnhzaUdNUjZoZHJTcSs1Z0w5RFlD?=
 =?utf-8?B?RDRsU2hBd0grM2F3TERqUzFVMmZtSmRnM0hMYUpIMDRsTVBuL21ZQzF5YytX?=
 =?utf-8?B?UUhkSGcwa2VLdjF6c3V2YXJFUkFqUlZ5ZWFTUEZpckpzTTdIMEkzZmZlNDZV?=
 =?utf-8?B?azNMak9zM1lvcXdCV2NzQUY1aXdZVWxlY1FqVW9UKzZldXAwYmRYV2hLWjR0?=
 =?utf-8?B?M2MxK3Y2NlE3TExGek5NUGEwRms5S1cyVWJXUVc3Z3pwVUJ5TTNrdnk1b1la?=
 =?utf-8?B?S1paYndiUmpoaXlLSVdDcXpYQ25NdWpobUJ1VkdQYjBKTFNhYVFiTFlWOGIr?=
 =?utf-8?B?ZE8rSHZxbG1aNlIyYjQ4OEJ1VFFNTHY3TExKMURzejBldzZ0WEZKdzQ2dTA0?=
 =?utf-8?B?WlRzQ2t1Q1hRWGNDelZScUE2RnZJNklyU3JFcVpHdkdqNFBlUUNndHM3TW5U?=
 =?utf-8?B?bHJJT1VlV3k1bDdTaTVPNFNEcnM4NjNFM1lrVjNZTG50bFcyN1pFdjVJUnRI?=
 =?utf-8?B?VDU4VFdMWmFNaVNaMy9IWmVVUGFaaE1QODhsM3Vmb25NVEFCempPZExUNUQ1?=
 =?utf-8?B?a1VFS3VaTlNkRlFTWU4zcHZ0VWtrWXBoajMyUGk5YlkzWnFjVjlld3V3UUFs?=
 =?utf-8?B?VXlEVzk5MFRnbGRQMHpVVlBsRTlrTnVlQUduamQ4R1V0UHZDRzRuWmlEZ280?=
 =?utf-8?B?amRQSXlYL3g3Tnl0OUkzZzkxMkVKMzBERjdubW5ZOTdCRkxYaTZFRXA1cE5p?=
 =?utf-8?B?U2paM3ZRUzBPd0tHYndRSFdWQkl5Z1ZiNjRUSEpiblFzNGhxeTJ5UTMxcWNF?=
 =?utf-8?B?dXJiQzl2d2RpcmxzRXJVTnhqSEVGdDlmME9DeTMvM25TVTZBc0NkMHBtbWhv?=
 =?utf-8?B?ZWhYTDJ6K1VzL0xuV0FkbWJuSThaK1h1RmxCUkI3aStVK3FaRlJmNk5rNDFE?=
 =?utf-8?B?cUg4cDRKOUNCRVFEWUZhUTR0Y3RpWE9BZlFYcmdvUlhkdXJSVGZGNTgwODR1?=
 =?utf-8?B?RW5RNTRBbkxqYTNzTWhISlhhWnNGVmlUWDNOUUtldWhpV2NqRTJtSGNQa2ov?=
 =?utf-8?B?Vkh0TVZub0pKbVhtd28wZE11bXExU1R2SXljakg3Yno0ZXcrOTVDTGptSWpv?=
 =?utf-8?B?YnhZU1dFSXRMODdsSFpmSVBsYnViOWZ1NHhMVHA5cnlKcDdOUzlLTVNMZG1q?=
 =?utf-8?B?aEdKelNDalh5d294cjVMdXpuWVpuc09qR2l2QkdJTldWSWVWU0lDT09ZWUE3?=
 =?utf-8?B?SHlhaXVRVzZHaENhUXQ0bDZUM0hUTUVFMi84Q21PdktjeE1lTEhCWW53RUJW?=
 =?utf-8?B?Z3kwTEczbDZhZDRLd1VVRXAzSlh4djBBSFNrd3FRNlJhSGRYaEhmNFBMQUVJ?=
 =?utf-8?B?Zy9QSlpEcVBvT1dISVNJWVhDa1hzYTBJc0xyRXQzcGQ2MnJ1bnlXN2pFY3Fs?=
 =?utf-8?B?MjVxa2ZsVlpyaWFWcWhrU1BFR1lxbnpZdVJTbHFJTnpMbnpLa090WjJ0eXZV?=
 =?utf-8?B?b0RpSnU4clFnZXRRbkZpV0p5T0QvZ3E2SkVHblBPNUlkNG9Ua3R3Wko1RHF3?=
 =?utf-8?B?K2phQ1MzNWlGNkJhWnB0ODl0eTd5MHFWN1U1eWdDRW9NeWJLbkNkTFZycWVn?=
 =?utf-8?B?UHNBM3hsRk1ROGdCK1Y3SHVXTiszd1RzeHZyWVRIbkc3Z0xBNDNEaWUxdDUw?=
 =?utf-8?B?Wlo3NjRXTmtXVjNpaFc4YUx1ZlFpa2lkcm85TjJTYTB1cGZpbHVIRDhzUUNq?=
 =?utf-8?B?U0o1TEJyRUlyaVVMVzRCVjliUXBBWWZubGorajZXeWNiRlhUa1RueDB3cHR2?=
 =?utf-8?B?QUl1bEhYeDFXb2lLY0dyQUR1VnRkRndRMmFSMGpSeHJGRHNNeDBLMzBOT2VB?=
 =?utf-8?Q?IZXaBLlHAwZ5V1vsuw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba770c0-74c1-49b2-79e6-08ded912b103
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:52:23.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZkzgZ+ADkHd3wcQEJj/2u96ag/8XDug20urYq/X4QNc/fVlFLi6NfbxcFYiBsdZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520

On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the latter allows you to pass NUMA_NO_NODE.
>
> The former is going away and the latter works fine here so switch over.
>
> No functional change intended.
>
> Cc: Dimitris Michailidis <dmichail@fungible.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Assisted-by: Gemini:unknown-version
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  drivers/net/ethernet/fungible/funeth/funeth_rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

