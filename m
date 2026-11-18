Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795036350;
	b=bHhLWo6o8pvsYVNN04T7f6WdLQzZngyTZHOlMuEq9OGfy1n0DCpw9lHy1U+PEKSGNqwX
	 Ri25ZJqmvPSvzJaVZdhp2yKS/kx8fDl6Vt+ov/EjjyL2dz+bSI7G5E0qdvQxM3dwZK6IX
	 IGxoOMWbaE2aG9i4F4HESpsksHkDWNe1GYqfDc73Xp1EqImsPUmg9Ptq53AtwEwWV5ZCh
	 rTXsA85j2GAibrvTajaTI6L9DoDPIIvbvA/lRtv5larsldSd8rq8WdJYyuj+O+QFA/kCW
	 qzeuWTxChYL70zqsZ/3yw0f+74EJdnD65lOlTLKPzX+urFs7c6DH63Cq3ls8ZuEGW1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036350;
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
	bh=KDMbhx6hGhGJx9MQCzuhBDYg+LqMnV3yxux4XrkPzz8=;
	b=2gSp/6Fg3NrmNAX+TFEpt3XNgacdol+CLA9WIRnGBS7QwgDICMKRlF/Fb7GSi6FQkqP5
	 UwGqp7AKEHo709vOypxN8PvYUB0QpyOVE4FWGqN7nDAwTQNNydMRXrkd0NCbTW7d8npmB
	 /TA2t5GVMwCkpK/KIyyl8wbIsR2y/rW+mvhT52F4ILT7n0f2Gzs/bnTAGm6eDqsDnQ1Q/
	 VXjNS/+IUXjzkA54IJhwoxXJxcjdo5sc8TH4EFkBWHgBJf73RjsgctPss29a2KzkMizCy
	 l62p6XW4vetvM0ALTUiQ/t4H48/H4pyPBh1p7fbVlT99qI/PJaHQjd2Bw6kmAUKwjdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=dXPm9qqL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.74
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022074.outbound.protection.outlook.com [40.107.193.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959360A2608;
	Wed, 18 Nov 2026 21:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2959360A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=dXPm9qqL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTdDmD2Pc1vE2YkZaijQZ9LzCSyLvOJCaXFtKicz/FFZbea9HWA3g8TSZNx4Fh1CaA7Iyb7JzAKRDcB3Yz0UtWHNqP4efLsVDw91ERUA0PdSQUBm0Eihp/BnyUsc2emmqDTZc9chin0BK/Fxaag7nstgMSjuDHm1bV8x0vzLLV0RrI8gBOKjsrt/bzktuHaPM0CyeDPp7ouIVkyQ1/r73WIwBm6+53QoD6YV406x1eSqZuVW7jbqTnCos0v0R1648wdOPHUsTWd2mSU6DOVlU9bB9+rGVaBUTz63+xjqvPLTPT4gS7cVSna7+NzyemVJCo+KiZOT2tGdID+GjZkhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDMbhx6hGhGJx9MQCzuhBDYg+LqMnV3yxux4XrkPzz8=;
 b=lGO2LWg1reUCQvHfBGwqHP3+/MaIAKv3dH7Poiz2HlRrYUZsaOdvaNJ55kfe1gnlik+vR5Ttg4EhH6dGjnbenMnPbbEEdFWLLqC2PZSlLMcHVl1BRlCIIK/sQuCh9FuRY4oAlZwGgB05+hr5n+u/GyqtX3xt41D/RUexlMI+NKlNfBTuHtaNgPKU569RY2gCbVv93iFWFkxu8gYCXh7/xKx2GJ9RIPGhCjk5BThKKhW5poyzBZGicbcooSKNIK5wD/47yf9qtvPPkRVJNinn/Kw9HOPc3VuzI23dMGauByQD7PldAmQ+bmqdItAA+/hvJ7wfkgXb4tS707gdviJ7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDMbhx6hGhGJx9MQCzuhBDYg+LqMnV3yxux4XrkPzz8=;
 b=dXPm9qqLPKM2VtDK4l3r7GUZoNjRexhj3DQzPUNpo+uiTkuvCOKZe3u8K6Tz3HD+5OPcVGdkGQayVEpUVyRRfoUofkMHg7BmwlDxsWZ9NqHSKPZs+WwzPAc3+OTHWu9PGBac6OAgFf2Voewn1CQOZH0hFHAtoBn9n3JwG4LinNOJfoiXvcWXzcx9G6KSxDebL/R+sH1jGV9877PCKR0Ru2kYzDYXP8PfnbDe5FgKQIfpddmSY0UJgYM53vm8HchxYyEz0g4mrYcGn1a4uf2YLVxAADxtYr7ozkHtIQFeK9FN0HBC6FXiGMO2LC1EcZl9IjIggMGjYzh92+sVHGqeGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB572210.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 21:12:25 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 21:12:25 +0000
Message-ID: <eb414b6f-ea8f-4dd5-94ca-0915490ff37b@efficios.com>
Date: Wed, 18 Nov 2026 16:12:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <92d746027d4034afb4e9c55bd1b686312a2401ab.1795031605.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-221967@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-221967@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0340.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB572210:EE_
X-MS-Office365-Filtering-Correlation-Id: 069e1f4a-a68b-4438-e63b-08df45b8a4fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|3023799007|56012099006|4143699003|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	MZAkrqwdPgSXkMvVKSU9KOn8s2ov+aiyQ4o36w/SaBGiRZT6jQ9G7R5cOWn7y+V+v131Wjfkpp0nRLcC5A7dEtY74r9P8rD12oSgv+ep5jGfMCVhEO9Ph+VHRtbdKCoC9SK8AvZfRK4LD3VkKGFGiHRN6U4msOldicNC7rG0JGfr6yj4c79OFZfeZ3FwFNmMy5hdLvf8G5FghKFImR+ts13oIcL6bIsFd3boc7IWVkvUxvJ9x7RfM3y15gkLSRzS9GLPNj1xydiTyPNlKBF9IVtlTJCWrchRTExWsx0r1y03UWxc0ZV04mTa5dWCaHSgIILNdP1WLXJ4wDqVS1EHh9DztfmSBTiaDnnXnENN/G/rWz+hdAbpkUbsQ3wOzC3yuXx6XZgehX8tdrBmM5Qp/62YcJJWBDOkhQiV5I0+UOpOhvUnOKYhzA0jA60N81npLz/Z642o4Vxr7RQSD1HCDx/o3WbERC/y3OBeWwjAer3Yg9xy/ZJ5uUreQRprC6+GKgl0YXUYjWDjgpfYT3UzwvM6qakdHdn3gE+AWvOkJ3C/iHrXZ9Gee0Bzz/DvkOhefDsPveaKl/n2euqyWu90+/gPY1AJ7oP/cUjfvKVHXhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(3023799007)(56012099006)(4143699003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRaazFpV2lRUTgwMGRJam1EbDVkSFV0enZDei9NTkxqTHJoazlmSEJWb1dt?=
 =?utf-8?B?Um9IZldnak9YY0l2eWJ5TCs3RjdLRFZHWmh3NDBpK2VYejZzMTVhSmY0TGlo?=
 =?utf-8?B?aWIyU0JyWkEzSVk2bklwZmlIWVQrUmhsSXZVZXpIdUwzQWxTWGJuckJST2tj?=
 =?utf-8?B?MmJEaGNCYTJHU0hnTVlsSFlBZHpIMmxpVFhxcXlnM3ZBcXdUVUhFdEQrajl1?=
 =?utf-8?B?WERLK1dzZWpHRlczK2tDMEdlbFNPMXFkQ3hJZHJpZThjOE8xTVYxRUVLSjFU?=
 =?utf-8?B?bGFGYS9XdFlKUGxwUU9UNGoyS1NHSEROQVZ1amVXTHZaVDdSaFRKSHNhWEpl?=
 =?utf-8?B?UnFuQ0pPdE8vc1hjZ0pDMUdyeHFlbTNOeGIzSndQSDJoT2c2OHdHWkFtSFJH?=
 =?utf-8?B?UlBjRmFCdktSbFBVQW11NWdwdTBBTjJzeFdDNy81aDJGMGpQc01FNXM2Qmdk?=
 =?utf-8?B?TFlnelZJSFFyNWlnWi9rZ0JwaklTSzBSazNOYXpvL3didVlrcEJqV0hxM2xp?=
 =?utf-8?B?aUducFNObjBUWDlYZzY0Wjl4NENGV2RSdndabTRtSXV0RjBYSEh5VHZtY1dt?=
 =?utf-8?B?dG1VRFJyYitGNWFuYkxvRHd0bFdwdFV1YlpXUTY2WnJhcWx6NjRCZjBmMnZR?=
 =?utf-8?B?dVlRSUtmVUpORDZxS0J1SkRld1Y1T1RtNU1ndndtalp6c2RGNmo1ek5YOEIw?=
 =?utf-8?B?VW93SVV1MkRwME0xRnhkcFlXMGlKMVZmelkxT0JjcG9DYjZJVUxSbk83bHdM?=
 =?utf-8?B?UTY1bS9qK2NwbmtVTWdzWWdLd3hRYmJ1VUQyU1R3Sm94eVhEQVBZWWRxbTZz?=
 =?utf-8?B?VkQ5MGFTOEw1N2hiWER1RFRxZFRkSTVMeDh6NmwxR2YyaC92WGNYekVXZG1G?=
 =?utf-8?B?RUgxSnc3aGtzc2hNMEF4dVp0WGtKSWlmSlp2MjRCak96eFdYalNBcTdZVk9h?=
 =?utf-8?B?Vlp0dVA4Y1RTQ0c3ZHlPOVJnLzUxK29qb3pLd3BXQXpDQkE1RHVBWmZKRUtV?=
 =?utf-8?B?ZVJCUWhVb2lUS1BHNzY5bUdGSXloeVJkQUFTRVQ0NlpGVVY0UG12bkFLajN4?=
 =?utf-8?B?Q3U4N0p4L1BhYlIrR2lMY0hJRENJdDB3aU96Z0NWWVUzTmtnMUZCcVZIU2tE?=
 =?utf-8?B?QjFIRkNvQm5LeEo4bEtXTkZQMStFazVQT0lKcUZoeGxZUHlJV1AzTnFKaWhT?=
 =?utf-8?B?Sm5CbXBDSnJzam9tNUxoUXdGTVFkK280MFpNODh1TVFLQlRXVDlGQXJaSGpm?=
 =?utf-8?B?VTBuVGxoTzhkcmIzSHN3U0UwUEJxYnJpbTdWQVVibEZ3dXFCRHV3UDJ6NWNt?=
 =?utf-8?B?SDBXbklYTTVzSVFnbTlxdkNhaHZydzd2OTcraU5wMHhxTDArWmZlTDBPaVU1?=
 =?utf-8?B?bjZEVVMwRWFmeGNkTVdubTZXZ3ZuWmN5c1l2ejdoSzlsYUJEdFU1aEx6a05y?=
 =?utf-8?B?b3dzcVhFWjB6UGFsUVg4eGZoTUNjVm9zSHRaMkJyUHh1NkV2Sy9Za295Y2dv?=
 =?utf-8?B?K0U5V2FkRjd3bkVDNFp3d1A3Z2pCcEk5L3l0azFtV2lsT2V6a3VrWFRhcm0x?=
 =?utf-8?B?S0UwTm5IZ3FiYlNIY3puVi9YNWcyVG1qUTluLzF5U0RKTndiQzhmam93enRt?=
 =?utf-8?B?Z3ZYQ1hRQms0Mk9Eek96MmhjZjV5YVVIbkRwUEpSMHR1eERyUlVFWlNwTkxX?=
 =?utf-8?B?SVpDalBMN0g1OVAwdjl3RlMrUXYwN1lqaTBlbTIxK0NlZnUwUGNqVllLQXp3?=
 =?utf-8?B?RlVVQVlob0FqMVlaTTJ6aE5kVithbmY4QmlUbHU2YkliNk1NYnRFTXFGa0lN?=
 =?utf-8?B?RnV6Y1FFQU1YT1l5YUlNU3NkOThGN3Z1WmRlMHNKY0Y1UW1YZkpFZmx0TzZJ?=
 =?utf-8?B?YXNRQXhNdnlON1QwK0VPZGE4T0tmdGppMzJzcHN1R1hKTTdVVHlXZ0dhSjlh?=
 =?utf-8?B?YWFWRHY5RFV5NTFrK1BjTWlNMTVzZlUyVzVDUXFxbExVZzdjajFrbk9RQXkz?=
 =?utf-8?B?Mk1kaXhTdWlkQ0FoM2tnRDgydWJxZHBJTkwvNTB5WHhhN0lQbEFsRFdYdDBy?=
 =?utf-8?B?UVNnNEF2SE5Pcld6OERDYzVjSDNlUys4bGp1NTBsSVVWYUhiTXFwZWxUdnZq?=
 =?utf-8?B?SUdUNUgzUU1xWnQweVR4Z0J2ekh3SzdablV2OUlvdGd5Y2h2RDRVMkZPM0NC?=
 =?utf-8?B?L3EwT2UyZWVoWWtQbXAzWWFwRFVrai9HQTVFNFFaUWoxMHhQWVpZRGpFa0FJ?=
 =?utf-8?B?bjhUUmFOMktZREZkUk1ZejlvcVZQdkNLQTVseWJEV2Jsc1RLUkJaRTFNcGla?=
 =?utf-8?B?a0xwWnpOLzJmZW4yVEd3VG90M2RzWmVUYnJ2RlRtb2hPeWVlTEpMMGg5Tkpx?=
 =?utf-8?Q?dMoMpd8x5Q6rewS4XnOzTAhay1kheKXar0Qc8?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069e1f4a-a68b-4438-e63b-08df45b8a4fd
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 21:12:25.5087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXs9CUEFr+VJnA4rZYCD3Cnvhe2DbJ1yQvswU+2J7EgzixFyr4igk9ICRWdjggpFZ7gmZlUbsPh9Q/H52hmvZYXrR47y1jMUN8i42osDVdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB572210

> Does deboost_new_params_reboost() exercise reboosting after a deboost as
> its comment describes?

It reaches the check it was written for. It failed on v7, before the
split, with the bug that "sched/deadline: Check the runtime of a task
whose parameters change" fixes. I have not checked your
point on the deadline of 0 in the waiter node.

> fair_tid is set in pi_init_lock2() but never read, which triggers a
> -Wunused-but-set-variable warning under -Wall.

These come from splitting the test. They serve the cases that the second
series adds back. The test builds with no warning, as fair_tid is a
global.

> Does pi_chain_donor_leaves() fail because Z is never propagated past M to
> O as O's donor?

No. It passes in every run, in 25 guests with this series. The missed
propagation is what pi_chain_top_moves tests. That case comes with the
two rtmutex fixes, in the second series.

> What happens in move_cancelled() when deadline_bw_test is started from a
> non-root cgroup (such as a systemd session or service cgroup)?

Right. The case assumes the root cgroup, and it turns the cpu controller
off even if it was on before. I will fix both.

> In the same loop, late.done is a plain uint64_t written by late_setter()
> while move_cancelled() polls it in wait_for(5000, late.done), which is a
> data race.

Right. I will make it atomic, and join the thread after the reap.

> Does shm_lock_init() re-initialize shm_lock without destroying it across
> death_pi_waiter, death_pi_owner, and death_pi_deadline_owner?

Yes. I will destroy the mutex and its attributes.

> Can hotplug_server() pass when probe(NULL) fails and returns -1?

Yes. I will check the probes in the three cases.

> Should rebuild_record_taken() return KSFT_SKIP instead of KSFT_FAIL when
> total_bw_of(a) returns -1 because /sys/kernel/debug/sched/debug is not
> available?

Yes.

> Does rebuild_record_taken() fail when CPU 0 is isolated with
> isolcpus=domain,0,1?

Yes. With 7 CPUs and isolcpus=domain,0,1, it fails in 3 runs of 3:
the task wakes on CPU 0. With the second series, it passes in 3 of 3.
The case tests "sched/deadline: Make a rebuild count a task in the root
domain it runs in", of the second series. It belongs there. It passed
in our runs only because the guests with isolated CPUs had too few
CPUs to run it. I will move it to the second series.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
