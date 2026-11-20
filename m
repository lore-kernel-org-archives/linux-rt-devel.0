Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182670;
	b=3ax+kvSvoHWAsboug966rqVLOas8ZNpp822WF6Qzh8JaMI/w4/tKZEiKH0isfiluEiOB
	 kU9x4jgM+RB2C5S8FeGwAfqEL32wzLAIlffVYhjlgs6PJWjn5wVUAIDtAbF4SL8WrNvFA
	 vIsM9CTXt0NUn8pBCw6b6sjlrl7SGITXf6YZbLm+A9BO4m3Tf5+FLMpZNHHFhfFmIsVc2
	 XhLlWARDxcIl6yj7+rlnEvb2TM+Eh9pfr/11vgZZySM69Bp4J3y0zpcpfwM2fyq+s475G
	 6roiw2eNa+dp7ZXV2WZl8ZrzdT6E08jdgj1IYScdPHPFWswehGfAOW4qtofX1ezInLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182670;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=XUkKOajwat5sqIeSvNL4vQbPXALl0FatN0Get3RPvTA=;
	b=fLbm6YEwcaeeYhjnjBhLqq0zcOy8p6BVirtqkG1psdu0yPygDRVXZn/IjZrOahKBk08V
	 99R/fpU12lQg2yazl6LycovaSimHP3KsshneNiwLU5zHjuO+ARoKbQLFvzmsqcYkyPFi1
	 VzKDX7emXP12mlKvz5de2P4dtTphvbaB4ZXadsG+doDZlkwBF0mAiY1ck4d4Lm2V54eg0
	 bIo5zR7uSLlYnPQmCArZ8sEgE6j9xMaqmRfL8CrUxkEAS1hSVVOknAkMJzBQ+zKnbAJoR
	 nkS/6CVFgqJCEvqP2KbjNmp9cYQglJsk+5swSoHNE14uyb52qq4LZnOgPFiGx3GJsIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=rq2c1fRz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.138
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020138.outbound.protection.outlook.com [52.101.189.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A8606A320;
	Fri, 20 Nov 2026 13:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 532A8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=rq2c1fRz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzNDvB/DOfwaekYCaHR+2RDhpPCISStBc6rMpwySeUUsvzpIOP9IhVsNT0WStM3X62St1OLEnxasmhzGBMzFs8aF6MAEAIZ2EvDk0yLN3FyFeiYGkbL19GRBBHiOtPZrNc7ZPXCr/mTMmYkRHSSXutmjXDL37H2gX3VVYFbnxXoettmWRPjHB6P8A6g9nhwV5vE5IvEipKM/53Umi+sJKeNS8z11WcIBdrKUH+8T6GVG0P3zP8CrMcHlB1Z8dxUPkBc+CGI4RZ5QJLuBYnb/I52yQvI6rgCZGGUlH0rpGMjJl9lkhiSH/zYR6/TE8zouBta/fBnlHwoerTxP6ZLz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUkKOajwat5sqIeSvNL4vQbPXALl0FatN0Get3RPvTA=;
 b=WcZKAY7FJ8k93apI6HklDaAi4re2EnU3t33lz/uIypjEbrnVfl5hkjLhQN1vkb8+Kn3hw7TYHdCr7kio5CHWKusOo8EZBpIQokjJofQKzpLuA7tRVmvFzQEPNWCPWtE2ytgFPoTurAFwjp43INcB8kCAP/y2Fd7htNGundeHO3dzU5QHMur/ljBHwO5ZjBiABStS9trgTYhPyA37m3EZ8S0kiTmp6iBvP+P+wsiwfMaUhO0d/fUiu4iSJdiXx6q4ebAwGRya8LMIHEoRJhMOCxBliMwo2TTX0HLhSL7wRk792UHCDYU51UvpZLmMzSsWGLVXrKdGJrvAucgK/6BZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUkKOajwat5sqIeSvNL4vQbPXALl0FatN0Get3RPvTA=;
 b=rq2c1fRzzU5VaswKCl9mXAlB2MycOFh0DJXbScDYWfYzba1NDCwVRqMQ8GCJeIWlCi53BYWYY+D401tRuESrODS6NOmEE8Bt2X0Pm8IQup+YUZ/0CS2fRhkLkk27SDb4Qw06UTDYhCCPbeBrffquJFxhsVQfZWs985aqiWeqKLaD5WG0dJRUGjP+PeOqX/bX59S5Pc+5cj5o/f3Mn+uVQvEMdw2N1wkUZKSL4m3jzr1Ceu0riHSfBlr45lJUZhJRHp9XW+/+jDct5axRGCYRyJeJiIskEG7P+pVEKRadmPDqMRU1CKyTV/dwyQ/4+/jVjTTH4wheXhT0+CDesKNgfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB165033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:200::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:51:09 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 13:51:09 +0000
Message-ID: <569b0c6c-8273-447e-b0df-2867eff701aa@efficios.com>
Date: Fri, 20 Nov 2026 08:51:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/33] sched/deadline: Keep the last CPU a task has in
 its root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <6e555ba3ad1013206d77ded129a127dadfd3b983.1795116791.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-224050@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-224050@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::12) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB165033:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a74063-e7a4-474c-2c3b-08df470d5494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|5023799004|4143699003|261009223027099003|261021121427099003|261022075727099003|261102123227099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VFfZ5iTASEew3lwJ66nS6HRQeFpNEnTWT1BN1m9qtiaNNisrgs9+5cI9DnJbt0RJjCXhstr3mH3OuH76DPVwUjXGUVGn61SMqTHkaoMaLJM+eotQGZeHdLDyRKmivwK4rCe4TiBi/0Arbz88j5qq/kvS/u2E8eWpp5AMTHh79RnOkP5ar803lIDEJbmsUkJ5s2ofB55tLdh+cpQXRVgYeOc05R1DBXJNz1gigH5HHy3vcWegsSyPYm9idw7Eubccv/WR3H0OamKCJmfLR0mBUczRyEF8wSKmxe45kZ20Cm0ZYQFEc14ymiFtrUN+lt/sUbZnLJAsDGs50385HcWbghOudwggobulEqNumU1MpKSY+BZIRUEWO9neVAErYpZmnPAx9xP1uCznZQIuNGn0qR6xhfD/Mh6PCB7b0RBt7rRDPa1kxc3fqmlCHzbYii26vRz136rwQIiqvOjw4xSsbIJ38NCTLPfYY24XnGZ5tgC9odf7UyG06fMPNr3Ftm3BKPNE13gK+6SizQ4a6O0Ip9TS2cTv+9kn7xwh0a/O3cvEwYBFEh5N97/eWyaHLidcrc0tzg4NKiiPI/FAwYdlMzqGCky41ZMuxBlwXBDw9to=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(5023799004)(4143699003)(261009223027099003)(261021121427099003)(261022075727099003)(261102123227099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhEUWlPclpZT25WV2tieHlFWDkyYWk4NURleXJhNVE5dEhWY3lPdTNMbHlC?=
 =?utf-8?B?cW9LbklIcjBTMnNWRlZ5QkhUWkcyU3pvaGovbzhNL0tvTUxJZC90S0NuNUd0?=
 =?utf-8?B?aEZyc1UxbE02N2g3UGYyYkFBMndzSjhFWXlZV1crL3pNTWhFSG1xT2hpY01C?=
 =?utf-8?B?TGVXL01hRlhZeG1Lc0JSUStJcS9UZE5MckZLSWtGZDR4aEczOVVTbnErczhn?=
 =?utf-8?B?S0F1a2dsaHc4Zjd5Z3IxRUJwdjVRY0lCMkFqT1hKdjBMVHVQTVJYS2x6Rk5a?=
 =?utf-8?B?NWxubEV5S3dxZnIvSjErODU1akg5MEVkUVdqMmNFdDQwNkZ5T09FNTNhdFFV?=
 =?utf-8?B?aGovZ3diQldYT2JReUlqanFaYWt1YnJsVEJTaC9mVEZPQjNoVWFOaEp6eEhB?=
 =?utf-8?B?dnpMcFpQRCt0QnV6bUV5Z1JzZStzYWptakdFaXIrbzIrVDNmQ2lObmlPajhS?=
 =?utf-8?B?NDB0ZEF4WDlaOXpaSmpYZEtjQWFUM1YreE1TQ3JkWnpnUWxHVWFXNmJmRURE?=
 =?utf-8?B?YW1nRUZtbUViSWkxNm1senlCTWcybEJtMFVtbHMwb1JqTkthL0E4am9Da0Fj?=
 =?utf-8?B?YW5GMmZKTEZQWUw2OE5aT2d4R1J5RW91aGhWalJtV2lHRTBOUGUyR0dNTUpE?=
 =?utf-8?B?UjFOVzNtMWF5b0RIR2xEenV1MEtXYXVoYkJ4dnhLZS9XdFMrVmh4cEhjQXJ4?=
 =?utf-8?B?azJ0NFFhUlNPY3dOVVBCeEw1MVFWaEtHUDBQZFR6dGtweGhRT3phWW1iNWhU?=
 =?utf-8?B?K1lzeVpadEx5Qzg0aWZJb0NsT1pyTGR6WmFlOXJVMWtsWndtQ1FreFpWbDNE?=
 =?utf-8?B?eTF0QlZLejRyVmk5VUZ6MU5PcHQxZmZhcGg2MCtJMUtEU3hzZ3Z6MWg2TCt6?=
 =?utf-8?B?YUx2MkE4UE01dThZdDBYemtFK1hjek1pbzBPS1ZRLy8yYldEZDhmYk1VTjhR?=
 =?utf-8?B?b1R6SXdYS1R6dkMzcGl1cXNrOGp3T1E2NXBRcjE2VGJHTEFqU3NPVHBJMUtQ?=
 =?utf-8?B?bzVWSWwreGFsZksvSzdJVldjOHYxUDZkYzI1aXJidkVWdmcxUUhqaWFJMDh6?=
 =?utf-8?B?RjZpMENRblpRelNhd3gvbnoram9xUmRRZmpXUG9xdEdCQmFJUzhHQlJOb0dU?=
 =?utf-8?B?dStVMW4rbFVZQVpTREg0MUhTMmFYSHlxc1dqTUl3dzV2Z01aYUlRVVFlelRh?=
 =?utf-8?B?SXRTdG9iL2x2bnpXeEpURUhlSFluUE1yUXQ3UGhWd1RiSnVXckNidmJndmU0?=
 =?utf-8?B?VmVOMVQwZ0VlQnlLeVhRVGlqNXJLYnl5S3RiWGlIWE52clhSTXJxQ1czK0lK?=
 =?utf-8?B?a045aTlHUEwvY2plNVJkOGFSNE1KWk1xYk94aDRLUUh4d0pmdUhhclpXa2o2?=
 =?utf-8?B?WFh3cEZ4dkQ1djZqY2kxbUxHSm9jYkpRbE9RM3lPMm9vcWhxSWRTQ1FtNTRU?=
 =?utf-8?B?b1hQUFBWVFp1dlpZSzE2d2U0Z2M2cUdEL1l6clFKWGxmTCtoczRuaEtKZU9a?=
 =?utf-8?B?TlRZVVFadUhXSkpoUU1jZGhZcG5zTi90Mld6K1hZZTRDYWdQQXdhY01ieGlJ?=
 =?utf-8?B?aGc0M0s4NmRTZkpzSmNDd3VWZldNNEhNRzlkQnR1OTBaUlNnTGw1SWQzc1V1?=
 =?utf-8?B?Y2NGMmdZdnloVGxubnJhQzRrenpTV0wzUmZhdDI0NW1CSzhUUW5LSzE4RGNL?=
 =?utf-8?B?K1J5bVVydnhQNUU1amdld3VsaXNIUHlIZ1AzK1dnYmtTekNMVmtEWnRZMU1S?=
 =?utf-8?B?R0ROU2JSNUQyanZNcTB6Q2tIdnQyczFsZnhRNFN6elNvczZTNThhcFEvdGUz?=
 =?utf-8?B?UmRsQkcwTENyQlFXS2hIelJuZkJWR3pCZjV3dVhXNjcwT3J2cnV5VUFXTEV6?=
 =?utf-8?B?NkE3SUh1eU0vNkFOclRvOXY0NmdUNUpnMWxKYlE1NXM1VXNaVmVZdWphekFv?=
 =?utf-8?B?ajcwWnVWR1FPQ3BGOWg2WUJMSkQxa1hOR0ZmVThvdFVPMUJweUhsN3hsc1p1?=
 =?utf-8?B?c1pyV1hPVjZRa3lMampaY01OTExSVk5hV2pVZ3YvZ1VEOUNOUjZmTTZtL2ov?=
 =?utf-8?B?K3VrNjg0RUZ0WDl5dzErNy9IN01aVTNIOHJNQ2FZb1FjMU9GeE5STVJRYitY?=
 =?utf-8?B?M1BwdGthVjVGM0RObzhnSnJ5SjNqUTBNNGlIbHpnSklqQnlzbloyMk5qelUz?=
 =?utf-8?B?anNVMTBwbUFkd1hQbk11cGsxenJTZE1jOVpXdHJxSDRhaFIzV1FGTENicTJJ?=
 =?utf-8?B?YW8vbXVYYlU1UDhjNUhTemdLdTJ5MHdJRGlvVS8yUWtsSjB0c0ZhK1BlblhW?=
 =?utf-8?B?WG13UGxXVHBLcEJlc3V5djdueXJ3RExZQlR1ZWNJT1B5UGhLU0M4OU8zbWI1?=
 =?utf-8?Q?UEXZl9W4962wV6aUgtBRf3MsQp+gzuNW1/aiX?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a74063-e7a4-474c-2c3b-08df470d5494
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:51:08.9790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9zqK8Uf4AT8Ze6wV+bJXxmlrkC4q2KwH68ieDNEzAReRd5aN4y1CNApdaJD0Mm1UP0K/79wtjNIHDZrQgcCPwi+J9wzzdcheUjQ+F4Zz6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB165033

> Does cpuset_cpus_allowed_without() leave pmask empty when from reaches
> top_cpuset and @cpu was the last active CPU in top_cpuset.effective_cpus?

Yes, by reading. It needs isolcpus=domain, with every housekeeping CPU
in a partition. When the top cpuset loses its last CPU, v9 will check
every cpuset, the top one included. v9 will not have a test of this case
yet.

> Can this loop walk past an unpopulated valid parent partition root that
> stays valid with an empty effective_cpus mask during hotplug?

Maybe. I have not traced it in full. partition_child_lost() does return
NULL at p_outer, and the walk then goes up to the top cpuset. I have not
checked how compute_effective_cpumask() treats p_outer. v9 will not
change this path. I will look at it in a follow-up, with a test.

> Can an offline that invalidates an isolated partition (PRS_ISOLATED) still
> move a deadline task from def_root_domain to a housekeeping root domain
> without being refused?

Yes. HK_TYPE_DOMAIN_BOOT does not know the CPUs of an isolated
partition. v9 will record with each task whether def_root_domain counts
its bandwidth, in a new field, dl_bw_def. The rebuild will keep the
bandwidth on that side. It will look at the root domain of each CPU, not
at the boot mask.

Your first example will be a new case,
hotplug_isolated_partition_falls_back. It fails without the fix, in
guests booted with isolcpus=domain. With the fix, it passes. Your second
example loses the last CPU of the top cpuset: the fix for your first
point covers it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
