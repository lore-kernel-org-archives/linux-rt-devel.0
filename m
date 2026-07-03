Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405E3D25C2
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087374; cv=fail; b=hMl8DgD+pEo2hn0AuHRkK5X6+pCK21d27RszSmNzjidHlrB6czLu+Perepvy7X65CDonNSywB6mnKB5CViS8g6YqSbmjfR8VhmT+2nNIujDxMkFEcmzeQXOja1aCDczwQKAD0EVInXja+3c+GqMSRVzkGsav9rrPM6gOJ6cMz3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087374; c=relaxed/simple;
	bh=xHWQXIgCzg8tU7SDTKO8CS3a3+e7Iuz0FJygdCtXT1g=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:References:
	 In-Reply-To:MIME-Version; b=WeSMFIZIh0u1YLOrdY7GpUUfNuJMSL1cEYw5yrK5dGBwXZBx6/WfoRpttVKO+CoBuo0CcEqHpQELzi6ZoWh1k6Lr6HplN/VDxsBaXexAr4P432kKAfzpk6Nx9dON1riXK0euckv+WQq2CmEHQezubps3NwIpVGKcogw+eJQmKbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J3Qescl/; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J3Qescl/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDJrxdQJ+Ysk4Jt+yNFdEDoqtUT3B3lV28k3VKS08s5BksQqW9lfT/wrMGjkZgqOTHELybcZjyM4wB4URBcu9NfUa1aMBJv4rZJy94XtCI8jucOQSf/6Ii0cLRxh9Vso2reglmrx0cDgeUl2cm0AuQSMC95vy6lcixoP9cBPaCeNpT2DNFjJVJcO+HtVDK731StR29K8FxThyCr36R+nJCNUWrtqrw+KwcVy5dA+uOg67Af4yZi7kVyXgLw+G8Ao16cVQUtdLvuHl79RArh82XIhgJqa1fccPCEDNkR9lrSXeY+ttZNyE4jeof73BegAg6ul2v43RIQ1zmogTY3eow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VD1twz+93jY0dG8KHpbDMH8JpGV38B2owJ5Pj69T9s=;
 b=Lkbbj1VDeeolZ5MCx+5sPcd/hKv71C48tu/kwUBefbDK/kXPoRixEGIIi04spCY24rv+XnUdHCZ/jorvQjGlc4HIVrPk9PQNdVErUOTY2p8HVWrlpn1fwKRkmuIXoRQuzAVp1aYTi3asHOc0IDBbLbzNlSADiyV7r0pXZAcj7DH1CIjmSUaq+Cb8EjdulgIf/JcNHL3IotvVBDviqm6ALshhQQi3aAeBlVv83M6hr2TYy3CJFPkXafOEZm89fiAdQGsK5dMr4ebk7CPcsGeBuRTd7eq+VAlAuo2fi/VvH4u6aY22Zo/gyAkEqgFJhZFbWdUxrmDHMPqwcI8dgxbR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VD1twz+93jY0dG8KHpbDMH8JpGV38B2owJ5Pj69T9s=;
 b=J3Qescl/jWzsWEw5rZl+qMW+2WQRSy7UpksiErc+5Gl9GULc8D/qd/SJFEFwHT9IjGfVJfXVaO7WlPMSA6PdYCC2Ke8zVMYJa+HIt8HxFd/MpyxwsuXx5SqGwzpATeFUFZ0VuWnv6NJ0AAuBlpYp2DgBb8sr+uYM5Le1wO4+0H+KLaRWBFwlfZTfohwdYq3CUIINQ4WAufAHQ4/hc5gSB4u71Tg/k4/ml96RPSXFR8E2lluZSjOgps03QEplfkZ6/9g6E/d628M7I4iw2ks7RrpETNaSoZ0K5e2JBibgO4bfLpPmeKBTB5s7c8lCXXt3xn4ZS9fYvz+rWjzPnxrYOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 14:02:46 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 14:02:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 10:02:42 -0400
Message-Id: <DJOZPU3A1P4N.9I6MTPH6QXNW@nvidia.com>
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
Subject: Re: [PATCH v5 03/18] mm: name some args in a function declaration
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <derkling@google.com>,
 <reijiw@google.com>, "Yosry Ahmed" <yosry@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-3-c87b714e19d3@google.com>
In-Reply-To: <20260703-alloc-trylock-v5-3-c87b714e19d3@google.com>
X-ClientProxiedBy: DS7PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:5:3af::12) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: d7defbd6-fb71-4646-30b7-08ded90bc29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|22082099003|11063799006|4143699003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	QsqfOImD2SNtSOgNuSlWQtmzx2siJSro39mn44YDdREkgxq+AAPLmC42MzEgj/t0jveRYyuQw0EZ8BOaz8h1CKO5Unp9eYarnqM4RTwVxrOFoMeq77DJhkh2CBko6JCRNRUYu4toFBYN5LsL9URxUWwWkA1bXtIEv0NVjZmLf4XZYCxTytezoNHloNSu6R+WD1jQsukIfhT+7tNBmr4A618ga7GNGkl+bU0CyPrGBORCSo0Wvr80bVF+QAD02Pjt1d+wwCZczQLZvo/r2ONkh9yFNLm1/bdOGc7eeYY9L395sQBOSsOLsuUXF/B0rJ4s4g3Qr/taLVoyybXGNA2sn3MlQJtVAHSH7DSs7KKuzD2e8wHyWYW3DGQmN5ZDnAVRWuARQPT8anEqOIb+CXYVaDGB/AecevMWWRQJDLstb91gqMnANBsT7rGUU1qQ8zRpYFCW4EN3c4pOCQY0f6ln8gdSB+KbMGva+3NlCVlRpsIiwe+BbsbbCCzpDxnKbV9Si/OeJPl+zOvhyX8SC8KRzGjqrzpqOYs8SUoGqlzB9ZuQzAQlbNiyqvP/fdL/heIpqEpL5Pd4ypc8Io/rIkt5PIdqg2A0qs2jfdCpZob3ftSsHNn/cGvS4LrqEbIWoYY97LgRMqD5dCRPan0iVqKF0O+ktb7ZzckjD+IpReUlJ4u5df6WFJg1anieRfKts1Vbm++6wYvDcjP0pDZHq/+RLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjAxZU5TdnZDN1hwdW03UGcvUVRqVUMybUFBU3ZlWU9oSEptVXVZRTVRbTRK?=
 =?utf-8?B?ZDY3aDJ3bTVEUVJaQ2cyUlV0T0NkUEV5eFYrTi9BaDZNOUVVdUlCMUIwZytF?=
 =?utf-8?B?QnVHTUY4OFh5WlZsejZnaUR6cmQzYjd6Y3Yyb0pmcktxRnowN2tid1dXNE9Y?=
 =?utf-8?B?Um43Yklaam5oU1FYelZSdjNzOHhsNWo4VS8xL2dEcHA1UE54K1A3Yzc3THB2?=
 =?utf-8?B?eTBhV0NEd1ByMmhhOSs1amJqZ3p6eXZiV3dRekFtYlgzQUNPK2ZQNzdxS2ZB?=
 =?utf-8?B?K1lVTTRJd3ZHaXY4RjdhVENpRzdOV3dHQlRFTk9JTVd1dnFGRkhjcGtlaFNU?=
 =?utf-8?B?aFFkZFFIaEl0ZmRXK25zNHlBVVhxd3RVNlNaSUJUMlJZY2lYeEdGSmNrZFEw?=
 =?utf-8?B?Y050c1lQT2I3NzdCakI3d1QwSzdUVUM3N3NlY0tkbmZVNy90aC8ybHhOdjVY?=
 =?utf-8?B?VTZtTEJCV0hHYkNuQjhmeWU0Q3UxazFNTjVHQTJGWXloWEd1aDZVdVQyS0lR?=
 =?utf-8?B?N0FNWFBETnlLUGJ6d0p1OHVUelZTbVJYN250NDZiSzVXY2FIdm5kSnBpblZG?=
 =?utf-8?B?RXRSckRwRitpdno1bGFKZ3NqSjF0WFFISmJFN2RWS2ErUUVOVHdGOUh4bjZH?=
 =?utf-8?B?RDVpSm1QZHRHeGxvR2Nwb1d5VkZNRXBNUWdUSUxzaWVUc3N5Z1NCYldVNHR6?=
 =?utf-8?B?amo5clFydkdSVXdPUk9xaFdXRFZRZmVFUjZBTnhsOGJ4SHh2TTZOWG10RGl3?=
 =?utf-8?B?MGl5REJkUG9QRWYwaXIrVGNFeUJ5cHNRUUlWZURmcUxVaExSN3dhNDJhNHF0?=
 =?utf-8?B?UDdFNjhZNnpXajVHdkNaZS9pQUwxbHdnRDR1UHpFV3N1M09xZlloK0NhMERW?=
 =?utf-8?B?Sk1tU21mZ3IyTHlhMkFDUVhWZ0x3Y2lNL21JdmQxN2Z2OFNaNzhEK0ZUOGRK?=
 =?utf-8?B?QTFxOHpqbWRlNzlmZzZqdnd4VTkwYWJ0N0xZa2hUdTZ6MENoQ2w5bjFJMWtL?=
 =?utf-8?B?SWRKRXRZc3lxOU5EMS9UK0xRT2h4RG5kd0VXMnVuWEY1QmJSUXoxZTA2eGxH?=
 =?utf-8?B?Y09jWTVKbWtVOGFCNVVRME1MQWV1dmJnQ3pMdVpEQ2xFV1dwejFtb2pYY0V3?=
 =?utf-8?B?RFExRkJvZEV1UnBGT0RFTFllWVlWUWp0Zk92eXBsYUM2cksvbnpSbWZaU2xM?=
 =?utf-8?B?VGtoVWtMMDhaL2ZBb1lRb05VcDgyckZlNlpkRzlCWE42dWQwNkVDcGR0b3R2?=
 =?utf-8?B?TEt6bEljQm9KaXIvRzV4QzlIeE5hc0NQdjMvRjdNKzYrMXI2bUNIVHlZdkMx?=
 =?utf-8?B?SzFWUkZ0VE5RbVZyWlk2OVJaSGtWcXhQRngrZFhTSWYxdVFXdys5d282em5w?=
 =?utf-8?B?YWlJbWw2U0tlaUJ5MEtFTEF1QVZKaEVELzUzcm04a2pKQ0RPeDgwUGgxcTNn?=
 =?utf-8?B?SUlXcjlsbUQ4S1BVeEttamJWUWhCeS9KdzNVNTc1Q052WmtZN0tKcTBJckEr?=
 =?utf-8?B?OHk4STNzVkNSNWZFQlQreUQrSGZUU2M2NllVSmZxYXhXbEVOUUZIOEFGVi9S?=
 =?utf-8?B?Q0R4NzRDazFLdUJCdVgxY2k3amlRbUMzeXZIcGNSa3U5Zmg5V2ZFU1pneWhM?=
 =?utf-8?B?bWV4eFVNM1QyaGZSdWhwSG5RK3dzbkRmR0ZhQkR5RkZ2aFRWS2VJMFpMZU1u?=
 =?utf-8?B?a0NVdkRrenA3ZG9ZRHhHZFNOVFVSeUowSmdsMlNxWUJocmhNY3ZrVWdkMXhW?=
 =?utf-8?B?ZTVZRUZsYmlTK2lVak1INFMrSkhHWjJBcGdUZ1MvaUF5VjZSNkxUS2lZNk5M?=
 =?utf-8?B?YituWFNFSXZVcjg5UGh0dWM3RUF0Q1JucXBseWpjTFN0RmtLMGo0cjNkbzJX?=
 =?utf-8?B?c3hVZ1RaUkxETldBTWFyTzN3RCtXMlVvMmNBaTdYNks1elVrbjRQcWtZTEI0?=
 =?utf-8?B?MmZsbE9UaUxpdW9kbVpwbG5vakVOYi9idTIrTG5TWDRjOENCbU5sVDQ0ZEND?=
 =?utf-8?B?SVBGMlYrUUd4Ylc2cUtEbWFLYSsrbkpLcWNvMWdMOUx1enZTVnNpSEIyMUdj?=
 =?utf-8?B?dTVDdXRtN1BvQzZnR0hqSk1GY0grNlVtNTJjaWU4ZW5hZzNia050eWZXb3FU?=
 =?utf-8?B?QzRUNHloeUdzNmx3bFRhb2drQ0d6NGR4cFc4bUl2eGRldk80NEFrSmJkVlpW?=
 =?utf-8?B?MW41bWQ3VnJHUXJZanNBWDJnK09hbnkwSmIwekpUOHFLaFBwQnowa25UVjJO?=
 =?utf-8?B?SjNwTnNaeVgwWFRXMnRtdTZCVXhDWGxjMGJqemw3d3JNSFRYekdpcFBMaUx3?=
 =?utf-8?Q?noaVlDXAaL11jWCHJm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7defbd6-fb71-4646-30b7-08ded90bc29f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:02:46.7529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /h/XRvOUbv+3EelfAm7ud392RIjFIQ+XXn5k35L1Ztj8JP+9flGSU45TwlZlyPQJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931

On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
> Checkpatch complains about this, a later patch will move the code, fix
> it so that checkpatch doesn't complain about that patch. Do it in a
> separate patch so the "move the code" patch is trivial to review using
> Git's diff colouring.
>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

