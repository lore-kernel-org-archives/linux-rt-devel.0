Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203646;
	b=a60UtoF4Ad8cYDOI43QUBcFADTFEo1Psnzv/TG05aJjIfOePExTYMyenDasi03BpgRYj
	 OQ7fQWDJsBwKcIm8fKtUzQxShZkCcRj9ivDYiin6V84zTsRHye3VG4Z25L+V7EtKJADEb
	 ick7dkw63bLxiGfI/xbhPoCpN+HQr/7+i/bUFZ4D9rQ35BmezaSAqr7Igb7Mg51Ssj3+T
	 sJdZUpauzqlknTBqWqYVjg6pSPwfyyyRBoJJTlsK6M3LoEcvQobcgGFhHa8Q7meagQQBq
	 hMKZzb5gjTjPtZTwVI7gxgkXXhkBg63s9kdqise/V02nrpG15ZYGHyArzrLiAtvGXdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203646;
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
	bh=xXbD4/b2DBlcg+AkUTV7ZAfGEKJ79cUJ94rcXZD9bUE=;
	b=xCn87VeEqI8jZVOaM1Gs2e6JXoTFQeMzHPg4S+nisBXnDX+2nqgt/HJzhMdEPpTQCitf
	 ZNCuW00UtDvO754e3AVxqNPbHtkM3sRo0pTByV1+NrqiMFba7xqGpnsv4W3+4WU/VQrTU
	 xc5ogzTBiE6uz2yPL2o2HyQum5A1/b3kogkQLsJS8TeofDrdLszWwxY8XKroKOtuHgFd1
	 MXm8aiwTU1ffpRrYl0Q29wqlqmby6A75uYi4vD374lGdUOgECtOoSJ3MwgveK8fBMyQzC
	 xTNE2AIiJlW96Jr6v28ccroFh/0O8yVS6ND/PXUH7azIbSQtP37wHHV1aoadW1AlZSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="A6Rtd48/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.77
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022077.outbound.protection.outlook.com [40.107.193.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB6606A6FA;
	Fri, 20 Nov 2026 19:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7EB6606A6FA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=A6Rtd48/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbPLkgsx/KwC2EntEecUY+7aNm20rJXYStJ6QBDLJCEowQUMzHCnbk5JlU3uUldYJ5tpG7kU6SzPsxzm9uQEhmcyL3xWEHxb+/OjGAe32v++xIYCirwwXKwU4178AdnA0Lwj5I9lqDt2uBs/LB53uz3yRNfShofjiA9dfGOV+1ms14Kc7GAYTgZ9ulsVn6Bfw6yFkUJrsgi/zYhFgvI8ooGs4ZfLcZcQId4Lpl6aC5zJtVeFg6duDgRrJOr2SLR3UzNq7kYk0qHvqYju999FHAb0vezw518HnpbiiG3jLvh3HAiP6/+hFFKhwwslX8uuF5FRGgxm9gdAWCc3aSg/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXbD4/b2DBlcg+AkUTV7ZAfGEKJ79cUJ94rcXZD9bUE=;
 b=Ld37Np+wDPLGz+AGebD2V3DT/4qy6sOiUfQRGQzjBvIEckGnn0tWWW1m25pMdPyexaJf0II7HjKCDDfU18O1iIRgXl9NiL44a82ilmrPpCuBRaOaJ4lKyrTHNfcgRTNIS5rD9t5K2YPR0dhlZWBab4JmvrTqvX2tbd/xjj0qULydqnS6MJr76GsfwnmVDbxSkvmniuMe9bA8YrEmwTVFnulHwa+y2AN9ctWwTJM9AlgymnixYiSLRAy0873/SebP5FS5TlJ0uCion6qTu2S3L44cyhRefc42qBb2+ArVqjP5yQff9nXKGIAZFkl0cvtpsMvbB8SNHLMAwF7HYAW7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXbD4/b2DBlcg+AkUTV7ZAfGEKJ79cUJ94rcXZD9bUE=;
 b=A6Rtd48/rCySu0+lmjhdKbZq7VPebkvlBi8FiVWBYEO09td9wuyECxCB8C8t6/IVoXa55/tkmDdtY8AQjxdAUZloK66we+cxlNJMabuak2q5IDh7+ns1HuuBezBNYoA16HpyB1iLLfmUPIjdMQ8qbAnXeGqJaDXrYEXuUdyEhIMFbPlO9xpHOHOLQwn2u4wG37XbJHNfY9sMbOKtWbYInyPAEIX1M1IPZZTlIVm7rPEDmfY+0LfFYcP3FqSFX351d2v90LBzGfLXr8se0swQ0G3ULEaSRUjzW5vbrzAC+GwnpCBQN7NBjzbAp+U6Bu+11eJgPjPYAE63SsBKpzrY2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT8PR01MB067206.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:40:41 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:40:41 +0000
Message-ID: <3b1ec788-b91b-4acd-975d-424c2bbdf3f2@efficios.com>
Date: Fri, 20 Nov 2026 14:40:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 26/33] sched/deadline: Start a period for a task that
 enters the class blocked
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <8c4afb25de793f30e480c975d5c4f94d27e51c02.1795181240.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-225397@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-225397@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT8PR01MB067206:EE_
X-MS-Office365-Filtering-Correlation-Id: cc89d6c5-c5e2-4410-8d08-08df473e2952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|3023799007|4143699003|56012099006|261028144727099003|261026121527099003|10067099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	KCof/QroJSTeM04KRO58LB7K03UYOtA1Kw9haOdjhBiuTVZL7K8213stlZwBsrsoBKwiCQu+hPMDNZ8SjaHiGVh9nevSkEoy3/R5E6EYxZORvwZveZkpUTRfkgAufsTKOmH+cMXF+qGljDN1+GkV5PXHSXhXgQxSJl7Fjd+G3XPyQ200twUeq07rczdbhFT4QTG+Z8B/UTBQIiFYFae4GIUEXOqhwU3GMa2sejw8iJz79amxUUsuAozuYTLRNfG5aQr5xBsCJ71RAtLzCIf/e9T6bIYMH1uqoDbuqrR1HrgFGHwUkMP/Yb90s5vB4MI3kGtnKO5YZTueEso3w0K2h3ixOJh/ghDtH2GbEjgmVUGIfFBVw1lDj1GpwI5XcN6FFaSdLtzXTbdeWQjIpOW8fa3yScS3RIGkV18q8IRI/IyWSPfD7wh4FIqBn5PSJglrr7YNvqSW7rzNNCw07NZePgr20CzpMOQfUySTOTJpnGgdIZnkpKW+IIagf4Z6BtKd2ic0pANXbv2bX7OSB6ia2/hOAAslKGNYkjCWRzeWRe2jI1vZRvyAVFLjHrE61qbglXc0A1cdpusbl97tv697FbbrgRIXjDqDH8omHJaBnaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(261028144727099003)(261026121527099003)(10067099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzV1TTRYTTNxUnlQaUN3N2NmNTRHYSsyNGYyUnpYbG14bjlhZitSRlNQajdu?=
 =?utf-8?B?aEUwTTRsNllDTC9Ha1Fmd3RVUk9vQmxXdTFTU1RxMTZiTjQ3ODd2S0ZxMWsr?=
 =?utf-8?B?eTFBb3RCaTRES2VYTFIxWk00K2RFTGJhNXpQK1czR1JtQzU5eXUrQ2llRE8w?=
 =?utf-8?B?aEZuWDhXc0VzR08yc09GL1JvbCt6YVh0eHhITkhpQnhpdG9waFM3Uk00Snlw?=
 =?utf-8?B?NlFqOGI2bVA5VmJ3UkdzTDltZkdqVHhPUDNjbFNsZm9nbFh5MFZkYnErelc4?=
 =?utf-8?B?QytQbFY0bFo5RytEUE5qdC9kUzBSWnl4T2JjajQxdUJZLzVad3ZpeEREUHZW?=
 =?utf-8?B?YUNZV3JlclBYTTBjUVdwZU5sVDlraDlMTHp6QytNejJZa3I2c2plT25NWWVB?=
 =?utf-8?B?ZTFvZk5qcEN1Q0RNNzlmQURmUE92YlV6ZzV2QTdaYWRabkJyY3BjQ0VPRjlK?=
 =?utf-8?B?VUo0ZEk1alRlL0xqZlVKQlZoZVM0WGFYdG45LzIrVGxKNk14QTk2WDJBZ3BX?=
 =?utf-8?B?dWR1YWtlcGpMZWlHcVVqRzBaRFdqN1d6bDBNc2VEWmszTjFIY3dnazVoTXlS?=
 =?utf-8?B?VS96WFo3SVI4Wm5OVzhqb1ZzRmd3bUMyaEdGcGFKTHNmWGhTZWJ6b0Vobko3?=
 =?utf-8?B?dWRqZTMrOGZKUWVrYlFnZnZGejZyMit5Zk8rS3NoNng0SjBEYkw0eDBDbEVU?=
 =?utf-8?B?Q0tuT2VEWnU4UEdvcXpyWFVKdkY5RzgvZzBsTXNuY1phdDR3bk1pdmpwcjB5?=
 =?utf-8?B?ekh6dDkwZFhPeWd0bkpnaDVjcXg4TFhGNkd4ZG5tbDRFTVFCZ2FtejcvOGNu?=
 =?utf-8?B?ZEZLbUJTSURDV29FSVpKQWswYm1qOEJrY29TRXdJWGJEZm9TVnVHR0lKMTdI?=
 =?utf-8?B?dldRYjRqOVU5SmZESkdINUFtYjR5QVUzbU0zVWovN1IrMU1nSzRiWnJ0dFJQ?=
 =?utf-8?B?dFFJaytIbEtjTFAxMjVCVkE4c1NnaWtwWHE1enBjL3BCajdla09kMm5Qc1dF?=
 =?utf-8?B?YUVOdHpmNldrSGtKOUxoci9yTHBXL0UrRjRxU0ZZQUszbnRkbWF6L2hkSVhN?=
 =?utf-8?B?M0ZHWTV3LzlvdG91aHdvUTNZZUd3NnZnbmFRMkl3ODg4RTNVamY3M1l5QmtR?=
 =?utf-8?B?RjA2M0ZhL3lCVlVScWczejU3NWE4ZFVaVWg0bCswYU1LZnpNcTJPWlNHb3ZF?=
 =?utf-8?B?aHBSWG56Q1FYVHFLS1JpRmh2SU0yaHJnS0M1QUMvdkx4S1ZYZ2pIWnJjVmhx?=
 =?utf-8?B?MFJQaHlVRjZvejlLS2ZEUnNwTlhBRmFzY0kwaUR3Qk1PVWRhVlNxQ3IrSjB2?=
 =?utf-8?B?RHFSUzczRXdDaThyNlJrVzkyTDFSclRmU3hkSGJ3Wkh0dXBnK0JEUzAzYkpn?=
 =?utf-8?B?bVVBQlpzbmVVU3RTQ0lPLzFZT2pQNThnaDlSVTVQQVBBV2dyT0FUSmc4SEJQ?=
 =?utf-8?B?aWg3VzNaK0RSaEJOMG1XUEg2ZGVjTkExMmE2bjBab0ZkMEM3N29iTHZIV3dK?=
 =?utf-8?B?ZlZlVGN6UHFOaXJjM1V3c0lUQnVwc2p1RXUxWGhYNWszZWwxZDdsNnJTNWZw?=
 =?utf-8?B?YkJ1czE5YnNHZU1uWXh5TFhxYzNUZ0hkRWdRbG1aWU9QTUVoVG1FWXExRTVX?=
 =?utf-8?B?S1Z3MlhIVWJCNWgxdFY1MWFIcE5MbitmL1dFVDl0dUlsWEh2RVppcFdUWnZY?=
 =?utf-8?B?WHNhMkVjZzFmeHVKMUQ0ZllnU1o5SkRBYi9TRjJ4UjNRRUJaUlBOczQyK3J6?=
 =?utf-8?B?Q0dxUm9aV0h2TUxnVVBRREM2U3AyTTY1VitkLzRUVFNUR09FckZDNEVYZzBm?=
 =?utf-8?B?dzVUVSs0QWtTVkVzZXl4ZHZXWWFreWJOZndTemVPS1gyVSt1aGdQcmtmMnJj?=
 =?utf-8?B?UTNhd3lWckE0WmlSbktrUTJ6TkJuKzJRUEIwRnVPM0hlZ2pGcFYyRzBBd0sr?=
 =?utf-8?B?b1pVZ1BXRXdMOFRxQkNpYXRQMHBiSWtYWjdCbmxyUkNUelFSaXl1WHkyb1pL?=
 =?utf-8?B?T2NrT21wWTBOdEdIbnhUTlRTSmdOTGs3OGpFUGZVcWNBMDhCKzNCRG1Fdlpt?=
 =?utf-8?B?eGEvck1KaFFSRFErUkNiUkNnam1IN1BBMXUwZmtpZzAyMVRUUE94LzE3Uzdx?=
 =?utf-8?B?em50OWd4UmNZUHl2VDZ1QVpEYjNzTTJhQmZBRFhldmVoeldJZ2Y5bzV1VFJh?=
 =?utf-8?B?QnhhaEFYQmw3MEdHcFVDZnZRWjFkU3o4OU02b3hubHJzVlFqR2tYQytZd3l1?=
 =?utf-8?B?VW9ySHVlZXBibWJVeTZkUStuQkZmUGRpbEJMK3pQbmYrMkdNdS9iRThHRTNG?=
 =?utf-8?B?UFE4dGNKakhVeHYwc3U5NlZNM1hQczkxbFF4WUpEWUg0bjI4eFpxQkdJN2Y0?=
 =?utf-8?Q?QTHFITKnhybY15bwjf97mPAo+uefYVKfaD17R?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc89d6c5-c5e2-4410-8d08-08df473e2952
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:40:41.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbBOfltaicZmxRiS6PDwQ02lac5zAT1D1X/y6cKS3en1sRnj6DtmSwpOsd/CQZrCFzQHCQ2DDwdHfW+fNg49cjSQ1VlP+gNIcxpB4/eBN5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT8PR01MB067206

> Can gating the new period on dl_task_pi_blocked() in switched_to_dl() and
> dl_boost_blocked() still leave a sleeping task with an uninitialized or
> stale p->dl.deadline?

Your first case: yes. v10 will fix it in a new patch, "sched/deadline:
Start a period for a task requeued onto an rt_mutex". 
task_blocks_on_rt_mutex() will start a new period for a proxy-locked
task whose deadline is 0 or has passed. The waiter then takes the new
deadline. A new case, requeue_pi_new_period, will test the deadline of
0. It fails without the fix. 

Your second case: yes. v10 will compare the waiter with the deadline
that the owner would run on. "sched/deadline: Boost an owner that cannot
run on its own reservation" will do that. A deadline that has passed, 0
included, then counts as now + dl_deadline.

Your third case is how a boost works. A new donor does not give the
owner its deadline. It changes the parameters of the owner's next
refills. A queued owner keeps its deadline the same way.

> Does checking !dl_se->dl_deadline in dl_boost_blocked() miss a task that
> left SCHED_DEADLINE before its 0-lag time?

Yes, by reading. v7.4-rc2 sorts a deadline waiter blocked past its
deadline the same way. A new period at the boost would fix only that
moment: the deadline of any waiter can pass while it stays blocked.
v10 will leave this out, and list it as a known limit in its cover
letter.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
