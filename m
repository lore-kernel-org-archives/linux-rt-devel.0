Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925062;
	b=0FfRZfoq8lDc95o4OQ/TnOmPvacFgfwZv3RnyrzeFpmS9s0+6Nyk7f+z2OxnOFwzMCuZ
	 NVGQQwnH6g+qQ/4OWcN7btLvlITDaMkOTTdvYKSfvB1PWgtZ1812n+2+r0L1MVn+tQC3b
	 GUBweZRABnkFRFOgjDnsbwmIBY99cbIHqqfm9nQk0sao2eCw6Zgp7O190ZMqebSWRm2Rx
	 wadoCMUG+Dn6m84XEDKLnUGGJ/5teaAC4kdsqLJ3iXb48FMF6k9EYtMol1tW1reHU43/F
	 CV7YIspp6IlmxwDsV9S9L7kJr/1Mf7r/8Ie3DFLTBdmhU7mK01VOuQ55PfOTJtHsZUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925062;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pho5LZVzaHn6uw1cBfSq0CzZdMtFEoMbcRLpiSlsiOA=;
	b=LLUQyRAGry7q7i9kUwlEU+Hl+Nb0xE28461fCMlkXS6Z8TSF0xN5/Cs0VYl0Ba8nzrOW
	 HnLcvOxheHsZ44yK03LhBwWalm1aQsvZKlVg4Cd061Ys4ZY2G7put+Dwi95zfu7GhfqyC
	 0Nsx0uPD861ZFyQmsgXbhDS6CSR0ACvh8Obu43LzIaO/izsxa+X1JBHK07rGJXk/OCZLR
	 zaGSxO1QBMgBNa7I21+fphDEmY6dfvLveLK/cGX8epbkRoitCYRWAW98c8ZWSmEe1tSl/
	 jnEV7n46sd+qgTteNUVyzbnutuxWQdafx2dizHu0zVDa5/js0CGk02nspk2MDukapow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="OuW/20c7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.122
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020122.outbound.protection.outlook.com [52.101.189.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874B606A339;
	Tue, 17 Nov 2026 14:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8874B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=OuW/20c7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7uLGeKTnOiX42Fxduhe0aszx/R8vBFHLuVIJZj34ahj8HPZvFXVFuAw2DJdHYShFsxMksJK3py/fSYc2u7D2+mUeM1BD3kV18Hjl/ngR281P4BnP0snPbp+7NOA/pzk8WoSC1EEfOk/IpGWEWOJd4Vmq0TubqDGwXgoKbMTLHOqV1iHAMpaY/uCT6GRNqAA7fhbRQSTFS3ykfVkl2xX7ksDnjTcB/gwvXcCRHwaDBS0/txDOF3oCumbn4oxgPjOBn2b9GY2Dn57+blfs9D1xM4NnLJhCdBMARlD2Q64d7ZeSpeyd8JkexW/JTM3q7ZWjRuHe1SYS6DYPNjPytzkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pho5LZVzaHn6uw1cBfSq0CzZdMtFEoMbcRLpiSlsiOA=;
 b=rckYyym9VAzEP+4lXknKA9XavAMcF8pm9EYMYHC5mCCWRIf50ffAJBl6vgd5dL1JtsGPUBL6k/LiWQarKo1unTXWZ47YXzNj9b6fs156hCGWMFN9hQSvc0LCTxmd5Ox8g3DwW6hpN1yBzHNSdTvOSdMuDcTrwged0U7/pCbVZHyDKlSE0mGLw+f3hfJ5aLhsHWkwSsL+IJVd0E/1uZ4pEr46h/m622jY9qwhhlAbHh5VVeQxlmeaku3wr+DuoljOdTqB4jh5Gg2n1812ogRWhqQOftHxqgcL9PynjNQhi5RaqEFMdG/b5gTvYFevaRJ3zV4CGeqez6VeiWdo75q+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pho5LZVzaHn6uw1cBfSq0CzZdMtFEoMbcRLpiSlsiOA=;
 b=OuW/20c7YcwNqRo4aA5PP0/6TliC+MmeWfrzhmUCCtekumFuSK7wiD3Qu0h4gn44DOR4xZzJJvUsksU6MBJZu+jrZKl2pg+s49vzVW3uT3AqhXqYhQqPYnB/U7I+xoab4NxWeWJSOIe7M6+OC/S4dzbTHrcg1quvW8igfnJyn/uDwRIduAogsGbIppz94A8byakbbWe6dIU0Zh4zo1n0BppoQgAnX81xsbakPTnaNIMb6Tkm6r88YiDmRWXEw9hXSNd4FZ3jG5LhVFBZMRp7dhvWXyh8BRWNNSA7wYa1K7T4AoA3Lpypjm6tunwIvoVT2+d1fwK8W+QHjD9Ucatg3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB9777.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:17:40 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:17:40 +0000
Message-ID: <8d6e5ef4-6b6d-4e22-ba20-15e8f76e6389@efficios.com>
Date: Tue, 17 Nov 2026 09:17:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 28/37] cgroup/cpuset: Refuse to take a deadline task
 out of its root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-29-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-217636@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-217636@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::24) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: b0869594-40cf-4aee-d7c9-08df44b589ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|56012099006|4143699003|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	homybMrni+kFjuZxbFwPZ+oQd2N9YnuQvymX5dHVydTsyoirSi8pf3fZyjWBhigWBTT35zVpR7vE/4PaHtxaMWfUDTomI6uVxbiPQDki0PYFE+ucU2MQxlOfYoDnnLruR4WpOF0ezffQgyduKTb/R8qFfSmjeJ9o8n1y57AR/EPNqc0JoizdNpU2iSj2v63C2FIFuy7BjaHVoqGZfzX92mxLmOellSkqBVOa8yTgTksZIn65gXYIjGhy0r2sff/yRiEpepCXrh9iCU4Q7Ooj9N5OKC4LUcTz3q/prWldjpl9vya0ewULL2tbffw4NmmPuekzyZgcnhmrl2YcYNC3G+xBiqnhHleCIlezYXt2OD3xZy+Zq365ozltpGKr5q+vMFjq9jD6Xy6L9S03Bp0p2C3vJeDZkAAV1p0bTM1Tm7GGLaTdnbLIwi5l5lrXyjuovjc1XUif9zaXhR+sYyFr470HOax4dCP3PrzuqNr/oVgcdQjNIVtVLJgp2AS3WJCOo/6sEFLvaJBqAb+qoh6T3SS1nxwJiyCcJb+6cD83b4hK7981DyKRvTkQCGNKWp9nERrHcznRA4B8+DVNAW7sX8e6wQKL4JuqX0keAIj1QHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGlHVzRGb0NsSWdSOC9adWlzb3hiU0FRVVdZZkpmVHBXK0FEemg2NUovcUtX?=
 =?utf-8?B?dEZpVlFrL1dkejZETVhxYVgrWVNNTGl4ck9YV1VmeEk3ckVPalFEb2NNdDhu?=
 =?utf-8?B?RS9MbFp1SDJuN0pFL2hoZCtTQUZybUIrTE1kSmdYUWloQ2YwWmpnU2NMY3hi?=
 =?utf-8?B?cUQ1TTlyYjhOUDlvZ2NwUEhWRTR3N3I5Rk0zMXYwN0dzQ1o5NVYzU1RINGhM?=
 =?utf-8?B?NkhDd2FQYzM0ZVhPeGdlYlBpSHRyZDlwbjdrTFJpdytKK3VCWGxwSS9RWnZD?=
 =?utf-8?B?dUpRa3phRmdtN1dEMlZPbEYxYW56d2RDT2RRejg1dDR2QWkwOGhpSjc2UjJp?=
 =?utf-8?B?U2FIdDZlNWg0MGJTRHBBQmJydVZNK2wxNFZJME8ybnVmWTM4aGpKY2FrMHYr?=
 =?utf-8?B?V29GZnJadW9DVDV1ZnN6SUZkZFVEeGRBam1uVDA4eDJLbG1MS0FGYklTQmhT?=
 =?utf-8?B?N3BMbDhNams5RytDekNkZ20wa1IzeGw3SHdFVWQxdnErQ3ZXeGdXZjlXcVJl?=
 =?utf-8?B?eThxUEpibE1xSFFUeTFCQ1FGNytuQnpCZjJRbU8rM1NWS1NYaEhhMG9IRHo4?=
 =?utf-8?B?L3pqTCtqd1piV002UXBLeE5sQzdyclp1Vm5uUHhsR0xQckxMdkszUCtHdHg1?=
 =?utf-8?B?ajd5ZXluUjIzeXRUWjBSSU1oTFcvZlZ3WC85K1pEdUtuMEdOdlZ5c1RKZTVK?=
 =?utf-8?B?Uyt0T04waWJ6RWcvenhuK0oyYnVRZ1R3UHRzMFBYQlZTSGtCZUs5ZnV2dmdy?=
 =?utf-8?B?NFRZTi96cEc5UmVHN2tyNFVEVThreHY4bUZNd2VyZkd1U3NsWXRJY25UeUZk?=
 =?utf-8?B?N0VsMFFFMUl3Mit0RUxRWUtKWE9pdENHWkR4bzA4ZTdWSlpPYVo3SmFOZG9m?=
 =?utf-8?B?U0FiUEg1VkYwdWhzRXBBWTlLZFVQRGVHeVM1bkhmNms3RmVuYTBhYU5NSU1F?=
 =?utf-8?B?V2VqRG5EVHFEMTdodjZqSWJ4bHB1ODl1dW9WVS9TbFVWWFdUT0ltRk0vb1py?=
 =?utf-8?B?RlZiTThtdWY5OW9rWUZRVFVsREdYZE5GRTI4UXAyb25GWTZJZkMwWFZ4REZ2?=
 =?utf-8?B?VlNJUnhGZ0JvZFQvbDAvMm9wTFBLaU5CNlA0NVFzNStRNWVKVUpta0x6T0p4?=
 =?utf-8?B?aEtBak9EQmZWbXVUV1BlMGRTSEYxYnRHWGIwSHNPVk41ektiaW1tY0s3ZmZh?=
 =?utf-8?B?MFZtWlc1bVBxMU00b1BBMG9uZXIvdmMzZnJFQTlzS2xMaGx5c0V5THlhemND?=
 =?utf-8?B?bjh0cHZXemhQQ0NBUWZ0eUpHSDNkUVAwVFVabmV2VWhZYXBaY05WWWZQTjNo?=
 =?utf-8?B?M2FzSWZCcGVxTFFuY2RuYUErSUFYMWw0MVhVRTVSTkpzTGxLM3g5SG9CUW9N?=
 =?utf-8?B?Rmo4TG9xTkRxSDZrSVlad2JJOXV3bExEYTlIQTFlK2o3QndGQjZBa0M2Z1lS?=
 =?utf-8?B?Sm1zZTVHa2xxVDZRcXFhbFFxLzdQSTBBWlpQNnJQM2cxVmcrKzZ3UHVDUkts?=
 =?utf-8?B?aXlONHM1SzI1VUp5dVlldGRQdERzQi9EZjVzVDFvbnJmRUNlaTczcURMVzBX?=
 =?utf-8?B?WU1GMUp4SFNROEFIeUpJOGNLTzlFZy8xR2g1d3d4S1RmM0JJSHFKNjcyaWFM?=
 =?utf-8?B?eERBTE1ON3hxUldsS3I2V0kwM0NqSE1uYmV5OXZUbTZsc2lRdktBeTZVSFo0?=
 =?utf-8?B?dVh4MDg3SE42MHlBZS9SOWw1RmJFWnF5Q1ZQZ2V1bCtPL2RDUHFBMFMvb3Vo?=
 =?utf-8?B?S092VVRpZVRLVnh1Y1J3emJZNjY2aTc5c1BoTHFYMUJpK0tSZnZtK3R6dVBi?=
 =?utf-8?B?QXJkNUI0RldYZEpiZWIzK3NYa0FUNGlLeU5pVVdPaUJPcFhLd1hlRXR1bUtv?=
 =?utf-8?B?Q3pZaXE0eCtqTTE1THlMY3AxSlpNUHBCQ0d0L2VDNWNDT0RuWGFXVnAwWFR0?=
 =?utf-8?B?cWk1NnBlZkNpdkUvZFBZUHlZSlhSMGVPYlRZN3VnYXllMkg2SndiMXpwT25n?=
 =?utf-8?B?cm1YczhCZGNxUXA4Q09UZ3J6b0lmMmY4Q2ViK0l4WUJTcithbjNMbC9YekpX?=
 =?utf-8?B?a2kyMzFzdjRHMTBGdmxJbG1kL01IWCszR3NmR2paMHRqOWNtazJpOGZxeXJK?=
 =?utf-8?B?bjFNWHBYakFlTmE1MkxKTDN2ZFBZbUxSRE1VVEtvbDJtUnhyOE1BRVk1NElQ?=
 =?utf-8?B?M2pZZThHc1dmbURlbTB4Tzl2dGwvVVZZSDJsajZndGU2SE44WVR5cHFZNW5W?=
 =?utf-8?B?VEF1MUk3c05qS2U3ZmVhbWNoYXlYZnJUT2FwcFNybFliREtiaDdtSXR4ZFhY?=
 =?utf-8?B?cHd5b1UxQnNJamRYMkRkdUtRcTFVU3hoMHhnK29xYTMzQnN6VnBFczVONVQz?=
 =?utf-8?Q?NZfS3Lu55szwRKCmQGCtWyJiyx9GIBdYtRdNr?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0869594-40cf-4aee-d7c9-08df44b589ac
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:17:40.0296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gv2DhYy4+P7RZr5R/4VtUhH665819fx8+gLEPI2/p/tPriVztbNyAcZiicQa51cDsR8flmhMiBM/Ctai0xFBxehKHXU5w8Uh0TzyCwoWfRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9777

> Can dl_tasks_keep_without() miscompute new_cpus for descendant cpusets and
> let a deadline task move to another root domain without admission control?

Yes. Fixed in the planned next version: the new masks are computed from
the top down, as update_cpumasks_hier() does.

> Does passing tmp->new_cpus to dl_tasks_keep_without() clobber excpus before
> it is copied to cs->effective_xcpus?

Yes, and with no deadline task at all. update_cpumasks_hier() computes
effective_xcpus again right after, so the wrong value does not last.
Only update_sibling_cpumasks(), called in between, can see it. This is
from reading: no test case showed a lasting effect. Fixed in the
planned next version with a scratch mask of its own.

> Can setting adding here when is_partition_invalid(cs) is true call
> partition_xcpus_del() on an already-invalid partition?

Yes. Fixed in the planned next version.

> What happens when a write to cpuset.cpus (or cpuset.cpus.exclusive)
> invalidates a valid partition root?

Right, the task can then run in a root domain that did not admit it, as
upstream does. The planned next version does not refuse this write, for
two reasons.

The same move happens on paths that cannot fail:
 - CPU hotplug;
 - a child partition made invalid after its parent, in
   update_cpumasks_hier();
 - a write of "member" to cpuset.cpus.partition.
A check on this write alone would not give a rule that holds.

The write path also cannot tell early whether the partition becomes
invalid. validate_partition(), prstate_housekeeping_conflict() and
update_parent_effective_cpumask() find that out, and the last one
already changes the state. Refusing would mean splitting
partition_cpus_change() into a compute step and an apply step. That is
too much for a fix meant for stable.

The rebuild then counts the task where it runs. The cover letter of the
planned next version lists this under "Not changed".

For cpuset.cpus.exclusive: on a cpuset that is not a partition root,
the exclusive CPUs do not change effective_cpus. On a partition root,
the change goes through update_parent_effective_cpumask() or
remote_cpus_update(), which have the check.

> Should dl_task_keeps_root_domain() account for p->user_cpus_ptr the way
> __set_cpus_allowed_ptr() and dl_task_bw_reserve_cpu() do?

Yes. Fixed in the planned next version, for masks that grow too.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
