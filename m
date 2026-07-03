Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6621B3EB105
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090247; cv=fail; b=nU5+FlWQ/g4avaab5ACMHiiWkVNuKcS6eYaLVUhbP06sjDXG8CavoS/prBML9ced+rvtq0gMFs9dELiTMwo2mRDveuOHa/nCecpZUo/ZXCdn0NtPIt2Qck9aosZzHA2qKH+OYoAIoVnec6nQjYrYt4qNQWiNydIlQP+jqbAsYck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090247; c=relaxed/simple;
	bh=+tE3nabaRtS5btHyUxvzJujeE+Vfd2xAWLsncw9OQzE=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=QohiIbd5pCTgG5/fnZUcXnSejkePw77SJAgGyQ8NDwy83CVf3BT15zMI3uPkTw2PkNlE2sCPBZePn3zsHyvNl7tQCTl99vCxsBaOYT1xoPRd0HRP49ewVM5lLr/e9RA323ygO2OpWCvfxGy7LHfLbprZQCLPk6COSMxFw11Bd5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YVklUgER; arc=fail smtp.client-ip=52.101.57.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YVklUgER"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mki9KiUwfIM1ZdtkwtUp1zVC6OWGn8Kea68HcuRumdFvM7U3iMiZionnlqFGueT43O9CoTON7Y/8jZ8Fe8t+Wppoio3QUTsf90jEYwSQAtMnB5c4OFF+ucwCBb2cyW2QUnjXjVj2/9pJbZCXTc9MqLTOwVs3skUnx9TQ0vqQIkMAgJ9TlK5Lmx/nZY2kJmWPQCzEqwPn6sM2ra9p+haUp1JsoRKv/n3JjfFjZiCNDYAibeTJw8BPbtnytlq/xHj4d3ETRKHVYE8bbnddKKrR8XlDSs4aI7g4T45A/MsD1ZbNIT0MPfTHARtqvKo+fQ7BN3c1nGmYzukuAU+SbmYUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbQmU5NGxz4YMhSbc0IOcqwdamjHWIBUHZvnDpUv/rc=;
 b=okwUYNV+p/TVHSbxtGZmczltahR6zuteU/Aj0vBgtFCWHwiyxNO1QGK25HlRu8OewcV1pMC+IRe21u3XXRQ8d8FjDheVryoo68duP6Kz2XV9UvkSkOe4LJ41yI/lJRo4G1BNLq2K+UTDSnP9ywMxUguS7W8S2nKDcPbbobIgQIbURqgWcdEWkDYGyTmqEg0S2EdooryGJukzIJ3UnPihnxw5owM7umNFuDrxbLT2/cbRIYGjg9trdD9ZcpG0/sCIH0n414LUl6Y7i1YSDF+UbwiFovEFq6zA61lFmgzOOOkHbTLuDwuV8fLa6Ws7ivZuObwQyLD4GXpyn9BI0DvhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbQmU5NGxz4YMhSbc0IOcqwdamjHWIBUHZvnDpUv/rc=;
 b=YVklUgERyV1ldVY8iEkxHNZUbuiPk/hLnr+oUISg21IiFP2bpriGl1bxt88eSNeeKfRU4u+dxCW6WsK3CIoux0EMCat0NQ3xAUbU1hb1CeAHVyA3AT2BbDFkC6BMyifMMx/It+E9a3o6pO5M5E0GelTRAeQXSrpSLFKUjNMOffr9ygNTmFF3LXGWB7BmNdTMw45Gjj+cykCx0Z+Dv5sDVEjCbff+kqEANwyBVKmp3ydxg61k9ykhiaXgXiGv1/gOyBUlOyPCPe0Lv33u8Gste4CtWQiEvWYXahSB1kFGQzdbutUxeO4dhN9iabl5WzGB5yB6srcXoRprDM/MBWEjXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 14:50:41 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 14:50:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 10:50:38 -0400
Message-Id: <DJP0QJ0P724D.1QOIRWK4RKULE@nvidia.com>
Subject: Re: [PATCH v5 10/18] x86/virt: Use higher-level allocator API
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <derkling@google.com>,
 <reijiw@google.com>, "Yosry Ahmed" <yosry@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov"
 <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
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
 <20260703-alloc-trylock-v5-10-c87b714e19d3@google.com>
In-Reply-To: <20260703-alloc-trylock-v5-10-c87b714e19d3@google.com>
X-ClientProxiedBy: CH2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:610:4f::39) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 224ceef8-9f09-4f23-0bcf-08ded91273be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|921020|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fvMx4/PiItCTTxw+I8rTPJC90y5xExJmeXgczOD5CbC12om+OPgvHkKcy3Bo+3/UiPSvzv1YG5I55x+1Tvdum5p0PITNtBL+kEr3vQveMFDosDoHBZCZWqoLEwB0tMZeRMVT7/kG45Zza5GPjb9bTBe+jS/77XvPJERzXgm5AmULMpY7ti6ZpdHSSWpFmIx3oAPAgTq0boedaNYGr/Eu6MO8jDgWkgB/SCi1f2EHVElL2faBD2jv4ds6SWyCWXQE7oz/emioxaYPYTZCcTkjBVwvV5ACwGBEqB6HrsK60JXT+/i6CGHgqZKWwu/+r+BkANCkOnkK6oC2eTFOmxEv3t+V6DQ44JIdSjn1iwEhNrIU1kmd+N9Xm/zEuc/Ee8JrCbU/yctUVdDPTlTq93wc+6dVnnjKVBjVh55FTqvIADomrrMzvNGeRKiTUjNXNTrD13mjwZtgWcNlpt8V7vxTsZjV9yoN4XeL011epAUJCZQeWkOMItt9Vot69v1RxRVaKx1LsdmB4mdwcYzZR3p8U2q0bi/ywA9yvYGvI/LU0lMAw/pQERFTE1JAY4zgHdO61Fh4rn+9G2tEeRnil9ZHLaePAy3sJkGCx+OfcqAzWFz2puicTbTafFgncP7h4CJjnGI1D77yU9ivhl9RI/73unSEXlAR7LANvuU/IlrsRydp2TgBodA4CAhCFgqALw5rHai7dGjjLTs18oN1EPqvgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(921020)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1B0SG9ZanMveCtVVGZ0S21FVmlzeTdFQ2RFL0wvNWZMemJWY0xRQ3FHUUs4?=
 =?utf-8?B?c0J3NWp3NUw4bGpFclMyUlgrWEtIbzVLY3NPZXl2NDAwYitFWFgxUUtNTDJC?=
 =?utf-8?B?cTB1RmhNbFNhQmc2bHlZZzRHK1NwUFlnNDNjaEorcGVqNDFJM3pQd05PTWJj?=
 =?utf-8?B?YVZkSFJ4Vzh1OWQ3ZXlUMUVIeDZmL2U5Y09XQk1tSlJjRnhtUmZoM0ZTbTFK?=
 =?utf-8?B?a2wxZEhvOFExcURxbnBlM2lma2pqdHo3bTlRUjUxTDRTUWgybTZ2MEowNjJW?=
 =?utf-8?B?RFNvL0d5a1UzK3k2ZUN4LzVpaWdxRWtWZmVLUDQyMjIrUlRlYkN4eEMzWVQ1?=
 =?utf-8?B?K3lUL2F4akJkbjM4M2dqcytBTE5kVVQwcVNES3ZRMzdRVFZvdEdsVmtPY2Q2?=
 =?utf-8?B?YnZPampJeVVVdUtsQmkwQU1Ea2RTakJTcm1RdHY5UGNQdmxOcmNoT01vU1NF?=
 =?utf-8?B?VXdIbnE4L2JXeGNEYVJnZGVVbXpCVmU2b05md0RPL3lxVVZScHlSam9SdFE3?=
 =?utf-8?B?c01FdjdsemRiVVBZY2dNcTV4eXc0K0VKWjVxckJ1a0s3bkFSVmpOd09RQ21i?=
 =?utf-8?B?YXVOY1BvR28wY0gzaFR1VXZtWjFyd1RBRVNwTGVCVmM4RUtZQXV0OWRrQUFH?=
 =?utf-8?B?ajUzOEc0a0pJRGwvNkxyM3FqQ3gwb2VlZ3IvU0xMdE40MFlSWmN4bjVEdHhQ?=
 =?utf-8?B?VTBYV2Rpb3B1Q2RCMzYwUlJlZnRUSkh3ZUJSVkdXeFBJN0dvUHdHSG56Mlln?=
 =?utf-8?B?UlVaZnIyczF5VE1CazFWV01jQkJtREVJNFRkTHJHb3NDVlo0QzZXUGVDUUhn?=
 =?utf-8?B?dkhUS1BwbTJubnIwVWJvUHdyNnRidU1ya3M2bFFGMmhiRFRZY0U5bEVGU0Uz?=
 =?utf-8?B?K0R6dDMyNDYvTURKcE03MXlBb1c0ZGJoMlNSKzk0anJFTko2Y1RUNXczZS9J?=
 =?utf-8?B?UjQ1WDF3TG9oMlZnYVoycU94ZDRUQUQwbGhabTJrTGVPRHliWSswMkMzRHQw?=
 =?utf-8?B?QzZDT1hmOXZZS3NEcEU2cko1eHFjWjliRUdlMlUyMEcwSGxObTlDajdlYTRy?=
 =?utf-8?B?Q2drUk40Z1doQTQ3SitFaS9uSEFFbjdncUlmYUNCSGRncWVwaWQvUmlsYUNi?=
 =?utf-8?B?TzVzd25sQk54UUJjbjhGcC9JK2FaWW1WR1g1eUVTMGlxSjh1YnZmbzV0Qk5R?=
 =?utf-8?B?dDYyenpIcFlqUTFZMTdqazdrRHBuTDB0ZXJnVVRuVlpRU1M5cWtHeWZaWVd0?=
 =?utf-8?B?bXlNSndLNXB2dlJOOFdRQkFlcThIa2ZMdzRpU0lTdUovclV6THQrZEtnS0Nh?=
 =?utf-8?B?VjdCUU5nckNZZS9MZmVucU1kOHVuOG1KdmY4aUNRRjRFTDRCS1dzZHMxazM0?=
 =?utf-8?B?Sk9ERXZhRmxHaFFCZE84NzBwV2xzWDd4OXhkQko5UTJUVzVkZFp3TkJHZlBV?=
 =?utf-8?B?QlBSRXlKZzg3aWJ2Ri9zbnErWERJNVlXdXo5eWZ4d0NVT0dFQ1FyVzBCUzdI?=
 =?utf-8?B?TEljOUpKdXJ4L3A2andCNHdORGZwYnZSTnNiekg1YkJmRk05a20rWE56eXo4?=
 =?utf-8?B?UHExbk1ML2IvMGZrQWNXTXFEMmdnUkFxZ1ZDRlZ6d2tvU01veTNNSFkvYTVv?=
 =?utf-8?B?NEFIa2tPUFhUK1NQak9LWlMxWTNRSUdKQTZRVU5yTWFheUEvdmF1RmhXbWxt?=
 =?utf-8?B?elRQb0VMeFhsK0pMZWxlOEFoWTY5WjFFTlJBc3BiQTNNcndtNVl2ZVlWSzdC?=
 =?utf-8?B?bnRNeFQ2a01ZVU9RRlJBTE82SXNuNS85alNjMVhJTGh5eGpRbHNUUVl1Smpm?=
 =?utf-8?B?Z0V6b1JLM1BNWlBPSEFSdDU3dnloeWVJWC9XY0tTcnFlNW5oS3NvbExhdTUz?=
 =?utf-8?B?bVRxVng2dEZrYWNySlpkMVRRbEMzQ2pUMmtiQlNJeWVoTUROYXd3YXQ2Q3VZ?=
 =?utf-8?B?ZkVDNDdmZkRweTZmS25FeXQ3Tnl0cHcrc0RDWVdUbHFiYmVjNms3S3ZSZWxo?=
 =?utf-8?B?QmNicmVmK0hXVFJIdHRncDFXZWMvYitoSGd4ZHdGckxWZGpoL1FPbWxLOXVo?=
 =?utf-8?B?ZFI4VkJOUHlXUUFYL2pRY0hSSnZLeG5sK2ZiQmNmbzRQYUc0MDRtY3RBRzhI?=
 =?utf-8?B?Q1FaNzYvQVBpd0Q4Z1pLbzJ0S2daRWFDU2c3Z1JHREdQUmM4VVJLT0dBQWRp?=
 =?utf-8?B?MnNLRGZ0VUI3UnJrdWZxQ3E3cTMxR0RCTjVuYzhob2lvemR6eTVwSU5ydGZM?=
 =?utf-8?B?SWxLek9mNWhrVTZzNFY1djk4VFcyQnFWUlluK2syOW9jK292UFg1RmxoUnlW?=
 =?utf-8?Q?vuLJNDwNGQler4MYBf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224ceef8-9f09-4f23-0bcf-08ded91273be
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:50:40.8928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvu20ipTWeJU+h9hD1koXUTpTTri5tv8rt6E73IBswVdfKkz3fyf4qI3yZJlgVD5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the latter allows you to pass NUMA_NO_NODE.
>
> The former is going away and the latter works fine here so switch over.
>
> No functional change intended.
>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Assisted-by: Gemini:unknown-version
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  arch/x86/virt/hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

