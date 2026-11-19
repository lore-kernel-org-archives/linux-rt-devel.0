Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795095618;
	b=X7+MvFtFqDmRi+Yk1DJYEwC4rYUaqIKh21UzMQCPk5HSyKjbkk1OlqGid9l5npUQU3tn
	 qfgN0m8TayG3BE8eMbfaeKqItx4yFT/N2WKgjlYuoEHeuqdv6rTTqzIbq6nDyXZ/NyZPY
	 8jvUnMhGvv4D3reSX+OXfyozGce2/WsDcaUDG1+Ty+I/qXR6am4f7JbhZ8xT+bEBKi3gR
	 x6dthBqls7m6p+9YowVsSWnmNWDvnWTdexv9avZSKmp24o+lW4REO4P2OjSWtyM4wxqJc
	 AHXNVJMy4X6YNW58pjzLaJ5XunvQ/MoUshcTY8gHvhLFy/3WzMaBgvV+uK3GmB3l2Hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095618;
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
	bh=YT5Wq7JseRTZGsCrPdxNGSCW9dIiruFuOip1R5x5y28=;
	b=bAgfkBVTOWhNjHKIM7qwCzyUpMUTVQ8RjeqfaoCD6hUo3+qcH8y7Cs9NG5Ozd81B+PDm
	 7F56JlGQoyM3cSh5/rtycFVDZ6vrJmycaiSXv+iPY9Fn/IAr9xN/M704tvGSjdlTEavdk
	 sBhIdgkW3joWuP0A6vEOKkh5jFV/4HEn1m71HGlKvsw7zOMxkHaAlTGbOvxByR+j5NEq5
	 MzVN9jtQmK/uJFOJLy2ZFYN6VLSokJdc4/aYYX1QWEEWJbs+SXu1ezCfaRdjUvt092JS2
	 w4nlAEHgT76eKk07edsS1VlIp87Rl0RhsXkcBh9RKK2Bea9/Az8lU6bTRqq7FaIyZ1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=GIuUHrmb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.136
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022136.outbound.protection.outlook.com [40.107.193.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCB606A325;
	Thu, 19 Nov 2026 13:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74FCB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=GIuUHrmb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUi6GEUy7NDk2q92FxwHtHK+JhTymsTxA2L6MmR3exQxA9U64KT6leb16Nw6BROlShJbtTicp6OudZ9mdKa4xD0fG+XSYseWfhc/CvCXgWt+hdfKMFmlfqDrslYWGxWymj/tMlCesDh9w1YvO203EsecI6USzmc5KthX/PyhuygGnxopymzVUaY7NG+KmDKKI5ix68AQ4b/LIRC5g3Hw7XMxg6ZvLljQmGaphjhO+XxW+hZU7rhBjJilybUAbPRdaM3u5cKyUIpCBYa3qNuxYjLRAaxzWJWlkyBqCuWalJS5+d8Xw0LBuKGxyNhfSTJY7MLV/m2A/IVmVC01VoSUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT5Wq7JseRTZGsCrPdxNGSCW9dIiruFuOip1R5x5y28=;
 b=mj3vMlLjZqePt6PUaDv6c8HyW3JMbR8AQu43x6HsJQafbXGATtiSuWjE+sVYHHXdaaGAKoH3PPluXpgEpZ46nMXATovHv43+L3VN9q25cppoU885Hx9d5jkWJszlrvR8DDqxHj0ccBim8jJx+CAEiq0YJCjsurJwaYbp6rf86jQlMN7hMYDZLRQuMUbJbrLFL2T3WQ7ydUl6/Y+3aVV0n58iBHMaEhSUTuMwDudCeR35HPv/eDxeWcHgJJ2zF5/nQ/YqAhQsvJ8gSnPzIXtiopaMwHgR6oYz4/mDbtP2kPqE2BydUyv7NQUFUSGN5UvoSy7ipFj5Z7NIqA+cv05TWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YT5Wq7JseRTZGsCrPdxNGSCW9dIiruFuOip1R5x5y28=;
 b=GIuUHrmbq4N6phWoC8OU/R+ue0TKG/gLxEMeYMTMLQ38WJBXsuhGMhCNkOBbvABlSXrRBoYHGMnCMZw+cS+3+xSb80gEtQEMyUkcxxKgIBoJ6twwtx4KLQNI7yw1FKwncqGp6dqU5RQxvZ1e5nnN9agfrh0yCKrQUM+qONTHbC7qh4eoyZx7A+YSK81S9GmoUJDBwW4Y2NFNyLSUE8kAOJP+aNQBm8lRQSksB5QRD+VGkvoC4HDLYVji42GWAHkbMVT8h02CoykYTMELbXx7yk6RFrc0gMYRaldH3RnEvJzfT15IMiOlC45CMHErxQcV3AP7DSOczjQugmXFfusrqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB5329.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:61::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 13:40:16 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 13:40:16 +0000
Message-ID: <7e3f00be-2849-42af-913b-8111be744ec6@efficios.com>
Date: Thu, 19 Nov 2026 08:40:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795037078.git.mathieu.desnoyers@efficios.com>
 <a94584f87598e48fece3c4eb9ec5f65e2a442abb.1795037078.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-222083@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-222083@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::30) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6ebbb4-d5c5-4231-7193-08df4642a539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8B/fPHCX4nmiI3aZaq/xwLH9WjjgJng44ksEbxVrRjs2Vvx39/aqlpgVZZcXlcghUeyO7c3nN/68ou8Z+yJMYizrHUGKeOGIgdiwu78/iXjHy55Vbz0rIukmmrEIN/330NT1xRyfpyafacWLIz2x7PbPmridjctB/vLCvh0zzBOZFmxMErgreQfrLbyYw4OcM/ziCNBuf73TYZVlNytrrfxZrdZn4bz/lGy2Uv9i20jEby0Qsh0Z1G66hzSIk5O1K2Bw9gm3egKWcv/YMN2WlE41Qwt2g5fPSXTavb8UrbqQ9xUeSXR6s2D56n/BNSidyfS6ycH0mZFrvRTXQFmNR2VqqxSQ1SpsyEar7Nxhzf8scw6YvOBZGcN/8OvPIyyaC8eCJeGAd8A8jYwdK23cf4bq+u/IAq+HHgu29MKEltdPYBtavojM3K2tGsZKfmExY8RboxYMicm7/ggAftAQfP/vDfFUt9UYIWS/mYn7PVLczOcEOlpG9PFGY4KfyMaD6Mi+PPY/HAH/5QNkudHCjT2Wzq6nkaoG6JIk4vQEYI6LopCQleJCRgyfpUTaOOfo2oxkd4ita8Y44khkuqzszrIY7URA4LBQ6GmRER72YVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NC9SRjNCSCtseXQwYXVnZU5VcVpHeW4vWUVOQTZnTnFSOXVKTXB0LzZ2YUg1?=
 =?utf-8?B?RW0yTnBzTWdmT29pMS9qZDYyRTliZzZXK05oTzFMWG1GY2tCQXpzYnRqQkhM?=
 =?utf-8?B?eW9LRldiK0Y3cTBjUG5PN2FBdkNxazMvWFpGMFZSSTVySDNaTWFMdVpraTl6?=
 =?utf-8?B?OUdZUlpOQ0dDRG01aGpFclNLQ2l5VFRkd1ZWclRXejFYMTVGS2xtYjYwekpK?=
 =?utf-8?B?eUtRNnJLVXNoWXRHeGJMd1BLdWZhbUhlN2I2QTAwRmxPb2ZXaWlRS2VhbFFu?=
 =?utf-8?B?WnFndVA5NU1aeCtkeE42RHdKMFhJQTU2bUtJNExmK0psc2MwK0VwUUN3R3BD?=
 =?utf-8?B?RGVBd1A5MVgwL3llVTZOVUxFNGhZRTIvNkNnbkRDWlhYSEhxTDVXdDFteTdj?=
 =?utf-8?B?bGlWVlBpa3pUTnZtOHRhLzY1T3pwUjFGZ1lZVEpVVm9xTWNGWXJGT3lSRFVw?=
 =?utf-8?B?cXdySTBTdU84K3k3S3A2L1NneGxxZExpK3FSSzRsTmpZZTZVUjRWVUptVFBQ?=
 =?utf-8?B?bkR0YVhObDdOMDdLRG8rbXBHTzZPUm1lVnQzZUlIcjhjQ2tmR01BcGVNdjBW?=
 =?utf-8?B?NSszSWR5Sm55eFZhOTRoV0IyVGl2dFdmZUNBOUxYZm5Fa0RBYXp2dERnKzVU?=
 =?utf-8?B?a3RoNDkyaStscm1mYWo1UlhqTE9NZEVwS2d6L050NSsvRkVOT0cyRXVzRi9N?=
 =?utf-8?B?bVVYalYvSE5ySTV0S0xwR1E2bTkyb3RxdGFUa0VHYk5JRXU1aWdUZkZucm5Q?=
 =?utf-8?B?UGdSaWtWWHEvTStpa2lES2ZoLzBpMFZvMFZ2TzBXZmNBSlh0Sis2Smg3RWxB?=
 =?utf-8?B?K05ZV3FpWVhrZllXNWtROXJQTmF0Ym1kREdnd2orNVlRYlptWHBmRVFUUTNU?=
 =?utf-8?B?clVYT0VBeFRkZlpRK3Fhc25laFB2TklPblZocUhIZE83RnQ3dG9YaWM3UW91?=
 =?utf-8?B?R29QMllZVm5uWHFGMVJzUE5rM2JWQXNDNTVDUzk4TWROVzFkY0IyUWlzVjFi?=
 =?utf-8?B?emgycGN6TGpxaWZoMDdhS3pmd0o1Rk55bDVhbk0xRTBvaElyRko3dFhaM08x?=
 =?utf-8?B?V2NYb0NVZktZQUVUYWlBRWxSWEVlRGRJKzB4NkFXMGZMdkpNYTRBa3pRWU01?=
 =?utf-8?B?V2c1elFjcTdSUldGVnEwOUFnRk9EYnhKWWpZNDVWL0ZPUVVyZ0xZem9nZExl?=
 =?utf-8?B?OEZReHUyaUJrcFhYMloxNEZjVzN3MHVSTER0NmpLQVJ6d0tYcHMrZUVJeHBB?=
 =?utf-8?B?VU1LY1BqQ29XK2JDNWZHTmovZndnOWMzc3g5MGRjZkhLSm95Smh0UHVTYWlv?=
 =?utf-8?B?ZERLdHVJaEMrSVVaU2c4M3REeDFRY3gxTmo3OHJaL3YxV1pVSEtkKzZpYk1M?=
 =?utf-8?B?T1BwSEViOEw0L2xRSWZNZGNNbTVvYXNNRmU1S0lqZTlqcEhZaVJnMnVzNzhV?=
 =?utf-8?B?U25WdWM0VFVWanhDeWZiUlJRdzZzSUdPZ0ZXdEduZ2pjazVqWjNIVTJLUGF1?=
 =?utf-8?B?d2owTDlEeWI2RVo1dUF1WXYwQmhMd3F0KzhxbTRNZG1PNllvTk5qYm1RR0pw?=
 =?utf-8?B?b1JTbFc3bStFbm81czV2VHBkaHp2UkUzZjR4RzM3UFgxc1ZYQkRRWmZMdUVp?=
 =?utf-8?B?N1phL1JNallZR0hiZ3RROUYxNWdkSENQaEJJZG1VSkQ4eEFUcEpvYUJqV0Z2?=
 =?utf-8?B?eFpoTDRGbFBZemU3a3NMYThnbWZHVlJVOGpqZWZjWjhyUFpqRkdlN2xYRVl5?=
 =?utf-8?B?ajd3c3VOdVozS0JuTW0yelR5VTdKSHVCR29wUGYvK1N1cFFXZWl4VkJPRGw5?=
 =?utf-8?B?bzJYZW1pcHVCZlhOeUV3QnRoUFlLdVJ4M1MrRVZkblhabFdsS0NkTC8vSURa?=
 =?utf-8?B?aDNrei9GV2dQWVlFcE5qcVFEZHNxeDlUcDhpY2ZBVFczaUYwazBtRlVlSCs3?=
 =?utf-8?B?THNhSnFTdUFOckN3cG1uMFFnNWJJaVhHKzBka0xJN3REQlMwdmZVdG1MdVpp?=
 =?utf-8?B?c1BjM3AwYmdNMW1oOThoeGprMjdyWjhWMVhTbng5U3RlNWsrWUU0bHZ3dDBX?=
 =?utf-8?B?QnRRYVJORDVwU05mckplWHpxQ3FXaG9oWnJOU1FLcDIraVBJa1VmOWU4a1BK?=
 =?utf-8?B?UTNoQWxUSC9nWkJEZW1hY3JIVlZNSWl5THBSRWZEQTA5cnpFbnJmdzVMRWl6?=
 =?utf-8?B?MVRQRzZZM3lOZ2NnU1pPQ25BSWdBK3hRSldyY3JxTVdrVXFxM28wcnRtVHo1?=
 =?utf-8?B?UHRmZ0JlZmJxYm05OG1CVmQ0d1QxSmNLaWpVbUd3R0xqUHRNeUhPTC9SNUlG?=
 =?utf-8?B?QitpNUN0MmxPWTlmQWIrWXJTdU9hTE5sSnNMWlR2ME9zSU0zUGp5azljTmhu?=
 =?utf-8?Q?o4qzfgnpBDtHY5gtD73ERsHVpxiog+V20ln1e?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6ebbb4-d5c5-4231-7193-08df4642a539
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:40:16.4444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD7MiXH+kY0GnTjdH9yZYNbvI6OcBHSpVzhpJNqiQHGrAWDeBBs4qD0c7no/745FsTi6LvY2N/DpGpPynLVRwVQ5nyKOcfC/YWRK94J6YFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5329

> Does calling set_deadline() on rb_waiter_tid while W is already blocked on
> pi_lock give W an absolute deadline of 0 instead of a deadline later than O
> and D?

Yes. I checked it in a guest. On this series, a task made
SCHED_DEADLINE while it waits on a PI mutex keeps a deadline of 0. So W
boosts O at once, and the case passes without the deboost it was
written for. On v7, the case failed without "sched/deadline: Check the
runtime of a task whose parameters change". v7 also had "sched/deadline:
Start a period for a task that enters the class blocked", which gives W
a new period. Both are in the second series. I will move the case
there.

> This isn't a bug, but fair_tid is only written here and never read (which
> triggers -Wunused-but-set-variable under Clang).

Same as v1 [1]: these are left from the split, and the second series
uses them.

> Does pi_chain_donor_leaves() pass on this series without an rt_mutex chain
> walk change to propagate M->dl.pi_se to O when M's sort keys do not move?

Same as v1: it passes in every run, in 25 guests with this series.

> Since death_pi_waiter, death_pi_owner, and death_pi_deadline_owner each run
> in a separate child process forked by run_in(), doesn't the process-private
> static ready variable start at 0 in every child?

Right. My v2 fix does not work. I will keep the flag in the shared
mapping, next to the lock.

> On a CONFIG_RT_GROUP_SCHED=y system where the cpu controller is already
> enabled in root/cgroup.subtree_control, won't server_client(1) fail
> sched_setscheduler(0, SCHED_FIFO, &sp) in cg_p with EPERM and cause
> server_states() to time out and fail instead of skipping?

Right. Our guests with CONFIG_RT_GROUP_SCHED did not have the cpu
controller on. I will make the case skip there.

[1] https://lore.kernel.org/all/eb414b6f-ea8f-4dd5-94ca-0915490ff37b@efficios.com/

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
